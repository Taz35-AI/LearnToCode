import 'server-only';

import { cache } from 'react';
import { createClient } from '@/lib/supabase/server';
import { getLessonOrder, getModuleGates, getRoadmap, getSkills } from './catalogue';
import { evaluateModuleGate, isMastered, recommendPractice } from '@/lib/progress/mastery';
import { buildPaceReport, computeStreak, recommendPace } from '@/lib/progress/pace';
import { learnerLevel } from '@/lib/progress/xp';
import { totalCourseMinutes } from '@/content/course';
import type {
  ExerciseAttemptRow,
  LearningPlanRow,
  ProfileRow,
  UserAchievementRow,
  UserLessonProgressRow,
  UserProjectRow,
  UserSkillMasteryRow,
} from '@/lib/supabase/database.types';

/**
 * Everything the signed-in learner's own dashboard needs.
 *
 * All reads go through the request-scoped client, so Row Level Security
 * guarantees a learner can only ever load their own rows — the queries below
 * do not even need a `where user_id = …` clause to be safe, though several
 * include one anyway for clarity and index use.
 */

export const getProfile = cache(async (userId: string): Promise<ProfileRow | null> => {
  const supabase = await createClient();
  const { data } = await supabase.from('profiles').select('*').eq('id', userId).maybeSingle();
  return data;
});

export const getLearningPlan = cache(async (userId: string): Promise<LearningPlanRow | null> => {
  const supabase = await createClient();
  const { data } = await supabase
    .from('learning_plans')
    .select('*')
    .eq('user_id', userId)
    .eq('is_active', true)
    .maybeSingle();
  return data;
});

export const getLessonProgress = cache(async (userId: string): Promise<UserLessonProgressRow[]> => {
  const supabase = await createClient();
  const { data } = await supabase.from('user_lesson_progress').select('*').eq('user_id', userId);
  return data ?? [];
});

export const getSkillMastery = cache(async (userId: string): Promise<UserSkillMasteryRow[]> => {
  const supabase = await createClient();
  const { data } = await supabase.from('user_skill_mastery').select('*').eq('user_id', userId);
  return data ?? [];
});

export const getPassedExerciseIds = cache(async (userId: string): Promise<string[]> => {
  const supabase = await createClient();
  const { data } = await supabase
    .from('exercise_attempts')
    .select('exercise_id')
    .eq('user_id', userId)
    .eq('passed', true);
  return [...new Set((data ?? []).map((row) => row.exercise_id))];
});

export const getSavedCode = cache(
  async (userId: string, exerciseIds: string[]): Promise<Record<string, { code: string; hintsUsed: number }>> => {
    if (exerciseIds.length === 0) return {};
    const supabase = await createClient();
    const { data } = await supabase
      .from('saved_code')
      .select('exercise_id, code, hints_used')
      .eq('user_id', userId)
      .in('exercise_id', exerciseIds);

    const map: Record<string, { code: string; hintsUsed: number }> = {};
    for (const row of data ?? []) {
      map[row.exercise_id] = { code: row.code, hintsUsed: row.hints_used };
    }
    return map;
  },
);

export const getQuizAnswers = cache(
  async (userId: string, questionIds: string[]) => {
    if (questionIds.length === 0) return {};
    const supabase = await createClient();
    const { data } = await supabase
      .from('quiz_attempts')
      .select('question_id, selected_option_ids, is_correct, answered_at')
      .eq('user_id', userId)
      .in('question_id', questionIds)
      .order('answered_at', { ascending: false });

    const map: Record<string, { selected: string[]; isCorrect: boolean }> = {};
    for (const row of data ?? []) {
      if (!map[row.question_id]) {
        map[row.question_id] = { selected: row.selected_option_ids, isCorrect: row.is_correct };
      }
    }
    return map;
  },
);

