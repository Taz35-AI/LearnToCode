import 'server-only';

import { cache } from 'react';
import { createClient } from '@/lib/supabase/server';
import type {
  AchievementRow,
  AssessmentRow,
  ExerciseRequirementRow,
  ExerciseRow,
  LearningMediaRow,
  LessonBlockRow,
  LessonRow,
  LevelRow,
  MediaAttributionRow,
  ModuleRow,
  ProjectTemplateRow,
  QuizOptionRow,
  QuizQuestionRow,
  SkillRow,
} from '@/lib/supabase/database.types';

/**
 * Read-only access to the course catalogue.
 *
 * Two rules run through this file:
 *
 *   1. Answer keys never leave the server. `quiz_options.is_correct` and
 *      `exercises.reference_solution` are stripped by the `*ForLearner`
 *      functions, which are the only ones a page component may use.
 *
 *   2. Every function is wrapped in React's `cache`, so a page that needs the
 *      same lesson in three places issues one query, not three.
 */

export const COURSE_SLUG = 'html-hero';

export const getCourse = cache(async () => {
  const supabase = await createClient();
  const { data } = await supabase
    .from('courses')
    .select('*')
    .eq('slug', COURSE_SLUG)
    .maybeSingle();
  return data;
});

export interface LevelWithModules extends LevelRow {
  modules: (ModuleRow & { lessons: LessonRow[]; skillIds: string[]; prerequisiteIds: string[] })[];
}

/** The whole roadmap: levels → modules → lessons, plus the gating graph. */
export const getRoadmap = cache(async (): Promise<LevelWithModules[]> => {
  const supabase = await createClient();
  const course = await getCourse();
  if (!course) return [];

  const [levelsResult, modulesResult, lessonsResult, skillsResult, prereqsResult] =
    await Promise.all([
      supabase.from('levels').select('*').eq('course_id', course.id).order('ordinal'),
      supabase.from('modules').select('*').order('ordinal'),
      supabase.from('lessons').select('*').order('ordinal'),
      supabase.from('module_skills').select('*'),
      supabase.from('module_prerequisites').select('*'),
    ]);

  const modules = modulesResult.data ?? [];
  const lessons = lessonsResult.data ?? [];
  const moduleSkills = skillsResult.data ?? [];
  const modulePrereqs = prereqsResult.data ?? [];

  return (levelsResult.data ?? []).map((level) => ({
    ...level,
    modules: modules
      .filter((m) => m.level_id === level.id)
      .map((m) => ({
        ...m,
        lessons: lessons.filter((l) => l.module_id === m.id).sort((a, b) => a.ordinal - b.ordinal),
        skillIds: moduleSkills.filter((s) => s.module_id === m.id).map((s) => s.skill_id),
        prerequisiteIds: modulePrereqs
          .filter((p) => p.module_id === m.id)
          .map((p) => p.prerequisite_module_id),
      })),
  }));
});

/** Module gating data, in the shape `evaluateModuleGate` expects. */
export const getModuleGates = cache(async () => {
  const supabase = await createClient();
  const [{ data: modules }, { data: prereqs }, { data: skills }] = await Promise.all([
    supabase.from('modules').select('id, slug, title, level_id, ordinal').order('ordinal'),
    supabase.from('module_prerequisites').select('*'),
    supabase.from('module_skills').select('*'),
  ]);

  return (modules ?? []).map((module) => ({
    moduleId: module.id,
    slug: module.slug,
    title: module.title,
    prerequisiteModuleIds: (prereqs ?? [])
      .filter((p) => p.module_id === module.id)
      .map((p) => p.prerequisite_module_id),
    requiredSkills: (skills ?? [])
      .filter((s) => s.module_id === module.id)
      .map((s) => ({ skillId: s.skill_id, masteryRequired: Number(s.mastery_required) })),
  }));
});

export const getSkills = cache(async (): Promise<SkillRow[]> => {
  const supabase = await createClient();
  const { data } = await supabase.from('skills').select('*').order('ordinal');
  return data ?? [];
});

export const getAchievements = cache(async (): Promise<AchievementRow[]> => {
  const supabase = await createClient();
  const { data } = await supabase.from('achievements').select('*').order('ordinal');
  return data ?? [];
});

