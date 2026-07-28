import { describe, expect, it } from 'vitest';
import { evaluateSubmission, findInvalidNesting, findIssues } from '@/lib/evaluator/evaluate';
import { parseDocument, scanSource } from '@/lib/evaluator/parse';
import { accessibleName, assessAltText, labelTextFor } from '@/lib/evaluator/accessible-name';
import { mediaPathExists } from '@/lib/evaluator/media-index';
import { requirementFromRow, type Requirement } from '@/lib/evaluator/types';
import type { ExerciseRequirementRow } from '@/lib/supabase/database.types';

/**
 * Evaluator tests.
 *
 * The central promise of the evaluator is that it judges *structure*, never
 * wording — two learners writing entirely different content must both pass a
 * structural requirement. Several tests below assert exactly that.
 */

let ordinal = 0;
function req(partial: Partial<Requirement> & { kind: Requirement['kind'] }): Requirement {
  ordinal += 1;
  return {
    id: `req-${ordinal}`,
    ordinal,
    selector: null,
    attribute: null,
    expectedValue: null,
    ancestorSelector: null,
    minCount: null,
    maxCount: null,
    message: 'requirement',
    hint: null,
    weight: 1,
    isCritical: true,
    condition: null,
    ...partial,
  };
}

/**
 * The stored-row → requirement mapping.
 *
 * Two callers grade the same exercises: the lesson page and the review queue.
 * They share this function, because a learner who passes an exercise in a
 * lesson and then fails its review on identical markup would rightly conclude
 * the checker is arbitrary.
 */
describe('requirements loaded from the database', () => {
  const row: ExerciseRequirementRow = {
    id: 'row-1',
    exercise_id: 'exercise-1',
    ordinal: 2,
    kind: 'element_count',
    selector: 'p',
    attribute: null,
    expected_value: null,
    ancestor_selector: null,
    min_count: 2,
    max_count: 2,
    message: 'Two paragraphs',
    hint: 'Add a second <p>.',
    // Postgres returns numeric as a string through PostgREST, which is why the
    // mapping coerces rather than trusting the type.
    weight: 0.5 as unknown as number,
    is_critical: false,
    condition: null,
    created_at: '2026-01-01T00:00:00Z',
  };

  it('carries every field the evaluator grades on', () => {
    expect(requirementFromRow(row)).toEqual({
      id: 'row-1',
      ordinal: 2,
      kind: 'element_count',
      selector: 'p',
      attribute: null,
      expectedValue: null,
      ancestorSelector: null,
      minCount: 2,
      maxCount: 2,
      message: 'Two paragraphs',
      hint: 'Add a second <p>.',
      weight: 0.5,
      isCritical: false,
      condition: null,
    });
  });

  it('coerces a numeric weight arriving as a string', () => {
    const asString = { ...row, weight: '0.5' as unknown as number };
    expect(requirementFromRow(asString).weight).toBe(0.5);
  });

  it('grades a review of an exercise exactly as its lesson would', () => {
    const requirements = [requirementFromRow(row)];
    const submission = '<p>One</p><p>Two</p>';

    // Same rows, same mapping, same evaluator — so the verdict cannot differ
    // between the two surfaces that call it.
    const inLesson = evaluateSubmission(submission, requirements);
    const inReview = evaluateSubmission(submission, requirements);

    expect(inReview.passed).toBe(inLesson.passed);
    expect(inReview.score).toBe(inLesson.score);
    expect(inLesson.passed).toBe(true);
  });
});

describe('structural evaluation, not string comparison', () => {
  const requirements = [
    req({ kind: 'unique_element', selector: 'main', message: 'One <main>' }),
    req({ kind: 'unique_element', selector: 'h1', message: 'One <h1>' }),
    req({ kind: 'element_count', selector: 'p', minCount: 2, maxCount: 2, message: 'Two paragraphs' }),
    req({ kind: 'alt_quality', selector: 'img', message: 'Images have meaningful alt text' }),
  ];

  it('passes two completely different submissions with the same structure', () => {
    const first = `
      <main>
        <h1>Riverside Cycle Hire</h1>
        <p>We rent bikes by the hour.</p>
        <p>Every hire includes a helmet.</p>
        <img src="/learning-media/images/coast-sunrise.jpg"
             alt="Sunrise over a calm sea with low headlands">
      </main>`;

    const second = `
      <main>
        <h1>Northgate Dental Practice</h1>
        <p>Accepting new NHS patients from September.</p>
        <p>Emergency appointments are kept free every morning.</p>
        <img src="/learning-media/images/studio-desk.jpg"
             alt="An open laptop and a notebook on a wooden desk">
      </main>`;

    expect(evaluateSubmission(first, requirements).passed).toBe(true);
    expect(evaluateSubmission(second, requirements).passed).toBe(true);
  });

  it('fails when the structure is wrong, however good the prose', () => {
    const wrong = `
      <main>
        <h1>Riverside Cycle Hire</h1>
        <h1>A second competing heading</h1>
        <p>Only one paragraph here.</p>
        <img src="/learning-media/images/coast-sunrise.jpg" alt="image">
      </main>`;

    const result = evaluateSubmission(wrong, requirements);
    expect(result.passed).toBe(false);
    expect(result.results.filter((r) => !r.passed)).toHaveLength(3);
  });

  it('reports a weighted score rather than a pass/fail only', () => {
    const partial = '<main><h1>Title</h1><p>One</p><p>Two</p></main>';
    const result = evaluateSubmission(partial, requirements);
    expect(result.score).toBeGreaterThan(0.5);
    expect(result.score).toBeLessThan(1);
  });
});

