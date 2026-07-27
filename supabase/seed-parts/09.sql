-- HTML Hero — course seed, part 9 of 10
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 8 first.

begin;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'annotated_code'::public.block_type, 'Source versus repaired DOM', NULL,
       'What you wrote:          What the Elements panel shows:

<main>                   <main>
  <section>                <section>
    <h2>Routes</h2>          <h2>Routes</h2>
  <p>Three loops.</p>        <p>Three loops.</p>    ← now inside section
</main>                    </section>
                         </main>', 'html', NULL, '{"annotations":[{"line":"1","text":"The `<section>` was never closed, so the browser assumed it should wrap everything up to `</main>`."},{"line":"4","text":"The paragraph you meant to be a sibling of the section became its child. The indentation in the panel gives it away instantly."}]}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'checklist'::public.block_type, 'A five-minute debugging routine', NULL,
       NULL, NULL, NULL, '{"items":["Open the Network panel and reload — any red lines are broken paths","Open Elements and check the indentation matches what you wrote","Tab through the page — is everything reachable, is focus visible","Select an interactive element and check its accessible name","Run the page through the W3C validator"]}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'term'::public.block_type, 'Device toolbar', 'A developer-tools mode that simulates a phone or tablet viewport. Useful for checking that responsive images and layouts behave — though it simulates size, not the real device.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'callout'::public.block_type, 'Cross-browser testing, briefly', 'Modern browsers agree on HTML far more than they used to; genuine differences are now mostly in newer features. A practical approach: build to the standard, test in one Chromium browser and one Firefox, check a real phone if you can, and consult caniuse.com before relying on anything recent. Do not write browser-specific markup — that habit causes more problems than it solves.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'progressive_detail'::public.block_type, 'Debugging as a method', 'The method that works is boring and reliable. Change one thing. Test. If it did not help, put it back. Beginners often change four things at once, see the page improve, and have no idea which change did it — so the next similar bug takes just as long. Narrow the problem before fixing it: delete half the page and see if the bug persists; if it does, the cause is in the remaining half. Three or four rounds of that will locate almost anything.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'interactive_demo'::public.block_type, 'What the inspector shows that the source does not', 'The browser repairs broken markup before you ever see it.',
       NULL, NULL, NULL, '{"variants":[{"label":"What you wrote","code":"<p>Fresh bread\n<div>Every morning</div>\n</p>","note":"A <div> inside a <p>, which is not legal. This is the source you would read in your editor."},{"label":"What the browser built","code":"<p>Fresh bread</p>\n<div>Every morning</div>\n<p></p>","note":"The parser closed the paragraph before the div and left an empty one behind. This is what the inspector shows — and why comparing the two is the fastest way to find a nesting fault."}]}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Elements shows the repaired DOM — indentation reveals unclosed tags.","Network shows broken paths as 404s with the exact URL requested.","The Accessibility panel shows computed names and roles.","Change one thing at a time, and narrow before you fix."],"nextUp":"Next: repair a whole broken site."}'::jsonb
from public.lessons where slug = 'developer-tools';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'devtools-debug', 1, 'debug'::public.exercise_kind, 'Four broken paths',
       'Every media path on this page 404s. Use the media library to find the correct paths and fix all four.', '<img src="/learning-media/images/coast-sunrise-900.jpg" alt="Sunrise over a calm sea" width="1200" height="800">
<img src="/learning-media/img/forest-path-800.jpg" alt="A sandy path between tall trees" width="800" height="534">
<video controls poster="/learning-media/posters/page-anatomy.png" width="1280" height="720">
  <source src="/learning-media/video/page-anatomy.mov" type="video/quicktime">
</video>', '<img src="/learning-media/images/coast-sunrise-800.jpg" alt="Sunrise over a calm sea" width="800" height="534">
<img src="/learning-media/images/forest-path-800.jpg" alt="A sandy path between tall trees" width="800" height="534">
<video controls poster="/learning-media/posters/page-anatomy.jpg" width="1280" height="720">
  <source src="/learning-media/video/page-anatomy.webm" type="video/webm">
  <source src="/learning-media/video/page-anatomy.mp4" type="video/mp4">
</video>', ARRAY['The library provides widths of 480, 800, 1200 and 1600 — there is no 900.', 'The folder is "images", not "img".', 'The poster is a .jpg, not a .png.', 'The video is available as .webm and .mp4, not .mov.']::text[],
       55, 3,
       (select id from public.skills where slug = 'debugging'), false
from public.lessons l where l.slug = 'developer-tools'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'local_media_path'::public.requirement_kind, 'img, source, video', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'devtools-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'img', NULL,
       NULL, NULL, 2, 2,
       'Both images are still present', NULL, 1, true
from public.exercises e where e.slug = 'devtools-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'video source', NULL,
       NULL, NULL, NULL, NULL,
       'The video still has a source', NULL, 1, true
from public.exercises e where e.slug = 'devtools-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'video', 'poster',
       NULL, NULL, NULL, NULL,
       'The video still has a poster', NULL, 1, true
from public.exercises e where e.slug = 'devtools-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every image has meaningful alternative text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'devtools-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'developer-tools'), NULL, 'q-elements-panel', 1, 'single'::public.question_kind,
        'How does the Elements panel help you find an unclosed tag?', 'It shows the repaired DOM, so an element that should be a sibling appears indented as a child — which reveals where the closing tag is missing.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It shows your original source file', false, NULL
from public.quiz_questions where slug = 'q-elements-panel';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It runs the W3C validator automatically', false, NULL
from public.quiz_questions where slug = 'q-elements-panel';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It shows the repaired DOM, where the wrong nesting is visible', true, NULL
from public.quiz_questions where slug = 'q-elements-panel';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It highlights unclosed tags in red', false, NULL
from public.quiz_questions where slug = 'q-elements-panel';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'developer-tools'), NULL, 'q-network-404', 2, 'single'::public.question_kind,
        'Which panel shows a broken image path?', 'Network — the request appears with a 404 status and the exact URL requested.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Console only', false, NULL
from public.quiz_questions where slug = 'q-network-404';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Sources', false, NULL
from public.quiz_questions where slug = 'q-network-404';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Performance', false, NULL
from public.quiz_questions where slug = 'q-network-404';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Network', true, NULL
from public.quiz_questions where slug = 'q-network-404';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'developer-tools'), NULL, 'q-one-change', 3, 'single'::public.question_kind,
        'Why change one thing at a time when debugging?', 'Otherwise you cannot tell which change fixed it, and you learn nothing that helps with the next similar bug.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Because the validator only reports one error at a time', false, NULL
from public.quiz_questions where slug = 'q-one-change';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'So you know which change actually fixed it', true, NULL
from public.quiz_questions where slug = 'q-one-change';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Because browsers cache multiple changes', false, NULL
from public.quiz_questions where slug = 'q-one-change';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'To keep the file smaller', false, NULL
from public.quiz_questions where slug = 'q-one-change';
-- lesson: A method that finds anything
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'a-method-for-debugging', 3, 'A method that finds anything', 'Bisection, minimal reproductions, and why guessing is slower', 'Most people debug by staring and guessing. There is a method that finds any fault in a bounded number of steps, and it does not require you to be clever.',
       ARRAY['Cut a problem in half repeatedly instead of scanning it', 'Reduce a broken page to a minimal reproduction', 'State a hypothesis before changing anything']::text[], 16, 40, (select id from public.skills where slug = 'debugging'), 0.7
from public.modules m where m.slug = 'validation-and-tools'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'pretest'::public.block_type, 'Before we start — have a guess', 'A 400-line page renders wrongly somewhere. Deleting half of it and checking is a strange-looking way to start. Roughly how many checks does that take to find the fault?',
       NULL, NULL, NULL, '{"options":["About nine — each check halves what is left","About 200 — you still have to read most of it","It depends entirely on how experienced you are","Bisection does not work on markup"],"answer":"About nine. Halving 400 lines takes roughly log₂(400) ≈ 9 steps to reach a single line, regardless of how the fault looks or how much you know about it. That is the whole appeal: the method is indifferent to your familiarity with the code, it terminates in a predictable number of steps, and it cannot be defeated by a fault you would not have thought to look for."}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Apply bisection to any broken document","Build a minimal reproduction and know why it is worth the time","Debug by hypothesis rather than by alteration"]}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'prose'::public.block_type, NULL, 'Debugging feels like an intuition problem and is really a search problem. The fault is somewhere in a space, and your job is to shrink that space as fast as possible. Reading from the top shrinks it one line at a time. Halving it shrinks it exponentially.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Bisection', 'Repeatedly cutting the search space in half. Remove half the page; if the fault survives, it was in the half you kept — if it vanishes, it was in the half you removed. Either answer is progress.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'worked_example'::public.block_type, 'Finding one fault in a long page', 'A page where everything after the third section renders inside the previous heading. The cause could be anywhere. Here is the method, which never needs a guess.',
       NULL, NULL, NULL, '{"steps":[{"title":"Confirm the fault, precisely","code":"Symptom: everything from \"Prices\" onwards is\ninside the <h2> above it.","reasoning":"Write the symptom down in one sentence before touching anything. Half of all long debugging sessions are someone fixing a different problem from the one that was reported, and this step costs ten seconds."},{"title":"Delete the second half","code":"<!-- keep lines 1-200, delete 201-400 -->","reasoning":"Do not read it. Delete it. If the fault is still there, it lives in the first half; if it is gone, in the second. One action has eliminated 200 lines either way."},{"title":"Repeat on whichever half still fails","code":"1-200 → still broken\n1-100 → still broken\n1-50  → fine\n50-100 → still broken","reasoning":"Each step costs one check and halves what is left. Four steps in, the fault is somewhere in fifty lines. Notice that no understanding of the fault has been required yet — which is exactly why the method works on code you have never seen."},{"title":"Read only what is left, then state a hypothesis","code":"<h2>Prices  ← no closing tag\n\nHypothesis: the unclosed h2 swallows\neverything until the browser closes it.","reasoning":"Now reading is cheap, because there are fifty lines instead of four hundred. State what you think is wrong and what fixing it should change *before* you edit — otherwise a fix that appears to work may just have moved the symptom somewhere you are not looking."}]}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Keep a copy before you start cutting', 'Bisection means deliberately destroying the page to learn where the fault is. Copy the file first — or commit it — so that when you have found the answer you can go back to the real thing and fix that one line, rather than trying to reconstruct 400 lines from memory.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'term'::public.block_type, 'Minimal reproduction', 'The smallest piece of markup that still shows the fault. Producing one is often what solves the problem, because everything you removed was, by definition, not the cause.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'The same fault, at three sizes', 'Each of these shows the identical bug. Only one is easy to think about.',
       NULL, NULL, NULL, '{"variants":[{"label":"Minimal","code":"<h2>Prices\n<p>From £6 an hour.</p>","note":"Two lines. The missing closing tag is obvious the moment everything else is gone."},{"label":"In context","code":"<header><nav aria-label=\"Main\"><a href=\"index.html\">Home</a></nav></header>\n<main>\n  <h2>Prices\n  <p>From £6 an hour.</p>\n  <p>Helmets included.</p>\n</main>","note":"Still findable, but you are now reading past four elements that have nothing to do with it."},{"label":"The real page","code":"<header><nav aria-label=\"Main\"><a href=\"index.html\">Home</a> <a href=\"menu.html\">Menu</a> <a href=\"contact.html\">Contact</a></nav></header>\n<main>\n  <h1>Riverside Cycle Hire</h1>\n  <p>Open seven days.</p>\n  <section><h2>Routes</h2><p>Three waymarked loops.</p></section>\n  <h2>Prices\n  <p>From £6 an hour.</p>\n</main>\n<footer><p>© 2026</p></footer>","note":"The same single fault, now surrounded by correct markup that all looks equally suspicious."}]}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'callout'::public.block_type, 'Changing several things at once', 'When a fix does not work, the temptation is to change three more things and try again. Now you have four alterations and no idea which helped, which did nothing, and which introduced a second fault. Change one thing. Check. Undo it if it did not help. It feels slower and it is reliably faster.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'predict_check'::public.block_type, 'Predict, then check', 'None of these list items is closed. Before you run it: does this render as three items, one item, or fail to render?',
       '<ul>
  <li>Sourdough
  <li>Rye
  <li>Seeded
