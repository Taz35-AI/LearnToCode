/**
 * Achievement evaluation.
 *
 * Achievements are data (`achievements.criteria`, a JSON object), so a new one
 * can be added by inserting a row. This module knows how to read the criteria
 * shapes and decide whether a learner has earned each one.
 *
 * Every unlock is idempotent: `user_achievements` has a UNIQUE constraint on
 * `(user_id, achievement_id)`, and the XP that comes with an achievement is
 * keyed on the achievement id, so an achievement can never pay out twice.
 */

export type AchievementCriteria =
  | { type: 'lessons_completed'; count: number }
  | { type: 'exercises_passed'; count: number }
  | { type: 'level_completed'; levelSlug: string }
  | { type: 'module_completed'; moduleSlug: string }
  | { type: 'skill_mastered'; skillSlug: string }
  | { type: 'skills_mastered'; count: number }
  | { type: 'streak_days'; days: number }
  | { type: 'first_pass_streak'; count: number }
  | { type: 'debug_challenges'; count: number }
  | { type: 'project_pages'; count: number }
  | { type: 'project_complete' }
  | { type: 'course_complete' }
  | { type: 'xp_total'; amount: number };

export interface AchievementSnapshot {
  lessonsCompleted: number;
  exercisesPassed: number;
  debugChallengesPassed: number;
  /** Exercises passed on the first attempt with no hints, consecutively. */
  currentFirstPassStreak: number;
  completedLevelSlugs: ReadonlySet<string>;
  completedModuleSlugs: ReadonlySet<string>;
  masteredSkillSlugs: ReadonlySet<string>;
  streakDays: number;
  projectPageCount: number;
  projectComplete: boolean;
  courseComplete: boolean;
  totalXp: number;
}

export const EMPTY_SNAPSHOT: AchievementSnapshot = {
  lessonsCompleted: 0,
  exercisesPassed: 0,
  debugChallengesPassed: 0,
  currentFirstPassStreak: 0,
  completedLevelSlugs: new Set(),
  completedModuleSlugs: new Set(),
  masteredSkillSlugs: new Set(),
  streakDays: 0,
  projectPageCount: 0,
  projectComplete: false,
  courseComplete: false,
  totalXp: 0,
};

/** Type guard: is this JSON blob a criteria shape we understand? */
export function isAchievementCriteria(value: unknown): value is AchievementCriteria {
  if (typeof value !== 'object' || value === null) return false;
  const type = (value as { type?: unknown }).type;
  return typeof type === 'string';
}

export function meetsCriteria(
  criteria: AchievementCriteria,
  snapshot: AchievementSnapshot,
): boolean {
  switch (criteria.type) {
    case 'lessons_completed':
      return snapshot.lessonsCompleted >= criteria.count;
    case 'exercises_passed':
      return snapshot.exercisesPassed >= criteria.count;
    case 'level_completed':
      return snapshot.completedLevelSlugs.has(criteria.levelSlug);
    case 'module_completed':
      return snapshot.completedModuleSlugs.has(criteria.moduleSlug);
    case 'skill_mastered':
      return snapshot.masteredSkillSlugs.has(criteria.skillSlug);
    case 'skills_mastered':
      return snapshot.masteredSkillSlugs.size >= criteria.count;
    case 'streak_days':
      return snapshot.streakDays >= criteria.days;
    case 'first_pass_streak':
      return snapshot.currentFirstPassStreak >= criteria.count;
    case 'debug_challenges':
      return snapshot.debugChallengesPassed >= criteria.count;
    case 'project_pages':
      return snapshot.projectPageCount >= criteria.count;
    case 'project_complete':
      return snapshot.projectComplete;
    case 'course_complete':
      return snapshot.courseComplete;
    case 'xp_total':
      return snapshot.totalXp >= criteria.amount;
    default:
      return false;
  }
}

export interface AchievementDefinition {
  id: string;
  slug: string;
  name: string;
  criteria: unknown;
  xpAward: number;
}

/**
 * Returns achievements the learner has newly earned.
 *
 * Already-unlocked achievements are filtered out here as a courtesy; the
 * database constraint is what actually guarantees single payment.
 */
export function newlyUnlocked(
  definitions: AchievementDefinition[],
  snapshot: AchievementSnapshot,
  alreadyUnlocked: ReadonlySet<string>,
): AchievementDefinition[] {
  return definitions.filter((definition) => {
    if (alreadyUnlocked.has(definition.id)) return false;
    if (!isAchievementCriteria(definition.criteria)) return false;
    return meetsCriteria(definition.criteria, snapshot);
  });
}

/**
 * Progress towards an achievement, for the "almost there" display.
 * Returns null for criteria that are boolean rather than countable.
 */
export function criteriaProgress(
  criteria: AchievementCriteria,
  snapshot: AchievementSnapshot,
): { current: number; target: number } | null {
  switch (criteria.type) {
    case 'lessons_completed':
      return { current: snapshot.lessonsCompleted, target: criteria.count };
    case 'exercises_passed':
      return { current: snapshot.exercisesPassed, target: criteria.count };
    case 'skills_mastered':
      return { current: snapshot.masteredSkillSlugs.size, target: criteria.count };
    case 'streak_days':
      return { current: snapshot.streakDays, target: criteria.days };
    case 'first_pass_streak':
      return { current: snapshot.currentFirstPassStreak, target: criteria.count };
    case 'debug_challenges':
      return { current: snapshot.debugChallengesPassed, target: criteria.count };
    case 'project_pages':
      return { current: snapshot.projectPageCount, target: criteria.count };
    case 'xp_total':
      return { current: snapshot.totalXp, target: criteria.amount };
    default:
      return null;
  }
}
