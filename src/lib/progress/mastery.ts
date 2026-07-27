import type { MasteryState } from '@/lib/supabase/database.types';

/**
 * Skill mastery.
 *
 * Mastery is an exponentially weighted moving average over evidence, so recent
 * work counts for more than something answered three weeks ago. Evidence comes
 * from three places, weighted by how much each really proves:
 *
 *   · a coding exercise      — strongest signal, weight 1.0
 *   · a debugging challenge  — strong, weight 0.9
 *   · a knowledge check      — weaker on its own, weight 0.5
 *
 * A skill is only *mastered* when the score is high AND there is enough
 * evidence behind it. One lucky multiple-choice answer never masters a skill.
 */

export const MASTERY_THRESHOLDS = {
  /** Below this, the skill is actively flagged for extra practice. */
  needsPractice: 0.5,
  proficient: 0.7,
  mastered: 0.8,
} as const;

/** A skill needs at least this much evidence before it can be called mastered. */
export const MIN_EVIDENCE_FOR_MASTERY = 3;

export type EvidenceKind = 'exercise' | 'debug' | 'quiz' | 'assessment' | 'project';

const EVIDENCE_WEIGHT: Record<EvidenceKind, number> = {
  exercise: 1.0,
  debug: 0.9,
  assessment: 1.0,
  project: 0.8,
  quiz: 0.5,
};

/** How quickly new evidence displaces old. Higher = more responsive. */
const LEARNING_RATE = 0.4;

export interface Evidence {
  kind: EvidenceKind;
  /** 0–1. For an exercise this is the weighted requirement score. */
  score: number;
  /** Hints reduce how much a success proves. */
  hintsUsed?: number;
  /** Failed attempts before this result. */
  priorAttempts?: number;
}

export interface MasteryRecord {
  mastery: number;
  evidenceCount: number;
  correctCount: number;
  state: MasteryState;
  needsPractice: boolean;
}

export const EMPTY_MASTERY: MasteryRecord = {
  mastery: 0,
  evidenceCount: 0,
  correctCount: 0,
  state: 'untouched',
  needsPractice: false,
};

/**
 * Discounts a score by the help the learner needed to reach it. Someone who
 * passes after four hints has demonstrably less command of the skill than
 * someone who passed cold — but they have still demonstrated something.
 */
function effectiveScore(evidence: Evidence): number {
  const hints = Math.max(0, evidence.hintsUsed ?? 0);
  const retries = Math.max(0, evidence.priorAttempts ?? 0);
  const hintFactor = Math.max(0.55, 1 - hints * 0.12);
  const retryFactor = Math.max(0.7, 1 - retries * 0.06);
  return clamp01(evidence.score * hintFactor * retryFactor);
}

export function applyEvidence(current: MasteryRecord, evidence: Evidence): MasteryRecord {
  const weight = EVIDENCE_WEIGHT[evidence.kind] ?? 0.5;
  const score = effectiveScore(evidence);
  const rate = LEARNING_RATE * weight;

  // The first piece of evidence for an untouched skill sets the baseline
  // directly; without this a strong first attempt would still read as 0.4.
  const mastery =
    current.evidenceCount === 0 ? score : clamp01(current.mastery + rate * (score - current.mastery));

  const evidenceCount = current.evidenceCount + 1;
  const correctCount = current.correctCount + (evidence.score >= 0.999 ? 1 : 0);

  return {
    mastery: round3(mastery),
    evidenceCount,
    correctCount,
    state: masteryState(mastery, evidenceCount),
    needsPractice: mastery < MASTERY_THRESHOLDS.needsPractice && evidenceCount > 0,
  };
}

export function masteryState(mastery: number, evidenceCount: number): MasteryState {
  if (evidenceCount === 0) return 'untouched';
  if (mastery >= MASTERY_THRESHOLDS.mastered && evidenceCount >= MIN_EVIDENCE_FOR_MASTERY) {
    return 'mastered';
  }
  if (mastery >= MASTERY_THRESHOLDS.proficient) return 'proficient';
  if (mastery >= MASTERY_THRESHOLDS.needsPractice) return 'practising';
  return 'learning';
}

export function isMastered(record: Pick<MasteryRecord, 'mastery' | 'evidenceCount'>): boolean {
  return (
    record.mastery >= MASTERY_THRESHOLDS.mastered &&
    record.evidenceCount >= MIN_EVIDENCE_FOR_MASTERY
  );
}

/**
 * Decays mastery for a skill not practised recently.
 *
 * This is deliberately gentle — it exists to bring a rusty skill back into the
 * practice queue, not to punish a learner for taking a week off. A skill loses
 * at most 15% of its score however long it is left.
 */
export function decayMastery(record: MasteryRecord, daysSincePractice: number): MasteryRecord {
  if (daysSincePractice <= 14 || record.evidenceCount === 0) return record;
  const weeksOver = (daysSincePractice - 14) / 7;
  const decayed = Math.max(record.mastery * 0.85, record.mastery - 0.02 * weeksOver);
  return {
    ...record,
    mastery: round3(decayed),
    state: masteryState(decayed, record.evidenceCount),
    needsPractice: decayed < MASTERY_THRESHOLDS.needsPractice,
  };
}

