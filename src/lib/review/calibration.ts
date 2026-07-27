/**
 * Metacognitive calibration — measuring how well the learner knows what they
 * know.
 *
 * ## The problem this exists to solve
 *
 * The single most expensive mistake a self-taught learner makes is stopping too
 * early, and they stop because material *feels* familiar. Re-reading, watching,
 * and following along all produce a strong sense of understanding while
 * producing very little durable knowledge. That gap — fluency mistaken for
 * mastery — is why someone can nod through a whole tutorial and then face a
 * blank editor with nothing to write.
 *
 * The intervention is not to tell learners this. It is to *show* them, using
 * their own numbers: ask how confident they are before revealing the answer,
 * then put the prediction and the outcome side by side. A learner who sees "you
 * were certain on eleven questions and wrong on four of them" recalibrates in a
 * way that no amount of advice achieves.
 *
 * ## What is measured
 *
 * - **Bias** — do stated confidences run above or below actual accuracy?
 * - **Brier score** — the standard measure of probabilistic forecast accuracy,
 *   so calibration can improve measurably rather than impressionistically.
 * - **Blind spots** — skills where confidence is high and accuracy is not.
 *   These are the highest-value thing the app can point at, because by
 *   definition the learner would never choose to practise them.
 *
 * Every function is pure and takes its inputs explicitly.
 */

/**
 * How sure the learner says they are, asked *before* the answer is revealed.
 *
 * Four levels, not a slider: fine-grained self-report is noise, and four is
 * enough to separate a guess from a certainty. The wording matters as much as
 * the number, which is why it lives here beside the value.
 */
export type ConfidenceRating = 1 | 2 | 3 | 4;

export const CONFIDENCE_LABELS: Record<ConfidenceRating, string> = {
  1: 'Guessing',
  2: 'Not sure',
  3: 'Fairly sure',
  4: 'Certain',
};

/**
 * The probability of being right that each rating claims.
 *
 * A guess on a four-option question is right about a quarter of the time, so
 * that is where the scale starts. "Certain" is 0.95 rather than 1.0 because a
 * forecast of absolute certainty cannot be scored — and because nobody is.
 */
export const CONFIDENCE_PROBABILITY: Record<ConfidenceRating, number> = {
  1: 0.25,
  2: 0.5,
  3: 0.75,
  4: 0.95,
};

export interface CalibrationPoint {
  confidence: ConfidenceRating;
  correct: boolean;
  skillSlug: string;
}

export interface ConfidenceBucket {
  confidence: ConfidenceRating;
  label: string;
  /** What this rating claims. */
  claimedAccuracy: number;
  /** What actually happened. */
  actualAccuracy: number;
  count: number;
  correctCount: number;
}

export type CalibrationVerdict =
  | 'insufficient-evidence'
  | 'well-calibrated'
  | 'overconfident'
  | 'underconfident';

export interface CalibrationReport {
  totalAnswers: number;
  /**
   * Mean claimed probability minus actual accuracy.
   *
   * Positive means overconfident — the learner believes more than they can do,
   * which is the direction that causes people to stop revising too soon.
   */
  bias: number;
  /** Mean squared error of the confidence forecasts. Lower is better. */
  brierScore: number;
  verdict: CalibrationVerdict;
  buckets: ConfidenceBucket[];
  /**
   * Answers the learner was certain about and got wrong.
   *
   * The most useful number in the report: these are beliefs actively held and
   * actively false, and nothing else in the application can find them.
   */
  confidentMistakes: number;
  /** Answers the learner got right while claiming to be guessing. */
  unrecognisedKnowledge: number;
}

/** Below this there is not enough evidence to say anything honest. */
export const MIN_ANSWERS_FOR_CALIBRATION = 8;

/** Bias within this band is not worth reporting as miscalibration. */
export const CALIBRATION_TOLERANCE = 0.1;

const ALL_RATINGS: ConfidenceRating[] = [1, 2, 3, 4];

/**
 * Builds the calibration report.
 *
 * Returns an honest "not enough evidence yet" rather than computing a
 * confident-looking figure from four answers. Telling a learner they are
 * overconfident on the basis of a handful of questions would be exactly the
 * error the report exists to correct.
 */
