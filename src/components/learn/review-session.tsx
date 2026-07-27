'use client';

import { useState, useTransition } from 'react';
import { answerReviewItemAction, type ReviewOutcomeResult } from '@/lib/actions/review';
import { CONFIDENCE_LABELS, type ConfidenceRating } from '@/lib/review/calibration';
import type { ReviewQuestion } from '@/lib/data/review';
import { Badge, Button, Callout, Card, ProgressBar } from '@/components/ui';
import { CheckIcon, SparkIcon } from '@/components/ui/icons';

/**
 * The review session.
 *
 * Three deliberate design decisions, all of which make the session feel harder
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
 */
export function ReviewSession({ questions }: { questions: ReviewQuestion[] }) {
  const [queue, setQueue] = useState(questions);
  const [index, setIndex] = useState(0);
  const [selected, setSelected] = useState<string[]>([]);
  const [confidence, setConfidence] = useState<ConfidenceRating | null>(null);
  const [outcome, setOutcome] = useState<ReviewOutcomeResult | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [completed, setCompleted] = useState(0);
  const [correctCount, setCorrectCount] = useState(0);
  const [pending, startTransition] = useTransition();

  const question = queue[index];
  const total = questions.length;

  if (!question) {
    return (
      <Card className="p-8 text-center">
        <div className="mx-auto mb-4 grid h-12 w-12 place-items-center rounded-full bg-[hsl(var(--success)/0.12)] text-[hsl(var(--success))]">
          <CheckIcon size={22} />
        </div>
        <h2 className="text-xl font-bold text-ink">Review complete</h2>
        <p className="mt-2 text-sm text-muted">
          {correctCount} of {completed} recalled correctly. Each one you got right just moved
          further into the future; the ones you missed will come back sooner.
        </p>
      </Card>
    );
  }

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

      const graded = result.data;
      setOutcome(graded);
      setCompleted((n) => n + 1);
      if (graded.isCorrect) setCorrectCount((n) => n + 1);
    });
  };

  const next = () => {
    const wasWrong = outcome !== null && !outcome.isCorrect;
    setOutcome(null);
    setSelected([]);
    setConfidence(null);

    if (wasWrong) {
      // Re-queue at the end rather than dropping it: finishing on a failure is
      // the one outcome worth designing away.
      setQueue((current) => [...current, question]);
    }
    setIndex((i) => i + 1);
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
    <div className="space-y-4">
      <div>
        <div className="mb-1.5 flex items-baseline justify-between text-xs text-muted">
          <span>
            Item {Math.min(index + 1, queue.length)} of {queue.length}
          </span>
          <span>{total} due today</span>
        </div>
        <ProgressBar value={completed} max={queue.length} label="Review progress" />
      </div>

      <Card className="p-5">
        <Badge tone="neutral">{question.skillSlug.replace(/-/g, ' ')}</Badge>
        <h2 className="mt-3 text-lg font-semibold text-ink">{question.prompt}</h2>

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
                    <span className="text-ink">{option.label}</span>
                  </label>
                </li>
              );
            })}
          </ul>
        </fieldset>

        {!answered ? (
          <div className="mt-5">
            <p id="confidence-label" className="text-sm font-medium text-ink">
              Before you see the answer — how sure are you?
            </p>
            <p className="mt-0.5 text-xs text-muted">
              This is how the app works out whether your sense of &ldquo;I know this&rdquo; matches
              your results.
            </p>
            <div
              className="mt-2 flex flex-wrap gap-2"
              role="radiogroup"
              aria-labelledby="confidence-label"
            >
              {([1, 2, 3, 4] as ConfidenceRating[]).map((rating) => (
                <button
                  key={rating}
                  type="button"
                  role="radio"
                  aria-checked={confidence === rating}
                  onClick={() => setConfidence(rating)}
                  className={[
                    'rounded-full border px-3 py-1.5 text-sm transition',
                    confidence === rating
                      ? 'border-accent bg-accent text-white'
                      : 'border-border text-muted hover:border-accent hover:text-ink',
                  ].join(' ')}
                >
                  {CONFIDENCE_LABELS[rating]}
                </button>
              ))}
            </div>
          </div>
        ) : null}

        {error ? (
          <p role="alert" className="mt-3 text-sm text-[hsl(var(--danger))]">
            {error}
          </p>
        ) : null}

        <div className="mt-5">
          {answered ? (
            <Button onClick={next}>Next</Button>
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
        <Callout tone={outcome.isCorrect ? 'tip' : 'mistake'} title={outcome.isCorrect ? 'Correct' : 'Not this time'}>
          <div className="space-y-2">
            {outcome.explanation ? <p>{outcome.explanation}</p> : null}
            <p className="text-xs text-muted">
              <SparkIcon size={12} />{' '}
              {outcome.intervalDays === 0
                ? 'This one comes back before you finish, so you do not leave on a wrong answer.'
                : `Next time you will see this in about ${outcome.intervalDays} ${outcome.intervalDays === 1 ? 'day' : 'days'} — scheduled for the point where recalling it is useful work rather than a formality.`}
            </p>
          </div>
        </Callout>
      ) : null}
    </div>
  );
}
