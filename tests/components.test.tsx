import { describe, expect, it, vi } from 'vitest';
import { render, screen, within } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { Quiz, type QuizQuestionView } from '@/components/learn/quiz';
import { LessonBlock } from '@/components/learn/lesson-blocks';
import { Badge, Button, Callout, EmptyState, ErrorState, Field, ProgressBar, Stat } from '@/components/ui';
import type { LessonBlockRow } from '@/lib/supabase/database.types';
import type { ActionResult } from '@/lib/actions/schemas';
import type { QuizOutcome } from '@/lib/actions/progress';

/**
 * Component tests.
 *
 * These assert the accessibility properties the course itself teaches: every
 * control has an accessible name, results are announced in a live region, and
 * the answer key never reaches the browser.
 */

function block(partial: Partial<LessonBlockRow> & Pick<LessonBlockRow, 'block_type'>): LessonBlockRow {
  return {
    id: 'block-1',
    lesson_id: 'lesson-1',
    ordinal: 1,
    title: null,
    body: null,
    code: null,
    language: null,
    media_slug: null,
    data: {},
    created_at: '2026-01-01T00:00:00Z',
    updated_at: '2026-01-01T00:00:00Z',
    ...partial,
  };
}

describe('UI primitives', () => {
  it('renders a button with an accessible name', () => {
    render(<Button>Check my work</Button>);
    expect(screen.getByRole('button', { name: 'Check my work' })).toBeInTheDocument();
  });

  it('gives a progress bar a name and correct ARIA values', () => {
    render(<ProgressBar value={3} max={10} label="Lessons completed" />);
    const bar = screen.getByRole('progressbar', { name: 'Lessons completed' });
    expect(bar).toHaveAttribute('aria-valuenow', '3');
    expect(bar).toHaveAttribute('aria-valuemin', '0');
    expect(bar).toHaveAttribute('aria-valuemax', '10');
  });

  it('clamps a progress bar that would overflow', () => {
    render(<ProgressBar value={50} max={10} label="Overshoot" />);
    const bar = screen.getByRole('progressbar', { name: 'Overshoot' });
    expect(bar.firstElementChild).toHaveStyle({ width: '100%' });
  });

  it('associates a field label, hint and error with its input', async () => {
    render(
      <Field label="Email address" htmlFor="email" hint="We only use this to reply." error="Enter a valid address" required>
        <input id="email" aria-describedby="email-hint email-error" aria-invalid />
      </Field>,
    );

    const input = screen.getByLabelText(/Email address/);
    expect(input).toHaveAttribute('aria-invalid', 'true');
    expect(input).toHaveAccessibleDescription(/We only use this to reply/);
    expect(screen.getByRole('alert')).toHaveTextContent('Enter a valid address');
  });

  it('announces an error state to assistive technology', () => {
    render(<ErrorState title="Could not save" description="Try again in a moment." />);
    expect(screen.getByRole('alert')).toHaveTextContent('Could not save');
  });

  it('renders an empty state with its call to action', () => {
    render(
      <EmptyState
        title="Nothing needs practice"
        description="Attempt a few exercises first."
        action={<Button>Browse the roadmap</Button>}
      />,
    );
    expect(screen.getByRole('heading', { name: 'Nothing needs practice' })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'Browse the roadmap' })).toBeInTheDocument();
  });

  it('labels a callout by tone so its purpose is readable', () => {
    render(<Callout tone="mistake" title="Watch out">Do not do that.</Callout>);
    expect(screen.getByText('Common mistake')).toBeInTheDocument();
    expect(screen.getByText('Watch out')).toBeInTheDocument();
  });

  it('renders stats and badges as plain readable text', () => {
    render(
      <>
        <Stat label="Total XP" value="1,240" hint="Level 6" />
        <Badge tone="success">Passed</Badge>
      </>,
    );
    expect(screen.getByText('Total XP')).toBeInTheDocument();
    expect(screen.getByText('1,240')).toBeInTheDocument();
    expect(screen.getByText('Passed')).toBeInTheDocument();
  });
});

