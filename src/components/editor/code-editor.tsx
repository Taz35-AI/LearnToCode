'use client';

import dynamic from 'next/dynamic';
import { html as htmlLang } from '@codemirror/lang-html';
import { EditorView } from '@codemirror/view';
import { Skeleton } from '@/components/ui';

/**
 * The HTML editor.
 *
 * CodeMirror is loaded client-side only: it touches the DOM at construction,
 * and there is no benefit to rendering it on the server. Until it arrives the
 * learner sees a skeleton of the right size rather than a layout jump.
 *
 * A plain `<textarea>` fallback is rendered when JavaScript has not loaded, so
 * the exercise is still readable and editable — the progressive-enhancement
 * principle the course itself teaches in Level 7.
 */

const CodeMirror = dynamic(() => import('@uiw/react-codemirror').then((m) => m.default), {
  ssr: false,
  loading: () => <Skeleton className="h-full w-full min-h-[18rem]" />,
});

/** Theme extension mapping CodeMirror onto our design tokens. */
const editorTheme = EditorView.theme({
  '&': {
    backgroundColor: 'hsl(var(--surface))',
    color: 'hsl(var(--ink))',
    height: '100%',
  },
  '.cm-content': { caretColor: 'hsl(var(--accent))', padding: '12px 0' },
  '.cm-gutters': {
    backgroundColor: 'hsl(var(--bg-subtle))',
    color: 'hsl(var(--ink-faint))',
    border: 'none',
    borderRight: '1px solid hsl(var(--border))',
  },
  '.cm-activeLine': { backgroundColor: 'hsl(var(--accent) / 0.06)' },
  '.cm-activeLineGutter': { backgroundColor: 'hsl(var(--accent) / 0.08)' },
  '.cm-selectionBackground, &.cm-focused .cm-selectionBackground': {
    backgroundColor: 'hsl(var(--accent) / 0.22)',
  },
  '.cm-cursor': { borderLeftColor: 'hsl(var(--accent))', borderLeftWidth: '2px' },
  '.cm-line': { padding: '0 12px' },
  '.cm-matchingBracket': {
    backgroundColor: 'hsl(var(--accent) / 0.18)',
    outline: '1px solid hsl(var(--accent) / 0.4)',
  },
});

export function CodeEditor({
  value,
  onChange,
  label,
  readOnly = false,
  minHeight = '20rem',
}: {
  value: string;
  onChange: (next: string) => void;
  label: string;
  readOnly?: boolean;
  minHeight?: string;
}) {
  return (
    <div style={{ minHeight }} className="h-full" aria-label={label} role="group">
      {/*
        Without JavaScript the editor bundle never arrives, so the exercise
        would be unreadable. A plain textarea carrying the starter code keeps
        the content available and copyable — progressive enhancement applied to
        the platform itself, which is the principle Level 7 teaches.
      */}
      <noscript>
        <label htmlFor="noscript-editor" className="sr-only">
          {label}
        </label>
        <textarea
          id="noscript-editor"
          defaultValue={value}
          readOnly
          spellCheck={false}
          className="h-full w-full resize-none bg-surface p-3 font-mono text-sm text-ink"
          style={{ minHeight }}
        />
      </noscript>

      <CodeMirror
        value={value}
        onChange={onChange}
        readOnly={readOnly}
        // Closing tags are deliberately NOT auto-inserted. Writing `</p>`
        // yourself is one of the first things this course teaches, and Level 1
        // includes a debugging challenge about a missing slash — an editor that
        // silently writes the closing tag for you would remove the very skill
        // being practised, and would fight anyone who types it themselves.
        extensions={[htmlLang({ autoCloseTags: false }), editorTheme, EditorView.lineWrapping]}
        basicSetup={{
          lineNumbers: true,
          highlightActiveLine: true,
          bracketMatching: true,
          closeBrackets: true,
          autocompletion: true,
          foldGutter: false,
          highlightSelectionMatches: false,
          // Tab must indent, not move focus — but Escape then Tab still lets a
          // keyboard user leave the editor, which is the accessible pattern.
          tabSize: 2,
        }}
        height="100%"
        style={{ height: '100%', minHeight }}
      />
    </div>
  );
}
