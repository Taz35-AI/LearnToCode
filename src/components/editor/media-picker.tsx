'use client';

import { useMemo, useState } from 'react';
import { MEDIA_ASSETS, MEDIA_GROUPS, type MediaAsset } from '@/content/media/manifest';
import { Badge, Button } from '@/components/ui';
import { ImageIcon } from '@/components/ui/icons';
import { cx } from '@/lib/utils';

/**
 * The media library browser.
 *
 * Every asset here exists locally and is released under CC0, so a learner can
 * insert one and be certain it will resolve and that the licence is clear.
 * The picker inserts complete, correct markup — a full `srcset` for a
 * photograph, a `<video>` with poster, sources and captions — so learners see
 * the professional pattern before they are asked to write it themselves.
 */

function suggestedMarkup(asset: MediaAsset): string {
  if (asset.kind === 'video') {
    const sources = asset.formats
      .map((f) => `    <source src="${f.path}" type="${f.type}">`)
      .join('\n');
    return `<video controls preload="metadata"
       poster="${asset.posterPath ?? ''}"
       width="${asset.width ?? 1280}" height="${asset.height ?? 720}">
${sources}
    <track kind="captions" src="${asset.captionsPath ?? ''}" srclang="en" label="English" default>
    <p>Your browser cannot play this video. <a href="${asset.path}">Download it instead</a>.</p>
</video>`;
  }

  if (asset.kind === 'audio') {
    const sources = asset.formats
      .map((f) => `    <source src="${f.path}" type="${f.type}">`)
      .join('\n');
    return `<audio controls preload="none">
${sources}
    <p>Your browser cannot play audio. <a href="${asset.path}">Download the file</a>.</p>
</audio>`;
  }

  if (asset.srcset.length > 0) {
    const srcset = asset.srcset.map((s) => `${s.path} ${s.width}w`).join(',\n          ');
    return `<img
  src="${asset.path}"
  srcset="${srcset}"
  sizes="(min-width: 60rem) 50vw, 100vw"
  alt="${asset.suggestedAlt}"
  width="${asset.width ?? 1200}" height="${asset.height ?? 800}">`;
  }

  const alt = asset.isDecorativeExample ? '' : asset.suggestedAlt;
  return `<img src="${asset.path}" alt="${alt}"${
    asset.width ? ` width="${asset.width}" height="${asset.height}"` : ''
  }>`;
}

