-- ---------------------------------------------------------------------------
-- HTML Hero — 0009 CSS requirement kinds
--
-- The evaluator until now judged HTML structure. These kinds let it judge CSS
-- the same way: by what actually *applies* to an element after the cascade has
-- been resolved, never by looking for a string in the source.
--
-- That distinction is the whole point. `margin: 0 auto` and a centring flex
-- parent both centre a box; a `.card` rule and a `:where()` token both set a
-- colour. A grader that searched for one of them would be teaching learners to
-- guess the marker rather than to write CSS, and would fail the learner who
-- chose the other correct answer.
--
-- New enum values are added here and deliberately not referenced until the
-- seed runs: PostgreSQL will not let a value be added and used inside the same
-- transaction.
-- ---------------------------------------------------------------------------

alter type public.requirement_kind add value if not exists 'css_declared';
alter type public.requirement_kind add value if not exists 'css_value';
alter type public.requirement_kind add value if not exists 'css_value_matches';
alter type public.requirement_kind add value if not exists 'css_inherited';
alter type public.requirement_kind add value if not exists 'css_property_absent';
alter type public.requirement_kind add value if not exists 'css_custom_property';
alter type public.requirement_kind add value if not exists 'css_rule_exists';
alter type public.requirement_kind add value if not exists 'css_media_rule';
alter type public.requirement_kind add value if not exists 'css_no_important';
alter type public.requirement_kind add value if not exists 'css_max_specificity';

-- The condition a CSS requirement is evaluated under: a media or container
-- query that counts as active while checking.
--
-- This is what lets one exercise ask two different questions of the same
-- stylesheet — "at a narrow viewport this is one column" and "at a wide one it
-- is three" — which is exactly the thing responsive CSS has to be examined on,
-- and which a single-state grader cannot express at all.
alter table public.exercise_requirements
  add column if not exists condition text;

comment on column public.exercise_requirements.condition is
  'Media or container query treated as active when evaluating this requirement, e.g. (min-width: 40rem). Null means the default state.';