export const getTotalXp = cache(async (userId: string): Promise<number> => {
  const supabase = await createClient();
  const { data } = await supabase.from('xp_transactions').select('amount').eq('user_id', userId);
  return (data ?? []).reduce((sum, row) => sum + row.amount, 0);
});

export const getStudyDates = cache(async (userId: string): Promise<string[]> => {
  const supabase = await createClient();
  const { data } = await supabase
    .from('study_sessions')
    .select('study_date')
    .eq('user_id', userId)
    .order('study_date');
  return (data ?? []).map((row) => row.study_date);
});

export const getUserAchievements = cache(async (userId: string): Promise<UserAchievementRow[]> => {
  const supabase = await createClient();
  const { data } = await supabase
    .from('user_achievements')
    .select('*')
    .eq('user_id', userId)
    .order('unlocked_at', { ascending: false });
  return data ?? [];
});

export const getActiveProject = cache(async (userId: string): Promise<UserProjectRow | null> => {
  const supabase = await createClient();
  const { data } = await supabase
    .from('user_projects')
    .select('*')
    .eq('user_id', userId)
    .order('created_at', { ascending: false })
    .limit(1)
    .maybeSingle();
  return data;
});

export const getProjectFiles = cache(async (projectId: string) => {
  const supabase = await createClient();
  const { data } = await supabase
    .from('project_files')
    .select('*')
    .eq('project_id', projectId)
    .order('path');
  return data ?? [];
});

export const getRecentAttempts = cache(
  async (userId: string, limit = 12): Promise<ExerciseAttemptRow[]> => {
    const supabase = await createClient();
    const { data } = await supabase
      .from('exercise_attempts')
      .select('*')
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .limit(limit);
    return data ?? [];
  },
);

// ---------------------------------------------------------------------------
// The composed dashboard view
// ---------------------------------------------------------------------------

export interface DashboardData {
  profile: ProfileRow | null;
  plan: LearningPlanRow | null;
  totalXp: number;
  level: ReturnType<typeof learnerLevel>;
  streak: ReturnType<typeof computeStreak>;
  pace: ReturnType<typeof buildPaceReport>;
  lessonsCompleted: number;
  totalLessons: number;
  skillsMastered: number;
  skillsNeedingPractice: number;
  practiceQueue: ReturnType<typeof recommendPractice>;
  nextLesson: { slug: string; title: string; moduleTitle: string; levelTitle: string } | null;
  unlockedModuleIds: Set<string>;
  moduleCompletion: Map<string, { completed: number; total: number }>;
  achievementsUnlocked: number;
  project: UserProjectRow | null;
  projectFileCount: number;
  studySeconds: number;
}

/**
 * Assembles the dashboard in one place so the page component stays declarative.
 *
 * Everything here is derived from real learner records — completions, attempts,
 * mastery scores and the dates on which study actually happened. No number on
 * the dashboard comes from a fixed calendar.
 */
