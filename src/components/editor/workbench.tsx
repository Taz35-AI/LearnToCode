'use client';

import { useCallback, useEffect, useRef, useState, useTransition } from 'react';
import { CodeEditor } from './code-editor';
import { Preview } from './preview';
import { MediaPicker } from './media-picker';
import { Badge, Button, Callout, ProgressBar } from '@/components/ui';
import {
  AlertIcon,
  CheckCircleIcon,
  CheckIcon,
  CodeIcon,
  EyeIcon,
  ImageIcon,
  LightbulbIcon,
  RefreshIcon,
  SparkIcon,
} from '@/components/ui/icons';
import { cx } from '@/lib/utils';
import type { EvaluationResult } from '@/lib/evaluator/types';
import type { EvaluationOutcome } from '@/lib/actions/progress';
import type { ActionResult } from '@/lib/actions/schemas';
import type { ExerciseKind } from '@/lib/supabase/database.types';

/**
 * The exercise workbench.
 *
 * Side by side on large screens, tabbed on small ones. Work autosaves after a
 * pause in typing, so a learner can close the tab and pick up later on another
 * device — the saved copy lives in Supabase, not in the browser.
 *
 * Hints are revealed one at a time and each one costs a little XP, which keeps
 * them genuinely useful rather than a way to skip the thinking. The reference
 * solution is only sent by the server once the learner has passed.
 */

export interface WorkbenchExercise {
  id: string;
  slug: string;
  kind: ExerciseKind;
  title: string;
  brief: string;
  starterCode: string;
  hints: string[];
  xpAward: number;
  difficulty: number;
  isOptional: boolean;
  requirements: { id: string; message: string }[];
  /** Present only once the learner has already solved it. */
  referenceSolution: string | null;
}

const KIND_LABEL: Record<ExerciseKind, { label: string; tone: 'accent' | 'warning' | 'success' | 'neutral' }> = {
  guided: { label: 'Guided exercise', tone: 'accent' },
  challenge: { label: 'Challenge', tone: 'success' },
  debug: { label: 'Debugging challenge', tone: 'warning' },
  project_mission: { label: 'Project mission', tone: 'accent' },
  bonus: { label: 'Bonus', tone: 'neutral' },
};

type Pane = 'code' | 'preview';

