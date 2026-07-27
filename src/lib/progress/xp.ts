import type { XpSource } from '@/lib/supabase/database.types';

/**
 * XP rules.
 *
 * Two principles shape this file:
 *
 *   1. XP rewards *learning*, not repetition. Every award is keyed by
 *      `(source_type, source_id)` and the `xp_transactions` table carries a
 *      UNIQUE constraint on `(user_id, source_type, source_id)`. Re-submitting
 *      a solved exercise is rejected by the database, not by a code path that
 *      could be bypassed.
 *
 *   2. Effort is rewarded honestly. Using hints or needing several attempts
 *      still earns XP, just less of it — because a learner who struggles and
 *      then succeeds has learned something real.
 */

export interface XpAward {
  amount: number;
  sourceType: XpSource;
  /** Stable key that makes the award idempotent. */
  sourceId: string;
  reason: string;
}

/** Multiplier applied per hint revealed, floored so hints stay worth using. */
const HINT_PENALTY = 0.15;
const MIN_HINT_MULTIPLIER = 0.5;

/** Multiplier applied per failed attempt before success. */
const RETRY_PENALTY = 0.08;
const MIN_RETRY_MULTIPLIER = 0.6;

export interface ExerciseXpInput {
  exerciseId: string;
  baseXp: number;
  hintsUsed: number;
  /** Failed attempts made before this successful one. */
  priorAttempts: number;
  /** First-time completions get the full award; later ones get nothing. */
  alreadyAwarded: boolean;
  isOptional?: boolean;
}

export function exerciseXp(input: ExerciseXpInput): XpAward | null {
  if (input.alreadyAwarded) return null;

  const hintMultiplier = Math.max(
    MIN_HINT_MULTIPLIER,
    1 - HINT_PENALTY * Math.max(0, input.hintsUsed),
  );
  const retryMultiplier = Math.max(
    MIN_RETRY_MULTIPLIER,
    1 - RETRY_PENALTY * Math.max(0, input.priorAttempts),
  );

  const amount = Math.max(5, Math.round(input.baseXp * hintMultiplier * retryMultiplier));

  const notes: string[] = [];
  if (input.hintsUsed > 0) notes.push(`${input.hintsUsed} hint${input.hintsUsed === 1 ? '' : 's'} used`);
  if (input.priorAttempts > 0) notes.push(`${input.priorAttempts + 1} attempts`);

  return {
    amount,
    sourceType: input.isOptional ? 'bonus' : 'exercise',
    sourceId: input.exerciseId,
    reason: notes.length > 0 ? `Exercise passed (${notes.join(', ')})` : 'Exercise passed first time',
  };
}

export interface LessonXpInput {
  lessonId: string;
  baseXp: number;
  alreadyAwarded: boolean;
}

export function lessonXp(input: LessonXpInput): XpAward | null {
  if (input.alreadyAwarded) return null;
  return {
    amount: input.baseXp,
    sourceType: 'lesson',
    sourceId: input.lessonId,
    reason: 'Lesson completed',
  };
}

export interface QuizXpInput {
  questionId: string;
  baseXp: number;
  isCorrect: boolean;
  /** Correct on the first try earns full XP; a later correction earns half. */
  isFirstAttempt: boolean;
  alreadyAwarded: boolean;
}

export function quizXp(input: QuizXpInput): XpAward | null {
  if (input.alreadyAwarded || !input.isCorrect) return null;
  const amount = input.isFirstAttempt ? input.baseXp : Math.max(2, Math.round(input.baseXp * 0.5));
  return {
    amount,
    sourceType: 'quiz',
    sourceId: input.questionId,
    reason: input.isFirstAttempt ? 'Knowledge check answered correctly' : 'Knowledge check corrected',
  };
}

export interface AssessmentXpInput {
  assessmentId: string;
  baseXp: number;
  score: number;
  passed: boolean;
  alreadyAwarded: boolean;
}

export function assessmentXp(input: AssessmentXpInput): XpAward | null {
  if (input.alreadyAwarded || !input.passed) return null;
  // A pass at the threshold earns the base award; a perfect score earns 1.25×.
  const bonus = 1 + Math.max(0, input.score - 0.75) * 1;
  return {
    amount: Math.round(input.baseXp * Math.min(1.25, bonus)),
    sourceType: 'assessment',
    sourceId: input.assessmentId,
    reason: `Milestone assessment passed with ${Math.round(input.score * 100)}%`,
  };
}

export function achievementXp(
  achievementId: string,
  baseXp: number,
  alreadyAwarded: boolean,
): XpAward | null {
  if (alreadyAwarded) return null;
  return {
    amount: baseXp,
    sourceType: 'achievement',
    sourceId: achievementId,
    reason: 'Achievement unlocked',
  };
}

/**
 * A once-per-milestone streak bonus. The `sourceId` is the streak length, so
 * reaching seven days awards once and only once, however many times the
 * dashboard is refreshed.
 */
const STREAK_MILESTONES = [3, 7, 14, 21, 30, 60, 100];

export function streakXp(streakDays: number, alreadyAwardedFor: Set<number>): XpAward | null {
  // Ascending, so milestones arrive in the order they were earned: a learner
  // whose first sync happens on day seven sees "3-day streak" before
  // "7-day streak" on their next visit, which reads correctly.
  const milestone = STREAK_MILESTONES.find((m) => streakDays >= m && !alreadyAwardedFor.has(m));
  if (milestone === undefined) return null;
  return {
    amount: milestone * 5,
    sourceType: 'streak',
    sourceId: `streak-${milestone}`,
    reason: `${milestone}-day learning streak`,
  };
}

// ---------------------------------------------------------------------------
// Learner-facing level curve
// ---------------------------------------------------------------------------

/**
 * XP needed to *reach* a given learner level. Growth is gentle early (so a
 * beginner sees movement in their first session) and steepens later.
 */
export function xpForLevel(level: number): number {
  if (level <= 1) return 0;
  return Math.round(120 * (level - 1) ** 1.55);
}

export interface LearnerLevel {
  level: number;
  currentLevelXp: number;
  nextLevelXp: number;
  xpIntoLevel: number;
  xpToNextLevel: number;
  progress: number;
}

export function learnerLevel(totalXp: number): LearnerLevel {
  const xp = Math.max(0, totalXp);
  let level = 1;
  while (xpForLevel(level + 1) <= xp && level < 99) level += 1;

  const currentLevelXp = xpForLevel(level);
  const nextLevelXp = xpForLevel(level + 1);
  const span = Math.max(1, nextLevelXp - currentLevelXp);
  const xpIntoLevel = xp - currentLevelXp;

  return {
    level,
    currentLevelXp,
    nextLevelXp,
    xpIntoLevel,
    xpToNextLevel: Math.max(0, nextLevelXp - xp),
    progress: Math.min(1, xpIntoLevel / span),
  };
}
