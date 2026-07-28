-- HTML Hero — course seed, part 11 of 11
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 10 first.

begin;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Set `border-box` once, at the top, on everything.","Padding is inside and takes the background; margin is outside and is transparent.","Selectors should be as weak as they can be while still matching."],"nextUp":"Next: flow, positioning and stacking."}'::jsonb
from public.lessons where slug = 'css-box-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why does `border-box` belong at the top of a stylesheet rather than on individual components?"],"points":["Because it changes what `width` means everywhere, and a component sized under one model inside a page using the other is unpredictable. Setting it once, universally, makes every later width mean the same thing — and it does not inherit, so the universal selector is the only way to reach everything."]}'::jsonb
from public.lessons where slug = 'css-box-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-box-milestone-challenge', 1, 'challenge'::public.exercise_kind, 'Build a predictable card',
       'Build a `.card` that is 320px wide on screen, with 1.5rem of internal padding, a 1px solid border, and 2rem of space below it separating it from the next card. Apply border-box sizing to everything. Every selector must be a single class or the universal selector — no ids, no `!important`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Card</title>
    <style>
    </style>
  </head>
  <body>
    <div class="card">
      <h2>Sourdough workshop</h2>
      <p>Six hours, small groups.</p>
    </div>
    <div class="card">
      <h2>Rye workshop</h2>
      <p>Four hours, small groups.</p>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Card</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card {
        width: 320px;
        padding: 1.5rem;
        border: 1px solid teal;
        margin-bottom: 2rem;
      }
    </style>
  </head>
  <body>
    <div class="card">
      <h2>Sourdough workshop</h2>
      <p>Six hours, small groups.</p>
    </div>
    <div class="card">
      <h2>Rye workshop</h2>
      <p>Four hours, small groups.</p>
    </div>
  </body>
</html>', ARRAY['Start with the universal border-box rule.', 'Space *inside* the card is padding; space *between* cards is margin.', 'A border needs a style keyword: 1px solid teal.']::text[],
       60, 3,
       (select id from public.skills where slug = 'box-model'), false
from public.lessons l where l.slug = 'css-box-milestone'
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
       'Cards use border-box sizing', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-box-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.card', 'width',
       '320px', NULL, NULL, NULL,
       'The card is 320px wide', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-box-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.card', 'padding',
       '1.5rem', NULL, NULL, NULL,
       'The card has 1.5rem of padding', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-box-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value_matches'::public.requirement_kind, '.card', 'border',
       '1px\s+solid', NULL, NULL, NULL,
       'The card has a 1px solid border', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-box-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value_matches'::public.requirement_kind, '.card', 'margin-bottom',
       '2rem', NULL, NULL, NULL,
       'Cards are separated by 2rem', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-box-milestone-challenge';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-box-milestone-debug', 2, 'debug'::public.exercise_kind, 'A card that is the wrong size',
       'This card should be 320px on screen and is not, and the space between cards is not what the author wrote. Fix the sizing model and use the correct property for the space *between* cards. Do not change the declared 320px.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Card</title>
    <style>
      .card {
        width: 320px;
        padding: 1.5rem;
        border: 1px solid teal;
        padding-bottom: 2rem;
      }
    </style>
  </head>
  <body>
    <div class="card">Sourdough workshop</div>
    <div class="card">Rye workshop</div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Card</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card {
        width: 320px;
        padding: 1.5rem;
        border: 1px solid teal;
        margin-bottom: 2rem;
      }
    </style>
  </head>
  <body>
    <div class="card">Sourdough workshop</div>
    <div class="card">Rye workshop</div>
  </body>
</html>', ARRAY['Without border-box, the padding and border are added to the 320px.', 'Extra padding at the bottom makes the card taller — it does not separate the cards.', 'Space between elements is margin.']::text[],
       55, 3,
       (select id from public.skills where slug = 'box-model'), false
