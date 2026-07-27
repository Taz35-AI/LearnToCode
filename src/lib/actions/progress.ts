'use server';

import { revalidatePath } from 'next/cache';
import { createClient, getCurrentUser } from '@/lib/supabase/server';
import { getExerciseForGrading, getQuestionForGrading, getAchievements, getRoadmap, getSkills } from '@/lib/data/catalogue';
import { evaluateSubmission } from '@/lib/evaluator/evaluate';
import { requirementFromRow } from '@/lib/evaluator/types';
import { isMastered, type EvidenceKind } from '@/lib/progress/mastery';
import { assessmentXp, exerciseXp, lessonXp, quizXp, streakXp, type XpAward } from '@/lib/progress/xp';
import { computeStreak, isoDate } from '@/lib/progress/pace';
import { newlyUnlocked, type AchievementSnapshot } from '@/lib/progress/achievements';
import { isSubstantialPage } from '@/lib/project/checklist';
import { recordMasteryEvidence } from '@/lib/data/mastery';
import {
  answerQuestionSchema,
  completeLessonSchema,
  evaluateSchema,
  fieldErrors,
  saveCodeSchema,
  submitAssessmentSchema,
  type ActionResult,
} from './schemas';
import type { EvaluationResult } from '@/lib/evaluator/types';
import type { Json, XpSource } from '@/lib/supabase/database.types';

/**
 * Progress actions.
 *
 * Every XP award, mastery update and achievement unlock happens here, on the
 * server, from data the client cannot forge:
 *
 *   · Grading uses the reference criteria loaded from the database, never
 *     anything posted by the browser.
 *   · XP is written through `awardXp`, which relies on the UNIQUE constraint
 *     on (user_id, source_type, source_id) — so a replayed request cannot pay
 *     out twice even if it reaches the database.
 *   · Mastery is recomputed from the graded result, not from a client claim.
 */

async function requireUser() {
  const user = await getCurrentUser();
  if (!user) throw new Error('Not signed in');
  return user;
}

/**
 * Writes an XP transaction. Returns the amount actually awarded — zero when the
 * database rejected it as a duplicate, which is the guarantee that resubmitting
 * a solved exercise never pays again.
 */
async function awardXp(userId: string, award: XpAward | null): Promise<number> {
  if (!award) return 0;
  const supabase = await createClient();
  const { error } = await supabase.from('xp_transactions').insert({
    user_id: userId,
    amount: award.amount,
    source_type: award.sourceType,
    source_id: award.sourceId,
    reason: award.reason,
  });
  // 23505 is unique_violation: this source has already paid out.
  if (error) return 0;
  return award.amount;
}

/** Records that the learner studied today, and rolls up the day's activity. */
async function recordStudyActivity(
  userId: string,
  delta: { seconds?: number; lessons?: number; exercises?: number; xp?: number },
): Promise<void> {
  const supabase = await createClient();
  const today = isoDate(new Date());

  const { data: existing } = await supabase
    .from('study_sessions')
    .select('*')
    .eq('user_id', userId)
    .eq('study_date', today)
    .maybeSingle();

  if (existing) {
    await supabase
      .from('study_sessions')
      .update({
        seconds: existing.seconds + (delta.seconds ?? 0),
        lessons_completed: existing.lessons_completed + (delta.lessons ?? 0),
        exercises_passed: existing.exercises_passed + (delta.exercises ?? 0),
        xp_earned: existing.xp_earned + (delta.xp ?? 0),
      })
      .eq('id', existing.id);
    return;
  }

  await supabase.from('study_sessions').insert({
    user_id: userId,
    study_date: today,
    seconds: delta.seconds ?? 0,
    lessons_completed: delta.lessons ?? 0,
    exercises_passed: delta.exercises ?? 0,
    xp_earned: delta.xp ?? 0,
  });
}

/**
 * Records evidence against a skill.
 *
 * Thin wrapper over the shared server-only writer, which the review actions
 * use too. Keeping the implementation out of this `'use server'` module means
 * it never becomes a client-callable endpoint.
 */
