-- HTML Hero — course seed, part 13 of 16
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 12 first.

begin;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Only with `inherit`', false, NULL
from public.quiz_questions where slug = 'a-css-7-sibling-scope';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only inside a media query', false, NULL
from public.quiz_questions where slug = 'a-css-7-sibling-scope';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'No, only descendants', true, NULL
from public.quiz_questions where slug = 'a-css-7-sibling-scope';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-7-milestone'), 'a-css-7-missing-var', 4, 'single'::public.question_kind,
        'What happens to `color: var(--missing)` with no fallback?', 'The declaration is invalid and dropped, silently.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The declaration is dropped silently', true, NULL
from public.quiz_questions where slug = 'a-css-7-missing-var';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The colour becomes black', false, NULL
from public.quiz_questions where slug = 'a-css-7-missing-var';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The whole rule is dropped', false, NULL
from public.quiz_questions where slug = 'a-css-7-missing-var';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'An error is logged', false, NULL
from public.quiz_questions where slug = 'a-css-7-missing-var';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-7-milestone'), 'a-css-7-theme-cost', 5, 'single'::public.question_kind,
        'What does adding a second theme cost in a token-based stylesheet?', 'One block of overrides, regardless of how many components there are.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A duplicate of every rule', false, NULL
from public.quiz_questions where slug = 'a-css-7-theme-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A class on every component', false, NULL
from public.quiz_questions where slug = 'a-css-7-theme-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A second stylesheet file', false, NULL
from public.quiz_questions where slug = 'a-css-7-theme-cost';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'One block of token overrides', true, NULL
from public.quiz_questions where slug = 'a-css-7-theme-cost';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-7-milestone'), 'a-css-7-root-why', 6, 'single'::public.question_kind,
        'Why are document-wide tokens declared on `:root`?', 'It is the ancestor of every element, and custom properties inherit.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It is the only place they are valid', false, NULL
from public.quiz_questions where slug = 'a-css-7-root-why';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It makes them non-inheriting', false, NULL
from public.quiz_questions where slug = 'a-css-7-root-why';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It gives them `!important`', false, NULL
from public.quiz_questions where slug = 'a-css-7-root-why';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Everything on the page is a descendant of it', true, NULL
from public.quiz_questions where slug = 'a-css-7-root-why';
-- --------------------------------------------------------------------------
-- CSS Architect — Level 8: Typography and Colour
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'css-typography', 8, 'Typography and Colour', 'The parts that are requirements, not taste',
       'Most typography advice is presented as taste. A useful amount of it is not: line length, line height and contrast ratio have numbers behind them, and two of those numbers are accessibility requirements.', 'You can set readable type on a scale and choose colours that meet contrast requirements.', 'violet'
from public.courses c where c.slug = 'css-architect'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'css-level-8-milestone', 'milestone'::public.assessment_kind, 'Level 8 milestone: Typography and Colour', 'Six questions on scale, measure, leading and contrast. Pass mark 75%.',
       0.75, 180, 8
from public.levels l where l.slug = 'css-typography'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Type and colour systems
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'css-type-colour', 1, 'Type and colour systems', 'Scale, measure, rhythm, contrast — and which of those you may not compromise on.',
       52, false
from public.levels l where l.slug = 'css-typography'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'css-type-colour' and p.slug = 'css-tokens';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'css-type-colour' and s.slug = 'typography';
-- lesson: Readable type
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-readable-type', 1, 'Readable type', 'Measure, leading and scale', 'Three numbers do most of the work: how long a line is, how far apart lines sit, and how sizes relate to each other.',
       ARRAY['Set a comfortable line length', 'Choose line height as a ratio', 'Build a modular type scale']::text[], 17, 40, (select id from public.skills where slug = 'typography'), 0.7
from public.modules m where m.slug = 'css-type-colour'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A paragraph of body text runs the full width of a 1400px screen. Why is that hard to read?',
       NULL, NULL, NULL, '{"options":["The eye loses its place returning to the start of the next line","Long lines render more slowly","Browsers cannot hyphenate long lines","It is not a problem; wider is always better"],"answer":"The return sweep. At the end of a very long line the eye has to travel a long way back and find the start of the next one, and it increasingly lands on the wrong line. This is why the recommendation is roughly 45–75 characters per line — and why `max-width: 65ch` on your text container is one of the highest-value single declarations in CSS."}'::jsonb
from public.lessons where slug = 'css-readable-type';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Constrain line length with `ch`","Set line height as a unitless ratio and explain why","Generate a type scale from one ratio"]}'::jsonb
from public.lessons where slug = 'css-readable-type';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Measure', 'The length of a line of text, counted in characters. Comfortable body text sits at roughly 45–75.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-readable-type';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Leading', 'The vertical distance between lines of text — `line-height` in CSS. Body text usually wants 1.5 or more.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-readable-type';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'The three numbers', NULL,
       '.prose      { max-width: 65ch; }      measure
body        { line-height: 1.5; }     leading, unitless
h1          { line-height: 1.1; }     large text needs less

1ch = the width of the "0" glyph in the current font,
so 65ch tracks the font rather than guessing at pixels.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-readable-type';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Line height must be unitless', '`line-height: 1.5` inherits as the *ratio*, so each descendant computes its own spacing from its own font size. `line-height: 24px` inherits as 24px, so a heading at 40px gets 24px of line height and its lines collide. This is one of the few places where the unit changes what inheritance means, and it catches people repeatedly.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'css-readable-type';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'interactive_demo'::public.block_type, 'Measure and leading', 'The same paragraph, three settings.',
       NULL, NULL, NULL, '{"variants":[{"label":"Unconstrained","code":"<style>\n  p { line-height: 1.2; }\n</style>\n<p>Sourdough is a slow bread. The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours. A loaf that would take three hours with commercial yeast takes a day or more, and most of that time is waiting rather than working. The waiting is the technique.</p>","note":"Full width, tight leading. Notice how hard it is to find the next line."},{"label":"Measure constrained","code":"<style>\n  p { max-width: 65ch; line-height: 1.2; }\n</style>\n<p>Sourdough is a slow bread. The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours. A loaf that would take three hours with commercial yeast takes a day or more, and most of that time is waiting rather than working. The waiting is the technique.</p>","note":"One declaration, and the return sweep is short again."},{"label":"Both","code":"<style>\n  p { max-width: 65ch; line-height: 1.6; }\n</style>\n<p>Sourdough is a slow bread. The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours. A loaf that would take three hours with commercial yeast takes a day or more, and most of that time is waiting rather than working. The waiting is the technique.</p>","note":"Comfortable leading as well. This is the baseline every text page should start from."}]}'::jsonb
from public.lessons where slug = 'css-readable-type';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'worked_example'::public.block_type, 'Building a type scale', 'Sizes chosen by a ratio rather than one at a time.',
       NULL, NULL, NULL, '{"steps":[{"title":"Pick a base and a ratio","code":":root {\n  --text-base: 1rem;    /* 16px, the browser default */\n  --ratio: 1.25;        /* major third */\n}","reasoning":"Starting from `1rem` means the reader''s own browser font-size setting is honoured — someone who set 20px because they need it gets a proportionally larger page rather than being overridden."},{"title":"Derive the steps","code":":root {\n  --text-sm:  0.8rem;    /* base ÷ 1.25 */\n  --text-base: 1rem;\n  --text-lg:  1.25rem;   /* base × 1.25 */\n  --text-xl:  1.563rem;  /* × 1.25 again */\n  --text-2xl: 1.953rem;\n}","reasoning":"Each step is the previous one multiplied by the ratio. The sizes then relate to each other by construction, which is what makes a page look deliberate rather than assembled."},{"title":"Use the steps, never raw numbers","code":"h1 { font-size: var(--text-2xl); line-height: 1.1; }\nh2 { font-size: var(--text-xl);  line-height: 1.2; }\np  { font-size: var(--text-base); }\nsmall { font-size: var(--text-sm); }","reasoning":"A stylesheet with five sizes in it looks designed. One with `font-size: 17px` in nineteen different places does not, and cannot be adjusted globally."},{"title":"Tighten leading as size grows","code":"h1 { line-height: 1.1; }\np  { line-height: 1.6; }","reasoning":"Leading is proportional, so a large heading at 1.6 gets a cavernous gap. Big text needs a smaller ratio; small text needs a larger one."}]}'::jsonb
from public.lessons where slug = 'css-readable-type';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'predict_check'::public.block_type, 'Predict, then check', 'The line height is 32px and the heading is 48px. Before you check: what happens to the heading?',
       '<style>
  body { font-size: 16px; line-height: 32px; }
  h1 { font-size: 48px; }
</style>
<h1>A heading that will wrap onto two lines here</h1>', 'html', NULL, '{"outcome":"Its lines overlap. `line-height: 32px` inherits as a fixed 32px, so a 48px heading gets 32px of line box — less than the text is tall. Had it been written `line-height: 2`, the heading would have computed 96px from its own font size. The unitless form is not a style preference; it is the only form that survives inheritance."}'::jsonb
from public.lessons where slug = 'css-readable-type';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'progressive_detail'::public.block_type, 'Why `rem` and not `px` for font size', 'A reader who has set their browser default to 20px has usually done it because they need to. `font-size: 16px` overrides that decision; `font-size: 1rem` honours it, and the whole scale moves with it. This is the single most common accessibility failure in otherwise careful stylesheets. Use `rem` for type, and `px` only where a value genuinely should not scale — a hairline border, for instance.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-readable-type';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Constrain measure to roughly 45–75 characters — `max-width: 65ch`.","Set `line-height` unitless so it inherits as a ratio.","Build sizes from one base and one ratio, held in tokens.","Size type in `rem` so the reader’s own setting is honoured."],"nextUp":"Next: colour and contrast."}'::jsonb
from public.lessons where slug = 'css-readable-type';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why must `line-height` be unitless?","What does `65ch` mean, and why is it better than a pixel width?","Why size type in `rem` rather than `px`?"],"points":["Because it inherits as a ratio, so each element computes its spacing from its own font size. A fixed length inherits as that same length, and large text ends up with lines that collide.","The width of 65 zero-glyphs in the current font — so it tracks the actual typeface rather than guessing. Change the font and the measure stays right.","Because `rem` is relative to the reader’s browser font-size setting, which they may have raised because they need it. A pixel size silently overrides that decision."]}'::jsonb
from public.lessons where slug = 'css-readable-type';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-type-guided', 1, 'guided'::public.exercise_kind, 'Set readable body text',
       'Give `.prose` a `max-width` of `65ch` and a unitless `line-height` of `1.6`. Give `h1` a `font-size` of `2rem` and a `line-height` of `1.1`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Type</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .prose { }
      h1 { }
    </style>
  </head>
  <body>
    <div class="prose">
      <h1>Sourdough, slowly</h1>
      <p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours.</p>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Type</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .prose {
        max-width: 65ch;
        line-height: 1.6;
      }

      h1 {
        font-size: 2rem;
        line-height: 1.1;
      }
    </style>
  </head>
  <body>
    <div class="prose">
      <h1>Sourdough, slowly</h1>
      <p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours.</p>
    </div>
  </body>
</html>', ARRAY['The ch unit measures character widths in the current font.', 'Line height takes no unit — just the number.', 'Large text wants a tighter ratio than body text.']::text[],
       45, 2,
       (select id from public.skills where slug = 'typography'), false
