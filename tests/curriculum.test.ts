import { describe, expect, it } from 'vitest';
import { COURSE, LEVELS, allLessons, allModules, courseStats, totalCourseMinutes } from '@/content/course';
import { SKILLS } from '@/content/skills';
import { ACHIEVEMENTS } from '@/content/achievements';
import { PROJECT_TEMPLATES } from '@/content/projects';
import { MEDIA_ASSETS, allMediaPaths, getMedia } from '@/content/media/manifest';
import { evaluateSubmission } from '@/lib/evaluator/evaluate';
import type { Requirement } from '@/lib/evaluator/types';
import { orderedOptions, type RequirementSpec } from '@/content/types';

/**
 * Curriculum integrity.
 *
 * These are the tests that stop the course shipping broken: every reference
 * solution must actually pass its own requirements, every media path must
 * exist, every skill and prerequisite must resolve, and the recommended pace
 * must genuinely land near thirty days.
 */

const MEDIA_PATHS = new Set(allMediaPaths());
const SKILL_SLUGS = new Set(SKILLS.map((s) => s.slug));
const MODULE_SLUGS = new Set(allModules().map((m) => m.slug));

function toRequirement(spec: RequirementSpec, index: number): Requirement {
  return {
    id: `r${index}`,
    ordinal: index,
    kind: spec.kind,
    selector: spec.selector ?? null,
    attribute: spec.attribute ?? null,
    expectedValue: spec.expectedValue ?? null,
    ancestorSelector: spec.ancestorSelector ?? null,
    minCount: spec.minCount ?? null,
    maxCount: spec.maxCount ?? null,
    message: spec.message,
    hint: spec.hint ?? null,
    weight: spec.weight ?? 1,
    isCritical: spec.critical !== false,
  };
}

describe('course shape', () => {
  it('has twelve levels in a sensible order', () => {
    expect(LEVELS).toHaveLength(12);
    expect(LEVELS[0]?.slug).toBe('html-explorer');
    expect(LEVELS[11]?.slug).toBe('html-hero-capstone');
  });

  it('gives every level a unique slug, modules and an assessment', () => {
    const slugs = LEVELS.map((l) => l.slug);
    expect(new Set(slugs).size).toBe(slugs.length);

    for (const level of LEVELS) {
      expect(level.modules.length, `${level.slug} has modules`).toBeGreaterThan(0);
      expect(level.assessment, `${level.slug} has a milestone assessment`).toBeDefined();
      expect(level.outcome.length).toBeGreaterThan(20);
    }
  });

  it('gives every lesson the full teaching structure', () => {
    for (const lesson of allLessons()) {
      const types = lesson.blocks.map((b) => b.type);

      expect(types, `${lesson.slug} opens with objectives`).toContain('objectives');
      expect(types, `${lesson.slug} ends with a summary`).toContain('summary');
      expect(lesson.objectives.length, `${lesson.slug} lists objectives`).toBeGreaterThanOrEqual(2);
      expect(lesson.blocks.length, `${lesson.slug} has real content`).toBeGreaterThanOrEqual(6);
      expect(lesson.exercises.length, `${lesson.slug} has exercises`).toBeGreaterThan(0);
      expect(lesson.estimatedMinutes).toBeGreaterThan(0);
    }
  });

  it('includes worked examples and practice in every lesson', () => {
    for (const lesson of allLessons()) {
      const types = new Set(lesson.blocks.map((b) => b.type));
      const hasExample = ['code_example', 'annotated_code', 'comparison', 'interactive_demo', 'media_example']
        .some((t) => types.has(t as never));
      expect(hasExample, `${lesson.slug} shows a code example`).toBe(true);
    }
  });

  it('covers every module with at least one debugging challenge across its lessons', () => {
    for (const level of LEVELS) {
      const kinds = level.modules
        .flatMap((m) => m.lessons)
        .flatMap((l) => l.exercises)
        .map((e) => e.kind);
      expect(kinds, `${level.slug} includes a debugging challenge`).toContain('debug');
    }
  });

  it('builds the capstone progressively rather than at the end', () => {
    const missions = allLessons()
      .flatMap((l) => l.exercises)
      .filter((e) => e.kind === 'project_mission');
    expect(missions.length).toBeGreaterThanOrEqual(10);

    // Missions must start early — the project is not a final-level bolt-on.
    const firstLevelMissions = LEVELS[0]?.modules
      .flatMap((m) => m.lessons)
      .flatMap((l) => l.exercises)
      .filter((e) => e.kind === 'project_mission');
    expect(firstLevelMissions?.length).toBeGreaterThan(0);
  });

  it('keeps every slug unique across the whole course', () => {
    const lessonSlugs = allLessons().map((l) => l.slug);
    const exerciseSlugs = allLessons().flatMap((l) => l.exercises.map((e) => e.slug));
    const questionSlugs = [
      ...allLessons().flatMap((l) => l.quiz.map((q) => q.slug)),
      ...LEVELS.flatMap((l) => l.assessment?.questions.map((q) => q.slug) ?? []),
    ];

    expect(new Set(lessonSlugs).size).toBe(lessonSlugs.length);
    expect(new Set(exerciseSlugs).size).toBe(exerciseSlugs.length);
    expect(new Set(questionSlugs).size).toBe(questionSlugs.length);
  });
});

