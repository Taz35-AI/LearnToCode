-- HTML Hero — course seed, part 6 of 7
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 5 first.

begin;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'comparison'::public.block_type, 'A typical repair, before and after', NULL,
       NULL, NULL, NULL, '{"good":{"label":"After","code":"<label for=\"email\">Email address</label>\n<input type=\"email\" id=\"email\" name=\"email\"\n       autocomplete=\"email\" required>","why":"Announced as \"Email address, edit text\". Clicking the words focuses the field. Autofill works."},"bad":{"label":"Before","code":"<input type=\"text\" placeholder=\"Email\">","why":"Announced as \"edit text\" with no clue what it wants. The placeholder disappears on typing, and there is no autofill."}}'::jsonb
from public.lessons where slug = 'accessibility-audit-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'The highest-impact repairs, in order', NULL,
       '<!-- The five repairs that fix the most, fastest -->
<html lang="en">                          <!-- 1. declare the language -->
<title>Book a bike — Riverside</title>     <!-- 2. a unique page title -->
<a class="skip-link" href="#main">…</a>    <!-- 3. a skip link -->
<main id="main">…</main>                   <!-- 4. one main landmark -->
<label for="x">…</label><input id="x">     <!-- 5. label every control -->', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'accessibility-audit-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Audit systematically, structure first.","Almost every fix is a correct HTML element rather than an ARIA attribute.","The keyboard test is your final check."],"nextUp":"Level 9 next: metadata, SEO and discoverability."}'::jsonb
from public.lessons where slug = 'accessibility-audit-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'a11y-audit-milestone', 1, 'challenge'::public.exercise_kind, 'Milestone: repair the inaccessible page',
       'This page has around fifteen accessibility failures. Repair all of them. The content must stay the same — only the markup changes.', '<html>
<head>
  <meta charset="utf-8">
</head>
<body>
  <div class="header">
    <div class="nav">
      <a href="index.html">Home</a>
      <a href="routes.html">Routes</a>
      <a href="contact.html">Contact</a>
    </div>
  </div>

  <div class="content">
    <div class="big-title">Book a bike</div>

    <h3>Choose your route</h3>
    <img src="/learning-media/images/forest-path.jpg" width="1200" height="800">

    <p>For route details <a href="routes.html">click here</a>.</p>

    <form action="/booking" method="post">
      <input type="text" id="name" placeholder="Your name">
      <input type="text" id="name" placeholder="Your email">
      <div class="submit" onclick="send()">Send</div>
    </form>

    <iframe src="https://example.org/map" width="600" height="400"></iframe>
  </div>

  <div class="footer">© 2026 Riverside Cycle Hire</div>
</body>
</html>', '<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Book a bike — Riverside Cycle Hire</title>
</head>
<body>
  <a class="skip-link" href="#main">Skip to main content</a>

  <header>
    <nav aria-label="Main">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="routes.html">Routes</a></li>
        <li><a href="contact.html" aria-current="page">Contact</a></li>
      </ul>
    </nav>
  </header>

  <main id="main">
    <h1>Book a bike</h1>

    <h2>Choose your route</h2>
    <img src="/learning-media/images/forest-path.jpg"
         alt="A sandy path winding between tall trees in a sunlit forest"
         width="1200" height="800">

    <p>Read our <a href="routes.html">full route descriptions</a>.</p>

    <form action="/booking" method="post">
      <label for="name">Your name</label>
      <input type="text" id="name" name="name" autocomplete="name" required>

      <label for="email">Your email</label>
      <input type="email" id="email" name="email" autocomplete="email" required>

      <button type="submit">Send</button>
    </form>

    <iframe src="https://example.org/map"
            title="Map showing the workshop on Mill Lane"
            width="600" height="400" loading="lazy"
            sandbox="allow-scripts"></iframe>
  </main>

  <footer>
    <p>© 2026 Riverside Cycle Hire</p>
  </footer>
</body>
</html>', ARRAY['Start at the top: the doctype is missing, and <html> has no lang.', 'There is no <title>. Every page needs one.', 'The divs should be landmarks: header, nav, main, footer. Add a skip link targeting main.', 'The "big-title" div is really the h1, which means the h3 below it should be an h2.', 'The image has no alt, the link says "click here", and both inputs share the id "name".', 'The submit div should be a <button type="submit">, and each input needs a real label.', 'The iframe has no title.']::text[],
       180, 5,
       (select id from public.skills where slug = 'accessibility'), false
