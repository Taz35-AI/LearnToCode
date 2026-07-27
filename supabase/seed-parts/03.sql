-- HTML Hero — course seed, part 3 of 7
--
-- GENERATED FILE. Do not edit by hand.
-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split
--
-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the
-- course catalogue; later parts insert rows that reference earlier ones.
-- Learner accounts and progress are never touched.
--
-- Run part 2 first.

begin;
-- --------------------------------------------------------------------------
-- Level 3: Navigation Architect
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'navigation-architect', 3, 'Navigation Architect', 'Connect pages into a website people can actually move around',
       'Links are what make the web a web. This level covers every kind of link, how file paths really work, and how to build navigation that works with a mouse, a keyboard and a screen reader.', 'You can build and connect a multi-page website with consistent, accessible navigation.', 'indigo'
from public.courses c where c.slug = 'html-hero';
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-3-milestone', 'milestone'::public.assessment_kind, 'Level 3 milestone: Navigation Architect', 'Eight questions on links, paths and navigation. Pass mark 75%.',
       0.75, 160, 3
from public.levels l where l.slug = 'navigation-architect';
-- module: Links and file paths
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'links-and-paths', 1, 'Links and file paths', 'The anchor element in depth, and the single topic that trips up more beginners than any other: relative paths.',
       50, false
from public.levels l where l.slug = 'navigation-architect';
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'links-and-paths' and p.slug = 'text-level-semantics';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'links-and-paths' and s.slug = 'links';
-- lesson: The anchor element and link text that works
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'anchors-and-link-text', 1, 'The anchor element and link text that works', 'href, targets, and why "click here" fails real users', 'One element, one essential attribute — and one writing habit that makes a measurable accessibility difference.',
       ARRAY['Link to another page with the anchor element', 'Write link text that makes sense out of context', 'Open external links safely']::text[], 14, 40, (select id from public.skills where slug = 'links'), 0.7
from public.modules m where m.slug = 'links-and-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Create links using the anchor element and its href attribute","Write descriptive link text and explain why it matters","Use rel=\"noopener noreferrer\" when opening a link in a new tab"]}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'A link is an `<a>` element with an `href` attribute. The `href` says where the link goes; the content between the tags is what the visitor sees and clicks.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'visual'::public.block_type, NULL, 'A link, with each part labelled.',
       NULL, NULL, 'anatomy-of-an-element', '{}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'code_example'::public.block_type, 'A link to another page in your site, and a link to another site', NULL,
       '<a href="about.html">About our workshop</a>
<a href="https://www.example.org/">The example organisation</a>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Why "click here" is a genuine problem', 'Screen-reader users can pull up a list of every link on a page and jump between them — exactly as sighted users scan for the blue text. In that list the link text appears with no surrounding sentence. A page of "click here", "read more", "click here" gives a list that is completely useless. Link text must make sense entirely on its own.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'comparison'::public.block_type, 'Link text out of context', NULL,
       NULL, NULL, NULL, '{"good":{"label":"Works alone","code":"<p>Rates start at £6 an hour. <a href=\"prices.html\">See our full price list</a>.</p>","why":"In a list of links this reads \"See our full price list\" — instantly clear."},"bad":{"label":"Meaningless alone","code":"<p>Rates start at £6 an hour. <a href=\"prices.html\">Click here</a>.</p>","why":"In a list of links this reads \"Click here\". Here where? For what?"}}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'prose'::public.block_type, NULL, 'Adding `target="_blank"` opens a link in a new tab. It is worth using sparingly, and when you do, you must add `rel="noopener noreferrer"`.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<a href="https://www.example.org/report"
   target="_blank"
   rel="noopener noreferrer">
  The 2026 cycling report (opens in a new tab)
</a>', 'html', NULL, '{"annotations":[{"line":"1","text":"A normal link to an external site."},{"line":"2","text":"`target=\"_blank\"` opens it in a new browser tab."},{"line":"3","text":"`noopener` stops the new page from getting a reference back to your page, which older browsers allowed it to use to redirect your tab somewhere malicious. `noreferrer` additionally stops your page''s address being sent to the destination."},{"line":"4","text":"Saying \"opens in a new tab\" in the visible text is not a technicality — an unexpected new tab is disorienting, and the Back button no longer works as expected."}]}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'callout'::public.block_type, 'Modern browsers already imply noopener', 'Every current browser treats `target="_blank"` as if `noopener` were set. Writing it explicitly costs nothing, documents the intent, and protects users on older browsers — so it remains the professional default.',
       NULL, NULL, NULL, '{"tone":"note"}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'progressive_detail'::public.block_type, 'When should a link open in a new tab at all?', 'The honest answer is: rarely. Taking control of the user''s window away from them is a decision they did not make, and it breaks the Back button, which is the most-used control in any browser. The defensible cases are narrow — a reference the user needs while completing a form, or a link that would lose unsaved work. When in doubt, let the link open normally; anyone who wants a new tab can middle-click or use their browser''s menu.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<a href=\"…\">` creates a link; the content between the tags is what people see.","Link text must make sense read on its own, out of context.","`target=\"_blank\"` needs `rel=\"noopener noreferrer\"` and a visible warning.","Opening in a new tab takes control away from the user — do it rarely."],"nextUp":"Next: relative paths, the thing everyone gets wrong once."}'::jsonb
from public.lessons where slug = 'anchors-and-link-text';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'links-guided', 1, 'guided'::public.exercise_kind, 'Rewrite three bad links',
       'All three links below use meaningless text. Rewrite the visible text so each makes sense on its own, keeping the destinations exactly as they are.', '<p>Our prices changed in April. <a href="prices.html">Click here</a>.</p>
<p>We publish a monthly newsletter. <a href="newsletter.html">Read more</a>.</p>
<p>Find us on Mill Lane. <a href="contact.html">Here</a>.</p>', '<p>Our prices changed in April. <a href="prices.html">See the new price list</a>.</p>
<p>We publish a monthly newsletter. <a href="newsletter.html">Read this month''s newsletter</a>.</p>
<p>Find us on Mill Lane. <a href="contact.html">Get directions and opening hours</a>.</p>', ARRAY['Ask yourself: if I read only the link text, would I know where it goes?', 'Describe the destination, not the action — "See the price list" rather than "Click here".', 'Keep each href exactly as it was; only the visible text changes.']::text[],
       35, 2,
       (select id from public.skills where slug = 'links'), false
from public.lessons l where l.slug = 'anchors-and-link-text';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'a', NULL,
       NULL, NULL, 3, 3,
       'All three links remain', NULL, 1, true
from public.exercises e where e.slug = 'links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'a[href="prices.html"]', 'href',
       'prices.html', NULL, NULL, NULL,
       'The prices link still points at prices.html', NULL, 1, true
from public.exercises e where e.slug = 'links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'accessible_name'::public.requirement_kind, 'a', NULL,
       NULL, NULL, NULL, NULL,
       'Every link has an accessible name', NULL, 1, true
from public.exercises e where e.slug = 'links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'text_content'::public.requirement_kind, 'a', NULL,
       'price', NULL, NULL, NULL,
       'The prices link describes its destination', 'Mention prices in the link text.', 1, true
from public.exercises e where e.slug = 'links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_absent'::public.requirement_kind, 'a[href="contact.html"]:not([href])', NULL,
       NULL, NULL, NULL, NULL,
       'Links keep their destinations', NULL, 1, true
from public.exercises e where e.slug = 'links-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'links-debug', 2, 'debug'::public.exercise_kind, 'An unsafe external link',
       'This external link opens in a new tab but is missing its `rel` attribute, and it does not warn the reader. Add `rel="noopener noreferrer"` and mention the new tab in the visible text.', '<p>
  Read <a href="https://www.example.org/report" target="_blank">the 2026 report</a>
  for the full figures.
</p>', '<p>
  Read
  <a href="https://www.example.org/report" target="_blank" rel="noopener noreferrer">
    the 2026 report (opens in a new tab)
  </a>
  for the full figures.
</p>', ARRAY['Add a rel attribute alongside target on the same opening tag.', 'Its value is the two keywords separated by a space: "noopener noreferrer".', 'Add "(opens in a new tab)" to the words inside the link.']::text[],
       35, 2,
       (select id from public.skills where slug = 'links'), false
from public.lessons l where l.slug = 'anchors-and-link-text';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'a[target="_blank"]', 'rel',
       NULL, NULL, NULL, NULL,
       'The external link has a rel attribute', NULL, 1, true
from public.exercises e where e.slug = 'links-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_matches'::public.requirement_kind, 'a[target="_blank"]', 'rel',
       'noopener', NULL, NULL, NULL,
       'The rel value includes noopener', NULL, 1, true
from public.exercises e where e.slug = 'links-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'text_content'::public.requirement_kind, 'a', NULL,
       'new tab', NULL, NULL, NULL,
       'The link text warns that it opens in a new tab', NULL, 1, true
from public.exercises e where e.slug = 'links-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'anchors-and-link-text'), NULL, 'q-link-text', 1, 'single'::public.question_kind,
        'Why must link text make sense out of context?', 'Screen-reader users can list every link on a page and jump between them. In that list the link text appears with nothing around it.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Screen-reader users navigate by a list of links with no surrounding text', true, NULL
