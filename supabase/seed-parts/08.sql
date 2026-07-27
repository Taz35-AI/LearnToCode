-- HTML Hero — course seed, part 8 of 10
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 7 first.

begin;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'text_not_empty'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page still has a title', NULL, 1, true
from public.exercises e where e.slug = 'lang-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'lang-debug', 2, 'debug'::public.exercise_kind, 'Confidently wrong language markup',
       'This page declares the wrong language, restates it needlessly on every paragraph, marks a proper noun as foreign, and leaves an Arabic quotation with no direction. Repair all four.', '<html lang="fr">
  <body>
    <h1>Riverside Bakery</h1>
    <p lang="fr">Open seven days a week.</p>
    <p lang="fr">You will find us on the <span lang="fr">Rue des Fleurs</span>.</p>
    <blockquote lang="ar">مرحبا بكم في المخبز</blockquote>
  </body>
</html>', '<html lang="en">
  <body>
    <h1>Riverside Bakery</h1>
    <p>Open seven days a week.</p>
    <p>You will find us on the Rue des Fleurs.</p>
    <blockquote lang="ar" dir="rtl">مرحبا بكم في المخبز</blockquote>
  </body>
</html>', ARRAY['The page is in English, so <html lang="en">.', 'Paragraphs inherit the page language — remove the repeated lang attributes.', 'A street name is a proper noun and should not be marked as French.', 'Arabic reads right to left, so the quotation needs dir="rtl".']::text[],
       45, 3,
       (select id from public.skills where slug = 'metadata'), false
from public.lessons l where l.slug = 'language-and-internationalisation'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'html', 'lang',
       'en', NULL, NULL, NULL,
       'The page declares English', NULL, 1, true
from public.exercises e where e.slug = 'lang-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, '[lang="fr"]', NULL,
       NULL, NULL, 0, 0,
       'Nothing is wrongly marked as French', NULL, 1, true
from public.exercises e where e.slug = 'lang-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'p[lang]', NULL,
       NULL, NULL, 0, 0,
       'Paragraphs simply inherit the page language', NULL, 1, true
from public.exercises e where e.slug = 'lang-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'blockquote', 'dir',
       'rtl', NULL, NULL, NULL,
       'The Arabic quotation declares its direction', NULL, 1, true
from public.exercises e where e.slug = 'lang-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_value'::public.requirement_kind, 'blockquote', 'lang',
       'ar', NULL, NULL, NULL,
       'The Arabic quotation declares its language', NULL, 1, true
