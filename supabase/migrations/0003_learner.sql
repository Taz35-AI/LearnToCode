-- ---------------------------------------------------------------------------
-- HTML Hero — 0003 learner-owned data
--
-- Every table here carries a `user_id` that references auth.users. Migration
-- 0004 locks each one down with Row Level Security so a learner can only ever
-- read or write their own rows.
-- ---------------------------------------------------------------------------

create table public.profiles (
  id                    uuid primary key references auth.users(id) on delete cascade,
  display_name          text not null default 'Learner',
  avatar_url            text,
  theme                 text not null default 'system',
  reduced_motion        boolean not null default false,
  timezone              text not null default 'UTC',
  onboarding_completed_at timestamptz,
  last_active_at        timestamptz,
  created_at            timestamptz not null default timezone('utc', now()),
  updated_at            timestamptz not null default timezone('utc', now()),
  constraint profiles_theme_valid check (theme in ('system', 'light', 'dark')),
  constraint profiles_display_name_length check (char_length(display_name) between 1 and 60)
);

-- The personalised schedule produced during onboarding. Recomputed pace values
-- are stored so the dashboard can show recommended vs. actual without
-- recalculating history on every request.
create table public.learning_plans (
  id                        uuid primary key default gen_random_uuid(),
  user_id                   uuid not null references auth.users(id) on delete cascade,
  course_id                 uuid not null references public.courses(id) on delete cascade,
  minutes_per_day           integer not null default 60,
  study_days                integer[] not null default '{1,2,3,4,5}',
  target_completion_date    date,
  experience                public.experience_level not null default 'none',
  project_template_id       uuid references public.project_templates(id) on delete set null,
  recommended_lessons_per_week numeric(6, 2) not null default 0,
  estimated_completion_date date,
  started_on                date not null default (timezone('utc', now()))::date,
  is_active                 boolean not null default true,
  created_at                timestamptz not null default timezone('utc', now()),
  updated_at                timestamptz not null default timezone('utc', now()),
  constraint learning_plan_minutes_range check (minutes_per_day between 10 and 480),
  constraint learning_plan_days_present check (array_length(study_days, 1) between 1 and 7)
);

create unique index learning_plans_one_active_per_user
  on public.learning_plans (user_id, course_id) where is_active;

create table public.user_lesson_progress (
  id                  uuid primary key default gen_random_uuid(),
  user_id             uuid not null references auth.users(id) on delete cascade,
  lesson_id           uuid not null references public.lessons(id) on delete cascade,
  status              public.lesson_status not null default 'not_started',
  started_at          timestamptz,
  completed_at        timestamptz,
  time_spent_seconds  integer not null default 0,
  visits              integer not null default 0,
  best_score          numeric(4, 3),
  created_at          timestamptz not null default timezone('utc', now()),
  updated_at          timestamptz not null default timezone('utc', now()),
  unique (user_id, lesson_id)
);

create table public.exercise_attempts (
  id                uuid primary key default gen_random_uuid(),
  user_id           uuid not null references auth.users(id) on delete cascade,
  exercise_id       uuid not null references public.exercises(id) on delete cascade,
  submitted_code    text not null,
  passed            boolean not null default false,
  score             numeric(4, 3) not null default 0,
  results           jsonb not null default '[]'::jsonb,
  hints_used        integer not null default 0,
  duration_seconds  integer not null default 0,
  created_at        timestamptz not null default timezone('utc', now())
);

-- Autosaved working code, one row per learner per exercise.
create table public.saved_code (
  id           uuid primary key default gen_random_uuid(),
  user_id      uuid not null references auth.users(id) on delete cascade,
  exercise_id  uuid not null references public.exercises(id) on delete cascade,
  code         text not null default '',
  hints_used   integer not null default 0,
  created_at   timestamptz not null default timezone('utc', now()),
  updated_at   timestamptz not null default timezone('utc', now()),
  unique (user_id, exercise_id)
);

create table public.quiz_attempts (
  id                  uuid primary key default gen_random_uuid(),
  user_id             uuid not null references auth.users(id) on delete cascade,
  question_id         uuid not null references public.quiz_questions(id) on delete cascade,
  selected_option_ids uuid[] not null default '{}',
  is_correct          boolean not null default false,
  answered_at         timestamptz not null default timezone('utc', now())
);

create table public.assessment_attempts (
  id             uuid primary key default gen_random_uuid(),
  user_id        uuid not null references auth.users(id) on delete cascade,
  assessment_id  uuid not null references public.assessments(id) on delete cascade,
  score          numeric(4, 3) not null default 0,
  passed         boolean not null default false,
  detail         jsonb not null default '{}'::jsonb,
  created_at     timestamptz not null default timezone('utc', now())
);

create table public.user_skill_mastery (
  id                uuid primary key default gen_random_uuid(),
  user_id           uuid not null references auth.users(id) on delete cascade,
  skill_id          uuid not null references public.skills(id) on delete cascade,
  mastery           numeric(4, 3) not null default 0,
  state             public.mastery_state not null default 'untouched',
  evidence_count    integer not null default 0,
  correct_count     integer not null default 0,
  needs_practice    boolean not null default false,
  last_practised_at timestamptz,
  created_at        timestamptz not null default timezone('utc', now()),
  updated_at        timestamptz not null default timezone('utc', now()),
  unique (user_id, skill_id),
  constraint mastery_range check (mastery between 0 and 1)
);

