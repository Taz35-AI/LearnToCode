import {
  activeRecap,
  callout,
  checklist,
  code,
  cssIs,
  cssMatches,
  cssNotSet,
  cssSet,
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
 * CSS Level 2 — the box model and selectors.
 *
 * Second because sizing is the next thing that behaves unexpectedly, and
 * because `box-sizing: border-box` is the single highest-value line most
 * learners never get told about.
 */
export const CSS_LEVEL_02: LevelSpec = {
  slug: 'css-box-model',
  title: 'Boxes and Selectors',
  subtitle: 'How a box gets its size, and how to target exactly what you mean',
  summary:
    'Every element is a box. Four layers decide how big it is, one property changes the maths entirely, and a handful of selectors let you reach any element without escalating specificity.',
  outcome:
    'You can size any element predictably and write selectors that target precisely what you intend.',
  accent: 'violet',
  modules: [
    {
      slug: 'css-boxes',
      title: 'The box model',
      summary: 'Content, padding, border, margin — and the property that changes what width means.',
      estimatedMinutes: 50,
      prerequisites: ['css-first-rules'],
      skills: [{ slug: 'box-model', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'css-the-four-layers',
          title: 'The four layers of a box',
          subtitle: 'Content, padding, border, margin — and what `width` actually measures',
          summary:
            'An element declared 300px wide is often not 300px wide. One property fixes that, and almost every real stylesheet sets it on the first line.',
          objectives: [
            'Name the four layers of the box model',
            'Explain what `width` measures by default',
            'Use `box-sizing: border-box` and say why',
          ],
          estimatedMinutes: 16,
          skill: 'box-model',
          blocks: [
            pretest(
              'A box has `width: 300px`, `padding: 20px` and `border: 5px solid`. How wide is it on screen, by default?',
              [
                '350px — padding and border are added on top of the width',
                '300px — width means the whole box',
                '260px — padding and border eat into the width',
                '345px',
              ],
              '350px: 300 + 20 + 20 + 5 + 5. By default `width` sets the **content** box only, and padding and border are added *outside* it. This is why a layout of "four 25% columns" overflows the moment anyone adds padding, and why `box-sizing: border-box` — which makes `width` mean the whole visible box — appears at the top of nearly every professional stylesheet.',
            ),
            objectives([
              'Identify content, padding, border and margin on any element',
              'Predict the rendered width of a box',
              'Apply `border-box` sizing and explain the difference',
            ]),
            term('Content box', 'The area the text or image itself occupies. This is what `width` and `height` set by default.'),
            term('Padding', 'Space *inside* the box, between the content and the border. It takes the background colour.'),
            term('Border', 'A line drawn at the edge of the padding. It has a width, a style and a colour, and the style is required — `border: 1px solid` shows nothing without it.'),
            term('Margin', 'Space *outside* the box, pushing other elements away. It is always transparent.'),
            code(
              `┌─────────────────────────────────────┐
│ margin            (transparent)     │
│  ┌───────────────────────────────┐  │
│  │ border                        │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │ padding   (background)  │  │  │
│  │  │  ┌───────────────────┐  │  │  │
│  │  │  │ content           │  │  │  │
│  │  │  └───────────────────┘  │  │  │
│  │  └─────────────────────────┘  │  │
│  └───────────────────────────────┘  │
└─────────────────────────────────────┘

Outward from the middle: content, padding, border, margin.`,
              'The four layers',
              'text',
            ),
            workedExample(
              'Working out a real width',
              'A card is meant to be exactly half of an 800px container. Here is why the obvious answer overflows, and the two ways to fix it.',
              [
                {
                  title: 'The obvious attempt',
                  code: `.card { width: 50%; padding: 1rem; border: 1px solid; }`,
                  reasoning:
                    '50% of 800 is 400. But `width` sets the content box, so the visible box is 400 + 16 + 16 + 1 + 1 = 434px. Two of them are 868px in an 800px container, and the second wraps.',
                },
                {
                  title: 'The fix nobody should have to discover',
                  code: `*, *::before, *::after { box-sizing: border-box; }`,
                  reasoning:
                    'Now `width` means the whole visible box, so 50% is genuinely 400px and the padding and border come out of that. Two fit exactly. This is why it goes at the top of the stylesheet, applied to everything, before any component is written.',
                },
                {
                  title: 'Why the universal selector, and why the pseudo-elements',
                  code: `*, *::before, *::after { box-sizing: border-box; }`,
                  reasoning:
                    '`box-sizing` does not inherit, so setting it on `body` reaches nothing else. The universal selector is the only way to reach everything, and generated content needs it too or a `::before` sized in percentages behaves differently from its element.',
                },
                {
                  title: 'What it does not change',
                  code: `.card { width: 50%; margin: 1rem; }`,
                  reasoning:
                    'Margin is still outside the box under either model — `border-box` never included it. Two 50% cards with margins still overflow, and that is the problem `gap` solves once you reach flexbox.',
                },
              ],
            ),
            demo('The same declared width, two sizing models', 'Both boxes say `width: 300px`.', [
              {
                label: 'border-box',
                code: '<style>\n  .box { box-sizing: border-box; width: 300px; padding: 20px; border: 5px solid teal; background: #eef; }\n</style>\n<div class="box">Exactly 300px wide on screen.</div>',
                note: 'The padding and border come *out of* the 300px. What you declared is what you measure.',
              },
              {
                label: 'content-box (the default)',
                code: '<style>\n  .box { box-sizing: content-box; width: 300px; padding: 20px; border: 5px solid crimson; background: #fee; }\n</style>\n<div class="box">350px wide on screen.</div>',
                note: '300px of content, plus 40px of padding, plus 10px of border. The declared number is the one part you cannot see.',
              },
            ]),
            predictCheck(
              `<style>
  .a { margin-bottom: 40px; }
  .b { margin-top: 20px; }
</style>
<p class="a">First paragraph.</p>
<p class="b">Second paragraph.</p>`,
              'One element has 40px of margin below it, the next has 20px above. Before you check: how much space is between them — 60px, 40px, or 20px?',
              '40px. Adjacent vertical margins **collapse** into one, and the larger wins rather than the two adding up. This catches everyone, and it is deliberate: it is why consecutive paragraphs are evenly spaced rather than accumulating gaps. Collapsing only happens vertically, only in normal flow, and it stops entirely inside a flex or grid container — which is one more reason modern layouts use `gap` instead of margins.',
            ),
            callout(
              'mistake',
              'Margin collapse is not a bug',
              'The three surprises are: adjacent siblings collapse to the larger of the two; a parent and its first or last child collapse together unless something separates them (padding, a border, or a new formatting context); and an empty element collapses its own top and bottom margins into one. Flex and grid containers do not collapse margins at all.',
            ),
            checklist('Box model checklist', [
              '`box-sizing: border-box` on `*, *::before, *::after`, once, at the top',
              'Padding for space inside; margin for space between',
              'A border needs a style — `1px solid`, not just `1px`',
              'Vertical margins between siblings collapse to the larger',
              'Margin is outside the box under both sizing models',
            ]),
            recap(
              [
                'Every element is content, padding, border and margin, outward from the middle.',
                'By default `width` sets the content box, so padding and border are added on top.',
                '`box-sizing: border-box` makes `width` mean the whole visible box.',
                'Adjacent vertical margins collapse to the larger of the two.',
              ],
              'Next: selectors, and reaching what you mean.',
            ),
            activeRecap(
              [
                'Name the four layers, from the inside out.',
                'A box has `width: 200px`, `padding: 10px`, `border: 2px`. How wide is it in each sizing model?',
                'What happens between a 30px bottom margin and a 10px top margin?',
              ],
              [
                'Content, padding, border, margin.',
                '`content-box`: 200 + 20 + 4 = 224px on screen. `border-box`: 200px on screen, with the padding and border taken out of it, leaving 176px of content.',
                'They collapse to 30px — the larger, not the sum. Vertical margins between siblings in normal flow always do this.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-border-box-guided',
              kind: 'guided',
              title: 'Make width mean what it says',
              brief:
                'Apply `border-box` sizing to everything, then give `.card` a width of `300px`, `1rem` of padding and a `2px solid teal` border. With border-box in place the card should measure exactly 300px on screen.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Boxes</title>
    <style>
    </style>
  </head>
  <body>
    <div class="card">Fresh bread, every morning.</div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Boxes</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card {
        width: 300px;
        padding: 1rem;
        border: 2px solid teal;
      }
    </style>
  </head>
  <body>
    <div class="card">Fresh bread, every morning.</div>
  </body>
</html>`,
              hints: [
                'The sizing rule targets everything: *, *::before, *::after',
                'box-sizing does not inherit, which is why it needs the universal selector.',
                'A border needs three parts: width, style, colour.',
              ],
              requirements: [
                cssIs('.card', 'box-sizing', 'border-box', 'The card uses border-box sizing'),
                cssIs('.card', 'width', '300px', 'The card is 300px wide'),
                cssIs('.card', 'padding', '1rem', 'The card has 1rem of padding'),
                cssMatches('.card', 'border', '2px\\s+solid\\s+teal', 'The card has a 2px solid teal border'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'box-model',
            },
            {
              slug: 'css-box-debug',
              kind: 'debug',
              title: 'Two columns that will not fit',
              brief:
                'Two `.col` elements are each 50% wide and they wrap onto separate lines instead of sitting side by side in the 800px container. The cause is the sizing model, not the width. Fix it by adding the sizing rule — do not change the 50%.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Columns</title>
    <style>
      .row { width: 800px; }
      .col {
        float: left;
        width: 50%;
        padding: 1rem;
        border: 1px solid teal;
      }
    </style>
  </head>
  <body>
    <div class="row">
      <div class="col">Sourdough</div>
      <div class="col">Rye</div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Columns</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .row { width: 800px; }
      .col {
        float: left;
        width: 50%;
        padding: 1rem;
        border: 1px solid teal;
      }
    </style>
  </head>
  <body>
    <div class="row">
      <div class="col">Sourdough</div>
      <div class="col">Rye</div>
    </div>
  </body>
</html>`,
              hints: [
                'Each column is 50% *plus* its padding and border, so the pair exceeds 100%.',
                'Add the universal border-box rule at the top of the stylesheet.',
                'Do not reduce the 50% — that would only hide the real cause.',
              ],
              requirements: [
                cssIs('.col', 'box-sizing', 'border-box', 'Columns use border-box sizing'),
                cssIs('.col', 'width', '50%', 'The declared width is still 50%'),
                cssIs('.col', 'padding', '1rem', 'The padding is unchanged'),
              ],
              difficulty: 3,
              xp: 45,
              skill: 'box-model',
            },
          ],
          quiz: [
            {
              slug: 'q-css-width-measures',
              prompt: 'By default, what does `width` measure?',
              explanation: 'The content box only. Padding and border are added outside it.',
              options: [
                { label: 'The content box only', correct: true },
                { label: 'The whole visible box' },
                { label: 'The box including its margin' },
                { label: 'It depends on the element' },
              ],
              skill: 'box-model',
            },
            {
              slug: 'q-css-border-box-selector',
              prompt: 'Why is `box-sizing: border-box` applied with `*` rather than on `body`?',
              explanation: '`box-sizing` does not inherit, so setting it on an ancestor reaches nothing else.',
              options: [
                { label: 'Because box-sizing does not inherit', correct: true },
                { label: 'Because body is not a real element' },
                { label: 'Because the universal selector is faster' },
                { label: 'It makes no difference which you use' },
              ],
              skill: 'box-model',
            },
            {
              slug: 'q-css-margin-collapse',
              prompt: 'A 30px bottom margin sits above a 10px top margin. How much space is between them?',
              explanation: 'They collapse to the larger of the two: 30px.',
              options: [
                { label: '30px', correct: true },
                { label: '40px' },
                { label: '10px' },
                { label: '20px' },
              ],
              skill: 'box-model',
            },
          ],
        },
        {
          slug: 'css-selectors',
          title: 'Selectors that reach what you mean',
          subtitle: 'Combinators, attributes and pseudo-classes — without escalating specificity',
          summary:
            'A handful of selectors cover almost everything, and choosing well keeps specificity low enough that the next person can override you.',
          objectives: [
            'Use descendant, child and sibling combinators',
            'Select by attribute and by state',
            'Keep specificity low deliberately',
          ],
          estimatedMinutes: 16,
          skill: 'selectors',
          blocks: [
            pretest(
              'You want to style only the paragraphs that are *directly* inside `.card`, not ones nested deeper. Which selector does that?',
              [
                '`.card > p`',
                '`.card p`',
                '`.card + p`',
                '`.card ~ p`',
              ],
              '`.card > p` — the child combinator, which matches only direct children. `.card p` is the *descendant* combinator and matches paragraphs at any depth, which is the default when you write a space and the source of a great many accidental matches. `+` and `~` are sibling combinators and match elements alongside `.card`, not inside it.',
            ),
            objectives([
              'Choose the right combinator for a relationship',
              'Select elements by attribute and by state',
              'Explain why `:where()` exists',
            ]),
            code(
              `.card p        descendant  — any p inside, at any depth
.card > p      child       — only direct children
.card + p      adjacent    — the p immediately after .card
.card ~ p      sibling     — every p after .card, same parent

a[href]                 has the attribute at all
a[href^="https"]        starts with
a[href$=".pdf"]         ends with
a[href*="example"]      contains

a:hover, a:focus-visible    state
li:first-child, li:last-child, li:nth-child(2n)
input:checked, input:disabled, input:invalid
p:not(.lead)                negation`,
              'The selectors worth knowing',
              'text',
            ),
            demo('Descendant versus child', 'Identical markup, one character different in the CSS.', [
              {
                label: 'Child only',
                code: '<style>\n  .card > p { color: teal }\n</style>\n<div class="card">\n  <p>Direct child — teal.</p>\n  <blockquote><p>Nested deeper — untouched.</p></blockquote>\n</div>',
                note: 'Only the direct child matches. The nested paragraph keeps its inherited colour.',
              },
              {
                label: 'Any descendant',
                code: '<style>\n  .card p { color: teal }\n</style>\n<div class="card">\n  <p>Direct child — teal.</p>\n  <blockquote><p>Nested deeper — also teal.</p></blockquote>\n</div>',
                note: 'Both match. Usually fine, occasionally a surprise when a component is nested inside another.',
              },
              {
                label: 'Attribute selector',
                code: '<style>\n  a[href^="https"] { color: teal }\n  a[href$=".pdf"] { font-weight: bold }\n</style>\n<a href="https://example.org">External</a>\n<a href="/menu.pdf">Menu (PDF)</a>\n<a href="about.html">About</a>',
                note: 'Style by what the markup says rather than by an extra class. The third link matches neither.',
              },
            ]),
            callout(
              'tip',
              'Style state with `:focus-visible`, not just `:hover`',
              'A rule that only responds to `:hover` is invisible to keyboard users. `:focus-visible` shows a focus style when the browser judges it useful — on keyboard focus but not on a mouse click — which is what you want. Never remove a focus outline without replacing it with something at least as visible.',
            ),
            selfExplain(
              'Your team writes `#sidebar .widget ul li a { color: teal }` for a link in a sidebar widget. It works. Explain what it costs, and what you would write instead.',
              'It works and it sets a specificity of one id, one class and three elements — so every future override of that link has to match or beat it. A theme, a dark mode, a utility class, or simply a different state all now need selectors at least that strong, and the stylesheet ratchets upwards. Nothing in that chain is doing useful work either: the `ul li` describes the markup structure rather than the thing being styled, so moving the link out of a list breaks the rule for no reason. What it should be is a single class on the thing itself — `.widget-link { color: teal }` — which is one class of specificity, survives the markup changing, and can be overridden by anything that needs to.',
            ),
            detail(
              '`:is()`, `:where()` and the specificity escape hatch',
              '`:is(h1, h2, h3)` matches any of them and takes the specificity of its *most specific* argument. `:where(h1, h2, h3)` matches the same elements and always scores **zero**. That makes `:where()` the right tool for a base layer — defaults that anything can override without a fight. A reset written as `:where(ul, ol) { margin: 0 }` never needs to be beaten, because it contributes nothing to the contest.',
            ),
            recap(
              [
                'A space is the descendant combinator; `>` restricts to direct children.',
                '`+` and `~` select siblings, not descendants.',
                'Attribute selectors style what the markup already says.',
                '`:where()` scores zero, which makes it right for defaults.',
              ],
              'Next: the Level 2 milestone.',
            ),
            activeRecap(
              [
                'What is the difference between `.card p` and `.card > p`?',
                'Why pair `:hover` with `:focus-visible`?',
                'When would you reach for `:where()`?',
              ],
              [
                '`.card p` matches paragraphs at any depth inside `.card`; `.card > p` matches only direct children.',
                'Because a hover-only style is invisible to anyone navigating by keyboard. `:focus-visible` gives them the same signal without showing a ring on every mouse click.',
                'For base styles and resets that must be trivially overridable — it always contributes zero specificity, so nothing ever has to fight it.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-selectors-guided',
              kind: 'guided',
              title: 'Target precisely',
              brief:
                'Using no selector stronger than one class: make only the *direct* paragraph children of `.card` teal; make links whose `href` starts with `https` bold; and give links a visible style on both hover and keyboard focus.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Selectors</title>
    <style>
    </style>
  </head>
  <body>
    <div class="card">
      <p>Direct child.</p>
      <blockquote><p>Nested deeper.</p></blockquote>
      <a href="https://example.org">External link</a>
      <a href="about.html">Internal link</a>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Selectors</title>
    <style>
      .card > p { color: teal; }
      a[href^="https"] { font-weight: bold; }
      a:hover,
      a:focus-visible { text-decoration: underline; }
    </style>
  </head>
  <body>
    <div class="card">
      <p>Direct child.</p>
      <blockquote><p>Nested deeper.</p></blockquote>
      <a href="https://example.org">External link</a>
      <a href="about.html">Internal link</a>
    </div>
  </body>
</html>`,
              hints: [
                'The child combinator is a greater-than sign between the two parts.',
                'Attribute "starts with" is written [href^="https"].',
                'Put the hover and focus-visible selectors in one comma-separated rule.',
              ],
              requirements: [
                cssIs('.card > p', 'color', 'teal', 'Direct child paragraphs are teal'),
                cssNotSet(
                  'blockquote p',
                  'color',
                  'The nested paragraph is not targeted — the child combinator does not reach it',
                ),
                cssIs('a[href^="https"]', 'font-weight', 'bold', 'External links are bold'),
                cssSet('a:hover', 'text-decoration', 'Links respond to hover'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'selectors',
            },
          ],
          quiz: [
            {
              slug: 'q-css-child-combinator',
              prompt: 'What does the space in `.card p` mean?',
              explanation: 'Descendant — any `p` inside `.card`, at any depth.',
              options: [
                { label: 'Any descendant, at any depth', correct: true },
                { label: 'Only direct children' },
                { label: 'The next sibling' },
                { label: 'Nothing; it is ignored' },
              ],
              skill: 'selectors',
            },
            {
              slug: 'q-css-where-zero-specificity',
              prompt: 'What makes `:where()` useful for a reset?',
              explanation: 'It always contributes zero specificity, so nothing ever has to fight it.',
              options: [
                { label: 'It always scores zero specificity', correct: true },
                { label: 'It matches more elements than `:is()`' },
                { label: 'It applies only to the first match' },
                { label: 'It is faster to evaluate' },
              ],
              skill: 'selectors',
            },
            {
              slug: 'q-css-focus-visible',
              prompt: 'Why style `:focus-visible` alongside `:hover`?',
              explanation: 'A hover-only style is invisible to anyone navigating with a keyboard.',
              options: [
                { label: 'Otherwise keyboard users get no feedback at all', correct: true },
                { label: 'Because `:hover` does not work on links' },
                { label: 'To make the style apply faster' },
                { label: 'It is required for the selector to be valid' },
              ],
              skill: 'selectors',
            },
          ],
        },
        {
          slug: 'css-box-milestone',
          title: 'Milestone: size a card component',
          subtitle: 'Predictable boxes, precise selectors',
          summary: 'Build a card that measures exactly what it says, with selectors no stronger than they need to be.',
          objectives: [
            'Apply border-box sizing project-wide',
            'Size and space a component predictably',
            'Keep every selector to one class',
          ],
          estimatedMinutes: 20,
          skill: 'box-model',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Build a component with predictable dimensions',
              'Use padding and margin for their correct purposes',
              'Keep specificity flat',
            ]),
            checklist('Before you call a component sized', [
              '`border-box` applied to everything, once',
              'Padding for internal space, margin for external',
              'Borders written with a style, not just a width',
              'No selector stronger than a single class',
              'Vertical rhythm not relying on collapsed margins you did not intend',
            ]),
            recall(
              'From memory: what are the four layers of the box model, what does `width` measure in each sizing model, and what happens to two adjacent vertical margins?',
              [
                'Content, padding, border, margin — outward from the middle.',
                '`content-box`: `width` is the content only, and padding and border are added outside it. `border-box`: `width` is the whole visible box, and padding and border come out of it.',
                'They collapse to the larger of the two rather than adding up. This stops entirely inside a flex or grid container.',
              ],
            ),
            recap(
              [
                'Set `border-box` once, at the top, on everything.',
                'Padding is inside and takes the background; margin is outside and is transparent.',
                'Selectors should be as weak as they can be while still matching.',
              ],
              'Next: flow, positioning and stacking.',
            ),
            activeRecap(
              ['Why does `border-box` belong at the top of a stylesheet rather than on individual components?'],
              [
                'Because it changes what `width` means everywhere, and a component sized under one model inside a page using the other is unpredictable. Setting it once, universally, makes every later width mean the same thing — and it does not inherit, so the universal selector is the only way to reach everything.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-box-milestone-challenge',
              kind: 'challenge',
              title: 'Build a predictable card',
              brief:
                'Build a `.card` that is 320px wide on screen, with 1.5rem of internal padding, a 1px solid border, and 2rem of space below it separating it from the next card. Apply border-box sizing to everything. Every selector must be a single class or the universal selector — no ids, no `!important`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Card</title>
    <style>
    </style>
  </head>
  <body>
    <div class="card">
      <h2>Sourdough workshop</h2>
      <p>Six hours, small groups.</p>
    </div>
    <div class="card">
      <h2>Rye workshop</h2>
      <p>Four hours, small groups.</p>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Card</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card {
        width: 320px;
        padding: 1.5rem;
        border: 1px solid teal;
        margin-bottom: 2rem;
      }
    </style>
  </head>
  <body>
    <div class="card">
      <h2>Sourdough workshop</h2>
      <p>Six hours, small groups.</p>
    </div>
    <div class="card">
      <h2>Rye workshop</h2>
      <p>Four hours, small groups.</p>
    </div>
  </body>
</html>`,
              hints: [
                'Start with the universal border-box rule.',
                'Space *inside* the card is padding; space *between* cards is margin.',
                'A border needs a style keyword: 1px solid teal.',
              ],
              requirements: [
                cssIs('.card', 'box-sizing', 'border-box', 'Cards use border-box sizing'),
                cssIs('.card', 'width', '320px', 'The card is 320px wide'),
                cssIs('.card', 'padding', '1.5rem', 'The card has 1.5rem of padding'),
                cssMatches('.card', 'border', '1px\\s+solid', 'The card has a 1px solid border'),
                cssMatches('.card', 'margin-bottom', '2rem', 'Cards are separated by 2rem'),
              ],
              difficulty: 3,
              xp: 60,
              skill: 'box-model',
            },
            {
              slug: 'css-box-milestone-debug',
              kind: 'debug',
              title: 'A card that is the wrong size',
              brief:
                'This card should be 320px on screen and is not, and the space between cards is not what the author wrote. Fix the sizing model and use the correct property for the space *between* cards. Do not change the declared 320px.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Card</title>
    <style>
      .card {
        width: 320px;
        padding: 1.5rem;
        border: 1px solid teal;
        padding-bottom: 2rem;
      }
    </style>
  </head>
  <body>
    <div class="card">Sourdough workshop</div>
    <div class="card">Rye workshop</div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Card</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card {
        width: 320px;
        padding: 1.5rem;
        border: 1px solid teal;
        margin-bottom: 2rem;
      }
    </style>
  </head>
  <body>
    <div class="card">Sourdough workshop</div>
    <div class="card">Rye workshop</div>
  </body>
</html>`,
              hints: [
                'Without border-box, the padding and border are added to the 320px.',
                'Extra padding at the bottom makes the card taller — it does not separate the cards.',
                'Space between elements is margin.',
              ],
              requirements: [
                cssIs('.card', 'box-sizing', 'border-box', 'Cards use border-box sizing'),
                cssIs('.card', 'width', '320px', 'The declared width is unchanged'),
                cssMatches('.card', 'margin-bottom', '2rem', 'Cards are separated by margin, not padding'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'box-model',
            },
          ],
          quiz: [
            {
              slug: 'q-css-padding-vs-margin',
              prompt: 'Which property creates space *between* two elements?',
              explanation: 'Margin is outside the box. Padding is inside it and makes the element itself bigger.',
              options: [
                { label: '`margin`', correct: true },
                { label: '`padding`' },
                { label: '`border`' },
                { label: '`gap`, always' },
              ],
              skill: 'box-model',
            },
            {
              slug: 'q-css-border-needs-style',
              prompt: 'Why does `border: 1px teal` show nothing?',
              explanation: 'The style keyword is required — without `solid`, `dashed` and so on, the border style defaults to `none`.',
              options: [
                { label: 'The style keyword is missing, and it defaults to none', correct: true },
                { label: 'Teal is not a valid border colour' },
                { label: 'Borders need a width of at least 2px' },
                { label: 'The shorthand must list colour first' },
              ],
              skill: 'box-model',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'css-level-2-milestone',
    kind: 'milestone',
    title: 'Level 2 milestone: Boxes and Selectors',
    description: 'Six questions on the box model and selectors. Pass mark 75%.',
    passScore: 0.75,
    xp: 180,
    questions: [
      {
        slug: 'a-css-2-width-default',
        prompt: 'A box has `width: 300px`, `padding: 20px`, `border: 5px`. How wide is it by default?',
        explanation: '350px — padding and border are added outside the content width.',
        options: [
          { label: '350px', correct: true },
          { label: '300px' },
          { label: '260px' },
          { label: '325px' },
        ],
        skill: 'box-model',
      },
      {
        slug: 'a-css-2-border-box',
        prompt: 'What does `box-sizing: border-box` change?',
        explanation: '`width` comes to mean the whole visible box, with padding and border taken out of it.',
        options: [
          { label: '`width` means content plus padding plus border', correct: true },
          { label: '`width` starts including the margin' },
          { label: 'Borders stop taking up space' },
          { label: 'Padding stops taking the background colour' },
        ],
        skill: 'box-model',
      },
      {
        slug: 'a-css-2-collapse',
        prompt: 'Where do vertical margins *not* collapse?',
        explanation: 'Inside a flex or grid container, margins never collapse.',
        options: [
          { label: 'Inside a flex or grid container', correct: true },
          { label: 'Between adjacent paragraphs' },
          { label: 'Between a parent and its first child' },
          { label: 'They always collapse' },
        ],
        skill: 'box-model',
      },
      {
        slug: 'a-css-2-combinator',
        prompt: 'Which selector matches only the direct children?',
        explanation: 'The child combinator, `>`.',
        options: [
          { label: '`.card > p`', correct: true },
          { label: '`.card p`' },
          { label: '`.card + p`' },
          { label: '`.card ~ p`' },
        ],
        skill: 'selectors',
      },
      {
        slug: 'a-css-2-attribute',
        prompt: 'What does `a[href$=".pdf"]` match?',
        explanation: 'Links whose href *ends with* `.pdf`.',
        options: [
          { label: 'Links whose href ends with .pdf', correct: true },
          { label: 'Links whose href starts with .pdf' },
          { label: 'Links whose href contains .pdf anywhere' },
          { label: 'Links with any href' },
        ],
        skill: 'selectors',
      },
      {
        slug: 'a-css-2-specificity-cost',
        prompt: 'What is the practical cost of `#sidebar .widget ul li a`?',
        explanation:
          'Every later override must match or beat one id, one class and three elements — and the rule breaks if the markup structure changes.',
        options: [
          { label: 'Every future override must beat it, and it breaks if the markup changes', correct: true },
          { label: 'It renders more slowly than a class' },
          { label: 'It is invalid CSS' },
          { label: 'Nothing — it is the recommended approach' },
        ],
        skill: 'selectors',
      },
    ],
  },
};
