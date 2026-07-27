-- HTML Hero — course seed, part 7 of 8
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 6 first.

begin;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Produce a head containing every piece of metadata a real page needs","Combine metadata with correct semantic body structure","Update your capstone pages to match"]}'::jsonb
from public.lessons where slug = 'seo-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'checklist'::public.block_type, 'The milestone page head needs', NULL,
       NULL, NULL, NULL, '{"items":["`<meta charset=\"utf-8\">` first","A viewport meta tag","A unique, specific `<title>` of about 50–60 characters","A `<meta name=\"description\">` of about 150 characters","A `<link rel=\"canonical\">`","A favicon","Open Graph title, description, image, image alt, url and type","A Twitter card tag","A JSON-LD structured-data block","`lang` on the `<html>` element"]}'::jsonb
from public.lessons where slug = 'seo-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'callout'::public.block_type, 'Write the metadata after the content, not before', 'A description is a summary. Writing it before the page exists produces a vague sentence that could describe anything. Write the page, then read it back and describe it honestly in one sentence — that sentence is your description, and it is usually a good og:description too.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'seo-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'A complete head, in the order it should be written', NULL,
       '<!-- Order matters: charset first, then viewport, then everything else -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Bike hire prices — Riverside Cycle Hire</title>
<meta name="description" content="Hourly, daily and weekly hire from £6.">
<link rel="canonical" href="https://riverside-cycles.example/prices.html">
<link rel="icon" href="/favicon.svg" type="image/svg+xml">

<meta property="og:title" content="Bike hire prices — Riverside Cycle Hire">
<meta property="og:image" content="https://riverside-cycles.example/share-1200.jpg">
<meta property="og:url" content="https://riverside-cycles.example/prices.html">', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'seo-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'What a shared link looks like', NULL,
       NULL, NULL, NULL, '{"good":{"label":"With Open Graph tags","code":"<meta property=\"og:title\" content=\"Bike hire prices — Riverside\">\n<meta property=\"og:description\" content=\"Hire from £6 an hour.\">\n<meta property=\"og:image\" content=\"https://riverside-cycles.example/share-1200.jpg\">\n<meta property=\"og:image:alt\" content=\"A blue hybrid bike outside the workshop\">","why":"A card with a large image, your headline and your sentence — chosen by you."},"bad":{"label":"Without","code":"<title>Riverside Cycle Hire</title>","why":"The messaging app guesses: often just the bare URL, or the first stray sentence it finds on the page."}}'::jsonb
from public.lessons where slug = 'seo-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["A complete head is roughly ten lines and takes five minutes.","Every page needs its own title and description.","Social metadata determines what a shared link looks like.","Structured data describes content that genuinely exists on the page."],"nextUp":"Level 10 next: performance and security."}'::jsonb
from public.lessons where slug = 'seo-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'seo-milestone-build', 1, 'challenge'::public.exercise_kind, 'Milestone: a fully optimised page',
       'Build a complete HTML document with everything on the checklist above in the head, plus a body containing header, nav, main with one h1, and footer.', '', '<!DOCTYPE html>
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
</html>', ARRAY['Build the head in order: charset, viewport, title, description, canonical, icon, then the og: tags, then the JSON-LD.', 'og: tags use property="…"; twitter:card uses name="…".', 'The body needs the landmark structure from Level 5.']::text[],
       150, 4,
       (select id from public.skills where slug = 'seo'), false
from public.lessons l where l.slug = 'seo-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'html', 'lang',
       NULL, NULL, NULL, NULL,
       'The html element declares a language', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'direct_child'::public.requirement_kind, 'meta[charset]', NULL,
       NULL, 'head', NULL, NULL,
       'The charset is declared in the head', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'meta[name="viewport"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a viewport meta tag', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one title', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'attribute_present'::public.requirement_kind, 'meta[name="description"]', 'content',
       NULL, NULL, NULL, NULL,
       'There is a meta description', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'element_present'::public.requirement_kind, 'link[rel="canonical"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a canonical link', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'element_present'::public.requirement_kind, 'link[rel="icon"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a favicon', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'element_present'::public.requirement_kind, 'meta[property="og:title"]', NULL,
       NULL, NULL, NULL, NULL,
       'Open Graph title is set', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'element_present'::public.requirement_kind, 'meta[property="og:image"]', NULL,
       NULL, NULL, NULL, NULL,
       'Open Graph image is set', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'element_present'::public.requirement_kind, 'meta[property="og:image:alt"]', NULL,
       NULL, NULL, NULL, NULL,
       'The Open Graph image has alt text', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'element_present'::public.requirement_kind, 'meta[property="og:url"]', NULL,
       NULL, NULL, NULL, NULL,
       'Open Graph url is set', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'element_present'::public.requirement_kind, 'meta[name="twitter:card"]', NULL,
       NULL, NULL, NULL, NULL,
       'A Twitter card is declared', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'attribute_value'::public.requirement_kind, 'script', 'type',
       'application/ld+json', NULL, NULL, NULL,
       'There is a JSON-LD block', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 15, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'The body has a header landmark', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 16, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 17, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'There is a footer landmark', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 18, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one h1', NULL, 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 19, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 20, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'seo-milestone-build';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'seo-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: unique metadata on every page',
       'Give every page of your capstone site its own title, its own description, a canonical URL, a favicon and Open Graph tags. Add a JSON-LD block to your homepage describing what your project actually is.', '<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- A title specific to THIS page -->
  <!-- A description specific to THIS page -->
  <!-- canonical, favicon -->
  <!-- Open Graph tags -->
  <!-- JSON-LD on the homepage -->
</head>', '<head>
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
</head>', ARRAY['The title and description must describe this specific page, not the whole site.', 'The canonical URL is this page''s own address.', 'og:image must be an absolute URL.']::text[],
       95, 3,
       (select id from public.skills where slug = 'metadata'), false
from public.lessons l where l.slug = 'seo-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true
from public.exercises e where e.slug = 'seo-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'text_not_empty'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The title has text', NULL, 1, true
from public.exercises e where e.slug = 'seo-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'meta[name="description"]', 'content',
       NULL, NULL, NULL, NULL,
       'The page has its own description', NULL, 1, true
from public.exercises e where e.slug = 'seo-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'link[rel="canonical"]', NULL,
       NULL, NULL, NULL, NULL,
       'A canonical URL is set', NULL, 1, true
from public.exercises e where e.slug = 'seo-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'link[rel="icon"]', NULL,
       NULL, NULL, NULL, NULL,
       'A favicon is linked', NULL, 1, true
from public.exercises e where e.slug = 'seo-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_present'::public.requirement_kind, 'meta[property="og:title"]', NULL,
       NULL, NULL, NULL, NULL,
       'Open Graph metadata is present', NULL, 1, true
from public.exercises e where e.slug = 'seo-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'attribute_matches'::public.requirement_kind, 'meta[property="og:image"]', 'content',
       '^https?://', NULL, NULL, NULL,
       'The og:image is an absolute URL', NULL, 1, true
