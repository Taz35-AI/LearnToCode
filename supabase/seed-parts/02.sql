-- HTML Hero — course seed, part 2 of 10
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 1 first.

begin;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'comparison'::public.block_type, 'Nesting: correct and overlapping', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Correct","code":"<p>Open <strong>every morning</strong> at six.</p>","why":"`<strong>` is opened and closed entirely inside the paragraph."},"bad":{"label":"Overlapping — never valid","code":"<p>Open <strong>every morning</p></strong> at six.","why":"The paragraph is closed while `<strong>` is still open. Browsers guess at a repair, and every browser guesses differently."}}'::jsonb
from public.lessons where slug = 'nesting-and-the-document-tree';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'visual'::public.block_type, NULL, 'Every HTML page is a tree. One element at the root, branching downwards.',
       NULL, NULL, 'document-tree', '{}'::jsonb
from public.lessons where slug = 'nesting-and-the-document-tree';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'Nesting', 'Placing one element inside another. The inside element is called a child; the outside one is its parent.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'nesting-and-the-document-tree';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'term'::public.block_type, 'The DOM', 'Document Object Model. It is simply the name for this tree once the browser has built it in memory. When people say "inspect the DOM", they mean "look at the live tree".',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'nesting-and-the-document-tree';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'prose'::public.block_type, NULL, 'Because the structure is a tree, the way you lay out your code should show that tree. Every time you go one level deeper, indent by two spaces. This is not decoration — it is how you spot a missing closing tag with your eyes instead of with a checker.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'nesting-and-the-document-tree';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<article>
  <h2>Sourdough workshop</h2>
  <p>
    A three-hour session covering
    <strong>starter care</strong> and shaping.
  </p>
</article>', 'html', NULL, '{"annotations":[{"line":"1","text":"`<article>` opens at the far left — it is the outermost element here."},{"line":"2-5","text":"Its children are indented two spaces, showing they sit inside it."},{"line":"4","text":"The `<strong>` is a child of the paragraph, so it is indented again."},{"line":"6","text":"`</article>` lines up exactly with `<article>`. If the indentation of an opening and closing tag do not line up, something is wrong."}]}'::jsonb
from public.lessons where slug = 'nesting-and-the-document-tree';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'prose'::public.block_type, NULL, 'You can also leave notes for yourself in the file. Anything between `<!--` and `-->` is a comment: the browser ignores it completely, and it never appears on the page.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'nesting-and-the-document-tree';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'code_example'::public.block_type, 'A comment', NULL,
       '<!-- Opening hours are updated every Monday -->
<p>Open 6am to 2pm, Tuesday to Sunday.</p>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'nesting-and-the-document-tree';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'callout'::public.block_type, 'Comments are not private', 'Anyone can view the source of your page and read your comments. Never put passwords, personal information or unflattering remarks in them.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'nesting-and-the-document-tree';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'progressive_detail'::public.block_type, 'What browsers do with broken nesting', 'The HTML specification defines a detailed error-recovery algorithm, so a browser will always produce *something* from broken markup rather than showing an error. That sounds helpful, and it is — but the repair it chooses may not be the page you intended, and CSS and JavaScript written against the structure you meant will then fail in confusing ways. This is why the checker in this course reports overlapping tags as errors even though the preview still renders.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'nesting-and-the-document-tree';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'interactive_demo'::public.block_type, 'Nesting, correct and crossed', 'The same four tags, opened in the same order and closed in different ones.',
       NULL, NULL, NULL, '{"variants":[{"label":"Nested correctly","code":"<p>Baked <strong>every <em>single</em> morning</strong>.</p>","note":"Each element closes inside the one that contains it. The tree is unambiguous, and every browser agrees on it."},{"label":"Crossed over","code":"<p>Baked <strong>every <em>single</strong> morning</em>.</p>","note":"The strong closes while the em is still open. The browser repairs this silently, and the structure it invents may not be the one you meant."},{"label":"Never closed","code":"<p>Baked <strong>every single morning.</p>\n<p>Open seven days.</p>","note":"The strong is never closed, so the browser keeps it open — and the second paragraph is bold too."}]}'::jsonb
from public.lessons where slug = 'nesting-and-the-document-tree';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Elements nest inside one another and must close in reverse order.","The nested structure is a tree; the browser''s live copy of it is called the DOM.","Indent two spaces per level so a missing closing tag is visible at a glance.","Comments (`<!-- … -->`) are ignored by the browser but readable by anyone."],"nextUp":"Next: the skeleton every real HTML file needs."}'::jsonb
from public.lessons where slug = 'nesting-and-the-document-tree';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'nesting-guided', 1, 'guided'::public.exercise_kind, 'Nest a list correctly',
       'Build an unordered list (`<ul>`) containing exactly three list items (`<li>`), one for each of three services. Indent the items two spaces inside the list.', '<ul>

</ul>', '<ul>
  <li>Bike hire by the hour or day</li>
  <li>Guided river routes</li>
  <li>Repairs while you wait</li>
</ul>', ARRAY['Each item is its own element: <li>…</li>', 'All three <li> elements go between the <ul> and the </ul>.', 'Indent each <li> by two spaces so the nesting is visible.']::text[],
       30, 1,
       (select id from public.skills where slug = 'syntax'), false
from public.lessons l where l.slug = 'nesting-and-the-document-tree'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'ul', NULL,
       NULL, NULL, NULL, NULL,
       'There is an unordered list', NULL, 1, true
from public.exercises e where e.slug = 'nesting-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'ul > li', NULL,
       NULL, NULL, 3, 3,
       'The list has exactly three items', NULL, 1, true
from public.exercises e where e.slug = 'nesting-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'text_not_empty'::public.requirement_kind, 'li', NULL,
       NULL, NULL, NULL, NULL,
       'Every item has text', NULL, 1, true
from public.exercises e where e.slug = 'nesting-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'nesting-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'nesting-debug', 2, 'debug'::public.exercise_kind, 'Untangle the overlap',
       'The two elements below overlap instead of nesting. Rearrange the closing tags so `<em>` is fully inside the paragraph, keeping the words in the same order.', '<p>Booking is <em>strongly recommended</p></em> at weekends.', '<p>Booking is <em>strongly recommended</em> at weekends.</p>', ARRAY['Whichever element opened last must close first.', '<em> opened second, so </em> must come before </p>.', 'The word "at weekends" belongs inside the paragraph too, so </p> goes at the very end.']::text[],
       35, 2,
       (select id from public.skills where slug = 'validation'), false
from public.lessons l where l.slug = 'nesting-and-the-document-tree'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'p', NULL,
       NULL, NULL, NULL, NULL,
       'The paragraph exists', NULL, 1, true
from public.exercises e where e.slug = 'nesting-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'nesting'::public.requirement_kind, 'em', NULL,
       NULL, 'p', 1, NULL,
       'The emphasis is nested inside the paragraph', NULL, 1, true
from public.exercises e where e.slug = 'nesting-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'text_content'::public.requirement_kind, 'p', NULL,
       'at weekends', NULL, NULL, NULL,
       'All the text is inside the paragraph', NULL, 1, true
