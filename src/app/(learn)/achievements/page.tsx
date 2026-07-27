import type { Metadata } from 'next';
import { redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { getAchievements } from '@/lib/data/catalogue';
import { getUserAchievements } from '@/lib/data/learner';
import { Badge, Card, ProgressBar } from '@/components/ui';
import { TrophyIcon } from '@/components/ui/icons';
import { cx, relativeTime } from '@/lib/utils';

export const metadata: Metadata = {
  title: 'Achievements',
  description: 'Milestones you have earned on the way to HTML Hero.',
};

const TIER_TONE: Record<string, 'neutral' | 'accent' | 'warning' | 'success'> = {
  bronze: 'neutral',
  silver: 'accent',
  gold: 'warning',
  platinum: 'success',
};

export default async function AchievementsPage() {
  const user = await getCurrentUser();
  if (!user) redirect('/login');

  const [definitions, unlocked] = await Promise.all([
    getAchievements(),
    getUserAchievements(user.id),
  ]);

  const unlockedAt = new Map(unlocked.map((entry) => [entry.achievement_id, entry.unlocked_at]));

  return (
    <div className="max-w-4xl p-5 lg:p-10">
      <header className="mb-7">
        <h1 className="text-2xl font-bold text-ink lg:text-3xl">Achievements</h1>
        <p className="mt-2 max-w-2xl text-muted">
          Each one marks something you genuinely did — a skill mastered, a level finished, a run of
          clean first attempts. There is nothing here for logging in.
        </p>
        <div className="mt-4 max-w-md">
          <ProgressBar
            value={unlocked.length}
            max={definitions.length}
            label="Achievements unlocked"
            showValue
          />
        </div>
      </header>

      <ul className="grid gap-3 sm:grid-cols-2">
        {definitions.map((achievement) => {
          const when = unlockedAt.get(achievement.id);
          const isUnlocked = Boolean(when);

          return (
            <li key={achievement.id}>
              <Card
                className={cx(
                  'h-full p-4',
                  isUnlocked
                    ? 'border-[hsl(var(--accent-border))]'
                    : 'opacity-65',
                )}
              >
                <div className="flex items-start gap-3">
                  <span
                    className={cx(
                      'grid h-10 w-10 shrink-0 place-items-center rounded-lg',
                      isUnlocked
                        ? 'bg-[hsl(var(--accent-soft))] text-[hsl(var(--accent))]'
                        : 'bg-[hsl(var(--bg-subtle))] text-faint',
                    )}
                    aria-hidden="true"
                  >
                    <TrophyIcon size={20} />
                  </span>
                  <div className="min-w-0 flex-1">
                    <div className="flex flex-wrap items-center gap-2">
                      <h2 className="font-semibold text-ink">{achievement.name}</h2>
                      <Badge tone={TIER_TONE[achievement.tier] ?? 'neutral'}>
                        {achievement.tier}
                      </Badge>
                    </div>
                    <p className="mt-1 text-sm text-muted">{achievement.description}</p>
                    <p className="mt-2 text-xs text-faint">
                      {isUnlocked
                        ? `Unlocked ${relativeTime(when)} · +${achievement.xp_award} XP`
                        : `Worth ${achievement.xp_award} XP`}
                    </p>
                  </div>
                </div>
              </Card>
            </li>
          );
        })}
      </ul>
    </div>
  );
}
