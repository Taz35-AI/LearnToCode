-- ---------------------------------------------------------------------------
-- HTML Hero — 0006 review engine
--
-- Adds spaced repetition, retrieval practice and metacognitive calibration.
--
-- Three new tables, mirroring the split the rest of the schema already uses:
--
--   review_items   catalogue — what *can* be reviewed. Public read, no writes.
--   review_states  learner   — one FSRS card per learner per item.
--   review_logs    learner   — append-only history of every review answered.
--
-- The log is append-only for the same reason the XP ledger is: a learner who
-- can rewrite their own review history can manufacture a schedule, and the
-- schedule is the thing the whole engine is for. Correcting a mistake means
-- answering again, not editing the past.
-- ---------------------------------------------------------------------------

-- --- Enum extensions --------------------------------------------------------
--
-- New values are added here and deliberately not used until a later migration
-- or the seed: PostgreSQL will not let a value be added and referenced inside
-- the same transaction.

alter type public.block_type add value if not exists 'pretest';
alter type public.block_type add value if not exists 'recall';
alter type public.block_type add value if not exists 'predict_check';
alter type public.block_type add value if not exists 'self_explain';
alter type public.block_type add value if not exists 'worked_example';
alter type public.block_type add value if not exists 'recap';

alter type public.exercise_kind add value if not exists 'completion';

alter type public.xp_source add value if not exists 'review';

-- --- New enums --------------------------------------------------------------

create type public.review_item_kind as enum (
  'question',      -- an existing knowledge-check question, re-asked later
  'exercise',      -- a small coding task, re-attempted later
  'recall_prompt'  -- "write down everything you remember about X"
);

-- The FSRS card lifecycle. 'learning' and 'relearning' differ in what they
-- imply about the learner: the first has never been known, the second was
-- known and has been forgotten, and those are not the same memory.
create type public.review_card_state as enum (
  'new', 'learning', 'review', 'relearning'
);

-- --- Catalogue: what can be reviewed ----------------------------------------

create table public.review_items (
  id          uuid primary key default gen_random_uuid(),
  slug        text not null unique,
  kind        public.review_item_kind not null,
  skill_id    uuid not null references public.skills(id) on delete cascade,
  lesson_id   uuid references public.lessons(id) on delete cascade,

  -- Exactly one of these is set, according to `kind`.
  question_id uuid references public.quiz_questions(id) on delete cascade,
  exercise_id uuid references public.exercises(id) on delete cascade,

  -- Used by recall prompts, which have no underlying question row.
  prompt          text,
  expected_points text[] not null default '{}',

  difficulty  smallint not null default 3,
  created_at  timestamptz not null default timezone('utc', now()),
  updated_at  timestamptz not null default timezone('utc', now()),

  constraint review_item_difficulty_range check (difficulty between 1 and 5),

  -- A review item that points at nothing, or at two things, would silently
  -- disappear from sessions rather than fail loudly. Make it impossible.
  constraint review_item_target_matches_kind check (
    (kind = 'question'      and question_id is not null and exercise_id is null and prompt is null)
    or (kind = 'exercise'   and exercise_id is not null and question_id is null and prompt is null)
    or (kind = 'recall_prompt' and prompt is not null and question_id is null and exercise_id is null)
  )
);

create index review_items_skill_idx  on public.review_items (skill_id);
create index review_items_lesson_idx on public.review_items (lesson_id);

create trigger review_items_set_updated_at before update on public.review_items
  for each row execute function public.set_updated_at();

-- --- Learner: one scheduling card per item ----------------------------------

create table public.review_states (
  id             uuid primary key default gen_random_uuid(),
  user_id        uuid not null references auth.users(id) on delete cascade,
  review_item_id uuid not null references public.review_items(id) on delete cascade,

  -- Days until recall probability falls to the target. Never negative.
  stability      double precision not null default 0,
  -- 1..10 once seen; 0 while still unseen.
  difficulty     double precision not null default 0,
  reps           integer not null default 0,
  lapses         integer not null default 0,
  state          public.review_card_state not null default 'new',

  -- Dates, not timestamps: the schedule is in whole days, and storing an
  -- instant would make "due today" depend on the hour the learner studies.
  last_reviewed_on date,
  due_on           date,

  created_at     timestamptz not null default timezone('utc', now()),
  updated_at     timestamptz not null default timezone('utc', now()),

  unique (user_id, review_item_id),
  constraint review_state_stability_non_negative check (stability >= 0),
  constraint review_state_difficulty_range check (difficulty >= 0 and difficulty <= 10),
  constraint review_state_counts_non_negative check (reps >= 0 and lapses >= 0)
);

-- The query that builds every session: this learner's cards, soonest first.
create index review_states_due_idx on public.review_states (user_id, due_on);

create trigger review_states_set_updated_at before update on public.review_states
  for each row execute function public.set_updated_at();

-- --- Learner: append-only review history ------------------------------------

create table public.review_logs (
  id             uuid primary key default gen_random_uuid(),
  user_id        uuid not null references auth.users(id) on delete cascade,
  review_item_id uuid not null references public.review_items(id) on delete cascade,

  grade          smallint not null,
  -- Stated *before* the answer was revealed. Null when not asked.
  confidence     smallint,
  -- Recall probability at the moment of review — how hard it actually was.
  retrievability double precision,
  interval_days  integer not null default 0,
  reviewed_at    timestamptz not null default timezone('utc', now()),

  constraint review_log_grade_range check (grade between 1 and 4),
  constraint review_log_confidence_range check (confidence is null or confidence between 1 and 4),
  constraint review_log_interval_non_negative check (interval_days >= 0)
);

create index review_logs_user_idx on public.review_logs (user_id, reviewed_at desc);
create index review_logs_item_idx on public.review_logs (user_id, review_item_id);

-- --- Calibration on ordinary knowledge checks -------------------------------
--
-- Confidence is recorded against every answer, not only inside review
-- sessions. Calibration measured on review alone would sample only material
-- the learner has already met twice, which is the opposite of where the
-- illusion of knowing bites.

alter table public.quiz_attempts
  add column if not exists confidence smallint;

alter table public.quiz_attempts
  add constraint quiz_attempt_confidence_range
  check (confidence is null or confidence between 1 and 4);

-- --- Row Level Security -----------------------------------------------------

alter table public.review_items  enable row level security;
alter table public.review_states enable row level security;
alter table public.review_logs   enable row level security;

-- Review items carry expected answers for recall prompts, so unlike most
-- catalogue tables they are readable by signed-in learners only, never anon.
create policy review_items_read on public.review_items
  for select to authenticated using (true);

do $$
declare
  t text;
begin
  foreach t in array array['review_states', 'review_logs'] loop
    execute format(
      'create policy %I on public.%I for select to authenticated using (auth.uid() = user_id)',
      t || '_select_own', t
    );
    execute format(
      'create policy %I on public.%I for insert to authenticated with check (auth.uid() = user_id)',
      t || '_insert_own', t
    );
  end loop;
end;
$$;

-- A card is updated after every review, so states need update. Logs do not:
-- they are the evidence.
create policy review_states_update_own on public.review_states
  for update to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy review_states_delete_own on public.review_states
  for delete to authenticated using (auth.uid() = user_id);

-- No update or delete policy is created for review_logs. Under RLS the absence
-- of a policy is a denial, so the history cannot be rewritten through the API
-- even by its owner — the same guarantee the XP ledger relies on.

revoke update, delete on public.review_logs from authenticated;
revoke insert, update, delete on public.review_items from anon, authenticated;
