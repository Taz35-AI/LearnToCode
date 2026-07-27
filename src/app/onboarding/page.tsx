import type { Metadata } from 'next';
import { redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { getProjectTemplates } from '@/lib/data/catalogue';
import { getProfile } from '@/lib/data/learner';
import { completeOnboardingAction } from '@/lib/actions/onboarding';
import { OnboardingFlow, type ProjectChoice } from '@/components/learn/onboarding-flow';
import { getMedia } from '@/content/media/manifest';
import { allLessons, totalCourseMinutes } from '@/content/course';
import { isSupabaseConfigured } from '@/lib/env';
import { SetupRequired } from '@/components/learn/setup-required';

export const metadata: Metadata = {
  title: 'Set up your learning plan',
  description: 'Tell us how you learn, and we will build a plan around it.',
  robots: { index: false, follow: false },
};

export default async function OnboardingPage() {
  if (!isSupabaseConfigured()) return <SetupRequired />;

  const user = await getCurrentUser();
  if (!user) redirect('/login?next=/onboarding');

  const [profile, templates] = await Promise.all([getProfile(user.id), getProjectTemplates()]);

  // Already onboarded — nothing to do here.
  if (profile?.onboarding_completed_at) redirect('/dashboard');

  const projects: ProjectChoice[] = templates.map((template) => {
    const hero = template.hero_media_slug ? getMedia(template.hero_media_slug) : undefined;
    return {
      slug: template.slug,
      name: template.name,
      tagline: template.tagline,
      description: template.description,
      audience: template.audience,
      heroPath: hero?.path ?? '/learning-media/svg/placeholder.svg',
    };
  });

  return (
    <OnboardingFlow
      action={completeOnboardingAction}
      defaultName={profile?.display_name ?? 'Learner'}
      projects={projects}
      totalLessons={allLessons().length}
      totalMinutes={totalCourseMinutes()}
    />
  );
}
