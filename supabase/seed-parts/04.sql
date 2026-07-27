-- HTML Hero — course seed, part 4 of 9
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 3 first.

begin;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'No alt text is a filename, a placeholder, or starts with "image of"', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'alt-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'alt-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'img[alt=""]', NULL,
       NULL, NULL, 1, 1,
       'Exactly one image is marked decorative with alt=""', NULL, 1, true
from public.exercises e where e.slug = 'alt-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'figure-challenge', 2, 'challenge'::public.exercise_kind, 'A figure with a caption',
       'Build a `<figure>` containing an image from the media library, with descriptive alt text and dimensions, plus a `<figcaption>` that says something the alt text does not — for example, where or when it was taken.', '', '<figure>
  <img src="/learning-media/images/forest-path.jpg"
       alt="A sandy path winding between tall trees in a sunlit forest"
       width="1200" height="800">
  <figcaption>
    The northern approach to the reservoir, halfway along the valley route.
  </figcaption>
</figure>', ARRAY['The <figure> wraps both the image and the caption.', 'The <figcaption> can come before or after the image, but must be inside the figure.', 'Make the caption add context rather than repeating the alt text word for word.']::text[],
       45, 2,
       (select id from public.skills where slug = 'images'), false
from public.lessons l where l.slug = 'writing-alt-text'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'figure', NULL,
       NULL, NULL, NULL, NULL,
       'There is a figure', NULL, 1, true
from public.exercises e where e.slug = 'figure-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'nesting'::public.requirement_kind, 'img', NULL,
       NULL, 'figure', 1, NULL,
       'The image is inside the figure', NULL, 1, true
from public.exercises e where e.slug = 'figure-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'nesting'::public.requirement_kind, 'figcaption', NULL,
       NULL, 'figure', 1, NULL,
       'The caption is inside the figure', NULL, 1, true
from public.exercises e where e.slug = 'figure-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'text_not_empty'::public.requirement_kind, 'figcaption', NULL,
       NULL, NULL, NULL, NULL,
       'The caption has text', NULL, 1, true
from public.exercises e where e.slug = 'figure-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'The image has meaningful alt text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'figure-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'attribute_present'::public.requirement_kind, 'img', 'width',
       NULL, NULL, NULL, NULL,
       'The image declares its dimensions', NULL, 1, true
from public.exercises e where e.slug = 'figure-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'figure-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'figure-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'writing-alt-text'), NULL, 'q-empty-alt', 1, 'single'::public.question_kind,
        'When is `alt=""` the correct choice?', 'When the image is purely decorative and adds no information, so a screen reader should skip it entirely.', (select id from public.skills where slug = 'images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'When you have not decided what to write yet', false, NULL
from public.quiz_questions where slug = 'q-empty-alt';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'When the image is very small', false, NULL
from public.quiz_questions where slug = 'q-empty-alt';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Never — alt must always have text', false, NULL
from public.quiz_questions where slug = 'q-empty-alt';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'When the image is decorative and carries no information', true, NULL
from public.quiz_questions where slug = 'q-empty-alt';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'writing-alt-text'), NULL, 'q-alt-vs-caption', 2, 'single'::public.question_kind,
        'How do alt text and a `<figcaption>` differ?', 'A caption is visible to everyone and adds context; alt text replaces the image for people who cannot see it.', (select id from public.skills where slug = 'images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A caption is only for photographs', false, NULL
from public.quiz_questions where slug = 'q-alt-vs-caption';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Alt text is shown on hover; captions are always visible', false, NULL
from public.quiz_questions where slug = 'q-alt-vs-caption';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A caption is for everyone; alt text replaces the image for those who cannot see it', true, NULL
from public.quiz_questions where slug = 'q-alt-vs-caption';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'They are the same and should be identical', false, NULL
from public.quiz_questions where slug = 'q-alt-vs-caption';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'writing-alt-text'), NULL, 'q-missing-alt', 3, 'single'::public.question_kind,
        'What happens if you omit the `alt` attribute entirely?', 'Screen readers commonly fall back to reading the filename aloud, which is worse than useless.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It behaves the same as alt=""', false, NULL
from public.quiz_questions where slug = 'q-missing-alt';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The browser generates a description automatically', false, NULL
from public.quiz_questions where slug = 'q-missing-alt';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Screen readers may read the filename aloud', true, NULL
from public.quiz_questions where slug = 'q-missing-alt';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The image will not load', false, NULL
from public.quiz_questions where slug = 'q-missing-alt';
-- module: Responsive images
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'responsive-images', 2, 'Responsive images', 'srcset, sizes, picture and modern formats — how one image element serves a phone and a large monitor well.',
       45, false
from public.levels l where l.slug = 'media-specialist'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'responsive-images' and p.slug = 'images-and-alt-text';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'responsive-images' and s.slug = 'responsive-images';
-- lesson: srcset and sizes
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'srcset-and-sizes', 1, 'srcset and sizes', 'Let the browser choose the right file', 'Sending a 1600-pixel photograph to a phone wastes most of the bytes. srcset offers the browser a choice.',
       ARRAY['Offer several image widths with srcset', 'Describe the display width with sizes', 'Explain why the browser, not you, makes the final choice']::text[], 15, 40, (select id from public.skills where slug = 'responsive-images'), 0.7
from public.modules m where m.slug = 'responsive-images'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Write a srcset with width descriptors","Write a sizes attribute that matches your layout","Explain what the browser considers when choosing"]}'::jsonb
from public.lessons where slug = 'srcset-and-sizes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'visual'::public.block_type, NULL, 'One image, offered at several widths. The browser picks.',
       NULL, NULL, 'responsive-images', '{}'::jsonb
from public.lessons where slug = 'srcset-and-sizes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'A photograph that looks sharp on a 27-inch monitor is roughly ten times more data than a phone needs. `srcset` lets you offer the same picture at several sizes and lets the browser download only the one it needs.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'srcset-and-sizes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<img
  src="/learning-media/images/coast-sunrise-800.jpg"
  srcset="/learning-media/images/coast-sunrise-480.jpg   480w,
          /learning-media/images/coast-sunrise-800.jpg   800w,
          /learning-media/images/coast-sunrise-1200.jpg 1200w,
          /learning-media/images/coast-sunrise-1600.jpg 1600w"
  sizes="(min-width: 60rem) 50vw, 100vw"
  alt="Sunrise over a calm sea, with low headlands against an orange sky"
  width="1200" height="800">', 'html', NULL, '{"annotations":[{"line":"2","text":"`src` is the fallback. Any browser that does not understand `srcset` uses this, so the image always appears."},{"line":"3-6","text":"`srcset` lists the candidates. `480w` means \"this file is 480 pixels wide\" — a description of the file, not an instruction."},{"line":"7","text":"`sizes` tells the browser how wide the image will *display*. Here: on screens at least 60rem wide it fills half the viewport; otherwise the full width."},{"line":"9","text":"`width` and `height` still come from one representative file, and give the browser the aspect ratio."}]}'::jsonb
from public.lessons where slug = 'srcset-and-sizes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Why does the browser need `sizes`?', 'The browser starts downloading images before it has finished working out the page layout — that is what makes pages feel fast. At that moment it does not yet know how wide your image will be on screen, so you have to tell it. Omit `sizes` and it assumes the image fills the whole viewport width, which usually means it downloads a file that is far too large.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'srcset-and-sizes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'prose'::public.block_type, NULL, 'The browser then combines your `sizes` value with the device''s screen density and the user''s current connection to choose a file. On a high-density phone screen it may pick a wider file than the raw pixel width suggests. You cannot control the outcome, and that is deliberate: the browser knows things you do not.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'srcset-and-sizes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'progressive_detail'::public.block_type, 'The other kind of srcset: pixel density', 'For images with a fixed display size — a logo, an avatar — use density descriptors instead: `srcset="logo.png 1x, logo@2x.png 2x"`. The browser picks based on screen density alone, and no `sizes` attribute is needed. Use `w` descriptors when the image scales with the layout, and `x` descriptors when it does not.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'srcset-and-sizes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'callout'::public.block_type, 'The media library already has the sizes', 'Every photograph in the HTML Hero media library is generated at 480, 800, 1200 and 1600 pixels wide. The media picker in the editor can insert a complete, correct `srcset` for you — use it while you are learning the pattern, then write one by hand to prove you can.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'srcset-and-sizes';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`srcset` offers candidate files with `w` descriptors giving each file''s real width.","`sizes` tells the browser how wide the image will display, before layout is known.","`src` remains as the fallback for browsers that do not understand `srcset`.","The browser makes the final choice, using information you do not have."],"nextUp":"Next: art direction and modern formats with `<picture>`."}'::jsonb
from public.lessons where slug = 'srcset-and-sizes';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'srcset-guided', 1, 'guided'::public.exercise_kind, 'Add a srcset',
       'This image only offers one size. Add a `srcset` listing the 480, 800, 1200 and 1600 pixel versions with correct `w` descriptors, and a `sizes` value of `(min-width: 60rem) 50vw, 100vw`.', '<img
  src="/learning-media/images/forest-path-800.jpg"
  alt="A sandy path winding between tall trees in a sunlit forest"
  width="1200" height="800">', '<img
  src="/learning-media/images/forest-path-800.jpg"
  srcset="/learning-media/images/forest-path-480.jpg   480w,
          /learning-media/images/forest-path-800.jpg   800w,
          /learning-media/images/forest-path-1200.jpg 1200w,
          /learning-media/images/forest-path-1600.jpg 1600w"
  sizes="(min-width: 60rem) 50vw, 100vw"
  alt="A sandy path winding between tall trees in a sunlit forest"
  width="1200" height="800">', ARRAY['Each entry in srcset is a path, a space, then the width followed by the letter w.', 'Separate the entries with commas.', 'The filenames follow the pattern forest-path-480.jpg, forest-path-800.jpg, and so on.']::text[],
       50, 3,
       (select id from public.skills where slug = 'responsive-images'), false
from public.lessons l where l.slug = 'srcset-and-sizes'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'img', 'srcset',
       NULL, NULL, NULL, NULL,
       'The image has a srcset', NULL, 1, true
from public.exercises e where e.slug = 'srcset-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_matches'::public.requirement_kind, 'img', 'srcset',
       '480w', NULL, NULL, NULL,
       'The srcset offers the 480 pixel version', NULL, 1, true
from public.exercises e where e.slug = 'srcset-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_matches'::public.requirement_kind, 'img', 'srcset',
       '1600w', NULL, NULL, NULL,
       'The srcset offers the 1600 pixel version', NULL, 1, true
from public.exercises e where e.slug = 'srcset-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'img', 'sizes',
       NULL, NULL, NULL, NULL,
       'The image has a sizes attribute', NULL, 1, true
from public.exercises e where e.slug = 'srcset-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_present'::public.requirement_kind, 'img', 'src',
       NULL, NULL, NULL, NULL,
       'A fallback src remains', NULL, 1, true
