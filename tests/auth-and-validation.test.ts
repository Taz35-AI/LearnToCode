// @vitest-environment node
//
// Middleware runs on the server, and `NextRequest` requires the platform's own
// Headers implementation rather than jsdom's. This file therefore runs in the
// node environment; component tests keep the jsdom default.

import { beforeEach, describe, expect, it, vi } from 'vitest';
import { NextRequest } from 'next/server';
import {
  answerQuestionSchema,
  completeLessonSchema,
  evaluateSchema,
  fieldErrors,
  forgotPasswordSchema,
  loginSchema,
  onboardingSchema,
  registerSchema,
  resetPasswordSchema,
  saveProjectFileSchema,
  updateSettingsSchema,
} from '@/lib/actions/schemas';

/**
 * Authentication, route protection and input validation.
 *
 * Route protection is tested against the real middleware with a stubbed
 * Supabase client, so what is asserted is the actual redirect behaviour rather
 * than a reimplementation of it.
 */

// --- Supabase stub, controlled per test -------------------------------------

let currentUser: { id: string } | null = null;

vi.mock('@supabase/ssr', () => ({
  createServerClient: () => ({
    auth: {
      getUser: async () => ({ data: { user: currentUser }, error: null }),
    },
  }),
}));

const { updateSession } = await import('@/lib/supabase/middleware');

function request(pathname: string): NextRequest {
  return new NextRequest(new URL(`http://localhost:3000${pathname}`));
}

describe('route protection', () => {
  beforeEach(() => {
    currentUser = null;
    process.env.NEXT_PUBLIC_SUPABASE_URL = 'https://project.supabase.co';
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY = 'anon-key-that-is-long-enough';
  });

  const protectedPaths = [
    '/dashboard',
    '/roadmap',
    '/lesson/what-happens-when-you-open-a-page',
    '/practice',
    '/project',
    '/achievements',
    '/settings',
    '/certificate',
    '/onboarding',
    '/assessment/level-1-milestone',
  ];

  it.each(protectedPaths)('redirects an anonymous visitor away from %s', async (path) => {
    const response = await updateSession(request(path));
    expect(response.status).toBe(307);

    const location = new URL(response.headers.get('location') ?? '');
    expect(location.pathname).toBe('/login');
    expect(location.searchParams.get('next')).toBe(path);
  });

  it.each(protectedPaths)('lets a signed-in learner reach %s', async (path) => {
    currentUser = { id: 'user-1' };
    const response = await updateSession(request(path));
    expect(response.status).toBe(200);
  });

  it('leaves public pages open to anonymous visitors', async () => {
    for (const path of ['/', '/login', '/register', '/media', '/forgot-password']) {
      const response = await updateSession(request(path));
      expect(response.status, path).toBe(200);
    }
  });

  it('bounces a signed-in learner away from the sign-in pages', async () => {
    currentUser = { id: 'user-1' };
    for (const path of ['/login', '/register', '/forgot-password']) {
      const response = await updateSession(request(path));
      expect(response.status, path).toBe(307);
      expect(new URL(response.headers.get('location') ?? '').pathname).toBe('/dashboard');
    }
  });

  it('does not protect a path that merely starts with the same letters', async () => {
    // "/projects-blog" must not be caught by the "/project" prefix.
    const response = await updateSession(request('/projects-blog'));
    expect(response.status).toBe(200);
  });

  it('lets requests through when Supabase is not configured, so setup can be explained', async () => {
    delete process.env.NEXT_PUBLIC_SUPABASE_URL;
    delete process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
    const response = await updateSession(request('/dashboard'));
    expect(response.status).toBe(200);
  });
});

describe('registration validation', () => {
  const valid = {
    displayName: 'Alex Whitfield',
    email: 'alex@example.test',
    password: 'a-memorable-passphrase',
  };

  it('accepts sensible details', () => {
    expect(registerSchema.safeParse(valid).success).toBe(true);
  });

  it('rejects a malformed email with a message a beginner can act on', () => {
    const result = registerSchema.safeParse({ ...valid, email: 'alex-at-example' });
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(fieldErrors(result.error).email).toContain('name@example.com');
    }
  });

  it('requires a password long enough to be worth having', () => {
    const short = registerSchema.safeParse({ ...valid, password: 'short' });
    expect(short.success).toBe(false);
    if (!short.success) {
      expect(fieldErrors(short.error).password).toContain('10 characters');
    }
  });

  it('rejects an empty or over-long display name', () => {
    expect(registerSchema.safeParse({ ...valid, displayName: '   ' }).success).toBe(false);
    expect(registerSchema.safeParse({ ...valid, displayName: 'x'.repeat(61) }).success).toBe(false);
  });

  it('trims surrounding whitespace from the name and email', () => {
    const result = registerSchema.safeParse({
      ...valid,
      displayName: '  Alex  ',
      email: '  alex@example.test  ',
    });
    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.displayName).toBe('Alex');
      expect(result.data.email).toBe('alex@example.test');
    }
  });
});

