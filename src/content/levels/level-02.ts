import {
  annotated,
  attr,
  callout,
  checklist,
  code,
  compare,
  count,
  demo,
  detail,
  doctype,
  headingOrder,
  inside,
  legalNesting,
  notEmpty,
  objectives,
  present,
  prose,
  recap,
  term,
  textIn,
  unique,
  visual,
  type LevelSpec,
} from '../types';

export const LEVEL_02: LevelSpec = {
  slug: 'content-builder',
  title: 'Content Builder',
  subtitle: 'Say what your content means, not what it should look like',
  summary:
    'HTML has an element for almost every kind of text: emphasis, quotations, abbreviations, dates, code. Choosing the right one is what separates markup that merely displays from markup that communicates.',
  outcome:
    'You can mark up a realistic article with a correct heading hierarchy and precise text semantics.',
  accent: 'teal',
  modules: [
    {
      slug: 'headings-and-paragraphs',
      title: 'Headings and paragraphs',
      summary:
        'The two elements you will use more than any other, and the hierarchy rule that makes a page navigable.',
      estimatedMinutes: 40,
      prerequisites: ['the-html-skeleton'],
      skills: [{ slug: 'text-semantics', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'heading-hierarchy',
          title: 'Headings and the outline they create',
          subtitle: 'h1 to h6, and why the order matters more than the size',
          summary:
            'Headings are not "big text". They are the table of contents that screen readers and search engines actually read.',
          objectives: [
            'Use h1 to h6 to describe the structure of a page',
            'Keep a heading hierarchy with no skipped levels',
            'Explain why heading order matters to real people',
          ],
          estimatedMinutes: 14,
          skill: 'text-semantics',
          blocks: [
            objectives([
              'Build a correct heading hierarchy with exactly one h1',
              'Recognise a skipped heading level and fix it',
              'Explain how a screen-reader user navigates by headings',
            ]),
            prose(
              'There are six heading elements, `<h1>` through `<h6>`. `<h1>` is the most important and `<h6>` the least. Together they form an outline of the page — exactly like the contents page of a book.',
            ),
            visual('heading-hierarchy', 'Headings as an indented outline. Each level is a step down, never a jump.'),
            prose(
              'The rule is simple: start at `<h1>`, and never skip a level going down. An `<h3>` may follow an `<h2>`, but it must not follow an `<h1>` directly. Going back up is fine — after an `<h3>`, the next `<h2>` simply starts a new section.',
            ),
            callout(
              'accessibility',
              'Why this is not pedantry',
              'Screen readers offer a "list all headings" command, and it is the main way blind users skim a page — the equivalent of your eye jumping down the screen. A hierarchy with gaps produces a contents list that makes no sense. Roughly two-thirds of screen-reader users say headings are how they find their way around a page.',
            ),
            compare(
              'Two versions of the same page',
              {
                label: 'Correct hierarchy',
                code: `<h1>Riverside Cycle Hire</h1>
  <h2>Our bikes</h2>
    <h3>Hybrids</h3>
    <h3>Road bikes</h3>
  <h2>Routes</h2>`,
                why: 'Reads as a proper outline: one topic, two sections, two sub-sections under the first.',
              },
              {
                label: 'Skipped level',
                code: `<h1>Riverside Cycle Hire</h1>
    <h4>Our bikes</h4>
    <h4>Routes</h4>`,
                why: 'h4 was chosen because it looked the right size. The outline now has two missing levels and describes a structure that does not exist.',
              },
            ),
            callout(
              'mistake',
              'Never choose a heading for its size',
              'If an `<h2>` looks too big, that is a styling problem with a styling solution. Picking `<h4>` to get smaller text breaks the outline for everyone who cannot see it. Structure first; appearance is CSS\'s job.',
            ),
            demo('How a screen reader hears it', 'The same content, announced two different ways.', [
              {
                label: 'Good structure',
                code: '<h1>Opening hours</h1>\n<h2>Weekdays</h2>\n<p>6am to 6pm.</p>\n<h2>Weekends</h2>\n<p>8am to 4pm.</p>',
                note: 'Announced as: heading level 1 Opening hours; heading level 2 Weekdays; heading level 2 Weekends. A clear two-section page.',
              },
              {
                label: 'Fake headings',
                code: '<p><strong>Opening hours</strong></p>\n<p><strong>Weekdays</strong></p>\n<p>6am to 6pm.</p>',
                note: 'Announced as three ordinary paragraphs. The headings list is empty, and the page appears to have no structure at all.',
              },
            ]),
            detail(
              'Does an h1 have to be the site name?',
              'No. The `<h1>` should name *this page*, not the whole site. On a homepage those are often the same, but on an About page the `<h1>` should say "About us", not repeat the company name. Search engines and screen-reader users both use the h1 to answer "what is this particular page?".',
            ),
            recap(
              [
                'Six heading levels form the page outline.',
                'Exactly one `<h1>`, naming what this page is about.',
                'Never skip a level going down; going back up starts a new section.',
                'Choose the level by meaning, never by how big the text looks.',
              ],
              'Next: paragraphs, and the difference between a line break and a new paragraph.',
            ),
          ],
          exercises: [
            {
              slug: 'headings-guided',
              kind: 'guided',
              title: 'Fix the outline',
              brief:
                'This page uses heading levels chosen by size rather than meaning. Rewrite the levels so the outline is correct: one h1 for the page, h2 for each major section, h3 for the parts inside a section. Do not change any wording.',
              starterCode: `<h1>Coastal Walks</h1>
<h4>Easy routes</h4>
<h5>Harbour loop</h5>
<h5>Cliff-top path</h5>
<h4>Harder routes</h4>
<h5>The ridge</h5>`,
              referenceSolution: `<h1>Coastal Walks</h1>
<h2>Easy routes</h2>
<h3>Harbour loop</h3>
<h3>Cliff-top path</h3>
<h2>Harder routes</h2>
<h3>The ridge</h3>`,
              hints: [
                'The two major sections are "Easy routes" and "Harder routes" — those should be h2.',
                'The individual walks sit inside a section, so they are one level down: h3.',
                'After changing them, read the levels top to bottom: 1, 2, 3, 3, 2, 3. No jumps.',
              ],
              requirements: [
                unique('h1', 'Exactly one h1'),
                count('h2', 2, 2, 'Two h2 sections'),
                count('h3', 3, 3, 'Three h3 sub-sections'),
                count('h4, h5, h6', 0, 0, 'No h4, h5 or h6 remain'),
                headingOrder(),
              ],
              difficulty: 2,
              xp: 35,
              skill: 'text-semantics',
            },
            {
              slug: 'headings-debug',
              kind: 'debug',
              title: 'Two h1s and a fake heading',
              brief:
                'This page has three problems: two competing h1 elements, a jump from h2 straight to h4, and a bold paragraph pretending to be a heading. Fix all three.',
              starterCode: `<h1>Northgate Dental</h1>
<h1>Our treatments</h1>
<h4>Check-ups</h4>
<p><strong>Emergency appointments</strong></p>
<p>We keep two slots free every day.</p>`,
              referenceSolution: `<h1>Northgate Dental</h1>
<h2>Our treatments</h2>
<h3>Check-ups</h3>
<h3>Emergency appointments</h3>
<p>We keep two slots free every day.</p>`,
              hints: [
                'Only one h1 — the second one is a section of the page, so it becomes h2.',
                'The h4 sits inside that section, so it should be h3.',
                'The bold paragraph is really a heading at the same level as "Check-ups".',
              ],
              requirements: [
                unique('h1', 'Only one h1 remains'),
                headingOrder(),
                count('h3', 2, 2, 'Both treatments are marked up as h3 headings'),
                count('p > strong', 0, 0, 'No paragraph is pretending to be a heading'),
              ],
              difficulty: 3,
              xp: 40,
              skill: 'text-semantics',
            },
          ],
          quiz: [
            {
              slug: 'q-heading-skip',
              prompt: 'You have an `<h2>` and want the next heading to be smaller. What should you use?',
              explanation:
                'The next level down is `<h3>`. If it looks too large, change the styling — never the level.',
              options: [
                { label: '<h3>, and adjust the size with CSS if needed', correct: true },
                { label: '<h5>, because it is smaller' },
                { label: '<p> with bold text' },
                { label: 'Another <h2> with a smaller font' },
              ],
              skill: 'text-semantics',
            },
            {
              slug: 'q-heading-purpose',
              prompt: 'How do many screen-reader users navigate a long page?',
              explanation:
                'They pull up a list of the page\'s headings and jump straight to the section they want — which only works if the headings describe the real structure.',
              options: [
                { label: 'By listing the headings and jumping between them', correct: true },
                { label: 'By reading every word from top to bottom' },
                { label: 'By searching for bold text' },
                { label: 'By looking at the font sizes' },
              ],
              skill: 'accessibility',
            },
          ],
        },
        {
          slug: 'paragraphs-breaks-rules',
          title: 'Paragraphs, line breaks and horizontal rules',
          subtitle: 'Three elements that look similar and mean very different things',
          summary:
            'Whitespace in your file does nothing. This lesson covers the elements that actually create structure in text.',
          objectives: [
            'Use `<p>` for prose and know when a new paragraph starts',
            'Use `<br>` only where a line break is part of the content',
            'Use `<hr>` to mark a genuine change of topic',
          ],
          estimatedMinutes: 12,
          skill: 'text-semantics',
          blocks: [
            objectives([
              'Split prose into paragraphs correctly',
              'Explain when `<br>` is appropriate and when it is a mistake',
              'Use `<hr>` for its actual meaning',
            ]),
            prose(
              'HTML collapses whitespace. Ten spaces, a tab and three blank lines in your file all become a single space on the page. Structure has to come from elements, not from how the text is laid out in the editor.',
            ),
            code(
              `<p>This        text

has lots of spacing in the file.</p>`,
              'What you write',
            ),
            prose('The browser displays that as a single line: "This text has lots of spacing in the file."'),
            term(
              'Paragraph',
              'A block of prose. `<p>` starts a new one. Browsers add space above and below automatically.',
            ),
            term(
              'Line break',
              '`<br>` forces a new line *within* a block. It is a void element — no closing tag.',
            ),
            callout(
              'mistake',
              '`<br>` is not for spacing',
              'A run of `<br><br><br>` to push things apart is the most common beginner habit, and it causes real problems: screen readers may announce the blank lines, and the spacing cannot be adjusted responsively. Use `<br>` only when the line break is genuinely part of the content — a postal address, a poem, song lyrics.',
            ),
            compare(
              'When `<br>` is right and wrong',
              {
                label: 'Correct — the breaks are part of the address',
                code: `<p>
  Riverside Cycle Hire<br>
  14 Mill Lane<br>
  Hexford HX2 4PL
</p>`,
                why: 'An address genuinely has line breaks in it. This is exactly what `<br>` is for.',
              },
              {
                label: 'Wrong — using breaks as spacing',
                code: `<p>Our opening hours have changed.</p>
<br><br>
<p>We now close at 4pm on Sundays.</p>`,
                why: 'These are two separate paragraphs already. The `<br>` elements add meaningless empty content that spacing should provide.',
              },
            ),
            prose(
              '`<hr>` used to mean "draw a horizontal line". In modern HTML it means "a thematic break" — the point where the subject changes, like a scene break in a novel. The line the browser draws is just the default way of showing that.',
            ),
            code(
              `<h2>Bike hire</h2>
<p>Hourly, daily and weekly rates.</p>

<hr>

<h2>Guided rides</h2>
<p>Every Saturday from March to October.</p>`,
              '`<hr>` marking a genuine change of subject',
            ),
            detail(
              'Where does the space between paragraphs come from?',
              'Browsers ship with a default stylesheet that gives `<p>` a margin above and below. You are not writing that space — the browser is. This is why adding `<br>` for spacing is redundant *and* fragile: the moment a real stylesheet changes the margin, your hand-made gaps are wrong.',
            ),
            checklist('Choosing between them', [
              'New topic or new block of prose → a new `<p>`',
              'Line break that is part of the content itself → `<br>`',
              'The subject genuinely changes → `<hr>`',
              'You just want more space → neither; that is a styling job',
            ]),
            recap(
              [
                'Whitespace in the file is collapsed; structure comes from elements.',
                '`<p>` for each block of prose.',
                '`<br>` only when the break belongs to the content, such as an address.',
                '`<hr>` means a change of subject, not "draw a line".',
              ],
              'Next: the elements that add meaning inside a sentence.',
            ),
          ],
          exercises: [
            {
              slug: 'paragraphs-guided',
              kind: 'guided',
              title: 'Mark up an address and two paragraphs',
              brief:
                'Turn the text below into two paragraphs of prose, plus a third paragraph containing a postal address that uses `<br>` between its lines.',
              starterCode: `We have been hiring bikes from the same workshop since 1998.
Everything is serviced on site by our own mechanics.

Riverside Cycle Hire
14 Mill Lane
Hexford HX2 4PL`,
              referenceSolution: `<p>We have been hiring bikes from the same workshop since 1998.</p>
<p>Everything is serviced on site by our own mechanics.</p>
<p>
  Riverside Cycle Hire<br>
  14 Mill Lane<br>
  Hexford HX2 4PL
</p>`,
              hints: [
                'The first two sentences are separate blocks of prose, so each gets its own <p>.',
                'The address is one block with line breaks inside it — one <p> containing <br> elements.',
                'You need two <br> elements: after the name and after the street.',
              ],
              requirements: [
                count('p', 3, 3, 'There are exactly three paragraphs'),
                count('br', 2, 2, 'The address uses exactly two line breaks'),
                inside('br', 'p', 'The line breaks are inside a paragraph'),
                textIn('p', 'Mill Lane', 'The address text is preserved'),
              ],
              difficulty: 2,
              xp: 35,
              skill: 'text-semantics',
            },
            {
              slug: 'paragraphs-debug',
              kind: 'debug',
              title: 'Remove the spacing hack',
              brief:
                'Someone used line breaks to create space between paragraphs and an `<hr>` purely for decoration. Rewrite it so the structure is honest: real paragraphs, and no stray break elements.',
              starterCode: `<p>Our summer timetable starts in May.</p>
<br><br>
<p>Winter hours begin in October.</p>
<hr>
<hr>
<p>Bank holidays follow Sunday hours.</p>`,
              referenceSolution: `<p>Our summer timetable starts in May.</p>
<p>Winter hours begin in October.</p>
<p>Bank holidays follow Sunday hours.</p>`,
              hints: [
                'The paragraphs already separate themselves — the <br> elements are doing nothing useful.',
                'Two <hr> elements in a row cannot both mark a change of subject.',
                'The finished answer is three paragraphs and nothing else.',
              ],
              requirements: [
                count('p', 3, 3, 'Three paragraphs remain'),
                count('br', 0, 0, 'No stray line breaks'),
                count('hr', 0, 1, 'At most one horizontal rule, if any'),
              ],
              difficulty: 2,
              xp: 30,
              skill: 'text-semantics',
            },
          ],
          quiz: [
            {
              slug: 'q-whitespace',
              prompt: 'What happens to three blank lines in your HTML file?',
              explanation:
                'Runs of whitespace are collapsed to a single space. Structure must come from elements.',
              options: [
                { label: 'They collapse into a single space', correct: true },
                { label: 'They appear as three blank lines on the page' },
                { label: 'They cause a validation error' },
                { label: 'They create a new paragraph automatically' },
              ],
              skill: 'text-semantics',
            },
            {
              slug: 'q-br-use',
              prompt: 'Which is a correct use of `<br>`?',
              explanation:
                '`<br>` is for line breaks that are part of the content, such as the lines of a postal address or a poem.',
              options: [
                { label: 'Between the lines of a postal address', correct: true },
                { label: 'To add space between two paragraphs' },
                { label: 'To push a footer to the bottom of the page' },
                { label: 'To start a new section of the page' },
              ],
              skill: 'text-semantics',
            },
            {
              slug: 'q-hr-meaning',
              prompt: 'What does `<hr>` mean in modern HTML?',
              explanation:
                'It marks a thematic break — the point where the subject changes. Drawing a line is just the default presentation of that meaning.',
              options: [
                { label: 'A change of subject', correct: true },
                { label: 'Draw a horizontal line' },
                { label: 'Add vertical space' },
                { label: 'End the current section element' },
              ],
              skill: 'text-semantics',
            },
          ],
        },
      ],
    },
    {
      slug: 'text-level-semantics',
      title: 'Meaning inside a sentence',
      summary:
        'Emphasis, importance, quotations, abbreviations, dates, code, and the special characters that break pages if you type them raw.',
      estimatedMinutes: 55,
      prerequisites: ['headings-and-paragraphs'],
      skills: [
        { slug: 'text-semantics', masteryRequired: 0.6 },
        { slug: 'lists', masteryRequired: 0 },
      ],
      lessons: [
        {
          slug: 'emphasis-and-importance',
          title: 'Emphasis, importance and highlighting',
          subtitle: 'strong, em, mark, small — and the two elements to avoid',
          summary:
            'Bold and italic are appearances. HTML gives you elements for the *reasons* behind them, and screen readers can hear the difference.',
          objectives: [
            'Choose between `<strong>` and `<em>` correctly',
            'Use `<mark>` and `<small>` for their real meanings',
            'Explain why `<b>` and `<i>` are rarely the right choice',
          ],
          estimatedMinutes: 12,
          skill: 'text-semantics',
          blocks: [
            objectives([
              'Use `<strong>` for importance and `<em>` for stress emphasis',
              'Apply `<mark>` and `<small>` where they genuinely fit',
              'Explain the difference between `<b>` and `<strong>`',
            ]),
            term(
              '<strong>',
              'Marks text as *important* — a warning, a deadline, something with consequences if missed. Displayed bold by default.',
              '<p><strong>Helmets must be worn</strong> on all guided rides.</p>',
            ),
            term(
              '<em>',
              'Marks *stress emphasis* — the word you would lean on if you said the sentence aloud. Displayed italic by default.',
              '<p>We open at six, but we <em>close</em> at two.</p>',
            ),
            demo('The same sentence, emphasised differently', 'Emphasis changes the meaning, not just the look.', [
              {
                label: 'Emphasis on "we"',
                code: '<p><em>We</em> did not lose your booking.</p>',
                note: 'Implies somebody else did.',
              },
              {
                label: 'Emphasis on "lose"',
                code: '<p>We did not <em>lose</em> your booking.</p>',
                note: 'Implies something else happened to it.',
              },
              {
                label: 'Importance instead',
                code: '<p><strong>Bookings close at 5pm.</strong></p>',
                note: 'Not a stressed word — a fact with consequences. Screen readers can announce it differently.',
              },
            ]),
            prose(
              '`<b>` and `<i>` still exist, but they mean "bold for no stated reason" and "a different voice or mood" — a ship name, a technical term, a word in another language. They carry no importance or emphasis. In practice, if you reach for bold or italic, the meaning you want is nearly always `<strong>` or `<em>`.',
            ),
            compare(
              'Choosing the right element',
              {
                label: 'Meaningful',
                code: '<p><strong>Do not lock bikes to the railings.</strong></p>',
                why: 'This matters. A screen reader can convey the importance.',
              },
              {
                label: 'Appearance only',
                code: '<p><b>Do not lock bikes to the railings.</b></p>',
                why: 'Looks identical, but says only "make this bold". The importance is lost to anyone not looking at the screen.',
              },
            ),
            term(
              '<mark>',
              'Marks text as relevant *in the current context* — most often a search term highlighted in a result. Rendered with a yellow background by default.',
            ),
            term(
              '<small>',
              'Side comments and small print: copyright lines, legal disclaimers, attribution. It means "this is fine print", not "make this smaller".',
            ),
            code(
              `<p>Results for <mark>cycle hire</mark>: 12 matches.</p>
<p><small>Prices include VAT and are subject to availability.</small></p>`,
              '`<mark>` and `<small>` in use',
            ),
            detail(
              'How screen readers actually treat these',
              'Support varies. Many screen readers do not announce `<strong>` or `<em>` by default, because constant announcements would be exhausting to listen to — but users can turn that on, and several will change the pitch or speed of the voice. Using the right element also means that when you later restyle the site, or when the page is converted to another format, the meaning survives. Choosing the semantic element costs nothing and can only help.',
            ),
            recap(
              [
                '`<strong>` = important. `<em>` = stressed when read aloud.',
                '`<b>` and `<i>` mean "bold" and "different voice" with no importance attached.',
                '`<mark>` highlights something relevant right now; `<small>` is for small print.',
                'Choose by meaning; the appearance follows.',
              ],
              'Next: quoting other people properly.',
            ),
          ],
          exercises: [
            {
              slug: 'emphasis-guided',
              kind: 'guided',
              title: 'Add meaning to a safety notice',
              brief:
                'In the notice below, mark "must be worn at all times" as important, and stress the word "before" so a reader leans on it. Use the semantic elements, not `<b>` or `<i>`.',
              starterCode: `<p>Helmets must be worn at all times. Please check your brakes before you set off.</p>`,
              referenceSolution: `<p><strong>Helmets must be worn at all times.</strong> Please check your brakes <em>before</em> you set off.</p>`,
              hints: [
                'Importance — a rule with consequences — is <strong>.',
                'Stress on a single word when read aloud is <em>.',
                'Wrap only the words that need it, not the whole paragraph.',
              ],
              requirements: [
                present('strong', 'The important sentence uses <strong>'),
                textIn('strong', 'must be worn', 'The right words are marked as important'),
                present('em', 'The stressed word uses <em>'),
                textIn('em', 'before', 'The word "before" is stressed'),
                count('b, i', 0, 0, 'No presentational <b> or <i> elements'),
              ],
              difficulty: 2,
              xp: 30,
              skill: 'text-semantics',
            },
            {
              slug: 'emphasis-challenge',
              kind: 'challenge',
              title: 'A notice with four kinds of meaning',
              brief:
                'Write a short paragraph for a shop page that contains all four of: `<strong>` for something important, `<em>` for a stressed word, `<mark>` for a highlighted term, and `<small>` for a line of small print. The wording is yours.',
              starterCode: '',
              referenceSolution: `<p>
  <strong>Orders placed after 2pm ship the next working day.</strong>
  We do <em>not</em> deliver on Sundays. Searching for
  <mark>next-day delivery</mark>? Choose it at checkout.
</p>
<p><small>Delivery estimates exclude bank holidays.</small></p>`,
              hints: [
                'Start with a sentence that genuinely matters — that is your <strong>.',
                '<mark> works well around a term someone might have searched for.',
                '<small> suits a closing line of terms or conditions.',
              ],
              requirements: [
                present('strong', 'Uses <strong> for importance'),
                present('em', 'Uses <em> for stress emphasis'),
                present('mark', 'Uses <mark> for a highlighted term'),
                present('small', 'Uses <small> for small print'),
                notEmpty('p', 'The paragraphs contain real content'),
                legalNesting(),
              ],
              difficulty: 3,
              xp: 40,
              skill: 'text-semantics',
            },
          ],
          quiz: [
            {
              slug: 'q-strong-vs-em',
              prompt: 'Which element marks text as important?',
              explanation:
                '`<strong>` means importance or urgency. `<em>` means stress emphasis — the word you would lean on.',
              options: [
                { label: '<strong>', correct: true },
                { label: '<em>' },
                { label: '<b>' },
                { label: '<mark>' },
              ],
              skill: 'text-semantics',
            },
            {
              slug: 'q-small-meaning',
              prompt: 'What does `<small>` mean?',
              explanation:
                'It marks side comments and small print — disclaimers, copyright lines, attribution. It is not a font-size control.',
              options: [
                { label: 'Small print such as a disclaimer or copyright line', correct: true },
                { label: 'Text that should be displayed smaller' },
                { label: 'A footnote reference' },
                { label: 'Text of secondary importance' },
              ],
              skill: 'text-semantics',
            },
          ],
        },
        {
          slug: 'quotes-abbreviations-dates',
          title: 'Quotations, citations, abbreviations and dates',
          subtitle: 'The elements that make content genuinely machine-readable',
          summary:
            'Six elements that carry real information: who said it, what an acronym means, and exactly which date "next Tuesday" refers to.',
          objectives: [
            'Quote sources correctly with blockquote, q and cite',
            'Expand abbreviations for people who do not know them',
            'Make dates unambiguous with the time element',
          ],
          estimatedMinutes: 14,
          skill: 'text-semantics',
          blocks: [
            objectives([
              'Mark up block and inline quotations with attribution',
              'Use `<abbr>` so abbreviations can be understood',
              'Use `<time datetime="…">` so machines read dates correctly',
            ]),
            term(
              '<blockquote>',
              'A quotation long enough to stand on its own as a block. Takes an optional `cite` attribute holding the source URL.',
            ),
            term('<q>', 'A short quotation inside a sentence. Browsers add the quotation marks for you.'),
            term(
              '<cite>',
              'The *title* of a creative work — a book, a film, an article, a study. Not the person who said it. This surprises almost everyone.',
            ),
            annotated(
              `<figure>
  <blockquote cite="https://example.org/cycling-report-2026">
    <p>
      Towns that added protected cycle lanes saw a 34% rise in journeys
      made by bike within two years.
    </p>
  </blockquote>
  <figcaption>
    Transport Research Unit, <cite>Cycling in Small Towns</cite>, 2026
  </figcaption>
</figure>`,
              [
                { line: '1', text: '`<figure>` groups the quotation with its caption so they travel together.' },
                {
                  line: '2',
                  text: '`cite` on the blockquote holds the source URL. Browsers do not display it, but it documents where the quotation came from.',
                },
                { line: '3-6', text: 'The quoted text itself goes in a paragraph inside the blockquote.' },
                {
                  line: '8-9',
                  text: '`<figcaption>` carries the attribution. `<cite>` wraps the *work\'s title* — the research unit\'s name is not inside it, because `<cite>` is for titles, not authors.',
                },
              ],
            ),
            code(
              `<p>The council described the scheme as <q>the busiest route in the county</q>.</p>`,
              '`<q>` for an inline quotation — no quotation marks typed by you',
            ),
            callout(
              'mistake',
              'Do not type quotation marks inside `<q>`',
              'The browser adds them, and it uses the right style for the page\'s language. Typing your own produces doubled marks like ""this"".',
            ),
            term(
              '<abbr>',
              'An abbreviation or acronym. Put the full expansion in the `title` attribute so it can be discovered.',
              '<abbr title="World Wide Web Consortium">W3C</abbr>',
            ),
            callout(
              'accessibility',
              'The `title` attribute is not enough on its own',
              'Hovering to reveal a tooltip requires a mouse, so touch and keyboard users cannot reach it. For an abbreviation your reader may genuinely not know, write it out in full the first time and put the abbreviation in brackets after it — then use `<abbr>` for later occurrences.',
            ),
            term(
              '<time>',
              'A date or time. The `datetime` attribute holds a machine-readable version, so software can read it even when the visible text is casual.',
            ),
            code(
              `<p>Our next guided ride is <time datetime="2026-08-15T09:30">Saturday morning</time>.</p>
<p>Open <time datetime="09:00">9am</time> to <time datetime="17:30">5.30pm</time>.</p>`,
              '`<time>` making casual wording precise',
            ),
            detail(
              'The datetime format',
              'It follows ISO 8601: `2026-08-15` for a date, `09:30` for a time, `2026-08-15T09:30` for both together, and `2026-08` or `2026-W33` for a month or a week. Always year-month-day, always with leading zeros. This ordering sorts correctly as plain text, which is why standards use it and why "15/08/2026" — ambiguous between British and American readers — does not appear in `datetime`.',
            ),
            checklist('Use these when', [
              'You quote a block of text from elsewhere → `<blockquote>` + `<figcaption>`',
              'You quote a phrase inside a sentence → `<q>`',
              'You name a book, film, study or article → `<cite>`',
              'You use an abbreviation a reader may not know → `<abbr title="…">`',
              'You mention any date or time → `<time datetime="…">`',
            ]),
            recap(
              [
                '`<blockquote>` for block quotations, `<q>` for inline ones — never type the quotation marks yourself.',
                '`<cite>` names the *work*, not the author.',
                '`<abbr title="…">` expands an abbreviation, but spelling it out in full first is better still.',
                '`<time datetime="…">` makes a casual date machine-readable.',
              ],
              'Next: code, superscripts and the special characters that break pages.',
            ),
          ],
          exercises: [
            {
              slug: 'quotes-guided',
              kind: 'guided',
              title: 'Mark up a quotation with attribution',
              brief:
                'Turn the text below into a `<figure>` containing a `<blockquote>` (with a `cite` attribute pointing at `https://example.org/report`) and a `<figcaption>` in which the report title is wrapped in `<cite>`.',
              starterCode: `Protected lanes raised cycling by a third within two years.
Transport Research Unit, Cycling in Small Towns, 2026`,
              referenceSolution: `<figure>
  <blockquote cite="https://example.org/report">
    <p>Protected lanes raised cycling by a third within two years.</p>
  </blockquote>
  <figcaption>
    Transport Research Unit, <cite>Cycling in Small Towns</cite>, 2026
  </figcaption>
</figure>`,
              hints: [
                'The <figure> wraps everything. Inside it go the <blockquote> and the <figcaption>.',
                'The quoted sentence goes in a <p> inside the <blockquote>.',
                'Only the report title — "Cycling in Small Towns" — goes inside <cite>, not the organisation name.',
              ],
              requirements: [
                present('figure', 'There is a figure grouping the quote and its caption'),
                inside('blockquote', 'figure', 'The blockquote is inside the figure'),
                attr('blockquote', 'cite', 'The blockquote has a cite attribute with the source URL'),
                inside('figcaption', 'figure', 'There is a figcaption inside the figure'),
                inside('cite', 'figcaption', 'The work title is wrapped in <cite> inside the caption'),
                textIn('cite', 'Cycling in Small Towns', 'The <cite> contains the title of the work'),
              ],
              difficulty: 3,
              xp: 40,
              skill: 'text-semantics',
            },
            {
              slug: 'quotes-debug',
              kind: 'debug',
              title: 'Four semantic mistakes',
              brief:
                'Each line has one problem: typed quotation marks inside `<q>`, an author in `<cite>`, an `<abbr>` with no expansion, and a date with no machine-readable value. Fix all four.',
              starterCode: `<p>She called it <q>"a proper community shop"</q>.</p>
<p>From <cite>Ada Whitfield</cite>, writing in 2026.</p>
<p>Approved by the <abbr>RSPB</abbr> last year.</p>
<p>We reopen on <time>3 September 2026</time>.</p>`,
              referenceSolution: `<p>She called it <q>a proper community shop</q>.</p>
<p>From <cite>The Village Shop</cite> by Ada Whitfield, 2026.</p>
<p>Approved by the <abbr title="Royal Society for the Protection of Birds">RSPB</abbr> last year.</p>
<p>We reopen on <time datetime="2026-09-03">3 September 2026</time>.</p>`,
              hints: [
                'The browser supplies the quotation marks for <q>, so remove the typed ones.',
                '<cite> names a work, not a person — give it a title instead.',
                '<abbr> needs a title attribute holding the expansion.',
                '<time> needs datetime="2026-09-03" in year-month-day order.',
              ],
              requirements: [
                present('q', 'The inline quotation still uses <q>'),
                attr('abbr', 'title', 'The abbreviation has a title with its expansion'),
                attr('time', 'datetime', 'The time element has a datetime attribute'),
                { kind: 'attribute_matches', selector: 'time', attribute: 'datetime', expectedValue: '^\\d{4}-\\d{2}-\\d{2}', message: 'The datetime is in year-month-day order', hint: 'Write datetime="2026-09-03".' },
                present('cite', 'A <cite> element is still present'),
              ],
              difficulty: 3,
              xp: 45,
              skill: 'text-semantics',
            },
          ],
          quiz: [
            {
              slug: 'q-cite-meaning',
              prompt: 'What does `<cite>` mark up?',
              explanation:
                'The title of a creative work — a book, film, study or article. Not the author, despite what the name suggests.',
              options: [
                { label: 'The title of a work', correct: true },
                { label: 'The author of a quotation' },
                { label: 'A URL you are citing' },
                { label: 'A footnote' },
              ],
              skill: 'text-semantics',
            },
            {
              slug: 'q-datetime-format',
              prompt: 'Which `datetime` value is correctly formatted?',
              explanation:
                'The format is ISO 8601: four-digit year, then month, then day, each separated by a hyphen, with leading zeros.',
              options: [
                { label: 'datetime="2026-09-03"', correct: true },
                { label: 'datetime="03/09/2026"' },
                { label: 'datetime="3 September 2026"' },
                { label: 'datetime="Sept 3, 2026"' },
              ],
              skill: 'text-semantics',
            },
            {
              slug: 'q-q-quotes',
              prompt: 'Should you type quotation marks inside `<q>`?',
              explanation:
                'No — the browser inserts them, in the style appropriate to the page\'s language. Typing your own gives you two sets.',
              options: [
                { label: 'No, the browser adds them automatically', correct: true },
                { label: 'Yes, always' },
                { label: 'Only for quotations longer than a sentence' },
                { label: 'Only when the page language is not English' },
              ],
              skill: 'text-semantics',
            },
          ],
        },
        {
          slug: 'code-entities-and-lists',
          title: 'Code, special characters and lists',
          subtitle: 'Showing HTML on a page, and structuring anything that comes in a set',
          summary:
            'How to display a `<` without breaking the page, and how to mark up the three kinds of list.',
          objectives: [
            'Display code and preformatted text correctly',
            'Write HTML entities for characters that would otherwise break markup',
            'Choose between ordered, unordered and description lists',
          ],
          estimatedMinutes: 15,
          skill: 'lists',
          blocks: [
            objectives([
              'Show code on a page using `<code>` and `<pre>`',
              'Escape `<`, `>` and `&` correctly with entities',
              'Use the right list element for the content',
            ]),
            prose(
              '`<code>` marks a fragment of computer code inside a sentence. `<pre>` means "preformatted": inside it, spaces and line breaks are kept exactly as written — the one place HTML does not collapse whitespace.',
            ),
            code(
              `<p>Every page needs a <code>&lt;title&gt;</code> element.</p>

<pre><code>&lt;head&gt;
  &lt;title&gt;My page&lt;/title&gt;
&lt;/head&gt;</code></pre>`,
              'Showing HTML inside HTML',
            ),
            prose(
              'Notice `&lt;` and `&gt;` above. To display a `<` character you cannot simply type it — the browser would read it as the start of a tag. Instead you write an entity: an ampersand, a name, and a semicolon.',
            ),
            term(
              'HTML entity',
              'A code that stands in for a character. Written `&name;` — for example `&lt;` produces `<`.',
            ),
            code(
              `&lt;   →  <     (less than — the start of a tag)
&gt;   →  >     (greater than)
&amp;  →  &     (ampersand — the start of an entity)
&quot; →  "     (double quotation mark)
&nbsp; →        (a space that never breaks across lines)
&copy; →  ©
&mdash;→  —     (an em dash)`,
              'The entities worth knowing',
              'text',
            ),
            callout(
              'tip',
              'Only three are genuinely required',
              'With a UTF-8 charset you can type é, ©, — and almost anything else directly. Only `<`, `>` and `&` truly need entities, because they have meaning in HTML itself. `&nbsp;` is useful in one specific case: keeping "10 km" or "Dr Alvarez" from splitting across two lines.',
            ),
            prose(
              'Lists come in three kinds, and choosing between them is a question about the content, not the appearance.',
            ),
            compare(
              'Ordered or unordered?',
              {
                label: '`<ol>` — the order is part of the meaning',
                code: `<ol>
  <li>Unlock the bike</li>
  <li>Adjust the saddle</li>
  <li>Check the brakes</li>
</ol>`,
                why: 'Steps in a procedure. Doing them in a different order would be wrong.',
              },
              {
                label: '`<ul>` — the order does not matter',
                code: `<ul>
  <li>Helmet</li>
  <li>Lock</li>
  <li>Route map</li>
</ul>`,
                why: 'A set of things. Shuffling them changes nothing.',
              },
            ),
            prose(
              'The third kind is the description list, `<dl>`. It pairs terms with their descriptions — a glossary, a specification table, a set of frequently asked questions.',
            ),
            annotated(
              `<dl>
  <dt>Hourly</dt>
  <dd>£6 per bike, minimum two hours.</dd>

  <dt>Day rate</dt>
  <dd>£22 per bike, returned by 6pm.</dd>
</dl>`,
              [
                { line: '1', text: '`<dl>` is the description list itself.' },
                { line: '2', text: '`<dt>` is a term being described.' },
                { line: '3', text: '`<dd>` is its description. One term can have several descriptions, and vice versa.' },
              ],
            ),
            callout(
              'mistake',
              'Lists nest inside `<li>`, not inside `<ul>`',
              'A sub-list goes inside the list item it belongs to, before that item\'s closing tag. Putting a `<ul>` directly inside another `<ul>` is invalid and produces an orphaned list.',
            ),
            code(
              `<ul>
  <li>Bikes
    <ul>
      <li>Hybrid</li>
      <li>Road</li>
    </ul>
  </li>
  <li>Accessories</li>
</ul>`,
              'Correctly nested lists',
            ),
            recap(
              [
                '`<code>` for code in a sentence; `<pre>` preserves spacing exactly.',
                '`&lt;`, `&gt;` and `&amp;` are the entities you genuinely need.',
                '`<ol>` when order matters, `<ul>` when it does not, `<dl>` for term-and-description pairs.',
                'Nest a sub-list inside the `<li>` it belongs to.',
              ],
              'Next: the Level 2 milestone — a complete article page.',
            ),
          ],
          exercises: [
            {
              slug: 'lists-guided',
              kind: 'guided',
              title: 'Three lists, three meanings',
              brief:
                'Build three lists: an ordered list of three setup steps, an unordered list of three items you should bring, and a description list with two term-and-description pairs for two hire rates.',
              starterCode: '',
              referenceSolution: `<h2>Before you set off</h2>
<ol>
  <li>Adjust the saddle height</li>
  <li>Check both brakes</li>
  <li>Test the bell</li>
</ol>

<h2>What to bring</h2>
<ul>
  <li>Water bottle</li>
  <li>Waterproof jacket</li>
  <li>Phone</li>
</ul>

<h2>Rates</h2>
<dl>
  <dt>Hourly</dt>
  <dd>£6 per bike, minimum two hours.</dd>
  <dt>Day rate</dt>
  <dd>£22 per bike, returned by 6pm.</dd>
</dl>`,
              hints: [
                'Steps happen in order, so that list is <ol>.',
                'Items to bring have no order, so that list is <ul>.',
                'The rates are term-and-description pairs: <dl> with <dt> and <dd>.',
              ],
              requirements: [
                count('ol > li', 3, 3, 'The ordered list has three steps'),
                count('ul > li', 3, 3, 'The unordered list has three items'),
                count('dl > dt', 2, 2, 'The description list has two terms'),
                count('dl > dd', 2, 2, 'Each term has a description'),
                legalNesting(),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'lists',
            },
            {
              slug: 'entities-debug',
              kind: 'debug',
              title: 'The page that swallowed itself',
              brief:
                'This page tries to show some HTML but typed the angle brackets directly, so the browser read them as real tags and the text vanished. Replace them with entities so the code shows on the page as text.',
              starterCode: `<h2>The title element</h2>
<p>Every page needs a <code><title></code> element in its head.</p>
<p>Ampersands must be written as & too.</p>`,
              referenceSolution: `<h2>The title element</h2>
<p>Every page needs a <code>&lt;title&gt;</code> element in its head.</p>
<p>Ampersands must be written as &amp; too.</p>`,
              hints: [
                'Replace the < you want to *display* with &lt; and the > with &gt;.',
                'A bare & should be written &amp;.',
                'The <code> tags themselves stay as real tags — only the ones inside it become entities.',
              ],
              requirements: [
                present('code', 'The <code> element is still there'),
                textIn('code', '<title>', 'The code element displays the text "<title>"'),
                count('title', 0, 0, 'No accidental real <title> element was created'),
                textIn('p', '&', 'The ampersand displays as a character'),
              ],
              difficulty: 3,
              xp: 40,
              skill: 'validation',
            },
          ],
          quiz: [
            {
              slug: 'q-entity-lt',
              prompt: 'How do you display a `<` character on a page?',
              explanation:
                'Write the entity `&lt;`. Typing the character directly makes the browser think a tag is starting.',
              options: [
                { label: '&lt;', correct: true },
                { label: '&lessthan;' },
                { label: '\\<' },
                { label: 'Just type < — browsers handle it' },
              ],
              skill: 'text-semantics',
            },
            {
              slug: 'q-list-choice',
              prompt: 'Which list element suits a recipe\'s method?',
              explanation:
                'The steps of a method must happen in order, so `<ol>` is correct. `<ul>` would suit the ingredients.',
              options: [
                { label: '<ol>', correct: true },
                { label: '<ul>' },
                { label: '<dl>' },
                { label: '<pre>' },
              ],
              skill: 'lists',
            },
            {
              slug: 'q-nested-list',
              prompt: 'Where does a nested sub-list belong?',
              explanation:
                'Inside the `<li>` it relates to, before that item\'s closing tag. Placing a list directly inside a `<ul>` is invalid.',
              options: [
                { label: 'Inside the <li> it belongs to', correct: true },
                { label: 'Directly inside the parent <ul>' },
                { label: 'After the parent list closes' },
                { label: 'Inside a <dd> element' },
              ],
              skill: 'lists',
            },
          ],
        },
        {
          slug: 'article-milestone',
          title: 'Milestone: a real information page',
          subtitle: 'Everything from Level 2, on one page',
          summary:
            'Build a complete article page with a correct heading hierarchy, precise text semantics, lists and a properly attributed quotation.',
          objectives: [
            'Combine every Level 2 element on one realistic page',
            'Make deliberate semantic choices and be able to justify them',
            'Add an information page to your capstone project',
          ],
          estimatedMinutes: 25,
          skill: 'text-semantics',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Produce a realistic article page with correct structure throughout',
              'Use at least six different text-level elements appropriately',
              'Add this page to your capstone website',
            ]),
            prose(
              'This milestone is a single page of realistic content — the kind of page every site has: an article, a guide, a page explaining what you do. The checker looks at structure, not wording, so write about whatever your project is.',
            ),
            checklist('Your page must contain', [
              'The full document skeleton, with a title of its own',
              'One `<h1>` and at least two `<h2>` sections, in correct order',
              'At least three paragraphs of genuine prose',
              'A list — ordered or unordered, whichever fits',
              '`<strong>` and `<em>`, each used for its real meaning',
              'An `<abbr>` with a `title`, or a `<time>` with a `datetime`',
              'A `<blockquote>` with a `<figcaption>` attributing it',
            ]),
            callout(
              'tip',
              'Write the content first, in plain text',
              'Decide what the page says before you mark it up. Then go through and ask of each piece: what *is* this? The element usually names itself once the question is asked that way round.',
            ),
            code(
              `<h1>Getting started with river routes</h1>
<p>The valley has around forty miles of traffic-free path.</p>

<h2>Before you set off</h2>
<p><strong>Check your brakes before every ride.</strong></p>
<ol>
  <li>Adjust the saddle</li>
  <li>Squeeze both brakes firmly</li>
</ol>

<h2>The routes</h2>
<p>Leave <em>before</em> noon for the longest one.</p>`,
              'The shape of a real information page',
            ),
            visual('heading-hierarchy', 'Your page should read as a clean outline like this one.'),
            detail(
              'How long should the page be?',
              'Long enough to need two sections and short enough that you can still hold the whole structure in your head. Three or four hundred words is plenty. The exercise is about making accurate structural decisions, not about producing volume — a short page with precise markup demonstrates far more than a long one with vague markup.',
            ),
            recap(
              [
                'You can now mark up a full page of realistic text with accurate semantics.',
                'Heading hierarchy, lists, emphasis, quotations and dates all have a correct element.',
                'Your capstone site now has two pages of real content.',
              ],
              'Level 3 next: connecting pages together.',
            ),
          ],
          exercises: [
            {
              slug: 'article-milestone-build',
              kind: 'challenge',
              title: 'Milestone: build an information page',
              brief:
                'Write a complete HTML document for an information page on your project\'s subject. Follow the checklist above. Content is entirely up to you — the structure is what is assessed.',
              starterCode: '',
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Getting started with river routes — Riverside Cycle Hire</title>
  </head>
  <body>
    <h1>Getting started with river routes</h1>
    <p>
      The valley has around forty miles of traffic-free path. This guide covers
      the three routes we recommend to people riding here for the first time.
    </p>

    <h2>Before you set off</h2>
    <p>
      <strong>Check your brakes before every ride.</strong> If anything feels
      soft, bring the bike back — we would far rather adjust it than have you
      find out on a descent.
    </p>
    <ol>
      <li>Adjust the saddle so your leg is almost straight at the bottom</li>
      <li>Squeeze both brakes firmly</li>
      <li>Check the tyres are hard</li>
    </ol>

    <h2>The three routes</h2>
    <p>
      All three start at the workshop. The shortest takes about an hour; the
      longest is a half-day ride, so leave <em>before</em> noon.
    </p>
    <ul>
      <li>Harbour loop — 6 miles, flat</li>
      <li>Mill and back — 11 miles, one climb</li>
      <li>The full valley — 24 miles</li>
    </ul>
    <p>
      Our next guided ride is on
      <time datetime="2026-08-15T09:30">15 August at 9.30am</time>, run with the
      <abbr title="Hexford Cycling Club">HCC</abbr>.
    </p>

    <figure>
      <blockquote cite="https://example.org/cycling-report-2026">
        <p>
          Towns that added protected lanes saw a 34% rise in journeys made by
          bike within two years.
        </p>
      </blockquote>
      <figcaption>
        Transport Research Unit, <cite>Cycling in Small Towns</cite>, 2026
      </figcaption>
    </figure>

    <p><small>Route distances are approximate and measured from the workshop.</small></p>
  </body>
</html>`,
              hints: [
                'Start with the document skeleton, then the h1, then work down the page.',
                'Two <h2> sections give you a natural place for the list and the quotation.',
                'Remember the blockquote needs a <figcaption> beside it inside a <figure>.',
                'The <abbr> needs title="…" and the <time> needs datetime="…".',
              ],
              requirements: [
                doctype(),
                unique('title', 'The page has its own title'),
                unique('h1', 'Exactly one h1'),
                count('h2', 2, null, 'At least two h2 sections'),
                headingOrder(),
                count('p', 3, null, 'At least three paragraphs'),
                present('ul li, ol li', 'There is a list with items'),
                present('strong', 'Uses <strong> for something important'),
                present('em', 'Uses <em> for stress emphasis'),
                present('abbr[title], time[datetime]', 'Uses an abbreviation with a title, or a time with a datetime'),
                present('blockquote', 'There is a block quotation'),
                present('figcaption', 'The quotation is attributed with a figcaption'),
                legalNesting(),
                { kind: 'no_duplicate_ids', message: 'Every id is unique' },
              ],
              difficulty: 3,
              xp: 100,
              skill: 'text-semantics',
            },
            {
              slug: 'article-mission',
              kind: 'project_mission',
              title: 'Capstone mission: add about.html',
              brief:
                'Add a second page to your capstone site: `about.html`. It should tell the story behind your project using the semantics from this level — headings, paragraphs, a list, and at least one quotation or key date.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About — your site name</title>
  </head>
  <body>
    <h1>About us</h1>
    <p>Replace with your own opening paragraph.</p>

    <h2>A section heading</h2>
    <p>More of your own content.</p>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About us — Riverside Cycle Hire</title>
  </head>
  <body>
    <h1>About us</h1>
    <p>We have hired bikes from the same Mill Lane workshop since 1998.</p>
    <h2>What we believe</h2>
    <p><strong>Every bike leaves serviced.</strong> No exceptions.</p>
    <ul>
      <li>Mechanics on site, every day we are open</li>
      <li>Helmet and lock included with every hire</li>
    </ul>
    <h2>Our history</h2>
    <p>We opened on <time datetime="1998-04-02">2 April 1998</time> with six bikes.</p>
  </body>
</html>`,
              hints: [
                'Replace every placeholder sentence with your own content.',
                'At least two <h2> sections keeps the page readable.',
                'Include a list and either a <time datetime="…"> or a quotation.',
              ],
              requirements: [
                doctype(),
                unique('h1', 'One h1 naming the page'),
                count('h2', 1, null, 'At least one h2 section'),
                headingOrder(),
                count('p', 2, null, 'At least two paragraphs of your own'),
                present('ul li, ol li', 'A list of items'),
                present('strong, em, time[datetime], blockquote', 'At least one text-level semantic element'),
              ],
              difficulty: 3,
              xp: 70,
              skill: 'multi-page',
            },
          ],
          quiz: [
            {
              slug: 'q-semantic-choice',
              prompt: 'You are marking up "Doors open at 7pm." on an event page. What is the best markup?',
              explanation:
                'Wrapping the time in `<time datetime="19:00">` keeps the friendly wording while making the value machine-readable — calendars and search engines can then use it.',
              options: [
                { label: '<p>Doors open at <time datetime="19:00">7pm</time>.</p>', correct: true },
                { label: '<p>Doors open at <strong>7pm</strong>.</p>' },
                { label: '<h3>Doors open at 7pm.</h3>' },
                { label: '<p>Doors open at <b>7pm</b>.</p>' },
              ],
              skill: 'text-semantics',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'level-2-milestone',
    kind: 'milestone',
    title: 'Level 2 milestone: Content Builder',
    description: 'Eight questions on headings, paragraphs, text semantics and lists. Pass mark 75%.',
    passScore: 0.75,
    xp: 150,
    questions: [
      {
        slug: 'a2-q1',
        prompt: 'A page has an `<h2>`, and the next heading needs to be one level down. Which element?',
        explanation: 'Levels step down one at a time: `<h2>` is followed by `<h3>`.',
        options: [
          { label: '<h3>', correct: true },
          { label: '<h4>' },
          { label: '<h1>' },
          { label: '<p><strong>' },
        ],
        skill: 'text-semantics',
      },
      {
        slug: 'a2-q2',
        prompt: 'Which element marks a change of subject?',
        explanation: '`<hr>` means a thematic break. The horizontal line is only its default appearance.',
        options: [
          { label: '<hr>', correct: true },
          { label: '<br>' },
          { label: '<small>' },
          { label: '<mark>' },
        ],
        skill: 'text-semantics',
      },
      {
        slug: 'a2-q3',
        prompt: 'Which is the correct use of `<strong>`?',
        explanation: '`<strong>` conveys importance or urgency, not merely bold appearance.',
        options: [
          { label: 'Around a safety warning', correct: true },
          { label: 'Around a page heading' },
          { label: 'Around a word you want stressed when read aloud' },
          { label: 'Around anything you want in bold' },
        ],
        skill: 'text-semantics',
      },
      {
        slug: 'a2-q4',
        prompt: 'Which three characters genuinely need HTML entities?',
        explanation:
          'Only `<`, `>` and `&` have special meaning in HTML. With UTF-8, other characters can be typed directly.',
        options: [
          { label: '< > &', correct: true },
          { label: '© é —' },
          { label: '" \' /' },
          { label: '£ $ €' },
        ],
        skill: 'text-semantics',
      },
      {
        slug: 'a2-q5',
        prompt: 'Which list would you use for a glossary of terms?',
        explanation: '`<dl>` pairs each term (`<dt>`) with its description (`<dd>`).',
        options: [
          { label: '<dl>', correct: true },
          { label: '<ul>' },
          { label: '<ol>' },
          { label: '<table>' },
        ],
        skill: 'lists',
      },
      {
        slug: 'a2-q6',
        prompt: 'What is wrong with using `<br><br>` between two paragraphs?',
        explanation:
          'The paragraphs already separate themselves. The breaks add empty content that spacing should provide, and it cannot adapt responsively.',
        options: [
          { label: 'It adds meaningless content where spacing belongs', correct: true },
          { label: 'It is invalid HTML' },
          { label: 'Browsers ignore it entirely' },
          { label: 'It creates a duplicate id' },
        ],
        skill: 'text-semantics',
      },
      {
        slug: 'a2-q7',
        prompt: 'Where must a nested list be placed?',
        explanation: 'Inside the `<li>` it belongs to.',
        options: [
          { label: 'Inside the <li> it relates to', correct: true },
          { label: 'Directly inside the parent <ul>' },
          { label: 'Between two <li> elements' },
          { label: 'After the parent list' },
        ],
        skill: 'lists',
      },
      {
        slug: 'a2-q8',
        prompt: 'What does `<pre>` do that other elements do not?',
        explanation:
          'It preserves whitespace exactly as written — the one place HTML does not collapse spaces and line breaks.',
        options: [
          { label: 'Preserves spaces and line breaks exactly', correct: true },
          { label: 'Marks text as computer code' },
          { label: 'Prevents the text being copied' },
          { label: 'Escapes HTML entities automatically' },
        ],
        skill: 'text-semantics',
      },
    ],
  },
};
