import type { Metadata } from 'next';
import Link from 'next/link';
import { redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { createClient } from '@/lib/supabase/server';
import { getSkills } from '@/lib/data/catalogue';
import { getSkillMastery } from '@/lib/data/learner';
import { nextDifficulty, recommendPractice, shouldOfferStretch } from '@/lib/progress/mastery';
import { Badge, ButtonLink, Card, CardHeader, EmptyState, ProgressBar } from '@/components/ui';
import { SparkIcon, TargetIcon } from '@/components/ui/icons';

export const metadata: Metadata = {
  title: 'Practice',
  description: 'Targeted practice, chosen from your actual results.',
};

/**
 * Adaptive practice.
 *
 * The queue is built from real evidence — mastery scores, how long since each
 * skill was practised, and how much evidence there is. A struggling learner is
 * offered easier work on the same skill; a confident one is offered harder
 * exercises rather than repetition.
 */
/**
 * Days since a timestamp. Kept outside the component so the clock read is not
 * part of render — the practice queue is recomputed on every request anyway.
 */
function daysSince(iso: string | null): number {
  if (!iso) return 999;
  return Math.floor((Date.now() - new Date(iso).getTime()) / 86_400_000);
}

export default async function PracticePage() {
  const user = await getCurrentUser();
  if (!user) redirect('/login');

  const supabase = await createClient();
  const [skills, mastery] = await Promise.all([getSkills(), getSkillMastery(user.id)]);

  const skillNames = new Map(skills.map((s) => [s.id, s.name]));

  const queue = recommendPractice(
    mastery.map((record) => ({
      skillId: record.skill_id,
      skillName: skillNames.get(record.skill_id) ?? 'Skill',
      mastery: Number(record.mastery),
      evidenceCount: record.evidence_count,
      daysSincePractice: daysSince(record.last_practised_at),
    })),
    8,
  );

  // For each queued skill, find exercises at the right difficulty that the
  // learner has already unlocked by reaching the lesson.
  const skillIds = queue.map((item) => item.skillId);
  const { data: exercises } = skillIds.length
    ? await supabase
        .from('exercises')
        .select('id, slug, title, difficulty, kind, skill_id, lesson_id, is_optional')
        .in('skill_id', skillIds)
        .order('difficulty')
    : { data: [] };

  const { data: lessons } = await supabase.from('lessons').select('id, slug, title');
  const lessonById = new Map((lessons ?? []).map((l) => [l.id, l]));

  const { data: attempts } = await supabase
    .from('exercise_attempts')
    .select('exercise_id, passed')
    .eq('user_id', user.id);
  const passedIds = new Set((attempts ?? []).filter((a) => a.passed).map((a) => a.exercise_id));

  const strongSkills = mastery.filter((record) =>
    shouldOfferStretch(Number(record.mastery), record.evidence_count),
  );

  return (
    <div className="max-w-4xl p-5 lg:p-10">
      <header className="mb-7">
        <h1 className="text-2xl font-bold text-ink lg:text-3xl">Practice</h1>
        <p className="mt-2 max-w-2xl text-muted">
          Chosen from your actual results — the skills where your evidence is weakest or oldest come
          first. Nothing here is busywork; every item is an exercise you have already met, at a
          difficulty matched to where you are now.
        </p>
      </header>

      {queue.length === 0 ? (
        <Card>
          <EmptyState
            icon={<TargetIcon size={32} />}
            title="Nothing needs practice yet"
            description="Once you have attempted a few exercises, the skills that need reinforcing will collect here automatically."
            action={<ButtonLink href="/roadmap">Browse the roadmap</ButtonLink>}
          />
        </Card>
      ) : (
        <ol className="space-y-4">
          {queue.map((item) => {
            const target = nextDifficulty(item.mastery, item.evidenceCount);
            const candidates = (exercises ?? [])
              .filter((exercise) => exercise.skill_id === item.skillId)
              .sort(
                (a, b) =>
                  Math.abs(a.difficulty - target) - Math.abs(b.difficulty - target) ||
                  Number(passedIds.has(a.id)) - Number(passedIds.has(b.id)),
              )
              .slice(0, 3);

            return (
              <li key={item.skillId}>
                <Card>
                  <CardHeader
                    title={item.skillName}
                    description={item.reason}
                    action={<Badge tone="warning">Difficulty {target}/5</Badge>}
                    level="h2"
                  />
                  <div className="px-5 pb-5">
                    <ProgressBar
                      value={item.mastery * 100}
                      label={`${item.skillName} mastery`}
                      tone={item.mastery < 0.5 ? 'warning' : 'accent'}
                      showValue
                    />

                    {candidates.length > 0 ? (
                      <ul className="mt-4 divide-y divide-[hsl(var(--border))]">
                        {candidates.map((exercise) => {
                          const lesson = lessonById.get(exercise.lesson_id);
                          if (!lesson) return null;

                          return (
                            <li key={exercise.id}>
                              <Link
                                href={`/lesson/${lesson.slug}#exercise-${exercise.slug}`}
                                className="flex items-center gap-3 py-2.5 transition-colors hover:text-accent"
                              >
                                <span className="min-w-0 flex-1">
                                  <span className="block truncate text-sm font-medium text-ink">
                                    {exercise.title}
                                  </span>
                                  <span className="block truncate text-xs text-muted">
                                    {lesson.title}
                                  </span>
                                </span>
                                {passedIds.has(exercise.id) ? (
                                  <Badge tone="success">Passed before</Badge>
                                ) : (
                                  <Badge tone="accent">New</Badge>
                                )}
                                <Badge>Level {exercise.difficulty}</Badge>
                              </Link>
                            </li>
                          );
                        })}
                      </ul>
                    ) : (
                      <p className="mt-4 text-sm text-muted">
                        No exercises for this skill yet — it is reinforced in a module you have not
                        reached.
                      </p>
                    )}
                  </div>
                </Card>
              </li>
            );
          })}
        </ol>
      )}

      {strongSkills.length > 0 ? (
        <Card className="mt-7">
          <CardHeader
            title="Optional stretch work"
            description="You have mastered these. Harder, real-world variations are available if you want them."
            action={
              <Badge tone="success">
                <SparkIcon size={12} />
                {strongSkills.length} mastered
              </Badge>
            }
          />
          <div className="px-5 pb-5">
            <ul className="flex flex-wrap gap-2">
              {strongSkills.map((record) => (
                <li key={record.skill_id}>
                  <Badge tone="success">{skillNames.get(record.skill_id) ?? 'Skill'}</Badge>
                </li>
              ))}
            </ul>
            <p className="mt-3 text-sm text-muted">
              Bonus exercises appear inside the lessons for these skills, marked{' '}
              <strong className="font-semibold text-ink">Optional</strong>. They award XP but are
              never required to progress.
            </p>
          </div>
        </Card>
      ) : null}
    </div>
  );
}
