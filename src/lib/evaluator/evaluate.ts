import type { HTMLElement } from 'node-html-parser';
import {
  DEPRECATED_ELEMENTS,
  collectHeadings,
  collectIds,
  parseDocument,
  safeQueryAll,
  scanSource,
  textOf,
  type ParsedDocument,
} from './parse';
import { accessibleName, assessAltText, hasAltAttribute, labelTextFor } from './accessible-name';
import {
  CSS_REQUIREMENT_KINDS,
  buildCssContext,
  checkCssRequirement,
  cssRequirementResult,
} from './css-requirements';
import { mediaPathExists } from './media-index';
import type { EvaluationIssue, EvaluationResult, Requirement, RequirementResult } from './types';

/**
 * The structural evaluator.
 *
 * It never compares the learner's code to a reference string. It parses the
 * markup, then asks a series of shape questions: does a `<main>` exist, is
 * there exactly one `<h1>`, does every image carry meaningful alt text, is the
 * heading hierarchy sound. Two learners writing entirely different content both
 * pass, provided the structure is right — which is the point.
 */

const PLURAL = (n: number, one: string, many: string) => (n === 1 ? one : many);

function describeCount(n: number, thing: string): string {
  if (n === 0) return `no ${thing}`;
  return `${n} ${PLURAL(n, thing, `${thing}s`)}`;
}

/** Human-readable name for a selector, used in feedback messages. */
function label(selector: string | null): string {
  if (!selector) return 'element';
  return /^[a-z][a-z0-9]*$/i.test(selector) ? `<${selector}>` : `\`${selector}\``;
}

function pass(req: Requirement, detail: string): RequirementResult {
  return {
    requirementId: req.id,
    kind: req.kind,
    passed: true,
    message: req.message,
    detail,
    hint: null,
    isCritical: req.isCritical,
    weight: req.weight,
  };
}

function fail(req: Requirement, detail: string): RequirementResult {
  return {
    requirementId: req.id,
    kind: req.kind,
    passed: false,
    message: req.message,
    detail,
    hint: req.hint,
    isCritical: req.isCritical,
    weight: req.weight,
  };
}

// ---------------------------------------------------------------------------
// Individual requirement checks
// ---------------------------------------------------------------------------

