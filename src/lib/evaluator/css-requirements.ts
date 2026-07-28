import type { HTMLElement } from 'node-html-parser';
import { safeQueryAll, type ParsedDocument } from './parse';
import {
  extractStyleSheets,
  layerOrder,
  parseStylesheet,
  specificity,
  type StyleRule,
} from './css-parse';
import {
  ancestorsOf,
  normaliseValue,
  resolveStyles,
  splitStates,
  substituteVariables,
} from './css-cascade';
import type { Requirement, RequirementResult } from './types';

/**
 * Grading CSS.
 *
 * Every check here asks about the **resolved** value — what the cascade
 * actually produced for an element — rather than about the text the learner
 * typed. That is the difference between a grader that teaches CSS and one that
 * teaches learners to guess which selector the marker had in mind.
 *
 * Two consequences worth stating plainly, because they shape what an exercise
 * can and cannot ask:
 *
 * · Any correct route passes. A colour set by a type selector, a class, a
 *   custom property or an inline style all resolve to the same value, so all
 *   four are accepted for a requirement that asks about the colour.
 *
 * · Nothing is laid out. There is no rendering engine here, so no requirement
 *   can ask where a box ended up on screen. What can be asked is which
 *   declarations apply, which is where learners actually go wrong.
 */

export interface CssContext {
  rules: StyleRule[];
  /** Problems the parser found, surfaced rather than swallowed. */
  problems: string[];
  /** The raw stylesheet text, for the few checks that are genuinely textual. */
  source: string;
  /** Cascade layers in declared order, earliest first. */
  layers: string[];
}

export function buildCssContext(doc: ParsedDocument): CssContext {
  const sheets = extractStyleSheets(doc.raw);
  const parsed = sheets.map((sheet) => parseStylesheet(sheet));

  return {
    rules: parsed.flatMap((sheet) => sheet.rules),
    problems: parsed.flatMap((sheet) => sheet.problems),
    source: sheets.join('\n'),
    layers: layerOrder(parsed),
  };
}

/** Every CSS requirement kind, so the dispatcher knows what to route here. */
export const CSS_REQUIREMENT_KINDS = new Set<Requirement['kind']>([
  'css_declared',
  'css_value',
  'css_value_matches',
  'css_inherited',
  'css_property_absent',
  'css_custom_property',
  'css_rule_exists',
  'css_media_rule',
  'css_no_important',
  'css_max_specificity',
]);

interface Outcome {
  passed: boolean;
  detail: string;
}

/** The resolved value of one property on one element, with `var()` expanded. */
function resolvedValue(
  element: HTMLElement,
  root: HTMLElement,
  context: CssContext,
  property: string,
  condition: string | null,
  states: string[] = [],
): { value: string; source: string; selector: string | null } | null {
  const resolved = resolveStyles(element, context.rules, ancestorsOf(root, element), {
    activeConditions: condition ? [condition] : [],
    activeStates: states,
    layerOrder: context.layers,
  });
  const declaration = resolved.get(property.toLowerCase());
  if (!declaration) return null;

  return {
    value: normaliseValue(substituteVariables(declaration.value, resolved)),
    source: declaration.source,
    selector: declaration.selector,
  };
}

/**
 * Elements a requirement's selector picks out.
 *
 * A requirement may name a state — `.button:hover` — which no static document
 * can be queried for. The elements are found by the rest of the selector, and
 * the state is handed to the cascade separately so that the hover rules are the
 * ones that apply.
 */
function targets(doc: ParsedDocument, selector: string | null): HTMLElement[] {
  if (!selector) return [];
  return safeQueryAll(doc.root, splitStates(selector).base);
}

const underCondition = (condition: string | null) =>
  condition ? ` under \`${condition}\`` : '';

