import {
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
  doctype,
  headingOrder,
  inside,
  legalNesting,
  named,
  notEmpty,
  objectives,
  present,
  prose,
  recap,
  term,
  unique,
  visual,
  type LevelSpec,
} from '../types';

export const LEVEL_03: LevelSpec = {
  slug: 'navigation-architect',
  title: 'Navigation Architect',
  subtitle: 'Connect pages into a website people can actually move around',
  summary:
    'Links are what make the web a web. This level covers every kind of link, how file paths really work, and how to build navigation that works with a mouse, a keyboard and a screen reader.',
  outcome: 'You can build and connect a multi-page website with consistent, accessible navigation.',
  accent: 'indigo',
  modules: [
    {
      slug: 'links-and-paths',
      title: 'Links and file paths',
      summary:
        'The anchor element in depth, and the single topic that trips up more beginners than any other: relative paths.',
      estimatedMinutes: 50,
      prerequisites: ['text-level-semantics'],
      skills: [{ slug: 'links', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'anchors-and-link-text',
          title: 'The anchor element and link text that works',
          subtitle: 'href, targets, and why "click here" fails real users',
          summary:
            'One element, one essential attribute — and one writing habit that makes a measurable accessibility difference.',
          objectives: [
            'Link to another page with the anchor element',
            'Write link text that makes sense out of context',
            'Open external links safely',
          ],
          estimatedMinutes: 14,
          skill: 'links',
          blocks: [
            objectives([
              'Create links using the anchor element and its href attribute',
              'Write descriptive link text and explain why it matters',
              'Use rel="noopener noreferrer" when opening a link in a new tab',
            ]),
            prose(
              'A link is an `<a>` element with an `href` attribute. The `href` says where the link goes; the content between the tags is what the visitor sees and clicks.',
            ),
            visual('anatomy-of-an-element', 'A link, with each part labelled.'),
            code(
              `<a href="about.html">About our workshop</a>
<a href="https://www.example.org/">The example organisation</a>`,
              'A link to another page in your site, and a link to another site',
            ),
            callout(
              'accessibility',
              'Why "click here" is a genuine problem',
              'Screen-reader users can pull up a list of every link on a page and jump between them — exactly as sighted users scan for the blue text. In that list the link text appears with no surrounding sentence. A page of "click here", "read more", "click here" gives a list that is completely useless. Link text must make sense entirely on its own.',
            ),
            compare(
              'Link text out of context',
              {
                label: 'Works alone',
                code: '<p>Rates start at £6 an hour. <a href="prices.html">See our full price list</a>.</p>',
                why: 'In a list of links this reads "See our full price list" — instantly clear.',
              },
              {
                label: 'Meaningless alone',
                code: '<p>Rates start at £6 an hour. <a href="prices.html">Click here</a>.</p>',
                why: 'In a list of links this reads "Click here". Here where? For what?',
              },
            ),
            prose(
              'Adding `target="_blank"` opens a link in a new tab. It is worth using sparingly, and when you do, you must add `rel="noopener noreferrer"`.',
            ),
            annotated(
              `<a href="https://www.example.org/report"
   target="_blank"
   rel="noopener noreferrer">
  The 2026 cycling report (opens in a new tab)
</a>`,
              [
                { line: '1', text: 'A normal link to an external site.' },
                { line: '2', text: '`target="_blank"` opens it in a new browser tab.' },
                {
                  line: '3',
                  text: '`noopener` stops the new page from getting a reference back to your page, which older browsers allowed it to use to redirect your tab somewhere malicious. `noreferrer` additionally stops your page\'s address being sent to the destination.',
                },
                {
                  line: '4',
                  text: 'Saying "opens in a new tab" in the visible text is not a technicality — an unexpected new tab is disorienting, and the Back button no longer works as expected.',
                },
              ],
            ),
            callout(
              'note',
              'Modern browsers already imply noopener',
              'Every current browser treats `target="_blank"` as if `noopener` were set. Writing it explicitly costs nothing, documents the intent, and protects users on older browsers — so it remains the professional default.',
            ),
            detail(
              'When should a link open in a new tab at all?',
              'The honest answer is: rarely. Taking control of the user\'s window away from them is a decision they did not make, and it breaks the Back button, which is the most-used control in any browser. The defensible cases are narrow — a reference the user needs while completing a form, or a link that would lose unsaved work. When in doubt, let the link open normally; anyone who wants a new tab can middle-click or use their browser\'s menu.',
            ),
            recap(
              [
                '`<a href="…">` creates a link; the content between the tags is what people see.',
                'Link text must make sense read on its own, out of context.',
                '`target="_blank"` needs `rel="noopener noreferrer"` and a visible warning.',
                'Opening in a new tab takes control away from the user — do it rarely.',
              ],
              'Next: relative paths, the thing everyone gets wrong once.',
            ),
          ],
          exercises: [
            {
              slug: 'links-guided',
              kind: 'guided',
              title: 'Rewrite three bad links',
              brief:
                'All three links below use meaningless text. Rewrite the visible text so each makes sense on its own, keeping the destinations exactly as they are.',
              starterCode: `<p>Our prices changed in April. <a href="prices.html">Click here</a>.</p>
<p>We publish a monthly newsletter. <a href="newsletter.html">Read more</a>.</p>
<p>Find us on Mill Lane. <a href="contact.html">Here</a>.</p>`,
              referenceSolution: `<p>Our prices changed in April. <a href="prices.html">See the new price list</a>.</p>
<p>We publish a monthly newsletter. <a href="newsletter.html">Read this month's newsletter</a>.</p>
<p>Find us on Mill Lane. <a href="contact.html">Get directions and opening hours</a>.</p>`,
              hints: [
                'Ask yourself: if I read only the link text, would I know where it goes?',
                'Describe the destination, not the action — "See the price list" rather than "Click here".',
                'Keep each href exactly as it was; only the visible text changes.',
              ],
              requirements: [
                count('a', 3, 3, 'All three links remain'),
                attrValue('a[href="prices.html"]', 'href', 'prices.html', 'The prices link still points at prices.html'),
                named('a', 'Every link has an accessible name'),
                { kind: 'text_content', selector: 'a', expectedValue: 'price', message: 'The prices link describes its destination', hint: 'Mention prices in the link text.' },
                { kind: 'element_absent', selector: 'a[href="contact.html"]:not([href])', message: 'Links keep their destinations' },
              ],
              difficulty: 2,
              xp: 35,
              skill: 'links',
            },
            {
              slug: 'links-debug',
              kind: 'debug',
              title: 'An unsafe external link',
              brief:
                'This external link opens in a new tab but is missing its `rel` attribute, and it does not warn the reader. Add `rel="noopener noreferrer"` and mention the new tab in the visible text.',
              starterCode: `<p>
  Read <a href="https://www.example.org/report" target="_blank">the 2026 report</a>
  for the full figures.
</p>`,
              referenceSolution: `<p>
  Read
  <a href="https://www.example.org/report" target="_blank" rel="noopener noreferrer">
    the 2026 report (opens in a new tab)
  </a>
  for the full figures.
</p>`,
              hints: [
                'Add a rel attribute alongside target on the same opening tag.',
                'Its value is the two keywords separated by a space: "noopener noreferrer".',
                'Add "(opens in a new tab)" to the words inside the link.',
              ],
              requirements: [
                attr('a[target="_blank"]', 'rel', 'The external link has a rel attribute'),
                attrMatches('a[target="_blank"]', 'rel', 'noopener', 'The rel value includes noopener'),
                { kind: 'text_content', selector: 'a', expectedValue: 'new tab', message: 'The link text warns that it opens in a new tab' },
              ],
              difficulty: 2,
              xp: 35,
              skill: 'links',
            },
          ],
          quiz: [
            {
              slug: 'q-link-text',
              prompt: 'Why must link text make sense out of context?',
              explanation:
                'Screen-reader users can list every link on a page and jump between them. In that list the link text appears with nothing around it.',
              options: [
                { label: 'Screen-reader users navigate by a list of links with no surrounding text', correct: true },
                { label: 'Search engines refuse to index short link text' },
                { label: 'Browsers truncate long link text' },
                { label: 'CSS cannot style links whose text is too short' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-noopener',
              prompt: 'What does `rel="noopener"` prevent?',
              explanation:
                'It stops the newly opened page from holding a reference back to yours — a reference it could otherwise use to redirect your tab.',
              options: [
                { label: 'The new page getting a reference back to yours', correct: true },
                { label: 'The link being followed by search engines' },
                { label: 'The page being cached' },
                { label: 'Cookies being sent with the request' },
              ],
              skill: 'security',
            },
          ],
        },
        {
          slug: 'relative-and-absolute-paths',
          title: 'Relative paths, absolute URLs and fragments',
          subtitle: 'The one topic worth slowing down for',
          summary:
            'Almost every "my image is broken" and "my link 404s" comes from a path. Half an hour here saves hours later.',
          objectives: [
            'Write a relative path from one file to another',
            'Use `../` to move up a folder',
            'Link to a section within a page using a fragment',
          ],
          estimatedMinutes: 16,
          skill: 'links',
          blocks: [
            objectives([
              'Write correct relative paths between files in a project',
              'Explain the difference between a relative path and an absolute URL',
              'Link to a specific section of a page with a fragment identifier',
            ]),
            visual('file-paths', 'A project folder, and the paths between the files in it.'),
            term(
              'Relative path',
              'A path starting from the file you are currently in. `about.html` means "a file called about.html, in the same folder as me".',
            ),
            term(
              'Absolute URL',
              'A complete web address including the protocol: `https://www.example.org/about`. It works from anywhere, but only points at a live site.',
            ),
            prose(
              'Given the folder shown above, here is every path you need. Read each one as an instruction starting from where you are now.',
            ),
            code(
              `From index.html (at the top level):
  about.html               → the file next to me
  images/logo.svg          → go into images, then take logo.svg
  projects/first.html      → go into projects, then take first.html

From projects/first.html (one folder deep):
  ../index.html            → go up one folder, then take index.html
  ../images/logo.svg       → go up one folder, into images, then logo.svg
  second.html              → the file next to me, inside projects/`,
              'Reading paths as instructions',
              'text',
            ),
            callout(
              'tip',
              'Two dots means "up one folder"',
              'A single dot means "here" and is almost always optional — `./about.html` and `about.html` are the same thing. Two dots means "go up one level". You can chain them: `../../images/logo.svg` goes up twice.',
            ),
            callout(
              'mistake',
              'The leading slash trap',
              'Writing `/images/logo.svg` with a leading slash means "start from the very top of the website", not "start from my folder". On a live server that is often what you want; but when you open a file directly from your computer it means the root of your hard drive, and the image will not load. While you are learning, prefer relative paths with no leading slash.',
            ),
            demo('Same link, three ways', 'Each of these can be correct — it depends where you are.', [
              {
                label: 'Relative',
                code: '<a href="about.html">About</a>',
                note: 'Looks for about.html beside the current file. Works locally and on a server.',
              },
              {
                label: 'Root-relative',
                code: '<a href="/about.html">About</a>',
                note: 'Always starts at the site root. Great on a server; usually broken when opening files directly.',
              },
              {
                label: 'Absolute',
                code: '<a href="https://example.org/about.html">About</a>',
                note: 'Points at one specific live site. Use it for links to *other* sites, not your own pages.',
              },
            ]),
            prose(
              'A fragment link points at a specific place *within* a page. You give an element an `id`, then link to `#that-id`. Clicking it scrolls straight there.',
            ),
            annotated(
              `<nav aria-label="On this page">
  <ul>
    <li><a href="#rates">Rates</a></li>
    <li><a href="#routes">Routes</a></li>
  </ul>
</nav>

<h2 id="rates">Rates</h2>
<p>From £6 an hour.</p>

<h2 id="routes">Routes</h2>
<p>Three waymarked loops from the door.</p>`,
              [
                { line: '3', text: '`href="#rates"` means "the element on this page whose id is rates".' },
                {
                  line: '8',
                  text: 'The matching `id="rates"`. Ids must be unique on a page — two elements can never share one.',
                },
                {
                  line: '1',
                  text: 'Giving the `<nav>` an `aria-label` distinguishes it from the site\'s main navigation for screen-reader users. Level 8 covers this properly.',
                },
              ],
            ),
            detail(
              'Linking to a section on another page',
              'Combine a path with a fragment: `<a href="prices.html#day-rates">Day rates</a>` loads prices.html and jumps to the element with `id="day-rates"`. This works with relative paths and absolute URLs alike. The `#top` fragment, and an empty `href="#"`, both scroll to the top of the current page — though `href="#"` on a real link is usually a sign that something is missing.',
            ),
            checklist('Path rules to remember', [
              'No slash at the start = start from where I am',
              '`../` = go up one folder',
              'Leading `/` = start from the site root',
              '`#name` = an element with `id="name"` on this page',
              'Folder and file names: lowercase, hyphens, no spaces',
            ]),
            recap(
              [
                'Relative paths start from the current file; `../` moves up a folder.',
                'A leading slash starts at the site root and usually breaks local file browsing.',
                'Absolute URLs are for other people\'s sites, not your own pages.',
                'Fragment links (`#id`) jump to a specific element, whose id must be unique.',
              ],
              'Next: email, telephone and download links.',
            ),
          ],
          exercises: [
            {
              slug: 'paths-guided',
              kind: 'guided',
              title: 'Write paths from a nested page',
              brief:
                'You are editing `routes/valley.html`, one folder deep. Add three links: back to `index.html` at the top level, across to `routes/harbour.html` beside you, and to `prices.html` at the top level.',
              starterCode: `<nav>
  <ul>
    <li><a href="">Home</a></li>
    <li><a href="">Harbour route</a></li>
    <li><a href="">Prices</a></li>
  </ul>
</nav>`,
              referenceSolution: `<nav>
  <ul>
    <li><a href="../index.html">Home</a></li>
    <li><a href="harbour.html">Harbour route</a></li>
    <li><a href="../prices.html">Prices</a></li>
  </ul>
</nav>`,
              hints: [
                'You are inside the routes folder, so anything at the top level needs ../ first.',
                'harbour.html is in the same folder as you, so it needs no prefix at all.',
                'Home becomes ../index.html and Prices becomes ../prices.html.',
              ],
              requirements: [
                attrValue('a', 'href', '../index.html', 'The Home link goes up one folder to index.html'),
                attrValue('a', 'href', 'harbour.html', 'The Harbour link points at the sibling file'),
                attrValue('a', 'href', '../prices.html', 'The Prices link goes up one folder'),
                count('nav a', 3, 3, 'All three links are present'),
              ],
              difficulty: 3,
              xp: 45,
              skill: 'links',
            },
            {
              slug: 'fragments-challenge',
              kind: 'challenge',
              title: 'Build an on-page contents list',
              brief:
                'Write a page with three `<h2>` sections, each with its own `id`, and a `<nav>` at the top containing a list of three fragment links that jump to them.',
              starterCode: '',
              referenceSolution: `<nav aria-label="On this page">
  <ul>
    <li><a href="#rates">Rates</a></li>
    <li><a href="#routes">Routes</a></li>
    <li><a href="#opening-hours">Opening hours</a></li>
  </ul>
</nav>

<h2 id="rates">Rates</h2>
<p>From £6 an hour, minimum two hours.</p>

<h2 id="routes">Routes</h2>
<p>Three waymarked loops start at our door.</p>

<h2 id="opening-hours">Opening hours</h2>
<p>Open 8am to 6pm, Tuesday to Sunday.</p>`,
              hints: [
                'Give each <h2> an id, using lowercase words joined by hyphens.',
                'Each link in the nav is href="#that-id".',
                'The ids must all be different from each other.',
              ],
              requirements: [
                count('h2[id]', 3, 3, 'Three sections, each with an id'),
                count('nav a[href^="#"]', 3, 3, 'Three fragment links in the nav'),
                { kind: 'no_duplicate_ids', message: 'Every id is unique' },
                inside('a', 'nav', 'The links are inside the nav'),
                notEmpty('h2', 'Every section heading has text'),
              ],
              difficulty: 3,
              xp: 45,
              skill: 'links',
            },
            {
              slug: 'paths-debug',
              kind: 'debug',
              title: 'Four broken paths',
              brief:
                'You are editing `index.html` at the top level of a site whose images live in an `images/` folder and whose route pages live in `routes/`. Every path below is wrong. Fix all four.',
              starterCode: `<a href="../about.html">About</a>
<a href="/routes/valley.html">The valley route</a>
<img src="logo.svg" alt="Riverside Cycle Hire">
<a href="#Prices">Prices</a>
<h2 id="prices">Prices</h2>`,
              referenceSolution: `<a href="about.html">About</a>
<a href="routes/valley.html">The valley route</a>
<img src="images/logo.svg" alt="Riverside Cycle Hire">
<a href="#prices">Prices</a>
<h2 id="prices">Prices</h2>`,
              hints: [
                'You are already at the top level, so ../ takes you above the site entirely.',
                'A leading slash breaks when the page is opened as a local file — drop it.',
                'The logo is inside the images folder, so the path needs that folder name.',
                'Fragment links are case-sensitive: #Prices does not match id="prices".',
              ],
              requirements: [
                attrValue('a', 'href', 'about.html', 'The About link is a simple relative path'),
                attrValue('a', 'href', 'routes/valley.html', 'The route link has no leading slash'),
                attrValue('img', 'src', 'images/logo.svg', 'The image path includes its folder'),
                attrValue('a', 'href', '#prices', 'The fragment link matches the id exactly, including case'),
              ],
              difficulty: 4,
              xp: 55,
              skill: 'links',
            },
          ],
          quiz: [
            {
              slug: 'q-dotdot',
              prompt: 'What does `../` mean at the start of a path?',
              explanation: 'It moves up one folder from where the current file lives.',
              options: [
                { label: 'Go up one folder', correct: true },
                { label: 'Go to the site root' },
                { label: 'Stay in the current folder' },
                { label: 'Go to the previous page' },
              ],
              skill: 'links',
            },
            {
              slug: 'q-leading-slash',
              prompt: 'Why can `/images/logo.svg` fail when you open a page from your own computer?',
              explanation:
                'The leading slash means "the root", and with no server that root is your hard drive rather than your project folder.',
              options: [
                { label: 'The leading slash points at the drive root, not the project folder', correct: true },
                { label: 'Local files cannot display SVG images' },
                { label: 'Browsers block absolute paths for security' },
                { label: 'The image needs an absolute URL' },
              ],
              skill: 'links',
            },
            {
              slug: 'q-fragment-case',
              prompt: 'Does `href="#Prices"` reach an element with `id="prices"`?',
              explanation: 'No. Fragment identifiers and ids are case-sensitive, so they must match exactly.',
              options: [
                { label: 'No — fragments are case-sensitive', correct: true },
                { label: 'Yes — HTML ignores case in ids' },
                { label: 'Only in some browsers' },
                { label: 'Only if the id is on a heading' },
              ],
              skill: 'links',
            },
          ],
        },
        {
          slug: 'special-links',
          title: 'Email, telephone and download links',
          subtitle: 'Links that do something other than load a page',
          summary:
            'Three link types that make a contact page genuinely useful, especially on a phone.',
          objectives: [
            'Create a link that opens an email client',
            'Create a tap-to-call telephone link',
            'Offer a file for download with a sensible filename',
          ],
          estimatedMinutes: 10,
          skill: 'links',
          blocks: [
            objectives([
              'Write mailto: and tel: links correctly',
              'Use the download attribute',
              'Explain why the visible text should show the address, not hide it',
            ]),
            code(
              `<a href="mailto:hello@example.org">hello@example.org</a>
<a href="tel:+441632960123">+44 1632 960123</a>
<a href="price-list.pdf" download="riverside-prices-2026.pdf">
  Download our price list (PDF, 240KB)
</a>`,
              'The three special link types',
            ),
            annotated(
              `<a href="mailto:hello@example.org?subject=Bike%20hire%20enquiry">
  hello@example.org
</a>`,
              [
                { line: '1', text: '`mailto:` followed by the address opens the visitor\'s email program.' },
                {
                  line: '1',
                  text: 'You can pre-fill a subject with `?subject=`. Spaces must be written as `%20` because a URL cannot contain a raw space.',
                },
                {
                  line: '2',
                  text: 'Show the actual address as the link text. Someone without an email program configured can then still copy it, and it prints usefully.',
                },
              ],
            ),
            callout(
              'tip',
              'Telephone numbers: always international format',
              'Write `tel:+441632960123` — a plus sign, the country code, then the number with no spaces or brackets. The visible text can be formatted for humans however you like. A number without a country code fails for anyone calling from abroad.',
            ),
            prose(
              'The `download` attribute tells the browser to save a file rather than trying to display it, and its value becomes the suggested filename. This matters: a server-generated file called `doc_38271.pdf` becomes `riverside-prices-2026.pdf` on the visitor\'s computer.',
            ),
            callout(
              'accessibility',
              'Tell people what they are about to download',
              'Include the file type and rough size in the link text: "Download our price list (PDF, 240KB)". People on limited data plans, slow connections or metered mobile need that information *before* they tap, not after.',
            ),
            detail(
              'Does the download attribute always work?',
              'It applies only to same-origin files — you cannot force a download of a file hosted on someone else\'s domain, for good security reasons. If the file is on your own site it works everywhere current. If the browser ignores it, the link still works; it just opens the file instead of saving it, which is a perfectly acceptable fallback.',
            ),
            recap(
              [
                '`mailto:` opens an email client; show the real address as the link text.',
                '`tel:` should always use full international format with a `+`.',
                '`download="filename"` saves the file and suggests a better name.',
                'Always state the file type and size in the link text.',
              ],
              'Next: assembling links into navigation.',
            ),
          ],
          exercises: [
            {
              slug: 'special-links-guided',
              kind: 'guided',
              title: 'Build a contact block',
              brief:
                'Create three links: an email link to `hello@example.org` showing the address as its text, a telephone link to `+441632960123`, and a download link to `price-list.pdf` that saves as `riverside-prices-2026.pdf` and states the file type in its text.',
              starterCode: `<h2>Contact us</h2>
<ul>
  <li></li>
  <li></li>
  <li></li>
</ul>`,
              referenceSolution: `<h2>Contact us</h2>
<ul>
  <li><a href="mailto:hello@example.org">hello@example.org</a></li>
  <li><a href="tel:+441632960123">+44 1632 960123</a></li>
  <li>
    <a href="price-list.pdf" download="riverside-prices-2026.pdf">
      Download our price list (PDF, 240KB)
    </a>
  </li>
</ul>`,
              hints: [
                'The email href starts with mailto: and then the address, with no space.',
                'The telephone href starts with tel:+44 and continues with no spaces or brackets.',
                'The download attribute takes the filename you want the visitor to receive.',
              ],
              requirements: [
                attrMatches('a', 'href', '^mailto:', 'There is a mailto link'),
                attrMatches('a', 'href', '^tel:\\+', 'There is a tel link in international format'),
                attr('a[download]', 'download', 'The download link has a download attribute'),
                { kind: 'text_content', selector: 'a[download]', expectedValue: 'PDF', message: 'The download link states the file type' },
                count('li a', 3, 3, 'All three links are inside list items'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'links',
            },
          ],
          quiz: [
            {
              slug: 'q-tel-format',
              prompt: 'Which `tel:` value is correct?',
              explanation:
                'International format with a leading plus and country code, and no spaces or punctuation inside the value.',
              options: [
                { label: 'tel:+441632960123', correct: true },
                { label: 'tel:01632 960123' },
                { label: 'tel:(01632) 960-123' },
                { label: 'tel:0044 1632 960123' },
              ],
              skill: 'links',
            },
            {
              slug: 'q-download-attr',
              prompt: 'What does the `download` attribute do?',
              explanation:
                'It asks the browser to save the file rather than display it, and its value suggests the filename to save it under.',
              options: [
                { label: 'Saves the file, using its value as the suggested filename', correct: true },
                { label: 'Compresses the file before sending it' },
                { label: 'Counts how many times the file is downloaded' },
                { label: 'Restricts the download to signed-in visitors' },
              ],
              skill: 'links',
            },
          ],
        },
      ],
    },
    {
      slug: 'site-navigation',
      title: 'Navigation and multi-page sites',
      summary:
        'Menus, breadcrumbs, skip links and the folder structure that keeps a growing site sane.',
      estimatedMinutes: 55,
      prerequisites: ['links-and-paths'],
      isMilestone: true,
      skills: [
        { slug: 'links', masteryRequired: 0.7 },
        { slug: 'navigation', masteryRequired: 0 },
        { slug: 'multi-page', masteryRequired: 0 },
      ],
      lessons: [
        {
          slug: 'navigation-menus',
          title: 'Navigation menus, breadcrumbs and skip links',
          subtitle: 'Three patterns every professional site uses',
          summary:
            'A menu is a list of links inside a `<nav>`. Getting the details right makes it work for everyone.',
          objectives: [
            'Build a navigation menu as a list inside a nav element',
            'Mark the current page so visitors know where they are',
            'Add a skip link for keyboard users',
          ],
          estimatedMinutes: 16,
          skill: 'navigation',
          blocks: [
            objectives([
              'Build a navigation menu with correct semantics',
              'Indicate the current page with aria-current',
              'Add a skip link and explain who it helps',
            ]),
            prose(
              'A navigation menu is a list of links. Marking it up as an actual list is not decoration — it lets a screen reader announce "navigation, list of five items", so the user knows how much there is before they start.',
            ),
            annotated(
              `<nav aria-label="Main">
  <ul>
    <li><a href="index.html">Home</a></li>
    <li><a href="about.html">About</a></li>
    <li><a href="routes/index.html" aria-current="page">Routes</a></li>
    <li><a href="prices.html">Prices</a></li>
    <li><a href="contact.html">Contact</a></li>
  </ul>
</nav>`,
              [
                {
                  line: '1',
                  text: '`<nav>` marks this as a navigation landmark. Screen-reader users can jump straight to it.',
                },
                {
                  line: '1',
                  text: '`aria-label="Main"` names it. A page often has more than one nav — main, footer, on-this-page — and the label tells them apart.',
                },
                { line: '2-8', text: 'A plain unordered list. The order is not meaningful, so `<ul>` rather than `<ol>`.' },
                {
                  line: '5',
                  text: '`aria-current="page"` marks the link to the page you are already on. Screen readers announce it as "current page", and it can be styled differently for everyone else.',
                },
              ],
            ),
            callout(
              'tip',
              'Keep navigation identical on every page',
              'Same links, same order, same place. Consistency is a WCAG requirement, and it is also just good sense — people learn where things are, and moving them costs them time on every visit.',
            ),
            prose(
              'A breadcrumb trail shows where the current page sits in the site. It is an ordered list, because the order genuinely matters.',
            ),
            code(
              `<nav aria-label="Breadcrumb">
  <ol>
    <li><a href="../index.html">Home</a></li>
    <li><a href="index.html">Routes</a></li>
    <li><a href="valley.html" aria-current="page">The valley route</a></li>
  </ol>
</nav>`,
              'A breadcrumb trail',
            ),
            term(
              'Skip link',
              'A link at the very top of the page that jumps past the navigation, straight to the main content.',
            ),
            prose(
              'Someone using only a keyboard presses Tab to move between links. Without a skip link, they must Tab through every navigation item on every page before reaching the content. On a site with a twelve-item menu, that is twelve presses each time.',
            ),
            code(
              `<body>
  <a class="skip-link" href="#main">Skip to main content</a>

  <nav aria-label="Main"><!-- … --></nav>

  <main id="main">
    <h1>The valley route</h1>
  </main>
</body>`,
              'A skip link — the first focusable thing on the page',
            ),
            callout(
              'accessibility',
              'A skip link must be visible when focused',
              'The convention is to position it off-screen until it receives keyboard focus, then bring it into view. A skip link that stays invisible even when focused is worse than none — the user tabs into something they cannot see. The platform stylesheet in your previews handles this for you.',
            ),
            detail(
              'Why is the skip link first?',
              'Keyboard focus follows source order. For the link to be reachable before the navigation, it must appear before the navigation in the HTML — being visually positioned first is not enough. This is the clearest everyday example of a rule that runs through the whole course: the order of your markup is the order real users experience.',
            ),
            checklist('Every page in your site should have', [
              'A skip link as the first focusable element',
              'The same `<nav>` in the same place, with the same links',
              '`aria-current="page"` on the link to the current page',
              'A breadcrumb trail on pages more than one level deep',
              'A `<main>` element with an `id` the skip link targets',
            ]),
            recap(
              [
                'Navigation is a list of links inside `<nav>`; name each nav with `aria-label`.',
                '`aria-current="page"` marks where the visitor already is.',
                'Breadcrumbs are an ordered list, because the order is the meaning.',
                'A skip link must be the first focusable element and must become visible on focus.',
              ],
              'Next: organising the files themselves.',
            ),
          ],
          exercises: [
            {
              slug: 'nav-guided',
              kind: 'guided',
              title: 'Build a main navigation',
              brief:
                'Build a `<nav>` labelled "Main" containing a list of four links: Home, About, Prices and Contact. Mark the Prices link as the current page.',
              starterCode: `<nav>

</nav>`,
              referenceSolution: `<nav aria-label="Main">
  <ul>
    <li><a href="index.html">Home</a></li>
    <li><a href="about.html">About</a></li>
    <li><a href="prices.html" aria-current="page">Prices</a></li>
    <li><a href="contact.html">Contact</a></li>
  </ul>
</nav>`,
              hints: [
                'Add aria-label="Main" to the nav element itself.',
                'Inside it, build a <ul> with one <li> per link.',
                'On the Prices link only, add aria-current="page".',
              ],
              requirements: [
                attr('nav', 'aria-label', 'The nav has an aria-label naming it'),
                inside('ul', 'nav', 'The links are in a list inside the nav'),
                count('nav li a', 4, 4, 'There are four links'),
                attrValue('a[aria-current]', 'aria-current', 'page', 'The current page link is marked with aria-current="page"'),
                named('nav a', 'Every link has visible text'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'navigation',
            },
            {
              slug: 'skip-link-challenge',
              kind: 'challenge',
              title: 'A page with a skip link and breadcrumbs',
              brief:
                'Build a page body containing, in this order: a skip link targeting `#main`, a main navigation, a breadcrumb nav, and a `<main id="main">` with an `<h1>` inside it.',
              starterCode: '',
              referenceSolution: `<a class="skip-link" href="#main">Skip to main content</a>

<nav aria-label="Main">
  <ul>
    <li><a href="../index.html">Home</a></li>
    <li><a href="index.html">Routes</a></li>
  </ul>
</nav>

<nav aria-label="Breadcrumb">
  <ol>
    <li><a href="../index.html">Home</a></li>
    <li><a href="index.html">Routes</a></li>
    <li><a href="valley.html" aria-current="page">The valley route</a></li>
  </ol>
</nav>

<main id="main">
  <h1>The valley route</h1>
  <p>Twenty-four miles, mostly flat, one long climb near the reservoir.</p>
</main>`,
              hints: [
                'The skip link comes first in the source — before any nav.',
                'Two <nav> elements need two different aria-label values so they can be told apart.',
                'The <main> needs id="main" for the skip link to reach it.',
              ],
              requirements: [
                attrValue('a', 'href', '#main', 'There is a skip link pointing at #main'),
                count('nav', 2, 2, 'There are two nav elements'),
                attr('nav', 'aria-label', 'Both navs are labelled'),
                attrValue('main', 'id', 'main', 'The main element has id="main"'),
                inside('h1', 'main', 'The h1 is inside the main element'),
                present('nav ol', 'The breadcrumb uses an ordered list'),
                { kind: 'no_duplicate_ids', message: 'Every id is unique' },
              ],
              difficulty: 4,
              xp: 55,
              skill: 'navigation',
            },
            {
              slug: 'nav-debug',
              kind: 'debug',
              title: 'Navigation that fails a keyboard user',
              brief:
                'This navigation has four problems: the links are not in a list, the nav has no label, no link is marked as current, and the skip link points at an id that does not exist. Fix all four.',
              starterCode: `<a href="#content">Skip to main content</a>
<nav>
  <a href="index.html">Home</a>
  <a href="about.html">About</a>
  <a href="contact.html">Contact</a>
</nav>
<main id="main">
  <h1>About us</h1>
</main>`,
              referenceSolution: `<a href="#main">Skip to main content</a>
<nav aria-label="Main">
  <ul>
    <li><a href="index.html">Home</a></li>
    <li><a href="about.html" aria-current="page">About</a></li>
    <li><a href="contact.html">Contact</a></li>
  </ul>
</nav>
<main id="main">
  <h1>About us</h1>
</main>`,
              hints: [
                'The skip link must match the id on <main>, which is "main" not "content".',
                'Wrap the three links in a <ul>, one <li> each.',
                'Add aria-label="Main" to the nav.',
                'The h1 says "About us", so the About link is the current page.',
              ],
              requirements: [
                attrValue('a', 'href', '#main', 'The skip link targets the id that actually exists'),
                inside('ul', 'nav', 'The links are wrapped in a list'),
                count('nav li a', 3, 3, 'All three links are list items'),
                attr('nav', 'aria-label', 'The nav is labelled'),
                attrValue('a[aria-current]', 'aria-current', 'page', 'The current page is marked'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'navigation',
            },
          ],
          quiz: [
            {
              slug: 'q-nav-list',
              prompt: 'Why put navigation links inside a `<ul>`?',
              explanation:
                'A screen reader announces the number of items, so the user knows how large the menu is before entering it.',
              options: [
                { label: 'So screen readers can announce how many links there are', correct: true },
                { label: 'Because links cannot appear directly inside <nav>' },
                { label: 'To make them display vertically' },
                { label: 'Because search engines require it' },
              ],
              skill: 'navigation',
            },
            {
              slug: 'q-skip-link-position',
              prompt: 'Where must a skip link appear in the HTML?',
              explanation:
                'Keyboard focus follows source order, so the skip link must be the first focusable element in the document.',
              options: [
                { label: 'As the first focusable element, before the navigation', correct: true },
                { label: 'Anywhere, as long as CSS positions it at the top' },
                { label: 'Inside the <nav> element' },
                { label: 'At the end of the page' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-aria-current',
              prompt: 'What does `aria-current="page"` do?',
              explanation:
                'It marks the link that points at the page the user is already on, so assistive technology can announce it as the current page.',
              options: [
                { label: 'Marks the link to the page the visitor is currently viewing', correct: true },
                { label: 'Disables the link' },
                { label: 'Highlights the link in the browser' },
                { label: 'Tells search engines which page is canonical' },
              ],
              skill: 'accessibility',
            },
          ],
        },
        {
          slug: 'multi-page-milestone',
          title: 'Milestone: connect a website',
          subtitle: 'Three pages, one navigation, no broken links',
          summary:
            'Build the navigation that will carry your capstone site for the rest of the course.',
          objectives: [
            'Plan a folder structure for a multi-page site',
            'Build navigation that works from every page',
            'Verify that no internal link is broken',
          ],
          estimatedMinutes: 25,
          skill: 'multi-page',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Organise a project into sensible files and folders',
              'Build a navigation block that works identically on every page',
              'Check every internal link resolves',
            ]),
            prose(
              'A website is a set of files that reference each other. Before writing any of them, decide where things go — changing your mind later means fixing every path.',
            ),
            code(
              `my-site/
├── index.html          the homepage
├── about.html
├── contact.html
├── prices.html
├── images/             every image, in one place
│   ├── logo.svg
│   └── workshop.jpg
└── routes/
    ├── index.html      the routes landing page
    ├── valley.html
    └── harbour.html`,
              'A structure that scales',
              'text',
            ),
            checklist('Naming rules that save you pain', [
              'Lowercase only — some servers treat `About.html` and `about.html` as different files',
              'Hyphens between words, never spaces — a space becomes `%20` in a URL',
              'Descriptive names: `day-rates.html`, not `page2.html`',
              'One folder per section, with its own `index.html`',
              'All images in `images/`, all downloads in `files/`',
            ]),
            callout(
              'warning',
              'Spaces in filenames are a real bug source',
              'A file called `price list.html` must be linked as `price%20list.html`. It works, but it is ugly, easy to get wrong, and breaks the moment someone types the name by hand. Use a hyphen.',
            ),
            prose(
              'The navigation block itself is the same on every page — but the paths inside it are not. From `index.html` the About link is `about.html`; from `routes/valley.html` it is `../about.html`. This is exactly the kind of repetition that templating tools exist to remove, and Level 5 shows how professionals handle it.',
            ),
            recap(
              [
                'Decide your folder structure before you write the files.',
                'Lowercase, hyphenated, descriptive filenames.',
                'Navigation stays identical; only the paths change with depth.',
                'Every internal link must resolve — check them all.',
              ],
              'Level 4 next: images, video and audio.',
            ),
          ],
          exercises: [
            {
              slug: 'multipage-milestone-build',
              kind: 'challenge',
              title: 'Milestone: a connected page',
              brief:
                'Build a complete `about.html` page for a site whose other pages are `index.html`, `prices.html` and `contact.html`, all at the top level. It needs the full document skeleton, a skip link, a labelled main navigation with all four links, `aria-current` on the About link, and a `<main>` containing an `<h1>` and two paragraphs — one of which contains a link to `contact.html`.',
              starterCode: '',
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About us — Riverside Cycle Hire</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>

    <nav aria-label="Main">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="about.html" aria-current="page">About</a></li>
        <li><a href="prices.html">Prices</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>

    <main id="main">
      <h1>About us</h1>
      <p>
        We have hired bikes from the same Mill Lane workshop since 1998, and
        every bike that leaves the shop has been serviced by our own mechanics.
      </p>
      <p>
        If you would like a route recommendation before you arrive,
        <a href="contact.html">send us a message</a> and we will reply the same day.
      </p>
    </main>
  </body>
</html>`,
              hints: [
                'Start with the full skeleton, including a title specific to this page.',
                'The skip link is the very first thing inside <body>.',
                'The nav needs aria-label, a <ul>, and four <li> items.',
                'Mark the About link with aria-current="page" since this is the About page.',
              ],
              requirements: [
                doctype(),
                unique('title', 'The page has its own title'),
                attrValue('a', 'href', '#main', 'A skip link targets #main'),
                attr('nav', 'aria-label', 'The navigation is labelled'),
                count('nav li a', 4, 4, 'The nav contains four links'),
                attrValue('a[aria-current]', 'aria-current', 'page', 'The current page is marked'),
                unique('main', 'There is exactly one main element'),
                attrValue('main', 'id', 'main', 'The main element has the id the skip link targets'),
                inside('h1', 'main', 'The h1 is inside main'),
                count('main p', 2, null, 'At least two paragraphs of content'),
                inside('a[href="contact.html"]', 'main p', 'A paragraph links to the contact page'),
                headingOrder(),
                legalNesting(),
              ],
              difficulty: 4,
              xp: 110,
              skill: 'multi-page',
            },
            {
              slug: 'navigation-mission',
              kind: 'project_mission',
              title: 'Capstone mission: add navigation to every page',
              brief:
                'Add the same navigation block to your capstone site\'s `index.html` and `about.html`, and create a third page. Every page needs the skip link, the identical nav, and `aria-current` pointing at itself. This nav will appear on every page you build from now on.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page title — your site</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>

    <nav aria-label="Main">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>

    <main id="main">
      <h1>Your page heading</h1>
      <p>Your content.</p>
    </main>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Prices — Riverside Cycle Hire</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <nav aria-label="Main">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="prices.html" aria-current="page">Prices</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>
    <main id="main">
      <h1>Prices</h1>
      <p>Hourly hire starts at £6, with a two-hour minimum.</p>
    </main>
  </body>
</html>`,
              hints: [
                'Copy the nav block exactly onto each page — consistency is the point.',
                'On each page, move aria-current="page" to the link for that page.',
                'Give every page its own <title>, not a shared one.',
              ],
              requirements: [
                doctype(),
                attrValue('a', 'href', '#main', 'The skip link is present'),
                attr('nav', 'aria-label', 'The nav is labelled'),
                count('nav li a', 3, null, 'The nav has at least three links'),
                attrValue('a[aria-current]', 'aria-current', 'page', 'This page is marked as current'),
                unique('main', 'There is one main element'),
                inside('h1', 'main', 'The h1 is inside main'),
                unique('title', 'The page has its own title'),
              ],
              difficulty: 3,
              xp: 80,
              skill: 'multi-page',
            },
          ],
          quiz: [
            {
              slug: 'q-filenames',
              prompt: 'Why avoid spaces in filenames?',
              explanation:
                'A space becomes `%20` in a URL. The link still works, but it is error-prone to type and read.',
              options: [
                { label: 'A space becomes %20 in the URL, which is easy to get wrong', correct: true },
                { label: 'Browsers refuse to load files with spaces' },
                { label: 'Spaces make files larger' },
                { label: 'HTML forbids them' },
              ],
              skill: 'multi-page',
            },
            {
              slug: 'q-nav-consistency',
              prompt: 'Why should navigation appear in the same place on every page?',
              explanation:
                'Consistent navigation is a WCAG 2.2 requirement and reduces the effort of using the site for everyone, especially people with cognitive disabilities.',
              options: [
                { label: 'People learn where it is; moving it costs them effort on every page', correct: true },
                { label: 'Browsers cache navigation only when it is identical' },
                { label: 'It makes the HTML file smaller' },
                { label: 'Search engines penalise varied navigation' },
              ],
              skill: 'navigation',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'level-3-milestone',
    kind: 'milestone',
    title: 'Level 3 milestone: Navigation Architect',
    description: 'Eight questions on links, paths and navigation. Pass mark 75%.',
    passScore: 0.75,
    xp: 160,
    questions: [
      {
        slug: 'a3-q1',
        prompt: 'You are in `routes/valley.html`. How do you link to `index.html` at the top level?',
        explanation: '`../` moves up one folder, out of `routes/`, then `index.html` is beside you.',
        options: [
          { label: '../index.html', correct: true },
          { label: 'index.html' },
          { label: '/index.html' },
          { label: 'routes/index.html' },
        ],
        skill: 'links',
      },
      {
        slug: 'a3-q2',
        prompt: 'Which link text is best?',
        explanation: 'It describes its destination and makes sense read on its own.',
        options: [
          { label: 'Download our 2026 price list (PDF)', correct: true },
          { label: 'Click here' },
          { label: 'Read more' },
          { label: 'This link' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'a3-q3',
        prompt: 'What must accompany `target="_blank"`?',
        explanation:
          '`rel="noopener noreferrer"` protects the user, and the visible text should say a new tab will open.',
        options: [
          { label: 'rel="noopener noreferrer" and a visible warning', correct: true },
          { label: 'A download attribute' },
          { label: 'An absolute URL' },
          { label: 'aria-current="page"' },
        ],
        skill: 'security',
      },
      {
        slug: 'a3-q4',
        prompt: 'What does `href="#prices"` do?',
        explanation: 'It jumps to the element on the current page whose id is `prices`.',
        options: [
          { label: 'Jumps to the element with id="prices" on this page', correct: true },
          { label: 'Loads a file called prices' },
          { label: 'Adds a hash to the URL with no effect' },
          { label: 'Filters the page to show only prices' },
        ],
        skill: 'links',
      },
      {
        slug: 'a3-q5',
        prompt: 'Which is correctly formatted for a phone link?',
        explanation: 'International format: a plus, the country code, then digits with no separators.',
        options: [
          { label: 'href="tel:+441632960123"', correct: true },
          { label: 'href="tel:01632 960123"' },
          { label: 'href="phone:+441632960123"' },
          { label: 'href="call:01632960123"' },
        ],
        skill: 'links',
      },
      {
        slug: 'a3-q6',
        prompt: 'Which element should a breadcrumb trail use for its list?',
        explanation: 'The order of a breadcrumb is meaningful, so it is an ordered list.',
        options: [
          { label: '<ol>', correct: true },
          { label: '<ul>' },
          { label: '<dl>' },
          { label: '<menu>' },
        ],
        skill: 'navigation',
      },
      {
        slug: 'a3-q7',
        prompt: 'A page has two `<nav>` elements. How do you distinguish them?',
        explanation:
          'Give each an `aria-label`, so a screen reader announces "Main navigation" and "Breadcrumb navigation" rather than two identical landmarks.',
        options: [
          { label: 'Give each an aria-label', correct: true },
          { label: 'Give each an id' },
          { label: 'Nest one inside the other' },
          { label: 'Use <nav> once and <div> for the other' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'a3-q8',
        prompt: 'Who does a skip link help most?',
        explanation:
          'Keyboard-only users, including many screen-reader users, who would otherwise tab through the whole menu on every page.',
        options: [
          { label: 'Keyboard-only users who would otherwise tab through the whole menu', correct: true },
          { label: 'Mobile users on slow connections' },
          { label: 'Search engine crawlers' },
          { label: 'Users with colour blindness' },
        ],
        skill: 'accessibility',
      },
    ],
  },
};
