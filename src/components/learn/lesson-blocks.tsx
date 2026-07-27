'use client';

import { useState } from 'react';
import { InlinePreview } from '@/components/editor/preview';
import { Badge, Callout, InlineText } from '@/components/ui';
import { getMedia } from '@/content/media/manifest';
import { cx, inlineFormat } from '@/lib/utils';
import { CheckIcon, CodeIcon, LightbulbIcon } from '@/components/ui/icons';
import type { Json, LessonBlockRow } from '@/lib/supabase/database.types';

/**
 * Renders lesson content blocks.
 *
 * Content arrives from the database as many small typed rows, so this is a
 * dispatcher rather than a template. Adding a new block type is a case here
 * plus a row in `lesson_blocks` — the learner interface never needs rebuilding
 * to reorder, reword or extend a lesson.
 */

// --- Safe readers for the untyped `data` column ----------------------------

function readArray(data: Json, key: string): unknown[] {
  if (typeof data !== 'object' || data === null || Array.isArray(data)) return [];
  const value = (data as Record<string, unknown>)[key];
  return Array.isArray(value) ? value : [];
}

function readString(data: Json, key: string): string | null {
  if (typeof data !== 'object' || data === null || Array.isArray(data)) return null;
  const value = (data as Record<string, unknown>)[key];
  return typeof value === 'string' ? value : null;
}

function readObject(data: Json, key: string): Record<string, unknown> | null {
  if (typeof data !== 'object' || data === null || Array.isArray(data)) return null;
  const value = (data as Record<string, unknown>)[key];
  return typeof value === 'object' && value !== null && !Array.isArray(value)
    ? (value as Record<string, unknown>)
    : null;
}

function str(value: unknown): string {
  return typeof value === 'string' ? value : '';
}

function Prose({ text }: { text: string }) {
  return (
    <div
      className="lesson-prose text-ink"
      // Input is authored content from this repository and is HTML-escaped by
      // `inlineFormat` before any emphasis markup is added back.
      dangerouslySetInnerHTML={{
        __html: text
          .split('\n\n')
          .map((paragraph) => `<p>${inlineFormat(paragraph)}</p>`)
          .join(''),
      }}
    />
  );
}

// --- Individual block renderers --------------------------------------------

function ObjectivesBlock({ block }: { block: LessonBlockRow }) {
  const items = readArray(block.data, 'items').map(str).filter(Boolean);
  return (
    <section
      aria-labelledby={`objectives-${block.id}`}
      className="rounded-[var(--radius-card)] border border-[hsl(var(--accent-border))] bg-[hsl(var(--accent-soft))] p-5"
    >
      <h2 id={`objectives-${block.id}`} className="text-sm font-bold uppercase tracking-wide text-accent">
        <InlineText text={block.title ?? 'What you will be able to do'} />
      </h2>
      <ul className="mt-3 space-y-2">
        {items.map((item) => (
          <li key={item} className="flex gap-2.5 text-ink">
            <span className="mt-1 shrink-0 text-accent" aria-hidden="true">
              <CheckIcon size={15} />
            </span>
            <span>
              <InlineText text={item} />
            </span>
          </li>
        ))}
      </ul>
    </section>
  );
}

function TermBlock({ block }: { block: LessonBlockRow }) {
  const example = readString(block.data, 'example');
  return (
    <div className="rounded-[var(--radius-card)] border-l-4 border-[hsl(var(--accent))] bg-[hsl(var(--bg-subtle))] py-3 pl-4 pr-4">
      <p className="text-xs font-bold uppercase tracking-wide text-accent">New word</p>
      <dl className="mt-1">
        <dt className="font-mono font-semibold text-ink">{block.title}</dt>
        <dd className="mt-1 text-ink">{block.body ? <Prose text={block.body} /> : null}</dd>
      </dl>
      {example ? (
        <pre className="mt-2.5 overflow-x-auto rounded-md border border-app bg-surface p-2.5 text-xs">
          <code>{example}</code>
        </pre>
      ) : null}
    </div>
  );
}

