'use client';

import { useActionState, useEffect, useState } from 'react';
import { useFormStatus } from 'react-dom';
import { Button, Card, CardHeader, Field, inputClasses } from '@/components/ui';
import { cx } from '@/lib/utils';
import type { ActionResult } from '@/lib/actions/schemas';

/**
 * Settings.
 *
 * The theme and reduced-motion choices apply immediately and are also stored on
 * the profile, so they follow the learner to another device. localStorage is
 * used only to avoid a flash of the wrong theme before the profile loads.
 */

const DAYS = [
  { value: 1, label: 'Mon' },
  { value: 2, label: 'Tue' },
  { value: 3, label: 'Wed' },
  { value: 4, label: 'Thu' },
  { value: 5, label: 'Fri' },
  { value: 6, label: 'Sat' },
  { value: 7, label: 'Sun' },
] as const;

export function SettingsForm({
  action,
  initial,
}: {
  action: (previous: ActionResult | null, formData: FormData) => Promise<ActionResult>;
  initial: {
    displayName: string;
    theme: string;
    reducedMotion: boolean;
    minutesPerDay: number;
    studyDays: number[];
    targetCompletionDate: string | null;
  };
}) {
  const [state, formAction] = useActionState(action, null);
  const [theme, setTheme] = useState(initial.theme);
  const [reducedMotion, setReducedMotion] = useState(initial.reducedMotion);
  const [days, setDays] = useState<number[]>(initial.studyDays);

  // Apply the preference to the live document immediately.
  useEffect(() => {
    const root = document.documentElement;
    if (theme === 'system') {
      root.removeAttribute('data-theme');
      localStorage.removeItem('html-hero-theme');
    } else {
      root.setAttribute('data-theme', theme);
      localStorage.setItem('html-hero-theme', theme);
    }
  }, [theme]);

  useEffect(() => {
    const root = document.documentElement;
    if (reducedMotion) {
      root.setAttribute('data-reduced-motion', 'true');
      localStorage.setItem('html-hero-reduced-motion', 'true');
    } else {
      root.removeAttribute('data-reduced-motion');
      localStorage.removeItem('html-hero-reduced-motion');
    }
  }, [reducedMotion]);

  const toggleDay = (value: number) =>
    setDays((current) =>
      current.includes(value) ? current.filter((d) => d !== value) : [...current, value].sort(),
    );

  const errors = state?.errors ?? {};

  return (
    <form action={formAction} className="space-y-5">
      {state?.message ? (
        <p
          role="status"
          className={cx(
            'rounded-lg border px-4 py-3 text-sm font-medium',
            state.ok
              ? 'border-[hsl(var(--success)/0.35)] bg-[hsl(var(--success-soft))] text-[hsl(var(--success))]'
              : 'border-[hsl(var(--danger)/0.35)] bg-[hsl(var(--danger-soft))] text-[hsl(var(--danger))]',
          )}
        >
          {state.message}
        </p>
      ) : null}

      <Card>
        <CardHeader title="Your details" />
        <div className="px-5 pb-5">
          <Field label="Display name" htmlFor="displayName" error={errors.displayName} required>
            <input
              id="displayName"
              name="displayName"
              type="text"
              defaultValue={initial.displayName}
              autoComplete="name"
              maxLength={60}
              required
              className={inputClasses}
            />
          </Field>
        </div>
      </Card>

      <Card>
        <CardHeader
          title="Appearance"
          description="Applies immediately, and follows you to other devices."
        />
        <div className="px-5 pb-5">
          <fieldset className="mb-5">
            <legend className="mb-2 text-sm font-semibold text-ink">Theme</legend>
            <div className="flex flex-wrap gap-2">
              {(['system', 'light', 'dark'] as const).map((option) => (
                <label
                  key={option}
                  className={cx(
                    'inline-flex cursor-pointer items-center gap-2 rounded-lg border px-4 py-2.5 text-sm font-medium min-h-[2.75rem] capitalize',
                    theme === option
                      ? 'border-[hsl(var(--accent))] bg-[hsl(var(--accent-soft))] text-[hsl(var(--accent))]'
                      : 'border-app text-muted hover:border-strong',
                  )}
                >
                  <input
                    type="radio"
                    name="theme"
                    value={option}
                    checked={theme === option}
                    onChange={() => setTheme(option)}
                    className="h-4 w-4 accent-[hsl(var(--accent))]"
                  />
                  {option}
                </label>
              ))}
            </div>
          </fieldset>

          <label className="flex cursor-pointer items-start gap-3">
            <input
              type="checkbox"
              name="reducedMotion"
              checked={reducedMotion}
              onChange={(event) => setReducedMotion(event.target.checked)}
              className="mt-1 h-4 w-4 accent-[hsl(var(--accent))]"
            />
            <span>
              <span className="block text-sm font-semibold text-ink">Reduce motion</span>
              <span className="block text-sm text-muted">
                Removes transitions and animations. Your operating-system setting is respected
                automatically; this forces it on regardless.
              </span>
            </span>
          </label>
        </div>
      </Card>

      <Card>
        <CardHeader
          title="Study plan"
          description="Changing these recalculates your estimated completion date."
        />
        <div className="px-5 pb-5">
          <Field
            label="Minutes on a study day"
            htmlFor="minutesPerDay"
            error={errors.minutesPerDay}
            required
          >
            <input
              id="minutesPerDay"
              name="minutesPerDay"
              type="number"
              min={15}
              max={240}
              step={5}
              defaultValue={initial.minutesPerDay}
              required
              className={inputClasses}
            />
          </Field>

          <fieldset className="mb-4">
            <legend className="mb-2 text-sm font-semibold text-ink">Study days</legend>
            <div className="flex flex-wrap gap-2">
              {DAYS.map((day) => (
                <label
                  key={day.value}
                  className={cx(
                    'inline-flex cursor-pointer items-center gap-2 rounded-lg border px-4 py-2.5 text-sm font-medium min-h-[2.75rem]',
                    days.includes(day.value)
                      ? 'border-[hsl(var(--accent))] bg-[hsl(var(--accent-soft))] text-[hsl(var(--accent))]'
                      : 'border-app text-muted hover:border-strong',
                  )}
                >
                  <input
                    type="checkbox"
                    name="studyDays"
                    value={day.value}
                    checked={days.includes(day.value)}
                    onChange={() => toggleDay(day.value)}
                    className="h-4 w-4 accent-[hsl(var(--accent))]"
                  />
                  {day.label}
                </label>
              ))}
            </div>
            {days.length === 0 ? (
              <p role="alert" className="mt-2 text-sm font-medium text-[hsl(var(--danger))]">
                Choose at least one day.
              </p>
            ) : null}
          </fieldset>

          <Field
            label="Target completion date"
            htmlFor="targetCompletionDate"
            hint="Optional. Leave blank to let the estimate follow your real pace."
          >
            <input
              id="targetCompletionDate"
              name="targetCompletionDate"
              type="date"
              defaultValue={initial.targetCompletionDate ?? ''}
              className={inputClasses}
              aria-describedby="targetCompletionDate-hint"
            />
          </Field>
        </div>
      </Card>

      <SaveButton disabled={days.length === 0} />
    </form>
  );
}

function SaveButton({ disabled }: { disabled: boolean }) {
  const { pending } = useFormStatus();
  return (
    <Button type="submit" size="lg" disabled={pending || disabled}>
      {pending ? 'Saving…' : 'Save settings'}
    </Button>
  );
}
