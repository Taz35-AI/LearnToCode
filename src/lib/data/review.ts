import 'server-only';
import { createClient } from '@/lib/supabase/server';
import { getPassedExerciseIds, getSkillMastery } from '@/lib/data/learner';
import { getSkills } from '@/lib/data/catalogue';
import { isMastered } from '@/lib/progress/mastery';
import { GRADE_AGAIN, reviewDate } from '@/lib/review/scheduler';
import {
  DEFAULT_SESSION_OPTIONS,
  composeLessonWarmUp,
  composeReviewSession,
  warmUpSkillsFor,
  type ReviewCandidate,
} from '@/lib/review/session';
import type { ReviewCard } from '@/lib/review/scheduler';
import type { ExerciseKind } from '@/lib/supabase/database.types';

/**
 * Server-only reads for the review engine.
 *
 * The rule the rest of the data layer follows applies here too, and matters
 * more: **answer keys never leave the server**. A review question is delivered
 * to the browser with its options in place and `is_correct` stripped, exactly
 * as a lesson quiz is. Grading happens in a Server Action against the database,
 * so nothing the client sends is trusted.
 */

interface ReviewItemRow {
  id: string;
  slug: string;
  kind: 'question' | 'exercise' | 'recall_prompt';
  difficulty: number;
  prompt: string | null;
  skills: { slug: string } | null;
  lessons: { slug: string; modules: { slug: string; levels: { ordinal: number } | null } | null } | null;
  quiz_questions: { id: string; prompt: string; kind: string } | null;
  exercises: { id: string; title: string; brief: string; starter_code: string } | null;
}

interface ReviewStateRow {
  review_item_id: string;
  stability: number;
  difficulty: number;
  reps: number;
  lapses: number;
  state: 'new' | 'learning' | 'review' | 'relearning';
  last_reviewed_on: string | null;
  due_on: string | null;
}

/** A card the learner has never seen has no row yet; treat it as brand new. */
const UNSEEN: ReviewCard = {
  stability: 0,
  difficulty: 0,
  reps: 0,
  lapses: 0,
  state: 'new',
  lastReviewedOn: null,
  dueOn: null,
};

const cardFrom = (row: ReviewStateRow | undefined): ReviewCard =>
  row === undefined
    ? UNSEEN
    : {
        stability: row.stability,
        difficulty: row.difficulty,
        reps: row.reps,
        lapses: row.lapses,
        state: row.state,
        lastReviewedOn: row.last_reviewed_on,
        dueOn: row.due_on,
      };

/**
 * Every item this learner could be asked, with its current schedule.
 *
 * Restricted to items from lessons the learner has actually started. Reviewing
 * something never taught is not spaced repetition, it is a cold quiz, and it
 * would make the queue look enormous from day one.
 */
export async function getReviewCandidates(userId: string): Promise<ReviewCandidate[]> {
  const supabase = await createClient();

  const [{ data: items }, { data: states }, { data: progress }] = await Promise.all([
    supabase
      .from('review_items')
      .select(
        `id, slug, kind, difficulty, prompt,
         skills ( slug ),
         lessons ( slug, modules ( slug, levels ( ordinal ) ) )`,
      ),
    supabase
      .from('review_states')
      .select('review_item_id, stability, difficulty, reps, lapses, state, last_reviewed_on, due_on')
      .eq('user_id', userId),
    supabase.from('user_lesson_progress').select('lessons ( slug )').eq('user_id', userId),
  ]);

  const startedLessons = new Set(
    ((progress ?? []) as unknown as { lessons: { slug: string } | null }[])
      .map((row) => row.lessons?.slug)
      .filter((slug): slug is string => typeof slug === 'string'),
  );

  const stateByItem = new Map<string, ReviewStateRow>();
  for (const state of (states ?? []) as unknown as ReviewStateRow[]) {
    stateByItem.set(state.review_item_id, state);
  }

  const candidates: ReviewCandidate[] = [];

  for (const item of (items ?? []) as unknown as ReviewItemRow[]) {
    const lessonSlug = item.lessons?.slug;
    const skillSlug = item.skills?.slug;
    if (!lessonSlug || !skillSlug) continue;
    if (!startedLessons.has(lessonSlug)) continue;

    candidates.push({
      itemId: item.id,
      kind: item.kind,
      skillSlug,
      levelOrdinal: item.lessons?.modules?.levels?.ordinal ?? 1,
      moduleSlug: item.lessons?.modules?.slug ?? '',
      lessonSlug,
      difficulty: item.difficulty,
      card: cardFrom(stateByItem.get(item.id)),
    });
  }

  return candidates;
}

