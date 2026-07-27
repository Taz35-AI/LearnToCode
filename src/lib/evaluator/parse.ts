import { parse, type HTMLElement } from 'node-html-parser';

/**
 * HTML parsing helpers shared by the evaluator and the preview sanitiser.
 *
 * Two passes are used deliberately:
 *
 *  - The DOM pass (`parseDocument`) answers structural questions: which
 *    elements exist, how they nest, what attributes they carry. Parsers repair
 *    broken markup, which is exactly what a browser does, so this pass reflects
 *    what the learner would actually see.
 *
 *  - The source pass (`scanSource`) reads the raw text to catch problems the
 *    DOM has already silently repaired — an unclosed tag, a stray `</div>`, a
 *    mis-typed attribute quote. Those are the mistakes beginners make most, and
 *    they would otherwise be invisible.
 */

export const VOID_ELEMENTS = new Set([
  'area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'link',
  'meta', 'param', 'source', 'track', 'wbr',
]);

/** Elements removed from, or never part of, the modern HTML standard. */
export const DEPRECATED_ELEMENTS = new Set([
  'acronym', 'applet', 'basefont', 'big', 'blink', 'center', 'dir', 'font',
  'frame', 'frameset', 'isindex', 'marquee', 'menuitem', 'nobr', 'noframes',
  'plaintext', 'spacer', 'strike', 'tt',
]);

/** Elements whose content must never be treated as markup. */
export const RAW_TEXT_ELEMENTS = new Set(['script', 'style', 'textarea', 'title']);

export interface ParsedDocument {
  root: HTMLElement;
  /** Lowercased tag names present anywhere in the document. */
  tagNames: Set<string>;
  raw: string;
}

export function parseDocument(html: string): ParsedDocument {
  const root = parse(html, {
    lowerCaseTagName: true,
    comment: true,
    voidTag: { closingSlash: true },
    blockTextElements: { script: true, noscript: true, style: true, pre: true },
  });

  const tagNames = new Set<string>();
  const walk = (node: HTMLElement) => {
    if (node.rawTagName) tagNames.add(node.rawTagName.toLowerCase());
    for (const child of node.childNodes) {
      if ((child as HTMLElement).rawTagName !== undefined) walk(child as HTMLElement);
    }
  };
  walk(root);

  return { root, tagNames, raw: html };
}

/** `querySelectorAll` that never throws on a malformed selector. */
export function safeQueryAll(root: HTMLElement, selector: string): HTMLElement[] {
  try {
    return root.querySelectorAll(selector) as unknown as HTMLElement[];
  } catch {
    return [];
  }
}

export function safeQuery(root: HTMLElement, selector: string): HTMLElement | null {
  const found = safeQueryAll(root, selector);
  return found[0] ?? null;
}

/** Visible text with runs of whitespace collapsed. */
export function textOf(el: HTMLElement): string {
  return el.text.replace(/\s+/g, ' ').trim();
}

export interface SourceToken {
  tag: string;
  kind: 'open' | 'close' | 'self';
  line: number;
  index: number;
}

export interface SourceScan {
  tokens: SourceToken[];
  /** Tags opened but never closed, in source order. */
  unclosed: SourceToken[];
  /** Closing tags with no matching opening tag. */
  stray: SourceToken[];
  /** Tags closed in the wrong order, e.g. `<b><i></b></i>`. */
  misnested: { tag: string; expected: string; line: number }[];
  hasDoctype: boolean;
  /** Attribute values that were opened with a quote but never closed. */
  unterminatedAttributes: { line: number; snippet: string }[];
  /**
   * Places where a browser had to auto-close an element to make the markup
   * legal — for example a `<div>` opened inside a `<p>`.
   */
  autoClosed: { parent: string; child: string; line: number }[];
}

/**
 * Elements that a browser auto-closes when certain other elements open inside
 * them. The DOM therefore never shows the invalid nesting — the repair has
 * already happened — so it has to be caught here, in the source.
 */
const AUTO_CLOSING_PARENTS: Record<string, Set<string>> = {
  p: new Set([
    'address', 'article', 'aside', 'blockquote', 'div', 'dl', 'fieldset',
    'figcaption', 'figure', 'footer', 'form', 'h1', 'h2', 'h3', 'h4', 'h5',
    'h6', 'header', 'hr', 'main', 'nav', 'ol', 'p', 'pre', 'section', 'table', 'ul',
  ]),
};

interface RawTag {
  /** Lowercased element name. */
  name: string;
  isClosing: boolean;
  selfClosed: boolean;
  index: number;
  /** True when the tag was never terminated by a `>` outside quotes. */
  unterminated: boolean;
  raw: string;
}

/**
 * Tokenises tags by hand rather than with a single regular expression.
 *
 * A regex cannot both respect quoting *and* report a tag whose quote is never
 * closed — the pattern simply fails to match, and the mistake disappears. Since
 * an unterminated attribute quote is one of the most confusing beginner errors
 * (it silently swallows the rest of the line), it is worth scanning properly.
 */
