-- HTML Hero — course seed, part 6 of 10
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
select id, 12, 'interactive_demo'::public.block_type, 'Native disclosure versus a hand-built one', 'The same control, with and without the browser doing the work.',
       NULL, NULL, NULL, '{"variants":[{"label":"Native details","code":"<details>\n  <summary>Opening hours</summary>\n  <p>Tuesday to Sunday, 8am to 6pm.</p>\n</details>","note":"Focusable, keyboard-operable, and its expanded state is maintained by the browser — so it can never fall out of step with what is on screen."},{"label":"Hand-built, state maintained","code":"<button type=\"button\" aria-expanded=\"false\" aria-controls=\"hours\">Opening hours</button>\n<div id=\"hours\" hidden>\n  <p>Tuesday to Sunday, 8am to 6pm.</p>\n</div>","note":"Correct as written — but only stays correct if the script updates aria-expanded on every toggle, forever."},{"label":"Hand-built, state forgotten","code":"<div class=\"toggle\">Opening hours</div>\n<div id=\"hours\" hidden>\n  <p>Tuesday to Sunday, 8am to 6pm.</p>\n</div>","note":"Not focusable, no role, no state. Sighted mouse users see a working control; nobody else has one at all."}]}'::jsonb
from public.lessons where slug = 'dialog-and-popover';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'summary'::public.block_type, 'Lesson summary', NULL,
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
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'accessible_name'::public.requirement_kind, 'button', NULL,
       NULL, NULL, NULL, NULL,
       'Both buttons have visible text', NULL, 1, true
from public.exercises e where e.slug = 'popover-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'dialog-debug', 2, 'debug'::public.exercise_kind, 'A dialog with no way out',
       'This dialog has no close mechanism and no heading. Add a heading and a `<form method="dialog">` with a close button.', '<dialog id="policy">
  <p>Cancel up to two hours before your booking for a full refund.</p>
</dialog>', '<dialog id="policy">
  <h2>Cancellation policy</h2>
  <p>Cancel up to two hours before your booking for a full refund.</p>
  <form method="dialog">
    <button type="submit">Close</button>
  </form>
</dialog>', ARRAY['A dialog should start with a heading so its purpose is announced.', 'A form with method="dialog" closes the dialog when submitted.', 'Put a submit button inside that form.']::text[],
       40, 2,
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
select e.id, 1, 'nesting'::public.requirement_kind, 'h2, h3', NULL,
       NULL, 'dialog', 1, NULL,
       'The dialog has a heading', NULL, 1, true
from public.exercises e where e.slug = 'dialog-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'dialog form', 'method',
       'dialog', NULL, NULL, NULL,
       'A form with method="dialog" is present', NULL, 1, true
from public.exercises e where e.slug = 'dialog-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'nesting'::public.requirement_kind, 'button', NULL,
       NULL, 'dialog form', 1, NULL,
       'There is a close button inside that form', NULL, 1, true
from public.exercises e where e.slug = 'dialog-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'accessible_name'::public.requirement_kind, 'button', NULL,
       NULL, NULL, NULL, NULL,
       'The button has visible text', NULL, 1, true
