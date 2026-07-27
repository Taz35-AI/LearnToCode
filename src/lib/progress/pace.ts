/**
 * Pace and scheduling.
 *
 * The curriculum itself is mastery-based and contains no calendar. This module
 * exists only to answer the learner's practical question — "when am I likely to
 * finish, at the rate I'm actually going?" — and it answers it from real
 * completions, never from a fixed day number.
 */

export interface PlanInput {
  /** Minutes the learner said they can study on a study day. */
  minutesPerDay: number;
  /** ISO weekday numbers they chose, 1 = Monday … 7 = Sunday. */
  studyDays: number[];
  /** Total teaching minutes in the whole course. */
  totalCourseMinutes: number;
  /** Optional date the learner is aiming for. */
  targetCompletionDate?: Date | null;
}

export interface RecommendedPace {
  minutesPerWeek: number;
  /** Lessons per week at the recommended pace. */
  lessonsPerWeek: number;
  /** Calendar days the plan implies, including non-study days. */
  estimatedDays: number;
  /** Whether the learner's chosen target is realistic. */
  targetIsAchievable: boolean;
  /** Minutes per study day needed to hit their target, if they set one. */
  minutesPerDayForTarget: number | null;
}

const MS_PER_DAY = 86_400_000;

export function averageLessonMinutes(totalCourseMinutes: number, lessonCount: number): number {
  if (lessonCount <= 0) return 15;
  return totalCourseMinutes / lessonCount;
}

/**
 * Turns the onboarding answers into a recommended pace.
 *
 * Note the 0.85 factor: self-reported study time is optimistic, and a plan that
 * assumes perfect attendance sets a beginner up to feel behind in week one.
 */
export function recommendPace(input: PlanInput, lessonCount: number): RecommendedPace {
  const studyDaysPerWeek = Math.max(1, Math.min(7, new Set(input.studyDays).size));
  const realisticMinutesPerWeek = input.minutesPerDay * studyDaysPerWeek * 0.85;

  const weeksNeeded = input.totalCourseMinutes / Math.max(1, realisticMinutesPerWeek);
  const estimatedDays = Math.ceil(weeksNeeded * 7);

  const lessonsPerWeek =
    lessonCount > 0 ? round2(lessonCount / Math.max(0.1, weeksNeeded)) : 0;

  let targetIsAchievable = true;
  let minutesPerDayForTarget: number | null = null;

  if (input.targetCompletionDate) {
    const daysAvailable = Math.max(
      1,
      Math.ceil((input.targetCompletionDate.getTime() - Date.now()) / MS_PER_DAY),
    );
    const studyDaysAvailable = Math.max(1, Math.floor((daysAvailable / 7) * studyDaysPerWeek));
    minutesPerDayForTarget = Math.ceil(input.totalCourseMinutes / 0.85 / studyDaysAvailable);
    targetIsAchievable = minutesPerDayForTarget <= input.minutesPerDay * 1.15;
  }

  return {
    minutesPerWeek: Math.round(realisticMinutesPerWeek),
    lessonsPerWeek,
    estimatedDays,
    targetIsAchievable,
    minutesPerDayForTarget,
  };
}

export interface ProgressSnapshot {
  lessonsCompleted: number;
  totalLessons: number;
  /** Remaining teaching minutes, from the lessons not yet completed. */
  remainingMinutes: number;
  /** Distinct dates on which the learner studied. */
  studyDates: string[];
  startedOn: Date;
  /** Total seconds recorded across all study sessions. */
  totalStudySeconds: number;
}

export interface PaceReport {
  /** Lessons per week the plan calls for. */
  recommendedLessonsPerWeek: number;
  /** Lessons per week the learner is actually achieving. */
  currentLessonsPerWeek: number;
  /** 'ahead' | 'on_track' | 'behind' | 'not_started' */
  status: PaceStatus;
  estimatedCompletionDate: Date | null;
  /** Percentage of the course finished, 0–100. */
  completionPercent: number;
  /** Active days in the last 7. */
  activeDaysThisWeek: number;
  /** A short, non-judgemental sentence for the dashboard. */
  message: string;
}

export type PaceStatus = 'not_started' | 'ahead' | 'on_track' | 'behind';

