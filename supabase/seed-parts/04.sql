-- HTML Hero — course seed, part 4 of 7
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
        'Should you lazy-load the main image at the top of a page?', 'No. It is visible immediately, so lazy-loading delays the most important image and measurably worsens perceived load speed.', (select id from public.skills where slug = 'performance'), 10);
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
        'When do you need `<picture>` rather than `srcset` on an `<img>`?', 'When the files genuinely differ — a different format the browser might not support, or a different crop.', (select id from public.skills where slug = 'responsive-images'), 10);
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
from public.levels l where l.slug = 'media-specialist';
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
from public.modules m where m.slug = 'video-audio-embeds';
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
from public.lessons l where l.slug = 'video-and-audio';
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
from public.lessons l where l.slug = 'video-and-audio';
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
        'What happens if you omit `controls` from a `<video>`?', 'There is no way for the visitor to play, pause or mute it without JavaScript. It is the single most common video mistake.', (select id from public.skills where slug = 'audio-video'), 10);
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
        'What is the difference between captions and subtitles?', 'Captions include non-speech sound and are for viewers who cannot hear the audio. Subtitles translate dialogue for viewers who can hear but do not understand the language.', (select id from public.skills where slug = 'audio-video'), 10);
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
        'Where does fallback content go inside a `<video>`?', 'After the `<source>` and `<track>` elements. Browsers that can play video ignore it; browsers that cannot display it instead.', (select id from public.skills where slug = 'audio-video'), 10);
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
from public.modules m where m.slug = 'video-audio-embeds';
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
from public.lessons l where l.slug = 'iframes-and-media-milestone';
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
from public.lessons l where l.slug = 'iframes-and-media-milestone';
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
from public.lessons l where l.slug = 'iframes-and-media-milestone';
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
        'Why does an `<iframe>` need a `title`?', 'Without it, a screen reader announces only "frame" with no indication of what the embedded content is.', (select id from public.skills where slug = 'accessibility'), 10);
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
        'What does `sandbox=""` on an iframe do?', 'An empty sandbox removes essentially every capability. Each `allow-` token you add restores one.', (select id from public.skills where slug = 'security'), 10);
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
        'Which attributes are required on every `<img>`?', '`src` says which file; `alt` provides the text alternative. Both are required.', (select id from public.skills where slug = 'images'), 10);
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
        'An image is purely decorative. What should its alt be?', '`alt=""` tells screen readers to skip it. The attribute must still be present.', (select id from public.skills where slug = 'images'), 10);
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
        'What does `1200w` mean in a srcset?', 'It describes the candidate file: this file is 1200 pixels wide.', (select id from public.skills where slug = 'responsive-images'), 10);
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
        'Which element is required inside a `<picture>`?', 'The `<img>` is what actually renders and carries the alt text.', (select id from public.skills where slug = 'responsive-images'), 10);
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
        'Which image should NOT have `loading="lazy"`?', 'The hero image is visible immediately, so lazy-loading it delays the most important content on the page.', (select id from public.skills where slug = 'performance'), 10);
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
        'What does `<track kind="captions">` provide?', 'A timed text file carrying dialogue and important non-speech sound, for viewers who cannot hear the audio.', (select id from public.skills where slug = 'audio-video'), 10);
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
        'Why is autoplaying video with sound a problem?', 'It plays over a screen reader''s voice, startles users, and is distressing for people with sensory sensitivities. Browsers block it by default.', (select id from public.skills where slug = 'accessibility'), 10);
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
        'Where does an iframe''s accessible name come from?', 'The `title` attribute on the iframe itself.', (select id from public.skills where slug = 'accessibility'), 10);
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
        'Where does a `<video>`''s fallback content go?', 'Inside the video element, after the source and track elements.', (select id from public.skills where slug = 'audio-video'), 10);
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
from public.courses c where c.slug = 'html-hero';
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-5-milestone', 'milestone'::public.assessment_kind, 'Level 5 milestone: Structure Professional', 'Eight questions on semantic structure and project organisation. Pass mark 75%.',
       0.75, 170, 5
from public.levels l where l.slug = 'structure-professional';
-- module: Semantic elements and page landmarks
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'semantic-landmarks', 1, 'Semantic elements and page landmarks', 'header, nav, main, section, article, aside, footer — what each one means and, just as importantly, when not to use it.',
       50, false
