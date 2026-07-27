import {
  annotated,
  attr,
  attrValue,
  callout,
  checklist,
  code,
  compare,
  count,
  demo,
  detail,
  headingOrder,
  inside,
  labelled,
  legalNesting,
  named,
  notEmpty,
  objectives,
  present,
  prose,
  recap,
  term,
  uniqueIds,
  type LevelSpec,
} from '../types';

export const LEVEL_07: LevelSpec = {
  slug: 'native-interaction',
  title: 'Native Interaction Expert',
  subtitle: 'Interactive features that need no JavaScript at all',
  summary:
    'Modern HTML can build accordions, modal dialogs, popovers, progress displays and autocomplete lists on its own — with keyboard support and screen-reader semantics already correct. Reaching for JavaScript first means rebuilding all of that by hand, usually worse.',
  outcome:
    'You can build FAQ accordions, dialogs, progress displays and enhanced form controls using HTML alone.',
  accent: 'cyan',
  modules: [
    {
      slug: 'disclosure-and-dialog',
      title: 'Disclosure, dialogs and popovers',
      summary:
        'details, summary, dialog and the popover attribute — the four features that replace most simple JavaScript widgets.',
      estimatedMinutes: 45,
      prerequisites: ['form-foundations'],
      skills: [
        { slug: 'native-interaction', masteryRequired: 0 },
        { slug: 'progressive-enhancement', masteryRequired: 0 },
      ],
      lessons: [
        {
          slug: 'details-and-summary',
          title: 'Details and summary',
          subtitle: 'An accordion in two elements',
          summary:
            'The show/hide pattern, built in — with keyboard support, correct announcements and find-in-page support you would otherwise have to write yourself.',
          objectives: [
            'Build a disclosure widget with details and summary',
            'Build an accordion where only one panel opens at a time',
            'Explain what you get free that JavaScript would have to reimplement',
          ],
          estimatedMinutes: 13,
          skill: 'native-interaction',
          blocks: [
            objectives([
              'Build a working FAQ accordion with no JavaScript',
              'Use the open and name attributes',
              'List the behaviours native disclosure gives you for free',
            ]),
            annotated(
              `<details>
  <summary>Do I need to book in advance?</summary>
  <p>
    Not on weekdays. At weekends we recommend booking at least a day ahead,
    especially for tandems and child seats.
  </p>
</details>`,
              [
                { line: '1', text: '`<details>` is the container. It is closed by default; add the `open` attribute to start expanded.' },
                {
                  line: '2',
                  text: '`<summary>` is the always-visible part that toggles it. It must be the first child, and there is exactly one per details.',
                },
                { line: '3-6', text: 'Everything after the summary is the panel, hidden until the widget is opened.' },
              ],
            ),
            callout(
              'tip',
              'What you get without writing a line of JavaScript',
              'Click and keyboard activation with Enter and Space. Correct focus behaviour. A screen-reader announcement of "collapsed" or "expanded" that updates as it changes. Browser find-in-page that opens the panel when the match is inside it. Printing that expands the content. Reimplementing all of that correctly takes a surprising amount of code, and most hand-rolled accordions miss at least two of them.',
            ),
            prose(
              'Give several `<details>` elements the same `name` and they behave as an exclusive accordion: opening one closes the others, exactly like a radio group.',
            ),
            code(
              `<h2>Frequently asked questions</h2>

<details name="faq" open>
  <summary>Do I need to book in advance?</summary>
  <p>Not on weekdays. At weekends, please book a day ahead.</p>
</details>

<details name="faq">
  <summary>Are helmets included?</summary>
  <p>Yes — a helmet and a lock come with every hire.</p>
</details>

<details name="faq">
  <summary>What if it rains?</summary>
  <p>Cancel up to two hours before and we will refund in full.</p>
</details>`,
              'An exclusive accordion',
            ),
            callout(
              'mistake',
              'Do not put a heading inside the summary and a heading outside it too',
              'A common pattern is `<summary><h3>Question</h3></summary>`. It is valid, and it can be useful for a page where the questions should appear in the heading outline — but doubling up, with an `<h3>` both inside and above the summary, produces a confusing outline. Pick one.',
            ),
            demo('Disclosure states', 'The same widget, opened and closed.', [
              {
                label: 'Closed by default',
                code: '<details>\n  <summary>Opening hours</summary>\n  <p>Tuesday to Sunday, 8am to 6pm.</p>\n</details>',
                note: 'Announced as "Opening hours, collapsed, button".',
              },
              {
                label: 'Open by default',
                code: '<details open>\n  <summary>Opening hours</summary>\n  <p>Tuesday to Sunday, 8am to 6pm.</p>\n</details>',
                note: 'Announced as "Opening hours, expanded, button". Use `open` for the answer people most often want.',
              },
            ]),
            detail(
              'When is a details element the wrong choice?',
              'It is a disclosure, not a menu and not a tab set. A navigation dropdown needs different keyboard behaviour — arrow keys, Escape to close, focus returning to the trigger — and a tab set needs arrow-key navigation between tabs. For those, either use a well-tested component or accept that you are writing JavaScript. `<details>` is exactly right for FAQs, "show more" panels, and optional detail.',
            ),
            recap(
              [
                '`<details>` plus `<summary>` gives a complete disclosure widget.',
                'A shared `name` makes several of them mutually exclusive.',
                '`open` starts a panel expanded.',
                'Keyboard, screen-reader, find-in-page and print behaviour all come free.',
              ],
              'Next: dialogs and popovers.',
            ),
          ],
          exercises: [
            {
              slug: 'details-guided',
              kind: 'guided',
              title: 'Build an FAQ accordion',
              brief:
                'Turn these three question-and-answer pairs into an exclusive accordion using `<details>` and `<summary>`, all sharing the name `faq`. The first should start open.',
              starterCode: `<h2>Frequently asked questions</h2>

<p>Do I need to book in advance?</p>
<p>Not on weekdays. At weekends, please book a day ahead.</p>

<p>Are helmets included?</p>
<p>Yes — a helmet and a lock come with every hire.</p>

<p>What if it rains?</p>
<p>Cancel up to two hours before and we will refund in full.</p>`,
              referenceSolution: `<h2>Frequently asked questions</h2>

<details name="faq" open>
  <summary>Do I need to book in advance?</summary>
  <p>Not on weekdays. At weekends, please book a day ahead.</p>
</details>

<details name="faq">
  <summary>Are helmets included?</summary>
  <p>Yes — a helmet and a lock come with every hire.</p>
</details>

<details name="faq">
  <summary>What if it rains?</summary>
  <p>Cancel up to two hours before and we will refund in full.</p>
</details>`,
              hints: [
                'Each question becomes a <summary> and each answer becomes the panel below it.',
                'The <summary> must be the first child of its <details>.',
                'Give all three name="faq", and add open to the first one only.',
              ],
              requirements: [
                count('details', 3, 3, 'There are three disclosure widgets'),
                count('details > summary', 3, 3, 'Each has a summary as its first child'),
                attrValue('details', 'name', 'faq', 'They share the name "faq" so only one opens at a time'),
                { kind: 'element_count', selector: 'details[open]', minCount: 1, maxCount: 1, message: 'Exactly one starts open' },
                notEmpty('summary', 'Every summary has text'),
                legalNesting(),
              ],
              difficulty: 2,
              xp: 45,
              skill: 'native-interaction',
            },
          ],
          quiz: [
            {
              slug: 'q-summary-position',
              prompt: 'Where must `<summary>` appear?',
              explanation: 'As the first child of its `<details>` element.',
              options: [
                { label: 'As the first child of <details>', correct: true },
                { label: 'Anywhere inside <details>' },
                { label: 'Immediately before <details>' },
                { label: 'As the last child of <details>' },
              ],
              skill: 'native-interaction',
            },
            {
              slug: 'q-details-name',
              prompt: 'What does giving several `<details>` elements the same `name` do?',
              explanation: 'It makes them exclusive: opening one closes the others.',
              options: [
                { label: 'Opening one closes the others', correct: true },
                { label: 'They all open together' },
                { label: 'It groups them for form submission' },
                { label: 'It has no effect on details elements' },
              ],
              skill: 'native-interaction',
            },
          ],
        },
        {
          slug: 'dialog-and-popover',
          title: 'Dialog and popover',
          subtitle: 'Modals and tooltips, built in',
          summary:
            'Two newer features that handle focus trapping, Escape-to-close and layering — the parts hand-built modals get wrong.',
          objectives: [
            'Build a dialog and understand what modal means',
            'Use the popover attribute for lightweight overlays',
            'Know exactly where JavaScript is still required, and why',
          ],
          estimatedMinutes: 14,
          skill: 'native-interaction',
          blocks: [
            objectives([
              'Write a <dialog> with a close mechanism',
              'Build a popover with no JavaScript at all',
              'Explain honestly which parts still need scripting',
            ]),
            term(
              'Modal',
              'An overlay that blocks the rest of the page until it is dealt with. Everything behind it becomes inert — unfocusable and unreadable to screen readers.',
            ),
            code(
              `<dialog id="cancel-policy">
  <h2>Cancellation policy</h2>
  <p>Cancel up to two hours before your booking for a full refund.</p>
  <form method="dialog">
    <button type="submit">Close</button>
  </form>
</dialog>`,
              'A dialog with a close button that needs no JavaScript',
            ),
            annotated(
              `<form method="dialog">
  <button type="submit">Close</button>
</form>`,
              [
                {
                  line: '1',
                  text: '`method="dialog"` is a special form method that exists only inside a `<dialog>`. Submitting the form closes the dialog instead of sending anything anywhere.',
                },
                {
                  line: '2',
                  text: 'This is the one way to close a dialog with no JavaScript. It is worth knowing, because a dialog with no way out is a trap.',
                },
              ],
            ),
            callout(
              'note',
              'Opening a dialog does need JavaScript',
              'This is the honest limit. `showModal()` is a JavaScript method, and there is no HTML attribute that opens a `<dialog>`. What HTML gives you, once it is open, is substantial: focus moves into the dialog, focus is trapped inside it, Escape closes it, the background is made inert, and it renders above everything else regardless of stacking order. Those are precisely the things hand-built modals get wrong. This course does not teach the one line of JavaScript that opens it — but you should know that one line is all it is.',
            ),
            prose(
              'The `popover` attribute is newer, and it does work with no JavaScript at all. Any element can become a popover; any button can control it.',
            ),
            annotated(
              `<button popovertarget="helmet-info" popovertargetaction="toggle">
  What sizes do helmets come in?
</button>

<div id="helmet-info" popover>
  <h3>Helmet sizes</h3>
  <p>Small, medium and large, plus two children's sizes.</p>
  <button popovertarget="helmet-info" popovertargetaction="hide">Close</button>
</div>`,
              [
                {
                  line: '1',
                  text: '`popovertarget` names the element this button controls, by its id. The browser wires up the relationship — and the ARIA that goes with it — automatically.',
                },
                {
                  line: '5',
                  text: 'The bare `popover` attribute makes the element a popover. It is hidden until shown, renders in the top layer above everything else, and closes on Escape or on a click outside it — behaviour known as "light dismiss".',
                },
                {
                  line: '8',
                  text: 'A second button with `popovertargetaction="hide"` gives an explicit close. Useful on touch devices, where clicking outside is less discoverable.',
                },
              ],
            ),
            compare(
              'Dialog or popover?',
              {
                label: 'Dialog — needs a decision',
                code: '<dialog id="confirm">\n  <p>Cancel this booking?</p>\n  <form method="dialog">\n    <button value="yes">Yes, cancel</button>\n    <button value="no">Keep it</button>\n  </form>\n</dialog>',
                why: 'Modal. The user must answer before continuing. Blocks the page deliberately.',
              },
              {
                label: 'Popover — extra information',
                code: '<button popovertarget="tip">Helmet sizes</button>\n<div id="tip" popover>\n  <p>Small, medium and large.</p>\n</div>',
                why: 'Non-modal. The user can ignore it and carry on. Dismisses itself on Escape or an outside click.',
              },
            ),
            term(
              'Progressive enhancement',
              'Build so the page works without the enhancement, then add the enhancement for browsers that support it. The content must never be locked inside a feature that might not run.',
            ),
            callout(
              'accessibility',
              'Never hide essential content in a popover or dialog',
              'If the only place your cancellation policy exists is inside a modal, then anyone whose browser does not open it — or whose JavaScript failed to load — cannot read it. Put essential content on the page, and use overlays for convenience, not as the sole home for anything that matters.',
            ),
            detail(
              'Browser support, and how to think about it',
              '`<details>` has been supported everywhere for years. `<dialog>` reached every current browser in 2022. The `popover` attribute reached every current browser in 2024. For a public site, the sensible approach is: use `<details>` freely; use `<dialog>` and `popover` where the content underneath is still reachable if the feature does nothing. That is progressive enhancement in one sentence, and it is a more useful habit than memorising a support table that changes every few months.',
            ),
            recap(
              [
                '`<dialog>` gives focus trapping, Escape-to-close and inert background — but opening it needs one line of JavaScript.',
                '`<form method="dialog">` closes a dialog with no scripting.',
                'The `popover` attribute needs no JavaScript at all, on either side.',
                'Never make an overlay the only place essential content exists.',
              ],
              'Next: progress, meter, datalist and output.',
            ),
          ],
          exercises: [
            {
              slug: 'popover-guided',
              kind: 'guided',
              title: 'Build a popover',
              brief:
                'Add a button that toggles a popover with the id `sizes`, and a close button inside the popover. Use `popovertarget` and `popovertargetaction`.',
              starterCode: `<button>What sizes do helmets come in?</button>

<div id="sizes">
  <h3>Helmet sizes</h3>
  <p>Small, medium and large, plus two children's sizes.</p>
</div>`,
              referenceSolution: `<button popovertarget="sizes" popovertargetaction="toggle">
  What sizes do helmets come in?
</button>

<div id="sizes" popover>
  <h3>Helmet sizes</h3>
  <p>Small, medium and large, plus two children's sizes.</p>
  <button popovertarget="sizes" popovertargetaction="hide">Close</button>
</div>`,
              hints: [
                'Add popovertarget="sizes" to the first button.',
                'Add the bare popover attribute to the div — it needs no value.',
                'Add a second button inside with popovertargetaction="hide".',
              ],
              requirements: [
                attr('div', 'popover', 'The panel is marked as a popover'),
                attrValue('button', 'popovertarget', 'sizes', 'A button targets the popover'),
                count('button[popovertarget]', 2, 2, 'There is a trigger button and a close button'),
                attrValue('button[popovertargetaction="hide"]', 'popovertargetaction', 'hide', 'The close button hides the popover'),
                uniqueIds(),
                named('button', 'Both buttons have visible text'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'native-interaction',
            },
            {
              slug: 'dialog-debug',
              kind: 'debug',
              title: 'A dialog with no way out',
              brief:
                'This dialog has no close mechanism and no heading. Add a heading and a `<form method="dialog">` with a close button.',
              starterCode: `<dialog id="policy">
  <p>Cancel up to two hours before your booking for a full refund.</p>
</dialog>`,
              referenceSolution: `<dialog id="policy">
  <h2>Cancellation policy</h2>
  <p>Cancel up to two hours before your booking for a full refund.</p>
  <form method="dialog">
    <button type="submit">Close</button>
  </form>
</dialog>`,
              hints: [
                'A dialog should start with a heading so its purpose is announced.',
                'A form with method="dialog" closes the dialog when submitted.',
                'Put a submit button inside that form.',
              ],
              requirements: [
                inside('h2, h3', 'dialog', 'The dialog has a heading'),
                attrValue('dialog form', 'method', 'dialog', 'A form with method="dialog" is present'),
                inside('button', 'dialog form', 'There is a close button inside that form'),
                named('button', 'The button has visible text'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'native-interaction',
            },
          ],
          quiz: [
            {
              slug: 'q-dialog-close',
              prompt: 'How can a `<dialog>` be closed without JavaScript?',
              explanation: 'With a `<form method="dialog">` — submitting it closes the dialog.',
              options: [
                { label: 'A form with method="dialog"', correct: true },
                { label: 'A button with type="reset"' },
                { label: 'A link to #close' },
                { label: 'It cannot be, ever' },
              ],
              skill: 'native-interaction',
            },
            {
              slug: 'q-popover-js',
              prompt: 'Does the `popover` attribute require JavaScript?',
              explanation:
                'No. `popovertarget` on a button wires up the whole interaction, including the ARIA relationship.',
              options: [
                { label: 'No — popovertarget handles it entirely', correct: true },
                { label: 'Yes, to show it' },
                { label: 'Yes, to close it' },
                { label: 'Only on mobile browsers' },
              ],
              skill: 'native-interaction',
            },
            {
              slug: 'q-modal-content',
              prompt: 'Why should essential content never live only inside a dialog?',
              explanation:
                'Anyone whose browser does not open it, or whose JavaScript fails, cannot reach the content at all.',
              options: [
                { label: 'If the overlay does not open, the content is unreachable', correct: true },
                { label: 'Dialogs cannot contain paragraphs' },
                { label: 'Search engines index dialogs twice' },
                { label: 'Dialogs are not keyboard accessible' },
              ],
              skill: 'progressive-enhancement',
            },
          ],
        },
        {
          slug: 'progress-meter-datalist-milestone',
          title: 'Progress, meter, datalist — and the milestone',
          subtitle: 'The last four native controls, then build the lot',
          summary:
            'Three small elements with precise meanings, plus a native autocomplete — and then the Level 7 milestone build.',
          objectives: [
            'Use progress and meter for their correct, different meanings',
            'Add native autocomplete with datalist',
            'Combine every Level 7 feature on one page',
          ],
          estimatedMinutes: 25,
          skill: 'native-interaction',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Distinguish progress from meter',
              'Build a datalist-backed input',
              'Build a complete interactive page with no JavaScript',
            ]),
            compare(
              'progress or meter?',
              {
                label: '`<progress>` — a task advancing',
                code: '<label for="setup">Profile completeness</label>\n<progress id="setup" value="7" max="10">7 of 10</progress>',
                why: 'Something that moves towards completion: an upload, a form wizard, a download. It has a beginning and an end.',
              },
              {
                label: '`<meter>` — a measurement in a range',
                code: '<label for="fleet">Bikes available today</label>\n<meter id="fleet" value="6" min="0" max="24" low="5" high="18" optimum="20">6 of 24</meter>',
                why: 'A gauge reading, with no notion of completion: disk usage, a rating, stock level. `low`, `high` and `optimum` let browsers colour it.',
              },
            ),
            callout(
              'mistake',
              'A meter is not a progress bar',
              'Using `<meter>` for a download, or `<progress>` for stock level, is announced wrongly by screen readers and coloured wrongly by browsers. Ask: is this moving towards being finished? If yes, `<progress>`. If it is simply a reading within a range, `<meter>`.',
            ),
            prose(
              'The text inside `<progress>` or `<meter>` is fallback content for very old browsers — but it is also worth keeping, because it states the value in words.',
            ),
            annotated(
              `<label for="route-choice">Which route?</label>
<input list="routes" id="route-choice" name="route"
       autocomplete="off" placeholder="Start typing…">

<datalist id="routes">
  <option value="Harbour loop"></option>
  <option value="Mill and back"></option>
  <option value="The full valley"></option>
</datalist>`,
              [
                {
                  line: '2',
                  text: '`list="routes"` connects the input to a `<datalist>` by its id.',
                },
                {
                  line: '5-9',
                  text: 'The `<datalist>` holds the suggestions. It renders nothing itself.',
                },
                {
                  line: '2',
                  text: 'Crucially, this is a *suggestion* list, not a restriction — the user can type anything. If only the listed values are acceptable, use a `<select>` instead.',
                },
              ],
            ),
            term(
              '<output>',
              'A place for a calculated result. It is a live region by default, so screen readers announce changes to it — which is exactly what you want for a running total.',
            ),
            checklist('The Level 7 milestone page needs', [
              'An FAQ accordion of at least three `<details>` sharing a `name`',
              'A `<dialog>` with a heading and a `<form method="dialog">` close button',
              'A popover with a trigger button and a close button',
              'A `<progress>` element with a label',
              'A `<meter>` element with a label',
              'An input backed by a `<datalist>`',
              'No `<script>` elements anywhere',
            ]),
            recap(
              [
                '`<progress>` for tasks advancing; `<meter>` for gauge readings.',
                '`<datalist>` suggests values without restricting them.',
                '`<output>` announces calculated results to screen readers.',
                'Everything in this level works without a line of JavaScript.',
              ],
              'Level 8 next: accessibility in depth.',
            ),
          ],
          exercises: [
            {
              slug: 'datalist-guided',
              kind: 'guided',
              title: 'Add native autocomplete',
              brief:
                'Connect this input to a `<datalist>` with the id `routes` containing three options. Also add a labelled `<meter>` showing 6 bikes available out of 24.',
              starterCode: `<label for="route-choice">Which route?</label>
<input id="route-choice" name="route" placeholder="Start typing…">

<label for="fleet">Bikes available today</label>
`,
              referenceSolution: `<label for="route-choice">Which route?</label>
<input list="routes" id="route-choice" name="route" placeholder="Start typing…">

<datalist id="routes">
  <option value="Harbour loop"></option>
  <option value="Mill and back"></option>
  <option value="The full valley"></option>
</datalist>

<label for="fleet">Bikes available today</label>
<meter id="fleet" value="6" min="0" max="24" low="5" high="18" optimum="20">6 of 24</meter>`,
              hints: [
                'Add list="routes" to the input, matching the datalist id.',
                'Each suggestion is an <option value="…"></option> inside the datalist.',
                'The meter needs value="6", min="0" and max="24", plus an id matching its label.',
              ],
              requirements: [
                attrValue('input', 'list', 'routes', 'The input is connected to the datalist'),
                present('datalist#routes', 'There is a datalist with that id'),
                count('datalist option', 3, null, 'The datalist offers at least three options'),
                present('meter', 'There is a meter'),
                attrValue('meter', 'value', '6', 'The meter shows the current value'),
                attrValue('meter', 'max', '24', 'The meter declares its maximum'),
                labelled('input, meter', 'Both controls are labelled'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'native-interaction',
            },
            {
              slug: 'native-milestone',
              kind: 'challenge',
              title: 'Milestone: an interactive page with no JavaScript',
              brief:
                'Build a page meeting every item on the checklist above. Everything must work with no scripting at all — the preview will not run any.',
              starterCode: '',
              referenceSolution: `<h1>Booking help</h1>

<h2>Frequently asked questions</h2>

<details name="faq" open>
  <summary>Do I need to book in advance?</summary>
  <p>Not on weekdays. At weekends, please book a day ahead.</p>
</details>

<details name="faq">
  <summary>Are helmets included?</summary>
  <p>Yes — a helmet and a lock come with every hire.</p>
</details>

<details name="faq">
  <summary>What if it rains?</summary>
  <p>
    Cancel up to two hours before for a full refund.
    <button popovertarget="policy-tip" popovertargetaction="toggle">See the details</button>
  </p>
</details>

<div id="policy-tip" popover>
  <h3>Cancellation in detail</h3>
  <p>Refunds are returned to the original payment method within five working days.</p>
  <button popovertarget="policy-tip" popovertargetaction="hide">Close</button>
</div>

<dialog id="terms">
  <h2>Hire terms</h2>
  <p>Bikes must be returned by 6pm on the day of hire.</p>
  <form method="dialog">
    <button type="submit">Close</button>
  </form>
</dialog>

<h2>Today at a glance</h2>

<label for="setup">Your booking, so far</label>
<progress id="setup" value="3" max="5">3 of 5 steps complete</progress>

<label for="fleet">Bikes available today</label>
<meter id="fleet" value="6" min="0" max="24" low="5" high="18" optimum="20">6 of 24</meter>

<label for="route-choice">Which route?</label>
<input list="routes" id="route-choice" name="route" placeholder="Start typing…">
<datalist id="routes">
  <option value="Harbour loop"></option>
  <option value="Mill and back"></option>
  <option value="The full valley"></option>
</datalist>`,
              hints: [
                'Work down the checklist one item at a time; each is only a few lines.',
                'The three details elements need a shared name so only one opens at a time.',
                'progress and meter both need labels connected by for and id.',
                'Do not add any <script> — the checker will flag it.',
              ],
              requirements: [
                count('details', 3, null, 'At least three details elements'),
                attr('details', 'name', 'The details elements share a name'),
                count('details > summary', 3, null, 'Each details has a summary'),
                present('dialog', 'There is a dialog'),
                attrValue('dialog form', 'method', 'dialog', 'The dialog can be closed without JavaScript'),
                present('[popover]', 'There is a popover'),
                present('button[popovertarget]', 'A button controls the popover'),
                present('progress', 'There is a progress element'),
                present('meter', 'There is a meter element'),
                present('datalist', 'There is a datalist'),
                attr('input', 'list', 'An input is connected to the datalist'),
                labelled('progress, meter, input', 'Every control is labelled'),
                { kind: 'element_count', selector: 'script', minCount: 0, maxCount: 0, message: 'The page contains no JavaScript' },
                uniqueIds(),
                headingOrder(),
                legalNesting(),
              ],
              difficulty: 5,
              xp: 150,
              skill: 'native-interaction',
            },
            {
              slug: 'native-mission',
              kind: 'project_mission',
              title: 'Capstone mission: add an FAQ section',
              brief:
                'Add an FAQ accordion to one of your capstone pages using `<details>`, and a progress or meter display somewhere it genuinely fits — availability, capacity, or how far through a process a visitor is.',
              starterCode: `<section aria-labelledby="faq-heading">
  <h2 id="faq-heading">Frequently asked questions</h2>

  <!-- Add at least three details elements sharing a name -->
</section>`,
              referenceSolution: `<section aria-labelledby="faq-heading">
  <h2 id="faq-heading">Frequently asked questions</h2>

  <details name="faq" open>
    <summary>Do I need to book in advance?</summary>
    <p>Not on weekdays. At weekends, please book a day ahead.</p>
  </details>

  <details name="faq">
    <summary>Are helmets included?</summary>
    <p>Yes — a helmet and a lock come with every hire.</p>
  </details>

  <details name="faq">
    <summary>Do you hire to children?</summary>
    <p>Yes, from age six, with a parent or guardian present.</p>
  </details>

  <label for="fleet">Bikes available today</label>
  <meter id="fleet" value="6" min="0" max="24" low="5" high="18" optimum="20">6 of 24</meter>
</section>`,
              hints: [
                'Write questions your own visitors would genuinely ask.',
                'All the details elements need the same name attribute.',
                'The meter or progress element needs a label connected by for and id.',
              ],
              requirements: [
                count('details', 3, null, 'At least three FAQ entries'),
                count('details > summary', 3, null, 'Each has a summary as its first child'),
                notEmpty('summary', 'Every question has text'),
                present('progress, meter', 'There is a progress or meter display'),
                labelled('progress, meter', 'The display is labelled'),
                { kind: 'element_count', selector: 'script', minCount: 0, maxCount: 0, message: 'No JavaScript is used' },
              ],
              difficulty: 3,
              xp: 90,
              skill: 'native-interaction',
            },
          ],
          quiz: [
            {
              slug: 'q-progress-vs-meter',
              prompt: 'Which element suits "disk space used: 62%"?',
              explanation:
                'A gauge reading within a range, with no notion of completion — that is `<meter>`.',
              options: [
                { label: '<meter>', correct: true },
                { label: '<progress>' },
                { label: '<output>' },
                { label: '<data>' },
              ],
              skill: 'native-interaction',
            },
            {
              slug: 'q-datalist-restrict',
              prompt: 'Does a `<datalist>` restrict what the user can type?',
              explanation:
                'No — it suggests. If only certain values are acceptable, use a `<select>` instead.',
              options: [
                { label: 'No, it only suggests — use <select> to restrict', correct: true },
                { label: 'Yes, only listed values are accepted' },
                { label: 'Yes, when combined with required' },
                { label: 'Only when the input has a pattern' },
              ],
              skill: 'native-interaction',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'level-7-milestone',
    kind: 'milestone',
    title: 'Level 7 milestone: Native Interaction Expert',
    description: 'Seven questions on native interactive elements and progressive enhancement. Pass mark 75%.',
    passScore: 0.75,
    xp: 170,
    questions: [
      {
        slug: 'a7-q1',
        prompt: 'What does `<details>` give you that a hand-built accordion must reimplement?',
        explanation:
          'Keyboard activation, expanded/collapsed announcements, find-in-page support and correct printing — all built in.',
        options: [
          { label: 'Keyboard, screen-reader, find-in-page and print behaviour', correct: true },
          { label: 'Animated transitions' },
          { label: 'Automatic styling' },
          { label: 'Server-side rendering' },
        ],
        skill: 'native-interaction',
      },
      {
        slug: 'a7-q2',
        prompt: 'Which part of using `<dialog>` still needs JavaScript?',
        explanation: 'Opening it. `showModal()` is a JavaScript method with no HTML equivalent.',
        options: [
          { label: 'Opening it', correct: true },
          { label: 'Closing it' },
          { label: 'Trapping focus inside it' },
          { label: 'Making the background inert' },
        ],
        skill: 'native-interaction',
      },
      {
        slug: 'a7-q3',
        prompt: 'What connects a button to a popover?',
        explanation: '`popovertarget`, holding the id of the popover element.',
        options: [
          { label: 'popovertarget', correct: true },
          { label: 'aria-controls' },
          { label: 'for' },
          { label: 'href' },
        ],
        skill: 'native-interaction',
      },
      {
        slug: 'a7-q4',
        prompt: 'Which element suits "uploading file 3 of 5"?',
        explanation: 'A task moving towards completion — `<progress>`.',
        options: [
          { label: '<progress>', correct: true },
          { label: '<meter>' },
          { label: '<output>' },
          { label: '<datalist>' },
        ],
        skill: 'native-interaction',
      },
      {
        slug: 'a7-q5',
        prompt: 'What is progressive enhancement?',
        explanation:
          'Building so the page works without the enhancement, then layering the enhancement on for browsers that support it.',
        options: [
          { label: 'Building so it works first, then enhancing where supported', correct: true },
          { label: 'Loading features one at a time as the page scrolls' },
          { label: 'Only supporting the newest browsers' },
          { label: 'Compressing assets progressively' },
        ],
        skill: 'progressive-enhancement',
      },
      {
        slug: 'a7-q6',
        prompt: 'Several `<details>` share `name="faq"`. What happens when you open the second one?',
        explanation: 'The first closes. A shared name makes them mutually exclusive.',
        options: [
          { label: 'The first one closes', correct: true },
          { label: 'Both stay open' },
          { label: 'The form is submitted' },
          { label: 'Nothing — name has no effect' },
        ],
        skill: 'native-interaction',
      },
      {
        slug: 'a7-q7',
        prompt: 'Why is `<output>` useful for a calculated total?',
        explanation:
          'It is a live region by default, so screen readers announce the new value when it changes.',
        options: [
          { label: 'It is a live region, so changes are announced', correct: true },
          { label: 'It calculates the total for you' },
          { label: 'It is styled as a result box' },
          { label: 'It is submitted with the form' },
        ],
        skill: 'aria',
      },
    ],
  },
};