from public.exercises e where e.slug = 'lang-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'language-and-internationalisation'), NULL, 'q-lang-missing-effect', 1, 'single'::public.question_kind,
        'What happens when a page has no `lang` attribute?', 'Assistive technology falls back to the user''s own language settings and applies its pronunciation rules to your text.', (select id from public.skills where slug = 'metadata'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Only search ranking is affected', false, NULL
from public.quiz_questions where slug = 'q-lang-missing-effect';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Screen readers fall back to the user''s language and mispronounce the content', true, NULL
from public.quiz_questions where slug = 'q-lang-missing-effect';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The page will not validate but nothing else changes', false, NULL
from public.quiz_questions where slug = 'q-lang-missing-effect';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Browsers detect the language from the words automatically', false, NULL
from public.quiz_questions where slug = 'q-lang-missing-effect';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'language-and-internationalisation'), NULL, 'q-wrong-lang-worse', 2, 'single'::public.question_kind,
        'Why is an incorrect `lang` worse than a missing one?', 'A missing attribute makes software fall back to a sensible default. A wrong one makes it confidently apply the wrong rules.', (select id from public.skills where slug = 'metadata'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It causes a validation error, whereas a missing one does not', false, NULL
from public.quiz_questions where slug = 'q-wrong-lang-worse';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It prevents the page being indexed at all', false, NULL
from public.quiz_questions where slug = 'q-wrong-lang-worse';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'There is no difference in practice', false, NULL
from public.quiz_questions where slug = 'q-wrong-lang-worse';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Software stops falling back and applies the wrong rules with confidence', true, NULL
from public.quiz_questions where slug = 'q-wrong-lang-worse';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'language-and-internationalisation'), NULL, 'q-dir-auto', 3, 'single'::public.question_kind,
        'When is `dir="auto"` the right choice?', 'For text whose direction you cannot know when writing the page — anything supplied by a user.', (select id from public.skills where slug = 'metadata'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Whenever the page mixes two fonts', false, NULL
from public.quiz_questions where slug = 'q-dir-auto';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'For user-supplied text such as reviews, comments or names', true, NULL
from public.quiz_questions where slug = 'q-dir-auto';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'For every element on a multilingual page', false, NULL
from public.quiz_questions where slug = 'q-dir-auto';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only on the `<html>` element', false, NULL
from public.quiz_questions where slug = 'q-dir-auto';
-- lesson: Milestone: optimise a page for discovery
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'seo-milestone', 4, 'Milestone: optimise a page for discovery', 'Every metadata decision on one page', 'A complete, discoverable, shareable page head plus a correctly structured body.',
       ARRAY['Build a complete production-quality document head', 'Add social metadata and structured data', 'Apply the same to your capstone site']::text[], 22, 40, (select id from public.skills where slug = 'seo'), 0.8
from public.modules m where m.slug = 'page-metadata'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
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
select id, 6, 'interactive_demo'::public.block_type, 'What a search result is built from', 'Three pages, three very different results.',
       NULL, NULL, NULL, '{"variants":[{"label":"Complete","code":"<title>Bike hire prices — Riverside Cycle Hire</title>\n<meta name=\"description\" content=\"Hourly, daily and weekly hire from £6. Helmet, lock and route map included.\">\n<link rel=\"canonical\" href=\"https://riverside-cycles.example/prices.html\">","note":"A distinct title, a description that reads as a promise, and one canonical address so duplicates do not compete."},{"label":"Shared title","code":"<title>Riverside Cycle Hire</title>\n<meta name=\"description\" content=\"Riverside Cycle Hire\">","note":"Every page identical. Tabs are indistinguishable, bookmarks meaningless, and the search engine has nothing to tell them apart."},{"label":"No canonical","code":"<title>Bike hire prices — Riverside Cycle Hire</title>\n<meta name=\"description\" content=\"Hourly, daily and weekly hire from £6.\">","note":"Fine until the same page is reachable with and without a trailing slash, or with tracking parameters — then several URLs compete with each other."}]}'::jsonb
from public.lessons where slug = 'seo-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'recall'::public.block_type, 'What the crawler was already reading', 'Metadata sits on top of structure — it cannot rescue a badly built page. From memory: which earlier decisions does a search engine actually read, and why does each one matter to it?',
       NULL, NULL, NULL, '{"points":["Level 1 — `<html lang>` tells it which audience the page is for; the `<title>` is the single most-read line you will write.","Level 2 — the heading outline is how a crawler works out what the page is about and which parts are subordinate.","Level 3 — descriptive link text is a signal about the destination, which is why \"click here\" wastes it.","Level 4 — `alt` text is the only description of an image a crawler has.","Level 5 — landmarks separate the content of this page from the navigation repeated on every page."]}'::jsonb
from public.lessons where slug = 'seo-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'summary'::public.block_type, 'Lesson summary', NULL,
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
-- HTML Hero — Level 10: HTML Performance and Security
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
select id, 12, 'interactive_demo'::public.block_type, 'One page, three loading strategies', 'The same three images, told to load in different ways.',
       NULL, NULL, NULL, '{"variants":[{"label":"Deliberate","code":"<img src=\"/learning-media/images/coast-sunrise.jpg\" alt=\"Sunrise over a calm sea\" width=\"1600\" height=\"900\" fetchpriority=\"high\">\n<img src=\"/learning-media/images/forest-path.jpg\" alt=\"A path between tall trees\" width=\"1600\" height=\"900\" loading=\"lazy\" decoding=\"async\">","note":"The banner is prioritised and eager; everything below is deferred. Exactly one asset is marked urgent."},{"label":"Everything urgent","code":"<img src=\"/learning-media/images/coast-sunrise.jpg\" alt=\"Sunrise over a calm sea\" width=\"1600\" height=\"900\" fetchpriority=\"high\">\n<img src=\"/learning-media/images/forest-path.jpg\" alt=\"A path between tall trees\" width=\"1600\" height=\"900\" fetchpriority=\"high\">","note":"Priority is relative, so marking both urgent prioritises neither — and the banner now competes with an image nobody has scrolled to."},{"label":"No dimensions","code":"<img src=\"/learning-media/images/coast-sunrise.jpg\" alt=\"Sunrise over a calm sea\">\n<p>Everything below this jumps when the image lands.</p>","note":"The image claims no height until it arrives, then shoves the paragraph down the page — often just as somebody reaches for a link."}]}'::jsonb
from public.lessons where slug = 'loading-strategy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'summary'::public.block_type, 'Lesson summary', NULL,
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
select id, 13, 'self_explain'::public.block_type, 'Explain it in your own words', 'A teammate has added `required`, `pattern="[0-9]{16}"` and `maxlength="16"` to a card-number field, and says the input is now validated. Write your reply. Be specific about what those attributes *do* achieve, so that the answer is not simply "they are useless".',
       NULL, NULL, NULL, '{"modelAnswer":"They achieve something real and something narrow: they catch honest mistakes early, in the browser, before a request is made — better error messages, fewer round trips, a kinder form. What they do not do is validate anything, because every one of them is enforced by the browser and an attacker does not need to use one. The request can be sent by hand with any value at all. So the field is validated for people who are trying to get it right, and completely unvalidated against anyone who is not. The server must check the same things again, and its check is the only one that counts."}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'recall'::public.block_type, 'From memory', 'Close the page. From memory, list every markup-level security measure this lesson covered — and beside each one, say what it prevents.',
       NULL, NULL, NULL, '{"points":["`rel=\"noopener noreferrer\"` on `target=\"_blank\"` — stops the opened page controlling the tab it came from, and stops your address being passed on.","`sandbox` on every iframe, granting the minimum — the embed runs someone else''s code inside your page.","`title` on every iframe — without it the embed is announced as an unnamed frame.","A referrer policy — stops full URLs, which may carry tokens or identifiers, leaking to third parties.","`rel=\"nofollow ugc\"` on user-submitted links — refuses to lend your site''s standing to content you did not write.","No secrets in hidden inputs, comments or data attributes — all of it is plainly readable.","Subresource integrity on third-party scripts — guarantees you got the code you agreed to.","And the boundary itself: none of this authenticates, authorises or validates. That is the server''s job, always."]}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 15, 'checklist'::public.block_type, 'The markup-level security checklist', NULL,
       NULL, NULL, NULL, '{"items":["`rel=\"noopener noreferrer\"` on every `target=\"_blank\"`","`sandbox` on every iframe, granting the minimum","`title` on every iframe","A referrer policy set page-wide","`rel=\"nofollow ugc\"` on user-submitted links","No secrets in hidden inputs, comments or data attributes","Forms served and submitted over HTTPS"]}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 16, 'progressive_detail'::public.block_type, 'What about `integrity`?', 'Subresource Integrity lets you pin the exact contents of a third-party file: `<script src="https://cdn.example/lib.js" integrity="sha384-…" crossorigin="anonymous"></script>`. If the file changes by so much as a byte, the browser refuses to run it. It is genuinely useful when loading code from a CDN you do not control. It is also a good illustration of HTML''s role in security: it does not make the code safe, it just guarantees you got the code you agreed to.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 17, 'interactive_demo'::public.block_type, 'The same external link, three ways', 'Only one of these is safe and honest about what it does.',
       NULL, NULL, NULL, '{"variants":[{"label":"Safe","code":"<a href=\"https://example.org/report\" target=\"_blank\" rel=\"noopener noreferrer\">The 2026 cycling report (opens in a new tab)</a>","note":"The opened page gets no reference back to your tab and no referrer, and the visitor is told a new tab is coming."},{"label":"No rel","code":"<a href=\"https://example.org/report\" target=\"_blank\">The 2026 cycling report</a>","note":"Modern browsers imply noopener, so this is no longer the hole it once was — but it still leaks your full URL as the referrer, and still surprises the visitor."},{"label":"Same tab","code":"<a href=\"https://example.org/report\">The 2026 cycling report</a>","note":"Often the best answer. Nothing to leak, nothing to warn about, and the Back button still works."}]}'::jsonb
from public.lessons where slug = 'html-security';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 18, 'summary'::public.block_type, 'Lesson summary', NULL,
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
-- lesson: Third-party content and embeds
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'third-party-and-embeds', 3, 'Third-party content and embeds', 'The code you did not write, running on your page', 'Almost every slow site is slow because of things someone else wrote. Here is what markup can do about it.',
       ARRAY['Explain what an embed actually costs', 'Defer and sandbox third-party frames', 'Use `preconnect` and `dns-prefetch` where they genuinely help']::text[], 15, 40, (select id from public.skills where slug = 'performance'), 0.7
from public.modules m where m.slug = 'html-performance'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A page embeds one video player from another site. Roughly how much does that typically add before the visitor has watched anything?',
       NULL, NULL, NULL, '{"options":["Often more than the entire rest of the page combined","A few kilobytes — it is only an iframe","Nothing until the visitor presses play","It depends only on your own server"],"answer":"Often more than everything else on the page put together. A typical embedded player pulls in its own HTML, its own scripts, its own styles, frequently its own analytics, and connects to several additional hosts — all before anyone presses play. This is why \"the site is slow\" so often traces back to something nobody on the team wrote, and why deciding *when* an embed loads is one of the highest-value markup decisions available to you."}'::jsonb
from public.lessons where slug = 'third-party-and-embeds';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Weigh the real cost of an embed before adding one","Defer offscreen frames and restrict what they may do","Warm up connections to hosts you will definitely use"]}'::jsonb
from public.lessons where slug = 'third-party-and-embeds';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'An `<iframe>` is not a picture of another page. It is another whole page, with its own network requests, its own scripts and its own memory, rendered inside yours. Treat it as such.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'third-party-and-embeds';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<iframe
  src="https://example.org/player/12345"
  title="Introduction to sourdough, 4 minutes"
  loading="lazy"
  sandbox="allow-scripts allow-same-origin allow-presentation"
  referrerpolicy="no-referrer"
  width="560" height="315"></iframe>', 'html', NULL, '{"annotations":[{"line":"3","text":"`title` is not optional. Without it the frame is announced as an unnamed frame, and a page with three of them becomes unnavigable."},{"line":"4","text":"`loading=\"lazy\"` on an offscreen embed is the single biggest win available here — it moves the entire cost until the visitor scrolls to it."},{"line":"5","text":"Start from nothing and grant back only what the embed genuinely needs. Note what is *not* granted: no top-navigation, so it cannot redirect your page; no popups; no downloads."},{"line":"6","text":"`no-referrer` means the third party is told nothing about which page the visitor came from."},{"line":"7","text":"Dimensions, for the same reason images need them — otherwise the page jumps when the frame resolves."}]}'::jsonb
from public.lessons where slug = 'third-party-and-embeds';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, '`allow-scripts` plus `allow-same-origin` removes most of the protection', 'Granted together, a frame from *your own origin* can reach out and remove its own sandbox attribute. For same-origin embeds, that combination is close to no sandbox at all. It is fine for a genuinely third-party origin, which cannot touch your document either way — but know which case you are in rather than copying the pair by habit.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'third-party-and-embeds';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'interactive_demo'::public.block_type, 'Where an embed loads', 'The same video embed, placed and configured three ways.',
       NULL, NULL, NULL, '{"variants":[{"label":"Lazy, below the fold","code":"<h1>How we bake</h1>\n<p>Fifteen hours, start to finish.</p>\n<iframe src=\"about:blank\" title=\"Introduction to sourdough\" loading=\"lazy\" width=\"560\" height=\"315\"></iframe>","note":"Costs nothing until the visitor scrolls to it. The right default for any embed that is not the point of the page."},{"label":"Eager, at the top","code":"<iframe src=\"about:blank\" title=\"Introduction to sourdough\" width=\"560\" height=\"315\"></iframe>\n<h1>How we bake</h1>","note":"Correct only when the embed *is* the page — a video the visitor came specifically to watch."},{"label":"No title, no dimensions","code":"<iframe src=\"about:blank\"></iframe>","note":"Announced as an unnamed frame, and the page jumps when it resolves. Two bugs in one line."}]}'::jsonb
from public.lessons where slug = 'third-party-and-embeds';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'Resource hints, applied to embeds', 'You met `preconnect` and `dns-prefetch` in the loading-strategy lesson. Embeds are the case where they pay off most, because a third-party frame reaches hosts the browser cannot discover until the frame itself has loaded. One `preconnect` to the embed provider is often worthwhile — and the same limit applies as before: two or three hosts, not ten, because prioritising everything prioritises nothing.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'third-party-and-embeds';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'self_explain'::public.block_type, 'Explain it in your own words', 'Your team wants to add three embeds to the homepage: a video, a map, and a social feed. Write the case you would make. Do not say "embeds are slow" — be specific about what each one costs and what you would do about it if the answer is that they stay.',
       NULL, NULL, NULL, '{"modelAnswer":"Each one is a whole page loaded inside yours: its own scripts, styles, connections and often its own analytics, typically dwarfing everything the team actually wrote. Three of them means three of that. If they stay, the markup can still do a great deal — every one gets `loading=\"lazy\"` so nothing loads until it is scrolled to, a `title` so the page stays navigable, dimensions so it does not shift the layout, a minimal `sandbox`, and `referrerpolicy=\"no-referrer\"` so three third parties are not told the visitor''s exact page. The stronger option for the map and the feed is a static image that links out, loading the real embed only when someone asks for it — which costs nothing for the large majority who never interact with either."}'::jsonb
from public.lessons where slug = 'third-party-and-embeds';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'progressive_detail'::public.block_type, 'The placeholder pattern', 'For a map or a social feed, the strongest option is not a better-configured embed — it is no embed until someone asks for one. Show a static image with a link or a button, and load the real thing only on interaction. Most visitors never interact, so most visitors pay nothing at all. The markup is ordinary: an `<img>`, an `<a>` or `<button>`, and the embed added afterwards. This is the one performance technique on the page that can remove a cost entirely rather than merely moving it.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'third-party-and-embeds';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'checklist'::public.block_type, 'Before you accept an embed', NULL,
       NULL, NULL, NULL, '{"items":["Does the page genuinely need it, or would a linked image do?","Does it have a `title`?","Is it `loading=\"lazy\"` unless it is the point of the page?","Does it have `width` and `height`?","Is it sandboxed to the minimum it needs?","Does it have a referrer policy?","Are you preconnecting to at most two or three hosts?"]}'::jsonb
from public.lessons where slug = 'third-party-and-embeds';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["An embed is another whole page, and usually costs more than everything you wrote.","`loading=\"lazy\"`, `title`, dimensions and `sandbox` are the four attributes every frame wants.","`allow-scripts` with `allow-same-origin` is close to no sandbox for a same-origin frame.","A static placeholder that loads the embed on interaction removes the cost rather than deferring it."],"nextUp":"Next: the Level 10 milestone."}'::jsonb
from public.lessons where slug = 'third-party-and-embeds';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What does an embedded player actually cost, before anyone interacts with it?","Name the four attributes every `<iframe>` should carry, and why.","Why is a static placeholder stronger than a well-configured embed?"],"points":["Its own HTML, scripts, styles, analytics and extra host connections — frequently more than the entire rest of the page combined.","`title` so it is announced and navigable; `loading=\"lazy\"` so an offscreen frame costs nothing until reached; `width`/`height` so the layout does not shift; `sandbox` so it can only do what it needs.","Because it removes the cost rather than moving it. A lazy embed still loads in full for anyone who scrolls to it; a placeholder loads the embed only for the minority who actually interact, so most visitors pay nothing at all."]}'::jsonb
from public.lessons where slug = 'third-party-and-embeds';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'embed-hardening-guided', 1, 'guided'::public.exercise_kind, 'Make an embed behave',
       'The embed below sits well down a long page. Give it a `title` describing what it is, make it lazy, add its `width` and `height` (560 by 315), sandbox it to scripts and presentation only, and stop it leaking the referrer.', '<h1>How we bake</h1>
