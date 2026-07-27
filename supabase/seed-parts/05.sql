-- HTML Hero — course seed, part 5 of 10
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 4 first.

begin;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_present'::public.requirement_kind, 'section', NULL,
       NULL, NULL, NULL, NULL,
       'The themed group uses a section', NULL, 1, true
from public.exercises e where e.slug = 'section-article-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'aside', NULL,
       NULL, NULL, NULL, NULL,
       'The tangential content uses an aside', NULL, 1, true
from public.exercises e where e.slug = 'section-article-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'main > div, section > div', NULL,
       NULL, NULL, 0, 0,
       'No meaningless divs remain', NULL, 1, true
from public.exercises e where e.slug = 'section-article-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'section-article-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'section-article-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'section-debug', 2, 'debug'::public.exercise_kind, 'Sections that should not be sections',
       'This page uses `<section>` for two things that are not sections: a styling wrapper with no heading, and a self-contained review. Fix both, and give the aside an accessible name.', '<main>
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
</main>', '<main>
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
</main>', ARRAY['The outer wrapper has no heading and exists only for layout — that is a <div>.', 'A single review is self-contained, so it is an <article>.', 'Add aria-label to the aside so screen readers can name it.']::text[],
       45, 3,
       (select id from public.skills where slug = 'semantic-html'), false
from public.lessons l where l.slug = 'section-article-aside'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'article', NULL,
       NULL, NULL, NULL, NULL,
       'The review is an article', NULL, 1, true
from public.exercises e where e.slug = 'section-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'section', NULL,
       NULL, NULL, 0, 0,
       'No misused section elements remain', NULL, 1, true
from public.exercises e where e.slug = 'section-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'aside', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The aside has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'section-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'div', NULL,
       NULL, NULL, NULL, NULL,
       'The layout wrapper is a div', NULL, 1, true
from public.exercises e where e.slug = 'section-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'section-article-aside'), NULL, 'q-article-test', 1, 'single'::public.question_kind,
        'What is the test for using `<article>`?', 'Whether the content would still make sense on its own, lifted out of the page.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Is it more than three paragraphs long?', false, NULL
from public.quiz_questions where slug = 'q-article-test';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Does it contain an image?', false, NULL
from public.quiz_questions where slug = 'q-article-test';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Is it written by a named author?', false, NULL
from public.quiz_questions where slug = 'q-article-test';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Would it make sense on its own, outside this page?', true, NULL
from public.quiz_questions where slug = 'q-article-test';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'section-article-aside'), NULL, 'q-section-heading', 2, 'single'::public.question_kind,
        'You have a container with no heading and no theme, used only for layout. What should it be?', '`<div>`. Using `<section>` would add a meaningless region to the page structure.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<article>', false, NULL
from public.quiz_questions where slug = 'q-section-heading';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<aside>', false, NULL
from public.quiz_questions where slug = 'q-section-heading';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<div>', true, NULL
from public.quiz_questions where slug = 'q-section-heading';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<section>', false, NULL
from public.quiz_questions where slug = 'q-section-heading';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'section-article-aside'), NULL, 'q-outline-algorithm', 3, 'single'::public.question_kind,
        'Does nesting a heading inside a `<section>` change its level?', 'No. The outline algorithm that would have done this was never implemented and has been removed from the specification. Always set levels explicitly.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'No — always set heading levels explicitly', true, NULL
from public.quiz_questions where slug = 'q-outline-algorithm';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Yes, each section demotes headings by one level', false, NULL
from public.quiz_questions where slug = 'q-outline-algorithm';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only in browsers that support HTML5 outlines', false, NULL
from public.quiz_questions where slug = 'q-outline-algorithm';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only for h1 elements', false, NULL
from public.quiz_questions where slug = 'q-outline-algorithm';
-- module: Organising a real project
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'organising-a-project', 2, 'Organising a real project', 'Folder structure, naming conventions, repeated page patterns, and the Level 5 milestone rebuild.',
       45, true
from public.levels l where l.slug = 'structure-professional'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'organising-a-project' and p.slug = 'semantic-landmarks';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.7
from public.modules m, public.skills s
where m.slug = 'organising-a-project' and s.slug = 'semantic-html';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'organising-a-project' and s.slug = 'maintainability';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.6
from public.modules m, public.skills s
where m.slug = 'organising-a-project' and s.slug = 'multi-page';
-- lesson: File organisation and reusable patterns
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'file-organisation-and-patterns', 1, 'File organisation and reusable patterns', 'Structure that still makes sense at page forty', 'Every professional site has conventions. Adopting them now costs nothing and saves a great deal later.',
       ARRAY['Lay out a project folder that scales', 'Apply consistent naming conventions', 'Recognise repeated patterns and keep them identical']::text[], 13, 40, (select id from public.skills where slug = 'maintainability'), 0.7
from public.modules m where m.slug = 'organising-a-project'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Design a folder structure for a multi-page site","Apply naming conventions that avoid server-specific bugs","Keep repeated page furniture consistent across a site"]}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'visual'::public.block_type, NULL, 'A project laid out so that paths stay predictable.',
       NULL, NULL, 'file-paths', '{}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'A structure that still works at forty pages', NULL,
       'my-site/
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
    └── harbour.html', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'checklist'::public.block_type, 'Conventions worth adopting permanently', NULL,
       NULL, NULL, NULL, '{"items":["Lowercase filenames — some servers are case-sensitive, some are not; assume the strict one","Hyphens, never spaces or underscores, in filenames","One `index.html` per folder, so `/routes/` works as a URL","All assets under `assets/`, grouped by type","Descriptive names: `hero-workshop.jpg`, not `IMG_4821.jpg`","A `404.html` so a mistyped URL is still helpful"]}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'The case-sensitivity trap', 'Most Windows and macOS setups treat `About.html` and `about.html` as the same file. Most Linux servers do not. A site that works perfectly on your laptop can 404 the moment it is deployed. Lowercase everything and the problem disappears permanently.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'prose'::public.block_type, NULL, 'The other half of maintainability is repetition. Your header, navigation and footer appear on every page. Keeping them byte-for-byte identical is what makes a site feel coherent — and it is the thing hand-written sites get wrong first.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'comparison'::public.block_type, 'Two ways of writing the same page furniture', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Consistent","code":"<!-- Site header — identical on every page -->\n<header>\n  <a href=\"/\" class=\"logo\">Riverside</a>\n  <nav aria-label=\"Main\">…</nav>\n</header>","why":"A comment marks the block as shared, so the next person knows to change it everywhere."},"bad":{"label":"Drifted","code":"<!-- page 1 -->\n<header><nav aria-label=\"Main\">…</nav></header>\n\n<!-- page 2 -->\n<div class=\"top\"><nav>…</nav></div>","why":"The same region, written two different ways. Screen-reader users lose the landmark on page two, and every future change has to be made twice."}}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'term'::public.block_type, 'Progressive disclosure of complexity', 'Hand-copying shared markup is fine for a handful of pages. Beyond that, professionals use a template system or a static site generator that writes the repetition for them. Knowing *why* the repetition exists is what lets you pick the right tool later.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'callout'::public.block_type, 'Comment the boundaries, not the obvious', 'A comment saying `<!-- Site header — keep identical across pages -->` earns its place. A comment saying `<!-- paragraph -->` above a `<p>` does not. Write comments for decisions and boundaries, never for restating what the code already says.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'progressive_detail'::public.block_type, 'Avoiding unnecessary containers', 'Every extra wrapper is a line someone has to read, and a level of nesting that makes a missing closing tag harder to find. Before adding a `<div>`, check whether the element you already have could carry the styling instead. A page that is five levels deep where three would do is not "more structured" — it is just harder to change.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'interactive_demo'::public.block_type, 'Where a file lives changes every path in it', 'The same link, written from three different places in the project.',
       NULL, NULL, NULL, '{"variants":[{"label":"From index.html, at the top","code":"<a href=\"projects/first.html\">First project</a>\n<img src=\"images/logo.svg\" alt=\"Riverside Bakery\" width=\"200\" height=\"60\">","note":"Both targets are below the current file, so both paths simply step down into a folder."},{"label":"From projects/first.html","code":"<a href=\"../index.html\">Home</a>\n<img src=\"../images/logo.svg\" alt=\"Riverside Bakery\" width=\"200\" height=\"60\">","note":"One folder deep, so both need ../ first. Read it back as a sentence: up one, into images, take logo.svg."},{"label":"A leading slash","code":"<img src=\"/images/logo.svg\" alt=\"Riverside Bakery\" width=\"200\" height=\"60\">","note":"Means \"from the site root\". Correct on a server, broken when you open the file directly from your computer."}]}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'visual'::public.block_type, NULL, 'A project folder is a desk. Everything has a place, and you can find things without remembering where you put them.',
       NULL, NULL, 'studio-desk', '{}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Lowercase, hyphenated filenames avoid an entire class of deployment bug.","Group assets by type under one folder.","Keep shared page furniture byte-for-byte identical.","Add a container only when it earns its place."],"nextUp":"Next: the Level 5 milestone rebuild."}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'patterns-guided', 1, 'guided'::public.exercise_kind, 'Make two pages consistent',
       'This is the header from page two of a site. Page one uses `<header>`, a labelled `<nav>` and a `<ul>` of links. Rewrite this one to match exactly.', '<div class="top">
  <nav>
    <a href="index.html">Home</a>
    <a href="about.html">About</a>
    <a href="contact.html">Contact</a>
  </nav>
</div>', '<header>
  <nav aria-label="Main">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="about.html">About</a></li>
      <li><a href="contact.html">Contact</a></li>
    </ul>
  </nav>
</header>', ARRAY['The wrapper should be a <header>, not a div.', 'The nav needs aria-label="Main" to match page one.', 'Wrap the links in a <ul> with one <li> each.']::text[],
       40, 2,
       (select id from public.skills where slug = 'maintainability'), false
