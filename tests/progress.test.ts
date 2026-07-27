import { describe, expect, it } from 'vitest';
import {
  achievementXp,
  assessmentXp,
  exerciseXp,
  learnerLevel,
  lessonXp,
  quizXp,
  streakXp,
  xpForLevel,
} from '@/lib/progress/xp';
import {
  applyEvidence,
  decayMastery,
  EMPTY_MASTERY,
  evaluateModuleGate,
  isMastered,
  MASTERY_THRESHOLDS,
  masteryState,
  nextDifficulty,
  recommendPractice,
  shouldOfferStretch,
} from '@/lib/progress/mastery';
import {
  addDays,
  buildPaceReport,
  computeStreak,
  formatStudyDays,
  isoDate,
  recommendPace,
} from '@/lib/progress/pace';
import {
  criteriaProgress,
  EMPTY_SNAPSHOT,
  meetsCriteria,
  newlyUnlocked,
  type AchievementSnapshot,
} from '@/lib/progress/achievements';

describe('XP', () => {
  it('awards the full amount for a clean first pass', () => {
    const award = exerciseXp({
      exerciseId: 'e1',
      baseXp: 40,
      hintsUsed: 0,
      priorAttempts: 0,
      alreadyAwarded: false,
    });
    expect(award?.amount).toBe(40);
  });

  it('reduces but never removes XP when hints are used', () => {
    const withHints = exerciseXp({
      exerciseId: 'e1',
      baseXp: 40,
      hintsUsed: 3,
      priorAttempts: 0,
      alreadyAwarded: false,
    });
    expect(withHints?.amount).toBeLessThan(40);
    expect(withHints?.amount).toBeGreaterThan(0);
    expect(withHints?.reason).toContain('3 hints');
  });

  it('floors the hint penalty so hints stay worth using', () => {
    const many = exerciseXp({
      exerciseId: 'e1',
      baseXp: 40,
      hintsUsed: 20,
      priorAttempts: 0,
      alreadyAwarded: false,
    });
    // 50% floor on hints, 60% floor on retries — never less than 30% of base.
    expect(many?.amount).toBeGreaterThanOrEqual(Math.round(40 * 0.5 * 0.6));
  });

  it('awards nothing for resubmitting an already-passed exercise', () => {
    expect(
      exerciseXp({
        exerciseId: 'e1',
        baseXp: 40,
        hintsUsed: 0,
        priorAttempts: 0,
        alreadyAwarded: true,
      }),
    ).toBeNull();
  });

  it('keys every award so the database can reject a duplicate', () => {
    const award = exerciseXp({
      exerciseId: 'exercise-123',
      baseXp: 40,
      hintsUsed: 0,
      priorAttempts: 0,
      alreadyAwarded: false,
    });
    expect(award?.sourceType).toBe('exercise');
    expect(award?.sourceId).toBe('exercise-123');
  });

  it('marks optional exercises as bonus XP', () => {
    const award = exerciseXp({
      exerciseId: 'e1',
      baseXp: 40,
      hintsUsed: 0,
      priorAttempts: 0,
      alreadyAwarded: false,
      isOptional: true,
    });
    expect(award?.sourceType).toBe('bonus');
  });

  it('awards lesson XP once only', () => {
    expect(lessonXp({ lessonId: 'l1', baseXp: 40, alreadyAwarded: false })?.amount).toBe(40);
    expect(lessonXp({ lessonId: 'l1', baseXp: 40, alreadyAwarded: true })).toBeNull();
  });

  it('halves quiz XP for a corrected answer, and gives none for a wrong one', () => {
    const first = quizXp({
      questionId: 'q1',
      baseXp: 10,
      isCorrect: true,
      isFirstAttempt: true,
      alreadyAwarded: false,
    });
    const later = quizXp({
      questionId: 'q1',
      baseXp: 10,
      isCorrect: true,
      isFirstAttempt: false,
      alreadyAwarded: false,
    });
    const wrong = quizXp({
      questionId: 'q1',
      baseXp: 10,
      isCorrect: false,
      isFirstAttempt: true,
      alreadyAwarded: false,
    });

    expect(first?.amount).toBe(10);
    expect(later?.amount).toBe(5);
    expect(wrong).toBeNull();
  });

  it('scales assessment XP with the score, capped at 1.25x', () => {
    const bare = assessmentXp({ assessmentId: 'a', baseXp: 200, score: 0.75, passed: true, alreadyAwarded: false });
    const perfect = assessmentXp({ assessmentId: 'a', baseXp: 200, score: 1, passed: true, alreadyAwarded: false });
    const failed = assessmentXp({ assessmentId: 'a', baseXp: 200, score: 0.6, passed: false, alreadyAwarded: false });

    expect(bare?.amount).toBe(200);
    expect(perfect?.amount).toBe(250);
    expect(failed).toBeNull();
  });

  it('awards streak milestones in the order they were earned, once each', () => {
    // A learner on day seven with nothing recorded is owed the 3-day milestone
    // first; the 7-day one follows on the next sync.
    expect(streakXp(7, new Set())?.sourceId).toBe('streak-3');
    expect(streakXp(7, new Set([3]))?.sourceId).toBe('streak-7');
    expect(streakXp(7, new Set([3, 7]))).toBeNull();
    expect(streakXp(14, new Set([3, 7]))?.sourceId).toBe('streak-14');
    expect(streakXp(2, new Set())).toBeNull();
  });

  it('never pays an achievement twice', () => {
    expect(achievementXp('a1', 100, false)?.amount).toBe(100);
    expect(achievementXp('a1', 100, true)).toBeNull();
  });
});

