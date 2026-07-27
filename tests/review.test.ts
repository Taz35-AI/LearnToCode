import { describe, it, expect } from 'vitest';
import {
  DEFAULT_PARAMS,
  GRADE_AGAIN,
  GRADE_EASY,
  GRADE_GOOD,
  GRADE_HARD,
  MAX_INTERVAL_DAYS,
  addDaysToDate,
  daysBetween,
  gradeFromPerformance,
  intervalFromStability,
  isDue,
  newCard,
  overdueFactor,
  retrievability,
  reviewCard,
  reviewDate,
  type ReviewCard,
} from '@/lib/review/scheduler';
import {
  composeLessonWarmUp,
  composeReviewSession,
  dueNowCount,
  reviewForecast,
  warmUpSkillsFor,
  type ReviewCandidate,
} from '@/lib/review/session';
import {
  blindSpots,
  calibrationMessage,
  calibrationReport,
  type CalibrationPoint,
  type ConfidenceRating,
} from '@/lib/review/calibration';

const at = (iso: string) => new Date(`${iso}T09:00:00Z`);

/** Reviews a fresh card repeatedly with the same grade, advancing to each due date. */
function drill(grade: Parameters<typeof reviewCard>[1], times: number) {
  let card = newCard();
  let date = '2026-01-01';
  const intervals: number[] = [];
  for (let i = 0; i < times; i += 1) {
    const outcome = reviewCard(card, grade, at(date));
    card = outcome.card;
    intervals.push(outcome.intervalDays);
    date = addDaysToDate(date, Math.max(1, outcome.intervalDays));
  }
  return { card, intervals };
}

describe('forgetting curve', () => {
  it('is certain immediately after a review', () => {
    expect(retrievability(10, 0)).toBeCloseTo(1, 10);
  });

  it('reaches the 90% target after exactly one stability period', () => {
    // This is the definition of stability, so it is the load-bearing property:
    // if this drifts, every interval the scheduler produces is wrong.
    expect(retrievability(10, 10)).toBeCloseTo(0.9, 6);
    expect(retrievability(37, 37)).toBeCloseTo(0.9, 6);
  });

  it('decays monotonically and never reaches zero', () => {
    const points = [0, 1, 7, 30, 365, 3650].map((d) => retrievability(10, d));
    for (let i = 1; i < points.length; i += 1) {
      expect(points[i]!).toBeLessThan(points[i - 1]!);
    }
    expect(points.at(-1)!).toBeGreaterThan(0);
  });

  it('decays more slowly for a more stable memory', () => {
    expect(retrievability(100, 30)).toBeGreaterThan(retrievability(10, 30));
  });

  it('treats an unseen item as unrecallable', () => {
    expect(retrievability(0, 0)).toBe(0);
  });
});

describe('interval from stability', () => {
  it('is approximately the stability itself at 90% requested retention', () => {
    expect(intervalFromStability(10)).toBe(10);
    expect(intervalFromStability(100)).toBe(100);
  });

  it('shortens when higher retention is demanded', () => {
    const strict = intervalFromStability(100, { ...DEFAULT_PARAMS, requestRetention: 0.97 });
    expect(strict).toBeLessThan(intervalFromStability(100));
  });

  it('never returns less than a day for a known item, and is capped', () => {
    expect(intervalFromStability(0.01)).toBe(1);
    expect(intervalFromStability(10_000)).toBe(MAX_INTERVAL_DAYS);
  });
});

