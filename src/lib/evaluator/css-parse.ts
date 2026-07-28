/**
 * A small CSS parser, built for grading rather than for rendering.
 *
 * ## Why this exists at all
 *
 * The HTML evaluator judges structure, and its central promise is that two
 * learners who write entirely different markup both pass if the structure is
 * right. CSS needs the same promise and it is harder to keep, because the same
 * visual result can be reached by genuinely different routes — `margin: 0 auto`
 * and a flex parent with `justify-content: center` both centre a box, and a
 * grader that looks for one string fails the learner who chose the other.
 *
 * So nothing here matches source text. The parser produces declarations, the
 * cascade module resolves which of them actually *apply* to a given element,
 * and requirements are then asked about the resolved value. A learner who
 * writes their rules in a different order, with different selectors, different
 * whitespace and different shorthand, is asked the only question that matters:
 * what did the browser end up with?
 *
 * ## What it deliberately does not do
 *
 * This is not a rendering engine and does not pretend to be one. It does not lay
 * anything out, so it cannot tell you the pixel position of a box. It resolves
 * the cascade, inheritance and custom properties — which is the part learners
 * get wrong and the part a course can meaningfully examine.
 */

/** One `property: value` pair, with the flag that outranks specificity. */
export interface Declaration {
  property: string;
  value: string;
  important: boolean;
}

export interface StyleRule {
  /** Each comma-separated selector, already trimmed. */
  selectors: string[];
  declarations: Declaration[];
  /** Source order, which breaks ties of equal specificity. */
  order: number;
  /** `@media` / `@supports` / `@container` conditions this rule sits inside. */
  conditions: AtRuleCondition[];
}

export interface AtRuleCondition {
  /** `media`, `supports`, `container`, `layer`, … */
  name: string;
  /** The raw prelude, e.g. `(min-width: 40rem)`. */
  query: string;
}

export interface ParsedStylesheet {
  rules: StyleRule[];
  /** At-rules with no block of declarations, such as `@import`. */
  statements: { name: string; prelude: string }[];
  /** Anything that could not be understood, reported rather than swallowed. */
  problems: string[];
}

