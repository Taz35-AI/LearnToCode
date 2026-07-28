-- HTML Hero — course seed, part 10 of 16
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 9 first.

begin;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 7, 'element_count'::public.requirement_kind, 'video[preload="auto"]', NULL,
       NULL, NULL, 0, 0,
       'The video no longer preloads its whole file', NULL, 1, true, NULL
from public.exercises e where e.slug = 'final-review-exercise';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 8, 'attribute_present'::public.requirement_kind, 'meta[name="description"]', 'content',
       NULL, NULL, NULL, NULL,
       'The page has a meta description', NULL, 1, true, NULL
from public.exercises e where e.slug = 'final-review-exercise';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 9, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page is marked in the nav', NULL, 1, true, NULL
from public.exercises e where e.slug = 'final-review-exercise';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'capstone-final-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: the finished site',
       'Apply the five reviews to every page of your capstone site and fix everything they turn up. When all five pass, export your project — the files are yours to publish anywhere.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page — your site</title>
    <meta name="description" content="A sentence about this page.">
    <link rel="canonical" href="https://your-site.example/page.html">
    <link rel="icon" href="/learning-media/favicon.svg" type="image/svg+xml">
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
      <h1>Your page heading</h1>
      <!-- Run the five reviews over everything below -->
    </main>
    <footer><p>&copy; 2026 Your site</p></footer>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Our routes — Riverside Cycle Hire</title>
    <meta name="description" content="Three waymarked routes starting from our Mill Lane workshop.">
    <link rel="canonical" href="https://riverside-cycles.example/routes.html">
    <link rel="icon" href="/learning-media/favicon.svg" type="image/svg+xml">
    <meta property="og:title" content="Our routes — Riverside Cycle Hire">
    <meta property="og:description" content="Three waymarked routes from our Mill Lane workshop.">
    <meta property="og:image" content="https://riverside-cycles.example/images/share-1200.jpg">
    <meta property="og:image:alt" content="A sandy path winding between tall trees">
    <meta property="og:url" content="https://riverside-cycles.example/routes.html">
    <meta property="og:type" content="website">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="routes.html" aria-current="page">Routes</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Our routes</h1>
      <h2>Easy routes</h2>
      <figure>
        <img src="/learning-media/images/forest-path-1200.jpg"
             alt="A sandy path winding between tall trees in a sunlit forest"
             loading="lazy" width="1200" height="800">
        <figcaption>The wooded section of the valley route.</figcaption>
      </figure>
      <ul>
        <li>Harbour loop — 6 miles, flat</li>
        <li>Mill and back — 11 miles, one climb</li>
      </ul>
    </main>
    <footer><p>&copy; 2026 Riverside Cycle Hire</p></footer>
  </body>
</html>', ARRAY['Run validation first, then the keyboard test, then check the Network panel.', 'Every page needs its own title, description and canonical.', 'Mark the current page in the nav on every page.']::text[],
       250, 5,
       (select id from public.skills where slug = 'multi-page'), false