<p>Fifteen hours from mix to cooling rack.</p>
<iframe src="https://example.org/player/12345"></iframe>', '<h1>How we bake</h1>
<p>Fifteen hours from mix to cooling rack.</p>
<iframe src="https://example.org/player/12345"
        title="Introduction to sourdough, 4 minutes"
        loading="lazy"
        sandbox="allow-scripts allow-presentation"
        referrerpolicy="no-referrer"
        width="560" height="315"></iframe>', ARRAY['The title should say what the embed contains, not just "video".', 'loading="lazy" is what stops it costing anything until scrolled to.', 'sandbox takes a space-separated list of permissions to grant back.', 'referrerpolicy="no-referrer" sends the third party nothing.']::text[],
       45, 3,
       (select id from public.skills where slug = 'performance'), false
from public.lessons l where l.slug = 'third-party-and-embeds'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'iframe', NULL,
       NULL, NULL, NULL, NULL,
       'The embed is still there', NULL, 1, true
from public.exercises e where e.slug = 'embed-hardening-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'iframe', 'title',
       NULL, NULL, NULL, NULL,
       'The frame has a title', NULL, 1, true
from public.exercises e where e.slug = 'embed-hardening-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_matches'::public.requirement_kind, 'iframe', 'title',
       '.{10,}', NULL, NULL, NULL,
       'The title actually describes the embed', NULL, 1, true
