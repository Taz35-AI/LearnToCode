import type { Metadata } from 'next';
import { ResetPasswordForm } from '@/components/auth/auth-forms';
import { resetPasswordAction } from '@/lib/actions/auth';

export const metadata: Metadata = {
  title: 'Choose a new password',
  robots: { index: false, follow: false },
};

export default function ResetPasswordPage() {
  return (
    <>
      <h1 className="text-2xl font-bold text-ink">Choose a new password</h1>
      <p className="mt-1.5 mb-7 text-muted">
        You are signed in from your reset link. Set a new password to finish.
      </p>

      <ResetPasswordForm action={resetPasswordAction} />
    </>
  );
}
