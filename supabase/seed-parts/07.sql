-- HTML Hero — course seed, part 7 of 10
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
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'aria-guided', 1, 'guided'::public.exercise_kind, 'Name three unnamed things',
       'Three elements here have no accessible name: a section, an icon-only button and a second nav. Name the section using its own heading with `aria-labelledby`, the button with `aria-label`, and the nav with `aria-label`.', '<section>
  <h2 id="hours-heading">Opening hours</h2>
  <p>Tuesday to Sunday, 8am to 6pm.</p>
</section>

<button type="button">
  <img src="/learning-media/icons/search.svg" alt="" width="24" height="24">
</button>

<nav>
  <ul><li><a href="privacy.html">Privacy</a></li></ul>
</nav>', '<section aria-labelledby="hours-heading">
  <h2 id="hours-heading">Opening hours</h2>
  <p>Tuesday to Sunday, 8am to 6pm.</p>
</section>

<button type="button" aria-label="Search">
  <img src="/learning-media/icons/search.svg" alt="" width="24" height="24">
</button>

<nav aria-label="Footer">
  <ul><li><a href="privacy.html">Privacy</a></li></ul>
</nav>', ARRAY['The heading already has id="hours-heading" — point aria-labelledby at it.', 'The button contains only an icon, so it needs aria-label="Search".', 'Give the nav an aria-label describing which navigation it is.']::text[],
       50, 3,
       (select id from public.skills where slug = 'aria'), false
from public.lessons l where l.slug = 'aria-fundamentals'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'section', 'aria-labelledby',
       'hours-heading', NULL, NULL, NULL,
       'The section is named by its heading', NULL, 1, true
from public.exercises e where e.slug = 'aria-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'button', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The icon-only button has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'aria-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav is labelled', NULL, 1, true
from public.exercises e where e.slug = 'aria-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'accessible_name'::public.requirement_kind, 'button', NULL,
       NULL, NULL, NULL, NULL,
       'The button has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'aria-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_value'::public.requirement_kind, 'button img', 'alt',
       '', NULL, NULL, NULL,
       'The decorative icon uses alt=""', NULL, 1, true
from public.exercises e where e.slug = 'aria-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'aria-debug', 2, 'debug'::public.exercise_kind, 'ARIA that makes things worse',
       'Every line here uses ARIA where native HTML would be better, or uses it wrongly. Rewrite them all with correct native elements.', '<div role="button" tabindex="0">Send</div>
<div role="heading" aria-level="2">Our routes</div>
<span role="link" tabindex="0">Prices</span>
<ul role="list"><li role="listitem">Helmet</li></ul>', '<button type="button">Send</button>
<h2>Our routes</h2>
<a href="prices.html">Prices</a>
<ul><li>Helmet</li></ul>', ARRAY['role="button" on a div should just be a <button>.', 'role="heading" aria-level="2" should just be an <h2>.', 'role="link" should be an <a href="…">.', 'A <ul> already has the list role — the ARIA is redundant noise.']::text[],
       55, 3,
       (select id from public.skills where slug = 'aria'), false
from public.lessons l where l.slug = 'aria-fundamentals'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'button', NULL,
       NULL, NULL, NULL, NULL,
       'The action is a real button', NULL, 1, true
from public.exercises e where e.slug = 'aria-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_present'::public.requirement_kind, 'h2', NULL,
       NULL, NULL, NULL, NULL,
       'The heading is a real h2', NULL, 1, true
from public.exercises e where e.slug = 'aria-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'a', 'href',
       NULL, NULL, NULL, NULL,
       'The link is a real link with an href', NULL, 1, true
from public.exercises e where e.slug = 'aria-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, '[role]', NULL,
       NULL, NULL, 0, 0,
       'No redundant role attributes remain', NULL, 1, true
from public.exercises e where e.slug = 'aria-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, '[tabindex]', NULL,
       NULL, NULL, 0, 0,
       'No tabindex needed — native elements are focusable already', NULL, 1, true
from public.exercises e where e.slug = 'aria-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_present'::public.requirement_kind, 'ul > li', NULL,
       NULL, NULL, NULL, NULL,
       'The list is still a list', NULL, 1, true
from public.exercises e where e.slug = 'aria-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'aria-fundamentals'), NULL, 'q-aria-first-rule', 1, 'single'::public.question_kind,
        'What is the first rule of ARIA?', 'Do not use ARIA if a native HTML element will do the job.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Always add a role to every element', false, NULL
from public.quiz_questions where slug = 'q-aria-first-rule';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Use aria-label on everything', false, NULL
from public.quiz_questions where slug = 'q-aria-first-rule';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Add ARIA before writing HTML', false, NULL
from public.quiz_questions where slug = 'q-aria-first-rule';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Do not use it if a native element will do', true, NULL
from public.quiz_questions where slug = 'q-aria-first-rule';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'aria-fundamentals'), NULL, 'q-aria-behaviour', 2, 'single'::public.question_kind,
        'Does `role="button"` make a `<div>` respond to the Enter key?', 'No. ARIA changes what is announced, never how an element behaves. You would have to add focus handling and key handling yourself.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Yes, the browser adds button behaviour', false, NULL
from public.quiz_questions where slug = 'q-aria-behaviour';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Only if tabindex="0" is also set', false, NULL
from public.quiz_questions where slug = 'q-aria-behaviour';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only in screen readers', false, NULL
from public.quiz_questions where slug = 'q-aria-behaviour';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'No — ARIA changes announcements, not behaviour', true, NULL
from public.quiz_questions where slug = 'q-aria-behaviour';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'aria-fundamentals'), NULL, 'q-labelledby-vs-label', 3, 'single'::public.question_kind,
        'A section has a visible `<h2>`. How should you name the section?', '`aria-labelledby` pointing at the heading, so the name and the visible text can never disagree.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It does not need a name', false, NULL
from public.quiz_questions where slug = 'q-labelledby-vs-label';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'aria-labelledby pointing at the heading''s id', true, NULL
from public.quiz_questions where slug = 'q-labelledby-vs-label';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'aria-label repeating the heading text', false, NULL
from public.quiz_questions where slug = 'q-labelledby-vs-label';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A title attribute', false, NULL
from public.quiz_questions where slug = 'q-labelledby-vs-label';
-- lesson: States, and changes worth announcing
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'aria-live-and-state', 2, 'States, and changes worth announcing', 'What to say when something happens without a page load', 'A change nobody is told about did not happen, as far as a screen-reader user is concerned. This is the part of ARIA that earns its place.',
       ARRAY['Use `aria-expanded`, `aria-current` and `aria-invalid` correctly', 'Explain what a live region is and when one is justified', 'Recognise the states native HTML already manages for you']::text[], 15, 40, (select id from public.skills where slug = 'aria'), 0.7
