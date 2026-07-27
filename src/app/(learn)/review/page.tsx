import type { Metadata } from 'next';
import Link from 'next/link';
import { redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { composeSession, getCalibrationHistory } from '@/lib/data/review';
import { getLessonProgress, getProfile } from '@/lib/data/learner';
import { getRoadmap } from '@/lib/data/catalogue';
import { dueNowCount, reviewForecast } from '@/lib/review/session';
import { reviewDate } from '@/lib/review/scheduler';
import { blindSpots, calibrationMessage, calibrationReport } from '@/lib/review/calibration';
import { ReviewSession } from '@/components/learn/review-session';
import { Badge, Card, CardHeader, EmptyState } from '@/components/ui';

export const metadata: Metadata = {
  title: 'Review',
  description: 'Spaced review, scheduled from how memory actually decays.',
};

/**
 * The review queue.
 *
 * Composed on the server from three signals — what the schedule says has
 * decayed, which skills are demonstrably weak, and what was learned in earlier
 * levels — then interleaved so consecutive items rarely share a skill.
 *
 * This is the widest of the three review surfaces. The other two narrow it
 * deliberately: module recall covers one module the day it is finished, level
 * review sweeps a whole level, and this queue mixes across everything the
 * learner has ever studied. All three use the same composer.
 */
export default async function ReviewPage() {
  const user = await getCurrentUser();
  if (!user) redirect('/login');

  const today = reviewDate(new Date());

  const [session, calibrationPoints, profile, roadmap, progress] = await Promise.all([
    composeSession({ userId: user.id, today }),
    getCalibrationHistory(user.id),
    getProfile(user.id),
    getRoadmap(),
    getLessonProgress(user.id),
  ]);

  const { entries, candidates } = session;

  const report = calibrationReport(calibrationPoints);
  const spots = blindSpots(calibrationPoints).slice(0, 3);
  const forecast = reviewForecast(candidates, today, 7);

  const completedLessonIds = new Set(
    progress.filter((row) => row.status === 'completed').map((row) => row.lesson_id),
  );

  // Modules the learner has finished every lesson of, newest first — the point
  // at which a module recall is worth offering.
  const finishedModules = roadmap
    .flatMap((level) => level.modules.map((module) => ({ level, module })))
    .filter(
      ({ module }) =>
        module.lessons.length > 0 && module.lessons.every((l) => completedLessonIds.has(l.id)),
    )
    .reverse()
    .slice(0, 4);

  const levelsWithProgress = roadmap.filter((level) =>
    level.modules.some((module) => module.lessons.some((l) => completedLessonIds.has(l.id))),
  );

  const exerciseCount = entries.filter((entry) => entry.kind === 'exercise').length;

  return (
    <div className="mx-auto max-w-3xl p-5 lg:p-10">
      <h1 className="text-2xl font-bold text-ink">Review</h1>
      <p className="mt-1 text-sm text-muted">
        Scheduled from how memory actually fades, not from a calendar. Each item comes back at the
        point where recalling it does the most good — which is later than it feels like it should
        be.
      </p>

      <div className="mt-6">
        {entries.length > 0 ? (
          <>
            {exerciseCount > 0 ? (
              <p className="mb-3 text-sm text-muted">
                {exerciseCount} of these {entries.length === 1 ? 'item asks' : 'items ask'} you to
                write the markup again rather than recognise it. That is the harder half, and the
                half that measures what you can actually do.
              </p>
            ) : null}
            <ReviewSession
              entries={entries}
              theme={profile?.theme === 'dark' ? 'dark' : 'light'}
            />
          </>
        ) : candidates.length === 0 ? (
          <EmptyState
            title="Nothing to review yet"
            description="Finish a lesson and its questions and exercises will start appearing here, spaced out over the following days and weeks."
          />
        ) : (
          <EmptyState
            title="Nothing due today"
            description={`You have ${candidates.length} item${candidates.length === 1 ? '' : 's'} being tracked. Coming back when they are due is the whole point — reviewing early costs time and strengthens very little.`}
          />
        )}
      </div>

      {finishedModules.length > 0 || levelsWithProgress.length > 0 ? (
        <Card className="mt-8 p-5">
          <CardHeader
            title="Recall a whole module or level"
            description="The daily queue mixes across everything. These two sweep one module or one level in a single pass — worth doing the day you finish something, and again a fortnight later."
          />
          {finishedModules.length > 0 ? (
            <div className="mt-4">
              <p className="text-xs font-semibold uppercase tracking-wide text-muted">
                Modules you have finished
              </p>
              <ul className="mt-2 flex flex-wrap gap-2">
                {finishedModules.map(({ module }) => (
                  <li key={module.id}>
                    <Link
                      href={`/review/module/${module.slug}`}
                      className="inline-flex rounded-full border border-app px-3 py-1.5 text-sm text-ink transition-colors hover:border-accent hover:text-accent min-h-[2.25rem] items-center"
                    >
                      {module.title}
                    </Link>
                  </li>
                ))}
              </ul>
            </div>
          ) : null}

          {levelsWithProgress.length > 0 ? (
            <div className="mt-4">
              <p className="text-xs font-semibold uppercase tracking-wide text-muted">
                Levels you have started
              </p>
              <ul className="mt-2 flex flex-wrap gap-2">
                {levelsWithProgress.map((level) => (
                  <li key={level.id}>
                    <Link
                      href={`/review/level/${level.slug}`}
                      className="inline-flex rounded-full border border-app px-3 py-1.5 text-sm text-ink transition-colors hover:border-accent hover:text-accent min-h-[2.25rem] items-center"
                    >
                      {level.title}
                    </Link>
                  </li>
                ))}
              </ul>
            </div>
          ) : null}
        </Card>
      ) : null}

      <div className="mt-8 grid gap-4 sm:grid-cols-2">
        <Card className="p-5">
          <CardHeader title="The next seven days" />
          <ul className="mt-3 space-y-1.5 text-sm">
            {forecast.map((day) => (
              <li key={day.date} className="flex items-center justify-between">
                <span className="text-muted">
                  {new Date(`${day.date}T00:00:00Z`).toLocaleDateString('en-GB', {
                    weekday: 'short',
                    day: 'numeric',
                    month: 'short',
                  })}
                </span>
                <span className={day.dueCount > 0 ? 'font-medium text-ink' : 'text-muted'}>
                  {day.dueCount === 0 ? '—' : `${day.dueCount} due`}
                </span>
              </li>
            ))}
          </ul>
          <p className="mt-3 text-xs text-muted">
            {dueNowCount(candidates, today)} due now · {candidates.length} tracked in total
          </p>
        </Card>

        <Card className="p-5">
          <CardHeader title="Confidence vs results" />
          <p className="mt-3 text-sm text-ink">{calibrationMessage(report)}</p>

          {report.verdict !== 'insufficient-evidence' ? (
            <ul className="mt-4 space-y-1.5 text-xs">
              {report.buckets
                .filter((bucket) => bucket.count > 0)
                .map((bucket) => (
                  <li key={bucket.confidence} className="flex items-center justify-between">
                    <span className="text-muted">{bucket.label}</span>
                    <span className="text-ink">
                      {Math.round(bucket.actualAccuracy * 100)}% right ({bucket.count})
                    </span>
                  </li>
                ))}
            </ul>
          ) : null}

          {spots.length > 0 ? (
            <div className="mt-4">
              <p className="text-xs font-medium text-ink">Worth a second look</p>
              <p className="mt-0.5 text-xs text-muted">
                You rate these higher than your answers support — the kind of gap you would never
                choose to practise.
              </p>
              <div className="mt-2 flex flex-wrap gap-1.5">
                {spots.map((spot) => (
                  <Badge key={spot.skillSlug} tone="warning">
                    {spot.skillSlug.replace(/-/g, ' ')}
                  </Badge>
                ))}
              </div>
            </div>
          ) : null}
        </Card>
      </div>
    </div>
  );
}