from public.exercises e where e.slug = 'dialog-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'dialog-and-popover'), NULL, 'q-dialog-close', 1, 'single'::public.question_kind,
        'How can a `<dialog>` be closed without JavaScript?', 'With a `<form method="dialog">` — submitting it closes the dialog.', (select id from public.skills where slug = 'native-interaction'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It cannot be, ever', false, NULL
from public.quiz_questions where slug = 'q-dialog-close';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A form with method="dialog"', true, NULL
from public.quiz_questions where slug = 'q-dialog-close';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A button with type="reset"', false, NULL
from public.quiz_questions where slug = 'q-dialog-close';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A link to #close', false, NULL
from public.quiz_questions where slug = 'q-dialog-close';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'dialog-and-popover'), NULL, 'q-popover-js', 2, 'single'::public.question_kind,
        'Does the `popover` attribute require JavaScript?', 'No. `popovertarget` on a button wires up the whole interaction, including the ARIA relationship.', (select id from public.skills where slug = 'native-interaction'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Yes, to show it', false, NULL
from public.quiz_questions where slug = 'q-popover-js';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Yes, to close it', false, NULL
from public.quiz_questions where slug = 'q-popover-js';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only on mobile browsers', false, NULL
from public.quiz_questions where slug = 'q-popover-js';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'No — popovertarget handles it entirely', true, NULL
from public.quiz_questions where slug = 'q-popover-js';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'dialog-and-popover'), NULL, 'q-modal-content', 3, 'single'::public.question_kind,
        'Why should essential content never live only inside a dialog?', 'Anyone whose browser does not open it, or whose JavaScript fails, cannot reach the content at all.', (select id from public.skills where slug = 'progressive-enhancement'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Dialogs cannot contain paragraphs', false, NULL
from public.quiz_questions where slug = 'q-modal-content';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Search engines index dialogs twice', false, NULL
from public.quiz_questions where slug = 'q-modal-content';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Dialogs are not keyboard accessible', false, NULL
from public.quiz_questions where slug = 'q-modal-content';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'If the overlay does not open, the content is unreachable', true, NULL
from public.quiz_questions where slug = 'q-modal-content';
-- lesson: Progress, meter, datalist — and the milestone
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'progress-meter-datalist-milestone', 3, 'Progress, meter, datalist — and the milestone', 'The last four native controls, then build the lot', 'Three small elements with precise meanings, plus a native autocomplete — and then the Level 7 milestone build.',
       ARRAY['Use progress and meter for their correct, different meanings', 'Add native autocomplete with datalist', 'Combine every Level 7 feature on one page']::text[], 25, 40, (select id from public.skills where slug = 'native-interaction'), 0.8
from public.modules m where m.slug = 'disclosure-and-dialog'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Distinguish progress from meter","Build a datalist-backed input","Build a complete interactive page with no JavaScript"]}'::jsonb
from public.lessons where slug = 'progress-meter-datalist-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'comparison'::public.block_type, 'progress or meter?', NULL,
       NULL, NULL, NULL, '{"good":{"label":"`<progress>` — a task advancing","code":"<label for=\"setup\">Profile completeness</label>\n<progress id=\"setup\" value=\"7\" max=\"10\">7 of 10</progress>","why":"Something that moves towards completion: an upload, a form wizard, a download. It has a beginning and an end."},"bad":{"label":"`<meter>` — a measurement in a range","code":"<label for=\"fleet\">Bikes available today</label>\n<meter id=\"fleet\" value=\"6\" min=\"0\" max=\"24\" low=\"5\" high=\"18\" optimum=\"20\">6 of 24</meter>","why":"A gauge reading, with no notion of completion: disk usage, a rating, stock level. `low`, `high` and `optimum` let browsers colour it."}}'::jsonb
from public.lessons where slug = 'progress-meter-datalist-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'callout'::public.block_type, 'A meter is not a progress bar', 'Using `<meter>` for a download, or `<progress>` for stock level, is announced wrongly by screen readers and coloured wrongly by browsers. Ask: is this moving towards being finished? If yes, `<progress>`. If it is simply a reading within a range, `<meter>`.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'progress-meter-datalist-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'prose'::public.block_type, NULL, 'The text inside `<progress>` or `<meter>` is fallback content for very old browsers — but it is also worth keeping, because it states the value in words.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'progress-meter-datalist-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<label for="route-choice">Which route?</label>
<input list="routes" id="route-choice" name="route"
       autocomplete="off" placeholder="Start typing…">

<datalist id="routes">
  <option value="Harbour loop"></option>
  <option value="Mill and back"></option>
  <option value="The full valley"></option>
</datalist>', 'html', NULL, '{"annotations":[{"line":"2","text":"`list=\"routes\"` connects the input to a `<datalist>` by its id."},{"line":"5-9","text":"The `<datalist>` holds the suggestions. It renders nothing itself."},{"line":"2","text":"Crucially, this is a *suggestion* list, not a restriction — the user can type anything. If only the listed values are acceptable, use a `<select>` instead."}]}'::jsonb
from public.lessons where slug = 'progress-meter-datalist-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'term'::public.block_type, '<output>', 'A place for a calculated result. It is a live region by default, so screen readers announce changes to it — which is exactly what you want for a running total.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'progress-meter-datalist-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'checklist'::public.block_type, 'The Level 7 milestone page needs', NULL,
       NULL, NULL, NULL, '{"items":["An FAQ accordion of at least three `<details>` sharing a `name`","A `<dialog>` with a heading and a `<form method=\"dialog\">` close button","A popover with a trigger button and a close button","A `<progress>` element with a label","A `<meter>` element with a label","An input backed by a `<datalist>`","No `<script>` elements anywhere"]}'::jsonb
from public.lessons where slug = 'progress-meter-datalist-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'Three elements people reach for JavaScript to build', 'All three are native, and all three come with keyboard and screen-reader support already.',
       NULL, NULL, NULL, '{"variants":[{"label":"progress","code":"<label for=\"upload\">Upload</label>\n<progress id=\"upload\" value=\"70\" max=\"100\">70%</progress>","note":"A task in progress towards completion. The text inside is what older browsers show."},{"label":"meter","code":"<label for=\"stock\">In stock</label>\n<meter id=\"stock\" value=\"3\" min=\"0\" max=\"20\" low=\"5\" high=\"15\" optimum=\"20\">3 of 20</meter>","note":"A measurement within a known range — not progress. The low, high and optimum values let the browser signal whether the reading is good."},{"label":"datalist","code":"<label for=\"route\">Route</label>\n<input list=\"routes\" id=\"route\" name=\"route\">\n<datalist id=\"routes\">\n  <option value=\"Riverside loop\">\n  <option value=\"Hill circuit\">\n</datalist>","note":"Suggestions that do not restrict the answer — unlike a select, the visitor may still type something else entirely."}]}'::jsonb
from public.lessons where slug = 'progress-meter-datalist-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<progress>` for tasks advancing; `<meter>` for gauge readings.","`<datalist>` suggests values without restricting them.","`<output>` announces calculated results to screen readers.","Everything in this level works without a line of JavaScript."],"nextUp":"Level 8 next: accessibility in depth."}'::jsonb
from public.lessons where slug = 'progress-meter-datalist-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'datalist-guided', 1, 'guided'::public.exercise_kind, 'Add native autocomplete',
       'Connect this input to a `<datalist>` with the id `routes` containing three options. Also add a labelled `<meter>` showing 6 bikes available out of 24.', '<label for="route-choice">Which route?</label>
<input id="route-choice" name="route" placeholder="Start typing…">

<label for="fleet">Bikes available today</label>
', '<label for="route-choice">Which route?</label>
<input list="routes" id="route-choice" name="route" placeholder="Start typing…">

<datalist id="routes">
  <option value="Harbour loop"></option>
  <option value="Mill and back"></option>
  <option value="The full valley"></option>
</datalist>

<label for="fleet">Bikes available today</label>
<meter id="fleet" value="6" min="0" max="24" low="5" high="18" optimum="20">6 of 24</meter>', ARRAY['Add list="routes" to the input, matching the datalist id.', 'Each suggestion is an <option value="…"></option> inside the datalist.', 'The meter needs value="6", min="0" and max="24", plus an id matching its label.']::text[],
       50, 3,
       (select id from public.skills where slug = 'native-interaction'), false
from public.lessons l where l.slug = 'progress-meter-datalist-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'input', 'list',
       'routes', NULL, NULL, NULL,
       'The input is connected to the datalist', NULL, 1, true
from public.exercises e where e.slug = 'datalist-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_present'::public.requirement_kind, 'datalist#routes', NULL,
       NULL, NULL, NULL, NULL,
       'There is a datalist with that id', NULL, 1, true
from public.exercises e where e.slug = 'datalist-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'datalist option', NULL,
       NULL, NULL, 3, NULL,
       'The datalist offers at least three options', NULL, 1, true
from public.exercises e where e.slug = 'datalist-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'meter', NULL,
       NULL, NULL, NULL, NULL,
       'There is a meter', NULL, 1, true
from public.exercises e where e.slug = 'datalist-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_value'::public.requirement_kind, 'meter', 'value',
       '6', NULL, NULL, NULL,
       'The meter shows the current value', NULL, 1, true
from public.exercises e where e.slug = 'datalist-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'attribute_value'::public.requirement_kind, 'meter', 'max',
       '24', NULL, NULL, NULL,
       'The meter declares its maximum', NULL, 1, true
from public.exercises e where e.slug = 'datalist-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'label_association'::public.requirement_kind, 'input, meter', NULL,
       NULL, NULL, NULL, NULL,
       'Both controls are labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'datalist-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'native-milestone', 2, 'challenge'::public.exercise_kind, 'Milestone: an interactive page with no JavaScript',
       'Build a page meeting every item on the checklist above. Everything must work with no scripting at all — the preview will not run any.', '', '<h1>Booking help</h1>

<h2>Frequently asked questions</h2>

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
  <p>
    Cancel up to two hours before for a full refund.
    <button popovertarget="policy-tip" popovertargetaction="toggle">See the details</button>
  </p>
</details>

<div id="policy-tip" popover>
  <h3>Cancellation in detail</h3>
  <p>Refunds are returned to the original payment method within five working days.</p>
  <button popovertarget="policy-tip" popovertargetaction="hide">Close</button>
</div>

<dialog id="terms">
  <h2>Hire terms</h2>
  <p>Bikes must be returned by 6pm on the day of hire.</p>
  <form method="dialog">
    <button type="submit">Close</button>
  </form>
</dialog>

<h2>Today at a glance</h2>

<label for="setup">Your booking, so far</label>
<progress id="setup" value="3" max="5">3 of 5 steps complete</progress>

<label for="fleet">Bikes available today</label>
<meter id="fleet" value="6" min="0" max="24" low="5" high="18" optimum="20">6 of 24</meter>

<label for="route-choice">Which route?</label>
<input list="routes" id="route-choice" name="route" placeholder="Start typing…">
<datalist id="routes">
  <option value="Harbour loop"></option>
  <option value="Mill and back"></option>
  <option value="The full valley"></option>
</datalist>', ARRAY['Work down the checklist one item at a time; each is only a few lines.', 'The three details elements need a shared name so only one opens at a time.', 'progress and meter both need labels connected by for and id.', 'Do not add any <script> — the checker will flag it.']::text[],
       150, 5,
       (select id from public.skills where slug = 'native-interaction'), false
from public.lessons l where l.slug = 'progress-meter-datalist-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'details', NULL,
       NULL, NULL, 3, NULL,
       'At least three details elements', NULL, 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'details', 'name',
       NULL, NULL, NULL, NULL,
       'The details elements share a name', NULL, 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'details > summary', NULL,
       NULL, NULL, 3, NULL,
       'Each details has a summary', NULL, 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'dialog', NULL,
       NULL, NULL, NULL, NULL,
       'There is a dialog', NULL, 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_value'::public.requirement_kind, 'dialog form', 'method',
       'dialog', NULL, NULL, NULL,
       'The dialog can be closed without JavaScript', NULL, 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_present'::public.requirement_kind, '[popover]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a popover', NULL, 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'element_present'::public.requirement_kind, 'button[popovertarget]', NULL,
       NULL, NULL, NULL, NULL,
       'A button controls the popover', NULL, 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'element_present'::public.requirement_kind, 'progress', NULL,
       NULL, NULL, NULL, NULL,
       'There is a progress element', NULL, 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'element_present'::public.requirement_kind, 'meter', NULL,
       NULL, NULL, NULL, NULL,
       'There is a meter element', NULL, 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'element_present'::public.requirement_kind, 'datalist', NULL,
       NULL, NULL, NULL, NULL,
       'There is a datalist', NULL, 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'attribute_present'::public.requirement_kind, 'input', 'list',
       NULL, NULL, NULL, NULL,
       'An input is connected to the datalist', NULL, 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'label_association'::public.requirement_kind, 'progress, meter, input', NULL,
       NULL, NULL, NULL, NULL,
       'Every control is labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'element_count'::public.requirement_kind, 'script', NULL,
       NULL, NULL, 0, 0,
       'The page contains no JavaScript', NULL, 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 15, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 16, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'native-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'native-mission', 3, 'project_mission'::public.exercise_kind, 'Capstone mission: add an FAQ section',
       'Add an FAQ accordion to one of your capstone pages using `<details>`, and a progress or meter display somewhere it genuinely fits — availability, capacity, or how far through a process a visitor is.', '<section aria-labelledby="faq-heading">
  <h2 id="faq-heading">Frequently asked questions</h2>

  <!-- Add at least three details elements sharing a name -->
</section>', '<section aria-labelledby="faq-heading">
  <h2 id="faq-heading">Frequently asked questions</h2>

  <details name="faq" open>
    <summary>Do I need to book in advance?</summary>
    <p>Not on weekdays. At weekends, please book a day ahead.</p>
  </details>

  <details name="faq">
    <summary>Are helmets included?</summary>
    <p>Yes — a helmet and a lock come with every hire.</p>
  </details>

  <details name="faq">
    <summary>Do you hire to children?</summary>
    <p>Yes, from age six, with a parent or guardian present.</p>
  </details>

  <label for="fleet">Bikes available today</label>
  <meter id="fleet" value="6" min="0" max="24" low="5" high="18" optimum="20">6 of 24</meter>
</section>', ARRAY['Write questions your own visitors would genuinely ask.', 'All the details elements need the same name attribute.', 'The meter or progress element needs a label connected by for and id.']::text[],
       90, 3,
       (select id from public.skills where slug = 'native-interaction'), false
from public.lessons l where l.slug = 'progress-meter-datalist-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'details', NULL,
       NULL, NULL, 3, NULL,
       'At least three FAQ entries', NULL, 1, true
from public.exercises e where e.slug = 'native-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'details > summary', NULL,
       NULL, NULL, 3, NULL,
       'Each has a summary as its first child', NULL, 1, true
from public.exercises e where e.slug = 'native-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'text_not_empty'::public.requirement_kind, 'summary', NULL,
       NULL, NULL, NULL, NULL,
       'Every question has text', NULL, 1, true
from public.exercises e where e.slug = 'native-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'progress, meter', NULL,
       NULL, NULL, NULL, NULL,
       'There is a progress or meter display', NULL, 1, true
from public.exercises e where e.slug = 'native-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'label_association'::public.requirement_kind, 'progress, meter', NULL,
       NULL, NULL, NULL, NULL,
       'The display is labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'native-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'script', NULL,
       NULL, NULL, 0, 0,
       'No JavaScript is used', NULL, 1, true
from public.exercises e where e.slug = 'native-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'progress-meter-datalist-milestone'), NULL, 'q-progress-vs-meter', 1, 'single'::public.question_kind,
        'Which element suits "disk space used: 62%"?', 'A gauge reading within a range, with no notion of completion — that is `<meter>`.', (select id from public.skills where slug = 'native-interaction'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<progress>', false, NULL
from public.quiz_questions where slug = 'q-progress-vs-meter';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<output>', false, NULL
from public.quiz_questions where slug = 'q-progress-vs-meter';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<data>', false, NULL
from public.quiz_questions where slug = 'q-progress-vs-meter';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<meter>', true, NULL
from public.quiz_questions where slug = 'q-progress-vs-meter';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'progress-meter-datalist-milestone'), NULL, 'q-datalist-restrict', 2, 'single'::public.question_kind,
        'Does a `<datalist>` restrict what the user can type?', 'No — it suggests. If only certain values are acceptable, use a `<select>` instead.', (select id from public.skills where slug = 'native-interaction'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Yes, only listed values are accepted', false, NULL
from public.quiz_questions where slug = 'q-datalist-restrict';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Yes, when combined with required', false, NULL
from public.quiz_questions where slug = 'q-datalist-restrict';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only when the input has a pattern', false, NULL
from public.quiz_questions where slug = 'q-datalist-restrict';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'No, it only suggests — use <select> to restrict', true, NULL
from public.quiz_questions where slug = 'q-datalist-restrict';
-- Level 7 milestone: Native Interaction Expert questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-7-milestone'), 'a7-q1', 1, 'single'::public.question_kind,
        'What does `<details>` give you that a hand-built accordion must reimplement?', 'Keyboard activation, expanded/collapsed announcements, find-in-page support and correct printing — all built in.', (select id from public.skills where slug = 'native-interaction'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Server-side rendering', false, NULL
from public.quiz_questions where slug = 'a7-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Keyboard, screen-reader, find-in-page and print behaviour', true, NULL
from public.quiz_questions where slug = 'a7-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Animated transitions', false, NULL
from public.quiz_questions where slug = 'a7-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Automatic styling', false, NULL
from public.quiz_questions where slug = 'a7-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-7-milestone'), 'a7-q2', 2, 'single'::public.question_kind,
        'Which part of using `<dialog>` still needs JavaScript?', 'Opening it. `showModal()` is a JavaScript method with no HTML equivalent.', (select id from public.skills where slug = 'native-interaction'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Opening it', true, NULL
from public.quiz_questions where slug = 'a7-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Closing it', false, NULL
from public.quiz_questions where slug = 'a7-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Trapping focus inside it', false, NULL
from public.quiz_questions where slug = 'a7-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Making the background inert', false, NULL
from public.quiz_questions where slug = 'a7-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-7-milestone'), 'a7-q3', 3, 'single'::public.question_kind,
        'What connects a button to a popover?', '`popovertarget`, holding the id of the popover element.', (select id from public.skills where slug = 'native-interaction'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'aria-controls', false, NULL
from public.quiz_questions where slug = 'a7-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'for', false, NULL
from public.quiz_questions where slug = 'a7-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'href', false, NULL
from public.quiz_questions where slug = 'a7-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'popovertarget', true, NULL
from public.quiz_questions where slug = 'a7-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-7-milestone'), 'a7-q4', 4, 'single'::public.question_kind,
        'Which element suits "uploading file 3 of 5"?', 'A task moving towards completion — `<progress>`.', (select id from public.skills where slug = 'native-interaction'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<output>', false, NULL
from public.quiz_questions where slug = 'a7-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<datalist>', false, NULL
from public.quiz_questions where slug = 'a7-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<progress>', true, NULL
from public.quiz_questions where slug = 'a7-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<meter>', false, NULL
from public.quiz_questions where slug = 'a7-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-7-milestone'), 'a7-q5', 5, 'single'::public.question_kind,
        'What is progressive enhancement?', 'Building so the page works without the enhancement, then layering the enhancement on for browsers that support it.', (select id from public.skills where slug = 'progressive-enhancement'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Compressing assets progressively', false, NULL
from public.quiz_questions where slug = 'a7-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Building so it works first, then enhancing where supported', true, NULL
from public.quiz_questions where slug = 'a7-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Loading features one at a time as the page scrolls', false, NULL
from public.quiz_questions where slug = 'a7-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only supporting the newest browsers', false, NULL
from public.quiz_questions where slug = 'a7-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-7-milestone'), 'a7-q6', 6, 'single'::public.question_kind,
        'Several `<details>` share `name="faq"`. What happens when you open the second one?', 'The first closes. A shared name makes them mutually exclusive.', (select id from public.skills where slug = 'native-interaction'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The first one closes', true, NULL
from public.quiz_questions where slug = 'a7-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Both stay open', false, NULL
from public.quiz_questions where slug = 'a7-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The form is submitted', false, NULL
from public.quiz_questions where slug = 'a7-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Nothing — name has no effect', false, NULL
from public.quiz_questions where slug = 'a7-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-7-milestone'), 'a7-q7', 7, 'single'::public.question_kind,
        'Why is `<output>` useful for a calculated total?', 'It is a live region by default, so screen readers announce the new value when it changes.', (select id from public.skills where slug = 'aria'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It calculates the total for you', false, NULL
from public.quiz_questions where slug = 'a7-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It is styled as a result box', false, NULL
from public.quiz_questions where slug = 'a7-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is submitted with the form', false, NULL
from public.quiz_questions where slug = 'a7-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is a live region, so changes are announced', true, NULL
from public.quiz_questions where slug = 'a7-q7';
-- --------------------------------------------------------------------------
-- Level 8: Accessibility Champion
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'accessibility-champion', 8, 'Accessibility Champion', 'Build so everybody can use it — using the HTML you already know',
       'Almost everything in this level is something you have already met. What changes here is that you learn to audit, to test with a keyboard, and to know the small set of ARIA worth using. Accessibility is not a layer added at the end; it is what correct HTML already does.', 'You can audit a page against WCAG 2.2 AA principles and repair what you find.', 'emerald'
from public.courses c where c.slug = 'html-hero'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-8-milestone', 'milestone'::public.assessment_kind, 'Level 8 milestone: Accessibility Champion', 'Nine questions on accessibility and ARIA. Pass mark 80% — this level matters.',
       0.8, 220, 8
from public.levels l where l.slug = 'accessibility-champion'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Accessibility foundations
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'accessibility-foundations', 1, 'Accessibility foundations', 'How assistive technology reads your page, how to test with a keyboard, and the accessibility your HTML already provides.',
       50, false
from public.levels l where l.slug = 'accessibility-champion'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'accessibility-foundations' and p.slug = 'disclosure-and-dialog';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'accessibility-foundations' and s.slug = 'accessibility';
-- lesson: How assistive technology reads a page
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'how-assistive-tech-reads-a-page', 1, 'How assistive technology reads a page', 'The accessibility tree, keyboard order, and what you can test today', 'You do not need a screen reader to catch most problems. You need a keyboard and ten minutes.',
       ARRAY['Explain what the accessibility tree is', 'Test a page using only the keyboard', 'Name the four WCAG principles']::text[], 14, 40, (select id from public.skills where slug = 'accessibility'), 0.7
from public.modules m where m.slug = 'accessibility-foundations'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Describe how HTML becomes the accessibility tree","Run a keyboard-only test on any page","Explain what WCAG 2.2 AA means in practice"]}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'visual'::public.block_type, NULL, 'Your HTML becomes an accessibility tree, which assistive technology reads.',
       NULL, NULL, 'accessibility-tree', '{}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'The browser builds two things from your markup: the DOM, which drives what is drawn on screen, and the accessibility tree, which is what screen readers, voice-control software and switch devices read. Correct HTML fills that second tree automatically. Incorrect HTML leaves it empty or wrong, and no amount of visual polish will fix it.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Role', 'What an element *is*, as far as assistive technology is concerned. `<button>` has the role `button`; `<nav>` has `navigation`. You rarely need to set one, because using the right element sets it for you.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'Accessible name', 'The text an element is announced by. It comes from its label, its alt text, its contents, or an `aria-label` — in that order of preference.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'term'::public.block_type, 'State', 'Whether something is expanded, checked, disabled or current. Native elements manage their own state; anything you build by hand does not.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'The keyboard test — do this on every page you build', 'Click into the address bar, then press Tab repeatedly. Four questions: (1) Can you reach every interactive thing? (2) Can you always see where focus is? (3) Does the order follow the visual layout? (4) Can you get *out* of everything you get into? Any "no" is a bug. This takes two minutes and catches the majority of real-world accessibility failures.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'Focus order follows source order', 'Not the order things appear on screen.',
       NULL, NULL, NULL, '{"variants":[{"label":"Source order matches visual order","code":"<nav aria-label=\"Main\"><a href=\"#a\">First</a> <a href=\"#b\">Second</a></nav>\n<main id=\"a\"><h1>Content</h1></main>","note":"Tab reaches First, then Second, then the content. Exactly what a sighted user expects."},{"label":"Content before navigation in the source","code":"<main id=\"a\"><h1>Content</h1><a href=\"#x\">A link in the content</a></main>\n<nav aria-label=\"Main\"><a href=\"#b\">Menu item</a></nav>","note":"If CSS moved the nav to the top visually, keyboard users would reach the content link first — a jarring mismatch. Get the source order right and CSS cannot break it."}]}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'prose'::public.block_type, NULL, 'WCAG — the Web Content Accessibility Guidelines — organises everything under four principles. The current version is 2.2, and AA is the level almost every organisation and law targets.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'code_example'::public.block_type, 'The four WCAG principles, in plain terms', NULL,
       'Perceivable    Can people sense the content?
               → alt text, captions, colour contrast, not relying on colour alone

Operable       Can people use the interface?
               → keyboard access, skip links, enough time, visible focus

Understandable Is it clear and predictable?
               → language declared, consistent navigation, clear error messages

Robust         Does it work with the tools people actually use?
               → valid HTML, correct names and roles, no duplicate ids', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'callout'::public.block_type, 'How much of this is HTML?', 'A great deal. Of the WCAG 2.2 AA criteria, the ones you can meet or fail purely in markup include page language, page titles, heading structure, link purpose, form labels, error identification, name-role-value, bypass blocks, and info-and-relationships. Colour contrast and reflow are CSS; timing and motion are usually JavaScript. Getting the HTML right takes you most of the way.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'progressive_detail'::public.block_type, 'Who is actually affected?', 'The stereotype is a blind screen-reader user, and they matter — but the population is much wider. Someone with a broken wrist using only a keyboard. Someone with a tremor who cannot hit a small target. Someone with dyslexia who relies on clear heading structure. Someone watching a video on a train with the sound off. Someone with a migraine using their phone at low brightness. Accessibility work is rarely for a minority; it is usually for everybody, some of the time.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["The browser builds an accessibility tree from your HTML; correct elements fill it for free.","Role, accessible name and state are what assistive technology reads.","The keyboard test takes two minutes and catches most real problems.","WCAG 2.2 AA is the working standard; much of it is markup."],"nextUp":"Next: the ARIA worth knowing, and the ARIA to avoid."}'::jsonb
from public.lessons where slug = 'how-assistive-tech-reads-a-page';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'keyboard-debug', 1, 'debug'::public.exercise_kind, 'A page a keyboard user cannot use',
       'Three things here cannot be reached or used with a keyboard: a `<div>` acting as a button, a link with no href, and an image link with no accessible name. Fix all three using the right native elements.', '<div class="button" onclick="submitForm()">Send enquiry</div>

<a class="nav-link">Prices</a>

<a href="index.html">
  <img src="/learning-media/icons/home.svg" alt="">
</a>', '<button type="submit">Send enquiry</button>

<a href="prices.html">Prices</a>

<a href="index.html">
  <img src="/learning-media/icons/home.svg" alt="">
  Home
</a>', ARRAY['A div is not focusable and is not announced as a button. Use a real <button>.', 'An <a> with no href is not a link at all — it cannot be focused or activated.', 'An image link with alt="" has no accessible name. Add visible text, or give the image alt text describing where the link goes.']::text[],
       55, 3,
       (select id from public.skills where slug = 'accessibility'), false
from public.lessons l where l.slug = 'how-assistive-tech-reads-a-page'
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
       'The action uses a real button element', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'button', 'type',
       NULL, NULL, NULL, NULL,
       'The button has an explicit type', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'a', 'href',
       NULL, NULL, NULL, NULL,
       'Every link has an href', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'accessible_name'::public.requirement_kind, 'a', NULL,
       NULL, NULL, NULL, NULL,
       'Every link has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'div[onclick], [onclick]', NULL,
       NULL, NULL, 0, 0,
       'No inline click handlers on non-interactive elements', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'accessible_name'::public.requirement_kind, 'button', NULL,
       NULL, NULL, NULL, NULL,
       'The button has visible text', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'how-assistive-tech-reads-a-page'), NULL, 'q-a11y-tree', 1, 'single'::public.question_kind,
        'What is the accessibility tree?', 'A second structure the browser builds from your HTML, containing roles, names and states, which assistive technology reads.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A file screen readers download separately', false, NULL
from public.quiz_questions where slug = 'q-a11y-tree';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A structure of roles, names and states built from your HTML', true, NULL
from public.quiz_questions where slug = 'q-a11y-tree';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A list of accessibility errors on the page', false, NULL
from public.quiz_questions where slug = 'q-a11y-tree';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The DOM with CSS applied', false, NULL
from public.quiz_questions where slug = 'q-a11y-tree';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'how-assistive-tech-reads-a-page'), NULL, 'q-keyboard-test', 2, 'single'::public.question_kind,
        'What does pressing Tab through a page test?', 'Whether every interactive element is reachable, whether focus is visible, and whether the order makes sense.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Whether everything interactive is reachable, visible and in a sensible order', true, NULL
from public.quiz_questions where slug = 'q-keyboard-test';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Whether the colour contrast is sufficient', false, NULL
from public.quiz_questions where slug = 'q-keyboard-test';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Whether images have alt text', false, NULL
from public.quiz_questions where slug = 'q-keyboard-test';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Whether the HTML validates', false, NULL
from public.quiz_questions where slug = 'q-keyboard-test';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'how-assistive-tech-reads-a-page'), NULL, 'q-div-button', 3, 'single'::public.question_kind,
        'Why is `<div onclick="…">` not a button?', 'It cannot be focused with a keyboard, is not announced as a button, and does not respond to Enter or Space.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Divs cannot contain text', false, NULL