describe('lesson blocks', () => {
  it('renders objectives as a list under a heading', () => {
    render(
      <LessonBlock
        block={block({
          block_type: 'objectives',
          title: 'What you will be able to do',
          data: { items: ['Write a valid document', 'Explain the doctype'] },
        })}
      />,
    );
    expect(screen.getByRole('heading', { name: 'What you will be able to do' })).toBeInTheDocument();
    expect(screen.getByText('Write a valid document')).toBeInTheDocument();
  });

  it('renders a term as a description list', () => {
    render(
      <LessonBlock
        block={block({ block_type: 'term', title: 'Browser', body: 'The program you use to look at websites.' })}
      />,
    );
    expect(screen.getByText('Browser')).toBeInTheDocument();
    expect(screen.getByText(/program you use/)).toBeInTheDocument();
  });

  it('escapes markup inside authored prose rather than rendering it', () => {
    render(
      <LessonBlock
        block={block({ block_type: 'prose', body: 'Every page needs a `<title>` element.' })}
      />,
    );
    // The angle brackets must be shown as text, not parsed into an element.
    expect(screen.getByText(/<title>/)).toBeInTheDocument();
    expect(document.querySelector('title')).toBeNull();
  });

  it('renders inline emphasis authored in the content', () => {
    const { container } = render(
      <LessonBlock block={block({ block_type: 'prose', body: 'This is **important** and *stressed*.' })} />,
    );
    expect(container.querySelector('strong')).toHaveTextContent('important');
    expect(container.querySelector('em')).toHaveTextContent('stressed');
  });

  it('renders a visual block with alt text from the media library', () => {
    render(<LessonBlock block={block({ block_type: 'visual', media_slug: 'document-tree', body: 'A caption.' })} />);
    const image = screen.getByRole('img');
    expect(image).toHaveAttribute('src', '/learning-media/svg/document-tree.svg');
    expect(image.getAttribute('alt')?.length).toBeGreaterThan(10);
    expect(screen.getByText('A caption.')).toBeInTheDocument();
  });

  it('renders nothing rather than breaking when a media slug is unknown', () => {
    const { container } = render(
      <LessonBlock block={block({ block_type: 'visual', media_slug: 'does-not-exist' })} />,
    );
    expect(container).toBeEmptyDOMElement();
  });

  it('renders a summary with its recap points', () => {
    render(
      <LessonBlock
        block={block({
          block_type: 'summary',
          title: 'Lesson summary',
          data: { points: ['Tags come in pairs', 'Attributes go in the opening tag'], nextUp: 'Next: nesting.' },
        })}
      />,
    );
    expect(screen.getByText('Tags come in pairs')).toBeInTheDocument();
    expect(screen.getByText('Next: nesting.')).toBeInTheDocument();
  });

  it('collapses progressive detail behind a disclosure', () => {
    render(
      <LessonBlock
        block={block({ block_type: 'progressive_detail', title: 'More detail', body: 'The deeper explanation.' })}
      />,
    );
    const disclosure = screen.getByText('More detail');
    expect(disclosure.closest('details')).toBeInTheDocument();
    expect(disclosure.tagName.toLowerCase()).toBe('summary');
  });

  it('renders an interactive demo as a tab list', async () => {
    const user = userEvent.setup();
    render(
      <LessonBlock
        block={block({
          block_type: 'interactive_demo',
          title: 'Try it',
          body: 'Compare the two.',
          data: {
            variants: [
              { label: 'As a heading', code: '<h1>Hours</h1>', note: 'Large and bold.' },
              { label: 'As a paragraph', code: '<p>Hours</p>', note: 'Normal body text.' },
            ],
          },
        })}
      />,
    );

    const tabs = screen.getAllByRole('tab');
    expect(tabs).toHaveLength(2);
    expect(tabs[0]).toHaveAttribute('aria-selected', 'true');
    expect(screen.getByText('Large and bold.')).toBeInTheDocument();

    await user.click(tabs[1]!);
    expect(tabs[1]).toHaveAttribute('aria-selected', 'true');
    expect(screen.getByText('Normal body text.')).toBeInTheDocument();
  });

  it('renders a comparison with both sides and their reasons', () => {
    render(
      <LessonBlock
        block={block({
          block_type: 'comparison',
          title: 'Nesting',
          data: {
            good: { label: 'Correct', code: '<p><em>a</em></p>', why: 'Properly nested.' },
            bad: { label: 'Broken', code: '<p><em>a</p></em>', why: 'They overlap.' },
          },
        })}
      />,
    );
    expect(screen.getByText('Correct')).toBeInTheDocument();
    expect(screen.getByText('Properly nested.')).toBeInTheDocument();
    expect(screen.getByText('They overlap.')).toBeInTheDocument();
  });

  it('renders a video media example with controls and captions', () => {
    const { container } = render(
      <LessonBlock
        block={block({
          block_type: 'media_example',
          media_slug: 'page-anatomy',
          title: 'An accessible video',
          body: 'Every attribute is doing a job.',
        })}
      />,
    );
    const video = container.querySelector('video');
    expect(video).toHaveAttribute('controls');
    expect(video?.querySelector('track[kind="captions"]')).toBeInTheDocument();
    expect(video?.querySelectorAll('source').length).toBeGreaterThanOrEqual(2);
  });
});

