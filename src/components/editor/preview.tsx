'use client';

import { useMemo } from 'react';
import { buildPreviewDocument } from '@/lib/preview/sanitise';
import { AlertIcon } from '@/components/ui/icons';

/**
 * The live preview.
 *
 * Learner markup renders inside an iframe with `sandbox=""` — no
 * `allow-scripts`, no `allow-same-origin`, no `allow-forms`, no
 * `allow-top-navigation`. With scripts disabled at the browser level, learner
 * code cannot execute in any origin, which is the guarantee this component
 * rests on. `buildPreviewDocument` additionally strips executable content and
 * injects a restrictive CSP before the markup ever reaches the frame.
 *
 * The platform's presentation stylesheet is injected too, and is labelled as
 * such in the interface, so a learner is never confused about which part of
 * what they see is their own HTML and which is supplied by the platform.
 */
export function Preview({
  code,
  theme = 'light',
  withStarterStyles = true,
  title = 'Preview of your page',
  className,
}: {
  code: string;
  theme?: 'light' | 'dark';
  withStarterStyles?: boolean;
  title?: string;
  className?: string;
}) {
  const { html, notices } = useMemo(
    () => buildPreviewDocument(code, { theme, withStarterStyles }),
    [code, theme, withStarterStyles],
  );

  return (
    <div className={className ?? 'flex h-full flex-col'}>
      <iframe
        // `sandbox` with an empty value removes every capability, including
        // script execution. This is the security boundary.
        sandbox=""
        srcDoc={html}
        title={title}
        className="w-full flex-1 min-h-0 border-0 bg-white"
        referrerPolicy="no-referrer"
        loading="lazy"
      />

      {notices.length > 0 ? (
        <div
          role="status"
          className="border-t border-app bg-[hsl(var(--warning-soft))] px-3 py-2 text-xs text-[hsl(var(--warning))]"
        >
          <p className="flex items-start gap-1.5 font-semibold">
            <AlertIcon size={14} className="mt-px shrink-0" />
            Changed for the preview
          </p>
          <ul className="mt-1 space-y-0.5 pl-5 list-disc">
            {notices.map((notice) => (
              <li key={notice}>{notice}</li>
            ))}
          </ul>
        </div>
      ) : null}
    </div>
  );
}

/** A small read-only preview used inside lesson content blocks. */
export function InlinePreview({
  code,
  theme = 'light',
  label,
  height = 220,
}: {
  code: string;
  theme?: 'light' | 'dark';
  label: string;
  height?: number;
}) {
  const { html } = useMemo(
    () => buildPreviewDocument(code, { theme, withStarterStyles: true }),
    [code, theme],
  );

  return (
    <iframe
      sandbox=""
      srcDoc={html}
      title={label}
      style={{ height }}
      className="w-full rounded-lg border border-app bg-white"
      referrerPolicy="no-referrer"
      loading="lazy"
    />
  );
}