from public.exercises e where e.slug = 'nesting-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'nesting-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'nesting-and-the-document-tree'), NULL, 'q-nesting-order', 1, 'single'::public.question_kind,
        'Which of these is nested correctly?', 'The element opened last must be closed first. In the correct answer, `<strong>` opens and closes entirely inside the paragraph.', (select id from public.skills where slug = 'syntax'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<p>Open <strong>daily from six.</p>', false, NULL
from public.quiz_questions where slug = 'q-nesting-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<p>Open <strong>daily</strong> from six.</p>', true, NULL
from public.quiz_questions where slug = 'q-nesting-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<p>Open <strong>daily</p></strong> from six.', false, NULL
from public.quiz_questions where slug = 'q-nesting-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<strong><p>Open daily</strong> from six.</p>', false, NULL
from public.quiz_questions where slug = 'q-nesting-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'nesting-and-the-document-tree'), NULL, 'q-dom-meaning', 2, 'single'::public.question_kind,
        'What does "the DOM" refer to?', 'The DOM is the browser''s live, in-memory tree of your document. Your HTML file is the recipe; the DOM is the thing the browser actually built from it.', (select id from public.skills where slug = 'syntax'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The stylesheet that controls appearance', false, NULL
from public.quiz_questions where slug = 'q-dom-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The name of the browser''s address bar', false, NULL
from public.quiz_questions where slug = 'q-dom-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The tree of elements the browser builds from your HTML', true, NULL
from public.quiz_questions where slug = 'q-dom-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A file format for storing web pages', false, NULL
from public.quiz_questions where slug = 'q-dom-meaning';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'nesting-and-the-document-tree'), NULL, 'q-comments', 3, 'single'::public.question_kind,
        'Which statement about HTML comments is true?', 'Comments are stripped from what the browser displays, but they are still sent to every visitor and anyone can read them by viewing the page source.', (select id from public.skills where slug = 'syntax'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'They are invisible on the page but readable in the page source', true, NULL
from public.quiz_questions where slug = 'q-comments';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'They are removed before the file is sent to the browser', false, NULL
from public.quiz_questions where slug = 'q-comments';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'They are only visible to the site owner', false, NULL
from public.quiz_questions where slug = 'q-comments';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'They appear on the page in a smaller font', false, NULL
from public.quiz_questions where slug = 'q-comments';
-- module: The skeleton of every page
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'the-html-skeleton', 2, 'The skeleton of every page', 'The five things every real HTML file needs, why each one exists, and what breaks without them.',
       40, false
from public.levels l where l.slug = 'html-explorer'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'the-html-skeleton' and p.slug = 'how-the-web-works';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.5
from public.modules m, public.skills s
where m.slug = 'the-html-skeleton' and s.slug = 'document-structure';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.5
from public.modules m, public.skills s
where m.slug = 'the-html-skeleton' and s.slug = 'syntax';
-- lesson: Doctype, html, head and body
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'doctype-html-head-body', 1, 'Doctype, html, head and body', 'The frame that every page hangs on', 'Four lines that appear in every HTML file ever written. This lesson explains what each one is actually for.',
       ARRAY['Write the standard skeleton of an HTML document from memory', 'Explain what goes in the head and what goes in the body', 'Say what the doctype is for']::text[], 15, 40, (select id from public.skills where slug = 'document-structure'), 0.7
from public.modules m where m.slug = 'the-html-skeleton'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Write a complete HTML document skeleton without copying it","Decide correctly whether a piece of content belongs in the head or the body","Explain why the doctype must be the first line"]}'::jsonb
from public.lessons where slug = 'doctype-html-head-body';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'So far you have written fragments. A real HTML file needs a frame around them. Here is that frame, complete — then we will take it apart line by line.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'doctype-html-head-body';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Riverside Cycle Hire</title>
  </head>
  <body>
    <h1>Riverside Cycle Hire</h1>
    <p>Bikes, helmets and route maps, seven days a week.</p>
  </body>
</html>', 'html', NULL, '{"annotations":[{"line":"1","text":"`<!DOCTYPE html>` tells the browser to use modern HTML rules. It is not really a tag, and it takes no closing tag. Leave it out and browsers fall back to a twenty-year-old compatibility mode where sizes and layouts behave oddly. It must be the very first thing in the file."},{"line":"2","text":"`<html>` is the root element — everything else lives inside it. `lang=\"en\"` states the language, which lets screen readers use the right pronunciation and helps browsers offer translation."},{"line":"3-7","text":"`<head>` holds information *about* the page. Nothing in here is displayed in the page itself."},{"line":"4","text":"`<meta charset=\"utf-8\">` says which alphabet the file uses. UTF-8 covers essentially every character in every language. Without it, characters like é, £ and — turn into gibberish."},{"line":"5","text":"The viewport line tells phones to use their real width rather than pretending to be a desktop and shrinking everything. Without it your page arrives on a phone zoomed out and unreadable."},{"line":"6","text":"`<title>` is the text in the browser tab, the name used when someone bookmarks the page, and the headline in search results. Every page needs its own."},{"line":"8-11","text":"`<body>` holds everything a visitor actually sees: headings, text, images, links, forms."},{"line":"12","text":"`</html>` closes the root element and ends the document."}]}'::jsonb
from public.lessons where slug = 'doctype-html-head-body';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Head', 'The part of the document that describes the page: its title, its character set, its description. None of it appears on the page itself.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'doctype-html-head-body';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'Body', 'The part of the document that holds visible content.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'doctype-html-head-body';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'The classic beginner error', 'Putting a heading inside `<head>` because "the heading is at the head of the page". They are unrelated. `<head>` is for information *about* the page; `<h1>` is visible content and belongs in `<body>`.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'doctype-html-head-body';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'interactive_demo'::public.block_type, 'Head or body?', 'Both documents contain the same words. Only one shows them.',
       NULL, NULL, NULL, '{"variants":[{"label":"Correct — content in the body","code":"<!DOCTYPE html>\n<html lang=\"en\">\n  <head><title>Hours</title></head>\n  <body><h1>Opening hours</h1></body>\n</html>","note":"The heading appears on the page, and \"Hours\" appears in the browser tab."},{"label":"Wrong — content in the head","code":"<!DOCTYPE html>\n<html lang=\"en\">\n  <head><title>Hours</title><h1>Opening hours</h1></head>\n  <body></body>\n</html>","note":"The page is blank. The browser moves the stray heading out of the head, but you cannot rely on how."}]}'::jsonb
from public.lessons where slug = 'doctype-html-head-body';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'checklist'::public.block_type, 'Every page you write from now on has', NULL,
       NULL, NULL, NULL, '{"items":["`<!DOCTYPE html>` on line one","`<html lang=\"en\">` (or the correct language for your content)","`<meta charset=\"utf-8\">` as the first thing in the head","A viewport meta tag","A `<title>` that describes this particular page","All visible content inside `<body>`"]}'::jsonb
from public.lessons where slug = 'doctype-html-head-body';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["The doctype must be the first line, and switches the browser into modern mode.","`<html lang=\"…\">` wraps the whole document and states its language.","`<head>` describes the page; `<body>` holds what people see.","The charset and viewport meta tags are not optional in practice — pages break without them."],"nextUp":"Next: your first complete page, built from a blank file."}'::jsonb
from public.lessons where slug = 'doctype-html-head-body';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'skeleton-guided', 1, 'guided'::public.exercise_kind, 'Complete the skeleton',
       'Three pieces are missing from this document: the doctype, the character set meta tag and the title. Add all three in the right places.', '<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
  </head>
  <body>
    <h1>Harbour View Guesthouse</h1>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Harbour View Guesthouse</title>
  </head>
  <body>
    <h1>Harbour View Guesthouse</h1>
  </body>
</html>', ARRAY['The doctype goes above everything else, on its own line.', 'The charset meta tag should be the first element inside <head>.', 'The title element goes in the head too: <title>Harbour View Guesthouse</title>']::text[],
       40, 2,
       (select id from public.skills where slug = 'document-structure'), false
from public.lessons l where l.slug = 'doctype-html-head-body'
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
from public.exercises e where e.slug = 'skeleton-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'html', 'lang',
       'en', NULL, NULL, NULL,
       'The html element declares its language', NULL, 1, true
from public.exercises e where e.slug = 'skeleton-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'meta[charset]', 'charset',
       'utf-8', NULL, NULL, NULL,
       'The character set is declared as utf-8', NULL, 1, true
from public.exercises e where e.slug = 'skeleton-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'nesting'::public.requirement_kind, 'meta[charset]', NULL,
       NULL, 'head', 1, NULL,
       'The charset meta tag is inside the head', NULL, 1, true
from public.exercises e where e.slug = 'skeleton-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one title', NULL, 1, true
from public.exercises e where e.slug = 'skeleton-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'text_not_empty'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The title has text', NULL, 1, true
from public.exercises e where e.slug = 'skeleton-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'nesting'::public.requirement_kind, 'title', NULL,
       NULL, 'head', 1, NULL,
       'The title is inside the head', NULL, 1, true
from public.exercises e where e.slug = 'skeleton-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'body', 1, NULL,
       'The heading is inside the body', NULL, 1, true
from public.exercises e where e.slug = 'skeleton-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'skeleton-debug', 2, 'debug'::public.exercise_kind, 'Content in the wrong half',
       'This page renders blank. Two elements are in the head that belong in the body, and one element is in the body that belongs in the head. Move all three.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <h1>Northgate Dental</h1>
    <p>Accepting new patients.</p>
  </head>
  <body>
    <title>Northgate Dental</title>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Northgate Dental</title>
  </head>
  <body>
    <h1>Northgate Dental</h1>
    <p>Accepting new patients.</p>
  </body>
</html>', ARRAY['Visible content — headings and paragraphs — always goes in the body.', 'The title describes the page rather than being part of it, so it belongs in the head.', 'After moving them, the head should contain only the meta tag and the title.']::text[],
       35, 2,
       (select id from public.skills where slug = 'document-structure'), false
from public.lessons l where l.slug = 'doctype-html-head-body'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'body', 1, NULL,
       'The heading is in the body', NULL, 1, true
from public.exercises e where e.slug = 'skeleton-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'nesting'::public.requirement_kind, 'p', NULL,
       NULL, 'body', 1, NULL,
       'The paragraph is in the body', NULL, 1, true
from public.exercises e where e.slug = 'skeleton-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'nesting'::public.requirement_kind, 'title', NULL,
       NULL, 'head', 1, NULL,
       'The title is in the head', NULL, 1, true
from public.exercises e where e.slug = 'skeleton-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'head > h1', NULL,
       NULL, NULL, 0, 0,
       'No heading is left in the head', NULL, 1, true
from public.exercises e where e.slug = 'skeleton-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true
from public.exercises e where e.slug = 'skeleton-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'doctype-html-head-body'), NULL, 'q-doctype-purpose', 1, 'single'::public.question_kind,
        'What does `<!DOCTYPE html>` do?', 'It switches the browser into standards mode. Without it, browsers use a legacy compatibility mode where sizing and layout behave differently — a source of very confusing bugs.', (select id from public.skills where slug = 'document-structure'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Creates the html element', false, NULL
from public.quiz_questions where slug = 'q-doctype-purpose';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Tells the browser to use modern HTML rules', true, NULL
from public.quiz_questions where slug = 'q-doctype-purpose';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Loads the HTML language into the browser', false, NULL
from public.quiz_questions where slug = 'q-doctype-purpose';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Declares which version of your file this is', false, NULL
from public.quiz_questions where slug = 'q-doctype-purpose';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'doctype-html-head-body'), NULL, 'q-head-vs-body', 2, 'single'::public.question_kind,
        'Where does `<title>` belong?', 'The title describes the page rather than being part of its visible content, so it lives in the head. It appears in the browser tab, in bookmarks and in search results.', (select id from public.skills where slug = 'document-structure'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Inside <body>, at the top', false, NULL
from public.quiz_questions where slug = 'q-head-vs-body';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Immediately after <!DOCTYPE html>', false, NULL
from public.quiz_questions where slug = 'q-head-vs-body';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Anywhere in the document', false, NULL
from public.quiz_questions where slug = 'q-head-vs-body';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Inside <head>', true, NULL
from public.quiz_questions where slug = 'q-head-vs-body';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'doctype-html-head-body'), NULL, 'q-viewport', 3, 'single'::public.question_kind,
        'What goes wrong if you omit the viewport meta tag?', 'Phones default to pretending they are about 980 pixels wide and then shrink the result, so your page arrives zoomed out and the text is too small to read.', (select id from public.skills where slug = 'document-structure'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Images lose their aspect ratio', false, NULL
from public.quiz_questions where slug = 'q-viewport';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nothing — it only matters for printing', false, NULL
from public.quiz_questions where slug = 'q-viewport';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Phones render the page zoomed out and unreadably small', true, NULL
from public.quiz_questions where slug = 'q-viewport';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The page fails to load on mobile devices', false, NULL
from public.quiz_questions where slug = 'q-viewport';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'doctype-html-head-body'), NULL, 'q-charset', 4, 'single'::public.question_kind,
        'Why declare `<meta charset="utf-8">`?', 'It tells the browser which character encoding the file uses. UTF-8 covers virtually every writing system; without the declaration, accented and non-Latin characters can render as nonsense.', (select id from public.skills where slug = 'metadata'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'So characters like é, £ and — display correctly', true, NULL
from public.quiz_questions where slug = 'q-charset';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'To set the language of the page', false, NULL
from public.quiz_questions where slug = 'q-charset';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'To choose which font the browser uses', false, NULL
from public.quiz_questions where slug = 'q-charset';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'To compress the file before sending it', false, NULL
from public.quiz_questions where slug = 'q-charset';
-- lesson: Your first complete page
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'your-first-complete-page', 2, 'Your first complete page', 'Milestone: build it from nothing', 'No starter code, no copying. You will write a complete, valid HTML document from a blank editor — and it will be the first page of the website you finish this course with.',
       ARRAY['Write a valid HTML document from an empty file', 'Choose sensible content for a real page', 'Start the website you will build across the whole course']::text[], 20, 40, (select id from public.skills where slug = 'document-structure'), 0.8
from public.modules m where m.slug = 'the-html-skeleton'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Produce a complete, valid HTML document with no starter code","Explain every line you wrote","Create the first page of your capstone website"]}'::jsonb
from public.lessons where slug = 'your-first-complete-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'This is the first milestone of the course. Everything you need has been covered — the skeleton, headings, paragraphs, links and nesting. What is new is that the editor starts empty.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'your-first-complete-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'callout'::public.block_type, 'How to approach a blank file', 'Write the frame first and the content second. Doctype, html, head, body — then fill in. Almost every professional does exactly this, and most editors will expand a shortcut into the skeleton for you. Doing it by hand a few times is how it becomes automatic.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'your-first-complete-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'visual'::public.block_type, NULL, 'The shape you are aiming for, before you write a word of content.',
       NULL, NULL, 'document-tree', '{}'::jsonb
from public.lessons where slug = 'your-first-complete-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'The frame, before any content — write this from memory, then fill it in', NULL,
       '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
  </head>
  <body>

  </body>
</html>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'your-first-complete-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'prose'::public.block_type, NULL, 'You chose a project type when you signed up. The page you build here becomes the homepage of that project, and every module from now on will add something to it. By the end of the course this file will have grown into a complete, professional, multi-page website — built by you, one piece at a time.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'your-first-complete-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'checklist'::public.block_type, 'Your page must have', NULL,
       NULL, NULL, NULL, '{"items":["The doctype on the first line","`<html>` with a `lang` attribute","A head containing the charset meta tag, the viewport meta tag and a title","A body containing exactly one `<h1>`","At least two paragraphs of real content","At least one link"]}'::jsonb
from public.lessons where slug = 'your-first-complete-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'progressive_detail'::public.block_type, 'Why "real content" matters', 'It is tempting to type "text here" and move on. Resist it. Writing plausible content forces you to make structural decisions — is this a heading or a paragraph? does this sentence belong in the same paragraph as the last one? — and those decisions are the actual skill. Lorem ipsum teaches you nothing, and every professional habit you build now saves you time later.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'your-first-complete-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'interactive_demo'::public.block_type, 'What each part of the skeleton does', 'Remove one piece at a time and watch what changes.',
       NULL, NULL, NULL, '{"variants":[{"label":"Complete","code":"<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\">\n    <title>Riverside Bakery</title>\n  </head>\n  <body>\n    <h1>Riverside Bakery</h1>\n    <p>Open seven days a week.</p>\n  </body>\n</html>","note":"Every required part present. The tab shows a title, the text is decoded correctly, and assistive technology knows the language."},{"label":"No charset","code":"<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <title>Riverside Bakery</title>\n  </head>\n  <body>\n    <h1>Café Riverside</h1>\n    <p>Open seven days — from £6.</p>\n  </body>\n</html>","note":"Accented characters, dashes and currency symbols are the first casualties. Often it happens to look fine until someone types an é."},{"label":"No title","code":"<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\">\n  </head>\n  <body>\n    <h1>Riverside Bakery</h1>\n  </body>\n</html>","note":"The page still renders, but the tab shows the file name, a bookmark is meaningless, and a search result has nothing to display."}]}'::jsonb
from public.lessons where slug = 'your-first-complete-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["You can now build a valid HTML document from an empty file.","The frame comes first; the content fills it in.","This page is the seed of your capstone website — you will return to it many times."],"nextUp":"Level 2 next: making the content itself meaningful."}'::jsonb
from public.lessons where slug = 'your-first-complete-page';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'first-page-milestone', 1, 'challenge'::public.exercise_kind, 'Milestone: a complete web page',
       'Starting from a blank editor, write a complete HTML document for a homepage. It needs the full skeleton, a single `<h1>`, at least two paragraphs, and at least one link. The subject is yours — write about the project you chose when you signed up.', '', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Riverside Cycle Hire — bikes and routes in the valley</title>
  </head>
  <body>
    <h1>Riverside Cycle Hire</h1>
    <p>
      We rent well-maintained bikes by the hour, the day or the week, from a
      workshop two minutes from the river path.
    </p>
    <p>
      Every hire includes a helmet, a lock and a printed route map. If something
      goes wrong out on the trail, ring us and we will come and get you.
    </p>
    <p><a href="contact.html">Book a bike or ask us a question</a></p>
  </body>
</html>', ARRAY['Start with the frame: <!DOCTYPE html>, then <html lang="en">, then <head> and <body>.', 'The head needs three things: the charset meta tag, the viewport meta tag, and a title.', 'In the body: one <h1>, then two or more <p> elements, then an <a href="…">…</a> somewhere.', 'Check the indentation — children indented two spaces inside their parent — then press Check my work.']::text[],
       90, 3,
       (select id from public.skills where slug = 'document-structure'), false
from public.lessons l where l.slug = 'your-first-complete-page'
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
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'unique_element'::public.requirement_kind, 'html', NULL,
       NULL, NULL, NULL, NULL,
       'There is one <html> element wrapping the document', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'html', 'lang',
       NULL, NULL, NULL, NULL,
       'The html element has a lang attribute', 'Write <html lang="en">.', 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'unique_element'::public.requirement_kind, 'head', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one <head>', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'unique_element'::public.requirement_kind, 'body', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one <body>', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'nesting'::public.requirement_kind, 'meta[charset]', NULL,
       NULL, 'head', 1, NULL,
       'The charset meta tag is in the head', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'attribute_value'::public.requirement_kind, 'meta[name="viewport"]', 'name',
       'viewport', NULL, NULL, NULL,
       'A viewport meta tag is present', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one <title>', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'text_not_empty'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The title is not empty', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one <h1>', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'body', 1, NULL,
       'The <h1> is inside the body', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'element_count'::public.requirement_kind, 'p', NULL,
       NULL, NULL, 2, NULL,
       'There are at least two paragraphs', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'text_not_empty'::public.requirement_kind, 'p', NULL,
       NULL, NULL, NULL, NULL,
       'The paragraphs contain real text', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'element_present'::public.requirement_kind, 'a[href]', NULL,
       NULL, NULL, NULL, NULL,
       'There is at least one link with an href', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 15, 'text_not_empty'::public.requirement_kind, 'a', NULL,
       NULL, NULL, NULL, NULL,
       'The link has visible text', NULL, 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 16, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 17, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 18, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'first-page-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'first-page-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: create index.html',
       'Save your page as the homepage of your capstone project. This file becomes `index.html` — the page a browser opens when someone visits your site with no filename. Keep the content you wrote; you will improve it many times as the course goes on.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Your site name — what you do</title>
  </head>
  <body>
    <h1>Your site name</h1>

    <!--
      Add at least two paragraphs of your own about this project,
      then a link to contact.html so visitors can reach you.
    -->
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Riverside Cycle Hire — bikes and routes in the valley</title>
  </head>
  <body>
    <h1>Riverside Cycle Hire</h1>
    <p>We rent well-maintained bikes by the hour, the day or the week.</p>
    <p>Every hire includes a helmet, a lock and a printed route map.</p>
    <p><a href="contact.html">Book a bike</a></p>
  </body>
</html>', ARRAY['Replace the placeholder sentences with your own — the checker requires real content, not the starter text.', 'Keep the whole skeleton intact.', 'Make the title specific to your project rather than generic.']::text[],
       60, 2,
       (select id from public.skills where slug = 'multi-page'), false
from public.lessons l where l.slug = 'your-first-complete-page'
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
from public.exercises e where e.slug = 'first-page-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'One <h1> naming your site', NULL, 1, true
from public.exercises e where e.slug = 'first-page-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'A title describing this page', NULL, 1, true
from public.exercises e where e.slug = 'first-page-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'p', NULL,
       NULL, NULL, 2, NULL,
       'At least two paragraphs of your own content', NULL, 1, true
from public.exercises e where e.slug = 'first-page-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'a[href]', NULL,
       NULL, NULL, NULL, NULL,
       'At least one link', NULL, 1, true
from public.exercises e where e.slug = 'first-page-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'first-page-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'first-page-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'your-first-complete-page'), NULL, 'q-index-html', 1, 'single'::public.question_kind,
        'Why is a site''s homepage almost always called `index.html`?', 'When a request arrives with no filename, web servers look for a default file, and `index.html` is that default nearly everywhere. It is a server convention, not an HTML rule.', (select id from public.skills where slug = 'multi-page'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Browsers refuse to open a site without it', false, NULL
from public.quiz_questions where slug = 'q-index-html';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It makes the page load faster', false, NULL
from public.quiz_questions where slug = 'q-index-html';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Servers serve it by default when no filename is given', true, NULL
from public.quiz_questions where slug = 'q-index-html';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'HTML requires the first page of a site to be called index', false, NULL
from public.quiz_questions where slug = 'q-index-html';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'your-first-complete-page'), NULL, 'q-one-h1', 2, 'single'::public.question_kind,
        'How many `<h1>` elements should a typical page have?', 'One. The `<h1>` names what the whole page is about. Several competing `<h1>`s leave screen-reader users and search engines with no clear answer to "what is this page?".', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Exactly one', true, NULL
from public.quiz_questions where slug = 'q-one-h1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'One per section', false, NULL
from public.quiz_questions where slug = 'q-one-h1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'As many as you like', false, NULL
from public.quiz_questions where slug = 'q-one-h1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'None — h1 is for site names only', false, NULL
from public.quiz_questions where slug = 'q-one-h1';
-- Level 1 milestone: HTML Explorer questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-1-milestone'), 'a1-q1', 1, 'single'::public.question_kind,
        'What is sent from a web server to your browser when you visit a page?', 'Files, starting with an HTML text file that the browser then renders.', (select id from public.skills where slug = 'document-structure'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A rendered image of the page', false, NULL
from public.quiz_questions where slug = 'a1-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A compiled program', false, NULL
from public.quiz_questions where slug = 'a1-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A database record', false, NULL
from public.quiz_questions where slug = 'a1-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'An HTML text file the browser renders', true, NULL
from public.quiz_questions where slug = 'a1-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-1-milestone'), 'a1-q2', 2, 'single'::public.question_kind,
        'Which line must come first in an HTML file?', 'The doctype precedes everything, including the html element.', (select id from public.skills where slug = 'document-structure'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<meta charset="utf-8">', false, NULL
from public.quiz_questions where slug = 'a1-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<head>', false, NULL
from public.quiz_questions where slug = 'a1-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<!DOCTYPE html>', true, NULL
from public.quiz_questions where slug = 'a1-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<html lang="en">', false, NULL
from public.quiz_questions where slug = 'a1-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-1-milestone'), 'a1-q3', 3, 'single'::public.question_kind,
        'Which is a void element?', '`<img>` wraps nothing, so it has no closing tag. The others all wrap content.', (select id from public.skills where slug = 'syntax'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<h1>', false, NULL
from public.quiz_questions where slug = 'a1-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<img>', true, NULL
from public.quiz_questions where slug = 'a1-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<p>', false, NULL
from public.quiz_questions where slug = 'a1-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<a>', false, NULL
from public.quiz_questions where slug = 'a1-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-1-milestone'), 'a1-q4', 4, 'single'::public.question_kind,
        'What is wrong with `<p>Open <em>daily</p></em>`?', 'The elements overlap. `<em>` was opened last, so it must be closed first, before `</p>`.', (select id from public.skills where slug = 'syntax'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The tags overlap instead of nesting', true, NULL
from public.quiz_questions where slug = 'a1-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<em> cannot be used inside a paragraph', false, NULL
from public.quiz_questions where slug = 'a1-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The paragraph needs an attribute', false, NULL
from public.quiz_questions where slug = 'a1-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Nothing — this is valid', false, NULL
from public.quiz_questions where slug = 'a1-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-1-milestone'), 'a1-q5', 5, 'single'::public.question_kind,
        'Which content belongs in `<head>`?', 'The head holds information about the page. Headings, paragraphs and images are visible content and belong in the body.', (select id from public.skills where slug = 'document-structure'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The main heading of the page', false, NULL
from public.quiz_questions where slug = 'a1-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The site logo image', false, NULL
from public.quiz_questions where slug = 'a1-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The footer', false, NULL
from public.quiz_questions where slug = 'a1-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The page title and character set', true, NULL
from public.quiz_questions where slug = 'a1-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-1-milestone'), 'a1-q6', 6, 'single'::public.question_kind,
        'In `<a href="shop.html">Shop</a>`, what is `href`?', 'It is an attribute name; `shop.html` is its value.', (select id from public.skills where slug = 'syntax'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'An element', false, NULL
from public.quiz_questions where slug = 'a1-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The content', false, NULL
from public.quiz_questions where slug = 'a1-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'An attribute', true, NULL
from public.quiz_questions where slug = 'a1-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A tag', false, NULL
from public.quiz_questions where slug = 'a1-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-1-milestone'), 'a1-q7', 7, 'single'::public.question_kind,
        'What does `lang="en"` on the `<html>` element do?', 'It declares the page''s language, which screen readers use to choose pronunciation and browsers use to offer translation.', (select id from public.skills where slug = 'document-structure'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Chooses which spell-checker the browser uses', false, NULL
from public.quiz_questions where slug = 'a1-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Declares the language of the page content', true, NULL
from public.quiz_questions where slug = 'a1-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Translates the page into English', false, NULL
from public.quiz_questions where slug = 'a1-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Sets the character encoding', false, NULL
from public.quiz_questions where slug = 'a1-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-1-milestone'), 'a1-q8', 8, 'single'::public.question_kind,
        'Which statement about HTML comments is correct?', 'Comments are hidden from the rendered page but are sent to the browser and visible in the page source.', (select id from public.skills where slug = 'syntax'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'They are hidden on the page but visible in the source', true, NULL
from public.quiz_questions where slug = 'a1-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'They are stripped out by the server', false, NULL
from public.quiz_questions where slug = 'a1-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'They can only appear in the head', false, NULL
from public.quiz_questions where slug = 'a1-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'They are displayed in grey on the page', false, NULL
from public.quiz_questions where slug = 'a1-q8';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-1-milestone'), 'a1-q9', 9, 'single'::public.question_kind,
        'Why indent nested elements?', 'Indentation makes the tree visible, so an unclosed or misplaced tag is obvious to the eye. Browsers ignore whitespace entirely.', (select id from public.skills where slug = 'maintainability'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Because browsers require it', false, NULL
from public.quiz_questions where slug = 'a1-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'To make the page render faster', false, NULL
from public.quiz_questions where slug = 'a1-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'To create indentation on the finished page', false, NULL
from public.quiz_questions where slug = 'a1-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'To make the structure readable and mistakes visible', true, NULL
from public.quiz_questions where slug = 'a1-q9';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-1-milestone'), 'a1-q10', 10, 'single'::public.question_kind,
        'What is the DOM?', 'The Document Object Model is the browser''s live tree of your document, built from your HTML when the page loads.', (select id from public.skills where slug = 'syntax'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The part of the browser that downloads files', false, NULL
from public.quiz_questions where slug = 'a1-q10';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The browser''s in-memory tree built from your HTML', true, NULL
from public.quiz_questions where slug = 'a1-q10';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A file format for saving web pages', false, NULL
from public.quiz_questions where slug = 'a1-q10';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A rule about which elements are allowed', false, NULL
from public.quiz_questions where slug = 'a1-q10';
-- --------------------------------------------------------------------------
-- Level 2: Content Builder
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'content-builder', 2, 'Content Builder', 'Say what your content means, not what it should look like',
       'HTML has an element for almost every kind of text: emphasis, quotations, abbreviations, dates, code. Choosing the right one is what separates markup that merely displays from markup that communicates.', 'You can mark up a realistic article with a correct heading hierarchy and precise text semantics.', 'teal'
from public.courses c where c.slug = 'html-hero'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-2-milestone', 'milestone'::public.assessment_kind, 'Level 2 milestone: Content Builder', 'Eight questions on headings, paragraphs, text semantics and lists. Pass mark 75%.',
       0.75, 150, 2
from public.levels l where l.slug = 'content-builder'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Headings and paragraphs
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'headings-and-paragraphs', 1, 'Headings and paragraphs', 'The two elements you will use more than any other, and the hierarchy rule that makes a page navigable.',
       40, false
from public.levels l where l.slug = 'content-builder'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'headings-and-paragraphs' and p.slug = 'the-html-skeleton';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'headings-and-paragraphs' and s.slug = 'text-semantics';
-- lesson: Headings and the outline they create
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'heading-hierarchy', 1, 'Headings and the outline they create', 'h1 to h6, and why the order matters more than the size', 'Headings are not "big text". They are the table of contents that screen readers and search engines actually read.',
       ARRAY['Use h1 to h6 to describe the structure of a page', 'Keep a heading hierarchy with no skipped levels', 'Explain why heading order matters to real people']::text[], 14, 40, (select id from public.skills where slug = 'text-semantics'), 0.7
from public.modules m where m.slug = 'headings-and-paragraphs'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Build a correct heading hierarchy with exactly one h1","Recognise a skipped heading level and fix it","Explain how a screen-reader user navigates by headings"]}'::jsonb
from public.lessons where slug = 'heading-hierarchy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'There are six heading elements, `<h1>` through `<h6>`. `<h1>` is the most important and `<h6>` the least. Together they form an outline of the page — exactly like the contents page of a book.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'heading-hierarchy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'visual'::public.block_type, NULL, 'Headings as an indented outline. Each level is a step down, never a jump.',
       NULL, NULL, 'heading-hierarchy', '{}'::jsonb
from public.lessons where slug = 'heading-hierarchy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'prose'::public.block_type, NULL, 'The rule is simple: start at `<h1>`, and never skip a level going down. An `<h3>` may follow an `<h2>`, but it must not follow an `<h1>` directly. Going back up is fine — after an `<h3>`, the next `<h2>` simply starts a new section.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'heading-hierarchy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Why this is not pedantry', 'Screen readers offer a "list all headings" command, and it is the main way blind users skim a page — the equivalent of your eye jumping down the screen. A hierarchy with gaps produces a contents list that makes no sense. Roughly two-thirds of screen-reader users say headings are how they find their way around a page.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'heading-hierarchy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'comparison'::public.block_type, 'Two versions of the same page', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Correct hierarchy","code":"<h1>Riverside Cycle Hire</h1>\n  <h2>Our bikes</h2>\n    <h3>Hybrids</h3>\n    <h3>Road bikes</h3>\n  <h2>Routes</h2>","why":"Reads as a proper outline: one topic, two sections, two sub-sections under the first."},"bad":{"label":"Skipped level","code":"<h1>Riverside Cycle Hire</h1>\n    <h4>Our bikes</h4>\n    <h4>Routes</h4>","why":"h4 was chosen because it looked the right size. The outline now has two missing levels and describes a structure that does not exist."}}'::jsonb
from public.lessons where slug = 'heading-hierarchy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'Never choose a heading for its size', 'If an `<h2>` looks too big, that is a styling problem with a styling solution. Picking `<h4>` to get smaller text breaks the outline for everyone who cannot see it. Structure first; appearance is CSS''s job.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'heading-hierarchy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'How a screen reader hears it', 'The same content, announced two different ways.',
       NULL, NULL, NULL, '{"variants":[{"label":"Good structure","code":"<h1>Opening hours</h1>\n<h2>Weekdays</h2>\n<p>6am to 6pm.</p>\n<h2>Weekends</h2>\n<p>8am to 4pm.</p>","note":"Announced as: heading level 1 Opening hours; heading level 2 Weekdays; heading level 2 Weekends. A clear two-section page."},{"label":"Fake headings","code":"<p><strong>Opening hours</strong></p>\n<p><strong>Weekdays</strong></p>\n<p>6am to 6pm.</p>","note":"Announced as three ordinary paragraphs. The headings list is empty, and the page appears to have no structure at all."}]}'::jsonb
from public.lessons where slug = 'heading-hierarchy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'progressive_detail'::public.block_type, 'Does an h1 have to be the site name?', 'No. The `<h1>` should name *this page*, not the whole site. On a homepage those are often the same, but on an About page the `<h1>` should say "About us", not repeat the company name. Search engines and screen-reader users both use the h1 to answer "what is this particular page?".',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'heading-hierarchy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'visual'::public.block_type, NULL, 'A long article benefits from headings for the same reason a path benefits from signposts: you can tell where you are without reading everything.',
       NULL, NULL, 'forest-path', '{}'::jsonb
from public.lessons where slug = 'heading-hierarchy';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Six heading levels form the page outline.","Exactly one `<h1>`, naming what this page is about.","Never skip a level going down; going back up starts a new section.","Choose the level by meaning, never by how big the text looks."],"nextUp":"Next: paragraphs, and the difference between a line break and a new paragraph."}'::jsonb
from public.lessons where slug = 'heading-hierarchy';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'headings-guided', 1, 'guided'::public.exercise_kind, 'Fix the outline',
       'This page uses heading levels chosen by size rather than meaning. Rewrite the levels so the outline is correct: one h1 for the page, h2 for each major section, h3 for the parts inside a section. Do not change any wording.', '<h1>Coastal Walks</h1>
<h4>Easy routes</h4>
<h5>Harbour loop</h5>
<h5>Cliff-top path</h5>
<h4>Harder routes</h4>
<h5>The ridge</h5>', '<h1>Coastal Walks</h1>
<h2>Easy routes</h2>
<h3>Harbour loop</h3>
<h3>Cliff-top path</h3>
<h2>Harder routes</h2>
<h3>The ridge</h3>', ARRAY['The two major sections are "Easy routes" and "Harder routes" — those should be h2.', 'The individual walks sit inside a section, so they are one level down: h3.', 'After changing them, read the levels top to bottom: 1, 2, 3, 3, 2, 3. No jumps.']::text[],
       35, 2,
       (select id from public.skills where slug = 'text-semantics'), false
from public.lessons l where l.slug = 'heading-hierarchy'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'Exactly one h1', NULL, 1, true
from public.exercises e where e.slug = 'headings-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'h2', NULL,
       NULL, NULL, 2, 2,
       'Two h2 sections', NULL, 1, true
from public.exercises e where e.slug = 'headings-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'h3', NULL,
       NULL, NULL, 3, 3,
       'Three h3 sub-sections', NULL, 1, true
from public.exercises e where e.slug = 'headings-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'h4, h5, h6', NULL,
       NULL, NULL, 0, 0,
       'No h4, h5 or h6 remain', NULL, 1, true
from public.exercises e where e.slug = 'headings-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'headings-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'headings-debug', 2, 'debug'::public.exercise_kind, 'Two h1s and a fake heading',
       'This page has three problems: two competing h1 elements, a jump from h2 straight to h4, and a bold paragraph pretending to be a heading. Fix all three.', '<h1>Northgate Dental</h1>
<h1>Our treatments</h1>
<h4>Check-ups</h4>
<p><strong>Emergency appointments</strong></p>
<p>We keep two slots free every day.</p>', '<h1>Northgate Dental</h1>
<h2>Our treatments</h2>
<h3>Check-ups</h3>
<h3>Emergency appointments</h3>
<p>We keep two slots free every day.</p>', ARRAY['Only one h1 — the second one is a section of the page, so it becomes h2.', 'The h4 sits inside that section, so it should be h3.', 'The bold paragraph is really a heading at the same level as "Check-ups".']::text[],
       40, 3,
       (select id from public.skills where slug = 'text-semantics'), false
from public.lessons l where l.slug = 'heading-hierarchy'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'Only one h1 remains', NULL, 1, true
from public.exercises e where e.slug = 'headings-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'headings-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'h3', NULL,
       NULL, NULL, 2, 2,
       'Both treatments are marked up as h3 headings', NULL, 1, true
from public.exercises e where e.slug = 'headings-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'p > strong', NULL,
       NULL, NULL, 0, 0,
       'No paragraph is pretending to be a heading', NULL, 1, true
from public.exercises e where e.slug = 'headings-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'heading-hierarchy'), NULL, 'q-heading-skip', 1, 'single'::public.question_kind,
        'You have an `<h2>` and want the next heading to be smaller. What should you use?', 'The next level down is `<h3>`. If it looks too large, change the styling — never the level.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<p> with bold text', false, NULL
from public.quiz_questions where slug = 'q-heading-skip';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Another <h2> with a smaller font', false, NULL
from public.quiz_questions where slug = 'q-heading-skip';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<h3>, and adjust the size with CSS if needed', true, NULL
from public.quiz_questions where slug = 'q-heading-skip';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<h5>, because it is smaller', false, NULL
from public.quiz_questions where slug = 'q-heading-skip';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'heading-hierarchy'), NULL, 'q-heading-purpose', 2, 'single'::public.question_kind,
        'How do many screen-reader users navigate a long page?', 'They pull up a list of the page''s headings and jump straight to the section they want — which only works if the headings describe the real structure.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'By looking at the font sizes', false, NULL
from public.quiz_questions where slug = 'q-heading-purpose';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'By listing the headings and jumping between them', true, NULL
from public.quiz_questions where slug = 'q-heading-purpose';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'By reading every word from top to bottom', false, NULL
from public.quiz_questions where slug = 'q-heading-purpose';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'By searching for bold text', false, NULL
from public.quiz_questions where slug = 'q-heading-purpose';
-- lesson: Paragraphs, line breaks and horizontal rules
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'paragraphs-breaks-rules', 2, 'Paragraphs, line breaks and horizontal rules', 'Three elements that look similar and mean very different things', 'Whitespace in your file does nothing. This lesson covers the elements that actually create structure in text.',
       ARRAY['Use `<p>` for prose and know when a new paragraph starts', 'Use `<br>` only where a line break is part of the content', 'Use `<hr>` to mark a genuine change of topic']::text[], 12, 40, (select id from public.skills where slug = 'text-semantics'), 0.7
from public.modules m where m.slug = 'headings-and-paragraphs'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Split prose into paragraphs correctly","Explain when `<br>` is appropriate and when it is a mistake","Use `<hr>` for its actual meaning"]}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'HTML collapses whitespace. Ten spaces, a tab and three blank lines in your file all become a single space on the page. Structure has to come from elements, not from how the text is laid out in the editor.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'What you write', NULL,
       '<p>This        text

has lots of spacing in the file.</p>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'prose'::public.block_type, NULL, 'The browser displays that as a single line: "This text has lots of spacing in the file."',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'Paragraph', 'A block of prose. `<p>` starts a new one. Browsers add space above and below automatically.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'term'::public.block_type, 'Line break', '`<br>` forces a new line *within* a block. It is a void element — no closing tag.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, '`<br>` is not for spacing', 'A run of `<br><br><br>` to push things apart is the most common beginner habit, and it causes real problems: screen readers may announce the blank lines, and the spacing cannot be adjusted responsively. Use `<br>` only when the line break is genuinely part of the content — a postal address, a poem, song lyrics.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'comparison'::public.block_type, 'When `<br>` is right and wrong', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Correct — the breaks are part of the address","code":"<p>\n  Riverside Cycle Hire<br>\n  14 Mill Lane<br>\n  Hexford HX2 4PL\n</p>","why":"An address genuinely has line breaks in it. This is exactly what `<br>` is for."},"bad":{"label":"Wrong — using breaks as spacing","code":"<p>Our opening hours have changed.</p>\n<br><br>\n<p>We now close at 4pm on Sundays.</p>","why":"These are two separate paragraphs already. The `<br>` elements add meaningless empty content that spacing should provide."}}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'prose'::public.block_type, NULL, '`<hr>` used to mean "draw a horizontal line". In modern HTML it means "a thematic break" — the point where the subject changes, like a scene break in a novel. The line the browser draws is just the default way of showing that.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'code_example'::public.block_type, '`<hr>` marking a genuine change of subject', NULL,
       '<h2>Bike hire</h2>
<p>Hourly, daily and weekly rates.</p>

<hr>

<h2>Guided rides</h2>
<p>Every Saturday from March to October.</p>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'Where does the space between paragraphs come from?', 'Browsers ship with a default stylesheet that gives `<p>` a margin above and below. You are not writing that space — the browser is. This is why adding `<br>` for spacing is redundant *and* fragile: the moment a real stylesheet changes the margin, your hand-made gaps are wrong.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'checklist'::public.block_type, 'Choosing between them', NULL,
       NULL, NULL, NULL, '{"items":["New topic or new block of prose → a new `<p>`","Line break that is part of the content itself → `<br>`","The subject genuinely changes → `<hr>`","You just want more space → neither; that is a styling job"]}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'interactive_demo'::public.block_type, 'Three ways to break a line, one of them right', 'The same address, marked up three ways.',
       NULL, NULL, NULL, '{"variants":[{"label":"One paragraph, real breaks","code":"<p>Riverside Bakery<br>12 Mill Lane<br>Hexford HX1 2AB</p>","note":"Correct. An address is one block of text whose line breaks are part of its meaning — exactly what <br> is for."},{"label":"Separate paragraphs","code":"<p>Riverside Bakery</p>\n<p>12 Mill Lane</p>\n<p>Hexford HX1 2AB</p>","note":"Wrong meaning: it claims these are three unrelated paragraphs, and screen readers announce three separate blocks."},{"label":"Empty paragraphs for spacing","code":"<p>Riverside Bakery</p>\n<p></p>\n<p>12 Mill Lane</p>","note":"Never do this. The empty paragraph is a spacing hack, it is announced as a blank paragraph, and CSS is the correct tool for space."}]}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Whitespace in the file is collapsed; structure comes from elements.","`<p>` for each block of prose.","`<br>` only when the break belongs to the content, such as an address.","`<hr>` means a change of subject, not \"draw a line\"."],"nextUp":"Next: the elements that add meaning inside a sentence."}'::jsonb
from public.lessons where slug = 'paragraphs-breaks-rules';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'paragraphs-guided', 1, 'guided'::public.exercise_kind, 'Mark up an address and two paragraphs',
       'Turn the text below into two paragraphs of prose, plus a third paragraph containing a postal address that uses `<br>` between its lines.', 'We have been hiring bikes from the same workshop since 1998.
Everything is serviced on site by our own mechanics.

Riverside Cycle Hire
14 Mill Lane
Hexford HX2 4PL', '<p>We have been hiring bikes from the same workshop since 1998.</p>
<p>Everything is serviced on site by our own mechanics.</p>
<p>
  Riverside Cycle Hire<br>
  14 Mill Lane<br>
  Hexford HX2 4PL
</p>', ARRAY['The first two sentences are separate blocks of prose, so each gets its own <p>.', 'The address is one block with line breaks inside it — one <p> containing <br> elements.', 'You need two <br> elements: after the name and after the street.']::text[],
       35, 2,
       (select id from public.skills where slug = 'text-semantics'), false
from public.lessons l where l.slug = 'paragraphs-breaks-rules'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'p', NULL,
       NULL, NULL, 3, 3,
       'There are exactly three paragraphs', NULL, 1, true
from public.exercises e where e.slug = 'paragraphs-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'br', NULL,
       NULL, NULL, 2, 2,
       'The address uses exactly two line breaks', NULL, 1, true
from public.exercises e where e.slug = 'paragraphs-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'nesting'::public.requirement_kind, 'br', NULL,
       NULL, 'p', 1, NULL,
       'The line breaks are inside a paragraph', NULL, 1, true
from public.exercises e where e.slug = 'paragraphs-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'text_content'::public.requirement_kind, 'p', NULL,
       'Mill Lane', NULL, NULL, NULL,
       'The address text is preserved', NULL, 1, true
from public.exercises e where e.slug = 'paragraphs-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'paragraphs-debug', 2, 'debug'::public.exercise_kind, 'Remove the spacing hack',
       'Someone used line breaks to create space between paragraphs and an `<hr>` purely for decoration. Rewrite it so the structure is honest: real paragraphs, and no stray break elements.', '<p>Our summer timetable starts in May.</p>
<br><br>
<p>Winter hours begin in October.</p>
<hr>
<hr>
<p>Bank holidays follow Sunday hours.</p>', '<p>Our summer timetable starts in May.</p>
<p>Winter hours begin in October.</p>
<p>Bank holidays follow Sunday hours.</p>', ARRAY['The paragraphs already separate themselves — the <br> elements are doing nothing useful.', 'Two <hr> elements in a row cannot both mark a change of subject.', 'The finished answer is three paragraphs and nothing else.']::text[],
       30, 2,
       (select id from public.skills where slug = 'text-semantics'), false
from public.lessons l where l.slug = 'paragraphs-breaks-rules'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'p', NULL,
       NULL, NULL, 3, 3,
       'Three paragraphs remain', NULL, 1, true
from public.exercises e where e.slug = 'paragraphs-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'br', NULL,
       NULL, NULL, 0, 0,
       'No stray line breaks', NULL, 1, true
from public.exercises e where e.slug = 'paragraphs-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'hr', NULL,
       NULL, NULL, 0, 1,
       'At most one horizontal rule, if any', NULL, 1, true
from public.exercises e where e.slug = 'paragraphs-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'paragraphs-breaks-rules'), NULL, 'q-whitespace', 1, 'single'::public.question_kind,
        'What happens to three blank lines in your HTML file?', 'Runs of whitespace are collapsed to a single space. Structure must come from elements.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'They appear as three blank lines on the page', false, NULL
from public.quiz_questions where slug = 'q-whitespace';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'They cause a validation error', false, NULL
from public.quiz_questions where slug = 'q-whitespace';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'They create a new paragraph automatically', false, NULL
from public.quiz_questions where slug = 'q-whitespace';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'They collapse into a single space', true, NULL
from public.quiz_questions where slug = 'q-whitespace';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'paragraphs-breaks-rules'), NULL, 'q-br-use', 2, 'single'::public.question_kind,
        'Which is a correct use of `<br>`?', '`<br>` is for line breaks that are part of the content, such as the lines of a postal address or a poem.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'To push a footer to the bottom of the page', false, NULL
from public.quiz_questions where slug = 'q-br-use';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'To start a new section of the page', false, NULL
from public.quiz_questions where slug = 'q-br-use';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Between the lines of a postal address', true, NULL
from public.quiz_questions where slug = 'q-br-use';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'To add space between two paragraphs', false, NULL
from public.quiz_questions where slug = 'q-br-use';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'paragraphs-breaks-rules'), NULL, 'q-hr-meaning', 3, 'single'::public.question_kind,
        'What does `<hr>` mean in modern HTML?', 'It marks a thematic break — the point where the subject changes. Drawing a line is just the default presentation of that meaning.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Add vertical space', false, NULL
from public.quiz_questions where slug = 'q-hr-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'End the current section element', false, NULL
from public.quiz_questions where slug = 'q-hr-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A change of subject', true, NULL
from public.quiz_questions where slug = 'q-hr-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Draw a horizontal line', false, NULL
from public.quiz_questions where slug = 'q-hr-meaning';
-- module: Meaning inside a sentence
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'text-level-semantics', 2, 'Meaning inside a sentence', 'Emphasis, importance, quotations, abbreviations, dates, code, and the special characters that break pages if you type them raw.',
       55, false
from public.levels l where l.slug = 'content-builder'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'text-level-semantics' and p.slug = 'headings-and-paragraphs';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.6
from public.modules m, public.skills s
where m.slug = 'text-level-semantics' and s.slug = 'text-semantics';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'text-level-semantics' and s.slug = 'lists';
-- lesson: Emphasis, importance and highlighting
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'emphasis-and-importance', 1, 'Emphasis, importance and highlighting', 'strong, em, mark, small — and the two elements to avoid', 'Bold and italic are appearances. HTML gives you elements for the *reasons* behind them, and screen readers can hear the difference.',
       ARRAY['Choose between `<strong>` and `<em>` correctly', 'Use `<mark>` and `<small>` for their real meanings', 'Explain why `<b>` and `<i>` are rarely the right choice']::text[], 12, 40, (select id from public.skills where slug = 'text-semantics'), 0.7
from public.modules m where m.slug = 'text-level-semantics'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Use `<strong>` for importance and `<em>` for stress emphasis","Apply `<mark>` and `<small>` where they genuinely fit","Explain the difference between `<b>` and `<strong>`"]}'::jsonb
from public.lessons where slug = 'emphasis-and-importance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'term'::public.block_type, '<strong>', 'Marks text as *important* — a warning, a deadline, something with consequences if missed. Displayed bold by default.',
       NULL, NULL, NULL, '{"example":"<p><strong>Helmets must be worn</strong> on all guided rides.</p>"}'::jsonb
from public.lessons where slug = 'emphasis-and-importance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, '<em>', 'Marks *stress emphasis* — the word you would lean on if you said the sentence aloud. Displayed italic by default.',
       NULL, NULL, NULL, '{"example":"<p>We open at six, but we <em>close</em> at two.</p>"}'::jsonb
from public.lessons where slug = 'emphasis-and-importance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'interactive_demo'::public.block_type, 'The same sentence, emphasised differently', 'Emphasis changes the meaning, not just the look.',
       NULL, NULL, NULL, '{"variants":[{"label":"Emphasis on \"we\"","code":"<p><em>We</em> did not lose your booking.</p>","note":"Implies somebody else did."},{"label":"Emphasis on \"lose\"","code":"<p>We did not <em>lose</em> your booking.</p>","note":"Implies something else happened to it."},{"label":"Importance instead","code":"<p><strong>Bookings close at 5pm.</strong></p>","note":"Not a stressed word — a fact with consequences. Screen readers can announce it differently."}]}'::jsonb
from public.lessons where slug = 'emphasis-and-importance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'prose'::public.block_type, NULL, '`<b>` and `<i>` still exist, but they mean "bold for no stated reason" and "a different voice or mood" — a ship name, a technical term, a word in another language. They carry no importance or emphasis. In practice, if you reach for bold or italic, the meaning you want is nearly always `<strong>` or `<em>`.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'emphasis-and-importance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'comparison'::public.block_type, 'Choosing the right element', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Meaningful","code":"<p><strong>Do not lock bikes to the railings.</strong></p>","why":"This matters. A screen reader can convey the importance."},"bad":{"label":"Appearance only","code":"<p><b>Do not lock bikes to the railings.</b></p>","why":"Looks identical, but says only \"make this bold\". The importance is lost to anyone not looking at the screen."}}'::jsonb
from public.lessons where slug = 'emphasis-and-importance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'term'::public.block_type, '<mark>', 'Marks text as relevant *in the current context* — most often a search term highlighted in a result. Rendered with a yellow background by default.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'emphasis-and-importance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'term'::public.block_type, '<small>', 'Side comments and small print: copyright lines, legal disclaimers, attribution. It means "this is fine print", not "make this smaller".',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'emphasis-and-importance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'code_example'::public.block_type, '`<mark>` and `<small>` in use', NULL,
       '<p>Results for <mark>cycle hire</mark>: 12 matches.</p>
<p><small>Prices include VAT and are subject to availability.</small></p>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'emphasis-and-importance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'progressive_detail'::public.block_type, 'How screen readers actually treat these', 'Support varies. Many screen readers do not announce `<strong>` or `<em>` by default, because constant announcements would be exhausting to listen to — but users can turn that on, and several will change the pitch or speed of the voice. Using the right element also means that when you later restyle the site, or when the page is converted to another format, the meaning survives. Choosing the semantic element costs nothing and can only help.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'emphasis-and-importance';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<strong>` = important. `<em>` = stressed when read aloud.","`<b>` and `<i>` mean \"bold\" and \"different voice\" with no importance attached.","`<mark>` highlights something relevant right now; `<small>` is for small print.","Choose by meaning; the appearance follows."],"nextUp":"Next: quoting other people properly."}'::jsonb
from public.lessons where slug = 'emphasis-and-importance';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'emphasis-guided', 1, 'guided'::public.exercise_kind, 'Add meaning to a safety notice',
       'In the notice below, mark "must be worn at all times" as important, and stress the word "before" so a reader leans on it. Use the semantic elements, not `<b>` or `<i>`.', '<p>Helmets must be worn at all times. Please check your brakes before you set off.</p>', '<p><strong>Helmets must be worn at all times.</strong> Please check your brakes <em>before</em> you set off.</p>', ARRAY['Importance — a rule with consequences — is <strong>.', 'Stress on a single word when read aloud is <em>.', 'Wrap only the words that need it, not the whole paragraph.']::text[],
       30, 2,
       (select id from public.skills where slug = 'text-semantics'), false
from public.lessons l where l.slug = 'emphasis-and-importance'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'strong', NULL,
       NULL, NULL, NULL, NULL,
       'The important sentence uses <strong>', NULL, 1, true
from public.exercises e where e.slug = 'emphasis-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'text_content'::public.requirement_kind, 'strong', NULL,
       'must be worn', NULL, NULL, NULL,
       'The right words are marked as important', NULL, 1, true
from public.exercises e where e.slug = 'emphasis-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'em', NULL,
       NULL, NULL, NULL, NULL,
       'The stressed word uses <em>', NULL, 1, true
from public.exercises e where e.slug = 'emphasis-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'text_content'::public.requirement_kind, 'em', NULL,
       'before', NULL, NULL, NULL,
       'The word "before" is stressed', NULL, 1, true
from public.exercises e where e.slug = 'emphasis-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'b, i', NULL,
       NULL, NULL, 0, 0,
       'No presentational <b> or <i> elements', NULL, 1, true
from public.exercises e where e.slug = 'emphasis-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'emphasis-challenge', 2, 'challenge'::public.exercise_kind, 'A notice with four kinds of meaning',
       'Write a short paragraph for a shop page that contains all four of: `<strong>` for something important, `<em>` for a stressed word, `<mark>` for a highlighted term, and `<small>` for a line of small print. The wording is yours.', '', '<p>
  <strong>Orders placed after 2pm ship the next working day.</strong>
  We do <em>not</em> deliver on Sundays. Searching for
  <mark>next-day delivery</mark>? Choose it at checkout.
</p>
<p><small>Delivery estimates exclude bank holidays.</small></p>', ARRAY['Start with a sentence that genuinely matters — that is your <strong>.', '<mark> works well around a term someone might have searched for.', '<small> suits a closing line of terms or conditions.']::text[],
       40, 3,
       (select id from public.skills where slug = 'text-semantics'), false
from public.lessons l where l.slug = 'emphasis-and-importance'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'strong', NULL,
       NULL, NULL, NULL, NULL,
       'Uses <strong> for importance', NULL, 1, true
from public.exercises e where e.slug = 'emphasis-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_present'::public.requirement_kind, 'em', NULL,
       NULL, NULL, NULL, NULL,
       'Uses <em> for stress emphasis', NULL, 1, true
from public.exercises e where e.slug = 'emphasis-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'mark', NULL,
       NULL, NULL, NULL, NULL,
       'Uses <mark> for a highlighted term', NULL, 1, true
from public.exercises e where e.slug = 'emphasis-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'small', NULL,
       NULL, NULL, NULL, NULL,
       'Uses <small> for small print', NULL, 1, true
from public.exercises e where e.slug = 'emphasis-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'text_not_empty'::public.requirement_kind, 'p', NULL,
       NULL, NULL, NULL, NULL,
       'The paragraphs contain real content', NULL, 1, true
from public.exercises e where e.slug = 'emphasis-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'emphasis-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'emphasis-and-importance'), NULL, 'q-strong-vs-em', 1, 'single'::public.question_kind,
        'Which element marks text as important?', '`<strong>` means importance or urgency. `<em>` means stress emphasis — the word you would lean on.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<b>', false, NULL
from public.quiz_questions where slug = 'q-strong-vs-em';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<mark>', false, NULL
from public.quiz_questions where slug = 'q-strong-vs-em';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<strong>', true, NULL
from public.quiz_questions where slug = 'q-strong-vs-em';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<em>', false, NULL
from public.quiz_questions where slug = 'q-strong-vs-em';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'emphasis-and-importance'), NULL, 'q-small-meaning', 2, 'single'::public.question_kind,
        'What does `<small>` mean?', 'It marks side comments and small print — disclaimers, copyright lines, attribution. It is not a font-size control.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Text of secondary importance', false, NULL
from public.quiz_questions where slug = 'q-small-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Small print such as a disclaimer or copyright line', true, NULL
from public.quiz_questions where slug = 'q-small-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Text that should be displayed smaller', false, NULL
from public.quiz_questions where slug = 'q-small-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A footnote reference', false, NULL
from public.quiz_questions where slug = 'q-small-meaning';
-- lesson: Quotations, citations, abbreviations and dates
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'quotes-abbreviations-dates', 2, 'Quotations, citations, abbreviations and dates', 'The elements that make content genuinely machine-readable', 'Six elements that carry real information: who said it, what an acronym means, and exactly which date "next Tuesday" refers to.',
       ARRAY['Quote sources correctly with blockquote, q and cite', 'Expand abbreviations for people who do not know them', 'Make dates unambiguous with the time element']::text[], 14, 40, (select id from public.skills where slug = 'text-semantics'), 0.7
from public.modules m where m.slug = 'text-level-semantics'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Mark up block and inline quotations with attribution","Use `<abbr>` so abbreviations can be understood","Use `<time datetime=\"…\">` so machines read dates correctly"]}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'term'::public.block_type, '<blockquote>', 'A quotation long enough to stand on its own as a block. Takes an optional `cite` attribute holding the source URL.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, '<q>', 'A short quotation inside a sentence. Browsers add the quotation marks for you.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, '<cite>', 'The *title* of a creative work — a book, a film, an article, a study. Not the person who said it. This surprises almost everyone.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<figure>
  <blockquote cite="https://example.org/cycling-report-2026">
    <p>
      Towns that added protected cycle lanes saw a 34% rise in journeys
      made by bike within two years.
    </p>
  </blockquote>
  <figcaption>
    Transport Research Unit, <cite>Cycling in Small Towns</cite>, 2026
  </figcaption>