describe('first review of a new item', () => {
  it('schedules roughly four days after a clean recall', () => {
    const { card, intervalDays } = reviewCard(newCard(), GRADE_GOOD, at('2026-01-01'));
    expect(intervalDays).toBe(4);
    expect(card.dueOn).toBe('2026-01-05');
    expect(card.state).toBe('review');
    expect(card.reps).toBe(1);
    expect(card.lapses).toBe(0);
  });

  it('re-asks within the same session when the learner could not recall it', () => {
    const { card, intervalDays } = reviewCard(newCard(), GRADE_AGAIN, at('2026-01-01'));
    // Leaving the session with the wrong answer as the last thing seen is the
    // one outcome worth avoiding, so a failure is never deferred to tomorrow.
    expect(intervalDays).toBe(0);
    expect(card.dueOn).toBe('2026-01-01');
    expect(card.state).toBe('learning');
  });

  it('spaces the four grades in the order a learner would expect', () => {
    const days = ([GRADE_AGAIN, GRADE_HARD, GRADE_GOOD, GRADE_EASY] as const).map(
      (g) => reviewCard(newCard(), g, at('2026-01-01')).intervalDays,
    );
    expect(days[0]).toBeLessThan(days[1]!);
    expect(days[1]).toBeLessThan(days[2]!);
    expect(days[2]).toBeLessThan(days[3]!);
  });

  it('records an easy item as less difficult than a hard one', () => {
    const easy = reviewCard(newCard(), GRADE_EASY, at('2026-01-01')).card;
    const hard = reviewCard(newCard(), GRADE_HARD, at('2026-01-01')).card;
    expect(easy.difficulty).toBeLessThan(hard.difficulty);
  });
});

describe('repeated successful review', () => {
  it('expands the interval every time until it reaches the cap', () => {
    const { intervals } = drill(GRADE_GOOD, 8);
    for (let i = 1; i < intervals.length; i += 1) {
      const previous = intervals[i - 1]!;
      const current = intervals[i]!;
      // Growth is strict right up to the ceiling, and flat at it — an interval
      // must never shrink after a success.
      if (previous < MAX_INTERVAL_DAYS) expect(current).toBeGreaterThan(previous);
      else expect(current).toBe(MAX_INTERVAL_DAYS);
    }
  });

  it('answering well consistently reaches the cap rather than crawling', () => {
    // Well-known material should stop consuming review time. If a learner who
    // always answers correctly still sees an item monthly forever, the
    // scheduler is wasting the time it exists to save.
    expect(drill(GRADE_GOOD, 8).intervals.at(-1)).toBe(MAX_INTERVAL_DAYS);
  });

  it('reaches a genuinely long interval rather than plateauing weekly', () => {
    const { intervals } = drill(GRADE_GOOD, 8);
    expect(intervals.at(-1)!).toBeGreaterThan(180);
  });

  it('expands faster for easy items than for hard ones', () => {
    expect(drill(GRADE_EASY, 5).intervals.at(-1)!).toBeGreaterThan(
      drill(GRADE_HARD, 5).intervals.at(-1)!,
    );
  });

  it('keeps difficulty inside its bounds however it is drilled', () => {
    for (const grade of [GRADE_AGAIN, GRADE_HARD, GRADE_GOOD, GRADE_EASY] as const) {
      const { card } = drill(grade, 12);
      expect(card.difficulty).toBeGreaterThanOrEqual(1);
      expect(card.difficulty).toBeLessThanOrEqual(10);
    }
  });
});

describe('lapses', () => {
  const wellKnown = (): ReviewCard => drill(GRADE_GOOD, 4).card;

  it('reduces stability without erasing it', () => {
    const before = wellKnown();
    const after = reviewCard(before, GRADE_AGAIN, at('2027-01-01')).card;
    // Relearning something forgotten is faster than learning it new, so a lapse
    // must not reset to zero — but it must cost something.
    expect(after.stability).toBeLessThan(before.stability);
    expect(after.stability).toBeGreaterThan(0);
  });

  it('counts the lapse and moves the item into relearning', () => {
    const after = reviewCard(wellKnown(), GRADE_AGAIN, at('2027-01-01')).card;
    expect(after.lapses).toBe(1);
    expect(after.state).toBe('relearning');
  });

  it('makes the item harder, so it is scheduled more conservatively after', () => {
    const before = wellKnown();
    const after = reviewCard(before, GRADE_AGAIN, at('2027-01-01')).card;
    expect(after.difficulty).toBeGreaterThan(before.difficulty);
  });
});

describe('the spacing effect is actually implemented', () => {
  it('rewards a hard-won recall more than an easy one', () => {
    // The central claim of the whole module: reviewing while the memory is
    // still fresh gains little, and waiting until recall is effortful gains
    // more. If this ever inverts, the scheduler is worse than doing nothing.
    const card = drill(GRADE_GOOD, 3).card;
    const due = card.dueOn as string;

    const reviewedEarly = reviewCard(card, GRADE_GOOD, at(addDaysToDate(due, -20)));
    const reviewedLate = reviewCard(card, GRADE_GOOD, at(due));

    expect(reviewedLate.retrievabilityAtReview).toBeLessThan(
      reviewedEarly.retrievabilityAtReview,
    );
    expect(reviewedLate.card.stability).toBeGreaterThan(reviewedEarly.card.stability);
  });
});

