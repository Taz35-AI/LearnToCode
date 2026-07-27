'use client';

import { useEffect, useRef, useState, useTransition } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { LessonBlock } from './lesson-blocks';
import { LessonWarmUp } from './lesson-warm-up';
import { Quiz, type QuizQuestionView } from './quiz';
import { Workbench, type WorkbenchExercise } from '@/components/editor/workbench';
import { Badge, Button, ButtonLink, Card } from '@/components/ui';
import {
  ArrowLeftIcon,
  ArrowRightIcon,
  CheckCircleIcon,
  ClockIcon,
  SparkIcon,
} from '@/components/ui/icons';
import type { LessonBlockRow } from '@/lib/supabase/database.types';
import type { ReviewQuestion } from '@/lib/data/review';
import type { EvaluationOutcome, LessonCompletionOutcome, QuizOutcome } from '@/lib/actions/progress';
import type { ActionResult } from '@/lib/actions/schemas';

/**
 * A single lesson.
 *
 * The order is deliberate and matches the lesson structure the course promises:
 * objectives, explanation, examples, demonstration, then the guided exercise,
 * the independent challenge, the debugging task, the knowledge check, the
 * project mission, and finally the summary and the mastery gate.
 *
 * Time on the lesson is measured client-side and sent with the completion, so
 * study time reflects real engagement rather than a page being left open —
 * the timer pauses when the tab is hidden.
 */

export interface LessonViewProps {
  lesson: {
    id: string;
    slug: string;
    title: string;
    subtitle: string;
    estimatedMinutes: number;
    xpAward: number;
    objectives: string[];
  };
  moduleTitle: string;
  levelTitle: string;
  levelSlug: string;
  blocks: LessonBlockRow[];
  exercises: WorkbenchExercise[];
  questions: QuizQuestionView[];
  /**
   * Retrieval practice drawn from earlier lessons, composed on the server.
   * Empty on a learner's very first lesson, which is correct rather than a gap:
   * there is nothing yet to retrieve.
   */
  warmUp: ReviewQuestion[];
  savedCode: Record<string, { code: string; hintsUsed: number }>;
  passedExerciseIds: string[];
  previousAnswers: Record<string, { selected: string[]; isCorrect: boolean }>;
  isCompleted: boolean;
  next: { slug: string; title: string } | null;
  previous: { slug: string; title: string } | null;
  theme: 'light' | 'dark';
  onEvaluate: (input: {
    exerciseId: string;
    code: string;
    hintsUsed: number;
    durationSeconds: number;
  }) => Promise<ActionResult<EvaluationOutcome>>;
  onSaveCode: (input: { exerciseId: string; code: string; hintsUsed: number }) => Promise<ActionResult>;
  onAnswer: (input: { questionId: string; optionIds: string[] }) => Promise<ActionResult<QuizOutcome>>;
  onComplete: (input: { lessonId: string; secondsSpent: number }) => Promise<ActionResult<LessonCompletionOutcome>>;
}

const KIND_ORDER: Record<string, number> = {
  guided: 0,
  // Finishing a partly written solution sits between being led through one and
  // writing one from nothing: the scaffolding comes off gradually.
  completion: 1,
  challenge: 2,
  debug: 3,
  project_mission: 4,
  bonus: 5,
};