from public.lessons l where l.slug = 'file-organisation-and-patterns'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'The wrapper is a header landmark', NULL, 1, true
from public.exercises e where e.slug = 'patterns-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'nav', 'aria-label',
       'Main', NULL, NULL, NULL,
       'The nav is labelled "Main"', NULL, 1, true
from public.exercises e where e.slug = 'patterns-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 3, 3,
       'Three links, each in a list item', NULL, 1, true
from public.exercises e where e.slug = 'patterns-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'div', NULL,
       NULL, NULL, 0, 0,
       'The generic div has been replaced', NULL, 1, true
from public.exercises e where e.slug = 'patterns-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'file-organisation-and-patterns'), NULL, 'q-case-sensitivity', 1, 'single'::public.question_kind,
        'Why use lowercase filenames?', 'Linux servers are case-sensitive while many development machines are not, so mixed case works locally and 404s in production.', (select id from public.skills where slug = 'multi-page'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Lowercase files load faster', false, NULL
from public.quiz_questions where slug = 'q-case-sensitivity';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'HTML requires it', false, NULL
from public.quiz_questions where slug = 'q-case-sensitivity';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Many servers are case-sensitive even when your computer is not', true, NULL
from public.quiz_questions where slug = 'q-case-sensitivity';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Uppercase letters are invalid in URLs', false, NULL
from public.quiz_questions where slug = 'q-case-sensitivity';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'file-organisation-and-patterns'), NULL, 'q-comments-value', 2, 'single'::public.question_kind,
        'Which comment is worth writing?', 'Comments should record decisions and mark boundaries, not restate what the markup already says.', (select id from public.skills where slug = 'maintainability'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<!-- Site header — keep identical across all pages -->', true, NULL
from public.quiz_questions where slug = 'q-comments-value';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<!-- paragraph -->', false, NULL
from public.quiz_questions where slug = 'q-comments-value';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<!-- div -->', false, NULL
from public.quiz_questions where slug = 'q-comments-value';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<!-- closing tag below -->', false, NULL
from public.quiz_questions where slug = 'q-comments-value';
-- lesson: Milestone: rebuild an unstructured page
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'semantic-rebuild-milestone', 2, 'Milestone: rebuild an unstructured page', 'Take div soup and turn it into professional markup', 'A real page, written badly. Your job is to rebuild it properly without changing a word of the content.',
       ARRAY['Convert a non-semantic page into a landmark-based structure', 'Fix the heading hierarchy at the same time', 'Justify every element choice you make']::text[], 30, 40, (select id from public.skills where slug = 'semantic-html'), 0.8
from public.modules m where m.slug = 'organising-a-project'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Rebuild a div-based page using correct landmarks","Repair the heading hierarchy","Produce markup you would be happy to hand to a colleague"]}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'The page in the exercise below is the kind you meet constantly in real work: it looks acceptable, and the markup underneath says nothing at all. Rebuilding it is the single most useful exercise in this level.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'checklist'::public.block_type, 'Your rebuild must have', NULL,
       NULL, NULL, NULL, '{"items":["A `<header>` containing the site name and the main `<nav>`","Exactly one `<main>`, with an `id` a skip link can target","The self-contained items as `<article>` elements","The tangential block as an `<aside>` with an accessible name","A `<footer>` outside `<main>`","A correct heading hierarchy: one `<h1>`, no skipped levels","No `<div>` where a semantic element fits"]}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Work outside in', 'Identify the landmarks first — header, main, footer. Then work down through what is inside each one. Trying to fix the innermost elements before the outer structure is settled means doing the work twice.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'The same region, before and after a rebuild', NULL,
       NULL, NULL, NULL, '{"good":{"label":"After — semantic","code":"<article>\n  <h2>The valley route</h2>\n  <p>Twenty-four miles, mostly flat.</p>\n</article>","why":"A screen reader announces an article with a heading. Search engines can identify the item. The class names are gone because the elements now carry the meaning."},"bad":{"label":"Before — div soup","code":"<div class=\"card\">\n  <div class=\"card-title\">The valley route</div>\n  <p>Twenty-four miles, mostly flat.</p>\n</div>","why":"Identical on screen. No heading in the outline, no landmark to jump to, and the \"card-title\" class means nothing to any software."}}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'visual'::public.block_type, NULL, 'The structure you are rebuilding towards.',
       NULL, NULL, 'semantic-landmarks', '{}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'interactive_demo'::public.block_type, 'Div soup and its replacement, side by side', 'Identical on screen. Not remotely identical to software.',
       NULL, NULL, NULL, '{"variants":[{"label":"Rebuilt","code":"<header><nav aria-label=\"Main\"><ul><li><a href=\"index.html\">Home</a></li></ul></nav></header>\n<main><h1>Prices</h1><p>From £6 an hour.</p></main>\n<footer><p>© 2026</p></footer>","note":"Four landmarks a screen-reader user can jump between, and a heading that describes the page."},{"label":"The original","code":"<div class=\"header\"><div class=\"nav\"><ul><li><a href=\"index.html\">Home</a></li></ul></div></div>\n<div class=\"main\"><div class=\"h1\">Prices</div><p>From £6 an hour.</p></div>\n<div class=\"footer\"><p>© 2026</p></div>","note":"No landmarks, no heading. The class names describe the intent perfectly and communicate it to nothing."}]}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["You can now read an unstructured page and see the structure it should have had.","Landmarks first, then content elements, then headings.","This is the skill that most visibly separates professional markup from amateur markup."],"nextUp":"Level 6 next: tables and forms."}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'semantic-rebuild', 1, 'challenge'::public.exercise_kind, 'Milestone: rebuild the page',
       'Rebuild this page with correct semantic structure and a valid heading hierarchy. Keep every word of the content exactly as it is — only the markup changes.', '<div id="top">
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
</div>', '<header>
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
</footer>', ARRAY['Start with the three landmarks: #top becomes <header>, #content becomes <main>, #bottom becomes <footer>.', 'The .menu is navigation — a <nav aria-label="Main"> containing a <ul> of links.', 'Each .card is a self-contained item, so it becomes an <article> with an <h2>.', '.title is the page heading — that is your single <h1>. The .side block becomes an <aside>.']::text[],
       140, 4,
       (select id from public.skills where slug = 'semantic-html'), false
from public.lessons l where l.slug = 'semantic-rebuild-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'There is a header landmark', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main element', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'There is a footer landmark', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'nav', NULL,
       NULL, NULL, NULL, NULL,
       'The menu uses a nav element', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav is labelled', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 3, 3,
       'The three links are list items in the nav', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one h1', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'element_count'::public.requirement_kind, 'article', NULL,
       NULL, NULL, 2, 2,
       'The two route cards are articles', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'element_count'::public.requirement_kind, 'article h2', NULL,
       NULL, NULL, 2, 2,
       'Each article has an h2 heading', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'element_present'::public.requirement_kind, 'aside', NULL,
       NULL, NULL, NULL, NULL,
       'The tangential block is an aside', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'attribute_present'::public.requirement_kind, 'aside', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The aside has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside main', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'element_count'::public.requirement_kind, 'footer main, main footer', NULL,
       NULL, NULL, 0, 0,
       'The footer is outside main', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 15, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 16, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 17, 'text_not_empty'::public.requirement_kind, 'p', NULL,
       NULL, NULL, NULL, NULL,
       'All the original content survives', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'semantic-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: give every page landmarks',
       'Rework your capstone pages so each one has `<header>`, `<nav>`, `<main id="main">` and `<footer>`, with the skip link still pointing at `#main`. This is the structure every remaining module builds on.', '<body>
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
</body>', '<body>
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
</body>', ARRAY['The header wraps the site name and the nav together.', 'main needs id="main" so the skip link reaches it.', 'The footer goes after main, not inside it.']::text[],
       90, 3,
       (select id from public.skills where slug = 'multi-page'), false
from public.lessons l where l.slug = 'semantic-rebuild-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'The page has a header', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'nesting'::public.requirement_kind, 'nav', NULL,
       NULL, 'header', 1, NULL,
       'The navigation is inside the header', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'main', 'id',
       'main', NULL, NULL, NULL,
       'main has the id the skip link targets', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'The page has a footer', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'main footer', NULL,
       NULL, NULL, 0, 0,
       'The footer is outside main', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside main', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'The skip link still targets #main', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'semantic-rebuild-milestone'), NULL, 'q-footer-placement', 1, 'single'::public.question_kind,
        'Should the site footer be inside `<main>`?', 'No. `<main>` holds content unique to this page; the site footer is repeated on every page, so it sits outside.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It makes no difference', false, NULL
from public.quiz_questions where slug = 'q-footer-placement';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'No — it is repeated on every page, so it goes outside main', true, NULL
from public.quiz_questions where slug = 'q-footer-placement';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Yes, main should contain the whole page', false, NULL
from public.quiz_questions where slug = 'q-footer-placement';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only if the page has no header', false, NULL
from public.quiz_questions where slug = 'q-footer-placement';
-- Level 5 milestone: Structure Professional questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q1', 1, 'single'::public.question_kind,
        'Which element wraps the content unique to a page?', '`<main>`, and there should be exactly one per page.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<section>', false, NULL
from public.quiz_questions where slug = 'a5-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<article>', false, NULL
from public.quiz_questions where slug = 'a5-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<div id="content">', false, NULL
from public.quiz_questions where slug = 'a5-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<main>', true, NULL
from public.quiz_questions where slug = 'a5-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q2', 2, 'single'::public.question_kind,
        'A blog post in a list of posts should be marked up as what?', 'It is self-contained and would make sense on its own, so `<article>`.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<aside>', false, NULL
from public.quiz_questions where slug = 'a5-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<div>', false, NULL
from public.quiz_questions where slug = 'a5-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<article>', true, NULL
from public.quiz_questions where slug = 'a5-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<section>', false, NULL
from public.quiz_questions where slug = 'a5-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q3', 3, 'single'::public.question_kind,
        'What role does `<header>` already have, without any ARIA?', 'When it is not inside an article or section, `<header>` has the `banner` role.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'complementary', false, NULL
from public.quiz_questions where slug = 'a5-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'banner', true, NULL
from public.quiz_questions where slug = 'a5-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'navigation', false, NULL
from public.quiz_questions where slug = 'a5-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'main', false, NULL
from public.quiz_questions where slug = 'a5-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q4', 4, 'single'::public.question_kind,
        'When is `<div>` the right choice?', 'When you genuinely need a container for layout and no semantic element describes the content.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'When no semantic element fits and you need a container', true, NULL
from public.quiz_questions where slug = 'a5-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Never — divs are obsolete', false, NULL
from public.quiz_questions where slug = 'a5-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Whenever you need to apply a class', false, NULL
from public.quiz_questions where slug = 'a5-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only inside <main>', false, NULL
from public.quiz_questions where slug = 'a5-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q5', 5, 'single'::public.question_kind,
        'Does nesting an `<h2>` inside a `<section>` make it behave like an `<h3>`?', 'No. The outline algorithm was never implemented and has been removed. Heading levels are always explicit.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Yes, sections demote headings automatically', false, NULL
from public.quiz_questions where slug = 'a5-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Only in screen readers', false, NULL
from public.quiz_questions where slug = 'a5-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only when the section has an aria-label', false, NULL
from public.quiz_questions where slug = 'a5-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'No — heading levels are always explicit', true, NULL
from public.quiz_questions where slug = 'a5-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q6', 6, 'single'::public.question_kind,
        'Why does a page with two `<nav>` elements need `aria-label` on each?', 'Otherwise a screen reader lists two identical "navigation" landmarks with no way to tell them apart.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'To give them different styling', false, NULL
from public.quiz_questions where slug = 'a5-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'To stop search engines indexing the second one', false, NULL
from public.quiz_questions where slug = 'a5-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'So they can be told apart in the landmarks list', true, NULL
from public.quiz_questions where slug = 'a5-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Because two navs are otherwise invalid', false, NULL
from public.quiz_questions where slug = 'a5-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q7', 7, 'single'::public.question_kind,
        'Which filename follows professional convention?', 'Lowercase, hyphenated, descriptive.', (select id from public.skills where slug = 'multi-page'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'doc1.pdf', false, NULL
from public.quiz_questions where slug = 'a5-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'price-list-2026.pdf', true, NULL
from public.quiz_questions where slug = 'a5-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Price List 2026.pdf', false, NULL
from public.quiz_questions where slug = 'a5-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'PriceList2026.PDF', false, NULL
from public.quiz_questions where slug = 'a5-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q8', 8, 'single'::public.question_kind,
        'What does `<aside>` mean?', 'Content related to what surrounds it but not essential — removing it should not damage the main content.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Related but non-essential content', true, NULL
from public.quiz_questions where slug = 'a5-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A sidebar, defined by its position on screen', false, NULL
from public.quiz_questions where slug = 'a5-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A footnote', false, NULL
from public.quiz_questions where slug = 'a5-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Any content that is visually to one side', false, NULL
from public.quiz_questions where slug = 'a5-q8';
-- --------------------------------------------------------------------------
-- HTML Hero — Level 6: Data and Forms Builder
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'data-and-forms', 6, 'Data and Forms Builder', 'Tables people can actually read, and forms people can actually complete',
       'Tables and forms are where HTML becomes an interface. Both are easy to write badly and not much harder to write well — the difference is knowing which handful of attributes matter.', 'You can build an accessible data table and a professional enquiry or booking form with real validation.', 'rose'
from public.courses c where c.slug = 'html-hero'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-6-milestone', 'milestone'::public.assessment_kind, 'Level 6 milestone: Data and Forms Builder', 'Ten questions on tables, forms, validation and form security. Pass mark 75%.',
       0.75, 200, 6
from public.levels l where l.slug = 'data-and-forms'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Data tables
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'data-tables', 1, 'Data tables', 'Rows, columns, headers and scope — plus the one thing tables must never be used for.',
       40, false
from public.levels l where l.slug = 'data-and-forms'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'data-tables' and p.slug = 'organising-a-project';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'data-tables' and s.slug = 'tables';
-- lesson: Building an accessible table
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'building-a-table', 1, 'Building an accessible table', 'caption, thead, th, scope — the four that do the work', 'A table without headers is a grid of numbers with no meaning. Four elements turn it into data.',
       ARRAY['Build a table with a caption and proper header cells', 'Use scope so header cells apply to the right row or column', 'Explain why tables must not be used for page layout']::text[], 15, 40, (select id from public.skills where slug = 'tables'), 0.7
from public.modules m where m.slug = 'data-tables'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Build a data table with caption, thead, tbody and tfoot","Apply scope=\"col\" and scope=\"row\" correctly","Explain the difference between a data table and a layout table"]}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'visual'::public.block_type, NULL, 'The parts of a data table, labelled.',
       NULL, NULL, 'table-structure', '{}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<table>
  <caption>Bike hire rates, 2026</caption>
  <thead>
    <tr>
      <th scope="col">Bike type</th>
      <th scope="col">Per hour</th>
      <th scope="col">Per day</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">Hybrid</th>
      <td>£6</td>
      <td>£22</td>
    </tr>
    <tr>
      <th scope="row">Road bike</th>
      <td>£9</td>
      <td>£34</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="3">All rates include a helmet and a lock.</td>
    </tr>
  </tfoot>
