'use server';

import { revalidatePath } from 'next/cache';
import { z } from 'zod';
import { createClient, getCurrentUser } from '@/lib/supabase/server';
import { getExerciseForGrading, getQuestionForGrading } from '@/lib/data/catalogue';
import { evaluateSubmission } from '@/lib/evaluator/evaluate';
import { requirementFromRow } from '@/lib/evaluator/types';
import {
  gradeFromPerformance,
  newCard,
  reviewCard,
  type ReviewCard,
} from '@/lib/review/scheduler';
import { recordMasteryEvidence } from '@/lib/data/mastery';
import { fieldErrors, type ActionResult } from './schemas';
import type { EvaluationResult } from '@/lib/evaluator/types';
import type { ExerciseRequirementRow } from '@/lib/supabase/database.types';

/**
 * Review actions.
 *
 * Grading a review is the same trust model as grading a quiz: the answer key
 * is loaded from the database here, on the server, and nothing the browser
 * sends is believed except which options were chosen.
 *
 * One addition specific to review: the learner's stated confidence is recorded
 * alongside the outcome. It is captured *before* the answer is revealed, which
 * is the only point at which it means anything, and it is what makes the
 * calibration report possible.
 */

const confidenceSchema = z
  .union([z.literal(1), z.literal(2), z.literal(3), z.literal(4)])
  .optional();

const answerReviewSchema = z.object({
  itemId: z.string().uuid(),
  questionId: z.string().uuid(),
  optionIds: z.array(z.string().uuid()).min(1, 'Choose an answer'),
  confidence: confidenceSchema,
});

const reviewExerciseSchema = z.object({
  itemId: z.string().uuid(),
  exerciseId: z.string().uuid(),
  code: z.string().max(100_000, 'That is longer than any exercise needs'),
  hintsUsed: z.number().int().min(0).max(20),
  durationSeconds: z.number().int().min(0).max(86_400),
  confidence: confidenceSchema,
});

async function requireUser() {
  const user = await getCurrentUser();
  if (!user) throw new Error('Not signed in');
  return user;
}

/**
 * Applies a graded review to the schedule and the history.
 *
 * The FSRS update, the card write and the append to `review_logs` are identical
 * whether the learner answered a question or wrote markup — only the grading
 * differs — so they live in one place. Keeping two copies would let the two
 * item kinds drift into two different schedules.
 *
 * Not exported: every export of a `'use server'` module is an endpoint the
 * browser can call, and an endpoint that writes a schedule from a client-chosen
 * grade would let a learner mark everything easy and empty their own queue.
 */
async function applyReview(
  userId: string,
  itemId: string,
  grade: 1 | 2 | 3 | 4,
  confidence: 1 | 2 | 3 | 4 | null,
): Promise<{ intervalDays: number; retrievability: number }> {
  const supabase = await createClient();

  const { data: existing } = await supabase
    .from('review_states')
    .select('stability, difficulty, reps, lapses, state, last_reviewed_on, due_on')
    .eq('user_id', userId)
    .eq('review_item_id', itemId)
    .maybeSingle();

  const card: ReviewCard = existing
    ? {
        stability: existing.stability,
        difficulty: existing.difficulty,
        reps: existing.reps,
        lapses: existing.lapses,
        state: existing.state,
        lastReviewedOn: existing.last_reviewed_on,
        dueOn: existing.due_on,
      }
    : newCard();

  const outcome = reviewCard(card, grade, new Date());

  await supabase.from('review_states').upsert(
    {
      user_id: userId,
      review_item_id: itemId,
      stability: outcome.card.stability,
      difficulty: outcome.card.difficulty,
      reps: outcome.card.reps,
      lapses: outcome.card.lapses,
      state: outcome.card.state,
      last_reviewed_on: outcome.card.lastReviewedOn,
      due_on: outcome.card.dueOn,
    },
    { onConflict: 'user_id,review_item_id' },
  );

  await supabase.from('review_logs').insert({
    user_id: userId,
    review_item_id: itemId,
    grade,
    confidence,
    retrievability: outcome.retrievabilityAtReview,
    interval_days: outcome.intervalDays,
  });

  return {
    intervalDays: outcome.intervalDays,
    retrievability: outcome.retrievabilityAtReview,
  };
}

export interface ReviewOutcomeResult {
  isCorrect: boolean;
  correctOptionIds: string[];
  explanation: string | null;
  /** Days until this item comes back. 0 means later in this same session. */
  intervalDays: number;
  /** How likely recall was at the moment of asking — how hard it really was. */
  retrievability: number;
}

/**
 * Grades one review answer, updates its schedule and records the history.
 *
 * No XP is awarded for review. That is deliberate: paying for reviews would
 * turn a memory schedule into a grind that rewards clicking through, and the
 * point of spacing is to do *less* work, not more. Progress here shows up as
 * mastery and as a shrinking queue.
 */