/** Removes comments without disturbing the offsets of anything else. */
function stripComments(css: string): string {
  return css.replace(/\/\*[\s\S]*?\*\//g, (match) => ' '.repeat(match.length));
}

/**
 * Splits a declaration block into `property: value` pairs.
 *
 * Semicolons inside strings, parentheses and `url()` must not split — which is
 * why this is a scanner rather than a `split(';')`. `grid-template-areas`,
 * `font-family` and any `var()` fallback all contain characters that a naive
 * split gets wrong, and all three appear in this course.
 */
export function parseDeclarations(block: string): Declaration[] {
  const declarations: Declaration[] = [];
  let buffer = '';
  let depth = 0;
  let quote: string | null = null;

  const flush = () => {
    const text = buffer.trim();
    buffer = '';
    if (!text) return;

    const colon = findTopLevelColon(text);
    if (colon === -1) return;

    const property = text.slice(0, colon).trim().toLowerCase();
    let value = text.slice(colon + 1).trim();
    if (!property || !value) return;

    let important = false;
    const bang = /!\s*important\s*$/i;
    if (bang.test(value)) {
      important = true;
      value = value.replace(bang, '').trim();
    }

    declarations.push({ property, value, important });
  };

  for (const character of block) {
    if (quote) {
      buffer += character;
      if (character === quote) quote = null;
      continue;
    }
    if (character === '"' || character === "'") {
      quote = character;
      buffer += character;
      continue;
    }
    if (character === '(') depth += 1;
    if (character === ')') depth = Math.max(0, depth - 1);

    if (character === ';' && depth === 0) {
      flush();
      continue;
    }
    buffer += character;
  }
  flush();

  return declarations;
}

/** The first colon not inside parentheses — so `background: url(a:b)` is safe. */
function findTopLevelColon(text: string): number {
  let depth = 0;
  for (let i = 0; i < text.length; i += 1) {
    const character = text[i];
    if (character === '(') depth += 1;
    else if (character === ')') depth = Math.max(0, depth - 1);
    else if (character === ':' && depth === 0) return i;
  }
  return -1;
}

/**
 * Parses a stylesheet into flat rules, carrying their at-rule conditions.
 *
 * Nested at-rules are kept as a list on each rule rather than as a tree,
 * because every question this course asks is of the form "does this rule apply
 * under these conditions" — and a flat list answers that directly.
 */
export function parseStylesheet(css: string): ParsedStylesheet {
  const source = stripComments(css);
  const rules: StyleRule[] = [];
  const statements: { name: string; prelude: string }[] = [];
  const problems: string[] = [];

  let index = 0;
  let order = 0;

  const parseBlock = (conditions: AtRuleCondition[], end: number, nested: boolean): void => {
    let prelude = '';

    while (index < end) {
      const character = source[index] ?? '';

      if (character === '}') {
        index += 1;
        // Inside an at-rule this closes the block. At the top level it is a
        // stray brace, and returning here would silently discard the whole
        // rest of the stylesheet — so a learner with one extra `}` could have
        // every later rule ignored and still be told their CSS was fine.
        if (nested) return;
        problems.push('there is a closing brace with no matching rule');
        continue;
      }

      if (character === '{') {
        const close = matchBrace(source, index);
        if (close === -1) {
          problems.push('a rule is missing its closing brace');
          index = end;
          return;
        }

        const head = prelude.trim();
        prelude = '';

        if (head.startsWith('@')) {
          const space = head.search(/\s/);
          const name = (space === -1 ? head : head.slice(0, space)).slice(1).toLowerCase();
          const query = space === -1 ? '' : head.slice(space).trim();

          // Recurse into the block with this condition added.
          const inner = index + 1;
          const previous = index;
          index = inner;
          parseBlock([...conditions, { name, query }], close, true);
          if (index <= previous) index = close + 1;
          continue;
        }

        if (!head) {
          problems.push('a declaration block has no selector');
        } else {
          order += 1;
          rules.push({
            selectors: splitSelectors(head),
            declarations: parseDeclarations(source.slice(index + 1, close)),
            order,
            conditions,
          });
        }

        index = close + 1;
        continue;
      }

      if (character === ';' && prelude.trim().startsWith('@')) {
        const head = prelude.trim();
        const space = head.search(/\s/);
        statements.push({
          name: (space === -1 ? head : head.slice(0, space)).slice(1).toLowerCase(),
          prelude: space === -1 ? '' : head.slice(space).trim(),
        });
        prelude = '';
        index += 1;
        continue;
      }

      prelude += character;
      index += 1;
    }

    if (prelude.trim()) {
      problems.push(`"${prelude.trim().slice(0, 40)}" is not inside a rule`);
    }
  };

  parseBlock([], source.length, false);

  return { rules, statements, problems };
}

/**
 * The layer a rule sits in — dot-joined when layers are nested, and empty for
 * an unlayered rule.
 */
export function layerNameOf(rule: StyleRule): string {
  return rule.conditions
    .filter((condition) => condition.name === 'layer')
    .map((condition) => condition.query.trim() || 'anonymous')
    .join('.');
}

/**
 * The order cascade layers were declared in.
 *
 * `@layer reset, base, components;` establishes the order up front, which is
 * the whole point of the statement form — a layer's position must not depend on
 * where its rules happen to appear. Any layer met only as a block is appended
 * in first-appearance order, which is what a browser does with it.
 */
export function layerOrder(sheets: ParsedStylesheet[]): string[] {
  const order: string[] = [];
  const add = (name: string) => {
    const trimmed = name.trim();
    if (trimmed && !order.includes(trimmed)) order.push(trimmed);
  };

  for (const sheet of sheets) {
    for (const statement of sheet.statements) {
      if (statement.name !== 'layer') continue;
      for (const part of statement.prelude.split(',')) add(part);
    }
  }

  for (const sheet of sheets) {
    for (const rule of sheet.rules) add(layerNameOf(rule));
  }

  return order;
}

/** Index of the `}` matching the `{` at `open`, or -1. */
function matchBrace(source: string, open: number): number {
  let depth = 0;
  let quote: string | null = null;

  for (let i = open; i < source.length; i += 1) {
    const character = source[i];
    if (quote) {
      if (character === quote) quote = null;
      continue;
    }
    if (character === '"' || character === "'") {
      quote = character;
      continue;
    }
    if (character === '{') depth += 1;
    else if (character === '}') {
      depth -= 1;
      if (depth === 0) return i;
    }
  }
  return -1;
}

/** Splits `a, b > c` on commas that are not inside parentheses. */
export function splitSelectors(head: string): string[] {
  const parts: string[] = [];
  let buffer = '';
  let depth = 0;
  let quote: string | null = null;

  for (const character of head) {
    if (quote) {
      buffer += character;
      if (character === quote) quote = null;
      continue;
    }
    if (character === '"' || character === "'") {
      quote = character;
      buffer += character;
      continue;
    }
    if (character === '(' || character === '[') depth += 1;
    if (character === ')' || character === ']') depth = Math.max(0, depth - 1);

    if (character === ',' && depth === 0) {
      if (buffer.trim()) parts.push(buffer.trim());
      buffer = '';
      continue;
    }
    buffer += character;
  }
  if (buffer.trim()) parts.push(buffer.trim());
  return parts;
}

/**
 * Extracts every `<style>` block from an HTML document, in source order.
 *
 * Learners in this course write a single file with a `<style>` element, for the
 * same reason the HTML course previews a single file: it removes an entire
 * category of "my stylesheet is not loading" problems that teach nothing about
 * CSS.
 */
export function extractStyleSheets(html: string): string[] {
  const sheets: string[] = [];
  const pattern = /<style\b[^>]*>([\s\S]*?)<\/style>/gi;
  let match: RegExpExecArray | null;
  while ((match = pattern.exec(html)) !== null) {
    sheets.push(match[1] ?? '');
  }
  return sheets;
}

/**
 * Specificity as the three-part tuple the specification defines.
 *
 * Returned as a single comparable number using base 256 per component. A real
 * stylesheet never approaches 256 of anything in one selector, and collapsing
 * the tuple makes the cascade comparison a plain `>` — which is much harder to
 * get subtly wrong than a lexicographic comparison written out by hand.
 */
export function specificity(selector: string): number {
  // The parts of a selector that must not be counted as anything else.
  let working = selector
    // `:not()`, `:is()` and `:has()` take the specificity of their argument,
    // which is handled below; strip the wrapper so the inner text is counted.
    .replace(/:(?:not|is|has)\(/gi, '(')
    .replace(/::[a-zA-Z-]+/g, ' ELEMENT ')
    .replace(/:where\([^)]*\)/gi, '');

  let ids = 0;
  let classes = 0;
  let elements = 0;

  // Attribute selectors count as a class, and their contents must not be
  // scanned for anything else — `[href="#a"]` is not an id.
  working = working.replace(/\[[^\]]*\]/g, () => {
    classes += 1;
    return ' ';
  });

  ids += (working.match(/#[a-zA-Z0-9_-]+/g) ?? []).length;
  working = working.replace(/#[a-zA-Z0-9_-]+/g, ' ');

  classes += (working.match(/\.[a-zA-Z0-9_-]+/g) ?? []).length;
  working = working.replace(/\.[a-zA-Z0-9_-]+/g, ' ');

  // Remaining pseudo-classes count as a class.
  classes += (working.match(/:[a-zA-Z-]+(?:\([^)]*\))?/g) ?? []).length;
  working = working.replace(/:[a-zA-Z-]+(?:\([^)]*\))?/g, ' ');

  elements += (working.match(/ ELEMENT /g) ?? []).length;
  working = working.replace(/ ELEMENT /g, ' ');

  // What is left is type selectors; `*` and combinators contribute nothing.
  elements += (working.match(/[a-zA-Z][a-zA-Z0-9-]*/g) ?? []).length;

  return ids * 256 * 256 + classes * 256 + elements;
}