from public.lessons l where l.slug = 'css-box-milestone'
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
       'Cards use border-box sizing', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-box-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.card', 'width',
       '320px', NULL, NULL, NULL,
       'The declared width is unchanged', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-box-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value_matches'::public.requirement_kind, '.card', 'margin-bottom',
       '2rem', NULL, NULL, NULL,
       'Cards are separated by margin, not padding', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-box-milestone-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-box-milestone'), NULL, 'q-css-padding-vs-margin', 1, 'single'::public.question_kind,
        'Which property creates space *between* two elements?', 'Margin is outside the box. Padding is inside it and makes the element itself bigger.', (select id from public.skills where slug = 'box-model'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`margin`', true, NULL
from public.quiz_questions where slug = 'q-css-padding-vs-margin';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`padding`', false, NULL
from public.quiz_questions where slug = 'q-css-padding-vs-margin';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`border`', false, NULL
from public.quiz_questions where slug = 'q-css-padding-vs-margin';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`gap`, always', false, NULL
from public.quiz_questions where slug = 'q-css-padding-vs-margin';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-box-milestone'), NULL, 'q-css-border-needs-style', 2, 'single'::public.question_kind,
        'Why does `border: 1px teal` show nothing?', 'The style keyword is required — without `solid`, `dashed` and so on, the border style defaults to `none`.', (select id from public.skills where slug = 'box-model'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Borders need a width of at least 2px', false, NULL
from public.quiz_questions where slug = 'q-css-border-needs-style';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The shorthand must list colour first', false, NULL
from public.quiz_questions where slug = 'q-css-border-needs-style';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The style keyword is missing, and it defaults to none', true, NULL
from public.quiz_questions where slug = 'q-css-border-needs-style';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Teal is not a valid border colour', false, NULL
from public.quiz_questions where slug = 'q-css-border-needs-style';
-- Level 2 milestone: Boxes and Selectors questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-2-milestone'), 'a-css-2-width-default', 1, 'single'::public.question_kind,
        'A box has `width: 300px`, `padding: 20px`, `border: 5px`. How wide is it by default?', '350px — padding and border are added outside the content width.', (select id from public.skills where slug = 'box-model'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '300px', false, NULL
from public.quiz_questions where slug = 'a-css-2-width-default';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '260px', false, NULL
from public.quiz_questions where slug = 'a-css-2-width-default';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '325px', false, NULL
from public.quiz_questions where slug = 'a-css-2-width-default';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '350px', true, NULL
from public.quiz_questions where slug = 'a-css-2-width-default';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-2-milestone'), 'a-css-2-border-box', 2, 'single'::public.question_kind,
        'What does `box-sizing: border-box` change?', '`width` comes to mean the whole visible box, with padding and border taken out of it.', (select id from public.skills where slug = 'box-model'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Padding stops taking the background colour', false, NULL
from public.quiz_questions where slug = 'a-css-2-border-box';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`width` means content plus padding plus border', true, NULL
from public.quiz_questions where slug = 'a-css-2-border-box';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`width` starts including the margin', false, NULL
from public.quiz_questions where slug = 'a-css-2-border-box';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Borders stop taking up space', false, NULL
from public.quiz_questions where slug = 'a-css-2-border-box';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-2-milestone'), 'a-css-2-collapse', 3, 'single'::public.question_kind,
        'Where do vertical margins *not* collapse?', 'Inside a flex or grid container, margins never collapse.', (select id from public.skills where slug = 'box-model'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Between a parent and its first child', false, NULL
from public.quiz_questions where slug = 'a-css-2-collapse';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'They always collapse', false, NULL
from public.quiz_questions where slug = 'a-css-2-collapse';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Inside a flex or grid container', true, NULL
from public.quiz_questions where slug = 'a-css-2-collapse';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Between adjacent paragraphs', false, NULL
from public.quiz_questions where slug = 'a-css-2-collapse';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-2-milestone'), 'a-css-2-combinator', 4, 'single'::public.question_kind,
        'Which selector matches only the direct children?', 'The child combinator, `>`.', (select id from public.skills where slug = 'selectors'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`.card p`', false, NULL
from public.quiz_questions where slug = 'a-css-2-combinator';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`.card + p`', false, NULL
from public.quiz_questions where slug = 'a-css-2-combinator';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`.card ~ p`', false, NULL
from public.quiz_questions where slug = 'a-css-2-combinator';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`.card > p`', true, NULL
from public.quiz_questions where slug = 'a-css-2-combinator';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-2-milestone'), 'a-css-2-attribute', 5, 'single'::public.question_kind,
        'What does `a[href$=".pdf"]` match?', 'Links whose href *ends with* `.pdf`.', (select id from public.skills where slug = 'selectors'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Links with any href', false, NULL
from public.quiz_questions where slug = 'a-css-2-attribute';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Links whose href ends with .pdf', true, NULL
from public.quiz_questions where slug = 'a-css-2-attribute';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Links whose href starts with .pdf', false, NULL
from public.quiz_questions where slug = 'a-css-2-attribute';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Links whose href contains .pdf anywhere', false, NULL
from public.quiz_questions where slug = 'a-css-2-attribute';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-2-milestone'), 'a-css-2-specificity-cost', 6, 'single'::public.question_kind,
        'What is the practical cost of `#sidebar .widget ul li a`?', 'Every later override must match or beat one id, one class and three elements — and the rule breaks if the markup structure changes.', (select id from public.skills where slug = 'selectors'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Nothing — it is the recommended approach', false, NULL
from public.quiz_questions where slug = 'a-css-2-specificity-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Every future override must beat it, and it breaks if the markup changes', true, NULL
from public.quiz_questions where slug = 'a-css-2-specificity-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It renders more slowly than a class', false, NULL
from public.quiz_questions where slug = 'a-css-2-specificity-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is invalid CSS', false, NULL
from public.quiz_questions where slug = 'a-css-2-specificity-cost';
-- --------------------------------------------------------------------------
-- Remove content deleted from the curriculum
-- --------------------------------------------------------------------------

delete from public.quiz_questions where slug not in ('a1-q1', 'a1-q2', 'a1-q3', 'a1-q4', 'a1-q5', 'a1-q6', 'a1-q7', 'a1-q8', 'a1-q9', 'a1-q10', 'q-what-is-html', 'q-html-purpose', 'q-tag-vs-element', 'q-attribute-syntax', 'q-void-elements', 'q-nesting-order', 'q-dom-meaning', 'q-comments', 'q-doctype-purpose', 'q-head-vs-body', 'q-viewport', 'q-charset', 'q-index-html', 'q-one-h1', 'a2-q1', 'a2-q2', 'a2-q3', 'a2-q4', 'a2-q5', 'a2-q6', 'a2-q7', 'a2-q8', 'q-heading-skip', 'q-heading-purpose', 'q-whitespace', 'q-br-use', 'q-hr-meaning', 'q-strong-vs-em', 'q-small-meaning', 'q-cite-meaning', 'q-datetime-format', 'q-q-quotes', 'q-entity-lt', 'q-list-choice', 'q-nested-list', 'q-semantic-choice', 'a3-q1', 'a3-q2', 'a3-q3', 'a3-q4', 'a3-q5', 'a3-q6', 'a3-q7', 'a3-q8', 'q-link-text', 'q-noopener', 'q-dotdot', 'q-leading-slash', 'q-fragment-case', 'q-tel-format', 'q-download-attr', 'q-nav-list', 'q-skip-link-position', 'q-aria-current', 'q-filenames', 'q-nav-consistency', 'a4-q1', 'a4-q2', 'a4-q3', 'a4-q4', 'a4-q5', 'a4-q6', 'a4-q7', 'a4-q8', 'a4-q9', 'q-img-dimensions', 'q-hotlinking', 'q-empty-alt', 'q-alt-vs-caption', 'q-missing-alt', 'q-srcset-w', 'q-sizes-purpose', 'q-picture-img', 'q-lazy-hero', 'q-picture-vs-srcset', 'q-video-controls', 'q-track-kind', 'q-fallback-placement', 'q-iframe-title', 'q-sandbox', 'a5-q1', 'a5-q2', 'a5-q3', 'a5-q4', 'a5-q5', 'a5-q6', 'a5-q7', 'a5-q8', 'q-semantic-meaning', 'q-main-count', 'q-article-test', 'q-section-heading', 'q-outline-algorithm', 'q-case-sensitivity', 'q-comments-value', 'q-footer-placement', 'a6-q1', 'a6-q2', 'a6-q3', 'a6-q4', 'a6-q5', 'a6-q6', 'a6-q7', 'a6-q8', 'a6-q9', 'a6-q10', 'q-scope-col', 'q-caption-position', 'q-layout-tables', 'q-label-for', 'q-placeholder', 'q-number-type', 'q-name-attribute', 'q-radio-group', 'q-button-type', 'q-legend-position', 'q-client-validation', 'q-get-vs-post', 'q-aria-describedby', 'a7-q1', 'a7-q2', 'a7-q3', 'a7-q4', 'a7-q5', 'a7-q6', 'a7-q7', 'q-summary-position', 'q-details-name', 'q-dialog-close', 'q-popover-js', 'q-modal-content', 'q-progress-vs-meter', 'q-datalist-restrict', 'a8-q1', 'a8-q2', 'a8-q3', 'a8-q4', 'a8-q5', 'a8-q6', 'a8-q7', 'a8-q8', 'a8-q9', 'q-a11y-tree', 'q-keyboard-test', 'q-div-button', 'q-focusable-defaults', 'q-tabindex-negative', 'q-positive-tabindex', 'q-name-order', 'q-alt-empty-vs-missing', 'q-link-text-alone', 'q-aria-first-rule', 'q-aria-behaviour', 'q-labelledby-vs-label', 'q-aria-current-page', 'q-live-region-timing', 'q-assertive-vs-polite', 'q-placeholder-not-label', 'q-fieldset-legend', 'q-autocomplete-requirement', 'q-audit-order', 'q-duplicate-id-impact', 'a9-q1', 'a9-q2', 'a9-q3', 'a9-q4', 'a9-q5', 'a9-q6', 'a9-q7', 'a9-q8', 'q-title-length', 'q-canonical', 'q-noindex-security', 'q-og-property', 'q-structured-data-ranking', 'q-og-image-url', 'q-lang-missing-effect', 'q-wrong-lang-worse', 'q-dir-auto', 'q-metadata-order', 'a10-q1', 'a10-q2', 'a10-q3', 'a10-q4', 'a10-q5', 'a10-q6', 'a10-q7', 'a10-q8', 'q-layout-shift', 'q-defer-async', 'q-preload-overuse', 'q-noopener-why', 'q-hidden-input', 'q-csp-header', 'q-iframe-cost', 'q-sandbox-combination', 'q-defer-vs-async', 'q-preload-auto', 'a11-q1', 'a11-q2', 'a11-q3', 'a11-q4', 'a11-q5', 'a11-q6', 'a11-q7', 'q-validator-order', 'q-validator-limits', 'q-duplicate-id-effect', 'q-elements-panel', 'q-network-404', 'q-one-change', 'q-bisection-steps', 'q-minimal-repro-value', 'q-one-change-at-a-time', 'q-repair-order', 'final-q1', 'final-q2', 'final-q3', 'final-q4', 'final-q5', 'final-q6', 'final-q7', 'final-q8', 'final-q9', 'final-q10', 'final-q11', 'final-q12', 'q-shell-difference', 'q-capstone-media', 'q-review-order', 'q-publishing', 'a-css-1-specificity-order', 'a-css-1-inheritance-loses', 'a-css-1-invalid-silent', 'a-css-1-inline-beats', 'a-css-1-does-not-inherit', 'a-css-1-where-zero', 'a-css-1-tie-break', 'a-css-1-button-inherit', 'q-css-rule-parts', 'q-css-invalid-declaration', 'q-css-where-it-lives', 'q-css-id-vs-classes', 'q-css-source-order', 'q-css-important-cost', 'q-css-what-inherits', 'q-css-inheritance-vs-specificity', 'q-css-button-font', 'q-css-diagnose-order', 'q-css-repair-direction', 'a-css-2-width-default', 'a-css-2-border-box', 'a-css-2-collapse', 'a-css-2-combinator', 'a-css-2-attribute', 'a-css-2-specificity-cost', 'q-css-width-measures', 'q-css-border-box-selector', 'q-css-margin-collapse', 'q-css-child-combinator', 'q-css-where-zero-specificity', 'q-css-focus-visible', 'q-css-padding-vs-margin', 'q-css-border-needs-style');
delete from public.exercises where slug not in ('first-markup-guided', 'first-markup-debug', 'attributes-guided', 'attributes-challenge', 'attributes-debug', 'nesting-guided', 'nesting-debug', 'skeleton-guided', 'skeleton-debug', 'first-page-milestone', 'first-page-mission', 'headings-guided', 'headings-debug', 'paragraphs-guided', 'paragraphs-debug', 'emphasis-guided', 'emphasis-challenge', 'quotes-guided', 'quotes-debug', 'lists-guided', 'entities-debug', 'article-milestone-build', 'article-mission', 'links-guided', 'links-debug', 'paths-guided', 'fragments-challenge', 'paths-debug', 'special-links-guided', 'nav-guided', 'skip-link-challenge', 'nav-debug', 'multipage-milestone-build', 'navigation-mission', 'img-guided', 'img-debug', 'alt-guided', 'figure-challenge', 'srcset-guided', 'srcset-debug', 'picture-guided', 'lazy-challenge', 'video-guided', 'video-debug', 'iframe-guided', 'media-milestone', 'media-mission', 'landmarks-guided', 'section-article-guided', 'section-debug', 'patterns-guided', 'semantic-rebuild', 'semantic-mission', 'table-guided', 'table-debug', 'labels-guided', 'input-types-debug', 'fieldset-guided', 'controls-challenge', 'validation-guided', 'form-milestone', 'form-mission', 'details-guided', 'popover-guided', 'dialog-debug', 'datalist-guided', 'native-milestone', 'native-mission', 'keyboard-debug', 'keyboard-skip-link-guided', 'keyboard-operability-debug', 'accessible-names-challenge', 'accessible-names-debug', 'aria-guided', 'aria-debug', 'aria-state-guided', 'aria-state-debug', 'accessible-form-challenge', 'accessible-form-debug', 'a11y-audit-milestone', 'a11y-mission', 'metadata-guided', 'metadata-debug', 'og-guided', 'jsonld-challenge', 'lang-guided', 'lang-debug', 'seo-milestone-build', 'seo-mission', 'perf-guided', 'security-debug', 'embed-hardening-guided', 'third-party-debug', 'performance-milestone-build', 'performance-mission', 'validation-debug', 'devtools-debug', 'bisection-debug', 'minimal-reproduction-challenge', 'repair-milestone', 'validation-mission', 'shell-guided', 'capstone-main-build', 'final-review-exercise', 'capstone-final-mission', 'css-first-rule-guided', 'css-first-rule-debug', 'css-specificity-guided', 'css-specificity-debug', 'css-inheritance-guided', 'css-inheritance-debug', 'css-cascade-milestone-debug', 'css-border-box-guided', 'css-box-debug', 'css-selectors-guided', 'css-box-milestone-challenge', 'css-box-milestone-debug');
delete from public.lessons where slug not in ('what-happens-when-you-open-a-page', 'tags-elements-attributes', 'nesting-and-the-document-tree', 'doctype-html-head-body', 'your-first-complete-page', 'heading-hierarchy', 'paragraphs-breaks-rules', 'emphasis-and-importance', 'quotes-abbreviations-dates', 'code-entities-and-lists', 'article-milestone', 'anchors-and-link-text', 'relative-and-absolute-paths', 'special-links', 'navigation-menus', 'multi-page-milestone', 'the-img-element', 'writing-alt-text', 'srcset-and-sizes', 'picture-and-formats', 'video-and-audio', 'iframes-and-media-milestone', 'semantic-vs-non-semantic', 'section-article-aside', 'file-organisation-and-patterns', 'semantic-rebuild-milestone', 'building-a-table', 'labels-and-inputs', 'grouping-and-controls', 'validation-and-form-milestone', 'details-and-summary', 'dialog-and-popover', 'progress-meter-datalist-milestone', 'how-assistive-tech-reads-a-page', 'keyboard-and-focus-management', 'accessible-names-in-depth', 'aria-fundamentals', 'aria-live-and-state', 'accessible-forms-in-depth', 'accessibility-audit-milestone', 'titles-descriptions-canonicals', 'social-and-structured-data', 'language-and-internationalisation', 'seo-milestone', 'loading-strategy', 'html-security', 'third-party-and-embeds', 'performance-milestone', 'reading-validation-output', 'developer-tools', 'a-method-for-debugging', 'debugging-milestone', 'assembling-the-site', 'capstone-build', 'final-review', 'css-what-a-rule-is', 'css-specificity', 'css-inheritance', 'css-cascade-milestone', 'css-the-four-layers', 'css-selectors', 'css-box-milestone');
delete from public.assessments where slug not in ('level-1-milestone', 'level-2-milestone', 'level-3-milestone', 'level-4-milestone', 'level-5-milestone', 'level-6-milestone', 'level-7-milestone', 'level-8-milestone', 'level-9-milestone', 'level-10-milestone', 'level-11-milestone', 'html-hero-final', 'css-level-1-milestone', 'css-level-2-milestone');
delete from public.modules where slug not in ('how-the-web-works', 'the-html-skeleton', 'headings-and-paragraphs', 'text-level-semantics', 'links-and-paths', 'site-navigation', 'images-and-alt-text', 'responsive-images', 'video-audio-embeds', 'semantic-landmarks', 'organising-a-project', 'data-tables', 'form-foundations', 'disclosure-and-dialog', 'accessibility-foundations', 'aria-and-accessible-forms', 'page-metadata', 'html-performance', 'validation-and-tools', 'completing-the-site', 'review-and-publish', 'css-first-rules', 'css-boxes');
delete from public.levels where slug not in ('html-explorer', 'content-builder', 'navigation-architect', 'media-specialist', 'structure-professional', 'data-and-forms', 'native-interaction', 'accessibility-champion', 'metadata-and-seo', 'performance-and-security', 'debugging-and-validation', 'html-hero-capstone', 'css-cascade', 'css-box-model');
-- --------------------------------------------------------------------------
-- Reviewable items (spaced repetition)
-- --------------------------------------------------------------------------

insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-what-is-html', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'document-structure'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'what-happens-when-you-open-a-page' and qq.slug = 'q-what-is-html'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-html-purpose', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'document-structure'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'what-happens-when-you-open-a-page' and qq.slug = 'q-html-purpose'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-first-markup-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'syntax'),
       l.id, e.id, 1
from public.lessons l, public.exercises e
where l.slug = 'what-happens-when-you-open-a-page' and e.slug = 'first-markup-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-first-markup-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'syntax'),
       l.id, e.id, 1
from public.lessons l, public.exercises e
where l.slug = 'what-happens-when-you-open-a-page' and e.slug = 'first-markup-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-tag-vs-element', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'syntax'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'tags-elements-attributes' and qq.slug = 'q-tag-vs-element'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-attribute-syntax', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'syntax'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'tags-elements-attributes' and qq.slug = 'q-attribute-syntax'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-void-elements', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'syntax'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'tags-elements-attributes' and qq.slug = 'q-void-elements'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-attributes-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'syntax'),
       l.id, e.id, 1
from public.lessons l, public.exercises e
where l.slug = 'tags-elements-attributes' and e.slug = 'attributes-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-attributes-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'syntax'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'tags-elements-attributes' and e.slug = 'attributes-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-attributes-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'validation'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'tags-elements-attributes' and e.slug = 'attributes-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-nesting-order', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'syntax'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'nesting-and-the-document-tree' and qq.slug = 'q-nesting-order'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-dom-meaning', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'syntax'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'nesting-and-the-document-tree' and qq.slug = 'q-dom-meaning'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-comments', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'syntax'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'nesting-and-the-document-tree' and qq.slug = 'q-comments'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-nesting-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'syntax'),
       l.id, e.id, 1
from public.lessons l, public.exercises e
where l.slug = 'nesting-and-the-document-tree' and e.slug = 'nesting-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-nesting-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'validation'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'nesting-and-the-document-tree' and e.slug = 'nesting-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-doctype-purpose', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'document-structure'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'doctype-html-head-body' and qq.slug = 'q-doctype-purpose'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-head-vs-body', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'document-structure'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'doctype-html-head-body' and qq.slug = 'q-head-vs-body'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-viewport', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'document-structure'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'doctype-html-head-body' and qq.slug = 'q-viewport'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-charset', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'metadata'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'doctype-html-head-body' and qq.slug = 'q-charset'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-skeleton-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'document-structure'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'doctype-html-head-body' and e.slug = 'skeleton-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-skeleton-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'document-structure'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'doctype-html-head-body' and e.slug = 'skeleton-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-index-html', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'multi-page'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'your-first-complete-page' and qq.slug = 'q-index-html'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-one-h1', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'your-first-complete-page' and qq.slug = 'q-one-h1'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-first-page-milestone', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'document-structure'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'your-first-complete-page' and e.slug = 'first-page-milestone'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-heading-skip', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'heading-hierarchy' and qq.slug = 'q-heading-skip'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-heading-purpose', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'heading-hierarchy' and qq.slug = 'q-heading-purpose'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-headings-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'heading-hierarchy' and e.slug = 'headings-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-headings-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'heading-hierarchy' and e.slug = 'headings-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-whitespace', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'paragraphs-breaks-rules' and qq.slug = 'q-whitespace'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-br-use', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'paragraphs-breaks-rules' and qq.slug = 'q-br-use'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-hr-meaning', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'paragraphs-breaks-rules' and qq.slug = 'q-hr-meaning'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-paragraphs-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'paragraphs-breaks-rules' and e.slug = 'paragraphs-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-paragraphs-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'paragraphs-breaks-rules' and e.slug = 'paragraphs-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-strong-vs-em', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'emphasis-and-importance' and qq.slug = 'q-strong-vs-em'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-small-meaning', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'emphasis-and-importance' and qq.slug = 'q-small-meaning'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-emphasis-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'emphasis-and-importance' and e.slug = 'emphasis-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-emphasis-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'emphasis-and-importance' and e.slug = 'emphasis-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-cite-meaning', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'quotes-abbreviations-dates' and qq.slug = 'q-cite-meaning'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-datetime-format', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'quotes-abbreviations-dates' and qq.slug = 'q-datetime-format'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-q-quotes', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'quotes-abbreviations-dates' and qq.slug = 'q-q-quotes'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-quotes-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'quotes-abbreviations-dates' and e.slug = 'quotes-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-quotes-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'quotes-abbreviations-dates' and e.slug = 'quotes-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-entity-lt', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'code-entities-and-lists' and qq.slug = 'q-entity-lt'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-list-choice', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'lists'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'code-entities-and-lists' and qq.slug = 'q-list-choice'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-nested-list', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'lists'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'code-entities-and-lists' and qq.slug = 'q-nested-list'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-lists-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'lists'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'code-entities-and-lists' and e.slug = 'lists-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-entities-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'validation'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'code-entities-and-lists' and e.slug = 'entities-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-semantic-choice', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'article-milestone' and qq.slug = 'q-semantic-choice'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-article-milestone-build', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'text-semantics'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'article-milestone' and e.slug = 'article-milestone-build'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-link-text', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'anchors-and-link-text' and qq.slug = 'q-link-text'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-noopener', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'security'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'anchors-and-link-text' and qq.slug = 'q-noopener'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-links-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'links'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'anchors-and-link-text' and e.slug = 'links-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-links-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'links'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'anchors-and-link-text' and e.slug = 'links-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-dotdot', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'links'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'relative-and-absolute-paths' and qq.slug = 'q-dotdot'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-leading-slash', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'links'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'relative-and-absolute-paths' and qq.slug = 'q-leading-slash'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-fragment-case', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'links'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'relative-and-absolute-paths' and qq.slug = 'q-fragment-case'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-paths-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'links'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'relative-and-absolute-paths' and e.slug = 'paths-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-fragments-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'links'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'relative-and-absolute-paths' and e.slug = 'fragments-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-paths-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'links'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'relative-and-absolute-paths' and e.slug = 'paths-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-tel-format', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'links'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'special-links' and qq.slug = 'q-tel-format'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-download-attr', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'links'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'special-links' and qq.slug = 'q-download-attr'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-special-links-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'links'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'special-links' and e.slug = 'special-links-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-nav-list', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'navigation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'navigation-menus' and qq.slug = 'q-nav-list'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-skip-link-position', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'navigation-menus' and qq.slug = 'q-skip-link-position'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-aria-current', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'navigation-menus' and qq.slug = 'q-aria-current'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-nav-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'navigation'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'navigation-menus' and e.slug = 'nav-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-skip-link-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'navigation'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'navigation-menus' and e.slug = 'skip-link-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-nav-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'navigation'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'navigation-menus' and e.slug = 'nav-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-filenames', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'multi-page'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'multi-page-milestone' and qq.slug = 'q-filenames'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-nav-consistency', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'navigation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'multi-page-milestone' and qq.slug = 'q-nav-consistency'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-multipage-milestone-build', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'multi-page'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'multi-page-milestone' and e.slug = 'multipage-milestone-build'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-img-dimensions', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'images'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'the-img-element' and qq.slug = 'q-img-dimensions'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-hotlinking', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'images'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'the-img-element' and qq.slug = 'q-hotlinking'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-img-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'images'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'the-img-element' and e.slug = 'img-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-img-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'images'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'the-img-element' and e.slug = 'img-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-empty-alt', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'images'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'writing-alt-text' and qq.slug = 'q-empty-alt'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-alt-vs-caption', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'images'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'writing-alt-text' and qq.slug = 'q-alt-vs-caption'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-missing-alt', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'writing-alt-text' and qq.slug = 'q-missing-alt'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-alt-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'images'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'writing-alt-text' and e.slug = 'alt-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-figure-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'images'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'writing-alt-text' and e.slug = 'figure-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-srcset-w', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive-images'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'srcset-and-sizes' and qq.slug = 'q-srcset-w'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-sizes-purpose', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive-images'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'srcset-and-sizes' and qq.slug = 'q-sizes-purpose'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-srcset-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive-images'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'srcset-and-sizes' and e.slug = 'srcset-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-srcset-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive-images'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'srcset-and-sizes' and e.slug = 'srcset-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-picture-img', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive-images'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'picture-and-formats' and qq.slug = 'q-picture-img'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-lazy-hero', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'performance'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'picture-and-formats' and qq.slug = 'q-lazy-hero'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-picture-vs-srcset', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive-images'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'picture-and-formats' and qq.slug = 'q-picture-vs-srcset'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-picture-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive-images'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'picture-and-formats' and e.slug = 'picture-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-lazy-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'performance'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'picture-and-formats' and e.slug = 'lazy-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-video-controls', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'audio-video'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'video-and-audio' and qq.slug = 'q-video-controls'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-track-kind', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'audio-video'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'video-and-audio' and qq.slug = 'q-track-kind'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-fallback-placement', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'audio-video'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'video-and-audio' and qq.slug = 'q-fallback-placement'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-video-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'audio-video'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'video-and-audio' and e.slug = 'video-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-video-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'audio-video'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'video-and-audio' and e.slug = 'video-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-iframe-title', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'iframes-and-media-milestone' and qq.slug = 'q-iframe-title'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-sandbox', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'security'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'iframes-and-media-milestone' and qq.slug = 'q-sandbox'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-iframe-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'embedded-content'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'iframes-and-media-milestone' and e.slug = 'iframe-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-media-milestone', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'audio-video'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'iframes-and-media-milestone' and e.slug = 'media-milestone'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-semantic-meaning', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'semantic-html'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'semantic-vs-non-semantic' and qq.slug = 'q-semantic-meaning'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-main-count', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'semantic-html'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'semantic-vs-non-semantic' and qq.slug = 'q-main-count'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-landmarks-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'semantic-html'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'semantic-vs-non-semantic' and e.slug = 'landmarks-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-article-test', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'semantic-html'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'section-article-aside' and qq.slug = 'q-article-test'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-section-heading', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'semantic-html'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'section-article-aside' and qq.slug = 'q-section-heading'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-outline-algorithm', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'semantic-html'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'section-article-aside' and qq.slug = 'q-outline-algorithm'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-section-article-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'semantic-html'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'section-article-aside' and e.slug = 'section-article-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-section-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'semantic-html'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'section-article-aside' and e.slug = 'section-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-case-sensitivity', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'multi-page'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'file-organisation-and-patterns' and qq.slug = 'q-case-sensitivity'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-comments-value', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'maintainability'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'file-organisation-and-patterns' and qq.slug = 'q-comments-value'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-patterns-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'maintainability'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'file-organisation-and-patterns' and e.slug = 'patterns-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-footer-placement', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'semantic-html'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'semantic-rebuild-milestone' and qq.slug = 'q-footer-placement'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-semantic-rebuild', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'semantic-html'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'semantic-rebuild-milestone' and e.slug = 'semantic-rebuild'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-scope-col', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'tables'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'building-a-table' and qq.slug = 'q-scope-col'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-caption-position', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'tables'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'building-a-table' and qq.slug = 'q-caption-position'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-layout-tables', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'tables'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'building-a-table' and qq.slug = 'q-layout-tables'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-table-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'tables'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'building-a-table' and e.slug = 'table-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-table-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'tables'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'building-a-table' and e.slug = 'table-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-label-for', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'forms'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'labels-and-inputs' and qq.slug = 'q-label-for'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-placeholder', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'labels-and-inputs' and qq.slug = 'q-placeholder'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-number-type', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'forms'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'labels-and-inputs' and qq.slug = 'q-number-type'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-name-attribute', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'forms'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'labels-and-inputs' and qq.slug = 'q-name-attribute'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-labels-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'forms'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'labels-and-inputs' and e.slug = 'labels-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-input-types-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'forms'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'labels-and-inputs' and e.slug = 'input-types-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-radio-group', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'forms'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'grouping-and-controls' and qq.slug = 'q-radio-group'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-button-type', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'forms'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'grouping-and-controls' and qq.slug = 'q-button-type'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-legend-position', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'forms'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'grouping-and-controls' and qq.slug = 'q-legend-position'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-fieldset-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'forms'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'grouping-and-controls' and e.slug = 'fieldset-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-controls-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'forms'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'grouping-and-controls' and e.slug = 'controls-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-client-validation', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'security'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'validation-and-form-milestone' and qq.slug = 'q-client-validation'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-get-vs-post', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'security'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'validation-and-form-milestone' and qq.slug = 'q-get-vs-post'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-aria-describedby', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'aria'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'validation-and-form-milestone' and qq.slug = 'q-aria-describedby'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-validation-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'forms'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'validation-and-form-milestone' and e.slug = 'validation-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-form-milestone', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'forms'),
       l.id, e.id, 5
from public.lessons l, public.exercises e
where l.slug = 'validation-and-form-milestone' and e.slug = 'form-milestone'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-summary-position', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'native-interaction'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'details-and-summary' and qq.slug = 'q-summary-position'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-details-name', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'native-interaction'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'details-and-summary' and qq.slug = 'q-details-name'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-details-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'native-interaction'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'details-and-summary' and e.slug = 'details-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-dialog-close', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'native-interaction'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'dialog-and-popover' and qq.slug = 'q-dialog-close'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-popover-js', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'native-interaction'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'dialog-and-popover' and qq.slug = 'q-popover-js'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-modal-content', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'progressive-enhancement'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'dialog-and-popover' and qq.slug = 'q-modal-content'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-popover-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'native-interaction'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'dialog-and-popover' and e.slug = 'popover-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-dialog-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'native-interaction'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'dialog-and-popover' and e.slug = 'dialog-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-progress-vs-meter', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'native-interaction'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'progress-meter-datalist-milestone' and qq.slug = 'q-progress-vs-meter'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-datalist-restrict', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'native-interaction'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'progress-meter-datalist-milestone' and qq.slug = 'q-datalist-restrict'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-datalist-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'native-interaction'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'progress-meter-datalist-milestone' and e.slug = 'datalist-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-native-milestone', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'native-interaction'),
       l.id, e.id, 5
from public.lessons l, public.exercises e
where l.slug = 'progress-meter-datalist-milestone' and e.slug = 'native-milestone'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-a11y-tree', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'how-assistive-tech-reads-a-page' and qq.slug = 'q-a11y-tree'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-keyboard-test', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'how-assistive-tech-reads-a-page' and qq.slug = 'q-keyboard-test'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-div-button', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'how-assistive-tech-reads-a-page' and qq.slug = 'q-div-button'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-keyboard-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'how-assistive-tech-reads-a-page' and e.slug = 'keyboard-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-focusable-defaults', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'keyboard-and-focus-management' and qq.slug = 'q-focusable-defaults'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-tabindex-negative', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'keyboard-and-focus-management' and qq.slug = 'q-tabindex-negative'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-positive-tabindex', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'keyboard-and-focus-management' and qq.slug = 'q-positive-tabindex'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-keyboard-skip-link-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'keyboard-and-focus-management' and e.slug = 'keyboard-skip-link-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-keyboard-operability-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'keyboard-and-focus-management' and e.slug = 'keyboard-operability-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-name-order', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'accessible-names-in-depth' and qq.slug = 'q-name-order'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-alt-empty-vs-missing', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'accessible-names-in-depth' and qq.slug = 'q-alt-empty-vs-missing'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-link-text-alone', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'accessible-names-in-depth' and qq.slug = 'q-link-text-alone'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-accessible-names-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'accessible-names-in-depth' and e.slug = 'accessible-names-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-accessible-names-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'accessible-names-in-depth' and e.slug = 'accessible-names-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-aria-first-rule', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'aria'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'aria-fundamentals' and qq.slug = 'q-aria-first-rule'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-aria-behaviour', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'aria'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'aria-fundamentals' and qq.slug = 'q-aria-behaviour'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-labelledby-vs-label', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'aria'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'aria-fundamentals' and qq.slug = 'q-labelledby-vs-label'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-aria-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'aria'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'aria-fundamentals' and e.slug = 'aria-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-aria-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'aria'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'aria-fundamentals' and e.slug = 'aria-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-aria-current-page', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'aria'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'aria-live-and-state' and qq.slug = 'q-aria-current-page'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-live-region-timing', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'aria'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'aria-live-and-state' and qq.slug = 'q-live-region-timing'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-assertive-vs-polite', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'aria'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'aria-live-and-state' and qq.slug = 'q-assertive-vs-polite'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-aria-state-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'aria'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'aria-live-and-state' and e.slug = 'aria-state-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-aria-state-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'aria'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'aria-live-and-state' and e.slug = 'aria-state-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-placeholder-not-label', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'accessible-forms-in-depth' and qq.slug = 'q-placeholder-not-label'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-fieldset-legend', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'accessible-forms-in-depth' and qq.slug = 'q-fieldset-legend'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-autocomplete-requirement', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'accessible-forms-in-depth' and qq.slug = 'q-autocomplete-requirement'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-accessible-form-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'accessible-forms-in-depth' and e.slug = 'accessible-form-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-accessible-form-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'accessible-forms-in-depth' and e.slug = 'accessible-form-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-audit-order', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'accessibility-audit-milestone' and qq.slug = 'q-audit-order'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-duplicate-id-impact', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'validation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'accessibility-audit-milestone' and qq.slug = 'q-duplicate-id-impact'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-a11y-audit-milestone', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'accessibility'),
       l.id, e.id, 5
from public.lessons l, public.exercises e
where l.slug = 'accessibility-audit-milestone' and e.slug = 'a11y-audit-milestone'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-title-length', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'seo'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'titles-descriptions-canonicals' and qq.slug = 'q-title-length'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-canonical', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'seo'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'titles-descriptions-canonicals' and qq.slug = 'q-canonical'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-noindex-security', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'security'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'titles-descriptions-canonicals' and qq.slug = 'q-noindex-security'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-metadata-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'metadata'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'titles-descriptions-canonicals' and e.slug = 'metadata-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-metadata-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'metadata'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'titles-descriptions-canonicals' and e.slug = 'metadata-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-og-property', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'seo'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'social-and-structured-data' and qq.slug = 'q-og-property'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-structured-data-ranking', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'structured-data'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'social-and-structured-data' and qq.slug = 'q-structured-data-ranking'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-og-image-url', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'seo'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'social-and-structured-data' and qq.slug = 'q-og-image-url'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-og-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'seo'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'social-and-structured-data' and e.slug = 'og-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-jsonld-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'structured-data'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'social-and-structured-data' and e.slug = 'jsonld-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-lang-missing-effect', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'metadata'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'language-and-internationalisation' and qq.slug = 'q-lang-missing-effect'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-wrong-lang-worse', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'metadata'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'language-and-internationalisation' and qq.slug = 'q-wrong-lang-worse'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-dir-auto', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'metadata'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'language-and-internationalisation' and qq.slug = 'q-dir-auto'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-lang-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'metadata'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'language-and-internationalisation' and e.slug = 'lang-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-lang-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'metadata'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'language-and-internationalisation' and e.slug = 'lang-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-metadata-order', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'metadata'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'seo-milestone' and qq.slug = 'q-metadata-order'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-seo-milestone-build', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'seo'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'seo-milestone' and e.slug = 'seo-milestone-build'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-layout-shift', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'performance'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'loading-strategy' and qq.slug = 'q-layout-shift'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-defer-async', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'performance'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'loading-strategy' and qq.slug = 'q-defer-async'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-preload-overuse', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'performance'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'loading-strategy' and qq.slug = 'q-preload-overuse'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-perf-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'performance'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'loading-strategy' and e.slug = 'perf-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-noopener-why', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'security'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'html-security' and qq.slug = 'q-noopener-why'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-hidden-input', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'security'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'html-security' and qq.slug = 'q-hidden-input'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-csp-header', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'security'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'html-security' and qq.slug = 'q-csp-header'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-security-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'security'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'html-security' and e.slug = 'security-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-iframe-cost', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'performance'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'third-party-and-embeds' and qq.slug = 'q-iframe-cost'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-sandbox-combination', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'security'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'third-party-and-embeds' and qq.slug = 'q-sandbox-combination'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-defer-vs-async', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'performance'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'third-party-and-embeds' and qq.slug = 'q-defer-vs-async'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-embed-hardening-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'performance'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'third-party-and-embeds' and e.slug = 'embed-hardening-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-third-party-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'performance'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'third-party-and-embeds' and e.slug = 'third-party-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-preload-auto', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'performance'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'performance-milestone' and qq.slug = 'q-preload-auto'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-performance-milestone-build', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'performance'),
       l.id, e.id, 5
from public.lessons l, public.exercises e
where l.slug = 'performance-milestone' and e.slug = 'performance-milestone-build'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-validator-order', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'validation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'reading-validation-output' and qq.slug = 'q-validator-order'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-validator-limits', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'validation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'reading-validation-output' and qq.slug = 'q-validator-limits'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-duplicate-id-effect', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'validation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'reading-validation-output' and qq.slug = 'q-duplicate-id-effect'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-validation-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'validation'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'reading-validation-output' and e.slug = 'validation-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-elements-panel', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'developer-tools' and qq.slug = 'q-elements-panel'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-network-404', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'developer-tools' and qq.slug = 'q-network-404'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-one-change', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'developer-tools' and qq.slug = 'q-one-change'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-devtools-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'debugging'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'developer-tools' and e.slug = 'devtools-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-bisection-steps', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'a-method-for-debugging' and qq.slug = 'q-bisection-steps'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-minimal-repro-value', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'a-method-for-debugging' and qq.slug = 'q-minimal-repro-value'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-one-change-at-a-time', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'a-method-for-debugging' and qq.slug = 'q-one-change-at-a-time'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-bisection-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'debugging'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'a-method-for-debugging' and e.slug = 'bisection-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-minimal-reproduction-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'debugging'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'a-method-for-debugging' and e.slug = 'minimal-reproduction-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-repair-order', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'debugging-milestone' and qq.slug = 'q-repair-order'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-repair-milestone', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'debugging'),
       l.id, e.id, 5
from public.lessons l, public.exercises e
where l.slug = 'debugging-milestone' and e.slug = 'repair-milestone'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-shell-difference', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'multi-page'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'assembling-the-site' and qq.slug = 'q-shell-difference'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-shell-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'multi-page'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'assembling-the-site' and e.slug = 'shell-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-capstone-media', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'images'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'capstone-build' and qq.slug = 'q-capstone-media'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-capstone-main-build', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'multi-page'),
       l.id, e.id, 5