function checkRequirement(req: Requirement, doc: ParsedDocument): RequirementResult {
  const { root, raw } = doc;
  const selector = req.selector;
  const found = selector ? safeQueryAll(root, selector) : [];

  switch (req.kind) {
    case 'doctype': {
      const ok = /^\s*<!doctype\s+html\s*>/i.test(raw);
      return ok
        ? pass(req, 'The document starts with <!DOCTYPE html>.')
        : fail(req, 'The document does not start with <!DOCTYPE html>.');
    }

    case 'element_present': {
      const min = req.minCount ?? 1;
      return found.length >= min
        ? pass(req, `Found ${describeCount(found.length, label(selector))}.`)
        : fail(
            req,
            `Expected at least ${min} ${label(selector)}, but found ${describeCount(found.length, label(selector))}.`,
          );
    }

    case 'element_absent': {
      return found.length === 0
        ? pass(req, `No ${label(selector)} present, as required.`)
        : fail(req, `Found ${describeCount(found.length, label(selector))}, but there should be none.`);
    }

    case 'unique_element': {
      if (found.length === 1) return pass(req, `Exactly one ${label(selector)}.`);
      return fail(
        req,
        found.length === 0
          ? `No ${label(selector)} found — exactly one is needed.`
          : `Found ${found.length} ${label(selector)} elements — there must be exactly one.`,
      );
    }

    case 'element_count': {
      const min = req.minCount ?? 0;
      const max = req.maxCount ?? Number.POSITIVE_INFINITY;
      const n = found.length;
      if (n >= min && n <= max) {
        return pass(req, `Found ${describeCount(n, label(selector))}.`);
      }
      const want =
        min === max
          ? `exactly ${min}`
          : Number.isFinite(max)
            ? `between ${min} and ${max}`
            : `at least ${min}`;
      return fail(req, `Expected ${want} ${label(selector)}, but found ${n}.`);
    }

    case 'attribute_present': {
      if (found.length === 0) {
        return fail(req, `No ${label(selector)} found, so its \`${req.attribute}\` could not be checked.`);
      }
      const missing = found.filter((el) => el.getAttribute(req.attribute ?? '') === undefined);
      return missing.length === 0
        ? pass(req, `Every ${label(selector)} has a \`${req.attribute}\` attribute.`)
        : fail(
            req,
            `${missing.length} of ${found.length} ${label(selector)} ${PLURAL(missing.length, 'element is', 'elements are')} missing \`${req.attribute}\`.`,
          );
    }

    case 'attribute_absent': {
      const offenders = found.filter((el) => el.getAttribute(req.attribute ?? '') !== undefined);
      return offenders.length === 0
        ? pass(req, `No ${label(selector)} uses \`${req.attribute}\`, as required.`)
        : fail(req, `${offenders.length} ${label(selector)} still uses \`${req.attribute}\`.`);
    }

    case 'attribute_value': {
      if (found.length === 0) {
        return fail(req, `No ${label(selector)} found.`);
      }
      const wanted = (req.expectedValue ?? '').trim().toLowerCase();
      const matching = found.filter(
        (el) => (el.getAttribute(req.attribute ?? '') ?? '').trim().toLowerCase() === wanted,
      );
      const min = req.minCount ?? 1;
      return matching.length >= min
        ? pass(req, `\`${req.attribute}="${req.expectedValue}"\` is set correctly.`)
        : fail(
            req,
            `Expected ${label(selector)} with \`${req.attribute}="${req.expectedValue}"\`; found ` +
              (found.length > 0
                ? `\`${req.attribute}="${found[0]?.getAttribute(req.attribute ?? '') ?? ''}"\`.`
                : 'nothing.'),
          );
    }

    case 'attribute_matches': {
      if (found.length === 0) return fail(req, `No ${label(selector)} found.`);
      let re: RegExp;
      try {
        re = new RegExp(req.expectedValue ?? '.', 'i');
      } catch {
        return fail(req, 'This requirement has an invalid pattern and could not be checked.');
      }
      const min = req.minCount ?? 1;
      const matching = found.filter((el) => re.test(el.getAttribute(req.attribute ?? '') ?? ''));
      return matching.length >= min
        ? pass(req, `\`${req.attribute}\` has the expected shape.`)
        : fail(req, `\`${req.attribute}\` on ${label(selector)} does not match the expected pattern.`);
    }

    case 'nesting': {
      const min = req.minCount ?? 1;
      const combined = `${req.ancestorSelector ?? ''} ${selector ?? ''}`.trim();
      const inside = safeQueryAll(root, combined);
      return inside.length >= min
        ? pass(req, `${label(selector)} sits inside ${label(req.ancestorSelector)}.`)
        : fail(
            req,
            `Expected ${label(selector)} inside ${label(req.ancestorSelector)}, but found ${inside.length}.`,
          );
    }

    case 'direct_child': {
      const min = req.minCount ?? 1;
      const combined = `${req.ancestorSelector ?? ''} > ${selector ?? ''}`;
      const inside = safeQueryAll(root, combined);
      return inside.length >= min
        ? pass(req, `${label(selector)} is a direct child of ${label(req.ancestorSelector)}.`)
        : fail(
            req,
            `${label(selector)} must be placed directly inside ${label(req.ancestorSelector)} — found ${inside.length}.`,
          );
    }

    case 'text_content': {
      const needle = (req.expectedValue ?? '').toLowerCase();
      const matched = found.filter((el) => textOf(el).toLowerCase().includes(needle));
      return matched.length > 0
        ? pass(req, `${label(selector)} contains the expected text.`)
        : fail(req, `No ${label(selector)} contains "${req.expectedValue}".`);
    }

    case 'text_not_empty': {
      if (found.length === 0) return fail(req, `No ${label(selector)} found.`);
      const min = req.minCount ?? found.length;
      const filled = found.filter((el) => textOf(el).length > 0);
      return filled.length >= min
        ? pass(req, `${label(selector)} has real content — good.`)
        : fail(
            req,
            `${found.length - filled.length} ${label(selector)} ${PLURAL(found.length - filled.length, 'element is', 'elements are')} empty.`,
          );
    }

    case 'accessible_name': {
      if (found.length === 0) return fail(req, `No ${label(selector)} found.`);
      const unnamed = found.filter((el) => accessibleName(el, root).length === 0);
      return unnamed.length === 0
        ? pass(req, `Every ${label(selector)} has an accessible name.`)
        : fail(
            req,
            `${unnamed.length} ${label(selector)} ${PLURAL(unnamed.length, 'element has', 'elements have')} no accessible name — ` +
              'a screen reader would announce it with nothing to identify it.',
          );
    }

    case 'alt_quality': {
      const images = safeQueryAll(root, selector ?? 'img');
      if (images.length === 0) return fail(req, 'No images found to check.');
      const problems: string[] = [];
      for (const img of images) {
        if (!hasAltAttribute(img)) {
          problems.push('one image has no alt attribute at all');
          continue;
        }
        const alt = img.getAttribute('alt') ?? '';
        const isDecorative = alt.trim().length === 0;
        // alt="" is correct for decorative images; only judge non-empty text.
        if (isDecorative) continue;
        const quality = assessAltText(alt);
        if (!quality.ok) problems.push(quality.reason);
      }
      return problems.length === 0
        ? pass(req, 'Alt text is present and descriptive.')
        : fail(req, `Alt text needs work: ${problems.slice(0, 3).join('; ')}.`);
    }

    case 'label_association': {
      const controls = safeQueryAll(root, selector ?? 'input, select, textarea').filter((el) => {
        const type = (el.getAttribute('type') ?? '').toLowerCase();
        return !['hidden', 'submit', 'reset', 'button', 'image'].includes(type);
      });
      if (controls.length === 0) return fail(req, 'No form controls found to check.');
      const unlabelled = controls.filter((el) => {
        if (labelTextFor(el, root)) return false;
        return accessibleName(el, root).length === 0;
      });
      return unlabelled.length === 0
        ? pass(req, `All ${controls.length} form ${PLURAL(controls.length, 'control is', 'controls are')} labelled.`)
        : fail(
            req,
            `${unlabelled.length} form ${PLURAL(unlabelled.length, 'control has', 'controls have')} no label. ` +
              'Every input needs a <label for="…"> pointing at its id.',
          );
    }

    case 'heading_order': {
      const headings = collectHeadings(root);
      if (headings.length === 0) return fail(req, 'No headings found.');
      const first = headings[0];
      if (first && first.level !== 1) {
        return fail(req, `The first heading is an <h${first.level}> — a page should start with its single <h1>.`);
      }
      const h1s = headings.filter((h) => h.level === 1).length;
      if (h1s !== 1) {
        return fail(req, `Found ${h1s} <h1> elements — a page should have exactly one.`);
      }
      for (let i = 1; i < headings.length; i += 1) {
        const prev = headings[i - 1];
        const current = headings[i];
        if (!prev || !current) continue;
        if (current.level > prev.level + 1) {
          return fail(
            req,
            `The heading "${current.text || `h${current.level}`}" jumps from h${prev.level} to h${current.level}. ` +
              'Headings go down one step at a time.',
          );
        }
      }
      return pass(req, `Heading order is correct across ${headings.length} headings.`);
    }

    case 'no_duplicate_ids': {
      const ids = collectIds(root);
      const seen = new Set<string>();
      const dupes = new Set<string>();
      for (const id of ids) {
        if (seen.has(id)) dupes.add(id);
        seen.add(id);
      }
      return dupes.size === 0
        ? pass(req, 'Every id is unique.')
        : fail(req, `These ids appear more than once: ${[...dupes].join(', ')}. An id must be unique on a page.`);
    }

    case 'no_inline_script': {
      const scripts = safeQueryAll(root, 'script');
      const handlers = safeQueryAll(root, '*').filter((el) =>
        Object.keys(el.attributes).some((a) => /^on[a-z]+$/i.test(a)),
      );
      const jsUrls = safeQueryAll(root, '[href], [src]').filter((el) =>
        /^\s*javascript:/i.test(el.getAttribute('href') ?? el.getAttribute('src') ?? ''),
      );
      const total = scripts.length + handlers.length + jsUrls.length;
      return total === 0
        ? pass(req, 'No scripts — this exercise is about HTML structure.')
        : fail(
            req,
            `Found ${total} script or inline event handler. This course teaches HTML structure, and the preview ` +
              'deliberately refuses to run JavaScript.',
          );
    }

    case 'local_media_path': {
      const mediaEls = safeQueryAll(root, selector ?? 'img[src], source[src], source[srcset], video[src], audio[src], track[src], video[poster]');
      if (mediaEls.length === 0) return fail(req, 'No media elements found to check.');
      const broken: string[] = [];
      for (const el of mediaEls) {
        for (const attr of ['src', 'poster'] as const) {
          const value = el.getAttribute(attr);
          if (value && !mediaPathExists(value)) broken.push(value);
        }
        const srcset = el.getAttribute('srcset');
        if (srcset) {
          for (const candidate of srcset.split(',')) {
            const url = candidate.trim().split(/\s+/)[0];
            if (url && !mediaPathExists(url)) broken.push(url);
          }
        }
      }
      return broken.length === 0
        ? pass(req, 'Every media path points at a file that exists.')
        : fail(
            req,
            `These paths do not exist: ${[...new Set(broken)].slice(0, 4).join(', ')}. ` +
              'Use the media library button to insert a correct path.',
          );
    }

    case 'no_deprecated_elements': {
      const used = [...doc.tagNames].filter((t) => DEPRECATED_ELEMENTS.has(t));
      return used.length === 0
        ? pass(req, 'No obsolete elements used.')
        : fail(req, `These elements were removed from HTML: ${used.map((t) => `<${t}>`).join(', ')}.`);
    }

    case 'valid_nesting': {
      const problems = [
        ...findInvalidNesting(root),
        ...scanSource(raw).autoClosed.map(
          (p) => `<${p.child}> cannot be placed inside <${p.parent}>`,
        ),
      ];
      return problems.length === 0
        ? pass(req, 'Elements are nested legally.')
        : fail(req, problems.slice(0, 3).join('; ') + '.');
    }

    default: {
      // `default` keeps the switch total even if a new enum value is added
      // to the database before the evaluator learns to check it.
      return fail(req, 'This requirement type is not yet supported by the evaluator.');
    }
  }
}

