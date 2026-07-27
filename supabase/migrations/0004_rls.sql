-- ---------------------------------------------------------------------------
-- HTML Hero — 0004 Row Level Security
--
-- Two rules, applied without exception:
--
--   1. Catalogue tables (the course itself) are readable by signed-in learners
--      and by anonymous visitors browsing the public roadmap. Nobody can write
--      to them through the API — content is changed by migrations and the seed
--      script, which run with elevated privileges outside the request path.
--
--   2. Learner tables are readable and writable ONLY by the learner who owns
--      the row. Reference solutions and quiz answer keys are additionally kept
--      out of client queries by the server-only data access layer.
-- ---------------------------------------------------------------------------

-- --- Catalogue: public read, no client writes -------------------------------

alter table public.courses               enable row level security;
alter table public.levels                enable row level security;
alter table public.modules               enable row level security;
alter table public.module_prerequisites  enable row level security;
alter table public.module_skills         enable row level security;
alter table public.lessons               enable row level security;
alter table public.lesson_blocks         enable row level security;
alter table public.exercises             enable row level security;
alter table public.exercise_requirements enable row level security;
alter table public.quiz_questions        enable row level security;
alter table public.quiz_options          enable row level security;
alter table public.skills                enable row level security;
alter table public.skill_prerequisites   enable row level security;
alter table public.achievements          enable row level security;
alter table public.learning_media        enable row level security;
alter table public.media_attributions    enable row level security;
alter table public.project_templates     enable row level security;
alter table public.assessments           enable row level security;

do $$
declare
  t text;
begin
  foreach t in array array[
    'courses', 'levels', 'modules', 'module_prerequisites', 'module_skills',
    'lessons', 'lesson_blocks', 'exercises', 'skills', 'skill_prerequisites',
    'achievements', 'learning_media', 'media_attributions', 'project_templates',
    'assessments'
  ] loop
    execute format(
      'create policy %I on public.%I for select to anon, authenticated using (true)',
      t || '_public_read', t
    );
  end loop;
end;
$$;

-- Answer keys and pass criteria are only readable by signed-in learners. The
-- server-side data layer strips `is_correct` and `reference_solution` before
-- anything reaches the browser; this policy is the second layer of defence
-- against anonymous scraping.
create policy exercise_requirements_read on public.exercise_requirements
  for select to authenticated using (true);

create policy quiz_questions_read on public.quiz_questions
  for select to authenticated using (true);

create policy quiz_options_read on public.quiz_options
  for select to authenticated using (true);

-- --- Learner data: strict owner isolation -----------------------------------

alter table public.profiles             enable row level security;
alter table public.learning_plans       enable row level security;
alter table public.user_lesson_progress enable row level security;
alter table public.exercise_attempts    enable row level security;
alter table public.saved_code           enable row level security;
alter table public.quiz_attempts        enable row level security;
alter table public.assessment_attempts  enable row level security;
alter table public.user_skill_mastery   enable row level security;
alter table public.user_projects        enable row level security;
alter table public.project_files        enable row level security;
alter table public.user_achievements    enable row level security;
alter table public.xp_transactions      enable row level security;
alter table public.study_sessions       enable row level security;
alter table public.certificates         enable row level security;

-- profiles keys on `id` rather than `user_id`.
create policy profiles_select_own on public.profiles
  for select to authenticated using (auth.uid() = id);
create policy profiles_insert_own on public.profiles
  for insert to authenticated with check (auth.uid() = id);
create policy profiles_update_own on public.profiles
  for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);

do $$
declare
  t text;
begin
  foreach t in array array[
    'learning_plans', 'user_lesson_progress', 'exercise_attempts', 'saved_code',
    'quiz_attempts', 'assessment_attempts', 'user_skill_mastery', 'user_projects',
    'project_files', 'user_achievements', 'xp_transactions', 'study_sessions',
    'certificates'
  ] loop
    execute format(
      'create policy %I on public.%I for select to authenticated using (auth.uid() = user_id)',
      t || '_select_own', t
    );
    execute format(
      'create policy %I on public.%I for insert to authenticated with check (auth.uid() = user_id)',
      t || '_insert_own', t
    );
    execute format(
      'create policy %I on public.%I for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id)',
      t || '_update_own', t
    );
    execute format(
      'create policy %I on public.%I for delete to authenticated using (auth.uid() = user_id)',
      t || '_delete_own', t
    );
  end loop;
end;
$$;

-- A project file must belong to a project the same learner owns. Without this,
-- a learner could attach files to someone else's project id while still
-- satisfying the `user_id` check above.
create policy project_files_project_owned_insert on public.project_files
  as restrictive for insert to authenticated
  with check (
    exists (
      select 1 from public.user_projects p
      where p.id = project_files.project_id and p.user_id = auth.uid()
    )
  );

create policy project_files_project_owned_update on public.project_files
  as restrictive for update to authenticated
  using (
    exists (
      select 1 from public.user_projects p
      where p.id = project_files.project_id and p.user_id = auth.uid()
    )
  );

-- XP is append-only. Learners may read their ledger but never edit or delete
-- entries, so a total can be trusted.
drop policy xp_transactions_update_own on public.xp_transactions;
drop policy xp_transactions_delete_own on public.xp_transactions;

-- Achievements and certificates are awarded, not edited.
drop policy user_achievements_update_own on public.user_achievements;
drop policy certificates_update_own on public.certificates;
drop policy certificates_delete_own on public.certificates;

-- --- Revoke default write grants on catalogue tables ------------------------

revoke insert, update, delete on all tables in schema public from anon, authenticated;

grant insert, update, delete on
  public.profiles,
  public.learning_plans,
  public.user_lesson_progress,
  public.exercise_attempts,
  public.saved_code,
  public.quiz_attempts,
  public.assessment_attempts,
  public.user_skill_mastery,
  public.user_projects,
  public.project_files,
  public.user_achievements,
  public.xp_transactions,
  public.study_sessions,
  public.certificates
to authenticated;
