import { describe, expect, it, vi } from 'vitest';
import { render, screen, within } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { Quiz, type QuizQuestionView } from '@/components/learn/quiz';
import { CourseSwitcher } from '@/components/learn/course-switcher';
import { LessonBlock } from '@/components/learn/lesson-blocks';
import { Badge, Button, Callout, EmptyState, ErrorState, Field, ProgressBar, Stat } from '@/components/ui';
import { inlineFormat } from '@/lib/utils';
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

/**
 * Authored inline emphasis.
 *
 * The curriculum uses backticks for code in roughly 450 places — question
 * prompts, answer explanations, exercise briefs, summary points, checklists.
 * Any render site that prints one of those as a bare string shows the learner
 * literal backticks, and the failure is invisible in code review because the
 * markup looks perfectly reasonable. These tests pin the formatter and the
 * places it has to be applied.
 */
describe('inline formatting of authored text', () => {
  it('renders code, bold and italic', () => {
    expect(inlineFormat('Use `<title>` here')).toBe('Use <code>&lt;title&gt;</code> here');
    expect(inlineFormat('This is **important**')).toBe('This is <strong>important</strong>');
    expect(inlineFormat('This is *stressed*')).toBe('This is <em>stressed</em>');
  });

  it('escapes the input before adding any markup back', () => {
    // Course content is full of literal tags. They must become text, never
    // elements — otherwise a lesson about <script> would be a security bug.
    expect(inlineFormat('<script>alert(1)</script>')).toBe(
      '&lt;script&gt;alert(1)&lt;/script&gt;',
    );
    expect(inlineFormat('A & B')).toBe('A &amp; B');
  });

  it('leaves text with no emphasis untouched', () => {
    expect(inlineFormat('Just a plain sentence.')).toBe('Just a plain sentence.');
  });

  it('renders emphasis in a quiz prompt, its options and its explanation', async () => {
    const user = userEvent.setup();
    const backticked: QuizQuestionView[] = [
      {
        id: 'q9',
        prompt: 'In `<p>Hello</p>`, which part is the element?',
        kind: 'single',
        xpAward: 10,
        options: [
          { id: 'a', label: 'The whole of `<p>Hello</p>`' },
          { id: 'b', label: 'Just `<p>`' },
        ],
      },
    ];
    const onAnswer = vi.fn(
      async (): Promise<ActionResult<QuizOutcome>> => ({
        ok: true,
        data: {
          isCorrect: true,
          correctOptionIds: ['a'],
          explanation: 'An element is the opening tag, the content and `</p>` together.',
          xpAwarded: 10,
        },
      }),
    );

    render(<Quiz questions={backticked} previousAnswers={{}} onAnswer={onAnswer} />);

    expect(screen.queryByText(/`/)).not.toBeInTheDocument();

    await user.click(screen.getByRole('radio', { name: 'The whole of <p>Hello</p>' }));
    await user.click(screen.getByRole('radio', { name: 'Certain' }));
    await user.click(screen.getByRole('button', { name: 'Check answer' }));

    await screen.findByText(/An element is the opening tag/);
    expect(screen.queryByText(/`/)).not.toBeInTheDocument();
  });

  it('renders emphasis in summary points and checklist items', () => {
    render(
      <LessonBlock
        block={block({
          block_type: 'summary',
          title: 'Lesson summary',
          data: {
            points: ['Void elements such as `<br>` have no closing tag.'],
            nextUp: 'Next: how `<div>` differs.',
          },
        })}
      />,
    );
    expect(screen.queryByText(/`/)).not.toBeInTheDocument();
    expect(screen.getByText('<br>').tagName).toBe('CODE');
    expect(screen.getByText('<div>').tagName).toBe('CODE');
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
    // The title sits inside the <summary> rather than being its only child,
    // because authored titles are run through the inline formatter. What
    // matters is the nesting — a <summary> inside a <details> is what makes it
    // a keyboard-operable disclosure — not which element holds the text.
    const disclosure = screen.getByText('More detail');
    expect(disclosure.closest('details')).toBeInTheDocument();
    expect(disclosure.closest('summary')).toBeInTheDocument();
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

/**
 * The retrieval-practice blocks.
 *
 * One property matters more than any other and is asserted for every one of
 * them: the answer is not in the document until the learner has committed to an
 * attempt. A block that renders its answer alongside its question is not
 * retrieval practice, it is a paragraph — and the failure would be invisible,
 * because it would look exactly right.
 */
describe('retrieval-practice blocks', () => {
  it('withholds the pretest answer until a guess is locked in', async () => {
    const user = userEvent.setup();
    render(
      <LessonBlock
        block={block({
          block_type: 'pretest',
          title: 'Before we start — have a guess',
          body: 'Which part is the element?',
          data: {
            options: ['The whole thing', 'Just the opening tag'],
            answer: 'The element is the whole thing.',
          },
        })}
      />,
    );

    expect(screen.queryByText(/The element is the whole thing/)).not.toBeInTheDocument();

    const commit = screen.getByRole('button', { name: 'Lock in my guess' });
    expect(commit).toBeDisabled();

    await user.click(screen.getByRole('radio', { name: 'The whole thing' }));
    await user.click(commit);

    expect(screen.getByText(/The element is the whole thing/)).toBeInTheDocument();
  });

  it('formats inline code in options and lists rather than showing backticks', async () => {
    const user = userEvent.setup();
    render(
      <LessonBlock
        block={block({
          block_type: 'pretest',
          title: 'Have a guess',
          body: 'Which part is the element?',
          data: {
            options: ['The whole of `<h1>Hi</h1>`', 'Just `<h1>`'],
            answer: 'The whole thing.',
          },
        })}
      />,
    );

    // Authored content uses backticks for code throughout. Rendering a list
    // item or a radio label as plain text shows them literally, which is what
    // this caught in the real application.
    expect(screen.queryByText(/`/)).not.toBeInTheDocument();
    const option = screen.getByText('<h1>Hi</h1>');
    expect(option.tagName).toBe('CODE');

    // And the accessible name is still the readable text, without backticks.
    await user.click(screen.getByRole('radio', { name: 'The whole of <h1>Hi</h1>' }));
    expect(screen.getByRole('button', { name: 'Lock in my guess' })).toBeEnabled();
  });

  it('withholds the recall points until the learner has written an answer', async () => {
    const user = userEvent.setup();
    render(
      <LessonBlock
        block={block({
          block_type: 'recall',
          title: 'From memory',
          body: 'List everything you remember about void elements.',
          data: { points: ['They wrap no content', 'They have no closing tag'] },
        })}
      />,
    );

    expect(screen.queryByText('They wrap no content')).not.toBeInTheDocument();
    expect(screen.getByRole('textbox')).toBeInTheDocument();

    await user.click(screen.getByRole('button', { name: /Show what a good answer covers/ }));
    expect(screen.getByText('They wrap no content')).toBeInTheDocument();
  });

  it('withholds what happens until the prediction is made', async () => {
    const user = userEvent.setup();
    render(
      <LessonBlock
        block={block({
          block_type: 'predict_check',
          title: 'Predict, then check',
          body: 'What will the browser do?',
          code: '<p>One</p>',
          data: { outcome: 'The browser repairs it silently.' },
        })}
      />,
    );

    expect(screen.queryByText(/repairs it silently/)).not.toBeInTheDocument();
    await user.click(screen.getByRole('button', { name: 'Run it and see' }));
    expect(screen.getByText(/repairs it silently/)).toBeInTheDocument();
  });

  it('withholds the model explanation until the learner has written theirs', async () => {
    const user = userEvent.setup();
    render(
      <LessonBlock
        block={block({
          block_type: 'self_explain',
          title: 'Explain it in your own words',
          body: 'Why do semantic elements matter if the page looks the same?',
          data: { modelAnswer: 'Looking identical is exactly the point.' },
        })}
      />,
    );

    expect(screen.queryByText(/Looking identical is exactly the point/)).not.toBeInTheDocument();
    await user.click(screen.getByRole('button', { name: /Compare with one way of putting it/ }));
    expect(screen.getByText(/Looking identical is exactly the point/)).toBeInTheDocument();
  });

  it('reveals a worked example one step at a time', async () => {
    const user = userEvent.setup();
    render(
      <LessonBlock
        block={block({
          block_type: 'worked_example',
          title: 'Working out one path',
          body: 'Four steps, every time.',
          data: {
            steps: [
              { title: 'Say where you are', code: 'projects/first.html', reasoning: 'Measured from there.' },
              { title: 'Say where the file is', code: 'images/logo.svg', reasoning: 'Siblings, not nested.' },
            ],
          },
        })}
      />,
    );

    // Showing every step at once turns a worked example into a finished
    // solution to skim, and the reasoning is what gets skipped.
    expect(screen.getByText('Say where you are')).toBeInTheDocument();
    expect(screen.queryByText('Say where the file is')).not.toBeInTheDocument();

    await user.click(screen.getByRole('button', { name: /Show the next step/ }));
    expect(screen.getByText('Say where the file is')).toBeInTheDocument();
    expect(screen.queryByRole('button', { name: /Show the next step/ })).not.toBeInTheDocument();
  });

  it('withholds the closing recap answers until the learner has attempted them', async () => {
    const user = userEvent.setup();
    render(
      <LessonBlock
        block={block({
          block_type: 'recap',
          title: 'Close the book',
          data: {
            prompts: ['What is the difference between a tag and an element?'],
            points: ['A tag is one label in angle brackets.'],
          },
        })}
      />,
    );

    expect(screen.getByText(/difference between a tag and an element/)).toBeInTheDocument();
    expect(screen.queryByText(/one label in angle brackets/)).not.toBeInTheDocument();

    await user.click(screen.getByRole('button', { name: 'Show the answers' }));
    expect(screen.getByText(/one label in angle brackets/)).toBeInTheDocument();
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
    for (const option of questions[0]!.options) {
      expect(screen.getByRole('radio', { name: option.label })).toBeInTheDocument();
    }
  });

  it('asks for confidence before the answer is checked, not after', () => {
    render(<Quiz questions={questions} previousAnswers={{}} onAnswer={vi.fn()} />);
    // Asked afterwards this would be hindsight, which measures nothing — so
    // the control has to be present while the answer is still unknown.
    const rating = screen.getByRole('radiogroup', { name: /how sure are you/i });
    expect(within(rating).getAllByRole('radio')).toHaveLength(4);
  });

  it('requires both an answer and a confidence rating before checking', async () => {
    const user = userEvent.setup();
    render(<Quiz questions={questions} previousAnswers={{}} onAnswer={vi.fn()} />);

    const button = screen.getByRole('button', { name: 'Check answer' });
    expect(button).toBeDisabled();

    await user.click(screen.getByRole('radio', { name: 'Inside <head>' }));
    // Still disabled: an optional rating would be filled in when the learner
    // feels sure and skipped when they do not, biasing the very thing it is
    // meant to measure.
    expect(button).toBeDisabled();

    await user.click(screen.getByRole('radio', { name: 'Fairly sure' }));
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
    await user.click(screen.getByRole('radio', { name: 'Certain' }));
    await user.click(screen.getByRole('button', { name: 'Check answer' }));

    expect(onAnswer).toHaveBeenCalledWith({ questionId: 'q1', optionIds: ['o1'], confidence: 4 });
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
    await user.click(screen.getByRole('radio', { name: 'Guessing' }));
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
    await user.click(screen.getByRole('radio', { name: 'Fairly sure' }));
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
    await user.click(screen.getByRole('radio', { name: 'Not sure' }));
    await user.click(screen.getByRole('button', { name: 'Check answer' }));

    expect(onAnswer).toHaveBeenCalledWith({
      questionId: 'q2',
      optionIds: ['a', 'b'],
      confidence: 2,
    });
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

/**
 * The course switcher.
 *
 * It is the only route to the CSS course, so "does it render both courses and
 * submit the right slug" is load-bearing rather than cosmetic.
 */
describe('CourseSwitcher', () => {
  const courses = [
    { slug: 'html-hero', title: 'HTML Hero' },
    { slug: 'css-architect', title: 'CSS Architect' },
  ];

  it('offers every course and marks the current one', () => {
    render(<CourseSwitcher courses={courses} activeSlug="html-hero" action={() => {}} />);

    const group = screen.getByRole('group', { name: /course/i });
    expect(within(group).getByRole('button', { name: /HTML Hero/ })).toHaveAttribute(
      'aria-current',
      'true',
    );
    expect(within(group).getByRole('button', { name: 'CSS Architect' })).not.toHaveAttribute(
      'aria-current',
    );
  });

  it('submits the slug of the course chosen', async () => {
    const action = vi.fn();
    render(<CourseSwitcher courses={courses} activeSlug="html-hero" action={action} />);

    await userEvent.click(screen.getByRole('button', { name: 'CSS Architect' }));

    expect(action).toHaveBeenCalledTimes(1);
    const submitted = action.mock.calls[0]?.[0] as FormData;
    expect(submitted.get('course')).toBe('css-architect');
  });

  it('renders nothing when there is only one course to choose from', () => {
    const { container } = render(
      <CourseSwitcher courses={[courses[0]!]} activeSlug="html-hero" action={() => {}} />,
    );
    expect(container).toBeEmptyDOMElement();
  });
});
