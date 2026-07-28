-- HTML Hero — course seed, part 15 of 16
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 14 first.

begin;
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
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-inline-ignores', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'layout-flow'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-normal-flow' and qq.slug = 'q-css-inline-ignores'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-display-none-cost', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'layout-flow'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-normal-flow' and qq.slug = 'q-css-display-none-cost'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-replaced-elements', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'layout-flow'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-normal-flow' and qq.slug = 'q-css-replaced-elements'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-flow-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'layout-flow'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'css-normal-flow' and e.slug = 'css-flow-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-absolute-against', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'layout-flow'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-position-and-stacking' and qq.slug = 'q-css-absolute-against'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-stacking-context-cause', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'layout-flow'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-position-and-stacking' and qq.slug = 'q-css-stacking-context-cause'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-zindex-static', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'layout-flow'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-position-and-stacking' and qq.slug = 'q-css-zindex-static'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-position-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'layout-flow'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-position-and-stacking' and e.slug = 'css-position-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-stacking-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'layout-flow'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-position-and-stacking' and e.slug = 'css-stacking-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-out-of-flow-space', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'layout-flow'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-flow-milestone' and qq.slug = 'q-css-out-of-flow-space'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-relative-no-offsets', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'layout-flow'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-flow-milestone' and qq.slug = 'q-css-relative-no-offsets'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-flow-milestone-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'layout-flow'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-flow-milestone' and e.slug = 'css-flow-milestone-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-justify-axis', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-flex-axes' and qq.slug = 'q-css-justify-axis'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-align-items-default', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-flex-axes' and qq.slug = 'q-css-align-items-default'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-gap-benefit', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-flex-axes' and qq.slug = 'q-css-gap-benefit'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-flex-centre-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'css-flex-axes' and e.slug = 'css-flex-centre-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-flex-axis-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-flex-axes' and e.slug = 'css-flex-axis-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-flex-1-expands', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-flex-sizing' and qq.slug = 'q-css-flex-1-expands'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-flex-auto-vs-1', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-flex-sizing' and qq.slug = 'q-css-flex-auto-vs-1'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-min-width-zero', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-flex-sizing' and qq.slug = 'q-css-min-width-zero'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-flex-sidebar-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-flex-sizing' and e.slug = 'css-flex-sidebar-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-flex-wrap-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-flex-sizing' and e.slug = 'css-flex-wrap-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-space-between', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-flex-milestone' and qq.slug = 'q-css-space-between'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-nested-flex', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-flex-milestone' and qq.slug = 'q-css-nested-flex'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-flex-milestone-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'flexbox'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-flex-milestone' and e.slug = 'css-flex-milestone-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-fr-meaning', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'grid'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-grid-tracks' and qq.slug = 'q-css-fr-meaning'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-implicit-rows', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'grid'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-grid-tracks' and qq.slug = 'q-css-implicit-rows'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-fr-vs-percent', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'grid'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-grid-tracks' and qq.slug = 'q-css-fr-vs-percent'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-grid-tracks-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'grid'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'css-grid-tracks' and e.slug = 'css-grid-tracks-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-auto-fit', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'grid'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-grid-areas-and-auto-fit' and qq.slug = 'q-css-auto-fit'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-auto-fit-vs-fill', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'grid'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-grid-areas-and-auto-fit' and qq.slug = 'q-css-auto-fit-vs-fill'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-grid-vs-flex', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'grid'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-grid-areas-and-auto-fit' and qq.slug = 'q-css-grid-vs-flex'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-grid-responsive-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'grid'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-grid-areas-and-auto-fit' and e.slug = 'css-grid-responsive-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-grid-areas-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'grid'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-grid-areas-and-auto-fit' and e.slug = 'css-grid-areas-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-area-span', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'grid'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-grid-milestone' and qq.slug = 'q-css-area-span'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-nested-grid-why', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'grid'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-grid-milestone' and qq.slug = 'q-css-nested-grid-why'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-grid-milestone-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'grid'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-grid-milestone' and e.slug = 'css-grid-milestone-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-max-width', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-fluid-first' and qq.slug = 'q-css-max-width'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-clamp-parts', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-fluid-first' and qq.slug = 'q-css-clamp-parts'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-ch-unit', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-fluid-first' and qq.slug = 'q-css-ch-unit'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-fluid-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'css-fluid-first' and e.slug = 'css-fluid-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-mobile-first', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-queries' and qq.slug = 'q-css-mobile-first'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-breakpoint-source', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-queries' and qq.slug = 'q-css-breakpoint-source'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-container-query-why', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-queries' and qq.slug = 'q-css-container-query-why'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-mobile-first-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-queries' and e.slug = 'css-mobile-first-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-responsive-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-queries' and e.slug = 'css-responsive-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-query-last-resort', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-responsive-milestone' and qq.slug = 'q-css-query-last-resort'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-rem-breakpoints', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-responsive-milestone' and qq.slug = 'q-css-rem-breakpoints'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-responsive-milestone-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-responsive-milestone' and e.slug = 'css-responsive-milestone-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-token-inherits', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-declaring-tokens' and qq.slug = 'q-css-token-inherits'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-var-fallback', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-declaring-tokens' and qq.slug = 'q-css-var-fallback'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-token-scope', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-declaring-tokens' and qq.slug = 'q-css-token-scope'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-tokens-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'css-declaring-tokens' and e.slug = 'css-tokens-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-theme-approach', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-theming' and qq.slug = 'q-css-theme-approach'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-token-naming', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-theming' and qq.slug = 'q-css-token-naming'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-prefers-scheme', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-theming' and qq.slug = 'q-css-prefers-scheme'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-theme-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-theming' and e.slug = 'css-theme-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-tokens-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-theming' and e.slug = 'css-tokens-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-variant-vs-theme', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-tokens-milestone' and qq.slug = 'q-css-variant-vs-theme'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-no-literal-colours', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-tokens-milestone' and qq.slug = 'q-css-no-literal-colours'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-tokens-milestone-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-tokens-milestone' and e.slug = 'css-tokens-milestone-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-measure', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'typography'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-readable-type' and qq.slug = 'q-css-measure'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-lineheight-unit', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'typography'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-readable-type' and qq.slug = 'q-css-lineheight-unit'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-rem-type', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'typography'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-readable-type' and qq.slug = 'q-css-rem-type'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-type-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'typography'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'css-readable-type' and e.slug = 'css-type-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-contrast-body', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'typography'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-colour-contrast' and qq.slug = 'q-css-contrast-body'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-colour-alone', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'typography'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-colour-contrast' and qq.slug = 'q-css-colour-alone'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-currentcolor', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'typography'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-colour-contrast' and qq.slug = 'q-css-currentcolor'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-contrast-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'typography'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-colour-contrast' and e.slug = 'css-contrast-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-scale-benefit', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'typography'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-type-milestone' and qq.slug = 'q-css-scale-benefit'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-heading-leading', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'typography'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-type-milestone' and qq.slug = 'q-css-heading-leading'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-type-milestone-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'typography'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-type-milestone' and e.slug = 'css-type-milestone-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-transition-where', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'animation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-transitions' and qq.slug = 'q-css-transition-where'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-transition-all', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'animation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-transitions' and qq.slug = 'q-css-transition-all'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-duration', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'animation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-transitions' and qq.slug = 'q-css-duration'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-transition-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'animation'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'css-transitions' and e.slug = 'css-transition-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-cheap-props', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'animation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-keyframes-motion' and qq.slug = 'q-css-cheap-props'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-reduced-motion', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'animation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-keyframes-motion' and qq.slug = 'q-css-reduced-motion'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-keyframes-name', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'animation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-keyframes-motion' and qq.slug = 'q-css-keyframes-name'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-motion-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'animation'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-keyframes-motion' and e.slug = 'css-motion-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-motion-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'animation'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-keyframes-motion' and e.slug = 'css-motion-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-motion-both', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'animation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-motion-milestone' and qq.slug = 'q-css-motion-both'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-motion-important', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'animation'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-motion-milestone' and qq.slug = 'q-css-motion-important'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-motion-milestone-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'animation'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-motion-milestone' and e.slug = 'css-motion-milestone-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-important-escalation', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-architecture'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-naming' and qq.slug = 'q-css-important-escalation'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-flat-selectors', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-architecture'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-naming' and qq.slug = 'q-css-flat-selectors'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-name-meaning', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-architecture'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-naming' and qq.slug = 'q-css-name-meaning'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-naming-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'css-architecture'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-naming' and e.slug = 'css-naming-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-layer-order', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-architecture'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-scale' and qq.slug = 'q-css-layer-order'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-where-reset', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-architecture'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-scale' and qq.slug = 'q-css-where-reset'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-deletable', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-architecture'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-scale' and qq.slug = 'q-css-deletable'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-layers-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'css-architecture'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-scale' and e.slug = 'css-layers-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-variant-class', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-architecture'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-architecture-milestone' and qq.slug = 'q-css-variant-class'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-arch-goal', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-architecture'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-architecture-milestone' and qq.slug = 'q-css-arch-goal'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-architecture-milestone-challenge', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'css-architecture'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-architecture-milestone' and e.slug = 'css-architecture-milestone-challenge'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-struck-through', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-inspector' and qq.slug = 'q-css-struck-through'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-computed-panel', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-inspector' and qq.slug = 'q-css-computed-panel'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-missing-rule', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-inspector' and qq.slug = 'q-css-missing-rule'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-invalid-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'css-debugging'),
       l.id, e.id, 2
