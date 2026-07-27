'use client';

import { useState } from 'react';
import { QuestionCard } from './review-session';
import { Badge, Button, Card, ProgressBar } from '@/components/ui';
import { CheckIcon } from '@/components/ui/icons';
import type { ReviewQuestion } from '@/lib/data/review';

/**
 * The retrieval warm-up that opens a lesson.
 *
 * Every lesson begins by pulling prior material back out of memory rather than
 * restating it. Re-reading a summary of the last lesson produces a strong
 * feeling of knowing and very little retention; a failed attempt to recall,
 * followed by the answer, produces the opposite. So a lesson opens with two or
 * three questions the learner may well get wrong — the discomfort is the
 * mechanism, not a side effect.
 *
 * Two decisions that matter as much as the questions themselves:
 *
 * 1. **It does not block the lesson.** The teaching content is on the page
 *    underneath, and skipping takes one click. A gate would convert a warm-up
 *    into a toll, and a learner who resents it will click through without
 *    retrieving anything, which is worse than not asking.
 * 2. **The questions come from earlier lessons, never this one.** Retrieval has
 *    to be of prior material for it to prime what follows. Asking this lesson's
 *    own questions first is a pretest — a different, also useful, thing, which
 *    is why `pretest` is an authored block type rather than something generated
 *    here.
 */
export function LessonWarmUp({ questions }: { questions: ReviewQuestion[] }) {
  const [index, setIndex] = useState(0);
  const [correctCount, setCorrectCount] = useState(0);
  const [skipped, setSkipped] = useState(false);

  if (questions.length === 0) return null;

  const question = questions[index];
  const finished = !question || skipped;

  if (finished) {
    return (
      <Card className="mb-8 border-[hsl(var(--accent-border))] p-5">
        <div className="flex flex-wrap items-center gap-2">
          <span className="text-[hsl(var(--success))]" aria-hidden="true">
            <CheckIcon size={18} />
          </span>
          <h2 className="font-semibold text-ink">
            {skipped ? 'Warm-up skipped' : 'Warm-up done'}
          </h2>
        </div>
        <p className="mt-1.5 text-sm text-muted">
          {skipped
            ? 'No problem — it is below whenever you want it. Recalling before you read is what makes the reading stick, so it is worth two minutes on the way in.'
            : `${correctCount} of ${index} recalled. Anything you missed has been rescheduled to come back sooner — getting one wrong here is the most useful thing that can happen to it.`}
        </p>
        {skipped ? (
          <Button className="mt-3" size="sm" variant="secondary" onClick={() => setSkipped(false)}>
            Do the warm-up after all
          </Button>
        ) : null}
      </Card>
    );
  }

  return (
    <section aria-labelledby="warm-up" className="mb-8">
      <Card className="border-[hsl(var(--accent-border))] p-5">
        <div className="flex flex-wrap items-baseline justify-between gap-2">
          <div>
            <Badge tone="accent">Warm-up</Badge>
            <h2 id="warm-up" className="mt-2 text-lg font-bold text-ink">
              Before this lesson — what do you still remember?
            </h2>
          </div>
          <span className="text-xs text-muted">
            {index + 1} of {questions.length}
          </span>
        </div>

        <p className="mt-1.5 text-sm text-muted">
          From earlier lessons, not this one. Getting these wrong is expected and useful — a failed
          attempt to recall something makes the next explanation of it land far harder than reading
          it again would.
        </p>

        <div className="mt-3">
          <ProgressBar value={index} max={questions.length} label="Warm-up progress" size="sm" />
        </div>
      </Card>

      <div className="mt-4">
        <QuestionCard
          key={question.itemId}
          question={question}
          skillSlug={question.skillSlug}
          onGraded={(correct) => {
            if (correct) setCorrectCount((n) => n + 1);
          }}
          onNext={() => setIndex((i) => i + 1)}
        />
      </div>

      <button
        type="button"
        onClick={() => setSkipped(true)}
        className="mt-3 text-sm text-muted underline underline-offset-2 hover:text-ink"
      >
        Skip to the lesson
      </button>
    </section>
  );
}
