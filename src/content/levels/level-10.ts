import {
  annotated,
  attr,
  attrMatches,
  attrValue,
  callout,
  checklist,
  code,
  compare,
  detail,
  goodAlt,
  mediaResolves,
  objectives,
  present,
  prose,
  recap,
  term,
  type LevelSpec,
} from '../types';

export const LEVEL_10: LevelSpec = {
  slug: 'performance-and-security',
  title: 'HTML Performance and Security',
  subtitle: 'The markup decisions that make pages fast and safe',
  summary:
    'HTML cannot secure an application and cannot make a slow server fast. What it can do is avoid a surprising number of self-inflicted wounds — and this level is about those.',
  outcome: 'You can take a slow, unsafe, bloated page and measurably improve all three.',
  accent: 'slate',
  modules: [
    {
      slug: 'html-performance',
      title: 'Performance-aware HTML',
      summary:
        'Dimensions, loading strategy, script loading, resource hints — and the honest limits of what markup controls.',
      estimatedMinutes: 45,
      prerequisites: ['page-metadata'],
      skills: [{ slug: 'performance', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'loading-strategy',
          title: 'Loading strategy',
          subtitle: 'Layout shift, lazy loading, preload and the critical path',
          summary:
            'A handful of attributes decide whether a page feels instant or feels broken while it settles.',
          objectives: [
            'Prevent layout shift with dimensions',
            'Choose loading and fetchpriority correctly',
            'Use resource hints without overusing them',
          ],
          estimatedMinutes: 15,
          skill: 'performance',
          blocks: [
            objectives([
              'Explain and prevent cumulative layout shift',
              'Choose the right loading strategy for each asset',
              'Use preload, preconnect and dns-prefetch appropriately',
            ]),
            term(
              'Layout shift',
              'Content jumping around as the page loads, because the browser did not know how much space something would need until it arrived. It is measured as Cumulative Layout Shift, and it is one of the three Core Web Vitals.',
            ),
            compare(
              'The same image, with and without dimensions',
              {
                label: 'Space reserved',
                code: '<img src="/learning-media/images/city-dusk-1200.jpg"\n     alt="A city skyline at dusk"\n     width="1200" height="800">',
                why: 'The browser reserves a 3:2 box immediately. Nothing below it moves when the file arrives.',
              },
              {
                label: 'No dimensions',
                code: '<img src="/learning-media/images/city-dusk-1200.jpg"\n     alt="A city skyline at dusk">',
                why: 'The image occupies zero height until it loads, then suddenly pushes everything below it down the page — often just as someone is about to tap a link.',
              },
            ),
            callout(
              'tip',
              'Dimensions do not fix the size, they fix the ratio',
              'A common worry is that `width` and `height` will stop an image being responsive. They will not: CSS still controls the displayed size, and modern browsers use the two attributes purely to compute an aspect ratio. Set them on every image, every video and every iframe.',
            ),
            code(
              `loading="lazy"          Do not download until near the viewport.
                        Use below the fold. Never on the hero image.

fetchpriority="high"    This is the most important asset on the page.
                        Use on exactly one thing, usually the hero image.

fetchpriority="low"     Deprioritise something incidental.

decoding="async"        Decode the image off the main thread. Safe default
                        for images that are not the hero.

preload="metadata"      For video and audio: fetch just the duration.
preload="none"          Fetch nothing until the user presses play.
preload="auto"          Fetch the whole file. Almost never justified.`,
              'The loading attributes',
              'text',
            ),
            prose(
              'Scripts are the other half of loading strategy. Even though this course does not teach JavaScript, you need to know how a script tag affects your page, because writing it wrongly blocks rendering entirely.',
            ),
            annotated(
              `<script src="analytics.js" defer></script>
<script src="widget.js" async></script>
<script src="critical.js"></script>`,
              [
                {
                  line: '1',
                  text: '`defer` downloads in parallel with parsing, then runs after the document is parsed, in source order. This is the right default for almost every script.',
                },
                {
                  line: '2',
                  text: '`async` downloads in parallel and runs the moment it arrives, interrupting parsing. Order is unpredictable. Only suitable for genuinely independent scripts.',
                },
                {
                  line: '3',
                  text: 'With neither attribute, parsing *stops* while the script downloads and runs. A slow script here freezes the page. This is the single most damaging thing you can put in a `<head>`.',
                },
              ],
            ),
            term(
              'Resource hint',
              'A `<link>` telling the browser to prepare for something before it is needed.',
            ),
            code(
              `<link rel="preconnect" href="https://fonts.example.com">
      Open the connection early. Use for one or two critical third-party origins.

<link rel="dns-prefetch" href="https://analytics.example.com">
      Cheaper than preconnect — resolves the domain name only.

<link rel="preload" href="/fonts/body.woff2" as="font" type="font/woff2" crossorigin>
      Fetch this now, at high priority. Powerful and easy to misuse.

<link rel="prefetch" href="/prices.html">
      Fetch during idle time, for a page the user will probably visit next.`,
              'Resource hints',
              'text',
            ),
            callout(
              'warning',
              'Preloading everything preloads nothing',
              'A resource hint works by changing priority relative to everything else. Preload five things and you have simply restated the original order while consuming bandwidth earlier. Preload is for one or two genuinely critical assets the browser would otherwise discover late — typically a font, or a hero image referenced from CSS.',
            ),
            detail(
              'What HTML cannot do for performance',
              'Markup cannot compress your images, cannot speed up a slow database query, cannot add caching headers, and cannot fix a 2MB JavaScript bundle. The biggest performance wins are usually elsewhere: image formats and sizes, server response time, caching, and how much JavaScript you ship. What HTML gives you is the difference between a page that renders progressively and pleasantly and one that blocks, jumps and reflows — which is what users actually perceive as "fast".',
            ),
            recap(
              [
                'Set `width` and `height` on every image, video and iframe — it fixes the ratio, not the size.',
                '`loading="lazy"` below the fold; `fetchpriority="high"` on one hero asset.',
                '`defer` is the right default for scripts; a bare `<script>` in the head blocks rendering.',
                'Resource hints are for one or two genuinely critical assets.',
              ],
              'Next: the security decisions HTML actually controls.',
            ),
          ],
          exercises: [
            {
              slug: 'perf-guided',
              kind: 'guided',
              title: 'Fix a page that jumps as it loads',
              brief:
                'Add dimensions to all three images, lazy-load the two below the fold, mark the hero as high priority, and change the render-blocking script to use `defer`.',
              starterCode: `<script src="analytics.js"></script>

<img src="/learning-media/images/coast-sunrise-1200.jpg" alt="Sunrise over a calm sea">
<p>Twenty-four miles, mostly flat.</p>
<img src="/learning-media/images/forest-path-1200.jpg" alt="A sandy path between tall trees">
<img src="/learning-media/images/city-dusk-1200.jpg" alt="A city skyline at dusk">`,
              referenceSolution: `<script src="analytics.js" defer></script>

<img src="/learning-media/images/coast-sunrise-1200.jpg"
     alt="Sunrise over a calm sea"
     fetchpriority="high" width="1200" height="800">
<p>Twenty-four miles, mostly flat.</p>
<img src="/learning-media/images/forest-path-1200.jpg"
     alt="A sandy path between tall trees"
     loading="lazy" width="1200" height="800">
<img src="/learning-media/images/city-dusk-1200.jpg"
     alt="A city skyline at dusk"
     loading="lazy" width="1200" height="800">`,
              hints: [
                'Every image needs width="1200" and height="800".',
                'The first image is the hero — fetchpriority="high" and no lazy loading.',
                'The other two get loading="lazy".',
                'Add defer to the script so it stops blocking the parser.',
              ],
              requirements: [
                attr('img', 'width', 'Every image declares its width'),
                attr('img', 'height', 'Every image declares its height'),
                { kind: 'element_count', selector: 'img[loading="lazy"]', minCount: 2, maxCount: 2, message: 'The two below-the-fold images are lazy-loaded' },
                attrValue('img', 'fetchpriority', 'high', 'The hero image is marked high priority'),
                { kind: 'element_count', selector: 'img[fetchpriority="high"][loading="lazy"]', minCount: 0, maxCount: 0, message: 'The hero image is not lazy-loaded' },
                attr('script', 'defer', 'The script no longer blocks rendering'),
                mediaResolves('img'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'performance',
            },
          ],
          quiz: [
            {
              slug: 'q-layout-shift',
              prompt: 'What causes layout shift when images load?',
              explanation:
                'Without dimensions the browser cannot reserve space, so content below jumps when the image arrives.',
              options: [
                { label: 'The browser cannot reserve space without dimensions', correct: true },
                { label: 'Images always load after text' },
                { label: 'Lazy loading delays them' },
                { label: 'The alt text is rendered first' },
              ],
              skill: 'performance',
            },
            {
              slug: 'q-defer-async',
              prompt: 'What is the difference between `defer` and `async`?',
              explanation:
                '`defer` runs after parsing, in source order. `async` runs as soon as it downloads, in unpredictable order.',
              options: [
                { label: 'defer runs after parsing in order; async runs on arrival, out of order', correct: true },
                { label: 'They are identical' },
                { label: 'defer downloads first, async downloads last' },
                { label: 'async is for modules; defer is for classic scripts' },
              ],
              skill: 'performance',
            },
            {
              slug: 'q-preload-overuse',
              prompt: 'What happens if you preload ten resources?',
              explanation:
                'Preload works by changing relative priority. Preloading everything restates the original order while pulling bandwidth forward.',
              options: [
                { label: 'Nothing is genuinely prioritised, and bandwidth is consumed earlier', correct: true },
                { label: 'The page loads ten times faster' },
                { label: 'The browser ignores all of them' },
                { label: 'It causes a validation error' },
              ],
              skill: 'performance',
            },
          ],
        },
        {
          slug: 'html-security',
          title: 'Security decisions in markup',
          subtitle: 'What HTML controls, and the much larger part it does not',
          summary:
            'External links, iframe sandboxing, referrer policy and CSP — plus a clear statement of HTML\'s limits.',
          objectives: [
            'Open external links safely',
            'Sandbox embedded content and set a referrer policy',
            'Explain why HTML alone secures nothing',
          ],
          estimatedMinutes: 15,
          skill: 'security',
          blocks: [
            objectives([
              'Apply rel="noopener noreferrer" correctly',
              'Choose sandbox tokens and a referrer policy',
              'Explain the boundary between markup and real security',
            ]),
            code(
              `<a href="https://example.org/report"
   target="_blank"
   rel="noopener noreferrer">
  The 2026 report (opens in a new tab)
</a>`,
              'A safe external link',
            ),
            code(
              `rel="noopener"    The new page gets no reference back to yours.
rel="noreferrer"  Your page's address is not sent to the destination.
                  Implies noopener.
rel="nofollow"    Tells search engines not to pass ranking credit.
                  Use on user-submitted links.
rel="ugc"         Marks a link as user-generated content.
rel="sponsored"   Marks a paid or affiliate link.`,
              'The rel values worth knowing',
              'text',
            ),
            term(
              'Referrer policy',
              'Controls how much of your page\'s address is sent when a visitor follows a link or your page loads a resource. Set per-link with `referrerpolicy`, or page-wide with a meta tag.',
            ),
            code(
              `<meta name="referrer" content="strict-origin-when-cross-origin">`,
              'A sensible page-wide default — and the modern browser default too',
            ),
            callout(
              'tip',
              'Why referrer policy matters in practice',
              'If a URL contains a password-reset token, an order number or a customer identifier, the full address is sent to every third party your page links to or loads a resource from. `strict-origin-when-cross-origin` sends the full path to your own origin and only the bare origin to others — which is almost always the behaviour you want.',
            ),
            prose('Iframes deserve particular care, because an embed runs someone else\'s code inside your page.'),
            annotated(
              `<iframe
  src="https://example.org/booking-widget"
  title="Booking widget"
  sandbox="allow-scripts allow-forms"
  referrerpolicy="no-referrer"
  loading="lazy"
  width="600" height="480"></iframe>`,
              [
                { line: '4', text: 'Start from nothing and add back only what the embed genuinely needs.' },
                {
                  line: '4',
                  text: 'Note what is *not* granted: no `allow-top-navigation`, so the embed cannot redirect your whole page; no `allow-popups`; no `allow-same-origin`.',
                },
                { line: '5', text: '`no-referrer` sends the third party nothing about where the visitor came from.' },
              ],
            ),
            term(
              'Content Security Policy',
              'A rule set telling the browser which sources of script, style, image and frame content are allowed. It is the strongest defence against cross-site scripting available to a web page.',
            ),
            code(
              `<meta http-equiv="Content-Security-Policy"
      content="default-src 'self'; img-src 'self' data:; script-src 'self'">`,
              'A very restrictive CSP, declared in HTML',
            ),
            callout(
              'warning',
              'A CSP meta tag is the weaker option',
              'CSP is properly delivered as an HTTP response header, set by the server. The meta-tag form exists, but it cannot use some directives, it arrives later than a header, and anything before it in the document is unprotected. Use the meta tag only when you cannot control the server.',
            ),
            callout(
              'warning',
              'The honest boundary',
              'HTML cannot authenticate a user, cannot authorise an action, cannot validate input in any way that survives an attacker, cannot encrypt anything, and cannot keep a secret. Every `required`, `pattern`, `maxlength` and `type="email"` on your page is a convenience for honest users and is trivially bypassed. Real security lives on the server: validate every input, authenticate every request, authorise every action, and never trust anything that arrives from a browser. What HTML *can* do is avoid handing an attacker an easy opening — which is exactly what this lesson is about.',
            ),
            checklist('The markup-level security checklist', [
              '`rel="noopener noreferrer"` on every `target="_blank"`',
              '`sandbox` on every iframe, granting the minimum',
              '`title` on every iframe',
              'A referrer policy set page-wide',
              '`rel="nofollow ugc"` on user-submitted links',
              'No secrets in hidden inputs, comments or data attributes',
              'Forms served and submitted over HTTPS',
            ]),
            detail(
              'What about `integrity`?',
              'Subresource Integrity lets you pin the exact contents of a third-party file: `<script src="https://cdn.example/lib.js" integrity="sha384-…" crossorigin="anonymous"></script>`. If the file changes by so much as a byte, the browser refuses to run it. It is genuinely useful when loading code from a CDN you do not control. It is also a good illustration of HTML\'s role in security: it does not make the code safe, it just guarantees you got the code you agreed to.',
            ),
            recap(
              [
                '`rel="noopener noreferrer"` on every external link opened in a new tab.',
                'Sandbox every iframe, granting the minimum it needs.',
                'Set a referrer policy so URLs do not leak to third parties.',
                'HTML avoids self-inflicted wounds; it does not provide security.',
              ],
              'Next: the Level 10 milestone.',
            ),
          ],
          exercises: [
            {
              slug: 'security-debug',
              kind: 'debug',
              title: 'Four unsafe patterns',
              brief:
                'Fix each problem: the external link has no `rel`, the iframe has no sandbox or title, the referrer policy is missing, and a secret has been left in a hidden input.',
              starterCode: `<head>
  <meta charset="utf-8">
</head>
<body>
  <a href="https://example.org/report" target="_blank">The 2026 report</a>

  <iframe src="https://example.org/widget" width="600" height="400"></iframe>

  <form action="/booking" method="post">
    <input type="hidden" name="api_key" value="sk_live_51H8xQ2eZvKYlo2C">
    <button type="submit">Book</button>
  </form>
</body>`,
              referenceSolution: `<head>
  <meta charset="utf-8">
  <meta name="referrer" content="strict-origin-when-cross-origin">
</head>
<body>
  <a href="https://example.org/report" target="_blank" rel="noopener noreferrer">
    The 2026 report (opens in a new tab)
  </a>

  <iframe src="https://example.org/widget"
          title="Booking widget"
          sandbox="allow-scripts allow-forms"
          referrerpolicy="no-referrer"
          loading="lazy"
          width="600" height="400"></iframe>

  <form action="/booking" method="post">
    <button type="submit">Book</button>
  </form>
</body>`,
              hints: [
                'Add rel="noopener noreferrer" to the external link, and warn about the new tab in the text.',
                'The iframe needs a title and a sandbox granting only what it needs.',
                'Add <meta name="referrer" content="strict-origin-when-cross-origin"> to the head.',
                'Delete the hidden input entirely — an API key must never appear in a page.',
              ],
              requirements: [
                attrMatches('a[target="_blank"]', 'rel', 'noopener', 'External links opened in a new tab use rel="noopener"'),
                attr('iframe', 'title', 'The iframe has a title'),
                attr('iframe', 'sandbox', 'The iframe is sandboxed'),
                present('meta[name="referrer"]', 'A referrer policy is set'),
                { kind: 'element_count', selector: 'input[type="hidden"]', minCount: 0, maxCount: 0, message: 'No secret is left in a hidden input', hint: 'A hidden input is visible to anyone who views the page source.' },
              ],
              difficulty: 4,
              xp: 65,
              skill: 'security',
            },
          ],
          quiz: [
            {
              slug: 'q-noopener-why',
              prompt: 'What can a page opened with `target="_blank"` do without `noopener`?',
              explanation:
                'It gets a reference back to the opening window and, in older browsers, can navigate it elsewhere — a phishing technique.',
              options: [
                { label: 'Navigate your original tab to another address', correct: true },
                { label: 'Read your cookies' },
                { label: 'Submit your forms' },
                { label: 'Nothing — the attribute is purely decorative' },
              ],
              skill: 'security',
            },
            {
              slug: 'q-hidden-input',
              prompt: 'Why must an API key never go in `<input type="hidden">`?',
              explanation: 'Its value is in the page source, visible to every visitor.',
              options: [
                { label: 'The value is visible in the page source', correct: true },
                { label: 'Hidden inputs are not submitted' },
                { label: 'It fails validation' },
                { label: 'Browsers strip hidden values' },
              ],
              skill: 'security',
            },
            {
              slug: 'q-csp-header',
              prompt: 'Where is a Content Security Policy best delivered?',
              explanation:
                'As an HTTP response header from the server. The meta-tag form is a weaker fallback.',
              options: [
                { label: 'As an HTTP response header', correct: true },
                { label: 'As a meta tag, always' },
                { label: 'In a rel attribute on links' },
                { label: 'In a sandbox attribute' },
              ],
              skill: 'security',
            },
          ],
        },
        {
          slug: 'performance-milestone',
          title: 'Milestone: repair a slow, unsafe page',
          subtitle: 'Every problem from this level, on one page',
          summary: 'The page in this milestone is slow, jumps as it loads, and hands data to third parties.',
          objectives: [
            'Diagnose performance and security problems from markup alone',
            'Apply the correct fix for each',
            'Improve your own capstone site the same way',
          ],
          estimatedMinutes: 25,
          skill: 'performance',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Repair layout shift, render blocking and unsafe embeds together',
              'Justify each change you make',
              'Apply the same review to your own project',
            ]),
            prose(
              'Every fault in the exercise below is one you have already met. What is new is meeting them together, on a page that looks fine until you measure it.',
            ),
            compare(
              'The two changes that matter most',
              {
                label: 'Fast',
                code: `<script src="analytics.js" defer></script>
<img src="hero-1200.jpg" alt="…"
     fetchpriority="high" width="1200" height="800">
<img src="below.jpg" alt="…"
     loading="lazy" width="1200" height="800">`,
                why: 'Nothing blocks the parser, the hero arrives first, and no content jumps as images load.',
              },
              {
                label: 'Slow',
                code: `<script src="analytics.js"></script>
<img src="hero-1200.jpg" alt="…" loading="lazy">
<img src="below.jpg" alt="…">`,
                why: 'The script freezes rendering, the hero is deprioritised, and both images shift the page when they arrive.',
              },
            ),
            callout(
              'note',
              'Measure, do not guess',
              'Open the Network panel and reload with the cache disabled. What arrives first? What blocks? A five-second look answers questions that are otherwise pure speculation.',
            ),
            checklist('Review any page against these', [
              'Every image, video and iframe has `width` and `height`',
              'Below-the-fold images and iframes are lazy-loaded',
              'The hero image is not lazy-loaded, and is `fetchpriority="high"`',
              'Scripts use `defer` unless there is a specific reason not to',
              'Video uses `preload="metadata"` or `none`, never `auto`',
              'External links opened in a new tab carry `rel="noopener noreferrer"`',
              'Every iframe has a `title` and a `sandbox`',
              'A referrer policy is set',
              'No secrets anywhere in the markup',
            ]),
            recap(
              [
                'Most HTML performance work is about not making things worse.',
                'Most HTML security work is about not handing over an opening.',
                'Both take minutes and both are checkable from the markup alone.',
              ],
              'Level 11 next: validation and debugging.',
            ),
          ],
          exercises: [
            {
              slug: 'performance-milestone-build',
              kind: 'challenge',
              title: 'Milestone: repair the page',
              brief:
                'This page has around ten performance and security problems. Fix them all. Keep the content identical.',
              starterCode: `<head>
  <meta charset="utf-8">
  <script src="analytics.js"></script>
  <link rel="preload" href="/a.js" as="script">
  <link rel="preload" href="/b.js" as="script">
  <link rel="preload" href="/c.js" as="script">
</head>
<body>
  <h1>The valley route</h1>

  <img src="/learning-media/images/coast-sunrise-1200.jpg" alt="Sunrise over a calm sea" loading="lazy">

  <p>Twenty-four miles, mostly flat.</p>

  <img src="/learning-media/images/forest-path-1200.jpg" alt="A sandy path between tall trees">

  <video src="/learning-media/video/page-anatomy.mp4" preload="auto" autoplay></video>

  <iframe src="https://example.org/map" width="600" height="400"></iframe>

  <p><a href="https://example.org/report" target="_blank">The 2026 report</a></p>
</body>`,
              referenceSolution: `<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="referrer" content="strict-origin-when-cross-origin">
  <script src="analytics.js" defer></script>
</head>
<body>
  <h1>The valley route</h1>

  <img src="/learning-media/images/coast-sunrise-1200.jpg"
       alt="Sunrise over a calm sea"
       fetchpriority="high" width="1200" height="800">

  <p>Twenty-four miles, mostly flat.</p>

  <img src="/learning-media/images/forest-path-1200.jpg"
       alt="A sandy path between tall trees"
       loading="lazy" width="1200" height="800">

  <video controls preload="metadata"
         poster="/learning-media/posters/page-anatomy.jpg"
         width="1280" height="720">
    <source src="/learning-media/video/page-anatomy.webm" type="video/webm">
    <source src="/learning-media/video/page-anatomy.mp4" type="video/mp4">
    <track kind="captions" src="/learning-media/captions/page-anatomy.en.vtt"
           srclang="en" label="English" default>
    <p><a href="/learning-media/video/page-anatomy.mp4">Download the MP4</a></p>
  </video>

  <iframe src="https://example.org/map"
          title="Map showing the workshop on Mill Lane"
          sandbox="allow-scripts"
          referrerpolicy="no-referrer"
          loading="lazy"
          width="600" height="400"></iframe>

  <p>
    <a href="https://example.org/report" target="_blank" rel="noopener noreferrer">
      The 2026 report (opens in a new tab)
    </a>
  </p>
</body>`,
              hints: [
                'The script blocks rendering — add defer. The three preloads are pointless; delete them.',
                'The hero image is lazy-loaded, which is backwards. Swap it for fetchpriority="high" and give every image dimensions.',
                'The video autoplays with preload="auto" and no controls. Fix all three, add a poster and captions.',
                'The iframe needs a title, a sandbox and lazy loading. The external link needs rel="noopener noreferrer".',
                'Add a referrer policy and a viewport meta tag to the head.',
              ],
              requirements: [
                attr('script', 'defer', 'The script no longer blocks rendering'),
                { kind: 'element_count', selector: 'link[rel="preload"]', minCount: 0, maxCount: 1, message: 'The unnecessary preloads are removed' },
                attr('img', 'width', 'Every image declares its width'),
                attr('img', 'height', 'Every image declares its height'),
                { kind: 'element_count', selector: 'img[fetchpriority="high"][loading="lazy"]', minCount: 0, maxCount: 0, message: 'The hero image is not lazy-loaded' },
                { kind: 'element_count', selector: 'img[loading="lazy"]', minCount: 1, message: 'Below-the-fold images are lazy-loaded' },
                { kind: 'attribute_absent', selector: 'video', attribute: 'autoplay', message: 'The video no longer autoplays' },
                attr('video', 'controls', 'The video has controls'),
                { kind: 'element_count', selector: 'video[preload="auto"]', minCount: 0, maxCount: 0, message: 'The video no longer preloads its whole file' },
                present('track[kind="captions"]', 'The video has captions'),
                attr('iframe', 'title', 'The iframe has a title'),
                attr('iframe', 'sandbox', 'The iframe is sandboxed'),
                attrValue('iframe', 'loading', 'lazy', 'The iframe is lazy-loaded'),
                attrMatches('a[target="_blank"]', 'rel', 'noopener', 'The external link is opened safely'),
                present('meta[name="referrer"]', 'A referrer policy is set'),
                present('meta[name="viewport"]', 'A viewport meta tag is present'),
                mediaResolves('img, source, track, video'),
                goodAlt('img'),
              ],
              difficulty: 5,
              xp: 170,
              skill: 'performance',
            },
            {
              slug: 'performance-mission',
              kind: 'project_mission',
              title: 'Capstone mission: performance and security review',
              brief:
                'Review every page of your capstone site against the checklist. Add dimensions everywhere, lazy-load what should be lazy, add a referrer policy, and make every external link safe.',
              starterCode: `<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Add a referrer policy -->
</head>
<body>
  <!-- Check: dimensions on every image? -->
  <!-- Check: lazy loading below the fold, but not the hero? -->
  <!-- Check: rel="noopener noreferrer" on external links? -->
</body>`,
              referenceSolution: `<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="referrer" content="strict-origin-when-cross-origin">
</head>
<body>
  <img src="/learning-media/images/coast-sunrise-1200.jpg"
       alt="Sunrise over the estuary"
       fetchpriority="high" width="1200" height="800">

  <img src="/learning-media/images/workshop-tools-1200.jpg"
       alt="Hand tools hanging above a workbench"
       loading="lazy" width="1200" height="800">

  <p>
    <a href="https://example.org/cycling-map" target="_blank" rel="noopener noreferrer">
      The national cycle map (opens in a new tab)
    </a>
  </p>
</body>`,
              hints: [
                'Every image needs both width and height.',
                'Only the first visible image should have fetchpriority="high".',
                'Any link with target="_blank" needs rel="noopener noreferrer".',
              ],
              requirements: [
                present('meta[name="referrer"]', 'A referrer policy is set'),
                attr('img', 'width', 'Images declare their width'),
                attr('img', 'height', 'Images declare their height'),
                { kind: 'element_count', selector: 'img[loading="lazy"]', minCount: 1, message: 'At least one image is lazy-loaded' },
                { kind: 'element_count', selector: 'a[target="_blank"]:not([rel])', minCount: 0, maxCount: 0, message: 'Every new-tab link has a rel attribute' },
                mediaResolves('img'),
              ],
              difficulty: 4,
              xp: 100,
              skill: 'performance',
            },
          ],
          quiz: [
            {
              slug: 'q-preload-auto',
              prompt: 'Why is `preload="auto"` on a video usually wrong?',
              explanation:
                'It downloads the whole file before anyone presses play — potentially megabytes of a visitor\'s mobile data for a video they never watch.',
              options: [
                { label: 'It downloads the whole file whether or not anyone watches', correct: true },
                { label: 'It disables the controls' },
                { label: 'It prevents captions loading' },
                { label: 'It is invalid HTML' },
              ],
              skill: 'performance',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'level-10-milestone',
    kind: 'milestone',
    title: 'Level 10 milestone: Performance and Security',
    description: 'Eight questions on loading strategy and markup-level security. Pass mark 75%.',
    passScore: 0.75,
    xp: 190,
    questions: [
      {
        slug: 'a10-q1',
        prompt: 'What do `width` and `height` on an `<img>` prevent?',
        explanation: 'Layout shift — content jumping as the image arrives.',
        options: [
          { label: 'Layout shift as the image loads', correct: true },
          { label: 'The image being resized by CSS' },
          { label: 'The image being lazy-loaded' },
          { label: 'The image being cached' },
        ],
        skill: 'performance',
      },
      {
        slug: 'a10-q2',
        prompt: 'Which script attribute is the right default?',
        explanation: '`defer`: downloads in parallel, runs after parsing, in source order.',
        options: [
          { label: 'defer', correct: true },
          { label: 'async' },
          { label: 'Neither — a bare script tag' },
          { label: 'type="module" only' },
        ],
        skill: 'performance',
      },
      {
        slug: 'a10-q3',
        prompt: 'What does `sandbox` with no value do to an iframe?',
        explanation: 'It removes essentially every capability; each `allow-` token restores one.',
        options: [
          { label: 'Removes nearly all capabilities', correct: true },
          { label: 'Grants all capabilities' },
          { label: 'Blocks the iframe from loading' },
          { label: 'Has no effect' },
        ],
        skill: 'security',
      },
      {
        slug: 'a10-q4',
        prompt: 'Which referrer policy is a sensible default?',
        explanation:
          '`strict-origin-when-cross-origin` sends the full path to your own origin and only the bare origin to others.',
        options: [
          { label: 'strict-origin-when-cross-origin', correct: true },
          { label: 'unsafe-url' },
          { label: 'no-referrer, always' },
          { label: 'origin-when-downgrade' },
        ],
        skill: 'security',
      },
      {
        slug: 'a10-q5',
        prompt: 'Can HTML validation attributes secure a form?',
        explanation:
          'No. They are removable in two clicks, and a request can be sent without loading your page at all.',
        options: [
          { label: 'No — the server must revalidate everything', correct: true },
          { label: 'Yes, if you also use pattern' },
          { label: 'Yes, over HTTPS' },
          { label: 'Yes, when the form uses POST' },
        ],
        skill: 'security',
      },
      {
        slug: 'a10-q6',
        prompt: 'When should you use `fetchpriority="high"`?',
        explanation: 'On the single most important asset, usually the hero image.',
        options: [
          { label: 'On one asset — usually the hero image', correct: true },
          { label: 'On every image on the page' },
          { label: 'On all third-party scripts' },
          { label: 'On anything below the fold' },
        ],
        skill: 'performance',
      },
      {
        slug: 'a10-q7',
        prompt: 'What is Subresource Integrity for?',
        explanation:
          'It pins the exact contents of a third-party file, so the browser refuses to run it if it has changed.',
        options: [
          { label: 'Guaranteeing a third-party file has not been altered', correct: true },
          { label: 'Compressing external scripts' },
          { label: 'Blocking cross-origin requests' },
          { label: 'Validating HTML structure' },
        ],
        skill: 'security',
      },
      {
        slug: 'a10-q8',
        prompt: 'What is the biggest limitation of HTML for performance?',
        explanation:
          'It cannot compress images, speed up a server, set caching headers or shrink a JavaScript bundle — the largest wins are elsewhere.',
        options: [
          { label: 'It cannot fix image sizes, server speed, caching or JavaScript weight', correct: true },
          { label: 'It cannot set image dimensions' },
          { label: 'It cannot lazy-load anything' },
          { label: 'It cannot express loading priority' },
        ],
        skill: 'performance',
      },
    ],
  },
};