from public.exercises e where e.slug = 'seo-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'seo-milestone'), NULL, 'q-metadata-order', 1, 'single'::public.question_kind,
        'Why must `<meta charset>` come first in the head?', 'The browser must know the encoding within the first 1024 bytes. A late declaration forces it to restart parsing.', (select id from public.skills where slug = 'metadata'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The browser needs it within the first 1024 bytes', true, NULL
from public.quiz_questions where slug = 'q-metadata-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It must come before the doctype', false, NULL
from public.quiz_questions where slug = 'q-metadata-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Search engines only read the first meta tag', false, NULL
from public.quiz_questions where slug = 'q-metadata-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It has no effect on order', false, NULL
from public.quiz_questions where slug = 'q-metadata-order';
-- Level 9 milestone: Metadata, SEO and Discoverability questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-9-milestone'), 'a9-q1', 1, 'single'::public.question_kind,
        'Which appears in browser tabs, bookmarks and search results?', 'The `<title>` element.', (select id from public.skills where slug = 'metadata'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<h1>', false, NULL
from public.quiz_questions where slug = 'a9-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'meta description', false, NULL
from public.quiz_questions where slug = 'a9-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'og:title', false, NULL
from public.quiz_questions where slug = 'a9-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<title>', true, NULL
from public.quiz_questions where slug = 'a9-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-9-milestone'), 'a9-q2', 2, 'single'::public.question_kind,
        'Is the meta description a ranking factor?', 'No, but it is usually the text shown under your result, which affects clicks.', (select id from public.skills where slug = 'seo'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Yes, for local searches only', false, NULL
from public.quiz_questions where slug = 'a9-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It has no effect at all', false, NULL
from public.quiz_questions where slug = 'a9-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'No, but it is often the snippet shown in results', true, NULL
from public.quiz_questions where slug = 'a9-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Yes, it is the strongest ranking factor', false, NULL
from public.quiz_questions where slug = 'a9-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-9-milestone'), 'a9-q3', 3, 'single'::public.question_kind,
        'Which format does Google recommend for structured data?', 'JSON-LD, in a `<script type="application/ld+json">` block.', (select id from public.skills where slug = 'structured-data'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'XML sitemaps', false, NULL
from public.quiz_questions where slug = 'a9-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'JSON-LD', true, NULL
from public.quiz_questions where slug = 'a9-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Microdata attributes', false, NULL
from public.quiz_questions where slug = 'a9-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'RDFa', false, NULL
from public.quiz_questions where slug = 'a9-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-9-milestone'), 'a9-q4', 4, 'single'::public.question_kind,
        'What size should an Open Graph image be?', '1200 × 630 pixels is the accepted standard for a large preview card.', (select id from public.skills where slug = 'seo'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '1200 × 630', true, NULL
from public.quiz_questions where slug = 'a9-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '600 × 600', false, NULL
from public.quiz_questions where slug = 'a9-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '320 × 240', false, NULL
from public.quiz_questions where slug = 'a9-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Any size — it is scaled automatically', false, NULL
from public.quiz_questions where slug = 'a9-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-9-milestone'), 'a9-q5', 5, 'single'::public.question_kind,
        'What must structured data describe?', 'Content genuinely present on the page. Marking up things that do not exist is a policy violation.', (select id from public.skills where slug = 'structured-data'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Whatever keywords you want to rank for', false, NULL
from public.quiz_questions where slug = 'a9-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Only the page title', false, NULL
from public.quiz_questions where slug = 'a9-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Your competitors'' content', false, NULL
from public.quiz_questions where slug = 'a9-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Content that is genuinely on the page', true, NULL
from public.quiz_questions where slug = 'a9-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-9-milestone'), 'a9-q6', 6, 'single'::public.question_kind,
        'Why give every page its own title?', 'So visitors can tell tabs and bookmarks apart, and so search engines have something distinguishing to display.', (select id from public.skills where slug = 'seo'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'To increase keyword density', false, NULL
from public.quiz_questions where slug = 'a9-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'To speed up rendering', false, NULL
from public.quiz_questions where slug = 'a9-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'So tabs, bookmarks and results are distinguishable', true, NULL
from public.quiz_questions where slug = 'a9-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Because duplicate titles are invalid HTML', false, NULL
from public.quiz_questions where slug = 'a9-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-9-milestone'), 'a9-q7', 7, 'single'::public.question_kind,
        'What does `lang="fr"` on a `<span>` achieve?', 'A screen reader switches to French pronunciation for that phrase, instead of reading French words with English phonetics.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It sets a different character encoding', false, NULL
from public.quiz_questions where slug = 'a9-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Screen readers pronounce that phrase in French', true, NULL
from public.quiz_questions where slug = 'a9-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It translates the text', false, NULL
from public.quiz_questions where slug = 'a9-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It changes the font', false, NULL
from public.quiz_questions where slug = 'a9-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-9-milestone'), 'a9-q8', 8, 'single'::public.question_kind,
        'What can HTML alone honestly guarantee about search rankings?', 'Nothing. HTML makes content crawlable, understandable and shareable; ranking depends on content quality, links and page experience.', (select id from public.skills where slug = 'seo'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Nothing — it makes content crawlable and understandable, not high-ranking', true, NULL
from public.quiz_questions where slug = 'a9-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A first-page position with the right meta tags', false, NULL
from public.quiz_questions where slug = 'a9-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A rich snippet in every result', false, NULL
from public.quiz_questions where slug = 'a9-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Higher ranking than sites without structured data', false, NULL
from public.quiz_questions where slug = 'a9-q8';
-- --------------------------------------------------------------------------
-- Level 10: HTML Performance and Security
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'performance-and-security', 10, 'HTML Performance and Security', 'The markup decisions that make pages fast and safe',
       'HTML cannot secure an application and cannot make a slow server fast. What it can do is avoid a surprising number of self-inflicted wounds — and this level is about those.', 'You can take a slow, unsafe, bloated page and measurably improve all three.', 'slate'
from public.courses c where c.slug = 'html-hero'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-10-milestone', 'milestone'::public.assessment_kind, 'Level 10 milestone: Performance and Security', 'Eight questions on loading strategy and markup-level security. Pass mark 75%.',
       0.75, 190, 10
from public.levels l where l.slug = 'performance-and-security'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Performance-aware HTML
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'html-performance', 1, 'Performance-aware HTML', 'Dimensions, loading strategy, script loading, resource hints — and the honest limits of what markup controls.',
       45, false
from public.levels l where l.slug = 'performance-and-security'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'html-performance' and p.slug = 'page-metadata';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'html-performance' and s.slug = 'performance';
-- lesson: Loading strategy
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'loading-strategy', 1, 'Loading strategy', 'Layout shift, lazy loading, preload and the critical path', 'A handful of attributes decide whether a page feels instant or feels broken while it settles.',
       ARRAY['Prevent layout shift with dimensions', 'Choose loading and fetchpriority correctly', 'Use resource hints without overusing them']::text[], 15, 40, (select id from public.skills where slug = 'performance'), 0.7
from public.modules m where m.slug = 'html-performance'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Explain and prevent cumulative layout shift","Choose the right loading strategy for each asset","Use preload, preconnect and dns-prefetch appropriately"]}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'term'::public.block_type, 'Layout shift', 'Content jumping around as the page loads, because the browser did not know how much space something would need until it arrived. It is measured as Cumulative Layout Shift, and it is one of the three Core Web Vitals.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'comparison'::public.block_type, 'The same image, with and without dimensions', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Space reserved","code":"<img src=\"/learning-media/images/city-dusk-1200.jpg\"\n     alt=\"A city skyline at dusk\"\n     width=\"1200\" height=\"800\">","why":"The browser reserves a 3:2 box immediately. Nothing below it moves when the file arrives."},"bad":{"label":"No dimensions","code":"<img src=\"/learning-media/images/city-dusk-1200.jpg\"\n     alt=\"A city skyline at dusk\">","why":"The image occupies zero height until it loads, then suddenly pushes everything below it down the page — often just as someone is about to tap a link."}}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Dimensions do not fix the size, they fix the ratio', 'A common worry is that `width` and `height` will stop an image being responsive. They will not: CSS still controls the displayed size, and modern browsers use the two attributes purely to compute an aspect ratio. Set them on every image, every video and every iframe.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'The loading attributes', NULL,
       'loading="lazy"          Do not download until near the viewport.
                        Use below the fold. Never on the hero image.

fetchpriority="high"    This is the most important asset on the page.
                        Use on exactly one thing, usually the hero image.

fetchpriority="low"     Deprioritise something incidental.

decoding="async"        Decode the image off the main thread. Safe default
                        for images that are not the hero.

preload="metadata"      For video and audio: fetch just the duration.
preload="none"          Fetch nothing until the user presses play.
preload="auto"          Fetch the whole file. Almost never justified.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'prose'::public.block_type, NULL, 'Scripts are the other half of loading strategy. Even though this course does not teach JavaScript, you need to know how a script tag affects your page, because writing it wrongly blocks rendering entirely.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<script src="analytics.js" defer></script>
<script src="widget.js" async></script>
<script src="critical.js"></script>', 'html', NULL, '{"annotations":[{"line":"1","text":"`defer` downloads in parallel with parsing, then runs after the document is parsed, in source order. This is the right default for almost every script."},{"line":"2","text":"`async` downloads in parallel and runs the moment it arrives, interrupting parsing. Order is unpredictable. Only suitable for genuinely independent scripts."},{"line":"3","text":"With neither attribute, parsing *stops* while the script downloads and runs. A slow script here freezes the page. This is the single most damaging thing you can put in a `<head>`."}]}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'term'::public.block_type, 'Resource hint', 'A `<link>` telling the browser to prepare for something before it is needed.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'code_example'::public.block_type, 'Resource hints', NULL,
       '<link rel="preconnect" href="https://fonts.example.com">
      Open the connection early. Use for one or two critical third-party origins.

<link rel="dns-prefetch" href="https://analytics.example.com">
      Cheaper than preconnect — resolves the domain name only.

<link rel="preload" href="/fonts/body.woff2" as="font" type="font/woff2" crossorigin>
      Fetch this now, at high priority. Powerful and easy to misuse.

<link rel="prefetch" href="/prices.html">
      Fetch during idle time, for a page the user will probably visit next.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'callout'::public.block_type, 'Preloading everything preloads nothing', 'A resource hint works by changing priority relative to everything else. Preload five things and you have simply restated the original order while consuming bandwidth earlier. Preload is for one or two genuinely critical assets the browser would otherwise discover late — typically a font, or a hero image referenced from CSS.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'What HTML cannot do for performance', 'Markup cannot compress your images, cannot speed up a slow database query, cannot add caching headers, and cannot fix a 2MB JavaScript bundle. The biggest performance wins are usually elsewhere: image formats and sizes, server response time, caching, and how much JavaScript you ship. What HTML gives you is the difference between a page that renders progressively and pleasantly and one that blocks, jumps and reflows — which is what users actually perceive as "fast".',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Set `width` and `height` on every image, video and iframe — it fixes the ratio, not the size.","`loading=\"lazy\"` below the fold; `fetchpriority=\"high\"` on one hero asset.","`defer` is the right default for scripts; a bare `<script>` in the head blocks rendering.","Resource hints are for one or two genuinely critical assets."],"nextUp":"Next: the security decisions HTML actually controls."}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'perf-guided', 1, 'guided'::public.exercise_kind, 'Fix a page that jumps as it loads',
       'Add dimensions to all three images, lazy-load the two below the fold, mark the hero as high priority, and change the render-blocking script to use `defer`.', '<script src="analytics.js"></script>