from public.exercises e where e.slug = 'embed-hardening-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'iframe', 'loading',
       'lazy', NULL, NULL, NULL,
       'The frame is lazy-loaded', NULL, 1, true
from public.exercises e where e.slug = 'embed-hardening-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_present'::public.requirement_kind, 'iframe', 'sandbox',
       NULL, NULL, NULL, NULL,
       'The frame is sandboxed', NULL, 1, true
from public.exercises e where e.slug = 'embed-hardening-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'attribute_value'::public.requirement_kind, 'iframe', 'referrerpolicy',
       'no-referrer', NULL, NULL, NULL,
       'The frame sends no referrer', NULL, 1, true
from public.exercises e where e.slug = 'embed-hardening-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'attribute_present'::public.requirement_kind, 'iframe', 'width',
       NULL, NULL, NULL, NULL,
       'The frame declares its width', NULL, 1, true
from public.exercises e where e.slug = 'embed-hardening-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'attribute_present'::public.requirement_kind, 'iframe', 'height',
       NULL, NULL, NULL, NULL,
       'The frame declares its height', NULL, 1, true
from public.exercises e where e.slug = 'embed-hardening-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'third-party-debug', 2, 'debug'::public.exercise_kind, 'A homepage full of other people''s code',
       'Three problems: an unnamed eager iframe, a render-blocking script in the head, and eight preconnects. Give the frame a title and make it lazy, defer the script, and cut the preconnects down to the one host that is genuinely certain.', '<head>
  <link rel="preconnect" href="https://a.example.com">
  <link rel="preconnect" href="https://b.example.com">
  <link rel="preconnect" href="https://c.example.com">
  <script src="/analytics.js"></script>
