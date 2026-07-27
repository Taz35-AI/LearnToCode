/**
 * Composing a review session — interleaving and deliberate practice.
 *
 * The scheduler decides *when* an item should come back. This module decides
 * *which* items make up a session and, just as importantly, *in what order*.
 *
 * ## Why order is not cosmetic
 *
 * Blocked practice — all the list questions, then all the link questions —
 * produces faster performance during the session and worse retention
 * afterwards. Interleaved practice feels harder and measurably outperforms it
 * on delayed tests, because mixing forces the learner to first work out *which*
 * approach applies, which is the discrimination the real task actually demands.
 * A learner who has only ever practised links in a block labelled "links" has
 * never once had to notice that a problem is about links.
 *
 * So this module deliberately spreads a session across skills even though a
 * skill-ordered session would feel tidier and score better in the moment.
 *
 * ## What a session is made of
 *
 * Three sources, in priority order:
 *
 * 1. **Due items** — the scheduler says memory has decayed to the useful edge.
 * 2. **Weak skills** — deliberate practice aimed at demonstrated weakness
 *    rather than at whatever comes next.
 * 3. **Cross-level resurfacing** — older material pulled forward into newer
 *    work, so Level 2 does not quietly rot while the learner is in Level 7.
 *
 * Everything here is a pure function of its arguments, including the date and
 * the shuffle seed, so a session can be asserted exactly in a test.
 */

import { isDue, overdueFactor, type ReviewCard } from './scheduler';

export type ReviewItemKind = 'question' | 'exercise' | 'recall_prompt';

export interface ReviewCandidate {
  /** Stable identifier of the underlying question or exercise. */
  itemId: string;
  kind: ReviewItemKind;
  skillSlug: string;
  /** Which level the item was first taught in — drives cross-level resurfacing. */
  levelOrdinal: number;
  moduleSlug: string;
  lessonSlug: string;
  /** 1 (easiest) to 5, as authored. */
  difficulty: number;
  card: ReviewCard;
}

export interface SessionOptions {
  /** ISO date the session is being composed for. */
  today: string;
  /** Hard ceiling on session length, to keep cognitive load manageable. */
  maxItems: number;
  /**
   * Most consecutive items allowed from one skill. 1 means perfect
   * interleaving wherever the mix permits it.
   */
  maxConsecutivePerSkill: number;
  /** Skills the learner has demonstrably not mastered. */
  weakSkills: ReadonlySet<string>;
  /** The level the learner is currently working in. */
  currentLevel: number;
  /** Seed for the deterministic shuffle. */
  seed: string;
}

export const DEFAULT_SESSION_OPTIONS: Pick<
  SessionOptions,
  'maxItems' | 'maxConsecutivePerSkill'
> = {
  // Twenty is long enough to be worth starting and short enough to finish.
  // A queue the learner abandons halfway is worse than a shorter one, because
  // the unreviewed remainder decays while appearing to be "in progress".
  maxItems: 20,
  maxConsecutivePerSkill: 1,
};

/** Deterministic 32-bit hash, so sessions are reproducible and testable. */
function hashString(value: string): number {
  let hash = 2166136261;
  for (let i = 0; i < value.length; i += 1) {
    hash ^= value.charCodeAt(i);
    hash = Math.imul(hash, 16777619) >>> 0;
  }
  return hash >>> 0;
}

export interface ScoredCandidate {
  candidate: ReviewCandidate;
  score: number;
  /** Why this item was selected — surfaced to the learner, not just logged. */
  reason: 'due' | 'overdue' | 'weak-skill' | 'resurfaced';
}

/**
 * Scores one candidate for inclusion.
 *
 * Higher is more urgent. The weighting is deliberate: an item whose memory has
 * actually decayed beats an item merely associated with a weak skill, because
 * the first is evidence and the second is inference.
 */
export function scoreCandidate(
  candidate: ReviewCandidate,
  options: SessionOptions,
): ScoredCandidate | null {
  const due = isDue(candidate.card, options.today);
  const weak = options.weakSkills.has(candidate.skillSlug);
  const older = candidate.levelOrdinal < options.currentLevel;

  if (!due && !weak && !older) return null;

  let score = 0;
  let reason: ScoredCandidate['reason'] = 'due';

  if (due) {
    const overdue = overdueFactor(candidate.card, options.today);
    // An unseen or never-scheduled item returns Infinity; treat it as merely
    // due so that one new item cannot monopolise the front of the session.
    const bounded = Number.isFinite(overdue) ? overdue : 1;
    score += 100 + Math.min(bounded, 10) * 20;
    reason = bounded > 1.5 ? 'overdue' : 'due';
  }

  if (weak) {
    score += 60;
    if (!due) reason = 'weak-skill';
  }

  if (older) {
    // Distance matters: material from six levels back is closer to being lost
    // than material from one level back.
    const distance = options.currentLevel - candidate.levelOrdinal;
    score += Math.min(distance, 6) * 8;
    if (!due && !weak) reason = 'resurfaced';
  }

  // Harder items are worth slightly more of a limited session.
  score += candidate.difficulty * 2;

  return { candidate, score, reason };
}

/**
 * Reorders a scored list so consecutive items rarely share a skill.
 *
 * Greedy: repeatedly take the highest-scoring item whose skill has not just
 * been used. If every remaining item shares the blocked skill, the constraint
 * is relaxed rather than dropping items — a shorter session would cost more
 * than an imperfectly interleaved one.
 */
