import type { HTMLElement } from 'node-html-parser';
import { safeQueryAll, textOf } from './parse';

/**
 * A pragmatic accessible-name computation.
 *
 * This is not a full implementation of the Accessible Name and Description
 * Computation specification — that requires a live DOM and a full CSS cascade.
 * It covers the cases an HTML course actually teaches, in specification order:
 *
 *   1. aria-labelledby   (points at other elements by id)
 *   2. aria-label        (a literal string)
 *   3. native host-language labelling
 *        · <img alt>, <area alt>, <input type=image alt>
 *        · <label for> or a wrapping <label>
 *        · <fieldset><legend>
 *        · <table><caption>
 *        · <svg><title>, <iframe title>
 *        · <input type=button|submit|reset value>
 *   4. the element's own text content
 *   5. the title attribute, as a last resort
 */
export function accessibleName(el: HTMLElement, root: HTMLElement): string {
  const tag = el.rawTagName?.toLowerCase() ?? '';

  const labelledBy = el.getAttribute('aria-labelledby');
  if (labelledBy) {
    const parts = labelledBy
      .split(/\s+/)
      .filter(Boolean)
      .map((id) => {
        const target = safeQueryAll(root, `#${cssEscape(id)}`)[0];
        return target ? textOf(target) : '';
      })
      .filter(Boolean);
    if (parts.length > 0) return parts.join(' ');
  }

  const ariaLabel = el.getAttribute('aria-label');
  if (ariaLabel && ariaLabel.trim()) return ariaLabel.trim();

  if (tag === 'img' || tag === 'area') {
    const alt = el.getAttribute('alt');
    // An explicitly empty alt is a *decision*, not a missing name: it marks the
    // image as decorative. Callers distinguish the two via `hasAltAttribute`.
    return alt?.trim() ?? '';
  }

  if (tag === 'input') {
    const type = (el.getAttribute('type') ?? 'text').toLowerCase();
    if (type === 'image') {
      const alt = el.getAttribute('alt');
      if (alt?.trim()) return alt.trim();
    }
    if (['button', 'submit', 'reset'].includes(type)) {
      const value = el.getAttribute('value');
      if (value?.trim()) return value.trim();
      if (type === 'submit') return 'Submit';
      if (type === 'reset') return 'Reset';
    }
  }

  if (['input', 'select', 'textarea', 'meter', 'progress', 'output'].includes(tag)) {
    const fromLabel = labelTextFor(el, root);
    if (fromLabel) return fromLabel;
  }

  if (tag === 'fieldset') {
    const legend = el.querySelector('legend');
    if (legend) return textOf(legend);
  }

  if (tag === 'table') {
    const caption = el.querySelector('caption');
    if (caption) return textOf(caption);
  }

  if (tag === 'svg') {
    const title = el.querySelector('title');
    if (title) return textOf(title);
  }

  if (tag === 'iframe') {
    const title = el.getAttribute('title');
    if (title?.trim()) return title.trim();
  }

  if (tag === 'figure') {
    const caption = el.querySelector('figcaption');
    if (caption) return textOf(caption);
  }

  // Elements whose name comes from their contents.
  if (!['input', 'select', 'textarea', 'img', 'area', 'iframe'].includes(tag)) {
    const own = textOf(el);
    if (own) return own;
  }

  const title = el.getAttribute('title');
  return title?.trim() ?? '';
}

/** True when an `<img>` carries an `alt` attribute at all (even an empty one). */
export function hasAltAttribute(el: HTMLElement): boolean {
  return el.getAttribute('alt') !== undefined;
}

/** Finds the `<label>` text associated with a form control, if any. */
export function labelTextFor(el: HTMLElement, root: HTMLElement): string {
  const id = el.getAttribute('id');
  if (id) {
    const explicit = safeQueryAll(root, 'label').find(
      (label) => label.getAttribute('for') === id,
    );
    if (explicit) {
      const text = textOf(explicit);
      if (text) return text;
    }
  }

  // A wrapping <label> also labels the control it contains.
  let parent = el.parentNode as HTMLElement | null;
  while (parent) {
    if (parent.rawTagName?.toLowerCase() === 'label') {
      const text = textOf(parent);
      if (text) return text;
    }
    parent = parent.parentNode as HTMLElement | null;
  }

  return '';
}

/**
 * Alt text that technically exists but tells a screen-reader user nothing.
 * These are the phrases beginners reach for first, so the course names them
 * explicitly rather than just saying "write better alt text".
 */
const UNHELPFUL_ALT = [
  'image', 'img', 'picture', 'photo', 'photograph', 'graphic', 'icon', 'logo',
  'placeholder', 'untitled', 'alt', 'alt text', 'spacer', 'banner', 'thumbnail',
  'screenshot', 'pic',
];

export interface AltQuality {
  ok: boolean;
  reason: string;
}

/** Judges whether alt text is likely to be genuinely descriptive. */
export function assessAltText(alt: string): AltQuality {
  const value = alt.trim();

  if (value.length === 0) {
    return { ok: false, reason: 'the alt text is empty' };
  }
  if (/\.(jpe?g|png|gif|webp|svg|avif)$/i.test(value)) {
    return { ok: false, reason: 'the alt text is a file name rather than a description' };
  }
  const normalised = value.toLowerCase().replace(/[^a-z\s]/g, '').trim();
  if (UNHELPFUL_ALT.includes(normalised)) {
    return {
      ok: false,
      reason: `"${value}" only repeats that this is an image — describe what the image shows`,
    };
  }
  if (/^(image|picture|photo|graphic|icon) of\b/i.test(value)) {
    return {
      ok: false,
      reason: 'a screen reader already announces "image", so "image of…" is repeated twice',
    };
  }
  if (value.length < 8) {
    return { ok: false, reason: 'the alt text is too short to describe the image' };
  }
  if (value.length > 250) {
    return {
      ok: false,
      reason: 'the alt text is very long — keep it to one useful sentence and put detail in the page',
    };
  }
  return { ok: true, reason: 'the alt text describes the image' };
}

/** Escapes a value for safe use inside an attribute or id selector. */
function cssEscape(value: string): string {
  return value.replace(/["\\\][)(}{><~+*^$|=!:,;'`# ]/g, (c) => `\\${c}`);
}