from public.lessons l where l.slug = 'css-readable-type'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.prose', 'max-width',
       '65ch', NULL, NULL, NULL,
       'The measure is constrained', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-type-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.prose', 'line-height',
       '1.6', NULL, NULL, NULL,
       'Body leading is comfortable and unitless', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-type-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, 'h1', 'font-size',
       '2rem', NULL, NULL, NULL,
       'The heading is sized in rem', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-type-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, 'h1', 'line-height',
       '1.1', NULL, NULL, NULL,
       'The heading leading is tightened', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-type-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-readable-type'), NULL, 'q-css-measure', 1, 'single'::public.question_kind,
        'Roughly how many characters per line reads comfortably?', 'About 45–75. Beyond that the return sweep starts to fail.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '45–75', true, NULL
from public.quiz_questions where slug = 'q-css-measure';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '20–30', false, NULL
from public.quiz_questions where slug = 'q-css-measure';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '100–140', false, NULL
from public.quiz_questions where slug = 'q-css-measure';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'As many as fit', false, NULL
from public.quiz_questions where slug = 'q-css-measure';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-readable-type'), NULL, 'q-css-lineheight-unit', 2, 'single'::public.question_kind,
        'Why should `line-height` be unitless?', 'It inherits as a ratio, so each element computes from its own font size.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It inherits as a ratio rather than a fixed length', true, NULL
from public.quiz_questions where slug = 'q-css-lineheight-unit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Units are invalid on line-height', false, NULL
from public.quiz_questions where slug = 'q-css-lineheight-unit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It renders faster', false, NULL
from public.quiz_questions where slug = 'q-css-lineheight-unit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It increases specificity', false, NULL
from public.quiz_questions where slug = 'q-css-lineheight-unit';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-readable-type'), NULL, 'q-css-rem-type', 3, 'single'::public.question_kind,
        'Why size body text in `rem` rather than `px`?', 'It honours the reader’s own browser font-size setting.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'rem is faster to parse', false, NULL
from public.quiz_questions where slug = 'q-css-rem-type';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It respects the reader’s browser font-size setting', true, NULL
from public.quiz_questions where slug = 'q-css-rem-type';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is more precise', false, NULL
from public.quiz_questions where slug = 'q-css-rem-type';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'px is deprecated', false, NULL
from public.quiz_questions where slug = 'q-css-rem-type';
-- lesson: Colour and contrast
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-colour-contrast', 2, 'Colour and contrast', 'Where taste stops and requirements begin', 'Which colours you choose is taste. Whether text can be read against its background is a measurable requirement with a number attached.',
       ARRAY['Explain the WCAG contrast thresholds', 'Build a colour system on roles', 'Never signal meaning by colour alone']::text[], 17, 40, (select id from public.skills where slug = 'typography'), 0.7
from public.modules m where m.slug = 'css-type-colour'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'Light grey text on white looks elegant in the mock-up. What is the problem?',
       NULL, NULL, NULL, '{"options":["It may fail the contrast requirement, which is measurable and not a matter of taste","Grey text renders slowly","Grey is not a valid CSS colour","Nothing — if the designer approved it, it is fine"],"answer":"It probably fails contrast. WCAG sets 4.5:1 for normal body text and 3:1 for large text, and light-grey-on-white routinely lands near 2:1. This is the point where design opinion stops: someone with low vision, or anyone outdoors in sunlight, cannot read it. The number decides, not the mock-up."}'::jsonb
from public.lessons where slug = 'css-colour-contrast';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Apply the 4.5:1 and 3:1 thresholds","Organise colour by role","Pair colour with a second signal"]}'::jsonb
from public.lessons where slug = 'css-colour-contrast';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Contrast ratio', 'A measure of the relative luminance of two colours, from 1:1 (identical) to 21:1 (black on white). Body text needs at least 4.5:1.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-colour-contrast';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'The thresholds', NULL,
       '4.5:1   normal body text                  required
3:1     large text (24px, or 18.7px bold)    required
3:1     UI components and focus indicators   required
7:1     enhanced (AAA) for body text         stricter target

Measured between the text colour and what is actually
behind it — including any background image.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-colour-contrast';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'Colour as the only signal', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Colour plus a second signal","code":".error {\n  color: #b00020;\n  border-left: 3px solid currentColor;\n}\n/* and the message text says \"Error:\" */","why":"Readable to someone who cannot distinguish red from green, and to someone reading a printout in black and white."},"bad":{"label":"Colour alone","code":".error { color: red; }\n.success { color: green; }\n/* the only difference between the two states */","why":"Around one in twelve men cannot reliably tell these apart. The state becomes invisible."}}'::jsonb
from public.lessons where slug = 'css-colour-contrast';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'interactive_demo'::public.block_type, 'Contrast, seen', 'The same text against the same background.',
       NULL, NULL, NULL, '{"variants":[{"label":"Fails","code":"<style>\n  .note { color: #aaa; background: #fff; padding: 1rem; }\n</style>\n<p class=\"note\">Roughly 2.3:1 — under the 4.5:1 requirement for body text.</p>","note":"This is the light-grey-on-white that appears in a great many mock-ups."},{"label":"Passes","code":"<style>\n  .note { color: #595959; background: #fff; padding: 1rem; }\n</style>\n<p class=\"note\">Roughly 7:1 — comfortably over the requirement, and still grey.</p>","note":"Darkening the same hue keeps the intended restraint and clears the threshold."},{"label":"Colour plus a second signal","code":"<style>\n  .error { color: #b00020; border-left: 3px solid currentColor; padding-left: 0.75rem; }\n</style>\n<p class=\"error\">Error: the starter has not been fed for six days.</p>","note":"The border and the word \"Error\" both survive when the colour does not."}]}'::jsonb
from public.lessons where slug = 'css-colour-contrast';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, '`currentColor` keeps a component honest', 'It resolves to whatever `color` is on that element, so a border or an SVG icon follows the text colour automatically — including through every theme override. It is the one keyword that makes "the border matches the text" true by construction rather than by discipline.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-colour-contrast';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'self_explain'::public.block_type, 'Explain it in your own words', 'Your designer says the light grey is intentional and the contrast requirement is a guideline. Write your reply.',
       NULL, NULL, NULL, '{"modelAnswer":"It is not a guideline in the sense of being optional: WCAG 1.4.3 is a level AA success criterion, and in many jurisdictions accessibility conformance is a legal requirement for public-facing services. But the more useful argument is the practical one — the people who cannot read light grey on white include anyone with low vision, anyone over about fifty, and everyone using the site outdoors on a phone, which is a large fraction of real traffic rather than an edge case. The restraint the designer wants is achievable: keep the same hue and darken it until it measures 4.5:1. The design intent survives; the text becomes readable. That is a better outcome than a debate about whether the rule is binding."}'::jsonb
from public.lessons where slug = 'css-colour-contrast';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'checklist'::public.block_type, 'Colour system review', NULL,
       NULL, NULL, NULL, '{"items":["Body text measures at least 4.5:1 against its actual background","Large text and UI components at least 3:1","Focus indicators visible and at least 3:1","No state signalled by colour alone","Colours named by role, so themes can override them","Contrast checked in both light and dark themes"]}'::jsonb
