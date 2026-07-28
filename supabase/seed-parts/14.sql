-- HTML Hero — course seed, part 14 of 16
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 13 first.

begin;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A second class on the element, styled by its own one-class rule', true, NULL
from public.quiz_questions where slug = 'q-css-variant-class';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A chained selector such as `.card.featured`', false, NULL
from public.quiz_questions where slug = 'q-css-variant-class';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-architecture-milestone'), NULL, 'q-css-arch-goal', 2, 'single'::public.question_kind,
        'What is the practical goal of a CSS architecture?', 'That overriding stays possible and deleting stays provably safe — the two things that fail at scale.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Overriding stays possible and deleting stays provably safe', true, NULL
from public.quiz_questions where slug = 'q-css-arch-goal';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The smallest possible file', false, NULL
from public.quiz_questions where slug = 'q-css-arch-goal';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The fewest possible classes', false, NULL
from public.quiz_questions where slug = 'q-css-arch-goal';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Matching the designer’s folder structure', false, NULL
from public.quiz_questions where slug = 'q-css-arch-goal';
-- Level 10 milestone: Architecture and Scale questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-10-milestone'), 'a-css-10-important', 1, 'single'::public.question_kind,
        'A rule will not override. What is usually the right fix?', 'Lower the specificity of the rule that was too strong.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Add an id to the selector', false, NULL
from public.quiz_questions where slug = 'a-css-10-important';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Move the rule to the end of the file', false, NULL
from public.quiz_questions where slug = 'a-css-10-important';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Lower the specificity of the rule that was too strong', true, NULL
from public.quiz_questions where slug = 'a-css-10-important';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Add `!important`', false, NULL
from public.quiz_questions where slug = 'a-css-10-important';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-10-milestone'), 'a-css-10-layer-beats', 2, 'single'::public.question_kind,
        'A one-class rule in `utilities` versus an id rule in `components`, with utilities declared last. Which wins?', 'The utility. Layer order is consulted before specificity.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The id rule, because ids are stronger', false, NULL
from public.quiz_questions where slug = 'a-css-10-layer-beats';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Whichever appears later in the file', false, NULL
from public.quiz_questions where slug = 'a-css-10-layer-beats';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Neither; the conflict is an error', false, NULL
from public.quiz_questions where slug = 'a-css-10-layer-beats';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The one-class rule in `utilities`', true, NULL
from public.quiz_questions where slug = 'a-css-10-layer-beats';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-10-milestone'), 'a-css-10-where', 3, 'single'::public.question_kind,
        'What does `:where()` contribute to specificity?', 'Zero, always.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The same as its most specific argument', false, NULL
from public.quiz_questions where slug = 'a-css-10-where';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Zero', true, NULL
from public.quiz_questions where slug = 'a-css-10-where';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'One class', false, NULL
from public.quiz_questions where slug = 'a-css-10-where';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'One id', false, NULL
from public.quiz_questions where slug = 'a-css-10-where';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-10-milestone'), 'a-css-10-prefix', 4, 'single'::public.question_kind,
        'Why give each component a unique class prefix?', 'So its use can be proved by searching, which makes deletion safe.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'To raise its specificity', false, NULL
from public.quiz_questions where slug = 'a-css-10-prefix';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Because CSS requires unique names', false, NULL
from public.quiz_questions where slug = 'a-css-10-prefix';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'So you can prove where it is used, and delete it safely', true, NULL
from public.quiz_questions where slug = 'a-css-10-prefix';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'To reduce file size', false, NULL
from public.quiz_questions where slug = 'a-css-10-prefix';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-10-milestone'), 'a-css-10-shared-selector', 5, 'single'::public.question_kind,
        'What is the problem with a shared `.card, .panel` selector?', 'It couples two components invisibly, so neither can be deleted locally.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Only one of the two will match', false, NULL
from public.quiz_questions where slug = 'a-css-10-shared-selector';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It couples the two components, so neither can be changed alone', true, NULL
from public.quiz_questions where slug = 'a-css-10-shared-selector';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Comma selectors are slower', false, NULL
from public.quiz_questions where slug = 'a-css-10-shared-selector';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It doubles the specificity', false, NULL
from public.quiz_questions where slug = 'a-css-10-shared-selector';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-10-milestone'), 'a-css-10-name-role', 6, 'single'::public.question_kind,
        'Why name a modifier after its role rather than its appearance?', 'The name has to stay true after a redesign.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The name stays true when the design changes', true, NULL
from public.quiz_questions where slug = 'a-css-10-name-role';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Role names are shorter', false, NULL
from public.quiz_questions where slug = 'a-css-10-name-role';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Appearance names are invalid', false, NULL
from public.quiz_questions where slug = 'a-css-10-name-role';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It changes the specificity', false, NULL
from public.quiz_questions where slug = 'a-css-10-name-role';
-- --------------------------------------------------------------------------
-- CSS Architect — Level 11: Debugging CSS
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'css-debugging-level', 11, 'Debugging CSS', 'Why it is not working, in order of likelihood',
       'Almost every "my CSS is not working" is one of a short list of causes. Checking them in order — with the inspector rather than by rereading the file — turns an hour of guessing into a couple of minutes.', 'You can diagnose a rule that did not apply by reading computed values rather than by guessing.', 'violet'
from public.courses c where c.slug = 'css-architect'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'css-level-11-milestone', 'milestone'::public.assessment_kind, 'Level 11 milestone: Debugging CSS', 'Six questions on the inspector and the diagnostic order. Pass mark 75%.',
       0.75, 190, 11
from public.levels l where l.slug = 'css-debugging-level'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Finding out why
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'css-debugging-module', 1, 'Finding out why', 'The inspector, computed values, and the six usual causes.',
       52, false
from public.levels l where l.slug = 'css-debugging-level'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'css-debugging-module' and p.slug = 'css-architecture-module';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'css-debugging-module' and s.slug = 'css-debugging';
-- lesson: Reading the inspector
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-inspector', 1, 'Reading the inspector', 'Computed values answer the question the file cannot', 'The styles panel shows what you wrote. The computed panel shows what the browser decided. When those disagree, the second one is the fact.',
       ARRAY['Read the computed value of a property', 'Recognise a struck-through declaration and say why', 'Use the box model diagram to explain a size']::text[], 16, 40, (select id from public.skills where slug = 'css-debugging'), 0.7
from public.modules m where m.slug = 'css-debugging-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A declaration appears struck through in the styles panel. What does that mean?',
       NULL, NULL, NULL, '{"options":["It did not win — something overrode it, or the value is invalid","It is a comment","It has not loaded yet","It applies only on hover"],"answer":"It lost, or it was never valid. The browser is telling you the exact thing you would otherwise spend twenty minutes guessing at: this declaration is not in effect. Hovering the rule above it shows what beat it, and if nothing did, the value itself was rejected — a misspelled property, a missing unit, or a `var()` that resolved to nothing."}'::jsonb
from public.lessons where slug = 'css-inspector';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Find the computed value of any property","Explain a struck-through declaration","Read the box model diagram"]}'::jsonb
from public.lessons where slug = 'css-inspector';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Computed value', 'What the browser actually resolved a property to for this element, after the cascade, inheritance and every relative unit.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-inspector';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'What each part is for', NULL,
       'Styles panel     what you wrote, in cascade order
                 struck through = did not win, or invalid
Computed panel   what the browser decided — the fact
Box model        content, padding, border, margin, measured
:hov             force a state so you can inspect it
Filter box       type a property name to find who set it', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-inspector';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'Two ways to answer "why is this not red"', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Read the computed value","code":"Computed → color: rgb(0, 128, 128)\nClick the arrow → set by .card, line 12","why":"One answer, with the winning rule named. There is nothing left to guess at."},"bad":{"label":"Reread the stylesheet","code":"/* scrolling through 400 lines\n   looking for something that might\n   be overriding it */","why":"Slow, and it cannot find the causes that are not in the file at all — an inherited value, a browser default, or a rule from a stylesheet you forgot was loaded."}}'::jsonb
from public.lessons where slug = 'css-inspector';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'progressive_detail'::public.block_type, 'Force a state to inspect it', 'A hover or focus style cannot be inspected while you are moving the pointer to the panel. The `:hov` toggle pins the state on, so `:hover`, `:focus`, `:focus-visible` and `:active` styles can be read like any other. This is the only practical way to debug a focus ring, and it is the reason focus styles are so often broken — people cannot see them while they work.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-inspector';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'interactive_demo'::public.block_type, 'What the computed value tells you', 'Three cases, one method.',
       NULL, NULL, NULL, '{"variants":[{"label":"Overridden","code":"<style>\n  .note { color: crimson; }\n  .card p { color: teal; }\n</style>\n<div class=\"card\"><p class=\"note\">Computed colour is teal — `.card p` is 0-1-1 and beats `.note` at 0-1-0.</p></div>","note":"The styles panel would show `color: crimson` struck through."},{"label":"Invalid value","code":"<style>\n  .note { color: teal; padding: 10; }\n</style>\n<p class=\"note\">The padding is dropped entirely — 10 has no unit, so the declaration is invalid.</p>","note":"Struck through with no override anywhere. That combination always means the value was rejected."},{"label":"Never matched","code":"<style>\n  .notes { color: crimson; }\n</style>\n<p class=\"note\">The rule says `.notes`; the element is `.note`. Nothing is struck through, because the rule was never in the running.</p>","note":"The tell is the rule not appearing in the styles panel at all — the most commonly missed diagnosis, because there is nothing to see."}]}'::jsonb
from public.lessons where slug = 'css-inspector';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'predict_check'::public.block_type, 'Predict, then check', 'No `box-sizing` is set here. Before you check: what total width does the box model diagram report?',
       '<style>
  .box { width: 200px; padding: 20px; border: 5px solid teal; }
</style>
<div class="box">Measured</div>', 'html', NULL, '{"outcome":"250px — 200 of content, plus 20 of padding and 5 of border on each side. Under the default `content-box`, `width` sizes the content alone and everything else is added on top. The box model diagram in the inspector shows all four rings with their measured numbers, which settles this in a glance rather than by arithmetic."}'::jsonb
from public.lessons where slug = 'css-inspector';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["The styles panel shows what you wrote; the computed panel shows what won.","Struck through means overridden, or invalid.","A rule that is missing entirely never matched at all.","Force a state with `:hov` to inspect hover and focus styles."],"nextUp":"Next: the six usual causes."}'::jsonb
from public.lessons where slug = 'css-inspector';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["A declaration is struck through and nothing above it sets that property. What happened?","What does it mean when a rule you expected does not appear in the styles panel?","Why is the computed panel more trustworthy than the file?"],"points":["The value was invalid, so the browser dropped the declaration. A missing unit, a misspelled property, or a `var()` that resolved to nothing.","It never matched the element — usually a typo in the selector, or the element does not have the class you think it does. Nothing is struck through because the rule was never a candidate.","Because it reports what the browser decided after the cascade, inheritance, relative units and defaults. The file only shows what you wrote, and cannot show the causes that are not in it."]}'::jsonb
from public.lessons where slug = 'css-inspector';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-invalid-debug', 1, 'debug'::public.exercise_kind, 'Three declarations that never applied',
       'Each fault is one the inspector would show you. `padding: 10` has no unit, so it is invalid — make it `10px`. `colour` is not a CSS property — it is spelled `color`. And the rule targets `.notes` while the element is `.note` — fix the selector.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Invalid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .note { padding: 10; }
      .note { colour: teal; }
      .notes { border-left: 3px solid teal; }
    </style>
  </head>
  <body>
    <p class="note">Nothing here applies.</p>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Invalid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .note { padding: 10px; }
      .note { color: teal; }
      .note { border-left: 3px solid teal; }
    </style>
  </head>
  <body>
    <p class="note">Nothing here applies.</p>
  </body>
