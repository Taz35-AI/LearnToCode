import {
  annotated,
  attr,
  attrMatches,
  attrValue,
  callout,
  checklist,
  code,
  compare,
  count,
  demo,
  detail,
  goodAlt,
  inside,
  legalNesting,
  mediaExample,
  mediaResolves,
  notEmpty,
  objectives,
  present,
  prose,
  recap,
  term,
  visual,
  type LevelSpec,
} from '../types';

export const LEVEL_04: LevelSpec = {
  slug: 'media-specialist',
  title: 'Media Specialist',
  subtitle: 'Images, video and audio that are fast, accessible and never broken',
  summary:
    'Media is where beginner sites most often fall down: missing alt text, enormous files, autoplaying video, no captions. This level covers modern media properly, using the free media library built into HTML Hero.',
  outcome:
    'You can build a media-rich page with responsive images, an accessible video with captions, and correct fallback content.',
  accent: 'amber',
  modules: [
    {
      slug: 'images-and-alt-text',
      title: 'Images and alternative text',
      summary:
        'The img element, the difference between informative and decorative images, and how to write alt text that actually carries the meaning.',
      estimatedMinutes: 45,
      prerequisites: ['site-navigation'],
      skills: [{ slug: 'images', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'the-img-element',
          title: 'The img element',
          subtitle: 'src, alt, width, height — and why the last two matter more than you think',
          summary:
            'Four attributes. Each one prevents a specific, common problem.',
          objectives: [
            'Place an image with a correct path',
            'Give every image an alt attribute',
            'Set width and height to stop the page jumping as it loads',
          ],
          estimatedMinutes: 14,
          skill: 'images',
          blocks: [
            objectives([
              'Insert an image using a correct local path',
              'Write an alt attribute for an informative image',
              'Explain what width and height prevent',
            ]),
            prose(
              '`<img>` is a void element — one tag, no closing tag. It needs two attributes to be usable, and two more to be professional.',
            ),
            mediaExample(
              'coast-sunrise',
              'A complete image element',
              'Every attribute here is doing a job. The image comes from the media library built into this platform, so it works offline and its licence is documented.',
              `<img
  src="/learning-media/images/coast-sunrise.jpg"
  alt="Sunrise over a calm sea, with low headlands silhouetted against an orange sky"
  width="1200"
  height="800">`,
            ),
            annotated(
              `<img src="/learning-media/images/coast-sunrise.jpg"
     alt="Sunrise over a calm sea, with low headlands against an orange sky"
     width="1200" height="800">`,
              [
                { line: '1', text: '`src` is the path to the image file. Get this wrong and you see a broken-image icon.' },
                {
                  line: '2',
                  text: '`alt` is the text a screen reader announces, and what displays if the image fails to load. It is required on every image.',
                },
                {
                  line: '3',
                  text: '`width` and `height` are the image\'s real pixel dimensions, written as plain numbers with no "px". The browser uses them to reserve the right amount of space before the file arrives, so the page does not jump when it loads.',
                },
              ],
            ),
            callout(
              'tip',
              'Width and height are not sizing instructions',
              'They tell the browser the image\'s aspect ratio so it can reserve space. CSS still controls the displayed size. Omitting them causes "layout shift" — text jumping down the page as images pop in — which is one of the most irritating things a website can do, and one of the easiest to prevent.',
            ),
            prose(
              'Every image on your page needs a path that resolves. In this course the media library gives you images that are guaranteed to work: click the media button in the editor toolbar to browse them and insert a correct path.',
            ),
            callout(
              'warning',
              'Never hotlink someone else\'s image',
              'Pointing `src` at an image on another website — "hotlinking" — uses their bandwidth without permission, breaks the moment they move or delete the file, and is usually a copyright problem. Download images you have the right to use, put them in your own `images/` folder, and record where they came from.',
            ),
            demo('What happens when a path is wrong', 'The alt text is what saves the page.', [
              {
                label: 'Correct path',
                code: '<img src="/learning-media/images/forest-path.jpg" alt="A sandy path winding between tall trees" width="1200" height="800">',
                note: 'The image loads.',
              },
              {
                label: 'Broken path, good alt',
                code: '<img src="/learning-media/images/forest-pathh.jpg" alt="A sandy path winding between tall trees" width="1200" height="800">',
                note: 'The image fails, but the alt text is displayed instead — the reader still learns what was meant to be there.',
              },
              {
                label: 'Broken path, no alt',
                code: '<img src="/learning-media/images/forest-pathh.jpg" width="1200" height="800">',
                note: 'A broken icon and nothing else. The content is simply gone.',
              },
            ]),
            detail(
              'Image formats, briefly',
              'JPEG suits photographs. PNG suits graphics with sharp edges or transparency. SVG is drawn from instructions rather than pixels, so it stays crisp at any size — ideal for logos, icons and diagrams. WebP and AVIF are modern formats that produce noticeably smaller files than JPEG at the same quality; the next module shows how to offer them with a fallback so older browsers still get an image.',
            ),
            recap(
              [
                '`<img>` is a void element needing `src` and `alt`.',
                '`width` and `height` reserve space and prevent the page jumping.',
                'Alt text is displayed when the image fails, and read aloud by screen readers.',
                'Use local files from your own project; never hotlink.',
              ],
              'Next: what to actually write in that alt attribute.',
            ),
          ],
          exercises: [
            {
              slug: 'img-guided',
              kind: 'guided',
              title: 'Place an image correctly',
              brief:
                'Add an image of the workshop to this page. Use the media library path `/learning-media/images/workshop-tools.jpg`, give it descriptive alt text, and set `width="1200"` and `height="800"`.',
              starterCode: `<h2>Our workshop</h2>
<p>Everything is serviced on site by our own mechanics.</p>
`,
              referenceSolution: `<h2>Our workshop</h2>
<p>Everything is serviced on site by our own mechanics.</p>
<img
  src="/learning-media/images/workshop-tools.jpg"
  alt="Hand tools hanging in rows on a workshop wall above a wooden workbench"
  width="1200"
  height="800">`,
              hints: [
                '<img> is a single tag with no closing tag.',
                'Start with src="/learning-media/images/workshop-tools.jpg".',
                'Then add alt="…" describing what is in the picture, plus width="1200" height="800".',
              ],
              requirements: [
                present('img', 'There is an image'),
                attrValue('img', 'src', '/learning-media/images/workshop-tools.jpg', 'The image uses the correct library path'),
                attr('img', 'alt', 'The image has an alt attribute'),
                goodAlt('img', 'The alt text describes what the image shows'),
                attr('img', 'width', 'The image declares its width'),
                attr('img', 'height', 'The image declares its height'),
                mediaResolves('img'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'images',
            },
            {
              slug: 'img-debug',
              kind: 'debug',
              title: 'Three broken images',
              brief:
                'Each image below has a different problem: a path that does not exist, a missing alt attribute, and a hotlinked remote URL. Fix all three using paths from the media library.',
              starterCode: `<img src="/learning-media/images/coast.jpg" alt="Sunrise over a calm sea" width="1200" height="800">
<img src="/learning-media/images/studio-desk.jpg" width="1200" height="800">
<img src="https://example.com/photos/plate.jpg" alt="A plated dish seen from above" width="1200" height="800">`,
              referenceSolution: `<img src="/learning-media/images/coast-sunrise.jpg" alt="Sunrise over a calm sea" width="1200" height="800">
<img src="/learning-media/images/studio-desk.jpg" alt="An open laptop, a notebook and a coffee mug on a wooden desk" width="1200" height="800">
<img src="/learning-media/images/restaurant-plate.jpg" alt="A plated dish seen from above" width="1200" height="800">`,
              hints: [
                'Open the media library from the editor toolbar to see the real filenames.',
                'The first image is missing part of its filename.',
                'The second has no alt attribute at all.',
                'The third points at another website — replace it with a local library path.',
              ],
              requirements: [
                count('img', 3, 3, 'All three images remain'),
                mediaResolves('img'),
                attr('img', 'alt', 'Every image has an alt attribute'),
                goodAlt('img', 'Every image has meaningful alt text'),
                { kind: 'attribute_absent', selector: 'img[src^="http"]', attribute: 'src', message: 'No image is hotlinked from another site' },
              ],
              difficulty: 3,
              xp: 50,
              skill: 'images',
            },
          ],
          quiz: [
            {
              slug: 'q-img-dimensions',
              prompt: 'Why set `width` and `height` on an `<img>`?',
              explanation:
                'The browser reserves the correct space before the file arrives, so surrounding content does not jump when the image loads.',
              options: [
                { label: 'So the browser reserves space and the page does not jump', correct: true },
                { label: 'To force the image to display at that exact size' },
                { label: 'To compress the image file' },
                { label: 'Because alt text requires them' },
              ],
              skill: 'images',
            },
            {
              slug: 'q-hotlinking',
              prompt: 'What is wrong with pointing `src` at an image on someone else\'s website?',
              explanation:
                'It uses their bandwidth, breaks when they move the file, and is usually a copyright problem.',
              options: [
                { label: 'It uses their bandwidth, breaks easily, and is usually a copyright problem', correct: true },
                { label: 'Browsers block cross-domain images' },
                { label: 'It makes your page load faster but looks unprofessional' },
                { label: 'Nothing — this is standard practice' },
              ],
              skill: 'images',
            },
          ],
        },
        {
          slug: 'writing-alt-text',
          title: 'Writing alt text that carries the meaning',
          subtitle: 'Informative, decorative, and the surprisingly common empty alt',
          summary:
            'Good alt text is a writing skill, not a technical one. The rule is simpler than most people expect.',
          objectives: [
            'Decide whether an image is informative or decorative',
            'Write alt text that replaces the image, rather than describing it',
            'Use `alt=""` correctly',
          ],
          estimatedMinutes: 14,
          skill: 'images',
          blocks: [
            objectives([
              'Classify an image as informative or decorative',
              'Write alt text that conveys the image\'s purpose',
              'Use an empty alt attribute where it is the correct answer',
            ]),
            prose(
              'The test is this: if you were reading the page aloud to someone on the telephone, what would you say when you reached this image? That sentence is your alt text. Sometimes the honest answer is "nothing" — and that is a real answer, written as `alt=""`.',
            ),
            term(
              'Informative image',
              'An image that adds meaning the surrounding text does not already carry. It needs alt text describing that meaning.',
            ),
            term(
              'Decorative image',
              'An image that adds atmosphere but no information — a background texture, a divider, an icon beside a word that already says the same thing. It takes `alt=""`, which tells screen readers to skip it entirely.',
            ),
            callout(
              'warning',
              '`alt=""` and no alt attribute are completely different',
              '`alt=""` says "I have considered this image and it carries no information — skip it." Omitting `alt` says nothing, and screen readers fall back to announcing the filename, so users hear "image, D S C underscore 0 4 8 2 dot J P G". Always include the attribute; make it empty only on purpose.',
            ),
            compare(
              'Alt text for the same photograph, in two different contexts',
              {
                label: 'On a page about the workshop',
                code: '<img src="/learning-media/images/workshop-tools.jpg"\n     alt="Hand tools hanging in labelled rows above a workbench">',
                why: 'The image is showing the reader what the workshop is like. That is information.',
              },
              {
                label: 'As a background strip on a contact page',
                code: '<img src="/learning-media/images/workshop-tools.jpg" alt="">',
                why: 'Here it is atmosphere. Describing it would interrupt the reader for no benefit.',
              },
            ),
            checklist('Alt text that works', [
              'Describe the *purpose*, not every detail — one useful sentence',
              'Do not start with "Image of" or "Picture of" — the screen reader already says "image"',
              'Do not repeat text that sits right next to the image',
              'For a photograph of a person, say who they are, not what they are wearing',
              'For a chart, give the conclusion the chart shows, and put the data in a table nearby',
              'For an image inside a link, describe where the link goes',
            ]),
            demo('Four attempts at the same image', 'The image shows a plated dish on a restaurant menu page.', [
              {
                label: 'Best',
                code: '<img src="/learning-media/images/restaurant-plate.jpg" alt="Slow-roast lamb with charred aubergine and flatbread" width="1200" height="800">',
                note: 'Tells the reader what the dish is — exactly what a sighted reader gets from looking.',
              },
              {
                label: 'Too vague',
                code: '<img src="/learning-media/images/restaurant-plate.jpg" alt="Food" width="1200" height="800">',
                note: 'Technically present, practically useless.',
              },
              {
                label: 'Redundant',
                code: '<img src="/learning-media/images/restaurant-plate.jpg" alt="Image of a photo of food" width="1200" height="800">',
                note: 'Screen readers already announce "image". This says it three times and describes nothing.',
              },
              {
                label: 'Filename',
                code: '<img src="/learning-media/images/restaurant-plate.jpg" alt="restaurant-plate.jpg" width="1200" height="800">',
                note: 'The commonest automated mistake. It tells the reader nothing at all.',
              },
            ]),
            prose(
              '`<figure>` and `<figcaption>` group an image with a caption. A caption is visible to everyone; alt text is for people who cannot see the image. They are not the same thing and should not be identical — the caption might name a photographer, while the alt text describes the scene.',
            ),
            code(
              `<figure>
  <img src="/learning-media/images/city-dusk.jpg"
       alt="A city skyline at dusk with hundreds of lit office windows"
       width="1200" height="800">
  <figcaption>The financial district, photographed from the river path.</figcaption>
</figure>`,
              'A figure with both a caption and alt text',
            ),
            detail(
              'When the caption already says it',
              'If a caption fully describes the image, repeating it in the alt text makes a screen-reader user hear the same sentence twice in a row. In that case `alt=""` is the right choice: the caption is already doing the job, and it is available to everybody. This is one of the few places where an empty alt on a clearly informative image is correct.',
            ),
            mediaExample(
              'placeholder',
              'The decorative case, in full',
              'A neutral graphic carrying no information. The correct alt text is empty — present, but with nothing in it — so assistive technology skips it instead of announcing a filename.',
              `<img src="/learning-media/svg/placeholder.svg" alt=""
     width="600" height="400">`,
            ),
            recap(
              [
                'Ask: what would I say if I were reading this page aloud?',
                'Informative images need descriptive alt; decorative images take `alt=""`.',
                '`alt=""` and a missing `alt` are not the same — always include the attribute.',
                'Captions and alt text serve different audiences and should not duplicate each other.',
              ],
              'Next: serving the right image for the screen.',
            ),
          ],
          exercises: [
            {
              slug: 'alt-guided',
              kind: 'guided',
              title: 'Fix four alt attributes',
              brief:
                'Each image below has poor alt text. Rewrite them: the first is informative and needs a real description; the second is purely decorative and should be `alt=""`; the third must not start with "Image of"; the fourth must not be a filename.',
              starterCode: `<img src="/learning-media/images/team-portrait.jpg" alt="photo" width="1067" height="1600">
<img src="/learning-media/svg/placeholder.svg" alt="decorative background pattern here" width="800" height="500">
<img src="/learning-media/images/vehicle-hire.jpg" alt="Image of a car" width="1200" height="800">
<img src="/learning-media/images/event-stage.jpg" alt="event-stage.jpg" width="1200" height="800">`,
              referenceSolution: `<img src="/learning-media/images/team-portrait.jpg" alt="Amara Okonjo, our head mechanic" width="1067" height="1600">
<img src="/learning-media/svg/placeholder.svg" alt="" width="800" height="500">
<img src="/learning-media/images/vehicle-hire.jpg" alt="A blue five-door hire car parked on an open road" width="1200" height="800">
<img src="/learning-media/images/event-stage.jpg" alt="A crowd watching a stage lit by pink and blue lights" width="1200" height="800">`,
              hints: [
                'For the portrait, say who the person is — that is what a sighted reader learns.',
                'A purely decorative image takes alt="" — an empty value, but the attribute must still be there.',
                'Delete "Image of" and describe the car instead.',
                'Replace the filename with a sentence about what is in the picture.',
              ],
              requirements: [
                count('img', 4, 4, 'All four images remain'),
                attr('img', 'alt', 'Every image has an alt attribute'),
                goodAlt('img', 'No alt text is a filename, a placeholder, or starts with "image of"'),
                mediaResolves('img'),
                { kind: 'element_count', selector: 'img[alt=""]', minCount: 1, maxCount: 1, message: 'Exactly one image is marked decorative with alt=""' },
              ],
              difficulty: 3,
              xp: 50,
              skill: 'images',
            },
            {
              slug: 'figure-challenge',
              kind: 'challenge',
              title: 'A figure with a caption',
              brief:
                'Build a `<figure>` containing an image from the media library, with descriptive alt text and dimensions, plus a `<figcaption>` that says something the alt text does not — for example, where or when it was taken.',
              starterCode: '',
              referenceSolution: `<figure>
  <img src="/learning-media/images/forest-path.jpg"
       alt="A sandy path winding between tall trees in a sunlit forest"
       width="1200" height="800">
  <figcaption>
    The northern approach to the reservoir, halfway along the valley route.
  </figcaption>
</figure>`,
              hints: [
                'The <figure> wraps both the image and the caption.',
                'The <figcaption> can come before or after the image, but must be inside the figure.',
                'Make the caption add context rather than repeating the alt text word for word.',
              ],
              requirements: [
                present('figure', 'There is a figure'),
                inside('img', 'figure', 'The image is inside the figure'),
                inside('figcaption', 'figure', 'The caption is inside the figure'),
                notEmpty('figcaption', 'The caption has text'),
                goodAlt('img', 'The image has meaningful alt text'),
                attr('img', 'width', 'The image declares its dimensions'),
                mediaResolves('img'),
                legalNesting(),
              ],
              difficulty: 2,
              xp: 45,
              skill: 'images',
            },
          ],
          quiz: [
            {
              slug: 'q-empty-alt',
              prompt: 'When is `alt=""` the correct choice?',
              explanation:
                'When the image is purely decorative and adds no information, so a screen reader should skip it entirely.',
              options: [
                { label: 'When the image is decorative and carries no information', correct: true },
                { label: 'When you have not decided what to write yet' },
                { label: 'When the image is very small' },
                { label: 'Never — alt must always have text' },
              ],
              skill: 'images',
            },
            {
              slug: 'q-alt-vs-caption',
              prompt: 'How do alt text and a `<figcaption>` differ?',
              explanation:
                'A caption is visible to everyone and adds context; alt text replaces the image for people who cannot see it.',
              options: [
                { label: 'A caption is for everyone; alt text replaces the image for those who cannot see it', correct: true },
                { label: 'They are the same and should be identical' },
                { label: 'A caption is only for photographs' },
                { label: 'Alt text is shown on hover; captions are always visible' },
              ],
              skill: 'images',
            },
            {
              slug: 'q-missing-alt',
              prompt: 'What happens if you omit the `alt` attribute entirely?',
              explanation:
                'Screen readers commonly fall back to reading the filename aloud, which is worse than useless.',
              options: [
                { label: 'Screen readers may read the filename aloud', correct: true },
                { label: 'The image will not load' },
                { label: 'It behaves the same as alt=""' },
                { label: 'The browser generates a description automatically' },
              ],
              skill: 'accessibility',
            },
          ],
        },
      ],
    },
    {
      slug: 'responsive-images',
      title: 'Responsive images',
      summary:
        'srcset, sizes, picture and modern formats — how one image element serves a phone and a large monitor well.',
      estimatedMinutes: 45,
      prerequisites: ['images-and-alt-text'],
      skills: [{ slug: 'responsive-images', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'srcset-and-sizes',
          title: 'srcset and sizes',
          subtitle: 'Let the browser choose the right file',
          summary:
            'Sending a 1600-pixel photograph to a phone wastes most of the bytes. srcset offers the browser a choice.',
          objectives: [
            'Offer several image widths with srcset',
            'Describe the display width with sizes',
            'Explain why the browser, not you, makes the final choice',
          ],
          estimatedMinutes: 15,
          skill: 'responsive-images',
          blocks: [
            objectives([
              'Write a srcset with width descriptors',
              'Write a sizes attribute that matches your layout',
              'Explain what the browser considers when choosing',
            ]),
            visual('responsive-images', 'One image, offered at several widths. The browser picks.'),
            prose(
              'A photograph that looks sharp on a 27-inch monitor is roughly ten times more data than a phone needs. `srcset` lets you offer the same picture at several sizes and lets the browser download only the one it needs.',
            ),
            annotated(
              `<img
  src="/learning-media/images/coast-sunrise-800.jpg"
  srcset="/learning-media/images/coast-sunrise-480.jpg   480w,
          /learning-media/images/coast-sunrise-800.jpg   800w,
          /learning-media/images/coast-sunrise-1200.jpg 1200w,
          /learning-media/images/coast-sunrise-1600.jpg 1600w"
  sizes="(min-width: 60rem) 50vw, 100vw"
  alt="Sunrise over a calm sea, with low headlands against an orange sky"
  width="1200" height="800">`,
              [
                {
                  line: '2',
                  text: '`src` is the fallback. Any browser that does not understand `srcset` uses this, so the image always appears.',
                },
                {
                  line: '3-6',
                  text: '`srcset` lists the candidates. `480w` means "this file is 480 pixels wide" — a description of the file, not an instruction.',
                },
                {
                  line: '7',
                  text: '`sizes` tells the browser how wide the image will *display*. Here: on screens at least 60rem wide it fills half the viewport; otherwise the full width.',
                },
                {
                  line: '9',
                  text: '`width` and `height` still come from one representative file, and give the browser the aspect ratio.',
                },
              ],
            ),
            callout(
              'note',
              'Why does the browser need `sizes`?',
              'The browser starts downloading images before it has finished working out the page layout — that is what makes pages feel fast. At that moment it does not yet know how wide your image will be on screen, so you have to tell it. Omit `sizes` and it assumes the image fills the whole viewport width, which usually means it downloads a file that is far too large.',
            ),
            prose(
              'The browser then combines your `sizes` value with the device\'s screen density and the user\'s current connection to choose a file. On a high-density phone screen it may pick a wider file than the raw pixel width suggests. You cannot control the outcome, and that is deliberate: the browser knows things you do not.',
            ),
            detail(
              'The other kind of srcset: pixel density',
              'For images with a fixed display size — a logo, an avatar — use density descriptors instead: `srcset="logo.png 1x, logo@2x.png 2x"`. The browser picks based on screen density alone, and no `sizes` attribute is needed. Use `w` descriptors when the image scales with the layout, and `x` descriptors when it does not.',
            ),
            callout(
              'tip',
              'The media library already has the sizes',
              'Every photograph in the HTML Hero media library is generated at 480, 800, 1200 and 1600 pixels wide. The media picker in the editor can insert a complete, correct `srcset` for you — use it while you are learning the pattern, then write one by hand to prove you can.',
            ),
            demo('One image, three requests', 'What the browser actually downloads depends on what you told it.', [
              {
                label: 'With srcset and sizes',
                code: '<img src="/learning-media/images/coast-sunrise.jpg"\n     srcset="/learning-media/images/coast-sunrise-800.jpg 800w,\n             /learning-media/images/coast-sunrise-1200.jpg 1200w,\n             /learning-media/images/coast-sunrise.jpg 1600w"\n     sizes="(max-width: 700px) 100vw, 700px"\n     alt="Sunrise over a calm sea" width="1600" height="900">',
                note: 'A phone fetches the 800-wide file. A wide screen fetches the largest. Nobody downloads more than they can display.',
              },
              {
                label: 'srcset with no sizes',
                code: '<img src="/learning-media/images/coast-sunrise.jpg"\n     srcset="/learning-media/images/coast-sunrise-800.jpg 800w,\n             /learning-media/images/coast-sunrise.jpg 1600w"\n     alt="Sunrise over a calm sea" width="1600" height="900">',
                note: 'Without sizes the browser assumes the image spans the full viewport width, and usually fetches larger than it needs.',
              },
              {
                label: 'A single large file',
                code: '<img src="/learning-media/images/coast-sunrise.jpg"\n     alt="Sunrise over a calm sea" width="1600" height="900">',
                note: 'Everyone downloads the full-size file, including a phone that will display it 400 pixels wide.',
              },
            ]),
            mediaExample(
              'responsive-layout',
              'What responsive actually looks like',
              'A layout reflowing from three columns to one as the viewport narrows. `srcset` is the image half of this: the same page asking for a different file at each of those widths.',
              `<video controls preload="metadata"
       poster="/learning-media/posters/responsive-layout.jpg"
       width="1280" height="720">
  <source src="/learning-media/video/responsive-layout.mp4" type="video/mp4">
  <p>Your browser cannot play this video.
     <a href="/learning-media/video/responsive-layout.mp4">Download the MP4</a>.</p>
</video>`,
            ),
            recap(
              [
                '`srcset` offers candidate files with `w` descriptors giving each file\'s real width.',
                '`sizes` tells the browser how wide the image will display, before layout is known.',
                '`src` remains as the fallback for browsers that do not understand `srcset`.',
                'The browser makes the final choice, using information you do not have.',
              ],
              'Next: art direction and modern formats with `<picture>`.',
            ),
          ],
          exercises: [
            {
              slug: 'srcset-guided',
              kind: 'guided',
              title: 'Add a srcset',
              brief:
                'This image only offers one size. Add a `srcset` listing the 480, 800, 1200 and 1600 pixel versions with correct `w` descriptors, and a `sizes` value of `(min-width: 60rem) 50vw, 100vw`.',
              starterCode: `<img
  src="/learning-media/images/forest-path-800.jpg"
  alt="A sandy path winding between tall trees in a sunlit forest"
  width="1200" height="800">`,
              referenceSolution: `<img
  src="/learning-media/images/forest-path-800.jpg"
  srcset="/learning-media/images/forest-path-480.jpg   480w,
          /learning-media/images/forest-path-800.jpg   800w,
          /learning-media/images/forest-path-1200.jpg 1200w,
          /learning-media/images/forest-path-1600.jpg 1600w"
  sizes="(min-width: 60rem) 50vw, 100vw"
  alt="A sandy path winding between tall trees in a sunlit forest"
  width="1200" height="800">`,
              hints: [
                'Each entry in srcset is a path, a space, then the width followed by the letter w.',
                'Separate the entries with commas.',
                'The filenames follow the pattern forest-path-480.jpg, forest-path-800.jpg, and so on.',
              ],
              requirements: [
                attr('img', 'srcset', 'The image has a srcset'),
                attrMatches('img', 'srcset', '480w', 'The srcset offers the 480 pixel version'),
                attrMatches('img', 'srcset', '1600w', 'The srcset offers the 1600 pixel version'),
                attr('img', 'sizes', 'The image has a sizes attribute'),
                attr('img', 'src', 'A fallback src remains'),
                mediaResolves('img'),
                goodAlt('img'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'responsive-images',
            },
            {
              slug: 'srcset-debug',
              kind: 'debug',
              title: 'A srcset that downloads the wrong file',
              brief:
                'This srcset uses `px` instead of `w`, has no `sizes`, and one of its paths does not exist. Fix all three problems.',
              starterCode: `<img
  src="/learning-media/images/city-dusk-800.jpg"
  srcset="/learning-media/images/city-dusk-480.jpg 480px,
          /learning-media/images/city-dusk-900.jpg 900px,
          /learning-media/images/city-dusk-1600.jpg 1600px"
  alt="A city skyline at dusk with hundreds of lit office windows"
  width="1200" height="800">`,
              referenceSolution: `<img
  src="/learning-media/images/city-dusk-800.jpg"
  srcset="/learning-media/images/city-dusk-480.jpg   480w,
          /learning-media/images/city-dusk-800.jpg   800w,
          /learning-media/images/city-dusk-1600.jpg 1600w"
  sizes="(min-width: 60rem) 50vw, 100vw"
  alt="A city skyline at dusk with hundreds of lit office windows"
  width="1200" height="800">`,
              hints: [
                'A width descriptor is the number followed by the letter w — never px.',
                'There is no 900-pixel version. The library provides 480, 800, 1200 and 1600.',
                'Add a sizes attribute so the browser knows how wide the image will display.',
              ],
              requirements: [
                attrMatches('img', 'srcset', '\\d+w', 'The srcset uses w descriptors'),
                { kind: 'attribute_absent', selector: 'img[srcset*="px"]', attribute: 'srcset', message: 'No px units in the srcset' },
                attr('img', 'sizes', 'A sizes attribute is present'),
                mediaResolves('img'),
              ],
              difficulty: 4,
              xp: 55,
              skill: 'responsive-images',
            },
          ],
          quiz: [
            {
              slug: 'q-srcset-w',
              prompt: 'What does `800w` in a srcset mean?',
              explanation:
                'It describes the file: this image file is 800 pixels wide. It is not an instruction about display size.',
              options: [
                { label: 'This file is 800 pixels wide', correct: true },
                { label: 'Display this image at 800 pixels' },
                { label: 'Use this file on screens wider than 800 pixels' },
                { label: 'The file is 800 kilobytes' },
              ],
              skill: 'responsive-images',
            },
            {
              slug: 'q-sizes-purpose',
              prompt: 'Why is a `sizes` attribute needed?',
              explanation:
                'The browser starts choosing an image before layout is complete, so it needs you to describe how wide the image will be.',
              options: [
                { label: 'The browser chooses an image before it knows the layout', correct: true },
                { label: 'To set the CSS width of the image' },
                { label: 'To tell the server which file to send' },
                { label: 'To validate the srcset' },
              ],
              skill: 'responsive-images',
            },
          ],
        },
        {
          slug: 'picture-and-formats',
          title: 'The picture element, art direction and lazy loading',
          subtitle: 'When you need a different crop, a newer format, or a later download',
          summary:
            '`<picture>` gives you control that `srcset` alone cannot: different images entirely, and modern formats with a safe fallback.',
          objectives: [
            'Use `<picture>` to offer modern formats with a fallback',
            'Use art direction to change the crop at different screen sizes',
            'Apply lazy loading and fetch priority sensibly',
          ],
          estimatedMinutes: 15,
          skill: 'responsive-images',
          blocks: [
            objectives([
              'Offer WebP with a JPEG fallback using <picture>',
              'Serve a different crop on small screens',
              'Decide which images should be lazy-loaded and which should not',
            ]),
            prose(
              '`srcset` chooses between different sizes of the same image. `<picture>` chooses between genuinely different files — a different format, or a different crop.',
            ),
            annotated(
              `<picture>
  <source
    type="image/webp"
    srcset="/learning-media/images/studio-desk-800.webp 800w,
            /learning-media/images/studio-desk-1600.webp 1600w"
    sizes="100vw">
  <img
    src="/learning-media/images/studio-desk-1200.jpg"
    alt="An open laptop, a notebook and a coffee mug on a wooden desk"
    width="1200" height="800">
</picture>`,
              [
                { line: '1', text: '`<picture>` is a wrapper. It displays nothing itself.' },
                {
                  line: '2-6',
                  text: 'Each `<source>` is a candidate. The browser takes the first one it understands and stops looking.',
                },
                {
                  line: '3',
                  text: '`type="image/webp"` lets a browser skip this source entirely if it cannot display WebP.',
                },
                {
                  line: '7-10',
                  text: 'The `<img>` is required and must come last. It is the fallback, and it carries the `alt`, `width` and `height` for the whole picture.',
                },
              ],
            ),
            callout(
              'mistake',
              'The `<img>` inside `<picture>` is not optional',
              'Without it nothing displays at all — `<picture>` and `<source>` render nothing on their own. The `alt` also belongs on the `<img>`, not on the `<source>`.',
            ),
            prose(
              'Art direction means showing a *different* image, not just a different size. A wide landscape photograph often becomes unreadable when squeezed onto a phone; a tighter crop of the same scene works far better.',
            ),
            code(
              `<picture>
  <source media="(max-width: 40rem)"
          srcset="/learning-media/images/team-portrait-800.jpg">
  <img src="/learning-media/images/city-dusk-1200.jpg"
       alt="The team outside the workshop at dusk"
       width="1200" height="800">
</picture>`,
              'Art direction: a portrait crop on narrow screens',
            ),
            callout(
              'note',
              'srcset or picture?',
              'Use `srcset` on a plain `<img>` when it is the same picture at different sizes — that covers most cases and is far less markup. Reach for `<picture>` only when the *content* differs: a new format, or a genuinely different crop.',
            ),
            term(
              'Lazy loading',
              '`loading="lazy"` tells the browser not to download an image until the user is close to scrolling it into view.',
            ),
            compare(
              'Which images to lazy-load',
              {
                label: 'Below the fold — lazy',
                code: '<img src="/learning-media/images/newsroom-desk-800.jpg"\n     alt="Newspaper pages spread across a desk"\n     loading="lazy" width="1200" height="800">',
                why: 'The visitor may never scroll this far. Not downloading it is a straight saving.',
              },
              {
                label: 'The hero image — never lazy',
                code: '<img src="/learning-media/images/coast-sunrise-1200.jpg"\n     alt="Sunrise over a calm sea"\n     fetchpriority="high" width="1200" height="800">',
                why: 'It is visible immediately. Lazy-loading it *delays* the most important image on the page — a common and costly mistake.',
              },
            ),
            term(
              'fetchpriority',
              'A hint about how urgently an image is needed. `high` on the main hero image; `low` on something incidental. Use it sparingly — the browser is usually right without help.',
            ),
            detail(
              'Why does lazy loading a hero image hurt so much?',
              'Lazy-loaded images are deprioritised until the browser has calculated layout, which delays the largest visible image — the exact thing performance measurements such as Largest Contentful Paint measure. The rule of thumb: images visible without scrolling should never be lazy; everything else should be. Level 10 returns to this with the full performance picture.',
            ),
            demo('Choosing a format, and the fallback that must be there', 'The browser takes the first source it understands.', [
              {
                label: 'Modern format with a fallback',
                code: '<picture>\n  <source srcset="/learning-media/images/city-dusk.webp" type="image/webp">\n  <img src="/learning-media/images/city-dusk.jpg"\n       alt="A city skyline at dusk with hundreds of lit office windows"\n       width="1600" height="900">\n</picture>',
                note: 'A browser that understands WebP takes it; anything else falls through to the JPEG. The <img> is what actually renders.',
              },
              {
                label: 'Art direction',
                code: '<picture>\n  <source media="(max-width: 600px)" srcset="/learning-media/images/city-dusk-800.jpg">\n  <img src="/learning-media/images/city-dusk.jpg"\n       alt="A city skyline at dusk with hundreds of lit office windows"\n       width="1600" height="900">\n</picture>',
                note: 'Here the choice is by viewport, not format — a differently cropped image on narrow screens. That is what <picture> is for; plain srcset cannot do it.',
              },
              {
                label: 'No img fallback',
                code: '<picture>\n  <source srcset="/learning-media/images/city-dusk.webp" type="image/webp">\n</picture>',
                note: 'Nothing renders at all. The <img> inside <picture> is not optional — it is the element that displays, and the sources merely redirect it.',
              },
            ]),
            mediaExample(
              'city-dusk',
              'One photograph, several possible files',
              'A detailed night scene is exactly where format matters: gradients and noise make it large as a JPEG, and markedly smaller in a modern format. `<picture>` is how you offer both without excluding anyone.',
              `<picture>
  <source srcset="/learning-media/images/city-dusk.jpg" type="image/jpeg">
  <img src="/learning-media/images/city-dusk.jpg"
       alt="A city skyline at dusk with hundreds of lit office windows"
       width="1600" height="900" loading="lazy" decoding="async">
</picture>`,
            ),
            recap(
              [
                '`<picture>` chooses between genuinely different files; `srcset` chooses between sizes.',
                'The `<img>` inside `<picture>` is required and carries the alt text.',
                '`loading="lazy"` for images below the fold; never for the hero image.',
                '`fetchpriority="high"` marks the one image that matters most.',
              ],
              'Next: video and audio.',
            ),
          ],
          exercises: [
            {
              slug: 'picture-guided',
              kind: 'guided',
              title: 'Offer WebP with a JPEG fallback',
              brief:
                'Wrap this image in a `<picture>` and add a `<source>` offering the WebP versions at 800 and 1600 pixels wide, with `type="image/webp"`. Leave the `<img>` as the fallback.',
              starterCode: `<img
  src="/learning-media/images/product-bottle-1200.jpg"
  alt="A dark green ceramic bottle with a cork stopper on a plain grey background"
  width="1200" height="1200">`,
              referenceSolution: `<picture>
  <source
    type="image/webp"
    srcset="/learning-media/images/product-bottle-800.webp 800w,
            /learning-media/images/product-bottle-1600.webp 1600w"
    sizes="100vw">
  <img
    src="/learning-media/images/product-bottle-1200.jpg"
    alt="A dark green ceramic bottle with a cork stopper on a plain grey background"
    width="1200" height="1200">
</picture>`,
              hints: [
                'The <picture> wraps everything; the <source> comes first and the <img> last.',
                'The <source> needs type="image/webp" and a srcset of the .webp files.',
                'Keep the alt, width and height on the <img>, not on the <source>.',
              ],
              requirements: [
                present('picture', 'There is a picture element'),
                inside('source', 'picture', 'A source element is inside the picture'),
                attrValue('source', 'type', 'image/webp', 'The source declares the WebP type'),
                attr('source', 'srcset', 'The source has a srcset'),
                inside('img', 'picture', 'The img fallback is inside the picture'),
                goodAlt('img', 'The img still carries the alt text'),
                mediaResolves('img, source'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'responsive-images',
            },
            {
              slug: 'lazy-challenge',
              kind: 'challenge',
              title: 'Three images, three loading decisions',
              brief:
                'Build a page with three images from the media library: a hero image at the top marked `fetchpriority="high"`, and two further down the page marked `loading="lazy"`. All three need alt text and dimensions.',
              starterCode: '',
              referenceSolution: `<h1>The valley route</h1>
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
     loading="lazy" width="1200" height="800">`,
              hints: [
                'The first image is visible immediately, so it must NOT be lazy.',
                'Add fetchpriority="high" to the hero image only.',
                'Add loading="lazy" to the other two.',
              ],
              requirements: [
                count('img', 3, 3, 'There are three images'),
                { kind: 'element_count', selector: 'img[loading="lazy"]', minCount: 2, maxCount: 2, message: 'Exactly two images are lazy-loaded' },
                attrValue('img', 'fetchpriority', 'high', 'The hero image is marked high priority'),
                { kind: 'element_count', selector: 'img[fetchpriority="high"][loading="lazy"]', minCount: 0, maxCount: 0, message: 'The hero image is not also lazy-loaded', hint: 'Lazy-loading the hero image delays the most important image on the page.' },
                goodAlt('img'),
                attr('img', 'width', 'Every image declares its width'),
                mediaResolves('img'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'performance',
            },
          ],
          quiz: [
            {
              slug: 'q-picture-img',
              prompt: 'Why must a `<picture>` contain an `<img>`?',
              explanation:
                '`<picture>` and `<source>` render nothing themselves. The `<img>` is what actually displays, and it carries the alt text.',
              options: [
                { label: 'The <img> is what actually displays, and holds the alt text', correct: true },
                { label: 'It is optional in modern browsers' },
                { label: 'It sets the aspect ratio only' },
                { label: 'It is required only when using WebP' },
              ],
              skill: 'responsive-images',
            },
            {
              slug: 'q-lazy-hero',
              prompt: 'Should you lazy-load the main image at the top of a page?',
              explanation:
                'No. It is visible immediately, so lazy-loading delays the most important image and measurably worsens perceived load speed.',
              options: [
                { label: 'No — it delays the most important image on the page', correct: true },
                { label: 'Yes, always lazy-load every image' },
                { label: 'Only on mobile' },
                { label: 'Only if the image is over 500KB' },
              ],
              skill: 'performance',
            },
            {
              slug: 'q-picture-vs-srcset',
              prompt: 'When do you need `<picture>` rather than `srcset` on an `<img>`?',
              explanation:
                'When the files genuinely differ — a different format the browser might not support, or a different crop.',
              options: [
                { label: 'When offering a different format or a different crop', correct: true },
                { label: 'Whenever you have more than one image size' },
                { label: 'Whenever the image is a photograph' },
                { label: 'When you want lazy loading' },
              ],
              skill: 'responsive-images',
            },
          ],
        },
      ],
    },
    {
      slug: 'video-audio-embeds',
      title: 'Video, audio and embedded content',
      summary:
        'Accessible media with captions and fallbacks, and how to embed someone else\'s content without handing them your page.',
      estimatedMinutes: 50,
      prerequisites: ['responsive-images'],
      isMilestone: true,
      skills: [
        { slug: 'audio-video', masteryRequired: 0 },
        { slug: 'embedded-content', masteryRequired: 0 },
        { slug: 'responsive-images', masteryRequired: 0.7 },
      ],
      lessons: [
        {
          slug: 'video-and-audio',
          title: 'Video and audio',
          subtitle: 'Sources, posters, controls, captions and fallbacks',
          summary:
            'Video is the easiest place to accidentally exclude people. Getting captions and controls right takes two extra lines.',
          objectives: [
            'Embed a video with multiple sources and a poster image',
            'Add captions with the track element',
            'Explain why autoplay with sound is a serious accessibility problem',
          ],
          estimatedMinutes: 16,
          skill: 'audio-video',
          blocks: [
            objectives([
              'Embed video and audio with fallback sources',
              'Add a captions track and a poster image',
              'Make correct decisions about autoplay, muting and preload',
            ]),
            mediaExample(
              'page-anatomy',
              'A complete, accessible video',
              'Every attribute below is doing something specific. Play it — the captions can be turned on from the video controls.',
              `<video
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
</video>`,
            ),
            annotated(
              `<video controls preload="metadata"
       poster="/learning-media/posters/page-anatomy.jpg"
       width="1280" height="720">
  <source src="/learning-media/video/page-anatomy.webm" type="video/webm">
  <source src="/learning-media/video/page-anatomy.mp4" type="video/mp4">
  <track kind="captions" src="/learning-media/captions/page-anatomy.en.vtt"
         srclang="en" label="English" default>
  <p>Your browser cannot play this video.</p>
</video>`,
              [
                {
                  line: '1',
                  text: '`controls` gives the visitor play, pause, volume and captions. Without it there is no way to start the video at all unless you write JavaScript.',
                },
                {
                  line: '1',
                  text: '`preload="metadata"` downloads just enough to know the duration. `auto` would fetch the whole file before anyone asks for it; `none` fetches nothing.',
                },
                {
                  line: '2',
                  text: '`poster` is the still image shown before playback. Without it the visitor sees a black rectangle.',
                },
                {
                  line: '4-5',
                  text: 'Two `<source>` elements: the browser takes the first format it supports. WebM is smaller; MP4 is universally supported. Listing WebM first means capable browsers get the smaller file.',
                },
                {
                  line: '6-7',
                  text: '`<track kind="captions">` points at a WebVTT file. `default` turns them on automatically. Captions serve deaf and hard-of-hearing viewers, anyone in a noisy place, and anyone who simply prefers to read.',
                },
                {
                  line: '8',
                  text: 'Anything after the sources is fallback content, shown only by browsers that cannot play video at all. Offer a download link rather than an apology.',
                },
              ],
            ),
            callout(
              'accessibility',
              'Autoplay with sound is genuinely harmful',
              'Unexpected sound is disorienting for screen-reader users — it plays over the voice they are listening to — and distressing for people with anxiety or sensory sensitivities. Browsers now block it, but the fix is not to work around the block. If a video must play automatically it must be `muted`, and it must still have `controls` so it can be stopped.',
            ),
            code(
              `<audio controls preload="none">
  <source src="/learning-media/audio/calm-loop.mp3" type="audio/mpeg">
  <source src="/learning-media/audio/calm-loop.wav" type="audio/wav">
  <p>
    Your browser cannot play audio.
    <a href="/learning-media/audio/calm-loop.mp3">Download the MP3</a>.
  </p>
</audio>`,
              'Audio follows exactly the same pattern',
            ),
            term(
              'WebVTT',
              'The caption file format. Plain text: a timestamp range, then the words shown during it. You can write one in any text editor.',
            ),
            code(
              `WEBVTT

00:00:00.000 --> 00:00:03.000
Every web page starts as a plain text file.

00:00:03.000 --> 00:00:06.500
The doctype tells the browser to use modern HTML rules.`,
              'Inside a .vtt caption file',
              'text',
            ),
            detail(
              'Captions, subtitles and transcripts',
              'Captions carry the dialogue *and* important non-speech sound ("[door closes]") and are aimed at viewers who cannot hear the audio. Subtitles translate dialogue for viewers who cannot understand the language but can hear fine — `kind="subtitles"` with a different `srclang`. A transcript is the whole thing as text on the page: it helps people who prefer reading, works for anyone who cannot use the player at all, and is the only version a search engine can read. Offering all three is the professional standard for important video.',
            ),
            checklist('Every video you publish', [
              '`controls`, always',
              'A `poster` image',
              'At least one `<source>`, ideally WebM and MP4',
              'A `<track kind="captions">` with a real caption file',
              'Fallback content with a download link',
              '`width` and `height` to reserve space',
              'No autoplay — or if truly necessary, `muted` and still with controls',
            ]),
            mediaExample(
              'welcome-chime',
              'A three-second clip, with controls',
              'Press play. `controls` is what makes this operable at all — without it nothing renders and nothing is focusable, so only a script could ever start it.',
              `<audio controls preload="none">
  <source src="/learning-media/audio/welcome-chime.mp3" type="audio/mpeg">
  <p>Your browser cannot play audio.
     <a href="/learning-media/audio/welcome-chime.mp3">Download the file</a>.</p>
</audio>`,
            ),
            mediaExample(
              'calm-loop',
              'A longer clip, and why `preload` matters',
              'Eight seconds of ambient tone. `preload="none"` means nothing is fetched until somebody presses play — the right default for any audio that is not the reason they came.',
              `<audio controls preload="none">
  <source src="/learning-media/audio/calm-loop.mp3" type="audio/mpeg">
  <p>Your browser cannot play audio.
     <a href="/learning-media/audio/calm-loop.mp3">Download the file</a>.</p>
</audio>`,
            ),
            demo('What each attribute is holding up', 'Remove one thing at a time from a working player.', [
              {
                label: 'Complete',
                code: '<audio controls preload="none">\n  <source src="/learning-media/audio/welcome-chime.mp3" type="audio/mpeg">\n  <p>Your browser cannot play audio. <a href="/learning-media/audio/welcome-chime.mp3">Download the file</a>.</p>\n</audio>',
                note: 'Operable by keyboard, nothing downloaded until asked for, and a working link for anyone whose browser cannot play the format.',
              },
              {
                label: 'No controls',
                code: '<audio preload="none">\n  <source src="/learning-media/audio/welcome-chime.mp3" type="audio/mpeg">\n</audio>',
                note: 'Nothing renders and nothing is focusable. The audio exists on the page and no visitor can reach it.',
              },
              {
                label: 'No fallback',
                code: '<audio controls preload="none">\n  <source src="/learning-media/audio/welcome-chime.mp3" type="audio/mpeg">\n</audio>',
                note: 'Fine until somebody arrives with a browser that cannot play MP3 — and then an empty player with no way through to the file.',
              },
            ]),
            recap(
              [
                '`<source>` elements let the browser choose a format it supports.',
                '`controls` and a `poster` are effectively mandatory.',
                '`<track kind="captions">` is what makes video usable by deaf viewers.',
                'Fallback content sits after the sources; make it a download link.',
                'Autoplay with sound is harmful and is blocked by browsers.',
              ],
              'Next: embedding other people\'s content safely.',
            ),
          ],
          exercises: [
            {
              slug: 'video-guided',
              kind: 'guided',
              title: 'Build an accessible video',
              brief:
                'Complete this video element. Add `controls`, a `poster` of `/learning-media/posters/responsive-layout.jpg`, a second `<source>` for the MP4, an English captions `<track>` pointing at `/learning-media/captions/responsive-layout.en.vtt`, and fallback content with a download link.',
              starterCode: `<video width="1280" height="720">
  <source src="/learning-media/video/responsive-layout.webm" type="video/webm">
</video>`,
              referenceSolution: `<video controls preload="metadata"
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
</video>`,
              hints: [
                'controls is a boolean attribute — just the word, with no value.',
                'The MP4 source goes after the WebM one, with type="video/mp4".',
                'The <track> needs kind, src, srclang and label; add default to switch captions on.',
                'Fallback content goes last, inside the <video>, after the track.',
              ],
              requirements: [
                attr('video', 'controls', 'The video has visible controls'),
                attr('video', 'poster', 'The video has a poster image'),
                count('video source', 2, null, 'There are at least two sources'),
                attrValue('source', 'type', 'video/mp4', 'An MP4 source is offered'),
                present('track[kind="captions"]', 'There is a captions track'),
                attrValue('track', 'srclang', 'en', 'The captions declare their language'),
                inside('a', 'video', 'Fallback content offers a download link'),
                mediaResolves('video, source, track'),
              ],
              difficulty: 3,
              xp: 60,
              skill: 'audio-video',
            },
            {
              slug: 'video-debug',
              kind: 'debug',
              title: 'A video nobody can use',
              brief:
                'This video autoplays with sound, has no controls, no captions and no poster. Repair it so it meets the checklist from this lesson.',
              starterCode: `<video autoplay loop width="1280" height="720">
  <source src="/learning-media/video/page-anatomy.mp4" type="video/mp4">
</video>`,
              referenceSolution: `<video controls preload="metadata"
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
</video>`,
              hints: [
                'Remove autoplay entirely — the visitor should decide when it starts.',
                'Add controls so it can be played, paused and muted.',
                'Add a poster and a captions track from the media library.',
                'Add fallback content with a download link at the end.',
              ],
              requirements: [
                { kind: 'attribute_absent', selector: 'video', attribute: 'autoplay', message: 'The video no longer autoplays', hint: 'Delete the autoplay attribute.' },
                attr('video', 'controls', 'The video has controls'),
                attr('video', 'poster', 'The video has a poster image'),
                present('track[kind="captions"]', 'Captions are provided'),
                inside('a', 'video', 'There is fallback content with a download link'),
                mediaResolves('video, source, track'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'audio-video',
            },
          ],
          quiz: [
            {
              slug: 'q-video-controls',
              prompt: 'What happens if you omit `controls` from a `<video>`?',
              explanation:
                'There is no way for the visitor to play, pause or mute it without JavaScript. It is the single most common video mistake.',
              options: [
                { label: 'The visitor has no way to play or pause it', correct: true },
                { label: 'The video plays automatically instead' },
                { label: 'The browser adds default controls anyway' },
                { label: 'Only the poster image is shown' },
              ],
              skill: 'audio-video',
            },
            {
              slug: 'q-track-kind',
              prompt: 'What is the difference between captions and subtitles?',
              explanation:
                'Captions include non-speech sound and are for viewers who cannot hear the audio. Subtitles translate dialogue for viewers who can hear but do not understand the language.',
              options: [
                { label: 'Captions include non-speech sound; subtitles translate dialogue', correct: true },
                { label: 'They are the same thing with different names' },
                { label: 'Subtitles are burned into the video; captions are separate' },
                { label: 'Captions are for film; subtitles are for the web' },
              ],
              skill: 'audio-video',
            },
            {
              slug: 'q-fallback-placement',
              prompt: 'Where does fallback content go inside a `<video>`?',
              explanation:
                'After the `<source>` and `<track>` elements. Browsers that can play video ignore it; browsers that cannot display it instead.',
              options: [
                { label: 'Inside the <video>, after the sources and tracks', correct: true },
                { label: 'In an alt attribute on the video' },
                { label: 'Immediately after the closing </video> tag' },
                { label: 'Inside the first <source>' },
              ],
              skill: 'audio-video',
            },
          ],
        },
        {
          slug: 'iframes-and-media-milestone',
          title: 'Iframes, sandboxing, and the media milestone',
          subtitle: 'Embedding safely, then building the whole thing',
          summary:
            'An iframe puts someone else\'s page inside yours. That is powerful and worth being careful about.',
          objectives: [
            'Embed content with an iframe and a title',
            'Restrict an embed with the sandbox attribute',
            'Build a complete media-rich page',
          ],
          estimatedMinutes: 25,
          skill: 'embedded-content',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Embed third-party content with an accessible name',
              'Apply sandbox and referrerpolicy sensibly',
              'Combine responsive images, video and figures on one page',
            ]),
            term(
              'Iframe',
              'An "inline frame" — a window in your page showing a completely separate document. Maps, video players and payment forms are commonly embedded this way.',
            ),
            annotated(
              `<iframe
  src="https://www.example.org/map"
  title="Map showing the workshop on Mill Lane"
  width="600" height="400"
  loading="lazy"
  sandbox="allow-scripts allow-same-origin"
  referrerpolicy="no-referrer-when-downgrade">
</iframe>`,
              [
                { line: '2', text: '`src` is the page being embedded.' },
                {
                  line: '3',
                  text: '`title` is required for accessibility. Without it a screen reader announces only "frame", with no indication of what is inside. This is the most commonly missed accessibility attribute in all of HTML.',
                },
                { line: '4', text: '`width` and `height` reserve space, exactly as with images.' },
                { line: '5', text: '`loading="lazy"` avoids loading an embed the visitor may never scroll to. Embeds are often the heaviest thing on a page.' },
                {
                  line: '6',
                  text: '`sandbox` removes capabilities and adds back only what you list. With an empty `sandbox=""` the embedded page can do almost nothing; each `allow-` token restores one capability.',
                },
                {
                  line: '7',
                  text: '`referrerpolicy` controls how much of your page\'s address is sent to the embedded site. Level 10 covers the options in full.',
                },
              ],
            ),
            callout(
              'warning',
              'Only embed sources you trust',
              'An embedded page runs its own code, sets its own cookies and can attempt to navigate your window. `sandbox` is your main defence — start with the tightest set of permissions that still works, rather than starting permissive and tightening later.',
            ),
            callout(
              'note',
              'How this platform previews your work',
              'Every preview in HTML Hero renders inside an iframe with `sandbox=""` and no `allow-scripts`, which is why scripts you write never execute here. You are using the exact technique this lesson describes, and now you know why the preview panel says what it says.',
            ),
            detail(
              'Common sandbox tokens',
              '`allow-scripts` lets the embed run JavaScript. `allow-same-origin` lets it keep its own origin, without which it cannot read its own cookies or storage. `allow-forms` permits form submission. `allow-popups` permits new windows. Granting `allow-scripts` and `allow-same-origin` together to a page from your *own* origin effectively removes the sandbox, because the embedded page can then reach out and remove the sandbox attribute itself — so avoid that particular combination for same-origin content.',
            ),
            checklist('The media milestone page needs', [
              'A responsive hero image with `srcset` and `sizes`',
              'A `<figure>` with an image and a `<figcaption>`',
              'A `<video>` with controls, a poster, two sources, captions and fallback content',
              'One decorative image with `alt=""`',
              'Correct alt text on every informative image',
              'Lazy loading on everything below the fold, but not on the hero',
              'No broken media paths',
            ]),
            demo('An embed, configured and not', 'The four attributes every frame wants.', [
              {
                label: 'Configured',
                code: '<iframe src="https://example.org/map" title="Map of the bakery location" loading="lazy" width="560" height="315"></iframe>',
                note: 'Named so it can be navigated to, deferred so it costs nothing until scrolled to, and sized so the layout does not jump.',
              },
              {
                label: 'Bare',
                code: '<iframe src="https://example.org/map"></iframe>',
                note: 'Announced as an unnamed frame, loaded immediately, and the page shifts when it resolves. Three faults in one line.',
              },
            ]),
            recap(
              [
                'An `<iframe>` embeds a whole separate document; `title` is required.',
                '`sandbox` removes capabilities; add back only what is needed.',
                '`loading="lazy"` matters even more for embeds than for images.',
                'You can now build a complete, accessible, fast media page.',
              ],
              'Level 5 next: giving your pages professional structure.',
            ),
          ],
          exercises: [
            {
              slug: 'iframe-guided',
              kind: 'guided',
              title: 'Make an embed safe and accessible',
              brief:
                'This iframe has no title, no sandbox and no lazy loading. Add a descriptive `title`, `loading="lazy"`, and a `sandbox` that allows scripts but nothing else.',
              starterCode: `<iframe src="https://www.example.org/map" width="600" height="400"></iframe>`,
              referenceSolution: `<iframe
  src="https://www.example.org/map"
  title="Map showing the workshop on Mill Lane"
  width="600" height="400"
  loading="lazy"
  sandbox="allow-scripts"
  referrerpolicy="no-referrer-when-downgrade"></iframe>`,
              hints: [
                'The title should say what the embedded content is, not just "map".',
                'sandbox="allow-scripts" removes everything except the ability to run JavaScript.',
                'loading="lazy" goes on the iframe just as it does on an image.',
              ],
              requirements: [
                attr('iframe', 'title', 'The iframe has a title'),
                attrMatches('iframe', 'title', '\\S{4,}', 'The title actually describes the embedded content'),
                attrValue('iframe', 'loading', 'lazy', 'The iframe is lazy-loaded'),
                attr('iframe', 'sandbox', 'The iframe is sandboxed'),
                attrMatches('iframe', 'sandbox', 'allow-scripts', 'Scripts are permitted inside the sandbox'),
              ],
              difficulty: 3,
              xp: 45,
              skill: 'embedded-content',
            },
            {
              slug: 'media-milestone',
              kind: 'challenge',
              title: 'Milestone: a media-rich page',
              brief:
                'Build a complete page body meeting every item on the checklist above. Use only paths from the media library — the checker verifies that every file exists.',
              starterCode: '',
              referenceSolution: `<h1>The valley route</h1>

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

<img src="/learning-media/svg/placeholder.svg" alt="" loading="lazy" width="800" height="500">`,
              hints: [
                'Start with the hero image: a full srcset, sizes, fetchpriority="high", and no lazy loading.',
                'The figure needs an image with lazy loading plus a figcaption.',
                'The video needs controls, poster, two sources, a captions track and fallback content.',
                'End with one decorative image using alt="" — the placeholder SVG is designed for this.',
              ],
              requirements: [
                count('img', 3, null, 'There are at least three images'),
                attr('img[srcset]', 'sizes', 'The responsive image has both srcset and sizes'),
                present('figure > figcaption', 'There is a figure with a caption'),
                present('video[controls]', 'There is a video with controls'),
                attr('video', 'poster', 'The video has a poster image'),
                count('video source', 2, null, 'The video offers at least two sources'),
                present('track[kind="captions"]', 'The video has captions'),
                inside('a', 'video', 'The video has fallback content with a link'),
                { kind: 'element_count', selector: 'img[alt=""]', minCount: 1, message: 'At least one decorative image uses alt=""' },
                { kind: 'element_count', selector: 'img[loading="lazy"]', minCount: 1, message: 'At least one image below the fold is lazy-loaded' },
                goodAlt('img', 'Every informative image has meaningful alt text'),
                mediaResolves('img, source, track, video'),
                headingOrderRequirement(),
                legalNesting(),
              ],
              difficulty: 4,
              xp: 130,
              skill: 'audio-video',
            },
            {
              slug: 'media-mission',
              kind: 'project_mission',
              title: 'Capstone mission: add media to your site',
              brief:
                'Add a hero image with a full `srcset` to your capstone homepage, and a `<figure>` with a captioned image to your about page. Use library paths so nothing can break.',
              starterCode: `<main id="main">
  <h1>Your site name</h1>

  <!-- Add your responsive hero image here -->

  <p>Your existing content.</p>

  <!-- Add a figure with a captioned image here -->
</main>`,
              referenceSolution: `<main id="main">
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
</main>`,
              hints: [
                'Use the media picker to insert a full srcset without typing every path.',
                'The hero image should not be lazy-loaded.',
                'Write alt text that suits your own project, not the example.',
              ],
              requirements: [
                attr('img[srcset]', 'sizes', 'The hero image has srcset and sizes'),
                present('figure > figcaption', 'There is a captioned figure'),
                goodAlt('img'),
                attr('img', 'width', 'Images declare their dimensions'),
                mediaResolves('img, source'),
              ],
              difficulty: 3,
              xp: 85,
              skill: 'responsive-images',
            },
          ],
          quiz: [
            {
              slug: 'q-iframe-title',
              prompt: 'Why does an `<iframe>` need a `title`?',
              explanation:
                'Without it, a screen reader announces only "frame" with no indication of what the embedded content is.',
              options: [
                { label: 'Screen readers otherwise announce only "frame"', correct: true },
                { label: 'It sets the title of the embedded page' },
                { label: 'It is required for the iframe to load' },
                { label: 'It appears as a tooltip on hover' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-sandbox',
              prompt: 'What does `sandbox=""` on an iframe do?',
              explanation:
                'An empty sandbox removes essentially every capability. Each `allow-` token you add restores one.',
              options: [
                { label: 'Removes almost all capabilities from the embedded page', correct: true },
                { label: 'Grants the embedded page full permissions' },
                { label: 'Prevents the iframe from loading at all' },
                { label: 'Has no effect unless a value is given' },
              ],
              skill: 'security',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'level-4-milestone',
    kind: 'milestone',
    title: 'Level 4 milestone: Media Specialist',
    description: 'Nine questions on images, responsive images, video, audio and embeds. Pass mark 75%.',
    passScore: 0.75,
    xp: 180,
    questions: [
      {
        slug: 'a4-q1',
        prompt: 'Which attributes are required on every `<img>`?',
        explanation: '`src` says which file; `alt` provides the text alternative. Both are required.',
        options: [
          { label: 'src and alt', correct: true },
          { label: 'src and title' },
          { label: 'src, width and height' },
          { label: 'src only' },
        ],
        skill: 'images',
      },
      {
        slug: 'a4-q2',
        prompt: 'An image is purely decorative. What should its alt be?',
        explanation: '`alt=""` tells screen readers to skip it. The attribute must still be present.',
        options: [
          { label: 'alt=""', correct: true },
          { label: 'Omit the alt attribute' },
          { label: 'alt="decorative"' },
          { label: 'alt="spacer image"' },
        ],
        skill: 'images',
      },
      {
        slug: 'a4-q3',
        prompt: 'What does `1200w` mean in a srcset?',
        explanation: 'It describes the candidate file: this file is 1200 pixels wide.',
        options: [
          { label: 'This image file is 1200 pixels wide', correct: true },
          { label: 'Use this file on screens wider than 1200 pixels' },
          { label: 'Display the image at 1200 pixels' },
          { label: 'The file weighs 1200 kilobytes' },
        ],
        skill: 'responsive-images',
      },
      {
        slug: 'a4-q4',
        prompt: 'Which element is required inside a `<picture>`?',
        explanation: 'The `<img>` is what actually renders and carries the alt text.',
        options: [
          { label: '<img>', correct: true },
          { label: '<source>' },
          { label: '<figcaption>' },
          { label: '<track>' },
        ],
        skill: 'responsive-images',
      },
      {
        slug: 'a4-q5',
        prompt: 'Which image should NOT have `loading="lazy"`?',
        explanation:
          'The hero image is visible immediately, so lazy-loading it delays the most important content on the page.',
        options: [
          { label: 'The hero image at the top of the page', correct: true },
          { label: 'A photograph in the footer' },
          { label: 'An image halfway down a long article' },
          { label: 'An image inside a collapsed details element' },
        ],
        skill: 'performance',
      },
      {
        slug: 'a4-q6',
        prompt: 'What does `<track kind="captions">` provide?',
        explanation:
          'A timed text file carrying dialogue and important non-speech sound, for viewers who cannot hear the audio.',
        options: [
          { label: 'Timed captions for viewers who cannot hear the audio', correct: true },
          { label: 'A thumbnail preview strip' },
          { label: 'Chapter markers' },
          { label: 'An alternative video format' },
        ],
        skill: 'audio-video',
      },
      {
        slug: 'a4-q7',
        prompt: 'Why is autoplaying video with sound a problem?',
        explanation:
          'It plays over a screen reader\'s voice, startles users, and is distressing for people with sensory sensitivities. Browsers block it by default.',
        options: [
          { label: 'It talks over screen readers and startles users', correct: true },
          { label: 'It uses more bandwidth than muted video' },
          { label: 'It is invalid HTML' },
          { label: 'Search engines penalise it' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'a4-q8',
        prompt: 'Where does an iframe\'s accessible name come from?',
        explanation: 'The `title` attribute on the iframe itself.',
        options: [
          { label: 'Its title attribute', correct: true },
          { label: 'The <title> of the embedded page' },
          { label: 'Its src attribute' },
          { label: 'A nearby heading' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'a4-q9',
        prompt: 'Where does a `<video>`\'s fallback content go?',
        explanation: 'Inside the video element, after the source and track elements.',
        options: [
          { label: 'Inside <video>, after the sources and tracks', correct: true },
          { label: 'In an alt attribute' },
          { label: 'In the first <source>' },
          { label: 'After the closing </video> tag' },
        ],
        skill: 'audio-video',
      },
    ],
  },
};

/** Local helper so the milestone can assert heading order without another import. */
function headingOrderRequirement() {
  return {
    kind: 'heading_order' as const,
    message: 'The heading hierarchy is correct',
    hint: 'One <h1>, then step down one level at a time.',
  };
}