from public.lessons where slug = 'css-colour-contrast';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Contrast is measurable: 4.5:1 for body text, 3:1 for large text and UI.","Never signal meaning by colour alone.","`currentColor` ties borders and icons to the text colour.","Check contrast in every theme, not just the default one."],"nextUp":"Next: the Level 8 milestone."}'::jsonb
from public.lessons where slug = 'css-colour-contrast';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What are the two contrast thresholds, and which text does each cover?","Why is colour-only signalling a failure?","What does `currentColor` resolve to?"],"points":["4.5:1 for normal body text, and 3:1 for large text — 24px, or 18.7px bold — as well as for UI components and focus indicators.","Because a substantial number of readers cannot distinguish the colours in question, and because the signal disappears entirely in greyscale or high-contrast modes. The state has to be carried by something else as well: a word, an icon, a border.","The computed `color` of the element it is used on — so borders, outlines and icons follow the text colour through every theme automatically."]}'::jsonb
from public.lessons where slug = 'css-colour-contrast';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-contrast-debug', 1, 'debug'::public.exercise_kind, 'Fix the contrast failure',
       'Two accessibility faults. The body text is `#aaa` on white, well under 4.5:1 — change it to `#595959`. And `.error` is signalled by colour alone; add `border-left: 3px solid currentColor` so the state survives without colour.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Contrast</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      body { background: #fff; color: #aaa; }

      .error {
        color: #b00020;
        padding-left: 0.75rem;
      }
    </style>
  </head>
  <body>
    <p>The starter doubles in about six hours at room temperature.</p>
    <p class="error">Error: the starter has not been fed for six days.</p>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Contrast</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      body { background: #fff; color: #595959; }

      .error {
        color: #b00020;
        border-left: 3px solid currentColor;
        padding-left: 0.75rem;
      }
    </style>
  </head>
  <body>
    <p>The starter doubles in about six hours at room temperature.</p>
    <p class="error">Error: the starter has not been fed for six days.</p>
  </body>
</html>', ARRAY['Keep the grey, but darken it until it clears 4.5:1.', 'currentColor resolves to the element’s own color.', 'The border gives the state a second, non-colour signal.']::text[],
       55, 3,
       (select id from public.skills where slug = 'typography'), false
from public.lessons l where l.slug = 'css-colour-contrast'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, 'body', 'color',
       '#595959', NULL, NULL, NULL,
       'Body text clears the contrast threshold', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-contrast-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value_matches'::public.requirement_kind, '.error', 'border-left',
       'currentColor', NULL, NULL, NULL,
       'The error state carries a non-colour signal', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-contrast-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.error', 'color',
       '#b00020', NULL, NULL, NULL,
       'The error colour is kept', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-contrast-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-colour-contrast'), NULL, 'q-css-contrast-body', 1, 'single'::public.question_kind,
        'What contrast ratio does normal body text require?', '4.5:1 against its actual background.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '10:1', false, NULL
from public.quiz_questions where slug = 'q-css-contrast-body';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '4.5:1', true, NULL
from public.quiz_questions where slug = 'q-css-contrast-body';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '2:1', false, NULL
from public.quiz_questions where slug = 'q-css-contrast-body';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '3:1', false, NULL
from public.quiz_questions where slug = 'q-css-contrast-body';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-colour-contrast'), NULL, 'q-css-colour-alone', 2, 'single'::public.question_kind,
        'Why is signalling a state by colour alone a failure?', 'Many readers cannot distinguish the colours, and the signal vanishes in greyscale or high-contrast modes.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Readers who cannot distinguish the colours lose the signal entirely', true, NULL
from public.quiz_questions where slug = 'q-css-colour-alone';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Colour is slow to render', false, NULL
from public.quiz_questions where slug = 'q-css-colour-alone';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'CSS colours are unreliable across browsers', false, NULL
from public.quiz_questions where slug = 'q-css-colour-alone';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is only a problem when printing', false, NULL
from public.quiz_questions where slug = 'q-css-colour-alone';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-colour-contrast'), NULL, 'q-css-currentcolor', 3, 'single'::public.question_kind,
        'What does `currentColor` resolve to?', 'The element’s own computed `color`.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The element’s computed `color`', true, NULL
from public.quiz_questions where slug = 'q-css-currentcolor';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The page background', false, NULL
from public.quiz_questions where slug = 'q-css-currentcolor';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The browser default colour', false, NULL
from public.quiz_questions where slug = 'q-css-currentcolor';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The last colour declared in the file', false, NULL
from public.quiz_questions where slug = 'q-css-currentcolor';
-- lesson: Milestone: a readable article
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-type-milestone', 3, 'Milestone: a readable article', 'Scale, measure and contrast together', 'Everything from this level applied to one page of text.',
       ARRAY['Apply a type scale from tokens', 'Constrain measure and set leading', 'Meet the contrast requirement']::text[], 18, 40, (select id from public.skills where slug = 'typography'), 0.8
from public.modules m where m.slug = 'css-type-colour'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Combine scale, measure, leading and contrast into one readable page"]}'::jsonb
from public.lessons where slug = 'css-type-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'The whole level, in five lines', NULL,
       'max-width: 65ch     measure
line-height: 1.6    leading (unitless)
font-size: 1rem     honours the reader''s setting
--text-*            a scale, not ad-hoc numbers
4.5:1               contrast, non-negotiable', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-type-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'recall'::public.block_type, 'From memory', 'From memory: what number belongs with each of these, and why?',
       NULL, NULL, NULL, '{"points":["Comfortable measure — 45–75 characters, because a longer return sweep makes the eye lose its line.","Body leading — about 1.5–1.6, unitless so it inherits as a ratio.","Heading leading — about 1.1, because leading is proportional and large text needs less.","Body-text contrast — 4.5:1, a requirement rather than a preference.","Large-text and UI contrast — 3:1."]}'::jsonb
from public.lessons where slug = 'css-type-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Type decisions come from numbers more often than people expect.","A scale in tokens beats sizes chosen one at a time.","Contrast is measured, not judged."],"nextUp":"Next: transitions and animation."}'::jsonb
from public.lessons where slug = 'css-type-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Which parts of this level are taste, and which are requirements?"],"points":["Taste: which typeface, which ratio for the scale, which hue. Requirements: the contrast thresholds, and honouring the reader''s font-size setting by sizing in `rem`. Measure and leading sit in between — strongly evidenced recommendations rather than pass/fail rules, but you need a reason to depart from them."]}'::jsonb
from public.lessons where slug = 'css-type-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-type-milestone-challenge', 1, 'challenge'::public.exercise_kind, 'Set an article',
       'On `:root` define `--text-base: 1rem` and `--text-2xl: 2rem`. Give `.prose` a `max-width` of `65ch`, `line-height` `1.6`, `font-size` `var(--text-base)` and `color` `#333`. Give `h1` `font-size: var(--text-2xl)` and `line-height: 1.1`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Article</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      body { background: #fff; }
    </style>
  </head>
  <body>
    <article class="prose">
      <h1>Sourdough, slowly</h1>
      <p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours.</p>
    </article>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Article</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root {
        --text-base: 1rem;
        --text-2xl: 2rem;
      }

      body { background: #fff; }

      .prose {
        max-width: 65ch;
        line-height: 1.6;
        font-size: var(--text-base);
        color: #333;
      }

      h1 {
        font-size: var(--text-2xl);
        line-height: 1.1;
      }
    </style>
  </head>
  <body>
    <article class="prose">
      <h1>Sourdough, slowly</h1>
      <p>The starter is a live culture of wild yeast and bacteria, and it works on its own schedule rather than yours.</p>
    </article>
  </body>
</html>', ARRAY['Declare both tokens on :root first.', 'Read them back with var().', 'Line height stays unitless.', '#333 on white is around 12:1 — comfortably over the requirement.']::text[],
       70, 4,
       (select id from public.skills where slug = 'typography'), false
from public.lessons l where l.slug = 'css-type-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.prose', 'max-width',
       '65ch', NULL, NULL, NULL,
       'The measure is constrained', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-type-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.prose', 'line-height',
       '1.6', NULL, NULL, NULL,
       'Leading is comfortable and unitless', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-type-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.prose', 'font-size',
       '1rem', NULL, NULL, NULL,
       'Body size resolves from the token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-type-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, '.prose', 'color',
       '#333', NULL, NULL, NULL,
       'Body text clears the contrast requirement', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-type-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value'::public.requirement_kind, 'h1', 'font-size',
       '2rem', NULL, NULL, NULL,
       'The heading resolves from the scale', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-type-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'css_value'::public.requirement_kind, 'h1', 'line-height',
       '1.1', NULL, NULL, NULL,
       'Heading leading is tightened', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-type-milestone-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-type-milestone'), NULL, 'q-css-scale-benefit', 1, 'single'::public.question_kind,
        'Why derive font sizes from one base and one ratio?', 'The sizes then relate to each other by construction, and the whole page can be adjusted from one place.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Browsers require it', false, NULL
from public.quiz_questions where slug = 'q-css-scale-benefit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It improves specificity', false, NULL
from public.quiz_questions where slug = 'q-css-scale-benefit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The sizes relate to each other, and can be adjusted from one place', true, NULL
from public.quiz_questions where slug = 'q-css-scale-benefit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It reduces file size', false, NULL
from public.quiz_questions where slug = 'q-css-scale-benefit';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-type-milestone'), NULL, 'q-css-heading-leading', 2, 'single'::public.question_kind,
        'Why do large headings want a smaller `line-height` ratio than body text?', 'Leading is proportional, so the same ratio produces a much larger gap at a larger size.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Headings are never more than one line', false, NULL
from public.quiz_questions where slug = 'q-css-heading-leading';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Browsers ignore line-height on headings', false, NULL
from public.quiz_questions where slug = 'q-css-heading-leading';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is required by the spec', false, NULL
from public.quiz_questions where slug = 'q-css-heading-leading';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The ratio is proportional, so a large size produces a large gap', true, NULL
from public.quiz_questions where slug = 'q-css-heading-leading';
-- Level 8 milestone: Typography and Colour questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-8-milestone'), 'a-css-8-measure', 1, 'single'::public.question_kind,
        'Which declaration constrains line length to a comfortable measure?', '`ch` tracks the font, so 65ch stays right when the typeface changes.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`overflow-wrap: break-word`', false, NULL
from public.quiz_questions where slug = 'a-css-8-measure';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`max-width: 65ch`', true, NULL
from public.quiz_questions where slug = 'a-css-8-measure';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`width: 100%`', false, NULL
from public.quiz_questions where slug = 'a-css-8-measure';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`max-width: 100vw`', false, NULL
from public.quiz_questions where slug = 'a-css-8-measure';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-8-milestone'), 'a-css-8-lineheight', 2, 'single'::public.question_kind,
        'What goes wrong with `line-height: 24px` on `body`?', 'It inherits as a fixed length, so large text gets too little line box and the lines collide.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It only applies to the body element', false, NULL
from public.quiz_questions where slug = 'a-css-8-lineheight';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It disables inheritance entirely', false, NULL
from public.quiz_questions where slug = 'a-css-8-lineheight';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Large text inherits 24px and its lines collide', true, NULL
from public.quiz_questions where slug = 'a-css-8-lineheight';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is invalid CSS', false, NULL
from public.quiz_questions where slug = 'a-css-8-lineheight';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-8-milestone'), 'a-css-8-rem', 3, 'single'::public.question_kind,
        'What does sizing type in `rem` preserve?', 'The reader’s own browser font-size setting.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Print layout', false, NULL
from public.quiz_questions where slug = 'a-css-8-rem';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The reader’s browser font-size setting', true, NULL
from public.quiz_questions where slug = 'a-css-8-rem';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Pixel-perfect rendering', false, NULL
from public.quiz_questions where slug = 'a-css-8-rem';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The element’s own font size', false, NULL
from public.quiz_questions where slug = 'a-css-8-rem';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-8-milestone'), 'a-css-8-contrast-large', 4, 'single'::public.question_kind,
        'What contrast ratio do large text and UI components require?', '3:1 — body text is the stricter 4.5:1.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '7:1', false, NULL
from public.quiz_questions where slug = 'a-css-8-contrast-large';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '3:1', true, NULL
from public.quiz_questions where slug = 'a-css-8-contrast-large';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '4.5:1', false, NULL
from public.quiz_questions where slug = 'a-css-8-contrast-large';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '1.5:1', false, NULL
from public.quiz_questions where slug = 'a-css-8-contrast-large';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-8-milestone'), 'a-css-8-second-signal', 5, 'single'::public.question_kind,
        'An error state is shown in red. What else does it need?', 'A second, non-colour signal — a word, an icon or a border.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A larger font size', false, NULL
from public.quiz_questions where slug = 'a-css-8-second-signal';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nothing; red is universally understood', false, NULL
from public.quiz_questions where slug = 'a-css-8-second-signal';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A non-colour signal as well, such as text or an icon', true, NULL
from public.quiz_questions where slug = 'a-css-8-second-signal';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A brighter red', false, NULL
from public.quiz_questions where slug = 'a-css-8-second-signal';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-8-milestone'), 'a-css-8-currentcolor-use', 6, 'single'::public.question_kind,
        'Why use `currentColor` for a component’s border?', 'It follows the text colour through every theme, without a second token or a second rule.', (select id from public.skills where slug = 'typography'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It disables inheritance', false, NULL
from public.quiz_questions where slug = 'a-css-8-currentcolor-use';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The border follows the text colour through every theme automatically', true, NULL
from public.quiz_questions where slug = 'a-css-8-currentcolor-use';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It has higher specificity', false, NULL
from public.quiz_questions where slug = 'a-css-8-currentcolor-use';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is the only way to set a border colour', false, NULL
from public.quiz_questions where slug = 'a-css-8-currentcolor-use';
-- --------------------------------------------------------------------------
-- CSS Architect — Level 9: Transitions and Motion
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'css-motion', 9, 'Transitions and Motion', 'Cheap to animate, and safe to animate',
       'Motion has two constraints that are not matters of taste: only a few properties animate without forcing layout on every frame, and some readers have told their operating system that motion makes them ill.', 'You can build transitions and keyframe animations that stay smooth and that honour a reduced-motion preference.', 'violet'
from public.courses c where c.slug = 'css-architect'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'css-level-9-milestone', 'milestone'::public.assessment_kind, 'Level 9 milestone: Transitions and Motion', 'Six questions on transitions, keyframes, animation cost and reduced motion. Pass mark 75%.',
       0.75, 180, 9
from public.levels l where l.slug = 'css-motion'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Motion that helps
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'css-motion-module', 1, 'Motion that helps', 'Transitions, keyframes, the compositor, and the preference you must respect.',
       52, false
from public.levels l where l.slug = 'css-motion'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'css-motion-module' and p.slug = 'css-type-colour';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'css-motion-module' and s.slug = 'animation';
-- lesson: Transitions
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-transitions', 1, 'Transitions', 'Interpolating between two states', 'A transition does one thing: when a property changes, take some time over it instead of jumping. Everything else is detail about which properties and how long.',
       ARRAY['Write a transition and name the properties explicitly', 'Choose a duration and an easing that suit the change', 'Explain why `transition: all` is a poor default']::text[], 16, 40, (select id from public.skills where slug = 'animation'), 0.7
from public.modules m where m.slug = 'css-motion-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A button has `transition: all 0.3s`. Why is that a worse default than naming the properties?',
       NULL, NULL, NULL, '{"options":["It animates properties you never intended, including expensive ones","`all` is invalid and the transition never runs","It makes the transition twice as slow","Nothing is wrong with it"],"answer":"It animates everything, including properties you did not think about. Add a `:hover` that changes `width` or `padding` later and you have silently signed up for a layout pass on every frame — plus odd behaviour when unrelated properties change, such as a fade-in of a colour you meant to switch instantly. Naming the properties means the transition only ever does what you asked for."}'::jsonb
from public.lessons where slug = 'css-transitions';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Write a transition with explicit properties","Pick a duration in the 150–300ms range and justify it","Explain why easing matters"]}'::jsonb
from public.lessons where slug = 'css-transitions';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Transition', 'An instruction to interpolate a property over time whenever its value changes, rather than switching instantly.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-transitions';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'The shape of it', NULL,
       '.button {
  background: teal;
  transition: background 200ms ease-out;
}
.button:hover { background: darkcyan; }

transition: <property> <duration> <easing> <delay>;
transition: background 200ms ease-out, transform 150ms ease-out;

The transition goes on the *resting* state, not on
:hover — otherwise it only applies on the way in.', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'css-transitions';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'interactive_demo'::public.block_type, 'The same hover, three ways', 'Move the pointer over each.',
       NULL, NULL, NULL, '{"variants":[{"label":"No transition","code":"<style>\n  .button { background: teal; color: #fff; border: 0; padding: 0.6rem 1rem; }\n  .button:hover { background: darkcyan; }\n</style>\n<button class=\"button\">Feed the starter</button>","note":"Instant. Not wrong — but the change is easy to miss."},{"label":"Transitioned","code":"<style>\n  .button { background: teal; color: #fff; border: 0; padding: 0.6rem 1rem; transition: background 200ms ease-out; }\n  .button:hover { background: darkcyan; }\n</style>\n<button class=\"button\">Feed the starter</button>","note":"The eye registers the change without being interrupted by it."},{"label":"Too slow","code":"<style>\n  .button { background: teal; color: #fff; border: 0; padding: 0.6rem 1rem; transition: background 1200ms ease-out; }\n  .button:hover { background: darkcyan; }\n</style>\n<button class=\"button\">Feed the starter</button>","note":"The interface now feels like it is thinking. Anything a user triggers should finish in about 150–300ms."}]}'::jsonb
from public.lessons where slug = 'css-transitions';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'comparison'::public.block_type, 'Naming properties versus `all`', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Explicit","code":".card {\n  transition: background 200ms ease-out,\n              transform 150ms ease-out;\n}","why":"Only these two properties ever animate. Adding a hover that changes padding next month costs nothing."},"bad":{"label":"`transition: all`","code":".card {\n  transition: all 200ms ease-out;\n}","why":"Every future property change becomes an animation, including ones that force layout on every frame. The bug appears months later, in a rule that looks innocent."}}'::jsonb
from public.lessons where slug = 'css-transitions';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'Where the transition declaration belongs', 'On the resting state — `.button`, not `.button:hover`. Put it on `:hover` and the animation runs on the way in but the element snaps back instantly when the pointer leaves, because there is no transition in force at that point. That asymmetry is occasionally what you want, and almost always a mistake.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'css-transitions';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'progressive_detail'::public.block_type, 'Easing, briefly', '`linear` moves at a constant rate and reads as mechanical. `ease-out` starts fast and settles — right for things entering or responding to a click, because the response feels immediate. `ease-in` starts slow, which suits things leaving. `ease-in-out` suits movement between two positions. If you only remember one: `ease-out` for anything the user triggered.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-transitions';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'predict_check'::public.block_type, 'Predict, then check', 'The transition is declared inside `:hover`. Before you check: what happens on the way in, and on the way out?',
       '<style>
  .box { width: 100px; height: 100px; background: teal; }
  .box:hover { transition: background 400ms; background: crimson; }
</style>
<div class="box"></div>', 'html', NULL, '{"outcome":"It fades to crimson over 400ms on the way in, then snaps back to teal instantly when the pointer leaves. On the way out the `:hover` rule no longer applies, so the transition declaration is gone with it and there is nothing left to interpolate. Moving the declaration to `.box` makes both directions smooth."}'::jsonb
from public.lessons where slug = 'css-transitions';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["A transition interpolates a property when its value changes.","It belongs on the resting state, not on `:hover`.","Name the properties — `all` animates things you never intended.","User-triggered changes want roughly 150–300ms and `ease-out`."],"nextUp":"Next: keyframes and what is cheap to animate."}'::jsonb
from public.lessons where slug = 'css-transitions';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why does the transition declaration belong on the resting state?","What is wrong with `transition: all`?","Roughly how long should a hover or click response take?"],"points":["Because it has to be in force in both directions. Declared inside `:hover`, it disappears the moment the pointer leaves, so the element snaps back instantly.","It animates every property that ever changes on that element, including ones added later and ones that are expensive to animate. The resulting bug is far from the code that caused it.","About 150–300ms. Faster is barely perceptible; much slower makes the interface feel like it is deliberating."]}'::jsonb
from public.lessons where slug = 'css-transitions';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-transition-guided', 1, 'guided'::public.exercise_kind, 'Transition a button',
       'Give `.button` a transition of `background 200ms ease-out` — on the resting state, not on `:hover`. The hover rule already changes the background.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Transition</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .button {
        background: teal;
        color: #fff;
        border: 0;
        padding: 0.6rem 1rem;
      }

      .button:hover { background: darkcyan; }
    </style>
  </head>
  <body>
    <button class="button">Feed the starter</button>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Transition</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .button {
        background: teal;
        color: #fff;
        border: 0;
        padding: 0.6rem 1rem;
        transition: background 200ms ease-out;
      }

      .button:hover { background: darkcyan; }
    </style>
  </head>
  <body>
    <button class="button">Feed the starter</button>
  </body>