</table>', 'html', NULL, '{"annotations":[{"line":"2","text":"`<caption>` is the table''s title. It must be the first child of `<table>`, and it is announced by screen readers before the data — so the user knows what they are about to enter."},{"line":"3-9","text":"`<thead>` groups the header row. Browsers repeat it when a long table is printed."},{"line":"5","text":"`<th scope=\"col\">` means \"this heading describes the whole column below me\"."},{"line":"10-19","text":"`<tbody>` holds the data rows."},{"line":"13","text":"`<th scope=\"row\">` means \"this heading describes the row beside me\". The first cell of each row is a heading, not data — it names what the row is about."},{"line":"20-24","text":"`<tfoot>` holds summary or footnote rows. It may be written before or after `<tbody>`; browsers render it last either way."},{"line":"22","text":"`colspan=\"3\"` makes this cell span all three columns."}]}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'What `scope` actually does', 'When a screen-reader user moves to a cell containing "£34", the screen reader announces "Road bike, Per day, £34" — it reads out the row and column headings that apply. It only knows which headings those are because `scope` told it. Without `scope`, the user hears "£34" and has to remember, cell by cell, where they are.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'interactive_demo'::public.block_type, 'The same numbers, with and without headers', 'Move through the cells and imagine hearing only the value.',
       NULL, NULL, NULL, '{"variants":[{"label":"With headers and scope","code":"<table>\n  <caption>Opening hours</caption>\n  <thead><tr><th scope=\"col\">Day</th><th scope=\"col\">Opens</th><th scope=\"col\">Closes</th></tr></thead>\n  <tbody>\n    <tr><th scope=\"row\">Tuesday</th><td>8am</td><td>6pm</td></tr>\n    <tr><th scope=\"row\">Sunday</th><td>9am</td><td>4pm</td></tr>\n  </tbody>\n</table>","note":"A cell announces as \"Sunday, Closes, 4pm\". Completely clear."},{"label":"Without","code":"<table>\n  <tr><td>Day</td><td>Opens</td><td>Closes</td></tr>\n  <tr><td>Tuesday</td><td>8am</td><td>6pm</td></tr>\n  <tr><td>Sunday</td><td>9am</td><td>4pm</td></tr>\n</table>","note":"The same cell announces as \"4pm\". Four pm on which day, opening or closing?"}]}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Never use a table for page layout', 'Twenty years ago tables were the only way to build a column layout, and a great deal of old tutorial material still shows it. A layout table tells a screen reader "here is data with rows and columns" when there is no data at all, and the reading order it produces often makes no sense. Use a table only when the content is genuinely tabular — information with two axes.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'progressive_detail'::public.block_type, 'colspan and rowspan', '`colspan="2"` makes a cell occupy two columns; `rowspan="2"` makes it occupy two rows. They are useful for grouping headers, but every span makes the table harder to follow non-visually. For anything more complex than a single spanned header row, consider whether two simpler tables would serve readers better — the answer is usually yes.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'checklist'::public.block_type, 'Every data table needs', NULL,
       NULL, NULL, NULL, '{"items":["A `<caption>` as the first child, saying what the table contains","`<thead>` for the header row and `<tbody>` for the data","`<th scope=\"col\">` for column headings","`<th scope=\"row\">` where the first cell names the row","`<tfoot>` for totals or notes, if there are any"]}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<caption>` names the table and comes first.","`<th>` is a header cell; `<td>` is a data cell.","`scope=\"col\"` and `scope=\"row\"` tell screen readers which headings apply.","Tables are for data with two axes, never for layout."],"nextUp":"Next: forms."}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'table-guided', 1, 'guided'::public.exercise_kind, 'Build an opening-hours table',
       'Build a table with a caption "Opening hours", a header row of three column headings (Day, Opens, Closes), and two data rows for Tuesday and Sunday where the day is a row heading. Use `scope` throughout.', '<table>

</table>', '<table>
  <caption>Opening hours</caption>
  <thead>
    <tr>
      <th scope="col">Day</th>
      <th scope="col">Opens</th>
      <th scope="col">Closes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">Tuesday</th>
      <td>8am</td>
      <td>6pm</td>
    </tr>
    <tr>
      <th scope="row">Sunday</th>
      <td>9am</td>
      <td>4pm</td>
    </tr>
  </tbody>
</table>', ARRAY['The <caption> comes first, immediately inside <table>.', 'The header row goes inside <thead>, with three <th scope="col"> cells.', 'Each data row starts with <th scope="row"> for the day, then two <td> cells.']::text[],
       50, 3,
       (select id from public.skills where slug = 'tables'), false