describe('individual requirement kinds', () => {
  it('checks the doctype', () => {
    expect(
      evaluateSubmission('<!DOCTYPE html><html lang="en"></html>', [req({ kind: 'doctype' })]).passed,
    ).toBe(true);
    expect(evaluateSubmission('<html></html>', [req({ kind: 'doctype' })]).passed).toBe(false);
  });

  it('checks nesting via an ancestor selector', () => {
    const requirement = req({
      kind: 'nesting',
      selector: 'h1',
      ancestorSelector: 'main',
      message: 'The h1 is inside main',
    });
    expect(evaluateSubmission('<main><h1>Hi</h1></main>', [requirement]).passed).toBe(true);
    expect(evaluateSubmission('<h1>Hi</h1><main></main>', [requirement]).passed).toBe(false);
  });

  it('checks direct children specifically', () => {
    const requirement = req({
      kind: 'direct_child',
      selector: 'li',
      ancestorSelector: 'ul',
      message: 'List items are direct children',
    });
    expect(evaluateSubmission('<ul><li>a</li></ul>', [requirement]).passed).toBe(true);
  });

  it('checks attribute values case-insensitively but exactly', () => {
    const requirement = req({
      kind: 'attribute_value',
      selector: 'a',
      attribute: 'href',
      expectedValue: 'about.html',
      message: 'Points at about.html',
    });
    expect(evaluateSubmission('<a href="about.html">About</a>', [requirement]).passed).toBe(true);
    expect(evaluateSubmission('<a href="/about.html">About</a>', [requirement]).passed).toBe(false);
  });

  it('checks attributes against a pattern', () => {
    const requirement = req({
      kind: 'attribute_matches',
      selector: 'time',
      attribute: 'datetime',
      expectedValue: '^\\d{4}-\\d{2}-\\d{2}',
      message: 'ISO date',
    });
    expect(
      evaluateSubmission('<time datetime="2026-09-03">3 Sept</time>', [requirement]).passed,
    ).toBe(true);
    expect(
      evaluateSubmission('<time datetime="03/09/2026">3 Sept</time>', [requirement]).passed,
    ).toBe(false);
  });

  it('validates heading order', () => {
    const requirement = req({ kind: 'heading_order', message: 'Heading order' });
    expect(
      evaluateSubmission('<h1>A</h1><h2>B</h2><h3>C</h3><h2>D</h2>', [requirement]).passed,
    ).toBe(true);
    expect(evaluateSubmission('<h1>A</h1><h3>B</h3>', [requirement]).passed).toBe(false);
    expect(evaluateSubmission('<h2>A</h2><h3>B</h3>', [requirement]).passed).toBe(false);
    expect(evaluateSubmission('<h1>A</h1><h1>B</h1>', [requirement]).passed).toBe(false);
  });

  it('detects duplicate ids', () => {
    const requirement = req({ kind: 'no_duplicate_ids', message: 'Unique ids' });
    expect(evaluateSubmission('<p id="a"></p><p id="b"></p>', [requirement]).passed).toBe(true);
    expect(evaluateSubmission('<p id="a"></p><p id="a"></p>', [requirement]).passed).toBe(false);
  });

  it('detects scripts and inline event handlers', () => {
    const requirement = req({ kind: 'no_inline_script', message: 'No scripts', isCritical: true });
    expect(evaluateSubmission('<p>Safe</p>', [requirement]).passed).toBe(true);
    expect(evaluateSubmission('<script>alert(1)</script>', [requirement]).passed).toBe(false);
    expect(evaluateSubmission('<div onclick="go()">x</div>', [requirement]).passed).toBe(false);
    expect(evaluateSubmission('<a href="javascript:go()">x</a>', [requirement]).passed).toBe(false);
  });

  it('rejects obsolete elements', () => {
    const requirement = req({ kind: 'no_deprecated_elements', message: 'No obsolete elements' });
    expect(evaluateSubmission('<p>Fine</p>', [requirement]).passed).toBe(true);
    expect(evaluateSubmission('<center>Old</center>', [requirement]).passed).toBe(false);
  });

  it('checks form label association', () => {
    const requirement = req({ kind: 'label_association', selector: 'input', message: 'Labelled' });
    expect(
      evaluateSubmission(
        '<label for="email">Email</label><input id="email" type="email">',
        [requirement],
      ).passed,
    ).toBe(true);
    expect(evaluateSubmission('<input type="email" placeholder="Email">', [requirement]).passed).toBe(
      false,
    );
  });

  it('accepts a wrapping label as an association', () => {
    const requirement = req({ kind: 'label_association', selector: 'input', message: 'Labelled' });
    expect(
      evaluateSubmission('<label>Email <input type="email"></label>', [requirement]).passed,
    ).toBe(true);
  });
});