</html>', ARRAY['A length needs a unit — a bare number is invalid except for zero.', 'CSS uses the American spelling.', 'Check the class in the markup against the class in the selector.']::text[],
       50, 2,
       (select id from public.skills where slug = 'css-debugging'), false
from public.lessons l where l.slug = 'css-inspector'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.note', 'padding',
       '10px', NULL, NULL, NULL,
       'The padding now has a unit and applies', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-invalid-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.note', 'color',
       'teal', NULL, NULL, NULL,
       'The property name is spelled as CSS spells it', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-invalid-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.note', 'border-left',
       '3px solid teal', NULL, NULL, NULL,
       'The selector matches the element', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-invalid-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-inspector'), NULL, 'q-css-struck-through', 1, 'single'::public.question_kind,
        'A declaration is struck through in the styles panel. What are the two possible causes?', 'Something overrode it, or the value was invalid.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The file has not loaded', false, NULL
from public.quiz_questions where slug = 'q-css-struck-through';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It applies only in print', false, NULL
from public.quiz_questions where slug = 'q-css-struck-through';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It was overridden, or the value is invalid', true, NULL
from public.quiz_questions where slug = 'q-css-struck-through';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is commented out or misspelled', false, NULL
from public.quiz_questions where slug = 'q-css-struck-through';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-inspector'), NULL, 'q-css-computed-panel', 2, 'single'::public.question_kind,
        'What does the computed panel show?', 'What the browser resolved, after cascade, inheritance and units.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The most specific selector', false, NULL
from public.quiz_questions where slug = 'q-css-computed-panel';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The browser default', false, NULL
from public.quiz_questions where slug = 'q-css-computed-panel';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The value the browser actually resolved', true, NULL
from public.quiz_questions where slug = 'q-css-computed-panel';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The last declaration in the file', false, NULL
from public.quiz_questions where slug = 'q-css-computed-panel';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-inspector'), NULL, 'q-css-missing-rule', 3, 'single'::public.question_kind,
        'Your rule does not appear in the styles panel at all. What does that indicate?', 'It never matched the element.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It was overridden', false, NULL
from public.quiz_questions where slug = 'q-css-missing-rule';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The value was invalid', false, NULL
from public.quiz_questions where slug = 'q-css-missing-rule';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is inside a media query', false, NULL
from public.quiz_questions where slug = 'q-css-missing-rule';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The selector never matched', true, NULL
from public.quiz_questions where slug = 'q-css-missing-rule';
-- lesson: The six usual causes
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-diagnosis', 2, 'The six usual causes', 'A checklist that beats staring at the file', 'Working through the list in order finds the cause faster than any amount of rereading, because each step rules out a whole category.',
       ARRAY['Apply the diagnostic list in order', 'Distinguish "did not match" from "did not win"', 'Recognise the causes that are not in the file']::text[], 18, 40, (select id from public.skills where slug = 'css-debugging'), 0.7
from public.modules m where m.slug = 'css-debugging-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'What is the first thing to check when a rule seems not to apply?',
       NULL, NULL, NULL, '{"options":["Whether it matched the element at all","Whether the browser supports the property","Whether the file is cached","Whether the value needs a prefix"],"answer":"Whether it matched. It costs one glance at the styles panel and eliminates the largest category outright — typos in the selector, a class that is not on the element, a rule in the wrong block. Checking support or caching first means investigating rare causes before common ones, which is how debugging sessions turn into afternoons."}'::jsonb
from public.lessons where slug = 'css-diagnosis';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Work the list in order","Name the six causes","Explain why order matters in diagnosis"]}'::jsonb
from public.lessons where slug = 'css-diagnosis';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'worked_example'::public.block_type, 'The list, in order', 'Each step eliminates a category, so the order is the method.',
       NULL, NULL, NULL, '{"steps":[{"title":"1. Did it match?","code":"/* Rule absent from the styles panel entirely. */\n.notes { color: teal }   /* element is class=\"note\" */","reasoning":"The biggest category and the cheapest to check. A typo in the selector, a class that is not on the element, or a rule that ended up inside a media query that is not active."},{"title":"2. Did it win?","code":"/* Struck through, with a stronger rule above it. */\n.note { color: crimson }\n.card p { color: teal }   /* 0-1-1 beats 0-1-0 */","reasoning":"Specificity or source order. The panel names the winner, so this is a read rather than a deduction."},{"title":"3. Was the value valid?","code":"padding: 10;        /* no unit */\ncolour: teal;       /* not a property */\ncolor: var(--nope); /* resolves to nothing */","reasoning":"Struck through with nothing overriding it. The browser dropped the declaration and said nothing — the third case is the nastiest, because the syntax is perfect."},{"title":"4. Does the property apply to that element?","code":"span { width: 200px }   /* inline: ignored */\n.parent { gap: 1rem }   /* not flex or grid: ignored */","reasoning":"A valid declaration on an element it means nothing for. `width` on an inline element and `gap` without a flex or grid container are the two that catch nearly everyone."},{"title":"5. Is something else in play?","code":"/* inherited value, browser default,\n   a reset, or a rule from another sheet */","reasoning":"The causes that are not in your file. The computed panel finds them because it reports the source of the winning value wherever it came from."},{"title":"6. Is it the element you think it is?","code":"/* the padding is on the wrapper,\n   the border is on the child */","reasoning":"Last because it is the least common and the hardest to see. Select the element in the inspector rather than assuming, and the box model diagram settles it."}]}'::jsonb
from public.lessons where slug = 'css-diagnosis';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'interactive_demo'::public.block_type, 'Causes four and six, seen', 'Both look like the CSS is being ignored.',
       NULL, NULL, NULL, '{"variants":[{"label":"Property does not apply","code":"<style>\n  .tag { width: 200px; background: #eee; }\n</style>\n<span class=\"tag\">width does nothing on an inline element</span>","note":"Perfectly valid CSS, silently doing nothing. `display: inline-block` would make it take effect."},{"label":"Fixed","code":"<style>\n  .tag { display: inline-block; width: 200px; background: #eee; }\n</style>\n<span class=\"tag\">Now it is 200px</span>","note":"The declaration was never the problem — the display type was."},{"label":"Wrong element","code":"<style>\n  .wrapper { padding: 2rem; background: #eee; }\n  .card { background: #fff; }\n</style>\n<div class=\"wrapper\"><div class=\"card\">The padding people go looking for on .card is on .wrapper</div></div>","note":"Selecting the element in the inspector rather than assuming which one it is takes a second and settles it."}]}'::jsonb
from public.lessons where slug = 'css-diagnosis';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'When you are truly stuck, bisect', 'Comment out half the stylesheet. If the problem disappears, it was in that half; if not, it was in the other. Six or seven halvings locate the cause in a 400-line file with certainty, and it works even when you have no theory at all — which is exactly the situation where rereading is least effective.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-diagnosis';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'self_explain'::public.block_type, 'Explain it in your own words', 'Why does working the list in order beat checking whatever you suspect first?',
       NULL, NULL, NULL, '{"modelAnswer":"Because your suspicion is shaped by what you were last working on, not by what is actually most likely — so it sends you to a rare cause while the common one goes unchecked. The order is not arbitrary either: each step eliminates a whole category, and the early steps are the cheapest to perform as well as the most likely to hit. Checking \"did it match\" costs one glance and rules out more cases than everything below it combined. There is also a discipline benefit: a fixed order means you cannot check the same thing three times and skip the step that would have found it, which is the actual shape of most long debugging sessions."}'::jsonb
from public.lessons where slug = 'css-diagnosis';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'checklist'::public.block_type, 'When a rule is not applying', NULL,
       NULL, NULL, NULL, '{"items":["Did it match? — the rule appears in the styles panel","Did it win? — not struck through","Was the value valid? — struck through with nothing overriding it","Does the property apply to this element? — inline, or not a flex container","Is something else in play? — inheritance, a default, another sheet","Is it the element you think it is? — select it and read the box model"]}'::jsonb