describe('determinism', () => {
  it('depends only on its arguments, never on the wall clock', () => {
    const card = drill(GRADE_GOOD, 3).card;
    const first = reviewCard(card, GRADE_GOOD, at('2030-06-01'));
    const second = reviewCard(card, GRADE_GOOD, at('2030-06-01'));
    expect(second).toEqual(first);
  });
});

describe('due dates', () => {
  it('treats a never-scheduled item as due now', () => {
    expect(isDue(newCard(), '2026-01-01')).toBe(true);
  });

  it('is due on and after its due date, but not before', () => {
    const card = reviewCard(newCard(), GRADE_GOOD, at('2026-01-01')).card;
    expect(isDue(card, '2026-01-04')).toBe(false);
    expect(isDue(card, '2026-01-05')).toBe(true);
    expect(isDue(card, '2026-02-01')).toBe(true);
  });

  it('ranks a badly overdue item above a barely overdue one', () => {
    const shortInterval = reviewCard(newCard(), GRADE_HARD, at('2026-01-01')).card;
    const longInterval = drill(GRADE_EASY, 4).card;
    // One day late on a two-day interval is a bigger decay than one day late
    // on a six-month one, which raw due dates would get backwards.
    expect(overdueFactor(shortInterval, addDaysToDate(shortInterval.dueOn!, 1))).toBeGreaterThan(
      overdueFactor(longInterval, addDaysToDate(longInterval.dueOn!, 1)),
    );
  });
});

describe('grading from what the learner actually did', () => {
  it('fails an incorrect answer regardless of effort', () => {
    expect(gradeFromPerformance({ correct: true, hintsUsed: 0, attempts: 1 })).toBe(GRADE_EASY);
    expect(gradeFromPerformance({ correct: false, hintsUsed: 0, attempts: 1 })).toBe(GRADE_AGAIN);
  });

  it('separates a clean first pass from one that needed help', () => {
    // Grading these the same would schedule a shaky memory as if it were secure.
    expect(gradeFromPerformance({ correct: true, hintsUsed: 2, attempts: 1 })).toBe(GRADE_HARD);
    expect(gradeFromPerformance({ correct: true, hintsUsed: 0, attempts: 2 })).toBe(GRADE_GOOD);
    expect(gradeFromPerformance({ correct: true, hintsUsed: 0, attempts: 5 })).toBe(GRADE_HARD);
  });
});

describe('date helpers', () => {
  it('counts whole days across month and year boundaries', () => {
    expect(daysBetween('2026-01-01', '2026-01-01')).toBe(0);
    expect(daysBetween('2026-02-28', '2026-03-01')).toBe(1);
    expect(daysBetween('2024-02-28', '2024-03-01')).toBe(2); // leap year
    expect(daysBetween('2026-12-31', '2027-01-01')).toBe(1);
    expect(daysBetween('2026-01-10', '2026-01-01')).toBe(-9);
  });

  it('adds days across boundaries', () => {
    expect(addDaysToDate('2026-12-30', 3)).toBe('2027-01-02');
    expect(addDaysToDate('2024-02-28', 1)).toBe('2024-02-29');
  });

  it('takes the UTC calendar date of an instant', () => {
    expect(reviewDate(new Date('2026-05-04T23:30:00Z'))).toBe('2026-05-04');
  });
});

// ---------------------------------------------------------------------------
// Session composition
// ---------------------------------------------------------------------------

const candidate = (
  itemId: string,
  skillSlug: string,
  overrides: Partial<ReviewCandidate> = {},
): ReviewCandidate => ({
  itemId,
  kind: 'question',
  skillSlug,
  levelOrdinal: 1,
  moduleSlug: 'm',
  lessonSlug: 'l',
  difficulty: 3,
  card: newCard(),
  ...overrides,
});

