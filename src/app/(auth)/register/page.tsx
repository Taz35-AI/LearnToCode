import type { Metadata } from 'next';
import { RegisterForm } from '@/components/auth/auth-forms';
import { registerAction } from '@/lib/actions/auth';

export const metadata: Metadata = {
  title: 'Create your account',
  description: 'Start the HTML Hero course — from complete beginner to professional HTML.',
};

export default function RegisterPage() {
  return (
    <>
      <h1 className="text-2xl font-bold text-ink">Start learning HTML</h1>
      <p className="mt-1.5 mb-7 text-muted">
        No experience needed. Every term is explained before it is used.
      </p>

      <RegisterForm action={registerAction} />
    </>
  );
}