from public.lessons where slug = 'css-diagnosis';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Six causes account for nearly every case.","Check them in order; each step eliminates a category.","Valid CSS on the wrong kind of element does nothing, silently.","Bisect when you have no theory at all."],"nextUp":"Next: the Level 11 milestone."}'::jsonb
from public.lessons where slug = 'css-diagnosis';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What is the difference between \"did not match\" and \"did not win\", and how do you tell them apart?","Which two properties most often fail because they do not apply to the element?","When is bisecting the right tool?"],"points":["A rule that did not match was never a candidate, so it is absent from the styles panel entirely. One that did not win is present but struck through, with the winner shown above it. The panel distinguishes them at a glance — absent versus struck through.","`width` and `height` on an inline element, and `gap` on a container that is not flex or grid. Both are valid CSS that silently does nothing.","When you have no theory. Halving the stylesheet finds the cause by elimination rather than by insight, which is exactly what you lack at that point."]}'::jsonb
from public.lessons where slug = 'css-diagnosis';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-applies-debug', 1, 'debug'::public.exercise_kind, 'Valid CSS that does nothing',
       'Two faults from cause four. `.tag` sets a width on an inline element — add `display: inline-block` so the width takes effect. And `.row` sets `gap` without being a flex container — add `display: flex`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Applies</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .tag { width: 200px; background: #eee; }
      .row { gap: 1rem; }
    </style>
  </head>
  <body>
    <span class="tag">Tag</span>
    <div class="row"><div>One</div><div>Two</div></div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Applies</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .tag { display: inline-block; width: 200px; background: #eee; }
      .row { display: flex; gap: 1rem; }
    </style>
  </head>
  <body>
    <span class="tag">Tag</span>
    <div class="row"><div>One</div><div>Two</div></div>
  </body>
</html>', ARRAY['An inline element ignores width and height.', 'gap only means something inside a flex or grid container.', 'Neither declaration was wrong — the display type was.']::text[],
       55, 3,
       (select id from public.skills where slug = 'css-debugging'), false
from public.lessons l where l.slug = 'css-diagnosis'
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
       'The tag can now take a width', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-applies-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.tag', 'width',
       '200px', NULL, NULL, NULL,
       'The width is kept', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-applies-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.row', 'display',
       'flex', NULL, NULL, NULL,
       'The row is a flex container, so gap applies', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-applies-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, '.row', 'gap',
       '1rem', NULL, NULL, NULL,
       'The gap is kept', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-applies-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-diagnosis'), NULL, 'q-css-first-check', 1, 'single'::public.question_kind,
        'What is the first check when a rule seems not to apply?', 'Whether it matched at all — the largest and cheapest category to eliminate.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Whether the browser supports it', false, NULL
from public.quiz_questions where slug = 'q-css-first-check';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Whether the file is cached', false, NULL
from public.quiz_questions where slug = 'q-css-first-check';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Whether it needs a vendor prefix', false, NULL
from public.quiz_questions where slug = 'q-css-first-check';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Whether it matched the element', true, NULL
from public.quiz_questions where slug = 'q-css-first-check';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-diagnosis'), NULL, 'q-css-inline-width', 2, 'single'::public.question_kind,
        'Why does `width` do nothing on a `<span>`?', 'An inline element ignores width and height.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Inline elements ignore width and height', true, NULL
from public.quiz_questions where slug = 'q-css-inline-width';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The value is invalid', false, NULL
from public.quiz_questions where slug = 'q-css-inline-width';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Spans cannot be styled', false, NULL
from public.quiz_questions where slug = 'q-css-inline-width';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It needs `!important`', false, NULL
from public.quiz_questions where slug = 'q-css-inline-width';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-diagnosis'), NULL, 'q-css-bisect', 3, 'single'::public.question_kind,
        'When is bisecting the stylesheet the right approach?', 'When you have no theory — it finds the cause by elimination.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'When you have no theory about the cause', true, NULL
from public.quiz_questions where slug = 'q-css-bisect';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'When the file is small', false, NULL
from public.quiz_questions where slug = 'q-css-bisect';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Before checking anything else', false, NULL
from public.quiz_questions where slug = 'q-css-bisect';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only for specificity problems', false, NULL
from public.quiz_questions where slug = 'q-css-bisect';
-- lesson: Milestone: diagnose and repair
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-debugging-milestone', 3, 'Milestone: diagnose and repair', 'Every cause on the list, in one file', 'A stylesheet with one instance of each common fault.',
       ARRAY['Diagnose each fault by its signature', 'Repair without escalating specificity', 'Leave the stylesheet within the conventions']::text[], 18, 40, (select id from public.skills where slug = 'css-debugging'), 0.8
from public.modules m where m.slug = 'css-debugging-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Find and fix one instance of each common cause, without escalating anything"]}'::jsonb
from public.lessons where slug = 'css-debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'Signature → cause', NULL,
       'Absent from the panel     → never matched
Struck through, overridden → lost the cascade
Struck through, alone      → invalid value
Present, no visible effect → does not apply here
Value from nowhere         → inherited or a default
Right rule, wrong box      → not that element', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'recall'::public.block_type, 'From memory', 'From memory: what is the signature of each cause?',
       NULL, NULL, NULL, '{"points":["Never matched — the rule is absent from the styles panel entirely.","Lost the cascade — present but struck through, with the winner shown above.","Invalid value — struck through with nothing overriding it.","Does not apply — present, winning, and visibly doing nothing.","Something else in play — a computed value whose source is not your rule.","Wrong element — the rule is fine; it is on a different box than you assumed."]}'::jsonb
from public.lessons where slug = 'css-debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Diagnosis is a read, not a guess.","Each signature points at exactly one cause.","Repair by lowering, not by escalating."],"nextUp":"Next: the capstone."}'::jsonb
from public.lessons where slug = 'css-debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why does repairing by escalation make the next bug harder to diagnose?"],"points":["Because it adds a rule whose only reason for existing is to beat another one, and that reason is invisible six months later. The next person sees an `!important` or a deep selector, cannot tell what it was defending against, and dares not remove it — so it stays, and the next fix has to beat that too. Lowering the over-strong rule instead leaves a stylesheet where the winner is always the obvious one."]}'::jsonb
from public.lessons where slug = 'css-debugging-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-debugging-milestone-debug', 1, 'debug'::public.exercise_kind, 'Four faults, four causes',
       'One of each. `.titel` is a typo for `.title`. `#main .note` is over-specific and beats `.warning` — lower it to `.note` so the later `.warning` rule wins. `margin: 8` is missing its unit. And `.row` sets `gap` without `display: flex`. Fix all four, and leave nothing using `!important`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Diagnose</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .titel { font-size: 1.5rem; }
      #main .note { color: teal; }
      .warning { color: crimson; }
      .card { margin: 8; }
      .row { gap: 1rem; }
    </style>
  </head>
  <body>
    <div id="main">
      <h2 class="title">Sourdough</h2>
      <p class="note warning">A warning, which should be crimson.</p>
      <div class="card">Card</div>
      <div class="row"><div>One</div><div>Two</div></div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Diagnose</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .title { font-size: 1.5rem; }
      .note { color: teal; }
      .warning { color: crimson; }
      .card { margin: 8px; }
      .row { display: flex; gap: 1rem; }
    </style>
  </head>
  <body>
    <div id="main">
      <h2 class="title">Sourdough</h2>
      <p class="note warning">A warning, which should be crimson.</p>
      <div class="card">Card</div>
      <div class="row"><div>One</div><div>Two</div></div>
    </div>
  </body>
</html>', ARRAY['Compare each selector against the class actually in the markup.', 'Removing the id brings both colour rules to one class, so source order decides.', 'A bare number is not a length.', 'gap needs a flex or grid container to mean anything.']::text[],
       75, 4,
       (select id from public.skills where slug = 'css-debugging'), false
from public.lessons l where l.slug = 'css-debugging-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.title', 'font-size',
       '1.5rem', NULL, NULL, NULL,
       'The heading rule matches the markup', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-debugging-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.warning', 'color',
       'crimson', NULL, NULL, NULL,
       'The warning colour wins without escalation', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-debugging-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.card', 'margin',
       '8px', NULL, NULL, NULL,
       'The margin has a unit and applies', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-debugging-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, '.row', 'display',
       'flex', NULL, NULL, NULL,
       'The row is a flex container', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-debugging-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_no_important'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Nothing was repaired by escalating', 'Raising specificity with !important wins this argument and loses the next one — the only way to override it later is another !important.', 1, true, NULL
from public.exercises e where e.slug = 'css-debugging-milestone-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'css_property_absent'::public.requirement_kind, '.title', 'color',
       NULL, NULL, NULL, NULL,
       'The heading was not given styles it never needed', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-debugging-milestone-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-debugging-milestone'), NULL, 'q-css-signature-invalid', 1, 'single'::public.question_kind,
        'Struck through, with nothing above it setting that property. Which cause?', 'The value was invalid, so the browser dropped the declaration.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'An invalid value', true, NULL
from public.quiz_questions where slug = 'q-css-signature-invalid';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It was overridden', false, NULL
from public.quiz_questions where slug = 'q-css-signature-invalid';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It never matched', false, NULL
from public.quiz_questions where slug = 'q-css-signature-invalid';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It does not apply to that element', false, NULL
from public.quiz_questions where slug = 'q-css-signature-invalid';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-debugging-milestone'), NULL, 'q-css-repair-by-lowering', 2, 'single'::public.question_kind,
        'A rule is being beaten by an over-specific one. What is the right repair?', 'Lower the over-specific rule rather than escalating the one that lost.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Add `!important` to the loser', false, NULL
from public.quiz_questions where slug = 'q-css-repair-by-lowering';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Add an id to the loser', false, NULL
from public.quiz_questions where slug = 'q-css-repair-by-lowering';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Move the loser to the end of the file', false, NULL
from public.quiz_questions where slug = 'q-css-repair-by-lowering';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Lower the over-specific rule', true, NULL
from public.quiz_questions where slug = 'q-css-repair-by-lowering';
-- Level 11 milestone: Debugging CSS questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-11-milestone'), 'a-css-11-computed', 1, 'single'::public.question_kind,
        'Which panel tells you what the browser actually decided?', 'The computed panel — the styles panel shows what you wrote.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The computed panel', true, NULL
from public.quiz_questions where slug = 'a-css-11-computed';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The styles panel', false, NULL
from public.quiz_questions where slug = 'a-css-11-computed';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The network panel', false, NULL
from public.quiz_questions where slug = 'a-css-11-computed';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The console', false, NULL
from public.quiz_questions where slug = 'a-css-11-computed';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-11-milestone'), 'a-css-11-absent', 2, 'single'::public.question_kind,
        'The rule is absent from the styles panel. What does that mean?', 'It never matched the element.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It never matched', true, NULL
from public.quiz_questions where slug = 'a-css-11-absent';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It was overridden', false, NULL
from public.quiz_questions where slug = 'a-css-11-absent';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Its value was invalid', false, NULL
from public.quiz_questions where slug = 'a-css-11-absent';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is in a later layer', false, NULL
from public.quiz_questions where slug = 'a-css-11-absent';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-11-milestone'), 'a-css-11-order', 3, 'single'::public.question_kind,
        'Why check the causes in a fixed order?', 'Each step eliminates a category, cheapest and most likely first.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It avoids caching problems', false, NULL
from public.quiz_questions where slug = 'a-css-11-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Each step eliminates a category, most likely first', true, NULL
from public.quiz_questions where slug = 'a-css-11-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The browser requires it', false, NULL
from public.quiz_questions where slug = 'a-css-11-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It makes the file smaller', false, NULL
from public.quiz_questions where slug = 'a-css-11-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-11-milestone'), 'a-css-11-gap', 4, 'single'::public.question_kind,
        '`gap: 1rem` has no effect. What is the most likely cause?', 'The container is neither flex nor grid.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`gap` needs a prefix', false, NULL
from public.quiz_questions where slug = 'a-css-11-gap';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The container is not flex or grid', true, NULL
from public.quiz_questions where slug = 'a-css-11-gap';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The value is invalid', false, NULL
from public.quiz_questions where slug = 'a-css-11-gap';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It was overridden', false, NULL
from public.quiz_questions where slug = 'a-css-11-gap';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-11-milestone'), 'a-css-11-hov', 5, 'single'::public.question_kind,
        'What is the `:hov` toggle in the inspector for?', 'Pinning a state on so hover and focus styles can be inspected.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Forcing a state so its styles can be read', true, NULL
from public.quiz_questions where slug = 'a-css-11-hov';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Hiding hover styles', false, NULL
from public.quiz_questions where slug = 'a-css-11-hov';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Showing the box model', false, NULL
from public.quiz_questions where slug = 'a-css-11-hov';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Disabling transitions', false, NULL
from public.quiz_questions where slug = 'a-css-11-hov';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-11-milestone'), 'a-css-11-bisect', 6, 'single'::public.question_kind,
        'What makes bisecting effective when you have no theory?', 'It locates the cause by elimination rather than by insight.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It is faster to type', false, NULL
