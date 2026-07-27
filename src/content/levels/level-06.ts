import {
  annotated,
  attr,
  attrValue,
  callout,
  checklist,
  code,
  compare,
  count,
  demo,
  detail,
  headingOrder,
  inside,
  labelled,
  legalNesting,
  named,
  notEmpty,
  objectives,
  present,
  prose,
  recap,
  term,
  unique,
  uniqueIds,
  visual,
  type LevelSpec,
  recall,
} from '../types';

export const LEVEL_06: LevelSpec = {
  slug: 'data-and-forms',
  title: 'Data and Forms Builder',
  subtitle: 'Tables people can actually read, and forms people can actually complete',
  summary:
    'Tables and forms are where HTML becomes an interface. Both are easy to write badly and not much harder to write well — the difference is knowing which handful of attributes matter.',
  outcome:
    'You can build an accessible data table and a professional enquiry or booking form with real validation.',
  accent: 'rose',
  modules: [
    {
      slug: 'data-tables',
      title: 'Data tables',
      summary:
        'Rows, columns, headers and scope — plus the one thing tables must never be used for.',
      estimatedMinutes: 40,
      prerequisites: ['organising-a-project'],
      skills: [{ slug: 'tables', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'building-a-table',
          title: 'Building an accessible table',
          subtitle: 'caption, thead, th, scope — the four that do the work',
          summary:
            'A table without headers is a grid of numbers with no meaning. Four elements turn it into data.',
          objectives: [
            'Build a table with a caption and proper header cells',
            'Use scope so header cells apply to the right row or column',
            'Explain why tables must not be used for page layout',
          ],
          estimatedMinutes: 15,
          skill: 'tables',
          blocks: [
            objectives([
              'Build a data table with caption, thead, tbody and tfoot',
              'Apply scope="col" and scope="row" correctly',
              'Explain the difference between a data table and a layout table',
            ]),
            visual('table-structure', 'The parts of a data table, labelled.'),
            annotated(
              `<table>
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
</table>`,
              [
                {
                  line: '2',
                  text: '`<caption>` is the table\'s title. It must be the first child of `<table>`, and it is announced by screen readers before the data — so the user knows what they are about to enter.',
                },
                { line: '3-9', text: '`<thead>` groups the header row. Browsers repeat it when a long table is printed.' },
                {
                  line: '5',
                  text: '`<th scope="col">` means "this heading describes the whole column below me".',
                },
                { line: '10-19', text: '`<tbody>` holds the data rows.' },
                {
                  line: '13',
                  text: '`<th scope="row">` means "this heading describes the row beside me". The first cell of each row is a heading, not data — it names what the row is about.',
                },
                {
                  line: '20-24',
                  text: '`<tfoot>` holds summary or footnote rows. It may be written before or after `<tbody>`; browsers render it last either way.',
                },
                {
                  line: '22',
                  text: '`colspan="3"` makes this cell span all three columns.',
                },
              ],
            ),
            callout(
              'accessibility',
              'What `scope` actually does',
              'When a screen-reader user moves to a cell containing "£34", the screen reader announces "Road bike, Per day, £34" — it reads out the row and column headings that apply. It only knows which headings those are because `scope` told it. Without `scope`, the user hears "£34" and has to remember, cell by cell, where they are.',
            ),
            demo('The same numbers, with and without headers', 'Move through the cells and imagine hearing only the value.', [
              {
                label: 'With headers and scope',
                code: '<table>\n  <caption>Opening hours</caption>\n  <thead><tr><th scope="col">Day</th><th scope="col">Opens</th><th scope="col">Closes</th></tr></thead>\n  <tbody>\n    <tr><th scope="row">Tuesday</th><td>8am</td><td>6pm</td></tr>\n    <tr><th scope="row">Sunday</th><td>9am</td><td>4pm</td></tr>\n  </tbody>\n</table>',
                note: 'A cell announces as "Sunday, Closes, 4pm". Completely clear.',
              },
              {
                label: 'Without',
                code: '<table>\n  <tr><td>Day</td><td>Opens</td><td>Closes</td></tr>\n  <tr><td>Tuesday</td><td>8am</td><td>6pm</td></tr>\n  <tr><td>Sunday</td><td>9am</td><td>4pm</td></tr>\n</table>',
                note: 'The same cell announces as "4pm". Four pm on which day, opening or closing?',
              },
            ]),
            callout(
              'warning',
              'Never use a table for page layout',
              'Twenty years ago tables were the only way to build a column layout, and a great deal of old tutorial material still shows it. A layout table tells a screen reader "here is data with rows and columns" when there is no data at all, and the reading order it produces often makes no sense. Use a table only when the content is genuinely tabular — information with two axes.',
            ),
            detail(
              'colspan and rowspan',
              '`colspan="2"` makes a cell occupy two columns; `rowspan="2"` makes it occupy two rows. They are useful for grouping headers, but every span makes the table harder to follow non-visually. For anything more complex than a single spanned header row, consider whether two simpler tables would serve readers better — the answer is usually yes.',
            ),
            checklist('Every data table needs', [
              'A `<caption>` as the first child, saying what the table contains',
              '`<thead>` for the header row and `<tbody>` for the data',
              '`<th scope="col">` for column headings',
              '`<th scope="row">` where the first cell names the row',
              '`<tfoot>` for totals or notes, if there are any',
            ]),
            recap(
              [
                '`<caption>` names the table and comes first.',
                '`<th>` is a header cell; `<td>` is a data cell.',
                '`scope="col"` and `scope="row"` tell screen readers which headings apply.',
                'Tables are for data with two axes, never for layout.',
              ],
              'Next: forms.',
            ),
          ],
          exercises: [
            {
              slug: 'table-guided',
              kind: 'guided',
              title: 'Build an opening-hours table',
              brief:
                'Build a table with a caption "Opening hours", a header row of three column headings (Day, Opens, Closes), and two data rows for Tuesday and Sunday where the day is a row heading. Use `scope` throughout.',
              starterCode: `<table>

</table>`,
              referenceSolution: `<table>
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
</table>`,
              hints: [
                'The <caption> comes first, immediately inside <table>.',
                'The header row goes inside <thead>, with three <th scope="col"> cells.',
                'Each data row starts with <th scope="row"> for the day, then two <td> cells.',
              ],
              requirements: [
                present('table > caption', 'The table has a caption as its first child'),
                notEmpty('caption', 'The caption has text'),
                present('thead', 'There is a table head'),
                present('tbody', 'There is a table body'),
                count('th[scope="col"]', 3, 3, 'Three column headings with scope="col"'),
                count('th[scope="row"]', 2, 2, 'Two row headings with scope="row"'),
                count('tbody td', 4, 4, 'Four data cells'),
                legalNesting(),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'tables',
            },
            {
              slug: 'table-debug',
              kind: 'debug',
              title: 'A table with no meaning',
              brief:
                'This table uses `<td>` for everything, has no caption and no scope. Repair it so a screen-reader user can understand any single cell.',
              starterCode: `<table>
  <tr><td>Bike type</td><td>Per hour</td><td>Per day</td></tr>
  <tr><td>Hybrid</td><td>£6</td><td>£22</td></tr>
  <tr><td>Road bike</td><td>£9</td><td>£34</td></tr>
</table>`,
              referenceSolution: `<table>
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
</table>`,
              hints: [
                'Add a <caption> as the very first thing inside <table>.',
                'The first row is headings — change those cells to <th scope="col"> and wrap the row in <thead>.',
                'The first cell of each data row names the row, so it becomes <th scope="row">.',
              ],
              requirements: [
                present('caption', 'The table has a caption'),
                count('th[scope="col"]', 3, 3, 'The header row uses column headings'),
                count('th[scope="row"]', 2, 2, 'Each data row has a row heading'),
                present('thead', 'The header row is inside thead'),
                present('tbody', 'The data rows are inside tbody'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'tables',
            },
          ],
          quiz: [
            {
              slug: 'q-scope-col',
              prompt: 'What does `scope="col"` mean?',
              explanation: 'This header cell describes the column beneath it.',
              options: [
                { label: 'This heading describes the column below it', correct: true },
                { label: 'This cell should be displayed as a column' },
                { label: 'This column is sortable' },
                { label: 'This heading spans several columns' },
              ],
              skill: 'tables',
            },
            {
              slug: 'q-caption-position',
              prompt: 'Where must `<caption>` appear?',
              explanation: 'As the first child of `<table>`, before thead or any rows.',
              options: [
                { label: 'As the first child of <table>', correct: true },
                { label: 'Inside <thead>' },
                { label: 'After </table>' },
                { label: 'Anywhere inside the table' },
              ],
              skill: 'tables',
            },
            {
              slug: 'q-layout-tables',
              prompt: 'Why should you not use a table for page layout?',
              explanation:
                'It announces "data with rows and columns" to a screen reader when there is no data, and often produces a nonsensical reading order.',
              options: [
                { label: 'It announces data structure where there is none', correct: true },
                { label: 'Tables render more slowly than divs' },
                { label: 'Tables cannot be styled with CSS' },
                { label: 'Search engines ignore table content' },
              ],
              skill: 'tables',
            },
          ],
        },
      ],
    },
    {
      slug: 'form-foundations',
      title: 'Form foundations',
      summary:
        'The form element, labels, input types, and the grouping that makes a long form comprehensible.',
      estimatedMinutes: 55,
      prerequisites: ['data-tables'],
      skills: [{ slug: 'forms', masteryRequired: 0 }],
      lessons: [
        {
          slug: 'labels-and-inputs',
          title: 'Labels and input types',
          subtitle: 'The single most important pairing in HTML',
          summary:
            'An input without a label is unusable by a screen-reader user, and harder for everyone else. Joining them takes two attributes.',
          objectives: [
            'Join a label to its input with for and id',
            'Choose the right input type for the data',
            'Explain why placeholder text is not a label',
          ],
          estimatedMinutes: 16,
          skill: 'forms',
          blocks: [
            objectives([
              'Write a correctly associated label and input',
              'Choose input types that give mobile users the right keyboard',
              'Explain the problems with using placeholder as a label',
            ]),
            visual('form-anatomy', 'A label and its input, joined by matching for and id values.'),
            annotated(
              `<label for="email">Email address</label>
<input type="email" id="email" name="email" autocomplete="email" required>`,
              [
                { line: '1', text: '`for="email"` points at the input whose `id` is `email`.' },
                {
                  line: '2',
                  text: '`type="email"` gives phones an @-friendly keyboard and lets the browser check the format.',
                },
                { line: '2', text: '`id="email"` is what the label points at. It must be unique on the page.' },
                {
                  line: '2',
                  text: '`name="email"` is the key the value is sent under when the form is submitted. Without a `name`, the field is not sent at all.',
                },
                {
                  line: '2',
                  text: '`autocomplete="email"` lets the browser fill it from saved details — a large convenience, and a genuine accessibility benefit for people with motor or memory difficulties.',
                },
                { line: '2', text: '`required` tells the browser the field must be filled before submission.' },
              ],
            ),
            callout(
              'accessibility',
              'What a label gets you',
              'Three things at once. A screen reader announces "Email address, edit text" instead of just "edit text". Clicking the *word* puts the cursor in the box — which roughly doubles the target size, and matters enormously to anyone with a tremor or using a phone one-handed. And the browser can associate validation messages with the right field.',
            ),
            compare(
              'Label or placeholder?',
              {
                label: 'A real label',
                code: '<label for="phone">Phone number</label>\n<input type="tel" id="phone" name="phone" autocomplete="tel">',
                why: 'Always visible, clickable, and announced by screen readers.',
              },
              {
                label: 'Placeholder as a label',
                code: '<input type="tel" name="phone" placeholder="Phone number">',
                why: 'The text vanishes the moment typing starts, so anyone interrupted forgets what the field was. Placeholder contrast is usually too low to meet WCAG, and support in screen readers is inconsistent.',
              },
            ),
            callout(
              'mistake',
              'Placeholder is a hint, not a label',
              'Use it for an *example* of the expected format — `placeholder="07700 900123"` beside a label saying "Phone number". Never use it as the only description of a field.',
            ),
            prose('Choosing the right `type` is mostly about what keyboard a phone shows and what the browser can check for you.'),
            code(
              `type="text"      Anything short and free-form
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
type="hidden"    Not shown; carries a value the server needs`,
              'The input types you will actually use',
              'text',
            ),
            callout(
              'warning',
              '`type="number"` is the wrong choice more often than you think',
              'It is for quantities you might sensibly add up. Phone numbers, postcodes and card numbers are not quantities: `number` strips leading zeros, offers a spinner nobody wants, and rejects spaces and hyphens. Use `type="text"` with `inputmode="numeric"` instead — you get the numeric keypad without the damage.',
            ),
            term(
              'inputmode',
              'A hint about which on-screen keyboard to show, independent of the input type. `inputmode="numeric"` gives digits; `inputmode="decimal"` adds a decimal point.',
            ),
            term(
              'autocomplete',
              'Tells the browser what kind of information a field expects, so it can offer the user\'s saved details. The values are a fixed list: `name`, `email`, `tel`, `street-address`, `postal-code`, `cc-number`, `bday`, and so on.',
            ),
            detail(
              'Why autocomplete is an accessibility requirement',
              'WCAG 2.1 introduced a success criterion called Identify Input Purpose, which requires common personal-data fields to declare their purpose programmatically. `autocomplete` is how you meet it. For someone with a cognitive disability, a motor impairment, or simply a very long email address, autofill is the difference between a form that takes ten seconds and one that takes two minutes.',
            ),
            demo('Three ways to label a field', 'Two of these work. One only looks like it does.', [
              {
                label: 'Label with for',
                code: '<label for="email">Email address</label>\n<input type="email" id="email" name="email" autocomplete="email">',
                note: 'The usual form. Announced as "Email address, edit text", and clicking the words focuses the field.',
              },
              {
                label: 'Label wrapping the input',
                code: '<label>Email address\n  <input type="email" name="email" autocomplete="email">\n</label>',
                note: 'Also correct, and needs no id at all. Useful when you do not control the ids on the page.',
              },
              {
                label: 'Placeholder only',
                code: '<input type="email" name="email" placeholder="Email address">',
                note: 'No accessible name at all, and the hint vanishes the moment typing starts — removing the only clue exactly when it is needed.',
              },
            ]),
            recap(
              [
                'Every input needs a `<label for="…">` matching its `id`.',
                '`name` is what the value is submitted under — without it the field is not sent.',
                'Placeholder text is a hint, never a label.',
                'Choose `type` for the keyboard and the checking it brings; use `inputmode` where `number` would hurt.',
                '`autocomplete` is a real accessibility feature, not just a convenience.',
              ],
              'Next: grouping, selects and buttons.',
            ),
          ],
          exercises: [
            {
              slug: 'labels-guided',
              kind: 'guided',
              title: 'Label three inputs',
              brief:
                'Each input below has no label. Add a correctly associated `<label>` for each, and give each input a `name` and a suitable `autocomplete` value.',
              starterCode: `<form>
  <input type="text" id="fullname">
  <input type="email" id="email">
  <input type="tel" id="phone">
  <button type="submit">Send</button>
</form>`,
              referenceSolution: `<form>
  <label for="fullname">Full name</label>
  <input type="text" id="fullname" name="fullname" autocomplete="name">

  <label for="email">Email address</label>
  <input type="email" id="email" name="email" autocomplete="email">

  <label for="phone">Phone number</label>
  <input type="tel" id="phone" name="phone" autocomplete="tel">

  <button type="submit">Send</button>
</form>`,
              hints: [
                'Each label needs for="…" matching the id of its input.',
                'Add name="…" to each input, usually the same word as the id.',
                'The autocomplete values here are name, email and tel.',
              ],
              requirements: [
                count('label[for]', 3, 3, 'Three labels, each with a for attribute'),
                labelled('input', 'Every input is labelled'),
                attr('input', 'name', 'Every input has a name so its value is submitted'),
                attr('input', 'autocomplete', 'Every input declares its autocomplete purpose'),
                uniqueIds(),
              ],
              difficulty: 2,
              xp: 45,
              skill: 'forms',
            },
            {
              slug: 'input-types-debug',
              kind: 'debug',
              title: 'Four wrong input types',
              brief:
                'Each field uses a type that causes a real problem. Fix them: the email field should validate, the phone should not be a number, the postcode should not strip its formatting, and the password should be hidden.',
              starterCode: `<form>
  <label for="email">Email address</label>
  <input type="text" id="email" name="email">

  <label for="phone">Phone number</label>
  <input type="number" id="phone" name="phone">

  <label for="postcode">Postcode</label>
  <input type="number" id="postcode" name="postcode">

  <label for="password">Password</label>
  <input type="text" id="password" name="password">
</form>`,
              referenceSolution: `<form>
  <label for="email">Email address</label>
  <input type="email" id="email" name="email" autocomplete="email">

  <label for="phone">Phone number</label>
  <input type="tel" id="phone" name="phone" inputmode="tel" autocomplete="tel">

  <label for="postcode">Postcode</label>
  <input type="text" id="postcode" name="postcode" autocomplete="postal-code">

  <label for="password">Password</label>
  <input type="password" id="password" name="password" autocomplete="current-password">
</form>`,
              hints: [
                'The email field should be type="email" so the browser checks for an @.',
                'Phone numbers are not quantities — use type="tel".',
                'A postcode contains letters and a space, so type="text" is correct.',
                'A password field must be type="password".',
              ],
              requirements: [
                attrValue('input#email', 'type', 'email', 'The email field uses type="email"'),
                attrValue('input#phone', 'type', 'tel', 'The phone field uses type="tel"'),
                attrValue('input#postcode', 'type', 'text', 'The postcode field uses type="text"'),
                attrValue('input#password', 'type', 'password', 'The password field is hidden as it is typed'),
                labelled('input', 'All fields remain labelled'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'forms',
            },
          ],
          quiz: [
            {
              slug: 'q-label-for',
              prompt: 'What joins a `<label>` to its input?',
              explanation: 'The label\'s `for` attribute must match the input\'s `id` exactly.',
              options: [
                { label: 'The label\'s for matches the input\'s id', correct: true },
                { label: 'They must be next to each other in the HTML' },
                { label: 'The label\'s for matches the input\'s name' },
                { label: 'The input\'s placeholder matches the label text' },
              ],
              skill: 'forms',
            },
            {
              slug: 'q-placeholder',
              prompt: 'Why should placeholder text not be used as a label?',
              explanation:
                'It disappears as soon as the user types, its contrast usually fails WCAG, and screen-reader support is inconsistent.',
              options: [
                { label: 'It vanishes on typing and has poor contrast and support', correct: true },
                { label: 'Placeholders are not valid HTML' },
                { label: 'It prevents the field being submitted' },
                { label: 'It only works on text inputs' },
              ],
              skill: 'accessibility',
            },
            {
              slug: 'q-number-type',
              prompt: 'Which field should NOT use `type="number"`?',
              explanation:
                '`number` is for quantities. A phone number is not a quantity — it can contain spaces and leading zeros, both of which `number` damages.',
              options: [
                { label: 'A phone number', correct: true },
                { label: 'A quantity of bikes to hire' },
                { label: 'An age in years' },
                { label: 'A number of nights' },
              ],
              skill: 'forms',
            },
            {
              slug: 'q-name-attribute',
              prompt: 'What happens to an input with no `name` attribute?',
              explanation: 'Its value is not submitted with the form at all.',
              options: [
                { label: 'Its value is not submitted', correct: true },
                { label: 'It cannot be labelled' },
                { label: 'It fails validation' },
                { label: 'Nothing — name is optional' },
              ],
              skill: 'forms',
            },
          ],
        },
        {
          slug: 'grouping-and-controls',
          title: 'Grouping, selects, checkboxes and buttons',
          subtitle: 'Making a long form comprehensible',
          summary:
            'Fieldsets, legends, radio groups, select menus and the button types that behave differently.',
          objectives: [
            'Group related controls with fieldset and legend',
            'Build correct radio and checkbox groups',
            'Use select, optgroup and the three button types',
          ],
          estimatedMinutes: 15,
          skill: 'forms',
          blocks: [
            objectives([
              'Group radio buttons in a fieldset with a legend',
              'Build a select menu with grouped options',
              'Choose between button types correctly',
            ]),
            prose(
              'A radio group has a problem a single input does not: each radio has its own label, but the *question* has no label at all. `<fieldset>` and `<legend>` solve exactly that.',
            ),
            annotated(
              `<fieldset>
  <legend>Which bike would you like?</legend>

  <input type="radio" id="hybrid" name="biketype" value="hybrid" checked>
  <label for="hybrid">Hybrid</label>

  <input type="radio" id="road" name="biketype" value="road">
  <label for="road">Road bike</label>
</fieldset>`,
              [
                { line: '1', text: '`<fieldset>` groups related controls.' },
                {
                  line: '2',
                  text: '`<legend>` is the group\'s label and must be the first child. A screen reader announces it before each option, so the user hears "Which bike would you like? Hybrid, radio button, 1 of 2".',
                },
                {
                  line: '4',
                  text: 'All the radios share the same `name`. That is what makes them one group where only one can be chosen — not the fieldset.',
                },
                {
                  line: '4',
                  text: '`value` is what gets submitted. Radio and checkbox labels are for humans; `value` is for the server.',
                },
                { line: '4', text: '`checked` sets the default. Choosing a sensible default saves everyone a click.' },
              ],
            ),
            callout(
              'mistake',
              'Radios grouped by fieldset instead of by name',
              'Two radio buttons with *different* `name` values can both be selected at once, however they are wrapped. The shared `name` is what creates the group; the fieldset only labels it.',
            ),
            compare(
              'Radio or checkbox?',
              {
                label: 'Radio — choose one',
                code: '<input type="radio" name="size" value="s" id="s">\n<label for="s">Small</label>\n<input type="radio" name="size" value="m" id="m">\n<label for="m">Medium</label>',
                why: 'Same name, so selecting one deselects the other.',
              },
              {
                label: 'Checkbox — choose any number',
                code: '<input type="checkbox" name="extras" value="helmet" id="helmet">\n<label for="helmet">Helmet</label>\n<input type="checkbox" name="extras" value="lock" id="lock">\n<label for="lock">Lock</label>',
                why: 'Also a shared name, but checkboxes are independent — any combination can be ticked.',
              },
            ),
            code(
              `<label for="route">Which route?</label>
<select id="route" name="route">
  <optgroup label="Easy">
    <option value="harbour">Harbour loop — 6 miles</option>
    <option value="mill">Mill and back — 11 miles</option>
  </optgroup>
  <optgroup label="Harder">
    <option value="valley">The full valley — 24 miles</option>
  </optgroup>
</select>`,
              'A select menu with grouped options',
            ),
            callout(
              'tip',
              'When not to use a select',
              'Under about five options, radio buttons are faster and clearer — everything is visible at once with no interaction needed. A select earns its place when the list is long, or when it needs to be searchable. Never use one for a yes/no question.',
            ),
            prose('There are three button types, and the difference matters.'),
            code(
              `<button type="submit">Send enquiry</button>   Submits the form. The default.
<button type="reset">Clear form</button>      Wipes every field. Almost never wanted.
<button type="button">Show more</button>      Does nothing without JavaScript.`,
              'The three button types',
              'text',
            ),
            callout(
              'warning',
              'Always write the type',
              'A `<button>` inside a form with no `type` defaults to `submit`. A "Show password" button written without `type="button"` will submit the form when clicked — a genuinely common and confusing bug.',
            ),
            term(
              '<textarea>',
              'A multi-line text field. Unlike `<input>` it has a closing tag, and any content between the tags becomes its starting value — so keep it empty unless you want a default.',
            ),
            detail(
              'Button versus link',
              'A link goes somewhere. A button does something. If clicking it changes the address bar, it should be an `<a>`; if it submits, toggles or opens something on the current page, it should be a `<button>`. This matters because keyboard behaviour differs — a link activates on Enter, a button on Enter *and* Space — and because screen readers announce them differently, setting a different expectation.',
            ),
            demo('A question, and a list of unrelated options', 'The difference is one wrapper.', [
              {
                label: 'Grouped',
                code: '<fieldset>\n  <legend>How should we contact you?</legend>\n  <input type="radio" id="by-email" name="contact" value="email">\n  <label for="by-email">Email</label>\n  <input type="radio" id="by-phone" name="contact" value="phone">\n  <label for="by-phone">Phone</label>\n</fieldset>',
                note: 'The legend names the group, so the options are announced together with the question they answer.',
              },
              {
                label: 'Ungrouped',
                code: '<p>How should we contact you?</p>\n<input type="radio" id="by-email" name="contact" value="email">\n<label for="by-email">Email</label>\n<input type="radio" id="by-phone" name="contact" value="phone">\n<label for="by-phone">Phone</label>',
                note: 'The question is just a paragraph floating above. A user who jumps straight to the controls hears "Email, radio button" with no idea what is being asked.',
              },
            ]),
            recap(
              [
                '`<fieldset>` groups controls; `<legend>` labels the group and comes first.',
                'A shared `name` creates a radio group, not the fieldset.',
                '`value` is submitted; the label is for the human.',
                'Always write `type` on a button, or it will submit the form.',
                'Links navigate; buttons act.',
              ],
              'Next: validation attributes and the milestone form.',
            ),
          ],
          exercises: [
            {
              slug: 'fieldset-guided',
              kind: 'guided',
              title: 'Build a radio group properly',
              brief:
                'Wrap these radio buttons in a `<fieldset>` with the legend "Which bike would you like?", give them all the same `name` of `biketype`, add a `value` to each, and label each one.',
              starterCode: `<form>
  <input type="radio" id="hybrid">
  Hybrid
  <input type="radio" id="road">
  Road bike
  <button type="submit">Send</button>
</form>`,
              referenceSolution: `<form>
  <fieldset>
    <legend>Which bike would you like?</legend>

    <input type="radio" id="hybrid" name="biketype" value="hybrid" checked>
    <label for="hybrid">Hybrid</label>

    <input type="radio" id="road" name="biketype" value="road">
    <label for="road">Road bike</label>
  </fieldset>
  <button type="submit">Send</button>
</form>`,
              hints: [
                'The <legend> must be the first child of the <fieldset>.',
                'Both radios need name="biketype" — that is what makes them one group.',
                'Wrap the visible words in <label for="…"> matching each id.',
              ],
              requirements: [
                present('fieldset > legend', 'The fieldset has a legend as its first child'),
                notEmpty('legend', 'The legend has text'),
                count('input[type="radio"][name="biketype"]', 2, 2, 'Both radios share the name biketype'),
                attr('input[type="radio"]', 'value', 'Each radio has a value to submit'),
                count('label[for]', 2, 2, 'Each radio has an associated label'),
                labelled('input', 'Every control is labelled'),
              ],
              difficulty: 3,
              xp: 50,
              skill: 'forms',
            },
            {
              slug: 'controls-challenge',
              kind: 'challenge',
              title: 'A booking form section',
              brief:
                'Build a form section containing: a `<select>` with two `<optgroup>` groups of routes, a fieldset of at least two checkboxes for optional extras, a `<textarea>` for notes, and a submit button with an explicit type. Label everything.',
              starterCode: '',
              referenceSolution: `<form>
  <label for="route">Which route?</label>
  <select id="route" name="route">
    <optgroup label="Easy">
      <option value="harbour">Harbour loop — 6 miles</option>
      <option value="mill">Mill and back — 11 miles</option>
    </optgroup>
    <optgroup label="Harder">
      <option value="valley">The full valley — 24 miles</option>
    </optgroup>
  </select>

  <fieldset>
    <legend>Optional extras</legend>
    <input type="checkbox" id="childseat" name="extras" value="childseat">
    <label for="childseat">Child seat</label>
    <input type="checkbox" id="pannier" name="extras" value="pannier">
    <label for="pannier">Pannier bags</label>
  </fieldset>

  <label for="notes">Anything we should know?</label>
  <textarea id="notes" name="notes" rows="4"></textarea>

  <button type="submit">Request a booking</button>
</form>`,
              hints: [
                'The select needs a label, and each optgroup needs a label attribute.',
                'Checkboxes go in a fieldset with a legend describing the group.',
                'The textarea has a closing tag — leave it empty so the field starts blank.',
                'Write type="submit" on the button explicitly.',
              ],
              requirements: [
                present('select', 'There is a select menu'),
                count('optgroup', 2, null, 'The options are grouped into at least two optgroups'),
                attr('optgroup', 'label', 'Each optgroup has a label'),
                present('fieldset > legend', 'The checkboxes are in a labelled fieldset'),
                count('input[type="checkbox"]', 2, null, 'There are at least two checkboxes'),
                present('textarea', 'There is a textarea'),
                attrValue('button', 'type', 'submit', 'The button has an explicit type'),
                labelled('input, select, textarea', 'Every control is labelled'),
                uniqueIds(),
              ],
              difficulty: 4,
              xp: 65,
              skill: 'forms',
            },
          ],
          quiz: [
            {
              slug: 'q-radio-group',
              prompt: 'What makes two radio buttons part of the same group?',
              explanation:
                'A shared `name` attribute. The fieldset labels the group but does not create it.',
              options: [
                { label: 'They share the same name attribute', correct: true },
                { label: 'They are inside the same fieldset' },
                { label: 'They share the same id' },
                { label: 'They are adjacent in the HTML' },
              ],
              skill: 'forms',
            },
            {
              slug: 'q-button-type',
              prompt: 'A `<button>` inside a form with no `type` attribute — what does it do when clicked?',
              explanation: 'It submits the form, because `submit` is the default type.',
              options: [
                { label: 'Submits the form', correct: true },
                { label: 'Nothing' },
                { label: 'Resets the form' },
                { label: 'Depends on the browser' },
              ],
              skill: 'forms',
            },
            {
              slug: 'q-legend-position',
              prompt: 'Where must `<legend>` appear?',
              explanation: 'As the first child of its `<fieldset>`.',
              options: [
                { label: 'As the first child of the fieldset', correct: true },
                { label: 'Immediately before the fieldset' },
                { label: 'Anywhere inside the fieldset' },
                { label: 'As the last child of the fieldset' },
              ],
              skill: 'forms',
            },
          ],
        },
        {
          slug: 'validation-and-form-milestone',
          title: 'Validation, form security, and the milestone form',
          subtitle: 'What the browser can check, and what it absolutely cannot',
          summary:
            'Native validation attributes cost nothing and catch most mistakes. They are also no defence whatsoever against an attacker.',
          objectives: [
            'Use required, pattern, min, max, step, minlength and maxlength',
            'Explain the difference between GET and POST',
            'Explain why client-side validation is not security',
          ],
          estimatedMinutes: 24,
          skill: 'forms',
          masteryThreshold: 0.8,
          blocks: [
            objectives([
              'Apply native validation attributes correctly',
              'Choose between GET and POST for a form',
              'Explain why every input must be re-validated on the server',
            ]),
            code(
              `required                  Must be filled in
minlength="8"             At least 8 characters
maxlength="200"           At most 200 characters
min="1"  max="10"         Numeric or date range
step="0.5"                Allowed increments
pattern="[A-Z]{2}[0-9]+"  Must match this regular expression
multiple                  Accept several values (email or file)
accept="image/*,.pdf"     Which file types a file input offers`,
              'The native validation attributes',
              'text',
            ),
            annotated(
              `<label for="people">How many people?</label>
<input type="number" id="people" name="people"
       min="1" max="8" step="1" value="2" required>

<label for="postcode">Postcode</label>
<input type="text" id="postcode" name="postcode"
       inputmode="text" autocomplete="postal-code"
       pattern="[A-Za-z]{1,2}[0-9][A-Za-z0-9]? ?[0-9][A-Za-z]{2}"
       required
       aria-describedby="postcode-hint">
<p id="postcode-hint">For example: HX2 4PL</p>`,
              [
                { line: '3', text: '`min` and `max` bound the value; `step="1"` allows whole numbers only.' },
                { line: '3', text: '`value="2"` sets a sensible starting point.' },
                {
                  line: '8',
                  text: '`pattern` takes a regular expression the value must match. The whole value must match, so no anchors are needed.',
                },
                {
                  line: '10',
                  text: '`aria-describedby` links the field to its hint, so a screen reader reads the format example *after* the label. Without it the hint is just a paragraph nobody hears at the right moment.',
                },
              ],
            ),
            callout(
              'accessibility',
              'A pattern always needs a visible hint',
              'If a value is rejected for not matching a pattern, the browser\'s default message is unhelpfully vague. Say what the format is, in plain words, near the field — and connect it with `aria-describedby`. A validation rule the user cannot see is a trap.',
            ),
            term(
              'method',
              'How the form is sent. `GET` puts the values in the URL; `POST` puts them in the request body.',
            ),
            compare(
              'GET or POST?',
              {
                label: 'GET — for searches and filters',
                code: '<form action="/search" method="get">\n  <label for="q">Search routes</label>\n  <input type="search" id="q" name="q">\n  <button type="submit">Search</button>\n</form>',
                why: 'The values appear in the URL, so results can be bookmarked and shared. Correct when the form only reads data.',
              },
              {
                label: 'POST — for anything that changes something',
                code: '<form action="/enquiry" method="post">\n  <label for="message">Your message</label>\n  <textarea id="message" name="message"></textarea>\n  <button type="submit">Send</button>\n</form>',
                why: 'Values are not in the URL, not in browser history, and not in server logs. Correct for anything private or anything that creates a record.',
              },
            ),
            callout(
              'warning',
              'Client-side validation is a convenience, never a security control',
              'Every attribute on this page can be removed in two clicks with browser developer tools, and a request can be sent to your server without ever loading your page. Native validation exists to help honest users get it right first time. The server must re-check every single value as though nothing had been checked at all. HTML cannot secure anything — this is the most important sentence in this level.',
            ),
            detail(
              'What else does form security involve?',
              'Beyond server-side validation: serve the form over HTTPS so values are not readable in transit; use a CSRF token so another site cannot submit the form on a signed-in user\'s behalf; rate-limit submissions; and never put secrets in `<input type="hidden">`, which is visible to anyone who views the source. Those are all server-side concerns, and HTML\'s honest role is to make the field purposes clear enough that the server knows what it is validating.',
            ),
            checklist('The milestone form needs', [
              '`<form>` with an `action` and `method="post"`',
              'Every control labelled with `<label for="…">`',
              'A `<fieldset>` with a `<legend>` around at least one group',
              'At least four different input types',
              '`required` on the fields that genuinely are',
              '`autocomplete` on every personal-detail field',
              'A hint connected with `aria-describedby`',
              'A `<textarea>` for a message',
              'A submit button with an explicit `type`',
            ]),
            demo('Client-side validation, and what it is worth', 'The same field, three ways of asking.', [
              {
                label: 'Typed and required',
                code: '<label for="email">Email address</label>\n<input type="email" id="email" name="email" autocomplete="email" required>',
                note: 'The right keyboard on a phone, browser-level checking, autofill, and a real label. All of it helps honest users and stops nobody else.',
              },
              {
                label: 'Untyped',
                code: '<label for="email">Email address</label>\n<input type="text" id="email" name="email">',
                note: 'Works, but gives up the mobile keyboard, the built-in check and the autofill hint for no gain.',
              },
              {
                label: 'Pattern with no hint',
                code: '<label for="postcode">Postcode</label>\n<input type="text" id="postcode" name="postcode" pattern="[A-Z]{1,2}[0-9]{1,2} ?[0-9][A-Z]{2}" required>',
                note: 'Rejects valid-looking input with no explanation of the rule. A pattern always needs a visible description of what it wants.',
              },
            ]),
            recall(
              'Before you build the form, reach back four levels. From memory, and without scrolling: what does each of these give you, and what breaks without it?',
              [
                'Level 1 — the document skeleton: doctype, `<html lang>`, `<head>` with a charset and title, `<body>`. Without the charset, accented characters and currency symbols break.',
                'Level 2 — headings describe structure, not size. A skipped level leaves a gap in the outline a screen-reader user navigates by.',
                'Level 3 — link text has to make sense read on its own, because links are commonly listed with the surrounding sentence removed.',
                'Level 5 — landmarks let assistive technology jump to a region. Exactly one `<main>`, holding what is unique to this page.',
              ],
              'Four levels back',
            ),
            recap(
              [
                'Native validation attributes catch most honest mistakes for free.',
                '`pattern` always needs a visible, connected hint.',
                'GET for reading, POST for anything that changes or is private.',
                'The server must revalidate everything. HTML secures nothing.',
              ],
              'Level 7 next: native interactive elements.',
            ),
          ],
          exercises: [
            {
              slug: 'validation-guided',
              kind: 'guided',
              title: 'Add validation to three fields',
              brief:
                'Add validation: the name must be required and at least two characters; the party size must be a whole number between 1 and 8; the postcode must be required and connected to its hint with `aria-describedby`.',
              starterCode: `<form action="/booking" method="post">
  <label for="name">Full name</label>
  <input type="text" id="name" name="name" autocomplete="name">

  <label for="people">How many people?</label>
  <input type="number" id="people" name="people">

  <label for="postcode">Postcode</label>
  <input type="text" id="postcode" name="postcode" autocomplete="postal-code">
  <p id="postcode-hint">For example: HX2 4PL</p>

  <button type="submit">Request a booking</button>
</form>`,
              referenceSolution: `<form action="/booking" method="post">
  <label for="name">Full name</label>
  <input type="text" id="name" name="name" autocomplete="name" required minlength="2">

  <label for="people">How many people?</label>
  <input type="number" id="people" name="people" min="1" max="8" step="1" value="2" required>

  <label for="postcode">Postcode</label>
  <input type="text" id="postcode" name="postcode" autocomplete="postal-code"
         required aria-describedby="postcode-hint">
  <p id="postcode-hint">For example: HX2 4PL</p>

  <button type="submit">Request a booking</button>
</form>`,
              hints: [
                'required is a boolean attribute — write the word on its own.',
                'The number field needs min="1" max="8" step="1".',
                'aria-describedby="postcode-hint" points at the id of the hint paragraph.',
              ],
              requirements: [
                attr('input#name', 'required', 'The name field is required'),
                attr('input#name', 'minlength', 'The name has a minimum length'),
                attrValue('input#people', 'min', '1', 'The party size has a minimum of 1'),
                attrValue('input#people', 'max', '8', 'The party size has a maximum of 8'),
                attrValue('input#postcode', 'aria-describedby', 'postcode-hint', 'The postcode is connected to its hint'),
                labelled('input', 'Every field is still labelled'),
              ],
              difficulty: 3,
              xp: 55,
              skill: 'forms',
            },
            {
              slug: 'form-milestone',
              kind: 'challenge',
              title: 'Milestone: a professional enquiry form',
              brief:
                'Build a complete, accessible enquiry or booking form meeting every item on the checklist above. Content is yours; the structure and accessibility are what is assessed.',
              starterCode: '',
              referenceSolution: `<h1>Book a bike</h1>

<form action="/booking" method="post">
  <label for="name">Full name</label>
  <input type="text" id="name" name="name" autocomplete="name" required minlength="2">

  <label for="email">Email address</label>
  <input type="email" id="email" name="email" autocomplete="email" required
         aria-describedby="email-hint">
  <p id="email-hint">We will only use this to confirm your booking.</p>

  <label for="phone">Phone number</label>
  <input type="tel" id="phone" name="phone" autocomplete="tel" inputmode="tel">

  <label for="date">Preferred date</label>
  <input type="date" id="date" name="date" min="2026-01-01" required>

  <label for="people">How many bikes?</label>
  <input type="number" id="people" name="people" min="1" max="8" step="1" value="2" required>

  <fieldset>
    <legend>Which bike would you like?</legend>
    <input type="radio" id="hybrid" name="biketype" value="hybrid" checked>
    <label for="hybrid">Hybrid</label>
    <input type="radio" id="road" name="biketype" value="road">
    <label for="road">Road bike</label>
  </fieldset>

  <fieldset>
    <legend>Optional extras</legend>
    <input type="checkbox" id="childseat" name="extras" value="childseat">
    <label for="childseat">Child seat</label>
    <input type="checkbox" id="pannier" name="extras" value="pannier">
    <label for="pannier">Pannier bags</label>
  </fieldset>

  <label for="notes">Anything we should know?</label>
  <textarea id="notes" name="notes" rows="4" maxlength="500"></textarea>

  <button type="submit">Request a booking</button>
</form>`,
              hints: [
                'Start with <form action="…" method="post">.',
                'Add fields one at a time, each with its own <label for="…">.',
                'Use at least four different input types: text, email, tel, date, number are all available.',
                'Wrap the radios and the checkboxes in fieldsets with legends.',
                'Connect at least one hint paragraph with aria-describedby.',
              ],
              requirements: [
                present('form[action]', 'The form has an action'),
                attrValue('form', 'method', 'post', 'The form uses POST'),
                labelled('input, select, textarea', 'Every control has a label'),
                count('fieldset > legend', 1, null, 'At least one group is wrapped in a fieldset with a legend'),
                count('input[type="email"]', 1, null, 'There is an email field'),
                count('input[required]', 2, null, 'At least two fields are required'),
                attr(
                  'input[type="text"], input[type="email"], input[type="tel"]',
                  'autocomplete',
                  'Personal-detail fields declare their autocomplete purpose',
                ),
                present('[aria-describedby]', 'At least one field is connected to a hint'),
                present('textarea', 'There is a textarea for a message'),
                attrValue('button', 'type', 'submit', 'The submit button has an explicit type'),
                uniqueIds(),
                legalNesting(),
                named('button', 'The button has visible text'),
              ],
              difficulty: 5,
              xp: 160,
              skill: 'forms',
            },
            {
              slug: 'form-mission',
              kind: 'project_mission',
              title: 'Capstone mission: build contact.html',
              brief:
                'Build the contact page your navigation has been linking to since Level 3. It needs the full page structure — header, nav, main, footer — plus an accessible form suited to your project.',
              starterCode: `<main id="main">
  <h1>Contact us</h1>
  <p>Introduce the form in a sentence.</p>

  <form action="/contact" method="post">
    <!-- Build your form here -->
  </form>
</main>`,
              referenceSolution: `<main id="main">
  <h1>Contact us</h1>
  <p>Send us a message and we will reply the same working day.</p>

  <form action="/contact" method="post">
    <label for="name">Your name</label>
    <input type="text" id="name" name="name" autocomplete="name" required>

    <label for="email">Email address</label>
    <input type="email" id="email" name="email" autocomplete="email" required
           aria-describedby="email-hint">
    <p id="email-hint">We will only use this to reply to you.</p>

    <fieldset>
      <legend>What is your enquiry about?</legend>
      <input type="radio" id="booking" name="topic" value="booking" checked>
      <label for="booking">A booking</label>
      <input type="radio" id="other" name="topic" value="other">
      <label for="other">Something else</label>
    </fieldset>

    <label for="message">Your message</label>
    <textarea id="message" name="message" rows="5" required maxlength="1000"></textarea>

    <button type="submit">Send message</button>
  </form>
</main>`,
              hints: [
                'Keep the page structure you built in Level 5 — header, nav, main, footer.',
                'The form needs at least a name, an email and a message.',
                'Every control needs a label; the radio group needs a fieldset and legend.',
              ],
              requirements: [
                unique('main', 'The page has a main element'),
                inside('h1', 'main', 'The h1 is inside main'),
                present('form[action][method]', 'The form has an action and a method'),
                labelled('input, select, textarea', 'Every control is labelled'),
                present('textarea', 'There is a message field'),
                count('input[required], textarea[required]', 1, null, 'At least one field is required'),
                attrValue('button', 'type', 'submit', 'The submit button has an explicit type'),
                headingOrder(),
                uniqueIds(),
              ],
              difficulty: 4,
              xp: 110,
              skill: 'forms',
            },
          ],
          quiz: [
            {
              slug: 'q-client-validation',
              prompt: 'Is `required` a security feature?',
              explanation:
                'No. It can be removed with developer tools, and a request can be sent without loading your page at all. The server must revalidate everything.',
              options: [
                { label: 'No — the server must revalidate every value', correct: true },
                { label: 'Yes, browsers enforce it before submission' },
                { label: 'Yes, when combined with pattern' },
                { label: 'Only over HTTPS' },
              ],
              skill: 'security',
            },
            {
              slug: 'q-get-vs-post',
              prompt: 'Which method should a login form use?',
              explanation:
                'POST. GET would put the password in the URL, browser history and server logs.',
              options: [
                { label: 'POST', correct: true },
                { label: 'GET' },
                { label: 'Either works equally well' },
                { label: 'PUT' },
              ],
              skill: 'security',
            },
            {
              slug: 'q-aria-describedby',
              prompt: 'What does `aria-describedby` on an input do?',
              explanation:
                'It connects the field to descriptive text elsewhere on the page, so a screen reader reads the hint after the label.',
              options: [
                { label: 'Connects the field to a hint that screen readers announce', correct: true },
                { label: 'Replaces the field\'s label' },
                { label: 'Sets the validation error message' },
                { label: 'Adds a tooltip on hover' },
              ],
              skill: 'aria',
            },
          ],
        },
      ],
    },
  ],
  assessment: {
    slug: 'level-6-milestone',
    kind: 'milestone',
    title: 'Level 6 milestone: Data and Forms Builder',
    description: 'Ten questions on tables, forms, validation and form security. Pass mark 75%.',
    passScore: 0.75,
    xp: 200,
    questions: [
      {
        slug: 'a6-q1',
        prompt: 'Which element gives a table its title?',
        explanation: '`<caption>`, as the first child of `<table>`.',
        options: [
          { label: '<caption>', correct: true },
          { label: '<thead>' },
          { label: '<legend>' },
          { label: '<summary>' },
        ],
        skill: 'tables',
      },
      {
        slug: 'a6-q2',
        prompt: 'A cell contains "£34". A screen reader announces "Road bike, Per day, £34". What made that possible?',
        explanation: 'Header cells with `scope`, telling the screen reader which headings apply to that cell.',
        options: [
          { label: '<th> cells with scope attributes', correct: true },
          { label: 'The table caption' },
          { label: 'A title attribute on the cell' },
          { label: 'colspan on the header row' },
        ],
        skill: 'tables',
      },
      {
        slug: 'a6-q3',
        prompt: 'What connects a label to its input?',
        explanation: 'The label\'s `for` value matches the input\'s `id`.',
        options: [
          { label: 'for matching id', correct: true },
          { label: 'for matching name' },
          { label: 'Being adjacent in the source' },
          { label: 'A shared class' },
        ],
        skill: 'forms',
      },
      {
        slug: 'a6-q4',
        prompt: 'Which attribute makes two radio buttons mutually exclusive?',
        explanation:
          'A shared `name` attribute. The fieldset labels the group for screen readers, but it is the matching name that makes the browser treat them as one choice.',
        options: [
          { label: 'name', correct: true },
          { label: 'id' },
          { label: 'value' },
          { label: 'group' },
        ],
        skill: 'forms',
      },
      {
        slug: 'a6-q5',
        prompt: 'Which input type suits a UK postcode?',
        explanation:
          'A postcode contains letters and a space, so `text`. `number` would strip formatting and reject letters.',
        options: [
          { label: 'text', correct: true },
          { label: 'number' },
          { label: 'tel' },
          { label: 'search' },
        ],
        skill: 'forms',
      },
      {
        slug: 'a6-q6',
        prompt: 'Which form method should be used for a search box?',
        explanation:
          'GET, so results appear in the URL and can be bookmarked and shared. It only reads data.',
        options: [
          { label: 'GET', correct: true },
          { label: 'POST' },
          { label: 'Either, but POST is safer' },
          { label: 'It depends on the number of fields' },
        ],
        skill: 'forms',
      },
      {
        slug: 'a6-q7',
        prompt: 'What must accompany a `pattern` attribute?',
        explanation:
          'A visible, plain-language description of the required format, connected with `aria-describedby`.',
        options: [
          { label: 'A visible hint connected with aria-describedby', correct: true },
          { label: 'A matching maxlength' },
          { label: 'A title attribute only' },
          { label: 'Nothing — the browser explains it' },
        ],
        skill: 'accessibility',
      },
      {
        slug: 'a6-q8',
        prompt: 'What does `<legend>` do?',
        explanation:
          'It labels the whole `<fieldset>` group, and screen readers announce it before each control in the group.',
        options: [
          { label: 'Labels the group of controls in a fieldset', correct: true },
          { label: 'Labels a single input' },
          { label: 'Provides a table caption' },
          { label: 'Describes a validation error' },
        ],
        skill: 'forms',
      },
      {
        slug: 'a6-q9',
        prompt: 'You add a "Show password" button inside a form and omit `type`. What happens on click?',
        explanation: 'It submits the form, because `submit` is the default button type.',
        options: [
          { label: 'The form is submitted', correct: true },
          { label: 'Nothing happens' },
          { label: 'The form is reset' },
          { label: 'The password is revealed' },
        ],
        skill: 'forms',
      },
      {
        slug: 'a6-q10',
        prompt: 'Why is `<input type="hidden">` unsuitable for secrets?',
        explanation: 'Its value is in the page source, visible to anyone who looks.',
        options: [
          { label: 'Its value is visible in the page source', correct: true },
          { label: 'It is not submitted with the form' },
          { label: 'Screen readers announce it aloud' },
          { label: 'Browsers strip it before sending' },
        ],
        skill: 'security',
      },
    ],
  },
};