from public.lessons l where l.slug = 'building-a-table'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'table > caption', NULL,
       NULL, NULL, NULL, NULL,
       'The table has a caption as its first child', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'text_not_empty'::public.requirement_kind, 'caption', NULL,
       NULL, NULL, NULL, NULL,
       'The caption has text', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'thead', NULL,
       NULL, NULL, NULL, NULL,
       'There is a table head', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'tbody', NULL,
       NULL, NULL, NULL, NULL,
       'There is a table body', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'th[scope="col"]', NULL,
       NULL, NULL, 3, 3,
       'Three column headings with scope="col"', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'th[scope="row"]', NULL,
       NULL, NULL, 2, 2,
       'Two row headings with scope="row"', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'element_count'::public.requirement_kind, 'tbody td', NULL,
       NULL, NULL, 4, 4,
       'Four data cells', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'table-debug', 2, 'debug'::public.exercise_kind, 'A table with no meaning',
       'This table uses `<td>` for everything, has no caption and no scope. Repair it so a screen-reader user can understand any single cell.', '<table>
  <tr><td>Bike type</td><td>Per hour</td><td>Per day</td></tr>
  <tr><td>Hybrid</td><td>£6</td><td>£22</td></tr>
  <tr><td>Road bike</td><td>£9</td><td>£34</td></tr>
</table>', '<table>
  <caption>Bike hire rates, 2026</caption>
  <thead>
    <tr>
      <th scope="col">Bike type</th>
      <th scope="col">Per hour</th>
      <th scope="col">Per day</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">Hybrid</th>
      <td>£6</td>
      <td>£22</td>
    </tr>
    <tr>
      <th scope="row">Road bike</th>
      <td>£9</td>
      <td>£34</td>
    </tr>
  </tbody>
</table>', ARRAY['Add a <caption> as the very first thing inside <table>.', 'The first row is headings — change those cells to <th scope="col"> and wrap the row in <thead>.', 'The first cell of each data row names the row, so it becomes <th scope="row">.']::text[],
       50, 3,
       (select id from public.skills where slug = 'tables'), false
from public.lessons l where l.slug = 'building-a-table'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'caption', NULL,
       NULL, NULL, NULL, NULL,
       'The table has a caption', NULL, 1, true
from public.exercises e where e.slug = 'table-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'th[scope="col"]', NULL,
       NULL, NULL, 3, 3,
       'The header row uses column headings', NULL, 1, true
from public.exercises e where e.slug = 'table-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'th[scope="row"]', NULL,
       NULL, NULL, 2, 2,
       'Each data row has a row heading', NULL, 1, true
from public.exercises e where e.slug = 'table-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'thead', NULL,
       NULL, NULL, NULL, NULL,
       'The header row is inside thead', NULL, 1, true
from public.exercises e where e.slug = 'table-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'tbody', NULL,
       NULL, NULL, NULL, NULL,
       'The data rows are inside tbody', NULL, 1, true
from public.exercises e where e.slug = 'table-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'building-a-table'), NULL, 'q-scope-col', 1, 'single'::public.question_kind,
        'What does `scope="col"` mean?', 'This header cell describes the column beneath it.', (select id from public.skills where slug = 'tables'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'This heading spans several columns', false, NULL
from public.quiz_questions where slug = 'q-scope-col';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'This heading describes the column below it', true, NULL
from public.quiz_questions where slug = 'q-scope-col';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'This cell should be displayed as a column', false, NULL
from public.quiz_questions where slug = 'q-scope-col';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'This column is sortable', false, NULL
from public.quiz_questions where slug = 'q-scope-col';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'building-a-table'), NULL, 'q-caption-position', 2, 'single'::public.question_kind,
        'Where must `<caption>` appear?', 'As the first child of `<table>`, before thead or any rows.', (select id from public.skills where slug = 'tables'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'As the first child of <table>', true, NULL
from public.quiz_questions where slug = 'q-caption-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Inside <thead>', false, NULL
from public.quiz_questions where slug = 'q-caption-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'After </table>', false, NULL
from public.quiz_questions where slug = 'q-caption-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Anywhere inside the table', false, NULL
from public.quiz_questions where slug = 'q-caption-position';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'building-a-table'), NULL, 'q-layout-tables', 3, 'single'::public.question_kind,
        'Why should you not use a table for page layout?', 'It announces "data with rows and columns" to a screen reader when there is no data, and often produces a nonsensical reading order.', (select id from public.skills where slug = 'tables'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It announces data structure where there is none', true, NULL
from public.quiz_questions where slug = 'q-layout-tables';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Tables render more slowly than divs', false, NULL
from public.quiz_questions where slug = 'q-layout-tables';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Tables cannot be styled with CSS', false, NULL
from public.quiz_questions where slug = 'q-layout-tables';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Search engines ignore table content', false, NULL
from public.quiz_questions where slug = 'q-layout-tables';
-- module: Form foundations
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'form-foundations', 2, 'Form foundations', 'The form element, labels, input types, and the grouping that makes a long form comprehensible.',
       55, false
from public.levels l where l.slug = 'data-and-forms'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'form-foundations' and p.slug = 'data-tables';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'form-foundations' and s.slug = 'forms';
-- lesson: Labels and input types
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'labels-and-inputs', 1, 'Labels and input types', 'The single most important pairing in HTML', 'An input without a label is unusable by a screen-reader user, and harder for everyone else. Joining them takes two attributes.',
       ARRAY['Join a label to its input with for and id', 'Choose the right input type for the data', 'Explain why placeholder text is not a label']::text[], 16, 40, (select id from public.skills where slug = 'forms'), 0.7
from public.modules m where m.slug = 'form-foundations'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Write a correctly associated label and input","Choose input types that give mobile users the right keyboard","Explain the problems with using placeholder as a label"]}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'visual'::public.block_type, NULL, 'A label and its input, joined by matching for and id values.',
       NULL, NULL, 'form-anatomy', '{}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<label for="email">Email address</label>
<input type="email" id="email" name="email" autocomplete="email" required>', 'html', NULL, '{"annotations":[{"line":"1","text":"`for=\"email\"` points at the input whose `id` is `email`."},{"line":"2","text":"`type=\"email\"` gives phones an @-friendly keyboard and lets the browser check the format."},{"line":"2","text":"`id=\"email\"` is what the label points at. It must be unique on the page."},{"line":"2","text":"`name=\"email\"` is the key the value is sent under when the form is submitted. Without a `name`, the field is not sent at all."},{"line":"2","text":"`autocomplete=\"email\"` lets the browser fill it from saved details — a large convenience, and a genuine accessibility benefit for people with motor or memory difficulties."},{"line":"2","text":"`required` tells the browser the field must be filled before submission."}]}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'What a label gets you', 'Three things at once. A screen reader announces "Email address, edit text" instead of just "edit text". Clicking the *word* puts the cursor in the box — which roughly doubles the target size, and matters enormously to anyone with a tremor or using a phone one-handed. And the browser can associate validation messages with the right field.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'Label or placeholder?', NULL,
       NULL, NULL, NULL, '{"good":{"label":"A real label","code":"<label for=\"phone\">Phone number</label>\n<input type=\"tel\" id=\"phone\" name=\"phone\" autocomplete=\"tel\">","why":"Always visible, clickable, and announced by screen readers."},"bad":{"label":"Placeholder as a label","code":"<input type=\"tel\" name=\"phone\" placeholder=\"Phone number\">","why":"The text vanishes the moment typing starts, so anyone interrupted forgets what the field was. Placeholder contrast is usually too low to meet WCAG, and support in screen readers is inconsistent."}}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Placeholder is a hint, not a label', 'Use it for an *example* of the expected format — `placeholder="07700 900123"` beside a label saying "Phone number". Never use it as the only description of a field.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'prose'::public.block_type, NULL, 'Choosing the right `type` is mostly about what keyboard a phone shows and what the browser can check for you.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'code_example'::public.block_type, 'The input types you will actually use', NULL,
       'type="text"      Anything short and free-form
type="email"     Email keyboard; browser checks for an @
type="tel"       Numeric keypad; no format checking (phone formats vary too much)
type="url"       URL keyboard; browser checks for a scheme
type="number"    Numeric spinner. Only for genuine quantities — never for
                 phone numbers, card numbers or postcodes
type="password"  Characters hidden as you type
type="date"      A native date picker
type="time"      A native time picker
type="search"    A search field, with a clear button on some browsers
type="file"      A file chooser
type="hidden"    Not shown; carries a value the server needs', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'callout'::public.block_type, '`type="number"` is the wrong choice more often than you think', 'It is for quantities you might sensibly add up. Phone numbers, postcodes and card numbers are not quantities: `number` strips leading zeros, offers a spinner nobody wants, and rejects spaces and hyphens. Use `type="text"` with `inputmode="numeric"` instead — you get the numeric keypad without the damage.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'term'::public.block_type, 'inputmode', 'A hint about which on-screen keyboard to show, independent of the input type. `inputmode="numeric"` gives digits; `inputmode="decimal"` adds a decimal point.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'term'::public.block_type, 'autocomplete', 'Tells the browser what kind of information a field expects, so it can offer the user''s saved details. The values are a fixed list: `name`, `email`, `tel`, `street-address`, `postal-code`, `cc-number`, `bday`, and so on.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'progressive_detail'::public.block_type, 'Why autocomplete is an accessibility requirement', 'WCAG 2.1 introduced a success criterion called Identify Input Purpose, which requires common personal-data fields to declare their purpose programmatically. `autocomplete` is how you meet it. For someone with a cognitive disability, a motor impairment, or simply a very long email address, autofill is the difference between a form that takes ten seconds and one that takes two minutes.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'interactive_demo'::public.block_type, 'Three ways to label a field', 'Two of these work. One only looks like it does.',
       NULL, NULL, NULL, '{"variants":[{"label":"Label with for","code":"<label for=\"email\">Email address</label>\n<input type=\"email\" id=\"email\" name=\"email\" autocomplete=\"email\">","note":"The usual form. Announced as \"Email address, edit text\", and clicking the words focuses the field."},{"label":"Label wrapping the input","code":"<label>Email address\n  <input type=\"email\" name=\"email\" autocomplete=\"email\">\n</label>","note":"Also correct, and needs no id at all. Useful when you do not control the ids on the page."},{"label":"Placeholder only","code":"<input type=\"email\" name=\"email\" placeholder=\"Email address\">","note":"No accessible name at all, and the hint vanishes the moment typing starts — removing the only clue exactly when it is needed."}]}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Every input needs a `<label for=\"…\">` matching its `id`.","`name` is what the value is submitted under — without it the field is not sent.","Placeholder text is a hint, never a label.","Choose `type` for the keyboard and the checking it brings; use `inputmode` where `number` would hurt.","`autocomplete` is a real accessibility feature, not just a convenience."],"nextUp":"Next: grouping, selects and buttons."}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'labels-guided', 1, 'guided'::public.exercise_kind, 'Label three inputs',
       'Each input below has no label. Add a correctly associated `<label>` for each, and give each input a `name` and a suitable `autocomplete` value.', '<form>
  <input type="text" id="fullname">
  <input type="email" id="email">
  <input type="tel" id="phone">
  <button type="submit">Send</button>
</form>', '<form>
  <label for="fullname">Full name</label>
  <input type="text" id="fullname" name="fullname" autocomplete="name">

  <label for="email">Email address</label>
  <input type="email" id="email" name="email" autocomplete="email">

  <label for="phone">Phone number</label>
  <input type="tel" id="phone" name="phone" autocomplete="tel">

  <button type="submit">Send</button>
</form>', ARRAY['Each label needs for="…" matching the id of its input.', 'Add name="…" to each input, usually the same word as the id.', 'The autocomplete values here are name, email and tel.']::text[],
       45, 2,
       (select id from public.skills where slug = 'forms'), false
from public.lessons l where l.slug = 'labels-and-inputs'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'label[for]', NULL,
       NULL, NULL, 3, 3,
       'Three labels, each with a for attribute', NULL, 1, true
from public.exercises e where e.slug = 'labels-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'Every input is labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'labels-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'input', 'name',
       NULL, NULL, NULL, NULL,
       'Every input has a name so its value is submitted', NULL, 1, true
from public.exercises e where e.slug = 'labels-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'input', 'autocomplete',
       NULL, NULL, NULL, NULL,
       'Every input declares its autocomplete purpose', NULL, 1, true
from public.exercises e where e.slug = 'labels-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'labels-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'input-types-debug', 2, 'debug'::public.exercise_kind, 'Four wrong input types',
       'Each field uses a type that causes a real problem. Fix them: the email field should validate, the phone should not be a number, the postcode should not strip its formatting, and the password should be hidden.', '<form>
  <label for="email">Email address</label>
  <input type="text" id="email" name="email">

  <label for="phone">Phone number</label>
  <input type="number" id="phone" name="phone">

  <label for="postcode">Postcode</label>
  <input type="number" id="postcode" name="postcode">

  <label for="password">Password</label>
  <input type="text" id="password" name="password">
</form>', '<form>
  <label for="email">Email address</label>
  <input type="email" id="email" name="email" autocomplete="email">

  <label for="phone">Phone number</label>
  <input type="tel" id="phone" name="phone" inputmode="tel" autocomplete="tel">

  <label for="postcode">Postcode</label>
  <input type="text" id="postcode" name="postcode" autocomplete="postal-code">

  <label for="password">Password</label>
  <input type="password" id="password" name="password" autocomplete="current-password">
</form>', ARRAY['The email field should be type="email" so the browser checks for an @.', 'Phone numbers are not quantities — use type="tel".', 'A postcode contains letters and a space, so type="text" is correct.', 'A password field must be type="password".']::text[],
       50, 3,
       (select id from public.skills where slug = 'forms'), false
from public.lessons l where l.slug = 'labels-and-inputs'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'input#email', 'type',
       'email', NULL, NULL, NULL,
       'The email field uses type="email"', NULL, 1, true
from public.exercises e where e.slug = 'input-types-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'input#phone', 'type',
       'tel', NULL, NULL, NULL,
       'The phone field uses type="tel"', NULL, 1, true
from public.exercises e where e.slug = 'input-types-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'input#postcode', 'type',
       'text', NULL, NULL, NULL,
       'The postcode field uses type="text"', NULL, 1, true
from public.exercises e where e.slug = 'input-types-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'input#password', 'type',
       'password', NULL, NULL, NULL,
       'The password field is hidden as it is typed', NULL, 1, true
from public.exercises e where e.slug = 'input-types-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'All fields remain labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'input-types-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'labels-and-inputs'), NULL, 'q-label-for', 1, 'single'::public.question_kind,
        'What joins a `<label>` to its input?', 'The label''s `for` attribute must match the input''s `id` exactly.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The label''s for matches the input''s id', true, NULL
from public.quiz_questions where slug = 'q-label-for';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'They must be next to each other in the HTML', false, NULL
from public.quiz_questions where slug = 'q-label-for';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The label''s for matches the input''s name', false, NULL
from public.quiz_questions where slug = 'q-label-for';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The input''s placeholder matches the label text', false, NULL
from public.quiz_questions where slug = 'q-label-for';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'labels-and-inputs'), NULL, 'q-placeholder', 2, 'single'::public.question_kind,
        'Why should placeholder text not be used as a label?', 'It disappears as soon as the user types, its contrast usually fails WCAG, and screen-reader support is inconsistent.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It only works on text inputs', false, NULL
