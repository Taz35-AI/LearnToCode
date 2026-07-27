import type { Metadata } from 'next';
import { ForgotPasswordForm } from '@/components/auth/auth-forms';
import { forgotPasswordAction } from '@/lib/actions/auth';

export const metadata: Metadata = {
  title: 'Reset your password',
  description: 'Request a password reset link for your HTML Hero account.',
};

export default function ForgotPasswordPage() {
  return (
    <>
      <h1 className="text-2xl font-bold text-ink">Reset your password</h1>
      <p className="mt-1.5 mb-7 text-muted">
        Enter the address you signed up with and we will send you a link.
      </p>

      <ForgotPasswordForm action={forgotPasswordAction} />
    </>
  );
}