export async function getDashboardData(userId: string): Promise<DashboardData> {
  const supabase = await createClient();

  const [
    profile,
    plan,
    progress,
    mastery,
    totalXp,
    studyDates,
    achievements,
    project,
    skills,
    roadmap,
    gates,
    lessonOrder,
  ] = await Promise.all([
    getProfile(userId),
    getLearningPlan(userId),
    getLessonProgress(userId),
    getSkillMastery(userId),
    getTotalXp(userId),
    getStudyDates(userId),
    getUserAchievements(userId),
    getActiveProject(userId),
    getSkills(),
    getRoadmap(),
    getModuleGates(),
    getLessonOrder(),
  ]);

  const { data: sessions } = await supabase
    .from('study_sessions')
    .select('seconds')
    .eq('user_id', userId);
  const studySeconds = (sessions ?? []).reduce((sum, s) => sum + s.seconds, 0);

  const completedLessonIds = new Set(
    progress.filter((p) => p.status === 'completed').map((p) => p.lesson_id),
  );

  // Module completion, and therefore which modules are unlocked.
  const moduleCompletion = new Map<string, { completed: number; total: number }>();
  for (const level of roadmap) {
    for (const mod of level.modules) {
      const total = mod.lessons.length;
      const completed = mod.lessons.filter((l) => completedLessonIds.has(l.id)).length;
      moduleCompletion.set(mod.id, { completed, total });
    }
  }

  const completedModuleIds = new Set(
    [...moduleCompletion.entries()]
      .filter(([, counts]) => counts.total > 0 && counts.completed === counts.total)
      .map(([id]) => id),
  );

  const masteryBySkill = new Map(mastery.map((m) => [m.skill_id, Number(m.mastery)]));
  const skillNames = new Map(skills.map((s) => [s.id, s.name]));
  const moduleNames = new Map(
    roadmap.flatMap((level) => level.modules.map((m) => [m.id, m.title] as const)),
  );

  const unlockedModuleIds = new Set<string>();
  for (const gate of gates) {
    const verdict = evaluateModuleGate(
      {
        moduleId: gate.moduleId,
        prerequisiteModuleIds: gate.prerequisiteModuleIds,
        requiredSkills: gate.requiredSkills,
      },
      { completedModuleIds, masteryBySkill },
      skillNames,
      moduleNames,
    );
    if (verdict.unlocked) unlockedModuleIds.add(gate.moduleId);
  }

  // The next recommended lesson: the first incomplete lesson in an unlocked module.
  let nextLesson: DashboardData['nextLesson'] = null;
  outer: for (const level of roadmap) {
    for (const mod of level.modules) {
      if (!unlockedModuleIds.has(mod.id)) continue;
      for (const lesson of mod.lessons) {
        if (!completedLessonIds.has(lesson.id)) {
          nextLesson = {
            slug: lesson.slug,
            title: lesson.title,
            moduleTitle: mod.title,
            levelTitle: level.title,
          };
          break outer;
        }
      }
    }
  }

  const now = new Date();
  const masteredCount = mastery.filter((m) =>
    isMastered({ mastery: Number(m.mastery), evidenceCount: m.evidence_count }),
  ).length;

  const recommended = recommendPace(
    {
      minutesPerDay: plan?.minutes_per_day ?? 60,
      studyDays: plan?.study_days ?? [1, 2, 3, 4, 5],
      totalCourseMinutes: totalCourseMinutes(),
      targetCompletionDate: plan?.target_completion_date
        ? new Date(plan.target_completion_date)
        : null,
    },
    lessonOrder.length,
  );

  const completedLessons = progress.filter((p) => p.status === 'completed');
  const pace = buildPaceReport(
    {
      lessonsCompleted: completedLessons.length,
      totalLessons: lessonOrder.length,
      remainingMinutes: 0,
      studyDates,
      startedOn: plan?.started_on ? new Date(plan.started_on) : now,
      totalStudySeconds: studySeconds,
    },
    recommended,
    now,
  );

  const practiceQueue = recommendPractice(
    mastery.map((m) => ({
      skillId: m.skill_id,
      skillName: skillNames.get(m.skill_id) ?? 'Skill',
      mastery: Number(m.mastery),
      evidenceCount: m.evidence_count,
      daysSincePractice: m.last_practised_at
        ? Math.floor((now.getTime() - new Date(m.last_practised_at).getTime()) / 86_400_000)
        : 999,
    })),
  );

  const projectFileCount = project ? (await getProjectFiles(project.id)).length : 0;

  return {
    profile,
    plan,
    totalXp,
    level: learnerLevel(totalXp),
    streak: computeStreak(studyDates, now),
    pace,
    lessonsCompleted: completedLessons.length,
    totalLessons: lessonOrder.length,
    skillsMastered: masteredCount,
    skillsNeedingPractice: mastery.filter((m) => m.needs_practice).length,
    practiceQueue,
    nextLesson,
    unlockedModuleIds,
    moduleCompletion,
    achievementsUnlocked: achievements.length,
    project,
    projectFileCount,
    studySeconds,
  };
}
