import { redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { getProfile, getStudyDates, getTotalXp } from '@/lib/data/learner';
import { learnerLevel } from '@/lib/progress/xp';
import { computeStreak } from '@/lib/progress/pace';
import { logoutAction } from '@/lib/actions/auth';
import { setActiveCourseAction } from '@/lib/actions/course';
import { getCourses } from '@/lib/data/catalogue';
import { getActiveCourseSlug } from '@/lib/data/course-context';
import { AppShell } from '@/components/learn/app-shell';
import { isSupabaseConfigured } from '@/lib/env';
import { SetupRequired } from '@/components/learn/setup-required';

/**
 * The protected learner shell.
 *
 * Middleware already redirects unauthenticated requests, but this checks again:
 * a layout that renders learner data must never rely on middleware alone, since
 * middleware can be bypassed by configuration mistakes and this cannot.
 */
export default async function LearnLayout({ children }: { children: React.ReactNode }) {
  if (!isSupabaseConfigured()) {
    return <SetupRequired />;
  }

  const user = await getCurrentUser();
  if (!user) redirect('/login');

  const [profile, totalXp, studyDates, courses, activeCourseSlug] = await Promise.all([
    getProfile(user.id),
    getTotalXp(user.id),
    getStudyDates(user.id),
    getCourses(),
    getActiveCourseSlug(),
  ]);

  // A learner who has not finished onboarding has no plan, so send them there.
  if (profile && !profile.onboarding_completed_at) {
    redirect('/onboarding');
  }

  const level = learnerLevel(totalXp);
  const streak = computeStreak(studyDates);

  return (
    <AppShell
      displayName={profile?.display_name ?? 'Learner'}
      totalXp={totalXp}
      learnerLevel={level.level}
      streakDays={streak.current}
      onSignOut={logoutAction}
      courses={courses.map(({ slug, title }) => ({ slug, title }))}
      activeCourseSlug={activeCourseSlug}
      courseTitle={courses.find((c) => c.slug === activeCourseSlug)?.title ?? 'HTML Hero'}
      onSwitchCourse={setActiveCourseAction}
    >
      {children}
    </AppShell>
  );
}
