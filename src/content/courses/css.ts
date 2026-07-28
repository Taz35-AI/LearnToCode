import { CSS_LEVEL_01 } from '../levels/css-level-01';
import { CSS_LEVEL_02 } from '../levels/css-level-02';
import { CSS_LEVEL_03 } from '../levels/css-level-03';
import { CSS_LEVEL_04 } from '../levels/css-level-04';
import { CSS_LEVEL_05 } from '../levels/css-level-05';
import { CSS_LEVEL_06 } from '../levels/css-level-06';
import { CSS_LEVEL_07 } from '../levels/css-level-07';
import { CSS_LEVEL_08 } from '../levels/css-level-08';
import { CSS_LEVEL_09 } from '../levels/css-level-09';
import { CSS_LEVEL_10 } from '../levels/css-level-10';
import { CSS_LEVEL_11 } from '../levels/css-level-11';
import { CSS_LEVEL_12 } from '../levels/css-level-12';
import type { CourseSpec } from '../types';

/**
 * The CSS curriculum.
 *
 * **Unpublished while it is being written.** The course row is seeded, so every
 * lesson can be loaded, rendered and verified against the real database as it is
 * authored — but `isPublished: false` keeps it off the roadmap and out of every
 * statistic a learner is shown. The alternative, a long-lived branch, means
 * content that is never seeded and never actually run until it all lands at
 * once.
 *
 * ## What this course has to teach, and in what order
 *
 * The ordering is not the usual one. Most CSS material starts with selectors and
 * properties and reaches the cascade somewhere near the end, by which point the
 * learner has already formed a mental model in which rules mysteriously stop
 * working. The cascade, specificity and inheritance come *first* here, because
 * they are the model everything else hangs on, and because nearly every "CSS is
 * confusing" experience is really a cascade misunderstanding.
 *
 * Levels, in the order a learner meets them:
 *
 *  1. The cascade, specificity and inheritance — why a rule wins or loses
 *  2. The box model, and how a box actually gets its size
 *  3. Flow, positioning and stacking
 *  4. Flexbox, taught until fluent
 *  5. Grid, taught until fluent
 *  6. Responsive design and container queries
 *  7. Custom properties and design tokens
 *  8. Typography and colour systems
 *  9. Transitions, animation and motion preferences
 * 10. Architecture, naming and scale
 * 11. Developer tools for CSS
 * 12. Capstone: styling the site built in the HTML course
 *
 * The capstone is deliberate: the learner already has a real, valid, accessible
 * multi-page site from the HTML course, and styling *that* is a far better
 * exercise than styling a fresh mock-up. It also makes the dependency between
 * the two courses concrete rather than nominal.
 */
export const CSS_COURSE: CourseSpec = {
  slug: 'css-architect',
  title: 'CSS Architect',
  subtitle: 'From "why is this not working" to layouts you can reason about',
  description:
    'A mastery-based journey through modern CSS. It starts with the cascade rather than ending with it, because almost every hour lost to CSS is really a cascade misunderstanding. You style the site you built in the HTML course, and finish able to build responsive, maintainable layouts and explain exactly why each rule applies.',
  outcome:
    'You can style a complete multi-page site with modern CSS, and explain why every rule in it wins or loses.',
  ordinal: 2,
  accent: 'violet',
  recommendedDays: 30,
  recommendedMinutesPerDay: 60,
  version: '0.1.0',
  prerequisites: ['html-hero'],
  isPublished: true,
  levels: [
    CSS_LEVEL_01,
    CSS_LEVEL_02,
    CSS_LEVEL_03,
    CSS_LEVEL_04,
    CSS_LEVEL_05,
    CSS_LEVEL_06,
    CSS_LEVEL_07,
    CSS_LEVEL_08,
    CSS_LEVEL_09,
    CSS_LEVEL_10,
    CSS_LEVEL_11,
    CSS_LEVEL_12,
  ],
};