from public.quiz_questions where slug = 'a-css-11-bisect';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It fixes the bug directly', false, NULL
from public.quiz_questions where slug = 'a-css-11-bisect';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It only works on small files', false, NULL
from public.quiz_questions where slug = 'a-css-11-bisect';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It finds the cause by elimination, needing no theory', true, NULL
from public.quiz_questions where slug = 'a-css-11-bisect';
-- --------------------------------------------------------------------------
-- CSS Architect — Level 12: Capstone: Styling Your Site
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'css-capstone', 12, 'Capstone: Styling Your Site', 'Everything, applied to the site you already built',
       'The site from the HTML course is valid, semantic and accessible, and entirely unstyled. Styling it is the capstone — real markup, real constraints, and every technique from this course used together.', 'You have styled a complete multi-page site with a token system, responsive layout and no specificity escalation anywhere.', 'violet'
from public.courses c where c.slug = 'css-architect'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, (select id from public.courses where slug = 'css-architect'), 'css-architect-final', 'final'::public.assessment_kind, 'CSS Architect final assessment', 'Ten questions drawn from the whole course. Pass mark 80%. Passing this, plus your styled capstone site, completes the course.',
       0.8, 500, 12
from public.levels l where l.slug = 'css-capstone'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Styling the site
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'css-capstone-module', 1, 'Styling the site', 'Tokens, layout, responsiveness and a final review, on real pages.',
       70, false
from public.levels l where l.slug = 'css-capstone'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'css-capstone-module' and p.slug = 'css-debugging-module';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.75
from public.modules m, public.skills s
where m.slug = 'css-capstone-module' and s.slug = 'custom-properties';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.75
from public.modules m, public.skills s
where m.slug = 'css-capstone-module' and s.slug = 'typography';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.75
from public.modules m, public.skills s
where m.slug = 'css-capstone-module' and s.slug = 'grid';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.75
from public.modules m, public.skills s
where m.slug = 'css-capstone-module' and s.slug = 'responsive';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.75
from public.modules m, public.skills s
where m.slug = 'css-capstone-module' and s.slug = 'css-architecture';
-- lesson: The foundation
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-capstone-foundation', 1, 'The foundation', 'Tokens and type before anything else', 'The order matters. Tokens and typography first, because every later decision reads from them — and because a site with good type and no layout still looks considered, while the reverse never does.',
       ARRAY['Establish a token set for the whole site', 'Set the typographic baseline', 'Explain why this order is the efficient one']::text[], 20, 40, (select id from public.skills where slug = 'custom-properties'), 0.7
from public.modules m where m.slug = 'css-capstone-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'You are styling an unstyled site from scratch. What goes first?',
       NULL, NULL, NULL, '{"options":["Tokens and typography, because everything later reads from them","The navigation, because it appears on every page","The homepage hero, because it is the most visible","The responsive breakpoints, to get them out of the way"],"answer":"Tokens and typography. Every later rule reads from the tokens, so establishing them first means no rule ever has to be revisited to replace a hard-coded value — and typography is the single change that most improves an unstyled page. Starting with the hero means making colour and spacing decisions ad hoc, then either living with them or going back to normalise them, which is the same work done twice."}'::jsonb
from public.lessons where slug = 'css-capstone-foundation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Define a site-wide token set","Set measure, leading and scale","Sequence the work so nothing is done twice"]}'::jsonb
from public.lessons where slug = 'css-capstone-foundation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, 'What you are starting from', 'Your site from the HTML course has five pages and no styling at all. That is a better starting point than it sounds: the markup is semantic, so `header`, `nav`, `main`, `article` and `footer` are all available as styling hooks that already mean something, and every heading level is correct. Nothing has to be restructured before it can be styled.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-capstone-foundation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'worked_example'::public.block_type, 'The order to work in', 'Four passes, each depending only on the ones before it.',
       NULL, NULL, NULL, '{"steps":[{"title":"Pass one — tokens","code":":root {\n  --surface: #fff;\n  --text: #1a1a1a;\n  --muted: #595959;\n  --accent: teal;\n  --border: #ddd;\n  --space: 1rem;\n  --measure: 65ch;\n  --radius: 0.5rem;\n}","reasoning":"Roles, not appearances, so a dark theme costs one block later. Everything after this pass reads values by name, and no rule ever contains a literal colour."},{"title":"Pass two — typography","code":"body { font-size: 1rem; line-height: 1.6; color: var(--text); }\nmain { max-width: var(--measure); }\nh1 { font-size: 2rem; line-height: 1.1; }\nh2 { font-size: 1.5rem; line-height: 1.2; }","reasoning":"The highest-value pass by a distance. An unstyled page with a constrained measure and comfortable leading already reads well, before a single layout decision has been made."},{"title":"Pass three — layout","code":".page { display: grid; gap: var(--space); }\n.cards { display: grid;\n  grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr)); }","reasoning":"Now, and not before. Layout decisions made after the type is set are made against real line lengths rather than against placeholder text, which is where most awkward column widths come from."},{"title":"Pass four — states and refinement","code":"a:hover, a:focus-visible { text-decoration: underline; }\n.card { transition: transform 200ms ease-out; }\n@media (prefers-reduced-motion: reduce) { * { transition: none; } }","reasoning":"Last, because states and motion are refinements of something that must already work without them. A site with no hover styles is plain; a site with no layout is broken."}]}'::jsonb
from public.lessons where slug = 'css-capstone-foundation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Style the smallest page first', 'The contact page or the about page, not the homepage. They contain the same components with fewer of them, so the token set and the typography get exercised without the homepage''s complexity obscuring what is going wrong. By the time you reach the homepage most of its parts already exist.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-capstone-foundation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'interactive_demo'::public.block_type, 'Typography alone', 'The same unstyled markup, one pass applied.',
       NULL, NULL, NULL, '{"variants":[{"label":"Unstyled","code":"<article><h1>Sourdough, slowly</h1><p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours. A loaf that would take three hours with commercial yeast takes a day or more.</p></article>","note":"Valid, semantic, and hard to read — full-width lines and default leading."},{"label":"After the typography pass","code":"<style>\n  :root { --text: #1a1a1a; --measure: 65ch; }\n  article { max-width: var(--measure); line-height: 1.6; color: var(--text); }\n  h1 { font-size: 2rem; line-height: 1.1; }\n</style>\n<article><h1>Sourdough, slowly</h1><p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours. A loaf that would take three hours with commercial yeast takes a day or more.</p></article>","note":"Four declarations. No layout work at all, and the page already reads as designed rather than as unfinished."}]}'::jsonb
from public.lessons where slug = 'css-capstone-foundation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Tokens first, so no rule ever holds a literal value.","Typography second — the highest-value pass on an unstyled site.","Layout third, against real type rather than placeholders.","States and motion last; they refine something that already works."],"nextUp":"Next: layout and the responsive pass."}'::jsonb
from public.lessons where slug = 'css-capstone-foundation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why do tokens come before everything else?","Why is typography a better second pass than layout?","Why start with the smallest page?"],"points":["Because every later rule reads values by name. Establishing them first means no rule is ever revisited to replace a hard-coded colour or spacing, and a theme later costs one block instead of an audit.","Because it is the change that most improves an unstyled page, and because layout decisions made afterwards are made against real line lengths instead of guesses.","Because it contains the same components with fewer of them, so the foundations get exercised without the homepage''s complexity hiding what is wrong."]}'::jsonb
from public.lessons where slug = 'css-capstone-foundation';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-capstone-foundation-guided', 1, 'guided'::public.exercise_kind, 'Lay the foundation',
       'On `:root` define `--text: #1a1a1a`, `--accent: teal`, `--space: 1rem` and `--measure: 65ch`. Then set `body` to `line-height: 1.6` and `color: var(--text)`, give `main` a `max-width: var(--measure)`, and give `h1` `font-size: 2rem` with `line-height: 1.1`. No literal colours outside `:root`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>About — Sourdough</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }
    </style>
  </head>
  <body>
    <main>
      <h1>About the workshop</h1>
      <p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours.</p>
    </main>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>About — Sourdough</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root {
        --text: #1a1a1a;
        --accent: teal;
        --space: 1rem;
        --measure: 65ch;
      }

      body {
        line-height: 1.6;
        color: var(--text);
      }

      main { max-width: var(--measure); }

      h1 {
        font-size: 2rem;
        line-height: 1.1;
      }
    </style>
  </head>
  <body>
    <main>
      <h1>About the workshop</h1>
      <p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours.</p>
    </main>
  </body>
</html>', ARRAY['All four tokens go on :root.', 'Read them back with var() — no literal colours below.', 'Line height stays unitless so it inherits as a ratio.']::text[],
       60, 3,
       (select id from public.skills where slug = 'custom-properties'), false
from public.lessons l where l.slug = 'css-capstone-foundation'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_custom_property'::public.requirement_kind, 'main', '--measure',
       NULL, NULL, NULL, NULL,
       'The measure token reaches the page', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-foundation-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_custom_property'::public.requirement_kind, 'main', '--accent',
       NULL, NULL, NULL, NULL,
       'The accent token is defined', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-foundation-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, 'body', 'color',
       '#1a1a1a', NULL, NULL, NULL,
       'The text colour resolves from the token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-foundation-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, 'body', 'line-height',
       '1.6', NULL, NULL, NULL,
       'Body leading is comfortable and unitless', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-foundation-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value'::public.requirement_kind, 'main', 'max-width',
       '65ch', NULL, NULL, NULL,
       'The measure resolves from the token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-foundation-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'css_value'::public.requirement_kind, 'h1', 'font-size',
       '2rem', NULL, NULL, NULL,
       'The heading is on the scale', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-foundation-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-capstone-foundation'), NULL, 'q-css-capstone-order', 1, 'single'::public.question_kind,
        'What is the first pass when styling an unstyled site?', 'Tokens, so every later rule reads values by name.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Breakpoints', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The homepage hero', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Tokens', true, NULL
from public.quiz_questions where slug = 'q-css-capstone-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The navigation', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-capstone-foundation'), NULL, 'q-css-capstone-typography', 2, 'single'::public.question_kind,
        'Why is typography the second pass rather than the fourth?', 'It is the highest-value change on an unstyled page, and layout decisions afterwards are made against real line lengths.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It is required before media queries', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-typography';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It improves the page most, and layout then follows real type', true, NULL
from public.quiz_questions where slug = 'q-css-capstone-typography';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Fonts take longest to load', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-typography';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Layout cannot be changed later', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-typography';
-- lesson: Layout and the responsive pass
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-capstone-layout', 2, 'Layout and the responsive pass', 'One grid, no device breakpoints', 'The site layout needs one grid and, at most, one or two breakpoints chosen from where the content stops working.',
       ARRAY['Lay out the page shell with grid', 'Make card lists responsive without media queries', 'Choose breakpoints from content']::text[], 22, 40, (select id from public.skills where slug = 'responsive'), 0.7
from public.modules m where m.slug = 'css-capstone-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'Your card list needs to reflow from one column to three. What is the least code that does it?',
       NULL, NULL, NULL, '{"options":["`repeat(auto-fit, minmax(16rem, 1fr))` — no media queries at all","Three media queries, one per column count","Float the cards and clear them","A media query per device width"],"answer":"`repeat(auto-fit, minmax(16rem, 1fr))`. The grid fits as many 16rem-minimum columns as the space allows and stretches them to fill, so the column count follows the available width by itself. Media queries are for the cases this cannot express — the page shell changing shape, not a list changing its column count."}'::jsonb
