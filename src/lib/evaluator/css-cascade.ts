import type { HTMLElement } from 'node-html-parser';
import { safeQueryAll } from './parse';
import { layerNameOf, parseDeclarations, specificity, type StyleRule } from './css-parse';

/**
 * Resolving the cascade: which declaration actually wins for a given element.
 *
 * This is the module the whole CSS evaluator rests on, and the reason grading
 * can be honest about different-but-equally-correct answers. A requirement never
 * asks "did you write `color: red`" — it asks "is the resolved colour of this
 * element red", and gets the same answer whether the learner set it with a type
 * selector, a class, a custom property or an inline style.
 *
 * ## The order of battle
 *
 * For each element, every declaration that could apply is collected and then
 * ranked, highest first:
 *
 *   1. `!important` inline style
 *   2. `!important` author rule, then by specificity, then by source order
 *   3. inline style
 *   4. author rule, by specificity, then by source order
 *
 * Only then, if nothing set the property at all, is inheritance consulted —
 * because an inherited value loses to *any* declaration on the element itself,
 * however weak. That single fact accounts for a large share of the time
 * beginners lose to CSS, which is why the course teaches it first and why the
 * grader models it exactly rather than approximating.
 */

export interface ResolvedDeclaration {
  value: string;
  important: boolean;
  /** Rank of the cascade layer this came from; see `layerRank`. */
  layer: number;
  specificity: number;
  order: number;
  /** How the value reached this element. */
  source: 'inline' | 'rule' | 'inherited';
  /** The selector that won, for explaining the result back to the learner. */
  selector: string | null;
}

/** Properties that inherit by default. Not exhaustive — this is what a course needs. */
export const INHERITED_PROPERTIES = new Set([
  'color',
  'font',
  'font-family',
  'font-size',
  'font-style',
  'font-weight',
  'font-variant',
  'letter-spacing',
  'line-height',
  'text-align',
  'text-indent',
  'text-transform',
  'visibility',
  'white-space',
  'word-spacing',
  'direction',
  'cursor',
  'list-style',
  'list-style-type',
  'list-style-position',
  'quotes',
  'caption-side',
  'border-collapse',
  'border-spacing',
  'empty-cells',
  'orphans',
  'widows',
  'hyphens',
  'tab-size',
]);

/** A custom property (`--brand`) always inherits, whatever its name. */
function inherits(property: string): boolean {
  return property.startsWith('--') || INHERITED_PROPERTIES.has(property);
}

export interface CascadeOptions {
  /**
   * Conditions treated as active. A rule inside `@media (min-width: 40rem)`
   * only applies when its query is listed here.
   *
   * Requirements state the context they are asking about, so an exercise can
   * ask "at a wide viewport, is this a three-column grid" and "at a narrow one,
   * is it a single column" — and both are answered by the same resolver.
   */
  activeConditions?: string[];
  /**
   * State pseudo-classes treated as active, without the colon — `['hover']`.
   *
   * A rule written for a state applies only when that state is listed. This is
   * the same idea as `activeConditions`: the requirement says which state it is
   * asking about, and the resolver answers for that state. Without it a
   * `.button:hover` rule would colour the resting button, and every exercise
   * that styles a hover would silently corrupt the checks around it.
   */
  activeStates?: string[];
  /**
   * Cascade layers in declared order, earliest first.
   *
   * Layer order is consulted *before* specificity, which is what lets a
   * one-class utility beat an id selector without `!important`. A grader that
   * ignored layers would quietly mark the correct answer wrong in exactly the
   * lesson that teaches them.
   */
  layerOrder?: string[];
}

/**
 * Where a rule's layer sits in the order.
 *
 * Unlayered author rules beat every layer — the specification treats them as an
 * implicit final layer — so they rank above the highest declared one. A layer
 * that was never declared in a `@layer` statement ranks after those that were,
 * matching first-appearance ordering.
 */
function layerRank(rule: StyleRule, order: string[]): number {
  const name = layerNameOf(rule);
  if (!name) return Number.MAX_SAFE_INTEGER;
  const index = order.indexOf(name);
  return index === -1 ? order.length : index;
}

/**
 * State pseudo-classes the grader models, longest alternative first.
 *
 * The ordering matters: with `focus` before `focus-visible`, `:focus-visible`
 * matches as `:focus` — the word boundary holds before the hyphen — and leaves
 * a stray `-visible` behind, producing a selector that matches nothing.
 */
const STATE_PSEUDO_CLASSES =
  /:(focus-visible|focus-within|hover|focus|active|visited|target|disabled|checked)\b/g;

/**
 * Separates a selector into the part a static document can match and the states
 * it asks for. `a:hover` becomes `{ base: 'a', states: ['hover'] }`.
 */