const updateMastery = recordMasteryEvidence;

/**
 * Re-evaluates every achievement and unlocks whatever the learner has earned.
 * Idempotent: `user_achievements` has a UNIQUE constraint, and the XP that
 * accompanies an unlock is keyed on the achievement id.
 */
async function syncAchievements(userId: string): Promise<string[]> {
  const supabase = await createClient();
  const [definitions, roadmap, skills] = await Promise.all([
    getAchievements(),
    getRoadmap(),
    getSkills(),
  ]);

  const [
    { data: progress },
    { data: attempts },
    { data: mastery },
    { data: unlocked },
    { data: xp },
    { data: sessions },
    { data: project },
  ] = await Promise.all([
    supabase.from('user_lesson_progress').select('lesson_id, status').eq('user_id', userId),
    supabase
      .from('exercise_attempts')
      .select('exercise_id, passed, hints_used, created_at')
      .eq('user_id', userId)
      .order('created_at'),
    supabase.from('user_skill_mastery').select('skill_id, mastery, evidence_count').eq('user_id', userId),
    supabase.from('user_achievements').select('achievement_id').eq('user_id', userId),
    supabase.from('xp_transactions').select('amount').eq('user_id', userId),
    supabase.from('study_sessions').select('study_date').eq('user_id', userId),
    supabase.from('user_projects').select('id, status, completion_percent').eq('user_id', userId).maybeSingle(),
  ]);

  const completedLessonIds = new Set(
    (progress ?? []).filter((p) => p.status === 'completed').map((p) => p.lesson_id),
  );

  const completedModuleSlugs = new Set<string>();
  const completedLevelSlugs = new Set<string>();
  let totalLessons = 0;
  for (const level of roadmap) {
    let levelComplete = level.modules.length > 0;
    for (const mod of level.modules) {
      totalLessons += mod.lessons.length;
      const done =
        mod.lessons.length > 0 && mod.lessons.every((l) => completedLessonIds.has(l.id));
      if (done) completedModuleSlugs.add(mod.slug);
      else levelComplete = false;
    }
    if (levelComplete) completedLevelSlugs.add(level.slug);
  }

  const skillSlugById = new Map(skills.map((s) => [s.id, s.slug]));
  const masteredSkillSlugs = new Set(
    (mastery ?? [])
      .filter((m) => isMastered({ mastery: Number(m.mastery), evidenceCount: m.evidence_count }))
      .map((m) => skillSlugById.get(m.skill_id) ?? '')
      .filter(Boolean),
  );

  // Longest current run of exercises passed first time with no hints.
  const byExercise = new Map<string, { attempts: number; passedFirst: boolean; hints: number }>();
  for (const attempt of attempts ?? []) {
    const record = byExercise.get(attempt.exercise_id) ?? { attempts: 0, passedFirst: false, hints: 0 };
    record.attempts += 1;
    if (attempt.passed && record.attempts === 1 && attempt.hints_used === 0) record.passedFirst = true;
    byExercise.set(attempt.exercise_id, record);
  }
  let firstPassStreak = 0;
  let bestFirstPassStreak = 0;
  for (const attempt of attempts ?? []) {
    if (!attempt.passed) continue;
    const record = byExercise.get(attempt.exercise_id);
    if (record?.passedFirst) {
      firstPassStreak += 1;
      bestFirstPassStreak = Math.max(bestFirstPassStreak, firstPassStreak);
    } else {
      firstPassStreak = 0;
    }
  }

  const passedExerciseIds = new Set(
    (attempts ?? []).filter((a) => a.passed).map((a) => a.exercise_id),
  );

  const { data: debugExercises } = await supabase
    .from('exercises')
    .select('id')
    .eq('kind', 'debug');
  const debugPassed = (debugExercises ?? []).filter((e) => passedExerciseIds.has(e.id)).length;

  const projectFiles = project
    ? await supabase
        .from('project_files')
        .select('path, content')
        .eq('project_id', project.id)
    : { data: [] };

  const totalXp = (xp ?? []).reduce((sum, row) => sum + row.amount, 0);
  const streak = computeStreak((sessions ?? []).map((s) => s.study_date));

  const snapshot: AchievementSnapshot = {
    lessonsCompleted: completedLessonIds.size,
    exercisesPassed: passedExerciseIds.size,
    debugChallengesPassed: debugPassed,
    currentFirstPassStreak: bestFirstPassStreak,
    completedLevelSlugs,
    completedModuleSlugs,
    masteredSkillSlugs,
    streakDays: streak.current,
    // Pages the learner has actually written, not the stubs onboarding seeded.
    projectPageCount: (projectFiles.data ?? []).filter(
      (f) => f.path.endsWith('.html') && isSubstantialPage(f.content),
    ).length,
    projectComplete: project?.status === 'complete',
    courseComplete: totalLessons > 0 && completedLessonIds.size >= totalLessons,
    totalXp,
  };

  const alreadyUnlocked = new Set((unlocked ?? []).map((u) => u.achievement_id));
  const earned = newlyUnlocked(
    definitions.map((d) => ({
      id: d.id,
      slug: d.slug,
      name: d.name,
      criteria: d.criteria,
      xpAward: d.xp_award,
    })),
    snapshot,
    alreadyUnlocked,
  );

  const names: string[] = [];
  for (const achievement of earned) {
    const { error } = await supabase
      .from('user_achievements')
      .insert({ user_id: userId, achievement_id: achievement.id });
    if (!error) {
      await awardXp(userId, {
        amount: achievement.xpAward,
        sourceType: 'achievement' as XpSource,
        sourceId: achievement.id,
        reason: `Achievement unlocked: ${achievement.name}`,
      });
      names.push(achievement.name);
    }
  }

  // Streak milestones, awarded once each.
  const { data: streakAwards } = await supabase
    .from('xp_transactions')
    .select('source_id')
    .eq('user_id', userId)
    .eq('source_type', 'streak');
  const awardedMilestones = new Set(
    (streakAwards ?? []).map((s) => Number(s.source_id.replace('streak-', ''))),
  );
  await awardXp(userId, streakXp(streak.current, awardedMilestones));

  return names;
}

