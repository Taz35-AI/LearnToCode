import {
  activeRecap,
  callout,
  checklist,
  code,
  compare,
  cssIs,
  cssNoImportant,
  cssRule,
  cssSpecificityBudget,
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
  SPECIFICITY_ONE_CLASS,
  type LevelSpec,
} from '../types';

/**
 * CSS Level 10 — architecture.
 *
 * The level that decides whether a stylesheet is still workable in a year. Its
 * central claim is deliberately narrow and testable: keep specificity flat and
 * name things after what they are, and the two failure modes that destroy large
 * stylesheets — specificity wars and CSS nobody dares delete — do not start.
 */
export const CSS_LEVEL_10: LevelSpec = {
  slug: 'css-architecture-level',
  title: 'Architecture and Scale',
  subtitle: 'Stylesheets that survive being worked on',
  summary:
    'Two things destroy stylesheets over time: specificity that only ever climbs, and rules nobody can prove are unused. Both are prevented by conventions that cost nothing on day one.',
  outcome:
    'You can structure a stylesheet so that deleting a component deletes its CSS, and no rule needs `!important` to win.',
  accent: 'violet',
  modules: [
    {
      slug: 'css-architecture-module',
      title: 'Naming, layering and scale',
      summary: 'Flat specificity, honest names, and the discipline that makes CSS deletable.',
      estimatedMinutes: 52,
      prerequisites: ['css-motion-module'],
      skills: [{ slug: 'css-architecture', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'css-naming',
          title: 'Naming and flat specificity',
          subtitle: 'Why one class is usually the right answer',
          summary:
            'A convention that keeps almost every selector at one class removes the entire category of bug where a rule cannot be overridden without escalating.',
          objectives: [
            'Name components by what they are',
            'Keep selectors to a single class',
            'Explain why `!important` makes things worse',
          ],
          estimatedMinutes: 17,
          skill: 'css-architecture',
          blocks: [
            pretest(
              'A rule will not override. Adding `!important` fixes it. What has actually happened?',
              [
                'The next override now needs `!important` too — the problem was moved, not solved',
                'The rule became faster',
                'The specificity was reset to zero',
                'Nothing; `!important` is the intended tool for this',
              ],
              'The problem moved. `!important` beats everything below it, so the next person who needs to override that rule has no option left but another `!important` — and after that, nothing. Every escalation removes a rung from the ladder you are standing on. The actual fix is almost always to lower the specificity of the rule that was too strong.',
            ),
            objectives([
              'Apply a naming convention consistently',
              'Keep selectors flat',
              'Diagnose a specificity war',
            ]),
            term(
              'Specificity war',
              'A stylesheet where each override needs to be stronger than the last, ending in `!important` and then in nothing.',
            ),
            code(
              `.card                 the component
.card__title          a part of it
.card--featured       a variant of it

One class of specificity, whatever the nesting depth.
The name says what it is, so the markup and the
stylesheet can be read against each other.`,
              'A naming convention',
              'text',
            ),
            compare(
              'Flat versus nested',
              {
                label: 'Flat — one class',
                code: `.card { }
.card__title { }
.card--featured { }`,
                why: 'Every rule is the same weight, so source order decides and any of them can be overridden by any other. The selector also does not care where the element sits, so the component can be moved.',
              },
              {
                label: 'Nested and specific',
                code: `#main .content .card h2 { }`,
                why: 'Needs an equally deep selector to override, and breaks the moment the component is used outside `#main`. The specificity is 1-2-1 and there is no way down from there except `!important`.',
              },
            ),
            demo('Escalation, and the way out', 'The same override, done twice.', [
              {
                label: 'The war',
                code: '<style>\n  #main .card p { color: crimson; }\n  .note { color: teal; }\n</style>\n<div id="main"><div class="card"><p class="note">Meant to be teal, and is not.</p></div></div>',
                note: 'The `.note` class cannot win: 1-2-1 against 0-1-0. The tempting fix is `!important`.',
              },
              {
                label: 'Escalated',
                code: '<style>\n  #main .card p { color: crimson; }\n  .note { color: teal !important; }\n</style>\n<div id="main"><div class="card"><p class="note">Teal now — at a price.</p></div></div>',
                note: 'It works, and the next override of `.note` has nowhere left to go.',
              },
              {
                label: 'Fixed properly',
                code: '<style>\n  .card p { color: crimson; }\n  .note { color: teal; }\n</style>\n<div id="main"><div class="card"><p class="note">Teal, and still overridable.</p></div></div>',
                note: 'Lower the rule that was too strong. Now source order decides, and everything stays adjustable.',
              },
            ]),
            callout(
              'tip',
              'A budget makes this checkable',
              'Adopt a rule such as "no selector above one class" and it stops being a matter of judgement. Anything that needs to be stronger is a sign the component wants a variant class rather than a deeper selector — which is also the change that makes it reusable.',
            ),
            predictCheck(
              `<style>
  .button { background: teal; }
  a.button { background: crimson; }
</style>
<a href="#" class="button">Link button</a>`,
              'Both rules target the same element and the class rule comes first. Before you check: what colour is it?',
              'Crimson. `a.button` is 0-1-1 against `.button` at 0-1-0, so it wins regardless of order. This is how specificity creeps in without anyone deciding to escalate: adding the element name feels like a clarification rather than an escalation, but it permanently outranks the plain class and every later `.button` override has to account for it.',
            ),
            detail(
              'Why names beat appearances',
              '`.card--featured` still makes sense when the design changes; `.card--yellow` becomes a lie the first time the highlight turns blue, and you are left with `class="card--yellow"` on a blue box. The same reasoning as `--surface` over `--white` in the tokens level, applied to class names: name the role or the meaning, and the name survives redesigns. Utility classes such as `.mt-4` are a deliberate exception — they name exactly what they do and are read as such.',
            ),
            recap(
              [
                'Keep almost every selector at one class.',
                'Name components after what they are, not what they look like.',
                '`!important` moves a problem rather than solving it.',
                'The real fix for "will not override" is lowering the rule that was too strong.',
              ],
              'Next: scale, layering and deletability.',
            ),
            activeRecap(
              [
                'What does `!important` cost, beyond the immediate fix?',
                'Why does `a.button` beat `.button` even when it comes first?',
                'Why is `.card--featured` a better name than `.card--yellow`?',
              ],
              [
                'It removes the last rung of the ladder. Anything that needs to override it must also use `!important`, and after that there is nothing left — so the next override cannot be made at all without editing the original rule.',
                'Specificity is compared before source order. `a.button` is one element plus one class, which outranks one class, so order never gets consulted.',
                'Because the name has to stay true after a redesign. The variant is "featured" whatever colour it ends up being; a name that describes the colour becomes actively misleading the moment the colour changes.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-naming-debug',
              kind: 'debug',
              title: 'End the specificity war',
              brief:
                'The `.note` rule cannot win, so someone reached for `!important`. Fix it properly: replace `#main .card p` with a single class on the card itself — `.card { color: crimson }`, letting the colour inherit down to the paragraph — and remove the `!important` from `.note`. Both rules are then one class, so source order decides and `.note` wins on its own.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Specificity</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      #main .card p { color: crimson; }
      .note { color: teal !important; }
    </style>
  </head>
  <body>
    <div id="main">
      <div class="card">
        <p class="note">This should be teal.</p>
      </div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Specificity</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card { color: crimson; }
      .note { color: teal; }
    </style>
  </head>
  <body>
    <div id="main">
      <div class="card">
        <p class="note">This should be teal.</p>
      </div>
    </div>
  </body>
</html>`,
              hints: [
                'The id selector is what made the first rule unbeatable.',
                'Colour inherits, so the card can set it for everything inside.',
                'Once both rules are one class, source order decides — and .note is second.',
              ],
              requirements: [
                cssNoImportant('No declaration needs !important any more'),
                cssSpecificityBudget(
                  SPECIFICITY_ONE_CLASS,
                  'Every selector is back within a one-class budget',
                ),
                cssIs('.note', 'color', 'teal', 'The note rule now wins on its own'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'css-architecture',
            },
          ],
          quiz: [
            {
              slug: 'q-css-important-escalation',
              prompt: 'What does adding `!important` cost?',
              explanation: 'The next override needs one too, and after that there is nothing left.',
              options: [
                { label: 'The next override has nowhere left to escalate to', correct: true },
                { label: 'Rendering performance' },
                { label: 'Nothing at all' },
                { label: 'It disables inheritance' },
              ],
              skill: 'css-architecture',
            },
            {
              slug: 'q-css-flat-selectors',
              prompt: 'Why keep selectors to a single class?',
              explanation: 'Equal weight means source order decides, so anything can override anything.',
              options: [
                { label: 'Equal weight lets source order decide, so overriding stays possible', correct: true },
                { label: 'Shorter selectors parse faster' },
                { label: 'Browsers ignore deeper selectors' },
                { label: 'It makes rules inherit' },
              ],
              skill: 'css-architecture',
            },
            {
              slug: 'q-css-name-meaning',
              prompt: 'Which class name will still be true after a redesign?',
              explanation: 'A name describing the role, not the appearance.',
              options: [
                { label: '`.card--featured`', correct: true },
                { label: '`.card--yellow`' },
                { label: '`.card--big-text`' },
                { label: '`.card--rounded`' },
              ],
              skill: 'css-architecture',
            },
          ],
        },
        {
          slug: 'css-scale',
          title: 'Scale and deletability',
          subtitle: 'CSS nobody is afraid to remove',
          summary:
            'The second thing that kills a stylesheet is uncertainty: rules nobody can prove are unused, so nobody removes them, so the file only grows.',
          objectives: [
            'Structure a stylesheet so components are self-contained',
            'Use `@layer` to order concerns without specificity',
            'Explain what makes a rule safe to delete',
          ],
          estimatedMinutes: 18,
          skill: 'css-architecture',
          blocks: [
            pretest(
              'A stylesheet has grown to 6,000 lines and nobody deletes anything. What is the underlying cause?',
              [
                'No one can prove a rule is unused, so removing it feels risky',
                'CSS files cannot be split',
                'Deleting CSS breaks the cascade',
                'The file is too large to edit',
              ],
              'Nobody can prove a rule is unused. If a selector might match something, somewhere, in a template nobody has read, then deleting it is a gamble and leaving it is free — so it stays. Every convention in this lesson exists to make that proof easy: if a component owns its own file and its own class prefix, deleting the component deletes its CSS with certainty.',
            ),
            objectives([
              'Give each component its own scope',
              'Order concerns with `@layer`',
              'Recognise what makes CSS safe to remove',
            ]),
            term(
              'Cascade layer',
              'A named group declared with `@layer`. Every rule in an earlier layer loses to every rule in a later one, whatever their specificity.',
            ),
            workedExample(
              'A stylesheet you can still work on in a year',
              'Four conventions, each preventing a specific failure.',
              [
                {
                  title: 'One component, one prefix, one place',
                  code: `/* card.css — everything .card, nothing else */
.card { }
.card__title { }
.card--featured { }`,
                  reasoning:
                    'The proof of deletability: remove the component from the markup, delete this file, and nothing else can possibly be affected — because nothing else uses the prefix. That certainty is the whole point.',
                },
                {
                  title: 'Order concerns with layers, not with strength',
                  code: `@layer reset, base, components, utilities;

@layer components { .card { padding: 1rem; } }
@layer utilities  { .p-0 { padding: 0; } }`,
                  reasoning:
                    'A utility beats a component because `utilities` is declared later, not because it is more specific. This is the mechanism that lets a zero-specificity utility win without `!important` — the one honest way to make a weak selector beat a strong one.',
                },
                {
                  title: 'Keep the reset at zero specificity',
                  code: `@layer reset {
  :where(h1, h2, h3) { margin-block: 0; }
}`,
                  reasoning:
                    '`:where()` always contributes zero specificity, so nothing ever has to fight the reset. A reset that needs overriding is a reset that was written too strongly.',
                },
                {
                  title: 'Let the tokens be the shared surface',
                  code: `:root { --space: 1rem; }
.card { padding: var(--space); }
.panel { padding: var(--space); }`,
                  reasoning:
                    'Components share values rather than sharing rules. Nothing couples `.card` to `.panel`, so either can be deleted alone — which would not be true if they shared a `.card, .panel` selector.',
                },
              ],
            ),
            demo('Layers beat specificity', 'The utility is weaker and still wins.', [
              {
                label: 'Without layers',
                code: '<style>\n  .card { padding: 2rem; }\n  .p-0 { padding: 0; }\n</style>\n<div class="card p-0">Both are one class, so source order decides — the utility happens to win.</div>',
                note: 'It works here only because the utility was written second. Move it and it silently loses.',
              },
              {
                label: 'With layers',
                code: '<style>\n  @layer components, utilities;\n  @layer utilities { .p-0 { padding: 0; } }\n  @layer components { .card { padding: 2rem; } }\n</style>\n<div class="card p-0">The utility wins even though it is written first.</div>',
                note: 'The layer order decides, so the file order no longer matters. This is the guarantee `!important` was being misused to provide.',
              },
            ]),
            callout(
              'warning',
              'Layers invert what you expect from specificity',
              'A one-class rule in a later layer beats an id selector in an earlier one. That is the point — but it does mean the first question when a rule mysteriously loses is "which layer is it in", not "how specific is it". Declare the layer order once, at the top, so the answer is always visible.',
            ),
            selfExplain(
              'What makes a rule safe to delete? Answer as if writing the team convention.',
              'A rule is safe to delete when you can prove nothing uses it, and that proof has to be cheap or nobody will do it. Three things make it cheap. First, a unique prefix: if every selector in the file starts `.card`, then searching the templates for `card` finds every use, and no other component can be relying on it accidentally. Second, no shared selectors — the moment a rule reads `.card, .panel`, deleting the card means reading the panel too, and the coupling is invisible from either side. Third, no reliance on ambient context: a rule written `#main .card p` might be depended on by anything that ever appears inside `#main`, so its blast radius is the whole page. Flat, prefixed, self-contained rules make deletion a local decision, and a stylesheet where deletion is local is one that stops growing.',
            ),
            checklist('Architecture review', [
              'Almost every selector is one class',
              'No `!important` outside a reduced-motion or print override',
              'Component names describe what they are, not how they look',
              'Each component owns a prefix and a place',
              'Layer order declared once, near the top',
              'Reset written with `:where()` so it never needs overriding',
              'Shared values live in tokens, not in shared selectors',
            ]),
            recap(
              [
                'A stylesheet stops growing when deleting from it is provably safe.',
                'Prefix and isolate components so deletion is a local decision.',
                '`@layer` orders concerns without touching specificity.',
                '`:where()` keeps a reset at zero specificity.',
              ],
              'Next: the Level 10 milestone.',
            ),
            activeRecap(
              [
                'What does `@layer` let you do that specificity cannot?',
                'Why does `:where()` suit a reset?',
                'Why is a shared `.card, .panel` selector a liability?',
              ],
              [
                'Make a weak selector beat a strong one deliberately and predictably. A later layer beats an earlier one whatever the specificity, which is the guarantee people reach for `!important` to get.',
                'It contributes zero specificity, so every author rule outranks it automatically and nobody ever has to fight the reset.',
                'Because it couples two components invisibly. Deleting one means auditing the other, so deletion stops being a local decision — and that is exactly the uncertainty that makes stylesheets grow forever.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-layers-guided',
              kind: 'guided',
              title: 'Order concerns with layers',
              brief:
                'Declare `@layer components, utilities;` at the top. Put the existing `.card` rule inside a `@layer components` block, and the `.p-0` rule inside a `@layer utilities` block — with the utilities block written *first* in the file, to prove the layer order rather than source order is deciding.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Layers</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .p-0 { padding: 0; }
      .card { padding: 2rem; background: #f4f4f4; }
    </style>
  </head>
  <body>
    <div class="card p-0">No padding, despite the card rule.</div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Layers</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      @layer components, utilities;

      @layer utilities {
        .p-0 { padding: 0; }
      }

      @layer components {
        .card { padding: 2rem; background: #f4f4f4; }
      }
    </style>
  </head>
  <body>
    <div class="card p-0">No padding, despite the card rule.</div>
  </body>
</html>`,
              hints: [
                'The @layer declaration lists the order once, before the blocks.',
                'Later in the list means it wins.',
                'Wrap each existing rule in its layer block without changing the rule itself.',
              ],
              requirements: [
                cssIs('.card', 'padding', '0', 'The utility wins on layer order, not source order'),
                cssIs('.card', 'background', '#f4f4f4', 'The component rule still applies'),
                cssNoImportant('The layer order does the work, not !important'),
                cssSpecificityBudget(
                  SPECIFICITY_ONE_CLASS,
                  'No selector needed to be made stronger',
                ),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'css-architecture',
            },
          ],
          quiz: [
            {
              slug: 'q-css-layer-order',
              prompt: 'A rule in an earlier layer versus a rule in a later layer — which wins?',
              explanation: 'The later layer, whatever the specificity of either rule.',
              options: [
                { label: 'The later layer, regardless of specificity', correct: true },
                { label: 'The more specific rule' },
                { label: 'Whichever comes later in the file' },
                { label: 'The earlier layer' },
              ],
              skill: 'css-architecture',
            },
            {
              slug: 'q-css-where-reset',
              prompt: 'Why write a reset with `:where()`?',
              explanation: 'It contributes zero specificity, so nothing ever has to fight it.',
              options: [
                { label: 'It contributes zero specificity', correct: true },
                { label: 'It is faster to match' },
                { label: 'It applies only to the first match' },
                { label: 'It creates a new layer' },
              ],
              skill: 'css-architecture',
            },
            {
              slug: 'q-css-deletable',
              prompt: 'What makes a rule safe to delete?',
              explanation: 'A unique prefix and no shared selectors, so its use can be proved.',
              options: [
                { label: 'You can prove nothing else uses it', correct: true },
                { label: 'It is short' },
                { label: 'It has low specificity' },
                { label: 'It is at the end of the file' },
              ],
              skill: 'css-architecture',
            },
          ],
        },
        {
          slug: 'css-architecture-milestone',
          title: 'Milestone: a stylesheet built to last',
          subtitle: 'Flat, layered, named and deletable',
          summary: 'The conventions from this level applied together.',
          objectives: [
            'Keep every selector within a one-class budget',
            'Order concerns with layers',
            'Name components honestly',
          ],
          estimatedMinutes: 18,
          skill: 'css-architecture',
          masteryThreshold: 0.8,
          blocks: [
            objectives(['Apply the whole convention set to one small stylesheet']),
            code(
              `@layer reset, base, components, utilities;

:where(...)        reset, zero specificity
.card              one class, always
.card__title       a part
.card--featured    a variant
--space            shared values live here
!important         only for a reader-facing override`,
              'The convention, in full',
              'text',
            ),
            recall(
              'From memory: what does each convention prevent?',
              [
                'One class per selector — prevents specificity wars, because equal weight means order decides.',
                'A prefix per component — prevents undeletable CSS, because use can be proved by searching.',
                '`@layer` — prevents `!important`, by letting a weak rule beat a strong one deliberately.',
                '`:where()` in the reset — prevents fighting your own baseline.',
                'Role-based names — prevents names that lie after a redesign.',
                'Tokens rather than shared selectors — prevents invisible coupling between components.',
              ],
            ),
            recap(
              [
                'Every convention here buys back a specific future problem.',
                'Flat specificity keeps overriding possible.',
                'Provable deletability keeps the file from growing forever.',
              ],
              'Next: the developer tools.',
            ),
            activeRecap(
              ['Which single convention would you keep if you could only have one, and why?'],
              [
                'Flat specificity — almost every selector at one class. It is the one that keeps every other decision reversible: as long as nothing has escalated, any rule can be overridden by any other and mistakes stay cheap to fix. Deletability is the more valuable property in the long run, but it is unachievable in a stylesheet that has already gone to war with itself.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-architecture-milestone-challenge',
              kind: 'challenge',
              title: 'Restructure a small stylesheet',
              brief:
                'Rewrite this to the convention. Declare `@layer components, utilities;`. Replace `#main .card h2` with a `.card__title` class — adding the class to the markup — and `.card.yellow` with `.card--featured`. Put component rules in the components layer and `.p-0` in the utilities layer. Remove every `!important`, and keep every selector within a one-class budget.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Architecture</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      #main .card h2 { font-size: 1.5rem; }
      .card.yellow { border-left: 4px solid crimson; }
      .p-0 { padding: 0 !important; }
      .card { padding: 1rem; background: #f4f4f4; }
    </style>
  </head>
  <body>
    <div id="main">
      <div class="card yellow">
        <h2>Sourdough</h2>
      </div>
      <div class="card p-0">Flush</div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Architecture</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      @layer components, utilities;

      @layer components {
        .card { padding: 1rem; background: #f4f4f4; }
        .card__title { font-size: 1.5rem; }
        .card--featured { border-left: 4px solid crimson; }
      }

      @layer utilities {
        .p-0 { padding: 0; }
      }
    </style>
  </head>
  <body>
    <div id="main">
      <div class="card card--featured">
        <h2 class="card__title">Sourdough</h2>
      </div>
      <div class="card p-0">Flush</div>
    </div>
  </body>
</html>`,
              hints: [
                'The heading needs a class in the markup before the selector can use one.',
                'A variant is a class on the same element, not a second class chained in the selector.',
                'Once .p-0 is in the utilities layer it no longer needs !important.',
                'Declare the layer order once, before the blocks.',
              ],
              requirements: [
                cssNoImportant('Nothing needs !important once the layers are in place'),
                cssSpecificityBudget(
                  SPECIFICITY_ONE_CLASS,
                  'Every selector is within the one-class budget',
                ),
                cssRule('.card__title', 'The heading is targeted by its own class'),
                cssRule('.card--featured', 'The variant is named after what it is'),
                cssIs('.card__title', 'font-size', '1.5rem', 'The title rule still applies'),
                cssIs('.p-0', 'padding', '0', 'The utility still wins, now by layer order'),
              ],
              difficulty: 4,
              xp: 75,
              skill: 'css-architecture',
            },
          ],
          quiz: [
            {
              slug: 'q-css-variant-class',
              prompt: 'How is a variant applied, in this convention?',
              explanation: 'As a second class on the same element — `.card .card--featured` in the markup.',
              options: [
                { label: 'A second class on the element, styled by its own one-class rule', correct: true },
                { label: 'A chained selector such as `.card.featured`' },
                { label: 'An id on the element' },
                { label: 'An `!important` override' },
              ],
              skill: 'css-architecture',
            },
            {
              slug: 'q-css-arch-goal',
              prompt: 'What is the practical goal of a CSS architecture?',
              explanation:
                'That overriding stays possible and deleting stays provably safe — the two things that fail at scale.',
              options: [
                { label: 'Overriding stays possible and deleting stays provably safe', correct: true },
                { label: 'The smallest possible file' },
                { label: 'The fewest possible classes' },
                { label: 'Matching the designer’s folder structure' },
              ],
              skill: 'css-architecture',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'css-level-10-milestone',
    kind: 'milestone',
    title: 'Level 10 milestone: Architecture and Scale',
    description: 'Six questions on naming, specificity, layers and deletability. Pass mark 75%.',
    passScore: 0.75,
    xp: 190,
    questions: [
      {
        slug: 'a-css-10-important',
        prompt: 'A rule will not override. What is usually the right fix?',
        explanation: 'Lower the specificity of the rule that was too strong.',
        options: [
          { label: 'Lower the specificity of the rule that was too strong', correct: true },
          { label: 'Add `!important`' },
          { label: 'Add an id to the selector' },
          { label: 'Move the rule to the end of the file' },
        ],
        skill: 'css-architecture',
      },
      {
        slug: 'a-css-10-layer-beats',
        prompt: 'A one-class rule in `utilities` versus an id rule in `components`, with utilities declared last. Which wins?',
        explanation: 'The utility. Layer order is consulted before specificity.',
        options: [
          { label: 'The one-class rule in `utilities`', correct: true },
          { label: 'The id rule, because ids are stronger' },
          { label: 'Whichever appears later in the file' },
          { label: 'Neither; the conflict is an error' },
        ],
        skill: 'css-architecture',
      },
      {
        slug: 'a-css-10-where',
        prompt: 'What does `:where()` contribute to specificity?',
        explanation: 'Zero, always.',
        options: [
          { label: 'Zero', correct: true },
          { label: 'One class' },
          { label: 'One id' },
          { label: 'The same as its most specific argument' },
        ],
        skill: 'css-architecture',
      },
      {
        slug: 'a-css-10-prefix',
        prompt: 'Why give each component a unique class prefix?',
        explanation: 'So its use can be proved by searching, which makes deletion safe.',
        options: [
          { label: 'So you can prove where it is used, and delete it safely', correct: true },
          { label: 'To reduce file size' },
          { label: 'To raise its specificity' },
          { label: 'Because CSS requires unique names' },
        ],
        skill: 'css-architecture',
      },
      {
        slug: 'a-css-10-shared-selector',
        prompt: 'What is the problem with a shared `.card, .panel` selector?',
        explanation: 'It couples two components invisibly, so neither can be deleted locally.',
        options: [
          { label: 'It couples the two components, so neither can be changed alone', correct: true },
          { label: 'Comma selectors are slower' },
          { label: 'It doubles the specificity' },
          { label: 'Only one of the two will match' },
        ],
        skill: 'css-architecture',
      },
      {
        slug: 'a-css-10-name-role',
        prompt: 'Why name a modifier after its role rather than its appearance?',
        explanation: 'The name has to stay true after a redesign.',
        options: [
          { label: 'The name stays true when the design changes', correct: true },
          { label: 'Role names are shorter' },
          { label: 'Appearance names are invalid' },
          { label: 'It changes the specificity' },
        ],
        skill: 'css-architecture',
      },
    ],
  },
};
