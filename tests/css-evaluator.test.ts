import { describe, expect, it } from 'vitest';
import { parseDocument } from '@/lib/evaluator/parse';
import {
  extractStyleSheets,
  parseDeclarations,
  parseStylesheet,
  specificity,
  splitSelectors,
} from '@/lib/evaluator/css-parse';
import {
  ancestorsOf,
  normaliseValue,
  resolveStyles,
  substituteVariables,
} from '@/lib/evaluator/css-cascade';

/**
 * The CSS evaluator.
 *
 * Its central promise is the same one the HTML evaluator makes: two learners
 * who write genuinely different CSS both pass if the *result* is right. That
 * promise lives or dies on the cascade being resolved correctly, so most of
 * what follows is about which declaration wins and why.
 */

/** Resolves one element's styles from a complete HTML document. */
function resolve(html: string, selector: string, activeConditions: string[] = []) {
  const doc = parseDocument(html);
  const sheets = extractStyleSheets(html);
  const rules = sheets.flatMap((sheet) => parseStylesheet(sheet).rules);
  const element = doc.root.querySelector(selector);
  if (!element) throw new Error(`no element matched ${selector}`);
  return resolveStyles(element, rules, ancestorsOf(doc.root, element), { activeConditions });
}

/** The winning value of one property, with custom properties substituted. */
function valueOf(html: string, selector: string, property: string, conditions: string[] = []) {
  const resolved = resolve(html, selector, conditions);
  const declaration = resolved.get(property);
  if (!declaration) return undefined;
  return normaliseValue(substituteVariables(declaration.value, resolved));
}

describe('declaration parsing', () => {
  it('reads properties, values and the important flag', () => {
    expect(parseDeclarations('color: red; margin: 0 auto !important')).toEqual([
      { property: 'color', value: 'red', important: false },
      { property: 'margin', value: '0 auto', important: true },
    ]);
  });

  it('does not split on a semicolon inside a value', () => {
    // `content` and `url()` both legitimately contain semicolons and colons.
    const declarations = parseDeclarations('background: url(a.png?x=1;y=2); color: blue');
    expect(declarations).toHaveLength(2);
    expect(declarations[0]?.value).toBe('url(a.png?x=1;y=2)');
  });

  it('does not split on a colon inside parentheses', () => {
    const [declaration] = parseDeclarations('background-image: url(https://example.org/a.png)');
    expect(declaration?.property).toBe('background-image');
    expect(declaration?.value).toBe('url(https://example.org/a.png)');
  });

  it('keeps quoted values intact', () => {
    const [declaration] = parseDeclarations(`font-family: "Segoe UI", system-ui`);
    expect(declaration?.value).toBe(`"Segoe UI", system-ui`);
  });

  it('lowercases the property but preserves the value', () => {
    const [declaration] = parseDeclarations('COLOR: RebeccaPurple');
    expect(declaration?.property).toBe('color');
    expect(declaration?.value).toBe('RebeccaPurple');
  });
});

describe('stylesheet parsing', () => {
  it('splits selector lists without breaking on commas inside parentheses', () => {
    expect(splitSelectors('a, b > c')).toEqual(['a', 'b > c']);
    expect(splitSelectors(':is(h1, h2) span, p')).toEqual([':is(h1, h2) span', 'p']);
  });

  it('records source order, which is what breaks specificity ties', () => {
    const { rules } = parseStylesheet('p { color: red } p { color: blue }');
    expect(rules.map((rule) => rule.order)).toEqual([1, 2]);
  });

  it('carries at-rule conditions onto the rules inside them', () => {
    const { rules } = parseStylesheet(
      'p { color: red } @media (min-width: 40rem) { p { color: blue } }',
    );
    expect(rules[0]?.conditions).toEqual([]);
    expect(rules[1]?.conditions).toEqual([{ name: 'media', query: '(min-width: 40rem)' }]);
  });

  it('handles nested at-rules', () => {
    const { rules } = parseStylesheet(
      '@layer base { @media (min-width: 40rem) { p { color: blue } } }',
    );
    expect(rules[0]?.conditions.map((c) => c.name)).toEqual(['layer', 'media']);
  });

  it('strips comments without corrupting what follows', () => {
    const { rules } = parseStylesheet('/* a note */ p { color: red /* inline */ }');
    expect(rules[0]?.declarations[0]).toEqual({
      property: 'color',
      value: 'red',
      important: false,
    });
  });

  it('reports a missing brace rather than silently dropping the rule', () => {
    expect(parseStylesheet('p { color: red').problems.length).toBeGreaterThan(0);
  });

  it('extracts every style block in source order', () => {
    const sheets = extractStyleSheets('<style>a{color:red}</style><p></p><style>b{color:blue}</style>');
    expect(sheets).toEqual(['a{color:red}', 'b{color:blue}']);
  });
});

