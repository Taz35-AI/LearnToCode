import { beforeEach, describe, expect, it, vi } from 'vitest';
import { render, screen, within } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import type { ReviewEntry, ReviewExercise, ReviewQuestion } from '@/lib/data/review';

/**
 * The review interface.
 *
 * `ReviewSession` and `LessonWarmUp` call their server actions directly rather
 * than receiving them as props, so the actions are mocked here — importing them
 * for real would pull `server-only` into a browser environment.
 *
 * What these tests protect is the set of decisions that make review work and
 * that would each be silently undone by an innocent-looking change:
 * confidence collected *before* the answer, the answer withheld until the
 * learner commits, exercises actually reaching the learner, and a failed item
 * coming back rather than ending the session on a wrong answer.
 */

const answerReviewItemAction = vi.fn();
const answerReviewExerciseAction = vi.fn();

vi.mock('@/lib/actions/review', () => ({
  answerReviewItemAction: (input: unknown) => answerReviewItemAction(input),
  answerReviewExerciseAction: (input: unknown) => answerReviewExerciseAction(input),
}));

vi.mock('@/lib/actions/progress', () => ({
  saveCodeAction: vi.fn(async () => ({ ok: true })),
}));

const { ReviewSession } = await import('@/components/learn/review-session');
const { LessonWarmUp } = await import('@/components/learn/lesson-warm-up');

const question = (overrides: Partial<ReviewQuestion> = {}): ReviewQuestion => ({
  itemId: '11111111-1111-4111-8111-111111111111',
  questionId: '22222222-2222-4222-8222-222222222222',
  prompt: 'Where does the title element belong?',
  kind: 'single',
  lessonSlug: 'doctype-html-head-body',
  skillSlug: 'document-structure',
  options: [
    { id: 'o1', label: 'Inside <head>' },
    { id: 'o2', label: 'Inside <body>' },
  ],
  ...overrides,
});

const exercise = (overrides: Partial<ReviewExercise> = {}): ReviewExercise => ({
  itemId: '33333333-3333-4333-8333-333333333333',
  exerciseId: '44444444-4444-4444-8444-444444444444',
  slug: 'attributes-guided',
  kind: 'guided',
  title: 'Add an attribute to a link',
  brief: 'The link below has no destination.',
  starterCode: '<a>opening hours</a>',
  hints: ['An attribute goes inside the opening tag.'],
  xpAward: 30,
  difficulty: 1,
  isOptional: false,
  requirements: [{ id: 'r1', message: 'There is a link element' }],
  referenceSolution: null,
  lessonSlug: 'tags-elements-attributes',
  skillSlug: 'syntax',
  ...overrides,
});

const graded = (isCorrect: boolean) => ({
  ok: true as const,
  data: {
    isCorrect,
    correctOptionIds: ['o1'],
    explanation: 'The title describes the page, so it lives in the head.',
    intervalDays: isCorrect ? 4 : 0,
    retrievability: 0.6,
  },
});

beforeEach(() => {
  answerReviewItemAction.mockReset();
  answerReviewExerciseAction.mockReset();
});

