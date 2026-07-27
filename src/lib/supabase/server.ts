import 'server-only';

import { createServerClient } from '@supabase/ssr';
import { cookies } from 'next/headers';
import type { Database } from './database.types';
import { publicEnv } from '@/lib/env';

/**
 * The request-scoped Supabase client for Server Components, Server Actions and
 * Route Handlers. Session cookies are read from and written to the incoming
 * request, so a signed-in learner stays signed in across devices and reloads.
 */
export async function createClient() {
  const cookieStore = await cookies();
  const env = publicEnv();

  return createServerClient<Database>(
    env.NEXT_PUBLIC_SUPABASE_URL,
    env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll();
        },
        setAll(cookiesToSet) {
          try {
            for (const { name, value, options } of cookiesToSet) {
              cookieStore.set(name, value, options);
            }
          } catch {
            // Called from a Server Component, where cookies are read-only.
            // `middleware.ts` refreshes the session on every request, so the
            // cookie is kept fresh there instead.
          }
        },
      },
    },
  );
}

/**
 * Returns the signed-in user, or null.
 *
 * Always uses `getUser()` (which verifies the JWT with Supabase) rather than
 * `getSession()` (which trusts the cookie), because this value gates access to
 * learner data.
 */
export async function getCurrentUser() {
  const supabase = await createClient();
  const { data, error } = await supabase.auth.getUser();
  if (error) return null;
  return data.user;
}
