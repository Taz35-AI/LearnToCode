-- ---------------------------------------------------------------------------
-- HTML Hero — 0002 course catalogue
--
-- The curriculum is fully normalised: a lesson's teaching content lives in many
-- `lesson_blocks` rows, an exercise's pass criteria live in many
-- `exercise_requirements` rows, and ordering is an integer column. Authors can
-- add, reorder or reword content by editing rows — the learner interface never
-- needs to be rebuilt.
-- ---------------------------------------------------------------------------

-- --- Skills -----------------------------------------------------------------

create table public.skills (
  id           uuid primary key default gen_random_uuid(),
  slug         text not null unique,
  name         text not null,
  description  text not null,
  category     text not null,
  ordinal      integer not null,
  created_at   timestamptz not null default timezone('utc', now()),
  updated_at   timestamptz not null default timezone('utc', now())
);

create table public.skill_prerequisites (
  skill_id              uuid not null references public.skills(id) on delete cascade,
  prerequisite_skill_id uuid not null references public.skills(id) on delete cascade,
  primary key (skill_id, prerequisite_skill_id),
  constraint skill_prerequisite_not_self check (skill_id <> prerequisite_skill_id)
);

-- --- Course structure -------------------------------------------------------

create table public.courses (
  id                           uuid primary key default gen_random_uuid(),
  slug                         text not null unique,
  title                        text not null,
  subtitle                     text not null,
  description                  text not null,
  recommended_days             integer not null default 30,
  recommended_minutes_per_day  integer not null default 60,
  version                      text not null default '1.0.0',
  created_at                   timestamptz not null default timezone('utc', now()),
  updated_at                   timestamptz not null default timezone('utc', now())
);

create table public.levels (
  id          uuid primary key default gen_random_uuid(),
  course_id   uuid not null references public.courses(id) on delete cascade,
  slug        text not null,
  ordinal     integer not null,
  title       text not null,
  subtitle    text not null,
  summary     text not null,
  outcome     text not null,
  accent      text not null default 'blue',
  created_at  timestamptz not null default timezone('utc', now()),
  updated_at  timestamptz not null default timezone('utc', now()),
  unique (course_id, slug),
  unique (course_id, ordinal)
);

create table public.modules (
  id                 uuid primary key default gen_random_uuid(),
  level_id           uuid not null references public.levels(id) on delete cascade,
  slug               text not null unique,
  ordinal            integer not null,
  title              text not null,
  summary            text not null,
  estimated_minutes  integer not null default 45,
  is_milestone       boolean not null default false,
  created_at         timestamptz not null default timezone('utc', now()),
  updated_at         timestamptz not null default timezone('utc', now()),
  unique (level_id, ordinal)
);

-- A module unlocks on demonstrated mastery, never on elapsed time.
create table public.module_prerequisites (
  module_id              uuid not null references public.modules(id) on delete cascade,
  prerequisite_module_id uuid not null references public.modules(id) on delete cascade,
  primary key (module_id, prerequisite_module_id),
  constraint module_prerequisite_not_self check (module_id <> prerequisite_module_id)
);

create table public.module_skills (
  module_id        uuid not null references public.modules(id) on delete cascade,
  skill_id         uuid not null references public.skills(id) on delete cascade,
  mastery_required numeric(4, 3) not null default 0.000,
  primary key (module_id, skill_id),
  constraint module_skill_mastery_range check (mastery_required between 0 and 1)
);

create table public.lessons (
  id                  uuid primary key default gen_random_uuid(),
  module_id           uuid not null references public.modules(id) on delete cascade,
  slug                text not null unique,
  ordinal             integer not null,
  title               text not null,
  subtitle            text not null,
  summary             text not null,
  objectives          text[] not null default '{}',
  estimated_minutes   integer not null default 15,
  xp_award            integer not null default 40,
  primary_skill_id    uuid references public.skills(id) on delete set null,
  mastery_threshold   numeric(4, 3) not null default 0.700,
  created_at          timestamptz not null default timezone('utc', now()),
  updated_at          timestamptz not null default timezone('utc', now()),
  unique (module_id, ordinal),
  constraint lesson_mastery_range check (mastery_threshold between 0 and 1)
);