function tokeniseTags(source: string): RawTag[] {
  const tags: RawTag[] = [];
  let i = 0;

  while (i < source.length) {
    if (source[i] !== '<') {
      i += 1;
      continue;
    }

    const start = i;
    let cursor = i + 1;
    const isClosing = source[cursor] === '/';
    if (isClosing) cursor += 1;

    // A tag name must start with a letter; anything else is literal text.
    if (!/[a-zA-Z]/.test(source[cursor] ?? '')) {
      i += 1;
      continue;
    }

    let name = '';
    while (cursor < source.length && /[a-zA-Z0-9-]/.test(source[cursor] ?? '')) {
      name += source[cursor];
      cursor += 1;
    }

    // Walk to the closing `>`, tracking quote state.
    let quote: string | null = null;
    let terminated = false;
    let selfClosed = false;

    while (cursor < source.length) {
      const char = source[cursor];

      if (quote) {
        if (char === quote) quote = null;
        // A `<` inside an unclosed quote means the quote was never closed and
        // we have run into the next tag: stop and report it.
        else if (char === '<') break;
        cursor += 1;
        continue;
      }

      if (char === '"' || char === "'") {
        quote = char;
        cursor += 1;
        continue;
      }
      if (char === '>') {
        selfClosed = source[cursor - 1] === '/';
        terminated = true;
        cursor += 1;
        break;
      }
      if (char === '<') break;
      cursor += 1;
    }

    tags.push({
      name: name.toLowerCase(),
      isClosing,
      selfClosed,
      index: start,
      unterminated: !terminated,
      raw: source.slice(start, Math.min(cursor, start + 80)),
    });

    i = Math.max(cursor, start + 1);
  }

  return tags;
}

function lineOf(source: string, index: number): number {
  let line = 1;
  for (let i = 0; i < index && i < source.length; i += 1) {
    if (source.charCodeAt(i) === 10) line += 1;
  }
  return line;
}

/**
 * Reads the raw source for balance problems a DOM parser would quietly fix.
 * Content inside `<script>`, `<style>`, `<textarea>`, comments and CDATA is
 * skipped so that markup written *about* HTML is not mistaken for markup.
 */
export function scanSource(source: string): SourceScan {
  const scan: SourceScan = {
    tokens: [],
    unclosed: [],
    stray: [],
    misnested: [],
    hasDoctype: /^\s*<!doctype\s+html\s*>/i.test(source),
    unterminatedAttributes: [],
    autoClosed: [],
  };

  // Blank out regions whose contents are not markup, preserving offsets.
  let working = source.replace(/<!--[\s\S]*?-->/g, (m) => ' '.repeat(m.length));
  for (const tag of RAW_TEXT_ELEMENTS) {
    const re = new RegExp(`(<${tag}\\b[^>]*>)([\\s\\S]*?)(</${tag}\\s*>)`, 'gi');
    working = working.replace(re, (_m, open: string, body: string, close: string) =>
      open + ' '.repeat(body.length) + close,
    );
  }

  const stack: SourceToken[] = [];

  for (const tag of tokeniseTags(working)) {
    const line = lineOf(source, tag.index);

    if (tag.unterminated) {
      scan.unterminatedAttributes.push({ line, snippet: tag.raw.replace(/\s+/g, ' ').slice(0, 60) });
      continue;
    }

    if (VOID_ELEMENTS.has(tag.name) || tag.selfClosed) {
      scan.tokens.push({ tag: tag.name, kind: 'self', line, index: tag.index });
      // A void element can still auto-close an open <p>: <p>text<hr> is invalid.
      closeAutoClosingParents(scan, stack, tag.name, line);
      continue;
    }

    if (tag.isClosing) {
      const token: SourceToken = { tag: tag.name, kind: 'close', line, index: tag.index };
      scan.tokens.push(token);

      const top = stack[stack.length - 1];
      if (!top) {
        scan.stray.push(token);
      } else if (top.tag === tag.name) {
        stack.pop();
      } else {
        // Find the most recent matching open tag, longhand rather than with
        // findLastIndex, which needs a newer lib target than we compile to.
        let depth = -1;
        for (let i = stack.length - 1; i >= 0; i -= 1) {
          if (stack[i]?.tag === tag.name) {
            depth = i;
            break;
          }
        }
        if (depth === -1) {
          scan.stray.push(token);
        } else {
          scan.misnested.push({ tag: tag.name, expected: top.tag, line });
          for (let i = stack.length - 1; i > depth; i -= 1) {
            const orphan = stack[i];
            if (orphan) scan.unclosed.push(orphan);
          }
          stack.length = depth;
        }
      }
      continue;
    }

    closeAutoClosingParents(scan, stack, tag.name, line);

    const token: SourceToken = { tag: tag.name, kind: 'open', line, index: tag.index };
    scan.tokens.push(token);
    stack.push(token);
  }

  scan.unclosed.push(...stack);
  scan.unclosed.sort((a, b) => a.index - b.index);
  return scan;
}

/**
 * Records the invalid nesting a browser silently repairs by auto-closing.
 *
 * Writing `<p>Text<div>Block</div></p>` makes a browser close the paragraph
 * before the div, so by the time the DOM exists the mistake is invisible. It is
 * still a mistake — the learner's intended structure is not what they got — so
 * it is reported here, from the source, where the evidence survives.
 */
function closeAutoClosingParents(
  scan: SourceScan,
  stack: SourceToken[],
  openingTag: string,
  line: number,
): void {
  const top = stack[stack.length - 1];
  if (!top) return;
  if (AUTO_CLOSING_PARENTS[top.tag]?.has(openingTag)) {
    scan.autoClosed.push({ parent: top.tag, child: openingTag, line });
    stack.pop();
  }
}

/** Collects every `id` value in the document, in order. */
export function collectIds(root: HTMLElement): string[] {
  return safeQueryAll(root, '[id]')
    .map((el) => el.getAttribute('id') ?? '')
    .filter((v) => v.length > 0);
}

/** Heading elements in document order, paired with their level. */
export function collectHeadings(root: HTMLElement): { level: number; text: string }[] {
  return safeQueryAll(root, 'h1, h2, h3, h4, h5, h6').map((el) => ({
    level: Number.parseInt(el.rawTagName.slice(1), 10),
    text: textOf(el),
  }));
}