from public.quiz_questions where slug = 'q-div-button';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It works fine — the elements are equivalent', false, NULL
from public.quiz_questions where slug = 'q-div-button';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is not focusable, not announced as a button, and ignores Enter and Space', true, NULL
from public.quiz_questions where slug = 'q-div-button';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'onclick only works on buttons', false, NULL
from public.quiz_questions where slug = 'q-div-button';
-- lesson: Keyboard operability and focus
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'keyboard-and-focus-management', 2, 'Keyboard operability and focus', 'The test you can run on anything, and the three ways people break it', 'If it cannot be done with a keyboard, it cannot be done by a large number of people. This is the single highest-value habit in the level.',
       ARRAY['Name the elements that are focusable without any extra work', 'Use tabindex correctly — and know why positive values are a bug', 'Add a skip link that actually works']::text[], 16, 40, (select id from public.skills where slug = 'accessibility'), 0.7
from public.modules m where m.slug = 'accessibility-foundations'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A developer makes a clickable card by putting a click handler on a `<div>`. Who, apart from screen-reader users, is locked out?',
       NULL, NULL, NULL, '{"options":["Anyone not using a mouse — keyboard, voice control, switch devices","Nobody else — it is only a screen-reader problem","Only people on a phone","Only people who have turned JavaScript off"],"answer":"Far more people than most developers expect. A `<div>` is not focusable, so it cannot be reached with Tab, cannot be activated with Enter or Space, and is invisible to voice control asking to \"click the card\". That locks out people using switch devices or voice control, anyone whose trackpad has died, and anyone who simply prefers the keyboard. Screen-reader users are a minority of the people this breaks."}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["List the elements that are keyboard-focusable by default","Apply `tabindex=\"0\"` and `tabindex=\"-1\"` correctly","Write a skip link whose target can actually take focus"]}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'Keyboard access is not an accessibility extra. It is the substrate almost every assistive technology sits on: switch devices, voice control and screen readers all drive the page through the same focus model you use when you press Tab. Get the keyboard right and most of the rest follows.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Focusable', 'An element the browser will move focus to. Links *with an href*, buttons, form controls, `<summary>`, `<iframe>` and anything carrying a `tabindex` are focusable. Almost nothing else is.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'Tab order', 'The sequence Tab moves through. By default it is exactly the order elements appear in your source — which is one more reason source order matters.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, 'What the browser gives you free', NULL,
       'Focusable with no extra work:
  <a href="...">        a link — but only if it has an href
  <button>              always
  <input> <select>      every form control
  <textarea>
  <summary>             the toggle of a <details>
  <iframe>              the embed itself
  <audio controls>      and <video controls>

