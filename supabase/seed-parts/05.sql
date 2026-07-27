-- HTML Hero — course seed, part 5 of 7
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
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'labels-and-inputs'), NULL, 'q-label-for', 1, 'single'::public.question_kind,
        'What joins a `<label>` to its input?', 'The label''s `for` attribute must match the input''s `id` exactly.', (select id from public.skills where slug = 'forms'), 10);
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
        'Why should placeholder text not be used as a label?', 'It disappears as soon as the user types, its contrast usually fails WCAG, and screen-reader support is inconsistent.', (select id from public.skills where slug = 'accessibility'), 10);
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
        'Which field should NOT use `type="number"`?', '`number` is for quantities. A phone number is not a quantity — it can contain spaces and leading zeros, both of which `number` damages.', (select id from public.skills where slug = 'forms'), 10);
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
        'What happens to an input with no `name` attribute?', 'Its value is not submitted with the form at all.', (select id from public.skills where slug = 'forms'), 10);
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
from public.modules m where m.slug = 'form-foundations';
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
from public.lessons l where l.slug = 'grouping-and-controls';
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
from public.lessons l where l.slug = 'grouping-and-controls';
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
        'What makes two radio buttons part of the same group?', 'A shared `name` attribute. The fieldset labels the group but does not create it.', (select id from public.skills where slug = 'forms'), 10);
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
        'A `<button>` inside a form with no `type` attribute — what does it do when clicked?', 'It submits the form, because `submit` is the default type.', (select id from public.skills where slug = 'forms'), 10);
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
        'Where must `<legend>` appear?', 'As the first child of its `<fieldset>`.', (select id from public.skills where slug = 'forms'), 10);
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
from public.modules m where m.slug = 'form-foundations';
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
from public.lessons l where l.slug = 'validation-and-form-milestone';
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
from public.lessons l where l.slug = 'validation-and-form-milestone';
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
from public.lessons l where l.slug = 'validation-and-form-milestone';
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
        'Is `required` a security feature?', 'No. It can be removed with developer tools, and a request can be sent without loading your page at all. The server must revalidate everything.', (select id from public.skills where slug = 'security'), 10);
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
        'Which method should a login form use?', 'POST. GET would put the password in the URL, browser history and server logs.', (select id from public.skills where slug = 'security'), 10);
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
        'What does `aria-describedby` on an input do?', 'It connects the field to descriptive text elsewhere on the page, so a screen reader reads the hint after the label.', (select id from public.skills where slug = 'aria'), 10);
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
        'Which element gives a table its title?', '`<caption>`, as the first child of `<table>`.', (select id from public.skills where slug = 'tables'), 10);
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
        'A cell contains "£34". A screen reader announces "Road bike, Per day, £34". What made that possible?', 'Header cells with `scope`, telling the screen reader which headings apply to that cell.', (select id from public.skills where slug = 'tables'), 10);
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
        'What connects a label to its input?', 'The label''s `for` value matches the input''s `id`.', (select id from public.skills where slug = 'forms'), 10);
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
        'Which attribute makes two radio buttons mutually exclusive?', 'A shared `name` attribute. The fieldset labels the group for screen readers, but it is the matching name that makes the browser treat them as one choice.', (select id from public.skills where slug = 'forms'), 10);
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
        'Which input type suits a UK postcode?', 'A postcode contains letters and a space, so `text`. `number` would strip formatting and reject letters.', (select id from public.skills where slug = 'forms'), 10);
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
        'Which form method should be used for a search box?', 'GET, so results appear in the URL and can be bookmarked and shared. It only reads data.', (select id from public.skills where slug = 'forms'), 10);
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
        'What must accompany a `pattern` attribute?', 'A visible, plain-language description of the required format, connected with `aria-describedby`.', (select id from public.skills where slug = 'accessibility'), 10);
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
        'What does `<legend>` do?', 'It labels the whole `<fieldset>` group, and screen readers announce it before each control in the group.', (select id from public.skills where slug = 'forms'), 10);
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
        'You add a "Show password" button inside a form and omit `type`. What happens on click?', 'It submits the form, because `submit` is the default button type.', (select id from public.skills where slug = 'forms'), 10);
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
        'Why is `<input type="hidden">` unsuitable for secrets?', 'Its value is in the page source, visible to anyone who looks.', (select id from public.skills where slug = 'security'), 10);
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
from public.courses c where c.slug = 'html-hero';
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-7-milestone', 'milestone'::public.assessment_kind, 'Level 7 milestone: Native Interaction Expert', 'Seven questions on native interactive elements and progressive enhancement. Pass mark 75%.',
       0.75, 170, 7
from public.levels l where l.slug = 'native-interaction';
-- module: Disclosure, dialogs and popovers
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'disclosure-and-dialog', 1, 'Disclosure, dialogs and popovers', 'details, summary, dialog and the popover attribute — the four features that replace most simple JavaScript widgets.',
       45, false