export function buildPaceReport(
  snapshot: ProgressSnapshot,
  recommended: RecommendedPace,
  now: Date = new Date(),
): PaceReport {
  const completionPercent =
    snapshot.totalLessons === 0
      ? 0
      : Math.round((snapshot.lessonsCompleted / snapshot.totalLessons) * 100);

  const uniqueDates = [...new Set(snapshot.studyDates)].sort();
  const activeDaysThisWeek = countActiveDaysWithin(uniqueDates, now, 7);

  if (snapshot.lessonsCompleted === 0) {
    return {
      recommendedLessonsPerWeek: recommended.lessonsPerWeek,
      currentLessonsPerWeek: 0,
      status: 'not_started',
      estimatedCompletionDate: addDays(now, recommended.estimatedDays),
      completionPercent,
      activeDaysThisWeek,
      message: 'Your plan is ready. Finish your first lesson to start tracking your real pace.',
    };
  }

  const elapsedDays = Math.max(1, (now.getTime() - snapshot.startedOn.getTime()) / MS_PER_DAY);
  const elapsedWeeks = Math.max(0.25, elapsedDays / 7);
  const currentLessonsPerWeek = round2(snapshot.lessonsCompleted / elapsedWeeks);

  const lessonsRemaining = Math.max(0, snapshot.totalLessons - snapshot.lessonsCompleted);

  // Blend measured pace with the plan so a single quiet week doesn't throw the
  // estimate wildly. The more evidence there is, the more the real pace counts.
  const evidenceWeight = Math.min(0.85, snapshot.lessonsCompleted / 12);
  const blendedPerWeek =
    currentLessonsPerWeek * evidenceWeight + recommended.lessonsPerWeek * (1 - evidenceWeight);

  const weeksRemaining = blendedPerWeek > 0 ? lessonsRemaining / blendedPerWeek : 0;
  const estimatedCompletionDate =
    lessonsRemaining === 0 ? now : addDays(now, Math.ceil(weeksRemaining * 7));

  const ratio = recommended.lessonsPerWeek > 0 ? currentLessonsPerWeek / recommended.lessonsPerWeek : 1;
  const status: PaceStatus = ratio >= 1.15 ? 'ahead' : ratio >= 0.8 ? 'on_track' : 'behind';

  const message =
    lessonsRemaining === 0
      ? 'You have finished every lesson. Time to polish the capstone.'
      : status === 'ahead'
        ? `You're moving faster than planned — about ${currentLessonsPerWeek} lessons a week.`
        : status === 'on_track'
          ? `You're on track at about ${currentLessonsPerWeek} lessons a week.`
          : `You're averaging ${currentLessonsPerWeek} lessons a week against a plan of ${recommended.lessonsPerWeek}. ` +
            'Nothing is wrong — mastery matters more than speed. Adjust your plan in Settings if the schedule no longer fits.';

  return {
    recommendedLessonsPerWeek: recommended.lessonsPerWeek,
    currentLessonsPerWeek,
    status,
    estimatedCompletionDate,
    completionPercent,
    activeDaysThisWeek,
    message,
  };
}

// ---------------------------------------------------------------------------
// Streaks
// ---------------------------------------------------------------------------

export interface StreakReport {
  current: number;
  longest: number;
  /** True when the learner has already studied today. */
  activeToday: boolean;
  /** True when yesterday was studied but today has not been, yet. */
  atRisk: boolean;
}

/**
 * Computes streaks from the dates on which the learner actually studied.
 *
 * A streak survives the current day until midnight: studying yesterday and not
 * yet today shows the streak intact but "at risk", rather than silently
 * resetting and making the learner feel they lost something they had not.
 */
export function computeStreak(studyDates: string[], today: Date = new Date()): StreakReport {
  const unique = [...new Set(studyDates)].sort();
  if (unique.length === 0) {
    return { current: 0, longest: 0, activeToday: false, atRisk: false };
  }

  let longest = 1;
  let run = 1;
  for (let i = 1; i < unique.length; i += 1) {
    const prev = unique[i - 1];
    const current = unique[i];
    if (!prev || !current) continue;
    run = dayDifference(prev, current) === 1 ? run + 1 : 1;
    longest = Math.max(longest, run);
  }

  const todayKey = isoDate(today);
  const yesterdayKey = isoDate(addDays(today, -1));
  const last = unique[unique.length - 1] ?? '';

  const activeToday = last === todayKey;
  const anchored = activeToday || last === yesterdayKey;

  let current = 0;
  if (anchored) {
    current = 1;
    for (let i = unique.length - 1; i > 0; i -= 1) {
      const a = unique[i - 1];
      const b = unique[i];
      if (!a || !b) break;
      if (dayDifference(a, b) === 1) current += 1;
      else break;
    }
  }

  return { current, longest: Math.max(longest, current), activeToday, atRisk: anchored && !activeToday };
}

// ---------------------------------------------------------------------------
// Small date helpers (UTC-based, so the same numbers appear on every device)
// ---------------------------------------------------------------------------

export function isoDate(date: Date): string {
  return date.toISOString().slice(0, 10);
}

export function addDays(date: Date, days: number): Date {
  return new Date(date.getTime() + days * MS_PER_DAY);
}

function dayDifference(a: string, b: string): number {
  return Math.round((Date.parse(`${b}T00:00:00Z`) - Date.parse(`${a}T00:00:00Z`)) / MS_PER_DAY);
}

function countActiveDaysWithin(sortedDates: string[], now: Date, windowDays: number): number {
  const cutoff = addDays(now, -(windowDays - 1)).toISOString().slice(0, 10);
  return sortedDates.filter((d) => d >= cutoff).length;
}

function round2(value: number): number {
  return Math.round(value * 100) / 100;
}

/** Formats a date for the dashboard, e.g. "12 August 2026". */
export function formatDate(date: Date | null): string {
  if (!date) return '—';
  return new Intl.DateTimeFormat('en-GB', {
    day: 'numeric',
    month: 'long',
    year: 'numeric',
    timeZone: 'UTC',
  }).format(date);
}

/** Names the ISO weekdays a learner chose, e.g. "Mon, Wed, Fri". */
export function formatStudyDays(days: number[]): string {
  const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return [...new Set(days)]
    .sort((a, b) => a - b)
    .map((d) => names[d - 1] ?? '')
    .filter(Boolean)
    .join(', ');
}