export interface ReviewQuestion {
  itemId: string;
  questionId: string;
  prompt: string;
  kind: string;
  lessonSlug: string;
  skillSlug: string;
  /** Options with the answer key removed. */
  options: { id: string; label: string }[];
}

/**
 * Loads the questions for a set of review items, ready to render.
 *
 * `is_correct` is selected and then dropped before returning: the grading
 * action needs it, this function's callers are React components, and a shape
 * that cannot carry the answer is safer than remembering not to send it.
 */
export async function getReviewQuestions(itemIds: string[]): Promise<ReviewQuestion[]> {
  if (itemIds.length === 0) return [];

  const supabase = await createClient();

  const { data } = await supabase
    .from('review_items')
    .select(
      `id, question_id,
       skills ( slug ),
       lessons ( slug ),
       quiz_questions ( id, prompt, kind, quiz_options ( id, label, ordinal ) )`,
    )
    .in('id', itemIds)
    .eq('kind', 'question');

  type Row = {
    id: string;
    skills: { slug: string } | null;
    lessons: { slug: string } | null;
    quiz_questions: {
      id: string;
      prompt: string;
      kind: string;
      quiz_options: { id: string; label: string; ordinal: number }[];
    } | null;
  };

  const questions: ReviewQuestion[] = [];

  for (const row of (data ?? []) as unknown as Row[]) {
    const question = row.quiz_questions;
    if (!question) continue;

    questions.push({
      itemId: row.id,
      questionId: question.id,
      prompt: question.prompt,
      kind: question.kind,
      lessonSlug: row.lessons?.slug ?? '',
      skillSlug: row.skills?.slug ?? '',
      options: [...question.quiz_options]
        .sort((a, b) => a.ordinal - b.ordinal)
        .map((option) => ({ id: option.id, label: option.label })),
    });
  }

  // Preserve the interleaved order the session composer chose, which the
  // database query does not know about.
  const order = new Map(itemIds.map((id, index) => [id, index]));
  return questions.sort((a, b) => (order.get(a.itemId) ?? 0) - (order.get(b.itemId) ?? 0));
}

export interface ReviewExercise {
  itemId: string;
  exerciseId: string;
  slug: string;
  kind: ExerciseKind;
  title: string;
  brief: string;
  starterCode: string;
  hints: string[];
  xpAward: number;
  difficulty: number;
  isOptional: boolean;
  requirements: { id: string; message: string }[];
  /** Only once the learner has already solved it. */
  referenceSolution: string | null;
  lessonSlug: string;
  skillSlug: string;
}

/**
 * Loads the exercises for a set of review items, ready to render.
 *
 * Exercises are 79 of the 195 reviewable items, and they are the ones that
 * measure whether the learner can still *write* markup rather than recognise a
 * description of it. A review queue built only from multiple choice tests the
 * cheaper half of what the course teaches.
 *
 * The reference solution obeys the same rule as the lesson page: withheld
 * unless this learner has already passed the exercise, so review can never be
 * the route by which a model answer leaks.
 */