from public.quiz_questions where slug = 'q-placeholder';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It vanishes on typing and has poor contrast and support', true, NULL
from public.quiz_questions where slug = 'q-placeholder';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Placeholders are not valid HTML', false, NULL
from public.quiz_questions where slug = 'q-placeholder';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It prevents the field being submitted', false, NULL
from public.quiz_questions where slug = 'q-placeholder';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'labels-and-inputs'), NULL, 'q-number-type', 3, 'single'::public.question_kind,
        'Which field should NOT use `type="number"`?', '`number` is for quantities. A phone number is not a quantity — it can contain spaces and leading zeros, both of which `number` damages.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'An age in years', false, NULL
from public.quiz_questions where slug = 'q-number-type';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A number of nights', false, NULL
from public.quiz_questions where slug = 'q-number-type';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A phone number', true, NULL
from public.quiz_questions where slug = 'q-number-type';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A quantity of bikes to hire', false, NULL
from public.quiz_questions where slug = 'q-number-type';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'labels-and-inputs'), NULL, 'q-name-attribute', 4, 'single'::public.question_kind,
        'What happens to an input with no `name` attribute?', 'Its value is not submitted with the form at all.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It fails validation', false, NULL
from public.quiz_questions where slug = 'q-name-attribute';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nothing — name is optional', false, NULL
from public.quiz_questions where slug = 'q-name-attribute';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Its value is not submitted', true, NULL
from public.quiz_questions where slug = 'q-name-attribute';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It cannot be labelled', false, NULL
from public.quiz_questions where slug = 'q-name-attribute';
-- lesson: Grouping, selects, checkboxes and buttons
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'grouping-and-controls', 2, 'Grouping, selects, checkboxes and buttons', 'Making a long form comprehensible', 'Fieldsets, legends, radio groups, select menus and the button types that behave differently.',
       ARRAY['Group related controls with fieldset and legend', 'Build correct radio and checkbox groups', 'Use select, optgroup and the three button types']::text[], 15, 40, (select id from public.skills where slug = 'forms'), 0.7
from public.modules m where m.slug = 'form-foundations'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Group radio buttons in a fieldset with a legend","Build a select menu with grouped options","Choose between button types correctly"]}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'A radio group has a problem a single input does not: each radio has its own label, but the *question* has no label at all. `<fieldset>` and `<legend>` solve exactly that.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<fieldset>
  <legend>Which bike would you like?</legend>

  <input type="radio" id="hybrid" name="biketype" value="hybrid" checked>
  <label for="hybrid">Hybrid</label>

  <input type="radio" id="road" name="biketype" value="road">
  <label for="road">Road bike</label>
</fieldset>', 'html', NULL, '{"annotations":[{"line":"1","text":"`<fieldset>` groups related controls."},{"line":"2","text":"`<legend>` is the group''s label and must be the first child. A screen reader announces it before each option, so the user hears \"Which bike would you like? Hybrid, radio button, 1 of 2\"."},{"line":"4","text":"All the radios share the same `name`. That is what makes them one group where only one can be chosen — not the fieldset."},{"line":"4","text":"`value` is what gets submitted. Radio and checkbox labels are for humans; `value` is for the server."},{"line":"4","text":"`checked` sets the default. Choosing a sensible default saves everyone a click."}]}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Radios grouped by fieldset instead of by name', 'Two radio buttons with *different* `name` values can both be selected at once, however they are wrapped. The shared `name` is what creates the group; the fieldset only labels it.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'Radio or checkbox?', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Radio — choose one","code":"<input type=\"radio\" name=\"size\" value=\"s\" id=\"s\">\n<label for=\"s\">Small</label>\n<input type=\"radio\" name=\"size\" value=\"m\" id=\"m\">\n<label for=\"m\">Medium</label>","why":"Same name, so selecting one deselects the other."},"bad":{"label":"Checkbox — choose any number","code":"<input type=\"checkbox\" name=\"extras\" value=\"helmet\" id=\"helmet\">\n<label for=\"helmet\">Helmet</label>\n<input type=\"checkbox\" name=\"extras\" value=\"lock\" id=\"lock\">\n<label for=\"lock\">Lock</label>","why":"Also a shared name, but checkboxes are independent — any combination can be ticked."}}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, 'A select menu with grouped options', NULL,
       '<label for="route">Which route?</label>
<select id="route" name="route">
  <optgroup label="Easy">
    <option value="harbour">Harbour loop — 6 miles</option>
    <option value="mill">Mill and back — 11 miles</option>
  </optgroup>
  <optgroup label="Harder">
    <option value="valley">The full valley — 24 miles</option>
  </optgroup>