// ---------------------------------------------------------------------------
// Nesting rules that browsers silently "fix" but that break real pages
// ---------------------------------------------------------------------------

interface NestingRule {
  child: string;
  allowedParents: string[];
  message: string;
}

const NESTING_RULES: NestingRule[] = [
  { child: 'li', allowedParents: ['ul', 'ol', 'menu'], message: '<li> must be inside <ul> or <ol>' },
  { child: 'dt', allowedParents: ['dl', 'div'], message: '<dt> must be inside <dl>' },
  { child: 'dd', allowedParents: ['dl', 'div'], message: '<dd> must be inside <dl>' },
  { child: 'option', allowedParents: ['select', 'optgroup', 'datalist'], message: '<option> must be inside <select>, <optgroup> or <datalist>' },
  { child: 'optgroup', allowedParents: ['select'], message: '<optgroup> must be inside <select>' },
  { child: 'tr', allowedParents: ['table', 'thead', 'tbody', 'tfoot'], message: '<tr> must be inside <table>, <thead>, <tbody> or <tfoot>' },
  { child: 'td', allowedParents: ['tr'], message: '<td> must be inside <tr>' },
  { child: 'th', allowedParents: ['tr'], message: '<th> must be inside <tr>' },
  { child: 'thead', allowedParents: ['table'], message: '<thead> must be inside <table>' },
  { child: 'tbody', allowedParents: ['table'], message: '<tbody> must be inside <table>' },
  { child: 'tfoot', allowedParents: ['table'], message: '<tfoot> must be inside <table>' },
  { child: 'caption', allowedParents: ['table'], message: '<caption> must be inside <table>' },
  { child: 'figcaption', allowedParents: ['figure'], message: '<figcaption> must be inside <figure>' },
  { child: 'legend', allowedParents: ['fieldset'], message: '<legend> must be inside <fieldset>' },
  { child: 'summary', allowedParents: ['details'], message: '<summary> must be inside <details>' },
  { child: 'source', allowedParents: ['picture', 'video', 'audio'], message: '<source> must be inside <picture>, <video> or <audio>' },
  { child: 'track', allowedParents: ['video', 'audio'], message: '<track> must be inside <video> or <audio>' },
];