export async function answerReviewItemAction(
  input: unknown,
): Promise<ActionResult<ReviewOutcomeResult>> {
  const parsed = answerReviewSchema.safeParse(input);
  if (!parsed.success) return { ok: false, errors: fieldErrors(parsed.error) };

  const user = await requireUser();
  const supabase = await createClient();

  const loaded = await getQuestionForGrading(parsed.data.questionId);
  if (!loaded) return { ok: false, message: 'That question no longer exists.' };

  const { question, options } = loaded;
  const correctIds = options.filter((option) => option.is_correct).map((option) => option.id);
  const selected = new Set(parsed.data.optionIds);
  const isCorrect =
    correctIds.length === selected.size && correctIds.every((id) => selected.has(id));

  // Confirm the item exists and belongs to this question before writing a
  // schedule against an id the client supplied.
  const { data: item } = await supabase
    .from('review_items')
    .select('id, skill_id, question_id')
    .eq('id', parsed.data.itemId)
    .maybeSingle();

  if (!item || item.question_id !== question.id) {
    return { ok: false, message: 'That review item no longer exists.' };
  }

  // A review is a single graded attempt, so there are no hints and one try.
  const grade = gradeFromPerformance({ correct: isCorrect, hintsUsed: 0, attempts: 1 });
  const outcome = await applyReview(user.id, item.id, grade, parsed.data.confidence ?? null);

  // Recorded as an ordinary answer too, so calibration is measured across
  // everything the learner answers rather than only inside review sessions.
  await supabase.from('quiz_attempts').insert({
    user_id: user.id,
    question_id: question.id,
    selected_option_ids: parsed.data.optionIds,
    is_correct: isCorrect,
    confidence: parsed.data.confidence ?? null,
  });

  // Weighted as quiz evidence, exactly as the same question counts inside a
  // lesson: a recalled multiple-choice answer is real evidence, but weaker
  // than writing working markup.
  await recordMasteryEvidence(user.id, question.skill_id, 'quiz', isCorrect ? 1 : 0);

  revalidatePath('/review');
  revalidatePath('/dashboard');

  return {
    ok: true,
    data: {
      isCorrect,
      correctOptionIds: correctIds,
      explanation: question.explanation,
      intervalDays: outcome.intervalDays,
      retrievability: outcome.retrievability,
    },
  };
}

export interface ReviewExerciseOutcomeResult {
  result: EvaluationResult;
  /** Always zero. Present so the workbench can render one results panel. */
  xpAwarded: number;
  achievementsUnlocked: string[];
  referenceSolution: string | null;
  intervalDays: number;
  retrievability: number;
}

/**
 * Grades a reviewed exercise, updates its schedule and records the history.
 *
 * Exercises are 79 of the 195 reviewable items and the review page previously
 * selected them and then dropped them, so a learner could never be asked to
 * *write* anything in review — only to recognise a description of it. That made
 * the queue systematically easier than the course.
 *
 * Graded by the same evaluator, against the same requirements loaded from the
 * database, as when the exercise appeared in its lesson. Nothing the browser
 * sends is trusted except the markup itself.
 *
 * No XP, matching `answerReviewItemAction`: paying for review would turn a
 * memory schedule into a grind that rewards clicking through. The attempt is
 * deliberately *not* written to `exercise_attempts` either — that table is the
 * record of working through the course, and filling it with review attempts
 * would corrupt the first-pass streak the achievements are computed from.
 */
export async function answerReviewExerciseAction(
  input: unknown,
): Promise<ActionResult<ReviewExerciseOutcomeResult>> {
  const parsed = reviewExerciseSchema.safeParse(input);
  if (!parsed.success) return { ok: false, errors: fieldErrors(parsed.error) };

  const user = await requireUser();
  const supabase = await createClient();

  const loaded = await getExerciseForGrading(parsed.data.exerciseId);
  if (!loaded) return { ok: false, message: 'That exercise no longer exists.' };

  const { exercise, requirements } = loaded;

  // Confirm the item exists and points at this exercise before writing a
  // schedule against an id the client supplied.
  const { data: item } = await supabase
    .from('review_items')
    .select('id, skill_id, exercise_id')
    .eq('id', parsed.data.itemId)
    .maybeSingle();

  if (!item || item.exercise_id !== exercise.id) {
    return { ok: false, message: 'That review item no longer exists.' };
  }

  const result = evaluateSubmission(
    parsed.data.code,
    requirements.map((row: ExerciseRequirementRow) => requirementFromRow(row)),
  );

  const grade = gradeFromPerformance({
    correct: result.passed,
    hintsUsed: parsed.data.hintsUsed,
    attempts: 1,
  });
  const outcome = await applyReview(user.id, item.id, grade, parsed.data.confidence ?? null);

  // Weighted as exercise evidence, exactly as the same task counts inside its
  // lesson: producing working markup from memory is the strongest evidence the
  // app can collect.
  await recordMasteryEvidence(
    user.id,
    item.skill_id,
    'exercise',
    result.passed ? result.score : result.score * 0.5,
    parsed.data.hintsUsed,
  );

  // The learner's working copy still follows them between devices.
  await supabase.from('saved_code').upsert(
    {
      user_id: user.id,
      exercise_id: exercise.id,
      code: parsed.data.code,
      hints_used: parsed.data.hintsUsed,
    },
    { onConflict: 'user_id,exercise_id' },
  );

  // Whether this learner had already solved it, which is the only thing that
  // unlocks the reference solution.
  const { data: priorPasses } = await supabase
    .from('exercise_attempts')
    .select('id')
    .eq('user_id', user.id)
    .eq('exercise_id', exercise.id)
    .eq('passed', true)
    .limit(1);

  const maySeeSolution = result.passed || (priorPasses ?? []).length > 0;

  revalidatePath('/review');
  revalidatePath('/dashboard');

  return {
    ok: true,
    data: {
      result,
      xpAwarded: 0,
      achievementsUnlocked: [],
      referenceSolution: maySeeSolution ? exercise.reference_solution : null,
      intervalDays: outcome.intervalDays,
      retrievability: outcome.retrievability,
    },
  };
}