</html>', ARRAY['The transition goes in the .button rule.', 'Name the property rather than using all.', 'The order is property, duration, easing.']::text[],
       45, 2,
       (select id from public.skills where slug = 'animation'), false
from public.lessons l where l.slug = 'css-transitions'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.button', 'transition',
       'background 200ms ease-out', NULL, NULL, NULL,
       'The transition names its property', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-transition-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.button:hover', 'background',
       'darkcyan', NULL, NULL, NULL,
       'The hover state still changes the background', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-transition-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-transitions'), NULL, 'q-css-transition-where', 1, 'single'::public.question_kind,
        'Where should the `transition` declaration go?', 'On the resting state, so it applies in both directions.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'On the `:hover` state', false, NULL
from public.quiz_questions where slug = 'q-css-transition-where';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'On `body`', false, NULL
from public.quiz_questions where slug = 'q-css-transition-where';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Either; there is no difference', false, NULL
from public.quiz_questions where slug = 'q-css-transition-where';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'On the resting state', true, NULL
from public.quiz_questions where slug = 'q-css-transition-where';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-transitions'), NULL, 'q-css-transition-all', 2, 'single'::public.question_kind,
        'Why avoid `transition: all`?', 'It animates properties you never intended, including expensive ones added later.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It disables easing', false, NULL
from public.quiz_questions where slug = 'q-css-transition-all';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It animates properties you never intended', true, NULL
from public.quiz_questions where slug = 'q-css-transition-all';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is invalid CSS', false, NULL
from public.quiz_questions where slug = 'q-css-transition-all';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It doubles the duration', false, NULL
from public.quiz_questions where slug = 'q-css-transition-all';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-transitions'), NULL, 'q-css-duration', 3, 'single'::public.question_kind,
        'Roughly how long should a user-triggered transition last?', '150–300ms. Longer and the interface feels slow.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '1–2 seconds', false, NULL
from public.quiz_questions where slug = 'q-css-duration';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'As long as looks pleasing', false, NULL
from public.quiz_questions where slug = 'q-css-duration';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '150–300ms', true, NULL
from public.quiz_questions where slug = 'q-css-duration';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '20–40ms', false, NULL
from public.quiz_questions where slug = 'q-css-duration';
-- lesson: Keyframes, cost and consent
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-keyframes-motion', 2, 'Keyframes, cost and consent', 'The compositor, and `prefers-reduced-motion`', 'Two constraints decide most animation questions: which properties the browser can animate without recalculating layout, and whether the reader has asked for less motion.',
       ARRAY['Write a keyframe animation', 'Animate only `transform` and `opacity` where possible', 'Honour `prefers-reduced-motion`']::text[], 18, 40, (select id from public.skills where slug = 'animation'), 0.7
from public.modules m where m.slug = 'css-motion-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'Why animate `transform: translateX()` rather than `left`?',
       NULL, NULL, NULL, '{"options":["Transform is handled by the compositor, so no layout is recalculated per frame","Transform is newer syntax for the same thing","`left` only works on positioned elements","There is no difference in practice"],"answer":"Because `transform` and `opacity` can be handled by the compositor — the browser can move or fade an already-painted layer without recalculating layout or repainting. Animating `left`, `width`, `margin` or `top` forces the browser to redo layout on every single frame, for the element and often for everything around it. On a mid-range phone that is the difference between smooth and visibly stuttering."}'::jsonb
from public.lessons where slug = 'css-keyframes-motion';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Define and apply a `@keyframes` animation","Name the two properties that are cheap to animate","Write a reduced-motion block that actually works"]}'::jsonb
from public.lessons where slug = 'css-keyframes-motion';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'Keyframes', NULL,
       '@keyframes fade-up {
  from { opacity: 0; transform: translateY(8px); }
  to   { opacity: 1; transform: none; }
}

.panel {
  animation: fade-up 250ms ease-out;
}

animation: <name> <duration> <easing> <delay>
           <iteration-count> <direction> <fill-mode>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'css-keyframes-motion';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'worked_example'::public.block_type, 'Cheap animation, and consent', 'The two constraints, applied to one panel.',
       NULL, NULL, NULL, '{"steps":[{"title":"Animate transform and opacity only","code":"@keyframes fade-up {\n  from { opacity: 0; transform: translateY(8px); }\n  to   { opacity: 1; transform: none; }\n}","reasoning":"Both are compositor properties. The same effect written with `margin-top` and `visibility` would force a layout pass on every frame and would not fade at all."},{"title":"Keep it short","code":".panel { animation: fade-up 250ms ease-out; }","reasoning":"Entrance animation should be over before the reader has finished deciding to look at it. A long entrance is a delay wearing a costume."},{"title":"Ask whether motion is welcome","code":"@media (prefers-reduced-motion: reduce) {\n  .panel { animation: none; }\n}","reasoning":"This media query reports a setting the reader has already changed in their operating system. For people with vestibular disorders, large motion can cause genuine nausea and dizziness — this is not a preference about taste."},{"title":"Or reduce globally, once","code":"@media (prefers-reduced-motion: reduce) {\n  *, *::before, *::after {\n    animation-duration: 0.01ms !important;\n    animation-iteration-count: 1 !important;\n    transition-duration: 0.01ms !important;\n    scroll-behavior: auto !important;\n  }\n}","reasoning":"One block that catches everything, including animations added later by someone who forgot. This is one of the very few defensible uses of `!important`: it is a deliberate override of author styles on the reader''s behalf, and it must win."}]}'::jsonb
