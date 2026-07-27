'use server';

import { revalidatePath } from 'next/cache';
import { z } from 'zod';
import { createClient, getCurrentUser } from '@/lib/supabase/server';
import { getQuestionForGrading } from '@/lib/data/catalogue';
import {
  gradeFromPerformance,
  newCard,
  reviewCard,
  type ReviewCard,
} from '@/lib/review/scheduler';
import { recordMasteryEvidence } from '@/lib/data/mastery';
import { fieldErrors, type ActionResult } from './schemas';

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

const answerReviewSchema = z.object({
  itemId: z.string().uuid(),
  questionId: z.string().uuid(),
  optionIds: z.array(z.string().uuid()).min(1, 'Choose an answer'),
  confidence: z.union([z.literal(1), z.literal(2), z.literal(3), z.literal(4)]).optional(),
});

async function requireUser() {
  const user = await getCurrentUser();
  if (!user) throw new Error('Not signed in');
  return user;
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

  const { data: existing } = await supabase
    .from('review_states')
    .select('stability, difficulty, reps, lapses, state, last_reviewed_on, due_on')
    .eq('user_id', user.id)
    .eq('review_item_id', item.id)
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

  // A review is a single graded attempt, so there are no hints and one try.
  const grade = gradeFromPerformance({ correct: isCorrect, hintsUsed: 0, attempts: 1 });
  const now = new Date();
  const outcome = reviewCard(card, grade, now);

  await supabase.from('review_states').upsert(
    {
      user_id: user.id,
      review_item_id: item.id,
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
    user_id: user.id,
    review_item_id: item.id,
    grade,
    confidence: parsed.data.confidence ?? null,
    retrievability: outcome.retrievabilityAtReview,
    interval_days: outcome.intervalDays,
  });

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
      retrievability: outcome.retrievabilityAtReview,
    },
  };
}
