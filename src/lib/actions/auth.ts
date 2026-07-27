'use server';

import { redirect } from 'next/navigation';
import { revalidatePath } from 'next/cache';
import { createClient } from '@/lib/supabase/server';
import { siteUrl } from '@/lib/env';
import {
  fieldErrors,
  forgotPasswordSchema,
  loginSchema,
  registerSchema,
  resetPasswordSchema,
  type ActionResult,
} from './schemas';

/**
 * Authentication actions.
 *
 * Two deliberate choices:
 *
 *   · Error messages never reveal whether an email address is registered.
 *     "Those details did not match" is returned for both a wrong password and
 *     an unknown account, and password reset always reports success.
 *
 *   · Redirect targets are validated as same-origin relative paths, so a
 *     crafted `?next=` cannot bounce a signed-in learner to another site.
 */

/** Only same-origin paths are accepted as a post-login destination. */
function safeRedirect(next: string | undefined | null): string {
  if (!next) return '/dashboard';
  if (!next.startsWith('/') || next.startsWith('//')) return '/dashboard';
  return next;
}

export async function registerAction(
  _previous: ActionResult | null,
  formData: FormData,
): Promise<ActionResult> {
  const parsed = registerSchema.safeParse({
    displayName: formData.get('displayName'),
    email: formData.get('email'),
    password: formData.get('password'),
  });

  if (!parsed.success) {
    return { ok: false, errors: fieldErrors(parsed.error) };
  }

  const supabase = await createClient();
  const { data, error } = await supabase.auth.signUp({
    email: parsed.data.email,
    password: parsed.data.password,
    options: {
      data: { display_name: parsed.data.displayName },
      emailRedirectTo: `${siteUrl()}/auth/callback?next=/onboarding`,
    },
  });

  if (error) {
    // Supabase distinguishes "already registered"; we deliberately do not.
    return {
      ok: false,
      message:
        error.message.toLowerCase().includes('already')
          ? 'If that address can be registered, we have sent a confirmation email.'
          : 'We could not create the account. Please check the details and try again.',
    };
  }

  // With email confirmation switched on, there is no session yet.
  if (!data.session) {
    return {
      ok: true,
      message:
        'Check your inbox — we have sent a link to confirm your address. Once confirmed, you can sign in.',
    };
  }

  revalidatePath('/', 'layout');
  redirect('/onboarding');
}

export async function loginAction(
  _previous: ActionResult | null,
  formData: FormData,
): Promise<ActionResult> {
  const parsed = loginSchema.safeParse({
    email: formData.get('email'),
    password: formData.get('password'),
    next: formData.get('next') ?? undefined,
  });

  if (!parsed.success) {
    return { ok: false, errors: fieldErrors(parsed.error) };
  }

  const supabase = await createClient();
  const { error } = await supabase.auth.signInWithPassword({
    email: parsed.data.email,
    password: parsed.data.password,
  });

  if (error) {
    return {
      ok: false,
      message: 'Those details did not match an account. Check your email and password and try again.',
    };
  }

  revalidatePath('/', 'layout');
  redirect(safeRedirect(parsed.data.next));
}

export async function logoutAction(): Promise<void> {
  const supabase = await createClient();
  await supabase.auth.signOut();
  revalidatePath('/', 'layout');
  redirect('/login');
}

export async function forgotPasswordAction(
  _previous: ActionResult | null,
  formData: FormData,
): Promise<ActionResult> {
  const parsed = forgotPasswordSchema.safeParse({ email: formData.get('email') });
  if (!parsed.success) {
    return { ok: false, errors: fieldErrors(parsed.error) };
  }

  const supabase = await createClient();
  await supabase.auth.resetPasswordForEmail(parsed.data.email, {
    redirectTo: `${siteUrl()}/auth/callback?next=/reset-password`,
  });

  // Always the same answer, so this endpoint cannot be used to discover which
  // addresses have accounts.
  return {
    ok: true,
    message:
      'If that address has an account, we have sent a reset link. It expires in one hour.',
  };
}

export async function resetPasswordAction(
  _previous: ActionResult | null,
  formData: FormData,
): Promise<ActionResult> {
  const parsed = resetPasswordSchema.safeParse({
    password: formData.get('password'),
    confirmPassword: formData.get('confirmPassword'),
  });

  if (!parsed.success) {
    return { ok: false, errors: fieldErrors(parsed.error) };
  }

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return {
      ok: false,
      message: 'This reset link has expired. Request a new one and try again.',
    };
  }

  const { error } = await supabase.auth.updateUser({ password: parsed.data.password });
  if (error) {
    return { ok: false, message: 'We could not update the password. Please request a new link.' };
  }

  revalidatePath('/', 'layout');
  redirect('/dashboard');
}
