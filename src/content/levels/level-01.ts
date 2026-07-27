import {
  annotated,
  attrValue,
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
  uniqueIds,
  visual,
  type LevelSpec,
} from '../types';

export const LEVEL_01: LevelSpec = {
  slug: 'html-explorer',
  title: 'HTML Explorer',
  subtitle: 'From "I have never written code" to a real, valid web page',
  summary:
    'Every word in this level is explained before it is used. You will learn what a browser actually does, what an HTML file is, and how to write one that a browser understands.',
  outcome: 'You can write a correctly structured HTML page from a blank file, from memory.',
  accent: 'blue',
  modules: [
    // -----------------------------------------------------------------------
    {
      slug: 'how-the-web-works',
      title: 'How the web actually works',
      summary:
        'Before writing anything, a short, plain-English picture of what happens between clicking a link and seeing a page.',
      estimatedMinutes: 35,
      skills: [{ slug: 'document-structure', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'what-happens-when-you-open-a-page',
          title: 'What happens when you open a web page',
          subtitle: 'Browsers, servers, and the file in the middle',
          summary:
            'A web page is a text file that one computer sends to another. Understanding that one sentence makes everything else easier.',
          objectives: [
            'Explain in your own words what a browser does',
            'Describe what a web server sends when you visit a page',
            'Recognise HTML as plain text, not a picture of a page',
          ],
          estimatedMinutes: 12,
          skill: 'document-structure',
          blocks: [
            objectives([
              'Explain what a browser does with a web page',
              'Describe what travels across the internet when you visit a site',
              'Recognise that HTML is ordinary text you can read and write',
            ]),
            prose(
              'When you type an address into a browser and press Enter, your computer asks another computer for a file. That other computer sends the file back. Your browser then reads the file and draws it on your screen. That is the whole story — everything else is detail.',
            ),
            term(
              'Browser',
              'The program you use to look at websites — Chrome, Firefox, Safari, Edge. Its job is to fetch files and turn them into something you can see and click.',
              'Chrome, Firefox, Safari and Edge are all browsers.',
            ),
            term(
              'Server',
              'A computer, somewhere else, whose job is to hold files and hand them out when asked. Nothing mysterious — just a computer that is always switched on.',
            ),
            visual(
              'how-the-web-works',
              'Your browser asks. A server answers with a file. Your browser draws what the file describes.',
            ),
            prose(
              'The file that comes back is written in HTML. HTML is plain text — the same kind of text you could type into any notepad app. It contains the words of the page plus small labels that say what each piece of text *is*: a heading, a paragraph, a link, an image.',
            ),
            term(
              'HTML',
              'HyperText Markup Language. "Markup" means you take ordinary text and mark parts of it up with labels. Those labels tell the browser what each part means.',
            ),
            callout(
              'note',
              'HTML is not a programming language',
              'Programming languages make decisions and do calculations. HTML does neither. HTML describes structure and meaning: "this is a heading", "this is a list", "this is a photograph of a bicycle". That is a genuine relief — there is far less to learn than people expect.',
            ),
            code(
              `<h1>Fresh bread, every morning</h1>
<p>We open at 6am and bake until we sell out.</p>`,
              'What HTML actually looks like',
            ),
            prose(
              'Above, `<h1>` marks the most important heading on the page and `<p>` marks a paragraph. The browser reads those labels and decides that the heading should be big and bold and the paragraph should be normal-sized. You never had to say "make it big" — you said what it *was*, and the browser did the rest.',
            ),
            detail(
              'What about CSS and JavaScript?',
              'A finished website usually involves three languages. HTML describes the structure and meaning. CSS controls the appearance — colours, spacing, layout. JavaScript adds behaviour — things that respond and change. This course is about HTML, which is the foundation the other two are attached to. While you learn, HTML Hero supplies a professional stylesheet for your previews so your work looks good without you needing to know any CSS yet. You will see exactly where that boundary sits, clearly labelled, on every preview.',
            ),
            recap(
              [
                'A browser fetches a file from a server and draws it on screen.',
                'That file is HTML: ordinary text with labels around parts of it.',
                'The labels say what a piece of content *means*, and the browser decides how to display it.',
                'HTML is not a programming language — it describes, it does not calculate.',
              ],
              'Next: the file itself, and the tool you write it in.',
            ),
          ],
          exercises: [
            {
              slug: 'first-markup-guided',
              kind: 'guided',
              title: 'Label two pieces of text',
              brief:
                'The editor below contains two lines of plain text with no labels. Wrap the first line in an `<h1>` element so the browser knows it is the main heading, and wrap the second in a `<p>` element so it knows it is a paragraph. Press "Check my work" when you are done, then watch the preview change.',
              starterCode: `Fresh bread, every morning
We open at 6am and bake until we sell out.`,
              referenceSolution: `<h1>Fresh bread, every morning</h1>
<p>We open at 6am and bake until we sell out.</p>`,
              hints: [
                'A label goes before and after the text it applies to. The one before is written <h1> and the one after is written </h1> — note the slash.',
                'So the first line becomes: <h1>Fresh bread, every morning</h1>',
                'Do the same for the second line, but with p instead of h1: <p>We open at 6am and bake until we sell out.</p>',
              ],
              requirements: [
                unique('h1', 'There is exactly one <h1> heading'),
                notEmpty('h1', 'The heading has text inside it'),
                present('p', 'There is a paragraph'),
                notEmpty('p', 'The paragraph has text inside it'),
              ],
              difficulty: 1,
              xp: 30,
              skill: 'syntax',
            },
            {
              slug: 'first-markup-debug',
              kind: 'debug',
              title: 'Find the missing slash',
              brief:
                'This markup nearly works, but one closing label is wrong, so the browser swallows the rest of the page. Find it and fix it. The preview will tell you when you have got it.',
              starterCode: `<h1>Riverside Cycle Hire<h1>
<p>Bikes, helmets and route maps, seven days a week.</p>`,
              referenceSolution: `<h1>Riverside Cycle Hire</h1>
<p>Bikes, helmets and route maps, seven days a week.</p>`,
              hints: [
                'Look carefully at the two h1 labels. One of them is meant to close the heading.',
                'A closing label always has a forward slash after the opening angle bracket: </h1>',
              ],
              requirements: [
                unique('h1', 'There is exactly one <h1>, correctly closed'),
                present('p', 'The paragraph survives outside the heading'),
                textIn('p', 'Bikes', 'The paragraph text is still in the paragraph'),
              ],
              difficulty: 1,
              xp: 25,
              skill: 'syntax',
            },
          ],
          quiz: [
            {
              slug: 'q-what-is-html',
              prompt: 'What does a web server send to your browser when you visit a page?',
              explanation:
                'The server sends files — starting with an HTML file. Your browser reads that file and draws the page from it. The picture you see is produced on your computer, not sent as a picture.',
              options: [
                { label: 'A text file containing HTML, which the browser draws', correct: true },
                { label: 'A picture of the finished page' },
                { label: 'A program that runs on your computer' },
                { label: 'A video recording of the website' },
              ],
              skill: 'document-structure',
            },
            {
              slug: 'q-html-purpose',
              prompt: 'What is the job of HTML?',
              explanation:
                'HTML describes what content *is* — a heading, a paragraph, a link. Appearance is CSS\'s job, and behaviour is JavaScript\'s job.',
              options: [
                { label: 'To describe what each piece of content means', correct: true },
                { label: 'To choose the colours and fonts of a page' },
                { label: 'To make buttons respond when clicked' },
                { label: 'To store a website\'s data' },
              ],
              skill: 'document-structure',
            },
          ],
        },
        {
          slug: 'tags-elements-attributes',
          title: 'Tags, elements and attributes',
          subtitle: 'The three words that unlock everything else',
          summary:
            'Almost all of HTML is one pattern repeated. Learn the pattern once and every new element becomes easy.',
          objectives: [
            'Tell a tag apart from an element',
            'Write an attribute correctly, with its name and value',
            'Recognise elements that have no closing tag',
          ],
          estimatedMinutes: 14,
          skill: 'syntax',
          blocks: [
            objectives([
              'Explain the difference between a tag and an element',
              'Add an attribute to an element with the correct syntax',
              'Identify void elements, which never have a closing tag',
            ]),
            prose(
              'Nearly everything in HTML follows one pattern: an opening tag, some content, and a closing tag. Together those three things are called an element.',
            ),
            visual('anatomy-of-an-element', 'Every part of an element, labelled.'),
            term('Tag', 'The bit in angle brackets. `<p>` is an opening tag; `</p>` is a closing tag.'),
            term(
              'Element',
              'The opening tag, the content and the closing tag together. `<p>Hello</p>` is one paragraph element.',
            ),
            term(
              'Attribute',
              'Extra information written inside the opening tag, as `name="value"`. It tells the browser something the tag alone cannot.',
              '<a href="about.html">About us</a> — here `href` is the attribute name and `about.html` is its value.',
            ),
            annotated(
              `<a href="about.html" title="Learn about our bakery">About us</a>`,
              [
                { line: '1', text: '`<a` starts a link element. The letter "a" stands for anchor.' },
                {
                  line: '1',
                  text: '`href="about.html"` is an attribute. `href` means "hypertext reference" — where the link goes. Its value sits in quotation marks.',
                },
                {
                  line: '1',
                  text: '`title="…"` is a second attribute. Attributes are separated by a single space, and an element can have as many as it needs.',
                },
                { line: '1', text: '`>` closes the opening tag. Everything after it is the content.' },
                {
                  line: '1',
                  text: '`About us` is the content — the words a person actually sees and clicks.',
                },
                { line: '1', text: '`</a>` closes the element. The slash is what makes it a closing tag.' },
              ],
            ),
            callout(
              'mistake',
              'The three mistakes everyone makes at first',
              'Forgetting the slash in the closing tag (`<p>` twice instead of `<p>` then `</p>`). Forgetting the quotation marks around an attribute value. Putting a space around the equals sign — write `href="x"`, not `href = "x"`. All three are normal, and the checker in this course names them for you.',
            ),
            prose(
              'A small number of elements have nothing to put between an opening and closing tag, because they are not wrapping anything. These are called void elements, and they are written as a single tag.',
            ),
            code(
              `<br>
<hr>
<img src="/learning-media/images/coast-sunrise.jpg" alt="Sunrise over a calm sea">`,
              'Void elements: one tag, no closing tag',
            ),
            prose(
              'There are only fifteen void elements in the whole language, and you will meet the useful ones — `<br>`, `<hr>`, `<img>`, `<input>`, `<meta>`, `<link>`, `<source>`, `<track>` — as the course goes on. You never need to memorise the list.',
            ),
            demo('See it change', 'Watch what the same words look like with different labels around them.', [
              {
                label: 'As a heading',
                code: '<h1>Opening hours</h1>',
                note: 'The browser makes it large and bold, and screen readers announce it as a heading.',
              },
              {
                label: 'As a paragraph',
                code: '<p>Opening hours</p>',
                note: 'Normal body text. Correct if it is a sentence, wrong if it is really a heading.',
              },
              {
                label: 'As a link',
                code: '<a href="hours.html">Opening hours</a>',
                note: 'Now it is interactive — it can be clicked, and reached with the Tab key.',
              },
            ]),
            compare(
              'Attributes: written correctly, and written wrongly',
              {
                label: 'Correct',
                code: '<a href="contact.html">Contact us</a>',
                why: 'Attribute name, equals sign, value in quotation marks, no stray spaces.',
              },
              {
                label: 'Broken',
                code: '<a href = contact.html>Contact us</a>',
                why: 'Spaces around the equals sign and no quotation marks. Browsers sometimes forgive this, but it breaks the moment the value contains a space.',
              },
            ),
            checklist('Before you move on, you can', [
              'Point at a tag and an element and say which is which',
              'Write an attribute with its quotation marks',
              'Name two void elements',
            ]),
            recap(
              [
                'A tag is one label in angle brackets; an element is the opening tag, content and closing tag together.',
                'Attributes live inside the opening tag and are written `name="value"`.',
                'Void elements such as `<br>`, `<hr>` and `<img>` have no closing tag because they wrap nothing.',
              ],
              'Next: how elements sit inside one another.',
            ),
          ],
          exercises: [
            {
              slug: 'attributes-guided',
              kind: 'guided',
              title: 'Add an attribute to a link',
              brief:
                'The link below has no destination, so clicking it does nothing. Add an `href` attribute with the value `opening-hours.html`, keeping the visible text exactly as it is.',
              starterCode: `<p>Check our <a>opening hours</a> before you visit.</p>`,
              referenceSolution: `<p>Check our <a href="opening-hours.html">opening hours</a> before you visit.</p>`,
              hints: [
                'An attribute goes inside the opening tag, after the element name, separated by a space.',
                'The pattern is: <a href="value">',
                'The finished tag is <a href="opening-hours.html"> — remember the quotation marks.',
              ],
              requirements: [
                present('a', 'There is a link element'),
                attrValue('a', 'href', 'opening-hours.html', 'The link points to opening-hours.html'),
                textIn('a', 'opening hours', 'The link text is unchanged'),
                inside('a', 'p', 'The link is still inside the paragraph'),
              ],
              difficulty: 1,
              xp: 30,
              skill: 'syntax',
            },
            {
              slug: 'attributes-challenge',
              kind: 'challenge',
              title: 'Build a small block of content',
              brief:
                'Write three elements, in this order: a level-one heading naming any business you like, a paragraph describing it in a sentence, and a link to `menu.html` with sensible link text. The words are entirely up to you — the structure is what is being checked.',
              starterCode: '',
              referenceSolution: `<h1>The Blue Door Café</h1>
<p>A small neighbourhood café serving proper coffee and slow-baked pastries.</p>
<a href="menu.html">See our menu</a>`,
              hints: [
                'You need three separate elements, each on its own line.',
                'Start with <h1>…</h1>, then <p>…</p>, then a link.',
                'The link needs an href attribute pointing at menu.html.',
              ],
              requirements: [
                unique('h1', 'Exactly one <h1> heading'),
                notEmpty('h1', 'The heading is not empty'),
                present('p', 'A paragraph describing the business'),
                notEmpty('p', 'The paragraph is not empty'),
                attrValue('a', 'href', 'menu.html', 'A link pointing at menu.html'),
                notEmpty('a', 'The link has visible text'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'syntax',
            },
            {
              slug: 'attributes-debug',
              kind: 'debug',
              title: 'Three broken attributes',
              brief:
                'Every line below has one attribute mistake. Fix all three. Read the checker messages if you get stuck — they name the problem.',
              starterCode: `<a href=about.html>About</a>
<img src="/learning-media/images/studio-desk.jpg alt="A tidy desk">
<a href = "contact.html">Contact</a>`,
              referenceSolution: `<a href="about.html">About</a>
<img src="/learning-media/images/studio-desk.jpg" alt="A tidy desk">
<a href="contact.html">Contact</a>`,
              hints: [
                'Line 1: the value has no quotation marks around it.',
                'Line 2: a quotation mark is opened but never closed, so the alt text got swallowed.',
                'Line 3: there should be no spaces around the equals sign.',
              ],
              requirements: [
                count('a', 2, 2, 'Both links survive'),
                attrValue('a[href="about.html"]', 'href', 'about.html', 'The first link points at about.html'),
                attrValue('a[href="contact.html"]', 'href', 'contact.html', 'The second link points at contact.html'),
                present('img', 'The image element is still there'),
                textIn('a', 'About', 'The first link still says About'),
              ],
              difficulty: 2,
              xp: 35,
              skill: 'validation',
            },
          ],
          quiz: [
            {
              slug: 'q-tag-vs-element',
              prompt: 'In `<p>Hello</p>`, which part is the element?',
              explanation:
                'The element is the whole thing: opening tag, content and closing tag. `<p>` on its own is just a tag.',
              options: [
                { label: 'The whole of `<p>Hello</p>`', correct: true },
                { label: 'Just `<p>`' },
                { label: 'Just the word `Hello`' },
                { label: 'Just `</p>`' },
              ],
              skill: 'syntax',
            },
            {
              slug: 'q-attribute-syntax',
              prompt: 'Which of these writes an attribute correctly?',
              explanation:
                'The name touches the equals sign, the equals sign touches the value, and the value sits in quotation marks.',
              options: [
                { label: '<a href="shop.html">', correct: true },
                { label: '<a href = shop.html>' },
                { label: '<a href: "shop.html">' },
                { label: '<a "href"=shop.html>' },
              ],
              skill: 'syntax',
            },
            {
              slug: 'q-void-elements',
              prompt: 'Why does `<img>` have no closing tag?',
              explanation:
                'Void elements do not wrap any content, so there is nothing for a closing tag to close. Everything the element needs is given as attributes.',
              options: [
                { label: 'It wraps no content, so there is nothing to close', correct: true },
                { label: 'Because images load separately from the page' },
                { label: 'Closing tags are optional on every element' },
                { label: 'It is a shorthand that older browsers required' },
              ],
              skill: 'syntax',
            },
          ],
        },
        {
          slug: 'nesting-and-the-document-tree',
          title: 'Nesting and the document tree',
          subtitle: 'Why order matters, and how to keep it readable',
          summary:
            'Elements go inside other elements. Getting the order right is the single biggest thing that separates markup that works from markup that mysteriously does not.',
          objectives: [
            'Nest elements in the correct order',
            'Read an HTML document as a tree',
            'Indent your code so mistakes become visible',
          ],
          estimatedMinutes: 14,
          skill: 'syntax',
          blocks: [
            objectives([
              'Nest elements correctly and spot when they overlap',
              'Describe a page as a tree of parents and children',
              'Use indentation and comments to keep markup readable',
            ]),
            prose(
              'Elements can contain other elements. When they do, they must be closed in the reverse of the order they were opened — like closing a set of brackets. Think of it as boxes inside boxes: you cannot close the outer box before the inner one.',
            ),
            compare(
              'Nesting: correct and overlapping',
              {
                label: 'Correct',
                code: '<p>Open <strong>every morning</strong> at six.</p>',
                why: '`<strong>` is opened and closed entirely inside the paragraph.',
              },
              {
                label: 'Overlapping — never valid',
                code: '<p>Open <strong>every morning</p></strong> at six.',
                why: 'The paragraph is closed while `<strong>` is still open. Browsers guess at a repair, and every browser guesses differently.',
              },
            ),
            visual(
              'document-tree',
              'Every HTML page is a tree. One element at the root, branching downwards.',
            ),
            term(
              'Nesting',
              'Placing one element inside another. The inside element is called a child; the outside one is its parent.',
            ),
            term(
              'The DOM',
              'Document Object Model. It is simply the name for this tree once the browser has built it in memory. When people say "inspect the DOM", they mean "look at the live tree".',
            ),
            prose(
              'Because the structure is a tree, the way you lay out your code should show that tree. Every time you go one level deeper, indent by two spaces. This is not decoration — it is how you spot a missing closing tag with your eyes instead of with a checker.',
            ),
            annotated(
              `<article>
  <h2>Sourdough workshop</h2>
  <p>
    A three-hour session covering
    <strong>starter care</strong> and shaping.
  </p>
</article>`,
              [
                { line: '1', text: '`<article>` opens at the far left — it is the outermost element here.' },
                { line: '2-5', text: 'Its children are indented two spaces, showing they sit inside it.' },
                { line: '4', text: 'The `<strong>` is a child of the paragraph, so it is indented again.' },
                {
                  line: '6',
                  text: '`</article>` lines up exactly with `<article>`. If the indentation of an opening and closing tag do not line up, something is wrong.',
                },
              ],
            ),
            prose(
              'You can also leave notes for yourself in the file. Anything between `<!--` and `-->` is a comment: the browser ignores it completely, and it never appears on the page.',
            ),
            code(
              `<!-- Opening hours are updated every Monday -->
<p>Open 6am to 2pm, Tuesday to Sunday.</p>`,
              'A comment',
            ),
            callout(
              'warning',
              'Comments are not private',
              'Anyone can view the source of your page and read your comments. Never put passwords, personal information or unflattering remarks in them.',
            ),
            detail(
              'What browsers do with broken nesting',
              'The HTML specification defines a detailed error-recovery algorithm, so a browser will always produce *something* from broken markup rather than showing an error. That sounds helpful, and it is — but the repair it chooses may not be the page you intended, and CSS and JavaScript written against the structure you meant will then fail in confusing ways. This is why the checker in this course reports overlapping tags as errors even though the preview still renders.',
            ),
            recap(
              [
                'Elements nest inside one another and must close in reverse order.',
                'The nested structure is a tree; the browser\'s live copy of it is called the DOM.',
                'Indent two spaces per level so a missing closing tag is visible at a glance.',
                'Comments (`<!-- … -->`) are ignored by the browser but readable by anyone.',
              ],
              'Next: the skeleton every real HTML file needs.',
            ),
          ],
          exercises: [
            {
              slug: 'nesting-guided',
              kind: 'guided',
              title: 'Nest a list correctly',
              brief:
                'Build an unordered list (`<ul>`) containing exactly three list items (`<li>`), one for each of three services. Indent the items two spaces inside the list.',
              starterCode: `<ul>

</ul>`,
              referenceSolution: `<ul>
  <li>Bike hire by the hour or day</li>
  <li>Guided river routes</li>
  <li>Repairs while you wait</li>
</ul>`,
              hints: [
                'Each item is its own element: <li>…</li>',
                'All three <li> elements go between the <ul> and the </ul>.',
                'Indent each <li> by two spaces so the nesting is visible.',
              ],
              requirements: [
                present('ul', 'There is an unordered list'),
                count('ul > li', 3, 3, 'The list has exactly three items'),
                notEmpty('li', 'Every item has text'),
                legalNesting(),
              ],
              difficulty: 1,
              xp: 30,
              skill: 'syntax',
            },
            {
              slug: 'nesting-debug',
              kind: 'debug',
              title: 'Untangle the overlap',
              brief:
                'The two elements below overlap instead of nesting. Rearrange the closing tags so `<em>` is fully inside the paragraph, keeping the words in the same order.',
              starterCode: `<p>Booking is <em>strongly recommended</p></em> at weekends.`,
              referenceSolution: `<p>Booking is <em>strongly recommended</em> at weekends.</p>`,
              hints: [
                'Whichever element opened last must close first.',
                '<em> opened second, so </em> must come before </p>.',
                'The word "at weekends" belongs inside the paragraph too, so </p> goes at the very end.',
              ],
              requirements: [
                present('p', 'The paragraph exists'),
                inside('em', 'p', 'The emphasis is nested inside the paragraph'),
                textIn('p', 'at weekends', 'All the text is inside the paragraph'),
                legalNesting(),
              ],
              difficulty: 2,
              xp: 35,
              skill: 'validation',
            },
          ],
          quiz: [
            {
              slug: 'q-nesting-order',
              prompt: 'Which of these is nested correctly?',
              explanation:
                'The element opened last must be closed first. In the correct answer, `<strong>` opens and closes entirely inside the paragraph.',
              options: [
                { label: '<p>Open <strong>daily</strong> from six.</p>', correct: true },
                { label: '<p>Open <strong>daily</p></strong> from six.' },
                { label: '<strong><p>Open daily</strong> from six.</p>' },
                { label: '<p>Open <strong>daily from six.</p>' },
              ],
              skill: 'syntax',
            },
            {
              slug: 'q-dom-meaning',
              prompt: 'What does "the DOM" refer to?',
              explanation:
                'The DOM is the browser\'s live, in-memory tree of your document. Your HTML file is the recipe; the DOM is the thing the browser actually built from it.',
              options: [
                { label: 'The tree of elements the browser builds from your HTML', correct: true },
                { label: 'A file format for storing web pages' },
                { label: 'The stylesheet that controls appearance' },
                { label: 'The name of the browser\'s address bar' },
              ],
              skill: 'syntax',
            },
            {
              slug: 'q-comments',
              prompt: 'Which statement about HTML comments is true?',
              explanation:
                'Comments are stripped from what the browser displays, but they are still sent to every visitor and anyone can read them by viewing the page source.',
              options: [
                { label: 'They are invisible on the page but readable in the page source', correct: true },
                { label: 'They are removed before the file is sent to the browser' },
                { label: 'They are only visible to the site owner' },
                { label: 'They appear on the page in a smaller font' },
              ],
              skill: 'syntax',
            },
          ],
        },
      ],
    },

    // -----------------------------------------------------------------------
    {
      slug: 'the-html-skeleton',
      title: 'The skeleton of every page',
      summary:
        'The five things every real HTML file needs, why each one exists, and what breaks without them.',
      estimatedMinutes: 40,
      prerequisites: ['how-the-web-works'],
      skills: [
        { slug: 'document-structure', masteryRequired: 0.5 },
        { slug: 'syntax', masteryRequired: 0.5 },
      ],
      lessons: [
        {
          slug: 'doctype-html-head-body',
          title: 'Doctype, html, head and body',
          subtitle: 'The frame that every page hangs on',
          summary:
            'Four lines that appear in every HTML file ever written. This lesson explains what each one is actually for.',
          objectives: [
            'Write the standard skeleton of an HTML document from memory',
            'Explain what goes in the head and what goes in the body',
            'Say what the doctype is for',
          ],
          estimatedMinutes: 15,
          skill: 'document-structure',
          blocks: [
            objectives([
              'Write a complete HTML document skeleton without copying it',
              'Decide correctly whether a piece of content belongs in the head or the body',
              'Explain why the doctype must be the first line',
            ]),
            prose(
              'So far you have written fragments. A real HTML file needs a frame around them. Here is that frame, complete — then we will take it apart line by line.',
            ),
            annotated(
              `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Riverside Cycle Hire</title>
  </head>
  <body>
    <h1>Riverside Cycle Hire</h1>
    <p>Bikes, helmets and route maps, seven days a week.</p>
  </body>
</html>`,
              [
                {
                  line: '1',
                  text: '`<!DOCTYPE html>` tells the browser to use modern HTML rules. It is not really a tag, and it takes no closing tag. Leave it out and browsers fall back to a twenty-year-old compatibility mode where sizes and layouts behave oddly. It must be the very first thing in the file.',
                },
                {
                  line: '2',
                  text: '`<html>` is the root element — everything else lives inside it. `lang="en"` states the language, which lets screen readers use the right pronunciation and helps browsers offer translation.',
                },
                {
                  line: '3-7',
                  text: '`<head>` holds information *about* the page. Nothing in here is displayed in the page itself.',
                },
                {
                  line: '4',
                  text: '`<meta charset="utf-8">` says which alphabet the file uses. UTF-8 covers essentially every character in every language. Without it, characters like é, £ and — turn into gibberish.',
                },
                {
                  line: '5',
                  text: 'The viewport line tells phones to use their real width rather than pretending to be a desktop and shrinking everything. Without it your page arrives on a phone zoomed out and unreadable.',
                },
                {
                  line: '6',
                  text: '`<title>` is the text in the browser tab, the name used when someone bookmarks the page, and the headline in search results. Every page needs its own.',
                },
                {
                  line: '8-11',
                  text: '`<body>` holds everything a visitor actually sees: headings, text, images, links, forms.',
                },
                { line: '12', text: '`</html>` closes the root element and ends the document.' },
              ],
            ),
            term(
              'Head',
              'The part of the document that describes the page: its title, its character set, its description. None of it appears on the page itself.',
            ),
            term('Body', 'The part of the document that holds visible content.'),
            callout(
              'mistake',
              'The classic beginner error',
              'Putting a heading inside `<head>` because "the heading is at the head of the page". They are unrelated. `<head>` is for information *about* the page; `<h1>` is visible content and belongs in `<body>`.',
            ),
            demo('Head or body?', 'Both documents contain the same words. Only one shows them.', [
              {
                label: 'Correct — content in the body',
                code: '<!DOCTYPE html>\n<html lang="en">\n  <head><title>Hours</title></head>\n  <body><h1>Opening hours</h1></body>\n</html>',
                note: 'The heading appears on the page, and "Hours" appears in the browser tab.',
              },
              {
                label: 'Wrong — content in the head',
                code: '<!DOCTYPE html>\n<html lang="en">\n  <head><title>Hours</title><h1>Opening hours</h1></head>\n  <body></body>\n</html>',
                note: 'The page is blank. The browser moves the stray heading out of the head, but you cannot rely on how.',
              },
            ]),
            checklist('Every page you write from now on has', [
              '`<!DOCTYPE html>` on line one',
              '`<html lang="en">` (or the correct language for your content)',
              '`<meta charset="utf-8">` as the first thing in the head',
              'A viewport meta tag',
              'A `<title>` that describes this particular page',
              'All visible content inside `<body>`',
            ]),
            recap(
              [
                'The doctype must be the first line, and switches the browser into modern mode.',
                '`<html lang="…">` wraps the whole document and states its language.',
                '`<head>` describes the page; `<body>` holds what people see.',
                'The charset and viewport meta tags are not optional in practice — pages break without them.',
              ],
              'Next: your first complete page, built from a blank file.',
            ),
          ],
          exercises: [
            {
              slug: 'skeleton-guided',
              kind: 'guided',
              title: 'Complete the skeleton',
              brief:
                'Three pieces are missing from this document: the doctype, the character set meta tag and the title. Add all three in the right places.',
              starterCode: `<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
  </head>
  <body>
    <h1>Harbour View Guesthouse</h1>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Harbour View Guesthouse</title>
  </head>
  <body>
    <h1>Harbour View Guesthouse</h1>
  </body>
</html>`,
              hints: [
                'The doctype goes above everything else, on its own line.',
                'The charset meta tag should be the first element inside <head>.',
                'The title element goes in the head too: <title>Harbour View Guesthouse</title>',
              ],
              requirements: [
                doctype(),
                attrValue('html', 'lang', 'en', 'The html element declares its language'),
                attrValue('meta[charset]', 'charset', 'utf-8', 'The character set is declared as utf-8'),
                inside('meta[charset]', 'head', 'The charset meta tag is inside the head'),
                unique('title', 'There is exactly one title'),
                notEmpty('title', 'The title has text'),
                inside('title', 'head', 'The title is inside the head'),
                inside('h1', 'body', 'The heading is inside the body'),
              ],
              difficulty: 2,
              xp: 40,
              skill: 'document-structure',
            },
            {
              slug: 'skeleton-debug',
              kind: 'debug',
              title: 'Content in the wrong half',
              brief:
                'This page renders blank. Two elements are in the head that belong in the body, and one element is in the body that belongs in the head. Move all three.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <h1>Northgate Dental</h1>
    <p>Accepting new patients.</p>
  </head>
  <body>
    <title>Northgate Dental</title>
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Northgate Dental</title>
  </head>
  <body>
    <h1>Northgate Dental</h1>
    <p>Accepting new patients.</p>
  </body>
</html>`,
              hints: [
                'Visible content — headings and paragraphs — always goes in the body.',
                'The title describes the page rather than being part of it, so it belongs in the head.',
                'After moving them, the head should contain only the meta tag and the title.',
              ],
              requirements: [
                inside('h1', 'body', 'The heading is in the body'),
                inside('p', 'body', 'The paragraph is in the body'),
                inside('title', 'head', 'The title is in the head'),
                count('head > h1', 0, 0, 'No heading is left in the head'),
                doctype(),
              ],
              difficulty: 2,
              xp: 35,
              skill: 'document-structure',
            },
          ],
          quiz: [
            {
              slug: 'q-doctype-purpose',
              prompt: 'What does `<!DOCTYPE html>` do?',
              explanation:
                'It switches the browser into standards mode. Without it, browsers use a legacy compatibility mode where sizing and layout behave differently — a source of very confusing bugs.',
              options: [
                { label: 'Tells the browser to use modern HTML rules', correct: true },
                { label: 'Loads the HTML language into the browser' },
                { label: 'Declares which version of your file this is' },
                { label: 'Creates the html element' },
              ],
              skill: 'document-structure',
            },
            {
              slug: 'q-head-vs-body',
              prompt: 'Where does `<title>` belong?',
              explanation:
                'The title describes the page rather than being part of its visible content, so it lives in the head. It appears in the browser tab, in bookmarks and in search results.',
              options: [
                { label: 'Inside <head>', correct: true },
                { label: 'Inside <body>, at the top' },
                { label: 'Immediately after <!DOCTYPE html>' },
                { label: 'Anywhere in the document' },
              ],
              skill: 'document-structure',
            },
            {
              slug: 'q-viewport',
              prompt: 'What goes wrong if you omit the viewport meta tag?',
              explanation:
                'Phones default to pretending they are about 980 pixels wide and then shrink the result, so your page arrives zoomed out and the text is too small to read.',
              options: [
                { label: 'Phones render the page zoomed out and unreadably small', correct: true },
                { label: 'The page fails to load on mobile devices' },
                { label: 'Images lose their aspect ratio' },
                { label: 'Nothing — it only matters for printing' },
              ],
              skill: 'document-structure',
            },
            {
              slug: 'q-charset',
              prompt: 'Why declare `<meta charset="utf-8">`?',
              explanation:
                'It tells the browser which character encoding the file uses. UTF-8 covers virtually every writing system; without the declaration, accented and non-Latin characters can render as nonsense.',
              options: [
                { label: 'So characters like é, £ and — display correctly', correct: true },
                { label: 'To set the language of the page' },
                { label: 'To choose which font the browser uses' },
                { label: 'To compress the file before sending it' },
              ],
              skill: 'metadata',
            },
          ],
        },
        {
          slug: 'your-first-complete-page',
          title: 'Your first complete page',
          subtitle: 'Milestone: build it from nothing',
          summary:
            'No starter code, no copying. You will write a complete, valid HTML document from a blank editor — and it will be the first page of the website you finish this course with.',
          objectives: [
            'Write a valid HTML document from an empty file',
            'Choose sensible content for a real page',
            'Start the website you will build across the whole course',
          ],
          estimatedMinutes: 20,
          skill: 'document-structure',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Produce a complete, valid HTML document with no starter code',
              'Explain every line you wrote',
              'Create the first page of your capstone website',
            ]),
            prose(
              'This is the first milestone of the course. Everything you need has been covered — the skeleton, headings, paragraphs, links and nesting. What is new is that the editor starts empty.',
            ),
            callout(
              'tip',
              'How to approach a blank file',
              'Write the frame first and the content second. Doctype, html, head, body — then fill in. Almost every professional does exactly this, and most editors will expand a shortcut into the skeleton for you. Doing it by hand a few times is how it becomes automatic.',
            ),
            visual('document-tree', 'The shape you are aiming for, before you write a word of content.'),
            code(
              `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
  </head>
  <body>

  </body>
</html>`,
              'The frame, before any content — write this from memory, then fill it in',
            ),
            prose(
              'You chose a project type when you signed up. The page you build here becomes the homepage of that project, and every module from now on will add something to it. By the end of the course this file will have grown into a complete, professional, multi-page website — built by you, one piece at a time.',
            ),
            checklist('Your page must have', [
              'The doctype on the first line',
              '`<html>` with a `lang` attribute',
              'A head containing the charset meta tag, the viewport meta tag and a title',
              'A body containing exactly one `<h1>`',
              'At least two paragraphs of real content',
              'At least one link',
            ]),
            detail(
              'Why "real content" matters',
              'It is tempting to type "text here" and move on. Resist it. Writing plausible content forces you to make structural decisions — is this a heading or a paragraph? does this sentence belong in the same paragraph as the last one? — and those decisions are the actual skill. Lorem ipsum teaches you nothing, and every professional habit you build now saves you time later.',
            ),
            recap(
              [
                'You can now build a valid HTML document from an empty file.',
                'The frame comes first; the content fills it in.',
                'This page is the seed of your capstone website — you will return to it many times.',
              ],
              'Level 2 next: making the content itself meaningful.',
            ),
          ],
          exercises: [
            {
              slug: 'first-page-milestone',
              kind: 'challenge',
              title: 'Milestone: a complete web page',
              brief:
                'Starting from a blank editor, write a complete HTML document for a homepage. It needs the full skeleton, a single `<h1>`, at least two paragraphs, and at least one link. The subject is yours — write about the project you chose when you signed up.',
              starterCode: '',
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Riverside Cycle Hire — bikes and routes in the valley</title>
  </head>
  <body>
    <h1>Riverside Cycle Hire</h1>
    <p>
      We rent well-maintained bikes by the hour, the day or the week, from a
      workshop two minutes from the river path.
    </p>
    <p>
      Every hire includes a helmet, a lock and a printed route map. If something
      goes wrong out on the trail, ring us and we will come and get you.
    </p>
    <p><a href="contact.html">Book a bike or ask us a question</a></p>
  </body>
</html>`,
              hints: [
                'Start with the frame: <!DOCTYPE html>, then <html lang="en">, then <head> and <body>.',
                'The head needs three things: the charset meta tag, the viewport meta tag, and a title.',
                'In the body: one <h1>, then two or more <p> elements, then an <a href="…">…</a> somewhere.',
                'Check the indentation — children indented two spaces inside their parent — then press Check my work.',
              ],
              requirements: [
                doctype(),
                unique('html', 'There is one <html> element wrapping the document'),
                { kind: 'attribute_present', selector: 'html', attribute: 'lang', message: 'The html element has a lang attribute', hint: 'Write <html lang="en">.' },
                unique('head', 'There is exactly one <head>'),
                unique('body', 'There is exactly one <body>'),
                inside('meta[charset]', 'head', 'The charset meta tag is in the head'),
                attrValue('meta[name="viewport"]', 'name', 'viewport', 'A viewport meta tag is present'),
                unique('title', 'There is exactly one <title>'),
                notEmpty('title', 'The title is not empty'),
                unique('h1', 'There is exactly one <h1>'),
                inside('h1', 'body', 'The <h1> is inside the body'),
                count('p', 2, null, 'There are at least two paragraphs'),
                notEmpty('p', 'The paragraphs contain real text'),
                present('a[href]', 'There is at least one link with an href'),
                notEmpty('a', 'The link has visible text'),
                headingOrder(),
                uniqueIds(),
                legalNesting(),
              ],
              difficulty: 3,
              xp: 90,
              skill: 'document-structure',
            },
            {
              slug: 'first-page-mission',
              kind: 'project_mission',
              title: 'Capstone mission: create index.html',
              brief:
                'Save your page as the homepage of your capstone project. This file becomes `index.html` — the page a browser opens when someone visits your site with no filename. Keep the content you wrote; you will improve it many times as the course goes on.',
              starterCode: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Your site name — what you do</title>
  </head>
  <body>
    <h1>Your site name</h1>

    <!--
      Add at least two paragraphs of your own about this project,
      then a link to contact.html so visitors can reach you.
    -->
  </body>
</html>`,
              referenceSolution: `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Riverside Cycle Hire — bikes and routes in the valley</title>
  </head>
  <body>
    <h1>Riverside Cycle Hire</h1>
    <p>We rent well-maintained bikes by the hour, the day or the week.</p>
    <p>Every hire includes a helmet, a lock and a printed route map.</p>
    <p><a href="contact.html">Book a bike</a></p>
  </body>
</html>`,
              hints: [
                'Replace the placeholder sentences with your own — the checker requires real content, not the starter text.',
                'Keep the whole skeleton intact.',
                'Make the title specific to your project rather than generic.',
              ],
              requirements: [
                doctype(),
                unique('h1', 'One <h1> naming your site'),
                unique('title', 'A title describing this page'),
                count('p', 2, null, 'At least two paragraphs of your own content'),
                present('a[href]', 'At least one link'),
                headingOrder(),
                legalNesting(),
              ],
              difficulty: 2,
              xp: 60,
              skill: 'multi-page',
            },
          ],
          quiz: [
            {
              slug: 'q-index-html',
              prompt: 'Why is a site\'s homepage almost always called `index.html`?',
              explanation:
                'When a request arrives with no filename, web servers look for a default file, and `index.html` is that default nearly everywhere. It is a server convention, not an HTML rule.',
              options: [
                { label: 'Servers serve it by default when no filename is given', correct: true },
                { label: 'HTML requires the first page of a site to be called index' },
                { label: 'Browsers refuse to open a site without it' },
                { label: 'It makes the page load faster' },
              ],
              skill: 'multi-page',
            },
            {
              slug: 'q-one-h1',
              prompt: 'How many `<h1>` elements should a typical page have?',
              explanation:
                'One. The `<h1>` names what the whole page is about. Several competing `<h1>`s leave screen-reader users and search engines with no clear answer to "what is this page?".',
              options: [
                { label: 'Exactly one', correct: true },
                { label: 'One per section' },
                { label: 'As many as you like' },
                { label: 'None — h1 is for site names only' },
              ],
              skill: 'text-semantics',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'level-1-milestone',
    kind: 'milestone',
    title: 'Level 1 milestone: HTML Explorer',
    description:
      'Ten questions covering everything in Level 1. You need 75% to move on. If you do not reach it, the questions you missed become targeted practice — nothing is lost.',
    passScore: 0.75,
    xp: 150,
    questions: [
      {
        slug: 'a1-q1',
        prompt: 'What is sent from a web server to your browser when you visit a page?',
        explanation: 'Files, starting with an HTML text file that the browser then renders.',
        options: [
          { label: 'An HTML text file the browser renders', correct: true },
          { label: 'A rendered image of the page' },
          { label: 'A compiled program' },
          { label: 'A database record' },
        ],
        skill: 'document-structure',
      },
      {
        slug: 'a1-q2',
        prompt: 'Which line must come first in an HTML file?',
        explanation: 'The doctype precedes everything, including the html element.',
        options: [
          { label: '<!DOCTYPE html>', correct: true },
          { label: '<html lang="en">' },
          { label: '<meta charset="utf-8">' },
          { label: '<head>' },
        ],
        skill: 'document-structure',
      },
      {
        slug: 'a1-q3',
        prompt: 'Which is a void element?',
        explanation: '`<img>` wraps nothing, so it has no closing tag. The others all wrap content.',
        options: [
          { label: '<img>', correct: true },
          { label: '<p>' },
          { label: '<a>' },
          { label: '<h1>' },
        ],
        skill: 'syntax',
      },
      {
        slug: 'a1-q4',
        prompt: 'What is wrong with `<p>Open <em>daily</p></em>`?',
        explanation:
          'The elements overlap. `<em>` was opened last, so it must be closed first, before `</p>`.',
        options: [
          { label: 'The tags overlap instead of nesting', correct: true },
          { label: '<em> cannot be used inside a paragraph' },
          { label: 'The paragraph needs an attribute' },
          { label: 'Nothing — this is valid' },
        ],
        skill: 'syntax',
      },
      {
        slug: 'a1-q5',
        prompt: 'Which content belongs in `<head>`?',
        explanation:
          'The head holds information about the page. Headings, paragraphs and images are visible content and belong in the body.',
        options: [
          { label: 'The page title and character set', correct: true },
          { label: 'The main heading of the page' },
          { label: 'The site logo image' },
          { label: 'The footer' },
        ],
        skill: 'document-structure',
      },
      {
        slug: 'a1-q6',
        prompt: 'In `<a href="shop.html">Shop</a>`, what is `href`?',
        explanation: 'It is an attribute name; `shop.html` is its value.',
        options: [
          { label: 'An attribute', correct: true },
          { label: 'A tag' },
          { label: 'An element' },
          { label: 'The content' },
        ],
        skill: 'syntax',
      },
      {
        slug: 'a1-q7',
        prompt: 'What does `lang="en"` on the `<html>` element do?',
        explanation:
          'It declares the page\'s language, which screen readers use to choose pronunciation and browsers use to offer translation.',
        options: [
          { label: 'Declares the language of the page content', correct: true },
          { label: 'Translates the page into English' },
          { label: 'Sets the character encoding' },
          { label: 'Chooses which spell-checker the browser uses' },
        ],
        skill: 'document-structure',
      },
      {
        slug: 'a1-q8',
        prompt: 'Which statement about HTML comments is correct?',
        explanation:
          'Comments are hidden from the rendered page but are sent to the browser and visible in the page source.',
        options: [
          { label: 'They are hidden on the page but visible in the source', correct: true },
          { label: 'They are stripped out by the server' },
          { label: 'They can only appear in the head' },
          { label: 'They are displayed in grey on the page' },
        ],
        skill: 'syntax',
      },
      {
        slug: 'a1-q9',
        prompt: 'Why indent nested elements?',
        explanation:
          'Indentation makes the tree visible, so an unclosed or misplaced tag is obvious to the eye. Browsers ignore whitespace entirely.',
        options: [
          { label: 'To make the structure readable and mistakes visible', correct: true },
          { label: 'Because browsers require it' },
          { label: 'To make the page render faster' },
          { label: 'To create indentation on the finished page' },
        ],
        skill: 'maintainability',
      },
      {
        slug: 'a1-q10',
        prompt: 'What is the DOM?',
        explanation:
          'The Document Object Model is the browser\'s live tree of your document, built from your HTML when the page loads.',
        options: [
          { label: 'The browser\'s in-memory tree built from your HTML', correct: true },
          { label: 'A file format for saving web pages' },
          { label: 'A rule about which elements are allowed' },
          { label: 'The part of the browser that downloads files' },
        ],
        skill: 'syntax',
      },
    ],
  },
};
