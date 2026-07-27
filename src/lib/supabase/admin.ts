import 'server-only';

import { createClient as createSupabaseClient } from '@supabase/supabase-js';
import type { Database } from './database.types';
import { publicEnv, serverEnv } from '@/lib/env';

/**
 * A service-role client that bypasses Row Level Security.
 *
 * This exists for the seed script and administrative maintenance only. It is
 * never imported by anything under `src/app`, and `import 'server-only'` plus
 * the guard in `serverEnv()` make an accidental client-side import a build or
 * runtime failure rather than a silent key leak.
 */
export function createAdminClient() {
  const { NEXT_PUBLIC_SUPABASE_URL } = publicEnv();
  const { SUPABASE_SERVICE_ROLE_KEY } = serverEnv();

  return createSupabaseClient<Database>(NEXT_PUBLIC_SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
}