</select>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'When not to use a select', 'Under about five options, radio buttons are faster and clearer — everything is visible at once with no interaction needed. A select earns its place when the list is long, or when it needs to be searchable. Never use one for a yes/no question.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'prose'::public.block_type, NULL, 'There are three button types, and the difference matters.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'code_example'::public.block_type, 'The three button types', NULL,
       '<button type="submit">Send enquiry</button>   Submits the form. The default.
<button type="reset">Clear form</button>      Wipes every field. Almost never wanted.
<button type="button">Show more</button>      Does nothing without JavaScript.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'callout'::public.block_type, 'Always write the type', 'A `<button>` inside a form with no `type` defaults to `submit`. A "Show password" button written without `type="button"` will submit the form when clicked — a genuinely common and confusing bug.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'term'::public.block_type, '<textarea>', 'A multi-line text field. Unlike `<input>` it has a closing tag, and any content between the tags becomes its starting value — so keep it empty unless you want a default.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'progressive_detail'::public.block_type, 'Button versus link', 'A link goes somewhere. A button does something. If clicking it changes the address bar, it should be an `<a>`; if it submits, toggles or opens something on the current page, it should be a `<button>`. This matters because keyboard behaviour differs — a link activates on Enter, a button on Enter *and* Space — and because screen readers announce them differently, setting a different expectation.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'interactive_demo'::public.block_type, 'A question, and a list of unrelated options', 'The difference is one wrapper.',
       NULL, NULL, NULL, '{"variants":[{"label":"Grouped","code":"<fieldset>\n  <legend>How should we contact you?</legend>\n  <input type=\"radio\" id=\"by-email\" name=\"contact\" value=\"email\">\n  <label for=\"by-email\">Email</label>\n  <input type=\"radio\" id=\"by-phone\" name=\"contact\" value=\"phone\">\n  <label for=\"by-phone\">Phone</label>\n</fieldset>","note":"The legend names the group, so the options are announced together with the question they answer."},{"label":"Ungrouped","code":"<p>How should we contact you?</p>\n<input type=\"radio\" id=\"by-email\" name=\"contact\" value=\"email\">\n<label for=\"by-email\">Email</label>\n<input type=\"radio\" id=\"by-phone\" name=\"contact\" value=\"phone\">\n<label for=\"by-phone\">Phone</label>","note":"The question is just a paragraph floating above. A user who jumps straight to the controls hears \"Email, radio button\" with no idea what is being asked."}]}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<fieldset>` groups controls; `<legend>` labels the group and comes first.","A shared `name` creates a radio group, not the fieldset.","`value` is submitted; the label is for the human.","Always write `type` on a button, or it will submit the form.","Links navigate; buttons act."],"nextUp":"Next: validation attributes and the milestone form."}'::jsonb
from public.lessons where slug = 'grouping-and-controls';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'fieldset-guided', 1, 'guided'::public.exercise_kind, 'Build a radio group properly',
       'Wrap these radio buttons in a `<fieldset>` with the legend "Which bike would you like?", give them all the same `name` of `biketype`, add a `value` to each, and label each one.', '<form>
  <input type="radio" id="hybrid">
  Hybrid
  <input type="radio" id="road">
  Road bike
  <button type="submit">Send</button>
</form>', '<form>
  <fieldset>
    <legend>Which bike would you like?</legend>

    <input type="radio" id="hybrid" name="biketype" value="hybrid" checked>
    <label for="hybrid">Hybrid</label>

    <input type="radio" id="road" name="biketype" value="road">
    <label for="road">Road bike</label>
  </fieldset>
  <button type="submit">Send</button>
</form>', ARRAY['The <legend> must be the first child of the <fieldset>.', 'Both radios need name="biketype" — that is what makes them one group.', 'Wrap the visible words in <label for="…"> matching each id.']::text[],
       50, 3,
       (select id from public.skills where slug = 'forms'), false
from public.lessons l where l.slug = 'grouping-and-controls'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'fieldset > legend', NULL,
       NULL, NULL, NULL, NULL,
       'The fieldset has a legend as its first child', NULL, 1, true
from public.exercises e where e.slug = 'fieldset-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'text_not_empty'::public.requirement_kind, 'legend', NULL,
       NULL, NULL, NULL, NULL,
       'The legend has text', NULL, 1, true
from public.exercises e where e.slug = 'fieldset-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'input[type="radio"][name="biketype"]', NULL,
       NULL, NULL, 2, 2,
       'Both radios share the name biketype', NULL, 1, true
from public.exercises e where e.slug = 'fieldset-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'input[type="radio"]', 'value',
       NULL, NULL, NULL, NULL,
       'Each radio has a value to submit', NULL, 1, true
from public.exercises e where e.slug = 'fieldset-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'label[for]', NULL,
       NULL, NULL, 2, 2,
       'Each radio has an associated label', NULL, 1, true
from public.exercises e where e.slug = 'fieldset-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'Every control is labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'fieldset-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'controls-challenge', 2, 'challenge'::public.exercise_kind, 'A booking form section',
       'Build a form section containing: a `<select>` with two `<optgroup>` groups of routes, a fieldset of at least two checkboxes for optional extras, a `<textarea>` for notes, and a submit button with an explicit type. Label everything.', '', '<form>
  <label for="route">Which route?</label>
  <select id="route" name="route">
    <optgroup label="Easy">
      <option value="harbour">Harbour loop — 6 miles</option>
      <option value="mill">Mill and back — 11 miles</option>
    </optgroup>
    <optgroup label="Harder">
      <option value="valley">The full valley — 24 miles</option>
    </optgroup>
  </select>

  <fieldset>
    <legend>Optional extras</legend>
    <input type="checkbox" id="childseat" name="extras" value="childseat">
    <label for="childseat">Child seat</label>
    <input type="checkbox" id="pannier" name="extras" value="pannier">
    <label for="pannier">Pannier bags</label>
  </fieldset>

  <label for="notes">Anything we should know?</label>
  <textarea id="notes" name="notes" rows="4"></textarea>

  <button type="submit">Request a booking</button>
</form>', ARRAY['The select needs a label, and each optgroup needs a label attribute.', 'Checkboxes go in a fieldset with a legend describing the group.', 'The textarea has a closing tag — leave it empty so the field starts blank.', 'Write type="submit" on the button explicitly.']::text[],
       65, 4,
       (select id from public.skills where slug = 'forms'), false
from public.lessons l where l.slug = 'grouping-and-controls'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'select', NULL,
       NULL, NULL, NULL, NULL,
       'There is a select menu', NULL, 1, true
from public.exercises e where e.slug = 'controls-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'optgroup', NULL,
       NULL, NULL, 2, NULL,
       'The options are grouped into at least two optgroups', NULL, 1, true
from public.exercises e where e.slug = 'controls-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'optgroup', 'label',
       NULL, NULL, NULL, NULL,
       'Each optgroup has a label', NULL, 1, true
from public.exercises e where e.slug = 'controls-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'fieldset > legend', NULL,
       NULL, NULL, NULL, NULL,
       'The checkboxes are in a labelled fieldset', NULL, 1, true
from public.exercises e where e.slug = 'controls-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'input[type="checkbox"]', NULL,
       NULL, NULL, 2, NULL,
       'There are at least two checkboxes', NULL, 1, true
from public.exercises e where e.slug = 'controls-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_present'::public.requirement_kind, 'textarea', NULL,
       NULL, NULL, NULL, NULL,
       'There is a textarea', NULL, 1, true
from public.exercises e where e.slug = 'controls-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'attribute_value'::public.requirement_kind, 'button', 'type',
       'submit', NULL, NULL, NULL,
       'The button has an explicit type', NULL, 1, true
from public.exercises e where e.slug = 'controls-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'label_association'::public.requirement_kind, 'input, select, textarea', NULL,
       NULL, NULL, NULL, NULL,
       'Every control is labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'controls-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'controls-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'grouping-and-controls'), NULL, 'q-radio-group', 1, 'single'::public.question_kind,
        'What makes two radio buttons part of the same group?', 'A shared `name` attribute. The fieldset labels the group but does not create it.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'They are inside the same fieldset', false, NULL
from public.quiz_questions where slug = 'q-radio-group';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'They share the same id', false, NULL
from public.quiz_questions where slug = 'q-radio-group';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'They are adjacent in the HTML', false, NULL
from public.quiz_questions where slug = 'q-radio-group';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'They share the same name attribute', true, NULL
from public.quiz_questions where slug = 'q-radio-group';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'grouping-and-controls'), NULL, 'q-button-type', 2, 'single'::public.question_kind,
        'A `<button>` inside a form with no `type` attribute — what does it do when clicked?', 'It submits the form, because `submit` is the default type.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Nothing', false, NULL
from public.quiz_questions where slug = 'q-button-type';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Resets the form', false, NULL
from public.quiz_questions where slug = 'q-button-type';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Depends on the browser', false, NULL
from public.quiz_questions where slug = 'q-button-type';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Submits the form', true, NULL
from public.quiz_questions where slug = 'q-button-type';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'grouping-and-controls'), NULL, 'q-legend-position', 3, 'single'::public.question_kind,
        'Where must `<legend>` appear?', 'As the first child of its `<fieldset>`.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Immediately before the fieldset', false, NULL
from public.quiz_questions where slug = 'q-legend-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Anywhere inside the fieldset', false, NULL
from public.quiz_questions where slug = 'q-legend-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'As the last child of the fieldset', false, NULL
from public.quiz_questions where slug = 'q-legend-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'As the first child of the fieldset', true, NULL
from public.quiz_questions where slug = 'q-legend-position';
-- lesson: Validation, form security, and the milestone form
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'validation-and-form-milestone', 3, 'Validation, form security, and the milestone form', 'What the browser can check, and what it absolutely cannot', 'Native validation attributes cost nothing and catch most mistakes. They are also no defence whatsoever against an attacker.',
       ARRAY['Use required, pattern, min, max, step, minlength and maxlength', 'Explain the difference between GET and POST', 'Explain why client-side validation is not security']::text[], 24, 40, (select id from public.skills where slug = 'forms'), 0.8