const baseOptions = {
  today: '2026-06-01',
  maxItems: 20,
  maxConsecutivePerSkill: 1,
  weakSkills: new Set<string>(),
  currentLevel: 1,
  seed: 'seed',
};

/** A card last reviewed `daysAgo`, scheduled `interval` days after that. */
const scheduled = (interval: number, daysAgo: number): ReviewCard => {
  const last = addDaysToDate('2026-06-01', -daysAgo);
  return {
    stability: interval,
    difficulty: 5,
    reps: 3,
    lapses: 0,
    state: 'review',
    lastReviewedOn: last,
    dueOn: addDaysToDate(last, interval),
  };
};

describe('session selection', () => {
  it('includes nothing when there is nothing to do', () => {
    const notDue = candidate('a', 'links', { card: scheduled(30, 1) });
    expect(composeReviewSession([notDue], baseOptions)).toHaveLength(0);
  });

  it('includes due items', () => {
    const due = candidate('a', 'links', { card: scheduled(10, 10) });
    expect(composeReviewSession([due], baseOptions)).toHaveLength(1);
  });

  it('ranks the more decayed item first', () => {
    // Badly overdue beats barely overdue, regardless of original interval.
    const barely = candidate('barely', 'links', { card: scheduled(10, 11) });
    const badly = candidate('badly', 'lists', { card: scheduled(10, 60) });
    const session = composeReviewSession([barely, badly], baseOptions);
    expect(session[0]!.candidate.itemId).toBe('badly');
    expect(session[0]!.reason).toBe('overdue');
  });

  it('pulls in weak skills even when nothing is due', () => {
    const notDue = candidate('a', 'forms', { card: scheduled(30, 1) });
    const session = composeReviewSession([notDue], {
      ...baseOptions,
      weakSkills: new Set(['forms']),
    });
    expect(session).toHaveLength(1);
    expect(session[0]!.reason).toBe('weak-skill');
  });

  it('resurfaces older levels while the learner works in a newer one', () => {
    const old = candidate('old', 'tags', { levelOrdinal: 2, card: scheduled(90, 1) });
    const session = composeReviewSession([old], { ...baseOptions, currentLevel: 7 });
    expect(session).toHaveLength(1);
    expect(session[0]!.reason).toBe('resurfaced');
  });

  it('does not resurface material from the level being studied', () => {
    const current = candidate('cur', 'tags', { levelOrdinal: 7, card: scheduled(90, 1) });
    expect(composeReviewSession([current], { ...baseOptions, currentLevel: 7 })).toHaveLength(0);
  });

  it('prefers evidence of decay over inference from a weak skill', () => {
    // A genuinely due item outranks one merely tagged weak: the first is
    // measured, the second is assumed.
    const weakNotDue = candidate('weak', 'forms', { card: scheduled(30, 1) });
    const due = candidate('due', 'links', { card: scheduled(10, 12) });
    const session = composeReviewSession([weakNotDue, due], {
      ...baseOptions,
      weakSkills: new Set(['forms']),
    });
    expect(session[0]!.candidate.itemId).toBe('due');
  });

  it('respects the session ceiling', () => {
    const many = Array.from({ length: 50 }, (_, i) =>
      candidate(`i${i}`, `skill-${i % 5}`, { card: scheduled(10, 20) }),
    );
    expect(composeReviewSession(many, { ...baseOptions, maxItems: 12 })).toHaveLength(12);
  });

  it('is deterministic for the same inputs', () => {
    const items = Array.from({ length: 20 }, (_, i) =>
      candidate(`i${i}`, `skill-${i % 4}`, { card: scheduled(10, 15) }),
    );
    const a = composeReviewSession(items, baseOptions).map((s) => s.candidate.itemId);
    const b = composeReviewSession(items, baseOptions).map((s) => s.candidate.itemId);
    expect(b).toEqual(a);
  });
});