describe('reference solutions pass their own requirements', () => {
  const exercises = allLessons().flatMap((lesson) =>
    lesson.exercises.map((exercise) => ({ lesson: lesson.slug, exercise })),
  );

  it.each(exercises.map((e) => [e.exercise.slug, e] as const))(
    '%s',
    (_slug, { exercise, lesson }) => {
      const result = evaluateSubmission(
        exercise.referenceSolution,
        exercise.requirements.map(toRequirement),
      );

      const failures = result.results
        .filter((r) => !r.passed)
        .map((r) => `${r.message} — ${r.detail}`);
      const blocking = result.issues.filter((i) => i.severity === 'error').map((i) => i.message);

      expect(
        failures,
        `${lesson}/${exercise.slug} reference solution fails its own requirements`,
      ).toEqual([]);
      expect(blocking, `${lesson}/${exercise.slug} reference solution has source errors`).toEqual([]);
      expect(result.passed).toBe(true);
    },
  );
});

describe('starter code does not accidentally already pass', () => {
  const withStarters = allLessons()
    .flatMap((lesson) => lesson.exercises)
    .filter((exercise) => (exercise.starterCode ?? '').trim().length > 0);

  it.each(withStarters.map((e) => [e.slug, e] as const))('%s still has work to do', (_slug, exercise) => {
    const result = evaluateSubmission(
      exercise.starterCode ?? '',
      exercise.requirements.map(toRequirement),
    );
    expect(result.passed, `${exercise.slug} starter code already passes — the task is a no-op`).toBe(
      false,
    );
  });
});

