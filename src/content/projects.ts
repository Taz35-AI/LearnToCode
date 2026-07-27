import type { ProjectTemplateSpec } from './types';

/**
 * The capstone project types a learner chooses during onboarding.
 *
 * Each carries a page plan that the learner's project is seeded with, so their
 * project has real structure from the first mission rather than appearing as an
 * empty folder at the end of the course.
 */
export const PROJECT_TEMPLATES: ProjectTemplateSpec[] = [
  {
    slug: 'personal-portfolio',
    name: 'Personal portfolio',
    tagline: 'Show what you can do, to people who might hire you',
    description:
      'A site about you and your work. Strong on structure, images and a contact form — and the most directly useful outcome if you are learning to change career.',
    audience: 'Employers, clients and collaborators',
    heroMediaSlug: 'studio-desk',
    pagePlan: [
      { path: 'index.html', title: 'Home', purpose: 'Who you are and what you do, in one screen' },
      { path: 'about.html', title: 'About', purpose: 'Your background, skills and approach' },
      { path: 'projects.html', title: 'Projects', purpose: 'Your work, with images and short case studies' },
      { path: 'projects/case-study.html', title: 'Case study', purpose: 'One project in depth' },
      { path: 'contact.html', title: 'Contact', purpose: 'A form and your details' },
    ],
  },
  {
    slug: 'small-business',
    name: 'Small business website',
    tagline: 'The site every local business actually needs',
    description:
      'Homepage, services, about, contact. Covers the full range of the course — tables for pricing, forms for enquiries, structured data for local search.',
    audience: 'Local customers looking for a service',
    heroMediaSlug: 'city-dusk',
    pagePlan: [
      { path: 'index.html', title: 'Home', purpose: 'What you offer and how to get it' },
      { path: 'about.html', title: 'About', purpose: 'The story and the people' },
      { path: 'services.html', title: 'Services', purpose: 'What you do, with a pricing table' },
      { path: 'faq.html', title: 'FAQ', purpose: 'Common questions, as a details accordion' },
      { path: 'contact.html', title: 'Contact', purpose: 'An enquiry form and your address' },
    ],
  },
  {
    slug: 'local-service',
    name: 'Local service website',
    tagline: 'A trade or service business with a service area',
    description:
      'A plumber, electrician, gardener or cleaner. Heavy on trust signals, opening hours and a booking form — with structured data for local search results.',
    audience: 'People searching for a nearby tradesperson',
    heroMediaSlug: 'workshop-tools',
    pagePlan: [
      { path: 'index.html', title: 'Home', purpose: 'What you do and the areas you cover' },
      { path: 'about.html', title: 'About', purpose: 'Experience, qualifications and accreditations' },
      { path: 'services.html', title: 'Services', purpose: 'Each service with an indicative price' },
      { path: 'areas.html', title: 'Areas covered', purpose: 'Where you work, as a list or table' },
      { path: 'contact.html', title: 'Contact', purpose: 'A booking form with date and time' },
    ],
  },
  {
    slug: 'restaurant',
    name: 'Restaurant website',
    tagline: 'Menu, hours, booking',
    description:
      'A restaurant, café or takeaway. The menu is an excellent exercise in list and heading structure, and opening hours make a genuinely useful table.',
    audience: 'People deciding where to eat tonight',
    heroMediaSlug: 'restaurant-plate',
    pagePlan: [
      { path: 'index.html', title: 'Home', purpose: 'What kind of place this is' },
      { path: 'menu.html', title: 'Menu', purpose: 'Courses as structured lists with prices' },
      { path: 'about.html', title: 'About', purpose: 'The kitchen, the sourcing, the people' },
      { path: 'hours.html', title: 'Opening hours', purpose: 'A properly marked-up hours table' },
      { path: 'book.html', title: 'Book a table', purpose: 'A booking form with date, time and party size' },
    ],
  },
  {
    slug: 'hobby-site',
    name: 'Hobby or interest website',
    tagline: 'Write about something you actually care about',
    description:
      'A site about a hobby, a collection, a club or a subject you know well. The easiest to write real content for, which makes the structural decisions clearer.',
    audience: 'Other people interested in the same thing',
    heroMediaSlug: 'forest-path',
    pagePlan: [
      { path: 'index.html', title: 'Home', purpose: 'What this site covers' },
      { path: 'guide.html', title: 'Beginner guide', purpose: 'A long article with a full heading hierarchy' },
      { path: 'gallery.html', title: 'Gallery', purpose: 'Figures with captions and responsive images' },
      { path: 'resources.html', title: 'Resources', purpose: 'Curated links with descriptive link text' },
      { path: 'contact.html', title: 'Contact', purpose: 'A simple contact form' },
    ],
  },
  {
    slug: 'vehicle-rental',
    name: 'Vehicle-rental website',
    tagline: 'A fleet, rates and a booking form',
    description:
      'Car, van, bike or boat hire. Strong on tables for rates, forms for booking, and image galleries for the fleet.',
    audience: 'People who need a vehicle for a few days',
    heroMediaSlug: 'vehicle-hire',
    pagePlan: [
      { path: 'index.html', title: 'Home', purpose: 'What you hire and how it works' },
      { path: 'fleet.html', title: 'Our fleet', purpose: 'Each vehicle as an article with images' },
      { path: 'rates.html', title: 'Rates', purpose: 'A rates table with row and column headings' },
      { path: 'terms.html', title: 'Terms', purpose: 'Hire conditions as a description list' },
      { path: 'book.html', title: 'Book', purpose: 'A booking form with dates and vehicle choice' },
    ],
  },
  {
    slug: 'product-showcase',
    name: 'Product showcase website',
    tagline: 'One product, presented properly',
    description:
      'A single product or small range. Excellent for responsive images, specification tables and structured data.',
    audience: 'People deciding whether to buy',
    heroMediaSlug: 'product-bottle',
    pagePlan: [
      { path: 'index.html', title: 'Home', purpose: 'The product and why it exists' },
      { path: 'features.html', title: 'Features', purpose: 'What it does, in structured sections' },
      { path: 'specifications.html', title: 'Specifications', purpose: 'A specification table' },
      { path: 'faq.html', title: 'FAQ', purpose: 'Questions as a details accordion' },
      { path: 'contact.html', title: 'Contact', purpose: 'An enquiry form' },
    ],
  },
  {
    slug: 'news-magazine',
    name: 'News or magazine-style website',
    tagline: 'Articles, sections and a real editorial structure',
    description:
      'The best choice for practising article semantics, heading hierarchy, dates, quotations and citations.',
    audience: 'Readers looking for the latest on a subject',
    heroMediaSlug: 'newsroom-desk',
    pagePlan: [
      { path: 'index.html', title: 'Home', purpose: 'Latest articles as a list of article elements' },
      { path: 'articles/feature.html', title: 'Feature article', purpose: 'A long article with quotations and dates' },
      { path: 'about.html', title: 'About', purpose: 'Who publishes this and why' },
      { path: 'archive.html', title: 'Archive', purpose: 'Past articles, grouped by date' },
      { path: 'contact.html', title: 'Contact', purpose: 'A tip-off or letters form' },
    ],
  },
  {
    slug: 'event-site',
    name: 'Event website',
    tagline: 'Dates, programme, venue, tickets',
    description:
      'A conference, festival, wedding or club night. Strong on time elements, schedule tables and registration forms.',
    audience: 'People deciding whether to attend',
    heroMediaSlug: 'event-stage',
    pagePlan: [
      { path: 'index.html', title: 'Home', purpose: 'What, when and where' },
      { path: 'programme.html', title: 'Programme', purpose: 'A schedule table with time elements' },
      { path: 'speakers.html', title: 'Speakers', purpose: 'Each speaker as an article with a portrait' },
      { path: 'venue.html', title: 'Venue', purpose: 'Directions, an embedded map and accessibility information' },
      { path: 'register.html', title: 'Register', purpose: 'A registration form' },
    ],
  },
  {
    slug: 'custom',
    name: 'Custom project',
    tagline: 'Something else entirely',
    description:
      'Bring your own idea. You will get the same five-page structure and the same missions; you decide what the pages are about.',
    audience: 'Whoever your project is for',
    heroMediaSlug: 'coast-sunrise',
    pagePlan: [
      { path: 'index.html', title: 'Home', purpose: 'What this site is' },
      { path: 'about.html', title: 'About', purpose: 'Background and context' },
      { path: 'main-section.html', title: 'Main section', purpose: 'The heart of the site' },
      { path: 'extra.html', title: 'Extra page', purpose: 'Whatever your project needs' },
      { path: 'contact.html', title: 'Contact', purpose: 'A contact form' },
    ],
  },
];