Not focusable, ever, without help:
  <div> <span> <p>      no matter what handlers you attach', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'An anchor without an href is not a link', 'Writing `<a>Menu</a>` or `<a href="#">Menu</a>` is a common way to fake a button. The first is not focusable at all; the second is focusable but announced as a link that goes nowhere. If it performs an action rather than navigating, it is a `<button>`.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'The same card, three ways', 'Tab through each one and notice what you can reach.',
       NULL, NULL, NULL, '{"variants":[{"label":"A real link","code":"<article><h2><a href=\"article.html\">How we bake</a></h2><p>Fifteen hours, start to finish.</p></article>","note":"Focusable, announced as a link, activated with Enter, findable by voice control. Nothing extra required."},{"label":"A real button","code":"<article><h2>How we bake</h2><p>Fifteen hours, start to finish.</p><button type=\"button\">Read more</button></article>","note":"Correct when it performs an action rather than navigating. Enter and Space both activate it."},{"label":"A div pretending","code":"<article><h2>How we bake</h2><p>Fifteen hours, start to finish.</p><div class=\"btn\">Read more</div></article>","note":"Tab skips straight past it. There is no way to reach or activate it without a mouse — and no amount of styling fixes that."}]}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'prose'::public.block_type, NULL, '`tabindex` has exactly two values worth using, and one that is almost always a mistake.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<div tabindex="0">Now reachable by Tab</div>
