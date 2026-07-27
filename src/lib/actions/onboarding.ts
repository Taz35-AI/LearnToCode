'use server';

import { redirect } from 'next/navigation';
import { revalidatePath } from 'next/cache';
import { createClient, getCurrentUser } from '@/lib/supabase/server';
import { getCourse, getProjectTemplates } from '@/lib/data/catalogue';
import { recommendPace, addDays, isoDate } from '@/lib/progress/pace';
import { totalCourseMinutes, allLessons } from '@/content/course';
import { isSubstantialPage } from '@/lib/project/checklist';
import {
  fieldErrors,
  onboardingSchema,
  saveProjectFileSchema,
  updateSettingsSchema,
  type ActionResult,
} from './schemas';
import type { Json } from '@/lib/supabase/database.types';

/**
 * Onboarding and settings.
 *
 * Onboarding produces two things: a personalised learning plan, and the
 * learner's capstone project seeded with the page plan for the type they chose.
 * From that point the project is theirs — every module mission adds to it.
 */

interface PagePlanEntry {
  path: string;
  title: string;
  purpose: string;
}

function parsePagePlan(value: Json): PagePlanEntry[] {
  if (!Array.isArray(value)) return [];
  return value.flatMap((entry) => {
    if (typeof entry !== 'object' || entry === null || Array.isArray(entry)) return [];
    const record = entry as Record<string, unknown>;
    const path = typeof record.path === 'string' ? record.path : null;
    const title = typeof record.title === 'string' ? record.title : null;
    const purpose = typeof record.purpose === 'string' ? record.purpose : '';
    return path && title ? [{ path, title, purpose }] : [];
  });
}

/** The starter document every seeded project page begins with. */
function starterPage(title: string, siteName: string, purpose: string): string {
  return `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${title} — ${siteName}</title>
    <meta name="description" content="${purpose}">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>

    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
        </ul>
      </nav>
    </header>

    <main id="main">
      <h1>${title}</h1>
      <p>${purpose}</p>
      <!-- Each module mission adds a real piece to this page. -->
    </main>

    <footer>
      <p>&copy; 2026 ${siteName}</p>
    </footer>
  </body>
</html>
`;
}

export async function completeOnboardingAction(
  _previous: ActionResult | null,
  formData: FormData,
): Promise<ActionResult> {
  const user = await getCurrentUser();
  if (!user) redirect('/login');

  const parsed = onboardingSchema.safeParse({
    displayName: formData.get('displayName'),
    minutesPerDay: formData.get('minutesPerDay'),
    studyDays: formData.getAll('studyDays'),
    experience: formData.get('experience'),
    targetCompletionDate: formData.get('targetCompletionDate') || undefined,
    projectTemplateSlug: formData.get('projectTemplateSlug'),
  });

  if (!parsed.success) {
    return { ok: false, errors: fieldErrors(parsed.error), message: 'Please check the highlighted answers.' };
  }

  const supabase = await createClient();
  const course = await getCourse();
  if (!course) {
    return {
      ok: false,
      message:
        'The course has not been seeded yet. Run the database migrations and `npm run seed:generate`, then load supabase/seed.sql.',
    };
  }

  const templates = await getProjectTemplates();
  const template = templates.find((t) => t.slug === parsed.data.projectTemplateSlug);
  if (!template) {
    return { ok: false, errors: { projectTemplateSlug: 'Choose one of the listed projects' } };
  }

  const target = parsed.data.targetCompletionDate
    ? new Date(parsed.data.targetCompletionDate)
    : null;

  const pace = recommendPace(
    {
      minutesPerDay: parsed.data.minutesPerDay,
      studyDays: parsed.data.studyDays,
      totalCourseMinutes: totalCourseMinutes(),
      targetCompletionDate: target,
    },
    allLessons().length,
  );

  await supabase
    .from('profiles')
    .update({ display_name: parsed.data.displayName, onboarding_completed_at: new Date().toISOString() })
    .eq('id', user.id);

  // Retire any previous plan so the partial unique index stays satisfied.
  await supabase
    .from('learning_plans')
    .update({ is_active: false })
    .eq('user_id', user.id)
    .eq('is_active', true);

  const { error: planError } = await supabase.from('learning_plans').insert({
    user_id: user.id,
    course_id: course.id,
    minutes_per_day: parsed.data.minutesPerDay,
    study_days: parsed.data.studyDays,
    target_completion_date: target ? isoDate(target) : null,
    experience: parsed.data.experience,
    project_template_id: template.id,
    recommended_lessons_per_week: pace.lessonsPerWeek,
    estimated_completion_date: isoDate(addDays(new Date(), pace.estimatedDays)),
    started_on: isoDate(new Date()),
    is_active: true,
  });

  if (planError) {
    return { ok: false, message: 'We could not save your plan. Please try again.' };
  }

  // Seed the capstone project with the page plan for the chosen type.
  const siteName = `${parsed.data.displayName}'s ${template.name.toLowerCase()}`;
  const { data: project } = await supabase
    .from('user_projects')
    .insert({
      user_id: user.id,
      project_template_id: template.id,
      name: siteName,
      description: template.tagline,
      status: 'in_progress',
      completion_percent: 0,
    })
    .select()
    .maybeSingle();

  if (project) {
    const pages = parsePagePlan(template.page_plan);
    for (const page of pages) {
      await supabase.from('project_files').insert({
        project_id: project.id,
        user_id: user.id,
        path: page.path,
        kind: 'html',
        content: starterPage(page.title, siteName, page.purpose),
      });
    }
  }

  revalidatePath('/', 'layout');
  redirect('/dashboard?welcome=1');
}

