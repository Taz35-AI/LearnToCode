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
  doctype,
  goodAlt,
  headingOrder,
  labelled,
  legalNesting,
  mediaResolves,
  noObsolete,
  notEmpty,
  objectives,
  present,
  prose,
  recap,
  term,
  unique,
  uniqueIds,
  type LevelSpec,
} from '../types';

export const LEVEL_11: LevelSpec = {
  slug: 'debugging-and-validation',
  title: 'Debugging and Validation Master',
  subtitle: 'Find the problem, fix the problem, prove it is fixed',
  summary:
    'Every developer writes broken markup. What separates the professionals is how quickly they find it. This level is about validators, developer tools, and a debugging method that works.',
  outcome: 'You can take a broken multi-page site and repair every fault methodically.',
  accent: 'red',
  modules: [
    {
      slug: 'validation-and-tools',
      title: 'Validation and developer tools',
      summary:
        'What a validator checks, what it cannot check, and how to use the tools already in your browser.',
      estimatedMinutes: 45,
      prerequisites: ['html-performance'],
      skills: [{ slug: 'validation', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'reading-validation-output',
          title: 'Reading validation output',
          subtitle: 'Errors, warnings, and the ones that are not really problems',
          summary:
            'A validator is a spell-checker for markup. Learning to read its output is a twenty-minute skill that pays back forever.',
          objectives: [
            'Interpret common validator messages',
            'Fix invalid nesting, unclosed tags and duplicate ids',
            'Explain what a validator cannot tell you',
          ],
          estimatedMinutes: 15,
          skill: 'validation',
          blocks: [
            objectives([
              'Read and act on validator messages',
              'Recognise the five commonest validation errors',
              'Explain the limits of automated validation',
            ]),
            term(
              'Validation',
              'Checking your markup against the HTML specification. The official checker lives at validator.w3.org and will check a URL, a file or pasted markup.',
            ),
            prose('These five account for most real-world validation errors.'),
            code(
              `1. "End tag X seen, but there were open elements"
   → An element was left unclosed. The named tag is where it was noticed,
     not where the mistake is — look above it.

2. "Duplicate ID x"
   → Two elements share an id. Labels and aria references will now point
     at the wrong one.

3. "Element X not allowed as child of element Y"
   → Invalid nesting: a <div> inside a <p>, an <li> outside a list.

4. "Attribute X not allowed on element Y"
   → A mis-typed attribute, or one that belongs on a different element.

5. "Element head is missing a required instance of child element title"
   → Something mandatory is absent.`,
              'The five you will meet most',
              'text',
            ),
            callout(
              'tip',
              'Fix one error, then re-run',
              'A single unclosed `<div>` can produce twenty errors, because every subsequent structural check is thrown off. Fix the first error in the list, re-run the validator, and watch most of the rest disappear. Working down the list fixing everything is slower and often introduces new mistakes.',
            ),
            compare(
              'The same mistake, seen two ways',
              {
                label: 'What the validator says',
                code: 'Line 14: End tag "main" seen, but there were open elements.\nLine 9: Unclosed element "section".',
                why: 'Two messages describing one mistake. The second is the useful one: the real problem is on line 9.',
              },
              {
                label: 'What is actually wrong',
                code: '<main>\n  <section>\n    <h2>Routes</h2>\n    <p>Three loops from the door.</p>\n</main>',
                why: 'The `<section>` on line 2 was never closed. One missing tag, two error messages.',
              },
            ),
            callout(
              'warning',
              'What a validator cannot tell you',
              'It checks grammar, not meaning. A page can validate perfectly and still be unusable: alt text saying "image", a heading hierarchy that jumps from h1 to h4, links reading "click here", a `<div>` acting as a button, a form with no labels. Validation is a floor, not a ceiling — necessary, and nowhere near sufficient.',
            ),
            demo('Valid but wrong', 'Both of these pass the validator.', [
              {
                label: 'Valid and good',
                code: '<main>\n  <h1>Prices</h1>\n  <h2>Hourly</h2>\n  <p>From £6.</p>\n</main>',
                note: 'Valid markup, sound structure, correct heading order.',
              },
              {
                label: 'Valid and bad',
                code: '<div>\n  <div class="h1">Prices</div>\n  <h4>Hourly</h4>\n  <p>From £6.</p>\n</div>',
                note: 'Also completely valid. No landmark, no h1, a skipped heading level, and a fake heading. The validator has nothing to say about any of it.',
              },
            ]),
            detail(
              'Other checks worth running',
              'The W3C validator for HTML grammar. An automated accessibility checker such as axe or the browser\'s built-in accessibility audit for names, contrast and roles. A link checker for broken hrefs. And your own eyes for the things no tool can judge: whether the alt text is useful, whether the heading order describes the real structure, whether the link text makes sense out of context. Automated tools reliably catch roughly a third of accessibility issues — the rest need a person.',
            ),
            recap(
              [
                'A validator checks grammar against the specification.',
                'Fix the first error, then re-run — one mistake often causes many messages.',
                'The error line is where the problem was *noticed*, not always where it is.',
                'Valid markup can still be badly structured and inaccessible.',
              ],
              'Next: developer tools.',
            ),
          ],
          exercises: [
            {
              slug: 'validation-debug',
              kind: 'debug',
              title: 'Five validation errors',
              brief:
                'This markup produces five validator errors: an unclosed element, a duplicate id, invalid nesting, an obsolete element, and a missing required child. Fix all five.',
              starterCode: `<html lang="en">
  <head>
    <meta charset="utf-8">
  </head>
  <body>
    <main id="main">
      <h1 id="title">Route guides</h1>
      <section>
        <h2 id="title">Easy routes</h2>
        <p>Both of these are flat.<div>Six miles.</div></p>
      <center>All routes start at the workshop.</center>
    </main>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Route guides — Riverside Cycle Hire</title>
  </head>
  <body>
    <main id="main">
      <h1 id="page-title">Route guides</h1>
      <section>
        <h2 id="section-title">Easy routes</h2>
        <p>Both of these are flat.</p>
        <p>Six miles.</p>
      </section>
      <p>All routes start at the workshop.</p>
    </main>
  </body>
</html>`,
              hints: [
                'The <head> has no <title>, which is required.',
                'Two elements both use id="title" — give them different ids.',
                'A <div> cannot go inside a <p>. Make it a separate paragraph.',
                'The <section> is never closed.',
                '<center> was removed from HTML — use a paragraph instead.',
              ],
              requirements: [
                unique('title', 'The head has a title'),
                uniqueIds(),
                legalNesting(),
                noObsolete(),
                present('section', 'The section element is properly closed'),
                { kind: 'element_count', selector: 'p > div', minCount: 0, maxCount: 0, message: 'No block element is nested inside a paragraph' },
              ],
              difficulty: 4,
              xp: 65,
              skill: 'validation',
            },
          ],
          quiz: [
            {
              slug: 'q-validator-order',
              prompt: 'A validator reports twenty errors. What should you do first?',
              explanation:
                'Fix the first one and re-run. A single unclosed element can produce most of the rest.',
              options: [
                { label: 'Fix the first error, then re-validate', correct: true },
                { label: 'Fix them from the bottom up' },
                { label: 'Fix all twenty before re-checking' },
                { label: 'Ignore them if the page looks right' },
              ],
              skill: 'validation',
            },
            {
              slug: 'q-validator-limits',
              prompt: 'Which problem will a validator NOT report?',
              explanation:
                'Alt text quality is a judgement about meaning. A validator only checks that the attribute exists.',
              options: [
                { label: 'alt="image" on a photograph', correct: true },
                { label: 'A duplicate id' },
                { label: 'An unclosed <div>' },
                { label: 'A <li> outside any list' },
              ],
              skill: 'validation',
            },
            {
              slug: 'q-duplicate-id-effect',
              prompt: 'Why are duplicate ids a real problem, not just a technicality?',
              explanation:
                'Every relationship that references an id — `for`, `aria-labelledby`, `aria-describedby`, fragment links — resolves to the first match, so connections silently point at the wrong element.',
              options: [
                { label: 'Label and ARIA relationships silently resolve to the wrong element', correct: true },
                { label: 'The page will not load' },
                { label: 'CSS stops working entirely' },
                { label: 'Both elements are hidden' },
              ],
              skill: 'validation',
            },
          ],
        },
        {
          slug: 'developer-tools',
          title: 'Browser developer tools',
          subtitle: 'Inspecting the DOM, testing the keyboard, finding broken paths',
          summary:
            'Everything you need to debug a page is already in your browser, behind one keyboard shortcut.',
          objectives: [
            'Inspect the live DOM and see how the browser repaired your markup',
            'Find broken paths in the network panel',
            'Test keyboard order and inspect the accessibility tree',
          ],
          estimatedMinutes: 14,
          skill: 'debugging',
          blocks: [
            objectives([
              'Open developer tools and inspect an element',
              'Diagnose a broken media path from the network panel',
              'Use the accessibility panel to check names and roles',
            ]),
            prose(
              'Press F12, or Ctrl+Shift+I (Cmd+Option+I on a Mac). Four panels do almost everything you need.',
            ),
            code(
              `Elements / Inspector
  The live DOM — what the browser actually built, after repairing any
  mistakes. Comparing this with your source file is the fastest way to
  find an unclosed tag: the browser will have moved things somewhere
  surprising, and you can see exactly where.

Network
  Every file the page requested and what came back. A red 404 line
  is a broken path. Click it to see the exact URL requested — usually
  the typo is immediately obvious.

Console
  Errors and warnings. For HTML work this is mostly where you learn
  that a media file failed or a resource was blocked.

Accessibility
  The accessibility tree: the computed name, role and state of the
  selected element. If an element's name is empty here, a screen
  reader announces nothing.`,
              'The four panels that matter',
              'text',
            ),
            callout(
              'tip',
              'The trick that finds unclosed tags fastest',
              'Open the Elements panel and look at the indentation. If an element you expected to be a sibling appears as a *child* of the one above it, you have found your missing closing tag. The browser silently repaired the document, and the repair is visible right there in the tree.',
            ),
            annotated(
              `What you wrote:          What the Elements panel shows:

<main>                   <main>
  <section>                <section>
    <h2>Routes</h2>          <h2>Routes</h2>
  <p>Three loops.</p>        <p>Three loops.</p>    ← now inside section
</main>                    </section>
                         </main>`,
              [
                {
                  line: '1',
                  text: 'The `<section>` was never closed, so the browser assumed it should wrap everything up to `</main>`.',
                },
                {
                  line: '4',
                  text: 'The paragraph you meant to be a sibling of the section became its child. The indentation in the panel gives it away instantly.',
                },
              ],
              'Source versus repaired DOM',
            ),
            checklist('A five-minute debugging routine', [
              'Open the Network panel and reload — any red lines are broken paths',
              'Open Elements and check the indentation matches what you wrote',
              'Tab through the page — is everything reachable, is focus visible',
              'Select an interactive element and check its accessible name',
              'Run the page through the W3C validator',
            ]),
            term(
              'Device toolbar',
              'A developer-tools mode that simulates a phone or tablet viewport. Useful for checking that responsive images and layouts behave — though it simulates size, not the real device.',
            ),
            callout(
              'note',
              'Cross-browser testing, briefly',
              'Modern browsers agree on HTML far more than they used to; genuine differences are now mostly in newer features. A practical approach: build to the standard, test in one Chromium browser and one Firefox, check a real phone if you can, and consult caniuse.com before relying on anything recent. Do not write browser-specific markup — that habit causes more problems than it solves.',
            ),
            detail(
              'Debugging as a method',
              'The method that works is boring and reliable. Change one thing. Test. If it did not help, put it back. Beginners often change four things at once, see the page improve, and have no idea which change did it — so the next similar bug takes just as long. Narrow the problem before fixing it: delete half the page and see if the bug persists; if it does, the cause is in the remaining half. Three or four rounds of that will locate almost anything.',
            ),
            recap(
              [
                'Elements shows the repaired DOM — indentation reveals unclosed tags.',
                'Network shows broken paths as 404s with the exact URL requested.',
                'The Accessibility panel shows computed names and roles.',
                'Change one thing at a time, and narrow before you fix.',
              ],
              'Next: repair a whole broken site.',
            ),
          ],
          exercises: [
            {
              slug: 'devtools-debug',
              kind: 'debug',
              title: 'Four broken paths',
              brief:
                'Every media path on this page 404s. Use the media library to find the correct paths and fix all four.',
              starterCode: `<img src="/learning-media/images/coast-sunrise-900.jpg" alt="Sunrise over a calm sea" width="1200" height="800">
<img src="/learning-media/img/forest-path-800.jpg" alt="A sandy path between tall trees" width="800" height="534">
<video controls poster="/learning-media/posters/page-anatomy.png" width="1280" height="720">
  <source src="/learning-media/video/page-anatomy.mov" type="video/quicktime">
</video>`,
              referenceSolution: `<img src="/learning-media/images/coast-sunrise-800.jpg" alt="Sunrise over a calm sea" width="800" height="534">
<img src="/learning-media/images/forest-path-800.jpg" alt="A sandy path between tall trees" width="800" height="534">
<video controls poster="/learning-media/posters/page-anatomy.jpg" width="1280" height="720">
  <source src="/learning-media/video/page-anatomy.webm" type="video/webm">
  <source src="/learning-media/video/page-anatomy.mp4" type="video/mp4">
</video>`,
              hints: [
                'The library provides widths of 480, 800, 1200 and 1600 — there is no 900.',
                'The folder is "images", not "img".',
                'The poster is a .jpg, not a .png.',
                'The video is available as .webm and .mp4, not .mov.',
              ],
              requirements: [
                mediaResolves('img, source, video'),
                count('img', 2, 2, 'Both images are still present'),
                present('video source', 'The video still has a source'),
                attr('video', 'poster', 'The video still has a poster'),
                goodAlt('img'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'debugging',
            },
          ],
          quiz: [
            {
              slug: 'q-elements-panel',
              prompt: 'How does the Elements panel help you find an unclosed tag?',
              explanation:
                'It shows the repaired DOM, so an element that should be a sibling appears indented as a child — which reveals where the closing tag is missing.',
              options: [
                { label: 'It shows the repaired DOM, where the wrong nesting is visible', correct: true },
                { label: 'It highlights unclosed tags in red' },
                { label: 'It shows your original source file' },
                { label: 'It runs the W3C validator automatically' },
              ],
              skill: 'debugging',
            },
            {
              slug: 'q-network-404',
              prompt: 'Which panel shows a broken image path?',
              explanation: 'Network — the request appears with a 404 status and the exact URL requested.',
              options: [
                { label: 'Network', correct: true },
                { label: 'Console only' },
                { label: 'Sources' },
                { label: 'Performance' },
              ],
              skill: 'debugging',
            },
            {
              slug: 'q-one-change',
              prompt: 'Why change one thing at a time when debugging?',
              explanation:
                'Otherwise you cannot tell which change fixed it, and you learn nothing that helps with the next similar bug.',
              options: [
                { label: 'So you know which change actually fixed it', correct: true },
                { label: 'Because browsers cache multiple changes' },
                { label: 'To keep the file smaller' },
                { label: 'Because the validator only reports one error at a time' },
              ],
              skill: 'debugging',
            },
          ],
        },
        {
          slug: 'debugging-milestone',
          title: 'Milestone: repair a broken site',
          subtitle: 'Every category of fault, one page',
          summary:
            'A page with structural, semantic, accessibility, media and validation faults. Repair all of them.',
          objectives: [
            'Diagnose faults across every category covered so far',
            'Repair methodically rather than by guessing',
            'Verify with the checklist',
          ],
          estimatedMinutes: 30,
          skill: 'debugging',
          masteryThreshold: 0.85,
          blocks: [
            objectives([
              'Find and fix faults across structure, semantics, media and accessibility',
              'Work methodically from structure outwards',
              'Verify each fix rather than assuming it worked',
            ]),
            checklist('Repair in this order', [
              'Document: doctype, lang, charset, viewport, title',
              'Structure: landmarks, one main, heading hierarchy',
              'Validation: unclosed tags, duplicate ids, invalid nesting, obsolete elements',
              'Links: broken paths, missing hrefs, meaningless link text',
              'Media: broken paths, missing alt, missing dimensions',
              'Forms: labels, names, button types',
              'Finally: run the keyboard test',
            ]),
            callout(
              'tip',
              'Resist the urge to rewrite',
              'When a page is this broken it is tempting to delete it and start again. In real work you almost never can — the content matters, and somebody else wrote it. Practising methodical repair is the point of this exercise.',
            ),
            code(
              `1. <!DOCTYPE html>   missing?          → add it, first line
2. <html lang>       missing?          → add lang="en"
3. <title>           missing?          → every page needs its own
4. landmarks         divs everywhere?  → header, nav, main, footer
5. headings          skipped levels?   → one h1, step down one at a time
6. ids               duplicated?       → make each unique
7. nesting           div inside p?     → separate them
8. obsolete          <center>, <font>? → replace with real elements
9. media             404s? no alt?     → fix paths, describe images
10. forms            unlabelled?       → <label for> on every control`,
              'The repair order, as a working checklist',
              'text',
            ),
            compare(
              'One mistake, many error messages',
              {
                label: 'The validator output',
                code: `Line 14: End tag "main" seen, but there were open elements.
Line 9:  Unclosed element "section".
Line 15: Stray end tag "div".`,
                why: 'Three messages. Fix the one on line 9 and re-run — the other two usually vanish with it.',
              },
              {
                label: 'The actual fault',
                code: `<main>
  <section>          ← opened on line 9
    <h2>Routes</h2>
</main>              ← never closed`,
                why: 'A single missing closing tag. This is why you fix the first error and re-validate rather than working down the list.',
              },
            ),
            recap(
              [
                'Structure first, then validation, then content-level faults.',
                'Verify each fix; do not assume.',
                'This is the single most employable skill in the whole course.',
              ],
              'Level 12 next: the capstone.',
            ),
          ],
          exercises: [
            {
              slug: 'repair-milestone',
              kind: 'challenge',
              title: 'Milestone: repair the broken page',
              brief:
                'This page has faults in every category. Repair all of them, keeping the content the same.',
              starterCode: `<html>
<head>
<meta charset="utf-8">
</head>
<body>
<div class="top">
<a>Home</a>
<a href="about.html">About</a>
<a href="contact.html">Contact</a>
</div>

<div class="body">
<div class="title">Our routes</div>
<h4 id="r">Easy routes</h4>
<p>Flat and traffic-free.<div>Six miles.</div></p>
<h4 id="r">Harder routes</h4>
<img src="/learning-media/images/valley.jpg">
<p>For details <a href="routes.html">click here</a>.</p>
<center>All routes start at the workshop.</center>

<form action="/booking" method="post">
<input type="text" id="name" placeholder="Name">
<div onclick="send()">Send</div>
</form>
</div>

<div class="bottom">© 2026 Riverside Cycle Hire</div>
</body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Our routes — Riverside Cycle Hire</title>
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
    <h1>Our routes</h1>

    <h2 id="easy-routes">Easy routes</h2>
    <p>Flat and traffic-free.</p>
    <p>Six miles.</p>

    <h2 id="harder-routes">Harder routes</h2>
    <img src="/learning-media/images/forest-path-1200.jpg"
         alt="A sandy path winding between tall trees in a sunlit forest"
         loading="lazy" width="1200" height="800">

    <p>Read our <a href="routes.html">full route descriptions</a>.</p>
    <p>All routes start at the workshop.</p>

    <form action="/booking" method="post">
      <label for="name">Your name</label>
      <input type="text" id="name" name="name" autocomplete="name" required>
      <button type="submit">Send</button>
    </form>
  </main>

  <footer>
    <p>© 2026 Riverside Cycle Hire</p>
  </footer>
</body>
</html>`,
              hints: [
                'Start at the document level: no doctype, no lang, no viewport, no title.',
                'The three divs are landmarks: header, main, footer. Add a skip link and wrap the links in a nav with a list.',
                'The "title" div is really the h1, so the h4s become h2s. Both h4s also share id="r".',
                'A <div> cannot live inside a <p>. <center> is obsolete.',
                'The image path does not exist and has no alt or dimensions — use the media library.',
                '"Click here" tells a screen-reader user nothing. The first nav link has no href.',
                'The input needs a label and a name; the "Send" div should be a real button.',
              ],
              requirements: [
                doctype(),
                { kind: 'attribute_present', selector: 'html', attribute: 'lang', message: 'The html element declares a language' },
                present('meta[name="viewport"]', 'There is a viewport meta tag'),
                unique('title', 'The page has a title'),
                notEmpty('title', 'The title has text'),
                present('header', 'There is a header landmark'),
                unique('main', 'There is exactly one main landmark'),
                present('footer', 'There is a footer landmark'),
                present('nav', 'The links are in a nav'),
                attr('nav', 'aria-label', 'The nav is labelled'),
                count('nav li a', 3, 3, 'All three nav links are list items'),
                attr('a', 'href', 'Every link has an href'),
                attrValue('a', 'href', '#main', 'There is a skip link'),
                unique('h1', 'There is exactly one h1'),
                headingOrder(),
                uniqueIds(),
                legalNesting(),
                noObsolete(),
                { kind: 'element_count', selector: 'p > div', minCount: 0, maxCount: 0, message: 'No block element inside a paragraph' },
                goodAlt('img', 'The image has meaningful alt text'),
                attr('img', 'width', 'The image declares its dimensions'),
                mediaResolves('img'),
                labelled('input', 'The form control is labelled'),
                attr('input', 'name', 'The input has a name'),
                present('button[type="submit"]', 'The submit control is a real button'),
                { kind: 'element_count', selector: '[onclick]', minCount: 0, maxCount: 0, message: 'No inline click handlers remain' },
              ],
              difficulty: 5,
              xp: 200,
              skill: 'debugging',
            },
            {
              slug: 'validation-mission',
              kind: 'project_mission',
              title: 'Capstone mission: validate every page',
              brief:
                'Run every page of your capstone site through the checklist and fix everything you find. From here on, every page you add should pass first time.',
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
        <ul><li><a href="index.html">Home</a></li></ul>
      </nav>
    </header>
    <main id="main">
      <h1>Your page heading</h1>
      <!-- Check: unique ids? valid nesting? every image with alt and dimensions? -->
    </main>
    <footer><p>© 2026 Your site</p></footer>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Our routes — Riverside Cycle Hire</title>
    <meta name="description" content="Three waymarked routes starting at the Mill Lane workshop.">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="routes.html" aria-current="page">Routes</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Our routes</h1>
      <h2>Easy routes</h2>
      <p>Flat and traffic-free, starting at the workshop door.</p>
      <img src="/learning-media/images/forest-path-1200.jpg"
           alt="A sandy path winding between tall trees"
           loading="lazy" width="1200" height="800">
    </main>
    <footer><p>© 2026 Riverside Cycle Hire</p></footer>
  </body>
</html>`,
              hints: [
                'Work down the repair checklist in order.',
                'Check every id is unique and every image has alt text and dimensions.',
                'Tab through the finished page as a final check.',
              ],
              requirements: [
                doctype(),
                { kind: 'attribute_present', selector: 'html', attribute: 'lang', message: 'The page declares its language' },
                unique('title', 'The page has its own title'),
                unique('main', 'There is exactly one main'),
                headingOrder(),
                uniqueIds(),
                legalNesting(),
                noObsolete(),
                goodAlt('img'),
                mediaResolves('img'),
              ],
              difficulty: 4,
              xp: 110,
              skill: 'validation',
            },
          ],
          quiz: [
            {
              slug: 'q-repair-order',
              prompt: 'What should you repair first on a badly broken page?',
              explanation:
                'Document-level and structural problems. They affect everything else, and fixing them often resolves cascading errors.',
              options: [
                { label: 'Document structure — doctype, lang, landmarks, headings', correct: true },
                { label: 'Alt text on images' },
                { label: 'Meta descriptions' },
                { label: 'Whichever error the validator lists last' },
              ],
              skill: 'debugging',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'level-11-milestone',
    kind: 'milestone',
    title: 'Level 11 milestone: Debugging and Validation Master',
    description: 'Seven questions on validation and debugging method. Pass mark 75%.',
    passScore: 0.75,
    xp: 180,
    questions: [
      {
        slug: 'a11-q1',
        prompt: '"End tag main seen, but there were open elements" — where is the mistake?',
        explanation:
          'Above the reported line. An element opened earlier was never closed; the validator noticed at `</main>`.',
        options: [
          { label: 'Above that line — something opened earlier was never closed', correct: true },
          { label: 'On the reported line itself' },
          { label: 'In the head' },
          { label: 'In a linked stylesheet' },
        ],
        skill: 'validation',
      },
      {
        slug: 'a11-q2',
        prompt: 'Which of these will a validator NOT catch?',
        explanation:
          'Link text quality is a judgement about meaning, which no grammar checker can make.',
        options: [
          { label: 'A link whose text is "click here"', correct: true },
          { label: 'A duplicate id' },
          { label: 'An <li> outside a list' },
          { label: 'A missing <title>' },
        ],
        skill: 'validation',
      },
      {
        slug: 'a11-q3',
        prompt: 'Which developer-tools panel shows a 404 for a missing image?',
        explanation: 'Network, with the exact URL that was requested.',
        options: [
          { label: 'Network', correct: true },
          { label: 'Elements' },
          { label: 'Accessibility' },
          { label: 'Performance' },
        ],
        skill: 'debugging',
      },
      {
        slug: 'a11-q4',
        prompt: 'What does the Elements panel show?',
        explanation:
          'The live DOM — what the browser actually built, including any repairs it made to broken markup.',
        options: [
          { label: 'The live DOM, including the browser\'s repairs', correct: true },
          { label: 'Your original source file' },
          { label: 'Validation errors' },
          { label: 'The accessibility tree only' },
        ],
        skill: 'debugging',
      },
      {
        slug: 'a11-q5',
        prompt: 'Which element was removed from HTML?',
        explanation: '`<center>` is obsolete; centring is a styling concern.',
        options: [
          { label: '<center>', correct: true },
          { label: '<section>' },
          { label: '<figure>' },
          { label: '<aside>' },
        ],
        skill: 'validation',
      },
      {
        slug: 'a11-q6',
        prompt: 'Roughly how many accessibility issues do automated tools catch?',
        explanation:
          'About a third. The rest — alt-text quality, heading logic, link clarity — need a person.',
        options: [
          { label: 'About a third', correct: true },
          { label: 'Essentially all of them' },
          { label: 'None — they only check HTML grammar' },
          { label: 'About 90%' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'a11-q7',
        prompt: 'What is the most reliable debugging method?',
        explanation:
          'Change one thing, test, and revert if it did not help — plus narrowing the problem before fixing it.',
        options: [
          { label: 'Change one thing at a time and test after each change', correct: true },
          { label: 'Rewrite the page from scratch' },
          { label: 'Fix every reported error before testing' },
          { label: 'Try a different browser first' },
        ],
        skill: 'debugging',
      },
    ],
  },
};
