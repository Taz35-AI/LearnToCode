/**
 * Preview isolation.
 *
 * Learner-authored HTML is rendered inside an iframe with `sandbox=""` — no
 * `allow-scripts`, no `allow-same-origin`, no `allow-forms`. That alone stops
 * every script from executing, and it is the boundary this application relies
 * on. Nothing below is load-bearing for security on its own.
 *
 * The sanitiser exists for three further reasons:
 *
 *   1. Defence in depth. If a future change ever loosened the sandbox, script
 *      content would still have been removed before it got there.
 *   2. Honest feedback. A learner who writes an `onclick` should see it
 *      visibly disabled with an explanation, not silently ignored.
 *   3. Offline integrity. Remote URLs are rejected so lessons work with no
 *      network and learners do not get into the habit of hotlinking.
 */

const REMOVED_ELEMENTS = ['script', 'noscript', 'object', 'embed', 'applet', 'base'];

export interface SanitiseResult {
  html: string;
  /** Notes to show beside the preview, so nothing is removed invisibly. */
  notices: string[];
}

/** Strips an entire element including its contents. */
function stripElement(html: string, tag: string): { html: string; count: number } {
  let count = 0;
  const paired = new RegExp(`<${tag}\\b[^>]*>[\\s\\S]*?<\\/${tag}\\s*>`, 'gi');
  let out = html.replace(paired, () => {
    count += 1;
    return '';
  });
  const solo = new RegExp(`<${tag}\\b[^>]*\\/?>`, 'gi');
  out = out.replace(solo, () => {
    count += 1;
    return '';
  });
  return { html: out, count };
}

/**
 * Removes executable content from learner markup.
 *
 * Kept deliberately conservative: it removes only what could execute, and
 * leaves every structural element the course teaches — including `<iframe>`,
 * which Level 4 covers, because the outer sandbox already contains it and a
 * nested frame inherits the parent's restrictions.
 */