function VisualBlock({ block }: { block: LessonBlockRow }) {
  const asset = block.media_slug ? getMedia(block.media_slug) : undefined;
  if (!asset) return null;

  return (
    <figure className="my-2">
      {/* eslint-disable-next-line @next/next/no-img-element */}
      <img
        src={asset.path}
        alt={asset.suggestedAlt || asset.description}
        width={asset.width}
        height={asset.height}
        loading="lazy"
        className="w-full rounded-[var(--radius-card)] border border-app bg-white"
      />
      {block.body ? (
        <figcaption className="mt-2 text-sm text-muted">
          <InlineText text={block.body} />
        </figcaption>
      ) : null}
    </figure>
  );
}

function CodeBlock({ block }: { block: LessonBlockRow }) {
  const [showPreview, setShowPreview] = useState(false);
  const canPreview = (block.language ?? 'html') === 'html';

  return (
    <div>
      <div className="flex items-center justify-between gap-3 rounded-t-[var(--radius-card)] border border-b-0 border-app bg-[hsl(var(--bg-subtle))] px-4 py-2">
        <p className="flex items-center gap-1.5 text-xs font-semibold text-muted">
          <CodeIcon size={14} />
          <InlineText text={block.title ?? 'Example'} />
        </p>
        {canPreview ? (
          <button
            type="button"
            onClick={() => setShowPreview((value) => !value)}
            className="text-xs font-semibold text-accent underline underline-offset-2"
          >
            {showPreview ? 'Hide result' : 'Show result'}
          </button>
        ) : null}
      </div>
      <pre className="overflow-x-auto border border-app bg-surface p-4 text-sm">
        <code>{block.code}</code>
      </pre>
      {showPreview && block.code ? (
        <div className="rounded-b-[var(--radius-card)] border border-t-0 border-app bg-[hsl(var(--bg-subtle))] p-3">
          <p className="mb-2 text-xs text-faint">
            How a browser renders it. Styling here is supplied by HTML Hero.
          </p>
          <InlinePreview code={block.code} label={`Rendered result of ${block.title ?? 'the example'}`} />
        </div>
      ) : (
        <div className="h-0 rounded-b-[var(--radius-card)] border border-t-0 border-app" />
      )}
    </div>
  );
}

function AnnotatedCodeBlock({ block }: { block: LessonBlockRow }) {
  const annotations = readArray(block.data, 'annotations').flatMap((entry) => {
    if (typeof entry !== 'object' || entry === null || Array.isArray(entry)) return [];
    const record = entry as Record<string, unknown>;
    return [{ line: str(record.line), text: str(record.text) }];
  });

  return (
    <div className="rounded-[var(--radius-card)] border border-app overflow-hidden">
      <p className="border-b border-app bg-[hsl(var(--bg-subtle))] px-4 py-2 text-xs font-semibold text-muted">
        <InlineText text={block.title ?? 'Line by line'} />
      </p>
      <pre className="overflow-x-auto bg-surface p-4 text-sm">
        <code>{block.code}</code>
      </pre>
      <ol className="divide-y divide-[hsl(var(--border))] border-t border-app">
        {annotations.map((annotation, index) => (
          <li key={`${annotation.line}-${index}`} className="flex gap-3 px-4 py-2.5">
            <span className="mt-0.5 shrink-0 rounded bg-[hsl(var(--bg-subtle))] px-1.5 py-0.5 font-mono text-xs text-muted">
              {annotation.line}
            </span>
            <div className="min-w-0 text-sm">
              <Prose text={annotation.text} />
            </div>
          </li>
        ))}
      </ol>
    </div>
  );
}

