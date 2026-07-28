import {
  activeRecap,
  callout,
  checklist,
  code,
  cssIs,
  cssVariable,
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
 * CSS Level 7 — custom properties.
 *
 * Placed after the layout levels because a design token system is only
 * meaningful once there is something to tokenise, and because custom properties
 * are the first topic that rewards understanding the cascade properly — they
 * inherit, and that is the whole point of them.
 */
export const CSS_LEVEL_07: LevelSpec = {
  slug: 'css-custom-properties',
  title: 'Custom Properties',
  subtitle: 'Design tokens that live in the cascade',
  summary:
    'Custom properties are not variables in the ordinary sense: they inherit, they can be overridden per component, and they are resolved at use rather than at definition. That is what makes theming possible.',
  outcome:
    'You can build a token system and re-theme a component by overriding a property on one selector.',
  accent: 'violet',
  modules: [
    {
      slug: 'css-tokens',
      title: 'Custom properties and tokens',
      summary: 'Declaring, inheriting, scoping and overriding values by name.',
      estimatedMinutes: 50,
      prerequisites: ['css-responsive-module'],
      skills: [{ slug: 'custom-properties', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'css-declaring-tokens',
          title: 'Declaring and using tokens',
          subtitle: 'Why a custom property is not a variable',
          summary:
            'A preprocessor variable is substituted once at build time. A custom property lives in the cascade, inherits, and can be changed at runtime — which is a completely different tool.',
          objectives: [
            'Declare and use a custom property',
            'Explain why they inherit',
            'Use a fallback value',
          ],
          estimatedMinutes: 15,
          skill: 'custom-properties',
          blocks: [
            pretest(
              '`:root { --brand: teal }` and `.card { --brand: crimson }`. A button inside `.card` uses `color: var(--brand)`. What colour is it?',
              [
                'Crimson — the nearest ancestor that sets it wins, by inheritance',
                'Teal — `:root` is more authoritative',
                'Neither; a property cannot be redefined',
                'Whichever was declared later in the file',
              ],
              'Crimson. Custom properties inherit exactly like `color` does, so the value a `var()` sees is whatever the nearest ancestor set. That is the entire basis of theming in modern CSS: override one property on a wrapper and everything inside it changes, without a single new rule and without touching the components.',
            ),
            objectives([
              'Declare a custom property and read it with `var()`',
              'Explain the consequence of custom properties inheriting',
              'Supply a fallback for a property that may not be set',
            ]),
            term(
              'Custom property',
              'A property whose name begins with two hyphens, holding any value. Read it back with `var(--name)`.',
            ),
            code(
              `:root {
  --brand: teal;
  --space: 1rem;
  --radius: 0.5rem;
}

.card {
  padding: var(--space);
  border-radius: var(--radius);
  border: 1px solid var(--brand);
}

var(--missing, 1rem)     use 1rem if --missing is not set
var(--a, var(--b, 0))    fallbacks can nest`,
              'Declaring and using',
            ),
            callout(
              'note',
              '`:root` is just the `<html>` element',
              'It is written `:root` rather than `html` by convention, because it carries slightly more specificity and signals intent — these are document-wide tokens, not styles for the html element. Anything declared there inherits to every element on the page.',
            ),
            demo('Tokens, and overriding them', 'The same components, re-themed by one declaration.', [
              {
                label: 'Global tokens',
                code: '<style>\n  :root { --brand: teal; --space: 1rem; }\n  .card { border: 2px solid var(--brand); padding: var(--space); }\n</style>\n<div class="card">Sourdough</div>',
                note: 'One place defines the values; the component reads them by name.',
              },
              {
                label: 'Scoped override',
                code: '<style>\n  :root { --brand: teal; --space: 1rem; }\n  .card { border: 2px solid var(--brand); padding: var(--space); }\n  .featured { --brand: crimson; --space: 2rem; }\n</style>\n<div class="card">Sourdough</div>\n<div class="card featured">Rye — featured</div>',
                note: 'The featured card redefines the tokens for itself. The `.card` rule is untouched and does not know a variant exists.',
              },
              {
                label: 'Fallback',
                code: '<style>\n  .card { padding: var(--space, 1rem); border: 2px solid var(--brand, dimgray); }\n</style>\n<div class="card">No tokens defined at all — the fallbacks apply.</div>',
                note: 'A component that works standalone and picks up tokens when they exist.',
              },
            ]),
            predictCheck(
              `<style>
  .card { --brand: teal; }
  .button { color: var(--brand); }
</style>
<div class="card">Inside the card</div>
<button class="button">Outside it</button>`,
              'The token is declared on `.card`, and the button is a sibling rather than a child. Before you check: what colour is the button?',
              'It has no colour from that rule at all — `var(--brand)` resolves to nothing, so the `color` declaration is invalid and dropped, and the button falls back to its inherited or default colour. Custom properties reach *descendants* only, exactly like inheritance. This is the commonest mistake with tokens: declaring them on a component and then trying to use them from a sibling. Document-wide tokens belong on `:root`.',
            ),
            detail(
              'Why they are resolved at use, not at definition',
              'A preprocessor variable is replaced by its value when the stylesheet is compiled — after that the variable does not exist. A custom property is live: the browser looks it up each time the `var()` is evaluated, for each element. That is why one override on an ancestor re-themes everything below it, why a media query can change a token and every component follows, and why JavaScript can change a theme by setting a single property. None of that is possible with a compile-time variable.',
            ),
            recap(
              [
                'A custom property starts with `--` and is read with `var()`.',
                'They inherit, so a value set on an ancestor reaches every descendant.',
                'Overriding one on a wrapper re-themes everything inside it.',
                '`var(--name, fallback)` keeps a component working when the token is absent.',
              ],
              'Next: building a token system.',
            ),
            activeRecap(
              [
                'What makes a custom property different from a preprocessor variable?',
                'Where do document-wide tokens belong, and why?',
                'What happens when `var()` refers to a property that is not set and there is no fallback?',
              ],
              [
                'It lives in the cascade and is resolved each time it is used, so it inherits and can be overridden per element or changed at runtime. A preprocessor variable is substituted once at build time and then no longer exists.',
                'On `:root`, because custom properties only reach descendants — and everything on the page is a descendant of the root element.',
                'The whole declaration is invalid and dropped, so the property falls back to its inherited or initial value. Nothing warns you.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-tokens-guided',
              kind: 'guided',
              title: 'Build a small token set',
              brief:
                'Declare `--brand: teal`, `--space: 1rem` and `--radius: 0.5rem` on `:root`, then use all three in the `.card` rule for its border colour, padding and border radius.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tokens</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card { border-style: solid; border-width: 2px; }
    </style>
  </head>
  <body>
    <div class="card">Sourdough workshop</div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tokens</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root {
        --brand: teal;
        --space: 1rem;
        --radius: 0.5rem;
      }

      .card {
        border-style: solid;
        border-width: 2px;
        border-color: var(--brand);
        padding: var(--space);
        border-radius: var(--radius);
      }
    </style>
  </head>
  <body>
    <div class="card">Sourdough workshop</div>
  </body>
</html>`,
              hints: [
                'Custom property names start with two hyphens.',
                ':root is where document-wide tokens belong.',
                'Read them back with var(--name).',
              ],
              requirements: [
                cssVariable('.card', '--brand', 'The brand token reaches the card'),
                cssVariable('.card', '--space', 'The spacing token reaches the card'),
                cssIs('.card', 'border-color', 'teal', 'The border colour resolves from the token'),
                cssIs('.card', 'padding', '1rem', 'The padding resolves from the token'),
                cssIs('.card', 'border-radius', '0.5rem', 'The radius resolves from the token'),
              ],
              difficulty: 2,
              xp: 45,
              skill: 'custom-properties',
            },
          ],
          quiz: [
            {
              slug: 'q-css-token-inherits',
              prompt: 'Do custom properties inherit?',
              explanation: 'Yes — which is what makes scoped overrides and theming work.',
              options: [
                { label: 'Yes, like `color` does', correct: true },
                { label: 'No, they are global only' },
                { label: 'Only inside `:root`' },
                { label: 'Only if declared with `inherit`' },
              ],
              skill: 'custom-properties',
            },
            {
              slug: 'q-css-var-fallback',
              prompt: 'What does `var(--space, 1rem)` do when `--space` is not defined?',
              explanation: 'Uses the fallback of 1rem.',
              options: [
                { label: 'Uses 1rem', correct: true },
                { label: 'Drops the declaration' },
                { label: 'Throws an error' },
                { label: 'Uses zero' },
              ],
              skill: 'custom-properties',
            },
            {
              slug: 'q-css-token-scope',
              prompt: 'A token declared on `.card` — which elements can read it?',
              explanation: '`.card` and its descendants only. Siblings cannot see it.',
              options: [
                { label: '`.card` and its descendants', correct: true },
                { label: 'Every element on the page' },
                { label: 'Only `.card` itself' },
                { label: 'Its siblings as well' },
              ],
              skill: 'custom-properties',
            },
          ],
        },
        {
          slug: 'css-theming',
          title: 'Theming with tokens',
          subtitle: 'One override, a whole new appearance',
          summary:
            'A theme is not a second stylesheet. It is the same stylesheet with different token values, which is why the approach scales.',
          objectives: [
            'Re-theme a component by scoping tokens',
            'Build a dark theme without duplicating rules',
            'Respect a system colour-scheme preference',
          ],
          estimatedMinutes: 17,
          skill: 'custom-properties',
          blocks: [
            pretest(
              'You need a dark theme. Which approach scales best?',
              [
                'Redefine the same token names under a `[data-theme="dark"]` selector',
                'Write a second stylesheet with every rule duplicated',
                'Add a `.dark` class to every component and style each one',
                'Use `filter: invert(1)` on the whole page',
              ],
              'Redefine the tokens. Every component already reads its colours by name, so changing what those names mean changes everything at once — no rule is duplicated and no component knows a theme exists. The other approaches all scale with the number of components rather than the number of themes, which is the wrong direction.',
            ),
            objectives([
              'Scope tokens to create a variant',
              'Implement a theme with one block of overrides',
              'Honour `prefers-color-scheme`',
            ]),
            workedExample(
              'Adding a dark theme without touching a single component',
              'The whole technique, in four steps.',
              [
                {
                  title: 'Components must read colours by name',
                  code: `.card {
  background: var(--surface);
  color: var(--text);
  border: 1px solid var(--border);
}`,
                  reasoning:
                    'Nothing here is a literal colour. This is the step that makes everything after it possible, and it is the one that has to be done before a theme is ever contemplated.',
                },
                {
                  title: 'Define the default theme once',
                  code: `:root {
  --surface: white;
  --text: #111;
  --border: #ddd;
}`,
                  reasoning:
                    'These are the light values. Note that the names describe *roles* — surface, text, border — not appearances. A token called `--white` would be a lie the moment a dark theme existed.',
                },
                {
                  title: 'Override the same names for dark',
                  code: `[data-theme="dark"] {
  --surface: #111;
  --text: #f4f4f4;
  --border: #333;
}`,
                  reasoning:
                    'Three declarations re-theme the entire site. Because the tokens inherit, putting `data-theme="dark"` on `<html>` changes every descendant — and putting it on one panel themes just that panel.',
                },
                {
                  title: 'Follow the system preference by default',
                  code: `@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    --surface: #111;
    --text: #f4f4f4;
    --border: #333;
  }
}`,
                  reasoning:
                    'Respects the choice the reader already made in their operating system, while `:not([data-theme="light"])` still lets an explicit setting win. Someone who has chosen dark everywhere should not have to choose again on your site.',
                },
              ],
            ),
            demo('One token set, two themes', 'The component CSS is identical in both.', [
              {
                label: 'Light',
                code: '<style>\n  :root { --surface: white; --text: #111; --border: #ddd; }\n  .card { background: var(--surface); color: var(--text); border: 1px solid var(--border); padding: 1rem; }\n</style>\n<div class="card">Sourdough workshop</div>',
                note: 'The default token values.',
              },
              {
                label: 'Dark',
                code: '<style>\n  :root { --surface: white; --text: #111; --border: #ddd; }\n  [data-theme="dark"] { --surface: #111; --text: #f4f4f4; --border: #333; }\n  .card { background: var(--surface); color: var(--text); border: 1px solid var(--border); padding: 1rem; }\n</style>\n<div data-theme="dark"><div class="card">Sourdough workshop</div></div>',
                note: 'The `.card` rule has not changed by one character. Three token overrides did all of it.',
              },
              {
                label: 'Scoped to one panel',
                code: '<style>\n  :root { --surface: white; --text: #111; --border: #ddd; }\n  [data-theme="dark"] { --surface: #111; --text: #f4f4f4; --border: #333; }\n  .card { background: var(--surface); color: var(--text); border: 1px solid var(--border); padding: 1rem; margin-bottom: 0.5rem; }\n</style>\n<div class="card">Light card</div>\n<div data-theme="dark"><div class="card">Dark card, same rule</div></div>',
                note: 'Because tokens inherit, a theme can apply to a subtree rather than the whole page — useful for a preview panel or an inverted footer.',
              },
            ]),
            callout(
              'tip',
              'Name tokens after their role, not their appearance',
              '`--surface` and `--text` survive a dark theme. `--white` and `--dark-grey` become actively misleading the moment one exists, and a stylesheet full of `--white: #111` is worse than no tokens at all. The same applies to `--space-4` over `--space-16px`.',
            ),
            selfExplain(
              'A colleague proposes a dark theme as a second stylesheet, loaded instead of the first. Write the case against it — be specific about what happens over the following year.',
              'It doubles every future change. Each new component, each tweak to an existing one, has to be made twice and kept in sync by hand — and the two files drift, because nothing enforces the relationship. Bugs then appear in one theme only, which are the most annoying kind to reproduce. It also cannot do partial theming: a dark footer inside a light page is impossible with a whole-document swap, but trivial when the tokens inherit. And a third theme — high contrast, or a seasonal brand — means a third full copy. The token approach costs one block of overrides per theme regardless of how many components exist, which is the only version of this that scales.',
            ),
            checklist('A workable token system', [
              'Tokens named after their role, not their appearance',
              'Defined once on `:root`',
              'Components read every colour and space through `var()`',
              'A theme is a block of overrides, never a duplicated stylesheet',
              '`prefers-color-scheme` respected by default',
              'An explicit user choice able to override the system preference',
            ]),
            recap(
              [
                'A theme is the same stylesheet with different token values.',
                'Because tokens inherit, a theme can apply to the page or to one subtree.',
                'Name tokens after roles — `--surface`, not `--white`.',
                'Honour `prefers-color-scheme`, and let an explicit choice win over it.',
              ],
              'Next: the Level 7 milestone.',
            ),
            activeRecap(
              [
                'Why does a token-based theme scale where a second stylesheet does not?',
                'Why name a token `--surface` rather than `--white`?',
                'How can a theme apply to only part of a page?',
              ],
              [
                'Because it costs one block of overrides per theme, regardless of how many components exist — whereas a duplicated stylesheet costs double work on every future change and drifts out of sync.',
                'Because the name has to stay true in every theme. `--white: #111` in a dark theme is a lie, and a stylesheet that lies is worse than one with no tokens.',
                'By putting the overriding selector on a wrapper rather than the root. Tokens inherit, so only that subtree sees the new values.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-theme-guided',
              kind: 'guided',
              title: 'Add a dark theme',
              brief:
                'The card already reads its colours from tokens. Define the light values on `:root` — `--surface: white`, `--text: #111`, `--border: #ddd` — and add a `[data-theme="dark"]` block overriding the same three names with `#111`, `#f4f4f4` and `#333`. Do not change the `.card` rule.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Theme</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card {
        background: var(--surface);
        color: var(--text);
        border: 1px solid var(--border);
        padding: 1rem;
      }
    </style>
  </head>
  <body>
    <div class="card">Light card</div>
    <div data-theme="dark">
      <div class="card">Dark card</div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Theme</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root {
        --surface: white;
        --text: #111;
        --border: #ddd;
      }

      [data-theme="dark"] {
        --surface: #111;
        --text: #f4f4f4;
        --border: #333;
      }

      .card {
        background: var(--surface);
        color: var(--text);
        border: 1px solid var(--border);
        padding: 1rem;
      }
    </style>
  </head>
  <body>
    <div class="card">Light card</div>
    <div data-theme="dark">
      <div class="card">Dark card</div>
    </div>
  </body>
</html>`,
              hints: [
                'The light values go on :root so every element inherits them.',
                'The dark block redefines exactly the same three names.',
                'You should not need to touch the .card rule at all.',
              ],
              requirements: [
                cssIs('body > .card', 'background', 'white', 'The light card resolves to the light surface'),
                cssIs('[data-theme="dark"] .card', 'background', '#111', 'The dark card resolves to the dark surface'),
                cssIs('[data-theme="dark"] .card', 'color', '#f4f4f4', 'The dark card text follows the theme'),
                cssVariable('.card', '--border', 'The border token is defined'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'custom-properties',
            },
            {
              slug: 'css-tokens-debug',
              kind: 'debug',
              title: 'Tokens that do not reach',
              brief:
                'Two faults. The tokens are declared on `.theme`, which is a *sibling* of the card rather than an ancestor, so nothing resolves — move them to `:root`. And `--white` is a misleading name in a file that has a dark theme: rename it to `--surface` everywhere it appears.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tokens</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .theme { --white: #fff; --text: #111; }

      .card {
        background: var(--white);
        color: var(--text);
        padding: 1rem;
        border: 1px solid #ddd;
      }
    </style>
  </head>
  <body>
    <div class="theme"></div>
    <div class="card">Sourdough workshop</div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tokens</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root { --surface: #fff; --text: #111; }

      .card {
        background: var(--surface);
        color: var(--text);
        padding: 1rem;
        border: 1px solid #ddd;
      }
    </style>
  </head>
  <body>
    <div class="theme"></div>
    <div class="card">Sourdough workshop</div>
  </body>
</html>`,
              hints: [
                'Custom properties reach descendants only — a sibling cannot see them.',
                ':root is an ancestor of everything.',
                'Rename --white to --surface in both the declaration and the var().',
              ],
              requirements: [
                cssVariable('.card', '--surface', 'The card can read a role-named surface token'),
                cssIs('.card', 'background', '#fff', 'The background resolves from the token'),
                cssIs('.card', 'color', '#111', 'The text colour resolves from the token'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'custom-properties',
            },
          ],
          quiz: [
            {
              slug: 'q-css-theme-approach',
              prompt: 'What is a theme, in a token-based stylesheet?',
              explanation: 'The same rules with different token values — a block of overrides, not a second stylesheet.',
              options: [
                { label: 'A block of token overrides', correct: true },
                { label: 'A duplicate stylesheet' },
                { label: 'A class on every component' },
                { label: 'A filter applied to the page' },
              ],
              skill: 'custom-properties',
            },
            {
              slug: 'q-css-token-naming',
              prompt: 'Why is `--surface` a better token name than `--white`?',
              explanation: 'It stays true in every theme; `--white: #111` in a dark theme is actively misleading.',
              options: [
                { label: 'It describes the role, so it stays true in any theme', correct: true },
                { label: 'It is shorter' },
                { label: 'Colour names are invalid in custom properties' },
                { label: 'It has higher specificity' },
              ],
              skill: 'custom-properties',
            },
            {
              slug: 'q-css-prefers-scheme',
              prompt: 'What does `@media (prefers-color-scheme: dark)` let you do?',
              explanation: 'Follow the choice the reader already made at the operating-system level.',
              options: [
                { label: 'Respect the reader’s system-level preference', correct: true },
                { label: 'Force dark mode on everyone' },
                { label: 'Detect the time of day' },
                { label: 'Change the theme when the page scrolls' },
              ],
              skill: 'custom-properties',
            },
          ],
        },
        {
          slug: 'css-tokens-milestone',
          title: 'Milestone: a themeable component',
          subtitle: 'Tokens, a variant and a theme',
          summary: 'One component, re-themed three ways without duplicating a rule.',
          objectives: [
            'Build a component entirely on tokens',
            'Add a variant by scoping token values',
            'Add a theme by overriding the same names',
          ],
          estimatedMinutes: 18,
          skill: 'custom-properties',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Express a component in tokens',
              'Create a variant with scoped overrides',
              'Create a theme with root overrides',
            ]),
            code(
              `:root        the default values, inherited everywhere
[data-theme] a theme — the same names, different values
.variant     a component variant — scoped to one subtree
var(--x, y)  a fallback, so the component stands alone

Variant and theme use the same mechanism. The only
difference is where the override is scoped.`,
              'The whole system',
              'text',
            ),
            demo('One component, three appearances', 'The `.card` rule is identical in all three.', [
              {
                label: 'Default',
                code: '<style>\n  :root { --surface: #fff; --text: #111; --accent: teal; }\n  .card { background: var(--surface); color: var(--text); border-left: 4px solid var(--accent); padding: 1rem; }\n</style>\n<div class="card">Sourdough</div>',
                note: 'Root tokens.',
              },
              {
                label: 'Variant',
                code: '<style>\n  :root { --surface: #fff; --text: #111; --accent: teal; }\n  .featured { --accent: crimson; }\n  .card { background: var(--surface); color: var(--text); border-left: 4px solid var(--accent); padding: 1rem; }\n</style>\n<div class="card featured">Rye — featured</div>',
                note: 'One token overridden on the element itself.',
              },
              {
                label: 'Theme',
                code: '<style>\n  :root { --surface: #fff; --text: #111; --accent: teal; }\n  [data-theme="dark"] { --surface: #111; --text: #f4f4f4; }\n  .card { background: var(--surface); color: var(--text); border-left: 4px solid var(--accent); padding: 1rem; }\n</style>\n<div data-theme="dark"><div class="card">Seeded</div></div>',
                note: 'The same mechanism scoped to an ancestor instead.',
              },
            ]),
            recall(
              'From memory: what do each of these do, and where does each belong?',
              [
                '`:root { --x: … }` — declares a document-wide token every element inherits.',
                '`var(--x)` — reads it, resolved fresh for each element that uses it.',
                '`var(--x, fallback)` — reads it, with a value to use when it is not set.',
                '`.variant { --x: … }` — overrides it for one element and its descendants.',
                '`[data-theme="dark"] { --x: … }` — overrides it for a whole subtree.',
              ],
            ),
            recap(
              [
                'Variants and themes are the same mechanism at different scopes.',
                'Components should contain no literal colours at all.',
                'Fallbacks let a component work before the tokens exist.',
              ],
              'Next: typography and colour.',
            ),
            activeRecap(
              ['Why is "the component contains no literal colours" the step that makes everything else possible?'],
              [
                'Because every later capability — variants, themes, a high-contrast mode, a per-section accent — works by changing what a name means. If a component hard-codes a colour, none of those can reach it, and the only remaining option is to duplicate the rule. Doing this one thing first is what turns theming from a rewrite into three lines.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-tokens-milestone-challenge',
              kind: 'challenge',
              title: 'Tokens, a variant and a theme',
              brief:
                'Define `--surface: #fff`, `--text: #111` and `--accent: teal` on `:root`. Make `.card` use all three — background, colour, and a `4px` solid left border in the accent. Add a `.featured` variant that overrides `--accent` to `crimson`, and a `[data-theme="dark"]` block overriding `--surface` to `#111` and `--text` to `#f4f4f4`. The `.card` rule must contain no literal colours.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tokens milestone</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card { padding: 1rem; margin-bottom: 0.5rem; }
    </style>
  </head>
  <body>
    <div class="card">Sourdough</div>
    <div class="card featured">Rye — featured</div>
    <div data-theme="dark">
      <div class="card">Seeded</div>
    </div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tokens milestone</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root {
        --surface: #fff;
        --text: #111;
        --accent: teal;
      }

      [data-theme="dark"] {
        --surface: #111;
        --text: #f4f4f4;
      }

      .featured { --accent: crimson; }

      .card {
        background: var(--surface);
        color: var(--text);
        border-left: 4px solid var(--accent);
        padding: 1rem;
        margin-bottom: 0.5rem;
      }
    </style>
  </head>
  <body>
    <div class="card">Sourdough</div>
    <div class="card featured">Rye — featured</div>
    <div data-theme="dark">
      <div class="card">Seeded</div>
    </div>
  </body>
</html>`,
              hints: [
                'Declare the three tokens on :root first.',
                '.featured only needs to override --accent — nothing else.',
                'The theme block overrides --surface and --text on a wrapper.',
                'Every colour in .card should be a var().',
              ],
              requirements: [
                cssIs('body > .card', 'background', '#fff', 'The default card uses the surface token'),
                cssIs('body > .card', 'color', '#111', 'The default card uses the text token'),
                cssIs('.featured', 'border-left', '4px solid crimson', 'The variant overrides only the accent'),
                cssIs('[data-theme="dark"] .card', 'background', '#111', 'The theme changes the surface'),
                cssIs('[data-theme="dark"] .card', 'color', '#f4f4f4', 'The theme changes the text colour'),
              ],
              difficulty: 4,
              xp: 70,
              skill: 'custom-properties',
            },
          ],
          quiz: [
            {
              slug: 'q-css-variant-vs-theme',
              prompt: 'What is the difference between a variant and a theme, mechanically?',
              explanation: 'Only the scope of the override — the mechanism is identical.',
              options: [
                { label: 'Only where the override is scoped', correct: true },
                { label: 'Themes use classes, variants use attributes' },
                { label: 'Variants require duplicated rules' },
                { label: 'Themes cannot use custom properties' },
              ],
              skill: 'custom-properties',
            },
            {
              slug: 'q-css-no-literal-colours',
              prompt: 'Why should a themeable component contain no literal colours?',
              explanation:
                'Every theme, variant and contrast mode works by changing what a token name means — a literal colour is unreachable by all of them.',
              options: [
                { label: 'A literal colour cannot be reached by any theme or variant', correct: true },
                { label: 'Literal colours are slower to render' },
                { label: 'Hex codes are invalid in components' },
                { label: 'It reduces specificity' },
              ],
              skill: 'custom-properties',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'css-level-7-milestone',
    kind: 'milestone',
    title: 'Level 7 milestone: Custom Properties',
    description: 'Six questions on tokens, inheritance and theming. Pass mark 75%.',
    passScore: 0.75,
    xp: 180,
    questions: [
      {
        slug: 'a-css-7-syntax',
        prompt: 'How is a custom property named?',
        explanation: 'It begins with two hyphens.',
        options: [
          { label: 'Beginning with `--`', correct: true },
          { label: 'Beginning with `$`' },
          { label: 'Beginning with `@`' },
          { label: 'Any valid identifier' },
        ],
        skill: 'custom-properties',
      },
      {
        slug: 'a-css-7-resolved-when',
        prompt: 'When is a custom property resolved?',
        explanation: 'Each time it is used, per element — which is why overrides and runtime changes work.',
        options: [
          { label: 'Each time it is used, per element', correct: true },
          { label: 'Once, when the stylesheet is compiled' },
          { label: 'Only on page load' },
          { label: 'When the element is first painted' },
        ],
        skill: 'custom-properties',
      },
      {
        slug: 'a-css-7-sibling-scope',
        prompt: 'A token declared on `.panel` — can a sibling of `.panel` use it?',
        explanation: 'No. Custom properties reach descendants only.',
        options: [
          { label: 'No, only descendants', correct: true },
          { label: 'Yes, they are global' },
          { label: 'Only with `inherit`' },
          { label: 'Only inside a media query' },
        ],
        skill: 'custom-properties',
      },
      {
        slug: 'a-css-7-missing-var',
        prompt: 'What happens to `color: var(--missing)` with no fallback?',
        explanation: 'The declaration is invalid and dropped, silently.',
        options: [
          { label: 'The declaration is dropped silently', correct: true },
          { label: 'The colour becomes black' },
          { label: 'The whole rule is dropped' },
          { label: 'An error is logged' },
        ],
        skill: 'custom-properties',
      },
      {
        slug: 'a-css-7-theme-cost',
        prompt: 'What does adding a second theme cost in a token-based stylesheet?',
        explanation: 'One block of overrides, regardless of how many components there are.',
        options: [
          { label: 'One block of token overrides', correct: true },
          { label: 'A duplicate of every rule' },
          { label: 'A class on every component' },
          { label: 'A second stylesheet file' },
        ],
        skill: 'custom-properties',
      },
      {
        slug: 'a-css-7-root-why',
        prompt: 'Why are document-wide tokens declared on `:root`?',
        explanation: 'It is the ancestor of every element, and custom properties inherit.',
        options: [
          { label: 'Everything on the page is a descendant of it', correct: true },
          { label: 'It is the only place they are valid' },
          { label: 'It makes them non-inheriting' },
          { label: 'It gives them `!important`' },
        ],
        skill: 'custom-properties',
      },
    ],
  },
};
