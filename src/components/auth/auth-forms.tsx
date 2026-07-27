'use client';

import { useActionState } from 'react';
import { useFormStatus } from 'react-dom';
import Link from 'next/link';
import { useSearchParams } from 'next/navigation';
import { Button, Field, inputClasses, describedBy } from '@/components/ui';
import type { ActionResult } from '@/lib/actions/schemas';

/**
 * The authentication forms.
 *
 * Every field carries a real `<label for>`, an `autocomplete` value and an
 * `aria-describedby` pointing at its hint or error — the same rules the course
 * teaches in Level 6, applied to the platform itself.
 */

type AuthAction = (previous: ActionResult | null, formData: FormData) => Promise<ActionResult>;

function SubmitButton({ children, pendingLabel }: { children: string; pendingLabel: string }) {
  const { pending } = useFormStatus();
  return (
    <Button type="submit" size="lg" className="w-full" disabled={pending}>
      {pending ? pendingLabel : children}
    </Button>
  );
}

function FormMessage({ result }: { result: ActionResult | null }) {
  if (!result?.message) return null;
  const tone = result.ok
    ? 'border-[hsl(var(--success)/0.35)] bg-[hsl(var(--success-soft))] text-[hsl(var(--success))]'
    : 'border-[hsl(var(--danger)/0.35)] bg-[hsl(var(--danger-soft))] text-[hsl(var(--danger))]';

  return (
    <p role={result.ok ? 'status' : 'alert'} className={`mb-4 rounded-lg border px-4 py-3 text-sm font-medium ${tone}`}>
      {result.message}
    </p>
  );
}

export function RegisterForm({ action }: { action: AuthAction }) {
  const [state, formAction] = useActionState(action, null);
  const errors = state?.errors ?? {};

  return (
    <form action={formAction} noValidate>
      <FormMessage result={state} />

      <Field
        label="What should we call you?"
        htmlFor="displayName"
        hint="Shown on your dashboard and certificate."
        error={errors.displayName}
        required
      >
        <input
          id="displayName"
          name="displayName"
          type="text"
          autoComplete="name"
          required
          maxLength={60}
          className={inputClasses}
          aria-describedby={describedBy('displayName', 'hint', errors.displayName)}
          aria-invalid={errors.displayName ? true : undefined}
        />
      </Field>

      <Field label="Email address" htmlFor="email" error={errors.email} required>
        <input
          id="email"
          name="email"
          type="email"
          autoComplete="email"
          required
          className={inputClasses}
          aria-describedby={describedBy('email', undefined, errors.email)}
          aria-invalid={errors.email ? true : undefined}
        />
      </Field>

      <Field
        label="Password"
        htmlFor="password"
        hint="At least 10 characters. A memorable phrase beats a short complicated word."
        error={errors.password}
        required
      >
        <input
          id="password"
          name="password"
          type="password"
          autoComplete="new-password"
          required
          minLength={10}
          className={inputClasses}
          aria-describedby={describedBy('password', 'hint', errors.password)}
          aria-invalid={errors.password ? true : undefined}
        />
      </Field>

      <SubmitButton pendingLabel="Creating your account…">Create my account</SubmitButton>

      <p className="mt-5 text-center text-sm text-muted">
        Already have an account?{' '}
        <Link href="/login" className="text-accent font-semibold underline underline-offset-2">
          Sign in
        </Link>
      </p>
    </form>
  );
}

export function LoginForm({ action }: { action: AuthAction }) {
  const [state, formAction] = useActionState(action, null);
  const params = useSearchParams();
  const next = params.get('next') ?? '';
  const errors = state?.errors ?? {};

  return (
    <form action={formAction} noValidate>
      <FormMessage result={state} />
      <input type="hidden" name="next" value={next} />

      <Field label="Email address" htmlFor="email" error={errors.email} required>
        <input
          id="email"
          name="email"
          type="email"
          autoComplete="email"
          required
          className={inputClasses}
          aria-describedby={describedBy('email', undefined, errors.email)}
          aria-invalid={errors.email ? true : undefined}
        />
      </Field>

      <Field label="Password" htmlFor="password" error={errors.password} required>
        <input
          id="password"
          name="password"
          type="password"
          autoComplete="current-password"
          required
          className={inputClasses}
          aria-describedby={describedBy('password', undefined, errors.password)}
          aria-invalid={errors.password ? true : undefined}
        />
      </Field>

      <SubmitButton pendingLabel="Signing you in…">Sign in</SubmitButton>

      <div className="mt-5 flex flex-col gap-2 text-center text-sm text-muted">
        <Link href="/forgot-password" className="text-accent underline underline-offset-2">
          Forgotten your password?
        </Link>
        <span>
          New here?{' '}
          <Link href="/register" className="text-accent font-semibold underline underline-offset-2">
            Create an account
          </Link>
        </span>
      </div>
    </form>
  );
}

export function ForgotPasswordForm({ action }: { action: AuthAction }) {
  const [state, formAction] = useActionState(action, null);
  const errors = state?.errors ?? {};

  return (
    <form action={formAction} noValidate>
      <FormMessage result={state} />

      <Field
        label="Email address"
        htmlFor="email"
        hint="We will send a reset link if this address has an account."
        error={errors.email}
        required
      >
        <input
          id="email"
          name="email"
          type="email"
          autoComplete="email"
          required
          className={inputClasses}
          aria-describedby={describedBy('email', 'hint', errors.email)}
          aria-invalid={errors.email ? true : undefined}
        />
      </Field>

      <SubmitButton pendingLabel="Sending…">Send reset link</SubmitButton>

      <p className="mt-5 text-center text-sm">
        <Link href="/login" className="text-accent underline underline-offset-2">
          Back to sign in
        </Link>
      </p>
    </form>
  );
}

export function ResetPasswordForm({ action }: { action: AuthAction }) {
  const [state, formAction] = useActionState(action, null);
  const errors = state?.errors ?? {};

  return (
    <form action={formAction} noValidate>
      <FormMessage result={state} />

      <Field
        label="New password"
        htmlFor="password"
        hint="At least 10 characters."
        error={errors.password}
        required
      >
        <input
          id="password"
          name="password"
          type="password"
          autoComplete="new-password"
          required
          minLength={10}
          className={inputClasses}
          aria-describedby={describedBy('password', 'hint', errors.password)}
          aria-invalid={errors.password ? true : undefined}
        />
      </Field>

      <Field
        label="Confirm new password"
        htmlFor="confirmPassword"
        error={errors.confirmPassword}
        required
      >
        <input
          id="confirmPassword"
          name="confirmPassword"
          type="password"
          autoComplete="new-password"
          required
          className={inputClasses}
          aria-describedby={describedBy('confirmPassword', undefined, errors.confirmPassword)}
          aria-invalid={errors.confirmPassword ? true : undefined}
        />
      </Field>

      <SubmitButton pendingLabel="Updating…">Update password</SubmitButton>
    </form>
  );
}