from public.quiz_questions where slug = 'q-link-text';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Search engines refuse to index short link text', false, NULL
from public.quiz_questions where slug = 'q-link-text';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Browsers truncate long link text', false, NULL
from public.quiz_questions where slug = 'q-link-text';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'CSS cannot style links whose text is too short', false, NULL
from public.quiz_questions where slug = 'q-link-text';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'anchors-and-link-text'), NULL, 'q-noopener', 2, 'single'::public.question_kind,
        'What does `rel="noopener"` prevent?', 'It stops the newly opened page from holding a reference back to yours — a reference it could otherwise use to redirect your tab.', (select id from public.skills where slug = 'security'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The new page getting a reference back to yours', true, NULL
from public.quiz_questions where slug = 'q-noopener';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The link being followed by search engines', false, NULL
from public.quiz_questions where slug = 'q-noopener';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The page being cached', false, NULL
from public.quiz_questions where slug = 'q-noopener';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Cookies being sent with the request', false, NULL
from public.quiz_questions where slug = 'q-noopener';
-- lesson: Relative paths, absolute URLs and fragments
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'relative-and-absolute-paths', 2, 'Relative paths, absolute URLs and fragments', 'The one topic worth slowing down for', 'Almost every "my image is broken" and "my link 404s" comes from a path. Half an hour here saves hours later.',
       ARRAY['Write a relative path from one file to another', 'Use `../` to move up a folder', 'Link to a section within a page using a fragment']::text[], 16, 40, (select id from public.skills where slug = 'links'), 0.7
from public.modules m where m.slug = 'links-and-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Write correct relative paths between files in a project","Explain the difference between a relative path and an absolute URL","Link to a specific section of a page with a fragment identifier"]}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'visual'::public.block_type, NULL, 'A project folder, and the paths between the files in it.',
       NULL, NULL, 'file-paths', '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Relative path', 'A path starting from the file you are currently in. `about.html` means "a file called about.html, in the same folder as me".',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Absolute URL', 'A complete web address including the protocol: `https://www.example.org/about`. It works from anywhere, but only points at a live site.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'prose'::public.block_type, NULL, 'Given the folder shown above, here is every path you need. Read each one as an instruction starting from where you are now.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, 'Reading paths as instructions', NULL,
       'From index.html (at the top level):
  about.html               → the file next to me
  images/logo.svg          → go into images, then take logo.svg
  projects/first.html      → go into projects, then take first.html

From projects/first.html (one folder deep):
  ../index.html            → go up one folder, then take index.html
  ../images/logo.svg       → go up one folder, into images, then logo.svg
  second.html              → the file next to me, inside projects/', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'Two dots means "up one folder"', 'A single dot means "here" and is almost always optional — `./about.html` and `about.html` are the same thing. Two dots means "go up one level". You can chain them: `../../images/logo.svg` goes up twice.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'callout'::public.block_type, 'The leading slash trap', 'Writing `/images/logo.svg` with a leading slash means "start from the very top of the website", not "start from my folder". On a live server that is often what you want; but when you open a file directly from your computer it means the root of your hard drive, and the image will not load. While you are learning, prefer relative paths with no leading slash.',
       NULL, NULL, NULL, '{"tone":"mistake"}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'interactive_demo'::public.block_type, 'Same link, three ways', 'Each of these can be correct — it depends where you are.',
       NULL, NULL, NULL, '{"variants":[{"label":"Relative","code":"<a href=\"about.html\">About</a>","note":"Looks for about.html beside the current file. Works locally and on a server."},{"label":"Root-relative","code":"<a href=\"/about.html\">About</a>","note":"Always starts at the site root. Great on a server; usually broken when opening files directly."},{"label":"Absolute","code":"<a href=\"https://example.org/about.html\">About</a>","note":"Points at one specific live site. Use it for links to *other* sites, not your own pages."}]}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'prose'::public.block_type, NULL, 'A fragment link points at a specific place *within* a page. You give an element an `id`, then link to `#that-id`. Clicking it scrolls straight there.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<nav aria-label="On this page">
  <ul>
    <li><a href="#rates">Rates</a></li>
    <li><a href="#routes">Routes</a></li>
  </ul>
</nav>

<h2 id="rates">Rates</h2>
<p>From £6 an hour.</p>

<h2 id="routes">Routes</h2>
<p>Three waymarked loops from the door.</p>', 'html', NULL, '{"annotations":[{"line":"3","text":"`href=\"#rates\"` means \"the element on this page whose id is rates\"."},{"line":"8","text":"The matching `id=\"rates\"`. Ids must be unique on a page — two elements can never share one."},{"line":"1","text":"Giving the `<nav>` an `aria-label` distinguishes it from the site''s main navigation for screen-reader users. Level 8 covers this properly."}]}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'progressive_detail'::public.block_type, 'Linking to a section on another page', 'Combine a path with a fragment: `<a href="prices.html#day-rates">Day rates</a>` loads prices.html and jumps to the element with `id="day-rates"`. This works with relative paths and absolute URLs alike. The `#top` fragment, and an empty `href="#"`, both scroll to the top of the current page — though `href="#"` on a real link is usually a sign that something is missing.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'checklist'::public.block_type, 'Path rules to remember', NULL,
       NULL, NULL, NULL, '{"items":["No slash at the start = start from where I am","`../` = go up one folder","Leading `/` = start from the site root","`#name` = an element with `id=\"name\"` on this page","Folder and file names: lowercase, hyphens, no spaces"]}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 14, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Relative paths start from the current file; `../` moves up a folder.","A leading slash starts at the site root and usually breaks local file browsing.","Absolute URLs are for other people''s sites, not your own pages.","Fragment links (`#id`) jump to a specific element, whose id must be unique."],"nextUp":"Next: email, telephone and download links."}'::jsonb
from public.lessons where slug = 'relative-and-absolute-paths';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'paths-guided', 1, 'guided'::public.exercise_kind, 'Write paths from a nested page',
       'You are editing `routes/valley.html`, one folder deep. Add three links: back to `index.html` at the top level, across to `routes/harbour.html` beside you, and to `prices.html` at the top level.', '<nav>
  <ul>
    <li><a href="">Home</a></li>
    <li><a href="">Harbour route</a></li>
    <li><a href="">Prices</a></li>
  </ul>
</nav>', '<nav>
  <ul>
    <li><a href="../index.html">Home</a></li>
    <li><a href="harbour.html">Harbour route</a></li>
    <li><a href="../prices.html">Prices</a></li>
  </ul>
</nav>', ARRAY['You are inside the routes folder, so anything at the top level needs ../ first.', 'harbour.html is in the same folder as you, so it needs no prefix at all.', 'Home becomes ../index.html and Prices becomes ../prices.html.']::text[],
       45, 3,
       (select id from public.skills where slug = 'links'), false
from public.lessons l where l.slug = 'relative-and-absolute-paths';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '../index.html', NULL, NULL, NULL,
       'The Home link goes up one folder to index.html', NULL, 1, true
from public.exercises e where e.slug = 'paths-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'a', 'href',
       'harbour.html', NULL, NULL, NULL,
       'The Harbour link points at the sibling file', NULL, 1, true
from public.exercises e where e.slug = 'paths-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '../prices.html', NULL, NULL, NULL,
       'The Prices link goes up one folder', NULL, 1, true
from public.exercises e where e.slug = 'paths-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'nav a', NULL,
       NULL, NULL, 3, 3,
       'All three links are present', NULL, 1, true
from public.exercises e where e.slug = 'paths-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'fragments-challenge', 2, 'challenge'::public.exercise_kind, 'Build an on-page contents list',
       'Write a page with three `<h2>` sections, each with its own `id`, and a `<nav>` at the top containing a list of three fragment links that jump to them.', '', '<nav aria-label="On this page">
  <ul>
    <li><a href="#rates">Rates</a></li>
    <li><a href="#routes">Routes</a></li>
    <li><a href="#opening-hours">Opening hours</a></li>
  </ul>
</nav>

<h2 id="rates">Rates</h2>
<p>From £6 an hour, minimum two hours.</p>

<h2 id="routes">Routes</h2>
<p>Three waymarked loops start at our door.</p>

<h2 id="opening-hours">Opening hours</h2>
<p>Open 8am to 6pm, Tuesday to Sunday.</p>', ARRAY['Give each <h2> an id, using lowercase words joined by hyphens.', 'Each link in the nav is href="#that-id".', 'The ids must all be different from each other.']::text[],
       45, 3,
       (select id from public.skills where slug = 'links'), false
from public.lessons l where l.slug = 'relative-and-absolute-paths';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'h2[id]', NULL,
       NULL, NULL, 3, 3,
       'Three sections, each with an id', NULL, 1, true
from public.exercises e where e.slug = 'fragments-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'nav a[href^="#"]', NULL,
       NULL, NULL, 3, 3,
       'Three fragment links in the nav', NULL, 1, true
from public.exercises e where e.slug = 'fragments-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id is unique', NULL, 1, true
from public.exercises e where e.slug = 'fragments-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'nesting'::public.requirement_kind, 'a', NULL,
       NULL, 'nav', 1, NULL,
       'The links are inside the nav', NULL, 1, true
from public.exercises e where e.slug = 'fragments-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'text_not_empty'::public.requirement_kind, 'h2', NULL,
       NULL, NULL, NULL, NULL,
       'Every section heading has text', NULL, 1, true
from public.exercises e where e.slug = 'fragments-challenge';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'paths-debug', 3, 'debug'::public.exercise_kind, 'Four broken paths',
       'You are editing `index.html` at the top level of a site whose images live in an `images/` folder and whose route pages live in `routes/`. Every path below is wrong. Fix all four.', '<a href="../about.html">About</a>
<a href="/routes/valley.html">The valley route</a>
<img src="logo.svg" alt="Riverside Cycle Hire">
<a href="#Prices">Prices</a>
<h2 id="prices">Prices</h2>', '<a href="about.html">About</a>
<a href="routes/valley.html">The valley route</a>
<img src="images/logo.svg" alt="Riverside Cycle Hire">
<a href="#prices">Prices</a>
<h2 id="prices">Prices</h2>', ARRAY['You are already at the top level, so ../ takes you above the site entirely.', 'A leading slash breaks when the page is opened as a local file — drop it.', 'The logo is inside the images folder, so the path needs that folder name.', 'Fragment links are case-sensitive: #Prices does not match id="prices".']::text[],
       55, 4,
       (select id from public.skills where slug = 'links'), false
from public.lessons l where l.slug = 'relative-and-absolute-paths';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'a', 'href',
       'about.html', NULL, NULL, NULL,
       'The About link is a simple relative path', NULL, 1, true
from public.exercises e where e.slug = 'paths-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'a', 'href',
       'routes/valley.html', NULL, NULL, NULL,
       'The route link has no leading slash', NULL, 1, true
from public.exercises e where e.slug = 'paths-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'img', 'src',
       'images/logo.svg', NULL, NULL, NULL,
       'The image path includes its folder', NULL, 1, true
from public.exercises e where e.slug = 'paths-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#prices', NULL, NULL, NULL,
       'The fragment link matches the id exactly, including case', NULL, 1, true
from public.exercises e where e.slug = 'paths-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'relative-and-absolute-paths'), NULL, 'q-dotdot', 1, 'single'::public.question_kind,
        'What does `../` mean at the start of a path?', 'It moves up one folder from where the current file lives.', (select id from public.skills where slug = 'links'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Go up one folder', true, NULL
from public.quiz_questions where slug = 'q-dotdot';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Go to the site root', false, NULL
from public.quiz_questions where slug = 'q-dotdot';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Stay in the current folder', false, NULL
from public.quiz_questions where slug = 'q-dotdot';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Go to the previous page', false, NULL
from public.quiz_questions where slug = 'q-dotdot';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'relative-and-absolute-paths'), NULL, 'q-leading-slash', 2, 'single'::public.question_kind,
        'Why can `/images/logo.svg` fail when you open a page from your own computer?', 'The leading slash means "the root", and with no server that root is your hard drive rather than your project folder.', (select id from public.skills where slug = 'links'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Browsers block absolute paths for security', false, NULL
from public.quiz_questions where slug = 'q-leading-slash';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'The image needs an absolute URL', false, NULL
from public.quiz_questions where slug = 'q-leading-slash';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'The leading slash points at the drive root, not the project folder', true, NULL
from public.quiz_questions where slug = 'q-leading-slash';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Local files cannot display SVG images', false, NULL
from public.quiz_questions where slug = 'q-leading-slash';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'relative-and-absolute-paths'), NULL, 'q-fragment-case', 3, 'single'::public.question_kind,
        'Does `href="#Prices"` reach an element with `id="prices"`?', 'No. Fragment identifiers and ids are case-sensitive, so they must match exactly.', (select id from public.skills where slug = 'links'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Yes — HTML ignores case in ids', false, NULL
from public.quiz_questions where slug = 'q-fragment-case';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Only in some browsers', false, NULL
from public.quiz_questions where slug = 'q-fragment-case';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Only if the id is on a heading', false, NULL
from public.quiz_questions where slug = 'q-fragment-case';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'No — fragments are case-sensitive', true, NULL
from public.quiz_questions where slug = 'q-fragment-case';
-- lesson: Email, telephone and download links
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'special-links', 3, 'Email, telephone and download links', 'Links that do something other than load a page', 'Three link types that make a contact page genuinely useful, especially on a phone.',
       ARRAY['Create a link that opens an email client', 'Create a tap-to-call telephone link', 'Offer a file for download with a sensible filename']::text[], 10, 40, (select id from public.skills where slug = 'links'), 0.7
from public.modules m where m.slug = 'links-and-paths';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Write mailto: and tel: links correctly","Use the download attribute","Explain why the visible text should show the address, not hide it"]}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'code_example'::public.block_type, 'The three special link types', NULL,
       '<a href="mailto:hello@example.org">hello@example.org</a>
<a href="tel:+441632960123">+44 1632 960123</a>
<a href="price-list.pdf" download="riverside-prices-2026.pdf">
  Download our price list (PDF, 240KB)
</a>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<a href="mailto:hello@example.org?subject=Bike%20hire%20enquiry">
  hello@example.org
</a>', 'html', NULL, '{"annotations":[{"line":"1","text":"`mailto:` followed by the address opens the visitor''s email program."},{"line":"1","text":"You can pre-fill a subject with `?subject=`. Spaces must be written as `%20` because a URL cannot contain a raw space."},{"line":"2","text":"Show the actual address as the link text. Someone without an email program configured can then still copy it, and it prints usefully."}]}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Telephone numbers: always international format', 'Write `tel:+441632960123` — a plus sign, the country code, then the number with no spaces or brackets. The visible text can be formatted for humans however you like. A number without a country code fails for anyone calling from abroad.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'prose'::public.block_type, NULL, 'The `download` attribute tells the browser to save a file rather than trying to display it, and its value becomes the suggested filename. This matters: a server-generated file called `doc_38271.pdf` becomes `riverside-prices-2026.pdf` on the visitor''s computer.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'callout'::public.block_type, 'Tell people what they are about to download', 'Include the file type and rough size in the link text: "Download our price list (PDF, 240KB)". People on limited data plans, slow connections or metered mobile need that information *before* they tap, not after.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'progressive_detail'::public.block_type, 'Does the download attribute always work?', 'It applies only to same-origin files — you cannot force a download of a file hosted on someone else''s domain, for good security reasons. If the file is on your own site it works everywhere current. If the browser ignores it, the link still works; it just opens the file instead of saving it, which is a perfectly acceptable fallback.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`mailto:` opens an email client; show the real address as the link text.","`tel:` should always use full international format with a `+`.","`download=\"filename\"` saves the file and suggests a better name.","Always state the file type and size in the link text."],"nextUp":"Next: assembling links into navigation."}'::jsonb
from public.lessons where slug = 'special-links';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'special-links-guided', 1, 'guided'::public.exercise_kind, 'Build a contact block',
       'Create three links: an email link to `hello@example.org` showing the address as its text, a telephone link to `+441632960123`, and a download link to `price-list.pdf` that saves as `riverside-prices-2026.pdf` and states the file type in its text.', '<h2>Contact us</h2>
<ul>
  <li></li>
  <li></li>
  <li></li>
</ul>', '<h2>Contact us</h2>
<ul>
  <li><a href="mailto:hello@example.org">hello@example.org</a></li>
  <li><a href="tel:+441632960123">+44 1632 960123</a></li>
  <li>
    <a href="price-list.pdf" download="riverside-prices-2026.pdf">
      Download our price list (PDF, 240KB)
    </a>
  </li>
</ul>', ARRAY['The email href starts with mailto: and then the address, with no space.', 'The telephone href starts with tel:+44 and continues with no spaces or brackets.', 'The download attribute takes the filename you want the visitor to receive.']::text[],
       40, 2,
       (select id from public.skills where slug = 'links'), false
from public.lessons l where l.slug = 'special-links';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_matches'::public.requirement_kind, 'a', 'href',
       '^mailto:', NULL, NULL, NULL,
       'There is a mailto link', NULL, 1, true
from public.exercises e where e.slug = 'special-links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_matches'::public.requirement_kind, 'a', 'href',
       '^tel:\+', NULL, NULL, NULL,
       'There is a tel link in international format', NULL, 1, true
from public.exercises e where e.slug = 'special-links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'a[download]', 'download',
       NULL, NULL, NULL, NULL,
       'The download link has a download attribute', NULL, 1, true
from public.exercises e where e.slug = 'special-links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'text_content'::public.requirement_kind, 'a[download]', NULL,
       'PDF', NULL, NULL, NULL,
       'The download link states the file type', NULL, 1, true
from public.exercises e where e.slug = 'special-links-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'li a', NULL,
       NULL, NULL, 3, 3,
       'All three links are inside list items', NULL, 1, true
from public.exercises e where e.slug = 'special-links-guided';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'special-links'), NULL, 'q-tel-format', 1, 'single'::public.question_kind,
        'Which `tel:` value is correct?', 'International format with a leading plus and country code, and no spaces or punctuation inside the value.', (select id from public.skills where slug = 'links'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'tel:01632 960123', false, NULL
from public.quiz_questions where slug = 'q-tel-format';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'tel:(01632) 960-123', false, NULL
from public.quiz_questions where slug = 'q-tel-format';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'tel:0044 1632 960123', false, NULL
from public.quiz_questions where slug = 'q-tel-format';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'tel:+441632960123', true, NULL
from public.quiz_questions where slug = 'q-tel-format';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'special-links'), NULL, 'q-download-attr', 2, 'single'::public.question_kind,
        'What does the `download` attribute do?', 'It asks the browser to save the file rather than display it, and its value suggests the filename to save it under.', (select id from public.skills where slug = 'links'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Counts how many times the file is downloaded', false, NULL
from public.quiz_questions where slug = 'q-download-attr';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Restricts the download to signed-in visitors', false, NULL
from public.quiz_questions where slug = 'q-download-attr';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Saves the file, using its value as the suggested filename', true, NULL
from public.quiz_questions where slug = 'q-download-attr';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Compresses the file before sending it', false, NULL
from public.quiz_questions where slug = 'q-download-attr';
-- module: Navigation and multi-page sites
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'site-navigation', 2, 'Navigation and multi-page sites', 'Menus, breadcrumbs, skip links and the folder structure that keeps a growing site sane.',
       55, true
from public.levels l where l.slug = 'navigation-architect';
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'site-navigation' and p.slug = 'links-and-paths';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0.7
from public.modules m, public.skills s
where m.slug = 'site-navigation' and s.slug = 'links';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'site-navigation' and s.slug = 'navigation';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'site-navigation' and s.slug = 'multi-page';
-- lesson: Navigation menus, breadcrumbs and skip links
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'navigation-menus', 1, 'Navigation menus, breadcrumbs and skip links', 'Three patterns every professional site uses', 'A menu is a list of links inside a `<nav>`. Getting the details right makes it work for everyone.',
       ARRAY['Build a navigation menu as a list inside a nav element', 'Mark the current page so visitors know where they are', 'Add a skip link for keyboard users']::text[], 16, 40, (select id from public.skills where slug = 'navigation'), 0.7
from public.modules m where m.slug = 'site-navigation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Build a navigation menu with correct semantics","Indicate the current page with aria-current","Add a skip link and explain who it helps"]}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'A navigation menu is a list of links. Marking it up as an actual list is not decoration — it lets a screen reader announce "navigation, list of five items", so the user knows how much there is before they start.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<nav aria-label="Main">
  <ul>
    <li><a href="index.html">Home</a></li>
    <li><a href="about.html">About</a></li>
    <li><a href="routes/index.html" aria-current="page">Routes</a></li>
    <li><a href="prices.html">Prices</a></li>
    <li><a href="contact.html">Contact</a></li>
  </ul>
</nav>', 'html', NULL, '{"annotations":[{"line":"1","text":"`<nav>` marks this as a navigation landmark. Screen-reader users can jump straight to it."},{"line":"1","text":"`aria-label=\"Main\"` names it. A page often has more than one nav — main, footer, on-this-page — and the label tells them apart."},{"line":"2-8","text":"A plain unordered list. The order is not meaningful, so `<ul>` rather than `<ol>`."},{"line":"5","text":"`aria-current=\"page\"` marks the link to the page you are already on. Screen readers announce it as \"current page\", and it can be styled differently for everyone else."}]}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'callout'::public.block_type, 'Keep navigation identical on every page', 'Same links, same order, same place. Consistency is a WCAG requirement, and it is also just good sense — people learn where things are, and moving them costs them time on every visit.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'prose'::public.block_type, NULL, 'A breadcrumb trail shows where the current page sits in the site. It is an ordered list, because the order genuinely matters.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'code_example'::public.block_type, 'A breadcrumb trail', NULL,
       '<nav aria-label="Breadcrumb">
  <ol>
    <li><a href="../index.html">Home</a></li>
    <li><a href="index.html">Routes</a></li>
    <li><a href="valley.html" aria-current="page">The valley route</a></li>
  </ol>
</nav>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'term'::public.block_type, 'Skip link', 'A link at the very top of the page that jumps past the navigation, straight to the main content.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'prose'::public.block_type, NULL, 'Someone using only a keyboard presses Tab to move between links. Without a skip link, they must Tab through every navigation item on every page before reaching the content. On a site with a twelve-item menu, that is twelve presses each time.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'code_example'::public.block_type, 'A skip link — the first focusable thing on the page', NULL,
       '<body>
  <a class="skip-link" href="#main">Skip to main content</a>

  <nav aria-label="Main"><!-- … --></nav>

  <main id="main">
    <h1>The valley route</h1>
  </main>
</body>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'callout'::public.block_type, 'A skip link must be visible when focused', 'The convention is to position it off-screen until it receives keyboard focus, then bring it into view. A skip link that stays invisible even when focused is worse than none — the user tabs into something they cannot see. The platform stylesheet in your previews handles this for you.',
       NULL, NULL, NULL, '{"tone":"accessibility"}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'Why is the skip link first?', 'Keyboard focus follows source order. For the link to be reachable before the navigation, it must appear before the navigation in the HTML — being visually positioned first is not enough. This is the clearest everyday example of a rule that runs through the whole course: the order of your markup is the order real users experience.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'checklist'::public.block_type, 'Every page in your site should have', NULL,
       NULL, NULL, NULL, '{"items":["A skip link as the first focusable element","The same `<nav>` in the same place, with the same links","`aria-current=\"page\"` on the link to the current page","A breadcrumb trail on pages more than one level deep","A `<main>` element with an `id` the skip link targets"]}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 13, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Navigation is a list of links inside `<nav>`; name each nav with `aria-label`.","`aria-current=\"page\"` marks where the visitor already is.","Breadcrumbs are an ordered list, because the order is the meaning.","A skip link must be the first focusable element and must become visible on focus."],"nextUp":"Next: organising the files themselves."}'::jsonb
from public.lessons where slug = 'navigation-menus';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'nav-guided', 1, 'guided'::public.exercise_kind, 'Build a main navigation',
       'Build a `<nav>` labelled "Main" containing a list of four links: Home, About, Prices and Contact. Mark the Prices link as the current page.', '<nav>

</nav>', '<nav aria-label="Main">
  <ul>
    <li><a href="index.html">Home</a></li>
    <li><a href="about.html">About</a></li>
    <li><a href="prices.html" aria-current="page">Prices</a></li>
    <li><a href="contact.html">Contact</a></li>
  </ul>
</nav>', ARRAY['Add aria-label="Main" to the nav element itself.', 'Inside it, build a <ul> with one <li> per link.', 'On the Prices link only, add aria-current="page".']::text[],
       40, 2,
       (select id from public.skills where slug = 'navigation'), false
from public.lessons l where l.slug = 'navigation-menus';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav has an aria-label naming it', NULL, 1, true
from public.exercises e where e.slug = 'nav-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'nesting'::public.requirement_kind, 'ul', NULL,
       NULL, 'nav', 1, NULL,
       'The links are in a list inside the nav', NULL, 1, true
from public.exercises e where e.slug = 'nav-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 4, 4,
       'There are four links', NULL, 1, true
from public.exercises e where e.slug = 'nav-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page link is marked with aria-current="page"', NULL, 1, true
from public.exercises e where e.slug = 'nav-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'accessible_name'::public.requirement_kind, 'nav a', NULL,
       NULL, NULL, NULL, NULL,
       'Every link has visible text', NULL, 1, true
from public.exercises e where e.slug = 'nav-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'skip-link-challenge', 2, 'challenge'::public.exercise_kind, 'A page with a skip link and breadcrumbs',
       'Build a page body containing, in this order: a skip link targeting `#main`, a main navigation, a breadcrumb nav, and a `<main id="main">` with an `<h1>` inside it.', '', '<a class="skip-link" href="#main">Skip to main content</a>

<nav aria-label="Main">
  <ul>
    <li><a href="../index.html">Home</a></li>
    <li><a href="index.html">Routes</a></li>
  </ul>
</nav>

<nav aria-label="Breadcrumb">
  <ol>
    <li><a href="../index.html">Home</a></li>
    <li><a href="index.html">Routes</a></li>
    <li><a href="valley.html" aria-current="page">The valley route</a></li>
  </ol>
</nav>

<main id="main">
  <h1>The valley route</h1>
  <p>Twenty-four miles, mostly flat, one long climb near the reservoir.</p>
</main>', ARRAY['The skip link comes first in the source — before any nav.', 'Two <nav> elements need two different aria-label values so they can be told apart.', 'The <main> needs id="main" for the skip link to reach it.']::text[],
       55, 4,
       (select id from public.skills where slug = 'navigation'), false
from public.lessons l where l.slug = 'navigation-menus';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'There is a skip link pointing at #main', NULL, 1, true
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'element_count'::public.requirement_kind, 'nav', NULL,
       NULL, NULL, 2, 2,
       'There are two nav elements', NULL, 1, true
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'Both navs are labelled', NULL, 1, true
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_value'::public.requirement_kind, 'main', 'id',
       'main', NULL, NULL, NULL,
       'The main element has id="main"', NULL, 1, true
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside the main element', NULL, 1, true
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'element_present'::public.requirement_kind, 'nav ol', NULL,
       NULL, NULL, NULL, NULL,
       'The breadcrumb uses an ordered list', NULL, 1, true
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'no_duplicate_ids'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Every id is unique', NULL, 1, true
from public.exercises e where e.slug = 'skip-link-challenge';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'nav-debug', 3, 'debug'::public.exercise_kind, 'Navigation that fails a keyboard user',
       'This navigation has four problems: the links are not in a list, the nav has no label, no link is marked as current, and the skip link points at an id that does not exist. Fix all four.', '<a href="#content">Skip to main content</a>
<nav>
  <a href="index.html">Home</a>
  <a href="about.html">About</a>
  <a href="contact.html">Contact</a>
</nav>
<main id="main">
  <h1>About us</h1>
</main>', '<a href="#main">Skip to main content</a>
<nav aria-label="Main">
  <ul>
    <li><a href="index.html">Home</a></li>
    <li><a href="about.html" aria-current="page">About</a></li>
    <li><a href="contact.html">Contact</a></li>
  </ul>
</nav>
<main id="main">
  <h1>About us</h1>
</main>', ARRAY['The skip link must match the id on <main>, which is "main" not "content".', 'Wrap the three links in a <ul>, one <li> each.', 'Add aria-label="Main" to the nav.', 'The h1 says "About us", so the About link is the current page.']::text[],
       50, 3,
       (select id from public.skills where slug = 'navigation'), false
from public.lessons l where l.slug = 'navigation-menus';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'The skip link targets the id that actually exists', NULL, 1, true
from public.exercises e where e.slug = 'nav-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'nesting'::public.requirement_kind, 'ul', NULL,
       NULL, 'nav', 1, NULL,
       'The links are wrapped in a list', NULL, 1, true
from public.exercises e where e.slug = 'nav-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 3, 3,
       'All three links are list items', NULL, 1, true
from public.exercises e where e.slug = 'nav-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav is labelled', NULL, 1, true
from public.exercises e where e.slug = 'nav-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page is marked', NULL, 1, true
from public.exercises e where e.slug = 'nav-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'navigation-menus'), NULL, 'q-nav-list', 1, 'single'::public.question_kind,
        'Why put navigation links inside a `<ul>`?', 'A screen reader announces the number of items, so the user knows how large the menu is before entering it.', (select id from public.skills where slug = 'navigation'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'So screen readers can announce how many links there are', true, NULL
from public.quiz_questions where slug = 'q-nav-list';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Because links cannot appear directly inside <nav>', false, NULL
from public.quiz_questions where slug = 'q-nav-list';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'To make them display vertically', false, NULL
from public.quiz_questions where slug = 'q-nav-list';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Because search engines require it', false, NULL
from public.quiz_questions where slug = 'q-nav-list';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'navigation-menus'), NULL, 'q-skip-link-position', 2, 'single'::public.question_kind,
        'Where must a skip link appear in the HTML?', 'Keyboard focus follows source order, so the skip link must be the first focusable element in the document.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Inside the <nav> element', false, NULL
from public.quiz_questions where slug = 'q-skip-link-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'At the end of the page', false, NULL
from public.quiz_questions where slug = 'q-skip-link-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'As the first focusable element, before the navigation', true, NULL
from public.quiz_questions where slug = 'q-skip-link-position';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Anywhere, as long as CSS positions it at the top', false, NULL
from public.quiz_questions where slug = 'q-skip-link-position';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'navigation-menus'), NULL, 'q-aria-current', 3, 'single'::public.question_kind,
        'What does `aria-current="page"` do?', 'It marks the link that points at the page the user is already on, so assistive technology can announce it as the current page.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Disables the link', false, NULL
from public.quiz_questions where slug = 'q-aria-current';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Highlights the link in the browser', false, NULL
from public.quiz_questions where slug = 'q-aria-current';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Tells search engines which page is canonical', false, NULL
from public.quiz_questions where slug = 'q-aria-current';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Marks the link to the page the visitor is currently viewing', true, NULL
from public.quiz_questions where slug = 'q-aria-current';
-- lesson: Milestone: connect a website
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'multi-page-milestone', 2, 'Milestone: connect a website', 'Three pages, one navigation, no broken links', 'Build the navigation that will carry your capstone site for the rest of the course.',
       ARRAY['Plan a folder structure for a multi-page site', 'Build navigation that works from every page', 'Verify that no internal link is broken']::text[], 25, 40, (select id from public.skills where slug = 'multi-page'), 0.8
from public.modules m where m.slug = 'site-navigation';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Organise a project into sensible files and folders","Build a navigation block that works identically on every page","Check every internal link resolves"]}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'A website is a set of files that reference each other. Before writing any of them, decide where things go — changing your mind later means fixing every path.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'code_example'::public.block_type, 'A structure that scales', NULL,
       'my-site/
├── index.html          the homepage
├── about.html
├── contact.html
├── prices.html
├── images/             every image, in one place
│   ├── logo.svg
│   └── workshop.jpg
└── routes/
    ├── index.html      the routes landing page
    ├── valley.html
    └── harbour.html', 'text', NULL, '{}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'checklist'::public.block_type, 'Naming rules that save you pain', NULL,
       NULL, NULL, NULL, '{"items":["Lowercase only — some servers treat `About.html` and `about.html` as different files","Hyphens between words, never spaces — a space becomes `%20` in a URL","Descriptive names: `day-rates.html`, not `page2.html`","One folder per section, with its own `index.html`","All images in `images/`, all downloads in `files/`"]}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Spaces in filenames are a real bug source', 'A file called `price list.html` must be linked as `price%20list.html`. It works, but it is ugly, easy to get wrong, and breaks the moment someone types the name by hand. Use a hyphen.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'prose'::public.block_type, NULL, 'The navigation block itself is the same on every page — but the paths inside it are not. From `index.html` the About link is `about.html`; from `routes/valley.html` it is `../about.html`. This is exactly the kind of repetition that templating tools exist to remove, and Level 5 shows how professionals handle it.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Decide your folder structure before you write the files.","Lowercase, hyphenated, descriptive filenames.","Navigation stays identical; only the paths change with depth.","Every internal link must resolve — check them all."],"nextUp":"Level 4 next: images, video and audio."}'::jsonb
from public.lessons where slug = 'multi-page-milestone';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'multipage-milestone-build', 1, 'challenge'::public.exercise_kind, 'Milestone: a connected page',
       'Build a complete `about.html` page for a site whose other pages are `index.html`, `prices.html` and `contact.html`, all at the top level. It needs the full document skeleton, a skip link, a labelled main navigation with all four links, `aria-current` on the About link, and a `<main>` containing an `<h1>` and two paragraphs — one of which contains a link to `contact.html`.', '', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About us — Riverside Cycle Hire</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>

    <nav aria-label="Main">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="about.html" aria-current="page">About</a></li>
        <li><a href="prices.html">Prices</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>

    <main id="main">
      <h1>About us</h1>
      <p>
        We have hired bikes from the same Mill Lane workshop since 1998, and
        every bike that leaves the shop has been serviced by our own mechanics.
      </p>
      <p>
        If you would like a route recommendation before you arrive,
        <a href="contact.html">send us a message</a> and we will reply the same day.
      </p>
    </main>
  </body>
</html>', ARRAY['Start with the full skeleton, including a title specific to this page.', 'The skip link is the very first thing inside <body>.', 'The nav needs aria-label, a <ul>, and four <li> items.', 'Mark the About link with aria-current="page" since this is the About page.']::text[],
       110, 4,
       (select id from public.skills where slug = 'multi-page'), false
from public.lessons l where l.slug = 'multi-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'A skip link targets #main', NULL, 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The navigation is labelled', NULL, 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 4, 4,
       'The nav contains four links', NULL, 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'The current page is marked', NULL, 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is exactly one main element', NULL, 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'attribute_value'::public.requirement_kind, 'main', 'id',
       'main', NULL, NULL, NULL,
       'The main element has the id the skip link targets', NULL, 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 9, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside main', NULL, 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 10, 'element_count'::public.requirement_kind, 'main p', NULL,
       NULL, NULL, 2, NULL,
       'At least two paragraphs of content', NULL, 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 11, 'nesting'::public.requirement_kind, 'a[href="contact.html"]', NULL,
       NULL, 'main p', 1, NULL,
       'A paragraph links to the contact page', NULL, 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 12, 'heading_order'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The heading hierarchy is correct: one <h1>, and no skipped levels', 'Start with a single <h1>, then step down one level at a time — h2 before h3.', 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 13, 'valid_nesting'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'Elements are nested legally', 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.', 1, true
from public.exercises e where e.slug = 'multipage-milestone-build';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'navigation-mission', 2, 'project_mission'::public.exercise_kind, 'Capstone mission: add navigation to every page',
       'Add the same navigation block to your capstone site''s `index.html` and `about.html`, and create a third page. Every page needs the skip link, the identical nav, and `aria-current` pointing at itself. This nav will appear on every page you build from now on.', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page title — your site</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>

    <nav aria-label="Main">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>

    <main id="main">
      <h1>Your page heading</h1>
      <p>Your content.</p>
    </main>
  </body>
</html>', '<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Prices — Riverside Cycle Hire</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <nav aria-label="Main">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="prices.html" aria-current="page">Prices</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>
    <main id="main">
      <h1>Prices</h1>
      <p>Hourly hire starts at £6, with a two-hour minimum.</p>
    </main>
  </body>
</html>', ARRAY['Copy the nav block exactly onto each page — consistency is the point.', 'On each page, move aria-current="page" to the link for that page.', 'Give every page its own <title>, not a shared one.']::text[],
       80, 3,
       (select id from public.skills where slug = 'multi-page'), false
from public.lessons l where l.slug = 'multi-page-milestone';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'doctype'::public.requirement_kind, NULL, NULL,
       NULL, NULL, NULL, NULL,
       'The page starts with <!DOCTYPE html>', 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.', 1, true
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'a', 'href',
       '#main', NULL, NULL, NULL,
       'The skip link is present', NULL, 1, true
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'nav', 'aria-label',
       NULL, NULL, NULL, NULL,
       'The nav is labelled', NULL, 1, true
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'element_count'::public.requirement_kind, 'nav li a', NULL,
       NULL, NULL, 3, NULL,
       'The nav has at least three links', NULL, 1, true
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_value'::public.requirement_kind, 'a[aria-current]', 'aria-current',
       'page', NULL, NULL, NULL,
       'This page is marked as current', NULL, 1, true
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'unique_element'::public.requirement_kind, 'main', NULL,
       NULL, NULL, NULL, NULL,
       'There is one main element', NULL, 1, true
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'nesting'::public.requirement_kind, 'h1', NULL,
       NULL, 'main', 1, NULL,
       'The h1 is inside main', NULL, 1, true
from public.exercises e where e.slug = 'navigation-mission';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 8, 'unique_element'::public.requirement_kind, 'title', NULL,
       NULL, NULL, NULL, NULL,
       'The page has its own title', NULL, 1, true
from public.exercises e where e.slug = 'navigation-mission';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'multi-page-milestone'), NULL, 'q-filenames', 1, 'single'::public.question_kind,
        'Why avoid spaces in filenames?', 'A space becomes `%20` in a URL. The link still works, but it is error-prone to type and read.', (select id from public.skills where slug = 'multi-page'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A space becomes %20 in the URL, which is easy to get wrong', true, NULL
from public.quiz_questions where slug = 'q-filenames';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Browsers refuse to load files with spaces', false, NULL
from public.quiz_questions where slug = 'q-filenames';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Spaces make files larger', false, NULL
from public.quiz_questions where slug = 'q-filenames';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'HTML forbids them', false, NULL
from public.quiz_questions where slug = 'q-filenames';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'multi-page-milestone'), NULL, 'q-nav-consistency', 2, 'single'::public.question_kind,
        'Why should navigation appear in the same place on every page?', 'Consistent navigation is a WCAG 2.2 requirement and reduces the effort of using the site for everyone, especially people with cognitive disabilities.', (select id from public.skills where slug = 'navigation'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'It makes the HTML file smaller', false, NULL
from public.quiz_questions where slug = 'q-nav-consistency';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Search engines penalise varied navigation', false, NULL
from public.quiz_questions where slug = 'q-nav-consistency';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'People learn where it is; moving it costs them effort on every page', true, NULL
from public.quiz_questions where slug = 'q-nav-consistency';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Browsers cache navigation only when it is identical', false, NULL
from public.quiz_questions where slug = 'q-nav-consistency';
-- Level 3 milestone: Navigation Architect questions
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q1', 1, 'single'::public.question_kind,
        'You are in `routes/valley.html`. How do you link to `index.html` at the top level?', '`../` moves up one folder, out of `routes/`, then `index.html` is beside you.', (select id from public.skills where slug = 'links'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'routes/index.html', false, NULL
from public.quiz_questions where slug = 'a3-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '../index.html', true, NULL
from public.quiz_questions where slug = 'a3-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'index.html', false, NULL
from public.quiz_questions where slug = 'a3-q1';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '/index.html', false, NULL
from public.quiz_questions where slug = 'a3-q1';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q2', 2, 'single'::public.question_kind,
        'Which link text is best?', 'It describes its destination and makes sense read on its own.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Download our 2026 price list (PDF)', true, NULL
from public.quiz_questions where slug = 'a3-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Click here', false, NULL
from public.quiz_questions where slug = 'a3-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Read more', false, NULL
from public.quiz_questions where slug = 'a3-q2';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'This link', false, NULL
from public.quiz_questions where slug = 'a3-q2';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q3', 3, 'single'::public.question_kind,
        'What must accompany `target="_blank"`?', '`rel="noopener noreferrer"` protects the user, and the visible text should say a new tab will open.', (select id from public.skills where slug = 'security'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'A download attribute', false, NULL
from public.quiz_questions where slug = 'a3-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'An absolute URL', false, NULL
from public.quiz_questions where slug = 'a3-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'aria-current="page"', false, NULL
from public.quiz_questions where slug = 'a3-q3';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'rel="noopener noreferrer" and a visible warning', true, NULL
from public.quiz_questions where slug = 'a3-q3';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q4', 4, 'single'::public.question_kind,
        'What does `href="#prices"` do?', 'It jumps to the element on the current page whose id is `prices`.', (select id from public.skills where slug = 'links'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Adds a hash to the URL with no effect', false, NULL
from public.quiz_questions where slug = 'a3-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Filters the page to show only prices', false, NULL
from public.quiz_questions where slug = 'a3-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Jumps to the element with id="prices" on this page', true, NULL
from public.quiz_questions where slug = 'a3-q4';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Loads a file called prices', false, NULL
from public.quiz_questions where slug = 'a3-q4';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q5', 5, 'single'::public.question_kind,
        'Which is correctly formatted for a phone link?', 'International format: a plus, the country code, then digits with no separators.', (select id from public.skills where slug = 'links'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'href="call:01632960123"', false, NULL
from public.quiz_questions where slug = 'a3-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'href="tel:+441632960123"', true, NULL
from public.quiz_questions where slug = 'a3-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'href="tel:01632 960123"', false, NULL
from public.quiz_questions where slug = 'a3-q5';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'href="phone:+441632960123"', false, NULL
from public.quiz_questions where slug = 'a3-q5';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q6', 6, 'single'::public.question_kind,
        'Which element should a breadcrumb trail use for its list?', 'The order of a breadcrumb is meaningful, so it is an ordered list.', (select id from public.skills where slug = 'navigation'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, '<ol>', true, NULL
from public.quiz_questions where slug = 'a3-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, '<ul>', false, NULL
from public.quiz_questions where slug = 'a3-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, '<dl>', false, NULL
from public.quiz_questions where slug = 'a3-q6';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, '<menu>', false, NULL
from public.quiz_questions where slug = 'a3-q6';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q7', 7, 'single'::public.question_kind,
        'A page has two `<nav>` elements. How do you distinguish them?', 'Give each an `aria-label`, so a screen reader announces "Main navigation" and "Breadcrumb navigation" rather than two identical landmarks.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Give each an id', false, NULL
from public.quiz_questions where slug = 'a3-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Nest one inside the other', false, NULL
from public.quiz_questions where slug = 'a3-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Use <nav> once and <div> for the other', false, NULL
from public.quiz_questions where slug = 'a3-q7';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Give each an aria-label', true, NULL
from public.quiz_questions where slug = 'a3-q7';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (NULL, (select id from public.assessments where slug = 'level-3-milestone'), 'a3-q8', 8, 'single'::public.question_kind,
        'Who does a skip link help most?', 'Keyboard-only users, including many screen-reader users, who would otherwise tab through the whole menu on every page.', (select id from public.skills where slug = 'accessibility'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Search engine crawlers', false, NULL
from public.quiz_questions where slug = 'a3-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'Users with colour blindness', false, NULL
from public.quiz_questions where slug = 'a3-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Keyboard-only users who would otherwise tab through the whole menu', true, NULL
from public.quiz_questions where slug = 'a3-q8';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'Mobile users on slow connections', false, NULL
from public.quiz_questions where slug = 'a3-q8';
-- --------------------------------------------------------------------------
-- Level 4: Media Specialist
-- --------------------------------------------------------------------------

insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, 'media-specialist', 4, 'Media Specialist', 'Images, video and audio that are fast, accessible and never broken',
       'Media is where beginner sites most often fall down: missing alt text, enormous files, autoplaying video, no captions. This level covers modern media properly, using the free media library built into HTML Hero.', 'You can build a media-rich page with responsive images, an accessible video with captions, and correct fallback content.', 'amber'
from public.courses c where c.slug = 'html-hero';
insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, NULL, 'level-4-milestone', 'milestone'::public.assessment_kind, 'Level 4 milestone: Media Specialist', 'Nine questions on images, responsive images, video, audio and embeds. Pass mark 75%.',
       0.75, 180, 4
from public.levels l where l.slug = 'media-specialist';
-- module: Images and alternative text
insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, 'images-and-alt-text', 1, 'Images and alternative text', 'The img element, the difference between informative and decorative images, and how to write alt text that actually carries the meaning.',
       45, false
from public.levels l where l.slug = 'media-specialist';
insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = 'images-and-alt-text' and p.slug = 'site-navigation';
insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, 0
from public.modules m, public.skills s
where m.slug = 'images-and-alt-text' and s.slug = 'images';
-- lesson: The img element
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'the-img-element', 1, 'The img element', 'src, alt, width, height — and why the last two matter more than you think', 'Four attributes. Each one prevents a specific, common problem.',
       ARRAY['Place an image with a correct path', 'Give every image an alt attribute', 'Set width and height to stop the page jumping as it loads']::text[], 14, 40, (select id from public.skills where slug = 'images'), 0.7
from public.modules m where m.slug = 'images-and-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Insert an image using a correct local path","Write an alt attribute for an informative image","Explain what width and height prevent"]}'::jsonb
from public.lessons where slug = 'the-img-element';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, '`<img>` is a void element — one tag, no closing tag. It needs two attributes to be usable, and two more to be professional.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'the-img-element';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'media_example'::public.block_type, 'A complete image element', 'Every attribute here is doing a job. The image comes from the media library built into this platform, so it works offline and its licence is documented.',
       '<img
  src="/learning-media/images/coast-sunrise.jpg"
  alt="Sunrise over a calm sea, with low headlands silhouetted against an orange sky"
  width="1200"
  height="800">', 'html', 'coast-sunrise', '{}'::jsonb
from public.lessons where slug = 'the-img-element';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'annotated_code'::public.block_type, 'Line by line', NULL,
       '<img src="/learning-media/images/coast-sunrise.jpg"
     alt="Sunrise over a calm sea, with low headlands against an orange sky"
     width="1200" height="800">', 'html', NULL, '{"annotations":[{"line":"1","text":"`src` is the path to the image file. Get this wrong and you see a broken-image icon."},{"line":"2","text":"`alt` is the text a screen reader announces, and what displays if the image fails to load. It is required on every image."},{"line":"3","text":"`width` and `height` are the image''s real pixel dimensions, written as plain numbers with no \"px\". The browser uses them to reserve the right amount of space before the file arrives, so the page does not jump when it loads."}]}'::jsonb
from public.lessons where slug = 'the-img-element';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, 'Width and height are not sizing instructions', 'They tell the browser the image''s aspect ratio so it can reserve space. CSS still controls the displayed size. Omitting them causes "layout shift" — text jumping down the page as images pop in — which is one of the most irritating things a website can do, and one of the easiest to prevent.',
       NULL, NULL, NULL, '{"tone":"tip"}'::jsonb
from public.lessons where slug = 'the-img-element';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'prose'::public.block_type, NULL, 'Every image on your page needs a path that resolves. In this course the media library gives you images that are guaranteed to work: click the media button in the editor toolbar to browse them and insert a correct path.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'the-img-element';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'callout'::public.block_type, 'Never hotlink someone else''s image', 'Pointing `src` at an image on another website — "hotlinking" — uses their bandwidth without permission, breaks the moment they move or delete the file, and is usually a copyright problem. Download images you have the right to use, put them in your own `images/` folder, and record where they came from.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'the-img-element';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'What happens when a path is wrong', 'The alt text is what saves the page.',
       NULL, NULL, NULL, '{"variants":[{"label":"Correct path","code":"<img src=\"/learning-media/images/forest-path.jpg\" alt=\"A sandy path winding between tall trees\" width=\"1200\" height=\"800\">","note":"The image loads."},{"label":"Broken path, good alt","code":"<img src=\"/learning-media/images/forest-pathh.jpg\" alt=\"A sandy path winding between tall trees\" width=\"1200\" height=\"800\">","note":"The image fails, but the alt text is displayed instead — the reader still learns what was meant to be there."},{"label":"Broken path, no alt","code":"<img src=\"/learning-media/images/forest-pathh.jpg\" width=\"1200\" height=\"800\">","note":"A broken icon and nothing else. The content is simply gone."}]}'::jsonb
from public.lessons where slug = 'the-img-element';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'progressive_detail'::public.block_type, 'Image formats, briefly', 'JPEG suits photographs. PNG suits graphics with sharp edges or transparency. SVG is drawn from instructions rather than pixels, so it stays crisp at any size — ideal for logos, icons and diagrams. WebP and AVIF are modern formats that produce noticeably smaller files than JPEG at the same quality; the next module shows how to offer them with a fallback so older browsers still get an image.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'the-img-element';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["`<img>` is a void element needing `src` and `alt`.","`width` and `height` reserve space and prevent the page jumping.","Alt text is displayed when the image fails, and read aloud by screen readers.","Use local files from your own project; never hotlink."],"nextUp":"Next: what to actually write in that alt attribute."}'::jsonb
from public.lessons where slug = 'the-img-element';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'img-guided', 1, 'guided'::public.exercise_kind, 'Place an image correctly',
       'Add an image of the workshop to this page. Use the media library path `/learning-media/images/workshop-tools.jpg`, give it descriptive alt text, and set `width="1200"` and `height="800"`.', '<h2>Our workshop</h2>
<p>Everything is serviced on site by our own mechanics.</p>
', '<h2>Our workshop</h2>
<p>Everything is serviced on site by our own mechanics.</p>
<img
  src="/learning-media/images/workshop-tools.jpg"
  alt="Hand tools hanging in rows on a workshop wall above a wooden workbench"
  width="1200"
  height="800">', ARRAY['<img> is a single tag with no closing tag.', 'Start with src="/learning-media/images/workshop-tools.jpg".', 'Then add alt="…" describing what is in the picture, plus width="1200" height="800".']::text[],
       40, 2,
       (select id from public.skills where slug = 'images'), false
from public.lessons l where l.slug = 'the-img-element';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_present'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'There is an image', NULL, 1, true
from public.exercises e where e.slug = 'img-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_value'::public.requirement_kind, 'img', 'src',
       '/learning-media/images/workshop-tools.jpg', NULL, NULL, NULL,
       'The image uses the correct library path', NULL, 1, true
from public.exercises e where e.slug = 'img-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'img', 'alt',
       NULL, NULL, NULL, NULL,
       'The image has an alt attribute', NULL, 1, true
from public.exercises e where e.slug = 'img-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'The alt text describes what the image shows', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'img-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_present'::public.requirement_kind, 'img', 'width',
       NULL, NULL, NULL, NULL,
       'The image declares its width', NULL, 1, true
from public.exercises e where e.slug = 'img-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 6, 'attribute_present'::public.requirement_kind, 'img', 'height',
       NULL, NULL, NULL, NULL,
       'The image declares its height', NULL, 1, true
from public.exercises e where e.slug = 'img-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 7, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'img-guided';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'img-debug', 2, 'debug'::public.exercise_kind, 'Three broken images',
       'Each image below has a different problem: a path that does not exist, a missing alt attribute, and a hotlinked remote URL. Fix all three using paths from the media library.', '<img src="/learning-media/images/coast.jpg" alt="Sunrise over a calm sea" width="1200" height="800">
<img src="/learning-media/images/studio-desk.jpg" width="1200" height="800">
<img src="https://example.com/photos/plate.jpg" alt="A plated dish seen from above" width="1200" height="800">', '<img src="/learning-media/images/coast-sunrise.jpg" alt="Sunrise over a calm sea" width="1200" height="800">
<img src="/learning-media/images/studio-desk.jpg" alt="An open laptop, a notebook and a coffee mug on a wooden desk" width="1200" height="800">
<img src="/learning-media/images/restaurant-plate.jpg" alt="A plated dish seen from above" width="1200" height="800">', ARRAY['Open the media library from the editor toolbar to see the real filenames.', 'The first image is missing part of its filename.', 'The second has no alt attribute at all.', 'The third points at another website — replace it with a local library path.']::text[],
       50, 3,
       (select id from public.skills where slug = 'images'), false
from public.lessons l where l.slug = 'the-img-element';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'img', NULL,
       NULL, NULL, 3, 3,
       'All three images remain', NULL, 1, true
from public.exercises e where e.slug = 'img-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'local_media_path'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every media path points at a file that exists', 'Use the media library button in the editor toolbar to insert a correct path.', 1, true
from public.exercises e where e.slug = 'img-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 3, 'attribute_present'::public.requirement_kind, 'img', 'alt',
       NULL, NULL, NULL, NULL,
       'Every image has an alt attribute', NULL, 1, true
from public.exercises e where e.slug = 'img-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 4, 'alt_quality'::public.requirement_kind, 'img', NULL,
       NULL, NULL, NULL, NULL,
       'Every image has meaningful alt text', 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.', 1, true
from public.exercises e where e.slug = 'img-debug';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 5, 'attribute_absent'::public.requirement_kind, 'img[src^="http"]', 'src',
       NULL, NULL, NULL, NULL,
       'No image is hotlinked from another site', NULL, 1, true
from public.exercises e where e.slug = 'img-debug';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'the-img-element'), NULL, 'q-img-dimensions', 1, 'single'::public.question_kind,
        'Why set `width` and `height` on an `<img>`?', 'The browser reserves the correct space before the file arrives, so surrounding content does not jump when the image loads.', (select id from public.skills where slug = 'images'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Because alt text requires them', false, NULL
from public.quiz_questions where slug = 'q-img-dimensions';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'So the browser reserves space and the page does not jump', true, NULL
from public.quiz_questions where slug = 'q-img-dimensions';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'To force the image to display at that exact size', false, NULL
from public.quiz_questions where slug = 'q-img-dimensions';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'To compress the image file', false, NULL
from public.quiz_questions where slug = 'q-img-dimensions';
insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values ((select id from public.lessons where slug = 'the-img-element'), NULL, 'q-hotlinking', 2, 'single'::public.question_kind,
        'What is wrong with pointing `src` at an image on someone else''s website?', 'It uses their bandwidth, breaks when they move the file, and is usually a copyright problem.', (select id from public.skills where slug = 'images'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'Nothing — this is standard practice', false, NULL
from public.quiz_questions where slug = 'q-hotlinking';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 2, 'It uses their bandwidth, breaks easily, and is usually a copyright problem', true, NULL
from public.quiz_questions where slug = 'q-hotlinking';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 3, 'Browsers block cross-domain images', false, NULL
from public.quiz_questions where slug = 'q-hotlinking';
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 4, 'It makes your page load faster but looks unprofessional', false, NULL
from public.quiz_questions where slug = 'q-hotlinking';
-- lesson: Writing alt text that carries the meaning
insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, 'writing-alt-text', 2, 'Writing alt text that carries the meaning', 'Informative, decorative, and the surprisingly common empty alt', 'Good alt text is a writing skill, not a technical one. The rule is simpler than most people expect.',
       ARRAY['Decide whether an image is informative or decorative', 'Write alt text that replaces the image, rather than describing it', 'Use `alt=""` correctly']::text[], 14, 40, (select id from public.skills where slug = 'images'), 0.7
from public.modules m where m.slug = 'images-and-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 1, 'objectives'::public.block_type, 'What you will be able to do', NULL,
       NULL, NULL, NULL, '{"items":["Classify an image as informative or decorative","Write alt text that conveys the image''s purpose","Use an empty alt attribute where it is the correct answer"]}'::jsonb
from public.lessons where slug = 'writing-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 2, 'prose'::public.block_type, NULL, 'The test is this: if you were reading the page aloud to someone on the telephone, what would you say when you reached this image? That sentence is your alt text. Sometimes the honest answer is "nothing" — and that is a real answer, written as `alt=""`.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'writing-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 3, 'term'::public.block_type, 'Informative image', 'An image that adds meaning the surrounding text does not already carry. It needs alt text describing that meaning.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'writing-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 4, 'term'::public.block_type, 'Decorative image', 'An image that adds atmosphere but no information — a background texture, a divider, an icon beside a word that already says the same thing. It takes `alt=""`, which tells screen readers to skip it entirely.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'writing-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 5, 'callout'::public.block_type, '`alt=""` and no alt attribute are completely different', '`alt=""` says "I have considered this image and it carries no information — skip it." Omitting `alt` says nothing, and screen readers fall back to announcing the filename, so users hear "image, D S C underscore 0 4 8 2 dot J P G". Always include the attribute; make it empty only on purpose.',
       NULL, NULL, NULL, '{"tone":"warning"}'::jsonb
from public.lessons where slug = 'writing-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 6, 'comparison'::public.block_type, 'Alt text for the same photograph, in two different contexts', NULL,
       NULL, NULL, NULL, '{"good":{"label":"On a page about the workshop","code":"<img src=\"/learning-media/images/workshop-tools.jpg\"\n     alt=\"Hand tools hanging in labelled rows above a workbench\">","why":"The image is showing the reader what the workshop is like. That is information."},"bad":{"label":"As a background strip on a contact page","code":"<img src=\"/learning-media/images/workshop-tools.jpg\" alt=\"\">","why":"Here it is atmosphere. Describing it would interrupt the reader for no benefit."}}'::jsonb
from public.lessons where slug = 'writing-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 7, 'checklist'::public.block_type, 'Alt text that works', NULL,
       NULL, NULL, NULL, '{"items":["Describe the *purpose*, not every detail — one useful sentence","Do not start with \"Image of\" or \"Picture of\" — the screen reader already says \"image\"","Do not repeat text that sits right next to the image","For a photograph of a person, say who they are, not what they are wearing","For a chart, give the conclusion the chart shows, and put the data in a table nearby","For an image inside a link, describe where the link goes"]}'::jsonb
from public.lessons where slug = 'writing-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 8, 'interactive_demo'::public.block_type, 'Four attempts at the same image', 'The image shows a plated dish on a restaurant menu page.',
       NULL, NULL, NULL, '{"variants":[{"label":"Best","code":"<img src=\"/learning-media/images/restaurant-plate.jpg\" alt=\"Slow-roast lamb with charred aubergine and flatbread\" width=\"1200\" height=\"800\">","note":"Tells the reader what the dish is — exactly what a sighted reader gets from looking."},{"label":"Too vague","code":"<img src=\"/learning-media/images/restaurant-plate.jpg\" alt=\"Food\" width=\"1200\" height=\"800\">","note":"Technically present, practically useless."},{"label":"Redundant","code":"<img src=\"/learning-media/images/restaurant-plate.jpg\" alt=\"Image of a photo of food\" width=\"1200\" height=\"800\">","note":"Screen readers already announce \"image\". This says it three times and describes nothing."},{"label":"Filename","code":"<img src=\"/learning-media/images/restaurant-plate.jpg\" alt=\"restaurant-plate.jpg\" width=\"1200\" height=\"800\">","note":"The commonest automated mistake. It tells the reader nothing at all."}]}'::jsonb
from public.lessons where slug = 'writing-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 9, 'prose'::public.block_type, NULL, '`<figure>` and `<figcaption>` group an image with a caption. A caption is visible to everyone; alt text is for people who cannot see the image. They are not the same thing and should not be identical — the caption might name a photographer, while the alt text describes the scene.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'writing-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 10, 'code_example'::public.block_type, 'A figure with both a caption and alt text', NULL,
       '<figure>
  <img src="/learning-media/images/city-dusk.jpg"
       alt="A city skyline at dusk with hundreds of lit office windows"
       width="1200" height="800">
  <figcaption>The financial district, photographed from the river path.</figcaption>
</figure>', 'html', NULL, '{}'::jsonb
from public.lessons where slug = 'writing-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 11, 'progressive_detail'::public.block_type, 'When the caption already says it', 'If a caption fully describes the image, repeating it in the alt text makes a screen-reader user hear the same sentence twice in a row. In that case `alt=""` is the right choice: the caption is already doing the job, and it is available to everybody. This is one of the few places where an empty alt on a clearly informative image is correct.',
       NULL, NULL, NULL, '{}'::jsonb
from public.lessons where slug = 'writing-alt-text';
insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, 12, 'summary'::public.block_type, 'Lesson summary', NULL,
       NULL, NULL, NULL, '{"points":["Ask: what would I say if I were reading this page aloud?","Informative images need descriptive alt; decorative images take `alt=\"\"`.","`alt=\"\"` and a missing `alt` are not the same — always include the attribute.","Captions and alt text serve different audiences and should not duplicate each other."],"nextUp":"Next: serving the right image for the screen."}'::jsonb
from public.lessons where slug = 'writing-alt-text';
insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, 'alt-guided', 1, 'guided'::public.exercise_kind, 'Fix four alt attributes',
       'Each image below has poor alt text. Rewrite them: the first is informative and needs a real description; the second is purely decorative and should be `alt=""`; the third must not start with "Image of"; the fourth must not be a filename.', '<img src="/learning-media/images/team-portrait.jpg" alt="photo" width="1067" height="1600">
<img src="/learning-media/svg/placeholder.svg" alt="decorative background pattern here" width="800" height="500">
<img src="/learning-media/images/vehicle-hire.jpg" alt="Image of a car" width="1200" height="800">
<img src="/learning-media/images/event-stage.jpg" alt="event-stage.jpg" width="1200" height="800">', '<img src="/learning-media/images/team-portrait.jpg" alt="Amara Okonjo, our head mechanic" width="1067" height="1600">
<img src="/learning-media/svg/placeholder.svg" alt="" width="800" height="500">
<img src="/learning-media/images/vehicle-hire.jpg" alt="A blue five-door hire car parked on an open road" width="1200" height="800">
<img src="/learning-media/images/event-stage.jpg" alt="A crowd watching a stage lit by pink and blue lights" width="1200" height="800">', ARRAY['For the portrait, say who the person is — that is what a sighted reader learns.', 'A purely decorative image takes alt="" — an empty value, but the attribute must still be there.', 'Delete "Image of" and describe the car instead.', 'Replace the filename with a sentence about what is in the picture.']::text[],
       50, 3,
       (select id from public.skills where slug = 'images'), false
from public.lessons l where l.slug = 'writing-alt-text';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 1, 'element_count'::public.requirement_kind, 'img', NULL,
       NULL, NULL, 4, 4,
       'All four images remain', NULL, 1, true
from public.exercises e where e.slug = 'alt-guided';
insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical)
select e.id, 2, 'attribute_present'::public.requirement_kind, 'img', 'alt',
       NULL, NULL, NULL, NULL,
       'Every image has an alt attribute', NULL, 1, true
from public.exercises e where e.slug = 'alt-guided';
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
from public.lessons l where l.slug = 'writing-alt-text';
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
        'When is `alt=""` the correct choice?', 'When the image is purely decorative and adds no information, so a screen reader should skip it entirely.', (select id from public.skills where slug = 'images'), 10);
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
        'How do alt text and a `<figcaption>` differ?', 'A caption is visible to everyone and adds context; alt text replaces the image for people who cannot see it.', (select id from public.skills where slug = 'images'), 10);
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
        'What happens if you omit the `alt` attribute entirely?', 'Screen readers commonly fall back to reading the filename aloud, which is worse than useless.', (select id from public.skills where slug = 'accessibility'), 10);
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
from public.levels l where l.slug = 'media-specialist';
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
from public.modules m where m.slug = 'responsive-images';
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
from public.lessons l where l.slug = 'srcset-and-sizes';
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
from public.lessons l where l.slug = 'srcset-and-sizes';
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
        'What does `800w` in a srcset mean?', 'It describes the file: this image file is 800 pixels wide. It is not an instruction about display size.', (select id from public.skills where slug = 'responsive-images'), 10);
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
        'Why is a `sizes` attribute needed?', 'The browser starts choosing an image before layout is complete, so it needs you to describe how wide the image will be.', (select id from public.skills where slug = 'responsive-images'), 10);
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
from public.modules m where m.slug = 'responsive-images';
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
from public.lessons l where l.slug = 'picture-and-formats';
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
from public.lessons l where l.slug = 'picture-and-formats';
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
        'Why must a `<picture>` contain an `<img>`?', '`<picture>` and `<source>` render nothing themselves. The `<img>` is what actually displays, and it carries the alt text.', (select id from public.skills where slug = 'responsive-images'), 10);
insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, 1, 'The <img> is what actually displays, and holds the alt text', true, NULL
from public.quiz_questions where slug = 'q-picture-img';

commit;