function ComparisonBlock({ block }: { block: LessonBlockRow }) {
  const good = readObject(block.data, 'good');
  const bad = readObject(block.data, 'bad');
  if (!good || !bad) return null;

  const panels = [
    { data: good, tone: 'success' as const },
    { data: bad, tone: 'danger' as const },
  ];

  return (
    <div>
      {block.title ? (
        <h3 className="mb-3 font-semibold text-ink">
          <InlineText text={block.title} />
        </h3>
      ) : null}
      <div className="grid gap-3 md:grid-cols-2">
        {panels.map(({ data, tone }) => (
          <div
            key={str(data.label)}
            className={cx(
              'overflow-hidden rounded-[var(--radius-card)] border',
              tone === 'success'
                ? 'border-[hsl(var(--success)/0.35)]'
                : 'border-[hsl(var(--danger)/0.35)]',
            )}
          >
            <p
              className={cx(
                'px-3 py-1.5 text-xs font-bold',
                tone === 'success'
                  ? 'bg-[hsl(var(--success-soft))] text-[hsl(var(--success))]'
                  : 'bg-[hsl(var(--danger-soft))] text-[hsl(var(--danger))]',
              )}
            >
              {str(data.label)}
            </p>
            <pre className="overflow-x-auto bg-surface p-3 text-xs">
              <code>{str(data.code)}</code>
            </pre>
            <p className="border-t border-app bg-[hsl(var(--bg-subtle))] px-3 py-2 text-sm text-muted">
              <InlineText text={str(data.why)} />
            </p>
          </div>
        ))}
      </div>
    </div>
  );
}

function InteractiveDemoBlock({ block }: { block: LessonBlockRow }) {
  const variants = readArray(block.data, 'variants').flatMap((entry) => {
    if (typeof entry !== 'object' || entry === null || Array.isArray(entry)) return [];
    const record = entry as Record<string, unknown>;
    return [{ label: str(record.label), code: str(record.code), note: str(record.note) }];
  });

  const [active, setActive] = useState(0);
  const current = variants[active];
  if (!current) return null;

  return (
    <section className="rounded-[var(--radius-card)] border border-app overflow-hidden">
      <div className="border-b border-app bg-[hsl(var(--bg-subtle))] px-4 py-3">
        <h3 className="font-semibold text-ink">
          <InlineText text={block.title ?? 'Try it'} />
        </h3>
        {block.body ? (
          <p className="mt-0.5 text-sm text-muted">
            <InlineText text={block.body} />
          </p>
        ) : null}
      </div>

      <div role="tablist" aria-label={block.title ?? 'Demonstration options'} className="flex flex-wrap gap-1 border-b border-app p-2">
        {variants.map((variant, index) => (
          <button
            key={variant.label}
            type="button"
            role="tab"
            aria-selected={active === index}
            onClick={() => setActive(index)}
            className={cx(
              'rounded-lg px-3 py-1.5 text-sm font-medium min-h-[2.25rem] transition-colors',
              active === index
                ? 'bg-[hsl(var(--accent-soft))] text-[hsl(var(--accent))]'
                : 'text-muted hover:text-ink hover:bg-[hsl(var(--bg-subtle))]',
            )}
          >
            {variant.label}
          </button>
        ))}
      </div>

      <div className="grid md:grid-cols-2 divide-y md:divide-y-0 md:divide-x divide-[hsl(var(--border))]">
        <pre className="overflow-x-auto bg-surface p-4 text-xs">
          <code>{current.code}</code>
        </pre>
        <div className="p-3">
          <InlinePreview code={current.code} label={`Result: ${current.label}`} height={180} />
        </div>
      </div>

      <p className="border-t border-app bg-[hsl(var(--bg-subtle))] px-4 py-2.5 text-sm text-muted">
        <InlineText text={current.note} />
      </p>
    </section>
  );
}