from public.lessons where slug = 'css-keyframes-motion';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'interactive_demo'::public.block_type, 'Compositor properties versus layout properties', 'Both move the box the same distance.',
       NULL, NULL, NULL, '{"variants":[{"label":"transform (cheap)","code":"<style>\n  @keyframes slide-t { from { transform: translateX(0); } to { transform: translateX(120px); } }\n  .box { width: 60px; height: 60px; background: teal; animation: slide-t 1.2s ease-in-out infinite alternate; }\n</style>\n<div class=\"box\"></div>","note":"The browser moves an existing layer. No layout, no repaint."},{"label":"left (expensive)","code":"<style>\n  @keyframes slide-l { from { left: 0; } to { left: 120px; } }\n  .box { position: relative; width: 60px; height: 60px; background: crimson; animation: slide-l 1.2s ease-in-out infinite alternate; }\n</style>\n<div class=\"box\"></div>","note":"Identical to look at here, and a layout recalculation on every frame. On a slow device this is where the stutter comes from."},{"label":"Reduced motion respected","code":"<style>\n  @keyframes slide-t { from { transform: translateX(0); } to { transform: translateX(120px); } }\n  .box { width: 60px; height: 60px; background: teal; animation: slide-t 1.2s ease-in-out infinite alternate; }\n  @media (prefers-reduced-motion: reduce) { .box { animation: none; } }\n</style>\n<div class=\"box\"></div>","note":"If your system is set to reduce motion, this box is still. If not, it moves. Either way the reader got what they asked for."}]}'::jsonb
from public.lessons where slug = 'css-keyframes-motion';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Reduced motion is a medical setting for some readers', 'Vestibular disorders affect a meaningful share of adults, and large parallax or sliding motion can cause real nausea, dizziness and migraine. `prefers-reduced-motion: reduce` is how those readers have already told every site on the web. Ignoring it is not a missed nicety; it is overriding an explicit request that took effort to make.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'css-keyframes-motion';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'self_explain'::public.block_type, 'Explain it in your own words', 'Reduced motion is set. Should every animation stop, or is that too blunt?',
       NULL, NULL, NULL, '{"modelAnswer":"Too blunt in principle, though blunt is far better than nothing. The preference means \"reduce\", not \"eliminate\": what causes trouble is large-scale movement — parallax, big slides across the viewport, spinning, zooming, anything suggesting the page itself is moving. A short opacity fade is usually fine and often still helpful, because it preserves the sense that something changed. The good pattern is to replace motion with a fade rather than remove the feedback entirely, and to keep animations that convey state — a loading spinner still needs to indicate that work is happening. Where a distinction is too fiddly to make, the global override is the right default: a still interface is usable, and a nauseating one is not."}'::jsonb
from public.lessons where slug = 'css-keyframes-motion';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'checklist'::public.block_type, 'Motion review', NULL,
       NULL, NULL, NULL, '{"items":["Animating `transform` and `opacity` wherever the effect allows","No animation of `width`, `height`, `top`, `left` or `margin` in a loop","User-triggered transitions in the 150–300ms range","A `prefers-reduced-motion: reduce` block present","Large movement removed under reduced motion; short fades may remain","State-conveying animation such as a loading indicator kept"]}'::jsonb
from public.lessons where slug = 'css-keyframes-motion';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`transform` and `opacity` are the compositor-friendly properties.","Animating layout properties costs a layout pass on every frame.","`prefers-reduced-motion: reduce` reports a setting the reader already made.","Reduce means replace large motion with a fade — not necessarily remove all feedback."],"nextUp":"Next: the Level 9 milestone."}'::jsonb
from public.lessons where slug = 'css-keyframes-motion';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Which two properties are cheap to animate, and why?","What does animating `left` cost that animating `translateX` does not?","Does reduced motion mean no animation at all?"],"points":["`transform` and `opacity`, because the compositor can move or fade an already-painted layer without redoing layout or paint.","A layout recalculation on every frame, for the element and often its surroundings — which is where stutter on mid-range devices comes from.","No. It means reduce: remove large movement, keep short fades and anything that conveys state, such as a loading indicator. A global kill-switch is a reasonable default when finer judgement is impractical."]}'::jsonb
from public.lessons where slug = 'css-keyframes-motion';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-motion-guided', 1, 'guided'::public.exercise_kind, 'Animate cheaply, and ask first',
       'Define a `@keyframes fade-up` going from `opacity: 0; transform: translateY(8px)` to `opacity: 1; transform: none`. Apply it to `.panel` as `fade-up 250ms ease-out`. Then add a `@media (prefers-reduced-motion: reduce)` block setting `animation: none` on `.panel`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Motion</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .panel {
        background: #f4f4f4;
        padding: 1rem;
      }
    </style>
  </head>
  <body>
    <div class="panel">The starter doubles in about six hours.</div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Motion</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      @keyframes fade-up {
        from { opacity: 0; transform: translateY(8px); }
        to   { opacity: 1; transform: none; }
      }

      .panel {
        background: #f4f4f4;
        padding: 1rem;
        animation: fade-up 250ms ease-out;
      }

      @media (prefers-reduced-motion: reduce) {
        .panel { animation: none; }
      }
    </style>
  </head>
  <body>
    <div class="panel">The starter doubles in about six hours.</div>
  </body>
</html>', ARRAY['@keyframes takes a name, then from and to blocks.', 'Only opacity and transform belong in the keyframes.', 'The media query goes after the rule it overrides.']::text[],
       55, 3,
       (select id from public.skills where slug = 'animation'), false
from public.lessons l where l.slug = 'css-keyframes-motion'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value_matches'::public.requirement_kind, '.panel', 'animation',
       'fade-up', NULL, NULL, NULL,
       'The panel runs the named animation', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-motion-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_media_rule'::public.requirement_kind, NULL, NULL,
       '(prefers-reduced-motion: reduce)', NULL, NULL, NULL,
       'A reduced-motion block is present', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-motion-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.panel', 'animation',
       'none', NULL, NULL, NULL,
       'Motion is removed when reduced motion is requested', NULL, 1, true, '(prefers-reduced-motion: reduce)'
from public.exercises e where e.slug = 'css-motion-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-motion-debug', 2, 'debug'::public.exercise_kind, 'Expensive, and unasked for',
       'Two faults. The animation moves the box with `left`, which forces layout on every frame — rewrite the keyframes to use `transform: translateX()` for the same 120px movement, and remove `position: relative` since it is no longer needed. And there is no reduced-motion block; add one setting `animation: none` on `.box`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Motion</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      @keyframes slide {
        from { left: 0; }
        to   { left: 120px; }
      }

      .box {
        position: relative;
        width: 60px;
        height: 60px;
        background: teal;
        animation: slide 1.2s ease-in-out infinite alternate;
      }
    </style>
  </head>
  <body>
    <div class="box"></div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Motion</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      @keyframes slide {
        from { transform: translateX(0); }
        to   { transform: translateX(120px); }
      }

      .box {
        width: 60px;
        height: 60px;
        background: teal;
        animation: slide 1.2s ease-in-out infinite alternate;
      }

      @media (prefers-reduced-motion: reduce) {
        .box { animation: none; }
      }
    </style>
  </head>
  <body>
    <div class="box"></div>
  </body>
</html>', ARRAY['translateX moves an element without touching layout.', 'Once nothing uses left, the element does not need positioning.', 'The reduced-motion block goes last so it wins on source order.']::text[],
       55, 3,
       (select id from public.skills where slug = 'animation'), false
from public.lessons l where l.slug = 'css-keyframes-motion'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_media_rule'::public.requirement_kind, NULL, NULL,
       '(prefers-reduced-motion: reduce)', NULL, NULL, NULL,
       'A reduced-motion block is present', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-motion-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.box', 'animation',
       'none', NULL, NULL, NULL,
       'Motion stops when reduced motion is requested', NULL, 1, true, '(prefers-reduced-motion: reduce)'
from public.exercises e where e.slug = 'css-motion-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_property_absent'::public.requirement_kind, '.box', 'position',
       NULL, NULL, NULL, NULL,
       'The redundant positioning is gone', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-motion-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-keyframes-motion'), NULL, 'q-css-cheap-props', 1, 'single'::public.question_kind,
        'Which two properties can the compositor animate without a layout pass?', '`transform` and `opacity`.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`transform` and `opacity`', true, NULL
from public.quiz_questions where slug = 'q-css-cheap-props';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`width` and `height`', false, NULL
from public.quiz_questions where slug = 'q-css-cheap-props';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`top` and `left`', false, NULL
from public.quiz_questions where slug = 'q-css-cheap-props';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`margin` and `padding`', false, NULL
from public.quiz_questions where slug = 'q-css-cheap-props';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-keyframes-motion'), NULL, 'q-css-reduced-motion', 2, 'single'::public.question_kind,
        'What does `prefers-reduced-motion: reduce` tell you?', 'That the reader has asked their operating system for less motion.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Animations are unsupported', false, NULL
from public.quiz_questions where slug = 'q-css-reduced-motion';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The reader has set a system-level preference for less motion', true, NULL
from public.quiz_questions where slug = 'q-css-reduced-motion';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The device is low-powered', false, NULL
from public.quiz_questions where slug = 'q-css-reduced-motion';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The battery is low', false, NULL
from public.quiz_questions where slug = 'q-css-reduced-motion';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-keyframes-motion'), NULL, 'q-css-keyframes-name', 3, 'single'::public.question_kind,
        'What connects a `@keyframes` block to an element?', 'The animation name, referenced by the `animation` property.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The selector inside the keyframes block', false, NULL
from public.quiz_questions where slug = 'q-css-keyframes-name';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Source order', false, NULL
from public.quiz_questions where slug = 'q-css-keyframes-name';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A data attribute', false, NULL
from public.quiz_questions where slug = 'q-css-keyframes-name';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The name, referenced in the `animation` property', true, NULL
from public.quiz_questions where slug = 'q-css-keyframes-name';
-- lesson: Milestone: motion with consent
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-motion-milestone', 3, 'Milestone: motion with consent', 'A transition, an animation and a preference honoured', 'Everything from this level on one component.',
       ARRAY['Transition a hover state explicitly', 'Animate an entrance with compositor properties', 'Honour reduced motion globally']::text[], 18, 40, (select id from public.skills where slug = 'animation'), 0.8
from public.modules m where m.slug = 'css-motion-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Combine transitions, keyframes and a reduced-motion override into one component"]}'::jsonb
from public.lessons where slug = 'css-motion-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'The whole level', NULL,
       'transition: <prop> 200ms ease-out     name the property
@keyframes … transform / opacity      cheap to animate
animation: <name> 250ms ease-out      short entrance
@media (prefers-reduced-motion: reduce)
  → animation-duration: 0.01ms !important

The last one is the only !important in this course
that is not a mistake.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-motion-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'recall'::public.block_type, 'From memory', 'From memory: what is each of these for?',
       NULL, NULL, NULL, '{"points":["`transition` on the resting state — smooth in both directions when a value changes.","`@keyframes` — a named sequence of states, applied with `animation`.","`transform` / `opacity` — the properties the compositor can animate without a layout pass.","`ease-out` — the default easing for anything the user triggered.","`prefers-reduced-motion: reduce` — the reader has asked for less motion; comply."]}'::jsonb