export function LessonView(props: LessonViewProps) {
  const router = useRouter();
  const [passed, setPassed] = useState<Set<string>>(new Set(props.passedExerciseIds));
  const [completed, setCompleted] = useState(props.isCompleted);
  const [completionMessage, setCompletionMessage] = useState<string | null>(null);
  const [completionError, setCompletionError] = useState<string | null>(null);
  const [isCompleting, startCompleting] = useTransition();

  const seconds = useRef(0);
  const statusRef = useRef<HTMLDivElement | null>(null);

  // Count time only while the tab is actually visible.
  useEffect(() => {
    const tick = setInterval(() => {
      if (document.visibilityState === 'visible') seconds.current += 5;
    }, 5000);
    return () => clearInterval(tick);
  }, []);

  const required = props.exercises.filter((e) => !e.isOptional);
  const remaining = required.filter((e) => !passed.has(e.id));
  const canComplete = remaining.length === 0;

  const handleEvaluate: LessonViewProps['onEvaluate'] = async (input) => {
    const response = await props.onEvaluate(input);
    if (response.ok && response.data?.result.passed) {
      setPassed((current) => new Set(current).add(input.exerciseId));
    }
    return response;
  };

  const complete = () => {
    startCompleting(async () => {
      const response = await props.onComplete({
        lessonId: props.lesson.id,
        secondsSpent: seconds.current,
      });

      if (!response.ok) {
        setCompletionError(response.message ?? 'We could not mark this lesson complete.');
        return;
      }

      setCompleted(true);
      setCompletionError(null);
      const xp = response.data?.xpAwarded ?? 0;
      const achievements = response.data?.achievementsUnlocked ?? [];
      setCompletionMessage(
        [
          'Lesson complete.',
          xp > 0 ? `+${xp} XP.` : null,
          achievements.length > 0 ? `Achievement unlocked: ${achievements.join(', ')}.` : null,
        ]
          .filter(Boolean)
          .join(' '),
      );
      requestAnimationFrame(() => statusRef.current?.focus());
      router.refresh();
    });
  };

  const orderedExercises = [...props.exercises].sort(
    (a, b) => (KIND_ORDER[a.kind] ?? 9) - (KIND_ORDER[b.kind] ?? 9),
  );

  // `summary` restates the lesson and `recap` makes the learner retrieve it.
  // Both belong after the knowledge check rather than in the teaching flow —
  // a closing recall placed before the exercises is not a closing recall.
  const isClosing = (type: string) => type === 'summary' || type === 'recap';
  const summaryBlocks = props.blocks.filter((b) => isClosing(b.block_type));
  const teachingBlocks = props.blocks.filter((b) => !isClosing(b.block_type));

  return (
    <article className="mx-auto max-w-4xl px-5 py-6 lg:px-10 lg:py-10">
      {/* ---- Header ---- */}
      <header className="mb-8">
        <nav aria-label="Breadcrumb" className="mb-3">
          <ol className="flex flex-wrap items-center gap-1.5 text-sm text-muted">
            <li>
              <Link href="/roadmap" className="hover:text-ink underline underline-offset-2">
                Roadmap
              </Link>
            </li>
            <li aria-hidden="true">›</li>
            <li>
              <Link
                href={`/roadmap#${props.levelSlug}`}
                className="hover:text-ink underline underline-offset-2"
              >
                {props.levelTitle}
              </Link>
            </li>
            <li aria-hidden="true">›</li>
            <li className="text-ink">{props.moduleTitle}</li>
          </ol>
        </nav>

        <div className="flex flex-wrap items-center gap-2">
          {completed ? (
            <Badge tone="success">
              <CheckCircleIcon size={12} /> Completed
            </Badge>
          ) : null}
          <Badge>
            <ClockIcon size={12} /> {props.lesson.estimatedMinutes} min
          </Badge>
          <Badge tone="accent">
            <SparkIcon size={12} /> {props.lesson.xpAward} XP
          </Badge>
        </div>

        <h1 className="mt-3 text-2xl font-bold text-ink lg:text-3xl text-balance">
          {props.lesson.title}
        </h1>
        <p className="mt-1.5 text-lg text-muted">{props.lesson.subtitle}</p>
      </header>

      {/* ---- Warm-up: retrieval before new material ---- */}
      <LessonWarmUp questions={props.warmUp} />

      {/* ---- Teaching content ---- */}
      <div className="space-y-6">
        {teachingBlocks.map((block) => (
          <LessonBlock key={block.id} block={block} />
        ))}
      </div>

      {/* ---- Exercises ---- */}
      {orderedExercises.length > 0 ? (
        <section aria-labelledby="practice" className="mt-10">
          <h2 id="practice" className="text-xl font-bold text-ink">
            Now you try
          </h2>
          <p className="mt-1 mb-5 text-muted">
            The checker looks at the structure of your HTML, not the exact words. Write your own
            content — that is the point.
          </p>

          <div className="space-y-6">
            {orderedExercises.map((exercise) => (
              <Workbench
                key={exercise.id}
                exercise={exercise}
                savedCode={props.savedCode[exercise.id]?.code ?? null}
                savedHintsUsed={props.savedCode[exercise.id]?.hintsUsed ?? 0}
                alreadyPassed={passed.has(exercise.id)}
                theme={props.theme}
                onEvaluate={handleEvaluate}
                onSave={props.onSaveCode}
              />
            ))}
          </div>
        </section>
      ) : null}

      {/* ---- Knowledge check ---- */}
      {props.questions.length > 0 ? (
        <div className="mt-10">
          <Quiz
            questions={props.questions}
            previousAnswers={props.previousAnswers}
            onAnswer={props.onAnswer}
          />
        </div>
      ) : null}

      {/* ---- Summary ---- */}
      {summaryBlocks.length > 0 ? (
        <div className="mt-10 space-y-6">
          {summaryBlocks.map((block) => (
            <LessonBlock key={block.id} block={block} />
          ))}
        </div>
      ) : null}

      {/* ---- Mastery gate ---- */}
      <Card className="mt-10">
        <div className="p-5">
          <h2 className="text-lg font-bold text-ink">Mastery requirement</h2>
          <p className="mt-1 text-sm text-muted">
            This lesson counts as complete when you have passed its{' '}
            {required.length === 1 ? 'exercise' : `${required.length} required exercises`}. Time
            spent does not unlock anything — demonstrated understanding does.
          </p>

          <ul className="mt-4 space-y-1.5">
            {required.map((exercise) => (
              <li key={exercise.id} className="flex items-center gap-2 text-sm">
                <span
                  className={
                    passed.has(exercise.id) ? 'text-[hsl(var(--success))]' : 'text-faint'
                  }
                  aria-hidden="true"
                >
                  <CheckCircleIcon size={16} />
                </span>
                <span className={passed.has(exercise.id) ? 'text-muted line-through' : 'text-ink'}>
                  {exercise.title}
                </span>
              </li>
            ))}
          </ul>

          <div
            ref={statusRef}
            tabIndex={-1}
            aria-live="polite"
            className="mt-5 focus:outline-none"
          >
            {completionMessage ? (
              <p className="mb-4 rounded-lg border border-[hsl(var(--success)/0.35)] bg-[hsl(var(--success-soft))] px-4 py-3 text-sm font-medium text-[hsl(var(--success))]">
                {completionMessage}
              </p>
            ) : null}
            {completionError ? (
              <p
                role="alert"
                className="mb-4 rounded-lg border border-[hsl(var(--warning)/0.4)] bg-[hsl(var(--warning-soft))] px-4 py-3 text-sm font-medium text-[hsl(var(--warning))]"
              >
                {completionError}
              </p>
            ) : null}

            <div className="flex flex-wrap gap-3">
              {!completed ? (
                <Button onClick={complete} disabled={!canComplete || isCompleting} size="lg">
                  {isCompleting
                    ? 'Saving…'
                    : canComplete
                      ? 'Mark lesson complete'
                      : `${remaining.length} ${remaining.length === 1 ? 'exercise' : 'exercises'} left`}
                </Button>
              ) : null}

              {props.next ? (
                <ButtonLink
                  href={`/lesson/${props.next.slug}`}
                  size="lg"
                  variant={completed ? 'primary' : 'secondary'}
                >
                  Next: {props.next.title}
                  <ArrowRightIcon size={18} />
                </ButtonLink>
              ) : (
                <ButtonLink href="/project" size="lg" variant="secondary">
                  Open my project
                </ButtonLink>
              )}
            </div>
          </div>
        </div>
      </Card>

      {/* ---- Lesson navigation ---- */}
      <nav aria-label="Lesson" className="mt-8 flex flex-wrap justify-between gap-3">
        {props.previous ? (
          <ButtonLink href={`/lesson/${props.previous.slug}`} variant="ghost" size="sm">
            <ArrowLeftIcon size={16} />
            {props.previous.title}
          </ButtonLink>
        ) : (
          <span />
        )}
        {props.next ? (
          <ButtonLink href={`/lesson/${props.next.slug}`} variant="ghost" size="sm">
            {props.next.title}
            <ArrowRightIcon size={16} />
          </ButtonLink>
        ) : null}
      </nav>
    </article>
  );
}