/** Elements that must never contain interactive or block-level content. */
const PHRASING_ONLY_PARENTS = new Set(['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6']);
const BLOCK_CHILDREN = new Set([
  'div', 'p', 'ul', 'ol', 'section', 'article', 'header', 'footer', 'nav',
  'aside', 'main', 'table', 'form', 'figure', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6',
]);

export function findInvalidNesting(root: HTMLElement): string[] {
  const problems: string[] = [];

  for (const rule of NESTING_RULES) {
    for (const el of safeQueryAll(root, rule.child)) {
      const parent = el.parentNode as HTMLElement | null;
      const parentTag = parent?.rawTagName?.toLowerCase() ?? '';
      if (parentTag && !rule.allowedParents.includes(parentTag)) {
        problems.push(`${rule.message} (found inside <${parentTag}>)`);
        break;
      }
    }
  }

  for (const parentTag of PHRASING_ONLY_PARENTS) {
    for (const parent of safeQueryAll(root, parentTag)) {
      for (const child of parent.childNodes) {
        const tag = (child as HTMLElement).rawTagName?.toLowerCase();
        if (tag && BLOCK_CHILDREN.has(tag)) {
          problems.push(`<${tag}> cannot be placed inside <${parentTag}>`);
          break;
        }
      }
    }
  }

  // A link inside a link, or a button inside a button, is never valid.
  for (const [outer, inner] of [['a', 'a'], ['button', 'button'], ['a', 'button'], ['button', 'a']]) {
    if (safeQueryAll(root, `${outer} ${inner}`).length > 0) {
      problems.push(`<${inner}> cannot be nested inside <${outer}>`);
    }
  }

  // A <form> inside another <form> is not allowed.
  if (safeQueryAll(root, 'form form').length > 0) {
    problems.push('<form> cannot be nested inside another <form>');
  }

  return [...new Set(problems)];
}