export async function getReviewExercises(
  itemIds: string[],
  passedExerciseIds: readonly string[] = [],
): Promise<ReviewExercise[]> {
  if (itemIds.length === 0) return [];

  const supabase = await createClient();

  const { data } = await supabase
    .from('review_items')
    .select(
      `id, exercise_id,
       skills ( slug ),
       lessons ( slug ),
       exercises ( id, slug, kind, title, brief, starter_code, reference_solution, hints,
                   xp_award, difficulty, is_optional )`,
    )
    .in('id', itemIds)
    .eq('kind', 'exercise');

  type Row = {
    id: string;
    skills: { slug: string } | null;
    lessons: { slug: string } | null;
    exercises: {
      id: string;
      slug: string;
      kind: ExerciseKind;
      title: string;
      brief: string;
      starter_code: string;
      reference_solution: string;
      hints: string[];
      xp_award: number;
      difficulty: number;
      is_optional: boolean;
    } | null;
  };

  const rows = (data ?? []) as unknown as Row[];
  const exerciseIds = rows.map((row) => row.exercises?.id).filter((id): id is string => Boolean(id));

  const { data: requirements } = exerciseIds.length
    ? await supabase
        .from('exercise_requirements')
        .select('id, exercise_id, message, ordinal')
        .in('exercise_id', exerciseIds)
        .order('ordinal')
    : { data: [] };

  const passed = new Set(passedExerciseIds);
  const exercises: ReviewExercise[] = [];

  for (const row of rows) {
    const exercise = row.exercises;
    if (!exercise) continue;

    exercises.push({
      itemId: row.id,
      exerciseId: exercise.id,
      slug: exercise.slug,
      kind: exercise.kind,
      title: exercise.title,
      brief: exercise.brief,
      starterCode: exercise.starter_code,
      hints: exercise.hints,
      xpAward: exercise.xp_award,
      difficulty: exercise.difficulty,
      isOptional: exercise.is_optional,
      requirements: (requirements ?? [])
        .filter((requirement) => requirement.exercise_id === exercise.id)
        .map((requirement) => ({ id: requirement.id, message: requirement.message })),
      referenceSolution: passed.has(exercise.id) ? exercise.reference_solution : null,
      lessonSlug: row.lessons?.slug ?? '',
      skillSlug: row.skills?.slug ?? '',
    });
  }

  const order = new Map(itemIds.map((id, index) => [id, index]));
  return exercises.sort((a, b) => (order.get(a.itemId) ?? 0) - (order.get(b.itemId) ?? 0));
}

/** One item as the session component renders it. */
export type ReviewEntry =
  | { kind: 'question'; question: ReviewQuestion }
  | { kind: 'exercise'; exercise: ReviewExercise };

export interface SessionRequest {
  userId: string;
  /** Narrows the pool — one module, one level, or everything. */
  filter?: (candidate: ReviewCandidate) => boolean;
  maxItems?: number;
  /** Distinguishes one surface's shuffle from another's. */
  seedSuffix?: string;
  today?: string;
}

export interface ComposedSession {
  entries: ReviewEntry[];
  /** Every candidate in the pool, before selection — for forecasts and counts. */
  candidates: ReviewCandidate[];
  /** The pool after the filter, so a page can say how much it covers. */
  pool: ReviewCandidate[];
}

/**
 * Composes a session and loads everything needed to render it.
 *
 * Shared by the daily queue, module recall and level review. They differ only
 * in which candidates they draw from and how many items they allow, and
 * everything after that — scoring, interleaving, loading questions and
 * exercises, restoring the chosen order — is identical. Three copies of it
 * would be three chances for one surface to interleave and another not to.
 */