</ul>', 'html', NULL, '{"outcome":"Three items, correctly. `</li>` is genuinely optional in the HTML specification — the parser closes each item when the next one begins. This matters for debugging in a way that catches people out: when you are hunting a fault, \"there is no closing tag\" is *sometimes* the bug and sometimes entirely legal. `<li>`, `<p>`, `<td>` and `<option>` all have optional closing tags; `<div>`, `<h2>` and `<a>` do not. The validator is the reliable way to tell the two cases apart — which is why it comes before the guessing."}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'self_explain'::public.block_type, 'Explain it in your own words', 'A colleague spends an hour on a rendering fault, trying things until one works, and says bisection would have been slower because "it wastes time deleting code that is obviously fine". Write your reply.',
       NULL, NULL, NULL, '{"modelAnswer":"The word doing the work in their sentence is \"obviously\". If the fault were in code that looked wrong, they would have found it in five minutes — the reason it took an hour is precisely that the cause is somewhere they had already dismissed. Bisection is valuable because it does not care what looks fine: it eliminates half the page per check whether you understand the code or not, and reaches a single line in around nine steps for a 400-line file. Trying things until one works has no bound at all, produces no knowledge of *why* it worked, and frequently leaves a second fault behind — because several things were changed and only the symptom was checked."}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'checklist'::public.block_type, 'The method, in order', NULL,
       NULL, NULL, NULL, '{"items":["Write the symptom down in one sentence","Copy the file before you start cutting","Validate first — it may simply tell you the answer","Halve, check, halve again","Reduce to a minimal reproduction","State a hypothesis before editing","Change one thing, then check","Restore the real file and apply the single fix"]}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Debugging is a search problem: shrink the space, do not scan it.","Bisection finds a fault in a 400-line file in about nine checks, whatever the fault is.","A minimal reproduction often solves the problem by itself.","One change at a time, with a hypothesis stated first."],"nextUp":"Next: the faults you will actually meet, and how each one looks."}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Why does bisection beat reading from the top?","What should you do before you start deleting, and why?","Why change only one thing at a time?"],"points":["Reading eliminates one line per step; halving eliminates half the remaining file per step — about nine checks for 400 lines — and it works on code you have never seen, because it does not depend on recognising the fault.","Write the symptom down, and copy or commit the file. Bisection destroys the page deliberately, and you need the original back to apply the real fix.","Because with four simultaneous changes you cannot tell which one helped, which did nothing, and which quietly introduced a second fault."]}'::jsonb
from public.lessons where slug = 'a-method-for-debugging';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'bisection-debug', 1, 'debug'::public.exercise_kind, 'One fault, found by halving',
       'Everything below the "Prices" heading is being swallowed by it. Use the method: find the single unclosed element and close it. Change nothing else.', '<main>
  <h1>Riverside Cycle Hire</h1>
  <p>Open seven days a week.</p>
  <section>
    <h2>Routes</h2>
    <p>Three waymarked loops from the door.</p>
  </section>
  <h2>Prices
  <p>From £6 an hour.</p>
  <p>Helmets and route maps included.</p>
</main>', '<main>
  <h1>Riverside Cycle Hire</h1>
  <p>Open seven days a week.</p>
  <section>
    <h2>Routes</h2>
    <p>Three waymarked loops from the door.</p>
  </section>
  <h2>Prices</h2>
  <p>From £6 an hour.</p>
  <p>Helmets and route maps included.</p>
</main>', ARRAY['Delete the second half of the main and see whether the fault survives.', 'The fault is a heading that is never closed.', 'Add </h2> immediately after the word Prices.']::text[],
       45, 3,
       (select id from public.skills where slug = 'debugging'), false
from public.lessons l where l.slug = 'a-method-for-debugging'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'h2', NULL,
       NULL, NULL, 2, 2,
       'Both headings are present and correctly closed', NULL, 1, true
from public.exercises e where e.slug = 'bisection-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'h2 p', NULL,
       NULL, NULL, 0, 0,
       'No paragraph has been swallowed by a heading', NULL, 1, true
from public.exercises e where e.slug = 'bisection-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'main > p', NULL,
       NULL, NULL, 3, 3,
       'All three paragraphs sit directly in <main>', NULL, 1, true
from public.exercises e where e.slug = 'bisection-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'bisection-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'bisection-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one <main>', NULL, 1, true
from public.exercises e where e.slug = 'bisection-debug';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'minimal-reproduction-challenge', 2, 'challenge'::public.exercise_kind, 'Reduce it, then repair it',
       'This page has one structural fault. Do it the methodical way: strip out everything that is not the cause until you are left with the smallest fragment containing it — then fix that fragment. Your answer should be the reduced, repaired fragment and nothing else. Everything you can delete without losing the fault was, by definition, not the problem.', '<header>
  <nav aria-label="Main"><a href="index.html">Home</a></nav>
</header>
<main>
  <h1>Menu</h1>
  <p>Baked fresh each morning.</p>
  <section>
    <h2>Loaves</h2>
    <ul>
      <li>Sourdough</li>
      <li>Rye</li>
    </ul>
  </section>
  <div class="notice">
    <p>Closed Mondays.</p>
</main>', '<div class="notice">
  <p>Closed Mondays.</p>
</div>', ARRAY['Everything in the header, the h1 and the section renders correctly — remove it all.', 'The list is fine: <li> may legally omit its closing tag, so it is not the fault.', 'What remains is the div that is never closed. Close it.']::text[],
       55, 4,
       (select id from public.skills where slug = 'debugging'), false
from public.lessons l where l.slug = 'a-method-for-debugging'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'div', NULL,
       NULL, NULL, 1, 1,
       'The reproduction contains the single suspect element', NULL, 1, true
from public.exercises e where e.slug = 'minimal-reproduction-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'div > p', NULL,
       NULL, NULL, 1, 1,
       'The paragraph is inside the div, which is now closed', NULL, 1, true
from public.exercises e where e.slug = 'minimal-reproduction-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'nav', NULL,
       NULL, NULL, 0, 0,
       'The navigation has been removed as irrelevant', NULL, 1, true
from public.exercises e where e.slug = 'minimal-reproduction-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'h1, h2', NULL,
       NULL, NULL, 0, 0,
       'The headings have been removed as irrelevant', NULL, 1, true
from public.exercises e where e.slug = 'minimal-reproduction-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'ul, li', NULL,
       NULL, NULL, 0, 0,
       'The list has been removed as irrelevant', NULL, 1, true
from public.exercises e where e.slug = 'minimal-reproduction-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'minimal-reproduction-challenge';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'a-method-for-debugging'), NULL, 'q-bisection-steps', 1, 'single'::public.question_kind,
        'Roughly how many checks does bisection need to locate a fault in a 400-line file?', 'Each check halves what remains, so it takes about log₂(400) ≈ 9 steps regardless of the fault.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'About nine', true, NULL
from public.quiz_questions where slug = 'q-bisection-steps';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'About twenty', false, NULL
from public.quiz_questions where slug = 'q-bisection-steps';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'About two hundred', false, NULL
from public.quiz_questions where slug = 'q-bisection-steps';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It cannot be predicted', false, NULL
from public.quiz_questions where slug = 'q-bisection-steps';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'a-method-for-debugging'), NULL, 'q-minimal-repro-value', 2, 'single'::public.question_kind,
        'Why does building a minimal reproduction often solve the problem outright?', 'Everything you were able to remove was, by definition, not the cause — so what is left is the cause.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Browsers validate short documents more strictly', false, NULL
