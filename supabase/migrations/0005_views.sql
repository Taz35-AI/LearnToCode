-- ---------------------------------------------------------------------------
-- HTML Hero — 0005 reporting views
--
-- All views are declared `security_invoker = true`, so the Row Level Security
-- policies from 0004 still apply to whoever queries them. A learner reading
-- these views sees only their own rows.
-- ---------------------------------------------------------------------------

-- Flat course outline: one row per lesson with its module and level context.
create view public.course_outline
with (security_invoker = true) as
select
  c.id            as course_id,
  c.slug          as course_slug,
  l.id            as level_id,
  l.slug          as level_slug,
  l.ordinal       as level_ordinal,
  l.title         as level_title,
  m.id            as module_id,
  m.slug          as module_slug,
  m.ordinal       as module_ordinal,
  m.title         as module_title,
  m.is_milestone,
  ls.id           as lesson_id,
  ls.slug         as lesson_slug,
  ls.ordinal      as lesson_ordinal,
  ls.title        as lesson_title,
  ls.estimated_minutes,
  ls.xp_award,
  ls.primary_skill_id
from public.courses c
join public.levels l  on l.course_id = c.id
join public.modules m on m.level_id = l.id
join public.lessons ls on ls.module_id = m.id;

-- Aggregate learner totals in one round-trip for the dashboard.
create view public.user_progress_overview
with (security_invoker = true) as
select
  p.id as user_id,
  coalesce((select sum(x.amount) from public.xp_transactions x where x.user_id = p.id), 0)::integer as total_xp,
  coalesce((select count(*) from public.user_lesson_progress ulp
            where ulp.user_id = p.id and ulp.status = 'completed'), 0)::integer as lessons_completed,
  coalesce((select count(*) from public.user_skill_mastery usm
            where usm.user_id = p.id and usm.state = 'mastered'), 0)::integer as skills_mastered,
  coalesce((select count(*) from public.user_skill_mastery usm
            where usm.user_id = p.id and usm.needs_practice), 0)::integer as skills_needing_practice,
  coalesce((select count(*) from public.user_achievements ua
            where ua.user_id = p.id), 0)::integer as achievements_unlocked,
  coalesce((select sum(ss.seconds) from public.study_sessions ss
            where ss.user_id = p.id), 0)::integer as total_study_seconds,
  (select max(ss.study_date) from public.study_sessions ss where ss.user_id = p.id) as last_study_date
from public.profiles p;

grant select on public.course_outline to anon, authenticated;
grant select on public.user_progress_overview to authenticated;
