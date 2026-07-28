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
 * CSS Level 4 — Flexbox, taught until fluent.
 *
 * The handover asks for Flexbox and Grid "taught until fluent" rather than
 * surveyed. Fluency here means the learner can answer *which axis* without
 * thinking, because every flexbox confusion reduces to having the axes the
 * wrong way round.
 */
export const CSS_LEVEL_04: LevelSpec = {
  slug: 'css-flexbox',
  title: 'Flexbox',
  subtitle: 'One dimension, two axes, and the properties that follow from them',
  summary:
    'Flexbox is small: a container, a direction, and rules for distributing space. Almost every difficulty with it is really a question of which axis you are talking about.',
  outcome: 'You can build any one-dimensional layout and explain which axis each property acts on.',
  accent: 'violet',
  modules: [
    {
      slug: 'css-flex',
      title: 'Flexbox',
      summary: 'Axes, alignment, and the flex shorthand that decides how space is shared.',
      estimatedMinutes: 60,
      prerequisites: ['css-flow'],
      skills: [{ slug: 'flexbox', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'css-flex-axes',
          title: 'The two axes',
          subtitle: 'Why `justify-content` sometimes moves things vertically',
          summary:
            'One property decides what every other flexbox property means. Get it clear once and the rest stops being guesswork.',
          objectives: [
            'Identify the main and cross axis for any flex container',
            'Choose between `justify-content` and `align-items` correctly',
            'Explain why the axes swap with `flex-direction`',
          ],
          estimatedMinutes: 16,
          skill: 'flexbox',
          blocks: [
            pretest(
              'A flex container has `flex-direction: column`. Which property now centres its children **vertically**?',
              [
                '`justify-content`',
                '`align-items`',
                '`text-align`',
                '`vertical-align`',
              ],
              '`justify-content`. This is the single most useful fact in flexbox and the one that trips up nearly everyone. `justify-content` always works along the **main** axis and `align-items` always works along the **cross** axis — and `flex-direction: column` makes the main axis vertical. The properties did not change meaning; the axes rotated underneath them.',
            ),
            objectives([
              'Name the main and cross axis given a `flex-direction`',
              'Apply `justify-content` and `align-items` to the correct axis',
              'Predict what happens when the direction changes',
            ]),
            prose(
              'Flexbox lays out children along one axis. Everything follows from which axis that is — which is why the first thing to establish about any flex container is its direction.',
            ),
            term(
              'Main axis',
              'The direction children are laid out in, set by `flex-direction`. `row` (the default) means horizontal; `column` means vertical.',
            ),
            term(
              'Cross axis',
              'The axis at right angles to the main axis. It is whatever the main axis is not.',
            ),
            code(
              `flex-direction: row      main = horizontal, cross = vertical
flex-direction: column   main = vertical,   cross = horizontal

justify-content   always the MAIN axis
align-items       always the CROSS axis
align-content     the cross axis, when lines have wrapped
gap               space between items, both axes

So: to centre a box in the middle of its container,
  display: flex;
  justify-content: center;   /* main  */
  align-items: center;       /* cross */
and it works whichever direction you chose.`,
              'The whole model on one screen',
              'text',
            ),
            demo('The same two properties, two directions', 'Identical CSS apart from `flex-direction`.', [
              {
                label: 'row',
                code: '<style>\n  .box { display: flex; flex-direction: row; justify-content: center; align-items: flex-start; gap: 0.5rem; height: 8rem; border: 1px solid teal; }\n  .box > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class="box"><div>A</div><div>B</div><div>C</div></div>',
                note: 'Main axis is horizontal, so `justify-content: center` groups them across the middle. `align-items: flex-start` pins them to the top.',
              },
              {
                label: 'column',
                code: '<style>\n  .box { display: flex; flex-direction: column; justify-content: center; align-items: flex-start; gap: 0.5rem; height: 8rem; border: 1px solid teal; }\n  .box > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class="box"><div>A</div><div>B</div><div>C</div></div>',
                note: 'Identical declarations. The axes rotated, so `justify-content` now centres vertically and `align-items` pins them left.',
              },
              {
                label: 'Centred both ways',
                code: '<style>\n  .box { display: flex; justify-content: center; align-items: center; height: 8rem; border: 1px solid teal; }\n  .box > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class="box"><div>Centred</div></div>',
                note: 'The two-line answer to a problem that took the whole industry a decade to solve properly.',
              },
            ]),
            callout(
              'tip',
              'Use `gap`, not margins',
              '`gap` puts space *between* items and none on the outside, so you never need the `:last-child { margin-right: 0 }` that margin-based spacing always ends up needing. It works in flexbox and grid alike, and margins do not collapse inside a flex container anyway.',
            ),
            predictCheck(
              `<style>
  .row { display: flex; }
  .row > div { background: #cde; padding: 0.5rem; }
</style>
<div class="row">
  <div>Short</div>
  <div>A much longer piece of content here</div>
</div>`,
              'Two children with very different amounts of content, in a plain flex row with no other properties. Before you check: are the two boxes the same height, or does each fit its own content?',
              'They are the **same height** — both stretch to match the taller one. `align-items` defaults to `stretch`, so children fill the cross axis unless told otherwise. This is why flexbox gives equal-height columns for free, which was genuinely hard before it existed. If you want each box to fit its own content instead, that is `align-items: flex-start`.',
            ),
            selfExplain(
              'A colleague says they can never remember whether to use `justify-content` or `align-items`, so they try one and then the other. Write them a rule they can actually hold in their head.',
              'The rule is: `justify-content` is always the main axis, `align-items` is always the cross axis — and the main axis is whichever way `flex-direction` points. So the question is never "which property centres vertically", because that has no fixed answer; it is "which axis am I talking about, and which way is my main axis pointing". Once the direction is established the property follows without a guess. Trying one and then the other works often enough to feel fine and stops working the moment the direction changes, which is why it never becomes fluent.',
            ),
            checklist('For any flex container, establish in this order', [
              'What is the `flex-direction`? That fixes the main axis.',
              'The cross axis is the other one.',
              '`justify-content` distributes along the main axis.',
              '`align-items` aligns along the cross axis.',
              '`gap` spaces between items on both.',
            ]),
            recap(
              [
                '`flex-direction` decides the main axis; the cross axis is the other one.',
                '`justify-content` always acts on the main axis, `align-items` on the cross axis.',
                'Children stretch on the cross axis by default, giving equal heights for free.',
                '`gap` spaces items without the last-child margin problem.',
              ],
              'Next: how space is shared out.',
            ),
            activeRecap(
              [
                'With `flex-direction: column`, which property centres children vertically?',
                'Why do two flex children end up the same height by default?',
                'Why prefer `gap` over margins between flex items?',
              ],
              [
                '`justify-content`, because column makes the main axis vertical and `justify-content` always acts on the main axis.',
                'Because `align-items` defaults to `stretch`, so children fill the cross axis. Setting `align-items: flex-start` makes each fit its own content instead.',
                '`gap` puts space only *between* items, so there is no trailing space to undo with a `:last-child` rule — and margins do not collapse inside a flex container anyway.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-flex-centre-guided',
              kind: 'guided',
              title: 'Centre a box, both ways',
              brief:
                'Make `.frame` a flex container 12rem tall and centre its single child both horizontally and vertically.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flexbox</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .frame { height: 12rem; border: 1px solid teal; }
      .frame > div { background: #cde; padding: 0.5rem; }
    </style>
  </head>
  <body>
    <div class="frame"><div>Centred</div></div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flexbox</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .frame {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 12rem;
        border: 1px solid teal;
      }
      .frame > div { background: #cde; padding: 0.5rem; }
    </style>
  </head>
  <body>
    <div class="frame"><div>Centred</div></div>
  </body>
</html>`,
              hints: [
                'The container needs display: flex before anything else applies.',
                'justify-content works on the main axis, which is horizontal by default.',
                'align-items works on the cross axis, which is vertical by default.',
              ],
              requirements: [
                cssIs('.frame', 'display', 'flex', 'The frame is a flex container'),
                cssIs('.frame', 'justify-content', 'center', 'Children are centred on the main axis'),
                cssIs('.frame', 'align-items', 'center', 'Children are centred on the cross axis'),
                cssIs('.frame', 'height', '12rem', 'The frame is still 12rem tall'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'flexbox',
            },
            {
              slug: 'css-flex-axis-debug',
              kind: 'debug',
              title: 'The axes are the wrong way round',
              brief:
                'This column of cards should be centred horizontally and start at the top. The author swapped the two alignment properties. Fix it, keeping `flex-direction: column`, and use `gap` of `1rem` rather than margins.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flexbox</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .stack {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: flex-start;
        height: 20rem;
        border: 1px solid teal;
      }
      .stack > div { background: #cde; padding: 0.5rem; margin-bottom: 1rem; }
    </style>
  </head>
  <body>
    <div class="stack">
      <div>Sourdough</div>
      <div>Rye</div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flexbox</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .stack {
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
        gap: 1rem;
        height: 20rem;
        border: 1px solid teal;
      }
      .stack > div { background: #cde; padding: 0.5rem; }
    </style>
  </head>
  <body>
    <div class="stack">
      <div>Sourdough</div>
      <div>Rye</div>
    </div>
  </body>
</html>`,
              hints: [
                'With column, the main axis is vertical — so justify-content controls top-to-bottom.',
                '"Start at the top" is justify-content: flex-start.',
                '"Centred horizontally" on a column is align-items: center.',
                'Replace the child margin-bottom with gap on the container.',
              ],
              requirements: [
                cssIs('.stack', 'flex-direction', 'column', 'The direction is unchanged'),
                cssIs('.stack', 'justify-content', 'flex-start', 'Items start at the top of the main axis'),
                cssIs('.stack', 'align-items', 'center', 'Items are centred on the cross axis'),
                cssIs('.stack', 'gap', '1rem', 'Spacing uses gap'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'flexbox',
            },
          ],
          quiz: [
            {
              slug: 'q-css-justify-axis',
              prompt: 'Which axis does `justify-content` act on?',
              explanation: 'Always the main axis, whichever way `flex-direction` points it.',
              options: [
                { label: 'The main axis, always', correct: true },
                { label: 'The horizontal axis, always' },
                { label: 'The cross axis' },
                { label: 'Whichever axis is longer' },
              ],
              skill: 'flexbox',
            },
            {
              slug: 'q-css-align-items-default',
              prompt: 'What is the default value of `align-items`?',
              explanation: '`stretch`, which is why flex children end up the same height by default.',
              options: [
                { label: '`stretch`', correct: true },
                { label: '`center`' },
                { label: '`flex-start`' },
                { label: '`baseline`' },
              ],
              skill: 'flexbox',
            },
            {
              slug: 'q-css-gap-benefit',
              prompt: 'What does `gap` do that margins between items do not?',
              explanation: 'It puts space only between items, with none on the outside — so no last-child correction is needed.',
              options: [
                { label: 'Adds space only between items, never on the outside', correct: true },
                { label: 'Works only in grid' },
                { label: 'Collapses like vertical margins' },
                { label: 'Applies to the container padding' },
              ],
              skill: 'flexbox',
            },
          ],
        },
        {
          slug: 'css-flex-sizing',
          title: 'Sharing out space',
          subtitle: '`flex-grow`, `flex-shrink`, `flex-basis` — and the shorthand you should actually write',
          summary:
            'Three properties decide how leftover space is divided and how overflow is absorbed. One shorthand covers almost every real case.',
          objectives: [
            'Explain what `flex: 1` expands to',
            'Choose a `flex-basis` deliberately',
            'Use `flex-wrap` to build a responsive row with no media query',
          ],
          estimatedMinutes: 17,
          skill: 'flexbox',
          blocks: [
            pretest(
              'Three flex children all have `flex: 1`, but one contains far more text than the others. Are they the same width?',
              [
                'Yes — `flex: 1` sets `flex-basis: 0`, so content size is ignored',
                'No — the one with more content is wider',
                'Only if you also set `width`',
                'Only in a row, not a column',
              ],
              'Yes, they are equal. `flex: 1` is shorthand for `flex: 1 1 0%` — and that `0%` basis is the important part: it tells flexbox to start from zero rather than from the content size, so all the space is distributed equally. The near-identical `flex: auto` means `flex: 1 1 auto`, which *does* start from content size and gives unequal widths. That one character is the difference between "equal columns" and "proportional columns", and it explains most surprises here.',
            ),
            objectives([
              'Expand the `flex` shorthand correctly',
              'Choose between `flex: 1` and `flex: auto`',
              'Build a wrapping row that needs no breakpoint',
            ]),
            code(
              `flex: <grow> <shrink> <basis>

flex: 1        =  1 1 0%     equal shares, ignore content size
flex: auto     =  1 1 auto   share space, but start from content
flex: none     =  0 0 auto   do not grow, do not shrink
flex: 0 1 auto              the default: shrink if needed, never grow

grow    how much of the LEFTOVER space this item takes
shrink  how much this item gives up when there is not enough
basis   the size to start from before growing or shrinking`,
              'The flex shorthand',
              'text',
            ),
            workedExample(
              'A sidebar that stays put and a main column that fills',
              'The most common two-column layout in existence, and why each value is what it is.',
              [
                {
                  title: 'Make the container a row',
                  code: `.layout { display: flex; gap: 1rem; }`,
                  reasoning:
                    'Row is the default direction, so the main axis is horizontal and space will be shared left to right. `gap` handles the space between without touching either child.',
                },
                {
                  title: 'Fix the sidebar',
                  code: `.sidebar { flex: 0 0 16rem; }`,
                  reasoning:
                    'Grow 0 so it never takes leftover space; shrink 0 so it never gives any up; basis 16rem so that is its size. This is the honest way to say "exactly this wide, always" — more reliable than `width` alone, because `width` would still allow shrinking.',
                },
                {
                  title: 'Let the main column take the rest',
                  code: `.main { flex: 1; }`,
                  reasoning:
                    'Grow 1 from a basis of 0 means "take all the leftover space". It does not need to know how wide the sidebar is, which is what makes the layout survive the sidebar changing.',
                },
                {
                  title: 'Guard against the content that will not fit',
                  code: `.main { flex: 1; min-width: 0; }`,
                  reasoning:
                    'The line nobody expects. A flex item will not shrink below its content\'s minimum size by default, so one long unbroken string — a URL, a code sample — pushes the whole layout wider than its container. `min-width: 0` allows it to shrink properly. This is the single most common flexbox overflow bug.',
                },
              ],
            ),
            demo('The same row, three flex values', 'Three children, different amounts of text.', [
              {
                label: 'flex: 1 — equal',
                code: '<style>\n  .row { display: flex; gap: 0.5rem; }\n  .row > div { flex: 1; background: #cde; padding: 0.5rem; }\n</style>\n<div class="row"><div>A</div><div>Rather more content here</div><div>B</div></div>',
                note: 'Basis of 0 means content size is ignored entirely. Three equal columns.',
              },
              {
                label: 'flex: auto — proportional',
                code: '<style>\n  .row { display: flex; gap: 0.5rem; }\n  .row > div { flex: auto; background: #cde; padding: 0.5rem; }\n</style>\n<div class="row"><div>A</div><div>Rather more content here</div><div>B</div></div>',
                note: 'Basis of auto starts from content size, so the wordy one keeps its head start and stays wider.',
              },
              {
                label: 'Fixed plus fill',
                code: '<style>\n  .row { display: flex; gap: 0.5rem; }\n  .side { flex: 0 0 8rem; background: #dcd; padding: 0.5rem; }\n  .main { flex: 1; min-width: 0; background: #cde; padding: 0.5rem; }\n</style>\n<div class="row"><div class="side">Sidebar</div><div class="main">Main content takes whatever is left.</div></div>',
                note: 'The sidebar is exactly 8rem and refuses to shrink; the main column absorbs everything else.',
              },
            ]),
            term(
              '`flex-wrap`',
              'Whether items may move onto a new line when they do not fit. `nowrap` is the default and is why a flex row can overflow.',
            ),
            callout(
              'tip',
              'A responsive card row with no media query',
              'Give the container `flex-wrap: wrap` and each card `flex: 1 1 16rem`. Each card wants to be 16rem, will grow to fill leftover space, and will wrap to a new line when there is not room for another. The number of columns changes with the available width, and you have not written a single breakpoint — which means it also works inside a narrow sidebar, where a viewport-based media query would be wrong.',
            ),
            detail(
              'Why `min-width: 0` keeps appearing',
              'A flex item\'s default minimum size is `auto`, which means "at least as big as my content needs". For most content that is sensible. For a long URL, a `<pre>` block, or a table, it means the item refuses to shrink and pushes the layout wider than the screen. `min-width: 0` on a row item — or `min-height: 0` on a column item — opts out of that floor. If a flex layout overflows and you cannot see why, this is the first thing to try.',
            ),
            recap(
              [
                '`flex: 1` is `1 1 0%` — equal shares, ignoring content size.',
                '`flex: auto` is `1 1 auto` — proportional, starting from content size.',
                '`flex: 0 0 <size>` is how you say "exactly this wide, always".',
                '`flex-wrap: wrap` with a basis gives responsive columns without a media query.',
              ],
              'Next: the Level 4 milestone.',
            ),
            activeRecap(
              [
                'What does `flex: 1` expand to, and why does the basis matter?',
                'How do you make an item exactly 16rem and refuse to shrink?',
                'What does `min-width: 0` fix, and why is it needed?',
              ],
              [
                '`flex: 1 1 0%`. The `0%` basis means the item starts from zero rather than its content size, so leftover space is shared equally and all items end up the same width.',
                '`flex: 0 0 16rem` — never grow, never shrink, start at 16rem.',
                'A flex item will not shrink below its content\'s minimum size by default, so one long unbroken string pushes the layout wider than its container. `min-width: 0` removes that floor.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-flex-sidebar-guided',
              kind: 'guided',
              title: 'A fixed sidebar and a filling main column',
              brief:
                'Make `.layout` a flex row with a `1rem` gap. The `.sidebar` must be exactly `16rem` and never grow or shrink. The `.main` column takes all remaining space and can shrink below its content when it has to.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flex layout</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .layout { border: 1px solid teal; }
      .sidebar { background: #dcd; padding: 1rem; }
      .main { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="layout">
      <div class="sidebar">Routes</div>
      <div class="main">Hire a bike by the hour, the day or the week.</div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flex layout</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .layout { display: flex; gap: 1rem; border: 1px solid teal; }
      .sidebar { flex: 0 0 16rem; background: #dcd; padding: 1rem; }
      .main { flex: 1; min-width: 0; background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="layout">
      <div class="sidebar">Routes</div>
      <div class="main">Hire a bike by the hour, the day or the week.</div>
    </div>
  </body>
</html>`,
              hints: [
                'The container needs display: flex and gap: 1rem.',
                '"Exactly this wide, never changes" is flex: 0 0 16rem.',
                '"Take everything else" is flex: 1.',
                'Add min-width: 0 so long content cannot push the layout wider.',
              ],
              requirements: [
                cssIs('.layout', 'display', 'flex', 'The layout is a flex row'),
                cssIs('.layout', 'gap', '1rem', 'There is a 1rem gap'),
                cssMatches('.sidebar', 'flex', '0\\s+0\\s+16rem', 'The sidebar is fixed at 16rem'),
                cssMatches('.main', 'flex', '^1$|1\\s+1\\s+0', 'The main column fills the rest'),
                cssIs('.main', 'min-width', '0', 'The main column can shrink below its content'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'flexbox',
            },
            {
              slug: 'css-flex-wrap-debug',
              kind: 'debug',
              title: 'A card row that overflows',
              brief:
                'These cards run off the side of the page instead of wrapping. Add wrapping, give each card a `flex` of `1 1 16rem` so it has a sensible target width, and use a `1rem` gap instead of the child margins.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Cards</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards { display: flex; border: 1px solid teal; }
      .cards > div {
        width: 16rem;
        margin-right: 1rem;
        background: #cde;
        padding: 1rem;
      }
    </style>
  </head>
  <body>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
      <div>Focaccia</div>
      <div>Brioche</div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Cards</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards { display: flex; flex-wrap: wrap; gap: 1rem; border: 1px solid teal; }
      .cards > div {
        flex: 1 1 16rem;
        background: #cde;
        padding: 1rem;
      }
    </style>
  </head>
  <body>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
      <div>Focaccia</div>
      <div>Brioche</div>
    </div>
  </body>
</html>`,
              hints: [
                'flex-wrap defaults to nowrap, which is why the row overflows.',
                'Replace the fixed width with flex: 1 1 16rem — a target size that can flex.',
                'Swap the child margin-right for gap on the container.',
              ],
              requirements: [
                cssIs('.cards', 'flex-wrap', 'wrap', 'The row wraps'),
                cssIs('.cards', 'gap', '1rem', 'Spacing uses gap'),
                cssMatches('.cards > div', 'flex', '1\\s+1\\s+16rem', 'Cards have a flexible 16rem basis'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'flexbox',
            },
          ],
          quiz: [
            {
              slug: 'q-css-flex-1-expands',
              prompt: 'What does `flex: 1` expand to?',
              explanation: '`flex: 1 1 0%` — grow, shrink, and start from a basis of zero.',
              options: [
                { label: '`1 1 0%`', correct: true },
                { label: '`1 1 auto`' },
                { label: '`1 0 auto`' },
                { label: '`0 1 auto`' },
              ],
              skill: 'flexbox',
            },
            {
              slug: 'q-css-flex-auto-vs-1',
              prompt: 'Why do `flex: 1` and `flex: auto` produce different widths?',
              explanation:
                'Their bases differ: `1` starts from `0%` so content is ignored; `auto` starts from the content size.',
              options: [
                { label: '`flex: 1` starts from a 0 basis; `flex: auto` starts from content size', correct: true },
                { label: '`flex: auto` does not allow growing' },
                { label: 'They are identical' },
                { label: '`flex: 1` only works in a column' },
              ],
              skill: 'flexbox',
            },
            {
              slug: 'q-css-min-width-zero',
              prompt: 'A flex row overflows because one item contains a very long URL. What usually fixes it?',
              explanation:
                'A flex item will not shrink below its content minimum by default. `min-width: 0` removes that floor.',
              options: [
                { label: '`min-width: 0` on the flex item', correct: true },
                { label: '`flex-wrap: nowrap`' },
                { label: '`align-items: stretch`' },
                { label: 'Increasing the gap' },
              ],
              skill: 'flexbox',
            },
          ],
        },
        {
          slug: 'css-flex-milestone',
          title: 'Milestone: build a page header',
          subtitle: 'Logo left, navigation right, everything aligned',
          summary:
            'The layout every site needs, built with flexbox and no positioning tricks.',
          objectives: [
            'Build a two-part header with flexbox',
            'Space and align items on both axes',
            'Make a card row wrap without a media query',
          ],
          estimatedMinutes: 20,
          skill: 'flexbox',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Assemble a real header with flexbox',
              'Use `space-between` and `align-items` correctly',
              'Build a wrapping card row',
            ]),
            code(
              `justify-content values, on the main axis:

flex-start      packed at the start
flex-end        packed at the end
center          packed in the middle
space-between   first at the start, last at the end,
                equal space between
space-around    equal space around each item
space-evenly    equal space everywhere, including the ends`,
              'Distributing along the main axis',
              'text',
            ),
            demo('A header, three ways of distributing it', 'Same markup, three `justify-content` values.', [
              {
                label: 'space-between',
                code: '<style>\n  .header { display: flex; justify-content: space-between; align-items: center; border: 1px solid teal; padding: 1rem; }\n  nav { display: flex; gap: 1rem; }\n</style>\n<div class="header"><strong>Riverside</strong><nav><a href="#">Home</a><a href="#">Menu</a></nav></div>',
                note: 'Logo pinned left, navigation pinned right. This is the header layout almost every site uses.',
              },
              {
                label: 'center',
                code: '<style>\n  .header { display: flex; justify-content: center; align-items: center; gap: 2rem; border: 1px solid teal; padding: 1rem; }\n  nav { display: flex; gap: 1rem; }\n</style>\n<div class="header"><strong>Riverside</strong><nav><a href="#">Home</a><a href="#">Menu</a></nav></div>',
                note: 'Both groups together in the middle. Correct for a centred brand, wrong if you wanted them apart.',
              },
              {
                label: 'No alignment',
                code: '<style>\n  .header { display: flex; justify-content: space-between; align-items: flex-start; border: 1px solid crimson; padding: 1rem; }\n  nav { display: flex; gap: 1rem; }\n  strong { font-size: 2rem; }\n</style>\n<div class="header"><strong>Riverside</strong><nav><a href="#">Home</a><a href="#">Menu</a></nav></div>',
                note: 'With items of different heights and no cross-axis alignment, the links sit at the top rather than on the logo\'s centre line.',
              },
            ]),
            recall(
              'From memory: which axis does each of these act on, and what does each `flex` shorthand mean?',
              [
                '`justify-content` — the main axis, whichever way `flex-direction` points it.',
                '`align-items` — the cross axis, at right angles to the main axis.',
                '`flex: 1` — `1 1 0%`: equal shares, content size ignored.',
                '`flex: auto` — `1 1 auto`: proportional, starting from content size.',
                '`flex: 0 0 16rem` — exactly 16rem, never grows, never shrinks.',
                '`min-width: 0` — lets an item shrink below its content minimum, fixing most overflow.',
              ],
            ),
            recap(
              [
                '`space-between` with `align-items: center` is the standard header.',
                '`flex: 1 1 <basis>` with `flex-wrap: wrap` gives responsive columns with no breakpoint.',
                'Nested flex containers are normal — a header is usually a flex row containing a flex nav.',
              ],
              'Next: Grid.',
            ),
            activeRecap(
              ['Why is `flex-wrap: wrap` with a basis better than a media query for a card row?'],
              [
                'Because it responds to the space actually available rather than to the viewport width. The same component then works in a full-width page, in a narrow sidebar, and inside another layout — where a viewport-based breakpoint would give the wrong answer in at least two of those. It is also less code and has no numbers to keep in sync.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-flex-milestone-challenge',
              kind: 'challenge',
              title: 'Build the header and a wrapping card row',
              brief:
                'Two jobs. Make `.header` a flex row with the logo pinned left, the nav pinned right, and both vertically centred. Make `.nav` itself a flex row with a `1rem` gap. Then make `.cards` a wrapping flex row with a `1rem` gap where each card is `flex: 1 1 16rem`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Header</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .header { border: 1px solid teal; padding: 1rem; }
      .cards { border: 1px solid teal; padding: 1rem; }
      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <header class="header">
      <strong>Riverside</strong>
      <nav class="nav">
        <a href="index.html">Home</a>
        <a href="menu.html">Menu</a>
      </nav>
    </header>
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
    <title>Header</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border: 1px solid teal;
        padding: 1rem;
      }
      .nav { display: flex; gap: 1rem; }

      .cards {
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
        border: 1px solid teal;
        padding: 1rem;
      }
      .cards > div { flex: 1 1 16rem; background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <header class="header">
      <strong>Riverside</strong>
      <nav class="nav">
        <a href="index.html">Home</a>
        <a href="menu.html">Menu</a>
      </nav>
    </header>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
    </div>
  </body>
</html>`,
              hints: [
                'Pinning one item left and one right is justify-content: space-between.',
                'Vertically centring on a row is align-items: center.',
                'The nav is itself a flex container, with gap for the link spacing.',
                'The card row needs flex-wrap: wrap and each card flex: 1 1 16rem.',
              ],
              requirements: [
                cssIs('.header', 'display', 'flex', 'The header is a flex row'),
                cssIs('.header', 'justify-content', 'space-between', 'Logo and nav are pushed apart'),
                cssIs('.header', 'align-items', 'center', 'They are vertically centred'),
                cssIs('.nav', 'display', 'flex', 'The nav is a flex row'),
                cssIs('.nav', 'gap', '1rem', 'The nav links are spaced with gap'),
                cssIs('.cards', 'flex-wrap', 'wrap', 'The card row wraps'),
                cssMatches('.cards > div', 'flex', '1\\s+1\\s+16rem', 'Cards use a flexible 16rem basis'),
              ],
              difficulty: 4,
              xp: 70,
              skill: 'flexbox',
            },
          ],
          quiz: [
            {
              slug: 'q-css-space-between',
              prompt: 'What does `justify-content: space-between` do with two items?',
              explanation: 'Pins the first to the start and the last to the end, with all the space between them.',
              options: [
                { label: 'Pins one to each end', correct: true },
                { label: 'Centres both with equal space around' },
                { label: 'Stacks them vertically' },
                { label: 'Adds equal space including at the ends' },
              ],
              skill: 'flexbox',
            },
            {
              slug: 'q-css-nested-flex',
              prompt: 'Can a flex item itself be a flex container?',
              explanation:
                'Yes, and it is normal — a header is usually a flex row whose nav child is another flex row.',
              options: [
                { label: 'Yes, and it is a common pattern', correct: true },
                { label: 'No, flex containers cannot nest' },
                { label: 'Only if the directions differ' },
                { label: 'Only with `display: inline-flex`' },
              ],
              skill: 'flexbox',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'css-level-4-milestone',
    kind: 'milestone',
    title: 'Level 4 milestone: Flexbox',
    description: 'Six questions on axes, alignment and flexible sizing. Pass mark 75%.',
    passScore: 0.75,
    xp: 180,
    questions: [
      {
        slug: 'a-css-4-axes-swap',
        prompt: 'With `flex-direction: column`, `align-items: center` aligns items how?',
        explanation: 'On the cross axis, which is now horizontal — so it centres them left to right.',
        options: [
          { label: 'Horizontally', correct: true },
          { label: 'Vertically' },
          { label: 'Both ways' },
          { label: 'Not at all' },
        ],
        skill: 'flexbox',
      },
      {
        slug: 'a-css-4-equal-columns',
        prompt: 'Which makes three flex children exactly equal in width regardless of content?',
        explanation: '`flex: 1` uses a basis of 0, so content size is ignored.',
        options: [
          { label: '`flex: 1`', correct: true },
          { label: '`flex: auto`' },
          { label: '`flex: none`' },
          { label: '`align-items: stretch`' },
        ],
        skill: 'flexbox',
      },
      {
        slug: 'a-css-4-fixed-item',
        prompt: 'How do you make a sidebar exactly 16rem and stop it shrinking?',
        explanation: 'Grow 0, shrink 0, basis 16rem.',
        options: [
          { label: '`flex: 0 0 16rem`', correct: true },
          { label: '`flex: 1 1 16rem`' },
          { label: '`width: 16rem`' },
          { label: '`flex-basis: 16rem`' },
        ],
        skill: 'flexbox',
      },
      {
        slug: 'a-css-4-wrap-default',
        prompt: 'What is the default value of `flex-wrap`?',
        explanation: '`nowrap`, which is why a flex row can overflow its container.',
        options: [
          { label: '`nowrap`', correct: true },
          { label: '`wrap`' },
          { label: '`wrap-reverse`' },
          { label: 'It depends on the direction' },
        ],
        skill: 'flexbox',
      },
      {
        slug: 'a-css-4-equal-heights',
        prompt: 'Why do flex children end up the same height without any extra CSS?',
        explanation: '`align-items` defaults to `stretch`, filling the cross axis.',
        options: [
          { label: '`align-items` defaults to `stretch`', correct: true },
          { label: 'Because of `justify-content`' },
          { label: 'Flexbox forces equal heights always' },
          { label: 'Because of `gap`' },
        ],
        skill: 'flexbox',
      },
      {
        slug: 'a-css-4-overflow-cause',
        prompt: 'What is the usual cause of a flex layout overflowing horizontally?',
        explanation:
          'A flex item will not shrink below its content minimum size unless `min-width: 0` allows it.',
        options: [
          { label: 'An item refusing to shrink below its content minimum', correct: true },
          { label: 'A gap that is too large' },
          { label: '`align-items: center`' },
          { label: 'Too many children' },
        ],
        skill: 'flexbox',
      },
    ],
  },
};