// ---------------------------------------------------------------------------
// Public actions
// ---------------------------------------------------------------------------

export interface EvaluationOutcome {
  result: EvaluationResult;
  xpAwarded: number;
  achievementsUnlocked: string[];
  /** Included only once the learner has passed. */
  referenceSolution: string | null;
}

export async function evaluateExerciseAction(
  input: unknown,
): Promise<ActionResult<EvaluationOutcome>> {
  const parsed = evaluateSchema.safeParse(input);
  if (!parsed.success) {
    return { ok: false, errors: fieldErrors(parsed.error), message: 'That submission was not valid.' };
  }

  const user = await requireUser();
  const supabase = await createClient();

  const loaded = await getExerciseForGrading(parsed.data.exerciseId);
  if (!loaded) return { ok: false, message: 'That exercise no longer exists.' };

  const { exercise, requirements } = loaded;

  // Grading uses the criteria from the database — nothing the client sent.
  const result = evaluateSubmission(parsed.data.code, requirements.map(requirementFromRow));

  const { data: priorAttempts } = await supabase
    .from('exercise_attempts')
    .select('id, passed')
    .eq('user_id', user.id)
    .eq('exercise_id', exercise.id);

  const priorFailures = (priorAttempts ?? []).filter((a) => !a.passed).length;
  const alreadyPassed = (priorAttempts ?? []).some((a) => a.passed);

  await supabase.from('exercise_attempts').insert({
    user_id: user.id,
    exercise_id: exercise.id,
    submitted_code: parsed.data.code,
    passed: result.passed,
    score: result.score,
    // Stored as jsonb: round-trip through JSON so the column receives plain
    // data rather than a class-shaped object.
    results: JSON.parse(JSON.stringify(result.results)) as Json,
    hints_used: parsed.data.hintsUsed,
    duration_seconds: parsed.data.durationSeconds,
  });

  // Keep the learner's working copy in step with what they submitted.
  await supabase.from('saved_code').upsert(
    {
      user_id: user.id,
      exercise_id: exercise.id,
      code: parsed.data.code,
      hints_used: parsed.data.hintsUsed,
    },
    { onConflict: 'user_id,exercise_id' },
  );

  let xpAwarded = 0;
  let achievements: string[] = [];

  if (result.passed) {
    xpAwarded = await awardXp(
      user.id,
      exerciseXp({
        exerciseId: exercise.id,
        baseXp: exercise.xp_award,
        hintsUsed: parsed.data.hintsUsed,
        priorAttempts: priorFailures,
        alreadyAwarded: alreadyPassed,
        isOptional: exercise.is_optional,
      }),
    );

    const evidenceKind: EvidenceKind =
      exercise.kind === 'debug'
        ? 'debug'
        : exercise.kind === 'project_mission'
          ? 'project'
          : 'exercise';

    await updateMastery(
      user.id,
      exercise.skill_id,
      evidenceKind,
      result.score,
      parsed.data.hintsUsed,
      priorFailures,
    );

    await recordStudyActivity(user.id, {
      seconds: parsed.data.durationSeconds,
      exercises: alreadyPassed ? 0 : 1,
      xp: xpAwarded,
    });

    achievements = await syncAchievements(user.id);
  } else {
    // A failed attempt is still evidence — it lowers mastery, which is what
    // puts a struggling skill into the adaptive practice queue.
    await updateMastery(
      user.id,
      exercise.skill_id,
      'exercise',
      result.score * 0.5,
      parsed.data.hintsUsed,
      priorFailures,
    );
    await recordStudyActivity(user.id, { seconds: parsed.data.durationSeconds });
  }

  revalidatePath('/dashboard');

  return {
    ok: true,
    data: {
      result,
      xpAwarded,
      achievementsUnlocked: achievements,
      referenceSolution: result.passed || alreadyPassed ? exercise.reference_solution : null,
    },
  };
}

