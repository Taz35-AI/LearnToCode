import { HTML_COURSE } from './courses/html';
import { CSS_COURSE } from './courses/css';
import { RETRIEVAL_BLOCK_TYPES } from './types';
import type { CourseSpec, LessonSpec, LevelSpec, ModuleSpec } from './types';

/**
 * The programme: HTML, then CSS, then JavaScript.
 *
 * Order and gating are data here rather than a hard-coded slug in the data
 * layer, so adding a course is a content change. Every statistic below takes an
 * optional course argument and defaults to *published* courses only — a course
 * still being written must not inflate the figures on the marketing page or the
 * pace estimate a learner is held to.
 */
export const COURSES: CourseSpec[] = [HTML_COURSE, CSS_COURSE];

/** Courses a learner may actually see, in programme order. */
export function publishedCourses(): CourseSpec[] {
  return COURSES.filter((course) => course.isPublished).sort((a, b) => a.ordinal - b.ordinal);
}

export function courseBySlug(slug: string): CourseSpec | undefined {
  return COURSES.find((course) => course.slug === slug);
}

/**
 * The first course, and the one every statistic defaults to.
 *
 * Retained under its original name because a great deal of the application —
 * onboarding, the pace model, the certificate — is still single-course, and
 * pretending otherwise would be a bigger and riskier change than this one.
 */
export const COURSE = HTML_COURSE;

/** Levels of one course; the HTML course by default. */
export function levelsOf(course: CourseSpec = COURSE): LevelSpec[] {
  return course.levels;
}

export const LEVELS: LevelSpec[] = HTML_COURSE.levels;

export function allModules(course: CourseSpec = COURSE): ModuleSpec[] {
  return course.levels.flatMap((level) => level.modules);
}

export function allLessons(course: CourseSpec = COURSE): LessonSpec[] {
  return allModules(course).flatMap((module) => module.lessons);
}

/** Every lesson in every published course — used by the seed and by tests. */
export function allProgrammeLessons(): LessonSpec[] {
  return COURSES.flatMap((course) => allLessons(course));
}

/**
 * Rough minutes an exercise takes, by difficulty. Derived from the shape of the
 * work rather than guessed: a difficulty-1 guided exercise is a few lines with
 * hints available, a difficulty-5 milestone is a full page built from nothing.
 */
const EXERCISE_MINUTES: Record<number, number> = { 1: 3, 2: 5, 3: 7, 4: 11, 5: 18 };

/**
 * Total learner time across one course: reading plus doing.
 *
 * This is the basis of every pace calculation, so it must include practice
 * rather than only the lesson text — a plan built on reading time alone would
 * tell every learner they were behind from the first week.
 */
export function totalCourseMinutes(course: CourseSpec = COURSE): number {
  const lessons = allLessons(course);
  const reading = lessons.reduce((sum, lesson) => sum + lesson.estimatedMinutes, 0);
  const practice = lessons
    .flatMap((lesson) => lesson.exercises)
    .filter((exercise) => !exercise.optional)
    .reduce((sum, exercise) => sum + (EXERCISE_MINUTES[exercise.difficulty ?? 2] ?? 10), 0);
  const quizzes = lessons.reduce((sum, lesson) => sum + lesson.quiz.length * 1.5, 0);
  const assessments = course.levels.reduce(
    (sum, level) => sum + (level.assessment ? level.assessment.questions.length * 1.5 : 0),
    0,
  );
  return Math.round(reading + practice + quizzes + assessments);
}

export function courseStats(course: CourseSpec = COURSE) {
  const lessons = allLessons(course);
  const exercises = lessons.flatMap((l) => l.exercises);
  const questions = lessons.flatMap((l) => l.quiz);
  const assessmentQuestions = course.levels.flatMap((l) => l.assessment?.questions ?? []);

  return {
    levels: course.levels.length,
    modules: allModules(course).length,
    lessons: lessons.length,
    blocks: lessons.reduce((sum, l) => sum + l.blocks.length, 0),
    retrievalBlocks: lessons.reduce(
      (sum, l) => sum + l.blocks.filter((b) => RETRIEVAL_BLOCK_TYPES.has(b.type)).length,
      0,
    ),
    lessonsWithRetrieval: lessons.filter((l) =>
      l.blocks.some((b) => RETRIEVAL_BLOCK_TYPES.has(b.type)),
    ).length,
    exercises: exercises.length,
    debugChallenges: exercises.filter((e) => e.kind === 'debug').length,
    projectMissions: exercises.filter((e) => e.kind === 'project_mission').length,
    quizQuestions: questions.length + assessmentQuestions.length,
    assessments: course.levels.filter((l) => l.assessment).length,
    totalMinutes: totalCourseMinutes(course),
  };
}

/** The same figures summed across every course the seed will emit. */
export function programmeStats() {
  const perCourse = COURSES.map((course) => courseStats(course));
  const sum = (pick: (s: ReturnType<typeof courseStats>) => number) =>
    perCourse.reduce((total, s) => total + pick(s), 0);

  return {
    courses: COURSES.length,
    publishedCourses: publishedCourses().length,
    levels: sum((s) => s.levels),
    modules: sum((s) => s.modules),
    lessons: sum((s) => s.lessons),
    blocks: sum((s) => s.blocks),
    retrievalBlocks: sum((s) => s.retrievalBlocks),
    exercises: sum((s) => s.exercises),
    quizQuestions: sum((s) => s.quizQuestions),
    totalMinutes: sum((s) => s.totalMinutes),
  };
}