</figure>', 'html', NULL, '{"annotations":[{"line":"1","text":"`<figure>` groups the quotation with its caption so they travel together."},{"line":"2","text":"`cite` on the blockquote holds the source URL. Browsers do not display it, but it documents where the quotation came from."},{"line":"3-6","text":"The quoted text itself goes in a paragraph inside the blockquote."},{"line":"8-9","text":"`<figcaption>` carries the attribution. `<cite>` wraps the *work''s title* — the research unit''s name is not inside it, because `<cite>` is for titles, not authors."}]}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, '`<q>` for an inline quotation — no quotation marks typed by you', NULL,
       '<p>The council described the scheme as <q>the busiest route in the county</q>.</p>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'Do not type quotation marks inside `<q>`', 'The browser adds them, and it uses the right style for the page''s language. Typing your own produces doubled marks like ""this"".',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'term'::public.block_type, '<abbr>', 'An abbreviation or acronym. Put the full expansion in the `title` attribute so it can be discovered.',
       NULL, NULL, NULL, '{"example":"<abbr title=\"World Wide Web Consortium\">W3C</abbr>"}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'callout'::public.block_type, 'The `title` attribute is not enough on its own', 'Hovering to reveal a tooltip requires a mouse, so touch and keyboard users cannot reach it. For an abbreviation your reader may genuinely not know, write it out in full the first time and put the abbreviation in brackets after it — then use `<abbr>` for later occurrences.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'term'::public.block_type, '<time>', 'A date or time. The `datetime` attribute holds a machine-readable version, so software can read it even when the visible text is casual.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'code_example'::public.block_type, '`<time>` making casual wording precise', NULL,
       '<p>Our next guided ride is <time datetime="2026-08-15T09:30">Saturday morning</time>.</p>
