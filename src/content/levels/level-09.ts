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
  doctype,
  headingOrder,
  legalNesting,
  notEmpty,
  objectives,
  present,
  prose,
  recap,
  term,
  unique,
  type LevelSpec,
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
      prerequisites: ['accessibility-foundations'],
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
