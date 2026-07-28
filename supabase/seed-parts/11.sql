-- HTML Hero — course seed, part 11 of 16
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
-- CSS Architect — Level 3: Flow, Position and Stacking
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'css-flow-and-position', 3, 'Flow, Position and Stacking', 'The layout you get for free, and the four ways of leaving it',
       'Before any layout system, there is normal flow. Understanding it — and what `position` and stacking contexts really do — is what stops later layouts feeling like guesswork.', 'You can predict where an element will sit, and say which of two overlapping elements appears in front and why.', 'violet'
from public.courses c where c.slug = 'css-architect'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'css-level-3-milestone', 'milestone'::public.assessment_kind, 'Level 3 milestone: Flow, Position and Stacking', 'Six questions on normal flow, positioning and stacking. Pass mark 75%.',
       0.75, 180, 3
from public.levels l where l.slug = 'css-flow-and-position'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Normal flow and positioning
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'css-flow', 1, 'Normal flow and positioning', 'Block and inline, the display property, the four positioning schemes, and the stacking rules that decide what covers what.',
       55, false
from public.levels l where l.slug = 'css-flow-and-position'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'css-flow' and p.slug = 'css-boxes';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'css-flow' and s.slug = 'layout-flow';
-- lesson: Normal flow
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-normal-flow', 1, 'Normal flow', 'Block, inline, and the layout you already have', 'Every page starts with a layout you did not write. Knowing its rules explains most of what looks like strange behaviour later.',
       ARRAY['Explain the difference between block and inline layout', 'Predict which properties an inline element ignores', 'Choose a display value deliberately']::text[], 15, 40, (select id from public.skills where slug = 'layout-flow'), 0.7
from public.modules m where m.slug = 'css-flow'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'You give a `<span>` a `width` of 300px and 40px of top padding. What actually happens?',
       NULL, NULL, NULL, '{"options":["The width is ignored, and the padding overlaps the lines above and below","Both apply exactly as written","Both are ignored entirely","The width applies but the padding does not"],"answer":"The width is ignored and the vertical padding is drawn but does not push anything away — so it overlaps neighbouring lines. Inline elements are sized by their content, and vertical margins and padding on them do not affect line height. This is the commonest reason a `<span>` \"refuses\" to be sized, and the fix is almost always `display: inline-block` or using a block element in the first place."}'::jsonb
from public.lessons where slug = 'css-normal-flow';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Describe how block and inline boxes are laid out","Name what inline elements ignore","Pick between `block`, `inline`, `inline-block` and `none`"]}'::jsonb
from public.lessons where slug = 'css-normal-flow';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'Normal flow is the layout a browser gives you before you write a single layout rule. Blocks stack down the page; inline content runs along a line and wraps. Almost everything else in CSS layout is a deliberate departure from this.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-normal-flow';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Block box', 'Takes the full width available and starts on a new line. `<div>`, `<p>`, `<h1>`, `<section>` are block by default.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-normal-flow';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'Inline box', 'Sits within a line of text and is only as wide as its content. `<span>`, `<a>`, `<strong>`, `<em>` are inline by default.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-normal-flow';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, 'The display values worth knowing first', NULL,
       'display: block          full width, new line, all box properties apply
display: inline         flows in a line, width/height ignored,
                        vertical margin and padding do not push
display: inline-block   flows in a line, but sized like a block
display: none           removed entirely — no box, not in the
                        accessibility tree, not focusable
display: flow-root      a block that contains its own floats', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-normal-flow';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'interactive_demo'::public.block_type, 'The same span, three display values', 'Identical markup and identical width declaration.',
       NULL, NULL, NULL, '{"variants":[{"label":"inline (the default)","code":"<style>\n  .tag { display: inline; width: 300px; background: #cde; padding: 1rem; }\n</style>\n<p>Baked <span class=\"tag\">this morning</span> in Hexford.</p>","note":"The width is ignored. The horizontal padding pushes the text along; the vertical padding is drawn but overlaps the lines above and below."},{"label":"inline-block","code":"<style>\n  .tag { display: inline-block; width: 300px; background: #cde; padding: 1rem; }\n</style>\n<p>Baked <span class=\"tag\">this morning</span> in Hexford.</p>","note":"Still on the line, now genuinely 300px wide, and the vertical padding pushes the line apart properly."},{"label":"block","code":"<style>\n  .tag { display: block; width: 300px; background: #cde; padding: 1rem; }\n</style>\n<p>Baked <span class=\"tag\">this morning</span> in Hexford.</p>","note":"Breaks out onto its own line. Correct if it really is a block — but it has now interrupted the sentence."}]}'::jsonb