from public.modules m where m.slug = 'aria-and-accessible-forms'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A form shows an error message above the field after a failed submit. Focus stays where it was. What does a screen-reader user hear?',
       NULL, NULL, NULL, '{"options":["Nothing — the message appeared silently, in a place they have already passed","The message, because new content is always announced","The message, but only after they press Tab","An error tone from the browser"],"answer":"Nothing at all. Adding content to a page does not announce it; screen readers read what is focused or what the user navigates to, and this message appeared above a field they have already moved past. Making it heard takes a deliberate act — a live region, or moving focus. This is the gap ARIA live regions exist to close, and it is the one situation where reaching for ARIA is clearly right."}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Apply the state attributes worth knowing to real controls","Choose between `polite`, `assertive` and moving focus","Avoid the live-region mistakes that make a page worse"]}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'A state is a fact about a control that can change: open or closed, current or not, valid or invalid. Sighted users read state from the visuals. Everyone else needs it in the markup — and if you built the control by hand, nothing puts it there for you.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'The states worth knowing', NULL,
       'aria-expanded="true|false"   is this control''s target open?
aria-current="page|step|true" which item in this set is the current one?
aria-invalid="true"           did this field fail validation?
aria-describedby="id"         extra description, read after the name
aria-pressed="true|false"     is this toggle button pressed in?
aria-disabled="true"          announced as unavailable, but still focusable', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Native elements manage their own state', '`<details>` maintains `expanded` as the user opens and closes it. A checkbox maintains `checked`. A modal `<dialog>` maintains its own presence and focus. You only need these attributes for controls you have built yourself out of parts that do not know what they are — which is one more argument for not building them.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'interactive_demo'::public.block_type, 'Marking the current page', 'Three navs. Only one tells a screen-reader user where they are.',
       NULL, NULL, NULL, '{"variants":[{"label":"With aria-current","code":"<nav aria-label=\"Main\"><a href=\"index.html\">Home</a> <a href=\"menu.html\" aria-current=\"page\">Menu</a> <a href=\"contact.html\">Contact</a></nav>","note":"The current item is announced as \"Menu, current page\". The user knows where they are without reading the whole page."},{"label":"Styled only","code":"<nav aria-label=\"Main\"><a href=\"index.html\">Home</a> <a href=\"menu.html\" class=\"active\">Menu</a> <a href=\"contact.html\">Contact</a></nav>","note":"A class name is invisible to assistive technology. Visually obvious, silently absent for everyone else."},{"label":"No link at all","code":"<nav aria-label=\"Main\"><a href=\"index.html\">Home</a> <span>Menu</span> <a href=\"contact.html\">Contact</a></nav>","note":"Removing the link removes it from the keyboard order and from the list of links, so the set now looks incomplete."}]}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'term'::public.block_type, 'Live region', 'An area whose changes are announced without focus moving there. `aria-live="polite"` waits for a pause in speech; `aria-live="assertive"` interrupts immediately.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<p id="status" role="status"></p>

<p id="email-error" role="alert">
  Enter an email address in the format name@example.com
</p>

<input type="email" id="email" name="email"
       aria-describedby="email-error" aria-invalid="true">', 'html', NULL, '{"annotations":[{"line":"1","text":"`role=\"status\"` is a polite live region. Crucially the element exists in the page *before* the message arrives — a live region added at the same moment as its content is usually not announced at all."},{"line":"3","text":"`role=\"alert\"` is an assertive live region. It interrupts, so it is right for a validation failure and wrong for a \"saved\" confirmation."},{"line":"7","text":"`aria-describedby` ties the message to the field, so the message is read when the user reaches it — separately from the announcement."},{"line":"7","text":"`aria-invalid=\"true\"` marks the field itself as failing, so it is announced as invalid rather than merely having a description."}]}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'callout'::public.block_type, 'The three live-region mistakes', 'First: creating the region and its content at the same time — the region must already be in the page for a change to be noticed. Second: reaching for `assertive` everywhere, which interrupts whatever the user was listening to; reserve it for errors and genuine emergencies. Third: marking a large container as live, so every unrelated change inside it is read out.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'predict_check'::public.block_type, 'Predict, then check', 'A hand-built disclosure. The markup is correct as written. Before you check: what breaks the moment a learner wires up the click handler and forgets one line?',
       '<button type="button" aria-expanded="false" aria-controls="hours">
  Opening hours
</button>
<div id="hours" hidden>
  <p>Tuesday to Sunday, 8am to 6pm.</p>
</div>', 'html', NULL, '{"outcome":"`aria-expanded` stays `false` forever. The panel opens, the arrow turns, sighted users see the change — and every screen-reader user is told the control is still collapsed. Nothing errors and nothing looks wrong, which is exactly why it survives review. The native `<details>` and `<summary>` pair carries this state itself and cannot fall out of step, which is why it is the better answer whenever it fits."}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'Announce, or move focus?', 'A live region tells the user something changed while leaving them where they are. Moving focus takes them to it. Use a live region for information that does not need acting on — "Saved", "Three results". Move focus when the user has to do something next: after a failed submit, sending focus to the first invalid field is more use than any announcement, because it both tells them and puts them where the work is.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["State attributes describe what a control *is doing*: expanded, current, invalid, pressed.","Native elements maintain their own state; hand-built ones do not, and drift silently.","`role=\"status\"` is polite, `role=\"alert\"` interrupts — and the element must already exist.","For anything the user must act on, moving focus beats announcing."],"nextUp":"Next: forms, where all of this comes together."}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What does `aria-expanded` describe, and what keeps it accurate on a `<details>`?","Name the three common live-region mistakes.","When should you move focus rather than announce?"],"points":["Whether the control''s target is currently open. `<details>` maintains it natively, so it cannot drift out of step with what is on screen; a hand-built disclosure only stays accurate if you update it yourself.","Creating the region and its content at the same moment; using `assertive` when `polite` would do; marking too large a container as live so unrelated changes are announced.","When the user has to act next — a failed submit should move focus to the first invalid field, which both informs them and puts them where the work is."]}'::jsonb
from public.lessons where slug = 'aria-live-and-state';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'aria-state-guided', 1, 'guided'::public.exercise_kind, 'Mark the current page and connect an error',
       'Two jobs. In the nav, mark `menu.html` as the page currently being viewed using `aria-current`. Below it, connect the error message to the email field with `aria-describedby`, mark the field invalid, and make the message announce itself with `role="alert"`.', '<nav aria-label="Main">
  <a href="index.html">Home</a>
  <a href="menu.html" class="active">Menu</a>
  <a href="contact.html">Contact</a>
</nav>

<p id="email-error">Enter an email address in the format name@example.com</p>
<label for="email">Email address</label>
<input type="email" id="email" name="email">', '<nav aria-label="Main">
  <a href="index.html">Home</a>
  <a href="menu.html" aria-current="page">Menu</a>
  <a href="contact.html">Contact</a>
</nav>

<p id="email-error" role="alert">Enter an email address in the format name@example.com</p>
<label for="email">Email address</label>
<input type="email" id="email" name="email"
       aria-describedby="email-error" aria-invalid="true">', ARRAY['aria-current="page" goes on the link to the page you are already on.', 'aria-describedby takes the id of the message element.', 'The field itself needs aria-invalid="true", and the message needs role="alert".']::text[],
       45, 3,
       (select id from public.skills where slug = 'aria'), false
