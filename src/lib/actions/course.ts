'use server';

import { revalidatePath } from 'next/cache';
import { cookies } from 'next/headers';
import { ACTIVE_COURSE_COOKIE, selectableCourseSlugs } from '@/lib/data/course-context';

/**
 * Switches which course the learner is working in.
 *
 * The slug is checked against the published courses before it is written. A
 * cookie is browser-controlled, so accepting one unvalidated would let a
 * hand-edited value reach every catalogue query — and would expose a course
 * that has deliberately not been published yet.
 */
export async function setActiveCourseAction(formData: FormData): Promise<void> {
  const requested = formData.get('course');
  if (typeof requested !== 'string' || !selectableCourseSlugs().includes(requested)) {
    return;
  }

  const store = await cookies();
  store.set(ACTIVE_COURSE_COOKIE, requested, {
    httpOnly: true,
    sameSite: 'lax',
    secure: process.env.NODE_ENV === 'production',
    path: '/',
    // A year: which course you are studying is a preference, not a session.
    maxAge: 60 * 60 * 24 * 365,
  });

  // Every learner surface is scoped to the active course, so all of them are
  // now stale.
  revalidatePath('/', 'layout');
}
