'use client';

import { useState, useTransition } from 'react';
import { Badge, Button, ProgressBar } from '@/components/ui';
import { AlertIcon, CheckCircleIcon, SparkIcon } from '@/components/ui/icons';
import { cx } from '@/lib/utils';
import type { QuizOutcome } from '@/lib/actions/progress';
import type { ActionResult } from '@/lib/actions/schemas';

/**
 * The knowledge check.
 *
 * Answers are graded on the server: the browser is never sent `is_correct`, so
 * the answer key cannot be read out of the page source. The learner sees the
 * explanation after answering, whether they were right or wrong — being told
 * *why* is the part that teaches.
 */

export interface QuizQuestionView {
  id: string;
  prompt: string;
  kind: 'single' | 'multi' | 'true_false';
  xpAward: number;
  options: { id: string; label: string }[];
}

interface AnswerState {
  selected: string[];
  outcome: QuizOutcome | null;
}

export function Quiz({
  questions,
  previousAnswers,
  onAnswer,
}: {
  questions: QuizQuestionView[];
  previousAnswers: Record<string, { selected: string[]; isCorrect: boolean }>;
  onAnswer: (input: { questionId: string; optionIds: string[] }) => Promise<ActionResult<QuizOutcome>>;
}) {
  const [answers, setAnswers] = useState<Record<string, AnswerState>>(() => {
    const initial: Record<string, AnswerState> = {};
    for (const question of questions) {
      const previous = previousAnswers[question.id];
      initial[question.id] = { selected: previous?.selected ?? [], outcome: null };
    }
    return initial;
  });

  const answeredCount = questions.filter(
    (q) => answers[q.id]?.outcome || previousAnswers[q.id],
  ).length;

  if (questions.length === 0) return null;

  return (
    <section aria-labelledby="knowledge-check" className="rounded-[var(--radius-card)] border border-app bg-surface shadow-card">
      <header className="flex flex-wrap items-center justify-between gap-3 border-b border-app px-5 py-4">
        <div>
          <h2 id="knowledge-check" className="text-lg font-bold text-ink">
            Knowledge check
          </h2>
          <p className="mt-0.5 text-sm text-muted">
            {questions.length} {questions.length === 1 ? 'question' : 'questions'}. Getting one
            wrong is useful — read the explanation and try the next.
          </p>
        </div>
        <div className="w-40">
          <ProgressBar
            value={answeredCount}
            max={questions.length}
            label="Questions answered"
            tone="accent"
            size="sm"
            showValue
          />
        </div>
      </header>

      <ol className="divide-y divide-[hsl(var(--border))]">
        {questions.map((question, index) => (
          <QuizQuestion
            key={question.id}
            question={question}
            index={index + 1}
            state={answers[question.id] ?? { selected: [], outcome: null }}
            previous={previousAnswers[question.id]}
            onSelect={(optionIds) =>
              setAnswers((current) => ({
                ...current,
                [question.id]: { selected: optionIds, outcome: current[question.id]?.outcome ?? null },
              }))
            }
            onSubmit={async (optionIds) => {
              const response = await onAnswer({ questionId: question.id, optionIds });
              if (response.ok && response.data) {
                setAnswers((current) => ({
                  ...current,
                  [question.id]: { selected: optionIds, outcome: response.data ?? null },
                }));
              }
            }}
          />
        ))}
      </ol>
    </section>
  );
}

