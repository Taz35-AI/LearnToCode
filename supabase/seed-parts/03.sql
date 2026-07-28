-- HTML Hero — course seed, part 3 of 11
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 2 first.

begin;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'Only three are genuinely required', 'With a UTF-8 charset you can type é, ©, — and almost anything else directly. Only `<`, `>` and `&` truly need entities, because they have meaning in HTML itself. `&nbsp;` is useful in one specific case: keeping "10 km" or "Dr Alvarez" from splitting across two lines.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'prose'::public.block_type, NULL, 'Lists come in three kinds, and choosing between them is a question about the content, not the appearance.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'comparison'::public.block_type, 'Ordered or unordered?', NULL,
       NULL, NULL, NULL, '{"good":{"label":"`<ol>` — the order is part of the meaning","code":"<ol>\n  <li>Unlock the bike</li>\n  <li>Adjust the saddle</li>\n  <li>Check the brakes</li>\n</ol>","why":"Steps in a procedure. Doing them in a different order would be wrong."},"bad":{"label":"`<ul>` — the order does not matter","code":"<ul>\n  <li>Helmet</li>\n  <li>Lock</li>\n  <li>Route map</li>\n</ul>","why":"A set of things. Shuffling them changes nothing."}}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'prose'::public.block_type, NULL, 'The third kind is the description list, `<dl>`. It pairs terms with their descriptions — a glossary, a specification table, a set of frequently asked questions.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<dl>
  <dt>Hourly</dt>
  <dd>£6 per bike, minimum two hours.</dd>

  <dt>Day rate</dt>
  <dd>£22 per bike, returned by 6pm.</dd>
</dl>', 'html', NULL, '{"annotations":[{"line":"1","text":"`<dl>` is the description list itself."},{"line":"2","text":"`<dt>` is a term being described."},{"line":"3","text":"`<dd>` is its description. One term can have several descriptions, and vice versa."}]}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'callout'::public.block_type, 'Lists nest inside `<li>`, not inside `<ul>`', 'A sub-list goes inside the list item it belongs to, before that item''s closing tag. Putting a `<ul>` directly inside another `<ul>` is invalid and produces an orphaned list.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'code_example'::public.block_type, 'Correctly nested lists', NULL,
       '<ul>
  <li>Bikes
    <ul>
      <li>Hybrid</li>
      <li>Road</li>
    </ul>
  </li>
  <li>Accessories</li>
</ul>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'interactive_demo'::public.block_type, 'Showing code on a page', 'To display a tag rather than have the browser act on it, the angle brackets must be escaped.',
       NULL, NULL, NULL, '{"variants":[{"label":"Escaped correctly","code":"<p>Wrap a heading in <code>&lt;h1&gt;</code> tags.</p>","note":"The entities produce the characters < and >, so the reader sees the tag written out. Nothing is interpreted as markup."},{"label":"Not escaped","code":"<p>Wrap a heading in <code><h1></code> tags.</p>","note":"The browser reads <h1> as an instruction, not as text. An empty heading is created and the sentence falls apart."},{"label":"A preformatted block","code":"<pre><code>&lt;ul&gt;\n  &lt;li&gt;Sourdough&lt;/li&gt;\n&lt;/ul&gt;</code></pre>","note":"<pre> keeps the line breaks and indentation exactly as typed, which is what makes multi-line code readable."}]}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 15, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<code>` for code in a sentence; `<pre>` preserves spacing exactly.","`&lt;`, `&gt;` and `&amp;` are the entities you genuinely need.","`<ol>` when order matters, `<ul>` when it does not, `<dl>` for term-and-description pairs.","Nest a sub-list inside the `<li>` it belongs to."],"nextUp":"Next: the Level 2 milestone — a complete article page."}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'lists-guided', 1, 'guided'::public.exercise_kind, 'Three lists, three meanings',
       'Build three lists: an ordered list of three setup steps, an unordered list of three items you should bring, and a description list with two term-and-description pairs for two hire rates.', '', '<h2>Before you set off</h2>
<ol>
  <li>Adjust the saddle height</li>
  <li>Check both brakes</li>
  <li>Test the bell</li>
</ol>

<h2>What to bring</h2>
<ul>
  <li>Water bottle</li>
  <li>Waterproof jacket</li>
  <li>Phone</li>
</ul>

<h2>Rates</h2>
<dl>
  <dt>Hourly</dt>
  <dd>£6 per bike, minimum two hours.</dd>
  <dt>Day rate</dt>
  <dd>£22 per bike, returned by 6pm.</dd>
</dl>', ARRAY['Steps happen in order, so that list is <ol>.', 'Items to bring have no order, so that list is <ul>.', 'The rates are term-and-description pairs: <dl> with <dt> and <dd>.']::text[],
       40, 2,
       (select id from public.skills where slug = 'lists'), false
from public.lessons l where l.slug = 'code-entities-and-lists'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'element_count'::public.requirement_kind, 'ol > li', NULL,
       NULL, NULL, 3, 3,
       'The ordered list has three steps', NULL, 1, true, NULL
from public.exercises e where e.slug = 'lists-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'element_count'::public.requirement_kind, 'ul > li', NULL,
       NULL, NULL, 3, 3,
       'The unordered list has three items', NULL, 1, true, NULL
from public.exercises e where e.slug = 'lists-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'element_count'::public.requirement_kind, 'dl > dt', NULL,
       NULL, NULL, 2, 2,
       'The description list has two terms', NULL, 1, true, NULL
from public.exercises e where e.slug = 'lists-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'element_count'::public.requirement_kind, 'dl > dd', NULL,
       NULL, NULL, 2, 2,
       'Each term has a description', NULL, 1, true, NULL
from public.exercises e where e.slug = 'lists-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true, NULL
from public.exercises e where e.slug = 'lists-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'entities-debug', 2, 'debug'::public.exercise_kind, 'The page that swallowed itself',
       'This page tries to show some HTML but typed the angle brackets directly, so the browser read them as real tags and the text vanished. Replace them with entities so the code shows on the page as text.', '<h2>The title element</h2>
<p>Every page needs a <code><title></code> element in its head.</p>
<p>Ampersands must be written as & too.</p>', '<h2>The title element</h2>
<p>Every page needs a <code>&lt;title&gt;</code> element in its head.</p>
<p>Ampersands must be written as &amp; too.</p>', ARRAY['Replace the < you want to *display* with &lt; and the > with &gt;.', 'A bare & should be written &amp;.', 'The <code> tags themselves stay as real tags — only the ones inside it become entities.']::text[],
       40, 3,
       (select id from public.skills where slug = 'validation'), false
from public.lessons l where l.slug = 'code-entities-and-lists'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'element_present'::public.requirement_kind, 'code', NULL,
       NULL, NULL, NULL, NULL,
       'The <code> element is still there', NULL, 1, true, NULL
from public.exercises e where e.slug = 'entities-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'text_content'::public.requirement_kind, 'code', NULL,
       '<title>', NULL, NULL, NULL,
       'The code element displays the text "<title>"', NULL, 1, true, NULL
from public.exercises e where e.slug = 'entities-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'element_count'::public.requirement_kind, 'title', NULL,
       NULL, NULL, 0, 0,
       'No accidental real <title> element was created', NULL, 1, true, NULL
from public.exercises e where e.slug = 'entities-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'text_content'::public.requirement_kind, 'p', NULL,
       '&', NULL, NULL, NULL,
       'The ampersand displays as a character', NULL, 1, true, NULL
from public.exercises e where e.slug = 'entities-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'code-entities-and-lists'), NULL, 'q-entity-lt', 1, 'single'::public.question_kind,
        'How do you display a `<` character on a page?', 'Write the entity `&lt;`. Typing the character directly makes the browser think a tag is starting.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '\<', false, NULL