function MediaExampleBlock({ block }: { block: LessonBlockRow }) {
  const asset = block.media_slug ? getMedia(block.media_slug) : undefined;

  return (
    <section className="rounded-[var(--radius-card)] border border-app overflow-hidden">
      <div className="border-b border-app bg-[hsl(var(--bg-subtle))] px-4 py-3">
        <h3 className="font-semibold text-ink">
          <InlineText text={block.title ?? ''} />
        </h3>
        {block.body ? (
          <p className="mt-0.5 text-sm text-muted">
            <InlineText text={block.body} />
          </p>
        ) : null}
      </div>

      {asset ? (
        <div className="border-b border-app p-4">
          {asset.kind === 'video' ? (
            <video
              controls
              preload="metadata"
              poster={asset.posterPath}
              width={asset.width}
              height={asset.height}
              className="w-full rounded-lg border border-app"
            >
              {asset.formats.map((format) => (
                <source key={format.path} src={format.path} type={format.type} />
              ))}
              {asset.captionsPath ? (
                <track
                  kind="captions"
                  src={asset.captionsPath}
                  srcLang="en"
                  label="English"
                  default
                />
              ) : null}
              <p>
                Your browser cannot play this video.{' '}
                <a href={asset.path}>Download the MP4 file</a>.
              </p>
            </video>
          ) : asset.kind === 'audio' ? (
            <audio controls preload="none" className="w-full">
              {asset.formats.map((format) => (
                <source key={format.path} src={format.path} type={format.type} />
              ))}
              <p>
                Your browser cannot play audio. <a href={asset.path}>Download the file</a>.
              </p>
            </audio>
          ) : (
            /* eslint-disable-next-line @next/next/no-img-element */
            <img
              src={asset.path}
              alt={asset.suggestedAlt || asset.description}
              width={asset.width}
              height={asset.height}
              loading="lazy"
              className="w-full rounded-lg border border-app"
            />
          )}
          <p className="mt-2 text-xs text-faint">
            {asset.title} · {asset.attribution.licence}
          </p>
        </div>
      ) : null}

      {block.code ? (
        <pre className="overflow-x-auto bg-surface p-4 text-sm">
          <code>{block.code}</code>
        </pre>
      ) : null}
    </section>
  );
}

function ProgressiveDetailBlock({ block }: { block: LessonBlockRow }) {
  return (
    <details className="rounded-[var(--radius-card)] border border-app bg-[hsl(var(--bg-subtle))] px-4 py-3">
      <summary className="cursor-pointer font-semibold text-ink">
        <InlineText text={block.title ?? 'More detail'} />
      </summary>
      <div className="mt-3 text-sm">
        {block.body ? <Prose text={block.body} /> : null}
        {block.code ? (
          <pre className="mt-3 overflow-x-auto rounded-lg border border-app bg-surface p-3 text-xs">
            <code>{block.code}</code>
          </pre>
        ) : null}
      </div>
    </details>
  );
}

function ChecklistBlock({ block }: { block: LessonBlockRow }) {
  const items = readArray(block.data, 'items').map(str).filter(Boolean);
  return (
    <section className="rounded-[var(--radius-card)] border border-app bg-surface p-5">
      <h3 className="font-semibold text-ink">
        <InlineText text={block.title ?? 'Checklist'} />
      </h3>
      <ul className="mt-3 space-y-2">
        {items.map((item) => (
          <li key={item} className="flex gap-2.5 text-sm">
            <span className="mt-0.5 shrink-0 text-[hsl(var(--success))]" aria-hidden="true">
              <CheckIcon size={15} />
            </span>
            <span className="text-ink">
              <InlineText text={item} />
            </span>
          </li>
        ))}
      </ul>
    </section>
  );
}

function SummaryBlock({ block }: { block: LessonBlockRow }) {
  const points = readArray(block.data, 'points').map(str).filter(Boolean);
  const nextUp = readString(block.data, 'nextUp');

  return (
    <section
      aria-labelledby={`summary-${block.id}`}
      className="rounded-[var(--radius-card)] border border-app bg-[hsl(var(--bg-subtle))] p-5"
    >
      <h2 id={`summary-${block.id}`} className="flex items-center gap-2 font-semibold text-ink">
        <LightbulbIcon size={17} className="text-[hsl(var(--warning))]" />
        <InlineText text={block.title ?? 'Lesson summary'} />
      </h2>
      <ul className="mt-3 space-y-1.5 pl-5 list-disc text-ink">
        {points.map((point) => (
          <li key={point}>
            <InlineText text={point} />
          </li>
        ))}
      </ul>
      {nextUp ? (
        <p className="mt-4 border-t border-app pt-3 text-sm text-muted">
          <InlineText text={nextUp} />
        </p>
      ) : null}
    </section>
  );
}

