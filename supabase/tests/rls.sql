\set ON_ERROR_STOP on
\pset pager off
\pset tuples_only on

-- Setup, as the owner (bypasses RLS, like the service role).
delete from auth.users;
insert into auth.users (id, email) values
  ('11111111-1111-1111-1111-111111111111', 'alice@example.test'),
  ('22222222-2222-2222-2222-222222222222', 'bob@example.test');

insert into public.user_lesson_progress (user_id, lesson_id, status)
select '11111111-1111-1111-1111-111111111111', id, 'completed' from public.lessons limit 3;
insert into public.user_lesson_progress (user_id, lesson_id, status)
select '22222222-2222-2222-2222-222222222222', id, 'completed' from public.lessons limit 5;

insert into public.xp_transactions (user_id, amount, source_type, source_id, reason) values
  ('11111111-1111-1111-1111-111111111111', 100, 'lesson', 'l1', 'Lesson completed'),
  ('22222222-2222-2222-2222-222222222222', 250, 'lesson', 'l1', 'Lesson completed');

insert into public.user_projects (id, user_id, name)
values ('33333333-3333-3333-3333-333333333333',
        '11111111-1111-1111-1111-111111111111', 'alice project');

select case when count(*) = 2 then 'PASS' else 'FAIL' end || '  profiles auto-created for new users'
from public.profiles;

-- === Alice =================================================================
begin;
set local role authenticated;
select set_config('request.jwt.claim.sub', '11111111-1111-1111-1111-111111111111', true);

select case when count(*) = 3 then 'PASS' else 'FAIL' end || '  alice sees only her own lesson progress'
from public.user_lesson_progress;

select case when coalesce(sum(amount),0) = 100 then 'PASS' else 'FAIL' end || '  alice sees only her own XP'
from public.xp_transactions;

select case when count(*) = 1 then 'PASS' else 'FAIL' end || '  alice sees only her own profile'
from public.profiles;

select case when count(*) = 48 then 'PASS' else 'FAIL' end || '  alice can read the whole catalogue'
from public.lessons;

select case when count(*) > 0 then 'PASS' else 'FAIL' end || '  alice can read exercise requirements'
from public.exercise_requirements;

select case when count(*) = 1 then 'PASS' else 'FAIL' end || '  alice sees only her own project'
from public.user_projects;
commit;

-- === Bob ===================================================================
begin;
set local role authenticated;
select set_config('request.jwt.claim.sub', '22222222-2222-2222-2222-222222222222', true);

select case when count(*) = 5 then 'PASS' else 'FAIL' end || '  bob sees only his own lesson progress'
from public.user_lesson_progress;

select case when coalesce(sum(amount),0) = 250 then 'PASS' else 'FAIL' end || '  bob sees only his own XP'
from public.xp_transactions;

select case when count(*) = 0 then 'PASS' else 'FAIL' end || '  bob cannot see alice''s project'
from public.user_projects;

do $$
begin
  insert into public.xp_transactions (user_id, amount, source_type, source_id, reason)
  values ('11111111-1111-1111-1111-111111111111', 9999, 'bonus', 'cheat', 'stolen');
  raise warning 'FAIL  bob granted XP to alice';
exception when insufficient_privilege or check_violation then
  raise notice 'PASS  bob cannot grant XP to another learner';
end $$;

do $$
begin
  insert into public.xp_transactions (user_id, amount, source_type, source_id, reason)
  values ('22222222-2222-2222-2222-222222222222', 250, 'lesson', 'l1', 'duplicate');
  raise warning 'FAIL  duplicate XP was accepted';
exception when unique_violation then
  raise notice 'PASS  duplicate XP rejected by the database constraint';
end $$;

do $$
declare affected integer;
begin
  update public.xp_transactions set amount = 99999;
  get diagnostics affected = row_count;
  if affected > 0 then raise warning 'FAIL  XP ledger was editable';
  else raise notice 'PASS  XP ledger is append-only'; end if;
exception when insufficient_privilege then
  raise notice 'PASS  XP ledger is append-only (write denied)';
end $$;

do $$
begin
  update public.lessons set title = 'hacked';
  raise warning 'FAIL  learner edited the catalogue';
exception when insufficient_privilege then
  raise notice 'PASS  catalogue is read-only for learners';
end $$;

do $$
begin
  insert into public.project_files (project_id, user_id, path, content)
  values ('33333333-3333-3333-3333-333333333333',
          '22222222-2222-2222-2222-222222222222', 'index.html', 'hi');
  raise warning 'FAIL  bob attached a file to alice''s project';
exception when insufficient_privilege then
  raise notice 'PASS  bob cannot attach files to another learner''s project';
end $$;

do $$
begin
  insert into public.project_files (project_id, user_id, path, content)
  values ('33333333-3333-3333-3333-333333333333',
          '11111111-1111-1111-1111-111111111111', 'index.html', 'hi');
  raise warning 'FAIL  bob wrote a row owned by alice';
exception when insufficient_privilege then
  raise notice 'PASS  bob cannot write rows owned by another learner';
end $$;
rollback;

-- === Anonymous visitor =====================================================
begin;
set local role anon;
select set_config('request.jwt.claim.sub', '', true);

select case when count(*) = 12 then 'PASS' else 'FAIL' end || '  anon can read the public roadmap'
from public.levels;

select case when count(*) = 0 then 'PASS' else 'FAIL' end || '  anon cannot read learner progress'
from public.user_lesson_progress;

select case when count(*) = 0 then 'PASS' else 'FAIL' end || '  anon cannot read quiz answer keys'
from public.quiz_options;

select case when count(*) = 0 then 'PASS' else 'FAIL' end || '  anon cannot read exercise pass criteria'
from public.exercise_requirements;

select case when count(*) = 0 then 'PASS' else 'FAIL' end || '  anon cannot read XP ledgers'
from public.xp_transactions;
commit;