from public.levels l where l.slug = 'structure-professional';
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
from public.modules m where m.slug = 'semantic-landmarks';
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
from public.lessons l where l.slug = 'semantic-vs-non-semantic';
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
        'What makes an element "semantic"?', 'Its name describes what the content is, so software can act on that meaning.', (select id from public.skills where slug = 'semantic-html'), 10);
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
        'How many `<main>` elements should a page have?', 'One. It holds the content unique to that page.', (select id from public.skills where slug = 'semantic-html'), 10);
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
from public.modules m where m.slug = 'semantic-landmarks';
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
from public.lessons l where l.slug = 'section-article-aside';
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
from public.lessons l where l.slug = 'section-article-aside';
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
        'What is the test for using `<article>`?', 'Whether the content would still make sense on its own, lifted out of the page.', (select id from public.skills where slug = 'semantic-html'), 10);
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
        'You have a container with no heading and no theme, used only for layout. What should it be?', '`<div>`. Using `<section>` would add a meaningless region to the page structure.', (select id from public.skills where slug = 'semantic-html'), 10);
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
        'Does nesting a heading inside a `<section>` change its level?', 'No. The outline algorithm that would have done this was never implemented and has been removed from the specification. Always set levels explicitly.', (select id from public.skills where slug = 'semantic-html'), 10);
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
from public.levels l where l.slug = 'structure-professional';
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
from public.modules m where m.slug = 'organising-a-project';
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
from public.lessons l where l.slug = 'file-organisation-and-patterns';
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
        'Why use lowercase filenames?', 'Linux servers are case-sensitive while many development machines are not, so mixed case works locally and 404s in production.', (select id from public.skills where slug = 'multi-page'), 10);
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
        'Which comment is worth writing?', 'Comments should record decisions and mark boundaries, not restate what the markup already says.', (select id from public.skills where slug = 'maintainability'), 10);
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
from public.modules m where m.slug = 'organising-a-project';
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
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'semantic-rebuild', 1, 'challenge'::public.exercise_kind, 'Milestone: rebuild the page',
       'Rebuild this page with correct semantic structure and a valid heading hierarchy. Keep every word of the content exactly as it is — only the markup changes.', '<div id="top">
  <span class="brand">Riverside Cycle Hire</span>
  <div class="menu">
    <a href="index.html">Home</a>
    <a href="routes.html">Routes</a>
    <a href="contact.html">Contact</a>
  </div>
</div>

<div id="content">
  <div class="title">Route guides</div>

  <div class="card">
    <div class="card-title">The valley route</div>
    <p>Twenty-four miles, mostly flat, one long climb near the reservoir.</p>
  </div>

  <div class="card">
    <div class="card-title">The harbour loop</div>
    <p>Six miles, entirely traffic-free, suitable for children.</p>
  </div>

  <div class="side">
    <div class="side-title">Bike hire</div>
    <p>Hybrids suited to both routes, from £22 a day.</p>
  </div>
</div>

<div id="bottom">
  <p>© 2026 Riverside Cycle Hire</p>
</div>', '<header>
  <a href="index.html" class="brand">Riverside Cycle Hire</a>
  <nav aria-label="Main">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="routes.html">Routes</a></li>
      <li><a href="contact.html">Contact</a></li>
    </ul>
  </nav>
</header>

<main id="main">
  <h1>Route guides</h1>

  <article>
    <h2>The valley route</h2>
    <p>Twenty-four miles, mostly flat, one long climb near the reservoir.</p>
  </article>

  <article>
    <h2>The harbour loop</h2>
    <p>Six miles, entirely traffic-free, suitable for children.</p>
  </article>

  <aside aria-label="Bike hire">
    <h2>Bike hire</h2>
    <p>Hybrids suited to both routes, from £22 a day.</p>
  </aside>
</main>

<footer>
  <p>© 2026 Riverside Cycle Hire</p>
</footer>', ARRAY['Start with the three landmarks: #top becomes <header>, #content becomes <main>, #bottom becomes <footer>.', 'The .menu is navigation — a <nav aria-label="Main"> containing a <ul> of links.', 'Each .card is a self-contained item, so it becomes an <article> with an <h2>.', '.title is the page heading — that is your single <h1>. The .side block becomes an <aside>.']::text[],
       140, 4,
       (select id from public.skills where slug = 'semantic-html'), false
from public.lessons l where l.slug = 'semantic-rebuild-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'There is a header landmark', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main element', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'There is a footer landmark', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'nav', NULL,
       NULL, NULL, NULL, NULL,
       'The menu uses a nav element', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav is labelled', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 3, 3,
       'The three links are list items in the nav', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one h1', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'element_count'::public.requirement_kind, 'article', NULL,
       NULL, NULL, 2, 2,
       'The two route cards are articles', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'element_count'::public.requirement_kind, 'article h2', NULL,
       NULL, NULL, 2, 2,
       'Each article has an h2 heading', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'element_present'::public.requirement_kind, 'aside', NULL,
       NULL, NULL, NULL, NULL,
       'The tangential block is an aside', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'attribute_present'::public.requirement_kind, 'aside', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The aside has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside main', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'element_count'::public.requirement_kind, 'footer main, main footer', NULL,
       NULL, NULL, 0, 0,
       'The footer is outside main', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 15, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 16, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 17, 'text_not_empty'::public.requirement_kind, 'p', NULL,
       NULL, NULL, NULL, NULL,
       'All the original content survives', NULL, 1, true