<p>Open <time datetime="09:00">9am</time> to <time datetime="17:30">5.30pm</time>.</p>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'progressive_detail'::public.block_type, 'The datetime format', 'It follows ISO 8601: `2026-08-15` for a date, `09:30` for a time, `2026-08-15T09:30` for both together, and `2026-08` or `2026-W33` for a month or a week. Always year-month-day, always with leading zeros. This ordering sorts correctly as plain text, which is why standards use it and why "15/08/2026" — ambiguous between British and American readers — does not appear in `datetime`.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'checklist'::public.block_type, 'Use these when', NULL,
       NULL, NULL, NULL, '{"items":["You quote a block of text from elsewhere → `<blockquote>` + `<figcaption>`","You quote a phrase inside a sentence → `<q>`","You name a book, film, study or article → `<cite>`","You use an abbreviation a reader may not know → `<abbr title=\"…\">`","You mention any date or time → `<time datetime=\"…\">`"]}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'interactive_demo'::public.block_type, 'A quotation, marked up three ways', 'Only one of these tells software what it is looking at.',
       NULL, NULL, NULL, '{"variants":[{"label":"Marked up","code":"<blockquote cite=\"https://example.org/review\">\n  <p>The best sourdough in the county.</p>\n</blockquote>\n<p>— <cite>The Hexford Review</cite></p>","note":"The quotation is identifiable as a quotation, its source is recorded, and the publication is marked as a title."},{"label":"Typed quotation marks","code":"<p>\"The best sourdough in the county.\" — The Hexford Review</p>","note":"Looks nearly identical and means nothing to software. Nothing can find the quotations on this page, and nothing knows who said it."},{"label":"Italics for everything","code":"<p><i>\"The best sourdough in the county.\"</i> — <i>The Hexford Review</i></p>","note":"Two different things — a quotation and a publication title — flattened into the same purely visual instruction."}]}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 15, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<blockquote>` for block quotations, `<q>` for inline ones — never type the quotation marks yourself.","`<cite>` names the *work*, not the author.","`<abbr title=\"…\">` expands an abbreviation, but spelling it out in full first is better still.","`<time datetime=\"…\">` makes a casual date machine-readable."],"nextUp":"Next: code, superscripts and the special characters that break pages."}'::jsonb