from public.levels l where l.slug = 'native-interaction';
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
from public.modules m where m.slug = 'disclosure-and-dialog';
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
from public.lessons l where l.slug = 'details-and-summary';
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
        'Where must `<summary>` appear?', 'As the first child of its `<details>` element.', (select id from public.skills where slug = 'native-interaction'), 10);
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
        'What does giving several `<details>` elements the same `name` do?', 'It makes them exclusive: opening one closes the others.', (select id from public.skills where slug = 'native-interaction'), 10);
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
from public.modules m where m.slug = 'disclosure-and-dialog';
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
from public.lessons l where l.slug = 'dialog-and-popover';
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
from public.lessons l where l.slug = 'dialog-and-popover';
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
        'How can a `<dialog>` be closed without JavaScript?', 'With a `<form method="dialog">` — submitting it closes the dialog.', (select id from public.skills where slug = 'native-interaction'), 10);
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
        'Does the `popover` attribute require JavaScript?', 'No. `popovertarget` on a button wires up the whole interaction, including the ARIA relationship.', (select id from public.skills where slug = 'native-interaction'), 10);
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
        'Why should essential content never live only inside a dialog?', 'Anyone whose browser does not open it, or whose JavaScript fails, cannot reach the content at all.', (select id from public.skills where slug = 'progressive-enhancement'), 10);
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
from public.modules m where m.slug = 'disclosure-and-dialog';
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
from public.lessons l where l.slug = 'progress-meter-datalist-milestone';
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
from public.lessons l where l.slug = 'progress-meter-datalist-milestone';
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
from public.lessons l where l.slug = 'progress-meter-datalist-milestone';
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
        'Which element suits "disk space used: 62%"?', 'A gauge reading within a range, with no notion of completion — that is `<meter>`.', (select id from public.skills where slug = 'native-interaction'), 10);
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
        'Does a `<datalist>` restrict what the user can type?', 'No — it suggests. If only certain values are acceptable, use a `<select>` instead.', (select id from public.skills where slug = 'native-interaction'), 10);
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
        'What does `<details>` give you that a hand-built accordion must reimplement?', 'Keyboard activation, expanded/collapsed announcements, find-in-page support and correct printing — all built in.', (select id from public.skills where slug = 'native-interaction'), 10);
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
        'Which part of using `<dialog>` still needs JavaScript?', 'Opening it. `showModal()` is a JavaScript method with no HTML equivalent.', (select id from public.skills where slug = 'native-interaction'), 10);
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
        'What connects a button to a popover?', '`popovertarget`, holding the id of the popover element.', (select id from public.skills where slug = 'native-interaction'), 10);
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
        'Which element suits "uploading file 3 of 5"?', 'A task moving towards completion — `<progress>`.', (select id from public.skills where slug = 'native-interaction'), 10);
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
        'What is progressive enhancement?', 'Building so the page works without the enhancement, then layering the enhancement on for browsers that support it.', (select id from public.skills where slug = 'progressive-enhancement'), 10);
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
        'Several `<details>` share `name="faq"`. What happens when you open the second one?', 'The first closes. A shared name makes them mutually exclusive.', (select id from public.skills where slug = 'native-interaction'), 10);
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
        'Why is `<output>` useful for a calculated total?', 'It is a live region by default, so screen readers announce the new value when it changes.', (select id from public.skills where slug = 'aria'), 10);
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
from public.courses c where c.slug = 'html-hero';
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-8-milestone', 'milestone'::public.assessment_kind, 'Level 8 milestone: Accessibility Champion', 'Nine questions on accessibility and ARIA. Pass mark 80% — this level matters.',
       0.8, 220, 8
from public.levels l where l.slug = 'accessibility-champion';
-- module: Accessibility foundations
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'accessibility-foundations', 1, 'Accessibility foundations', 'How assistive technology reads your page, how to test with a keyboard, and the accessibility your HTML already provides.',
       50, false
from public.levels l where l.slug = 'accessibility-champion';
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
from public.modules m where m.slug = 'accessibility-foundations';
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
from public.lessons l where l.slug = 'how-assistive-tech-reads-a-page';
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
        'What is the accessibility tree?', 'A second structure the browser builds from your HTML, containing roles, names and states, which assistive technology reads.', (select id from public.skills where slug = 'accessibility'), 10);
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
        'What does pressing Tab through a page test?', 'Whether every interactive element is reachable, whether focus is visible, and whether the order makes sense.', (select id from public.skills where slug = 'accessibility'), 10);
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
        'Why is `<div onclick="…">` not a button?', 'It cannot be focused with a keyboard, is not announced as a button, and does not respond to Enter or Space.', (select id from public.skills where slug = 'accessibility'), 10);
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
from public.modules m where m.slug = 'accessibility-foundations';
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
from public.lessons l where l.slug = 'aria-fundamentals';
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
from public.lessons l where l.slug = 'aria-fundamentals';
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
        'What is the first rule of ARIA?', 'Do not use ARIA if a native HTML element will do the job.', (select id from public.skills where slug = 'aria'), 10);
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
        'Does `role="button"` make a `<div>` respond to the Enter key?', 'No. ARIA changes what is announced, never how an element behaves. You would have to add focus handling and key handling yourself.', (select id from public.skills where slug = 'aria'), 10);
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
        'A section has a visible `<h2>`. How should you name the section?', '`aria-labelledby` pointing at the heading, so the name and the visible text can never disagree.', (select id from public.skills where slug = 'aria'), 10);
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
from public.modules m where m.slug = 'accessibility-foundations';
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

commit;
