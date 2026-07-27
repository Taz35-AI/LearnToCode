'use client';

import { useState } from 'react';
import { InlinePreview } from '@/components/editor/preview';
import { Badge, Callout } from '@/components/ui';
import { getMedia } from '@/content/media/manifest';
import { cx } from '@/lib/utils';
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

/**
 * Renders inline markdown-ish emphasis used in lesson prose: `code`, **bold**
 * and *italic*. Deliberately tiny — lesson text is authored in this repository,
 * not by users, and a full markdown parser would be a dependency we do not
 * need. Everything is escaped first, so no authored string can inject markup.
 */
function inlineFormat(text: string): string {
  const escaped = text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');

  return escaped
    .replace(/`([^`]+)`/g, '<code>$1</code>')
    .replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
    .replace(/(^|[^*])\*([^*]+)\*/g, '$1<em>$2</em>');
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
        {block.title ?? 'What you will be able to do'}
      </h2>
      <ul className="mt-3 space-y-2">
        {items.map((item) => (
          <li key={item} className="flex gap-2.5 text-ink">
            <span className="mt-1 shrink-0 text-accent" aria-hidden="true">
              <CheckIcon size={15} />
            </span>
            <span>{item}</span>
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
        <figcaption className="mt-2 text-sm text-muted">{block.body}</figcaption>
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
          {block.title ?? 'Example'}
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
        {block.title ?? 'Line by line'}
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
      {block.title ? <h3 className="mb-3 font-semibold text-ink">{block.title}</h3> : null}
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
              {str(data.why)}
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
        <h3 className="font-semibold text-ink">{block.title ?? 'Try it'}</h3>
        {block.body ? <p className="mt-0.5 text-sm text-muted">{block.body}</p> : null}
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
        {current.note}
      </p>
    </section>
  );
}

function MediaExampleBlock({ block }: { block: LessonBlockRow }) {
  const asset = block.media_slug ? getMedia(block.media_slug) : undefined;

  return (
    <section className="rounded-[var(--radius-card)] border border-app overflow-hidden">
      <div className="border-b border-app bg-[hsl(var(--bg-subtle))] px-4 py-3">
        <h3 className="font-semibold text-ink">{block.title}</h3>
        {block.body ? <p className="mt-0.5 text-sm text-muted">{block.body}</p> : null}
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
        {block.title ?? 'More detail'}
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
      <h3 className="font-semibold text-ink">{block.title ?? 'Checklist'}</h3>
      <ul className="mt-3 space-y-2">
        {items.map((item) => (
          <li key={item} className="flex gap-2.5 text-sm">
            <span className="mt-0.5 shrink-0 text-[hsl(var(--success))]" aria-hidden="true">
              <CheckIcon size={15} />
            </span>
            <span className="text-ink">{item}</span>
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
        {block.title ?? 'Lesson summary'}
      </h2>
      <ul className="mt-3 space-y-1.5 pl-5 list-disc text-ink">
        {points.map((point) => (
          <li key={point}>{point}</li>
        ))}
      </ul>
      {nextUp ? (
        <p className="mt-4 border-t border-app pt-3 text-sm text-muted">{nextUp}</p>
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
    default:
      return null;
  }
}

export function LessonObjectivesBadge({ count }: { count: number }) {
  return <Badge tone="accent">{count} objectives</Badge>;
}