from public.lessons l, public.exercises e
where l.slug = 'css-inspector' and e.slug = 'css-invalid-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-first-check', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-diagnosis' and qq.slug = 'q-css-first-check'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-inline-width', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-diagnosis' and qq.slug = 'q-css-inline-width'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-bisect', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-diagnosis' and qq.slug = 'q-css-bisect'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-applies-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'css-debugging'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-diagnosis' and e.slug = 'css-applies-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-signature-invalid', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-debugging-milestone' and qq.slug = 'q-css-signature-invalid'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-repair-by-lowering', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'css-debugging'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-debugging-milestone' and qq.slug = 'q-css-repair-by-lowering'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-debugging-milestone-debug', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'css-debugging'),
       l.id, e.id, 4
from public.lessons l, public.exercises e
where l.slug = 'css-debugging-milestone' and e.slug = 'css-debugging-milestone-debug'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-capstone-order', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-capstone-foundation' and qq.slug = 'q-css-capstone-order'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-capstone-typography', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-capstone-foundation' and qq.slug = 'q-css-capstone-typography'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select 'rv-e-css-capstone-foundation-guided', 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = 'custom-properties'),
       l.id, e.id, 3
from public.lessons l, public.exercises e
where l.slug = 'css-capstone-foundation' and e.slug = 'css-capstone-foundation-guided'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;
insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select 'rv-q-q-css-capstone-autofit', 'question'::public.review_item_kind,
       (select id from public.skills where slug = 'responsive'),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = 'css-capstone-layout' and qq.slug = 'q-css-capstone-autofit'
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;

commit;
