import 'server-only';

import { cache } from 'react';
import { cookies } from 'next/headers';
import { publishedCourses } from '@/content/course';

/**
 * Which course the learner is currently working in.
 *
 * The application was single-course until the CSS course was published, and
 * every catalogue query resolved a hard-coded `html-hero`. Rather than thread a
 * course argument through several dozen call sites — and rather than restructure
 * every URL — the active course is an ambient, request-scoped value held in a
 * cookie. `getCourse`, `getRoadmap`, `getModuleGates` and `getLessonOrder` all
 * read it, so a page that asks for "the roadmap" gets the roadmap of whichever
 * course the learner switched to.
 *
 * The cookie is chosen by the browser, so it is **never** used as a query value
 * without being checked against the published courses first. A learner who
 * hand-edits it gets the default course, not a database error and not access to
 * a course that has not been published.
 */

export const ACTIVE_COURSE_COOKIE = 'active-course';

/** The course a learner starts in: the first published one in programme order. */
export function defaultCourseSlug(): string {
  return publishedCourses()[0]?.slug ?? 'html-hero';
}

/** Every slug a learner is allowed to switch to. */
export function selectableCourseSlugs(): string[] {
  return publishedCourses().map((course) => course.slug);
}

/**
 * The active course slug for this request, always one of the published courses.
 */
export const getActiveCourseSlug = cache(async (): Promise<string> => {
  const store = await cookies();
  const requested = store.get(ACTIVE_COURSE_COOKIE)?.value;

  return requested && selectableCourseSlugs().includes(requested)
    ? requested
    : defaultCourseSlug();
});
