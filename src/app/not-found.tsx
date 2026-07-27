import { ButtonLink } from '@/components/ui';

export default function NotFound() {
  return (
    <main className="min-h-screen grid place-items-center px-6 py-16">
      <div className="max-w-md text-center">
        <p className="text-sm font-bold uppercase tracking-widest text-accent">404</p>
        <h1 className="mt-2 text-2xl font-bold text-ink">We could not find that page</h1>
        <p className="mt-2 text-muted">
          The link may be out of date, or the page may have moved. Nothing in your progress has
          changed.
        </p>
        <div className="mt-6 flex flex-wrap gap-3 justify-center">
          <ButtonLink href="/dashboard">Go to your dashboard</ButtonLink>
          <ButtonLink href="/roadmap" variant="secondary">
            Browse the roadmap
          </ButtonLink>
        </div>
      </div>
    </main>
  );
}
