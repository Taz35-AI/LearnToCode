-- HTML Hero — course seed, part 9 of 9
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 8 first.

begin;
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
-- Items whose question or exercise has left the curriculum.
delete from public.review_items where slug not in ('rv-q-q-what-is-html', 'rv-q-q-html-purpose', 'rv-e-first-markup-guided', 'rv-e-first-markup-debug', 'rv-q-q-tag-vs-element', 'rv-q-q-attribute-syntax', 'rv-q-q-void-elements', 'rv-e-attributes-guided', 'rv-e-attributes-challenge', 'rv-e-attributes-debug', 'rv-q-q-nesting-order', 'rv-q-q-dom-meaning', 'rv-q-q-comments', 'rv-e-nesting-guided', 'rv-e-nesting-debug', 'rv-q-q-doctype-purpose', 'rv-q-q-head-vs-body', 'rv-q-q-viewport', 'rv-q-q-charset', 'rv-e-skeleton-guided', 'rv-e-skeleton-debug', 'rv-q-q-index-html', 'rv-q-q-one-h1', 'rv-e-first-page-milestone', 'rv-q-q-heading-skip', 'rv-q-q-heading-purpose', 'rv-e-headings-guided', 'rv-e-headings-debug', 'rv-q-q-whitespace', 'rv-q-q-br-use', 'rv-q-q-hr-meaning', 'rv-e-paragraphs-guided', 'rv-e-paragraphs-debug', 'rv-q-q-strong-vs-em', 'rv-q-q-small-meaning', 'rv-e-emphasis-guided', 'rv-e-emphasis-challenge', 'rv-q-q-cite-meaning', 'rv-q-q-datetime-format', 'rv-q-q-q-quotes', 'rv-e-quotes-guided', 'rv-e-quotes-debug', 'rv-q-q-entity-lt', 'rv-q-q-list-choice', 'rv-q-q-nested-list', 'rv-e-lists-guided', 'rv-e-entities-debug', 'rv-q-q-semantic-choice', 'rv-e-article-milestone-build', 'rv-q-q-link-text', 'rv-q-q-noopener', 'rv-e-links-guided', 'rv-e-links-debug', 'rv-q-q-dotdot', 'rv-q-q-leading-slash', 'rv-q-q-fragment-case', 'rv-e-paths-guided', 'rv-e-fragments-challenge', 'rv-e-paths-debug', 'rv-q-q-tel-format', 'rv-q-q-download-attr', 'rv-e-special-links-guided', 'rv-q-q-nav-list', 'rv-q-q-skip-link-position', 'rv-q-q-aria-current', 'rv-e-nav-guided', 'rv-e-skip-link-challenge', 'rv-e-nav-debug', 'rv-q-q-filenames', 'rv-q-q-nav-consistency', 'rv-e-multipage-milestone-build', 'rv-q-q-img-dimensions', 'rv-q-q-hotlinking', 'rv-e-img-guided', 'rv-e-img-debug', 'rv-q-q-empty-alt', 'rv-q-q-alt-vs-caption', 'rv-q-q-missing-alt', 'rv-e-alt-guided', 'rv-e-figure-challenge', 'rv-q-q-srcset-w', 'rv-q-q-sizes-purpose', 'rv-e-srcset-guided', 'rv-e-srcset-debug', 'rv-q-q-picture-img', 'rv-q-q-lazy-hero', 'rv-q-q-picture-vs-srcset', 'rv-e-picture-guided', 'rv-e-lazy-challenge', 'rv-q-q-video-controls', 'rv-q-q-track-kind', 'rv-q-q-fallback-placement', 'rv-e-video-guided', 'rv-e-video-debug', 'rv-q-q-iframe-title', 'rv-q-q-sandbox', 'rv-e-iframe-guided', 'rv-e-media-milestone', 'rv-q-q-semantic-meaning', 'rv-q-q-main-count', 'rv-e-landmarks-guided', 'rv-q-q-article-test', 'rv-q-q-section-heading', 'rv-q-q-outline-algorithm', 'rv-e-section-article-guided', 'rv-e-section-debug', 'rv-q-q-case-sensitivity', 'rv-q-q-comments-value', 'rv-e-patterns-guided', 'rv-q-q-footer-placement', 'rv-e-semantic-rebuild', 'rv-q-q-scope-col', 'rv-q-q-caption-position', 'rv-q-q-layout-tables', 'rv-e-table-guided', 'rv-e-table-debug', 'rv-q-q-label-for', 'rv-q-q-placeholder', 'rv-q-q-number-type', 'rv-q-q-name-attribute', 'rv-e-labels-guided', 'rv-e-input-types-debug', 'rv-q-q-radio-group', 'rv-q-q-button-type', 'rv-q-q-legend-position', 'rv-e-fieldset-guided', 'rv-e-controls-challenge', 'rv-q-q-client-validation', 'rv-q-q-get-vs-post', 'rv-q-q-aria-describedby', 'rv-e-validation-guided', 'rv-e-form-milestone', 'rv-q-q-summary-position', 'rv-q-q-details-name', 'rv-e-details-guided', 'rv-q-q-dialog-close', 'rv-q-q-popover-js', 'rv-q-q-modal-content', 'rv-e-popover-guided', 'rv-e-dialog-debug', 'rv-q-q-progress-vs-meter', 'rv-q-q-datalist-restrict', 'rv-e-datalist-guided', 'rv-e-native-milestone', 'rv-q-q-a11y-tree', 'rv-q-q-keyboard-test', 'rv-q-q-div-button', 'rv-e-keyboard-debug', 'rv-q-q-aria-first-rule', 'rv-q-q-aria-behaviour', 'rv-q-q-labelledby-vs-label', 'rv-e-aria-guided', 'rv-e-aria-debug', 'rv-q-q-audit-order', 'rv-q-q-duplicate-id-impact', 'rv-e-a11y-audit-milestone', 'rv-q-q-title-length', 'rv-q-q-canonical', 'rv-q-q-noindex-security', 'rv-e-metadata-guided', 'rv-e-metadata-debug', 'rv-q-q-og-property', 'rv-q-q-structured-data-ranking', 'rv-q-q-og-image-url', 'rv-e-og-guided', 'rv-e-jsonld-challenge', 'rv-q-q-metadata-order', 'rv-e-seo-milestone-build', 'rv-q-q-layout-shift', 'rv-q-q-defer-async', 'rv-q-q-preload-overuse', 'rv-e-perf-guided', 'rv-q-q-noopener-why', 'rv-q-q-hidden-input', 'rv-q-q-csp-header', 'rv-e-security-debug', 'rv-q-q-preload-auto', 'rv-e-performance-milestone-build', 'rv-q-q-validator-order', 'rv-q-q-validator-limits', 'rv-q-q-duplicate-id-effect', 'rv-e-validation-debug', 'rv-q-q-elements-panel', 'rv-q-q-network-404', 'rv-q-q-one-change', 'rv-e-devtools-debug', 'rv-q-q-repair-order', 'rv-e-repair-milestone', 'rv-q-q-shell-difference', 'rv-e-shell-guided', 'rv-q-q-capstone-media', 'rv-e-capstone-main-build', 'rv-q-q-review-order', 'rv-q-q-publishing', 'rv-e-final-review-exercise');

commit;