from public.lessons where slug = 'css-motion-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Motion has a cost model and a consent model, and both are non-negotiable.","Name transition properties; animate transform and opacity.","A global reduced-motion block catches what you forget."],"nextUp":"Next: architecture and naming."}'::jsonb
from public.lessons where slug = 'css-motion-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why is `!important` defensible in the reduced-motion override and almost nowhere else?"],"points":["Because it is not an author winning an argument with another author — it is a deliberate override applied on the reader''s behalf, against every animation in the stylesheet including ones added later by someone who did not think about it. It has to win, it is scoped to one media query, and there is no other mechanism that reaches rules you have not written yet."]}'::jsonb
from public.lessons where slug = 'css-motion-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-motion-milestone-challenge', 1, 'challenge'::public.exercise_kind, 'A card that moves considerately',
       'Give `.card` a `transition` of `transform 200ms ease-out` and a `:hover` that sets `transform: translateY(-4px)`. Define `@keyframes fade-up` from `opacity: 0; transform: translateY(8px)` to `opacity: 1; transform: none`, and apply it to `.card` as part of the same rule using the `animation` property with `fade-up 250ms ease-out`. Then add a `@media (prefers-reduced-motion: reduce)` block that sets `animation: none` and `transition: none` on `.card`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Motion milestone</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card {
        background: #f4f4f4;
        padding: 1rem;
        border-radius: 0.5rem;
      }
    </style>
  </head>
  <body>
    <div class="card">Sourdough workshop</div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Motion milestone</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      @keyframes fade-up {
        from { opacity: 0; transform: translateY(8px); }
        to   { opacity: 1; transform: none; }
      }

      .card {
        background: #f4f4f4;
        padding: 1rem;
        border-radius: 0.5rem;
        animation: fade-up 250ms ease-out;
        transition: transform 200ms ease-out;
      }

      .card:hover { transform: translateY(-4px); }

      @media (prefers-reduced-motion: reduce) {
        .card {
          animation: none;
          transition: none;
        }
      }
    </style>
  </head>
  <body>
    <div class="card">Sourdough workshop</div>
  </body>
</html>', ARRAY['Both the animation and the transition go on .card itself.', 'The hover rule only needs the transform.', 'The reduced-motion block turns both off.', 'Keep the keyframes to opacity and transform.']::text[],
       70, 4,
       (select id from public.skills where slug = 'animation'), false
from public.lessons l where l.slug = 'css-motion-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.card', 'transition',
       'transform 200ms ease-out', NULL, NULL, NULL,
       'The transition names its property', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-motion-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value_matches'::public.requirement_kind, '.card:hover', 'transform',
       'translateY', NULL, NULL, NULL,
       'The hover state moves with transform', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-motion-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value_matches'::public.requirement_kind, '.card', 'animation',
       'fade-up', NULL, NULL, NULL,
       'The entrance animation is applied', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-motion-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_media_rule'::public.requirement_kind, NULL, NULL,
       '(prefers-reduced-motion: reduce)', NULL, NULL, NULL,
       'A reduced-motion block is present', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-motion-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value'::public.requirement_kind, '.card', 'animation',
       'none', NULL, NULL, NULL,
       'The animation stops under reduced motion', NULL, 1, true, '(prefers-reduced-motion: reduce)'
from public.exercises e where e.slug = 'css-motion-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'css_value'::public.requirement_kind, '.card', 'transition',
       'none', NULL, NULL, NULL,
       'The transition stops under reduced motion', NULL, 1, true, '(prefers-reduced-motion: reduce)'
from public.exercises e where e.slug = 'css-motion-milestone-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-motion-milestone'), NULL, 'q-css-motion-both', 1, 'single'::public.question_kind,
        'A card has both an entrance animation and a hover transition. What must the reduced-motion block do?', 'Turn off both — the preference covers all motion, not just keyframes.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Disable the transition only', false, NULL
from public.quiz_questions where slug = 'q-css-motion-both';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Halve both durations', false, NULL
from public.quiz_questions where slug = 'q-css-motion-both';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Disable both', true, NULL
from public.quiz_questions where slug = 'q-css-motion-both';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Disable the animation only', false, NULL
from public.quiz_questions where slug = 'q-css-motion-both';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-motion-milestone'), NULL, 'q-css-motion-important', 2, 'single'::public.question_kind,
        'Why is `!important` acceptable inside a global reduced-motion override?', 'It is applied on the reader’s behalf and has to beat every author rule, including ones written later.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`!important` is required inside media queries', false, NULL
from public.quiz_questions where slug = 'q-css-motion-important';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Media queries have no specificity otherwise', false, NULL
from public.quiz_questions where slug = 'q-css-motion-important';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It makes the override faster', false, NULL
from public.quiz_questions where slug = 'q-css-motion-important';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It must beat every author rule, including ones not yet written', true, NULL
from public.quiz_questions where slug = 'q-css-motion-important';
-- Level 9 milestone: Transitions and Motion questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-9-milestone'), 'a-css-9-transition-place', 1, 'single'::public.question_kind,
        'A hover effect fades in but snaps back out. What is wrong?', 'The transition was declared inside `:hover`, so it disappears when the pointer leaves.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The duration is too short', false, NULL
from public.quiz_questions where slug = 'a-css-9-transition-place';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The easing is wrong', false, NULL
from public.quiz_questions where slug = 'a-css-9-transition-place';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`:hover` cannot be transitioned', false, NULL
from public.quiz_questions where slug = 'a-css-9-transition-place';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The transition is declared on `:hover` instead of the resting state', true, NULL
from public.quiz_questions where slug = 'a-css-9-transition-place';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-9-milestone'), 'a-css-9-compositor', 2, 'single'::public.question_kind,
        'Why is animating `transform` cheaper than animating `left`?', 'The compositor can move an existing layer; `left` forces layout on every frame.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Transforms are cached by the server', false, NULL
from public.quiz_questions where slug = 'a-css-9-compositor';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It avoids a layout recalculation on every frame', true, NULL
from public.quiz_questions where slug = 'a-css-9-compositor';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It uses fewer keyframes', false, NULL
from public.quiz_questions where slug = 'a-css-9-compositor';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`left` is deprecated', false, NULL
from public.quiz_questions where slug = 'a-css-9-compositor';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-9-milestone'), 'a-css-9-all', 3, 'single'::public.question_kind,
        'What is the risk of `transition: all`?', 'Properties added later animate silently, including expensive ones.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It is ignored by browsers', false, NULL
from public.quiz_questions where slug = 'a-css-9-all';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Properties added later start animating without being asked to', true, NULL
from public.quiz_questions where slug = 'a-css-9-all';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It applies only to the first property', false, NULL
from public.quiz_questions where slug = 'a-css-9-all';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It disables the easing function', false, NULL
from public.quiz_questions where slug = 'a-css-9-all';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-9-milestone'), 'a-css-9-preference-meaning', 4, 'single'::public.question_kind,
        'Reduced motion is set. What is the right response?', 'Remove large movement; short fades and state indicators may remain.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Ignore it unless the device is slow', false, NULL
from public.quiz_questions where slug = 'a-css-9-preference-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Remove all visual feedback of any kind', false, NULL
from public.quiz_questions where slug = 'a-css-9-preference-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Show a prompt asking the reader to confirm', false, NULL
from public.quiz_questions where slug = 'a-css-9-preference-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Remove large movement, keeping fades and state indicators', true, NULL
from public.quiz_questions where slug = 'a-css-9-preference-meaning';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-9-milestone'), 'a-css-9-why-preference', 5, 'single'::public.question_kind,
        'Why does reduced motion matter beyond preference?', 'Large motion can cause nausea, dizziness and migraine for people with vestibular disorders.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It affects search ranking', false, NULL