-- Teaching content: many small rows, never one oversized field.
create table public.lesson_blocks (
  id          uuid primary key default gen_random_uuid(),
  lesson_id   uuid not null references public.lessons(id) on delete cascade,
  ordinal     integer not null,
  block_type  public.block_type not null,
  title       text,
  body        text,
  code        text,
  language    text,
  media_slug  text,
  data        jsonb not null default '{}'::jsonb,
  created_at  timestamptz not null default timezone('utc', now()),
  updated_at  timestamptz not null default timezone('utc', now()),
  unique (lesson_id, ordinal)
);

-- --- Exercises --------------------------------------------------------------

create table public.exercises (
  id                  uuid primary key default gen_random_uuid(),
  lesson_id           uuid not null references public.lessons(id) on delete cascade,
  slug                text not null unique,
  ordinal             integer not null,
  kind                public.exercise_kind not null,
  title               text not null,
  brief               text not null,
  starter_code        text not null default '',
  reference_solution  text not null default '',
  hints               text[] not null default '{}',
  xp_award            integer not null default 30,
  difficulty          integer not null default 1,
  skill_id            uuid references public.skills(id) on delete set null,
  is_optional         boolean not null default false,
  created_at          timestamptz not null default timezone('utc', now()),
  updated_at          timestamptz not null default timezone('utc', now()),
  unique (lesson_id, ordinal),
  constraint exercise_difficulty_range check (difficulty between 1 and 5)
);

-- One row per structural rule the evaluator checks. Requirements are data, so
-- an author can tighten or relax a challenge without touching the evaluator.
create table public.exercise_requirements (
  id                uuid primary key default gen_random_uuid(),
  exercise_id       uuid not null references public.exercises(id) on delete cascade,
  ordinal           integer not null,
  kind              public.requirement_kind not null,
  selector          text,
  attribute         text,
  expected_value    text,
  ancestor_selector text,
  min_count         integer,
  max_count         integer,
  message           text not null,
  hint              text,
  weight            numeric(4, 2) not null default 1.0,
  is_critical       boolean not null default true,
  created_at        timestamptz not null default timezone('utc', now()),
  unique (exercise_id, ordinal)
);

-- --- Knowledge checks -------------------------------------------------------

create table public.assessments (
  id           uuid primary key default gen_random_uuid(),
  level_id     uuid references public.levels(id) on delete cascade,
  course_id    uuid references public.courses(id) on delete cascade,
  slug         text not null unique,
  kind         public.assessment_kind not null default 'milestone',
  title        text not null,
  description  text not null,
  pass_score   numeric(4, 3) not null default 0.750,
  xp_award     integer not null default 200,
  ordinal      integer not null default 0,
  created_at   timestamptz not null default timezone('utc', now()),
  updated_at   timestamptz not null default timezone('utc', now()),
  constraint assessment_scope check (level_id is not null or course_id is not null)
);

create table public.quiz_questions (
  id             uuid primary key default gen_random_uuid(),
  lesson_id      uuid references public.lessons(id) on delete cascade,
  assessment_id  uuid references public.assessments(id) on delete cascade,
  slug           text not null unique,
  ordinal        integer not null,
  kind           public.question_kind not null default 'single',
  prompt         text not null,
  explanation    text not null,
  skill_id       uuid references public.skills(id) on delete set null,
  xp_award       integer not null default 10,
  created_at     timestamptz not null default timezone('utc', now()),
  updated_at     timestamptz not null default timezone('utc', now()),
  constraint question_scope check (
    (lesson_id is not null and assessment_id is null)
    or (lesson_id is null and assessment_id is not null)
  )
);

create table public.quiz_options (
  id           uuid primary key default gen_random_uuid(),
  question_id  uuid not null references public.quiz_questions(id) on delete cascade,
  ordinal      integer not null,
  label        text not null,
  is_correct   boolean not null default false,
  feedback     text,
  unique (question_id, ordinal)
);

-- --- Media library ----------------------------------------------------------

create table public.learning_media (
  id             uuid primary key default gen_random_uuid(),
  slug           text not null unique,
  kind           public.media_kind not null,
  title          text not null,
  description    text not null,
  path           text not null,
  width          integer,
  height         integer,
  duration_secs  numeric(8, 2),
  srcset         jsonb not null default '[]'::jsonb,
  formats        jsonb not null default '[]'::jsonb,
  poster_path    text,
  captions_path  text,
  suggested_alt  text not null default '',
  is_decorative_example boolean not null default false,
  tags           text[] not null default '{}',
  created_at     timestamptz not null default timezone('utc', now()),
  updated_at     timestamptz not null default timezone('utc', now())
);

