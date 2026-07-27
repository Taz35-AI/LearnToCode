import { LEVEL_01 } from './levels/level-01';
import { LEVEL_02 } from './levels/level-02';
import { LEVEL_03 } from './levels/level-03';
import { LEVEL_04 } from './levels/level-04';
import { LEVEL_05 } from './levels/level-05';
import { LEVEL_06 } from './levels/level-06';
import { LEVEL_07 } from './levels/level-07';
import { LEVEL_08 } from './levels/level-08';
import { LEVEL_09 } from './levels/level-09';
import { LEVEL_10 } from './levels/level-10';
import { LEVEL_11 } from './levels/level-11';
import { LEVEL_12 } from './levels/level-12';
import type { LessonSpec, LevelSpec, ModuleSpec } from './types';

/**
 * The complete HTML Hero curriculum.
 *
 * Twelve mastery levels, not thirty days. The recommended pace is derived from
 * the total teaching time below and the learner's own answers during
 * onboarding — the curriculum itself contains no calendar at all.
 */
export const COURSE = {
  slug: 'html-hero',
  title: 'HTML Hero',
  subtitle: 'From complete beginner to production-quality HTML',
  description:
    'A mastery-based journey through modern HTML. Twelve levels, each unlocked by demonstrated understanding rather than elapsed time. You build one real website throughout, and finish able to build, validate, improve, export and publish a professional multi-page site.',
  recommendedDays: 30,
  recommendedMinutesPerDay: 60,
  version: '1.0.0',
} as const;

export const LEVELS: LevelSpec[] = [
  LEVEL_01,
  LEVEL_02,
  LEVEL_03,
  LEVEL_04,
  LEVEL_05,
  LEVEL_06,
  LEVEL_07,
  LEVEL_08,
  LEVEL_09,
  LEVEL_10,
  LEVEL_11,
  LEVEL_12,
];

export function allModules(): ModuleSpec[] {
  return LEVELS.flatMap((level) => level.modules);
}

export function allLessons(): LessonSpec[] {
  return allModules().flatMap((module) => module.lessons);
}

/**
 * Rough minutes an exercise takes, by difficulty. Derived from the shape of the
 * work rather than guessed: a difficulty-1 guided exercise is a few lines with
 * hints available, a difficulty-5 milestone is a full page built from nothing.
 */
const EXERCISE_MINUTES: Record<number, number> = { 1: 3, 2: 5, 3: 7, 4: 11, 5: 18 };

/**
 * Total learner time across the whole course: reading plus doing.
 *
 * This is the basis of every pace calculation, so it must include practice
 * rather than only the lesson text — a plan built on reading time alone would
 * tell every learner they were behind from the first week.
 */
export function totalCourseMinutes(): number {
  const reading = allLessons().reduce((sum, lesson) => sum + lesson.estimatedMinutes, 0);
  const practice = allLessons()
    .flatMap((lesson) => lesson.exercises)
    .filter((exercise) => !exercise.optional)
    .reduce((sum, exercise) => sum + (EXERCISE_MINUTES[exercise.difficulty ?? 2] ?? 10), 0);
  const quizzes = allLessons().reduce((sum, lesson) => sum + lesson.quiz.length * 1.5, 0);
  const assessments = LEVELS.reduce(
    (sum, level) => sum + (level.assessment ? level.assessment.questions.length * 1.5 : 0),
    0,
  );
  return Math.round(reading + practice + quizzes + assessments);
}

export function courseStats() {
  const lessons = allLessons();
  const exercises = lessons.flatMap((l) => l.exercises);
  const questions = lessons.flatMap((l) => l.quiz);
  const assessmentQuestions = LEVELS.flatMap((l) => l.assessment?.questions ?? []);

  return {
    levels: LEVELS.length,
    modules: allModules().length,
    lessons: lessons.length,
    blocks: lessons.reduce((sum, l) => sum + l.blocks.length, 0),
    exercises: exercises.length,
    debugChallenges: exercises.filter((e) => e.kind === 'debug').length,
    projectMissions: exercises.filter((e) => e.kind === 'project_mission').length,
    quizQuestions: questions.length + assessmentQuestions.length,
    assessments: LEVELS.filter((l) => l.assessment).length,
    totalMinutes: totalCourseMinutes(),
  };
}
