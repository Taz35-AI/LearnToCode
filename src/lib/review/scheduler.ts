/**
 * Spaced repetition — FSRS (Free Spaced Repetition Scheduler), v4.5 formulation.
 *
 * ## Why a real algorithm rather than "practise what looks weak"
 *
 * The application already tracks skill mastery as a weighted moving average,
 * and that is the right tool for deciding what a learner is ready to *unlock*.
 * It is the wrong tool for deciding *when to ask again*, because it has no
 * model of forgetting: it knows you were right, not how long that will last.
 *
 * FSRS models memory with three quantities:
 *
 * - **Stability (S)** — days until the chance of recalling the item falls to
 *   90%. This is memory strength expressed in time.
 * - **Difficulty (D)** — 1 to 10, how hard *this* learner finds *this* item.
 *   Harder items gain stability more slowly.
 * - **Retrievability (R)** — the probability of recall right now, which decays
 *   as time passes since the last review.
 *
 * The scheduling insight, from the spacing and testing-effect literature, is
 * that a review is worth most when it is *hard but still successful* — recalled
 * at around 90% probability rather than 100%. Reviewing while retrievability is
 * still near 1 wastes the learner's time and strengthens almost nothing.
 * Reviewing after it has collapsed means relearning from scratch. Scheduling
 * each item for the day its retrievability reaches the target keeps every
 * review near that useful edge.
 *
 * ## Determinism and time
 *
 * Every function here takes the current time as an argument. Nothing reads the
 * clock. This mirrors `evaluateModuleGate`, which takes no clock either, and it
 * is what makes the behaviour testable: a review a year from now can be
 * asserted exactly.
 */

/**
 * How the learner did on a single review.
 *
 * These four grades are the standard FSRS input. They are deliberately not
 * "right/wrong": whether a correct answer came instantly or after a struggle
 * carries real information about memory strength, and collapsing it away makes
 * the schedule markedly worse.
 */
export type ReviewGrade = 1 | 2 | 3 | 4;

export const GRADE_AGAIN: ReviewGrade = 1;
export const GRADE_HARD: ReviewGrade = 2;
export const GRADE_GOOD: ReviewGrade = 3;
export const GRADE_EASY: ReviewGrade = 4;

/** Where an item sits in its lifecycle. */
export type ReviewCardState = 'new' | 'learning' | 'review' | 'relearning';

export interface ReviewCard {
  /** Days until recall probability falls to the target. 0 for an unseen item. */
  stability: number;
  /** 1 (trivial) to 10 (very hard) for this learner. */
  difficulty: number;
  /** Total reviews, successful or not. */
  reps: number;
  /** Times the learner failed to recall it after previously knowing it. */
  lapses: number;
  state: ReviewCardState;
  /** ISO date of the last review, or null if never reviewed. */
  lastReviewedOn: string | null;
  /** ISO date this item is next due. Null means "as soon as possible". */
  dueOn: string | null;
}

/**
 * The published FSRS-4.5 default weights.
 *
 * These come from fitting the model against a very large corpus of real review
 * histories, so they are a far better starting point than anything hand-picked.
 * They are exposed as a parameter rather than hard-coded so that the schedule
 * can later be fitted to one learner's own history without touching this logic.
 */
export const FSRS_DEFAULT_WEIGHTS: readonly number[] = [
  0.4872, 1.4003, 3.7145, 13.8206, 5.1618, 1.2298, 0.8975, 0.031, 1.6474,
  0.1367, 1.0461, 2.1072, 0.0793, 0.3246, 1.587, 0.2272, 2.8755,
];

/** Curve constants for the forgetting function. Not tunable per learner. */
const DECAY = -0.5;
const FACTOR = 19 / 81;

/** Aim to review when recall probability has fallen to this. */
export const DEFAULT_REQUEST_RETENTION = 0.9;

/** Beyond this the schedule is guesswork, so cap it. */
export const MAX_INTERVAL_DAYS = 365 * 2;

export interface SchedulerParams {
  weights: readonly number[];
  requestRetention: number;
  maximumIntervalDays: number;
}

export const DEFAULT_PARAMS: SchedulerParams = {
  weights: FSRS_DEFAULT_WEIGHTS,
  requestRetention: DEFAULT_REQUEST_RETENTION,
  maximumIntervalDays: MAX_INTERVAL_DAYS,
};

