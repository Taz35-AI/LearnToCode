import type { Metadata } from 'next';
import { redirect } from 'next/navigation';
import { getCurrentUser, createClient } from '@/lib/supabase/server';
import { getCourse, getLessonOrder, getSkills } from '@/lib/data/catalogue';
import { getLessonProgress, getProfile, getSkillMastery, getTotalXp } from '@/lib/data/learner';
import { isMastered } from '@/lib/progress/mastery';
import { Badge, ButtonLink, Card, EmptyState, ProgressBar } from '@/components/ui';
import { CertificateIcon, LogoMark } from '@/components/ui/icons';
import { certificateSerial, percent } from '@/lib/utils';
import { formatDate } from '@/lib/progress/pace';

export const metadata: Metadata = {
  title: 'Certificate',
  description: 'Your HTML Hero certificate of completion.',
  robots: { index: false, follow: false },
};

/**
 * The certificate.
 *
 * Issued only when the work is genuinely finished: every lesson complete and
 * the final assessment passed. The serial is derived from the learner's id and
 * the issue year, so it is stable and verifiable rather than decorative.
 */
export default async function CertificatePage() {
  const user = await getCurrentUser();
  if (!user) redirect('/login');

  const supabase = await createClient();
  const [profile, progress, order, skills, mastery, totalXp, course] = await Promise.all([
    getProfile(user.id),
    getLessonProgress(user.id),
    getLessonOrder(),
    getSkills(),
    getSkillMastery(user.id),
    getTotalXp(user.id),
    getCourse(),
  ]);

  const completed = progress.filter((p) => p.status === 'completed').length;
  const allLessonsDone = order.length > 0 && completed >= order.length;

  const { data: finalAssessment } = await supabase
    .from('assessments')
    .select('id, title, pass_score')
    .eq('kind', 'final')
    .maybeSingle();

  const { data: finalAttempts } = finalAssessment
    ? await supabase
        .from('assessment_attempts')
        .select('score, passed, created_at')
        .eq('user_id', user.id)
        .eq('assessment_id', finalAssessment.id)
        .order('score', { ascending: false })
        .limit(1)
    : { data: [] };

  const bestFinal = finalAttempts?.[0];
  const finalPassed = bestFinal?.passed ?? false;

  const masteredCount = mastery.filter((m) =>
    isMastered({ mastery: Number(m.mastery), evidenceCount: m.evidence_count }),
  ).length;

  const earned = allLessonsDone && finalPassed;

  if (!earned) {
    return (
      <div className="max-w-3xl p-5 lg:p-10">
        <header className="mb-7">
          <h1 className="text-2xl font-bold text-ink lg:text-3xl">Certificate</h1>
          <p className="mt-2 text-muted">
            Issued when you have finished every lesson and passed the final assessment. Nothing is
            issued for partial completion — that is what makes it worth having.
          </p>
        </header>

        <Card>
          <EmptyState
            icon={<CertificateIcon size={32} />}
            title="Not yet earned"
            description="Keep going — you are closer than you think."
            action={<ButtonLink href="/dashboard">Continue learning</ButtonLink>}
          />
        </Card>

        <Card className="mt-5">
          <div className="space-y-5 p-5">
            <div>
              <div className="mb-1.5 flex items-baseline justify-between">
                <span className="text-sm font-medium text-ink">All lessons complete</span>
                <span className="text-sm tabular-nums text-muted">
                  {completed}/{order.length}
                </span>
              </div>
              <ProgressBar
                value={completed}
                max={order.length}
                label="Lessons completed"
                tone={allLessonsDone ? 'success' : 'accent'}
              />
            </div>

            <div>
              <div className="mb-1.5 flex items-baseline justify-between">
                <span className="text-sm font-medium text-ink">Final assessment passed</span>
                <Badge tone={finalPassed ? 'success' : 'neutral'}>
                  {bestFinal
                    ? `Best: ${Math.round(Number(bestFinal.score) * 100)}%`
                    : 'Not attempted'}
                </Badge>
              </div>
              <p className="text-sm text-muted">
                {finalAssessment
                  ? `Pass mark ${Math.round(Number(finalAssessment.pass_score) * 100)}%. You can retake it as many times as you need.`
                  : 'The final assessment becomes available once the course is seeded.'}
              </p>
            </div>

            <div>
              <div className="mb-1.5 flex items-baseline justify-between">
                <span className="text-sm font-medium text-ink">Skills mastered</span>
                <span className="text-sm tabular-nums text-muted">
                  {masteredCount}/{skills.length}
                </span>
              </div>
              <ProgressBar
                value={masteredCount}
                max={skills.length}
                label="Skills mastered"
                tone="accent"
              />
            </div>
          </div>
        </Card>
      </div>
    );
  }

  const issuedAt = bestFinal?.created_at ? new Date(bestFinal.created_at) : new Date();
  const serial = certificateSerial(user.id, issuedAt);
  const name = profile?.display_name ?? 'Learner';

  return (
    <div className="max-w-3xl p-5 lg:p-10">
      <header className="mb-7">
        <h1 className="text-2xl font-bold text-ink lg:text-3xl">Your certificate</h1>
        <p className="mt-2 text-muted">
          Every lesson complete, the final assessment passed, and a website you built yourself.
        </p>
      </header>

      <Card className="overflow-hidden">
        <div className="border-b-4 border-[hsl(var(--accent))] bg-[hsl(var(--bg-subtle))] p-8 text-center lg:p-12">
          <LogoMark size={44} className="mx-auto" />
          <p className="mt-5 text-xs font-bold uppercase tracking-[0.2em] text-accent">
            Certificate of completion
          </p>

          <p className="mt-6 text-sm text-muted">This certifies that</p>
          <p className="mt-1 text-3xl font-bold text-ink text-balance">{name}</p>

          <p className="mt-5 text-sm text-muted">has completed</p>
          <p className="mt-1 text-xl font-bold text-ink">{course?.title ?? 'HTML Hero'}</p>
          <p className="mt-1 text-sm text-muted">{course?.subtitle}</p>

          <dl className="mx-auto mt-8 grid max-w-lg grid-cols-2 gap-4 text-left sm:grid-cols-4">
            {[
              ['Lessons', String(order.length)],
              ['Skills mastered', `${masteredCount}/${skills.length}`],
              ['Final score', `${Math.round(Number(bestFinal?.score ?? 0) * 100)}%`],
              ['Total XP', totalXp.toLocaleString('en-GB')],
            ].map(([label, value]) => (
              <div key={label}>
                <dt className="text-xs font-semibold uppercase tracking-wide text-muted">
                  {label}
                </dt>
                <dd className="mt-0.5 text-lg font-bold text-ink tabular-nums">{value}</dd>
              </div>
            ))}
          </dl>

          <div className="mt-8 border-t border-app pt-5 text-sm text-muted">
            <p>Issued {formatDate(issuedAt)}</p>
            <p className="mt-1 font-mono text-xs">Serial {serial}</p>
          </div>
        </div>

        <div className="p-5 text-center">
          <p className="text-sm text-muted">
            {percent(completed, order.length)}% of the course completed. Print this page to save a
            PDF copy.
          </p>
          <ButtonLink href="/project" variant="secondary" className="mt-4">
            View the site you built
          </ButtonLink>
        </div>
      </Card>
    </div>
  );
}
