import {
  activeRecap,
  callout,
  checklist,
  code,
  cssIs,
  cssMatches,
  cssMediaRule,
  demo,
  detail,
  objectives,
  predictCheck,
  pretest,
  prose,
  recall,
  recap,
  selfExplain,
  term,
  workedExample,
  type LevelSpec,
} from '../types';

/**
 * CSS Level 6 — responsive design.
 *
 * Placed after Grid deliberately: `auto-fit` has already shown the learner that
 * many layouts need no breakpoint at all, so media queries arrive as the
 * exception rather than the default technique.
 */
export const CSS_LEVEL_06: LevelSpec = {
  slug: 'css-responsive',
  title: 'Responsive Design',
  subtitle: 'Fluid by default, breakpoints only where the content demands one',
  summary:
    'Most responsive CSS is written the wrong way round: a fixed layout, then breakpoints to patch it. Start fluid instead, and add a breakpoint only where the content actually breaks.',
  outcome:
    'You can build a layout that works at any width, and justify every breakpoint you added.',
  accent: 'violet',
  modules: [
    {
      slug: 'css-responsive-module',
      title: 'Responsive layout',
      summary: 'Fluid values, media queries, container queries, and choosing breakpoints from content.',
      estimatedMinutes: 55,
      prerequisites: ['css-grid-module'],
      skills: [{ slug: 'responsive', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'css-fluid-first',
          title: 'Fluid first',
          subtitle: 'The values that adapt without any query at all',
          summary:
            'Before reaching for a breakpoint, there are values that simply do the right thing at every width.',
          objectives: [
            'Use `max-width` rather than `width` for containers',
            'Apply `clamp()` for fluid type and spacing',
            'Explain why a breakpoint is a last resort',
          ],
          estimatedMinutes: 16,
          skill: 'responsive',
          blocks: [
            pretest(
              'A container is `width: 1200px`. On a 400px phone, what happens?',
              [
                'It overflows, and the page scrolls sideways',
                'It shrinks to 400px automatically',
                'It wraps onto two lines',
                'The browser ignores the width on small screens',
              ],
              'It overflows and the whole page scrolls sideways — the single most common responsive failure. `width` is an instruction, not a suggestion. What you almost always mean is `max-width: 1200px`, which says "up to 1200px, but never wider than the space available". That one change removes the need for a great many media queries.',
            ),
            objectives([
              'Choose `max-width` over `width` for layout containers',
              'Use `min()`, `max()` and `clamp()` for fluid values',
              'Explain when a query is genuinely needed',
            ]),
            compareBlock(),
            term(
              '`clamp(min, preferred, max)`',
              'A value that scales with the preferred expression but never goes below the minimum or above the maximum. Three numbers replace a set of breakpoints.',
            ),
            code(
              `width: 1200px           overflows below 1200px
max-width: 1200px       up to 1200px, never wider than available

width: min(100%, 65ch)  the smaller of the two — fluid, capped

font-size: clamp(1rem, 0.9rem + 0.5vw, 1.5rem)
  never below 1rem, never above 1.5rem, and scales
  smoothly with the viewport in between

padding: clamp(1rem, 5vw, 4rem)
  the same idea for spacing`,
              'Values that adapt on their own',
              'text',
            ),
            demo('Fixed, fluid, and clamped', 'Narrow the preview to see the difference.', [
              {
                label: 'max-width',
                code: '<style>\n  .wrap { max-width: 40rem; margin-inline: auto; border: 1px solid teal; padding: 1rem; }\n</style>\n<div class="wrap">Up to 40rem wide, and never wider than the space available. Centred by the auto inline margins.</div>',
                note: 'The everyday container. `margin-inline: auto` centres it once it stops filling the width.',
              },
              {
                label: 'Fixed width',
                code: '<style>\n  .wrap { width: 40rem; border: 1px solid crimson; padding: 1rem; }\n</style>\n<div class="wrap">Exactly 40rem, whatever the screen. Below that, the page scrolls sideways.</div>',
                note: 'The same layout with one word changed, and it now overflows on any narrow screen.',
              },
              {
                label: 'Clamped type',
                code: '<style>\n  .wrap { max-width: 40rem; margin-inline: auto; }\n  h2 { font-size: clamp(1.5rem, 1rem + 2vw, 3rem); }\n</style>\n<div class="wrap"><h2>A heading that scales</h2><p>Never smaller than 1.5rem, never larger than 3rem.</p></div>',
                note: 'One declaration replaces the three or four breakpoints this would otherwise need.',
              },
            ]),
            callout(
              'tip',
              'Set the measure in `ch`',
              'Long lines are genuinely harder to read — the eye loses its place returning to the start. A comfortable measure is roughly 45–75 characters, and `max-width: 65ch` says exactly that in a unit that follows the font rather than guessing in pixels.',
            ),
            predictCheck(
              `<style>
  .wrap { width: min(100%, 65ch); margin-inline: auto; }
</style>
<div class="wrap">
  <p>A paragraph of body text.</p>
</div>`,
              '`width: min(100%, 65ch)` — two values, and the smaller wins. Before you check: what does this do on a wide screen, and on a phone?',
              'On a wide screen `65ch` is smaller, so the container caps at a readable measure. On a phone `100%` is smaller, so it fills the width with no overflow. It behaves exactly like `max-width: 65ch` and reads more directly as "whichever of these is smaller" — which is also why `min()` produces a *maximum* and `max()` produces a *minimum*, a naming that catches everyone once. `max(1rem, 3vw)` means "at least 1rem".',
            ),
            detail(
              'Logical properties',
              '`margin-inline: auto` rather than `margin-left`/`margin-right`, and `padding-block` rather than top and bottom. Inline is the direction text runs; block is the direction lines stack. In English they map onto horizontal and vertical, and in Arabic or Japanese they follow the writing mode automatically — so a layout written this way needs no changes to be mirrored for a right-to-left language.',
            ),
            recap(
              [
                '`max-width` instead of `width` removes most overflow before it happens.',
                '`clamp()` gives fluid type and spacing with a floor and a ceiling.',
                '`min()` yields a maximum; `max()` yields a minimum.',
                '`ch` expresses a readable measure in terms of the font itself.',
              ],
              'Next: media and container queries.',
            ),
            activeRecap(
              [
                'Why is `max-width` almost always meant where `width` is written?',
                'What do the three values in `clamp()` do?',
                'Why does `min()` produce a maximum?',
              ],
              [
                'Because `width` is an instruction the browser obeys even when there is not room, so it overflows on narrow screens. `max-width` caps the size while still allowing it to shrink.',
                'A floor, a preferred value that scales, and a ceiling — so the value adapts smoothly but never becomes unreadably small or absurdly large.',
                'Because it returns whichever argument is smallest, so the result can never exceed the smallest of them — which is what a maximum is. `max()` is the mirror image and enforces a minimum.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-fluid-guided',
              kind: 'guided',
              title: 'A container that never overflows',
              brief:
                'Give `.wrap` a maximum width of `65ch`, centre it with automatic inline margins, and give the heading a font size that clamps between `1.5rem` and `3rem`, scaling with `1rem + 2vw` in between.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Fluid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .wrap { border: 1px solid teal; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="wrap">
      <h2>Fresh bread, every morning</h2>
      <p>We open at 6am and bake until we sell out.</p>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Fluid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .wrap {
        max-width: 65ch;
        margin-inline: auto;
        border: 1px solid teal;
        padding: 1rem;
      }
      .wrap h2 { font-size: clamp(1.5rem, 1rem + 2vw, 3rem); }
    </style>
  </head>
  <body>
    <div class="wrap">
      <h2>Fresh bread, every morning</h2>
      <p>We open at 6am and bake until we sell out.</p>
    </div>
  </body>
</html>`,
              hints: [
                'max-width caps the size without preventing it shrinking.',
                'margin-inline: auto centres a block once it is narrower than its parent.',
                'clamp takes three arguments: minimum, preferred, maximum.',
              ],
              requirements: [
                cssIs('.wrap', 'max-width', '65ch', 'The container caps at a readable measure'),
                cssIs('.wrap', 'margin-inline', 'auto', 'The container is centred'),
                cssMatches('.wrap h2', 'font-size', 'clamp\\(', 'The heading uses clamp'),
              ],
              difficulty: 2,
              xp: 45,
              skill: 'responsive',
            },
          ],
          quiz: [
            {
              slug: 'q-css-max-width',
              prompt: 'Why does `width: 1200px` cause sideways scrolling on a phone?',
              explanation: '`width` is obeyed exactly, so the element stays 1200px wide and overflows the screen.',
              options: [
                { label: 'It is obeyed exactly, so the element overflows', correct: true },
                { label: 'Phones ignore pixel units' },
                { label: 'It needs a media query to apply' },
                { label: 'Because of the box model' },
              ],
              skill: 'responsive',
            },
            {
              slug: 'q-css-clamp-parts',
              prompt: 'What is the middle argument of `clamp()`?',
              explanation: 'The preferred value, usually one that scales — the other two are the floor and ceiling.',
              options: [
                { label: 'The preferred, usually scaling, value', correct: true },
                { label: 'The maximum' },
                { label: 'The minimum' },
                { label: 'A fallback for old browsers' },
              ],
              skill: 'responsive',
            },
            {
              slug: 'q-css-ch-unit',
              prompt: 'What does the `ch` unit express?',
              explanation: 'A width relative to the font’s character width, which is how a readable measure is stated.',
              options: [
                { label: 'A width based on the font’s character width', correct: true },
                { label: 'A fixed number of pixels' },
                { label: 'A percentage of the viewport' },
                { label: 'The height of a line' },
              ],
              skill: 'responsive',
            },
          ],
        },
        {
          slug: 'css-queries',
          title: 'Media and container queries',
          subtitle: 'Choosing breakpoints from the content, and asking about the container instead',
          summary:
            'When a query is genuinely needed, the question is which one — and increasingly the right answer is a container query rather than a media query.',
          objectives: [
            'Write a mobile-first media query',
            'Choose a breakpoint from the content, not a device',
            'Use a container query and say when it is the better tool',
          ],
          estimatedMinutes: 18,
          skill: 'responsive',
          blocks: [
            pretest(
              'Where should a breakpoint go?',
              [
                'Wherever the content starts to look wrong',
                'At 768px, because that is the iPad width',
                'At the width of the most popular phone',
                'Every 200px, evenly',
              ],
              'Wherever the content breaks. Device widths date immediately — there is no single iPad width any more, and there never really was — while the width at which a headline wraps badly or a card becomes too narrow to read is a property of *your* design and stays true. Narrow the browser until it looks wrong; that is the breakpoint, and it will not be a round number.',
            ),
            objectives([
              'Write min-width queries in a mobile-first order',
              'Justify a breakpoint from the design',
              'Apply a container query to a reusable component',
            ]),
            prose(
              'Mobile-first means writing the narrow layout as the default and adding to it with `min-width` queries. The alternative — a wide default patched with `max-width` queries — means the smallest, slowest devices download and apply the most rules.',
            ),
            code(
              `/* Default: the narrow layout, no query at all */
.cards { display: grid; gap: 1rem; }

/* Then add, as space allows */
@media (min-width: 40rem) {
  .cards { grid-template-columns: repeat(2, 1fr); }
}

@media (min-width: 64rem) {
  .cards { grid-template-columns: repeat(3, 1fr); }
}

/* A container query asks about the parent instead */
.panel { container-type: inline-size; }

@container (min-width: 30rem) {
  .card { display: grid; grid-template-columns: 8rem 1fr; }
}`,
              'Mobile-first, and the container alternative',
            ),
            workedExample(
              'Choosing a breakpoint honestly',
              'A card row that needs one. Here is how to find where, without guessing a device.',
              [
                {
                  title: 'Start with no query at all',
                  code: `.cards { display: grid; gap: 1rem; }`,
                  reasoning:
                    'One column, stacked. This is the layout that works on the narrowest screen, and it is the default rather than an exception. Very often the work stops here.',
                },
                {
                  title: 'Widen the browser until it looks wrong',
                  code: `/* Around 38rem the single column is
   uncomfortably wide for the text. */`,
                  reasoning:
                    'Not "what width is a tablet" — literally drag the window and watch. The point where the line length becomes uncomfortable is a fact about this design and this font, and it will not be a round number.',
                },
                {
                  title: 'Put the breakpoint just past it',
                  code: `@media (min-width: 40rem) {
  .cards { grid-template-columns: repeat(2, 1fr); }
}`,
                  reasoning:
                    '`rem` rather than `px` so the breakpoint respects a reader who has increased their default font size — at which point the text needs the second column sooner, and a px breakpoint would not know.',
                },
                {
                  title: 'Ask whether the query was needed at all',
                  code: `.cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));
  gap: 1rem;
}`,
                  reasoning:
                    'For a card grid, usually not. `auto-fit` does the same job at every width, responds to the container rather than the viewport, and has no number to keep in sync with the design. Reach for a query when the layout must *change shape*, not merely change column count.',
                },
              ],
            ),
            term(
              'Container query',
              'A query about the width of an element\'s container rather than the viewport. The container must opt in with `container-type: inline-size`.',
            ),
            demo('The same card, two contexts', 'Why the viewport is often the wrong thing to ask about.', [
              {
                label: 'Container query',
                code: '<style>\n  .panel { container-type: inline-size; border: 1px solid teal; padding: 0.5rem; }\n  .card { display: grid; gap: 0.5rem; background: #cde; padding: 0.5rem; }\n  @container (min-width: 24rem) { .card { grid-template-columns: 6rem 1fr; } }\n</style>\n<div class="panel"><div class="card"><div>Image</div><div>A card that rearranges itself based on the panel it is in.</div></div></div>',
                note: 'The card asks how much room *it* has. Put the same panel in a sidebar and it lays out correctly with no extra CSS.',
              },
              {
                label: 'Media query',
                code: '<style>\n  .panel { border: 1px solid crimson; padding: 0.5rem; }\n  .card { display: grid; gap: 0.5rem; background: #fee; padding: 0.5rem; }\n  @media (min-width: 24rem) { .card { grid-template-columns: 6rem 1fr; } }\n</style>\n<div class="panel"><div class="card"><div>Image</div><div>A card that only knows how wide the window is.</div></div></div>',
                note: 'On a wide monitor this goes two-column even inside a 15rem sidebar, because the viewport is wide and the card has no idea it is not.',
              },
            ]),
            callout(
              'mistake',
              'Breakpoints named after devices',
              'Variables called `$tablet` and `$phone` encode an assumption that stopped being true years ago, and they make the CSS lie: the rule is not about tablets, it is about the width at which two columns start to work. Name breakpoints after what changes — `--bp-cards-two-up` — or do not name them at all.',
            ),
            selfExplain(
              'Your team has breakpoints at 576, 768, 992 and 1200px copied from a framework, applied to every component. Write the case for changing the approach.',
              'Those four numbers describe a framework\'s grid, not this design\'s content — so every component is being asked to change shape at moments that have nothing to do with when it actually needs to. In practice that means some components break *between* breakpoints and get patched with a fifth, while others change for no visible reason. The alternative is two moves: make components intrinsically responsive where possible, with `auto-fit`, `clamp()` and `max-width`, so most of them need no breakpoint at all; and where a genuine shape change is needed, find the width by narrowing the browser until *that component* looks wrong, and put the query there in `rem`. The result is fewer queries, each of which can be justified by pointing at the screen.',
            ),
            checklist('Before adding a breakpoint', [
              'Would `max-width` or `clamp()` solve it with no query?',
              'Would `auto-fit` handle the column count on its own?',
              'Is the layout genuinely changing *shape*, not just size?',
              'Did the number come from narrowing the browser, or from a device?',
              'Is it in `rem`, so it respects the reader\'s font size?',
              'Should this be a container query instead?',
            ]),
            recap(
              [
                'Mobile-first: the narrow layout is the default, `min-width` queries add to it.',
                'Breakpoints come from where the content breaks, not from device widths.',
                'Use `rem` so a breakpoint respects an increased default font size.',
                'Container queries ask about the component\'s own space, which is usually the better question.',
              ],
              'Next: the Level 6 milestone.',
            ),
            activeRecap(
              [
                'How do you find where a breakpoint belongs?',
                'Why write breakpoints in `rem` rather than `px`?',
                'When is a container query the better tool?',
              ],
              [
                'Narrow the browser until the content looks wrong, and put the query just past that point. It is a fact about the design, not about any device, and it will not be a round number.',
                'Because a `rem` breakpoint scales with the reader\'s default font size. Someone who has increased it needs the layout to change sooner, and a `px` breakpoint cannot know that.',
                'Whenever the component can appear in more than one context — a sidebar, a modal, a grid cell. It asks how much room the component actually has, where a media query only knows the window.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-mobile-first-guided',
              kind: 'guided',
              title: 'Mobile-first, two breakpoints',
              brief:
                'Write the card grid mobile-first: one column by default, two columns from `40rem`, three from `64rem`. Use `min-width` queries and a `1rem` gap.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards {
        display: grid;
        grid-template-columns: 1fr;
        gap: 1rem;
      }

      @media (min-width: 40rem) {
        .cards { grid-template-columns: repeat(2, 1fr); }
      }

      @media (min-width: 64rem) {
        .cards { grid-template-columns: repeat(3, 1fr); }
      }

      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
    </div>
  </body>
</html>`,
              hints: [
                'The single-column layout goes outside any query — that is what mobile-first means.',
                'Each query is @media (min-width: …) { … }.',
                'Use rem for the breakpoint values.',
              ],
              requirements: [
                cssIs('.cards', 'display', 'grid', 'The card row is a grid'),
                cssIs('.cards', 'grid-template-columns', '1fr', 'One column by default'),
                cssMediaRule('(min-width: 40rem)', 'There is a 40rem breakpoint'),
                cssMediaRule('(min-width: 64rem)', 'There is a 64rem breakpoint'),
                cssMatches('.cards', 'grid-template-columns', 'repeat\\(2,\\s*1fr\\)', 'Two columns from 40rem', {
                  condition: '(min-width: 40rem)',
                }),
                cssMatches('.cards', 'grid-template-columns', 'repeat\\(3,\\s*1fr\\)', 'Three columns from 64rem', {
                  condition: '(min-width: 64rem)',
                }),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'responsive',
            },
            {
              slug: 'css-responsive-debug',
              kind: 'debug',
              title: 'Desktop-first, and overflowing',
              brief:
                'This is written the wrong way round: a fixed width and a `max-width` query patching it. Rewrite it mobile-first — one column as the default with no query, two columns from `40rem` — and replace the fixed `width` with a `max-width` so it cannot overflow.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .wrap { width: 60rem; margin-inline: auto; }
      .cards { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1rem; }

      @media (max-width: 40rem) {
        .cards { grid-template-columns: 1fr; }
      }

      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="wrap">
      <div class="cards">
        <div>Sourdough</div>
        <div>Rye</div>
      </div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .wrap { max-width: 60rem; margin-inline: auto; }
      .cards { display: grid; grid-template-columns: 1fr; gap: 1rem; }

      @media (min-width: 40rem) {
        .cards { grid-template-columns: repeat(2, 1fr); }
      }

      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="wrap">
      <div class="cards">
        <div>Sourdough</div>
        <div>Rye</div>
      </div>
    </div>
  </body>
</html>`,
              hints: [
                'A fixed width overflows on narrow screens — max-width does not.',
                'Mobile-first means the single column is the default, outside any query.',
                'Swap the max-width query for a min-width one.',
              ],
              requirements: [
                cssIs('.wrap', 'max-width', '60rem', 'The wrapper uses max-width'),
                cssIs('.cards', 'grid-template-columns', '1fr', 'One column is the default'),
                cssMediaRule('(min-width: 40rem)', 'The query is mobile-first'),
                cssMatches('.cards', 'grid-template-columns', 'repeat\\(2,\\s*1fr\\)', 'Two columns from 40rem', {
                  condition: '(min-width: 40rem)',
                }),
              ],
              difficulty: 4,
              xp: 60,
              skill: 'responsive',
            },
          ],
          quiz: [
            {
              slug: 'q-css-mobile-first',
              prompt: 'What does mobile-first mean in practice?',
              explanation:
                'The narrow layout is the default with no query, and `min-width` queries add to it as space allows.',
              options: [
                { label: 'The narrow layout is the default; min-width queries add to it', correct: true },
                { label: 'You design on a phone first' },
                { label: 'All queries use max-width' },
                { label: 'Desktop styles load first' },
              ],
              skill: 'responsive',
            },
            {
              slug: 'q-css-breakpoint-source',
              prompt: 'Where should a breakpoint value come from?',
              explanation: 'From the width at which your content stops working, found by narrowing the browser.',
              options: [
                { label: 'The width at which the content breaks', correct: true },
                { label: 'The most popular device width' },
                { label: 'A framework’s defaults' },
                { label: 'Round numbers, for tidiness' },
              ],
              skill: 'responsive',
            },
            {
              slug: 'q-css-container-query-why',
              prompt: 'Why is a container query often better for a reusable component?',
              explanation:
                'It responds to the space the component actually has, so it behaves correctly in a sidebar or modal.',
              options: [
                { label: 'It asks about the component’s own space, not the window', correct: true },
                { label: 'It has higher specificity' },
                { label: 'It works in older browsers' },
                { label: 'It removes the need for grid' },
              ],
              skill: 'responsive',
            },
          ],
        },
        {
          slug: 'css-responsive-milestone',
          title: 'Milestone: one layout, every width',
          subtitle: 'Fluid where possible, queried where necessary',
          summary: 'A page that works from 320px to a wide monitor, with every breakpoint justified.',
          objectives: [
            'Combine fluid values with a minimum of queries',
            'Justify each breakpoint',
            'Avoid horizontal overflow at any width',
          ],
          estimatedMinutes: 20,
          skill: 'responsive',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Build a page that survives any width',
              'Prefer intrinsic techniques to breakpoints',
              'Explain every query you kept',
            ]),
            code(
              `Reach for these first, in this order:

1. max-width          stops overflow
2. auto-fit + minmax  column count with no query
3. clamp()            fluid type and spacing
4. container query    when the component is reusable
5. media query        when the layout changes SHAPE

Most pages need one or two of item 5. Many need none.`,
              'The order to reach for things',
              'text',
            ),
            demo('The same page, two approaches', 'Both work. One is much less code.', [
              {
                label: 'Intrinsic',
                code: '<style>\n  .wrap { max-width: 60rem; margin-inline: auto; padding: clamp(1rem, 4vw, 3rem); }\n  .cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(10rem, 1fr)); gap: 1rem; }\n  .cards > div { background: #cde; padding: 1rem; }\n</style>\n<div class="wrap"><div class="cards"><div>A</div><div>B</div><div>C</div></div></div>',
                note: 'No media query at all. The column count, the padding and the container width all adapt on their own.',
              },
              {
                label: 'Breakpoint-driven',
                code: '<style>\n  .wrap { max-width: 60rem; margin-inline: auto; padding: 1rem; }\n  .cards { display: grid; grid-template-columns: 1fr; gap: 1rem; }\n  @media (min-width: 40rem) { .cards { grid-template-columns: repeat(2, 1fr) } .wrap { padding: 2rem } }\n  @media (min-width: 64rem) { .cards { grid-template-columns: repeat(3, 1fr) } .wrap { padding: 3rem } }\n</style>\n<div class="wrap"><div class="cards"><div>A</div><div>B</div><div>C</div></div></div>',
                note: 'The same result at three specific widths and stepped changes between them, with two numbers to keep in sync with the design.',
              },
            ]),
            recall(
              'From memory: list the techniques to reach for before writing a media query, and say what each one removes the need for.',
              [
                '`max-width` instead of `width` — removes horizontal overflow.',
                '`repeat(auto-fit, minmax(X, 1fr))` — removes breakpoints that only change column count.',
                '`clamp()` — removes stepped font-size and spacing breakpoints.',
                'Logical properties such as `margin-inline` — remove the need for right-to-left overrides.',
                'Container queries — remove breakpoints that were really about the component, not the window.',
              ],
            ),
            recap(
              [
                'Fluid first: `max-width`, `clamp()`, `auto-fit`.',
                'A media query is for a change of shape, not a change of size.',
                'Breakpoints belong in `rem` and come from the content.',
              ],
              'Next: custom properties.',
            ),
            activeRecap(
              ['Why does an intrinsically responsive layout usually beat a breakpoint-driven one?'],
              [
                'Because it responds continuously to the space available rather than stepping at a few chosen widths, so it is correct at every width instead of at three. It also has no numbers to keep in sync with the design, and it keeps working when the component is moved into a narrower context — which a viewport breakpoint cannot do.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-responsive-milestone-challenge',
              kind: 'challenge',
              title: 'A page that works at every width',
              brief:
                'Give `.wrap` a `max-width` of `60rem`, centre it, and give it padding that clamps between `1rem` and `3rem` scaling on `4vw`. Make `.cards` an `auto-fit` grid with a `12rem` minimum and a `1rem` gap. Write no media query at all.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive page</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="wrap">
      <h1>Riverside Bakery</h1>
      <div class="cards">
        <div>Sourdough</div>
        <div>Rye</div>
        <div>Seeded</div>
      </div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive page</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .wrap {
        max-width: 60rem;
        margin-inline: auto;
        padding: clamp(1rem, 4vw, 3rem);
      }
      .cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(12rem, 1fr));
        gap: 1rem;
      }
      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="wrap">
      <h1>Riverside Bakery</h1>
      <div class="cards">
        <div>Sourdough</div>
        <div>Rye</div>
        <div>Seeded</div>
      </div>
    </div>
  </body>
</html>`,
              hints: [
                'clamp(1rem, 4vw, 3rem) for the padding.',
                'repeat(auto-fit, minmax(12rem, 1fr)) for the columns.',
                'margin-inline: auto centres the wrapper.',
              ],
              requirements: [
                cssIs('.wrap', 'max-width', '60rem', 'The wrapper caps at 60rem'),
                cssIs('.wrap', 'margin-inline', 'auto', 'The wrapper is centred'),
                cssMatches('.wrap', 'padding', 'clamp\\(', 'Padding is fluid'),
                cssMatches(
                  '.cards',
                  'grid-template-columns',
                  'repeat\\(auto-fit,\\s*minmax\\(12rem,\\s*1fr\\)\\)',
                  'The card grid is intrinsically responsive',
                ),
              ],
              difficulty: 4,
              xp: 70,
              skill: 'responsive',
            },
          ],
          quiz: [
            {
              slug: 'q-css-query-last-resort',
              prompt: 'What is a media query genuinely for?',
              explanation: 'A change of layout *shape* that fluid techniques cannot express.',
              options: [
                { label: 'A change of shape that fluid values cannot express', correct: true },
                { label: 'Any change at all between screen sizes' },
                { label: 'Setting font sizes' },
                { label: 'Preventing overflow' },
              ],
              skill: 'responsive',
            },
            {
              slug: 'q-css-rem-breakpoints',
              prompt: 'Why write breakpoints in `rem`?',
              explanation:
                'They then scale with the reader’s default font size, so someone using larger text gets the layout change sooner.',
              options: [
                { label: 'They respect a reader’s increased default font size', correct: true },
                { label: 'They render faster' },
                { label: 'Pixels are not allowed in media queries' },
                { label: 'It avoids rounding errors' },
              ],
              skill: 'responsive',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'css-level-6-milestone',
    kind: 'milestone',
    title: 'Level 6 milestone: Responsive Design',
    description: 'Six questions on fluid values, breakpoints and container queries. Pass mark 75%.',
    passScore: 0.75,
    xp: 180,
    questions: [
      {
        slug: 'a-css-6-max-width',
        prompt: 'Which prevents a container overflowing a narrow screen?',
        explanation: '`max-width` caps the size while still allowing the element to shrink.',
        options: [
          { label: '`max-width`', correct: true },
          { label: '`width`' },
          { label: '`min-width`' },
          { label: '`flex-basis`' },
        ],
        skill: 'responsive',
      },
      {
        slug: 'a-css-6-clamp',
        prompt: '`clamp(1rem, 0.9rem + 0.5vw, 1.5rem)` — what is the largest this can be?',
        explanation: '1.5rem, the third argument.',
        options: [
          { label: '1.5rem', correct: true },
          { label: '1rem' },
          { label: '0.5vw' },
          { label: 'Unbounded' },
        ],
        skill: 'responsive',
      },
      {
        slug: 'a-css-6-min-max-naming',
        prompt: '`width: min(100%, 65ch)` behaves like which single property?',
        explanation: 'Like `max-width: 65ch` — `min()` returns the smaller, so it caps the result.',
        options: [
          { label: '`max-width: 65ch`', correct: true },
          { label: '`min-width: 65ch`' },
          { label: '`width: 65ch`' },
          { label: '`flex-basis: 65ch`' },
        ],
        skill: 'responsive',
      },
      {
        slug: 'a-css-6-mobile-first-order',
        prompt: 'In a mobile-first stylesheet, what sits outside every media query?',
        explanation: 'The narrow layout — it is the default that queries then add to.',
        options: [
          { label: 'The narrow layout', correct: true },
          { label: 'The widest layout' },
          { label: 'Only the colours' },
          { label: 'Nothing; everything is in a query' },
        ],
        skill: 'responsive',
      },
      {
        slug: 'a-css-6-container-type',
        prompt: 'What must a container declare before `@container` queries work against it?',
        explanation: '`container-type: inline-size` opts the element in.',
        options: [
          { label: '`container-type: inline-size`', correct: true },
          { label: '`display: grid`' },
          { label: '`position: relative`' },
          { label: '`overflow: hidden`' },
        ],
        skill: 'responsive',
      },
      {
        slug: 'a-css-6-device-breakpoints',
        prompt: 'What is wrong with breakpoints named after devices?',
        explanation:
          'Device widths change constantly, and the rule is really about where the content breaks — which is a property of the design.',
        options: [
          { label: 'They describe hardware that changes, not the design that does not', correct: true },
          { label: 'They are invalid CSS' },
          { label: 'They cannot use rem units' },
          { label: 'They only work in mobile-first order' },
        ],
        skill: 'responsive',
      },
    ],
  },
};

/** Kept separate for readability: the fixed-versus-fluid comparison. */
function compareBlock() {
  return {
    type: 'comparison' as const,
    title: 'The one-word difference that causes most overflow',
    data: {
      good: {
        label: 'Fluid',
        code: '.wrap {\n  max-width: 60rem;\n  margin-inline: auto;\n}',
        why: 'Up to 60rem, and never wider than the space available. Works at every width with no query.',
      },
      bad: {
        label: 'Fixed',
        code: '.wrap {\n  width: 60rem;\n  margin-inline: auto;\n}',
        why: 'Exactly 60rem, always. Below that the page scrolls sideways, and every later breakpoint is patching this one decision.',
      },
    },
  };
}