<h2 tabindex="-1" id="results">Focusable by script only</h2>
<button tabindex="3">Please do not</button>', 'html', NULL, '{"annotations":[{"line":"1","text":"`tabindex=\"0\"` puts an element into the natural tab order, at its source position. Use it when you have genuinely built a custom control — and remember it makes the element *focusable*, not *operable*: you still owe it a role and keyboard handling."},{"line":"2","text":"`tabindex=\"-1\"` makes an element focusable by script, while Tab skips it. This is the right tool for something you want to move focus *to* after an action — a results heading, for instance."},{"line":"3","text":"A positive `tabindex` jumps the queue, moving this button ahead of everything with `tabindex=\"0\"` or no tabindex at all. It creates an order nobody can predict and which breaks as soon as the page changes. Treat any positive value as a bug."}]}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'predict_check'::public.block_type, 'Predict, then check', 'A skip link sits first in the source and points at the `id` of `<main>`. Before you run it: what has to be true of the target for *focus* — not merely the scroll position — to move there?',
       '<a href="#main-content">Skip to main content</a>
<nav aria-label="Main">
  <a href="index.html">Home</a>
  <a href="menu.html">Menu</a>
</nav>
<main id="main-content">
  <h1>Today''s bakes</h1>
</main>', 'html', NULL, '{"outcome":"The target has to be focusable. Browsers have improved here and most now move focus to the target of a fragment link even when it is not focusable, but the behaviour has historically been inconsistent — and the reliable fix is `tabindex=\"-1\"` on the target. That makes it focusable by fragment navigation and by script while keeping it out of the Tab order. Without it, on some browsers the page scrolls and focus stays on the skip link, so the next Tab press drops the user straight back into the navigation they were trying to skip."}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'callout'::public.block_type, 'A skip link must become visible when focused', 'The usual pattern positions the link off-screen and brings it back on focus. That part is CSS, so it is outside this course — but the markup half is yours, and a skip link hidden with `display: none` is not focusable at all. Never hide one that way.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'progressive_detail'::public.block_type, 'Focus traps, and the one place you want one', 'A focus trap is when Tab cannot escape a region. Usually it is a bug — a custom menu that swallows focus and never gives it back. In exactly one case it is correct: a modal dialog, where focus *should* stay inside until the dialog is dismissed. The native `<dialog>` opened as a modal does this for you, along with Escape to close and returning focus to whatever opened it. Building it by hand means reimplementing all three, and most hand-built versions get at least one of them wrong.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'checklist'::public.block_type, 'The two-minute keyboard test', NULL,
       NULL, NULL, NULL, '{"items":["Can you reach every interactive thing with Tab?","Can you always see where focus is?","Does the order follow the visual layout?","Can you get out of everything you can get into?","Does Enter activate links, and Enter *and* Space activate buttons?","Does the skip link appear when focused, and land somewhere useful?"]}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 15, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Links with an `href`, buttons, form controls, `<summary>` and `<iframe>` are focusable for free; `<div>` and `<span>` never are.","Tab order follows source order, which makes source order an accessibility decision.","`tabindex=\"0\"` adds to the natural order, `tabindex=\"-1\"` allows script focus, positive values are a bug.","A skip link needs a target that can take focus, which in practice means `tabindex=\"-1\"` on it."],"nextUp":"Next: where an accessible name actually comes from."}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 16, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Which elements are focusable without a tabindex? Name at least four.","What do `tabindex=\"0\"` and `tabindex=\"-1\"` each do, and why is `tabindex=\"3\"` a bug?","What has to be true of a skip link''s target?"],"points":["Links *with an href*, `<button>`, `<input>`, `<select>`, `<textarea>`, `<summary>`, `<iframe>`, and media carrying `controls`.","`0` puts it in the natural order at its source position. `-1` makes it focusable by script while Tab skips it. A positive value jumps the queue, producing an order nobody can predict and which breaks whenever the page changes.","It has to be able to take focus — give it `tabindex=\"-1\"` — and it must not be hidden with `display: none`, which would stop the link working at all."]}'::jsonb
from public.lessons where slug = 'keyboard-and-focus-management';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'keyboard-skip-link-guided', 1, 'guided'::public.exercise_kind, 'Add a working skip link',
       'This page puts navigation before its content, so a keyboard user must Tab through every menu item on every page. Add a skip link as the very first element, pointing at the `<main>`, and give the `<main>` an `id` and `tabindex="-1"` so focus can actually land there.', '<nav aria-label="Main">
  <a href="index.html">Home</a>
  <a href="menu.html">Menu</a>
  <a href="contact.html">Contact</a>
</nav>
<main>
  <h1>Today''s bakes</h1>
  <p>Sourdough, rye and a seeded loaf.</p>
</main>', '<a href="#main-content">Skip to main content</a>
<nav aria-label="Main">
  <a href="index.html">Home</a>
  <a href="menu.html">Menu</a>
  <a href="contact.html">Contact</a>
</nav>
<main id="main-content" tabindex="-1">
  <h1>Today''s bakes</h1>
  <p>Sourdough, rye and a seeded loaf.</p>
</main>', ARRAY['A skip link is an ordinary anchor whose href is a fragment, beginning with #.', 'Give the main element an id, then point the link at #that-id.', 'Add tabindex="-1" to the main so focus can move there without adding it to the Tab order.']::text[],
       40, 2,
       (select id from public.skills where slug = 'accessibility'), false
from public.lessons l where l.slug = 'keyboard-and-focus-management'
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
       'There is exactly one <main>', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-skip-link-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'main', 'id',
       NULL, NULL, NULL, NULL,
       'The <main> has an id so it can be targeted', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-skip-link-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'main', 'tabindex',
       '-1', NULL, NULL, NULL,
       'The <main> has tabindex="-1" so focus can land on it', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-skip-link-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_matches'::public.requirement_kind, 'a', 'href',
       '^#', NULL, NULL, NULL,
       'A fragment link points somewhere within the page', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-skip-link-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'text_not_empty'::public.requirement_kind, 'a', NULL,
       NULL, NULL, NULL, NULL,
       'The skip link has visible text', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-skip-link-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'keyboard-skip-link-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'keyboard-operability-debug', 2, 'debug'::public.exercise_kind, 'Three things a keyboard cannot reach',
       'This page looks fine and is unusable without a mouse. Three faults: an anchor with no destination, a `<div>` acting as a button, and a positive `tabindex`. Fix all three by using the correct elements.', '<nav aria-label="Main">
  <a>Home</a>
  <a href="menu.html" tabindex="2">Menu</a>
