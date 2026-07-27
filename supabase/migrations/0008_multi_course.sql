-- ---------------------------------------------------------------------------
-- HTML Hero — 0008 multi-course programme
--
-- Turns a one-course application into a programme of courses: HTML, then CSS,
-- then JavaScript.
--
-- Most of the work was already done. `levels`, `assessments`, `learning_plans`
-- and `certificates` all carry a `course_id` and always have. What was missing
-- is everything *about* a course as a unit:
--
--   · its position in the programme, so an order exists in data rather than in
--     a hard-coded slug somewhere in the data layer;
--   · what must be finished before it opens;
--   · whether it is ready to be shown to a learner at all.
--
-- Nothing here drops or rewrites a row. Every column is added with a default
-- that leaves the existing HTML course exactly where it was, which is the same
-- rule the seed follows: a learner's progress hangs off this catalogue by
-- foreign key, and a migration that rebuilds catalogue rows deletes progress.
-- ---------------------------------------------------------------------------

-- --- Courses become an ordered, gated set -----------------------------------

alter table public.courses
  add column if not exists ordinal integer not null default 1;

-- Matches `levels.accent`, so a course can carry its own visual identity
-- through the roadmap without the interface special-casing which one it is.
alter table public.courses
  add column if not exists accent text not null default 'blue';

-- A course under construction is present in the catalogue and invisible to
-- learners. This is what allows CSS content to be seeded and reviewed
-- incrementally without appearing half-finished on the roadmap — the
-- alternative being a long-lived branch, which is worse.
alter table public.courses
  add column if not exists is_published boolean not null default true;

-- A short sentence naming what the learner can do at the end, mirroring
-- `levels.outcome`. Defaulted empty rather than null so every read is total.
alter table public.courses
  add column if not exists outcome text not null default '';

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'courses_ordinal_positive'
  ) then
    alter table public.courses
      add constraint courses_ordinal_positive check (ordinal >= 1);
  end if;
end;
$$;

-- Deferrable, for the same reason as 0007: reordering courses in one
-- transaction transiently duplicates an ordinal, and a per-statement check
-- would reject a correct final state.
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'courses_ordinal_key'
  ) then
    alter table public.courses
      add constraint courses_ordinal_key unique (ordinal) deferrable initially deferred;
  end if;
end;
$$;

-- --- Cross-course prerequisites ---------------------------------------------
--
-- Deliberately a separate table rather than a column, exactly as
-- `module_prerequisites` is: a course may rest on more than one, and CSS and
-- JavaScript will both eventually require HTML.

create table if not exists public.course_prerequisites (
  course_id              uuid not null references public.courses(id) on delete cascade,
  prerequisite_course_id uuid not null references public.courses(id) on delete cascade,
  primary key (course_id, prerequisite_course_id),

  -- A course cannot require itself. Longer cycles are caught by the seed
  -- generator, which can see the whole graph; this catches the trivial case at
  -- the point of insertion.
  constraint course_prerequisite_not_self check (course_id <> prerequisite_course_id)
);

create index if not exists course_prerequisites_course_idx
  on public.course_prerequisites (course_id);

-- --- Row Level Security -----------------------------------------------------
--
-- Catalogue data: readable by anyone, writable by nobody through the API.
-- Matches `module_prerequisites` exactly.

alter table public.course_prerequisites enable row level security;

do $$
begin
  if not exists (
    select 1 from pg_policies
    where tablename = 'course_prerequisites' and policyname = 'course_prerequisites_read'
  ) then
    create policy course_prerequisites_read on public.course_prerequisites
      for select to anon, authenticated using (true);
  end if;
end;
$$;

revoke insert, update, delete on public.course_prerequisites from anon, authenticated;

-- --- Position the existing course -------------------------------------------
--
-- The HTML course is first and has no prerequisites. Stated explicitly rather
-- than left to the column default, so the intent survives someone changing
-- that default later.

update public.courses
set ordinal = 1,
    accent = 'blue',
    is_published = true,
    outcome = coalesce(nullif(outcome, ''),
      'You can build, validate, improve, export and publish a professional multi-page website in modern HTML.')
where slug = 'html-hero';
