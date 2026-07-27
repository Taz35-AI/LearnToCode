import type { NextRequest } from 'next/server';
import { updateSession } from '@/lib/supabase/middleware';

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
