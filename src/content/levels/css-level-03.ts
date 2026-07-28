import {
  activeRecap,
  callout,
  checklist,
  code,
  cssIs,
  cssNotSet,
  cssSet,
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
 * CSS Level 3 — flow, positioning and stacking.
 *
 * Placed before Flexbox and Grid on purpose. Both of those are ways of
 * *overriding* normal flow, and a learner who never understood the default
 * cannot tell whether a layout problem needs a different flex property or
 * simply needs the flex container removing.
 */
export const CSS_LEVEL_03: LevelSpec = {
  slug: 'css-flow-and-position',
  title: 'Flow, Position and Stacking',
  subtitle: 'The layout you get for free, and the four ways of leaving it',
  summary:
    'Before any layout system, there is normal flow. Understanding it — and what `position` and stacking contexts really do — is what stops later layouts feeling like guesswork.',
  outcome:
    'You can predict where an element will sit, and say which of two overlapping elements appears in front and why.',
  accent: 'violet',
  modules: [
    {
      slug: 'css-flow',
      title: 'Normal flow and positioning',
      summary:
        'Block and inline, the display property, the four positioning schemes, and the stacking rules that decide what covers what.',
      estimatedMinutes: 55,
      prerequisites: ['css-boxes'],
      skills: [{ slug: 'layout-flow', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'css-normal-flow',
          title: 'Normal flow',
          subtitle: 'Block, inline, and the layout you already have',
          summary:
            'Every page starts with a layout you did not write. Knowing its rules explains most of what looks like strange behaviour later.',
          objectives: [
            'Explain the difference between block and inline layout',
            'Predict which properties an inline element ignores',
            'Choose a display value deliberately',
          ],
          estimatedMinutes: 15,
          skill: 'layout-flow',
          blocks: [
            pretest(
              'You give a `<span>` a `width` of 300px and 40px of top padding. What actually happens?',
              [
                'The width is ignored, and the padding overlaps the lines above and below',
                'Both apply exactly as written',
                'Both are ignored entirely',
                'The width applies but the padding does not',
              ],
              'The width is ignored and the vertical padding is drawn but does not push anything away — so it overlaps neighbouring lines. Inline elements are sized by their content, and vertical margins and padding on them do not affect line height. This is the commonest reason a `<span>` "refuses" to be sized, and the fix is almost always `display: inline-block` or using a block element in the first place.',
            ),
            objectives([
              'Describe how block and inline boxes are laid out',
              'Name what inline elements ignore',
              'Pick between `block`, `inline`, `inline-block` and `none`',
            ]),
            prose(
              'Normal flow is the layout a browser gives you before you write a single layout rule. Blocks stack down the page; inline content runs along a line and wraps. Almost everything else in CSS layout is a deliberate departure from this.',
            ),
            term(
              'Block box',
              'Takes the full width available and starts on a new line. `<div>`, `<p>`, `<h1>`, `<section>` are block by default.',
            ),
            term(
              'Inline box',
              'Sits within a line of text and is only as wide as its content. `<span>`, `<a>`, `<strong>`, `<em>` are inline by default.',
            ),
            code(
              `display: block          full width, new line, all box properties apply
display: inline         flows in a line, width/height ignored,
                        vertical margin and padding do not push
display: inline-block   flows in a line, but sized like a block
display: none           removed entirely — no box, not in the
                        accessibility tree, not focusable
display: flow-root      a block that contains its own floats`,
              'The display values worth knowing first',
              'text',
            ),
            demo('The same span, three display values', 'Identical markup and identical width declaration.', [
              {
                label: 'inline (the default)',
                code: '<style>\n  .tag { display: inline; width: 300px; background: #cde; padding: 1rem; }\n</style>\n<p>Baked <span class="tag">this morning</span> in Hexford.</p>',
                note: 'The width is ignored. The horizontal padding pushes the text along; the vertical padding is drawn but overlaps the lines above and below.',
              },
              {
                label: 'inline-block',
                code: '<style>\n  .tag { display: inline-block; width: 300px; background: #cde; padding: 1rem; }\n</style>\n<p>Baked <span class="tag">this morning</span> in Hexford.</p>',
                note: 'Still on the line, now genuinely 300px wide, and the vertical padding pushes the line apart properly.',
              },
              {
                label: 'block',
                code: '<style>\n  .tag { display: block; width: 300px; background: #cde; padding: 1rem; }\n</style>\n<p>Baked <span class="tag">this morning</span> in Hexford.</p>',
                note: 'Breaks out onto its own line. Correct if it really is a block — but it has now interrupted the sentence.',
              },
            ]),
            callout(
              'accessibility',
              '`display: none` removes it from everyone',
              'A `display: none` element has no box, is not announced by a screen reader, and cannot be focused. That is exactly right for content that is genuinely not there yet — and exactly wrong for something meant to be available to assistive technology but not visually, which needs a visually-hidden pattern instead. Hiding a skip link with `display: none` breaks it completely, which is the mistake Level 8 of the HTML course warns about.',
            ),
            predictCheck(
              `<style>
  .box { display: inline; width: 200px; height: 200px; background: #cde; }
</style>
<div class="box">A div set to inline.</div>`,
              'A `<div>` — normally a block — is forced to `display: inline` and given a width and height. Before you check: how big is the box?',
              'Exactly as big as its text, and no bigger. `width` and `height` do not apply to non-replaced inline boxes, whatever element they started as. This is worth seeing once because it proves the point: block and inline are not properties of the *element*, they are properties of the box the element generates — and `display` changes that box completely. The element being a `<div>` buys you nothing here.',
            ),
            detail(
              'Replaced elements are the exception',
              'An `<img>`, `<video>`, `<input>` or `<iframe>` is a *replaced* element — its content comes from outside the document. Replaced elements are inline by default and yet `width` and `height` do apply to them, which is why an image can be sized without touching `display`. It is the single most useful exception to remember.',
            ),
            recap(
              [
                'Normal flow stacks blocks down the page and runs inline content along a line.',
                'Inline boxes ignore `width` and `height`, and their vertical margin and padding do not push anything.',
                '`inline-block` keeps an element in the line while sizing it like a block.',
                '`display: none` removes an element from layout, from the accessibility tree and from the tab order.',
              ],
              'Next: leaving normal flow deliberately.',
            ),
            activeRecap(
              [
                'What does an inline box ignore?',
                'What is `inline-block` for?',
                'Why is `display: none` more than a visual change?',
              ],
              [
                '`width` and `height`, and vertical margin and padding do not push neighbouring content away — they are drawn but overlap.',
                'Keeping an element in the flow of a line while letting it be sized like a block, with working vertical padding.',
                'Because it removes the element entirely: no box, not announced by screen readers, not focusable. Anything that should be available to assistive technology but not shown needs a visually-hidden pattern instead.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-flow-guided',
              kind: 'guided',
              title: 'Size a badge that stays in the line',
              brief:
                'The `.badge` span should stay inside the sentence but be exactly 8rem wide with 0.5rem of padding all round. Choose the display value that allows both.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flow</title>
    <style>
      .badge { width: 8rem; padding: 0.5rem; background: #cde; }
    </style>
  </head>
  <body>
    <p>Baked <span class="badge">this morning</span> in Hexford.</p>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flow</title>
    <style>
      .badge {
        display: inline-block;
        width: 8rem;
        padding: 0.5rem;
        background: #cde;
      }
    </style>
  </head>
  <body>
    <p>Baked <span class="badge">this morning</span> in Hexford.</p>
  </body>
</html>`,
              hints: [
                'A plain inline box ignores width entirely.',
                'display: block would break the badge onto its own line.',
                'inline-block keeps it in the sentence and lets it be sized.',
              ],
              requirements: [
                cssIs('.badge', 'display', 'inline-block', 'The badge is inline-block'),
                cssIs('.badge', 'width', '8rem', 'The badge is 8rem wide'),
                cssIs('.badge', 'padding', '0.5rem', 'The badge has 0.5rem of padding'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'layout-flow',
            },
          ],
          quiz: [
            {
              slug: 'q-css-inline-ignores',
              prompt: 'Which does a non-replaced inline box ignore?',
              explanation: '`width` and `height` do not apply to inline boxes.',
              options: [
                { label: '`width`', correct: true },
                { label: '`color`' },
                { label: '`font-size`' },
                { label: '`background`' },
              ],
              skill: 'layout-flow',
            },
            {
              slug: 'q-css-display-none-cost',
              prompt: 'What else does `display: none` do besides hiding an element visually?',
              explanation:
                'It removes it from the accessibility tree and from the tab order — it is gone for everyone.',
              options: [
                { label: 'Removes it from the accessibility tree and the tab order', correct: true },
                { label: 'Only hides it visually' },
                { label: 'Keeps it focusable for keyboard users' },
                { label: 'Makes it transparent but still clickable' },
              ],
              skill: 'layout-flow',
            },
            {
              slug: 'q-css-replaced-elements',
              prompt: 'Why can an `<img>` be given a width even though it is inline?',
              explanation: 'It is a replaced element — its content comes from outside the document, and sizing applies.',
              options: [
                { label: 'It is a replaced element', correct: true },
                { label: 'Images are block by default' },
                { label: 'Width always applies to every element' },
                { label: 'Because it has a src attribute' },
              ],
              skill: 'layout-flow',
            },
          ],
        },
        {
          slug: 'css-position-and-stacking',
          title: 'Position and stacking',
          subtitle: 'The four schemes, and why `z-index` sometimes does nothing',
          summary:
            'Positioning takes an element partly or wholly out of flow. Stacking decides what covers what — and it is not simply "the biggest number wins".',
          objectives: [
            'Choose between static, relative, absolute, fixed and sticky',
            'Explain what an absolutely positioned element is positioned against',
            'Say why a `z-index` of 9999 can still lose',
          ],
          estimatedMinutes: 18,
          skill: 'layout-flow',
          blocks: [
            pretest(
              'An element has `z-index: 9999` and is still hidden behind another element with `z-index: 1`. What is the most likely reason?',
              [
                'They are in different stacking contexts, and the parent of the first one sits lower',
                'z-index has a maximum of 999',
                'The element is not positioned, so z-index does nothing',
                'The other element is later in the source',
              ],
              'Both the first and third are real causes, and the first is the one that baffles people. `z-index` only orders elements *within the same stacking context*. If an ancestor created its own context — with `opacity` below 1, a `transform`, `position: fixed`, or a `z-index` of its own — then everything inside it is trapped in that context, and no number can lift a child above a sibling of its parent. The third option is also worth knowing: `z-index` has no effect at all on a `position: static` element.',
            ),
            objectives([
              'Apply each positioning scheme deliberately',
              'Identify the containing block for an absolute element',
              'Recognise when a stacking context has been created',
            ]),
            code(
              `static     the default. In flow. top/left/z-index do nothing.
relative   in flow, and offset visually from where it would be.
           Its original space is kept. Creates a positioning
           context for absolutely positioned descendants.
absolute   out of flow. Positioned against the nearest
           positioned ancestor, or the page if there is none.
fixed      out of flow. Positioned against the viewport.
sticky     in flow until it reaches a threshold, then fixed
           within its scrolling ancestor.`,
              'The five values of `position`',
              'text',
            ),
            workedExample(
              'Placing a badge in the corner of a card',
              'The classic case, and the one line everybody forgets.',
              [
                {
                  title: 'Take the badge out of flow',
                  code: `.badge { position: absolute; top: 0.5rem; right: 0.5rem; }`,
                  reasoning:
                    'Absolute positioning removes it from normal flow, so it no longer pushes the card content around. The offsets say where to put it.',
                },
                {
                  title: 'Ask: positioned against what?',
                  code: `/* Nothing yet — so the page. */`,
                  reasoning:
                    'An absolutely positioned element is placed against its nearest *positioned* ancestor. If none of its ancestors has a `position` other than `static`, it goes all the way up to the page — which is why the badge lands in the corner of the browser window rather than the card.',
                },
                {
                  title: 'Give the card a positioning context',
                  code: `.card { position: relative; }`,
                  reasoning:
                    'This is the line people forget. `position: relative` with no offsets changes nothing visually and makes the card the reference point for any absolutely positioned descendant. The badge now lands in the card corner.',
                },
                {
                  title: 'Check it did not cover anything important',
                  code: `.card { position: relative; padding-right: 5rem; }`,
                  reasoning:
                    'Out-of-flow elements do not reserve space, so the badge sits on top of whatever is underneath. If the card text can reach that corner, it needs room made for it — the layout will not do it for you.',
                },
              ],
            ),
            demo('The same badge, with and without a positioning context', 'One declaration different.', [
              {
                label: 'Card is positioned',
                code: '<style>\n  .card { position: relative; border: 1px solid teal; padding: 1rem; padding-right: 5rem; }\n  .badge { position: absolute; top: 0.5rem; right: 0.5rem; background: #cde; padding: 0.25rem 0.5rem; }\n</style>\n<div class="card">Sourdough workshop <span class="badge">New</span></div>',
                note: 'The badge is placed against the card, because the card is the nearest positioned ancestor.',
              },
              {
                label: 'Card is static',
                code: '<style>\n  .card { border: 1px solid crimson; padding: 1rem; }\n  .badge { position: absolute; top: 0.5rem; right: 0.5rem; background: #fee; padding: 0.25rem 0.5rem; }\n</style>\n<div class="card">Sourdough workshop <span class="badge">New</span></div>',
                note: 'No positioned ancestor, so the badge is placed against the page and flies to the top-right of the whole document.',
              },
            ]),
            term(
              'Stacking context',
              'A self-contained layer. Elements inside it are ordered among themselves, and the whole context is then ordered as one unit within its parent context.',
            ),
            callout(
              'mistake',
              'The things that quietly create a stacking context',
              '`position` with a `z-index` other than `auto`. `position: fixed` or `sticky`. `opacity` less than 1. Any `transform`, `filter`, `perspective`, `clip-path` or `mask`. `will-change` naming one of those. `isolation: isolate`. That `opacity: 0.99` someone added for a fade is enough — and it is why a dropdown suddenly disappears behind the next section after an unrelated change.',
            ),
            selfExplain(
              'A colleague fixes an overlap by changing a `z-index` from 10 to 9999, and it works. Write your reply: what have they actually learned about the page, and what happens the next time?',
              'They have learned that the two elements are in the same stacking context — because if they were not, no number would have helped. So the fix worked by accident of that fact rather than by understanding it. The next time this happens the number goes higher, and eventually someone hits a case where the elements are *not* in the same context and no number works at all, at which point 9999 has taught them nothing useful and the real question — which ancestor created a context, and why — has never been asked. The better fix is almost always to find the ancestor that made a context, or to give the two elements an explicit, small ordering within one shared context.',
            ),
            checklist('When something is in the wrong place or the wrong layer', [
              'Is it `position: static`? Then `top`/`left`/`z-index` do nothing.',
              'For `absolute`: which ancestor is positioned? That is what it is placed against.',
              'Does the out-of-flow element cover content that needed the space?',
              'For `z-index`: are the two elements in the same stacking context?',
              'Did an ancestor create a context with `opacity`, `transform` or `filter`?',
            ]),
            recap(
              [
                '`static` is the default and ignores offsets and `z-index` entirely.',
                '`relative` keeps its space and creates a positioning context for descendants.',
                '`absolute` is placed against the nearest positioned ancestor, or the page.',
                '`z-index` orders elements only within one stacking context, and many properties create one.',
              ],
              'Next: the Level 3 milestone.',
            ),
            activeRecap(
              [
                'What is an absolutely positioned element placed against?',
                'Name four things that create a stacking context.',
                'Why does `z-index` do nothing on a `static` element?',
              ],
              [
                'Its nearest ancestor with a `position` other than `static`. If there is none, the page itself.',
                '`position` with a numeric `z-index`; `position: fixed` or `sticky`; `opacity` below 1; a `transform`, `filter` or `clip-path`; `isolation: isolate`.',
                'Because `z-index` only applies to positioned elements. On a static element it is simply ignored, which is one of the two commonest reasons it "does not work".',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-position-guided',
              kind: 'guided',
              title: 'Pin a badge to a card',
              brief:
                'Place the badge in the top-right corner **of the card**, not of the page. Give the card the positioning context it needs, and enough right padding that the text never runs under the badge.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Position</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card { border: 1px solid teal; padding: 1rem; }
      .badge { background: #cde; padding: 0.25rem 0.5rem; }
    </style>
  </head>
  <body>
    <div class="card">
      Sourdough workshop, six hours
      <span class="badge">New</span>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Position</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card {
        position: relative;
        border: 1px solid teal;
        padding: 1rem;
        padding-right: 5rem;
      }
      .badge {
        position: absolute;
        top: 0.5rem;
        right: 0.5rem;
        background: #cde;
        padding: 0.25rem 0.5rem;
      }
    </style>
  </head>
  <body>
    <div class="card">
      Sourdough workshop, six hours
      <span class="badge">New</span>
    </div>
  </body>
</html>`,
              hints: [
                'The badge needs position: absolute with top and right offsets.',
                'Without position: relative on the card, the badge is placed against the page.',
                'Out-of-flow elements reserve no space — add right padding so the text clears it.',
              ],
              requirements: [
                cssIs('.card', 'position', 'relative', 'The card creates a positioning context'),
                cssIs('.badge', 'position', 'absolute', 'The badge is taken out of flow'),
                cssSet('.badge', 'top', 'The badge is offset from the top'),
                cssSet('.badge', 'right', 'The badge is offset from the right'),
                cssSet('.card', 'padding-right', 'The card makes room for the badge'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'layout-flow',
            },
            {
              slug: 'css-stacking-debug',
              kind: 'debug',
              title: 'A z-index that cannot win',
              brief:
                'The dropdown has `z-index: 9999` and still hides behind the banner. The cause is the `opacity` on `.header`, which creates a stacking context trapping everything inside it. Remove that cause, and give the dropdown a small, honest `z-index` of `10`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Stacking</title>
    <style>
      .header { position: relative; opacity: 0.99; }
      .dropdown { position: absolute; z-index: 9999; background: #fff; }
      .banner { position: relative; z-index: 1; background: #cde; }
    </style>
  </head>
  <body>
    <div class="header">
      <div class="dropdown">Menu contents</div>
    </div>
    <div class="banner">Promotional banner</div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Stacking</title>
    <style>
      .header { position: relative; }
      .dropdown { position: absolute; z-index: 10; background: #fff; }
      .banner { position: relative; z-index: 1; background: #cde; }
    </style>
  </head>
  <body>
    <div class="header">
      <div class="dropdown">Menu contents</div>
    </div>
    <div class="banner">Promotional banner</div>
  </body>
</html>`,
              hints: [
                'An opacity below 1 creates a stacking context, trapping every descendant inside it.',
                'Remove the opacity declaration from .header entirely.',
                'Then a z-index of 10 comfortably beats the banner\'s 1 — the huge number was never the answer.',
              ],
              requirements: [
                cssNotSet('.header', 'opacity', 'The header no longer creates a stacking context'),
                cssIs('.dropdown', 'z-index', '10', 'The dropdown uses a small, honest z-index'),
                cssIs('.dropdown', 'position', 'absolute', 'The dropdown is still positioned'),
              ],
              difficulty: 4,
              xp: 55,
              skill: 'layout-flow',
            },
          ],
          quiz: [
            {
              slug: 'q-css-absolute-against',
              prompt: 'An absolutely positioned element is placed against what?',
              explanation: 'Its nearest positioned ancestor — or the page, if none of its ancestors is positioned.',
              options: [
                { label: 'The nearest ancestor whose position is not static', correct: true },
                { label: 'Its immediate parent, always' },
                { label: 'The viewport, always' },
                { label: 'The nearest block element' },
              ],
              skill: 'layout-flow',
            },
            {
              slug: 'q-css-stacking-context-cause',
              prompt: 'Which of these creates a new stacking context?',
              explanation:
                'An `opacity` below 1 does, which is why an unrelated fade can bury a dropdown.',
              options: [
                { label: '`opacity: 0.99`', correct: true },
                { label: '`color: red`' },
                { label: '`padding: 1rem`' },
                { label: '`font-weight: bold`' },
              ],
              skill: 'layout-flow',
            },
            {
              slug: 'q-css-zindex-static',
              prompt: 'Why does `z-index: 50` do nothing on an element with no `position`?',
              explanation: '`z-index` applies only to positioned elements; on a static element it is ignored.',
              options: [
                { label: '`z-index` only applies to positioned elements', correct: true },
                { label: '50 is too small a value' },
                { label: 'It only works inside a flex container' },
                { label: 'It needs an `!important`' },
              ],
              skill: 'layout-flow',
            },
          ],
        },
        {
          slug: 'css-flow-milestone',
          title: 'Milestone: place things deliberately',
          subtitle: 'A layout where nothing is where its author meant it',
          summary:
            'Four faults, all of them flow or stacking. None needs a layout system — they need the defaults understood.',
          objectives: [
            'Diagnose a misplaced element',
            'Repair positioning without introducing a layout framework',
            'Keep out-of-flow elements from covering content',
          ],
          estimatedMinutes: 18,
          skill: 'layout-flow',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Work through positioning faults methodically',
              'Fix stacking without escalating numbers',
              'Explain each repair',
            ]),
            code(
              `Symptom                        Look at
element ignores width          is it inline?
element flew to the page edge  which ancestor is positioned?
content sits under something   out-of-flow element covering it
z-index does nothing           is the element positioned?
z-index still does nothing     which ancestor made a context?`,
              'Symptom to cause',
              'text',
            ),
            demo('Two ways a badge goes wrong', 'The same absolute badge in two cards.', [
              {
                label: 'Correct',
                code: '<style>\n  .card { position: relative; border: 1px solid teal; padding: 1rem 5rem 1rem 1rem; }\n  .badge { position: absolute; top: 0.5rem; right: 0.5rem; background: #cde; padding: 0.25rem 0.5rem; }\n</style>\n<div class="card">Sourdough workshop, six hours, small groups <span class="badge">New</span></div>',
                note: 'Positioned against the card, with padding making room so the text never runs underneath.',
              },
              {
                label: 'No room made',
                code: '<style>\n  .card { position: relative; border: 1px solid crimson; padding: 1rem; }\n  .badge { position: absolute; top: 0.5rem; right: 0.5rem; background: #fee; padding: 0.25rem 0.5rem; }\n</style>\n<div class="card">Sourdough workshop, six hours, small groups and everything provided <span class="badge">New</span></div>',
                note: 'Placed correctly and covering the text, because an out-of-flow element reserves no space for itself.',
              },
            ]),
            recall(
              'From memory: name the five values of `position` and say, in one line each, what each does to flow.',
              [
                '`static` — the default; fully in flow, and offsets and `z-index` are ignored.',
                '`relative` — in flow and keeps its space, offset visually, and becomes a positioning context for descendants.',
                '`absolute` — out of flow, reserves no space, placed against the nearest positioned ancestor.',
                '`fixed` — out of flow, placed against the viewport.',
                '`sticky` — in flow until a threshold is reached, then fixed within its scrolling ancestor.',
              ],
            ),
            recap(
              [
                'Most "wrong place" bugs are a missing `position: relative` on the intended reference.',
                'Out-of-flow elements reserve no space — make room for them yourself.',
                'A `z-index` that does nothing means either no `position`, or a different stacking context.',
              ],
              'Next: Flexbox.',
            ),
            activeRecap(
              ['What is the first thing to check when an absolutely positioned element lands in the wrong place?'],
              [
                'Which ancestor is positioned. An absolute element is placed against its nearest ancestor whose `position` is not `static`, so if nobody has one it goes all the way up to the page. Adding `position: relative` to the intended reference — which changes nothing visually on its own — is the fix nine times out of ten.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-flow-milestone-debug',
              kind: 'debug',
              title: 'Four things in the wrong place',
              brief:
                'Repair four faults. The `.tag` span must be sized (make it inline-block). The `.badge` must sit in the corner of `.card`, not the page. The card must make room so its text does not run under the badge. And the `.dropdown` must appear above `.banner` using a `z-index` of `10`, which means removing whatever is trapping it.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flow milestone</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .tag { width: 6rem; padding: 0.25rem; background: #cde; }
      .card { border: 1px solid teal; padding: 1rem; }
      .badge { position: absolute; top: 0.5rem; right: 0.5rem; background: #cde; }
      .header { position: relative; opacity: 0.99; }
      .dropdown { position: absolute; z-index: 9999; background: #fff; }
      .banner { position: relative; z-index: 1; background: #cde; }
    </style>
  </head>
  <body>
    <div class="header">
      <div class="dropdown">Menu contents</div>
    </div>
    <div class="banner">Promotional banner</div>
    <div class="card">
      Sourdough workshop <span class="tag">6 hours</span>
      <span class="badge">New</span>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flow milestone</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .tag { display: inline-block; width: 6rem; padding: 0.25rem; background: #cde; }
      .card { position: relative; border: 1px solid teal; padding: 1rem; padding-right: 5rem; }
      .badge { position: absolute; top: 0.5rem; right: 0.5rem; background: #cde; }
      .header { position: relative; }
      .dropdown { position: absolute; z-index: 10; background: #fff; }
      .banner { position: relative; z-index: 1; background: #cde; }
    </style>
  </head>
  <body>
    <div class="header">
      <div class="dropdown">Menu contents</div>
    </div>
    <div class="banner">Promotional banner</div>
    <div class="card">
      Sourdough workshop <span class="tag">6 hours</span>
      <span class="badge">New</span>
    </div>
  </body>
</html>`,
              hints: [
                'A span is inline, so its width is ignored — inline-block fixes that.',
                'The badge needs the card to be position: relative.',
                'Add right padding to the card so the text clears the badge.',
                'The opacity on .header traps the dropdown in its own stacking context.',
              ],
              requirements: [
                cssIs('.tag', 'display', 'inline-block', 'The tag can be sized'),
                cssIs('.card', 'position', 'relative', 'The card is the badge\'s reference'),
                cssSet('.card', 'padding-right', 'The card makes room for the badge'),
                cssNotSet('.header', 'opacity', 'The header no longer traps its children'),
                cssIs('.dropdown', 'z-index', '10', 'The dropdown uses a small z-index'),
              ],
              difficulty: 4,
              xp: 70,
              skill: 'layout-flow',
            },
          ],
          quiz: [
            {
              slug: 'q-css-out-of-flow-space',
              prompt: 'How much space does an absolutely positioned element reserve in the flow?',
              explanation: 'None. It is out of flow entirely, so surrounding content behaves as though it were not there.',
              options: [
                { label: 'None at all', correct: true },
                { label: 'Its full width and height' },
                { label: 'Its height only' },
                { label: 'Its margin only' },
              ],
              skill: 'layout-flow',
            },
            {
              slug: 'q-css-relative-no-offsets',
              prompt: 'What does `position: relative` with no offsets do?',
              explanation:
                'Nothing visually — but it makes the element a positioning context for absolutely positioned descendants.',
              options: [
                { label: 'Nothing visible, but it becomes a reference for absolute descendants', correct: true },
                { label: 'Removes it from flow' },
                { label: 'Centres it' },
                { label: 'Nothing at all; it is a no-op' },
              ],
              skill: 'layout-flow',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'css-level-3-milestone',
    kind: 'milestone',
    title: 'Level 3 milestone: Flow, Position and Stacking',
    description: 'Six questions on normal flow, positioning and stacking. Pass mark 75%.',
    passScore: 0.75,
    xp: 180,
    questions: [
      {
        slug: 'a-css-3-inline-width',
        prompt: 'Why is `width` ignored on a `<span>`?',
        explanation: 'It generates an inline box, and `width` does not apply to non-replaced inline boxes.',
        options: [
          { label: 'It generates an inline box', correct: true },
          { label: 'Spans cannot be styled' },
          { label: 'The width needs a unit' },
          { label: 'It needs an id selector' },
        ],
        skill: 'layout-flow',
      },
      {
        slug: 'a-css-3-inline-block',
        prompt: 'What does `inline-block` give you?',
        explanation: 'A box that stays in the line but can be sized like a block.',
        options: [
          { label: 'Stays in the line, sizes like a block', correct: true },
          { label: 'Breaks onto its own line' },
          { label: 'Removes it from the document' },
          { label: 'Makes it position: absolute' },
        ],
        skill: 'layout-flow',
      },
      {
        slug: 'a-css-3-abs-reference',
        prompt: 'A badge with `position: absolute` lands in the corner of the page instead of its card. Why?',
        explanation: 'No ancestor is positioned, so it falls back to the page.',
        options: [
          { label: 'No ancestor has a position other than static', correct: true },
          { label: 'The offsets are the wrong way round' },
          { label: 'Absolute always means the page' },
          { label: 'The card needs a z-index' },
        ],
        skill: 'layout-flow',
      },
      {
        slug: 'a-css-3-sticky',
        prompt: 'What does `position: sticky` do?',
        explanation: 'Stays in flow until a threshold, then behaves as fixed within its scrolling ancestor.',
        options: [
          { label: 'In flow until a threshold, then fixed within its scroller', correct: true },
          { label: 'Always fixed to the viewport' },
          { label: 'Always out of flow' },
          { label: 'The same as relative' },
        ],
        skill: 'layout-flow',
      },
      {
        slug: 'a-css-3-context-trap',
        prompt: 'A child with `z-index: 9999` is behind a sibling of its parent. What is happening?',
        explanation:
          'The parent created a stacking context, so the child is ordered inside it and cannot escape.',
        options: [
          { label: 'The parent created a stacking context', correct: true },
          { label: 'z-index is capped at 999' },
          { label: 'The sibling has `!important`' },
          { label: 'z-index cannot be used on children' },
        ],
        skill: 'layout-flow',
      },
      {
        slug: 'a-css-3-display-none-a11y',
        prompt: 'Which is true of `display: none`?',
        explanation: 'It removes the element for everyone — visually, from the accessibility tree, and from focus order.',
        options: [
          { label: 'It removes the element from the accessibility tree too', correct: true },
          { label: 'It hides it visually but keeps it focusable' },
          { label: 'Screen readers still announce it' },
          { label: 'It only affects printing' },
        ],
        skill: 'layout-flow',
      },
    ],
  },
};