export function interleaveBySkill(
  scored: ScoredCandidate[],
  maxConsecutivePerSkill: number,
): ScoredCandidate[] {
  const remaining = [...scored];
  const ordered: ScoredCandidate[] = [];

  let lastSkill: string | null = null;
  let runLength = 0;

  while (remaining.length > 0) {
    let pickIndex = remaining.findIndex(
      (item) =>
        item.candidate.skillSlug !== lastSkill || runLength < maxConsecutivePerSkill,
    );

    // Only one skill left in the queue — take it rather than truncate.
    if (pickIndex === -1) pickIndex = 0;

    const [picked] = remaining.splice(pickIndex, 1);
    if (!picked) break;

    if (picked.candidate.skillSlug === lastSkill) {
      runLength += 1;
    } else {
      lastSkill = picked.candidate.skillSlug;
      runLength = 1;
    }

    ordered.push(picked);
  }

  return ordered;
}

/**
 * Builds the review session.
 *
 * Selection is by score; ordering is by interleaving. Doing it in that order
 * matters — interleaving first and then truncating would drop urgent items in
 * favour of variety, which gets the priority exactly backwards.
 */
export function composeReviewSession(
  candidates: readonly ReviewCandidate[],
  options: SessionOptions,
): ScoredCandidate[] {
  const scored = candidates
    .map((candidate) => scoreCandidate(candidate, options))
    .filter((entry): entry is ScoredCandidate => entry !== null)
    .sort((a, b) => {
      if (b.score !== a.score) return b.score - a.score;
      // Deterministic tie-break, so two runs never differ.
      return hashString(a.candidate.itemId + options.seed) -
        hashString(b.candidate.itemId + options.seed);
    });

  const selected = scored.slice(0, Math.max(0, options.maxItems));
  return interleaveBySkill(selected, Math.max(1, options.maxConsecutivePerSkill));
}

/**
 * Options for the lesson warm-up.
 *
 * Deliberately its own type rather than a subset of `SessionOptions`: sharing
 * that type let a caller pass a full session's item ceiling and turn a
 * three-question warm-up into a twenty-question quiz standing between the
 * learner and the lesson.
 */
export interface WarmUpOptions {
  today: string;
  weakSkills: ReadonlySet<string>;
  currentLevel: number;
  seed: string;
  /** Defaults to three, and cannot exceed `MAX_WARM_UP_SIZE`. */
  size?: number;
}

/** Enough to prime the lesson; few enough that it is not itself the work. */
export const DEFAULT_WARM_UP_SIZE = 3;
export const MAX_WARM_UP_SIZE = 5;

/**
 * The short retrieval-practice set that opens a lesson.
 *
 * Every lesson begins by pulling prior material back out of memory rather than
 * restating it. Re-reading produces a strong feeling of knowing and very little
 * retention; a failed attempt to recall, followed by the answer, produces the
 * opposite. This is why lessons open with questions the learner may well get
 * wrong — the discomfort is the mechanism, not a side effect.
 *
 * Drawn only from skills the lesson actually builds on, so the warm-up primes
 * the lesson rather than being a general quiz.
 */
export function composeLessonWarmUp(
  candidates: readonly ReviewCandidate[],
  prerequisiteSkills: readonly string[],
  options: WarmUpOptions,
): ScoredCandidate[] {
  const relevant = new Set(prerequisiteSkills);
  const eligible = candidates.filter((c) => relevant.has(c.skillSlug));

  return composeReviewSession(eligible, {
    today: options.today,
    weakSkills: options.weakSkills,
    currentLevel: options.currentLevel,
    seed: options.seed,
    maxItems: Math.min(options.size ?? DEFAULT_WARM_UP_SIZE, MAX_WARM_UP_SIZE),
    maxConsecutivePerSkill: 1,
  });
}

export interface ReviewForecastDay {
  date: string;
  dueCount: number;
}

/**
 * How many items fall due over the coming days.
 *
 * Shown to the learner so review never arrives as an unexplained pile. Seeing
 * that tomorrow holds four items and next week holds nine is what makes a queue
 * feel finite.
 */
export function reviewForecast(
  candidates: readonly ReviewCandidate[],
  fromDate: string,
  days: number,
): ReviewForecastDay[] {
  const counts = new Map<string, number>();

  for (const candidate of candidates) {
    const due = candidate.card.dueOn ?? fromDate;
    counts.set(due, (counts.get(due) ?? 0) + 1);
  }

  const forecast: ReviewForecastDay[] = [];
  const start = Date.parse(`${fromDate}T00:00:00Z`);

  for (let offset = 0; offset < days; offset += 1) {
    const date = new Date(start + offset * 86_400_000).toISOString().slice(0, 10);
    let dueCount = counts.get(date) ?? 0;

    // Everything already overdue lands on the first day of the forecast.
    if (offset === 0) {
      for (const [dueDate, count] of counts) {
        if (dueDate < fromDate) dueCount += count;
      }
    }

    forecast.push({ date, dueCount });
  }

  return forecast;
}

/** Count of items that would appear in a session right now. */
export function dueNowCount(
  candidates: readonly ReviewCandidate[],
  today: string,
): number {
  return candidates.filter((c) => isDue(c.card, today)).length;
}