from public.lessons l where l.slug = 'aria-live-and-state'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'a[href="menu.html"]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page is marked with aria-current="page"', NULL, 1, true
from public.exercises e where e.slug = 'aria-state-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'p', 'role',
       'alert', NULL, NULL, NULL,
       'The error message is an assertive live region', NULL, 1, true
from public.exercises e where e.slug = 'aria-state-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'input', 'aria-describedby',
       'email-error', NULL, NULL, NULL,
       'The field is described by the error message', NULL, 1, true
from public.exercises e where e.slug = 'aria-state-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'input', 'aria-invalid',
       'true', NULL, NULL, NULL,
       'The field is marked invalid', NULL, 1, true
from public.exercises e where e.slug = 'aria-state-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'The field still has its label', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'aria-state-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'aria-state-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'aria-state-debug', 2, 'debug'::public.exercise_kind, 'ARIA that makes the page worse',
       'Every piece of ARIA below is actively harmful: a `role="button"` on a `<div>`, an `aria-label` on a `<span>` where it is ignored, an `aria-hidden` hiding a real control from assistive technology, and `aria-live="assertive"` on a whole region. Repair each one, preferring native HTML.', '<main aria-live="assertive">
  <h1>Book a table</h1>
  <div role="button">Book now</div>
  <span aria-label="Closed today">Closed</span>
  <button type="button" aria-hidden="true">Cancel</button>
</main>', '<main>
  <h1>Book a table</h1>
  <button type="button">Book now</button>
  <p>Closed today</p>
  <button type="button">Cancel</button>
</main>', ARRAY['A role does not make something operable — use the real element instead.', 'aria-label is ignored on a plain span; put the words in the page as text.', 'aria-hidden on a focusable control creates something reachable by Tab but invisible to a screen reader. Remove it.', 'A whole region marked assertive announces every change inside it. Remove it entirely.']::text[],
       55, 4,
       (select id from public.skills where slug = 'aria'), false
from public.lessons l where l.slug = 'aria-live-and-state'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, '[role="button"]', NULL,
       NULL, NULL, 0, 0,
       'No element fakes a button with a role', NULL, 1, true
from public.exercises e where e.slug = 'aria-state-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'button', NULL,
       NULL, NULL, 2, 2,
       'Both actions are real buttons', NULL, 1, true
from public.exercises e where e.slug = 'aria-state-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, '[aria-hidden="true"]', NULL,
       NULL, NULL, 0, 0,
       'Nothing interactive is hidden from assistive technology', NULL, 1, true
from public.exercises e where e.slug = 'aria-state-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_absent'::public.requirement_kind, 'main', 'aria-live',
       NULL, NULL, NULL, NULL,
       'The whole region is no longer a live region', NULL, 1, true
from public.exercises e where e.slug = 'aria-state-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'text_content'::public.requirement_kind, 'main', NULL,
       'Closed today', NULL, NULL, NULL,
       'The closed message is real text on the page', NULL, 1, true
from public.exercises e where e.slug = 'aria-state-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one <main>', NULL, 1, true
from public.exercises e where e.slug = 'aria-state-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'aria-live-and-state'), NULL, 'q-aria-current-page', 1, 'single'::public.question_kind,
        'How do you tell assistive technology which nav item is the page currently open?', '`aria-current="page"` marks the current item. A CSS class is invisible to assistive technology.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`aria-selected="true"`', false, NULL
from public.quiz_questions where slug = 'q-aria-current-page';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`aria-current="page"` on that link', true, NULL
from public.quiz_questions where slug = 'q-aria-current-page';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A class such as `active`', false, NULL
from public.quiz_questions where slug = 'q-aria-current-page';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Removing the href so it is not a link', false, NULL
from public.quiz_questions where slug = 'q-aria-current-page';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'aria-live-and-state'), NULL, 'q-live-region-timing', 2, 'single'::public.question_kind,
        'Why must a live region already exist in the page before its message arrives?', 'Assistive technology watches an existing region for changes. A region created together with its content usually produces no announcement at all.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It does not matter — order is irrelevant', false, NULL
from public.quiz_questions where slug = 'q-live-region-timing';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Because `aria-live` only works on page load', false, NULL
from public.quiz_questions where slug = 'q-live-region-timing';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Assistive tech announces changes to a region it is already watching', true, NULL
from public.quiz_questions where slug = 'q-live-region-timing';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Because the CSS has to load first', false, NULL
from public.quiz_questions where slug = 'q-live-region-timing';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'aria-live-and-state'), NULL, 'q-assertive-vs-polite', 3, 'single'::public.question_kind,
        'When is `aria-live="assertive"` (or `role="alert"`) the right choice?', 'Assertive interrupts whatever is being read. That is justified for an error or an emergency, and rude for a routine confirmation.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'For "saved" confirmations', false, NULL
from public.quiz_questions where slug = 'q-assertive-vs-polite';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Whenever the region is visually prominent', false, NULL
from public.quiz_questions where slug = 'q-assertive-vs-polite';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'For validation errors and genuine emergencies', true, NULL
from public.quiz_questions where slug = 'q-assertive-vs-polite';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'For every status message, so nothing is missed', false, NULL
from public.quiz_questions where slug = 'q-assertive-vs-polite';
-- lesson: Accessible forms
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'accessible-forms-in-depth', 3, 'Accessible forms', 'Labels, groups, errors, and the WCAG 2.2 criteria that are pure markup', 'Forms are where accessibility failures cost people money and appointments. Almost all of it is markup you already know, used deliberately.',
       ARRAY['Label every control, including groups of related ones', 'Use `autocomplete` so people are not asked to retype what the browser knows', 'Build an error message that is announced, connected and actionable']::text[], 18, 40, (select id from public.skills where slug = 'accessibility'), 0.7