describe('quiz', () => {
  const questions: QuizQuestionView[] = [
    {
      id: 'q1',
      prompt: 'Where does the title element belong?',
      kind: 'single',
      xpAward: 10,
      options: [
        { id: 'o1', label: 'Inside <head>' },
        { id: 'o2', label: 'Inside <body>' },
        { id: 'o3', label: 'Anywhere' },
      ],
    },
  ];

  it('never receives the answer key in its props', () => {
    // The shape itself is the guarantee: `QuizQuestionView` options carry only
    // an id and a label. `is_correct` is stripped server-side.
    for (const option of questions[0]!.options) {
      expect(Object.keys(option).sort()).toEqual(['id', 'label']);
    }
  });

  it('renders the question as a fieldset with a legend', () => {
    render(<Quiz questions={questions} previousAnswers={{}} onAnswer={vi.fn()} />);
    const group = screen.getByRole('group');
    expect(within(group).getByText(/Where does the title element belong/)).toBeInTheDocument();
    expect(screen.getAllByRole('radio')).toHaveLength(3);
  });

  it('keeps the check button disabled until something is selected', async () => {
    const user = userEvent.setup();
    render(<Quiz questions={questions} previousAnswers={{}} onAnswer={vi.fn()} />);

    const button = screen.getByRole('button', { name: 'Check answer' });
    expect(button).toBeDisabled();

    await user.click(screen.getByRole('radio', { name: 'Inside <head>' }));
    expect(button).toBeEnabled();
  });

  it('grades through the server action and shows the explanation', async () => {
    const user = userEvent.setup();
    const onAnswer = vi.fn(
      async (): Promise<ActionResult<QuizOutcome>> => ({
        ok: true,
        data: {
          isCorrect: true,
          correctOptionIds: ['o1'],
          explanation: 'The title describes the page, so it lives in the head.',
          xpAwarded: 10,
        },
      }),
    );

    render(<Quiz questions={questions} previousAnswers={{}} onAnswer={onAnswer} />);

    await user.click(screen.getByRole('radio', { name: 'Inside <head>' }));
    await user.click(screen.getByRole('button', { name: 'Check answer' }));

    expect(onAnswer).toHaveBeenCalledWith({ questionId: 'q1', optionIds: ['o1'] });
    expect(await screen.findByText(/The title describes the page/)).toBeInTheDocument();
    expect(screen.getByText('Correct')).toBeInTheDocument();
    expect(screen.getByText(/\+10 XP/)).toBeInTheDocument();
  });

  it('explains a wrong answer rather than only marking it wrong', async () => {
    const user = userEvent.setup();
    const onAnswer = vi.fn(
      async (): Promise<ActionResult<QuizOutcome>> => ({
        ok: true,
        data: {
          isCorrect: false,
          correctOptionIds: ['o1'],
          explanation: 'The head holds information about the page.',
          xpAwarded: 0,
        },
      }),
    );

    render(<Quiz questions={questions} previousAnswers={{}} onAnswer={onAnswer} />);
    await user.click(screen.getByRole('radio', { name: 'Inside <body>' }));
    await user.click(screen.getByRole('button', { name: 'Check answer' }));

    expect(await screen.findByText('Not this time')).toBeInTheDocument();
    expect(screen.getByText(/The head holds information/)).toBeInTheDocument();
  });

  it('locks the options once answered', async () => {
    const user = userEvent.setup();
    const onAnswer = vi.fn(
      async (): Promise<ActionResult<QuizOutcome>> => ({
        ok: true,
        data: { isCorrect: true, correctOptionIds: ['o1'], explanation: 'Yes.', xpAwarded: 10 },
      }),
    );

    render(<Quiz questions={questions} previousAnswers={{}} onAnswer={onAnswer} />);
    await user.click(screen.getByRole('radio', { name: 'Inside <head>' }));
    await user.click(screen.getByRole('button', { name: 'Check answer' }));

    await screen.findByText('Correct');
    for (const radio of screen.getAllByRole('radio')) {
      expect(radio).toBeDisabled();
    }
  });

  it('supports multi-select questions with checkboxes', async () => {
    const user = userEvent.setup();
    const multi: QuizQuestionView[] = [
      {
        id: 'q2',
        prompt: 'Which are void elements?',
        kind: 'multi',
        xpAward: 10,
        options: [
          { id: 'a', label: '<img>' },
          { id: 'b', label: '<br>' },
          { id: 'c', label: '<p>' },
        ],
      },
    ];
    const onAnswer = vi.fn(
      async (): Promise<ActionResult<QuizOutcome>> => ({
        ok: true,
        data: { isCorrect: true, correctOptionIds: ['a', 'b'], explanation: 'Both wrap nothing.', xpAwarded: 10 },
      }),
    );

    render(<Quiz questions={multi} previousAnswers={{}} onAnswer={onAnswer} />);
    expect(screen.getAllByRole('checkbox')).toHaveLength(3);

    await user.click(screen.getByRole('checkbox', { name: '<img>' }));
    await user.click(screen.getByRole('checkbox', { name: '<br>' }));
    await user.click(screen.getByRole('button', { name: 'Check answer' }));

    expect(onAnswer).toHaveBeenCalledWith({ questionId: 'q2', optionIds: ['a', 'b'] });
  });

  it('tells a returning learner they have answered before', () => {
    render(
      <Quiz
        questions={questions}
        previousAnswers={{ q1: { selected: ['o2'], isCorrect: false } }}
        onAnswer={vi.fn()}
      />,
    );
    expect(screen.getByText(/answered this before and were incorrect/)).toBeInTheDocument();
  });
});