from public.lessons l where l.slug = 'accessibility-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'html', 'lang',
       NULL, NULL, NULL, NULL,
       'The html element declares a language', 'Add lang="en".', 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The document has a doctype', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has a title', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'text_not_empty'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The title is not empty', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'There is a header landmark', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main landmark', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'There is a footer landmark', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'element_present'::public.requirement_kind, 'nav', NULL,
       NULL, NULL, NULL, NULL,
       'The navigation uses a nav element', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'There is a skip link targeting main', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one h1', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'The image has meaningful alt text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'Every form control has a label', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 15, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 16, 'element_present'::public.requirement_kind, 'button[type="submit"]', NULL,
       NULL, NULL, NULL, NULL,
       'The submit control is a real button', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 17, 'element_count'::public.requirement_kind, '[onclick]', NULL,
       NULL, NULL, 0, 0,
       'No inline click handlers on non-interactive elements', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 18, 'attribute_present'::public.requirement_kind, 'iframe', 'title',
       NULL, NULL, NULL, NULL,
       'The iframe has a title', NULL, 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 19, 'element_absent'::public.requirement_kind, 'a[href="routes.html"] ~ *', NULL,
       NULL, NULL, NULL, NULL,
       'Link text describes its destination', 'Replace "click here" with text describing where the link goes.', 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 20, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'a11y-audit-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'a11y-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: audit your own site',
       'Run the audit checklist over one of your capstone pages and fix everything it turns up. Then Tab through it: every interactive element reachable, focus always visible, order matching the layout.', '<!DOCTYPE html>
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
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Your page heading</h1>
      <!-- Check every image, link, control and heading below -->
    </main>
    <footer>
      <p>© 2026 Your site</p>
    </footer>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About us — Riverside Cycle Hire</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html" aria-current="page">About</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>About us</h1>
      <p>We have hired bikes from Mill Lane since 1998.</p>
      <h2>Our workshop</h2>
      <img src="/learning-media/images/workshop-tools-1200.jpg"
           alt="Hand tools hanging in rows above a workbench"
           loading="lazy" width="1200" height="800">
      <p>Read our <a href="prices.html">current hire prices</a>.</p>
    </main>
    <footer>
      <p>© 2026 Riverside Cycle Hire</p>
    </footer>
  </body>
</html>', ARRAY['Work down the audit checklist item by item.', 'Mark the current page with aria-current="page" in the nav.', 'Check every image has appropriate alt text and every link makes sense alone.']::text[],
       110, 4,
       (select id from public.skills where slug = 'accessibility'), false
from public.lessons l where l.slug = 'accessibility-audit-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'html', 'lang',
       NULL, NULL, NULL, NULL,
       'The page declares its language', NULL, 1, true
from public.exercises e where e.slug = 'a11y-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true
from public.exercises e where e.slug = 'a11y-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'The skip link is present', NULL, 1, true
from public.exercises e where e.slug = 'a11y-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is one main landmark', NULL, 1, true
from public.exercises e where e.slug = 'a11y-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'There is a header', NULL, 1, true
from public.exercises e where e.slug = 'a11y-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'There is a footer', NULL, 1, true
from public.exercises e where e.slug = 'a11y-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'Exactly one h1', NULL, 1, true
from public.exercises e where e.slug = 'a11y-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'a11y-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Images have appropriate alt text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'a11y-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'accessible_name'::public.requirement_kind, 'a', NULL,
       NULL, NULL, NULL, NULL,
       'Every link has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'a11y-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'a11y-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'accessibility-audit-milestone'), NULL, 'q-audit-order', 1, 'single'::public.question_kind,
        'Which failure has the greatest impact on a screen-reader user?', 'Missing landmarks force the user to read from the top of every page, every time. That is a structural failure affecting every visit.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'No landmarks, so there is no way to skip to the content', true, NULL
from public.quiz_questions where slug = 'q-audit-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Alt text that is slightly too wordy', false, NULL
from public.quiz_questions where slug = 'q-audit-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A missing meta description', false, NULL
from public.quiz_questions where slug = 'q-audit-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A heading styled at the wrong size', false, NULL
from public.quiz_questions where slug = 'q-audit-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'accessibility-audit-milestone'), NULL, 'q-duplicate-id-impact', 2, 'single'::public.question_kind,
        'Why do duplicate ids break accessibility?', 'Relationships like `for`, `aria-labelledby` and `aria-describedby` resolve to the first match, so a label may connect to the wrong control.', (select id from public.skills where slug = 'validation'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Screen readers skip both elements', false, NULL
from public.quiz_questions where slug = 'q-duplicate-id-impact';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It only affects CSS', false, NULL
from public.quiz_questions where slug = 'q-duplicate-id-impact';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Label and description relationships resolve to the wrong element', true, NULL
from public.quiz_questions where slug = 'q-duplicate-id-impact';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The page will not render', false, NULL
from public.quiz_questions where slug = 'q-duplicate-id-impact';
-- Level 8 milestone: Accessibility Champion questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-8-milestone'), 'a8-q1', 1, 'single'::public.question_kind,
        'What are the four WCAG principles?', 'Perceivable, Operable, Understandable, Robust.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Semantic, Styled, Scripted, Secure', false, NULL
from public.quiz_questions where slug = 'a8-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Structure, Style, Behaviour, Content', false, NULL
from public.quiz_questions where slug = 'a8-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Perceivable, Operable, Understandable, Robust', true, NULL
from public.quiz_questions where slug = 'a8-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Visible, Clickable, Readable, Fast', false, NULL
from public.quiz_questions where slug = 'a8-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-8-milestone'), 'a8-q2', 2, 'single'::public.question_kind,
        'Which gives a keyboard user the most benefit on a site with a large menu?', 'A skip link, letting them bypass the menu on every page.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A sitemap page', false, NULL