from public.modules m where m.slug = 'aria-and-accessible-forms'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A checkout form asks for a delivery address, then asks for it again on a later step as "billing address". Which WCAG 2.2 criterion does that risk failing?',
       NULL, NULL, NULL, '{"options":["Redundant Entry — asking again for information already given","None; repeating a question is always allowed","Contrast Minimum","Page Titled"],"answer":"Redundant Entry (3.3.7, added in WCAG 2.2). Asking someone to supply the same information twice in one process is a genuine barrier for people with memory or motor impairments, and simply annoying for everyone else. The fix is to auto-populate it, or offer it as a selectable option. It is worth knowing this criterion exists because it is one of several in 2.2 that are solved with markup rather than design."}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Associate every control with a label, and every group with a legend","Apply `autocomplete` tokens correctly","Connect and announce validation errors"]}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'visual'::public.block_type, NULL, 'A label and its input, joined by matching `for` and `id`.',
       NULL, NULL, 'form-anatomy', '{}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'prose'::public.block_type, NULL, 'You met `<label>` in Level 6. Here it matters for a different reason: a control with no label has no accessible name, so it is announced as "edit text" and a voice-control user has nothing to say to reach it.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'The same field, labelled and not', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Labelled","code":"<label for=\"postcode\">Postcode</label>\n<input type=\"text\" id=\"postcode\" name=\"postcode\"\n       autocomplete=\"postal-code\">","why":"Announced as \"Postcode, edit text\". Clicking the word focuses the field, which also makes it an easier target for anyone with a tremor. Autofill works."},"bad":{"label":"Placeholder only","code":"<input type=\"text\" name=\"postcode\" placeholder=\"Postcode\">","why":"No name. The placeholder disappears the moment typing starts, so the one hint about what the field wants is gone exactly when it is needed."}}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'term'::public.block_type, 'Fieldset and legend', 'A `<fieldset>` groups related controls and its `<legend>` names the group. Without them, a set of radio buttons is announced as a series of unrelated options with no indication of the question they answer.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'code_example'::public.block_type, 'A group that announces its own question', NULL,
       '<fieldset>
  <legend>How should we contact you?</legend>

  <input type="radio" id="by-email" name="contact" value="email">
  <label for="by-email">Email</label>

  <input type="radio" id="by-phone" name="contact" value="phone">
  <label for="by-phone">Phone</label>
</fieldset>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'prose'::public.block_type, NULL, '`autocomplete` is not a convenience feature. WCAG 2.1 made it a requirement for fields collecting information about the user, because it lets browsers and assistive tools fill in details someone may find slow, painful or impossible to type accurately.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'code_example'::public.block_type, 'The autocomplete tokens you will actually use', NULL,
       'name              given-name        family-name
email             tel               organization
street-address    address-level2    postal-code    country-name
cc-name           cc-number         cc-exp
username          current-password  new-password
bday              url', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'callout'::public.block_type, 'Never block paste on a password field', 'WCAG 2.2 added Accessible Authentication (3.3.8). Blocking paste, or forbidding a password manager, forces people to transcribe a long random string by hand — which is precisely what someone with a cognitive or motor impairment cannot reliably do, and which pushes everyone else towards weaker passwords. Use `autocomplete="current-password"` and leave paste alone.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'worked_example'::public.block_type, 'Building an error message that actually works', 'The field has been submitted empty. Four things have to be true before that failure is usable, and they are usually added in the wrong order — or three out of four.',
       NULL, NULL, NULL, '{"steps":[{"title":"Say what is wrong, in words","code":"<p id=\"email-error\">Enter an email address</p>","reasoning":"Not \"invalid input\". The message has to name the field and the problem, because it may be read in isolation, far from the field it describes."},{"title":"Say how to fix it","code":"<p id=\"email-error\">Enter an email address in the format name@example.com</p>","reasoning":"A message that only reports failure leaves the user guessing at the rule. Showing the shape of a correct answer turns a dead end into an instruction."},{"title":"Connect it to the field","code":"<input type=\"email\" id=\"email\" name=\"email\"\n       aria-describedby=\"email-error\" aria-invalid=\"true\">","reasoning":"`aria-describedby` means the message is read when the user reaches the field, however they got there. `aria-invalid` marks the field itself as failing, so it is announced as invalid rather than merely described."},{"title":"Make it announce itself","code":"<p id=\"email-error\" role=\"alert\">Enter an email address in the format name@example.com</p>","reasoning":"Without this, a message that appears after a failed submit is silent — the user is left waiting for a response that already happened. This is the step most often missed, because nothing about the page looks wrong without it."}]}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'callout'::public.block_type, '`required` is a hint, never a guarantee', 'Client-side validation attributes — `required`, `pattern`, `type="email"`, `maxlength` — improve the experience for people filling the form honestly. They are enforced by the browser, so they stop nobody who does not want to be stopped. The server must check everything again, and Level 10 makes the same point about security.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'checklist'::public.block_type, 'Before you ship a form', NULL,
       NULL, NULL, NULL, '{"items":["Every control has a `<label>` with a matching `for` and `id`","Every group of related controls sits in a `<fieldset>` with a `<legend>`","Every field about the user has an `autocomplete` token","Errors say what is wrong *and* how to fix it","Errors are connected with `aria-describedby` and marked with `aria-invalid`","Errors announce themselves, or focus moves to the first failing field","Paste is allowed everywhere, especially on passwords","Nothing is asked for twice in the same process"]}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'interactive_demo'::public.block_type, 'An error message, connected and unconnected', 'The same failure, reported three ways.',
       NULL, NULL, NULL, '{"variants":[{"label":"Fully connected","code":"<p id=\"email-error\" role=\"alert\">Enter an email address in the format name@example.com</p>\n<label for=\"email\">Email address</label>\n<input type=\"email\" id=\"email\" name=\"email\" aria-describedby=\"email-error\" aria-invalid=\"true\">","note":"Announced when it appears, read again when the field is reached, and the field itself reports as invalid."},{"label":"Visible only","code":"<p class=\"error\">Enter an email address in the format name@example.com</p>\n<label for=\"email\">Email address</label>\n<input type=\"email\" id=\"email\" name=\"email\">","note":"Perfectly visible and completely silent. Nothing announces it, and reaching the field tells the user nothing is wrong."},{"label":"Connected but silent","code":"<p id=\"email-error\">Enter an email address in the format name@example.com</p>\n<label for=\"email\">Email address</label>\n<input type=\"email\" id=\"email\" name=\"email\" aria-describedby=\"email-error\" aria-invalid=\"true\">","note":"Better — reaching the field now reads the message — but nothing is announced when it first appears, so a user who submitted and waited hears nothing at all."}]}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 15, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["A control with no label has no name, and cannot be reached by voice.","`<fieldset>` and `<legend>` are what make a group of radios a question rather than a list.","`autocomplete` is a WCAG requirement for fields about the user, not a nicety.","A usable error says what is wrong, how to fix it, is connected with `aria-describedby`, and is announced."],"nextUp":"Next: the milestone — a page written to fail, for you to repair."}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 16, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why is a placeholder not a label?","What do `<fieldset>` and `<legend>` add that labels alone cannot?","List the four things a usable error message needs."],"points":["Because it supplies no accessible name, and it disappears as soon as the user starts typing — removing the only hint at exactly the moment it is needed.","They name the *group*, so a set of radio buttons is announced together with the question it answers instead of as unrelated options.","It says what is wrong; it says how to fix it; it is connected to the field with `aria-describedby` and `aria-invalid`; and it announces itself with `role=\"alert\"` or focus moves to the failing field."]}'::jsonb
from public.lessons where slug = 'accessible-forms-in-depth';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'accessible-form-challenge', 1, 'challenge'::public.exercise_kind, 'Build an accessible booking form',
       'Build a form containing: a name field, an email field, a grouped pair of radio buttons asking how to contact the person, and a submit button. Every control labelled, the radios grouped with a legend, and `autocomplete` on the fields about the user. Your wording throughout.', '<h1>Book a table</h1>