from public.quiz_questions where slug = 'q-entity-lt';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Just type < — browsers handle it', false, NULL
from public.quiz_questions where slug = 'q-entity-lt';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '&lt;', true, NULL
from public.quiz_questions where slug = 'q-entity-lt';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '&lessthan;', false, NULL
from public.quiz_questions where slug = 'q-entity-lt';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'code-entities-and-lists'), NULL, 'q-list-choice', 2, 'single'::public.question_kind,
        'Which list element suits a recipe''s method?', 'The steps of a method must happen in order, so `<ol>` is correct. `<ul>` would suit the ingredients.', (select id from public.skills where slug = 'lists'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<ol>', true, NULL
from public.quiz_questions where slug = 'q-list-choice';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<ul>', false, NULL
from public.quiz_questions where slug = 'q-list-choice';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<dl>', false, NULL
from public.quiz_questions where slug = 'q-list-choice';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<pre>', false, NULL
from public.quiz_questions where slug = 'q-list-choice';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'code-entities-and-lists'), NULL, 'q-nested-list', 3, 'single'::public.question_kind,
        'Where does a nested sub-list belong?', 'Inside the `<li>` it relates to, before that item''s closing tag. Placing a list directly inside a `<ul>` is invalid.', (select id from public.skills where slug = 'lists'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Inside the <li> it belongs to', true, NULL
from public.quiz_questions where slug = 'q-nested-list';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Directly inside the parent <ul>', false, NULL
from public.quiz_questions where slug = 'q-nested-list';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'After the parent list closes', false, NULL
from public.quiz_questions where slug = 'q-nested-list';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Inside a <dd> element', false, NULL
from public.quiz_questions where slug = 'q-nested-list';
-- lesson: Milestone: a real information page
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'article-milestone', 4, 'Milestone: a real information page', 'Everything from Level 2, on one page', 'Build a complete article page with a correct heading hierarchy, precise text semantics, lists and a properly attributed quotation.',
       ARRAY['Combine every Level 2 element on one realistic page', 'Make deliberate semantic choices and be able to justify them', 'Add an information page to your capstone project']::text[], 25, 40, (select id from public.skills where slug = 'text-semantics'), 0.8
from public.modules m where m.slug = 'text-level-semantics'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Produce a realistic article page with correct structure throughout","Use at least six different text-level elements appropriately","Add this page to your capstone website"]}'::jsonb
from public.lessons where slug = 'article-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'This milestone is a single page of realistic content — the kind of page every site has: an article, a guide, a page explaining what you do. The checker looks at structure, not wording, so write about whatever your project is.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'article-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'checklist'::public.block_type, 'Your page must contain', NULL,
       NULL, NULL, NULL, '{"items":["The full document skeleton, with a title of its own","One `<h1>` and at least two `<h2>` sections, in correct order","At least three paragraphs of genuine prose","A list — ordered or unordered, whichever fits","`<strong>` and `<em>`, each used for its real meaning","An `<abbr>` with a `title`, or a `<time>` with a `datetime`","A `<blockquote>` with a `<figcaption>` attributing it"]}'::jsonb
from public.lessons where slug = 'article-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Write the content first, in plain text', 'Decide what the page says before you mark it up. Then go through and ask of each piece: what *is* this? The element usually names itself once the question is asked that way round.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'article-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'The shape of a real information page', NULL,
       '<h1>Getting started with river routes</h1>
<p>The valley has around forty miles of traffic-free path.</p>

<h2>Before you set off</h2>
<p><strong>Check your brakes before every ride.</strong></p>
<ol>
  <li>Adjust the saddle</li>
  <li>Squeeze both brakes firmly</li>
</ol>

<h2>The routes</h2>
<p>Leave <em>before</em> noon for the longest one.</p>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'article-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'visual'::public.block_type, NULL, 'Your page should read as a clean outline like this one.',
       NULL, NULL, 'heading-hierarchy', '{}'::jsonb
from public.lessons where slug = 'article-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'progressive_detail'::public.block_type, 'How long should the page be?', 'Long enough to need two sections and short enough that you can still hold the whole structure in your head. Three or four hundred words is plenty. The exercise is about making accurate structural decisions, not about producing volume — a short page with precise markup demonstrates far more than a long one with vague markup.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'article-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'The same article, structured and flat', 'Both contain identical words.',
       NULL, NULL, NULL, '{"variants":[{"label":"Structured","code":"<article>\n  <h1>Fifteen hours to a loaf</h1>\n  <p>Published <time datetime=\"2026-03-04\">4 March 2026</time></p>\n  <h2>The starter</h2>\n  <p>It begins the night before.</p>\n  <h2>The bake</h2>\n  <p>Forty minutes, no more.</p>\n</article>","note":"A screen-reader user can list the headings and jump to the part they want. The date is machine-readable."},{"label":"Flat","code":"<p><b>Fifteen hours to a loaf</b></p>\n<p>Published 4 March 2026</p>\n<p><b>The starter</b></p>\n<p>It begins the night before.</p>\n<p><b>The bake</b></p>\n<p>Forty minutes, no more.</p>","note":"Looks similar and has no structure at all: no headings to navigate by, no article, and a date nothing can parse."}]}'::jsonb
from public.lessons where slug = 'article-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["You can now mark up a full page of realistic text with accurate semantics.","Heading hierarchy, lists, emphasis, quotations and dates all have a correct element.","Your capstone site now has two pages of real content."],"nextUp":"Level 3 next: connecting pages together."}'::jsonb
from public.lessons where slug = 'article-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'article-milestone-build', 1, 'challenge'::public.exercise_kind, 'Milestone: build an information page',
       'Write a complete HTML document for an information page on your project''s subject. Follow the checklist above. Content is entirely up to you — the structure is what is assessed.', '', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Getting started with river routes — Riverside Cycle Hire</title>
  </head>
  <body>
    <h1>Getting started with river routes</h1>
    <p>
      The valley has around forty miles of traffic-free path. This guide covers
      the three routes we recommend to people riding here for the first time.
    </p>

    <h2>Before you set off</h2>
    <p>
      <strong>Check your brakes before every ride.</strong> If anything feels
      soft, bring the bike back — we would far rather adjust it than have you
      find out on a descent.
    </p>
    <ol>
      <li>Adjust the saddle so your leg is almost straight at the bottom</li>
      <li>Squeeze both brakes firmly</li>
      <li>Check the tyres are hard</li>
    </ol>

    <h2>The three routes</h2>
    <p>
      All three start at the workshop. The shortest takes about an hour; the
      longest is a half-day ride, so leave <em>before</em> noon.
    </p>
    <ul>
      <li>Harbour loop — 6 miles, flat</li>
      <li>Mill and back — 11 miles, one climb</li>
      <li>The full valley — 24 miles</li>
    </ul>
    <p>
      Our next guided ride is on
      <time datetime="2026-08-15T09:30">15 August at 9.30am</time>, run with the
      <abbr title="Hexford Cycling Club">HCC</abbr>.
    </p>

    <figure>
      <blockquote cite="https://example.org/cycling-report-2026">
        <p>
          Towns that added protected lanes saw a 34% rise in journeys made by
          bike within two years.
        </p>
      </blockquote>
      <figcaption>
        Transport Research Unit, <cite>Cycling in Small Towns</cite>, 2026
      </figcaption>
    </figure>

    <p><small>Route distances are approximate and measured from the workshop.</small></p>
  </body>
</html>', ARRAY['Start with the document skeleton, then the h1, then work down the page.', 'Two <h2> sections give you a natural place for the list and the quotation.', 'Remember the blockquote needs a <figcaption> beside it inside a <figure>.', 'The <abbr> needs title="…" and the <time> needs datetime="…".']::text[],
       100, 3,
       (select id from public.skills where slug = 'text-semantics'), false
from public.lessons l where l.slug = 'article-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'Exactly one h1', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'element_count'::public.requirement_kind, 'h2', NULL,
       NULL, NULL, 2, NULL,
       'At least two h2 sections', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'element_count'::public.requirement_kind, 'p', NULL,
       NULL, NULL, 3, NULL,
       'At least three paragraphs', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 7, 'element_present'::public.requirement_kind, 'ul li, ol li', NULL,
       NULL, NULL, NULL, NULL,
       'There is a list with items', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 8, 'element_present'::public.requirement_kind, 'strong', NULL,
       NULL, NULL, NULL, NULL,
       'Uses <strong> for something important', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 9, 'element_present'::public.requirement_kind, 'em', NULL,
       NULL, NULL, NULL, NULL,
       'Uses <em> for stress emphasis', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 10, 'element_present'::public.requirement_kind, 'abbr[title], time[datetime]', NULL,
       NULL, NULL, NULL, NULL,
       'Uses an abbreviation with a title, or a time with a datetime', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 11, 'element_present'::public.requirement_kind, 'blockquote', NULL,
       NULL, NULL, NULL, NULL,
       'There is a block quotation', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 12, 'element_present'::public.requirement_kind, 'figcaption', NULL,
       NULL, NULL, NULL, NULL,
       'The quotation is attributed with a figcaption', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 13, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 14, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id is unique', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-milestone-build';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'article-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: add about.html',
       'Add a second page to your capstone site: `about.html`. It should tell the story behind your project using the semantics from this level — headings, paragraphs, a list, and at least one quotation or key date.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About — your site name</title>
  </head>
  <body>
    <h1>About us</h1>
    <p>Replace with your own opening paragraph.</p>

    <h2>A section heading</h2>
    <p>More of your own content.</p>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About us — Riverside Cycle Hire</title>
  </head>
  <body>
    <h1>About us</h1>
    <p>We have hired bikes from the same Mill Lane workshop since 1998.</p>
    <h2>What we believe</h2>
    <p><strong>Every bike leaves serviced.</strong> No exceptions.</p>
    <ul>
      <li>Mechanics on site, every day we are open</li>
      <li>Helmet and lock included with every hire</li>
    </ul>
    <h2>Our history</h2>
    <p>We opened on <time datetime="1998-04-02">2 April 1998</time> with six bikes.</p>
  </body>
</html>', ARRAY['Replace every placeholder sentence with your own content.', 'At least two <h2> sections keeps the page readable.', 'Include a list and either a <time datetime="…"> or a quotation.']::text[],
       70, 3,
       (select id from public.skills where slug = 'multi-page'), false
from public.lessons l where l.slug = 'article-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true, NULL
from public.exercises e where e.slug = 'article-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'One h1 naming the page', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'element_count'::public.requirement_kind, 'h2', NULL,
       NULL, NULL, 1, NULL,
       'At least one h2 section', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true, NULL
from public.exercises e where e.slug = 'article-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'element_count'::public.requirement_kind, 'p', NULL,
       NULL, NULL, 2, NULL,
       'At least two paragraphs of your own', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'element_present'::public.requirement_kind, 'ul li, ol li', NULL,
       NULL, NULL, NULL, NULL,
       'A list of items', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 7, 'element_present'::public.requirement_kind, 'strong, em, time[datetime], blockquote', NULL,
       NULL, NULL, NULL, NULL,
       'At least one text-level semantic element', NULL, 1, true, NULL
from public.exercises e where e.slug = 'article-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'article-milestone'), NULL, 'q-semantic-choice', 1, 'single'::public.question_kind,
        'You are marking up "Doors open at 7pm." on an event page. What is the best markup?', 'Wrapping the time in `<time datetime="19:00">` keeps the friendly wording while making the value machine-readable — calendars and search engines can then use it.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<p>Doors open at <time datetime="19:00">7pm</time>.</p>', true, NULL
from public.quiz_questions where slug = 'q-semantic-choice';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<p>Doors open at <strong>7pm</strong>.</p>', false, NULL
from public.quiz_questions where slug = 'q-semantic-choice';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<h3>Doors open at 7pm.</h3>', false, NULL
from public.quiz_questions where slug = 'q-semantic-choice';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<p>Doors open at <b>7pm</b>.</p>', false, NULL
from public.quiz_questions where slug = 'q-semantic-choice';
-- Level 2 milestone: Content Builder questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-2-milestone'), 'a2-q1', 1, 'single'::public.question_kind,
        'A page has an `<h2>`, and the next heading needs to be one level down. Which element?', 'Levels step down one at a time: `<h2>` is followed by `<h3>`.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<h3>', true, NULL
from public.quiz_questions where slug = 'a2-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<h4>', false, NULL
from public.quiz_questions where slug = 'a2-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<h1>', false, NULL
from public.quiz_questions where slug = 'a2-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<p><strong>', false, NULL
from public.quiz_questions where slug = 'a2-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-2-milestone'), 'a2-q2', 2, 'single'::public.question_kind,
        'Which element marks a change of subject?', '`<hr>` means a thematic break. The horizontal line is only its default appearance.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<br>', false, NULL