from public.lessons l where l.slug = 'final-review'
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
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'html', 'lang',
       NULL, NULL, NULL, NULL,
       'The page declares its language', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'meta[name="description"]', 'content',
       NULL, NULL, NULL, NULL,
       'The page has its own description', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'element_present'::public.requirement_kind, 'link[rel="canonical"]', NULL,
       NULL, NULL, NULL, NULL,
       'A canonical URL is set', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'element_present'::public.requirement_kind, 'link[rel="icon"]', NULL,
       NULL, NULL, NULL, NULL,
       'A favicon is linked', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 7, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'The skip link matches the main landmark', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 8, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 9, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'There is a header landmark', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 10, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'There is a footer landmark', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 11, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav is labelled', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 12, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page is marked', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 13, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one h1', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 14, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 15, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Images have meaningful alt text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 16, 'local_media_path'::public.requirement_kind, 'img, source, video, track', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 17, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 18, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 19, 'no_deprecated_elements'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No obsolete elements are used', 'Elements like <center>, <font> and <big> were removed from HTML.', 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 20, 'text_not_empty'::public.requirement_kind, 'main p, main li', NULL,
       NULL, NULL, NULL, NULL,
       'The page has real content', NULL, 1, true, NULL
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'final-review'), NULL, 'q-review-order', 1, 'single'::public.question_kind,
        'Why validate before running an accessibility check?', 'An accessibility tool reads the repaired DOM. If the markup is invalid the browser has guessed at the structure, so the results describe a document you did not write.', (select id from public.skills where slug = 'validation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Accessibility tools refuse to run on invalid HTML', false, NULL
from public.quiz_questions where slug = 'q-review-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Validation fixes accessibility automatically', false, NULL
from public.quiz_questions where slug = 'q-review-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'There is no reason — the order does not matter', false, NULL
from public.quiz_questions where slug = 'q-review-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Invalid markup means the tool is checking a document the browser guessed at', true, NULL
from public.quiz_questions where slug = 'q-review-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'final-review'), NULL, 'q-publishing', 2, 'single'::public.question_kind,
        'What build step does a static HTML site need before publishing?', 'None. HTML runs as-is; the files you upload are the files you wrote.', (select id from public.skills where slug = 'multi-page'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Conversion to a server-side language', false, NULL
from public.quiz_questions where slug = 'q-publishing';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'None — the files run as they are', true, NULL
from public.quiz_questions where slug = 'q-publishing';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Compilation to a binary format', false, NULL
from public.quiz_questions where slug = 'q-publishing';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Minification, which is mandatory', false, NULL
from public.quiz_questions where slug = 'q-publishing';
-- HTML Hero final assessment questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q1', 1, 'single'::public.question_kind,
        'Which must be the first line of an HTML file?', 'The doctype, which switches the browser into standards mode.', (select id from public.skills where slug = 'document-structure'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<?xml version="1.0"?>', false, NULL
from public.quiz_questions where slug = 'final-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<!DOCTYPE html>', true, NULL
from public.quiz_questions where slug = 'final-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<html lang="en">', false, NULL
from public.quiz_questions where slug = 'final-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<meta charset="utf-8">', false, NULL
from public.quiz_questions where slug = 'final-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q2', 2, 'single'::public.question_kind,
        'How many `<h1>` and `<main>` elements should a page have?', 'Exactly one of each. The h1 names what the page is about, and main holds the content unique to that page — several of either leaves both readers and software with no clear answer.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'One h1 and one main', true, NULL
from public.quiz_questions where slug = 'final-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'One h1 and several main elements', false, NULL
from public.quiz_questions where slug = 'final-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Several h1 elements and one main', false, NULL
from public.quiz_questions where slug = 'final-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'As many as the design needs', false, NULL
from public.quiz_questions where slug = 'final-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q3', 3, 'single'::public.question_kind,
        'A decorative image needs which alt value?', '`alt=""` — the attribute present, its value empty.', (select id from public.skills where slug = 'images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'No alt attribute at all', false, NULL
from public.quiz_questions where slug = 'final-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'alt="decorative"', false, NULL
from public.quiz_questions where slug = 'final-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'alt=" "', false, NULL
from public.quiz_questions where slug = 'final-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'alt=""', true, NULL
from public.quiz_questions where slug = 'final-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q4', 4, 'single'::public.question_kind,
        'What connects a `<label>` to its input?', 'The label''s `for` value matching the input''s `id`.', (select id from public.skills where slug = 'forms'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A shared class', false, NULL
from public.quiz_questions where slug = 'final-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Physical adjacency', false, NULL
from public.quiz_questions where slug = 'final-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'for matching id', true, NULL
from public.quiz_questions where slug = 'final-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'for matching name', false, NULL
from public.quiz_questions where slug = 'final-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q5', 5, 'single'::public.question_kind,
        'What does `srcset` with `w` descriptors let the browser do?', 'Choose the smallest file that will still look sharp, given the layout and the device.', (select id from public.skills where slug = 'responsive-images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Convert between image formats', false, NULL
from public.quiz_questions where slug = 'final-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Choose the smallest adequate file for the device and layout', true, NULL
from public.quiz_questions where slug = 'final-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Load all the images and pick one', false, NULL
from public.quiz_questions where slug = 'final-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Resize a single image on the fly', false, NULL
from public.quiz_questions where slug = 'final-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q6', 6, 'single'::public.question_kind,
        'What must every `<iframe>` have for accessibility?', 'A `title` attribute, otherwise screen readers announce only "frame".', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A title attribute', true, NULL
from public.quiz_questions where slug = 'final-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'An alt attribute', false, NULL
from public.quiz_questions where slug = 'final-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A role attribute', false, NULL
from public.quiz_questions where slug = 'final-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'An aria-hidden attribute', false, NULL
from public.quiz_questions where slug = 'final-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q7', 7, 'single'::public.question_kind,
        'What is the first rule of ARIA?', 'Do not use ARIA if a native HTML element will do the job.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Add a role to every element', false, NULL
from public.quiz_questions where slug = 'final-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Always pair a role with tabindex', false, NULL
from public.quiz_questions where slug = 'final-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Use aria-label on every landmark', false, NULL
from public.quiz_questions where slug = 'final-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Do not use it if a native element will do', true, NULL
from public.quiz_questions where slug = 'final-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q8', 8, 'single'::public.question_kind,
        'Which script attribute is the right default?', '`defer` — downloads in parallel, runs after parsing, in source order.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Neither', false, NULL
from public.quiz_questions where slug = 'final-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'nomodule', false, NULL
from public.quiz_questions where slug = 'final-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'defer', true, NULL
from public.quiz_questions where slug = 'final-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'async', false, NULL
from public.quiz_questions where slug = 'final-q8';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q9', 9, 'single'::public.question_kind,
        'Can HTML validation attributes secure a form?', 'No. They are trivially removed, and a request can be made without loading your page at all.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Yes, if the form uses POST', false, NULL
from public.quiz_questions where slug = 'final-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'No — the server must revalidate every value', true, NULL
from public.quiz_questions where slug = 'final-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Yes, when combined with pattern', false, NULL
from public.quiz_questions where slug = 'final-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Yes, over HTTPS', false, NULL
from public.quiz_questions where slug = 'final-q9';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q10', 10, 'single'::public.question_kind,
        'What does `scope="row"` on a `<th>` do?', 'It tells assistive technology that this heading describes the row beside it, so a cell announces with its row and column headings.', (select id from public.skills where slug = 'tables'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Merges the cell across the row', false, NULL
from public.quiz_questions where slug = 'final-q10';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Makes the row sortable', false, NULL
from public.quiz_questions where slug = 'final-q10';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Repeats the row when printing', false, NULL
from public.quiz_questions where slug = 'final-q10';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Marks the heading as describing its row', true, NULL
from public.quiz_questions where slug = 'final-q10';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q11', 11, 'single'::public.question_kind,
        'Which is true of structured data?', 'It can change how a result is displayed, but it is not a ranking factor, and it must describe content genuinely on the page.', (select id from public.skills where slug = 'structured-data'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It replaces the meta description', false, NULL
from public.quiz_questions where slug = 'final-q11';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It may describe content not on the page', false, NULL
from public.quiz_questions where slug = 'final-q11';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It changes how a result is displayed, not where it ranks', true, NULL
from public.quiz_questions where slug = 'final-q11';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It guarantees a first-page position', false, NULL
from public.quiz_questions where slug = 'final-q11';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q12', 12, 'single'::public.question_kind,
        'What should you do first when a validator reports twenty errors?', 'Fix the first error and re-run. A single unclosed element commonly produces most of the rest.', (select id from public.skills where slug = 'validation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Ignore them if the page renders', false, NULL
from public.quiz_questions where slug = 'final-q12';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Fix the first one and re-validate', true, NULL
from public.quiz_questions where slug = 'final-q12';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Fix them all before re-checking', false, NULL
from public.quiz_questions where slug = 'final-q12';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Start from the last error', false, NULL
from public.quiz_questions where slug = 'final-q12';
-- --------------------------------------------------------------------------
-- CSS Architect — Level 1: The Cascade
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'css-cascade', 1, 'The Cascade', 'Why a rule wins, why it loses, and why it sometimes never applied at all',
       'Every "CSS is not working" is one of four things: the selector did not match, another rule won, the property does not inherit, or it was never valid. This level makes all four visible.', 'You can look at any conflicting pair of CSS rules and say which wins, and why.', 'violet'
from public.courses c where c.slug = 'css-architect'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'css-level-1-milestone', 'milestone'::public.assessment_kind, 'Level 1 milestone: The Cascade', 'Eight questions on rules, specificity and inheritance. Pass mark 80% — everything later in this course assumes this model.',
       0.8, 200, 1
from public.levels l where l.slug = 'css-cascade'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Rules, selectors and the cascade
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'css-first-rules', 1, 'Rules, selectors and the cascade', 'What a rule is made of, how the browser decides between two of them, and the inheritance model underneath.',
       70, false
from public.levels l where l.slug = 'css-cascade'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'css-first-rules' and s.slug = 'cascade';
-- lesson: What a rule actually is
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-what-a-rule-is', 1, 'What a rule actually is', 'Selector, declaration block, and where the CSS lives', 'Three parts, one shape, repeated forever. Everything else in CSS is variations on this.',
       ARRAY['Name the parts of a CSS rule', 'Write a rule that targets an element', 'Explain where a stylesheet can live and which wins']::text[], 14, 40, (select id from public.skills where slug = 'cascade'), 0.7
from public.modules m where m.slug = 'css-first-rules'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A page has `<p style="color: red">` in the markup and `p { color: blue }` in a stylesheet. What colour is the paragraph?',
       NULL, NULL, NULL, '{"options":["Red — the inline style wins","Blue — the stylesheet is more official","Whichever appears later in the file","Neither; they cancel out"],"answer":"Red. An inline `style` attribute beats any selector in a stylesheet, however specific — the only thing that outranks it is an `!important` declaration in a rule. This is worth knowing on day one because inline styles are the most common reason a learner''s stylesheet appears to be ignored entirely."}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Identify the selector, property and value in any rule","Write rules that target elements by type and by class","Explain the three places CSS can live, and which one wins"]}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'HTML says what something *is*. CSS says how it should look. The two stay separate on purpose: the same markup can be styled completely differently, and the same stylesheet can serve a thousand pages.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Rule', 'A selector followed by a block of declarations. `p { color: teal; }` is one rule with one declaration.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'Declaration', 'A property and a value, separated by a colon and ended with a semicolon. `color: teal;` is one declaration.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'annotated_code'::public.block_type, 'Line by line', NULL,
       'p {
  color: teal;
  line-height: 1.5;
}', 'html', NULL, '{"annotations":[{"line":"1","text":"`p` is the **selector** — every paragraph on the page."},{"line":"1","text":"The `{` opens the **declaration block**. Everything until the `}` applies to whatever the selector matched."},{"line":"2","text":"`color` is the **property**, `teal` is the **value**, and the semicolon ends the declaration. The last one before `}` may legally omit it — include it anyway, so adding a line later cannot break the one above."},{"line":"3","text":"A second declaration. A rule may have as many as it needs."}]}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'prose'::public.block_type, NULL, 'CSS can live in three places, and knowing which wins saves an afternoon.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'code_example'::public.block_type, 'Where CSS lives', NULL,
       '1. An external file, linked from the head:
   <link rel="stylesheet" href="styles.css">
   The right answer for a real site — one file, every page.

2. A <style> element in the head:
   <style> p { color: teal } </style>
   Fine for one page, and what you will use in this course.

3. A style attribute on an element:
   <p style="color: teal">
   Beats both of the above, cannot be reused, and is nearly
   always a mistake outside of email or generated markup.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'callout'::public.block_type, 'Why this course uses `<style>`', 'Everything you write here goes in a `<style>` element in the same file as the markup. That is not how a real site is built, and it removes an entire category of "my stylesheet is not loading" problems — wrong path, wrong filename, cached old copy — that teach you nothing about CSS. Level 10 covers splitting a stylesheet out properly.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'interactive_demo'::public.block_type, 'The same paragraph, three ways of styling it', 'Identical markup in all three.',
       NULL, NULL, NULL, '{"variants":[{"label":"A type selector","code":"<style>\n  p { color: teal; font-size: 1.25rem }\n</style>\n<p>Fresh bread, every morning.</p>","note":"Targets every `<p>` on the page. Simple, and exactly right when you genuinely mean all of them."},{"label":"A class","code":"<style>\n  .lead { color: teal; font-size: 1.25rem }\n</style>\n<p class=\"lead\">Fresh bread, every morning.</p>\n<p>We open at 6am.</p>","note":"Targets only what you opt in. This is the workhorse of real CSS — you decide what gets it."},{"label":"An inline style","code":"<p style=\"color: teal; font-size: 1.25rem\">Fresh bread, every morning.</p>","note":"Works, applies to exactly one element, cannot be reused, and beats any rule you write later. Avoid."}]}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'term'::public.block_type, 'Class', 'A label you put on elements with `class="name"`, selected in CSS with a leading dot: `.name`. An element may carry several, separated by spaces.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'predict_check'::public.block_type, 'Predict, then check', 'The first declaration spells the property the British way. Before you check: does the whole rule fail, does the whole stylesheet fail, or does something else happen?',
       '<style>
  p { colour: teal }
  p { font-size: 1.25rem }
</style>
<p>Fresh bread, every morning.</p>', 'html', NULL, '{"outcome":"Only that one declaration is discarded. The browser drops any declaration it does not understand and carries on — so the font size still applies, and the colour silently does nothing. There is no error, no warning, and nothing in the page to suggest a problem. This is the single most important thing to know about debugging CSS: **invalid CSS fails silently, one declaration at a time**. If a property seems to do nothing, checking the spelling is not a beginner move, it is the first thing an expert checks."}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'checklist'::public.block_type, 'The shape of every rule', NULL,
       NULL, NULL, NULL, '{"items":["A selector saying what to target","A `{` opening the block","One or more `property: value;` declarations","A `}` closing the block","Semicolons after every declaration, including the last"]}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["A rule is a selector plus a block of `property: value` declarations.","CSS lives in an external file, a `<style>` element, or a `style` attribute — in increasing order of how much it wins and how little it should be used.","A class is an opt-in label; a type selector catches everything.","An invalid declaration is dropped silently, and nothing tells you."],"nextUp":"Next: what happens when two rules disagree."}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 15, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Name the four parts of a CSS rule.","Where can CSS live, and which of the three wins?","What happens when you misspell a property name?"],"points":["Selector, declaration block, and within it a property and a value. Declarations are separated by semicolons.","An external file, a `<style>` element, or a `style` attribute. The inline `style` attribute beats the other two — only `!important` in a rule outranks it.","That single declaration is silently discarded. The rest of the rule still applies, nothing warns you, and the page simply looks wrong."]}'::jsonb
from public.lessons where slug = 'css-what-a-rule-is';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-first-rule-guided', 1, 'guided'::public.exercise_kind, 'Write your first rule',
       'The page has a heading and two paragraphs. Add a `<style>` element in the head and write one rule so that **every** paragraph is `teal`, and a second rule so the heading is `rebeccapurple`. Use type selectors — no classes yet.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Riverside Bakery</title>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>Fresh bread, every morning.</p>
    <p>We open at 6am and bake until we sell out.</p>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Riverside Bakery</title>
    <style>
      h1 { color: rebeccapurple; }
      p { color: teal; }
    </style>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>Fresh bread, every morning.</p>
    <p>We open at 6am and bake until we sell out.</p>
  </body>
</html>', ARRAY['The <style> element goes inside <head>, after the title.', 'A type selector is just the element name: p { ... }', 'Inside the block: color: teal;']::text[],
       30, 1,
       (select id from public.skills where slug = 'cascade'), false
from public.lessons l where l.slug = 'css-what-a-rule-is'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'element_present'::public.requirement_kind, 'style', NULL,
       NULL, NULL, NULL, NULL,
       'There is a <style> element', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-first-rule-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, 'p', 'color',
       'teal', NULL, NULL, NULL,
       'Every paragraph resolves to teal', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-first-rule-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, 'h1', 'color',
       'rebeccapurple', NULL, NULL, NULL,
       'The heading resolves to rebeccapurple', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-first-rule-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_rule_exists'::public.requirement_kind, NULL, NULL,
       'p', NULL, NULL, NULL,
       'A rule targets paragraphs by type', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-first-rule-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-first-rule-debug', 2, 'debug'::public.exercise_kind, 'Three rules that do nothing',
       'This stylesheet looks reasonable and none of it works. Three faults: a misspelled property, a missing colon, and a selector with a stray dot that matches nothing. Repair all three so the paragraph is `teal` at `1.25rem`, and the heading is `rebeccapurple`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Riverside Bakery</title>
    <style>
      p { colour: teal; }
      p { font-size 1.25rem; }
      .h1 { color: rebeccapurple; }
    </style>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>Fresh bread, every morning.</p>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Riverside Bakery</title>
    <style>
      p { color: teal; }
      p { font-size: 1.25rem; }
      h1 { color: rebeccapurple; }
    </style>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>Fresh bread, every morning.</p>
  </body>
</html>', ARRAY['CSS uses the American spelling of colour.', 'Every declaration needs a colon between the property and the value.', 'A leading dot means "class". The heading has no class — select it by type.']::text[],
       40, 2,
       (select id from public.skills where slug = 'cascade'), false
from public.lessons l where l.slug = 'css-what-a-rule-is'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, 'p', 'color',
       'teal', NULL, NULL, NULL,
       'The paragraph resolves to teal', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-first-rule-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, 'p', 'font-size',
       '1.25rem', NULL, NULL, NULL,
       'The paragraph resolves to 1.25rem', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-first-rule-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, 'h1', 'color',
       'rebeccapurple', NULL, NULL, NULL,
       'The heading resolves to rebeccapurple', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-first-rule-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-what-a-rule-is'), NULL, 'q-css-rule-parts', 1, 'single'::public.question_kind,
        'In `p { color: teal; }`, what is `color`?', 'The property. `teal` is its value, and together they are one declaration.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The selector', false, NULL
from public.quiz_questions where slug = 'q-css-rule-parts';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The declaration', false, NULL
from public.quiz_questions where slug = 'q-css-rule-parts';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The rule', false, NULL
from public.quiz_questions where slug = 'q-css-rule-parts';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The property', true, NULL
from public.quiz_questions where slug = 'q-css-rule-parts';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-what-a-rule-is'), NULL, 'q-css-invalid-declaration', 2, 'single'::public.question_kind,
        'What happens when a browser meets a property it does not recognise?', 'It discards that one declaration and carries on. Nothing is reported, which is why a misspelling can cost an hour.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The whole stylesheet is ignored', false, NULL
from public.quiz_questions where slug = 'q-css-invalid-declaration';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'An error appears in the page', false, NULL
from public.quiz_questions where slug = 'q-css-invalid-declaration';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'That declaration is silently dropped; the rest still applies', true, NULL
from public.quiz_questions where slug = 'q-css-invalid-declaration';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The whole rule is ignored', false, NULL
from public.quiz_questions where slug = 'q-css-invalid-declaration';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-what-a-rule-is'), NULL, 'q-css-where-it-lives', 3, 'single'::public.question_kind,
        'Which form of CSS beats the other two?', 'A `style` attribute on the element. Only an `!important` declaration in a rule outranks it.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'An external stylesheet', false, NULL
from public.quiz_questions where slug = 'q-css-where-it-lives';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A `<style>` element in the head', false, NULL
from public.quiz_questions where slug = 'q-css-where-it-lives';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Whichever was written last', false, NULL
from public.quiz_questions where slug = 'q-css-where-it-lives';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A `style` attribute on the element', true, NULL
from public.quiz_questions where slug = 'q-css-where-it-lives';
-- lesson: Specificity
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-specificity', 2, 'Specificity', 'The scoring system that decides which rule wins', 'Two rules, same property, same element. One wins. The system is small, exact, and worth learning in ten minutes rather than absorbing wrongly over months.',
       ARRAY['Score any selector as ids, classes and elements', 'Predict which of two conflicting rules wins', 'Explain why `!important` is a trap rather than a tool']::text[], 18, 40, (select id from public.skills where slug = 'cascade'), 0.7
from public.modules m where m.slug = 'css-first-rules'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'Two rules set a colour on the same paragraph: `#main p { color: blue }` and `.intro.lead.card.big { color: red }`. Four classes against one id. Which wins?',
       NULL, NULL, NULL, '{"options":["Blue — one id beats any number of classes","Red — four beats one","Whichever comes later in the stylesheet","Neither; the browser picks at random"],"answer":"Blue. Specificity is not a sum — it is three separate columns compared left to right, and a single id beats *any* number of classes, even a hundred. This is why a stylesheet that starts using ids becomes progressively harder to override, and why the fix is almost never \"add another id\"."}'::jsonb
from public.lessons where slug = 'css-specificity';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Count a selector as (ids, classes, elements)","Compare two selectors and say which applies","Explain why raising specificity to win is a debt, not a solution"]}'::jsonb
from public.lessons where slug = 'css-specificity';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Specificity', 'A score the browser gives every selector, used to decide which rule applies when two set the same property on the same element.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-specificity';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'Scoring a selector', NULL,
       'Count three things, and compare them left to right:

  ids        #main                       →  (1, 0, 0)
  classes    .card  [href]  :hover       →  (0, 1, 0)
  elements   p  h1  ::before             →  (0, 0, 1)

  p                    (0, 0, 1)
  .card                (0, 1, 0)   beats every element selector
  #main                (1, 0, 0)   beats every class selector
  .card p              (0, 1, 1)
  #main .card p        (1, 1, 1)

Left to right. Any number in a column beats everything to its right.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-specificity';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'It is not a three-digit number', 'A very common shortcut is to read (0, 1, 0) as "10" and (0, 0, 11) as "11", and conclude that eleven elements beat one class. They do not. The columns are compared independently and never carry — which is exactly why one id beats a hundred classes.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'css-specificity';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'worked_example'::public.block_type, 'Deciding a real conflict, step by step', 'A link inside a card is the wrong colour. Three rules could apply. This is the reasoning, and it is the same four steps every time.',
       NULL, NULL, NULL, '{"steps":[{"title":"List every rule that matches","code":"a            { color: blue }\n.card a      { color: teal }\n#sidebar a   { color: crimson }","reasoning":"Not every rule in the file — only the ones whose selector actually matches this element. Rules that do not match are not in the contest at all, and half of all \"why is this not working\" is a selector that never matched."},{"title":"Score each one","code":"a            (0, 0, 1)\n.card a      (0, 1, 1)\n#sidebar a   (1, 0, 1)","reasoning":"Count ids, then classes, then elements. Do it mechanically — the whole value of the system is that it does not require judgement."},{"title":"Compare left to right","code":"(1, 0, 1)  ← #sidebar a wins\n(0, 1, 1)\n(0, 0, 1)","reasoning":"The first column decides it immediately: one id beats zero ids, and nothing in the other columns can rescue the others. Only if the first column ties do you look at the second."},{"title":"Only if everything ties, source order decides","code":".card a { color: teal }\n.card a { color: crimson }   ← this one wins","reasoning":"Equal specificity means the later rule wins. This is the only situation where \"move it further down the file\" is a legitimate fix — and it is why the order of your stylesheet is part of its meaning."}]}'::jsonb
from public.lessons where slug = 'css-specificity';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'interactive_demo'::public.block_type, 'The same link, four ways of losing the argument', 'Every panel has the same markup and a different winner.',
       NULL, NULL, NULL, '{"variants":[{"label":"Type only","code":"<style>\n  a { color: teal }\n</style>\n<div class=\"card\"><a href=\"#\">Read the menu</a></div>","note":"One rule, no contest. (0, 0, 1) wins by default."},{"label":"Class beats type","code":"<style>\n  a { color: teal }\n  .card a { color: crimson }\n</style>\n<div class=\"card\"><a href=\"#\">Read the menu</a></div>","note":"(0, 1, 1) beats (0, 0, 1). Note that the *order* is irrelevant here — swapping the two rules changes nothing."},{"label":"Order breaks a tie","code":"<style>\n  .card a { color: crimson }\n  .card a { color: teal }\n</style>\n<div class=\"card\"><a href=\"#\">Read the menu</a></div>","note":"Identical specificity, so the later rule wins. This is the only case where moving a rule down the file is a real fix."},{"label":"important beats everything","code":"<style>\n  a { color: teal !important }\n  #sidebar .card a { color: crimson }\n</style>\n<div id=\"sidebar\"><div class=\"card\"><a href=\"#\">Read the menu</a></div></div>","note":"The weakest selector in the file wins because of one keyword. Now nothing can override it except another !important."}]}'::jsonb
from public.lessons where slug = 'css-specificity';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'self_explain'::public.block_type, 'Explain it in your own words', 'A colleague fixes a stubborn style by adding `!important`, and says it worked so it was the right call. Write your reply. Do not just say "it is bad practice" — explain what specifically happens next, to them and to the next person.',
       NULL, NULL, NULL, '{"modelAnswer":"It worked, and it moved the problem rather than solving it. `!important` sits above the entire specificity system, so the only thing that can override this declaration later is another `!important` — and then the only way to override *that* is a more specific `!important`. Within a few months the stylesheet has a second, parallel hierarchy where the ordinary rules are decoration and the real behaviour lives in the important ones, and nobody can predict either. The underlying question was never answered: *why* was the other rule winning? Usually the honest answer is that a selector is more specific than the component needs, and lowering that instead fixes the cause. The defensible uses of `!important` are narrow — overriding a third-party stylesheet you cannot edit, or a utility class that is explicitly meant to be final."}'::jsonb
from public.lessons where slug = 'css-specificity';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'progressive_detail'::public.block_type, 'Where `:is()`, `:where()` and `:not()` sit', '`:where()` always scores zero, whatever is inside it — which makes it the right tool for a default that must be trivially overridable. `:is()` and `:not()` take the specificity of their *most specific* argument, so `:is(h1, #main)` scores as an id, which surprises people. That difference is the whole reason `:where()` exists, and it is the cleanest way to write a base layer that never fights the components built on it.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-specificity';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Specificity is three columns — ids, classes, elements — compared left to right, never summed.","One id beats any number of classes; one class beats any number of elements.","Source order decides only when specificity is exactly equal.","`!important` sits outside the system and can only be beaten by another `!important`."],"nextUp":"Next: inheritance, and the rule that is not in the contest at all."}'::jsonb
from public.lessons where slug = 'css-specificity';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Score `#main .card a:hover` as ids, classes and elements.","Why does one id beat ten classes?","When is source order the deciding factor?"],"points":["(1, 2, 1) — one id, two classes (`.card` and the `:hover` pseudo-class), one element (`a`).","Because the columns are compared left to right and never carry. Any non-zero count in a column beats everything to its right, whatever the numbers there.","Only when two selectors have identical specificity. Then the later rule wins — and that is the only situation where moving a rule down the file is a genuine fix rather than a coincidence."]}'::jsonb
from public.lessons where slug = 'css-specificity';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-specificity-guided', 1, 'guided'::public.exercise_kind, 'Make the more specific rule win',
       'Both paragraphs should be grey, except the one with `class="lead"`, which should be `rebeccapurple`. Add exactly one rule to achieve that — do not edit the existing rule, and do not use `!important`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Specificity</title>
    <style>
      p { color: dimgray; }
    </style>
  </head>
  <body>
    <p class="lead">Fresh bread, every morning.</p>
    <p>We open at 6am.</p>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Specificity</title>
    <style>
      p { color: dimgray; }
      .lead { color: rebeccapurple; }
    </style>
  </head>
  <body>
    <p class="lead">Fresh bread, every morning.</p>
    <p>We open at 6am.</p>
  </body>
</html>', ARRAY['A class selector starts with a dot: .lead', 'A class scores (0, 1, 0), which beats the type selector''s (0, 0, 1).', 'You do not need to repeat the type: .lead on its own is enough.']::text[],
       40, 2,
       (select id from public.skills where slug = 'cascade'), false
from public.lessons l where l.slug = 'css-specificity'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.lead', 'color',
       'rebeccapurple', NULL, NULL, NULL,
       'The lead paragraph resolves to rebeccapurple', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-specificity-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, 'p:not(.lead)', 'color',
       'dimgray', NULL, NULL, NULL,
       'The other paragraph is still dimgray', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-specificity-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_no_important'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No declaration uses !important', 'Raising specificity with !important wins this argument and loses the next one — the only way to override it later is another !important.', 1, true, NULL
from public.exercises e where e.slug = 'css-specificity-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-specificity-debug', 2, 'debug'::public.exercise_kind, 'Untangle a specificity war',
       'The button should be `teal`. Someone reached for `!important` and an id to force it, and now nothing can be overridden. Repair this properly: remove every `!important` and every id selector, and make the button teal using no selector stronger than a single class.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Buttons</title>
    <style>
      button { color: dimgray; }
      #page .toolbar button { color: crimson !important; }
      .btn { color: teal; }
    </style>
  </head>
  <body>
    <div id="page">
      <div class="toolbar">
        <button class="btn" type="button">Book a table</button>
      </div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Buttons</title>
    <style>
      button { color: dimgray; }
      .btn { color: teal; }
    </style>
  </head>
  <body>
    <div id="page">
      <div class="toolbar">
        <button class="btn" type="button">Book a table</button>
      </div>
    </div>
  </body>
</html>', ARRAY['Delete the rule that uses the id and !important entirely.', 'The .btn rule already says teal — it was simply being outranked.', 'Once the id rule is gone, a single class beats the type selector on its own.']::text[],
       50, 3,
       (select id from public.skills where slug = 'cascade'), false
from public.lessons l where l.slug = 'css-specificity'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.btn', 'color',
       'teal', NULL, NULL, NULL,
       'The button resolves to teal', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-specificity-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_no_important'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No declaration uses !important', 'Raising specificity with !important wins this argument and loses the next one — the only way to override it later is another !important.', 1, true, NULL
from public.exercises e where e.slug = 'css-specificity-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_max_specificity'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, 256,
       'No selector is stronger than a single class', 'Remove the id from the selector — a component should not need one.', 1, true, NULL
from public.exercises e where e.slug = 'css-specificity-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-specificity'), NULL, 'q-css-id-vs-classes', 1, 'single'::public.question_kind,
        'Which selector wins: `#main` or `.a.b.c.d`?', '`#main`. The columns are compared left to right and never carry, so one id beats any number of classes.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Whichever comes later', false, NULL
from public.quiz_questions where slug = 'q-css-id-vs-classes';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'They tie', false, NULL
from public.quiz_questions where slug = 'q-css-id-vs-classes';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`#main` — one id beats any number of classes', true, NULL
from public.quiz_questions where slug = 'q-css-id-vs-classes';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`.a.b.c.d` — four beats one', false, NULL
from public.quiz_questions where slug = 'q-css-id-vs-classes';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-specificity'), NULL, 'q-css-source-order', 2, 'single'::public.question_kind,
        'When does the order of two rules in the file decide the winner?', 'Only when their specificity is exactly equal.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Never; only specificity matters', false, NULL
from public.quiz_questions where slug = 'q-css-source-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Only inside a media query', false, NULL
from public.quiz_questions where slug = 'q-css-source-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only when their specificity is identical', true, NULL
from public.quiz_questions where slug = 'q-css-source-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Always — later rules always win', false, NULL
from public.quiz_questions where slug = 'q-css-source-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-specificity'), NULL, 'q-css-important-cost', 3, 'single'::public.question_kind,
        'What is the real cost of fixing a conflict with `!important`?', 'It can only be overridden by another `!important`, so it starts a parallel hierarchy that grows.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It stops the rest of the rule applying', false, NULL
from public.quiz_questions where slug = 'q-css-important-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nothing — it is the recommended fix', false, NULL
from public.quiz_questions where slug = 'q-css-important-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only another !important can override it later', true, NULL
from public.quiz_questions where slug = 'q-css-important-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It slows the page down', false, NULL
from public.quiz_questions where slug = 'q-css-important-cost';
-- lesson: Inheritance
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-inheritance', 3, 'Inheritance', 'The value that is not in the specificity contest at all', 'Some properties flow down the tree and some do not. Knowing which — and that inheritance loses to everything — closes the last gap in the model.',
       ARRAY['Name which kinds of property inherit', 'Explain why an inherited value loses to any direct rule', 'Use `inherit` deliberately']::text[], 16, 40, (select id from public.skills where slug = 'cascade'), 0.7
from public.modules m where m.slug = 'css-first-rules'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', '`#page { color: crimson }` sets a colour on a wrapper. Inside it, `p { color: teal }` sets one on paragraphs. An id against a type selector. What colour are the paragraphs?',
       NULL, NULL, NULL, '{"options":["Teal — an inherited value loses to any rule on the element itself","Crimson — the id is far more specific","Crimson, because the wrapper is closer to the root","It depends which rule comes first"],"answer":"Teal, and the specificity of the id is completely irrelevant. Inheritance is not part of the specificity contest: it only supplies a value when *nothing at all* set that property on the element itself. Any direct rule, however weak, beats any inherited value, however specific its source. This one fact resolves a large share of the confusion beginners have about the cascade."}'::jsonb
from public.lessons where slug = 'css-inheritance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Predict which properties reach a child element","Explain the relationship between inheritance and specificity","Use `inherit` to opt in deliberately"]}'::jsonb
from public.lessons where slug = 'css-inheritance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'Some properties pass down the document tree to descendants automatically. Broadly: the ones about *text* inherit, and the ones about *boxes* do not.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-inheritance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'What inherits', NULL,
       'Inherit by default          Do not inherit
  color                       margin, padding
  font-family, font-size      border
  font-weight, font-style     background
  line-height                 width, height
  letter-spacing              display, position
  text-align, text-indent     flex, grid
  visibility, cursor          box-shadow
  list-style

The rule of thumb: if it describes the text, it inherits.
If it describes the box, it does not — because a box that
inherited its parent''s padding would be unusable.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-inheritance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'This is why `body { font-family: … }` works', 'Setting the font once on `body` styles the entire page, because `font-family` inherits all the way down. Setting `padding` on `body` styles only the body. Once you know which list a property is on, both behaviours stop being surprising.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-inheritance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'predict_check'::public.block_type, 'Predict, then check', 'An id sets both a colour and a border on the wrapper. A type selector sets a colour on the paragraph. Before you check: what colour is the paragraph text, and does it have a border?',
       '<style>
  #page { color: crimson; border: 2px solid crimson; }
  p     { color: teal; }
</style>
<div id="page">
  <p>Fresh bread, every morning.</p>
</div>', 'html', NULL, '{"outcome":"The text is **teal**, and there is **no border**. Two separate lessons in one. The colour is teal because inheritance only supplies a value when nothing set the property on the element itself — the id''s specificity never enters into it, because the id''s rule is not competing for the paragraph at all, only for the div. And there is no border because `border` does not inherit: only the wrapper has one. If borders inherited, every element inside a bordered box would have its own, which is obviously not what anyone wants."}'::jsonb
from public.lessons where slug = 'css-inheritance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'term'::public.block_type, '`inherit`', 'A value you can give any property to force it to take the parent''s computed value — even for a property that does not normally inherit. `border: inherit` is legal and occasionally useful.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-inheritance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'comparison'::public.block_type, 'Opting in to inheritance', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Deliberate","code":"button {\n  font-family: inherit;\n  font-size: inherit;\n}","why":"Form controls do *not* inherit fonts from the page by default — browsers give them their own. This one rule is why a button suddenly matches the rest of your text, and almost every real stylesheet contains it."},"bad":{"label":"Fighting it instead","code":"button {\n  font-family: system-ui, sans-serif;\n  font-size: 1rem;\n}","why":"Works today, and now the button has its own copy of the value. Change the page font later and the buttons quietly stop matching."}}'::jsonb
from public.lessons where slug = 'css-inheritance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'interactive_demo'::public.block_type, 'Inheritance versus a direct rule', 'The same nesting, three times.',
       NULL, NULL, NULL, '{"variants":[{"label":"Inherited","code":"<style>\n  .card { color: rebeccapurple }\n</style>\n<div class=\"card\"><p>Fresh bread, every morning.</p></div>","note":"Nothing sets a colour on the paragraph, so it inherits from the card."},{"label":"Direct rule wins","code":"<style>\n  #page .card { color: rebeccapurple }\n  p { color: teal }\n</style>\n<div id=\"page\"><div class=\"card\"><p>Fresh bread, every morning.</p></div></div>","note":"An id-and-class selector on the ancestor loses to a bare type selector on the element. Inheritance is not in the contest."},{"label":"Boxes do not inherit","code":"<style>\n  .card { border: 2px solid teal; padding: 1rem }\n</style>\n<div class=\"card\"><p>Fresh bread, every morning.</p></div>","note":"The card has a border and padding. The paragraph inside has neither — box properties stop where they are set."}]}'::jsonb
from public.lessons where slug = 'css-inheritance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'progressive_detail'::public.block_type, 'The four keywords every property accepts', '`inherit` takes the parent''s value. `initial` resets to the property''s specification default, which is often not what a browser stylesheet gives you — `display: initial` is `inline`, not `block`. `unset` behaves as `inherit` for inherited properties and `initial` for the rest, which makes it the most useful of the four. `revert` rolls back to the browser''s own stylesheet, which is the one you want when undoing your own reset.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-inheritance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Text properties inherit; box properties do not.","An inherited value only applies when nothing set the property on the element itself.","Inheritance is not part of specificity — any direct rule beats any inherited value.","`inherit` opts in deliberately, and is how form controls are made to match the page."],"nextUp":"Next: the Level 1 milestone."}'::jsonb
from public.lessons where slug = 'css-inheritance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Give three properties that inherit and three that do not.","Why does a bare `p { color: teal }` beat `#page { color: crimson }` on a paragraph inside `#page`?","What does `font-family: inherit` on a button fix?"],"points":["Inherit: `color`, `font-family`, `line-height`, `text-align`. Do not: `margin`, `padding`, `border`, `background`, `width`, `display`.","Because the id rule applies to the *wrapper*, not the paragraph. Its value only reaches the paragraph by inheritance, and inheritance supplies a value only when nothing set the property directly. The type selector does set it, so it wins — specificity never enters into it.","Form controls do not inherit fonts from the page; browsers give them their own. `inherit` makes the button follow the page font, and keeps following it if the page font changes later."]}'::jsonb
from public.lessons where slug = 'css-inheritance';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-inheritance-guided', 1, 'guided'::public.exercise_kind, 'Set the page font once',
       'Set `font-family` and `color` **once** on `body` so that every piece of text on the page picks them up by inheritance. Then make the button match, using `inherit` rather than repeating the values. Do not add a font or colour to any other selector.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Inheritance</title>
    <style>
    </style>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>Fresh bread, every morning.</p>
    <button type="button">Book a table</button>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Inheritance</title>
    <style>
      body {
        font-family: system-ui, sans-serif;
        color: rebeccapurple;
      }
      button {
        font-family: inherit;
        font-size: inherit;
      }
    </style>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>Fresh bread, every morning.</p>
    <button type="button">Book a table</button>
  </body>
</html>', ARRAY['One rule on body sets both properties for the whole page.', 'The heading and paragraph need no rules at all — they inherit.', 'For the button, write font-family: inherit rather than naming the font again.']::text[],
       45, 2,
       (select id from public.skills where slug = 'cascade'), false
from public.lessons l where l.slug = 'css-inheritance'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_declared'::public.requirement_kind, 'body', 'font-family',
       NULL, NULL, NULL, NULL,
       'The body sets a font family', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-inheritance-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_inherited'::public.requirement_kind, 'p', 'color',
       NULL, NULL, NULL, NULL,
       'The paragraph colour is inherited, not set directly', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-inheritance-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_inherited'::public.requirement_kind, 'h1', 'font-family',
       NULL, NULL, NULL, NULL,
       'The heading font is inherited, not set directly', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-inheritance-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, 'button', 'font-family',
       'inherit', NULL, NULL, NULL,
       'The button opts in with font-family: inherit', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-inheritance-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-inheritance-debug', 2, 'debug'::public.exercise_kind, 'A rule that never had a chance',
       'The author wanted every paragraph in the card to be `rebeccapurple` and used a very specific selector to be sure. It is still teal. Fix it *without* raising specificity any further — remove what is actually beating it.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Inheritance</title>
    <style>
      #page .card { color: rebeccapurple; }
      p { color: teal; }
    </style>
  </head>
  <body>
    <div id="page">
      <div class="card">
        <p>Fresh bread, every morning.</p>
      </div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Inheritance</title>
    <style>
      #page .card { color: rebeccapurple; }
    </style>
  </head>
  <body>
    <div id="page">
      <div class="card">
        <p>Fresh bread, every morning.</p>
      </div>
    </div>
  </body>
</html>', ARRAY['The specific selector is not losing a specificity contest — it is not in one.', 'The paragraph has its own colour, so it never inherits anything.', 'Delete the p rule and the inherited value reaches the paragraph.']::text[],
       50, 3,
       (select id from public.skills where slug = 'cascade'), false
from public.lessons l where l.slug = 'css-inheritance'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, 'p', 'color',
       'rebeccapurple', NULL, NULL, NULL,
       'The paragraph resolves to rebeccapurple', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-inheritance-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_inherited'::public.requirement_kind, 'p', 'color',
       NULL, NULL, NULL, NULL,
       'It gets there by inheritance, not a rule of its own', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-inheritance-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_no_important'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No declaration uses !important', 'Raising specificity with !important wins this argument and loses the next one — the only way to override it later is another !important.', 1, true, NULL
from public.exercises e where e.slug = 'css-inheritance-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-inheritance'), NULL, 'q-css-what-inherits', 1, 'single'::public.question_kind,
        'Which of these inherits by default?', '`color` inherits, along with the other text properties. Box properties such as padding, border and width do not.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`width`', false, NULL
from public.quiz_questions where slug = 'q-css-what-inherits';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`color`', true, NULL
from public.quiz_questions where slug = 'q-css-what-inherits';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`padding`', false, NULL
from public.quiz_questions where slug = 'q-css-what-inherits';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`border`', false, NULL
from public.quiz_questions where slug = 'q-css-what-inherits';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-inheritance'), NULL, 'q-css-inheritance-vs-specificity', 2, 'single'::public.question_kind,
        'Why does `p { color: teal }` beat an inherited value from `#page { color: crimson }`?', 'Inheritance only supplies a value when nothing set the property on the element itself. It is not part of the specificity contest.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Type selectors beat id selectors', false, NULL
from public.quiz_questions where slug = 'q-css-inheritance-vs-specificity';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The p rule comes later in the file', false, NULL
from public.quiz_questions where slug = 'q-css-inheritance-vs-specificity';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Because `#page` is not a real selector', false, NULL
from public.quiz_questions where slug = 'q-css-inheritance-vs-specificity';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Inheritance only applies when nothing sets the property directly', true, NULL
from public.quiz_questions where slug = 'q-css-inheritance-vs-specificity';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-inheritance'), NULL, 'q-css-button-font', 3, 'single'::public.question_kind,
        'Why do buttons usually need `font-family: inherit`?', 'Form controls do not inherit fonts from the page — browsers give them their own — so they must opt in.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Form controls do not inherit fonts by default', true, NULL
from public.quiz_questions where slug = 'q-css-button-font';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Buttons cannot have a font-family set directly', false, NULL
from public.quiz_questions where slug = 'q-css-button-font';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It makes the button load faster', false, NULL
from public.quiz_questions where slug = 'q-css-button-font';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is required for accessibility', false, NULL
from public.quiz_questions where slug = 'q-css-button-font';
-- lesson: Milestone: make the page obey you
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-cascade-milestone', 4, 'Milestone: make the page obey you', 'Six conflicts, one stylesheet', 'A stylesheet where nothing does what its author intended. Every fault is a cascade fault, and none of them needs a new property.',
       ARRAY['Diagnose why a rule is not applying', 'Repair conflicts without raising specificity', 'Produce a stylesheet with no `!important` and no id selectors']::text[], 24, 40, (select id from public.skills where slug = 'cascade'), 0.8
from public.modules m where m.slug = 'css-first-rules'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Work through cascade faults methodically","Repair each without escalating specificity","Explain every change you made"]}'::jsonb
from public.lessons where slug = 'css-cascade-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'checklist'::public.block_type, 'When a rule is not applying, check in this order', NULL,
       NULL, NULL, NULL, '{"items":["Does the selector actually match anything?","Is the property spelled correctly, and the value valid?","Is another rule winning on specificity?","Is another rule winning on source order at equal specificity?","Is there an `!important` anywhere?","Is there an inline `style` attribute on the element?","Does the property even inherit, if you set it on an ancestor?"]}'::jsonb
from public.lessons where slug = 'css-cascade-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'callout'::public.block_type, 'Check the cheap things first', 'The list above is in order of how quickly you can rule each one out. A misspelled property takes five seconds to check and accounts for a surprising share of lost afternoons — checking it before you start reasoning about specificity is not laziness, it is efficiency.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-cascade-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'interactive_demo'::public.block_type, 'The four ways a rule fails', 'One symptom, four completely different causes.',
       NULL, NULL, NULL, '{"variants":[{"label":"Selector never matched","code":"<style>\n  .intro { color: teal }\n</style>\n<p class=\"lead\">Fresh bread.</p>","note":"Nothing is wrong with the CSS. The class in the markup is `lead`, not `intro`, so the rule is not in the contest at all."},{"label":"Invalid value","code":"<style>\n  p { color: tealish }\n</style>\n<p>Fresh bread.</p>","note":"`tealish` is not a colour, so the declaration is dropped silently. The selector matched perfectly."},{"label":"Outranked","code":"<style>\n  p { color: teal }\n  .card p { color: crimson }\n</style>\n<div class=\"card\"><p>Fresh bread.</p></div>","note":"Both matched, both valid. The more specific one simply won."},{"label":"Never inherited","code":"<style>\n  .card { border: 2px solid teal }\n</style>\n<div class=\"card\"><p>Fresh bread.</p></div>","note":"The author expected the paragraph to get a border too. `border` does not inherit, so it never could."}]}'::jsonb
from public.lessons where slug = 'css-cascade-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'recall'::public.block_type, 'From memory', 'Close the page. From memory, write the checklist for diagnosing a rule that is not applying — in order, cheapest check first.',
       NULL, NULL, NULL, '{"points":["Does the selector match anything at all?","Is the property spelled right and the value valid?","Is another rule winning on specificity?","At equal specificity, is another rule later in the file?","Is there an `!important`?","Is there an inline `style` attribute?","Does the property inherit, if you set it on an ancestor?"]}'::jsonb
from public.lessons where slug = 'css-cascade-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Almost every cascade fault is one of four things: no match, invalid, outranked, or not inherited.","Check the cheap causes before reasoning about specificity.","Repair by lowering the winning selector, not by raising the losing one."],"nextUp":"Next: the box model."}'::jsonb
from public.lessons where slug = 'css-cascade-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Name the four reasons a valid-looking rule does nothing.","Why repair a conflict by lowering specificity rather than raising it?"],"points":["The selector matched nothing; the declaration was invalid and silently dropped; another rule outranked it; or the property was set on an ancestor and does not inherit.","Because raising it is unbounded — every future override has to beat the new high-water mark, and the stylesheet ratchets upwards until only `!important` works. Lowering the winner puts the ceiling back down for everyone."]}'::jsonb
from public.lessons where slug = 'css-cascade-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-cascade-milestone-debug', 1, 'debug'::public.exercise_kind, 'Six conflicts, one stylesheet',
       'Every intended style is being defeated. Repair the stylesheet so that: the page font is inherited from `body`; every paragraph is `dimgray`; the `.lead` paragraph is `rebeccapurple`; the `.btn` button is `teal` and matches the page font. Remove every `!important`, every id selector and the inline style. No selector may be stronger than a single class.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Cascade milestone</title>
    <style>
      body { font-family: system-ui, sans-serif; }
      p { color: dimgray; }
      #page .lead { color: rebeccapurple; }
      .lead { color: dimgray !important; }
      button { color: crimson; }
      .btn { color: teal; }
    </style>
  </head>
  <body>
    <div id="page">
      <p class="lead" style="color: crimson">Fresh bread, every morning.</p>
      <p>We open at 6am and bake until we sell out.</p>
      <button class="btn" type="button">Book a table</button>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Cascade milestone</title>
    <style>
      body { font-family: system-ui, sans-serif; }
      p { color: dimgray; }
      .lead { color: rebeccapurple; }
      button { color: crimson; font-family: inherit; }
      .btn { color: teal; }
    </style>
  </head>
  <body>
    <div id="page">
      <p class="lead">Fresh bread, every morning.</p>
      <p>We open at 6am and bake until we sell out.</p>
      <button class="btn" type="button">Book a table</button>
    </div>
  </body>
</html>', ARRAY['Start by deleting the inline style attribute — nothing in the stylesheet can beat it.', 'The two .lead rules disagree; keep the one that says rebeccapurple and drop the !important.', 'Remove #page from the selector so no rule is stronger than one class.', 'The button needs font-family: inherit to pick up the body font.']::text[],
       70, 4,
       (select id from public.skills where slug = 'cascade'), false
from public.lessons l where l.slug = 'css-cascade-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.lead', 'color',
       'rebeccapurple', NULL, NULL, NULL,
       'The lead paragraph is rebeccapurple', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-cascade-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, 'p:not(.lead)', 'color',
       'dimgray', NULL, NULL, NULL,
       'Ordinary paragraphs are dimgray', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-cascade-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.btn', 'color',
       'teal', NULL, NULL, NULL,
       'The button is teal', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-cascade-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, 'button', 'font-family',
       'inherit', NULL, NULL, NULL,
       'The button inherits the page font', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-cascade-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_inherited'::public.requirement_kind, 'p', 'font-family',
       NULL, NULL, NULL, NULL,
       'Paragraph fonts come from body by inheritance', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-cascade-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'css_no_important'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No declaration uses !important', 'Raising specificity with !important wins this argument and loses the next one — the only way to override it later is another !important.', 1, true, NULL
from public.exercises e where e.slug = 'css-cascade-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 7, 'css_max_specificity'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, 256,
       'No selector is stronger than a single class', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-cascade-milestone-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-cascade-milestone'), NULL, 'q-css-diagnose-order', 1, 'single'::public.question_kind,
        'A rule looks correct and does nothing. What is the cheapest thing to check first?', 'Whether the selector matches anything at all, and whether the property is spelled correctly. Both take seconds and account for a large share of lost time.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Whether another rule is more specific', false, NULL
from public.quiz_questions where slug = 'q-css-diagnose-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Whether the browser supports the property', false, NULL
from public.quiz_questions where slug = 'q-css-diagnose-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Whether the stylesheet loaded', false, NULL
from public.quiz_questions where slug = 'q-css-diagnose-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Whether the selector matches, and whether the property is spelled right', true, NULL
from public.quiz_questions where slug = 'q-css-diagnose-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-cascade-milestone'), NULL, 'q-css-repair-direction', 2, 'single'::public.question_kind,
        'Why repair a conflict by lowering the winning selector rather than raising the losing one?', 'Raising is unbounded: every future override must beat the new high-water mark, until only `!important` works.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Lower specificity renders faster', false, NULL
from public.quiz_questions where slug = 'q-css-repair-direction';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Raising specificity is invalid CSS', false, NULL
from public.quiz_questions where slug = 'q-css-repair-direction';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'There is no difference', false, NULL
from public.quiz_questions where slug = 'q-css-repair-direction';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Raising ratchets the whole stylesheet upwards without limit', true, NULL
from public.quiz_questions where slug = 'q-css-repair-direction';
-- Level 1 milestone: The Cascade questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-1-milestone'), 'a-css-1-specificity-order', 1, 'single'::public.question_kind,
        'Put these in order, weakest first: `.card p`, `p`, `#main p`.', 'Elements, then classes, then ids — compared left to right.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'They are all equal', false, NULL
from public.quiz_questions where slug = 'a-css-1-specificity-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`p`, `.card p`, `#main p`', true, NULL
from public.quiz_questions where slug = 'a-css-1-specificity-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`p`, `#main p`, `.card p`', false, NULL
from public.quiz_questions where slug = 'a-css-1-specificity-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`.card p`, `p`, `#main p`', false, NULL
from public.quiz_questions where slug = 'a-css-1-specificity-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-1-milestone'), 'a-css-1-inheritance-loses', 2, 'single'::public.question_kind,
        'An ancestor with an id sets `color`. The element itself has a type-selector rule setting `color`. Which applies?', 'The rule on the element. Inheritance supplies a value only when nothing set the property directly.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The ancestor, because of the id', false, NULL
from public.quiz_questions where slug = 'a-css-1-inheritance-loses';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Whichever is later in the file', false, NULL
from public.quiz_questions where slug = 'a-css-1-inheritance-loses';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Neither applies', false, NULL
from public.quiz_questions where slug = 'a-css-1-inheritance-loses';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The rule on the element itself', true, NULL
from public.quiz_questions where slug = 'a-css-1-inheritance-loses';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-1-milestone'), 'a-css-1-invalid-silent', 3, 'single'::public.question_kind,
        'What does a browser do with `colour: teal`?', 'Discards that declaration silently and applies the rest of the rule.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Drops the whole rule', false, NULL
from public.quiz_questions where slug = 'a-css-1-invalid-silent';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Logs an error to the console', false, NULL
from public.quiz_questions where slug = 'a-css-1-invalid-silent';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Treats it as `color`', false, NULL
from public.quiz_questions where slug = 'a-css-1-invalid-silent';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Drops that declaration and keeps the rest of the rule', true, NULL
from public.quiz_questions where slug = 'a-css-1-invalid-silent';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-1-milestone'), 'a-css-1-inline-beats', 4, 'single'::public.question_kind,
        'What beats a `style` attribute on the element?', 'Only an `!important` declaration in a rule.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Nothing at all', false, NULL
from public.quiz_questions where slug = 'a-css-1-inline-beats';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'An `!important` declaration in a rule', true, NULL
from public.quiz_questions where slug = 'a-css-1-inline-beats';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'An id selector', false, NULL
from public.quiz_questions where slug = 'a-css-1-inline-beats';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A rule later in the stylesheet', false, NULL
from public.quiz_questions where slug = 'a-css-1-inline-beats';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-1-milestone'), 'a-css-1-does-not-inherit', 5, 'single'::public.question_kind,
        'Which of these does **not** inherit?', 'Box properties such as padding stop where they are set.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`line-height`', false, NULL
from public.quiz_questions where slug = 'a-css-1-does-not-inherit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`padding`', true, NULL
from public.quiz_questions where slug = 'a-css-1-does-not-inherit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`color`', false, NULL
from public.quiz_questions where slug = 'a-css-1-does-not-inherit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`font-family`', false, NULL
from public.quiz_questions where slug = 'a-css-1-does-not-inherit';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-1-milestone'), 'a-css-1-where-zero', 6, 'single'::public.question_kind,
        'What is the specificity of `:where(.card) p`?', '`:where()` always contributes zero, so this scores as a single element selector.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The same as `p`', true, NULL
from public.quiz_questions where slug = 'a-css-1-where-zero';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The same as `.card p`', false, NULL
from public.quiz_questions where slug = 'a-css-1-where-zero';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The same as `#card p`', false, NULL
from public.quiz_questions where slug = 'a-css-1-where-zero';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Zero for the whole selector', false, NULL
from public.quiz_questions where slug = 'a-css-1-where-zero';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-1-milestone'), 'a-css-1-tie-break', 7, 'single'::public.question_kind,
        'Two rules have identical specificity and set the same property. Which applies?', 'The later one in source order.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The one later in the stylesheet', true, NULL
from public.quiz_questions where slug = 'a-css-1-tie-break';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The one earlier in the stylesheet', false, NULL
from public.quiz_questions where slug = 'a-css-1-tie-break';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Neither; it is undefined', false, NULL
from public.quiz_questions where slug = 'a-css-1-tie-break';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Both, merged together', false, NULL
from public.quiz_questions where slug = 'a-css-1-tie-break';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-1-milestone'), 'a-css-1-button-inherit', 8, 'single'::public.question_kind,
        'Why does `button { font-family: inherit }` appear in almost every real stylesheet?', 'Browsers give form controls their own font, so they do not follow the page unless told to.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It is required by the HTML specification', false, NULL
from public.quiz_questions where slug = 'a-css-1-button-inherit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It improves rendering performance', false, NULL
from public.quiz_questions where slug = 'a-css-1-button-inherit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Form controls do not inherit the page font by default', true, NULL
from public.quiz_questions where slug = 'a-css-1-button-inherit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Buttons cannot be given a font directly', false, NULL
from public.quiz_questions where slug = 'a-css-1-button-inherit';
-- --------------------------------------------------------------------------
-- CSS Architect — Level 2: Boxes and Selectors
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'css-box-model', 2, 'Boxes and Selectors', 'How a box gets its size, and how to target exactly what you mean',
       'Every element is a box. Four layers decide how big it is, one property changes the maths entirely, and a handful of selectors let you reach any element without escalating specificity.', 'You can size any element predictably and write selectors that target precisely what you intend.', 'violet'
from public.courses c where c.slug = 'css-architect'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'css-level-2-milestone', 'milestone'::public.assessment_kind, 'Level 2 milestone: Boxes and Selectors', 'Six questions on the box model and selectors. Pass mark 75%.',
       0.75, 180, 2
from public.levels l where l.slug = 'css-box-model'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: The box model
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'css-boxes', 1, 'The box model', 'Content, padding, border, margin — and the property that changes what width means.',
       50, false
from public.levels l where l.slug = 'css-box-model'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'css-boxes' and p.slug = 'css-first-rules';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'css-boxes' and s.slug = 'box-model';
-- lesson: The four layers of a box
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-the-four-layers', 1, 'The four layers of a box', 'Content, padding, border, margin — and what `width` actually measures', 'An element declared 300px wide is often not 300px wide. One property fixes that, and almost every real stylesheet sets it on the first line.',
       ARRAY['Name the four layers of the box model', 'Explain what `width` measures by default', 'Use `box-sizing: border-box` and say why']::text[], 16, 40, (select id from public.skills where slug = 'box-model'), 0.7
from public.modules m where m.slug = 'css-boxes'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A box has `width: 300px`, `padding: 20px` and `border: 5px solid`. How wide is it on screen, by default?',
       NULL, NULL, NULL, '{"options":["350px — padding and border are added on top of the width","300px — width means the whole box","260px — padding and border eat into the width","345px"],"answer":"350px: 300 + 20 + 20 + 5 + 5. By default `width` sets the **content** box only, and padding and border are added *outside* it. This is why a layout of \"four 25% columns\" overflows the moment anyone adds padding, and why `box-sizing: border-box` — which makes `width` mean the whole visible box — appears at the top of nearly every professional stylesheet."}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Identify content, padding, border and margin on any element","Predict the rendered width of a box","Apply `border-box` sizing and explain the difference"]}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Content box', 'The area the text or image itself occupies. This is what `width` and `height` set by default.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Padding', 'Space *inside* the box, between the content and the border. It takes the background colour.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'Border', 'A line drawn at the edge of the padding. It has a width, a style and a colour, and the style is required — `border: 1px solid` shows nothing without it.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'term'::public.block_type, 'Margin', 'Space *outside* the box, pushing other elements away. It is always transparent.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'code_example'::public.block_type, 'The four layers', NULL,
       '┌─────────────────────────────────────┐
│ margin            (transparent)     │
│  ┌───────────────────────────────┐  │
│  │ border                        │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │ padding   (background)  │  │  │
│  │  │  ┌───────────────────┐  │  │  │
│  │  │  │ content           │  │  │  │
│  │  │  └───────────────────┘  │  │  │
│  │  └─────────────────────────┘  │  │
│  └───────────────────────────────┘  │
└─────────────────────────────────────┘

Outward from the middle: content, padding, border, margin.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'worked_example'::public.block_type, 'Working out a real width', 'A card is meant to be exactly half of an 800px container. Here is why the obvious answer overflows, and the two ways to fix it.',
       NULL, NULL, NULL, '{"steps":[{"title":"The obvious attempt","code":".card { width: 50%; padding: 1rem; border: 1px solid; }","reasoning":"50% of 800 is 400. But `width` sets the content box, so the visible box is 400 + 16 + 16 + 1 + 1 = 434px. Two of them are 868px in an 800px container, and the second wraps."},{"title":"The fix nobody should have to discover","code":"*, *::before, *::after { box-sizing: border-box; }","reasoning":"Now `width` means the whole visible box, so 50% is genuinely 400px and the padding and border come out of that. Two fit exactly. This is why it goes at the top of the stylesheet, applied to everything, before any component is written."},{"title":"Why the universal selector, and why the pseudo-elements","code":"*, *::before, *::after { box-sizing: border-box; }","reasoning":"`box-sizing` does not inherit, so setting it on `body` reaches nothing else. The universal selector is the only way to reach everything, and generated content needs it too or a `::before` sized in percentages behaves differently from its element."},{"title":"What it does not change","code":".card { width: 50%; margin: 1rem; }","reasoning":"Margin is still outside the box under either model — `border-box` never included it. Two 50% cards with margins still overflow, and that is the problem `gap` solves once you reach flexbox."}]}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'interactive_demo'::public.block_type, 'The same declared width, two sizing models', 'Both boxes say `width: 300px`.',
       NULL, NULL, NULL, '{"variants":[{"label":"border-box","code":"<style>\n  .box { box-sizing: border-box; width: 300px; padding: 20px; border: 5px solid teal; background: #eef; }\n</style>\n<div class=\"box\">Exactly 300px wide on screen.</div>","note":"The padding and border come *out of* the 300px. What you declared is what you measure."},{"label":"content-box (the default)","code":"<style>\n  .box { box-sizing: content-box; width: 300px; padding: 20px; border: 5px solid crimson; background: #fee; }\n</style>\n<div class=\"box\">350px wide on screen.</div>","note":"300px of content, plus 40px of padding, plus 10px of border. The declared number is the one part you cannot see."}]}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'predict_check'::public.block_type, 'Predict, then check', 'One element has 40px of margin below it, the next has 20px above. Before you check: how much space is between them — 60px, 40px, or 20px?',
       '<style>
  .a { margin-bottom: 40px; }
  .b { margin-top: 20px; }
</style>
<p class="a">First paragraph.</p>
<p class="b">Second paragraph.</p>', 'html', NULL, '{"outcome":"40px. Adjacent vertical margins **collapse** into one, and the larger wins rather than the two adding up. This catches everyone, and it is deliberate: it is why consecutive paragraphs are evenly spaced rather than accumulating gaps. Collapsing only happens vertically, only in normal flow, and it stops entirely inside a flex or grid container — which is one more reason modern layouts use `gap` instead of margins."}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'callout'::public.block_type, 'Margin collapse is not a bug', 'The three surprises are: adjacent siblings collapse to the larger of the two; a parent and its first or last child collapse together unless something separates them (padding, a border, or a new formatting context); and an empty element collapses its own top and bottom margins into one. Flex and grid containers do not collapse margins at all.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'checklist'::public.block_type, 'Box model checklist', NULL,
       NULL, NULL, NULL, '{"items":["`box-sizing: border-box` on `*, *::before, *::after`, once, at the top","Padding for space inside; margin for space between","A border needs a style — `1px solid`, not just `1px`","Vertical margins between siblings collapse to the larger","Margin is outside the box under both sizing models"]}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Every element is content, padding, border and margin, outward from the middle.","By default `width` sets the content box, so padding and border are added on top.","`box-sizing: border-box` makes `width` mean the whole visible box.","Adjacent vertical margins collapse to the larger of the two."],"nextUp":"Next: selectors, and reaching what you mean."}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Name the four layers, from the inside out.","A box has `width: 200px`, `padding: 10px`, `border: 2px`. How wide is it in each sizing model?","What happens between a 30px bottom margin and a 10px top margin?"],"points":["Content, padding, border, margin.","`content-box`: 200 + 20 + 4 = 224px on screen. `border-box`: 200px on screen, with the padding and border taken out of it, leaving 176px of content.","They collapse to 30px — the larger, not the sum. Vertical margins between siblings in normal flow always do this."]}'::jsonb
from public.lessons where slug = 'css-the-four-layers';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-border-box-guided', 1, 'guided'::public.exercise_kind, 'Make width mean what it says',
       'Apply `border-box` sizing to everything, then give `.card` a width of `300px`, `1rem` of padding and a `2px solid teal` border. With border-box in place the card should measure exactly 300px on screen.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Boxes</title>
    <style>
    </style>
  </head>
  <body>
    <div class="card">Fresh bread, every morning.</div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Boxes</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card {
        width: 300px;
        padding: 1rem;
        border: 2px solid teal;
      }
    </style>
  </head>
  <body>
    <div class="card">Fresh bread, every morning.</div>
  </body>
</html>', ARRAY['The sizing rule targets everything: *, *::before, *::after', 'box-sizing does not inherit, which is why it needs the universal selector.', 'A border needs three parts: width, style, colour.']::text[],
       40, 2,
       (select id from public.skills where slug = 'box-model'), false
from public.lessons l where l.slug = 'css-the-four-layers'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.card', 'box-sizing',
       'border-box', NULL, NULL, NULL,
       'The card uses border-box sizing', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-border-box-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.card', 'width',
       '300px', NULL, NULL, NULL,
       'The card is 300px wide', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-border-box-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.card', 'padding',
       '1rem', NULL, NULL, NULL,
       'The card has 1rem of padding', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-border-box-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value_matches'::public.requirement_kind, '.card', 'border',
       '2px\s+solid\s+teal', NULL, NULL, NULL,
       'The card has a 2px solid teal border', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-border-box-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-box-debug', 2, 'debug'::public.exercise_kind, 'Two columns that will not fit',
       'Two `.col` elements are each 50% wide and they wrap onto separate lines instead of sitting side by side in the 800px container. The cause is the sizing model, not the width. Fix it by adding the sizing rule — do not change the 50%.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Columns</title>
    <style>
      .row { width: 800px; }
      .col {
        float: left;
        width: 50%;
        padding: 1rem;
        border: 1px solid teal;
      }
    </style>
  </head>
  <body>
    <div class="row">
      <div class="col">Sourdough</div>
      <div class="col">Rye</div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Columns</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .row { width: 800px; }
      .col {
        float: left;
        width: 50%;
        padding: 1rem;
        border: 1px solid teal;
      }
    </style>
  </head>
  <body>
    <div class="row">
      <div class="col">Sourdough</div>
      <div class="col">Rye</div>
    </div>
  </body>
</html>', ARRAY['Each column is 50% *plus* its padding and border, so the pair exceeds 100%.', 'Add the universal border-box rule at the top of the stylesheet.', 'Do not reduce the 50% — that would only hide the real cause.']::text[],
       45, 3,
       (select id from public.skills where slug = 'box-model'), false
from public.lessons l where l.slug = 'css-the-four-layers'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.col', 'box-sizing',
       'border-box', NULL, NULL, NULL,
       'Columns use border-box sizing', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-box-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.col', 'width',
       '50%', NULL, NULL, NULL,
       'The declared width is still 50%', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-box-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.col', 'padding',
       '1rem', NULL, NULL, NULL,
       'The padding is unchanged', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-box-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-the-four-layers'), NULL, 'q-css-width-measures', 1, 'single'::public.question_kind,
        'By default, what does `width` measure?', 'The content box only. Padding and border are added outside it.', (select id from public.skills where slug = 'box-model'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The box including its margin', false, NULL
from public.quiz_questions where slug = 'q-css-width-measures';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It depends on the element', false, NULL
from public.quiz_questions where slug = 'q-css-width-measures';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The content box only', true, NULL
from public.quiz_questions where slug = 'q-css-width-measures';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The whole visible box', false, NULL
from public.quiz_questions where slug = 'q-css-width-measures';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-the-four-layers'), NULL, 'q-css-border-box-selector', 2, 'single'::public.question_kind,
        'Why is `box-sizing: border-box` applied with `*` rather than on `body`?', '`box-sizing` does not inherit, so setting it on an ancestor reaches nothing else.', (select id from public.skills where slug = 'box-model'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Because box-sizing does not inherit', true, NULL
from public.quiz_questions where slug = 'q-css-border-box-selector';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Because body is not a real element', false, NULL
from public.quiz_questions where slug = 'q-css-border-box-selector';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Because the universal selector is faster', false, NULL
from public.quiz_questions where slug = 'q-css-border-box-selector';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It makes no difference which you use', false, NULL
from public.quiz_questions where slug = 'q-css-border-box-selector';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-the-four-layers'), NULL, 'q-css-margin-collapse', 3, 'single'::public.question_kind,
        'A 30px bottom margin sits above a 10px top margin. How much space is between them?', 'They collapse to the larger of the two: 30px.', (select id from public.skills where slug = 'box-model'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '10px', false, NULL
from public.quiz_questions where slug = 'q-css-margin-collapse';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '20px', false, NULL
from public.quiz_questions where slug = 'q-css-margin-collapse';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '30px', true, NULL
from public.quiz_questions where slug = 'q-css-margin-collapse';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '40px', false, NULL
from public.quiz_questions where slug = 'q-css-margin-collapse';
-- lesson: Selectors that reach what you mean
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-selectors', 2, 'Selectors that reach what you mean', 'Combinators, attributes and pseudo-classes — without escalating specificity', 'A handful of selectors cover almost everything, and choosing well keeps specificity low enough that the next person can override you.',
       ARRAY['Use descendant, child and sibling combinators', 'Select by attribute and by state', 'Keep specificity low deliberately']::text[], 16, 40, (select id from public.skills where slug = 'selectors'), 0.7
from public.modules m where m.slug = 'css-boxes'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'You want to style only the paragraphs that are *directly* inside `.card`, not ones nested deeper. Which selector does that?',
       NULL, NULL, NULL, '{"options":["`.card > p`","`.card p`","`.card + p`","`.card ~ p`"],"answer":"`.card > p` — the child combinator, which matches only direct children. `.card p` is the *descendant* combinator and matches paragraphs at any depth, which is the default when you write a space and the source of a great many accidental matches. `+` and `~` are sibling combinators and match elements alongside `.card`, not inside it."}'::jsonb
from public.lessons where slug = 'css-selectors';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Choose the right combinator for a relationship","Select elements by attribute and by state","Explain why `:where()` exists"]}'::jsonb
from public.lessons where slug = 'css-selectors';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'The selectors worth knowing', NULL,
       '.card p        descendant  — any p inside, at any depth
.card > p      child       — only direct children
.card + p      adjacent    — the p immediately after .card
.card ~ p      sibling     — every p after .card, same parent

a[href]                 has the attribute at all
a[href^="https"]        starts with
a[href$=".pdf"]         ends with
a[href*="example"]      contains

a:hover, a:focus-visible    state
li:first-child, li:last-child, li:nth-child(2n)
input:checked, input:disabled, input:invalid
p:not(.lead)                negation', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-selectors';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'interactive_demo'::public.block_type, 'Descendant versus child', 'Identical markup, one character different in the CSS.',
       NULL, NULL, NULL, '{"variants":[{"label":"Child only","code":"<style>\n  .card > p { color: teal }\n</style>\n<div class=\"card\">\n  <p>Direct child — teal.</p>\n  <blockquote><p>Nested deeper — untouched.</p></blockquote>\n</div>","note":"Only the direct child matches. The nested paragraph keeps its inherited colour."},{"label":"Any descendant","code":"<style>\n  .card p { color: teal }\n</style>\n<div class=\"card\">\n  <p>Direct child — teal.</p>\n  <blockquote><p>Nested deeper — also teal.</p></blockquote>\n</div>","note":"Both match. Usually fine, occasionally a surprise when a component is nested inside another."},{"label":"Attribute selector","code":"<style>\n  a[href^=\"https\"] { color: teal }\n  a[href$=\".pdf\"] { font-weight: bold }\n</style>\n<a href=\"https://example.org\">External</a>\n<a href=\"/menu.pdf\">Menu (PDF)</a>\n<a href=\"about.html\">About</a>","note":"Style by what the markup says rather than by an extra class. The third link matches neither."}]}'::jsonb
from public.lessons where slug = 'css-selectors';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Style state with `:focus-visible`, not just `:hover`', 'A rule that only responds to `:hover` is invisible to keyboard users. `:focus-visible` shows a focus style when the browser judges it useful — on keyboard focus but not on a mouse click — which is what you want. Never remove a focus outline without replacing it with something at least as visible.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-selectors';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'self_explain'::public.block_type, 'Explain it in your own words', 'Your team writes `#sidebar .widget ul li a { color: teal }` for a link in a sidebar widget. It works. Explain what it costs, and what you would write instead.',
       NULL, NULL, NULL, '{"modelAnswer":"It works and it sets a specificity of one id, one class and three elements — so every future override of that link has to match or beat it. A theme, a dark mode, a utility class, or simply a different state all now need selectors at least that strong, and the stylesheet ratchets upwards. Nothing in that chain is doing useful work either: the `ul li` describes the markup structure rather than the thing being styled, so moving the link out of a list breaks the rule for no reason. What it should be is a single class on the thing itself — `.widget-link { color: teal }` — which is one class of specificity, survives the markup changing, and can be overridden by anything that needs to."}'::jsonb
from public.lessons where slug = 'css-selectors';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'progressive_detail'::public.block_type, '`:is()`, `:where()` and the specificity escape hatch', '`:is(h1, h2, h3)` matches any of them and takes the specificity of its *most specific* argument. `:where(h1, h2, h3)` matches the same elements and always scores **zero**. That makes `:where()` the right tool for a base layer — defaults that anything can override without a fight. A reset written as `:where(ul, ol) { margin: 0 }` never needs to be beaten, because it contributes nothing to the contest.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-selectors';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["A space is the descendant combinator; `>` restricts to direct children.","`+` and `~` select siblings, not descendants.","Attribute selectors style what the markup already says.","`:where()` scores zero, which makes it right for defaults."],"nextUp":"Next: the Level 2 milestone."}'::jsonb
from public.lessons where slug = 'css-selectors';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What is the difference between `.card p` and `.card > p`?","Why pair `:hover` with `:focus-visible`?","When would you reach for `:where()`?"],"points":["`.card p` matches paragraphs at any depth inside `.card`; `.card > p` matches only direct children.","Because a hover-only style is invisible to anyone navigating by keyboard. `:focus-visible` gives them the same signal without showing a ring on every mouse click.","For base styles and resets that must be trivially overridable — it always contributes zero specificity, so nothing ever has to fight it."]}'::jsonb
from public.lessons where slug = 'css-selectors';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-selectors-guided', 1, 'guided'::public.exercise_kind, 'Target precisely',
       'Using no selector stronger than one class: make only the *direct* paragraph children of `.card` teal; make links whose `href` starts with `https` bold; and give links a visible style on both hover and keyboard focus.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Selectors</title>
    <style>
    </style>
  </head>
  <body>
    <div class="card">
      <p>Direct child.</p>
      <blockquote><p>Nested deeper.</p></blockquote>
      <a href="https://example.org">External link</a>
      <a href="about.html">Internal link</a>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Selectors</title>
    <style>
      .card > p { color: teal; }
      a[href^="https"] { font-weight: bold; }
      a:hover,
      a:focus-visible { text-decoration: underline; }
    </style>
  </head>
  <body>
    <div class="card">
      <p>Direct child.</p>
      <blockquote><p>Nested deeper.</p></blockquote>
      <a href="https://example.org">External link</a>
      <a href="about.html">Internal link</a>
    </div>
  </body>
</html>', ARRAY['The child combinator is a greater-than sign between the two parts.', 'Attribute "starts with" is written [href^="https"].', 'Put the hover and focus-visible selectors in one comma-separated rule.']::text[],
       50, 3,
       (select id from public.skills where slug = 'selectors'), false
from public.lessons l where l.slug = 'css-selectors'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.card > p', 'color',
       'teal', NULL, NULL, NULL,
       'Direct child paragraphs are teal', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-selectors-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_property_absent'::public.requirement_kind, 'blockquote p', 'color',
       NULL, NULL, NULL, NULL,
       'The nested paragraph is not targeted — the child combinator does not reach it', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-selectors-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, 'a[href^="https"]', 'font-weight',
       'bold', NULL, NULL, NULL,
       'External links are bold', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-selectors-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_declared'::public.requirement_kind, 'a:hover', 'text-decoration',
       NULL, NULL, NULL, NULL,
       'Links respond to hover', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-selectors-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-selectors'), NULL, 'q-css-child-combinator', 1, 'single'::public.question_kind,
        'What does the space in `.card p` mean?', 'Descendant — any `p` inside `.card`, at any depth.', (select id from public.skills where slug = 'selectors'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Nothing; it is ignored', false, NULL
from public.quiz_questions where slug = 'q-css-child-combinator';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Any descendant, at any depth', true, NULL
from public.quiz_questions where slug = 'q-css-child-combinator';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only direct children', false, NULL
from public.quiz_questions where slug = 'q-css-child-combinator';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The next sibling', false, NULL
from public.quiz_questions where slug = 'q-css-child-combinator';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-selectors'), NULL, 'q-css-where-zero-specificity', 2, 'single'::public.question_kind,
        'What makes `:where()` useful for a reset?', 'It always contributes zero specificity, so nothing ever has to fight it.', (select id from public.skills where slug = 'selectors'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It is faster to evaluate', false, NULL
from public.quiz_questions where slug = 'q-css-where-zero-specificity';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It always scores zero specificity', true, NULL
from public.quiz_questions where slug = 'q-css-where-zero-specificity';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It matches more elements than `:is()`', false, NULL
from public.quiz_questions where slug = 'q-css-where-zero-specificity';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It applies only to the first match', false, NULL
from public.quiz_questions where slug = 'q-css-where-zero-specificity';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-selectors'), NULL, 'q-css-focus-visible', 3, 'single'::public.question_kind,
        'Why style `:focus-visible` alongside `:hover`?', 'A hover-only style is invisible to anyone navigating with a keyboard.', (select id from public.skills where slug = 'selectors'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It is required for the selector to be valid', false, NULL
from public.quiz_questions where slug = 'q-css-focus-visible';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Otherwise keyboard users get no feedback at all', true, NULL
from public.quiz_questions where slug = 'q-css-focus-visible';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Because `:hover` does not work on links', false, NULL
from public.quiz_questions where slug = 'q-css-focus-visible';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'To make the style apply faster', false, NULL
from public.quiz_questions where slug = 'q-css-focus-visible';
-- lesson: Milestone: size a card component
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-box-milestone', 3, 'Milestone: size a card component', 'Predictable boxes, precise selectors', 'Build a card that measures exactly what it says, with selectors no stronger than they need to be.',
       ARRAY['Apply border-box sizing project-wide', 'Size and space a component predictably', 'Keep every selector to one class']::text[], 20, 40, (select id from public.skills where slug = 'box-model'), 0.8
from public.modules m where m.slug = 'css-boxes'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Build a component with predictable dimensions","Use padding and margin for their correct purposes","Keep specificity flat"]}'::jsonb
from public.lessons where slug = 'css-box-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'checklist'::public.block_type, 'Before you call a component sized', NULL,
       NULL, NULL, NULL, '{"items":["`border-box` applied to everything, once","Padding for internal space, margin for external","Borders written with a style, not just a width","No selector stronger than a single class","Vertical rhythm not relying on collapsed margins you did not intend"]}'::jsonb
from public.lessons where slug = 'css-box-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'recall'::public.block_type, 'From memory', 'From memory: what are the four layers of the box model, what does `width` measure in each sizing model, and what happens to two adjacent vertical margins?',
       NULL, NULL, NULL, '{"points":["Content, padding, border, margin — outward from the middle.","`content-box`: `width` is the content only, and padding and border are added outside it. `border-box`: `width` is the whole visible box, and padding and border come out of it.","They collapse to the larger of the two rather than adding up. This stops entirely inside a flex or grid container."]}'::jsonb
from public.lessons where slug = 'css-box-milestone';

commit;
