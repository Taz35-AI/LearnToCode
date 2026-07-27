import type {
  AssessmentKind,
  BlockType,
  ExerciseKind,
  QuestionKind,
  RequirementKind,
} from '@/lib/supabase/database.types';

/**
 * The curriculum authoring format.
 *
 * Course content is authored here as typed TypeScript, then compiled into
 * normalised SQL rows by `npm run seed:generate`. Authoring in TypeScript
 * means every lesson is type-checked and every media reference is validated
 * before it can reach the database; storing the result in normalised tables
 * means content can afterwards be edited row by row without touching the app.
 */

// ---------------------------------------------------------------------------
// Lesson content blocks
// ---------------------------------------------------------------------------

export interface BlockSpec {
  type: BlockType;
  title?: string;
  body?: string;
  code?: string;
  language?: string;
  mediaSlug?: string;
  data?: Record<string, unknown>;
}

/** The learning objectives that open every lesson. */
export const objectives = (items: string[]): BlockSpec => ({
  type: 'objectives',
  title: 'What you will be able to do',
  data: { items },
});

/** A short explanation. Keep these to two or three sentences. */
export const prose = (body: string, title?: string): BlockSpec => ({
  type: 'prose',
  ...(title ? { title } : {}),
  body,
});

/** Defines a piece of jargon *before* the lesson uses it. */
export const term = (word: string, meaning: string, example?: string): BlockSpec => ({
  type: 'term',
  title: word,
  body: meaning,
  data: example ? { example } : {},
});

export type CalloutTone = 'tip' | 'warning' | 'mistake' | 'note' | 'accessibility';

export const callout = (tone: CalloutTone, title: string, body: string): BlockSpec => ({
  type: 'callout',
  title,
  body,
  data: { tone },
});

/** A diagram or photograph from the media library. */
export const visual = (mediaSlug: string, caption: string): BlockSpec => ({
  type: 'visual',
  mediaSlug,
  body: caption,
});

/** A complete, correct code sample. */
export const code = (codeText: string, title?: string, language = 'html'): BlockSpec => ({
  type: 'code_example',
  ...(title ? { title } : {}),
  code: codeText,
  language,
});

export interface AnnotationSpec {
  /** 1-based line number in the sample, or a range like "3-5". */
  line: string;
  text: string;
}

/** A code sample with a line-by-line explanation. */
export const annotated = (
  codeText: string,
  annotations: AnnotationSpec[],
  title = 'Line by line',
): BlockSpec => ({
  type: 'annotated_code',
  title,
  code: codeText,
  language: 'html',
  data: { annotations },
});

/** A side-by-side "do this / not this" comparison. */
export const compare = (
  title: string,
  good: { code: string; label: string; why: string },
  bad: { code: string; label: string; why: string },
): BlockSpec => ({
  type: 'comparison',
  title,
  data: { good, bad },
});

/**
 * A live demonstration the learner can toggle. `variants` each render in a
 * sandboxed preview so the difference is visible, not just described.
 */
export const demo = (
  title: string,
  intro: string,
  variants: { label: string; code: string; note: string }[],
): BlockSpec => ({
  type: 'interactive_demo',
  title,
  body: intro,
  data: { variants },
});

/** An `<img>`, `<video>` or `<audio>` demonstration using the media library. */
export const mediaExample = (
  mediaSlug: string,
  title: string,
  body: string,
  codeText: string,
): BlockSpec => ({
  type: 'media_example',
  title,
  body,
  code: codeText,
  language: 'html',
  mediaSlug,
});

/** Deeper technical detail, collapsed by default so it never overwhelms. */
export const detail = (title: string, body: string, codeText?: string): BlockSpec => ({
  type: 'progressive_detail',
  title,
  body,
  ...(codeText ? { code: codeText, language: 'html' } : {}),
});

export const checklist = (title: string, items: string[]): BlockSpec => ({
  type: 'checklist',
  title,
  data: { items },
});

/** The closing recap. Every lesson ends with one. */
export const recap = (points: string[], nextUp?: string): BlockSpec => ({
  type: 'summary',
  title: 'Lesson summary',
  data: { points, ...(nextUp ? { nextUp } : {}) },
});

