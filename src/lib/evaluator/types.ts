import type { ExerciseRequirementRow, RequirementKind } from '@/lib/supabase/database.types';

/**
 * A single structural rule an exercise checks.
 *
 * Requirements describe *shape*, never exact text, so a learner may write
 * "About our bakery" where the reference solution says "About us" and still
 * pass — as long as the structure is right.
 */
export interface Requirement {
  id: string;
  ordinal: number;
  kind: RequirementKind;
  /** A CSS-style selector, e.g. `main`, `img[alt]`, `nav a`. */
  selector: string | null;
  attribute: string | null;
  expectedValue: string | null;
  /** For `nesting` / `direct_child`: the element the selector must sit inside. */
  ancestorSelector: string | null;
  minCount: number | null;
  maxCount: number | null;
  /** Beginner-readable statement of what is being asked for. */
  message: string;
  /** Shown when the requirement fails, to nudge without giving the answer. */
  hint: string | null;
  weight: number;
  /** A non-critical requirement can fail without failing the whole exercise. */
  isCritical: boolean;
}

/**
 * Turns a stored requirement row into the shape the evaluator grades against.
 *
 * Shared because two callers grade the same exercises: the lesson page and the
 * review queue. Two copies of this mapping would be two chances for a review to
 * grade an exercise by slightly different rules than the lesson did, and a
 * learner who passes an exercise and then fails its review on identical markup
 * would rightly conclude the checker is arbitrary.
 */
export function requirementFromRow(row: ExerciseRequirementRow): Requirement {
  return {
    id: row.id,
    ordinal: row.ordinal,
    kind: row.kind,
    selector: row.selector,
    attribute: row.attribute,
    expectedValue: row.expected_value,
    ancestorSelector: row.ancestor_selector,
    minCount: row.min_count,
    maxCount: row.max_count,
    message: row.message,
    hint: row.hint,
    weight: Number(row.weight),
    isCritical: row.is_critical,
  };
}

export interface RequirementResult {
  requirementId: string;
  kind: RequirementKind;
  passed: boolean;
  message: string;
  /** What the evaluator actually found, phrased for a beginner. */
  detail: string;
  hint: string | null;
  isCritical: boolean;
  weight: number;
}

export interface EvaluationIssue {
  severity: 'error' | 'warning';
  /** A short machine-readable code, e.g. `duplicate-id`, `unclosed-tag`. */
  code: string;
  message: string;
  line?: number;
}

export interface EvaluationResult {
  passed: boolean;
  /** Weighted proportion of requirements satisfied, 0–1. */
  score: number;
  results: RequirementResult[];
  /** Problems found regardless of the exercise's own requirements. */
  issues: EvaluationIssue[];
  /** A single encouraging or corrective sentence for the results panel. */
  summary: string;
}