-- Provenance for every asset, shown on the in-app /media attribution page.
create table public.media_attributions (
  id                uuid primary key default gen_random_uuid(),
  media_id          uuid not null references public.learning_media(id) on delete cascade,
  asset_title       text not null,
  creator           text,
  source            text not null,
  source_url        text,
  licence           text not null,
  licence_url       text,
  attribution_text  text not null,
  local_path        text not null,
  retrieved_on      date not null,
  notes             text,
  created_at        timestamptz not null default timezone('utc', now()),
  unique (media_id)
);

-- --- Projects and achievements ---------------------------------------------

create table public.project_templates (
  id               uuid primary key default gen_random_uuid(),
  slug             text not null unique,
  name             text not null,
  tagline          text not null,
  description      text not null,
  audience         text not null,
  hero_media_slug  text,
  page_plan        jsonb not null default '[]'::jsonb,
  ordinal          integer not null default 0,
  created_at       timestamptz not null default timezone('utc', now()),
  updated_at       timestamptz not null default timezone('utc', now())
);

create table public.achievements (
  id           uuid primary key default gen_random_uuid(),
  slug         text not null unique,
  name         text not null,
  description  text not null,
  icon         text not null default 'star',
  tier         text not null default 'bronze',
  criteria     jsonb not null default '{}'::jsonb,
  xp_award     integer not null default 50,
  ordinal      integer not null default 0,
  created_at   timestamptz not null default timezone('utc', now()),
  updated_at   timestamptz not null default timezone('utc', now())
);

-- --- Indexes ----------------------------------------------------------------

create index levels_course_ordinal_idx on public.levels (course_id, ordinal);
create index modules_level_ordinal_idx on public.modules (level_id, ordinal);
create index lessons_module_ordinal_idx on public.lessons (module_id, ordinal);
create index lessons_primary_skill_idx on public.lessons (primary_skill_id);
create index lesson_blocks_lesson_idx on public.lesson_blocks (lesson_id, ordinal);
create index exercises_lesson_idx on public.exercises (lesson_id, ordinal);
create index exercises_skill_idx on public.exercises (skill_id);
create index exercise_requirements_exercise_idx on public.exercise_requirements (exercise_id, ordinal);
create index quiz_questions_lesson_idx on public.quiz_questions (lesson_id, ordinal);
create index quiz_questions_assessment_idx on public.quiz_questions (assessment_id, ordinal);
create index quiz_options_question_idx on public.quiz_options (question_id, ordinal);
create index learning_media_kind_idx on public.learning_media (kind);
create index learning_media_tags_idx on public.learning_media using gin (tags);
create index assessments_level_idx on public.assessments (level_id, ordinal);
create index module_skills_skill_idx on public.module_skills (skill_id);

-- --- updated_at triggers ----------------------------------------------------

create trigger skills_set_updated_at before update on public.skills
  for each row execute function public.set_updated_at();
create trigger courses_set_updated_at before update on public.courses
  for each row execute function public.set_updated_at();
create trigger levels_set_updated_at before update on public.levels
  for each row execute function public.set_updated_at();
create trigger modules_set_updated_at before update on public.modules
  for each row execute function public.set_updated_at();
create trigger lessons_set_updated_at before update on public.lessons
  for each row execute function public.set_updated_at();
create trigger lesson_blocks_set_updated_at before update on public.lesson_blocks
  for each row execute function public.set_updated_at();
create trigger exercises_set_updated_at before update on public.exercises
  for each row execute function public.set_updated_at();
create trigger assessments_set_updated_at before update on public.assessments
  for each row execute function public.set_updated_at();
create trigger quiz_questions_set_updated_at before update on public.quiz_questions
  for each row execute function public.set_updated_at();
create trigger learning_media_set_updated_at before update on public.learning_media
  for each row execute function public.set_updated_at();
create trigger project_templates_set_updated_at before update on public.project_templates
  for each row execute function public.set_updated_at();
create trigger achievements_set_updated_at before update on public.achievements
  for each row execute function public.set_updated_at();