<form action="/book" method="post">

</form>', '<h1>Book a table</h1>
<form action="/book" method="post">
  <label for="name">Full name</label>
  <input type="text" id="name" name="name" autocomplete="name" required>

  <label for="email">Email address</label>
  <input type="email" id="email" name="email" autocomplete="email" required>

  <fieldset>
    <legend>How should we confirm your booking?</legend>

    <input type="radio" id="by-email" name="contact" value="email">
    <label for="by-email">By email</label>

    <input type="radio" id="by-phone" name="contact" value="phone">
    <label for="by-phone">By phone</label>
  </fieldset>

  <button type="submit">Request a table</button>
</form>', ARRAY['Each input needs an id, and each label needs a for matching it.', 'Wrap the two radio buttons in a <fieldset> and give it a <legend>.', 'autocomplete="name" and autocomplete="email" are the tokens for those two fields.', 'The submit control is <button type="submit">, not an <input type="button">.']::text[],
       60, 4,
       (select id from public.skills where slug = 'accessibility'), false
from public.lessons l where l.slug = 'accessible-forms-in-depth'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'form', NULL,
       NULL, NULL, NULL, NULL,
       'There is a form', NULL, 1, true
from public.exercises e where e.slug = 'accessible-form-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'Every input has an associated label', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'accessible-form-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'fieldset', NULL,
       NULL, NULL, NULL, NULL,
       'The related radio buttons are grouped in a fieldset', NULL, 1, true
from public.exercises e where e.slug = 'accessible-form-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'direct_child'::public.requirement_kind, 'legend', NULL,
       NULL, 'fieldset', NULL, NULL,
       'The fieldset has a legend naming the group', NULL, 1, true
from public.exercises e where e.slug = 'accessible-form-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'text_not_empty'::public.requirement_kind, 'legend', NULL,
       NULL, NULL, NULL, NULL,
       'The legend asks the question', NULL, 1, true
from public.exercises e where e.slug = 'accessible-form-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'input[type="radio"]', NULL,
       NULL, NULL, 2, NULL,
       'There are at least two radio options', NULL, 1, true
from public.exercises e where e.slug = 'accessible-form-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'attribute_value'::public.requirement_kind, 'input[type="email"]', 'autocomplete',
       'email', NULL, NULL, NULL,
       'The email field carries autocomplete="email"', NULL, 1, true
from public.exercises e where e.slug = 'accessible-form-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'element_present'::public.requirement_kind, 'button[type="submit"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a submit button', NULL, 1, true
from public.exercises e where e.slug = 'accessible-form-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'accessible-form-challenge';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'accessible-form-debug', 2, 'debug'::public.exercise_kind, 'A form nobody can complete',
       'This form has four failures: a placeholder standing in for a label, radios with no group or legend, an error message connected to nothing, and a missing `autocomplete`. Repair all four.', '<form action="/book" method="post">
  <input type="text" name="name" placeholder="Full name">

  <p id="name-error">That is not valid</p>

  <input type="radio" id="by-email" name="contact" value="email">
  <label for="by-email">By email</label>
  <input type="radio" id="by-phone" name="contact" value="phone">
  <label for="by-phone">By phone</label>

  <button type="submit">Send</button>
</form>', '<form action="/book" method="post">
  <label for="name">Full name</label>
  <input type="text" id="name" name="name" autocomplete="name"
         aria-describedby="name-error" aria-invalid="true">

  <p id="name-error" role="alert">Enter your full name as it appears on your card</p>

  <fieldset>
    <legend>How should we confirm your booking?</legend>

    <input type="radio" id="by-email" name="contact" value="email">
    <label for="by-email">By email</label>
    <input type="radio" id="by-phone" name="contact" value="phone">
    <label for="by-phone">By phone</label>
  </fieldset>

  <button type="submit">Send</button>
</form>', ARRAY['Replace the placeholder with a real <label for="name">, and give the input a matching id.', 'Wrap the two radios in a <fieldset> with a <legend>.', 'Connect the message with aria-describedby, mark the field aria-invalid, and give the message role="alert".', 'The name field should carry autocomplete="name".']::text[],
       55, 4,
       (select id from public.skills where slug = 'accessibility'), false
from public.lessons l where l.slug = 'accessible-forms-in-depth'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'label_association'::public.requirement_kind, 'input[type="text"]', NULL,
       NULL, NULL, NULL, NULL,
       'The text field has a real label', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'accessible-form-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'input[type="text"]', 'autocomplete',
       'name', NULL, NULL, NULL,
       'The name field carries autocomplete="name"', NULL, 1, true
from public.exercises e where e.slug = 'accessible-form-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'input[type="text"]', 'aria-describedby',
       'name-error', NULL, NULL, NULL,
       'The error message is connected to the field', NULL, 1, true
from public.exercises e where e.slug = 'accessible-form-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'p', 'role',
       'alert', NULL, NULL, NULL,
       'The error message announces itself', NULL, 1, true
from public.exercises e where e.slug = 'accessible-form-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'fieldset', NULL,
       NULL, NULL, NULL, NULL,
       'The radios are grouped in a fieldset', NULL, 1, true
from public.exercises e where e.slug = 'accessible-form-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'direct_child'::public.requirement_kind, 'legend', NULL,
       NULL, 'fieldset', NULL, NULL,
       'The group has a legend', NULL, 1, true
from public.exercises e where e.slug = 'accessible-form-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'accessible-form-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'accessible-forms-in-depth'), NULL, 'q-placeholder-not-label', 1, 'single'::public.question_kind,
        'Why is a placeholder not an acceptable substitute for a `<label>`?', 'It gives the control no accessible name, and it vanishes as soon as the user starts typing.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It supplies no accessible name and disappears once typing starts', true, NULL
from public.quiz_questions where slug = 'q-placeholder-not-label';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It cannot be styled', false, NULL
from public.quiz_questions where slug = 'q-placeholder-not-label';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is not supported in older browsers', false, NULL
from public.quiz_questions where slug = 'q-placeholder-not-label';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is only a problem on mobile', false, NULL
from public.quiz_questions where slug = 'q-placeholder-not-label';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'accessible-forms-in-depth'), NULL, 'q-fieldset-legend', 2, 'single'::public.question_kind,
        'What do `<fieldset>` and `<legend>` provide for a set of radio buttons?', 'They name the group, so the options are announced together with the question they answer.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'They are purely decorative', false, NULL
from public.quiz_questions where slug = 'q-fieldset-legend';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'They set the tab order for the group', false, NULL
from public.quiz_questions where slug = 'q-fieldset-legend';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A name for the group, so the question is announced with the options', true, NULL
from public.quiz_questions where slug = 'q-fieldset-legend';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'They make the radios mutually exclusive', false, NULL
from public.quiz_questions where slug = 'q-fieldset-legend';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'accessible-forms-in-depth'), NULL, 'q-autocomplete-requirement', 3, 'single'::public.question_kind,
        'Why does `autocomplete` matter for accessibility, not just convenience?', 'WCAG requires it on fields collecting information about the user, so browsers and assistive tools can fill in details that are slow or painful to type.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It replaces the need for a label', false, NULL
