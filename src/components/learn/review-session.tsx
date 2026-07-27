'use client';

import { useState, useTransition } from 'react';
import {
  answerReviewExerciseAction,
  answerReviewItemAction,
  type ReviewExerciseOutcomeResult,
  type ReviewOutcomeResult,
} from '@/lib/actions/review';
import { saveCodeAction } from '@/lib/actions/progress';
import { CONFIDENCE_LABELS, type ConfidenceRating } from '@/lib/review/calibration';
import type { ReviewEntry, ReviewExercise, ReviewQuestion } from '@/lib/data/review';
import { Workbench } from '@/components/editor/workbench';
import { Badge, Button, Callout, Card, InlineText, ProgressBar } from '@/components/ui';
import { CheckIcon, SparkIcon } from '@/components/ui/icons';

/**
 * The review session.
 *
 * Four deliberate design decisions, all of which make the session feel harder
 * than it needs to:
 *
 * 1. **Confidence is asked before the answer is revealed.** Asked afterwards it
 *    would be hindsight, which measures nothing. This is the input the
 *    calibration report is built from.
 * 2. **The answer is not shown until the learner commits.** A visible answer
 *    turns retrieval practice into reading, which is the thing retrieval
 *    practice exists to replace.
 * 3. **A failed item returns later in the same session** rather than tomorrow,
 *    so nobody finishes having last seen themselves get it wrong.
 * 4. **Exercises are reviewed by writing them again**, not by recognising a
 *    description of them. Half the reviewable pool is exercises, and a queue
 *    that quietly dropped them would be systematically easier than the course
 *    it is meant to consolidate.
 */

const entryId = (entry: ReviewEntry) =>
  entry.kind === 'question' ? entry.question.itemId : entry.exercise.itemId;

const entrySkill = (entry: ReviewEntry) =>
  entry.kind === 'question' ? entry.question.skillSlug : entry.exercise.skillSlug;

export function ReviewSession({
  entries,
  theme = 'light',
  title,
}: {
  entries: ReviewEntry[];
  theme?: 'light' | 'dark';
  /** Announced above the queue, so module recall does not look like the daily queue. */
  title?: string;
}) {
  const [queue, setQueue] = useState(entries);
  const [index, setIndex] = useState(0);
  const [completed, setCompleted] = useState(0);
  const [correctCount, setCorrectCount] = useState(0);

  const entry = queue[index];

  if (!entry) {
    return (
      <Card className="p-8 text-center">
        <div className="mx-auto mb-4 grid h-12 w-12 place-items-center rounded-full bg-[hsl(var(--success)/0.12)] text-[hsl(var(--success))]">
          <CheckIcon size={22} />
        </div>
        <h2 className="text-xl font-bold text-ink">{title ? `${title} complete` : 'Review complete'}</h2>
        <p className="mt-2 text-sm text-muted">
          {correctCount} of {completed} recalled correctly. Each one you got right just moved
          further into the future; the ones you missed will come back sooner.
        </p>
      </Card>
    );
  }

  const finish = (wasCorrect: boolean) => {
    setCompleted((n) => n + 1);
    if (wasCorrect) setCorrectCount((n) => n + 1);
  };

  const next = (wasCorrect: boolean) => {
    if (!wasCorrect) {
      // Re-queue at the end rather than dropping it: finishing on a failure is
      // the one outcome worth designing away.
      setQueue((current) => [...current, entry]);
    }
    setIndex((i) => i + 1);
  };

  return (
    <div className="space-y-4">
      <div>
        <div className="mb-1.5 flex items-baseline justify-between text-xs text-muted">
          <span>
            Item {Math.min(index + 1, queue.length)} of {queue.length}
          </span>
          <span>{entries.length} in this session</span>
        </div>
        <ProgressBar value={completed} max={queue.length} label="Review progress" />
      </div>

      {entry.kind === 'question' ? (
        <QuestionCard
          key={`${entryId(entry)}-${index}`}
          question={entry.question}
          skillSlug={entrySkill(entry)}
          onGraded={finish}
          onNext={next}
        />
      ) : (
        <ExerciseCard
          key={`${entryId(entry)}-${index}`}
          exercise={entry.exercise}
          theme={theme}
          onGraded={finish}
          onNext={next}
        />
      )}
    </div>
  );
}

// --- Confidence -------------------------------------------------------------

/**
 * The confidence control, asked before anything is revealed.
 *
 * A radiogroup rather than a slider: four options are enough to separate a
 * guess from a certainty, and finer self-report is noise.
 */