<img src="/learning-media/images/coast-sunrise-1200.jpg" alt="Sunrise over a calm sea">
<p>Twenty-four miles, mostly flat.</p>
<img src="/learning-media/images/forest-path-1200.jpg" alt="A sandy path between tall trees">
<img src="/learning-media/images/city-dusk-1200.jpg" alt="A city skyline at dusk">', '<script src="analytics.js" defer></script>

<img src="/learning-media/images/coast-sunrise-1200.jpg"
     alt="Sunrise over a calm sea"
     fetchpriority="high" width="1200" height="800">
<p>Twenty-four miles, mostly flat.</p>
<img src="/learning-media/images/forest-path-1200.jpg"
     alt="A sandy path between tall trees"
     loading="lazy" width="1200" height="800">
<img src="/learning-media/images/city-dusk-1200.jpg"
     alt="A city skyline at dusk"
     loading="lazy" width="1200" height="800">', ARRAY['Every image needs width="1200" and height="800".', 'The first image is the hero — fetchpriority="high" and no lazy loading.', 'The other two get loading="lazy".', 'Add defer to the script so it stops blocking the parser.']::text[],
       55, 3,
       (select id from public.skills where slug = 'performance'), false
from public.lessons l where l.slug = 'loading-strategy'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'img', 'width',
       NULL, NULL, NULL, NULL,
       'Every image declares its width', NULL, 1, true
from public.exercises e where e.slug = 'perf-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'img', 'height',
       NULL, NULL, NULL, NULL,
       'Every image declares its height', NULL, 1, true
from public.exercises e where e.slug = 'perf-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'img[loading="lazy"]', NULL,
       NULL, NULL, 2, 2,
       'The two below-the-fold images are lazy-loaded', NULL, 1, true
from public.exercises e where e.slug = 'perf-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'img', 'fetchpriority',
       'high', NULL, NULL, NULL,
       'The hero image is marked high priority', NULL, 1, true
from public.exercises e where e.slug = 'perf-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'img[fetchpriority="high"][loading="lazy"]', NULL,
       NULL, NULL, 0, 0,
       'The hero image is not lazy-loaded', NULL, 1, true
from public.exercises e where e.slug = 'perf-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'attribute_present'::public.requirement_kind, 'script', 'defer',
       NULL, NULL, NULL, NULL,
       'The script no longer blocks rendering', NULL, 1, true
from public.exercises e where e.slug = 'perf-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'perf-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'loading-strategy'), NULL, 'q-layout-shift', 1, 'single'::public.question_kind,
        'What causes layout shift when images load?', 'Without dimensions the browser cannot reserve space, so content below jumps when the image arrives.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The alt text is rendered first', false, NULL
from public.quiz_questions where slug = 'q-layout-shift';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The browser cannot reserve space without dimensions', true, NULL
from public.quiz_questions where slug = 'q-layout-shift';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Images always load after text', false, NULL
from public.quiz_questions where slug = 'q-layout-shift';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Lazy loading delays them', false, NULL
from public.quiz_questions where slug = 'q-layout-shift';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'loading-strategy'), NULL, 'q-defer-async', 2, 'single'::public.question_kind,
        'What is the difference between `defer` and `async`?', '`defer` runs after parsing, in source order. `async` runs as soon as it downloads, in unpredictable order.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'They are identical', false, NULL
from public.quiz_questions where slug = 'q-defer-async';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'defer downloads first, async downloads last', false, NULL
from public.quiz_questions where slug = 'q-defer-async';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'async is for modules; defer is for classic scripts', false, NULL
from public.quiz_questions where slug = 'q-defer-async';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'defer runs after parsing in order; async runs on arrival, out of order', true, NULL
from public.quiz_questions where slug = 'q-defer-async';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'loading-strategy'), NULL, 'q-preload-overuse', 3, 'single'::public.question_kind,
        'What happens if you preload ten resources?', 'Preload works by changing relative priority. Preloading everything restates the original order while pulling bandwidth forward.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It causes a validation error', false, NULL
from public.quiz_questions where slug = 'q-preload-overuse';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nothing is genuinely prioritised, and bandwidth is consumed earlier', true, NULL
from public.quiz_questions where slug = 'q-preload-overuse';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The page loads ten times faster', false, NULL
from public.quiz_questions where slug = 'q-preload-overuse';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The browser ignores all of them', false, NULL
from public.quiz_questions where slug = 'q-preload-overuse';
-- lesson: Security decisions in markup
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'html-security', 2, 'Security decisions in markup', 'What HTML controls, and the much larger part it does not', 'External links, iframe sandboxing, referrer policy and CSP — plus a clear statement of HTML''s limits.',
       ARRAY['Open external links safely', 'Sandbox embedded content and set a referrer policy', 'Explain why HTML alone secures nothing']::text[], 15, 40, (select id from public.skills where slug = 'security'), 0.7
from public.modules m where m.slug = 'html-performance'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Apply rel=\"noopener noreferrer\" correctly","Choose sandbox tokens and a referrer policy","Explain the boundary between markup and real security"]}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'A safe external link', NULL,
       '<a href="https://example.org/report"
   target="_blank"
   rel="noopener noreferrer">
  The 2026 report (opens in a new tab)
</a>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'The rel values worth knowing', NULL,
       'rel="noopener"    The new page gets no reference back to yours.
rel="noreferrer"  Your page''s address is not sent to the destination.
                  Implies noopener.
rel="nofollow"    Tells search engines not to pass ranking credit.
                  Use on user-submitted links.
rel="ugc"         Marks a link as user-generated content.
rel="sponsored"   Marks a paid or affiliate link.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Referrer policy', 'Controls how much of your page''s address is sent when a visitor follows a link or your page loads a resource. Set per-link with `referrerpolicy`, or page-wide with a meta tag.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'A sensible page-wide default — and the modern browser default too', NULL,
       '<meta name="referrer" content="strict-origin-when-cross-origin">', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Why referrer policy matters in practice', 'If a URL contains a password-reset token, an order number or a customer identifier, the full address is sent to every third party your page links to or loads a resource from. `strict-origin-when-cross-origin` sends the full path to your own origin and only the bare origin to others — which is almost always the behaviour you want.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'prose'::public.block_type, NULL, 'Iframes deserve particular care, because an embed runs someone else''s code inside your page.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<iframe
  src="https://example.org/booking-widget"
  title="Booking widget"
  sandbox="allow-scripts allow-forms"
  referrerpolicy="no-referrer"
  loading="lazy"
  width="600" height="480"></iframe>', 'html', NULL, '{"annotations":[{"line":"4","text":"Start from nothing and add back only what the embed genuinely needs."},{"line":"4","text":"Note what is *not* granted: no `allow-top-navigation`, so the embed cannot redirect your whole page; no `allow-popups`; no `allow-same-origin`."},{"line":"5","text":"`no-referrer` sends the third party nothing about where the visitor came from."}]}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'term'::public.block_type, 'Content Security Policy', 'A rule set telling the browser which sources of script, style, image and frame content are allowed. It is the strongest defence against cross-site scripting available to a web page.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'code_example'::public.block_type, 'A very restrictive CSP, declared in HTML', NULL,
       '<meta http-equiv="Content-Security-Policy"
      content="default-src ''self''; img-src ''self'' data:; script-src ''self''">', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'callout'::public.block_type, 'A CSP meta tag is the weaker option', 'CSP is properly delivered as an HTTP response header, set by the server. The meta-tag form exists, but it cannot use some directives, it arrives later than a header, and anything before it in the document is unprotected. Use the meta tag only when you cannot control the server.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'callout'::public.block_type, 'The honest boundary', 'HTML cannot authenticate a user, cannot authorise an action, cannot validate input in any way that survives an attacker, cannot encrypt anything, and cannot keep a secret. Every `required`, `pattern`, `maxlength` and `type="email"` on your page is a convenience for honest users and is trivially bypassed. Real security lives on the server: validate every input, authenticate every request, authorise every action, and never trust anything that arrives from a browser. What HTML *can* do is avoid handing an attacker an easy opening — which is exactly what this lesson is about.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'checklist'::public.block_type, 'The markup-level security checklist', NULL,
       NULL, NULL, NULL, '{"items":["`rel=\"noopener noreferrer\"` on every `target=\"_blank\"`","`sandbox` on every iframe, granting the minimum","`title` on every iframe","A referrer policy set page-wide","`rel=\"nofollow ugc\"` on user-submitted links","No secrets in hidden inputs, comments or data attributes","Forms served and submitted over HTTPS"]}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'progressive_detail'::public.block_type, 'What about `integrity`?', 'Subresource Integrity lets you pin the exact contents of a third-party file: `<script src="https://cdn.example/lib.js" integrity="sha384-…" crossorigin="anonymous"></script>`. If the file changes by so much as a byte, the browser refuses to run it. It is genuinely useful when loading code from a CDN you do not control. It is also a good illustration of HTML''s role in security: it does not make the code safe, it just guarantees you got the code you agreed to.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 15, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`rel=\"noopener noreferrer\"` on every external link opened in a new tab.","Sandbox every iframe, granting the minimum it needs.","Set a referrer policy so URLs do not leak to third parties.","HTML avoids self-inflicted wounds; it does not provide security."],"nextUp":"Next: the Level 10 milestone."}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'security-debug', 1, 'debug'::public.exercise_kind, 'Four unsafe patterns',
       'Fix each problem: the external link has no `rel`, the iframe has no sandbox or title, the referrer policy is missing, and a secret has been left in a hidden input.', '<head>
  <meta charset="utf-8">
