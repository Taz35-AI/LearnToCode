/** Joins class names, dropping falsy values. Small enough not to need a library. */
export function cx(...values: (string | false | null | undefined)[]): string {
  return values.filter(Boolean).join(' ');
}

/**
 * Renders the inline emphasis used throughout the authored curriculum:
 * `code`, **bold** and *italic*.
 *
 * Deliberately tiny. Lesson text is authored in this repository, not by users,
 * and a full markdown parser would be a dependency that has not earned its
 * place. Everything is HTML-escaped *first*, so no authored string can inject
 * markup even by accident — which matters, because course content is full of
 * literal tags like `<p>` that must render as text.
 *
 * Content uses backticks in roughly 450 places — question prompts, answer
 * explanations, exercise briefs, summary points and checklists. Any render site
 * that prints one of those as a plain string shows the backticks to the
 * learner, so this lives here rather than inside one component, and
 * `InlineText` in the UI primitives is the component that applies it.
 */
export function inlineFormat(text: string): string {
  const escaped = text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');

  return escaped
    .replace(/`([^`]+)`/g, '<code>$1</code>')
    .replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
    .replace(/(^|[^*])\*([^*]+)\*/g, '$1<em>$2</em>');
}

/** Clamps a number into a range. */
export function clamp(value: number, min: number, max: number): number {
  return Math.min(max, Math.max(min, value));
}

/** "3 lessons" / "1 lesson" */
export function plural(count: number, one: string, many = `${one}s`): string {
  return `${count} ${count === 1 ? one : many}`;
}

/** Formats a duration in minutes as "45 min" or "1 h 20 min". */
export function formatMinutes(minutes: number): string {
  const total = Math.max(0, Math.round(minutes));
  if (total < 60) return `${total} min`;
  const hours = Math.floor(total / 60);
  const rest = total % 60;
  return rest === 0 ? `${hours} h` : `${hours} h ${rest} min`;
}

/** Formats seconds as a compact study-time string. */
export function formatStudyTime(seconds: number): string {
  return formatMinutes(seconds / 60);
}

/** A short relative time, e.g. "2 days ago". */
export function relativeTime(iso: string | null | undefined, now = new Date()): string {
  if (!iso) return 'never';
  const then = new Date(iso).getTime();
  if (Number.isNaN(then)) return 'never';

  const seconds = Math.round((now.getTime() - then) / 1000);
  if (seconds < 60) return 'just now';
  const minutes = Math.round(seconds / 60);
  if (minutes < 60) return `${plural(minutes, 'minute')} ago`;
  const hours = Math.round(minutes / 60);
  if (hours < 24) return `${plural(hours, 'hour')} ago`;
  const days = Math.round(hours / 24);
  if (days < 30) return `${plural(days, 'day')} ago`;
  const months = Math.round(days / 30);
  if (months < 12) return `${plural(months, 'month')} ago`;
  return `${plural(Math.round(months / 12), 'year')} ago`;
}

/** Percentage as a whole number, safe against divide-by-zero. */
export function percent(part: number, whole: number): number {
  if (whole <= 0) return 0;
  return clamp(Math.round((part / whole) * 100), 0, 100);
}

/** A stable, human-readable certificate serial. */
export function certificateSerial(userId: string, issuedAt: Date): string {
  const year = issuedAt.getUTCFullYear();
  const short = userId.replace(/-/g, '').slice(0, 8).toUpperCase();
  return `HH-${year}-${short}`;
}

/** Title-cases a slug for display, e.g. "responsive-images" → "Responsive images". */
export function humanise(slug: string): string {
  const words = slug.replace(/[-_]/g, ' ').trim();
  return words.charAt(0).toUpperCase() + words.slice(1);
}