from public.quiz_questions where slug = 'q-minimal-repro-value';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It forces the browser to re-parse the page', false, NULL
from public.quiz_questions where slug = 'q-minimal-repro-value';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Everything removable was not the cause, so what remains is', true, NULL
from public.quiz_questions where slug = 'q-minimal-repro-value';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Smaller files load faster, revealing timing bugs', false, NULL
from public.quiz_questions where slug = 'q-minimal-repro-value';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'a-method-for-debugging'), NULL, 'q-one-change-at-a-time', 3, 'single'::public.question_kind,
        'Why change only one thing between checks?', 'With several simultaneous changes you cannot attribute the result, and you may introduce a new fault while masking the original.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Browsers cache multiple edits incorrectly', false, NULL
from public.quiz_questions where slug = 'q-one-change-at-a-time';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The validator only reports one error at a time', false, NULL
from public.quiz_questions where slug = 'q-one-change-at-a-time';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'It is only a stylistic preference', false, NULL
from public.quiz_questions where slug = 'q-one-change-at-a-time';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Otherwise you cannot tell which change was responsible', true, NULL
from public.quiz_questions where slug = 'q-one-change-at-a-time';
-- lesson: Milestone: repair a broken site
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'debugging-milestone', 4, 'Milestone: repair a broken site', 'Every category of fault, one page', 'A page with structural, semantic, accessibility, media and validation faults. Repair all of them.',
       ARRAY['Diagnose faults across every category covered so far', 'Repair methodically rather than by guessing', 'Verify with the checklist']::text[], 30, 40, (select id from public.skills where slug = 'debugging'), 0.85
from public.modules m where m.slug = 'validation-and-tools'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Find and fix faults across structure, semantics, media and accessibility","Work methodically from structure outwards","Verify each fix rather than assuming it worked"]}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'checklist'::public.block_type, 'Repair in this order', NULL,
       NULL, NULL, NULL, '{"items":["Document: doctype, lang, charset, viewport, title","Structure: landmarks, one main, heading hierarchy","Validation: unclosed tags, duplicate ids, invalid nesting, obsolete elements","Links: broken paths, missing hrefs, meaningless link text","Media: broken paths, missing alt, missing dimensions","Forms: labels, names, button types","Finally: run the keyboard test"]}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'callout'::public.block_type, 'Resist the urge to rewrite', 'When a page is this broken it is tempting to delete it and start again. In real work you almost never can — the content matters, and somebody else wrote it. Practising methodical repair is the point of this exercise.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'The repair order, as a working checklist', NULL,
       '1. <!DOCTYPE html>   missing?          → add it, first line
2. <html lang>       missing?          → add lang="en"
3. <title>           missing?          → every page needs its own
4. landmarks         divs everywhere?  → header, nav, main, footer
5. headings          skipped levels?   → one h1, step down one at a time
6. ids               duplicated?       → make each unique
7. nesting           div inside p?     → separate them
8. obsolete          <center>, <font>? → replace with real elements
9. media             404s? no alt?     → fix paths, describe images
10. forms            unlabelled?       → <label for> on every control', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'comparison'::public.block_type, 'One mistake, many error messages', NULL,
       NULL, NULL, NULL, '{"good":{"label":"The validator output","code":"Line 14: End tag \"main\" seen, but there were open elements.\nLine 9:  Unclosed element \"section\".\nLine 15: Stray end tag \"div\".","why":"Three messages. Fix the one on line 9 and re-run — the other two usually vanish with it."},"bad":{"label":"The actual fault","code":"<main>\n  <section>          ← opened on line 9\n    <h2>Routes</h2>\n</main>              ← never closed","why":"A single missing closing tag. This is why you fix the first error and re-validate rather than working down the list."}}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'interactive_demo'::public.block_type, 'Where each kind of fault shows up', 'The same page, seen through three different tools.',
       NULL, NULL, NULL, '{"variants":[{"label":"The validator finds it","code":"<main>\n  <section>\n    <h2>Routes</h2>\n</main>","note":"Unclosed section. A grammar fault, so the validator names it directly — always the cheapest check to run first."},{"label":"Only the keyboard finds it","code":"<main>\n  <h1>Book a table</h1>\n  <div class=\"button\">Book now</div>\n</main>","note":"Perfectly valid. Nothing but tabbing through the page reveals that the control cannot be reached at all."},{"label":"Only the network panel finds it","code":"<img src=\"/learning-media/images/does-not-exist.jpg\" alt=\"A tidy studio desk\" width=\"800\" height=\"600\">","note":"Valid markup, sensible alt, and a 404. No validator checks whether a path resolves — the Network panel is the only place this appears."}]}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'recall'::public.block_type, 'The rules behind the faults', 'Every fault in this milestone is a rule you already know, broken. From memory, name the rule each of these would violate — before you look at the page.',
       NULL, NULL, NULL, '{"points":["Level 1 — elements must nest, never overlap: `<strong><em>…</strong></em>` is the classic.","Level 2 — one `<h1>`, and no skipped levels between headings.","Level 3 — a relative path is read from the file you are in, so `../` means up one folder.","Level 4 — every image needs an `alt`, and every media path must actually resolve.","Level 5 — exactly one `<main>`, and it does not sit inside a header, footer or article.","Level 6 — every control needs a label with a matching `for` and `id`.","Level 8 — every id on the page is unique, or labels and ARIA references point at the wrong element."]}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Structure first, then validation, then content-level faults.","Verify each fix; do not assume.","This is the single most employable skill in the whole course."],"nextUp":"Level 12 next: the capstone."}'::jsonb
from public.lessons where slug = 'debugging-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'repair-milestone', 1, 'challenge'::public.exercise_kind, 'Milestone: repair the broken page',
       'This page has faults in every category. Repair all of them, keeping the content the same.', '<html>
<head>
<meta charset="utf-8">
</head>
<body>
<div class="top">
<a>Home</a>
<a href="about.html">About</a>
<a href="contact.html">Contact</a>
</div>

<div class="body">
<div class="title">Our routes</div>
<h4 id="r">Easy routes</h4>
<p>Flat and traffic-free.<div>Six miles.</div></p>
<h4 id="r">Harder routes</h4>
<img src="/learning-media/images/valley.jpg">
<p>For details <a href="routes.html">click here</a>.</p>
<center>All routes start at the workshop.</center>

<form action="/booking" method="post">
<input type="text" id="name" placeholder="Name">
<div onclick="send()">Send</div>
</form>
</div>

<div class="bottom">© 2026 Riverside Cycle Hire</div>
</body>
</html>', '<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Our routes — Riverside Cycle Hire</title>
</head>
<body>
  <a class="skip-link" href="#main">Skip to main content</a>

  <header>
    <nav aria-label="Main">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>
  </header>

  <main id="main">
    <h1>Our routes</h1>

    <h2 id="easy-routes">Easy routes</h2>
    <p>Flat and traffic-free.</p>
    <p>Six miles.</p>

    <h2 id="harder-routes">Harder routes</h2>
    <img src="/learning-media/images/forest-path-1200.jpg"
         alt="A sandy path winding between tall trees in a sunlit forest"
         loading="lazy" width="1200" height="800">

    <p>Read our <a href="routes.html">full route descriptions</a>.</p>
    <p>All routes start at the workshop.</p>

    <form action="/booking" method="post">
      <label for="name">Your name</label>
      <input type="text" id="name" name="name" autocomplete="name" required>
      <button type="submit">Send</button>
    </form>
  </main>

  <footer>
    <p>© 2026 Riverside Cycle Hire</p>
  </footer>
</body>
</html>', ARRAY['Start at the document level: no doctype, no lang, no viewport, no title.', 'The three divs are landmarks: header, main, footer. Add a skip link and wrap the links in a nav with a list.', 'The "title" div is really the h1, so the h4s become h2s. Both h4s also share id="r".', 'A <div> cannot live inside a <p>. <center> is obsolete.', 'The image path does not exist and has no alt or dimensions — use the media library.', '"Click here" tells a screen-reader user nothing. The first nav link has no href.', 'The input needs a label and a name; the "Send" div should be a real button.']::text[],
       200, 5,
       (select id from public.skills where slug = 'debugging'), false
from public.lessons l where l.slug = 'debugging-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'html', 'lang',
       NULL, NULL, NULL, NULL,
       'The html element declares a language', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_present'::public.requirement_kind, 'meta[name="viewport"]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a viewport meta tag', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has a title', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'text_not_empty'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The title has text', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'There is a header landmark', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main landmark', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'There is a footer landmark', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'element_present'::public.requirement_kind, 'nav', NULL,
       NULL, NULL, NULL, NULL,
       'The links are in a nav', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav is labelled', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 3, 3,
       'All three nav links are list items', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'attribute_present'::public.requirement_kind, 'a', 'href',
       NULL, NULL, NULL, NULL,
       'Every link has an href', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'There is a skip link', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one h1', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 15, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 16, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 17, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 18, 'no_deprecated_elements'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No obsolete elements are used', 'Elements like <center>, <font> and <big> were removed from HTML.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 19, 'element_count'::public.requirement_kind, 'p > div', NULL,
       NULL, NULL, 0, 0,
       'No block element inside a paragraph', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 20, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'The image has meaningful alt text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 21, 'attribute_present'::public.requirement_kind, 'img', 'width',
       NULL, NULL, NULL, NULL,
       'The image declares its dimensions', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 22, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 23, 'label_association'::public.requirement_kind, 'input', NULL,
       NULL, NULL, NULL, NULL,
       'The form control is labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 24, 'attribute_present'::public.requirement_kind, 'input', 'name',
       NULL, NULL, NULL, NULL,
       'The input has a name', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 25, 'element_present'::public.requirement_kind, 'button[type="submit"]', NULL,
       NULL, NULL, NULL, NULL,
       'The submit control is a real button', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 26, 'element_count'::public.requirement_kind, '[onclick]', NULL,
       NULL, NULL, 0, 0,
       'No inline click handlers remain', NULL, 1, true
