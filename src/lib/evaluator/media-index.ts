import { allMediaPaths } from '@/content/media/manifest';

/**
 * Known-good media paths, used to tell a learner when they have typed a path
 * that will 404. Built once from the media manifest, which `npm run media:verify`
 * checks against the real contents of `public/`.
 */
const KNOWN_PATHS = new Set(allMediaPaths());

/** Paths a learner's own project may legitimately reference. */
const PROJECT_PATH_RE = /^(?:\.{0,2}\/)?(?:images|assets|media|img)\/[a-z0-9][a-z0-9._/-]*$/i;

/**
 * True when a media reference will resolve.
 *
 * Accepts three shapes:
 *   · a path into the platform's own media library (checked exactly)
 *   · a relative path inside the learner's project folders (shape-checked, since
 *     the learner's own files are not on this server)
 *   · a data: URI (self-contained, so it always resolves)
 *
 * Remote URLs are rejected on purpose: lessons must work offline, and the
 * course teaches learners not to hotlink other people's media.
 */
export function mediaPathExists(reference: string): boolean {
  const value = reference.trim();
  if (value.length === 0) return false;
  if (value.startsWith('data:')) return true;

  if (/^https?:\/\//i.test(value) || value.startsWith('//')) return false;

  const withoutQuery = value.split(/[?#]/)[0] ?? value;

  if (withoutQuery.startsWith('/learning-media/')) {
    return KNOWN_PATHS.has(withoutQuery);
  }
  if (withoutQuery.startsWith('learning-media/')) {
    return KNOWN_PATHS.has(`/${withoutQuery}`);
  }
  return PROJECT_PATH_RE.test(withoutQuery);
}

/** Exposed for tests and the media picker. */
export function knownMediaPaths(): string[] {
  return [...KNOWN_PATHS];
}
