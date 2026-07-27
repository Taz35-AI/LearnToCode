import 'server-only';
import { createClient } from '@/lib/supabase/server';
import { applyEvidence, EMPTY_MASTERY, type EvidenceKind } from '@/lib/progress/mastery';
import type { MasteryState } from '@/lib/supabase/database.types';

/**
 * Records one piece of evidence against a skill.
 *
 * This lives here rather than in an action file on purpose. Every export of a
 * `'use server'` module becomes an endpoint the browser can call, and a
 * function that writes mastery directly is precisely what must not be one —
 * it would let a client set its own skill levels and unlock modules without
 * answering anything. Keeping it in a `server-only` module means both the
 * lesson actions and the review actions can share it while it stays
 * unreachable from the client.
 */
export async function recordMasteryEvidence(
  userId: string,
  skillId: string | null,
  kind: EvidenceKind,
  score: number,
  hintsUsed = 0,
  priorAttempts = 0,
): Promise<void> {
  if (!skillId) return;
  const supabase = await createClient();

  const { data: existing } = await supabase
    .from('user_skill_mastery')
    .select('*')
    .eq('user_id', userId)
    .eq('skill_id', skillId)
    .maybeSingle();

  const current = existing
    ? {
        mastery: Number(existing.mastery),
        evidenceCount: existing.evidence_count,
        correctCount: existing.correct_count,
        state: existing.state,
        needsPractice: existing.needs_practice,
      }
    : EMPTY_MASTERY;

  const updated = applyEvidence(current, { kind, score, hintsUsed, priorAttempts });

  const row = {
    user_id: userId,
    skill_id: skillId,
    mastery: updated.mastery,
    state: updated.state as MasteryState,
    evidence_count: updated.evidenceCount,
    correct_count: updated.correctCount,
    needs_practice: updated.needsPractice,
    last_practised_at: new Date().toISOString(),
  };

  if (existing) {
    await supabase.from('user_skill_mastery').update(row).eq('id', existing.id);
  } else {
    await supabase.from('user_skill_mastery').insert(row);
  }
}