const clamp = (value: number, low: number, high: number): number =>
  Math.min(high, Math.max(low, value));

/** Reads a weight by index, tolerating a short array rather than throwing. */
const w = (params: SchedulerParams, index: number): number =>
  params.weights[index] ?? (FSRS_DEFAULT_WEIGHTS[index] as number);

/** An item the learner has never seen. */
export function newCard(): ReviewCard {
  return {
    stability: 0,
    difficulty: 0,
    reps: 0,
    lapses: 0,
    state: 'new',
    lastReviewedOn: null,
    dueOn: null,
  };
}

/**
 * Probability of recalling the item after `elapsedDays`.
 *
 * The curve is R = (1 + FACTOR · t/S)^DECAY — a power law, not an exponential.
 * Power-law forgetting fits human data better: memories decay quickly at first
 * and then far more slowly, which is exactly why expanding intervals work.
 */
export function retrievability(stability: number, elapsedDays: number): number {
  if (stability <= 0) return 0;
  const elapsed = Math.max(0, elapsedDays);
  return Math.pow(1 + (FACTOR * elapsed) / stability, DECAY);
}

/** Days from now until recall probability falls to the target retention. */
export function intervalFromStability(
  stability: number,
  params: SchedulerParams = DEFAULT_PARAMS,
): number {
  if (stability <= 0) return 0;
  const raw = (stability / FACTOR) * (Math.pow(params.requestRetention, 1 / DECAY) - 1);
  return clamp(Math.round(raw), 1, params.maximumIntervalDays);
}

/** Stability given to an item the first time it is answered. */
function initialStability(grade: ReviewGrade, params: SchedulerParams): number {
  return Math.max(0.1, w(params, grade - 1));
}

/** Difficulty given to an item the first time it is answered. */
function initialDifficulty(grade: ReviewGrade, params: SchedulerParams): number {
  return clamp(w(params, 4) - Math.exp(w(params, 5) * (grade - 1)) + 1, 1, 10);
}

/**
 * Difficulty after a review, pulled gently back toward the mean.
 *
 * Without that pull, one bad day would mark an item permanently hard. The
 * reversion term is what stops difficulty ratcheting.
 */
function nextDifficulty(
  difficulty: number,
  grade: ReviewGrade,
  params: SchedulerParams,
): number {
  const delta = -w(params, 6) * (grade - 3);
  const linear = difficulty + delta * ((10 - difficulty) / 9);
  const reverted = w(params, 7) * initialDifficulty(GRADE_EASY, params) + (1 - w(params, 7)) * linear;
  return clamp(reverted, 1, 10);
}

/**
 * Stability after a *successful* recall.
 *
 * Three effects are encoded, and each is a documented finding rather than a
 * knob: harder items gain less; already-stable items gain proportionally less
 * (diminishing returns); and a success at low retrievability — recall that was
 * genuinely effortful — gains the most. That last term is the spacing effect
 * itself, and it is why the scheduler deliberately waits until recall is hard.
 */
function stabilityAfterRecall(
  stability: number,
  difficulty: number,
  recallProbability: number,
  grade: ReviewGrade,
  params: SchedulerParams,
): number {
  const hardPenalty = grade === GRADE_HARD ? w(params, 15) : 1;
  const easyBonus = grade === GRADE_EASY ? w(params, 16) : 1;

  const growth =
    Math.exp(w(params, 8)) *
    (11 - difficulty) *
    Math.pow(stability, -w(params, 9)) *
    (Math.exp(w(params, 10) * (1 - recallProbability)) - 1) *
    hardPenalty *
    easyBonus;

  return Math.max(0.1, stability * (1 + growth));
}

/**
 * Stability after a lapse — a failure on an item previously known.
 *
 * Note that this is not a reset to zero. Relearning something forgotten is
 * faster than learning it new, and the model reflects that: prior stability
 * still contributes.
 */
function stabilityAfterLapse(
  stability: number,
  difficulty: number,
  recallProbability: number,
  params: SchedulerParams,
): number {
  const next =
    w(params, 11) *
    Math.pow(difficulty, -w(params, 12)) *
    (Math.pow(stability + 1, w(params, 13)) - 1) *
    Math.exp(w(params, 14) * (1 - recallProbability));

  // Never award a lapse more stability than the item already had.
  return clamp(next, 0.1, Math.max(0.1, stability));
}