describe('learner levels', () => {
  it('starts everyone at level 1 with no XP', () => {
    const level = learnerLevel(0);
    expect(level.level).toBe(1);
    expect(level.progress).toBe(0);
  });

  it('rises monotonically and never exceeds the cap', () => {
    let previous = 0;
    for (const xp of [0, 100, 500, 2_000, 10_000, 100_000, 5_000_000]) {
      const level = learnerLevel(xp).level;
      expect(level).toBeGreaterThanOrEqual(previous);
      expect(level).toBeLessThanOrEqual(99);
      previous = level;
    }
  });

  it('reports progress within the current level', () => {
    const threshold = xpForLevel(4);
    const justOver = learnerLevel(threshold + 1);
    expect(justOver.level).toBe(4);
    expect(justOver.progress).toBeGreaterThan(0);
    expect(justOver.progress).toBeLessThan(0.5);
  });

  it('handles negative input without breaking', () => {
    expect(learnerLevel(-500).level).toBe(1);
  });
});

describe('skill mastery', () => {
  it('takes the first piece of evidence as the baseline', () => {
    const record = applyEvidence(EMPTY_MASTERY, { kind: 'exercise', score: 1 });
    expect(record.mastery).toBe(1);
    expect(record.evidenceCount).toBe(1);
  });

  it('needs several pieces of evidence before calling a skill mastered', () => {
    let record = applyEvidence(EMPTY_MASTERY, { kind: 'exercise', score: 1 });
    expect(isMastered(record)).toBe(false);

    record = applyEvidence(record, { kind: 'exercise', score: 1 });
    record = applyEvidence(record, { kind: 'exercise', score: 1 });
    expect(isMastered(record)).toBe(true);
    expect(record.state).toBe('mastered');
  });

  it('does not master a skill on one lucky multiple-choice answer', () => {
    const record = applyEvidence(EMPTY_MASTERY, { kind: 'quiz', score: 1 });
    expect(isMastered(record)).toBe(false);
  });

  it('discounts a success that needed heavy help', () => {
    const clean = applyEvidence(EMPTY_MASTERY, { kind: 'exercise', score: 1 });
    const helped = applyEvidence(EMPTY_MASTERY, {
      kind: 'exercise',
      score: 1,
      hintsUsed: 3,
      priorAttempts: 2,
    });
    expect(helped.mastery).toBeLessThan(clean.mastery);
  });

  it('flags a weak skill for practice', () => {
    let record = applyEvidence(EMPTY_MASTERY, { kind: 'exercise', score: 0.2 });
    record = applyEvidence(record, { kind: 'exercise', score: 0.3 });
    expect(record.needsPractice).toBe(true);
    expect(record.mastery).toBeLessThan(MASTERY_THRESHOLDS.needsPractice);
  });

  it('recovers as the learner improves', () => {
    let record = applyEvidence(EMPTY_MASTERY, { kind: 'exercise', score: 0.2 });
    for (let i = 0; i < 6; i += 1) {
      record = applyEvidence(record, { kind: 'exercise', score: 1 });
    }
    expect(record.needsPractice).toBe(false);
    expect(isMastered(record)).toBe(true);
  });

  it('decays gently and only after a fortnight', () => {
    const record = { ...EMPTY_MASTERY, mastery: 0.9, evidenceCount: 5, state: 'mastered' as const };
    expect(decayMastery(record, 7).mastery).toBe(0.9);

    const rusty = decayMastery(record, 90);
    expect(rusty.mastery).toBeLessThan(0.9);
    expect(rusty.mastery).toBeGreaterThanOrEqual(0.9 * 0.85);
  });

  it('classifies states at the documented thresholds', () => {
    expect(masteryState(0, 0)).toBe('untouched');
    expect(masteryState(0.3, 2)).toBe('learning');
    expect(masteryState(0.6, 2)).toBe('practising');
    expect(masteryState(0.75, 2)).toBe('proficient');
    expect(masteryState(0.9, 5)).toBe('mastered');
    // High score, thin evidence: proficient, not mastered.
    expect(masteryState(0.9, 1)).toBe('proficient');
  });
});

