import type { ComponentPropsWithoutRef, ElementType, ReactNode } from 'react';
import Link from 'next/link';
import { cx } from '@/lib/utils';

/**
 * The shared component vocabulary.
 *
 * Small, unopinionated primitives built on the design tokens in globals.css.
 * Every interactive element inherits the single focus ring defined there, so
 * keyboard visibility is consistent without each component restating it.
 */

// --- Button ----------------------------------------------------------------

type ButtonVariant = 'primary' | 'secondary' | 'ghost' | 'danger';
type ButtonSize = 'sm' | 'md' | 'lg';

const BUTTON_BASE =
  'inline-flex items-center justify-center gap-2 rounded-lg font-semibold ' +
  'transition-colors duration-150 disabled:opacity-55 disabled:cursor-not-allowed ' +
  'whitespace-nowrap select-none';

const BUTTON_VARIANTS: Record<ButtonVariant, string> = {
  primary:
    'bg-[hsl(var(--accent))] text-[hsl(var(--accent-ink))] hover:bg-[hsl(var(--accent)/0.88)] shadow-card',
  secondary:
    'bg-surface text-ink border border-app hover:bg-[hsl(var(--bg-subtle))]',
  ghost: 'text-muted hover:text-ink hover:bg-[hsl(var(--bg-subtle))]',
  danger:
    'bg-[hsl(var(--danger))] text-white hover:bg-[hsl(var(--danger)/0.88)]',
};

const BUTTON_SIZES: Record<ButtonSize, string> = {
  sm: 'text-sm px-3 py-1.5 min-h-[2.25rem]',
  md: 'text-sm px-4 py-2.5 min-h-[2.75rem]',
  lg: 'text-base px-6 py-3 min-h-[3rem]',
};

export function buttonClasses(
  variant: ButtonVariant = 'primary',
  size: ButtonSize = 'md',
  className?: string,
): string {
  return cx(BUTTON_BASE, BUTTON_VARIANTS[variant], BUTTON_SIZES[size], className);
}

export function Button({
  variant = 'primary',
  size = 'md',
  className,
  ...props
}: ComponentPropsWithoutRef<'button'> & { variant?: ButtonVariant; size?: ButtonSize }) {
  return <button className={buttonClasses(variant, size, className)} {...props} />;
}

export function ButtonLink({
  variant = 'primary',
  size = 'md',
  className,
  ...props
}: ComponentPropsWithoutRef<typeof Link> & { variant?: ButtonVariant; size?: ButtonSize }) {
  return <Link className={buttonClasses(variant, size, className)} {...props} />;
}

// --- Card ------------------------------------------------------------------

export function Card({
  as: Tag = 'div',
  className,
  children,
  ...props
}: { as?: ElementType; className?: string; children: ReactNode } & Record<string, unknown>) {
  return (
    <Tag
      className={cx(
        'bg-surface border border-app rounded-[var(--radius-card)] shadow-card',
        className,
      )}
      {...props}
    >
      {children}
    </Tag>
  );
}

export function CardHeader({
  title,
  description,
  action,
  level: Heading = 'h2',
}: {
  title: ReactNode;
  description?: ReactNode;
  action?: ReactNode;
  level?: 'h2' | 'h3' | 'h4';
}) {
  return (
    <div className="flex items-start justify-between gap-4 px-5 pt-5 pb-3">
      <div className="min-w-0">
        <Heading className="text-base font-semibold text-ink">{title}</Heading>
        {description ? <p className="text-sm text-muted mt-0.5">{description}</p> : null}
      </div>
      {action ? <div className="shrink-0">{action}</div> : null}
    </div>
  );
}

// --- Badge -----------------------------------------------------------------

type BadgeTone = 'neutral' | 'accent' | 'success' | 'warning' | 'danger';