from public.quiz_questions where slug = 'a-css-9-why-preference';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Older browsers cannot animate', false, NULL
from public.quiz_questions where slug = 'a-css-9-why-preference';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Motion can make some readers physically unwell', true, NULL
from public.quiz_questions where slug = 'a-css-9-why-preference';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Animation drains the battery', false, NULL
from public.quiz_questions where slug = 'a-css-9-why-preference';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-9-milestone'), 'a-css-9-easing-default', 6, 'single'::public.question_kind,
        'Which easing suits something the user just triggered?', '`ease-out` — fast at first, so the response feels immediate.', (select id from public.skills where slug = 'animation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`ease-in`', false, NULL
from public.quiz_questions where slug = 'a-css-9-easing-default';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`linear`', false, NULL
from public.quiz_questions where slug = 'a-css-9-easing-default';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`steps(4)`', false, NULL
from public.quiz_questions where slug = 'a-css-9-easing-default';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`ease-out`', true, NULL
from public.quiz_questions where slug = 'a-css-9-easing-default';
-- --------------------------------------------------------------------------
-- CSS Architect — Level 10: Architecture and Scale
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'css-architecture-level', 10, 'Architecture and Scale', 'Stylesheets that survive being worked on',
       'Two things destroy stylesheets over time: specificity that only ever climbs, and rules nobody can prove are unused. Both are prevented by conventions that cost nothing on day one.', 'You can structure a stylesheet so that deleting a component deletes its CSS, and no rule needs `!important` to win.', 'violet'
from public.courses c where c.slug = 'css-architect'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'css-level-10-milestone', 'milestone'::public.assessment_kind, 'Level 10 milestone: Architecture and Scale', 'Six questions on naming, specificity, layers and deletability. Pass mark 75%.',
       0.75, 190, 10
from public.levels l where l.slug = 'css-architecture-level'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Naming, layering and scale
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'css-architecture-module', 1, 'Naming, layering and scale', 'Flat specificity, honest names, and the discipline that makes CSS deletable.',
       52, false
from public.levels l where l.slug = 'css-architecture-level'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'css-architecture-module' and p.slug = 'css-motion-module';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'css-architecture-module' and s.slug = 'css-architecture';
-- lesson: Naming and flat specificity
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-naming', 1, 'Naming and flat specificity', 'Why one class is usually the right answer', 'A convention that keeps almost every selector at one class removes the entire category of bug where a rule cannot be overridden without escalating.',
       ARRAY['Name components by what they are', 'Keep selectors to a single class', 'Explain why `!important` makes things worse']::text[], 17, 40, (select id from public.skills where slug = 'css-architecture'), 0.7
from public.modules m where m.slug = 'css-architecture-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A rule will not override. Adding `!important` fixes it. What has actually happened?',
       NULL, NULL, NULL, '{"options":["The next override now needs `!important` too — the problem was moved, not solved","The rule became faster","The specificity was reset to zero","Nothing; `!important` is the intended tool for this"],"answer":"The problem moved. `!important` beats everything below it, so the next person who needs to override that rule has no option left but another `!important` — and after that, nothing. Every escalation removes a rung from the ladder you are standing on. The actual fix is almost always to lower the specificity of the rule that was too strong."}'::jsonb
from public.lessons where slug = 'css-naming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Apply a naming convention consistently","Keep selectors flat","Diagnose a specificity war"]}'::jsonb
from public.lessons where slug = 'css-naming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Specificity war', 'A stylesheet where each override needs to be stronger than the last, ending in `!important` and then in nothing.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-naming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'A naming convention', NULL,
       '.card                 the component
.card__title          a part of it
.card--featured       a variant of it

One class of specificity, whatever the nesting depth.
The name says what it is, so the markup and the
stylesheet can be read against each other.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-naming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'Flat versus nested', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Flat — one class","code":".card { }\n.card__title { }\n.card--featured { }","why":"Every rule is the same weight, so source order decides and any of them can be overridden by any other. The selector also does not care where the element sits, so the component can be moved."},"bad":{"label":"Nested and specific","code":"#main .content .card h2 { }","why":"Needs an equally deep selector to override, and breaks the moment the component is used outside `#main`. The specificity is 1-2-1 and there is no way down from there except `!important`."}}'::jsonb
from public.lessons where slug = 'css-naming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'interactive_demo'::public.block_type, 'Escalation, and the way out', 'The same override, done twice.',
       NULL, NULL, NULL, '{"variants":[{"label":"The war","code":"<style>\n  #main .card p { color: crimson; }\n  .note { color: teal; }\n</style>\n<div id=\"main\"><div class=\"card\"><p class=\"note\">Meant to be teal, and is not.</p></div></div>","note":"The `.note` class cannot win: 1-2-1 against 0-1-0. The tempting fix is `!important`."},{"label":"Escalated","code":"<style>\n  #main .card p { color: crimson; }\n  .note { color: teal !important; }\n</style>\n<div id=\"main\"><div class=\"card\"><p class=\"note\">Teal now — at a price.</p></div></div>","note":"It works, and the next override of `.note` has nowhere left to go."},{"label":"Fixed properly","code":"<style>\n  .card p { color: crimson; }\n  .note { color: teal; }\n</style>\n<div id=\"main\"><div class=\"card\"><p class=\"note\">Teal, and still overridable.</p></div></div>","note":"Lower the rule that was too strong. Now source order decides, and everything stays adjustable."}]}'::jsonb
from public.lessons where slug = 'css-naming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'A budget makes this checkable', 'Adopt a rule such as "no selector above one class" and it stops being a matter of judgement. Anything that needs to be stronger is a sign the component wants a variant class rather than a deeper selector — which is also the change that makes it reusable.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-naming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'predict_check'::public.block_type, 'Predict, then check', 'Both rules target the same element and the class rule comes first. Before you check: what colour is it?',
       '<style>
  .button { background: teal; }
  a.button { background: crimson; }
</style>
<a href="#" class="button">Link button</a>', 'html', NULL, '{"outcome":"Crimson. `a.button` is 0-1-1 against `.button` at 0-1-0, so it wins regardless of order. This is how specificity creeps in without anyone deciding to escalate: adding the element name feels like a clarification rather than an escalation, but it permanently outranks the plain class and every later `.button` override has to account for it."}'::jsonb
from public.lessons where slug = 'css-naming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'progressive_detail'::public.block_type, 'Why names beat appearances', '`.card--featured` still makes sense when the design changes; `.card--yellow` becomes a lie the first time the highlight turns blue, and you are left with `class="card--yellow"` on a blue box. The same reasoning as `--surface` over `--white` in the tokens level, applied to class names: name the role or the meaning, and the name survives redesigns. Utility classes such as `.mt-4` are a deliberate exception — they name exactly what they do and are read as such.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-naming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Keep almost every selector at one class.","Name components after what they are, not what they look like.","`!important` moves a problem rather than solving it.","The real fix for \"will not override\" is lowering the rule that was too strong."],"nextUp":"Next: scale, layering and deletability."}'::jsonb
from public.lessons where slug = 'css-naming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What does `!important` cost, beyond the immediate fix?","Why does `a.button` beat `.button` even when it comes first?","Why is `.card--featured` a better name than `.card--yellow`?"],"points":["It removes the last rung of the ladder. Anything that needs to override it must also use `!important`, and after that there is nothing left — so the next override cannot be made at all without editing the original rule.","Specificity is compared before source order. `a.button` is one element plus one class, which outranks one class, so order never gets consulted.","Because the name has to stay true after a redesign. The variant is \"featured\" whatever colour it ends up being; a name that describes the colour becomes actively misleading the moment the colour changes."]}'::jsonb
from public.lessons where slug = 'css-naming';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-naming-debug', 1, 'debug'::public.exercise_kind, 'End the specificity war',
       'The `.note` rule cannot win, so someone reached for `!important`. Fix it properly: replace `#main .card p` with a single class on the card itself — `.card { color: crimson }`, letting the colour inherit down to the paragraph — and remove the `!important` from `.note`. Both rules are then one class, so source order decides and `.note` wins on its own.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Specificity</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      #main .card p { color: crimson; }
      .note { color: teal !important; }
    </style>
  </head>
  <body>
    <div id="main">
      <div class="card">
        <p class="note">This should be teal.</p>
      </div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Specificity</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card { color: crimson; }
      .note { color: teal; }
    </style>
  </head>
  <body>
    <div id="main">
      <div class="card">
        <p class="note">This should be teal.</p>
      </div>
    </div>
  </body>
</html>', ARRAY['The id selector is what made the first rule unbeatable.', 'Colour inherits, so the card can set it for everything inside.', 'Once both rules are one class, source order decides — and .note is second.']::text[],
       55, 3,
       (select id from public.skills where slug = 'css-architecture'), false
from public.lessons l where l.slug = 'css-naming'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_no_important'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No declaration needs !important any more', 'Raising specificity with !important wins this argument and loses the next one — the only way to override it later is another !important.', 1, true, NULL
from public.exercises e where e.slug = 'css-naming-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_max_specificity'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, 256,
       'Every selector is back within a one-class budget', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-naming-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.note', 'color',
       'teal', NULL, NULL, NULL,
       'The note rule now wins on its own', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-naming-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-naming'), NULL, 'q-css-important-escalation', 1, 'single'::public.question_kind,
        'What does adding `!important` cost?', 'The next override needs one too, and after that there is nothing left.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Nothing at all', false, NULL
from public.quiz_questions where slug = 'q-css-important-escalation';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It disables inheritance', false, NULL
from public.quiz_questions where slug = 'q-css-important-escalation';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The next override has nowhere left to escalate to', true, NULL
from public.quiz_questions where slug = 'q-css-important-escalation';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Rendering performance', false, NULL
from public.quiz_questions where slug = 'q-css-important-escalation';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-naming'), NULL, 'q-css-flat-selectors', 2, 'single'::public.question_kind,
        'Why keep selectors to a single class?', 'Equal weight means source order decides, so anything can override anything.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Browsers ignore deeper selectors', false, NULL
from public.quiz_questions where slug = 'q-css-flat-selectors';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It makes rules inherit', false, NULL
from public.quiz_questions where slug = 'q-css-flat-selectors';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Equal weight lets source order decide, so overriding stays possible', true, NULL
from public.quiz_questions where slug = 'q-css-flat-selectors';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Shorter selectors parse faster', false, NULL
from public.quiz_questions where slug = 'q-css-flat-selectors';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-naming'), NULL, 'q-css-name-meaning', 3, 'single'::public.question_kind,
        'Which class name will still be true after a redesign?', 'A name describing the role, not the appearance.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`.card--yellow`', false, NULL
from public.quiz_questions where slug = 'q-css-name-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`.card--big-text`', false, NULL
from public.quiz_questions where slug = 'q-css-name-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`.card--rounded`', false, NULL
from public.quiz_questions where slug = 'q-css-name-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`.card--featured`', true, NULL
from public.quiz_questions where slug = 'q-css-name-meaning';
-- lesson: Scale and deletability
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-scale', 2, 'Scale and deletability', 'CSS nobody is afraid to remove', 'The second thing that kills a stylesheet is uncertainty: rules nobody can prove are unused, so nobody removes them, so the file only grows.',
       ARRAY['Structure a stylesheet so components are self-contained', 'Use `@layer` to order concerns without specificity', 'Explain what makes a rule safe to delete']::text[], 18, 40, (select id from public.skills where slug = 'css-architecture'), 0.7
from public.modules m where m.slug = 'css-architecture-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A stylesheet has grown to 6,000 lines and nobody deletes anything. What is the underlying cause?',
       NULL, NULL, NULL, '{"options":["No one can prove a rule is unused, so removing it feels risky","CSS files cannot be split","Deleting CSS breaks the cascade","The file is too large to edit"],"answer":"Nobody can prove a rule is unused. If a selector might match something, somewhere, in a template nobody has read, then deleting it is a gamble and leaving it is free — so it stays. Every convention in this lesson exists to make that proof easy: if a component owns its own file and its own class prefix, deleting the component deletes its CSS with certainty."}'::jsonb
from public.lessons where slug = 'css-scale';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Give each component its own scope","Order concerns with `@layer`","Recognise what makes CSS safe to remove"]}'::jsonb
from public.lessons where slug = 'css-scale';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Cascade layer', 'A named group declared with `@layer`. Every rule in an earlier layer loses to every rule in a later one, whatever their specificity.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-scale';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'worked_example'::public.block_type, 'A stylesheet you can still work on in a year', 'Four conventions, each preventing a specific failure.',
       NULL, NULL, NULL, '{"steps":[{"title":"One component, one prefix, one place","code":"/* card.css — everything .card, nothing else */\n.card { }\n.card__title { }\n.card--featured { }","reasoning":"The proof of deletability: remove the component from the markup, delete this file, and nothing else can possibly be affected — because nothing else uses the prefix. That certainty is the whole point."},{"title":"Order concerns with layers, not with strength","code":"@layer reset, base, components, utilities;\n\n@layer components { .card { padding: 1rem; } }\n@layer utilities  { .p-0 { padding: 0; } }","reasoning":"A utility beats a component because `utilities` is declared later, not because it is more specific. This is the mechanism that lets a zero-specificity utility win without `!important` — the one honest way to make a weak selector beat a strong one."},{"title":"Keep the reset at zero specificity","code":"@layer reset {\n  :where(h1, h2, h3) { margin-block: 0; }\n}","reasoning":"`:where()` always contributes zero specificity, so nothing ever has to fight the reset. A reset that needs overriding is a reset that was written too strongly."},{"title":"Let the tokens be the shared surface","code":":root { --space: 1rem; }\n.card { padding: var(--space); }\n.panel { padding: var(--space); }","reasoning":"Components share values rather than sharing rules. Nothing couples `.card` to `.panel`, so either can be deleted alone — which would not be true if they shared a `.card, .panel` selector."}]}'::jsonb
from public.lessons where slug = 'css-scale';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'interactive_demo'::public.block_type, 'Layers beat specificity', 'The utility is weaker and still wins.',
       NULL, NULL, NULL, '{"variants":[{"label":"Without layers","code":"<style>\n  .card { padding: 2rem; }\n  .p-0 { padding: 0; }\n</style>\n<div class=\"card p-0\">Both are one class, so source order decides — the utility happens to win.</div>","note":"It works here only because the utility was written second. Move it and it silently loses."},{"label":"With layers","code":"<style>\n  @layer components, utilities;\n  @layer utilities { .p-0 { padding: 0; } }\n  @layer components { .card { padding: 2rem; } }\n</style>\n<div class=\"card p-0\">The utility wins even though it is written first.</div>","note":"The layer order decides, so the file order no longer matters. This is the guarantee `!important` was being misused to provide."}]}'::jsonb
