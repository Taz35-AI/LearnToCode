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
  legalNesting,
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

export const LEVEL_05: LevelSpec = {
  slug: 'structure-professional',
  title: 'Structure Professional',
  subtitle: 'Markup that describes meaning, not appearance',
  summary:
    'The difference between an amateur page and a professional one is usually not what it looks like — it is what the markup says. This level is about semantic structure and the file organisation that goes with it.',
  outcome:
    'You can take an unstructured page and rebuild it with professional semantic HTML and a maintainable folder structure.',
  accent: 'violet',
  modules: [
    {
      slug: 'semantic-landmarks',
      title: 'Semantic elements and page landmarks',
      summary:
        'header, nav, main, section, article, aside, footer — what each one means and, just as importantly, when not to use it.',
      estimatedMinutes: 50,
      prerequisites: ['video-audio-embeds'],
      skills: [{ slug: 'semantic-html', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'semantic-vs-non-semantic',
          title: 'Semantic versus non-semantic elements',
          subtitle: 'Why `<div>` should be your last choice, not your first',
          summary:
            'A `<div>` says nothing. Every semantic element you use instead gives real information to browsers, screen readers and search engines — for free.',
          objectives: [
            'Explain what makes an element semantic',
            'Name the main landmark elements and their meanings',
            'Recognise "div soup" and know what to do about it',
          ],
          estimatedMinutes: 14,
          skill: 'semantic-html',
          blocks: [
            objectives([
              'Define semantic HTML in your own words',
              'Identify the correct landmark element for a region of a page',
              'Rewrite a div-based layout using semantic elements',
            ]),
            term(
              'Semantic element',
              'An element whose name describes what its content *is*. `<nav>` is semantic; `<div>` is not.',
            ),
            term(
              '<div> and <span>',
              'Generic containers with no meaning at all. `<div>` is a block, `<span>` is inline. They exist for when you genuinely need a box to hang styling on and no semantic element fits.',
            ),
            visual('semantic-landmarks', 'The main landmark elements and the regions they describe.'),
            compare(
              'The same page, twice',
              {
                label: 'Semantic',
                code: `<header>
  <nav aria-label="Main">…</nav>
</header>
<main>
  <article>…</article>
  <aside>…</aside>
</main>
<footer>…</footer>`,
                why: 'A screen reader can list the landmarks and jump straight to "main". Search engines can tell content from navigation. No extra work required.',
              },
              {
                label: 'Div soup',
                code: `<div class="header">
  <div class="nav">…</div>
</div>
<div class="main">
  <div class="article">…</div>
  <div class="aside">…</div>
</div>
<div class="footer">…</div>`,
                why: 'Identical on screen, but the class names mean nothing to software. There are no landmarks to jump to, and the page is one undifferentiated blob.',
              },
            ),
            prose('Here is what each landmark actually means.'),
            code(
              `<header>   Introductory content for the page or a section: logo, site name, main nav.
<nav>      A block of major navigation links. Not every group of links.
<main>     The unique content of this page. Exactly one per page.
<article>  A self-contained item that would still make sense on its own.
<section>  A thematic grouping — normally with a heading.
<aside>    Related but not essential: a sidebar, a pull quote, related links.
<footer>   Closing information for the page or section: copyright, contact.
<address>  Contact details for the nearest article or the whole page.`,
              'The landmark elements at a glance',
              'text',
            ),
            callout(
              'tip',
              'The `<main>` rule',
              'Exactly one `<main>` per page, and it must not sit inside `<article>`, `<aside>`, `<header>`, `<footer>` or `<nav>`. It holds what makes *this* page different from every other page on the site — so the repeated header and footer stay outside it.',
            ),
            demo('What a screen reader announces', 'The same two pages, heard rather than seen.', [
              {
                label: 'With landmarks',
                code: '<header><nav aria-label="Main"><ul><li><a href="#">Home</a></li></ul></nav></header>\n<main><h1>Prices</h1><p>From £6 an hour.</p></main>\n<footer><p>© 2026</p></footer>',
                note: 'Landmarks list: banner, navigation "Main", main, contentinfo. The user jumps straight to main.',
              },
              {
                label: 'Without',
                code: '<div><div><ul><li><a href="#">Home</a></li></ul></div></div>\n<div><h1>Prices</h1><p>From £6 an hour.</p></div>\n<div><p>© 2026</p></div>',
                note: 'Landmarks list: empty. The only way through is to read from the top, every time.',
              },
            ]),
            callout(
              'mistake',
              '`<div>` is not forbidden',
              'It is the right answer when you need a container purely for layout and no semantic element describes the content. The mistake is reaching for it *first*. Ask "what is this?" — and use `<div>` only when the honest answer is "just a box".',
            ),
            detail(
              'Do landmarks replace ARIA roles?',
              'Yes, and that is the point. `<header>` already has the `banner` role, `<nav>` has `navigation`, `<main>` has `main`, `<footer>` has `contentinfo`. Writing `<div role="banner">` achieves the same thing with more code and none of the other behaviour the real element brings. This is the first appearance of a rule that runs through the rest of the course: native HTML first, ARIA only where HTML cannot express what you mean.',
            ),
            recap(
              [
                'Semantic elements name what their content is; `<div>` and `<span>` name nothing.',
                'Landmarks let assistive technology jump straight to a region of the page.',
                'Exactly one `<main>`, holding what is unique to this page.',
                'Use `<div>` when no semantic element fits — but ask the question first.',
              ],
              'Next: sections, articles, and the ones people get wrong.',
            ),
          ],
          exercises: [
            {
              slug: 'landmarks-guided',
              kind: 'guided',
              title: 'Replace the divs with landmarks',
              brief:
                'Rewrite this page using semantic landmark elements instead of divs. The class names tell you which element each one should become.',
              starterCode: `<div class="header">
  <div class="nav">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="prices.html">Prices</a></li>
    </ul>
  </div>
</div>
<div class="main">
  <h1>Prices</h1>
  <p>Hourly hire starts at £6.</p>
</div>
<div class="footer">
  <p>© 2026 Riverside Cycle Hire</p>
</div>`,
              referenceSolution: `<header>
  <nav aria-label="Main">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="prices.html">Prices</a></li>
    </ul>
  </nav>
</header>
<main>
  <h1>Prices</h1>
  <p>Hourly hire starts at £6.</p>
</main>
<footer>
  <p>© 2026 Riverside Cycle Hire</p>
</footer>`,
              hints: [
                'div class="header" becomes <header>, and so on for each one.',
                'The nav should also get an aria-label so it can be told apart from other navs.',
                'Remove the class attributes — the element names now carry the meaning.',
              ],
              requirements: [
                unique('main', 'There is exactly one main element'),
                present('header', 'The page has a header landmark'),
                present('nav', 'The navigation uses a nav element'),
                present('footer', 'The page has a footer landmark'),
                count('div', 0, 0, 'No generic divs remain'),
                inside('h1', 'main', 'The h1 is inside main'),
                attr('nav', 'aria-label', 'The nav is labelled'),
              ],
              difficulty: 2,
              xp: 45,
              skill: 'semantic-html',
            },
          ],
          quiz: [
            {
              slug: 'q-semantic-meaning',
              prompt: 'What makes an element "semantic"?',
              explanation: 'Its name describes what the content is, so software can act on that meaning.',
              options: [
                { label: 'Its name describes what the content is', correct: true },
                { label: 'It has default styling applied' },
                { label: 'It can hold other elements' },
                { label: 'It is newer than HTML 4' },
              ],
              skill: 'semantic-html',
            },
            {
              slug: 'q-main-count',
              prompt: 'How many `<main>` elements should a page have?',
              explanation: 'One. It holds the content unique to that page.',
              options: [
                { label: 'Exactly one', correct: true },
                { label: 'One per section' },
                { label: 'As many as the layout needs' },
                { label: 'None — main is optional and rarely used' },
              ],
              skill: 'semantic-html',
            },
          ],
        },
        {
          slug: 'section-article-aside',
          title: 'Section, article and aside',
          subtitle: 'The three that are most often confused',
          summary:
            'Two simple tests settle almost every case: could it stand alone, and does it have a heading?',
          objectives: [
            'Decide between section, article and div',
            'Use aside for genuinely tangential content',
            'Understand what a document outline is and is not',
          ],
          estimatedMinutes: 14,
          skill: 'semantic-html',
          blocks: [
            objectives([
              'Apply the "would it make sense alone?" test for <article>',
              'Apply the "does it have a heading?" test for <section>',
              'Use <aside> correctly and sparingly',
            ]),
            prose(
              '`<article>` is for something self-contained: a blog post, a news item, a product card, a single review, a comment. The test is whether it would still make sense if you lifted it out and put it somewhere else — in a feed reader, or in a search result.',
            ),
            prose(
              '`<section>` is a thematic grouping within a larger document. The test is whether it has, or could sensibly have, its own heading. If you cannot write a heading for it, it is almost certainly not a section — it is a `<div>`.',
            ),
            code(
              `<main>
  <h1>Route guides</h1>

  <article>
    <h2>The valley route</h2>
    <p>Twenty-four miles, mostly flat.</p>
  </article>

  <article>
    <h2>The harbour loop</h2>
    <p>Six miles, entirely traffic-free.</p>
  </article>
</main>`,
              'Two self-contained articles in a listing page',
            ),
            code(
              `<article>
  <h1>The valley route</h1>

  <section>
    <h2>Getting there</h2>
    <p>The route starts at the workshop on Mill Lane.</p>
  </section>

  <section>
    <h2>What to expect</h2>
    <p>One long climb near the reservoir; the rest is flat.</p>
  </section>

  <aside>
    <h2>Bike hire</h2>
    <p>We hire hybrids suited to this route from £22 a day.</p>
  </aside>
</article>`,
              'One article, divided into sections, with an aside',
            ),
            annotated(
              `<aside aria-label="Related routes">
  <h2>You might also like</h2>
  <ul>
    <li><a href="harbour.html">The harbour loop</a></li>
  </ul>
</aside>`,
              [
                {
                  line: '1',
                  text: '`<aside>` means "related to the content around it, but not part of it". Removing it should not damage the main content.',
                },
                {
                  line: '1',
                  text: 'An `aria-label` names the landmark, so a screen reader announces "complementary, Related routes" rather than just "complementary".',
                },
                {
                  line: '2',
                  text: 'A heading inside an aside is good practice — it tells everyone what the aside is for.',
                },
              ],
            ),
            callout(
              'mistake',
              '`<section>` is not a styling wrapper',
              'Using `<section>` where you mean "a box" adds a meaningless region to the page\'s structure. If it has no heading and no thematic identity, use `<div>`. There is no penalty for a `<div>` in the right place, but there is a real cost to a `<section>` in the wrong one.',
            ),
            demo('section, article or div?', 'Three candidates for the same block of markup.', [
              {
                label: 'article — correct',
                code: '<article>\n  <h2>Slow-roast lamb</h2>\n  <p>Served with charred aubergine.</p>\n</article>',
                note: 'A menu item is self-contained and would make sense on its own. article is right.',
              },
              {
                label: 'section — correct',
                code: '<section>\n  <h2>Main courses</h2>\n  <p>All served with bread.</p>\n</section>',
                note: 'A themed part of the menu page, with its own heading. section is right.',
              },
              {
                label: 'div — correct',
                code: '<div class="price-badge">\n  <span>£18</span>\n</div>',
                note: 'Just a box for styling, with no heading and no theme. div is right.',
              },
            ]),
            detail(
              'The document outline algorithm',
              'Older material said that `<section>` created a new heading level automatically, so you could use `<h1>` everywhere and the nesting would sort it out. That algorithm was never implemented by any browser or screen reader, and it has been removed from the specification. Set heading levels explicitly: an `<h2>` is an `<h2>` no matter how deeply it is nested. If you read otherwise on an older tutorial, it is out of date.',
            ),
            checklist('Choosing a container', [
              'Would it make sense lifted out of the page? → `<article>`',
              'Is it a themed part of a larger whole, with a heading? → `<section>`',
              'Is it related but not essential? → `<aside>`',
              'Is it just a box for layout? → `<div>`',
            ]),
            recap(
              [
                '`<article>` = self-contained; `<section>` = themed group with a heading.',
                '`<aside>` = related but removable without damaging the content.',
                '`<div>` is correct when nothing else fits — that is what it is for.',
                'Heading levels are always explicit; sectioning does not adjust them.',
              ],
              'Next: file organisation and repeated page patterns.',
            ),
          ],
          exercises: [
            {
              slug: 'section-article-guided',
              kind: 'guided',
              title: 'Choose the right containers',
              brief:
                'Rewrite this listing page. The two route entries are self-contained items; the block introducing them is a themed part of the page; the hire offer is related but tangential.',
              starterCode: `<main>
  <h1>Route guides</h1>
  <div>
    <h2>Easy routes</h2>
    <p>Both of these are flat and traffic-free.</p>
  </div>
  <div>
    <h3>The harbour loop</h3>
    <p>Six miles from the workshop door.</p>
  </div>
  <div>
    <h3>The mill and back</h3>
    <p>Eleven miles, one gentle climb.</p>
  </div>
  <div>
    <h2>Bike hire</h2>
    <p>Hybrids from £22 a day.</p>
  </div>
</main>`,
              referenceSolution: `<main>
  <h1>Route guides</h1>
  <section>
    <h2>Easy routes</h2>
    <p>Both of these are flat and traffic-free.</p>

    <article>
      <h3>The harbour loop</h3>
      <p>Six miles from the workshop door.</p>
    </article>

    <article>
      <h3>The mill and back</h3>
      <p>Eleven miles, one gentle climb.</p>
    </article>
  </section>

  <aside aria-label="Bike hire">
    <h2>Bike hire</h2>
    <p>Hybrids from £22 a day.</p>
  </aside>
</main>`,
              hints: [
                'The two routes are self-contained items — each becomes an <article>.',
                'The "Easy routes" block groups them under a heading — that is a <section>.',
                'The hire offer is related but not part of the guides — that is an <aside>.',
              ],
              requirements: [
                count('article', 2, 2, 'The two routes are articles'),
                present('section', 'The themed group uses a section'),
                present('aside', 'The tangential content uses an aside'),
                count('main > div, section > div', 0, 0, 'No meaningless divs remain'),
                headingOrder(),
                legalNesting(),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'semantic-html',
            },
            {
              slug: 'section-debug',
              kind: 'debug',
              title: 'Sections that should not be sections',
              brief:
                'This page uses `<section>` for two things that are not sections: a styling wrapper with no heading, and a self-contained review. Fix both, and give the aside an accessible name.',
              starterCode: `<main>
  <h1>Customer reviews</h1>
  <section class="layout-wrapper">
    <section>
      <h2>"Excellent service"</h2>
      <p>Booked a bike at short notice and it was ready in ten minutes.</p>
    </section>
  </section>
  <aside>
    <h2>Leave a review</h2>
    <p>We read every one.</p>
  </aside>
</main>`,
              referenceSolution: `<main>
  <h1>Customer reviews</h1>
  <div class="layout-wrapper">
    <article>
      <h2>"Excellent service"</h2>
      <p>Booked a bike at short notice and it was ready in ten minutes.</p>
    </article>
  </div>
  <aside aria-label="Leave a review">
    <h2>Leave a review</h2>
    <p>We read every one.</p>
  </aside>
</main>`,
              hints: [
                'The outer wrapper has no heading and exists only for layout — that is a <div>.',
                'A single review is self-contained, so it is an <article>.',
                'Add aria-label to the aside so screen readers can name it.',
              ],
              requirements: [
                present('article', 'The review is an article'),
                count('section', 0, 0, 'No misused section elements remain'),
                attr('aside', 'aria-label', 'The aside has an accessible name'),
                present('div', 'The layout wrapper is a div'),
              ],
              difficulty: 3,
              xp: 45,
              skill: 'semantic-html',
            },
          ],
          quiz: [
            {
              slug: 'q-article-test',
              prompt: 'What is the test for using `<article>`?',
              explanation:
                'Whether the content would still make sense on its own, lifted out of the page.',
              options: [
                { label: 'Would it make sense on its own, outside this page?', correct: true },
                { label: 'Is it more than three paragraphs long?' },
                { label: 'Does it contain an image?' },
                { label: 'Is it written by a named author?' },
              ],
              skill: 'semantic-html',
            },
            {
              slug: 'q-section-heading',
              prompt: 'You have a container with no heading and no theme, used only for layout. What should it be?',
              explanation:
                '`<div>`. Using `<section>` would add a meaningless region to the page structure.',
              options: [
                { label: '<div>', correct: true },
                { label: '<section>' },
                { label: '<article>' },
                { label: '<aside>' },
              ],
              skill: 'semantic-html',
            },
            {
              slug: 'q-outline-algorithm',
              prompt: 'Does nesting a heading inside a `<section>` change its level?',
              explanation:
                'No. The outline algorithm that would have done this was never implemented and has been removed from the specification. Always set levels explicitly.',
              options: [
                { label: 'No — always set heading levels explicitly', correct: true },
                { label: 'Yes, each section demotes headings by one level' },
                { label: 'Only in browsers that support HTML5 outlines' },
                { label: 'Only for h1 elements' },
              ],
              skill: 'semantic-html',
            },
          ],
        },
      ],
    },
    {
      slug: 'organising-a-project',
      title: 'Organising a real project',
      summary:
        'Folder structure, naming conventions, repeated page patterns, and the Level 5 milestone rebuild.',
      estimatedMinutes: 45,
      prerequisites: ['semantic-landmarks'],
      isMilestone: true,
      skills: [
        { slug: 'semantic-html', masteryRequired: 0.7 },
        { slug: 'maintainability', masteryRequired: 0 },
        { slug: 'multi-page', masteryRequired: 0.6 },
      ],
      lessons: [
        {
          slug: 'file-organisation-and-patterns',
          title: 'File organisation and reusable patterns',
          subtitle: 'Structure that still makes sense at page forty',
          summary:
            'Every professional site has conventions. Adopting them now costs nothing and saves a great deal later.',
          objectives: [
            'Lay out a project folder that scales',
            'Apply consistent naming conventions',
            'Recognise repeated patterns and keep them identical',
          ],
          estimatedMinutes: 13,
          skill: 'maintainability',
          blocks: [
            objectives([
              'Design a folder structure for a multi-page site',
              'Apply naming conventions that avoid server-specific bugs',
              'Keep repeated page furniture consistent across a site',
            ]),
            visual('file-paths', 'A project laid out so that paths stay predictable.'),
            code(
              `my-site/
├── index.html
├── about.html
├── contact.html
├── 404.html                custom "page not found"
├── favicon.svg
├── assets/
│   ├── css/
│   │   └── site.css
│   ├── images/
│   │   ├── hero-workshop.jpg
│   │   └── logo.svg
│   ├── media/
│   │   ├── tour.mp4
│   │   └── tour.en.vtt
│   └── files/
│       └── price-list-2026.pdf
└── routes/
    ├── index.html
    ├── valley.html
    └── harbour.html`,
              'A structure that still works at forty pages',
              'text',
            ),
            checklist('Conventions worth adopting permanently', [
              'Lowercase filenames — some servers are case-sensitive, some are not; assume the strict one',
              'Hyphens, never spaces or underscores, in filenames',
              'One `index.html` per folder, so `/routes/` works as a URL',
              'All assets under `assets/`, grouped by type',
              'Descriptive names: `hero-workshop.jpg`, not `IMG_4821.jpg`',
              'A `404.html` so a mistyped URL is still helpful',
            ]),
            callout(
              'warning',
              'The case-sensitivity trap',
              'Most Windows and macOS setups treat `About.html` and `about.html` as the same file. Most Linux servers do not. A site that works perfectly on your laptop can 404 the moment it is deployed. Lowercase everything and the problem disappears permanently.',
            ),
            prose(
              'The other half of maintainability is repetition. Your header, navigation and footer appear on every page. Keeping them byte-for-byte identical is what makes a site feel coherent — and it is the thing hand-written sites get wrong first.',
            ),
            compare(
              'Two ways of writing the same page furniture',
              {
                label: 'Consistent',
                code: `<!-- Site header — identical on every page -->
<header>
  <a href="/" class="logo">Riverside</a>
  <nav aria-label="Main">…</nav>
</header>`,
                why: 'A comment marks the block as shared, so the next person knows to change it everywhere.',
              },
              {
                label: 'Drifted',
                code: `<!-- page 1 -->
<header><nav aria-label="Main">…</nav></header>

<!-- page 2 -->
<div class="top"><nav>…</nav></div>`,
                why: 'The same region, written two different ways. Screen-reader users lose the landmark on page two, and every future change has to be made twice.',
              },
            ),
            term(
              'Progressive disclosure of complexity',
              'Hand-copying shared markup is fine for a handful of pages. Beyond that, professionals use a template system or a static site generator that writes the repetition for them. Knowing *why* the repetition exists is what lets you pick the right tool later.',
            ),
            callout(
              'tip',
              'Comment the boundaries, not the obvious',
              'A comment saying `<!-- Site header — keep identical across pages -->` earns its place. A comment saying `<!-- paragraph -->` above a `<p>` does not. Write comments for decisions and boundaries, never for restating what the code already says.',
            ),
            detail(
              'Avoiding unnecessary containers',
              'Every extra wrapper is a line someone has to read, and a level of nesting that makes a missing closing tag harder to find. Before adding a `<div>`, check whether the element you already have could carry the styling instead. A page that is five levels deep where three would do is not "more structured" — it is just harder to change.',
            ),
            recap(
              [
                'Lowercase, hyphenated filenames avoid an entire class of deployment bug.',
                'Group assets by type under one folder.',
                'Keep shared page furniture byte-for-byte identical.',
                'Add a container only when it earns its place.',
              ],
              'Next: the Level 5 milestone rebuild.',
            ),
          ],
          exercises: [
            {
              slug: 'patterns-guided',
              kind: 'guided',
              title: 'Make two pages consistent',
              brief:
                'This is the header from page two of a site. Page one uses `<header>`, a labelled `<nav>` and a `<ul>` of links. Rewrite this one to match exactly.',
              starterCode: `<div class="top">
  <nav>
    <a href="index.html">Home</a>
    <a href="about.html">About</a>
    <a href="contact.html">Contact</a>
  </nav>
</div>`,
              referenceSolution: `<header>
  <nav aria-label="Main">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="about.html">About</a></li>
      <li><a href="contact.html">Contact</a></li>
    </ul>
  </nav>
</header>`,
              hints: [
                'The wrapper should be a <header>, not a div.',
                'The nav needs aria-label="Main" to match page one.',
                'Wrap the links in a <ul> with one <li> each.',
              ],
              requirements: [
                present('header', 'The wrapper is a header landmark'),
                attrValue('nav', 'aria-label', 'Main', 'The nav is labelled "Main"'),
                count('nav li a', 3, 3, 'Three links, each in a list item'),
                count('div', 0, 0, 'The generic div has been replaced'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'maintainability',
            },
          ],
          quiz: [
            {
              slug: 'q-case-sensitivity',
              prompt: 'Why use lowercase filenames?',
              explanation:
                'Linux servers are case-sensitive while many development machines are not, so mixed case works locally and 404s in production.',
              options: [
                { label: 'Many servers are case-sensitive even when your computer is not', correct: true },
                { label: 'Uppercase letters are invalid in URLs' },
                { label: 'Lowercase files load faster' },
                { label: 'HTML requires it' },
              ],
              skill: 'multi-page',
            },
            {
              slug: 'q-comments-value',
              prompt: 'Which comment is worth writing?',
              explanation:
                'Comments should record decisions and mark boundaries, not restate what the markup already says.',
              options: [
                { label: '<!-- Site header — keep identical across all pages -->', correct: true },
                { label: '<!-- paragraph -->' },
                { label: '<!-- div -->' },
                { label: '<!-- closing tag below -->' },
              ],
              skill: 'maintainability',
            },
          ],
        },
        {
          slug: 'semantic-rebuild-milestone',
          title: 'Milestone: rebuild an unstructured page',
          subtitle: 'Take div soup and turn it into professional markup',
          summary:
            'A real page, written badly. Your job is to rebuild it properly without changing a word of the content.',
          objectives: [
            'Convert a non-semantic page into a landmark-based structure',
            'Fix the heading hierarchy at the same time',
            'Justify every element choice you make',
          ],
          estimatedMinutes: 30,
          skill: 'semantic-html',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Rebuild a div-based page using correct landmarks',
              'Repair the heading hierarchy',
              'Produce markup you would be happy to hand to a colleague',
            ]),
            prose(
              'The page in the exercise below is the kind you meet constantly in real work: it looks acceptable, and the markup underneath says nothing at all. Rebuilding it is the single most useful exercise in this level.',
            ),
            checklist('Your rebuild must have', [
              'A `<header>` containing the site name and the main `<nav>`',
              'Exactly one `<main>`, with an `id` a skip link can target',
              'The self-contained items as `<article>` elements',
              'The tangential block as an `<aside>` with an accessible name',
              'A `<footer>` outside `<main>`',
              'A correct heading hierarchy: one `<h1>`, no skipped levels',
              'No `<div>` where a semantic element fits',
            ]),
            callout(
              'tip',
              'Work outside in',
              'Identify the landmarks first — header, main, footer. Then work down through what is inside each one. Trying to fix the innermost elements before the outer structure is settled means doing the work twice.',
            ),
            compare(
              'The same region, before and after a rebuild',
              {
                label: 'After — semantic',
                code: `<article>
  <h2>The valley route</h2>
  <p>Twenty-four miles, mostly flat.</p>
</article>`,
                why: 'A screen reader announces an article with a heading. Search engines can identify the item. The class names are gone because the elements now carry the meaning.',
              },
              {
                label: 'Before — div soup',
                code: `<div class="card">
  <div class="card-title">The valley route</div>
  <p>Twenty-four miles, mostly flat.</p>
</div>`,
                why: 'Identical on screen. No heading in the outline, no landmark to jump to, and the "card-title" class means nothing to any software.',
              },
            ),
            visual('semantic-landmarks', 'The structure you are rebuilding towards.'),
            recap(
              [
                'You can now read an unstructured page and see the structure it should have had.',
                'Landmarks first, then content elements, then headings.',
                'This is the skill that most visibly separates professional markup from amateur markup.',
              ],
              'Level 6 next: tables and forms.',
            ),
          ],
          exercises: [
            {
              slug: 'semantic-rebuild',
              kind: 'challenge',
              title: 'Milestone: rebuild the page',
              brief:
                'Rebuild this page with correct semantic structure and a valid heading hierarchy. Keep every word of the content exactly as it is — only the markup changes.',
              starterCode: `<div id="top">
  <span class="brand">Riverside Cycle Hire</span>
  <div class="menu">
    <a href="index.html">Home</a>
    <a href="routes.html">Routes</a>
    <a href="contact.html">Contact</a>
  </div>
</div>

<div id="content">
  <div class="title">Route guides</div>

  <div class="card">
    <div class="card-title">The valley route</div>
    <p>Twenty-four miles, mostly flat, one long climb near the reservoir.</p>
  </div>

  <div class="card">
    <div class="card-title">The harbour loop</div>
    <p>Six miles, entirely traffic-free, suitable for children.</p>
  </div>

  <div class="side">
    <div class="side-title">Bike hire</div>
    <p>Hybrids suited to both routes, from £22 a day.</p>
  </div>
</div>

<div id="bottom">
  <p>© 2026 Riverside Cycle Hire</p>
</div>`,
              referenceSolution: `<header>
  <a href="index.html" class="brand">Riverside Cycle Hire</a>
  <nav aria-label="Main">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="routes.html">Routes</a></li>
      <li><a href="contact.html">Contact</a></li>
    </ul>
  </nav>
</header>

<main id="main">
  <h1>Route guides</h1>

  <article>
    <h2>The valley route</h2>
    <p>Twenty-four miles, mostly flat, one long climb near the reservoir.</p>
  </article>

  <article>
    <h2>The harbour loop</h2>
    <p>Six miles, entirely traffic-free, suitable for children.</p>
  </article>

  <aside aria-label="Bike hire">
    <h2>Bike hire</h2>
    <p>Hybrids suited to both routes, from £22 a day.</p>
  </aside>
</main>

<footer>
  <p>© 2026 Riverside Cycle Hire</p>
</footer>`,
              hints: [
                'Start with the three landmarks: #top becomes <header>, #content becomes <main>, #bottom becomes <footer>.',
                'The .menu is navigation — a <nav aria-label="Main"> containing a <ul> of links.',
                'Each .card is a self-contained item, so it becomes an <article> with an <h2>.',
                '.title is the page heading — that is your single <h1>. The .side block becomes an <aside>.',
              ],
              requirements: [
                present('header', 'There is a header landmark'),
                unique('main', 'There is exactly one main element'),
                present('footer', 'There is a footer landmark'),
                present('nav', 'The menu uses a nav element'),
                attr('nav', 'aria-label', 'The nav is labelled'),
                count('nav li a', 3, 3, 'The three links are list items in the nav'),
                unique('h1', 'There is exactly one h1'),
                count('article', 2, 2, 'The two route cards are articles'),
                count('article h2', 2, 2, 'Each article has an h2 heading'),
                present('aside', 'The tangential block is an aside'),
                attr('aside', 'aria-label', 'The aside has an accessible name'),
                inside('h1', 'main', 'The h1 is inside main'),
                { kind: 'element_count', selector: 'footer main, main footer', minCount: 0, maxCount: 0, message: 'The footer is outside main' },
                headingOrder(),
                uniqueIds(),
                legalNesting(),
                notEmpty('p', 'All the original content survives'),
              ],
              difficulty: 4,
              xp: 140,
              skill: 'semantic-html',
            },
            {
              slug: 'semantic-mission',
              kind: 'project_mission',
              title: 'Capstone mission: give every page landmarks',
              brief:
                'Rework your capstone pages so each one has `<header>`, `<nav>`, `<main id="main">` and `<footer>`, with the skip link still pointing at `#main`. This is the structure every remaining module builds on.',
              starterCode: `<body>
  <a class="skip-link" href="#main">Skip to main content</a>

  <!-- Wrap the nav in a header -->
  <nav aria-label="Main">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="about.html">About</a></li>
      <li><a href="contact.html">Contact</a></li>
    </ul>
  </nav>

  <!-- Wrap your page content in main -->
  <h1>Your page heading</h1>
  <p>Your content.</p>

  <!-- Add a footer -->
</body>`,
              referenceSolution: `<body>
  <a class="skip-link" href="#main">Skip to main content</a>

  <header>
    <a href="index.html">Riverside Cycle Hire</a>
    <nav aria-label="Main">
      <ul>
        <li><a href="index.html" aria-current="page">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>
  </header>

  <main id="main">
    <h1>Riverside Cycle Hire</h1>
    <p>We rent well-maintained bikes by the hour, the day or the week.</p>
  </main>

  <footer>
    <p>© 2026 Riverside Cycle Hire</p>
  </footer>
</body>`,
              hints: [
                'The header wraps the site name and the nav together.',
                'main needs id="main" so the skip link reaches it.',
                'The footer goes after main, not inside it.',
              ],
              requirements: [
                present('header', 'The page has a header'),
                inside('nav', 'header', 'The navigation is inside the header'),
                unique('main', 'There is exactly one main'),
                attrValue('main', 'id', 'main', 'main has the id the skip link targets'),
                present('footer', 'The page has a footer'),
                { kind: 'element_count', selector: 'main footer', minCount: 0, maxCount: 0, message: 'The footer is outside main' },
                inside('h1', 'main', 'The h1 is inside main'),
                attrValue('a', 'href', '#main', 'The skip link still targets #main'),
              ],
              difficulty: 3,
              xp: 90,
              skill: 'multi-page',
            },
          ],
          quiz: [
            {
              slug: 'q-footer-placement',
              prompt: 'Should the site footer be inside `<main>`?',
              explanation:
                'No. `<main>` holds content unique to this page; the site footer is repeated on every page, so it sits outside.',
              options: [
                { label: 'No — it is repeated on every page, so it goes outside main', correct: true },
                { label: 'Yes, main should contain the whole page' },
                { label: 'Only if the page has no header' },
                { label: 'It makes no difference' },
              ],
              skill: 'semantic-html',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'level-5-milestone',
    kind: 'milestone',
    title: 'Level 5 milestone: Structure Professional',
    description: 'Eight questions on semantic structure and project organisation. Pass mark 75%.',
    passScore: 0.75,
    xp: 170,
    questions: [
      {
        slug: 'a5-q1',
        prompt: 'Which element wraps the content unique to a page?',
        explanation: '`<main>`, and there should be exactly one per page.',
        options: [
          { label: '<main>', correct: true },
          { label: '<section>' },
          { label: '<article>' },
          { label: '<div id="content">' },
        ],
        skill: 'semantic-html',
      },
      {
        slug: 'a5-q2',
        prompt: 'A blog post in a list of posts should be marked up as what?',
        explanation: 'It is self-contained and would make sense on its own, so `<article>`.',
        options: [
          { label: '<article>', correct: true },
          { label: '<section>' },
          { label: '<aside>' },
          { label: '<div>' },
        ],
        skill: 'semantic-html',
      },
      {
        slug: 'a5-q3',
        prompt: 'What role does `<header>` already have, without any ARIA?',
        explanation: 'When it is not inside an article or section, `<header>` has the `banner` role.',
        options: [
          { label: 'banner', correct: true },
          { label: 'navigation' },
          { label: 'main' },
          { label: 'complementary' },
        ],
        skill: 'aria',
      },
      {
        slug: 'a5-q4',
        prompt: 'When is `<div>` the right choice?',
        explanation:
          'When you genuinely need a container for layout and no semantic element describes the content.',
        options: [
          { label: 'When no semantic element fits and you need a container', correct: true },
          { label: 'Never — divs are obsolete' },
          { label: 'Whenever you need to apply a class' },
          { label: 'Only inside <main>' },
        ],
        skill: 'semantic-html',
      },
      {
        slug: 'a5-q5',
        prompt: 'Does nesting an `<h2>` inside a `<section>` make it behave like an `<h3>`?',
        explanation:
          'No. The outline algorithm was never implemented and has been removed. Heading levels are always explicit.',
        options: [
          { label: 'No — heading levels are always explicit', correct: true },
          { label: 'Yes, sections demote headings automatically' },
          { label: 'Only in screen readers' },
          { label: 'Only when the section has an aria-label' },
        ],
        skill: 'semantic-html',
      },
      {
        slug: 'a5-q6',
        prompt: 'Why does a page with two `<nav>` elements need `aria-label` on each?',
        explanation:
          'Otherwise a screen reader lists two identical "navigation" landmarks with no way to tell them apart.',
        options: [
          { label: 'So they can be told apart in the landmarks list', correct: true },
          { label: 'Because two navs are otherwise invalid' },
          { label: 'To give them different styling' },
          { label: 'To stop search engines indexing the second one' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'a5-q7',
        prompt: 'Which filename follows professional convention?',
        explanation: 'Lowercase, hyphenated, descriptive.',
        options: [
          { label: 'price-list-2026.pdf', correct: true },
          { label: 'Price List 2026.pdf' },
          { label: 'PriceList2026.PDF' },
          { label: 'doc1.pdf' },
        ],
        skill: 'multi-page',
      },
      {
        slug: 'a5-q8',
        prompt: 'What does `<aside>` mean?',
        explanation:
          'Content related to what surrounds it but not essential — removing it should not damage the main content.',
        options: [
          { label: 'Related but non-essential content', correct: true },
          { label: 'A sidebar, defined by its position on screen' },
          { label: 'A footnote' },
          { label: 'Any content that is visually to one side' },
        ],
        skill: 'semantic-html',
      },
    ],
  },
};
