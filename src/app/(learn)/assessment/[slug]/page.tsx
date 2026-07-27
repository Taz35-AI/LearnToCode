import type { Metadata } from 'next';
import { notFound, redirect } from 'next/navigation';
import { createClient, getCurrentUser } from '@/lib/supabase/server';
import { getAssessment } from '@/lib/data/catalogue';
import { submitAssessmentAction } from '@/lib/actions/progress';
import { AssessmentView } from '@/components/learn/assessment-view';
import type { QuestionKind } from '@/lib/supabase/database.types';

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const loaded = await getAssessment(slug);
  return {
    title: loaded?.assessment.title ?? 'Assessment',
    robots: { index: false, follow: false },
  };
}

export default async function AssessmentPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;

  const user = await getCurrentUser();
  if (!user) redirect(`/login?next=/assessment/${slug}`);

  const loaded = await getAssessment(slug);
  if (!loaded) notFound();

  const supabase = await createClient();
  const { data: attempts } = await supabase
    .from('assessment_attempts')
    .select('score')
    .eq('user_id', user.id)
    .eq('assessment_id', loaded.assessment.id)
    .order('score', { ascending: false })
    .limit(1);

  return (
    <AssessmentView
      assessment={{
        id: loaded.assessment.id,
        title: loaded.assessment.title,
        description: loaded.assessment.description,
        passScore: Number(loaded.assessment.pass_score),
        xpAward: loaded.assessment.xp_award,
      }}
      questions={loaded.questions.map((question) => ({
        id: question.id,
        prompt: question.prompt,
        kind: question.kind as QuestionKind,
        options: question.options.map((option) => ({ id: option.id, label: option.label })),
      }))}
      bestScore={attempts?.[0] ? Number(attempts[0].score) : null}
      onSubmit={submitAssessmentAction}
    />
  );
}