from public.exercises e where e.slug = 'repair-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'validation-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: validate every page',
       'Run every page of your capstone site through the checklist and fix everything you find. From here on, every page you add should pass first time.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page title — your site</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul><li><a href="index.html">Home</a></li></ul>
      </nav>
    </header>
    <main id="main">
      <h1>Your page heading</h1>
      <!-- Check: unique ids? valid nesting? every image with alt and dimensions? -->
    </main>
    <footer><p>© 2026 Your site</p></footer>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Our routes — Riverside Cycle Hire</title>
    <meta name="description" content="Three waymarked routes starting at the Mill Lane workshop.">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="routes.html" aria-current="page">Routes</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Our routes</h1>
      <h2>Easy routes</h2>
      <p>Flat and traffic-free, starting at the workshop door.</p>
      <img src="/learning-media/images/forest-path-1200.jpg"
           alt="A sandy path winding between tall trees"
           loading="lazy" width="1200" height="800">
    </main>
    <footer><p>© 2026 Riverside Cycle Hire</p></footer>
  </body>
</html>', ARRAY['Work down the repair checklist in order.', 'Check every id is unique and every image has alt text and dimensions.', 'Tab through the finished page as a final check.']::text[],
       110, 4,
       (select id from public.skills where slug = 'validation'), false
from public.lessons l where l.slug = 'debugging-milestone'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'html', 'lang',
       NULL, NULL, NULL, NULL,
       'The page declares its language', NULL, 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main', NULL, 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'no_deprecated_elements'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No obsolete elements are used', 'Elements like <center>, <font> and <big> were removed from HTML.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every image has meaningful alternative text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'validation-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'debugging-milestone'), NULL, 'q-repair-order', 1, 'single'::public.question_kind,
        'What should you repair first on a badly broken page?', 'Document-level and structural problems. They affect everything else, and fixing them often resolves cascading errors.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Meta descriptions', false, NULL
from public.quiz_questions where slug = 'q-repair-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Whichever error the validator lists last', false, NULL
from public.quiz_questions where slug = 'q-repair-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Document structure — doctype, lang, landmarks, headings', true, NULL
from public.quiz_questions where slug = 'q-repair-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Alt text on images', false, NULL
from public.quiz_questions where slug = 'q-repair-order';
-- Level 11 milestone: Debugging and Validation Master questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-11-milestone'), 'a11-q1', 1, 'single'::public.question_kind,
        '"End tag main seen, but there were open elements" — where is the mistake?', 'Above the reported line. An element opened earlier was never closed; the validator noticed at `</main>`.', (select id from public.skills where slug = 'validation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Above that line — something opened earlier was never closed', true, NULL
from public.quiz_questions where slug = 'a11-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'On the reported line itself', false, NULL
from public.quiz_questions where slug = 'a11-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'In the head', false, NULL
from public.quiz_questions where slug = 'a11-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'In a linked stylesheet', false, NULL
from public.quiz_questions where slug = 'a11-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-11-milestone'), 'a11-q2', 2, 'single'::public.question_kind,
        'Which of these will a validator NOT catch?', 'Link text quality is a judgement about meaning, which no grammar checker can make.', (select id from public.skills where slug = 'validation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A duplicate id', false, NULL
from public.quiz_questions where slug = 'a11-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'An <li> outside a list', false, NULL
from public.quiz_questions where slug = 'a11-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'A missing <title>', false, NULL
from public.quiz_questions where slug = 'a11-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'A link whose text is "click here"', true, NULL
from public.quiz_questions where slug = 'a11-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-11-milestone'), 'a11-q3', 3, 'single'::public.question_kind,
        'Which developer-tools panel shows a 404 for a missing image?', 'Network, with the exact URL that was requested.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Accessibility', false, NULL
from public.quiz_questions where slug = 'a11-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Performance', false, NULL
from public.quiz_questions where slug = 'a11-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Network', true, NULL
from public.quiz_questions where slug = 'a11-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Elements', false, NULL
from public.quiz_questions where slug = 'a11-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-11-milestone'), 'a11-q4', 4, 'single'::public.question_kind,
        'What does the Elements panel show?', 'The live DOM — what the browser actually built, including any repairs it made to broken markup.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The accessibility tree only', false, NULL