from public.lessons where slug = 'quotes-abbreviations-dates';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'quotes-guided', 1, 'guided'::public.exercise_kind, 'Mark up a quotation with attribution',
       'Turn the text below into a `<figure>` containing a `<blockquote>` (with a `cite` attribute pointing at `https://example.org/report`) and a `<figcaption>` in which the report title is wrapped in `<cite>`.', 'Protected lanes raised cycling by a third within two years.
Transport Research Unit, Cycling in Small Towns, 2026', '<figure>
  <blockquote cite="https://example.org/report">
    <p>Protected lanes raised cycling by a third within two years.</p>
  </blockquote>
  <figcaption>
    Transport Research Unit, <cite>Cycling in Small Towns</cite>, 2026
  </figcaption>
</figure>', ARRAY['The <figure> wraps everything. Inside it go the <blockquote> and the <figcaption>.', 'The quoted sentence goes in a <p> inside the <blockquote>.', 'Only the report title — "Cycling in Small Towns" — goes inside <cite>, not the organisation name.']::text[],
       40, 3,
       (select id from public.skills where slug = 'text-semantics'), false
from public.lessons l where l.slug = 'quotes-abbreviations-dates'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'figure', NULL,
       NULL, NULL, NULL, NULL,
       'There is a figure grouping the quote and its caption', NULL, 1, true
