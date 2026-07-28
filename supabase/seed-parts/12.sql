-- HTML Hero — course seed, part 12 of 16
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 11 first.

begin;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The last two items are hidden', false, NULL
from public.quiz_questions where slug = 'q-css-implicit-rows';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A second row is created automatically', true, NULL
from public.quiz_questions where slug = 'q-css-implicit-rows';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The extra items overflow the container', false, NULL
from public.quiz_questions where slug = 'q-css-implicit-rows';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The columns shrink to fit five items', false, NULL
from public.quiz_questions where slug = 'q-css-implicit-rows';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-grid-tracks'), NULL, 'q-css-fr-vs-percent', 3, 'single'::public.question_kind,
        'Why can three `33.33%` columns with gaps overflow when `repeat(3, 1fr)` cannot?', 'Percentages are computed from the full width and gaps are added on top; `fr` is a share of what remains after gaps.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Percentages ignore the gaps, which are then added on top', true, NULL
from public.quiz_questions where slug = 'q-css-fr-vs-percent';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Percentages are not valid in grid', false, NULL
from public.quiz_questions where slug = 'q-css-fr-vs-percent';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`fr` rounds down', false, NULL
from public.quiz_questions where slug = 'q-css-fr-vs-percent';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Gaps only apply to `fr` tracks', false, NULL
from public.quiz_questions where slug = 'q-css-fr-vs-percent';
-- lesson: Named areas and responsive grids
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-grid-areas-and-auto-fit', 2, 'Named areas and responsive grids', 'Drawing a layout in the stylesheet, and the one line that replaces a breakpoint', 'Named areas let a layout be readable at a glance. `auto-fit` with `minmax()` makes it responsive without a single media query.',
       ARRAY['Lay out a page with `grid-template-areas`', 'Explain what `auto-fit` and `minmax()` do together', 'Build a responsive grid with no breakpoints']::text[], 18, 40, (select id from public.skills where slug = 'grid'), 0.7
from public.modules m where m.slug = 'css-grid-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'What does `grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr))` do?',
       NULL, NULL, NULL, '{"options":["Fits as many columns of at least 16rem as will fit, and shares the rest between them","Creates exactly 16 columns","Makes every column exactly 16rem wide","Creates one column that is at least 16rem"],"answer":"It fits as many columns as will fit at a minimum of 16rem each, then stretches them to share the leftover space. The number of columns changes with the available width, and you have written **no media query at all** — the layout responds to the space it is actually in rather than to the viewport, so it also works correctly inside a sidebar. This one line is, in practice, the most useful declaration in modern CSS."}'::jsonb
from public.lessons where slug = 'css-grid-areas-and-auto-fit';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Draw a layout with named grid areas","Combine `auto-fit` with `minmax()`","Explain why this beats a breakpoint"]}'::jsonb
from public.lessons where slug = 'css-grid-areas-and-auto-fit';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'Grid can place items by name. You draw the layout as text in the stylesheet, and each item says which area it belongs to.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-grid-areas-and-auto-fit';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'Named areas', NULL,
       '.page {
  display: grid;
  grid-template-areas:
    "header header"
    "sidebar main"
    "footer footer";
  grid-template-columns: 12rem 1fr;
  gap: 1rem;
}

.page > header  { grid-area: header;  }
.page > .side   { grid-area: sidebar; }
.page > main    { grid-area: main;    }
.page > footer  { grid-area: footer;  }

A full stop marks a deliberately empty cell:
    "header header"
    "sidebar ."', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'css-grid-areas-and-auto-fit';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Named areas document themselves', 'The quoted rows are a picture of the layout. Somebody reading the stylesheet six months later can see the page shape without opening the browser — which is not true of `grid-column: 2 / 4`. Prefer areas for page-level layout, and line numbers for the occasional item that spans.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-grid-areas-and-auto-fit';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'worked_example'::public.block_type, 'A responsive card grid, without a single breakpoint', 'Building up the one declaration that does the whole job.',
       NULL, NULL, NULL, '{"steps":[{"title":"Start with a fixed count","code":"grid-template-columns: repeat(3, 1fr);","reasoning":"Three equal columns. Correct on a laptop and unusable on a phone, where each column is about 100px wide."},{"title":"Give each column a minimum","code":"grid-template-columns: repeat(3, minmax(16rem, 1fr));","reasoning":"`minmax(16rem, 1fr)` means \"never narrower than 16rem, otherwise take a fair share\". But the count is still fixed at three, so on a narrow screen the grid now overflows instead of squashing. Worse, not better — yet."},{"title":"Let grid choose the count","code":"grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));","reasoning":"`auto-fit` replaces the fixed number with \"as many as will fit\". Grid works out how many 16rem columns the container can hold, creates that many, and the `1fr` stretches them to fill. One column on a phone, four on a wide screen, and nothing in the stylesheet mentions a device."},{"title":"Know the one difference from `auto-fill`","code":"repeat(auto-fill, minmax(16rem, 1fr))","reasoning":"`auto-fill` keeps the empty tracks it created; `auto-fit` collapses them. With three cards in a container wide enough for five, `auto-fill` leaves two empty columns and the cards stay narrow, while `auto-fit` collapses them so the three cards stretch across. For card layouts you almost always want `auto-fit`."}]}'::jsonb
from public.lessons where slug = 'css-grid-areas-and-auto-fit';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'interactive_demo'::public.block_type, 'auto-fit in action', 'The same declaration, different container widths.',
       NULL, NULL, NULL, '{"variants":[{"label":"The responsive grid","code":"<style>\n  .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(10rem, 1fr)); gap: 1rem; border: 1px solid teal; padding: 1rem; }\n  .grid > div { background: #cde; padding: 1rem; }\n</style>\n<div class=\"grid\"><div>Sourdough</div><div>Rye</div><div>Seeded</div><div>Focaccia</div></div>","note":"Resize the preview. The number of columns changes on its own, and there is no media query anywhere."},{"label":"A named-area page","code":"<style>\n  .page { display: grid; grid-template-areas: \"header header\" \"side main\" \"footer footer\"; grid-template-columns: 8rem 1fr; gap: 0.5rem; border: 1px solid teal; padding: 0.5rem; }\n  .page > * { background: #cde; padding: 0.5rem; }\n  .h { grid-area: header } .s { grid-area: side } .m { grid-area: main } .f { grid-area: footer }\n</style>\n<div class=\"page\"><div class=\"h\">Header</div><div class=\"s\">Side</div><div class=\"m\">Main</div><div class=\"f\">Footer</div></div>","note":"The quoted rows in the CSS are a picture of what you see. Reordering the layout means editing that picture."}]}'::jsonb
from public.lessons where slug = 'css-grid-areas-and-auto-fit';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'self_explain'::public.block_type, 'Explain it in your own words', 'A colleague says `repeat(auto-fit, minmax(16rem, 1fr))` is "just a shortcut for media queries". Write your reply, and be specific about a case where the two genuinely differ.',
       NULL, NULL, NULL, '{"modelAnswer":"It is not a shortcut, it answers a different question. A media query asks how wide the *viewport* is; `auto-fit` asks how much room this *container* actually has. Those agree for a full-width grid and diverge the moment the component is reused. Drop the same card grid into a 20rem sidebar on a 1400px monitor and the media query says \"wide screen, four columns\" and produces four 5rem columns of unreadable text, while `auto-fit` correctly gives one. The same is true inside a modal, a split view, or another grid cell. It is also less code, has no magic numbers to keep in sync with the design, and cannot drift out of step with them."}'::jsonb
from public.lessons where slug = 'css-grid-areas-and-auto-fit';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'progressive_detail'::public.block_type, 'Placing an item across tracks', '`grid-column: 1 / 3` places an item from line 1 to line 3 — remember lines are the edges, so that spans two columns. `grid-column: span 2` says the same thing relative to wherever the item lands. `grid-row` works identically for rows. Lines can be named too, but for page layout `grid-template-areas` is nearly always more readable.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-grid-areas-and-auto-fit';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'checklist'::public.block_type, 'Choosing between flexbox and grid', NULL,
       NULL, NULL, NULL, '{"items":["One dimension — a row *or* a column — is flexbox","Two dimensions at once — rows *and* columns — is grid","Content decides the sizes: flexbox","The layout decides the sizes: grid","A wrapping card row works well in either; grid keeps the columns aligned"]}'::jsonb
from public.lessons where slug = 'css-grid-areas-and-auto-fit';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`grid-template-areas` draws the layout as readable text.","`repeat(auto-fit, minmax(X, 1fr))` is a responsive grid with no media query.","`auto-fit` collapses empty tracks; `auto-fill` keeps them.","Flexbox is one dimension, grid is two."],"nextUp":"Next: the Level 5 milestone."}'::jsonb
from public.lessons where slug = 'css-grid-areas-and-auto-fit';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What does `repeat(auto-fit, minmax(16rem, 1fr))` do, in one sentence?","What is the difference between `auto-fit` and `auto-fill`?","Why does this beat a media query for a reusable component?"],"points":["Creates as many columns as fit at a minimum of 16rem, then stretches them to share the leftover space.","`auto-fill` keeps the empty tracks it created, so items stay narrow; `auto-fit` collapses them so the items stretch to fill.","Because it responds to the container''s width rather than the viewport''s. The same component then behaves correctly in a full-width page, a sidebar or a modal, where a viewport breakpoint would give the wrong answer."]}'::jsonb
from public.lessons where slug = 'css-grid-areas-and-auto-fit';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-grid-responsive-guided', 1, 'guided'::public.exercise_kind, 'A responsive grid with no breakpoints',
       'Make `.cards` a grid whose columns are at least `16rem` and as many as will fit, stretching to fill. Use a `1rem` gap. Do not write a media query.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive grid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards { border: 1px solid teal; padding: 1rem; }
      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="cards">
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
    <title>Responsive grid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));
        gap: 1rem;
        border: 1px solid teal;
        padding: 1rem;
      }
      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
      <div>Focaccia</div>
    </div>
  </body>
</html>', ARRAY['The pattern is repeat(auto-fit, minmax(MIN, 1fr)).', 'auto-fit collapses empty tracks so the cards stretch.', 'No @media rule is needed anywhere.']::text[],
       55, 3,
       (select id from public.skills where slug = 'grid'), false
