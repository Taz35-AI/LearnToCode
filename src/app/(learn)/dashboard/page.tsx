import type { Metadata } from 'next';
import Link from 'next/link';
import { redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { getDashboardData, getUserAchievements, getRecentAttempts } from '@/lib/data/learner';
import { getAchievements, getRoadmap, getSkills } from '@/lib/data/catalogue';
import { getSkillMastery } from '@/lib/data/learner';
import { formatDate, formatStudyDays } from '@/lib/progress/pace';
import { MASTERY_THRESHOLDS } from '@/lib/progress/mastery';
import { Badge, ButtonLink, Card, CardHeader, EmptyState, ProgressBar, Stat } from '@/components/ui';
import {
  ArrowRightIcon,
  CheckCircleIcon,
  ClockIcon,
  FlameIcon,
  FolderIcon,
  LockIcon,
  SparkIcon,
  TargetIcon,
  TrophyIcon,
} from '@/components/ui/icons';
import { cx, formatStudyTime, percent, relativeTime } from '@/lib/utils';

export const metadata: Metadata = {
  title: 'Dashboard',
  description: 'Your progress, your pace and your next lesson.',
};

/**
 * The learner dashboard.
 *
 * The primary action — continue learning — is the largest thing on the page and
 * is always present. Everything else is context. The roadmap is shown as levels
 * and modules, never as a thirty-day calendar; the only dates on this page are
 * the learner's own estimated completion and their study streak.
 */
export default async function DashboardPage() {
  const user = await getCurrentUser();
  if (!user) redirect('/login');

  const [data, roadmap, skills, mastery, achievementDefs, unlocked, attempts] = await Promise.all([
    getDashboardData(user.id),
    getRoadmap(),
    getSkills(),
    getSkillMastery(user.id),
    getAchievements(),
    getUserAchievements(user.id),
    getRecentAttempts(user.id, 6),
  ]);

  if (roadmap.length === 0) {
    return (
      <div className="p-6 lg:p-10">
        <EmptyState
          title="The course has not been loaded yet"
          description="Run the database migrations, then npm run seed:generate and load supabase/seed.sql into your Supabase project."
          action={
            <ButtonLink href="/settings" variant="secondary">
              Open settings
            </ButtonLink>
          }
        />
      </div>
    );
  }

  const masteryBySkill = new Map(mastery.map((m) => [m.skill_id, m]));
  const masteredSkills = skills.filter(
    (s) => (masteryBySkill.get(s.id)?.state ?? 'untouched') === 'mastered',
  );
  const weakSkills = skills.filter((s) => masteryBySkill.get(s.id)?.needs_practice);

  const recentAchievements = unlocked
    .slice(0, 3)
    .map((entry) => achievementDefs.find((a) => a.id === entry.achievement_id))
    .filter((a): a is NonNullable<typeof a> => Boolean(a));

  const paceTone =
    data.pace.status === 'ahead' ? 'success' : data.pace.status === 'behind' ? 'warning' : 'accent';

  return (
    <div className="p-5 lg:p-10 max-w-6xl">
      <header className="mb-7">
        <h1 className="text-2xl font-bold text-ink lg:text-3xl">
          {greeting()}, {data.profile?.display_name ?? 'Learner'}
        </h1>
        <p className="mt-1 text-muted">{data.pace.message}</p>
      </header>

      {/* ---- The primary action ---- */}
      {data.nextLesson ? (
        <Card className="mb-7 overflow-hidden border-[hsl(var(--accent-border))]">
          <div className="bg-[hsl(var(--accent-soft))] px-5 py-5 sm:px-7 sm:py-6">
            <p className="text-xs font-bold uppercase tracking-wide text-accent">
              Next up · {data.nextLesson.levelTitle} · {data.nextLesson.moduleTitle}
            </p>
            <h2 className="mt-1.5 text-xl font-bold text-ink sm:text-2xl text-balance">
              {data.nextLesson.title}
            </h2>
            <ButtonLink href={`/lesson/${data.nextLesson.slug}`} size="lg" className="mt-4">
              Continue learning
              <ArrowRightIcon size={18} />
            </ButtonLink>
          </div>
        </Card>
      ) : (
        <Card className="mb-7">
          <EmptyState
            title="Every lesson is complete"
            description="Finish your capstone project and take the final assessment to earn your certificate."
            icon={<TrophyIcon size={32} />}
            action={<ButtonLink href="/project">Open my project</ButtonLink>}
          />
        </Card>
      )}

      {/* ---- Stats ---- */}
      <div className="mb-7 grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
        <Stat
          label="Total XP"
          value={data.totalXp.toLocaleString('en-GB')}
          hint={`Level ${data.level.level} · ${data.level.xpToNextLevel} XP to level ${data.level.level + 1}`}
          icon={<SparkIcon size={14} />}
        />
        <Stat
          label="Streak"
          value={data.streak.current === 0 ? '—' : `${data.streak.current} days`}
          hint={
            data.streak.activeToday
              ? 'Studied today'
              : data.streak.atRisk
                ? 'Study today to keep it'
                : `Longest: ${data.streak.longest} days`
          }
          icon={<FlameIcon size={14} />}
        />
        <Stat
          label="Skills mastered"
          value={`${masteredSkills.length} / ${skills.length}`}
          hint={weakSkills.length > 0 ? `${weakSkills.length} need more practice` : 'Nothing flagged'}
          icon={<TargetIcon size={14} />}
        />
        <Stat
          label="Study time"
          value={formatStudyTime(data.studySeconds)}
          hint={`${data.pace.activeDaysThisWeek} active days this week`}
          icon={<ClockIcon size={14} />}
        />
      </div>

      <div className="grid gap-5 lg:grid-cols-3">
        {/* ---- Left column ---- */}
        <div className="space-y-5 lg:col-span-2">
          {/* Overall progress */}
          <Card>
            <CardHeader
              title="Course progress"
              description={`${data.lessonsCompleted} of ${data.totalLessons} lessons complete`}
              action={
                <ButtonLink href="/roadmap" variant="ghost" size="sm">
                  Full roadmap
                </ButtonLink>
              }
            />
            <div className="px-5 pb-5">
              <ProgressBar
                value={data.lessonsCompleted}
                max={data.totalLessons}
                label="Lessons completed"
                showValue
              />

              <ol className="mt-5 space-y-2">
                {roadmap.map((level, index) => {
                  const lessons = level.modules.flatMap((m) => m.lessons);
                  const done = level.modules.reduce(
                    (sum, m) => sum + (data.moduleCompletion.get(m.id)?.completed ?? 0),
                    0,
                  );
                  const isUnlocked = level.modules.some((m) => data.unlockedModuleIds.has(m.id));
                  const isComplete = lessons.length > 0 && done === lessons.length;

                  return (
                    <li key={level.id}>
                      <Link
                        href={`/roadmap#${level.slug}`}
                        className={cx(
                          'flex items-center gap-3 rounded-lg border p-3 transition-colors',
                          isComplete
                            ? 'border-[hsl(var(--success)/0.35)] bg-[hsl(var(--success-soft))]'
                            : isUnlocked
                              ? 'border-app hover:border-strong'
                              : 'border-app opacity-60',
                        )}
                      >
                        <span
                          className={cx(
                            'grid h-8 w-8 shrink-0 place-items-center rounded-lg text-sm font-bold',
                            isComplete
                              ? 'bg-[hsl(var(--success))] text-white'
                              : isUnlocked
                                ? 'bg-[hsl(var(--accent-soft))] text-[hsl(var(--accent))]'
                                : 'bg-[hsl(var(--bg-subtle))] text-faint',
                          )}
                        >
                          {isComplete ? <CheckCircleIcon size={16} /> : isUnlocked ? index + 1 : <LockIcon size={14} />}
                        </span>
                        <span className="min-w-0 flex-1">
                          <span className="block truncate text-sm font-semibold text-ink">
                            {level.title}
                          </span>
                          <span className="block text-xs text-muted">
                            {done} of {lessons.length} lessons
                          </span>
                        </span>
                        <span className="shrink-0 text-sm font-semibold tabular-nums text-muted">
                          {percent(done, lessons.length)}%
                        </span>
                      </Link>
                    </li>
                  );
                })}
              </ol>
            </div>
          </Card>

          {/* Skills */}
          <Card>
            <CardHeader
              title="Skill mastery"
              description="Mastery is earned by demonstrating a skill, not by finishing a lesson."
            />
            <div className="px-5 pb-5">
              <ul className="grid gap-2.5 sm:grid-cols-2">
                {skills.map((skill) => {
                  const record = masteryBySkill.get(skill.id);
                  const value = Number(record?.mastery ?? 0);
                  const tone =
                    record?.state === 'mastered'
                      ? 'success'
                      : value < MASTERY_THRESHOLDS.needsPractice && record
                        ? 'warning'
                        : 'accent';

                  return (
                    <li key={skill.id} className="rounded-lg border border-app p-3">
                      <div className="mb-1.5 flex items-baseline justify-between gap-2">
                        <span className="truncate text-sm font-medium text-ink">{skill.name}</span>
                        <span className="shrink-0 text-xs font-semibold tabular-nums text-muted">
                          {Math.round(value * 100)}%
                        </span>
                      </div>
                      <ProgressBar
                        value={value * 100}
                        label={`${skill.name} mastery`}
                        tone={tone}
                        size="sm"
                      />
                    </li>
                  );
                })}
              </ul>
            </div>
          </Card>

          {/* Recent activity */}
          <Card>
            <CardHeader title="Recent activity" />
            <div className="px-5 pb-5">
              {attempts.length === 0 ? (
                <p className="py-4 text-sm text-muted">
                  Nothing yet. Your exercise attempts will appear here.
                </p>
              ) : (
                <ul className="divide-y divide-[hsl(var(--border))]">
                  {attempts.map((attempt) => (
                    <li key={attempt.id} className="flex items-center gap-3 py-2.5">
                      <span
                        className={cx(
                          'shrink-0',
                          attempt.passed ? 'text-[hsl(var(--success))]' : 'text-[hsl(var(--warning))]',
                        )}
                        aria-hidden="true"
                      >
                        <CheckCircleIcon size={16} />
                      </span>
                      <span className="min-w-0 flex-1 text-sm text-ink">
                        {attempt.passed ? 'Passed an exercise' : 'Attempted an exercise'}
                        <span className="ml-2 text-xs text-muted">
                          {Math.round(Number(attempt.score) * 100)}% of requirements met
                        </span>
                      </span>
                      <span className="shrink-0 text-xs text-faint">
                        {relativeTime(attempt.created_at)}
                      </span>
                    </li>
                  ))}
                </ul>
              )}
            </div>
          </Card>
        </div>

        {/* ---- Right column ---- */}
        <div className="space-y-5">
          {/* Pace */}
          <Card>
            <CardHeader title="Your pace" />
            <div className="space-y-3 px-5 pb-5 text-sm">
              <Row label="Recommended" value={`${data.pace.recommendedLessonsPerWeek} lessons/week`} />
              <Row
                label="Your actual pace"
                value={`${data.pace.currentLessonsPerWeek} lessons/week`}
                badge={
                  <Badge tone={paceTone}>
                    {data.pace.status === 'not_started'
                      ? 'Not started'
                      : data.pace.status === 'ahead'
                        ? 'Ahead'
                        : data.pace.status === 'on_track'
                          ? 'On track'
                          : 'Behind'}
                  </Badge>
                }
              />
              <Row
                label="Estimated finish"
                value={formatDate(data.pace.estimatedCompletionDate)}
              />
              {data.plan ? (
                <>
                  <Row label="Study days" value={formatStudyDays(data.plan.study_days)} />
                  <Row label="Session length" value={`${data.plan.minutes_per_day} minutes`} />
                </>
              ) : null}
              <p className="border-t border-app pt-3 text-xs text-muted">
                This estimate comes from the lessons you have actually completed, and updates every
                time you finish one. Adjust your plan in{' '}
                <Link href="/settings" className="text-accent underline underline-offset-2">
                  Settings
                </Link>{' '}
                whenever your week changes.
              </p>
            </div>
          </Card>

          {/* Practice queue */}
          <Card>
            <CardHeader
              title="Needs more practice"
              description="Chosen from your actual results, not a fixed schedule."
            />
            <div className="px-5 pb-5">
              {data.practiceQueue.length === 0 ? (
                <p className="py-3 text-sm text-muted">
                  Nothing flagged. Everything you have attempted is holding up well.
                </p>
              ) : (
                <>
                  <ul className="space-y-2.5">
                    {data.practiceQueue.slice(0, 4).map((item) => (
                      <li key={item.skillId} className="rounded-lg border border-app p-3">
                        <p className="text-sm font-semibold text-ink">{item.skillName}</p>
                        <p className="mt-0.5 text-xs text-muted">{item.reason}</p>
                        <div className="mt-2">
                          <ProgressBar
                            value={item.mastery * 100}
                            label={`${item.skillName} mastery`}
                            tone="warning"
                            size="sm"
                          />
                        </div>
                      </li>
                    ))}
                  </ul>
                  <ButtonLink href="/practice" variant="secondary" size="sm" className="mt-4 w-full">
                    Open practice
                  </ButtonLink>
                </>
              )}
            </div>
          </Card>

          {/* Project */}
          <Card>
            <CardHeader title="Final project" />
            <div className="px-5 pb-5">
              {data.project ? (
                <>
                  <p className="text-sm font-semibold text-ink">{data.project.name}</p>
                  <p className="mt-0.5 text-xs text-muted">
                    {data.projectFileCount} {data.projectFileCount === 1 ? 'page' : 'pages'}
                  </p>
                  <div className="mt-3">
                    <ProgressBar
                      value={data.project.completion_percent}
                      label="Project completion"
                      showValue
                    />
                  </div>
                  <ButtonLink href="/project" variant="secondary" size="sm" className="mt-4 w-full">
                    <FolderIcon size={15} />
                    Open my project
                  </ButtonLink>
                </>
              ) : (
                <p className="py-3 text-sm text-muted">
                  Your capstone project is created during onboarding.
                </p>
              )}
            </div>
          </Card>

          {/* Achievements */}
          <Card>
            <CardHeader
              title="Recent achievements"
              action={
                <ButtonLink href="/achievements" variant="ghost" size="sm">
                  All
                </ButtonLink>
              }
            />
            <div className="px-5 pb-5">
              {recentAchievements.length === 0 ? (
                <p className="py-3 text-sm text-muted">
                  Your first achievement arrives when you finish the opening module.
                </p>
              ) : (
                <ul className="space-y-2.5">
                  {recentAchievements.map((achievement) => (
                    <li key={achievement.id} className="flex gap-3">
                      <span className="mt-0.5 shrink-0 text-[hsl(var(--warning))]" aria-hidden="true">
                        <TrophyIcon size={18} />
                      </span>
                      <span className="min-w-0">
                        <span className="block text-sm font-semibold text-ink">
                          {achievement.name}
                        </span>
                        <span className="block text-xs text-muted">{achievement.description}</span>
                      </span>
                    </li>
                  ))}
                </ul>
              )}
            </div>
          </Card>
        </div>
      </div>
    </div>
  );
}

function Row({ label, value, badge }: { label: string; value: string; badge?: React.ReactNode }) {
  return (
    <div className="flex items-baseline justify-between gap-3">
      <span className="text-muted">{label}</span>
      <span className="flex items-center gap-2 text-right font-semibold text-ink">
        {value}
        {badge}
      </span>
    </div>
  );
}

function greeting(): string {
  const hour = new Date().getUTCHours();
  if (hour < 12) return 'Good morning';
  if (hour < 18) return 'Good afternoon';
  return 'Good evening';
}
