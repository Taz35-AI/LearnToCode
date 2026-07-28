import {
  activeRecap,
  annotated,
  callout,
  checklist,
  code,
  compare,
  cssInherited,
  cssIs,
  cssNoImportant,
  cssRule,
  cssSet,
  cssSpecificityBudget,
  demo,
  detail,
  objectives,
  predictCheck,
  present,
  pretest,
  prose,
  recall,
  recap,
  selfExplain,
  term,
  workedExample,
  SPECIFICITY_ONE_CLASS,
  type LevelSpec,
} from '../types';

/**
 * CSS Level 1 — the cascade.
 *
 * Deliberately first. Most CSS material teaches properties for weeks and
 * reaches the cascade near the end, by which point the learner has built a
 * mental model in which rules mysteriously stop working and the fix is to add
 * `!important` until they start again. Teaching it first costs one level and
 * removes the single largest source of wasted hours in the language.
 */
export const CSS_LEVEL_01: LevelSpec = {
  slug: 'css-cascade',
  title: 'The Cascade',
  subtitle: 'Why a rule wins, why it loses, and why it sometimes never applied at all',
  summary:
    'Every "CSS is not working" is one of four things: the selector did not match, another rule won, the property does not inherit, or it was never valid. This level makes all four visible.',
  outcome: 'You can look at any conflicting pair of CSS rules and say which wins, and why.',
  accent: 'violet',
  modules: [
    {
      slug: 'css-first-rules',
      title: 'Rules, selectors and the cascade',
      summary:
        'What a rule is made of, how the browser decides between two of them, and the inheritance model underneath.',
      estimatedMinutes: 70,
      skills: [{ slug: 'cascade', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'css-what-a-rule-is',
          title: 'What a rule actually is',
          subtitle: 'Selector, declaration block, and where the CSS lives',
          summary:
            'Three parts, one shape, repeated forever. Everything else in CSS is variations on this.',
          objectives: [
            'Name the parts of a CSS rule',
            'Write a rule that targets an element',
            'Explain where a stylesheet can live and which wins',
          ],
          estimatedMinutes: 14,
          skill: 'cascade',
          blocks: [
            pretest(
              'A page has `<p style="color: red">` in the markup and `p { color: blue }` in a stylesheet. What colour is the paragraph?',
              [
                'Red — the inline style wins',
                'Blue — the stylesheet is more official',
                'Whichever appears later in the file',
                'Neither; they cancel out',
              ],
              'Red. An inline `style` attribute beats any selector in a stylesheet, however specific — the only thing that outranks it is an `!important` declaration in a rule. This is worth knowing on day one because inline styles are the most common reason a learner\'s stylesheet appears to be ignored entirely.',
            ),
            objectives([
              'Identify the selector, property and value in any rule',
              'Write rules that target elements by type and by class',
              'Explain the three places CSS can live, and which one wins',
            ]),
            prose(
              'HTML says what something *is*. CSS says how it should look. The two stay separate on purpose: the same markup can be styled completely differently, and the same stylesheet can serve a thousand pages.',
            ),
            term(
              'Rule',
              'A selector followed by a block of declarations. `p { color: teal; }` is one rule with one declaration.',
            ),
            term(
              'Declaration',
              'A property and a value, separated by a colon and ended with a semicolon. `color: teal;` is one declaration.',
            ),
            annotated(
              `p {
  color: teal;
  line-height: 1.5;
}`,
              [
                { line: '1', text: '`p` is the **selector** — every paragraph on the page.' },
                { line: '1', text: 'The `{` opens the **declaration block**. Everything until the `}` applies to whatever the selector matched.' },
                { line: '2', text: '`color` is the **property**, `teal` is the **value**, and the semicolon ends the declaration. The last one before `}` may legally omit it — include it anyway, so adding a line later cannot break the one above.' },
                { line: '3', text: 'A second declaration. A rule may have as many as it needs.' },
              ],
            ),
            prose(
              'CSS can live in three places, and knowing which wins saves an afternoon.',
            ),
            code(
              `1. An external file, linked from the head:
   <link rel="stylesheet" href="styles.css">
   The right answer for a real site — one file, every page.

2. A <style> element in the head:
   <style> p { color: teal } </style>
   Fine for one page, and what you will use in this course.

3. A style attribute on an element:
   <p style="color: teal">
   Beats both of the above, cannot be reused, and is nearly
   always a mistake outside of email or generated markup.`,
              'Where CSS lives',
              'text',
            ),
            callout(
              'note',
              'Why this course uses `<style>`',
              'Everything you write here goes in a `<style>` element in the same file as the markup. That is not how a real site is built, and it removes an entire category of "my stylesheet is not loading" problems — wrong path, wrong filename, cached old copy — that teach you nothing about CSS. Level 10 covers splitting a stylesheet out properly.',
            ),
            demo('The same paragraph, three ways of styling it', 'Identical markup in all three.', [
              {
                label: 'A type selector',
                code: '<style>\n  p { color: teal; font-size: 1.25rem }\n</style>\n<p>Fresh bread, every morning.</p>',
                note: 'Targets every `<p>` on the page. Simple, and exactly right when you genuinely mean all of them.',
              },
              {
                label: 'A class',
                code: '<style>\n  .lead { color: teal; font-size: 1.25rem }\n</style>\n<p class="lead">Fresh bread, every morning.</p>\n<p>We open at 6am.</p>',
                note: 'Targets only what you opt in. This is the workhorse of real CSS — you decide what gets it.',
              },
              {
                label: 'An inline style',
                code: '<p style="color: teal; font-size: 1.25rem">Fresh bread, every morning.</p>',
                note: 'Works, applies to exactly one element, cannot be reused, and beats any rule you write later. Avoid.',
              },
            ]),
            term(
              'Class',
              'A label you put on elements with `class="name"`, selected in CSS with a leading dot: `.name`. An element may carry several, separated by spaces.',
            ),
            predictCheck(
              `<style>
  p { colour: teal }
  p { font-size: 1.25rem }
</style>
<p>Fresh bread, every morning.</p>`,
              'The first declaration spells the property the British way. Before you check: does the whole rule fail, does the whole stylesheet fail, or does something else happen?',
              'Only that one declaration is discarded. The browser drops any declaration it does not understand and carries on — so the font size still applies, and the colour silently does nothing. There is no error, no warning, and nothing in the page to suggest a problem. This is the single most important thing to know about debugging CSS: **invalid CSS fails silently, one declaration at a time**. If a property seems to do nothing, checking the spelling is not a beginner move, it is the first thing an expert checks.',
            ),
            checklist('The shape of every rule', [
              'A selector saying what to target',
              'A `{` opening the block',
              'One or more `property: value;` declarations',
              'A `}` closing the block',
              'Semicolons after every declaration, including the last',
            ]),
            recap(
              [
                'A rule is a selector plus a block of `property: value` declarations.',
                'CSS lives in an external file, a `<style>` element, or a `style` attribute — in increasing order of how much it wins and how little it should be used.',
                'A class is an opt-in label; a type selector catches everything.',
                'An invalid declaration is dropped silently, and nothing tells you.',
              ],
              'Next: what happens when two rules disagree.',
            ),
            activeRecap(
              [
                'Name the four parts of a CSS rule.',
                'Where can CSS live, and which of the three wins?',
                'What happens when you misspell a property name?',
              ],
              [
                'Selector, declaration block, and within it a property and a value. Declarations are separated by semicolons.',
                'An external file, a `<style>` element, or a `style` attribute. The inline `style` attribute beats the other two — only `!important` in a rule outranks it.',
                'That single declaration is silently discarded. The rest of the rule still applies, nothing warns you, and the page simply looks wrong.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-first-rule-guided',
              kind: 'guided',
              title: 'Write your first rule',
              brief:
                'The page has a heading and two paragraphs. Add a `<style>` element in the head and write one rule so that **every** paragraph is `teal`, and a second rule so the heading is `rebeccapurple`. Use type selectors — no classes yet.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Riverside Bakery</title>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>Fresh bread, every morning.</p>
    <p>We open at 6am and bake until we sell out.</p>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Riverside Bakery</title>
    <style>
      h1 { color: rebeccapurple; }
      p { color: teal; }
    </style>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>Fresh bread, every morning.</p>
    <p>We open at 6am and bake until we sell out.</p>
  </body>
</html>`,
              hints: [
                'The <style> element goes inside <head>, after the title.',
                'A type selector is just the element name: p { ... }',
                'Inside the block: color: teal;',
              ],
              requirements: [
                present('style', 'There is a <style> element'),
                cssIs('p', 'color', 'teal', 'Every paragraph resolves to teal'),
                cssIs('h1', 'color', 'rebeccapurple', 'The heading resolves to rebeccapurple'),
                cssRule('p', 'A rule targets paragraphs by type'),
              ],
              difficulty: 1,
              xp: 30,
              skill: 'cascade',
            },
            {
              slug: 'css-first-rule-debug',
              kind: 'debug',
              title: 'Three rules that do nothing',
              brief:
                'This stylesheet looks reasonable and none of it works. Three faults: a misspelled property, a missing colon, and a selector with a stray dot that matches nothing. Repair all three so the paragraph is `teal` at `1.25rem`, and the heading is `rebeccapurple`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Riverside Bakery</title>
    <style>
      p { colour: teal; }
      p { font-size 1.25rem; }
      .h1 { color: rebeccapurple; }
    </style>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>Fresh bread, every morning.</p>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Riverside Bakery</title>
    <style>
      p { color: teal; }
      p { font-size: 1.25rem; }
      h1 { color: rebeccapurple; }
    </style>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>Fresh bread, every morning.</p>
  </body>
</html>`,
              hints: [
                'CSS uses the American spelling of colour.',
                'Every declaration needs a colon between the property and the value.',
                'A leading dot means "class". The heading has no class — select it by type.',
              ],
              requirements: [
                cssIs('p', 'color', 'teal', 'The paragraph resolves to teal'),
                cssIs('p', 'font-size', '1.25rem', 'The paragraph resolves to 1.25rem'),
                cssIs('h1', 'color', 'rebeccapurple', 'The heading resolves to rebeccapurple'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'cascade',
            },
          ],
          quiz: [
            {
              slug: 'q-css-rule-parts',
              prompt: 'In `p { color: teal; }`, what is `color`?',
              explanation: 'The property. `teal` is its value, and together they are one declaration.',
              options: [
                { label: 'The property', correct: true },
                { label: 'The selector' },
                { label: 'The declaration' },
                { label: 'The rule' },
              ],
              skill: 'cascade',
            },
            {
              slug: 'q-css-invalid-declaration',
              prompt: 'What happens when a browser meets a property it does not recognise?',
              explanation:
                'It discards that one declaration and carries on. Nothing is reported, which is why a misspelling can cost an hour.',
              options: [
                { label: 'That declaration is silently dropped; the rest still applies', correct: true },
                { label: 'The whole rule is ignored' },
                { label: 'The whole stylesheet is ignored' },
                { label: 'An error appears in the page' },
              ],
              skill: 'cascade',
            },
            {
              slug: 'q-css-where-it-lives',
              prompt: 'Which form of CSS beats the other two?',
              explanation:
                'A `style` attribute on the element. Only an `!important` declaration in a rule outranks it.',
              options: [
                { label: 'A `style` attribute on the element', correct: true },
                { label: 'An external stylesheet' },
                { label: 'A `<style>` element in the head' },
                { label: 'Whichever was written last' },
              ],
              skill: 'cascade',
            },
          ],
        },
        {
          slug: 'css-specificity',
          title: 'Specificity',
          subtitle: 'The scoring system that decides which rule wins',
          summary:
            'Two rules, same property, same element. One wins. The system is small, exact, and worth learning in ten minutes rather than absorbing wrongly over months.',
          objectives: [
            'Score any selector as ids, classes and elements',
            'Predict which of two conflicting rules wins',
            'Explain why `!important` is a trap rather than a tool',
          ],
          estimatedMinutes: 18,
          skill: 'cascade',
          blocks: [
            pretest(
              'Two rules set a colour on the same paragraph: `#main p { color: blue }` and `.intro.lead.card.big { color: red }`. Four classes against one id. Which wins?',
              [
                'Blue — one id beats any number of classes',
                'Red — four beats one',
                'Whichever comes later in the stylesheet',
                'Neither; the browser picks at random',
              ],
              'Blue. Specificity is not a sum — it is three separate columns compared left to right, and a single id beats *any* number of classes, even a hundred. This is why a stylesheet that starts using ids becomes progressively harder to override, and why the fix is almost never "add another id".',
            ),
            objectives([
              'Count a selector as (ids, classes, elements)',
              'Compare two selectors and say which applies',
              'Explain why raising specificity to win is a debt, not a solution',
            ]),
            term(
              'Specificity',
              'A score the browser gives every selector, used to decide which rule applies when two set the same property on the same element.',
            ),
            code(
              `Count three things, and compare them left to right:

  ids        #main                       →  (1, 0, 0)
  classes    .card  [href]  :hover       →  (0, 1, 0)
  elements   p  h1  ::before             →  (0, 0, 1)

  p                    (0, 0, 1)
  .card                (0, 1, 0)   beats every element selector
  #main                (1, 0, 0)   beats every class selector
  .card p              (0, 1, 1)
  #main .card p        (1, 1, 1)

Left to right. Any number in a column beats everything to its right.`,
              'Scoring a selector',
              'text',
            ),
            callout(
              'mistake',
              'It is not a three-digit number',
              'A very common shortcut is to read (0, 1, 0) as "10" and (0, 0, 11) as "11", and conclude that eleven elements beat one class. They do not. The columns are compared independently and never carry — which is exactly why one id beats a hundred classes.',
            ),
            workedExample(
              'Deciding a real conflict, step by step',
              'A link inside a card is the wrong colour. Three rules could apply. This is the reasoning, and it is the same four steps every time.',
              [
                {
                  title: 'List every rule that matches',
                  code: `a            { color: blue }
.card a      { color: teal }
#sidebar a   { color: crimson }`,
                  reasoning:
                    'Not every rule in the file — only the ones whose selector actually matches this element. Rules that do not match are not in the contest at all, and half of all "why is this not working" is a selector that never matched.',
                },
                {
                  title: 'Score each one',
                  code: `a            (0, 0, 1)
.card a      (0, 1, 1)
#sidebar a   (1, 0, 1)`,
                  reasoning:
                    'Count ids, then classes, then elements. Do it mechanically — the whole value of the system is that it does not require judgement.',
                },
                {
                  title: 'Compare left to right',
                  code: `(1, 0, 1)  ← #sidebar a wins
(0, 1, 1)
(0, 0, 1)`,
                  reasoning:
                    'The first column decides it immediately: one id beats zero ids, and nothing in the other columns can rescue the others. Only if the first column ties do you look at the second.',
                },
                {
                  title: 'Only if everything ties, source order decides',
                  code: `.card a { color: teal }
.card a { color: crimson }   ← this one wins`,
                  reasoning:
                    'Equal specificity means the later rule wins. This is the only situation where "move it further down the file" is a legitimate fix — and it is why the order of your stylesheet is part of its meaning.',
                },
              ],
            ),
            demo('The same link, four ways of losing the argument', 'Every panel has the same markup and a different winner.', [
              {
                label: 'Type only',
                code: '<style>\n  a { color: teal }\n</style>\n<div class="card"><a href="#">Read the menu</a></div>',
                note: 'One rule, no contest. (0, 0, 1) wins by default.',
              },
              {
                label: 'Class beats type',
                code: '<style>\n  a { color: teal }\n  .card a { color: crimson }\n</style>\n<div class="card"><a href="#">Read the menu</a></div>',
                note: '(0, 1, 1) beats (0, 0, 1). Note that the *order* is irrelevant here — swapping the two rules changes nothing.',
              },
              {
                label: 'Order breaks a tie',
                code: '<style>\n  .card a { color: crimson }\n  .card a { color: teal }\n</style>\n<div class="card"><a href="#">Read the menu</a></div>',
                note: 'Identical specificity, so the later rule wins. This is the only case where moving a rule down the file is a real fix.',
              },
              {
                label: 'important beats everything',
                code: '<style>\n  a { color: teal !important }\n  #sidebar .card a { color: crimson }\n</style>\n<div id="sidebar"><div class="card"><a href="#">Read the menu</a></div></div>',
                note: 'The weakest selector in the file wins because of one keyword. Now nothing can override it except another !important.',
              },
            ]),
            selfExplain(
              'A colleague fixes a stubborn style by adding `!important`, and says it worked so it was the right call. Write your reply. Do not just say "it is bad practice" — explain what specifically happens next, to them and to the next person.',
              'It worked, and it moved the problem rather than solving it. `!important` sits above the entire specificity system, so the only thing that can override this declaration later is another `!important` — and then the only way to override *that* is a more specific `!important`. Within a few months the stylesheet has a second, parallel hierarchy where the ordinary rules are decoration and the real behaviour lives in the important ones, and nobody can predict either. The underlying question was never answered: *why* was the other rule winning? Usually the honest answer is that a selector is more specific than the component needs, and lowering that instead fixes the cause. The defensible uses of `!important` are narrow — overriding a third-party stylesheet you cannot edit, or a utility class that is explicitly meant to be final.',
            ),
            detail(
              'Where `:is()`, `:where()` and `:not()` sit',
              '`:where()` always scores zero, whatever is inside it — which makes it the right tool for a default that must be trivially overridable. `:is()` and `:not()` take the specificity of their *most specific* argument, so `:is(h1, #main)` scores as an id, which surprises people. That difference is the whole reason `:where()` exists, and it is the cleanest way to write a base layer that never fights the components built on it.',
            ),
            recap(
              [
                'Specificity is three columns — ids, classes, elements — compared left to right, never summed.',
                'One id beats any number of classes; one class beats any number of elements.',
                'Source order decides only when specificity is exactly equal.',
                '`!important` sits outside the system and can only be beaten by another `!important`.',
              ],
              'Next: inheritance, and the rule that is not in the contest at all.',
            ),
            activeRecap(
              [
                'Score `#main .card a:hover` as ids, classes and elements.',
                'Why does one id beat ten classes?',
                'When is source order the deciding factor?',
              ],
              [
                '(1, 2, 1) — one id, two classes (`.card` and the `:hover` pseudo-class), one element (`a`).',
                'Because the columns are compared left to right and never carry. Any non-zero count in a column beats everything to its right, whatever the numbers there.',
                'Only when two selectors have identical specificity. Then the later rule wins — and that is the only situation where moving a rule down the file is a genuine fix rather than a coincidence.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-specificity-guided',
              kind: 'guided',
              title: 'Make the more specific rule win',
              brief:
                'Both paragraphs should be grey, except the one with `class="lead"`, which should be `rebeccapurple`. Add exactly one rule to achieve that — do not edit the existing rule, and do not use `!important`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Specificity</title>
    <style>
      p { color: dimgray; }
    </style>
  </head>
  <body>
    <p class="lead">Fresh bread, every morning.</p>
    <p>We open at 6am.</p>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Specificity</title>
    <style>
      p { color: dimgray; }
      .lead { color: rebeccapurple; }
    </style>
  </head>
  <body>
    <p class="lead">Fresh bread, every morning.</p>
    <p>We open at 6am.</p>
  </body>
</html>`,
              hints: [
                'A class selector starts with a dot: .lead',
                'A class scores (0, 1, 0), which beats the type selector\'s (0, 0, 1).',
                'You do not need to repeat the type: .lead on its own is enough.',
              ],
              requirements: [
                cssIs('.lead', 'color', 'rebeccapurple', 'The lead paragraph resolves to rebeccapurple'),
                cssIs('p:not(.lead)', 'color', 'dimgray', 'The other paragraph is still dimgray'),
                cssNoImportant(),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'cascade',
            },
            {
              slug: 'css-specificity-debug',
              kind: 'debug',
              title: 'Untangle a specificity war',
              brief:
                'The button should be `teal`. Someone reached for `!important` and an id to force it, and now nothing can be overridden. Repair this properly: remove every `!important` and every id selector, and make the button teal using no selector stronger than a single class.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Buttons</title>
    <style>
      button { color: dimgray; }
      #page .toolbar button { color: crimson !important; }
      .btn { color: teal; }
    </style>
  </head>
  <body>
    <div id="page">
      <div class="toolbar">
        <button class="btn" type="button">Book a table</button>
      </div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Buttons</title>
    <style>
      button { color: dimgray; }
      .btn { color: teal; }
    </style>
  </head>
  <body>
    <div id="page">
      <div class="toolbar">
        <button class="btn" type="button">Book a table</button>
      </div>
    </div>
  </body>
</html>`,
              hints: [
                'Delete the rule that uses the id and !important entirely.',
                'The .btn rule already says teal — it was simply being outranked.',
                'Once the id rule is gone, a single class beats the type selector on its own.',
              ],
              requirements: [
                cssIs('.btn', 'color', 'teal', 'The button resolves to teal'),
                cssNoImportant(),
                cssSpecificityBudget(
                  SPECIFICITY_ONE_CLASS,
                  'No selector is stronger than a single class',
                  'Remove the id from the selector — a component should not need one.',
                ),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'cascade',
            },
          ],
          quiz: [
            {
              slug: 'q-css-id-vs-classes',
              prompt: 'Which selector wins: `#main` or `.a.b.c.d`?',
              explanation:
                '`#main`. The columns are compared left to right and never carry, so one id beats any number of classes.',
              options: [
                { label: '`#main` — one id beats any number of classes', correct: true },
                { label: '`.a.b.c.d` — four beats one' },
                { label: 'Whichever comes later' },
                { label: 'They tie' },
              ],
              skill: 'cascade',
            },
            {
              slug: 'q-css-source-order',
              prompt: 'When does the order of two rules in the file decide the winner?',
              explanation: 'Only when their specificity is exactly equal.',
              options: [
                { label: 'Only when their specificity is identical', correct: true },
                { label: 'Always — later rules always win' },
                { label: 'Never; only specificity matters' },
                { label: 'Only inside a media query' },
              ],
              skill: 'cascade',
            },
            {
              slug: 'q-css-important-cost',
              prompt: 'What is the real cost of fixing a conflict with `!important`?',
              explanation:
                'It can only be overridden by another `!important`, so it starts a parallel hierarchy that grows.',
              options: [
                { label: 'Only another !important can override it later', correct: true },
                { label: 'It slows the page down' },
                { label: 'It stops the rest of the rule applying' },
                { label: 'Nothing — it is the recommended fix' },
              ],
              skill: 'cascade',
            },
          ],
        },
        {
          slug: 'css-inheritance',
          title: 'Inheritance',
          subtitle: 'The value that is not in the specificity contest at all',
          summary:
            'Some properties flow down the tree and some do not. Knowing which — and that inheritance loses to everything — closes the last gap in the model.',
          objectives: [
            'Name which kinds of property inherit',
            'Explain why an inherited value loses to any direct rule',
            'Use `inherit` deliberately',
          ],
          estimatedMinutes: 16,
          skill: 'cascade',
          blocks: [
            pretest(
              '`#page { color: crimson }` sets a colour on a wrapper. Inside it, `p { color: teal }` sets one on paragraphs. An id against a type selector. What colour are the paragraphs?',
              [
                'Teal — an inherited value loses to any rule on the element itself',
                'Crimson — the id is far more specific',
                'Crimson, because the wrapper is closer to the root',
                'It depends which rule comes first',
              ],
              'Teal, and the specificity of the id is completely irrelevant. Inheritance is not part of the specificity contest: it only supplies a value when *nothing at all* set that property on the element itself. Any direct rule, however weak, beats any inherited value, however specific its source. This one fact resolves a large share of the confusion beginners have about the cascade.',
            ),
            objectives([
              'Predict which properties reach a child element',
              'Explain the relationship between inheritance and specificity',
              'Use `inherit` to opt in deliberately',
            ]),
            prose(
              'Some properties pass down the document tree to descendants automatically. Broadly: the ones about *text* inherit, and the ones about *boxes* do not.',
            ),
            code(
              `Inherit by default          Do not inherit
  color                       margin, padding
  font-family, font-size      border
  font-weight, font-style     background
  line-height                 width, height
  letter-spacing              display, position
  text-align, text-indent     flex, grid
  visibility, cursor          box-shadow
  list-style

The rule of thumb: if it describes the text, it inherits.
If it describes the box, it does not — because a box that
inherited its parent's padding would be unusable.`,
              'What inherits',
              'text',
            ),
            callout(
              'tip',
              'This is why `body { font-family: … }` works',
              'Setting the font once on `body` styles the entire page, because `font-family` inherits all the way down. Setting `padding` on `body` styles only the body. Once you know which list a property is on, both behaviours stop being surprising.',
            ),
            predictCheck(
              `<style>
  #page { color: crimson; border: 2px solid crimson; }
  p     { color: teal; }
</style>
<div id="page">
  <p>Fresh bread, every morning.</p>
</div>`,
              'An id sets both a colour and a border on the wrapper. A type selector sets a colour on the paragraph. Before you check: what colour is the paragraph text, and does it have a border?',
              'The text is **teal**, and there is **no border**. Two separate lessons in one. The colour is teal because inheritance only supplies a value when nothing set the property on the element itself — the id\'s specificity never enters into it, because the id\'s rule is not competing for the paragraph at all, only for the div. And there is no border because `border` does not inherit: only the wrapper has one. If borders inherited, every element inside a bordered box would have its own, which is obviously not what anyone wants.',
            ),
            term(
              '`inherit`',
              'A value you can give any property to force it to take the parent\'s computed value — even for a property that does not normally inherit. `border: inherit` is legal and occasionally useful.',
            ),
            compare(
              'Opting in to inheritance',
              {
                label: 'Deliberate',
                code: `button {
  font-family: inherit;
  font-size: inherit;
}`,
                why: 'Form controls do *not* inherit fonts from the page by default — browsers give them their own. This one rule is why a button suddenly matches the rest of your text, and almost every real stylesheet contains it.',
              },
              {
                label: 'Fighting it instead',
                code: `button {
  font-family: system-ui, sans-serif;
  font-size: 1rem;
}`,
                why: 'Works today, and now the button has its own copy of the value. Change the page font later and the buttons quietly stop matching.',
              },
            ),
            demo('Inheritance versus a direct rule', 'The same nesting, three times.', [
              {
                label: 'Inherited',
                code: '<style>\n  .card { color: rebeccapurple }\n</style>\n<div class="card"><p>Fresh bread, every morning.</p></div>',
                note: 'Nothing sets a colour on the paragraph, so it inherits from the card.',
              },
              {
                label: 'Direct rule wins',
                code: '<style>\n  #page .card { color: rebeccapurple }\n  p { color: teal }\n</style>\n<div id="page"><div class="card"><p>Fresh bread, every morning.</p></div></div>',
                note: 'An id-and-class selector on the ancestor loses to a bare type selector on the element. Inheritance is not in the contest.',
              },
              {
                label: 'Boxes do not inherit',
                code: '<style>\n  .card { border: 2px solid teal; padding: 1rem }\n</style>\n<div class="card"><p>Fresh bread, every morning.</p></div>',
                note: 'The card has a border and padding. The paragraph inside has neither — box properties stop where they are set.',
              },
            ]),
            detail(
              'The four keywords every property accepts',
              '`inherit` takes the parent\'s value. `initial` resets to the property\'s specification default, which is often not what a browser stylesheet gives you — `display: initial` is `inline`, not `block`. `unset` behaves as `inherit` for inherited properties and `initial` for the rest, which makes it the most useful of the four. `revert` rolls back to the browser\'s own stylesheet, which is the one you want when undoing your own reset.',
            ),
            recap(
              [
                'Text properties inherit; box properties do not.',
                'An inherited value only applies when nothing set the property on the element itself.',
                'Inheritance is not part of specificity — any direct rule beats any inherited value.',
                '`inherit` opts in deliberately, and is how form controls are made to match the page.',
              ],
              'Next: the Level 1 milestone.',
            ),
            activeRecap(
              [
                'Give three properties that inherit and three that do not.',
                'Why does a bare `p { color: teal }` beat `#page { color: crimson }` on a paragraph inside `#page`?',
                'What does `font-family: inherit` on a button fix?',
              ],
              [
                'Inherit: `color`, `font-family`, `line-height`, `text-align`. Do not: `margin`, `padding`, `border`, `background`, `width`, `display`.',
                'Because the id rule applies to the *wrapper*, not the paragraph. Its value only reaches the paragraph by inheritance, and inheritance supplies a value only when nothing set the property directly. The type selector does set it, so it wins — specificity never enters into it.',
                'Form controls do not inherit fonts from the page; browsers give them their own. `inherit` makes the button follow the page font, and keeps following it if the page font changes later.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-inheritance-guided',
              kind: 'guided',
              title: 'Set the page font once',
              brief:
                'Set `font-family` and `color` **once** on `body` so that every piece of text on the page picks them up by inheritance. Then make the button match, using `inherit` rather than repeating the values. Do not add a font or colour to any other selector.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Inheritance</title>
    <style>
    </style>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>Fresh bread, every morning.</p>
    <button type="button">Book a table</button>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Inheritance</title>
    <style>
      body {
        font-family: system-ui, sans-serif;
        color: rebeccapurple;
      }
      button {
        font-family: inherit;
        font-size: inherit;
      }
    </style>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>Fresh bread, every morning.</p>
    <button type="button">Book a table</button>
  </body>
</html>`,
              hints: [
                'One rule on body sets both properties for the whole page.',
                'The heading and paragraph need no rules at all — they inherit.',
                'For the button, write font-family: inherit rather than naming the font again.',
              ],
              requirements: [
                cssSet('body', 'font-family', 'The body sets a font family'),
                cssInherited('p', 'color', 'The paragraph colour is inherited, not set directly'),
                cssInherited('h1', 'font-family', 'The heading font is inherited, not set directly'),
                cssIs('button', 'font-family', 'inherit', 'The button opts in with font-family: inherit'),
              ],
              difficulty: 2,
              xp: 45,
              skill: 'cascade',
            },
            {
              slug: 'css-inheritance-debug',
              kind: 'debug',
              title: 'A rule that never had a chance',
              brief:
                'The author wanted every paragraph in the card to be `rebeccapurple` and used a very specific selector to be sure. It is still teal. Fix it *without* raising specificity any further — remove what is actually beating it.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Inheritance</title>
    <style>
      #page .card { color: rebeccapurple; }
      p { color: teal; }
    </style>
  </head>
  <body>
    <div id="page">
      <div class="card">
        <p>Fresh bread, every morning.</p>
      </div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Inheritance</title>
    <style>
      #page .card { color: rebeccapurple; }
    </style>
  </head>
  <body>
    <div id="page">
      <div class="card">
        <p>Fresh bread, every morning.</p>
      </div>
    </div>
  </body>
</html>`,
              hints: [
                'The specific selector is not losing a specificity contest — it is not in one.',
                'The paragraph has its own colour, so it never inherits anything.',
                'Delete the p rule and the inherited value reaches the paragraph.',
              ],
              requirements: [
                cssIs('p', 'color', 'rebeccapurple', 'The paragraph resolves to rebeccapurple'),
                cssInherited('p', 'color', 'It gets there by inheritance, not a rule of its own'),
                cssNoImportant(),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'cascade',
            },
          ],
          quiz: [
            {
              slug: 'q-css-what-inherits',
              prompt: 'Which of these inherits by default?',
              explanation:
                '`color` inherits, along with the other text properties. Box properties such as padding, border and width do not.',
              options: [
                { label: '`color`', correct: true },
                { label: '`padding`' },
                { label: '`border`' },
                { label: '`width`' },
              ],
              skill: 'cascade',
            },
            {
              slug: 'q-css-inheritance-vs-specificity',
              prompt: 'Why does `p { color: teal }` beat an inherited value from `#page { color: crimson }`?',
              explanation:
                'Inheritance only supplies a value when nothing set the property on the element itself. It is not part of the specificity contest.',
              options: [
                { label: 'Inheritance only applies when nothing sets the property directly', correct: true },
                { label: 'Type selectors beat id selectors' },
                { label: 'The p rule comes later in the file' },
                { label: 'Because `#page` is not a real selector' },
              ],
              skill: 'cascade',
            },
            {
              slug: 'q-css-button-font',
              prompt: 'Why do buttons usually need `font-family: inherit`?',
              explanation:
                'Form controls do not inherit fonts from the page — browsers give them their own — so they must opt in.',
              options: [
                { label: 'Form controls do not inherit fonts by default', correct: true },
                { label: 'Buttons cannot have a font-family set directly' },
                { label: 'It makes the button load faster' },
                { label: 'It is required for accessibility' },
              ],
              skill: 'cascade',
            },
          ],
        },
        {
          slug: 'css-cascade-milestone',
          title: 'Milestone: make the page obey you',
          subtitle: 'Six conflicts, one stylesheet',
          summary:
            'A stylesheet where nothing does what its author intended. Every fault is a cascade fault, and none of them needs a new property.',
          objectives: [
            'Diagnose why a rule is not applying',
            'Repair conflicts without raising specificity',
            'Produce a stylesheet with no `!important` and no id selectors',
          ],
          estimatedMinutes: 24,
          skill: 'cascade',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Work through cascade faults methodically',
              'Repair each without escalating specificity',
              'Explain every change you made',
            ]),
            checklist('When a rule is not applying, check in this order', [
              'Does the selector actually match anything?',
              'Is the property spelled correctly, and the value valid?',
              'Is another rule winning on specificity?',
              'Is another rule winning on source order at equal specificity?',
              'Is there an `!important` anywhere?',
              'Is there an inline `style` attribute on the element?',
              'Does the property even inherit, if you set it on an ancestor?',
            ]),
            callout(
              'tip',
              'Check the cheap things first',
              'The list above is in order of how quickly you can rule each one out. A misspelled property takes five seconds to check and accounts for a surprising share of lost afternoons — checking it before you start reasoning about specificity is not laziness, it is efficiency.',
            ),
            demo('The four ways a rule fails', 'One symptom, four completely different causes.', [
              {
                label: 'Selector never matched',
                code: '<style>\n  .intro { color: teal }\n</style>\n<p class="lead">Fresh bread.</p>',
                note: 'Nothing is wrong with the CSS. The class in the markup is `lead`, not `intro`, so the rule is not in the contest at all.',
              },
              {
                label: 'Invalid value',
                code: '<style>\n  p { color: tealish }\n</style>\n<p>Fresh bread.</p>',
                note: '`tealish` is not a colour, so the declaration is dropped silently. The selector matched perfectly.',
              },
              {
                label: 'Outranked',
                code: '<style>\n  p { color: teal }\n  .card p { color: crimson }\n</style>\n<div class="card"><p>Fresh bread.</p></div>',
                note: 'Both matched, both valid. The more specific one simply won.',
              },
              {
                label: 'Never inherited',
                code: '<style>\n  .card { border: 2px solid teal }\n</style>\n<div class="card"><p>Fresh bread.</p></div>',
                note: 'The author expected the paragraph to get a border too. `border` does not inherit, so it never could.',
              },
            ]),
            recall(
              'Close the page. From memory, write the checklist for diagnosing a rule that is not applying — in order, cheapest check first.',
              [
                'Does the selector match anything at all?',
                'Is the property spelled right and the value valid?',
                'Is another rule winning on specificity?',
                'At equal specificity, is another rule later in the file?',
                'Is there an `!important`?',
                'Is there an inline `style` attribute?',
                'Does the property inherit, if you set it on an ancestor?',
              ],
            ),
            recap(
              [
                'Almost every cascade fault is one of four things: no match, invalid, outranked, or not inherited.',
                'Check the cheap causes before reasoning about specificity.',
                'Repair by lowering the winning selector, not by raising the losing one.',
              ],
              'Next: the box model.',
            ),
            activeRecap(
              [
                'Name the four reasons a valid-looking rule does nothing.',
                'Why repair a conflict by lowering specificity rather than raising it?',
              ],
              [
                'The selector matched nothing; the declaration was invalid and silently dropped; another rule outranked it; or the property was set on an ancestor and does not inherit.',
                'Because raising it is unbounded — every future override has to beat the new high-water mark, and the stylesheet ratchets upwards until only `!important` works. Lowering the winner puts the ceiling back down for everyone.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-cascade-milestone-debug',
              kind: 'debug',
              title: 'Six conflicts, one stylesheet',
              brief:
                'Every intended style is being defeated. Repair the stylesheet so that: the page font is inherited from `body`; every paragraph is `dimgray`; the `.lead` paragraph is `rebeccapurple`; the `.btn` button is `teal` and matches the page font. Remove every `!important`, every id selector and the inline style. No selector may be stronger than a single class.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Cascade milestone</title>
    <style>
      body { font-family: system-ui, sans-serif; }
      p { color: dimgray; }
      #page .lead { color: rebeccapurple; }
      .lead { color: dimgray !important; }
      button { color: crimson; }
      .btn { color: teal; }
    </style>
  </head>
  <body>
    <div id="page">
      <p class="lead" style="color: crimson">Fresh bread, every morning.</p>
      <p>We open at 6am and bake until we sell out.</p>
      <button class="btn" type="button">Book a table</button>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Cascade milestone</title>
    <style>
      body { font-family: system-ui, sans-serif; }
      p { color: dimgray; }
      .lead { color: rebeccapurple; }
      button { color: crimson; font-family: inherit; }
      .btn { color: teal; }
    </style>
  </head>
  <body>
    <div id="page">
      <p class="lead">Fresh bread, every morning.</p>
      <p>We open at 6am and bake until we sell out.</p>
      <button class="btn" type="button">Book a table</button>
    </div>
  </body>
</html>`,
              hints: [
                'Start by deleting the inline style attribute — nothing in the stylesheet can beat it.',
                'The two .lead rules disagree; keep the one that says rebeccapurple and drop the !important.',
                'Remove #page from the selector so no rule is stronger than one class.',
                'The button needs font-family: inherit to pick up the body font.',
              ],
              requirements: [
                cssIs('.lead', 'color', 'rebeccapurple', 'The lead paragraph is rebeccapurple'),
                cssIs('p:not(.lead)', 'color', 'dimgray', 'Ordinary paragraphs are dimgray'),
                cssIs('.btn', 'color', 'teal', 'The button is teal'),
                cssIs('button', 'font-family', 'inherit', 'The button inherits the page font'),
                cssInherited('p', 'font-family', 'Paragraph fonts come from body by inheritance'),
                cssNoImportant(),
                cssSpecificityBudget(
                  SPECIFICITY_ONE_CLASS,
                  'No selector is stronger than a single class',
                ),
              ],
              difficulty: 4,
              xp: 70,
              skill: 'cascade',
            },
          ],
          quiz: [
            {
              slug: 'q-css-diagnose-order',
              prompt: 'A rule looks correct and does nothing. What is the cheapest thing to check first?',
              explanation:
                'Whether the selector matches anything at all, and whether the property is spelled correctly. Both take seconds and account for a large share of lost time.',
              options: [
                { label: 'Whether the selector matches, and whether the property is spelled right', correct: true },
                { label: 'Whether another rule is more specific' },
                { label: 'Whether the browser supports the property' },
                { label: 'Whether the stylesheet loaded' },
              ],
              skill: 'cascade',
            },
            {
              slug: 'q-css-repair-direction',
              prompt: 'Why repair a conflict by lowering the winning selector rather than raising the losing one?',
              explanation:
                'Raising is unbounded: every future override must beat the new high-water mark, until only `!important` works.',
              options: [
                { label: 'Raising ratchets the whole stylesheet upwards without limit', correct: true },
                { label: 'Lower specificity renders faster' },
                { label: 'Raising specificity is invalid CSS' },
                { label: 'There is no difference' },
              ],
              skill: 'cascade',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'css-level-1-milestone',
    kind: 'milestone',
    title: 'Level 1 milestone: The Cascade',
    description:
      'Eight questions on rules, specificity and inheritance. Pass mark 80% — everything later in this course assumes this model.',
    passScore: 0.8,
    xp: 200,
    questions: [
      {
        slug: 'a-css-1-specificity-order',
        prompt: 'Put these in order, weakest first: `.card p`, `p`, `#main p`.',
        explanation: 'Elements, then classes, then ids — compared left to right.',
        options: [
          { label: '`p`, `.card p`, `#main p`', correct: true },
          { label: '`p`, `#main p`, `.card p`' },
          { label: '`.card p`, `p`, `#main p`' },
          { label: 'They are all equal' },
        ],
        skill: 'cascade',
      },
      {
        slug: 'a-css-1-inheritance-loses',
        prompt: 'An ancestor with an id sets `color`. The element itself has a type-selector rule setting `color`. Which applies?',
        explanation:
          'The rule on the element. Inheritance supplies a value only when nothing set the property directly.',
        options: [
          { label: 'The rule on the element itself', correct: true },
          { label: 'The ancestor, because of the id' },
          { label: 'Whichever is later in the file' },
          { label: 'Neither applies' },
        ],
        skill: 'cascade',
      },
      {
        slug: 'a-css-1-invalid-silent',
        prompt: 'What does a browser do with `colour: teal`?',
        explanation: 'Discards that declaration silently and applies the rest of the rule.',
        options: [
          { label: 'Drops that declaration and keeps the rest of the rule', correct: true },
          { label: 'Drops the whole rule' },
          { label: 'Logs an error to the console' },
          { label: 'Treats it as `color`' },
        ],
        skill: 'cascade',
      },
      {
        slug: 'a-css-1-inline-beats',
        prompt: 'What beats a `style` attribute on the element?',
        explanation: 'Only an `!important` declaration in a rule.',
        options: [
          { label: 'An `!important` declaration in a rule', correct: true },
          { label: 'An id selector' },
          { label: 'A rule later in the stylesheet' },
          { label: 'Nothing at all' },
        ],
        skill: 'cascade',
      },
      {
        slug: 'a-css-1-does-not-inherit',
        prompt: 'Which of these does **not** inherit?',
        explanation: 'Box properties such as padding stop where they are set.',
        options: [
          { label: '`padding`', correct: true },
          { label: '`color`' },
          { label: '`font-family`' },
          { label: '`line-height`' },
        ],
        skill: 'cascade',
      },
      {
        slug: 'a-css-1-where-zero',
        prompt: 'What is the specificity of `:where(.card) p`?',
        explanation: '`:where()` always contributes zero, so this scores as a single element selector.',
        options: [
          { label: 'The same as `p`', correct: true },
          { label: 'The same as `.card p`' },
          { label: 'The same as `#card p`' },
          { label: 'Zero for the whole selector' },
        ],
        skill: 'cascade',
      },
      {
        slug: 'a-css-1-tie-break',
        prompt: 'Two rules have identical specificity and set the same property. Which applies?',
        explanation: 'The later one in source order.',
        options: [
          { label: 'The one later in the stylesheet', correct: true },
          { label: 'The one earlier in the stylesheet' },
          { label: 'Neither; it is undefined' },
          { label: 'Both, merged together' },
        ],
        skill: 'cascade',
      },
      {
        slug: 'a-css-1-button-inherit',
        prompt: 'Why does `button { font-family: inherit }` appear in almost every real stylesheet?',
        explanation:
          'Browsers give form controls their own font, so they do not follow the page unless told to.',
        options: [
          { label: 'Form controls do not inherit the page font by default', correct: true },
          { label: 'Buttons cannot be given a font directly' },
          { label: 'It is required by the HTML specification' },
          { label: 'It improves rendering performance' },
        ],
        skill: 'cascade',
      },
    ],
  },
};