from public.lessons l where l.slug = 'css-grid-areas-and-auto-fit'
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
       'The container is a grid', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-responsive-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value_matches'::public.requirement_kind, '.cards', 'grid-template-columns',
       'repeat\(auto-fit,\s*minmax\(16rem,\s*1fr\)\)', NULL, NULL, NULL,
       'Columns use auto-fit with a 16rem minimum', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-responsive-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.cards', 'gap',
       '1rem', NULL, NULL, NULL,
       'There is a 1rem gap', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-responsive-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-grid-areas-debug', 2, 'debug'::public.exercise_kind, 'A page layout that will not assemble',
       'The named areas are declared but the items do not use them, and the columns are percentages that overflow with the gap. Give each child the right `grid-area`, and replace the percentage columns with `12rem 1fr`.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Page layout</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .page {
        display: grid;
        grid-template-areas:
          "header header"
          "side main"
          "footer footer";
        grid-template-columns: 30% 70%;
        gap: 1rem;
      }
      .page > * { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="page">
      <header class="site-header">Riverside</header>
      <aside class="site-side">Routes</aside>
      <main class="site-main">Hire a bike by the hour.</main>
      <footer class="site-footer">© 2026</footer>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Page layout</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .page {
        display: grid;
        grid-template-areas:
          "header header"
          "side main"
          "footer footer";
        grid-template-columns: 12rem 1fr;
        gap: 1rem;
      }
      .page > * { background: #cde; padding: 1rem; }

      .site-header { grid-area: header; }
      .site-side   { grid-area: side; }
      .site-main   { grid-area: main; }
      .site-footer { grid-area: footer; }
    </style>
  </head>
  <body>
    <div class="page">
      <header class="site-header">Riverside</header>
      <aside class="site-side">Routes</aside>
      <main class="site-main">Hire a bike by the hour.</main>
      <footer class="site-footer">© 2026</footer>
    </div>
  </body>
</html>', ARRAY['Each child needs grid-area naming the area it belongs to.', 'The area names are the words inside the quoted rows.', '30% + 70% + a 1rem gap is more than 100% — use 12rem 1fr instead.']::text[],
       60, 4,
       (select id from public.skills where slug = 'grid'), false
from public.lessons l where l.slug = 'css-grid-areas-and-auto-fit'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.site-header', 'grid-area',
       'header', NULL, NULL, NULL,
       'The header is placed in its area', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-areas-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.site-side', 'grid-area',
       'side', NULL, NULL, NULL,
       'The sidebar is placed in its area', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-areas-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.site-main', 'grid-area',
       'main', NULL, NULL, NULL,
       'The main region is placed in its area', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-areas-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, '.site-footer', 'grid-area',
       'footer', NULL, NULL, NULL,
       'The footer is placed in its area', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-areas-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value_matches'::public.requirement_kind, '.page', 'grid-template-columns',
       '12rem\s+1fr', NULL, NULL, NULL,
       'Columns are a fixed track and a fr track', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-areas-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-grid-areas-and-auto-fit'), NULL, 'q-css-auto-fit', 1, 'single'::public.question_kind,
        'What does `auto-fit` do that a fixed column count does not?', 'It creates as many tracks as will fit in the available space, and collapses empty ones.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Makes every column the same fixed width', false, NULL
from public.quiz_questions where slug = 'q-css-auto-fit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Adds a media query automatically', false, NULL
from public.quiz_questions where slug = 'q-css-auto-fit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Prevents the grid from wrapping', false, NULL
from public.quiz_questions where slug = 'q-css-auto-fit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Chooses the number of columns from the space available', true, NULL
from public.quiz_questions where slug = 'q-css-auto-fit';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-grid-areas-and-auto-fit'), NULL, 'q-css-auto-fit-vs-fill', 2, 'single'::public.question_kind,
        'Three cards in a container wide enough for five. What differs between `auto-fit` and `auto-fill`?', '`auto-fill` keeps the two empty tracks so the cards stay narrow; `auto-fit` collapses them so the cards stretch.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`auto-fill` only works with fixed widths', false, NULL
from public.quiz_questions where slug = 'q-css-auto-fit-vs-fill';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`auto-fill` leaves empty tracks; `auto-fit` collapses them', true, NULL
from public.quiz_questions where slug = 'q-css-auto-fit-vs-fill';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'They behave identically', false, NULL
from public.quiz_questions where slug = 'q-css-auto-fit-vs-fill';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`auto-fit` creates more columns', false, NULL
from public.quiz_questions where slug = 'q-css-auto-fit-vs-fill';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-grid-areas-and-auto-fit'), NULL, 'q-css-grid-vs-flex', 3, 'single'::public.question_kind,
        'When is grid the better choice over flexbox?', 'When you need rows and columns aligned at once — two dimensions rather than one.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'When the layout is two-dimensional', true, NULL
from public.quiz_questions where slug = 'q-css-grid-vs-flex';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Whenever there is more than one child', false, NULL
from public.quiz_questions where slug = 'q-css-grid-vs-flex';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only for full-page layouts', false, NULL
from public.quiz_questions where slug = 'q-css-grid-vs-flex';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'When you need a gap', false, NULL
from public.quiz_questions where slug = 'q-css-grid-vs-flex';
-- lesson: Milestone: lay out a whole page
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-grid-milestone', 3, 'Milestone: lay out a whole page', 'Header, sidebar, content, footer — plus a responsive card grid inside it', 'The two grid techniques together, in the shape a real site actually uses.',
       ARRAY['Build a page shell with named areas', 'Nest a responsive card grid inside it', 'Choose grid or flexbox deliberately']::text[], 20, 40, (select id from public.skills where slug = 'grid'), 0.8
from public.modules m where m.slug = 'css-grid-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Assemble a page-level grid","Nest an intrinsically responsive grid","Justify each layout choice"]}'::jsonb
from public.lessons where slug = 'css-grid-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'Why named areas are worth it', NULL,
       'A page shell, at full size and narrowed:

  grid-template-areas:            grid-template-areas:
    "header header"                 "header"
    "side   main"                   "main"
    "footer footer";                "side"
  grid-template-columns:          "footer";
    12rem 1fr;                    grid-template-columns: 1fr;

Reordering a layout means redrawing the picture,
not renumbering a set of line references.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-grid-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'interactive_demo'::public.block_type, 'A whole page, assembled', 'A named-area shell containing an auto-fit card grid.',
       NULL, NULL, NULL, '{"variants":[{"label":"The finished shape","code":"<style>\n  .page { display: grid; grid-template-areas: \"header header\" \"side main\" \"footer footer\"; grid-template-columns: 8rem 1fr; gap: 0.5rem; }\n  .page > * { background: #eef; padding: 0.5rem; }\n  .h { grid-area: header } .s { grid-area: side } .m { grid-area: main } .f { grid-area: footer }\n  .cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(6rem, 1fr)); gap: 0.5rem; }\n  .cards > div { background: #cde; padding: 0.5rem; }\n</style>\n<div class=\"page\"><div class=\"h\">Header</div><div class=\"s\">Side</div><div class=\"m\"><div class=\"cards\"><div>A</div><div>B</div><div>C</div></div></div><div class=\"f\">Footer</div></div>","note":"Two grids: the page shell places the regions, and the card grid inside main chooses its own column count from the space main gave it."}]}'::jsonb
from public.lessons where slug = 'css-grid-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'recall'::public.block_type, 'From memory', 'From memory: what does each of these do?',
       NULL, NULL, NULL, '{"points":["`grid-template-columns: repeat(3, 1fr)` — three equal columns sharing the leftover space.","`minmax(16rem, 1fr)` — a track at least 16rem and at most a fair share of what is left.","`repeat(auto-fit, …)` — as many tracks as fit, with empty ones collapsed.","`grid-template-areas` — draws the layout as named rows; each item claims one with `grid-area`.","`gap` — space between tracks, and unlike margins it never adds space at the outer edge."]}'::jsonb
from public.lessons where slug = 'css-grid-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["A page shell in named areas is readable and easy to rearrange.","Grids nest — the outer one places regions, the inner one lays out cards.","One dimension is flexbox; two is grid."],"nextUp":"Next: responsive design and container queries."}'::jsonb
from public.lessons where slug = 'css-grid-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why nest a grid inside a grid area rather than declaring every card in the page grid?"],"points":["Because they answer different questions. The page grid decides where the regions go; the card grid decides how many columns fit inside whatever width `main` ended up with. Putting the cards in the page grid would couple them to the page''s column definition, so the component could not be moved into a sidebar or a modal without being rewritten."]}'::jsonb
from public.lessons where slug = 'css-grid-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-grid-milestone-challenge', 1, 'challenge'::public.exercise_kind, 'Build the page shell and the card grid',
       'Make `.page` a grid using the three named rows `header` / `side main` / `footer`, with columns `12rem 1fr` and a `1rem` gap. Give each region its `grid-area`. Then make `.cards` inside main a responsive grid of `minmax(12rem, 1fr)` columns with `auto-fit` and a `1rem` gap.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Page</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .page > * { background: #eef; padding: 1rem; }
      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="page">
      <header class="site-header">Riverside</header>
      <aside class="site-side">Routes</aside>
      <main class="site-main">
        <div class="cards">
          <div>Sourdough</div>
          <div>Rye</div>
          <div>Seeded</div>
        </div>
      </main>
      <footer class="site-footer">© 2026</footer>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Page</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .page {
        display: grid;
        grid-template-areas:
          "header header"
          "side main"
          "footer footer";
        grid-template-columns: 12rem 1fr;
        gap: 1rem;
      }
      .page > * { background: #eef; padding: 1rem; }

      .site-header { grid-area: header; }
      .site-side   { grid-area: side; }
      .site-main   { grid-area: main; }
      .site-footer { grid-area: footer; }

      .cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(12rem, 1fr));
        gap: 1rem;
      }
      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="page">
      <header class="site-header">Riverside</header>
      <aside class="site-side">Routes</aside>
      <main class="site-main">
        <div class="cards">
          <div>Sourdough</div>
          <div>Rye</div>
          <div>Seeded</div>
        </div>
      </main>
      <footer class="site-footer">© 2026</footer>
    </div>
  </body>
</html>', ARRAY['The area names in the quoted rows must match the grid-area values exactly.', 'The header and footer span both columns, which is why their names repeat.', 'The inner card grid is a separate, independent grid.']::text[],
       75, 4,
       (select id from public.skills where slug = 'grid'), false
from public.lessons l where l.slug = 'css-grid-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.page', 'display',
       'grid', NULL, NULL, NULL,
       'The page is a grid', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value_matches'::public.requirement_kind, '.page', 'grid-template-columns',
       '12rem\s+1fr', NULL, NULL, NULL,
       'The page columns are 12rem and 1fr', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.site-header', 'grid-area',
       'header', NULL, NULL, NULL,
       'The header claims its area', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, '.site-main', 'grid-area',
       'main', NULL, NULL, NULL,
       'Main claims its area', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value'::public.requirement_kind, '.site-footer', 'grid-area',
       'footer', NULL, NULL, NULL,
       'The footer claims its area', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'css_value'::public.requirement_kind, '.cards', 'display',
       'grid', NULL, NULL, NULL,
       'The card row is its own grid', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 7, 'css_value_matches'::public.requirement_kind, '.cards', 'grid-template-columns',
       'repeat\(auto-fit,\s*minmax\(12rem,\s*1fr\)\)', NULL, NULL, NULL,
       'The card grid is intrinsically responsive', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-grid-milestone-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-grid-milestone'), NULL, 'q-css-area-span', 1, 'single'::public.question_kind,
        'In `"header header"`, why is the name repeated?', 'Repeating a name across cells makes that area span those columns.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'To make the area span both columns', true, NULL
from public.quiz_questions where slug = 'q-css-area-span';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'To create two separate headers', false, NULL
from public.quiz_questions where slug = 'q-css-area-span';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is a syntax requirement of every row', false, NULL
from public.quiz_questions where slug = 'q-css-area-span';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'To double its width relative to others', false, NULL
from public.quiz_questions where slug = 'q-css-area-span';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-grid-milestone'), NULL, 'q-css-nested-grid-why', 2, 'single'::public.question_kind,
        'Why nest a card grid inside a page grid rather than using one grid for everything?', 'The card component then sizes itself from whatever width its container has, so it can be reused anywhere.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Because grids cannot have more than four children', false, NULL
from public.quiz_questions where slug = 'q-css-nested-grid-why';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Because named areas do not allow more than one row', false, NULL
from public.quiz_questions where slug = 'q-css-nested-grid-why';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It renders faster', false, NULL
from public.quiz_questions where slug = 'q-css-nested-grid-why';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'So the cards respond to their container, not the page definition', true, NULL
from public.quiz_questions where slug = 'q-css-nested-grid-why';
-- Level 5 milestone: Grid questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-5-milestone'), 'a-css-5-fr-leftover', 1, 'single'::public.question_kind,
        '`grid-template-columns: 200px 1fr` in a 1000px container with no gap. How wide is the `1fr`?', '800px — `fr` takes what is left after fixed tracks and gaps.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '500px', false, NULL
from public.quiz_questions where slug = 'a-css-5-fr-leftover';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '200px', false, NULL
from public.quiz_questions where slug = 'a-css-5-fr-leftover';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '800px', true, NULL
from public.quiz_questions where slug = 'a-css-5-fr-leftover';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '1000px', false, NULL
from public.quiz_questions where slug = 'a-css-5-fr-leftover';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-5-milestone'), 'a-css-5-repeat', 2, 'single'::public.question_kind,
        'What is `repeat(3, 1fr)` equivalent to?', 'Writing `1fr 1fr 1fr`.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`3fr`', false, NULL
from public.quiz_questions where slug = 'a-css-5-repeat';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`33% 33% 33%`', false, NULL
from public.quiz_questions where slug = 'a-css-5-repeat';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`minmax(3, 1fr)`', false, NULL
from public.quiz_questions where slug = 'a-css-5-repeat';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`1fr 1fr 1fr`', true, NULL
from public.quiz_questions where slug = 'a-css-5-repeat';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-5-milestone'), 'a-css-5-implicit', 3, 'single'::public.question_kind,
        'What are implicit tracks?', 'Rows or columns grid creates automatically for items beyond the ones you declared.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Tracks sized with `fr`', false, NULL
from public.quiz_questions where slug = 'a-css-5-implicit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Tracks grid creates automatically for extra items', true, NULL
from public.quiz_questions where slug = 'a-css-5-implicit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Tracks declared with `repeat()`', false, NULL
from public.quiz_questions where slug = 'a-css-5-implicit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Tracks that are hidden', false, NULL
from public.quiz_questions where slug = 'a-css-5-implicit';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-5-milestone'), 'a-css-5-minmax', 4, 'single'::public.question_kind,
        'What does `minmax(16rem, 1fr)` mean?', 'At least 16rem, at most a fair share of the leftover space.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'At least 16rem, at most a share of what is left', true, NULL
from public.quiz_questions where slug = 'a-css-5-minmax';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Exactly 16rem', false, NULL
from public.quiz_questions where slug = 'a-css-5-minmax';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Between 16rem and 1rem', false, NULL
from public.quiz_questions where slug = 'a-css-5-minmax';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A minimum of one fraction unit', false, NULL
from public.quiz_questions where slug = 'a-css-5-minmax';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-5-milestone'), 'a-css-5-empty-cell', 5, 'single'::public.question_kind,
        'What does a full stop mean inside `grid-template-areas`?', 'A deliberately empty cell.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A deliberately empty cell', true, NULL
from public.quiz_questions where slug = 'a-css-5-empty-cell';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A class selector', false, NULL
from public.quiz_questions where slug = 'a-css-5-empty-cell';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The end of a row', false, NULL
from public.quiz_questions where slug = 'a-css-5-empty-cell';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A track sized by content', false, NULL
from public.quiz_questions where slug = 'a-css-5-empty-cell';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-5-milestone'), 'a-css-5-container-vs-viewport', 6, 'single'::public.question_kind,
        'Why does an `auto-fit` grid behave correctly inside a sidebar where a media query would not?', 'It responds to the container it is in; a media query only knows the viewport width.', (select id from public.skills where slug = 'grid'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It responds to the container, not the viewport', true, NULL
from public.quiz_questions where slug = 'a-css-5-container-vs-viewport';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Media queries do not work in sidebars', false, NULL
from public.quiz_questions where slug = 'a-css-5-container-vs-viewport';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It has higher specificity', false, NULL
from public.quiz_questions where slug = 'a-css-5-container-vs-viewport';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It disables wrapping', false, NULL
from public.quiz_questions where slug = 'a-css-5-container-vs-viewport';
-- --------------------------------------------------------------------------
-- CSS Architect — Level 6: Responsive Design
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'css-responsive', 6, 'Responsive Design', 'Fluid by default, breakpoints only where the content demands one',
       'Most responsive CSS is written the wrong way round: a fixed layout, then breakpoints to patch it. Start fluid instead, and add a breakpoint only where the content actually breaks.', 'You can build a layout that works at any width, and justify every breakpoint you added.', 'violet'
from public.courses c where c.slug = 'css-architect'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'css-level-6-milestone', 'milestone'::public.assessment_kind, 'Level 6 milestone: Responsive Design', 'Six questions on fluid values, breakpoints and container queries. Pass mark 75%.',
       0.75, 180, 6
from public.levels l where l.slug = 'css-responsive'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Responsive layout
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'css-responsive-module', 1, 'Responsive layout', 'Fluid values, media queries, container queries, and choosing breakpoints from content.',
       55, false
from public.levels l where l.slug = 'css-responsive'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'css-responsive-module' and p.slug = 'css-grid-module';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'css-responsive-module' and s.slug = 'responsive';
-- lesson: Fluid first
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-fluid-first', 1, 'Fluid first', 'The values that adapt without any query at all', 'Before reaching for a breakpoint, there are values that simply do the right thing at every width.',
       ARRAY['Use `max-width` rather than `width` for containers', 'Apply `clamp()` for fluid type and spacing', 'Explain why a breakpoint is a last resort']::text[], 16, 40, (select id from public.skills where slug = 'responsive'), 0.7
from public.modules m where m.slug = 'css-responsive-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A container is `width: 1200px`. On a 400px phone, what happens?',
       NULL, NULL, NULL, '{"options":["It overflows, and the page scrolls sideways","It shrinks to 400px automatically","It wraps onto two lines","The browser ignores the width on small screens"],"answer":"It overflows and the whole page scrolls sideways — the single most common responsive failure. `width` is an instruction, not a suggestion. What you almost always mean is `max-width: 1200px`, which says \"up to 1200px, but never wider than the space available\". That one change removes the need for a great many media queries."}'::jsonb
from public.lessons where slug = 'css-fluid-first';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Choose `max-width` over `width` for layout containers","Use `min()`, `max()` and `clamp()` for fluid values","Explain when a query is genuinely needed"]}'::jsonb
from public.lessons where slug = 'css-fluid-first';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'comparison'::public.block_type, 'The one-word difference that causes most overflow', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Fluid","code":".wrap {\n  max-width: 60rem;\n  margin-inline: auto;\n}","why":"Up to 60rem, and never wider than the space available. Works at every width with no query."},"bad":{"label":"Fixed","code":".wrap {\n  width: 60rem;\n  margin-inline: auto;\n}","why":"Exactly 60rem, always. Below that the page scrolls sideways, and every later breakpoint is patching this one decision."}}'::jsonb
from public.lessons where slug = 'css-fluid-first';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, '`clamp(min, preferred, max)`', 'A value that scales with the preferred expression but never goes below the minimum or above the maximum. Three numbers replace a set of breakpoints.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-fluid-first';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'Values that adapt on their own', NULL,
       'width: 1200px           overflows below 1200px
max-width: 1200px       up to 1200px, never wider than available

width: min(100%, 65ch)  the smaller of the two — fluid, capped

font-size: clamp(1rem, 0.9rem + 0.5vw, 1.5rem)
  never below 1rem, never above 1.5rem, and scales
  smoothly with the viewport in between

padding: clamp(1rem, 5vw, 4rem)
  the same idea for spacing', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-fluid-first';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'interactive_demo'::public.block_type, 'Fixed, fluid, and clamped', 'Narrow the preview to see the difference.',
       NULL, NULL, NULL, '{"variants":[{"label":"max-width","code":"<style>\n  .wrap { max-width: 40rem; margin-inline: auto; border: 1px solid teal; padding: 1rem; }\n</style>\n<div class=\"wrap\">Up to 40rem wide, and never wider than the space available. Centred by the auto inline margins.</div>","note":"The everyday container. `margin-inline: auto` centres it once it stops filling the width."},{"label":"Fixed width","code":"<style>\n  .wrap { width: 40rem; border: 1px solid crimson; padding: 1rem; }\n</style>\n<div class=\"wrap\">Exactly 40rem, whatever the screen. Below that, the page scrolls sideways.</div>","note":"The same layout with one word changed, and it now overflows on any narrow screen."},{"label":"Clamped type","code":"<style>\n  .wrap { max-width: 40rem; margin-inline: auto; }\n  h2 { font-size: clamp(1.5rem, 1rem + 2vw, 3rem); }\n</style>\n<div class=\"wrap\"><h2>A heading that scales</h2><p>Never smaller than 1.5rem, never larger than 3rem.</p></div>","note":"One declaration replaces the three or four breakpoints this would otherwise need."}]}'::jsonb
from public.lessons where slug = 'css-fluid-first';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'Set the measure in `ch`', 'Long lines are genuinely harder to read — the eye loses its place returning to the start. A comfortable measure is roughly 45–75 characters, and `max-width: 65ch` says exactly that in a unit that follows the font rather than guessing in pixels.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-fluid-first';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'predict_check'::public.block_type, 'Predict, then check', '`width: min(100%, 65ch)` — two values, and the smaller wins. Before you check: what does this do on a wide screen, and on a phone?',
       '<style>
  .wrap { width: min(100%, 65ch); margin-inline: auto; }
</style>
<div class="wrap">
  <p>A paragraph of body text.</p>
</div>', 'html', NULL, '{"outcome":"On a wide screen `65ch` is smaller, so the container caps at a readable measure. On a phone `100%` is smaller, so it fills the width with no overflow. It behaves exactly like `max-width: 65ch` and reads more directly as \"whichever of these is smaller\" — which is also why `min()` produces a *maximum* and `max()` produces a *minimum*, a naming that catches everyone once. `max(1rem, 3vw)` means \"at least 1rem\"."}'::jsonb
from public.lessons where slug = 'css-fluid-first';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'progressive_detail'::public.block_type, 'Logical properties', '`margin-inline: auto` rather than `margin-left`/`margin-right`, and `padding-block` rather than top and bottom. Inline is the direction text runs; block is the direction lines stack. In English they map onto horizontal and vertical, and in Arabic or Japanese they follow the writing mode automatically — so a layout written this way needs no changes to be mirrored for a right-to-left language.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-fluid-first';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`max-width` instead of `width` removes most overflow before it happens.","`clamp()` gives fluid type and spacing with a floor and a ceiling.","`min()` yields a maximum; `max()` yields a minimum.","`ch` expresses a readable measure in terms of the font itself."],"nextUp":"Next: media and container queries."}'::jsonb
from public.lessons where slug = 'css-fluid-first';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why is `max-width` almost always meant where `width` is written?","What do the three values in `clamp()` do?","Why does `min()` produce a maximum?"],"points":["Because `width` is an instruction the browser obeys even when there is not room, so it overflows on narrow screens. `max-width` caps the size while still allowing it to shrink.","A floor, a preferred value that scales, and a ceiling — so the value adapts smoothly but never becomes unreadably small or absurdly large.","Because it returns whichever argument is smallest, so the result can never exceed the smallest of them — which is what a maximum is. `max()` is the mirror image and enforces a minimum."]}'::jsonb
from public.lessons where slug = 'css-fluid-first';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-fluid-guided', 1, 'guided'::public.exercise_kind, 'A container that never overflows',
       'Give `.wrap` a maximum width of `65ch`, centre it with automatic inline margins, and give the heading a font size that clamps between `1.5rem` and `3rem`, scaling with `1rem + 2vw` in between.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Fluid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .wrap { border: 1px solid teal; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="wrap">
      <h2>Fresh bread, every morning</h2>
      <p>We open at 6am and bake until we sell out.</p>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Fluid</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .wrap {
        max-width: 65ch;
        margin-inline: auto;
        border: 1px solid teal;
        padding: 1rem;
      }
      .wrap h2 { font-size: clamp(1.5rem, 1rem + 2vw, 3rem); }
    </style>
  </head>
  <body>
    <div class="wrap">
      <h2>Fresh bread, every morning</h2>
      <p>We open at 6am and bake until we sell out.</p>
    </div>
  </body>
</html>', ARRAY['max-width caps the size without preventing it shrinking.', 'margin-inline: auto centres a block once it is narrower than its parent.', 'clamp takes three arguments: minimum, preferred, maximum.']::text[],
       45, 2,
       (select id from public.skills where slug = 'responsive'), false
from public.lessons l where l.slug = 'css-fluid-first'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.wrap', 'max-width',
       '65ch', NULL, NULL, NULL,
       'The container caps at a readable measure', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-fluid-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.wrap', 'margin-inline',
       'auto', NULL, NULL, NULL,
       'The container is centred', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-fluid-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value_matches'::public.requirement_kind, '.wrap h2', 'font-size',
       'clamp\(', NULL, NULL, NULL,
       'The heading uses clamp', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-fluid-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-fluid-first'), NULL, 'q-css-max-width', 1, 'single'::public.question_kind,
        'Why does `width: 1200px` cause sideways scrolling on a phone?', '`width` is obeyed exactly, so the element stays 1200px wide and overflows the screen.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Because of the box model', false, NULL
from public.quiz_questions where slug = 'q-css-max-width';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It is obeyed exactly, so the element overflows', true, NULL
from public.quiz_questions where slug = 'q-css-max-width';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Phones ignore pixel units', false, NULL
from public.quiz_questions where slug = 'q-css-max-width';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It needs a media query to apply', false, NULL
from public.quiz_questions where slug = 'q-css-max-width';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-fluid-first'), NULL, 'q-css-clamp-parts', 2, 'single'::public.question_kind,
        'What is the middle argument of `clamp()`?', 'The preferred value, usually one that scales — the other two are the floor and ceiling.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The preferred, usually scaling, value', true, NULL
from public.quiz_questions where slug = 'q-css-clamp-parts';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The maximum', false, NULL
from public.quiz_questions where slug = 'q-css-clamp-parts';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The minimum', false, NULL
from public.quiz_questions where slug = 'q-css-clamp-parts';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A fallback for old browsers', false, NULL
from public.quiz_questions where slug = 'q-css-clamp-parts';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-fluid-first'), NULL, 'q-css-ch-unit', 3, 'single'::public.question_kind,
        'What does the `ch` unit express?', 'A width relative to the font’s character width, which is how a readable measure is stated.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A percentage of the viewport', false, NULL
from public.quiz_questions where slug = 'q-css-ch-unit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The height of a line', false, NULL
from public.quiz_questions where slug = 'q-css-ch-unit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A width based on the font’s character width', true, NULL
from public.quiz_questions where slug = 'q-css-ch-unit';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A fixed number of pixels', false, NULL
from public.quiz_questions where slug = 'q-css-ch-unit';
-- lesson: Media and container queries
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-queries', 2, 'Media and container queries', 'Choosing breakpoints from the content, and asking about the container instead', 'When a query is genuinely needed, the question is which one — and increasingly the right answer is a container query rather than a media query.',
       ARRAY['Write a mobile-first media query', 'Choose a breakpoint from the content, not a device', 'Use a container query and say when it is the better tool']::text[], 18, 40, (select id from public.skills where slug = 'responsive'), 0.7
from public.modules m where m.slug = 'css-responsive-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'Where should a breakpoint go?',
       NULL, NULL, NULL, '{"options":["Wherever the content starts to look wrong","At 768px, because that is the iPad width","At the width of the most popular phone","Every 200px, evenly"],"answer":"Wherever the content breaks. Device widths date immediately — there is no single iPad width any more, and there never really was — while the width at which a headline wraps badly or a card becomes too narrow to read is a property of *your* design and stays true. Narrow the browser until it looks wrong; that is the breakpoint, and it will not be a round number."}'::jsonb
from public.lessons where slug = 'css-queries';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Write min-width queries in a mobile-first order","Justify a breakpoint from the design","Apply a container query to a reusable component"]}'::jsonb
from public.lessons where slug = 'css-queries';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'Mobile-first means writing the narrow layout as the default and adding to it with `min-width` queries. The alternative — a wide default patched with `max-width` queries — means the smallest, slowest devices download and apply the most rules.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-queries';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'Mobile-first, and the container alternative', NULL,
       '/* Default: the narrow layout, no query at all */
.cards { display: grid; gap: 1rem; }

/* Then add, as space allows */
@media (min-width: 40rem) {
  .cards { grid-template-columns: repeat(2, 1fr); }
}

@media (min-width: 64rem) {
  .cards { grid-template-columns: repeat(3, 1fr); }
}

/* A container query asks about the parent instead */
.panel { container-type: inline-size; }

@container (min-width: 30rem) {
  .card { display: grid; grid-template-columns: 8rem 1fr; }
}', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'css-queries';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'worked_example'::public.block_type, 'Choosing a breakpoint honestly', 'A card row that needs one. Here is how to find where, without guessing a device.',
       NULL, NULL, NULL, '{"steps":[{"title":"Start with no query at all","code":".cards { display: grid; gap: 1rem; }","reasoning":"One column, stacked. This is the layout that works on the narrowest screen, and it is the default rather than an exception. Very often the work stops here."},{"title":"Widen the browser until it looks wrong","code":"/* Around 38rem the single column is\n   uncomfortably wide for the text. */","reasoning":"Not \"what width is a tablet\" — literally drag the window and watch. The point where the line length becomes uncomfortable is a fact about this design and this font, and it will not be a round number."},{"title":"Put the breakpoint just past it","code":"@media (min-width: 40rem) {\n  .cards { grid-template-columns: repeat(2, 1fr); }\n}","reasoning":"`rem` rather than `px` so the breakpoint respects a reader who has increased their default font size — at which point the text needs the second column sooner, and a px breakpoint would not know."},{"title":"Ask whether the query was needed at all","code":".cards {\n  display: grid;\n  grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));\n  gap: 1rem;\n}","reasoning":"For a card grid, usually not. `auto-fit` does the same job at every width, responds to the container rather than the viewport, and has no number to keep in sync with the design. Reach for a query when the layout must *change shape*, not merely change column count."}]}'::jsonb
from public.lessons where slug = 'css-queries';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'term'::public.block_type, 'Container query', 'A query about the width of an element''s container rather than the viewport. The container must opt in with `container-type: inline-size`.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-queries';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'interactive_demo'::public.block_type, 'The same card, two contexts', 'Why the viewport is often the wrong thing to ask about.',
       NULL, NULL, NULL, '{"variants":[{"label":"Container query","code":"<style>\n  .panel { container-type: inline-size; border: 1px solid teal; padding: 0.5rem; }\n  .card { display: grid; gap: 0.5rem; background: #cde; padding: 0.5rem; }\n  @container (min-width: 24rem) { .card { grid-template-columns: 6rem 1fr; } }\n</style>\n<div class=\"panel\"><div class=\"card\"><div>Image</div><div>A card that rearranges itself based on the panel it is in.</div></div></div>","note":"The card asks how much room *it* has. Put the same panel in a sidebar and it lays out correctly with no extra CSS."},{"label":"Media query","code":"<style>\n  .panel { border: 1px solid crimson; padding: 0.5rem; }\n  .card { display: grid; gap: 0.5rem; background: #fee; padding: 0.5rem; }\n  @media (min-width: 24rem) { .card { grid-template-columns: 6rem 1fr; } }\n</style>\n<div class=\"panel\"><div class=\"card\"><div>Image</div><div>A card that only knows how wide the window is.</div></div></div>","note":"On a wide monitor this goes two-column even inside a 15rem sidebar, because the viewport is wide and the card has no idea it is not."}]}'::jsonb
from public.lessons where slug = 'css-queries';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'callout'::public.block_type, 'Breakpoints named after devices', 'Variables called `$tablet` and `$phone` encode an assumption that stopped being true years ago, and they make the CSS lie: the rule is not about tablets, it is about the width at which two columns start to work. Name breakpoints after what changes — `--bp-cards-two-up` — or do not name them at all.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'css-queries';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'self_explain'::public.block_type, 'Explain it in your own words', 'Your team has breakpoints at 576, 768, 992 and 1200px copied from a framework, applied to every component. Write the case for changing the approach.',
       NULL, NULL, NULL, '{"modelAnswer":"Those four numbers describe a framework''s grid, not this design''s content — so every component is being asked to change shape at moments that have nothing to do with when it actually needs to. In practice that means some components break *between* breakpoints and get patched with a fifth, while others change for no visible reason. The alternative is two moves: make components intrinsically responsive where possible, with `auto-fit`, `clamp()` and `max-width`, so most of them need no breakpoint at all; and where a genuine shape change is needed, find the width by narrowing the browser until *that component* looks wrong, and put the query there in `rem`. The result is fewer queries, each of which can be justified by pointing at the screen."}'::jsonb
from public.lessons where slug = 'css-queries';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'checklist'::public.block_type, 'Before adding a breakpoint', NULL,
       NULL, NULL, NULL, '{"items":["Would `max-width` or `clamp()` solve it with no query?","Would `auto-fit` handle the column count on its own?","Is the layout genuinely changing *shape*, not just size?","Did the number come from narrowing the browser, or from a device?","Is it in `rem`, so it respects the reader''s font size?","Should this be a container query instead?"]}'::jsonb
from public.lessons where slug = 'css-queries';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Mobile-first: the narrow layout is the default, `min-width` queries add to it.","Breakpoints come from where the content breaks, not from device widths.","Use `rem` so a breakpoint respects an increased default font size.","Container queries ask about the component''s own space, which is usually the better question."],"nextUp":"Next: the Level 6 milestone."}'::jsonb
from public.lessons where slug = 'css-queries';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["How do you find where a breakpoint belongs?","Why write breakpoints in `rem` rather than `px`?","When is a container query the better tool?"],"points":["Narrow the browser until the content looks wrong, and put the query just past that point. It is a fact about the design, not about any device, and it will not be a round number.","Because a `rem` breakpoint scales with the reader''s default font size. Someone who has increased it needs the layout to change sooner, and a `px` breakpoint cannot know that.","Whenever the component can appear in more than one context — a sidebar, a modal, a grid cell. It asks how much room the component actually has, where a media query only knows the window."]}'::jsonb
from public.lessons where slug = 'css-queries';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-mobile-first-guided', 1, 'guided'::public.exercise_kind, 'Mobile-first, two breakpoints',
       'Write the card grid mobile-first: one column by default, two columns from `40rem`, three from `64rem`. Use `min-width` queries and a `1rem` gap.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
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
    <title>Responsive</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards {
        display: grid;
        grid-template-columns: 1fr;
        gap: 1rem;
      }

      @media (min-width: 40rem) {
        .cards { grid-template-columns: repeat(2, 1fr); }
      }

      @media (min-width: 64rem) {
        .cards { grid-template-columns: repeat(3, 1fr); }
      }

      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="cards">
      <div>Sourdough</div>
      <div>Rye</div>
      <div>Seeded</div>
    </div>
  </body>
</html>', ARRAY['The single-column layout goes outside any query — that is what mobile-first means.', 'Each query is @media (min-width: …) { … }.', 'Use rem for the breakpoint values.']::text[],
       55, 3,
       (select id from public.skills where slug = 'responsive'), false
from public.lessons l where l.slug = 'css-queries'
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
       'The card row is a grid', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-mobile-first-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.cards', 'grid-template-columns',
       '1fr', NULL, NULL, NULL,
       'One column by default', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-mobile-first-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_media_rule'::public.requirement_kind, NULL, NULL,
       '(min-width: 40rem)', NULL, NULL, NULL,
       'There is a 40rem breakpoint', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-mobile-first-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_media_rule'::public.requirement_kind, NULL, NULL,
       '(min-width: 64rem)', NULL, NULL, NULL,
       'There is a 64rem breakpoint', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-mobile-first-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value_matches'::public.requirement_kind, '.cards', 'grid-template-columns',
       'repeat\(2,\s*1fr\)', NULL, NULL, NULL,
       'Two columns from 40rem', NULL, 1, true, '(min-width: 40rem)'
from public.exercises e where e.slug = 'css-mobile-first-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 6, 'css_value_matches'::public.requirement_kind, '.cards', 'grid-template-columns',
       'repeat\(3,\s*1fr\)', NULL, NULL, NULL,
       'Three columns from 64rem', NULL, 1, true, '(min-width: 64rem)'
from public.exercises e where e.slug = 'css-mobile-first-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-responsive-debug', 2, 'debug'::public.exercise_kind, 'Desktop-first, and overflowing',
       'This is written the wrong way round: a fixed width and a `max-width` query patching it. Rewrite it mobile-first — one column as the default with no query, two columns from `40rem` — and replace the fixed `width` with a `max-width` so it cannot overflow.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .wrap { width: 60rem; margin-inline: auto; }
      .cards { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1rem; }

      @media (max-width: 40rem) {
        .cards { grid-template-columns: 1fr; }
      }

      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="wrap">
      <div class="cards">
        <div>Sourdough</div>
        <div>Rye</div>
      </div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .wrap { max-width: 60rem; margin-inline: auto; }
      .cards { display: grid; grid-template-columns: 1fr; gap: 1rem; }

      @media (min-width: 40rem) {
        .cards { grid-template-columns: repeat(2, 1fr); }
      }

      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="wrap">
      <div class="cards">
        <div>Sourdough</div>
        <div>Rye</div>
      </div>
    </div>
  </body>
</html>', ARRAY['A fixed width overflows on narrow screens — max-width does not.', 'Mobile-first means the single column is the default, outside any query.', 'Swap the max-width query for a min-width one.']::text[],
       60, 4,
       (select id from public.skills where slug = 'responsive'), false
from public.lessons l where l.slug = 'css-queries'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.wrap', 'max-width',
       '60rem', NULL, NULL, NULL,
       'The wrapper uses max-width', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-responsive-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.cards', 'grid-template-columns',
       '1fr', NULL, NULL, NULL,
       'One column is the default', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-responsive-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_media_rule'::public.requirement_kind, NULL, NULL,
       '(min-width: 40rem)', NULL, NULL, NULL,
       'The query is mobile-first', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-responsive-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value_matches'::public.requirement_kind, '.cards', 'grid-template-columns',
       'repeat\(2,\s*1fr\)', NULL, NULL, NULL,
       'Two columns from 40rem', NULL, 1, true, '(min-width: 40rem)'
from public.exercises e where e.slug = 'css-responsive-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-queries'), NULL, 'q-css-mobile-first', 1, 'single'::public.question_kind,
        'What does mobile-first mean in practice?', 'The narrow layout is the default with no query, and `min-width` queries add to it as space allows.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Desktop styles load first', false, NULL