from public.exercises e where e.slug = 'srcset-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'srcset-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every image has meaningful alternative text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'srcset-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'srcset-debug', 2, 'debug'::public.exercise_kind, 'A srcset that downloads the wrong file',
       'This srcset uses `px` instead of `w`, has no `sizes`, and one of its paths does not exist. Fix all three problems.', '<img
  src="/learning-media/images/city-dusk-800.jpg"
  srcset="/learning-media/images/city-dusk-480.jpg 480px,
          /learning-media/images/city-dusk-900.jpg 900px,
          /learning-media/images/city-dusk-1600.jpg 1600px"
  alt="A city skyline at dusk with hundreds of lit office windows"
  width="1200" height="800">', '<img
  src="/learning-media/images/city-dusk-800.jpg"
  srcset="/learning-media/images/city-dusk-480.jpg   480w,
          /learning-media/images/city-dusk-800.jpg   800w,
          /learning-media/images/city-dusk-1600.jpg 1600w"
  sizes="(min-width: 60rem) 50vw, 100vw"
  alt="A city skyline at dusk with hundreds of lit office windows"
  width="1200" height="800">', ARRAY['A width descriptor is the number followed by the letter w — never px.', 'There is no 900-pixel version. The library provides 480, 800, 1200 and 1600.', 'Add a sizes attribute so the browser knows how wide the image will display.']::text[],
       55, 4,
       (select id from public.skills where slug = 'responsive-images'), false
from public.lessons l where l.slug = 'srcset-and-sizes'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_matches'::public.requirement_kind, 'img', 'srcset',
       '\d+w', NULL, NULL, NULL,
       'The srcset uses w descriptors', NULL, 1, true
from public.exercises e where e.slug = 'srcset-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_absent'::public.requirement_kind, 'img[srcset*="px"]', 'srcset',
       NULL, NULL, NULL, NULL,
       'No px units in the srcset', NULL, 1, true
from public.exercises e where e.slug = 'srcset-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'img', 'sizes',
       NULL, NULL, NULL, NULL,
       'A sizes attribute is present', NULL, 1, true
from public.exercises e where e.slug = 'srcset-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'srcset-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'srcset-and-sizes'), NULL, 'q-srcset-w', 1, 'single'::public.question_kind,
        'What does `800w` in a srcset mean?', 'It describes the file: this image file is 800 pixels wide. It is not an instruction about display size.', (select id from public.skills where slug = 'responsive-images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'This file is 800 pixels wide', true, NULL
from public.quiz_questions where slug = 'q-srcset-w';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Display this image at 800 pixels', false, NULL
from public.quiz_questions where slug = 'q-srcset-w';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Use this file on screens wider than 800 pixels', false, NULL
from public.quiz_questions where slug = 'q-srcset-w';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The file is 800 kilobytes', false, NULL
from public.quiz_questions where slug = 'q-srcset-w';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'srcset-and-sizes'), NULL, 'q-sizes-purpose', 2, 'single'::public.question_kind,
        'Why is a `sizes` attribute needed?', 'The browser starts choosing an image before layout is complete, so it needs you to describe how wide the image will be.', (select id from public.skills where slug = 'responsive-images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'To validate the srcset', false, NULL
from public.quiz_questions where slug = 'q-sizes-purpose';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The browser chooses an image before it knows the layout', true, NULL
from public.quiz_questions where slug = 'q-sizes-purpose';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'To set the CSS width of the image', false, NULL
from public.quiz_questions where slug = 'q-sizes-purpose';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'To tell the server which file to send', false, NULL
from public.quiz_questions where slug = 'q-sizes-purpose';
-- lesson: The picture element, art direction and lazy loading
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'picture-and-formats', 2, 'The picture element, art direction and lazy loading', 'When you need a different crop, a newer format, or a later download', '`<picture>` gives you control that `srcset` alone cannot: different images entirely, and modern formats with a safe fallback.',
       ARRAY['Use `<picture>` to offer modern formats with a fallback', 'Use art direction to change the crop at different screen sizes', 'Apply lazy loading and fetch priority sensibly']::text[], 15, 40, (select id from public.skills where slug = 'responsive-images'), 0.7
from public.modules m where m.slug = 'responsive-images'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Offer WebP with a JPEG fallback using <picture>","Serve a different crop on small screens","Decide which images should be lazy-loaded and which should not"]}'::jsonb
from public.lessons where slug = 'picture-and-formats';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, '`srcset` chooses between different sizes of the same image. `<picture>` chooses between genuinely different files — a different format, or a different crop.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'picture-and-formats';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<picture>
  <source
    type="image/webp"
    srcset="/learning-media/images/studio-desk-800.webp 800w,
            /learning-media/images/studio-desk-1600.webp 1600w"
    sizes="100vw">
  <img
    src="/learning-media/images/studio-desk-1200.jpg"
    alt="An open laptop, a notebook and a coffee mug on a wooden desk"
    width="1200" height="800">
</picture>', 'html', NULL, '{"annotations":[{"line":"1","text":"`<picture>` is a wrapper. It displays nothing itself."},{"line":"2-6","text":"Each `<source>` is a candidate. The browser takes the first one it understands and stops looking."},{"line":"3","text":"`type=\"image/webp\"` lets a browser skip this source entirely if it cannot display WebP."},{"line":"7-10","text":"The `<img>` is required and must come last. It is the fallback, and it carries the `alt`, `width` and `height` for the whole picture."}]}'::jsonb
from public.lessons where slug = 'picture-and-formats';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'The `<img>` inside `<picture>` is not optional', 'Without it nothing displays at all — `<picture>` and `<source>` render nothing on their own. The `alt` also belongs on the `<img>`, not on the `<source>`.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'picture-and-formats';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'prose'::public.block_type, NULL, 'Art direction means showing a *different* image, not just a different size. A wide landscape photograph often becomes unreadable when squeezed onto a phone; a tighter crop of the same scene works far better.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'picture-and-formats';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, 'Art direction: a portrait crop on narrow screens', NULL,
       '<picture>
  <source media="(max-width: 40rem)"
          srcset="/learning-media/images/team-portrait-800.jpg">
  <img src="/learning-media/images/city-dusk-1200.jpg"
       alt="The team outside the workshop at dusk"
       width="1200" height="800">
</picture>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'picture-and-formats';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'srcset or picture?', 'Use `srcset` on a plain `<img>` when it is the same picture at different sizes — that covers most cases and is far less markup. Reach for `<picture>` only when the *content* differs: a new format, or a genuinely different crop.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'picture-and-formats';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'term'::public.block_type, 'Lazy loading', '`loading="lazy"` tells the browser not to download an image until the user is close to scrolling it into view.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'picture-and-formats';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'comparison'::public.block_type, 'Which images to lazy-load', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Below the fold — lazy","code":"<img src=\"/learning-media/images/newsroom-desk-800.jpg\"\n     alt=\"Newspaper pages spread across a desk\"\n     loading=\"lazy\" width=\"1200\" height=\"800\">","why":"The visitor may never scroll this far. Not downloading it is a straight saving."},"bad":{"label":"The hero image — never lazy","code":"<img src=\"/learning-media/images/coast-sunrise-1200.jpg\"\n     alt=\"Sunrise over a calm sea\"\n     fetchpriority=\"high\" width=\"1200\" height=\"800\">","why":"It is visible immediately. Lazy-loading it *delays* the most important image on the page — a common and costly mistake."}}'::jsonb
from public.lessons where slug = 'picture-and-formats';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'term'::public.block_type, 'fetchpriority', 'A hint about how urgently an image is needed. `high` on the main hero image; `low` on something incidental. Use it sparingly — the browser is usually right without help.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'picture-and-formats';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'Why does lazy loading a hero image hurt so much?', 'Lazy-loaded images are deprioritised until the browser has calculated layout, which delays the largest visible image — the exact thing performance measurements such as Largest Contentful Paint measure. The rule of thumb: images visible without scrolling should never be lazy; everything else should be. Level 10 returns to this with the full performance picture.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'picture-and-formats';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<picture>` chooses between genuinely different files; `srcset` chooses between sizes.","The `<img>` inside `<picture>` is required and carries the alt text.","`loading=\"lazy\"` for images below the fold; never for the hero image.","`fetchpriority=\"high\"` marks the one image that matters most."],"nextUp":"Next: video and audio."}'::jsonb
from public.lessons where slug = 'picture-and-formats';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'picture-guided', 1, 'guided'::public.exercise_kind, 'Offer WebP with a JPEG fallback',
       'Wrap this image in a `<picture>` and add a `<source>` offering the WebP versions at 800 and 1600 pixels wide, with `type="image/webp"`. Leave the `<img>` as the fallback.', '<img
  src="/learning-media/images/product-bottle-1200.jpg"
  alt="A dark green ceramic bottle with a cork stopper on a plain grey background"
  width="1200" height="1200">', '<picture>
  <source
    type="image/webp"
    srcset="/learning-media/images/product-bottle-800.webp 800w,
            /learning-media/images/product-bottle-1600.webp 1600w"
    sizes="100vw">
  <img
    src="/learning-media/images/product-bottle-1200.jpg"
    alt="A dark green ceramic bottle with a cork stopper on a plain grey background"
    width="1200" height="1200">
</picture>', ARRAY['The <picture> wraps everything; the <source> comes first and the <img> last.', 'The <source> needs type="image/webp" and a srcset of the .webp files.', 'Keep the alt, width and height on the <img>, not on the <source>.']::text[],
       50, 3,
       (select id from public.skills where slug = 'responsive-images'), false
from public.lessons l where l.slug = 'picture-and-formats'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'picture', NULL,
       NULL, NULL, NULL, NULL,
       'There is a picture element', NULL, 1, true
from public.exercises e where e.slug = 'picture-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'nesting'::public.requirement_kind, 'source', NULL,
       NULL, 'picture', 1, NULL,
       'A source element is inside the picture', NULL, 1, true
from public.exercises e where e.slug = 'picture-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'source', 'type',
       'image/webp', NULL, NULL, NULL,
       'The source declares the WebP type', NULL, 1, true
from public.exercises e where e.slug = 'picture-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'source', 'srcset',
       NULL, NULL, NULL, NULL,
       'The source has a srcset', NULL, 1, true
from public.exercises e where e.slug = 'picture-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'nesting'::public.requirement_kind, 'img', NULL,
       NULL, 'picture', 1, NULL,
       'The img fallback is inside the picture', NULL, 1, true
from public.exercises e where e.slug = 'picture-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'The img still carries the alt text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'picture-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'local_media_path'::public.requirement_kind, 'img, source', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'picture-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'lazy-challenge', 2, 'challenge'::public.exercise_kind, 'Three images, three loading decisions',
       'Build a page with three images from the media library: a hero image at the top marked `fetchpriority="high"`, and two further down the page marked `loading="lazy"`. All three need alt text and dimensions.', '', '<h1>The valley route</h1>
<img src="/learning-media/images/coast-sunrise-1200.jpg"
     alt="Sunrise over a calm sea at the start of the valley route"
     fetchpriority="high" width="1200" height="800">