describe('specificity', () => {
  it('ranks id above class above type', () => {
    expect(specificity('#main')).toBeGreaterThan(specificity('.card'));
    expect(specificity('.card')).toBeGreaterThan(specificity('p'));
  });

  it('counts repeated components', () => {
    expect(specificity('.a.b')).toBeGreaterThan(specificity('.a'));
    expect(specificity('div p')).toBeGreaterThan(specificity('p'));
  });

  it('counts an attribute selector as a class, not an id', () => {
    expect(specificity('[href="#main"]')).toBe(specificity('.card'));
  });

  it('gives a pseudo-element the weight of a type selector', () => {
    expect(specificity('p::before')).toBe(specificity('p p'));
  });

  it('ignores :where(), as the specification requires', () => {
    expect(specificity(':where(.card) p')).toBe(specificity('p'));
  });

  it('a single id outranks any number of classes', () => {
    expect(specificity('#main')).toBeGreaterThan(specificity('.a.b.c.d.e.f.g.h.i.j'));
  });
});

describe('the cascade', () => {
  const page = (style: string, body = '<p class="intro" id="lead">Hello</p>') =>
    `<html><head><style>${style}</style></head><body><main class="wrap">${body}</main></body></html>`;

  it('lets the more specific selector win regardless of order', () => {
    expect(valueOf(page('.intro { color: blue } p { color: red }'), 'p', 'color')).toBe('blue');
  });

  it('breaks a specificity tie by source order', () => {
    expect(valueOf(page('p { color: red } p { color: blue }'), 'p', 'color')).toBe('blue');
  });

  it('lets !important beat higher specificity', () => {
    expect(valueOf(page('#lead { color: blue } p { color: red !important }'), 'p', 'color')).toBe(
      'red',
    );
  });

  it('lets an inline style beat any selector', () => {
    const html = page('#lead { color: blue }', '<p class="intro" id="lead" style="color: green">Hi</p>');
    expect(valueOf(html, 'p', 'color')).toBe('green');
  });

  it('lets !important in a rule beat a plain inline style', () => {
    const html = page('p { color: red !important }', '<p style="color: green">Hi</p>');
    expect(valueOf(html, 'p', 'color')).toBe('red');
  });
});

describe('inheritance', () => {
  const page = (style: string) =>
    `<html><head><style>${style}</style></head><body><main class="wrap"><p>Hello</p></main></body></html>`;

  it('passes an inherited property down to a descendant', () => {
    expect(valueOf(page('.wrap { color: rebeccapurple }'), 'p', 'color')).toBe('rebeccapurple');
  });

  it('does not pass down a property that does not inherit', () => {
    expect(valueOf(page('.wrap { border: 1px solid black }'), 'p', 'border')).toBeUndefined();
  });

  it('loses to any declaration on the element itself, however weak', () => {
    // The single most expensive misunderstanding in CSS: an id on the parent
    // does not beat a type selector on the child, because inheritance is not
    // part of the specificity contest at all.
    expect(valueOf(page('#none, .wrap { color: blue } p { color: red }'), 'p', 'color')).toBe(
      'red',
    );
  });

  it('takes the value from the nearest ancestor that sets it', () => {
    const html =
      '<html><head><style>body { color: red } .wrap { color: blue }</style></head>' +
      '<body><main class="wrap"><p>Hello</p></main></body></html>';
    expect(valueOf(html, 'p', 'color')).toBe('blue');
  });
});

describe('conditional rules', () => {
  const html =
    '<html><head><style>' +
    '.grid { grid-template-columns: 1fr }' +
    '@media (min-width: 40rem) { .grid { grid-template-columns: repeat(3, 1fr) } }' +
    '</style></head><body><div class="grid"></div></body></html>';

  it('ignores a media rule whose condition is not active', () => {
    expect(valueOf(html, '.grid', 'grid-template-columns')).toBe('1fr');
  });

  it('applies a media rule when its condition is active', () => {
    expect(valueOf(html, '.grid', 'grid-template-columns', ['(min-width: 40rem)'])).toBe(
      'repeat(3,1fr)',
    );
  });

  it('matches a condition regardless of whitespace', () => {
    expect(valueOf(html, '.grid', 'grid-template-columns', ['(min-width:40rem)'])).toBe(
      'repeat(3,1fr)',
    );
  });
});

