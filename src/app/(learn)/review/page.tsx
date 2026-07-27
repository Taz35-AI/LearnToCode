import type { Metadata } from 'next';
import { redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { getCalibrationHistory, getReviewCandidates, getReviewQuestions } from '@/lib/data/review';
import { getSkillMastery } from '@/lib/data/learner';
import { getSkills } from '@/lib/data/catalogue';
import { isMastered } from '@/lib/progress/mastery';
import {
  DEFAULT_SESSION_OPTIONS,
  composeReviewSession,
  dueNowCount,
  reviewForecast,
} from '@/lib/review/session';
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
 */
export default async function ReviewPage() {
  const user = await getCurrentUser();
  if (!user) redirect('/login');

  const [candidates, mastery, skills, calibrationPoints] = await Promise.all([
    getReviewCandidates(user.id),
    getSkillMastery(user.id),
    getSkills(),
    getCalibrationHistory(user.id),
  ]);

  const today = reviewDate(new Date());

  const skillSlugById = new Map(skills.map((skill) => [skill.id, skill.slug]));
  const weakSkills = new Set(
    mastery
      .filter((record) => !isMastered({ mastery: Number(record.mastery), evidenceCount: record.evidence_count }))
      .map((record) => skillSlugById.get(record.skill_id) ?? '')
      .filter(Boolean),
  );

  const currentLevel = Math.max(1, ...candidates.map((candidate) => candidate.levelOrdinal));

  const session = composeReviewSession(candidates, {
    ...DEFAULT_SESSION_OPTIONS,
    today,
    weakSkills,
    currentLevel,
    seed: user.id,
  });

  const questionItems = session.filter((entry) => entry.candidate.kind === 'question');
  const questions = await getReviewQuestions(questionItems.map((entry) => entry.candidate.itemId));

  const report = calibrationReport(calibrationPoints);
  const spots = blindSpots(calibrationPoints).slice(0, 3);
  const forecast = reviewForecast(candidates, today, 7);

  return (
    <div className="mx-auto max-w-3xl">
      <h1 className="text-2xl font-bold text-ink">Review</h1>
      <p className="mt-1 text-sm text-muted">
        Scheduled from how memory actually fades, not from a calendar. Each item comes back at the
        point where recalling it does the most good — which is later than it feels like it should
        be.
      </p>

      <div className="mt-6">
        {questions.length > 0 ? (
          <ReviewSession questions={questions} />
        ) : candidates.length === 0 ? (
          <EmptyState
            title="Nothing to review yet"
            description="Finish a lesson and its questions will start appearing here, spaced out over the following days and weeks."
          />
        ) : (
          <EmptyState
            title="Nothing due today"
            description={`You have ${candidates.length} item${candidates.length === 1 ? '' : 's'} being tracked. Coming back when they are due is the whole point — reviewing early costs time and strengthens very little.`}
          />
        )}
      </div>

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