from public.quiz_questions where slug = 'a11-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The live DOM, including the browser''s repairs', true, NULL
from public.quiz_questions where slug = 'a11-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Your original source file', false, NULL
from public.quiz_questions where slug = 'a11-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Validation errors', false, NULL
from public.quiz_questions where slug = 'a11-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-11-milestone'), 'a11-q5', 5, 'single'::public.question_kind,
        'Which element was removed from HTML?', '`<center>` is obsolete; centring is a styling concern.', (select id from public.skills where slug = 'validation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<center>', true, NULL
from public.quiz_questions where slug = 'a11-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<section>', false, NULL
from public.quiz_questions where slug = 'a11-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<figure>', false, NULL
from public.quiz_questions where slug = 'a11-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<aside>', false, NULL
from public.quiz_questions where slug = 'a11-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-11-milestone'), 'a11-q6', 6, 'single'::public.question_kind,
        'Roughly how many accessibility issues do automated tools catch?', 'About a third. The rest — alt-text quality, heading logic, link clarity — need a person.', (select id from public.skills where slug = 'accessibility'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Essentially all of them', false, NULL
from public.quiz_questions where slug = 'a11-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'None — they only check HTML grammar', false, NULL
from public.quiz_questions where slug = 'a11-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'About 90%', false, NULL
from public.quiz_questions where slug = 'a11-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'About a third', true, NULL
from public.quiz_questions where slug = 'a11-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-11-milestone'), 'a11-q7', 7, 'single'::public.question_kind,
        'What is the most reliable debugging method?', 'Change one thing, test, and revert if it did not help — plus narrowing the problem before fixing it.', (select id from public.skills where slug = 'debugging'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Fix every reported error before testing', false, NULL
from public.quiz_questions where slug = 'a11-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Try a different browser first', false, NULL
from public.quiz_questions where slug = 'a11-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Change one thing at a time and test after each change', true, NULL
from public.quiz_questions where slug = 'a11-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Rewrite the page from scratch', false, NULL
from public.quiz_questions where slug = 'a11-q7';
-- --------------------------------------------------------------------------
-- HTML Hero — Level 12: HTML Hero Capstone
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'html-hero-capstone', 12, 'HTML Hero Capstone', 'Finish, review and publish the website you have been building all along',
       'You have been building this site since Level 1. This level completes it, reviews it against every standard in the course, and gets it ready to publish.', 'You have a complete, valid, accessible, fast, multi-page website you built yourself — and you can explain every decision in it.', 'blue'
from public.courses c where c.slug = 'html-hero'
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, (select id from public.courses where slug = 'html-hero'), 'html-hero-final', 'final'::public.assessment_kind, 'HTML Hero final assessment', 'Twelve questions drawn from the whole course. Pass mark 80%. Passing this, plus your completed capstone, earns your certificate.',
       0.8, 500, 12
from public.levels l where l.slug = 'html-hero-capstone'
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;
-- module: Completing the site
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'completing-the-site', 1, 'Completing the site', 'The remaining pages, the shared patterns, and the pieces that turn a set of pages into a website.',
       60, false
from public.levels l where l.slug = 'html-hero-capstone'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'completing-the-site' and p.slug = 'validation-and-tools';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.75
from public.modules m, public.skills s
where m.slug = 'completing-the-site' and s.slug = 'multi-page';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.75
from public.modules m, public.skills s
where m.slug = 'completing-the-site' and s.slug = 'semantic-html';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.75
from public.modules m, public.skills s
where m.slug = 'completing-the-site' and s.slug = 'accessibility';
-- lesson: Assembling the site
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'assembling-the-site', 1, 'Assembling the site', 'Five pages, one consistent structure', 'Every module has added a piece. This lesson puts them together and fills the gaps.',
       ARRAY['Plan the final page set for your project', 'Apply the shared page shell to every page', 'Add the remaining page your project needs']::text[], 20, 40, (select id from public.skills where slug = 'multi-page'), 0.7
from public.modules m where m.slug = 'completing-the-site'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Complete the page set your capstone needs","Apply one consistent page shell across every page","Verify that no internal link is broken"]}'::jsonb
from public.lessons where slug = 'assembling-the-site';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'Your finished site needs at least five pages: a homepage, an about page, a page showing what you offer, a contact page, and one more that suits your particular project.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'assembling-the-site';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'The five-page structure', NULL,
       'Homepage        What this is, who it is for, and the one thing you
                want a visitor to do next.

About           The story, the people, the credentials. Where trust is built.

Services /      What you offer, in detail. Usually the longest page and
Products /      the one people actually came for.
Projects

Contact         The form, the address, the phone number, the hours.

One more        Depends on your project:
                · a portfolio → case study
                · a restaurant → menu
                · an event → programme
                · a rental business → FAQ or terms
                · a news site → an article page', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'assembling-the-site';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Page shell', 'The markup every page shares: the head metadata pattern, the skip link, the header and navigation, the main landmark, and the footer. Only the contents of `<main>` and the metadata values change.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'assembling-the-site';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'The page shell — copy this for every page and change only the marked parts', NULL,
       '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="referrer" content="strict-origin-when-cross-origin">

    <title>PAGE NAME — SITE NAME</title>
    <meta name="description" content="ONE SENTENCE ABOUT THIS PAGE">
    <link rel="canonical" href="https://YOUR-SITE/THIS-PAGE.html">
    <link rel="icon" href="/favicon.svg" type="image/svg+xml">

    <meta property="og:title" content="PAGE NAME — SITE NAME">
    <meta property="og:description" content="ONE SENTENCE ABOUT THIS PAGE">
    <meta property="og:image" content="https://YOUR-SITE/images/share-1200.jpg">
    <meta property="og:image:alt" content="DESCRIBE THE SHARE IMAGE">
    <meta property="og:url" content="https://YOUR-SITE/THIS-PAGE.html">
    <meta property="og:type" content="website">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>

    <header>
      <a href="index.html">SITE NAME</a>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="services.html">Services</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>

    <main id="main">
      <h1>PAGE HEADING</h1>
      <!-- This page''s content -->
    </main>

    <footer>
      <p>&copy; 2026 SITE NAME</p>
      <nav aria-label="Footer">
        <ul>
          <li><a href="privacy.html">Privacy</a></li>
        </ul>
      </nav>
    </footer>
  </body>
</html>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'assembling-the-site';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Change `aria-current` per page', 'The shell is identical everywhere except for one thing: `aria-current="page"` moves to the link for whichever page you are on. It is the easiest detail to forget when copying, and it is the one that tells visitors where they are.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'assembling-the-site';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'visual'::public.block_type, NULL, 'Your finished project structure.',
       NULL, NULL, 'file-paths', '{}'::jsonb
from public.lessons where slug = 'assembling-the-site';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'checklist'::public.block_type, 'Before moving on, confirm', NULL,
       NULL, NULL, NULL, '{"items":["Five pages exist, each with its own title and description","Every page uses the identical shell","`aria-current=\"page\"` is correct on each","Every internal link resolves — click all of them","All assets are in `assets/`, with lowercase hyphenated names","A favicon exists and is linked from every page"]}'::jsonb
from public.lessons where slug = 'assembling-the-site';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'media_example'::public.block_type, 'A real page, assembled from everything so far', 'Every element here has been covered: a landmark, a heading, a described image with dimensions, and a link whose text works on its own. Assembly is not a new skill — it is the point at which the previous eleven levels stop being separate.',
       '<main>
  <h1>The workshop</h1>
  <img src="/learning-media/images/workshop-tools.jpg"
       alt="Hand tools hanging in rows on a workshop wall above a wooden workbench"
       width="1600" height="900" loading="lazy" decoding="async">
  <p>Every repair is done here, by hand.</p>
  <a href="repairs.html">See what a service includes</a>
</main>', 'html', 'workshop-tools', '{}'::jsonb
from public.lessons where slug = 'assembling-the-site';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'interactive_demo'::public.block_type, 'A page section, before and after the course', 'The same content as a beginner writes it, and as you write it now.',
       NULL, NULL, NULL, '{"variants":[{"label":"Now","code":"<main>\n  <h1>Repairs</h1>\n  <img src=\"/learning-media/images/workshop-tools.jpg\" alt=\"Hand tools hanging in rows on a workshop wall\" width=\"1600\" height=\"900\" loading=\"lazy\">\n  <p>Booked in and returned within a week.</p>\n  <a href=\"repairs.html\">See what a service includes</a>\n</main>","note":"A landmark, one h1, described image with reserved space, deferred loading, and link text that works alone."},{"label":"Before","code":"<div class=\"content\">\n  <div class=\"title\">Repairs</div>\n  <img src=\"workshop.jpg\">\n  <div>Booked in and returned within a week.</div>\n  <a href=\"repairs.html\">Click here</a>\n</div>","note":"Renders almost identically and fails on every count: no landmark, no heading, no alt, no dimensions, and link text that means nothing in a list."}]}'::jsonb
from public.lessons where slug = 'assembling-the-site';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Five pages, one shell, differing only in metadata and main content.","`aria-current` moves per page.","Check every internal link by clicking it."],"nextUp":"Next: the final review."}'::jsonb
from public.lessons where slug = 'assembling-the-site';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'shell-guided', 1, 'guided'::public.exercise_kind, 'Build the page shell',
       'Build the complete shell for one page of your site: full head metadata, skip link, header with navigation, main with an h1, and a footer with a secondary nav.', '', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="referrer" content="strict-origin-when-cross-origin">
    <title>Services — Riverside Cycle Hire</title>
    <meta name="description" content="Bike hire, guided rides and repairs from our Mill Lane workshop.">
    <link rel="canonical" href="https://riverside-cycles.example/services.html">
    <link rel="icon" href="/learning-media/favicon.svg" type="image/svg+xml">
    <meta property="og:title" content="Services — Riverside Cycle Hire">
    <meta property="og:description" content="Bike hire, guided rides and repairs.">
    <meta property="og:image" content="https://riverside-cycles.example/images/share-1200.jpg">
    <meta property="og:image:alt" content="A blue hybrid bike outside the Mill Lane workshop">
    <meta property="og:url" content="https://riverside-cycles.example/services.html">
    <meta property="og:type" content="website">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <a href="index.html">Riverside Cycle Hire</a>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="services.html" aria-current="page">Services</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Services</h1>
      <p>Everything we offer, from an hour''s hire to a full service.</p>
    </main>
    <footer>
      <p>&copy; 2026 Riverside Cycle Hire</p>
      <nav aria-label="Footer">
        <ul><li><a href="privacy.html">Privacy</a></li></ul>
      </nav>
    </footer>
  </body>
</html>', ARRAY['Work down the shell from the template in the lesson.', 'Two navs means two different aria-label values.', 'Put aria-current="page" on the link for this page.']::text[],
       120, 4,
       (select id from public.skills where slug = 'multi-page'), false
from public.lessons l where l.slug = 'assembling-the-site'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'html', 'lang',
       NULL, NULL, NULL, NULL,
       'The page declares its language', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'meta[name="description"]', 'content',
       NULL, NULL, NULL, NULL,
       'The page has a description', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'link[rel="canonical"]', NULL,
       NULL, NULL, NULL, NULL,
       'A canonical URL is set', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_present'::public.requirement_kind, 'link[rel="icon"]', NULL,
       NULL, NULL, NULL, NULL,
       'A favicon is linked', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'element_present'::public.requirement_kind, 'meta[property="og:title"]', NULL,
       NULL, NULL, NULL, NULL,
       'Open Graph metadata is present', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'There is a skip link', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'There is a header landmark', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'element_count'::public.requirement_kind, 'nav', NULL,
       NULL, NULL, 2, NULL,
       'There is a main nav and a footer nav', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'Both navs are labelled', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page is marked', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside main', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 15, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'There is a footer landmark', NULL, 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 16, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 17, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'shell-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'assembling-the-site'), NULL, 'q-shell-difference', 1, 'single'::public.question_kind,
        'What should differ between two pages using the same shell?', 'The title, description, canonical, Open Graph values, the `aria-current` position, and the contents of `<main>`. Everything else is identical.', (select id from public.skills where slug = 'multi-page'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The position of the skip link', false, NULL
from public.quiz_questions where slug = 'q-shell-difference';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nothing — pages should be byte-identical', false, NULL
from public.quiz_questions where slug = 'q-shell-difference';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Metadata values, aria-current, and the contents of main', true, NULL
from public.quiz_questions where slug = 'q-shell-difference';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'The navigation link order', false, NULL
from public.quiz_questions where slug = 'q-shell-difference';
-- lesson: The capstone build
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'capstone-build', 2, 'The capstone build', 'Every requirement, one page at a time', 'The full requirement list for the finished site, and the build that proves you can meet it.',
       ARRAY['Meet every capstone requirement', 'Combine everything from all twelve levels', 'Produce work you would show an employer']::text[], 45, 40, (select id from public.skills where slug = 'multi-page'), 0.85
from public.modules m where m.slug = 'completing-the-site'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Build a page meeting the complete capstone requirement list","Demonstrate every skill from the course on one page","Produce a portfolio-quality result"]}'::jsonb
from public.lessons where slug = 'capstone-build';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'checklist'::public.block_type, 'The capstone requirement list', NULL,
       NULL, NULL, NULL, '{"items":["Consistent navigation on every page, with a skip link","Semantic landmarks: header, nav, main, footer","An accessible heading hierarchy — one h1, no skipped levels","A responsive image with `srcset` and `sizes`","Locally available media only — no hotlinking, no broken paths","A figure with a caption","A video or audio element with controls and captions","An accessible form with labels, grouping and validation","A meaningful list","A meaningful table, where the content genuinely warrants one","A native interactive element — details, dialog or popover","Unique page titles and meta descriptions","Social-sharing metadata","Basic structured data","A favicon","Organised project folders","No broken internal links","Valid HTML"]}'::jsonb
from public.lessons where slug = 'capstone-build';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'callout'::public.block_type, 'Do not build it all at once', 'You have not been asked to. Every module since Level 1 added a piece, and what remains is assembling and polishing. If a requirement is missing, go back to the module that taught it — the mission from that module is the piece you skipped.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'capstone-build';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'progressive_detail'::public.block_type, 'What "portfolio quality" actually means', 'Not that it looks like an agency site — you have not learned CSS yet, and the platform supplies the presentation. It means the markup would survive review by a professional: correct elements, sound structure, real alt text, working keyboard access, no broken paths, and metadata that is genuinely specific to each page. Somebody reading your HTML should be able to tell you knew why you chose each element. That is a genuinely employable standard, and it is what this build is assessed against.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'capstone-build';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'code_example'::public.block_type, 'The shape of the capstone page — every requirement visible at once', NULL,
       '<main id="main">
  <h1>Bike hire and guided rides</h1>

  <img src="hero-1200.jpg"
       srcset="hero-480.jpg 480w, hero-1200.jpg 1200w"
       sizes="100vw" alt="Sunrise over the estuary"
       fetchpriority="high" width="1200" height="800">

  <h2>Our rates</h2>
  <table>
    <caption>Bike hire rates, 2026</caption>
    <thead><tr><th scope="col">Bike</th><th scope="col">Per day</th></tr></thead>
    <tbody><tr><th scope="row">Hybrid</th><td>£22</td></tr></tbody>
  </table>

  <h2>Common questions</h2>
  <details name="faq" open>
    <summary>Do I need to book?</summary>
    <p>Not on weekdays.</p>
  </details>
</main>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'capstone-build';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'visual'::public.block_type, NULL, 'The landmark structure every page of your site should have.',
       NULL, NULL, 'semantic-landmarks', '{}'::jsonb
from public.lessons where slug = 'capstone-build';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'media_example'::public.block_type, 'A product entry, marked up properly', 'A single item on a shop or menu page. Note what it does *not* need: no ARIA, no roles, no wrappers. Correct elements, and the accessibility comes free.',
       '<article>
  <h3>Stoneware bottle</h3>
  <img src="/learning-media/images/product-bottle.jpg"
       alt="A dark green ceramic bottle with a cork stopper"
       width="1200" height="1200" loading="lazy" decoding="async">
  <p>Hand-thrown, 500ml. <strong>£28</strong></p>
  <a href="bottle.html">Read more about the stoneware bottle</a>
</article>', 'html', 'product-bottle', '{}'::jsonb
from public.lessons where slug = 'capstone-build';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'Three states of the same project page', 'What "finished" actually means, checked against the course.',
       NULL, NULL, NULL, '{"variants":[{"label":"Finished","code":"<main id=\"main\" tabindex=\"-1\">\n  <h1>Stoneware bottle</h1>\n  <img src=\"/learning-media/images/product-bottle.jpg\" alt=\"A dark green ceramic bottle with a cork stopper\" width=\"1200\" height=\"1200\" loading=\"lazy\">\n  <p>Hand-thrown, 500ml. <strong>£28</strong></p>\n  <a href=\"shop.html\">Back to the full range</a>\n</main>","note":"Landmark, one h1, described image with reserved space, deferred loading, and link text that stands alone."},{"label":"Nearly","code":"<main>\n  <h1>Stoneware bottle</h1>\n  <img src=\"/learning-media/images/product-bottle.jpg\" alt=\"bottle\" width=\"1200\" height=\"1200\">\n  <p>Hand-thrown, 500ml. £28</p>\n  <a href=\"shop.html\">Click here</a>\n</main>","note":"Valid, and three faults: alt that names the object rather than describing it, no loading strategy, and link text that means nothing in a list."},{"label":"Not started","code":"<div class=\"page\">\n  <div class=\"title\">Stoneware bottle</div>\n  <img src=\"bottle.jpg\">\n  <div>Hand-thrown, 500ml. £28</div>\n</div>","note":"No landmark, no heading, no alt, no dimensions, no link. It renders — and fails every check in the final review."}]}'::jsonb
from public.lessons where slug = 'capstone-build';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["The capstone is the assembly of twelve levels of work.","Every requirement maps to a module you have already completed.","The standard is markup that survives professional review."],"nextUp":"Next: the final review and publishing."}'::jsonb
from public.lessons where slug = 'capstone-build';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'capstone-main-build', 1, 'challenge'::public.exercise_kind, 'Capstone: the complete page',
       'Build one complete page of your site that demonstrates every requirement on the list: full metadata and structured data, landmarks, a responsive image, a figure with a caption, a video with captions, a list, a table, a native interactive element, and an accessible form.', '', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="referrer" content="strict-origin-when-cross-origin">

    <title>Bike hire and guided rides — Riverside Cycle Hire</title>
    <meta name="description"
          content="Hourly, daily and weekly bike hire from £6, plus guided valley rides every Saturday.">
    <link rel="canonical" href="https://riverside-cycles.example/services.html">
    <link rel="icon" href="/learning-media/favicon.svg" type="image/svg+xml">

    <meta property="og:title" content="Bike hire and guided rides — Riverside Cycle Hire">
    <meta property="og:description" content="Hire from £6 an hour. Guided valley rides every Saturday.">
    <meta property="og:image" content="https://riverside-cycles.example/images/share-1200.jpg">
    <meta property="og:image:alt" content="A blue hybrid bike outside the Mill Lane workshop">
    <meta property="og:url" content="https://riverside-cycles.example/services.html">
    <meta property="og:type" content="website">

    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "LocalBusiness",
      "name": "Riverside Cycle Hire",
      "url": "https://riverside-cycles.example/",
      "telephone": "+441632960123",
      "address": {
        "@type": "PostalAddress",
        "streetAddress": "14 Mill Lane",
        "addressLocality": "Hexford",
        "postalCode": "HX2 4PL",
        "addressCountry": "GB"
      }
    }
    </script>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>

    <header>
      <a href="index.html">Riverside Cycle Hire</a>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="services.html" aria-current="page">Services</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>

    <main id="main">
      <h1>Bike hire and guided rides</h1>

      <img
        src="/learning-media/images/coast-sunrise-1200.jpg"
        srcset="/learning-media/images/coast-sunrise-480.jpg   480w,
                /learning-media/images/coast-sunrise-800.jpg   800w,
                /learning-media/images/coast-sunrise-1200.jpg 1200w,
                /learning-media/images/coast-sunrise-1600.jpg 1600w"
        sizes="100vw"
        alt="Sunrise over the estuary at the start of the river path"
        fetchpriority="high" width="1200" height="800">

      <p>
        We hire well-maintained bikes by the hour, the day or the week, and run
        guided rides through the valley every Saturday from March to October.
      </p>

      <h2>What every hire includes</h2>
      <ul>
        <li>A helmet, fitted before you leave</li>
        <li>A lock and a printed route map</li>
        <li>Roadside recovery within ten miles</li>
      </ul>

      <h2>Our rates</h2>
      <table>
        <caption>Bike hire rates, 2026</caption>
        <thead>
          <tr>
            <th scope="col">Bike type</th>
            <th scope="col">Per hour</th>
            <th scope="col">Per day</th>
          </tr>
        </thead>
        <tbody>
          <tr><th scope="row">Hybrid</th><td>£6</td><td>£22</td></tr>
          <tr><th scope="row">Road bike</th><td>£9</td><td>£34</td></tr>
          <tr><th scope="row">Child''s bike</th><td>£4</td><td>£15</td></tr>
        </tbody>
        <tfoot>
          <tr><td colspan="3">All rates include a helmet and a lock.</td></tr>
        </tfoot>
      </table>

      <h2>The valley route</h2>
      <figure>
        <img src="/learning-media/images/forest-path-1200.jpg"
             alt="A sandy path winding between tall trees in a sunlit forest"
             loading="lazy" width="1200" height="800">
        <figcaption>The wooded section between mile eight and mile twelve.</figcaption>
      </figure>

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

      <h2>Common questions</h2>
      <details name="faq" open>
        <summary>Do I need to book in advance?</summary>
        <p>Not on weekdays. At weekends, please book a day ahead.</p>
      </details>
      <details name="faq">
        <summary>What if it rains?</summary>
        <p>Cancel up to two hours before for a full refund.</p>
      </details>

      <h2>Book a bike</h2>
      <form action="/booking" method="post">
        <label for="name">Your name</label>
        <input type="text" id="name" name="name" autocomplete="name" required minlength="2">

        <label for="email">Email address</label>
        <input type="email" id="email" name="email" autocomplete="email" required
               aria-describedby="email-hint">
        <p id="email-hint">We will only use this to confirm your booking.</p>

        <label for="date">Preferred date</label>
        <input type="date" id="date" name="date" required>

        <fieldset>
          <legend>Which bike would you like?</legend>
          <input type="radio" id="hybrid" name="biketype" value="hybrid" checked>
          <label for="hybrid">Hybrid</label>
          <input type="radio" id="road" name="biketype" value="road">
          <label for="road">Road bike</label>
        </fieldset>

        <label for="notes">Anything we should know?</label>
        <textarea id="notes" name="notes" rows="4" maxlength="500"></textarea>

        <button type="submit">Request a booking</button>
      </form>
    </main>

    <footer>
      <p>&copy; 2026 Riverside Cycle Hire</p>
      <nav aria-label="Footer">
        <ul>
          <li><a href="privacy.html">Privacy</a></li>
          <li><a href="terms.html">Terms</a></li>
        </ul>
      </nav>
    </footer>
  </body>