from public.modules m where m.slug = 'form-foundations'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Apply native validation attributes correctly","Choose between GET and POST for a form","Explain why every input must be re-validated on the server"]}'::jsonb
from public.lessons where slug = 'validation-and-form-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'The native validation attributes', NULL,
       'required                  Must be filled in
minlength="8"             At least 8 characters
maxlength="200"           At most 200 characters
min="1"  max="10"         Numeric or date range
step="0.5"                Allowed increments
pattern="[A-Z]{2}[0-9]+"  Must match this regular expression
multiple                  Accept several values (email or file)
accept="image/*,.pdf"     Which file types a file input offers', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'validation-and-form-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<label for="people">How many people?</label>
<input type="number" id="people" name="people"
       min="1" max="8" step="1" value="2" required>

<label for="postcode">Postcode</label>
<input type="text" id="postcode" name="postcode"
       inputmode="text" autocomplete="postal-code"
       pattern="[A-Za-z]{1,2}[0-9][A-Za-z0-9]? ?[0-9][A-Za-z]{2}"
       required
       aria-describedby="postcode-hint">
<p id="postcode-hint">For example: HX2 4PL</p>', 'html', NULL, '{"annotations":[{"line":"3","text":"`min` and `max` bound the value; `step=\"1\"` allows whole numbers only."},{"line":"3","text":"`value=\"2\"` sets a sensible starting point."},{"line":"8","text":"`pattern` takes a regular expression the value must match. The whole value must match, so no anchors are needed."},{"line":"10","text":"`aria-describedby` links the field to its hint, so a screen reader reads the format example *after* the label. Without it the hint is just a paragraph nobody hears at the right moment."}]}'::jsonb
from public.lessons where slug = 'validation-and-form-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'A pattern always needs a visible hint', 'If a value is rejected for not matching a pattern, the browser''s default message is unhelpfully vague. Say what the format is, in plain words, near the field — and connect it with `aria-describedby`. A validation rule the user cannot see is a trap.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'validation-and-form-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'method', 'How the form is sent. `GET` puts the values in the URL; `POST` puts them in the request body.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'validation-and-form-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'comparison'::public.block_type, 'GET or POST?', NULL,
       NULL, NULL, NULL, '{"good":{"label":"GET — for searches and filters","code":"<form action=\"/search\" method=\"get\">\n  <label for=\"q\">Search routes</label>\n  <input type=\"search\" id=\"q\" name=\"q\">\n  <button type=\"submit\">Search</button>\n</form>","why":"The values appear in the URL, so results can be bookmarked and shared. Correct when the form only reads data."},"bad":{"label":"POST — for anything that changes something","code":"<form action=\"/enquiry\" method=\"post\">\n  <label for=\"message\">Your message</label>\n  <textarea id=\"message\" name=\"message\"></textarea>\n  <button type=\"submit\">Send</button>\n</form>","why":"Values are not in the URL, not in browser history, and not in server logs. Correct for anything private or anything that creates a record."}}'::jsonb
from public.lessons where slug = 'validation-and-form-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'Client-side validation is a convenience, never a security control', 'Every attribute on this page can be removed in two clicks with browser developer tools, and a request can be sent to your server without ever loading your page. Native validation exists to help honest users get it right first time. The server must re-check every single value as though nothing had been checked at all. HTML cannot secure anything — this is the most important sentence in this level.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'validation-and-form-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'progressive_detail'::public.block_type, 'What else does form security involve?', 'Beyond server-side validation: serve the form over HTTPS so values are not readable in transit; use a CSRF token so another site cannot submit the form on a signed-in user''s behalf; rate-limit submissions; and never put secrets in `<input type="hidden">`, which is visible to anyone who views the source. Those are all server-side concerns, and HTML''s honest role is to make the field purposes clear enough that the server knows what it is validating.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'validation-and-form-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'checklist'::public.block_type, 'The milestone form needs', NULL,
       NULL, NULL, NULL, '{"items":["`<form>` with an `action` and `method=\"post\"`","Every control labelled with `<label for=\"…\">`","A `<fieldset>` with a `<legend>` around at least one group","At least four different input types","`required` on the fields that genuinely are","`autocomplete` on every personal-detail field","A hint connected with `aria-describedby`","A `<textarea>` for a message","A submit button with an explicit `type`"]}'::jsonb
from public.lessons where slug = 'validation-and-form-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'interactive_demo'::public.block_type, 'Client-side validation, and what it is worth', 'The same field, three ways of asking.',
       NULL, NULL, NULL, '{"variants":[{"label":"Typed and required","code":"<label for=\"email\">Email address</label>\n<input type=\"email\" id=\"email\" name=\"email\" autocomplete=\"email\" required>","note":"The right keyboard on a phone, browser-level checking, autofill, and a real label. All of it helps honest users and stops nobody else."},{"label":"Untyped","code":"<label for=\"email\">Email address</label>\n<input type=\"text\" id=\"email\" name=\"email\">","note":"Works, but gives up the mobile keyboard, the built-in check and the autofill hint for no gain."},{"label":"Pattern with no hint","code":"<label for=\"postcode\">Postcode</label>\n<input type=\"text\" id=\"postcode\" name=\"postcode\" pattern=\"[A-Z]{1,2}[0-9]{1,2} ?[0-9][A-Z]{2}\" required>","note":"Rejects valid-looking input with no explanation of the rule. A pattern always needs a visible description of what it wants."}]}'::jsonb
from public.lessons where slug = 'validation-and-form-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'recall'::public.block_type, 'Four levels back', 'Before you build the form, reach back four levels. From memory, and without scrolling: what does each of these give you, and what breaks without it?',
       NULL, NULL, NULL, '{"points":["Level 1 — the document skeleton: doctype, `<html lang>`, `<head>` with a charset and title, `<body>`. Without the charset, accented characters and currency symbols break.","Level 2 — headings describe structure, not size. A skipped level leaves a gap in the outline a screen-reader user navigates by.","Level 3 — link text has to make sense read on its own, because links are commonly listed with the surrounding sentence removed.","Level 5 — landmarks let assistive technology jump to a region. Exactly one `<main>`, holding what is unique to this page."]}'::jsonb
from public.lessons where slug = 'validation-and-form-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Native validation attributes catch most honest mistakes for free.","`pattern` always needs a visible, connected hint.","GET for reading, POST for anything that changes or is private.","The server must revalidate everything. HTML secures nothing."],"nextUp":"Level 7 next: native interactive elements."}'::jsonb
from public.lessons where slug = 'validation-and-form-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'validation-guided', 1, 'guided'::public.exercise_kind, 'Add validation to three fields',
       'Add validation: the name must be required and at least two characters; the party size must be a whole number between 1 and 8; the postcode must be required and connected to its hint with `aria-describedby`.', '<form action="/booking" method="post">
  <label for="name">Full name</label>
  <input type="text" id="name" name="name" autocomplete="name">

  <label for="people">How many people?</label>
  <input type="number" id="people" name="people">

  <label for="postcode">Postcode</label>
  <input type="text" id="postcode" name="postcode" autocomplete="postal-code">
  <p id="postcode-hint">For example: HX2 4PL</p>

  <button type="submit">Request a booking</button>
</form>', '<form action="/booking" method="post">
  <label for="name">Full name</label>
  <input type="text" id="name" name="name" autocomplete="name" required minlength="2">

  <label for="people">How many people?</label>
  <input type="number" id="people" name="people" min="1" max="8" step="1" value="2" required>

  <label for="postcode">Postcode</label>
  <input type="text" id="postcode" name="postcode" autocomplete="postal-code"
         required aria-describedby="postcode-hint">
  <p id="postcode-hint">For example: HX2 4PL</p>

  <button type="submit">Request a booking</button>
</form>', ARRAY['required is a boolean attribute — write the word on its own.', 'The number field needs min="1" max="8" step="1".', 'aria-describedby="postcode-hint" points at the id of the hint paragraph.']::text[],
       55, 3,
       (select id from public.skills where slug = 'forms'), false
from public.lessons l where l.slug = 'validation-and-form-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'input#name', 'required',
       NULL, NULL, NULL, NULL,
       'The name field is required', NULL, 1, true
from public.exercises e where e.slug = 'validation-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'input#name', 'minlength',
       NULL, NULL, NULL, NULL,
       'The name has a minimum length', NULL, 1, true
from public.exercises e where e.slug = 'validation-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'input#people', 'min',
       '1', NULL, NULL, NULL,
       'The party size has a minimum of 1', NULL, 1, true
from public.exercises e where e.slug = 'validation-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'input#people', 'max',
       '8', NULL, NULL, NULL,
       'The party size has a maximum of 8', NULL, 1, true
from public.exercises e where e.slug = 'validation-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_value'::public.requirement_kind, 'input#postcode', 'aria-describedby',
       'postcode-hint', NULL, NULL, NULL,
       'The postcode is connected to its hint', NULL, 1, true
from public.exercises e where e.slug = 'validation-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'Every field is still labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'validation-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'form-milestone', 2, 'challenge'::public.exercise_kind, 'Milestone: a professional enquiry form',
       'Build a complete, accessible enquiry or booking form meeting every item on the checklist above. Content is yours; the structure and accessibility are what is assessed.', '', '<h1>Book a bike</h1>

<form action="/booking" method="post">
  <label for="name">Full name</label>
  <input type="text" id="name" name="name" autocomplete="name" required minlength="2">

  <label for="email">Email address</label>
  <input type="email" id="email" name="email" autocomplete="email" required
         aria-describedby="email-hint">
  <p id="email-hint">We will only use this to confirm your booking.</p>

  <label for="phone">Phone number</label>
  <input type="tel" id="phone" name="phone" autocomplete="tel" inputmode="tel">

  <label for="date">Preferred date</label>
  <input type="date" id="date" name="date" min="2026-01-01" required>

  <label for="people">How many bikes?</label>
  <input type="number" id="people" name="people" min="1" max="8" step="1" value="2" required>

  <fieldset>
    <legend>Which bike would you like?</legend>
    <input type="radio" id="hybrid" name="biketype" value="hybrid" checked>
    <label for="hybrid">Hybrid</label>
    <input type="radio" id="road" name="biketype" value="road">
    <label for="road">Road bike</label>
  </fieldset>

  <fieldset>
    <legend>Optional extras</legend>
    <input type="checkbox" id="childseat" name="extras" value="childseat">
    <label for="childseat">Child seat</label>
    <input type="checkbox" id="pannier" name="extras" value="pannier">
    <label for="pannier">Pannier bags</label>
  </fieldset>

  <label for="notes">Anything we should know?</label>
  <textarea id="notes" name="notes" rows="4" maxlength="500"></textarea>

  <button type="submit">Request a booking</button>