describe('media references', () => {
  it('resolves every media slug a lesson block asks for', () => {
    for (const lesson of allLessons()) {
      for (const block of lesson.blocks) {
        if (!block.mediaSlug) continue;
        expect(getMedia(block.mediaSlug), `${lesson.slug} → ${block.mediaSlug}`).toBeDefined();
      }
    }
  });

  it('resolves every media path used by a reference solution', () => {
    const pattern = /["'\s(](\/learning-media\/[A-Za-z0-9._/-]+)/g;
    for (const lesson of allLessons()) {
      for (const exercise of lesson.exercises) {
        for (const match of exercise.referenceSolution.matchAll(pattern)) {
          const path = match[1] ?? '';
          expect(MEDIA_PATHS.has(path), `${exercise.slug} → ${path}`).toBe(true);
        }
      }
    }
  });

  it('resolves every project template hero image', () => {
    for (const template of PROJECT_TEMPLATES) {
      expect(getMedia(template.heroMediaSlug), template.slug).toBeDefined();
    }
  });

  it('gives every video a poster and captions', () => {
    const videos = MEDIA_ASSETS.filter((a) => a.kind === 'video');
    expect(videos.length).toBeGreaterThanOrEqual(2);
    for (const video of videos) {
      expect(video.posterPath, `${video.slug} poster`).toBeTruthy();
      expect(video.captionsPath, `${video.slug} captions`).toBeTruthy();
      expect(video.formats.length, `${video.slug} formats`).toBeGreaterThanOrEqual(2);
    }
  });

  it('ships at least two audio clips with multiple formats', () => {
    const audio = MEDIA_ASSETS.filter((a) => a.kind === 'audio');
    expect(audio.length).toBeGreaterThanOrEqual(2);
    for (const clip of audio) {
      expect(clip.formats.length).toBeGreaterThanOrEqual(2);
    }
  });

  it('offers responsive widths for every photographic scene', () => {
    for (const asset of MEDIA_ASSETS.filter((a) => a.kind === 'photo')) {
      expect(asset.srcset.length, `${asset.slug} srcset`).toBeGreaterThanOrEqual(4);
      expect(asset.formats.some((f) => f.type === 'image/webp'), `${asset.slug} webp`).toBe(true);
    }
  });

  it('documents a licence and creator for every asset', () => {
    for (const asset of MEDIA_ASSETS) {
      expect(asset.attribution.licence, asset.slug).toContain('CC0');
      expect(asset.attribution.creator.length, asset.slug).toBeGreaterThan(0);
      expect(asset.attribution.localPath, asset.slug).toMatch(/^\/learning-media\//);
      expect(asset.attribution.retrievedOn, asset.slug).toMatch(/^\d{4}-\d{2}-\d{2}$/);
    }
  });

  it('gives every informative image suggested alt text', () => {
    for (const asset of MEDIA_ASSETS) {
      if (asset.isDecorativeExample || asset.kind === 'audio') continue;
      expect(asset.suggestedAlt.length, `${asset.slug} needs suggested alt text`).toBeGreaterThan(10);
    }
  });
});

describe('skills and gating', () => {
  it('resolves every skill reference', () => {
    for (const lesson of allLessons()) {
      expect(SKILL_SLUGS.has(lesson.skill), `${lesson.slug} → ${lesson.skill}`).toBe(true);
      for (const exercise of lesson.exercises) {
        if (exercise.skill) {
          expect(SKILL_SLUGS.has(exercise.skill), `${exercise.slug} → ${exercise.skill}`).toBe(true);
        }
      }
    }
    for (const mod of allModules()) {
      for (const skill of mod.skills) {
        expect(SKILL_SLUGS.has(skill.slug), `${mod.slug} → ${skill.slug}`).toBe(true);
      }
    }
  });

  it('resolves every module prerequisite', () => {
    for (const mod of allModules()) {
      for (const prerequisite of mod.prerequisites ?? []) {
        expect(MODULE_SLUGS.has(prerequisite), `${mod.slug} → ${prerequisite}`).toBe(true);
      }
    }
  });

  it('has no cycles in the skill prerequisite graph', () => {
    const bySlug = new Map(SKILLS.map((s) => [s.slug, s]));
    const state = new Map<string, 'visiting' | 'done'>();

    const visit = (slug: string, path: string[]): void => {
      if (state.get(slug) === 'done') return;
      expect(state.get(slug), `cycle: ${[...path, slug].join(' → ')}`).not.toBe('visiting');
      state.set(slug, 'visiting');
      for (const prerequisite of bySlug.get(slug)?.prerequisites ?? []) {
        visit(prerequisite, [...path, slug]);
      }
      state.set(slug, 'done');
    };

    for (const skill of SKILLS) visit(skill.slug, []);
  });

  it('has no cycles in the module prerequisite graph', () => {
    const bySlug = new Map(allModules().map((m) => [m.slug, m]));
    const state = new Map<string, 'visiting' | 'done'>();

    const visit = (slug: string, path: string[]): void => {
      if (state.get(slug) === 'done') return;
      expect(state.get(slug), `cycle: ${[...path, slug].join(' → ')}`).not.toBe('visiting');
      state.set(slug, 'visiting');
      for (const prerequisite of bySlug.get(slug)?.prerequisites ?? []) {
        visit(prerequisite, [...path, slug]);
      }
      state.set(slug, 'done');
    };

    for (const mod of allModules()) visit(mod.slug, []);
  });

  it('leaves the first module of the course unlocked', () => {
    const first = allModules()[0];
    expect(first?.prerequisites ?? []).toHaveLength(0);
    expect(first?.skills.every((s) => (s.masteryRequired ?? 0) === 0)).toBe(true);
  });

  it('covers every declared skill somewhere in the course', () => {
    const taught = new Set(allLessons().map((l) => l.skill));
    for (const mod of allModules()) {
      for (const skill of mod.skills) taught.add(skill.slug);
    }
    for (const skill of SKILLS) {
      expect(taught.has(skill.slug), `${skill.slug} is never taught`).toBe(true);
    }
  });
});

describe('quizzes', () => {
  const questions = [
    ...allLessons().flatMap((l) => l.quiz),
    ...LEVELS.flatMap((l) => l.assessment?.questions ?? []),
  ];

  it('gives every question exactly one correct answer unless it is multi-select', () => {
    for (const question of questions) {
      const correct = question.options.filter((o) => o.correct).length;
      expect(correct, `${question.slug} has a correct answer`).toBeGreaterThan(0);
      if (question.kind !== 'multi') {
        expect(correct, `${question.slug} has exactly one correct answer`).toBe(1);
      }
    }
  });

  it('gives every question at least three options and an explanation', () => {
    for (const question of questions) {
      expect(question.options.length, question.slug).toBeGreaterThanOrEqual(2);
      expect(question.explanation.length, `${question.slug} explains the answer`).toBeGreaterThan(20);
    }
  });

  it('varies where the correct answer appears, so position cannot be guessed', () => {
    const positions = questions.map((q) => orderedOptions(q).findIndex((o) => o.correct));
    const distinct = new Set(positions);

    // At least three different positions used, and no single position holding
    // more than half the answers.
    expect(distinct.size).toBeGreaterThanOrEqual(3);
    for (const position of distinct) {
      const share = positions.filter((p) => p === position).length / positions.length;
      expect(share, `position ${position} holds ${Math.round(share * 100)}% of answers`).toBeLessThan(0.5);
    }
  });

  it('keeps the rotation stable across calls, so stored answers stay valid', () => {
    for (const question of questions.slice(0, 20)) {
      expect(orderedOptions(question).map((o) => o.label)).toEqual(
        orderedOptions(question).map((o) => o.label),
      );
    }
  });
});

describe('achievements and projects', () => {
  it('gives every achievement a unique slug, criteria and XP', () => {
    const slugs = ACHIEVEMENTS.map((a) => a.slug);
    expect(new Set(slugs).size).toBe(slugs.length);
    for (const achievement of ACHIEVEMENTS) {
      expect(achievement.criteria.type, achievement.slug).toBeTruthy();
      expect(achievement.xp, achievement.slug).toBeGreaterThan(0);
    }
  });

  it('references only real levels, modules and skills in achievement criteria', () => {
    const levelSlugs = new Set(LEVELS.map((l) => l.slug));
    for (const achievement of ACHIEVEMENTS) {
      const criteria = achievement.criteria as Record<string, unknown>;
      if (typeof criteria.levelSlug === 'string') {
        expect(levelSlugs.has(criteria.levelSlug), achievement.slug).toBe(true);
      }
      if (typeof criteria.moduleSlug === 'string') {
        expect(MODULE_SLUGS.has(criteria.moduleSlug), achievement.slug).toBe(true);
      }
      if (typeof criteria.skillSlug === 'string') {
        expect(SKILL_SLUGS.has(criteria.skillSlug), achievement.slug).toBe(true);
      }
    }
  });

  it('offers every project type named in the brief, each with five pages', () => {
    const slugs = PROJECT_TEMPLATES.map((t) => t.slug);
    for (const expected of [
      'personal-portfolio',
      'small-business',
      'local-service',
      'restaurant',
      'hobby-site',
      'vehicle-rental',
      'product-showcase',
      'news-magazine',
      'event-site',
      'custom',
    ]) {
      expect(slugs, `${expected} project type`).toContain(expected);
    }

    for (const template of PROJECT_TEMPLATES) {
      expect(template.pagePlan.length, template.slug).toBeGreaterThanOrEqual(5);
      expect(template.pagePlan.some((p) => p.path === 'index.html'), template.slug).toBe(true);
    }
  });
});

describe('recommended pace', () => {
  it('lands near thirty days at the stated 45–75 minutes a day', () => {
    const minutes = totalCourseMinutes();
    const perDay = minutes / COURSE.recommendedDays;
    expect(perDay).toBeGreaterThanOrEqual(45);
    expect(perDay).toBeLessThanOrEqual(75);
  });

  it('reports statistics that match the content', () => {
    const stats = courseStats();
    expect(stats.levels).toBe(LEVELS.length);
    expect(stats.lessons).toBe(allLessons().length);
    expect(stats.exercises).toBeGreaterThan(50);
    expect(stats.debugChallenges).toBeGreaterThan(10);
    expect(stats.quizQuestions).toBeGreaterThan(100);
  });
});