const BADGE_TONES: Record<BadgeTone, string> = {
  neutral: 'bg-[hsl(var(--bg-subtle))] text-muted border-app',
  accent: 'bg-[hsl(var(--accent-soft))] text-[hsl(var(--accent))] border-[hsl(var(--accent-border))]',
  success: 'bg-[hsl(var(--success-soft))] text-[hsl(var(--success))] border-[hsl(var(--success)/0.3)]',
  warning: 'bg-[hsl(var(--warning-soft))] text-[hsl(var(--warning))] border-[hsl(var(--warning)/0.3)]',
  danger: 'bg-[hsl(var(--danger-soft))] text-[hsl(var(--danger))] border-[hsl(var(--danger)/0.3)]',
};

export function Badge({
  tone = 'neutral',
  className,
  children,
}: {
  tone?: BadgeTone;
  className?: string;
  children: ReactNode;
}) {
  return (
    <span
      className={cx(
        'inline-flex items-center gap-1 rounded-full border px-2.5 py-0.5 text-xs font-semibold',
        BADGE_TONES[tone],
        className,
      )}
    >
      {children}
    </span>
  );
}

// --- Progress bar ----------------------------------------------------------

export function ProgressBar({
  value,
  max = 100,
  label,
  tone = 'accent',
  showValue = false,
  size = 'md',
}: {
  value: number;
  max?: number;
  label: string;
  tone?: 'accent' | 'success' | 'warning';
  showValue?: boolean;
  size?: 'sm' | 'md';
}) {
  const percentage = max > 0 ? Math.min(100, Math.max(0, (value / max) * 100)) : 0;
  const colour =
    tone === 'success'
      ? 'bg-[hsl(var(--success))]'
      : tone === 'warning'
        ? 'bg-[hsl(var(--warning))]'
        : 'bg-[hsl(var(--accent))]';

  return (
    <div>
      {showValue ? (
        <div className="flex justify-between items-baseline mb-1.5">
          <span className="text-xs font-medium text-muted">{label}</span>
          <span className="text-xs font-semibold text-ink tabular-nums">{Math.round(percentage)}%</span>
        </div>
      ) : null}
      <div
        role="progressbar"
        aria-valuenow={Math.round(value)}
        aria-valuemin={0}
        aria-valuemax={Math.round(max)}
        aria-label={label}
        className={cx(
          'w-full overflow-hidden rounded-full bg-[hsl(var(--bg-subtle))] border border-app',
          size === 'sm' ? 'h-1.5' : 'h-2.5',
        )}
      >
        <div
          className={cx('h-full rounded-full transition-[width] duration-500', colour)}
          style={{ width: `${percentage}%` }}
        />
      </div>
    </div>
  );
}

// --- Stat ------------------------------------------------------------------

export function Stat({
  label,
  value,
  hint,
  icon,
}: {
  label: string;
  value: ReactNode;
  hint?: ReactNode;
  icon?: ReactNode;
}) {
  return (
    <div className="bg-surface border border-app rounded-[var(--radius-card)] p-4 shadow-card">
      <div className="flex items-center gap-2 text-muted">
        {icon}
        <span className="text-xs font-semibold uppercase tracking-wide">{label}</span>
      </div>
      <p className="mt-1.5 text-2xl font-bold text-ink tabular-nums leading-tight">{value}</p>
      {hint ? <p className="mt-0.5 text-xs text-faint">{hint}</p> : null}
    </div>
  );
}

// --- States ----------------------------------------------------------------

export function EmptyState({
  title,
  description,
  action,
  icon,
}: {
  title: string;
  description: string;
  action?: ReactNode;
  icon?: ReactNode;
}) {
  return (
    <div className="text-center py-12 px-6">
      {icon ? <div className="mx-auto mb-3 text-faint">{icon}</div> : null}
      <h3 className="text-base font-semibold text-ink">{title}</h3>
      <p className="mt-1.5 text-sm text-muted max-w-sm mx-auto">{description}</p>
      {action ? <div className="mt-5">{action}</div> : null}
    </div>
  );
}

export function ErrorState({ title, description, action }: { title: string; description: string; action?: ReactNode }) {
  return (
    <div
      role="alert"
      className="rounded-[var(--radius-card)] border border-[hsl(var(--danger)/0.35)] bg-[hsl(var(--danger-soft))] p-5"
    >
      <h3 className="text-sm font-semibold text-[hsl(var(--danger))]">{title}</h3>
      <p className="mt-1 text-sm text-ink">{description}</p>
      {action ? <div className="mt-4">{action}</div> : null}
    </div>
  );
}