</head>
<body>
  <h1>Riverside Bakery</h1>
  <iframe src="https://example.org/map"></iframe>
</body>', '<head>
  <link rel="preconnect" href="https://a.example.com">
  <script src="/analytics.js" defer></script>
</head>
<body>
  <h1>Riverside Bakery</h1>
  <iframe src="https://example.org/map" title="Map of the bakery location"
          loading="lazy" width="560" height="315"></iframe>
</body>', ARRAY['Keep one preconnect and delete the rest.', 'Adding defer to the script stops it blocking the parser.', 'The iframe needs a title, loading="lazy" and dimensions.']::text[],
       55, 4,
       (select id from public.skills where slug = 'performance'), false
from public.lessons l where l.slug = 'third-party-and-embeds'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'link[rel="preconnect"]', NULL,
       NULL, NULL, 1, 1,
       'Only one host is preconnected', NULL, 1, true
from public.exercises e where e.slug = 'third-party-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'script', 'defer',
       NULL, NULL, NULL, NULL,
       'The script no longer blocks parsing', NULL, 1, true
from public.exercises e where e.slug = 'third-party-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'iframe', 'title',
       NULL, NULL, NULL, NULL,
       'The frame has a title', NULL, 1, true
from public.exercises e where e.slug = 'third-party-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'iframe', 'loading',
       'lazy', NULL, NULL, NULL,
       'The frame is lazy-loaded', NULL, 1, true
