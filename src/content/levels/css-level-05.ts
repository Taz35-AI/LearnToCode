import {
  activeRecap,
  callout,
  checklist,
  code,
  cssIs,
  cssMatches,
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
 * CSS Level 5 — Grid, taught until fluent.
 *
 * Grid is introduced after Flexbox because the useful distinction — one
 * dimension versus two — only means something once the learner has actually
 * built a one-dimensional layout and felt where it stops being enough.
 */
export const CSS_LEVEL_05: LevelSpec = {
  slug: 'css-grid',
  title: 'Grid',
  subtitle: 'Two dimensions, named areas, and layouts that need no breakpoints',
  summary:
    'Grid lays out rows and columns at once. It also contains the single most useful line in modern CSS — a responsive layout in one declaration, with no media query at all.',
  outcome: 'You can build any two-dimensional layout and make it responsive without a breakpoint.',
  accent: 'violet',
  modules: [
    {
      slug: 'css-grid-module',
      title: 'Grid',
      summary: 'Tracks, the fr unit, named areas, and intrinsically responsive layouts.',
      estimatedMinutes: 60,
      prerequisites: ['css-flex'],
      skills: [{ slug: 'grid', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'css-grid-tracks',
          title: 'Tracks and the `fr` unit',
          subtitle: 'Defining columns, and the unit that only exists in grid',
          summary:
            'A grid is columns and rows you declare up front. One new unit does most of the work.',
          objectives: [
            'Define explicit columns and rows',
            'Explain what `fr` measures',
            'Use `gap` and `repeat()`',
          ],
          estimatedMinutes: 16,
          skill: 'grid',
          blocks: [
            pretest(
              'A grid has `grid-template-columns: 200px 1fr 1fr` and a `2rem` gap. The container is 1000px wide. How wide is each `1fr` column?',
              [
                'About 368px — the gap is subtracted first, then the rest is split',
                '400px — half of the remaining 800px',
                '333px — a third of 1000px',
                '266px — a third of the remaining 800px',
              ],
              'About 368px. `fr` distributes what is *left over* after fixed tracks and every gap have been taken out: 1000 − 200 (the fixed column) − 64 (two 2rem gaps) = 736, split in two. This is why `fr` behaves so well in practice — it never causes the overflow that percentages do, because percentages are computed before gaps are subtracted and then push the layout wider.',
            ),
            objectives([
              'Declare explicit column and row tracks',
              'Use `fr` to distribute leftover space',
              'Shorten repeated tracks with `repeat()`',
            ]),
            term(
              'Track',
              'A column or a row. `grid-template-columns` declares the column tracks; `grid-template-rows` declares the row tracks.',
            ),
            term(
              '`fr`',
              'A fraction of the *leftover* space, after fixed tracks and gaps are accounted for. It exists only in grid, and it is why grid layouts rarely overflow.',
            ),
            code(
              `display: grid;
grid-template-columns: 200px 1fr 1fr;   three columns
grid-template-columns: repeat(3, 1fr);  the same as 1fr 1fr 1fr
grid-template-rows: auto 1fr auto;      header, filling body, footer
gap: 1rem;                              between every track
column-gap / row-gap                    if they differ

Values a track can take:
  200px, 20%      fixed
  auto            as big as its content needs
  1fr             a share of the leftover space
  minmax(a, b)    at least a, at most b
  min-content     the smallest it can be without overflowing
  max-content     as wide as it wants to be`,
              'Declaring a grid',
              'text',
            ),
            demo('The same six items, three track definitions', 'Only `grid-template-columns` changes.', [
              {
                label: 'Three equal columns',
                code: '<style>\n  .grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 0.5rem; border: 1px solid teal; padding: 0.5rem; }\n  .grid > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class="grid"><div>1</div><div>2</div><div>3</div><div>4</div><div>5</div><div>6</div></div>',
                note: 'Six items flow into three columns, creating two rows automatically. You never declared the rows.',
              },
              {
                label: 'Sidebar and content',
                code: '<style>\n  .grid { display: grid; grid-template-columns: 12rem 1fr; gap: 0.5rem; border: 1px solid teal; padding: 0.5rem; }\n  .grid > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class="grid"><div>Nav</div><div>Content</div><div>Nav</div><div>Content</div></div>',
                note: 'A fixed track and a filling one. The `1fr` takes whatever is left after the 12rem and the gap.',
              },
              {
                label: 'Unequal fractions',
                code: '<style>\n  .grid { display: grid; grid-template-columns: 2fr 1fr; gap: 0.5rem; border: 1px solid teal; padding: 0.5rem; }\n  .grid > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class="grid"><div>Two thirds</div><div>One third</div></div>',
                note: '`fr` values are relative to each other — 2fr and 1fr means two thirds and one third of the leftover space.',
              },
            ]),
            term(
              'Implicit tracks',
              'Rows (or columns) grid creates automatically for items beyond the tracks you declared. `grid-auto-rows` controls their size.',
            ),
            predictCheck(
              `<style>
  .grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1rem;
  }
</style>
<div class="grid">
  <div>1</div><div>2</div><div>3</div>
  <div>4</div><div>5</div>
</div>`,
              'Three columns are declared and five items are supplied. Before you check: what happens to items 4 and 5 — do they overflow, shrink, or something else?',
              'Grid creates a second row automatically and places them in the first two cells of it, leaving the third empty. These are **implicit** rows: you declared three columns and grid worked out how many rows it needed. This is the everyday behaviour that makes grid so comfortable for card layouts — you say how many columns you want and the number of rows takes care of itself. `grid-auto-rows` controls how tall those automatic rows are if the default of `auto` is not what you want.',
            ),
            callout(
              'tip',
              'Prefer `fr` to percentages',
              'Three columns of `33.33%` plus two `1rem` gaps overflows, because the percentages are computed from the full width and the gaps are then added on top. `repeat(3, 1fr)` cannot overflow, because `fr` is defined as a share of what is *left* after the gaps. The same argument applies to `minmax()` over fixed widths.',
            ),
            recap(
              [
                '`display: grid` plus `grid-template-columns` defines the columns.',
                '`fr` distributes leftover space after fixed tracks and gaps.',
                '`repeat(n, …)` shortens repeated track definitions.',
                'Items beyond the declared tracks create implicit rows automatically.',
              ],
              'Next: placing items, and responsive grids with no breakpoints.',
            ),
            activeRecap(
              [
                'What does `1fr` actually measure?',
                'Why does `repeat(3, 1fr)` never overflow where `33.33%` does?',
                'What happens to a seventh item in a three-column grid?',
              ],
              [
                'A share of the space left over after fixed tracks and all gaps have been subtracted.',
                'Because `fr` is defined *after* gaps are taken out, whereas percentages are computed from the full container width and the gaps are then added on top, pushing the total past 100%.',
                'Grid creates an implicit third row and places it in the first cell. You declared columns; the rows follow automatically.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-grid-tracks-guided',
              kind: 'guided',
              title: 'Three columns and a gap',
              brief:
                'Make `.grid` a three-column grid using `repeat()` and `fr`, with a `1rem` gap. Do not use percentages.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Grid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .grid { border: 1px solid teal; padding: 1rem; }
      .grid > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="grid">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
      <div>Focaccia</div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Grid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 1rem;
        border: 1px solid teal;
        padding: 1rem;
      }
      .grid > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="grid">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
      <div>Focaccia</div>
    </div>
  </body>
</html>`,
              hints: [
                'display: grid comes first.',
                'repeat(3, 1fr) is the same as writing 1fr 1fr 1fr.',
                'gap applies between both rows and columns.',
              ],
              requirements: [
                cssIs('.grid', 'display', 'grid', 'The container is a grid'),
                cssMatches('.grid', 'grid-template-columns', 'repeat\\(3,\\s*1fr\\)', 'Three equal columns using repeat and fr'),
                cssIs('.grid', 'gap', '1rem', 'There is a 1rem gap'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'grid',
            },
          ],
          quiz: [
            {
              slug: 'q-css-fr-meaning',
              prompt: 'What does `1fr` distribute?',
              explanation: 'The space left over after fixed tracks and all gaps are subtracted.',
              options: [
                { label: 'Leftover space, after fixed tracks and gaps', correct: true },
                { label: 'A fixed fraction of the viewport' },
                { label: 'A percentage of the container' },
                { label: 'The content width of the largest item' },
              ],
              skill: 'grid',
            },
            {
              slug: 'q-css-implicit-rows',
              prompt: 'Five items in a grid with three declared columns. What happens?',
              explanation: 'Grid creates an implicit second row and places the remaining items in it.',
              options: [
                { label: 'A second row is created automatically', correct: true },
                { label: 'The extra items overflow the container' },
                { label: 'The columns shrink to fit five items' },
                { label: 'The last two items are hidden' },
              ],
              skill: 'grid',
            },
            {
              slug: 'q-css-fr-vs-percent',
              prompt: 'Why can three `33.33%` columns with gaps overflow when `repeat(3, 1fr)` cannot?',
              explanation:
                'Percentages are computed from the full width and gaps are added on top; `fr` is a share of what remains after gaps.',
              options: [
                { label: 'Percentages ignore the gaps, which are then added on top', correct: true },
                { label: 'Percentages are not valid in grid' },
                { label: '`fr` rounds down' },
                { label: 'Gaps only apply to `fr` tracks' },
              ],
              skill: 'grid',
            },
          ],
        },
        {
          slug: 'css-grid-areas-and-auto-fit',
          title: 'Named areas and responsive grids',
          subtitle: 'Drawing a layout in the stylesheet, and the one line that replaces a breakpoint',
          summary:
            'Named areas let a layout be readable at a glance. `auto-fit` with `minmax()` makes it responsive without a single media query.',
          objectives: [
            'Lay out a page with `grid-template-areas`',
            'Explain what `auto-fit` and `minmax()` do together',
            'Build a responsive grid with no breakpoints',
          ],
          estimatedMinutes: 18,
          skill: 'grid',
          blocks: [
            pretest(
              'What does `grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr))` do?',
              [
                'Fits as many columns of at least 16rem as will fit, and shares the rest between them',
                'Creates exactly 16 columns',
                'Makes every column exactly 16rem wide',
                'Creates one column that is at least 16rem',
              ],
              'It fits as many columns as will fit at a minimum of 16rem each, then stretches them to share the leftover space. The number of columns changes with the available width, and you have written **no media query at all** — the layout responds to the space it is actually in rather than to the viewport, so it also works correctly inside a sidebar. This one line is, in practice, the most useful declaration in modern CSS.',
            ),
            objectives([
              'Draw a layout with named grid areas',
              'Combine `auto-fit` with `minmax()`',
              'Explain why this beats a breakpoint',
            ]),
            prose(
              'Grid can place items by name. You draw the layout as text in the stylesheet, and each item says which area it belongs to.',
            ),
            code(
              `.page {
  display: grid;
  grid-template-areas:
    "header header"
    "sidebar main"
    "footer footer";
  grid-template-columns: 12rem 1fr;
  gap: 1rem;
}

.page > header  { grid-area: header;  }
.page > .side   { grid-area: sidebar; }
.page > main    { grid-area: main;    }
.page > footer  { grid-area: footer;  }

A full stop marks a deliberately empty cell:
    "header header"
    "sidebar ."`,
              'Named areas',
            ),
            callout(
              'tip',
              'Named areas document themselves',
              'The quoted rows are a picture of the layout. Somebody reading the stylesheet six months later can see the page shape without opening the browser — which is not true of `grid-column: 2 / 4`. Prefer areas for page-level layout, and line numbers for the occasional item that spans.',
            ),
            workedExample(
              'A responsive card grid, without a single breakpoint',
              'Building up the one declaration that does the whole job.',
              [
                {
                  title: 'Start with a fixed count',
                  code: `grid-template-columns: repeat(3, 1fr);`,
                  reasoning:
                    'Three equal columns. Correct on a laptop and unusable on a phone, where each column is about 100px wide.',
                },
                {
                  title: 'Give each column a minimum',
                  code: `grid-template-columns: repeat(3, minmax(16rem, 1fr));`,
                  reasoning:
                    '`minmax(16rem, 1fr)` means "never narrower than 16rem, otherwise take a fair share". But the count is still fixed at three, so on a narrow screen the grid now overflows instead of squashing. Worse, not better — yet.',
                },
                {
                  title: 'Let grid choose the count',
                  code: `grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));`,
                  reasoning:
                    '`auto-fit` replaces the fixed number with "as many as will fit". Grid works out how many 16rem columns the container can hold, creates that many, and the `1fr` stretches them to fill. One column on a phone, four on a wide screen, and nothing in the stylesheet mentions a device.',
                },
                {
                  title: 'Know the one difference from `auto-fill`',
                  code: `repeat(auto-fill, minmax(16rem, 1fr))`,
                  reasoning:
                    '`auto-fill` keeps the empty tracks it created; `auto-fit` collapses them. With three cards in a container wide enough for five, `auto-fill` leaves two empty columns and the cards stay narrow, while `auto-fit` collapses them so the three cards stretch across. For card layouts you almost always want `auto-fit`.',
                },
              ],
            ),
            demo('auto-fit in action', 'The same declaration, different container widths.', [
              {
                label: 'The responsive grid',
                code: '<style>\n  .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(10rem, 1fr)); gap: 1rem; border: 1px solid teal; padding: 1rem; }\n  .grid > div { background: #cde; padding: 1rem; }\n</style>\n<div class="grid"><div>Sourdough</div><div>Rye</div><div>Seeded</div><div>Focaccia</div></div>',
                note: 'Resize the preview. The number of columns changes on its own, and there is no media query anywhere.',
              },
              {
                label: 'A named-area page',
                code: '<style>\n  .page { display: grid; grid-template-areas: "header header" "side main" "footer footer"; grid-template-columns: 8rem 1fr; gap: 0.5rem; border: 1px solid teal; padding: 0.5rem; }\n  .page > * { background: #cde; padding: 0.5rem; }\n  .h { grid-area: header } .s { grid-area: side } .m { grid-area: main } .f { grid-area: footer }\n</style>\n<div class="page"><div class="h">Header</div><div class="s">Side</div><div class="m">Main</div><div class="f">Footer</div></div>',
                note: 'The quoted rows in the CSS are a picture of what you see. Reordering the layout means editing that picture.',
              },
            ]),
            selfExplain(
              'A colleague says `repeat(auto-fit, minmax(16rem, 1fr))` is "just a shortcut for media queries". Write your reply, and be specific about a case where the two genuinely differ.',
              'It is not a shortcut, it answers a different question. A media query asks how wide the *viewport* is; `auto-fit` asks how much room this *container* actually has. Those agree for a full-width grid and diverge the moment the component is reused. Drop the same card grid into a 20rem sidebar on a 1400px monitor and the media query says "wide screen, four columns" and produces four 5rem columns of unreadable text, while `auto-fit` correctly gives one. The same is true inside a modal, a split view, or another grid cell. It is also less code, has no magic numbers to keep in sync with the design, and cannot drift out of step with them.',
            ),
            detail(
              'Placing an item across tracks',
              '`grid-column: 1 / 3` places an item from line 1 to line 3 — remember lines are the edges, so that spans two columns. `grid-column: span 2` says the same thing relative to wherever the item lands. `grid-row` works identically for rows. Lines can be named too, but for page layout `grid-template-areas` is nearly always more readable.',
            ),
            checklist('Choosing between flexbox and grid', [
              'One dimension — a row *or* a column — is flexbox',
              'Two dimensions at once — rows *and* columns — is grid',
              'Content decides the sizes: flexbox',
              'The layout decides the sizes: grid',
              'A wrapping card row works well in either; grid keeps the columns aligned',
            ]),
            recap(
              [
                '`grid-template-areas` draws the layout as readable text.',
                '`repeat(auto-fit, minmax(X, 1fr))` is a responsive grid with no media query.',
                '`auto-fit` collapses empty tracks; `auto-fill` keeps them.',
                'Flexbox is one dimension, grid is two.',
              ],
              'Next: the Level 5 milestone.',
            ),
            activeRecap(
              [
                'What does `repeat(auto-fit, minmax(16rem, 1fr))` do, in one sentence?',
                'What is the difference between `auto-fit` and `auto-fill`?',
                'Why does this beat a media query for a reusable component?',
              ],
              [
                'Creates as many columns as fit at a minimum of 16rem, then stretches them to share the leftover space.',
                '`auto-fill` keeps the empty tracks it created, so items stay narrow; `auto-fit` collapses them so the items stretch to fill.',
                'Because it responds to the container\'s width rather than the viewport\'s. The same component then behaves correctly in a full-width page, a sidebar or a modal, where a viewport breakpoint would give the wrong answer.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-grid-responsive-guided',
              kind: 'guided',
              title: 'A responsive grid with no breakpoints',
              brief:
                'Make `.cards` a grid whose columns are at least `16rem` and as many as will fit, stretching to fill. Use a `1rem` gap. Do not write a media query.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive grid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards { border: 1px solid teal; padding: 1rem; }
      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
      <div>Focaccia</div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive grid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));
        gap: 1rem;
        border: 1px solid teal;
        padding: 1rem;
      }
      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
      <div>Focaccia</div>
    </div>
  </body>
</html>`,
              hints: [
                'The pattern is repeat(auto-fit, minmax(MIN, 1fr)).',
                'auto-fit collapses empty tracks so the cards stretch.',
                'No @media rule is needed anywhere.',
              ],
              requirements: [
                cssIs('.cards', 'display', 'grid', 'The container is a grid'),
                cssMatches(
                  '.cards',
                  'grid-template-columns',
                  'repeat\\(auto-fit,\\s*minmax\\(16rem,\\s*1fr\\)\\)',
                  'Columns use auto-fit with a 16rem minimum',
                ),
                cssIs('.cards', 'gap', '1rem', 'There is a 1rem gap'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'grid',
            },
            {
              slug: 'css-grid-areas-debug',
              kind: 'debug',
              title: 'A page layout that will not assemble',
              brief:
                'The named areas are declared but the items do not use them, and the columns are percentages that overflow with the gap. Give each child the right `grid-area`, and replace the percentage columns with `12rem 1fr`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Page layout</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .page {
        display: grid;
        grid-template-areas:
          "header header"
          "side main"
          "footer footer";
        grid-template-columns: 30% 70%;
        gap: 1rem;
      }
      .page > * { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="page">
      <header class="site-header">Riverside</header>
      <aside class="site-side">Routes</aside>
      <main class="site-main">Hire a bike by the hour.</main>
      <footer class="site-footer">© 2026</footer>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Page layout</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .page {
        display: grid;
        grid-template-areas:
          "header header"
          "side main"
          "footer footer";
        grid-template-columns: 12rem 1fr;
        gap: 1rem;
      }
      .page > * { background: #cde; padding: 1rem; }

      .site-header { grid-area: header; }
      .site-side   { grid-area: side; }
      .site-main   { grid-area: main; }
      .site-footer { grid-area: footer; }
    </style>
  </head>
  <body>
    <div class="page">
      <header class="site-header">Riverside</header>
      <aside class="site-side">Routes</aside>
      <main class="site-main">Hire a bike by the hour.</main>
      <footer class="site-footer">© 2026</footer>
    </div>
  </body>
</html>`,
              hints: [
                'Each child needs grid-area naming the area it belongs to.',
                'The area names are the words inside the quoted rows.',
                '30% + 70% + a 1rem gap is more than 100% — use 12rem 1fr instead.',
              ],
              requirements: [
                cssIs('.site-header', 'grid-area', 'header', 'The header is placed in its area'),
                cssIs('.site-side', 'grid-area', 'side', 'The sidebar is placed in its area'),
                cssIs('.site-main', 'grid-area', 'main', 'The main region is placed in its area'),
                cssIs('.site-footer', 'grid-area', 'footer', 'The footer is placed in its area'),
                cssMatches('.page', 'grid-template-columns', '12rem\\s+1fr', 'Columns are a fixed track and a fr track'),
              ],
              difficulty: 4,
              xp: 60,
              skill: 'grid',
            },
          ],
          quiz: [
            {
              slug: 'q-css-auto-fit',
              prompt: 'What does `auto-fit` do that a fixed column count does not?',
              explanation: 'It creates as many tracks as will fit in the available space, and collapses empty ones.',
              options: [
                { label: 'Chooses the number of columns from the space available', correct: true },
                { label: 'Makes every column the same fixed width' },
                { label: 'Adds a media query automatically' },
                { label: 'Prevents the grid from wrapping' },
              ],
              skill: 'grid',
            },
            {
              slug: 'q-css-auto-fit-vs-fill',
              prompt: 'Three cards in a container wide enough for five. What differs between `auto-fit` and `auto-fill`?',
              explanation:
                '`auto-fill` keeps the two empty tracks so the cards stay narrow; `auto-fit` collapses them so the cards stretch.',
              options: [
                { label: '`auto-fill` leaves empty tracks; `auto-fit` collapses them', correct: true },
                { label: 'They behave identically' },
                { label: '`auto-fit` creates more columns' },
                { label: '`auto-fill` only works with fixed widths' },
              ],
              skill: 'grid',
            },
            {
              slug: 'q-css-grid-vs-flex',
              prompt: 'When is grid the better choice over flexbox?',
              explanation: 'When you need rows and columns aligned at once — two dimensions rather than one.',
              options: [
                { label: 'When the layout is two-dimensional', correct: true },
                { label: 'Whenever there is more than one child' },
                { label: 'Only for full-page layouts' },
                { label: 'When you need a gap' },
              ],
              skill: 'grid',
            },
          ],
        },
        {
          slug: 'css-grid-milestone',
          title: 'Milestone: lay out a whole page',
          subtitle: 'Header, sidebar, content, footer — plus a responsive card grid inside it',
          summary: 'The two grid techniques together, in the shape a real site actually uses.',
          objectives: [
            'Build a page shell with named areas',
            'Nest a responsive card grid inside it',
            'Choose grid or flexbox deliberately',
          ],
          estimatedMinutes: 20,
          skill: 'grid',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Assemble a page-level grid',
              'Nest an intrinsically responsive grid',
              'Justify each layout choice',
            ]),
            code(
              `A page shell, at full size and narrowed:

  grid-template-areas:            grid-template-areas:
    "header header"                 "header"
    "side   main"                   "main"
    "footer footer";                "side"
  grid-template-columns:          "footer";
    12rem 1fr;                    grid-template-columns: 1fr;

Reordering a layout means redrawing the picture,
not renumbering a set of line references.`,
              'Why named areas are worth it',
              'text',
            ),
            demo('A whole page, assembled', 'A named-area shell containing an auto-fit card grid.', [
              {
                label: 'The finished shape',
                code: '<style>\n  .page { display: grid; grid-template-areas: "header header" "side main" "footer footer"; grid-template-columns: 8rem 1fr; gap: 0.5rem; }\n  .page > * { background: #eef; padding: 0.5rem; }\n  .h { grid-area: header } .s { grid-area: side } .m { grid-area: main } .f { grid-area: footer }\n  .cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(6rem, 1fr)); gap: 0.5rem; }\n  .cards > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class="page"><div class="h">Header</div><div class="s">Side</div><div class="m"><div class="cards"><div>A</div><div>B</div><div>C</div></div></div><div class="f">Footer</div></div>',
                note: 'Two grids: the page shell places the regions, and the card grid inside main chooses its own column count from the space main gave it.',
              },
            ]),
            recall(
              'From memory: what does each of these do?',
              [
                '`grid-template-columns: repeat(3, 1fr)` — three equal columns sharing the leftover space.',
                '`minmax(16rem, 1fr)` — a track at least 16rem and at most a fair share of what is left.',
                '`repeat(auto-fit, …)` — as many tracks as fit, with empty ones collapsed.',
                '`grid-template-areas` — draws the layout as named rows; each item claims one with `grid-area`.',
                '`gap` — space between tracks, and unlike margins it never adds space at the outer edge.',
              ],
            ),
            recap(
              [
                'A page shell in named areas is readable and easy to rearrange.',
                'Grids nest — the outer one places regions, the inner one lays out cards.',
                'One dimension is flexbox; two is grid.',
              ],
              'Next: responsive design and container queries.',
            ),
            activeRecap(
              ['Why nest a grid inside a grid area rather than declaring every card in the page grid?'],
              [
                'Because they answer different questions. The page grid decides where the regions go; the card grid decides how many columns fit inside whatever width `main` ended up with. Putting the cards in the page grid would couple them to the page\'s column definition, so the component could not be moved into a sidebar or a modal without being rewritten.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-grid-milestone-challenge',
              kind: 'challenge',
              title: 'Build the page shell and the card grid',
              brief:
                'Make `.page` a grid using the three named rows `header` / `side main` / `footer`, with columns `12rem 1fr` and a `1rem` gap. Give each region its `grid-area`. Then make `.cards` inside main a responsive grid of `minmax(12rem, 1fr)` columns with `auto-fit` and a `1rem` gap.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Page</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .page > * { background: #eef; padding: 1rem; }
      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="page">
      <header class="site-header">Riverside</header>
      <aside class="site-side">Routes</aside>
      <main class="site-main">
        <div class="cards">
          <div>Sourdough</div>
          <div>Rye</div>
          <div>Seeded</div>
        </div>
      </main>
      <footer class="site-footer">© 2026</footer>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Page</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .page {
        display: grid;
        grid-template-areas:
          "header header"
          "side main"
          "footer footer";
        grid-template-columns: 12rem 1fr;
        gap: 1rem;
      }
      .page > * { background: #eef; padding: 1rem; }

      .site-header { grid-area: header; }
      .site-side   { grid-area: side; }
      .site-main   { grid-area: main; }
      .site-footer { grid-area: footer; }

      .cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(12rem, 1fr));
        gap: 1rem;
      }
      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="page">
      <header class="site-header">Riverside</header>
      <aside class="site-side">Routes</aside>
      <main class="site-main">
        <div class="cards">
          <div>Sourdough</div>
          <div>Rye</div>
          <div>Seeded</div>
        </div>
      </main>
      <footer class="site-footer">© 2026</footer>
    </div>
  </body>
</html>`,
              hints: [
                'The area names in the quoted rows must match the grid-area values exactly.',
                'The header and footer span both columns, which is why their names repeat.',
                'The inner card grid is a separate, independent grid.',
              ],
              requirements: [
                cssIs('.page', 'display', 'grid', 'The page is a grid'),
                cssMatches('.page', 'grid-template-columns', '12rem\\s+1fr', 'The page columns are 12rem and 1fr'),
                cssIs('.site-header', 'grid-area', 'header', 'The header claims its area'),
                cssIs('.site-main', 'grid-area', 'main', 'Main claims its area'),
                cssIs('.site-footer', 'grid-area', 'footer', 'The footer claims its area'),
                cssIs('.cards', 'display', 'grid', 'The card row is its own grid'),
                cssMatches(
                  '.cards',
                  'grid-template-columns',
                  'repeat\\(auto-fit,\\s*minmax\\(12rem,\\s*1fr\\)\\)',
                  'The card grid is intrinsically responsive',
                ),
              ],
              difficulty: 4,
              xp: 75,
              skill: 'grid',
            },
          ],
          quiz: [
            {
              slug: 'q-css-area-span',
              prompt: 'In `"header header"`, why is the name repeated?',
              explanation: 'Repeating a name across cells makes that area span those columns.',
              options: [
                { label: 'To make the area span both columns', correct: true },
                { label: 'To create two separate headers' },
                { label: 'It is a syntax requirement of every row' },
                { label: 'To double its width relative to others' },
              ],
              skill: 'grid',
            },
            {
              slug: 'q-css-nested-grid-why',
              prompt: 'Why nest a card grid inside a page grid rather than using one grid for everything?',
              explanation:
                'The card component then sizes itself from whatever width its container has, so it can be reused anywhere.',
              options: [
                { label: 'So the cards respond to their container, not the page definition', correct: true },
                { label: 'Because grids cannot have more than four children' },
                { label: 'Because named areas do not allow more than one row' },
                { label: 'It renders faster' },
              ],
              skill: 'grid',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'css-level-5-milestone',
    kind: 'milestone',
    title: 'Level 5 milestone: Grid',
    description: 'Six questions on tracks, areas and responsive grids. Pass mark 75%.',
    passScore: 0.75,
    xp: 180,
    questions: [
      {
        slug: 'a-css-5-fr-leftover',
        prompt: '`grid-template-columns: 200px 1fr` in a 1000px container with no gap. How wide is the `1fr`?',
        explanation: '800px — `fr` takes what is left after fixed tracks and gaps.',
        options: [
          { label: '800px', correct: true },
          { label: '1000px' },
          { label: '500px' },
          { label: '200px' },
        ],
        skill: 'grid',
      },
      {
        slug: 'a-css-5-repeat',
        prompt: 'What is `repeat(3, 1fr)` equivalent to?',
        explanation: 'Writing `1fr 1fr 1fr`.',
        options: [
          { label: '`1fr 1fr 1fr`', correct: true },
          { label: '`3fr`' },
          { label: '`33% 33% 33%`' },
          { label: '`minmax(3, 1fr)`' },
        ],
        skill: 'grid',
      },
      {
        slug: 'a-css-5-implicit',
        prompt: 'What are implicit tracks?',
        explanation: 'Rows or columns grid creates automatically for items beyond the ones you declared.',
        options: [
          { label: 'Tracks grid creates automatically for extra items', correct: true },
          { label: 'Tracks declared with `repeat()`' },
          { label: 'Tracks that are hidden' },
          { label: 'Tracks sized with `fr`' },
        ],
        skill: 'grid',
      },
      {
        slug: 'a-css-5-minmax',
        prompt: 'What does `minmax(16rem, 1fr)` mean?',
        explanation: 'At least 16rem, at most a fair share of the leftover space.',
        options: [
          { label: 'At least 16rem, at most a share of what is left', correct: true },
          { label: 'Exactly 16rem' },
          { label: 'Between 16rem and 1rem' },
          { label: 'A minimum of one fraction unit' },
        ],
        skill: 'grid',
      },
      {
        slug: 'a-css-5-empty-cell',
        prompt: 'What does a full stop mean inside `grid-template-areas`?',
        explanation: 'A deliberately empty cell.',
        options: [
          { label: 'A deliberately empty cell', correct: true },
          { label: 'A class selector' },
          { label: 'The end of a row' },
          { label: 'A track sized by content' },
        ],
        skill: 'grid',
      },
      {
        slug: 'a-css-5-container-vs-viewport',
        prompt: 'Why does an `auto-fit` grid behave correctly inside a sidebar where a media query would not?',
        explanation:
          'It responds to the container it is in; a media query only knows the viewport width.',
        options: [
          { label: 'It responds to the container, not the viewport', correct: true },
          { label: 'Media queries do not work in sidebars' },
          { label: 'It has higher specificity' },
          { label: 'It disables wrapping' },
        ],
        skill: 'grid',
      },
    ],
  },
};
