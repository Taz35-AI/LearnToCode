'use client';

import { useEffect } from 'react';
import { Button, ButtonLink } from '@/components/ui';
import { AlertIcon } from '@/components/ui/icons';

/**
 * The application error boundary.
 *
 * Deliberately shows what the learner can do, not a stack trace — the details
 * go to the console for whoever is debugging, and the page offers a way out.
 */
export default function ErrorBoundary({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    console.error('Unhandled error:', error);
  }, [error]);

  return (
    <main className="min-h-screen grid place-items-center px-6 py-16">
      <div className="max-w-md text-center">
        <div className="mx-auto mb-4 grid h-12 w-12 place-items-center rounded-full bg-[hsl(var(--danger-soft))] text-[hsl(var(--danger))]">
          <AlertIcon size={24} />
        </div>
        <h1 className="text-2xl font-bold text-ink">Something went wrong</h1>
        <p className="mt-2 text-muted">
          Your progress is saved — nothing has been lost. Try again, or head back to your dashboard.
        </p>
        {error.digest ? (
          <p className="mt-3 text-xs text-faint font-mono">Reference: {error.digest}</p>
        ) : null}
        <div className="mt-6 flex flex-wrap gap-3 justify-center">
          <Button onClick={reset}>Try again</Button>
          <ButtonLink href="/dashboard" variant="secondary">
            Back to dashboard
          </ButtonLink>
        </div>
      </div>
    </main>
  );
}