from public.quiz_questions where slug = 'a2-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<small>', false, NULL
from public.quiz_questions where slug = 'a2-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<mark>', false, NULL
from public.quiz_questions where slug = 'a2-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<hr>', true, NULL
from public.quiz_questions where slug = 'a2-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-2-milestone'), 'a2-q3', 3, 'single'::public.question_kind,
        'Which is the correct use of `<strong>`?', '`<strong>` conveys importance or urgency, not merely bold appearance.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Around a word you want stressed when read aloud', false, NULL
from public.quiz_questions where slug = 'a2-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Around anything you want in bold', false, NULL
from public.quiz_questions where slug = 'a2-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Around a safety warning', true, NULL
from public.quiz_questions where slug = 'a2-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Around a page heading', false, NULL
from public.quiz_questions where slug = 'a2-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-2-milestone'), 'a2-q4', 4, 'single'::public.question_kind,
        'Which three characters genuinely need HTML entities?', 'Only `<`, `>` and `&` have special meaning in HTML. With UTF-8, other characters can be typed directly.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '£ $ €', false, NULL
from public.quiz_questions where slug = 'a2-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '< > &', true, NULL
from public.quiz_questions where slug = 'a2-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '© é —', false, NULL
from public.quiz_questions where slug = 'a2-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '" '' /', false, NULL
from public.quiz_questions where slug = 'a2-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-2-milestone'), 'a2-q5', 5, 'single'::public.question_kind,
        'Which list would you use for a glossary of terms?', '`<dl>` pairs each term (`<dt>`) with its description (`<dd>`).', (select id from public.skills where slug = 'lists'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<dl>', true, NULL
from public.quiz_questions where slug = 'a2-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<ul>', false, NULL
from public.quiz_questions where slug = 'a2-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<ol>', false, NULL
from public.quiz_questions where slug = 'a2-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<table>', false, NULL
from public.quiz_questions where slug = 'a2-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-2-milestone'), 'a2-q6', 6, 'single'::public.question_kind,
        'What is wrong with using `<br><br>` between two paragraphs?', 'The paragraphs already separate themselves. The breaks add empty content that spacing should provide, and it cannot adapt responsively.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It is invalid HTML', false, NULL
from public.quiz_questions where slug = 'a2-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Browsers ignore it entirely', false, NULL
from public.quiz_questions where slug = 'a2-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It creates a duplicate id', false, NULL
from public.quiz_questions where slug = 'a2-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It adds meaningless content where spacing belongs', true, NULL
from public.quiz_questions where slug = 'a2-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-2-milestone'), 'a2-q7', 7, 'single'::public.question_kind,
        'Where must a nested list be placed?', 'Inside the `<li>` it belongs to.', (select id from public.skills where slug = 'lists'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Between two <li> elements', false, NULL
from public.quiz_questions where slug = 'a2-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'After the parent list', false, NULL
from public.quiz_questions where slug = 'a2-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Inside the <li> it relates to', true, NULL
from public.quiz_questions where slug = 'a2-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Directly inside the parent <ul>', false, NULL
from public.quiz_questions where slug = 'a2-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-2-milestone'), 'a2-q8', 8, 'single'::public.question_kind,
        'What does `<pre>` do that other elements do not?', 'It preserves whitespace exactly as written — the one place HTML does not collapse spaces and line breaks.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Escapes HTML entities automatically', false, NULL
from public.quiz_questions where slug = 'a2-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Preserves spaces and line breaks exactly', true, NULL
from public.quiz_questions where slug = 'a2-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Marks text as computer code', false, NULL
from public.quiz_questions where slug = 'a2-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Prevents the text being copied', false, NULL
from public.quiz_questions where slug = 'a2-q8';
-- --------------------------------------------------------------------------
-- HTML Hero — Level 3: Navigation Architect
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'navigation-architect', 3, 'Navigation Architect', 'Connect pages into a website people can actually move around',
       'Links are what make the web a web. This level covers every kind of link, how file paths really work, and how to build navigation that works with a mouse, a keyboard and a screen reader.', 'You can build and connect a multi-page website with consistent, accessible navigation.', 'indigo'
from public.courses c where c.slug = 'html-hero'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-3-milestone', 'milestone'::public.assessment_kind, 'Level 3 milestone: Navigation Architect', 'Eight questions on links, paths and navigation. Pass mark 75%.',
       0.75, 160, 3
from public.levels l where l.slug = 'navigation-architect'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Links and file paths
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'links-and-paths', 1, 'Links and file paths', 'The anchor element in depth, and the single topic that trips up more beginners than any other: relative paths.',
       50, false
from public.levels l where l.slug = 'navigation-architect'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'links-and-paths' and p.slug = 'text-level-semantics';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'links-and-paths' and s.slug = 'links';
-- lesson: The anchor element and link text that works
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'anchors-and-link-text', 1, 'The anchor element and link text that works', 'href, targets, and why "click here" fails real users', 'One element, one essential attribute — and one writing habit that makes a measurable accessibility difference.',
       ARRAY['Link to another page with the anchor element', 'Write link text that makes sense out of context', 'Open external links safely']::text[], 14, 40, (select id from public.skills where slug = 'links'), 0.7
from public.modules m where m.slug = 'links-and-paths'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Create links using the anchor element and its href attribute","Write descriptive link text and explain why it matters","Use rel=\"noopener noreferrer\" when opening a link in a new tab"]}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'A link is an `<a>` element with an `href` attribute. The `href` says where the link goes; the content between the tags is what the visitor sees and clicks.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'visual'::public.block_type, NULL, 'A link, with each part labelled.',
       NULL, NULL, 'anatomy-of-an-element', '{}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'A link to another page in your site, and a link to another site', NULL,
       '<a href="about.html">About our workshop</a>
<a href="https://www.example.org/">The example organisation</a>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Why "click here" is a genuine problem', 'Screen-reader users can pull up a list of every link on a page and jump between them — exactly as sighted users scan for the blue text. In that list the link text appears with no surrounding sentence. A page of "click here", "read more", "click here" gives a list that is completely useless. Link text must make sense entirely on its own.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'comparison'::public.block_type, 'Link text out of context', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Works alone","code":"<p>Rates start at £6 an hour. <a href=\"prices.html\">See our full price list</a>.</p>","why":"In a list of links this reads \"See our full price list\" — instantly clear."},"bad":{"label":"Meaningless alone","code":"<p>Rates start at £6 an hour. <a href=\"prices.html\">Click here</a>.</p>","why":"In a list of links this reads \"Click here\". Here where? For what?"}}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'prose'::public.block_type, NULL, 'Adding `target="_blank"` opens a link in a new tab. It is worth using sparingly, and when you do, you must add `rel="noopener noreferrer"`.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<a href="https://www.example.org/report"
   target="_blank"
   rel="noopener noreferrer">
  The 2026 cycling report (opens in a new tab)
</a>', 'html', NULL, '{"annotations":[{"line":"1","text":"A normal link to an external site."},{"line":"2","text":"`target=\"_blank\"` opens it in a new browser tab."},{"line":"3","text":"`noopener` stops the new page from getting a reference back to your page, which older browsers allowed it to use to redirect your tab somewhere malicious. `noreferrer` additionally stops your page''s address being sent to the destination."},{"line":"4","text":"Saying \"opens in a new tab\" in the visible text is not a technicality — an unexpected new tab is disorienting, and the Back button no longer works as expected."}]}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'callout'::public.block_type, 'Modern browsers already imply noopener', 'Every current browser treats `target="_blank"` as if `noopener` were set. Writing it explicitly costs nothing, documents the intent, and protects users on older browsers — so it remains the professional default.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'progressive_detail'::public.block_type, 'When should a link open in a new tab at all?', 'The honest answer is: rarely. Taking control of the user''s window away from them is a decision they did not make, and it breaks the Back button, which is the most-used control in any browser. The defensible cases are narrow — a reference the user needs while completing a form, or a link that would lose unsaved work. When in doubt, let the link open normally; anyone who wants a new tab can middle-click or use their browser''s menu.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'interactive_demo'::public.block_type, 'Link text, heard on its own', 'Screen-reader users often pull up a list of links. This is what each version sounds like there.',
       NULL, NULL, NULL, '{"variants":[{"label":"Names the destination","code":"<h3>Sourdough workshop</h3>\n<p>Six hours, small groups.</p>\n<a href=\"sourdough.html\">Book the sourdough workshop</a>","note":"In a link list it reads \"Book the sourdough workshop\" — unambiguous with the page removed."},{"label":"Read more","code":"<h3>Sourdough workshop</h3>\n<p>Six hours, small groups.</p>\n<a href=\"sourdough.html\">Read more</a>","note":"Reads \"Read more\", identical to every other such link on the site. The list becomes useless."},{"label":"The bare URL","code":"<p>Details: <a href=\"https://example.org/workshops/sourdough.html\">https://example.org/workshops/sourdough.html</a></p>","note":"Announced character by character in some configurations. Long, unreadable, and it tells the reader nothing a sentence would not."}]}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<a href=\"…\">` creates a link; the content between the tags is what people see.","Link text must make sense read on its own, out of context.","`target=\"_blank\"` needs `rel=\"noopener noreferrer\"` and a visible warning.","Opening in a new tab takes control away from the user — do it rarely."],"nextUp":"Next: relative paths, the thing everyone gets wrong once."}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'links-guided', 1, 'guided'::public.exercise_kind, 'Rewrite three bad links',
       'All three links below use meaningless text. Rewrite the visible text so each makes sense on its own, keeping the destinations exactly as they are.', '<p>Our prices changed in April. <a href="prices.html">Click here</a>.</p>
<p>We publish a monthly newsletter. <a href="newsletter.html">Read more</a>.</p>
<p>Find us on Mill Lane. <a href="contact.html">Here</a>.</p>', '<p>Our prices changed in April. <a href="prices.html">See the new price list</a>.</p>
<p>We publish a monthly newsletter. <a href="newsletter.html">Read this month''s newsletter</a>.</p>
<p>Find us on Mill Lane. <a href="contact.html">Get directions and opening hours</a>.</p>', ARRAY['Ask yourself: if I read only the link text, would I know where it goes?', 'Describe the destination, not the action — "See the price list" rather than "Click here".', 'Keep each href exactly as it was; only the visible text changes.']::text[],
       35, 2,
       (select id from public.skills where slug = 'links'), false