from public.lessons where slug = 'css-scale';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Layers invert what you expect from specificity', 'A one-class rule in a later layer beats an id selector in an earlier one. That is the point — but it does mean the first question when a rule mysteriously loses is "which layer is it in", not "how specific is it". Declare the layer order once, at the top, so the answer is always visible.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'css-scale';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'self_explain'::public.block_type, 'Explain it in your own words', 'What makes a rule safe to delete? Answer as if writing the team convention.',
       NULL, NULL, NULL, '{"modelAnswer":"A rule is safe to delete when you can prove nothing uses it, and that proof has to be cheap or nobody will do it. Three things make it cheap. First, a unique prefix: if every selector in the file starts `.card`, then searching the templates for `card` finds every use, and no other component can be relying on it accidentally. Second, no shared selectors — the moment a rule reads `.card, .panel`, deleting the card means reading the panel too, and the coupling is invisible from either side. Third, no reliance on ambient context: a rule written `#main .card p` might be depended on by anything that ever appears inside `#main`, so its blast radius is the whole page. Flat, prefixed, self-contained rules make deletion a local decision, and a stylesheet where deletion is local is one that stops growing."}'::jsonb
from public.lessons where slug = 'css-scale';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'checklist'::public.block_type, 'Architecture review', NULL,
       NULL, NULL, NULL, '{"items":["Almost every selector is one class","No `!important` outside a reduced-motion or print override","Component names describe what they are, not how they look","Each component owns a prefix and a place","Layer order declared once, near the top","Reset written with `:where()` so it never needs overriding","Shared values live in tokens, not in shared selectors"]}'::jsonb
from public.lessons where slug = 'css-scale';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["A stylesheet stops growing when deleting from it is provably safe.","Prefix and isolate components so deletion is a local decision.","`@layer` orders concerns without touching specificity.","`:where()` keeps a reset at zero specificity."],"nextUp":"Next: the Level 10 milestone."}'::jsonb
from public.lessons where slug = 'css-scale';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What does `@layer` let you do that specificity cannot?","Why does `:where()` suit a reset?","Why is a shared `.card, .panel` selector a liability?"],"points":["Make a weak selector beat a strong one deliberately and predictably. A later layer beats an earlier one whatever the specificity, which is the guarantee people reach for `!important` to get.","It contributes zero specificity, so every author rule outranks it automatically and nobody ever has to fight the reset.","Because it couples two components invisibly. Deleting one means auditing the other, so deletion stops being a local decision — and that is exactly the uncertainty that makes stylesheets grow forever."]}'::jsonb
from public.lessons where slug = 'css-scale';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-layers-guided', 1, 'guided'::public.exercise_kind, 'Order concerns with layers',
       'Declare `@layer components, utilities;` at the top. Put the existing `.card` rule inside a `@layer components` block, and the `.p-0` rule inside a `@layer utilities` block — with the utilities block written *first* in the file, to prove the layer order rather than source order is deciding.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Layers</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .p-0 { padding: 0; }
      .card { padding: 2rem; background: #f4f4f4; }
    </style>
  </head>
  <body>
    <div class="card p-0">No padding, despite the card rule.</div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Layers</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      @layer components, utilities;

      @layer utilities {
        .p-0 { padding: 0; }
      }

      @layer components {
        .card { padding: 2rem; background: #f4f4f4; }
      }
    </style>
  </head>
  <body>
    <div class="card p-0">No padding, despite the card rule.</div>
  </body>
</html>', ARRAY['The @layer declaration lists the order once, before the blocks.', 'Later in the list means it wins.', 'Wrap each existing rule in its layer block without changing the rule itself.']::text[],
       55, 3,
       (select id from public.skills where slug = 'css-architecture'), false
from public.lessons l where l.slug = 'css-scale'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.card', 'padding',
       '0', NULL, NULL, NULL,
       'The utility wins on layer order, not source order', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-layers-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.card', 'background',
       '#f4f4f4', NULL, NULL, NULL,
       'The component rule still applies', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-layers-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_no_important'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The layer order does the work, not !important', 'Raising specificity with !important wins this argument and loses the next one — the only way to override it later is another !important.', 1, true, NULL
from public.exercises e where e.slug = 'css-layers-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_max_specificity'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, 256,
       'No selector needed to be made stronger', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-layers-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-scale'), NULL, 'q-css-layer-order', 1, 'single'::public.question_kind,
        'A rule in an earlier layer versus a rule in a later layer — which wins?', 'The later layer, whatever the specificity of either rule.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The later layer, regardless of specificity', true, NULL
from public.quiz_questions where slug = 'q-css-layer-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The more specific rule', false, NULL
from public.quiz_questions where slug = 'q-css-layer-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Whichever comes later in the file', false, NULL
from public.quiz_questions where slug = 'q-css-layer-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The earlier layer', false, NULL
from public.quiz_questions where slug = 'q-css-layer-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-scale'), NULL, 'q-css-where-reset', 2, 'single'::public.question_kind,
        'Why write a reset with `:where()`?', 'It contributes zero specificity, so nothing ever has to fight it.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It creates a new layer', false, NULL
from public.quiz_questions where slug = 'q-css-where-reset';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It contributes zero specificity', true, NULL
from public.quiz_questions where slug = 'q-css-where-reset';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is faster to match', false, NULL
from public.quiz_questions where slug = 'q-css-where-reset';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It applies only to the first match', false, NULL
from public.quiz_questions where slug = 'q-css-where-reset';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-scale'), NULL, 'q-css-deletable', 3, 'single'::public.question_kind,
        'What makes a rule safe to delete?', 'A unique prefix and no shared selectors, so its use can be proved.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It has low specificity', false, NULL
from public.quiz_questions where slug = 'q-css-deletable';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It is at the end of the file', false, NULL
from public.quiz_questions where slug = 'q-css-deletable';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'You can prove nothing else uses it', true, NULL
from public.quiz_questions where slug = 'q-css-deletable';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is short', false, NULL
from public.quiz_questions where slug = 'q-css-deletable';
-- lesson: Milestone: a stylesheet built to last
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-architecture-milestone', 3, 'Milestone: a stylesheet built to last', 'Flat, layered, named and deletable', 'The conventions from this level applied together.',
       ARRAY['Keep every selector within a one-class budget', 'Order concerns with layers', 'Name components honestly']::text[], 18, 40, (select id from public.skills where slug = 'css-architecture'), 0.8
from public.modules m where m.slug = 'css-architecture-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Apply the whole convention set to one small stylesheet"]}'::jsonb
from public.lessons where slug = 'css-architecture-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'The convention, in full', NULL,
       '@layer reset, base, components, utilities;

:where(...)        reset, zero specificity
.card              one class, always
.card__title       a part
.card--featured    a variant
--space            shared values live here
!important         only for a reader-facing override', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-architecture-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'recall'::public.block_type, 'From memory', 'From memory: what does each convention prevent?',
       NULL, NULL, NULL, '{"points":["One class per selector — prevents specificity wars, because equal weight means order decides.","A prefix per component — prevents undeletable CSS, because use can be proved by searching.","`@layer` — prevents `!important`, by letting a weak rule beat a strong one deliberately.","`:where()` in the reset — prevents fighting your own baseline.","Role-based names — prevents names that lie after a redesign.","Tokens rather than shared selectors — prevents invisible coupling between components."]}'::jsonb
from public.lessons where slug = 'css-architecture-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Every convention here buys back a specific future problem.","Flat specificity keeps overriding possible.","Provable deletability keeps the file from growing forever."],"nextUp":"Next: the developer tools."}'::jsonb
from public.lessons where slug = 'css-architecture-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Which single convention would you keep if you could only have one, and why?"],"points":["Flat specificity — almost every selector at one class. It is the one that keeps every other decision reversible: as long as nothing has escalated, any rule can be overridden by any other and mistakes stay cheap to fix. Deletability is the more valuable property in the long run, but it is unachievable in a stylesheet that has already gone to war with itself."]}'::jsonb
from public.lessons where slug = 'css-architecture-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-architecture-milestone-challenge', 1, 'challenge'::public.exercise_kind, 'Restructure a small stylesheet',
       'Rewrite this to the convention. Declare `@layer components, utilities;`. Replace `#main .card h2` with a `.card__title` class — adding the class to the markup — and `.card.yellow` with `.card--featured`. Put component rules in the components layer and `.p-0` in the utilities layer. Remove every `!important`, and keep every selector within a one-class budget.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Architecture</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      #main .card h2 { font-size: 1.5rem; }
      .card.yellow { border-left: 4px solid crimson; }
      .p-0 { padding: 0 !important; }
      .card { padding: 1rem; background: #f4f4f4; }
    </style>
  </head>
  <body>
    <div id="main">
      <div class="card yellow">
        <h2>Sourdough</h2>
      </div>
      <div class="card p-0">Flush</div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Architecture</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      @layer components, utilities;

      @layer components {
        .card { padding: 1rem; background: #f4f4f4; }
        .card__title { font-size: 1.5rem; }
        .card--featured { border-left: 4px solid crimson; }
      }

      @layer utilities {
        .p-0 { padding: 0; }
      }
    </style>
  </head>
  <body>
    <div id="main">
      <div class="card card--featured">
        <h2 class="card__title">Sourdough</h2>
      </div>
      <div class="card p-0">Flush</div>
    </div>
  </body>
</html>', ARRAY['The heading needs a class in the markup before the selector can use one.', 'A variant is a class on the same element, not a second class chained in the selector.', 'Once .p-0 is in the utilities layer it no longer needs !important.', 'Declare the layer order once, before the blocks.']::text[],
       75, 4,
       (select id from public.skills where slug = 'css-architecture'), false
from public.lessons l where l.slug = 'css-architecture-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_no_important'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Nothing needs !important once the layers are in place', 'Raising specificity with !important wins this argument and loses the next one — the only way to override it later is another !important.', 1, true, NULL
from public.exercises e where e.slug = 'css-architecture-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_max_specificity'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, 256,
       'Every selector is within the one-class budget', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-architecture-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_rule_exists'::public.requirement_kind, NULL, NULL,
       '.card__title', NULL, NULL, NULL,
       'The heading is targeted by its own class', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-architecture-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_rule_exists'::public.requirement_kind, NULL, NULL,
       '.card--featured', NULL, NULL, NULL,
       'The variant is named after what it is', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-architecture-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value'::public.requirement_kind, '.card__title', 'font-size',
       '1.5rem', NULL, NULL, NULL,
       'The title rule still applies', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-architecture-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'css_value'::public.requirement_kind, '.p-0', 'padding',
       '0', NULL, NULL, NULL,
       'The utility still wins, now by layer order', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-architecture-milestone-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-architecture-milestone'), NULL, 'q-css-variant-class', 1, 'single'::public.question_kind,
        'How is a variant applied, in this convention?', 'As a second class on the same element — `.card .card--featured` in the markup.', (select id from public.skills where slug = 'css-architecture'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'An id on the element', false, NULL
from public.quiz_questions where slug = 'q-css-variant-class';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'An `!important` override', false, NULL
from public.quiz_questions where slug = 'q-css-variant-class';

commit;
