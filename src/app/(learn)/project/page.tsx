import type { Metadata } from 'next';
import { redirect } from 'next/navigation';
import { getCurrentUser } from '@/lib/supabase/server';
import { getActiveProject, getProfile, getProjectFiles } from '@/lib/data/learner';
import { saveProjectFileAction } from '@/lib/actions/onboarding';
import { buildCapstoneChecklist } from '@/lib/project/checklist';
import { ProjectWorkspace } from '@/components/learn/project-workspace';
import { ButtonLink, Card, EmptyState } from '@/components/ui';
import { FolderIcon } from '@/components/ui/icons';

export const metadata: Metadata = {
  title: 'My project',
  description: 'The website you are building throughout the course.',
  robots: { index: false, follow: false },
};

export default async function ProjectPage() {
  const user = await getCurrentUser();
  if (!user) redirect('/login');

  const [project, profile] = await Promise.all([getActiveProject(user.id), getProfile(user.id)]);

  if (!project) {
    return (
      <div className="p-5 lg:p-10">
        <Card>
          <EmptyState
            icon={<FolderIcon size={32} />}
            title="No project yet"
            description="Your capstone project is created during onboarding, when you choose which kind of site you want to build."
            action={<ButtonLink href="/onboarding">Choose a project</ButtonLink>}
          />
        </Card>
      </div>
    );
  }

  const files = await getProjectFiles(project.id);
  const checklist = buildCapstoneChecklist(
    files.map((file) => ({ path: file.path, content: file.content })),
  );

  return (
    <ProjectWorkspace
      projectName={project.name}
      files={files.map((file) => ({
        id: file.id,
        path: file.path,
        content: file.content,
        kind: file.kind,
      }))}
      completionPercent={project.completion_percent}
      checklist={checklist}
      theme={profile?.theme === 'dark' ? 'dark' : 'light'}
      onSave={saveProjectFileAction}
    />
  );
}