export async function saveCodeAction(input: unknown): Promise<ActionResult> {
  const parsed = saveCodeSchema.safeParse(input);
  if (!parsed.success) return { ok: false, errors: fieldErrors(parsed.error) };

  const user = await requireUser();
  const supabase = await createClient();

  const { error } = await supabase.from('saved_code').upsert(
    {
      user_id: user.id,
      exercise_id: parsed.data.exerciseId,
      code: parsed.data.code,
      hints_used: parsed.data.hintsUsed,
    },
    { onConflict: 'user_id,exercise_id' },
  );

  return error ? { ok: false, message: 'We could not save your work just now.' } : { ok: true };
}

export interface QuizOutcome {
  isCorrect: boolean;
  correctOptionIds: string[];
  explanation: string;
  xpAwarded: number;
}

export async function answerQuestionAction(input: unknown): Promise<ActionResult<QuizOutcome>> {
  const parsed = answerQuestionSchema.safeParse(input);
  if (!parsed.success) return { ok: false, errors: fieldErrors(parsed.error) };

  const user = await requireUser();
  const supabase = await createClient();

  const loaded = await getQuestionForGrading(parsed.data.questionId);
  if (!loaded) return { ok: false, message: 'That question no longer exists.' };

  const { question, options } = loaded;
  const correctIds = options.filter((o) => o.is_correct).map((o) => o.id);
  const selected = new Set(parsed.data.optionIds);

  const isCorrect =
    correctIds.length === selected.size && correctIds.every((id) => selected.has(id));

  const { data: priorAnswers } = await supabase
    .from('quiz_attempts')
    .select('id, is_correct')
    .eq('user_id', user.id)
    .eq('question_id', question.id);

  const isFirstAttempt = (priorAnswers ?? []).length === 0;
  const alreadyCorrect = (priorAnswers ?? []).some((a) => a.is_correct);

  // Confidence is recorded here as well as in review, so calibration is
  // measured on first contact with an idea and not only on material the learner
  // has already met twice. First contact is exactly where the illusion of
  // knowing bites hardest, so measuring only review would sample the wrong end.
  await supabase.from('quiz_attempts').insert({
    user_id: user.id,
    question_id: question.id,
    selected_option_ids: parsed.data.optionIds,
    is_correct: isCorrect,
    confidence: parsed.data.confidence ?? null,
  });

  const xpAwarded = await awardXp(
    user.id,
    quizXp({
      questionId: question.id,
      baseXp: question.xp_award,
      isCorrect,
      isFirstAttempt,
      alreadyAwarded: alreadyCorrect,
    }),
  );

  await updateMastery(user.id, question.skill_id, 'quiz', isCorrect ? 1 : 0);
  if (xpAwarded > 0) await recordStudyActivity(user.id, { xp: xpAwarded });

  return {
    ok: true,
    data: { isCorrect, correctOptionIds: correctIds, explanation: question.explanation, xpAwarded },
  };
}

