-- HTML Hero — course seed, part 1 of 11
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- This is the first part. Run it before any other.

begin;
-- HTML Hero — course seed data
--
-- GENERATED FILE. Do not edit by hand.
-- Source: src/content/**  ·  Regenerate: npm run seed:generate
--
-- 12 levels · 21 modules · 55 lessons
-- 664 content blocks · 105 exercises · 241 questions
-- 38 media assets · 22 achievements
-- Estimated learner time: 2163 minutes
--
-- This script is idempotent: running it again updates existing rows in place
-- rather than duplicating them, so content edits can be re-seeded safely.

begin;
-- Learner progress hangs off the catalogue by foreign key, and those keys
-- cascade. Deleting a lesson therefore deletes every learner's progress
-- through it, so rows a learner can reference are UPDATED IN PLACE by slug
-- and never dropped and rebuilt. Only child rows nothing owns are replaced
-- wholesale: blocks, requirements, options and join tables.
delete from public.lesson_blocks;
delete from public.exercise_requirements;
delete from public.quiz_options;
delete from public.module_skills;
delete from public.module_prerequisites;
delete from public.skill_prerequisites;
delete from public.media_attributions;
delete from public.learning_media;
-- --------------------------------------------------------------------------
-- Skills
-- --------------------------------------------------------------------------

insert into public.skills (slug, name, description, category, ordinal) values ('document-structure', 'Document structure', 'Building a valid HTML document: the doctype, the html, head and body elements, and the metadata a page needs to work.', 'Foundations', 1)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('syntax', 'Tags, elements and attributes', 'Writing well-formed markup: opening and closing tags, nesting, attributes, indentation and comments.', 'Foundations', 2)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('text-semantics', 'Text semantics', 'Choosing the element that matches the meaning of your text — headings, paragraphs, emphasis, quotations, dates, code and abbreviations.', 'Content', 3)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('lists', 'Lists and structured content', 'Marking up ordered, unordered and description lists, and nesting them correctly.', 'Content', 4)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('links', 'Links', 'Linking to pages, sections, email addresses and files, with link text that makes sense on its own.', 'Navigation', 5)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('navigation', 'Navigation and site architecture', 'Building consistent menus, breadcrumbs and skip links, and organising a project into folders that scale.', 'Navigation', 6)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('images', 'Images and alternative text', 'Placing images correctly, telling informative images apart from decorative ones, and writing alt text that carries the meaning.', 'Media', 7)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('responsive-images', 'Responsive images', 'Serving the right image for the screen with srcset, sizes and picture, including art direction and modern formats.', 'Media', 8)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('audio-video', 'Audio and video', 'Embedding accessible media with multiple sources, posters, controls, captions and fallback content.', 'Media', 9)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('embedded-content', 'Embedded content', 'Embedding third-party content safely with iframes, sandboxing and referrer policies.', 'Media', 10)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('semantic-html', 'Semantic HTML', 'Using header, nav, main, section, article, aside and footer to describe what a page means, not how it looks.', 'Structure', 11)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('multi-page', 'Multi-page architecture', 'Building a site of several pages with consistent structure, shared patterns and sensible file organisation.', 'Structure', 12)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('tables', 'Data tables', 'Marking up tabular data accessibly with caption, thead, scope, colspan and rowspan — and knowing when not to use a table.', 'Data', 13)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('forms', 'Forms', 'Building forms people can actually complete: labels, input types, grouping, validation attributes and accessible error messages.', 'Data', 14)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('native-interaction', 'Native interactive elements', 'Using details, summary, dialog, popover, progress, meter and datalist instead of reaching for JavaScript.', 'Interaction', 15)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('accessibility', 'Accessibility', 'Building pages that work with a keyboard and a screen reader: landmarks, names, focus order and WCAG 2.2 AA thinking.', 'Quality', 16)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('aria', 'ARIA fundamentals', 'Knowing the small set of ARIA attributes worth using, and knowing that correct HTML beats ARIA every time.', 'Quality', 17)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('metadata', 'Metadata', 'The head of a document: character encoding, viewport, titles, descriptions, canonical URLs, favicons and language.', 'Discoverability', 18)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('seo', 'On-page SEO', 'How HTML structure influences search visibility and social sharing — and what HTML cannot promise.', 'Discoverability', 19)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('structured-data', 'Structured data', 'Describing your content to machines with JSON-LD and basic schema.org types.', 'Discoverability', 20)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('performance', 'Performance-aware HTML', 'The markup decisions that make pages fast: dimensions, lazy loading, preload choices, script loading and resource hints.', 'Production', 21)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('security', 'Security awareness', 'Safe external links, iframe sandboxing, referrer policies, CSP basics, and why client-side validation is never enough.', 'Production', 22)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('validation', 'Validation', 'Reading validator output and fixing what it finds: nesting errors, unclosed tags, duplicate ids and bad attributes.', 'Craft', 23)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('debugging', 'Debugging and developer tools', 'Using browser developer tools to inspect the DOM, test keyboard navigation and find the cause of a problem.', 'Craft', 24)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('maintainability', 'Maintainable HTML', 'Code that another person — including future you — can read: consistent formatting, useful comments, reusable patterns and no needless containers.', 'Craft', 25)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('progressive-enhancement', 'Progressive enhancement', 'Building so the page works everywhere first, then improves where the browser supports more.', 'Production', 26)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('cascade', 'The cascade and specificity', 'Working out which rule wins and why: specificity, source order, importance and inheritance. The model everything else in CSS rests on.', 'CSS foundations', 27)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('selectors', 'Selectors', 'Targeting exactly the elements you mean — combinators, attribute selectors, pseudo-classes — without reaching for specificity you will regret.', 'CSS foundations', 28)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('box-model', 'The box model', 'How a box gets its size: content, padding, border, margin, box-sizing, and why two margins sometimes become one.', 'CSS foundations', 29)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('layout-flow', 'Flow, positioning and stacking', 'Normal flow, the display property, position, and the stacking contexts that decide what covers what.', 'CSS layout', 30)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('flexbox', 'Flexbox', 'One-dimensional layout: main and cross axes, growing, shrinking and distributing space.', 'CSS layout', 31)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('grid', 'Grid', 'Two-dimensional layout: tracks, areas, implicit rows, and the functions that make a grid responsive without a single media query.', 'CSS layout', 32)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('responsive', 'Responsive design', 'Layouts that adapt: fluid values, media queries, container queries, and choosing a breakpoint from the content rather than from a device.', 'CSS layout', 33)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('custom-properties', 'Custom properties', 'Design tokens that live in the cascade: declaring, inheriting, scoping and overriding values by name.', 'CSS craft', 34)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('typography', 'Typography and colour', 'Readable type and usable colour: scale, measure, line height, contrast and the parts of both that are accessibility requirements rather than taste.', 'CSS craft', 35)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('animation', 'Transitions and animation', 'Motion that helps rather than distracts — what is cheap to animate, what is not, and honouring a reduced-motion preference.', 'CSS craft', 36)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('css-architecture', 'CSS architecture', 'Naming, layering and scoping so a stylesheet stays workable at size, and so deleting a component deletes its CSS too.', 'CSS craft', 37)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skills (slug, name, description, category, ordinal) values ('css-debugging', 'Debugging CSS', 'Finding why a rule did not apply: the inspector, computed values, and the small set of causes behind almost every "this is not working".', 'CSS craft', 38)
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'text-semantics' and p.slug = 'syntax'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'lists' and p.slug = 'syntax'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'links' and p.slug = 'syntax'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'navigation' and p.slug = 'links'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'images' and p.slug = 'syntax'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'responsive-images' and p.slug = 'images'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'audio-video' and p.slug = 'images'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'embedded-content' and p.slug = 'audio-video'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'semantic-html' and p.slug = 'text-semantics'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'semantic-html' and p.slug = 'document-structure'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'multi-page' and p.slug = 'navigation'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'multi-page' and p.slug = 'semantic-html'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'tables' and p.slug = 'semantic-html'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'forms' and p.slug = 'semantic-html'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'native-interaction' and p.slug = 'forms'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'accessibility' and p.slug = 'semantic-html'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'accessibility' and p.slug = 'images'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'accessibility' and p.slug = 'forms'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'aria' and p.slug = 'accessibility'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'metadata' and p.slug = 'document-structure'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'seo' and p.slug = 'metadata'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'seo' and p.slug = 'text-semantics'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'structured-data' and p.slug = 'seo'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'performance' and p.slug = 'responsive-images'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'performance' and p.slug = 'metadata'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'security' and p.slug = 'embedded-content'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'security' and p.slug = 'forms'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'validation' and p.slug = 'syntax'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'debugging' and p.slug = 'validation'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'maintainability' and p.slug = 'semantic-html'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'progressive-enhancement' and p.slug = 'native-interaction'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'progressive-enhancement' and p.slug = 'accessibility'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'cascade' and p.slug = 'semantic-html'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'selectors' and p.slug = 'cascade'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'box-model' and p.slug = 'cascade'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'layout-flow' and p.slug = 'box-model'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'flexbox' and p.slug = 'layout-flow'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'grid' and p.slug = 'flexbox'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'responsive' and p.slug = 'grid'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'custom-properties' and p.slug = 'cascade'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'typography' and p.slug = 'custom-properties'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'animation' and p.slug = 'layout-flow'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'css-architecture' and p.slug = 'selectors'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'css-architecture' and p.slug = 'custom-properties'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'css-debugging' and p.slug = 'cascade'
  on conflict do nothing;
insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = 'css-debugging' and p.slug = 'box-model'
  on conflict do nothing;
-- --------------------------------------------------------------------------
-- Learning media and attributions
-- --------------------------------------------------------------------------

insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('coast-sunrise', 'photo', 'Sunrise over a quiet coast', 'A wide landscape scene: layered headlands behind a calm sea, with the rising sun laying a glittering path across the water.', '/learning-media/images/coast-sunrise.jpg',
   1200, 800, NULL,
   '[{"path":"/learning-media/images/coast-sunrise-480.jpg","type":"image/jpeg","width":480,"height":320},{"path":"/learning-media/images/coast-sunrise-800.jpg","type":"image/jpeg","width":800,"height":534},{"path":"/learning-media/images/coast-sunrise-1200.jpg","type":"image/jpeg","width":1200,"height":800},{"path":"/learning-media/images/coast-sunrise-1600.jpg","type":"image/jpeg","width":1600,"height":1067}]'::jsonb, '[{"path":"/learning-media/images/coast-sunrise-480.webp","type":"image/webp","width":480,"height":320},{"path":"/learning-media/images/coast-sunrise-800.webp","type":"image/webp","width":800,"height":534},{"path":"/learning-media/images/coast-sunrise-1200.webp","type":"image/webp","width":1200,"height":800},{"path":"/learning-media/images/coast-sunrise-1600.webp","type":"image/webp","width":1600,"height":1067}]'::jsonb,
   NULL, NULL, 'Sunrise over a calm sea, with low headlands silhouetted against an orange sky',
   false, ARRAY['landscape', 'nature', 'hero', 'travel']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'Sunrise over a quiet coast', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/images/coast-sunrise.jpg', '2026-07-27'::date, 'Rendered procedurally from code; not a photograph of a real place or person.'
from public.learning_media m where m.slug = 'coast-sunrise'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('forest-path', 'photo', 'Path through a bright forest', 'A sandy path leading between tall trees, with shafts of light coming through the canopy.', '/learning-media/images/forest-path.jpg',
   1200, 800, NULL,
   '[{"path":"/learning-media/images/forest-path-480.jpg","type":"image/jpeg","width":480,"height":320},{"path":"/learning-media/images/forest-path-800.jpg","type":"image/jpeg","width":800,"height":534},{"path":"/learning-media/images/forest-path-1200.jpg","type":"image/jpeg","width":1200,"height":800},{"path":"/learning-media/images/forest-path-1600.jpg","type":"image/jpeg","width":1600,"height":1067}]'::jsonb, '[{"path":"/learning-media/images/forest-path-480.webp","type":"image/webp","width":480,"height":320},{"path":"/learning-media/images/forest-path-800.webp","type":"image/webp","width":800,"height":534},{"path":"/learning-media/images/forest-path-1200.webp","type":"image/webp","width":1200,"height":800},{"path":"/learning-media/images/forest-path-1600.webp","type":"image/webp","width":1600,"height":1067}]'::jsonb,
   NULL, NULL, 'A narrow sandy path winding between tall trees in a sunlit forest',
   false, ARRAY['landscape', 'nature', 'hobby', 'outdoors']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'Path through a bright forest', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/images/forest-path.jpg', '2026-07-27'::date, 'Rendered procedurally from code; not a photograph of a real place or person.'
from public.learning_media m where m.slug = 'forest-path'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('city-dusk', 'photo', 'City skyline at dusk', 'A layered skyline of lit windows against a violet evening sky.', '/learning-media/images/city-dusk.jpg',
   1200, 800, NULL,
   '[{"path":"/learning-media/images/city-dusk-480.jpg","type":"image/jpeg","width":480,"height":320},{"path":"/learning-media/images/city-dusk-800.jpg","type":"image/jpeg","width":800,"height":534},{"path":"/learning-media/images/city-dusk-1200.jpg","type":"image/jpeg","width":1200,"height":800},{"path":"/learning-media/images/city-dusk-1600.jpg","type":"image/jpeg","width":1600,"height":1067}]'::jsonb, '[{"path":"/learning-media/images/city-dusk-480.webp","type":"image/webp","width":480,"height":320},{"path":"/learning-media/images/city-dusk-800.webp","type":"image/webp","width":800,"height":534},{"path":"/learning-media/images/city-dusk-1200.webp","type":"image/webp","width":1200,"height":800},{"path":"/learning-media/images/city-dusk-1600.webp","type":"image/webp","width":1600,"height":1067}]'::jsonb,
   NULL, NULL, 'A city skyline at dusk with hundreds of lit office windows',
   false, ARRAY['landscape', 'city', 'hero', 'news']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'City skyline at dusk', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/images/city-dusk.jpg', '2026-07-27'::date, 'Rendered procedurally from code; not a photograph of a real place or person.'
from public.learning_media m where m.slug = 'city-dusk'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('studio-desk', 'photo', 'A tidy studio desk', 'An open laptop, a notebook and a mug on a wooden desk in soft daylight — a calm working scene.', '/learning-media/images/studio-desk.jpg',
   1200, 800, NULL,
   '[{"path":"/learning-media/images/studio-desk-480.jpg","type":"image/jpeg","width":480,"height":320},{"path":"/learning-media/images/studio-desk-800.jpg","type":"image/jpeg","width":800,"height":534},{"path":"/learning-media/images/studio-desk-1200.jpg","type":"image/jpeg","width":1200,"height":800},{"path":"/learning-media/images/studio-desk-1600.jpg","type":"image/jpeg","width":1600,"height":1067}]'::jsonb, '[{"path":"/learning-media/images/studio-desk-480.webp","type":"image/webp","width":480,"height":320},{"path":"/learning-media/images/studio-desk-800.webp","type":"image/webp","width":800,"height":534},{"path":"/learning-media/images/studio-desk-1200.webp","type":"image/webp","width":1200,"height":800},{"path":"/learning-media/images/studio-desk-1600.webp","type":"image/webp","width":1600,"height":1067}]'::jsonb,
   NULL, NULL, 'An open laptop, a notebook and a coffee mug on a wooden desk',
   false, ARRAY['business', 'about', 'workspace', 'portfolio']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'A tidy studio desk', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/images/studio-desk.jpg', '2026-07-27'::date, 'Rendered procedurally from code; not a photograph of a real place or person.'
from public.learning_media m where m.slug = 'studio-desk'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('team-portrait', 'photo', 'Portrait of a team member', 'A stylised head-and-shoulders portrait on a blue background, for "meet the team" examples.', '/learning-media/images/team-portrait.jpg',
   1200, 1799, NULL,
   '[{"path":"/learning-media/images/team-portrait-480.jpg","type":"image/jpeg","width":480,"height":720},{"path":"/learning-media/images/team-portrait-800.jpg","type":"image/jpeg","width":800,"height":1200},{"path":"/learning-media/images/team-portrait-1200.jpg","type":"image/jpeg","width":1200,"height":1799},{"path":"/learning-media/images/team-portrait-1600.jpg","type":"image/jpeg","width":1600,"height":2399}]'::jsonb, '[{"path":"/learning-media/images/team-portrait-480.webp","type":"image/webp","width":480,"height":720},{"path":"/learning-media/images/team-portrait-800.webp","type":"image/webp","width":800,"height":1200},{"path":"/learning-media/images/team-portrait-1200.webp","type":"image/webp","width":1200,"height":1799},{"path":"/learning-media/images/team-portrait-1600.webp","type":"image/webp","width":1600,"height":2399}]'::jsonb,
   NULL, NULL, 'A head-and-shoulders portrait of a person in a dark jacket against a blue background',
   false, ARRAY['portrait', 'people', 'about', 'team']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'Portrait of a team member', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/images/team-portrait.jpg', '2026-07-27'::date, 'Rendered procedurally from code; not a photograph of a real place or person.'
from public.learning_media m where m.slug = 'team-portrait'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('product-bottle', 'photo', 'Product shot: ceramic bottle', 'A green ceramic bottle with a cork stopper on a plain studio backdrop.', '/learning-media/images/product-bottle.jpg',
   1200, 1200, NULL,
   '[{"path":"/learning-media/images/product-bottle-480.jpg","type":"image/jpeg","width":480,"height":480},{"path":"/learning-media/images/product-bottle-800.jpg","type":"image/jpeg","width":800,"height":800},{"path":"/learning-media/images/product-bottle-1200.jpg","type":"image/jpeg","width":1200,"height":1200},{"path":"/learning-media/images/product-bottle-1600.jpg","type":"image/jpeg","width":1600,"height":1600}]'::jsonb, '[{"path":"/learning-media/images/product-bottle-480.webp","type":"image/webp","width":480,"height":480},{"path":"/learning-media/images/product-bottle-800.webp","type":"image/webp","width":800,"height":800},{"path":"/learning-media/images/product-bottle-1200.webp","type":"image/webp","width":1200,"height":1200},{"path":"/learning-media/images/product-bottle-1600.webp","type":"image/webp","width":1600,"height":1600}]'::jsonb,
   NULL, NULL, 'A dark green ceramic bottle with a cork stopper, photographed on a plain grey background',
   false, ARRAY['product', 'shop', 'square', 'business']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'Product shot: ceramic bottle', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/images/product-bottle.jpg', '2026-07-27'::date, 'Rendered procedurally from code; not a photograph of a real place or person.'
from public.learning_media m where m.slug = 'product-bottle'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('workshop-tools', 'photo', 'A workshop wall of tools', 'Hand tools hanging in neat rows above a workbench — for local-service and trade examples.', '/learning-media/images/workshop-tools.jpg',
   1200, 800, NULL,
   '[{"path":"/learning-media/images/workshop-tools-480.jpg","type":"image/jpeg","width":480,"height":320},{"path":"/learning-media/images/workshop-tools-800.jpg","type":"image/jpeg","width":800,"height":534},{"path":"/learning-media/images/workshop-tools-1200.jpg","type":"image/jpeg","width":1200,"height":800},{"path":"/learning-media/images/workshop-tools-1600.jpg","type":"image/jpeg","width":1600,"height":1067}]'::jsonb, '[{"path":"/learning-media/images/workshop-tools-480.webp","type":"image/webp","width":480,"height":320},{"path":"/learning-media/images/workshop-tools-800.webp","type":"image/webp","width":800,"height":534},{"path":"/learning-media/images/workshop-tools-1200.webp","type":"image/webp","width":1200,"height":800},{"path":"/learning-media/images/workshop-tools-1600.webp","type":"image/webp","width":1600,"height":1067}]'::jsonb,
   NULL, NULL, 'Hand tools hanging in rows on a workshop wall above a wooden workbench',
   false, ARRAY['service', 'business', 'trade']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'A workshop wall of tools', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/images/workshop-tools.jpg', '2026-07-27'::date, 'Rendered procedurally from code; not a photograph of a real place or person.'
from public.learning_media m where m.slug = 'workshop-tools'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('restaurant-plate', 'photo', 'A plated dish, from above', 'An overhead view of a garnished dish on a white plate against a dark table.', '/learning-media/images/restaurant-plate.jpg',
   1200, 800, NULL,
   '[{"path":"/learning-media/images/restaurant-plate-480.jpg","type":"image/jpeg","width":480,"height":320},{"path":"/learning-media/images/restaurant-plate-800.jpg","type":"image/jpeg","width":800,"height":534},{"path":"/learning-media/images/restaurant-plate-1200.jpg","type":"image/jpeg","width":1200,"height":800},{"path":"/learning-media/images/restaurant-plate-1600.jpg","type":"image/jpeg","width":1600,"height":1067}]'::jsonb, '[{"path":"/learning-media/images/restaurant-plate-480.webp","type":"image/webp","width":480,"height":320},{"path":"/learning-media/images/restaurant-plate-800.webp","type":"image/webp","width":800,"height":534},{"path":"/learning-media/images/restaurant-plate-1200.webp","type":"image/webp","width":1200,"height":800},{"path":"/learning-media/images/restaurant-plate-1600.webp","type":"image/webp","width":1600,"height":1067}]'::jsonb,
   NULL, NULL, 'An overhead view of a colourful plated dish on a white plate',
   false, ARRAY['restaurant', 'food', 'menu']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'A plated dish, from above', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/images/restaurant-plate.jpg', '2026-07-27'::date, 'Rendered procedurally from code; not a photograph of a real place or person.'
from public.learning_media m where m.slug = 'restaurant-plate'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('event-stage', 'photo', 'A lit stage and audience', 'Coloured stage lights above a crowd, seen from the back of a venue.', '/learning-media/images/event-stage.jpg',
   1200, 800, NULL,
   '[{"path":"/learning-media/images/event-stage-480.jpg","type":"image/jpeg","width":480,"height":320},{"path":"/learning-media/images/event-stage-800.jpg","type":"image/jpeg","width":800,"height":534},{"path":"/learning-media/images/event-stage-1200.jpg","type":"image/jpeg","width":1200,"height":800},{"path":"/learning-media/images/event-stage-1600.jpg","type":"image/jpeg","width":1600,"height":1067}]'::jsonb, '[{"path":"/learning-media/images/event-stage-480.webp","type":"image/webp","width":480,"height":320},{"path":"/learning-media/images/event-stage-800.webp","type":"image/webp","width":800,"height":534},{"path":"/learning-media/images/event-stage-1200.webp","type":"image/webp","width":1200,"height":800},{"path":"/learning-media/images/event-stage-1600.webp","type":"image/webp","width":1600,"height":1067}]'::jsonb,
   NULL, NULL, 'A crowd silhouetted in front of a stage lit by pink and blue lights',
   false, ARRAY['event', 'music', 'hero']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'A lit stage and audience', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/images/event-stage.jpg', '2026-07-27'::date, 'Rendered procedurally from code; not a photograph of a real place or person.'
from public.learning_media m where m.slug = 'event-stage'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('vehicle-hire', 'photo', 'A hire car on an open road', 'A blue car in side profile on a road under a clear sky.', '/learning-media/images/vehicle-hire.jpg',
   1200, 800, NULL,
   '[{"path":"/learning-media/images/vehicle-hire-480.jpg","type":"image/jpeg","width":480,"height":320},{"path":"/learning-media/images/vehicle-hire-800.jpg","type":"image/jpeg","width":800,"height":534},{"path":"/learning-media/images/vehicle-hire-1200.jpg","type":"image/jpeg","width":1200,"height":800},{"path":"/learning-media/images/vehicle-hire-1600.jpg","type":"image/jpeg","width":1600,"height":1067}]'::jsonb, '[{"path":"/learning-media/images/vehicle-hire-480.webp","type":"image/webp","width":480,"height":320},{"path":"/learning-media/images/vehicle-hire-800.webp","type":"image/webp","width":800,"height":534},{"path":"/learning-media/images/vehicle-hire-1200.webp","type":"image/webp","width":1200,"height":800},{"path":"/learning-media/images/vehicle-hire-1600.webp","type":"image/webp","width":1600,"height":1067}]'::jsonb,
   NULL, NULL, 'A blue five-door car photographed side-on, parked on an open road',
   false, ARRAY['vehicle', 'rental', 'product']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'A hire car on an open road', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/images/vehicle-hire.jpg', '2026-07-27'::date, 'Rendered procedurally from code; not a photograph of a real place or person.'
from public.learning_media m where m.slug = 'vehicle-hire'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('newsroom-desk', 'photo', 'Scattered newspaper pages', 'Overlapping newspaper layouts, used for magazine and news-style examples.', '/learning-media/images/newsroom-desk.jpg',
   1200, 800, NULL,
   '[{"path":"/learning-media/images/newsroom-desk-480.jpg","type":"image/jpeg","width":480,"height":320},{"path":"/learning-media/images/newsroom-desk-800.jpg","type":"image/jpeg","width":800,"height":534},{"path":"/learning-media/images/newsroom-desk-1200.jpg","type":"image/jpeg","width":1200,"height":800},{"path":"/learning-media/images/newsroom-desk-1600.jpg","type":"image/jpeg","width":1600,"height":1067}]'::jsonb, '[{"path":"/learning-media/images/newsroom-desk-480.webp","type":"image/webp","width":480,"height":320},{"path":"/learning-media/images/newsroom-desk-800.webp","type":"image/webp","width":800,"height":534},{"path":"/learning-media/images/newsroom-desk-1200.webp","type":"image/webp","width":1200,"height":800},{"path":"/learning-media/images/newsroom-desk-1600.webp","type":"image/webp","width":1600,"height":1067}]'::jsonb,
   NULL, NULL, 'Several overlapping newspaper pages spread across a desk',
   false, ARRAY['news', 'magazine', 'editorial']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'Scattered newspaper pages', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/images/newsroom-desk.jpg', '2026-07-27'::date, 'Rendered procedurally from code; not a photograph of a real place or person.'
from public.learning_media m where m.slug = 'newsroom-desk'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('how-the-web-works', 'illustration', 'How a page reaches your screen', 'A browser asking a server for a page, and the server sending HTML back.', '/learning-media/svg/how-the-web-works.svg',
   NULL, NULL, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/svg/how-the-web-works.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, 'A browser window requesting a page from a server, which returns an HTML file',
   false, ARRAY['diagram', 'foundations']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'How a page reaches your screen', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/svg/how-the-web-works.svg', '2026-07-27'::date, 'Hand-authored SVG markup, written for this course.'
from public.learning_media m where m.slug = 'how-the-web-works'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('document-tree', 'illustration', 'The document tree', 'An HTML document drawn as a tree: html at the top, branching into head and body.', '/learning-media/svg/document-tree.svg',
   NULL, NULL, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/svg/document-tree.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, 'A tree diagram with html at the top branching into head and body, which branch into title, meta, h1 and p',
   false, ARRAY['diagram', 'structure', 'dom']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'The document tree', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/svg/document-tree.svg', '2026-07-27'::date, 'Hand-authored SVG markup, written for this course.'
from public.learning_media m where m.slug = 'document-tree'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('anatomy-of-an-element', 'illustration', 'Anatomy of an element', 'A labelled link showing the opening tag, attribute, content and closing tag.', '/learning-media/svg/anatomy-of-an-element.svg',
   NULL, NULL, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/svg/anatomy-of-an-element.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, 'A link element labelled to show its opening tag, href attribute, text content and closing tag',
   false, ARRAY['diagram', 'syntax']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'Anatomy of an element', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/svg/anatomy-of-an-element.svg', '2026-07-27'::date, 'Hand-authored SVG markup, written for this course.'
from public.learning_media m where m.slug = 'anatomy-of-an-element'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('heading-hierarchy', 'illustration', 'Heading hierarchy', 'Headings drawn as an indented outline from h1 down to h3.', '/learning-media/svg/heading-hierarchy.svg',
   NULL, NULL, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/svg/heading-hierarchy.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, 'An indented outline showing one h1, then h2 sections, each containing h3 subsections',
   false, ARRAY['diagram', 'text']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'Heading hierarchy', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/svg/heading-hierarchy.svg', '2026-07-27'::date, 'Hand-authored SVG markup, written for this course.'
from public.learning_media m where m.slug = 'heading-hierarchy'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('semantic-landmarks', 'illustration', 'Page landmarks', 'A page layout diagram labelling header, nav, main, article, aside and footer.', '/learning-media/svg/semantic-landmarks.svg',
   NULL, NULL, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/svg/semantic-landmarks.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, 'A page layout with labelled regions: header, nav, main containing an article, an aside, and a footer',
   false, ARRAY['diagram', 'semantics']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'Page landmarks', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/svg/semantic-landmarks.svg', '2026-07-27'::date, 'Hand-authored SVG markup, written for this course.'
from public.learning_media m where m.slug = 'semantic-landmarks'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('responsive-images', 'illustration', 'One image, several sizes', 'The same image served at three widths to a phone, a tablet and a desktop.', '/learning-media/svg/responsive-images.svg',
   NULL, NULL, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/svg/responsive-images.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, 'A phone, tablet and desktop screen each showing the same image at a different size',
   false, ARRAY['diagram', 'images', 'responsive']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'One image, several sizes', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/svg/responsive-images.svg', '2026-07-27'::date, 'Hand-authored SVG markup, written for this course.'
from public.learning_media m where m.slug = 'responsive-images'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('form-anatomy', 'illustration', 'How a label finds its input', 'A label and input joined by matching for and id values.', '/learning-media/svg/form-anatomy.svg',
   NULL, NULL, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/svg/form-anatomy.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, 'A label element with for="email" connected by an arrow to an input with id="email"',
   false, ARRAY['diagram', 'forms', 'accessibility']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'How a label finds its input', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/svg/form-anatomy.svg', '2026-07-27'::date, 'Hand-authored SVG markup, written for this course.'
from public.learning_media m where m.slug = 'form-anatomy'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('file-paths', 'illustration', 'Relative paths in a project', 'A folder tree with worked examples of relative paths from two different pages.', '/learning-media/svg/file-paths.svg',
   NULL, NULL, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/svg/file-paths.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, 'A folder tree showing index.html, an images folder and a projects folder, with example relative paths',
   false, ARRAY['diagram', 'paths', 'architecture']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'Relative paths in a project', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/svg/file-paths.svg', '2026-07-27'::date, 'Hand-authored SVG markup, written for this course.'
from public.learning_media m where m.slug = 'file-paths'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('table-structure', 'illustration', 'The parts of a data table', 'A table diagram labelling caption, thead, th scope values, tbody and tfoot.', '/learning-media/svg/table-structure.svg',
   NULL, NULL, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/svg/table-structure.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, 'A table diagram labelling the caption, header row of th cells, body rows of td cells and a footer row',
   false, ARRAY['diagram', 'tables']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'The parts of a data table', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/svg/table-structure.svg', '2026-07-27'::date, 'Hand-authored SVG markup, written for this course.'
from public.learning_media m where m.slug = 'table-structure'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('accessibility-tree', 'illustration', 'From HTML to the accessibility tree', 'How semantic HTML becomes the structure assistive technology reads aloud.', '/learning-media/svg/accessibility-tree.svg',
   NULL, NULL, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/svg/accessibility-tree.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, 'HTML elements on the left mapping to accessibility roles in the middle, read by a screen reader on the right',
   false, ARRAY['diagram', 'accessibility', 'aria']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'From HTML to the accessibility tree', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/svg/accessibility-tree.svg', '2026-07-27'::date, 'Hand-authored SVG markup, written for this course.'
from public.learning_media m where m.slug = 'accessibility-tree'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('placeholder', 'illustration', 'Neutral placeholder graphic', 'A plain grey placeholder. Used in lessons that teach *decorative* images, where alt="" is the correct answer.', '/learning-media/svg/placeholder.svg',
   NULL, NULL, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/svg/placeholder.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['decorative', 'placeholder']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'Neutral placeholder graphic', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/svg/placeholder.svg', '2026-07-27'::date, 'Hand-authored SVG markup, written for this course.'
from public.learning_media m where m.slug = 'placeholder'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('icon-home', 'icon', 'Home icon', 'A simple line icon of a home, drawn on a 24 by 24 grid.', '/learning-media/icons/home.svg',
   24, 24, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/icons/home.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['icon', 'ui', 'home']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'home icon', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/icons/home.svg', '2026-07-27'::date, 'Hand-authored SVG path data.'
from public.learning_media m where m.slug = 'icon-home'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('icon-mail', 'icon', 'Mail icon', 'A simple line icon of a mail, drawn on a 24 by 24 grid.', '/learning-media/icons/mail.svg',
   24, 24, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/icons/mail.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['icon', 'ui', 'mail']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'mail icon', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/icons/mail.svg', '2026-07-27'::date, 'Hand-authored SVG path data.'
from public.learning_media m where m.slug = 'icon-mail'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('icon-phone', 'icon', 'Phone icon', 'A simple line icon of a phone, drawn on a 24 by 24 grid.', '/learning-media/icons/phone.svg',
   24, 24, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/icons/phone.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['icon', 'ui', 'phone']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'phone icon', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/icons/phone.svg', '2026-07-27'::date, 'Hand-authored SVG path data.'
from public.learning_media m where m.slug = 'icon-phone'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('icon-map-pin', 'icon', 'Map pin icon', 'A simple line icon of a map pin, drawn on a 24 by 24 grid.', '/learning-media/icons/map-pin.svg',
   24, 24, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/icons/map-pin.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['icon', 'ui', 'map-pin']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'map pin icon', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/icons/map-pin.svg', '2026-07-27'::date, 'Hand-authored SVG path data.'
from public.learning_media m where m.slug = 'icon-map-pin'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('icon-clock', 'icon', 'Clock icon', 'A simple line icon of a clock, drawn on a 24 by 24 grid.', '/learning-media/icons/clock.svg',
   24, 24, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/icons/clock.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['icon', 'ui', 'clock']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'clock icon', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/icons/clock.svg', '2026-07-27'::date, 'Hand-authored SVG path data.'
from public.learning_media m where m.slug = 'icon-clock'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('icon-star', 'icon', 'Star icon', 'A simple line icon of a star, drawn on a 24 by 24 grid.', '/learning-media/icons/star.svg',
   24, 24, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/icons/star.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['icon', 'ui', 'star']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'star icon', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/icons/star.svg', '2026-07-27'::date, 'Hand-authored SVG path data.'
from public.learning_media m where m.slug = 'icon-star'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('icon-check', 'icon', 'Check icon', 'A simple line icon of a check, drawn on a 24 by 24 grid.', '/learning-media/icons/check.svg',
   24, 24, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/icons/check.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['icon', 'ui', 'check']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'check icon', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/icons/check.svg', '2026-07-27'::date, 'Hand-authored SVG path data.'
from public.learning_media m where m.slug = 'icon-check'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('icon-search', 'icon', 'Search icon', 'A simple line icon of a search, drawn on a 24 by 24 grid.', '/learning-media/icons/search.svg',
   24, 24, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/icons/search.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['icon', 'ui', 'search']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'search icon', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/icons/search.svg', '2026-07-27'::date, 'Hand-authored SVG path data.'
from public.learning_media m where m.slug = 'icon-search'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('icon-menu', 'icon', 'Menu icon', 'A simple line icon of a menu, drawn on a 24 by 24 grid.', '/learning-media/icons/menu.svg',
   24, 24, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/icons/menu.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['icon', 'ui', 'menu']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'menu icon', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/icons/menu.svg', '2026-07-27'::date, 'Hand-authored SVG path data.'
from public.learning_media m where m.slug = 'icon-menu'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('icon-download', 'icon', 'Download icon', 'A simple line icon of a download, drawn on a 24 by 24 grid.', '/learning-media/icons/download.svg',
   24, 24, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/icons/download.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['icon', 'ui', 'download']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'download icon', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/icons/download.svg', '2026-07-27'::date, 'Hand-authored SVG path data.'
from public.learning_media m where m.slug = 'icon-download'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('icon-play', 'icon', 'Play icon', 'A simple line icon of a play, drawn on a 24 by 24 grid.', '/learning-media/icons/play.svg',
   24, 24, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/icons/play.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['icon', 'ui', 'play']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'play icon', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/icons/play.svg', '2026-07-27'::date, 'Hand-authored SVG path data.'
from public.learning_media m where m.slug = 'icon-play'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('icon-calendar', 'icon', 'Calendar icon', 'A simple line icon of a calendar, drawn on a 24 by 24 grid.', '/learning-media/icons/calendar.svg',
   24, 24, NULL,
   '[]'::jsonb, '[{"path":"/learning-media/icons/calendar.svg","type":"image/svg+xml"}]'::jsonb,
   NULL, NULL, '',
   true, ARRAY['icon', 'ui', 'calendar']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'calendar icon', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/icons/calendar.svg', '2026-07-27'::date, 'Hand-authored SVG path data.'
from public.learning_media m where m.slug = 'icon-calendar'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('page-anatomy', 'video', 'How an HTML page is built', 'A 10-second explainer: a document is typed out tag by tag while the browser preview assembles alongside it.', '/learning-media/video/page-anatomy.mp4',
   1280, 720, 10,
   '[]'::jsonb, '[{"path":"/learning-media/video/page-anatomy.webm","type":"video/webm","width":1280,"height":720},{"path":"/learning-media/video/page-anatomy.mp4","type":"video/mp4","width":1280,"height":720}]'::jsonb,
   '/learning-media/posters/page-anatomy.jpg', '/learning-media/captions/page-anatomy.en.vtt', 'A short animation showing HTML being typed and the resulting page appearing',
   false, ARRAY['video', 'foundations', 'explainer']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'How an HTML page is built', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/video/page-anatomy.mp4', '2026-07-27'::date, 'Frames rendered with Pillow and encoded with ffmpeg by this repository.'
from public.learning_media m where m.slug = 'page-anatomy'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('responsive-layout', 'video', 'One page, every screen size', 'An 11-second explainer showing a card layout reflowing as the viewport narrows.', '/learning-media/video/responsive-layout.mp4',
   1280, 720, 11,
   '[]'::jsonb, '[{"path":"/learning-media/video/responsive-layout.webm","type":"video/webm","width":1280,"height":720},{"path":"/learning-media/video/responsive-layout.mp4","type":"video/mp4","width":1280,"height":720}]'::jsonb,
   '/learning-media/posters/responsive-layout.jpg', '/learning-media/captions/responsive-layout.en.vtt', 'A short animation of a page layout changing from three columns to one as the window narrows',
   false, ARRAY['video', 'responsive', 'explainer']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'One page, every screen size', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/video/responsive-layout.mp4', '2026-07-27'::date, 'Frames rendered with Pillow and encoded with ffmpeg by this repository.'
from public.learning_media m where m.slug = 'responsive-layout'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('welcome-chime', 'audio', 'Welcome chime', 'A three-second bell chime, synthesised from a major triad. Useful for short <audio> examples.', '/learning-media/audio/welcome-chime.mp3',
   NULL, NULL, 3,
   '[]'::jsonb, '[{"path":"/learning-media/audio/welcome-chime.mp3","type":"audio/mpeg"},{"path":"/learning-media/audio/welcome-chime.wav","type":"audio/wav"}]'::jsonb,
   NULL, NULL, '',
   false, ARRAY['audio', 'ui', 'short']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'Welcome chime', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/audio/welcome-chime.mp3', '2026-07-27'::date, 'Synthesised from a mathematical expression; contains no recorded material.'
from public.learning_media m where m.slug = 'welcome-chime'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  ('calm-loop', 'audio', 'Calm ambient loop', 'An eight-second ambient tone that loops cleanly. Useful for demonstrating <audio> controls.', '/learning-media/audio/calm-loop.mp3',
   NULL, NULL, 8,
   '[]'::jsonb, '[{"path":"/learning-media/audio/calm-loop.mp3","type":"audio/mpeg"},{"path":"/learning-media/audio/calm-loop.wav","type":"audio/wav"}]'::jsonb,
   NULL, NULL, '',
   false, ARRAY['audio', 'ambient', 'loop']::text[])
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;
insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, 'Calm ambient loop', 'HTML Hero (generated by scripts/generate_media.py)', 'Created for this project', NULL, 'CC0-1.0 (public domain dedication)',
       'https://creativecommons.org/publicdomain/zero/1.0/', 'Original artwork created for HTML Hero and released under CC0-1.0. No attribution is required, but it is welcome.', '/learning-media/audio/calm-loop.mp3', '2026-07-27'::date, 'Synthesised from a mathematical expression; contains no recorded material.'
from public.learning_media m where m.slug = 'calm-loop'
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;
-- --------------------------------------------------------------------------
-- Capstone project templates
-- --------------------------------------------------------------------------

insert into public.project_templates (slug, name, tagline, description, audience, hero_media_slug, page_plan, ordinal)
values ('personal-portfolio', 'Personal portfolio', 'Show what you can do, to people who might hire you', 'A site about you and your work. Strong on structure, images and a contact form — and the most directly useful outcome if you are learning to change career.',
        'Employers, clients and collaborators', 'studio-desk', '[{"path":"index.html","title":"Home","purpose":"Who you are and what you do, in one screen"},{"path":"about.html","title":"About","purpose":"Your background, skills and approach"},{"path":"projects.html","title":"Projects","purpose":"Your work, with images and short case studies"},{"path":"projects/case-study.html","title":"Case study","purpose":"One project in depth"},{"path":"contact.html","title":"Contact","purpose":"A form and your details"}]'::jsonb, 1)
on conflict (slug) do update set
  name = excluded.name, tagline = excluded.tagline, description = excluded.description,
  audience = excluded.audience, hero_media_slug = excluded.hero_media_slug,
  page_plan = excluded.page_plan, ordinal = excluded.ordinal;
insert into public.project_templates (slug, name, tagline, description, audience, hero_media_slug, page_plan, ordinal)
values ('small-business', 'Small business website', 'The site every local business actually needs', 'Homepage, services, about, contact. Covers the full range of the course — tables for pricing, forms for enquiries, structured data for local search.',
        'Local customers looking for a service', 'city-dusk', '[{"path":"index.html","title":"Home","purpose":"What you offer and how to get it"},{"path":"about.html","title":"About","purpose":"The story and the people"},{"path":"services.html","title":"Services","purpose":"What you do, with a pricing table"},{"path":"faq.html","title":"FAQ","purpose":"Common questions, as a details accordion"},{"path":"contact.html","title":"Contact","purpose":"An enquiry form and your address"}]'::jsonb, 2)
on conflict (slug) do update set
  name = excluded.name, tagline = excluded.tagline, description = excluded.description,
  audience = excluded.audience, hero_media_slug = excluded.hero_media_slug,
  page_plan = excluded.page_plan, ordinal = excluded.ordinal;
insert into public.project_templates (slug, name, tagline, description, audience, hero_media_slug, page_plan, ordinal)
values ('local-service', 'Local service website', 'A trade or service business with a service area', 'A plumber, electrician, gardener or cleaner. Heavy on trust signals, opening hours and a booking form — with structured data for local search results.',
        'People searching for a nearby tradesperson', 'workshop-tools', '[{"path":"index.html","title":"Home","purpose":"What you do and the areas you cover"},{"path":"about.html","title":"About","purpose":"Experience, qualifications and accreditations"},{"path":"services.html","title":"Services","purpose":"Each service with an indicative price"},{"path":"areas.html","title":"Areas covered","purpose":"Where you work, as a list or table"},{"path":"contact.html","title":"Contact","purpose":"A booking form with date and time"}]'::jsonb, 3)
on conflict (slug) do update set
  name = excluded.name, tagline = excluded.tagline, description = excluded.description,
  audience = excluded.audience, hero_media_slug = excluded.hero_media_slug,
  page_plan = excluded.page_plan, ordinal = excluded.ordinal;
insert into public.project_templates (slug, name, tagline, description, audience, hero_media_slug, page_plan, ordinal)
values ('restaurant', 'Restaurant website', 'Menu, hours, booking', 'A restaurant, café or takeaway. The menu is an excellent exercise in list and heading structure, and opening hours make a genuinely useful table.',
        'People deciding where to eat tonight', 'restaurant-plate', '[{"path":"index.html","title":"Home","purpose":"What kind of place this is"},{"path":"menu.html","title":"Menu","purpose":"Courses as structured lists with prices"},{"path":"about.html","title":"About","purpose":"The kitchen, the sourcing, the people"},{"path":"hours.html","title":"Opening hours","purpose":"A properly marked-up hours table"},{"path":"book.html","title":"Book a table","purpose":"A booking form with date, time and party size"}]'::jsonb, 4)
on conflict (slug) do update set
  name = excluded.name, tagline = excluded.tagline, description = excluded.description,
  audience = excluded.audience, hero_media_slug = excluded.hero_media_slug,
  page_plan = excluded.page_plan, ordinal = excluded.ordinal;
insert into public.project_templates (slug, name, tagline, description, audience, hero_media_slug, page_plan, ordinal)
values ('hobby-site', 'Hobby or interest website', 'Write about something you actually care about', 'A site about a hobby, a collection, a club or a subject you know well. The easiest to write real content for, which makes the structural decisions clearer.',
        'Other people interested in the same thing', 'forest-path', '[{"path":"index.html","title":"Home","purpose":"What this site covers"},{"path":"guide.html","title":"Beginner guide","purpose":"A long article with a full heading hierarchy"},{"path":"gallery.html","title":"Gallery","purpose":"Figures with captions and responsive images"},{"path":"resources.html","title":"Resources","purpose":"Curated links with descriptive link text"},{"path":"contact.html","title":"Contact","purpose":"A simple contact form"}]'::jsonb, 5)
on conflict (slug) do update set
  name = excluded.name, tagline = excluded.tagline, description = excluded.description,
  audience = excluded.audience, hero_media_slug = excluded.hero_media_slug,
  page_plan = excluded.page_plan, ordinal = excluded.ordinal;
insert into public.project_templates (slug, name, tagline, description, audience, hero_media_slug, page_plan, ordinal)
values ('vehicle-rental', 'Vehicle-rental website', 'A fleet, rates and a booking form', 'Car, van, bike or boat hire. Strong on tables for rates, forms for booking, and image galleries for the fleet.',
        'People who need a vehicle for a few days', 'vehicle-hire', '[{"path":"index.html","title":"Home","purpose":"What you hire and how it works"},{"path":"fleet.html","title":"Our fleet","purpose":"Each vehicle as an article with images"},{"path":"rates.html","title":"Rates","purpose":"A rates table with row and column headings"},{"path":"terms.html","title":"Terms","purpose":"Hire conditions as a description list"},{"path":"book.html","title":"Book","purpose":"A booking form with dates and vehicle choice"}]'::jsonb, 6)
on conflict (slug) do update set
  name = excluded.name, tagline = excluded.tagline, description = excluded.description,
  audience = excluded.audience, hero_media_slug = excluded.hero_media_slug,
  page_plan = excluded.page_plan, ordinal = excluded.ordinal;
insert into public.project_templates (slug, name, tagline, description, audience, hero_media_slug, page_plan, ordinal)
values ('product-showcase', 'Product showcase website', 'One product, presented properly', 'A single product or small range. Excellent for responsive images, specification tables and structured data.',
        'People deciding whether to buy', 'product-bottle', '[{"path":"index.html","title":"Home","purpose":"The product and why it exists"},{"path":"features.html","title":"Features","purpose":"What it does, in structured sections"},{"path":"specifications.html","title":"Specifications","purpose":"A specification table"},{"path":"faq.html","title":"FAQ","purpose":"Questions as a details accordion"},{"path":"contact.html","title":"Contact","purpose":"An enquiry form"}]'::jsonb, 7)
on conflict (slug) do update set
  name = excluded.name, tagline = excluded.tagline, description = excluded.description,
  audience = excluded.audience, hero_media_slug = excluded.hero_media_slug,
  page_plan = excluded.page_plan, ordinal = excluded.ordinal;
insert into public.project_templates (slug, name, tagline, description, audience, hero_media_slug, page_plan, ordinal)
values ('news-magazine', 'News or magazine-style website', 'Articles, sections and a real editorial structure', 'The best choice for practising article semantics, heading hierarchy, dates, quotations and citations.',
        'Readers looking for the latest on a subject', 'newsroom-desk', '[{"path":"index.html","title":"Home","purpose":"Latest articles as a list of article elements"},{"path":"articles/feature.html","title":"Feature article","purpose":"A long article with quotations and dates"},{"path":"about.html","title":"About","purpose":"Who publishes this and why"},{"path":"archive.html","title":"Archive","purpose":"Past articles, grouped by date"},{"path":"contact.html","title":"Contact","purpose":"A tip-off or letters form"}]'::jsonb, 8)
on conflict (slug) do update set
  name = excluded.name, tagline = excluded.tagline, description = excluded.description,
  audience = excluded.audience, hero_media_slug = excluded.hero_media_slug,
  page_plan = excluded.page_plan, ordinal = excluded.ordinal;
insert into public.project_templates (slug, name, tagline, description, audience, hero_media_slug, page_plan, ordinal)
values ('event-site', 'Event website', 'Dates, programme, venue, tickets', 'A conference, festival, wedding or club night. Strong on time elements, schedule tables and registration forms.',
        'People deciding whether to attend', 'event-stage', '[{"path":"index.html","title":"Home","purpose":"What, when and where"},{"path":"programme.html","title":"Programme","purpose":"A schedule table with time elements"},{"path":"speakers.html","title":"Speakers","purpose":"Each speaker as an article with a portrait"},{"path":"venue.html","title":"Venue","purpose":"Directions, an embedded map and accessibility information"},{"path":"register.html","title":"Register","purpose":"A registration form"}]'::jsonb, 9)
on conflict (slug) do update set
  name = excluded.name, tagline = excluded.tagline, description = excluded.description,
  audience = excluded.audience, hero_media_slug = excluded.hero_media_slug,
  page_plan = excluded.page_plan, ordinal = excluded.ordinal;
insert into public.project_templates (slug, name, tagline, description, audience, hero_media_slug, page_plan, ordinal)
values ('custom', 'Custom project', 'Something else entirely', 'Bring your own idea. You will get the same five-page structure and the same missions; you decide what the pages are about.',
        'Whoever your project is for', 'coast-sunrise', '[{"path":"index.html","title":"Home","purpose":"What this site is"},{"path":"about.html","title":"About","purpose":"Background and context"},{"path":"main-section.html","title":"Main section","purpose":"The heart of the site"},{"path":"extra.html","title":"Extra page","purpose":"Whatever your project needs"},{"path":"contact.html","title":"Contact","purpose":"A contact form"}]'::jsonb, 10)
on conflict (slug) do update set
  name = excluded.name, tagline = excluded.tagline, description = excluded.description,
  audience = excluded.audience, hero_media_slug = excluded.hero_media_slug,
  page_plan = excluded.page_plan, ordinal = excluded.ordinal;
-- --------------------------------------------------------------------------
-- Achievements
-- --------------------------------------------------------------------------

insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('first-html-page', 'First HTML Page', 'You wrote a complete, valid HTML document from an empty file.', 'star',
        'bronze', '{"type":"module_completed","moduleSlug":"the-html-skeleton"}'::jsonb, 60, 1)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('document-architect', 'Document Architect', 'You mastered document structure — doctype, head, body and metadata.', 'home',
        'bronze', '{"type":"skill_mastered","skillSlug":"document-structure"}'::jsonb, 80, 2)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('wordsmith', 'Wordsmith', 'You mastered text semantics: the right element for every kind of content.', 'check',
        'bronze', '{"type":"skill_mastered","skillSlug":"text-semantics"}'::jsonb, 80, 3)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('navigation-builder', 'Navigation Builder', 'You connected a multi-page site with consistent, accessible navigation.', 'map-pin',
        'silver', '{"type":"level_completed","levelSlug":"navigation-architect"}'::jsonb, 120, 4)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('media-specialist', 'Media Specialist', 'You built a media-rich page with accessible video and correct fallbacks.', 'play',
        'silver', '{"type":"level_completed","levelSlug":"media-specialist"}'::jsonb, 120, 5)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('responsive-image-expert', 'Responsive Image Expert', 'You mastered srcset, sizes and picture — the right image for every screen.', 'search',
        'silver', '{"type":"skill_mastered","skillSlug":"responsive-images"}'::jsonb, 120, 6)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('semantic-professional', 'Semantic HTML Professional', 'You mastered semantic structure and landmarks.', 'menu',
        'silver', '{"type":"skill_mastered","skillSlug":"semantic-html"}'::jsonb, 140, 7)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('form-engineer', 'Form Engineer', 'You built a professional, accessible form with real validation.', 'mail',
        'silver', '{"type":"skill_mastered","skillSlug":"forms"}'::jsonb, 140, 8)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('table-craftsman', 'Table Craftsman', 'You built data tables a screen-reader user can actually navigate.', 'calendar',
        'silver', '{"type":"skill_mastered","skillSlug":"tables"}'::jsonb, 120, 9)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('no-javascript-needed', 'No JavaScript Needed', 'You built interactive features using nothing but HTML.', 'check',
        'silver', '{"type":"level_completed","levelSlug":"native-interaction"}'::jsonb, 140, 10)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('accessibility-champion', 'Accessibility Champion', 'You audited and repaired an inaccessible site, and mastered accessible HTML.', 'star',
        'gold', '{"type":"skill_mastered","skillSlug":"accessibility"}'::jsonb, 200, 11)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('metadata-master', 'Metadata Master', 'You mastered titles, descriptions, social metadata and structured data.', 'search',
        'gold', '{"type":"level_completed","levelSlug":"metadata-and-seo"}'::jsonb, 180, 12)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('debugging-detective', 'Debugging Detective', 'You repaired ten debugging challenges.', 'search',
        'gold', '{"type":"debug_challenges","count":10}'::jsonb, 180, 13)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('validation-expert', 'Validation Expert', 'You mastered validation — invalid markup no longer gets past you.', 'check',
        'gold', '{"type":"skill_mastered","skillSlug":"validation"}'::jsonb, 180, 14)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('multi-page-builder', 'Multi-Page Builder', 'Your capstone site reached five complete pages.', 'home',
        'gold', '{"type":"project_pages","count":5}'::jsonb, 200, 15)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('first-pass', 'Clean First Attempt', 'You passed five exercises in a row first time, with no hints.', 'star',
        'silver', '{"type":"first_pass_streak","count":5}'::jsonb, 120, 16)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('steady-week', 'Steady Week', 'You studied on seven consecutive days.', 'calendar',
        'bronze', '{"type":"streak_days","days":7}'::jsonb, 80, 17)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('three-week-habit', 'Three-Week Habit', 'A twenty-one day streak. This is what learning to code actually looks like.', 'calendar',
        'gold', '{"type":"streak_days","days":21}'::jsonb, 220, 18)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('half-way', 'Half Way', 'You completed thirty lessons.', 'clock',
        'silver', '{"type":"lessons_completed","count":30}'::jsonb, 140, 19)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('practice-makes-permanent', 'Practice Makes Permanent', 'You passed fifty coding exercises.', 'check',
        'gold', '{"type":"exercises_passed","count":50}'::jsonb, 200, 20)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('well-rounded', 'Well Rounded', 'You mastered fifteen separate skills.', 'star',
        'gold', '{"type":"skills_mastered","count":15}'::jsonb, 240, 21)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values ('html-hero', 'HTML Hero', 'You completed the entire course and shipped a professional multi-page website. This is the one that matters.', 'star',
        'platinum', '{"type":"course_complete"}'::jsonb, 800, 22)
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;
-- --------------------------------------------------------------------------
-- Courses
-- --------------------------------------------------------------------------

insert into public.courses
  (slug, title, subtitle, description, outcome, ordinal, accent, is_published,
   recommended_days, recommended_minutes_per_day, version)
values ('html-hero', 'HTML Hero', 'From complete beginner to production-quality HTML', 'A mastery-based journey through modern HTML. Twelve levels, each unlocked by demonstrated understanding rather than elapsed time. You build one real website throughout, and finish able to build, validate, improve, export and publish a professional multi-page site.',
        'You can build, validate, improve, export and publish a professional multi-page website in modern HTML.', 1, 'blue', true,
        30, 60, '1.0.0')
on conflict (slug) do update set
  title = excluded.title, subtitle = excluded.subtitle, description = excluded.description,
  outcome = excluded.outcome, ordinal = excluded.ordinal, accent = excluded.accent,
  is_published = excluded.is_published,
  recommended_days = excluded.recommended_days,
  recommended_minutes_per_day = excluded.recommended_minutes_per_day,
  version = excluded.version;
insert into public.courses
  (slug, title, subtitle, description, outcome, ordinal, accent, is_published,
   recommended_days, recommended_minutes_per_day, version)
values ('css-architect', 'CSS Architect', 'From "why is this not working" to layouts you can reason about', 'A mastery-based journey through modern CSS. It starts with the cascade rather than ending with it, because almost every hour lost to CSS is really a cascade misunderstanding. You style the site you built in the HTML course, and finish able to build responsive, maintainable layouts and explain exactly why each rule applies.',
        'You can style a complete multi-page site with modern CSS, and explain why every rule in it wins or loses.', 2, 'violet', false,
        30, 60, '0.1.0')
on conflict (slug) do update set
  title = excluded.title, subtitle = excluded.subtitle, description = excluded.description,
  outcome = excluded.outcome, ordinal = excluded.ordinal, accent = excluded.accent,
  is_published = excluded.is_published,
  recommended_days = excluded.recommended_days,
  recommended_minutes_per_day = excluded.recommended_minutes_per_day,
  version = excluded.version;
-- Cross-course prerequisites: CSS rests on HTML.
delete from public.course_prerequisites;
insert into public.course_prerequisites (course_id, prerequisite_course_id)
select c.id, p.id from public.courses c, public.courses p
where c.slug = 'css-architect' and p.slug = 'html-hero'
on conflict do nothing;
-- --------------------------------------------------------------------------
-- HTML Hero — Level 1: HTML Explorer
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'html-explorer', 1, 'HTML Explorer', 'From "I have never written code" to a real, valid web page',
       'Every word in this level is explained before it is used. You will learn what a browser actually does, what an HTML file is, and how to write one that a browser understands.', 'You can write a correctly structured HTML page from a blank file, from memory.', 'blue'
from public.courses c where c.slug = 'html-hero'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-1-milestone', 'milestone'::public.assessment_kind, 'Level 1 milestone: HTML Explorer', 'Ten questions covering everything in Level 1. You need 75% to move on. If you do not reach it, the questions you missed become targeted practice — nothing is lost.',
       0.75, 150, 1
from public.levels l where l.slug = 'html-explorer'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: How the web actually works
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'how-the-web-works', 1, 'How the web actually works', 'Before writing anything, a short, plain-English picture of what happens between clicking a link and seeing a page.',
       35, false
from public.levels l where l.slug = 'html-explorer'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'how-the-web-works' and s.slug = 'document-structure';
-- lesson: What happens when you open a web page
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'what-happens-when-you-open-a-page', 1, 'What happens when you open a web page', 'Browsers, servers, and the file in the middle', 'A web page is a text file that one computer sends to another. Understanding that one sentence makes everything else easier.',
       ARRAY['Explain in your own words what a browser does', 'Describe what a web server sends when you visit a page', 'Recognise HTML as plain text, not a picture of a page']::text[], 12, 40, (select id from public.skills where slug = 'document-structure'), 0.7
from public.modules m where m.slug = 'how-the-web-works'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Explain what a browser does with a web page","Describe what travels across the internet when you visit a site","Recognise that HTML is ordinary text you can read and write"]}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'When you type an address into a browser and press Enter, your computer asks another computer for a file. That other computer sends the file back. Your browser then reads the file and draws it on your screen. That is the whole story — everything else is detail.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Browser', 'The program you use to look at websites — Chrome, Firefox, Safari, Edge. Its job is to fetch files and turn them into something you can see and click.',
       NULL, NULL, NULL, '{"example":"Chrome, Firefox, Safari and Edge are all browsers."}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Server', 'A computer, somewhere else, whose job is to hold files and hand them out when asked. Nothing mysterious — just a computer that is always switched on.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'visual'::public.block_type, NULL, 'Your browser asks. A server answers with a file. Your browser draws what the file describes.',
       NULL, NULL, 'how-the-web-works', '{}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'prose'::public.block_type, NULL, 'The file that comes back is written in HTML. HTML is plain text — the same kind of text you could type into any notepad app. It contains the words of the page plus small labels that say what each piece of text *is*: a heading, a paragraph, a link, an image.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'term'::public.block_type, 'HTML', 'HyperText Markup Language. "Markup" means you take ordinary text and mark parts of it up with labels. Those labels tell the browser what each part means.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'callout'::public.block_type, 'HTML is not a programming language', 'Programming languages make decisions and do calculations. HTML does neither. HTML describes structure and meaning: "this is a heading", "this is a list", "this is a photograph of a bicycle". That is a genuine relief — there is far less to learn than people expect.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'code_example'::public.block_type, 'What HTML actually looks like', NULL,
       '<h1>Fresh bread, every morning</h1>
<p>We open at 6am and bake until we sell out.</p>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'prose'::public.block_type, NULL, 'Above, `<h1>` marks the most important heading on the page and `<p>` marks a paragraph. The browser reads those labels and decides that the heading should be big and bold and the paragraph should be normal-sized. You never had to say "make it big" — you said what it *was*, and the browser did the rest.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'What about CSS and JavaScript?', 'A finished website usually involves three languages. HTML describes the structure and meaning. CSS controls the appearance — colours, spacing, layout. JavaScript adds behaviour — things that respond and change. This course is about HTML, which is the foundation the other two are attached to. While you learn, HTML Hero supplies a professional stylesheet for your previews so your work looks good without you needing to know any CSS yet. You will see exactly where that boundary sits, clearly labelled, on every preview.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'interactive_demo'::public.block_type, 'The same words, with and without labels', 'This is the whole idea of HTML, in two panels.',
       NULL, NULL, NULL, '{"variants":[{"label":"Plain text","code":"Fresh bread, every morning\nWe open at 6am and bake until we sell out.","note":"The browser has been told nothing about what these words are, so it runs them together as one undifferentiated block."},{"label":"With labels","code":"<h1>Fresh bread, every morning</h1>\n<p>We open at 6am and bake until we sell out.</p>","note":"Identical words. The labels say what each part *is*, and the browser decides how to show it — larger and bolder for the heading, normal for the paragraph."}]}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["A browser fetches a file from a server and draws it on screen.","That file is HTML: ordinary text with labels around parts of it.","The labels say what a piece of content *means*, and the browser decides how to display it.","HTML is not a programming language — it describes, it does not calculate."],"nextUp":"Next: the file itself, and the tool you write it in."}'::jsonb
from public.lessons where slug = 'what-happens-when-you-open-a-page';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'first-markup-guided', 1, 'guided'::public.exercise_kind, 'Label two pieces of text',
       'The editor below contains two lines of plain text with no labels. Wrap the first line in an `<h1>` element so the browser knows it is the main heading, and wrap the second in a `<p>` element so it knows it is a paragraph. Press "Check my work" when you are done, then watch the preview change.', 'Fresh bread, every morning
We open at 6am and bake until we sell out.', '<h1>Fresh bread, every morning</h1>
<p>We open at 6am and bake until we sell out.</p>', ARRAY['A label goes before and after the text it applies to. The one before is written <h1> and the one after is written </h1> — note the slash.', 'So the first line becomes: <h1>Fresh bread, every morning</h1>', 'Do the same for the second line, but with p instead of h1: <p>We open at 6am and bake until we sell out.</p>']::text[],
       30, 1,
       (select id from public.skills where slug = 'syntax'), false
from public.lessons l where l.slug = 'what-happens-when-you-open-a-page'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one <h1> heading', NULL, 1, true, NULL
from public.exercises e where e.slug = 'first-markup-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'text_not_empty'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'The heading has text inside it', NULL, 1, true, NULL
from public.exercises e where e.slug = 'first-markup-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'element_present'::public.requirement_kind, 'p', NULL,
       NULL, NULL, NULL, NULL,
       'There is a paragraph', NULL, 1, true, NULL
from public.exercises e where e.slug = 'first-markup-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'text_not_empty'::public.requirement_kind, 'p', NULL,
       NULL, NULL, NULL, NULL,
       'The paragraph has text inside it', NULL, 1, true, NULL
from public.exercises e where e.slug = 'first-markup-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'first-markup-debug', 2, 'debug'::public.exercise_kind, 'Find the missing slash',
       'This markup nearly works, but one closing label is wrong, so the browser swallows the rest of the page. Find it and fix it. The preview will tell you when you have got it.', '<h1>Riverside Cycle Hire<h1>
<p>Bikes, helmets and route maps, seven days a week.</p>', '<h1>Riverside Cycle Hire</h1>
<p>Bikes, helmets and route maps, seven days a week.</p>', ARRAY['Look carefully at the two h1 labels. One of them is meant to close the heading.', 'A closing label always has a forward slash after the opening angle bracket: </h1>']::text[],
       25, 1,
       (select id from public.skills where slug = 'syntax'), false
from public.lessons l where l.slug = 'what-happens-when-you-open-a-page'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one <h1>, correctly closed', NULL, 1, true, NULL
from public.exercises e where e.slug = 'first-markup-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'element_present'::public.requirement_kind, 'p', NULL,
       NULL, NULL, NULL, NULL,
       'The paragraph survives outside the heading', NULL, 1, true, NULL
from public.exercises e where e.slug = 'first-markup-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'text_content'::public.requirement_kind, 'p', NULL,
       'Bikes', NULL, NULL, NULL,
       'The paragraph text is still in the paragraph', NULL, 1, true, NULL
from public.exercises e where e.slug = 'first-markup-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'what-happens-when-you-open-a-page'), NULL, 'q-what-is-html', 1, 'single'::public.question_kind,
        'What does a web server send to your browser when you visit a page?', 'The server sends files — starting with an HTML file. Your browser reads that file and draws the page from it. The picture you see is produced on your computer, not sent as a picture.', (select id from public.skills where slug = 'document-structure'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A picture of the finished page', false, NULL
from public.quiz_questions where slug = 'q-what-is-html';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A program that runs on your computer', false, NULL
from public.quiz_questions where slug = 'q-what-is-html';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A video recording of the website', false, NULL
from public.quiz_questions where slug = 'q-what-is-html';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A text file containing HTML, which the browser draws', true, NULL
from public.quiz_questions where slug = 'q-what-is-html';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'what-happens-when-you-open-a-page'), NULL, 'q-html-purpose', 2, 'single'::public.question_kind,
        'What is the job of HTML?', 'HTML describes what content *is* — a heading, a paragraph, a link. Appearance is CSS''s job, and behaviour is JavaScript''s job.', (select id from public.skills where slug = 'document-structure'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'To describe what each piece of content means', true, NULL
from public.quiz_questions where slug = 'q-html-purpose';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'To choose the colours and fonts of a page', false, NULL
from public.quiz_questions where slug = 'q-html-purpose';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'To make buttons respond when clicked', false, NULL
from public.quiz_questions where slug = 'q-html-purpose';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'To store a website''s data', false, NULL
from public.quiz_questions where slug = 'q-html-purpose';
-- lesson: Tags, elements and attributes
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'tags-elements-attributes', 2, 'Tags, elements and attributes', 'The three words that unlock everything else', 'Almost all of HTML is one pattern repeated. Learn the pattern once and every new element becomes easy.',
       ARRAY['Tell a tag apart from an element', 'Write an attribute correctly, with its name and value', 'Recognise elements that have no closing tag']::text[], 14, 40, (select id from public.skills where slug = 'syntax'), 0.7
from public.modules m where m.slug = 'how-the-web-works'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'You have seen `<h1>Fresh bread</h1>` already. Which part of that would you call the *element*?',
       NULL, NULL, NULL, '{"options":["The whole thing: `<h1>Fresh bread</h1>`","Just `<h1>`","Just the words `Fresh bread`","Just `</h1>`"],"answer":"The element is the whole thing — opening tag, content and closing tag together. `<h1>` on its own is a *tag*. The distinction sounds pedantic and is not: nearly every error message you will ever read talks about one or the other, and they mean different things."}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Explain the difference between a tag and an element","Add an attribute to an element with the correct syntax","Identify void elements, which never have a closing tag"]}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'Nearly everything in HTML follows one pattern: an opening tag, some content, and a closing tag. Together those three things are called an element.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'visual'::public.block_type, NULL, 'Every part of an element, labelled.',
       NULL, NULL, 'anatomy-of-an-element', '{}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'Tag', 'The bit in angle brackets. `<p>` is an opening tag; `</p>` is a closing tag.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'term'::public.block_type, 'Element', 'The opening tag, the content and the closing tag together. `<p>Hello</p>` is one paragraph element.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'term'::public.block_type, 'Attribute', 'Extra information written inside the opening tag, as `name="value"`. It tells the browser something the tag alone cannot.',
       NULL, NULL, NULL, '{"example":"<a href=\"about.html\">About us</a> — here href is the attribute name and about.html is its value."}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<a href="about.html" title="Learn about our bakery">About us</a>', 'html', NULL, '{"annotations":[{"line":"1","text":"`<a` starts a link element. The letter \"a\" stands for anchor."},{"line":"1","text":"`href=\"about.html\"` is an attribute. `href` means \"hypertext reference\" — where the link goes. Its value sits in quotation marks."},{"line":"1","text":"`title=\"…\"` is a second attribute. Attributes are separated by a single space, and an element can have as many as it needs."},{"line":"1","text":"`>` closes the opening tag. Everything after it is the content."},{"line":"1","text":"`About us` is the content — the words a person actually sees and clicks."},{"line":"1","text":"`</a>` closes the element. The slash is what makes it a closing tag."}]}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'callout'::public.block_type, 'The three mistakes everyone makes at first', 'Forgetting the slash in the closing tag (`<p>` twice instead of `<p>` then `</p>`). Forgetting the quotation marks around an attribute value. Putting a space around the equals sign — write `href="x"`, not `href = "x"`. All three are normal, and the checker in this course names them for you.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'prose'::public.block_type, NULL, 'A small number of elements have nothing to put between an opening and closing tag, because they are not wrapping anything. These are called void elements, and they are written as a single tag.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'code_example'::public.block_type, 'Void elements: one tag, no closing tag', NULL,
       '<br>
<hr>
<img src="/learning-media/images/coast-sunrise.jpg" alt="Sunrise over a calm sea">', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'prose'::public.block_type, NULL, 'There are only fifteen void elements in the whole language, and you will meet the useful ones — `<br>`, `<hr>`, `<img>`, `<input>`, `<meta>`, `<link>`, `<source>`, `<track>` — as the course goes on. You never need to memorise the list.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'interactive_demo'::public.block_type, 'See it change', 'Watch what the same words look like with different labels around them.',
       NULL, NULL, NULL, '{"variants":[{"label":"As a heading","code":"<h1>Opening hours</h1>","note":"The browser makes it large and bold, and screen readers announce it as a heading."},{"label":"As a paragraph","code":"<p>Opening hours</p>","note":"Normal body text. Correct if it is a sentence, wrong if it is really a heading."},{"label":"As a link","code":"<a href=\"hours.html\">Opening hours</a>","note":"Now it is interactive — it can be clicked, and reached with the Tab key."}]}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'comparison'::public.block_type, 'Attributes: written correctly, and written wrongly', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Correct","code":"<a href=\"contact.html\">Contact us</a>","why":"Attribute name, equals sign, value in quotation marks, no stray spaces."},"bad":{"label":"Broken","code":"<a href = contact.html>Contact us</a>","why":"Spaces around the equals sign and no quotation marks. Browsers sometimes forgive this, but it breaks the moment the value contains a space."}}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 15, 'predict_check'::public.block_type, 'Predict, then check', 'Two paragraphs, almost identical. `<br>` is a void element, so the second one closes a tag that was never open. Before you run it: will the browser refuse the second paragraph, or do something else?',
       '<p>Fresh bread<br>every morning</p>
<p>Fresh bread</br>every morning</p>', 'html', NULL, '{"outcome":"It does something else. Browsers do not reject broken HTML — they repair it and carry on, so `</br>` is silently treated as `<br>` and both paragraphs look identical. That is why a page can look perfect and still be wrong, and why this course checks your markup rather than trusting how it looks."}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 16, 'checklist'::public.block_type, 'Before you move on, you can', NULL,
       NULL, NULL, NULL, '{"items":["Point at a tag and an element and say which is which","Write an attribute with its quotation marks","Name two void elements"]}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 17, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["A tag is one label in angle brackets; an element is the opening tag, content and closing tag together.","Attributes live inside the opening tag and are written `name=\"value\"`.","Void elements such as `<br>`, `<hr>` and `<img>` have no closing tag because they wrap nothing."],"nextUp":"Next: how elements sit inside one another."}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 18, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What is the difference between a tag and an element?","Write out the anatomy of a link to `about.html` with the text \"About us\", from memory.","Name two void elements and say what makes them void."],"points":["A tag is one label in angle brackets. An element is the opening tag, the content and the closing tag together.","`<a href=\"about.html\">About us</a>` — element name, attribute as `name=\"value\"` in quotation marks, content, then a closing tag with a slash.","`<br>`, `<hr>`, `<img>`, `<input>`, `<meta>` and `<link>` are all void: they wrap no content, so there is nothing for a closing tag to close."]}'::jsonb
from public.lessons where slug = 'tags-elements-attributes';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'attributes-guided', 1, 'guided'::public.exercise_kind, 'Add an attribute to a link',
       'The link below has no destination, so clicking it does nothing. Add an `href` attribute with the value `opening-hours.html`, keeping the visible text exactly as it is.', '<p>Check our <a>opening hours</a> before you visit.</p>', '<p>Check our <a href="opening-hours.html">opening hours</a> before you visit.</p>', ARRAY['An attribute goes inside the opening tag, after the element name, separated by a space.', 'The pattern is: <a href="value">', 'The finished tag is <a href="opening-hours.html"> — remember the quotation marks.']::text[],
       30, 1,
       (select id from public.skills where slug = 'syntax'), false
from public.lessons l where l.slug = 'tags-elements-attributes'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'element_present'::public.requirement_kind, 'a', NULL,
       NULL, NULL, NULL, NULL,
       'There is a link element', NULL, 1, true, NULL
from public.exercises e where e.slug = 'attributes-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'a', 'href',
       'opening-hours.html', NULL, NULL, NULL,
       'The link points to opening-hours.html', NULL, 1, true, NULL
from public.exercises e where e.slug = 'attributes-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'text_content'::public.requirement_kind, 'a', NULL,
       'opening hours', NULL, NULL, NULL,
       'The link text is unchanged', NULL, 1, true, NULL
from public.exercises e where e.slug = 'attributes-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'nesting'::public.requirement_kind, 'a', NULL,
       NULL, 'p', 1, NULL,
       'The link is still inside the paragraph', NULL, 1, true, NULL
from public.exercises e where e.slug = 'attributes-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'attributes-challenge', 2, 'challenge'::public.exercise_kind, 'Build a small block of content',
       'Write three elements, in this order: a level-one heading naming any business you like, a paragraph describing it in a sentence, and a link to `menu.html` with sensible link text. The words are entirely up to you — the structure is what is being checked.', '', '<h1>The Blue Door Café</h1>
<p>A small neighbourhood café serving proper coffee and slow-baked pastries.</p>
<a href="menu.html">See our menu</a>', ARRAY['You need three separate elements, each on its own line.', 'Start with <h1>…</h1>, then <p>…</p>, then a link.', 'The link needs an href attribute pointing at menu.html.']::text[],
       40, 2,
       (select id from public.skills where slug = 'syntax'), false
from public.lessons l where l.slug = 'tags-elements-attributes'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'Exactly one <h1> heading', NULL, 1, true, NULL
from public.exercises e where e.slug = 'attributes-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'text_not_empty'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'The heading is not empty', NULL, 1, true, NULL
from public.exercises e where e.slug = 'attributes-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'element_present'::public.requirement_kind, 'p', NULL,
       NULL, NULL, NULL, NULL,
       'A paragraph describing the business', NULL, 1, true, NULL
from public.exercises e where e.slug = 'attributes-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'text_not_empty'::public.requirement_kind, 'p', NULL,
       NULL, NULL, NULL, NULL,
       'The paragraph is not empty', NULL, 1, true, NULL
from public.exercises e where e.slug = 'attributes-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'attribute_value'::public.requirement_kind, 'a', 'href',
       'menu.html', NULL, NULL, NULL,
       'A link pointing at menu.html', NULL, 1, true, NULL
from public.exercises e where e.slug = 'attributes-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'text_not_empty'::public.requirement_kind, 'a', NULL,
       NULL, NULL, NULL, NULL,
       'The link has visible text', NULL, 1, true, NULL
from public.exercises e where e.slug = 'attributes-challenge';

commit;