describe('media path validation', () => {
  it('accepts real library paths', () => {
    expect(mediaPathExists('/learning-media/images/coast-sunrise.jpg')).toBe(true);
    expect(mediaPathExists('/learning-media/images/coast-sunrise-800.jpg')).toBe(true);
    expect(mediaPathExists('/learning-media/video/page-anatomy.mp4')).toBe(true);
    expect(mediaPathExists('/learning-media/captions/page-anatomy.en.vtt')).toBe(true);
  });

  it('rejects paths that do not exist', () => {
    expect(mediaPathExists('/learning-media/images/coast-sunrise-900.jpg')).toBe(false);
    expect(mediaPathExists('/learning-media/img/coast-sunrise.jpg')).toBe(false);
    expect(mediaPathExists('')).toBe(false);
  });

  it('rejects hotlinked remote URLs', () => {
    expect(mediaPathExists('https://example.com/photo.jpg')).toBe(false);
    expect(mediaPathExists('//example.com/photo.jpg')).toBe(false);
  });

  it("accepts relative paths inside a learner's own project folders", () => {
    expect(mediaPathExists('images/logo.svg')).toBe(true);
    expect(mediaPathExists('../images/logo.svg')).toBe(true);
    expect(mediaPathExists('assets/media/tour.mp4')).toBe(true);
  });

  it('reports broken media through the evaluator', () => {
    const requirement = req({ kind: 'local_media_path', selector: 'img', message: 'Media resolves' });
    expect(
      evaluateSubmission(
        '<img src="/learning-media/images/forest-path.jpg" alt="A forest path between tall trees">',
        [requirement],
      ).passed,
    ).toBe(true);
    expect(
      evaluateSubmission('<img src="/learning-media/images/nope.jpg" alt="Missing">', [requirement])
        .passed,
    ).toBe(false);
  });

  it('checks every candidate in a srcset', () => {
    const requirement = req({ kind: 'local_media_path', selector: 'img', message: 'Media resolves' });
    const broken =
      '<img src="/learning-media/images/coast-sunrise-800.jpg" ' +
      'srcset="/learning-media/images/coast-sunrise-480.jpg 480w, ' +
      '/learning-media/images/coast-sunrise-900.jpg 900w" alt="Sunrise over a calm sea">';
    expect(evaluateSubmission(broken, [requirement]).passed).toBe(false);
  });
});

describe('alt text quality', () => {
  it('accepts a genuine description', () => {
    expect(assessAltText('Sunrise over a calm sea with low headlands').ok).toBe(true);
  });

  it('rejects filenames, placeholders and redundant prefixes', () => {
    expect(assessAltText('photo.jpg').ok).toBe(false);
    expect(assessAltText('image').ok).toBe(false);
    expect(assessAltText('Image of a bicycle').ok).toBe(false);
    expect(assessAltText('logo').ok).toBe(false);
    expect(assessAltText('').ok).toBe(false);
    expect(assessAltText('a'.repeat(300)).ok).toBe(false);
  });

  it('treats an explicitly empty alt as a decorative decision, not a failure', () => {
    const requirement = req({ kind: 'alt_quality', selector: 'img', message: 'Alt text' });
    expect(evaluateSubmission('<img src="/learning-media/svg/placeholder.svg" alt="">', [requirement]).passed).toBe(true);
    expect(evaluateSubmission('<img src="/learning-media/svg/placeholder.svg">', [requirement]).passed).toBe(false);
  });
});

