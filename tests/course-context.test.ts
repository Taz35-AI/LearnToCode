import { describe, expect, it, vi, beforeEach } from 'vitest';

/**
 * The active-course context.
 *
 * The application was single-course, with `html-hero` hard-coded in the data
 * layer. That meant the CSS course could be authored, seeded, published — and
 * remain unreachable from every page. The active course is now an ambient value
 * held in a cookie, which puts a browser-controlled string one step away from
 * every catalogue query. These tests exist mainly to pin down that it can never
 * get there unvalidated.
 */

const cookieStore = { value: undefined as string | undefined };

vi.mock('next/headers', () => ({
  cookies: async () => ({
    get: (name: string) =>
      name === 'active-course' && cookieStore.value !== undefined
        ? { name, value: cookieStore.value }
        : undefined,
  }),
}));

// `server-only` throws when imported outside a server component build.
vi.mock('server-only', () => ({}));

const {
  ACTIVE_COURSE_COOKIE,
  defaultCourseSlug,
  getActiveCourseSlug,
  selectableCourseSlugs,
} = await import('@/lib/data/course-context');

const { publishedCourses } = await import('@/content/course');

describe('the active course', () => {
  beforeEach(() => {
    cookieStore.value = undefined;
  });

  it('defaults to the first published course when no cookie is set', async () => {
    await expect(getActiveCourseSlug()).resolves.toBe(defaultCourseSlug());
    expect(defaultCourseSlug()).toBe('html-hero');
  });

  it('honours a cookie naming a published course', async () => {
    cookieStore.value = 'css-architect';
    await expect(getActiveCourseSlug()).resolves.toBe('css-architect');
  });

  it('ignores a cookie naming a course that does not exist', async () => {
    cookieStore.value = 'does-not-exist';
    await expect(getActiveCourseSlug()).resolves.toBe(defaultCourseSlug());
  });

  it('ignores a cookie that is not a course slug at all', async () => {
    // The value reaches a `.eq('slug', …)` filter, so anything that is not on
    // the allow-list has to be discarded rather than passed through.
    for (const hostile of ["' or 1=1 --", '../../etc/passwd', '', 'HTML-HERO']) {
      cookieStore.value = hostile;
      await expect(getActiveCourseSlug()).resolves.toBe(defaultCourseSlug());
    }
  });

  it('offers exactly the published courses as choices', () => {
    expect(selectableCourseSlugs()).toEqual(publishedCourses().map((course) => course.slug));
    expect(selectableCourseSlugs()).toContain('css-architect');
  });

  it('names the cookie consistently', () => {
    expect(ACTIVE_COURSE_COOKIE).toBe('active-course');
  });
});