describe('module unlocking', () => {
  const gate = {
    moduleId: 'm2',
    prerequisiteModuleIds: ['m1'],
    requiredSkills: [{ skillId: 's1', masteryRequired: 0.7 }],
  };

  it('stays locked until the prerequisite module is complete', () => {
    const verdict = evaluateModuleGate(gate, {
      completedModuleIds: new Set(),
      masteryBySkill: new Map([['s1', 0.9]]),
    });
    expect(verdict.unlocked).toBe(false);
    expect(verdict.blockedBy).toHaveLength(1);
  });

  it('stays locked until the required skill reaches its threshold', () => {
    const verdict = evaluateModuleGate(gate, {
      completedModuleIds: new Set(['m1']),
      masteryBySkill: new Map([['s1', 0.5]]),
    });
    expect(verdict.unlocked).toBe(false);
    expect(verdict.blockedBy[0]).toContain('70%');
  });

  it('unlocks when both conditions are met', () => {
    const verdict = evaluateModuleGate(gate, {
      completedModuleIds: new Set(['m1']),
      masteryBySkill: new Map([['s1', 0.75]]),
    });
    expect(verdict.unlocked).toBe(true);
    expect(verdict.blockedBy).toHaveLength(0);
  });

  it('never unlocks on elapsed time — the gate has no time input at all', () => {
    // The verdict is identical however long has passed, because the function
    // takes no clock. This is the course's central promise, asserted directly.
    const context = {
      completedModuleIds: new Set<string>(),
      masteryBySkill: new Map([['s1', 0.2]]),
    };
    expect(evaluateModuleGate(gate, context).unlocked).toBe(false);
    expect(evaluateModuleGate(gate, context).unlocked).toBe(false);
  });

  it('names the missing skill and module when it can', () => {
    const verdict = evaluateModuleGate(
      gate,
      { completedModuleIds: new Set(), masteryBySkill: new Map() },
      new Map([['s1', 'Semantic HTML']]),
      new Map([['m1', 'The HTML skeleton']]),
    );
    expect(verdict.blockedBy.join(' ')).toContain('The HTML skeleton');
    expect(verdict.blockedBy.join(' ')).toContain('Semantic HTML');
  });
});

