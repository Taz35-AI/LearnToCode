import { Callout } from '@/components/ui';

/**
 * Shown when the Supabase environment variables are missing.
 *
 * Rather than crashing with a stack trace, the application explains exactly
 * what is missing and how to fix it. This is also what makes `next build`
 * succeed on a machine that has never seen the project's credentials.
 */
export function SetupRequired() {
  return (
    <main className="min-h-screen px-6 py-16">
      <div className="mx-auto max-w-2xl">
        <h1 className="text-2xl font-bold text-ink">Finish setting up HTML Hero</h1>
        <p className="mt-2 text-muted">
          The application is installed but has no Supabase connection yet, so there is no course to
          load and nowhere to save progress.
        </p>

        <Callout tone="tip" title="Three steps">
          <ol className="mt-2 list-decimal space-y-2 pl-5">
            <li>
              Copy <code>.env.example</code> to <code>.env.local</code> and fill in{' '}
              <code>NEXT_PUBLIC_SUPABASE_URL</code> and{' '}
              <code>NEXT_PUBLIC_SUPABASE_ANON_KEY</code> from your Supabase project settings.
            </li>
            <li>
              Apply the migrations in <code>supabase/migrations/</code> in filename order, using the
              Supabase SQL editor or <code>supabase db push</code>.
            </li>
            <li>
              Run <code>npm run seed:generate</code>, then load the generated{' '}
              <code>supabase/seed.sql</code> into your project.
            </li>
          </ol>
        </Callout>

        <p className="mt-6 text-sm text-muted">
          The full walkthrough is in the README, under <strong>Supabase setup</strong>.
        </p>
      </div>
    </main>
  );
}
