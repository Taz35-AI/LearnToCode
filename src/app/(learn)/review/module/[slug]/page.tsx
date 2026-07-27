import type { Metadata } from 'next';
import Link from 'next/link';
import { notFound, redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { composeSession } from '@/lib/data/review';
import { getLessonProgress, getProfile } from '@/lib/data/learner';
import { getRoadmap } from '@/lib/data/catalogue';
import { reviewDate } from '@/lib/review/scheduler';
import { ReviewSession } from '@/components/learn/review-session';
import { Badge, ButtonLink, Card, EmptyState } from '@/components/ui';

/** Long enough to sweep a module, short enough to finish in one sitting. */
const MODULE_RECALL_MAX_ITEMS = 12;

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const roadmap = await getRoadmap();
  const found = roadmap.flatMap((level) => level.modules).find((m) => m.slug === slug);

  return {
    title: found ? `Recall: ${found.title}` : 'Module recall',
    description: 'Retrieve a whole module in one pass.',
    robots: { index: false, follow: false },
  };
}

/**
 * Module recall — the first of the three levels of review.
 *
 * The daily queue mixes across everything the learner has ever studied, which
 * is right for maintenance and wrong for the moment a module is finished.
 * Immediately after finishing, the material is still fresh enough that nothing
 * is due yet, so the queue has nothing to say about it for days — during which
 * it decays fastest. This page closes that gap: one deliberate pass over the
 * module as a whole, taken when the learner chooses rather than when the
 * schedule insists.
 *
 * Unlike the queue it is not restricted to due items, so it is genuinely
 * available on the day. It still writes to the same schedule, so recalling
 * something here pushes it further out exactly as the queue would have.
 */
export default async function ModuleRecallPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;

  const user = await getCurrentUser();
  if (!user) redirect(`/login?next=/review/module/${slug}`);

  const roadmap = await getRoadmap();
  const found = roadmap
    .flatMap((level) => level.modules.map((module) => ({ level, module })))
    .find((entry) => entry.module.slug === slug);
  if (!found) notFound();

  const { level, module } = found;
  const lessonSlugs = new Set(module.lessons.map((lesson) => lesson.slug));

  const [session, profile, progress] = await Promise.all([
    composeSession({
      userId: user.id,
      today: reviewDate(new Date()),
      filter: (candidate) => lessonSlugs.has(candidate.lessonSlug),
      maxItems: MODULE_RECALL_MAX_ITEMS,
      seedSuffix: `module:${slug}`,
    }),
    getProfile(user.id),
    getLessonProgress(user.id),
  ]);

  const completedLessonIds = new Set(
    progress.filter((row) => row.status === 'completed').map((row) => row.lesson_id),
  );
  const done = module.lessons.filter((lesson) => completedLessonIds.has(lesson.id)).length;

  return (
    <div className="mx-auto max-w-3xl p-5 lg:p-10">
      <nav aria-label="Breadcrumb" className="mb-3">
        <ol className="flex flex-wrap items-center gap-1.5 text-sm text-muted">
          <li>
            <Link href="/review" className="hover:text-ink underline underline-offset-2">
              Review
            </Link>
          </li>
          <li aria-hidden="true">›</li>
          <li>
            <Link
              href={`/review/level/${level.slug}`}
              className="hover:text-ink underline underline-offset-2"
            >
              {level.title}
            </Link>
          </li>
        </ol>
      </nav>

      <Badge tone="accent">Module recall</Badge>
      <h1 className="mt-2 text-2xl font-bold text-ink">{module.title}</h1>
      <p className="mt-1 text-sm text-muted">
        Everything this module taught, in one pass. Finishing the lessons is not the same as being
        able to retrieve them a week later — this is where you find out which it is.
      </p>
      <p className="mt-2 text-xs text-muted">
        {done} of {module.lessons.length} lessons completed · {session.pool.length} items tracked
        from this module
      </p>

      <div className="mt-6">
        {session.entries.length > 0 ? (
          <ReviewSession
            entries={session.entries}
            theme={profile?.theme === 'dark' ? 'dark' : 'light'}
            title="Module recall"
          />
        ) : (
          <EmptyState
            title="Nothing tracked from this module yet"
            description="Items appear once you have started the lessons they come from. Work through a lesson and this page will have something to ask you."
            action={<ButtonLink href="/roadmap">Back to the roadmap</ButtonLink>}
          />
        )}
      </div>

      <Card className="mt-8 p-5">
        <h2 className="font-semibold text-ink">After this</h2>
        <p className="mt-1.5 text-sm text-muted">
          A single pass is not the point — spacing is. Whatever you recalled here has been pushed
          out to the day it is worth asking again, and it will reappear in your daily queue on its
          own. Coming back tomorrow to redo this page would cost time and strengthen very little.
        </p>
        <div className="mt-4 flex flex-wrap gap-3">
          <ButtonLink href={`/review/level/${level.slug}`} variant="secondary" size="sm">
            Review the whole of {level.title}
          </ButtonLink>
          <ButtonLink href="/review" variant="ghost" size="sm">
            Back to the daily queue
          </ButtonLink>
        </div>
      </Card>
    </div>
  );
}