describe('interleaving', () => {
  it('does not put two items from the same skill back to back', () => {
    const items = ['links', 'links', 'links', 'lists', 'lists', 'forms'].map((skill, i) =>
      candidate(`i${i}`, skill, { card: scheduled(10, 20) }),
    );
    const session = composeReviewSession(items, baseOptions);
    let adjacent = 0;
    for (let i = 1; i < session.length; i += 1) {
      if (session[i]!.candidate.skillSlug === session[i - 1]!.candidate.skillSlug) adjacent += 1;
    }
    // Three of six items share one skill, so a perfect alternation exists.
    expect(adjacent).toBe(0);
  });

  it('keeps every item when only one skill is available rather than truncating', () => {
    // Interleaving is a preference, not a filter: dropping due items to look
    // varied would trade real retention for a cosmetic property.
    const items = Array.from({ length: 5 }, (_, i) =>
      candidate(`i${i}`, 'links', { card: scheduled(10, 20) }),
    );
    expect(composeReviewSession(items, baseOptions)).toHaveLength(5);
  });

  it('never invents or duplicates items', () => {
    const items = Array.from({ length: 9 }, (_, i) =>
      candidate(`i${i}`, `skill-${i % 3}`, { card: scheduled(10, 20) }),
    );
    const ids = composeReviewSession(items, baseOptions).map((s) => s.candidate.itemId);
    expect(new Set(ids).size).toBe(9);
  });
});

describe('lesson warm-up', () => {
  const pool = [
    candidate('prereq', 'tags', { card: scheduled(10, 20) }),
    candidate('unrelated', 'forms', { card: scheduled(10, 20) }),
  ];

  it('draws only from the skills the lesson builds on', () => {
    const warmUp = composeLessonWarmUp(pool, ['tags'], baseOptions);
    expect(warmUp.map((s) => s.candidate.itemId)).toEqual(['prereq']);
  });

  it('stays short enough not to become the lesson', () => {
    const many = Array.from({ length: 12 }, (_, i) =>
      candidate(`i${i}`, 'tags', { card: scheduled(10, 20) }),
    );
    expect(composeLessonWarmUp(many, ['tags'], baseOptions).length).toBeLessThanOrEqual(3);
  });
});

describe('which skills a warm-up may draw on', () => {
  //   syntax → tags → text
  //   forms  → labels
  const graph = new Map<string, string[]>([
    ['syntax', ['tags']],
    ['tags', ['text']],
    ['forms', ['labels']],
  ]);

  it('always includes the skill the lesson itself builds', () => {
    // Otherwise the first lesson to revisit a skill could never warm up on it.
    expect(
      warmUpSkillsFor({ lessonSkill: 'forms', moduleSkills: [], skillPrerequisites: new Map() }),
    ).toEqual(['forms']);
  });

  it('follows the prerequisite chain, so the warm-up primes this lesson', () => {
    expect(
      warmUpSkillsFor({ lessonSkill: 'syntax', moduleSkills: [], skillPrerequisites: graph }),
    ).toEqual(['syntax', 'tags', 'text']);
  });

  it('stops at the configured depth rather than walking to the root', () => {
    // Following the chain all the way back eventually reaches "what a tag is",
    // which primes nothing by Level 9.
    expect(
      warmUpSkillsFor({
        lessonSkill: 'syntax',
        moduleSkills: [],
        skillPrerequisites: graph,
        depth: 1,
      }),
    ).toEqual(['syntax', 'tags']);

    expect(
      warmUpSkillsFor({
        lessonSkill: 'syntax',
        moduleSkills: [],
        skillPrerequisites: graph,
        depth: 0,
      }),
    ).toEqual(['syntax']);
  });

  it('includes what the module declares it teaches, and their prerequisites', () => {
    expect(
      warmUpSkillsFor({
        lessonSkill: 'syntax',
        moduleSkills: ['forms'],
        skillPrerequisites: graph,
        depth: 1,
      }),
    ).toEqual(['forms', 'labels', 'syntax', 'tags']);
  });

  it('terminates on a cyclic graph rather than looping forever', () => {
    const cyclic = new Map<string, string[]>([
      ['a', ['b']],
      ['b', ['a']],
    ]);
    expect(
      warmUpSkillsFor({ lessonSkill: 'a', moduleSkills: [], skillPrerequisites: cyclic, depth: 9 }),
    ).toEqual(['a', 'b']);
  });

  it('is stable regardless of the order the graph is walked', () => {
    const forwards = warmUpSkillsFor({
      lessonSkill: 'syntax',
      moduleSkills: ['forms'],
      skillPrerequisites: graph,
    });
    const backwards = warmUpSkillsFor({
      lessonSkill: 'syntax',
      moduleSkills: ['forms'],
      skillPrerequisites: new Map([...graph].reverse()),
    });
    expect(forwards).toEqual(backwards);
  });
});