describe('adaptive practice', () => {
  it('ranks the weakest skill first', () => {
    const queue = recommendPractice([
      { skillId: 'a', skillName: 'Strong', mastery: 0.75, evidenceCount: 4, daysSincePractice: 1 },
      { skillId: 'b', skillName: 'Weak', mastery: 0.25, evidenceCount: 4, daysSincePractice: 1 },
    ]);
    expect(queue[0]?.skillId).toBe('b');
  });

  it('surfaces a stale skill above a recently practised one of the same strength', () => {
    const queue = recommendPractice([
      { skillId: 'fresh', skillName: 'Fresh', mastery: 0.6, evidenceCount: 4, daysSincePractice: 0 },
      { skillId: 'stale', skillName: 'Stale', mastery: 0.6, evidenceCount: 4, daysSincePractice: 40 },
    ]);
    expect(queue[0]?.skillId).toBe('stale');
  });

  it('leaves mastered and untouched skills out of the queue', () => {
    const queue = recommendPractice([
      { skillId: 'mastered', skillName: 'Mastered', mastery: 0.95, evidenceCount: 5, daysSincePractice: 1 },
      { skillId: 'new', skillName: 'Untouched', mastery: 0, evidenceCount: 0, daysSincePractice: 999 },
    ]);
    expect(queue).toHaveLength(0);
  });

  it('offers easier work when struggling and harder work when confident', () => {
    expect(nextDifficulty(0.2, 3)).toBe(1);
    expect(nextDifficulty(0.45, 3)).toBe(2);
    expect(nextDifficulty(0.6, 3)).toBe(3);
    expect(nextDifficulty(0.75, 3)).toBe(4);
    expect(nextDifficulty(0.9, 5)).toBe(5);
    expect(nextDifficulty(0.9, 0)).toBe(1);
  });

  it('offers stretch work only to a genuinely mastered skill', () => {
    expect(shouldOfferStretch(0.9, 5)).toBe(true);
    expect(shouldOfferStretch(0.9, 1)).toBe(false);
    expect(shouldOfferStretch(0.6, 9)).toBe(false);
  });
});