from public.exercises e where e.slug = 'quotes-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'nesting'::public.requirement_kind, 'blockquote', NULL,
       NULL, 'figure', 1, NULL,
       'The blockquote is inside the figure', NULL, 1, true
from public.exercises e where e.slug = 'quotes-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'blockquote', 'cite',
       NULL, NULL, NULL, NULL,
       'The blockquote has a cite attribute with the source URL', NULL, 1, true
from public.exercises e where e.slug = 'quotes-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'nesting'::public.requirement_kind, 'figcaption', NULL,
       NULL, 'figure', 1, NULL,
       'There is a figcaption inside the figure', NULL, 1, true
from public.exercises e where e.slug = 'quotes-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'nesting'::public.requirement_kind, 'cite', NULL,
       NULL, 'figcaption', 1, NULL,
       'The work title is wrapped in <cite> inside the caption', NULL, 1, true
from public.exercises e where e.slug = 'quotes-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'text_content'::public.requirement_kind, 'cite', NULL,
       'Cycling in Small Towns', NULL, NULL, NULL,
       'The <cite> contains the title of the work', NULL, 1, true
from public.exercises e where e.slug = 'quotes-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'quotes-debug', 2, 'debug'::public.exercise_kind, 'Four semantic mistakes',
       'Each line has one problem: typed quotation marks inside `<q>`, an author in `<cite>`, an `<abbr>` with no expansion, and a date with no machine-readable value. Fix all four.', '<p>She called it <q>"a proper community shop"</q>.</p>
