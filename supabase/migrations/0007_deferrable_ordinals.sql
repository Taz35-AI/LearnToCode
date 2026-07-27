-- ---------------------------------------------------------------------------
-- HTML Hero — 0007 deferrable ordering constraints
--
-- Content is now updated in place rather than deleted and rebuilt, so that a
-- re-seed cannot destroy learner progress. That change exposes a second
-- problem: reordering.
--
-- Each level, module, lesson and exercise is unique on (parent, ordinal). When
-- a lesson is inserted between two existing ones, the seed renumbers the ones
-- after it — and part-way through that renumbering two rows briefly share an
-- ordinal. Checked per statement, that is a violation and the whole re-seed
-- fails; checked at commit, the final state is perfectly consistent.
--
-- Making these constraints deferrable moves the check to commit time. The seed
-- already runs inside a single transaction, so the intermediate states are
-- never visible to anything else.
-- ---------------------------------------------------------------------------

alter table public.levels    drop constraint if exists levels_course_id_ordinal_key;
alter table public.modules   drop constraint if exists modules_level_id_ordinal_key;
alter table public.lessons   drop constraint if exists lessons_module_id_ordinal_key;
alter table public.exercises drop constraint if exists exercises_lesson_id_ordinal_key;

alter table public.levels
  add constraint levels_course_id_ordinal_key
  unique (course_id, ordinal) deferrable initially deferred;

alter table public.modules
  add constraint modules_level_id_ordinal_key
  unique (level_id, ordinal) deferrable initially deferred;

alter table public.lessons
  add constraint lessons_module_id_ordinal_key
  unique (module_id, ordinal) deferrable initially deferred;

alter table public.exercises
  add constraint exercises_lesson_id_ordinal_key
  unique (lesson_id, ordinal) deferrable initially deferred;
