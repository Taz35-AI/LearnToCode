-- HTML Hero — course seed, part 5 of 8
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
-- Level 6: Data and Forms Builder
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
select id, 13, 'summary'::public.block_type, 'Lesson summary', NULL,
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
select id, 13, 'summary'::public.block_type, 'Lesson summary', NULL,
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
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
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
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'search', false, NULL
from public.quiz_questions where slug = 'a6-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-6-milestone'), 'a6-q6', 6, 'single'::public.question_kind,
        'Which form method should be used for a search box?', 'GET, so results appear in the URL and can be bookmarked and shared. It only reads data.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'POST', false, NULL
from public.quiz_questions where slug = 'a6-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Either, but POST is safer', false, NULL
from public.quiz_questions where slug = 'a6-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It depends on the number of fields', false, NULL
from public.quiz_questions where slug = 'a6-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'GET', true, NULL
from public.quiz_questions where slug = 'a6-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-6-milestone'), 'a6-q7', 7, 'single'::public.question_kind,
        'What must accompany a `pattern` attribute?', 'A visible, plain-language description of the required format, connected with `aria-describedby`.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A title attribute only', false, NULL
from public.quiz_questions where slug = 'a6-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nothing — the browser explains it', false, NULL
from public.quiz_questions where slug = 'a6-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A visible hint connected with aria-describedby', true, NULL
from public.quiz_questions where slug = 'a6-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A matching maxlength', false, NULL
from public.quiz_questions where slug = 'a6-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-6-milestone'), 'a6-q8', 8, 'single'::public.question_kind,
        'What does `<legend>` do?', 'It labels the whole `<fieldset>` group, and screen readers announce it before each control in the group.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Describes a validation error', false, NULL
from public.quiz_questions where slug = 'a6-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Labels the group of controls in a fieldset', true, NULL
from public.quiz_questions where slug = 'a6-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Labels a single input', false, NULL
from public.quiz_questions where slug = 'a6-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Provides a table caption', false, NULL
from public.quiz_questions where slug = 'a6-q8';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-6-milestone'), 'a6-q9', 9, 'single'::public.question_kind,
        'You add a "Show password" button inside a form and omit `type`. What happens on click?', 'It submits the form, because `submit` is the default button type.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The form is submitted', true, NULL
from public.quiz_questions where slug = 'a6-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nothing happens', false, NULL
from public.quiz_questions where slug = 'a6-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The form is reset', false, NULL
from public.quiz_questions where slug = 'a6-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The password is revealed', false, NULL
from public.quiz_questions where slug = 'a6-q9';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-6-milestone'), 'a6-q10', 10, 'single'::public.question_kind,
        'Why is `<input type="hidden">` unsuitable for secrets?', 'Its value is in the page source, visible to anyone who looks.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Its value is visible in the page source', true, NULL
from public.quiz_questions where slug = 'a6-q10';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It is not submitted with the form', false, NULL
from public.quiz_questions where slug = 'a6-q10';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Screen readers announce it aloud', false, NULL
from public.quiz_questions where slug = 'a6-q10';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Browsers strip it before sending', false, NULL
from public.quiz_questions where slug = 'a6-q10';
-- --------------------------------------------------------------------------
-- Level 7: Native Interaction Expert
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'native-interaction', 7, 'Native Interaction Expert', 'Interactive features that need no JavaScript at all',
       'Modern HTML can build accordions, modal dialogs, popovers, progress displays and autocomplete lists on its own — with keyboard support and screen-reader semantics already correct. Reaching for JavaScript first means rebuilding all of that by hand, usually worse.', 'You can build FAQ accordions, dialogs, progress displays and enhanced form controls using HTML alone.', 'cyan'
from public.courses c where c.slug = 'html-hero'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-7-milestone', 'milestone'::public.assessment_kind, 'Level 7 milestone: Native Interaction Expert', 'Seven questions on native interactive elements and progressive enhancement. Pass mark 75%.',
       0.75, 170, 7
from public.levels l where l.slug = 'native-interaction'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Disclosure, dialogs and popovers
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'disclosure-and-dialog', 1, 'Disclosure, dialogs and popovers', 'details, summary, dialog and the popover attribute — the four features that replace most simple JavaScript widgets.',
       45, false
from public.levels l where l.slug = 'native-interaction'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'disclosure-and-dialog' and p.slug = 'form-foundations';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'disclosure-and-dialog' and s.slug = 'native-interaction';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'disclosure-and-dialog' and s.slug = 'progressive-enhancement';
-- lesson: Details and summary
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'details-and-summary', 1, 'Details and summary', 'An accordion in two elements', 'The show/hide pattern, built in — with keyboard support, correct announcements and find-in-page support you would otherwise have to write yourself.',
       ARRAY['Build a disclosure widget with details and summary', 'Build an accordion where only one panel opens at a time', 'Explain what you get free that JavaScript would have to reimplement']::text[], 13, 40, (select id from public.skills where slug = 'native-interaction'), 0.7