export function checkCssRequirement(
  requirement: Requirement,
  doc: ParsedDocument,
  context: CssContext,
): Outcome {
  const selector = requirement.selector;
  const property = (requirement.attribute ?? '').toLowerCase();
  const expected = requirement.expectedValue ?? '';
  const condition = requirement.condition ?? null;

  // Textual checks first: these ask about the stylesheet itself rather than
  // about any one element.
  if (requirement.kind === 'css_rule_exists') {
    const wanted = (requirement.expectedValue ?? requirement.selector ?? '').trim();
    const found = context.rules.some((rule) =>
      rule.selectors.some((entry) => entry.replace(/\s+/g, ' ').trim() === wanted),
    );
    return {
      passed: found,
      detail: found
        ? `Found a rule for \`${wanted}\`.`
        : `No rule uses the selector \`${wanted}\`. The selectors present are: ${listSelectors(context)}.`,
    };
  }

  if (requirement.kind === 'css_media_rule') {
    const wanted = expected.replace(/\s+/g, '').toLowerCase();
    const found = context.rules.some((rule) =>
      rule.conditions.some(
        (entry) =>
          (entry.name === 'media' || entry.name === 'container') &&
          entry.query.replace(/\s+/g, '').toLowerCase() === wanted,
      ),
    );
    return {
      passed: found,
      detail: found
        ? `Found rules inside \`${expected}\`.`
        : `No rules are wrapped in \`${expected}\`.`,
    };
  }

  if (requirement.kind === 'css_no_important') {
    const offenders = context.rules.flatMap((rule) =>
      rule.declarations
        .filter((declaration) => declaration.important)
        .map((declaration) => `${rule.selectors[0] ?? '?'} { ${declaration.property} }`),
    );
    return {
      passed: offenders.length === 0,
      detail:
        offenders.length === 0
          ? 'No declaration uses !important.'
          : `${offenders.length} declaration(s) use !important: ${offenders.slice(0, 3).join(', ')}. Raising specificity with !important wins the argument and loses the war — the next override needs another one.`,
    };
  }

  if (requirement.kind === 'css_max_specificity') {
    const limit = requirement.maxCount ?? 0;
    const over = context.rules
      .flatMap((rule) => rule.selectors)
      .filter((entry) => specificity(entry) > limit);
    return {
      passed: over.length === 0,
      detail:
        over.length === 0
          ? 'Every selector is within the specificity budget.'
          : `${over.length} selector(s) exceed the budget: ${over.slice(0, 3).join(', ')}.`,
    };
  }

  // Everything below needs elements to ask about.
  const states = selector ? splitStates(selector).states : [];
  const elements = targets(doc, selector);
  if (elements.length === 0) {
    return {
      passed: false,
      detail: `Nothing matches \`${selector}\`, so its styles cannot be checked. Check the markup before the CSS.`,
    };
  }

  if (requirement.kind === 'css_custom_property') {
    const name = property.startsWith('--') ? property : `--${property}`;
    const failures = elements.filter(
      (element) => resolvedValue(element, doc.root, context, name, condition, states) === null,
    );
    return {
      passed: failures.length === 0,
      detail:
        failures.length === 0
          ? `\`${name}\` resolves on every \`${selector}\`.`
          : `\`${name}\` is not defined for \`${selector}\`. A custom property must be declared on the element or on one of its ancestors.`,
    };
  }

  const readings = elements.map((element) => ({
    element,
    reading: resolvedValue(element, doc.root, context, property, condition, states),
  }));

  if (requirement.kind === 'css_property_absent') {
    const offenders = readings.filter(
      (entry) => entry.reading !== null && entry.reading.source !== 'inherited',
    );
    return {
      passed: offenders.length === 0,
      detail:
        offenders.length === 0
          ? `Nothing sets \`${property}\` on \`${selector}\`${underCondition(condition)}.`
          : `\`${property}\` is set to \`${offenders[0]?.reading?.value}\` on \`${selector}\`, and this exercise asks for it not to be.`,
    };
  }

  const missing = readings.filter((entry) => entry.reading === null);
  if (missing.length > 0) {
    return {
      passed: false,
      detail: `\`${property}\` does not resolve for \`${selector}\`${underCondition(condition)}. Nothing in the stylesheet sets it, and it is not inherited.`,
    };
  }

  if (requirement.kind === 'css_declared') {
    return {
      passed: true,
      detail: `\`${property}\` resolves to \`${readings[0]?.reading?.value}\` on \`${selector}\`.`,
    };
  }

  if (requirement.kind === 'css_inherited') {
    const notInherited = readings.filter((entry) => entry.reading?.source !== 'inherited');
    return {
      passed: notInherited.length === 0,
      detail:
        notInherited.length === 0
          ? `\`${property}\` reaches \`${selector}\` by inheritance, as asked.`
          : `\`${property}\` is set directly on \`${selector}\` rather than inherited from an ancestor. A declaration on the element itself beats an inherited value however weak it is — which is the point of this exercise.`,
    };
  }

  if (requirement.kind === 'css_value') {
    const want = normaliseValue(expected);
    const wrong = readings.filter((entry) => !valuesMatch(entry.reading?.value ?? '', want));
    return {
      passed: wrong.length === 0,
      detail:
        wrong.length === 0
          ? `\`${property}\` resolves to \`${expected}\` on \`${selector}\`${underCondition(condition)}.`
          : `\`${property}\` on \`${selector}\`${underCondition(condition)} resolves to \`${wrong[0]?.reading?.value}\`, not \`${expected}\`` +
            (wrong[0]?.reading?.selector
              ? `. The winning rule is \`${wrong[0]?.reading?.selector}\`.`
              : '.'),
    };
  }

  if (requirement.kind === 'css_value_matches') {
    let pattern: RegExp;
    try {
      pattern = new RegExp(expected, 'i');
    } catch {
      return { passed: false, detail: `The pattern \`${expected}\` is not valid.` };
    }
    const wrong = readings.filter((entry) => !pattern.test(entry.reading?.value ?? ''));
    return {
      passed: wrong.length === 0,
      detail:
        wrong.length === 0
          ? `\`${property}\` on \`${selector}\` matches the expected shape.`
          : `\`${property}\` on \`${selector}\` resolves to \`${wrong[0]?.reading?.value}\`, which does not match \`${expected}\`.`,
    };
  }

  return { passed: false, detail: 'Unknown CSS requirement.' };
}

