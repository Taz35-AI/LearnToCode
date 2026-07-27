-- HTML Hero — course seed, part 6 of 9
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
select id, 8, 'summary'::public.block_type, 'Lesson summary', NULL,
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
-- lesson: ARIA fundamentals
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'aria-fundamentals', 2, 'ARIA fundamentals', 'A small, useful set — and the rule that matters most', 'ARIA can make a page more accessible or considerably less. The first rule of ARIA is not to use it.',
       ARRAY['State the first rule of ARIA', 'Use aria-label, aria-labelledby, aria-describedby and aria-current correctly', 'Explain what a live region is and when to use one']::text[], 15, 40, (select id from public.skills where slug = 'aria'), 0.7
from public.modules m where m.slug = 'accessibility-foundations'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Explain why native HTML beats ARIA","Apply the handful of ARIA attributes worth knowing","Recognise ARIA that makes a page worse"]}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'callout'::public.block_type, 'The first rule of ARIA', 'If a native HTML element will do the job, use it instead. ARIA changes what assistive technology *announces*; it changes nothing about how an element actually behaves. `<div role="button">` is announced as a button but is still not focusable, still ignores Enter and Space, and still does nothing on a keyboard. You would have to add all of that yourself — or use `<button>`, which has it already.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'comparison'::public.block_type, 'The same control, two ways', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Native","code":"<button type=\"button\">Menu</button>","why":"Focusable, announced as a button, responds to Enter and Space, works with voice control. Zero extra work."},"bad":{"label":"ARIA rebuild","code":"<div role=\"button\" tabindex=\"0\" aria-pressed=\"false\">Menu</div>","why":"Announced as a button, but Enter and Space do nothing without JavaScript, and voice-control software may not find it. More code, less function."}}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'prose'::public.block_type, NULL, 'These are the ARIA attributes genuinely worth knowing at this stage.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'The ARIA worth learning first', NULL,
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
select id, 6, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<section aria-labelledby="hours-heading">
  <h2 id="hours-heading">Opening hours</h2>
  <p>Tuesday to Sunday, 8am to 6pm.</p>
</section>

<button type="button" aria-label="Search">
  <img src="/learning-media/icons/search.svg" alt="" width="24" height="24">
</button>', 'html', NULL, '{"annotations":[{"line":"1","text":"`aria-labelledby` names the section using its own heading. Better than `aria-label`, because the name and the visible text can never drift apart."},{"line":"6","text":"An icon-only button has no text, so it has no accessible name. `aria-label=\"Search\"` supplies one."},{"line":"7","text":"The icon itself takes `alt=\"\"`: the button already has a name, and describing the icon too would announce it twice."}]}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, '`aria-label` on the wrong element', '`aria-label` is ignored on most non-interactive elements — a `<span>`, a `<div>` with no role, a plain `<p>`. It works on interactive elements and on landmarks. Putting it on a `<div>` and assuming it will be read is one of the most common ARIA mistakes.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'term'::public.block_type, 'Live region', 'An area whose changes should be announced without moving focus — a form error summary, a "message sent" confirmation, a live score. `aria-live="polite"` waits for a pause; `assertive` interrupts immediately and should be reserved for genuine emergencies.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'code_example'::public.block_type, 'An accessible error message', NULL,
       '<p id="email-error" role="alert">
  Enter an email address in the format name@example.com
</p>

<input type="email" id="email" name="email"
       aria-describedby="email-error" aria-invalid="true">', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'callout'::public.block_type, 'What makes an error message accessible', 'Four things. It says what is wrong in plain words. It says how to fix it. It is connected to the field with `aria-describedby`, so it is read when the user reaches the field. And it is announced when it appears, via `role="alert"` — because a message the user has to go looking for is a message they will miss.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'When ARIA is genuinely the right answer', 'ARIA earns its place where HTML has no equivalent: naming a landmark that has no visible heading; announcing a change that happens without a page load; marking the current item in a set; describing a relationship between elements that are not nested. Those are real gaps, and ARIA fills them well. What it cannot do is turn a `<div>` into a working control.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["First rule of ARIA: use native HTML instead, whenever you can.","ARIA changes announcements, never behaviour.","`aria-labelledby` is better than `aria-label` when visible text already exists.","Error messages need plain words, a fix, `aria-describedby`, and an announcement."],"nextUp":"Next: the accessibility audit milestone."}'::jsonb
from public.lessons where slug = 'aria-fundamentals';
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
-- lesson: Milestone: audit and repair an inaccessible site
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'accessibility-audit-milestone', 3, 'Milestone: audit and repair an inaccessible site', 'Fifteen deliberate failures, one page', 'The page in this milestone was written to fail. Your job is to find and fix everything.',
       ARRAY['Audit a page systematically against WCAG principles', 'Repair every failure using correct HTML', 'Produce a page that passes a keyboard test']::text[], 30, 40, (select id from public.skills where slug = 'accessibility'), 0.85
from public.modules m where m.slug = 'accessibility-foundations'
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
-- lesson: Milestone: optimise a page for discovery
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'seo-milestone', 3, 'Milestone: optimise a page for discovery', 'Every metadata decision on one page', 'A complete, discoverable, shareable page head plus a correctly structured body.',
       ARRAY['Build a complete production-quality document head', 'Add social metadata and structured data', 'Apply the same to your capstone site']::text[], 22, 40, (select id from public.skills where slug = 'seo'), 0.8
from public.modules m where m.slug = 'page-metadata'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;

commit;
