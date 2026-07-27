import Link from 'next/link';
import { LogoMark } from '@/components/ui/icons';

export default function AuthLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="min-h-screen grid lg:grid-cols-[1fr_minmax(24rem,32rem)]">
      {/* The marketing panel is decorative on small screens, so it is hidden
          rather than stacked — it would push the form below the fold. */}
      <aside className="hidden lg:flex flex-col justify-between bg-[hsl(var(--bg-subtle))] border-r border-app p-12">
        <Link href="/" className="inline-flex items-center gap-2.5 font-bold text-lg text-ink">
          <LogoMark size={30} />
          HTML Hero
        </Link>

        <div className="max-w-md">
          <h2 className="text-3xl font-bold text-ink leading-tight text-balance">
            Twelve levels. One real website. No calendar telling you when to be ready.
          </h2>
          <p className="mt-4 text-muted leading-relaxed">
            You progress by demonstrating you understand something, not by a day number. Spend an
            afternoon on one difficult idea, or clear three lessons before lunch — the course moves
            at your pace and keeps an honest estimate of when you will finish.
          </p>

          <dl className="mt-8 grid grid-cols-2 gap-5">
            {[
              ['48', 'interactive lessons'],
              ['91', 'coding exercises'],
              ['25', 'debugging challenges'],
              ['1', 'website you actually ship'],
            ].map(([value, label]) => (
              <div key={label}>
                <dt className="text-2xl font-bold text-accent tabular-nums">{value}</dt>
                <dd className="text-sm text-muted">{label}</dd>
              </div>
            ))}
          </dl>
        </div>

        <p className="text-xs text-faint">
          All example media is original and released into the public domain.
        </p>
      </aside>

      <main className="flex flex-col justify-center px-6 py-12 sm:px-10">
        <div className="w-full max-w-md mx-auto">
          <Link
            href="/"
            className="lg:hidden inline-flex items-center gap-2 font-bold text-lg text-ink mb-8"
          >
            <LogoMark size={28} />
            HTML Hero
          </Link>
          {children}
        </div>
      </main>
    </div>
  );
}
