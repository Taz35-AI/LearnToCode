import {
  absent,
  activeRecap,
  annotated,
  attr,
  attrMatches,
  attrValue,
  callout,
  checklist,
  code,
  compare,
  count,
  demo,
  detail,
  directChild,
  goodAlt,
  headingOrder,
  labelled,
  legalNesting,
  mediaExample,
  mediaResolves,
  named,
  notEmpty,
  objectives,
  predictCheck,
  noAttr,
  present,
  pretest,
  prose,
  recap,
  selfExplain,
  term,
  textIn,
  unique,
  uniqueIds,
  visual,
  workedExample,
  type LevelSpec,
  recall,
} from '../types';

export const LEVEL_08: LevelSpec = {
  slug: 'accessibility-champion',
  title: 'Accessibility Champion',
  subtitle: 'Build so everybody can use it — using the HTML you already know',
  summary:
    'Almost everything in this level is something you have already met. What changes here is that you learn to audit, to test with a keyboard, and to know the small set of ARIA worth using. Accessibility is not a layer added at the end; it is what correct HTML already does.',
  outcome: 'You can audit a page against WCAG 2.2 AA principles and repair what you find.',
  accent: 'emerald',
  modules: [
    {
      slug: 'accessibility-foundations',
      title: 'Accessibility foundations',
      summary:
        'How assistive technology reads your page, how to test with a keyboard, and the accessibility your HTML already provides.',
      estimatedMinutes: 50,
      prerequisites: ['disclosure-and-dialog'],
      skills: [{ slug: 'accessibility', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'how-assistive-tech-reads-a-page',
          title: 'How assistive technology reads a page',
          subtitle: 'The accessibility tree, keyboard order, and what you can test today',
          summary:
            'You do not need a screen reader to catch most problems. You need a keyboard and ten minutes.',
          objectives: [
            'Explain what the accessibility tree is',
            'Test a page using only the keyboard',
            'Name the four WCAG principles',
          ],
          estimatedMinutes: 14,
          skill: 'accessibility',
          blocks: [
            objectives([
              'Describe how HTML becomes the accessibility tree',
              'Run a keyboard-only test on any page',
              'Explain what WCAG 2.2 AA means in practice',
            ]),
            visual('accessibility-tree', 'Your HTML becomes an accessibility tree, which assistive technology reads.'),
            prose(
              'The browser builds two things from your markup: the DOM, which drives what is drawn on screen, and the accessibility tree, which is what screen readers, voice-control software and switch devices read. Correct HTML fills that second tree automatically. Incorrect HTML leaves it empty or wrong, and no amount of visual polish will fix it.',
            ),
            term(
              'Role',
              'What an element *is*, as far as assistive technology is concerned. `<button>` has the role `button`; `<nav>` has `navigation`. You rarely need to set one, because using the right element sets it for you.',
            ),
            term(
              'Accessible name',
              'The text an element is announced by. It comes from its label, its alt text, its contents, or an `aria-label` — in that order of preference.',
            ),
            term(
              'State',
              'Whether something is expanded, checked, disabled or current. Native elements manage their own state; anything you build by hand does not.',
            ),
            callout(
              'tip',
              'The keyboard test — do this on every page you build',
              'Click into the address bar, then press Tab repeatedly. Four questions: (1) Can you reach every interactive thing? (2) Can you always see where focus is? (3) Does the order follow the visual layout? (4) Can you get *out* of everything you get into? Any "no" is a bug. This takes two minutes and catches the majority of real-world accessibility failures.',
            ),
            demo('Focus order follows source order', 'Not the order things appear on screen.', [
              {
                label: 'Source order matches visual order',
                code: '<nav aria-label="Main"><a href="#a">First</a> <a href="#b">Second</a></nav>\n<main id="a"><h1>Content</h1></main>',
                note: 'Tab reaches First, then Second, then the content. Exactly what a sighted user expects.',
              },
              {
                label: 'Content before navigation in the source',
                code: '<main id="a"><h1>Content</h1><a href="#x">A link in the content</a></main>\n<nav aria-label="Main"><a href="#b">Menu item</a></nav>',
                note: 'If CSS moved the nav to the top visually, keyboard users would reach the content link first — a jarring mismatch. Get the source order right and CSS cannot break it.',
              },
            ]),
            prose(
              'WCAG — the Web Content Accessibility Guidelines — organises everything under four principles. The current version is 2.2, and AA is the level almost every organisation and law targets.',
            ),
            code(
              `Perceivable    Can people sense the content?
               → alt text, captions, colour contrast, not relying on colour alone

Operable       Can people use the interface?
               → keyboard access, skip links, enough time, visible focus

Understandable Is it clear and predictable?
               → language declared, consistent navigation, clear error messages

Robust         Does it work with the tools people actually use?
               → valid HTML, correct names and roles, no duplicate ids`,
              'The four WCAG principles, in plain terms',
              'text',
            ),
            callout(
              'note',
              'How much of this is HTML?',
              'A great deal. Of the WCAG 2.2 AA criteria, the ones you can meet or fail purely in markup include page language, page titles, heading structure, link purpose, form labels, error identification, name-role-value, bypass blocks, and info-and-relationships. Colour contrast and reflow are CSS; timing and motion are usually JavaScript. Getting the HTML right takes you most of the way.',
            ),
            detail(
              'Who is actually affected?',
              'The stereotype is a blind screen-reader user, and they matter — but the population is much wider. Someone with a broken wrist using only a keyboard. Someone with a tremor who cannot hit a small target. Someone with dyslexia who relies on clear heading structure. Someone watching a video on a train with the sound off. Someone with a migraine using their phone at low brightness. Accessibility work is rarely for a minority; it is usually for everybody, some of the time.',
            ),
            recap(
              [
                'The browser builds an accessibility tree from your HTML; correct elements fill it for free.',
                'Role, accessible name and state are what assistive technology reads.',
                'The keyboard test takes two minutes and catches most real problems.',
                'WCAG 2.2 AA is the working standard; much of it is markup.',
              ],
              'Next: the ARIA worth knowing, and the ARIA to avoid.',
            ),
          ],
          exercises: [
            {
              slug: 'keyboard-debug',
              kind: 'debug',
              title: 'A page a keyboard user cannot use',
              brief:
                'Three things here cannot be reached or used with a keyboard: a `<div>` acting as a button, a link with no href, and an image link with no accessible name. Fix all three using the right native elements.',
              starterCode: `<div class="button" onclick="submitForm()">Send enquiry</div>

<a class="nav-link">Prices</a>

<a href="index.html">
  <img src="/learning-media/icons/home.svg" alt="">
</a>`,
              referenceSolution: `<button type="submit">Send enquiry</button>

<a href="prices.html">Prices</a>

<a href="index.html">
  <img src="/learning-media/icons/home.svg" alt="">
  Home
</a>`,
              hints: [
                'A div is not focusable and is not announced as a button. Use a real <button>.',
                'An <a> with no href is not a link at all — it cannot be focused or activated.',
                'An image link with alt="" has no accessible name. Add visible text, or give the image alt text describing where the link goes.',
              ],
              requirements: [
                present('button', 'The action uses a real button element'),
                attr('button', 'type', 'The button has an explicit type'),
                attr('a', 'href', 'Every link has an href'),
                named('a', 'Every link has an accessible name'),
                { kind: 'element_count', selector: 'div[onclick], [onclick]', minCount: 0, maxCount: 0, message: 'No inline click handlers on non-interactive elements' },
                named('button', 'The button has visible text'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'accessibility',
            },
          ],
          quiz: [
            {
              slug: 'q-a11y-tree',
              prompt: 'What is the accessibility tree?',
              explanation:
                'A second structure the browser builds from your HTML, containing roles, names and states, which assistive technology reads.',
              options: [
                { label: 'A structure of roles, names and states built from your HTML', correct: true },
                { label: 'A list of accessibility errors on the page' },
                { label: 'The DOM with CSS applied' },
                { label: 'A file screen readers download separately' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-keyboard-test',
              prompt: 'What does pressing Tab through a page test?',
              explanation:
                'Whether every interactive element is reachable, whether focus is visible, and whether the order makes sense.',
              options: [
                { label: 'Whether everything interactive is reachable, visible and in a sensible order', correct: true },
                { label: 'Whether the colour contrast is sufficient' },
                { label: 'Whether images have alt text' },
                { label: 'Whether the HTML validates' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-div-button',
              prompt: 'Why is `<div onclick="…">` not a button?',
              explanation:
                'It cannot be focused with a keyboard, is not announced as a button, and does not respond to Enter or Space.',
              options: [
                { label: 'It is not focusable, not announced as a button, and ignores Enter and Space', correct: true },
                { label: 'onclick only works on buttons' },
                { label: 'Divs cannot contain text' },
                { label: 'It works fine — the elements are equivalent' },
              ],
              skill: 'accessibility',
            },
          ],
        },
        {
          slug: 'keyboard-and-focus-management',
          title: 'Keyboard operability and focus',
          subtitle: 'The test you can run on anything, and the three ways people break it',
          summary:
            'If it cannot be done with a keyboard, it cannot be done by a large number of people. This is the single highest-value habit in the level.',
          objectives: [
            'Name the elements that are focusable without any extra work',
            'Use tabindex correctly — and know why positive values are a bug',
            'Add a skip link that actually works',
          ],
          estimatedMinutes: 16,
          skill: 'accessibility',
          blocks: [
            pretest(
              'A developer makes a clickable card by putting a click handler on a `<div>`. Who, apart from screen-reader users, is locked out?',
              [
                'Anyone not using a mouse — keyboard, voice control, switch devices',
                'Nobody else — it is only a screen-reader problem',
                'Only people on a phone',
                'Only people who have turned JavaScript off',
              ],
              'Far more people than most developers expect. A `<div>` is not focusable, so it cannot be reached with Tab, cannot be activated with Enter or Space, and is invisible to voice control asking to "click the card". That locks out people using switch devices or voice control, anyone whose trackpad has died, and anyone who simply prefers the keyboard. Screen-reader users are a minority of the people this breaks.',
            ),
            objectives([
              'List the elements that are keyboard-focusable by default',
              'Apply `tabindex="0"` and `tabindex="-1"` correctly',
              'Write a skip link whose target can actually take focus',
            ]),
            prose(
              'Keyboard access is not an accessibility extra. It is the substrate almost every assistive technology sits on: switch devices, voice control and screen readers all drive the page through the same focus model you use when you press Tab. Get the keyboard right and most of the rest follows.',
            ),
            term(
              'Focusable',
              'An element the browser will move focus to. Links *with an href*, buttons, form controls, `<summary>`, `<iframe>` and anything carrying a `tabindex` are focusable. Almost nothing else is.',
            ),
            term(
              'Tab order',
              'The sequence Tab moves through. By default it is exactly the order elements appear in your source — which is one more reason source order matters.',
            ),
            code(
              `Focusable with no extra work:
  <a href="...">        a link — but only if it has an href
  <button>              always
  <input> <select>      every form control
  <textarea>
  <summary>             the toggle of a <details>
  <iframe>              the embed itself
  <audio controls>      and <video controls>

Not focusable, ever, without help:
  <div> <span> <p>      no matter what handlers you attach`,
              'What the browser gives you free',
              'text',
            ),
            callout(
              'mistake',
              'An anchor without an href is not a link',
              'Writing `<a>Menu</a>` or `<a href="#">Menu</a>` is a common way to fake a button. The first is not focusable at all; the second is focusable but announced as a link that goes nowhere. If it performs an action rather than navigating, it is a `<button>`.',
            ),
            demo('The same card, three ways', 'Tab through each one and notice what you can reach.', [
              {
                label: 'A real link',
                code: '<article><h2><a href="article.html">How we bake</a></h2><p>Fifteen hours, start to finish.</p></article>',
                note: 'Focusable, announced as a link, activated with Enter, findable by voice control. Nothing extra required.',
              },
              {
                label: 'A real button',
                code: '<article><h2>How we bake</h2><p>Fifteen hours, start to finish.</p><button type="button">Read more</button></article>',
                note: 'Correct when it performs an action rather than navigating. Enter and Space both activate it.',
              },
              {
                label: 'A div pretending',
                code: '<article><h2>How we bake</h2><p>Fifteen hours, start to finish.</p><div class="btn">Read more</div></article>',
                note: 'Tab skips straight past it. There is no way to reach or activate it without a mouse — and no amount of styling fixes that.',
              },
            ]),
            prose(
              '`tabindex` has exactly two values worth using, and one that is almost always a mistake.',
            ),
            annotated(
              `<div tabindex="0">Now reachable by Tab</div>
<h2 tabindex="-1" id="results">Focusable by script only</h2>
<button tabindex="3">Please do not</button>`,
              [
                {
                  line: '1',
                  text: '`tabindex="0"` puts an element into the natural tab order, at its source position. Use it when you have genuinely built a custom control — and remember it makes the element *focusable*, not *operable*: you still owe it a role and keyboard handling.',
                },
                {
                  line: '2',
                  text: '`tabindex="-1"` makes an element focusable by script, while Tab skips it. This is the right tool for something you want to move focus *to* after an action — a results heading, for instance.',
                },
                {
                  line: '3',
                  text: 'A positive `tabindex` jumps the queue, moving this button ahead of everything with `tabindex="0"` or no tabindex at all. It creates an order nobody can predict and which breaks as soon as the page changes. Treat any positive value as a bug.',
                },
              ],
            ),
            predictCheck(
              `<a href="#main-content">Skip to main content</a>
<nav aria-label="Main">
  <a href="index.html">Home</a>
  <a href="menu.html">Menu</a>
</nav>
<main id="main-content">
  <h1>Today's bakes</h1>
</main>`,
              'A skip link sits first in the source and points at the `id` of `<main>`. Before you run it: what has to be true of the target for *focus* — not merely the scroll position — to move there?',
              'The target has to be focusable. Browsers have improved here and most now move focus to the target of a fragment link even when it is not focusable, but the behaviour has historically been inconsistent — and the reliable fix is `tabindex="-1"` on the target. That makes it focusable by fragment navigation and by script while keeping it out of the Tab order. Without it, on some browsers the page scrolls and focus stays on the skip link, so the next Tab press drops the user straight back into the navigation they were trying to skip.',
            ),
            callout(
              'accessibility',
              'A skip link must become visible when focused',
              'The usual pattern positions the link off-screen and brings it back on focus. That part is CSS, so it is outside this course — but the markup half is yours, and a skip link hidden with `display: none` is not focusable at all. Never hide one that way.',
            ),
            detail(
              'Focus traps, and the one place you want one',
              'A focus trap is when Tab cannot escape a region. Usually it is a bug — a custom menu that swallows focus and never gives it back. In exactly one case it is correct: a modal dialog, where focus *should* stay inside until the dialog is dismissed. The native `<dialog>` opened as a modal does this for you, along with Escape to close and returning focus to whatever opened it. Building it by hand means reimplementing all three, and most hand-built versions get at least one of them wrong.',
            ),
            checklist('The two-minute keyboard test', [
              'Can you reach every interactive thing with Tab?',
              'Can you always see where focus is?',
              'Does the order follow the visual layout?',
              'Can you get out of everything you can get into?',
              'Does Enter activate links, and Enter *and* Space activate buttons?',
              'Does the skip link appear when focused, and land somewhere useful?',
            ]),
            recap(
              [
                'Links with an `href`, buttons, form controls, `<summary>` and `<iframe>` are focusable for free; `<div>` and `<span>` never are.',
                'Tab order follows source order, which makes source order an accessibility decision.',
                '`tabindex="0"` adds to the natural order, `tabindex="-1"` allows script focus, positive values are a bug.',
                'A skip link needs a target that can take focus, which in practice means `tabindex="-1"` on it.',
              ],
              'Next: where an accessible name actually comes from.',
            ),
            activeRecap(
              [
                'Which elements are focusable without a tabindex? Name at least four.',
                'What do `tabindex="0"` and `tabindex="-1"` each do, and why is `tabindex="3"` a bug?',
                'What has to be true of a skip link\'s target?',
              ],
              [
                'Links *with an href*, `<button>`, `<input>`, `<select>`, `<textarea>`, `<summary>`, `<iframe>`, and media carrying `controls`.',
                '`0` puts it in the natural order at its source position. `-1` makes it focusable by script while Tab skips it. A positive value jumps the queue, producing an order nobody can predict and which breaks whenever the page changes.',
                'It has to be able to take focus — give it `tabindex="-1"` — and it must not be hidden with `display: none`, which would stop the link working at all.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'keyboard-skip-link-guided',
              kind: 'guided',
              title: 'Add a working skip link',
              brief:
                'This page puts navigation before its content, so a keyboard user must Tab through every menu item on every page. Add a skip link as the very first element, pointing at the `<main>`, and give the `<main>` an `id` and `tabindex="-1"` so focus can actually land there.',
              starterCode: `<nav aria-label="Main">
  <a href="index.html">Home</a>
  <a href="menu.html">Menu</a>
  <a href="contact.html">Contact</a>
</nav>
<main>
  <h1>Today's bakes</h1>
  <p>Sourdough, rye and a seeded loaf.</p>
</main>`,
              referenceSolution: `<a href="#main-content">Skip to main content</a>
<nav aria-label="Main">
  <a href="index.html">Home</a>
  <a href="menu.html">Menu</a>
  <a href="contact.html">Contact</a>
</nav>
<main id="main-content" tabindex="-1">
  <h1>Today's bakes</h1>
  <p>Sourdough, rye and a seeded loaf.</p>
</main>`,
              hints: [
                'A skip link is an ordinary anchor whose href is a fragment, beginning with #.',
                'Give the main element an id, then point the link at #that-id.',
                'Add tabindex="-1" to the main so focus can move there without adding it to the Tab order.',
              ],
              requirements: [
                unique('main', 'There is exactly one <main>'),
                attr('main', 'id', 'The <main> has an id so it can be targeted'),
                attrValue('main', 'tabindex', '-1', 'The <main> has tabindex="-1" so focus can land on it'),
                attrMatches('a', 'href', '^#', 'A fragment link points somewhere within the page'),
                notEmpty('a', 'The skip link has visible text'),
                uniqueIds(),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'accessibility',
            },
            {
              slug: 'keyboard-operability-debug',
              kind: 'debug',
              title: 'Three things a keyboard cannot reach',
              brief:
                'This page looks fine and is unusable without a mouse. Three faults: an anchor with no destination, a `<div>` acting as a button, and a positive `tabindex`. Fix all three by using the correct elements.',
              starterCode: `<nav aria-label="Main">
  <a>Home</a>
  <a href="menu.html" tabindex="2">Menu</a>
</nav>
<main>
  <h1>Book a table</h1>
  <div class="button">Book now</div>
</main>`,
              referenceSolution: `<nav aria-label="Main">
  <a href="index.html">Home</a>
  <a href="menu.html">Menu</a>
</nav>
<main>
  <h1>Book a table</h1>
  <button type="button">Book now</button>
</main>`,
              hints: [
                'An anchor is only focusable when it has an href.',
                'Something that performs an action is a <button>, not a <div>.',
                'Remove the positive tabindex entirely — the source order is already correct.',
              ],
              requirements: [
                count('a:not([href])', 0, 0, 'Every anchor has an href'),
                present('button', 'The action uses a real <button>'),
                count('div.button', 0, 0, 'No <div> is pretending to be a button'),
                count('[tabindex="1"], [tabindex="2"], [tabindex="3"]', 0, 0, 'No positive tabindex values remain'),
                unique('main', 'The page still has exactly one <main>'),
              ],
              difficulty: 3,
              xp: 45,
              skill: 'accessibility',
            },
          ],
          quiz: [
            {
              slug: 'q-focusable-defaults',
              prompt: 'Which of these is focusable with no `tabindex` at all?',
              explanation:
                'An anchor is focusable only when it has an href. Generic containers never are, whatever handlers you attach to them.',
              options: [
                { label: '`<a href="about.html">About</a>`', correct: true },
                { label: '`<a>About</a>`' },
                { label: '`<div class="link">About</div>`' },
                { label: '`<span class="link">About</span>`' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-tabindex-negative',
              prompt: 'What does `tabindex="-1"` do?',
              explanation:
                'It makes an element focusable by script or by a fragment link, while keeping it out of the Tab sequence.',
              options: [
                { label: 'Makes it focusable by script, but skipped by Tab', correct: true },
                { label: 'Removes it from the accessibility tree' },
                { label: 'Puts it last in the Tab order' },
                { label: 'Hides it from screen readers' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-positive-tabindex',
              prompt: 'Why is a positive `tabindex` such as `tabindex="5"` treated as a bug?',
              explanation:
                'It jumps ahead of everything in the natural order, creating a sequence nobody can predict and which breaks whenever the page changes.',
              options: [
                { label: 'It jumps the queue, creating an unpredictable and fragile order', correct: true },
                { label: 'It is ignored by every modern browser' },
                { label: 'It removes the element from the accessibility tree' },
                { label: 'It only works when JavaScript is enabled' },
              ],
              skill: 'accessibility',
            },
          ],
        },
        {
          slug: 'accessible-names-in-depth',
          title: 'Accessible names',
          subtitle: 'Where the words a screen reader says actually come from',
          summary:
            'Every control is announced by something. Knowing which something, and in what order, is what separates a page that reads well from one that reads as "link, link, button, link".',
          objectives: [
            'State the order a browser uses to work out an accessible name',
            'Write link text that makes sense read out of context',
            'Choose the right alt text for informative, decorative and functional images',
          ],
          estimatedMinutes: 16,
          skill: 'accessibility',
          blocks: [
            pretest(
              'A screen-reader user asks for a list of every link on the page. Nine of them say "Read more". What has gone wrong?',
              [
                'Link text is announced without its surrounding paragraph, so nine links are indistinguishable',
                'Nothing — the surrounding text is read out with each link',
                'The links need a `title` attribute as well',
                'Screen readers cannot list links, so it does not matter',
              ],
              'Listing links is one of the most common ways screen-reader users navigate, and the list contains the link *text alone* — the paragraph it sat in is gone. Nine identical "Read more" entries are nine destinations the user cannot tell apart. This is why link text has to make sense with everything around it removed.',
            ),
            objectives([
              'Explain how a browser computes an accessible name, in order',
              'Write link text that works when read on its own',
              'Decide between descriptive alt text and `alt=""`',
            ]),
            prose(
              'An accessible name is simply the words an element is announced by. Almost every accessibility bug you will meet is really a naming bug: a control with no name, the wrong name, or a name that only makes sense if you can see the rest of the page.',
            ),
            visual('accessibility-tree', 'Names, roles and states are what assistive technology actually receives.'),
            code(
              `The browser works down this list and stops at the first one it finds:

  1. aria-labelledby   points at other elements; their text becomes the name
  2. aria-label        a string you supply directly
  3. the native source  <label> for a field, alt for an image,
                        <legend> for a fieldset, <caption> for a table,
                        the element's own text for a link or button
  4. title             a last resort, and a poor one`,
              'How a name is worked out',
              'text',
            ),
            callout(
              'tip',
              'Prefer the lowest number you can',
              'That ordering looks like a ranking of quality, and it is — upside down. `aria-labelledby` and the native sources are best because they reuse text that is *already visible*, so the name and the screen can never disagree. `aria-label` replaces the visible text with something only some users get, which is why a mismatch there breaks voice control. `title` is unreliable on touch, invisible to keyboard users, and should be treated as a fallback you did not want.',
            ),
            compare(
              'Link text, read out of context',
              {
                label: 'Works alone',
                code: `<h3>Sourdough workshop</h3>
<p>Six hours, small groups.</p>
<a href="sourdough.html">Book the sourdough workshop</a>`,
                why: 'In a list of links it reads "Book the sourdough workshop" — unambiguous with the page removed.',
              },
              {
                label: 'Meaningless alone',
                code: `<h3>Sourdough workshop</h3>
<p>Six hours, small groups.</p>
<a href="sourdough.html">Read more</a>`,
                why: 'In a list of links it reads "Read more", identical to every other one on the page.',
              },
            ),
            demo('Naming an icon-only button', 'Three attempts. Only one of them is announced usefully.', [
              {
                label: 'Named with aria-label',
                code: '<button type="button" aria-label="Search"><img src="/learning-media/icons/search.svg" alt="" width="24" height="24"></button>',
                note: 'Announced as "Search, button". The icon takes alt="" because the button already carries the name — describing both would say it twice.',
              },
              {
                label: 'Named by the image',
                code: '<button type="button"><img src="/learning-media/icons/search.svg" alt="Search" width="24" height="24"></button>',
                note: 'Also correct. The button has no text of its own, so the image\'s alt becomes the button\'s name.',
              },
              {
                label: 'Named by nothing',
                code: '<button type="button"><img src="/learning-media/icons/search.svg" alt="" width="24" height="24"></button>',
                note: 'Announced as just "button". The user is told there is a control and nothing about what it does.',
              },
            ]),
            prose(
              'Alt text is the same problem wearing different clothes. The question is never "what is in this picture" — it is "what would this image have told the reader, and how do I say that in words".',
            ),
            mediaExample(
              'team-portrait',
              'The same photograph, three correct answers',
              'Which alt text is right depends entirely on why the image is on the page. All three of these are correct — in different contexts.',
              `<!-- Informative: the image carries information -->
<img src="/learning-media/images/team-portrait.jpg"
     alt="Priya Raman, head baker" width="800" height="800">

<!-- Functional: the image is the link -->
<a href="team.html"><img src="/learning-media/images/team-portrait.jpg"
     alt="Meet the team" width="800" height="800"></a>

<!-- Decorative: the caption already says it -->
<figure>
  <img src="/learning-media/images/team-portrait.jpg" alt=""
       width="800" height="800">
  <figcaption>Priya Raman, head baker</figcaption>
</figure>`,
            ),
            callout(
              'accessibility',
              '`alt=""` is a decision, not an omission',
              'An empty alt says "this image adds nothing, skip it" and is exactly right for decoration or for an image whose caption already carries the message. Leaving the attribute off altogether is different and worse: with no `alt` at all, many screen readers fall back to reading the file name, so the user hears "team hyphen portrait dot jay peg".',
            ),
            selfExplain(
              'A colleague writes `<img src="logo.svg" alt="logo">` and says the image is now accessible because it has alt text. Write your reply. Say what a reader actually gains from that alt, and what it should say instead in two different situations.',
              'It has alt text and it still tells the reader nothing. "Logo" names the *kind of thing* the image is, which the user did not ask about and cannot act on. What matters is what the image does on this page. If the logo is inside a link to the homepage, its alt is the link\'s name, so it should say where the link goes — "Riverside Bakery, home". If it is decoration beside a heading that already says the company name, it should be `alt=""` so it is skipped rather than announced twice. Same file, two different correct answers, and neither of them is "logo".',
            ),
            detail(
              'Naming regions, groups and tables',
              'The same rules extend past controls. A `<nav>` gets a name from `aria-label` or `aria-labelledby`, which is how a user with three navs tells them apart. A group of related radio buttons is named by its `<fieldset>`\'s `<legend>`. A data table is named by its `<caption>`. In every case, prefer the native element — the legend and the caption are visible to everyone, and a name everybody can see is a name that cannot silently drift out of date.',
            ),
            checklist('Naming checklist', [
              'Every image has an `alt`, even when the right value is empty',
              'Every form control has a `<label>`, or a name from `aria-labelledby`',
              'Every link makes sense read on its own',
              'Every icon-only button has an `aria-label` or a named image inside it',
              'Every `<nav>` beyond the first has a label distinguishing it',
              'No name is supplied by `title` alone',
            ]),
            recap(
              [
                'The name comes from `aria-labelledby`, then `aria-label`, then the native source, then `title`.',
                'Prefer sources that reuse visible text, so the name and the screen cannot disagree.',
                'Link text must make sense with the page removed, because that is how it is often heard.',
                '`alt=""` means "skip this"; no `alt` at all often means "read the file name out".',
              ],
              'Next: the ARIA worth knowing, and the rule that matters most.',
            ),
            activeRecap(
              [
                'List the four sources of an accessible name, in the order the browser tries them.',
                'Why is "Read more" poor link text, and what makes replacement text good?',
                'When is `alt=""` correct, and how does it differ from leaving `alt` off?',
              ],
              [
                '`aria-labelledby`, then `aria-label`, then the native source (`<label>`, `alt`, `<legend>`, `<caption>`, or the element\'s own text), then `title`.',
                'Because links are commonly listed and heard without their surrounding text, so nine "Read more" links are indistinguishable. Good link text names the destination — "Book the sourdough workshop".',
                '`alt=""` is correct for decoration, or where a caption already carries the message, and tells assistive technology to skip the image. Omitting `alt` entirely often makes a screen reader read out the file name instead.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'accessible-names-challenge',
              kind: 'challenge',
              title: 'Name four controls correctly',
              brief:
                'Build a small block containing: a search button whose only content is an icon image, a link to `team.html` whose text works read on its own, a decorative image, and a labelled email field. Every one of the four must end up with a sensible accessible name. The wording is yours.',
              starterCode: `<!-- A search button with an icon: /learning-media/icons/search.svg -->

<!-- A link to team.html -->

<!-- A decorative image: /learning-media/svg/placeholder.svg -->

<!-- An email field with a label -->
`,
              referenceSolution: `<button type="button" aria-label="Search the site">
  <img src="/learning-media/icons/search.svg" alt="" width="24" height="24">
</button>

<a href="team.html">Meet the bakery team</a>

<img src="/learning-media/svg/placeholder.svg" alt="" width="600" height="400">

<label for="email">Email address</label>
<input type="email" id="email" name="email" autocomplete="email">`,
              hints: [
                'An icon-only button needs an aria-label, and the icon inside it should then take alt="".',
                'Link text should name the destination, not say "click here".',
                'A decorative image takes alt="" — the attribute is present, its value is empty.',
                'A label needs for="the-input-id", and the input needs a matching id.',
              ],
              requirements: [
                present('button', 'There is a button'),
                named('button', 'The button has an accessible name'),
                present('a[href="team.html"]', 'There is a link to team.html'),
                named('a', 'The link text makes sense on its own'),
                count('img', 2, null, 'Both images are present'),
                goodAlt('img', 'Every image has an appropriate alt attribute'),
                labelled('input', 'The email field has an associated label'),
                attrValue('input', 'type', 'email', 'The email field uses type="email"'),
                mediaResolves(),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'accessibility',
            },
            {
              slug: 'accessible-names-debug',
              kind: 'debug',
              title: 'Four names that say nothing',
              brief:
                'Every control below has a name problem: a link that reads meaninglessly on its own, an icon button with no name, an image whose alt describes the file rather than the content, and a field labelled only by a placeholder. Repair all four.',
              starterCode: `<article>
  <h2>Sourdough workshop</h2>
  <p>Six hours, small groups, everything provided.</p>
  <a href="sourdough.html">Click here</a>
  <button type="button"><img src="/learning-media/icons/mail.svg" alt="" width="24" height="24"></button>
  <img src="/learning-media/images/studio-desk.jpg" alt="studio-desk.jpg" width="1200" height="800">
  <input type="email" name="email" placeholder="Email">
</article>`,
              referenceSolution: `<article>
  <h2>Sourdough workshop</h2>
  <p>Six hours, small groups, everything provided.</p>
  <a href="sourdough.html">Book the sourdough workshop</a>
  <button type="button" aria-label="Email us about this workshop">
    <img src="/learning-media/icons/mail.svg" alt="" width="24" height="24">
  </button>
  <img src="/learning-media/images/studio-desk.jpg"
       alt="An open laptop, a notebook and a mug on a wooden desk" width="1200" height="800">
  <label for="email">Email address</label>
  <input type="email" id="email" name="email" autocomplete="email">
</article>`,
              hints: [
                'Replace "Click here" with text naming where the link goes.',
                'The icon button has no text at all, so give it an aria-label.',
                'Alt text describes what the image shows, never the file name.',
                'A placeholder is not a label — add a real <label> with a matching for and id.',
              ],
              requirements: [
                named('a', 'The link has meaningful text of its own'),
                absent('a:has(> :only-child)', 'The link is not empty', 'The link needs visible text.'),
                named('button', 'The icon button has an accessible name'),
                goodAlt('img', 'The alt text describes the image, not the file'),
                labelled('input', 'The email field has a real label'),
                attr('label', 'for', 'The label points at the field with for'),
                uniqueIds(),
                mediaResolves(),
              ],
              difficulty: 3,
              xp: 45,
              skill: 'accessibility',
            },
          ],
          quiz: [
            {
              slug: 'q-name-order',
              prompt: 'Which source wins when a button has both `aria-label` and its own text content?',
              explanation:
                '`aria-label` overrides the element\'s own text — which is why a mismatch between the two breaks voice control.',
              options: [
                { label: '`aria-label` — it replaces the visible text', correct: true },
                { label: 'The visible text — ARIA never overrides real content' },
                { label: 'Both are read, one after the other' },
                { label: 'Whichever appears first in the source' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-alt-empty-vs-missing',
              prompt: 'What is the difference between `alt=""` and leaving `alt` off entirely?',
              explanation:
                '`alt=""` says "skip this image". No alt at all leaves the reader with nothing, and many screen readers then announce the file name.',
              options: [
                { label: '`alt=""` tells assistive tech to skip it; a missing alt often makes it read the file name', correct: true },
                { label: 'They behave identically' },
                { label: '`alt=""` hides the image from everyone' },
                { label: 'A missing alt is required for decorative images' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-link-text-alone',
              prompt: 'Why does link text have to make sense without its surrounding paragraph?',
              explanation:
                'Screen-reader users frequently pull up a list of every link on the page, and that list contains the link text alone.',
              options: [
                { label: 'Links are often listed on their own, with the surrounding text removed', correct: true },
                { label: 'Search engines cannot read paragraphs' },
                { label: 'Browsers truncate long link text' },
                { label: 'It is only a style preference' },
              ],
              skill: 'accessibility',
            },
          ],
        },
      ],
    },
    {
      slug: 'aria-and-accessible-forms',
      title: 'ARIA and accessible forms',
      summary:
        'The small set of ARIA worth knowing, the states that have to be announced when they change, and the forms most people get wrong.',
      estimatedMinutes: 75,
      prerequisites: ['accessibility-foundations'],
      skills: [
        { slug: 'aria', masteryRequired: 0 },
        { slug: 'accessibility', masteryRequired: 0.5 },
      ],
      lessons: [
        {
          slug: 'aria-fundamentals',
          title: 'ARIA fundamentals',
          subtitle: 'A small, useful set — and the rule that matters most',
          summary:
            'ARIA can make a page more accessible or considerably less. The first rule of ARIA is not to use it.',
          objectives: [
            'State the first rule of ARIA',
            'Use aria-label, aria-labelledby, aria-describedby and aria-current correctly',
            'Explain what a live region is and when to use one',
          ],
          estimatedMinutes: 15,
          skill: 'aria',
          blocks: [
            pretest(
              'A developer wants a clickable "Menu" control and writes `<div role="button">Menu</div>`. A screen reader announces it as a button. What happens when someone presses Enter on it?',
              [
                'Nothing — it is announced as a button but does not behave like one',
                'It activates, because the role tells the browser how to treat it',
                'It activates, but only in browsers that support ARIA',
                'The page reports an error',
              ],
              'Nothing happens. This is the single most important thing to understand about ARIA, and it is why the first rule of ARIA is not to use it. A role changes what assistive technology *announces* and nothing else — not focus, not keyboard behaviour, not anything. So this control is now announced as a button to exactly the users who cannot operate it, which is worse than leaving it unannounced.',
            ),
            objectives([
              'Explain why native HTML beats ARIA',
              'Apply the handful of ARIA attributes worth knowing',
              'Recognise ARIA that makes a page worse',
            ]),
            callout(
              'warning',
              'The first rule of ARIA',
              'If a native HTML element will do the job, use it instead. ARIA changes what assistive technology *announces*; it changes nothing about how an element actually behaves. `<div role="button">` is announced as a button but is still not focusable, still ignores Enter and Space, and still does nothing on a keyboard. You would have to add all of that yourself — or use `<button>`, which has it already.',
            ),
            compare(
              'The same control, two ways',
              {
                label: 'Native',
                code: '<button type="button">Menu</button>',
                why: 'Focusable, announced as a button, responds to Enter and Space, works with voice control. Zero extra work.',
              },
              {
                label: 'ARIA rebuild',
                code: '<div role="button" tabindex="0" aria-pressed="false">Menu</div>',
                why: 'Announced as a button, but Enter and Space do nothing without JavaScript, and voice-control software may not find it. More code, less function.',
              },
            ),
            prose('These are the ARIA attributes genuinely worth knowing at this stage.'),
            code(
              `aria-label="Main"          Names an element that has no visible label.
                           Use on <nav>, <section>, <iframe>, icon-only buttons.

aria-labelledby="id"       Names an element using text that is already on the page.
                           Prefer this over aria-label when such text exists.

aria-describedby="id"      Attaches extra description, read after the name.
                           Use for format hints and error messages on form fields.

aria-current="page"        Marks the current item in a set — the link to the page
                           you are already on, or the current step in a process.

aria-expanded="true"       States whether a control's target is open. Native
                           <details> manages this for you; custom widgets do not.

aria-live="polite"         Marks a region whose changes should be announced when
                           the user is idle. Use very sparingly.

aria-hidden="true"         Removes an element from the accessibility tree entirely.
                           Only for genuinely decorative things.`,
              'The ARIA worth learning first',
              'text',
            ),
            annotated(
              `<section aria-labelledby="hours-heading">
  <h2 id="hours-heading">Opening hours</h2>
  <p>Tuesday to Sunday, 8am to 6pm.</p>
</section>

<button type="button" aria-label="Search">
  <img src="/learning-media/icons/search.svg" alt="" width="24" height="24">
</button>`,
              [
                {
                  line: '1',
                  text: '`aria-labelledby` names the section using its own heading. Better than `aria-label`, because the name and the visible text can never drift apart.',
                },
                {
                  line: '6',
                  text: 'An icon-only button has no text, so it has no accessible name. `aria-label="Search"` supplies one.',
                },
                {
                  line: '7',
                  text: 'The icon itself takes `alt=""`: the button already has a name, and describing the icon too would announce it twice.',
                },
              ],
            ),
            callout(
              'mistake',
              '`aria-label` on the wrong element',
              '`aria-label` is ignored on most non-interactive elements — a `<span>`, a `<div>` with no role, a plain `<p>`. It works on interactive elements and on landmarks. Putting it on a `<div>` and assuming it will be read is one of the most common ARIA mistakes.',
            ),
            term(
              'Live region',
              'An area whose changes should be announced without moving focus — a form error summary, a "message sent" confirmation, a live score. `aria-live="polite"` waits for a pause; `assertive` interrupts immediately and should be reserved for genuine emergencies.',
            ),
            code(
              `<p id="email-error" role="alert">
  Enter an email address in the format name@example.com
</p>

<input type="email" id="email" name="email"
       aria-describedby="email-error" aria-invalid="true">`,
              'An accessible error message',
            ),
            callout(
              'accessibility',
              'What makes an error message accessible',
              'Four things. It says what is wrong in plain words. It says how to fix it. It is connected to the field with `aria-describedby`, so it is read when the user reaches the field. And it is announced when it appears, via `role="alert"` — because a message the user has to go looking for is a message they will miss.',
            ),
            predictCheck(
              `<button type="button" aria-label="Search">Search our recipes</button>

<span aria-label="Closed today">Closed</span>`,
              'Two elements, each given an `aria-label`. Before you check: what does a screen reader announce for each — and is either of them what the author intended?',
              'Neither is. The button is announced as just "Search", because `aria-label` *replaces* the visible text rather than adding to it — so a voice-control user saying "click Search our recipes" now finds nothing. The `<span>` is announced as plain "Closed", because `aria-label` is ignored on a non-interactive element with no role; the label is simply dropped. Both are quiet failures: the markup looks careful, the page looks fine, and the accessibility is worse than if neither attribute had been written.',
            ),
            detail(
              'When ARIA is genuinely the right answer',
              'ARIA earns its place where HTML has no equivalent: naming a landmark that has no visible heading; announcing a change that happens without a page load; marking the current item in a set; describing a relationship between elements that are not nested. Those are real gaps, and ARIA fills them well. What it cannot do is turn a `<div>` into a working control.',
            ),
            demo('Native element versus ARIA rebuild', 'Tab to each one and press Space.', [
              {
                label: 'A real button',
                code: '<button type="button">Menu</button>',
                note: 'Focusable, announced as a button, responds to Enter and Space, findable by voice control. No attributes required.',
              },
              {
                label: 'The ARIA rebuild',
                code: '<div role="button" tabindex="0">Menu</div>',
                note: 'Announced as a button and focusable — but Enter and Space do nothing without a script, so it is announced as operable to precisely the people who cannot operate it.',
              },
              {
                label: 'A role and nothing else',
                code: '<div role="button">Menu</div>',
                note: 'Announced as a button and not even reachable by Tab. The role changed what is said about it and nothing about what it does.',
              },
            ]),
            recap(
              [
                'First rule of ARIA: use native HTML instead, whenever you can.',
                'ARIA changes announcements, never behaviour.',
                '`aria-labelledby` is better than `aria-label` when visible text already exists.',
                'Error messages need plain words, a fix, `aria-describedby`, and an announcement.',
              ],
              'Next: the accessibility audit milestone.',
            ),
          ],
          exercises: [
            {
              slug: 'aria-guided',
              kind: 'guided',
              title: 'Name three unnamed things',
              brief:
                'Three elements here have no accessible name: a section, an icon-only button and a second nav. Name the section using its own heading with `aria-labelledby`, the button with `aria-label`, and the nav with `aria-label`.',
              starterCode: `<section>
  <h2 id="hours-heading">Opening hours</h2>
  <p>Tuesday to Sunday, 8am to 6pm.</p>
</section>

<button type="button">
  <img src="/learning-media/icons/search.svg" alt="" width="24" height="24">
</button>

<nav>
  <ul><li><a href="privacy.html">Privacy</a></li></ul>
</nav>`,
              referenceSolution: `<section aria-labelledby="hours-heading">
  <h2 id="hours-heading">Opening hours</h2>
  <p>Tuesday to Sunday, 8am to 6pm.</p>
</section>

<button type="button" aria-label="Search">
  <img src="/learning-media/icons/search.svg" alt="" width="24" height="24">
</button>

<nav aria-label="Footer">
  <ul><li><a href="privacy.html">Privacy</a></li></ul>
</nav>`,
              hints: [
                'The heading already has id="hours-heading" — point aria-labelledby at it.',
                'The button contains only an icon, so it needs aria-label="Search".',
                'Give the nav an aria-label describing which navigation it is.',
              ],
              requirements: [
                attrValue('section', 'aria-labelledby', 'hours-heading', 'The section is named by its heading'),
                attr('button', 'aria-label', 'The icon-only button has an accessible name'),
                attr('nav', 'aria-label', 'The nav is labelled'),
                named('button', 'The button has an accessible name'),
                attrValue('button img', 'alt', '', 'The decorative icon uses alt=""'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'aria',
            },
            {
              slug: 'aria-debug',
              kind: 'debug',
              title: 'ARIA that makes things worse',
              brief:
                'Every line here uses ARIA where native HTML would be better, or uses it wrongly. Rewrite them all with correct native elements.',
              starterCode: `<div role="button" tabindex="0">Send</div>
<div role="heading" aria-level="2">Our routes</div>
<span role="link" tabindex="0">Prices</span>
<ul role="list"><li role="listitem">Helmet</li></ul>`,
              referenceSolution: `<button type="button">Send</button>
<h2>Our routes</h2>
<a href="prices.html">Prices</a>
<ul><li>Helmet</li></ul>`,
              hints: [
                'role="button" on a div should just be a <button>.',
                'role="heading" aria-level="2" should just be an <h2>.',
                'role="link" should be an <a href="…">.',
                'A <ul> already has the list role — the ARIA is redundant noise.',
              ],
              requirements: [
                present('button', 'The action is a real button'),
                present('h2', 'The heading is a real h2'),
                attr('a', 'href', 'The link is a real link with an href'),
                { kind: 'element_count', selector: '[role]', minCount: 0, maxCount: 0, message: 'No redundant role attributes remain' },
                { kind: 'element_count', selector: '[tabindex]', minCount: 0, maxCount: 0, message: 'No tabindex needed — native elements are focusable already' },
                present('ul > li', 'The list is still a list'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'aria',
            },
          ],
          quiz: [
            {
              slug: 'q-aria-first-rule',
              prompt: 'What is the first rule of ARIA?',
              explanation: 'Do not use ARIA if a native HTML element will do the job.',
              options: [
                { label: 'Do not use it if a native element will do', correct: true },
                { label: 'Always add a role to every element' },
                { label: 'Use aria-label on everything' },
                { label: 'Add ARIA before writing HTML' },
              ],
              skill: 'aria',
            },
            {
              slug: 'q-aria-behaviour',
              prompt: 'Does `role="button"` make a `<div>` respond to the Enter key?',
              explanation:
                'No. ARIA changes what is announced, never how an element behaves. You would have to add focus handling and key handling yourself.',
              options: [
                { label: 'No — ARIA changes announcements, not behaviour', correct: true },
                { label: 'Yes, the browser adds button behaviour' },
                { label: 'Only if tabindex="0" is also set' },
                { label: 'Only in screen readers' },
              ],
              skill: 'aria',
            },
            {
              slug: 'q-labelledby-vs-label',
              prompt: 'A section has a visible `<h2>`. How should you name the section?',
              explanation:
                '`aria-labelledby` pointing at the heading, so the name and the visible text can never disagree.',
              options: [
                { label: 'aria-labelledby pointing at the heading\'s id', correct: true },
                { label: 'aria-label repeating the heading text' },
                { label: 'A title attribute' },
                { label: 'It does not need a name' },
              ],
              skill: 'aria',
            },
          ],
        },
        {
          slug: 'aria-live-and-state',
          title: 'States, and changes worth announcing',
          subtitle: 'What to say when something happens without a page load',
          summary:
            'A change nobody is told about did not happen, as far as a screen-reader user is concerned. This is the part of ARIA that earns its place.',
          objectives: [
            'Use `aria-expanded`, `aria-current` and `aria-invalid` correctly',
            'Explain what a live region is and when one is justified',
            'Recognise the states native HTML already manages for you',
          ],
          estimatedMinutes: 15,
          skill: 'aria',
          blocks: [
            pretest(
              'A form shows an error message above the field after a failed submit. Focus stays where it was. What does a screen-reader user hear?',
              [
                'Nothing — the message appeared silently, in a place they have already passed',
                'The message, because new content is always announced',
                'The message, but only after they press Tab',
                'An error tone from the browser',
              ],
              'Nothing at all. Adding content to a page does not announce it; screen readers read what is focused or what the user navigates to, and this message appeared above a field they have already moved past. Making it heard takes a deliberate act — a live region, or moving focus. This is the gap ARIA live regions exist to close, and it is the one situation where reaching for ARIA is clearly right.',
            ),
            objectives([
              'Apply the state attributes worth knowing to real controls',
              'Choose between `polite`, `assertive` and moving focus',
              'Avoid the live-region mistakes that make a page worse',
            ]),
            prose(
              'A state is a fact about a control that can change: open or closed, current or not, valid or invalid. Sighted users read state from the visuals. Everyone else needs it in the markup — and if you built the control by hand, nothing puts it there for you.',
            ),
            code(
              `aria-expanded="true|false"   is this control's target open?
aria-current="page|step|true" which item in this set is the current one?
aria-invalid="true"           did this field fail validation?
aria-describedby="id"         extra description, read after the name
aria-pressed="true|false"     is this toggle button pressed in?
aria-disabled="true"          announced as unavailable, but still focusable`,
              'The states worth knowing',
              'text',
            ),
            callout(
              'tip',
              'Native elements manage their own state',
              '`<details>` maintains `expanded` as the user opens and closes it. A checkbox maintains `checked`. A modal `<dialog>` maintains its own presence and focus. You only need these attributes for controls you have built yourself out of parts that do not know what they are — which is one more argument for not building them.',
            ),
            demo('Marking the current page', 'Three navs. Only one tells a screen-reader user where they are.', [
              {
                label: 'With aria-current',
                code: '<nav aria-label="Main"><a href="index.html">Home</a> <a href="menu.html" aria-current="page">Menu</a> <a href="contact.html">Contact</a></nav>',
                note: 'The current item is announced as "Menu, current page". The user knows where they are without reading the whole page.',
              },
              {
                label: 'Styled only',
                code: '<nav aria-label="Main"><a href="index.html">Home</a> <a href="menu.html" class="active">Menu</a> <a href="contact.html">Contact</a></nav>',
                note: 'A class name is invisible to assistive technology. Visually obvious, silently absent for everyone else.',
              },
              {
                label: 'No link at all',
                code: '<nav aria-label="Main"><a href="index.html">Home</a> <span>Menu</span> <a href="contact.html">Contact</a></nav>',
                note: 'Removing the link removes it from the keyboard order and from the list of links, so the set now looks incomplete.',
              },
            ]),
            term(
              'Live region',
              'An area whose changes are announced without focus moving there. `aria-live="polite"` waits for a pause in speech; `aria-live="assertive"` interrupts immediately.',
            ),
            annotated(
              `<p id="status" role="status"></p>

<p id="email-error" role="alert">
  Enter an email address in the format name@example.com
</p>

<input type="email" id="email" name="email"
       aria-describedby="email-error" aria-invalid="true">`,
              [
                {
                  line: '1',
                  text: '`role="status"` is a polite live region. Crucially the element exists in the page *before* the message arrives — a live region added at the same moment as its content is usually not announced at all.',
                },
                {
                  line: '3',
                  text: '`role="alert"` is an assertive live region. It interrupts, so it is right for a validation failure and wrong for a "saved" confirmation.',
                },
                {
                  line: '7',
                  text: '`aria-describedby` ties the message to the field, so the message is read when the user reaches it — separately from the announcement.',
                },
                {
                  line: '7',
                  text: '`aria-invalid="true"` marks the field itself as failing, so it is announced as invalid rather than merely having a description.',
                },
              ],
            ),
            callout(
              'mistake',
              'The three live-region mistakes',
              'First: creating the region and its content at the same time — the region must already be in the page for a change to be noticed. Second: reaching for `assertive` everywhere, which interrupts whatever the user was listening to; reserve it for errors and genuine emergencies. Third: marking a large container as live, so every unrelated change inside it is read out.',
            ),
            predictCheck(
              `<button type="button" aria-expanded="false" aria-controls="hours">
  Opening hours
</button>
<div id="hours" hidden>
  <p>Tuesday to Sunday, 8am to 6pm.</p>
</div>`,
              'A hand-built disclosure. The markup is correct as written. Before you check: what breaks the moment a learner wires up the click handler and forgets one line?',
              '`aria-expanded` stays `false` forever. The panel opens, the arrow turns, sighted users see the change — and every screen-reader user is told the control is still collapsed. Nothing errors and nothing looks wrong, which is exactly why it survives review. The native `<details>` and `<summary>` pair carries this state itself and cannot fall out of step, which is why it is the better answer whenever it fits.',
            ),
            detail(
              'Announce, or move focus?',
              'A live region tells the user something changed while leaving them where they are. Moving focus takes them to it. Use a live region for information that does not need acting on — "Saved", "Three results". Move focus when the user has to do something next: after a failed submit, sending focus to the first invalid field is more use than any announcement, because it both tells them and puts them where the work is.',
            ),
            recap(
              [
                'State attributes describe what a control *is doing*: expanded, current, invalid, pressed.',
                'Native elements maintain their own state; hand-built ones do not, and drift silently.',
                '`role="status"` is polite, `role="alert"` interrupts — and the element must already exist.',
                'For anything the user must act on, moving focus beats announcing.',
              ],
              'Next: forms, where all of this comes together.',
            ),
            activeRecap(
              [
                'What does `aria-expanded` describe, and what keeps it accurate on a `<details>`?',
                'Name the three common live-region mistakes.',
                'When should you move focus rather than announce?',
              ],
              [
                'Whether the control\'s target is currently open. `<details>` maintains it natively, so it cannot drift out of step with what is on screen; a hand-built disclosure only stays accurate if you update it yourself.',
                'Creating the region and its content at the same moment; using `assertive` when `polite` would do; marking too large a container as live so unrelated changes are announced.',
                'When the user has to act next — a failed submit should move focus to the first invalid field, which both informs them and puts them where the work is.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'aria-state-guided',
              kind: 'guided',
              title: 'Mark the current page and connect an error',
              brief:
                'Two jobs. In the nav, mark `menu.html` as the page currently being viewed using `aria-current`. Below it, connect the error message to the email field with `aria-describedby`, mark the field invalid, and make the message announce itself with `role="alert"`.',
              starterCode: `<nav aria-label="Main">
  <a href="index.html">Home</a>
  <a href="menu.html" class="active">Menu</a>
  <a href="contact.html">Contact</a>
</nav>

<p id="email-error">Enter an email address in the format name@example.com</p>
<label for="email">Email address</label>
<input type="email" id="email" name="email">`,
              referenceSolution: `<nav aria-label="Main">
  <a href="index.html">Home</a>
  <a href="menu.html" aria-current="page">Menu</a>
  <a href="contact.html">Contact</a>
</nav>

<p id="email-error" role="alert">Enter an email address in the format name@example.com</p>
<label for="email">Email address</label>
<input type="email" id="email" name="email"
       aria-describedby="email-error" aria-invalid="true">`,
              hints: [
                'aria-current="page" goes on the link to the page you are already on.',
                'aria-describedby takes the id of the message element.',
                'The field itself needs aria-invalid="true", and the message needs role="alert".',
              ],
              requirements: [
                attrValue('a[href="menu.html"]', 'aria-current', 'page', 'The current page is marked with aria-current="page"'),
                attrValue('p', 'role', 'alert', 'The error message is an assertive live region'),
                attrValue('input', 'aria-describedby', 'email-error', 'The field is described by the error message'),
                attrValue('input', 'aria-invalid', 'true', 'The field is marked invalid'),
                labelled('input', 'The field still has its label'),
                uniqueIds(),
              ],
              difficulty: 3,
              xp: 45,
              skill: 'aria',
            },
            {
              slug: 'aria-state-debug',
              kind: 'debug',
              title: 'ARIA that makes the page worse',
              brief:
                'Every piece of ARIA below is actively harmful: a `role="button"` on a `<div>`, an `aria-label` on a `<span>` where it is ignored, an `aria-hidden` hiding a real control from assistive technology, and `aria-live="assertive"` on a whole region. Repair each one, preferring native HTML.',
              starterCode: `<main aria-live="assertive">
  <h1>Book a table</h1>
  <div role="button">Book now</div>
  <span aria-label="Closed today">Closed</span>
  <button type="button" aria-hidden="true">Cancel</button>
</main>`,
              referenceSolution: `<main>
  <h1>Book a table</h1>
  <button type="button">Book now</button>
  <p>Closed today</p>
  <button type="button">Cancel</button>
</main>`,
              hints: [
                'A role does not make something operable — use the real element instead.',
                'aria-label is ignored on a plain span; put the words in the page as text.',
                'aria-hidden on a focusable control creates something reachable by Tab but invisible to a screen reader. Remove it.',
                'A whole region marked assertive announces every change inside it. Remove it entirely.',
              ],
              requirements: [
                count('[role="button"]', 0, 0, 'No element fakes a button with a role'),
                count('button', 2, 2, 'Both actions are real buttons'),
                count('[aria-hidden="true"]', 0, 0, 'Nothing interactive is hidden from assistive technology'),
                noAttr('main', 'aria-live', 'The whole region is no longer a live region'),
                textIn('main', 'Closed today', 'The closed message is real text on the page'),
                unique('main', 'There is exactly one <main>'),
              ],
              difficulty: 4,
              xp: 55,
              skill: 'aria',
            },
          ],
          quiz: [
            {
              slug: 'q-aria-current-page',
              prompt: 'How do you tell assistive technology which nav item is the page currently open?',
              explanation:
                '`aria-current="page"` marks the current item. A CSS class is invisible to assistive technology.',
              options: [
                { label: '`aria-current="page"` on that link', correct: true },
                { label: 'A class such as `active`' },
                { label: 'Removing the href so it is not a link' },
                { label: '`aria-selected="true"`' },
              ],
              skill: 'aria',
            },
            {
              slug: 'q-live-region-timing',
              prompt: 'Why must a live region already exist in the page before its message arrives?',
              explanation:
                'Assistive technology watches an existing region for changes. A region created together with its content usually produces no announcement at all.',
              options: [
                { label: 'Assistive tech announces changes to a region it is already watching', correct: true },
                { label: 'Because the CSS has to load first' },
                { label: 'It does not matter — order is irrelevant' },
                { label: 'Because `aria-live` only works on page load' },
              ],
              skill: 'aria',
            },
            {
              slug: 'q-assertive-vs-polite',
              prompt: 'When is `aria-live="assertive"` (or `role="alert"`) the right choice?',
              explanation:
                'Assertive interrupts whatever is being read. That is justified for an error or an emergency, and rude for a routine confirmation.',
              options: [
                { label: 'For validation errors and genuine emergencies', correct: true },
                { label: 'For every status message, so nothing is missed' },
                { label: 'For "saved" confirmations' },
                { label: 'Whenever the region is visually prominent' },
              ],
              skill: 'aria',
            },
          ],
        },
        {
          slug: 'accessible-forms-in-depth',
          title: 'Accessible forms',
          subtitle: 'Labels, groups, errors, and the WCAG 2.2 criteria that are pure markup',
          summary:
            'Forms are where accessibility failures cost people money and appointments. Almost all of it is markup you already know, used deliberately.',
          objectives: [
            'Label every control, including groups of related ones',
            'Use `autocomplete` so people are not asked to retype what the browser knows',
            'Build an error message that is announced, connected and actionable',
          ],
          estimatedMinutes: 18,
          skill: 'accessibility',
          blocks: [
            pretest(
              'A checkout form asks for a delivery address, then asks for it again on a later step as "billing address". Which WCAG 2.2 criterion does that risk failing?',
              [
                'Redundant Entry — asking again for information already given',
                'None; repeating a question is always allowed',
                'Contrast Minimum',
                'Page Titled',
              ],
              'Redundant Entry (3.3.7, added in WCAG 2.2). Asking someone to supply the same information twice in one process is a genuine barrier for people with memory or motor impairments, and simply annoying for everyone else. The fix is to auto-populate it, or offer it as a selectable option. It is worth knowing this criterion exists because it is one of several in 2.2 that are solved with markup rather than design.',
            ),
            objectives([
              'Associate every control with a label, and every group with a legend',
              'Apply `autocomplete` tokens correctly',
              'Connect and announce validation errors',
            ]),
            visual('form-anatomy', 'A label and its input, joined by matching `for` and `id`.'),
            prose(
              'You met `<label>` in Level 6. Here it matters for a different reason: a control with no label has no accessible name, so it is announced as "edit text" and a voice-control user has nothing to say to reach it.',
            ),
            compare(
              'The same field, labelled and not',
              {
                label: 'Labelled',
                code: `<label for="postcode">Postcode</label>
<input type="text" id="postcode" name="postcode"
       autocomplete="postal-code">`,
                why: 'Announced as "Postcode, edit text". Clicking the word focuses the field, which also makes it an easier target for anyone with a tremor. Autofill works.',
              },
              {
                label: 'Placeholder only',
                code: `<input type="text" name="postcode" placeholder="Postcode">`,
                why: 'No name. The placeholder disappears the moment typing starts, so the one hint about what the field wants is gone exactly when it is needed.',
              },
            ),
            term(
              'Fieldset and legend',
              'A `<fieldset>` groups related controls and its `<legend>` names the group. Without them, a set of radio buttons is announced as a series of unrelated options with no indication of the question they answer.',
            ),
            code(
              `<fieldset>
  <legend>How should we contact you?</legend>

  <input type="radio" id="by-email" name="contact" value="email">
  <label for="by-email">Email</label>

  <input type="radio" id="by-phone" name="contact" value="phone">
  <label for="by-phone">Phone</label>
</fieldset>`,
              'A group that announces its own question',
            ),
            prose(
              '`autocomplete` is not a convenience feature. WCAG 2.1 made it a requirement for fields collecting information about the user, because it lets browsers and assistive tools fill in details someone may find slow, painful or impossible to type accurately.',
            ),
            code(
              `name              given-name        family-name
email             tel               organization
street-address    address-level2    postal-code    country-name
cc-name           cc-number         cc-exp
username          current-password  new-password
bday              url`,
              'The autocomplete tokens you will actually use',
              'text',
            ),
            callout(
              'accessibility',
              'Never block paste on a password field',
              'WCAG 2.2 added Accessible Authentication (3.3.8). Blocking paste, or forbidding a password manager, forces people to transcribe a long random string by hand — which is precisely what someone with a cognitive or motor impairment cannot reliably do, and which pushes everyone else towards weaker passwords. Use `autocomplete="current-password"` and leave paste alone.',
            ),
            workedExample(
              'Building an error message that actually works',
              'The field has been submitted empty. Four things have to be true before that failure is usable, and they are usually added in the wrong order — or three out of four.',
              [
                {
                  title: 'Say what is wrong, in words',
                  code: `<p id="email-error">Enter an email address</p>`,
                  reasoning:
                    'Not "invalid input". The message has to name the field and the problem, because it may be read in isolation, far from the field it describes.',
                },
                {
                  title: 'Say how to fix it',
                  code: `<p id="email-error">Enter an email address in the format name@example.com</p>`,
                  reasoning:
                    'A message that only reports failure leaves the user guessing at the rule. Showing the shape of a correct answer turns a dead end into an instruction.',
                },
                {
                  title: 'Connect it to the field',
                  code: `<input type="email" id="email" name="email"
       aria-describedby="email-error" aria-invalid="true">`,
                  reasoning:
                    '`aria-describedby` means the message is read when the user reaches the field, however they got there. `aria-invalid` marks the field itself as failing, so it is announced as invalid rather than merely described.',
                },
                {
                  title: 'Make it announce itself',
                  code: `<p id="email-error" role="alert">Enter an email address in the format name@example.com</p>`,
                  reasoning:
                    'Without this, a message that appears after a failed submit is silent — the user is left waiting for a response that already happened. This is the step most often missed, because nothing about the page looks wrong without it.',
                },
              ],
            ),
            callout(
              'mistake',
              '`required` is a hint, never a guarantee',
              'Client-side validation attributes — `required`, `pattern`, `type="email"`, `maxlength` — improve the experience for people filling the form honestly. They are enforced by the browser, so they stop nobody who does not want to be stopped. The server must check everything again, and Level 10 makes the same point about security.',
            ),
            checklist('Before you ship a form', [
              'Every control has a `<label>` with a matching `for` and `id`',
              'Every group of related controls sits in a `<fieldset>` with a `<legend>`',
              'Every field about the user has an `autocomplete` token',
              'Errors say what is wrong *and* how to fix it',
              'Errors are connected with `aria-describedby` and marked with `aria-invalid`',
              'Errors announce themselves, or focus moves to the first failing field',
              'Paste is allowed everywhere, especially on passwords',
              'Nothing is asked for twice in the same process',
            ]),
            demo('An error message, connected and unconnected', 'The same failure, reported three ways.', [
              {
                label: 'Fully connected',
                code: '<p id="email-error" role="alert">Enter an email address in the format name@example.com</p>\n<label for="email">Email address</label>\n<input type="email" id="email" name="email" aria-describedby="email-error" aria-invalid="true">',
                note: 'Announced when it appears, read again when the field is reached, and the field itself reports as invalid.',
              },
              {
                label: 'Visible only',
                code: '<p class="error">Enter an email address in the format name@example.com</p>\n<label for="email">Email address</label>\n<input type="email" id="email" name="email">',
                note: 'Perfectly visible and completely silent. Nothing announces it, and reaching the field tells the user nothing is wrong.',
              },
              {
                label: 'Connected but silent',
                code: '<p id="email-error">Enter an email address in the format name@example.com</p>\n<label for="email">Email address</label>\n<input type="email" id="email" name="email" aria-describedby="email-error" aria-invalid="true">',
                note: 'Better — reaching the field now reads the message — but nothing is announced when it first appears, so a user who submitted and waited hears nothing at all.',
              },
            ]),
            recap(
              [
                'A control with no label has no name, and cannot be reached by voice.',
                '`<fieldset>` and `<legend>` are what make a group of radios a question rather than a list.',
                '`autocomplete` is a WCAG requirement for fields about the user, not a nicety.',
                'A usable error says what is wrong, how to fix it, is connected with `aria-describedby`, and is announced.',
              ],
              'Next: the milestone — a page written to fail, for you to repair.',
            ),
            activeRecap(
              [
                'Why is a placeholder not a label?',
                'What do `<fieldset>` and `<legend>` add that labels alone cannot?',
                'List the four things a usable error message needs.',
              ],
              [
                'Because it supplies no accessible name, and it disappears as soon as the user starts typing — removing the only hint at exactly the moment it is needed.',
                'They name the *group*, so a set of radio buttons is announced together with the question it answers instead of as unrelated options.',
                'It says what is wrong; it says how to fix it; it is connected to the field with `aria-describedby` and `aria-invalid`; and it announces itself with `role="alert"` or focus moves to the failing field.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'accessible-form-challenge',
              kind: 'challenge',
              title: 'Build an accessible booking form',
              brief:
                'Build a form containing: a name field, an email field, a grouped pair of radio buttons asking how to contact the person, and a submit button. Every control labelled, the radios grouped with a legend, and `autocomplete` on the fields about the user. Your wording throughout.',
              starterCode: `<h1>Book a table</h1>
<form action="/book" method="post">

</form>`,
              referenceSolution: `<h1>Book a table</h1>
<form action="/book" method="post">
  <label for="name">Full name</label>
  <input type="text" id="name" name="name" autocomplete="name" required>

  <label for="email">Email address</label>
  <input type="email" id="email" name="email" autocomplete="email" required>

  <fieldset>
    <legend>How should we confirm your booking?</legend>

    <input type="radio" id="by-email" name="contact" value="email">
    <label for="by-email">By email</label>

    <input type="radio" id="by-phone" name="contact" value="phone">
    <label for="by-phone">By phone</label>
  </fieldset>

  <button type="submit">Request a table</button>
</form>`,
              hints: [
                'Each input needs an id, and each label needs a for matching it.',
                'Wrap the two radio buttons in a <fieldset> and give it a <legend>.',
                'autocomplete="name" and autocomplete="email" are the tokens for those two fields.',
                'The submit control is <button type="submit">, not an <input type="button">.',
              ],
              requirements: [
                present('form', 'There is a form'),
                labelled('input', 'Every input has an associated label'),
                present('fieldset', 'The related radio buttons are grouped in a fieldset'),
                directChild('legend', 'fieldset', 'The fieldset has a legend naming the group'),
                notEmpty('legend', 'The legend asks the question'),
                count('input[type="radio"]', 2, null, 'There are at least two radio options'),
                attrValue('input[type="email"]', 'autocomplete', 'email', 'The email field carries autocomplete="email"'),
                present('button[type="submit"]', 'There is a submit button'),
                uniqueIds(),
              ],
              difficulty: 4,
              xp: 60,
              skill: 'accessibility',
            },
            {
              slug: 'accessible-form-debug',
              kind: 'debug',
              title: 'A form nobody can complete',
              brief:
                'This form has four failures: a placeholder standing in for a label, radios with no group or legend, an error message connected to nothing, and a missing `autocomplete`. Repair all four.',
              starterCode: `<form action="/book" method="post">
  <input type="text" name="name" placeholder="Full name">

  <p id="name-error">That is not valid</p>

  <input type="radio" id="by-email" name="contact" value="email">
  <label for="by-email">By email</label>
  <input type="radio" id="by-phone" name="contact" value="phone">
  <label for="by-phone">By phone</label>

  <button type="submit">Send</button>
</form>`,
              referenceSolution: `<form action="/book" method="post">
  <label for="name">Full name</label>
  <input type="text" id="name" name="name" autocomplete="name"
         aria-describedby="name-error" aria-invalid="true">

  <p id="name-error" role="alert">Enter your full name as it appears on your card</p>

  <fieldset>
    <legend>How should we confirm your booking?</legend>

    <input type="radio" id="by-email" name="contact" value="email">
    <label for="by-email">By email</label>
    <input type="radio" id="by-phone" name="contact" value="phone">
    <label for="by-phone">By phone</label>
  </fieldset>

  <button type="submit">Send</button>
</form>`,
              hints: [
                'Replace the placeholder with a real <label for="name">, and give the input a matching id.',
                'Wrap the two radios in a <fieldset> with a <legend>.',
                'Connect the message with aria-describedby, mark the field aria-invalid, and give the message role="alert".',
                'The name field should carry autocomplete="name".',
              ],
              requirements: [
                labelled('input[type="text"]', 'The text field has a real label'),
                attrValue('input[type="text"]', 'autocomplete', 'name', 'The name field carries autocomplete="name"'),
                attrValue('input[type="text"]', 'aria-describedby', 'name-error', 'The error message is connected to the field'),
                attrValue('p', 'role', 'alert', 'The error message announces itself'),
                present('fieldset', 'The radios are grouped in a fieldset'),
                directChild('legend', 'fieldset', 'The group has a legend'),
                uniqueIds(),
              ],
              difficulty: 4,
              xp: 55,
              skill: 'accessibility',
            },
          ],
          quiz: [
            {
              slug: 'q-placeholder-not-label',
              prompt: 'Why is a placeholder not an acceptable substitute for a `<label>`?',
              explanation:
                'It gives the control no accessible name, and it vanishes as soon as the user starts typing.',
              options: [
                { label: 'It supplies no accessible name and disappears once typing starts', correct: true },
                { label: 'It cannot be styled' },
                { label: 'It is not supported in older browsers' },
                { label: 'It is only a problem on mobile' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-fieldset-legend',
              prompt: 'What do `<fieldset>` and `<legend>` provide for a set of radio buttons?',
              explanation:
                'They name the group, so the options are announced together with the question they answer.',
              options: [
                { label: 'A name for the group, so the question is announced with the options', correct: true },
                { label: 'They make the radios mutually exclusive' },
                { label: 'They are purely decorative' },
                { label: 'They set the tab order for the group' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-autocomplete-requirement',
              prompt: 'Why does `autocomplete` matter for accessibility, not just convenience?',
              explanation:
                'WCAG requires it on fields collecting information about the user, so browsers and assistive tools can fill in details that are slow or painful to type.',
              options: [
                { label: 'It lets tools fill in details some people cannot type quickly or accurately', correct: true },
                { label: 'It makes form submission faster on the server' },
                { label: 'It replaces the need for a label' },
                { label: 'It validates the value for you' },
              ],
              skill: 'accessibility',
            },
          ],
        },
        {
          slug: 'accessibility-audit-milestone',
          title: 'Milestone: audit and repair an inaccessible site',
          subtitle: 'Fifteen deliberate failures, one page',
          summary:
            'The page in this milestone was written to fail. Your job is to find and fix everything.',
          objectives: [
            'Audit a page systematically against WCAG principles',
            'Repair every failure using correct HTML',
            'Produce a page that passes a keyboard test',
          ],
          estimatedMinutes: 30,
          skill: 'accessibility',
          masteryThreshold: 0.85,
          blocks: [
            objectives([
              'Run a systematic accessibility audit',
              'Repair structural, media and form accessibility failures',
              'Verify with a keyboard test',
            ]),
            checklist('Audit in this order — structure first', [
              'Does `<html>` declare a `lang`?',
              'Is there exactly one `<h1>`, and no skipped heading levels?',
              'Are there landmarks — header, nav, main, footer?',
              'Is there a skip link, and does it point at something real?',
              'Does every image have an appropriate `alt`?',
              'Does every form control have a `<label>`?',
              'Does every link have text that makes sense alone?',
              'Are buttons `<button>` and links `<a href>`?',
              'Are all ids unique?',
              'Does every `<iframe>` have a `title`?',
              'Do videos have captions?',
              'Are error messages connected with `aria-describedby`?',
            ]),
            callout(
              'tip',
              'Fix in order of impact',
              'A missing `<main>` affects every screen-reader user on every visit. A slightly wordy alt attribute affects almost nobody. When auditing a real site, deal with structure, names and keyboard access first — those are the things that make a page unusable rather than merely imperfect.',
            ),
            compare(
              'A typical repair, before and after',
              {
                label: 'After',
                code: `<label for="email">Email address</label>
<input type="email" id="email" name="email"
       autocomplete="email" required>`,
                why: 'Announced as "Email address, edit text". Clicking the words focuses the field. Autofill works.',
              },
              {
                label: 'Before',
                code: `<input type="text" placeholder="Email">`,
                why: 'Announced as "edit text" with no clue what it wants. The placeholder disappears on typing, and there is no autofill.',
              },
            ),
            code(
              `<!-- The five repairs that fix the most, fastest -->
<html lang="en">                          <!-- 1. declare the language -->
<title>Book a bike — Riverside</title>     <!-- 2. a unique page title -->
<a class="skip-link" href="#main">…</a>    <!-- 3. a skip link -->
<main id="main">…</main>                   <!-- 4. one main landmark -->
<label for="x">…</label><input id="x">     <!-- 5. label every control -->`,
              'The highest-impact repairs, in order',
            ),
            demo('One repair, three times over', 'The commonest three failures, before and after.', [
              {
                label: 'Repaired',
                code: '<label for="email">Email address</label>\n<input type="email" id="email" name="email" autocomplete="email">\n<button type="button">Search</button>\n<img src="/learning-media/images/team-portrait.jpg" alt="Priya Raman, head baker" width="800" height="800">',
                note: 'A named field, a real button, and an image described rather than named. All three announce usefully.',
              },
              {
                label: 'As found',
                code: '<input type="text" placeholder="Email">\n<div class="btn">Search</div>\n<img src="/learning-media/images/team-portrait.jpg" alt="portrait">',
                note: 'A field with no name, a control no keyboard can reach, and alt text that names the file type rather than the person.',
              },
            ]),
            recall(
              'This audit uses almost everything you have learned. Close the page and list, from memory, what you already know that applies here — grouped by where you learned it.',
              [
                'Level 2 — one `<h1>`, no skipped heading levels, because the outline is how many people navigate.',
                'Level 3 — link text that works alone; `rel="noopener noreferrer"` on anything opening in a new tab.',
                'Level 4 — alt text describes what the image *does on this page*; `alt=""` for decoration, and never a missing alt.',
                'Level 5 — landmarks, and exactly one `<main>`.',
                'Level 6 — every control labelled, related controls grouped in a `<fieldset>` with a `<legend>`.',
                'Level 7 — native `<details>` and `<dialog>` maintain their own state, so it cannot drift out of step.',
                'This level — keyboard operability first, accessible names second, and ARIA only where HTML cannot express it.',
              ],
              'Everything so far, applied at once',
            ),
            recap(
              [
                'Audit systematically, structure first.',
                'Almost every fix is a correct HTML element rather than an ARIA attribute.',
                'The keyboard test is your final check.',
              ],
              'Level 9 next: metadata, SEO and discoverability.',
            ),
          ],
          exercises: [
            {
              slug: 'a11y-audit-milestone',
              kind: 'challenge',
              title: 'Milestone: repair the inaccessible page',
              brief:
                'This page has around fifteen accessibility failures. Repair all of them. The content must stay the same — only the markup changes.',
              starterCode: `<html>
<head>
  <meta charset="utf-8">
</head>
<body>
  <div class="header">
    <div class="nav">
      <a href="index.html">Home</a>
      <a href="routes.html">Routes</a>
      <a href="contact.html">Contact</a>
    </div>
  </div>

  <div class="content">
    <div class="big-title">Book a bike</div>

    <h3>Choose your route</h3>
    <img src="/learning-media/images/forest-path.jpg" width="1200" height="800">

    <p>For route details <a href="routes.html">click here</a>.</p>

    <form action="/booking" method="post">
      <input type="text" id="name" placeholder="Your name">
      <input type="text" id="name" placeholder="Your email">
      <div class="submit" onclick="send()">Send</div>
    </form>

    <iframe src="https://example.org/map" width="600" height="400"></iframe>
  </div>

  <div class="footer">© 2026 Riverside Cycle Hire</div>
</body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Book a bike — Riverside Cycle Hire</title>
</head>
<body>
  <a class="skip-link" href="#main">Skip to main content</a>

  <header>
    <nav aria-label="Main">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="routes.html">Routes</a></li>
        <li><a href="contact.html" aria-current="page">Contact</a></li>
      </ul>
    </nav>
  </header>

  <main id="main">
    <h1>Book a bike</h1>

    <h2>Choose your route</h2>
    <img src="/learning-media/images/forest-path.jpg"
         alt="A sandy path winding between tall trees in a sunlit forest"
         width="1200" height="800">

    <p>Read our <a href="routes.html">full route descriptions</a>.</p>

    <form action="/booking" method="post">
      <label for="name">Your name</label>
      <input type="text" id="name" name="name" autocomplete="name" required>

      <label for="email">Your email</label>
      <input type="email" id="email" name="email" autocomplete="email" required>

      <button type="submit">Send</button>
    </form>

    <iframe src="https://example.org/map"
            title="Map showing the workshop on Mill Lane"
            width="600" height="400" loading="lazy"
            sandbox="allow-scripts"></iframe>
  </main>

  <footer>
    <p>© 2026 Riverside Cycle Hire</p>
  </footer>
</body>
</html>`,
              hints: [
                'Start at the top: the doctype is missing, and <html> has no lang.',
                'There is no <title>. Every page needs one.',
                'The divs should be landmarks: header, nav, main, footer. Add a skip link targeting main.',
                'The "big-title" div is really the h1, which means the h3 below it should be an h2.',
                'The image has no alt, the link says "click here", and both inputs share the id "name".',
                'The submit div should be a <button type="submit">, and each input needs a real label.',
                'The iframe has no title.',
              ],
              requirements: [
                { kind: 'attribute_present', selector: 'html', attribute: 'lang', message: 'The html element declares a language', hint: 'Add lang="en".' },
                { kind: 'doctype', message: 'The document has a doctype' },
                unique('title', 'The page has a title'),
                notEmpty('title', 'The title is not empty'),
                present('header', 'There is a header landmark'),
                unique('main', 'There is exactly one main landmark'),
                present('footer', 'There is a footer landmark'),
                present('nav', 'The navigation uses a nav element'),
                attr('nav', 'aria-label', 'The nav has an accessible name'),
                attrValue('a', 'href', '#main', 'There is a skip link targeting main'),
                unique('h1', 'There is exactly one h1'),
                headingOrder(),
                goodAlt('img', 'The image has meaningful alt text'),
                labelled('input', 'Every form control has a label'),
                uniqueIds(),
                present('button[type="submit"]', 'The submit control is a real button'),
                { kind: 'element_count', selector: '[onclick]', minCount: 0, maxCount: 0, message: 'No inline click handlers on non-interactive elements' },
                attr('iframe', 'title', 'The iframe has a title'),
                { kind: 'element_absent', selector: 'a[href="routes.html"] ~ *', message: 'Link text describes its destination', hint: 'Replace "click here" with text describing where the link goes.' },
                legalNesting(),
              ],
              difficulty: 5,
              xp: 180,
              skill: 'accessibility',
            },
            {
              slug: 'a11y-mission',
              kind: 'project_mission',
              title: 'Capstone mission: audit your own site',
              brief:
                'Run the audit checklist over one of your capstone pages and fix everything it turns up. Then Tab through it: every interactive element reachable, focus always visible, order matching the layout.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page title — your site</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Your page heading</h1>
      <!-- Check every image, link, control and heading below -->
    </main>
    <footer>
      <p>© 2026 Your site</p>
    </footer>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About us — Riverside Cycle Hire</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html" aria-current="page">About</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>About us</h1>
      <p>We have hired bikes from Mill Lane since 1998.</p>
      <h2>Our workshop</h2>
      <img src="/learning-media/images/workshop-tools-1200.jpg"
           alt="Hand tools hanging in rows above a workbench"
           loading="lazy" width="1200" height="800">
      <p>Read our <a href="prices.html">current hire prices</a>.</p>
    </main>
    <footer>
      <p>© 2026 Riverside Cycle Hire</p>
    </footer>
  </body>
</html>`,
              hints: [
                'Work down the audit checklist item by item.',
                'Mark the current page with aria-current="page" in the nav.',
                'Check every image has appropriate alt text and every link makes sense alone.',
              ],
              requirements: [
                { kind: 'attribute_present', selector: 'html', attribute: 'lang', message: 'The page declares its language' },
                unique('title', 'The page has its own title'),
                attrValue('a', 'href', '#main', 'The skip link is present'),
                unique('main', 'There is one main landmark'),
                present('header', 'There is a header'),
                present('footer', 'There is a footer'),
                unique('h1', 'Exactly one h1'),
                headingOrder(),
                goodAlt('img', 'Images have appropriate alt text'),
                named('a', 'Every link has an accessible name'),
                uniqueIds(),
              ],
              difficulty: 4,
              xp: 110,
              skill: 'accessibility',
            },
          ],
          quiz: [
            {
              slug: 'q-audit-order',
              prompt: 'Which failure has the greatest impact on a screen-reader user?',
              explanation:
                'Missing landmarks force the user to read from the top of every page, every time. That is a structural failure affecting every visit.',
              options: [
                { label: 'No landmarks, so there is no way to skip to the content', correct: true },
                { label: 'Alt text that is slightly too wordy' },
                { label: 'A missing meta description' },
                { label: 'A heading styled at the wrong size' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-duplicate-id-impact',
              prompt: 'Why do duplicate ids break accessibility?',
              explanation:
                'Relationships like `for`, `aria-labelledby` and `aria-describedby` resolve to the first match, so a label may connect to the wrong control.',
              options: [
                { label: 'Label and description relationships resolve to the wrong element', correct: true },
                { label: 'The page will not render' },
                { label: 'Screen readers skip both elements' },
                { label: 'It only affects CSS' },
              ],
              skill: 'validation',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'level-8-milestone',
    kind: 'milestone',
    title: 'Level 8 milestone: Accessibility Champion',
    description: 'Nine questions on accessibility and ARIA. Pass mark 80% — this level matters.',
    passScore: 0.8,
    xp: 220,
    questions: [
      {
        slug: 'a8-q1',
        prompt: 'What are the four WCAG principles?',
        explanation: 'Perceivable, Operable, Understandable, Robust.',
        options: [
          { label: 'Perceivable, Operable, Understandable, Robust', correct: true },
          { label: 'Visible, Clickable, Readable, Fast' },
          { label: 'Semantic, Styled, Scripted, Secure' },
          { label: 'Structure, Style, Behaviour, Content' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'a8-q2',
        prompt: 'Which gives a keyboard user the most benefit on a site with a large menu?',
        explanation: 'A skip link, letting them bypass the menu on every page.',
        options: [
          { label: 'A skip link', correct: true },
          { label: 'A larger font size' },
          { label: 'aria-label on every link' },
          { label: 'A sitemap page' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'a8-q3',
        prompt: 'What does `aria-describedby` do?',
        explanation:
          'It attaches additional descriptive text, announced after the element\'s name — ideal for format hints and error messages.',
        options: [
          { label: 'Attaches extra description read after the name', correct: true },
          { label: 'Replaces the accessible name' },
          { label: 'Hides the element from screen readers' },
          { label: 'Marks the element as invalid' },
        ],
        skill: 'aria',
      },
      {
        slug: 'a8-q4',
        prompt: 'When should you use `aria-hidden="true"`?',
        explanation:
          'Only on genuinely decorative content that adds nothing — never on anything a user might need.',
        options: [
          { label: 'On purely decorative content', correct: true },
          { label: 'On content that is visually hidden but still needed' },
          { label: 'On any element with an aria-label' },
          { label: 'On form fields that are not required' },
        ],
        skill: 'aria',
      },
      {
        slug: 'a8-q5',
        prompt: 'An icon-only button contains an `<img>`. Where should the accessible name come from?',
        explanation:
          '`aria-label` on the button, with `alt=""` on the image so the name is not announced twice.',
        options: [
          { label: 'aria-label on the button, with alt="" on the image', correct: true },
          { label: 'Alt text on the image, with no aria-label' },
          { label: 'A title attribute on the button' },
          { label: 'Both the alt and an aria-label, to be safe' },
        ],
        skill: 'aria',
      },
      {
        slug: 'a8-q6',
        prompt: 'What makes an error message accessible?',
        explanation:
          'Plain words, a stated fix, connection to the field with `aria-describedby`, and an announcement when it appears.',
        options: [
          { label: 'Plain words, a fix, aria-describedby, and an announcement', correct: true },
          { label: 'Red text and a warning icon' },
          { label: 'A tooltip on the field' },
          { label: 'A summary at the bottom of the page' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'a8-q7',
        prompt: 'Does adding `role="navigation"` to a `<nav>` improve anything?',
        explanation: 'No — `<nav>` already has that role. The extra attribute is redundant noise.',
        options: [
          { label: 'No — <nav> already has that role', correct: true },
          { label: 'Yes, it improves older screen-reader support' },
          { label: 'Yes, it is required by WCAG' },
          { label: 'Yes, it makes the landmark focusable' },
        ],
        skill: 'aria',
      },
      {
        slug: 'a8-q8',
        prompt: 'What determines keyboard focus order by default?',
        explanation: 'The order elements appear in the HTML source.',
        options: [
          { label: 'The order of elements in the HTML source', correct: true },
          { label: 'Their visual position on screen' },
          { label: 'Their tabindex values, always' },
          { label: 'Alphabetical order of their ids' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'a8-q9',
        prompt: 'A page has an `<a>` with no `href`. What is the problem?',
        explanation:
          'Without an `href` it is not a link: it cannot be focused with a keyboard and is not announced as a link.',
        options: [
          { label: 'It is not focusable and not announced as a link', correct: true },
          { label: 'It will not be styled as a link' },
          { label: 'It fails HTML validation' },
          { label: 'Nothing — href is optional' },
        ],
        skill: 'accessibility',
      },
    ],
  },
};