export function splitStates(selector: string): { base: string; states: string[] } {
  const states: string[] = [];
  const base = selector
    .replace(STATE_PSEUDO_CLASSES, (_match, name: string) => {
      states.push(name.toLowerCase());
      return '';
    })
    .trim();

  return { base: base || '*', states };
}

/** A query with all whitespace removed and lowercased, for comparison only. */
function condensed(query: string): string {
  return query.replace(/\s+/g, '').toLowerCase();
}

/** Does every at-rule wrapping this rule count as active? */
function conditionsHold(rule: StyleRule, active: string[]): boolean {
  return rule.conditions.every((condition) => {
    // `@layer` and `@supports` are not simulated: a rule inside them is treated
    // as applying, which is right for `@supports` in a teaching context — the
    // features this course teaches are supported everywhere — and avoids
    // silently failing a learner for using a layer.
    if (condition.name !== 'media' && condition.name !== 'container') return true;
    // Compared with every space removed, so `(min-width:40rem)` and
    // `(min-width: 40rem)` are the same condition. A requirement should never
    // fail because an author and a learner spaced a query differently.
    const query = condensed(condition.query);
    return active.some((entry) => condensed(entry) === query);
  });
}

/** Declarations from a `style` attribute, which outrank every ordinary rule. */
function inlineDeclarations(element: HTMLElement) {
  const attribute = element.getAttribute('style');
  return attribute ? parseDeclarations(attribute) : [];
}

/**
 * Every property that any rule sets on this element, resolved to a winner.
 *
 * Inheritance is applied last and only where nothing else set the property, by
 * walking up the ancestors. The walk stops at the first ancestor that sets the
 * property, which is what "inherited" actually means — not "the value on the
 * root".
 */
export function resolveStyles(
  element: HTMLElement,
  rules: StyleRule[],
  ancestors: HTMLElement[],
  options: CascadeOptions = {},
): Map<string, ResolvedDeclaration> {
  const active = options.activeConditions ?? [];
  const states = options.activeStates ?? [];
  const layers = options.layerOrder ?? [];
  const resolved = new Map<string, ResolvedDeclaration>();

  const consider = (candidate: ResolvedDeclaration, property: string) => {
    const current = resolved.get(property);
    if (!current || outranks(candidate, current)) resolved.set(property, candidate);
  };

  for (const rule of rules) {
    if (!conditionsHold(rule, active)) continue;

    const layer = layerRank(rule, layers);
    for (const selector of rule.selectors) {
      if (!matches(element, selector, ancestors, states)) continue;

      const weight = specificity(selector);
      for (const declaration of rule.declarations) {
        consider(
          {
            value: declaration.value,
            important: declaration.important,
            layer,
            specificity: weight,
            order: rule.order,
            source: 'rule',
            selector,
          },
          declaration.property,
        );
      }
    }
  }

  for (const declaration of inlineDeclarations(element)) {
    consider(
      {
        value: declaration.value,
        important: declaration.important,
        // A style attribute belongs to no layer, which puts it with the
        // unlayered rules — above every declared layer.
        layer: Number.MAX_SAFE_INTEGER,
        // Inline beats every selector, so it is given a weight nothing can reach.
        specificity: Number.MAX_SAFE_INTEGER,
        order: Number.MAX_SAFE_INTEGER,
        source: 'inline',
        selector: null,
      },
      declaration.property,
    );
  }

  // Inheritance, only for properties nothing on this element set.
  for (let depth = ancestors.length - 1; depth >= 0; depth -= 1) {
    const ancestor = ancestors[depth];
    if (!ancestor) continue;

    // Ancestors are resolved in their resting state: a requirement asking about
    // `.button:hover` is asking about that button, not about every element
    // above it in the tree.
    const inheritedFrom = resolveOwn(ancestor, rules, ancestors.slice(0, depth), active, layers);
    for (const [property, declaration] of inheritedFrom) {
      if (!inherits(property)) continue;
      if (resolved.has(property)) continue;
      resolved.set(property, { ...declaration, source: 'inherited' });
    }
  }

  return resolved;
}

