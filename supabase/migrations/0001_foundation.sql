-- ---------------------------------------------------------------------------
-- HTML Hero — 0001 foundation
--
-- Extensions, shared enum types and the `updated_at` maintenance trigger used
-- by every table in later migrations.
-- ---------------------------------------------------------------------------

create extension if not exists "pgcrypto";

-- Keeps `updated_at` honest without trusting the client to send it.
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;

-- --- Catalogue enums --------------------------------------------------------

create type public.block_type as enum (
  'objectives',      -- the learning objectives list that opens a lesson
  'prose',           -- a short explanation (kept deliberately small)
  'term',            -- "new word" card: defines jargon before it is used
  'callout',         -- tip / warning / common-mistake box
  'visual',          -- a diagram or photograph from the media library
  'code_example',    -- a correct, complete code sample
  'annotated_code',  -- a code sample with a line-by-line explanation
  'comparison',      -- side-by-side "do this / not this"
  'interactive_demo',-- a toggleable live demonstration
  'media_example',   -- an <img>/<video>/<audio> demonstration
  'progressive_detail', -- collapsed deeper technical detail
  'checklist',       -- a practical checklist
  'summary'          -- the lesson recap
);

create type public.exercise_kind as enum (
  'guided',          -- heavily scaffolded, hints on tap
  'challenge',       -- independent build from a brief
  'debug',           -- find and repair broken markup
  'project_mission', -- adds a real piece to the learner's capstone site
  'bonus'            -- optional stretch work for strong learners
);

create type public.requirement_kind as enum (
  'doctype',
  'element_present',
  'element_absent',
  'element_count',
  'unique_element',
  'attribute_present',
  'attribute_absent',
  'attribute_value',
  'attribute_matches',
  'nesting',
  'direct_child',
  'text_content',
  'text_not_empty',
  'accessible_name',
  'alt_quality',
  'label_association',
  'heading_order',
  'no_duplicate_ids',
  'no_inline_script',
  'local_media_path',
  'no_deprecated_elements',
  'valid_nesting'
);

create type public.question_kind as enum ('single', 'multi', 'true_false');

create type public.lesson_status as enum ('not_started', 'in_progress', 'completed');

create type public.mastery_state as enum (
  'untouched', 'learning', 'practising', 'proficient', 'mastered'
);

create type public.xp_source as enum (
  'lesson', 'exercise', 'quiz', 'assessment', 'achievement', 'streak', 'project', 'bonus'
);

create type public.media_kind as enum (
  'photo', 'illustration', 'icon', 'video', 'audio', 'poster', 'captions'
);

create type public.assessment_kind as enum ('milestone', 'final');

create type public.experience_level as enum ('none', 'some_html', 'other_language');