from public.exercises e where e.slug = 'third-party-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_present'::public.requirement_kind, 'iframe', 'width',
       NULL, NULL, NULL, NULL,
       'The frame declares its dimensions', NULL, 1, true
from public.exercises e where e.slug = 'third-party-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'third-party-and-embeds'), NULL, 'q-iframe-cost', 1, 'single'::public.question_kind,
        'What is an `<iframe>` embed, in resource terms?', 'It is another complete page — its own requests, scripts, styles and memory — rendered inside yours.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A lightweight reference costing a few kilobytes', false, NULL
from public.quiz_questions where slug = 'q-iframe-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A copy of content fetched by your own server', false, NULL
from public.quiz_questions where slug = 'q-iframe-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Another complete page, with its own requests and scripts', true, NULL
from public.quiz_questions where slug = 'q-iframe-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A static image of another page', false, NULL
from public.quiz_questions where slug = 'q-iframe-cost';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'third-party-and-embeds'), NULL, 'q-sandbox-combination', 2, 'single'::public.question_kind,
        'Why is `sandbox="allow-scripts allow-same-origin"` weak on a same-origin frame?', 'Together they let the framed document reach out and remove its own sandbox attribute.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Browsers ignore sandbox when two values are given', false, NULL
from public.quiz_questions where slug = 'q-sandbox-combination';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It blocks the frame from loading at all', false, NULL
from public.quiz_questions where slug = 'q-sandbox-combination';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is fine — the combination is the recommended default', false, NULL
from public.quiz_questions where slug = 'q-sandbox-combination';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The frame can remove its own sandbox attribute', true, NULL
from public.quiz_questions where slug = 'q-sandbox-combination';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'third-party-and-embeds'), NULL, 'q-defer-vs-async', 3, 'single'::public.question_kind,
        'What does `defer` do that `async` does not?', '`defer` runs scripts after parsing in document order. `async` runs each as soon as it arrives, in no predictable order.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Runs the script before the parser starts', false, NULL