describe('pace and scheduling', () => {
  const plan = {
    minutesPerDay: 60,
    studyDays: [1, 2, 3, 4, 5],
    totalCourseMinutes: 1900,
  };

  it('produces a realistic estimate that discounts perfect attendance', () => {
    const pace = recommendPace(plan, 48);
    // 60 min x 5 days x 0.85 = 255 min/week, not 300.
    expect(pace.minutesPerWeek).toBe(255);
    expect(pace.estimatedDays).toBeGreaterThan(30);
    expect(pace.lessonsPerWeek).toBeGreaterThan(0);
  });

  it('finishes faster with more study days', () => {
    const weekdays = recommendPace(plan, 48);
    const everyDay = recommendPace({ ...plan, studyDays: [1, 2, 3, 4, 5, 6, 7] }, 48);
    expect(everyDay.estimatedDays).toBeLessThan(weekdays.estimatedDays);
  });

  it('says honestly when a target date is unrealistic', () => {
    const soon = recommendPace({ ...plan, targetCompletionDate: addDays(new Date(), 5) }, 48);
    expect(soon.targetIsAchievable).toBe(false);
    expect(soon.minutesPerDayForTarget).toBeGreaterThan(60);

    const generous = recommendPace({ ...plan, targetCompletionDate: addDays(new Date(), 180) }, 48);
    expect(generous.targetIsAchievable).toBe(true);
  });

  it('deduplicates study days rather than double-counting', () => {
    const doubled = recommendPace({ ...plan, studyDays: [1, 1, 2, 2, 3] }, 48);
    const distinct = recommendPace({ ...plan, studyDays: [1, 2, 3] }, 48);
    expect(doubled.minutesPerWeek).toBe(distinct.minutesPerWeek);
  });

  it('reports "not started" before the first completion', () => {
    const report = buildPaceReport(
      {
        lessonsCompleted: 0,
        totalLessons: 48,
        remainingMinutes: 1900,
        studyDates: [],
        startedOn: new Date(),
        totalStudySeconds: 0,
      },
      recommendPace(plan, 48),
    );
    expect(report.status).toBe('not_started');
    expect(report.completionPercent).toBe(0);
  });

  it('recognises a learner moving faster than planned', () => {
    const now = new Date('2026-02-01T12:00:00Z');
    const report = buildPaceReport(
      {
        lessonsCompleted: 20,
        totalLessons: 48,
        remainingMinutes: 900,
        studyDates: ['2026-01-20', '2026-01-21', '2026-01-22'],
        startedOn: new Date('2026-01-25T12:00:00Z'),
        totalStudySeconds: 30_000,
      },
      recommendPace(plan, 48),
      now,
    );
    expect(report.status).toBe('ahead');
    expect(report.completionPercent).toBe(42);
  });

  it('recognises a learner falling behind, without blaming them', () => {
    const now = new Date('2026-03-01T12:00:00Z');
    const report = buildPaceReport(
      {
        lessonsCompleted: 2,
        totalLessons: 48,
        remainingMinutes: 1800,
        studyDates: ['2026-01-05'],
        startedOn: new Date('2026-01-01T12:00:00Z'),
        totalStudySeconds: 3_600,
      },
      recommendPace(plan, 48),
      now,
    );
    expect(report.status).toBe('behind');
    expect(report.message).toContain('mastery matters more than speed');
  });

  it('estimates a completion date that moves with real progress', () => {
    const now = new Date('2026-02-01T12:00:00Z');
    const recommended = recommendPace(plan, 48);
    const slow = buildPaceReport(
      { lessonsCompleted: 4, totalLessons: 48, remainingMinutes: 0, studyDates: [], startedOn: new Date('2026-01-01T12:00:00Z'), totalStudySeconds: 0 },
      recommended,
      now,
    );
    const fast = buildPaceReport(
      { lessonsCompleted: 30, totalLessons: 48, remainingMinutes: 0, studyDates: [], startedOn: new Date('2026-01-01T12:00:00Z'), totalStudySeconds: 0 },
      recommended,
      now,
    );
    expect(fast.estimatedCompletionDate!.getTime()).toBeLessThan(
      slow.estimatedCompletionDate!.getTime(),
    );
  });
});

describe('streaks', () => {
  const today = new Date('2026-03-10T12:00:00Z');

  it('reports nothing for a learner who has never studied', () => {
    expect(computeStreak([], today)).toEqual({
      current: 0,
      longest: 0,
      activeToday: false,
      atRisk: false,
    });
  });

  it('counts consecutive days up to today', () => {
    const streak = computeStreak(['2026-03-08', '2026-03-09', '2026-03-10'], today);
    expect(streak.current).toBe(3);
    expect(streak.activeToday).toBe(true);
    expect(streak.atRisk).toBe(false);
  });

  it('keeps the streak alive but at risk when yesterday was the last day', () => {
    const streak = computeStreak(['2026-03-08', '2026-03-09'], today);
    expect(streak.current).toBe(2);
    expect(streak.activeToday).toBe(false);
    expect(streak.atRisk).toBe(true);
  });

  it('breaks the streak after a missed day', () => {
    const streak = computeStreak(['2026-03-01', '2026-03-02'], today);
    expect(streak.current).toBe(0);
    expect(streak.longest).toBe(2);
  });

  it('remembers the longest run even after it is broken', () => {
    const streak = computeStreak(
      ['2026-01-01', '2026-01-02', '2026-01-03', '2026-01-04', '2026-03-10'],
      today,
    );
    expect(streak.longest).toBe(4);
    expect(streak.current).toBe(1);
  });

  it('ignores duplicate dates', () => {
    expect(computeStreak(['2026-03-10', '2026-03-10', '2026-03-09'], today).current).toBe(2);
  });
});