from public.quiz_questions where slug = 'q-css-mobile-first';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The narrow layout is the default; min-width queries add to it', true, NULL
from public.quiz_questions where slug = 'q-css-mobile-first';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'You design on a phone first', false, NULL
from public.quiz_questions where slug = 'q-css-mobile-first';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'All queries use max-width', false, NULL
from public.quiz_questions where slug = 'q-css-mobile-first';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-queries'), NULL, 'q-css-breakpoint-source', 2, 'single'::public.question_kind,
        'Where should a breakpoint value come from?', 'From the width at which your content stops working, found by narrowing the browser.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The most popular device width', false, NULL
from public.quiz_questions where slug = 'q-css-breakpoint-source';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A framework’s defaults', false, NULL
from public.quiz_questions where slug = 'q-css-breakpoint-source';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Round numbers, for tidiness', false, NULL
from public.quiz_questions where slug = 'q-css-breakpoint-source';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The width at which the content breaks', true, NULL
from public.quiz_questions where slug = 'q-css-breakpoint-source';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-queries'), NULL, 'q-css-container-query-why', 3, 'single'::public.question_kind,
        'Why is a container query often better for a reusable component?', 'It responds to the space the component actually has, so it behaves correctly in a sidebar or modal.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It has higher specificity', false, NULL
