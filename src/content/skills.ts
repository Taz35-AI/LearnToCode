import type { SkillSpec } from './types';

/**
 * The skills the course tracks mastery against.
 *
 * These are deliberately coarse enough to be meaningful ("forms", not
 * "the maxlength attribute") and fine enough to drive targeted practice.
 * Prerequisites form the graph that gates module unlocking.
 */
export const SKILLS: SkillSpec[] = [
  {
    slug: 'document-structure',
    name: 'Document structure',
    description:
      'Building a valid HTML document: the doctype, the html, head and body elements, and the metadata a page needs to work.',
    category: 'Foundations',
  },
  {
    slug: 'syntax',
    name: 'Tags, elements and attributes',
    description:
      'Writing well-formed markup: opening and closing tags, nesting, attributes, indentation and comments.',
    category: 'Foundations',
  },
  {
    slug: 'text-semantics',
    name: 'Text semantics',
    description:
      'Choosing the element that matches the meaning of your text — headings, paragraphs, emphasis, quotations, dates, code and abbreviations.',
    category: 'Content',
    prerequisites: ['syntax'],
  },
  {
    slug: 'lists',
    name: 'Lists and structured content',
    description:
      'Marking up ordered, unordered and description lists, and nesting them correctly.',
    category: 'Content',
    prerequisites: ['syntax'],
  },
  {
    slug: 'links',
    name: 'Links',
    description:
      'Linking to pages, sections, email addresses and files, with link text that makes sense on its own.',
    category: 'Navigation',
    prerequisites: ['syntax'],
  },
  {
    slug: 'navigation',
    name: 'Navigation and site architecture',
    description:
      'Building consistent menus, breadcrumbs and skip links, and organising a project into folders that scale.',
    category: 'Navigation',
    prerequisites: ['links'],
  },
  {
    slug: 'images',
    name: 'Images and alternative text',
    description:
      'Placing images correctly, telling informative images apart from decorative ones, and writing alt text that carries the meaning.',
    category: 'Media',
    prerequisites: ['syntax'],
  },
  {
    slug: 'responsive-images',
    name: 'Responsive images',
    description:
      'Serving the right image for the screen with srcset, sizes and picture, including art direction and modern formats.',
    category: 'Media',
    prerequisites: ['images'],
  },
  {
    slug: 'audio-video',
    name: 'Audio and video',
    description:
      'Embedding accessible media with multiple sources, posters, controls, captions and fallback content.',
    category: 'Media',
    prerequisites: ['images'],
  },
  {
    slug: 'embedded-content',
    name: 'Embedded content',
    description:
      'Embedding third-party content safely with iframes, sandboxing and referrer policies.',
    category: 'Media',
    prerequisites: ['audio-video'],
  },
  {
    slug: 'semantic-html',
    name: 'Semantic HTML',
    description:
      'Using header, nav, main, section, article, aside and footer to describe what a page means, not how it looks.',
    category: 'Structure',
    prerequisites: ['text-semantics', 'document-structure'],
  },
  {
    slug: 'multi-page',
    name: 'Multi-page architecture',
    description:
      'Building a site of several pages with consistent structure, shared patterns and sensible file organisation.',
    category: 'Structure',
    prerequisites: ['navigation', 'semantic-html'],
  },
  {
    slug: 'tables',
    name: 'Data tables',
    description:
      'Marking up tabular data accessibly with caption, thead, scope, colspan and rowspan — and knowing when not to use a table.',
    category: 'Data',
    prerequisites: ['semantic-html'],
  },
  {
    slug: 'forms',
    name: 'Forms',
    description:
      'Building forms people can actually complete: labels, input types, grouping, validation attributes and accessible error messages.',
    category: 'Data',
    prerequisites: ['semantic-html'],
  },
  {
    slug: 'native-interaction',
    name: 'Native interactive elements',
    description:
      'Using details, summary, dialog, popover, progress, meter and datalist instead of reaching for JavaScript.',
    category: 'Interaction',
    prerequisites: ['forms'],
  },
  {
    slug: 'accessibility',
    name: 'Accessibility',
    description:
      'Building pages that work with a keyboard and a screen reader: landmarks, names, focus order and WCAG 2.2 AA thinking.',
    category: 'Quality',
    prerequisites: ['semantic-html', 'images', 'forms'],
  },
  {
    slug: 'aria',
    name: 'ARIA fundamentals',
    description:
      'Knowing the small set of ARIA attributes worth using, and knowing that correct HTML beats ARIA every time.',
    category: 'Quality',
    prerequisites: ['accessibility'],
  },
  {
    slug: 'metadata',
    name: 'Metadata',
    description:
      'The head of a document: character encoding, viewport, titles, descriptions, canonical URLs, favicons and language.',
    category: 'Discoverability',
    prerequisites: ['document-structure'],
  },
  {
    slug: 'seo',
    name: 'On-page SEO',
    description:
      'How HTML structure influences search visibility and social sharing — and what HTML cannot promise.',
    category: 'Discoverability',
    prerequisites: ['metadata', 'text-semantics'],
  },
  {
    slug: 'structured-data',
    name: 'Structured data',
    description: 'Describing your content to machines with JSON-LD and basic schema.org types.',
    category: 'Discoverability',
    prerequisites: ['seo'],
  },
  {
    slug: 'performance',
    name: 'Performance-aware HTML',
    description:
      'The markup decisions that make pages fast: dimensions, lazy loading, preload choices, script loading and resource hints.',
    category: 'Production',
    prerequisites: ['responsive-images', 'metadata'],
  },
  {
    slug: 'security',
    name: 'Security awareness',
    description:
      'Safe external links, iframe sandboxing, referrer policies, CSP basics, and why client-side validation is never enough.',
    category: 'Production',
    prerequisites: ['embedded-content', 'forms'],
  },
  {
    slug: 'validation',
    name: 'Validation',
    description:
      'Reading validator output and fixing what it finds: nesting errors, unclosed tags, duplicate ids and bad attributes.',
    category: 'Craft',
    prerequisites: ['syntax'],
  },
  {
    slug: 'debugging',
    name: 'Debugging and developer tools',
    description:
      'Using browser developer tools to inspect the DOM, test keyboard navigation and find the cause of a problem.',
    category: 'Craft',
    prerequisites: ['validation'],
  },
  {
    slug: 'maintainability',
    name: 'Maintainable HTML',
    description:
      'Code that another person — including future you — can read: consistent formatting, useful comments, reusable patterns and no needless containers.',
    category: 'Craft',
    prerequisites: ['semantic-html'],
  },
  {
    slug: 'progressive-enhancement',
    name: 'Progressive enhancement',
    description:
      'Building so the page works everywhere first, then improves where the browser supports more.',
    category: 'Production',
    prerequisites: ['native-interaction', 'accessibility'],
  },
];

export const SKILL_SLUGS = SKILLS.map((s) => s.slug);