</head>
<body>
  <a href="https://example.org/report" target="_blank">The 2026 report</a>

  <iframe src="https://example.org/widget" width="600" height="400"></iframe>

  <form action="/booking" method="post">
    <input type="hidden" name="api_key" value="sk_live_51H8xQ2eZvKYlo2C">
    <button type="submit">Book</button>
  </form>
</body>', '<head>
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
</body>', ARRAY['Add rel="noopener noreferrer" to the external link, and warn about the new tab in the text.', 'The iframe needs a title and a sandbox granting only what it needs.', 'Add <meta name="referrer" content="strict-origin-when-cross-origin"> to the head.', 'Delete the hidden input entirely — an API key must never appear in a page.']::text[],
       65, 4,
       (select id from public.skills where slug = 'security'), false
from public.lessons l where l.slug = 'html-security'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_matches'::public.requirement_kind, 'a[target="_blank"]', 'rel',
       'noopener', NULL, NULL, NULL,
       'External links opened in a new tab use rel="noopener"', NULL, 1, true
from public.exercises e where e.slug = 'security-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'iframe', 'title',
       NULL, NULL, NULL, NULL,
       'The iframe has a title', NULL, 1, true
from public.exercises e where e.slug = 'security-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'iframe', 'sandbox',
       NULL, NULL, NULL, NULL,
       'The iframe is sandboxed', NULL, 1, true
from public.exercises e where e.slug = 'security-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'meta[name="referrer"]', NULL,
       NULL, NULL, NULL, NULL,
       'A referrer policy is set', NULL, 1, true
from public.exercises e where e.slug = 'security-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'input[type="hidden"]', NULL,
       NULL, NULL, 0, 0,
       'No secret is left in a hidden input', 'A hidden input is visible to anyone who views the page source.', 1, true
from public.exercises e where e.slug = 'security-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'html-security'), NULL, 'q-noopener-why', 1, 'single'::public.question_kind,
        'What can a page opened with `target="_blank"` do without `noopener`?', 'It gets a reference back to the opening window and, in older browsers, can navigate it elsewhere — a phishing technique.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Nothing — the attribute is purely decorative', false, NULL
from public.quiz_questions where slug = 'q-noopener-why';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Navigate your original tab to another address', true, NULL
from public.quiz_questions where slug = 'q-noopener-why';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Read your cookies', false, NULL
from public.quiz_questions where slug = 'q-noopener-why';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Submit your forms', false, NULL
from public.quiz_questions where slug = 'q-noopener-why';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'html-security'), NULL, 'q-hidden-input', 2, 'single'::public.question_kind,
        'Why must an API key never go in `<input type="hidden">`?', 'Its value is in the page source, visible to every visitor.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Browsers strip hidden values', false, NULL
from public.quiz_questions where slug = 'q-hidden-input';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The value is visible in the page source', true, NULL
from public.quiz_questions where slug = 'q-hidden-input';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Hidden inputs are not submitted', false, NULL
from public.quiz_questions where slug = 'q-hidden-input';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It fails validation', false, NULL
from public.quiz_questions where slug = 'q-hidden-input';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'html-security'), NULL, 'q-csp-header', 3, 'single'::public.question_kind,
        'Where is a Content Security Policy best delivered?', 'As an HTTP response header from the server. The meta-tag form is a weaker fallback.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'In a rel attribute on links', false, NULL
from public.quiz_questions where slug = 'q-csp-header';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'In a sandbox attribute', false, NULL
from public.quiz_questions where slug = 'q-csp-header';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'As an HTTP response header', true, NULL
from public.quiz_questions where slug = 'q-csp-header';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'As a meta tag, always', false, NULL
from public.quiz_questions where slug = 'q-csp-header';
-- lesson: Milestone: repair a slow, unsafe page
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'performance-milestone', 3, 'Milestone: repair a slow, unsafe page', 'Every problem from this level, on one page', 'The page in this milestone is slow, jumps as it loads, and hands data to third parties.',
       ARRAY['Diagnose performance and security problems from markup alone', 'Apply the correct fix for each', 'Improve your own capstone site the same way']::text[], 25, 40, (select id from public.skills where slug = 'performance'), 0.8
from public.modules m where m.slug = 'html-performance'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Repair layout shift, render blocking and unsafe embeds together","Justify each change you make","Apply the same review to your own project"]}'::jsonb
from public.lessons where slug = 'performance-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'Every fault in the exercise below is one you have already met. What is new is meeting them together, on a page that looks fine until you measure it.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'performance-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'comparison'::public.block_type, 'The two changes that matter most', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Fast","code":"<script src=\"analytics.js\" defer></script>\n<img src=\"hero-1200.jpg\" alt=\"…\"\n     fetchpriority=\"high\" width=\"1200\" height=\"800\">\n<img src=\"below.jpg\" alt=\"…\"\n     loading=\"lazy\" width=\"1200\" height=\"800\">","why":"Nothing blocks the parser, the hero arrives first, and no content jumps as images load."},"bad":{"label":"Slow","code":"<script src=\"analytics.js\"></script>\n<img src=\"hero-1200.jpg\" alt=\"…\" loading=\"lazy\">\n<img src=\"below.jpg\" alt=\"…\">","why":"The script freezes rendering, the hero is deprioritised, and both images shift the page when they arrive."}}'::jsonb
from public.lessons where slug = 'performance-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Measure, do not guess', 'Open the Network panel and reload with the cache disabled. What arrives first? What blocks? A five-second look answers questions that are otherwise pure speculation.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'performance-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'checklist'::public.block_type, 'Review any page against these', NULL,
       NULL, NULL, NULL, '{"items":["Every image, video and iframe has `width` and `height`","Below-the-fold images and iframes are lazy-loaded","The hero image is not lazy-loaded, and is `fetchpriority=\"high\"`","Scripts use `defer` unless there is a specific reason not to","Video uses `preload=\"metadata\"` or `none`, never `auto`","External links opened in a new tab carry `rel=\"noopener noreferrer\"`","Every iframe has a `title` and a `sandbox`","A referrer policy is set","No secrets anywhere in the markup"]}'::jsonb
from public.lessons where slug = 'performance-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Most HTML performance work is about not making things worse.","Most HTML security work is about not handing over an opening.","Both take minutes and both are checkable from the markup alone."],"nextUp":"Level 11 next: validation and debugging."}'::jsonb
from public.lessons where slug = 'performance-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'performance-milestone-build', 1, 'challenge'::public.exercise_kind, 'Milestone: repair the page',
       'This page has around ten performance and security problems. Fix them all. Keep the content identical.', '<head>
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
</body>', '<head>
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
</body>', ARRAY['The script blocks rendering — add defer. The three preloads are pointless; delete them.', 'The hero image is lazy-loaded, which is backwards. Swap it for fetchpriority="high" and give every image dimensions.', 'The video autoplays with preload="auto" and no controls. Fix all three, add a poster and captions.', 'The iframe needs a title, a sandbox and lazy loading. The external link needs rel="noopener noreferrer".', 'Add a referrer policy and a viewport meta tag to the head.']::text[],
       170, 5,
       (select id from public.skills where slug = 'performance'), false