from public.quiz_questions where slug = 'q-css-container-query-why';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It works in older browsers', false, NULL
from public.quiz_questions where slug = 'q-css-container-query-why';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It removes the need for grid', false, NULL
from public.quiz_questions where slug = 'q-css-container-query-why';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It asks about the component’s own space, not the window', true, NULL
from public.quiz_questions where slug = 'q-css-container-query-why';
-- lesson: Milestone: one layout, every width
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-responsive-milestone', 3, 'Milestone: one layout, every width', 'Fluid where possible, queried where necessary', 'A page that works from 320px to a wide monitor, with every breakpoint justified.',
       ARRAY['Combine fluid values with a minimum of queries', 'Justify each breakpoint', 'Avoid horizontal overflow at any width']::text[], 20, 40, (select id from public.skills where slug = 'responsive'), 0.8
from public.modules m where m.slug = 'css-responsive-module'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Build a page that survives any width","Prefer intrinsic techniques to breakpoints","Explain every query you kept"]}'::jsonb
from public.lessons where slug = 'css-responsive-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'The order to reach for things', NULL,
       'Reach for these first, in this order:

1. max-width          stops overflow
2. auto-fit + minmax  column count with no query
3. clamp()            fluid type and spacing
4. container query    when the component is reusable
5. media query        when the layout changes SHAPE