from public.quiz_questions where slug = 'a8-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A skip link', true, NULL
from public.quiz_questions where slug = 'a8-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A larger font size', false, NULL
from public.quiz_questions where slug = 'a8-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'aria-label on every link', false, NULL
from public.quiz_questions where slug = 'a8-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-8-milestone'), 'a8-q3', 3, 'single'::public.question_kind,
        'What does `aria-describedby` do?', 'It attaches additional descriptive text, announced after the element''s name — ideal for format hints and error messages.', (select id from public.skills where slug = 'aria'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Attaches extra description read after the name', true, NULL
from public.quiz_questions where slug = 'a8-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Replaces the accessible name', false, NULL
from public.quiz_questions where slug = 'a8-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Hides the element from screen readers', false, NULL
from public.quiz_questions where slug = 'a8-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Marks the element as invalid', false, NULL
from public.quiz_questions where slug = 'a8-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-8-milestone'), 'a8-q4', 4, 'single'::public.question_kind,
        'When should you use `aria-hidden="true"`?', 'Only on genuinely decorative content that adds nothing — never on anything a user might need.', (select id from public.skills where slug = 'aria'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'On content that is visually hidden but still needed', false, NULL
from public.quiz_questions where slug = 'a8-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'On any element with an aria-label', false, NULL
from public.quiz_questions where slug = 'a8-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'On form fields that are not required', false, NULL
from public.quiz_questions where slug = 'a8-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'On purely decorative content', true, NULL
from public.quiz_questions where slug = 'a8-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-8-milestone'), 'a8-q5', 5, 'single'::public.question_kind,
        'An icon-only button contains an `<img>`. Where should the accessible name come from?', '`aria-label` on the button, with `alt=""` on the image so the name is not announced twice.', (select id from public.skills where slug = 'aria'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A title attribute on the button', false, NULL
from public.quiz_questions where slug = 'a8-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Both the alt and an aria-label, to be safe', false, NULL
from public.quiz_questions where slug = 'a8-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'aria-label on the button, with alt="" on the image', true, NULL
from public.quiz_questions where slug = 'a8-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Alt text on the image, with no aria-label', false, NULL
from public.quiz_questions where slug = 'a8-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-8-milestone'), 'a8-q6', 6, 'single'::public.question_kind,
        'What makes an error message accessible?', 'Plain words, a stated fix, connection to the field with `aria-describedby`, and an announcement when it appears.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A summary at the bottom of the page', false, NULL
from public.quiz_questions where slug = 'a8-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Plain words, a fix, aria-describedby, and an announcement', true, NULL
from public.quiz_questions where slug = 'a8-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Red text and a warning icon', false, NULL
from public.quiz_questions where slug = 'a8-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A tooltip on the field', false, NULL
from public.quiz_questions where slug = 'a8-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-8-milestone'), 'a8-q7', 7, 'single'::public.question_kind,
        'Does adding `role="navigation"` to a `<nav>` improve anything?', 'No — `<nav>` already has that role. The extra attribute is redundant noise.', (select id from public.skills where slug = 'aria'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'No — <nav> already has that role', true, NULL
from public.quiz_questions where slug = 'a8-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Yes, it improves older screen-reader support', false, NULL
from public.quiz_questions where slug = 'a8-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Yes, it is required by WCAG', false, NULL
from public.quiz_questions where slug = 'a8-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Yes, it makes the landmark focusable', false, NULL
from public.quiz_questions where slug = 'a8-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-8-milestone'), 'a8-q8', 8, 'single'::public.question_kind,
        'What determines keyboard focus order by default?', 'The order elements appear in the HTML source.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Their visual position on screen', false, NULL
from public.quiz_questions where slug = 'a8-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Their tabindex values, always', false, NULL
from public.quiz_questions where slug = 'a8-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Alphabetical order of their ids', false, NULL
from public.quiz_questions where slug = 'a8-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The order of elements in the HTML source', true, NULL
from public.quiz_questions where slug = 'a8-q8';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-8-milestone'), 'a8-q9', 9, 'single'::public.question_kind,
        'A page has an `<a>` with no `href`. What is the problem?', 'Without an `href` it is not a link: it cannot be focused with a keyboard and is not announced as a link.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It fails HTML validation', false, NULL
from public.quiz_questions where slug = 'a8-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nothing — href is optional', false, NULL
from public.quiz_questions where slug = 'a8-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is not focusable and not announced as a link', true, NULL
from public.quiz_questions where slug = 'a8-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It will not be styled as a link', false, NULL
from public.quiz_questions where slug = 'a8-q9';
-- --------------------------------------------------------------------------
-- Level 9: Metadata, SEO and Discoverability
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'metadata-and-seo', 9, 'Metadata, SEO and Discoverability', 'Everything in the head, and what it can honestly do',
       'The head of a document is invisible to visitors and enormously important to everything else — search engines, social networks, browsers and screen readers. This level covers what to put there and, just as importantly, what HTML can and cannot promise.', 'You can optimise a multi-page site for search engines, social sharing and structured data.', 'orange'
from public.courses c where c.slug = 'html-hero';
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-9-milestone', 'milestone'::public.assessment_kind, 'Level 9 milestone: Metadata, SEO and Discoverability', 'Eight questions on metadata, social sharing and structured data. Pass mark 75%.',
       0.75, 180, 9
from public.levels l where l.slug = 'metadata-and-seo';
-- module: Page metadata
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'page-metadata', 1, 'Page metadata', 'Titles, descriptions, canonical URLs, favicons, language and robots directives.',
       45, false
from public.levels l where l.slug = 'metadata-and-seo';
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'page-metadata' and p.slug = 'accessibility-foundations';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'page-metadata' and s.slug = 'metadata';
-- lesson: Titles, descriptions and canonical URLs
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'titles-descriptions-canonicals', 1, 'Titles, descriptions and canonical URLs', 'The three things every page needs and most pages get wrong', 'Your title is the most-read sentence you will write. It appears in tabs, bookmarks, search results and shared links.',
       ARRAY['Write a page title that works in all four places it appears', 'Write a meta description that earns a click', 'Use a canonical URL to prevent duplicate-content problems']::text[], 15, 40, (select id from public.skills where slug = 'metadata'), 0.7