/**
 * Module recall and level cumulative review.
 *
 * Both narrow the candidate pool and then run the same composer as the daily
 * queue. These assert the two properties that make them worth having as
 * separate screens rather than as a filter on the queue.
 */
describe('module and level review', () => {
  const pool = [
    candidate('m1-a', 'tags', { moduleSlug: 'basics', lessonSlug: 'l1', card: scheduled(10, 20) }),
    candidate('m1-b', 'text', { moduleSlug: 'basics', lessonSlug: 'l2', card: scheduled(10, 20) }),
    candidate('m2-a', 'links', { moduleSlug: 'linking', lessonSlug: 'l3', card: scheduled(10, 20) }),
  ];

  it('a module pass covers only that module', () => {
    const selected = composeReviewSession(
      pool.filter((c) => c.moduleSlug === 'basics'),
      baseOptions,
    );
    expect(selected.map((s) => s.candidate.itemId).sort()).toEqual(['m1-a', 'm1-b']);
  });

  it('a level pass mixes across its modules rather than walking them in order', () => {
    // Answering inside one module means the topic is given. Answering across a
    // level means working out which idea applies first, which is the
    // discrimination the real task demands.
    const selected = composeReviewSession(pool, { ...baseOptions, maxConsecutivePerSkill: 1 });
    const skills = selected.map((s) => s.candidate.skillSlug);
    for (let i = 1; i < skills.length; i += 1) {
      expect(skills[i]).not.toBe(skills[i - 1]);
    }
    expect(selected).toHaveLength(3);
  });

  it('holds a module pass to a shorter ceiling than a level pass', () => {
    const many = Array.from({ length: 30 }, (_, i) =>
      candidate(`i${i}`, `skill-${i % 5}`, { card: scheduled(10, 20) }),
    );
    // A queue abandoned halfway is worse than a shorter one: the unreviewed
    // remainder decays while appearing to be in progress.
    expect(composeReviewSession(many, { ...baseOptions, maxItems: 12 })).toHaveLength(12);
    expect(composeReviewSession(many, { ...baseOptions, maxItems: 20 })).toHaveLength(20);
  });
});

describe('forecast', () => {
  it('counts items on the day they fall due', () => {
    const items = [
      candidate('a', 'x', { card: scheduled(10, 10) }),   // due today
      candidate('b', 'y', { card: scheduled(10, 9) }),    // due tomorrow
      candidate('c', 'z', { card: scheduled(10, 9) }),
    ];
    const forecast = reviewForecast(items, '2026-06-01', 3);
    expect(forecast[0]).toEqual({ date: '2026-06-01', dueCount: 1 });
    expect(forecast[1]).toEqual({ date: '2026-06-02', dueCount: 2 });
    expect(forecast[2]!.dueCount).toBe(0);
  });

  it('piles everything overdue onto the first day rather than hiding it', () => {
    const items = [
      candidate('a', 'x', { card: scheduled(10, 100) }),
      candidate('b', 'y', { card: scheduled(10, 80) }),
    ];
    expect(reviewForecast(items, '2026-06-01', 2)[0]!.dueCount).toBe(2);
  });

  it('counts what is due right now', () => {
    const items = [
      candidate('a', 'x', { card: scheduled(10, 20) }),
      candidate('b', 'y', { card: scheduled(30, 1) }),
    ];
    expect(dueNowCount(items, '2026-06-01')).toBe(1);
  });
});

// ---------------------------------------------------------------------------
// Metacognitive calibration
// ---------------------------------------------------------------------------

const point = (
  confidence: ConfidenceRating,
  correct: boolean,
  skillSlug = 'links',
): CalibrationPoint => ({ confidence, correct, skillSlug });

/** n answers at one confidence, of which `correct` were right. */
const points = (
  confidence: ConfidenceRating,
  n: number,
  correct: number,
  skill = 'links',
): CalibrationPoint[] =>
  Array.from({ length: n }, (_, i) => point(confidence, i < correct, skill));

