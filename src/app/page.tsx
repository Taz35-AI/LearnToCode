import Link from 'next/link';
import type { Metadata } from 'next';
import { ButtonLink, Card } from '@/components/ui';
import {
  ArrowRightIcon,
  CheckIcon,
  CodeIcon,
  LogoMark,
  TargetIcon,
  TrophyIcon,
} from '@/components/ui/icons';
import { LEVELS, courseStats, totalCourseMinutes } from '@/content/course';
import { formatMinutes } from '@/lib/utils';

export const metadata: Metadata = {
  title: 'HTML Hero — learn HTML properly, from complete beginner to professional',
  description:
    'A mastery-based interactive course. Twelve levels, real coding exercises, debugging challenges and one professional website you build as you go.',
};

export default function LandingPage() {
  const stats = courseStats();

  return (
    <>
      <a className="skip-link" href="#main">
        Skip to main content
      </a>

      <header className="border-b border-app">
        <div className="mx-auto flex max-w-6xl items-center gap-4 px-5 py-4 lg:px-8">
          <Link href="/" className="flex items-center gap-2.5 font-bold text-ink">
            <LogoMark size={28} />
            HTML Hero
          </Link>
          <nav aria-label="Main" className="ml-auto">
            <ul className="flex items-center gap-2">
              <li>
                <ButtonLink href="/login" variant="ghost" size="sm">
                  Sign in
                </ButtonLink>
              </li>
              <li>
                <ButtonLink href="/register" size="sm">
                  Get started
                </ButtonLink>
              </li>
            </ul>
          </nav>
        </div>
      </header>

      <main id="main">
        {/* --- Hero --- */}
        <section className="mx-auto max-w-6xl px-5 py-14 lg:px-8 lg:py-24">
          <div className="grid items-center gap-10 lg:grid-cols-2">
            <div>
              <p className="text-sm font-bold uppercase tracking-widest text-accent">
                Mastery-based · not day-based
              </p>
              <h1 className="mt-3 text-4xl font-bold leading-[1.1] text-ink lg:text-5xl text-balance">
                Learn HTML properly, from never having written a tag.
              </h1>
              <p className="mt-5 max-w-xl text-lg leading-relaxed text-muted">
                Twelve levels take you from &ldquo;what is a tag?&rdquo; to building, validating and
                publishing a professional multi-page website. Every term is explained before it is
                used. Every level is unlocked by demonstrating you understand it — never by a day
                number.
              </p>

              <div className="mt-8 flex flex-wrap gap-3">
                <ButtonLink href="/register" size="lg">
                  Start learning
                  <ArrowRightIcon size={18} />
                </ButtonLink>
                <ButtonLink href="/login" variant="secondary" size="lg">
                  I already have an account
                </ButtonLink>
              </div>

              <p className="mt-5 text-sm text-muted">
                About {formatMinutes(totalCourseMinutes())} of material · roughly 30 days at 45–75
                minutes a day
              </p>
            </div>

            <Card className="overflow-hidden">
              <div className="flex items-center gap-2 border-b border-app bg-[hsl(var(--bg-subtle))] px-4 py-2.5">
                <span className="flex gap-1.5" aria-hidden="true">
                  <span className="h-2.5 w-2.5 rounded-full bg-[hsl(var(--danger))]" />
                  <span className="h-2.5 w-2.5 rounded-full bg-[hsl(var(--warning))]" />
                  <span className="h-2.5 w-2.5 rounded-full bg-[hsl(var(--success))]" />
                </span>
                <span className="ml-2 flex items-center gap-1.5 font-mono text-xs text-muted">
                  <CodeIcon size={13} />
                  index.html
                </span>
              </div>
              <pre className="overflow-x-auto p-5 text-sm leading-relaxed">
                <code>{`<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">
    <title>Riverside Cycle Hire</title>
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>

    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html" aria-current="page">Home</a></li>
          <li><a href="routes.html">Routes</a></li>
        </ul>
      </nav>
    </header>

    <main id="main">
      <h1>Bikes, routes and repairs</h1>
      <p>Open seven days a week from Mill Lane.</p>
    </main>
  </body>
</html>`}</code>
              </pre>
              <p className="border-t border-app bg-[hsl(var(--bg-subtle))] px-4 py-2.5 text-xs text-muted">
                Markup from Level 5. By then you will know why every line is there.
              </p>
            </Card>
          </div>
        </section>

        {/* --- Numbers --- */}
        <section aria-labelledby="numbers" className="border-y border-app bg-[hsl(var(--bg-subtle))]">
          <h2 id="numbers" className="sr-only">
            What the course contains
          </h2>
          <dl className="mx-auto grid max-w-6xl grid-cols-2 gap-6 px-5 py-10 lg:grid-cols-5 lg:px-8">
            {[
              [stats.levels, 'mastery levels'],
              [stats.lessons, 'interactive lessons'],
              [stats.exercises, 'coding exercises'],
              [stats.debugChallenges, 'debugging challenges'],
              [stats.quizQuestions, 'knowledge checks'],
            ].map(([value, label]) => (
              <div key={String(label)}>
                <dt className="text-3xl font-bold tabular-nums text-accent">{value}</dt>
                <dd className="mt-0.5 text-sm text-muted">{label}</dd>
              </div>
            ))}
          </dl>
        </section>

        {/* --- How it works --- */}
        <section aria-labelledby="how" className="mx-auto max-w-6xl px-5 py-16 lg:px-8 lg:py-20">
          <h2 id="how" className="text-3xl font-bold text-ink text-balance">
            Built for people who have genuinely never done this
          </h2>
          <p className="mt-3 max-w-2xl text-muted">
            Most HTML courses assume you already know what a browser, a file path or a screen reader
            is. This one assumes none of it, and never uses a word it has not explained.
          </p>

          <div className="mt-10 grid gap-5 md:grid-cols-3">
            {[
              {
                Icon: TargetIcon,
                title: 'Mastery, not a calendar',
                body: 'A module opens when you have shown you understand what it builds on. Spend an afternoon on one hard idea or clear three lessons before lunch — the estimate follows your real pace either way.',
              },
              {
                Icon: CodeIcon,
                title: 'You write real code',
                body: 'Every lesson ends with a guided exercise, an independent challenge and a debugging task. A structural checker reads your markup and tells you what is wrong in plain English — it never compares your words to a model answer.',
              },
              {
                Icon: TrophyIcon,
                title: 'One website, built throughout',
                body: 'You choose your project at the start. Every module adds a real piece to it. By the end you have a complete, valid, accessible site you can export and publish — never one generated for you.',
              },
            ].map(({ Icon, title, body }) => (
              <Card key={title} className="p-6">
                <span
                  className="grid h-10 w-10 place-items-center rounded-lg bg-[hsl(var(--accent-soft))] text-[hsl(var(--accent))]"
                  aria-hidden="true"
                >
                  <Icon size={20} />
                </span>
                <h3 className="mt-4 text-lg font-semibold text-ink">{title}</h3>
                <p className="mt-2 text-muted">{body}</p>
              </Card>
            ))}
          </div>
        </section>

        {/* --- The journey --- */}
        <section
          aria-labelledby="journey"
          className="border-t border-app bg-[hsl(var(--bg-subtle))] py-16 lg:py-20"
        >
          <div className="mx-auto max-w-6xl px-5 lg:px-8">
            <h2 id="journey" className="text-3xl font-bold text-ink">
              The journey
            </h2>
            <p className="mt-3 max-w-2xl text-muted">
              Twelve levels, {stats.modules} modules. Each ends with a milestone project and an
              assessment you must pass to move on.
            </p>

            <ol className="mt-10 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
              {LEVELS.map((level, index) => (
                <li key={level.slug}>
                  <Card className="h-full p-5">
                    <div className="flex items-center gap-3">
                      <span className="grid h-8 w-8 shrink-0 place-items-center rounded-lg bg-[hsl(var(--accent-soft))] text-sm font-bold text-[hsl(var(--accent))]">
                        {index + 1}
                      </span>
                      <h3 className="font-semibold text-ink">{level.title}</h3>
                    </div>
                    <p className="mt-2.5 text-sm text-muted">{level.subtitle}</p>
                    <p className="mt-3 flex gap-2 text-sm text-ink">
                      <span className="mt-0.5 shrink-0 text-[hsl(var(--success))]" aria-hidden="true">
                        <CheckIcon size={15} />
                      </span>
                      {level.outcome}
                    </p>
                  </Card>
                </li>
              ))}
            </ol>
          </div>
        </section>

        {/* --- What you'll know --- */}
        <section aria-labelledby="outcomes" className="mx-auto max-w-6xl px-5 py-16 lg:px-8 lg:py-20">
          <h2 id="outcomes" className="text-3xl font-bold text-ink">
            What you will actually be able to do
          </h2>

          <ul className="mt-8 grid gap-x-8 gap-y-2.5 sm:grid-cols-2 lg:grid-cols-3">
            {[
              'Write a valid HTML document from an empty file',
              'Choose the right element for the meaning, every time',
              'Build a multi-page site with consistent navigation',
              'Serve responsive images with srcset and picture',
              'Embed accessible video with captions and fallbacks',
              'Build data tables a screen reader can navigate',
              'Build forms people can actually complete',
              'Use details, dialog and popover instead of JavaScript',
              'Audit and repair an inaccessible page',
              'Write metadata, Open Graph tags and structured data',
              'Make markup-level performance and security decisions',
              'Read validator output and debug methodically',
              'Export and publish a real website',
            ].map((item) => (
              <li key={item} className="flex gap-2.5 text-ink">
                <span className="mt-1 shrink-0 text-[hsl(var(--success))]" aria-hidden="true">
                  <CheckIcon size={15} />
                </span>
                {item}
              </li>
            ))}
          </ul>

          <div className="mt-12 rounded-[var(--radius-card)] border border-[hsl(var(--accent-border))] bg-[hsl(var(--accent-soft))] p-8 text-center">
            <h2 className="text-2xl font-bold text-ink text-balance">
              Your first two lines of HTML are about ninety seconds away.
            </h2>
            <p className="mx-auto mt-2 max-w-xl text-muted">
              Registration, a three-minute plan, and you are writing markup in the same session.
            </p>
            <ButtonLink href="/register" size="lg" className="mt-6">
              Start learning
              <ArrowRightIcon size={18} />
            </ButtonLink>
          </div>
        </section>
      </main>

      <footer className="border-t border-app">
        <div className="mx-auto flex max-w-6xl flex-wrap items-center gap-4 px-5 py-8 lg:px-8">
          <p className="text-sm text-muted">
            HTML Hero · all example media is original and released under CC0-1.0
          </p>
          <nav aria-label="Footer" className="ml-auto">
            <ul className="flex gap-5 text-sm">
              <li>
                <Link href="/media" className="text-muted underline underline-offset-2 hover:text-ink">
                  Media attribution
                </Link>
              </li>
              <li>
                <Link href="/login" className="text-muted underline underline-offset-2 hover:text-ink">
                  Sign in
                </Link>
              </li>
            </ul>
          </nav>
        </div>
      </footer>
    </>
  );
}