Most pages need one or two of item 5. Many need none.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-responsive-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'interactive_demo'::public.block_type, 'The same page, two approaches', 'Both work. One is much less code.',
       NULL, NULL, NULL, '{"variants":[{"label":"Intrinsic","code":"<style>\n  .wrap { max-width: 60rem; margin-inline: auto; padding: clamp(1rem, 4vw, 3rem); }\n  .cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(10rem, 1fr)); gap: 1rem; }\n  .cards > div { background: #cde; padding: 1rem; }\n</style>\n<div class=\"wrap\"><div class=\"cards\"><div>A</div><div>B</div><div>C</div></div></div>","note":"No media query at all. The column count, the padding and the container width all adapt on their own."},{"label":"Breakpoint-driven","code":"<style>\n  .wrap { max-width: 60rem; margin-inline: auto; padding: 1rem; }\n  .cards { display: grid; grid-template-columns: 1fr; gap: 1rem; }\n  @media (min-width: 40rem) { .cards { grid-template-columns: repeat(2, 1fr) } .wrap { padding: 2rem } }\n  @media (min-width: 64rem) { .cards { grid-template-columns: repeat(3, 1fr) } .wrap { padding: 3rem } }\n</style>\n<div class=\"wrap\"><div class=\"cards\"><div>A</div><div>B</div><div>C</div></div></div>","note":"The same result at three specific widths and stepped changes between them, with two numbers to keep in sync with the design."}]}'::jsonb
from public.lessons where slug = 'css-responsive-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'recall'::public.block_type, 'From memory', 'From memory: list the techniques to reach for before writing a media query, and say what each one removes the need for.',
       NULL, NULL, NULL, '{"points":["`max-width` instead of `width` — removes horizontal overflow.","`repeat(auto-fit, minmax(X, 1fr))` — removes breakpoints that only change column count.","`clamp()` — removes stepped font-size and spacing breakpoints.","Logical properties such as `margin-inline` — remove the need for right-to-left overrides.","Container queries — remove breakpoints that were really about the component, not the window."]}'::jsonb
from public.lessons where slug = 'css-responsive-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Fluid first: `max-width`, `clamp()`, `auto-fit`.","A media query is for a change of shape, not a change of size.","Breakpoints belong in `rem` and come from the content."],"nextUp":"Next: custom properties."}'::jsonb
from public.lessons where slug = 'css-responsive-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why does an intrinsically responsive layout usually beat a breakpoint-driven one?"],"points":["Because it responds continuously to the space available rather than stepping at a few chosen widths, so it is correct at every width instead of at three. It also has no numbers to keep in sync with the design, and it keeps working when the component is moved into a narrower context — which a viewport breakpoint cannot do."]}'::jsonb
from public.lessons where slug = 'css-responsive-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-responsive-milestone-challenge', 1, 'challenge'::public.exercise_kind, 'A page that works at every width',
       'Give `.wrap` a `max-width` of `60rem`, centre it, and give it padding that clamps between `1rem` and `3rem` scaling on `4vw`. Make `.cards` an `auto-fit` grid with a `12rem` minimum and a `1rem` gap. Write no media query at all.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive page</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="wrap">
      <h1>Riverside Bakery</h1>
      <div class="cards">
        <div>Sourdough</div>
        <div>Rye</div>
        <div>Seeded</div>
      </div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Responsive page</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .wrap {
        max-width: 60rem;
        margin-inline: auto;
        padding: clamp(1rem, 4vw, 3rem);
      }
      .cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(12rem, 1fr));
        gap: 1rem;
      }
      .cards > div { background: #cde; padding: 1rem; }
    </style>
  </head>
  <body>
    <div class="wrap">
      <h1>Riverside Bakery</h1>
      <div class="cards">
        <div>Sourdough</div>
        <div>Rye</div>
        <div>Seeded</div>
      </div>
    </div>
  </body>
</html>', ARRAY['clamp(1rem, 4vw, 3rem) for the padding.', 'repeat(auto-fit, minmax(12rem, 1fr)) for the columns.', 'margin-inline: auto centres the wrapper.']::text[],
       70, 4,
       (select id from public.skills where slug = 'responsive'), false
from public.lessons l where l.slug = 'css-responsive-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, '.wrap', 'max-width',
       '60rem', NULL, NULL, NULL,
       'The wrapper caps at 60rem', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-responsive-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.wrap', 'margin-inline',
       'auto', NULL, NULL, NULL,
       'The wrapper is centred', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-responsive-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value_matches'::public.requirement_kind, '.wrap', 'padding',
       'clamp\(', NULL, NULL, NULL,
       'Padding is fluid', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-responsive-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value_matches'::public.requirement_kind, '.cards', 'grid-template-columns',
       'repeat\(auto-fit,\s*minmax\(12rem,\s*1fr\)\)', NULL, NULL, NULL,
       'The card grid is intrinsically responsive', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-responsive-milestone-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-responsive-milestone'), NULL, 'q-css-query-last-resort', 1, 'single'::public.question_kind,
        'What is a media query genuinely for?', 'A change of layout *shape* that fluid techniques cannot express.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Any change at all between screen sizes', false, NULL
from public.quiz_questions where slug = 'q-css-query-last-resort';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Setting font sizes', false, NULL
from public.quiz_questions where slug = 'q-css-query-last-resort';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Preventing overflow', false, NULL
from public.quiz_questions where slug = 'q-css-query-last-resort';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A change of shape that fluid values cannot express', true, NULL
from public.quiz_questions where slug = 'q-css-query-last-resort';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-responsive-milestone'), NULL, 'q-css-rem-breakpoints', 2, 'single'::public.question_kind,
        'Why write breakpoints in `rem`?', 'They then scale with the reader’s default font size, so someone using larger text gets the layout change sooner.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'They render faster', false, NULL
from public.quiz_questions where slug = 'q-css-rem-breakpoints';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Pixels are not allowed in media queries', false, NULL
from public.quiz_questions where slug = 'q-css-rem-breakpoints';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It avoids rounding errors', false, NULL
from public.quiz_questions where slug = 'q-css-rem-breakpoints';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'They respect a reader’s increased default font size', true, NULL
from public.quiz_questions where slug = 'q-css-rem-breakpoints';
-- Level 6 milestone: Responsive Design questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-6-milestone'), 'a-css-6-max-width', 1, 'single'::public.question_kind,
        'Which prevents a container overflowing a narrow screen?', '`max-width` caps the size while still allowing the element to shrink.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`max-width`', true, NULL
from public.quiz_questions where slug = 'a-css-6-max-width';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`width`', false, NULL
from public.quiz_questions where slug = 'a-css-6-max-width';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`min-width`', false, NULL
from public.quiz_questions where slug = 'a-css-6-max-width';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`flex-basis`', false, NULL
from public.quiz_questions where slug = 'a-css-6-max-width';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-6-milestone'), 'a-css-6-clamp', 2, 'single'::public.question_kind,
        '`clamp(1rem, 0.9rem + 0.5vw, 1.5rem)` — what is the largest this can be?', '1.5rem, the third argument.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '0.5vw', false, NULL
from public.quiz_questions where slug = 'a-css-6-clamp';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Unbounded', false, NULL
from public.quiz_questions where slug = 'a-css-6-clamp';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '1.5rem', true, NULL
from public.quiz_questions where slug = 'a-css-6-clamp';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '1rem', false, NULL
from public.quiz_questions where slug = 'a-css-6-clamp';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-6-milestone'), 'a-css-6-min-max-naming', 3, 'single'::public.question_kind,
        '`width: min(100%, 65ch)` behaves like which single property?', 'Like `max-width: 65ch` — `min()` returns the smaller, so it caps the result.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`min-width: 65ch`', false, NULL
from public.quiz_questions where slug = 'a-css-6-min-max-naming';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`width: 65ch`', false, NULL
from public.quiz_questions where slug = 'a-css-6-min-max-naming';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`flex-basis: 65ch`', false, NULL
from public.quiz_questions where slug = 'a-css-6-min-max-naming';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`max-width: 65ch`', true, NULL
from public.quiz_questions where slug = 'a-css-6-min-max-naming';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-6-milestone'), 'a-css-6-mobile-first-order', 4, 'single'::public.question_kind,
        'In a mobile-first stylesheet, what sits outside every media query?', 'The narrow layout — it is the default that queries then add to.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Nothing; everything is in a query', false, NULL
from public.quiz_questions where slug = 'a-css-6-mobile-first-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The narrow layout', true, NULL
from public.quiz_questions where slug = 'a-css-6-mobile-first-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The widest layout', false, NULL
from public.quiz_questions where slug = 'a-css-6-mobile-first-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only the colours', false, NULL
from public.quiz_questions where slug = 'a-css-6-mobile-first-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-6-milestone'), 'a-css-6-container-type', 5, 'single'::public.question_kind,
        'What must a container declare before `@container` queries work against it?', '`container-type: inline-size` opts the element in.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '`overflow: hidden`', false, NULL