// ---------------------------------------------------------------------------
// Document-wide issues, checked for every submission
// ---------------------------------------------------------------------------

export function findIssues(doc: ParsedDocument): EvaluationIssue[] {
  const issues: EvaluationIssue[] = [];
  const { root, raw } = doc;
  const scan = scanSource(raw);

  for (const token of scan.unclosed.slice(0, 5)) {
    issues.push({
      severity: 'error',
      code: 'unclosed-tag',
      message: `<${token.tag}> is opened on line ${token.line} but never closed.`,
      line: token.line,
    });
  }

  for (const token of scan.stray.slice(0, 5)) {
    issues.push({
      severity: 'error',
      code: 'stray-closing-tag',
      message: `</${token.tag}> on line ${token.line} closes a tag that was never opened.`,
      line: token.line,
    });
  }

  for (const problem of scan.misnested.slice(0, 5)) {
    issues.push({
      severity: 'error',
      code: 'misnested-tag',
      message:
        `</${problem.tag}> on line ${problem.line} closes out of order — ` +
        `<${problem.expected}> was opened more recently and must be closed first.`,
      line: problem.line,
    });
  }

  for (const problem of scan.autoClosed.slice(0, 4)) {
    issues.push({
      severity: 'error',
      code: 'invalid-nesting',
      message:
        `<${problem.child}> cannot be placed inside <${problem.parent}> (line ${problem.line}). ` +
        `The browser silently closed the <${problem.parent}> before it, so the structure you get ` +
        'is not the one you wrote.',
      line: problem.line,
    });
  }

  for (const problem of scan.unterminatedAttributes.slice(0, 3)) {
    issues.push({
      severity: 'error',
      code: 'unterminated-attribute',
      message: `An attribute quote is not closed on line ${problem.line}: ${problem.snippet}…`,
      line: problem.line,
    });
  }

  const ids = collectIds(root);
  const seen = new Set<string>();
  for (const id of ids) {
    if (seen.has(id)) {
      issues.push({
        severity: 'error',
        code: 'duplicate-id',
        message: `The id "${id}" is used more than once. Ids must be unique on a page.`,
      });
    }
    seen.add(id);
  }

  const deprecated = [...doc.tagNames].filter((t) => DEPRECATED_ELEMENTS.has(t));
  for (const tag of deprecated) {
    issues.push({
      severity: 'warning',
      code: 'deprecated-element',
      message: `<${tag}> was removed from HTML and should not be used.`,
    });
  }

  for (const problem of findInvalidNesting(root).slice(0, 5)) {
    issues.push({ severity: 'error', code: 'invalid-nesting', message: `${problem}.` });
  }

  for (const img of safeQueryAll(root, 'img')) {
    if (!hasAltAttribute(img)) {
      issues.push({
        severity: 'warning',
        code: 'img-missing-alt',
        message: 'An <img> has no alt attribute. Add descriptive text, or alt="" if it is purely decorative.',
      });
      break;
    }
  }

  if (safeQueryAll(root, 'script').length > 0) {
    issues.push({
      severity: 'warning',
      code: 'script-ignored',
      message: 'The preview does not run JavaScript. Scripts in your code are shown but never executed.',
    });
  }

  return issues;
}

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