from public.lessons l where l.slug = 'performance-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'script', 'defer',
       NULL, NULL, NULL, NULL,
       'The script no longer blocks rendering', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'link[rel="preload"]', NULL,
       NULL, NULL, 0, 1,
       'The unnecessary preloads are removed', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'img', 'width',
       NULL, NULL, NULL, NULL,
       'Every image declares its width', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'img', 'height',
       NULL, NULL, NULL, NULL,
       'Every image declares its height', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'img[fetchpriority="high"][loading="lazy"]', NULL,
       NULL, NULL, 0, 0,
       'The hero image is not lazy-loaded', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'img[loading="lazy"]', NULL,
       NULL, NULL, 1, NULL,
       'Below-the-fold images are lazy-loaded', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'attribute_absent'::public.requirement_kind, 'video', 'autoplay',
       NULL, NULL, NULL, NULL,
       'The video no longer autoplays', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'attribute_present'::public.requirement_kind, 'video', 'controls',
       NULL, NULL, NULL, NULL,
       'The video has controls', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'element_count'::public.requirement_kind, 'video[preload="auto"]', NULL,
       NULL, NULL, 0, 0,
       'The video no longer preloads its whole file', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'element_present'::public.requirement_kind, 'track[kind="captions"]', NULL,
       NULL, NULL, NULL, NULL,
       'The video has captions', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'attribute_present'::public.requirement_kind, 'iframe', 'title',
       NULL, NULL, NULL, NULL,
       'The iframe has a title', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'attribute_present'::public.requirement_kind, 'iframe', 'sandbox',
       NULL, NULL, NULL, NULL,
       'The iframe is sandboxed', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'attribute_value'::public.requirement_kind, 'iframe', 'loading',
       'lazy', NULL, NULL, NULL,
       'The iframe is lazy-loaded', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'attribute_matches'::public.requirement_kind, 'a[target="_blank"]', 'rel',
       'noopener', NULL, NULL, NULL,
       'The external link is opened safely', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 15, 'element_present'::public.requirement_kind, 'meta[name="referrer"]', NULL,
       NULL, NULL, NULL, NULL,
       'A referrer policy is set', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 16, 'element_present'::public.requirement_kind, 'meta[name="viewport"]', NULL,
       NULL, NULL, NULL, NULL,
       'A viewport meta tag is present', NULL, 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 17, 'local_media_path'::public.requirement_kind, 'img, source, track, video', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 18, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every image has meaningful alternative text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'performance-milestone-build';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'performance-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: performance and security review',
       'Review every page of your capstone site against the checklist. Add dimensions everywhere, lazy-load what should be lazy, add a referrer policy, and make every external link safe.', '<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Add a referrer policy -->
</head>
<body>
  <!-- Check: dimensions on every image? -->
  <!-- Check: lazy loading below the fold, but not the hero? -->
  <!-- Check: rel="noopener noreferrer" on external links? -->
</body>', '<head>
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
</body>', ARRAY['Every image needs both width and height.', 'Only the first visible image should have fetchpriority="high".', 'Any link with target="_blank" needs rel="noopener noreferrer".']::text[],
       100, 4,
       (select id from public.skills where slug = 'performance'), false
from public.lessons l where l.slug = 'performance-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'meta[name="referrer"]', NULL,
       NULL, NULL, NULL, NULL,
       'A referrer policy is set', NULL, 1, true
from public.exercises e where e.slug = 'performance-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'img', 'width',
       NULL, NULL, NULL, NULL,
       'Images declare their width', NULL, 1, true
from public.exercises e where e.slug = 'performance-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'img', 'height',
       NULL, NULL, NULL, NULL,
       'Images declare their height', NULL, 1, true
from public.exercises e where e.slug = 'performance-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'img[loading="lazy"]', NULL,
       NULL, NULL, 1, NULL,
       'At least one image is lazy-loaded', NULL, 1, true
from public.exercises e where e.slug = 'performance-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'a[target="_blank"]:not([rel])', NULL,
       NULL, NULL, 0, 0,
       'Every new-tab link has a rel attribute', NULL, 1, true
from public.exercises e where e.slug = 'performance-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'performance-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'performance-milestone'), NULL, 'q-preload-auto', 1, 'single'::public.question_kind,
        'Why is `preload="auto"` on a video usually wrong?', 'It downloads the whole file before anyone presses play — potentially megabytes of a visitor''s mobile data for a video they never watch.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It is invalid HTML', false, NULL
from public.quiz_questions where slug = 'q-preload-auto';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It downloads the whole file whether or not anyone watches', true, NULL
from public.quiz_questions where slug = 'q-preload-auto';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It disables the controls', false, NULL
from public.quiz_questions where slug = 'q-preload-auto';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It prevents captions loading', false, NULL
from public.quiz_questions where slug = 'q-preload-auto';
-- Level 10 milestone: Performance and Security questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-10-milestone'), 'a10-q1', 1, 'single'::public.question_kind,
        'What do `width` and `height` on an `<img>` prevent?', 'Layout shift — content jumping as the image arrives.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The image being resized by CSS', false, NULL
from public.quiz_questions where slug = 'a10-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The image being lazy-loaded', false, NULL
from public.quiz_questions where slug = 'a10-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The image being cached', false, NULL
from public.quiz_questions where slug = 'a10-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Layout shift as the image loads', true, NULL
from public.quiz_questions where slug = 'a10-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-10-milestone'), 'a10-q2', 2, 'single'::public.question_kind,
        'Which script attribute is the right default?', '`defer`: downloads in parallel, runs after parsing, in source order.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Neither — a bare script tag', false, NULL
from public.quiz_questions where slug = 'a10-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'type="module" only', false, NULL
from public.quiz_questions where slug = 'a10-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'defer', true, NULL
from public.quiz_questions where slug = 'a10-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'async', false, NULL
from public.quiz_questions where slug = 'a10-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-10-milestone'), 'a10-q3', 3, 'single'::public.question_kind,
        'What does `sandbox` with no value do to an iframe?', 'It removes essentially every capability; each `allow-` token restores one.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Has no effect', false, NULL
from public.quiz_questions where slug = 'a10-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Removes nearly all capabilities', true, NULL
from public.quiz_questions where slug = 'a10-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Grants all capabilities', false, NULL
from public.quiz_questions where slug = 'a10-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Blocks the iframe from loading', false, NULL
from public.quiz_questions where slug = 'a10-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-10-milestone'), 'a10-q4', 4, 'single'::public.question_kind,
        'Which referrer policy is a sensible default?', '`strict-origin-when-cross-origin` sends the full path to your own origin and only the bare origin to others.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'strict-origin-when-cross-origin', true, NULL
from public.quiz_questions where slug = 'a10-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'unsafe-url', false, NULL
from public.quiz_questions where slug = 'a10-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'no-referrer, always', false, NULL
from public.quiz_questions where slug = 'a10-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'origin-when-downgrade', false, NULL
from public.quiz_questions where slug = 'a10-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-10-milestone'), 'a10-q5', 5, 'single'::public.question_kind,
        'Can HTML validation attributes secure a form?', 'No. They are removable in two clicks, and a request can be sent without loading your page at all.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Yes, if you also use pattern', false, NULL
from public.quiz_questions where slug = 'a10-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Yes, over HTTPS', false, NULL
from public.quiz_questions where slug = 'a10-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Yes, when the form uses POST', false, NULL
from public.quiz_questions where slug = 'a10-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'No — the server must revalidate everything', true, NULL
from public.quiz_questions where slug = 'a10-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-10-milestone'), 'a10-q6', 6, 'single'::public.question_kind,
        'When should you use `fetchpriority="high"`?', 'On the single most important asset, usually the hero image.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'On all third-party scripts', false, NULL
from public.quiz_questions where slug = 'a10-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'On anything below the fold', false, NULL
from public.quiz_questions where slug = 'a10-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'On one asset — usually the hero image', true, NULL
from public.quiz_questions where slug = 'a10-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'On every image on the page', false, NULL
from public.quiz_questions where slug = 'a10-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-10-milestone'), 'a10-q7', 7, 'single'::public.question_kind,
        'What is Subresource Integrity for?', 'It pins the exact contents of a third-party file, so the browser refuses to run it if it has changed.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Validating HTML structure', false, NULL
from public.quiz_questions where slug = 'a10-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Guaranteeing a third-party file has not been altered', true, NULL
from public.quiz_questions where slug = 'a10-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Compressing external scripts', false, NULL
from public.quiz_questions where slug = 'a10-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Blocking cross-origin requests', false, NULL
from public.quiz_questions where slug = 'a10-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-10-milestone'), 'a10-q8', 8, 'single'::public.question_kind,
        'What is the biggest limitation of HTML for performance?', 'It cannot compress images, speed up a server, set caching headers or shrink a JavaScript bundle — the largest wins are elsewhere.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It cannot fix image sizes, server speed, caching or JavaScript weight', true, NULL
from public.quiz_questions where slug = 'a10-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It cannot set image dimensions', false, NULL
from public.quiz_questions where slug = 'a10-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It cannot lazy-load anything', false, NULL
from public.quiz_questions where slug = 'a10-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It cannot express loading priority', false, NULL
from public.quiz_questions where slug = 'a10-q8';
-- --------------------------------------------------------------------------
-- Level 11: Debugging and Validation Master
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'debugging-and-validation', 11, 'Debugging and Validation Master', 'Find the problem, fix the problem, prove it is fixed',
       'Every developer writes broken markup. What separates the professionals is how quickly they find it. This level is about validators, developer tools, and a debugging method that works.', 'You can take a broken multi-page site and repair every fault methodically.', 'red'
from public.courses c where c.slug = 'html-hero'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-11-milestone', 'milestone'::public.assessment_kind, 'Level 11 milestone: Debugging and Validation Master', 'Seven questions on validation and debugging method. Pass mark 75%.',
       0.75, 180, 11