describe('review session', () => {
  it('asks for confidence before revealing anything, and requires it', async () => {
    const user = userEvent.setup();
    answerReviewItemAction.mockResolvedValue(graded(true));

    render(<ReviewSession entries={[{ kind: 'question', question: question() }]} />);

    const check = screen.getByRole('button', { name: 'Check my answer' });
    expect(check).toBeDisabled();

    await user.click(screen.getByRole('radio', { name: 'Inside <head>' }));
    expect(check).toBeDisabled();

    await user.click(screen.getByRole('radio', { name: 'Certain' }));
    expect(check).toBeEnabled();

    // The explanation must not exist in the document before the learner
    // commits: a visible answer turns retrieval practice into reading.
    expect(screen.queryByText(/The title describes the page/)).not.toBeInTheDocument();

    await user.click(check);
    expect(await screen.findByText(/The title describes the page/)).toBeInTheDocument();
    expect(answerReviewItemAction).toHaveBeenCalledWith(
      expect.objectContaining({ confidence: 4, optionIds: ['o1'] }),
    );
  });

  it('re-queues a failed item so the session never ends on a wrong answer', async () => {
    const user = userEvent.setup();
    answerReviewItemAction.mockResolvedValue(graded(false));

    render(<ReviewSession entries={[{ kind: 'question', question: question() }]} />);

    expect(screen.getByText('Item 1 of 1')).toBeInTheDocument();

    await user.click(screen.getByRole('radio', { name: 'Inside <body>' }));
    await user.click(screen.getByRole('radio', { name: 'Not sure' }));
    await user.click(screen.getByRole('button', { name: 'Check my answer' }));
    await user.click(await screen.findByRole('button', { name: 'Next' }));

    // The queue grew rather than finishing: the item comes back later in this
    // same session.
    expect(screen.getByText('Item 2 of 2')).toBeInTheDocument();
    expect(screen.queryByText('Review complete')).not.toBeInTheDocument();
  });

  it('finishes when a correct answer empties the queue', async () => {
    const user = userEvent.setup();
    answerReviewItemAction.mockResolvedValue(graded(true));

    render(<ReviewSession entries={[{ kind: 'question', question: question() }]} />);

    await user.click(screen.getByRole('radio', { name: 'Inside <head>' }));
    await user.click(screen.getByRole('radio', { name: 'Fairly sure' }));
    await user.click(screen.getByRole('button', { name: 'Check my answer' }));
    await user.click(await screen.findByRole('button', { name: 'Next' }));

    expect(screen.getByRole('heading', { name: 'Review complete' })).toBeInTheDocument();
    expect(screen.getByText(/1 of 1 recalled correctly/)).toBeInTheDocument();
  });

  it('serves exercise items rather than dropping them', () => {
    // 79 of the 195 reviewable items are exercises. They were previously
    // selected by the composer and then filtered out before rendering, so the
    // queue only ever tested recognition.
    render(<ReviewSession entries={[{ kind: 'exercise', exercise: exercise() }]} />);

    expect(screen.getByRole('heading', { name: 'Add an attribute to a link' })).toBeInTheDocument();
    expect(screen.getByText('Write it again')).toBeInTheDocument();
  });

  it('collects confidence on an exercise before the editor opens', async () => {
    const user = userEvent.setup();
    render(<ReviewSession entries={[{ kind: 'exercise', exercise: exercise() }]} />);

    const open = screen.getByRole('button', { name: 'Open the editor' });
    expect(open).toBeDisabled();

    // Rated after twenty minutes of writing, this would be a report on how the
    // attempt went rather than a prediction — which is the hindsight the whole
    // measurement exists to avoid.
    const rating = screen.getByRole('radiogroup', { name: /could you write this now/i });
    expect(within(rating).getAllByRole('radio')).toHaveLength(4);

    await user.click(within(rating).getByRole('radio', { name: 'Guessing' }));
    expect(open).toBeEnabled();
  });

  it('counts a mixed queue as one session', () => {
    const entries: ReviewEntry[] = [
      { kind: 'question', question: question() },
      { kind: 'exercise', exercise: exercise() },
    ];
    render(<ReviewSession entries={entries} />);

    expect(screen.getByText('Item 1 of 2')).toBeInTheDocument();
    expect(screen.getByText('2 in this session')).toBeInTheDocument();
  });

  it('names the session when one is given, so module recall is not mistaken for the queue', async () => {
    const user = userEvent.setup();
    answerReviewItemAction.mockResolvedValue(graded(true));

    render(
      <ReviewSession
        entries={[{ kind: 'question', question: question() }]}
        title="Module recall"
      />,
    );

    await user.click(screen.getByRole('radio', { name: 'Inside <head>' }));
    await user.click(screen.getByRole('radio', { name: 'Certain' }));
    await user.click(screen.getByRole('button', { name: 'Check my answer' }));
    await user.click(await screen.findByRole('button', { name: 'Next' }));

    expect(screen.getByRole('heading', { name: 'Module recall complete' })).toBeInTheDocument();
  });
});

describe('lesson warm-up', () => {
  it('renders nothing at all when there is nothing to retrieve', () => {
    // A learner's very first lesson has no prior material. An empty warm-up
    // card would read as a broken feature rather than an honest absence.
    const { container } = render(<LessonWarmUp questions={[]} />);
    expect(container).toBeEmptyDOMElement();
  });

  it('opens the lesson with retrieval rather than restatement', () => {
    render(<LessonWarmUp questions={[question()]} />);

    expect(
      screen.getByRole('heading', { name: /what do you still remember/i }),
    ).toBeInTheDocument();
    expect(screen.getByText(/Where does the title element belong/)).toBeInTheDocument();
  });

  it('can be skipped, because a gate would be clicked through rather than answered', async () => {
    const user = userEvent.setup();
    render(<LessonWarmUp questions={[question()]} />);

    await user.click(screen.getByRole('button', { name: 'Skip to the lesson' }));

    expect(screen.getByRole('heading', { name: 'Warm-up skipped' })).toBeInTheDocument();
    expect(screen.queryByText(/Where does the title element belong/)).not.toBeInTheDocument();

    // And it is not a one-way door.
    await user.click(screen.getByRole('button', { name: 'Do the warm-up after all' }));
    expect(screen.getByText(/Where does the title element belong/)).toBeInTheDocument();
  });

  it('reports what was recalled once it is finished', async () => {
    const user = userEvent.setup();
    answerReviewItemAction.mockResolvedValue(graded(true));

    render(<LessonWarmUp questions={[question()]} />);

    await user.click(screen.getByRole('radio', { name: 'Inside <head>' }));
    await user.click(screen.getByRole('radio', { name: 'Certain' }));
    await user.click(screen.getByRole('button', { name: 'Check my answer' }));
    await user.click(await screen.findByRole('button', { name: 'Next' }));

    expect(screen.getByRole('heading', { name: 'Warm-up done' })).toBeInTheDocument();
    expect(screen.getByText(/1 of 1 recalled/)).toBeInTheDocument();
  });
});