from public.quiz_questions where slug = 'q-autocomplete-requirement';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It validates the value for you', false, NULL
from public.quiz_questions where slug = 'q-autocomplete-requirement';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It lets tools fill in details some people cannot type quickly or accurately', true, NULL
from public.quiz_questions where slug = 'q-autocomplete-requirement';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It makes form submission faster on the server', false, NULL
from public.quiz_questions where slug = 'q-autocomplete-requirement';
-- lesson: Milestone: audit and repair an inaccessible site
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'accessibility-audit-milestone', 4, 'Milestone: audit and repair an inaccessible site', 'Fifteen deliberate failures, one page', 'The page in this milestone was written to fail. Your job is to find and fix everything.',
       ARRAY['Audit a page systematically against WCAG principles', 'Repair every failure using correct HTML', 'Produce a page that passes a keyboard test']::text[], 30, 40, (select id from public.skills where slug = 'accessibility'), 0.85
from public.modules m where m.slug = 'aria-and-accessible-forms'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Run a systematic accessibility audit","Repair structural, media and form accessibility failures","Verify with a keyboard test"]}'::jsonb
from public.lessons where slug = 'accessibility-audit-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'checklist'::public.block_type, 'Audit in this order — structure first', NULL,
       NULL, NULL, NULL, '{"items":["Does `<html>` declare a `lang`?","Is there exactly one `<h1>`, and no skipped heading levels?","Are there landmarks — header, nav, main, footer?","Is there a skip link, and does it point at something real?","Does every image have an appropriate `alt`?","Does every form control have a `<label>`?","Does every link have text that makes sense alone?","Are buttons `<button>` and links `<a href>`?","Are all ids unique?","Does every `<iframe>` have a `title`?","Do videos have captions?","Are error messages connected with `aria-describedby`?"]}'::jsonb
from public.lessons where slug = 'accessibility-audit-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'callout'::public.block_type, 'Fix in order of impact', 'A missing `<main>` affects every screen-reader user on every visit. A slightly wordy alt attribute affects almost nobody. When auditing a real site, deal with structure, names and keyboard access first — those are the things that make a page unusable rather than merely imperfect.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'accessibility-audit-milestone';
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
select id, 6, 'interactive_demo'::public.block_type, 'One repair, three times over', 'The commonest three failures, before and after.',
       NULL, NULL, NULL, '{"variants":[{"label":"Repaired","code":"<label for=\"email\">Email address</label>\n<input type=\"email\" id=\"email\" name=\"email\" autocomplete=\"email\">\n<button type=\"button\">Search</button>\n<img src=\"/learning-media/images/team-portrait.jpg\" alt=\"Priya Raman, head baker\" width=\"800\" height=\"800\">","note":"A named field, a real button, and an image described rather than named. All three announce usefully."},{"label":"As found","code":"<input type=\"text\" placeholder=\"Email\">\n<div class=\"btn\">Search</div>\n<img src=\"/learning-media/images/team-portrait.jpg\" alt=\"portrait\">","note":"A field with no name, a control no keyboard can reach, and alt text that names the file type rather than the person."}]}'::jsonb
from public.lessons where slug = 'accessibility-audit-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'recall'::public.block_type, 'Everything so far, applied at once', 'This audit uses almost everything you have learned. Close the page and list, from memory, what you already know that applies here — grouped by where you learned it.',
       NULL, NULL, NULL, '{"points":["Level 2 — one `<h1>`, no skipped heading levels, because the outline is how many people navigate.","Level 3 — link text that works alone; `rel=\"noopener noreferrer\"` on anything opening in a new tab.","Level 4 — alt text describes what the image *does on this page*; `alt=\"\"` for decoration, and never a missing alt.","Level 5 — landmarks, and exactly one `<main>`.","Level 6 — every control labelled, related controls grouped in a `<fieldset>` with a `<legend>`.","Level 7 — native `<details>` and `<dialog>` maintain their own state, so it cannot drift out of step.","This level — keyboard operability first, accessible names second, and ARIA only where HTML cannot express it."]}'::jsonb
from public.lessons where slug = 'accessibility-audit-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'summary'::public.block_type, 'Lesson summary', NULL,
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
from public.lessons l where l.slug = 'accessibility-audit-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
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
from public.lessons l where l.slug = 'accessibility-audit-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
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
        'Which failure has the greatest impact on a screen-reader user?', 'Missing landmarks force the user to read from the top of every page, every time. That is a structural failure affecting every visit.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'Why do duplicate ids break accessibility?', 'Relationships like `for`, `aria-labelledby` and `aria-describedby` resolve to the first match, so a label may connect to the wrong control.', (select id from public.skills where slug = 'validation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'What are the four WCAG principles?', 'Perceivable, Operable, Understandable, Robust.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'Which gives a keyboard user the most benefit on a site with a large menu?', 'A skip link, letting them bypass the menu on every page.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'What does `aria-describedby` do?', 'It attaches additional descriptive text, announced after the element''s name — ideal for format hints and error messages.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'When should you use `aria-hidden="true"`?', 'Only on genuinely decorative content that adds nothing — never on anything a user might need.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'An icon-only button contains an `<img>`. Where should the accessible name come from?', '`aria-label` on the button, with `alt=""` on the image so the name is not announced twice.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'What makes an error message accessible?', 'Plain words, a stated fix, connection to the field with `aria-describedby`, and an announcement when it appears.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'Does adding `role="navigation"` to a `<nav>` improve anything?', 'No — `<nav>` already has that role. The extra attribute is redundant noise.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'What determines keyboard focus order by default?', 'The order elements appear in the HTML source.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'A page has an `<a>` with no `href`. What is the problem?', 'Without an `href` it is not a link: it cannot be focused with a keyboard and is not announced as a link.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
from public.courses c where c.slug = 'html-hero'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-9-milestone', 'milestone'::public.assessment_kind, 'Level 9 milestone: Metadata, SEO and Discoverability', 'Eight questions on metadata, social sharing and structured data. Pass mark 75%.',
       0.75, 180, 9
from public.levels l where l.slug = 'metadata-and-seo'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Page metadata
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'page-metadata', 1, 'Page metadata', 'Titles, descriptions, canonical URLs, favicons, language and robots directives.',
       45, false
from public.levels l where l.slug = 'metadata-and-seo'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'page-metadata' and p.slug = 'aria-and-accessible-forms';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'page-metadata' and s.slug = 'metadata';
-- lesson: Titles, descriptions and canonical URLs
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'titles-descriptions-canonicals', 1, 'Titles, descriptions and canonical URLs', 'The three things every page needs and most pages get wrong', 'Your title is the most-read sentence you will write. It appears in tabs, bookmarks, search results and shared links.',
       ARRAY['Write a page title that works in all four places it appears', 'Write a meta description that earns a click', 'Use a canonical URL to prevent duplicate-content problems']::text[], 15, 40, (select id from public.skills where slug = 'metadata'), 0.7