from public.lessons where slug = 'css-capstone-layout';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Build the page shell","Use intrinsic sizing for lists","Add a breakpoint only where the content demands one"]}'::jsonb
from public.lessons where slug = 'css-capstone-layout';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'The whole site layout', NULL,
       '.page {
  display: grid;
  grid-template-columns: 1fr;
  gap: var(--space);
}

.cards {
  display: grid;
  gap: var(--space);
  grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));
}

@media (min-width: 48rem) {
  .page { grid-template-columns: 16rem 1fr; }
}', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'css-capstone-layout';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'progressive_detail'::public.block_type, 'Why so few breakpoints', 'Every breakpoint is a second layout to maintain, test and keep consistent. Intrinsic sizing — `auto-fit`, `minmax`, `clamp` and `min-content` — handles most reflow without any, so the breakpoints that remain are the genuine structural changes: a sidebar appearing, a navigation collapsing. Two or three per site is normal for work done this way. A dozen usually means device widths were used instead of content.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-capstone-layout';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'interactive_demo'::public.block_type, 'One rule, every width', 'Resize the preview to see the column count change.',
       NULL, NULL, NULL, '{"variants":[{"label":"Intrinsic","code":"<style>\n  .cards { display: grid; gap: 1rem; grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr)); }\n  .card { background: #f4f4f4; padding: 1rem; }\n</style>\n<div class=\"cards\"><div class=\"card\">Sourdough</div><div class=\"card\">Rye</div><div class=\"card\">Seeded</div><div class=\"card\">Spelt</div></div>","note":"No media queries. The column count follows the space available."},{"label":"The shell","code":"<style>\n  .page { display: grid; grid-template-columns: 1fr; gap: 1rem; }\n  @media (min-width: 48rem) { .page { grid-template-columns: 16rem 1fr; } }\n  .side, .body { background: #f4f4f4; padding: 1rem; }\n</style>\n<div class=\"page\"><div class=\"side\">Navigation</div><div class=\"body\">Main content</div></div>","note":"One breakpoint, for a genuine structural change — the sidebar moving beside the content rather than above it."}]}'::jsonb
from public.lessons where slug = 'css-capstone-layout';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'self_explain'::public.block_type, 'Explain it in your own words', 'Your site has eleven media queries. What has probably gone wrong, and how would you reduce it?',
       NULL, NULL, NULL, '{"modelAnswer":"Almost certainly the breakpoints were taken from device widths rather than from where the content stops working, and each component got its own. The reduction is mechanical: replace every query whose only job is changing a column count with `repeat(auto-fit, minmax(…, 1fr))`, which removes most of them outright; replace fixed font-size steps with `clamp()`; and replace fixed widths with `min()` or `max-width` in `ch`. What survives is the small number of genuine structural changes — a sidebar appearing, a navigation collapsing — and those should be shared across components rather than declared separately in each. Eleven typically becomes two or three, and the layout gets more robust in the process, because intrinsic sizing works at every width rather than only at the ones you thought to test."}'::jsonb
from public.lessons where slug = 'css-capstone-layout';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'checklist'::public.block_type, 'Layout pass review', NULL,
       NULL, NULL, NULL, '{"items":["The page shell is one grid","Card and item lists use intrinsic sizing, not media queries","Breakpoints chosen from content, in `rem`","The layout is mobile-first — `min-width` queries add complexity","Nothing overflows horizontally at 320px","Spacing comes from the token, not from ad-hoc values"]}'::jsonb
from public.lessons where slug = 'css-capstone-layout';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["One grid for the shell, one for each list.","Intrinsic sizing removes most media queries.","Breakpoints come from content, and there should be few.","Mobile-first means each query adds rather than undoes."],"nextUp":"Next: the final review and the capstone mission."}'::jsonb
from public.lessons where slug = 'css-capstone-layout';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What replaces most media queries in a modern layout?","How do you know a breakpoint is in the right place?","Why does each extra breakpoint cost more than it looks?"],"points":["Intrinsic sizing — `auto-fit` with `minmax`, `clamp`, `min()` and sizing in `ch`. The layout responds to the space available rather than to a width you predicted.","You found it by narrowing the window until the content stopped working, not by looking up a device width. Content-derived breakpoints keep working when the device landscape changes.","Because it is another complete layout to maintain, test and keep consistent with the others — and the bugs it creates only appear in one width range, which is where they are least likely to be noticed."]}'::jsonb
from public.lessons where slug = 'css-capstone-layout';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-capstone-layout-guided', 1, 'guided'::public.exercise_kind, 'Lay out the page',
       'Make `.cards` a grid with `gap: var(--space)` and `grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr))`. Make `.page` a single-column grid with the same gap, and add one `@media (min-width: 48rem)` block giving `.page` two columns of `16rem 1fr`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Home — Sourdough</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root { --space: 1rem; }

      .card { background: #f4f4f4; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="page">
      <nav>Navigation</nav>
      <main>
        <div class="cards">
          <div class="card">Sourdough</div>
          <div class="card">Rye</div>
          <div class="card">Seeded</div>
        </div>
      </main>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Home — Sourdough</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root { --space: 1rem; }

      .page {
        display: grid;
        grid-template-columns: 1fr;
        gap: var(--space);
      }

      .cards {
        display: grid;
        gap: var(--space);
        grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));
      }

      .card { background: #f4f4f4; padding: 1rem; }

      @media (min-width: 48rem) {
        .page { grid-template-columns: 16rem 1fr; }
      }
    </style>
  </head>
  <body>
    <div class="page">
      <nav>Navigation</nav>
      <main>
        <div class="cards">
          <div class="card">Sourdough</div>
          <div class="card">Rye</div>
          <div class="card">Seeded</div>
        </div>
      </main>
    </div>
  </body>
</html>', ARRAY['auto-fit with minmax needs no media query to change column count.', 'The gap reads from the spacing token.', 'Mobile-first: the single column is the base, the query adds the sidebar.']::text[],
       70, 4,
       (select id from public.skills where slug = 'responsive'), false
from public.lessons l where l.slug = 'css-capstone-layout'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.cards', 'display',
       'grid', NULL, NULL, NULL,
       'The card list is a grid', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-layout-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.cards', 'gap',
       '1rem', NULL, NULL, NULL,
       'The gap resolves from the spacing token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-layout-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.cards', 'grid-template-columns',
       'repeat(auto-fit,minmax(16rem,1fr))', NULL, NULL, NULL,
       'The columns are intrinsic, needing no media query', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-layout-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, '.page', 'display',
       'grid', NULL, NULL, NULL,
       'The page shell is a grid', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-layout-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_media_rule'::public.requirement_kind, NULL, NULL,
       '(min-width: 48rem)', NULL, NULL, NULL,
       'There is one content-derived breakpoint', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-layout-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'css_value'::public.requirement_kind, '.page', 'grid-template-columns',
       '16rem 1fr', NULL, NULL, NULL,
       'The sidebar appears at the breakpoint', NULL, 1, true, '(min-width: 48rem)'
from public.exercises e where e.slug = 'css-capstone-layout-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-capstone-layout'), NULL, 'q-css-capstone-autofit', 1, 'single'::public.question_kind,
        'What does `repeat(auto-fit, minmax(16rem, 1fr))` remove the need for?', 'Media queries whose only job is changing a column count.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A grid container', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-autofit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Box sizing', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-autofit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Media queries that only change the column count', true, NULL
from public.quiz_questions where slug = 'q-css-capstone-autofit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The gap property', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-autofit';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-capstone-layout'), NULL, 'q-css-capstone-breakpoint-source', 2, 'single'::public.question_kind,
        'Where should a breakpoint come from?', 'From where the content stops working, not from a device width.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The designer’s artboard widths', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-breakpoint-source';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Where the content stops working', true, NULL
from public.quiz_questions where slug = 'q-css-capstone-breakpoint-source';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The most popular phone width', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-breakpoint-source';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A standard set of device sizes', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-breakpoint-source';
-- lesson: Final review and mission
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-capstone-review', 3, 'Final review and mission', 'Six checks, then the site is done', 'The same review every professional stylesheet gets before it ships: contrast, motion, specificity, breakpoints, tokens and focus.',
       ARRAY['Review a stylesheet against the whole course', 'Fix what the review finds without escalating', 'Complete the capstone']::text[], 25, 40, (select id from public.skills where slug = 'css-architecture'), 0.8
from public.modules m where m.slug = 'css-capstone-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Apply the six-point review","Repair by lowering rather than escalating","Finish and export the styled site"]}'::jsonb
from public.lessons where slug = 'css-capstone-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'checklist'::public.block_type, 'The final review', NULL,
       NULL, NULL, NULL, '{"items":["Contrast — body text at least 4.5:1, large text and UI at least 3:1, in every theme","Focus — every interactive element has a visible focus style, at 3:1 or better","Motion — a `prefers-reduced-motion: reduce` block exists and covers transitions as well as animations","Specificity — nothing above one class, and no `!important` outside the reduced-motion override","Tokens — no literal colours or spacing values outside `:root`","Breakpoints — few, in `rem`, and derived from content"]}'::jsonb
from public.lessons where slug = 'css-capstone-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'interactive_demo'::public.block_type, 'Before and after the review', 'The same page, reviewed.',
       NULL, NULL, NULL, '{"variants":[{"label":"Before","code":"<style>\n  .note { color: #aaa; }\n  #main .card { padding: 12px; }\n  a:focus { outline: none; }\n</style>\n<div id=\"main\"><div class=\"card\"><p class=\"note\">Low contrast, an id selector, hard-coded spacing, and focus removed.</p><a href=\"#\">A link</a></div></div>","note":"Four review failures, each of which passed unnoticed while the page was being built."},{"label":"After","code":"<style>\n  :root { --muted: #595959; --space: 0.75rem; --accent: teal; }\n  .note { color: var(--muted); }\n  .card { padding: var(--space); }\n  a:focus-visible { outline: 2px solid var(--accent); outline-offset: 2px; }\n</style>\n<div id=\"main\"><div class=\"card\"><p class=\"note\">Contrast met, one class, tokens used, focus visible.</p><a href=\"#\">A link</a></div></div>","note":"No rule got stronger. Two got weaker, and the hard-coded values became tokens."}]}'::jsonb
from public.lessons where slug = 'css-capstone-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, '`outline: none` without a replacement is the one to look for', 'Removing the focus ring makes a site unusable by keyboard, and it is nearly always done because the default outline looked wrong rather than because anyone decided keyboard users did not matter. If you remove it, replace it in the same declaration block — and check the replacement against 3:1, because a subtle focus ring is the same failure in a more considerate tone.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'css-capstone-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'recall'::public.block_type, 'From memory', 'From memory: what does each review point protect?',
       NULL, NULL, NULL, '{"points":["Contrast — readers with low vision, and anyone in bright light.","Focus — everyone navigating by keyboard, including people who cannot use a pointer.","Reduced motion — readers for whom motion causes nausea or migraine.","Specificity — your own ability to change the site next month.","Tokens — themeability, and the ability to change a value in one place.","Breakpoints — the number of separate layouts anyone has to maintain."]}'::jsonb