from public.modules m where m.slug = 'disclosure-and-dialog'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Build a working FAQ accordion with no JavaScript","Use the open and name attributes","List the behaviours native disclosure gives you for free"]}'::jsonb
from public.lessons where slug = 'details-and-summary';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<details>
  <summary>Do I need to book in advance?</summary>
  <p>
    Not on weekdays. At weekends we recommend booking at least a day ahead,
    especially for tandems and child seats.
  </p>
</details>', 'html', NULL, '{"annotations":[{"line":"1","text":"`<details>` is the container. It is closed by default; add the `open` attribute to start expanded."},{"line":"2","text":"`<summary>` is the always-visible part that toggles it. It must be the first child, and there is exactly one per details."},{"line":"3-6","text":"Everything after the summary is the panel, hidden until the widget is opened."}]}'::jsonb
from public.lessons where slug = 'details-and-summary';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'callout'::public.block_type, 'What you get without writing a line of JavaScript', 'Click and keyboard activation with Enter and Space. Correct focus behaviour. A screen-reader announcement of "collapsed" or "expanded" that updates as it changes. Browser find-in-page that opens the panel when the match is inside it. Printing that expands the content. Reimplementing all of that correctly takes a surprising amount of code, and most hand-rolled accordions miss at least two of them.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'details-and-summary';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'prose'::public.block_type, NULL, 'Give several `<details>` elements the same `name` and they behave as an exclusive accordion: opening one closes the others, exactly like a radio group.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'details-and-summary';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'An exclusive accordion', NULL,
       '<h2>Frequently asked questions</h2>

<details name="faq" open>
  <summary>Do I need to book in advance?</summary>
  <p>Not on weekdays. At weekends, please book a day ahead.</p>
</details>

<details name="faq">
  <summary>Are helmets included?</summary>
  <p>Yes — a helmet and a lock come with every hire.</p>
</details>

<details name="faq">
  <summary>What if it rains?</summary>
  <p>Cancel up to two hours before and we will refund in full.</p>
</details>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'details-and-summary';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Do not put a heading inside the summary and a heading outside it too', 'A common pattern is `<summary><h3>Question</h3></summary>`. It is valid, and it can be useful for a page where the questions should appear in the heading outline — but doubling up, with an `<h3>` both inside and above the summary, produces a confusing outline. Pick one.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'details-and-summary';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'interactive_demo'::public.block_type, 'Disclosure states', 'The same widget, opened and closed.',
       NULL, NULL, NULL, '{"variants":[{"label":"Closed by default","code":"<details>\n  <summary>Opening hours</summary>\n  <p>Tuesday to Sunday, 8am to 6pm.</p>\n</details>","note":"Announced as \"Opening hours, collapsed, button\"."},{"label":"Open by default","code":"<details open>\n  <summary>Opening hours</summary>\n  <p>Tuesday to Sunday, 8am to 6pm.</p>\n</details>","note":"Announced as \"Opening hours, expanded, button\". Use `open` for the answer people most often want."}]}'::jsonb
from public.lessons where slug = 'details-and-summary';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'progressive_detail'::public.block_type, 'When is a details element the wrong choice?', 'It is a disclosure, not a menu and not a tab set. A navigation dropdown needs different keyboard behaviour — arrow keys, Escape to close, focus returning to the trigger — and a tab set needs arrow-key navigation between tabs. For those, either use a well-tested component or accept that you are writing JavaScript. `<details>` is exactly right for FAQs, "show more" panels, and optional detail.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'details-and-summary';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<details>` plus `<summary>` gives a complete disclosure widget.","A shared `name` makes several of them mutually exclusive.","`open` starts a panel expanded.","Keyboard, screen-reader, find-in-page and print behaviour all come free."],"nextUp":"Next: dialogs and popovers."}'::jsonb
from public.lessons where slug = 'details-and-summary';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'details-guided', 1, 'guided'::public.exercise_kind, 'Build an FAQ accordion',
       'Turn these three question-and-answer pairs into an exclusive accordion using `<details>` and `<summary>`, all sharing the name `faq`. The first should start open.', '<h2>Frequently asked questions</h2>

<p>Do I need to book in advance?</p>
<p>Not on weekdays. At weekends, please book a day ahead.</p>

<p>Are helmets included?</p>
<p>Yes — a helmet and a lock come with every hire.</p>

<p>What if it rains?</p>
<p>Cancel up to two hours before and we will refund in full.</p>', '<h2>Frequently asked questions</h2>

<details name="faq" open>
  <summary>Do I need to book in advance?</summary>
  <p>Not on weekdays. At weekends, please book a day ahead.</p>