from public.modules m where m.slug = 'page-metadata'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
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
select id, 10, 'media_example'::public.block_type, 'Why every page needs its own title', 'Eight tabs open, all from the same site. The title is the only thing distinguishing them — which is why "Riverside Bakery" on every page makes a site unnavigable the moment somebody opens two of them.',
       '<title>Bike hire prices — Riverside Cycle Hire</title>
<title>Route guides — Riverside Cycle Hire</title>
<title>Contact and opening hours — Riverside Cycle Hire</title>', 'html', 'newsroom-desk', '{}'::jsonb
from public.lessons where slug = 'titles-descriptions-canonicals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'interactive_demo'::public.block_type, 'The same page, three titles', 'Each shown as it would appear in a browser tab and a search result.',
       NULL, NULL, NULL, '{"variants":[{"label":"Specific, distinctive first","code":"<title>Bike hire prices — Riverside Cycle Hire</title>","note":"Readable in a narrow tab, unique across the site, and the useful words come before the truncation point."},{"label":"Site name first","code":"<title>Riverside Cycle Hire — Bike hire prices</title>","note":"In a narrow tab the visitor sees only \"Riverside Cycl…\", which is identical on every page of the site."},{"label":"Keyword stuffed","code":"<title>Riverside Cycle Hire | Bike Hire | Cycling | Hexford | Home</title>","note":"Truncated in results, useless in a tab, and search engines have long since stopped rewarding it."}]}'::jsonb
