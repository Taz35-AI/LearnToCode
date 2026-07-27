'use client';

import { useState, useTransition } from 'react';
import { CodeEditor } from '@/components/editor/code-editor';
import { Preview } from '@/components/editor/preview';
import { MediaPicker } from '@/components/editor/media-picker';
import { Badge, Button, Card, ProgressBar } from '@/components/ui';
import { CodeIcon, EyeIcon, ImageIcon, CheckCircleIcon, AlertIcon } from '@/components/ui/icons';
import { cx } from '@/lib/utils';
import { exportProject } from '@/lib/project/export';
import type { ActionResult } from '@/lib/actions/schemas';

/**
 * The capstone workspace.
 *
 * The learner's own website, page by page. Export bundles every file into a
 * folder they can open, upload, or drop onto a static host — because the whole
 * point of learning HTML is producing files that work anywhere with no build
 * step, which is the last thing Level 12 teaches.
 */

export interface ProjectFile {
  id: string;
  path: string;
  content: string;
  kind: string;
}

export interface ChecklistItem {
  label: string;
  met: boolean;
  detail: string;
}

export function ProjectWorkspace({
  projectName,
  files,
  completionPercent,
  checklist,
  theme,
  onSave,
}: {
  projectName: string;
  files: ProjectFile[];
  completionPercent: number;
  checklist: ChecklistItem[];
  theme: 'light' | 'dark';
  onSave: (input: { path: string; content: string }) => Promise<ActionResult>;
}) {
  const [activePath, setActivePath] = useState(files[0]?.path ?? 'index.html');
  const [contents, setContents] = useState<Record<string, string>>(() =>
    Object.fromEntries(files.map((file) => [file.path, file.content])),
  );
  const [pane, setPane] = useState<'code' | 'preview'>('code');
  const [showMedia, setShowMedia] = useState(false);
  const [status, setStatus] = useState<string | null>(null);
  const [isSaving, startSaving] = useTransition();

  const activeContent = contents[activePath] ?? '';

  const save = () => {
    startSaving(async () => {
      const response = await onSave({ path: activePath, content: activeContent });
      setStatus(response.ok ? `Saved ${activePath}` : (response.message ?? 'Could not save'));
      setTimeout(() => setStatus(null), 3000);
    });
  };

  const download = () => {
    exportProject(
      projectName,
      files.map((file) => ({ path: file.path, content: contents[file.path] ?? file.content })),
    );
  };

  const met = checklist.filter((item) => item.met).length;

  return (
    <div className="p-5 lg:p-10">
      <header className="mb-6 flex flex-wrap items-end justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-ink lg:text-3xl">{projectName}</h1>
          <p className="mt-1 text-muted">
            {files.length} {files.length === 1 ? 'page' : 'pages'} · built piece by piece since
            Level 1
          </p>
        </div>
        <div className="flex flex-wrap gap-2">
          <Button variant="secondary" onClick={download}>
            Export as files
          </Button>
          <Button onClick={save} disabled={isSaving}>
            {isSaving ? 'Saving…' : 'Save page'}
          </Button>
        </div>
      </header>

      <p aria-live="polite" className="mb-4 min-h-[1.25rem] text-sm text-[hsl(var(--success))]">
        {status}
      </p>

      <div className="grid gap-5 lg:grid-cols-[1fr_18rem]">
        <Card className="overflow-hidden">
          {/* File tabs */}
          <div
            role="tablist"
            aria-label="Project pages"
            className="flex gap-1 overflow-x-auto border-b border-app bg-[hsl(var(--bg-subtle))] px-2 py-2"
          >
            {files.map((file) => (
              <button
                key={file.path}
                type="button"
                role="tab"
                aria-selected={activePath === file.path}
                onClick={() => setActivePath(file.path)}
                className={cx(
                  'whitespace-nowrap rounded-lg px-3 py-1.5 font-mono text-xs font-medium min-h-[2.25rem]',
                  activePath === file.path
                    ? 'bg-surface text-ink shadow-card'
                    : 'text-muted hover:text-ink',
                )}
              >
                {file.path}
              </button>
            ))}
          </div>

          {/* Toolbar */}
          <div className="flex flex-wrap items-center gap-2 border-b border-app px-3 py-2">
            <div role="tablist" aria-label="Editor view" className="flex gap-1 lg:hidden">
              {(['code', 'preview'] as const).map((option) => (
                <button
                  key={option}
                  type="button"
                  role="tab"
                  aria-selected={pane === option}
                  onClick={() => setPane(option)}
                  className={cx(
                    'inline-flex items-center gap-1.5 rounded-lg px-3 py-1.5 text-sm font-medium min-h-[2.25rem]',
                    pane === option ? 'bg-[hsl(var(--bg-subtle))] text-ink' : 'text-muted',
                  )}
                >
                  {option === 'code' ? <CodeIcon size={15} /> : <EyeIcon size={15} />}
                  {option === 'code' ? 'Code' : 'Preview'}
                </button>
              ))}
            </div>
            <Button
              variant="ghost"
              size="sm"
              className="ml-auto"
              onClick={() => setShowMedia((v) => !v)}
            >
              <ImageIcon size={15} />
              {showMedia ? 'Close media' : 'Media library'}
            </Button>
          </div>

          {showMedia ? (
            <div className="h-[30rem]">
              <MediaPicker
                onInsert={(markup) =>
                  setContents((current) => ({
                    ...current,
                    [activePath]: `${(current[activePath] ?? '').trimEnd()}\n${markup}\n`,
                  }))
                }
                onClose={() => setShowMedia(false)}
              />
            </div>
          ) : (
            <div className="grid h-[30rem] lg:h-[36rem] lg:grid-cols-2 divide-y lg:divide-y-0 lg:divide-x divide-[hsl(var(--border))]">
              <div className={cx('min-h-0 overflow-hidden', pane === 'preview' && 'hidden lg:block')}>
                <CodeEditor
                  value={activeContent}
                  onChange={(next) =>
                    setContents((current) => ({ ...current, [activePath]: next }))
                  }
                  label={`HTML editor for ${activePath}`}
                  minHeight="100%"
                />
              </div>
              <div className={cx('flex min-h-0 flex-col', pane === 'code' && 'hidden lg:flex')}>
                <p className="border-b border-app bg-[hsl(var(--bg-subtle))] px-3 py-1.5 text-xs text-faint">
                  Preview of {activePath}
                </p>
                <Preview
                  code={activeContent}
                  theme={theme}
                  title={`Preview of ${activePath}`}
                  className="flex min-h-0 flex-1 flex-col"
                />
              </div>
            </div>
          )}
        </Card>

        {/* Capstone checklist */}
        <aside className="space-y-5">
          <Card>
            <div className="p-5">
              <h2 className="font-semibold text-ink">Project completion</h2>
              <div className="mt-3">
                <ProgressBar value={completionPercent} label="Project completion" showValue />
              </div>
            </div>
          </Card>

          <Card>
            <div className="p-5">
              <div className="flex items-baseline justify-between gap-2">
                <h2 className="font-semibold text-ink">Capstone checklist</h2>
                <Badge tone={met === checklist.length ? 'success' : 'neutral'}>
                  {met}/{checklist.length}
                </Badge>
              </div>
              <p className="mt-1 text-xs text-muted">
                Checked across every page of your project, live.
              </p>

              <ul className="mt-4 space-y-2">
                {checklist.map((item) => (
                  <li key={item.label} className="flex gap-2.5 text-sm">
                    <span
                      className={cx(
                        'mt-0.5 shrink-0',
                        item.met ? 'text-[hsl(var(--success))]' : 'text-faint',
                      )}
                      aria-hidden="true"
                    >
                      {item.met ? <CheckCircleIcon size={16} /> : <AlertIcon size={16} />}
                    </span>
                    <span>
                      <span className={cx('block', item.met ? 'text-muted' : 'text-ink')}>
                        {item.label}
                      </span>
                      {!item.met ? (
                        <span className="block text-xs text-faint">{item.detail}</span>
                      ) : null}
                    </span>
                  </li>
                ))}
              </ul>
            </div>
          </Card>
        </aside>
      </div>
    </div>
  );
}