// --- Retrieval-practice blocks ---------------------------------------------
//
// Six block types that share one rule: nothing is revealed until the learner
// has committed to an attempt. The reveal is always a deliberate action, never
// a hover, an auto-expand or a `<details>` a reader's eye can slide past —
// because an answer glimpsed before the attempt turns retrieval practice back
// into reading, which is the thing it exists to replace.

/** The shared "you have attempted it, here is the answer" panel. */
function Revealed({
  id,
  tone,
  title,
  children,
}: {
  id: string;
  tone: 'accent' | 'success';
  title: string;
  children: React.ReactNode;
}) {
  return (
    <div
      id={id}
      className={cx(
        'mt-4 rounded-lg border p-3.5',
        tone === 'success'
          ? 'border-[hsl(var(--success)/0.35)] bg-[hsl(var(--success-soft))]'
          : 'border-[hsl(var(--accent-border))] bg-[hsl(var(--accent-soft))]',
      )}
    >
      <p className="text-xs font-bold uppercase tracking-wide text-accent">{title}</p>
      <div className="mt-2 text-sm text-ink">{children}</div>
    </div>
  );
}

/** The frame every retrieval block sits in, so they read as one family. */
function RetrievalFrame({
  block,
  eyebrow,
  children,
}: {
  block: LessonBlockRow;
  eyebrow: string;
  children: React.ReactNode;
}) {
  return (
    <section
      aria-labelledby={`retrieval-${block.id}`}
      className="rounded-[var(--radius-card)] border border-[hsl(var(--accent-border))] bg-surface p-5"
    >
      <p className="text-xs font-bold uppercase tracking-wide text-accent">{eyebrow}</p>
      <h3 id={`retrieval-${block.id}`} className="mt-1 font-semibold text-ink">
        <InlineText text={block.title ?? ''} />
      </h3>
      {children}
    </section>
  );
}

/**
 * A written-answer block: a prompt, a box to write in, and a reveal.
 *
 * The learner's writing is deliberately not saved or graded. Nobody can mark
 * free recall automatically, and pretending to would be worse than not trying:
 * the value is entirely in the act of retrieving, and the points below are how
 * the learner marks themselves.
 */
function WrittenAnswerBlock({
  block,
  eyebrow,
  placeholder,
  revealLabel,
  revealTitle,
  prompts,
  reveal,
}: {
  block: LessonBlockRow;
  eyebrow: string;
  placeholder: string;
  revealLabel: string;
  revealTitle: string;
  prompts: string[];
  reveal: React.ReactNode;
}) {
  const [revealed, setRevealed] = useState(false);
  const fieldId = `written-${block.id}`;
  const panelId = `written-panel-${block.id}`;

  return (
    <RetrievalFrame block={block} eyebrow={eyebrow}>
      {block.body ? (
        <div className="mt-2 text-sm">
          <Prose text={block.body} />
        </div>
      ) : null}

      {prompts.length > 0 ? (
        <ul className="mt-3 space-y-1.5 pl-5 list-disc text-sm text-ink">
          {prompts.map((prompt) => (
            <li key={prompt}>
              <InlineText text={prompt} />
            </li>
          ))}
        </ul>
      ) : null}

      <label htmlFor={fieldId} className="mt-4 block text-sm font-medium text-ink">
        Your answer — write it before you look
      </label>
      <textarea
        id={fieldId}
        rows={4}
        placeholder={placeholder}
        className="mt-1.5 w-full rounded-lg border border-app bg-app p-3 text-sm text-ink placeholder:text-faint focus:border-accent focus:outline-none focus:ring-2 focus:ring-[hsl(var(--accent)/0.35)]"
      />
      <p className="mt-1 text-xs text-faint">
        Nothing here is saved or marked. Writing it is what does the work.
      </p>

      {!revealed ? (
        <button
          type="button"
          onClick={() => setRevealed(true)}
          aria-expanded={false}
          aria-controls={panelId}
          className="mt-3 rounded-lg border border-accent px-3.5 py-2 text-sm font-semibold text-accent transition-colors hover:bg-[hsl(var(--accent-soft))] min-h-[2.5rem]"
        >
          {revealLabel}
        </button>
      ) : (
        <Revealed id={panelId} tone="accent" title={revealTitle}>
          {reveal}
        </Revealed>
      )}
    </RetrievalFrame>
  );
}