describe('achievements', () => {
  const snapshot: AchievementSnapshot = {
    ...EMPTY_SNAPSHOT,
    lessonsCompleted: 30,
    exercisesPassed: 50,
    debugChallengesPassed: 10,
    currentFirstPassStreak: 5,
    completedLevelSlugs: new Set(['html-explorer']),
    completedModuleSlugs: new Set(['the-html-skeleton']),
    masteredSkillSlugs: new Set(['syntax', 'links', 'images']),
    streakDays: 21,
    projectPageCount: 5,
    totalXp: 4000,
  };

  it('evaluates every criteria shape', () => {
    expect(meetsCriteria({ type: 'lessons_completed', count: 30 }, snapshot)).toBe(true);
    expect(meetsCriteria({ type: 'lessons_completed', count: 31 }, snapshot)).toBe(false);
    expect(meetsCriteria({ type: 'level_completed', levelSlug: 'html-explorer' }, snapshot)).toBe(true);
    expect(meetsCriteria({ type: 'module_completed', moduleSlug: 'the-html-skeleton' }, snapshot)).toBe(true);
    expect(meetsCriteria({ type: 'skill_mastered', skillSlug: 'links' }, snapshot)).toBe(true);
    expect(meetsCriteria({ type: 'skill_mastered', skillSlug: 'forms' }, snapshot)).toBe(false);
    expect(meetsCriteria({ type: 'skills_mastered', count: 3 }, snapshot)).toBe(true);
    expect(meetsCriteria({ type: 'streak_days', days: 21 }, snapshot)).toBe(true);
    expect(meetsCriteria({ type: 'first_pass_streak', count: 5 }, snapshot)).toBe(true);
    expect(meetsCriteria({ type: 'debug_challenges', count: 10 }, snapshot)).toBe(true);
    expect(meetsCriteria({ type: 'project_pages', count: 5 }, snapshot)).toBe(true);
    expect(meetsCriteria({ type: 'xp_total', amount: 4000 }, snapshot)).toBe(true);
    expect(meetsCriteria({ type: 'course_complete' }, snapshot)).toBe(false);
  });

  it('unlocks only what is newly earned', () => {
    const definitions = [
      { id: '1', slug: 'a', name: 'Thirty lessons', criteria: { type: 'lessons_completed', count: 30 }, xpAward: 100 },
      { id: '2', slug: 'b', name: 'Fifty lessons', criteria: { type: 'lessons_completed', count: 50 }, xpAward: 200 },
      { id: '3', slug: 'c', name: 'Already had', criteria: { type: 'streak_days', days: 7 }, xpAward: 50 },
    ];

    const earned = newlyUnlocked(definitions, snapshot, new Set(['3']));
    expect(earned.map((a) => a.id)).toEqual(['1']);
  });

  it('ignores a criteria shape it does not understand', () => {
    const earned = newlyUnlocked(
      [{ id: '1', slug: 'x', name: 'Odd', criteria: { type: 'not-a-real-thing' }, xpAward: 10 }],
      snapshot,
      new Set(),
    );
    expect(earned).toHaveLength(0);
  });

  it('reports progress towards countable achievements', () => {
    expect(criteriaProgress({ type: 'lessons_completed', count: 50 }, snapshot)).toEqual({
      current: 30,
      target: 50,
    });
    expect(criteriaProgress({ type: 'course_complete' }, snapshot)).toBeNull();
  });
});

describe('date helpers', () => {
  it('formats ISO dates in UTC', () => {
    expect(isoDate(new Date('2026-03-10T23:30:00Z'))).toBe('2026-03-10');
  });

  it('adds and subtracts days', () => {
    expect(isoDate(addDays(new Date('2026-03-10T12:00:00Z'), 5))).toBe('2026-03-15');
    expect(isoDate(addDays(new Date('2026-03-10T12:00:00Z'), -10))).toBe('2026-02-28');
  });

  it('names study days in order, without duplicates', () => {
    expect(formatStudyDays([3, 1, 5, 1])).toBe('Mon, Wed, Fri');
  });
});
