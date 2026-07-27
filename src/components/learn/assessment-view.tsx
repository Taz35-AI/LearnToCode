'use client';

import { useRef, useState, useTransition } from 'react';
import { Badge, Button, ButtonLink, Card, ProgressBar } from '@/components/ui';
import { AlertIcon, CheckCircleIcon, SparkIcon } from '@/components/ui/icons';
import { cx } from '@/lib/utils';
import type { AssessmentOutcome } from '@/lib/actions/progress';
import type { ActionResult } from '@/lib/actions/schemas';

/**
 * A milestone or final assessment.
 *
 * Unlike a lesson knowledge check, every question is answered before anything
 * is graded — this is a check of retained understanding, not a guided
 * exercise. Wrong answers come back with their explanation, and the assessment
 * can be retaken as many times as needed.
 */

export interface AssessmentQuestion {
  id: string;
  prompt: string;
  kind: 'single' | 'multi' | 'true_false';
  options: { id: string; label: string }[];
}

export function AssessmentView({
  assessment,
  questions,
  bestScore,
  onSubmit,
}: {
  assessment: { id: string; title: string; description: string; passScore: number; xpAward: number };
  questions: AssessmentQuestion[];
  bestScore: number | null;
  onSubmit: (input: {
    assessmentId: string;
    answers: { questionId: string; optionIds: string[] }[];
  }) => Promise<ActionResult<AssessmentOutcome>>;
}) {
  const [answers, setAnswers] = useState<Record<string, string[]>>({});
  const [outcome, setOutcome] = useState<AssessmentOutcome | null>(null);
  const [isPending, startTransition] = useTransition();
  const resultRef = useRef<HTMLDivElement | null>(null);

  const answeredCount = Object.values(answers).filter((v) => v.length > 0).length;
  const allAnswered = answeredCount === questions.length;

  const select = (questionId: string, optionId: string, isMulti: boolean) => {
    if (outcome) return;
    setAnswers((current) => {
      const existing = current[questionId] ?? [];
      if (!isMulti) return { ...current, [questionId]: [optionId] };
      return {
        ...current,
        [questionId]: existing.includes(optionId)
          ? existing.filter((id) => id !== optionId)
          : [...existing, optionId],
      };
    });
  };

  const submit = () => {
    startTransition(async () => {
      const response = await onSubmit({
        assessmentId: assessment.id,
        answers: questions.map((question) => ({
          questionId: question.id,
          optionIds: answers[question.id] ?? [],
        })),
      });
      if (response.ok && response.data) {
        setOutcome(response.data);
        requestAnimationFrame(() => resultRef.current?.focus());
      }
    });
  };

  const retake = () => {
    setAnswers({});
    setOutcome(null);
  };

  return (
    <div className="mx-auto max-w-3xl p-5 lg:p-10">
      <header className="mb-7">
        <Badge tone="warning">Milestone assessment</Badge>
        <h1 className="mt-2.5 text-2xl font-bold text-ink lg:text-3xl">{assessment.title}</h1>
        <p className="mt-2 text-muted">{assessment.description}</p>

        <div className="mt-4 flex flex-wrap items-center gap-3">
          <Badge tone="accent">
            Pass mark {Math.round(assessment.passScore * 100)}%
          </Badge>
          <Badge>
            <SparkIcon size={12} /> {assessment.xpAward} XP
          </Badge>
          {bestScore !== null ? (
            <Badge tone={bestScore >= assessment.passScore ? 'success' : 'neutral'}>
              Best so far: {Math.round(bestScore * 100)}%
            </Badge>
          ) : null}
        </div>

        <div className="mt-4">
          <ProgressBar
            value={answeredCount}
            max={questions.length}
            label="Questions answered"
            showValue
          />
        </div>
      </header>

      <ol className="space-y-4">
        {questions.map((question, index) => {
          const selected = answers[question.id] ?? [];
          const feedback = outcome?.perQuestion.find((p) => p.questionId === question.id);
          const isMulti = question.kind === 'multi';

          return (
            <li key={question.id}>
              <Card className="p-5">
                <fieldset>
                  <legend className="font-semibold text-ink">
                    <span className="text-muted">{index + 1}. </span>
                    {question.prompt}
                    {isMulti ? (
                      <span className="ml-2 text-xs font-normal text-muted">
                        (choose all that apply)
                      </span>
                    ) : null}
                  </legend>

                  <div className="mt-3 space-y-2">
                    {question.options.map((option) => {
                      const isSelected = selected.includes(option.id);
                      const isCorrect = feedback?.correctOptionIds.includes(option.id) ?? false;
                      const showWrong = outcome && isSelected && !isCorrect;

                      return (
                        <label
                          key={option.id}
                          className={cx(
                            'flex items-start gap-3 rounded-lg border p-3 transition-colors',
                            outcome
                              ? isCorrect
                                ? 'border-[hsl(var(--success)/0.45)] bg-[hsl(var(--success-soft))]'
                                : showWrong
                                  ? 'border-[hsl(var(--danger)/0.45)] bg-[hsl(var(--danger-soft))]'
                                  : 'border-app'
                              : isSelected
                                ? 'cursor-pointer border-[hsl(var(--accent))] bg-[hsl(var(--accent-soft))]'
                                : 'cursor-pointer border-app hover:border-strong',
                          )}
                        >
                          <input
                            type={isMulti ? 'checkbox' : 'radio'}
                            name={`assessment-${question.id}`}
                            checked={isSelected}
                            onChange={() => select(question.id, option.id, isMulti)}
                            disabled={Boolean(outcome)}
                            className="mt-0.5 h-4 w-4 shrink-0 accent-[hsl(var(--accent))]"
                          />
                          <span className="text-ink">{option.label}</span>
                        </label>
                      );
                    })}
                  </div>

                  {feedback ? (
                    <p
                      className={cx(
                        'mt-3 rounded-lg border p-3 text-sm',
                        feedback.correct
                          ? 'border-[hsl(var(--success)/0.35)] bg-[hsl(var(--success-soft))] text-ink'
                          : 'border-[hsl(var(--warning)/0.4)] bg-[hsl(var(--warning-soft))] text-ink',
                      )}
                    >
                      <strong className="font-semibold">
                        {feedback.correct ? 'Correct. ' : 'Not quite. '}
                      </strong>
                      {feedback.explanation}
                    </p>
                  ) : null}
                </fieldset>
              </Card>
            </li>
          );
        })}
      </ol>

      <div ref={resultRef} tabIndex={-1} aria-live="polite" className="mt-7 focus:outline-none">
        {outcome ? (
          <Card
            className={cx(
              'p-6 text-center',
              outcome.passed
                ? 'border-[hsl(var(--success)/0.4)]'
                : 'border-[hsl(var(--warning)/0.4)]',
            )}
          >
            <span
              className={cx(
                'mx-auto grid h-12 w-12 place-items-center rounded-full',
                outcome.passed
                  ? 'bg-[hsl(var(--success-soft))] text-[hsl(var(--success))]'
                  : 'bg-[hsl(var(--warning-soft))] text-[hsl(var(--warning))]',
              )}
              aria-hidden="true"
            >
              {outcome.passed ? <CheckCircleIcon size={26} /> : <AlertIcon size={26} />}
            </span>

            <p className="mt-4 text-2xl font-bold text-ink">
              {outcome.correctCount} out of {outcome.total} —{' '}
              {Math.round(outcome.score * 100)}%
            </p>
            <p className="mt-1.5 text-muted">
              {outcome.passed
                ? 'Passed. The questions you missed are explained above — read them before moving on.'
                : `You need ${Math.round(assessment.passScore * 100)}% to pass. Read the explanations above, revisit the lessons they came from, and take it again. There is no penalty for retaking.`}
            </p>

            {outcome.xpAwarded > 0 ? (
              <p className="mt-3 inline-flex items-center gap-1.5 font-semibold text-[hsl(var(--success))]">
                <SparkIcon size={16} />+{outcome.xpAwarded} XP
              </p>
            ) : null}

            <div className="mt-6 flex flex-wrap justify-center gap-3">
              <Button variant="secondary" onClick={retake}>
                Take it again
              </Button>
              <ButtonLink href="/dashboard">Back to dashboard</ButtonLink>
            </div>
          </Card>
        ) : (
          <Button size="lg" onClick={submit} disabled={!allAnswered || isPending} className="w-full">
            {isPending
              ? 'Marking…'
              : allAnswered
                ? 'Submit assessment'
                : `Answer all ${questions.length} questions first (${answeredCount} done)`}
          </Button>
        )}
      </div>
    </div>
  );
}