export async function composeSession(request: SessionRequest): Promise<ComposedSession> {
  const today = request.today ?? reviewDate(new Date());

  const [candidates, weakSkills, passedExerciseIds] = await Promise.all([
    getReviewCandidates(request.userId),
    getWeakSkillSlugs(request.userId),
    getPassedExerciseIds(request.userId),
  ]);

  const pool = request.filter ? candidates.filter(request.filter) : candidates;

  const session = composeReviewSession(pool, {
    ...DEFAULT_SESSION_OPTIONS,
    ...(request.maxItems === undefined ? {} : { maxItems: request.maxItems }),
    today,
    weakSkills,
    currentLevel: Math.max(1, ...pool.map((candidate) => candidate.levelOrdinal)),
    seed: request.seedSuffix ? `${request.userId}:${request.seedSuffix}` : request.userId,
  });

  const questionIds = session
    .filter((entry) => entry.candidate.kind === 'question')
    .map((entry) => entry.candidate.itemId);
  const exerciseIds = session
    .filter((entry) => entry.candidate.kind === 'exercise')
    .map((entry) => entry.candidate.itemId);

  const [questions, exercises] = await Promise.all([
    getReviewQuestions(questionIds),
    getReviewExercises(exerciseIds, passedExerciseIds),
  ]);

  const questionByItem = new Map(questions.map((question) => [question.itemId, question]));
  const exerciseByItem = new Map(exercises.map((exercise) => [exercise.itemId, exercise]));

  // Rebuilt from the session order rather than by concatenating the two
  // queries, so the interleaving the composer chose survives — a session that
  // ran all its questions and then all its exercises would be blocked
  // practice wearing an interleaved label.
  const entries: ReviewEntry[] = [];
  for (const scored of session) {
    const { itemId, kind } = scored.candidate;
    if (kind === 'question') {
      const question = questionByItem.get(itemId);
      if (question) entries.push({ kind: 'question', question });
    } else if (kind === 'exercise') {
      const exercise = exerciseByItem.get(itemId);
      if (exercise) entries.push({ kind: 'exercise', exercise });
    }
  }

  return { entries, candidates, pool };
}

/**
 * Skills this learner has not yet demonstrated, by slug.
 *
 * Shared by every surface that composes a session — the review queue, the
 * lesson warm-up, module recall and level review — because "weak" has to mean
 * the same thing on all of them or the same item would be urgent on one page
 * and absent from another.
 */
export async function getWeakSkillSlugs(userId: string): Promise<Set<string>> {
  const [mastery, skills] = await Promise.all([getSkillMastery(userId), getSkills()]);
  const slugById = new Map(skills.map((skill) => [skill.id, skill.slug]));

  return new Set(
    mastery
      .filter(
        (record) =>
          !isMastered({ mastery: Number(record.mastery), evidenceCount: record.evidence_count }),
      )
      .map((record) => slugById.get(record.skill_id) ?? '')
      .filter(Boolean),
  );
}

/**
 * The retrieval warm-up that opens a lesson.
 *
 * Questions only, never exercises: the warm-up has to be over in a minute or
 * two, and a coding task placed between the learner and the lesson stops being
 * a warm-up and becomes the lesson.
 *
 * Items from the lesson being opened are excluded. Asking a lesson's own
 * questions before teaching it is a pretest — a genuinely useful thing, which
 * is why `pretest` is an authored block type — but it is not retrieval of prior
 * material, and mixing the two would make the warm-up look broken on any lesson
 * the learner is revisiting.
 */
