import type { Metadata } from 'next';
import Link from 'next/link';
import { redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { getModuleGates, getRoadmap, getSkills } from '@/lib/data/catalogue';
import { getLessonProgress, getSkillMastery } from '@/lib/data/learner';
import { evaluateModuleGate } from '@/lib/progress/mastery';
import { Badge, Card, ProgressBar } from '@/components/ui';
import { CheckCircleIcon, ClockIcon, LockIcon, SparkIcon, TrophyIcon } from '@/components/ui/icons';
import { cx, formatMinutes, percent } from '@/lib/utils';

export const metadata: Metadata = {
  title: 'Roadmap',
  description: 'The complete mastery-based learning journey, level by level.',
};

/**
 * The complete roadmap.
 *
 * Deliberately organised as levels and modules — there is no day counter
 * anywhere on this page. A locked module says exactly which skills or modules
 * would open it, so the learner always knows what to do next rather than
 * waiting for a date to arrive.
 */
export default async function RoadmapPage() {
  const user = await getCurrentUser();
  if (!user) redirect('/login');

  const [roadmap, gates, skills, progress, mastery] = await Promise.all([
    getRoadmap(),
    getModuleGates(),
    getSkills(),
    getLessonProgress(user.id),
    getSkillMastery(user.id),
  ]);

  const completedLessonIds = new Set(
    progress.filter((p) => p.status === 'completed').map((p) => p.lesson_id),
  );
  const startedLessonIds = new Set(
    progress.filter((p) => p.status !== 'not_started').map((p) => p.lesson_id),
  );

  const completedModuleIds = new Set(
    roadmap
      .flatMap((level) => level.modules)
      .filter((m) => m.lessons.length > 0 && m.lessons.every((l) => completedLessonIds.has(l.id)))
      .map((m) => m.id),
  );

  const masteryBySkill = new Map(mastery.map((m) => [m.skill_id, Number(m.mastery)]));
  const skillNames = new Map(skills.map((s) => [s.id, s.name]));
  const moduleNames = new Map(
    roadmap.flatMap((level) => level.modules.map((m) => [m.id, m.title] as const)),
  );

  const verdicts = new Map(
    gates.map((gate) => [
      gate.moduleId,
      evaluateModuleGate(
        {
          moduleId: gate.moduleId,
          prerequisiteModuleIds: gate.prerequisiteModuleIds,
          requiredSkills: gate.requiredSkills,
        },
        { completedModuleIds, masteryBySkill },
        skillNames,
        moduleNames,
      ),
    ]),
  );

  const totalLessons = roadmap.flatMap((l) => l.modules).flatMap((m) => m.lessons).length;
  const totalMinutes = roadmap
    .flatMap((l) => l.modules)
    .reduce((sum, m) => sum + m.estimated_minutes, 0);

  return (
    <div className="max-w-4xl p-5 lg:p-10">
      <header className="mb-8">
        <h1 className="text-2xl font-bold text-ink lg:text-3xl">Learning roadmap</h1>
        <p className="mt-2 max-w-2xl text-muted">
          Twelve levels, {roadmap.flatMap((l) => l.modules).length} modules,{' '}
          {totalLessons} lessons — roughly {formatMinutes(totalMinutes)} of teaching plus practice.
          Modules unlock when you have demonstrated the skills they build on, not when a date
          arrives.
        </p>
        <div className="mt-4">
          <ProgressBar
            value={completedLessonIds.size}
            max={totalLessons}
            label="Lessons completed"
            showValue
          />
        </div>
      </header>

      <ol className="space-y-8">
        {roadmap.map((level, levelIndex) => {
          const levelLessons = level.modules.flatMap((m) => m.lessons);
          const levelDone = levelLessons.filter((l) => completedLessonIds.has(l.id)).length;
          const levelUnlocked = level.modules.some((m) => verdicts.get(m.id)?.unlocked);

          return (
            <li key={level.id} id={level.slug} className="scroll-mt-6">
              <div className="mb-3 flex flex-wrap items-baseline gap-x-3 gap-y-1">
                <span className="text-xs font-bold uppercase tracking-widest text-accent">
                  Level {levelIndex + 1}
                </span>
                <h2 className="text-xl font-bold text-ink">{level.title}</h2>
                <span className="ml-auto text-sm font-semibold tabular-nums text-muted">
                  {levelDone}/{levelLessons.length}
                </span>
              </div>

              <p className="mb-1 text-sm text-muted">{level.subtitle}</p>
              <p className="mb-4 text-sm text-faint">
                <strong className="font-semibold text-muted">You will be able to:</strong>{' '}
                {level.outcome}
              </p>

              <ol className="space-y-3">
                {level.modules.map((module) => {
                  const verdict = verdicts.get(module.id);
                  const unlocked = verdict?.unlocked ?? false;
                  const done = module.lessons.filter((l) => completedLessonIds.has(l.id)).length;
                  const complete = module.lessons.length > 0 && done === module.lessons.length;

                  return (
                    <li key={module.id}>
                      <Card
                        className={cx(
                          'overflow-hidden',
                          !unlocked && 'opacity-70',
                          complete && 'border-[hsl(var(--success)/0.35)]',
                        )}
                      >
                        <div className="flex flex-wrap items-start gap-3 px-5 pt-4 pb-3">
                          <div className="min-w-0 flex-1">
                            <div className="flex flex-wrap items-center gap-2">
                              <h3 className="font-semibold text-ink">{module.title}</h3>
                              {module.is_milestone ? (
                                <Badge tone="warning">
                                  <TrophyIcon size={12} /> Milestone
                                </Badge>
                              ) : null}
                              {complete ? (
                                <Badge tone="success">
                                  <CheckCircleIcon size={12} /> Complete
                                </Badge>
                              ) : !unlocked ? (
                                <Badge>
                                  <LockIcon size={12} /> Locked
                                </Badge>
                              ) : null}
                            </div>
                            <p className="mt-1 text-sm text-muted">{module.summary}</p>
                          </div>
                          <Badge>
                            <ClockIcon size={12} /> {formatMinutes(module.estimated_minutes)}
                          </Badge>
                        </div>

                        {!unlocked && verdict && verdict.blockedBy.length > 0 ? (
                          <div className="border-t border-app bg-[hsl(var(--bg-subtle))] px-5 py-3">
                            <p className="text-xs font-semibold uppercase tracking-wide text-muted">
                              To unlock this module
                            </p>
                            <ul className="mt-1.5 space-y-1 text-sm text-ink">
                              {verdict.blockedBy.map((reason) => (
                                <li key={reason}>· {reason}</li>
                              ))}
                            </ul>
                          </div>
                        ) : (
                          <ol className="divide-y divide-[hsl(var(--border))] border-t border-app">
                            {module.lessons.map((lesson) => {
                              const isDone = completedLessonIds.has(lesson.id);
                              const isStarted = startedLessonIds.has(lesson.id);

                              return (
                                <li key={lesson.id}>
                                  <Link
                                    href={`/lesson/${lesson.slug}`}
                                    className="flex items-center gap-3 px-5 py-3 transition-colors hover:bg-[hsl(var(--bg-subtle))]"
                                  >
                                    <span
                                      className={cx(
                                        'shrink-0',
                                        isDone ? 'text-[hsl(var(--success))]' : 'text-faint',
                                      )}
                                      aria-hidden="true"
                                    >
                                      <CheckCircleIcon size={17} />
                                    </span>
                                    <span className="min-w-0 flex-1">
                                      <span
                                        className={cx(
                                          'block truncate text-sm font-medium',
                                          isDone ? 'text-muted' : 'text-ink',
                                        )}
                                      >
                                        {lesson.title}
                                      </span>
                                      <span className="block truncate text-xs text-faint">
                                        {lesson.subtitle}
                                      </span>
                                    </span>
                                    {isStarted && !isDone ? (
                                      <Badge tone="accent">In progress</Badge>
                                    ) : null}
                                    <span className="hidden shrink-0 items-center gap-1 text-xs text-faint sm:flex">
                                      <SparkIcon size={12} />
                                      {lesson.xp_award}
                                    </span>
                                  </Link>
                                </li>
                              );
                            })}
                          </ol>
                        )}

                        {unlocked && module.lessons.length > 0 ? (
                          <div className="border-t border-app px-5 py-3">
                            <ProgressBar
                              value={done}
                              max={module.lessons.length}
                              label={`${module.title} progress`}
                              tone={complete ? 'success' : 'accent'}
                              size="sm"
                            />
                            {complete ? (
                              <p className="mt-2.5 text-sm">
                                <Link
                                  href={`/review/module/${module.slug}`}
                                  className="font-medium text-accent underline underline-offset-2"
                                >
                                  Recall this module
                                </Link>{' '}
                                <span className="text-muted">
                                  — finishing the lessons and being able to retrieve them a week
                                  later are different things.
                                </span>
                              </p>
                            ) : null}
                          </div>
                        ) : null}
                      </Card>
                    </li>
                  );
                })}
              </ol>

              {levelUnlocked && levelDone === levelLessons.length && levelLessons.length > 0 ? (
                <p className="mt-3 text-sm font-medium text-[hsl(var(--success))]">
                  Level complete — {percent(levelDone, levelLessons.length)}% of {level.title}.
                </p>
              ) : null}

              {levelDone > 0 ? (
                <p className="mt-3 text-sm">
                  <Link
                    href={`/review/level/${level.slug}`}
                    className="font-medium text-accent underline underline-offset-2"
                  >
                    Cumulative review of {level.title}
                  </Link>{' '}
                  <span className="text-muted">
                    — mixed across every module, so you have to work out which idea applies before
                    you can apply it.
                  </span>
                </p>
              ) : null}
            </li>
          );
        })}
      </ol>
    </div>
  );
}
