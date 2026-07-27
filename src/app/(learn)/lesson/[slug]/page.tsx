import type { Metadata } from 'next';
import { notFound, redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { getLessonDetail } from '@/lib/data/catalogue';
import {
  getLessonProgress,
  getPassedExerciseIds,
  getProfile,
  getQuizAnswers,
  getSavedCode,
} from '@/lib/data/learner';
import {
  answerQuestionAction,
  completeLessonAction,
  evaluateExerciseAction,
  saveCodeAction,
  startLessonAction,
} from '@/lib/actions/progress';
import { LessonView } from '@/components/learn/lesson-view';
import type { QuestionKind } from '@/lib/supabase/database.types';

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const detail = await getLessonDetail(slug);
  if (!detail) return { title: 'Lesson not found' };

  return {
    title: detail.lesson.title,
    description: detail.lesson.summary,
    robots: { index: false, follow: false },
  };
}

/**
 * A lesson.
 *
 * Everything the browser receives is filtered server-side: reference solutions
 * only for exercises this learner has already passed, and quiz options with the
 * `is_correct` flag removed entirely. Grading happens in the server actions
 * passed down as props.
 */
export default async function LessonPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;

  const user = await getCurrentUser();
  if (!user) redirect(`/login?next=/lesson/${slug}`);

  const passedExerciseIds = await getPassedExerciseIds(user.id);
  const detail = await getLessonDetail(slug, passedExerciseIds);
  if (!detail) notFound();

  const exerciseIds = detail.exercises.map((e) => e.id);
  const questionIds = detail.questions.map((q) => q.id);

  const [savedCode, previousAnswers, progress, profile] = await Promise.all([
    getSavedCode(user.id, exerciseIds),
    getQuizAnswers(user.id, questionIds),
    getLessonProgress(user.id),
    getProfile(user.id),
  ]);

  // Records the visit so the dashboard can show the lesson as in progress.
  await startLessonAction(detail.lesson.id);

  const isCompleted =
    progress.find((p) => p.lesson_id === detail.lesson.id)?.status === 'completed';

  const theme = profile?.theme === 'dark' ? 'dark' : 'light';

  return (
    <LessonView
      lesson={{
        id: detail.lesson.id,
        slug: detail.lesson.slug,
        title: detail.lesson.title,
        subtitle: detail.lesson.subtitle,
        estimatedMinutes: detail.lesson.estimated_minutes,
        xpAward: detail.lesson.xp_award,
        objectives: detail.lesson.objectives,
      }}
      moduleTitle={detail.module.title}
      levelTitle={detail.level.title}
      levelSlug={detail.level.slug}
      blocks={detail.blocks}
      exercises={detail.exercises.map((exercise) => ({
        id: exercise.id,
        slug: exercise.slug,
        kind: exercise.kind,
        title: exercise.title,
        brief: exercise.brief,
        starterCode: exercise.starter_code,
        hints: exercise.hints,
        xpAward: exercise.xp_award,
        difficulty: exercise.difficulty,
        isOptional: exercise.is_optional,
        requirements: exercise.requirements.map((r) => ({ id: r.id, message: r.message })),
        referenceSolution: exercise.reference_solution,
      }))}
      questions={detail.questions.map((question) => ({
        id: question.id,
        prompt: question.prompt,
        kind: question.kind as QuestionKind,
        xpAward: question.xp_award,
        options: question.options.map((option) => ({ id: option.id, label: option.label })),
      }))}
      savedCode={savedCode}
      passedExerciseIds={passedExerciseIds.filter((id) => exerciseIds.includes(id))}
      previousAnswers={previousAnswers}
      isCompleted={isCompleted}
      next={detail.next}
      previous={detail.previous}
      theme={theme}
      onEvaluate={evaluateExerciseAction}
      onSaveCode={saveCodeAction}
      onAnswer={answerQuestionAction}
      onComplete={completeLessonAction}
    />
  );
}