create table public.user_projects (
  id                   uuid primary key default gen_random_uuid(),
  user_id              uuid not null references auth.users(id) on delete cascade,
  project_template_id  uuid references public.project_templates(id) on delete set null,
  name                 text not null,
  description          text not null default '',
  status               text not null default 'in_progress',
  completion_percent   integer not null default 0,
  created_at           timestamptz not null default timezone('utc', now()),
  updated_at           timestamptz not null default timezone('utc', now()),
  constraint project_status_valid check (status in ('in_progress', 'review', 'complete')),
  constraint project_completion_range check (completion_percent between 0 and 100)
);

create unique index user_projects_one_active_per_user on public.user_projects (user_id)
  where status <> 'complete';

create table public.project_files (
  id           uuid primary key default gen_random_uuid(),
  project_id   uuid not null references public.user_projects(id) on delete cascade,
  user_id      uuid not null references auth.users(id) on delete cascade,
  path         text not null,
  content      text not null default '',
  kind         text not null default 'html',
  mission_slug text,
  created_at   timestamptz not null default timezone('utc', now()),
  updated_at   timestamptz not null default timezone('utc', now()),
  unique (project_id, path),
  constraint project_file_path_shape check (path ~ '^[a-z0-9][a-z0-9._/-]*$')
);

create table public.user_achievements (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references auth.users(id) on delete cascade,
  achievement_id  uuid not null references public.achievements(id) on delete cascade,
  unlocked_at     timestamptz not null default timezone('utc', now()),
  unique (user_id, achievement_id)
);

-- The UNIQUE constraint below is the duplicate-XP guarantee: re-submitting an
-- already-passed exercise can never award XP a second time, because the
-- database itself rejects the second row.
create table public.xp_transactions (
  id           uuid primary key default gen_random_uuid(),
  user_id      uuid not null references auth.users(id) on delete cascade,
  amount       integer not null,
  source_type  public.xp_source not null,
  source_id    text not null,
  reason       text not null,
  created_at   timestamptz not null default timezone('utc', now()),
  unique (user_id, source_type, source_id),
  constraint xp_amount_positive check (amount > 0)
);

-- One row per learner per calendar day: cheap streak maths, cheap pace maths.
create table public.study_sessions (
  id                 uuid primary key default gen_random_uuid(),
  user_id            uuid not null references auth.users(id) on delete cascade,
  study_date         date not null,
  seconds            integer not null default 0,
  lessons_completed  integer not null default 0,
  exercises_passed   integer not null default 0,
  xp_earned          integer not null default 0,
  created_at         timestamptz not null default timezone('utc', now()),
  updated_at         timestamptz not null default timezone('utc', now()),
  unique (user_id, study_date)
);

create table public.certificates (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null references auth.users(id) on delete cascade,
  course_id     uuid not null references public.courses(id) on delete cascade,
  serial        text not null unique,
  recipient_name text not null,
  score         numeric(4, 3) not null default 0,
  skills_mastered integer not null default 0,
  issued_at     timestamptz not null default timezone('utc', now()),
  unique (user_id, course_id)
);

-- --- Indexes ----------------------------------------------------------------

create index user_lesson_progress_user_idx on public.user_lesson_progress (user_id, status);
create index user_lesson_progress_completed_idx on public.user_lesson_progress (user_id, completed_at desc);
create index exercise_attempts_user_idx on public.exercise_attempts (user_id, exercise_id, created_at desc);
create index exercise_attempts_recent_idx on public.exercise_attempts (user_id, created_at desc);
create index quiz_attempts_user_idx on public.quiz_attempts (user_id, question_id, answered_at desc);
create index user_skill_mastery_user_idx on public.user_skill_mastery (user_id, state);
create index xp_transactions_user_idx on public.xp_transactions (user_id, created_at desc);
create index study_sessions_user_date_idx on public.study_sessions (user_id, study_date desc);
create index project_files_project_idx on public.project_files (project_id, path);
create index user_achievements_user_idx on public.user_achievements (user_id, unlocked_at desc);
create index assessment_attempts_user_idx on public.assessment_attempts (user_id, assessment_id, created_at desc);

-- --- updated_at triggers ----------------------------------------------------

create trigger profiles_set_updated_at before update on public.profiles
  for each row execute function public.set_updated_at();
create trigger learning_plans_set_updated_at before update on public.learning_plans
  for each row execute function public.set_updated_at();
create trigger user_lesson_progress_set_updated_at before update on public.user_lesson_progress
  for each row execute function public.set_updated_at();
create trigger saved_code_set_updated_at before update on public.saved_code
  for each row execute function public.set_updated_at();
create trigger user_skill_mastery_set_updated_at before update on public.user_skill_mastery
  for each row execute function public.set_updated_at();
create trigger user_projects_set_updated_at before update on public.user_projects
  for each row execute function public.set_updated_at();
create trigger project_files_set_updated_at before update on public.project_files
  for each row execute function public.set_updated_at();
create trigger study_sessions_set_updated_at before update on public.study_sessions
  for each row execute function public.set_updated_at();

-- --- New-user bootstrap -----------------------------------------------------

-- Creates the profile row the moment Supabase Auth creates the user, so the
-- application never has to deal with a signed-in user that has no profile.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, display_name)
  values (
    new.id,
    coalesce(
      nullif(trim(new.raw_user_meta_data ->> 'display_name'), ''),
      split_part(coalesce(new.email, 'Learner'), '@', 1)
    )
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