/** Declarations set directly on an element, ignoring inheritance. */
function resolveOwn(
  element: HTMLElement,
  rules: StyleRule[],
  ancestors: HTMLElement[],
  active: string[],
  layers: string[] = [],
): Map<string, ResolvedDeclaration> {
  const resolved = new Map<string, ResolvedDeclaration>();

  const consider = (candidate: ResolvedDeclaration, property: string) => {
    const current = resolved.get(property);
    if (!current || outranks(candidate, current)) resolved.set(property, candidate);
  };

  for (const rule of rules) {
    if (!conditionsHold(rule, active)) continue;
    const layer = layerRank(rule, layers);
    for (const selector of rule.selectors) {
      if (!matches(element, selector, ancestors)) continue;
      const weight = specificity(selector);
      for (const declaration of rule.declarations) {
        consider(
          {
            value: declaration.value,
            important: declaration.important,
            layer,
            specificity: weight,
            order: rule.order,
            source: 'rule',
            selector,
          },
          declaration.property,
        );
      }
    }
  }

  for (const declaration of inlineDeclarations(element)) {
    consider(
      {
        value: declaration.value,
        important: declaration.important,
        layer: Number.MAX_SAFE_INTEGER,
        specificity: Number.MAX_SAFE_INTEGER,
        order: Number.MAX_SAFE_INTEGER,
        source: 'inline',
        selector: null,
      },
      declaration.property,
    );
  }

  return resolved;
}

/** The cascade comparison, in the specification's order. */
function outranks(candidate: ResolvedDeclaration, current: ResolvedDeclaration): boolean {
  if (candidate.important !== current.important) return candidate.important;

  if (candidate.layer !== current.layer) {
    // Layer order is compared before specificity — that is the whole reason
    // layers exist. For `!important` declarations the order reverses, so an
    // early layer's important rule beats a later layer's important rule.
    return candidate.important
      ? candidate.layer < current.layer
      : candidate.layer > current.layer;
  }

  if (candidate.specificity !== current.specificity) {
    return candidate.specificity > current.specificity;
  }
  return candidate.order >= current.order;
}

/**
 * Does this element match this selector?
 *
 * Delegated to the HTML parser's own engine by querying the document and
 * checking membership, rather than reimplementing selector matching. Slower
 * than a direct match and far more trustworthy — combinators, attribute
 * operators and `:not()` all behave as the parser already implements them.
 */
function matches(
  element: HTMLElement,
  selector: string,
  ancestors: HTMLElement[],
  activeStates: string[] = [],
): boolean {
  const root = ancestors[0] ?? element;

  // A rule written for a state applies only when the caller said that state is
  // active. Nothing in a static document can tell us whether a button is being
  // hovered, so the requirement has to say which state it is asking about.
  const { base, states } = splitStates(selector);
  if (states.some((state) => !activeStates.includes(state))) return false;

  // Pseudo-elements cannot be evaluated against a static document either, so
  // the rule is matched on the rest of the selector.
  const staticSelector = base
    .replace(/::[a-zA-Z-]+/g, '')
    // `:root` is the document element. The HTML parser's selector engine does
    // not implement it, and it is how every design-token stylesheet in this
    // course declares its custom properties — so it is rewritten rather than
    // quietly failing to match, which would make every `var()` resolve empty.
    .replace(/:root\b/g, 'html')
    .trim();

  if (!staticSelector || staticSelector === '*') return true;

  try {
    return safeQueryAll(root, staticSelector).includes(element);
  } catch {
    return false;
  }
}

/** The chain from the document root down to (but excluding) an element. */
export function ancestorsOf(root: HTMLElement, element: HTMLElement): HTMLElement[] {
  const chain: HTMLElement[] = [];
  let current = element.parentNode as HTMLElement | null;
  while (current) {
    chain.unshift(current);
    if (current === root) break;
    current = current.parentNode as HTMLElement | null;
  }
  return chain;
}

/**
 * Substitutes `var()` references against the resolved custom properties.
 *
 * Custom properties are the one place where the *value* a learner writes and
 * the value that applies genuinely differ, so a grader that skipped this would
 * mark a correct design-token answer wrong. Fallbacks are honoured, and a
 * missing property with no fallback resolves to the empty string exactly as a
 * browser leaves the declaration invalid.
 */
export function substituteVariables(
  value: string,
  resolved: Map<string, ResolvedDeclaration>,
  depth = 0,
): string {
  if (depth > 10 || !value.includes('var(')) return value;

  const replaced = value.replace(/var\(\s*(--[a-zA-Z0-9_-]+)\s*(?:,([^)]*))?\)/g, (_all, name: string, fallback?: string) => {
    const declaration = resolved.get(name);
    if (declaration) return declaration.value.trim();
    return (fallback ?? '').trim();
  });

  return replaced === value ? replaced : substituteVariables(replaced, resolved, depth + 1);
}

/** Normalises a value for comparison: lowercase, collapsed spaces, no quotes. */
export function normaliseValue(value: string): string {
  return value
    .trim()
    .toLowerCase()
    .replace(/\s*,\s*/g, ',')
    .replace(/\s+/g, ' ')
    .replace(/^["']|["']$/g, '');
}
