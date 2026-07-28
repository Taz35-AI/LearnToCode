import {
  activeRecap,
  callout,
  checklist,
  code,
  compare,
  cssIs,
  cssMatches,
  cssMediaRule,
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
 * CSS Level 9 — motion.
 *
 * Two threads run through this level and neither is optional. The first is that
 * only a small set of properties can be animated cheaply, and animating anything
 * else costs a layout pass on every frame. The second is that motion makes some
 * people physically unwell, and `prefers-reduced-motion` is the mechanism they
 * already used to say so.
 */
export const CSS_LEVEL_09: LevelSpec = {
  slug: 'css-motion',
  title: 'Transitions and Motion',
  subtitle: 'Cheap to animate, and safe to animate',
  summary:
    'Motion has two constraints that are not matters of taste: only a few properties animate without forcing layout on every frame, and some readers have told their operating system that motion makes them ill.',
  outcome:
    'You can build transitions and keyframe animations that stay smooth and that honour a reduced-motion preference.',
  accent: 'violet',
  modules: [
    {
      slug: 'css-motion-module',
      title: 'Motion that helps',
      summary: 'Transitions, keyframes, the compositor, and the preference you must respect.',
      estimatedMinutes: 52,
      prerequisites: ['css-type-colour'],
      skills: [{ slug: 'animation', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'css-transitions',
          title: 'Transitions',
          subtitle: 'Interpolating between two states',
          summary:
            'A transition does one thing: when a property changes, take some time over it instead of jumping. Everything else is detail about which properties and how long.',
          objectives: [
            'Write a transition and name the properties explicitly',
            'Choose a duration and an easing that suit the change',
            'Explain why `transition: all` is a poor default',
          ],
          estimatedMinutes: 16,
          skill: 'animation',
          blocks: [
            pretest(
              'A button has `transition: all 0.3s`. Why is that a worse default than naming the properties?',
              [
                'It animates properties you never intended, including expensive ones',
                '`all` is invalid and the transition never runs',
                'It makes the transition twice as slow',
                'Nothing is wrong with it',
              ],
              'It animates everything, including properties you did not think about. Add a `:hover` that changes `width` or `padding` later and you have silently signed up for a layout pass on every frame — plus odd behaviour when unrelated properties change, such as a fade-in of a colour you meant to switch instantly. Naming the properties means the transition only ever does what you asked for.',
            ),
            objectives([
              'Write a transition with explicit properties',
              'Pick a duration in the 150–300ms range and justify it',
              'Explain why easing matters',
            ]),
            term(
              'Transition',
              'An instruction to interpolate a property over time whenever its value changes, rather than switching instantly.',
            ),
            code(
              `.button {
  background: teal;
  transition: background 200ms ease-out;
}
.button:hover { background: darkcyan; }

transition: <property> <duration> <easing> <delay>;
transition: background 200ms ease-out, transform 150ms ease-out;

The transition goes on the *resting* state, not on
:hover — otherwise it only applies on the way in.`,
              'The shape of it',
            ),
            demo('The same hover, three ways', 'Move the pointer over each.', [
              {
                label: 'No transition',
                code: '<style>\n  .button { background: teal; color: #fff; border: 0; padding: 0.6rem 1rem; }\n  .button:hover { background: darkcyan; }\n</style>\n<button class="button">Feed the starter</button>',
                note: 'Instant. Not wrong — but the change is easy to miss.',
              },
              {
                label: 'Transitioned',
                code: '<style>\n  .button { background: teal; color: #fff; border: 0; padding: 0.6rem 1rem; transition: background 200ms ease-out; }\n  .button:hover { background: darkcyan; }\n</style>\n<button class="button">Feed the starter</button>',
                note: 'The eye registers the change without being interrupted by it.',
              },
              {
                label: 'Too slow',
                code: '<style>\n  .button { background: teal; color: #fff; border: 0; padding: 0.6rem 1rem; transition: background 1200ms ease-out; }\n  .button:hover { background: darkcyan; }\n</style>\n<button class="button">Feed the starter</button>',
                note: 'The interface now feels like it is thinking. Anything a user triggers should finish in about 150–300ms.',
              },
            ]),
            compare(
              'Naming properties versus `all`',
              {
                label: 'Explicit',
                code: `.card {
  transition: background 200ms ease-out,
              transform 150ms ease-out;
}`,
                why: 'Only these two properties ever animate. Adding a hover that changes padding next month costs nothing.',
              },
              {
                label: '`transition: all`',
                code: `.card {
  transition: all 200ms ease-out;
}`,
                why: 'Every future property change becomes an animation, including ones that force layout on every frame. The bug appears months later, in a rule that looks innocent.',
              },
            ),
            callout(
              'note',
              'Where the transition declaration belongs',
              'On the resting state — `.button`, not `.button:hover`. Put it on `:hover` and the animation runs on the way in but the element snaps back instantly when the pointer leaves, because there is no transition in force at that point. That asymmetry is occasionally what you want, and almost always a mistake.',
            ),
            detail(
              'Easing, briefly',
              '`linear` moves at a constant rate and reads as mechanical. `ease-out` starts fast and settles — right for things entering or responding to a click, because the response feels immediate. `ease-in` starts slow, which suits things leaving. `ease-in-out` suits movement between two positions. If you only remember one: `ease-out` for anything the user triggered.',
            ),
            predictCheck(
              `<style>
  .box { width: 100px; height: 100px; background: teal; }
  .box:hover { transition: background 400ms; background: crimson; }
</style>
<div class="box"></div>`,
              'The transition is declared inside `:hover`. Before you check: what happens on the way in, and on the way out?',
              'It fades to crimson over 400ms on the way in, then snaps back to teal instantly when the pointer leaves. On the way out the `:hover` rule no longer applies, so the transition declaration is gone with it and there is nothing left to interpolate. Moving the declaration to `.box` makes both directions smooth.',
            ),
            recap(
              [
                'A transition interpolates a property when its value changes.',
                'It belongs on the resting state, not on `:hover`.',
                'Name the properties — `all` animates things you never intended.',
                'User-triggered changes want roughly 150–300ms and `ease-out`.',
              ],
              'Next: keyframes and what is cheap to animate.',
            ),
            activeRecap(
              [
                'Why does the transition declaration belong on the resting state?',
                'What is wrong with `transition: all`?',
                'Roughly how long should a hover or click response take?',
              ],
              [
                'Because it has to be in force in both directions. Declared inside `:hover`, it disappears the moment the pointer leaves, so the element snaps back instantly.',
                'It animates every property that ever changes on that element, including ones added later and ones that are expensive to animate. The resulting bug is far from the code that caused it.',
                'About 150–300ms. Faster is barely perceptible; much slower makes the interface feel like it is deliberating.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-transition-guided',
              kind: 'guided',
              title: 'Transition a button',
              brief:
                'Give `.button` a transition of `background 200ms ease-out` — on the resting state, not on `:hover`. The hover rule already changes the background.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Transition</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .button {
        background: teal;
        color: #fff;
        border: 0;
        padding: 0.6rem 1rem;
      }

      .button:hover { background: darkcyan; }
    </style>
  </head>
  <body>
    <button class="button">Feed the starter</button>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Transition</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .button {
        background: teal;
        color: #fff;
        border: 0;
        padding: 0.6rem 1rem;
        transition: background 200ms ease-out;
      }

      .button:hover { background: darkcyan; }
    </style>
  </head>
  <body>
    <button class="button">Feed the starter</button>
  </body>
</html>`,
              hints: [
                'The transition goes in the .button rule.',
                'Name the property rather than using all.',
                'The order is property, duration, easing.',
              ],
              requirements: [
                cssIs('.button', 'transition', 'background 200ms ease-out', 'The transition names its property'),
                cssIs('.button:hover', 'background', 'darkcyan', 'The hover state still changes the background'),
              ],
              difficulty: 2,
              xp: 45,
              skill: 'animation',
            },
          ],
          quiz: [
            {
              slug: 'q-css-transition-where',
              prompt: 'Where should the `transition` declaration go?',
              explanation: 'On the resting state, so it applies in both directions.',
              options: [
                { label: 'On the resting state', correct: true },
                { label: 'On the `:hover` state' },
                { label: 'On `body`' },
                { label: 'Either; there is no difference' },
              ],
              skill: 'animation',
            },
            {
              slug: 'q-css-transition-all',
              prompt: 'Why avoid `transition: all`?',
              explanation: 'It animates properties you never intended, including expensive ones added later.',
              options: [
                { label: 'It animates properties you never intended', correct: true },
                { label: 'It is invalid CSS' },
                { label: 'It doubles the duration' },
                { label: 'It disables easing' },
              ],
              skill: 'animation',
            },
            {
              slug: 'q-css-duration',
              prompt: 'Roughly how long should a user-triggered transition last?',
              explanation: '150–300ms. Longer and the interface feels slow.',
              options: [
                { label: '150–300ms', correct: true },
                { label: '20–40ms' },
                { label: '1–2 seconds' },
                { label: 'As long as looks pleasing' },
              ],
              skill: 'animation',
            },
          ],
        },
        {
          slug: 'css-keyframes-motion',
          title: 'Keyframes, cost and consent',
          subtitle: 'The compositor, and `prefers-reduced-motion`',
          summary:
            'Two constraints decide most animation questions: which properties the browser can animate without recalculating layout, and whether the reader has asked for less motion.',
          objectives: [
            'Write a keyframe animation',
            'Animate only `transform` and `opacity` where possible',
            'Honour `prefers-reduced-motion`',
          ],
          estimatedMinutes: 18,
          skill: 'animation',
          blocks: [
            pretest(
              'Why animate `transform: translateX()` rather than `left`?',
              [
                'Transform is handled by the compositor, so no layout is recalculated per frame',
                'Transform is newer syntax for the same thing',
                '`left` only works on positioned elements',
                'There is no difference in practice',
              ],
              'Because `transform` and `opacity` can be handled by the compositor — the browser can move or fade an already-painted layer without recalculating layout or repainting. Animating `left`, `width`, `margin` or `top` forces the browser to redo layout on every single frame, for the element and often for everything around it. On a mid-range phone that is the difference between smooth and visibly stuttering.',
            ),
            objectives([
              'Define and apply a `@keyframes` animation',
              'Name the two properties that are cheap to animate',
              'Write a reduced-motion block that actually works',
            ]),
            code(
              `@keyframes fade-up {
  from { opacity: 0; transform: translateY(8px); }
  to   { opacity: 1; transform: none; }
}

.panel {
  animation: fade-up 250ms ease-out;
}

animation: <name> <duration> <easing> <delay>
           <iteration-count> <direction> <fill-mode>`,
              'Keyframes',
            ),
            workedExample(
              'Cheap animation, and consent',
              'The two constraints, applied to one panel.',
              [
                {
                  title: 'Animate transform and opacity only',
                  code: `@keyframes fade-up {
  from { opacity: 0; transform: translateY(8px); }
  to   { opacity: 1; transform: none; }
}`,
                  reasoning:
                    'Both are compositor properties. The same effect written with `margin-top` and `visibility` would force a layout pass on every frame and would not fade at all.',
                },
                {
                  title: 'Keep it short',
                  code: `.panel { animation: fade-up 250ms ease-out; }`,
                  reasoning:
                    'Entrance animation should be over before the reader has finished deciding to look at it. A long entrance is a delay wearing a costume.',
                },
                {
                  title: 'Ask whether motion is welcome',
                  code: `@media (prefers-reduced-motion: reduce) {
  .panel { animation: none; }
}`,
                  reasoning:
                    'This media query reports a setting the reader has already changed in their operating system. For people with vestibular disorders, large motion can cause genuine nausea and dizziness — this is not a preference about taste.',
                },
                {
                  title: 'Or reduce globally, once',
                  code: `@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}`,
                  reasoning:
                    'One block that catches everything, including animations added later by someone who forgot. This is one of the very few defensible uses of `!important`: it is a deliberate override of author styles on the reader\'s behalf, and it must win.',
                },
              ],
            ),
            demo('Compositor properties versus layout properties', 'Both move the box the same distance.', [
              {
                label: 'transform (cheap)',
                code: '<style>\n  @keyframes slide-t { from { transform: translateX(0); } to { transform: translateX(120px); } }\n  .box { width: 60px; height: 60px; background: teal; animation: slide-t 1.2s ease-in-out infinite alternate; }\n</style>\n<div class="box"></div>',
                note: 'The browser moves an existing layer. No layout, no repaint.',
              },
              {
                label: 'left (expensive)',
                code: '<style>\n  @keyframes slide-l { from { left: 0; } to { left: 120px; } }\n  .box { position: relative; width: 60px; height: 60px; background: crimson; animation: slide-l 1.2s ease-in-out infinite alternate; }\n</style>\n<div class="box"></div>',
                note: 'Identical to look at here, and a layout recalculation on every frame. On a slow device this is where the stutter comes from.',
              },
              {
                label: 'Reduced motion respected',
                code: '<style>\n  @keyframes slide-t { from { transform: translateX(0); } to { transform: translateX(120px); } }\n  .box { width: 60px; height: 60px; background: teal; animation: slide-t 1.2s ease-in-out infinite alternate; }\n  @media (prefers-reduced-motion: reduce) { .box { animation: none; } }\n</style>\n<div class="box"></div>',
                note: 'If your system is set to reduce motion, this box is still. If not, it moves. Either way the reader got what they asked for.',
              },
            ]),
            callout(
              'warning',
              'Reduced motion is a medical setting for some readers',
              'Vestibular disorders affect a meaningful share of adults, and large parallax or sliding motion can cause real nausea, dizziness and migraine. `prefers-reduced-motion: reduce` is how those readers have already told every site on the web. Ignoring it is not a missed nicety; it is overriding an explicit request that took effort to make.',
            ),
            selfExplain(
              'Reduced motion is set. Should every animation stop, or is that too blunt?',
              'Too blunt in principle, though blunt is far better than nothing. The preference means "reduce", not "eliminate": what causes trouble is large-scale movement — parallax, big slides across the viewport, spinning, zooming, anything suggesting the page itself is moving. A short opacity fade is usually fine and often still helpful, because it preserves the sense that something changed. The good pattern is to replace motion with a fade rather than remove the feedback entirely, and to keep animations that convey state — a loading spinner still needs to indicate that work is happening. Where a distinction is too fiddly to make, the global override is the right default: a still interface is usable, and a nauseating one is not.',
            ),
            checklist('Motion review', [
              'Animating `transform` and `opacity` wherever the effect allows',
              'No animation of `width`, `height`, `top`, `left` or `margin` in a loop',
              'User-triggered transitions in the 150–300ms range',
              'A `prefers-reduced-motion: reduce` block present',
              'Large movement removed under reduced motion; short fades may remain',
              'State-conveying animation such as a loading indicator kept',
            ]),
            recap(
              [
                '`transform` and `opacity` are the compositor-friendly properties.',
                'Animating layout properties costs a layout pass on every frame.',
                '`prefers-reduced-motion: reduce` reports a setting the reader already made.',
                'Reduce means replace large motion with a fade — not necessarily remove all feedback.',
              ],
              'Next: the Level 9 milestone.',
            ),
            activeRecap(
              [
                'Which two properties are cheap to animate, and why?',
                'What does animating `left` cost that animating `translateX` does not?',
                'Does reduced motion mean no animation at all?',
              ],
              [
                '`transform` and `opacity`, because the compositor can move or fade an already-painted layer without redoing layout or paint.',
                'A layout recalculation on every frame, for the element and often its surroundings — which is where stutter on mid-range devices comes from.',
                'No. It means reduce: remove large movement, keep short fades and anything that conveys state, such as a loading indicator. A global kill-switch is a reasonable default when finer judgement is impractical.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-motion-guided',
              kind: 'guided',
              title: 'Animate cheaply, and ask first',
              brief:
                'Define a `@keyframes fade-up` going from `opacity: 0; transform: translateY(8px)` to `opacity: 1; transform: none`. Apply it to `.panel` as `fade-up 250ms ease-out`. Then add a `@media (prefers-reduced-motion: reduce)` block setting `animation: none` on `.panel`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Motion</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .panel {
        background: #f4f4f4;
        padding: 1rem;
      }
    </style>
  </head>
  <body>
    <div class="panel">The starter doubles in about six hours.</div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Motion</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      @keyframes fade-up {
        from { opacity: 0; transform: translateY(8px); }
        to   { opacity: 1; transform: none; }
      }

      .panel {
        background: #f4f4f4;
        padding: 1rem;
        animation: fade-up 250ms ease-out;
      }

      @media (prefers-reduced-motion: reduce) {
        .panel { animation: none; }
      }
    </style>
  </head>
  <body>
    <div class="panel">The starter doubles in about six hours.</div>
  </body>
</html>`,
              hints: [
                '@keyframes takes a name, then from and to blocks.',
                'Only opacity and transform belong in the keyframes.',
                'The media query goes after the rule it overrides.',
              ],
              requirements: [
                cssMatches('.panel', 'animation', 'fade-up', 'The panel runs the named animation'),
                cssMediaRule('(prefers-reduced-motion: reduce)', 'A reduced-motion block is present'),
                cssIs('.panel', 'animation', 'none', 'Motion is removed when reduced motion is requested', {
                  condition: '(prefers-reduced-motion: reduce)',
                }),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'animation',
            },
            {
              slug: 'css-motion-debug',
              kind: 'debug',
              title: 'Expensive, and unasked for',
              brief:
                'Two faults. The animation moves the box with `left`, which forces layout on every frame — rewrite the keyframes to use `transform: translateX()` for the same 120px movement, and remove `position: relative` since it is no longer needed. And there is no reduced-motion block; add one setting `animation: none` on `.box`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Motion</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      @keyframes slide {
        from { left: 0; }
        to   { left: 120px; }
      }

      .box {
        position: relative;
        width: 60px;
        height: 60px;
        background: teal;
        animation: slide 1.2s ease-in-out infinite alternate;
      }
    </style>
  </head>
  <body>
    <div class="box"></div>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Motion</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      @keyframes slide {
        from { transform: translateX(0); }
        to   { transform: translateX(120px); }
      }

      .box {
        width: 60px;
        height: 60px;
        background: teal;
        animation: slide 1.2s ease-in-out infinite alternate;
      }

      @media (prefers-reduced-motion: reduce) {
        .box { animation: none; }
      }
    </style>
  </head>
  <body>
    <div class="box"></div>
  </body>
</html>`,
              hints: [
                'translateX moves an element without touching layout.',
                'Once nothing uses left, the element does not need positioning.',
                'The reduced-motion block goes last so it wins on source order.',
              ],
              requirements: [
                cssMediaRule('(prefers-reduced-motion: reduce)', 'A reduced-motion block is present'),
                cssIs('.box', 'animation', 'none', 'Motion stops when reduced motion is requested', {
                  condition: '(prefers-reduced-motion: reduce)',
                }),
                cssNotSet('.box', 'position', 'The redundant positioning is gone'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'animation',
            },
          ],
          quiz: [
            {
              slug: 'q-css-cheap-props',
              prompt: 'Which two properties can the compositor animate without a layout pass?',
              explanation: '`transform` and `opacity`.',
              options: [
                { label: '`transform` and `opacity`', correct: true },
                { label: '`width` and `height`' },
                { label: '`top` and `left`' },
                { label: '`margin` and `padding`' },
              ],
              skill: 'animation',
            },
            {
              slug: 'q-css-reduced-motion',
              prompt: 'What does `prefers-reduced-motion: reduce` tell you?',
              explanation: 'That the reader has asked their operating system for less motion.',
              options: [
                { label: 'The reader has set a system-level preference for less motion', correct: true },
                { label: 'The device is low-powered' },
                { label: 'The battery is low' },
                { label: 'Animations are unsupported' },
              ],
              skill: 'animation',
            },
            {
              slug: 'q-css-keyframes-name',
              prompt: 'What connects a `@keyframes` block to an element?',
              explanation: 'The animation name, referenced by the `animation` property.',
              options: [
                { label: 'The name, referenced in the `animation` property', correct: true },
                { label: 'The selector inside the keyframes block' },
                { label: 'Source order' },
                { label: 'A data attribute' },
              ],
              skill: 'animation',
            },
          ],
        },
        {
          slug: 'css-motion-milestone',
          title: 'Milestone: motion with consent',
          subtitle: 'A transition, an animation and a preference honoured',
          summary: 'Everything from this level on one component.',
          objectives: [
            'Transition a hover state explicitly',
            'Animate an entrance with compositor properties',
            'Honour reduced motion globally',
          ],
          estimatedMinutes: 18,
          skill: 'animation',
          masteryThreshold: 0.8,
          blocks: [
            objectives(['Combine transitions, keyframes and a reduced-motion override into one component']),
            code(
              `transition: <prop> 200ms ease-out     name the property
@keyframes … transform / opacity      cheap to animate
animation: <name> 250ms ease-out      short entrance
@media (prefers-reduced-motion: reduce)
  → animation-duration: 0.01ms !important

The last one is the only !important in this course
that is not a mistake.`,
              'The whole level',
              'text',
            ),
            recall(
              'From memory: what is each of these for?',
              [
                '`transition` on the resting state — smooth in both directions when a value changes.',
                '`@keyframes` — a named sequence of states, applied with `animation`.',
                '`transform` / `opacity` — the properties the compositor can animate without a layout pass.',
                '`ease-out` — the default easing for anything the user triggered.',
                '`prefers-reduced-motion: reduce` — the reader has asked for less motion; comply.',
              ],
            ),
            recap(
              [
                'Motion has a cost model and a consent model, and both are non-negotiable.',
                'Name transition properties; animate transform and opacity.',
                'A global reduced-motion block catches what you forget.',
              ],
              'Next: architecture and naming.',
            ),
            activeRecap(
              ['Why is `!important` defensible in the reduced-motion override and almost nowhere else?'],
              [
                'Because it is not an author winning an argument with another author — it is a deliberate override applied on the reader\'s behalf, against every animation in the stylesheet including ones added later by someone who did not think about it. It has to win, it is scoped to one media query, and there is no other mechanism that reaches rules you have not written yet.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'css-motion-milestone-challenge',
              kind: 'challenge',
              title: 'A card that moves considerately',
              brief:
                'Give `.card` a `transition` of `transform 200ms ease-out` and a `:hover` that sets `transform: translateY(-4px)`. Define `@keyframes fade-up` from `opacity: 0; transform: translateY(8px)` to `opacity: 1; transform: none`, and apply it to `.card` as part of the same rule using the `animation` property with `fade-up 250ms ease-out`. Then add a `@media (prefers-reduced-motion: reduce)` block that sets `animation: none` and `transition: none` on `.card`.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Motion milestone</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card {
        background: #f4f4f4;
        padding: 1rem;
        border-radius: 0.5rem;
      }
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
    <title>Motion milestone</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      @keyframes fade-up {
        from { opacity: 0; transform: translateY(8px); }
        to   { opacity: 1; transform: none; }
      }

      .card {
        background: #f4f4f4;
        padding: 1rem;
        border-radius: 0.5rem;
        animation: fade-up 250ms ease-out;
        transition: transform 200ms ease-out;
      }

      .card:hover { transform: translateY(-4px); }

      @media (prefers-reduced-motion: reduce) {
        .card {
          animation: none;
          transition: none;
        }
      }
    </style>
  </head>
  <body>
    <div class="card">Sourdough workshop</div>
  </body>
</html>`,
              hints: [
                'Both the animation and the transition go on .card itself.',
                'The hover rule only needs the transform.',
                'The reduced-motion block turns both off.',
                'Keep the keyframes to opacity and transform.',
              ],
              requirements: [
                cssIs('.card', 'transition', 'transform 200ms ease-out', 'The transition names its property'),
                cssMatches('.card:hover', 'transform', 'translateY', 'The hover state moves with transform'),
                cssMatches('.card', 'animation', 'fade-up', 'The entrance animation is applied'),
                cssMediaRule('(prefers-reduced-motion: reduce)', 'A reduced-motion block is present'),
                cssIs('.card', 'animation', 'none', 'The animation stops under reduced motion', {
                  condition: '(prefers-reduced-motion: reduce)',
                }),
                cssIs('.card', 'transition', 'none', 'The transition stops under reduced motion', {
                  condition: '(prefers-reduced-motion: reduce)',
                }),
              ],
              difficulty: 4,
              xp: 70,
              skill: 'animation',
            },
          ],
          quiz: [
            {
              slug: 'q-css-motion-both',
              prompt: 'A card has both an entrance animation and a hover transition. What must the reduced-motion block do?',
              explanation: 'Turn off both — the preference covers all motion, not just keyframes.',
              options: [
                { label: 'Disable both', correct: true },
                { label: 'Disable the animation only' },
                { label: 'Disable the transition only' },
                { label: 'Halve both durations' },
              ],
              skill: 'animation',
            },
            {
              slug: 'q-css-motion-important',
              prompt: 'Why is `!important` acceptable inside a global reduced-motion override?',
              explanation:
                'It is applied on the reader’s behalf and has to beat every author rule, including ones written later.',
              options: [
                { label: 'It must beat every author rule, including ones not yet written', correct: true },
                { label: '`!important` is required inside media queries' },
                { label: 'Media queries have no specificity otherwise' },
                { label: 'It makes the override faster' },
              ],
              skill: 'animation',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'css-level-9-milestone',
    kind: 'milestone',
    title: 'Level 9 milestone: Transitions and Motion',
    description: 'Six questions on transitions, keyframes, animation cost and reduced motion. Pass mark 75%.',
    passScore: 0.75,
    xp: 180,
    questions: [
      {
        slug: 'a-css-9-transition-place',
        prompt: 'A hover effect fades in but snaps back out. What is wrong?',
        explanation: 'The transition was declared inside `:hover`, so it disappears when the pointer leaves.',
        options: [
          { label: 'The transition is declared on `:hover` instead of the resting state', correct: true },
          { label: 'The duration is too short' },
          { label: 'The easing is wrong' },
          { label: '`:hover` cannot be transitioned' },
        ],
        skill: 'animation',
      },
      {
        slug: 'a-css-9-compositor',
        prompt: 'Why is animating `transform` cheaper than animating `left`?',
        explanation: 'The compositor can move an existing layer; `left` forces layout on every frame.',
        options: [
          { label: 'It avoids a layout recalculation on every frame', correct: true },
          { label: 'It uses fewer keyframes' },
          { label: '`left` is deprecated' },
          { label: 'Transforms are cached by the server' },
        ],
        skill: 'animation',
      },
      {
        slug: 'a-css-9-all',
        prompt: 'What is the risk of `transition: all`?',
        explanation: 'Properties added later animate silently, including expensive ones.',
        options: [
          { label: 'Properties added later start animating without being asked to', correct: true },
          { label: 'It applies only to the first property' },
          { label: 'It disables the easing function' },
          { label: 'It is ignored by browsers' },
        ],
        skill: 'animation',
      },
      {
        slug: 'a-css-9-preference-meaning',
        prompt: 'Reduced motion is set. What is the right response?',
        explanation: 'Remove large movement; short fades and state indicators may remain.',
        options: [
          { label: 'Remove large movement, keeping fades and state indicators', correct: true },
          { label: 'Ignore it unless the device is slow' },
          { label: 'Remove all visual feedback of any kind' },
          { label: 'Show a prompt asking the reader to confirm' },
        ],
        skill: 'animation',
      },
      {
        slug: 'a-css-9-why-preference',
        prompt: 'Why does reduced motion matter beyond preference?',
        explanation: 'Large motion can cause nausea, dizziness and migraine for people with vestibular disorders.',
        options: [
          { label: 'Motion can make some readers physically unwell', correct: true },
          { label: 'Animation drains the battery' },
          { label: 'It affects search ranking' },
          { label: 'Older browsers cannot animate' },
        ],
        skill: 'animation',
      },
      {
        slug: 'a-css-9-easing-default',
        prompt: 'Which easing suits something the user just triggered?',
        explanation: '`ease-out` — fast at first, so the response feels immediate.',
        options: [
          { label: '`ease-out`', correct: true },
          { label: '`ease-in`' },
          { label: '`linear`' },
          { label: '`steps(4)`' },
        ],
        skill: 'animation',
      },
    ],
  },
};