</nav>
<main>
  <h1>Book a table</h1>
  <div class="button">Book now</div>
</main>', '<nav aria-label="Main">
  <a href="index.html">Home</a>
  <a href="menu.html">Menu</a>
</nav>
<main>
  <h1>Book a table</h1>
  <button type="button">Book now</button>
</main>', ARRAY['An anchor is only focusable when it has an href.', 'Something that performs an action is a <button>, not a <div>.', 'Remove the positive tabindex entirely — the source order is already correct.']::text[],
       45, 3,
       (select id from public.skills where slug = 'accessibility'), false
from public.lessons l where l.slug = 'keyboard-and-focus-management'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'a:not([href])', NULL,
       NULL, NULL, 0, 0,
       'Every anchor has an href', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-operability-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_present'::public.requirement_kind, 'button', NULL,
       NULL, NULL, NULL, NULL,
       'The action uses a real <button>', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-operability-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'div.button', NULL,
       NULL, NULL, 0, 0,
       'No <div> is pretending to be a button', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-operability-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, '[tabindex="1"], [tabindex="2"], [tabindex="3"]', NULL,
       NULL, NULL, 0, 0,
       'No positive tabindex values remain', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-operability-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'The page still has exactly one <main>', NULL, 1, true
from public.exercises e where e.slug = 'keyboard-operability-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'keyboard-and-focus-management'), NULL, 'q-focusable-defaults', 1, 'single'::public.question_kind,
        'Which of these is focusable with no `tabindex` at all?', 'An anchor is focusable only when it has an href. Generic containers never are, whatever handlers you attach to them.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`<a>About</a>`', false, NULL
from public.quiz_questions where slug = 'q-focusable-defaults';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`<div class="link">About</div>`', false, NULL
from public.quiz_questions where slug = 'q-focusable-defaults';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`<span class="link">About</span>`', false, NULL
from public.quiz_questions where slug = 'q-focusable-defaults';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`<a href="about.html">About</a>`', true, NULL
from public.quiz_questions where slug = 'q-focusable-defaults';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'keyboard-and-focus-management'), NULL, 'q-tabindex-negative', 2, 'single'::public.question_kind,
        'What does `tabindex="-1"` do?', 'It makes an element focusable by script or by a fragment link, while keeping it out of the Tab sequence.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Removes it from the accessibility tree', false, NULL
from public.quiz_questions where slug = 'q-tabindex-negative';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Puts it last in the Tab order', false, NULL
from public.quiz_questions where slug = 'q-tabindex-negative';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Hides it from screen readers', false, NULL
from public.quiz_questions where slug = 'q-tabindex-negative';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Makes it focusable by script, but skipped by Tab', true, NULL
from public.quiz_questions where slug = 'q-tabindex-negative';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'keyboard-and-focus-management'), NULL, 'q-positive-tabindex', 3, 'single'::public.question_kind,
        'Why is a positive `tabindex` such as `tabindex="5"` treated as a bug?', 'It jumps ahead of everything in the natural order, creating a sequence nobody can predict and which breaks whenever the page changes.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It is ignored by every modern browser', false, NULL
from public.quiz_questions where slug = 'q-positive-tabindex';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It removes the element from the accessibility tree', false, NULL
from public.quiz_questions where slug = 'q-positive-tabindex';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It only works when JavaScript is enabled', false, NULL
from public.quiz_questions where slug = 'q-positive-tabindex';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It jumps the queue, creating an unpredictable and fragile order', true, NULL
from public.quiz_questions where slug = 'q-positive-tabindex';
-- lesson: Accessible names
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'accessible-names-in-depth', 3, 'Accessible names', 'Where the words a screen reader says actually come from', 'Every control is announced by something. Knowing which something, and in what order, is what separates a page that reads well from one that reads as "link, link, button, link".',
       ARRAY['State the order a browser uses to work out an accessible name', 'Write link text that makes sense read out of context', 'Choose the right alt text for informative, decorative and functional images']::text[], 16, 40, (select id from public.skills where slug = 'accessibility'), 0.7
from public.modules m where m.slug = 'accessibility-foundations'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A screen-reader user asks for a list of every link on the page. Nine of them say "Read more". What has gone wrong?',
       NULL, NULL, NULL, '{"options":["Link text is announced without its surrounding paragraph, so nine links are indistinguishable","Nothing — the surrounding text is read out with each link","The links need a `title` attribute as well","Screen readers cannot list links, so it does not matter"],"answer":"Listing links is one of the most common ways screen-reader users navigate, and the list contains the link *text alone* — the paragraph it sat in is gone. Nine identical \"Read more\" entries are nine destinations the user cannot tell apart. This is why link text has to make sense with everything around it removed."}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Explain how a browser computes an accessible name, in order","Write link text that works when read on its own","Decide between descriptive alt text and `alt=\"\"`"]}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'An accessible name is simply the words an element is announced by. Almost every accessibility bug you will meet is really a naming bug: a control with no name, the wrong name, or a name that only makes sense if you can see the rest of the page.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'visual'::public.block_type, NULL, 'Names, roles and states are what assistive technology actually receives.',
       NULL, NULL, 'accessibility-tree', '{}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'How a name is worked out', NULL,
       'The browser works down this list and stops at the first one it finds:

  1. aria-labelledby   points at other elements; their text becomes the name
  2. aria-label        a string you supply directly
  3. the native source  <label> for a field, alt for an image,
                        <legend> for a fieldset, <caption> for a table,
                        the element''s own text for a link or button
  4. title             a last resort, and a poor one', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Prefer the lowest number you can', 'That ordering looks like a ranking of quality, and it is — upside down. `aria-labelledby` and the native sources are best because they reuse text that is *already visible*, so the name and the screen can never disagree. `aria-label` replaces the visible text with something only some users get, which is why a mismatch there breaks voice control. `title` is unreliable on touch, invisible to keyboard users, and should be treated as a fallback you did not want.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'comparison'::public.block_type, 'Link text, read out of context', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Works alone","code":"<h3>Sourdough workshop</h3>\n<p>Six hours, small groups.</p>\n<a href=\"sourdough.html\">Book the sourdough workshop</a>","why":"In a list of links it reads \"Book the sourdough workshop\" — unambiguous with the page removed."},"bad":{"label":"Meaningless alone","code":"<h3>Sourdough workshop</h3>\n<p>Six hours, small groups.</p>\n<a href=\"sourdough.html\">Read more</a>","why":"In a list of links it reads \"Read more\", identical to every other one on the page."}}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'Naming an icon-only button', 'Three attempts. Only one of them is announced usefully.',
       NULL, NULL, NULL, '{"variants":[{"label":"Named with aria-label","code":"<button type=\"button\" aria-label=\"Search\"><img src=\"/learning-media/icons/search.svg\" alt=\"\" width=\"24\" height=\"24\"></button>","note":"Announced as \"Search, button\". The icon takes alt=\"\" because the button already carries the name — describing both would say it twice."},{"label":"Named by the image","code":"<button type=\"button\"><img src=\"/learning-media/icons/search.svg\" alt=\"Search\" width=\"24\" height=\"24\"></button>","note":"Also correct. The button has no text of its own, so the image''s alt becomes the button''s name."},{"label":"Named by nothing","code":"<button type=\"button\"><img src=\"/learning-media/icons/search.svg\" alt=\"\" width=\"24\" height=\"24\"></button>","note":"Announced as just \"button\". The user is told there is a control and nothing about what it does."}]}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'prose'::public.block_type, NULL, 'Alt text is the same problem wearing different clothes. The question is never "what is in this picture" — it is "what would this image have told the reader, and how do I say that in words".',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'media_example'::public.block_type, 'The same photograph, three correct answers', 'Which alt text is right depends entirely on why the image is on the page. All three of these are correct — in different contexts.',
       '<!-- Informative: the image carries information -->
<img src="/learning-media/images/team-portrait.jpg"
     alt="Priya Raman, head baker" width="800" height="800">

<!-- Functional: the image is the link -->
<a href="team.html"><img src="/learning-media/images/team-portrait.jpg"
     alt="Meet the team" width="800" height="800"></a>

<!-- Decorative: the caption already says it -->
<figure>
  <img src="/learning-media/images/team-portrait.jpg" alt=""
       width="800" height="800">
  <figcaption>Priya Raman, head baker</figcaption>