export const getProjectTemplates = cache(async (): Promise<ProjectTemplateRow[]> => {
  const supabase = await createClient();
  const { data } = await supabase.from('project_templates').select('*').order('ordinal');
  return data ?? [];
});

export const getMediaLibrary = cache(
  async (): Promise<(LearningMediaRow & { attribution: MediaAttributionRow | null })[]> => {
    const supabase = await createClient();
    const [{ data: media }, { data: attributions }] = await Promise.all([
      supabase.from('learning_media').select('*').order('kind').order('title'),
      supabase.from('media_attributions').select('*'),
    ]);
    return (media ?? []).map((asset) => ({
      ...asset,
      attribution: (attributions ?? []).find((a) => a.media_id === asset.id) ?? null,
    }));
  },
);

// ---------------------------------------------------------------------------
// Lessons
// ---------------------------------------------------------------------------

/** An exercise as it may be sent to the browser — no reference solution. */
export type LearnerExercise = Omit<ExerciseRow, 'reference_solution'> & {
  requirements: Omit<ExerciseRequirementRow, 'exercise_id'>[];
  /** Only populated once the learner has passed. */
  reference_solution: string | null;
};

/** A quiz question as it may be sent to the browser — no answer key. */
export type LearnerQuestion = QuizQuestionRow & {
  options: Omit<QuizOptionRow, 'is_correct' | 'question_id'>[];
};

export interface LessonDetail {
  lesson: LessonRow;
  module: ModuleRow;
  level: LevelRow;
  blocks: LessonBlockRow[];
  exercises: LearnerExercise[];
  questions: LearnerQuestion[];
  /** The next lesson in course order, for the continue button. */
  next: { slug: string; title: string } | null;
  previous: { slug: string; title: string } | null;
}

/**
 * Loads a lesson for display.
 *
 * `passedExerciseIds` controls which reference solutions are included: a
 * learner sees the model answer only after they have solved the exercise
 * themselves, which is why this is computed server-side rather than hidden
 * with CSS.
 */
export const getLessonDetail = cache(
  async (slug: string, passedExerciseIds: string[] = []): Promise<LessonDetail | null> => {
    const supabase = await createClient();

    const { data: lesson } = await supabase
      .from('lessons')
      .select('*')
      .eq('slug', slug)
      .maybeSingle();
    if (!lesson) return null;

    const [{ data: module }, { data: blocks }, { data: exercises }, { data: questions }] =
      await Promise.all([
        supabase.from('modules').select('*').eq('id', lesson.module_id).maybeSingle(),
        supabase.from('lesson_blocks').select('*').eq('lesson_id', lesson.id).order('ordinal'),
        supabase.from('exercises').select('*').eq('lesson_id', lesson.id).order('ordinal'),
        supabase.from('quiz_questions').select('*').eq('lesson_id', lesson.id).order('ordinal'),
      ]);

    if (!module) return null;

    const { data: level } = await supabase
      .from('levels')
      .select('*')
      .eq('id', module.level_id)
      .maybeSingle();
    if (!level) return null;

    const exerciseIds = (exercises ?? []).map((e) => e.id);
    const questionIds = (questions ?? []).map((q) => q.id);

    const [{ data: requirements }, { data: options }] = await Promise.all([
      exerciseIds.length
        ? supabase
            .from('exercise_requirements')
            .select('*')
            .in('exercise_id', exerciseIds)
            .order('ordinal')
        : Promise.resolve({ data: [] as ExerciseRequirementRow[] }),
      questionIds.length
        ? supabase.from('quiz_options').select('*').in('question_id', questionIds).order('ordinal')
        : Promise.resolve({ data: [] as QuizOptionRow[] }),
    ]);

    const passed = new Set(passedExerciseIds);

    const learnerExercises: LearnerExercise[] = (exercises ?? []).map((exercise) => {
      const { reference_solution, ...rest } = exercise;
      return {
        ...rest,
        // The model answer is withheld until the learner has solved it.
        reference_solution: passed.has(exercise.id) ? reference_solution : null,
        requirements: (requirements ?? [])
          .filter((r) => r.exercise_id === exercise.id)
          .map(({ exercise_id: _exerciseId, ...requirement }) => requirement),
      };
    });

    const learnerQuestions: LearnerQuestion[] = (questions ?? []).map((question) => ({
      ...question,
      options: (options ?? [])
        .filter((o) => o.question_id === question.id)
        // `is_correct` is deliberately dropped: the answer key never reaches
        // the browser, so it cannot be read out of the page source.
        .map(({ is_correct: _isCorrect, question_id: _questionId, ...option }) => option),
    }));

    const { next, previous } = await getLessonNeighbours(lesson.id);

    return {
      lesson,
      module,
      level,
      blocks: blocks ?? [],
      exercises: learnerExercises,
      questions: learnerQuestions,
      next,
      previous,
    };
  },
);