<h2>Halfway</h2>
<img src="/learning-media/images/forest-path-1200.jpg"
     alt="A sandy path winding between tall trees"
     loading="lazy" width="1200" height="800">

<h2>The finish</h2>
<img src="/learning-media/images/city-dusk-1200.jpg"
     alt="A city skyline at dusk with hundreds of lit office windows"
     loading="lazy" width="1200" height="800">', ARRAY['The first image is visible immediately, so it must NOT be lazy.', 'Add fetchpriority="high" to the hero image only.', 'Add loading="lazy" to the other two.']::text[],
       55, 3,
       (select id from public.skills where slug = 'performance'), false
from public.lessons l where l.slug = 'picture-and-formats'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'img', NULL,
       NULL, NULL, 3, 3,
       'There are three images', NULL, 1, true
from public.exercises e where e.slug = 'lazy-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'img[loading="lazy"]', NULL,
       NULL, NULL, 2, 2,
       'Exactly two images are lazy-loaded', NULL, 1, true
from public.exercises e where e.slug = 'lazy-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'img', 'fetchpriority',
       'high', NULL, NULL, NULL,
       'The hero image is marked high priority', NULL, 1, true
from public.exercises e where e.slug = 'lazy-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'img[fetchpriority="high"][loading="lazy"]', NULL,
       NULL, NULL, 0, 0,
       'The hero image is not also lazy-loaded', 'Lazy-loading the hero image delays the most important image on the page.', 1, true
from public.exercises e where e.slug = 'lazy-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every image has meaningful alternative text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'lazy-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'attribute_present'::public.requirement_kind, 'img', 'width',
       NULL, NULL, NULL, NULL,
       'Every image declares its width', NULL, 1, true
from public.exercises e where e.slug = 'lazy-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'lazy-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'picture-and-formats'), NULL, 'q-picture-img', 1, 'single'::public.question_kind,
        'Why must a `<picture>` contain an `<img>`?', '`<picture>` and `<source>` render nothing themselves. The `<img>` is what actually displays, and it carries the alt text.', (select id from public.skills where slug = 'responsive-images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The <img> is what actually displays, and holds the alt text', true, NULL
from public.quiz_questions where slug = 'q-picture-img';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It is optional in modern browsers', false, NULL
from public.quiz_questions where slug = 'q-picture-img';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It sets the aspect ratio only', false, NULL
from public.quiz_questions where slug = 'q-picture-img';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is required only when using WebP', false, NULL
from public.quiz_questions where slug = 'q-picture-img';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'picture-and-formats'), NULL, 'q-lazy-hero', 2, 'single'::public.question_kind,
        'Should you lazy-load the main image at the top of a page?', 'No. It is visible immediately, so lazy-loading delays the most important image and measurably worsens perceived load speed.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Only if the image is over 500KB', false, NULL
from public.quiz_questions where slug = 'q-lazy-hero';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'No — it delays the most important image on the page', true, NULL
from public.quiz_questions where slug = 'q-lazy-hero';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Yes, always lazy-load every image', false, NULL
from public.quiz_questions where slug = 'q-lazy-hero';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only on mobile', false, NULL
from public.quiz_questions where slug = 'q-lazy-hero';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'picture-and-formats'), NULL, 'q-picture-vs-srcset', 3, 'single'::public.question_kind,
        'When do you need `<picture>` rather than `srcset` on an `<img>`?', 'When the files genuinely differ — a different format the browser might not support, or a different crop.', (select id from public.skills where slug = 'responsive-images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'When you want lazy loading', false, NULL
from public.quiz_questions where slug = 'q-picture-vs-srcset';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'When offering a different format or a different crop', true, NULL
from public.quiz_questions where slug = 'q-picture-vs-srcset';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Whenever you have more than one image size', false, NULL
from public.quiz_questions where slug = 'q-picture-vs-srcset';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Whenever the image is a photograph', false, NULL
from public.quiz_questions where slug = 'q-picture-vs-srcset';
-- module: Video, audio and embedded content
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'video-audio-embeds', 3, 'Video, audio and embedded content', 'Accessible media with captions and fallbacks, and how to embed someone else''s content without handing them your page.',
       50, true
from public.levels l where l.slug = 'media-specialist'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'video-audio-embeds' and p.slug = 'responsive-images';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'video-audio-embeds' and s.slug = 'audio-video';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'video-audio-embeds' and s.slug = 'embedded-content';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.7
from public.modules m, public.skills s
where m.slug = 'video-audio-embeds' and s.slug = 'responsive-images';
-- lesson: Video and audio
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'video-and-audio', 1, 'Video and audio', 'Sources, posters, controls, captions and fallbacks', 'Video is the easiest place to accidentally exclude people. Getting captions and controls right takes two extra lines.',
       ARRAY['Embed a video with multiple sources and a poster image', 'Add captions with the track element', 'Explain why autoplay with sound is a serious accessibility problem']::text[], 16, 40, (select id from public.skills where slug = 'audio-video'), 0.7
from public.modules m where m.slug = 'video-audio-embeds'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Embed video and audio with fallback sources","Add a captions track and a poster image","Make correct decisions about autoplay, muting and preload"]}'::jsonb
from public.lessons where slug = 'video-and-audio';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'media_example'::public.block_type, 'A complete, accessible video', 'Every attribute below is doing something specific. Play it — the captions can be turned on from the video controls.',
       '<video
  controls
  preload="metadata"
  poster="/learning-media/posters/page-anatomy.jpg"
  width="1280" height="720">
  <source src="/learning-media/video/page-anatomy.webm" type="video/webm">
  <source src="/learning-media/video/page-anatomy.mp4" type="video/mp4">
  <track
    kind="captions"
    src="/learning-media/captions/page-anatomy.en.vtt"
    srclang="en"
    label="English"
    default>
  <p>
    Your browser cannot play this video.
    <a href="/learning-media/video/page-anatomy.mp4">Download the MP4 file</a>.
  </p>
</video>', 'html', 'page-anatomy', '{}'::jsonb
from public.lessons where slug = 'video-and-audio';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<video controls preload="metadata"
       poster="/learning-media/posters/page-anatomy.jpg"
       width="1280" height="720">
  <source src="/learning-media/video/page-anatomy.webm" type="video/webm">
  <source src="/learning-media/video/page-anatomy.mp4" type="video/mp4">
  <track kind="captions" src="/learning-media/captions/page-anatomy.en.vtt"
         srclang="en" label="English" default>
  <p>Your browser cannot play this video.</p>
</video>', 'html', NULL, '{"annotations":[{"line":"1","text":"`controls` gives the visitor play, pause, volume and captions. Without it there is no way to start the video at all unless you write JavaScript."},{"line":"1","text":"`preload=\"metadata\"` downloads just enough to know the duration. `auto` would fetch the whole file before anyone asks for it; `none` fetches nothing."},{"line":"2","text":"`poster` is the still image shown before playback. Without it the visitor sees a black rectangle."},{"line":"4-5","text":"Two `<source>` elements: the browser takes the first format it supports. WebM is smaller; MP4 is universally supported. Listing WebM first means capable browsers get the smaller file."},{"line":"6-7","text":"`<track kind=\"captions\">` points at a WebVTT file. `default` turns them on automatically. Captions serve deaf and hard-of-hearing viewers, anyone in a noisy place, and anyone who simply prefers to read."},{"line":"8","text":"Anything after the sources is fallback content, shown only by browsers that cannot play video at all. Offer a download link rather than an apology."}]}'::jsonb
from public.lessons where slug = 'video-and-audio';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Autoplay with sound is genuinely harmful', 'Unexpected sound is disorienting for screen-reader users — it plays over the voice they are listening to — and distressing for people with anxiety or sensory sensitivities. Browsers now block it, but the fix is not to work around the block. If a video must play automatically it must be `muted`, and it must still have `controls` so it can be stopped.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'video-and-audio';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'Audio follows exactly the same pattern', NULL,
       '<audio controls preload="none">
  <source src="/learning-media/audio/calm-loop.mp3" type="audio/mpeg">
  <source src="/learning-media/audio/calm-loop.wav" type="audio/wav">
  <p>
    Your browser cannot play audio.
    <a href="/learning-media/audio/calm-loop.mp3">Download the MP3</a>.
  </p>
</audio>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'video-and-audio';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'term'::public.block_type, 'WebVTT', 'The caption file format. Plain text: a timestamp range, then the words shown during it. You can write one in any text editor.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'video-and-audio';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'code_example'::public.block_type, 'Inside a .vtt caption file', NULL,
       'WEBVTT

00:00:00.000 --> 00:00:03.000
Every web page starts as a plain text file.

00:00:03.000 --> 00:00:06.500
The doctype tells the browser to use modern HTML rules.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'video-and-audio';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'progressive_detail'::public.block_type, 'Captions, subtitles and transcripts', 'Captions carry the dialogue *and* important non-speech sound ("[door closes]") and are aimed at viewers who cannot hear the audio. Subtitles translate dialogue for viewers who cannot understand the language but can hear fine — `kind="subtitles"` with a different `srclang`. A transcript is the whole thing as text on the page: it helps people who prefer reading, works for anyone who cannot use the player at all, and is the only version a search engine can read. Offering all three is the professional standard for important video.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'video-and-audio';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'checklist'::public.block_type, 'Every video you publish', NULL,
       NULL, NULL, NULL, '{"items":["`controls`, always","A `poster` image","At least one `<source>`, ideally WebM and MP4","A `<track kind=\"captions\">` with a real caption file","Fallback content with a download link","`width` and `height` to reserve space","No autoplay — or if truly necessary, `muted` and still with controls"]}'::jsonb
from public.lessons where slug = 'video-and-audio';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<source>` elements let the browser choose a format it supports.","`controls` and a `poster` are effectively mandatory.","`<track kind=\"captions\">` is what makes video usable by deaf viewers.","Fallback content sits after the sources; make it a download link.","Autoplay with sound is harmful and is blocked by browsers."],"nextUp":"Next: embedding other people''s content safely."}'::jsonb
from public.lessons where slug = 'video-and-audio';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'video-guided', 1, 'guided'::public.exercise_kind, 'Build an accessible video',
       'Complete this video element. Add `controls`, a `poster` of `/learning-media/posters/responsive-layout.jpg`, a second `<source>` for the MP4, an English captions `<track>` pointing at `/learning-media/captions/responsive-layout.en.vtt`, and fallback content with a download link.', '<video width="1280" height="720">
  <source src="/learning-media/video/responsive-layout.webm" type="video/webm">
</video>', '<video controls preload="metadata"
       poster="/learning-media/posters/responsive-layout.jpg"
       width="1280" height="720">
  <source src="/learning-media/video/responsive-layout.webm" type="video/webm">
  <source src="/learning-media/video/responsive-layout.mp4" type="video/mp4">
  <track kind="captions"
         src="/learning-media/captions/responsive-layout.en.vtt"
         srclang="en" label="English" default>
  <p>
    Your browser cannot play this video.
    <a href="/learning-media/video/responsive-layout.mp4">Download the MP4</a>.
  </p>