from public.lessons where slug = 'titles-descriptions-canonicals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'summary'::public.block_type, 'Lesson summary', NULL,
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
from public.lessons l where l.slug = 'titles-descriptions-canonicals'
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
from public.lessons l where l.slug = 'titles-descriptions-canonicals'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
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
        'Roughly how long should a page title be?', 'About 50–60 characters, before search engines truncate it. Put the distinctive part first.', (select id from public.skills where slug = 'seo'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'What does `<link rel="canonical">` do?', 'It states the preferred URL for a page, resolving ambiguity when the same content is reachable at several addresses.', (select id from public.skills where slug = 'seo'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'Does `<meta name="robots" content="noindex">` hide a page?', 'No. It asks well-behaved crawlers not to index it. The page remains fully public to anyone with the URL.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
from public.modules m where m.slug = 'page-metadata'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
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
select id, 12, 'media_example'::public.block_type, 'The image a share card actually uses', 'A sharing image is not decoration — it is often the only thing seen before someone decides whether to click. It needs its own dimensions and an absolute URL, because the site rendering it is not yours.',
       '<meta property="og:image"
      content="https://riverside-cycles.example/learning-media/images/event-stage.jpg">
<meta property="og:image:width" content="1600">
<meta property="og:image:height" content="900">
<meta property="og:image:alt"
      content="A crowd silhouetted in front of a stage lit by pink and blue lights">', 'html', 'event-stage', '{}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'interactive_demo'::public.block_type, 'The same page, shared three ways', 'What a chat app or social network has to work with.',
       NULL, NULL, NULL, '{"variants":[{"label":"Full card","code":"<meta property=\"og:title\" content=\"Bike hire prices — Riverside Cycle Hire\">\n<meta property=\"og:description\" content=\"Hourly, daily and weekly hire from £6, helmet and route map included.\">\n<meta property=\"og:image\" content=\"https://riverside-cycles.example/share.jpg\">\n<meta property=\"og:image:alt\" content=\"A blue bicycle on a riverside path\">\n<meta property=\"og:url\" content=\"https://riverside-cycles.example/prices.html\">","note":"Title, description, image and a described image. The link arrives as a card somebody might actually click."},{"label":"Image with no alt","code":"<meta property=\"og:title\" content=\"Bike hire prices — Riverside Cycle Hire\">\n<meta property=\"og:image\" content=\"https://riverside-cycles.example/share.jpg\">","note":"The card renders, and screen-reader users on the sharing platform get an unlabelled image. `og:image:alt` is the only fix."},{"label":"Nothing declared","code":"<title>Bike hire prices — Riverside Cycle Hire</title>","note":"Platforms fall back to guessing — usually the title and whichever image they find first, which may be your logo or an advert."}]}'::jsonb
from public.lessons where slug = 'social-and-structured-data';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'summary'::public.block_type, 'Lesson summary', NULL,
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
from public.lessons l where l.slug = 'social-and-structured-data'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
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
from public.lessons l where l.slug = 'social-and-structured-data'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
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
        'Which attribute do Open Graph tags use?', '`property`, not `name`. Using `name` for `og:` tags is one of the commonest mistakes in this area.', (select id from public.skills where slug = 'seo'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'Does structured data improve your search ranking?', 'No. It can change how your result is *displayed* — rich snippets, star ratings, event dates — which affects clicks, not position.', (select id from public.skills where slug = 'structured-data'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
        'Why must `og:image` be an absolute URL?', 'The software building the preview fetches the image without your page as context, so a relative path cannot be resolved.', (select id from public.skills where slug = 'seo'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
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
-- lesson: Language and direction
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'language-and-internationalisation', 3, 'Language and direction', 'The attribute that changes how your page is spoken, translated and indexed', 'One attribute on `<html>` affects screen-reader pronunciation, automatic translation, search indexing and how the browser hyphenates. Almost everybody sets it wrongly or not at all.',
       ARRAY['Declare the page language correctly', 'Mark passages that are in a different language', 'Explain what `dir` does and when it is needed']::text[], 14, 40, (select id from public.skills where slug = 'metadata'), 0.7
from public.modules m where m.slug = 'page-metadata'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A page has no `lang` attribute. A screen-reader user in France opens it. What is the most likely result?',
       NULL, NULL, NULL, '{"options":["English text is read aloud using French pronunciation rules, and is close to unintelligible","The screen reader detects the language automatically from the words","Nothing changes — `lang` only affects search engines","The page fails to load"],"answer":"The screen reader falls back to the user''s own configured language and applies French pronunciation to English words. The result is not a slight accent — it is genuinely hard to understand, in the way that reading English aloud with strictly French letter sounds would be. Screen readers do not guess the language from the content; they are told, or they fall back. One attribute prevents this entirely, which is why it is the single highest value-per-character thing in the whole of metadata."}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Set `lang` on `<html>` with a valid language tag","Mark inline passages in another language","Use `dir` where the writing direction genuinely changes"]}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Language tag', 'A short code identifying a language, optionally with a region: `en`, `en-GB`, `fr`, `pt-BR`. Use the shortest tag that is accurate — `en` is fine unless the regional difference actually matters.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'Declaring the page language', NULL,
       '<html lang="en-GB">      British English
<html lang="en">         English, region unspecified — usually enough
<html lang="fr">         French
<html lang="pt-BR">      Brazilian Portuguese
<html lang="cy">         Welsh
<html lang="ar">         Arabic — see dir, below', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'prose'::public.block_type, NULL, 'Set it once on `<html>` and every element inherits it. Then override it only where a passage genuinely changes language — and *only* there, because an incorrect override is worse than none.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<html lang="en">
  <body>
    <p>The bakery is on the Rue des Fleurs.</p>
    <p>Our motto is <span lang="fr">plus de beurre</span>.</p>
    <p lang="cy">Croeso i''r becws.</p>
  </body>
</html>', 'html', NULL, '{"annotations":[{"line":"1","text":"Declared once. Everything inside inherits `en` unless it says otherwise."},{"line":"3","text":"A French street name inside an English sentence. This does *not* get a `lang` — proper nouns are read acceptably either way, and marking every foreign-derived name quickly becomes noise."},{"line":"4","text":"An actual French phrase, so it is marked. The screen reader switches voice for those three words and switches back."},{"line":"5","text":"A whole paragraph in Welsh, so the attribute goes on the block itself rather than a span inside it."}]}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'The two commonest `lang` errors', 'Leaving it off entirely — which the validator will tell you about, and which is the more damaging. And setting it once and then never revisiting it, so a page translated into Welsh still says `lang="en"`, which is worse than absent: the screen reader now confidently applies the wrong rules rather than falling back to the user''s default.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'term'::public.block_type, 'Writing direction', '`dir="rtl"` marks text that reads right to left — Arabic, Hebrew, Persian, Urdu. `dir="ltr"` is the default. `dir="auto"` lets the browser decide from the first strongly directional character, which is what you want for text you did not write.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'interactive_demo'::public.block_type, 'Direction in practice', 'The same markup, with and without a direction declared.',
       NULL, NULL, NULL, '{"variants":[{"label":"Declared","code":"<p lang=\"ar\" dir=\"rtl\">مرحبا بكم في المخبز</p>\n<p>Open seven days a week.</p>","note":"The Arabic paragraph lays out right to left, its punctuation lands on the correct side, and the English paragraph is unaffected."},{"label":"Not declared","code":"<p lang=\"ar\">مرحبا بكم في المخبز</p>\n<p>Open seven days a week.</p>","note":"Browsers handle the characters themselves, but punctuation and any mixed-in Latin text can end up on the wrong side of the line."},{"label":"User-supplied text","code":"<blockquote dir=\"auto\">مرحبا بكم في المخبز</blockquote>\n<blockquote dir=\"auto\">Lovely bread, thank you.</blockquote>","note":"`dir=\"auto\"` is the right choice for anything you did not write — a review, a comment, a name — because you cannot know its direction in advance."}]}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'predict_check'::public.block_type, 'Predict, then check', 'Every element here declares `lang="en"`, including a phrase that is actually French. Before you check: is repeating the attribute harmful, useless, or helpful?',
       '<html lang="en">
  <body>
    <p lang="en">Welcome to the bakery.</p>
    <p lang="en">Our motto is plus de beurre.</p>
  </body>
</html>', 'html', NULL, '{"outcome":"Repeating `en` on the paragraphs is merely useless — they already inherited it. The real fault is the second paragraph, where a French phrase is now positively asserted to be English, so a screen reader will pronounce it with English rules rather than switching. This is the pattern worth internalising: a missing `lang` makes software fall back, which is bad; a *wrong* `lang` makes software confident, which is worse. Declare it once at the top, and override only where the language genuinely changes."}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'What `lang` reaches beyond screen readers', 'Browser translation offers, and correctly identifies the source language. Hyphenation and line-breaking rules. Which font a browser picks for characters that exist in several scripts. Spell-checking in editable fields. Search engines use it to serve the right page to the right audience — which is why it sits in the metadata level rather than the accessibility one, though it matters most for accessibility. And `<html lang>` is required for several WCAG success criteria, so a page without it cannot conform at any level.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'checklist'::public.block_type, 'Language checklist', NULL,
       NULL, NULL, NULL, '{"items":["`<html>` has a `lang` with a valid tag","The tag is actually correct for the content — not copied from a template","Passages in another language are marked, at the block or span level","Proper nouns are *not* marked just for being foreign","`dir=\"rtl\"` on right-to-left content, `dir=\"auto\"` on anything user-supplied"]}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`lang` on `<html>` is inherited by everything and affects speech, translation, fonts and indexing.","Override it only where the language genuinely changes.","A wrong `lang` is worse than a missing one: software stops falling back and becomes confidently wrong.","`dir=\"auto\"` is the right default for text you did not write."],"nextUp":"Next: the Level 9 milestone."}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What does a missing `lang` do to a screen-reader user, specifically?","When should you add `lang` to an element inside the page — and when should you not?","What is `dir=\"auto\"` for?"],"points":["The reader falls back to the user''s own language and applies its pronunciation rules to your words, which can make the page close to unintelligible rather than merely accented.","Add it where a passage is genuinely in another language, at block or span level. Do not add it to proper nouns, and do not restate the page language on elements that already inherit it.","Text whose direction you cannot know in advance — anything user-supplied, such as a review, comment or name. The browser decides from the first strongly directional character."]}'::jsonb
from public.lessons where slug = 'language-and-internationalisation';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'lang-guided', 1, 'guided'::public.exercise_kind, 'Declare the language properly',
       'Set the page language to British English, mark the French motto so it is pronounced correctly, and mark the Welsh greeting on its own paragraph. Do not mark the French street name — it is a proper noun.', '<html>
  <head>
    <meta charset="utf-8">
    <title>Riverside Bakery</title>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>You will find us on the Rue des Fleurs.</p>
    <p>Our motto is plus de beurre.</p>
    <p>Croeso i''r becws.</p>
  </body>
</html>', '<html lang="en-GB">
  <head>
    <meta charset="utf-8">
    <title>Riverside Bakery</title>
  </head>
  <body>
    <h1>Riverside Bakery</h1>
    <p>You will find us on the Rue des Fleurs.</p>
    <p>Our motto is <span lang="fr">plus de beurre</span>.</p>
    <p lang="cy">Croeso i''r becws.</p>
  </body>
</html>', ARRAY['The page language goes on the <html> element itself: lang="en-GB".', 'Wrap just the French words in a <span lang="fr">.', 'The Welsh sentence is a whole paragraph, so the attribute goes on the <p>.']::text[],
       40, 2,
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
       'en-GB', NULL, NULL, NULL,
       'The page declares British English', NULL, 1, true
from public.exercises e where e.slug = 'lang-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'span', 'lang',
       'fr', NULL, NULL, NULL,
       'The French phrase is marked', NULL, 1, true
from public.exercises e where e.slug = 'lang-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'p[lang="cy"]', 'lang',
       'cy', NULL, NULL, NULL,
       'The Welsh paragraph is marked', NULL, 1, true
from public.exercises e where e.slug = 'lang-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, '[lang="fr"]', NULL,
       NULL, NULL, 1, 1,
       'Only the French phrase is marked as French', NULL, 1, true
from public.exercises e where e.slug = 'lang-guided';

commit;
