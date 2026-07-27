import {
  activeRecap,
  attr,
  attrMatches,
  attrValue,
  callout,
  checklist,
  code,
  count,
  detail,
  doctype,
  goodAlt,
  headingOrder,
  inside,
  labelled,
  legalNesting,
  mediaResolves,
  named,
  noObsolete,
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
  demo,
  mediaExample,
  recall,
} from '../types';

export const LEVEL_12: LevelSpec = {
  slug: 'html-hero-capstone',
  title: 'HTML Hero Capstone',
  subtitle: 'Finish, review and publish the website you have been building all along',
  summary:
    'You have been building this site since Level 1. This level completes it, reviews it against every standard in the course, and gets it ready to publish.',
  outcome:
    'You have a complete, valid, accessible, fast, multi-page website you built yourself — and you can explain every decision in it.',
  accent: 'blue',
  modules: [
    {
      slug: 'completing-the-site',
      title: 'Completing the site',
      summary:
        'The remaining pages, the shared patterns, and the pieces that turn a set of pages into a website.',
      estimatedMinutes: 60,
      prerequisites: ['validation-and-tools'],
      skills: [
        { slug: 'multi-page', masteryRequired: 0.75 },
        { slug: 'semantic-html', masteryRequired: 0.75 },
        { slug: 'accessibility', masteryRequired: 0.75 },
      ],
      lessons: [
        {
          slug: 'assembling-the-site',
          title: 'Assembling the site',
          subtitle: 'Five pages, one consistent structure',
          summary:
            'Every module has added a piece. This lesson puts them together and fills the gaps.',
          objectives: [
            'Plan the final page set for your project',
            'Apply the shared page shell to every page',
            'Add the remaining page your project needs',
          ],
          estimatedMinutes: 20,
          skill: 'multi-page',
          blocks: [
            objectives([
              'Complete the page set your capstone needs',
              'Apply one consistent page shell across every page',
              'Verify that no internal link is broken',
            ]),
            prose(
              'Your finished site needs at least five pages: a homepage, an about page, a page showing what you offer, a contact page, and one more that suits your particular project.',
            ),
            code(
              `Homepage        What this is, who it is for, and the one thing you
                want a visitor to do next.

About           The story, the people, the credentials. Where trust is built.

Services /      What you offer, in detail. Usually the longest page and
Products /      the one people actually came for.
Projects

Contact         The form, the address, the phone number, the hours.

One more        Depends on your project:
                · a portfolio → case study
                · a restaurant → menu
                · an event → programme
                · a rental business → FAQ or terms
                · a news site → an article page`,
              'The five-page structure',
              'text',
            ),
            term(
              'Page shell',
              'The markup every page shares: the head metadata pattern, the skip link, the header and navigation, the main landmark, and the footer. Only the contents of `<main>` and the metadata values change.',
            ),
            code(
              `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="referrer" content="strict-origin-when-cross-origin">

    <title>PAGE NAME — SITE NAME</title>
    <meta name="description" content="ONE SENTENCE ABOUT THIS PAGE">
    <link rel="canonical" href="https://YOUR-SITE/THIS-PAGE.html">
    <link rel="icon" href="/favicon.svg" type="image/svg+xml">

    <meta property="og:title" content="PAGE NAME — SITE NAME">
    <meta property="og:description" content="ONE SENTENCE ABOUT THIS PAGE">
    <meta property="og:image" content="https://YOUR-SITE/images/share-1200.jpg">
    <meta property="og:image:alt" content="DESCRIBE THE SHARE IMAGE">
    <meta property="og:url" content="https://YOUR-SITE/THIS-PAGE.html">
    <meta property="og:type" content="website">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>

    <header>
      <a href="index.html">SITE NAME</a>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="services.html">Services</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>

    <main id="main">
      <h1>PAGE HEADING</h1>
      <!-- This page's content -->
    </main>

    <footer>
      <p>&copy; 2026 SITE NAME</p>
      <nav aria-label="Footer">
        <ul>
          <li><a href="privacy.html">Privacy</a></li>
        </ul>
      </nav>
    </footer>
  </body>
</html>`,
              'The page shell — copy this for every page and change only the marked parts',
            ),
            callout(
              'tip',
              'Change `aria-current` per page',
              'The shell is identical everywhere except for one thing: `aria-current="page"` moves to the link for whichever page you are on. It is the easiest detail to forget when copying, and it is the one that tells visitors where they are.',
            ),
            visual('file-paths', 'Your finished project structure.'),
            checklist('Before moving on, confirm', [
              'Five pages exist, each with its own title and description',
              'Every page uses the identical shell',
              '`aria-current="page"` is correct on each',
              'Every internal link resolves — click all of them',
              'All assets are in `assets/`, with lowercase hyphenated names',
              'A favicon exists and is linked from every page',
            ]),
            mediaExample(
              'workshop-tools',
              'A real page, assembled from everything so far',
              'Every element here has been covered: a landmark, a heading, a described image with dimensions, and a link whose text works on its own. Assembly is not a new skill — it is the point at which the previous eleven levels stop being separate.',
              `<main>
  <h1>The workshop</h1>
  <img src="/learning-media/images/workshop-tools.jpg"
       alt="Hand tools hanging in rows on a workshop wall above a wooden workbench"
       width="1600" height="900" loading="lazy" decoding="async">
  <p>Every repair is done here, by hand.</p>
  <a href="repairs.html">See what a service includes</a>
</main>`,
            ),
            demo('A page section, before and after the course', 'The same content as a beginner writes it, and as you write it now.', [
              {
                label: 'Now',
                code: '<main>\n  <h1>Repairs</h1>\n  <img src="/learning-media/images/workshop-tools.jpg" alt="Hand tools hanging in rows on a workshop wall" width="1600" height="900" loading="lazy">\n  <p>Booked in and returned within a week.</p>\n  <a href="repairs.html">See what a service includes</a>\n</main>',
                note: 'A landmark, one h1, described image with reserved space, deferred loading, and link text that works alone.',
              },
              {
                label: 'Before',
                code: '<div class="content">\n  <div class="title">Repairs</div>\n  <img src="workshop.jpg">\n  <div>Booked in and returned within a week.</div>\n  <a href="repairs.html">Click here</a>\n</div>',
                note: 'Renders almost identically and fails on every count: no landmark, no heading, no alt, no dimensions, and link text that means nothing in a list.',
              },
            ]),
            recap(
              [
                'Five pages, one shell, differing only in metadata and main content.',
                '`aria-current` moves per page.',
                'Check every internal link by clicking it.',
              ],
              'Next: the final review.',
            ),
          ],
          exercises: [
            {
              slug: 'shell-guided',
              kind: 'guided',
              title: 'Build the page shell',
              brief:
                'Build the complete shell for one page of your site: full head metadata, skip link, header with navigation, main with an h1, and a footer with a secondary nav.',
              starterCode: '',
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="referrer" content="strict-origin-when-cross-origin">
    <title>Services — Riverside Cycle Hire</title>
    <meta name="description" content="Bike hire, guided rides and repairs from our Mill Lane workshop.">
    <link rel="canonical" href="https://riverside-cycles.example/services.html">
    <link rel="icon" href="/learning-media/favicon.svg" type="image/svg+xml">
    <meta property="og:title" content="Services — Riverside Cycle Hire">
    <meta property="og:description" content="Bike hire, guided rides and repairs.">
    <meta property="og:image" content="https://riverside-cycles.example/images/share-1200.jpg">
    <meta property="og:image:alt" content="A blue hybrid bike outside the Mill Lane workshop">
    <meta property="og:url" content="https://riverside-cycles.example/services.html">
    <meta property="og:type" content="website">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <a href="index.html">Riverside Cycle Hire</a>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="services.html" aria-current="page">Services</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Services</h1>
      <p>Everything we offer, from an hour's hire to a full service.</p>
    </main>
    <footer>
      <p>&copy; 2026 Riverside Cycle Hire</p>
      <nav aria-label="Footer">
        <ul><li><a href="privacy.html">Privacy</a></li></ul>
      </nav>
    </footer>
  </body>
</html>`,
              hints: [
                'Work down the shell from the template in the lesson.',
                'Two navs means two different aria-label values.',
                'Put aria-current="page" on the link for this page.',
              ],
              requirements: [
                doctype(),
                { kind: 'attribute_present', selector: 'html', attribute: 'lang', message: 'The page declares its language' },
                unique('title', 'The page has its own title'),
                attr('meta[name="description"]', 'content', 'The page has a description'),
                present('link[rel="canonical"]', 'A canonical URL is set'),
                present('link[rel="icon"]', 'A favicon is linked'),
                present('meta[property="og:title"]', 'Open Graph metadata is present'),
                attrValue('a', 'href', '#main', 'There is a skip link'),
                present('header', 'There is a header landmark'),
                count('nav', 2, null, 'There is a main nav and a footer nav'),
                attr('nav', 'aria-label', 'Both navs are labelled'),
                attrValue('a[aria-current]', 'aria-current', 'page', 'The current page is marked'),
                unique('main', 'There is exactly one main'),
                inside('h1', 'main', 'The h1 is inside main'),
                present('footer', 'There is a footer landmark'),
                headingOrder(),
                legalNesting(),
              ],
              difficulty: 4,
              xp: 120,
              skill: 'multi-page',
            },
          ],
          quiz: [
            {
              slug: 'q-shell-difference',
              prompt: 'What should differ between two pages using the same shell?',
              explanation:
                'The title, description, canonical, Open Graph values, the `aria-current` position, and the contents of `<main>`. Everything else is identical.',
              options: [
                { label: 'Metadata values, aria-current, and the contents of main', correct: true },
                { label: 'The navigation link order' },
                { label: 'The position of the skip link' },
                { label: 'Nothing — pages should be byte-identical' },
              ],
              skill: 'multi-page',
            },
          ],
        },
        {
          slug: 'capstone-build',
          title: 'The capstone build',
          subtitle: 'Every requirement, one page at a time',
          summary:
            'The full requirement list for the finished site, and the build that proves you can meet it.',
          objectives: [
            'Meet every capstone requirement',
            'Combine everything from all twelve levels',
            'Produce work you would show an employer',
          ],
          estimatedMinutes: 45,
          skill: 'multi-page',
          masteryThreshold: 0.85,
          blocks: [
            objectives([
              'Build a page meeting the complete capstone requirement list',
              'Demonstrate every skill from the course on one page',
              'Produce a portfolio-quality result',
            ]),
            checklist('The capstone requirement list', [
              'Consistent navigation on every page, with a skip link',
              'Semantic landmarks: header, nav, main, footer',
              'An accessible heading hierarchy — one h1, no skipped levels',
              'A responsive image with `srcset` and `sizes`',
              'Locally available media only — no hotlinking, no broken paths',
              'A figure with a caption',
              'A video or audio element with controls and captions',
              'An accessible form with labels, grouping and validation',
              'A meaningful list',
              'A meaningful table, where the content genuinely warrants one',
              'A native interactive element — details, dialog or popover',
              'Unique page titles and meta descriptions',
              'Social-sharing metadata',
              'Basic structured data',
              'A favicon',
              'Organised project folders',
              'No broken internal links',
              'Valid HTML',
            ]),
            callout(
              'tip',
              'Do not build it all at once',
              'You have not been asked to. Every module since Level 1 added a piece, and what remains is assembling and polishing. If a requirement is missing, go back to the module that taught it — the mission from that module is the piece you skipped.',
            ),
            detail(
              'What "portfolio quality" actually means',
              'Not that it looks like an agency site — you have not learned CSS yet, and the platform supplies the presentation. It means the markup would survive review by a professional: correct elements, sound structure, real alt text, working keyboard access, no broken paths, and metadata that is genuinely specific to each page. Somebody reading your HTML should be able to tell you knew why you chose each element. That is a genuinely employable standard, and it is what this build is assessed against.',
            ),
            code(
              `<main id="main">
  <h1>Bike hire and guided rides</h1>

  <img src="hero-1200.jpg"
       srcset="hero-480.jpg 480w, hero-1200.jpg 1200w"
       sizes="100vw" alt="Sunrise over the estuary"
       fetchpriority="high" width="1200" height="800">

  <h2>Our rates</h2>
  <table>
    <caption>Bike hire rates, 2026</caption>
    <thead><tr><th scope="col">Bike</th><th scope="col">Per day</th></tr></thead>
    <tbody><tr><th scope="row">Hybrid</th><td>£22</td></tr></tbody>
  </table>

  <h2>Common questions</h2>
  <details name="faq" open>
    <summary>Do I need to book?</summary>
    <p>Not on weekdays.</p>
  </details>
</main>`,
              'The shape of the capstone page — every requirement visible at once',
            ),
            visual('semantic-landmarks', 'The landmark structure every page of your site should have.'),
            mediaExample(
              'product-bottle',
              'A product entry, marked up properly',
              'A single item on a shop or menu page. Note what it does *not* need: no ARIA, no roles, no wrappers. Correct elements, and the accessibility comes free.',
              `<article>
  <h3>Stoneware bottle</h3>
  <img src="/learning-media/images/product-bottle.jpg"
       alt="A dark green ceramic bottle with a cork stopper"
       width="1200" height="1200" loading="lazy" decoding="async">
  <p>Hand-thrown, 500ml. <strong>£28</strong></p>
  <a href="bottle.html">Read more about the stoneware bottle</a>
</article>`,
            ),
            demo('Three states of the same project page', 'What "finished" actually means, checked against the course.', [
              {
                label: 'Finished',
                code: '<main id="main" tabindex="-1">\n  <h1>Stoneware bottle</h1>\n  <img src="/learning-media/images/product-bottle.jpg" alt="A dark green ceramic bottle with a cork stopper" width="1200" height="1200" loading="lazy">\n  <p>Hand-thrown, 500ml. <strong>£28</strong></p>\n  <a href="shop.html">Back to the full range</a>\n</main>',
                note: 'Landmark, one h1, described image with reserved space, deferred loading, and link text that stands alone.',
              },
              {
                label: 'Nearly',
                code: '<main>\n  <h1>Stoneware bottle</h1>\n  <img src="/learning-media/images/product-bottle.jpg" alt="bottle" width="1200" height="1200">\n  <p>Hand-thrown, 500ml. £28</p>\n  <a href="shop.html">Click here</a>\n</main>',
                note: 'Valid, and three faults: alt that names the object rather than describing it, no loading strategy, and link text that means nothing in a list.',
              },
              {
                label: 'Not started',
                code: '<div class="page">\n  <div class="title">Stoneware bottle</div>\n  <img src="bottle.jpg">\n  <div>Hand-thrown, 500ml. £28</div>\n</div>',
                note: 'No landmark, no heading, no alt, no dimensions, no link. It renders — and fails every check in the final review.',
              },
            ]),
            recap(
              [
                'The capstone is the assembly of twelve levels of work.',
                'Every requirement maps to a module you have already completed.',
                'The standard is markup that survives professional review.',
              ],
              'Next: the final review and publishing.',
            ),
          ],
          exercises: [
            {
              slug: 'capstone-main-build',
              kind: 'challenge',
              title: 'Capstone: the complete page',
              brief:
                'Build one complete page of your site that demonstrates every requirement on the list: full metadata and structured data, landmarks, a responsive image, a figure with a caption, a video with captions, a list, a table, a native interactive element, and an accessible form.',
              starterCode: '',
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="referrer" content="strict-origin-when-cross-origin">

    <title>Bike hire and guided rides — Riverside Cycle Hire</title>
    <meta name="description"
          content="Hourly, daily and weekly bike hire from £6, plus guided valley rides every Saturday.">
    <link rel="canonical" href="https://riverside-cycles.example/services.html">
    <link rel="icon" href="/learning-media/favicon.svg" type="image/svg+xml">

    <meta property="og:title" content="Bike hire and guided rides — Riverside Cycle Hire">
    <meta property="og:description" content="Hire from £6 an hour. Guided valley rides every Saturday.">
    <meta property="og:image" content="https://riverside-cycles.example/images/share-1200.jpg">
    <meta property="og:image:alt" content="A blue hybrid bike outside the Mill Lane workshop">
    <meta property="og:url" content="https://riverside-cycles.example/services.html">
    <meta property="og:type" content="website">

    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "LocalBusiness",
      "name": "Riverside Cycle Hire",
      "url": "https://riverside-cycles.example/",
      "telephone": "+441632960123",
      "address": {
        "@type": "PostalAddress",
        "streetAddress": "14 Mill Lane",
        "addressLocality": "Hexford",
        "postalCode": "HX2 4PL",
        "addressCountry": "GB"
      }
    }
    </script>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>

    <header>
      <a href="index.html">Riverside Cycle Hire</a>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="services.html" aria-current="page">Services</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>

    <main id="main">
      <h1>Bike hire and guided rides</h1>

      <img
        src="/learning-media/images/coast-sunrise-1200.jpg"
        srcset="/learning-media/images/coast-sunrise-480.jpg   480w,
                /learning-media/images/coast-sunrise-800.jpg   800w,
                /learning-media/images/coast-sunrise-1200.jpg 1200w,
                /learning-media/images/coast-sunrise-1600.jpg 1600w"
        sizes="100vw"
        alt="Sunrise over the estuary at the start of the river path"
        fetchpriority="high" width="1200" height="800">

      <p>
        We hire well-maintained bikes by the hour, the day or the week, and run
        guided rides through the valley every Saturday from March to October.
      </p>

      <h2>What every hire includes</h2>
      <ul>
        <li>A helmet, fitted before you leave</li>
        <li>A lock and a printed route map</li>
        <li>Roadside recovery within ten miles</li>
      </ul>

      <h2>Our rates</h2>
      <table>
        <caption>Bike hire rates, 2026</caption>
        <thead>
          <tr>
            <th scope="col">Bike type</th>
            <th scope="col">Per hour</th>
            <th scope="col">Per day</th>
          </tr>
        </thead>
        <tbody>
          <tr><th scope="row">Hybrid</th><td>£6</td><td>£22</td></tr>
          <tr><th scope="row">Road bike</th><td>£9</td><td>£34</td></tr>
          <tr><th scope="row">Child's bike</th><td>£4</td><td>£15</td></tr>
        </tbody>
        <tfoot>
          <tr><td colspan="3">All rates include a helmet and a lock.</td></tr>
        </tfoot>
      </table>

      <h2>The valley route</h2>
      <figure>
        <img src="/learning-media/images/forest-path-1200.jpg"
             alt="A sandy path winding between tall trees in a sunlit forest"
             loading="lazy" width="1200" height="800">
        <figcaption>The wooded section between mile eight and mile twelve.</figcaption>
      </figure>

      <video controls preload="metadata"
             poster="/learning-media/posters/responsive-layout.jpg"
             width="1280" height="720">
        <source src="/learning-media/video/responsive-layout.webm" type="video/webm">
        <source src="/learning-media/video/responsive-layout.mp4" type="video/mp4">
        <track kind="captions" src="/learning-media/captions/responsive-layout.en.vtt"
               srclang="en" label="English" default>
        <p>
          Your browser cannot play this video.
          <a href="/learning-media/video/responsive-layout.mp4">Download the MP4</a>.
        </p>
      </video>

      <h2>Common questions</h2>
      <details name="faq" open>
        <summary>Do I need to book in advance?</summary>
        <p>Not on weekdays. At weekends, please book a day ahead.</p>
      </details>
      <details name="faq">
        <summary>What if it rains?</summary>
        <p>Cancel up to two hours before for a full refund.</p>
      </details>

      <h2>Book a bike</h2>
      <form action="/booking" method="post">
        <label for="name">Your name</label>
        <input type="text" id="name" name="name" autocomplete="name" required minlength="2">

        <label for="email">Email address</label>
        <input type="email" id="email" name="email" autocomplete="email" required
               aria-describedby="email-hint">
        <p id="email-hint">We will only use this to confirm your booking.</p>

        <label for="date">Preferred date</label>
        <input type="date" id="date" name="date" required>

        <fieldset>
          <legend>Which bike would you like?</legend>
          <input type="radio" id="hybrid" name="biketype" value="hybrid" checked>
          <label for="hybrid">Hybrid</label>
          <input type="radio" id="road" name="biketype" value="road">
          <label for="road">Road bike</label>
        </fieldset>

        <label for="notes">Anything we should know?</label>
        <textarea id="notes" name="notes" rows="4" maxlength="500"></textarea>

        <button type="submit">Request a booking</button>
      </form>
    </main>

    <footer>
      <p>&copy; 2026 Riverside Cycle Hire</p>
      <nav aria-label="Footer">
        <ul>
          <li><a href="privacy.html">Privacy</a></li>
          <li><a href="terms.html">Terms</a></li>
        </ul>
      </nav>
    </footer>
  </body>
</html>`,
              hints: [
                'Start from the page shell, then add the main content section by section.',
                'Use the media picker to insert the responsive image srcset and the video paths.',
                'The table needs a caption, thead with scope="col", and row headings with scope="row".',
                'The form needs labels on everything, a fieldset with a legend, and an explicit button type.',
                'Do not forget the JSON-LD block in the head.',
              ],
              requirements: [
                doctype(),
                { kind: 'attribute_present', selector: 'html', attribute: 'lang', message: 'The page declares its language' },
                unique('title', 'The page has its own title'),
                attr('meta[name="description"]', 'content', 'The page has a meta description'),
                present('link[rel="canonical"]', 'A canonical URL is set'),
                present('link[rel="icon"]', 'A favicon is linked'),
                present('meta[property="og:title"]', 'Social sharing metadata is present'),
                attrMatches('meta[property="og:image"]', 'content', '^https?://', 'The share image is an absolute URL'),
                attrValue('script', 'type', 'application/ld+json', 'There is structured data'),
                attrValue('a', 'href', '#main', 'There is a skip link'),
                present('header', 'There is a header landmark'),
                count('nav', 2, null, 'There is a main nav and a footer nav'),
                attr('nav', 'aria-label', 'Every nav is labelled'),
                attrValue('a[aria-current]', 'aria-current', 'page', 'The current page is marked'),
                unique('main', 'There is exactly one main landmark'),
                present('footer', 'There is a footer landmark'),
                unique('h1', 'There is exactly one h1'),
                count('h2', 3, null, 'The page has several h2 sections'),
                headingOrder(),
                attr('img[srcset]', 'sizes', 'There is a responsive image with srcset and sizes'),
                present('figure > figcaption', 'There is a figure with a caption'),
                present('video[controls]', 'There is a video with controls'),
                present('track[kind="captions"]', 'The video has captions'),
                present('ul li, ol li', 'There is a meaningful list'),
                present('table > caption', 'There is a table with a caption'),
                count('th[scope="col"]', 2, null, 'The table has column headings with scope'),
                count('th[scope="row"]', 1, null, 'The table has row headings with scope'),
                count('details > summary', 2, null, 'There is a native interactive element'),
                present('form[action][method]', 'There is a form with an action and method'),
                labelled('input, select, textarea', 'Every form control is labelled'),
                present('fieldset > legend', 'Related controls are grouped with a legend'),
                attrValue('button', 'type', 'submit', 'The submit button has an explicit type'),
                goodAlt('img', 'Every image has meaningful alt text'),
                attr('img', 'width', 'Every image declares its dimensions'),
                mediaResolves('img, source, track, video'),
                uniqueIds(),
                legalNesting(),
                noObsolete(),
                named('a', 'Every link has an accessible name'),
              ],
              difficulty: 5,
              xp: 400,
              skill: 'multi-page',
            },
          ],
          quiz: [
            {
              slug: 'q-capstone-media',
              prompt: 'Why must the capstone use local media only?',
              explanation:
                'Hotlinked media breaks when the other site changes, uses their bandwidth without permission, and is usually a copyright problem.',
              options: [
                { label: 'Hotlinked media breaks, costs others bandwidth, and raises copyright issues', correct: true },
                { label: 'Browsers block cross-origin images' },
                { label: 'Local files always load faster' },
                { label: 'Remote images cannot have alt text' },
              ],
              skill: 'images',
            },
          ],
        },
      ],
    },
    {
      slug: 'review-and-publish',
      title: 'Final review and publishing',
      summary:
        'The review process a professional runs before shipping, and how to get your site onto the web.',
      estimatedMinutes: 45,
      prerequisites: ['completing-the-site'],
      isMilestone: true,
      skills: [
        { slug: 'validation', masteryRequired: 0.75 },
        { slug: 'debugging', masteryRequired: 0.75 },
        { slug: 'performance', masteryRequired: 0.7 },
        { slug: 'seo', masteryRequired: 0.7 },
      ],
      lessons: [
        {
          slug: 'final-review',
          title: 'The final review',
          subtitle: 'What to check before anything goes live',
          summary:
            'Five reviews, in order: validation, accessibility, media, performance, and a real device.',
          objectives: [
            'Run a complete pre-launch review',
            'Fix what it turns up',
            'Export your site as real files',
          ],
          estimatedMinutes: 20,
          skill: 'validation',
          blocks: [
            objectives([
              'Run the five reviews in order',
              'Interpret and act on what each turns up',
              'Export the finished site',
            ]),
            code(
              `1. VALIDATION
   Every page through validator.w3.org. Zero errors.
   Check: unclosed tags, duplicate ids, invalid nesting, obsolete elements.

2. ACCESSIBILITY
   Tab through every page: everything reachable, focus always visible,
   order matching the layout.
   Check: one h1 per page, no skipped levels, every image's alt, every
   form label, every link's text out of context, every iframe's title.

3. MEDIA
   Open the Network panel and reload every page. Zero 404s.
   Check: dimensions on every image, lazy loading below the fold,
   captions on video, posters set, no hotlinked files.

4. PERFORMANCE
   Check: no render-blocking scripts, no preload="auto" on media,
   hero image not lazy-loaded, no unnecessary resource hints.

5. REAL DEVICE
   Open the site on an actual phone, not just a simulated viewport.
   Check: text readable without zooming, tap targets large enough,
   nothing overflowing horizontally.`,
              'The five-review checklist',
              'text',
            ),
            callout(
              'tip',
              'Review in this order for a reason',
              'Validation first, because invalid markup makes every later check unreliable — an accessibility tool cannot judge a document the browser had to guess at. Then accessibility, then media, then performance, then a real device. Each stage assumes the previous one is clean.',
            ),
            prose(
              'When every review passes, export your project from HTML Hero. You get a folder of real `.html` files and an `assets/` directory, which will open in any browser and can be uploaded anywhere.',
            ),
            detail(
              'Publishing your site',
              'A static HTML site can be hosted almost anywhere, and usually free. Drag your exported folder onto a static host such as Netlify or Cloudflare Pages and it is live in seconds. Push it to a GitHub repository and enable GitHub Pages and it is live at a github.io address. Or upload the files by FTP to any traditional web host. Whichever you choose, the files you upload are exactly the files you exported — nothing needs building or compiling, because HTML runs as-is. That simplicity is one of the language\'s real strengths.',
            ),
            checklist('Before you publish', [
              'Every page validates with zero errors',
              'Keyboard test passes on every page',
              'Zero 404s in the Network panel',
              'Every page has its own title and description',
              'Favicon present and linked everywhere',
              'Tested on a real phone',
              'No placeholder text left anywhere',
            ]),
            mediaExample(
              'restaurant-plate',
              'The last thing to check: does it work on a real device?',
              'Every review stage before this one can be done at your desk. This one cannot — pick the page up on a phone, on real data, and tap the things people will tap.',
              `<img src="/learning-media/images/restaurant-plate.jpg"
     alt="An overhead view of a colourful plated dish on a white plate"
     width="1200" height="1200" loading="lazy" decoding="async">`,
            ),
            demo('The five reviews, in order', 'Each stage assumes the one before it is clean.', [
              {
                label: 'Validation first',
                code: '<!DOCTYPE html>\n<html lang="en">\n  <head><meta charset="utf-8"><title>Menu — Riverside</title></head>\n  <body><main><h1>Menu</h1></main></body>\n</html>',
                note: 'Zero errors before anything else. Measuring the performance of a page whose markup is broken measures the wrong page.',
              },
              {
                label: 'Then the keyboard',
                code: '<a href="#main-content">Skip to main content</a>\n<nav aria-label="Main"><a href="index.html">Home</a></nav>\n<main id="main-content" tabindex="-1"><h1>Menu</h1></main>',
                note: 'Tab from the top. Everything reachable, focus always visible, and the skip link lands somewhere that can hold focus.',
              },
              {
                label: 'Then media and performance',
                code: '<img src="/learning-media/images/restaurant-plate.jpg" alt="An overhead view of a colourful plated dish" width="1200" height="1200" loading="lazy" decoding="async">',
                note: 'Every asset resolves, every image has dimensions and an appropriate loading strategy. Only now is a measurement meaningful.',
              },
            ]),
            recall(
              'The last retrieval of the course. Close everything and write down what you would check on any page you were handed tomorrow — from memory, grouped however you like. Aim for fifteen items before you look.',
              [
                'Structure — doctype, `<html lang>`, charset first in the head, one unique title and description per page.',
                'Headings — exactly one `<h1>`, no skipped levels, headings describing structure rather than chosen for size.',
                'Landmarks — header, nav, main, footer; exactly one `<main>`; a skip link whose target can take focus.',
                'Links — text that works read alone; `rel="noopener noreferrer"` with `target="_blank"`; every internal path resolving.',
                'Images — an `alt` on every one, empty for decoration; `width` and `height` everywhere; `loading="lazy"` below the fold and never above it.',
                'Forms — a label per control, groups in a `<fieldset>` with a `<legend>`, `autocomplete` on fields about the user, errors connected and announced.',
                'ARIA — as little as possible; native elements first; `aria-current` on the current nav item.',
                'Keyboard — everything reachable, focus always visible, nothing trapped, Enter and Space both working on buttons.',
                'Validation — zero errors, no duplicate ids, no obsolete elements, legal nesting throughout.',
                'Performance — one priority image, dimensions everywhere, embeds lazy, titled and sandboxed.',
                'Metadata — canonical URL, favicon, Open Graph title, description and a described image.',
                'And the one no tool can check: does the alt text, the link text and the heading order describe what is actually on the page?',
              ],
              'Everything, from memory',
            ),
            recap(
              [
                'Five reviews, in order: validation, accessibility, media, performance, real device.',
                'Each stage assumes the previous one is clean.',
                'A static HTML site publishes with no build step at all.',
              ],
              'Finally: the course assessment.',
            ),
            activeRecap(
              [
                'Name the five reviews in order, and say why that order and not another.',
                'For each one, name the single check you would run first if you only had five minutes.',
                'What does it mean that a page passes validation but fails the keyboard test?',
              ],
              [
                'Validation, accessibility, media, performance, real device. Each stage assumes the previous one is clean — there is no point measuring the performance of a page whose markup is still broken, because fixing the markup changes the measurement.',
                'Validation: run the page through the W3C validator. Accessibility: tab through it from top to bottom. Media: check for 404s in the Network panel. Performance: check image dimensions and formats. Device: open it on a real phone.',
                'That valid markup and usable markup are different claims. Validation checks that the document is well formed; it cannot tell whether a control can be reached, whether focus is visible, or whether the reading order makes sense. A page can be perfectly valid and completely unusable without a mouse.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'final-review-exercise',
              kind: 'debug',
              title: 'The last five faults',
              brief:
                'This page is nearly ready. Five faults remain, one from each review category. Find and fix all five.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Services — Riverside Cycle Hire</title>
  </head>
  <body>
    <a class="skip-link" href="#content">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="services.html">Services</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Services</h1>
      <h3>Bike hire</h3>
      <img src="/learning-media/images/workshop.jpg" alt="Workshop" width="1200" height="800">
      <video src="/learning-media/video/page-anatomy.mp4" controls preload="auto" width="1280" height="720"></video>
    </main>
    <footer><p>&copy; 2026 Riverside Cycle Hire</p></footer>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Services — Riverside Cycle Hire</title>
    <meta name="description" content="Bike hire, guided rides and repairs from our Mill Lane workshop.">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="services.html" aria-current="page">Services</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Services</h1>
      <h2>Bike hire</h2>
      <img src="/learning-media/images/workshop-tools-1200.jpg"
           alt="Hand tools hanging in rows above a wooden workbench"
           width="1200" height="800">
      <video controls preload="metadata"
             poster="/learning-media/posters/page-anatomy.jpg"
             width="1280" height="720">
        <source src="/learning-media/video/page-anatomy.webm" type="video/webm">
        <source src="/learning-media/video/page-anatomy.mp4" type="video/mp4">
        <track kind="captions" src="/learning-media/captions/page-anatomy.en.vtt"
               srclang="en" label="English" default>
        <p><a href="/learning-media/video/page-anatomy.mp4">Download the MP4</a></p>
      </video>
    </main>
    <footer><p>&copy; 2026 Riverside Cycle Hire</p></footer>
  </body>
</html>`,
              hints: [
                'Accessibility: the skip link points at #content, but main has id="main".',
                'Structure: the h1 is followed by an h3, skipping a level.',
                'Media: the image path does not exist, and its alt text is one word.',
                'Media: the video has no captions and no poster.',
                'Metadata: the page has no meta description, and no link is marked as current.',
              ],
              requirements: [
                attrValue('a', 'href', '#main', 'The skip link matches the id on main'),
                headingOrder(),
                mediaResolves('img, source, video, track'),
                goodAlt('img', 'The image alt text is descriptive'),
                present('track[kind="captions"]', 'The video has captions'),
                attr('video', 'poster', 'The video has a poster image'),
                { kind: 'element_count', selector: 'video[preload="auto"]', minCount: 0, maxCount: 0, message: 'The video no longer preloads its whole file' },
                attr('meta[name="description"]', 'content', 'The page has a meta description'),
                attrValue('a[aria-current]', 'aria-current', 'page', 'The current page is marked in the nav'),
              ],
              difficulty: 5,
              xp: 150,
              skill: 'debugging',
            },
            {
              slug: 'capstone-final-mission',
              kind: 'project_mission',
              title: 'Capstone mission: the finished site',
              brief:
                'Apply the five reviews to every page of your capstone site and fix everything they turn up. When all five pass, export your project — the files are yours to publish anywhere.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page — your site</title>
    <meta name="description" content="A sentence about this page.">
    <link rel="canonical" href="https://your-site.example/page.html">
    <link rel="icon" href="/learning-media/favicon.svg" type="image/svg+xml">
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
      <!-- Run the five reviews over everything below -->
    </main>
    <footer><p>&copy; 2026 Your site</p></footer>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Our routes — Riverside Cycle Hire</title>
    <meta name="description" content="Three waymarked routes starting from our Mill Lane workshop.">
    <link rel="canonical" href="https://riverside-cycles.example/routes.html">
    <link rel="icon" href="/learning-media/favicon.svg" type="image/svg+xml">
    <meta property="og:title" content="Our routes — Riverside Cycle Hire">
    <meta property="og:description" content="Three waymarked routes from our Mill Lane workshop.">
    <meta property="og:image" content="https://riverside-cycles.example/images/share-1200.jpg">
    <meta property="og:image:alt" content="A sandy path winding between tall trees">
    <meta property="og:url" content="https://riverside-cycles.example/routes.html">
    <meta property="og:type" content="website">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="routes.html" aria-current="page">Routes</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Our routes</h1>
      <h2>Easy routes</h2>
      <figure>
        <img src="/learning-media/images/forest-path-1200.jpg"
             alt="A sandy path winding between tall trees in a sunlit forest"
             loading="lazy" width="1200" height="800">
        <figcaption>The wooded section of the valley route.</figcaption>
      </figure>
      <ul>
        <li>Harbour loop — 6 miles, flat</li>
        <li>Mill and back — 11 miles, one climb</li>
      </ul>
    </main>
    <footer><p>&copy; 2026 Riverside Cycle Hire</p></footer>
  </body>
</html>`,
              hints: [
                'Run validation first, then the keyboard test, then check the Network panel.',
                'Every page needs its own title, description and canonical.',
                'Mark the current page in the nav on every page.',
              ],
              requirements: [
                doctype(),
                { kind: 'attribute_present', selector: 'html', attribute: 'lang', message: 'The page declares its language' },
                unique('title', 'The page has its own title'),
                attr('meta[name="description"]', 'content', 'The page has its own description'),
                present('link[rel="canonical"]', 'A canonical URL is set'),
                present('link[rel="icon"]', 'A favicon is linked'),
                attrValue('a', 'href', '#main', 'The skip link matches the main landmark'),
                unique('main', 'There is exactly one main'),
                present('header', 'There is a header landmark'),
                present('footer', 'There is a footer landmark'),
                attr('nav', 'aria-label', 'The nav is labelled'),
                attrValue('a[aria-current]', 'aria-current', 'page', 'The current page is marked'),
                unique('h1', 'There is exactly one h1'),
                headingOrder(),
                goodAlt('img', 'Images have meaningful alt text'),
                mediaResolves('img, source, video, track'),
                uniqueIds(),
                legalNesting(),
                noObsolete(),
                notEmpty('main p, main li', 'The page has real content'),
              ],
              difficulty: 5,
              xp: 250,
              skill: 'multi-page',
            },
          ],
          quiz: [
            {
              slug: 'q-review-order',
              prompt: 'Why validate before running an accessibility check?',
              explanation:
                'An accessibility tool reads the repaired DOM. If the markup is invalid the browser has guessed at the structure, so the results describe a document you did not write.',
              options: [
                { label: 'Invalid markup means the tool is checking a document the browser guessed at', correct: true },
                { label: 'Accessibility tools refuse to run on invalid HTML' },
                { label: 'Validation fixes accessibility automatically' },
                { label: 'There is no reason — the order does not matter' },
              ],
              skill: 'validation',
            },
            {
              slug: 'q-publishing',
              prompt: 'What build step does a static HTML site need before publishing?',
              explanation: 'None. HTML runs as-is; the files you upload are the files you wrote.',
              options: [
                { label: 'None — the files run as they are', correct: true },
                { label: 'Compilation to a binary format' },
                { label: 'Minification, which is mandatory' },
                { label: 'Conversion to a server-side language' },
              ],
              skill: 'multi-page',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'html-hero-final',
    kind: 'final',
    title: 'HTML Hero final assessment',
    description:
      'Twelve questions drawn from the whole course. Pass mark 80%. Passing this, plus your completed capstone, earns your certificate.',
    passScore: 0.8,
    xp: 500,
    questions: [
      {
        slug: 'final-q1',
        prompt: 'Which must be the first line of an HTML file?',
        explanation: 'The doctype, which switches the browser into standards mode.',
        options: [
          { label: '<!DOCTYPE html>', correct: true },
          { label: '<html lang="en">' },
          { label: '<meta charset="utf-8">' },
          { label: '<?xml version="1.0"?>' },
        ],
        skill: 'document-structure',
      },
      {
        slug: 'final-q2',
        prompt: 'How many `<h1>` and `<main>` elements should a page have?',
        explanation:
          'Exactly one of each. The h1 names what the page is about, and main holds the content unique to that page — several of either leaves both readers and software with no clear answer.',
        options: [
          { label: 'One h1 and one main', correct: true },
          { label: 'One h1 and several main elements' },
          { label: 'Several h1 elements and one main' },
          { label: 'As many as the design needs' },
        ],
        skill: 'semantic-html',
      },
      {
        slug: 'final-q3',
        prompt: 'A decorative image needs which alt value?',
        explanation: '`alt=""` — the attribute present, its value empty.',
        options: [
          { label: 'alt=""', correct: true },
          { label: 'No alt attribute at all' },
          { label: 'alt="decorative"' },
          { label: 'alt=" "' },
        ],
        skill: 'images',
      },
      {
        slug: 'final-q4',
        prompt: 'What connects a `<label>` to its input?',
        explanation: 'The label\'s `for` value matching the input\'s `id`.',
        options: [
          { label: 'for matching id', correct: true },
          { label: 'for matching name' },
          { label: 'A shared class' },
          { label: 'Physical adjacency' },
        ],
        skill: 'forms',
      },
      {
        slug: 'final-q5',
        prompt: 'What does `srcset` with `w` descriptors let the browser do?',
        explanation:
          'Choose the smallest file that will still look sharp, given the layout and the device.',
        options: [
          { label: 'Choose the smallest adequate file for the device and layout', correct: true },
          { label: 'Load all the images and pick one' },
          { label: 'Resize a single image on the fly' },
          { label: 'Convert between image formats' },
        ],
        skill: 'responsive-images',
      },
      {
        slug: 'final-q6',
        prompt: 'What must every `<iframe>` have for accessibility?',
        explanation: 'A `title` attribute, otherwise screen readers announce only "frame".',
        options: [
          { label: 'A title attribute', correct: true },
          { label: 'An alt attribute' },
          { label: 'A role attribute' },
          { label: 'An aria-hidden attribute' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'final-q7',
        prompt: 'What is the first rule of ARIA?',
        explanation: 'Do not use ARIA if a native HTML element will do the job.',
        options: [
          { label: 'Do not use it if a native element will do', correct: true },
          { label: 'Add a role to every element' },
          { label: 'Always pair a role with tabindex' },
          { label: 'Use aria-label on every landmark' },
        ],
        skill: 'aria',
      },
      {
        slug: 'final-q8',
        prompt: 'Which script attribute is the right default?',
        explanation: '`defer` — downloads in parallel, runs after parsing, in source order.',
        options: [
          { label: 'defer', correct: true },
          { label: 'async' },
          { label: 'Neither' },
          { label: 'nomodule' },
        ],
        skill: 'performance',
      },
      {
        slug: 'final-q9',
        prompt: 'Can HTML validation attributes secure a form?',
        explanation:
          'No. They are trivially removed, and a request can be made without loading your page at all.',
        options: [
          { label: 'No — the server must revalidate every value', correct: true },
          { label: 'Yes, when combined with pattern' },
          { label: 'Yes, over HTTPS' },
          { label: 'Yes, if the form uses POST' },
        ],
        skill: 'security',
      },
      {
        slug: 'final-q10',
        prompt: 'What does `scope="row"` on a `<th>` do?',
        explanation:
          'It tells assistive technology that this heading describes the row beside it, so a cell announces with its row and column headings.',
        options: [
          { label: 'Marks the heading as describing its row', correct: true },
          { label: 'Merges the cell across the row' },
          { label: 'Makes the row sortable' },
          { label: 'Repeats the row when printing' },
        ],
        skill: 'tables',
      },
      {
        slug: 'final-q11',
        prompt: 'Which is true of structured data?',
        explanation:
          'It can change how a result is displayed, but it is not a ranking factor, and it must describe content genuinely on the page.',
        options: [
          { label: 'It changes how a result is displayed, not where it ranks', correct: true },
          { label: 'It guarantees a first-page position' },
          { label: 'It replaces the meta description' },
          { label: 'It may describe content not on the page' },
        ],
        skill: 'structured-data',
      },
      {
        slug: 'final-q12',
        prompt: 'What should you do first when a validator reports twenty errors?',
        explanation:
          'Fix the first error and re-run. A single unclosed element commonly produces most of the rest.',
        options: [
          { label: 'Fix the first one and re-validate', correct: true },
          { label: 'Fix them all before re-checking' },
          { label: 'Start from the last error' },
          { label: 'Ignore them if the page renders' },
        ],
        skill: 'validation',
      },
    ],
  },
};