from public.lessons l where l.slug = 'anchors-and-link-text'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'element_count'::public.requirement_kind, 'a', NULL,
       NULL, NULL, 3, 3,
       'All three links remain', NULL, 1, true, NULL
from public.exercises e where e.slug = 'links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'a[href="prices.html"]', 'href',
       'prices.html', NULL, NULL, NULL,
       'The prices link still points at prices.html', NULL, 1, true, NULL
from public.exercises e where e.slug = 'links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'accessible_name'::public.requirement_kind, 'a', NULL,
       NULL, NULL, NULL, NULL,
       'Every link has an accessible name', NULL, 1, true, NULL
from public.exercises e where e.slug = 'links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'text_content'::public.requirement_kind, 'a', NULL,
       'price', NULL, NULL, NULL,
       'The prices link describes its destination', 'Mention prices in the link text.', 1, true, NULL
from public.exercises e where e.slug = 'links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'element_absent'::public.requirement_kind, 'a[href="contact.html"]:not([href])', NULL,
       NULL, NULL, NULL, NULL,
       'Links keep their destinations', NULL, 1, true, NULL
from public.exercises e where e.slug = 'links-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'links-debug', 2, 'debug'::public.exercise_kind, 'An unsafe external link',
       'This external link opens in a new tab but is missing its `rel` attribute, and it does not warn the reader. Add `rel="noopener noreferrer"` and mention the new tab in the visible text.', '<p>
  Read <a href="https://www.example.org/report" target="_blank">the 2026 report</a>
  for the full figures.
</p>', '<p>
  Read
  <a href="https://www.example.org/report" target="_blank" rel="noopener noreferrer">
    the 2026 report (opens in a new tab)
  </a>
  for the full figures.
</p>', ARRAY['Add a rel attribute alongside target on the same opening tag.', 'Its value is the two keywords separated by a space: "noopener noreferrer".', 'Add "(opens in a new tab)" to the words inside the link.']::text[],
       35, 2,
       (select id from public.skills where slug = 'links'), false
from public.lessons l where l.slug = 'anchors-and-link-text'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'a[target="_blank"]', 'rel',
       NULL, NULL, NULL, NULL,
       'The external link has a rel attribute', NULL, 1, true, NULL
from public.exercises e where e.slug = 'links-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'attribute_matches'::public.requirement_kind, 'a[target="_blank"]', 'rel',
       'noopener', NULL, NULL, NULL,
       'The rel value includes noopener', NULL, 1, true, NULL
from public.exercises e where e.slug = 'links-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'text_content'::public.requirement_kind, 'a', NULL,
       'new tab', NULL, NULL, NULL,
       'The link text warns that it opens in a new tab', NULL, 1, true, NULL
from public.exercises e where e.slug = 'links-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'anchors-and-link-text'), NULL, 'q-link-text', 1, 'single'::public.question_kind,
        'Why must link text make sense out of context?', 'Screen-reader users can list every link on a page and jump between them. In that list the link text appears with nothing around it.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Screen-reader users navigate by a list of links with no surrounding text', true, NULL
from public.quiz_questions where slug = 'q-link-text';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Search engines refuse to index short link text', false, NULL
from public.quiz_questions where slug = 'q-link-text';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Browsers truncate long link text', false, NULL
from public.quiz_questions where slug = 'q-link-text';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'CSS cannot style links whose text is too short', false, NULL
from public.quiz_questions where slug = 'q-link-text';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'anchors-and-link-text'), NULL, 'q-noopener', 2, 'single'::public.question_kind,
        'What does `rel="noopener"` prevent?', 'It stops the newly opened page from holding a reference back to yours — a reference it could otherwise use to redirect your tab.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The new page getting a reference back to yours', true, NULL
from public.quiz_questions where slug = 'q-noopener';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The link being followed by search engines', false, NULL
from public.quiz_questions where slug = 'q-noopener';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The page being cached', false, NULL
from public.quiz_questions where slug = 'q-noopener';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Cookies being sent with the request', false, NULL
from public.quiz_questions where slug = 'q-noopener';
-- lesson: Relative paths, absolute URLs and fragments
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'relative-and-absolute-paths', 2, 'Relative paths, absolute URLs and fragments', 'The one topic worth slowing down for', 'Almost every "my image is broken" and "my link 404s" comes from a path. Half an hour here saves hours later.',
       ARRAY['Write a relative path from one file to another', 'Use `../` to move up a folder', 'Link to a section within a page using a fragment']::text[], 16, 40, (select id from public.skills where slug = 'links'), 0.7
from public.modules m where m.slug = 'links-and-paths'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Write correct relative paths between files in a project","Explain the difference between a relative path and an absolute URL","Link to a specific section of a page with a fragment identifier"]}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'visual'::public.block_type, NULL, 'A project folder, and the paths between the files in it.',
       NULL, NULL, 'file-paths', '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Relative path', 'A path starting from the file you are currently in. `about.html` means "a file called about.html, in the same folder as me".',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Absolute URL', 'A complete web address including the protocol: `https://www.example.org/about`. It works from anywhere, but only points at a live site.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'prose'::public.block_type, NULL, 'Given the folder shown above, here is every path you need. Read each one as an instruction starting from where you are now.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, 'Reading paths as instructions', NULL,
       'From index.html (at the top level):
  about.html               → the file next to me
  images/logo.svg          → go into images, then take logo.svg
  projects/first.html      → go into projects, then take first.html

From projects/first.html (one folder deep):
  ../index.html            → go up one folder, then take index.html
  ../images/logo.svg       → go up one folder, into images, then logo.svg
  second.html              → the file next to me, inside projects/', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'Two dots means "up one folder"', 'A single dot means "here" and is almost always optional — `./about.html` and `about.html` are the same thing. Two dots means "go up one level". You can chain them: `../../images/logo.svg` goes up twice.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'callout'::public.block_type, 'The leading slash trap', 'Writing `/images/logo.svg` with a leading slash means "start from the very top of the website", not "start from my folder". On a live server that is often what you want; but when you open a file directly from your computer it means the root of your hard drive, and the image will not load. While you are learning, prefer relative paths with no leading slash.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'worked_example'::public.block_type, 'Working out one path, step by step', 'The question: you are editing `projects/first.html` and you want to show `images/logo.svg`, which sits at the top level. Rather than guessing and refreshing, here is the reasoning — it is the same four steps every time, and it never fails.',
       NULL, NULL, NULL, '{"steps":[{"title":"Say where you are, out loud","code":"projects/first.html","reasoning":"You are *inside* the `projects` folder. Everything that follows is measured from there, not from the top of the project. This is the step people skip, and skipping it is why paths feel like guesswork."},{"title":"Say where the file is","code":"images/logo.svg","reasoning":"The image lives inside `images`, which sits at the top level — beside `projects`, not inside it. So the two folders are siblings, and you cannot reach one from inside the other by going further down."},{"title":"Climb out until you can see it","code":"../","reasoning":"One `../` takes you up from `projects` to the top level. From there `images` is visible. You needed exactly one, because you were exactly one folder deep — count the folders, do not guess the dots."},{"title":"Then walk down to the file","code":"<img src=\"../images/logo.svg\" alt=\"Company logo\">","reasoning":"Up one, into `images`, take `logo.svg`. Read it back as a sentence — \"go up one folder, into images, then logo.svg\" — and if the sentence is true, the path is right."}]}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'interactive_demo'::public.block_type, 'Same link, three ways', 'Each of these can be correct — it depends where you are.',
       NULL, NULL, NULL, '{"variants":[{"label":"Relative","code":"<a href=\"about.html\">About</a>","note":"Looks for about.html beside the current file. Works locally and on a server."},{"label":"Root-relative","code":"<a href=\"/about.html\">About</a>","note":"Always starts at the site root. Great on a server; usually broken when opening files directly."},{"label":"Absolute","code":"<a href=\"https://example.org/about.html\">About</a>","note":"Points at one specific live site. Use it for links to *other* sites, not your own pages."}]}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'prose'::public.block_type, NULL, 'A fragment link points at a specific place *within* a page. You give an element an `id`, then link to `#that-id`. Clicking it scrolls straight there.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<nav aria-label="On this page">
  <ul>
    <li><a href="#rates">Rates</a></li>
    <li><a href="#routes">Routes</a></li>
  </ul>
</nav>

<h2 id="rates">Rates</h2>
<p>From £6 an hour.</p>

<h2 id="routes">Routes</h2>
<p>Three waymarked loops from the door.</p>', 'html', NULL, '{"annotations":[{"line":"3","text":"`href=\"#rates\"` means \"the element on this page whose id is rates\"."},{"line":"8","text":"The matching `id=\"rates\"`. Ids must be unique on a page — two elements can never share one."},{"line":"1","text":"Giving the `<nav>` an `aria-label` distinguishes it from the site''s main navigation for screen-reader users. Level 8 covers this properly."}]}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'progressive_detail'::public.block_type, 'Linking to a section on another page', 'Combine a path with a fragment: `<a href="prices.html#day-rates">Day rates</a>` loads prices.html and jumps to the element with `id="day-rates"`. This works with relative paths and absolute URLs alike. The `#top` fragment, and an empty `href="#"`, both scroll to the top of the current page — though `href="#"` on a real link is usually a sign that something is missing.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'predict_check'::public.block_type, 'Predict, then check', 'Two headings have been given the same `id`, which is not allowed. Before you run it: does the link fail, jump to the first heading, or jump to the second?',
       '<h2 id="rates">Rates</h2>
<p>From £6 an hour.</p>

<h2 id="rates">Off-peak rates</h2>
<p>From £4 an hour after 4pm.</p>

<p><a href="#rates">Jump to rates</a></p>', 'html', NULL, '{"outcome":"It jumps to the *first* one, silently. Nothing warns you, and the second `id=\"rates\"` is simply unreachable — no link can ever reach it. Duplicate ids are one of the few HTML mistakes with no visible symptom at all, which is exactly why the checker in this course looks for them."}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 15, 'checklist'::public.block_type, 'Path rules to remember', NULL,
       NULL, NULL, NULL, '{"items":["No slash at the start = start from where I am","`../` = go up one folder","Leading `/` = start from the site root","`#name` = an element with `id=\"name\"` on this page","Folder and file names: lowercase, hyphens, no spaces"]}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 16, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Relative paths start from the current file; `../` moves up a folder.","A leading slash starts at the site root and usually breaks local file browsing.","Absolute URLs are for other people''s sites, not your own pages.","Fragment links (`#id`) jump to a specific element, whose id must be unique."],"nextUp":"Next: email, telephone and download links."}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'paths-guided', 1, 'guided'::public.exercise_kind, 'Write paths from a nested page',
       'You are editing `routes/valley.html`, one folder deep. Add three links: back to `index.html` at the top level, across to `routes/harbour.html` beside you, and to `prices.html` at the top level.', '<nav>
  <ul>
    <li><a href="">Home</a></li>
    <li><a href="">Harbour route</a></li>
    <li><a href="">Prices</a></li>
  </ul>
