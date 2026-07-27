import type { NextRequest } from 'next/server';

/*
 * Session refresh and route protection, running before every matched request.
 *
 * This uses Next 16's `proxy` convention rather than the deprecated
 * `middleware` one. The rename is not cosmetic: `middleware` compiles to an
 * Edge Function packaged separately from the rest of the application, and that
 * packaging step could not resolve the `@/` alias into `src/` — `next build`
 * succeeded and the deployment then failed on an "unsupported modules" error.
 * `proxy` is traced as an ordinary Node function, so the alias boundary and the
 * Edge runtime's library restrictions both stop applying.
 *
 * The import below stays relative regardless, so this entry point resolves the
 * same way under any bundler.
 */
import { updateSession } from './lib/supabase/middleware';

export default async function proxy(request: NextRequest) {
  return updateSession(request);
}

export const config = {
  matcher: [
    /*
     * Every path except static assets, the learning-media folder and image
     * optimisation — those never need a session and skipping them keeps
     * media requests fast.
     */
    '/((?!_next/static|_next/image|learning-media|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|webp|gif|mp4|webm|wav|mp3|vtt|ico)$).*)',
  ],
};
