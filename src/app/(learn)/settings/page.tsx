import type { Metadata } from 'next';
import { redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { getLearningPlan, getProfile } from '@/lib/data/learner';
import { updateSettingsAction } from '@/lib/actions/onboarding';
import { SettingsForm } from '@/components/learn/settings-form';

export const metadata: Metadata = {
  title: 'Settings',
  description: 'Your details, appearance and study plan.',
  robots: { index: false, follow: false },
};

export default async function SettingsPage() {
  const user = await getCurrentUser();
  if (!user) redirect('/login');

  const [profile, plan] = await Promise.all([getProfile(user.id), getLearningPlan(user.id)]);

  return (
    <div className="max-w-2xl p-5 lg:p-10">
      <header className="mb-7">
        <h1 className="text-2xl font-bold text-ink lg:text-3xl">Settings</h1>
        <p className="mt-2 text-muted">
          Nothing here affects what you have already learned. Adjusting your plan only changes the
          estimate, never your progress.
        </p>
      </header>

      <SettingsForm
        action={updateSettingsAction}
        initial={{
          displayName: profile?.display_name ?? 'Learner',
          theme: profile?.theme ?? 'system',
          reducedMotion: profile?.reduced_motion ?? false,
          minutesPerDay: plan?.minutes_per_day ?? 60,
          studyDays: plan?.study_days ?? [1, 2, 3, 4, 5],
          targetCompletionDate: plan?.target_completion_date ?? null,
        }}
      />
    </div>
  );
}