function ConfidenceChoice({
  id,
  question,
  explanation,
  value,
  onChange,
}: {
  id: string;
  question: string;
  explanation: string;
  value: ConfidenceRating | null;
  onChange: (rating: ConfidenceRating) => void;
}) {
  return (
    <div className="mt-5">
      <p id={id} className="text-sm font-medium text-ink">
        {question}
      </p>
      <p className="mt-0.5 text-xs text-muted">{explanation}</p>
      <div className="mt-2 flex flex-wrap gap-2" role="radiogroup" aria-labelledby={id}>
        {([1, 2, 3, 4] as ConfidenceRating[]).map((rating) => (
          <button
            key={rating}
            type="button"
            role="radio"
            aria-checked={value === rating}
            onClick={() => onChange(rating)}
            className={[
              'rounded-full border px-3 py-1.5 text-sm transition min-h-[2.25rem]',
              value === rating
                ? 'border-accent bg-accent text-white'
                : 'border-border text-muted hover:border-accent hover:text-ink',
            ].join(' ')}
          >
            {CONFIDENCE_LABELS[rating]}
          </button>
        ))}
      </div>
    </div>
  );
}

/** The shared "when this comes back" note under a graded item. */
function ScheduleNote({ intervalDays }: { intervalDays: number }) {
  return (
    <p className="text-xs text-muted">
      <SparkIcon size={12} />{' '}
      {intervalDays === 0
        ? 'This one comes back before you finish, so you do not leave on a wrong answer.'
        : `Next time you will see this in about ${intervalDays} ${intervalDays === 1 ? 'day' : 'days'} — scheduled for the point where recalling it is useful work rather than a formality.`}
    </p>
  );
}

// --- Questions --------------------------------------------------------------

/**
 * One reviewed question, graded on the server.
 *
 * Exported because the lesson warm-up asks the same three questions in the same
 * way, and a second implementation would be a second place for the confidence
 * prompt or the answer reveal to drift.
 */
export function QuestionCard({
  question,
  skillSlug,
  onGraded,
  onNext,
}: {
  question: ReviewQuestion;
  skillSlug: string;
  onGraded: (correct: boolean) => void;
  onNext: (correct: boolean) => void;
}) {
  const [selected, setSelected] = useState<string[]>([]);
  const [confidence, setConfidence] = useState<ConfidenceRating | null>(null);
  const [outcome, setOutcome] = useState<ReviewOutcomeResult | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [pending, startTransition] = useTransition();

  const answered = outcome !== null;

  const submit = () => {
    if (selected.length === 0 || confidence === null) return;
    setError(null);

    startTransition(async () => {
      const result = await answerReviewItemAction({
        itemId: question.itemId,
        questionId: question.questionId,
        optionIds: selected,
        confidence,
      });

      if (!result.ok || !result.data) {
        setError(result.message ?? 'That did not save. Try again.');
        return;
      }

      setOutcome(result.data);
      onGraded(result.data.isCorrect);
    });
  };

  const toggle = (optionId: string) => {
    if (answered) return;
    setSelected((current) =>
      question.kind === 'multi'
        ? current.includes(optionId)
          ? current.filter((id) => id !== optionId)
          : [...current, optionId]
        : [optionId],
    );
  };

  return (
    <>
      <Card className="p-5">
        <Badge tone="neutral">{skillSlug.replace(/-/g, ' ')}</Badge>
        <h2 className="mt-3 text-lg font-semibold text-ink">
          <InlineText text={question.prompt} />
        </h2>

        <fieldset className="mt-4" disabled={answered || pending}>
          <legend className="sr-only">Choose your answer</legend>
          <ul className="space-y-2">
            {question.options.map((option) => {
              const isChosen = selected.includes(option.id);
              const isRight = outcome?.correctOptionIds.includes(option.id) ?? false;

              return (
                <li key={option.id}>
                  <label
                    className={[
                      'flex cursor-pointer items-start gap-3 rounded-lg border p-3 text-sm transition',
                      answered && isRight
                        ? 'border-[hsl(var(--success))] bg-[hsl(var(--success)/0.08)]'
                        : answered && isChosen
                          ? 'border-[hsl(var(--danger))] bg-[hsl(var(--danger)/0.08)]'
                          : isChosen
                            ? 'border-accent bg-[hsl(var(--accent)/0.06)]'
                            : 'border-border hover:border-accent',
                    ].join(' ')}
                  >
                    <input
                      type={question.kind === 'multi' ? 'checkbox' : 'radio'}
                      name={`review-${question.itemId}`}
                      checked={isChosen}
                      onChange={() => toggle(option.id)}
                      className="mt-0.5"
                    />
                    <span className="text-ink">
                      <InlineText text={option.label} />
                    </span>
                  </label>
                </li>
              );
            })}
          </ul>
        </fieldset>

        {!answered ? (
          <ConfidenceChoice
            id={`confidence-${question.itemId}`}
            question="Before you see the answer — how sure are you?"
            explanation={'This is how the app works out whether your sense of "I know this" matches your results.'}
            value={confidence}
            onChange={setConfidence}
          />
        ) : null}

        {error ? (
          <p role="alert" className="mt-3 text-sm text-[hsl(var(--danger))]">
            {error}
          </p>
        ) : null}

        <div className="mt-5">
          {answered ? (
            <Button onClick={() => onNext(outcome.isCorrect)}>Next</Button>
          ) : (
            <Button onClick={submit} disabled={selected.length === 0 || confidence === null || pending}>
              {pending ? 'Checking…' : 'Check my answer'}
            </Button>
          )}
          {!answered && confidence === null ? (
            <span className="ml-3 text-xs text-muted">Rate your confidence to continue.</span>
          ) : null}
        </div>
      </Card>

      {outcome ? (
        <Callout
          tone={outcome.isCorrect ? 'tip' : 'mistake'}
          title={outcome.isCorrect ? 'Correct' : 'Not this time'}
        >
          <div className="space-y-2">
            {outcome.explanation ? (
              <p>
                <InlineText text={outcome.explanation} />
              </p>
            ) : null}
            <ScheduleNote intervalDays={outcome.intervalDays} />
          </div>
        </Callout>
      ) : null}
    </>
  );
}