<p>From <cite>Ada Whitfield</cite>, writing in 2026.</p>
<p>Approved by the <abbr>RSPB</abbr> last year.</p>
<p>We reopen on <time>3 September 2026</time>.</p>', '<p>She called it <q>a proper community shop</q>.</p>
<p>From <cite>The Village Shop</cite> by Ada Whitfield, 2026.</p>
<p>Approved by the <abbr title="Royal Society for the Protection of Birds">RSPB</abbr> last year.</p>
<p>We reopen on <time datetime="2026-09-03">3 September 2026</time>.</p>', ARRAY['The browser supplies the quotation marks for <q>, so remove the typed ones.', '<cite> names a work, not a person — give it a title instead.', '<abbr> needs a title attribute holding the expansion.', '<time> needs datetime="2026-09-03" in year-month-day order.']::text[],
       45, 3,
       (select id from public.skills where slug = 'text-semantics'), false
from public.lessons l where l.slug = 'quotes-abbreviations-dates'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'q', NULL,
       NULL, NULL, NULL, NULL,
       'The inline quotation still uses <q>', NULL, 1, true
from public.exercises e where e.slug = 'quotes-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'abbr', 'title',
       NULL, NULL, NULL, NULL,
       'The abbreviation has a title with its expansion', NULL, 1, true