</details>

<details name="faq">
  <summary>Are helmets included?</summary>
  <p>Yes — a helmet and a lock come with every hire.</p>
</details>

<details name="faq">
  <summary>What if it rains?</summary>
  <p>Cancel up to two hours before and we will refund in full.</p>
</details>', ARRAY['Each question becomes a <summary> and each answer becomes the panel below it.', 'The <summary> must be the first child of its <details>.', 'Give all three name="faq", and add open to the first one only.']::text[],
       45, 2,
       (select id from public.skills where slug = 'native-interaction'), false
from public.lessons l where l.slug = 'details-and-summary'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'details', NULL,
       NULL, NULL, 3, 3,
       'There are three disclosure widgets', NULL, 1, true
from public.exercises e where e.slug = 'details-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'details > summary', NULL,
       NULL, NULL, 3, 3,
       'Each has a summary as its first child', NULL, 1, true
from public.exercises e where e.slug = 'details-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'details', 'name',
       'faq', NULL, NULL, NULL,
       'They share the name "faq" so only one opens at a time', NULL, 1, true
from public.exercises e where e.slug = 'details-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'details[open]', NULL,
       NULL, NULL, 1, 1,
       'Exactly one starts open', NULL, 1, true
from public.exercises e where e.slug = 'details-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'text_not_empty'::public.requirement_kind, 'summary', NULL,
       NULL, NULL, NULL, NULL,
       'Every summary has text', NULL, 1, true
from public.exercises e where e.slug = 'details-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'details-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'details-and-summary'), NULL, 'q-summary-position', 1, 'single'::public.question_kind,
        'Where must `<summary>` appear?', 'As the first child of its `<details>` element.', (select id from public.skills where slug = 'native-interaction'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'As the first child of <details>', true, NULL
from public.quiz_questions where slug = 'q-summary-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Anywhere inside <details>', false, NULL
from public.quiz_questions where slug = 'q-summary-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Immediately before <details>', false, NULL
from public.quiz_questions where slug = 'q-summary-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'As the last child of <details>', false, NULL
from public.quiz_questions where slug = 'q-summary-position';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'details-and-summary'), NULL, 'q-details-name', 2, 'single'::public.question_kind,
        'What does giving several `<details>` elements the same `name` do?', 'It makes them exclusive: opening one closes the others.', (select id from public.skills where slug = 'native-interaction'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It groups them for form submission', false, NULL
from public.quiz_questions where slug = 'q-details-name';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It has no effect on details elements', false, NULL
from public.quiz_questions where slug = 'q-details-name';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Opening one closes the others', true, NULL
from public.quiz_questions where slug = 'q-details-name';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'They all open together', false, NULL
from public.quiz_questions where slug = 'q-details-name';
-- lesson: Dialog and popover
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'dialog-and-popover', 2, 'Dialog and popover', 'Modals and tooltips, built in', 'Two newer features that handle focus trapping, Escape-to-close and layering — the parts hand-built modals get wrong.',
       ARRAY['Build a dialog and understand what modal means', 'Use the popover attribute for lightweight overlays', 'Know exactly where JavaScript is still required, and why']::text[], 14, 40, (select id from public.skills where slug = 'native-interaction'), 0.7
from public.modules m where m.slug = 'disclosure-and-dialog'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Write a <dialog> with a close mechanism","Build a popover with no JavaScript at all","Explain honestly which parts still need scripting"]}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'term'::public.block_type, 'Modal', 'An overlay that blocks the rest of the page until it is dealt with. Everything behind it becomes inert — unfocusable and unreadable to screen readers.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'A dialog with a close button that needs no JavaScript', NULL,
       '<dialog id="cancel-policy">
  <h2>Cancellation policy</h2>
  <p>Cancel up to two hours before your booking for a full refund.</p>
  <form method="dialog">
    <button type="submit">Close</button>
  </form>
</dialog>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<form method="dialog">
  <button type="submit">Close</button>
</form>', 'html', NULL, '{"annotations":[{"line":"1","text":"`method=\"dialog\"` is a special form method that exists only inside a `<dialog>`. Submitting the form closes the dialog instead of sending anything anywhere."},{"line":"2","text":"This is the one way to close a dialog with no JavaScript. It is worth knowing, because a dialog with no way out is a trap."}]}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Opening a dialog does need JavaScript', 'This is the honest limit. `showModal()` is a JavaScript method, and there is no HTML attribute that opens a `<dialog>`. What HTML gives you, once it is open, is substantial: focus moves into the dialog, focus is trapped inside it, Escape closes it, the background is made inert, and it renders above everything else regardless of stacking order. Those are precisely the things hand-built modals get wrong. This course does not teach the one line of JavaScript that opens it — but you should know that one line is all it is.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'prose'::public.block_type, NULL, 'The `popover` attribute is newer, and it does work with no JavaScript at all. Any element can become a popover; any button can control it.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<button popovertarget="helmet-info" popovertargetaction="toggle">
  What sizes do helmets come in?
</button>

<div id="helmet-info" popover>
  <h3>Helmet sizes</h3>
  <p>Small, medium and large, plus two children''s sizes.</p>
  <button popovertarget="helmet-info" popovertargetaction="hide">Close</button>
</div>', 'html', NULL, '{"annotations":[{"line":"1","text":"`popovertarget` names the element this button controls, by its id. The browser wires up the relationship — and the ARIA that goes with it — automatically."},{"line":"5","text":"The bare `popover` attribute makes the element a popover. It is hidden until shown, renders in the top layer above everything else, and closes on Escape or on a click outside it — behaviour known as \"light dismiss\"."},{"line":"8","text":"A second button with `popovertargetaction=\"hide\"` gives an explicit close. Useful on touch devices, where clicking outside is less discoverable."}]}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'comparison'::public.block_type, 'Dialog or popover?', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Dialog — needs a decision","code":"<dialog id=\"confirm\">\n  <p>Cancel this booking?</p>\n  <form method=\"dialog\">\n    <button value=\"yes\">Yes, cancel</button>\n    <button value=\"no\">Keep it</button>\n  </form>\n</dialog>","why":"Modal. The user must answer before continuing. Blocks the page deliberately."},"bad":{"label":"Popover — extra information","code":"<button popovertarget=\"tip\">Helmet sizes</button>\n<div id=\"tip\" popover>\n  <p>Small, medium and large.</p>\n</div>","why":"Non-modal. The user can ignore it and carry on. Dismisses itself on Escape or an outside click."}}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'term'::public.block_type, 'Progressive enhancement', 'Build so the page works without the enhancement, then add the enhancement for browsers that support it. The content must never be locked inside a feature that might not run.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'callout'::public.block_type, 'Never hide essential content in a popover or dialog', 'If the only place your cancellation policy exists is inside a modal, then anyone whose browser does not open it — or whose JavaScript failed to load — cannot read it. Put essential content on the page, and use overlays for convenience, not as the sole home for anything that matters.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'Browser support, and how to think about it', '`<details>` has been supported everywhere for years. `<dialog>` reached every current browser in 2022. The `popover` attribute reached every current browser in 2024. For a public site, the sensible approach is: use `<details>` freely; use `<dialog>` and `popover` where the content underneath is still reachable if the feature does nothing. That is progressive enhancement in one sentence, and it is a more useful habit than memorising a support table that changes every few months.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<dialog>` gives focus trapping, Escape-to-close and inert background — but opening it needs one line of JavaScript.","`<form method=\"dialog\">` closes a dialog with no scripting.","The `popover` attribute needs no JavaScript at all, on either side.","Never make an overlay the only place essential content exists."],"nextUp":"Next: progress, meter, datalist and output."}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'popover-guided', 1, 'guided'::public.exercise_kind, 'Build a popover',
       'Add a button that toggles a popover with the id `sizes`, and a close button inside the popover. Use `popovertarget` and `popovertargetaction`.', '<button>What sizes do helmets come in?</button>

