import { LEVEL_01 } from '../levels/level-01';
import { LEVEL_02 } from '../levels/level-02';
import { LEVEL_03 } from '../levels/level-03';
import { LEVEL_04 } from '../levels/level-04';
import { LEVEL_05 } from '../levels/level-05';
import { LEVEL_06 } from '../levels/level-06';
import { LEVEL_07 } from '../levels/level-07';
import { LEVEL_08 } from '../levels/level-08';
import { LEVEL_09 } from '../levels/level-09';
import { LEVEL_10 } from '../levels/level-10';
import { LEVEL_11 } from '../levels/level-11';
import { LEVEL_12 } from '../levels/level-12';
import type { CourseSpec } from '../types';

/**
 * The complete HTML curriculum.
 *
 * Twelve mastery levels, not thirty days. The recommended pace is derived from
 * the total teaching time and the learner's own answers during onboarding — the
 * curriculum itself contains no calendar at all.
 */
export const HTML_COURSE: CourseSpec = {
  slug: 'html-hero',
  title: 'HTML Hero',
  subtitle: 'From complete beginner to production-quality HTML',
  description:
    'A mastery-based journey through modern HTML. Twelve levels, each unlocked by demonstrated understanding rather than elapsed time. You build one real website throughout, and finish able to build, validate, improve, export and publish a professional multi-page site.',
  outcome:
    'You can build, validate, improve, export and publish a professional multi-page website in modern HTML.',
  ordinal: 1,
  accent: 'blue',
  recommendedDays: 30,
  recommendedMinutesPerDay: 60,
  version: '1.0.0',
  isPublished: true,
  levels: [
    LEVEL_01,
    LEVEL_02,
    LEVEL_03,
    LEVEL_04,
    LEVEL_05,
    LEVEL_06,
    LEVEL_07,
    LEVEL_08,
    LEVEL_09,
    LEVEL_10,
    LEVEL_11,
    LEVEL_12,
  ],
};