export function Workbench({
  exercise,
  savedCode,
  savedHintsUsed,
  alreadyPassed,
  theme,
  onEvaluate,
  onSave,
}: {
  exercise: WorkbenchExercise;
  savedCode: string | null;
  savedHintsUsed: number;
  alreadyPassed: boolean;
  theme: 'light' | 'dark';
  onEvaluate: (input: {
    exerciseId: string;
    code: string;
    hintsUsed: number;
    durationSeconds: number;
  }) => Promise<ActionResult<EvaluationOutcome>>;
  onSave: (input: { exerciseId: string; code: string; hintsUsed: number }) => Promise<ActionResult>;
}) {
  const [code, setCode] = useState(savedCode ?? exercise.starterCode);
  const [hintsShown, setHintsShown] = useState(savedHintsUsed);
  const [pane, setPane] = useState<Pane>('code');
  const [expanded, setExpanded] = useState(false);
  const [showMedia, setShowMedia] = useState(false);
  const [showSolution, setShowSolution] = useState(false);
  const [result, setResult] = useState<EvaluationResult | null>(null);
  const [outcome, setOutcome] = useState<EvaluationOutcome | null>(null);
  const [saveState, setSaveState] = useState<'idle' | 'saving' | 'saved'>('idle');
  const [isChecking, startChecking] = useTransition();

  // The clock is read in an effect, not during render, so the component stays
  // pure and the timer starts when the workbench is actually on screen.
  const startedAt = useRef<number | null>(null);
  const saveTimer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const resultRef = useRef<HTMLDivElement | null>(null);
  const isDirty = useRef(false);

  const passed = outcome?.result.passed ?? (alreadyPassed && !result ? true : false);
  const reference = outcome?.referenceSolution ?? exercise.referenceSolution;

  useEffect(() => {
    startedAt.current = Date.now();
  }, []);

  // Autosave: a pause in typing, not every keystroke.
  useEffect(() => {
    if (!isDirty.current) return;
    setSaveState('saving');
    if (saveTimer.current) clearTimeout(saveTimer.current);
    saveTimer.current = setTimeout(() => {
      void onSave({ exerciseId: exercise.id, code, hintsUsed: hintsShown }).then(() => {
        setSaveState('saved');
        setTimeout(() => setSaveState('idle'), 1800);
      });
    }, 1200);

    return () => {
      if (saveTimer.current) clearTimeout(saveTimer.current);
    };
  }, [code, hintsShown, exercise.id, onSave]);

  const handleChange = useCallback((next: string) => {
    isDirty.current = true;
    setCode(next);
  }, []);

  const check = () => {
    startChecking(async () => {
      const response = await onEvaluate({
        exerciseId: exercise.id,
        code,
        hintsUsed: hintsShown,
        durationSeconds: startedAt.current
          ? Math.min(86_400, Math.round((Date.now() - startedAt.current) / 1000))
          : 0,
      });
      if (response.ok && response.data) {
        setOutcome(response.data);
        setResult(response.data.result);
        // Move focus to the results so a screen-reader user hears the outcome
        // rather than being left at the button with nothing announced.
        requestAnimationFrame(() => resultRef.current?.focus());
      }
    });
  };

  const reset = () => {
    if (!window.confirm('Reset this exercise back to the starter code? Your current work is discarded.')) {
      return;
    }
    isDirty.current = true;
    setCode(exercise.starterCode);
    setResult(null);
    setOutcome(null);
  };

  const insertMarkup = (markup: string) => {
    isDirty.current = true;
    setCode((current) => (current.trimEnd() ? `${current.trimEnd()}\n\n${markup}\n` : `${markup}\n`));
  };

  const kind = KIND_LABEL[exercise.kind];

  return (
    <section
      aria-labelledby={`exercise-${exercise.slug}`}
      className={cx(
        'rounded-[var(--radius-card)] border border-app bg-surface shadow-card overflow-hidden',
        expanded && 'fixed inset-3 z-50 flex flex-col',
      )}
    >
      {/* ---- Brief ---- */}
      <header className="border-b border-app px-5 py-4">
        <div className="flex flex-wrap items-center gap-2">
          <Badge tone={kind.tone}>{kind.label}</Badge>
          <Badge>Difficulty {exercise.difficulty}/5</Badge>
          <Badge tone="accent">{exercise.xpAward} XP</Badge>
          {exercise.isOptional ? <Badge>Optional</Badge> : null}
          {alreadyPassed ? (
            <Badge tone="success">
              <CheckIcon size={12} /> Passed
            </Badge>
          ) : null}
        </div>

        <h3 id={`exercise-${exercise.slug}`} className="mt-2.5 text-lg font-bold text-ink">
          {exercise.title}
        </h3>
        <p className="mt-1.5 text-sm text-muted lesson-prose">{exercise.brief}</p>

        <details className="mt-3">
          <summary className="cursor-pointer text-sm font-semibold text-accent">
            What is being checked ({exercise.requirements.length})
          </summary>
          <ul className="mt-2 space-y-1 pl-5 text-sm text-muted list-disc">
            {exercise.requirements.map((requirement) => (
              <li key={requirement.id}>{requirement.message}</li>
            ))}
          </ul>
        </details>
      </header>

      {/* ---- Toolbar ---- */}
      <div className="flex flex-wrap items-center gap-2 border-b border-app bg-[hsl(var(--bg-subtle))] px-3 py-2">
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
                pane === option
                  ? 'bg-surface text-ink shadow-card'
                  : 'text-muted hover:text-ink',
              )}
            >
              {option === 'code' ? <CodeIcon size={15} /> : <EyeIcon size={15} />}
              {option === 'code' ? 'Code' : 'Preview'}
            </button>
          ))}
        </div>

        <div className="ml-auto flex flex-wrap items-center gap-2">
          <span aria-live="polite" className="text-xs text-faint min-w-[4.5rem] text-right">
            {saveState === 'saving' ? 'Saving…' : saveState === 'saved' ? 'Saved' : ''}
          </span>

          <Button variant="ghost" size="sm" onClick={() => setShowMedia(true)}>
            <ImageIcon size={15} />
            Media
          </Button>

          {exercise.hints.length > 0 && hintsShown < exercise.hints.length ? (
            <Button variant="ghost" size="sm" onClick={() => setHintsShown((n) => n + 1)}>
              <LightbulbIcon size={15} />
              Hint {hintsShown + 1} of {exercise.hints.length}
            </Button>
          ) : null}

          <Button variant="ghost" size="sm" onClick={reset}>
            <RefreshIcon size={15} />
            Reset
          </Button>

          <Button
            variant="secondary"
            size="sm"
            onClick={() => setExpanded((value) => !value)}
            className="hidden lg:inline-flex"
          >
            {expanded ? 'Exit full screen' : 'Full screen'}
          </Button>

          <Button size="sm" onClick={check} disabled={isChecking}>
            {isChecking ? 'Checking…' : 'Check my work'}
          </Button>
        </div>
      </div>

      {/* ---- Hints ---- */}
      {hintsShown > 0 ? (
        <div className="border-b border-app px-5 py-3">
          <ol className="space-y-2">
            {exercise.hints.slice(0, hintsShown).map((hint, index) => (
              <li key={hint} className="flex gap-2 text-sm">
                <span className="mt-0.5 shrink-0 text-[hsl(var(--warning))]">
                  <LightbulbIcon size={15} />
                </span>
                <span className="text-ink">
                  <strong className="font-semibold">Hint {index + 1}:</strong> {hint}
                </span>
              </li>
            ))}
          </ol>
        </div>
      ) : null}

      {/* ---- Editor and preview ---- */}
      {showMedia ? (
        <div className={cx('bg-surface', expanded ? 'flex-1 min-h-0' : 'h-[32rem]')}>
          <MediaPicker onInsert={insertMarkup} onClose={() => setShowMedia(false)} />
        </div>
      ) : (
        <div
          className={cx(
            'grid lg:grid-cols-2 divide-y lg:divide-y-0 lg:divide-x divide-[hsl(var(--border))]',
            expanded ? 'flex-1 min-h-0' : 'h-[28rem] lg:h-[32rem]',
          )}
        >
          <div className={cx('min-h-0 overflow-hidden', pane === 'preview' && 'hidden lg:block')}>
            <CodeEditor
              value={code}
              onChange={handleChange}
              label={`HTML editor for ${exercise.title}`}
              minHeight="100%"
            />
          </div>

          <div className={cx('flex min-h-0 flex-col', pane === 'code' && 'hidden lg:flex')}>
            <p className="border-b border-app bg-[hsl(var(--bg-subtle))] px-3 py-1.5 text-xs text-faint">
              Live preview · styling supplied by HTML Hero, structure is yours
            </p>
            <Preview
              code={code}
              theme={theme}
              title={`Live preview of your work on ${exercise.title}`}
              className="flex min-h-0 flex-1 flex-col"
            />
          </div>
        </div>
      )}

      {/* ---- Results ---- */}
      <div
        ref={resultRef}
        tabIndex={-1}
        aria-live="polite"
        className="border-t border-app px-5 py-4 focus:outline-none"
      >
        {result ? (
          <ResultPanel result={result} outcome={outcome} />
        ) : (
          <p className="text-sm text-muted">
            Write your answer, then choose <strong className="font-semibold text-ink">Check my work</strong>. The
            checker looks at the structure of your HTML, not the exact words — your own wording is
            welcome.
          </p>
        )}

        {(passed || alreadyPassed) && reference ? (
          <div className="mt-4">
            <Button variant="secondary" size="sm" onClick={() => setShowSolution((v) => !v)}>
              {showSolution ? 'Hide' : 'Compare with'} the reference solution
            </Button>
            {showSolution ? (
              <div className="mt-3">
                <p className="mb-2 text-xs text-muted">
                  One correct answer among many. Yours does not need to match this — compare the
                  structure, not the wording.
                </p>
                <pre className="overflow-x-auto rounded-lg border border-app bg-[hsl(var(--bg-subtle))] p-3 text-xs">
                  <code>{reference}</code>
                </pre>
              </div>
            ) : null}
          </div>
        ) : null}
      </div>
    </section>
  );
}

