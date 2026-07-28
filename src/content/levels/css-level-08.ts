import {
  activeRecap,
  callout,
  checklist,
  code,
  compare,
  cssIs,
  cssMatches,
  demo,
  detail,
  objectives,
  predictCheck,
  pretest,
  recall,
  recap,
  selfExplain,
  term,
  workedExample,
  type LevelSpec,
} from '../types';

/**
 * CSS Level 8 — typography and colour.
 *
 * Deliberately taught as engineering rather than taste. Line length, line
 * height and contrast ratio all have defensible numbers behind them, and two of
 * them are accessibility requirements. What is genuinely a matter of taste is
 * marked as such, so the learner can tell the difference.
 */
export const CSS_LEVEL_08: LevelSpec = {
  slug: 'css-typography',
  title: 'Typography and Colour',
  subtitle: 'The parts that are requirements, not taste',
  summary:
    'Most typography advice is presented as taste. A useful amount of it is not: line length, line height and contrast ratio have numbers behind them, and two of those numbers are accessibility requirements.',
  outcome:
    'You can set readable type on a scale and choose colours that meet contrast requirements.',
  accent: 'violet',
  modules: [
    {
      slug: 'css-type-colour',
      title: 'Type and colour systems',
      summary: 'Scale, measure, rhythm, contrast — and which of those you may not compromise on.',
      estimatedMinutes: 52,
      prerequisites: ['css-tokens'],
      skills: [{ slug: 'typography', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'css-readable-type',
          title: 'Readable type',
          subtitle: 'Measure, leading and scale',
          summary:
            'Three numbers do most of the work: how long a line is, how far apart lines sit, and how sizes relate to each other.',
          objectives: [
            'Set a comfortable line length',
            'Choose line height as a ratio',
            'Build a modular type scale',
          ],
          estimatedMinutes: 17,
          skill: 'typography',
          blocks: [
            pretest(
              'A paragraph of body text runs the full width of a 1400px screen. Why is that hard to read?',
              [
                'The eye loses its place returning to the start of the next line',
                'Long lines render more slowly',
                'Browsers cannot hyphenate long lines',
                'It is not a problem; wider is always better',
              ],
              'The return sweep. At the end of a very long line the eye has to travel a long way back and find the start of the next one, and it increasingly lands on the wrong line. This is why the recommendation is roughly 45–75 characters per line — and why `max-width: 65ch` on your text container is one of the highest-value single declarations in CSS.',
            ),
            objectives([
              'Constrain line length with `ch`',
              'Set line height as a unitless ratio and explain why',
              'Generate a type scale from one ratio',
            ]),
            term(
              'Measure',
              'The length of a line of text, counted in characters. Comfortable body text sits at roughly 45–75.',
            ),
            term(
              'Leading',
              'The vertical distance between lines of text — `line-height` in CSS. Body text usually wants 1.5 or more.',
            ),
            code(
              `.prose      { max-width: 65ch; }      measure
body        { line-height: 1.5; }     leading, unitless
h1          { line-height: 1.1; }     large text needs less

1ch = the width of the "0" glyph in the current font,
so 65ch tracks the font rather than guessing at pixels.`,
              'The three numbers',
              'text',
            ),
            callout(
              'warning',
              'Line height must be unitless',
              '`line-height: 1.5` inherits as the *ratio*, so each descendant computes its own spacing from its own font size. `line-height: 24px` inherits as 24px, so a heading at 40px gets 24px of line height and its lines collide. This is one of the few places where the unit changes what inheritance means, and it catches people repeatedly.',
            ),
            demo('Measure and leading', 'The same paragraph, three settings.', [
              {
                label: 'Unconstrained',
                code: '<style>\n  p { line-height: 1.2; }\n</style>\n<p>Sourdough is a slow bread. The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours. A loaf that would take three hours with commercial yeast takes a day or more, and most of that time is waiting rather than working. The waiting is the technique.</p>',
                note: 'Full width, tight leading. Notice how hard it is to find the next line.',
              },
              {
                label: 'Measure constrained',
                code: '<style>\n  p { max-width: 65ch; line-height: 1.2; }\n</style>\n<p>Sourdough is a slow bread. The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours. A loaf that would take three hours with commercial yeast takes a day or more, and most of that time is waiting rather than working. The waiting is the technique.</p>',
                note: 'One declaration, and the return sweep is short again.',
              },
              {
                label: 'Both',
                code: '<style>\n  p { max-width: 65ch; line-height: 1.6; }\n</style>\n<p>Sourdough is a slow bread. The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours. A loaf that would take three hours with commercial yeast takes a day or more, and most of that time is waiting rather than working. The waiting is the technique.</p>',
                note: 'Comfortable leading as well. This is the baseline every text page should start from.',
              },
            ]),
            workedExample(
              'Building a type scale',
              'Sizes chosen by a ratio rather than one at a time.',
              [
                {
                  title: 'Pick a base and a ratio',
                  code: `:root {
  --text-base: 1rem;    /* 16px, the browser default */
  --ratio: 1.25;        /* major third */
}`,
                  reasoning:
                    'Starting from `1rem` means the reader\'s own browser font-size setting is honoured — someone who set 20px because they need it gets a proportionally larger page rather than being overridden.',
                },
                {
                  title: 'Derive the steps',
                  code: `:root {
  --text-sm:  0.8rem;    /* base ÷ 1.25 */
  --text-base: 1rem;
  --text-lg:  1.25rem;   /* base × 1.25 */
  --text-xl:  1.563rem;  /* × 1.25 again */
  --text-2xl: 1.953rem;
}`,
                  reasoning:
                    'Each step is the previous one multiplied by the ratio. The sizes then relate to each other by construction, which is what makes a page look deliberate rather than assembled.',
                },
                {
                  title: 'Use the steps, never raw numbers',
                  code: `h1 { font-size: var(--text-2xl); line-height: 1.1; }
h2 { font-size: var(--text-xl);  line-height: 1.2; }
p  { font-size: var(--text-base); }
small { font-size: var(--text-sm); }`,
                  reasoning:
                    'A stylesheet with five sizes in it looks designed. One with `font-size: 17px` in nineteen different places does not, and cannot be adjusted globally.',
                },
                {
                  title: 'Tighten leading as size grows',
                  code: `h1 { line-height: 1.1; }
p  { line-height: 1.6; }`,
                  reasoning:
                    'Leading is proportional, so a large heading at 1.6 gets a cavernous gap. Big text needs a smaller ratio; small text needs a larger one.',
                },
              ],
            ),
            predictCheck(
              `<style>
  body { font-size: 16px; line-height: 32px; }
  h1 { font-size: 48px; }
</style>
<h1>A heading that will wrap onto two lines here</h1>`,
              'The line height is 32px and the heading is 48px. Before you check: what happens to the heading?',
              'Its lines overlap. `line-height: 32px` inherits as a fixed 32px, so a 48px heading gets 32px of line box — less than the text is tall. Had it been written `line-height: 2`, the heading would have computed 96px from its own font size. The unitless form is not a style preference; it is the only form that survives inheritance.',
            ),
            detail(
              'Why `rem` and not `px` for font size',
              'A reader who has set their browser default to 20px has usually done it because they need to. `font-size: 16px` overrides that decision; `font-size: 1rem` honours it, and the whole scale moves with it. This is the single most common accessibility failure in otherwise careful stylesheets. Use `rem` for type, and `px` only where a value genuinely should not scale — a hairline border, for instance.',
            ),
            recap(
              [
                'Constrain measure to roughly 45–75 characters — `max-width: 65ch`.',
                'Set `line-height` unitless so it inherits as a ratio.',
                'Build sizes from one base and one ratio, held in tokens.',
                'Size type in `rem` so the reader’s own setting is honoured.',
              ],
              'Next: colour and contrast.',
            ),
            activeRecap(
              [
                'Why must `line-height` be unitless?',
                'What does `65ch` mean, and why is it better than a pixel width?',
                'Why size type in `rem` rather than `px`?',
              ],
              [
                'Because it inherits as a ratio, so each element computes its spacing from its own font size. A fixed length inherits as that same length, and large text ends up with lines that collide.',
                'The width of 65 zero-glyphs in the current font — so it tracks the actual typeface rather than guessing. Change the font and the measure stays right.',
                'Because `rem` is relative to the reader’s browser font-size setting, which they may have raised because they need it. A pixel size silently overrides that decision.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-type-guided',
              kind: 'guided',
              title: 'Set readable body text',
              brief:
                'Give `.prose` a `max-width` of `65ch` and a unitless `line-height` of `1.6`. Give `h1` a `font-size` of `2rem` and a `line-height` of `1.1`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Type</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .prose { }
      h1 { }
    </style>
  </head>
  <body>
    <div class="prose">
      <h1>Sourdough, slowly</h1>
      <p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours.</p>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Type</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .prose {
        max-width: 65ch;
        line-height: 1.6;
      }

      h1 {
        font-size: 2rem;
        line-height: 1.1;
      }
    </style>
  </head>
  <body>
    <div class="prose">
      <h1>Sourdough, slowly</h1>
      <p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours.</p>
    </div>
  </body>
</html>`,
              hints: [
                'The ch unit measures character widths in the current font.',
                'Line height takes no unit — just the number.',
                'Large text wants a tighter ratio than body text.',
              ],
              requirements: [
                cssIs('.prose', 'max-width', '65ch', 'The measure is constrained'),
                cssIs('.prose', 'line-height', '1.6', 'Body leading is comfortable and unitless'),
                cssIs('h1', 'font-size', '2rem', 'The heading is sized in rem'),
                cssIs('h1', 'line-height', '1.1', 'The heading leading is tightened'),
              ],
              difficulty: 2,
              xp: 45,
              skill: 'typography',
            },
          ],
          quiz: [
            {
              slug: 'q-css-measure',
              prompt: 'Roughly how many characters per line reads comfortably?',
              explanation: 'About 45–75. Beyond that the return sweep starts to fail.',
              options: [
                { label: '45–75', correct: true },
                { label: '20–30' },
                { label: '100–140' },
                { label: 'As many as fit' },
              ],
              skill: 'typography',
            },
            {
              slug: 'q-css-lineheight-unit',
              prompt: 'Why should `line-height` be unitless?',
              explanation: 'It inherits as a ratio, so each element computes from its own font size.',
              options: [
                { label: 'It inherits as a ratio rather than a fixed length', correct: true },
                { label: 'Units are invalid on line-height' },
                { label: 'It renders faster' },
                { label: 'It increases specificity' },
              ],
              skill: 'typography',
            },
            {
              slug: 'q-css-rem-type',
              prompt: 'Why size body text in `rem` rather than `px`?',
              explanation: 'It honours the reader’s own browser font-size setting.',
              options: [
                { label: 'It respects the reader’s browser font-size setting', correct: true },
                { label: 'It is more precise' },
                { label: 'px is deprecated' },
                { label: 'rem is faster to parse' },
              ],
              skill: 'typography',
            },
          ],
        },
        {
          slug: 'css-colour-contrast',
          title: 'Colour and contrast',
          subtitle: 'Where taste stops and requirements begin',
          summary:
            'Which colours you choose is taste. Whether text can be read against its background is a measurable requirement with a number attached.',
          objectives: [
            'Explain the WCAG contrast thresholds',
            'Build a colour system on roles',
            'Never signal meaning by colour alone',
          ],
          estimatedMinutes: 17,
          skill: 'typography',
          blocks: [
            pretest(
              'Light grey text on white looks elegant in the mock-up. What is the problem?',
              [
                'It may fail the contrast requirement, which is measurable and not a matter of taste',
                'Grey text renders slowly',
                'Grey is not a valid CSS colour',
                'Nothing — if the designer approved it, it is fine',
              ],
              'It probably fails contrast. WCAG sets 4.5:1 for normal body text and 3:1 for large text, and light-grey-on-white routinely lands near 2:1. This is the point where design opinion stops: someone with low vision, or anyone outdoors in sunlight, cannot read it. The number decides, not the mock-up.',
            ),
            objectives([
              'Apply the 4.5:1 and 3:1 thresholds',
              'Organise colour by role',
              'Pair colour with a second signal',
            ]),
            term(
              'Contrast ratio',
              'A measure of the relative luminance of two colours, from 1:1 (identical) to 21:1 (black on white). Body text needs at least 4.5:1.',
            ),
            code(
              `4.5:1   normal body text                  required
3:1     large text (24px, or 18.7px bold)    required
3:1     UI components and focus indicators   required
7:1     enhanced (AAA) for body text         stricter target

Measured between the text colour and what is actually
behind it — including any background image.`,
              'The thresholds',
              'text',
            ),
            compare(
              'Colour as the only signal',
              {
                label: 'Colour plus a second signal',
                code: `.error {
  color: #b00020;
  border-left: 3px solid currentColor;
}
/* and the message text says "Error:" */`,
                why: 'Readable to someone who cannot distinguish red from green, and to someone reading a printout in black and white.',
              },
              {
                label: 'Colour alone',
                code: `.error { color: red; }
.success { color: green; }
/* the only difference between the two states */`,
                why: 'Around one in twelve men cannot reliably tell these apart. The state becomes invisible.',
              },
            ),
            demo('Contrast, seen', 'The same text against the same background.', [
              {
                label: 'Fails',
                code: '<style>\n  .note { color: #aaa; background: #fff; padding: 1rem; }\n</style>\n<p class="note">Roughly 2.3:1 — under the 4.5:1 requirement for body text.</p>',
                note: 'This is the light-grey-on-white that appears in a great many mock-ups.',
              },
              {
                label: 'Passes',
                code: '<style>\n  .note { color: #595959; background: #fff; padding: 1rem; }\n</style>\n<p class="note">Roughly 7:1 — comfortably over the requirement, and still grey.</p>',
                note: 'Darkening the same hue keeps the intended restraint and clears the threshold.',
              },
              {
                label: 'Colour plus a second signal',
                code: '<style>\n  .error { color: #b00020; border-left: 3px solid currentColor; padding-left: 0.75rem; }\n</style>\n<p class="error">Error: the starter has not been fed for six days.</p>',
                note: 'The border and the word "Error" both survive when the colour does not.',
              },
            ]),
            callout(
              'tip',
              '`currentColor` keeps a component honest',
              'It resolves to whatever `color` is on that element, so a border or an SVG icon follows the text colour automatically — including through every theme override. It is the one keyword that makes "the border matches the text" true by construction rather than by discipline.',
            ),
            selfExplain(
              'Your designer says the light grey is intentional and the contrast requirement is a guideline. Write your reply.',
              'It is not a guideline in the sense of being optional: WCAG 1.4.3 is a level AA success criterion, and in many jurisdictions accessibility conformance is a legal requirement for public-facing services. But the more useful argument is the practical one — the people who cannot read light grey on white include anyone with low vision, anyone over about fifty, and everyone using the site outdoors on a phone, which is a large fraction of real traffic rather than an edge case. The restraint the designer wants is achievable: keep the same hue and darken it until it measures 4.5:1. The design intent survives; the text becomes readable. That is a better outcome than a debate about whether the rule is binding.',
            ),
            checklist('Colour system review', [
              'Body text measures at least 4.5:1 against its actual background',
              'Large text and UI components at least 3:1',
              'Focus indicators visible and at least 3:1',
              'No state signalled by colour alone',
              'Colours named by role, so themes can override them',
              'Contrast checked in both light and dark themes',
            ]),
            recap(
              [
                'Contrast is measurable: 4.5:1 for body text, 3:1 for large text and UI.',
                'Never signal meaning by colour alone.',
                '`currentColor` ties borders and icons to the text colour.',
                'Check contrast in every theme, not just the default one.',
              ],
              'Next: the Level 8 milestone.',
            ),
            activeRecap(
              [
                'What are the two contrast thresholds, and which text does each cover?',
                'Why is colour-only signalling a failure?',
                'What does `currentColor` resolve to?',
              ],
              [
                '4.5:1 for normal body text, and 3:1 for large text — 24px, or 18.7px bold — as well as for UI components and focus indicators.',
                'Because a substantial number of readers cannot distinguish the colours in question, and because the signal disappears entirely in greyscale or high-contrast modes. The state has to be carried by something else as well: a word, an icon, a border.',
                'The computed `color` of the element it is used on — so borders, outlines and icons follow the text colour through every theme automatically.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-contrast-debug',
              kind: 'debug',
              title: 'Fix the contrast failure',
              brief:
                'Two accessibility faults. The body text is `#aaa` on white, well under 4.5:1 — change it to `#595959`. And `.error` is signalled by colour alone; add `border-left: 3px solid currentColor` so the state survives without colour.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Contrast</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      body { background: #fff; color: #aaa; }

      .error {
        color: #b00020;
        padding-left: 0.75rem;
      }
    </style>
  </head>
  <body>
    <p>The starter doubles in about six hours at room temperature.</p>
    <p class="error">Error: the starter has not been fed for six days.</p>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Contrast</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      body { background: #fff; color: #595959; }

      .error {
        color: #b00020;
        border-left: 3px solid currentColor;
        padding-left: 0.75rem;
      }
    </style>
  </head>
  <body>
    <p>The starter doubles in about six hours at room temperature.</p>
    <p class="error">Error: the starter has not been fed for six days.</p>
  </body>
</html>`,
              hints: [
                'Keep the grey, but darken it until it clears 4.5:1.',
                'currentColor resolves to the element’s own color.',
                'The border gives the state a second, non-colour signal.',
              ],
              requirements: [
                cssIs('body', 'color', '#595959', 'Body text clears the contrast threshold'),
                cssMatches('.error', 'border-left', 'currentColor', 'The error state carries a non-colour signal'),
                cssIs('.error', 'color', '#b00020', 'The error colour is kept'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'typography',
            },
          ],
          quiz: [
            {
              slug: 'q-css-contrast-body',
              prompt: 'What contrast ratio does normal body text require?',
              explanation: '4.5:1 against its actual background.',
              options: [
                { label: '4.5:1', correct: true },
                { label: '2:1' },
                { label: '3:1' },
                { label: '10:1' },
              ],
              skill: 'typography',
            },
            {
              slug: 'q-css-colour-alone',
              prompt: 'Why is signalling a state by colour alone a failure?',
              explanation:
                'Many readers cannot distinguish the colours, and the signal vanishes in greyscale or high-contrast modes.',
              options: [
                { label: 'Readers who cannot distinguish the colours lose the signal entirely', correct: true },
                { label: 'Colour is slow to render' },
                { label: 'CSS colours are unreliable across browsers' },
                { label: 'It is only a problem when printing' },
              ],
              skill: 'typography',
            },
            {
              slug: 'q-css-currentcolor',
              prompt: 'What does `currentColor` resolve to?',
              explanation: 'The element’s own computed `color`.',
              options: [
                { label: 'The element’s computed `color`', correct: true },
                { label: 'The page background' },
                { label: 'The browser default colour' },
                { label: 'The last colour declared in the file' },
              ],
              skill: 'typography',
            },
          ],
        },
        {
          slug: 'css-type-milestone',
          title: 'Milestone: a readable article',
          subtitle: 'Scale, measure and contrast together',
          summary: 'Everything from this level applied to one page of text.',
          objectives: [
            'Apply a type scale from tokens',
            'Constrain measure and set leading',
            'Meet the contrast requirement',
          ],
          estimatedMinutes: 18,
          skill: 'typography',
          masteryThreshold: 0.8,
          blocks: [
            objectives(['Combine scale, measure, leading and contrast into one readable page']),
            code(
              `max-width: 65ch     measure
line-height: 1.6    leading (unitless)
font-size: 1rem     honours the reader's setting
--text-*            a scale, not ad-hoc numbers
4.5:1               contrast, non-negotiable`,
              'The whole level, in five lines',
              'text',
            ),
            recall(
              'From memory: what number belongs with each of these, and why?',
              [
                'Comfortable measure — 45–75 characters, because a longer return sweep makes the eye lose its line.',
                'Body leading — about 1.5–1.6, unitless so it inherits as a ratio.',
                'Heading leading — about 1.1, because leading is proportional and large text needs less.',
                'Body-text contrast — 4.5:1, a requirement rather than a preference.',
                'Large-text and UI contrast — 3:1.',
              ],
            ),
            recap(
              [
                'Type decisions come from numbers more often than people expect.',
                'A scale in tokens beats sizes chosen one at a time.',
                'Contrast is measured, not judged.',
              ],
              'Next: transitions and animation.',
            ),
            activeRecap(
              ['Which parts of this level are taste, and which are requirements?'],
              [
                'Taste: which typeface, which ratio for the scale, which hue. Requirements: the contrast thresholds, and honouring the reader\'s font-size setting by sizing in `rem`. Measure and leading sit in between — strongly evidenced recommendations rather than pass/fail rules, but you need a reason to depart from them.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-type-milestone-challenge',
              kind: 'challenge',
              title: 'Set an article',
              brief:
                'On `:root` define `--text-base: 1rem` and `--text-2xl: 2rem`. Give `.prose` a `max-width` of `65ch`, `line-height` `1.6`, `font-size` `var(--text-base)` and `color` `#333`. Give `h1` `font-size: var(--text-2xl)` and `line-height: 1.1`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Article</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      body { background: #fff; }
    </style>
  </head>
  <body>
    <article class="prose">
      <h1>Sourdough, slowly</h1>
      <p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours.</p>
    </article>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Article</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root {
        --text-base: 1rem;
        --text-2xl: 2rem;
      }

      body { background: #fff; }

      .prose {
        max-width: 65ch;
        line-height: 1.6;
        font-size: var(--text-base);
        color: #333;
      }

      h1 {
        font-size: var(--text-2xl);
        line-height: 1.1;
      }
    </style>
  </head>
  <body>
    <article class="prose">
      <h1>Sourdough, slowly</h1>
      <p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours.</p>
    </article>
  </body>
</html>`,
              hints: [
                'Declare both tokens on :root first.',
                'Read them back with var().',
                'Line height stays unitless.',
                '#333 on white is around 12:1 — comfortably over the requirement.',
              ],
              requirements: [
                cssIs('.prose', 'max-width', '65ch', 'The measure is constrained'),
                cssIs('.prose', 'line-height', '1.6', 'Leading is comfortable and unitless'),
                cssIs('.prose', 'font-size', '1rem', 'Body size resolves from the token'),
                cssIs('.prose', 'color', '#333', 'Body text clears the contrast requirement'),
                cssIs('h1', 'font-size', '2rem', 'The heading resolves from the scale'),
                cssIs('h1', 'line-height', '1.1', 'Heading leading is tightened'),
              ],
              difficulty: 4,
              xp: 70,
              skill: 'typography',
            },
          ],
          quiz: [
            {
              slug: 'q-css-scale-benefit',
              prompt: 'Why derive font sizes from one base and one ratio?',
              explanation:
                'The sizes then relate to each other by construction, and the whole page can be adjusted from one place.',
              options: [
                { label: 'The sizes relate to each other, and can be adjusted from one place', correct: true },
                { label: 'It reduces file size' },
                { label: 'Browsers require it' },
                { label: 'It improves specificity' },
              ],
              skill: 'typography',
            },
            {
              slug: 'q-css-heading-leading',
              prompt: 'Why do large headings want a smaller `line-height` ratio than body text?',
              explanation: 'Leading is proportional, so the same ratio produces a much larger gap at a larger size.',
              options: [
                { label: 'The ratio is proportional, so a large size produces a large gap', correct: true },
                { label: 'Headings are never more than one line' },
                { label: 'Browsers ignore line-height on headings' },
                { label: 'It is required by the spec' },
              ],
              skill: 'typography',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'css-level-8-milestone',
    kind: 'milestone',
    title: 'Level 8 milestone: Typography and Colour',
    description: 'Six questions on scale, measure, leading and contrast. Pass mark 75%.',
    passScore: 0.75,
    xp: 180,
    questions: [
      {
        slug: 'a-css-8-measure',
        prompt: 'Which declaration constrains line length to a comfortable measure?',
        explanation: '`ch` tracks the font, so 65ch stays right when the typeface changes.',
        options: [
          { label: '`max-width: 65ch`', correct: true },
          { label: '`width: 100%`' },
          { label: '`max-width: 100vw`' },
          { label: '`overflow-wrap: break-word`' },
        ],
        skill: 'typography',
      },
      {
        slug: 'a-css-8-lineheight',
        prompt: 'What goes wrong with `line-height: 24px` on `body`?',
        explanation: 'It inherits as a fixed length, so large text gets too little line box and the lines collide.',
        options: [
          { label: 'Large text inherits 24px and its lines collide', correct: true },
          { label: 'It is invalid CSS' },
          { label: 'It only applies to the body element' },
          { label: 'It disables inheritance entirely' },
        ],
        skill: 'typography',
      },
      {
        slug: 'a-css-8-rem',
        prompt: 'What does sizing type in `rem` preserve?',
        explanation: 'The reader’s own browser font-size setting.',
        options: [
          { label: 'The reader’s browser font-size setting', correct: true },
          { label: 'Pixel-perfect rendering' },
          { label: 'The element’s own font size' },
          { label: 'Print layout' },
        ],
        skill: 'typography',
      },
      {
        slug: 'a-css-8-contrast-large',
        prompt: 'What contrast ratio do large text and UI components require?',
        explanation: '3:1 — body text is the stricter 4.5:1.',
        options: [
          { label: '3:1', correct: true },
          { label: '4.5:1' },
          { label: '1.5:1' },
          { label: '7:1' },
        ],
        skill: 'typography',
      },
      {
        slug: 'a-css-8-second-signal',
        prompt: 'An error state is shown in red. What else does it need?',
        explanation: 'A second, non-colour signal — a word, an icon or a border.',
        options: [
          { label: 'A non-colour signal as well, such as text or an icon', correct: true },
          { label: 'A brighter red' },
          { label: 'A larger font size' },
          { label: 'Nothing; red is universally understood' },
        ],
        skill: 'typography',
      },
      {
        slug: 'a-css-8-currentcolor-use',
        prompt: 'Why use `currentColor` for a component’s border?',
        explanation: 'It follows the text colour through every theme, without a second token or a second rule.',
        options: [
          { label: 'The border follows the text colour through every theme automatically', correct: true },
          { label: 'It has higher specificity' },
          { label: 'It is the only way to set a border colour' },
          { label: 'It disables inheritance' },
        ],
        skill: 'typography',
      },
    ],
  },
};
