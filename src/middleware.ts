import type { NextRequest } from 'next/server';

/*
 * Session refresh and route protection, running before every matched request.
 *
 * Two deployment details are deliberate here, both learned the hard way.
 *
 * The file lives in `src/`, not at the repository root, and imports relatively
 * rather than through the `@/` alias. Middleware is packaged as a separate
 * Edge Function, and a root-level entry point reaching across into `src/` via
 * the alias fails that packaging step — `next build` succeeds and the
 * deployment then dies on "referencing unsupported modules".
 *
 * Next 16 deprecates this convention in favour of `proxy`, which is why the
 * build prints a warning. Do not take that advice yet: `proxy` builds cleanly
 * but hosting providers do not all wire it into their routing table, and the
 * result is a deployment that reports success while returning 404 for every
 * path the matcher covers. The deprecation warning is the lesser problem.
 */
import { updateSession } from './lib/supabase/middleware';

export async function middleware(request: NextRequest) {
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