from public.modules m where m.slug = 'page-metadata';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Write unique, descriptive titles for every page","Write meta descriptions of a useful length","Explain when a canonical URL is needed"]}'::jsonb
from public.lessons where slug = 'titles-descriptions-canonicals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Bike hire prices — Riverside Cycle Hire</title>
  <meta name="description"
        content="Hourly, daily and weekly bike hire from £6. Helmet, lock and route map included with every hire. Book online or call in.">
  <link rel="canonical" href="https://riverside-cycles.example/prices.html">
  <link rel="icon" href="/favicon.svg" type="image/svg+xml">
  <meta name="theme-color" content="#1d4ed8">
</head>', 'html', NULL, '{"annotations":[{"line":"2","text":"`charset` must be within the first 1024 bytes of the document, which in practice means first in the head. Browsers begin decoding before this point, so a late declaration means a restart."},{"line":"4","text":"The title: specific page name, an em dash, then the site name. Around 50–60 characters is the sweet spot before search engines truncate it. Put the distinctive part first — \"Bike hire prices\" is more useful at the start of a browser tab than the site name."},{"line":"5","text":"The description is not a ranking factor, but it is very often the text shown under your result. Around 150–160 characters, written as a promise of what the page contains."},{"line":"7","text":"`canonical` states the one true address for this page. If the same content is reachable at several URLs — with and without a trailing slash, with tracking parameters — this tells search engines which one to index."},{"line":"8","text":"An SVG favicon scales to every size and works in dark mode."},{"line":"9","text":"`theme-color` tints the browser interface on mobile. Small touch, noticeably more polished."}]}'::jsonb
from public.lessons where slug = 'titles-descriptions-canonicals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'comparison'::public.block_type, 'Titles that work and titles that do not', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Good","code":"<title>Bike hire prices — Riverside Cycle Hire</title>","why":"Specific, unique to this page, distinctive part first, and readable in a narrow browser tab."},"bad":{"label":"Poor","code":"<title>Riverside Cycle Hire | Bike Hire | Cycling | Hexford | Home</title>","why":"Keyword stuffing. Truncated in results, useless in a tab, and identical across pages if the site does this everywhere."}}'::jsonb
from public.lessons where slug = 'titles-descriptions-canonicals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'The same title on every page', 'The commonest metadata failure. If every page says "Riverside Cycle Hire", then a visitor with eight tabs open cannot tell them apart, bookmarks are meaningless, and search engines have nothing distinguishing to show. Every page needs its own title — and its own description.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'titles-descriptions-canonicals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'Robots meta', '`<meta name="robots" content="noindex">` asks search engines not to index a page. Useful for thank-you pages, staging sites and internal search results — and a serious accident if it ends up on a live homepage.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'titles-descriptions-canonicals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, 'Robots directives', NULL,
       '<meta name="robots" content="index, follow">     the default; usually unnecessary
<meta name="robots" content="noindex, follow">   do not index this page
<meta name="robots" content="noindex, nofollow"> do not index, do not follow its links', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'titles-descriptions-canonicals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'A robots meta tag is a request, not a control', 'Well-behaved crawlers obey it. It is not access control, and it does not hide anything: the page is still public, and anyone with the URL can read it. If something must not be seen, it needs authentication, not a meta tag.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'titles-descriptions-canonicals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'progressive_detail'::public.block_type, 'Language metadata beyond `lang`', '`<html lang="en">` declares the page language. Add `lang` on any element whose content is in a different language — `<span lang="fr">bon appétit</span>` — and a screen reader switches pronunciation for that phrase. For a site with several language versions, `<link rel="alternate" hreflang="fr" href="…">` tells search engines which version to show to whom. `lang="en-GB"` versus `lang="en-US"` also affects hyphenation and spell-checking.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'titles-descriptions-canonicals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'checklist'::public.block_type, 'Every page in your site needs', NULL,
       NULL, NULL, NULL, '{"items":["`<meta charset=\"utf-8\">` first in the head","A viewport meta tag","A unique, specific `<title>`","A unique `<meta name=\"description\">`","A `<link rel=\"canonical\">` on a live site","A favicon","`lang` on the `<html>` element"]}'::jsonb
from public.lessons where slug = 'titles-descriptions-canonicals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Titles appear in tabs, bookmarks, search results and shares — make each one unique and specific.","Descriptions are not a ranking factor but usually become your search snippet.","Canonical URLs resolve duplicate-content ambiguity.","A robots meta tag is a polite request, never a security measure."],"nextUp":"Next: social sharing metadata and structured data."}'::jsonb
from public.lessons where slug = 'titles-descriptions-canonicals';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'metadata-guided', 1, 'guided'::public.exercise_kind, 'Complete a page head',
       'Add the missing metadata: a unique title, a meta description, a canonical URL of `https://riverside-cycles.example/prices.html`, and a favicon link.', '<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>', '<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Bike hire prices — Riverside Cycle Hire</title>
  <meta name="description"
        content="Hourly, daily and weekly bike hire from £6. Helmet, lock and route map included with every hire.">
  <link rel="canonical" href="https://riverside-cycles.example/prices.html">
  <link rel="icon" href="/favicon.svg" type="image/svg+xml">
