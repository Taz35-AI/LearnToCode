import { parseDocument, safeQuery, safeQueryAll, textOf } from '@/lib/evaluator/parse';
import { collectHeadings, collectIds } from '@/lib/evaluator/parse';
import { assessAltText, hasAltAttribute } from '@/lib/evaluator/accessible-name';
import { mediaPathExists } from '@/lib/evaluator/media-index';

/**
 * The capstone checklist.
 *
 * The same structural analysis the exercise evaluator uses, applied across
 * every page of the learner's project at once. This is the requirement list
 * from Level 12, checked live rather than described.
 */

export interface ChecklistResult {
  label: string;
  met: boolean;
  detail: string;
}

export interface ProjectPage {
  path: string;
  content: string;
}

/**
 * Elements that only appear once a page has real content in it. A seeded page
 * has a heading and a sentence; a written one has sections, lists, images,
 * tables, figures or a form.
 */
const CONTENT_ELEMENTS = new Set([
  'section', 'article', 'aside', 'figure', 'img', 'picture', 'video', 'audio',
  'table', 'form', 'ul', 'ol', 'dl', 'blockquote', 'iframe', 'details',
]);

/** Visible characters the main region needs before the page reads as written. */
export const SUBSTANTIAL_PAGE_TEXT_CHARS = 200;

/**
 * True when a project page carries the learner's own work rather than the stub
 * onboarding seeded.
 *
 * Counting pages that *exist* would be meaningless: every page of the chosen
 * project is created during onboarding so the learner has somewhere to work, so
 * the count is at its maximum from the first minute. Counting characters is no
 * better — the starter page is already ~600 of them. What actually distinguishes
 * a written page is structure the starter does not have, so that is what both
 * project completion and the five-page achievement measure.
 */
export function isSubstantialPage(content: string): boolean {
  const { root } = parseDocument(content);
  const main = safeQuery(root, 'main') ?? safeQuery(root, 'body') ?? root;

  const hasContentElement = safeQueryAll(main, '*').some((el) =>
    CONTENT_ELEMENTS.has(el.rawTagName?.toLowerCase() ?? ''),
  );

  return hasContentElement && textOf(main).length >= SUBSTANTIAL_PAGE_TEXT_CHARS;
}