</figure>', 'html', 'team-portrait', '{}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'callout'::public.block_type, '`alt=""` is a decision, not an omission', 'An empty alt says "this image adds nothing, skip it" and is exactly right for decoration or for an image whose caption already carries the message. Leaving the attribute off altogether is different and worse: with no `alt` at all, many screen readers fall back to reading the file name, so the user hears "team hyphen portrait dot jay peg".',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'self_explain'::public.block_type, 'Explain it in your own words', 'A colleague writes `<img src="logo.svg" alt="logo">` and says the image is now accessible because it has alt text. Write your reply. Say what a reader actually gains from that alt, and what it should say instead in two different situations.',
       NULL, NULL, NULL, '{"modelAnswer":"It has alt text and it still tells the reader nothing. \"Logo\" names the *kind of thing* the image is, which the user did not ask about and cannot act on. What matters is what the image does on this page. If the logo is inside a link to the homepage, its alt is the link''s name, so it should say where the link goes — \"Riverside Bakery, home\". If it is decoration beside a heading that already says the company name, it should be `alt=\"\"` so it is skipped rather than announced twice. Same file, two different correct answers, and neither of them is \"logo\"."}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'progressive_detail'::public.block_type, 'Naming regions, groups and tables', 'The same rules extend past controls. A `<nav>` gets a name from `aria-label` or `aria-labelledby`, which is how a user with three navs tells them apart. A group of related radio buttons is named by its `<fieldset>`''s `<legend>`. A data table is named by its `<caption>`. In every case, prefer the native element — the legend and the caption are visible to everyone, and a name everybody can see is a name that cannot silently drift out of date.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'checklist'::public.block_type, 'Naming checklist', NULL,
       NULL, NULL, NULL, '{"items":["Every image has an `alt`, even when the right value is empty","Every form control has a `<label>`, or a name from `aria-labelledby`","Every link makes sense read on its own","Every icon-only button has an `aria-label` or a named image inside it","Every `<nav>` beyond the first has a label distinguishing it","No name is supplied by `title` alone"]}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 15, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["The name comes from `aria-labelledby`, then `aria-label`, then the native source, then `title`.","Prefer sources that reuse visible text, so the name and the screen cannot disagree.","Link text must make sense with the page removed, because that is how it is often heard.","`alt=\"\"` means \"skip this\"; no `alt` at all often means \"read the file name out\"."],"nextUp":"Next: the ARIA worth knowing, and the rule that matters most."}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 16, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["List the four sources of an accessible name, in the order the browser tries them.","Why is \"Read more\" poor link text, and what makes replacement text good?","When is `alt=\"\"` correct, and how does it differ from leaving `alt` off?"],"points":["`aria-labelledby`, then `aria-label`, then the native source (`<label>`, `alt`, `<legend>`, `<caption>`, or the element''s own text), then `title`.","Because links are commonly listed and heard without their surrounding text, so nine \"Read more\" links are indistinguishable. Good link text names the destination — \"Book the sourdough workshop\".","`alt=\"\"` is correct for decoration, or where a caption already carries the message, and tells assistive technology to skip the image. Omitting `alt` entirely often makes a screen reader read out the file name instead."]}'::jsonb
from public.lessons where slug = 'accessible-names-in-depth';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'accessible-names-challenge', 1, 'challenge'::public.exercise_kind, 'Name four controls correctly',
       'Build a small block containing: a search button whose only content is an icon image, a link to `team.html` whose text works read on its own, a decorative image, and a labelled email field. Every one of the four must end up with a sensible accessible name. The wording is yours.', '<!-- A search button with an icon: /learning-media/icons/search.svg -->

<!-- A link to team.html -->

<!-- A decorative image: /learning-media/svg/placeholder.svg -->

<!-- An email field with a label -->
', '<button type="button" aria-label="Search the site">
  <img src="/learning-media/icons/search.svg" alt="" width="24" height="24">
</button>

<a href="team.html">Meet the bakery team</a>

<img src="/learning-media/svg/placeholder.svg" alt="" width="600" height="400">

<label for="email">Email address</label>
<input type="email" id="email" name="email" autocomplete="email">', ARRAY['An icon-only button needs an aria-label, and the icon inside it should then take alt="".', 'Link text should name the destination, not say "click here".', 'A decorative image takes alt="" — the attribute is present, its value is empty.', 'A label needs for="the-input-id", and the input needs a matching id.']::text[],
       50, 3,
       (select id from public.skills where slug = 'accessibility'), false
from public.lessons l where l.slug = 'accessible-names-in-depth'
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
       'There is a button', NULL, 1, true
from public.exercises e where e.slug = 'accessible-names-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'accessible_name'::public.requirement_kind, 'button', NULL,
       NULL, NULL, NULL, NULL,
       'The button has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'accessible-names-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'a[href="team.html"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a link to team.html', NULL, 1, true
from public.exercises e where e.slug = 'accessible-names-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'accessible_name'::public.requirement_kind, 'a', NULL,
       NULL, NULL, NULL, NULL,
       'The link text makes sense on its own', NULL, 1, true
from public.exercises e where e.slug = 'accessible-names-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'img', NULL,
       NULL, NULL, 2, NULL,
       'Both images are present', NULL, 1, true
from public.exercises e where e.slug = 'accessible-names-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every image has an appropriate alt attribute', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'accessible-names-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'The email field has an associated label', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'accessible-names-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'attribute_value'::public.requirement_kind, 'input', 'type',
       'email', NULL, NULL, NULL,
       'The email field uses type="email"', NULL, 1, true
from public.exercises e where e.slug = 'accessible-names-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'local_media_path'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'accessible-names-challenge';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'accessible-names-debug', 2, 'debug'::public.exercise_kind, 'Four names that say nothing',
       'Every control below has a name problem: a link that reads meaninglessly on its own, an icon button with no name, an image whose alt describes the file rather than the content, and a field labelled only by a placeholder. Repair all four.', '<article>
  <h2>Sourdough workshop</h2>
  <p>Six hours, small groups, everything provided.</p>
  <a href="sourdough.html">Click here</a>
  <button type="button"><img src="/learning-media/icons/mail.svg" alt="" width="24" height="24"></button>
  <img src="/learning-media/images/studio-desk.jpg" alt="studio-desk.jpg" width="1200" height="800">
  <input type="email" name="email" placeholder="Email">
</article>', '<article>
  <h2>Sourdough workshop</h2>
  <p>Six hours, small groups, everything provided.</p>
  <a href="sourdough.html">Book the sourdough workshop</a>
  <button type="button" aria-label="Email us about this workshop">
    <img src="/learning-media/icons/mail.svg" alt="" width="24" height="24">
  </button>
  <img src="/learning-media/images/studio-desk.jpg"
       alt="An open laptop, a notebook and a mug on a wooden desk" width="1200" height="800">
  <label for="email">Email address</label>
  <input type="email" id="email" name="email" autocomplete="email">
</article>', ARRAY['Replace "Click here" with text naming where the link goes.', 'The icon button has no text at all, so give it an aria-label.', 'Alt text describes what the image shows, never the file name.', 'A placeholder is not a label — add a real <label> with a matching for and id.']::text[],
       45, 3,
       (select id from public.skills where slug = 'accessibility'), false
from public.lessons l where l.slug = 'accessible-names-in-depth'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'accessible_name'::public.requirement_kind, 'a', NULL,
       NULL, NULL, NULL, NULL,
       'The link has meaningful text of its own', NULL, 1, true
from public.exercises e where e.slug = 'accessible-names-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_absent'::public.requirement_kind, 'a:has(> :only-child)', NULL,
       NULL, NULL, NULL, NULL,
       'The link is not empty', 'The link needs visible text.', 1, true
from public.exercises e where e.slug = 'accessible-names-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'accessible_name'::public.requirement_kind, 'button', NULL,
       NULL, NULL, NULL, NULL,
       'The icon button has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'accessible-names-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'The alt text describes the image, not the file', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'accessible-names-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'The email field has a real label', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'accessible-names-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'attribute_present'::public.requirement_kind, 'label', 'for',
       NULL, NULL, NULL, NULL,
       'The label points at the field with for', NULL, 1, true
from public.exercises e where e.slug = 'accessible-names-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'accessible-names-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'local_media_path'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'accessible-names-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'accessible-names-in-depth'), NULL, 'q-name-order', 1, 'single'::public.question_kind,
        'Which source wins when a button has both `aria-label` and its own text content?', '`aria-label` overrides the element''s own text — which is why a mismatch between the two breaks voice control.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`aria-label` — it replaces the visible text', true, NULL
from public.quiz_questions where slug = 'q-name-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The visible text — ARIA never overrides real content', false, NULL
from public.quiz_questions where slug = 'q-name-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Both are read, one after the other', false, NULL
from public.quiz_questions where slug = 'q-name-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Whichever appears first in the source', false, NULL
from public.quiz_questions where slug = 'q-name-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'accessible-names-in-depth'), NULL, 'q-alt-empty-vs-missing', 2, 'single'::public.question_kind,
        'What is the difference between `alt=""` and leaving `alt` off entirely?', '`alt=""` says "skip this image". No alt at all leaves the reader with nothing, and many screen readers then announce the file name.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`alt=""` hides the image from everyone', false, NULL
