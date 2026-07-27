import { z } from 'zod';

/**
 * Environment access.
 *
 * `NEXT_PUBLIC_*` values are safe to ship to the browser — the Supabase
 * anon key is designed to be public and is useless without a session,
 * because Row Level Security decides what it can read.
 *
 * The service-role key is read ONLY by `serverEnv()`, which throws if it is
 * ever reached from a browser bundle. Nothing in `src/app` imports it.
 */

const publicSchema = z.object({
  NEXT_PUBLIC_SUPABASE_URL: z.string().url('NEXT_PUBLIC_SUPABASE_URL must be a valid URL'),
  NEXT_PUBLIC_SUPABASE_ANON_KEY: z.string().min(20, 'NEXT_PUBLIC_SUPABASE_ANON_KEY looks too short'),
  NEXT_PUBLIC_SITE_URL: z.string().url().optional(),
});

export type PublicEnv = z.infer<typeof publicSchema>;

let cachedPublic: PublicEnv | null = null;

/**
 * Reads the public environment. Property access is written out longhand
 * because Next.js inlines `process.env.NEXT_PUBLIC_*` at build time only when
 * it can see the literal property name.
 */
export function publicEnv(): PublicEnv {
  if (cachedPublic) return cachedPublic;

  const parsed = publicSchema.safeParse({
    NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL,
    NEXT_PUBLIC_SUPABASE_ANON_KEY: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    NEXT_PUBLIC_SITE_URL: process.env.NEXT_PUBLIC_SITE_URL,
  });

  if (!parsed.success) {
    const issues = parsed.error.issues.map((i) => `  • ${i.path.join('.')}: ${i.message}`).join('\n');
    throw new Error(
      `Supabase environment variables are missing or invalid:\n${issues}\n\n` +
        'Copy .env.example to .env.local and fill in the values from your Supabase project settings.',
    );
  }

  cachedPublic = parsed.data;
  return cachedPublic;
}

/** True when the app has enough configuration to talk to Supabase. */
export function isSupabaseConfigured(): boolean {
  return (
    typeof process.env.NEXT_PUBLIC_SUPABASE_URL === 'string' &&
    process.env.NEXT_PUBLIC_SUPABASE_URL.length > 0 &&
    typeof process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY === 'string' &&
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY.length > 0
  );
}

/** The canonical site origin, used to build auth redirect URLs. */
export function siteUrl(): string {
  const explicit = process.env.NEXT_PUBLIC_SITE_URL;
  if (explicit) return explicit.replace(/\/$/, '');
  const vercel = process.env.VERCEL_URL;
  if (vercel) return `https://${vercel}`;
  return 'http://localhost:3000';
}

/**
 * Server-only secrets. Guarded so an accidental client import fails loudly at
 * runtime instead of silently shipping a service-role key to the browser.
 */
export function serverEnv(): { SUPABASE_SERVICE_ROLE_KEY: string } {
  if (typeof window !== 'undefined') {
    throw new Error('serverEnv() must never be called in the browser.');
  }
  const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!key) {
    throw new Error(
      'SUPABASE_SERVICE_ROLE_KEY is not set. It is only needed by scripts/seed tooling, never by the app.',
    );
  }
  return { SUPABASE_SERVICE_ROLE_KEY: key };
}