from public.lessons where slug = 'css-capstone-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["The review is six checks and takes minutes.","Four of the six are accessibility requirements, not preferences.","Repair by lowering; the review should never make a stylesheet stronger."],"nextUp":"Then the site is finished — and it is yours."}'::jsonb
from public.lessons where slug = 'css-capstone-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Which review points are requirements rather than preferences, and why does the distinction matter?"],"points":["Contrast, focus visibility and reduced motion are requirements — they are WCAG success criteria, and each one corresponds to readers who cannot use the site without it. Specificity, tokens and breakpoint count are engineering judgement: they protect your ability to keep working on the site rather than anyone''s ability to use it. The distinction matters because the first three are not negotiable against a deadline or a design opinion, and the second three legitimately are."]}'::jsonb
from public.lessons where slug = 'css-capstone-review';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-capstone-review-debug', 1, 'debug'::public.exercise_kind, 'Fix what the review found',
       'Four failures. `.note` is `#aaa` on white — change it to `var(--muted)`, which is `#595959`. `#main .card` is over-specific — lower it to `.card` and use `var(--space)` for the padding instead of `12px`. `a:focus` removes the outline — replace it with `a:focus-visible { outline: 2px solid var(--accent); outline-offset: 2px }`. And add a `@media (prefers-reduced-motion: reduce)` block setting `transition: none` on `.card`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Review</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root { --muted: #595959; --space: 0.75rem; --accent: teal; }

      .note { color: #aaa; }
      #main .card { padding: 12px; transition: transform 200ms ease-out; }
      a:focus { outline: none; }
    </style>
  </head>
  <body>
    <div id="main">
      <div class="card">
        <p class="note">A note.</p>
        <a href="#">A link</a>
      </div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Review</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root { --muted: #595959; --space: 0.75rem; --accent: teal; }

      .note { color: var(--muted); }

      .card {
        padding: var(--space);
        transition: transform 200ms ease-out;
      }

      a:focus-visible {
        outline: 2px solid var(--accent);
        outline-offset: 2px;
      }

      @media (prefers-reduced-motion: reduce) {
        .card { transition: none; }
      }
    </style>
  </head>
  <body>
    <div id="main">
      <div class="card">
        <p class="note">A note.</p>
        <a href="#">A link</a>
      </div>
    </div>
  </body>
</html>', ARRAY['Every value you need is already a token — read them with var().', 'Removing the id brings the card rule to one class.', 'A removed outline must be replaced, not just deleted.', 'The reduced-motion block covers transitions as well as animations.']::text[],
       80, 4,
       (select id from public.skills where slug = 'css-architecture'), false
from public.lessons l where l.slug = 'css-capstone-review'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.note', 'color',
       '#595959', NULL, NULL, NULL,
       'The note meets the contrast requirement', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-review-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.card', 'padding',
       '0.75rem', NULL, NULL, NULL,
       'Spacing comes from the token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-review-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_max_specificity'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, 257,
       'Nothing is above a one-class budget', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-review-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, 'a:focus-visible', 'outline',
       '2px solid teal', NULL, NULL, NULL,
       'Focus is visible again', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-review-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_media_rule'::public.requirement_kind, NULL, NULL,
       '(prefers-reduced-motion: reduce)', NULL, NULL, NULL,
       'A reduced-motion block is present', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-review-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'css_value'::public.requirement_kind, '.card', 'transition',
       'none', NULL, NULL, NULL,
       'Motion stops when reduced motion is requested', NULL, 1, true, '(prefers-reduced-motion: reduce)'
from public.exercises e where e.slug = 'css-capstone-review-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 7, 'css_no_important'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Nothing was repaired by escalating', 'Raising specificity with !important wins this argument and loses the next one — the only way to override it later is another !important.', 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-review-debug';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-capstone-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: style your site',
       'Style every page of the site you built in the HTML course. Work in the four passes — tokens, typography, layout, then states — and finish by running the six-point review over the whole stylesheet. When it passes, export the project: the CSS is yours, and it works anywhere.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page — your site</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      /* Pass one — tokens. Roles, not appearances. */
      :root {
        --surface: #fff;
        --text: #1a1a1a;
        --accent: teal;
        --space: 1rem;
        --measure: 65ch;
      }

      /* Pass two — typography. */

      /* Pass three — layout. */

      /* Pass four — states and motion. */
    </style>
  </head>
  <body>
    <div class="page">
      <header><nav>Your navigation</nav></header>
      <main>
        <h1>Your page heading</h1>
        <p>Your content, with <a href="index.html">a link</a> in it.</p>
      </main>
      <footer>Your footer</footer>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page — your site</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      /* Pass one — tokens. Roles, not appearances. */
      :root {
        --surface: #fff;
        --text: #1a1a1a;
        --accent: teal;
        --space: 1rem;
        --measure: 65ch;
      }

      /* Pass two — typography. */
      body {
        background: var(--surface);
        color: var(--text);
        line-height: 1.6;
      }

      main { max-width: var(--measure); }

      h1 {
        font-size: 2rem;
        line-height: 1.1;
      }

      /* Pass three — layout. */
      .page {
        display: grid;
        gap: var(--space);
      }

      /* Pass four — states and motion. */
      a:focus-visible {
        outline: 2px solid var(--accent);
        outline-offset: 2px;
      }

      @media (prefers-reduced-motion: reduce) {
        .page { transition: none; }
      }
    </style>
  </head>
  <body>
    <div class="page">
      <header><nav>Your navigation</nav></header>
      <main>
        <h1>Your page heading</h1>
        <p>Your content, with <a href="index.html">a link</a> in it.</p>
      </main>
      <footer>Your footer</footer>
    </div>
  </body>
</html>', ARRAY['Work the passes in order — each one depends only on the ones before it.', 'Start with your smallest page, not the homepage.', 'Every colour below :root should be a var().', 'Run the six-point review before you call it finished.']::text[],
       150, 5,
       (select id from public.skills where slug = 'css-architecture'), false
from public.lessons l where l.slug = 'css-capstone-review'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_custom_property'::public.requirement_kind, 'main', '--measure',
       NULL, NULL, NULL, NULL,
       'The token set reaches the page', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, 'body', 'color',
       '#1a1a1a', NULL, NULL, NULL,
       'Text colour resolves from a token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, 'main', 'max-width',
       '65ch', NULL, NULL, NULL,
       'The measure is constrained', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, '.page', 'display',
       'grid', NULL, NULL, NULL,
       'The page shell is laid out', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value'::public.requirement_kind, 'a:focus-visible', 'outline',
       '2px solid teal', NULL, NULL, NULL,
       'Focus is visible', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'css_max_specificity'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, 257,
       'The stylesheet stays within a one-class budget', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 7, 'css_no_important'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Nothing needed `!important`', 'Raising specificity with !important wins this argument and loses the next one — the only way to override it later is another !important.', 1, true, NULL
from public.exercises e where e.slug = 'css-capstone-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-capstone-review'), NULL, 'q-css-capstone-outline', 1, 'single'::public.question_kind,
        'What must accompany `outline: none` on a focus style?', 'A visible replacement, checked against 3:1.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'An `!important` flag', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-outline';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nothing; the default is decorative', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-outline';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A visible replacement focus indicator', true, NULL
from public.quiz_questions where slug = 'q-css-capstone-outline';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A hover style', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-outline';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-capstone-review'), NULL, 'q-css-capstone-review-direction', 2, 'single'::public.question_kind,
        'What should the final review never do to a stylesheet?', 'Make it stronger — repairs come from lowering, not escalating.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Add a token', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-review-direction';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Reduce a breakpoint count', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-review-direction';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Make any rule stronger', true, NULL
from public.quiz_questions where slug = 'q-css-capstone-review-direction';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Remove a rule', false, NULL
from public.quiz_questions where slug = 'q-css-capstone-review-direction';
-- CSS Architect final assessment questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-architect-final'), 'css-final-q1', 1, 'single'::public.question_kind,
        'Two rules of equal specificity set the same property. Which wins?', 'The later one. Source order is the final tie-break.', (select id from public.skills where slug = 'cascade'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The one written first', false, NULL
from public.quiz_questions where slug = 'css-final-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Neither; the property is dropped', false, NULL
from public.quiz_questions where slug = 'css-final-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The one with more declarations', false, NULL
from public.quiz_questions where slug = 'css-final-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The one written later', true, NULL
from public.quiz_questions where slug = 'css-final-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-architect-final'), 'css-final-q2', 2, 'single'::public.question_kind,
        'What does `box-sizing: border-box` change?', '`width` then includes padding and border rather than excluding them.', (select id from public.skills where slug = 'box-model'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The element becomes a flex container', false, NULL
from public.quiz_questions where slug = 'css-final-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Borders are drawn outside the element', false, NULL
from public.quiz_questions where slug = 'css-final-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`width` includes padding and border', true, NULL
from public.quiz_questions where slug = 'css-final-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Margins stop collapsing', false, NULL
from public.quiz_questions where slug = 'css-final-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-architect-final'), 'css-final-q3', 3, 'single'::public.question_kind,
        'Which axis does `justify-content` work on in a flex container?', 'The main axis — the one `flex-direction` sets.', (select id from public.skills where slug = 'flexbox'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Both axes', false, NULL
from public.quiz_questions where slug = 'css-final-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The main axis', true, NULL
from public.quiz_questions where slug = 'css-final-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The cross axis', false, NULL
from public.quiz_questions where slug = 'css-final-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Always the horizontal axis', false, NULL
from public.quiz_questions where slug = 'css-final-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-architect-final'), 'css-final-q4', 4, 'single'::public.question_kind,
        'What does `repeat(auto-fit, minmax(16rem, 1fr))` do?', 'Fits as many columns of at least 16rem as the space allows, stretching them to fill.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Fits as many 16rem-minimum columns as the space allows', true, NULL
from public.quiz_questions where slug = 'css-final-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Creates exactly 16 columns', false, NULL
from public.quiz_questions where slug = 'css-final-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Sets every column to 16rem', false, NULL
from public.quiz_questions where slug = 'css-final-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Requires a media query to reflow', false, NULL
from public.quiz_questions where slug = 'css-final-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-architect-final'), 'css-final-q5', 5, 'single'::public.question_kind,
        'Where should a breakpoint come from?', 'From where the content stops working.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A list of device widths', false, NULL
from public.quiz_questions where slug = 'css-final-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The most common screen size', false, NULL
from public.quiz_questions where slug = 'css-final-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The design tool’s artboards', false, NULL
from public.quiz_questions where slug = 'css-final-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Where the content stops working', true, NULL
from public.quiz_questions where slug = 'css-final-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-architect-final'), 'css-final-q6', 6, 'single'::public.question_kind,
        'A token is declared on `.panel`. Which elements can read it?', '`.panel` and its descendants — custom properties inherit.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Only `.panel`', false, NULL