</head>', ARRAY['The title should name this page first, then the site.', 'The description goes in a <meta name="description" content="…"> tag.', 'The canonical is a <link rel="canonical" href="…">.']::text[],
       45, 2,
       (select id from public.skills where slug = 'metadata'), false
from public.lessons l where l.slug = 'titles-descriptions-canonicals';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one title', NULL, 1, true
from public.exercises e where e.slug = 'metadata-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'text_not_empty'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The title has text', NULL, 1, true
from public.exercises e where e.slug = 'metadata-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'meta[name="description"]', 'content',
       NULL, NULL, NULL, NULL,
       'There is a meta description with content', NULL, 1, true
from public.exercises e where e.slug = 'metadata-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'link[rel="canonical"]', 'href',
       'https://riverside-cycles.example/prices.html', NULL, NULL, NULL,
       'The canonical URL is set', NULL, 1, true
from public.exercises e where e.slug = 'metadata-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'link[rel="icon"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a favicon link', NULL, 1, true
from public.exercises e where e.slug = 'metadata-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'metadata-debug', 2, 'debug'::public.exercise_kind, 'Metadata that will cost you traffic',
       'This head has four problems: the charset is not first, the title is generic and duplicated across the site, the description is far too long, and a `noindex` has been left on a page that should be indexed. Fix all four.', '<head>
  <title>Riverside Cycle Hire</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="robots" content="noindex, nofollow">
  <meta name="description" content="Riverside Cycle Hire is a bike hire company based in Hexford offering bike hire, cycle hire, bicycle rental, bike rental, cycling equipment, helmets, locks, route maps, guided rides, repairs, servicing, accessories, and much more for everyone in the whole of the surrounding area and beyond, seven days a week, all year round.">
</head>', '<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Bike hire prices — Riverside Cycle Hire</title>
  <meta name="description"
        content="Hourly, daily and weekly bike hire from £6. Helmet, lock and route map included with every hire.">
</head>', ARRAY['The charset meta tag must come first in the head.', 'Make the title specific to this page, not just the company name.', 'Cut the description to roughly 150 characters of useful, readable prose.', 'Delete the robots noindex — this page should be indexed.']::text[],
       55, 3,
       (select id from public.skills where slug = 'metadata'), false
from public.lessons l where l.slug = 'titles-descriptions-canonicals';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'direct_child'::public.requirement_kind, 'meta[charset]', NULL,
       NULL, 'head', NULL, NULL,
       'The charset meta tag is in the head', NULL, 1, true
from public.exercises e where e.slug = 'metadata-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'text_not_empty'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The title has text', NULL, 1, true
from public.exercises e where e.slug = 'metadata-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'meta[name="robots"][content*="noindex"]', NULL,
       NULL, NULL, 0, 0,
       'The noindex directive has been removed', NULL, 1, true
from public.exercises e where e.slug = 'metadata-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'meta[name="description"]', 'content',
       NULL, NULL, NULL, NULL,
       'A meta description is present', NULL, 1, true
from public.exercises e where e.slug = 'metadata-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_matches'::public.requirement_kind, 'meta[name="description"]', 'content',
       '^.{40,200}$', NULL, NULL, NULL,
       'The description is a useful length, roughly 150 characters', 'Aim for one or two clear sentences.', 1, true
from public.exercises e where e.slug = 'metadata-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'titles-descriptions-canonicals'), NULL, 'q-title-length', 1, 'single'::public.question_kind,
        'Roughly how long should a page title be?', 'About 50–60 characters, before search engines truncate it. Put the distinctive part first.', (select id from public.skills where slug = 'seo'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Exactly 160 characters', false, NULL
from public.quiz_questions where slug = 'q-title-length';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'About 50–60 characters', true, NULL
from public.quiz_questions where slug = 'q-title-length';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'As long as possible, for keywords', false, NULL
from public.quiz_questions where slug = 'q-title-length';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Under 20 characters', false, NULL
from public.quiz_questions where slug = 'q-title-length';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'titles-descriptions-canonicals'), NULL, 'q-canonical', 2, 'single'::public.question_kind,
        'What does `<link rel="canonical">` do?', 'It states the preferred URL for a page, resolving ambiguity when the same content is reachable at several addresses.', (select id from public.skills where slug = 'seo'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'States the one preferred URL for this content', true, NULL
from public.quiz_questions where slug = 'q-canonical';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Redirects visitors to another page', false, NULL
from public.quiz_questions where slug = 'q-canonical';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Prevents the page being indexed', false, NULL
from public.quiz_questions where slug = 'q-canonical';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Sets the page language', false, NULL
from public.quiz_questions where slug = 'q-canonical';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'titles-descriptions-canonicals'), NULL, 'q-noindex-security', 3, 'single'::public.question_kind,
        'Does `<meta name="robots" content="noindex">` hide a page?', 'No. It asks well-behaved crawlers not to index it. The page remains fully public to anyone with the URL.', (select id from public.skills where slug = 'security'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'No — the page is still public to anyone with the URL', true, NULL
from public.quiz_questions where slug = 'q-noindex-security';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Yes, it requires a password', false, NULL
from public.quiz_questions where slug = 'q-noindex-security';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Yes, it blocks all access', false, NULL
from public.quiz_questions where slug = 'q-noindex-security';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only for logged-out visitors', false, NULL
from public.quiz_questions where slug = 'q-noindex-security';
-- lesson: Social sharing and structured data
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'social-and-structured-data', 2, 'Social sharing and structured data', 'Open Graph, and describing your content to machines with JSON-LD', 'What appears when someone pastes your link into a message, and how to tell a search engine what your page actually is.',
       ARRAY['Add Open Graph metadata for social sharing', 'Write a basic JSON-LD structured-data block', 'State honestly what structured data can and cannot achieve']::text[], 15, 40, (select id from public.skills where slug = 'structured-data'), 0.7
from public.modules m where m.slug = 'page-metadata';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Add the four Open Graph properties that matter","Write valid JSON-LD for a common schema type","Explain the honest limits of SEO markup"]}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'When a link is pasted into a chat app, a social network or a messaging thread, the software fetches the page and looks for Open Graph tags to build a preview card. Without them, it guesses — usually badly.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<meta property="og:title" content="Bike hire prices — Riverside Cycle Hire">
<meta property="og:description" content="Hourly, daily and weekly hire from £6, helmet and lock included.">
<meta property="og:image" content="https://riverside-cycles.example/images/hero-1200.jpg">
<meta property="og:image:alt" content="A blue hybrid bike outside the Mill Lane workshop">
<meta property="og:url" content="https://riverside-cycles.example/prices.html">
<meta property="og:type" content="website">
<meta name="twitter:card" content="summary_large_image">', 'html', NULL, '{"annotations":[{"line":"1","text":"Note `property`, not `name`. Open Graph uses a different attribute from standard meta tags — a very common mistake."},{"line":"3","text":"The image must be an absolute URL. A relative path will not work, because the software fetching it has no page context."},{"line":"4","text":"`og:image:alt` describes the preview image. Frequently omitted, and it is the accessible name of the card for anyone using a screen reader on the platform showing it."},{"line":"7","text":"`twitter:card` uses `name` rather than `property`, because it is not part of Open Graph. Yes, this is inconsistent."}]}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Recommended image size', '1200 × 630 pixels is the widely accepted standard for a large preview card. Anything much smaller is rendered as a small thumbnail beside the text instead.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'Structured data', 'Machine-readable facts about your page, written in a standard vocabulary so software can understand what the page describes rather than merely what words it contains.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'term'::public.block_type, 'JSON-LD', 'The recommended format for structured data: a block of JSON inside a `<script type="application/ld+json">` tag. It sits separately from your visible markup, so it does not tangle with your HTML.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'code_example'::public.block_type, 'JSON-LD describing a local business', NULL,
       '<script type="application/ld+json">
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
</script>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'callout'::public.block_type, 'This is the one script tag this course uses', 'A `<script type="application/ld+json">` block contains data, not code. Browsers do not execute it; it is simply a container the parser skips over. It is the single exception to "this course does not use script tags", and it is why the exception exists.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'code_example'::public.block_type, 'The schema types worth knowing', NULL,
       'LocalBusiness   a shop, restaurant, service — address, hours, phone
Organization    a company or charity
Person          an individual — for a portfolio or author page
Article         a news item or blog post — headline, author, date
Product         name, description, price, availability
Event           name, start date, location
BreadcrumbList  the trail of pages leading to this one
FAQPage         a set of questions and answers', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'callout'::public.block_type, 'What structured data cannot do', 'It does not raise your ranking. What it can do is make your result *look* different — star ratings, opening hours, event dates, an FAQ dropdown in the results page — which affects how many people click. It must also describe content that is genuinely on the page: marking up reviews that do not exist is a policy violation and gets sites penalised. Describe what is there, accurately.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'The honest limits of on-page SEO', 'HTML can make your content understandable, crawlable and shareable. It cannot make it *good*, and it cannot make it rank. Rankings depend overwhelmingly on the quality and relevance of your content, on how many other sites reference it, and on how fast and usable your pages are. Anyone who tells you a particular meta tag guarantees a position is selling something. What is genuinely in your control: unique titles and descriptions, a clear heading structure, descriptive links, real alt text, fast-loading pages, and accurate structured data. That is the whole honest list.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Open Graph uses `property`, needs absolute image URLs, and wants a 1200×630 image.","JSON-LD describes your content to machines in a standard vocabulary.","Structured data changes how your result *looks*, not where it ranks.","Only ever describe content that is genuinely on the page."],"nextUp":"Next: the Level 9 milestone."}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'og-guided', 1, 'guided'::public.exercise_kind, 'Add social sharing metadata',
       'Add Open Graph tags for title, description, image (absolute URL), image alt, url and type, plus a Twitter card tag.', '<head>
  <meta charset="utf-8">
  <title>Bike hire prices — Riverside Cycle Hire</title>
  <meta name="description" content="Hourly, daily and weekly hire from £6.">
</head>', '<head>
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
</head>', ARRAY['Open Graph tags use property="og:…", not name.', 'The og:image must be a full absolute URL beginning https://.', 'The twitter:card tag uses name, not property.']::text[],
       50, 3,
       (select id from public.skills where slug = 'seo'), false
from public.lessons l where l.slug = 'social-and-structured-data';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'meta[property="og:title"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is an og:title', NULL, 1, true
from public.exercises e where e.slug = 'og-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_present'::public.requirement_kind, 'meta[property="og:description"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is an og:description', NULL, 1, true
from public.exercises e where e.slug = 'og-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_matches'::public.requirement_kind, 'meta[property="og:image"]', 'content',
       '^https?://', NULL, NULL, NULL,
       'The og:image is an absolute URL', NULL, 1, true
from public.exercises e where e.slug = 'og-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'meta[property="og:image:alt"]', NULL,
       NULL, NULL, NULL, NULL,
       'The preview image has alt text', NULL, 1, true
from public.exercises e where e.slug = 'og-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'meta[property="og:url"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is an og:url', NULL, 1, true
from public.exercises e where e.slug = 'og-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_present'::public.requirement_kind, 'meta[name="twitter:card"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a Twitter card tag', NULL, 1, true
from public.exercises e where e.slug = 'og-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'jsonld-challenge', 2, 'challenge'::public.exercise_kind, 'Write structured data',
       'Add a JSON-LD block describing a LocalBusiness with a name, description, url, telephone and a nested PostalAddress. The details are yours; the shape is what is checked.', '<head>
  <meta charset="utf-8">
  <title>Riverside Cycle Hire — bike hire in the Hexford valley</title>
</head>', '<head>
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
</head>', ARRAY['The block goes inside <script type="application/ld+json">…</script>.', 'Every JSON-LD block starts with "@context": "https://schema.org" and an "@type".', 'The address is a nested object with its own "@type": "PostalAddress".']::text[],
       60, 4,
       (select id from public.skills where slug = 'structured-data'), false
from public.lessons l where l.slug = 'social-and-structured-data';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'script', 'type',
       'application/ld+json', NULL, NULL, NULL,
       'There is a JSON-LD script block', NULL, 1, true
from public.exercises e where e.slug = 'jsonld-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'text_content'::public.requirement_kind, 'script[type="application/ld+json"]', NULL,
       'schema.org', NULL, NULL, NULL,
       'The block declares the schema.org context', NULL, 1, true
from public.exercises e where e.slug = 'jsonld-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'text_content'::public.requirement_kind, 'script[type="application/ld+json"]', NULL,
       '@type', NULL, NULL, NULL,
       'The block declares a type', NULL, 1, true
from public.exercises e where e.slug = 'jsonld-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'text_content'::public.requirement_kind, 'script[type="application/ld+json"]', NULL,
       'PostalAddress', NULL, NULL, NULL,
       'The block includes a nested postal address', NULL, 1, true
from public.exercises e where e.slug = 'jsonld-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'social-and-structured-data'), NULL, 'q-og-property', 1, 'single'::public.question_kind,
        'Which attribute do Open Graph tags use?', '`property`, not `name`. Using `name` for `og:` tags is one of the commonest mistakes in this area.', (select id from public.skills where slug = 'seo'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'rel', false, NULL
from public.quiz_questions where slug = 'q-og-property';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'itemprop', false, NULL
from public.quiz_questions where slug = 'q-og-property';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'property', true, NULL
from public.quiz_questions where slug = 'q-og-property';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'name', false, NULL
from public.quiz_questions where slug = 'q-og-property';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'social-and-structured-data'), NULL, 'q-structured-data-ranking', 2, 'single'::public.question_kind,
        'Does structured data improve your search ranking?', 'No. It can change how your result is *displayed* — rich snippets, star ratings, event dates — which affects clicks, not position.', (select id from public.skills where slug = 'structured-data'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Only when combined with Open Graph', false, NULL
from public.quiz_questions where slug = 'q-structured-data-ranking';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'No — it changes how the result looks, not where it ranks', true, NULL
from public.quiz_questions where slug = 'q-structured-data-ranking';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Yes, it is a direct ranking factor', false, NULL
from public.quiz_questions where slug = 'q-structured-data-ranking';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Yes, but only for local businesses', false, NULL
from public.quiz_questions where slug = 'q-structured-data-ranking';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'social-and-structured-data'), NULL, 'q-og-image-url', 3, 'single'::public.question_kind,
        'Why must `og:image` be an absolute URL?', 'The software building the preview fetches the image without your page as context, so a relative path cannot be resolved.', (select id from public.skills where slug = 'seo'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The service fetching it has no page context to resolve a relative path', true, NULL
from public.quiz_questions where slug = 'q-og-image-url';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Relative paths are invalid in meta tags', false, NULL
from public.quiz_questions where slug = 'q-og-image-url';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Absolute URLs load faster', false, NULL
from public.quiz_questions where slug = 'q-og-image-url';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is only required for images over 1MB', false, NULL
from public.quiz_questions where slug = 'q-og-image-url';
-- lesson: Milestone: optimise a page for discovery
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'seo-milestone', 3, 'Milestone: optimise a page for discovery', 'Every metadata decision on one page', 'A complete, discoverable, shareable page head plus a correctly structured body.',
       ARRAY['Build a complete production-quality document head', 'Add social metadata and structured data', 'Apply the same to your capstone site']::text[], 22, 40, (select id from public.skills where slug = 'seo'), 0.8
from public.modules m where m.slug = 'page-metadata';
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
from public.lessons l where l.slug = 'seo-milestone';
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
from public.lessons l where l.slug = 'seo-milestone';
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
        'Why must `<meta charset>` come first in the head?', 'The browser must know the encoding within the first 1024 bytes. A late declaration forces it to restart parsing.', (select id from public.skills where slug = 'metadata'), 10);
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
        'Which appears in browser tabs, bookmarks and search results?', 'The `<title>` element.', (select id from public.skills where slug = 'metadata'), 10);
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
        'Is the meta description a ranking factor?', 'No, but it is usually the text shown under your result, which affects clicks.', (select id from public.skills where slug = 'seo'), 10);
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
        'Which format does Google recommend for structured data?', 'JSON-LD, in a `<script type="application/ld+json">` block.', (select id from public.skills where slug = 'structured-data'), 10);
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
        'What size should an Open Graph image be?', '1200 × 630 pixels is the accepted standard for a large preview card.', (select id from public.skills where slug = 'seo'), 10);
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
        'What must structured data describe?', 'Content genuinely present on the page. Marking up things that do not exist is a policy violation.', (select id from public.skills where slug = 'structured-data'), 10);
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
        'Why give every page its own title?', 'So visitors can tell tabs and bookmarks apart, and so search engines have something distinguishing to display.', (select id from public.skills where slug = 'seo'), 10);
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
        'What does `lang="fr"` on a `<span>` achieve?', 'A screen reader switches to French pronunciation for that phrase, instead of reading French words with English phonetics.', (select id from public.skills where slug = 'accessibility'), 10);
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
        'What can HTML alone honestly guarantee about search rankings?', 'Nothing. HTML makes content crawlable, understandable and shareable; ranking depends on content quality, links and page experience.', (select id from public.skills where slug = 'seo'), 10);
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
from public.courses c where c.slug = 'html-hero';
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-10-milestone', 'milestone'::public.assessment_kind, 'Level 10 milestone: Performance and Security', 'Eight questions on loading strategy and markup-level security. Pass mark 75%.',
       0.75, 190, 10