/** The flat course order, used for next/previous and progress maths. */
export const getLessonOrder = cache(async (): Promise<{ id: string; slug: string; title: string; moduleId: string }[]> => {
  const supabase = await createClient();
  const { data } = await supabase
    .from('course_outline')
    .select('lesson_id, lesson_slug, lesson_title, module_id, level_ordinal, module_ordinal, lesson_ordinal')
    .order('level_ordinal')
    .order('module_ordinal')
    .order('lesson_ordinal');

  return (data ?? []).map((row) => ({
    id: row.lesson_id,
    slug: row.lesson_slug,
    title: row.lesson_title,
    moduleId: row.module_id,
  }));
});

async function getLessonNeighbours(lessonId: string) {
  const order = await getLessonOrder();
  const index = order.findIndex((l) => l.id === lessonId);
  const previousLesson = index > 0 ? order[index - 1] : undefined;
  const nextLesson = index >= 0 && index < order.length - 1 ? order[index + 1] : undefined;
  return {
    previous: previousLesson ? { slug: previousLesson.slug, title: previousLesson.title } : null,
    next: nextLesson ? { slug: nextLesson.slug, title: nextLesson.title } : null,
  };
}

// ---------------------------------------------------------------------------
// Server-only lookups: these return answer keys and must never be called from
// a component that renders to the browser.
// ---------------------------------------------------------------------------

/** Full exercise including its reference solution and pass criteria. */
export async function getExerciseForGrading(exerciseId: string): Promise<{
  exercise: ExerciseRow;
  requirements: ExerciseRequirementRow[];
} | null> {
  const supabase = await createClient();
  const { data: exercise } = await supabase
    .from('exercises')
    .select('*')
    .eq('id', exerciseId)
    .maybeSingle();
  if (!exercise) return null;

  const { data: requirements } = await supabase
    .from('exercise_requirements')
    .select('*')
    .eq('exercise_id', exerciseId)
    .order('ordinal');

  return { exercise, requirements: requirements ?? [] };
}

/** Full question including which options are correct. */
export async function getQuestionForGrading(questionId: string): Promise<{
  question: QuizQuestionRow;
  options: QuizOptionRow[];
} | null> {
  const supabase = await createClient();
  const { data: question } = await supabase
    .from('quiz_questions')
    .select('*')
    .eq('id', questionId)
    .maybeSingle();
  if (!question) return null;

  const { data: options } = await supabase
    .from('quiz_options')
    .select('*')
    .eq('question_id', questionId)
    .order('ordinal');

  return { question, options: options ?? [] };
}

export const getAssessment = cache(
  async (slug: string): Promise<{ assessment: AssessmentRow; questions: LearnerQuestion[] } | null> => {
    const supabase = await createClient();
    const { data: assessment } = await supabase
      .from('assessments')
      .select('*')
      .eq('slug', slug)
      .maybeSingle();
    if (!assessment) return null;

    const { data: questions } = await supabase
      .from('quiz_questions')
      .select('*')
      .eq('assessment_id', assessment.id)
      .order('ordinal');

    const questionIds = (questions ?? []).map((q) => q.id);
    const { data: options } = questionIds.length
      ? await supabase.from('quiz_options').select('*').in('question_id', questionIds).order('ordinal')
      : { data: [] as QuizOptionRow[] };

    return {
      assessment,
      questions: (questions ?? []).map((question) => ({
        ...question,
        options: (options ?? [])
          .filter((o) => o.question_id === question.id)
          .map(({ is_correct: _isCorrect, question_id: _questionId, ...option }) => option),
      })),
    };
  },
);

export const getLevelAssessment = cache(async (levelId: string) => {
  const supabase = await createClient();
  const { data } = await supabase
    .from('assessments')
    .select('*')
    .eq('level_id', levelId)
    .maybeSingle();
  return data;
});