function PretestBlock({ block }: { block: LessonBlockRow }) {
  const options = readArray(block.data, 'options').map(str).filter(Boolean);
  const answer = readString(block.data, 'answer') ?? '';
  const [chosen, setChosen] = useState<string | null>(null);
  const [committed, setCommitted] = useState(false);
  const panelId = `pretest-panel-${block.id}`;

  return (
    <RetrievalFrame block={block} eyebrow="Before we teach it">
      {block.body ? (
        <div className="mt-2 text-sm">
          <Prose text={block.body} />
        </div>
      ) : null}

      <fieldset className="mt-3" disabled={committed}>
        <legend className="sr-only">Choose your guess</legend>
        <ul className="space-y-2">
          {options.map((option) => (
            <li key={option}>
              <label
                className={cx(
                  'flex cursor-pointer items-start gap-3 rounded-lg border p-3 text-sm transition-colors',
                  chosen === option
                    ? 'border-[hsl(var(--accent))] bg-[hsl(var(--accent-soft))]'
                    : 'border-app hover:border-strong',
                  committed && 'cursor-default',
                )}
              >
                <input
                  type="radio"
                  name={`pretest-${block.id}`}
                  value={option}
                  checked={chosen === option}
                  onChange={() => setChosen(option)}
                  className="mt-0.5 h-4 w-4 shrink-0 accent-[hsl(var(--accent))]"
                />
                <span className="text-ink">
                  <InlineText text={option} />
                </span>
              </label>
            </li>
          ))}
        </ul>
      </fieldset>

      {!committed ? (
        <>
          <button
            type="button"
            onClick={() => setCommitted(true)}
            disabled={chosen === null}
            aria-controls={panelId}
            className="mt-3 rounded-lg border border-accent px-3.5 py-2 text-sm font-semibold text-accent transition-colors hover:bg-[hsl(var(--accent-soft))] disabled:cursor-not-allowed disabled:opacity-50 min-h-[2.5rem]"
          >
            Lock in my guess
          </button>
          <p className="mt-1.5 text-xs text-faint">
            Being wrong here is useful, and expected — you have not been taught this yet. Guessing
            first is what makes the explanation stick.
          </p>
        </>
      ) : (
        <Revealed id={panelId} tone="accent" title="What is actually the case">
          <Prose text={answer} />
        </Revealed>
      )}
    </RetrievalFrame>
  );
}

function RecallBlock({ block }: { block: LessonBlockRow }) {
  const points = readArray(block.data, 'points').map(str).filter(Boolean);

  return (
    <WrittenAnswerBlock
      block={block}
      eyebrow="From memory"
      placeholder="Everything you can remember, in any order…"
      revealLabel="Show what a good answer covers"
      revealTitle="Check yours against these"
      prompts={[]}
      reveal={
        <ul className="space-y-1.5 pl-5 list-disc">
          {points.map((point) => (
            <li key={point}>
              <InlineText text={point} />
            </li>
          ))}
        </ul>
      }
    />
  );
}