from public.levels l where l.slug = 'performance-and-security';
-- module: Performance-aware HTML
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'html-performance', 1, 'Performance-aware HTML', 'Dimensions, loading strategy, script loading, resource hints — and the honest limits of what markup controls.',
       45, false
from public.levels l where l.slug = 'performance-and-security';
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
from public.modules m where m.slug = 'html-performance';
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
from public.lessons l where l.slug = 'loading-strategy';
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
        'What causes layout shift when images load?', 'Without dimensions the browser cannot reserve space, so content below jumps when the image arrives.', (select id from public.skills where slug = 'performance'), 10);
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
        'What is the difference between `defer` and `async`?', '`defer` runs after parsing, in source order. `async` runs as soon as it downloads, in unpredictable order.', (select id from public.skills where slug = 'performance'), 10);
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
        'What happens if you preload ten resources?', 'Preload works by changing relative priority. Preloading everything restates the original order while pulling bandwidth forward.', (select id from public.skills where slug = 'performance'), 10);
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
from public.modules m where m.slug = 'html-performance';
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
from public.lessons l where l.slug = 'html-security';
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
        'What can a page opened with `target="_blank"` do without `noopener`?', 'It gets a reference back to the opening window and, in older browsers, can navigate it elsewhere — a phishing technique.', (select id from public.skills where slug = 'security'), 10);
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
        'Why must an API key never go in `<input type="hidden">`?', 'Its value is in the page source, visible to every visitor.', (select id from public.skills where slug = 'security'), 10);
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
        'Where is a Content Security Policy best delivered?', 'As an HTTP response header from the server. The meta-tag form is a weaker fallback.', (select id from public.skills where slug = 'security'), 10);
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
from public.modules m where m.slug = 'html-performance';
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
from public.lessons l where l.slug = 'performance-milestone';
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
from public.lessons l where l.slug = 'performance-milestone';
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
        'Why is `preload="auto"` on a video usually wrong?', 'It downloads the whole file before anyone presses play — potentially megabytes of a visitor''s mobile data for a video they never watch.', (select id from public.skills where slug = 'performance'), 10);
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
        'What do `width` and `height` on an `<img>` prevent?', 'Layout shift — content jumping as the image arrives.', (select id from public.skills where slug = 'performance'), 10);
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
        'Which script attribute is the right default?', '`defer`: downloads in parallel, runs after parsing, in source order.', (select id from public.skills where slug = 'performance'), 10);
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
        'What does `sandbox` with no value do to an iframe?', 'It removes essentially every capability; each `allow-` token restores one.', (select id from public.skills where slug = 'security'), 10);
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
        'Which referrer policy is a sensible default?', '`strict-origin-when-cross-origin` sends the full path to your own origin and only the bare origin to others.', (select id from public.skills where slug = 'security'), 10);
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
        'Can HTML validation attributes secure a form?', 'No. They are removable in two clicks, and a request can be sent without loading your page at all.', (select id from public.skills where slug = 'security'), 10);
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
        'When should you use `fetchpriority="high"`?', 'On the single most important asset, usually the hero image.', (select id from public.skills where slug = 'performance'), 10);
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
        'What is Subresource Integrity for?', 'It pins the exact contents of a third-party file, so the browser refuses to run it if it has changed.', (select id from public.skills where slug = 'security'), 10);
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
        'What is the biggest limitation of HTML for performance?', 'It cannot compress images, speed up a server, set caching headers or shrink a JavaScript bundle — the largest wins are elsewhere.', (select id from public.skills where slug = 'performance'), 10);
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
from public.courses c where c.slug = 'html-hero';
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-11-milestone', 'milestone'::public.assessment_kind, 'Level 11 milestone: Debugging and Validation Master', 'Seven questions on validation and debugging method. Pass mark 75%.',
       0.75, 180, 11
from public.levels l where l.slug = 'debugging-and-validation';
-- module: Validation and developer tools
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'validation-and-tools', 1, 'Validation and developer tools', 'What a validator checks, what it cannot check, and how to use the tools already in your browser.',
       45, false
from public.levels l where l.slug = 'debugging-and-validation';
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
from public.modules m where m.slug = 'validation-and-tools';

commit;