export interface EvaluateOptions {
  /** Blocking source errors normally fail the submission; tests can relax this. */
  failOnSourceErrors?: boolean;
}

export function evaluateSubmission(
  html: string,
  requirements: Requirement[],
  options: EvaluateOptions = {},
): EvaluationResult {
  const { failOnSourceErrors = true } = options;
  const doc = parseDocument(html);

  // Built once and shared: parsing every <style> block for each requirement
  // would be wasted work on an exercise with a dozen CSS checks.
  const needsCss = requirements.some((req) => CSS_REQUIREMENT_KINDS.has(req.kind));
  const cssContext = needsCss ? buildCssContext(doc) : null;

  const results = [...requirements]
    .sort((a, b) => a.ordinal - b.ordinal)
    .map((req) =>
      cssContext && CSS_REQUIREMENT_KINDS.has(req.kind)
        ? cssRequirementResult(req, checkCssRequirement(req, doc, cssContext))
        : checkRequirement(req, doc),
    );

  const issues = findIssues(doc);

  const totalWeight = results.reduce((sum, r) => sum + r.weight, 0);
  const earned = results.reduce((sum, r) => sum + (r.passed ? r.weight : 0), 0);
  const score = totalWeight === 0 ? 0 : Math.round((earned / totalWeight) * 1000) / 1000;

  const criticalFailures = results.filter((r) => !r.passed && r.isCritical);
  const blockingIssues = issues.filter(
    (i) => i.severity === 'error' && i.code !== 'invalid-nesting',
  );

  const passed =
    criticalFailures.length === 0 &&
    (!failOnSourceErrors || blockingIssues.length === 0) &&
    results.length > 0;

  return { passed, score, results, issues, summary: buildSummary(passed, results, issues) };
}

function buildSummary(
  passed: boolean,
  results: RequirementResult[],
  issues: EvaluationIssue[],
): string {
  const total = results.length;
  const met = results.filter((r) => r.passed).length;

  if (passed) {
    const warnings = issues.filter((i) => i.severity === 'warning').length;
    if (warnings > 0) {
      return `All ${total} requirements met. There ${PLURAL(warnings, 'is', 'are')} still ${warnings} ${PLURAL(warnings, 'suggestion', 'suggestions')} worth reading.`;
    }
    return `All ${total} requirements met — nicely done.`;
  }

  const blocking = issues.find((i) => i.severity === 'error');
  if (blocking) {
    return `${met} of ${total} requirements met. Fix this first: ${blocking.message}`;
  }

  const firstFailure = results.find((r) => !r.passed && r.isCritical);
  if (firstFailure) {
    return `${met} of ${total} requirements met. Next: ${firstFailure.message}`;
  }

  return `${met} of ${total} requirements met.`;
}
