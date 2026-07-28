import {
  activeRecap,
  callout,
  checklist,
  code,
  cssIs,
  cssMediaRule,
  cssNoImportant,
  cssSpecificityBudget,
  cssVariable,
  demo,
  detail,
  objectives,
  pretest,
  prose,
  recall,
  recap,
  selfExplain,
  workedExample,
  SPECIFICITY_ONE_CLASS_ONE_ELEMENT,
  type LevelSpec,
} from '../types';

/**
 * CSS Level 12 — the capstone.
 *
 * The learner styles the site they built in the HTML course rather than a fresh
 * mock-up. That choice does real work: the markup is already valid, semantic and
 * accessible, so every styling decision is made against structure that exists
 * and constraints that are real — which is the situation styling is actually
 * done in, and the one a mock-up cannot simulate.
 */
export const CSS_LEVEL_12: LevelSpec = {
  slug: 'css-capstone',
  title: 'Capstone: Styling Your Site',
  subtitle: 'Everything, applied to the site you already built',
  summary:
    'The site from the HTML course is valid, semantic and accessible, and entirely unstyled. Styling it is the capstone — real markup, real constraints, and every technique from this course used together.',
  outcome:
    'You have styled a complete multi-page site with a token system, responsive layout and no specificity escalation anywhere.',
  accent: 'violet',
  modules: [
    {
      slug: 'css-capstone-module',
      title: 'Styling the site',
      summary: 'Tokens, layout, responsiveness and a final review, on real pages.',
      estimatedMinutes: 70,
      prerequisites: ['css-debugging-module'],
      skills: [
        { slug: 'custom-properties', masteryRequired: 0.75 },
        { slug: 'typography', masteryRequired: 0.75 },
        { slug: 'grid', masteryRequired: 0.75 },
        { slug: 'responsive', masteryRequired: 0.75 },
        { slug: 'css-architecture', masteryRequired: 0.75 },
      ],
      lessons: [
        {
          slug: 'css-capstone-foundation',
          title: 'The foundation',
          subtitle: 'Tokens and type before anything else',
          summary:
            'The order matters. Tokens and typography first, because every later decision reads from them — and because a site with good type and no layout still looks considered, while the reverse never does.',
          objectives: [
            'Establish a token set for the whole site',
            'Set the typographic baseline',
            'Explain why this order is the efficient one',
          ],
          estimatedMinutes: 20,
          skill: 'custom-properties',
          blocks: [
            pretest(
              'You are styling an unstyled site from scratch. What goes first?',
              [
                'Tokens and typography, because everything later reads from them',
                'The navigation, because it appears on every page',
                'The homepage hero, because it is the most visible',
                'The responsive breakpoints, to get them out of the way',
              ],
              'Tokens and typography. Every later rule reads from the tokens, so establishing them first means no rule ever has to be revisited to replace a hard-coded value — and typography is the single change that most improves an unstyled page. Starting with the hero means making colour and spacing decisions ad hoc, then either living with them or going back to normalise them, which is the same work done twice.',
            ),
            objectives([
              'Define a site-wide token set',
              'Set measure, leading and scale',
              'Sequence the work so nothing is done twice',
            ]),
            prose(
              'Your site from the HTML course has five pages and no styling at all. That is a better starting point than it sounds: the markup is semantic, so `header`, `nav`, `main`, `article` and `footer` are all available as styling hooks that already mean something, and every heading level is correct. Nothing has to be restructured before it can be styled.',
              'What you are starting from',
            ),
            workedExample(
              'The order to work in',
              'Four passes, each depending only on the ones before it.',
              [
                {
                  title: 'Pass one — tokens',
                  code: `:root {
  --surface: #fff;
  --text: #1a1a1a;
  --muted: #595959;
  --accent: teal;
  --border: #ddd;
  --space: 1rem;
  --measure: 65ch;
  --radius: 0.5rem;
}`,
                  reasoning:
                    'Roles, not appearances, so a dark theme costs one block later. Everything after this pass reads values by name, and no rule ever contains a literal colour.',
                },
                {
                  title: 'Pass two — typography',
                  code: `body { font-size: 1rem; line-height: 1.6; color: var(--text); }
main { max-width: var(--measure); }
h1 { font-size: 2rem; line-height: 1.1; }
h2 { font-size: 1.5rem; line-height: 1.2; }`,
                  reasoning:
                    'The highest-value pass by a distance. An unstyled page with a constrained measure and comfortable leading already reads well, before a single layout decision has been made.',
                },
                {
                  title: 'Pass three — layout',
                  code: `.page { display: grid; gap: var(--space); }
.cards { display: grid;
  grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr)); }`,
                  reasoning:
                    'Now, and not before. Layout decisions made after the type is set are made against real line lengths rather than against placeholder text, which is where most awkward column widths come from.',
                },
                {
                  title: 'Pass four — states and refinement',
                  code: `a:hover, a:focus-visible { text-decoration: underline; }
.card { transition: transform 200ms ease-out; }
@media (prefers-reduced-motion: reduce) { * { transition: none; } }`,
                  reasoning:
                    'Last, because states and motion are refinements of something that must already work without them. A site with no hover styles is plain; a site with no layout is broken.',
                },
              ],
            ),
            callout(
              'tip',
              'Style the smallest page first',
              'The contact page or the about page, not the homepage. They contain the same components with fewer of them, so the token set and the typography get exercised without the homepage\'s complexity obscuring what is going wrong. By the time you reach the homepage most of its parts already exist.',
            ),
            demo('Typography alone', 'The same unstyled markup, one pass applied.', [
              {
                label: 'Unstyled',
                code: '<article><h1>Sourdough, slowly</h1><p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours. A loaf that would take three hours with commercial yeast takes a day or more.</p></article>',
                note: 'Valid, semantic, and hard to read — full-width lines and default leading.',
              },
              {
                label: 'After the typography pass',
                code: '<style>\n  :root { --text: #1a1a1a; --measure: 65ch; }\n  article { max-width: var(--measure); line-height: 1.6; color: var(--text); }\n  h1 { font-size: 2rem; line-height: 1.1; }\n</style>\n<article><h1>Sourdough, slowly</h1><p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours. A loaf that would take three hours with commercial yeast takes a day or more.</p></article>',
                note: 'Four declarations. No layout work at all, and the page already reads as designed rather than as unfinished.',
              },
            ]),
            recap(
              [
                'Tokens first, so no rule ever holds a literal value.',
                'Typography second — the highest-value pass on an unstyled site.',
                'Layout third, against real type rather than placeholders.',
                'States and motion last; they refine something that already works.',
              ],
              'Next: layout and the responsive pass.',
            ),
            activeRecap(
              [
                'Why do tokens come before everything else?',
                'Why is typography a better second pass than layout?',
                'Why start with the smallest page?',
              ],
              [
                'Because every later rule reads values by name. Establishing them first means no rule is ever revisited to replace a hard-coded colour or spacing, and a theme later costs one block instead of an audit.',
                'Because it is the change that most improves an unstyled page, and because layout decisions made afterwards are made against real line lengths instead of guesses.',
                'Because it contains the same components with fewer of them, so the foundations get exercised without the homepage\'s complexity hiding what is wrong.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-capstone-foundation-guided',
              kind: 'guided',
              title: 'Lay the foundation',
              brief:
                'On `:root` define `--text: #1a1a1a`, `--accent: teal`, `--space: 1rem` and `--measure: 65ch`. Then set `body` to `line-height: 1.6` and `color: var(--text)`, give `main` a `max-width: var(--measure)`, and give `h1` `font-size: 2rem` with `line-height: 1.1`. No literal colours outside `:root`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>About — Sourdough</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }
    </style>
  </head>
  <body>
    <main>
      <h1>About the workshop</h1>
      <p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours.</p>
    </main>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>About — Sourdough</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root {
        --text: #1a1a1a;
        --accent: teal;
        --space: 1rem;
        --measure: 65ch;
      }

      body {
        line-height: 1.6;
        color: var(--text);
      }

      main { max-width: var(--measure); }

      h1 {
        font-size: 2rem;
        line-height: 1.1;
      }
    </style>
  </head>
  <body>
    <main>
      <h1>About the workshop</h1>
      <p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours.</p>
    </main>
  </body>
</html>`,
              hints: [
                'All four tokens go on :root.',
                'Read them back with var() — no literal colours below.',
                'Line height stays unitless so it inherits as a ratio.',
              ],
              requirements: [
                cssVariable('main', '--measure', 'The measure token reaches the page'),
                cssVariable('main', '--accent', 'The accent token is defined'),
                cssIs('body', 'color', '#1a1a1a', 'The text colour resolves from the token'),
                cssIs('body', 'line-height', '1.6', 'Body leading is comfortable and unitless'),
                cssIs('main', 'max-width', '65ch', 'The measure resolves from the token'),
                cssIs('h1', 'font-size', '2rem', 'The heading is on the scale'),
              ],
              difficulty: 3,
              xp: 60,
              skill: 'custom-properties',
            },
          ],
          quiz: [
            {
              slug: 'q-css-capstone-order',
              prompt: 'What is the first pass when styling an unstyled site?',
              explanation: 'Tokens, so every later rule reads values by name.',
              options: [
                { label: 'Tokens', correct: true },
                { label: 'The navigation' },
                { label: 'Breakpoints' },
                { label: 'The homepage hero' },
              ],
              skill: 'custom-properties',
            },
            {
              slug: 'q-css-capstone-typography',
              prompt: 'Why is typography the second pass rather than the fourth?',
              explanation:
                'It is the highest-value change on an unstyled page, and layout decisions afterwards are made against real line lengths.',
              options: [
                { label: 'It improves the page most, and layout then follows real type', correct: true },
                { label: 'Fonts take longest to load' },
                { label: 'Layout cannot be changed later' },
                { label: 'It is required before media queries' },
              ],
              skill: 'custom-properties',
            },
          ],
        },
        {
          slug: 'css-capstone-layout',
          title: 'Layout and the responsive pass',
          subtitle: 'One grid, no device breakpoints',
          summary:
            'The site layout needs one grid and, at most, one or two breakpoints chosen from where the content stops working.',
          objectives: [
            'Lay out the page shell with grid',
            'Make card lists responsive without media queries',
            'Choose breakpoints from content',
          ],
          estimatedMinutes: 22,
          skill: 'responsive',
          blocks: [
            pretest(
              'Your card list needs to reflow from one column to three. What is the least code that does it?',
              [
                '`repeat(auto-fit, minmax(16rem, 1fr))` — no media queries at all',
                'Three media queries, one per column count',
                'Float the cards and clear them',
                'A media query per device width',
              ],
              '`repeat(auto-fit, minmax(16rem, 1fr))`. The grid fits as many 16rem-minimum columns as the space allows and stretches them to fill, so the column count follows the available width by itself. Media queries are for the cases this cannot express — the page shell changing shape, not a list changing its column count.',
            ),
            objectives([
              'Build the page shell',
              'Use intrinsic sizing for lists',
              'Add a breakpoint only where the content demands one',
            ]),
            code(
              `.page {
  display: grid;
  grid-template-columns: 1fr;
  gap: var(--space);
}

.cards {
  display: grid;
  gap: var(--space);
  grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));
}

@media (min-width: 48rem) {
  .page { grid-template-columns: 16rem 1fr; }
}`,
              'The whole site layout',
            ),
            detail(
              'Why so few breakpoints',
              'Every breakpoint is a second layout to maintain, test and keep consistent. Intrinsic sizing — `auto-fit`, `minmax`, `clamp` and `min-content` — handles most reflow without any, so the breakpoints that remain are the genuine structural changes: a sidebar appearing, a navigation collapsing. Two or three per site is normal for work done this way. A dozen usually means device widths were used instead of content.',
            ),
            demo('One rule, every width', 'Resize the preview to see the column count change.', [
              {
                label: 'Intrinsic',
                code: '<style>\n  .cards { display: grid; gap: 1rem; grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr)); }\n  .card { background: #f4f4f4; padding: 1rem; }\n</style>\n<div class="cards"><div class="card">Sourdough</div><div class="card">Rye</div><div class="card">Seeded</div><div class="card">Spelt</div></div>',
                note: 'No media queries. The column count follows the space available.',
              },
              {
                label: 'The shell',
                code: '<style>\n  .page { display: grid; grid-template-columns: 1fr; gap: 1rem; }\n  @media (min-width: 48rem) { .page { grid-template-columns: 16rem 1fr; } }\n  .side, .body { background: #f4f4f4; padding: 1rem; }\n</style>\n<div class="page"><div class="side">Navigation</div><div class="body">Main content</div></div>',
                note: 'One breakpoint, for a genuine structural change — the sidebar moving beside the content rather than above it.',
              },
            ]),
            selfExplain(
              'Your site has eleven media queries. What has probably gone wrong, and how would you reduce it?',
              'Almost certainly the breakpoints were taken from device widths rather than from where the content stops working, and each component got its own. The reduction is mechanical: replace every query whose only job is changing a column count with `repeat(auto-fit, minmax(…, 1fr))`, which removes most of them outright; replace fixed font-size steps with `clamp()`; and replace fixed widths with `min()` or `max-width` in `ch`. What survives is the small number of genuine structural changes — a sidebar appearing, a navigation collapsing — and those should be shared across components rather than declared separately in each. Eleven typically becomes two or three, and the layout gets more robust in the process, because intrinsic sizing works at every width rather than only at the ones you thought to test.',
            ),
            checklist('Layout pass review', [
              'The page shell is one grid',
              'Card and item lists use intrinsic sizing, not media queries',
              'Breakpoints chosen from content, in `rem`',
              'The layout is mobile-first — `min-width` queries add complexity',
              'Nothing overflows horizontally at 320px',
              'Spacing comes from the token, not from ad-hoc values',
            ]),
            recap(
              [
                'One grid for the shell, one for each list.',
                'Intrinsic sizing removes most media queries.',
                'Breakpoints come from content, and there should be few.',
                'Mobile-first means each query adds rather than undoes.',
              ],
              'Next: the final review and the capstone mission.',
            ),
            activeRecap(
              [
                'What replaces most media queries in a modern layout?',
                'How do you know a breakpoint is in the right place?',
                'Why does each extra breakpoint cost more than it looks?',
              ],
              [
                'Intrinsic sizing — `auto-fit` with `minmax`, `clamp`, `min()` and sizing in `ch`. The layout responds to the space available rather than to a width you predicted.',
                'You found it by narrowing the window until the content stopped working, not by looking up a device width. Content-derived breakpoints keep working when the device landscape changes.',
                'Because it is another complete layout to maintain, test and keep consistent with the others — and the bugs it creates only appear in one width range, which is where they are least likely to be noticed.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-capstone-layout-guided',
              kind: 'guided',
              title: 'Lay out the page',
              brief:
                'Make `.cards` a grid with `gap: var(--space)` and `grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr))`. Make `.page` a single-column grid with the same gap, and add one `@media (min-width: 48rem)` block giving `.page` two columns of `16rem 1fr`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Home — Sourdough</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root { --space: 1rem; }

      .card { background: #f4f4f4; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="page">
      <nav>Navigation</nav>
      <main>
        <div class="cards">
          <div class="card">Sourdough</div>
          <div class="card">Rye</div>
          <div class="card">Seeded</div>
        </div>
      </main>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Home — Sourdough</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root { --space: 1rem; }

      .page {
        display: grid;
        grid-template-columns: 1fr;
        gap: var(--space);
      }

      .cards {
        display: grid;
        gap: var(--space);
        grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));
      }

      .card { background: #f4f4f4; padding: 1rem; }

      @media (min-width: 48rem) {
        .page { grid-template-columns: 16rem 1fr; }
      }
    </style>
  </head>
  <body>
    <div class="page">
      <nav>Navigation</nav>
      <main>
        <div class="cards">
          <div class="card">Sourdough</div>
          <div class="card">Rye</div>
          <div class="card">Seeded</div>
        </div>
      </main>
    </div>
  </body>
</html>`,
              hints: [
                'auto-fit with minmax needs no media query to change column count.',
                'The gap reads from the spacing token.',
                'Mobile-first: the single column is the base, the query adds the sidebar.',
              ],
              requirements: [
                cssIs('.cards', 'display', 'grid', 'The card list is a grid'),
                cssIs('.cards', 'gap', '1rem', 'The gap resolves from the spacing token'),
                cssIs(
                  '.cards',
                  'grid-template-columns',
                  'repeat(auto-fit,minmax(16rem,1fr))',
                  'The columns are intrinsic, needing no media query',
                ),
                cssIs('.page', 'display', 'grid', 'The page shell is a grid'),
                cssMediaRule('(min-width: 48rem)', 'There is one content-derived breakpoint'),
                cssIs('.page', 'grid-template-columns', '16rem 1fr', 'The sidebar appears at the breakpoint', {
                  condition: '(min-width: 48rem)',
                }),
              ],
              difficulty: 4,
              xp: 70,
              skill: 'responsive',
            },
          ],
          quiz: [
            {
              slug: 'q-css-capstone-autofit',
              prompt: 'What does `repeat(auto-fit, minmax(16rem, 1fr))` remove the need for?',
              explanation: 'Media queries whose only job is changing a column count.',
              options: [
                { label: 'Media queries that only change the column count', correct: true },
                { label: 'The gap property' },
                { label: 'A grid container' },
                { label: 'Box sizing' },
              ],
              skill: 'responsive',
            },
            {
              slug: 'q-css-capstone-breakpoint-source',
              prompt: 'Where should a breakpoint come from?',
              explanation: 'From where the content stops working, not from a device width.',
              options: [
                { label: 'Where the content stops working', correct: true },
                { label: 'The most popular phone width' },
                { label: 'A standard set of device sizes' },
                { label: 'The designer’s artboard widths' },
              ],
              skill: 'responsive',
            },
          ],
        },
        {
          slug: 'css-capstone-review',
          title: 'Final review and mission',
          subtitle: 'Six checks, then the site is done',
          summary:
            'The same review every professional stylesheet gets before it ships: contrast, motion, specificity, breakpoints, tokens and focus.',
          objectives: [
            'Review a stylesheet against the whole course',
            'Fix what the review finds without escalating',
            'Complete the capstone',
          ],
          estimatedMinutes: 25,
          skill: 'css-architecture',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Apply the six-point review',
              'Repair by lowering rather than escalating',
              'Finish and export the styled site',
            ]),
            checklist('The final review', [
              'Contrast — body text at least 4.5:1, large text and UI at least 3:1, in every theme',
              'Focus — every interactive element has a visible focus style, at 3:1 or better',
              'Motion — a `prefers-reduced-motion: reduce` block exists and covers transitions as well as animations',
              'Specificity — nothing above one class, and no `!important` outside the reduced-motion override',
              'Tokens — no literal colours or spacing values outside `:root`',
              'Breakpoints — few, in `rem`, and derived from content',
            ]),
            demo('Before and after the review', 'The same page, reviewed.', [
              {
                label: 'Before',
                code: '<style>\n  .note { color: #aaa; }\n  #main .card { padding: 12px; }\n  a:focus { outline: none; }\n</style>\n<div id="main"><div class="card"><p class="note">Low contrast, an id selector, hard-coded spacing, and focus removed.</p><a href="#">A link</a></div></div>',
                note: 'Four review failures, each of which passed unnoticed while the page was being built.',
              },
              {
                label: 'After',
                code: '<style>\n  :root { --muted: #595959; --space: 0.75rem; --accent: teal; }\n  .note { color: var(--muted); }\n  .card { padding: var(--space); }\n  a:focus-visible { outline: 2px solid var(--accent); outline-offset: 2px; }\n</style>\n<div id="main"><div class="card"><p class="note">Contrast met, one class, tokens used, focus visible.</p><a href="#">A link</a></div></div>',
                note: 'No rule got stronger. Two got weaker, and the hard-coded values became tokens.',
              },
            ]),
            callout(
              'warning',
              '`outline: none` without a replacement is the one to look for',
              'Removing the focus ring makes a site unusable by keyboard, and it is nearly always done because the default outline looked wrong rather than because anyone decided keyboard users did not matter. If you remove it, replace it in the same declaration block — and check the replacement against 3:1, because a subtle focus ring is the same failure in a more considerate tone.',
            ),
            recall(
              'From memory: what does each review point protect?',
              [
                'Contrast — readers with low vision, and anyone in bright light.',
                'Focus — everyone navigating by keyboard, including people who cannot use a pointer.',
                'Reduced motion — readers for whom motion causes nausea or migraine.',
                'Specificity — your own ability to change the site next month.',
                'Tokens — themeability, and the ability to change a value in one place.',
                'Breakpoints — the number of separate layouts anyone has to maintain.',
              ],
            ),
            recap(
              [
                'The review is six checks and takes minutes.',
                'Four of the six are accessibility requirements, not preferences.',
                'Repair by lowering; the review should never make a stylesheet stronger.',
              ],
              'Then the site is finished — and it is yours.',
            ),
            activeRecap(
              ['Which review points are requirements rather than preferences, and why does the distinction matter?'],
              [
                'Contrast, focus visibility and reduced motion are requirements — they are WCAG success criteria, and each one corresponds to readers who cannot use the site without it. Specificity, tokens and breakpoint count are engineering judgement: they protect your ability to keep working on the site rather than anyone\'s ability to use it. The distinction matters because the first three are not negotiable against a deadline or a design opinion, and the second three legitimately are.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-capstone-review-debug',
              kind: 'debug',
              title: 'Fix what the review found',
              brief:
                'Four failures. `.note` is `#aaa` on white — change it to `var(--muted)`, which is `#595959`. `#main .card` is over-specific — lower it to `.card` and use `var(--space)` for the padding instead of `12px`. `a:focus` removes the outline — replace it with `a:focus-visible { outline: 2px solid var(--accent); outline-offset: 2px }`. And add a `@media (prefers-reduced-motion: reduce)` block setting `transition: none` on `.card`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Review</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root { --muted: #595959; --space: 0.75rem; --accent: teal; }

      .note { color: #aaa; }
      #main .card { padding: 12px; transition: transform 200ms ease-out; }
      a:focus { outline: none; }
    </style>
  </head>
  <body>
    <div id="main">
      <div class="card">
        <p class="note">A note.</p>
        <a href="#">A link</a>
      </div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Review</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root { --muted: #595959; --space: 0.75rem; --accent: teal; }

      .note { color: var(--muted); }

      .card {
        padding: var(--space);
        transition: transform 200ms ease-out;
      }

      a:focus-visible {
        outline: 2px solid var(--accent);
        outline-offset: 2px;
      }

      @media (prefers-reduced-motion: reduce) {
        .card { transition: none; }
      }
    </style>
  </head>
  <body>
    <div id="main">
      <div class="card">
        <p class="note">A note.</p>
        <a href="#">A link</a>
      </div>
    </div>
  </body>
</html>`,
              hints: [
                'Every value you need is already a token — read them with var().',
                'Removing the id brings the card rule to one class.',
                'A removed outline must be replaced, not just deleted.',
                'The reduced-motion block covers transitions as well as animations.',
              ],
              requirements: [
                cssIs('.note', 'color', '#595959', 'The note meets the contrast requirement'),
                cssIs('.card', 'padding', '0.75rem', 'Spacing comes from the token'),
                cssSpecificityBudget(
                  SPECIFICITY_ONE_CLASS_ONE_ELEMENT,
                  'Nothing is above a one-class budget',
                ),
                cssIs('a:focus-visible', 'outline', '2px solid teal', 'Focus is visible again'),
                cssMediaRule('(prefers-reduced-motion: reduce)', 'A reduced-motion block is present'),
                cssIs('.card', 'transition', 'none', 'Motion stops when reduced motion is requested', {
                  condition: '(prefers-reduced-motion: reduce)',
                }),
                cssNoImportant('Nothing was repaired by escalating'),
              ],
              difficulty: 4,
              xp: 80,
              skill: 'css-architecture',
            },
            {
              slug: 'css-capstone-mission',
              kind: 'project_mission',
              title: 'Capstone mission: style your site',
              brief:
                'Style every page of the site you built in the HTML course. Work in the four passes — tokens, typography, layout, then states — and finish by running the six-point review over the whole stylesheet. When it passes, export the project: the CSS is yours, and it works anywhere.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page — your site</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      /* Pass one — tokens. Roles, not appearances. */
      :root {
        --surface: #fff;
        --text: #1a1a1a;
        --accent: teal;
        --space: 1rem;
        --measure: 65ch;
      }

      /* Pass two — typography. */

      /* Pass three — layout. */

      /* Pass four — states and motion. */
    </style>
  </head>
  <body>
    <div class="page">
      <header><nav>Your navigation</nav></header>
      <main>
        <h1>Your page heading</h1>
        <p>Your content, with <a href="index.html">a link</a> in it.</p>
      </main>
      <footer>Your footer</footer>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page — your site</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      /* Pass one — tokens. Roles, not appearances. */
      :root {
        --surface: #fff;
        --text: #1a1a1a;
        --accent: teal;
        --space: 1rem;
        --measure: 65ch;
      }

      /* Pass two — typography. */
      body {
        background: var(--surface);
        color: var(--text);
        line-height: 1.6;
      }

      main { max-width: var(--measure); }

      h1 {
        font-size: 2rem;
        line-height: 1.1;
      }

      /* Pass three — layout. */
      .page {
        display: grid;
        gap: var(--space);
      }

      /* Pass four — states and motion. */
      a:focus-visible {
        outline: 2px solid var(--accent);
        outline-offset: 2px;
      }

      @media (prefers-reduced-motion: reduce) {
        .page { transition: none; }
      }
    </style>
  </head>
  <body>
    <div class="page">
      <header><nav>Your navigation</nav></header>
      <main>
        <h1>Your page heading</h1>
        <p>Your content, with <a href="index.html">a link</a> in it.</p>
      </main>
      <footer>Your footer</footer>
    </div>
  </body>
</html>`,
              hints: [
                'Work the passes in order — each one depends only on the ones before it.',
                'Start with your smallest page, not the homepage.',
                'Every colour below :root should be a var().',
                'Run the six-point review before you call it finished.',
              ],
              requirements: [
                cssVariable('main', '--measure', 'The token set reaches the page'),
                cssIs('body', 'color', '#1a1a1a', 'Text colour resolves from a token'),
                cssIs('main', 'max-width', '65ch', 'The measure is constrained'),
                cssIs('.page', 'display', 'grid', 'The page shell is laid out'),
                cssIs('a:focus-visible', 'outline', '2px solid teal', 'Focus is visible'),
                cssSpecificityBudget(
                  SPECIFICITY_ONE_CLASS_ONE_ELEMENT,
                  'The stylesheet stays within a one-class budget',
                ),
                cssNoImportant('Nothing needed `!important`'),
              ],
              difficulty: 5,
              xp: 150,
              skill: 'css-architecture',
            },
          ],
          quiz: [
            {
              slug: 'q-css-capstone-outline',
              prompt: 'What must accompany `outline: none` on a focus style?',
              explanation: 'A visible replacement, checked against 3:1.',
              options: [
                { label: 'A visible replacement focus indicator', correct: true },
                { label: 'A hover style' },
                { label: 'An `!important` flag' },
                { label: 'Nothing; the default is decorative' },
              ],
              skill: 'css-architecture',
            },
            {
              slug: 'q-css-capstone-review-direction',
              prompt: 'What should the final review never do to a stylesheet?',
              explanation: 'Make it stronger — repairs come from lowering, not escalating.',
              options: [
                { label: 'Make any rule stronger', correct: true },
                { label: 'Remove a rule' },
                { label: 'Add a token' },
                { label: 'Reduce a breakpoint count' },
              ],
              skill: 'css-architecture',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'css-architect-final',
    kind: 'final',
    title: 'CSS Architect final assessment',
    description:
      'Ten questions drawn from the whole course. Pass mark 80%. Passing this, plus your styled capstone site, completes the course.',
    passScore: 0.8,
    xp: 500,
    questions: [
      {
        slug: 'css-final-q1',
        prompt: 'Two rules of equal specificity set the same property. Which wins?',
        explanation: 'The later one. Source order is the final tie-break.',
        options: [
          { label: 'The one written later', correct: true },
          { label: 'The one written first' },
          { label: 'Neither; the property is dropped' },
          { label: 'The one with more declarations' },
        ],
        skill: 'cascade',
      },
      {
        slug: 'css-final-q2',
        prompt: 'What does `box-sizing: border-box` change?',
        explanation: '`width` then includes padding and border rather than excluding them.',
        options: [
          { label: '`width` includes padding and border', correct: true },
          { label: 'Margins stop collapsing' },
          { label: 'The element becomes a flex container' },
          { label: 'Borders are drawn outside the element' },
        ],
        skill: 'box-model',
      },
      {
        slug: 'css-final-q3',
        prompt: 'Which axis does `justify-content` work on in a flex container?',
        explanation: 'The main axis — the one `flex-direction` sets.',
        options: [
          { label: 'The main axis', correct: true },
          { label: 'The cross axis' },
          { label: 'Always the horizontal axis' },
          { label: 'Both axes' },
        ],
        skill: 'flexbox',
      },
      {
        slug: 'css-final-q4',
        prompt: 'What does `repeat(auto-fit, minmax(16rem, 1fr))` do?',
        explanation: 'Fits as many columns of at least 16rem as the space allows, stretching them to fill.',
        options: [
          { label: 'Fits as many 16rem-minimum columns as the space allows', correct: true },
          { label: 'Creates exactly 16 columns' },
          { label: 'Sets every column to 16rem' },
          { label: 'Requires a media query to reflow' },
        ],
        skill: 'grid',
      },
      {
        slug: 'css-final-q5',
        prompt: 'Where should a breakpoint come from?',
        explanation: 'From where the content stops working.',
        options: [
          { label: 'Where the content stops working', correct: true },
          { label: 'A list of device widths' },
          { label: 'The most common screen size' },
          { label: 'The design tool’s artboards' },
        ],
        skill: 'responsive',
      },
      {
        slug: 'css-final-q6',
        prompt: 'A token is declared on `.panel`. Which elements can read it?',
        explanation: '`.panel` and its descendants — custom properties inherit.',
        options: [
          { label: '`.panel` and its descendants', correct: true },
          { label: 'Every element on the page' },
          { label: 'Only `.panel`' },
          { label: 'Its siblings too' },
        ],
        skill: 'custom-properties',
      },
      {
        slug: 'css-final-q7',
        prompt: 'What contrast ratio does normal body text require?',
        explanation: '4.5:1 against its actual background.',
        options: [
          { label: '4.5:1', correct: true },
          { label: '3:1' },
          { label: '2:1' },
          { label: '7:1' },
        ],
        skill: 'typography',
      },
      {
        slug: 'css-final-q8',
        prompt: 'Which two properties can be animated without forcing layout?',
        explanation: '`transform` and `opacity` — the compositor handles both.',
        options: [
          { label: '`transform` and `opacity`', correct: true },
          { label: '`width` and `height`' },
          { label: '`top` and `left`' },
          { label: '`margin` and `padding`' },
        ],
        skill: 'animation',
      },
      {
        slug: 'css-final-q9',
        prompt: 'What does `@layer` let a weak selector do?',
        explanation: 'Beat a stronger one, because layer order is compared before specificity.',
        options: [
          { label: 'Beat a stronger selector in an earlier layer', correct: true },
          { label: 'Raise its own specificity' },
          { label: 'Apply only inside a media query' },
          { label: 'Inherit from its parent' },
        ],
        skill: 'css-architecture',
      },
      {
        slug: 'css-final-q10',
        prompt: 'A rule is absent from the styles panel entirely. What happened?',
        explanation: 'It never matched the element.',
        options: [
          { label: 'It never matched', correct: true },
          { label: 'It was overridden' },
          { label: 'Its value was invalid' },
          { label: 'It is in an earlier layer' },
        ],
        skill: 'css-debugging',
      },
    ],
  },
};