from public.quiz_questions where slug = 'q-defer-vs-async';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Runs after parsing, preserving document order', true, NULL
from public.quiz_questions where slug = 'q-defer-vs-async';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Downloads the script faster', false, NULL
from public.quiz_questions where slug = 'q-defer-vs-async';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Prevents the script from running at all', false, NULL
from public.quiz_questions where slug = 'q-defer-vs-async';
-- lesson: Milestone: repair a slow, unsafe page
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'performance-milestone', 4, 'Milestone: repair a slow, unsafe page', 'Every problem from this level, on one page', 'The page in this milestone is slow, jumps as it loads, and hands data to third parties.',
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
select id, 6, 'media_example'::public.block_type, 'The image that decides how fast the page feels', 'On a page like this the banner *is* the perceived load time. It gets dimensions so nothing shifts, a priority hint so it is fetched first, and deliberately no `loading="lazy"` — the two would contradict each other.',
       '<img src="/learning-media/images/vehicle-hire.jpg"
     alt="A blue five-door car photographed side-on, parked on an open road"
     width="1600" height="900" fetchpriority="high">', 'html', 'vehicle-hire', '{}'::jsonb
from public.lessons where slug = 'performance-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'interactive_demo'::public.block_type, 'The same repair, measured', 'What each change actually buys.',
       NULL, NULL, NULL, '{"variants":[{"label":"Repaired","code":"<img src=\"/learning-media/images/vehicle-hire.jpg\" alt=\"A blue five-door car parked on an open road\" width=\"1600\" height=\"900\" fetchpriority=\"high\">\n<iframe src=\"https://example.org/map\" title=\"Location map\" loading=\"lazy\" width=\"560\" height=\"315\"></iframe>","note":"Nothing shifts, the banner is fetched first, and the map costs nothing until somebody scrolls to it."},{"label":"As found","code":"<img src=\"/learning-media/images/vehicle-hire.jpg\" alt=\"car\" loading=\"lazy\" fetchpriority=\"high\">\n<iframe src=\"https://example.org/map\"></iframe>","note":"No dimensions so the page jumps; lazy and high-priority contradicting each other on the banner; and an unnamed frame loading immediately."}]}'::jsonb
from public.lessons where slug = 'performance-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'recall'::public.block_type, 'The performance you already wrote', 'Most of this repair is applying earlier lessons with a new motive. From memory: which decisions from Levels 4 and 9 turn out to be performance decisions too?',
       NULL, NULL, NULL, '{"points":["Level 4 — `srcset` and `sizes` stop a phone downloading a 1600-pixel file to display it at 400.","Level 4 — `<picture>` offers a modern format with a fallback, which is usually the single largest byte saving available.","Level 4 — `width` and `height` on every image, which you learned for layout and which also stops the page shifting as it loads.","Level 9 — `<link rel=\"canonical\">` and clean metadata keep duplicate URLs from competing, so caching and crawling both do less work.","This level — `loading`, `fetchpriority` and `decoding` decide *when* and *in what order*, not how much."]}'::jsonb
from public.lessons where slug = 'performance-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
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
-- HTML Hero — Level 11: Debugging and Validation Master
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

commit;