from public.exercises e where e.slug = 'semantic-rebuild';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'semantic-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: give every page landmarks',
       'Rework your capstone pages so each one has `<header>`, `<nav>`, `<main id="main">` and `<footer>`, with the skip link still pointing at `#main`. This is the structure every remaining module builds on.', '<body>
  <a class="skip-link" href="#main">Skip to main content</a>

  <!-- Wrap the nav in a header -->
  <nav aria-label="Main">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="about.html">About</a></li>
      <li><a href="contact.html">Contact</a></li>
    </ul>
  </nav>

  <!-- Wrap your page content in main -->
  <h1>Your page heading</h1>
  <p>Your content.</p>

  <!-- Add a footer -->
</body>', '<body>
  <a class="skip-link" href="#main">Skip to main content</a>

  <header>
    <a href="index.html">Riverside Cycle Hire</a>
    <nav aria-label="Main">
      <ul>
        <li><a href="index.html" aria-current="page">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>
  </header>

  <main id="main">
    <h1>Riverside Cycle Hire</h1>
    <p>We rent well-maintained bikes by the hour, the day or the week.</p>
  </main>

  <footer>
    <p>© 2026 Riverside Cycle Hire</p>
  </footer>
</body>', ARRAY['The header wraps the site name and the nav together.', 'main needs id="main" so the skip link reaches it.', 'The footer goes after main, not inside it.']::text[],
       90, 3,
       (select id from public.skills where slug = 'multi-page'), false
from public.lessons l where l.slug = 'semantic-rebuild-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'The page has a header', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'nesting'::public.requirement_kind, 'nav', NULL,
       NULL, 'header', 1, NULL,
       'The navigation is inside the header', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'main', 'id',
       'main', NULL, NULL, NULL,
       'main has the id the skip link targets', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'The page has a footer', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'main footer', NULL,
       NULL, NULL, 0, 0,
       'The footer is outside main', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside main', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'The skip link still targets #main', NULL, 1, true