from public.lessons l, public.exercises e
where l.slug = 'capstone-build' and e.slug = 'capstone-main-build'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-review-order', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'validation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'final-review' and qq.slug = 'q-review-order'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-publishing', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'multi-page'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'final-review' and qq.slug = 'q-publishing'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-final-review-exercise', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'debugging'),
       l.id, e.id, 5
from public.lessons l, public.exercises e
where l.slug = 'final-review' and e.slug = 'final-review-exercise'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-rule-parts', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-what-a-rule-is' and qq.slug = 'q-css-rule-parts'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-invalid-declaration', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-what-a-rule-is' and qq.slug = 'q-css-invalid-declaration'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-where-it-lives', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-what-a-rule-is' and qq.slug = 'q-css-where-it-lives'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-first-rule-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, e.id, 1
from public.lessons l, public.exercises e
where l.slug = 'css-what-a-rule-is' and e.slug = 'css-first-rule-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-first-rule-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'css-what-a-rule-is' and e.slug = 'css-first-rule-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-id-vs-classes', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-specificity' and qq.slug = 'q-css-id-vs-classes'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-source-order', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-specificity' and qq.slug = 'q-css-source-order'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-important-cost', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-specificity' and qq.slug = 'q-css-important-cost'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-specificity-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'css-specificity' and e.slug = 'css-specificity-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-specificity-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-specificity' and e.slug = 'css-specificity-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-what-inherits', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-inheritance' and qq.slug = 'q-css-what-inherits'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-inheritance-vs-specificity', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-inheritance' and qq.slug = 'q-css-inheritance-vs-specificity'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-button-font', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-inheritance' and qq.slug = 'q-css-button-font'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-inheritance-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'css-inheritance' and e.slug = 'css-inheritance-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-inheritance-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-inheritance' and e.slug = 'css-inheritance-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-diagnose-order', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-cascade-milestone' and qq.slug = 'q-css-diagnose-order'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-repair-direction', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-cascade-milestone' and qq.slug = 'q-css-repair-direction'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-cascade-milestone-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'cascade'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-cascade-milestone' and e.slug = 'css-cascade-milestone-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-width-measures', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'box-model'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-the-four-layers' and qq.slug = 'q-css-width-measures'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-border-box-selector', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'box-model'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-the-four-layers' and qq.slug = 'q-css-border-box-selector'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-margin-collapse', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'box-model'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-the-four-layers' and qq.slug = 'q-css-margin-collapse'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-border-box-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'box-model'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'css-the-four-layers' and e.slug = 'css-border-box-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-box-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'box-model'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-the-four-layers' and e.slug = 'css-box-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-child-combinator', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'selectors'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-selectors' and qq.slug = 'q-css-child-combinator'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-where-zero-specificity', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'selectors'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-selectors' and qq.slug = 'q-css-where-zero-specificity'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-focus-visible', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'selectors'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-selectors' and qq.slug = 'q-css-focus-visible'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-selectors-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'selectors'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-selectors' and e.slug = 'css-selectors-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-padding-vs-margin', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'box-model'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-box-milestone' and qq.slug = 'q-css-padding-vs-margin'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-border-needs-style', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'box-model'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-box-milestone' and qq.slug = 'q-css-border-needs-style'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-box-milestone-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'box-model'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-box-milestone' and e.slug = 'css-box-milestone-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-box-milestone-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'box-model'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-box-milestone' and e.slug = 'css-box-milestone-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
-- Items whose question or exercise has left the curriculum.
delete from public.review_items where slug not in ('rv-q-q-what-is-html', 'rv-q-q-html-purpose', 'rv-e-first-markup-guided', 'rv-e-first-markup-debug', 'rv-q-q-tag-vs-element', 'rv-q-q-attribute-syntax', 'rv-q-q-void-elements', 'rv-e-attributes-guided', 'rv-e-attributes-challenge', 'rv-e-attributes-debug', 'rv-q-q-nesting-order', 'rv-q-q-dom-meaning', 'rv-q-q-comments', 'rv-e-nesting-guided', 'rv-e-nesting-debug', 'rv-q-q-doctype-purpose', 'rv-q-q-head-vs-body', 'rv-q-q-viewport', 'rv-q-q-charset', 'rv-e-skeleton-guided', 'rv-e-skeleton-debug', 'rv-q-q-index-html', 'rv-q-q-one-h1', 'rv-e-first-page-milestone', 'rv-q-q-heading-skip', 'rv-q-q-heading-purpose', 'rv-e-headings-guided', 'rv-e-headings-debug', 'rv-q-q-whitespace', 'rv-q-q-br-use', 'rv-q-q-hr-meaning', 'rv-e-paragraphs-guided', 'rv-e-paragraphs-debug', 'rv-q-q-strong-vs-em', 'rv-q-q-small-meaning', 'rv-e-emphasis-guided', 'rv-e-emphasis-challenge', 'rv-q-q-cite-meaning', 'rv-q-q-datetime-format', 'rv-q-q-q-quotes', 'rv-e-quotes-guided', 'rv-e-quotes-debug', 'rv-q-q-entity-lt', 'rv-q-q-list-choice', 'rv-q-q-nested-list', 'rv-e-lists-guided', 'rv-e-entities-debug', 'rv-q-q-semantic-choice', 'rv-e-article-milestone-build', 'rv-q-q-link-text', 'rv-q-q-noopener', 'rv-e-links-guided', 'rv-e-links-debug', 'rv-q-q-dotdot', 'rv-q-q-leading-slash', 'rv-q-q-fragment-case', 'rv-e-paths-guided', 'rv-e-fragments-challenge', 'rv-e-paths-debug', 'rv-q-q-tel-format', 'rv-q-q-download-attr', 'rv-e-special-links-guided', 'rv-q-q-nav-list', 'rv-q-q-skip-link-position', 'rv-q-q-aria-current', 'rv-e-nav-guided', 'rv-e-skip-link-challenge', 'rv-e-nav-debug', 'rv-q-q-filenames', 'rv-q-q-nav-consistency', 'rv-e-multipage-milestone-build', 'rv-q-q-img-dimensions', 'rv-q-q-hotlinking', 'rv-e-img-guided', 'rv-e-img-debug', 'rv-q-q-empty-alt', 'rv-q-q-alt-vs-caption', 'rv-q-q-missing-alt', 'rv-e-alt-guided', 'rv-e-figure-challenge', 'rv-q-q-srcset-w', 'rv-q-q-sizes-purpose', 'rv-e-srcset-guided', 'rv-e-srcset-debug', 'rv-q-q-picture-img', 'rv-q-q-lazy-hero', 'rv-q-q-picture-vs-srcset', 'rv-e-picture-guided', 'rv-e-lazy-challenge', 'rv-q-q-video-controls', 'rv-q-q-track-kind', 'rv-q-q-fallback-placement', 'rv-e-video-guided', 'rv-e-video-debug', 'rv-q-q-iframe-title', 'rv-q-q-sandbox', 'rv-e-iframe-guided', 'rv-e-media-milestone', 'rv-q-q-semantic-meaning', 'rv-q-q-main-count', 'rv-e-landmarks-guided', 'rv-q-q-article-test', 'rv-q-q-section-heading', 'rv-q-q-outline-algorithm', 'rv-e-section-article-guided', 'rv-e-section-debug', 'rv-q-q-case-sensitivity', 'rv-q-q-comments-value', 'rv-e-patterns-guided', 'rv-q-q-footer-placement', 'rv-e-semantic-rebuild', 'rv-q-q-scope-col', 'rv-q-q-caption-position', 'rv-q-q-layout-tables', 'rv-e-table-guided', 'rv-e-table-debug', 'rv-q-q-label-for', 'rv-q-q-placeholder', 'rv-q-q-number-type', 'rv-q-q-name-attribute', 'rv-e-labels-guided', 'rv-e-input-types-debug', 'rv-q-q-radio-group', 'rv-q-q-button-type', 'rv-q-q-legend-position', 'rv-e-fieldset-guided', 'rv-e-controls-challenge', 'rv-q-q-client-validation', 'rv-q-q-get-vs-post', 'rv-q-q-aria-describedby', 'rv-e-validation-guided', 'rv-e-form-milestone', 'rv-q-q-summary-position', 'rv-q-q-details-name', 'rv-e-details-guided', 'rv-q-q-dialog-close', 'rv-q-q-popover-js', 'rv-q-q-modal-content', 'rv-e-popover-guided', 'rv-e-dialog-debug', 'rv-q-q-progress-vs-meter', 'rv-q-q-datalist-restrict', 'rv-e-datalist-guided', 'rv-e-native-milestone', 'rv-q-q-a11y-tree', 'rv-q-q-keyboard-test', 'rv-q-q-div-button', 'rv-e-keyboard-debug', 'rv-q-q-focusable-defaults', 'rv-q-q-tabindex-negative', 'rv-q-q-positive-tabindex', 'rv-e-keyboard-skip-link-guided', 'rv-e-keyboard-operability-debug', 'rv-q-q-name-order', 'rv-q-q-alt-empty-vs-missing', 'rv-q-q-link-text-alone', 'rv-e-accessible-names-challenge', 'rv-e-accessible-names-debug', 'rv-q-q-aria-first-rule', 'rv-q-q-aria-behaviour', 'rv-q-q-labelledby-vs-label', 'rv-e-aria-guided', 'rv-e-aria-debug', 'rv-q-q-aria-current-page', 'rv-q-q-live-region-timing', 'rv-q-q-assertive-vs-polite', 'rv-e-aria-state-guided', 'rv-e-aria-state-debug', 'rv-q-q-placeholder-not-label', 'rv-q-q-fieldset-legend', 'rv-q-q-autocomplete-requirement', 'rv-e-accessible-form-challenge', 'rv-e-accessible-form-debug', 'rv-q-q-audit-order', 'rv-q-q-duplicate-id-impact', 'rv-e-a11y-audit-milestone', 'rv-q-q-title-length', 'rv-q-q-canonical', 'rv-q-q-noindex-security', 'rv-e-metadata-guided', 'rv-e-metadata-debug', 'rv-q-q-og-property', 'rv-q-q-structured-data-ranking', 'rv-q-q-og-image-url', 'rv-e-og-guided', 'rv-e-jsonld-challenge', 'rv-q-q-lang-missing-effect', 'rv-q-q-wrong-lang-worse', 'rv-q-q-dir-auto', 'rv-e-lang-guided', 'rv-e-lang-debug', 'rv-q-q-metadata-order', 'rv-e-seo-milestone-build', 'rv-q-q-layout-shift', 'rv-q-q-defer-async', 'rv-q-q-preload-overuse', 'rv-e-perf-guided', 'rv-q-q-noopener-why', 'rv-q-q-hidden-input', 'rv-q-q-csp-header', 'rv-e-security-debug', 'rv-q-q-iframe-cost', 'rv-q-q-sandbox-combination', 'rv-q-q-defer-vs-async', 'rv-e-embed-hardening-guided', 'rv-e-third-party-debug', 'rv-q-q-preload-auto', 'rv-e-performance-milestone-build', 'rv-q-q-validator-order', 'rv-q-q-validator-limits', 'rv-q-q-duplicate-id-effect', 'rv-e-validation-debug', 'rv-q-q-elements-panel', 'rv-q-q-network-404', 'rv-q-q-one-change', 'rv-e-devtools-debug', 'rv-q-q-bisection-steps', 'rv-q-q-minimal-repro-value', 'rv-q-q-one-change-at-a-time', 'rv-e-bisection-debug', 'rv-e-minimal-reproduction-challenge', 'rv-q-q-repair-order', 'rv-e-repair-milestone', 'rv-q-q-shell-difference', 'rv-e-shell-guided', 'rv-q-q-capstone-media', 'rv-e-capstone-main-build', 'rv-q-q-review-order', 'rv-q-q-publishing', 'rv-e-final-review-exercise', 'rv-q-q-css-rule-parts', 'rv-q-q-css-invalid-declaration', 'rv-q-q-css-where-it-lives', 'rv-e-css-first-rule-guided', 'rv-e-css-first-rule-debug', 'rv-q-q-css-id-vs-classes', 'rv-q-q-css-source-order', 'rv-q-q-css-important-cost', 'rv-e-css-specificity-guided', 'rv-e-css-specificity-debug', 'rv-q-q-css-what-inherits', 'rv-q-q-css-inheritance-vs-specificity', 'rv-q-q-css-button-font', 'rv-e-css-inheritance-guided', 'rv-e-css-inheritance-debug', 'rv-q-q-css-diagnose-order', 'rv-q-q-css-repair-direction', 'rv-e-css-cascade-milestone-debug', 'rv-q-q-css-width-measures', 'rv-q-q-css-border-box-selector', 'rv-q-q-css-margin-collapse', 'rv-e-css-border-box-guided', 'rv-e-css-box-debug', 'rv-q-q-css-child-combinator', 'rv-q-q-css-where-zero-specificity', 'rv-q-q-css-focus-visible', 'rv-e-css-selectors-guided', 'rv-q-q-css-padding-vs-margin', 'rv-q-q-css-border-needs-style', 'rv-e-css-box-milestone-challenge', 'rv-e-css-box-milestone-debug');

commit;
