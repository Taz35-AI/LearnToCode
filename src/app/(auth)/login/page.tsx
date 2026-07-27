import { Suspense } from 'react';
import type { Metadata } from 'next';
import { LoginForm } from '@/components/auth/auth-forms';
import { loginAction } from '@/lib/actions/auth';
import { Skeleton } from '@/components/ui';

export const metadata: Metadata = {
  title: 'Sign in',
  description: 'Sign in to continue your HTML Hero course.',
};

export default function LoginPage() {
  return (
    <>
      <h1 className="text-2xl font-bold text-ink">Welcome back</h1>
      <p className="mt-1.5 mb-7 text-muted">Pick up exactly where you left off.</p>

      <Suspense fallback={<Skeleton className="h-72 w-full" />}>
        <LoginForm action={loginAction} />
      </Suspense>
    </>
  );
}