function QuizQuestion({
  question,
  index,
  state,
  previous,
  onSelect,
  onSubmit,
}: {
  question: QuizQuestionView;
  index: number;
  state: AnswerState;
  previous?: { selected: string[]; isCorrect: boolean };
  onSelect: (optionIds: string[]) => void;
  onSubmit: (optionIds: string[]) => Promise<void>;
}) {
  const [isPending, startTransition] = useTransition();
  const outcome = state.outcome;
  const answered = outcome !== null;
  const isMulti = question.kind === 'multi';

  const toggle = (optionId: string) => {
    if (answered) return;
    if (isMulti) {
      onSelect(
        state.selected.includes(optionId)
          ? state.selected.filter((id) => id !== optionId)
          : [...state.selected, optionId],
      );
    } else {
      onSelect([optionId]);
    }
  };

  const groupName = `question-${question.id}`;

  return (
    <li className="px-5 py-5">
      <fieldset>
        <legend className="font-semibold text-ink">
          <span className="text-muted">{index}. </span>
          {question.prompt}
          {isMulti ? (
            <span className="ml-2 text-xs font-normal text-muted">(choose all that apply)</span>
          ) : null}
        </legend>

        {previous && !answered ? (
          <p className="mt-1.5 text-xs text-muted">
            You answered this before and were{' '}
            {previous.isCorrect ? 'correct' : 'incorrect'}. You may answer again.
          </p>
        ) : null}

        <div className="mt-3 space-y-2">
          {question.options.map((option) => {
            const isSelected = state.selected.includes(option.id);
            const isCorrectOption = outcome?.correctOptionIds.includes(option.id) ?? false;
            const showAsWrong = answered && isSelected && !isCorrectOption;

            return (
              <label
                key={option.id}
                className={cx(
                  'flex cursor-pointer items-start gap-3 rounded-lg border p-3 transition-colors',
                  answered && isCorrectOption
                    ? 'border-[hsl(var(--success)/0.45)] bg-[hsl(var(--success-soft))]'
                    : showAsWrong
                      ? 'border-[hsl(var(--danger)/0.45)] bg-[hsl(var(--danger-soft))]'
                      : isSelected
                        ? 'border-[hsl(var(--accent))] bg-[hsl(var(--accent-soft))]'
                        : 'border-app hover:border-strong',
                  answered && 'cursor-default',
                )}
              >
                <input
                  type={isMulti ? 'checkbox' : 'radio'}
                  name={groupName}
                  value={option.id}
                  checked={isSelected}
                  onChange={() => toggle(option.id)}
                  disabled={answered}
                  className="mt-0.5 h-4 w-4 shrink-0 accent-[hsl(var(--accent))]"
                />
                <span className="text-ink">{option.label}</span>
                {answered && isCorrectOption ? (
                  <span className="ml-auto shrink-0 text-[hsl(var(--success))]" aria-label="Correct answer">
                    <CheckCircleIcon size={18} />
                  </span>
                ) : null}
              </label>
            );
          })}
        </div>

        {!answered ? (
          <Button
            className="mt-4"
            size="sm"
            disabled={state.selected.length === 0 || isPending}
            onClick={() => startTransition(() => void onSubmit(state.selected))}
          >
            {isPending ? 'Checking…' : 'Check answer'}
          </Button>
        ) : (
          <div
            role="status"
            className={cx(
              'mt-4 rounded-lg border p-3.5',
              outcome.isCorrect
                ? 'border-[hsl(var(--success)/0.35)] bg-[hsl(var(--success-soft))]'
                : 'border-[hsl(var(--warning)/0.4)] bg-[hsl(var(--warning-soft))]',
            )}
          >
            <p className="flex items-center gap-2 font-semibold text-ink">
              <span
                className={
                  outcome.isCorrect ? 'text-[hsl(var(--success))]' : 'text-[hsl(var(--warning))]'
                }
              >
                {outcome.isCorrect ? <CheckCircleIcon size={18} /> : <AlertIcon size={18} />}
              </span>
              {outcome.isCorrect ? 'Correct' : 'Not this time'}
              {outcome.xpAwarded > 0 ? (
                <Badge tone="success" className="ml-1">
                  <SparkIcon size={12} />+{outcome.xpAwarded} XP
                </Badge>
              ) : null}
            </p>
            <p className="mt-1.5 text-sm text-ink">{outcome.explanation}</p>
          </div>
        )}
      </fieldset>
    </li>
  );
}