describe('calibration', () => {
  it('says nothing at all from too little evidence', () => {
    // Telling someone they are overconfident on the basis of three answers
    // would be the same error the report exists to correct.
    const report = calibrationReport(points(4, 3, 0));
    expect(report.verdict).toBe('insufficient-evidence');
  });

  it('detects overconfidence', () => {
    const report = calibrationReport(points(4, 12, 5));
    expect(report.verdict).toBe('overconfident');
    expect(report.bias).toBeGreaterThan(0);
  });

  it('detects underconfidence', () => {
    const report = calibrationReport(points(1, 12, 11));
    expect(report.verdict).toBe('underconfident');
    expect(report.bias).toBeLessThan(0);
  });

  it('accepts a learner whose confidence matches their results', () => {
    // 95% claimed, 10 of 10 right ≈ well calibrated within tolerance.
    const report = calibrationReport(points(4, 10, 10));
    expect(report.verdict).toBe('well-calibrated');
    expect(Math.abs(report.bias)).toBeLessThanOrEqual(0.1);
  });

  it('counts confident mistakes separately, because those are the dangerous ones', () => {
    const report = calibrationReport([...points(4, 6, 2), ...points(1, 4, 4)]);
    expect(report.confidentMistakes).toBe(4);
    expect(report.unrecognisedKnowledge).toBe(4);
  });

  it('scores forecasts with Brier, rewarding accuracy over hedging', () => {
    const perfect = calibrationReport(points(4, 10, 10));
    const wrong = calibrationReport(points(4, 10, 0));
    expect(perfect.brierScore).toBeLessThan(wrong.brierScore);
    expect(perfect.brierScore).toBeGreaterThanOrEqual(0);
    expect(wrong.brierScore).toBeLessThanOrEqual(1);
  });

  it('reports each confidence level against what actually happened', () => {
    const report = calibrationReport([...points(4, 4, 2), ...points(2, 4, 2)]);
    const certain = report.buckets.find((b) => b.confidence === 4)!;
    expect(certain.count).toBe(4);
    expect(certain.actualAccuracy).toBe(0.5);
    expect(certain.claimedAccuracy).toBe(0.95);
  });

  it('handles an empty history without dividing by zero', () => {
    const report = calibrationReport([]);
    expect(report.totalAnswers).toBe(0);
    expect(report.brierScore).toBe(0);
    expect(report.buckets).toHaveLength(4);
  });
});

describe('blind spots', () => {
  it('finds skills believed in more than they are earned', () => {
    const spots = blindSpots([
      ...points(4, 6, 1, 'forms'),   // certain, mostly wrong
      ...points(3, 6, 5, 'links'),   // fairly sure, mostly right
    ]);
    expect(spots.map((s) => s.skillSlug)).toEqual(['forms']);
    expect(spots[0]!.gap).toBeGreaterThan(0.5);
  });

  it('ignores skills with too few answers to judge', () => {
    expect(blindSpots(points(4, 2, 0, 'forms'))).toHaveLength(0);
  });

  it('orders by how dangerous the gap is', () => {
    const spots = blindSpots([
      ...points(4, 5, 3, 'links'),
      ...points(4, 5, 0, 'forms'),
    ]);
    expect(spots[0]!.skillSlug).toBe('forms');
  });

  it('does not flag a skill the learner is right about', () => {
    expect(blindSpots(points(4, 8, 8, 'links'))).toHaveLength(0);
  });
});

describe('calibration wording', () => {
  it('addresses the learner differently for each verdict', () => {
    const messages = [
      calibrationMessage(calibrationReport(points(4, 3, 0))),
      calibrationMessage(calibrationReport(points(4, 12, 4))),
      calibrationMessage(calibrationReport(points(1, 12, 11))),
      calibrationMessage(calibrationReport(points(4, 10, 10))),
    ];
    expect(new Set(messages).size).toBe(4);
    for (const message of messages) expect(message.length).toBeGreaterThan(40);
  });

  it('names the number of confident mistakes, since that is the point', () => {
    const message = calibrationMessage(calibrationReport(points(4, 12, 4)));
    expect(message).toContain('8');
  });
});