/** Whole days between two dates, ignoring the time of day. */
export function daysBetween(from: string, to: string): number {
  const start = Date.parse(`${from}T00:00:00Z`);
  const end = Date.parse(`${to}T00:00:00Z`);
  if (Number.isNaN(start) || Number.isNaN(end)) return 0;
  return Math.round((end - start) / 86_400_000);
}

/** The UTC calendar date of an instant, as `YYYY-MM-DD`. */
export function reviewDate(at: Date): string {
  return at.toISOString().slice(0, 10);
}

export function addDaysToDate(date: string, days: number): string {
  const base = Date.parse(`${date}T00:00:00Z`);
  return new Date(base + days * 86_400_000).toISOString().slice(0, 10);
}

export interface ReviewOutcome {
  card: ReviewCard;
  /** Days until the next review. 0 means "again in this same session". */
  intervalDays: number;
  /** Recall probability at the moment of review — how hard it actually was. */
  retrievabilityAtReview: number;
}

/**
 * Apply one review to a card and return its new schedule.
 *
 * `reviewedAt` is passed in rather than read, so a schedule years out can be
 * asserted exactly in a test.
 */
export function reviewCard(
  card: ReviewCard,
  grade: ReviewGrade,
  reviewedAt: Date,
  params: SchedulerParams = DEFAULT_PARAMS,
): ReviewOutcome {
  const today = reviewDate(reviewedAt);
  const firstReview = card.state === 'new' || card.lastReviewedOn === null;

  const elapsedDays = firstReview ? 0 : daysBetween(card.lastReviewedOn as string, today);
  const recallProbability = firstReview ? 0 : retrievability(card.stability, elapsedDays);

  let stability: number;
  let difficulty: number;
  let state: ReviewCardState;
  let lapses = card.lapses;

  if (firstReview) {
    stability = initialStability(grade, params);
    difficulty = initialDifficulty(grade, params);
    state = grade === GRADE_AGAIN ? 'learning' : 'review';
  } else if (grade === GRADE_AGAIN) {
    difficulty = nextDifficulty(card.difficulty, grade, params);
    stability = stabilityAfterLapse(card.stability, difficulty, recallProbability, params);
    state = 'relearning';
    lapses += 1;
  } else {
    difficulty = nextDifficulty(card.difficulty, grade, params);
    stability = stabilityAfterRecall(
      card.stability,
      difficulty,
      recallProbability,
      grade,
      params,
    );
    state = 'review';
  }

  // A failure is re-asked within the same session rather than tomorrow: the
  // learner should not leave having last seen the wrong answer.
  const intervalDays = grade === GRADE_AGAIN ? 0 : intervalFromStability(stability, params);

  return {
    card: {
      stability,
      difficulty,
      reps: card.reps + 1,
      lapses,
      state,
      lastReviewedOn: today,
      dueOn: addDaysToDate(today, intervalDays),
    },
    intervalDays,
    retrievabilityAtReview: recallProbability,
  };
}

/** True when the item is due for review on the given date. */
export function isDue(card: ReviewCard, on: string): boolean {
  if (card.dueOn === null) return true;
  return daysBetween(card.dueOn, on) >= 0;
}

/**
 * How overdue an item is, as a fraction of the interval it was given.
 *
 * Used to order a session: the most decayed item is the most urgent, and
 * ordering by raw due date would let a one-day-late easy item outrank a
 * month-late hard one.
 */
export function overdueFactor(card: ReviewCard, on: string): number {
  if (card.dueOn === null || card.lastReviewedOn === null) return Number.POSITIVE_INFINITY;
  const scheduled = Math.max(1, daysBetween(card.lastReviewedOn, card.dueOn));
  const elapsed = daysBetween(card.lastReviewedOn, on);
  return elapsed / scheduled;
}

/**
 * Translate an exercise or question outcome into a review grade.
 *
 * Correctness alone is not enough — how much help was needed is part of what
 * the schedule is modelling. A first-time clean pass and a pass after four
 * hints are genuinely different memories, and grading them identically would
 * schedule both as if they were secure.
 */
export function gradeFromPerformance(input: {
  correct: boolean;
  hintsUsed: number;
  attempts: number;
}): ReviewGrade {
  if (!input.correct) return GRADE_AGAIN;
  if (input.hintsUsed > 0 || input.attempts > 2) return GRADE_HARD;
  if (input.attempts === 1) return GRADE_EASY;
  return GRADE_GOOD;
}