</video>', ARRAY['controls is a boolean attribute — just the word, with no value.', 'The MP4 source goes after the WebM one, with type="video/mp4".', 'The <track> needs kind, src, srclang and label; add default to switch captions on.', 'Fallback content goes last, inside the <video>, after the track.']::text[],
       60, 3,
       (select id from public.skills where slug = 'audio-video'), false
from public.lessons l where l.slug = 'video-and-audio'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'video', 'controls',
       NULL, NULL, NULL, NULL,
       'The video has visible controls', NULL, 1, true
from public.exercises e where e.slug = 'video-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'video', 'poster',
       NULL, NULL, NULL, NULL,
       'The video has a poster image', NULL, 1, true
from public.exercises e where e.slug = 'video-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'video source', NULL,
       NULL, NULL, 2, NULL,
       'There are at least two sources', NULL, 1, true
from public.exercises e where e.slug = 'video-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'source', 'type',
       'video/mp4', NULL, NULL, NULL,
       'An MP4 source is offered', NULL, 1, true
from public.exercises e where e.slug = 'video-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'track[kind="captions"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a captions track', NULL, 1, true
from public.exercises e where e.slug = 'video-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'attribute_value'::public.requirement_kind, 'track', 'srclang',
       'en', NULL, NULL, NULL,
       'The captions declare their language', NULL, 1, true
from public.exercises e where e.slug = 'video-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'nesting'::public.requirement_kind, 'a', NULL,
       NULL, 'video', 1, NULL,
       'Fallback content offers a download link', NULL, 1, true
from public.exercises e where e.slug = 'video-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'local_media_path'::public.requirement_kind, 'video, source, track', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'video-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'video-debug', 2, 'debug'::public.exercise_kind, 'A video nobody can use',
       'This video autoplays with sound, has no controls, no captions and no poster. Repair it so it meets the checklist from this lesson.', '<video autoplay loop width="1280" height="720">
  <source src="/learning-media/video/page-anatomy.mp4" type="video/mp4">
</video>', '<video controls preload="metadata"
       poster="/learning-media/posters/page-anatomy.jpg"
       width="1280" height="720">
  <source src="/learning-media/video/page-anatomy.webm" type="video/webm">
  <source src="/learning-media/video/page-anatomy.mp4" type="video/mp4">
  <track kind="captions" src="/learning-media/captions/page-anatomy.en.vtt"
         srclang="en" label="English" default>
  <p>
    Your browser cannot play this video.
    <a href="/learning-media/video/page-anatomy.mp4">Download the MP4</a>.
  </p>
</video>', ARRAY['Remove autoplay entirely — the visitor should decide when it starts.', 'Add controls so it can be played, paused and muted.', 'Add a poster and a captions track from the media library.', 'Add fallback content with a download link at the end.']::text[],
       55, 3,
       (select id from public.skills where slug = 'audio-video'), false
from public.lessons l where l.slug = 'video-and-audio'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_absent'::public.requirement_kind, 'video', 'autoplay',
       NULL, NULL, NULL, NULL,
       'The video no longer autoplays', 'Delete the autoplay attribute.', 1, true
from public.exercises e where e.slug = 'video-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'video', 'controls',
       NULL, NULL, NULL, NULL,
       'The video has controls', NULL, 1, true
from public.exercises e where e.slug = 'video-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'video', 'poster',
       NULL, NULL, NULL, NULL,
       'The video has a poster image', NULL, 1, true
from public.exercises e where e.slug = 'video-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'track[kind="captions"]', NULL,
       NULL, NULL, NULL, NULL,
       'Captions are provided', NULL, 1, true
from public.exercises e where e.slug = 'video-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'nesting'::public.requirement_kind, 'a', NULL,
       NULL, 'video', 1, NULL,
       'There is fallback content with a download link', NULL, 1, true
from public.exercises e where e.slug = 'video-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'local_media_path'::public.requirement_kind, 'video, source, track', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'video-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'video-and-audio'), NULL, 'q-video-controls', 1, 'single'::public.question_kind,
        'What happens if you omit `controls` from a `<video>`?', 'There is no way for the visitor to play, pause or mute it without JavaScript. It is the single most common video mistake.', (select id from public.skills where slug = 'audio-video'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The visitor has no way to play or pause it', true, NULL
from public.quiz_questions where slug = 'q-video-controls';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The video plays automatically instead', false, NULL
from public.quiz_questions where slug = 'q-video-controls';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The browser adds default controls anyway', false, NULL
from public.quiz_questions where slug = 'q-video-controls';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only the poster image is shown', false, NULL
from public.quiz_questions where slug = 'q-video-controls';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'video-and-audio'), NULL, 'q-track-kind', 2, 'single'::public.question_kind,
        'What is the difference between captions and subtitles?', 'Captions include non-speech sound and are for viewers who cannot hear the audio. Subtitles translate dialogue for viewers who can hear but do not understand the language.', (select id from public.skills where slug = 'audio-video'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Subtitles are burned into the video; captions are separate', false, NULL
from public.quiz_questions where slug = 'q-track-kind';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Captions are for film; subtitles are for the web', false, NULL
from public.quiz_questions where slug = 'q-track-kind';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Captions include non-speech sound; subtitles translate dialogue', true, NULL
from public.quiz_questions where slug = 'q-track-kind';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'They are the same thing with different names', false, NULL
from public.quiz_questions where slug = 'q-track-kind';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'video-and-audio'), NULL, 'q-fallback-placement', 3, 'single'::public.question_kind,
        'Where does fallback content go inside a `<video>`?', 'After the `<source>` and `<track>` elements. Browsers that can play video ignore it; browsers that cannot display it instead.', (select id from public.skills where slug = 'audio-video'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Immediately after the closing </video> tag', false, NULL
from public.quiz_questions where slug = 'q-fallback-placement';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Inside the first <source>', false, NULL
from public.quiz_questions where slug = 'q-fallback-placement';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Inside the <video>, after the sources and tracks', true, NULL
from public.quiz_questions where slug = 'q-fallback-placement';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'In an alt attribute on the video', false, NULL
from public.quiz_questions where slug = 'q-fallback-placement';
-- lesson: Iframes, sandboxing, and the media milestone
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'iframes-and-media-milestone', 2, 'Iframes, sandboxing, and the media milestone', 'Embedding safely, then building the whole thing', 'An iframe puts someone else''s page inside yours. That is powerful and worth being careful about.',
       ARRAY['Embed content with an iframe and a title', 'Restrict an embed with the sandbox attribute', 'Build a complete media-rich page']::text[], 25, 40, (select id from public.skills where slug = 'embedded-content'), 0.8
from public.modules m where m.slug = 'video-audio-embeds'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Embed third-party content with an accessible name","Apply sandbox and referrerpolicy sensibly","Combine responsive images, video and figures on one page"]}'::jsonb
from public.lessons where slug = 'iframes-and-media-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'term'::public.block_type, 'Iframe', 'An "inline frame" — a window in your page showing a completely separate document. Maps, video players and payment forms are commonly embedded this way.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'iframes-and-media-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<iframe
  src="https://www.example.org/map"
  title="Map showing the workshop on Mill Lane"
  width="600" height="400"
  loading="lazy"
  sandbox="allow-scripts allow-same-origin"
  referrerpolicy="no-referrer-when-downgrade">
</iframe>', 'html', NULL, '{"annotations":[{"line":"2","text":"`src` is the page being embedded."},{"line":"3","text":"`title` is required for accessibility. Without it a screen reader announces only \"frame\", with no indication of what is inside. This is the most commonly missed accessibility attribute in all of HTML."},{"line":"4","text":"`width` and `height` reserve space, exactly as with images."},{"line":"5","text":"`loading=\"lazy\"` avoids loading an embed the visitor may never scroll to. Embeds are often the heaviest thing on a page."},{"line":"6","text":"`sandbox` removes capabilities and adds back only what you list. With an empty `sandbox=\"\"` the embedded page can do almost nothing; each `allow-` token restores one capability."},{"line":"7","text":"`referrerpolicy` controls how much of your page''s address is sent to the embedded site. Level 10 covers the options in full."}]}'::jsonb
from public.lessons where slug = 'iframes-and-media-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Only embed sources you trust', 'An embedded page runs its own code, sets its own cookies and can attempt to navigate your window. `sandbox` is your main defence — start with the tightest set of permissions that still works, rather than starting permissive and tightening later.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'iframes-and-media-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'How this platform previews your work', 'Every preview in HTML Hero renders inside an iframe with `sandbox=""` and no `allow-scripts`, which is why scripts you write never execute here. You are using the exact technique this lesson describes, and now you know why the preview panel says what it says.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'iframes-and-media-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'progressive_detail'::public.block_type, 'Common sandbox tokens', '`allow-scripts` lets the embed run JavaScript. `allow-same-origin` lets it keep its own origin, without which it cannot read its own cookies or storage. `allow-forms` permits form submission. `allow-popups` permits new windows. Granting `allow-scripts` and `allow-same-origin` together to a page from your *own* origin effectively removes the sandbox, because the embedded page can then reach out and remove the sandbox attribute itself — so avoid that particular combination for same-origin content.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'iframes-and-media-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'checklist'::public.block_type, 'The media milestone page needs', NULL,
       NULL, NULL, NULL, '{"items":["A responsive hero image with `srcset` and `sizes`","A `<figure>` with an image and a `<figcaption>`","A `<video>` with controls, a poster, two sources, captions and fallback content","One decorative image with `alt=\"\"`","Correct alt text on every informative image","Lazy loading on everything below the fold, but not on the hero","No broken media paths"]}'::jsonb
from public.lessons where slug = 'iframes-and-media-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["An `<iframe>` embeds a whole separate document; `title` is required.","`sandbox` removes capabilities; add back only what is needed.","`loading=\"lazy\"` matters even more for embeds than for images.","You can now build a complete, accessible, fast media page."],"nextUp":"Level 5 next: giving your pages professional structure."}'::jsonb
from public.lessons where slug = 'iframes-and-media-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'iframe-guided', 1, 'guided'::public.exercise_kind, 'Make an embed safe and accessible',
       'This iframe has no title, no sandbox and no lazy loading. Add a descriptive `title`, `loading="lazy"`, and a `sandbox` that allows scripts but nothing else.', '<iframe src="https://www.example.org/map" width="600" height="400"></iframe>', '<iframe
  src="https://www.example.org/map"
  title="Map showing the workshop on Mill Lane"
  width="600" height="400"
  loading="lazy"
  sandbox="allow-scripts"
  referrerpolicy="no-referrer-when-downgrade"></iframe>', ARRAY['The title should say what the embedded content is, not just "map".', 'sandbox="allow-scripts" removes everything except the ability to run JavaScript.', 'loading="lazy" goes on the iframe just as it does on an image.']::text[],
       45, 3,
       (select id from public.skills where slug = 'embedded-content'), false
from public.lessons l where l.slug = 'iframes-and-media-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'iframe', 'title',
       NULL, NULL, NULL, NULL,
       'The iframe has a title', NULL, 1, true
from public.exercises e where e.slug = 'iframe-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_matches'::public.requirement_kind, 'iframe', 'title',
       '\S{4,}', NULL, NULL, NULL,
       'The title actually describes the embedded content', NULL, 1, true
from public.exercises e where e.slug = 'iframe-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'iframe', 'loading',
       'lazy', NULL, NULL, NULL,
       'The iframe is lazy-loaded', NULL, 1, true
from public.exercises e where e.slug = 'iframe-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'iframe', 'sandbox',
       NULL, NULL, NULL, NULL,
       'The iframe is sandboxed', NULL, 1, true
from public.exercises e where e.slug = 'iframe-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_matches'::public.requirement_kind, 'iframe', 'sandbox',
       'allow-scripts', NULL, NULL, NULL,
       'Scripts are permitted inside the sandbox', NULL, 1, true
from public.exercises e where e.slug = 'iframe-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'media-milestone', 2, 'challenge'::public.exercise_kind, 'Milestone: a media-rich page',
       'Build a complete page body meeting every item on the checklist above. Use only paths from the media library — the checker verifies that every file exists.', '', '<h1>The valley route</h1>

<img
  src="/learning-media/images/coast-sunrise-1200.jpg"
  srcset="/learning-media/images/coast-sunrise-480.jpg   480w,
          /learning-media/images/coast-sunrise-800.jpg   800w,
          /learning-media/images/coast-sunrise-1200.jpg 1200w,
          /learning-media/images/coast-sunrise-1600.jpg 1600w"
  sizes="100vw"
  alt="Sunrise over a calm sea at the start of the valley route"
  fetchpriority="high"
  width="1200" height="800">

<p>Twenty-four miles, mostly flat, with one long climb near the reservoir.</p>

<figure>
  <img src="/learning-media/images/forest-path-1200.jpg"
       alt="A sandy path winding between tall trees in a sunlit forest"
       loading="lazy" width="1200" height="800">
  <figcaption>The wooded section between mile eight and mile twelve.</figcaption>
</figure>

<h2>What the route looks like</h2>
<video controls preload="metadata"
       poster="/learning-media/posters/responsive-layout.jpg"
       width="1280" height="720">
  <source src="/learning-media/video/responsive-layout.webm" type="video/webm">
  <source src="/learning-media/video/responsive-layout.mp4" type="video/mp4">
  <track kind="captions" src="/learning-media/captions/responsive-layout.en.vtt"
         srclang="en" label="English" default>
  <p>
    Your browser cannot play this video.
    <a href="/learning-media/video/responsive-layout.mp4">Download the MP4</a>.
  </p>
</video>

<img src="/learning-media/svg/placeholder.svg" alt="" loading="lazy" width="800" height="500">', ARRAY['Start with the hero image: a full srcset, sizes, fetchpriority="high", and no lazy loading.', 'The figure needs an image with lazy loading plus a figcaption.', 'The video needs controls, poster, two sources, a captions track and fallback content.', 'End with one decorative image using alt="" — the placeholder SVG is designed for this.']::text[],
       130, 4,
       (select id from public.skills where slug = 'audio-video'), false
from public.lessons l where l.slug = 'iframes-and-media-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'img', NULL,
       NULL, NULL, 3, NULL,
       'There are at least three images', NULL, 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'img[srcset]', 'sizes',
       NULL, NULL, NULL, NULL,
       'The responsive image has both srcset and sizes', NULL, 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'figure > figcaption', NULL,
       NULL, NULL, NULL, NULL,
       'There is a figure with a caption', NULL, 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'video[controls]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a video with controls', NULL, 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_present'::public.requirement_kind, 'video', 'poster',
       NULL, NULL, NULL, NULL,
       'The video has a poster image', NULL, 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'video source', NULL,
       NULL, NULL, 2, NULL,
       'The video offers at least two sources', NULL, 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'element_present'::public.requirement_kind, 'track[kind="captions"]', NULL,
       NULL, NULL, NULL, NULL,
       'The video has captions', NULL, 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'nesting'::public.requirement_kind, 'a', NULL,
       NULL, 'video', 1, NULL,
       'The video has fallback content with a link', NULL, 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'element_count'::public.requirement_kind, 'img[alt=""]', NULL,
       NULL, NULL, 1, NULL,
       'At least one decorative image uses alt=""', NULL, 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'element_count'::public.requirement_kind, 'img[loading="lazy"]', NULL,
       NULL, NULL, 1, NULL,
       'At least one image below the fold is lazy-loaded', NULL, 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every informative image has meaningful alt text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'local_media_path'::public.requirement_kind, 'img, source, track, video', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct', 'One <h1>, then step down one level at a time.', 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'media-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'media-mission', 3, 'project_mission'::public.exercise_kind, 'Capstone mission: add media to your site',
       'Add a hero image with a full `srcset` to your capstone homepage, and a `<figure>` with a captioned image to your about page. Use library paths so nothing can break.', '<main id="main">
  <h1>Your site name</h1>

  <!-- Add your responsive hero image here -->

  <p>Your existing content.</p>

  <!-- Add a figure with a captioned image here -->
</main>', '<main id="main">
  <h1>Riverside Cycle Hire</h1>

  <img
    src="/learning-media/images/coast-sunrise-1200.jpg"
    srcset="/learning-media/images/coast-sunrise-480.jpg   480w,
            /learning-media/images/coast-sunrise-800.jpg   800w,
            /learning-media/images/coast-sunrise-1200.jpg 1200w,
            /learning-media/images/coast-sunrise-1600.jpg 1600w"
    sizes="100vw"
    alt="Sunrise over the estuary at the start of the river path"
    fetchpriority="high" width="1200" height="800">

  <p>We rent well-maintained bikes by the hour, the day or the week.</p>

  <figure>
    <img src="/learning-media/images/workshop-tools-1200.jpg"
         alt="Hand tools hanging in rows above a workbench"
         loading="lazy" width="1200" height="800">
    <figcaption>Every bike is serviced on site before it leaves.</figcaption>
  </figure>
</main>', ARRAY['Use the media picker to insert a full srcset without typing every path.', 'The hero image should not be lazy-loaded.', 'Write alt text that suits your own project, not the example.']::text[],
       85, 3,
       (select id from public.skills where slug = 'responsive-images'), false
from public.lessons l where l.slug = 'iframes-and-media-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'img[srcset]', 'sizes',
       NULL, NULL, NULL, NULL,
       'The hero image has srcset and sizes', NULL, 1, true
from public.exercises e where e.slug = 'media-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_present'::public.requirement_kind, 'figure > figcaption', NULL,
       NULL, NULL, NULL, NULL,
       'There is a captioned figure', NULL, 1, true
from public.exercises e where e.slug = 'media-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every image has meaningful alternative text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'media-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'img', 'width',
       NULL, NULL, NULL, NULL,
       'Images declare their dimensions', NULL, 1, true
from public.exercises e where e.slug = 'media-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'local_media_path'::public.requirement_kind, 'img, source', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'media-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'iframes-and-media-milestone'), NULL, 'q-iframe-title', 1, 'single'::public.question_kind,
        'Why does an `<iframe>` need a `title`?', 'Without it, a screen reader announces only "frame" with no indication of what the embedded content is.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It appears as a tooltip on hover', false, NULL