<div id="sizes">
  <h3>Helmet sizes</h3>
  <p>Small, medium and large, plus two children''s sizes.</p>
</div>', '<button popovertarget="sizes" popovertargetaction="toggle">
  What sizes do helmets come in?
</button>

<div id="sizes" popover>
  <h3>Helmet sizes</h3>
  <p>Small, medium and large, plus two children''s sizes.</p>
  <button popovertarget="sizes" popovertargetaction="hide">Close</button>
</div>', ARRAY['Add popovertarget="sizes" to the first button.', 'Add the bare popover attribute to the div — it needs no value.', 'Add a second button inside with popovertargetaction="hide".']::text[],
       50, 3,
       (select id from public.skills where slug = 'native-interaction'), false
from public.lessons l where l.slug = 'dialog-and-popover'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'div', 'popover',
       NULL, NULL, NULL, NULL,
       'The panel is marked as a popover', NULL, 1, true
from public.exercises e where e.slug = 'popover-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'button', 'popovertarget',
       'sizes', NULL, NULL, NULL,
       'A button targets the popover', NULL, 1, true
from public.exercises e where e.slug = 'popover-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'button[popovertarget]', NULL,
       NULL, NULL, 2, 2,
       'There is a trigger button and a close button', NULL, 1, true
from public.exercises e where e.slug = 'popover-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'button[popovertargetaction="hide"]', 'popovertargetaction',
       'hide', NULL, NULL, NULL,
       'The close button hides the popover', NULL, 1, true
from public.exercises e where e.slug = 'popover-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'popover-guided';

commit;