// ---------------------------------------------------------------------------
// Retrieval-practice blocks
//
// The six block types added by migration 0006. What unites them is that each
// one asks the learner to *produce* something — a guess, a prediction, an
// explanation, a memory — before it shows them anything. That ordering is the
// whole point. Reading an explanation produces a strong feeling of
// understanding and very little durable knowledge; attempting first and being
// wrong produces the opposite, which is why these blocks are deliberately
// uncomfortable to work through.
//
// Every one of them hides its answer until the learner commits. A block that
// reveals the answer alongside the question is a `prose` block wearing a
// costume, and it teaches like one.
// ---------------------------------------------------------------------------

/**
 * A question asked *before* the material is taught.
 *
 * The learner will usually get it wrong, and that is the mechanism rather than
 * a side effect: a failed retrieval attempt primes the explanation that
 * follows, so the same paragraph read afterwards lands far harder. Put one at
 * the very top of a lesson, above the objectives.
 *
 * `answer` explains which option was right and why — it is shown only once a
 * guess has been committed.
 */
export const pretest = (
  prompt: string,
  options: string[],
  answer: string,
  title = 'Before we start — have a guess',
): BlockSpec => ({
  type: 'pretest',
  title,
  body: prompt,
  data: { options, answer },
});

/**
 * Free recall: "write down everything you remember about X."
 *
 * Harder than recognising an answer from a list, and correspondingly more
 * effective. `points` is what a good answer would contain — revealed after the
 * learner has written theirs, so it grades their memory rather than replacing
 * it.
 */
export const recall = (
  prompt: string,
  points: string[],
  title = 'From memory',
): BlockSpec => ({
  type: 'recall',
  title,
  body: prompt,
  data: { points },
});

/**
 * Predict what this code does, then run it.
 *
 * A mismatch between prediction and result is the moment a misconception
 * becomes visible — to the learner, not just to us. Reading the same code with
 * the answer already on screen surfaces nothing, because a wrong model of it
 * never gets stated and so never gets contradicted.
 */
export const predictCheck = (
  codeText: string,
  question: string,
  outcome: string,
  title = 'Predict, then check',
): BlockSpec => ({
  type: 'predict_check',
  title,
  body: question,
  code: codeText,
  language: 'html',
  data: { outcome },
});

/**
 * Asks the learner to explain something in their own words.
 *
 * Self-explanation forces the gaps in an understanding into the open, because
 * an explanation cannot be assembled out of a vague sense of familiarity.
 * `modelAnswer` is for comparison afterwards, never a target to reproduce.
 */
export const selfExplain = (
  prompt: string,
  modelAnswer: string,
  title = 'Explain it in your own words',
): BlockSpec => ({
  type: 'self_explain',
  title,
  body: prompt,
  data: { modelAnswer },
});

export interface WorkedStepSpec {
  title: string;
  code: string;
  /** Why this step, not merely what it does. */
  reasoning: string;
}

/**
 * A problem solved one step at a time, with the reasoning behind each step.
 *
 * A beginner given a finished solution has to reverse-engineer the thinking,
 * which is most of the difficulty and the part they cannot yet do. Studying
 * worked examples produces better results than problem-solving alone early on,
 * and the advantage reverses as expertise grows — so these belong in the
 * lessons that introduce something, not in the ones that consolidate it.
 */
export const workedExample = (
  title: string,
  intro: string,
  steps: WorkedStepSpec[],
): BlockSpec => ({
  type: 'worked_example',
  title,
  body: intro,
  data: { steps },
});

/**
 * The closing retrieval recap.
 *
 * Distinct from `recap`, which writes a `summary` block: that one *tells* the
 * learner what the lesson said, this one makes them say it. Both have a place —
 * the summary is a reference to come back to, this is the last piece of
 * practice — but only one of them strengthens memory.
 *
 * `points` are revealed after the learner has attempted the prompts.
 */
export const activeRecap = (
  prompts: string[],
  points: string[],
  title = 'Close the book',
): BlockSpec => ({
  type: 'recap',
  title,
  data: { prompts, points },
});

/**
 * The block types that make the learner produce something before showing them
 * anything. Counted separately in the seed statistics, because "how much of
 * this course is retrieval rather than reading" is the number Part A exists to
 * move.
 */
export const RETRIEVAL_BLOCK_TYPES: ReadonlySet<BlockType> = new Set<BlockType>([
  'pretest',
  'recall',
  'predict_check',
  'self_explain',
  'worked_example',
  'recap',
]);

// ---------------------------------------------------------------------------
// Block validation
// ---------------------------------------------------------------------------

/** Reads a `string[]` out of a block's untyped `data`, ignoring anything else. */
function stringList(data: Record<string, unknown> | undefined, key: string): string[] {
  const value = data?.[key];
  return Array.isArray(value) ? value.filter((item): item is string => typeof item === 'string') : [];
}