export function MediaPicker({
  onInsert,
  onClose,
}: {
  onInsert: (markup: string) => void;
  onClose: () => void;
}) {
  const [group, setGroup] = useState(MEDIA_GROUPS[0]?.id ?? 'photos');
  const [selected, setSelected] = useState<string | null>(null);
  const [query, setQuery] = useState('');

  const visible = useMemo(() => {
    const groupSlugs = new Set(MEDIA_GROUPS.find((g) => g.id === group)?.slugs ?? []);
    const term = query.trim().toLowerCase();
    return MEDIA_ASSETS.filter((asset) => {
      if (!groupSlugs.has(asset.slug)) return false;
      if (!term) return true;
      return (
        asset.title.toLowerCase().includes(term) ||
        asset.tags.some((tag) => tag.includes(term)) ||
        asset.description.toLowerCase().includes(term)
      );
    });
  }, [group, query]);

  const active = selected ? MEDIA_ASSETS.find((a) => a.slug === selected) : null;

  return (
    <div className="flex h-full flex-col">
      <div className="flex flex-wrap items-center gap-2 border-b border-app px-4 py-3">
        <h2 className="mr-auto flex items-center gap-2 text-sm font-semibold text-ink">
          <ImageIcon size={16} />
          Media library
        </h2>
        <label htmlFor="media-search" className="sr-only">
          Search the media library
        </label>
        <input
          id="media-search"
          type="search"
          value={query}
          onChange={(event) => setQuery(event.target.value)}
          placeholder="Search…"
          className="rounded-lg border border-app bg-surface px-3 py-1.5 text-sm min-h-[2.25rem] w-40"
        />
        <Button variant="ghost" size="sm" onClick={onClose}>
          Close
        </Button>
      </div>

      <div
        role="tablist"
        aria-label="Media categories"
        className="flex gap-1 overflow-x-auto border-b border-app px-3 py-2"
      >
        {MEDIA_GROUPS.map((entry) => (
          <button
            key={entry.id}
            type="button"
            role="tab"
            aria-selected={group === entry.id}
            onClick={() => {
              setGroup(entry.id);
              setSelected(null);
            }}
            className={cx(
              'whitespace-nowrap rounded-lg px-3 py-1.5 text-sm font-medium transition-colors',
              group === entry.id
                ? 'bg-[hsl(var(--accent-soft))] text-[hsl(var(--accent))]'
                : 'text-muted hover:text-ink hover:bg-[hsl(var(--bg-subtle))]',
            )}
          >
            {entry.label}
          </button>
        ))}
      </div>

      <div className="grid flex-1 min-h-0 gap-0 md:grid-cols-[1fr_20rem]">
        <ul className="grid grid-cols-2 content-start gap-3 overflow-y-auto p-4 sm:grid-cols-3">
          {visible.map((asset) => (
            <li key={asset.slug}>
              <button
                type="button"
                onClick={() => setSelected(asset.slug)}
                aria-pressed={selected === asset.slug}
                className={cx(
                  'w-full overflow-hidden rounded-lg border-2 bg-surface text-left transition-colors',
                  selected === asset.slug
                    ? 'border-[hsl(var(--accent))]'
                    : 'border-app hover:border-strong',
                )}
              >
                <div className="aspect-[4/3] bg-[hsl(var(--bg-subtle))] grid place-items-center overflow-hidden">
                  {asset.kind === 'video' ? (
                    /* eslint-disable-next-line @next/next/no-img-element */
                    <img
                      src={asset.posterPath ?? asset.path}
                      alt=""
                      className="h-full w-full object-cover"
                      loading="lazy"
                    />
                  ) : asset.kind === 'audio' ? (
                    <span className="text-xs font-semibold text-muted px-2 text-center">
                      Audio · {asset.durationSeconds}s
                    </span>
                  ) : (
                    /* eslint-disable-next-line @next/next/no-img-element */
                    <img
                      src={asset.path}
                      alt=""
                      className={cx(
                        'h-full w-full',
                        asset.kind === 'icon' ? 'object-contain p-6' : 'object-cover',
                      )}
                      loading="lazy"
                    />
                  )}
                </div>
                <p className="px-2 py-1.5 text-xs font-medium text-ink line-clamp-2">
                  {asset.title}
                </p>
              </button>
            </li>
          ))}
          {visible.length === 0 ? (
            <li className="col-span-full py-8 text-center text-sm text-muted">
              Nothing matches “{query}”.
            </li>
          ) : null}
        </ul>

        <aside className="overflow-y-auto border-t border-app bg-[hsl(var(--bg-subtle))] p-4 md:border-l md:border-t-0">
          {active ? (
            <>
              <h3 className="text-sm font-semibold text-ink">{active.title}</h3>
              <p className="mt-1 text-xs text-muted">{active.description}</p>

              <dl className="mt-4 space-y-2.5 text-xs">
                <div>
                  <dt className="font-semibold text-ink">Suggested alt text</dt>
                  <dd className="mt-0.5 text-muted">
                    {active.suggestedAlt || (
                      <span className="italic">
                        Empty — this is the course&rsquo;s example of a decorative image, so{' '}
                        <code>alt=&quot;&quot;</code> is correct.
                      </span>
                    )}
                  </dd>
                </div>
                <div>
                  <dt className="font-semibold text-ink">Path</dt>
                  <dd className="mt-0.5 font-mono break-all text-muted">{active.path}</dd>
                </div>
                {active.srcset.length > 0 ? (
                  <div>
                    <dt className="font-semibold text-ink">Available widths</dt>
                    <dd className="mt-0.5 text-muted">
                      {active.srcset.map((s) => `${s.width}px`).join(', ')}
                    </dd>
                  </div>
                ) : null}
                <div>
                  <dt className="font-semibold text-ink">Licence</dt>
                  <dd className="mt-0.5 text-muted">{active.attribution.licence}</dd>
                </div>
                <div>
                  <dt className="font-semibold text-ink">Creator</dt>
                  <dd className="mt-0.5 text-muted">{active.attribution.creator}</dd>
                </div>
              </dl>

              <div className="mt-4 flex flex-wrap gap-1.5">
                {active.tags.slice(0, 5).map((tag) => (
                  <Badge key={tag}>{tag}</Badge>
                ))}
              </div>

              <Button
                className="mt-5 w-full"
                onClick={() => {
                  onInsert(suggestedMarkup(active));
                  onClose();
                }}
              >
                Insert markup
              </Button>
              <p className="mt-2 text-xs text-faint">
                Inserts complete, correct markup with dimensions and alt text — edit it to fit your
                page.
              </p>
            </>
          ) : (
            <p className="py-8 text-center text-sm text-muted">
              Choose an asset to see its path, licence and suggested alt text.
            </p>
          )}
        </aside>
      </div>
    </div>
  );
}
