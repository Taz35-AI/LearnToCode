'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useEffect, useState } from 'react';
import { cx } from '@/lib/utils';
import { Badge } from '@/components/ui';
import {
  BookIcon,
  CertificateIcon,
  FlameIcon,
  FolderIcon,
  HomeIcon,
  ImageIcon,
  LogoMark,
  MapIcon,
  SettingsIcon,
  SparkIcon,
  TargetIcon,
  TrophyIcon,
} from '@/components/ui/icons';

/**
 * The signed-in application shell.
 *
 * A single `<nav aria-label="Main">` used at both sizes: a sidebar on large
 * screens, a slide-over on small ones. The skip link is the first focusable
 * element on every page, and `aria-current="page"` marks where the learner is —
 * exactly the pattern taught in Level 3.
 */

const NAV = [
  { href: '/dashboard', label: 'Dashboard', Icon: HomeIcon },
  { href: '/roadmap', label: 'Roadmap', Icon: MapIcon },
  { href: '/practice', label: 'Practice', Icon: TargetIcon },
  { href: '/project', label: 'My project', Icon: FolderIcon },
  { href: '/achievements', label: 'Achievements', Icon: TrophyIcon },
  { href: '/media', label: 'Media library', Icon: ImageIcon },
  { href: '/certificate', label: 'Certificate', Icon: CertificateIcon },
  { href: '/settings', label: 'Settings', Icon: SettingsIcon },
] as const;

export function AppShell({
  children,
  displayName,
  totalXp,
  learnerLevel,
  streakDays,
  onSignOut,
}: {
  children: React.ReactNode;
  displayName: string;
  totalXp: number;
  learnerLevel: number;
  streakDays: number;
  onSignOut: () => void;
}) {
  const pathname = usePathname();
  const [menuOpen, setMenuOpen] = useState(false);

  // Escape closes the slide-over. Navigation closes it from the link's own
  // click handler rather than an effect, so no cascading render is triggered.
  useEffect(() => {
    if (!menuOpen) return;
    const onKey = (event: KeyboardEvent) => {
      if (event.key === 'Escape') setMenuOpen(false);
    };
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [menuOpen]);

  const isCurrent = (href: string) => pathname === href || pathname.startsWith(`${href}/`);

  const navList = (
    <ul className="space-y-0.5">
      {NAV.map(({ href, label, Icon }) => (
        <li key={href}>
          <Link
            href={href}
            onClick={() => setMenuOpen(false)}
            aria-current={isCurrent(href) ? 'page' : undefined}
            className={cx(
              'flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium transition-colors min-h-[2.75rem]',
              isCurrent(href)
                ? 'bg-[hsl(var(--accent-soft))] text-[hsl(var(--accent))]'
                : 'text-muted hover:bg-[hsl(var(--bg-subtle))] hover:text-ink',
            )}
          >
            <Icon size={18} />
            {label}
          </Link>
        </li>
      ))}
    </ul>
  );

  return (
    <div className="min-h-screen lg:grid lg:grid-cols-[16rem_1fr]">
      <a className="skip-link" href="#main">
        Skip to main content
      </a>

      {/* --- Sidebar (large screens) --- */}
      <aside className="hidden lg:flex lg:flex-col border-r border-app bg-[hsl(var(--bg-subtle))] sticky top-0 h-screen">
        <div className="p-5">
          <Link href="/dashboard" className="flex items-center gap-2.5 font-bold text-ink">
            <LogoMark size={28} />
            HTML Hero
          </Link>
        </div>

        <nav aria-label="Main" className="flex-1 overflow-y-auto px-3">
          {navList}
        </nav>

        <div className="border-t border-app p-4">
          <LearnerSummary
            displayName={displayName}
            totalXp={totalXp}
            learnerLevel={learnerLevel}
            streakDays={streakDays}
          />
          <form action={onSignOut} className="mt-3">
            <button
              type="submit"
              className="w-full rounded-lg px-3 py-2 text-left text-sm font-medium text-muted transition-colors hover:bg-[hsl(var(--bg-subtle))] hover:text-ink min-h-[2.5rem]"
            >
              Sign out
            </button>
          </form>
        </div>
      </aside>

      {/* --- Top bar (small screens) --- */}
      <div className="lg:hidden sticky top-0 z-30 flex items-center gap-3 border-b border-app bg-app px-4 py-3">
        <Link href="/dashboard" className="flex items-center gap-2 font-bold text-ink">
          <LogoMark size={24} />
          HTML Hero
        </Link>
        <div className="ml-auto flex items-center gap-2">
          <Badge tone="accent">
            <SparkIcon size={12} />
            {totalXp.toLocaleString('en-GB')}
          </Badge>
          <button
            type="button"
            onClick={() => setMenuOpen(true)}
            aria-expanded={menuOpen}
            aria-controls="mobile-nav"
            className="rounded-lg border border-app px-3 py-2 text-sm font-semibold text-ink min-h-[2.5rem]"
          >
            Menu
          </button>
        </div>
      </div>

      {menuOpen ? (
        <div className="lg:hidden fixed inset-0 z-40">
          <button
            type="button"
            aria-label="Close menu"
            onClick={() => setMenuOpen(false)}
            className="absolute inset-0 bg-black/40"
          />
          <div
            id="mobile-nav"
            className="absolute inset-y-0 right-0 flex w-72 max-w-[85vw] flex-col border-l border-app bg-app shadow-lift"
          >
            <div className="flex items-center justify-between border-b border-app p-4">
              <span className="font-bold text-ink">Menu</span>
              <button
                type="button"
                onClick={() => setMenuOpen(false)}
                className="rounded-lg px-3 py-1.5 text-sm font-semibold text-muted min-h-[2.25rem]"
              >
                Close
              </button>
            </div>
            <nav aria-label="Main" className="flex-1 overflow-y-auto p-3">
              {navList}
            </nav>
            <div className="border-t border-app p-4">
              <LearnerSummary
                displayName={displayName}
                totalXp={totalXp}
                learnerLevel={learnerLevel}
                streakDays={streakDays}
              />
              <form action={onSignOut} className="mt-3">
                <button
                  type="submit"
                  className="w-full rounded-lg border border-app px-3 py-2 text-sm font-medium text-ink min-h-[2.5rem]"
                >
                  Sign out
                </button>
              </form>
            </div>
          </div>
        </div>
      ) : null}

      <main id="main" className="min-w-0">
        {children}
      </main>
    </div>
  );
}

function LearnerSummary({
  displayName,
  totalXp,
  learnerLevel,
  streakDays,
}: {
  displayName: string;
  totalXp: number;
  learnerLevel: number;
  streakDays: number;
}) {
  return (
    <div>
      <p className="truncate text-sm font-semibold text-ink">{displayName}</p>
      <div className="mt-1.5 flex flex-wrap items-center gap-1.5">
        <Badge tone="accent">
          <BookIcon size={12} />
          Level {learnerLevel}
        </Badge>
        <Badge>
          <SparkIcon size={12} />
          {totalXp.toLocaleString('en-GB')} XP
        </Badge>
        {streakDays > 0 ? (
          <Badge tone="warning">
            <FlameIcon size={12} />
            {streakDays}
          </Badge>
        ) : null}
      </div>
    </div>
  );
}
