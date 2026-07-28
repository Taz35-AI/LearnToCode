#!/usr/bin/env tsx
/**
 * Compiles the TypeScript curriculum into `supabase/seed.sql`.
 *
 * The curriculum is authored as typed TypeScript so every media reference,
 * skill slug and requirement shape is checked before it can reach the database.
 * The output is fully normalised SQL — many small rows, no oversized JSON
 * fields — so content can afterwards be edited row by row without any code
 * change or rebuild.
 *
 * Run: npm run seed:generate
 */

import { readFile, writeFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import { join } from 'node:path';

import { COURSES, allProgrammeLessons, courseStats, programmeStats, totalCourseMinutes } from '../src/content/course';
import { SKILLS } from '../src/content/skills';
import { ACHIEVEMENTS } from '../src/content/achievements';
import { PROJECT_TEMPLATES } from '../src/content/projects';
import { MEDIA_ASSETS, getMedia } from '../src/content/media/manifest';
import { blockProblems, orderedOptions } from '../src/content/types';
import type { BlockSpec, CourseSpec, LessonSpec, ModuleSpec, QuestionSpec, RequirementSpec } from '../src/content/types';

const ROOT = fileURLToPath(new URL('..', import.meta.url));
const OUT = join(ROOT, 'supabase', 'seed.sql');
const HEALTH_CHECK = join(ROOT, 'supabase', 'tests', 'verify-database.sql');

// ---------------------------------------------------------------------------
// SQL literal helpers
// ---------------------------------------------------------------------------

/** Quotes a value as a SQL string literal, or NULL. */
function q(value: string | null | undefined): string {
  if (value === null || value === undefined) return 'NULL';
  return `'${value.replace(/'/g, "''")}'`;
}

function n(value: number | null | undefined): string {
  return value === null || value === undefined ? 'NULL' : String(value);
}

function b(value: boolean | undefined): string {
  return value ? 'true' : 'false';
}

/** A Postgres text[] literal. */
function arr(values: readonly string[]): string {
  if (values.length === 0) return "'{}'";
  return `ARRAY[${values.map(q).join(', ')}]::text[]`;
}

function json(value: unknown): string {
  return `${q(JSON.stringify(value ?? {}))}::jsonb`;
}

// ---------------------------------------------------------------------------
// Validation — the seed must never produce a broken course
// ---------------------------------------------------------------------------

const problems: string[] = [];

function validate(): void {
  const skillSlugs = new Set(SKILLS.map((s) => s.slug));
  const mediaSlugs = new Set(MEDIA_ASSETS.map((m) => m.slug));
  const lessonSlugs = new Set<string>();
  const exerciseSlugs = new Set<string>();
  const questionSlugs = new Set<string>();
  const allLevels = COURSES.flatMap((c) => c.levels);
  const moduleSlugs = new Set(allLevels.flatMap((l) => l.modules.map((m) => m.slug)));

  for (const skill of SKILLS) {
    for (const prerequisite of skill.prerequisites ?? []) {
      if (!skillSlugs.has(prerequisite)) {
        problems.push(`skill "${skill.slug}" has unknown prerequisite "${prerequisite}"`);
      }
    }
  }

  for (const level of allLevels) {
    for (const mod of level.modules) {
      for (const prerequisite of mod.prerequisites ?? []) {
        if (!moduleSlugs.has(prerequisite)) {
          problems.push(`module "${mod.slug}" has unknown prerequisite "${prerequisite}"`);
        }
      }
      for (const skill of mod.skills) {
        if (!skillSlugs.has(skill.slug)) {
          problems.push(`module "${mod.slug}" references unknown skill "${skill.slug}"`);
        }
      }
      for (const lesson of mod.lessons) {
        if (lessonSlugs.has(lesson.slug)) problems.push(`duplicate lesson slug "${lesson.slug}"`);
        lessonSlugs.add(lesson.slug);

        if (!skillSlugs.has(lesson.skill)) {
          problems.push(`lesson "${lesson.slug}" references unknown skill "${lesson.skill}"`);
        }
        if (lesson.blocks.length === 0) {
          problems.push(`lesson "${lesson.slug}" has no content blocks`);
        }
        if (lesson.exercises.length === 0) {
          problems.push(`lesson "${lesson.slug}" has no exercises`);
        }

        for (const block of lesson.blocks) {
          if (block.mediaSlug && !mediaSlugs.has(block.mediaSlug)) {
            problems.push(`lesson "${lesson.slug}" references unknown media "${block.mediaSlug}"`);
          }
          checkBlock(block, `lesson "${lesson.slug}"`);
        }

        for (const exercise of lesson.exercises) {
          if (exerciseSlugs.has(exercise.slug)) {
            problems.push(`duplicate exercise slug "${exercise.slug}"`);
          }
          exerciseSlugs.add(exercise.slug);

          if (exercise.requirements.length === 0) {
            problems.push(`exercise "${exercise.slug}" has no requirements`);
          }
          if (exercise.referenceSolution.trim().length === 0) {
            problems.push(`exercise "${exercise.slug}" has no reference solution`);
          }
          if (exercise.skill && !skillSlugs.has(exercise.skill)) {
            problems.push(`exercise "${exercise.slug}" references unknown skill "${exercise.skill}"`);
          }
          // Every media path used by a reference solution must actually exist.
          for (const path of extractMediaPaths(exercise.referenceSolution)) {
            if (!allPaths.has(path)) {
              problems.push(`exercise "${exercise.slug}" reference solution uses missing media "${path}"`);
            }
          }
          // Starter code may deliberately contain a broken path when finding it
          // *is* the exercise — a debugging challenge, or anything that asserts
          // `local_media_path` in its requirements.
          const pathsAreTheTask =
            exercise.kind === 'debug' ||
            exercise.requirements.some((r) => r.kind === 'local_media_path');
          if (!pathsAreTheTask) {
            for (const path of extractMediaPaths(exercise.starterCode ?? '')) {
              if (!allPaths.has(path)) {
                problems.push(`exercise "${exercise.slug}" starter code uses missing media "${path}"`);
              }
            }
          }
        }

        for (const question of lesson.quiz) {
          checkQuestion(question, `lesson "${lesson.slug}"`, questionSlugs, skillSlugs);
        }
      }
    }

    if (level.assessment) {
      for (const question of level.assessment.questions) {
        checkQuestion(question, `assessment "${level.assessment.slug}"`, questionSlugs, skillSlugs);
      }
    }
  }

  for (const template of PROJECT_TEMPLATES) {
    if (!mediaSlugs.has(template.heroMediaSlug)) {
      problems.push(`project "${template.slug}" references unknown media "${template.heroMediaSlug}"`);
    }
  }
}

function checkBlock(block: BlockSpec, context: string): void {
  for (const problem of blockProblems(block)) {
    problems.push(`${context}: ${problem}`);
  }
}

function checkQuestion(
  question: QuestionSpec,
  context: string,
  seen: Set<string>,
  skillSlugs: Set<string>,
): void {
  if (seen.has(question.slug)) problems.push(`duplicate question slug "${question.slug}"`);
  seen.add(question.slug);

  const correct = question.options.filter((o) => o.correct).length;
  if (correct === 0) problems.push(`question "${question.slug}" in ${context} has no correct answer`);
  if (question.kind !== 'multi' && correct > 1) {
    problems.push(`single-answer question "${question.slug}" has ${correct} correct options`);
  }
  if (question.options.length < 2) {
    problems.push(`question "${question.slug}" has fewer than two options`);
  }
  if (question.skill && !skillSlugs.has(question.skill)) {
    problems.push(`question "${question.slug}" references unknown skill "${question.skill}"`);
  }
}

const allPaths = new Set<string>();
for (const asset of MEDIA_ASSETS) {
  allPaths.add(asset.path);
  for (const s of asset.srcset) allPaths.add(s.path);
  for (const f of asset.formats) allPaths.add(f.path);
  if (asset.posterPath) allPaths.add(asset.posterPath);
  if (asset.captionsPath) allPaths.add(asset.captionsPath);
}
allPaths.add('/learning-media/favicon.svg');
allPaths.add('/learning-media/favicon.png');

/** Pulls every `/learning-media/...` path out of a block of HTML. */
function extractMediaPaths(html: string): string[] {
  const matches = html.matchAll(/["'\s(](\/learning-media\/[A-Za-z0-9._/-]+)/g);
  return [...matches].map((m) => m[1] ?? '').filter(Boolean);
}

// ---------------------------------------------------------------------------
// SQL emission
// ---------------------------------------------------------------------------

const sql: string[] = [];
const stats = { ...courseStats(), reviewItems: 0 };

function section(title: string): void {
  sql.push('', `-- ${'-'.repeat(74)}`, `-- ${title}`, `-- ${'-'.repeat(74)}`, '');
}

function emitHeader(): void {
  sql.push(
    '-- HTML Hero — course seed data',
    '--',
    '-- GENERATED FILE. Do not edit by hand.',
    '-- Source: src/content/**  ·  Regenerate: npm run seed:generate',
    '--',
    `-- ${stats.levels} levels · ${stats.modules} modules · ${stats.lessons} lessons`,
    `-- ${stats.blocks} content blocks · ${stats.exercises} exercises · ${stats.quizQuestions} questions`,
    `-- ${MEDIA_ASSETS.length} media assets · ${ACHIEVEMENTS.length} achievements`,
    `-- Estimated learner time: ${totalCourseMinutes()} minutes`,
    '--',
    '-- This script is idempotent: running it again updates existing rows in place',
    '-- rather than duplicating them, so content edits can be re-seeded safely.',
    '',
    'begin;',
    '',
    '-- Learner progress hangs off the catalogue by foreign key, and those keys',
    '-- cascade. Deleting a lesson therefore deletes every learner\'s progress',
    '-- through it, so rows a learner can reference are UPDATED IN PLACE by slug',
    '-- and never dropped and rebuilt. Only child rows nothing owns are replaced',
    '-- wholesale: blocks, requirements, options and join tables.',
    'delete from public.lesson_blocks;',
    'delete from public.exercise_requirements;',
    'delete from public.quiz_options;',
    'delete from public.module_skills;',
    'delete from public.module_prerequisites;',
    'delete from public.skill_prerequisites;',
    'delete from public.media_attributions;',
    'delete from public.learning_media;',
  );
}

function emitSkills(): void {
  section('Skills');
  SKILLS.forEach((skill, index) => {
    sql.push(
      `insert into public.skills (slug, name, description, category, ordinal) values (${q(skill.slug)}, ${q(skill.name)}, ${q(skill.description)}, ${q(skill.category)}, ${index + 1})
  on conflict (slug) do update set name = excluded.name, description = excluded.description, category = excluded.category, ordinal = excluded.ordinal;`,
    );
  });

  sql.push('');
  for (const skill of SKILLS) {
    for (const prerequisite of skill.prerequisites ?? []) {
      sql.push(
        `insert into public.skill_prerequisites (skill_id, prerequisite_skill_id)
  select s.id, p.id from public.skills s, public.skills p
  where s.slug = ${q(skill.slug)} and p.slug = ${q(prerequisite)}
  on conflict do nothing;`,
      );
    }
  }
}

function emitMedia(): void {
  section('Learning media and attributions');
  for (const asset of MEDIA_ASSETS) {
    sql.push(
      `insert into public.learning_media
  (slug, kind, title, description, path, width, height, duration_secs, srcset, formats, poster_path, captions_path, suggested_alt, is_decorative_example, tags)
values
  (${q(asset.slug)}, ${q(asset.kind)}, ${q(asset.title)}, ${q(asset.description)}, ${q(asset.path)},
   ${n(asset.width)}, ${n(asset.height)}, ${n(asset.durationSeconds)},
   ${json(asset.srcset)}, ${json(asset.formats)},
   ${q(asset.posterPath)}, ${q(asset.captionsPath)}, ${q(asset.suggestedAlt)},
   ${b(asset.isDecorativeExample)}, ${arr(asset.tags)})
on conflict (slug) do update set
  kind = excluded.kind, title = excluded.title, description = excluded.description,
  path = excluded.path, width = excluded.width, height = excluded.height,
  duration_secs = excluded.duration_secs, srcset = excluded.srcset, formats = excluded.formats,
  poster_path = excluded.poster_path, captions_path = excluded.captions_path,
  suggested_alt = excluded.suggested_alt, is_decorative_example = excluded.is_decorative_example,
  tags = excluded.tags;`,
    );

    const a = asset.attribution;
    sql.push(
      `insert into public.media_attributions
  (media_id, asset_title, creator, source, source_url, licence, licence_url, attribution_text, local_path, retrieved_on, notes)
select m.id, ${q(a.assetTitle)}, ${q(a.creator)}, ${q(a.source)}, ${q(a.sourceUrl)}, ${q(a.licence)},
       ${q(a.licenceUrl)}, ${q(a.attributionText)}, ${q(a.localPath)}, ${q(a.retrievedOn)}::date, ${q(a.notes ?? null)}
from public.learning_media m where m.slug = ${q(asset.slug)}
on conflict (media_id) do update set
  asset_title = excluded.asset_title, creator = excluded.creator, source = excluded.source,
  licence = excluded.licence, attribution_text = excluded.attribution_text,
  local_path = excluded.local_path, retrieved_on = excluded.retrieved_on, notes = excluded.notes;`,
      '',
    );
  }
}

function emitProjects(): void {
  section('Capstone project templates');
  PROJECT_TEMPLATES.forEach((template, index) => {
    sql.push(
      `insert into public.project_templates (slug, name, tagline, description, audience, hero_media_slug, page_plan, ordinal)
values (${q(template.slug)}, ${q(template.name)}, ${q(template.tagline)}, ${q(template.description)},
        ${q(template.audience)}, ${q(template.heroMediaSlug)}, ${json(template.pagePlan)}, ${index + 1})
on conflict (slug) do update set
  name = excluded.name, tagline = excluded.tagline, description = excluded.description,
  audience = excluded.audience, hero_media_slug = excluded.hero_media_slug,
  page_plan = excluded.page_plan, ordinal = excluded.ordinal;`,
    );
  });
}

function emitAchievements(): void {
  section('Achievements');
  ACHIEVEMENTS.forEach((achievement, index) => {
    sql.push(
      `insert into public.achievements (slug, name, description, icon, tier, criteria, xp_award, ordinal)
values (${q(achievement.slug)}, ${q(achievement.name)}, ${q(achievement.description)}, ${q(achievement.icon)},
        ${q(achievement.tier)}, ${json(achievement.criteria)}, ${achievement.xp}, ${index + 1})
on conflict (slug) do update set
  name = excluded.name, description = excluded.description, icon = excluded.icon,
  tier = excluded.tier, criteria = excluded.criteria, xp_award = excluded.xp_award,
  ordinal = excluded.ordinal;`,
    );
  });
}

/**
 * Every course in the programme, and the order they unlock in.
 *
 * Upserted by slug and never deleted, for the same reason lessons are: a
 * learner's plan, certificate and every level hang off `courses.id` by a
 * cascading foreign key, so dropping and rebuilding a course row would take
 * their progress with it.
 */
function emitCourses(): void {
  section('Courses');

  for (const course of COURSES) {
    sql.push(
      `insert into public.courses
  (slug, title, subtitle, description, outcome, ordinal, accent, is_published,
   recommended_days, recommended_minutes_per_day, version)
values (${q(course.slug)}, ${q(course.title)}, ${q(course.subtitle)}, ${q(course.description)},
        ${q(course.outcome)}, ${course.ordinal}, ${q(course.accent)}, ${b(course.isPublished)},
        ${course.recommendedDays}, ${course.recommendedMinutesPerDay}, ${q(course.version)})
on conflict (slug) do update set
  title = excluded.title, subtitle = excluded.subtitle, description = excluded.description,
  outcome = excluded.outcome, ordinal = excluded.ordinal, accent = excluded.accent,
  is_published = excluded.is_published,
  recommended_days = excluded.recommended_days,
  recommended_minutes_per_day = excluded.recommended_minutes_per_day,
  version = excluded.version;`,
    );
  }

  sql.push('', '-- Cross-course prerequisites: CSS rests on HTML.');
  sql.push('delete from public.course_prerequisites;');
  for (const course of COURSES) {
    for (const prerequisite of course.prerequisites ?? []) {
      sql.push(
        `insert into public.course_prerequisites (course_id, prerequisite_course_id)
select c.id, p.id from public.courses c, public.courses p
where c.slug = ${q(course.slug)} and p.slug = ${q(prerequisite)}
on conflict do nothing;`,
      );
    }
  }
}

function emitRequirement(exerciseSlug: string, req: RequirementSpec, ordinal: number): void {
  sql.push(
    `insert into public.exercise_requirements
  (exercise_id, ordinal, kind, selector, attribute, expected_value, ancestor_selector, min_count, max_count, message, hint, weight, is_critical, condition)
select e.id, ${ordinal}, ${q(req.kind)}::public.requirement_kind, ${q(req.selector)}, ${q(req.attribute)},
       ${q(req.expectedValue)}, ${q(req.ancestorSelector)}, ${n(req.minCount)}, ${n(req.maxCount)},
       ${q(req.message)}, ${q(req.hint)}, ${req.weight ?? 1}, ${req.critical === false ? 'false' : 'true'}, ${q(req.condition ?? null)}
from public.exercises e where e.slug = ${q(exerciseSlug)};`,
  );
}

function emitQuestion(
  question: QuestionSpec,
  ordinal: number,
  owner: { lessonSlug?: string; assessmentSlug?: string },
): void {
  const lessonRef = owner.lessonSlug
    ? `(select id from public.lessons where slug = ${q(owner.lessonSlug)})`
    : 'NULL';
  const assessmentRef = owner.assessmentSlug
    ? `(select id from public.assessments where slug = ${q(owner.assessmentSlug)})`
    : 'NULL';
  const skillRef = question.skill
    ? `(select id from public.skills where slug = ${q(question.skill)})`
    : 'NULL';

  sql.push(
    `insert into public.quiz_questions (lesson_id, assessment_id, slug, ordinal, kind, prompt, explanation, skill_id, xp_award)
values (${lessonRef}, ${assessmentRef}, ${q(question.slug)}, ${ordinal}, ${q(question.kind ?? 'single')}::public.question_kind,
        ${q(question.prompt)}, ${q(question.explanation)}, ${skillRef}, ${question.xp ?? 10})
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, assessment_id = excluded.assessment_id,
  ordinal = excluded.ordinal, kind = excluded.kind, prompt = excluded.prompt,
  explanation = excluded.explanation, skill_id = excluded.skill_id,
  xp_award = excluded.xp_award;`,
  );

  // Rotated so the correct answer is not always in the same position.
  orderedOptions(question).forEach((option, index) => {
    sql.push(
      `insert into public.quiz_options (question_id, ordinal, label, is_correct, feedback)
select id, ${index + 1}, ${q(option.label)}, ${b(option.correct)}, ${q(option.feedback ?? null)}
from public.quiz_questions where slug = ${q(question.slug)};`,
    );
  });
}

function emitLesson(lesson: LessonSpec, moduleSlug: string, ordinal: number): void {
  const skillRef = `(select id from public.skills where slug = ${q(lesson.skill)})`;

  sql.push(
    '',
    `-- lesson: ${lesson.title}`,
    `insert into public.lessons
  (module_id, slug, ordinal, title, subtitle, summary, objectives, estimated_minutes, xp_award, primary_skill_id, mastery_threshold)
select m.id, ${q(lesson.slug)}, ${ordinal}, ${q(lesson.title)}, ${q(lesson.subtitle)}, ${q(lesson.summary)},
       ${arr(lesson.objectives)}, ${lesson.estimatedMinutes}, ${lesson.xp ?? 40}, ${skillRef}, ${lesson.masteryThreshold ?? 0.7}
from public.modules m where m.slug = ${q(moduleSlug)}
on conflict (slug) do update set
  module_id = excluded.module_id, ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, objectives = excluded.objectives,
  estimated_minutes = excluded.estimated_minutes, xp_award = excluded.xp_award,
  primary_skill_id = excluded.primary_skill_id, mastery_threshold = excluded.mastery_threshold;`,
  );

  lesson.blocks.forEach((block, index) => {
    sql.push(
      `insert into public.lesson_blocks (lesson_id, ordinal, block_type, title, body, code, language, media_slug, data)
select id, ${index + 1}, ${q(block.type)}::public.block_type, ${q(block.title ?? null)}, ${q(block.body ?? null)},
       ${q(block.code ?? null)}, ${q(block.language ?? null)}, ${q(block.mediaSlug ?? null)}, ${json(block.data ?? {})}
from public.lessons where slug = ${q(lesson.slug)};`,
    );
  });

  lesson.exercises.forEach((exercise, index) => {
    const exerciseSkill = exercise.skill ?? lesson.skill;
    sql.push(
      '',
      `insert into public.exercises
  (lesson_id, slug, ordinal, kind, title, brief, starter_code, reference_solution, hints, xp_award, difficulty, skill_id, is_optional)
select l.id, ${q(exercise.slug)}, ${index + 1}, ${q(exercise.kind)}::public.exercise_kind, ${q(exercise.title)},
       ${q(exercise.brief)}, ${q(exercise.starterCode ?? '')}, ${q(exercise.referenceSolution)}, ${arr(exercise.hints)},
       ${exercise.xp ?? 30}, ${exercise.difficulty ?? 2},
       (select id from public.skills where slug = ${q(exerciseSkill)}), ${b(exercise.optional)}
from public.lessons l where l.slug = ${q(lesson.slug)}
on conflict (slug) do update set
  lesson_id = excluded.lesson_id, ordinal = excluded.ordinal, kind = excluded.kind,
  title = excluded.title, brief = excluded.brief, starter_code = excluded.starter_code,
  reference_solution = excluded.reference_solution, hints = excluded.hints,
  xp_award = excluded.xp_award, difficulty = excluded.difficulty,
  skill_id = excluded.skill_id, is_optional = excluded.is_optional;`,
    );
    exercise.requirements.forEach((req, reqIndex) => {
      emitRequirement(exercise.slug, req, reqIndex + 1);
    });
  });

  lesson.quiz.forEach((question, index) => {
    emitQuestion(question, index + 1, { lessonSlug: lesson.slug });
  });
}

function emitModule(mod: ModuleSpec, levelSlug: string, ordinal: number): void {
  sql.push(
    '',
    `-- module: ${mod.title}`,
    `insert into public.modules (level_id, slug, ordinal, title, summary, estimated_minutes, is_milestone)
select l.id, ${q(mod.slug)}, ${ordinal}, ${q(mod.title)}, ${q(mod.summary)},
       ${mod.estimatedMinutes ?? 45}, ${b(mod.isMilestone)}
from public.levels l where l.slug = ${q(levelSlug)}
on conflict (slug) do update set
  level_id = excluded.level_id, ordinal = excluded.ordinal, title = excluded.title,
  summary = excluded.summary, estimated_minutes = excluded.estimated_minutes,
  is_milestone = excluded.is_milestone;`,
  );

  for (const prerequisite of mod.prerequisites ?? []) {
    sql.push(
      `insert into public.module_prerequisites (module_id, prerequisite_module_id)
select m.id, p.id from public.modules m, public.modules p
where m.slug = ${q(mod.slug)} and p.slug = ${q(prerequisite)};`,
    );
  }

  for (const skill of mod.skills) {
    sql.push(
      `insert into public.module_skills (module_id, skill_id, mastery_required)
select m.id, s.id, ${skill.masteryRequired ?? 0}
from public.modules m, public.skills s
where m.slug = ${q(mod.slug)} and s.slug = ${q(skill.slug)};`,
    );
  }

  mod.lessons.forEach((lesson, index) => emitLesson(lesson, mod.slug, index + 1));
}

function emitLevels(): void {
  for (const course of COURSES) emitCourseLevels(course);
}

function emitCourseLevels(course: CourseSpec): void {
  course.levels.forEach((level, levelIndex) => {
    section(`${course.title} — Level ${levelIndex + 1}: ${level.title}`);
    sql.push(
      `insert into public.levels (course_id, slug, ordinal, title, subtitle, summary, outcome, accent)
select c.id, ${q(level.slug)}, ${levelIndex + 1}, ${q(level.title)}, ${q(level.subtitle)},
       ${q(level.summary)}, ${q(level.outcome)}, ${q(level.accent)}
from public.courses c where c.slug = ${q(course.slug)}
on conflict (course_id, slug) do update set
  ordinal = excluded.ordinal, title = excluded.title,
  subtitle = excluded.subtitle, summary = excluded.summary, outcome = excluded.outcome,
  accent = excluded.accent;`,
    );

    if (level.assessment) {
      const a = level.assessment;
      const courseRef =
        a.kind === 'final' ? `(select id from public.courses where slug = ${q(course.slug)})` : 'NULL';
      sql.push(
        `insert into public.assessments (level_id, course_id, slug, kind, title, description, pass_score, xp_award, ordinal)
select l.id, ${courseRef}, ${q(a.slug)}, ${q(a.kind)}::public.assessment_kind, ${q(a.title)}, ${q(a.description)},
       ${a.passScore ?? 0.75}, ${a.xp ?? 150}, ${levelIndex + 1}
from public.levels l where l.slug = ${q(level.slug)}
on conflict (slug) do update set
  level_id = excluded.level_id, course_id = excluded.course_id, kind = excluded.kind,
  title = excluded.title, description = excluded.description, pass_score = excluded.pass_score,
  xp_award = excluded.xp_award, ordinal = excluded.ordinal;`,
      );
    }

    level.modules.forEach((mod, index) => emitModule(mod, level.slug, index + 1));

    if (level.assessment) {
      sql.push('', `-- ${level.assessment.title} questions`);
      level.assessment.questions.forEach((question, index) => {
        emitQuestion(question, index + 1, { assessmentSlug: level.assessment?.slug });
      });
    }
  });
}

/**
 * Removes catalogue rows that are no longer part of the curriculum.
 *
 * Now that content is updated in place rather than rebuilt, a lesson deleted
 * from `src/content/` would otherwise linger in the database forever. This is
 * the one place the seed does destroy learner data, and it is correct that it
 * does: progress through a lesson that no longer exists has nowhere to live.
 * The deletes are ordered children-first so a cascade never does the work
 * silently.
 */
/**
 * Creates the pool of things spaced repetition can bring back.
 *
 * Every lesson knowledge-check question and every non-project exercise becomes
 * a review item. Milestone assessment questions are excluded on purpose: an
 * assessment is a measurement, and recycling its questions as practice turns
 * the measurement into a memory test of the measurement.
 *
 * Items are upserted by slug and never bulk-deleted, because review_states
 * cascades from them — dropping and rebuilding the pool would silently erase
 * every learner's schedule, which is the same trap the catalogue tables fell
 * into.
 */
function emitReviewItems(): void {
  section('Reviewable items (spaced repetition)');

  const slugs: string[] = [];

  for (const level of COURSES.flatMap((c) => c.levels)) {
    for (const mod of level.modules) {
      for (const lesson of mod.lessons) {
        for (const question of lesson.quiz) {
          const slug = `rv-q-${question.slug}`;
          slugs.push(slug);
          sql.push(
            `insert into public.review_items (slug, kind, skill_id, lesson_id, question_id, difficulty)
select ${q(slug)}, 'question'::public.review_item_kind,
       (select id from public.skills where slug = ${q(question.skill ?? lesson.skill)}),
       l.id, qq.id, 2
from public.lessons l, public.quiz_questions qq
where l.slug = ${q(lesson.slug)} and qq.slug = ${q(question.slug)}
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  question_id = excluded.question_id, difficulty = excluded.difficulty;`,
          );
        }

        for (const exercise of lesson.exercises) {
          // Project missions build the learner's own site; they are not
          // repeatable practice and would be meaningless out of context.
          if (exercise.kind === 'project_mission') continue;

          const slug = `rv-e-${exercise.slug}`;
          slugs.push(slug);
          sql.push(
            `insert into public.review_items (slug, kind, skill_id, lesson_id, exercise_id, difficulty)
select ${q(slug)}, 'exercise'::public.review_item_kind,
       (select id from public.skills where slug = ${q(exercise.skill ?? lesson.skill)}),
       l.id, e.id, ${Math.min(5, Math.max(1, exercise.difficulty ?? 2))}
from public.lessons l, public.exercises e
where l.slug = ${q(lesson.slug)} and e.slug = ${q(exercise.slug)}
on conflict (slug) do update set
  skill_id = excluded.skill_id, lesson_id = excluded.lesson_id,
  exercise_id = excluded.exercise_id, difficulty = excluded.difficulty;`,
          );
        }
      }
    }
  }

  stats.reviewItems = slugs.length;

  sql.push(
    '',
    '-- Items whose question or exercise has left the curriculum.',
    `delete from public.review_items where slug not in (${slugs.map((slug) => q(slug)).join(', ')});`,
  );
}

function emitStaleCleanup(): void {
  section('Remove content deleted from the curriculum');

  const levelSlugs: string[] = [];
  const moduleSlugs: string[] = [];
  const lessonSlugs: string[] = [];
  const exerciseSlugs: string[] = [];
  const questionSlugs: string[] = [];
  const assessmentSlugs: string[] = [];

  for (const level of COURSES.flatMap((c) => c.levels)) {
    levelSlugs.push(level.slug);
    if (level.assessment) {
      assessmentSlugs.push(level.assessment.slug);
      for (const question of level.assessment.questions) questionSlugs.push(question.slug);
    }
    for (const mod of level.modules) {
      moduleSlugs.push(mod.slug);
      for (const lesson of mod.lessons) {
        lessonSlugs.push(lesson.slug);
        for (const exercise of lesson.exercises) exerciseSlugs.push(exercise.slug);
        for (const question of lesson.quiz) questionSlugs.push(question.slug);
      }
    }
  }

  const notIn = (table: string, slugs: string[]) =>
    `delete from public.${table} where slug not in (${slugs.map((slug) => q(slug)).join(', ')});`;

  sql.push(
    notIn('quiz_questions', questionSlugs),
    notIn('exercises', exerciseSlugs),
    notIn('lessons', lessonSlugs),
    notIn('assessments', assessmentSlugs),
    notIn('modules', moduleSlugs),
    notIn('levels', levelSlugs),
  );
}

// ---------------------------------------------------------------------------

/**
 * Rewrites the expected counts inside the database health check.
 *
 * The check hard-codes how much content should be present, so that a
 * half-loaded seed fails loudly instead of looking fine. The cost of that
 * precision is that it goes stale every time a lesson is added — and a check
 * that is wrong after every authoring change is one people stop reading.
 *
 * Since the seed generator already knows every count, and the health check
 * exists to verify precisely this seed, it updates the numbers itself. Drift
 * becomes impossible rather than merely detectable. `curriculum.test.ts` still
 * asserts the two agree, which catches the case where this function is removed
 * or its patterns stop matching.
 */
async function syncHealthCheck(): Promise<void> {
  // Programme totals, not one course's. The database holds every course the
  // seed emits — including unpublished ones, which are seeded precisely so they
  // can be verified — so the health check must count all of them or it reports
  // a failure every time a course is being written.
  const programme = programmeStats();
  const lessons = allProgrammeLessons();

  const reviewQuestions = lessons.flatMap((lesson) => lesson.quiz).length;
  const reviewExercises = lessons
    .flatMap((lesson) => lesson.exercises)
    .filter((exercise) => exercise.kind !== 'project_mission').length;

  const replacements: [RegExp, string][] = [
    [/(\(select count\(\*\) from lessons\) = )\d+/, `$1${lessons.length}`],
    [/(\(select count\(\*\) from lesson_blocks\) = )\d+/, `$1${programme.blocks}`],
    [/(\(select count\(\*\) from quiz_questions\) = )\d+/, `$1${programme.quizQuestions}`],
    [/(\(select count\(\*\) from levels\) = )\d+/, `$1${programme.levels}`],
    [/(\(select count\(\*\) from modules\) = )\d+/, `$1${programme.modules}`],
    [/(\(select count\(\*\) from review_items\) = )\d+/, `$1${reviewQuestions + reviewExercises}`],
    [/(where kind = 'question'\) = )\d+/, `$1${reviewQuestions}`],
    [/(where kind = 'exercise'\) = )\d+/, `$1${reviewExercises}`],
    [/(\(select count\(\*\) from learning_media\) = )\d+/, `$1${MEDIA_ASSETS.length}`],
    [/'All \d+ levels and \d+ modules'/, `'All ${programme.levels} levels and ${programme.modules} modules'`],
  ];

  let sql = await readFile(HEALTH_CHECK, 'utf8');
  for (const [pattern, value] of replacements) {
    sql = sql.replace(pattern, value);
  }
  sql = sql.replace(
    /(\(select count\(\*\) from learning_media\)::text \|\| ' of )\d+'/,
    `$1${MEDIA_ASSETS.length}'`,
  );

  await writeFile(HEALTH_CHECK, sql, 'utf8');
}

async function main(): Promise<void> {
  validate();
  if (problems.length > 0) {
    console.error(`\n✗ The curriculum has ${problems.length} problem(s):\n`);
    for (const problem of problems) console.error(`    ${problem}`);
    console.error('');
    process.exit(1);
  }

  emitHeader();
  emitSkills();
  emitMedia();
  emitProjects();
  emitAchievements();
  emitCourses();
  emitLevels();
  emitStaleCleanup();
  emitReviewItems();

  sql.push('', 'commit;', '');
  await writeFile(OUT, sql.join('\n'), 'utf8');
  await syncHealthCheck();

  const lessons = allProgrammeLessons();
  const programme = programmeStats();

  console.log('✓ supabase/seed.sql written');

  // Reported per course as well as in total: an unpublished course contributes
  // rows to the seed and nothing to what a learner is shown, and conflating the
  // two is how a half-written course ends up quoted as a headline figure.
  for (const course of COURSES) {
    const s = courseStats(course);
    const state = course.isPublished ? 'published' : 'UNPUBLISHED';
    console.log(
      `  ${course.title} (${state}): ${s.levels} levels · ${s.modules} modules · ` +
        `${s.lessons} lessons · ${s.exercises} exercises · ${s.quizQuestions} questions`,
    );
  }
  console.log(
    `  programme total: ${programme.levels} levels · ${programme.lessons} lessons · ` +
      `${programme.blocks} blocks · ${programme.exercises} exercises`,
  );
  console.log(
    `  ${stats.reviewItems} reviewable items for spaced repetition`,
  );
  console.log(
    `  ${stats.retrievalBlocks} retrieval-practice blocks across ${stats.lessonsWithRetrieval} lesson(s)`,
  );
  console.log(
    `  ${MEDIA_ASSETS.length} media assets · ${ACHIEVEMENTS.length} achievements · ` +
      `${PROJECT_TEMPLATES.length} project templates`,
  );
  console.log(`  estimated learner time: ${totalCourseMinutes()} minutes (${(totalCourseMinutes() / 60).toFixed(1)} hours)`);
  console.log(`  ${sql.length} SQL statements`);

  // A courtesy check: warn about media the course never actually shows.
  const usedMedia = new Set<string>();
  for (const lesson of lessons) {
    for (const block of lesson.blocks) if (block.mediaSlug) usedMedia.add(block.mediaSlug);
  }
  const unused = MEDIA_ASSETS.filter(
    (m) => !usedMedia.has(m.slug) && m.kind !== 'icon' && !getMedia(m.slug)?.tags.includes('icon'),
  );
  if (unused.length > 0) {
    console.log(`  note: ${unused.length} media asset(s) are in the library but not shown in a lesson block`);
  }
}

main().catch((error: unknown) => {
  console.error(error);
  process.exit(1);
});