from public.quiz_questions where slug = 'q-iframe-title';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Screen readers otherwise announce only "frame"', true, NULL
from public.quiz_questions where slug = 'q-iframe-title';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It sets the title of the embedded page', false, NULL
from public.quiz_questions where slug = 'q-iframe-title';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It is required for the iframe to load', false, NULL
from public.quiz_questions where slug = 'q-iframe-title';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'iframes-and-media-milestone'), NULL, 'q-sandbox', 2, 'single'::public.question_kind,
        'What does `sandbox=""` on an iframe do?', 'An empty sandbox removes essentially every capability. Each `allow-` token you add restores one.', (select id from public.skills where slug = 'security'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Has no effect unless a value is given', false, NULL
from public.quiz_questions where slug = 'q-sandbox';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Removes almost all capabilities from the embedded page', true, NULL
from public.quiz_questions where slug = 'q-sandbox';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Grants the embedded page full permissions', false, NULL
from public.quiz_questions where slug = 'q-sandbox';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Prevents the iframe from loading at all', false, NULL
from public.quiz_questions where slug = 'q-sandbox';
-- Level 4 milestone: Media Specialist questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-4-milestone'), 'a4-q1', 1, 'single'::public.question_kind,
        'Which attributes are required on every `<img>`?', '`src` says which file; `alt` provides the text alternative. Both are required.', (select id from public.skills where slug = 'images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'src, width and height', false, NULL
from public.quiz_questions where slug = 'a4-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'src only', false, NULL
from public.quiz_questions where slug = 'a4-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'src and alt', true, NULL
from public.quiz_questions where slug = 'a4-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'src and title', false, NULL
from public.quiz_questions where slug = 'a4-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-4-milestone'), 'a4-q2', 2, 'single'::public.question_kind,
        'An image is purely decorative. What should its alt be?', '`alt=""` tells screen readers to skip it. The attribute must still be present.', (select id from public.skills where slug = 'images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'alt="spacer image"', false, NULL
from public.quiz_questions where slug = 'a4-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'alt=""', true, NULL
from public.quiz_questions where slug = 'a4-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Omit the alt attribute', false, NULL
from public.quiz_questions where slug = 'a4-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'alt="decorative"', false, NULL
from public.quiz_questions where slug = 'a4-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-4-milestone'), 'a4-q3', 3, 'single'::public.question_kind,
        'What does `1200w` mean in a srcset?', 'It describes the candidate file: this file is 1200 pixels wide.', (select id from public.skills where slug = 'responsive-images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'This image file is 1200 pixels wide', true, NULL
from public.quiz_questions where slug = 'a4-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Use this file on screens wider than 1200 pixels', false, NULL
from public.quiz_questions where slug = 'a4-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Display the image at 1200 pixels', false, NULL
from public.quiz_questions where slug = 'a4-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The file weighs 1200 kilobytes', false, NULL
from public.quiz_questions where slug = 'a4-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-4-milestone'), 'a4-q4', 4, 'single'::public.question_kind,
        'Which element is required inside a `<picture>`?', 'The `<img>` is what actually renders and carries the alt text.', (select id from public.skills where slug = 'responsive-images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<source>', false, NULL
from public.quiz_questions where slug = 'a4-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<figcaption>', false, NULL
from public.quiz_questions where slug = 'a4-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<track>', false, NULL
from public.quiz_questions where slug = 'a4-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<img>', true, NULL
from public.quiz_questions where slug = 'a4-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-4-milestone'), 'a4-q5', 5, 'single'::public.question_kind,
        'Which image should NOT have `loading="lazy"`?', 'The hero image is visible immediately, so lazy-loading it delays the most important content on the page.', (select id from public.skills where slug = 'performance'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'An image halfway down a long article', false, NULL
from public.quiz_questions where slug = 'a4-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'An image inside a collapsed details element', false, NULL
from public.quiz_questions where slug = 'a4-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The hero image at the top of the page', true, NULL
from public.quiz_questions where slug = 'a4-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A photograph in the footer', false, NULL
from public.quiz_questions where slug = 'a4-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-4-milestone'), 'a4-q6', 6, 'single'::public.question_kind,
        'What does `<track kind="captions">` provide?', 'A timed text file carrying dialogue and important non-speech sound, for viewers who cannot hear the audio.', (select id from public.skills where slug = 'audio-video'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'An alternative video format', false, NULL
from public.quiz_questions where slug = 'a4-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Timed captions for viewers who cannot hear the audio', true, NULL
from public.quiz_questions where slug = 'a4-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A thumbnail preview strip', false, NULL
from public.quiz_questions where slug = 'a4-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Chapter markers', false, NULL
from public.quiz_questions where slug = 'a4-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-4-milestone'), 'a4-q7', 7, 'single'::public.question_kind,
        'Why is autoplaying video with sound a problem?', 'It plays over a screen reader''s voice, startles users, and is distressing for people with sensory sensitivities. Browsers block it by default.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It talks over screen readers and startles users', true, NULL
from public.quiz_questions where slug = 'a4-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It uses more bandwidth than muted video', false, NULL
from public.quiz_questions where slug = 'a4-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is invalid HTML', false, NULL
from public.quiz_questions where slug = 'a4-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Search engines penalise it', false, NULL
from public.quiz_questions where slug = 'a4-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-4-milestone'), 'a4-q8', 8, 'single'::public.question_kind,
        'Where does an iframe''s accessible name come from?', 'The `title` attribute on the iframe itself.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The <title> of the embedded page', false, NULL