from public.quiz_questions where slug = 'a-css-6-container-type';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '`container-type: inline-size`', true, NULL
from public.quiz_questions where slug = 'a-css-6-container-type';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`display: grid`', false, NULL
from public.quiz_questions where slug = 'a-css-6-container-type';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '`position: relative`', false, NULL
from public.quiz_questions where slug = 'a-css-6-container-type';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-6-milestone'), 'a-css-6-device-breakpoints', 6, 'single'::public.question_kind,
        'What is wrong with breakpoints named after devices?', 'Device widths change constantly, and the rule is really about where the content breaks — which is a property of the design.', (select id from public.skills where slug = 'responsive'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'They describe hardware that changes, not the design that does not', true, NULL
from public.quiz_questions where slug = 'a-css-6-device-breakpoints';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'They are invalid CSS', false, NULL
from public.quiz_questions where slug = 'a-css-6-device-breakpoints';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'They cannot use rem units', false, NULL
from public.quiz_questions where slug = 'a-css-6-device-breakpoints';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'They only work in mobile-first order', false, NULL
from public.quiz_questions where slug = 'a-css-6-device-breakpoints';
-- --------------------------------------------------------------------------
-- CSS Architect — Level 7: Custom Properties
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'css-custom-properties', 7, 'Custom Properties', 'Design tokens that live in the cascade',
       'Custom properties are not variables in the ordinary sense: they inherit, they can be overridden per component, and they are resolved at use rather than at definition. That is what makes theming possible.', 'You can build a token system and re-theme a component by overriding a property on one selector.', 'violet'
from public.courses c where c.slug = 'css-architect'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'css-level-7-milestone', 'milestone'::public.assessment_kind, 'Level 7 milestone: Custom Properties', 'Six questions on tokens, inheritance and theming. Pass mark 75%.',
       0.75, 180, 7
from public.levels l where l.slug = 'css-custom-properties'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Custom properties and tokens
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'css-tokens', 1, 'Custom properties and tokens', 'Declaring, inheriting, scoping and overriding values by name.',
       50, false
from public.levels l where l.slug = 'css-custom-properties'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'css-tokens' and p.slug = 'css-responsive-module';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'css-tokens' and s.slug = 'custom-properties';
-- lesson: Declaring and using tokens
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-declaring-tokens', 1, 'Declaring and using tokens', 'Why a custom property is not a variable', 'A preprocessor variable is substituted once at build time. A custom property lives in the cascade, inherits, and can be changed at runtime — which is a completely different tool.',
       ARRAY['Declare and use a custom property', 'Explain why they inherit', 'Use a fallback value']::text[], 15, 40, (select id from public.skills where slug = 'custom-properties'), 0.7
from public.modules m where m.slug = 'css-tokens'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', '`:root { --brand: teal }` and `.card { --brand: crimson }`. A button inside `.card` uses `color: var(--brand)`. What colour is it?',
       NULL, NULL, NULL, '{"options":["Crimson — the nearest ancestor that sets it wins, by inheritance","Teal — `:root` is more authoritative","Neither; a property cannot be redefined","Whichever was declared later in the file"],"answer":"Crimson. Custom properties inherit exactly like `color` does, so the value a `var()` sees is whatever the nearest ancestor set. That is the entire basis of theming in modern CSS: override one property on a wrapper and everything inside it changes, without a single new rule and without touching the components."}'::jsonb
from public.lessons where slug = 'css-declaring-tokens';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Declare a custom property and read it with `var()`","Explain the consequence of custom properties inheriting","Supply a fallback for a property that may not be set"]}'::jsonb
from public.lessons where slug = 'css-declaring-tokens';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Custom property', 'A property whose name begins with two hyphens, holding any value. Read it back with `var(--name)`.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-declaring-tokens';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'Declaring and using', NULL,
       ':root {
  --brand: teal;
  --space: 1rem;
  --radius: 0.5rem;
}

.card {
  padding: var(--space);
  border-radius: var(--radius);
  border: 1px solid var(--brand);
}

var(--missing, 1rem)     use 1rem if --missing is not set
var(--a, var(--b, 0))    fallbacks can nest', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'css-declaring-tokens';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, '`:root` is just the `<html>` element', 'It is written `:root` rather than `html` by convention, because it carries slightly more specificity and signals intent — these are document-wide tokens, not styles for the html element. Anything declared there inherits to every element on the page.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'css-declaring-tokens';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'interactive_demo'::public.block_type, 'Tokens, and overriding them', 'The same components, re-themed by one declaration.',
       NULL, NULL, NULL, '{"variants":[{"label":"Global tokens","code":"<style>\n  :root { --brand: teal; --space: 1rem; }\n  .card { border: 2px solid var(--brand); padding: var(--space); }\n</style>\n<div class=\"card\">Sourdough</div>","note":"One place defines the values; the component reads them by name."},{"label":"Scoped override","code":"<style>\n  :root { --brand: teal; --space: 1rem; }\n  .card { border: 2px solid var(--brand); padding: var(--space); }\n  .featured { --brand: crimson; --space: 2rem; }\n</style>\n<div class=\"card\">Sourdough</div>\n<div class=\"card featured\">Rye — featured</div>","note":"The featured card redefines the tokens for itself. The `.card` rule is untouched and does not know a variant exists."},{"label":"Fallback","code":"<style>\n  .card { padding: var(--space, 1rem); border: 2px solid var(--brand, dimgray); }\n</style>\n<div class=\"card\">No tokens defined at all — the fallbacks apply.</div>","note":"A component that works standalone and picks up tokens when they exist."}]}'::jsonb
from public.lessons where slug = 'css-declaring-tokens';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'predict_check'::public.block_type, 'Predict, then check', 'The token is declared on `.card`, and the button is a sibling rather than a child. Before you check: what colour is the button?',
       '<style>
  .card { --brand: teal; }
  .button { color: var(--brand); }
</style>
<div class="card">Inside the card</div>
<button class="button">Outside it</button>', 'html', NULL, '{"outcome":"It has no colour from that rule at all — `var(--brand)` resolves to nothing, so the `color` declaration is invalid and dropped, and the button falls back to its inherited or default colour. Custom properties reach *descendants* only, exactly like inheritance. This is the commonest mistake with tokens: declaring them on a component and then trying to use them from a sibling. Document-wide tokens belong on `:root`."}'::jsonb
from public.lessons where slug = 'css-declaring-tokens';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'progressive_detail'::public.block_type, 'Why they are resolved at use, not at definition', 'A preprocessor variable is replaced by its value when the stylesheet is compiled — after that the variable does not exist. A custom property is live: the browser looks it up each time the `var()` is evaluated, for each element. That is why one override on an ancestor re-themes everything below it, why a media query can change a token and every component follows, and why JavaScript can change a theme by setting a single property. None of that is possible with a compile-time variable.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'css-declaring-tokens';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["A custom property starts with `--` and is read with `var()`.","They inherit, so a value set on an ancestor reaches every descendant.","Overriding one on a wrapper re-themes everything inside it.","`var(--name, fallback)` keeps a component working when the token is absent."],"nextUp":"Next: building a token system."}'::jsonb
from public.lessons where slug = 'css-declaring-tokens';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["What makes a custom property different from a preprocessor variable?","Where do document-wide tokens belong, and why?","What happens when `var()` refers to a property that is not set and there is no fallback?"],"points":["It lives in the cascade and is resolved each time it is used, so it inherits and can be overridden per element or changed at runtime. A preprocessor variable is substituted once at build time and then no longer exists.","On `:root`, because custom properties only reach descendants — and everything on the page is a descendant of the root element.","The whole declaration is invalid and dropped, so the property falls back to its inherited or initial value. Nothing warns you."]}'::jsonb
from public.lessons where slug = 'css-declaring-tokens';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-tokens-guided', 1, 'guided'::public.exercise_kind, 'Build a small token set',
       'Declare `--brand: teal`, `--space: 1rem` and `--radius: 0.5rem` on `:root`, then use all three in the `.card` rule for its border colour, padding and border radius.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tokens</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card { border-style: solid; border-width: 2px; }
    </style>
  </head>
  <body>
    <div class="card">Sourdough workshop</div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tokens</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root {
        --brand: teal;
        --space: 1rem;
        --radius: 0.5rem;
      }

      .card {
        border-style: solid;
        border-width: 2px;
        border-color: var(--brand);
        padding: var(--space);
        border-radius: var(--radius);
      }
    </style>
  </head>
  <body>
    <div class="card">Sourdough workshop</div>
  </body>
</html>', ARRAY['Custom property names start with two hyphens.', ':root is where document-wide tokens belong.', 'Read them back with var(--name).']::text[],
       45, 2,
       (select id from public.skills where slug = 'custom-properties'), false
