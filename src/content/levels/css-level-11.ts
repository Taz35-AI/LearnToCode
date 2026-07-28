import {
  activeRecap,
  callout,
  checklist,
  code,
  compare,
  cssIs,
  cssNoImportant,
  cssNotSet,
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
 * CSS Level 11 — debugging.
 *
 * Near the end deliberately. A debugging method is only teachable once there is
 * enough machinery to go wrong, and by this point the learner has met every
 * cause on the list. The claim of the level is that "this is not working" almost
 * always resolves to one of six things, and that checking them in order is
 * faster than staring at the file.
 */
export const CSS_LEVEL_11: LevelSpec = {
  slug: 'css-debugging-level',
  title: 'Debugging CSS',
  subtitle: 'Why it is not working, in order of likelihood',
  summary:
    'Almost every "my CSS is not working" is one of a short list of causes. Checking them in order — with the inspector rather than by rereading the file — turns an hour of guessing into a couple of minutes.',
  outcome:
    'You can diagnose a rule that did not apply by reading computed values rather than by guessing.',
  accent: 'violet',
  modules: [
    {
      slug: 'css-debugging-module',
      title: 'Finding out why',
      summary: 'The inspector, computed values, and the six usual causes.',
      estimatedMinutes: 52,
      prerequisites: ['css-architecture-module'],
      skills: [{ slug: 'css-debugging', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'css-inspector',
          title: 'Reading the inspector',
          subtitle: 'Computed values answer the question the file cannot',
          summary:
            'The styles panel shows what you wrote. The computed panel shows what the browser decided. When those disagree, the second one is the fact.',
          objectives: [
            'Read the computed value of a property',
            'Recognise a struck-through declaration and say why',
            'Use the box model diagram to explain a size',
          ],
          estimatedMinutes: 16,
          skill: 'css-debugging',
          blocks: [
            pretest(
              'A declaration appears struck through in the styles panel. What does that mean?',
              [
                'It did not win — something overrode it, or the value is invalid',
                'It is a comment',
                'It has not loaded yet',
                'It applies only on hover',
              ],
              'It lost, or it was never valid. The browser is telling you the exact thing you would otherwise spend twenty minutes guessing at: this declaration is not in effect. Hovering the rule above it shows what beat it, and if nothing did, the value itself was rejected — a misspelled property, a missing unit, or a `var()` that resolved to nothing.',
            ),
            objectives([
              'Find the computed value of any property',
              'Explain a struck-through declaration',
              'Read the box model diagram',
            ]),
            term(
              'Computed value',
              'What the browser actually resolved a property to for this element, after the cascade, inheritance and every relative unit.',
            ),
            code(
              `Styles panel     what you wrote, in cascade order
                 struck through = did not win, or invalid
Computed panel   what the browser decided — the fact
Box model        content, padding, border, margin, measured
:hov             force a state so you can inspect it
Filter box       type a property name to find who set it`,
              'What each part is for',
              'text',
            ),
            compare(
              'Two ways to answer "why is this not red"',
              {
                label: 'Read the computed value',
                code: `Computed → color: rgb(0, 128, 128)
Click the arrow → set by .card, line 12`,
                why: 'One answer, with the winning rule named. There is nothing left to guess at.',
              },
              {
                label: 'Reread the stylesheet',
                code: `/* scrolling through 400 lines
   looking for something that might
   be overriding it */`,
                why: 'Slow, and it cannot find the causes that are not in the file at all — an inherited value, a browser default, or a rule from a stylesheet you forgot was loaded.',
              },
            ),
            detail(
              'Force a state to inspect it',
              'A hover or focus style cannot be inspected while you are moving the pointer to the panel. The `:hov` toggle pins the state on, so `:hover`, `:focus`, `:focus-visible` and `:active` styles can be read like any other. This is the only practical way to debug a focus ring, and it is the reason focus styles are so often broken — people cannot see them while they work.',
            ),
            demo('What the computed value tells you', 'Three cases, one method.', [
              {
                label: 'Overridden',
                code: '<style>\n  .note { color: crimson; }\n  .card p { color: teal; }\n</style>\n<div class="card"><p class="note">Computed colour is teal — `.card p` is 0-1-1 and beats `.note` at 0-1-0.</p></div>',
                note: 'The styles panel would show `color: crimson` struck through.',
              },
              {
                label: 'Invalid value',
                code: '<style>\n  .note { color: teal; padding: 10; }\n</style>\n<p class="note">The padding is dropped entirely — 10 has no unit, so the declaration is invalid.</p>',
                note: 'Struck through with no override anywhere. That combination always means the value was rejected.',
              },
              {
                label: 'Never matched',
                code: '<style>\n  .notes { color: crimson; }\n</style>\n<p class="note">The rule says `.notes`; the element is `.note`. Nothing is struck through, because the rule was never in the running.</p>',
                note: 'The tell is the rule not appearing in the styles panel at all — the most commonly missed diagnosis, because there is nothing to see.',
              },
            ]),
            predictCheck(
              `<style>
  .box { width: 200px; padding: 20px; border: 5px solid teal; }
</style>
<div class="box">Measured</div>`,
              'No `box-sizing` is set here. Before you check: what total width does the box model diagram report?',
              '250px — 200 of content, plus 20 of padding and 5 of border on each side. Under the default `content-box`, `width` sizes the content alone and everything else is added on top. The box model diagram in the inspector shows all four rings with their measured numbers, which settles this in a glance rather than by arithmetic.',
            ),
            recap(
              [
                'The styles panel shows what you wrote; the computed panel shows what won.',
                'Struck through means overridden, or invalid.',
                'A rule that is missing entirely never matched at all.',
                'Force a state with `:hov` to inspect hover and focus styles.',
              ],
              'Next: the six usual causes.',
            ),
            activeRecap(
              [
                'A declaration is struck through and nothing above it sets that property. What happened?',
                'What does it mean when a rule you expected does not appear in the styles panel?',
                'Why is the computed panel more trustworthy than the file?',
              ],
              [
                'The value was invalid, so the browser dropped the declaration. A missing unit, a misspelled property, or a `var()` that resolved to nothing.',
                'It never matched the element — usually a typo in the selector, or the element does not have the class you think it does. Nothing is struck through because the rule was never a candidate.',
                'Because it reports what the browser decided after the cascade, inheritance, relative units and defaults. The file only shows what you wrote, and cannot show the causes that are not in it.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-invalid-debug',
              kind: 'debug',
              title: 'Three declarations that never applied',
              brief:
                'Each fault is one the inspector would show you. `padding: 10` has no unit, so it is invalid — make it `10px`. `colour` is not a CSS property — it is spelled `color`. And the rule targets `.notes` while the element is `.note` — fix the selector.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Invalid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .note { padding: 10; }
      .note { colour: teal; }
      .notes { border-left: 3px solid teal; }
    </style>
  </head>
  <body>
    <p class="note">Nothing here applies.</p>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Invalid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .note { padding: 10px; }
      .note { color: teal; }
      .note { border-left: 3px solid teal; }
    </style>
  </head>
  <body>
    <p class="note">Nothing here applies.</p>
  </body>
</html>`,
              hints: [
                'A length needs a unit — a bare number is invalid except for zero.',
                'CSS uses the American spelling.',
                'Check the class in the markup against the class in the selector.',
              ],
              requirements: [
                cssIs('.note', 'padding', '10px', 'The padding now has a unit and applies'),
                cssIs('.note', 'color', 'teal', 'The property name is spelled as CSS spells it'),
                cssIs('.note', 'border-left', '3px solid teal', 'The selector matches the element'),
              ],
              difficulty: 2,
              xp: 50,
              skill: 'css-debugging',
            },
          ],
          quiz: [
            {
              slug: 'q-css-struck-through',
              prompt: 'A declaration is struck through in the styles panel. What are the two possible causes?',
              explanation: 'Something overrode it, or the value was invalid.',
              options: [
                { label: 'It was overridden, or the value is invalid', correct: true },
                { label: 'It is commented out or misspelled' },
                { label: 'The file has not loaded' },
                { label: 'It applies only in print' },
              ],
              skill: 'css-debugging',
            },
            {
              slug: 'q-css-computed-panel',
              prompt: 'What does the computed panel show?',
              explanation: 'What the browser resolved, after cascade, inheritance and units.',
              options: [
                { label: 'The value the browser actually resolved', correct: true },
                { label: 'The last declaration in the file' },
                { label: 'The most specific selector' },
                { label: 'The browser default' },
              ],
              skill: 'css-debugging',
            },
            {
              slug: 'q-css-missing-rule',
              prompt: 'Your rule does not appear in the styles panel at all. What does that indicate?',
              explanation: 'It never matched the element.',
              options: [
                { label: 'The selector never matched', correct: true },
                { label: 'It was overridden' },
                { label: 'The value was invalid' },
                { label: 'It is inside a media query' },
              ],
              skill: 'css-debugging',
            },
          ],
        },
        {
          slug: 'css-diagnosis',
          title: 'The six usual causes',
          subtitle: 'A checklist that beats staring at the file',
          summary:
            'Working through the list in order finds the cause faster than any amount of rereading, because each step rules out a whole category.',
          objectives: [
            'Apply the diagnostic list in order',
            'Distinguish "did not match" from "did not win"',
            'Recognise the causes that are not in the file',
          ],
          estimatedMinutes: 18,
          skill: 'css-debugging',
          blocks: [
            pretest(
              'What is the first thing to check when a rule seems not to apply?',
              [
                'Whether it matched the element at all',
                'Whether the browser supports the property',
                'Whether the file is cached',
                'Whether the value needs a prefix',
              ],
              'Whether it matched. It costs one glance at the styles panel and eliminates the largest category outright — typos in the selector, a class that is not on the element, a rule in the wrong block. Checking support or caching first means investigating rare causes before common ones, which is how debugging sessions turn into afternoons.',
            ),
            objectives([
              'Work the list in order',
              'Name the six causes',
              'Explain why order matters in diagnosis',
            ]),
            workedExample(
              'The list, in order',
              'Each step eliminates a category, so the order is the method.',
              [
                {
                  title: '1. Did it match?',
                  code: `/* Rule absent from the styles panel entirely. */
.notes { color: teal }   /* element is class="note" */`,
                  reasoning:
                    'The biggest category and the cheapest to check. A typo in the selector, a class that is not on the element, or a rule that ended up inside a media query that is not active.',
                },
                {
                  title: '2. Did it win?',
                  code: `/* Struck through, with a stronger rule above it. */
.note { color: crimson }
.card p { color: teal }   /* 0-1-1 beats 0-1-0 */`,
                  reasoning:
                    'Specificity or source order. The panel names the winner, so this is a read rather than a deduction.',
                },
                {
                  title: '3. Was the value valid?',
                  code: `padding: 10;        /* no unit */
colour: teal;       /* not a property */
color: var(--nope); /* resolves to nothing */`,
                  reasoning:
                    'Struck through with nothing overriding it. The browser dropped the declaration and said nothing — the third case is the nastiest, because the syntax is perfect.',
                },
                {
                  title: '4. Does the property apply to that element?',
                  code: `span { width: 200px }   /* inline: ignored */
.parent { gap: 1rem }   /* not flex or grid: ignored */`,
                  reasoning:
                    'A valid declaration on an element it means nothing for. `width` on an inline element and `gap` without a flex or grid container are the two that catch nearly everyone.',
                },
                {
                  title: '5. Is something else in play?',
                  code: `/* inherited value, browser default,
   a reset, or a rule from another sheet */`,
                  reasoning:
                    'The causes that are not in your file. The computed panel finds them because it reports the source of the winning value wherever it came from.',
                },
                {
                  title: '6. Is it the element you think it is?',
                  code: `/* the padding is on the wrapper,
   the border is on the child */`,
                  reasoning:
                    'Last because it is the least common and the hardest to see. Select the element in the inspector rather than assuming, and the box model diagram settles it.',
                },
              ],
            ),
            demo('Causes four and six, seen', 'Both look like the CSS is being ignored.', [
              {
                label: 'Property does not apply',
                code: '<style>\n  .tag { width: 200px; background: #eee; }\n</style>\n<span class="tag">width does nothing on an inline element</span>',
                note: 'Perfectly valid CSS, silently doing nothing. `display: inline-block` would make it take effect.',
              },
              {
                label: 'Fixed',
                code: '<style>\n  .tag { display: inline-block; width: 200px; background: #eee; }\n</style>\n<span class="tag">Now it is 200px</span>',
                note: 'The declaration was never the problem — the display type was.',
              },
              {
                label: 'Wrong element',
                code: '<style>\n  .wrapper { padding: 2rem; background: #eee; }\n  .card { background: #fff; }\n</style>\n<div class="wrapper"><div class="card">The padding people go looking for on .card is on .wrapper</div></div>',
                note: 'Selecting the element in the inspector rather than assuming which one it is takes a second and settles it.',
              },
            ]),
            callout(
              'tip',
              'When you are truly stuck, bisect',
              'Comment out half the stylesheet. If the problem disappears, it was in that half; if not, it was in the other. Six or seven halvings locate the cause in a 400-line file with certainty, and it works even when you have no theory at all — which is exactly the situation where rereading is least effective.',
            ),
            selfExplain(
              'Why does working the list in order beat checking whatever you suspect first?',
              'Because your suspicion is shaped by what you were last working on, not by what is actually most likely — so it sends you to a rare cause while the common one goes unchecked. The order is not arbitrary either: each step eliminates a whole category, and the early steps are the cheapest to perform as well as the most likely to hit. Checking "did it match" costs one glance and rules out more cases than everything below it combined. There is also a discipline benefit: a fixed order means you cannot check the same thing three times and skip the step that would have found it, which is the actual shape of most long debugging sessions.',
            ),
            checklist('When a rule is not applying', [
              'Did it match? — the rule appears in the styles panel',
              'Did it win? — not struck through',
              'Was the value valid? — struck through with nothing overriding it',
              'Does the property apply to this element? — inline, or not a flex container',
              'Is something else in play? — inheritance, a default, another sheet',
              'Is it the element you think it is? — select it and read the box model',
            ]),
            recap(
              [
                'Six causes account for nearly every case.',
                'Check them in order; each step eliminates a category.',
                'Valid CSS on the wrong kind of element does nothing, silently.',
                'Bisect when you have no theory at all.',
              ],
              'Next: the Level 11 milestone.',
            ),
            activeRecap(
              [
                'What is the difference between "did not match" and "did not win", and how do you tell them apart?',
                'Which two properties most often fail because they do not apply to the element?',
                'When is bisecting the right tool?',
              ],
              [
                'A rule that did not match was never a candidate, so it is absent from the styles panel entirely. One that did not win is present but struck through, with the winner shown above it. The panel distinguishes them at a glance — absent versus struck through.',
                '`width` and `height` on an inline element, and `gap` on a container that is not flex or grid. Both are valid CSS that silently does nothing.',
                'When you have no theory. Halving the stylesheet finds the cause by elimination rather than by insight, which is exactly what you lack at that point.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-applies-debug',
              kind: 'debug',
              title: 'Valid CSS that does nothing',
              brief:
                'Two faults from cause four. `.tag` sets a width on an inline element — add `display: inline-block` so the width takes effect. And `.row` sets `gap` without being a flex container — add `display: flex`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Applies</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .tag { width: 200px; background: #eee; }
      .row { gap: 1rem; }
    </style>
  </head>
  <body>
    <span class="tag">Tag</span>
    <div class="row"><div>One</div><div>Two</div></div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Applies</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .tag { display: inline-block; width: 200px; background: #eee; }
      .row { display: flex; gap: 1rem; }
    </style>
  </head>
  <body>
    <span class="tag">Tag</span>
    <div class="row"><div>One</div><div>Two</div></div>
  </body>
</html>`,
              hints: [
                'An inline element ignores width and height.',
                'gap only means something inside a flex or grid container.',
                'Neither declaration was wrong — the display type was.',
              ],
              requirements: [
                cssIs('.tag', 'display', 'inline-block', 'The tag can now take a width'),
                cssIs('.tag', 'width', '200px', 'The width is kept'),
                cssIs('.row', 'display', 'flex', 'The row is a flex container, so gap applies'),
                cssIs('.row', 'gap', '1rem', 'The gap is kept'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'css-debugging',
            },
          ],
          quiz: [
            {
              slug: 'q-css-first-check',
              prompt: 'What is the first check when a rule seems not to apply?',
              explanation: 'Whether it matched at all — the largest and cheapest category to eliminate.',
              options: [
                { label: 'Whether it matched the element', correct: true },
                { label: 'Whether the browser supports it' },
                { label: 'Whether the file is cached' },
                { label: 'Whether it needs a vendor prefix' },
              ],
              skill: 'css-debugging',
            },
            {
              slug: 'q-css-inline-width',
              prompt: 'Why does `width` do nothing on a `<span>`?',
              explanation: 'An inline element ignores width and height.',
              options: [
                { label: 'Inline elements ignore width and height', correct: true },
                { label: 'The value is invalid' },
                { label: 'Spans cannot be styled' },
                { label: 'It needs `!important`' },
              ],
              skill: 'css-debugging',
            },
            {
              slug: 'q-css-bisect',
              prompt: 'When is bisecting the stylesheet the right approach?',
              explanation: 'When you have no theory — it finds the cause by elimination.',
              options: [
                { label: 'When you have no theory about the cause', correct: true },
                { label: 'When the file is small' },
                { label: 'Before checking anything else' },
                { label: 'Only for specificity problems' },
              ],
              skill: 'css-debugging',
            },
          ],
        },
        {
          slug: 'css-debugging-milestone',
          title: 'Milestone: diagnose and repair',
          subtitle: 'Every cause on the list, in one file',
          summary: 'A stylesheet with one instance of each common fault.',
          objectives: [
            'Diagnose each fault by its signature',
            'Repair without escalating specificity',
            'Leave the stylesheet within the conventions',
          ],
          estimatedMinutes: 18,
          skill: 'css-debugging',
          masteryThreshold: 0.8,
          blocks: [
            objectives(['Find and fix one instance of each common cause, without escalating anything']),
            code(
              `Absent from the panel     → never matched
Struck through, overridden → lost the cascade
Struck through, alone      → invalid value
Present, no visible effect → does not apply here
Value from nowhere         → inherited or a default
Right rule, wrong box      → not that element`,
              'Signature → cause',
              'text',
            ),
            recall(
              'From memory: what is the signature of each cause?',
              [
                'Never matched — the rule is absent from the styles panel entirely.',
                'Lost the cascade — present but struck through, with the winner shown above.',
                'Invalid value — struck through with nothing overriding it.',
                'Does not apply — present, winning, and visibly doing nothing.',
                'Something else in play — a computed value whose source is not your rule.',
                'Wrong element — the rule is fine; it is on a different box than you assumed.',
              ],
            ),
            recap(
              [
                'Diagnosis is a read, not a guess.',
                'Each signature points at exactly one cause.',
                'Repair by lowering, not by escalating.',
              ],
              'Next: the capstone.',
            ),
            activeRecap(
              ['Why does repairing by escalation make the next bug harder to diagnose?'],
              [
                'Because it adds a rule whose only reason for existing is to beat another one, and that reason is invisible six months later. The next person sees an `!important` or a deep selector, cannot tell what it was defending against, and dares not remove it — so it stays, and the next fix has to beat that too. Lowering the over-strong rule instead leaves a stylesheet where the winner is always the obvious one.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-debugging-milestone-debug',
              kind: 'debug',
              title: 'Four faults, four causes',
              brief:
                'One of each. `.titel` is a typo for `.title`. `#main .note` is over-specific and beats `.warning` — lower it to `.note` so the later `.warning` rule wins. `margin: 8` is missing its unit. And `.row` sets `gap` without `display: flex`. Fix all four, and leave nothing using `!important`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Diagnose</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .titel { font-size: 1.5rem; }
      #main .note { color: teal; }
      .warning { color: crimson; }
      .card { margin: 8; }
      .row { gap: 1rem; }
    </style>
  </head>
  <body>
    <div id="main">
      <h2 class="title">Sourdough</h2>
      <p class="note warning">A warning, which should be crimson.</p>
      <div class="card">Card</div>
      <div class="row"><div>One</div><div>Two</div></div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Diagnose</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .title { font-size: 1.5rem; }
      .note { color: teal; }
      .warning { color: crimson; }
      .card { margin: 8px; }
      .row { display: flex; gap: 1rem; }
    </style>
  </head>
  <body>
    <div id="main">
      <h2 class="title">Sourdough</h2>
      <p class="note warning">A warning, which should be crimson.</p>
      <div class="card">Card</div>
      <div class="row"><div>One</div><div>Two</div></div>
    </div>
  </body>
</html>`,
              hints: [
                'Compare each selector against the class actually in the markup.',
                'Removing the id brings both colour rules to one class, so source order decides.',
                'A bare number is not a length.',
                'gap needs a flex or grid container to mean anything.',
              ],
              requirements: [
                cssIs('.title', 'font-size', '1.5rem', 'The heading rule matches the markup'),
                cssIs('.warning', 'color', 'crimson', 'The warning colour wins without escalation'),
                cssIs('.card', 'margin', '8px', 'The margin has a unit and applies'),
                cssIs('.row', 'display', 'flex', 'The row is a flex container'),
                cssNoImportant('Nothing was repaired by escalating'),
                cssNotSet('.title', 'color', 'The heading was not given styles it never needed'),
              ],
              difficulty: 4,
              xp: 75,
              skill: 'css-debugging',
            },
          ],
          quiz: [
            {
              slug: 'q-css-signature-invalid',
              prompt: 'Struck through, with nothing above it setting that property. Which cause?',
              explanation: 'The value was invalid, so the browser dropped the declaration.',
              options: [
                { label: 'An invalid value', correct: true },
                { label: 'It was overridden' },
                { label: 'It never matched' },
                { label: 'It does not apply to that element' },
              ],
              skill: 'css-debugging',
            },
            {
              slug: 'q-css-repair-by-lowering',
              prompt: 'A rule is being beaten by an over-specific one. What is the right repair?',
              explanation: 'Lower the over-specific rule rather than escalating the one that lost.',
              options: [
                { label: 'Lower the over-specific rule', correct: true },
                { label: 'Add `!important` to the loser' },
                { label: 'Add an id to the loser' },
                { label: 'Move the loser to the end of the file' },
              ],
              skill: 'css-debugging',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'css-level-11-milestone',
    kind: 'milestone',
    title: 'Level 11 milestone: Debugging CSS',
    description: 'Six questions on the inspector and the diagnostic order. Pass mark 75%.',
    passScore: 0.75,
    xp: 190,
    questions: [
      {
        slug: 'a-css-11-computed',
        prompt: 'Which panel tells you what the browser actually decided?',
        explanation: 'The computed panel — the styles panel shows what you wrote.',
        options: [
          { label: 'The computed panel', correct: true },
          { label: 'The styles panel' },
          { label: 'The network panel' },
          { label: 'The console' },
        ],
        skill: 'css-debugging',
      },
      {
        slug: 'a-css-11-absent',
        prompt: 'The rule is absent from the styles panel. What does that mean?',
        explanation: 'It never matched the element.',
        options: [
          { label: 'It never matched', correct: true },
          { label: 'It was overridden' },
          { label: 'Its value was invalid' },
          { label: 'It is in a later layer' },
        ],
        skill: 'css-debugging',
      },
      {
        slug: 'a-css-11-order',
        prompt: 'Why check the causes in a fixed order?',
        explanation: 'Each step eliminates a category, cheapest and most likely first.',
        options: [
          { label: 'Each step eliminates a category, most likely first', correct: true },
          { label: 'The browser requires it' },
          { label: 'It makes the file smaller' },
          { label: 'It avoids caching problems' },
        ],
        skill: 'css-debugging',
      },
      {
        slug: 'a-css-11-gap',
        prompt: '`gap: 1rem` has no effect. What is the most likely cause?',
        explanation: 'The container is neither flex nor grid.',
        options: [
          { label: 'The container is not flex or grid', correct: true },
          { label: 'The value is invalid' },
          { label: 'It was overridden' },
          { label: '`gap` needs a prefix' },
        ],
        skill: 'css-debugging',
      },
      {
        slug: 'a-css-11-hov',
        prompt: 'What is the `:hov` toggle in the inspector for?',
        explanation: 'Pinning a state on so hover and focus styles can be inspected.',
        options: [
          { label: 'Forcing a state so its styles can be read', correct: true },
          { label: 'Hiding hover styles' },
          { label: 'Showing the box model' },
          { label: 'Disabling transitions' },
        ],
        skill: 'css-debugging',
      },
      {
        slug: 'a-css-11-bisect',
        prompt: 'What makes bisecting effective when you have no theory?',
        explanation: 'It locates the cause by elimination rather than by insight.',
        options: [
          { label: 'It finds the cause by elimination, needing no theory', correct: true },
          { label: 'It is faster to type' },
          { label: 'It fixes the bug directly' },
          { label: 'It only works on small files' },
        ],
        skill: 'css-debugging',
      },
    ],
  },
};