from public.levels l where l.slug = 'debugging-and-validation'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Validation and developer tools
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'validation-and-tools', 1, 'Validation and developer tools', 'What a validator checks, what it cannot check, and how to use the tools already in your browser.',
       45, false
from public.levels l where l.slug = 'debugging-and-validation'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'validation-and-tools' and p.slug = 'html-performance';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'validation-and-tools' and s.slug = 'validation';
-- lesson: Reading validation output
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'reading-validation-output', 1, 'Reading validation output', 'Errors, warnings, and the ones that are not really problems', 'A validator is a spell-checker for markup. Learning to read its output is a twenty-minute skill that pays back forever.',
       ARRAY['Interpret common validator messages', 'Fix invalid nesting, unclosed tags and duplicate ids', 'Explain what a validator cannot tell you']::text[], 15, 40, (select id from public.skills where slug = 'validation'), 0.7
from public.modules m where m.slug = 'validation-and-tools'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Read and act on validator messages","Recognise the five commonest validation errors","Explain the limits of automated validation"]}'::jsonb
from public.lessons where slug = 'reading-validation-output';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'term'::public.block_type, 'Validation', 'Checking your markup against the HTML specification. The official checker lives at validator.w3.org and will check a URL, a file or pasted markup.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'reading-validation-output';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'These five account for most real-world validation errors.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'reading-validation-output';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'The five you will meet most', NULL,
       '1. "End tag X seen, but there were open elements"
   → An element was left unclosed. The named tag is where it was noticed,
     not where the mistake is — look above it.

2. "Duplicate ID x"
   → Two elements share an id. Labels and aria references will now point
     at the wrong one.

3. "Element X not allowed as child of element Y"
   → Invalid nesting: a <div> inside a <p>, an <li> outside a list.

4. "Attribute X not allowed on element Y"
   → A mis-typed attribute, or one that belongs on a different element.

5. "Element head is missing a required instance of child element title"
   → Something mandatory is absent.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'reading-validation-output';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Fix one error, then re-run', 'A single unclosed `<div>` can produce twenty errors, because every subsequent structural check is thrown off. Fix the first error in the list, re-run the validator, and watch most of the rest disappear. Working down the list fixing everything is slower and often introduces new mistakes.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'reading-validation-output';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'comparison'::public.block_type, 'The same mistake, seen two ways', NULL,
       NULL, NULL, NULL, '{"good":{"label":"What the validator says","code":"Line 14: End tag \"main\" seen, but there were open elements.\nLine 9: Unclosed element \"section\".","why":"Two messages describing one mistake. The second is the useful one: the real problem is on line 9."},"bad":{"label":"What is actually wrong","code":"<main>\n  <section>\n    <h2>Routes</h2>\n    <p>Three loops from the door.</p>\n</main>","why":"The `<section>` on line 2 was never closed. One missing tag, two error messages."}}'::jsonb
from public.lessons where slug = 'reading-validation-output';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'What a validator cannot tell you', 'It checks grammar, not meaning. A page can validate perfectly and still be unusable: alt text saying "image", a heading hierarchy that jumps from h1 to h4, links reading "click here", a `<div>` acting as a button, a form with no labels. Validation is a floor, not a ceiling — necessary, and nowhere near sufficient.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'reading-validation-output';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'Valid but wrong', 'Both of these pass the validator.',
       NULL, NULL, NULL, '{"variants":[{"label":"Valid and good","code":"<main>\n  <h1>Prices</h1>\n  <h2>Hourly</h2>\n  <p>From £6.</p>\n</main>","note":"Valid markup, sound structure, correct heading order."},{"label":"Valid and bad","code":"<div>\n  <div class=\"h1\">Prices</div>\n  <h4>Hourly</h4>\n  <p>From £6.</p>\n</div>","note":"Also completely valid. No landmark, no h1, a skipped heading level, and a fake heading. The validator has nothing to say about any of it."}]}'::jsonb
from public.lessons where slug = 'reading-validation-output';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'progressive_detail'::public.block_type, 'Other checks worth running', 'The W3C validator for HTML grammar. An automated accessibility checker such as axe or the browser''s built-in accessibility audit for names, contrast and roles. A link checker for broken hrefs. And your own eyes for the things no tool can judge: whether the alt text is useful, whether the heading order describes the real structure, whether the link text makes sense out of context. Automated tools reliably catch roughly a third of accessibility issues — the rest need a person.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'reading-validation-output';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["A validator checks grammar against the specification.","Fix the first error, then re-run — one mistake often causes many messages.","The error line is where the problem was *noticed*, not always where it is.","Valid markup can still be badly structured and inaccessible."],"nextUp":"Next: developer tools."}'::jsonb
from public.lessons where slug = 'reading-validation-output';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'validation-debug', 1, 'debug'::public.exercise_kind, 'Five validation errors',
       'This markup produces five validator errors: an unclosed element, a duplicate id, invalid nesting, an obsolete element, and a missing required child. Fix all five.', '<html lang="en">
  <head>
    <meta charset="utf-8">
  </head>
  <body>
    <main id="main">
      <h1 id="title">Route guides</h1>
      <section>
        <h2 id="title">Easy routes</h2>
        <p>Both of these are flat.<div>Six miles.</div></p>
      <center>All routes start at the workshop.</center>
    </main>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Route guides — Riverside Cycle Hire</title>
  </head>
  <body>
    <main id="main">
      <h1 id="page-title">Route guides</h1>
      <section>
        <h2 id="section-title">Easy routes</h2>
        <p>Both of these are flat.</p>
        <p>Six miles.</p>
      </section>
      <p>All routes start at the workshop.</p>
    </main>
  </body>
</html>', ARRAY['The <head> has no <title>, which is required.', 'Two elements both use id="title" — give them different ids.', 'A <div> cannot go inside a <p>. Make it a separate paragraph.', 'The <section> is never closed.', '<center> was removed from HTML — use a paragraph instead.']::text[],
       65, 4,
       (select id from public.skills where slug = 'validation'), false
from public.lessons l where l.slug = 'reading-validation-output'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The head has a title', NULL, 1, true
from public.exercises e where e.slug = 'validation-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'validation-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'validation-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'no_deprecated_elements'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No obsolete elements are used', 'Elements like <center>, <font> and <big> were removed from HTML.', 1, true
from public.exercises e where e.slug = 'validation-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'section', NULL,
       NULL, NULL, NULL, NULL,
       'The section element is properly closed', NULL, 1, true
from public.exercises e where e.slug = 'validation-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'p > div', NULL,
       NULL, NULL, 0, 0,
       'No block element is nested inside a paragraph', NULL, 1, true