from public.lessons l where l.slug = 'css-declaring-tokens'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_custom_property'::public.requirement_kind, '.card', '--brand',
       NULL, NULL, NULL, NULL,
       'The brand token reaches the card', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_custom_property'::public.requirement_kind, '.card', '--space',
       NULL, NULL, NULL, NULL,
       'The spacing token reaches the card', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.card', 'border-color',
       'teal', NULL, NULL, NULL,
       'The border colour resolves from the token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, '.card', 'padding',
       '1rem', NULL, NULL, NULL,
       'The padding resolves from the token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value'::public.requirement_kind, '.card', 'border-radius',
       '0.5rem', NULL, NULL, NULL,
       'The radius resolves from the token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-declaring-tokens'), NULL, 'q-css-token-inherits', 1, 'single'::public.question_kind,
        'Do custom properties inherit?', 'Yes — which is what makes scoped overrides and theming work.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Only inside `:root`', false, NULL
from public.quiz_questions where slug = 'q-css-token-inherits';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Only if declared with `inherit`', false, NULL
from public.quiz_questions where slug = 'q-css-token-inherits';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Yes, like `color` does', true, NULL
from public.quiz_questions where slug = 'q-css-token-inherits';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'No, they are global only', false, NULL
from public.quiz_questions where slug = 'q-css-token-inherits';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-declaring-tokens'), NULL, 'q-css-var-fallback', 2, 'single'::public.question_kind,
        'What does `var(--space, 1rem)` do when `--space` is not defined?', 'Uses the fallback of 1rem.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Throws an error', false, NULL
from public.quiz_questions where slug = 'q-css-var-fallback';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Uses zero', false, NULL
from public.quiz_questions where slug = 'q-css-var-fallback';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Uses 1rem', true, NULL
from public.quiz_questions where slug = 'q-css-var-fallback';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Drops the declaration', false, NULL
from public.quiz_questions where slug = 'q-css-var-fallback';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-declaring-tokens'), NULL, 'q-css-token-scope', 3, 'single'::public.question_kind,
        'A token declared on `.card` — which elements can read it?', '`.card` and its descendants only. Siblings cannot see it.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Only `.card` itself', false, NULL
from public.quiz_questions where slug = 'q-css-token-scope';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Its siblings as well', false, NULL
from public.quiz_questions where slug = 'q-css-token-scope';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '`.card` and its descendants', true, NULL
from public.quiz_questions where slug = 'q-css-token-scope';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Every element on the page', false, NULL
from public.quiz_questions where slug = 'q-css-token-scope';
-- lesson: Theming with tokens
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-theming', 2, 'Theming with tokens', 'One override, a whole new appearance', 'A theme is not a second stylesheet. It is the same stylesheet with different token values, which is why the approach scales.',
       ARRAY['Re-theme a component by scoping tokens', 'Build a dark theme without duplicating rules', 'Respect a system colour-scheme preference']::text[], 17, 40, (select id from public.skills where slug = 'custom-properties'), 0.7
from public.modules m where m.slug = 'css-tokens'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'You need a dark theme. Which approach scales best?',
       NULL, NULL, NULL, '{"options":["Redefine the same token names under a `[data-theme=\"dark\"]` selector","Write a second stylesheet with every rule duplicated","Add a `.dark` class to every component and style each one","Use `filter: invert(1)` on the whole page"],"answer":"Redefine the tokens. Every component already reads its colours by name, so changing what those names mean changes everything at once — no rule is duplicated and no component knows a theme exists. The other approaches all scale with the number of components rather than the number of themes, which is the wrong direction."}'::jsonb
from public.lessons where slug = 'css-theming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Scope tokens to create a variant","Implement a theme with one block of overrides","Honour `prefers-color-scheme`"]}'::jsonb
from public.lessons where slug = 'css-theming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'worked_example'::public.block_type, 'Adding a dark theme without touching a single component', 'The whole technique, in four steps.',
       NULL, NULL, NULL, '{"steps":[{"title":"Components must read colours by name","code":".card {\n  background: var(--surface);\n  color: var(--text);\n  border: 1px solid var(--border);\n}","reasoning":"Nothing here is a literal colour. This is the step that makes everything after it possible, and it is the one that has to be done before a theme is ever contemplated."},{"title":"Define the default theme once","code":":root {\n  --surface: white;\n  --text: #111;\n  --border: #ddd;\n}","reasoning":"These are the light values. Note that the names describe *roles* — surface, text, border — not appearances. A token called `--white` would be a lie the moment a dark theme existed."},{"title":"Override the same names for dark","code":"[data-theme=\"dark\"] {\n  --surface: #111;\n  --text: #f4f4f4;\n  --border: #333;\n}","reasoning":"Three declarations re-theme the entire site. Because the tokens inherit, putting `data-theme=\"dark\"` on `<html>` changes every descendant — and putting it on one panel themes just that panel."},{"title":"Follow the system preference by default","code":"@media (prefers-color-scheme: dark) {\n  :root:not([data-theme=\"light\"]) {\n    --surface: #111;\n    --text: #f4f4f4;\n    --border: #333;\n  }\n}","reasoning":"Respects the choice the reader already made in their operating system, while `:not([data-theme=\"light\"])` still lets an explicit setting win. Someone who has chosen dark everywhere should not have to choose again on your site."}]}'::jsonb
from public.lessons where slug = 'css-theming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'interactive_demo'::public.block_type, 'One token set, two themes', 'The component CSS is identical in both.',
       NULL, NULL, NULL, '{"variants":[{"label":"Light","code":"<style>\n  :root { --surface: white; --text: #111; --border: #ddd; }\n  .card { background: var(--surface); color: var(--text); border: 1px solid var(--border); padding: 1rem; }\n</style>\n<div class=\"card\">Sourdough workshop</div>","note":"The default token values."},{"label":"Dark","code":"<style>\n  :root { --surface: white; --text: #111; --border: #ddd; }\n  [data-theme=\"dark\"] { --surface: #111; --text: #f4f4f4; --border: #333; }\n  .card { background: var(--surface); color: var(--text); border: 1px solid var(--border); padding: 1rem; }\n</style>\n<div data-theme=\"dark\"><div class=\"card\">Sourdough workshop</div></div>","note":"The `.card` rule has not changed by one character. Three token overrides did all of it."},{"label":"Scoped to one panel","code":"<style>\n  :root { --surface: white; --text: #111; --border: #ddd; }\n  [data-theme=\"dark\"] { --surface: #111; --text: #f4f4f4; --border: #333; }\n  .card { background: var(--surface); color: var(--text); border: 1px solid var(--border); padding: 1rem; margin-bottom: 0.5rem; }\n</style>\n<div class=\"card\">Light card</div>\n<div data-theme=\"dark\"><div class=\"card\">Dark card, same rule</div></div>","note":"Because tokens inherit, a theme can apply to a subtree rather than the whole page — useful for a preview panel or an inverted footer."}]}'::jsonb
from public.lessons where slug = 'css-theming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Name tokens after their role, not their appearance', '`--surface` and `--text` survive a dark theme. `--white` and `--dark-grey` become actively misleading the moment one exists, and a stylesheet full of `--white: #111` is worse than no tokens at all. The same applies to `--space-4` over `--space-16px`.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'css-theming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'self_explain'::public.block_type, 'Explain it in your own words', 'A colleague proposes a dark theme as a second stylesheet, loaded instead of the first. Write the case against it — be specific about what happens over the following year.',
       NULL, NULL, NULL, '{"modelAnswer":"It doubles every future change. Each new component, each tweak to an existing one, has to be made twice and kept in sync by hand — and the two files drift, because nothing enforces the relationship. Bugs then appear in one theme only, which are the most annoying kind to reproduce. It also cannot do partial theming: a dark footer inside a light page is impossible with a whole-document swap, but trivial when the tokens inherit. And a third theme — high contrast, or a seasonal brand — means a third full copy. The token approach costs one block of overrides per theme regardless of how many components exist, which is the only version of this that scales."}'::jsonb
from public.lessons where slug = 'css-theming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'checklist'::public.block_type, 'A workable token system', NULL,
       NULL, NULL, NULL, '{"items":["Tokens named after their role, not their appearance","Defined once on `:root`","Components read every colour and space through `var()`","A theme is a block of overrides, never a duplicated stylesheet","`prefers-color-scheme` respected by default","An explicit user choice able to override the system preference"]}'::jsonb
from public.lessons where slug = 'css-theming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["A theme is the same stylesheet with different token values.","Because tokens inherit, a theme can apply to the page or to one subtree.","Name tokens after roles — `--surface`, not `--white`.","Honour `prefers-color-scheme`, and let an explicit choice win over it."],"nextUp":"Next: the Level 7 milestone."}'::jsonb
from public.lessons where slug = 'css-theming';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why does a token-based theme scale where a second stylesheet does not?","Why name a token `--surface` rather than `--white`?","How can a theme apply to only part of a page?"],"points":["Because it costs one block of overrides per theme, regardless of how many components exist — whereas a duplicated stylesheet costs double work on every future change and drifts out of sync.","Because the name has to stay true in every theme. `--white: #111` in a dark theme is a lie, and a stylesheet that lies is worse than one with no tokens.","By putting the overriding selector on a wrapper rather than the root. Tokens inherit, so only that subtree sees the new values."]}'::jsonb
from public.lessons where slug = 'css-theming';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-theme-guided', 1, 'guided'::public.exercise_kind, 'Add a dark theme',
       'The card already reads its colours from tokens. Define the light values on `:root` — `--surface: white`, `--text: #111`, `--border: #ddd` — and add a `[data-theme="dark"]` block overriding the same three names with `#111`, `#f4f4f4` and `#333`. Do not change the `.card` rule.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Theme</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card {
        background: var(--surface);
        color: var(--text);
        border: 1px solid var(--border);
        padding: 1rem;
      }
    </style>
  </head>
  <body>
    <div class="card">Light card</div>
    <div data-theme="dark">
      <div class="card">Dark card</div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Theme</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root {
        --surface: white;
        --text: #111;
        --border: #ddd;
      }

      [data-theme="dark"] {
        --surface: #111;
        --text: #f4f4f4;
        --border: #333;
      }

      .card {
        background: var(--surface);
        color: var(--text);
        border: 1px solid var(--border);
        padding: 1rem;
      }
    </style>
  </head>
  <body>
    <div class="card">Light card</div>
    <div data-theme="dark">
      <div class="card">Dark card</div>
    </div>
  </body>
</html>', ARRAY['The light values go on :root so every element inherits them.', 'The dark block redefines exactly the same three names.', 'You should not need to touch the .card rule at all.']::text[],
       55, 3,
       (select id from public.skills where slug = 'custom-properties'), false
from public.lessons l where l.slug = 'css-theming'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, 'body > .card', 'background',
       'white', NULL, NULL, NULL,
       'The light card resolves to the light surface', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-theme-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '[data-theme="dark"] .card', 'background',
       '#111', NULL, NULL, NULL,
       'The dark card resolves to the dark surface', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-theme-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '[data-theme="dark"] .card', 'color',
       '#f4f4f4', NULL, NULL, NULL,
       'The dark card text follows the theme', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-theme-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_custom_property'::public.requirement_kind, '.card', '--border',
       NULL, NULL, NULL, NULL,
       'The border token is defined', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-theme-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-tokens-debug', 2, 'debug'::public.exercise_kind, 'Tokens that do not reach',
       'Two faults. The tokens are declared on `.theme`, which is a *sibling* of the card rather than an ancestor, so nothing resolves — move them to `:root`. And `--white` is a misleading name in a file that has a dark theme: rename it to `--surface` everywhere it appears.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tokens</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .theme { --white: #fff; --text: #111; }

      .card {
        background: var(--white);
        color: var(--text);
        padding: 1rem;
        border: 1px solid #ddd;
      }
    </style>
  </head>
  <body>
    <div class="theme"></div>
    <div class="card">Sourdough workshop</div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tokens</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root { --surface: #fff; --text: #111; }

      .card {
        background: var(--surface);
        color: var(--text);
        padding: 1rem;
        border: 1px solid #ddd;
      }
    </style>
  </head>
  <body>
    <div class="theme"></div>
    <div class="card">Sourdough workshop</div>
  </body>
</html>', ARRAY['Custom properties reach descendants only — a sibling cannot see them.', ':root is an ancestor of everything.', 'Rename --white to --surface in both the declaration and the var().']::text[],
       55, 3,
       (select id from public.skills where slug = 'custom-properties'), false
from public.lessons l where l.slug = 'css-theming'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_custom_property'::public.requirement_kind, '.card', '--surface',
       NULL, NULL, NULL, NULL,
       'The card can read a role-named surface token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, '.card', 'background',
       '#fff', NULL, NULL, NULL,
       'The background resolves from the token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.card', 'color',
       '#111', NULL, NULL, NULL,
       'The text colour resolves from the token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-theming'), NULL, 'q-css-theme-approach', 1, 'single'::public.question_kind,
        'What is a theme, in a token-based stylesheet?', 'The same rules with different token values — a block of overrides, not a second stylesheet.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A class on every component', false, NULL