from public.quiz_questions where slug = 'a4-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Its src attribute', false, NULL
from public.quiz_questions where slug = 'a4-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A nearby heading', false, NULL
from public.quiz_questions where slug = 'a4-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Its title attribute', true, NULL
from public.quiz_questions where slug = 'a4-q8';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-4-milestone'), 'a4-q9', 9, 'single'::public.question_kind,
        'Where does a `<video>`''s fallback content go?', 'Inside the video element, after the source and track elements.', (select id from public.skills where slug = 'audio-video'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'In the first <source>', false, NULL
from public.quiz_questions where slug = 'a4-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'After the closing </video> tag', false, NULL
from public.quiz_questions where slug = 'a4-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Inside <video>, after the sources and tracks', true, NULL
from public.quiz_questions where slug = 'a4-q9';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'In an alt attribute', false, NULL
from public.quiz_questions where slug = 'a4-q9';
-- --------------------------------------------------------------------------
-- Level 5: Structure Professional
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'structure-professional', 5, 'Structure Professional', 'Markup that describes meaning, not appearance',
       'The difference between an amateur page and a professional one is usually not what it looks like — it is what the markup says. This level is about semantic structure and the file organisation that goes with it.', 'You can take an unstructured page and rebuild it with professional semantic HTML and a maintainable folder structure.', 'violet'
from public.courses c where c.slug = 'html-hero'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-5-milestone', 'milestone'::public.assessment_kind, 'Level 5 milestone: Structure Professional', 'Eight questions on semantic structure and project organisation. Pass mark 75%.',
       0.75, 170, 5
from public.levels l where l.slug = 'structure-professional'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Semantic elements and page landmarks
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'semantic-landmarks', 1, 'Semantic elements and page landmarks', 'header, nav, main, section, article, aside, footer — what each one means and, just as importantly, when not to use it.',
       50, false
from public.levels l where l.slug = 'structure-professional'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'semantic-landmarks' and p.slug = 'video-audio-embeds';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'semantic-landmarks' and s.slug = 'semantic-html';
-- lesson: Semantic versus non-semantic elements
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'semantic-vs-non-semantic', 1, 'Semantic versus non-semantic elements', 'Why `<div>` should be your last choice, not your first', 'A `<div>` says nothing. Every semantic element you use instead gives real information to browsers, screen readers and search engines — for free.',
       ARRAY['Explain what makes an element semantic', 'Name the main landmark elements and their meanings', 'Recognise "div soup" and know what to do about it']::text[], 14, 40, (select id from public.skills where slug = 'semantic-html'), 0.7
from public.modules m where m.slug = 'semantic-landmarks'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Define semantic HTML in your own words","Identify the correct landmark element for a region of a page","Rewrite a div-based layout using semantic elements"]}'::jsonb
from public.lessons where slug = 'semantic-vs-non-semantic';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'term'::public.block_type, 'Semantic element', 'An element whose name describes what its content *is*. `<nav>` is semantic; `<div>` is not.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'semantic-vs-non-semantic';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, '<div> and <span>', 'Generic containers with no meaning at all. `<div>` is a block, `<span>` is inline. They exist for when you genuinely need a box to hang styling on and no semantic element fits.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'semantic-vs-non-semantic';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'visual'::public.block_type, NULL, 'The main landmark elements and the regions they describe.',
       NULL, NULL, 'semantic-landmarks', '{}'::jsonb
from public.lessons where slug = 'semantic-vs-non-semantic';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'The same page, twice', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Semantic","code":"<header>\n  <nav aria-label=\"Main\">…</nav>\n</header>\n<main>\n  <article>…</article>\n  <aside>…</aside>\n</main>\n<footer>…</footer>","why":"A screen reader can list the landmarks and jump straight to \"main\". Search engines can tell content from navigation. No extra work required."},"bad":{"label":"Div soup","code":"<div class=\"header\">\n  <div class=\"nav\">…</div>\n</div>\n<div class=\"main\">\n  <div class=\"article\">…</div>\n  <div class=\"aside\">…</div>\n</div>\n<div class=\"footer\">…</div>","why":"Identical on screen, but the class names mean nothing to software. There are no landmarks to jump to, and the page is one undifferentiated blob."}}'::jsonb
from public.lessons where slug = 'semantic-vs-non-semantic';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'prose'::public.block_type, NULL, 'Here is what each landmark actually means.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'semantic-vs-non-semantic';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'code_example'::public.block_type, 'The landmark elements at a glance', NULL,
       '<header>   Introductory content for the page or a section: logo, site name, main nav.
<nav>      A block of major navigation links. Not every group of links.
<main>     The unique content of this page. Exactly one per page.
<article>  A self-contained item that would still make sense on its own.
<section>  A thematic grouping — normally with a heading.
<aside>    Related but not essential: a sidebar, a pull quote, related links.
<footer>   Closing information for the page or section: copyright, contact.
<address>  Contact details for the nearest article or the whole page.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'semantic-vs-non-semantic';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'callout'::public.block_type, 'The `<main>` rule', 'Exactly one `<main>` per page, and it must not sit inside `<article>`, `<aside>`, `<header>`, `<footer>` or `<nav>`. It holds what makes *this* page different from every other page on the site — so the repeated header and footer stay outside it.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'semantic-vs-non-semantic';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'interactive_demo'::public.block_type, 'What a screen reader announces', 'The same two pages, heard rather than seen.',
       NULL, NULL, NULL, '{"variants":[{"label":"With landmarks","code":"<header><nav aria-label=\"Main\"><ul><li><a href=\"#\">Home</a></li></ul></nav></header>\n<main><h1>Prices</h1><p>From £6 an hour.</p></main>\n<footer><p>© 2026</p></footer>","note":"Landmarks list: banner, navigation \"Main\", main, contentinfo. The user jumps straight to main."},{"label":"Without","code":"<div><div><ul><li><a href=\"#\">Home</a></li></ul></div></div>\n<div><h1>Prices</h1><p>From £6 an hour.</p></div>\n<div><p>© 2026</p></div>","note":"Landmarks list: empty. The only way through is to read from the top, every time."}]}'::jsonb
from public.lessons where slug = 'semantic-vs-non-semantic';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'callout'::public.block_type, '`<div>` is not forbidden', 'It is the right answer when you need a container purely for layout and no semantic element describes the content. The mistake is reaching for it *first*. Ask "what is this?" — and use `<div>` only when the honest answer is "just a box".',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'semantic-vs-non-semantic';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'Do landmarks replace ARIA roles?', 'Yes, and that is the point. `<header>` already has the `banner` role, `<nav>` has `navigation`, `<main>` has `main`, `<footer>` has `contentinfo`. Writing `<div role="banner">` achieves the same thing with more code and none of the other behaviour the real element brings. This is the first appearance of a rule that runs through the rest of the course: native HTML first, ARIA only where HTML cannot express what you mean.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'semantic-vs-non-semantic';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Semantic elements name what their content is; `<div>` and `<span>` name nothing.","Landmarks let assistive technology jump straight to a region of the page.","Exactly one `<main>`, holding what is unique to this page.","Use `<div>` when no semantic element fits — but ask the question first."],"nextUp":"Next: sections, articles, and the ones people get wrong."}'::jsonb
from public.lessons where slug = 'semantic-vs-non-semantic';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'landmarks-guided', 1, 'guided'::public.exercise_kind, 'Replace the divs with landmarks',
       'Rewrite this page using semantic landmark elements instead of divs. The class names tell you which element each one should become.', '<div class="header">
  <div class="nav">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="prices.html">Prices</a></li>
    </ul>
  </div>
</div>
<div class="main">
  <h1>Prices</h1>
  <p>Hourly hire starts at £6.</p>
</div>
<div class="footer">
  <p>© 2026 Riverside Cycle Hire</p>
</div>', '<header>
  <nav aria-label="Main">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="prices.html">Prices</a></li>
    </ul>
  </nav>
</header>
<main>
  <h1>Prices</h1>
  <p>Hourly hire starts at £6.</p>
</main>
<footer>
  <p>© 2026 Riverside Cycle Hire</p>
</footer>', ARRAY['div class="header" becomes <header>, and so on for each one.', 'The nav should also get an aria-label so it can be told apart from other navs.', 'Remove the class attributes — the element names now carry the meaning.']::text[],
       45, 2,
       (select id from public.skills where slug = 'semantic-html'), false
from public.lessons l where l.slug = 'semantic-vs-non-semantic'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main element', NULL, 1, true
from public.exercises e where e.slug = 'landmarks-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'The page has a header landmark', NULL, 1, true
from public.exercises e where e.slug = 'landmarks-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'nav', NULL,
       NULL, NULL, NULL, NULL,
       'The navigation uses a nav element', NULL, 1, true
from public.exercises e where e.slug = 'landmarks-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'The page has a footer landmark', NULL, 1, true
from public.exercises e where e.slug = 'landmarks-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'div', NULL,
       NULL, NULL, 0, 0,
       'No generic divs remain', NULL, 1, true
from public.exercises e where e.slug = 'landmarks-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside main', NULL, 1, true
from public.exercises e where e.slug = 'landmarks-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav is labelled', NULL, 1, true
from public.exercises e where e.slug = 'landmarks-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'semantic-vs-non-semantic'), NULL, 'q-semantic-meaning', 1, 'single'::public.question_kind,
        'What makes an element "semantic"?', 'Its name describes what the content is, so software can act on that meaning.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It can hold other elements', false, NULL