describe('accessible names', () => {
  const nameOf = (html: string, selector: string) => {
    const doc = parseDocument(html);
    const element = doc.root.querySelector(selector);
    return element ? accessibleName(element, doc.root) : '';
  };

  it('prefers aria-labelledby, then aria-label, then content', () => {
    expect(
      nameOf('<h2 id="t">Opening hours</h2><section aria-labelledby="t"></section>', 'section'),
    ).toBe('Opening hours');
    expect(nameOf('<button aria-label="Search"><span>x</span></button>', 'button')).toBe('Search');
    expect(nameOf('<button>Send enquiry</button>', 'button')).toBe('Send enquiry');
  });

  it('reads a name from a native label, a legend and a caption', () => {
    expect(nameOf('<label for="e">Email</label><input id="e">', 'input')).toBe('Email');
    expect(nameOf('<fieldset><legend>Bike type</legend></fieldset>', 'fieldset')).toBe('Bike type');
    expect(nameOf('<table><caption>Rates</caption></table>', 'table')).toBe('Rates');
    expect(nameOf('<iframe title="A map of Mill Lane"></iframe>', 'iframe')).toBe(
      'A map of Mill Lane',
    );
  });

  it('finds a wrapping label', () => {
    const doc = parseDocument('<label>Email <input type="email"></label>');
    const input = doc.root.querySelector('input');
    expect(input && labelTextFor(input, doc.root)).toBe('Email');
  });
});

describe('source scanning finds what a DOM parser repairs', () => {
  it('finds an unclosed element', () => {
    const scan = scanSource('<main>\n  <section>\n    <p>Hello</p>\n</main>');
    expect(scan.unclosed.map((t) => t.tag)).toContain('section');
  });

  it('finds a stray closing tag', () => {
    const scan = scanSource('<p>Hello</p></div>');
    expect(scan.stray.map((t) => t.tag)).toContain('div');
  });

  it('finds overlapping tags', () => {
    const scan = scanSource('<p>Open <em>daily</p></em>');
    expect(scan.misnested).toHaveLength(1);
    expect(scan.misnested[0]?.tag).toBe('p');
  });

  it('ignores markup written inside a script, style or textarea', () => {
    const scan = scanSource('<textarea><div></textarea><p>Fine</p>');
    expect(scan.unclosed).toHaveLength(0);
  });

  it('finds an unterminated attribute quote', () => {
    const scan = scanSource('<img src="/a.jpg alt="A picture">');
    expect(scan.unterminatedAttributes.length).toBeGreaterThan(0);
  });

  it('does not count void elements as unclosed', () => {
    const scan = scanSource('<p>Line<br>break<hr><img src="a.jpg" alt="a"></p>');
    expect(scan.unclosed).toHaveLength(0);
  });
});

describe('nesting rules', () => {
  // Combines the DOM check with the source scan, because a browser auto-closes
  // some invalid nesting before the DOM exists.
  const problems = (html: string) => [
    ...findInvalidNesting(parseDocument(html).root),
    ...scanSource(html).autoClosed.map((p) => `<${p.child}> inside <${p.parent}>`),
  ];

  it('rejects list items outside a list', () => {
    expect(problems('<div><li>Orphan</li></div>').length).toBeGreaterThan(0);
  });

  it('rejects a block element inside a paragraph', () => {
    expect(problems('<p>Text<div>Block</div></p>').length).toBeGreaterThan(0);
  });

  it('rejects nested links and nested forms', () => {
    expect(problems('<a href="#"><a href="#">x</a></a>').length).toBeGreaterThan(0);
    expect(problems('<form><form></form></form>').length).toBeGreaterThan(0);
  });

  it('accepts legal structures', () => {
    expect(problems('<ul><li>One<ul><li>Nested</li></ul></li></ul>')).toEqual([]);
    expect(
      problems('<table><caption>C</caption><tbody><tr><th scope="row">A</th><td>1</td></tr></tbody></table>'),
    ).toEqual([]);
    expect(problems('<figure><img src="a.jpg" alt="a"><figcaption>Cap</figcaption></figure>')).toEqual([]);
  });
});

describe('document-wide issues', () => {
  it('reports an unclosed tag with its line number', () => {
    const issues = findIssues(parseDocument('<main>\n  <section>\n    <p>Hi</p>\n</main>'));
    const unclosed = issues.find((i) => i.code === 'unclosed-tag');
    expect(unclosed).toBeDefined();
    expect(unclosed?.line).toBe(2);
  });

  it('warns rather than fails on a missing alt attribute', () => {
    const issues = findIssues(parseDocument('<img src="a.jpg">'));
    const issue = issues.find((i) => i.code === 'img-missing-alt');
    expect(issue?.severity).toBe('warning');
  });

  it('fails a submission that has blocking source errors', () => {
    const requirement = req({ kind: 'element_present', selector: 'p', message: 'A paragraph' });
    const result = evaluateSubmission('<main><p>Hi</p>', [requirement]);
    expect(result.results[0]?.passed).toBe(true);
    expect(result.passed).toBe(false);
    expect(result.summary).toContain('Fix this first');
  });
});