export function sanitiseForPreview(html: string): SanitiseResult {
  const notices: string[] = [];
  let out = html;

  for (const tag of REMOVED_ELEMENTS) {
    const result = stripElement(out, tag);
    out = result.html;
    if (result.count > 0) {
      notices.push(
        tag === 'script'
          ? `${result.count} <script> element${result.count === 1 ? '' : 's'} removed — the preview does not run JavaScript.`
          : `${result.count} <${tag}> element${result.count === 1 ? '' : 's'} removed from the preview.`,
      );
    }
  }

  // Inline event handlers (onclick, onerror, onload, …).
  let handlerCount = 0;
  out = out.replace(
    /\son[a-z]+\s*=\s*(?:"[^"]*"|'[^']*'|[^\s>]+)/gi,
    () => {
      handlerCount += 1;
      return '';
    },
  );
  if (handlerCount > 0) {
    notices.push(
      `${handlerCount} inline event handler${handlerCount === 1 ? '' : 's'} removed. ` +
        'This course teaches HTML structure; behaviour belongs in JavaScript, which the preview will not run.',
    );
  }

  // javascript: and data:text/html URLs in href/src/action/formaction.
  let urlCount = 0;
  out = out.replace(
    /\s(href|src|action|formaction|xlink:href)\s*=\s*(["'])\s*(javascript:|data:text\/html)[^"']*\2/gi,
    (_match, attr: string) => {
      urlCount += 1;
      return ` ${attr}="#" data-blocked-url="true"`;
    },
  );
  if (urlCount > 0) {
    notices.push(`${urlCount} unsafe URL${urlCount === 1 ? '' : 's'} neutralised in the preview.`);
  }

  // Remote assets: lessons must work offline and must not hotlink.
  let remoteCount = 0;
  out = out.replace(
    /\s(src|srcset|href|poster)\s*=\s*(["'])(\s*(?:https?:)?\/\/[^"']*)\2/gi,
    (match, attr: string, _quote: string, value: string) => {
      // Stylesheet and canonical links are harmless and are taught in Level 9.
      if (attr.toLowerCase() === 'href' && /rel\s*=\s*["'](canonical|stylesheet)/i.test(match)) {
        return match;
      }
      remoteCount += 1;
      return ` data-remote-${attr}="${escapeAttribute(value.trim())}"`;
    },
  );
  if (remoteCount > 0) {
    notices.push(
      `${remoteCount} remote URL${remoteCount === 1 ? '' : 's'} blocked. ` +
        'Use the media library — everything this course teaches works from local files.',
    );
  }

  return { html: out, notices };
}

/**
 * The Content-Security-Policy injected into every preview document.
 * Belt and braces alongside the sandbox attribute.
 */
export const PREVIEW_CSP =
  "default-src 'none'; " +
  "img-src 'self' data:; " +
  "media-src 'self'; " +
  "style-src 'unsafe-inline'; " +
  "font-src 'self'; " +
  "frame-src 'none'; " +
  "script-src 'none'; " +
  "form-action 'none'; " +
  "base-uri 'none'";

export interface BuildPreviewOptions {
  /** Injects the platform's presentation stylesheet, clearly separated from learner HTML. */
  withStarterStyles?: boolean;
  /** Follows the platform theme so the preview does not flash white in dark mode. */
  theme?: 'light' | 'dark';
  /** Origin used to resolve `/learning-media/...` paths inside the iframe. */
  baseHref?: string;
}

/**
 * Wraps learner markup into a complete, sandboxed preview document.
 *
 * When the learner has written a full document (their own `<html>` or
 * `<!DOCTYPE>`), their document is used as-is and the platform's styles are
 * injected into it. Otherwise a minimal host document is built around the
 * fragment. Either way the learner's structure is preserved exactly — the
 * platform only ever adds presentation, never markup.
 */
export function buildPreviewDocument(
  learnerHtml: string,
  options: BuildPreviewOptions = {},
): SanitiseResult {
  const { withStarterStyles = true, theme = 'light', baseHref } = options;
  const { html, notices } = sanitiseForPreview(learnerHtml);

  const head = [
    `<meta charset="utf-8">`,
    `<meta name="viewport" content="width=device-width, initial-scale=1">`,
    `<meta http-equiv="Content-Security-Policy" content="${PREVIEW_CSP}">`,
    baseHref ? `<base href="${escapeAttribute(baseHref)}">` : '',
    withStarterStyles ? `<style data-html-hero="preview-styles">${previewStylesheet(theme)}</style>` : '',
  ]
    .filter(Boolean)
    .join('\n    ');

  const isFullDocument = /<html[\s>]/i.test(html) || /<!doctype/i.test(html);

  if (isFullDocument) {
    // Inject into the learner's own <head>, or create one if they omitted it.
    if (/<head[\s>]/i.test(html)) {
      return { html: html.replace(/<head([^>]*)>/i, `<head$1>\n    ${head}`), notices };
    }
    if (/<html[^>]*>/i.test(html)) {
      return { html: html.replace(/<html([^>]*)>/i, `<html$1>\n  <head>\n    ${head}\n  </head>`), notices };
    }
  }

  const document = `<!DOCTYPE html>
<html lang="en" data-preview-theme="${theme}">
  <head>
    ${head}
    <title>Preview</title>
  </head>
  <body>
${html}
  </body>
</html>`;

  return { html: document, notices };
}

function escapeAttribute(value: string): string {
  return value.replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/</g, '&lt;');
}

/**
 * The platform's starter stylesheet for previews.
 *
 * This is presentation supplied by HTML Hero, NOT something the learner wrote,
 * and the interface says so beside every preview. It exists so a beginner can
 * see their structure rendered attractively without needing to know any CSS.
 * Level 10 explains how the two layers relate.
 */
export function previewStylesheet(theme: 'light' | 'dark' = 'light'): string {
  const dark = theme === 'dark';
  const ink = dark ? '#e7ecf3' : '#16202e';
  const muted = dark ? '#9fb0c4' : '#5a6a7d';
  const bg = dark ? '#0f151d' : '#ffffff';
  const surface = dark ? '#161e29' : '#f6f8fb';
  const border = dark ? '#28323f' : '#dde3ec';
  const accent = dark ? '#7cb0ff' : '#1d4ed8';

  return `
*, *::before, *::after { box-sizing: border-box; }
:root { color-scheme: ${dark ? 'dark' : 'light'}; }
html { -webkit-text-size-adjust: 100%; }
body {
  margin: 0;
  padding: 1.75rem;
  background: ${bg};
  color: ${ink};
  font: 16px/1.65 ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
  max-width: 68rem;
}
h1, h2, h3, h4, h5, h6 { line-height: 1.22; margin: 1.6em 0 0.5em; font-weight: 650; text-wrap: balance; }
h1 { font-size: 2.1rem; margin-top: 0; letter-spacing: -0.02em; }
h2 { font-size: 1.55rem; letter-spacing: -0.01em; }
h3 { font-size: 1.24rem; }
h4 { font-size: 1.06rem; }
h5, h6 { font-size: 0.96rem; text-transform: uppercase; letter-spacing: 0.06em; color: ${muted}; }
p { margin: 0 0 1em; max-width: 68ch; }
a { color: ${accent}; text-underline-offset: 0.18em; }
a:focus-visible, button:focus-visible, input:focus-visible, select:focus-visible,
textarea:focus-visible, summary:focus-visible, [tabindex]:focus-visible {
  outline: 3px solid ${accent}; outline-offset: 2px; border-radius: 3px;
}
img, video, svg { max-width: 100%; height: auto; }
img, video { border-radius: 8px; }
figure { margin: 1.5rem 0; }
figcaption { color: ${muted}; font-size: 0.9rem; margin-top: 0.5rem; }
ul, ol { padding-left: 1.4rem; margin: 0 0 1em; }
li { margin-bottom: 0.35em; }
dl { margin: 0 0 1em; } dt { font-weight: 650; } dd { margin: 0 0 0.75em 1.1rem; color: ${muted}; }
blockquote {
  margin: 1.5rem 0; padding: 0.5rem 0 0.5rem 1.15rem;
  border-left: 4px solid ${accent}; color: ${muted}; font-style: italic;
}
hr { border: 0; border-top: 1px solid ${border}; margin: 2rem 0; }
code, kbd, samp { font-family: ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace; font-size: 0.9em; }
code { background: ${surface}; padding: 0.15em 0.36em; border-radius: 4px; }
pre { background: ${surface}; border: 1px solid ${border}; border-radius: 10px; padding: 1rem; overflow-x: auto; }
pre code { background: none; padding: 0; }
mark { background: ${dark ? '#4a3f12' : '#fff3c4'}; color: inherit; padding: 0.05em 0.2em; border-radius: 3px; }
abbr[title] { text-decoration: underline dotted; cursor: help; }
table { border-collapse: collapse; width: 100%; margin: 1.5rem 0; font-size: 0.95rem; }
caption { text-align: left; font-weight: 650; padding-bottom: 0.6rem; color: ${muted}; }
th, td { border: 1px solid ${border}; padding: 0.6rem 0.75rem; text-align: left; vertical-align: top; }
thead th { background: ${surface}; }
tfoot { background: ${surface}; font-weight: 650; }
header, nav, main, section, article, aside, footer { display: block; }
nav ul { list-style: none; padding: 0; display: flex; flex-wrap: wrap; gap: 1rem; }
form { max-width: 34rem; }
fieldset { border: 1px solid ${border}; border-radius: 10px; padding: 1rem 1.15rem; margin: 0 0 1.25rem; }
legend { padding: 0 0.4rem; font-weight: 650; }
label { display: block; font-weight: 550; margin-bottom: 0.3rem; }
input, select, textarea {
  font: inherit; width: 100%; padding: 0.55rem 0.7rem; margin-bottom: 1rem;
  border: 1px solid ${border}; border-radius: 8px; background: ${bg}; color: ${ink};
}
input[type="checkbox"], input[type="radio"] { width: auto; margin: 0 0.5rem 0 0; }
button, input[type="submit"], input[type="button"] {
  font: inherit; width: auto; cursor: pointer; padding: 0.6rem 1.15rem;
  border: 0; border-radius: 8px; background: ${accent}; color: #fff; font-weight: 600;
}
details { border: 1px solid ${border}; border-radius: 10px; padding: 0.85rem 1rem; margin-bottom: 0.75rem; }
summary { cursor: pointer; font-weight: 600; }
progress, meter { width: 100%; height: 0.9rem; margin-bottom: 1rem; }
dialog { border: 1px solid ${border}; border-radius: 12px; padding: 1.25rem; color: ${ink}; background: ${bg}; }
iframe { max-width: 100%; border: 1px solid ${border}; border-radius: 10px; }
[data-blocked-url] { text-decoration: line-through; opacity: 0.6; }
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after { animation-duration: 0.01ms !important; transition-duration: 0.01ms !important; }
}
`.trim();
}