from public.exercises e where e.slug = 'semantic-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'semantic-rebuild-milestone'), NULL, 'q-footer-placement', 1, 'single'::public.question_kind,
        'Should the site footer be inside `<main>`?', 'No. `<main>` holds content unique to this page; the site footer is repeated on every page, so it sits outside.', (select id from public.skills where slug = 'semantic-html'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It makes no difference', false, NULL
from public.quiz_questions where slug = 'q-footer-placement';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'No — it is repeated on every page, so it goes outside main', true, NULL
from public.quiz_questions where slug = 'q-footer-placement';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Yes, main should contain the whole page', false, NULL
from public.quiz_questions where slug = 'q-footer-placement';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only if the page has no header', false, NULL
from public.quiz_questions where slug = 'q-footer-placement';
-- Level 5 milestone: Structure Professional questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q1', 1, 'single'::public.question_kind,
        'Which element wraps the content unique to a page?', '`<main>`, and there should be exactly one per page.', (select id from public.skills where slug = 'semantic-html'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<section>', false, NULL
from public.quiz_questions where slug = 'a5-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<article>', false, NULL
from public.quiz_questions where slug = 'a5-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<div id="content">', false, NULL
from public.quiz_questions where slug = 'a5-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<main>', true, NULL
from public.quiz_questions where slug = 'a5-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q2', 2, 'single'::public.question_kind,
        'A blog post in a list of posts should be marked up as what?', 'It is self-contained and would make sense on its own, so `<article>`.', (select id from public.skills where slug = 'semantic-html'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<aside>', false, NULL
from public.quiz_questions where slug = 'a5-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<div>', false, NULL
from public.quiz_questions where slug = 'a5-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<article>', true, NULL
from public.quiz_questions where slug = 'a5-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<section>', false, NULL
from public.quiz_questions where slug = 'a5-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q3', 3, 'single'::public.question_kind,
        'What role does `<header>` already have, without any ARIA?', 'When it is not inside an article or section, `<header>` has the `banner` role.', (select id from public.skills where slug = 'aria'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'complementary', false, NULL
from public.quiz_questions where slug = 'a5-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'banner', true, NULL
from public.quiz_questions where slug = 'a5-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'navigation', false, NULL
from public.quiz_questions where slug = 'a5-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'main', false, NULL
from public.quiz_questions where slug = 'a5-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q4', 4, 'single'::public.question_kind,
        'When is `<div>` the right choice?', 'When you genuinely need a container for layout and no semantic element describes the content.', (select id from public.skills where slug = 'semantic-html'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'When no semantic element fits and you need a container', true, NULL
from public.quiz_questions where slug = 'a5-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Never — divs are obsolete', false, NULL
from public.quiz_questions where slug = 'a5-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Whenever you need to apply a class', false, NULL
from public.quiz_questions where slug = 'a5-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Only inside <main>', false, NULL
from public.quiz_questions where slug = 'a5-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q5', 5, 'single'::public.question_kind,
        'Does nesting an `<h2>` inside a `<section>` make it behave like an `<h3>`?', 'No. The outline algorithm was never implemented and has been removed. Heading levels are always explicit.', (select id from public.skills where slug = 'semantic-html'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Yes, sections demote headings automatically', false, NULL
from public.quiz_questions where slug = 'a5-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Only in screen readers', false, NULL
from public.quiz_questions where slug = 'a5-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only when the section has an aria-label', false, NULL
from public.quiz_questions where slug = 'a5-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'No — heading levels are always explicit', true, NULL
from public.quiz_questions where slug = 'a5-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q6', 6, 'single'::public.question_kind,
        'Why does a page with two `<nav>` elements need `aria-label` on each?', 'Otherwise a screen reader lists two identical "navigation" landmarks with no way to tell them apart.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'To give them different styling', false, NULL
from public.quiz_questions where slug = 'a5-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'To stop search engines indexing the second one', false, NULL
from public.quiz_questions where slug = 'a5-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'So they can be told apart in the landmarks list', true, NULL
from public.quiz_questions where slug = 'a5-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Because two navs are otherwise invalid', false, NULL
from public.quiz_questions where slug = 'a5-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q7', 7, 'single'::public.question_kind,
        'Which filename follows professional convention?', 'Lowercase, hyphenated, descriptive.', (select id from public.skills where slug = 'multi-page'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'doc1.pdf', false, NULL
from public.quiz_questions where slug = 'a5-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'price-list-2026.pdf', true, NULL
from public.quiz_questions where slug = 'a5-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Price List 2026.pdf', false, NULL
from public.quiz_questions where slug = 'a5-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'PriceList2026.PDF', false, NULL
from public.quiz_questions where slug = 'a5-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-5-milestone'), 'a5-q8', 8, 'single'::public.question_kind,
        'What does `<aside>` mean?', 'Content related to what surrounds it but not essential — removing it should not damage the main content.', (select id from public.skills where slug = 'semantic-html'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Related but non-essential content', true, NULL
from public.quiz_questions where slug = 'a5-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'A sidebar, defined by its position on screen', false, NULL
from public.quiz_questions where slug = 'a5-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A footnote', false, NULL
from public.quiz_questions where slug = 'a5-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Any content that is visually to one side', false, NULL
from public.quiz_questions where slug = 'a5-q8';
-- --------------------------------------------------------------------------
-- Level 6: Data and Forms Builder
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'data-and-forms', 6, 'Data and Forms Builder', 'Tables people can actually read, and forms people can actually complete',
       'Tables and forms are where HTML becomes an interface. Both are easy to write badly and not much harder to write well — the difference is knowing which handful of attributes matter.', 'You can build an accessible data table and a professional enquiry or booking form with real validation.', 'rose'
from public.courses c where c.slug = 'html-hero';
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-6-milestone', 'milestone'::public.assessment_kind, 'Level 6 milestone: Data and Forms Builder', 'Ten questions on tables, forms, validation and form security. Pass mark 75%.',
       0.75, 200, 6
from public.levels l where l.slug = 'data-and-forms';
-- module: Data tables
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'data-tables', 1, 'Data tables', 'Rows, columns, headers and scope — plus the one thing tables must never be used for.',
       40, false
from public.levels l where l.slug = 'data-and-forms';
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'data-tables' and p.slug = 'organising-a-project';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'data-tables' and s.slug = 'tables';
-- lesson: Building an accessible table
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'building-a-table', 1, 'Building an accessible table', 'caption, thead, th, scope — the four that do the work', 'A table without headers is a grid of numbers with no meaning. Four elements turn it into data.',
       ARRAY['Build a table with a caption and proper header cells', 'Use scope so header cells apply to the right row or column', 'Explain why tables must not be used for page layout']::text[], 15, 40, (select id from public.skills where slug = 'tables'), 0.7
from public.modules m where m.slug = 'data-tables';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Build a data table with caption, thead, tbody and tfoot","Apply scope=\"col\" and scope=\"row\" correctly","Explain the difference between a data table and a layout table"]}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'visual'::public.block_type, NULL, 'The parts of a data table, labelled.',
       NULL, NULL, 'table-structure', '{}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<table>
  <caption>Bike hire rates, 2026</caption>
  <thead>
    <tr>
      <th scope="col">Bike type</th>
      <th scope="col">Per hour</th>
      <th scope="col">Per day</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">Hybrid</th>
      <td>£6</td>
      <td>£22</td>
    </tr>
    <tr>
      <th scope="row">Road bike</th>
      <td>£9</td>
      <td>£34</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="3">All rates include a helmet and a lock.</td>
    </tr>
  </tfoot>
</table>', 'html', NULL, '{"annotations":[{"line":"2","text":"`<caption>` is the table''s title. It must be the first child of `<table>`, and it is announced by screen readers before the data — so the user knows what they are about to enter."},{"line":"3-9","text":"`<thead>` groups the header row. Browsers repeat it when a long table is printed."},{"line":"5","text":"`<th scope=\"col\">` means \"this heading describes the whole column below me\"."},{"line":"10-19","text":"`<tbody>` holds the data rows."},{"line":"13","text":"`<th scope=\"row\">` means \"this heading describes the row beside me\". The first cell of each row is a heading, not data — it names what the row is about."},{"line":"20-24","text":"`<tfoot>` holds summary or footnote rows. It may be written before or after `<tbody>`; browsers render it last either way."},{"line":"22","text":"`colspan=\"3\"` makes this cell span all three columns."}]}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'What `scope` actually does', 'When a screen-reader user moves to a cell containing "£34", the screen reader announces "Road bike, Per day, £34" — it reads out the row and column headings that apply. It only knows which headings those are because `scope` told it. Without `scope`, the user hears "£34" and has to remember, cell by cell, where they are.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'interactive_demo'::public.block_type, 'The same numbers, with and without headers', 'Move through the cells and imagine hearing only the value.',
       NULL, NULL, NULL, '{"variants":[{"label":"With headers and scope","code":"<table>\n  <caption>Opening hours</caption>\n  <thead><tr><th scope=\"col\">Day</th><th scope=\"col\">Opens</th><th scope=\"col\">Closes</th></tr></thead>\n  <tbody>\n    <tr><th scope=\"row\">Tuesday</th><td>8am</td><td>6pm</td></tr>\n    <tr><th scope=\"row\">Sunday</th><td>9am</td><td>4pm</td></tr>\n  </tbody>\n</table>","note":"A cell announces as \"Sunday, Closes, 4pm\". Completely clear."},{"label":"Without","code":"<table>\n  <tr><td>Day</td><td>Opens</td><td>Closes</td></tr>\n  <tr><td>Tuesday</td><td>8am</td><td>6pm</td></tr>\n  <tr><td>Sunday</td><td>9am</td><td>4pm</td></tr>\n</table>","note":"The same cell announces as \"4pm\". Four pm on which day, opening or closing?"}]}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Never use a table for page layout', 'Twenty years ago tables were the only way to build a column layout, and a great deal of old tutorial material still shows it. A layout table tells a screen reader "here is data with rows and columns" when there is no data at all, and the reading order it produces often makes no sense. Use a table only when the content is genuinely tabular — information with two axes.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'progressive_detail'::public.block_type, 'colspan and rowspan', '`colspan="2"` makes a cell occupy two columns; `rowspan="2"` makes it occupy two rows. They are useful for grouping headers, but every span makes the table harder to follow non-visually. For anything more complex than a single spanned header row, consider whether two simpler tables would serve readers better — the answer is usually yes.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'checklist'::public.block_type, 'Every data table needs', NULL,
       NULL, NULL, NULL, '{"items":["A `<caption>` as the first child, saying what the table contains","`<thead>` for the header row and `<tbody>` for the data","`<th scope=\"col\">` for column headings","`<th scope=\"row\">` where the first cell names the row","`<tfoot>` for totals or notes, if there are any"]}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<caption>` names the table and comes first.","`<th>` is a header cell; `<td>` is a data cell.","`scope=\"col\"` and `scope=\"row\"` tell screen readers which headings apply.","Tables are for data with two axes, never for layout."],"nextUp":"Next: forms."}'::jsonb
from public.lessons where slug = 'building-a-table';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'table-guided', 1, 'guided'::public.exercise_kind, 'Build an opening-hours table',
       'Build a table with a caption "Opening hours", a header row of three column headings (Day, Opens, Closes), and two data rows for Tuesday and Sunday where the day is a row heading. Use `scope` throughout.', '<table>

</table>', '<table>
  <caption>Opening hours</caption>
  <thead>
    <tr>
      <th scope="col">Day</th>
      <th scope="col">Opens</th>
      <th scope="col">Closes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">Tuesday</th>
      <td>8am</td>
      <td>6pm</td>
    </tr>
    <tr>
      <th scope="row">Sunday</th>
      <td>9am</td>
      <td>4pm</td>
    </tr>
  </tbody>
</table>', ARRAY['The <caption> comes first, immediately inside <table>.', 'The header row goes inside <thead>, with three <th scope="col"> cells.', 'Each data row starts with <th scope="row"> for the day, then two <td> cells.']::text[],
       50, 3,
       (select id from public.skills where slug = 'tables'), false
from public.lessons l where l.slug = 'building-a-table';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'table > caption', NULL,
       NULL, NULL, NULL, NULL,
       'The table has a caption as its first child', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'text_not_empty'::public.requirement_kind, 'caption', NULL,
       NULL, NULL, NULL, NULL,
       'The caption has text', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'thead', NULL,
       NULL, NULL, NULL, NULL,
       'There is a table head', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'tbody', NULL,
       NULL, NULL, NULL, NULL,
       'There is a table body', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'th[scope="col"]', NULL,
       NULL, NULL, 3, 3,
       'Three column headings with scope="col"', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_count'::public.requirement_kind, 'th[scope="row"]', NULL,
       NULL, NULL, 2, 2,
       'Two row headings with scope="row"', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'element_count'::public.requirement_kind, 'tbody td', NULL,
       NULL, NULL, 4, 4,
       'Four data cells', NULL, 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'table-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'table-debug', 2, 'debug'::public.exercise_kind, 'A table with no meaning',
       'This table uses `<td>` for everything, has no caption and no scope. Repair it so a screen-reader user can understand any single cell.', '<table>
  <tr><td>Bike type</td><td>Per hour</td><td>Per day</td></tr>
  <tr><td>Hybrid</td><td>£6</td><td>£22</td></tr>
  <tr><td>Road bike</td><td>£9</td><td>£34</td></tr>
</table>', '<table>
  <caption>Bike hire rates, 2026</caption>
  <thead>
    <tr>
      <th scope="col">Bike type</th>
      <th scope="col">Per hour</th>
      <th scope="col">Per day</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">Hybrid</th>
      <td>£6</td>
      <td>£22</td>
    </tr>
    <tr>
      <th scope="row">Road bike</th>
      <td>£9</td>
      <td>£34</td>
    </tr>
  </tbody>
</table>', ARRAY['Add a <caption> as the very first thing inside <table>.', 'The first row is headings — change those cells to <th scope="col"> and wrap the row in <thead>.', 'The first cell of each data row names the row, so it becomes <th scope="row">.']::text[],
       50, 3,
       (select id from public.skills where slug = 'tables'), false
from public.lessons l where l.slug = 'building-a-table';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'caption', NULL,
       NULL, NULL, NULL, NULL,
       'The table has a caption', NULL, 1, true
from public.exercises e where e.slug = 'table-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'th[scope="col"]', NULL,
       NULL, NULL, 3, 3,
       'The header row uses column headings', NULL, 1, true
from public.exercises e where e.slug = 'table-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'th[scope="row"]', NULL,
       NULL, NULL, 2, 2,
       'Each data row has a row heading', NULL, 1, true
from public.exercises e where e.slug = 'table-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_present'::public.requirement_kind, 'thead', NULL,
       NULL, NULL, NULL, NULL,
       'The header row is inside thead', NULL, 1, true
from public.exercises e where e.slug = 'table-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'tbody', NULL,
       NULL, NULL, NULL, NULL,
       'The data rows are inside tbody', NULL, 1, true
from public.exercises e where e.slug = 'table-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'building-a-table'), NULL, 'q-scope-col', 1, 'single'::public.question_kind,
        'What does `scope="col"` mean?', 'This header cell describes the column beneath it.', (select id from public.skills where slug = 'tables'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'This heading spans several columns', false, NULL
from public.quiz_questions where slug = 'q-scope-col';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'This heading describes the column below it', true, NULL
from public.quiz_questions where slug = 'q-scope-col';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'This cell should be displayed as a column', false, NULL
from public.quiz_questions where slug = 'q-scope-col';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'This column is sortable', false, NULL
from public.quiz_questions where slug = 'q-scope-col';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'building-a-table'), NULL, 'q-caption-position', 2, 'single'::public.question_kind,
        'Where must `<caption>` appear?', 'As the first child of `<table>`, before thead or any rows.', (select id from public.skills where slug = 'tables'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'As the first child of <table>', true, NULL
from public.quiz_questions where slug = 'q-caption-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Inside <thead>', false, NULL
from public.quiz_questions where slug = 'q-caption-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'After </table>', false, NULL
from public.quiz_questions where slug = 'q-caption-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Anywhere inside the table', false, NULL
from public.quiz_questions where slug = 'q-caption-position';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'building-a-table'), NULL, 'q-layout-tables', 3, 'single'::public.question_kind,
        'Why should you not use a table for page layout?', 'It announces "data with rows and columns" to a screen reader when there is no data, and often produces a nonsensical reading order.', (select id from public.skills where slug = 'tables'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It announces data structure where there is none', true, NULL
from public.quiz_questions where slug = 'q-layout-tables';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Tables render more slowly than divs', false, NULL
from public.quiz_questions where slug = 'q-layout-tables';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Tables cannot be styled with CSS', false, NULL
from public.quiz_questions where slug = 'q-layout-tables';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Search engines ignore table content', false, NULL
from public.quiz_questions where slug = 'q-layout-tables';
-- module: Form foundations
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'form-foundations', 2, 'Form foundations', 'The form element, labels, input types, and the grouping that makes a long form comprehensible.',
       55, false
from public.levels l where l.slug = 'data-and-forms';
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'form-foundations' and p.slug = 'data-tables';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'form-foundations' and s.slug = 'forms';
-- lesson: Labels and input types
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'labels-and-inputs', 1, 'Labels and input types', 'The single most important pairing in HTML', 'An input without a label is unusable by a screen-reader user, and harder for everyone else. Joining them takes two attributes.',
       ARRAY['Join a label to its input with for and id', 'Choose the right input type for the data', 'Explain why placeholder text is not a label']::text[], 16, 40, (select id from public.skills where slug = 'forms'), 0.7
from public.modules m where m.slug = 'form-foundations';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Write a correctly associated label and input","Choose input types that give mobile users the right keyboard","Explain the problems with using placeholder as a label"]}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'visual'::public.block_type, NULL, 'A label and its input, joined by matching for and id values.',
       NULL, NULL, 'form-anatomy', '{}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<label for="email">Email address</label>
<input type="email" id="email" name="email" autocomplete="email" required>', 'html', NULL, '{"annotations":[{"line":"1","text":"`for=\"email\"` points at the input whose `id` is `email`."},{"line":"2","text":"`type=\"email\"` gives phones an @-friendly keyboard and lets the browser check the format."},{"line":"2","text":"`id=\"email\"` is what the label points at. It must be unique on the page."},{"line":"2","text":"`name=\"email\"` is the key the value is sent under when the form is submitted. Without a `name`, the field is not sent at all."},{"line":"2","text":"`autocomplete=\"email\"` lets the browser fill it from saved details — a large convenience, and a genuine accessibility benefit for people with motor or memory difficulties."},{"line":"2","text":"`required` tells the browser the field must be filled before submission."}]}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'What a label gets you', 'Three things at once. A screen reader announces "Email address, edit text" instead of just "edit text". Clicking the *word* puts the cursor in the box — which roughly doubles the target size, and matters enormously to anyone with a tremor or using a phone one-handed. And the browser can associate validation messages with the right field.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'Label or placeholder?', NULL,
       NULL, NULL, NULL, '{"good":{"label":"A real label","code":"<label for=\"phone\">Phone number</label>\n<input type=\"tel\" id=\"phone\" name=\"phone\" autocomplete=\"tel\">","why":"Always visible, clickable, and announced by screen readers."},"bad":{"label":"Placeholder as a label","code":"<input type=\"tel\" name=\"phone\" placeholder=\"Phone number\">","why":"The text vanishes the moment typing starts, so anyone interrupted forgets what the field was. Placeholder contrast is usually too low to meet WCAG, and support in screen readers is inconsistent."}}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Placeholder is a hint, not a label', 'Use it for an *example* of the expected format — `placeholder="07700 900123"` beside a label saying "Phone number". Never use it as the only description of a field.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'prose'::public.block_type, NULL, 'Choosing the right `type` is mostly about what keyboard a phone shows and what the browser can check for you.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'code_example'::public.block_type, 'The input types you will actually use', NULL,
       'type="text"      Anything short and free-form
type="email"     Email keyboard; browser checks for an @
type="tel"       Numeric keypad; no format checking (phone formats vary too much)
type="url"       URL keyboard; browser checks for a scheme
type="number"    Numeric spinner. Only for genuine quantities — never for
                 phone numbers, card numbers or postcodes
type="password"  Characters hidden as you type
type="date"      A native date picker
type="time"      A native time picker
type="search"    A search field, with a clear button on some browsers
type="file"      A file chooser
type="hidden"    Not shown; carries a value the server needs', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'callout'::public.block_type, '`type="number"` is the wrong choice more often than you think', 'It is for quantities you might sensibly add up. Phone numbers, postcodes and card numbers are not quantities: `number` strips leading zeros, offers a spinner nobody wants, and rejects spaces and hyphens. Use `type="text"` with `inputmode="numeric"` instead — you get the numeric keypad without the damage.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'term'::public.block_type, 'inputmode', 'A hint about which on-screen keyboard to show, independent of the input type. `inputmode="numeric"` gives digits; `inputmode="decimal"` adds a decimal point.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'term'::public.block_type, 'autocomplete', 'Tells the browser what kind of information a field expects, so it can offer the user''s saved details. The values are a fixed list: `name`, `email`, `tel`, `street-address`, `postal-code`, `cc-number`, `bday`, and so on.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'progressive_detail'::public.block_type, 'Why autocomplete is an accessibility requirement', 'WCAG 2.1 introduced a success criterion called Identify Input Purpose, which requires common personal-data fields to declare their purpose programmatically. `autocomplete` is how you meet it. For someone with a cognitive disability, a motor impairment, or simply a very long email address, autofill is the difference between a form that takes ten seconds and one that takes two minutes.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Every input needs a `<label for=\"…\">` matching its `id`.","`name` is what the value is submitted under — without it the field is not sent.","Placeholder text is a hint, never a label.","Choose `type` for the keyboard and the checking it brings; use `inputmode` where `number` would hurt.","`autocomplete` is a real accessibility feature, not just a convenience."],"nextUp":"Next: grouping, selects and buttons."}'::jsonb
from public.lessons where slug = 'labels-and-inputs';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'labels-guided', 1, 'guided'::public.exercise_kind, 'Label three inputs',
       'Each input below has no label. Add a correctly associated `<label>` for each, and give each input a `name` and a suitable `autocomplete` value.', '<form>
  <input type="text" id="fullname">
  <input type="email" id="email">
  <input type="tel" id="phone">
  <button type="submit">Send</button>
</form>', '<form>
  <label for="fullname">Full name</label>
  <input type="text" id="fullname" name="fullname" autocomplete="name">

  <label for="email">Email address</label>
  <input type="email" id="email" name="email" autocomplete="email">

  <label for="phone">Phone number</label>
  <input type="tel" id="phone" name="phone" autocomplete="tel">

  <button type="submit">Send</button>
</form>', ARRAY['Each label needs for="…" matching the id of its input.', 'Add name="…" to each input, usually the same word as the id.', 'The autocomplete values here are name, email and tel.']::text[],
       45, 2,
       (select id from public.skills where slug = 'forms'), false
from public.lessons l where l.slug = 'labels-and-inputs';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'label[for]', NULL,
       NULL, NULL, 3, 3,
       'Three labels, each with a for attribute', NULL, 1, true
from public.exercises e where e.slug = 'labels-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'Every input is labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'labels-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'input', 'name',
       NULL, NULL, NULL, NULL,
       'Every input has a name so its value is submitted', NULL, 1, true
from public.exercises e where e.slug = 'labels-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'input', 'autocomplete',
       NULL, NULL, NULL, NULL,
       'Every input declares its autocomplete purpose', NULL, 1, true
from public.exercises e where e.slug = 'labels-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'labels-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'input-types-debug', 2, 'debug'::public.exercise_kind, 'Four wrong input types',
       'Each field uses a type that causes a real problem. Fix them: the email field should validate, the phone should not be a number, the postcode should not strip its formatting, and the password should be hidden.', '<form>
  <label for="email">Email address</label>
  <input type="text" id="email" name="email">

  <label for="phone">Phone number</label>
  <input type="number" id="phone" name="phone">

  <label for="postcode">Postcode</label>
  <input type="number" id="postcode" name="postcode">

  <label for="password">Password</label>
  <input type="text" id="password" name="password">
</form>', '<form>
  <label for="email">Email address</label>
  <input type="email" id="email" name="email" autocomplete="email">

  <label for="phone">Phone number</label>
  <input type="tel" id="phone" name="phone" inputmode="tel" autocomplete="tel">

  <label for="postcode">Postcode</label>
  <input type="text" id="postcode" name="postcode" autocomplete="postal-code">

  <label for="password">Password</label>
  <input type="password" id="password" name="password" autocomplete="current-password">
</form>', ARRAY['The email field should be type="email" so the browser checks for an @.', 'Phone numbers are not quantities — use type="tel".', 'A postcode contains letters and a space, so type="text" is correct.', 'A password field must be type="password".']::text[],
       50, 3,
       (select id from public.skills where slug = 'forms'), false
from public.lessons l where l.slug = 'labels-and-inputs';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'input#email', 'type',
       'email', NULL, NULL, NULL,
       'The email field uses type="email"', NULL, 1, true
from public.exercises e where e.slug = 'input-types-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'input#phone', 'type',
       'tel', NULL, NULL, NULL,
       'The phone field uses type="tel"', NULL, 1, true
from public.exercises e where e.slug = 'input-types-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'input#postcode', 'type',
       'text', NULL, NULL, NULL,
       'The postcode field uses type="text"', NULL, 1, true
from public.exercises e where e.slug = 'input-types-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'input#password', 'type',
       'password', NULL, NULL, NULL,
       'The password field is hidden as it is typed', NULL, 1, true
from public.exercises e where e.slug = 'input-types-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'All fields remain labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'input-types-debug';

commit;