from public.quiz_questions where slug = 'q-semantic-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It is newer than HTML 4', false, NULL
from public.quiz_questions where slug = 'q-semantic-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Its name describes what the content is', true, NULL
from public.quiz_questions where slug = 'q-semantic-meaning';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It has default styling applied', false, NULL
from public.quiz_questions where slug = 'q-semantic-meaning';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'semantic-vs-non-semantic'), NULL, 'q-main-count', 2, 'single'::public.question_kind,
        'How many `<main>` elements should a page have?', 'One. It holds the content unique to that page.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'None — main is optional and rarely used', false, NULL
from public.quiz_questions where slug = 'q-main-count';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Exactly one', true, NULL
from public.quiz_questions where slug = 'q-main-count';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'One per section', false, NULL
from public.quiz_questions where slug = 'q-main-count';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'As many as the layout needs', false, NULL
from public.quiz_questions where slug = 'q-main-count';
-- lesson: Section, article and aside
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'section-article-aside', 2, 'Section, article and aside', 'The three that are most often confused', 'Two simple tests settle almost every case: could it stand alone, and does it have a heading?',
       ARRAY['Decide between section, article and div', 'Use aside for genuinely tangential content', 'Understand what a document outline is and is not']::text[], 14, 40, (select id from public.skills where slug = 'semantic-html'), 0.7
from public.modules m where m.slug = 'semantic-landmarks'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Apply the \"would it make sense alone?\" test for <article>","Apply the \"does it have a heading?\" test for <section>","Use <aside> correctly and sparingly"]}'::jsonb
from public.lessons where slug = 'section-article-aside';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, '`<article>` is for something self-contained: a blog post, a news item, a product card, a single review, a comment. The test is whether it would still make sense if you lifted it out and put it somewhere else — in a feed reader, or in a search result.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'section-article-aside';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, '`<section>` is a thematic grouping within a larger document. The test is whether it has, or could sensibly have, its own heading. If you cannot write a heading for it, it is almost certainly not a section — it is a `<div>`.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'section-article-aside';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'Two self-contained articles in a listing page', NULL,
       '<main>
  <h1>Route guides</h1>

  <article>
    <h2>The valley route</h2>
    <p>Twenty-four miles, mostly flat.</p>
  </article>

  <article>
    <h2>The harbour loop</h2>
    <p>Six miles, entirely traffic-free.</p>
  </article>
</main>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'section-article-aside';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'One article, divided into sections, with an aside', NULL,
       '<article>
  <h1>The valley route</h1>

  <section>
    <h2>Getting there</h2>
    <p>The route starts at the workshop on Mill Lane.</p>
  </section>

  <section>
    <h2>What to expect</h2>
    <p>One long climb near the reservoir; the rest is flat.</p>
  </section>

  <aside>
    <h2>Bike hire</h2>
    <p>We hire hybrids suited to this route from £22 a day.</p>
  </aside>
</article>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'section-article-aside';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<aside aria-label="Related routes">
  <h2>You might also like</h2>
  <ul>
    <li><a href="harbour.html">The harbour loop</a></li>
  </ul>
</aside>', 'html', NULL, '{"annotations":[{"line":"1","text":"`<aside>` means \"related to the content around it, but not part of it\". Removing it should not damage the main content."},{"line":"1","text":"An `aria-label` names the landmark, so a screen reader announces \"complementary, Related routes\" rather than just \"complementary\"."},{"line":"2","text":"A heading inside an aside is good practice — it tells everyone what the aside is for."}]}'::jsonb
from public.lessons where slug = 'section-article-aside';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, '`<section>` is not a styling wrapper', 'Using `<section>` where you mean "a box" adds a meaningless region to the page''s structure. If it has no heading and no thematic identity, use `<div>`. There is no penalty for a `<div>` in the right place, but there is a real cost to a `<section>` in the wrong one.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'section-article-aside';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'section, article or div?', 'Three candidates for the same block of markup.',
       NULL, NULL, NULL, '{"variants":[{"label":"article — correct","code":"<article>\n  <h2>Slow-roast lamb</h2>\n  <p>Served with charred aubergine.</p>\n</article>","note":"A menu item is self-contained and would make sense on its own. article is right."},{"label":"section — correct","code":"<section>\n  <h2>Main courses</h2>\n  <p>All served with bread.</p>\n</section>","note":"A themed part of the menu page, with its own heading. section is right."},{"label":"div — correct","code":"<div class=\"price-badge\">\n  <span>£18</span>\n</div>","note":"Just a box for styling, with no heading and no theme. div is right."}]}'::jsonb
from public.lessons where slug = 'section-article-aside';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'progressive_detail'::public.block_type, 'The document outline algorithm', 'Older material said that `<section>` created a new heading level automatically, so you could use `<h1>` everywhere and the nesting would sort it out. That algorithm was never implemented by any browser or screen reader, and it has been removed from the specification. Set heading levels explicitly: an `<h2>` is an `<h2>` no matter how deeply it is nested. If you read otherwise on an older tutorial, it is out of date.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'section-article-aside';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'checklist'::public.block_type, 'Choosing a container', NULL,
       NULL, NULL, NULL, '{"items":["Would it make sense lifted out of the page? → `<article>`","Is it a themed part of a larger whole, with a heading? → `<section>`","Is it related but not essential? → `<aside>`","Is it just a box for layout? → `<div>`"]}'::jsonb