</nav>', '<nav>
  <ul>
    <li><a href="../index.html">Home</a></li>
    <li><a href="harbour.html">Harbour route</a></li>
    <li><a href="../prices.html">Prices</a></li>
  </ul>
</nav>', ARRAY['You are inside the routes folder, so anything at the top level needs ../ first.', 'harbour.html is in the same folder as you, so it needs no prefix at all.', 'Home becomes ../index.html and Prices becomes ../prices.html.']::text[],
       45, 3,
       (select id from public.skills where slug = 'links'), false
from public.lessons l where l.slug = 'relative-and-absolute-paths'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '../index.html', NULL, NULL, NULL,
       'The Home link goes up one folder to index.html', NULL, 1, true, NULL
from public.exercises e where e.slug = 'paths-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'a', 'href',
       'harbour.html', NULL, NULL, NULL,
       'The Harbour link points at the sibling file', NULL, 1, true, NULL
from public.exercises e where e.slug = 'paths-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '../prices.html', NULL, NULL, NULL,
       'The Prices link goes up one folder', NULL, 1, true, NULL
from public.exercises e where e.slug = 'paths-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'element_count'::public.requirement_kind, 'nav a', NULL,
       NULL, NULL, 3, 3,
       'All three links are present', NULL, 1, true, NULL
from public.exercises e where e.slug = 'paths-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'fragments-challenge', 2, 'challenge'::public.exercise_kind, 'Build an on-page contents list',
       'Write a page with three `<h2>` sections, each with its own `id`, and a `<nav>` at the top containing a list of three fragment links that jump to them.', '', '<nav aria-label="On this page">
  <ul>
    <li><a href="#rates">Rates</a></li>
    <li><a href="#routes">Routes</a></li>
    <li><a href="#opening-hours">Opening hours</a></li>
  </ul>
</nav>

<h2 id="rates">Rates</h2>
<p>From £6 an hour, minimum two hours.</p>

<h2 id="routes">Routes</h2>
<p>Three waymarked loops start at our door.</p>

<h2 id="opening-hours">Opening hours</h2>
<p>Open 8am to 6pm, Tuesday to Sunday.</p>', ARRAY['Give each <h2> an id, using lowercase words joined by hyphens.', 'Each link in the nav is href="#that-id".', 'The ids must all be different from each other.']::text[],
       45, 3,
       (select id from public.skills where slug = 'links'), false
from public.lessons l where l.slug = 'relative-and-absolute-paths'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'element_count'::public.requirement_kind, 'h2[id]', NULL,
       NULL, NULL, 3, 3,
       'Three sections, each with an id', NULL, 1, true, NULL
from public.exercises e where e.slug = 'fragments-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'element_count'::public.requirement_kind, 'nav a[href^="#"]', NULL,
       NULL, NULL, 3, 3,
       'Three fragment links in the nav', NULL, 1, true, NULL
from public.exercises e where e.slug = 'fragments-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id is unique', NULL, 1, true, NULL
from public.exercises e where e.slug = 'fragments-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'nesting'::public.requirement_kind, 'a', NULL,
       NULL, 'nav', 1, NULL,
       'The links are inside the nav', NULL, 1, true, NULL
from public.exercises e where e.slug = 'fragments-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'text_not_empty'::public.requirement_kind, 'h2', NULL,
       NULL, NULL, NULL, NULL,
       'Every section heading has text', NULL, 1, true, NULL
from public.exercises e where e.slug = 'fragments-challenge';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'paths-debug', 3, 'debug'::public.exercise_kind, 'Four broken paths',
       'You are editing `index.html` at the top level of a site whose images live in an `images/` folder and whose route pages live in `routes/`. Every path below is wrong. Fix all four.', '<a href="../about.html">About</a>
<a href="/routes/valley.html">The valley route</a>
<img src="logo.svg" alt="Riverside Cycle Hire">
<a href="#Prices">Prices</a>
<h2 id="prices">Prices</h2>', '<a href="about.html">About</a>
<a href="routes/valley.html">The valley route</a>
<img src="images/logo.svg" alt="Riverside Cycle Hire">
<a href="#prices">Prices</a>
<h2 id="prices">Prices</h2>', ARRAY['You are already at the top level, so ../ takes you above the site entirely.', 'A leading slash breaks when the page is opened as a local file — drop it.', 'The logo is inside the images folder, so the path needs that folder name.', 'Fragment links are case-sensitive: #Prices does not match id="prices".']::text[],
       55, 4,
       (select id from public.skills where slug = 'links'), false
from public.lessons l where l.slug = 'relative-and-absolute-paths'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'a', 'href',
       'about.html', NULL, NULL, NULL,
       'The About link is a simple relative path', NULL, 1, true, NULL
from public.exercises e where e.slug = 'paths-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'a', 'href',
       'routes/valley.html', NULL, NULL, NULL,
       'The route link has no leading slash', NULL, 1, true, NULL
from public.exercises e where e.slug = 'paths-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'img', 'src',
       'images/logo.svg', NULL, NULL, NULL,
       'The image path includes its folder', NULL, 1, true, NULL
from public.exercises e where e.slug = 'paths-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#prices', NULL, NULL, NULL,
       'The fragment link matches the id exactly, including case', NULL, 1, true, NULL