export function buildCapstoneChecklist(pages: ProjectPage[]): ChecklistResult[] {
  const htmlPages = pages.filter((page) => page.path.endsWith('.html'));
  const docs = htmlPages.map((page) => ({ page, doc: parseDocument(page.content) }));

  const any = (test: (doc: ReturnType<typeof parseDocument>) => boolean) =>
    docs.some(({ doc }) => test(doc));
  const all = (test: (doc: ReturnType<typeof parseDocument>) => boolean) =>
    docs.length > 0 && docs.every(({ doc }) => test(doc));

  const pagesFailing = (test: (doc: ReturnType<typeof parseDocument>) => boolean) =>
    docs.filter(({ doc }) => !test(doc)).map(({ page }) => page.path);

  const results: ChecklistResult[] = [];

  const check = (
    label: string,
    test: (doc: ReturnType<typeof parseDocument>) => boolean,
    detail: string,
    mode: 'any' | 'all' = 'all',
  ) => {
    const met = mode === 'all' ? all(test) : any(test);
    const failing = mode === 'all' ? pagesFailing(test) : [];
    results.push({
      label,
      met,
      detail:
        failing.length > 0
          ? `${detail} Missing on: ${failing.slice(0, 3).join(', ')}${failing.length > 3 ? '…' : ''}`
          : detail,
    });
  };

  results.push({
    label: 'At least five pages',
    met: htmlPages.length >= 5,
    detail: `You have ${htmlPages.length}. The capstone needs a homepage, an about page, a page for what you offer, a contact page and one more.`,
  });

  check(
    'Every page has a doctype and lang',
    (doc) =>
      /^\s*<!doctype\s+html\s*>/i.test(doc.raw) &&
      safeQueryAll(doc.root, 'html[lang]').length > 0,
    'Start each page with <!DOCTYPE html> and give <html> a lang attribute.',
  );

  check(
    'Every page has a unique title and description',
    (doc) =>
      safeQueryAll(doc.root, 'title').length === 1 &&
      safeQueryAll(doc.root, 'meta[name="description"]').length > 0,
    'Each page needs its own <title> and <meta name="description">.',
  );

  // Titles must differ from each other, not merely exist.
  const titles = docs
    .map(({ doc }) => safeQueryAll(doc.root, 'title')[0]?.text.trim() ?? '')
    .filter(Boolean);
  results.push({
    label: 'No two pages share a title',
    met: titles.length > 0 && new Set(titles).size === titles.length,
    detail: 'Duplicate titles make tabs, bookmarks and search results indistinguishable.',
  });

  check(
    'Consistent navigation on every page',
    (doc) => safeQueryAll(doc.root, 'nav a').length >= 3,
    'Every page needs the same <nav> with links to the other pages.',
  );

  check(
    'A skip link on every page',
    (doc) => safeQueryAll(doc.root, 'a[href^="#"]').some((a) => /skip/i.test(a.text)),
    'Add a skip link as the first focusable element, pointing at your <main>.',
  );

  check(
    'Semantic landmarks on every page',
    (doc) =>
      safeQueryAll(doc.root, 'header').length > 0 &&
      safeQueryAll(doc.root, 'main').length === 1 &&
      safeQueryAll(doc.root, 'footer').length > 0,
    'Each page needs a <header>, exactly one <main> and a <footer>.',
  );

  check(
    'Correct heading hierarchy everywhere',
    (doc) => {
      const headings = collectHeadings(doc.root);
      if (headings.length === 0) return false;
      if (headings.filter((h) => h.level === 1).length !== 1) return false;
      if (headings[0]?.level !== 1) return false;
      return headings.every((heading, index) => {
        if (index === 0) return true;
        const previous = headings[index - 1];
        return !previous || heading.level <= previous.level + 1;
      });
    },
    'One <h1> per page, and no skipped levels going down.',
  );

  check(
    'Every id is unique',
    (doc) => {
      const ids = collectIds(doc.root);
      return new Set(ids).size === ids.length;
    },
    'Two elements can never share an id.',
  );

  results.push({
    label: 'A responsive image with srcset and sizes',
    met: any((doc) => safeQueryAll(doc.root, 'img[srcset][sizes]').length > 0),
    detail: 'Add a hero image offering several widths with srcset, plus a sizes attribute.',
  });

  results.push({
    label: 'A figure with a caption',
    met: any((doc) => safeQueryAll(doc.root, 'figure figcaption').length > 0),
    detail: 'Wrap at least one image in a <figure> with a <figcaption>.',
  });

  results.push({
    label: 'A video or audio element with captions or a transcript',
    met: any(
      (doc) =>
        safeQueryAll(doc.root, 'video track[kind="captions"]').length > 0 ||
        safeQueryAll(doc.root, 'audio').length > 0,
    ),
    detail: 'Add a <video> with a captions <track>, or an <audio> element with a transcript.',
  });

  results.push({
    label: 'A meaningful list',
    met: any((doc) => safeQueryAll(doc.root, 'ul li, ol li, dl dt').length >= 2),
    detail: 'Use a list where the content is genuinely a set or a sequence.',
  });

  results.push({
    label: 'An accessible table where the content warrants one',
    met: any(
      (doc) =>
        safeQueryAll(doc.root, 'table caption').length > 0 &&
        safeQueryAll(doc.root, 'th[scope]').length >= 2,
    ),
    detail: 'A data table needs a <caption> and <th> cells with scope attributes.',
  });

  results.push({
    label: 'An accessible form',
    met: any((doc) => {
      const controls = safeQueryAll(doc.root, 'input, select, textarea').filter((el) => {
        const type = (el.getAttribute('type') ?? '').toLowerCase();
        return !['hidden', 'submit', 'button', 'reset'].includes(type);
      });
      if (controls.length === 0) return false;
      const labels = safeQueryAll(doc.root, 'label[for]').map((l) => l.getAttribute('for'));
      return controls.every((control) => labels.includes(control.getAttribute('id') ?? ''));
    }),
    detail: 'Your contact page needs a form where every control has a <label for="…">.',
  });

  results.push({
    label: 'A native interactive element',
    met: any(
      (doc) =>
        safeQueryAll(doc.root, 'details summary').length > 0 ||
        safeQueryAll(doc.root, 'dialog').length > 0 ||
        safeQueryAll(doc.root, '[popover]').length > 0,
    ),
    detail: 'Add a <details> accordion, a <dialog>, or an element with the popover attribute.',
  });

  results.push({
    label: 'Social sharing metadata',
    met: any((doc) => safeQueryAll(doc.root, 'meta[property^="og:"]').length >= 3),
    detail: 'Add og:title, og:description, og:image and og:url to at least your homepage.',
  });

  results.push({
    label: 'Basic structured data',
    met: any(
      (doc) => safeQueryAll(doc.root, 'script[type="application/ld+json"]').length > 0,
    ),
    detail: 'Add a JSON-LD block describing what your site is.',
  });

  check(
    'A favicon linked from every page',
    (doc) => safeQueryAll(doc.root, 'link[rel~="icon"]').length > 0,
    'Add <link rel="icon" href="…"> to each page.',
  );

  // Media: every referenced path must resolve.
  const brokenMedia: string[] = [];
  for (const { page, doc } of docs) {
    for (const el of safeQueryAll(doc.root, 'img[src], source[src], video[poster], track[src], audio[src]')) {
      for (const attribute of ['src', 'poster'] as const) {
        const value = el.getAttribute(attribute);
        if (value && !mediaPathExists(value)) brokenMedia.push(`${page.path}: ${value}`);
      }
    }
  }
  results.push({
    label: 'No missing media',
    met: brokenMedia.length === 0,
    detail:
      brokenMedia.length > 0
        ? `Broken: ${brokenMedia.slice(0, 2).join(', ')}${brokenMedia.length > 2 ? '…' : ''}`
        : 'Every image, video and caption file resolves.',
  });

  // Alt text quality across the whole project.
  let altProblems = 0;
  for (const { doc } of docs) {
    for (const img of safeQueryAll(doc.root, 'img')) {
      if (!hasAltAttribute(img)) {
        altProblems += 1;
        continue;
      }
      const alt = img.getAttribute('alt') ?? '';
      if (alt.trim() && !assessAltText(alt).ok) altProblems += 1;
    }
  }
  results.push({
    label: 'Meaningful alt text on every image',
    met: altProblems === 0,
    detail:
      altProblems > 0
        ? `${altProblems} ${altProblems === 1 ? 'image needs' : 'images need'} better alt text.`
        : 'Every image is described, or correctly marked decorative.',
  });

  // Internal links must point at pages that exist.
  const pagePaths = new Set(htmlPages.map((page) => page.path));
  const brokenLinks: string[] = [];
  for (const { page, doc } of docs) {
    for (const link of safeQueryAll(doc.root, 'a[href]')) {
      const href = (link.getAttribute('href') ?? '').split('#')[0];
      if (!href) continue;
      if (/^(https?:|mailto:|tel:|\/)/i.test(href)) continue;
      if (!pagePaths.has(href)) brokenLinks.push(`${page.path} → ${href}`);
    }
  }
  results.push({
    label: 'No broken internal links',
    met: brokenLinks.length === 0,
    detail:
      brokenLinks.length > 0
        ? `Broken: ${brokenLinks.slice(0, 2).join(', ')}${brokenLinks.length > 2 ? '…' : ''}`
        : 'Every internal link points at a page that exists.',
  });

  return results;
}