export async function getLessonWarmUp(
  userId: string,
  lessonSlug: string,
  today: string = reviewDate(new Date()),
): Promise<ReviewQuestion[]> {
  const supabase = await createClient();

  const { data: lesson } = await supabase
    .from('lessons')
    .select('id, module_id, primary_skill_id')
    .eq('slug', lessonSlug)
    .maybeSingle();
  if (!lesson) return [];

  const [candidates, weakSkills, skills, { data: moduleSkillRows }, { data: prerequisiteRows }] =
    await Promise.all([
      getReviewCandidates(userId),
      getWeakSkillSlugs(userId),
      getSkills(),
      supabase.from('module_skills').select('skill_id').eq('module_id', lesson.module_id),
      supabase.from('skill_prerequisites').select('skill_id, prerequisite_skill_id'),
    ]);

  const slugById = new Map(skills.map((skill) => [skill.id, skill.slug]));

  const skillPrerequisites = new Map<string, string[]>();
  for (const row of prerequisiteRows ?? []) {
    const skill = slugById.get(row.skill_id);
    const prerequisite = slugById.get(row.prerequisite_skill_id);
    if (!skill || !prerequisite) continue;
    const existing = skillPrerequisites.get(skill);
    if (existing) existing.push(prerequisite);
    else skillPrerequisites.set(skill, [prerequisite]);
  }

  const lessonSkill = lesson.primary_skill_id ? slugById.get(lesson.primary_skill_id) : undefined;
  if (!lessonSkill) return [];

  const relevantSkills = warmUpSkillsFor({
    lessonSkill,
    moduleSkills: (moduleSkillRows ?? [])
      .map((row) => slugById.get(row.skill_id) ?? '')
      .filter(Boolean),
    skillPrerequisites,
  });

  const eligible = candidates.filter(
    (candidate) => candidate.kind === 'question' && candidate.lessonSlug !== lessonSlug,
  );

  const warmUp = composeLessonWarmUp(eligible, relevantSkills, {
    today,
    weakSkills,
    currentLevel: Math.max(1, ...eligible.map((candidate) => candidate.levelOrdinal)),
    // Seeded per lesson as well as per learner, so revisiting a lesson does not
    // deal the identical three questions every time.
    seed: `${userId}:${lessonSlug}`,
  });

  return getReviewQuestions(warmUp.map((entry) => entry.candidate.itemId));
}

/**
 * Confidence ratings paired with outcomes, for the calibration report.
 *
 * Drawn from two places. Every answered question writes to `quiz_attempts` —
 * lesson quizzes and review alike, since `answerReviewItemAction` records a
 * review answer as an ordinary attempt too. Reviewed *exercises* have no
 * question row, so their confidence lives only in `review_logs`, and reading
 * just the one table would silently exclude every point where the learner
 * predicted whether they could write markup rather than recognise it.
 *
 * Only exercise items are taken from the log: question items are already
 * counted via `quiz_attempts`, and including both would double them.
 */
export async function getCalibrationHistory(
  userId: string,
): Promise<{ confidence: 1 | 2 | 3 | 4; correct: boolean; skillSlug: string }[]> {
  const supabase = await createClient();

  const [{ data: attempts }, { data: logs }] = await Promise.all([
    supabase
      .from('quiz_attempts')
      .select('is_correct, confidence, quiz_questions ( skills ( slug ) )')
      .eq('user_id', userId)
      .not('confidence', 'is', null)
      .order('answered_at', { ascending: false })
      .limit(500),
    supabase
      .from('review_logs')
      .select('grade, confidence, review_items!inner ( kind, skills ( slug ) )')
      .eq('user_id', userId)
      .eq('review_items.kind', 'exercise')
      .not('confidence', 'is', null)
      .order('reviewed_at', { ascending: false })
      .limit(500),
  ]);

  type AttemptRow = {
    is_correct: boolean;
    confidence: number | null;
    quiz_questions: { skills: { slug: string } | null } | null;
  };

  type LogRow = {
    grade: number;
    confidence: number | null;
    review_items: { kind: string; skills: { slug: string } | null } | null;
  };

  const points: { confidence: 1 | 2 | 3 | 4; correct: boolean; skillSlug: string }[] = [];

  const add = (confidence: number | null, correct: boolean, skillSlug: string | undefined) => {
    if (confidence === null || confidence < 1 || confidence > 4 || !skillSlug) return;
    points.push({ confidence: confidence as 1 | 2 | 3 | 4, correct, skillSlug });
  };

  for (const row of (attempts ?? []) as unknown as AttemptRow[]) {
    add(row.confidence, row.is_correct, row.quiz_questions?.skills?.slug);
  }

  for (const row of (logs ?? []) as unknown as LogRow[]) {
    // GRADE_AGAIN is the only failing grade: anything above it means the
    // learner produced a working answer.
    add(row.confidence, row.grade > GRADE_AGAIN, row.review_items?.skills?.slug);
  }

  return points;
}
