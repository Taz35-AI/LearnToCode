'use client';

import { createBrowserClient } from '@supabase/ssr';
import type { Database } from './database.types';
import { publicEnv } from '@/lib/env';

type BrowserClient = ReturnType<typeof createBrowserClient<Database>>;

let cached: BrowserClient | null = null;

/**
 * The browser Supabase client. Uses only the public anon key; every read and
 * write it performs is filtered by Row Level Security.
 */
export function createClient(): BrowserClient {
  if (cached) return cached;
  const env = publicEnv();
  cached = createBrowserClient<Database>(
    env.NEXT_PUBLIC_SUPABASE_URL,
    env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
  );
  return cached;
}