export function calibrationReport(points: readonly CalibrationPoint[]): CalibrationReport {
  const buckets: ConfidenceBucket[] = ALL_RATINGS.map((rating) => {
    const inBucket = points.filter((p) => p.confidence === rating);
    const correctCount = inBucket.filter((p) => p.correct).length;
    return {
      confidence: rating,
      label: CONFIDENCE_LABELS[rating],
      claimedAccuracy: CONFIDENCE_PROBABILITY[rating],
      actualAccuracy: inBucket.length === 0 ? 0 : correctCount / inBucket.length,
      count: inBucket.length,
      correctCount,
    };
  });

  const total = points.length;

  if (total === 0) {
    return {
      totalAnswers: 0,
      bias: 0,
      brierScore: 0,
      verdict: 'insufficient-evidence',
      buckets,
      confidentMistakes: 0,
      unrecognisedKnowledge: 0,
    };
  }

  const claimedSum = points.reduce((sum, p) => sum + CONFIDENCE_PROBABILITY[p.confidence], 0);
  const correctSum = points.reduce((sum, p) => sum + (p.correct ? 1 : 0), 0);
  const bias = claimedSum / total - correctSum / total;

  const brierScore =
    points.reduce((sum, p) => {
      const forecast = CONFIDENCE_PROBABILITY[p.confidence];
      const outcome = p.correct ? 1 : 0;
      return sum + (forecast - outcome) ** 2;
    }, 0) / total;

  let verdict: CalibrationVerdict;
  if (total < MIN_ANSWERS_FOR_CALIBRATION) verdict = 'insufficient-evidence';
  else if (bias > CALIBRATION_TOLERANCE) verdict = 'overconfident';
  else if (bias < -CALIBRATION_TOLERANCE) verdict = 'underconfident';
  else verdict = 'well-calibrated';

  return {
    totalAnswers: total,
    bias,
    brierScore,
    verdict,
    buckets,
    confidentMistakes: points.filter((p) => p.confidence === 4 && !p.correct).length,
    unrecognisedKnowledge: points.filter((p) => p.confidence === 1 && p.correct).length,
  };
}

export interface SkillBlindSpot {
  skillSlug: string;
  /** Mean claimed probability across answers in this skill. */
  claimedAccuracy: number;
  actualAccuracy: number;
  /** How far belief exceeds ability. Larger is more dangerous. */
  gap: number;
  answers: number;
}

/** Fewer answers than this in one skill is noise, not a blind spot. */
export const MIN_ANSWERS_PER_SKILL = 4;

/**
 * Finds the skills where the learner believes most and delivers least.
 *
 * These deserve to be surfaced above ordinary weak skills. A skill the learner
 * knows is weak will get attention anyway; a skill they wrongly believe is
 * solid will not, and it is the one that will fail them later.
 */
export function blindSpots(
  points: readonly CalibrationPoint[],
  minimumGap = CALIBRATION_TOLERANCE,
): SkillBlindSpot[] {
  const bySkill = new Map<string, CalibrationPoint[]>();

  for (const point of points) {
    const existing = bySkill.get(point.skillSlug);
    if (existing) existing.push(point);
    else bySkill.set(point.skillSlug, [point]);
  }

  const spots: SkillBlindSpot[] = [];

  for (const [skillSlug, skillPoints] of bySkill) {
    if (skillPoints.length < MIN_ANSWERS_PER_SKILL) continue;

    const claimedAccuracy =
      skillPoints.reduce((sum, p) => sum + CONFIDENCE_PROBABILITY[p.confidence], 0) /
      skillPoints.length;
    const actualAccuracy =
      skillPoints.filter((p) => p.correct).length / skillPoints.length;
    const gap = claimedAccuracy - actualAccuracy;

    if (gap > minimumGap) {
      spots.push({
        skillSlug,
        claimedAccuracy,
        actualAccuracy,
        gap,
        answers: skillPoints.length,
      });
    }
  }

  // Worst gap first, then alphabetically so the order never wobbles between
  // two skills that happen to tie.
  return spots.sort((a, b) => b.gap - a.gap || a.skillSlug.localeCompare(b.skillSlug));
}

/**
 * A plain-English reading of the report, addressed to the learner.
 *
 * Kept here beside the maths so the wording cannot drift away from what the
 * numbers actually say — and phrased as an observation rather than a telling
 * off, because the point is to change study behaviour, not to score the
 * learner.
 */
export function calibrationMessage(report: CalibrationReport): string {
  if (report.verdict === 'insufficient-evidence') {
    return `Answer a few more questions with a confidence rating and this will tell you how well your sense of "I know this" matches your results.`;
  }

  if (report.verdict === 'overconfident') {
    const detail =
      report.confidentMistakes > 0
        ? ` You were certain on ${report.confidentMistakes} answer${report.confidentMistakes === 1 ? '' : 's'} that turned out wrong.`
        : '';
    return `Your confidence runs ahead of your results.${detail} That is worth knowing: feeling familiar with something is not the same as being able to do it, and it is the usual reason people stop practising too early.`;
  }

  if (report.verdict === 'underconfident') {
    const detail =
      report.unrecognisedKnowledge > 0
        ? ` You marked ${report.unrecognisedKnowledge} answer${report.unrecognisedKnowledge === 1 ? '' : 's'} as guesses and got ${report.unrecognisedKnowledge === 1 ? 'it' : 'them'} right.`
        : '';
    return `You know more than you think.${detail} Trust the working — hesitating on things you can actually do costs you time.`;
  }

  return `Your sense of what you know matches your results closely. That is a genuinely useful skill: it means you can trust your own judgement about what still needs practice.`;
}