export interface LessonCompletionOutcome {
  xpAwarded: number;
  achievementsUnlocked: string[];
}

export async function completeLessonAction(
  input: unknown,
): Promise<ActionResult<LessonCompletionOutcome>> {
  const parsed = completeLessonSchema.safeParse(input);
  if (!parsed.success) return { ok: false, errors: fieldErrors(parsed.error) };

  const user = await requireUser();
  const supabase = await createClient();

  const { data: lesson } = await supabase
    .from('lessons')
    .select('id, xp_award, mastery_threshold, primary_skill_id')
    .eq('id', parsed.data.lessonId)
    .maybeSingle();
  if (!lesson) return { ok: false, message: 'That lesson no longer exists.' };

  // A lesson counts as complete only when its required exercises are passed.
  const { data: exercises } = await supabase
    .from('exercises')
    .select('id, is_optional')
    .eq('lesson_id', lesson.id);
  const required = (exercises ?? []).filter((e) => !e.is_optional).map((e) => e.id);

  const { data: passed } = required.length
    ? await supabase
        .from('exercise_attempts')
        .select('exercise_id')
        .eq('user_id', user.id)
        .eq('passed', true)
        .in('exercise_id', required)
    : { data: [] };

  const passedIds = new Set((passed ?? []).map((p) => p.exercise_id));
  const outstanding = required.filter((id) => !passedIds.has(id));

  if (outstanding.length > 0) {
    return {
      ok: false,
      message: `Finish the ${outstanding.length === 1 ? 'remaining exercise' : `${outstanding.length} remaining exercises`} to complete this lesson.`,
    };
  }

  const { data: existing } = await supabase
    .from('user_lesson_progress')
    .select('*')
    .eq('user_id', user.id)
    .eq('lesson_id', lesson.id)
    .maybeSingle();

  const alreadyComplete = existing?.status === 'completed';
  const now = new Date().toISOString();

  if (existing) {
    await supabase
      .from('user_lesson_progress')
      .update({
        status: 'completed',
        completed_at: existing.completed_at ?? now,
        time_spent_seconds: existing.time_spent_seconds + parsed.data.secondsSpent,
        visits: existing.visits + 1,
      })
      .eq('id', existing.id);
  } else {
    await supabase.from('user_lesson_progress').insert({
      user_id: user.id,
      lesson_id: lesson.id,
      status: 'completed',
      started_at: now,
      completed_at: now,
      time_spent_seconds: parsed.data.secondsSpent,
      visits: 1,
    });
  }

  const xpAwarded = await awardXp(
    user.id,
    lessonXp({ lessonId: lesson.id, baseXp: lesson.xp_award, alreadyAwarded: alreadyComplete }),
  );

  await recordStudyActivity(user.id, {
    seconds: parsed.data.secondsSpent,
    lessons: alreadyComplete ? 0 : 1,
    xp: xpAwarded,
  });

  const achievements = await syncAchievements(user.id);

  revalidatePath('/dashboard');
  revalidatePath('/roadmap');

  return { ok: true, data: { xpAwarded, achievementsUnlocked: achievements } };
}