from public.exercises e where e.slug = 'quotes-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'time', 'datetime',
       NULL, NULL, NULL, NULL,
       'The time element has a datetime attribute', NULL, 1, true
from public.exercises e where e.slug = 'quotes-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_matches'::public.requirement_kind, 'time', 'datetime',
       '^\d{4}-\d{2}-\d{2}', NULL, NULL, NULL,
       'The datetime is in year-month-day order', 'Write datetime="2026-09-03".', 1, true
from public.exercises e where e.slug = 'quotes-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'cite', NULL,
       NULL, NULL, NULL, NULL,
       'A <cite> element is still present', NULL, 1, true
from public.exercises e where e.slug = 'quotes-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'quotes-abbreviations-dates'), NULL, 'q-cite-meaning', 1, 'single'::public.question_kind,
        'What does `<cite>` mark up?', 'The title of a creative work — a book, film, study or article. Not the author, despite what the name suggests.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A footnote', false, NULL
from public.quiz_questions where slug = 'q-cite-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The title of a work', true, NULL
from public.quiz_questions where slug = 'q-cite-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The author of a quotation', false, NULL
from public.quiz_questions where slug = 'q-cite-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A URL you are citing', false, NULL
from public.quiz_questions where slug = 'q-cite-meaning';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'quotes-abbreviations-dates'), NULL, 'q-datetime-format', 2, 'single'::public.question_kind,
        'Which `datetime` value is correctly formatted?', 'The format is ISO 8601: four-digit year, then month, then day, each separated by a hyphen, with leading zeros.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'datetime="03/09/2026"', false, NULL
from public.quiz_questions where slug = 'q-datetime-format';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'datetime="3 September 2026"', false, NULL
from public.quiz_questions where slug = 'q-datetime-format';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'datetime="Sept 3, 2026"', false, NULL
from public.quiz_questions where slug = 'q-datetime-format';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'datetime="2026-09-03"', true, NULL
from public.quiz_questions where slug = 'q-datetime-format';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'quotes-abbreviations-dates'), NULL, 'q-q-quotes', 3, 'single'::public.question_kind,
        'Should you type quotation marks inside `<q>`?', 'No — the browser inserts them, in the style appropriate to the page''s language. Typing your own gives you two sets.', (select id from public.skills where slug = 'text-semantics'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Only when the page language is not English', false, NULL
from public.quiz_questions where slug = 'q-q-quotes';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'No, the browser adds them automatically', true, NULL
from public.quiz_questions where slug = 'q-q-quotes';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Yes, always', false, NULL
from public.quiz_questions where slug = 'q-q-quotes';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only for quotations longer than a sentence', false, NULL
from public.quiz_questions where slug = 'q-q-quotes';
-- lesson: Code, special characters and lists
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'code-entities-and-lists', 3, 'Code, special characters and lists', 'Showing HTML on a page, and structuring anything that comes in a set', 'How to display a `<` without breaking the page, and how to mark up the three kinds of list.',
       ARRAY['Display code and preformatted text correctly', 'Write HTML entities for characters that would otherwise break markup', 'Choose between ordered, unordered and description lists']::text[], 15, 40, (select id from public.skills where slug = 'lists'), 0.7
from public.modules m where m.slug = 'text-level-semantics'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Show code on a page using `<code>` and `<pre>`","Escape `<`, `>` and `&` correctly with entities","Use the right list element for the content"]}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, '`<code>` marks a fragment of computer code inside a sentence. `<pre>` means "preformatted": inside it, spaces and line breaks are kept exactly as written — the one place HTML does not collapse whitespace.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'Showing HTML inside HTML', NULL,
       '<p>Every page needs a <code>&lt;title&gt;</code> element.</p>

<pre><code>&lt;head&gt;
  &lt;title&gt;My page&lt;/title&gt;
&lt;/head&gt;</code></pre>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'prose'::public.block_type, NULL, 'Notice `&lt;` and `&gt;` above. To display a `<` character you cannot simply type it — the browser would read it as the start of a tag. Instead you write an entity: an ampersand, a name, and a semicolon.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'HTML entity', 'A code that stands in for a character. Written `&name;` — for example `&lt;` produces `<`.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, 'The entities worth knowing', NULL,
       '&lt;   →  <     (less than — the start of a tag)
&gt;   →  >     (greater than)
&amp;  →  &     (ampersand — the start of an entity)
&quot; →  "     (double quotation mark)
&nbsp; →        (a space that never breaks across lines)
&copy; →  ©
&mdash;→  —     (an em dash)', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'code-entities-and-lists';
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
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'ol > li', NULL,
       NULL, NULL, 3, 3,
       'The ordered list has three steps', NULL, 1, true
from public.exercises e where e.slug = 'lists-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'ul > li', NULL,
       NULL, NULL, 3, 3,
       'The unordered list has three items', NULL, 1, true
from public.exercises e where e.slug = 'lists-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'dl > dt', NULL,
       NULL, NULL, 2, 2,
       'The description list has two terms', NULL, 1, true
from public.exercises e where e.slug = 'lists-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'dl > dd', NULL,
       NULL, NULL, 2, 2,
       'Each term has a description', NULL, 1, true
from public.exercises e where e.slug = 'lists-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
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
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'code', NULL,
       NULL, NULL, NULL, NULL,
       'The <code> element is still there', NULL, 1, true
from public.exercises e where e.slug = 'entities-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'text_content'::public.requirement_kind, 'code', NULL,
       '<title>', NULL, NULL, NULL,
       'The code element displays the text "<title>"', NULL, 1, true
from public.exercises e where e.slug = 'entities-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'title', NULL,
       NULL, NULL, 0, 0,
       'No accidental real <title> element was created', NULL, 1, true
from public.exercises e where e.slug = 'entities-debug';

commit;