from public.quiz_questions where slug = 'css-final-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Its siblings too', false, NULL
from public.quiz_questions where slug = 'css-final-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`.panel` and its descendants', true, NULL
from public.quiz_questions where slug = 'css-final-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Every element on the page', false, NULL
from public.quiz_questions where slug = 'css-final-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-architect-final'), 'css-final-q7', 7, 'single'::public.question_kind,
        'What contrast ratio does normal body text require?', '4.5:1 against its actual background.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '7:1', false, NULL
from public.quiz_questions where slug = 'css-final-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '4.5:1', true, NULL
from public.quiz_questions where slug = 'css-final-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '3:1', false, NULL
from public.quiz_questions where slug = 'css-final-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '2:1', false, NULL
from public.quiz_questions where slug = 'css-final-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-architect-final'), 'css-final-q8', 8, 'single'::public.question_kind,
        'Which two properties can be animated without forcing layout?', '`transform` and `opacity` — the compositor handles both.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`transform` and `opacity`', true, NULL
from public.quiz_questions where slug = 'css-final-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`width` and `height`', false, NULL
from public.quiz_questions where slug = 'css-final-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`top` and `left`', false, NULL
from public.quiz_questions where slug = 'css-final-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`margin` and `padding`', false, NULL
from public.quiz_questions where slug = 'css-final-q8';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-architect-final'), 'css-final-q9', 9, 'single'::public.question_kind,
        'What does `@layer` let a weak selector do?', 'Beat a stronger one, because layer order is compared before specificity.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Raise its own specificity', false, NULL