// ---------------------------------------------------------------------------
// Unlocking
// ---------------------------------------------------------------------------

export interface ModuleGate {
  moduleId: string;
  prerequisiteModuleIds: string[];
  /** Skills that must reach a given mastery before this module opens. */
  requiredSkills: { skillId: string; masteryRequired: number }[];
}

export interface UnlockContext {
  /** Module ids whose lessons are all complete. */
  completedModuleIds: ReadonlySet<string>;
  /** Current mastery per skill id. */
  masteryBySkill: ReadonlyMap<string, number>;
}

export interface UnlockVerdict {
  unlocked: boolean;
  /** Beginner-readable reasons the module is still closed. */
  blockedBy: string[];
}

/**
 * Decides whether a module is open.
 *
 * Time is deliberately absent from this function. A module opens because the
 * learner has demonstrated the prerequisite skills, and for no other reason.
 */
export function evaluateModuleGate(
  gate: ModuleGate,
  context: UnlockContext,
  skillNames: ReadonlyMap<string, string> = new Map(),
  moduleNames: ReadonlyMap<string, string> = new Map(),
): UnlockVerdict {
  const blockedBy: string[] = [];

  for (const moduleId of gate.prerequisiteModuleIds) {
    if (!context.completedModuleIds.has(moduleId)) {
      blockedBy.push(`Finish "${moduleNames.get(moduleId) ?? 'the previous module'}" first`);
    }
  }

  for (const requirement of gate.requiredSkills) {
    if (requirement.masteryRequired <= 0) continue;
    const current = context.masteryBySkill.get(requirement.skillId) ?? 0;
    if (current < requirement.masteryRequired) {
      const name = skillNames.get(requirement.skillId) ?? 'a required skill';
      blockedBy.push(
        `Reach ${Math.round(requirement.masteryRequired * 100)}% mastery in ${name} ` +
          `(currently ${Math.round(current * 100)}%)`,
      );
    }
  }

  return { unlocked: blockedBy.length === 0, blockedBy };
}

// ---------------------------------------------------------------------------
// Adaptive practice
// ---------------------------------------------------------------------------

export interface PracticeCandidate {
  skillId: string;
  skillName: string;
  mastery: number;
  evidenceCount: number;
  daysSincePractice: number;
}

export interface PracticeRecommendation extends PracticeCandidate {
  /** Higher is more urgent. */
  priority: number;
  reason: string;
}

/**
 * Ranks which skills the learner should revisit.
 *
 * Weakness dominates, but staleness matters too: a skill at 0.62 untouched for
 * a month is a better use of ten minutes than a skill at 0.55 practised
 * yesterday, because the learner has already had a recent go at the latter.
 */
export function recommendPractice(
  candidates: PracticeCandidate[],
  limit = 5,
): PracticeRecommendation[] {
  return candidates
    .filter((c) => c.evidenceCount > 0 && c.mastery < MASTERY_THRESHOLDS.mastered)
    .map((c) => {
      const weakness = 1 - c.mastery;
      const staleness = Math.min(1, c.daysSincePractice / 21);
      const thinEvidence = c.evidenceCount < MIN_EVIDENCE_FOR_MASTERY ? 0.15 : 0;
      const priority = round3(weakness * 0.65 + staleness * 0.2 + thinEvidence);

      const reason =
        c.mastery < MASTERY_THRESHOLDS.needsPractice
          ? 'This one is still shaky — a short focused practice will help.'
          : c.daysSincePractice > 14
            ? "You haven't used this in a while. A quick refresher keeps it sharp."
            : 'Almost mastered. One more solid attempt should do it.';

      return { ...c, priority, reason };
    })
    .sort((a, b) => b.priority - a.priority)
    .slice(0, limit);
}

/**
 * Chooses the difficulty of the next exercise for a skill.
 *
 * A struggling learner is offered something easier rather than the same wall
 * again; a confident learner is offered a real-world edge case.
 */
export function nextDifficulty(mastery: number, evidenceCount: number): 1 | 2 | 3 | 4 | 5 {
  if (evidenceCount === 0) return 1;
  if (mastery < 0.35) return 1;
  if (mastery < MASTERY_THRESHOLDS.needsPractice) return 2;
  if (mastery < MASTERY_THRESHOLDS.proficient) return 3;
  if (mastery < MASTERY_THRESHOLDS.mastered) return 4;
  return 5;
}

/** True when the learner is doing well enough to be offered optional stretch work. */
export function shouldOfferStretch(mastery: number, evidenceCount: number): boolean {
  return mastery >= MASTERY_THRESHOLDS.mastered && evidenceCount >= MIN_EVIDENCE_FOR_MASTERY;
}

function clamp01(value: number): number {
  if (Number.isNaN(value)) return 0;
  return Math.min(1, Math.max(0, value));
}

function round3(value: number): number {
  return Math.round(value * 1000) / 1000;
}
