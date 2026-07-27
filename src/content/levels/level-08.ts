import {
  annotated,
  attr,
  attrValue,
  callout,
  checklist,
  code,
  compare,
  demo,
  detail,
  goodAlt,
  headingOrder,
  labelled,
  legalNesting,
  named,
  notEmpty,
  objectives,
  present,
  prose,
  recap,
  term,
  unique,
  uniqueIds,
  visual,
  type LevelSpec,
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
            detail(
              'When ARIA is genuinely the right answer',
              'ARIA earns its place where HTML has no equivalent: naming a landmark that has no visible heading; announcing a change that happens without a page load; marking the current item in a set; describing a relationship between elements that are not nested. Those are real gaps, and ARIA fills them well. What it cannot do is turn a `<div>` into a working control.',
            ),
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