</form>', ARRAY['Start with <form action="…" method="post">.', 'Add fields one at a time, each with its own <label for="…">.', 'Use at least four different input types: text, email, tel, date, number are all available.', 'Wrap the radios and the checkboxes in fieldsets with legends.', 'Connect at least one hint paragraph with aria-describedby.']::text[],
       160, 5,
       (select id from public.skills where slug = 'forms'), false
from public.lessons l where l.slug = 'validation-and-form-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'form[action]', NULL,
       NULL, NULL, NULL, NULL,
       'The form has an action', NULL, 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'form', 'method',
       'post', NULL, NULL, NULL,
       'The form uses POST', NULL, 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'label_association'::public.requirement_kind, 'input, select, textarea', NULL,
       NULL, NULL, NULL, NULL,
       'Every control has a label', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'fieldset > legend', NULL,
       NULL, NULL, 1, NULL,
       'At least one group is wrapped in a fieldset with a legend', NULL, 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'input[type="email"]', NULL,
       NULL, NULL, 1, NULL,
       'There is an email field', NULL, 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'input[required]', NULL,
       NULL, NULL, 2, NULL,
       'At least two fields are required', NULL, 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'attribute_present'::public.requirement_kind, 'input[type="text"], input[type="email"], input[type="tel"]', 'autocomplete',
       NULL, NULL, NULL, NULL,
       'Personal-detail fields declare their autocomplete purpose', NULL, 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'element_present'::public.requirement_kind, '[aria-describedby]', NULL,
       NULL, NULL, NULL, NULL,
       'At least one field is connected to a hint', NULL, 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'element_present'::public.requirement_kind, 'textarea', NULL,
       NULL, NULL, NULL, NULL,
       'There is a textarea for a message', NULL, 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'attribute_value'::public.requirement_kind, 'button', 'type',
       'submit', NULL, NULL, NULL,
       'The submit button has an explicit type', NULL, 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'accessible_name'::public.requirement_kind, 'button', NULL,
       NULL, NULL, NULL, NULL,
       'The button has visible text', NULL, 1, true
from public.exercises e where e.slug = 'form-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'form-mission', 3, 'project_mission'::public.exercise_kind, 'Capstone mission: build contact.html',
       'Build the contact page your navigation has been linking to since Level 3. It needs the full page structure — header, nav, main, footer — plus an accessible form suited to your project.', '<main id="main">
  <h1>Contact us</h1>
  <p>Introduce the form in a sentence.</p>

  <form action="/contact" method="post">
    <!-- Build your form here -->
  </form>
</main>', '<main id="main">
  <h1>Contact us</h1>
  <p>Send us a message and we will reply the same working day.</p>

  <form action="/contact" method="post">
    <label for="name">Your name</label>
    <input type="text" id="name" name="name" autocomplete="name" required>

    <label for="email">Email address</label>
    <input type="email" id="email" name="email" autocomplete="email" required
           aria-describedby="email-hint">
    <p id="email-hint">We will only use this to reply to you.</p>

    <fieldset>
      <legend>What is your enquiry about?</legend>
      <input type="radio" id="booking" name="topic" value="booking" checked>
      <label for="booking">A booking</label>
      <input type="radio" id="other" name="topic" value="other">
      <label for="other">Something else</label>
    </fieldset>

    <label for="message">Your message</label>
    <textarea id="message" name="message" rows="5" required maxlength="1000"></textarea>

    <button type="submit">Send message</button>
  </form>
</main>', ARRAY['Keep the page structure you built in Level 5 — header, nav, main, footer.', 'The form needs at least a name, an email and a message.', 'Every control needs a label; the radio group needs a fieldset and legend.']::text[],
       110, 4,
       (select id from public.skills where slug = 'forms'), false
from public.lessons l where l.slug = 'validation-and-form-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'The page has a main element', NULL, 1, true
from public.exercises e where e.slug = 'form-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside main', NULL, 1, true
from public.exercises e where e.slug = 'form-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'form[action][method]', NULL,
       NULL, NULL, NULL, NULL,
       'The form has an action and a method', NULL, 1, true
from public.exercises e where e.slug = 'form-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'label_association'::public.requirement_kind, 'input, select, textarea', NULL,
       NULL, NULL, NULL, NULL,
       'Every control is labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'form-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'textarea', NULL,
       NULL, NULL, NULL, NULL,
       'There is a message field', NULL, 1, true
from public.exercises e where e.slug = 'form-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'input[required], textarea[required]', NULL,
       NULL, NULL, 1, NULL,
       'At least one field is required', NULL, 1, true
from public.exercises e where e.slug = 'form-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'attribute_value'::public.requirement_kind, 'button', 'type',
       'submit', NULL, NULL, NULL,
       'The submit button has an explicit type', NULL, 1, true
from public.exercises e where e.slug = 'form-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'form-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'form-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'validation-and-form-milestone'), NULL, 'q-client-validation', 1, 'single'::public.question_kind,
        'Is `required` a security feature?', 'No. It can be removed with developer tools, and a request can be sent without loading your page at all. The server must revalidate everything.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Only over HTTPS', false, NULL
from public.quiz_questions where slug = 'q-client-validation';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'No — the server must revalidate every value', true, NULL
from public.quiz_questions where slug = 'q-client-validation';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Yes, browsers enforce it before submission', false, NULL
from public.quiz_questions where slug = 'q-client-validation';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Yes, when combined with pattern', false, NULL
from public.quiz_questions where slug = 'q-client-validation';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'validation-and-form-milestone'), NULL, 'q-get-vs-post', 2, 'single'::public.question_kind,
        'Which method should a login form use?', 'POST. GET would put the password in the URL, browser history and server logs.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'GET', false, NULL
from public.quiz_questions where slug = 'q-get-vs-post';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Either works equally well', false, NULL
from public.quiz_questions where slug = 'q-get-vs-post';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'PUT', false, NULL
from public.quiz_questions where slug = 'q-get-vs-post';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'POST', true, NULL
from public.quiz_questions where slug = 'q-get-vs-post';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'validation-and-form-milestone'), NULL, 'q-aria-describedby', 3, 'single'::public.question_kind,
        'What does `aria-describedby` on an input do?', 'It connects the field to descriptive text elsewhere on the page, so a screen reader reads the hint after the label.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Connects the field to a hint that screen readers announce', true, NULL
from public.quiz_questions where slug = 'q-aria-describedby';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Replaces the field''s label', false, NULL
from public.quiz_questions where slug = 'q-aria-describedby';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Sets the validation error message', false, NULL
from public.quiz_questions where slug = 'q-aria-describedby';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Adds a tooltip on hover', false, NULL
from public.quiz_questions where slug = 'q-aria-describedby';
-- Level 6 milestone: Data and Forms Builder questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-6-milestone'), 'a6-q1', 1, 'single'::public.question_kind,
        'Which element gives a table its title?', '`<caption>`, as the first child of `<table>`.', (select id from public.skills where slug = 'tables'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<caption>', true, NULL
from public.quiz_questions where slug = 'a6-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<thead>', false, NULL
from public.quiz_questions where slug = 'a6-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<legend>', false, NULL
from public.quiz_questions where slug = 'a6-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<summary>', false, NULL
from public.quiz_questions where slug = 'a6-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-6-milestone'), 'a6-q2', 2, 'single'::public.question_kind,
        'A cell contains "£34". A screen reader announces "Road bike, Per day, £34". What made that possible?', 'Header cells with `scope`, telling the screen reader which headings apply to that cell.', (select id from public.skills where slug = 'tables'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The table caption', false, NULL
from public.quiz_questions where slug = 'a6-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A title attribute on the cell', false, NULL
from public.quiz_questions where slug = 'a6-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'colspan on the header row', false, NULL
from public.quiz_questions where slug = 'a6-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<th> cells with scope attributes', true, NULL
from public.quiz_questions where slug = 'a6-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-6-milestone'), 'a6-q3', 3, 'single'::public.question_kind,
        'What connects a label to its input?', 'The label''s `for` value matches the input''s `id`.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Being adjacent in the source', false, NULL
from public.quiz_questions where slug = 'a6-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A shared class', false, NULL
from public.quiz_questions where slug = 'a6-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'for matching id', true, NULL
from public.quiz_questions where slug = 'a6-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'for matching name', false, NULL
from public.quiz_questions where slug = 'a6-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-6-milestone'), 'a6-q4', 4, 'single'::public.question_kind,
        'Which attribute makes two radio buttons mutually exclusive?', 'A shared `name` attribute. The fieldset labels the group for screen readers, but it is the matching name that makes the browser treat them as one choice.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'group', false, NULL
from public.quiz_questions where slug = 'a6-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'name', true, NULL
from public.quiz_questions where slug = 'a6-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'id', false, NULL
from public.quiz_questions where slug = 'a6-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'value', false, NULL
from public.quiz_questions where slug = 'a6-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-6-milestone'), 'a6-q5', 5, 'single'::public.question_kind,
        'Which input type suits a UK postcode?', 'A postcode contains letters and a space, so `text`. `number` would strip formatting and reject letters.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'text', true, NULL
from public.quiz_questions where slug = 'a6-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'number', false, NULL
from public.quiz_questions where slug = 'a6-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'tel', false, NULL
from public.quiz_questions where slug = 'a6-q5';

commit;