function nonEmptyString(data: Record<string, unknown> | undefined, key: string): boolean {
  const value = data?.[key];
  return typeof value === 'string' && value.trim().length > 0;
}

/**
 * Structural problems with one authored block, as plain messages.
 *
 * The builders above cannot produce a malformed block, but a `BlockSpec` object
 * literal can, and the retrieval blocks fail *quietly* when they are: a pretest
 * with no options renders as a question nobody can answer, and a worked example
 * with no steps renders as nothing at all. A lesson that silently teaches
 * nothing is worse than a build that stops, so these are checked at seed time
 * where the failure is loud and names the lesson.
 *
 * Lives here rather than in the seed script so the rules sit beside the format
 * they describe, and so they can be tested directly.
 */
export function blockProblems(block: BlockSpec): string[] {
  const problems: string[] = [];
  const data = block.data;
  const require = (condition: boolean, message: string) => {
    if (!condition) problems.push(message);
  };

  switch (block.type) {
    case 'pretest':
      require(Boolean(block.body?.trim()), 'pretest block has no question');
      require(stringList(data, 'options').length >= 2, 'pretest block needs at least two options');
      require(nonEmptyString(data, 'answer'), 'pretest block has no answer to reveal');
      break;

    case 'recall':
      require(Boolean(block.body?.trim()), 'recall block has no prompt');
      require(stringList(data, 'points').length > 0, 'recall block lists no expected points');
      break;

    case 'predict_check':
      require(Boolean(block.body?.trim()), 'predict_check block has no question');
      require(Boolean(block.code?.trim()), 'predict_check block has no code to predict');
      require(nonEmptyString(data, 'outcome'), 'predict_check block does not say what happens');
      break;

    case 'self_explain':
      require(Boolean(block.body?.trim()), 'self_explain block has no prompt');
      require(nonEmptyString(data, 'modelAnswer'), 'self_explain block has no model answer');
      break;

    case 'worked_example': {
      const steps = Array.isArray(data?.steps) ? data.steps : [];
      require(steps.length > 0, 'worked_example block has no steps');
      for (const [index, step] of steps.entries()) {
        const record =
          typeof step === 'object' && step !== null && !Array.isArray(step)
            ? (step as Record<string, unknown>)
            : undefined;
        require(nonEmptyString(record, 'title'), `worked_example step ${index + 1} has no title`);
        require(
          nonEmptyString(record, 'reasoning'),
          `worked_example step ${index + 1} explains what but not why`,
        );
      }
      break;
    }

    case 'recap':
      require(stringList(data, 'prompts').length > 0, 'recap block asks nothing');
      require(stringList(data, 'points').length > 0, 'recap block reveals nothing');
      break;

    default:
      break;
  }

  return problems;
}

// ---------------------------------------------------------------------------
// Exercise requirements
// ---------------------------------------------------------------------------

export interface RequirementSpec {
  kind: RequirementKind;
  selector?: string;
  attribute?: string;
  expectedValue?: string;
  ancestorSelector?: string;
  minCount?: number;
  maxCount?: number;
  message: string;
  hint?: string;
  weight?: number;
  critical?: boolean;
}

export const doctype = (): RequirementSpec => ({
  kind: 'doctype',
  message: 'The page starts with <!DOCTYPE html>',
  hint: 'The very first line of an HTML file is <!DOCTYPE html>, before anything else.',
});

export const present = (selector: string, message: string, hint?: string): RequirementSpec => ({
  kind: 'element_present',
  selector,
  message,
  ...(hint ? { hint } : {}),
});

export const absent = (selector: string, message: string, hint?: string): RequirementSpec => ({
  kind: 'element_absent',
  selector,
  message,
  ...(hint ? { hint } : {}),
});

export const unique = (selector: string, message: string, hint?: string): RequirementSpec => ({
  kind: 'unique_element',
  selector,
  message,
  ...(hint ? { hint } : {}),
});

export const count = (
  selector: string,
  min: number,
  max: number | null,
  message: string,
  hint?: string,
): RequirementSpec => ({
  kind: 'element_count',
  selector,
  minCount: min,
  ...(max === null ? {} : { maxCount: max }),
  message,
  ...(hint ? { hint } : {}),
});

export const attr = (
  selector: string,
  attribute: string,
  message: string,
  hint?: string,
): RequirementSpec => ({
  kind: 'attribute_present',
  selector,
  attribute,
  message,
  ...(hint ? { hint } : {}),
});