// --- Exercises --------------------------------------------------------------

/**
 * A reviewed exercise.
 *
 * Confidence is collected *before* the editor opens rather than beside the
 * check button. A prediction made after twenty minutes of writing is not a
 * prediction about whether the learner could do it — it is a report on how the
 * attempt went, which is the hindsight the whole measurement is designed to
 * avoid.
 */
function ExerciseCard({
  exercise,
  theme,
  onGraded,
  onNext,
}: {
  exercise: ReviewExercise;
  theme: 'light' | 'dark';
  onGraded: (correct: boolean) => void;
  onNext: (correct: boolean) => void;
}) {
  const [confidence, setConfidence] = useState<ConfidenceRating | null>(null);
  const [started, setStarted] = useState(false);
  const [outcome, setOutcome] = useState<ReviewExerciseOutcomeResult | null>(null);

  if (!started) {
    return (
      <Card className="p-5">
        <div className="flex flex-wrap items-center gap-2">
          <Badge tone="neutral">{exercise.skillSlug.replace(/-/g, ' ')}</Badge>
          <Badge>Write it again</Badge>
          <Badge>Difficulty {exercise.difficulty}/5</Badge>
        </div>
        <h2 className="mt-3 text-lg font-semibold text-ink">{exercise.title}</h2>
        <p className="mt-1.5 text-sm text-muted lesson-prose">
          <InlineText text={exercise.brief} />
        </p>

        <ConfidenceChoice
          id={`confidence-${exercise.itemId}`}
          question="Before you open the editor — could you write this now?"
          explanation="Rate it before you start. Judging afterwards is hindsight, and hindsight measures nothing."
          value={confidence}
          onChange={setConfidence}
        />

        <div className="mt-5">
          <Button onClick={() => setStarted(true)} disabled={confidence === null}>
            Open the editor
          </Button>
          {confidence === null ? (
            <span className="ml-3 text-xs text-muted">Rate your confidence to continue.</span>
          ) : null}
        </div>
      </Card>
    );
  }

  return (
    <>
      <Workbench
        exercise={{
          id: exercise.exerciseId,
          slug: exercise.slug,
          kind: exercise.kind,
          title: exercise.title,
          brief: exercise.brief,
          starterCode: exercise.starterCode,
          hints: exercise.hints,
          xpAward: exercise.xpAward,
          difficulty: exercise.difficulty,
          isOptional: exercise.isOptional,
          requirements: exercise.requirements,
          referenceSolution: exercise.referenceSolution,
        }}
        // Always the starter code: reviewing an exercise means writing it
        // again, and handing back the saved answer would make it a reading
        // exercise with extra steps.
        savedCode={null}
        savedHintsUsed={0}
        alreadyPassed={false}
        theme={theme}
        onEvaluate={async (input) => {
          const result = await answerReviewExerciseAction({
            itemId: exercise.itemId,
            exerciseId: input.exerciseId,
            code: input.code,
            hintsUsed: input.hintsUsed,
            durationSeconds: input.durationSeconds,
            confidence: confidence ?? undefined,
          });

          if (result.ok && result.data) {
            setOutcome(result.data);
            onGraded(result.data.result.passed);
          }

          return result;
        }}
        onSave={saveCodeAction}
      />

      {outcome ? (
        <Callout
          tone={outcome.result.passed ? 'tip' : 'mistake'}
          title={outcome.result.passed ? 'Still there' : 'Worth another look'}
        >
          <div className="space-y-2">
            <p>
              {outcome.result.passed
                ? 'You wrote that from memory, which is far stronger evidence than recognising it would have been.'
                : 'This one has faded. It will come back sooner, and the next attempt is where the strengthening happens.'}
            </p>
            <ScheduleNote intervalDays={outcome.intervalDays} />
            <Button size="sm" onClick={() => onNext(outcome.result.passed)}>
              Next
            </Button>
          </div>
        </Callout>
      ) : null}
    </>
  );
}