from public.exercises e where e.slug = 'validation-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'reading-validation-output'), NULL, 'q-validator-order', 1, 'single'::public.question_kind,
        'A validator reports twenty errors. What should you do first?', 'Fix the first one and re-run. A single unclosed element can produce most of the rest.', (select id from public.skills where slug = 'validation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Ignore them if the page looks right', false, NULL
from public.quiz_questions where slug = 'q-validator-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Fix the first error, then re-validate', true, NULL
from public.quiz_questions where slug = 'q-validator-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Fix them from the bottom up', false, NULL
from public.quiz_questions where slug = 'q-validator-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Fix all twenty before re-checking', false, NULL
from public.quiz_questions where slug = 'q-validator-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'reading-validation-output'), NULL, 'q-validator-limits', 2, 'single'::public.question_kind,
        'Which problem will a validator NOT report?', 'Alt text quality is a judgement about meaning. A validator only checks that the attribute exists.', (select id from public.skills where slug = 'validation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A <li> outside any list', false, NULL
from public.quiz_questions where slug = 'q-validator-limits';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'alt="image" on a photograph', true, NULL
from public.quiz_questions where slug = 'q-validator-limits';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A duplicate id', false, NULL
from public.quiz_questions where slug = 'q-validator-limits';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'An unclosed <div>', false, NULL
from public.quiz_questions where slug = 'q-validator-limits';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'reading-validation-output'), NULL, 'q-duplicate-id-effect', 3, 'single'::public.question_kind,
        'Why are duplicate ids a real problem, not just a technicality?', 'Every relationship that references an id — `for`, `aria-labelledby`, `aria-describedby`, fragment links — resolves to the first match, so connections silently point at the wrong element.', (select id from public.skills where slug = 'validation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The page will not load', false, NULL
from public.quiz_questions where slug = 'q-duplicate-id-effect';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'CSS stops working entirely', false, NULL
from public.quiz_questions where slug = 'q-duplicate-id-effect';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Both elements are hidden', false, NULL
from public.quiz_questions where slug = 'q-duplicate-id-effect';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Label and ARIA relationships silently resolve to the wrong element', true, NULL
from public.quiz_questions where slug = 'q-duplicate-id-effect';
-- lesson: Browser developer tools
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'developer-tools', 2, 'Browser developer tools', 'Inspecting the DOM, testing the keyboard, finding broken paths', 'Everything you need to debug a page is already in your browser, behind one keyboard shortcut.',
       ARRAY['Inspect the live DOM and see how the browser repaired your markup', 'Find broken paths in the network panel', 'Test keyboard order and inspect the accessibility tree']::text[], 14, 40, (select id from public.skills where slug = 'debugging'), 0.7
from public.modules m where m.slug = 'validation-and-tools'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Open developer tools and inspect an element","Diagnose a broken media path from the network panel","Use the accessibility panel to check names and roles"]}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'Press F12, or Ctrl+Shift+I (Cmd+Option+I on a Mac). Four panels do almost everything you need.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'The four panels that matter', NULL,
       'Elements / Inspector
  The live DOM — what the browser actually built, after repairing any
  mistakes. Comparing this with your source file is the fastest way to
  find an unclosed tag: the browser will have moved things somewhere
  surprising, and you can see exactly where.

Network
  Every file the page requested and what came back. A red 404 line
  is a broken path. Click it to see the exact URL requested — usually
  the typo is immediately obvious.

Console
  Errors and warnings. For HTML work this is mostly where you learn
  that a media file failed or a resource was blocked.

Accessibility
  The accessibility tree: the computed name, role and state of the
  selected element. If an element''s name is empty here, a screen
  reader announces nothing.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'The trick that finds unclosed tags fastest', 'Open the Elements panel and look at the indentation. If an element you expected to be a sibling appears as a *child* of the one above it, you have found your missing closing tag. The browser silently repaired the document, and the repair is visible right there in the tree.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'annotated_code'::public.block_type, 'Source versus repaired DOM', NULL,
       'What you wrote:          What the Elements panel shows:

<main>                   <main>
  <section>                <section>
    <h2>Routes</h2>          <h2>Routes</h2>
  <p>Three loops.</p>        <p>Three loops.</p>    ← now inside section
</main>                    </section>
                         </main>', 'html', NULL, '{"annotations":[{"line":"1","text":"The `<section>` was never closed, so the browser assumed it should wrap everything up to `</main>`."},{"line":"4","text":"The paragraph you meant to be a sibling of the section became its child. The indentation in the panel gives it away instantly."}]}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'checklist'::public.block_type, 'A five-minute debugging routine', NULL,
       NULL, NULL, NULL, '{"items":["Open the Network panel and reload — any red lines are broken paths","Open Elements and check the indentation matches what you wrote","Tab through the page — is everything reachable, is focus visible","Select an interactive element and check its accessible name","Run the page through the W3C validator"]}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'term'::public.block_type, 'Device toolbar', 'A developer-tools mode that simulates a phone or tablet viewport. Useful for checking that responsive images and layouts behave — though it simulates size, not the real device.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'callout'::public.block_type, 'Cross-browser testing, briefly', 'Modern browsers agree on HTML far more than they used to; genuine differences are now mostly in newer features. A practical approach: build to the standard, test in one Chromium browser and one Firefox, check a real phone if you can, and consult caniuse.com before relying on anything recent. Do not write browser-specific markup — that habit causes more problems than it solves.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'progressive_detail'::public.block_type, 'Debugging as a method', 'The method that works is boring and reliable. Change one thing. Test. If it did not help, put it back. Beginners often change four things at once, see the page improve, and have no idea which change did it — so the next similar bug takes just as long. Narrow the problem before fixing it: delete half the page and see if the bug persists; if it does, the cause is in the remaining half. Three or four rounds of that will locate almost anything.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Elements shows the repaired DOM — indentation reveals unclosed tags.","Network shows broken paths as 404s with the exact URL requested.","The Accessibility panel shows computed names and roles.","Change one thing at a time, and narrow before you fix."],"nextUp":"Next: repair a whole broken site."}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'devtools-debug', 1, 'debug'::public.exercise_kind, 'Four broken paths',
       'Every media path on this page 404s. Use the media library to find the correct paths and fix all four.', '<img src="/learning-media/images/coast-sunrise-900.jpg" alt="Sunrise over a calm sea" width="1200" height="800">
<img src="/learning-media/img/forest-path-800.jpg" alt="A sandy path between tall trees" width="800" height="534">
<video controls poster="/learning-media/posters/page-anatomy.png" width="1280" height="720">
  <source src="/learning-media/video/page-anatomy.mov" type="video/quicktime">
</video>', '<img src="/learning-media/images/coast-sunrise-800.jpg" alt="Sunrise over a calm sea" width="800" height="534">
<img src="/learning-media/images/forest-path-800.jpg" alt="A sandy path between tall trees" width="800" height="534">
<video controls poster="/learning-media/posters/page-anatomy.jpg" width="1280" height="720">
  <source src="/learning-media/video/page-anatomy.webm" type="video/webm">
  <source src="/learning-media/video/page-anatomy.mp4" type="video/mp4">
</video>', ARRAY['The library provides widths of 480, 800, 1200 and 1600 — there is no 900.', 'The folder is "images", not "img".', 'The poster is a .jpg, not a .png.', 'The video is available as .webm and .mp4, not .mov.']::text[],
       55, 3,
       (select id from public.skills where slug = 'debugging'), false
from public.lessons l where l.slug = 'developer-tools'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'local_media_path'::public.requirement_kind, 'img, source, video', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'devtools-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'img', NULL,
       NULL, NULL, 2, 2,
       'Both images are still present', NULL, 1, true
from public.exercises e where e.slug = 'devtools-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'video source', NULL,
       NULL, NULL, NULL, NULL,
       'The video still has a source', NULL, 1, true
from public.exercises e where e.slug = 'devtools-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'video', 'poster',
       NULL, NULL, NULL, NULL,
       'The video still has a poster', NULL, 1, true
from public.exercises e where e.slug = 'devtools-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every image has meaningful alternative text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'devtools-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'developer-tools'), NULL, 'q-elements-panel', 1, 'single'::public.question_kind,
        'How does the Elements panel help you find an unclosed tag?', 'It shows the repaired DOM, so an element that should be a sibling appears indented as a child — which reveals where the closing tag is missing.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It shows your original source file', false, NULL
from public.quiz_questions where slug = 'q-elements-panel';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It runs the W3C validator automatically', false, NULL
from public.quiz_questions where slug = 'q-elements-panel';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It shows the repaired DOM, where the wrong nesting is visible', true, NULL
from public.quiz_questions where slug = 'q-elements-panel';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It highlights unclosed tags in red', false, NULL
from public.quiz_questions where slug = 'q-elements-panel';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'developer-tools'), NULL, 'q-network-404', 2, 'single'::public.question_kind,
        'Which panel shows a broken image path?', 'Network — the request appears with a 404 status and the exact URL requested.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Console only', false, NULL
from public.quiz_questions where slug = 'q-network-404';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Sources', false, NULL
from public.quiz_questions where slug = 'q-network-404';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Performance', false, NULL
from public.quiz_questions where slug = 'q-network-404';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Network', true, NULL
from public.quiz_questions where slug = 'q-network-404';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'developer-tools'), NULL, 'q-one-change', 3, 'single'::public.question_kind,
        'Why change one thing at a time when debugging?', 'Otherwise you cannot tell which change fixed it, and you learn nothing that helps with the next similar bug.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Because the validator only reports one error at a time', false, NULL
from public.quiz_questions where slug = 'q-one-change';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'So you know which change actually fixed it', true, NULL
from public.quiz_questions where slug = 'q-one-change';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Because browsers cache multiple changes', false, NULL
from public.quiz_questions where slug = 'q-one-change';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'To keep the file smaller', false, NULL
from public.quiz_questions where slug = 'q-one-change';
-- lesson: Milestone: repair a broken site
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'debugging-milestone', 3, 'Milestone: repair a broken site', 'Every category of fault, one page', 'A page with structural, semantic, accessibility, media and validation faults. Repair all of them.',
       ARRAY['Diagnose faults across every category covered so far', 'Repair methodically rather than by guessing', 'Verify with the checklist']::text[], 30, 40, (select id from public.skills where slug = 'debugging'), 0.85
from public.modules m where m.slug = 'validation-and-tools'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Find and fix faults across structure, semantics, media and accessibility","Work methodically from structure outwards","Verify each fix rather than assuming it worked"]}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'checklist'::public.block_type, 'Repair in this order', NULL,
       NULL, NULL, NULL, '{"items":["Document: doctype, lang, charset, viewport, title","Structure: landmarks, one main, heading hierarchy","Validation: unclosed tags, duplicate ids, invalid nesting, obsolete elements","Links: broken paths, missing hrefs, meaningless link text","Media: broken paths, missing alt, missing dimensions","Forms: labels, names, button types","Finally: run the keyboard test"]}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'callout'::public.block_type, 'Resist the urge to rewrite', 'When a page is this broken it is tempting to delete it and start again. In real work you almost never can — the content matters, and somebody else wrote it. Practising methodical repair is the point of this exercise.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'The repair order, as a working checklist', NULL,
       '1. <!DOCTYPE html>   missing?          → add it, first line