function SelfExplainBlock({ block }: { block: LessonBlockRow }) {
  const modelAnswer = readString(block.data, 'modelAnswer') ?? '';

  return (
    <WrittenAnswerBlock
      block={block}
      eyebrow="Explain it"
      placeholder="In your own words, as if explaining to someone else…"
      revealLabel="Compare with one way of putting it"
      revealTitle="One way of putting it"
      prompts={[]}
      reveal={
        <>
          <Prose text={modelAnswer} />
          <p className="mt-2 text-xs text-muted">
            Yours does not need to match this. If it covers the same ground in different words, you
            understand it.
          </p>
        </>
      }
    />
  );
}

function ActiveRecapBlock({ block }: { block: LessonBlockRow }) {
  const prompts = readArray(block.data, 'prompts').map(str).filter(Boolean);
  const points = readArray(block.data, 'points').map(str).filter(Boolean);

  return (
    <WrittenAnswerBlock
      block={block}
      eyebrow="Close the book"
      placeholder="Answer from memory — no scrolling back up…"
      revealLabel="Show the answers"
      revealTitle="What the lesson covered"
      prompts={prompts}
      reveal={
        <ul className="space-y-1.5 pl-5 list-disc">
          {points.map((point) => (
            <li key={point}>
              <InlineText text={point} />
            </li>
          ))}
        </ul>
      }
    />
  );
}

function PredictCheckBlock({ block }: { block: LessonBlockRow }) {
  const outcome = readString(block.data, 'outcome') ?? '';
  const [revealed, setRevealed] = useState(false);
  const fieldId = `predict-${block.id}`;
  const panelId = `predict-panel-${block.id}`;

  return (
    <RetrievalFrame block={block} eyebrow="Predict, then check">
      {block.body ? (
        <div className="mt-2 text-sm">
          <Prose text={block.body} />
        </div>
      ) : null}

      <pre className="mt-3 overflow-x-auto rounded-lg border border-app bg-[hsl(var(--bg-subtle))] p-3 text-xs">
        <code>{block.code}</code>
      </pre>

      <label htmlFor={fieldId} className="mt-4 block text-sm font-medium text-ink">
        What will the browser do?
      </label>
      <textarea
        id={fieldId}
        rows={3}
        placeholder="Say what you expect to see before you run it…"
        className="mt-1.5 w-full rounded-lg border border-app bg-app p-3 text-sm text-ink placeholder:text-faint focus:border-accent focus:outline-none focus:ring-2 focus:ring-[hsl(var(--accent)/0.35)]"
      />

      {!revealed ? (
        <button
          type="button"
          onClick={() => setRevealed(true)}
          aria-controls={panelId}
          className="mt-3 rounded-lg border border-accent px-3.5 py-2 text-sm font-semibold text-accent transition-colors hover:bg-[hsl(var(--accent-soft))] min-h-[2.5rem]"
        >
          Run it and see
        </button>
      ) : (
        <Revealed id={panelId} tone="accent" title="What actually happens">
          <Prose text={outcome} />
          {block.code ? (
            <div className="mt-3">
              <InlinePreview code={block.code} label={`Result of ${block.title ?? 'the example'}`} height={180} />
            </div>
          ) : null}
          <p className="mt-2 text-xs text-muted">
            If that surprised you, the gap between what you expected and what happened is the most
            useful thing on this page.
          </p>
        </Revealed>
      )}
    </RetrievalFrame>
  );
}

/**
 * A worked example, revealed a step at a time.
 *
 * Showing every step at once turns it into a finished solution to skim, which
 * is the format a beginner learns least from — the reasoning is what they
 * cannot yet supply, and it is exactly what gets skipped. Revealing stepwise
 * keeps a prediction live at every stage.
 */