describe('sign-in and reset validation', () => {
  it('requires both fields to sign in', () => {
    expect(loginSchema.safeParse({ email: 'a@b.test', password: '' }).success).toBe(false);
    expect(loginSchema.safeParse({ email: '', password: 'x' }).success).toBe(false);
    expect(loginSchema.safeParse({ email: 'a@b.test', password: 'x' }).success).toBe(true);
  });

  it('carries an optional post-login destination', () => {
    const result = loginSchema.safeParse({
      email: 'a@b.test',
      password: 'x',
      next: '/lesson/first',
    });
    expect(result.success).toBe(true);
    if (result.success) expect(result.data.next).toBe('/lesson/first');
  });

  it('validates the forgotten-password address', () => {
    expect(forgotPasswordSchema.safeParse({ email: 'not-an-email' }).success).toBe(false);
    expect(forgotPasswordSchema.safeParse({ email: 'a@b.test' }).success).toBe(true);
  });

  it('requires the two new passwords to match', () => {
    const mismatch = resetPasswordSchema.safeParse({
      password: 'a-long-enough-passphrase',
      confirmPassword: 'a-different-passphrase',
    });
    expect(mismatch.success).toBe(false);
    if (!mismatch.success) {
      expect(fieldErrors(mismatch.error).confirmPassword).toContain('do not match');
    }

    expect(
      resetPasswordSchema.safeParse({
        password: 'a-long-enough-passphrase',
        confirmPassword: 'a-long-enough-passphrase',
      }).success,
    ).toBe(true);
  });
});

describe('onboarding validation', () => {
  const valid = {
    displayName: 'Alex',
    minutesPerDay: 60,
    studyDays: [1, 2, 3, 4, 5],
    experience: 'none',
    projectTemplateSlug: 'personal-portfolio',
  };

  it('accepts a complete plan', () => {
    expect(onboardingSchema.safeParse(valid).success).toBe(true);
  });

  it('coerces form values, which always arrive as strings', () => {
    const result = onboardingSchema.safeParse({
      ...valid,
      minutesPerDay: '45',
      studyDays: ['1', '3', '5'],
    });
    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.minutesPerDay).toBe(45);
      expect(result.data.studyDays).toEqual([1, 3, 5]);
    }
  });

  it('requires at least one study day', () => {
    const result = onboardingSchema.safeParse({ ...valid, studyDays: [] });
    expect(result.success).toBe(false);
    if (!result.success) {
      expect(fieldErrors(result.error).studyDays).toContain('at least one day');
    }
  });

  it('rejects an impossible schedule', () => {
    expect(onboardingSchema.safeParse({ ...valid, minutesPerDay: 5 }).success).toBe(false);
    expect(onboardingSchema.safeParse({ ...valid, minutesPerDay: 600 }).success).toBe(false);
    expect(onboardingSchema.safeParse({ ...valid, studyDays: [0] }).success).toBe(false);
    expect(onboardingSchema.safeParse({ ...valid, studyDays: [8] }).success).toBe(false);
  });

  it('requires a project choice', () => {
    expect(onboardingSchema.safeParse({ ...valid, projectTemplateSlug: '' }).success).toBe(false);
  });

  it('rejects an unparseable target date', () => {
    expect(onboardingSchema.safeParse({ ...valid, targetCompletionDate: 'soon' }).success).toBe(false);
    expect(onboardingSchema.safeParse({ ...valid, targetCompletionDate: '2026-12-01' }).success).toBe(true);
  });
});