/**
 * Compares two resolved values tolerantly.
 *
 * Accepts equivalences a browser treats as identical but a string comparison
 * does not, so a learner is never failed for writing `#ffffff` where the
 * reference says `#fff`, or `0` where it says `0px`. Anything beyond that is
 * left strict — silently accepting near-misses would make the grader lie.
 */
function valuesMatch(actual: string, expected: string): boolean {
  if (actual === expected) return true;

  const expand = (value: string) =>
    value
      // #abc → #aabbcc
      .replace(/^#([0-9a-f])([0-9a-f])([0-9a-f])$/i, (_m, r, g, b) => `#${r}${r}${g}${g}${b}${b}`)
      // A bare zero is the same length whatever unit is implied.
      .replace(/\b0(px|rem|em|%)\b/g, '0')
      .replace(/\s+/g, ' ')
      .trim();

  return expand(actual) === expand(expected);
}

function listSelectors(context: CssContext): string {
  const selectors = [...new Set(context.rules.flatMap((rule) => rule.selectors))];
  if (selectors.length === 0) return 'none — the stylesheet is empty';
  return selectors.slice(0, 6).map((entry) => `\`${entry}\``).join(', ');
}

/** Turns an outcome into the shape the results panel renders. */
export function cssRequirementResult(
  requirement: Requirement,
  outcome: Outcome,
): RequirementResult {
  return {
    requirementId: requirement.id,
    kind: requirement.kind,
    passed: outcome.passed,
    message: requirement.message,
    detail: outcome.detail,
    hint: requirement.hint,
    isCritical: requirement.isCritical,
    weight: requirement.weight,
  };
}