from public.exercises e where e.slug = 'paths-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'relative-and-absolute-paths'), NULL, 'q-dotdot', 1, 'single'::public.question_kind,
        'What does `../` mean at the start of a path?', 'It moves up one folder from where the current file lives.', (select id from public.skills where slug = 'links'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Go up one folder', true, NULL
from public.quiz_questions where slug = 'q-dotdot';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Go to the site root', false, NULL
from public.quiz_questions where slug = 'q-dotdot';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Stay in the current folder', false, NULL
from public.quiz_questions where slug = 'q-dotdot';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Go to the previous page', false, NULL
from public.quiz_questions where slug = 'q-dotdot';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'relative-and-absolute-paths'), NULL, 'q-leading-slash', 2, 'single'::public.question_kind,
        'Why can `/images/logo.svg` fail when you open a page from your own computer?', 'The leading slash means "the root", and with no server that root is your hard drive rather than your project folder.', (select id from public.skills where slug = 'links'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Browsers block absolute paths for security', false, NULL
from public.quiz_questions where slug = 'q-leading-slash';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The image needs an absolute URL', false, NULL
from public.quiz_questions where slug = 'q-leading-slash';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The leading slash points at the drive root, not the project folder', true, NULL
from public.quiz_questions where slug = 'q-leading-slash';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Local files cannot display SVG images', false, NULL
from public.quiz_questions where slug = 'q-leading-slash';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'relative-and-absolute-paths'), NULL, 'q-fragment-case', 3, 'single'::public.question_kind,
        'Does `href="#Prices"` reach an element with `id="prices"`?', 'No. Fragment identifiers and ids are case-sensitive, so they must match exactly.', (select id from public.skills where slug = 'links'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Yes — HTML ignores case in ids', false, NULL
from public.quiz_questions where slug = 'q-fragment-case';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Only in some browsers', false, NULL
from public.quiz_questions where slug = 'q-fragment-case';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only if the id is on a heading', false, NULL
from public.quiz_questions where slug = 'q-fragment-case';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'No — fragments are case-sensitive', true, NULL
from public.quiz_questions where slug = 'q-fragment-case';
-- lesson: Email, telephone and download links
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'special-links', 3, 'Email, telephone and download links', 'Links that do something other than load a page', 'Three link types that make a contact page genuinely useful, especially on a phone.',
       ARRAY['Create a link that opens an email client', 'Create a tap-to-call telephone link', 'Offer a file for download with a sensible filename']::text[], 10, 40, (select id from public.skills where slug = 'links'), 0.7
from public.modules m where m.slug = 'links-and-paths'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Write mailto: and tel: links correctly","Use the download attribute","Explain why the visible text should show the address, not hide it"]}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'The three special link types', NULL,
       '<a href="mailto:hello@example.org">hello@example.org</a>
<a href="tel:+441632960123">+44 1632 960123</a>
<a href="price-list.pdf" download="riverside-prices-2026.pdf">
  Download our price list (PDF, 240KB)
</a>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<a href="mailto:hello@example.org?subject=Bike%20hire%20enquiry">
  hello@example.org
</a>', 'html', NULL, '{"annotations":[{"line":"1","text":"`mailto:` followed by the address opens the visitor''s email program."},{"line":"1","text":"You can pre-fill a subject with `?subject=`. Spaces must be written as `%20` because a URL cannot contain a raw space."},{"line":"2","text":"Show the actual address as the link text. Someone without an email program configured can then still copy it, and it prints usefully."}]}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Telephone numbers: always international format', 'Write `tel:+441632960123` — a plus sign, the country code, then the number with no spaces or brackets. The visible text can be formatted for humans however you like. A number without a country code fails for anyone calling from abroad.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'prose'::public.block_type, NULL, 'The `download` attribute tells the browser to save a file rather than trying to display it, and its value becomes the suggested filename. This matters: a server-generated file called `doc_38271.pdf` becomes `riverside-prices-2026.pdf` on the visitor''s computer.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Tell people what they are about to download', 'Include the file type and rough size in the link text: "Download our price list (PDF, 240KB)". People on limited data plans, slow connections or metered mobile need that information *before* they tap, not after.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'progressive_detail'::public.block_type, 'Does the download attribute always work?', 'It applies only to same-origin files — you cannot force a download of a file hosted on someone else''s domain, for good security reasons. If the file is on your own site it works everywhere current. If the browser ignores it, the link still works; it just opens the file instead of saving it, which is a perfectly acceptable fallback.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'Three protocols, three behaviours', 'The scheme at the start of the href decides what happens on click.',
       NULL, NULL, NULL, '{"variants":[{"label":"Email","code":"<a href=\"mailto:hello@example.org?subject=Workshop%20booking\">Email the bakery</a>","note":"Opens the visitor''s mail client with the address, and here the subject, already filled in. Note the encoded space."},{"label":"Telephone","code":"<a href=\"tel:+441632960123\">Call 01632 960123</a>","note":"Dials on a phone and is often ignored on a desktop — so the readable number belongs in the link text, not only in the href."},{"label":"Download","code":"<a href=\"/menu.pdf\" download=\"riverside-menu.pdf\">Download the menu (PDF, 240KB)</a>","note":"Saves rather than navigates, under the name you supply. Telling the reader the format and size before they click is basic courtesy."}]}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`mailto:` opens an email client; show the real address as the link text.","`tel:` should always use full international format with a `+`.","`download=\"filename\"` saves the file and suggests a better name.","Always state the file type and size in the link text."],"nextUp":"Next: assembling links into navigation."}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'special-links-guided', 1, 'guided'::public.exercise_kind, 'Build a contact block',
       'Create three links: an email link to `hello@example.org` showing the address as its text, a telephone link to `+441632960123`, and a download link to `price-list.pdf` that saves as `riverside-prices-2026.pdf` and states the file type in its text.', '<h2>Contact us</h2>
<ul>
  <li></li>
  <li></li>
  <li></li>
</ul>', '<h2>Contact us</h2>
<ul>
  <li><a href="mailto:hello@example.org">hello@example.org</a></li>
  <li><a href="tel:+441632960123">+44 1632 960123</a></li>
  <li>
    <a href="price-list.pdf" download="riverside-prices-2026.pdf">
      Download our price list (PDF, 240KB)
    </a>
  </li>
</ul>', ARRAY['The email href starts with mailto: and then the address, with no space.', 'The telephone href starts with tel:+44 and continues with no spaces or brackets.', 'The download attribute takes the filename you want the visitor to receive.']::text[],
       40, 2,
       (select id from public.skills where slug = 'links'), false
from public.lessons l where l.slug = 'special-links'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'attribute_matches'::public.requirement_kind, 'a', 'href',
       '^mailto:', NULL, NULL, NULL,
       'There is a mailto link', NULL, 1, true, NULL
from public.exercises e where e.slug = 'special-links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'attribute_matches'::public.requirement_kind, 'a', 'href',
       '^tel:\+', NULL, NULL, NULL,
       'There is a tel link in international format', NULL, 1, true, NULL
from public.exercises e where e.slug = 'special-links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'a[download]', 'download',
       NULL, NULL, NULL, NULL,
       'The download link has a download attribute', NULL, 1, true, NULL
from public.exercises e where e.slug = 'special-links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'text_content'::public.requirement_kind, 'a[download]', NULL,
       'PDF', NULL, NULL, NULL,
       'The download link states the file type', NULL, 1, true, NULL
from public.exercises e where e.slug = 'special-links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'element_count'::public.requirement_kind, 'li a', NULL,
       NULL, NULL, 3, 3,
       'All three links are inside list items', NULL, 1, true, NULL
from public.exercises e where e.slug = 'special-links-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'special-links'), NULL, 'q-tel-format', 1, 'single'::public.question_kind,
        'Which `tel:` value is correct?', 'International format with a leading plus and country code, and no spaces or punctuation inside the value.', (select id from public.skills where slug = 'links'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'tel:01632 960123', false, NULL
from public.quiz_questions where slug = 'q-tel-format';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'tel:(01632) 960-123', false, NULL
from public.quiz_questions where slug = 'q-tel-format';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'tel:0044 1632 960123', false, NULL
from public.quiz_questions where slug = 'q-tel-format';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'tel:+441632960123', true, NULL
from public.quiz_questions where slug = 'q-tel-format';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'special-links'), NULL, 'q-download-attr', 2, 'single'::public.question_kind,
        'What does the `download` attribute do?', 'It asks the browser to save the file rather than display it, and its value suggests the filename to save it under.', (select id from public.skills where slug = 'links'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Counts how many times the file is downloaded', false, NULL
from public.quiz_questions where slug = 'q-download-attr';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Restricts the download to signed-in visitors', false, NULL
from public.quiz_questions where slug = 'q-download-attr';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Saves the file, using its value as the suggested filename', true, NULL
from public.quiz_questions where slug = 'q-download-attr';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Compresses the file before sending it', false, NULL
from public.quiz_questions where slug = 'q-download-attr';
-- module: Navigation and multi-page sites
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'site-navigation', 2, 'Navigation and multi-page sites', 'Menus, breadcrumbs, skip links and the folder structure that keeps a growing site sane.',
       55, true
from public.levels l where l.slug = 'navigation-architect'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'site-navigation' and p.slug = 'links-and-paths';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.7
from public.modules m, public.skills s
where m.slug = 'site-navigation' and s.slug = 'links';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'site-navigation' and s.slug = 'navigation';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'site-navigation' and s.slug = 'multi-page';
-- lesson: Navigation menus, breadcrumbs and skip links
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'navigation-menus', 1, 'Navigation menus, breadcrumbs and skip links', 'Three patterns every professional site uses', 'A menu is a list of links inside a `<nav>`. Getting the details right makes it work for everyone.',
       ARRAY['Build a navigation menu as a list inside a nav element', 'Mark the current page so visitors know where they are', 'Add a skip link for keyboard users']::text[], 16, 40, (select id from public.skills where slug = 'navigation'), 0.7
from public.modules m where m.slug = 'site-navigation'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Build a navigation menu with correct semantics","Indicate the current page with aria-current","Add a skip link and explain who it helps"]}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'A navigation menu is a list of links. Marking it up as an actual list is not decoration — it lets a screen reader announce "navigation, list of five items", so the user knows how much there is before they start.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<nav aria-label="Main">
  <ul>
    <li><a href="index.html">Home</a></li>
    <li><a href="about.html">About</a></li>
    <li><a href="routes/index.html" aria-current="page">Routes</a></li>
    <li><a href="prices.html">Prices</a></li>
    <li><a href="contact.html">Contact</a></li>
  </ul>
</nav>', 'html', NULL, '{"annotations":[{"line":"1","text":"`<nav>` marks this as a navigation landmark. Screen-reader users can jump straight to it."},{"line":"1","text":"`aria-label=\"Main\"` names it. A page often has more than one nav — main, footer, on-this-page — and the label tells them apart."},{"line":"2-8","text":"A plain unordered list. The order is not meaningful, so `<ul>` rather than `<ol>`."},{"line":"5","text":"`aria-current=\"page\"` marks the link to the page you are already on. Screen readers announce it as \"current page\", and it can be styled differently for everyone else."}]}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Keep navigation identical on every page', 'Same links, same order, same place. Consistency is a WCAG requirement, and it is also just good sense — people learn where things are, and moving them costs them time on every visit.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'prose'::public.block_type, NULL, 'A breadcrumb trail shows where the current page sits in the site. It is an ordered list, because the order genuinely matters.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, 'A breadcrumb trail', NULL,
       '<nav aria-label="Breadcrumb">
  <ol>
    <li><a href="../index.html">Home</a></li>
    <li><a href="index.html">Routes</a></li>
    <li><a href="valley.html" aria-current="page">The valley route</a></li>
  </ol>
</nav>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'term'::public.block_type, 'Skip link', 'A link at the very top of the page that jumps past the navigation, straight to the main content.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'prose'::public.block_type, NULL, 'Someone using only a keyboard presses Tab to move between links. Without a skip link, they must Tab through every navigation item on every page before reaching the content. On a site with a twelve-item menu, that is twelve presses each time.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'code_example'::public.block_type, 'A skip link — the first focusable thing on the page', NULL,
       '<body>
  <a class="skip-link" href="#main">Skip to main content</a>

  <nav aria-label="Main"><!-- … --></nav>

  <main id="main">
    <h1>The valley route</h1>
  </main>
</body>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'callout'::public.block_type, 'A skip link must be visible when focused', 'The convention is to position it off-screen until it receives keyboard focus, then bring it into view. A skip link that stays invisible even when focused is worse than none — the user tabs into something they cannot see. The platform stylesheet in your previews handles this for you.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'Why is the skip link first?', 'Keyboard focus follows source order. For the link to be reachable before the navigation, it must appear before the navigation in the HTML — being visually positioned first is not enough. This is the clearest everyday example of a rule that runs through the whole course: the order of your markup is the order real users experience.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'checklist'::public.block_type, 'Every page in your site should have', NULL,
       NULL, NULL, NULL, '{"items":["A skip link as the first focusable element","The same `<nav>` in the same place, with the same links","`aria-current=\"page\"` on the link to the current page","A breadcrumb trail on pages more than one level deep","A `<main>` element with an `id` the skip link targets"]}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'interactive_demo'::public.block_type, 'Marking where the visitor already is', 'Three navs. Only one is useful to somebody who cannot see the styling.',
       NULL, NULL, NULL, '{"variants":[{"label":"aria-current","code":"<nav aria-label=\"Main\">\n  <ul>\n    <li><a href=\"index.html\">Home</a></li>\n    <li><a href=\"menu.html\" aria-current=\"page\">Menu</a></li>\n  </ul>\n</nav>","note":"Announced as \"Menu, current page\". The information reaches everybody."},{"label":"A class only","code":"<nav aria-label=\"Main\">\n  <ul>\n    <li><a href=\"index.html\">Home</a></li>\n    <li><a href=\"menu.html\" class=\"active\">Menu</a></li>\n  </ul>\n</nav>","note":"Visually obvious, completely silent. A class name means nothing to assistive technology."},{"label":"Two unlabelled navs","code":"<nav>\n  <ul><li><a href=\"index.html\">Home</a></li></ul>\n</nav>\n<nav>\n  <ul><li><a href=\"terms.html\">Terms</a></li></ul>\n</nav>","note":"Both announce as just \"navigation\", so a user listing the landmarks cannot tell the main menu from the footer links."}]}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Navigation is a list of links inside `<nav>`; name each nav with `aria-label`.","`aria-current=\"page\"` marks where the visitor already is.","Breadcrumbs are an ordered list, because the order is the meaning.","A skip link must be the first focusable element and must become visible on focus."],"nextUp":"Next: organising the files themselves."}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'nav-guided', 1, 'guided'::public.exercise_kind, 'Build a main navigation',
       'Build a `<nav>` labelled "Main" containing a list of four links: Home, About, Prices and Contact. Mark the Prices link as the current page.', '<nav>

</nav>', '<nav aria-label="Main">
  <ul>
    <li><a href="index.html">Home</a></li>
    <li><a href="about.html">About</a></li>
    <li><a href="prices.html" aria-current="page">Prices</a></li>
    <li><a href="contact.html">Contact</a></li>
  </ul>
</nav>', ARRAY['Add aria-label="Main" to the nav element itself.', 'Inside it, build a <ul> with one <li> per link.', 'On the Prices link only, add aria-current="page".']::text[],
       40, 2,
       (select id from public.skills where slug = 'navigation'), false
from public.lessons l where l.slug = 'navigation-menus'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav has an aria-label naming it', NULL, 1, true, NULL
from public.exercises e where e.slug = 'nav-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'nesting'::public.requirement_kind, 'ul', NULL,
       NULL, 'nav', 1, NULL,
       'The links are in a list inside the nav', NULL, 1, true, NULL
from public.exercises e where e.slug = 'nav-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 4, 4,
       'There are four links', NULL, 1, true, NULL
from public.exercises e where e.slug = 'nav-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page link is marked with aria-current="page"', NULL, 1, true, NULL
from public.exercises e where e.slug = 'nav-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'accessible_name'::public.requirement_kind, 'nav a', NULL,
       NULL, NULL, NULL, NULL,
       'Every link has visible text', NULL, 1, true, NULL
from public.exercises e where e.slug = 'nav-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'skip-link-challenge', 2, 'challenge'::public.exercise_kind, 'A page with a skip link and breadcrumbs',
       'Build a page body containing, in this order: a skip link targeting `#main`, a main navigation, a breadcrumb nav, and a `<main id="main">` with an `<h1>` inside it.', '', '<a class="skip-link" href="#main">Skip to main content</a>

<nav aria-label="Main">
  <ul>
    <li><a href="../index.html">Home</a></li>
    <li><a href="index.html">Routes</a></li>
  </ul>
</nav>

<nav aria-label="Breadcrumb">
  <ol>
    <li><a href="../index.html">Home</a></li>
    <li><a href="index.html">Routes</a></li>
    <li><a href="valley.html" aria-current="page">The valley route</a></li>
  </ol>
</nav>

<main id="main">
  <h1>The valley route</h1>
  <p>Twenty-four miles, mostly flat, one long climb near the reservoir.</p>
</main>', ARRAY['The skip link comes first in the source — before any nav.', 'Two <nav> elements need two different aria-label values so they can be told apart.', 'The <main> needs id="main" for the skip link to reach it.']::text[],
       55, 4,
       (select id from public.skills where slug = 'navigation'), false
from public.lessons l where l.slug = 'navigation-menus'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'There is a skip link pointing at #main', NULL, 1, true, NULL
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'element_count'::public.requirement_kind, 'nav', NULL,
       NULL, NULL, 2, 2,
       'There are two nav elements', NULL, 1, true, NULL
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'Both navs are labelled', NULL, 1, true, NULL
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'main', 'id',
       'main', NULL, NULL, NULL,
       'The main element has id="main"', NULL, 1, true, NULL
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside the main element', NULL, 1, true, NULL
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'element_present'::public.requirement_kind, 'nav ol', NULL,
       NULL, NULL, NULL, NULL,
       'The breadcrumb uses an ordered list', NULL, 1, true, NULL
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 7, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id is unique', NULL, 1, true, NULL
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'nav-debug', 3, 'debug'::public.exercise_kind, 'Navigation that fails a keyboard user',
       'This navigation has four problems: the links are not in a list, the nav has no label, no link is marked as current, and the skip link points at an id that does not exist. Fix all four.', '<a href="#content">Skip to main content</a>
<nav>
  <a href="index.html">Home</a>
  <a href="about.html">About</a>
  <a href="contact.html">Contact</a>
</nav>
<main id="main">
  <h1>About us</h1>
</main>', '<a href="#main">Skip to main content</a>
<nav aria-label="Main">
  <ul>
    <li><a href="index.html">Home</a></li>
    <li><a href="about.html" aria-current="page">About</a></li>
    <li><a href="contact.html">Contact</a></li>
  </ul>
</nav>
<main id="main">
  <h1>About us</h1>
</main>', ARRAY['The skip link must match the id on <main>, which is "main" not "content".', 'Wrap the three links in a <ul>, one <li> each.', 'Add aria-label="Main" to the nav.', 'The h1 says "About us", so the About link is the current page.']::text[],
       50, 3,
       (select id from public.skills where slug = 'navigation'), false
from public.lessons l where l.slug = 'navigation-menus'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'The skip link targets the id that actually exists', NULL, 1, true, NULL
from public.exercises e where e.slug = 'nav-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'nesting'::public.requirement_kind, 'ul', NULL,
       NULL, 'nav', 1, NULL,
       'The links are wrapped in a list', NULL, 1, true, NULL
from public.exercises e where e.slug = 'nav-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 3, 3,
       'All three links are list items', NULL, 1, true, NULL
from public.exercises e where e.slug = 'nav-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav is labelled', NULL, 1, true, NULL
from public.exercises e where e.slug = 'nav-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page is marked', NULL, 1, true, NULL
from public.exercises e where e.slug = 'nav-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'navigation-menus'), NULL, 'q-nav-list', 1, 'single'::public.question_kind,
        'Why put navigation links inside a `<ul>`?', 'A screen reader announces the number of items, so the user knows how large the menu is before entering it.', (select id from public.skills where slug = 'navigation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'So screen readers can announce how many links there are', true, NULL
from public.quiz_questions where slug = 'q-nav-list';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Because links cannot appear directly inside <nav>', false, NULL
from public.quiz_questions where slug = 'q-nav-list';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'To make them display vertically', false, NULL
from public.quiz_questions where slug = 'q-nav-list';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Because search engines require it', false, NULL
from public.quiz_questions where slug = 'q-nav-list';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'navigation-menus'), NULL, 'q-skip-link-position', 2, 'single'::public.question_kind,
        'Where must a skip link appear in the HTML?', 'Keyboard focus follows source order, so the skip link must be the first focusable element in the document.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Inside the <nav> element', false, NULL
from public.quiz_questions where slug = 'q-skip-link-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'At the end of the page', false, NULL
from public.quiz_questions where slug = 'q-skip-link-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'As the first focusable element, before the navigation', true, NULL
from public.quiz_questions where slug = 'q-skip-link-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Anywhere, as long as CSS positions it at the top', false, NULL
from public.quiz_questions where slug = 'q-skip-link-position';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'navigation-menus'), NULL, 'q-aria-current', 3, 'single'::public.question_kind,
        'What does `aria-current="page"` do?', 'It marks the link that points at the page the user is already on, so assistive technology can announce it as the current page.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Disables the link', false, NULL
from public.quiz_questions where slug = 'q-aria-current';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Highlights the link in the browser', false, NULL
from public.quiz_questions where slug = 'q-aria-current';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Tells search engines which page is canonical', false, NULL
from public.quiz_questions where slug = 'q-aria-current';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Marks the link to the page the visitor is currently viewing', true, NULL
from public.quiz_questions where slug = 'q-aria-current';
-- lesson: Milestone: connect a website
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'multi-page-milestone', 2, 'Milestone: connect a website', 'Three pages, one navigation, no broken links', 'Build the navigation that will carry your capstone site for the rest of the course.',
       ARRAY['Plan a folder structure for a multi-page site', 'Build navigation that works from every page', 'Verify that no internal link is broken']::text[], 25, 40, (select id from public.skills where slug = 'multi-page'), 0.8
from public.modules m where m.slug = 'site-navigation'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Organise a project into sensible files and folders","Build a navigation block that works identically on every page","Check every internal link resolves"]}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'A website is a set of files that reference each other. Before writing any of them, decide where things go — changing your mind later means fixing every path.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'A structure that scales', NULL,
       'my-site/
├── index.html          the homepage
├── about.html
├── contact.html
├── prices.html
├── images/             every image, in one place
│   ├── logo.svg
│   └── workshop.jpg
└── routes/
    ├── index.html      the routes landing page
    ├── valley.html
    └── harbour.html', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'checklist'::public.block_type, 'Naming rules that save you pain', NULL,
       NULL, NULL, NULL, '{"items":["Lowercase only — some servers treat `About.html` and `about.html` as different files","Hyphens between words, never spaces — a space becomes `%20` in a URL","Descriptive names: `day-rates.html`, not `page2.html`","One folder per section, with its own `index.html`","All images in `images/`, all downloads in `files/`"]}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Spaces in filenames are a real bug source', 'A file called `price list.html` must be linked as `price%20list.html`. It works, but it is ugly, easy to get wrong, and breaks the moment someone types the name by hand. Use a hyphen.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'prose'::public.block_type, NULL, 'The navigation block itself is the same on every page — but the paths inside it are not. From `index.html` the About link is `about.html`; from `routes/valley.html` it is `../about.html`. This is exactly the kind of repetition that templating tools exist to remove, and Level 5 shows how professionals handle it.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'interactive_demo'::public.block_type, 'A nav that works across every page', 'The same markup on three pages, with one attribute moving.',
       NULL, NULL, NULL, '{"variants":[{"label":"On index.html","code":"<nav aria-label=\"Main\">\n  <ul>\n    <li><a href=\"index.html\" aria-current=\"page\">Home</a></li>\n    <li><a href=\"about.html\">About</a></li>\n  </ul>\n</nav>","note":"aria-current sits on Home. Everything else is identical to every other page."},{"label":"On about.html","code":"<nav aria-label=\"Main\">\n  <ul>\n    <li><a href=\"index.html\">Home</a></li>\n    <li><a href=\"about.html\" aria-current=\"page\">About</a></li>\n  </ul>\n</nav>","note":"The one attribute moves. This is the detail most often forgotten when copying a shell between pages."}]}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Decide your folder structure before you write the files.","Lowercase, hyphenated, descriptive filenames.","Navigation stays identical; only the paths change with depth.","Every internal link must resolve — check them all."],"nextUp":"Level 4 next: images, video and audio."}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'multipage-milestone-build', 1, 'challenge'::public.exercise_kind, 'Milestone: a connected page',
       'Build a complete `about.html` page for a site whose other pages are `index.html`, `prices.html` and `contact.html`, all at the top level. It needs the full document skeleton, a skip link, a labelled main navigation with all four links, `aria-current` on the About link, and a `<main>` containing an `<h1>` and two paragraphs — one of which contains a link to `contact.html`.', '', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About us — Riverside Cycle Hire</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>

    <nav aria-label="Main">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="about.html" aria-current="page">About</a></li>
        <li><a href="prices.html">Prices</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>

    <main id="main">
      <h1>About us</h1>
      <p>
        We have hired bikes from the same Mill Lane workshop since 1998, and
        every bike that leaves the shop has been serviced by our own mechanics.
      </p>
      <p>
        If you would like a route recommendation before you arrive,
        <a href="contact.html">send us a message</a> and we will reply the same day.
      </p>
    </main>
  </body>
</html>', ARRAY['Start with the full skeleton, including a title specific to this page.', 'The skip link is the very first thing inside <body>.', 'The nav needs aria-label, a <ul>, and four <li> items.', 'Mark the About link with aria-current="page" since this is the About page.']::text[],
       110, 4,
       (select id from public.skills where slug = 'multi-page'), false
from public.lessons l where l.slug = 'multi-page-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'A skip link targets #main', NULL, 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The navigation is labelled', NULL, 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 4, 4,
       'The nav contains four links', NULL, 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page is marked', NULL, 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 7, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main element', NULL, 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 8, 'attribute_value'::public.requirement_kind, 'main', 'id',
       'main', NULL, NULL, NULL,
       'The main element has the id the skip link targets', NULL, 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 9, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside main', NULL, 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 10, 'element_count'::public.requirement_kind, 'main p', NULL,
       NULL, NULL, 2, NULL,
       'At least two paragraphs of content', NULL, 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 11, 'nesting'::public.requirement_kind, 'a[href="contact.html"]', NULL,
       NULL, 'main p', 1, NULL,
       'A paragraph links to the contact page', NULL, 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 12, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 13, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true, NULL
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'navigation-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: add navigation to every page',
       'Add the same navigation block to your capstone site''s `index.html` and `about.html`, and create a third page. Every page needs the skip link, the identical nav, and `aria-current` pointing at itself. This nav will appear on every page you build from now on.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page title — your site</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>

    <nav aria-label="Main">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>

    <main id="main">
      <h1>Your page heading</h1>
      <p>Your content.</p>
    </main>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Prices — Riverside Cycle Hire</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <nav aria-label="Main">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="prices.html" aria-current="page">Prices</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>
    <main id="main">
      <h1>Prices</h1>
      <p>Hourly hire starts at £6, with a two-hour minimum.</p>
    </main>
  </body>
</html>', ARRAY['Copy the nav block exactly onto each page — consistency is the point.', 'On each page, move aria-current="page" to the link for that page.', 'Give every page its own <title>, not a shared one.']::text[],
       80, 3,
       (select id from public.skills where slug = 'multi-page'), false
from public.lessons l where l.slug = 'multi-page-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true, NULL
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'The skip link is present', NULL, 1, true, NULL
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav is labelled', NULL, 1, true, NULL
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 3, NULL,
       'The nav has at least three links', NULL, 1, true, NULL
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'This page is marked as current', NULL, 1, true, NULL
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is one main element', NULL, 1, true, NULL
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 7, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside main', NULL, 1, true, NULL
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 8, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true, NULL
from public.exercises e where e.slug = 'navigation-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'multi-page-milestone'), NULL, 'q-filenames', 1, 'single'::public.question_kind,
        'Why avoid spaces in filenames?', 'A space becomes `%20` in a URL. The link still works, but it is error-prone to type and read.', (select id from public.skills where slug = 'multi-page'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A space becomes %20 in the URL, which is easy to get wrong', true, NULL
from public.quiz_questions where slug = 'q-filenames';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Browsers refuse to load files with spaces', false, NULL
from public.quiz_questions where slug = 'q-filenames';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Spaces make files larger', false, NULL
from public.quiz_questions where slug = 'q-filenames';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'HTML forbids them', false, NULL
from public.quiz_questions where slug = 'q-filenames';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'multi-page-milestone'), NULL, 'q-nav-consistency', 2, 'single'::public.question_kind,
        'Why should navigation appear in the same place on every page?', 'Consistent navigation is a WCAG 2.2 requirement and reduces the effort of using the site for everyone, especially people with cognitive disabilities.', (select id from public.skills where slug = 'navigation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It makes the HTML file smaller', false, NULL
from public.quiz_questions where slug = 'q-nav-consistency';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Search engines penalise varied navigation', false, NULL
from public.quiz_questions where slug = 'q-nav-consistency';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'People learn where it is; moving it costs them effort on every page', true, NULL
from public.quiz_questions where slug = 'q-nav-consistency';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Browsers cache navigation only when it is identical', false, NULL
from public.quiz_questions where slug = 'q-nav-consistency';
-- Level 3 milestone: Navigation Architect questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q1', 1, 'single'::public.question_kind,
        'You are in `routes/valley.html`. How do you link to `index.html` at the top level?', '`../` moves up one folder, out of `routes/`, then `index.html` is beside you.', (select id from public.skills where slug = 'links'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'routes/index.html', false, NULL
from public.quiz_questions where slug = 'a3-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '../index.html', true, NULL
from public.quiz_questions where slug = 'a3-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'index.html', false, NULL
from public.quiz_questions where slug = 'a3-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '/index.html', false, NULL
from public.quiz_questions where slug = 'a3-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q2', 2, 'single'::public.question_kind,
        'Which link text is best?', 'It describes its destination and makes sense read on its own.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Download our 2026 price list (PDF)', true, NULL
from public.quiz_questions where slug = 'a3-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Click here', false, NULL
from public.quiz_questions where slug = 'a3-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Read more', false, NULL
from public.quiz_questions where slug = 'a3-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'This link', false, NULL
from public.quiz_questions where slug = 'a3-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q3', 3, 'single'::public.question_kind,
        'What must accompany `target="_blank"`?', '`rel="noopener noreferrer"` protects the user, and the visible text should say a new tab will open.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A download attribute', false, NULL
from public.quiz_questions where slug = 'a3-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'An absolute URL', false, NULL
from public.quiz_questions where slug = 'a3-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'aria-current="page"', false, NULL
from public.quiz_questions where slug = 'a3-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'rel="noopener noreferrer" and a visible warning', true, NULL
from public.quiz_questions where slug = 'a3-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q4', 4, 'single'::public.question_kind,
        'What does `href="#prices"` do?', 'It jumps to the element on the current page whose id is `prices`.', (select id from public.skills where slug = 'links'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Adds a hash to the URL with no effect', false, NULL
from public.quiz_questions where slug = 'a3-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Filters the page to show only prices', false, NULL
from public.quiz_questions where slug = 'a3-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Jumps to the element with id="prices" on this page', true, NULL
from public.quiz_questions where slug = 'a3-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Loads a file called prices', false, NULL
from public.quiz_questions where slug = 'a3-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q5', 5, 'single'::public.question_kind,
        'Which is correctly formatted for a phone link?', 'International format: a plus, the country code, then digits with no separators.', (select id from public.skills where slug = 'links'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'href="call:01632960123"', false, NULL
from public.quiz_questions where slug = 'a3-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'href="tel:+441632960123"', true, NULL
from public.quiz_questions where slug = 'a3-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'href="tel:01632 960123"', false, NULL
from public.quiz_questions where slug = 'a3-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'href="phone:+441632960123"', false, NULL
from public.quiz_questions where slug = 'a3-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q6', 6, 'single'::public.question_kind,
        'Which element should a breadcrumb trail use for its list?', 'The order of a breadcrumb is meaningful, so it is an ordered list.', (select id from public.skills where slug = 'navigation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<ol>', true, NULL
from public.quiz_questions where slug = 'a3-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<ul>', false, NULL
from public.quiz_questions where slug = 'a3-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<dl>', false, NULL
from public.quiz_questions where slug = 'a3-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<menu>', false, NULL
from public.quiz_questions where slug = 'a3-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q7', 7, 'single'::public.question_kind,
        'A page has two `<nav>` elements. How do you distinguish them?', 'Give each an `aria-label`, so a screen reader announces "Main navigation" and "Breadcrumb navigation" rather than two identical landmarks.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Give each an id', false, NULL
from public.quiz_questions where slug = 'a3-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nest one inside the other', false, NULL
from public.quiz_questions where slug = 'a3-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Use <nav> once and <div> for the other', false, NULL
from public.quiz_questions where slug = 'a3-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Give each an aria-label', true, NULL
from public.quiz_questions where slug = 'a3-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q8', 8, 'single'::public.question_kind,
        'Who does a skip link help most?', 'Keyboard-only users, including many screen-reader users, who would otherwise tab through the whole menu on every page.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Search engine crawlers', false, NULL
from public.quiz_questions where slug = 'a3-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Users with colour blindness', false, NULL
from public.quiz_questions where slug = 'a3-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Keyboard-only users who would otherwise tab through the whole menu', true, NULL
from public.quiz_questions where slug = 'a3-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Mobile users on slow connections', false, NULL
from public.quiz_questions where slug = 'a3-q8';
-- --------------------------------------------------------------------------
-- HTML Hero — Level 4: Media Specialist
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'media-specialist', 4, 'Media Specialist', 'Images, video and audio that are fast, accessible and never broken',
       'Media is where beginner sites most often fall down: missing alt text, enormous files, autoplaying video, no captions. This level covers modern media properly, using the free media library built into HTML Hero.', 'You can build a media-rich page with responsive images, an accessible video with captions, and correct fallback content.', 'amber'
from public.courses c where c.slug = 'html-hero'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-4-milestone', 'milestone'::public.assessment_kind, 'Level 4 milestone: Media Specialist', 'Nine questions on images, responsive images, video, audio and embeds. Pass mark 75%.',
       0.75, 180, 4
from public.levels l where l.slug = 'media-specialist'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Images and alternative text
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'images-and-alt-text', 1, 'Images and alternative text', 'The img element, the difference between informative and decorative images, and how to write alt text that actually carries the meaning.',
       45, false
from public.levels l where l.slug = 'media-specialist'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'images-and-alt-text' and p.slug = 'site-navigation';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'images-and-alt-text' and s.slug = 'images';

commit;
