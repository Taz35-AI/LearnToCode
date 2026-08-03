/*
 * Supabase connection — fill in both values from your Supabase project:
 * Dashboard → Project Settings → API.
 *
 * These two values are safe to commit: the anon key is designed to be
 * public, and Row Level Security (see supabase/schema.sql) means nobody
 * can touch the data without signing in.
 *
 * Leave both empty ("") to run in local-only mode (data stays in the
 * browser, as before).
 */
window.APP_CONFIG = {
  SUPABASE_URL: "",
  SUPABASE_ANON_KEY: "",
};
