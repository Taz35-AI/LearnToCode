import {
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
  doctype,
  headingOrder,
  legalNesting,
  notEmpty,
  objectives,
  predictCheck,
  present,
  pretest,
  prose,
  recap,
  term,
  unique,
  type LevelSpec,
  mediaExample,
  recall,
} from '../types';

export const LEVEL_09: LevelSpec = {
  slug: 'metadata-and-seo',
  title: 'Metadata, SEO and Discoverability',
  subtitle: 'Everything in the head, and what it can honestly do',
  summary:
    'The head of a document is invisible to visitors and enormously important to everything else — search engines, social networks, browsers and screen readers. This level covers what to put there and, just as importantly, what HTML can and cannot promise.',
  outcome:
    'You can optimise a multi-page site for search engines, social sharing and structured data.',
  accent: 'orange',
  modules: [
    {
      slug: 'page-metadata',
      title: 'Page metadata',
      summary:
        'Titles, descriptions, canonical URLs, favicons, language and robots directives.',
      estimatedMinutes: 45,
      // Level 8 now runs foundations → ARIA and forms, so this depends on the
      // later of the two: a learner should have met ARIA and accessible forms
      // before metadata, not merely the keyboard basics.
      prerequisites: ['aria-and-accessible-forms'],
      skills: [{ slug: 'metadata', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'titles-descriptions-canonicals',
          title: 'Titles, descriptions and canonical URLs',
          subtitle: 'The three things every page needs and most pages get wrong',
          summary:
            'Your title is the most-read sentence you will write. It appears in tabs, bookmarks, search results and shared links.',
          objectives: [
            'Write a page title that works in all four places it appears',
            'Write a meta description that earns a click',
            'Use a canonical URL to prevent duplicate-content problems',
          ],
          estimatedMinutes: 15,
          skill: 'metadata',
          blocks: [
            objectives([
              'Write unique, descriptive titles for every page',
              'Write meta descriptions of a useful length',
              'Explain when a canonical URL is needed',
            ]),
            annotated(
              `<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Bike hire prices — Riverside Cycle Hire</title>
  <meta name="description"
        content="Hourly, daily and weekly bike hire from £6. Helmet, lock and route map included with every hire. Book online or call in.">
  <link rel="canonical" href="https://riverside-cycles.example/prices.html">
  <link rel="icon" href="/favicon.svg" type="image/svg+xml">
  <meta name="theme-color" content="#1d4ed8">
</head>`,
              [
                {
                  line: '2',
                  text: '`charset` must be within the first 1024 bytes of the document, which in practice means first in the head. Browsers begin decoding before this point, so a late declaration means a restart.',
                },
                {
                  line: '4',
                  text: 'The title: specific page name, an em dash, then the site name. Around 50–60 characters is the sweet spot before search engines truncate it. Put the distinctive part first — "Bike hire prices" is more useful at the start of a browser tab than the site name.',
                },
                {
                  line: '5',
                  text: 'The description is not a ranking factor, but it is very often the text shown under your result. Around 150–160 characters, written as a promise of what the page contains.',
                },
                {
                  line: '7',
                  text: '`canonical` states the one true address for this page. If the same content is reachable at several URLs — with and without a trailing slash, with tracking parameters — this tells search engines which one to index.',
                },
                { line: '8', text: 'An SVG favicon scales to every size and works in dark mode.' },
                { line: '9', text: '`theme-color` tints the browser interface on mobile. Small touch, noticeably more polished.' },
              ],
            ),
            compare(
              'Titles that work and titles that do not',
              {
                label: 'Good',
                code: '<title>Bike hire prices — Riverside Cycle Hire</title>',
                why: 'Specific, unique to this page, distinctive part first, and readable in a narrow browser tab.',
              },
              {
                label: 'Poor',
                code: '<title>Riverside Cycle Hire | Bike Hire | Cycling | Hexford | Home</title>',
                why: 'Keyword stuffing. Truncated in results, useless in a tab, and identical across pages if the site does this everywhere.',
              },
            ),
            callout(
              'mistake',
              'The same title on every page',
              'The commonest metadata failure. If every page says "Riverside Cycle Hire", then a visitor with eight tabs open cannot tell them apart, bookmarks are meaningless, and search engines have nothing distinguishing to show. Every page needs its own title — and its own description.',
            ),
            term(
              'Robots meta',
              '`<meta name="robots" content="noindex">` asks search engines not to index a page. Useful for thank-you pages, staging sites and internal search results — and a serious accident if it ends up on a live homepage.',
            ),
            code(
              `<meta name="robots" content="index, follow">     the default; usually unnecessary
<meta name="robots" content="noindex, follow">   do not index this page
<meta name="robots" content="noindex, nofollow"> do not index, do not follow its links`,
              'Robots directives',
              'text',
            ),
            callout(
              'warning',
              'A robots meta tag is a request, not a control',
              'Well-behaved crawlers obey it. It is not access control, and it does not hide anything: the page is still public, and anyone with the URL can read it. If something must not be seen, it needs authentication, not a meta tag.',
            ),
            detail(
              'Language metadata beyond `lang`',
              '`<html lang="en">` declares the page language. Add `lang` on any element whose content is in a different language — `<span lang="fr">bon appétit</span>` — and a screen reader switches pronunciation for that phrase. For a site with several language versions, `<link rel="alternate" hreflang="fr" href="…">` tells search engines which version to show to whom. `lang="en-GB"` versus `lang="en-US"` also affects hyphenation and spell-checking.',
            ),
            checklist('Every page in your site needs', [
              '`<meta charset="utf-8">` first in the head',
              'A viewport meta tag',
              'A unique, specific `<title>`',
              'A unique `<meta name="description">`',
              'A `<link rel="canonical">` on a live site',
              'A favicon',
              '`lang` on the `<html>` element',
            ]),
            mediaExample(
              'newsroom-desk',
              'Why every page needs its own title',
              'Eight tabs open, all from the same site. The title is the only thing distinguishing them — which is why "Riverside Bakery" on every page makes a site unnavigable the moment somebody opens two of them.',
              `<title>Bike hire prices — Riverside Cycle Hire</title>
<title>Route guides — Riverside Cycle Hire</title>
<title>Contact and opening hours — Riverside Cycle Hire</title>`,
            ),
            demo('The same page, three titles', 'Each shown as it would appear in a browser tab and a search result.', [
              {
                label: 'Specific, distinctive first',
                code: '<title>Bike hire prices — Riverside Cycle Hire</title>',
                note: 'Readable in a narrow tab, unique across the site, and the useful words come before the truncation point.',
              },
              {
                label: 'Site name first',
                code: '<title>Riverside Cycle Hire — Bike hire prices</title>',
                note: 'In a narrow tab the visitor sees only "Riverside Cycl…", which is identical on every page of the site.',
              },
              {
                label: 'Keyword stuffed',
                code: '<title>Riverside Cycle Hire | Bike Hire | Cycling | Hexford | Home</title>',
                note: 'Truncated in results, useless in a tab, and search engines have long since stopped rewarding it.',
              },
            ]),
            recap(
              [
                'Titles appear in tabs, bookmarks, search results and shares — make each one unique and specific.',
                'Descriptions are not a ranking factor but usually become your search snippet.',
                'Canonical URLs resolve duplicate-content ambiguity.',
                'A robots meta tag is a polite request, never a security measure.',
              ],
              'Next: social sharing metadata and structured data.',
            ),
          ],
          exercises: [
            {
              slug: 'metadata-guided',
              kind: 'guided',
              title: 'Complete a page head',
              brief:
                'Add the missing metadata: a unique title, a meta description, a canonical URL of `https://riverside-cycles.example/prices.html`, and a favicon link.',
              starterCode: `<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>`,
              referenceSolution: `<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Bike hire prices — Riverside Cycle Hire</title>
  <meta name="description"
        content="Hourly, daily and weekly bike hire from £6. Helmet, lock and route map included with every hire.">
  <link rel="canonical" href="https://riverside-cycles.example/prices.html">
  <link rel="icon" href="/favicon.svg" type="image/svg+xml">
</head>`,
              hints: [
                'The title should name this page first, then the site.',
                'The description goes in a <meta name="description" content="…"> tag.',
                'The canonical is a <link rel="canonical" href="…">.',
              ],
              requirements: [
                unique('title', 'There is exactly one title'),
                notEmpty('title', 'The title has text'),
                attr('meta[name="description"]', 'content', 'There is a meta description with content'),
                attrValue('link[rel="canonical"]', 'href', 'https://riverside-cycles.example/prices.html', 'The canonical URL is set'),
                present('link[rel="icon"]', 'There is a favicon link'),
              ],
              difficulty: 2,
              xp: 45,
              skill: 'metadata',
            },
            {
              slug: 'metadata-debug',
              kind: 'debug',
              title: 'Metadata that will cost you traffic',
              brief:
                'This head has four problems: the charset is not first, the title is generic and duplicated across the site, the description is far too long, and a `noindex` has been left on a page that should be indexed. Fix all four.',
              starterCode: `<head>
  <title>Riverside Cycle Hire</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="robots" content="noindex, nofollow">
  <meta name="description" content="Riverside Cycle Hire is a bike hire company based in Hexford offering bike hire, cycle hire, bicycle rental, bike rental, cycling equipment, helmets, locks, route maps, guided rides, repairs, servicing, accessories, and much more for everyone in the whole of the surrounding area and beyond, seven days a week, all year round.">
</head>`,
              referenceSolution: `<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Bike hire prices — Riverside Cycle Hire</title>
  <meta name="description"
        content="Hourly, daily and weekly bike hire from £6. Helmet, lock and route map included with every hire.">
</head>`,
              hints: [
                'The charset meta tag must come first in the head.',
                'Make the title specific to this page, not just the company name.',
                'Cut the description to roughly 150 characters of useful, readable prose.',
                'Delete the robots noindex — this page should be indexed.',
              ],
              requirements: [
                { kind: 'direct_child', selector: 'meta[charset]', ancestorSelector: 'head', message: 'The charset meta tag is in the head' },
                notEmpty('title', 'The title has text'),
                { kind: 'element_count', selector: 'meta[name="robots"][content*="noindex"]', minCount: 0, maxCount: 0, message: 'The noindex directive has been removed' },
                attr('meta[name="description"]', 'content', 'A meta description is present'),
                { kind: 'attribute_matches', selector: 'meta[name="description"]', attribute: 'content', expectedValue: '^.{40,200}$', message: 'The description is a useful length, roughly 150 characters', hint: 'Aim for one or two clear sentences.' },
              ],
              difficulty: 3,
              xp: 55,
              skill: 'metadata',
            },
          ],
          quiz: [
            {
              slug: 'q-title-length',
              prompt: 'Roughly how long should a page title be?',
              explanation:
                'About 50–60 characters, before search engines truncate it. Put the distinctive part first.',
              options: [
                { label: 'About 50–60 characters', correct: true },
                { label: 'As long as possible, for keywords' },
                { label: 'Under 20 characters' },
                { label: 'Exactly 160 characters' },
              ],
              skill: 'seo',
            },
            {
              slug: 'q-canonical',
              prompt: 'What does `<link rel="canonical">` do?',
              explanation:
                'It states the preferred URL for a page, resolving ambiguity when the same content is reachable at several addresses.',
              options: [
                { label: 'States the one preferred URL for this content', correct: true },
                { label: 'Redirects visitors to another page' },
                { label: 'Prevents the page being indexed' },
                { label: 'Sets the page language' },
              ],
              skill: 'seo',
            },
            {
              slug: 'q-noindex-security',
              prompt: 'Does `<meta name="robots" content="noindex">` hide a page?',
              explanation:
                'No. It asks well-behaved crawlers not to index it. The page remains fully public to anyone with the URL.',
              options: [
                { label: 'No — the page is still public to anyone with the URL', correct: true },
                { label: 'Yes, it requires a password' },
                { label: 'Yes, it blocks all access' },
                { label: 'Only for logged-out visitors' },
              ],
              skill: 'security',
            },
          ],
        },
        {
          slug: 'social-and-structured-data',
          title: 'Social sharing and structured data',
          subtitle: 'Open Graph, and describing your content to machines with JSON-LD',
          summary:
            'What appears when someone pastes your link into a message, and how to tell a search engine what your page actually is.',
          objectives: [
            'Add Open Graph metadata for social sharing',
            'Write a basic JSON-LD structured-data block',
            'State honestly what structured data can and cannot achieve',
          ],
          estimatedMinutes: 15,
          skill: 'structured-data',
          blocks: [
            objectives([
              'Add the four Open Graph properties that matter',
              'Write valid JSON-LD for a common schema type',
              'Explain the honest limits of SEO markup',
            ]),
            prose(
              'When a link is pasted into a chat app, a social network or a messaging thread, the software fetches the page and looks for Open Graph tags to build a preview card. Without them, it guesses — usually badly.',
            ),
            annotated(
              `<meta property="og:title" content="Bike hire prices — Riverside Cycle Hire">
<meta property="og:description" content="Hourly, daily and weekly hire from £6, helmet and lock included.">
<meta property="og:image" content="https://riverside-cycles.example/images/hero-1200.jpg">
<meta property="og:image:alt" content="A blue hybrid bike outside the Mill Lane workshop">
<meta property="og:url" content="https://riverside-cycles.example/prices.html">
<meta property="og:type" content="website">
<meta name="twitter:card" content="summary_large_image">`,
              [
                {
                  line: '1',
                  text: 'Note `property`, not `name`. Open Graph uses a different attribute from standard meta tags — a very common mistake.',
                },
                {
                  line: '3',
                  text: 'The image must be an absolute URL. A relative path will not work, because the software fetching it has no page context.',
                },
                {
                  line: '4',
                  text: '`og:image:alt` describes the preview image. Frequently omitted, and it is the accessible name of the card for anyone using a screen reader on the platform showing it.',
                },
                {
                  line: '7',
                  text: '`twitter:card` uses `name` rather than `property`, because it is not part of Open Graph. Yes, this is inconsistent.',
                },
              ],
            ),
            callout(
              'tip',
              'Recommended image size',
              '1200 × 630 pixels is the widely accepted standard for a large preview card. Anything much smaller is rendered as a small thumbnail beside the text instead.',
            ),
            term(
              'Structured data',
              'Machine-readable facts about your page, written in a standard vocabulary so software can understand what the page describes rather than merely what words it contains.',
            ),
            term(
              'JSON-LD',
              'The recommended format for structured data: a block of JSON inside a `<script type="application/ld+json">` tag. It sits separately from your visible markup, so it does not tangle with your HTML.',
            ),
            code(
              `<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "LocalBusiness",
  "name": "Riverside Cycle Hire",
  "description": "Bike hire, guided rides and repairs in the Hexford valley.",
  "url": "https://riverside-cycles.example/",
  "telephone": "+441632960123",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "14 Mill Lane",
    "addressLocality": "Hexford",
    "postalCode": "HX2 4PL",
    "addressCountry": "GB"
  },
  "openingHours": "Tu-Su 08:00-18:00"
}
</script>`,
              'JSON-LD describing a local business',
            ),
            callout(
              'note',
              'This is the one script tag this course uses',
              'A `<script type="application/ld+json">` block contains data, not code. Browsers do not execute it; it is simply a container the parser skips over. It is the single exception to "this course does not use script tags", and it is why the exception exists.',
            ),
            code(
              `LocalBusiness   a shop, restaurant, service — address, hours, phone
Organization    a company or charity
Person          an individual — for a portfolio or author page
Article         a news item or blog post — headline, author, date
Product         name, description, price, availability
Event           name, start date, location
BreadcrumbList  the trail of pages leading to this one
FAQPage         a set of questions and answers`,
              'The schema types worth knowing',
              'text',
            ),
            callout(
              'warning',
              'What structured data cannot do',
              'It does not raise your ranking. What it can do is make your result *look* different — star ratings, opening hours, event dates, an FAQ dropdown in the results page — which affects how many people click. It must also describe content that is genuinely on the page: marking up reviews that do not exist is a policy violation and gets sites penalised. Describe what is there, accurately.',
            ),
            detail(
              'The honest limits of on-page SEO',
              'HTML can make your content understandable, crawlable and shareable. It cannot make it *good*, and it cannot make it rank. Rankings depend overwhelmingly on the quality and relevance of your content, on how many other sites reference it, and on how fast and usable your pages are. Anyone who tells you a particular meta tag guarantees a position is selling something. What is genuinely in your control: unique titles and descriptions, a clear heading structure, descriptive links, real alt text, fast-loading pages, and accurate structured data. That is the whole honest list.',
            ),
            mediaExample(
              'event-stage',
              'The image a share card actually uses',
              'A sharing image is not decoration — it is often the only thing seen before someone decides whether to click. It needs its own dimensions and an absolute URL, because the site rendering it is not yours.',
              `<meta property="og:image"
      content="https://riverside-cycles.example/learning-media/images/event-stage.jpg">
<meta property="og:image:width" content="1600">
<meta property="og:image:height" content="900">
<meta property="og:image:alt"
      content="A crowd silhouetted in front of a stage lit by pink and blue lights">`,
            ),
            demo('The same page, shared three ways', 'What a chat app or social network has to work with.', [
              {
                label: 'Full card',
                code: '<meta property="og:title" content="Bike hire prices — Riverside Cycle Hire">\n<meta property="og:description" content="Hourly, daily and weekly hire from £6, helmet and route map included.">\n<meta property="og:image" content="https://riverside-cycles.example/share.jpg">\n<meta property="og:image:alt" content="A blue bicycle on a riverside path">\n<meta property="og:url" content="https://riverside-cycles.example/prices.html">',
                note: 'Title, description, image and a described image. The link arrives as a card somebody might actually click.',
              },
              {
                label: 'Image with no alt',
                code: '<meta property="og:title" content="Bike hire prices — Riverside Cycle Hire">\n<meta property="og:image" content="https://riverside-cycles.example/share.jpg">',
                note: 'The card renders, and screen-reader users on the sharing platform get an unlabelled image. `og:image:alt` is the only fix.',
              },
              {
                label: 'Nothing declared',
                code: '<title>Bike hire prices — Riverside Cycle Hire</title>',
                note: 'Platforms fall back to guessing — usually the title and whichever image they find first, which may be your logo or an advert.',
              },
            ]),
            recap(
              [
                'Open Graph uses `property`, needs absolute image URLs, and wants a 1200×630 image.',
                'JSON-LD describes your content to machines in a standard vocabulary.',
                'Structured data changes how your result *looks*, not where it ranks.',
                'Only ever describe content that is genuinely on the page.',
              ],
              'Next: the Level 9 milestone.',
            ),
          ],
          exercises: [
            {
              slug: 'og-guided',
              kind: 'guided',
              title: 'Add social sharing metadata',
              brief:
                'Add Open Graph tags for title, description, image (absolute URL), image alt, url and type, plus a Twitter card tag.',
              starterCode: `<head>
  <meta charset="utf-8">
  <title>Bike hire prices — Riverside Cycle Hire</title>
  <meta name="description" content="Hourly, daily and weekly hire from £6.">
</head>`,
              referenceSolution: `<head>
  <meta charset="utf-8">
  <title>Bike hire prices — Riverside Cycle Hire</title>
  <meta name="description" content="Hourly, daily and weekly hire from £6.">

  <meta property="og:title" content="Bike hire prices — Riverside Cycle Hire">
  <meta property="og:description" content="Hourly, daily and weekly hire from £6, helmet and lock included.">
  <meta property="og:image" content="https://riverside-cycles.example/images/hero-1200.jpg">
  <meta property="og:image:alt" content="A blue hybrid bike outside the Mill Lane workshop">
  <meta property="og:url" content="https://riverside-cycles.example/prices.html">
  <meta property="og:type" content="website">
  <meta name="twitter:card" content="summary_large_image">
</head>`,
              hints: [
                'Open Graph tags use property="og:…", not name.',
                'The og:image must be a full absolute URL beginning https://.',
                'The twitter:card tag uses name, not property.',
              ],
              requirements: [
                present('meta[property="og:title"]', 'There is an og:title'),
                present('meta[property="og:description"]', 'There is an og:description'),
                attrMatches('meta[property="og:image"]', 'content', '^https?://', 'The og:image is an absolute URL'),
                present('meta[property="og:image:alt"]', 'The preview image has alt text'),
                present('meta[property="og:url"]', 'There is an og:url'),
                present('meta[name="twitter:card"]', 'There is a Twitter card tag'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'seo',
            },
            {
              slug: 'jsonld-challenge',
              kind: 'challenge',
              title: 'Write structured data',
              brief:
                'Add a JSON-LD block describing a LocalBusiness with a name, description, url, telephone and a nested PostalAddress. The details are yours; the shape is what is checked.',
              starterCode: `<head>
  <meta charset="utf-8">
  <title>Riverside Cycle Hire — bike hire in the Hexford valley</title>
</head>`,
              referenceSolution: `<head>
  <meta charset="utf-8">
  <title>Riverside Cycle Hire — bike hire in the Hexford valley</title>

  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "LocalBusiness",
    "name": "Riverside Cycle Hire",
    "description": "Bike hire, guided rides and repairs in the Hexford valley.",
    "url": "https://riverside-cycles.example/",
    "telephone": "+441632960123",
    "address": {
      "@type": "PostalAddress",
      "streetAddress": "14 Mill Lane",
      "addressLocality": "Hexford",
      "postalCode": "HX2 4PL",
      "addressCountry": "GB"
    },
    "openingHours": "Tu-Su 08:00-18:00"
  }
  </script>
</head>`,
              hints: [
                'The block goes inside <script type="application/ld+json">…</script>.',
                'Every JSON-LD block starts with "@context": "https://schema.org" and an "@type".',
                'The address is a nested object with its own "@type": "PostalAddress".',
              ],
              requirements: [
                attrValue('script', 'type', 'application/ld+json', 'There is a JSON-LD script block'),
                { kind: 'text_content', selector: 'script[type="application/ld+json"]', expectedValue: 'schema.org', message: 'The block declares the schema.org context' },
                { kind: 'text_content', selector: 'script[type="application/ld+json"]', expectedValue: '@type', message: 'The block declares a type' },
                { kind: 'text_content', selector: 'script[type="application/ld+json"]', expectedValue: 'PostalAddress', message: 'The block includes a nested postal address' },
              ],
              difficulty: 4,
              xp: 60,
              skill: 'structured-data',
            },
          ],
          quiz: [
            {
              slug: 'q-og-property',
              prompt: 'Which attribute do Open Graph tags use?',
              explanation:
                '`property`, not `name`. Using `name` for `og:` tags is one of the commonest mistakes in this area.',
              options: [
                { label: 'property', correct: true },
                { label: 'name' },
                { label: 'rel' },
                { label: 'itemprop' },
              ],
              skill: 'seo',
            },
            {
              slug: 'q-structured-data-ranking',
              prompt: 'Does structured data improve your search ranking?',
              explanation:
                'No. It can change how your result is *displayed* — rich snippets, star ratings, event dates — which affects clicks, not position.',
              options: [
                { label: 'No — it changes how the result looks, not where it ranks', correct: true },
                { label: 'Yes, it is a direct ranking factor' },
                { label: 'Yes, but only for local businesses' },
                { label: 'Only when combined with Open Graph' },
              ],
              skill: 'structured-data',
            },
            {
              slug: 'q-og-image-url',
              prompt: 'Why must `og:image` be an absolute URL?',
              explanation:
                'The software building the preview fetches the image without your page as context, so a relative path cannot be resolved.',
              options: [
                { label: 'The service fetching it has no page context to resolve a relative path', correct: true },
                { label: 'Relative paths are invalid in meta tags' },
                { label: 'Absolute URLs load faster' },
                { label: 'It is only required for images over 1MB' },
              ],
              skill: 'seo',
            },
          ],
        },
        {
          slug: 'language-and-internationalisation',
          title: 'Language and direction',
          subtitle: 'The attribute that changes how your page is spoken, translated and indexed',
          summary:
            'One attribute on `<html>` affects screen-reader pronunciation, automatic translation, search indexing and how the browser hyphenates. Almost everybody sets it wrongly or not at all.',
          objectives: [
            'Declare the page language correctly',
            'Mark passages that are in a different language',
            'Explain what `dir` does and when it is needed',
          ],
          estimatedMinutes: 14,
          skill: 'metadata',
          blocks: [
            pretest(
              'A page has no `lang` attribute. A screen-reader user in France opens it. What is the most likely result?',
              [
                'English text is read aloud using French pronunciation rules, and is close to unintelligible',
                'The screen reader detects the language automatically from the words',
                'Nothing changes — `lang` only affects search engines',
                'The page fails to load',
              ],
              'The screen reader falls back to the user\'s own configured language and applies French pronunciation to English words. The result is not a slight accent — it is genuinely hard to understand, in the way that reading English aloud with strictly French letter sounds would be. Screen readers do not guess the language from the content; they are told, or they fall back. One attribute prevents this entirely, which is why it is the single highest value-per-character thing in the whole of metadata.',
            ),
            objectives([
              'Set `lang` on `<html>` with a valid language tag',
              'Mark inline passages in another language',
              'Use `dir` where the writing direction genuinely changes',
            ]),
            term(
              'Language tag',
              'A short code identifying a language, optionally with a region: `en`, `en-GB`, `fr`, `pt-BR`. Use the shortest tag that is accurate — `en` is fine unless the regional difference actually matters.',
            ),
            code(
              `<html lang="en-GB">      British English
<html lang="en">         English, region unspecified — usually enough
<html lang="fr">         French
<html lang="pt-BR">      Brazilian Portuguese
<html lang="cy">         Welsh
<html lang="ar">         Arabic — see dir, below`,
              'Declaring the page language',
            ),
            prose(
              'Set it once on `<html>` and every element inherits it. Then override it only where a passage genuinely changes language — and *only* there, because an incorrect override is worse than none.',
            ),
            annotated(
              `<html lang="en">
  <body>
    <p>The bakery is on the Rue des Fleurs.</p>
    <p>Our motto is <span lang="fr">plus de beurre</span>.</p>
    <p lang="cy">Croeso i'r becws.</p>
  </body>
</html>`,
              [
                { line: '1', text: 'Declared once. Everything inside inherits `en` unless it says otherwise.' },
                { line: '3', text: 'A French street name inside an English sentence. This does *not* get a `lang` — proper nouns are read acceptably either way, and marking every foreign-derived name quickly becomes noise.' },
                { line: '4', text: 'An actual French phrase, so it is marked. The screen reader switches voice for those three words and switches back.' },
                { line: '5', text: 'A whole paragraph in Welsh, so the attribute goes on the block itself rather than a span inside it.' },
              ],
            ),
            callout(
              'mistake',
              'The two commonest `lang` errors',
              'Leaving it off entirely — which the validator will tell you about, and which is the more damaging. And setting it once and then never revisiting it, so a page translated into Welsh still says `lang="en"`, which is worse than absent: the screen reader now confidently applies the wrong rules rather than falling back to the user\'s default.',
            ),
            term(
              'Writing direction',
              '`dir="rtl"` marks text that reads right to left — Arabic, Hebrew, Persian, Urdu. `dir="ltr"` is the default. `dir="auto"` lets the browser decide from the first strongly directional character, which is what you want for text you did not write.',
            ),
            demo('Direction in practice', 'The same markup, with and without a direction declared.', [
              {
                label: 'Declared',
                code: '<p lang="ar" dir="rtl">مرحبا بكم في المخبز</p>\n<p>Open seven days a week.</p>',
                note: 'The Arabic paragraph lays out right to left, its punctuation lands on the correct side, and the English paragraph is unaffected.',
              },
              {
                label: 'Not declared',
                code: '<p lang="ar">مرحبا بكم في المخبز</p>\n<p>Open seven days a week.</p>',
                note: 'Browsers handle the characters themselves, but punctuation and any mixed-in Latin text can end up on the wrong side of the line.',
              },
              {
                label: 'User-supplied text',
                code: '<blockquote dir="auto">مرحبا بكم في المخبز</blockquote>\n<blockquote dir="auto">Lovely bread, thank you.</blockquote>',
                note: '`dir="auto"` is the right choice for anything you did not write — a review, a comment, a name — because you cannot know its direction in advance.',
              },
            ]),
            predictCheck(
              `<html lang="en">
  <body>
    <p lang="en">Welcome to the bakery.</p>
    <p lang="en">Our motto is plus de beurre.</p>
  </body>
</html>`,
              'Every element here declares `lang="en"`, including a phrase that is actually French. Before you check: is repeating the attribute harmful, useless, or helpful?',
              'Repeating `en` on the paragraphs is merely useless — they already inherited it. The real fault is the second paragraph, where a French phrase is now positively asserted to be English, so a screen reader will pronounce it with English rules rather than switching. This is the pattern worth internalising: a missing `lang` makes software fall back, which is bad; a *wrong* `lang` makes software confident, which is worse. Declare it once at the top, and override only where the language genuinely changes.',
            ),
            detail(
              'What `lang` reaches beyond screen readers',
              'Browser translation offers, and correctly identifies the source language. Hyphenation and line-breaking rules. Which font a browser picks for characters that exist in several scripts. Spell-checking in editable fields. Search engines use it to serve the right page to the right audience — which is why it sits in the metadata level rather than the accessibility one, though it matters most for accessibility. And `<html lang>` is required for several WCAG success criteria, so a page without it cannot conform at any level.',
            ),
            checklist('Language checklist', [
              '`<html>` has a `lang` with a valid tag',
              'The tag is actually correct for the content — not copied from a template',
              'Passages in another language are marked, at the block or span level',
              'Proper nouns are *not* marked just for being foreign',
              '`dir="rtl"` on right-to-left content, `dir="auto"` on anything user-supplied',
            ]),
            recap(
              [
                '`lang` on `<html>` is inherited by everything and affects speech, translation, fonts and indexing.',
                'Override it only where the language genuinely changes.',
                'A wrong `lang` is worse than a missing one: software stops falling back and becomes confidently wrong.',
                '`dir="auto"` is the right default for text you did not write.',
              ],
              'Next: the Level 9 milestone.',
            ),
            activeRecap(
              [
                'What does a missing `lang` do to a screen-reader user, specifically?',
                'When should you add `lang` to an element inside the page — and when should you not?',
                'What is `dir="auto"` for?',
              ],
              [
                'The reader falls back to the user\'s own language and applies its pronunciation rules to your words, which can make the page close to unintelligible rather than merely accented.',
                'Add it where a passage is genuinely in another language, at block or span level. Do not add it to proper nouns, and do not restate the page language on elements that already inherit it.',
                'Text whose direction you cannot know in advance — anything user-supplied, such as a review, comment or name. The browser decides from the first strongly directional character.',
              ],
            ),
          ],
          exercises: [
            {
              slug: 'lang-guided',
              kind: 'guided',
              title: 'Declare the language properly',
              brief:
                'Set the page language to British English, mark the French motto so it is pronounced correctly, and mark the Welsh greeting on its own paragraph. Do not mark the French street name — it is a proper noun.',
              starterCode: `<html>
  <head>
    <meta charset="utf-8">
    <title>Riverside Bakery</title>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>You will find us on the Rue des Fleurs.</p>
    <p>Our motto is plus de beurre.</p>
    <p>Croeso i'r becws.</p>
  </body>
</html>`,
              referenceSolution: `<html lang="en-GB">
  <head>
    <meta charset="utf-8">
    <title>Riverside Bakery</title>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>You will find us on the Rue des Fleurs.</p>
    <p>Our motto is <span lang="fr">plus de beurre</span>.</p>
    <p lang="cy">Croeso i'r becws.</p>
  </body>
</html>`,
              hints: [
                'The page language goes on the <html> element itself: lang="en-GB".',
                'Wrap just the French words in a <span lang="fr">.',
                'The Welsh sentence is a whole paragraph, so the attribute goes on the <p>.',
              ],
              requirements: [
                attrValue('html', 'lang', 'en-GB', 'The page declares British English'),
                attrValue('span', 'lang', 'fr', 'The French phrase is marked'),
                attrValue('p[lang="cy"]', 'lang', 'cy', 'The Welsh paragraph is marked'),
                count('[lang="fr"]', 1, 1, 'Only the French phrase is marked as French'),
                notEmpty('title', 'The page still has a title'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'metadata',
            },
            {
              slug: 'lang-debug',
              kind: 'debug',
              title: 'Confidently wrong language markup',
              brief:
                'This page declares the wrong language, restates it needlessly on every paragraph, marks a proper noun as foreign, and leaves an Arabic quotation with no direction. Repair all four.',
              starterCode: `<html lang="fr">
  <body>
    <h1>Riverside Bakery</h1>
    <p lang="fr">Open seven days a week.</p>
    <p lang="fr">You will find us on the <span lang="fr">Rue des Fleurs</span>.</p>
    <blockquote lang="ar">مرحبا بكم في المخبز</blockquote>
  </body>
</html>`,
              referenceSolution: `<html lang="en">
  <body>
    <h1>Riverside Bakery</h1>
    <p>Open seven days a week.</p>
    <p>You will find us on the Rue des Fleurs.</p>
    <blockquote lang="ar" dir="rtl">مرحبا بكم في المخبز</blockquote>
  </body>
</html>`,
              hints: [
                'The page is in English, so <html lang="en">.',
                'Paragraphs inherit the page language — remove the repeated lang attributes.',
                'A street name is a proper noun and should not be marked as French.',
                'Arabic reads right to left, so the quotation needs dir="rtl".',
              ],
              requirements: [
                attrValue('html', 'lang', 'en', 'The page declares English'),
                count('[lang="fr"]', 0, 0, 'Nothing is wrongly marked as French'),
                count('p[lang]', 0, 0, 'Paragraphs simply inherit the page language'),
                attrValue('blockquote', 'dir', 'rtl', 'The Arabic quotation declares its direction'),
                attrValue('blockquote', 'lang', 'ar', 'The Arabic quotation declares its language'),
              ],
              difficulty: 3,
              xp: 45,
              skill: 'metadata',
            },
          ],
          quiz: [
            {
              slug: 'q-lang-missing-effect',
              prompt: 'What happens when a page has no `lang` attribute?',
              explanation:
                'Assistive technology falls back to the user\'s own language settings and applies its pronunciation rules to your text.',
              options: [
                { label: 'Screen readers fall back to the user\'s language and mispronounce the content', correct: true },
                { label: 'The page will not validate but nothing else changes' },
                { label: 'Browsers detect the language from the words automatically' },
                { label: 'Only search ranking is affected' },
              ],
              skill: 'metadata',
            },
            {
              slug: 'q-wrong-lang-worse',
              prompt: 'Why is an incorrect `lang` worse than a missing one?',
              explanation:
                'A missing attribute makes software fall back to a sensible default. A wrong one makes it confidently apply the wrong rules.',
              options: [
                { label: 'Software stops falling back and applies the wrong rules with confidence', correct: true },
                { label: 'It causes a validation error, whereas a missing one does not' },
                { label: 'It prevents the page being indexed at all' },
                { label: 'There is no difference in practice' },
              ],
              skill: 'metadata',
            },
            {
              slug: 'q-dir-auto',
              prompt: 'When is `dir="auto"` the right choice?',
              explanation:
                'For text whose direction you cannot know when writing the page — anything supplied by a user.',
              options: [
                { label: 'For user-supplied text such as reviews, comments or names', correct: true },
                { label: 'For every element on a multilingual page' },
                { label: 'Only on the `<html>` element' },
                { label: 'Whenever the page mixes two fonts' },
              ],
              skill: 'metadata',
            },
          ],
        },
        {
          slug: 'seo-milestone',
          title: 'Milestone: optimise a page for discovery',
          subtitle: 'Every metadata decision on one page',
          summary: 'A complete, discoverable, shareable page head plus a correctly structured body.',
          objectives: [
            'Build a complete production-quality document head',
            'Add social metadata and structured data',
            'Apply the same to your capstone site',
          ],
          estimatedMinutes: 22,
          skill: 'seo',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Produce a head containing every piece of metadata a real page needs',
              'Combine metadata with correct semantic body structure',
              'Update your capstone pages to match',
            ]),
            checklist('The milestone page head needs', [
              '`<meta charset="utf-8">` first',
              'A viewport meta tag',
              'A unique, specific `<title>` of about 50–60 characters',
              'A `<meta name="description">` of about 150 characters',
              'A `<link rel="canonical">`',
              'A favicon',
              'Open Graph title, description, image, image alt, url and type',
              'A Twitter card tag',
              'A JSON-LD structured-data block',
              '`lang` on the `<html>` element',
            ]),
            callout(
              'tip',
              'Write the metadata after the content, not before',
              'A description is a summary. Writing it before the page exists produces a vague sentence that could describe anything. Write the page, then read it back and describe it honestly in one sentence — that sentence is your description, and it is usually a good og:description too.',
            ),
            code(
              `<!-- Order matters: charset first, then viewport, then everything else -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Bike hire prices — Riverside Cycle Hire</title>
<meta name="description" content="Hourly, daily and weekly hire from £6.">
<link rel="canonical" href="https://riverside-cycles.example/prices.html">
<link rel="icon" href="/favicon.svg" type="image/svg+xml">

<meta property="og:title" content="Bike hire prices — Riverside Cycle Hire">
<meta property="og:image" content="https://riverside-cycles.example/share-1200.jpg">
<meta property="og:url" content="https://riverside-cycles.example/prices.html">`,
              'A complete head, in the order it should be written',
            ),
            compare(
              'What a shared link looks like',
              {
                label: 'With Open Graph tags',
                code: `<meta property="og:title" content="Bike hire prices — Riverside">
<meta property="og:description" content="Hire from £6 an hour.">
<meta property="og:image" content="https://riverside-cycles.example/share-1200.jpg">
<meta property="og:image:alt" content="A blue hybrid bike outside the workshop">`,
                why: 'A card with a large image, your headline and your sentence — chosen by you.',
              },
              {
                label: 'Without',
                code: `<title>Riverside Cycle Hire</title>`,
                why: 'The messaging app guesses: often just the bare URL, or the first stray sentence it finds on the page.',
              },
            ),
            demo('What a search result is built from', 'Three pages, three very different results.', [
              {
                label: 'Complete',
                code: '<title>Bike hire prices — Riverside Cycle Hire</title>\n<meta name="description" content="Hourly, daily and weekly hire from £6. Helmet, lock and route map included.">\n<link rel="canonical" href="https://riverside-cycles.example/prices.html">',
                note: 'A distinct title, a description that reads as a promise, and one canonical address so duplicates do not compete.',
              },
              {
                label: 'Shared title',
                code: '<title>Riverside Cycle Hire</title>\n<meta name="description" content="Riverside Cycle Hire">',
                note: 'Every page identical. Tabs are indistinguishable, bookmarks meaningless, and the search engine has nothing to tell them apart.',
              },
              {
                label: 'No canonical',
                code: '<title>Bike hire prices — Riverside Cycle Hire</title>\n<meta name="description" content="Hourly, daily and weekly hire from £6.">',
                note: 'Fine until the same page is reachable with and without a trailing slash, or with tracking parameters — then several URLs compete with each other.',
              },
            ]),
            recall(
              'Metadata sits on top of structure — it cannot rescue a badly built page. From memory: which earlier decisions does a search engine actually read, and why does each one matter to it?',
              [
                'Level 1 — `<html lang>` tells it which audience the page is for; the `<title>` is the single most-read line you will write.',
                'Level 2 — the heading outline is how a crawler works out what the page is about and which parts are subordinate.',
                'Level 3 — descriptive link text is a signal about the destination, which is why "click here" wastes it.',
                'Level 4 — `alt` text is the only description of an image a crawler has.',
                'Level 5 — landmarks separate the content of this page from the navigation repeated on every page.',
              ],
              'What the crawler was already reading',
            ),
            recap(
              [
                'A complete head is roughly ten lines and takes five minutes.',
                'Every page needs its own title and description.',
                'Social metadata determines what a shared link looks like.',
                'Structured data describes content that genuinely exists on the page.',
              ],
              'Level 10 next: performance and security.',
            ),
          ],
          exercises: [
            {
              slug: 'seo-milestone-build',
              kind: 'challenge',
              title: 'Milestone: a fully optimised page',
              brief:
                'Build a complete HTML document with everything on the checklist above in the head, plus a body containing header, nav, main with one h1, and footer.',
              starterCode: '',
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Bike hire prices — Riverside Cycle Hire</title>
    <meta name="description"
          content="Hourly, daily and weekly bike hire from £6. Helmet, lock and route map included with every hire.">
    <link rel="canonical" href="https://riverside-cycles.example/prices.html">
    <link rel="icon" href="/learning-media/favicon.svg" type="image/svg+xml">
    <meta name="theme-color" content="#1d4ed8">

    <meta property="og:title" content="Bike hire prices — Riverside Cycle Hire">
    <meta property="og:description" content="Hourly, daily and weekly hire from £6, helmet and lock included.">
    <meta property="og:image" content="https://riverside-cycles.example/images/hero-1200.jpg">
    <meta property="og:image:alt" content="A blue hybrid bike outside the Mill Lane workshop">
    <meta property="og:url" content="https://riverside-cycles.example/prices.html">
    <meta property="og:type" content="website">
    <meta name="twitter:card" content="summary_large_image">

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
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="prices.html" aria-current="page">Prices</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Bike hire prices</h1>
      <p>Every hire includes a helmet, a lock and a printed route map.</p>
    </main>
    <footer>
      <p>© 2026 Riverside Cycle Hire</p>
    </footer>
  </body>
</html>`,
              hints: [
                'Build the head in order: charset, viewport, title, description, canonical, icon, then the og: tags, then the JSON-LD.',
                'og: tags use property="…"; twitter:card uses name="…".',
                'The body needs the landmark structure from Level 5.',
              ],
              requirements: [
                doctype(),
                { kind: 'attribute_present', selector: 'html', attribute: 'lang', message: 'The html element declares a language' },
                { kind: 'direct_child', selector: 'meta[charset]', ancestorSelector: 'head', message: 'The charset is declared in the head' },
                present('meta[name="viewport"]', 'There is a viewport meta tag'),
                unique('title', 'There is exactly one title'),
                attr('meta[name="description"]', 'content', 'There is a meta description'),
                present('link[rel="canonical"]', 'There is a canonical link'),
                present('link[rel="icon"]', 'There is a favicon'),
                present('meta[property="og:title"]', 'Open Graph title is set'),
                present('meta[property="og:image"]', 'Open Graph image is set'),
                present('meta[property="og:image:alt"]', 'The Open Graph image has alt text'),
                present('meta[property="og:url"]', 'Open Graph url is set'),
                present('meta[name="twitter:card"]', 'A Twitter card is declared'),
                attrValue('script', 'type', 'application/ld+json', 'There is a JSON-LD block'),
                present('header', 'The body has a header landmark'),
                unique('main', 'There is exactly one main'),
                present('footer', 'There is a footer landmark'),
                unique('h1', 'There is exactly one h1'),
                headingOrder(),
                legalNesting(),
              ],
              difficulty: 4,
              xp: 150,
              skill: 'seo',
            },
            {
              slug: 'seo-mission',
              kind: 'project_mission',
              title: 'Capstone mission: unique metadata on every page',
              brief:
                'Give every page of your capstone site its own title, its own description, a canonical URL, a favicon and Open Graph tags. Add a JSON-LD block to your homepage describing what your project actually is.',
              starterCode: `<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- A title specific to THIS page -->
  <!-- A description specific to THIS page -->
  <!-- canonical, favicon -->
  <!-- Open Graph tags -->
  <!-- JSON-LD on the homepage -->
</head>`,
              referenceSolution: `<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>About us — Riverside Cycle Hire</title>
  <meta name="description"
        content="Family-run bike hire on Mill Lane since 1998. Every bike serviced on site by our own mechanics.">
  <link rel="canonical" href="https://riverside-cycles.example/about.html">
  <link rel="icon" href="/learning-media/favicon.svg" type="image/svg+xml">

  <meta property="og:title" content="About us — Riverside Cycle Hire">
  <meta property="og:description" content="Family-run bike hire on Mill Lane since 1998.">
  <meta property="og:image" content="https://riverside-cycles.example/images/workshop-1200.jpg">
  <meta property="og:image:alt" content="Hand tools hanging above a workbench in the Mill Lane workshop">
  <meta property="og:url" content="https://riverside-cycles.example/about.html">
  <meta property="og:type" content="website">
</head>`,
              hints: [
                'The title and description must describe this specific page, not the whole site.',
                'The canonical URL is this page\'s own address.',
                'og:image must be an absolute URL.',
              ],
              requirements: [
                unique('title', 'The page has its own title'),
                notEmpty('title', 'The title has text'),
                attr('meta[name="description"]', 'content', 'The page has its own description'),
                present('link[rel="canonical"]', 'A canonical URL is set'),
                present('link[rel="icon"]', 'A favicon is linked'),
                present('meta[property="og:title"]', 'Open Graph metadata is present'),
                attrMatches('meta[property="og:image"]', 'content', '^https?://', 'The og:image is an absolute URL'),
              ],
              difficulty: 3,
              xp: 95,
              skill: 'metadata',
            },
          ],
          quiz: [
            {
              slug: 'q-metadata-order',
              prompt: 'Why must `<meta charset>` come first in the head?',
              explanation:
                'The browser must know the encoding within the first 1024 bytes. A late declaration forces it to restart parsing.',
              options: [
                { label: 'The browser needs it within the first 1024 bytes', correct: true },
                { label: 'It must come before the doctype' },
                { label: 'Search engines only read the first meta tag' },
                { label: 'It has no effect on order' },
              ],
              skill: 'metadata',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'level-9-milestone',
    kind: 'milestone',
    title: 'Level 9 milestone: Metadata, SEO and Discoverability',
    description: 'Eight questions on metadata, social sharing and structured data. Pass mark 75%.',
    passScore: 0.75,
    xp: 180,
    questions: [
      {
        slug: 'a9-q1',
        prompt: 'Which appears in browser tabs, bookmarks and search results?',
        explanation: 'The `<title>` element.',
        options: [
          { label: '<title>', correct: true },
          { label: '<h1>' },
          { label: 'meta description' },
          { label: 'og:title' },
        ],
        skill: 'metadata',
      },
      {
        slug: 'a9-q2',
        prompt: 'Is the meta description a ranking factor?',
        explanation: 'No, but it is usually the text shown under your result, which affects clicks.',
        options: [
          { label: 'No, but it is often the snippet shown in results', correct: true },
          { label: 'Yes, it is the strongest ranking factor' },
          { label: 'Yes, for local searches only' },
          { label: 'It has no effect at all' },
        ],
        skill: 'seo',
      },
      {
        slug: 'a9-q3',
        prompt: 'Which format does Google recommend for structured data?',
        explanation: 'JSON-LD, in a `<script type="application/ld+json">` block.',
        options: [
          { label: 'JSON-LD', correct: true },
          { label: 'Microdata attributes' },
          { label: 'RDFa' },
          { label: 'XML sitemaps' },
        ],
        skill: 'structured-data',
      },
      {
        slug: 'a9-q4',
        prompt: 'What size should an Open Graph image be?',
        explanation: '1200 × 630 pixels is the accepted standard for a large preview card.',
        options: [
          { label: '1200 × 630', correct: true },
          { label: '600 × 600' },
          { label: '320 × 240' },
          { label: 'Any size — it is scaled automatically' },
        ],
        skill: 'seo',
      },
      {
        slug: 'a9-q5',
        prompt: 'What must structured data describe?',
        explanation:
          'Content genuinely present on the page. Marking up things that do not exist is a policy violation.',
        options: [
          { label: 'Content that is genuinely on the page', correct: true },
          { label: 'Whatever keywords you want to rank for' },
          { label: 'Only the page title' },
          { label: 'Your competitors\' content' },
        ],
        skill: 'structured-data',
      },
      {
        slug: 'a9-q6',
        prompt: 'Why give every page its own title?',
        explanation:
          'So visitors can tell tabs and bookmarks apart, and so search engines have something distinguishing to display.',
        options: [
          { label: 'So tabs, bookmarks and results are distinguishable', correct: true },
          { label: 'Because duplicate titles are invalid HTML' },
          { label: 'To increase keyword density' },
          { label: 'To speed up rendering' },
        ],
        skill: 'seo',
      },
      {
        slug: 'a9-q7',
        prompt: 'What does `lang="fr"` on a `<span>` achieve?',
        explanation:
          'A screen reader switches to French pronunciation for that phrase, instead of reading French words with English phonetics.',
        options: [
          { label: 'Screen readers pronounce that phrase in French', correct: true },
          { label: 'It translates the text' },
          { label: 'It changes the font' },
          { label: 'It sets a different character encoding' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'a9-q8',
        prompt: 'What can HTML alone honestly guarantee about search rankings?',
        explanation:
          'Nothing. HTML makes content crawlable, understandable and shareable; ranking depends on content quality, links and page experience.',
        options: [
          { label: 'Nothing — it makes content crawlable and understandable, not high-ranking', correct: true },
          { label: 'A first-page position with the right meta tags' },
          { label: 'A rich snippet in every result' },
          { label: 'Higher ranking than sites without structured data' },
        ],
        skill: 'seo',
      },
    ],
  },
};