describe('custom properties', () => {
  const page = (style: string) =>
    `<html><head><style>${style}</style></head><body><main class="wrap"><p>Hi</p></main></body></html>`;

  it('substitutes a value defined on an ancestor', () => {
    expect(valueOf(page(':root { --brand: teal } p { color: var(--brand) }'), 'p', 'color')).toBe(
      'teal',
    );
  });

  it('uses the fallback when the property is not defined', () => {
    expect(valueOf(page('p { color: var(--missing, hotpink) }'), 'p', 'color')).toBe('hotpink');
  });

  it('resolves a property that refers to another property', () => {
    const style = ':root { --base: teal; --accent: var(--base) } p { color: var(--accent) }';
    expect(valueOf(page(style), 'p', 'color')).toBe('teal');
  });

  it('leaves nothing behind when a property is missing and there is no fallback', () => {
    expect(valueOf(page('p { color: var(--missing) }'), 'p', 'color')).toBe('');
  });

  it('lets a custom property be overridden further down the tree', () => {
    const style = ':root { --brand: teal } .wrap { --brand: crimson } p { color: var(--brand) }';
    expect(valueOf(page(style), 'p', 'color')).toBe('crimson');
  });
});

/**
 * The promise that makes this gradeable at all.
 *
 * Each pair below is two genuinely different stylesheets a learner might write.
 * The evaluator must reach the same answer for both, because both are correct —
 * a grader that rewarded one and failed the other would be teaching the
 * learner to guess the marker rather than to write CSS.
 */
describe('different CSS, identical result', () => {
  const wrap = (style: string) =>
    `<html><head><style>${style}</style></head><body><main class="wrap"><p class="intro">Hi</p></main></body></html>`;

  it('reaches the same colour by four different routes', () => {
    const routes = [
      'p { color: teal }',
      '.intro { color: teal }',
      'main p { color: teal }',
      ':root { --c: teal } .intro { color: var(--c) }',
    ];
    for (const style of routes) {
      expect(valueOf(wrap(style), 'p', 'color'), style).toBe('teal');
    }
  });

  it('does not care about declaration order, whitespace or letter case', () => {
    const tidy = 'p { color: teal; font-size: 1rem }';
    const untidy = 'p{FONT-SIZE:1rem;color:TEAL}';
    expect(valueOf(wrap(tidy), 'p', 'color')).toBe(valueOf(wrap(untidy), 'p', 'color'));
    expect(valueOf(wrap(tidy), 'p', 'font-size')).toBe(valueOf(wrap(untidy), 'p', 'font-size'));
  });

  it('is unaffected by rules that never match', () => {
    const withNoise = '.nothing-here { color: red } #absent { color: red } p { color: teal }';
    expect(valueOf(wrap(withNoise), 'p', 'color')).toBe('teal');
  });
});

describe('value normalisation', () => {
  it('collapses whitespace and lowercases', () => {
    expect(normaliseValue('  REPEAT(3,   1FR) ')).toBe('repeat(3,1fr)');
  });

  it('strips surrounding quotes so font stacks compare cleanly', () => {
    expect(normaliseValue('"Segoe UI"')).toBe('segoe ui');
  });
});

describe('robustness', () => {
  it('survives a stylesheet that is entirely broken', () => {
    const { rules, problems } = parseStylesheet('}}} p { color');
    expect(Array.isArray(rules)).toBe(true);
    expect(problems.length).toBeGreaterThan(0);
  });

  it('returns nothing rather than throwing for an unmatched selector', () => {
    const html = '<html><body><p>Hi</p></body></html>';
    expect(valueOf(html, 'p', 'color')).toBeUndefined();
  });

  it('does not loop forever on a circular custom property', () => {
    const style = ':root { --a: var(--b); --b: var(--a) } p { color: var(--a) }';
    const html = `<html><head><style>${style}</style></head><body><p>Hi</p></body></html>`;
    expect(() => valueOf(html, 'p', 'color')).not.toThrow();
  });
});