export const attrValue = (
  selector: string,
  attribute: string,
  value: string,
  message: string,
  hint?: string,
): RequirementSpec => ({
  kind: 'attribute_value',
  selector,
  attribute,
  expectedValue: value,
  message,
  ...(hint ? { hint } : {}),
});

export const attrMatches = (
  selector: string,
  attribute: string,
  pattern: string,
  message: string,
  hint?: string,
): RequirementSpec => ({
  kind: 'attribute_matches',
  selector,
  attribute,
  expectedValue: pattern,
  message,
  ...(hint ? { hint } : {}),
});

export const noAttr = (
  selector: string,
  attribute: string,
  message: string,
  hint?: string,
): RequirementSpec => ({
  kind: 'attribute_absent',
  selector,
  attribute,
  message,
  ...(hint ? { hint } : {}),
});

export const inside = (
  selector: string,
  ancestor: string,
  message: string,
  hint?: string,
  min = 1,
): RequirementSpec => ({
  kind: 'nesting',
  selector,
  ancestorSelector: ancestor,
  minCount: min,
  message,
  ...(hint ? { hint } : {}),
});

export const directChild = (
  selector: string,
  parent: string,
  message: string,
  hint?: string,
): RequirementSpec => ({
  kind: 'direct_child',
  selector,
  ancestorSelector: parent,
  message,
  ...(hint ? { hint } : {}),
});

export const textIn = (selector: string, needle: string, message: string, hint?: string): RequirementSpec => ({
  kind: 'text_content',
  selector,
  expectedValue: needle,
  message,
  ...(hint ? { hint } : {}),
});

export const notEmpty = (selector: string, message: string, hint?: string): RequirementSpec => ({
  kind: 'text_not_empty',
  selector,
  message,
  ...(hint ? { hint } : {}),
});

export const named = (selector: string, message: string, hint?: string): RequirementSpec => ({
  kind: 'accessible_name',
  selector,
  message,
  ...(hint ? { hint } : {}),
});

export const goodAlt = (selector = 'img', message = 'Every image has meaningful alternative text'): RequirementSpec => ({
  kind: 'alt_quality',
  selector,
  message,
  hint: 'Describe what the image shows, as if reading the page aloud to someone who cannot see it. Use alt="" only for purely decorative images.',
});

export const labelled = (
  selector = 'input, select, textarea',
  message = 'Every form control has a label',
): RequirementSpec => ({
  kind: 'label_association',
  selector,
  message,
  hint: 'Give the control an id, then point a <label for="that-id"> at it.',
});

export const headingOrder = (
  message = 'The heading hierarchy is correct: one <h1>, and no skipped levels',
): RequirementSpec => ({
  kind: 'heading_order',
  message,
  hint: 'Start with a single <h1>, then step down one level at a time — h2 before h3.',
});

export const uniqueIds = (message = 'Every id on the page is unique'): RequirementSpec => ({
  kind: 'no_duplicate_ids',
  message,
  hint: 'Two elements can never share an id. Use a class or a different id.',
});

export const noScripts = (message = 'The page contains no JavaScript'): RequirementSpec => ({
  kind: 'no_inline_script',
  message,
  weight: 0.5,
  critical: false,
});

export const mediaResolves = (
  selector?: string,
  message = 'Every media path points at a file that exists',
): RequirementSpec => ({
  kind: 'local_media_path',
  ...(selector ? { selector } : {}),
  message,
  hint: 'Use the media library button in the editor toolbar to insert a correct path.',
});

export const noObsolete = (
  message = 'No obsolete elements are used',
): RequirementSpec => ({
  kind: 'no_deprecated_elements',
  message,
  hint: 'Elements like <center>, <font> and <big> were removed from HTML.',
});

export const legalNesting = (
  message = 'Elements are nested legally',
): RequirementSpec => ({
  kind: 'valid_nesting',
  message,
  hint: 'For example: <li> must be inside <ul> or <ol>, and a block element cannot sit inside a <p>.',
});

// ---------------------------------------------------------------------------
// Exercises
// ---------------------------------------------------------------------------

export interface ExerciseSpec {
  slug: string;
  kind: ExerciseKind;
  title: string;
  brief: string;
  starterCode?: string;
  referenceSolution: string;
  /** Revealed one at a time, each more specific than the last. */
  hints: string[];
  requirements: RequirementSpec[];
  xp?: number;
  difficulty?: 1 | 2 | 3 | 4 | 5;
  skill?: string;
  optional?: boolean;
}

