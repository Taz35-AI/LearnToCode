import { createServerClient } from '@supabase/ssr';
import { NextResponse, type NextRequest } from 'next/server';
import type { Database } from './database.types';

/** Routes that require a signed-in learner. */
const PROTECTED_PREFIXES = [
  '/dashboard',
  '/roadmap',
  '/lesson',
  '/level',
  '/practice',
  '/review',
  '/project',
  '/achievements',
  '/settings',
  '/certificate',
  '/onboarding',
  '/assessment',
];

/** Routes a signed-in learner should be bounced away from. */
const AUTH_ONLY_PREFIXES = ['/login', '/register', '/forgot-password'];

function matches(pathname: string, prefixes: string[]): boolean {
  return prefixes.some((p) => pathname === p || pathname.startsWith(`${p}/`));
}

/**
 * Refreshes the Supabase session cookie on every request and enforces route
 * protection. Running this in middleware means a Server Component never sees a
 * stale token, and an unauthenticated request never reaches learner data.
 */
export async function updateSession(request: NextRequest): Promise<NextResponse> {
  let response = NextResponse.next({ request });

  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  // Without configuration there is no session to refresh. Let the request
  // through so the app can render its "finish setting up Supabase" screen.
  if (!url || !key) return response;

  const supabase = createServerClient<Database>(url, key, {
    cookies: {
      getAll() {
        return request.cookies.getAll();
      },
      setAll(cookiesToSet) {
        for (const { name, value } of cookiesToSet) {
          request.cookies.set(name, value);
        }
        response = NextResponse.next({ request });
        for (const { name, value, options } of cookiesToSet) {
          response.cookies.set(name, value, options);
        }
      },
    },
  });

  const {
    data: { user },
  } = await supabase.auth.getUser();

  const { pathname } = request.nextUrl;

  if (!user && matches(pathname, PROTECTED_PREFIXES)) {
    const redirect = request.nextUrl.clone();
    redirect.pathname = '/login';
    redirect.searchParams.set('next', pathname);
    return NextResponse.redirect(redirect);
  }

  if (user && matches(pathname, AUTH_ONLY_PREFIXES)) {
    const redirect = request.nextUrl.clone();
    redirect.pathname = '/dashboard';
    redirect.search = '';
    return NextResponse.redirect(redirect);
  }

  return response;
}