from public.lessons where slug = 'css-normal-flow';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'callout'::public.block_type, '`display: none` removes it from everyone', 'A `display: none` element has no box, is not announced by a screen reader, and cannot be focused. That is exactly right for content that is genuinely not there yet — and exactly wrong for something meant to be available to assistive technology but not visually, which needs a visually-hidden pattern instead. Hiding a skip link with `display: none` breaks it completely, which is the mistake Level 8 of the HTML course warns about.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'css-normal-flow';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'predict_check'::public.block_type, 'Predict, then check', 'A `<div>` — normally a block — is forced to `display: inline` and given a width and height. Before you check: how big is the box?',
       '<style>
  .box { display: inline; width: 200px; height: 200px; background: #cde; }
</style>
<div class="box">A div set to inline.</div>', 'html', NULL, '{"outcome":"Exactly as big as its text, and no bigger. `width` and `height` do not apply to non-replaced inline boxes, whatever element they started as. This is worth seeing once because it proves the point: block and inline are not properties of the *element*, they are properties of the box the element generates — and `display` changes that box completely. The element being a `<div>` buys you nothing here."}'::jsonb
from public.lessons where slug = 'css-normal-flow';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'progressive_detail'::public.block_type, 'Replaced elements are the exception', 'An `<img>`, `<video>`, `<input>` or `<iframe>` is a *replaced* element — its content comes from outside the document. Replaced elements are inline by default and yet `width` and `height` do apply to them, which is why an image can be sized without touching `display`. It is the single most useful exception to remember.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-normal-flow';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Normal flow stacks blocks down the page and runs inline content along a line.","Inline boxes ignore `width` and `height`, and their vertical margin and padding do not push anything.","`inline-block` keeps an element in the line while sizing it like a block.","`display: none` removes an element from layout, from the accessibility tree and from the tab order."],"nextUp":"Next: leaving normal flow deliberately."}'::jsonb
from public.lessons where slug = 'css-normal-flow';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What does an inline box ignore?","What is `inline-block` for?","Why is `display: none` more than a visual change?"],"points":["`width` and `height`, and vertical margin and padding do not push neighbouring content away — they are drawn but overlap.","Keeping an element in the flow of a line while letting it be sized like a block, with working vertical padding.","Because it removes the element entirely: no box, not announced by screen readers, not focusable. Anything that should be available to assistive technology but not shown needs a visually-hidden pattern instead."]}'::jsonb
from public.lessons where slug = 'css-normal-flow';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-flow-guided', 1, 'guided'::public.exercise_kind, 'Size a badge that stays in the line',
       'The `.badge` span should stay inside the sentence but be exactly 8rem wide with 0.5rem of padding all round. Choose the display value that allows both.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flow</title>
    <style>
      .badge { width: 8rem; padding: 0.5rem; background: #cde; }
    </style>
  </head>
  <body>
    <p>Baked <span class="badge">this morning</span> in Hexford.</p>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flow</title>
    <style>
      .badge {
        display: inline-block;
        width: 8rem;
        padding: 0.5rem;
        background: #cde;
      }
    </style>
  </head>
  <body>
    <p>Baked <span class="badge">this morning</span> in Hexford.</p>
  </body>
</html>', ARRAY['A plain inline box ignores width entirely.', 'display: block would break the badge onto its own line.', 'inline-block keeps it in the sentence and lets it be sized.']::text[],
       40, 2,
       (select id from public.skills where slug = 'layout-flow'), false
from public.lessons l where l.slug = 'css-normal-flow'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.badge', 'display',
       'inline-block', NULL, NULL, NULL,
       'The badge is inline-block', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flow-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.badge', 'width',
       '8rem', NULL, NULL, NULL,
       'The badge is 8rem wide', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flow-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.badge', 'padding',
       '0.5rem', NULL, NULL, NULL,
       'The badge has 0.5rem of padding', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flow-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-normal-flow'), NULL, 'q-css-inline-ignores', 1, 'single'::public.question_kind,
        'Which does a non-replaced inline box ignore?', '`width` and `height` do not apply to inline boxes.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`background`', false, NULL
from public.quiz_questions where slug = 'q-css-inline-ignores';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`width`', true, NULL
from public.quiz_questions where slug = 'q-css-inline-ignores';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`color`', false, NULL
from public.quiz_questions where slug = 'q-css-inline-ignores';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`font-size`', false, NULL
from public.quiz_questions where slug = 'q-css-inline-ignores';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-normal-flow'), NULL, 'q-css-display-none-cost', 2, 'single'::public.question_kind,
        'What else does `display: none` do besides hiding an element visually?', 'It removes it from the accessibility tree and from the tab order — it is gone for everyone.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Only hides it visually', false, NULL
from public.quiz_questions where slug = 'q-css-display-none-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Keeps it focusable for keyboard users', false, NULL
from public.quiz_questions where slug = 'q-css-display-none-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Makes it transparent but still clickable', false, NULL
from public.quiz_questions where slug = 'q-css-display-none-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Removes it from the accessibility tree and the tab order', true, NULL
from public.quiz_questions where slug = 'q-css-display-none-cost';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-normal-flow'), NULL, 'q-css-replaced-elements', 3, 'single'::public.question_kind,
        'Why can an `<img>` be given a width even though it is inline?', 'It is a replaced element — its content comes from outside the document, and sizing applies.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Width always applies to every element', false, NULL
from public.quiz_questions where slug = 'q-css-replaced-elements';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Because it has a src attribute', false, NULL
from public.quiz_questions where slug = 'q-css-replaced-elements';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is a replaced element', true, NULL
from public.quiz_questions where slug = 'q-css-replaced-elements';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Images are block by default', false, NULL
from public.quiz_questions where slug = 'q-css-replaced-elements';
-- lesson: Position and stacking
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-position-and-stacking', 2, 'Position and stacking', 'The four schemes, and why `z-index` sometimes does nothing', 'Positioning takes an element partly or wholly out of flow. Stacking decides what covers what — and it is not simply "the biggest number wins".',
       ARRAY['Choose between static, relative, absolute, fixed and sticky', 'Explain what an absolutely positioned element is positioned against', 'Say why a `z-index` of 9999 can still lose']::text[], 18, 40, (select id from public.skills where slug = 'layout-flow'), 0.7
from public.modules m where m.slug = 'css-flow'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'An element has `z-index: 9999` and is still hidden behind another element with `z-index: 1`. What is the most likely reason?',
       NULL, NULL, NULL, '{"options":["They are in different stacking contexts, and the parent of the first one sits lower","z-index has a maximum of 999","The element is not positioned, so z-index does nothing","The other element is later in the source"],"answer":"Both the first and third are real causes, and the first is the one that baffles people. `z-index` only orders elements *within the same stacking context*. If an ancestor created its own context — with `opacity` below 1, a `transform`, `position: fixed`, or a `z-index` of its own — then everything inside it is trapped in that context, and no number can lift a child above a sibling of its parent. The third option is also worth knowing: `z-index` has no effect at all on a `position: static` element."}'::jsonb
from public.lessons where slug = 'css-position-and-stacking';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Apply each positioning scheme deliberately","Identify the containing block for an absolute element","Recognise when a stacking context has been created"]}'::jsonb
from public.lessons where slug = 'css-position-and-stacking';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'The five values of `position`', NULL,
       'static     the default. In flow. top/left/z-index do nothing.
relative   in flow, and offset visually from where it would be.
           Its original space is kept. Creates a positioning
           context for absolutely positioned descendants.
absolute   out of flow. Positioned against the nearest
           positioned ancestor, or the page if there is none.
fixed      out of flow. Positioned against the viewport.
sticky     in flow until it reaches a threshold, then fixed
           within its scrolling ancestor.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-position-and-stacking';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'worked_example'::public.block_type, 'Placing a badge in the corner of a card', 'The classic case, and the one line everybody forgets.',
       NULL, NULL, NULL, '{"steps":[{"title":"Take the badge out of flow","code":".badge { position: absolute; top: 0.5rem; right: 0.5rem; }","reasoning":"Absolute positioning removes it from normal flow, so it no longer pushes the card content around. The offsets say where to put it."},{"title":"Ask: positioned against what?","code":"/* Nothing yet — so the page. */","reasoning":"An absolutely positioned element is placed against its nearest *positioned* ancestor. If none of its ancestors has a `position` other than `static`, it goes all the way up to the page — which is why the badge lands in the corner of the browser window rather than the card."},{"title":"Give the card a positioning context","code":".card { position: relative; }","reasoning":"This is the line people forget. `position: relative` with no offsets changes nothing visually and makes the card the reference point for any absolutely positioned descendant. The badge now lands in the card corner."},{"title":"Check it did not cover anything important","code":".card { position: relative; padding-right: 5rem; }","reasoning":"Out-of-flow elements do not reserve space, so the badge sits on top of whatever is underneath. If the card text can reach that corner, it needs room made for it — the layout will not do it for you."}]}'::jsonb
from public.lessons where slug = 'css-position-and-stacking';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'interactive_demo'::public.block_type, 'The same badge, with and without a positioning context', 'One declaration different.',
       NULL, NULL, NULL, '{"variants":[{"label":"Card is positioned","code":"<style>\n  .card { position: relative; border: 1px solid teal; padding: 1rem; padding-right: 5rem; }\n  .badge { position: absolute; top: 0.5rem; right: 0.5rem; background: #cde; padding: 0.25rem 0.5rem; }\n</style>\n<div class=\"card\">Sourdough workshop <span class=\"badge\">New</span></div>","note":"The badge is placed against the card, because the card is the nearest positioned ancestor."},{"label":"Card is static","code":"<style>\n  .card { border: 1px solid crimson; padding: 1rem; }\n  .badge { position: absolute; top: 0.5rem; right: 0.5rem; background: #fee; padding: 0.25rem 0.5rem; }\n</style>\n<div class=\"card\">Sourdough workshop <span class=\"badge\">New</span></div>","note":"No positioned ancestor, so the badge is placed against the page and flies to the top-right of the whole document."}]}'::jsonb
from public.lessons where slug = 'css-position-and-stacking';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'term'::public.block_type, 'Stacking context', 'A self-contained layer. Elements inside it are ordered among themselves, and the whole context is then ordered as one unit within its parent context.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-position-and-stacking';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'The things that quietly create a stacking context', '`position` with a `z-index` other than `auto`. `position: fixed` or `sticky`. `opacity` less than 1. Any `transform`, `filter`, `perspective`, `clip-path` or `mask`. `will-change` naming one of those. `isolation: isolate`. That `opacity: 0.99` someone added for a fade is enough — and it is why a dropdown suddenly disappears behind the next section after an unrelated change.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'css-position-and-stacking';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'self_explain'::public.block_type, 'Explain it in your own words', 'A colleague fixes an overlap by changing a `z-index` from 10 to 9999, and it works. Write your reply: what have they actually learned about the page, and what happens the next time?',
       NULL, NULL, NULL, '{"modelAnswer":"They have learned that the two elements are in the same stacking context — because if they were not, no number would have helped. So the fix worked by accident of that fact rather than by understanding it. The next time this happens the number goes higher, and eventually someone hits a case where the elements are *not* in the same context and no number works at all, at which point 9999 has taught them nothing useful and the real question — which ancestor created a context, and why — has never been asked. The better fix is almost always to find the ancestor that made a context, or to give the two elements an explicit, small ordering within one shared context."}'::jsonb
from public.lessons where slug = 'css-position-and-stacking';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'checklist'::public.block_type, 'When something is in the wrong place or the wrong layer', NULL,
       NULL, NULL, NULL, '{"items":["Is it `position: static`? Then `top`/`left`/`z-index` do nothing.","For `absolute`: which ancestor is positioned? That is what it is placed against.","Does the out-of-flow element cover content that needed the space?","For `z-index`: are the two elements in the same stacking context?","Did an ancestor create a context with `opacity`, `transform` or `filter`?"]}'::jsonb
from public.lessons where slug = 'css-position-and-stacking';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`static` is the default and ignores offsets and `z-index` entirely.","`relative` keeps its space and creates a positioning context for descendants.","`absolute` is placed against the nearest positioned ancestor, or the page.","`z-index` orders elements only within one stacking context, and many properties create one."],"nextUp":"Next: the Level 3 milestone."}'::jsonb
from public.lessons where slug = 'css-position-and-stacking';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What is an absolutely positioned element placed against?","Name four things that create a stacking context.","Why does `z-index` do nothing on a `static` element?"],"points":["Its nearest ancestor with a `position` other than `static`. If there is none, the page itself.","`position` with a numeric `z-index`; `position: fixed` or `sticky`; `opacity` below 1; a `transform`, `filter` or `clip-path`; `isolation: isolate`.","Because `z-index` only applies to positioned elements. On a static element it is simply ignored, which is one of the two commonest reasons it \"does not work\"."]}'::jsonb
from public.lessons where slug = 'css-position-and-stacking';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-position-guided', 1, 'guided'::public.exercise_kind, 'Pin a badge to a card',
       'Place the badge in the top-right corner **of the card**, not of the page. Give the card the positioning context it needs, and enough right padding that the text never runs under the badge.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Position</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card { border: 1px solid teal; padding: 1rem; }
      .badge { background: #cde; padding: 0.25rem 0.5rem; }
    </style>
  </head>
  <body>
    <div class="card">
      Sourdough workshop, six hours
      <span class="badge">New</span>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Position</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card {
        position: relative;
        border: 1px solid teal;
        padding: 1rem;
        padding-right: 5rem;
      }
      .badge {
        position: absolute;
        top: 0.5rem;
        right: 0.5rem;
        background: #cde;
        padding: 0.25rem 0.5rem;
      }
    </style>
  </head>
  <body>
    <div class="card">
      Sourdough workshop, six hours
      <span class="badge">New</span>
    </div>
  </body>
</html>', ARRAY['The badge needs position: absolute with top and right offsets.', 'Without position: relative on the card, the badge is placed against the page.', 'Out-of-flow elements reserve no space — add right padding so the text clears it.']::text[],
       50, 3,
       (select id from public.skills where slug = 'layout-flow'), false
from public.lessons l where l.slug = 'css-position-and-stacking'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.card', 'position',
       'relative', NULL, NULL, NULL,
       'The card creates a positioning context', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-position-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.badge', 'position',
       'absolute', NULL, NULL, NULL,
       'The badge is taken out of flow', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-position-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_declared'::public.requirement_kind, '.badge', 'top',
       NULL, NULL, NULL, NULL,
       'The badge is offset from the top', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-position-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_declared'::public.requirement_kind, '.badge', 'right',
       NULL, NULL, NULL, NULL,
       'The badge is offset from the right', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-position-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_declared'::public.requirement_kind, '.card', 'padding-right',
       NULL, NULL, NULL, NULL,
       'The card makes room for the badge', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-position-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-stacking-debug', 2, 'debug'::public.exercise_kind, 'A z-index that cannot win',
       'The dropdown has `z-index: 9999` and still hides behind the banner. The cause is the `opacity` on `.header`, which creates a stacking context trapping everything inside it. Remove that cause, and give the dropdown a small, honest `z-index` of `10`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Stacking</title>
    <style>
      .header { position: relative; opacity: 0.99; }
      .dropdown { position: absolute; z-index: 9999; background: #fff; }
      .banner { position: relative; z-index: 1; background: #cde; }
    </style>
  </head>
  <body>
    <div class="header">
      <div class="dropdown">Menu contents</div>
    </div>
    <div class="banner">Promotional banner</div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Stacking</title>
    <style>
      .header { position: relative; }
      .dropdown { position: absolute; z-index: 10; background: #fff; }
      .banner { position: relative; z-index: 1; background: #cde; }
    </style>
  </head>
  <body>
    <div class="header">
      <div class="dropdown">Menu contents</div>
    </div>
    <div class="banner">Promotional banner</div>
  </body>
</html>', ARRAY['An opacity below 1 creates a stacking context, trapping every descendant inside it.', 'Remove the opacity declaration from .header entirely.', 'Then a z-index of 10 comfortably beats the banner''s 1 — the huge number was never the answer.']::text[],
       55, 4,
       (select id from public.skills where slug = 'layout-flow'), false
from public.lessons l where l.slug = 'css-position-and-stacking'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_property_absent'::public.requirement_kind, '.header', 'opacity',
       NULL, NULL, NULL, NULL,
       'The header no longer creates a stacking context', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-stacking-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.dropdown', 'z-index',
       '10', NULL, NULL, NULL,
       'The dropdown uses a small, honest z-index', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-stacking-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.dropdown', 'position',
       'absolute', NULL, NULL, NULL,
       'The dropdown is still positioned', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-stacking-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-position-and-stacking'), NULL, 'q-css-absolute-against', 1, 'single'::public.question_kind,
        'An absolutely positioned element is placed against what?', 'Its nearest positioned ancestor — or the page, if none of its ancestors is positioned.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Its immediate parent, always', false, NULL
from public.quiz_questions where slug = 'q-css-absolute-against';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The viewport, always', false, NULL
from public.quiz_questions where slug = 'q-css-absolute-against';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The nearest block element', false, NULL
from public.quiz_questions where slug = 'q-css-absolute-against';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The nearest ancestor whose position is not static', true, NULL
from public.quiz_questions where slug = 'q-css-absolute-against';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-position-and-stacking'), NULL, 'q-css-stacking-context-cause', 2, 'single'::public.question_kind,
        'Which of these creates a new stacking context?', 'An `opacity` below 1 does, which is why an unrelated fade can bury a dropdown.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`padding: 1rem`', false, NULL
from public.quiz_questions where slug = 'q-css-stacking-context-cause';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`font-weight: bold`', false, NULL
from public.quiz_questions where slug = 'q-css-stacking-context-cause';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`opacity: 0.99`', true, NULL
from public.quiz_questions where slug = 'q-css-stacking-context-cause';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`color: red`', false, NULL
from public.quiz_questions where slug = 'q-css-stacking-context-cause';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-position-and-stacking'), NULL, 'q-css-zindex-static', 3, 'single'::public.question_kind,
        'Why does `z-index: 50` do nothing on an element with no `position`?', '`z-index` applies only to positioned elements; on a static element it is ignored.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '50 is too small a value', false, NULL
from public.quiz_questions where slug = 'q-css-zindex-static';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It only works inside a flex container', false, NULL
from public.quiz_questions where slug = 'q-css-zindex-static';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It needs an `!important`', false, NULL
from public.quiz_questions where slug = 'q-css-zindex-static';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`z-index` only applies to positioned elements', true, NULL
from public.quiz_questions where slug = 'q-css-zindex-static';
-- lesson: Milestone: place things deliberately
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-flow-milestone', 3, 'Milestone: place things deliberately', 'A layout where nothing is where its author meant it', 'Four faults, all of them flow or stacking. None needs a layout system — they need the defaults understood.',
       ARRAY['Diagnose a misplaced element', 'Repair positioning without introducing a layout framework', 'Keep out-of-flow elements from covering content']::text[], 18, 40, (select id from public.skills where slug = 'layout-flow'), 0.8
from public.modules m where m.slug = 'css-flow'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Work through positioning faults methodically","Fix stacking without escalating numbers","Explain each repair"]}'::jsonb
from public.lessons where slug = 'css-flow-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'Symptom to cause', NULL,
       'Symptom                        Look at
element ignores width          is it inline?
element flew to the page edge  which ancestor is positioned?
content sits under something   out-of-flow element covering it
z-index does nothing           is the element positioned?
z-index still does nothing     which ancestor made a context?', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-flow-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'interactive_demo'::public.block_type, 'Two ways a badge goes wrong', 'The same absolute badge in two cards.',
       NULL, NULL, NULL, '{"variants":[{"label":"Correct","code":"<style>\n  .card { position: relative; border: 1px solid teal; padding: 1rem 5rem 1rem 1rem; }\n  .badge { position: absolute; top: 0.5rem; right: 0.5rem; background: #cde; padding: 0.25rem 0.5rem; }\n</style>\n<div class=\"card\">Sourdough workshop, six hours, small groups <span class=\"badge\">New</span></div>","note":"Positioned against the card, with padding making room so the text never runs underneath."},{"label":"No room made","code":"<style>\n  .card { position: relative; border: 1px solid crimson; padding: 1rem; }\n  .badge { position: absolute; top: 0.5rem; right: 0.5rem; background: #fee; padding: 0.25rem 0.5rem; }\n</style>\n<div class=\"card\">Sourdough workshop, six hours, small groups and everything provided <span class=\"badge\">New</span></div>","note":"Placed correctly and covering the text, because an out-of-flow element reserves no space for itself."}]}'::jsonb
from public.lessons where slug = 'css-flow-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'recall'::public.block_type, 'From memory', 'From memory: name the five values of `position` and say, in one line each, what each does to flow.',
       NULL, NULL, NULL, '{"points":["`static` — the default; fully in flow, and offsets and `z-index` are ignored.","`relative` — in flow and keeps its space, offset visually, and becomes a positioning context for descendants.","`absolute` — out of flow, reserves no space, placed against the nearest positioned ancestor.","`fixed` — out of flow, placed against the viewport.","`sticky` — in flow until a threshold is reached, then fixed within its scrolling ancestor."]}'::jsonb
from public.lessons where slug = 'css-flow-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Most \"wrong place\" bugs are a missing `position: relative` on the intended reference.","Out-of-flow elements reserve no space — make room for them yourself.","A `z-index` that does nothing means either no `position`, or a different stacking context."],"nextUp":"Next: Flexbox."}'::jsonb
from public.lessons where slug = 'css-flow-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What is the first thing to check when an absolutely positioned element lands in the wrong place?"],"points":["Which ancestor is positioned. An absolute element is placed against its nearest ancestor whose `position` is not `static`, so if nobody has one it goes all the way up to the page. Adding `position: relative` to the intended reference — which changes nothing visually on its own — is the fix nine times out of ten."]}'::jsonb
from public.lessons where slug = 'css-flow-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-flow-milestone-debug', 1, 'debug'::public.exercise_kind, 'Four things in the wrong place',
       'Repair four faults. The `.tag` span must be sized (make it inline-block). The `.badge` must sit in the corner of `.card`, not the page. The card must make room so its text does not run under the badge. And the `.dropdown` must appear above `.banner` using a `z-index` of `10`, which means removing whatever is trapping it.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flow milestone</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .tag { width: 6rem; padding: 0.25rem; background: #cde; }
      .card { border: 1px solid teal; padding: 1rem; }
      .badge { position: absolute; top: 0.5rem; right: 0.5rem; background: #cde; }
      .header { position: relative; opacity: 0.99; }
      .dropdown { position: absolute; z-index: 9999; background: #fff; }
      .banner { position: relative; z-index: 1; background: #cde; }
    </style>
  </head>
  <body>
    <div class="header">
      <div class="dropdown">Menu contents</div>
    </div>
    <div class="banner">Promotional banner</div>
    <div class="card">
      Sourdough workshop <span class="tag">6 hours</span>
      <span class="badge">New</span>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flow milestone</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .tag { display: inline-block; width: 6rem; padding: 0.25rem; background: #cde; }
      .card { position: relative; border: 1px solid teal; padding: 1rem; padding-right: 5rem; }
      .badge { position: absolute; top: 0.5rem; right: 0.5rem; background: #cde; }
      .header { position: relative; }
      .dropdown { position: absolute; z-index: 10; background: #fff; }
      .banner { position: relative; z-index: 1; background: #cde; }
    </style>
  </head>
  <body>
    <div class="header">
      <div class="dropdown">Menu contents</div>
    </div>
    <div class="banner">Promotional banner</div>
    <div class="card">
      Sourdough workshop <span class="tag">6 hours</span>
      <span class="badge">New</span>
    </div>
  </body>
</html>', ARRAY['A span is inline, so its width is ignored — inline-block fixes that.', 'The badge needs the card to be position: relative.', 'Add right padding to the card so the text clears the badge.', 'The opacity on .header traps the dropdown in its own stacking context.']::text[],
       70, 4,
       (select id from public.skills where slug = 'layout-flow'), false
from public.lessons l where l.slug = 'css-flow-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.tag', 'display',
       'inline-block', NULL, NULL, NULL,
       'The tag can be sized', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flow-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.card', 'position',
       'relative', NULL, NULL, NULL,
       'The card is the badge''s reference', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flow-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_declared'::public.requirement_kind, '.card', 'padding-right',
       NULL, NULL, NULL, NULL,
       'The card makes room for the badge', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flow-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_property_absent'::public.requirement_kind, '.header', 'opacity',
       NULL, NULL, NULL, NULL,
       'The header no longer traps its children', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flow-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value'::public.requirement_kind, '.dropdown', 'z-index',
       '10', NULL, NULL, NULL,
       'The dropdown uses a small z-index', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flow-milestone-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-flow-milestone'), NULL, 'q-css-out-of-flow-space', 1, 'single'::public.question_kind,
        'How much space does an absolutely positioned element reserve in the flow?', 'None. It is out of flow entirely, so surrounding content behaves as though it were not there.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'None at all', true, NULL
from public.quiz_questions where slug = 'q-css-out-of-flow-space';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Its full width and height', false, NULL
from public.quiz_questions where slug = 'q-css-out-of-flow-space';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Its height only', false, NULL
from public.quiz_questions where slug = 'q-css-out-of-flow-space';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Its margin only', false, NULL
from public.quiz_questions where slug = 'q-css-out-of-flow-space';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-flow-milestone'), NULL, 'q-css-relative-no-offsets', 2, 'single'::public.question_kind,
        'What does `position: relative` with no offsets do?', 'Nothing visually — but it makes the element a positioning context for absolutely positioned descendants.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Nothing at all; it is a no-op', false, NULL
from public.quiz_questions where slug = 'q-css-relative-no-offsets';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nothing visible, but it becomes a reference for absolute descendants', true, NULL
from public.quiz_questions where slug = 'q-css-relative-no-offsets';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Removes it from flow', false, NULL
from public.quiz_questions where slug = 'q-css-relative-no-offsets';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Centres it', false, NULL
from public.quiz_questions where slug = 'q-css-relative-no-offsets';
-- Level 3 milestone: Flow, Position and Stacking questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-3-milestone'), 'a-css-3-inline-width', 1, 'single'::public.question_kind,
        'Why is `width` ignored on a `<span>`?', 'It generates an inline box, and `width` does not apply to non-replaced inline boxes.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The width needs a unit', false, NULL
from public.quiz_questions where slug = 'a-css-3-inline-width';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It needs an id selector', false, NULL
from public.quiz_questions where slug = 'a-css-3-inline-width';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It generates an inline box', true, NULL
from public.quiz_questions where slug = 'a-css-3-inline-width';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Spans cannot be styled', false, NULL
from public.quiz_questions where slug = 'a-css-3-inline-width';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-3-milestone'), 'a-css-3-inline-block', 2, 'single'::public.question_kind,
        'What does `inline-block` give you?', 'A box that stays in the line but can be sized like a block.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Breaks onto its own line', false, NULL
from public.quiz_questions where slug = 'a-css-3-inline-block';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Removes it from the document', false, NULL
from public.quiz_questions where slug = 'a-css-3-inline-block';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Makes it position: absolute', false, NULL
from public.quiz_questions where slug = 'a-css-3-inline-block';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Stays in the line, sizes like a block', true, NULL
from public.quiz_questions where slug = 'a-css-3-inline-block';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-3-milestone'), 'a-css-3-abs-reference', 3, 'single'::public.question_kind,
        'A badge with `position: absolute` lands in the corner of the page instead of its card. Why?', 'No ancestor is positioned, so it falls back to the page.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'No ancestor has a position other than static', true, NULL
from public.quiz_questions where slug = 'a-css-3-abs-reference';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The offsets are the wrong way round', false, NULL
from public.quiz_questions where slug = 'a-css-3-abs-reference';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Absolute always means the page', false, NULL
from public.quiz_questions where slug = 'a-css-3-abs-reference';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The card needs a z-index', false, NULL
from public.quiz_questions where slug = 'a-css-3-abs-reference';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-3-milestone'), 'a-css-3-sticky', 4, 'single'::public.question_kind,
        'What does `position: sticky` do?', 'Stays in flow until a threshold, then behaves as fixed within its scrolling ancestor.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Always fixed to the viewport', false, NULL
from public.quiz_questions where slug = 'a-css-3-sticky';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Always out of flow', false, NULL
from public.quiz_questions where slug = 'a-css-3-sticky';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The same as relative', false, NULL
from public.quiz_questions where slug = 'a-css-3-sticky';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'In flow until a threshold, then fixed within its scroller', true, NULL
from public.quiz_questions where slug = 'a-css-3-sticky';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-3-milestone'), 'a-css-3-context-trap', 5, 'single'::public.question_kind,
        'A child with `z-index: 9999` is behind a sibling of its parent. What is happening?', 'The parent created a stacking context, so the child is ordered inside it and cannot escape.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'z-index cannot be used on children', false, NULL
from public.quiz_questions where slug = 'a-css-3-context-trap';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The parent created a stacking context', true, NULL
from public.quiz_questions where slug = 'a-css-3-context-trap';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'z-index is capped at 999', false, NULL
from public.quiz_questions where slug = 'a-css-3-context-trap';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The sibling has `!important`', false, NULL
from public.quiz_questions where slug = 'a-css-3-context-trap';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-3-milestone'), 'a-css-3-display-none-a11y', 6, 'single'::public.question_kind,
        'Which is true of `display: none`?', 'It removes the element for everyone — visually, from the accessibility tree, and from focus order.', (select id from public.skills where slug = 'layout-flow'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Screen readers still announce it', false, NULL
from public.quiz_questions where slug = 'a-css-3-display-none-a11y';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It only affects printing', false, NULL
from public.quiz_questions where slug = 'a-css-3-display-none-a11y';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It removes the element from the accessibility tree too', true, NULL
from public.quiz_questions where slug = 'a-css-3-display-none-a11y';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It hides it visually but keeps it focusable', false, NULL
from public.quiz_questions where slug = 'a-css-3-display-none-a11y';
-- --------------------------------------------------------------------------
-- CSS Architect — Level 4: Flexbox
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'css-flexbox', 4, 'Flexbox', 'One dimension, two axes, and the properties that follow from them',
       'Flexbox is small: a container, a direction, and rules for distributing space. Almost every difficulty with it is really a question of which axis you are talking about.', 'You can build any one-dimensional layout and explain which axis each property acts on.', 'violet'
from public.courses c where c.slug = 'css-architect'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'css-level-4-milestone', 'milestone'::public.assessment_kind, 'Level 4 milestone: Flexbox', 'Six questions on axes, alignment and flexible sizing. Pass mark 75%.',
       0.75, 180, 4
from public.levels l where l.slug = 'css-flexbox'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Flexbox
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'css-flex', 1, 'Flexbox', 'Axes, alignment, and the flex shorthand that decides how space is shared.',
       60, false
from public.levels l where l.slug = 'css-flexbox'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'css-flex' and p.slug = 'css-flow';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'css-flex' and s.slug = 'flexbox';
-- lesson: The two axes
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-flex-axes', 1, 'The two axes', 'Why `justify-content` sometimes moves things vertically', 'One property decides what every other flexbox property means. Get it clear once and the rest stops being guesswork.',
       ARRAY['Identify the main and cross axis for any flex container', 'Choose between `justify-content` and `align-items` correctly', 'Explain why the axes swap with `flex-direction`']::text[], 16, 40, (select id from public.skills where slug = 'flexbox'), 0.7
from public.modules m where m.slug = 'css-flex'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A flex container has `flex-direction: column`. Which property now centres its children **vertically**?',
       NULL, NULL, NULL, '{"options":["`justify-content`","`align-items`","`text-align`","`vertical-align`"],"answer":"`justify-content`. This is the single most useful fact in flexbox and the one that trips up nearly everyone. `justify-content` always works along the **main** axis and `align-items` always works along the **cross** axis — and `flex-direction: column` makes the main axis vertical. The properties did not change meaning; the axes rotated underneath them."}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Name the main and cross axis given a `flex-direction`","Apply `justify-content` and `align-items` to the correct axis","Predict what happens when the direction changes"]}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'Flexbox lays out children along one axis. Everything follows from which axis that is — which is why the first thing to establish about any flex container is its direction.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Main axis', 'The direction children are laid out in, set by `flex-direction`. `row` (the default) means horizontal; `column` means vertical.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'term'::public.block_type, 'Cross axis', 'The axis at right angles to the main axis. It is whatever the main axis is not.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, 'The whole model on one screen', NULL,
       'flex-direction: row      main = horizontal, cross = vertical
flex-direction: column   main = vertical,   cross = horizontal

justify-content   always the MAIN axis
align-items       always the CROSS axis
align-content     the cross axis, when lines have wrapped
gap               space between items, both axes

So: to centre a box in the middle of its container,
  display: flex;
  justify-content: center;   /* main  */
  align-items: center;       /* cross */
and it works whichever direction you chose.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'interactive_demo'::public.block_type, 'The same two properties, two directions', 'Identical CSS apart from `flex-direction`.',
       NULL, NULL, NULL, '{"variants":[{"label":"row","code":"<style>\n  .box { display: flex; flex-direction: row; justify-content: center; align-items: flex-start; gap: 0.5rem; height: 8rem; border: 1px solid teal; }\n  .box > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class=\"box\"><div>A</div><div>B</div><div>C</div></div>","note":"Main axis is horizontal, so `justify-content: center` groups them across the middle. `align-items: flex-start` pins them to the top."},{"label":"column","code":"<style>\n  .box { display: flex; flex-direction: column; justify-content: center; align-items: flex-start; gap: 0.5rem; height: 8rem; border: 1px solid teal; }\n  .box > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class=\"box\"><div>A</div><div>B</div><div>C</div></div>","note":"Identical declarations. The axes rotated, so `justify-content` now centres vertically and `align-items` pins them left."},{"label":"Centred both ways","code":"<style>\n  .box { display: flex; justify-content: center; align-items: center; height: 8rem; border: 1px solid teal; }\n  .box > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class=\"box\"><div>Centred</div></div>","note":"The two-line answer to a problem that took the whole industry a decade to solve properly."}]}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'callout'::public.block_type, 'Use `gap`, not margins', '`gap` puts space *between* items and none on the outside, so you never need the `:last-child { margin-right: 0 }` that margin-based spacing always ends up needing. It works in flexbox and grid alike, and margins do not collapse inside a flex container anyway.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'predict_check'::public.block_type, 'Predict, then check', 'Two children with very different amounts of content, in a plain flex row with no other properties. Before you check: are the two boxes the same height, or does each fit its own content?',
       '<style>
  .row { display: flex; }
  .row > div { background: #cde; padding: 0.5rem; }
</style>
<div class="row">
  <div>Short</div>
  <div>A much longer piece of content here</div>
</div>', 'html', NULL, '{"outcome":"They are the **same height** — both stretch to match the taller one. `align-items` defaults to `stretch`, so children fill the cross axis unless told otherwise. This is why flexbox gives equal-height columns for free, which was genuinely hard before it existed. If you want each box to fit its own content instead, that is `align-items: flex-start`."}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'self_explain'::public.block_type, 'Explain it in your own words', 'A colleague says they can never remember whether to use `justify-content` or `align-items`, so they try one and then the other. Write them a rule they can actually hold in their head.',
       NULL, NULL, NULL, '{"modelAnswer":"The rule is: `justify-content` is always the main axis, `align-items` is always the cross axis — and the main axis is whichever way `flex-direction` points. So the question is never \"which property centres vertically\", because that has no fixed answer; it is \"which axis am I talking about, and which way is my main axis pointing\". Once the direction is established the property follows without a guess. Trying one and then the other works often enough to feel fine and stops working the moment the direction changes, which is why it never becomes fluent."}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'checklist'::public.block_type, 'For any flex container, establish in this order', NULL,
       NULL, NULL, NULL, '{"items":["What is the `flex-direction`? That fixes the main axis.","The cross axis is the other one.","`justify-content` distributes along the main axis.","`align-items` aligns along the cross axis.","`gap` spaces between items on both."]}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`flex-direction` decides the main axis; the cross axis is the other one.","`justify-content` always acts on the main axis, `align-items` on the cross axis.","Children stretch on the cross axis by default, giving equal heights for free.","`gap` spaces items without the last-child margin problem."],"nextUp":"Next: how space is shared out."}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["With `flex-direction: column`, which property centres children vertically?","Why do two flex children end up the same height by default?","Why prefer `gap` over margins between flex items?"],"points":["`justify-content`, because column makes the main axis vertical and `justify-content` always acts on the main axis.","Because `align-items` defaults to `stretch`, so children fill the cross axis. Setting `align-items: flex-start` makes each fit its own content instead.","`gap` puts space only *between* items, so there is no trailing space to undo with a `:last-child` rule — and margins do not collapse inside a flex container anyway."]}'::jsonb
from public.lessons where slug = 'css-flex-axes';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-flex-centre-guided', 1, 'guided'::public.exercise_kind, 'Centre a box, both ways',
       'Make `.frame` a flex container 12rem tall and centre its single child both horizontally and vertically.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flexbox</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .frame { height: 12rem; border: 1px solid teal; }
      .frame > div { background: #cde; padding: 0.5rem; }
    </style>
  </head>
  <body>
    <div class="frame"><div>Centred</div></div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flexbox</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .frame {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 12rem;
        border: 1px solid teal;
      }
      .frame > div { background: #cde; padding: 0.5rem; }
    </style>
  </head>
  <body>
    <div class="frame"><div>Centred</div></div>
  </body>
</html>', ARRAY['The container needs display: flex before anything else applies.', 'justify-content works on the main axis, which is horizontal by default.', 'align-items works on the cross axis, which is vertical by default.']::text[],
       40, 2,
       (select id from public.skills where slug = 'flexbox'), false
from public.lessons l where l.slug = 'css-flex-axes'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.frame', 'display',
       'flex', NULL, NULL, NULL,
       'The frame is a flex container', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-centre-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.frame', 'justify-content',
       'center', NULL, NULL, NULL,
       'Children are centred on the main axis', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-centre-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.frame', 'align-items',
       'center', NULL, NULL, NULL,
       'Children are centred on the cross axis', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-centre-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, '.frame', 'height',
       '12rem', NULL, NULL, NULL,
       'The frame is still 12rem tall', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-centre-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-flex-axis-debug', 2, 'debug'::public.exercise_kind, 'The axes are the wrong way round',
       'This column of cards should be centred horizontally and start at the top. The author swapped the two alignment properties. Fix it, keeping `flex-direction: column`, and use `gap` of `1rem` rather than margins.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flexbox</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .stack {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: flex-start;
        height: 20rem;
        border: 1px solid teal;
      }
      .stack > div { background: #cde; padding: 0.5rem; margin-bottom: 1rem; }
    </style>
  </head>
  <body>
    <div class="stack">
      <div>Sourdough</div>
      <div>Rye</div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flexbox</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .stack {
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
        gap: 1rem;
        height: 20rem;
        border: 1px solid teal;
      }
      .stack > div { background: #cde; padding: 0.5rem; }
    </style>
  </head>
  <body>
    <div class="stack">
      <div>Sourdough</div>
      <div>Rye</div>
    </div>
  </body>
</html>', ARRAY['With column, the main axis is vertical — so justify-content controls top-to-bottom.', '"Start at the top" is justify-content: flex-start.', '"Centred horizontally" on a column is align-items: center.', 'Replace the child margin-bottom with gap on the container.']::text[],
       50, 3,
       (select id from public.skills where slug = 'flexbox'), false
from public.lessons l where l.slug = 'css-flex-axes'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.stack', 'flex-direction',
       'column', NULL, NULL, NULL,
       'The direction is unchanged', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-axis-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.stack', 'justify-content',
       'flex-start', NULL, NULL, NULL,
       'Items start at the top of the main axis', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-axis-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.stack', 'align-items',
       'center', NULL, NULL, NULL,
       'Items are centred on the cross axis', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-axis-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, '.stack', 'gap',
       '1rem', NULL, NULL, NULL,
       'Spacing uses gap', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-axis-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-flex-axes'), NULL, 'q-css-justify-axis', 1, 'single'::public.question_kind,
        'Which axis does `justify-content` act on?', 'Always the main axis, whichever way `flex-direction` points it.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The main axis, always', true, NULL
from public.quiz_questions where slug = 'q-css-justify-axis';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The horizontal axis, always', false, NULL
from public.quiz_questions where slug = 'q-css-justify-axis';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The cross axis', false, NULL
from public.quiz_questions where slug = 'q-css-justify-axis';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Whichever axis is longer', false, NULL
from public.quiz_questions where slug = 'q-css-justify-axis';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-flex-axes'), NULL, 'q-css-align-items-default', 2, 'single'::public.question_kind,
        'What is the default value of `align-items`?', '`stretch`, which is why flex children end up the same height by default.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`flex-start`', false, NULL
from public.quiz_questions where slug = 'q-css-align-items-default';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`baseline`', false, NULL
from public.quiz_questions where slug = 'q-css-align-items-default';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`stretch`', true, NULL
from public.quiz_questions where slug = 'q-css-align-items-default';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`center`', false, NULL
from public.quiz_questions where slug = 'q-css-align-items-default';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-flex-axes'), NULL, 'q-css-gap-benefit', 3, 'single'::public.question_kind,
        'What does `gap` do that margins between items do not?', 'It puts space only between items, with none on the outside — so no last-child correction is needed.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Collapses like vertical margins', false, NULL
from public.quiz_questions where slug = 'q-css-gap-benefit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Applies to the container padding', false, NULL
from public.quiz_questions where slug = 'q-css-gap-benefit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Adds space only between items, never on the outside', true, NULL
from public.quiz_questions where slug = 'q-css-gap-benefit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Works only in grid', false, NULL
from public.quiz_questions where slug = 'q-css-gap-benefit';
-- lesson: Sharing out space
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-flex-sizing', 2, 'Sharing out space', '`flex-grow`, `flex-shrink`, `flex-basis` — and the shorthand you should actually write', 'Three properties decide how leftover space is divided and how overflow is absorbed. One shorthand covers almost every real case.',
       ARRAY['Explain what `flex: 1` expands to', 'Choose a `flex-basis` deliberately', 'Use `flex-wrap` to build a responsive row with no media query']::text[], 17, 40, (select id from public.skills where slug = 'flexbox'), 0.7
from public.modules m where m.slug = 'css-flex'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'Three flex children all have `flex: 1`, but one contains far more text than the others. Are they the same width?',
       NULL, NULL, NULL, '{"options":["Yes — `flex: 1` sets `flex-basis: 0`, so content size is ignored","No — the one with more content is wider","Only if you also set `width`","Only in a row, not a column"],"answer":"Yes, they are equal. `flex: 1` is shorthand for `flex: 1 1 0%` — and that `0%` basis is the important part: it tells flexbox to start from zero rather than from the content size, so all the space is distributed equally. The near-identical `flex: auto` means `flex: 1 1 auto`, which *does* start from content size and gives unequal widths. That one character is the difference between \"equal columns\" and \"proportional columns\", and it explains most surprises here."}'::jsonb
from public.lessons where slug = 'css-flex-sizing';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Expand the `flex` shorthand correctly","Choose between `flex: 1` and `flex: auto`","Build a wrapping row that needs no breakpoint"]}'::jsonb
from public.lessons where slug = 'css-flex-sizing';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'The flex shorthand', NULL,
       'flex: <grow> <shrink> <basis>

flex: 1        =  1 1 0%     equal shares, ignore content size
flex: auto     =  1 1 auto   share space, but start from content
flex: none     =  0 0 auto   do not grow, do not shrink
flex: 0 1 auto              the default: shrink if needed, never grow

grow    how much of the LEFTOVER space this item takes
shrink  how much this item gives up when there is not enough
basis   the size to start from before growing or shrinking', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-flex-sizing';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'worked_example'::public.block_type, 'A sidebar that stays put and a main column that fills', 'The most common two-column layout in existence, and why each value is what it is.',
       NULL, NULL, NULL, '{"steps":[{"title":"Make the container a row","code":".layout { display: flex; gap: 1rem; }","reasoning":"Row is the default direction, so the main axis is horizontal and space will be shared left to right. `gap` handles the space between without touching either child."},{"title":"Fix the sidebar","code":".sidebar { flex: 0 0 16rem; }","reasoning":"Grow 0 so it never takes leftover space; shrink 0 so it never gives any up; basis 16rem so that is its size. This is the honest way to say \"exactly this wide, always\" — more reliable than `width` alone, because `width` would still allow shrinking."},{"title":"Let the main column take the rest","code":".main { flex: 1; }","reasoning":"Grow 1 from a basis of 0 means \"take all the leftover space\". It does not need to know how wide the sidebar is, which is what makes the layout survive the sidebar changing."},{"title":"Guard against the content that will not fit","code":".main { flex: 1; min-width: 0; }","reasoning":"The line nobody expects. A flex item will not shrink below its content''s minimum size by default, so one long unbroken string — a URL, a code sample — pushes the whole layout wider than its container. `min-width: 0` allows it to shrink properly. This is the single most common flexbox overflow bug."}]}'::jsonb
from public.lessons where slug = 'css-flex-sizing';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'interactive_demo'::public.block_type, 'The same row, three flex values', 'Three children, different amounts of text.',
       NULL, NULL, NULL, '{"variants":[{"label":"flex: 1 — equal","code":"<style>\n  .row { display: flex; gap: 0.5rem; }\n  .row > div { flex: 1; background: #cde; padding: 0.5rem; }\n</style>\n<div class=\"row\"><div>A</div><div>Rather more content here</div><div>B</div></div>","note":"Basis of 0 means content size is ignored entirely. Three equal columns."},{"label":"flex: auto — proportional","code":"<style>\n  .row { display: flex; gap: 0.5rem; }\n  .row > div { flex: auto; background: #cde; padding: 0.5rem; }\n</style>\n<div class=\"row\"><div>A</div><div>Rather more content here</div><div>B</div></div>","note":"Basis of auto starts from content size, so the wordy one keeps its head start and stays wider."},{"label":"Fixed plus fill","code":"<style>\n  .row { display: flex; gap: 0.5rem; }\n  .side { flex: 0 0 8rem; background: #dcd; padding: 0.5rem; }\n  .main { flex: 1; min-width: 0; background: #cde; padding: 0.5rem; }\n</style>\n<div class=\"row\"><div class=\"side\">Sidebar</div><div class=\"main\">Main content takes whatever is left.</div></div>","note":"The sidebar is exactly 8rem and refuses to shrink; the main column absorbs everything else."}]}'::jsonb
from public.lessons where slug = 'css-flex-sizing';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'term'::public.block_type, '`flex-wrap`', 'Whether items may move onto a new line when they do not fit. `nowrap` is the default and is why a flex row can overflow.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-flex-sizing';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'A responsive card row with no media query', 'Give the container `flex-wrap: wrap` and each card `flex: 1 1 16rem`. Each card wants to be 16rem, will grow to fill leftover space, and will wrap to a new line when there is not room for another. The number of columns changes with the available width, and you have not written a single breakpoint — which means it also works inside a narrow sidebar, where a viewport-based media query would be wrong.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-flex-sizing';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'progressive_detail'::public.block_type, 'Why `min-width: 0` keeps appearing', 'A flex item''s default minimum size is `auto`, which means "at least as big as my content needs". For most content that is sensible. For a long URL, a `<pre>` block, or a table, it means the item refuses to shrink and pushes the layout wider than the screen. `min-width: 0` on a row item — or `min-height: 0` on a column item — opts out of that floor. If a flex layout overflows and you cannot see why, this is the first thing to try.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-flex-sizing';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`flex: 1` is `1 1 0%` — equal shares, ignoring content size.","`flex: auto` is `1 1 auto` — proportional, starting from content size.","`flex: 0 0 <size>` is how you say \"exactly this wide, always\".","`flex-wrap: wrap` with a basis gives responsive columns without a media query."],"nextUp":"Next: the Level 4 milestone."}'::jsonb
from public.lessons where slug = 'css-flex-sizing';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What does `flex: 1` expand to, and why does the basis matter?","How do you make an item exactly 16rem and refuse to shrink?","What does `min-width: 0` fix, and why is it needed?"],"points":["`flex: 1 1 0%`. The `0%` basis means the item starts from zero rather than its content size, so leftover space is shared equally and all items end up the same width.","`flex: 0 0 16rem` — never grow, never shrink, start at 16rem.","A flex item will not shrink below its content''s minimum size by default, so one long unbroken string pushes the layout wider than its container. `min-width: 0` removes that floor."]}'::jsonb
from public.lessons where slug = 'css-flex-sizing';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-flex-sidebar-guided', 1, 'guided'::public.exercise_kind, 'A fixed sidebar and a filling main column',
       'Make `.layout` a flex row with a `1rem` gap. The `.sidebar` must be exactly `16rem` and never grow or shrink. The `.main` column takes all remaining space and can shrink below its content when it has to.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flex layout</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .layout { border: 1px solid teal; }
      .sidebar { background: #dcd; padding: 1rem; }
      .main { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="layout">
      <div class="sidebar">Routes</div>
      <div class="main">Hire a bike by the hour, the day or the week.</div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Flex layout</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .layout { display: flex; gap: 1rem; border: 1px solid teal; }
      .sidebar { flex: 0 0 16rem; background: #dcd; padding: 1rem; }
      .main { flex: 1; min-width: 0; background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="layout">
      <div class="sidebar">Routes</div>
      <div class="main">Hire a bike by the hour, the day or the week.</div>
    </div>
  </body>
</html>', ARRAY['The container needs display: flex and gap: 1rem.', '"Exactly this wide, never changes" is flex: 0 0 16rem.', '"Take everything else" is flex: 1.', 'Add min-width: 0 so long content cannot push the layout wider.']::text[],
       50, 3,
       (select id from public.skills where slug = 'flexbox'), false
from public.lessons l where l.slug = 'css-flex-sizing'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.layout', 'display',
       'flex', NULL, NULL, NULL,
       'The layout is a flex row', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-sidebar-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.layout', 'gap',
       '1rem', NULL, NULL, NULL,
       'There is a 1rem gap', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-sidebar-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value_matches'::public.requirement_kind, '.sidebar', 'flex',
       '0\s+0\s+16rem', NULL, NULL, NULL,
       'The sidebar is fixed at 16rem', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-sidebar-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value_matches'::public.requirement_kind, '.main', 'flex',
       '^1$|1\s+1\s+0', NULL, NULL, NULL,
       'The main column fills the rest', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-sidebar-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value'::public.requirement_kind, '.main', 'min-width',
       '0', NULL, NULL, NULL,
       'The main column can shrink below its content', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-sidebar-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-flex-wrap-debug', 2, 'debug'::public.exercise_kind, 'A card row that overflows',
       'These cards run off the side of the page instead of wrapping. Add wrapping, give each card a `flex` of `1 1 16rem` so it has a sensible target width, and use a `1rem` gap instead of the child margins.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Cards</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards { display: flex; border: 1px solid teal; }
      .cards > div {
        width: 16rem;
        margin-right: 1rem;
        background: #cde;
        padding: 1rem;
      }
    </style>
  </head>
  <body>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
      <div>Focaccia</div>
      <div>Brioche</div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Cards</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards { display: flex; flex-wrap: wrap; gap: 1rem; border: 1px solid teal; }
      .cards > div {
        flex: 1 1 16rem;
        background: #cde;
        padding: 1rem;
      }
    </style>
  </head>
  <body>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
      <div>Focaccia</div>
      <div>Brioche</div>
    </div>
  </body>
</html>', ARRAY['flex-wrap defaults to nowrap, which is why the row overflows.', 'Replace the fixed width with flex: 1 1 16rem — a target size that can flex.', 'Swap the child margin-right for gap on the container.']::text[],
       55, 3,
       (select id from public.skills where slug = 'flexbox'), false
from public.lessons l where l.slug = 'css-flex-sizing'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.cards', 'flex-wrap',
       'wrap', NULL, NULL, NULL,
       'The row wraps', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-wrap-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.cards', 'gap',
       '1rem', NULL, NULL, NULL,
       'Spacing uses gap', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-wrap-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value_matches'::public.requirement_kind, '.cards > div', 'flex',
       '1\s+1\s+16rem', NULL, NULL, NULL,
       'Cards have a flexible 16rem basis', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-wrap-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-flex-sizing'), NULL, 'q-css-flex-1-expands', 1, 'single'::public.question_kind,
        'What does `flex: 1` expand to?', '`flex: 1 1 0%` — grow, shrink, and start from a basis of zero.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`0 1 auto`', false, NULL
from public.quiz_questions where slug = 'q-css-flex-1-expands';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`1 1 0%`', true, NULL
from public.quiz_questions where slug = 'q-css-flex-1-expands';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`1 1 auto`', false, NULL
from public.quiz_questions where slug = 'q-css-flex-1-expands';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`1 0 auto`', false, NULL
from public.quiz_questions where slug = 'q-css-flex-1-expands';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-flex-sizing'), NULL, 'q-css-flex-auto-vs-1', 2, 'single'::public.question_kind,
        'Why do `flex: 1` and `flex: auto` produce different widths?', 'Their bases differ: `1` starts from `0%` so content is ignored; `auto` starts from the content size.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`flex: auto` does not allow growing', false, NULL
from public.quiz_questions where slug = 'q-css-flex-auto-vs-1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'They are identical', false, NULL
from public.quiz_questions where slug = 'q-css-flex-auto-vs-1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`flex: 1` only works in a column', false, NULL
from public.quiz_questions where slug = 'q-css-flex-auto-vs-1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`flex: 1` starts from a 0 basis; `flex: auto` starts from content size', true, NULL
from public.quiz_questions where slug = 'q-css-flex-auto-vs-1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-flex-sizing'), NULL, 'q-css-min-width-zero', 3, 'single'::public.question_kind,
        'A flex row overflows because one item contains a very long URL. What usually fixes it?', 'A flex item will not shrink below its content minimum by default. `min-width: 0` removes that floor.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`min-width: 0` on the flex item', true, NULL
from public.quiz_questions where slug = 'q-css-min-width-zero';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`flex-wrap: nowrap`', false, NULL
from public.quiz_questions where slug = 'q-css-min-width-zero';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`align-items: stretch`', false, NULL
from public.quiz_questions where slug = 'q-css-min-width-zero';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Increasing the gap', false, NULL
from public.quiz_questions where slug = 'q-css-min-width-zero';
-- lesson: Milestone: build a page header
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-flex-milestone', 3, 'Milestone: build a page header', 'Logo left, navigation right, everything aligned', 'The layout every site needs, built with flexbox and no positioning tricks.',
       ARRAY['Build a two-part header with flexbox', 'Space and align items on both axes', 'Make a card row wrap without a media query']::text[], 20, 40, (select id from public.skills where slug = 'flexbox'), 0.8
from public.modules m where m.slug = 'css-flex'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Assemble a real header with flexbox","Use `space-between` and `align-items` correctly","Build a wrapping card row"]}'::jsonb
from public.lessons where slug = 'css-flex-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'Distributing along the main axis', NULL,
       'justify-content values, on the main axis:

flex-start      packed at the start
flex-end        packed at the end
center          packed in the middle
space-between   first at the start, last at the end,
                equal space between
space-around    equal space around each item
space-evenly    equal space everywhere, including the ends', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-flex-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'interactive_demo'::public.block_type, 'A header, three ways of distributing it', 'Same markup, three `justify-content` values.',
       NULL, NULL, NULL, '{"variants":[{"label":"space-between","code":"<style>\n  .header { display: flex; justify-content: space-between; align-items: center; border: 1px solid teal; padding: 1rem; }\n  nav { display: flex; gap: 1rem; }\n</style>\n<div class=\"header\"><strong>Riverside</strong><nav><a href=\"#\">Home</a><a href=\"#\">Menu</a></nav></div>","note":"Logo pinned left, navigation pinned right. This is the header layout almost every site uses."},{"label":"center","code":"<style>\n  .header { display: flex; justify-content: center; align-items: center; gap: 2rem; border: 1px solid teal; padding: 1rem; }\n  nav { display: flex; gap: 1rem; }\n</style>\n<div class=\"header\"><strong>Riverside</strong><nav><a href=\"#\">Home</a><a href=\"#\">Menu</a></nav></div>","note":"Both groups together in the middle. Correct for a centred brand, wrong if you wanted them apart."},{"label":"No alignment","code":"<style>\n  .header { display: flex; justify-content: space-between; align-items: flex-start; border: 1px solid crimson; padding: 1rem; }\n  nav { display: flex; gap: 1rem; }\n  strong { font-size: 2rem; }\n</style>\n<div class=\"header\"><strong>Riverside</strong><nav><a href=\"#\">Home</a><a href=\"#\">Menu</a></nav></div>","note":"With items of different heights and no cross-axis alignment, the links sit at the top rather than on the logo''s centre line."}]}'::jsonb
from public.lessons where slug = 'css-flex-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'recall'::public.block_type, 'From memory', 'From memory: which axis does each of these act on, and what does each `flex` shorthand mean?',
       NULL, NULL, NULL, '{"points":["`justify-content` — the main axis, whichever way `flex-direction` points it.","`align-items` — the cross axis, at right angles to the main axis.","`flex: 1` — `1 1 0%`: equal shares, content size ignored.","`flex: auto` — `1 1 auto`: proportional, starting from content size.","`flex: 0 0 16rem` — exactly 16rem, never grows, never shrinks.","`min-width: 0` — lets an item shrink below its content minimum, fixing most overflow."]}'::jsonb
from public.lessons where slug = 'css-flex-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`space-between` with `align-items: center` is the standard header.","`flex: 1 1 <basis>` with `flex-wrap: wrap` gives responsive columns with no breakpoint.","Nested flex containers are normal — a header is usually a flex row containing a flex nav."],"nextUp":"Next: Grid."}'::jsonb
from public.lessons where slug = 'css-flex-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why is `flex-wrap: wrap` with a basis better than a media query for a card row?"],"points":["Because it responds to the space actually available rather than to the viewport width. The same component then works in a full-width page, in a narrow sidebar, and inside another layout — where a viewport-based breakpoint would give the wrong answer in at least two of those. It is also less code and has no numbers to keep in sync."]}'::jsonb
from public.lessons where slug = 'css-flex-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-flex-milestone-challenge', 1, 'challenge'::public.exercise_kind, 'Build the header and a wrapping card row',
       'Two jobs. Make `.header` a flex row with the logo pinned left, the nav pinned right, and both vertically centred. Make `.nav` itself a flex row with a `1rem` gap. Then make `.cards` a wrapping flex row with a `1rem` gap where each card is `flex: 1 1 16rem`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Header</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .header { border: 1px solid teal; padding: 1rem; }
      .cards { border: 1px solid teal; padding: 1rem; }
      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <header class="header">
      <strong>Riverside</strong>
      <nav class="nav">
        <a href="index.html">Home</a>
        <a href="menu.html">Menu</a>
      </nav>
    </header>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Header</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border: 1px solid teal;
        padding: 1rem;
      }
      .nav { display: flex; gap: 1rem; }

      .cards {
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
        border: 1px solid teal;
        padding: 1rem;
      }
      .cards > div { flex: 1 1 16rem; background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <header class="header">
      <strong>Riverside</strong>
      <nav class="nav">
        <a href="index.html">Home</a>
        <a href="menu.html">Menu</a>
      </nav>
    </header>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
    </div>
  </body>
</html>', ARRAY['Pinning one item left and one right is justify-content: space-between.', 'Vertically centring on a row is align-items: center.', 'The nav is itself a flex container, with gap for the link spacing.', 'The card row needs flex-wrap: wrap and each card flex: 1 1 16rem.']::text[],
       70, 4,
       (select id from public.skills where slug = 'flexbox'), false
from public.lessons l where l.slug = 'css-flex-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.header', 'display',
       'flex', NULL, NULL, NULL,
       'The header is a flex row', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.header', 'justify-content',
       'space-between', NULL, NULL, NULL,
       'Logo and nav are pushed apart', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.header', 'align-items',
       'center', NULL, NULL, NULL,
       'They are vertically centred', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, '.nav', 'display',
       'flex', NULL, NULL, NULL,
       'The nav is a flex row', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value'::public.requirement_kind, '.nav', 'gap',
       '1rem', NULL, NULL, NULL,
       'The nav links are spaced with gap', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'css_value'::public.requirement_kind, '.cards', 'flex-wrap',
       'wrap', NULL, NULL, NULL,
       'The card row wraps', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 7, 'css_value_matches'::public.requirement_kind, '.cards > div', 'flex',
       '1\s+1\s+16rem', NULL, NULL, NULL,
       'Cards use a flexible 16rem basis', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-flex-milestone-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-flex-milestone'), NULL, 'q-css-space-between', 1, 'single'::public.question_kind,
        'What does `justify-content: space-between` do with two items?', 'Pins the first to the start and the last to the end, with all the space between them.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Adds equal space including at the ends', false, NULL
from public.quiz_questions where slug = 'q-css-space-between';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Pins one to each end', true, NULL
from public.quiz_questions where slug = 'q-css-space-between';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Centres both with equal space around', false, NULL
from public.quiz_questions where slug = 'q-css-space-between';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Stacks them vertically', false, NULL
from public.quiz_questions where slug = 'q-css-space-between';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-flex-milestone'), NULL, 'q-css-nested-flex', 2, 'single'::public.question_kind,
        'Can a flex item itself be a flex container?', 'Yes, and it is normal — a header is usually a flex row whose nav child is another flex row.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'No, flex containers cannot nest', false, NULL
from public.quiz_questions where slug = 'q-css-nested-flex';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Only if the directions differ', false, NULL
from public.quiz_questions where slug = 'q-css-nested-flex';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only with `display: inline-flex`', false, NULL
from public.quiz_questions where slug = 'q-css-nested-flex';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Yes, and it is a common pattern', true, NULL
from public.quiz_questions where slug = 'q-css-nested-flex';
-- Level 4 milestone: Flexbox questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-4-milestone'), 'a-css-4-axes-swap', 1, 'single'::public.question_kind,
        'With `flex-direction: column`, `align-items: center` aligns items how?', 'On the cross axis, which is now horizontal — so it centres them left to right.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Horizontally', true, NULL
from public.quiz_questions where slug = 'a-css-4-axes-swap';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Vertically', false, NULL
from public.quiz_questions where slug = 'a-css-4-axes-swap';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Both ways', false, NULL
from public.quiz_questions where slug = 'a-css-4-axes-swap';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Not at all', false, NULL
from public.quiz_questions where slug = 'a-css-4-axes-swap';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-4-milestone'), 'a-css-4-equal-columns', 2, 'single'::public.question_kind,
        'Which makes three flex children exactly equal in width regardless of content?', '`flex: 1` uses a basis of 0, so content size is ignored.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`flex: auto`', false, NULL
from public.quiz_questions where slug = 'a-css-4-equal-columns';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`flex: none`', false, NULL
from public.quiz_questions where slug = 'a-css-4-equal-columns';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`align-items: stretch`', false, NULL
from public.quiz_questions where slug = 'a-css-4-equal-columns';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`flex: 1`', true, NULL
from public.quiz_questions where slug = 'a-css-4-equal-columns';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-4-milestone'), 'a-css-4-fixed-item', 3, 'single'::public.question_kind,
        'How do you make a sidebar exactly 16rem and stop it shrinking?', 'Grow 0, shrink 0, basis 16rem.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`flex-basis: 16rem`', false, NULL
from public.quiz_questions where slug = 'a-css-4-fixed-item';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`flex: 0 0 16rem`', true, NULL
from public.quiz_questions where slug = 'a-css-4-fixed-item';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`flex: 1 1 16rem`', false, NULL
from public.quiz_questions where slug = 'a-css-4-fixed-item';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`width: 16rem`', false, NULL
from public.quiz_questions where slug = 'a-css-4-fixed-item';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-4-milestone'), 'a-css-4-wrap-default', 4, 'single'::public.question_kind,
        'What is the default value of `flex-wrap`?', '`nowrap`, which is why a flex row can overflow its container.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`wrap`', false, NULL
from public.quiz_questions where slug = 'a-css-4-wrap-default';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`wrap-reverse`', false, NULL
from public.quiz_questions where slug = 'a-css-4-wrap-default';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It depends on the direction', false, NULL
from public.quiz_questions where slug = 'a-css-4-wrap-default';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`nowrap`', true, NULL
from public.quiz_questions where slug = 'a-css-4-wrap-default';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-4-milestone'), 'a-css-4-equal-heights', 5, 'single'::public.question_kind,
        'Why do flex children end up the same height without any extra CSS?', '`align-items` defaults to `stretch`, filling the cross axis.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`align-items` defaults to `stretch`', true, NULL
from public.quiz_questions where slug = 'a-css-4-equal-heights';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Because of `justify-content`', false, NULL
from public.quiz_questions where slug = 'a-css-4-equal-heights';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Flexbox forces equal heights always', false, NULL
from public.quiz_questions where slug = 'a-css-4-equal-heights';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Because of `gap`', false, NULL
from public.quiz_questions where slug = 'a-css-4-equal-heights';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-4-milestone'), 'a-css-4-overflow-cause', 6, 'single'::public.question_kind,
        'What is the usual cause of a flex layout overflowing horizontally?', 'A flex item will not shrink below its content minimum size unless `min-width: 0` allows it.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A gap that is too large', false, NULL
from public.quiz_questions where slug = 'a-css-4-overflow-cause';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`align-items: center`', false, NULL
from public.quiz_questions where slug = 'a-css-4-overflow-cause';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Too many children', false, NULL
from public.quiz_questions where slug = 'a-css-4-overflow-cause';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'An item refusing to shrink below its content minimum', true, NULL
from public.quiz_questions where slug = 'a-css-4-overflow-cause';
-- --------------------------------------------------------------------------
-- CSS Architect — Level 5: Grid
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'css-grid', 5, 'Grid', 'Two dimensions, named areas, and layouts that need no breakpoints',
       'Grid lays out rows and columns at once. It also contains the single most useful line in modern CSS — a responsive layout in one declaration, with no media query at all.', 'You can build any two-dimensional layout and make it responsive without a breakpoint.', 'violet'
from public.courses c where c.slug = 'css-architect'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'css-level-5-milestone', 'milestone'::public.assessment_kind, 'Level 5 milestone: Grid', 'Six questions on tracks, areas and responsive grids. Pass mark 75%.',
       0.75, 180, 5
from public.levels l where l.slug = 'css-grid'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Grid
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'css-grid-module', 1, 'Grid', 'Tracks, the fr unit, named areas, and intrinsically responsive layouts.',
       60, false
from public.levels l where l.slug = 'css-grid'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'css-grid-module' and p.slug = 'css-flex';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'css-grid-module' and s.slug = 'grid';
-- lesson: Tracks and the `fr` unit
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-grid-tracks', 1, 'Tracks and the `fr` unit', 'Defining columns, and the unit that only exists in grid', 'A grid is columns and rows you declare up front. One new unit does most of the work.',
       ARRAY['Define explicit columns and rows', 'Explain what `fr` measures', 'Use `gap` and `repeat()`']::text[], 16, 40, (select id from public.skills where slug = 'grid'), 0.7
from public.modules m where m.slug = 'css-grid-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A grid has `grid-template-columns: 200px 1fr 1fr` and a `2rem` gap. The container is 1000px wide. How wide is each `1fr` column?',
       NULL, NULL, NULL, '{"options":["About 368px — the gap is subtracted first, then the rest is split","400px — half of the remaining 800px","333px — a third of 1000px","266px — a third of the remaining 800px"],"answer":"About 368px. `fr` distributes what is *left over* after fixed tracks and every gap have been taken out: 1000 − 200 (the fixed column) − 64 (two 2rem gaps) = 736, split in two. This is why `fr` behaves so well in practice — it never causes the overflow that percentages do, because percentages are computed before gaps are subtracted and then push the layout wider."}'::jsonb
from public.lessons where slug = 'css-grid-tracks';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Declare explicit column and row tracks","Use `fr` to distribute leftover space","Shorten repeated tracks with `repeat()`"]}'::jsonb
from public.lessons where slug = 'css-grid-tracks';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Track', 'A column or a row. `grid-template-columns` declares the column tracks; `grid-template-rows` declares the row tracks.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-grid-tracks';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, '`fr`', 'A fraction of the *leftover* space, after fixed tracks and gaps are accounted for. It exists only in grid, and it is why grid layouts rarely overflow.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-grid-tracks';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'Declaring a grid', NULL,
       'display: grid;
grid-template-columns: 200px 1fr 1fr;   three columns
grid-template-columns: repeat(3, 1fr);  the same as 1fr 1fr 1fr
grid-template-rows: auto 1fr auto;      header, filling body, footer
gap: 1rem;                              between every track
column-gap / row-gap                    if they differ

Values a track can take:
  200px, 20%      fixed
  auto            as big as its content needs
  1fr             a share of the leftover space
  minmax(a, b)    at least a, at most b
  min-content     the smallest it can be without overflowing
  max-content     as wide as it wants to be', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-grid-tracks';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'interactive_demo'::public.block_type, 'The same six items, three track definitions', 'Only `grid-template-columns` changes.',
       NULL, NULL, NULL, '{"variants":[{"label":"Three equal columns","code":"<style>\n  .grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 0.5rem; border: 1px solid teal; padding: 0.5rem; }\n  .grid > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class=\"grid\"><div>1</div><div>2</div><div>3</div><div>4</div><div>5</div><div>6</div></div>","note":"Six items flow into three columns, creating two rows automatically. You never declared the rows."},{"label":"Sidebar and content","code":"<style>\n  .grid { display: grid; grid-template-columns: 12rem 1fr; gap: 0.5rem; border: 1px solid teal; padding: 0.5rem; }\n  .grid > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class=\"grid\"><div>Nav</div><div>Content</div><div>Nav</div><div>Content</div></div>","note":"A fixed track and a filling one. The `1fr` takes whatever is left after the 12rem and the gap."},{"label":"Unequal fractions","code":"<style>\n  .grid { display: grid; grid-template-columns: 2fr 1fr; gap: 0.5rem; border: 1px solid teal; padding: 0.5rem; }\n  .grid > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class=\"grid\"><div>Two thirds</div><div>One third</div></div>","note":"`fr` values are relative to each other — 2fr and 1fr means two thirds and one third of the leftover space."}]}'::jsonb
from public.lessons where slug = 'css-grid-tracks';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'term'::public.block_type, 'Implicit tracks', 'Rows (or columns) grid creates automatically for items beyond the tracks you declared. `grid-auto-rows` controls their size.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-grid-tracks';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'predict_check'::public.block_type, 'Predict, then check', 'Three columns are declared and five items are supplied. Before you check: what happens to items 4 and 5 — do they overflow, shrink, or something else?',
       '<style>
  .grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1rem;
  }
</style>
<div class="grid">
  <div>1</div><div>2</div><div>3</div>
  <div>4</div><div>5</div>
</div>', 'html', NULL, '{"outcome":"Grid creates a second row automatically and places them in the first two cells of it, leaving the third empty. These are **implicit** rows: you declared three columns and grid worked out how many rows it needed. This is the everyday behaviour that makes grid so comfortable for card layouts — you say how many columns you want and the number of rows takes care of itself. `grid-auto-rows` controls how tall those automatic rows are if the default of `auto` is not what you want."}'::jsonb
from public.lessons where slug = 'css-grid-tracks';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'callout'::public.block_type, 'Prefer `fr` to percentages', 'Three columns of `33.33%` plus two `1rem` gaps overflows, because the percentages are computed from the full width and the gaps are then added on top. `repeat(3, 1fr)` cannot overflow, because `fr` is defined as a share of what is *left* after the gaps. The same argument applies to `minmax()` over fixed widths.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-grid-tracks';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`display: grid` plus `grid-template-columns` defines the columns.","`fr` distributes leftover space after fixed tracks and gaps.","`repeat(n, …)` shortens repeated track definitions.","Items beyond the declared tracks create implicit rows automatically."],"nextUp":"Next: placing items, and responsive grids with no breakpoints."}'::jsonb
from public.lessons where slug = 'css-grid-tracks';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What does `1fr` actually measure?","Why does `repeat(3, 1fr)` never overflow where `33.33%` does?","What happens to a seventh item in a three-column grid?"],"points":["A share of the space left over after fixed tracks and all gaps have been subtracted.","Because `fr` is defined *after* gaps are taken out, whereas percentages are computed from the full container width and the gaps are then added on top, pushing the total past 100%.","Grid creates an implicit third row and places it in the first cell. You declared columns; the rows follow automatically."]}'::jsonb
from public.lessons where slug = 'css-grid-tracks';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-grid-tracks-guided', 1, 'guided'::public.exercise_kind, 'Three columns and a gap',
       'Make `.grid` a three-column grid using `repeat()` and `fr`, with a `1rem` gap. Do not use percentages.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Grid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .grid { border: 1px solid teal; padding: 1rem; }
      .grid > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="grid">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
      <div>Focaccia</div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Grid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 1rem;
        border: 1px solid teal;
        padding: 1rem;
      }
      .grid > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="grid">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
      <div>Focaccia</div>
    </div>
  </body>
</html>', ARRAY['display: grid comes first.', 'repeat(3, 1fr) is the same as writing 1fr 1fr 1fr.', 'gap applies between both rows and columns.']::text[],
       40, 2,
       (select id from public.skills where slug = 'grid'), false
from public.lessons l where l.slug = 'css-grid-tracks'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.grid', 'display',
       'grid', NULL, NULL, NULL,
       'The container is a grid', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-tracks-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value_matches'::public.requirement_kind, '.grid', 'grid-template-columns',
       'repeat\(3,\s*1fr\)', NULL, NULL, NULL,
       'Three equal columns using repeat and fr', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-tracks-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.grid', 'gap',
       '1rem', NULL, NULL, NULL,
       'There is a 1rem gap', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-tracks-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-grid-tracks'), NULL, 'q-css-fr-meaning', 1, 'single'::public.question_kind,
        'What does `1fr` distribute?', 'The space left over after fixed tracks and all gaps are subtracted.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A percentage of the container', false, NULL
from public.quiz_questions where slug = 'q-css-fr-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The content width of the largest item', false, NULL
from public.quiz_questions where slug = 'q-css-fr-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Leftover space, after fixed tracks and gaps', true, NULL
from public.quiz_questions where slug = 'q-css-fr-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A fixed fraction of the viewport', false, NULL
from public.quiz_questions where slug = 'q-css-fr-meaning';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-grid-tracks'), NULL, 'q-css-implicit-rows', 2, 'single'::public.question_kind,
        'Five items in a grid with three declared columns. What happens?', 'Grid creates an implicit second row and places the remaining items in it.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;

commit;