</html>', ARRAY['Start from the page shell, then add the main content section by section.', 'Use the media picker to insert the responsive image srcset and the video paths.', 'The table needs a caption, thead with scope="col", and row headings with scope="row".', 'The form needs labels on everything, a fieldset with a legend, and an explicit button type.', 'Do not forget the JSON-LD block in the head.']::text[],
       400, 5,
       (select id from public.skills where slug = 'multi-page'), false
from public.lessons l where l.slug = 'capstone-build'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'html', 'lang',
       NULL, NULL, NULL, NULL,
       'The page declares its language', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'meta[name="description"]', 'content',
       NULL, NULL, NULL, NULL,
       'The page has a meta description', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'link[rel="canonical"]', NULL,
       NULL, NULL, NULL, NULL,
       'A canonical URL is set', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_present'::public.requirement_kind, 'link[rel="icon"]', NULL,
       NULL, NULL, NULL, NULL,
       'A favicon is linked', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'element_present'::public.requirement_kind, 'meta[property="og:title"]', NULL,
       NULL, NULL, NULL, NULL,
       'Social sharing metadata is present', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'attribute_matches'::public.requirement_kind, 'meta[property="og:image"]', 'content',
       '^https?://', NULL, NULL, NULL,
       'The share image is an absolute URL', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'attribute_value'::public.requirement_kind, 'script', 'type',
       'application/ld+json', NULL, NULL, NULL,
       'There is structured data', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'There is a skip link', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'There is a header landmark', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'element_count'::public.requirement_kind, 'nav', NULL,
       NULL, NULL, 2, NULL,
       'There is a main nav and a footer nav', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'Every nav is labelled', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page is marked', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 15, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main landmark', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 16, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'There is a footer landmark', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 17, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one h1', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 18, 'element_count'::public.requirement_kind, 'h2', NULL,
       NULL, NULL, 3, NULL,
       'The page has several h2 sections', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 19, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 20, 'attribute_present'::public.requirement_kind, 'img[srcset]', 'sizes',
       NULL, NULL, NULL, NULL,
       'There is a responsive image with srcset and sizes', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 21, 'element_present'::public.requirement_kind, 'figure > figcaption', NULL,
       NULL, NULL, NULL, NULL,
       'There is a figure with a caption', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 22, 'element_present'::public.requirement_kind, 'video[controls]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a video with controls', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 23, 'element_present'::public.requirement_kind, 'track[kind="captions"]', NULL,
       NULL, NULL, NULL, NULL,
       'The video has captions', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 24, 'element_present'::public.requirement_kind, 'ul li, ol li', NULL,
       NULL, NULL, NULL, NULL,
       'There is a meaningful list', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 25, 'element_present'::public.requirement_kind, 'table > caption', NULL,
       NULL, NULL, NULL, NULL,
       'There is a table with a caption', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 26, 'element_count'::public.requirement_kind, 'th[scope="col"]', NULL,
       NULL, NULL, 2, NULL,
       'The table has column headings with scope', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 27, 'element_count'::public.requirement_kind, 'th[scope="row"]', NULL,
       NULL, NULL, 1, NULL,
       'The table has row headings with scope', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 28, 'element_count'::public.requirement_kind, 'details > summary', NULL,
       NULL, NULL, 2, NULL,
       'There is a native interactive element', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 29, 'element_present'::public.requirement_kind, 'form[action][method]', NULL,
       NULL, NULL, NULL, NULL,
       'There is a form with an action and method', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 30, 'label_association'::public.requirement_kind, 'input, select, textarea', NULL,
       NULL, NULL, NULL, NULL,
       'Every form control is labelled', 'Give the control an id, then point a <label for="that-id"> at it.', 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 31, 'element_present'::public.requirement_kind, 'fieldset > legend', NULL,
       NULL, NULL, NULL, NULL,
       'Related controls are grouped with a legend', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 32, 'attribute_value'::public.requirement_kind, 'button', 'type',
       'submit', NULL, NULL, NULL,
       'The submit button has an explicit type', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 33, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every image has meaningful alt text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 34, 'attribute_present'::public.requirement_kind, 'img', 'width',
       NULL, NULL, NULL, NULL,
       'Every image declares its dimensions', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 35, 'local_media_path'::public.requirement_kind, 'img, source, track, video', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 36, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 37, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 38, 'no_deprecated_elements'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No obsolete elements are used', 'Elements like <center>, <font> and <big> were removed from HTML.', 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 39, 'accessible_name'::public.requirement_kind, 'a', NULL,
       NULL, NULL, NULL, NULL,
       'Every link has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'capstone-main-build';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'capstone-build'), NULL, 'q-capstone-media', 1, 'single'::public.question_kind,
        'Why must the capstone use local media only?', 'Hotlinked media breaks when the other site changes, uses their bandwidth without permission, and is usually a copyright problem.', (select id from public.skills where slug = 'images'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Local files always load faster', false, NULL
from public.quiz_questions where slug = 'q-capstone-media';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Remote images cannot have alt text', false, NULL
from public.quiz_questions where slug = 'q-capstone-media';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Hotlinked media breaks, costs others bandwidth, and raises copyright issues', true, NULL
from public.quiz_questions where slug = 'q-capstone-media';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Browsers block cross-origin images', false, NULL
from public.quiz_questions where slug = 'q-capstone-media';
-- module: Final review and publishing
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'review-and-publish', 2, 'Final review and publishing', 'The review process a professional runs before shipping, and how to get your site onto the web.',
       45, true
from public.levels l where l.slug = 'html-hero-capstone'
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'review-and-publish' and p.slug = 'completing-the-site';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.75
from public.modules m, public.skills s
where m.slug = 'review-and-publish' and s.slug = 'validation';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.75
from public.modules m, public.skills s
where m.slug = 'review-and-publish' and s.slug = 'debugging';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.7
from public.modules m, public.skills s
where m.slug = 'review-and-publish' and s.slug = 'performance';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.7
from public.modules m, public.skills s
where m.slug = 'review-and-publish' and s.slug = 'seo';
-- lesson: The final review
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'final-review', 1, 'The final review', 'What to check before anything goes live', 'Five reviews, in order: validation, accessibility, media, performance, and a real device.',
       ARRAY['Run a complete pre-launch review', 'Fix what it turns up', 'Export your site as real files']::text[], 20, 40, (select id from public.skills where slug = 'validation'), 0.7
from public.modules m where m.slug = 'review-and-publish'
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Run the five reviews in order","Interpret and act on what each turns up","Export the finished site"]}'::jsonb
from public.lessons where slug = 'final-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'The five-review checklist', NULL,
       '1. VALIDATION
   Every page through validator.w3.org. Zero errors.
   Check: unclosed tags, duplicate ids, invalid nesting, obsolete elements.

2. ACCESSIBILITY
   Tab through every page: everything reachable, focus always visible,
   order matching the layout.
   Check: one h1 per page, no skipped levels, every image''s alt, every
   form label, every link''s text out of context, every iframe''s title.

3. MEDIA
   Open the Network panel and reload every page. Zero 404s.
   Check: dimensions on every image, lazy loading below the fold,
   captions on video, posters set, no hotlinked files.

4. PERFORMANCE
   Check: no render-blocking scripts, no preload="auto" on media,
   hero image not lazy-loaded, no unnecessary resource hints.

5. REAL DEVICE
   Open the site on an actual phone, not just a simulated viewport.
   Check: text readable without zooming, tap targets large enough,
   nothing overflowing horizontally.', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'final-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'callout'::public.block_type, 'Review in this order for a reason', 'Validation first, because invalid markup makes every later check unreliable — an accessibility tool cannot judge a document the browser had to guess at. Then accessibility, then media, then performance, then a real device. Each stage assumes the previous one is clean.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'final-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'prose'::public.block_type, NULL, 'When every review passes, export your project from HTML Hero. You get a folder of real `.html` files and an `assets/` directory, which will open in any browser and can be uploaded anywhere.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'final-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'progressive_detail'::public.block_type, 'Publishing your site', 'A static HTML site can be hosted almost anywhere, and usually free. Drag your exported folder onto a static host such as Netlify or Cloudflare Pages and it is live in seconds. Push it to a GitHub repository and enable GitHub Pages and it is live at a github.io address. Or upload the files by FTP to any traditional web host. Whichever you choose, the files you upload are exactly the files you exported — nothing needs building or compiling, because HTML runs as-is. That simplicity is one of the language''s real strengths.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'final-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'checklist'::public.block_type, 'Before you publish', NULL,
       NULL, NULL, NULL, '{"items":["Every page validates with zero errors","Keyboard test passes on every page","Zero 404s in the Network panel","Every page has its own title and description","Favicon present and linked everywhere","Tested on a real phone","No placeholder text left anywhere"]}'::jsonb
from public.lessons where slug = 'final-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'media_example'::public.block_type, 'The last thing to check: does it work on a real device?', 'Every review stage before this one can be done at your desk. This one cannot — pick the page up on a phone, on real data, and tap the things people will tap.',
       '<img src="/learning-media/images/restaurant-plate.jpg"
     alt="An overhead view of a colourful plated dish on a white plate"
     width="1200" height="1200" loading="lazy" decoding="async">', 'html', 'restaurant-plate', '{}'::jsonb
from public.lessons where slug = 'final-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'The five reviews, in order', 'Each stage assumes the one before it is clean.',
       NULL, NULL, NULL, '{"variants":[{"label":"Validation first","code":"<!DOCTYPE html>\n<html lang=\"en\">\n  <head><meta charset=\"utf-8\"><title>Menu — Riverside</title></head>\n  <body><main><h1>Menu</h1></main></body>\n</html>","note":"Zero errors before anything else. Measuring the performance of a page whose markup is broken measures the wrong page."},{"label":"Then the keyboard","code":"<a href=\"#main-content\">Skip to main content</a>\n<nav aria-label=\"Main\"><a href=\"index.html\">Home</a></nav>\n<main id=\"main-content\" tabindex=\"-1\"><h1>Menu</h1></main>","note":"Tab from the top. Everything reachable, focus always visible, and the skip link lands somewhere that can hold focus."},{"label":"Then media and performance","code":"<img src=\"/learning-media/images/restaurant-plate.jpg\" alt=\"An overhead view of a colourful plated dish\" width=\"1200\" height=\"1200\" loading=\"lazy\" decoding=\"async\">","note":"Every asset resolves, every image has dimensions and an appropriate loading strategy. Only now is a measurement meaningful."}]}'::jsonb
from public.lessons where slug = 'final-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'recall'::public.block_type, 'Everything, from memory', 'The last retrieval of the course. Close everything and write down what you would check on any page you were handed tomorrow — from memory, grouped however you like. Aim for fifteen items before you look.',
       NULL, NULL, NULL, '{"points":["Structure — doctype, `<html lang>`, charset first in the head, one unique title and description per page.","Headings — exactly one `<h1>`, no skipped levels, headings describing structure rather than chosen for size.","Landmarks — header, nav, main, footer; exactly one `<main>`; a skip link whose target can take focus.","Links — text that works read alone; `rel=\"noopener noreferrer\"` with `target=\"_blank\"`; every internal path resolving.","Images — an `alt` on every one, empty for decoration; `width` and `height` everywhere; `loading=\"lazy\"` below the fold and never above it.","Forms — a label per control, groups in a `<fieldset>` with a `<legend>`, `autocomplete` on fields about the user, errors connected and announced.","ARIA — as little as possible; native elements first; `aria-current` on the current nav item.","Keyboard — everything reachable, focus always visible, nothing trapped, Enter and Space both working on buttons.","Validation — zero errors, no duplicate ids, no obsolete elements, legal nesting throughout.","Performance — one priority image, dimensions everywhere, embeds lazy, titled and sandboxed.","Metadata — canonical URL, favicon, Open Graph title, description and a described image.","And the one no tool can check: does the alt text, the link text and the heading order describe what is actually on the page?"]}'::jsonb
from public.lessons where slug = 'final-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Five reviews, in order: validation, accessibility, media, performance, real device.","Each stage assumes the previous one is clean.","A static HTML site publishes with no build step at all."],"nextUp":"Finally: the course assessment."}'::jsonb
from public.lessons where slug = 'final-review';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'recap'::public.block_type, 'Close the book', NULL,
       NULL, NULL, NULL, '{"prompts":["Name the five reviews in order, and say why that order and not another.","For each one, name the single check you would run first if you only had five minutes.","What does it mean that a page passes validation but fails the keyboard test?"],"points":["Validation, accessibility, media, performance, real device. Each stage assumes the previous one is clean — there is no point measuring the performance of a page whose markup is still broken, because fixing the markup changes the measurement.","Validation: run the page through the W3C validator. Accessibility: tab through it from top to bottom. Media: check for 404s in the Network panel. Performance: check image dimensions and formats. Device: open it on a real phone.","That valid markup and usable markup are different claims. Validation checks that the document is well formed; it cannot tell whether a control can be reached, whether focus is visible, or whether the reading order makes sense. A page can be perfectly valid and completely unusable without a mouse."]}'::jsonb
from public.lessons where slug = 'final-review';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'final-review-exercise', 1, 'debug'::public.exercise_kind, 'The last five faults',
       'This page is nearly ready. Five faults remain, one from each review category. Find and fix all five.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Services — Riverside Cycle Hire</title>
  </head>
  <body>
    <a class="skip-link" href="#content">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="services.html">Services</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Services</h1>
      <h3>Bike hire</h3>
      <img src="/learning-media/images/workshop.jpg" alt="Workshop" width="1200" height="800">
      <video src="/learning-media/video/page-anatomy.mp4" controls preload="auto" width="1280" height="720"></video>
    </main>
    <footer><p>&copy; 2026 Riverside Cycle Hire</p></footer>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Services — Riverside Cycle Hire</title>
    <meta name="description" content="Bike hire, guided rides and repairs from our Mill Lane workshop.">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="services.html" aria-current="page">Services</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Services</h1>
      <h2>Bike hire</h2>
      <img src="/learning-media/images/workshop-tools-1200.jpg"
           alt="Hand tools hanging in rows above a wooden workbench"
           width="1200" height="800">
      <video controls preload="metadata"
             poster="/learning-media/posters/page-anatomy.jpg"
             width="1280" height="720">
        <source src="/learning-media/video/page-anatomy.webm" type="video/webm">
        <source src="/learning-media/video/page-anatomy.mp4" type="video/mp4">
        <track kind="captions" src="/learning-media/captions/page-anatomy.en.vtt"
               srclang="en" label="English" default>
        <p><a href="/learning-media/video/page-anatomy.mp4">Download the MP4</a></p>
      </video>
    </main>
    <footer><p>&copy; 2026 Riverside Cycle Hire</p></footer>
  </body>
</html>', ARRAY['Accessibility: the skip link points at #content, but main has id="main".', 'Structure: the h1 is followed by an h3, skipping a level.', 'Media: the image path does not exist, and its alt text is one word.', 'Media: the video has no captions and no poster.', 'Metadata: the page has no meta description, and no link is marked as current.']::text[],
       150, 5,
       (select id from public.skills where slug = 'debugging'), false
from public.lessons l where l.slug = 'final-review'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'The skip link matches the id on main', NULL, 1, true
from public.exercises e where e.slug = 'final-review-exercise';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'final-review-exercise';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'local_media_path'::public.requirement_kind, 'img, source, video, track', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'final-review-exercise';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'The image alt text is descriptive', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'final-review-exercise';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'track[kind="captions"]', NULL,
       NULL, NULL, NULL, NULL,
       'The video has captions', NULL, 1, true
from public.exercises e where e.slug = 'final-review-exercise';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'attribute_present'::public.requirement_kind, 'video', 'poster',
       NULL, NULL, NULL, NULL,
       'The video has a poster image', NULL, 1, true
from public.exercises e where e.slug = 'final-review-exercise';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'element_count'::public.requirement_kind, 'video[preload="auto"]', NULL,
       NULL, NULL, 0, 0,
       'The video no longer preloads its whole file', NULL, 1, true
from public.exercises e where e.slug = 'final-review-exercise';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'attribute_present'::public.requirement_kind, 'meta[name="description"]', 'content',
       NULL, NULL, NULL, NULL,
       'The page has a meta description', NULL, 1, true
from public.exercises e where e.slug = 'final-review-exercise';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page is marked in the nav', NULL, 1, true
from public.exercises e where e.slug = 'final-review-exercise';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'capstone-final-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: the finished site',
       'Apply the five reviews to every page of your capstone site and fix everything they turn up. When all five pass, export your project — the files are yours to publish anywhere.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page — your site</title>
    <meta name="description" content="A sentence about this page.">
    <link rel="canonical" href="https://your-site.example/page.html">
    <link rel="icon" href="/learning-media/favicon.svg" type="image/svg+xml">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Your page heading</h1>
      <!-- Run the five reviews over everything below -->
    </main>
    <footer><p>&copy; 2026 Your site</p></footer>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Our routes — Riverside Cycle Hire</title>
    <meta name="description" content="Three waymarked routes starting from our Mill Lane workshop.">
    <link rel="canonical" href="https://riverside-cycles.example/routes.html">
    <link rel="icon" href="/learning-media/favicon.svg" type="image/svg+xml">
    <meta property="og:title" content="Our routes — Riverside Cycle Hire">
    <meta property="og:description" content="Three waymarked routes from our Mill Lane workshop.">
    <meta property="og:image" content="https://riverside-cycles.example/images/share-1200.jpg">
    <meta property="og:image:alt" content="A sandy path winding between tall trees">
    <meta property="og:url" content="https://riverside-cycles.example/routes.html">
    <meta property="og:type" content="website">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="routes.html" aria-current="page">Routes</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>Our routes</h1>
      <h2>Easy routes</h2>
      <figure>
        <img src="/learning-media/images/forest-path-1200.jpg"
             alt="A sandy path winding between tall trees in a sunlit forest"
             loading="lazy" width="1200" height="800">
        <figcaption>The wooded section of the valley route.</figcaption>
      </figure>
      <ul>
        <li>Harbour loop — 6 miles, flat</li>
        <li>Mill and back — 11 miles, one climb</li>
      </ul>
    </main>
    <footer><p>&copy; 2026 Riverside Cycle Hire</p></footer>
  </body>
</html>', ARRAY['Run validation first, then the keyboard test, then check the Network panel.', 'Every page needs its own title, description and canonical.', 'Mark the current page in the nav on every page.']::text[],
       250, 5,
       (select id from public.skills where slug = 'multi-page'), false
from public.lessons l where l.slug = 'final-review'
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'html', 'lang',
       NULL, NULL, NULL, NULL,
       'The page declares its language', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'meta[name="description"]', 'content',
       NULL, NULL, NULL, NULL,
       'The page has its own description', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_present'::public.requirement_kind, 'link[rel="canonical"]', NULL,
       NULL, NULL, NULL, NULL,
       'A canonical URL is set', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_present'::public.requirement_kind, 'link[rel="icon"]', NULL,
       NULL, NULL, NULL, NULL,
       'A favicon is linked', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'The skip link matches the main landmark', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'element_present'::public.requirement_kind, 'header', NULL,
       NULL, NULL, NULL, NULL,
       'There is a header landmark', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'element_present'::public.requirement_kind, 'footer', NULL,
       NULL, NULL, NULL, NULL,
       'There is a footer landmark', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav is labelled', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page is marked', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'unique_element'::public.requirement_kind, 'h1', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one h1', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 14, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 15, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Images have meaningful alt text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 16, 'local_media_path'::public.requirement_kind, 'img, source, video, track', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 17, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id on the page is unique', 'Two elements can never share an id. Use a class or a different id.', 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 18, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 19, 'no_deprecated_elements'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'No obsolete elements are used', 'Elements like <center>, <font> and <big> were removed from HTML.', 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 20, 'text_not_empty'::public.requirement_kind, 'main p, main li', NULL,
       NULL, NULL, NULL, NULL,
       'The page has real content', NULL, 1, true
from public.exercises e where e.slug = 'capstone-final-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'final-review'), NULL, 'q-review-order', 1, 'single'::public.question_kind,
        'Why validate before running an accessibility check?', 'An accessibility tool reads the repaired DOM. If the markup is invalid the browser has guessed at the structure, so the results describe a document you did not write.', (select id from public.skills where slug = 'validation'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Accessibility tools refuse to run on invalid HTML', false, NULL
from public.quiz_questions where slug = 'q-review-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Validation fixes accessibility automatically', false, NULL
from public.quiz_questions where slug = 'q-review-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'There is no reason — the order does not matter', false, NULL
from public.quiz_questions where slug = 'q-review-order';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Invalid markup means the tool is checking a document the browser guessed at', true, NULL
from public.quiz_questions where slug = 'q-review-order';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'final-review'), NULL, 'q-publishing', 2, 'single'::public.question_kind,
        'What build step does a static HTML site need before publishing?', 'None. HTML runs as-is; the files you upload are the files you wrote.', (select id from public.skills where slug = 'multi-page'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Conversion to a server-side language', false, NULL
from public.quiz_questions where slug = 'q-publishing';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'None — the files run as they are', true, NULL
from public.quiz_questions where slug = 'q-publishing';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Compilation to a binary format', false, NULL
from public.quiz_questions where slug = 'q-publishing';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Minification, which is mandatory', false, NULL
from public.quiz_questions where slug = 'q-publishing';
-- HTML Hero final assessment questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q1', 1, 'single'::public.question_kind,
        'Which must be the first line of an HTML file?', 'The doctype, which switches the browser into standards mode.', (select id from public.skills where slug = 'document-structure'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<?xml version="1.0"?>', false, NULL
from public.quiz_questions where slug = 'final-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<!DOCTYPE html>', true, NULL
from public.quiz_questions where slug = 'final-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<html lang="en">', false, NULL
from public.quiz_questions where slug = 'final-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<meta charset="utf-8">', false, NULL
from public.quiz_questions where slug = 'final-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'html-hero-final'), 'final-q2', 2, 'single'::public.question_kind,
        'How many `<h1>` and `<main>` elements should a page have?', 'Exactly one of each. The h1 names what the page is about, and main holds the content unique to that page — several of either leaves both readers and software with no clear answer.', (select id from public.skills where slug = 'semantic-html'), 10)
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'One h1 and one main', true, NULL
from public.quiz_questions where slug = 'final-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'One h1 and several main elements', false, NULL
from public.quiz_questions where slug = 'final-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Several h1 elements and one main', false, NULL
from public.quiz_questions where slug = 'final-q2';

commit;