from public.lessons where slug = 'section-article-aside';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<article>` = self-contained; `<section>` = themed group with a heading.","`<aside>` = related but removable without damaging the content.","`<div>` is correct when nothing else fits — that is what it is for.","Heading levels are always explicit; sectioning does not adjust them."],"nextUp":"Next: file organisation and repeated page patterns."}'::jsonb
from public.lessons where slug = 'section-article-aside';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'section-article-guided', 1, 'guided'::public.exercise_kind, 'Choose the right containers',
       'Rewrite this listing page. The two route entries are self-contained items; the block introducing them is a themed part of the page; the hire offer is related but tangential.', '<main>
  <h1>Route guides</h1>
  <div>
    <h2>Easy routes</h2>
    <p>Both of these are flat and traffic-free.</p>
  </div>
  <div>
    <h3>The harbour loop</h3>
    <p>Six miles from the workshop door.</p>
  </div>
  <div>
    <h3>The mill and back</h3>
    <p>Eleven miles, one gentle climb.</p>
  </div>
  <div>
    <h2>Bike hire</h2>
    <p>Hybrids from £22 a day.</p>
  </div>
</main>', '<main>
  <h1>Route guides</h1>
  <section>
    <h2>Easy routes</h2>
    <p>Both of these are flat and traffic-free.</p>

    <article>
      <h3>The harbour loop</h3>
      <p>Six miles from the workshop door.</p>
    </article>

    <article>
      <h3>The mill and back</h3>
      <p>Eleven miles, one gentle climb.</p>
    </article>
  </section>

  <aside aria-label="Bike hire">
    <h2>Bike hire</h2>
    <p>Hybrids from £22 a day.</p>
  </aside>
</main>', ARRAY['The two routes are self-contained items — each becomes an <article>.', 'The "Easy routes" block groups them under a heading — that is a <section>.', 'The hire offer is related but not part of the guides — that is an <aside>.']::text[],
       50, 3,
       (select id from public.skills where slug = 'semantic-html'), false
from public.lessons l where l.slug = 'section-article-aside'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'article', NULL,
       NULL, NULL, 2, 2,
       'The two routes are articles', NULL, 1, true
from public.exercises e where e.slug = 'section-article-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_present'::public.requirement_kind, 'section', NULL,
       NULL, NULL, NULL, NULL,
       'The themed group uses a section', NULL, 1, true
from public.exercises e where e.slug = 'section-article-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'aside', NULL,
       NULL, NULL, NULL, NULL,
       'The tangential content uses an aside', NULL, 1, true
from public.exercises e where e.slug = 'section-article-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'main > div, section > div', NULL,
       NULL, NULL, 0, 0,
       'No meaningless divs remain', NULL, 1, true
from public.exercises e where e.slug = 'section-article-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'section-article-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'section-article-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'section-debug', 2, 'debug'::public.exercise_kind, 'Sections that should not be sections',
       'This page uses `<section>` for two things that are not sections: a styling wrapper with no heading, and a self-contained review. Fix both, and give the aside an accessible name.', '<main>
  <h1>Customer reviews</h1>
  <section class="layout-wrapper">
    <section>
      <h2>"Excellent service"</h2>
      <p>Booked a bike at short notice and it was ready in ten minutes.</p>
    </section>
  </section>
  <aside>
    <h2>Leave a review</h2>
    <p>We read every one.</p>
  </aside>
</main>', '<main>
  <h1>Customer reviews</h1>
  <div class="layout-wrapper">
    <article>
      <h2>"Excellent service"</h2>
      <p>Booked a bike at short notice and it was ready in ten minutes.</p>
    </article>
  </div>
  <aside aria-label="Leave a review">
    <h2>Leave a review</h2>
    <p>We read every one.</p>
  </aside>
</main>', ARRAY['The outer wrapper has no heading and exists only for layout — that is a <div>.', 'A single review is self-contained, so it is an <article>.', 'Add aria-label to the aside so screen readers can name it.']::text[],
       45, 3,
       (select id from public.skills where slug = 'semantic-html'), false
from public.lessons l where l.slug = 'section-article-aside'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'article', NULL,
       NULL, NULL, NULL, NULL,
       'The review is an article', NULL, 1, true
from public.exercises e where e.slug = 'section-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'section', NULL,
       NULL, NULL, 0, 0,
       'No misused section elements remain', NULL, 1, true
from public.exercises e where e.slug = 'section-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'aside', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The aside has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'section-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'div', NULL,
       NULL, NULL, NULL, NULL,
       'The layout wrapper is a div', NULL, 1, true
from public.exercises e where e.slug = 'section-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'section-article-aside'), NULL, 'q-article-test', 1, 'single'::public.question_kind,
        'What is the test for using `<article>`?', 'Whether the content would still make sense on its own, lifted out of the page.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Is it more than three paragraphs long?', false, NULL
from public.quiz_questions where slug = 'q-article-test';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Does it contain an image?', false, NULL
from public.quiz_questions where slug = 'q-article-test';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Is it written by a named author?', false, NULL
from public.quiz_questions where slug = 'q-article-test';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Would it make sense on its own, outside this page?', true, NULL
from public.quiz_questions where slug = 'q-article-test';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'section-article-aside'), NULL, 'q-section-heading', 2, 'single'::public.question_kind,
        'You have a container with no heading and no theme, used only for layout. What should it be?', '`<div>`. Using `<section>` would add a meaningless region to the page structure.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<article>', false, NULL
from public.quiz_questions where slug = 'q-section-heading';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<aside>', false, NULL
from public.quiz_questions where slug = 'q-section-heading';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<div>', true, NULL
from public.quiz_questions where slug = 'q-section-heading';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<section>', false, NULL
from public.quiz_questions where slug = 'q-section-heading';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'section-article-aside'), NULL, 'q-outline-algorithm', 3, 'single'::public.question_kind,
        'Does nesting a heading inside a `<section>` change its level?', 'No. The outline algorithm that would have done this was never implemented and has been removed from the specification. Always set levels explicitly.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'No — always set heading levels explicitly', true, NULL
from public.quiz_questions where slug = 'q-outline-algorithm';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Yes, each section demotes headings by one level', false, NULL
from public.quiz_questions where slug = 'q-outline-algorithm';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only in browsers that support HTML5 outlines', false, NULL
from public.quiz_questions where slug = 'q-outline-algorithm';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only for h1 elements', false, NULL
from public.quiz_questions where slug = 'q-outline-algorithm';
-- module: Organising a real project
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'organising-a-project', 2, 'Organising a real project', 'Folder structure, naming conventions, repeated page patterns, and the Level 5 milestone rebuild.',
       45, true
from public.levels l where l.slug = 'structure-professional'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'organising-a-project' and p.slug = 'semantic-landmarks';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.7
from public.modules m, public.skills s
where m.slug = 'organising-a-project' and s.slug = 'semantic-html';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'organising-a-project' and s.slug = 'maintainability';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.6
from public.modules m, public.skills s
where m.slug = 'organising-a-project' and s.slug = 'multi-page';
-- lesson: File organisation and reusable patterns
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'file-organisation-and-patterns', 1, 'File organisation and reusable patterns', 'Structure that still makes sense at page forty', 'Every professional site has conventions. Adopting them now costs nothing and saves a great deal later.',
       ARRAY['Lay out a project folder that scales', 'Apply consistent naming conventions', 'Recognise repeated patterns and keep them identical']::text[], 13, 40, (select id from public.skills where slug = 'maintainability'), 0.7
from public.modules m where m.slug = 'organising-a-project'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Design a folder structure for a multi-page site","Apply naming conventions that avoid server-specific bugs","Keep repeated page furniture consistent across a site"]}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'visual'::public.block_type, NULL, 'A project laid out so that paths stay predictable.',
       NULL, NULL, 'file-paths', '{}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'A structure that still works at forty pages', NULL,
       'my-site/
├── index.html
├── about.html
├── contact.html
├── 404.html                custom "page not found"
├── favicon.svg
├── assets/
│   ├── css/
│   │   └── site.css
│   ├── images/
│   │   ├── hero-workshop.jpg
│   │   └── logo.svg
│   ├── media/
│   │   ├── tour.mp4
│   │   └── tour.en.vtt
│   └── files/
│       └── price-list-2026.pdf
└── routes/
    ├── index.html
    ├── valley.html
    └── harbour.html', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'checklist'::public.block_type, 'Conventions worth adopting permanently', NULL,
       NULL, NULL, NULL, '{"items":["Lowercase filenames — some servers are case-sensitive, some are not; assume the strict one","Hyphens, never spaces or underscores, in filenames","One `index.html` per folder, so `/routes/` works as a URL","All assets under `assets/`, grouped by type","Descriptive names: `hero-workshop.jpg`, not `IMG_4821.jpg`","A `404.html` so a mistyped URL is still helpful"]}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'The case-sensitivity trap', 'Most Windows and macOS setups treat `About.html` and `about.html` as the same file. Most Linux servers do not. A site that works perfectly on your laptop can 404 the moment it is deployed. Lowercase everything and the problem disappears permanently.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'prose'::public.block_type, NULL, 'The other half of maintainability is repetition. Your header, navigation and footer appear on every page. Keeping them byte-for-byte identical is what makes a site feel coherent — and it is the thing hand-written sites get wrong first.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'comparison'::public.block_type, 'Two ways of writing the same page furniture', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Consistent","code":"<!-- Site header — identical on every page -->\n<header>\n  <a href=\"/\" class=\"logo\">Riverside</a>\n  <nav aria-label=\"Main\">…</nav>\n</header>","why":"A comment marks the block as shared, so the next person knows to change it everywhere."},"bad":{"label":"Drifted","code":"<!-- page 1 -->\n<header><nav aria-label=\"Main\">…</nav></header>\n\n<!-- page 2 -->\n<div class=\"top\"><nav>…</nav></div>","why":"The same region, written two different ways. Screen-reader users lose the landmark on page two, and every future change has to be made twice."}}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'term'::public.block_type, 'Progressive disclosure of complexity', 'Hand-copying shared markup is fine for a handful of pages. Beyond that, professionals use a template system or a static site generator that writes the repetition for them. Knowing *why* the repetition exists is what lets you pick the right tool later.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'callout'::public.block_type, 'Comment the boundaries, not the obvious', 'A comment saying `<!-- Site header — keep identical across pages -->` earns its place. A comment saying `<!-- paragraph -->` above a `<p>` does not. Write comments for decisions and boundaries, never for restating what the code already says.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'progressive_detail'::public.block_type, 'Avoiding unnecessary containers', 'Every extra wrapper is a line someone has to read, and a level of nesting that makes a missing closing tag harder to find. Before adding a `<div>`, check whether the element you already have could carry the styling instead. A page that is five levels deep where three would do is not "more structured" — it is just harder to change.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Lowercase, hyphenated filenames avoid an entire class of deployment bug.","Group assets by type under one folder.","Keep shared page furniture byte-for-byte identical.","Add a container only when it earns its place."],"nextUp":"Next: the Level 5 milestone rebuild."}'::jsonb
from public.lessons where slug = 'file-organisation-and-patterns';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'patterns-guided', 1, 'guided'::public.exercise_kind, 'Make two pages consistent',
       'This is the header from page two of a site. Page one uses `<header>`, a labelled `<nav>` and a `<ul>` of links. Rewrite this one to match exactly.', '<div class="top">
  <nav>
    <a href="index.html">Home</a>
    <a href="about.html">About</a>
    <a href="contact.html">Contact</a>
  </nav>
</div>', '<header>
  <nav aria-label="Main">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="about.html">About</a></li>
      <li><a href="contact.html">Contact</a></li>
    </ul>
  </nav>
</header>', ARRAY['The wrapper should be a <header>, not a div.', 'The nav needs aria-label="Main" to match page one.', 'Wrap the links in a <ul> with one <li> each.']::text[],
       40, 2,
       (select id from public.skills where slug = 'maintainability'), false
from public.lessons l where l.slug = 'file-organisation-and-patterns'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'The wrapper is a header landmark', NULL, 1, true
from public.exercises e where e.slug = 'patterns-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'nav', 'aria-label',
       'Main', NULL, NULL, NULL,
       'The nav is labelled "Main"', NULL, 1, true
from public.exercises e where e.slug = 'patterns-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 3, 3,
       'Three links, each in a list item', NULL, 1, true
from public.exercises e where e.slug = 'patterns-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'div', NULL,
       NULL, NULL, 0, 0,
       'The generic div has been replaced', NULL, 1, true
from public.exercises e where e.slug = 'patterns-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'file-organisation-and-patterns'), NULL, 'q-case-sensitivity', 1, 'single'::public.question_kind,
        'Why use lowercase filenames?', 'Linux servers are case-sensitive while many development machines are not, so mixed case works locally and 404s in production.', (select id from public.skills where slug = 'multi-page'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Lowercase files load faster', false, NULL
from public.quiz_questions where slug = 'q-case-sensitivity';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'HTML requires it', false, NULL
from public.quiz_questions where slug = 'q-case-sensitivity';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Many servers are case-sensitive even when your computer is not', true, NULL
from public.quiz_questions where slug = 'q-case-sensitivity';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Uppercase letters are invalid in URLs', false, NULL
from public.quiz_questions where slug = 'q-case-sensitivity';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'file-organisation-and-patterns'), NULL, 'q-comments-value', 2, 'single'::public.question_kind,
        'Which comment is worth writing?', 'Comments should record decisions and mark boundaries, not restate what the markup already says.', (select id from public.skills where slug = 'maintainability'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<!-- Site header — keep identical across all pages -->', true, NULL
from public.quiz_questions where slug = 'q-comments-value';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<!-- paragraph -->', false, NULL
from public.quiz_questions where slug = 'q-comments-value';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<!-- div -->', false, NULL
from public.quiz_questions where slug = 'q-comments-value';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<!-- closing tag below -->', false, NULL
from public.quiz_questions where slug = 'q-comments-value';
-- lesson: Milestone: rebuild an unstructured page
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'semantic-rebuild-milestone', 2, 'Milestone: rebuild an unstructured page', 'Take div soup and turn it into professional markup', 'A real page, written badly. Your job is to rebuild it properly without changing a word of the content.',
       ARRAY['Convert a non-semantic page into a landmark-based structure', 'Fix the heading hierarchy at the same time', 'Justify every element choice you make']::text[], 30, 40, (select id from public.skills where slug = 'semantic-html'), 0.8
from public.modules m where m.slug = 'organising-a-project'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Rebuild a div-based page using correct landmarks","Repair the heading hierarchy","Produce markup you would be happy to hand to a colleague"]}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'The page in the exercise below is the kind you meet constantly in real work: it looks acceptable, and the markup underneath says nothing at all. Rebuilding it is the single most useful exercise in this level.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'checklist'::public.block_type, 'Your rebuild must have', NULL,
       NULL, NULL, NULL, '{"items":["A `<header>` containing the site name and the main `<nav>`","Exactly one `<main>`, with an `id` a skip link can target","The self-contained items as `<article>` elements","The tangential block as an `<aside>` with an accessible name","A `<footer>` outside `<main>`","A correct heading hierarchy: one `<h1>`, no skipped levels","No `<div>` where a semantic element fits"]}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Work outside in', 'Identify the landmarks first — header, main, footer. Then work down through what is inside each one. Trying to fix the innermost elements before the outer structure is settled means doing the work twice.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'The same region, before and after a rebuild', NULL,
       NULL, NULL, NULL, '{"good":{"label":"After — semantic","code":"<article>\n  <h2>The valley route</h2>\n  <p>Twenty-four miles, mostly flat.</p>\n</article>","why":"A screen reader announces an article with a heading. Search engines can identify the item. The class names are gone because the elements now carry the meaning."},"bad":{"label":"Before — div soup","code":"<div class=\"card\">\n  <div class=\"card-title\">The valley route</div>\n  <p>Twenty-four miles, mostly flat.</p>\n</div>","why":"Identical on screen. No heading in the outline, no landmark to jump to, and the \"card-title\" class means nothing to any software."}}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'visual'::public.block_type, NULL, 'The structure you are rebuilding towards.',
       NULL, NULL, 'semantic-landmarks', '{}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["You can now read an unstructured page and see the structure it should have had.","Landmarks first, then content elements, then headings.","This is the skill that most visibly separates professional markup from amateur markup."],"nextUp":"Level 6 next: tables and forms."}'::jsonb
from public.lessons where slug = 'semantic-rebuild-milestone';

commit;
