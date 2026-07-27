import 'server-only';
import { createClient } from '@/lib/supabase/server';
import type { ReviewCandidate } from '@/lib/review/session';
import type { ReviewCard } from '@/lib/review/scheduler';

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

/** Confidence ratings paired with outcomes, for the calibration report. */
export async function getCalibrationHistory(
  userId: string,
): Promise<{ confidence: 1 | 2 | 3 | 4; correct: boolean; skillSlug: string }[]> {
  const supabase = await createClient();

  const { data } = await supabase
    .from('quiz_attempts')
    .select('is_correct, confidence, quiz_questions ( skills ( slug ) )')
    .eq('user_id', userId)
    .not('confidence', 'is', null)
    .order('answered_at', { ascending: false })
    .limit(500);

  type Row = {
    is_correct: boolean;
    confidence: number | null;
    quiz_questions: { skills: { slug: string } | null } | null;
  };

  const points: { confidence: 1 | 2 | 3 | 4; correct: boolean; skillSlug: string }[] = [];

  for (const row of (data ?? []) as unknown as Row[]) {
    const confidence = row.confidence;
    const skillSlug = row.quiz_questions?.skills?.slug;
    if (confidence === null || confidence < 1 || confidence > 4 || !skillSlug) continue;
    points.push({ confidence: confidence as 1 | 2 | 3 | 4, correct: row.is_correct, skillSlug });
  }

  return points;
}