/** Marks a lesson as started, so the dashboard can show it as in progress. */
export async function startLessonAction(lessonId: string): Promise<ActionResult> {
  const user = await getCurrentUser();
  if (!user) return { ok: false };

  const supabase = await createClient();
  const { data: existing } = await supabase
    .from('user_lesson_progress')
    .select('id, status, visits')
    .eq('user_id', user.id)
    .eq('lesson_id', lessonId)
    .maybeSingle();

  if (existing) {
    if (existing.status === 'not_started') {
      await supabase
        .from('user_lesson_progress')
        .update({ status: 'in_progress', started_at: new Date().toISOString(), visits: existing.visits + 1 })
        .eq('id', existing.id);
    }
    return { ok: true };
  }

  await supabase.from('user_lesson_progress').insert({
    user_id: user.id,
    lesson_id: lessonId,
    status: 'in_progress',
    started_at: new Date().toISOString(),
    visits: 1,
  });

  return { ok: true };
}

export interface AssessmentOutcome {
  score: number;
  passed: boolean;
  correctCount: number;
  total: number;
  xpAwarded: number;
  perQuestion: { questionId: string; correct: boolean; explanation: string; correctOptionIds: string[] }[];
}

export async function submitAssessmentAction(
  input: unknown,
): Promise<ActionResult<AssessmentOutcome>> {
  const parsed = submitAssessmentSchema.safeParse(input);
  if (!parsed.success) return { ok: false, errors: fieldErrors(parsed.error) };

  const user = await requireUser();
  const supabase = await createClient();

  const { data: assessment } = await supabase
    .from('assessments')
    .select('*')
    .eq('id', parsed.data.assessmentId)
    .maybeSingle();
  if (!assessment) return { ok: false, message: 'That assessment no longer exists.' };

  const { data: questions } = await supabase
    .from('quiz_questions')
    .select('id, explanation, skill_id')
    .eq('assessment_id', assessment.id);

  const questionIds = (questions ?? []).map((q) => q.id);
  const { data: options } = questionIds.length
    ? await supabase.from('quiz_options').select('*').in('question_id', questionIds)
    : { data: [] };

  const perQuestion: AssessmentOutcome['perQuestion'] = [];
  let correctCount = 0;

  for (const question of questions ?? []) {
    const correctIds = (options ?? [])
      .filter((o) => o.question_id === question.id && o.is_correct)
      .map((o) => o.id);
    const answer = parsed.data.answers.find((a) => a.questionId === question.id);
    const selected = new Set(answer?.optionIds ?? []);
    const correct = correctIds.length === selected.size && correctIds.every((id) => selected.has(id));

    if (correct) correctCount += 1;
    perQuestion.push({
      questionId: question.id,
      correct,
      explanation: question.explanation,
      correctOptionIds: correctIds,
    });

    await updateMastery(user.id, question.skill_id, 'assessment', correct ? 1 : 0);
  }

  const total = (questions ?? []).length;
  const score = total === 0 ? 0 : Math.round((correctCount / total) * 1000) / 1000;
  const passed = score >= Number(assessment.pass_score);

  await supabase.from('assessment_attempts').insert({
    user_id: user.id,
    assessment_id: assessment.id,
    score,
    passed,
    detail: { correctCount, total },
  });

  const xpAwarded = await awardXp(
    user.id,
    assessmentXp({
      assessmentId: assessment.id,
      baseXp: assessment.xp_award,
      score,
      passed,
      alreadyAwarded: false,
    }),
  );

  if (xpAwarded > 0) await recordStudyActivity(user.id, { xp: xpAwarded });
  await syncAchievements(user.id);

  revalidatePath('/dashboard');

  return { ok: true, data: { score, passed, correctCount, total, xpAwarded, perQuestion } };
}
