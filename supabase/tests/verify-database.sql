-- ---------------------------------------------------------------------------
-- HTML Hero — database health check
--
-- Paste into the Supabase SQL editor at any time. Read-only: it asserts the
-- schema, the security posture and the loaded content, and changes nothing.
--
-- Every row should read PASS. Failures sort to the top.
-- ---------------------------------------------------------------------------

with checks(item, ok, detail) as (
  select 'Every expected table exists',
         count(*) = 35, count(*)::text || ' of 35'
  from pg_tables where schemaname = 'public' and tablename in (
    'skills','skill_prerequisites','courses','levels','modules','module_prerequisites',
    'module_skills','lessons','lesson_blocks','exercises','exercise_requirements',
    'assessments','quiz_questions','quiz_options','learning_media','media_attributions',
    'project_templates','achievements','profiles','learning_plans','user_lesson_progress',
    'exercise_attempts','saved_code','quiz_attempts','assessment_attempts',
    'user_skill_mastery','user_projects','project_files','user_achievements',
    'xp_transactions','study_sessions','certificates','review_items','review_states','review_logs')
  union all
  select 'Review tables created (0006)',
         count(*) = 3, count(*)::text || ' of 3'
  from pg_tables where schemaname='public' and tablename in ('review_items','review_states','review_logs')
  union all
  select 'Row Level Security on every table',
         bool_and(c.relrowsecurity), count(*) filter (where not c.relrowsecurity)::text || ' unprotected'
  from pg_class c join pg_namespace n on n.oid=c.relnamespace
  where n.nspname='public' and c.relkind='r'
  union all
  select 'Review history is append-only',
         count(*) = 0, count(*)::text || ' write policies found'
  from pg_policies where tablename='review_logs' and cmd in ('UPDATE','DELETE')
  union all
  select 'XP ledger is append-only',
         count(*) = 0, count(*)::text || ' write policies found'
  from pg_policies where tablename='xp_transactions' and cmd in ('UPDATE','DELETE')
  union all
  select 'Confidence recorded on answers (0006)',
         count(*) = 1, count(*)::text
  from information_schema.columns where table_name='quiz_attempts' and column_name='confidence'
  union all
  select 'New lesson block types (0006)',
         count(*) = 6, count(*)::text || ' of 6'
  from pg_enum e join pg_type t on t.oid=e.enumtypid
  where t.typname='block_type'
    and e.enumlabel in ('pretest','recall','predict_check','self_explain','worked_example','recap')
  union all
  select 'Ordering constraints deferrable (0007)',
         count(*) = 4, count(*)::text || ' of 4'
  from pg_constraint
  where conname in ('levels_course_id_ordinal_key','modules_level_id_ordinal_key',
                    'lessons_module_id_ordinal_key','exercises_lesson_id_ordinal_key')
    and condeferrable
  union all
  select 'Course content loaded',
         (select count(*) from lessons) = 55
         and (select count(*) from quiz_questions) = 241
         and (select count(*) from lesson_blocks) = 664,
         -- The block count is in the detail because it is the figure that
         -- changes most often, and a failure that does not say which of the
         -- three numbers is wrong sends you looking in the wrong place.
         (select count(*) from lessons)::text || ' lessons, '
         || (select count(*) from quiz_questions)::text || ' questions, '
         || (select count(*) from lesson_blocks)::text || ' blocks'
  union all
  -- These two were added after a live database was found passing every check
  -- while holding zero review items: the seed had been loaded before the pool
  -- existed and never reloaded, so /review was silently empty. A health check
  -- that cannot see an entirely absent feature is not checking much.
  select 'Reviewable items loaded',
         (select count(*) from review_items) = 230
         and (select count(*) from review_items where kind = 'exercise') = 93
         and (select count(*) from review_items where kind = 'question') = 137,
         (select count(*) from review_items)::text || ' items ('
         || (select count(*) from review_items where kind = 'question')::text || ' questions, '
         || (select count(*) from review_items where kind = 'exercise')::text || ' exercises)'
  union all
  select 'Retrieval-practice blocks authored',
         (select count(*) from lesson_blocks
          where block_type in ('pretest','recall','predict_check','self_explain','worked_example','recap')) > 0
         and (select count(distinct block_type) from lesson_blocks
              where block_type in ('pretest','recall','predict_check','self_explain','worked_example','recap')) = 6,
         (select count(*) from lesson_blocks
          where block_type in ('pretest','recall','predict_check','self_explain','worked_example','recap'))::text
         || ' blocks across '
         || (select count(distinct block_type) from lesson_blocks
             where block_type in ('pretest','recall','predict_check','self_explain','worked_example','recap'))::text
         || ' of 6 types'
  union all
  select 'All 12 levels and 21 modules',
         (select count(*) from levels) = 12 and (select count(*) from modules) = 21,
         (select count(*) from levels)::text || ' levels, ' || (select count(*) from modules)::text || ' modules'
  union all
  select 'Media library registered',
         (select count(*) from learning_media) = 38, (select count(*) from learning_media)::text || ' of 38'
)
select case when ok then 'PASS' else 'FAIL' end as result, item, detail
from checks order by ok, item;