describe('submission validation', () => {
  // A valid v4 UUID: the 13th character is the version (4) and the 17th is the
  // variant (8-b). Zod 4 checks both, and so does Postgres.
  const uuid = '11111111-2222-4333-8444-555555555555';

  it('requires a real exercise id', () => {
    expect(evaluateSchema.safeParse({ exerciseId: 'nope', code: '<p>x</p>' }).success).toBe(false);
    expect(evaluateSchema.safeParse({ exerciseId: uuid, code: '<p>x</p>' }).success).toBe(true);
  });

  it('caps submission size so an enormous paste cannot be used as an attack', () => {
    const huge = 'x'.repeat(120_001);
    expect(evaluateSchema.safeParse({ exerciseId: uuid, code: huge }).success).toBe(false);
  });

  it('defaults hint and duration counters rather than trusting their absence', () => {
    const result = evaluateSchema.safeParse({ exerciseId: uuid, code: '<p>x</p>' });
    expect(result.success).toBe(true);
    if (result.success) {
      expect(result.data.hintsUsed).toBe(0);
      expect(result.data.durationSeconds).toBe(0);
    }
  });

  it('clamps implausible client-reported values', () => {
    expect(
      evaluateSchema.safeParse({ exerciseId: uuid, code: '<p>x</p>', durationSeconds: 999_999 }).success,
    ).toBe(false);
    expect(
      evaluateSchema.safeParse({ exerciseId: uuid, code: '<p>x</p>', hintsUsed: -1 }).success,
    ).toBe(false);
  });

  it('requires an answer to be chosen', () => {
    expect(answerQuestionSchema.safeParse({ questionId: uuid, optionIds: [] }).success).toBe(false);
    expect(answerQuestionSchema.safeParse({ questionId: uuid, optionIds: [uuid] }).success).toBe(true);
  });

  it('accepts a confidence rating on a lesson answer, and only a valid one', () => {
    const answer = (confidence: unknown) =>
      answerQuestionSchema.safeParse({ questionId: uuid, optionIds: [uuid], confidence });

    for (const rating of [1, 2, 3, 4]) {
      expect(answer(rating).success, `confidence ${rating}`).toBe(true);
    }
    // The database constrains this column to 1..4; anything else would be
    // rejected there, so it is rejected here where the error is useful.
    expect(answer(0).success).toBe(false);
    expect(answer(5).success).toBe(false);
    expect(answer('4').success).toBe(false);

    // Optional at the boundary: answers recorded before confidence existed
    // have none, and a replayed request should not be rejected as malformed.
    expect(answerQuestionSchema.safeParse({ questionId: uuid, optionIds: [uuid] }).success).toBe(
      true,
    );
  });

  it('validates lesson completion input', () => {
    expect(completeLessonSchema.safeParse({ lessonId: uuid, secondsSpent: 300 }).success).toBe(true);
    expect(completeLessonSchema.safeParse({ lessonId: 'x', secondsSpent: 300 }).success).toBe(false);
  });
});

describe('project file validation', () => {
  it('accepts sensible file paths', () => {
    for (const path of ['index.html', 'about.html', 'routes/valley.html', 'assets/css/site.css']) {
      expect(saveProjectFileSchema.safeParse({ path, content: '' }).success, path).toBe(true);
    }
  });

  it('rejects path traversal, uppercase and unknown extensions', () => {
    for (const path of [
      '../../etc/passwd',
      '/etc/passwd',
      'About.html',
      'index.php',
      'file with spaces.html',
      'script.js',
    ]) {
      expect(saveProjectFileSchema.safeParse({ path, content: '' }).success, path).toBe(false);
    }
  });

  it('caps file size', () => {
    expect(
      saveProjectFileSchema.safeParse({ path: 'index.html', content: 'x'.repeat(200_001) }).success,
    ).toBe(false);
  });
});

describe('settings validation', () => {
  const valid = {
    displayName: 'Alex',
    theme: 'dark',
    reducedMotion: true,
    minutesPerDay: 45,
    studyDays: [1, 3, 5],
  };

  it('accepts valid settings', () => {
    expect(updateSettingsSchema.safeParse(valid).success).toBe(true);
  });

  it('rejects an unknown theme', () => {
    expect(updateSettingsSchema.safeParse({ ...valid, theme: 'neon' }).success).toBe(false);
  });

  it('still requires at least one study day', () => {
    expect(updateSettingsSchema.safeParse({ ...valid, studyDays: [] }).success).toBe(false);
  });
});

describe('field error mapping', () => {
  it('reports one message per field, keyed by field name', () => {
    const result = registerSchema.safeParse({ displayName: '', email: 'x', password: 'y' });
    expect(result.success).toBe(false);
    if (!result.success) {
      const errors = fieldErrors(result.error);
      expect(Object.keys(errors).sort()).toEqual(['displayName', 'email', 'password']);
      for (const message of Object.values(errors)) {
        expect(message.length).toBeGreaterThan(5);
      }
    }
  });
});