from public.quiz_questions where slug = 'q-css-theme-approach';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A filter applied to the page', false, NULL
from public.quiz_questions where slug = 'q-css-theme-approach';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A block of token overrides', true, NULL
from public.quiz_questions where slug = 'q-css-theme-approach';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A duplicate stylesheet', false, NULL
from public.quiz_questions where slug = 'q-css-theme-approach';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-theming'), NULL, 'q-css-token-naming', 2, 'single'::public.question_kind,
        'Why is `--surface` a better token name than `--white`?', 'It stays true in every theme; `--white: #111` in a dark theme is actively misleading.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Colour names are invalid in custom properties', false, NULL
from public.quiz_questions where slug = 'q-css-token-naming';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It has higher specificity', false, NULL
from public.quiz_questions where slug = 'q-css-token-naming';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It describes the role, so it stays true in any theme', true, NULL
from public.quiz_questions where slug = 'q-css-token-naming';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is shorter', false, NULL
from public.quiz_questions where slug = 'q-css-token-naming';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-theming'), NULL, 'q-css-prefers-scheme', 3, 'single'::public.question_kind,
        'What does `@media (prefers-color-scheme: dark)` let you do?', 'Follow the choice the reader already made at the operating-system level.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Force dark mode on everyone', false, NULL
from public.quiz_questions where slug = 'q-css-prefers-scheme';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Detect the time of day', false, NULL
from public.quiz_questions where slug = 'q-css-prefers-scheme';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Change the theme when the page scrolls', false, NULL
from public.quiz_questions where slug = 'q-css-prefers-scheme';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Respect the reader’s system-level preference', true, NULL
from public.quiz_questions where slug = 'q-css-prefers-scheme';
-- lesson: Milestone: a themeable component
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'css-tokens-milestone', 3, 'Milestone: a themeable component', 'Tokens, a variant and a theme', 'One component, re-themed three ways without duplicating a rule.',
       ARRAY['Build a component entirely on tokens', 'Add a variant by scoping token values', 'Add a theme by overriding the same names']::text[], 18, 40, (select id from public.skills where slug = 'custom-properties'), 0.8
from public.modules m where m.slug = 'css-tokens'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Express a component in tokens","Create a variant with scoped overrides","Create a theme with root overrides"]}'::jsonb
from public.lessons where slug = 'css-tokens-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'The whole system', NULL,
       ':root        the default values, inherited everywhere
[data-theme] a theme — the same names, different values
.variant     a component variant — scoped to one subtree
var(--x, y)  a fallback, so the component stands alone

Variant and theme use the same mechanism. The only
difference is where the override is scoped.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'css-tokens-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'interactive_demo'::public.block_type, 'One component, three appearances', 'The `.card` rule is identical in all three.',
       NULL, NULL, NULL, '{"variants":[{"label":"Default","code":"<style>\n  :root { --surface: #fff; --text: #111; --accent: teal; }\n  .card { background: var(--surface); color: var(--text); border-left: 4px solid var(--accent); padding: 1rem; }\n</style>\n<div class=\"card\">Sourdough</div>","note":"Root tokens."},{"label":"Variant","code":"<style>\n  :root { --surface: #fff; --text: #111; --accent: teal; }\n  .featured { --accent: crimson; }\n  .card { background: var(--surface); color: var(--text); border-left: 4px solid var(--accent); padding: 1rem; }\n</style>\n<div class=\"card featured\">Rye — featured</div>","note":"One token overridden on the element itself."},{"label":"Theme","code":"<style>\n  :root { --surface: #fff; --text: #111; --accent: teal; }\n  [data-theme=\"dark\"] { --surface: #111; --text: #f4f4f4; }\n  .card { background: var(--surface); color: var(--text); border-left: 4px solid var(--accent); padding: 1rem; }\n</style>\n<div data-theme=\"dark\"><div class=\"card\">Seeded</div></div>","note":"The same mechanism scoped to an ancestor instead."}]}'::jsonb
from public.lessons where slug = 'css-tokens-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'recall'::public.block_type, 'From memory', 'From memory: what do each of these do, and where does each belong?',
       NULL, NULL, NULL, '{"points":["`:root { --x: … }` — declares a document-wide token every element inherits.","`var(--x)` — reads it, resolved fresh for each element that uses it.","`var(--x, fallback)` — reads it, with a value to use when it is not set.","`.variant { --x: … }` — overrides it for one element and its descendants.","`[data-theme=\"dark\"] { --x: … }` — overrides it for a whole subtree."]}'::jsonb
from public.lessons where slug = 'css-tokens-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Variants and themes are the same mechanism at different scopes.","Components should contain no literal colours at all.","Fallbacks let a component work before the tokens exist."],"nextUp":"Next: typography and colour."}'::jsonb
from public.lessons where slug = 'css-tokens-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why is \"the component contains no literal colours\" the step that makes everything else possible?"],"points":["Because every later capability — variants, themes, a high-contrast mode, a per-section accent — works by changing what a name means. If a component hard-codes a colour, none of those can reach it, and the only remaining option is to duplicate the rule. Doing this one thing first is what turns theming from a rewrite into three lines."]}'::jsonb
from public.lessons where slug = 'css-tokens-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'css-tokens-milestone-challenge', 1, 'challenge'::public.exercise_kind, 'Tokens, a variant and a theme',
       'Define `--surface: #fff`, `--text: #111` and `--accent: teal` on `:root`. Make `.card` use all three — background, colour, and a `4px` solid left border in the accent. Add a `.featured` variant that overrides `--accent` to `crimson`, and a `[data-theme="dark"]` block overriding `--surface` to `#111` and `--text` to `#f4f4f4`. The `.card` rule must contain no literal colours.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tokens milestone</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      .card { padding: 1rem; margin-bottom: 0.5rem; }
    </style>
  </head>
  <body>
    <div class="card">Sourdough</div>
    <div class="card featured">Rye — featured</div>
    <div data-theme="dark">
      <div class="card">Seeded</div>
    </div>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Tokens milestone</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }

      :root {
        --surface: #fff;
        --text: #111;
        --accent: teal;
      }

      [data-theme="dark"] {
        --surface: #111;
        --text: #f4f4f4;
      }

      .featured { --accent: crimson; }

      .card {
        background: var(--surface);
        color: var(--text);
        border-left: 4px solid var(--accent);
        padding: 1rem;
        margin-bottom: 0.5rem;
      }
    </style>
  </head>
  <body>
    <div class="card">Sourdough</div>
    <div class="card featured">Rye — featured</div>
    <div data-theme="dark">
      <div class="card">Seeded</div>
    </div>
  </body>
</html>', ARRAY['Declare the three tokens on :root first.', '.featured only needs to override --accent — nothing else.', 'The theme block overrides --surface and --text on a wrapper.', 'Every colour in .card should be a var().']::text[],
       70, 4,
       (select id from public.skills where slug = 'custom-properties'), false
from public.lessons l where l.slug = 'css-tokens-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 1, 'css_value'::public.requirement_kind, 'body > .card', 'background',
       '#fff', NULL, NULL, NULL,
       'The default card uses the surface token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 2, 'css_value'::public.requirement_kind, 'body > .card', 'color',
       '#111', NULL, NULL, NULL,
       'The default card uses the text token', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 3, 'css_value'::public.requirement_kind, '.featured', 'border-left',
       '4px solid crimson', NULL, NULL, NULL,
       'The variant overrides only the accent', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 4, 'css_value'::public.requirement_kind, '[data-theme="dark"] .card', 'background',
       '#111', NULL, NULL, NULL,
       'The theme changes the surface', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-milestone-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, 5, 'css_value'::public.requirement_kind, '[data-theme="dark"] .card', 'color',
       '#f4f4f4', NULL, NULL, NULL,
       'The theme changes the text colour', NULL, 1, true, NULL
from public.exercises e where e.slug = 'css-tokens-milestone-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-tokens-milestone'), NULL, 'q-css-variant-vs-theme', 1, 'single'::public.question_kind,
        'What is the difference between a variant and a theme, mechanically?', 'Only the scope of the override — the mechanism is identical.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Themes cannot use custom properties', false, NULL
from public.quiz_questions where slug = 'q-css-variant-vs-theme';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Only where the override is scoped', true, NULL
from public.quiz_questions where slug = 'q-css-variant-vs-theme';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Themes use classes, variants use attributes', false, NULL
from public.quiz_questions where slug = 'q-css-variant-vs-theme';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Variants require duplicated rules', false, NULL
from public.quiz_questions where slug = 'q-css-variant-vs-theme';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'css-tokens-milestone'), NULL, 'q-css-no-literal-colours', 2, 'single'::public.question_kind,
        'Why should a themeable component contain no literal colours?', 'Every theme, variant and contrast mode works by changing what a token name means — a literal colour is unreachable by all of them.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It reduces specificity', false, NULL
from public.quiz_questions where slug = 'q-css-no-literal-colours';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A literal colour cannot be reached by any theme or variant', true, NULL
from public.quiz_questions where slug = 'q-css-no-literal-colours';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Literal colours are slower to render', false, NULL
from public.quiz_questions where slug = 'q-css-no-literal-colours';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Hex codes are invalid in components', false, NULL
from public.quiz_questions where slug = 'q-css-no-literal-colours';
-- Level 7 milestone: Custom Properties questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-7-milestone'), 'a-css-7-syntax', 1, 'single'::public.question_kind,
        'How is a custom property named?', 'It begins with two hyphens.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Any valid identifier', false, NULL
from public.quiz_questions where slug = 'a-css-7-syntax';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Beginning with `--`', true, NULL
from public.quiz_questions where slug = 'a-css-7-syntax';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Beginning with `$`', false, NULL
from public.quiz_questions where slug = 'a-css-7-syntax';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Beginning with `@`', false, NULL
from public.quiz_questions where slug = 'a-css-7-syntax';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-7-milestone'), 'a-css-7-resolved-when', 2, 'single'::public.question_kind,
        'When is a custom property resolved?', 'Each time it is used, per element — which is why overrides and runtime changes work.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'When the element is first painted', false, NULL
from public.quiz_questions where slug = 'a-css-7-resolved-when';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Each time it is used, per element', true, NULL
from public.quiz_questions where slug = 'a-css-7-resolved-when';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Once, when the stylesheet is compiled', false, NULL
from public.quiz_questions where slug = 'a-css-7-resolved-when';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only on page load', false, NULL
from public.quiz_questions where slug = 'a-css-7-resolved-when';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'css-level-7-milestone'), 'a-css-7-sibling-scope', 3, 'single'::public.question_kind,
        'A token declared on `.panel` — can a sibling of `.panel` use it?', 'No. Custom properties reach descendants only.', (select id from public.skills where slug = 'custom-properties'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Yes, they are global', false, NULL
from public.quiz_questions where slug = 'a-css-7-sibling-scope';

commit;