export function Skeleton({ className }: { className?: string }) {
  return (
    <div
      aria-hidden="true"
      className={cx('animate-pulse rounded-md bg-[hsl(var(--bg-subtle))]', className)}
    />
  );
}

// --- Callout ---------------------------------------------------------------

const CALLOUT_STYLES: Record<string, { border: string; bg: string; label: string; tone: string }> = {
  tip: {
    border: 'border-[hsl(var(--accent-border))]',
    bg: 'bg-[hsl(var(--accent-soft))]',
    label: 'Tip',
    tone: 'text-[hsl(var(--accent))]',
  },
  note: {
    border: 'border-app',
    bg: 'bg-[hsl(var(--bg-subtle))]',
    label: 'Note',
    tone: 'text-muted',
  },
  warning: {
    border: 'border-[hsl(var(--warning)/0.4)]',
    bg: 'bg-[hsl(var(--warning-soft))]',
    label: 'Careful',
    tone: 'text-[hsl(var(--warning))]',
  },
  mistake: {
    border: 'border-[hsl(var(--danger)/0.35)]',
    bg: 'bg-[hsl(var(--danger-soft))]',
    label: 'Common mistake',
    tone: 'text-[hsl(var(--danger))]',
  },
  accessibility: {
    border: 'border-[hsl(var(--success)/0.35)]',
    bg: 'bg-[hsl(var(--success-soft))]',
    label: 'Accessibility',
    tone: 'text-[hsl(var(--success))]',
  },
};

export function Callout({
  tone = 'note',
  title,
  children,
}: {
  tone?: keyof typeof CALLOUT_STYLES;
  title?: string;
  children: ReactNode;
}) {
  const style = CALLOUT_STYLES[tone] ?? CALLOUT_STYLES.note;
  if (!style) return null;

  return (
    <aside className={cx('rounded-[var(--radius-card)] border p-4', style.border, style.bg)}>
      <p className={cx('text-xs font-bold uppercase tracking-wide', style.tone)}>{style.label}</p>
      {title ? <p className="mt-1 font-semibold text-ink">{title}</p> : null}
      <div className="mt-1 text-sm text-ink lesson-prose">{children}</div>
    </aside>
  );
}

// --- Field -----------------------------------------------------------------

export function Field({
  label,
  htmlFor,
  hint,
  error,
  children,
  required,
}: {
  label: string;
  htmlFor: string;
  hint?: string;
  error?: string;
  children: ReactNode;
  required?: boolean;
}) {
  const hintId = hint ? `${htmlFor}-hint` : undefined;
  const errorId = error ? `${htmlFor}-error` : undefined;

  return (
    <div className="mb-4">
      <label htmlFor={htmlFor} className="block text-sm font-semibold text-ink mb-1.5">
        {label}
        {required ? (
          <span className="text-[hsl(var(--danger))] ml-0.5" aria-hidden="true">
            *
          </span>
        ) : null}
      </label>
      {hint ? (
        <p id={hintId} className="text-xs text-muted mb-1.5">
          {hint}
        </p>
      ) : null}
      {children}
      {error ? (
        <p id={errorId} role="alert" className="mt-1.5 text-sm text-[hsl(var(--danger))] font-medium">
          {error}
        </p>
      ) : null}
    </div>
  );
}

export const inputClasses =
  'w-full rounded-lg border border-app bg-surface px-3 py-2.5 text-ink ' +
  'placeholder:text-faint min-h-[2.75rem] transition-colors ' +
  'hover:border-strong disabled:opacity-60';

/** Describes a field with its hint and error, for aria-describedby. */
export function describedBy(id: string, hint?: string, error?: string): string | undefined {
  const parts = [hint ? `${id}-hint` : null, error ? `${id}-error` : null].filter(Boolean);
  return parts.length ? parts.join(' ') : undefined;
}