from public.quiz_questions where slug = 'q-alt-empty-vs-missing';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A missing alt is required for decorative images', false, NULL
from public.quiz_questions where slug = 'q-alt-empty-vs-missing';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`alt=""` tells assistive tech to skip it; a missing alt often makes it read the file name', true, NULL
from public.quiz_questions where slug = 'q-alt-empty-vs-missing';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'They behave identically', false, NULL
from public.quiz_questions where slug = 'q-alt-empty-vs-missing';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'accessible-names-in-depth'), NULL, 'q-link-text-alone', 3, 'single'::public.question_kind,
        'Why does link text have to make sense without its surrounding paragraph?', 'Screen-reader users frequently pull up a list of every link on the page, and that list contains the link text alone.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Browsers truncate long link text', false, NULL
from public.quiz_questions where slug = 'q-link-text-alone';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It is only a style preference', false, NULL
from public.quiz_questions where slug = 'q-link-text-alone';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Links are often listed on their own, with the surrounding text removed', true, NULL
from public.quiz_questions where slug = 'q-link-text-alone';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Search engines cannot read paragraphs', false, NULL
from public.quiz_questions where slug = 'q-link-text-alone';
-- module: ARIA and accessible forms
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'aria-and-accessible-forms', 2, 'ARIA and accessible forms', 'The small set of ARIA worth knowing, the states that have to be announced when they change, and the forms most people get wrong.',
       75, false
from public.levels l where l.slug = 'accessibility-champion'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'aria-and-accessible-forms' and p.slug = 'accessibility-foundations';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'aria-and-accessible-forms' and s.slug = 'aria';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.5
from public.modules m, public.skills s
where m.slug = 'aria-and-accessible-forms' and s.slug = 'accessibility';
-- lesson: ARIA fundamentals
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'aria-fundamentals', 1, 'ARIA fundamentals', 'A small, useful set — and the rule that matters most', 'ARIA can make a page more accessible or considerably less. The first rule of ARIA is not to use it.',
       ARRAY['State the first rule of ARIA', 'Use aria-label, aria-labelledby, aria-describedby and aria-current correctly', 'Explain what a live region is and when to use one']::text[], 15, 40, (select id from public.skills where slug = 'aria'), 0.7
from public.modules m where m.slug = 'aria-and-accessible-forms'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A developer wants a clickable "Menu" control and writes `<div role="button">Menu</div>`. A screen reader announces it as a button. What happens when someone presses Enter on it?',
       NULL, NULL, NULL, '{"options":["Nothing — it is announced as a button but does not behave like one","It activates, because the role tells the browser how to treat it","It activates, but only in browsers that support ARIA","The page reports an error"],"answer":"Nothing happens. This is the single most important thing to understand about ARIA, and it is why the first rule of ARIA is not to use it. A role changes what assistive technology *announces* and nothing else — not focus, not keyboard behaviour, not anything. So this control is now announced as a button to exactly the users who cannot operate it, which is worse than leaving it unannounced."}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Explain why native HTML beats ARIA","Apply the handful of ARIA attributes worth knowing","Recognise ARIA that makes a page worse"]}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'callout'::public.block_type, 'The first rule of ARIA', 'If a native HTML element will do the job, use it instead. ARIA changes what assistive technology *announces*; it changes nothing about how an element actually behaves. `<div role="button">` is announced as a button but is still not focusable, still ignores Enter and Space, and still does nothing on a keyboard. You would have to add all of that yourself — or use `<button>`, which has it already.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'comparison'::public.block_type, 'The same control, two ways', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Native","code":"<button type=\"button\">Menu</button>","why":"Focusable, announced as a button, responds to Enter and Space, works with voice control. Zero extra work."},"bad":{"label":"ARIA rebuild","code":"<div role=\"button\" tabindex=\"0\" aria-pressed=\"false\">Menu</div>","why":"Announced as a button, but Enter and Space do nothing without JavaScript, and voice-control software may not find it. More code, less function."}}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'prose'::public.block_type, NULL, 'These are the ARIA attributes genuinely worth knowing at this stage.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, 'The ARIA worth learning first', NULL,
       'aria-label="Main"          Names an element that has no visible label.
                           Use on <nav>, <section>, <iframe>, icon-only buttons.

aria-labelledby="id"       Names an element using text that is already on the page.
                           Prefer this over aria-label when such text exists.

aria-describedby="id"      Attaches extra description, read after the name.
                           Use for format hints and error messages on form fields.

aria-current="page"        Marks the current item in a set — the link to the page
                           you are already on, or the current step in a process.

aria-expanded="true"       States whether a control''s target is open. Native
                           <details> manages this for you; custom widgets do not.

aria-live="polite"         Marks a region whose changes should be announced when
                           the user is idle. Use very sparingly.

aria-hidden="true"         Removes an element from the accessibility tree entirely.
                           Only for genuinely decorative things.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<section aria-labelledby="hours-heading">
  <h2 id="hours-heading">Opening hours</h2>
  <p>Tuesday to Sunday, 8am to 6pm.</p>
</section>

<button type="button" aria-label="Search">
  <img src="/learning-media/icons/search.svg" alt="" width="24" height="24">
</button>', 'html', NULL, '{"annotations":[{"line":"1","text":"`aria-labelledby` names the section using its own heading. Better than `aria-label`, because the name and the visible text can never drift apart."},{"line":"6","text":"An icon-only button has no text, so it has no accessible name. `aria-label=\"Search\"` supplies one."},{"line":"7","text":"The icon itself takes `alt=\"\"`: the button already has a name, and describing the icon too would announce it twice."}]}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'callout'::public.block_type, '`aria-label` on the wrong element', '`aria-label` is ignored on most non-interactive elements — a `<span>`, a `<div>` with no role, a plain `<p>`. It works on interactive elements and on landmarks. Putting it on a `<div>` and assuming it will be read is one of the most common ARIA mistakes.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'term'::public.block_type, 'Live region', 'An area whose changes should be announced without moving focus — a form error summary, a "message sent" confirmation, a live score. `aria-live="polite"` waits for a pause; `assertive` interrupts immediately and should be reserved for genuine emergencies.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'code_example'::public.block_type, 'An accessible error message', NULL,
       '<p id="email-error" role="alert">
  Enter an email address in the format name@example.com
</p>

<input type="email" id="email" name="email"
       aria-describedby="email-error" aria-invalid="true">', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'callout'::public.block_type, 'What makes an error message accessible', 'Four things. It says what is wrong in plain words. It says how to fix it. It is connected to the field with `aria-describedby`, so it is read when the user reaches the field. And it is announced when it appears, via `role="alert"` — because a message the user has to go looking for is a message they will miss.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'predict_check'::public.block_type, 'Predict, then check', 'Two elements, each given an `aria-label`. Before you check: what does a screen reader announce for each — and is either of them what the author intended?',
       '<button type="button" aria-label="Search">Search our recipes</button>

<span aria-label="Closed today">Closed</span>', 'html', NULL, '{"outcome":"Neither is. The button is announced as just \"Search\", because `aria-label` *replaces* the visible text rather than adding to it — so a voice-control user saying \"click Search our recipes\" now finds nothing. The `<span>` is announced as plain \"Closed\", because `aria-label` is ignored on a non-interactive element with no role; the label is simply dropped. Both are quiet failures: the markup looks careful, the page looks fine, and the accessibility is worse than if neither attribute had been written."}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'progressive_detail'::public.block_type, 'When ARIA is genuinely the right answer', 'ARIA earns its place where HTML has no equivalent: naming a landmark that has no visible heading; announcing a change that happens without a page load; marking the current item in a set; describing a relationship between elements that are not nested. Those are real gaps, and ARIA fills them well. What it cannot do is turn a `<div>` into a working control.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'interactive_demo'::public.block_type, 'Native element versus ARIA rebuild', 'Tab to each one and press Space.',
       NULL, NULL, NULL, '{"variants":[{"label":"A real button","code":"<button type=\"button\">Menu</button>","note":"Focusable, announced as a button, responds to Enter and Space, findable by voice control. No attributes required."},{"label":"The ARIA rebuild","code":"<div role=\"button\" tabindex=\"0\">Menu</div>","note":"Announced as a button and focusable — but Enter and Space do nothing without a script, so it is announced as operable to precisely the people who cannot operate it."},{"label":"A role and nothing else","code":"<div role=\"button\">Menu</div>","note":"Announced as a button and not even reachable by Tab. The role changed what is said about it and nothing about what it does."}]}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 15, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["First rule of ARIA: use native HTML instead, whenever you can.","ARIA changes announcements, never behaviour.","`aria-labelledby` is better than `aria-label` when visible text already exists.","Error messages need plain words, a fix, `aria-describedby`, and an announcement."],"nextUp":"Next: the accessibility audit milestone."}'::jsonb
from public.lessons where slug = 'aria-fundamentals';

commit;