function WorkedExampleBlock({ block }: { block: LessonBlockRow }) {
  const steps = readArray(block.data, 'steps').flatMap((entry) => {
    if (typeof entry !== 'object' || entry === null || Array.isArray(entry)) return [];
    const record = entry as Record<string, unknown>;
    return [{ title: str(record.title), code: str(record.code), reasoning: str(record.reasoning) }];
  });

  const [shown, setShown] = useState(1);
  const visible = steps.slice(0, shown);
  const remaining = steps.length - shown;

  if (steps.length === 0) return null;

  return (
    <section
      aria-labelledby={`worked-${block.id}`}
      className="rounded-[var(--radius-card)] border border-app overflow-hidden"
    >
      <div className="border-b border-app bg-[hsl(var(--bg-subtle))] px-4 py-3">
        <p className="text-xs font-bold uppercase tracking-wide text-accent">Worked example</p>
        <h3 id={`worked-${block.id}`} className="mt-1 font-semibold text-ink">
          <InlineText text={block.title ?? ''} />
        </h3>
        {block.body ? (
          <p className="mt-0.5 text-sm text-muted">
            <InlineText text={block.body} />
          </p>
        ) : null}
      </div>

      <ol className="divide-y divide-[hsl(var(--border))]">
        {visible.map((step, index) => (
          <li key={step.title} className="px-4 py-3.5">
            <p className="text-sm font-semibold text-ink">
              <span className="text-muted">Step {index + 1}. </span>
              <InlineText text={step.title} />
            </p>
            {step.code ? (
              <pre className="mt-2 overflow-x-auto rounded-lg border border-app bg-surface p-3 text-xs">
                <code>{step.code}</code>
              </pre>
            ) : null}
            <div className="mt-2 text-sm text-muted">
              <Prose text={step.reasoning} />
            </div>
          </li>
        ))}
      </ol>

      {remaining > 0 ? (
        <div className="border-t border-app bg-[hsl(var(--bg-subtle))] px-4 py-3">
          <p className="text-sm text-muted">
            Before you look: what would you do next?
          </p>
          <button
            type="button"
            onClick={() => setShown((n) => n + 1)}
            className="mt-2 rounded-lg border border-accent px-3.5 py-2 text-sm font-semibold text-accent transition-colors hover:bg-[hsl(var(--accent-soft))] min-h-[2.5rem]"
          >
            Show the next step ({remaining} left)
          </button>
        </div>
      ) : null}
    </section>
  );
}

// --- Dispatcher ------------------------------------------------------------

export function LessonBlock({ block }: { block: LessonBlockRow }) {
  switch (block.block_type) {
    case 'objectives':
      return <ObjectivesBlock block={block} />;
    case 'prose':
      return (
        <div>
          {block.title ? <h3 className="mb-2 font-semibold text-ink">{block.title}</h3> : null}
          {block.body ? <Prose text={block.body} /> : null}
        </div>
      );
    case 'term':
      return <TermBlock block={block} />;
    case 'callout': {
      const tone = readString(block.data, 'tone') ?? 'note';
      return (
        <Callout tone={tone as 'tip' | 'note' | 'warning' | 'mistake' | 'accessibility'} title={block.title ?? undefined}>
          {block.body ? <Prose text={block.body} /> : null}
        </Callout>
      );
    }
    case 'visual':
      return <VisualBlock block={block} />;
    case 'code_example':
      return <CodeBlock block={block} />;
    case 'annotated_code':
      return <AnnotatedCodeBlock block={block} />;
    case 'comparison':
      return <ComparisonBlock block={block} />;
    case 'interactive_demo':
      return <InteractiveDemoBlock block={block} />;
    case 'media_example':
      return <MediaExampleBlock block={block} />;
    case 'progressive_detail':
      return <ProgressiveDetailBlock block={block} />;
    case 'checklist':
      return <ChecklistBlock block={block} />;
    case 'summary':
      return <SummaryBlock block={block} />;
    case 'pretest':
      return <PretestBlock block={block} />;
    case 'recall':
      return <RecallBlock block={block} />;
    case 'predict_check':
      return <PredictCheckBlock block={block} />;
    case 'self_explain':
      return <SelfExplainBlock block={block} />;
    case 'worked_example':
      return <WorkedExampleBlock block={block} />;
    case 'recap':
      return <ActiveRecapBlock block={block} />;
    default:
      return null;
  }
}

export function LessonObjectivesBadge({ count }: { count: number }) {
  return <Badge tone="accent">{count} objectives</Badge>;
}