function ResultPanel({
  result,
  outcome,
}: {
  result: EvaluationResult;
  outcome: EvaluationOutcome | null;
}) {
  const met = result.results.filter((r) => r.passed).length;

  return (
    <div>
      <div
        className={cx(
          'flex items-start gap-3 rounded-lg border p-3.5',
          result.passed
            ? 'border-[hsl(var(--success)/0.35)] bg-[hsl(var(--success-soft))]'
            : 'border-[hsl(var(--warning)/0.4)] bg-[hsl(var(--warning-soft))]',
        )}
      >
        <span
          className={cx(
            'mt-0.5 shrink-0',
            result.passed ? 'text-[hsl(var(--success))]' : 'text-[hsl(var(--warning))]',
          )}
        >
          {result.passed ? <CheckCircleIcon size={20} /> : <AlertIcon size={20} />}
        </span>
        <div className="min-w-0 flex-1">
          <p className="font-semibold text-ink">
            {result.passed ? 'Passed' : 'Not quite yet'}
          </p>
          <p className="mt-0.5 text-sm text-ink">{result.summary}</p>

          {outcome && outcome.xpAwarded > 0 ? (
            <p className="mt-2 inline-flex items-center gap-1.5 text-sm font-semibold text-[hsl(var(--success))]">
              <SparkIcon size={15} />+{outcome.xpAwarded} XP
            </p>
          ) : null}

          {outcome && outcome.achievementsUnlocked.length > 0 ? (
            <p className="mt-1.5 text-sm font-semibold text-accent">
              Achievement unlocked: {outcome.achievementsUnlocked.join(', ')}
            </p>
          ) : null}
        </div>
      </div>

      <div className="mt-4">
        <ProgressBar
          value={met}
          max={result.results.length}
          label="Requirements met"
          tone={result.passed ? 'success' : 'accent'}
          showValue
        />
      </div>

      <ul className="mt-3 space-y-2">
        {result.results.map((requirement) => (
          <li key={requirement.requirementId} className="flex gap-2.5 text-sm">
            <span
              className={cx(
                'mt-0.5 shrink-0',
                requirement.passed ? 'text-[hsl(var(--success))]' : 'text-[hsl(var(--danger))]',
              )}
              aria-hidden="true"
            >
              {requirement.passed ? <CheckIcon size={16} /> : <AlertIcon size={16} />}
            </span>
            <div className="min-w-0">
              <p className={cx('font-medium', requirement.passed ? 'text-muted' : 'text-ink')}>
                <span className="sr-only">{requirement.passed ? 'Met: ' : 'Not met: '}</span>
                {requirement.message}
              </p>
              {!requirement.passed ? (
                <>
                  <p className="mt-0.5 text-muted">{requirement.detail}</p>
                  {requirement.hint ? (
                    <p className="mt-1 text-[hsl(var(--warning))]">{requirement.hint}</p>
                  ) : null}
                </>
              ) : null}
            </div>
          </li>
        ))}
      </ul>

      {result.issues.length > 0 ? (
        <div className="mt-4">
          <Callout tone={result.issues.some((i) => i.severity === 'error') ? 'mistake' : 'note'}>
            <ul className="space-y-1">
              {result.issues.map((issue, index) => (
                <li key={`${issue.code}-${index}`}>
                  {issue.line ? <strong>Line {issue.line}: </strong> : null}
                  {issue.message}
                </li>
              ))}
            </ul>
          </Callout>
        </div>
      ) : null}
    </div>
  );
}