export async function updateSettingsAction(
  _previous: ActionResult | null,
  formData: FormData,
): Promise<ActionResult> {
  const user = await getCurrentUser();
  if (!user) redirect('/login');

  const parsed = updateSettingsSchema.safeParse({
    displayName: formData.get('displayName'),
    theme: formData.get('theme'),
    reducedMotion: formData.get('reducedMotion') === 'on',
    minutesPerDay: formData.get('minutesPerDay'),
    studyDays: formData.getAll('studyDays'),
    targetCompletionDate: formData.get('targetCompletionDate') || undefined,
  });

  if (!parsed.success) {
    return { ok: false, errors: fieldErrors(parsed.error) };
  }

  const supabase = await createClient();

  await supabase
    .from('profiles')
    .update({
      display_name: parsed.data.displayName,
      theme: parsed.data.theme,
      reduced_motion: parsed.data.reducedMotion,
    })
    .eq('id', user.id);

  const target = parsed.data.targetCompletionDate
    ? new Date(parsed.data.targetCompletionDate)
    : null;

  const pace = recommendPace(
    {
      minutesPerDay: parsed.data.minutesPerDay,
      studyDays: parsed.data.studyDays,
      totalCourseMinutes: totalCourseMinutes(),
      targetCompletionDate: target,
    },
    allLessons().length,
  );

  await supabase
    .from('learning_plans')
    .update({
      minutes_per_day: parsed.data.minutesPerDay,
      study_days: parsed.data.studyDays,
      target_completion_date: target ? isoDate(target) : null,
      recommended_lessons_per_week: pace.lessonsPerWeek,
      estimated_completion_date: isoDate(addDays(new Date(), pace.estimatedDays)),
    })
    .eq('user_id', user.id)
    .eq('is_active', true);

  revalidatePath('/', 'layout');
  return { ok: true, message: 'Your settings and study plan have been updated.' };
}

export async function saveProjectFileAction(input: unknown): Promise<ActionResult> {
  const user = await getCurrentUser();
  if (!user) return { ok: false, message: 'Sign in to save your project.' };

  const parsed = saveProjectFileSchema.safeParse(input);
  if (!parsed.success) return { ok: false, errors: fieldErrors(parsed.error) };

  const supabase = await createClient();
  const { data: project } = await supabase
    .from('user_projects')
    .select('id')
    .eq('user_id', user.id)
    .order('created_at', { ascending: false })
    .limit(1)
    .maybeSingle();

  if (!project) return { ok: false, message: 'You do not have a project yet.' };

  const { error } = await supabase.from('project_files').upsert(
    {
      project_id: project.id,
      user_id: user.id,
      path: parsed.data.path,
      content: parsed.data.content,
      kind: parsed.data.path.endsWith('.css') ? 'css' : 'html',
      mission_slug: parsed.data.missionSlug ?? null,
    },
    { onConflict: 'project_id,path' },
  );

  if (error) return { ok: false, message: 'We could not save that file.' };

  // Recompute completion from the number of pages with real content — the same
  // measure the five-page achievement uses, so the two can never disagree.
  const { data: files } = await supabase
    .from('project_files')
    .select('path, content')
    .eq('project_id', project.id);

  const htmlPages = (files ?? []).filter((f) => f.path.endsWith('.html'));
  const substantial = htmlPages.filter((f) => isSubstantialPage(f.content)).length;
  const percent = Math.min(
    100,
    Math.round((substantial / Math.max(1, htmlPages.length)) * 100),
  );

  await supabase.from('user_projects').update({ completion_percent: percent }).eq('id', project.id);

  revalidatePath('/project');
  return { ok: true, message: 'Saved.' };
}