2. <html lang>       missing?          → add lang="en"
3. <title>           missing?          → every page needs its own
4. landmarks         divs everywhere?  → header, nav, main, footer
5. headings          skipped levels?   → one h1, step down one at a time
6. ids               duplicated?       → make each unique
7. nesting           div inside p?     → separate them
8. obsolete          <center>, <font>? → replace with real elements
9. media             404s? no alt?     → fix paths, describe images
10. forms            unlabelled?       → <label for> on every control', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'One mistake, many error messages', NULL,
       NULL, NULL, NULL, '{"good":{"label":"The validator output","code":"Line 14: End tag \"main\" seen, but there were open elements.\nLine 9:  Unclosed element \"section\".\nLine 15: Stray end tag \"div\".","why":"Three messages. Fix the one on line 9 and re-run — the other two usually vanish with it."},"bad":{"label":"The actual fault","code":"<main>\n  <section>          ← opened on line 9\n    <h2>Routes</h2>\n</main>              ← never closed","why":"A single missing closing tag. This is why you fix the first error and re-validate rather than working down the list."}}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Structure first, then validation, then content-level faults.","Verify each fix; do not assume.","This is the single most employable skill in the whole course."],"nextUp":"Level 12 next: the capstone."}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'repair-milestone', 1, 'challenge'::public.exercise_kind, 'Milestone: repair the broken page',
       'This page has faults in every category. Repair all of them, keeping the content the same.', '<html>
<head>
<meta charset="utf-8">
</head>
<body>
<div class="top">
<a>Home</a>
<a href="about.html">About</a>
<a href="contact.html">Contact</a>
</div>

<div class="body">
<div class="title">Our routes</div>
<h4 id="r">Easy routes</h4>
<p>Flat and traffic-free.<div>Six miles.</div></p>
<h4 id="r">Harder routes</h4>
<img src="/learning-media/images/valley.jpg">
<p>For details <a href="routes.html">click here</a>.</p>
<center>All routes start at the workshop.</center>

<form action="/booking" method="post">
<input type="text" id="name" placeholder="Name">
<div onclick="send()">Send</div>
</form>
</div>

<div class="bottom">© 2026 Riverside Cycle Hire</div>
</body>
</html>', '<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Our routes — Riverside Cycle Hire</title>
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
    <h1>Our routes</h1>

    <h2 id="easy-routes">Easy routes</h2>
    <p>Flat and traffic-free.</p>
    <p>Six miles.</p>

    <h2 id="harder-routes">Harder routes</h2>
    <img src="/learning-media/images/forest-path-1200.jpg"
         alt="A sandy path winding between tall trees in a sunlit forest"
         loading="lazy" width="1200" height="800">

    <p>Read our <a href="routes.html">full route descriptions</a>.</p>
    <p>All routes start at the workshop.</p>

    <form action="/booking" method="post">
      <label for="name">Your name</label>
      <input type="text" id="name" name="name" autocomplete="name" required>
      <button type="submit">Send</button>
    </form>
  </main>

  <footer>
    <p>© 2026 Riverside Cycle Hire</p>
  </footer>
</body>
</html>', ARRAY['Start at the document level: no doctype, no lang, no viewport, no title.', 'The three divs are landmarks: header, main, footer. Add a skip link and wrap the links in a nav with a list.', 'The "title" div is really the h1, so the h4s become h2s. Both h4s also share id="r".', 'A <div> cannot live inside a <p>. <center> is obsolete.', 'The image path does not exist and has no alt or dimensions — use the media library.', '"Click here" tells a screen-reader user nothing. The first nav link has no href.', 'The input needs a label and a name; the "Send" div should be a real button.']::text[],
       200, 5,
       (select id from public.skills where slug = 'debugging'), false
from public.lessons l where l.slug = 'debugging-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'html', 'lang',
       NULL, NULL, NULL, NULL,
       'The html element declares a language', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'meta[name="viewport"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a viewport meta tag', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has a title', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'text_not_empty'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The title has text', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'There is a header landmark', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main landmark', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'There is a footer landmark', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'element_present'::public.requirement_kind, 'nav', NULL,
       NULL, NULL, NULL, NULL,
       'The links are in a nav', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav is labelled', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 3, 3,
       'All three nav links are list items', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'attribute_present'::public.requirement_kind, 'a', 'href',
       NULL, NULL, NULL, NULL,
       'Every link has an href', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'There is a skip link', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one h1', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 15, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 16, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 17, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 18, 'no_deprecated_elements'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No obsolete elements are used', 'Elements like <center>, <font> and <big> were removed from HTML.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 19, 'element_count'::public.requirement_kind, 'p > div', NULL,
       NULL, NULL, 0, 0,
       'No block element inside a paragraph', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 20, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'The image has meaningful alt text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 21, 'attribute_present'::public.requirement_kind, 'img', 'width',
       NULL, NULL, NULL, NULL,
       'The image declares its dimensions', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 22, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 23, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'The form control is labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 24, 'attribute_present'::public.requirement_kind, 'input', 'name',
       NULL, NULL, NULL, NULL,
       'The input has a name', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 25, 'element_present'::public.requirement_kind, 'button[type="submit"]', NULL,
       NULL, NULL, NULL, NULL,
       'The submit control is a real button', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 26, 'element_count'::public.requirement_kind, '[onclick]', NULL,
       NULL, NULL, 0, 0,
       'No inline click handlers remain', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'validation-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: validate every page',
       'Run every page of your capstone site through the checklist and fix everything you find. From here on, every page you add should pass first time.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page title — your site</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul><li><a href="index.html">Home</a></li></ul>
      </nav>
    </header>
    <main id="main">
      <h1>Your page heading</h1>
      <!-- Check: unique ids? valid nesting? every image with alt and dimensions? -->
    </main>
    <footer><p>© 2026 Your site</p></footer>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Our routes — Riverside Cycle Hire</title>
    <meta name="description" content="Three waymarked routes starting at the Mill Lane workshop.">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="routes.html" aria-current="page">Routes</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Our routes</h1>
      <h2>Easy routes</h2>
      <p>Flat and traffic-free, starting at the workshop door.</p>
      <img src="/learning-media/images/forest-path-1200.jpg"
           alt="A sandy path winding between tall trees"
           loading="lazy" width="1200" height="800">
    </main>
    <footer><p>© 2026 Riverside Cycle Hire</p></footer>
  </body>
</html>', ARRAY['Work down the repair checklist in order.', 'Check every id is unique and every image has alt text and dimensions.', 'Tab through the finished page as a final check.']::text[],
       110, 4,
       (select id from public.skills where slug = 'validation'), false
from public.lessons l where l.slug = 'debugging-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'html', 'lang',
       NULL, NULL, NULL, NULL,
       'The page declares its language', NULL, 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main', NULL, 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'no_deprecated_elements'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No obsolete elements are used', 'Elements like <center>, <font> and <big> were removed from HTML.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every image has meaningful alternative text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'debugging-milestone'), NULL, 'q-repair-order', 1, 'single'::public.question_kind,
        'What should you repair first on a badly broken page?', 'Document-level and structural problems. They affect everything else, and fixing them often resolves cascading errors.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Meta descriptions', false, NULL
from public.quiz_questions where slug = 'q-repair-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Whichever error the validator lists last', false, NULL
from public.quiz_questions where slug = 'q-repair-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Document structure — doctype, lang, landmarks, headings', true, NULL
from public.quiz_questions where slug = 'q-repair-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Alt text on images', false, NULL
from public.quiz_questions where slug = 'q-repair-order';
-- Level 11 milestone: Debugging and Validation Master questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-11-milestone'), 'a11-q1', 1, 'single'::public.question_kind,
        '"End tag main seen, but there were open elements" — where is the mistake?', 'Above the reported line. An element opened earlier was never closed; the validator noticed at `</main>`.', (select id from public.skills where slug = 'validation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Above that line — something opened earlier was never closed', true, NULL
from public.quiz_questions where slug = 'a11-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'On the reported line itself', false, NULL
from public.quiz_questions where slug = 'a11-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'In the head', false, NULL
from public.quiz_questions where slug = 'a11-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'In a linked stylesheet', false, NULL
from public.quiz_questions where slug = 'a11-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-11-milestone'), 'a11-q2', 2, 'single'::public.question_kind,
        'Which of these will a validator NOT catch?', 'Link text quality is a judgement about meaning, which no grammar checker can make.', (select id from public.skills where slug = 'validation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A duplicate id', false, NULL
from public.quiz_questions where slug = 'a11-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'An <li> outside a list', false, NULL
from public.quiz_questions where slug = 'a11-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A missing <title>', false, NULL
from public.quiz_questions where slug = 'a11-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A link whose text is "click here"', true, NULL
from public.quiz_questions where slug = 'a11-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-11-milestone'), 'a11-q3', 3, 'single'::public.question_kind,
        'Which developer-tools panel shows a 404 for a missing image?', 'Network, with the exact URL that was requested.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Accessibility', false, NULL
from public.quiz_questions where slug = 'a11-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Performance', false, NULL
from public.quiz_questions where slug = 'a11-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Network', true, NULL
from public.quiz_questions where slug = 'a11-q3';

commit;