from public.quiz_questions where slug = 'css-final-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Apply only inside a media query', false, NULL
from public.quiz_questions where slug = 'css-final-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Inherit from its parent', false, NULL
from public.quiz_questions where slug = 'css-final-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Beat a stronger selector in an earlier layer', true, NULL
from public.quiz_questions where slug = 'css-final-q9';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-architect-final'), 'css-final-q10', 10, 'single'::public.question_kind,
        'A rule is absent from the styles panel entirely. What happened?', 'It never matched the element.', (select id from public.skills where slug = 'css-debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It is in an earlier layer', false, NULL
from public.quiz_questions where slug = 'css-final-q10';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It never matched', true, NULL
from public.quiz_questions where slug = 'css-final-q10';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It was overridden', false, NULL
from public.quiz_questions where slug = 'css-final-q10';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Its value was invalid', false, NULL
from public.quiz_questions where slug = 'css-final-q10';
-- --------------------------------------------------------------------------
-- Remove content deleted from the curriculum
-- --------------------------------------------------------------------------

delete from public.quiz_questions where slug not in ('a1-q1', 'a1-q2', 'a1-q3', 'a1-q4', 'a1-q5', 'a1-q6', 'a1-q7', 'a1-q8', 'a1-q9', 'a1-q10', 'q-what-is-html', 'q-html-purpose', 'q-tag-vs-element', 'q-attribute-syntax', 'q-void-elements', 'q-nesting-order', 'q-dom-meaning', 'q-comments', 'q-doctype-purpose', 'q-head-vs-body', 'q-viewport', 'q-charset', 'q-index-html', 'q-one-h1', 'a2-q1', 'a2-q2', 'a2-q3', 'a2-q4', 'a2-q5', 'a2-q6', 'a2-q7', 'a2-q8', 'q-heading-skip', 'q-heading-purpose', 'q-whitespace', 'q-br-use', 'q-hr-meaning', 'q-strong-vs-em', 'q-small-meaning', 'q-cite-meaning', 'q-datetime-format', 'q-q-quotes', 'q-entity-lt', 'q-list-choice', 'q-nested-list', 'q-semantic-choice', 'a3-q1', 'a3-q2', 'a3-q3', 'a3-q4', 'a3-q5', 'a3-q6', 'a3-q7', 'a3-q8', 'q-link-text', 'q-noopener', 'q-dotdot', 'q-leading-slash', 'q-fragment-case', 'q-tel-format', 'q-download-attr', 'q-nav-list', 'q-skip-link-position', 'q-aria-current', 'q-filenames', 'q-nav-consistency', 'a4-q1', 'a4-q2', 'a4-q3', 'a4-q4', 'a4-q5', 'a4-q6', 'a4-q7', 'a4-q8', 'a4-q9', 'q-img-dimensions', 'q-hotlinking', 'q-empty-alt', 'q-alt-vs-caption', 'q-missing-alt', 'q-srcset-w', 'q-sizes-purpose', 'q-picture-img', 'q-lazy-hero', 'q-picture-vs-srcset', 'q-video-controls', 'q-track-kind', 'q-fallback-placement', 'q-iframe-title', 'q-sandbox', 'a5-q1', 'a5-q2', 'a5-q3', 'a5-q4', 'a5-q5', 'a5-q6', 'a5-q7', 'a5-q8', 'q-semantic-meaning', 'q-main-count', 'q-article-test', 'q-section-heading', 'q-outline-algorithm', 'q-case-sensitivity', 'q-comments-value', 'q-footer-placement', 'a6-q1', 'a6-q2', 'a6-q3', 'a6-q4', 'a6-q5', 'a6-q6', 'a6-q7', 'a6-q8', 'a6-q9', 'a6-q10', 'q-scope-col', 'q-caption-position', 'q-layout-tables', 'q-label-for', 'q-placeholder', 'q-number-type', 'q-name-attribute', 'q-radio-group', 'q-button-type', 'q-legend-position', 'q-client-validation', 'q-get-vs-post', 'q-aria-describedby', 'a7-q1', 'a7-q2', 'a7-q3', 'a7-q4', 'a7-q5', 'a7-q6', 'a7-q7', 'q-summary-position', 'q-details-name', 'q-dialog-close', 'q-popover-js', 'q-modal-content', 'q-progress-vs-meter', 'q-datalist-restrict', 'a8-q1', 'a8-q2', 'a8-q3', 'a8-q4', 'a8-q5', 'a8-q6', 'a8-q7', 'a8-q8', 'a8-q9', 'q-a11y-tree', 'q-keyboard-test', 'q-div-button', 'q-focusable-defaults', 'q-tabindex-negative', 'q-positive-tabindex', 'q-name-order', 'q-alt-empty-vs-missing', 'q-link-text-alone', 'q-aria-first-rule', 'q-aria-behaviour', 'q-labelledby-vs-label', 'q-aria-current-page', 'q-live-region-timing', 'q-assertive-vs-polite', 'q-placeholder-not-label', 'q-fieldset-legend', 'q-autocomplete-requirement', 'q-audit-order', 'q-duplicate-id-impact', 'a9-q1', 'a9-q2', 'a9-q3', 'a9-q4', 'a9-q5', 'a9-q6', 'a9-q7', 'a9-q8', 'q-title-length', 'q-canonical', 'q-noindex-security', 'q-og-property', 'q-structured-data-ranking', 'q-og-image-url', 'q-lang-missing-effect', 'q-wrong-lang-worse', 'q-dir-auto', 'q-metadata-order', 'a10-q1', 'a10-q2', 'a10-q3', 'a10-q4', 'a10-q5', 'a10-q6', 'a10-q7', 'a10-q8', 'q-layout-shift', 'q-defer-async', 'q-preload-overuse', 'q-noopener-why', 'q-hidden-input', 'q-csp-header', 'q-iframe-cost', 'q-sandbox-combination', 'q-defer-vs-async', 'q-preload-auto', 'a11-q1', 'a11-q2', 'a11-q3', 'a11-q4', 'a11-q5', 'a11-q6', 'a11-q7', 'q-validator-order', 'q-validator-limits', 'q-duplicate-id-effect', 'q-elements-panel', 'q-network-404', 'q-one-change', 'q-bisection-steps', 'q-minimal-repro-value', 'q-one-change-at-a-time', 'q-repair-order', 'final-q1', 'final-q2', 'final-q3', 'final-q4', 'final-q5', 'final-q6', 'final-q7', 'final-q8', 'final-q9', 'final-q10', 'final-q11', 'final-q12', 'q-shell-difference', 'q-capstone-media', 'q-review-order', 'q-publishing', 'a-css-1-specificity-order', 'a-css-1-inheritance-loses', 'a-css-1-invalid-silent', 'a-css-1-inline-beats', 'a-css-1-does-not-inherit', 'a-css-1-where-zero', 'a-css-1-tie-break', 'a-css-1-button-inherit', 'q-css-rule-parts', 'q-css-invalid-declaration', 'q-css-where-it-lives', 'q-css-id-vs-classes', 'q-css-source-order', 'q-css-important-cost', 'q-css-what-inherits', 'q-css-inheritance-vs-specificity', 'q-css-button-font', 'q-css-diagnose-order', 'q-css-repair-direction', 'a-css-2-width-default', 'a-css-2-border-box', 'a-css-2-collapse', 'a-css-2-combinator', 'a-css-2-attribute', 'a-css-2-specificity-cost', 'q-css-width-measures', 'q-css-border-box-selector', 'q-css-margin-collapse', 'q-css-child-combinator', 'q-css-where-zero-specificity', 'q-css-focus-visible', 'q-css-padding-vs-margin', 'q-css-border-needs-style', 'a-css-3-inline-width', 'a-css-3-inline-block', 'a-css-3-abs-reference', 'a-css-3-sticky', 'a-css-3-context-trap', 'a-css-3-display-none-a11y', 'q-css-inline-ignores', 'q-css-display-none-cost', 'q-css-replaced-elements', 'q-css-absolute-against', 'q-css-stacking-context-cause', 'q-css-zindex-static', 'q-css-out-of-flow-space', 'q-css-relative-no-offsets', 'a-css-4-axes-swap', 'a-css-4-equal-columns', 'a-css-4-fixed-item', 'a-css-4-wrap-default', 'a-css-4-equal-heights', 'a-css-4-overflow-cause', 'q-css-justify-axis', 'q-css-align-items-default', 'q-css-gap-benefit', 'q-css-flex-1-expands', 'q-css-flex-auto-vs-1', 'q-css-min-width-zero', 'q-css-space-between', 'q-css-nested-flex', 'a-css-5-fr-leftover', 'a-css-5-repeat', 'a-css-5-implicit', 'a-css-5-minmax', 'a-css-5-empty-cell', 'a-css-5-container-vs-viewport', 'q-css-fr-meaning', 'q-css-implicit-rows', 'q-css-fr-vs-percent', 'q-css-auto-fit', 'q-css-auto-fit-vs-fill', 'q-css-grid-vs-flex', 'q-css-area-span', 'q-css-nested-grid-why', 'a-css-6-max-width', 'a-css-6-clamp', 'a-css-6-min-max-naming', 'a-css-6-mobile-first-order', 'a-css-6-container-type', 'a-css-6-device-breakpoints', 'q-css-max-width', 'q-css-clamp-parts', 'q-css-ch-unit', 'q-css-mobile-first', 'q-css-breakpoint-source', 'q-css-container-query-why', 'q-css-query-last-resort', 'q-css-rem-breakpoints', 'a-css-7-syntax', 'a-css-7-resolved-when', 'a-css-7-sibling-scope', 'a-css-7-missing-var', 'a-css-7-theme-cost', 'a-css-7-root-why', 'q-css-token-inherits', 'q-css-var-fallback', 'q-css-token-scope', 'q-css-theme-approach', 'q-css-token-naming', 'q-css-prefers-scheme', 'q-css-variant-vs-theme', 'q-css-no-literal-colours', 'a-css-8-measure', 'a-css-8-lineheight', 'a-css-8-rem', 'a-css-8-contrast-large', 'a-css-8-second-signal', 'a-css-8-currentcolor-use', 'q-css-measure', 'q-css-lineheight-unit', 'q-css-rem-type', 'q-css-contrast-body', 'q-css-colour-alone', 'q-css-currentcolor', 'q-css-scale-benefit', 'q-css-heading-leading', 'a-css-9-transition-place', 'a-css-9-compositor', 'a-css-9-all', 'a-css-9-preference-meaning', 'a-css-9-why-preference', 'a-css-9-easing-default', 'q-css-transition-where', 'q-css-transition-all', 'q-css-duration', 'q-css-cheap-props', 'q-css-reduced-motion', 'q-css-keyframes-name', 'q-css-motion-both', 'q-css-motion-important', 'a-css-10-important', 'a-css-10-layer-beats', 'a-css-10-where', 'a-css-10-prefix', 'a-css-10-shared-selector', 'a-css-10-name-role', 'q-css-important-escalation', 'q-css-flat-selectors', 'q-css-name-meaning', 'q-css-layer-order', 'q-css-where-reset', 'q-css-deletable', 'q-css-variant-class', 'q-css-arch-goal', 'a-css-11-computed', 'a-css-11-absent', 'a-css-11-order', 'a-css-11-gap', 'a-css-11-hov', 'a-css-11-bisect', 'q-css-struck-through', 'q-css-computed-panel', 'q-css-missing-rule', 'q-css-first-check', 'q-css-inline-width', 'q-css-bisect', 'q-css-signature-invalid', 'q-css-repair-by-lowering', 'css-final-q1', 'css-final-q2', 'css-final-q3', 'css-final-q4', 'css-final-q5', 'css-final-q6', 'css-final-q7', 'css-final-q8', 'css-final-q9', 'css-final-q10', 'q-css-capstone-order', 'q-css-capstone-typography', 'q-css-capstone-autofit', 'q-css-capstone-breakpoint-source', 'q-css-capstone-outline', 'q-css-capstone-review-direction');
delete from public.exercises where slug not in ('first-markup-guided', 'first-markup-debug', 'attributes-guided', 'attributes-challenge', 'attributes-debug', 'nesting-guided', 'nesting-debug', 'skeleton-guided', 'skeleton-debug', 'first-page-milestone', 'first-page-mission', 'headings-guided', 'headings-debug', 'paragraphs-guided', 'paragraphs-debug', 'emphasis-guided', 'emphasis-challenge', 'quotes-guided', 'quotes-debug', 'lists-guided', 'entities-debug', 'article-milestone-build', 'article-mission', 'links-guided', 'links-debug', 'paths-guided', 'fragments-challenge', 'paths-debug', 'special-links-guided', 'nav-guided', 'skip-link-challenge', 'nav-debug', 'multipage-milestone-build', 'navigation-mission', 'img-guided', 'img-debug', 'alt-guided', 'figure-challenge', 'srcset-guided', 'srcset-debug', 'picture-guided', 'lazy-challenge', 'video-guided', 'video-debug', 'iframe-guided', 'media-milestone', 'media-mission', 'landmarks-guided', 'section-article-guided', 'section-debug', 'patterns-guided', 'semantic-rebuild', 'semantic-mission', 'table-guided', 'table-debug', 'labels-guided', 'input-types-debug', 'fieldset-guided', 'controls-challenge', 'validation-guided', 'form-milestone', 'form-mission', 'details-guided', 'popover-guided', 'dialog-debug', 'datalist-guided', 'native-milestone', 'native-mission', 'keyboard-debug', 'keyboard-skip-link-guided', 'keyboard-operability-debug', 'accessible-names-challenge', 'accessible-names-debug', 'aria-guided', 'aria-debug', 'aria-state-guided', 'aria-state-debug', 'accessible-form-challenge', 'accessible-form-debug', 'a11y-audit-milestone', 'a11y-mission', 'metadata-guided', 'metadata-debug', 'og-guided', 'jsonld-challenge', 'lang-guided', 'lang-debug', 'seo-milestone-build', 'seo-mission', 'perf-guided', 'security-debug', 'embed-hardening-guided', 'third-party-debug', 'performance-milestone-build', 'performance-mission', 'validation-debug', 'devtools-debug', 'bisection-debug', 'minimal-reproduction-challenge', 'repair-milestone', 'validation-mission', 'shell-guided', 'capstone-main-build', 'final-review-exercise', 'capstone-final-mission', 'css-first-rule-guided', 'css-first-rule-debug', 'css-specificity-guided', 'css-specificity-debug', 'css-inheritance-guided', 'css-inheritance-debug', 'css-cascade-milestone-debug', 'css-border-box-guided', 'css-box-debug', 'css-selectors-guided', 'css-box-milestone-challenge', 'css-box-milestone-debug', 'css-flow-guided', 'css-position-guided', 'css-stacking-debug', 'css-flow-milestone-debug', 'css-flex-centre-guided', 'css-flex-axis-debug', 'css-flex-sidebar-guided', 'css-flex-wrap-debug', 'css-flex-milestone-challenge', 'css-grid-tracks-guided', 'css-grid-responsive-guided', 'css-grid-areas-debug', 'css-grid-milestone-challenge', 'css-fluid-guided', 'css-mobile-first-guided', 'css-responsive-debug', 'css-responsive-milestone-challenge', 'css-tokens-guided', 'css-theme-guided', 'css-tokens-debug', 'css-tokens-milestone-challenge', 'css-type-guided', 'css-contrast-debug', 'css-type-milestone-challenge', 'css-transition-guided', 'css-motion-guided', 'css-motion-debug', 'css-motion-milestone-challenge', 'css-naming-debug', 'css-layers-guided', 'css-architecture-milestone-challenge', 'css-invalid-debug', 'css-applies-debug', 'css-debugging-milestone-debug', 'css-capstone-foundation-guided', 'css-capstone-layout-guided', 'css-capstone-review-debug', 'css-capstone-mission');
delete from public.lessons where slug not in ('what-happens-when-you-open-a-page', 'tags-elements-attributes', 'nesting-and-the-document-tree', 'doctype-html-head-body', 'your-first-complete-page', 'heading-hierarchy', 'paragraphs-breaks-rules', 'emphasis-and-importance', 'quotes-abbreviations-dates', 'code-entities-and-lists', 'article-milestone', 'anchors-and-link-text', 'relative-and-absolute-paths', 'special-links', 'navigation-menus', 'multi-page-milestone', 'the-img-element', 'writing-alt-text', 'srcset-and-sizes', 'picture-and-formats', 'video-and-audio', 'iframes-and-media-milestone', 'semantic-vs-non-semantic', 'section-article-aside', 'file-organisation-and-patterns', 'semantic-rebuild-milestone', 'building-a-table', 'labels-and-inputs', 'grouping-and-controls', 'validation-and-form-milestone', 'details-and-summary', 'dialog-and-popover', 'progress-meter-datalist-milestone', 'how-assistive-tech-reads-a-page', 'keyboard-and-focus-management', 'accessible-names-in-depth', 'aria-fundamentals', 'aria-live-and-state', 'accessible-forms-in-depth', 'accessibility-audit-milestone', 'titles-descriptions-canonicals', 'social-and-structured-data', 'language-and-internationalisation', 'seo-milestone', 'loading-strategy', 'html-security', 'third-party-and-embeds', 'performance-milestone', 'reading-validation-output', 'developer-tools', 'a-method-for-debugging', 'debugging-milestone', 'assembling-the-site', 'capstone-build', 'final-review', 'css-what-a-rule-is', 'css-specificity', 'css-inheritance', 'css-cascade-milestone', 'css-the-four-layers', 'css-selectors', 'css-box-milestone', 'css-normal-flow', 'css-position-and-stacking', 'css-flow-milestone', 'css-flex-axes', 'css-flex-sizing', 'css-flex-milestone', 'css-grid-tracks', 'css-grid-areas-and-auto-fit', 'css-grid-milestone', 'css-fluid-first', 'css-queries', 'css-responsive-milestone', 'css-declaring-tokens', 'css-theming', 'css-tokens-milestone', 'css-readable-type', 'css-colour-contrast', 'css-type-milestone', 'css-transitions', 'css-keyframes-motion', 'css-motion-milestone', 'css-naming', 'css-scale', 'css-architecture-milestone', 'css-inspector', 'css-diagnosis', 'css-debugging-milestone', 'css-capstone-foundation', 'css-capstone-layout', 'css-capstone-review');
delete from public.assessments where slug not in ('level-1-milestone', 'level-2-milestone', 'level-3-milestone', 'level-4-milestone', 'level-5-milestone', 'level-6-milestone', 'level-7-milestone', 'level-8-milestone', 'level-9-milestone', 'level-10-milestone', 'level-11-milestone', 'html-hero-final', 'css-level-1-milestone', 'css-level-2-milestone', 'css-level-3-milestone', 'css-level-4-milestone', 'css-level-5-milestone', 'css-level-6-milestone', 'css-level-7-milestone', 'css-level-8-milestone', 'css-level-9-milestone', 'css-level-10-milestone', 'css-level-11-milestone', 'css-architect-final');
delete from public.modules where slug not in ('how-the-web-works', 'the-html-skeleton', 'headings-and-paragraphs', 'text-level-semantics', 'links-and-paths', 'site-navigation', 'images-and-alt-text', 'responsive-images', 'video-audio-embeds', 'semantic-landmarks', 'organising-a-project', 'data-tables', 'form-foundations', 'disclosure-and-dialog', 'accessibility-foundations', 'aria-and-accessible-forms', 'page-metadata', 'html-performance', 'validation-and-tools', 'completing-the-site', 'review-and-publish', 'css-first-rules', 'css-boxes', 'css-flow', 'css-flex', 'css-grid-module', 'css-responsive-module', 'css-tokens', 'css-type-colour', 'css-motion-module', 'css-architecture-module', 'css-debugging-module', 'css-capstone-module');
delete from public.levels where slug not in ('html-explorer', 'content-builder', 'navigation-architect', 'media-specialist', 'structure-professional', 'data-and-forms', 'native-interaction', 'accessibility-champion', 'metadata-and-seo', 'performance-and-security', 'debugging-and-validation', 'html-hero-capstone', 'css-cascade', 'css-box-model', 'css-flow-and-position', 'css-flexbox', 'css-grid', 'css-responsive', 'css-custom-properties', 'css-typography', 'css-motion', 'css-architecture-level', 'css-debugging-level', 'css-capstone');
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

commit;
