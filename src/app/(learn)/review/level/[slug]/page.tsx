import type { Metadata } from 'next';
import Link from 'next/link';
import { notFound, redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { composeSession } from '@/lib/data/review';
import { getLessonProgress, getProfile } from '@/lib/data/learner';
import { getRoadmap } from '@/lib/data/catalogue';
import { reviewDate } from '@/lib/review/scheduler';
import { ReviewSession } from '@/components/learn/review-session';
import { Badge, ButtonLink, Card, EmptyState, ProgressBar } from '@/components/ui';

/**
 * Longer than module recall, because it spans a whole level — but still
 * finishable. A queue abandoned halfway is worse than a shorter one: the
 * unreviewed remainder decays while appearing to be in progress.
 */
const LEVEL_REVIEW_MAX_ITEMS = 20;

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const roadmap = await getRoadmap();
  const level = roadmap.find((entry) => entry.slug === slug);

  return {
    title: level ? `Cumulative review: ${level.title}` : 'Level review',
    description: 'A cumulative pass across everything one level taught.',
    robots: { index: false, follow: false },
  };
}

/**
 * Level cumulative review — the second of the three levels of review.
 *
 * Where module recall asks "can you still do the thing you just learned", this
 * asks the harder question: can you still tell the modules apart? Answering
 * inside a module means the topic is given; answering across a level means
 * first working out which idea applies, which is the discrimination the real
 * task demands and the one blocked practice never trains.
 *
 * That is why this page interleaves across the level's modules rather than
 * walking them in order, and why it is worth taking again weeks after the level
 * is finished rather than only on the day.
 */
export default async function LevelReviewPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;

  const user = await getCurrentUser();
  if (!user) redirect(`/login?next=/review/level/${slug}`);

  const roadmap = await getRoadmap();
  const level = roadmap.find((entry) => entry.slug === slug);
  if (!level) notFound();

  const moduleSlugs = new Set(level.modules.map((module) => module.slug));
  const levelLessons = level.modules.flatMap((module) => module.lessons);

  const [session, profile, progress] = await Promise.all([
    composeSession({
      userId: user.id,
      today: reviewDate(new Date()),
      filter: (candidate) => moduleSlugs.has(candidate.moduleSlug),
      maxItems: LEVEL_REVIEW_MAX_ITEMS,
      seedSuffix: `level:${slug}`,
    }),
    getProfile(user.id),
    getLessonProgress(user.id),
  ]);

  const completedLessonIds = new Set(
    progress.filter((row) => row.status === 'completed').map((row) => row.lesson_id),
  );
  const done = levelLessons.filter((lesson) => completedLessonIds.has(lesson.id)).length;

  // How much of the level the session actually reaches into, which is the
  // honest version of "cumulative" — it covers what has been studied, not what
  // exists.
  const modulesCovered = new Set(session.pool.map((candidate) => candidate.moduleSlug)).size;

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
              href={`/roadmap#${level.slug}`}
              className="hover:text-ink underline underline-offset-2"
            >
              Roadmap
            </Link>
          </li>
        </ol>
      </nav>

      <Badge tone="accent">Cumulative review</Badge>
      <h1 className="mt-2 text-2xl font-bold text-ink">{level.title}</h1>
      <p className="mt-1 text-sm text-muted">
        Mixed across all {level.modules.length} modules of this level rather than taken one at a
        time. It feels harder than reviewing a module, and that is the point: when the topic is not
        given to you, you have to work out which idea applies before you can apply it.
      </p>

      <div className="mt-4">
        <ProgressBar
          value={done}
          max={levelLessons.length}
          label={`${level.title} lessons completed`}
          showValue
        />
      </div>
      <p className="mt-2 text-xs text-muted">
        {session.pool.length} items tracked across {modulesCovered} of {level.modules.length}{' '}
        modules
      </p>

      <div className="mt-6">
        {session.entries.length > 0 ? (
          <ReviewSession
            entries={session.entries}
            theme={profile?.theme === 'dark' ? 'dark' : 'light'}
            title="Cumulative review"
          />
        ) : (
          <EmptyState
            title="Nothing tracked from this level yet"
            description="Items appear once you have started the lessons they come from. Work through a module and this page will have something to ask you."
            action={<ButtonLink href="/roadmap">Back to the roadmap</ButtonLink>}
          />
        )}
      </div>

      {level.modules.length > 0 ? (
        <Card className="mt-8 p-5">
          <h2 className="font-semibold text-ink">Or take one module at a time</h2>
          <p className="mt-1.5 text-sm text-muted">
            Easier, and useful when a single module is the one that has gone soft. If you are not
            sure which, the cumulative pass above will tell you.
          </p>
          <ul className="mt-3 flex flex-wrap gap-2">
            {level.modules.map((module) => (
              <li key={module.id}>
                <Link
                  href={`/review/module/${module.slug}`}
                  className="inline-flex items-center rounded-full border border-app px-3 py-1.5 text-sm text-ink transition-colors hover:border-accent hover:text-accent min-h-[2.25rem]"
                >
                  {module.title}
                </Link>
              </li>
            ))}
          </ul>
        </Card>
      ) : null}
    </div>
  );
}