// ---------------------------------------------------------------------------
// Knowledge checks
// ---------------------------------------------------------------------------

export interface QuestionSpec {
  slug: string;
  kind?: QuestionKind;
  prompt: string;
  explanation: string;
  /**
   * Authored with the correct answer first, for readability while writing.
   * `orderedOptions` rotates them before they reach a learner — see below.
   */
  options: { label: string; correct?: boolean; feedback?: string }[];
  skill?: string;
  xp?: number;
}

/**
 * Returns a question's options in the order a learner should see them.
 *
 * Questions are authored with the correct answer first, which makes them far
 * easier to write and review — but shipping them that way would let a learner
 * pattern-match the position instead of reading the question. This rotates each
 * question's options by a hash of its slug: stable across runs and rebuilds
 * (so a learner's stored answer never points at a different option), varied
 * across questions, and requiring no manual shuffling of 200-plus questions.
 */
export function orderedOptions(question: QuestionSpec): QuestionSpec['options'] {
  const options = question.options;
  if (options.length < 2) return options;

  let hash = 0;
  for (let i = 0; i < question.slug.length; i += 1) {
    hash = (hash * 31 + question.slug.charCodeAt(i)) >>> 0;
  }

  const offset = hash % options.length;
  return [...options.slice(offset), ...options.slice(0, offset)];
}

// ---------------------------------------------------------------------------
// Lessons, modules, levels
// ---------------------------------------------------------------------------

export interface LessonSpec {
  slug: string;
  title: string;
  subtitle: string;
  summary: string;
  objectives: string[];
  estimatedMinutes: number;
  xp?: number;
  /** The skill this lesson chiefly builds. */
  skill: string;
  masteryThreshold?: number;
  blocks: BlockSpec[];
  exercises: ExerciseSpec[];
  quiz: QuestionSpec[];
}

export interface ModuleSpec {
  slug: string;
  title: string;
  summary: string;
  estimatedMinutes?: number;
  isMilestone?: boolean;
  /** Module slugs that must be finished first. */
  prerequisites?: string[];
  /** Skills this module teaches, with the mastery needed to move past it. */
  skills: { slug: string; masteryRequired?: number }[];
  lessons: LessonSpec[];
}

export interface AssessmentSpec {
  slug: string;
  kind: AssessmentKind;
  title: string;
  description: string;
  passScore?: number;
  xp?: number;
  questions: QuestionSpec[];
}

export interface LevelSpec {
  slug: string;
  title: string;
  subtitle: string;
  summary: string;
  outcome: string;
  accent: string;
  modules: ModuleSpec[];
  assessment?: AssessmentSpec;
}

/**
 * One course in the programme.
 *
 * The application began with a single course and a hard-coded slug in the data
 * layer. That is now data: a course knows its own position, what must be
 * finished before it opens, and whether it is ready to be seen at all.
 *
 * `isPublished: false` is the important one. Authoring a course the size of the
 * HTML one takes many sessions, and the alternative to an unpublished flag is a
 * long-lived branch — which means the content is never seeded, never rendered,
 * and never actually verified until the day it all lands at once. An
 * unpublished course is seeded and testable and simply not offered to a
 * learner.
 */
export interface CourseSpec {
  slug: string;
  title: string;
  subtitle: string;
  description: string;
  /** One sentence naming what a graduate can do. */
  outcome: string;
  /** Position in the programme: HTML is 1, CSS is 2, JavaScript is 3. */
  ordinal: number;
  accent: string;
  recommendedDays: number;
  recommendedMinutesPerDay: number;
  version: string;
  /** Slugs of courses that must be finished first. */
  prerequisites?: string[];
  /** False while the course is still being written. */
  isPublished: boolean;
  levels: LevelSpec[];
}

export interface SkillSpec {
  slug: string;
  name: string;
  description: string;
  category: string;
  prerequisites?: string[];
}

export interface AchievementSpec {
  slug: string;
  name: string;
  description: string;
  icon: string;
  tier: 'bronze' | 'silver' | 'gold' | 'platinum';
  criteria: Record<string, unknown>;
  xp: number;
}

export interface ProjectTemplateSpec {
  slug: string;
  name: string;
  tagline: string;
  description: string;
  audience: string;
  heroMediaSlug: string;
  pagePlan: { path: string; title: string; purpose: string }[];
}
