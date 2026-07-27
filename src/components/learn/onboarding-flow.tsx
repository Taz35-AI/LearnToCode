'use client';

import { useActionState, useState } from 'react';
import { useFormStatus } from 'react-dom';
import { Badge, Button, Callout, Card, Field, ProgressBar, inputClasses } from '@/components/ui';
import { InlinePreview } from '@/components/editor/preview';
import {
  ArrowLeftIcon,
  ArrowRightIcon,
  CheckIcon,
  FlameIcon,
  SparkIcon,
  TargetIcon,
  TrophyIcon,
} from '@/components/ui/icons';
import { cx } from '@/lib/utils';
import type { ActionResult } from '@/lib/actions/schemas';

/**
 * Onboarding.
 *
 * Six steps, each with one job. The learner's answers become a real learning
 * plan and a real project — the estimate shown on the final step is computed
 * with the same function the dashboard uses, so the number they are promised is
 * the number they will see.
 */

export interface ProjectChoice {
  slug: string;
  name: string;
  tagline: string;
  description: string;
  audience: string;
  heroPath: string;
}

const DAYS = [
  { value: 1, label: 'Mon' },
  { value: 2, label: 'Tue' },
  { value: 3, label: 'Wed' },
  { value: 4, label: 'Thu' },
  { value: 5, label: 'Fri' },
  { value: 6, label: 'Sat' },
  { value: 7, label: 'Sun' },
] as const;

const MINUTE_CHOICES = [
  { value: 30, label: '30 minutes', note: 'A steady pace — expect longer than 30 days' },
  { value: 45, label: '45 minutes', note: 'The lower end of the recommended range' },
  { value: 60, label: '1 hour', note: 'The recommended pace for finishing in about a month' },
  { value: 90, label: '1½ hours', note: 'A faster route, if you have the time' },
] as const;

const EXPERIENCE = [
  { value: 'none', label: 'I have never written any code', note: 'Perfect — this course assumes exactly that.' },
  { value: 'some_html', label: 'I have seen HTML but never really learned it', note: 'You will fill in the gaps quickly.' },
  { value: 'other_language', label: 'I code in something else, but not HTML', note: 'You can move fast through the early levels.' },
] as const;

const FIRST_ACTIVITY_STARTER = `Fresh bread, every morning
We open at 6am and bake until we sell out.`;

const FIRST_ACTIVITY_SOLVED = `<h1>Fresh bread, every morning</h1>
<p>We open at 6am and bake until we sell out.</p>`;

const TOTAL_STEPS = 6;

export function OnboardingFlow({
  action,
  defaultName,
  projects,
  totalLessons,
  totalMinutes,
}: {
  action: (previous: ActionResult | null, formData: FormData) => Promise<ActionResult>;
  defaultName: string;
  projects: ProjectChoice[];
  totalLessons: number;
  totalMinutes: number;
}) {
  const [state, formAction] = useActionState(action, null);
  const [step, setStep] = useState(1);

  const [displayName, setDisplayName] = useState(defaultName);
  const [minutes, setMinutes] = useState(60);
  const [days, setDays] = useState<number[]>([1, 2, 3, 4, 5]);
  const [experience, setExperience] = useState<string>('none');
  const [target, setTarget] = useState('');
  const [project, setProject] = useState(projects[0]?.slug ?? '');
  const [activityCode, setActivityCode] = useState(FIRST_ACTIVITY_STARTER);

  const activityDone =
    /<h1[^>]*>[\s\S]*?<\/h1>/i.test(activityCode) && /<p[^>]*>[\s\S]*?<\/p>/i.test(activityCode);

  // The same maths the dashboard uses, so the promise matches the reality.
  const studyDaysPerWeek = Math.max(1, new Set(days).size);
  const minutesPerWeek = minutes * studyDaysPerWeek * 0.85;
  const estimatedDays = Math.ceil((totalMinutes / Math.max(1, minutesPerWeek)) * 7);
  const lessonsPerWeek =
    Math.round((totalLessons / Math.max(0.1, totalMinutes / Math.max(1, minutesPerWeek))) * 10) / 10;

  const toggleDay = (value: number) =>
    setDays((current) =>
      current.includes(value) ? current.filter((d) => d !== value) : [...current, value].sort(),
    );

  const canAdvance =
    step === 3 ? days.length > 0 : step === 5 ? Boolean(project) : step === 1 ? displayName.trim().length > 0 : true;

  return (
    <div className="mx-auto max-w-3xl px-5 py-8 lg:py-14">
      <div className="mb-8">
        <div className="mb-2 flex items-baseline justify-between">
          <p className="text-sm font-semibold text-accent">
            Step {step} of {TOTAL_STEPS}
          </p>
          <p className="text-sm text-muted">Takes about three minutes</p>
        </div>
        <ProgressBar value={step} max={TOTAL_STEPS} label="Onboarding progress" size="sm" />
      </div>

      {state?.message && !state.ok ? (
        <p role="alert" className="mb-6 rounded-lg border border-[hsl(var(--danger)/0.35)] bg-[hsl(var(--danger-soft))] px-4 py-3 text-sm font-medium text-[hsl(var(--danger))]">
          {state.message}
        </p>
      ) : null}

      <form action={formAction}>
        {/* Every answer travels with the form regardless of which step is shown. */}
        <input type="hidden" name="displayName" value={displayName} />
        <input type="hidden" name="minutesPerDay" value={minutes} />
        {days.map((day) => (
          <input key={day} type="hidden" name="studyDays" value={day} />
        ))}
        <input type="hidden" name="experience" value={experience} />
        <input type="hidden" name="targetCompletionDate" value={target} />
        <input type="hidden" name="projectTemplateSlug" value={project} />

        {/* ---- 1. Welcome ---- */}
        {step === 1 ? (
          <Card className="p-6 lg:p-8">
            <h1 className="text-2xl font-bold text-ink lg:text-3xl text-balance">
              Welcome to HTML Hero
            </h1>
            <p className="mt-3 text-muted leading-relaxed">
              You are about to learn HTML properly — not a tour of tags, but the whole language as
              it is actually used: structure, meaning, accessibility, media, forms, metadata,
              performance and debugging.
            </p>

            <div className="mt-6 grid gap-3 sm:grid-cols-3">
              {[
                ['Twelve levels', 'Explorer to Hero, each unlocked by demonstrated understanding'],
                ['One real website', 'Built piece by piece as you go — never generated for you'],
                ['No calendar', 'Move fast or slow; the estimate follows your real pace'],
              ].map(([title, body]) => (
                <div key={title} className="rounded-lg border border-app p-4">
                  <p className="font-semibold text-ink">{title}</p>
                  <p className="mt-1 text-sm text-muted">{body}</p>
                </div>
              ))}
            </div>

            <Callout tone="note" title="Mastery-based, not day-based">
              <p>
                There is no &ldquo;Day 4&rdquo; here. A module opens when you have shown you
                understand what it builds on. Some people clear three lessons in an evening; others
                spend two days on one difficult idea. Both are fine, and the app keeps an honest
                estimate of when you will finish either way.
              </p>
            </Callout>

            <div className="mt-6">
              <Field label="What should we call you?" htmlFor="name-input" required>
                <input
                  id="name-input"
                  type="text"
                  value={displayName}
                  onChange={(event) => setDisplayName(event.target.value)}
                  maxLength={60}
                  autoComplete="name"
                  className={inputClasses}
                />
              </Field>
            </div>
          </Card>
        ) : null}

        {/* ---- 2. Experience ---- */}
        {step === 2 ? (
          <Card className="p-6 lg:p-8">
            <h1 className="text-2xl font-bold text-ink">Where are you starting from?</h1>
            <p className="mt-2 text-muted">
              This only affects the pace we suggest. Every term is explained before it is used,
              whichever you choose.
            </p>

            <fieldset className="mt-6">
              <legend className="sr-only">Your experience with code</legend>
              <div className="space-y-2.5">
                {EXPERIENCE.map((option) => (
                  <label
                    key={option.value}
                    className={cx(
                      'flex cursor-pointer items-start gap-3 rounded-lg border p-4 transition-colors',
                      experience === option.value
                        ? 'border-[hsl(var(--accent))] bg-[hsl(var(--accent-soft))]'
                        : 'border-app hover:border-strong',
                    )}
                  >
                    <input
                      type="radio"
                      name="experience-choice"
                      value={option.value}
                      checked={experience === option.value}
                      onChange={() => setExperience(option.value)}
                      className="mt-1 h-4 w-4 shrink-0 accent-[hsl(var(--accent))]"
                    />
                    <span>
                      <span className="block font-medium text-ink">{option.label}</span>
                      <span className="block text-sm text-muted">{option.note}</span>
                    </span>
                  </label>
                ))}
              </div>
            </fieldset>
          </Card>
        ) : null}

        {/* ---- 3. Schedule ---- */}
        {step === 3 ? (
          <Card className="p-6 lg:p-8">
            <h1 className="text-2xl font-bold text-ink">How much time do you have?</h1>
            <p className="mt-2 text-muted">
              Be honest rather than ambitious — a plan you can keep beats one that makes you feel
              behind. You can change this at any point.
            </p>

            <fieldset className="mt-6">
              <legend className="mb-2.5 font-semibold text-ink">On a day you study</legend>
              <div className="grid gap-2.5 sm:grid-cols-2">
                {MINUTE_CHOICES.map((option) => (
                  <label
                    key={option.value}
                    className={cx(
                      'flex cursor-pointer items-start gap-3 rounded-lg border p-3.5 transition-colors',
                      minutes === option.value
                        ? 'border-[hsl(var(--accent))] bg-[hsl(var(--accent-soft))]'
                        : 'border-app hover:border-strong',
                    )}
                  >
                    <input
                      type="radio"
                      name="minutes-choice"
                      value={option.value}
                      checked={minutes === option.value}
                      onChange={() => setMinutes(option.value)}
                      className="mt-1 h-4 w-4 shrink-0 accent-[hsl(var(--accent))]"
                    />
                    <span>
                      <span className="block font-medium text-ink">{option.label}</span>
                      <span className="block text-xs text-muted">{option.note}</span>
                    </span>
                  </label>
                ))}
              </div>
            </fieldset>

            <fieldset className="mt-7">
              <legend className="mb-2.5 font-semibold text-ink">Which days suit you?</legend>
              <div className="flex flex-wrap gap-2">
                {DAYS.map((day) => (
                  <label
                    key={day.value}
                    className={cx(
                      'cursor-pointer rounded-lg border px-4 py-2.5 text-sm font-medium transition-colors min-h-[2.75rem] inline-flex items-center gap-2',
                      days.includes(day.value)
                        ? 'border-[hsl(var(--accent))] bg-[hsl(var(--accent-soft))] text-[hsl(var(--accent))]'
                        : 'border-app text-muted hover:border-strong',
                    )}
                  >
                    <input
                      type="checkbox"
                      checked={days.includes(day.value)}
                      onChange={() => toggleDay(day.value)}
                      className="h-4 w-4 accent-[hsl(var(--accent))]"
                    />
                    {day.label}
                  </label>
                ))}
              </div>
              {days.length === 0 ? (
                <p role="alert" className="mt-2 text-sm font-medium text-[hsl(var(--danger))]">
                  Choose at least one day.
                </p>
              ) : null}
            </fieldset>

            <div className="mt-7">
              <Field
                label="Is there a date you would like to finish by?"
                htmlFor="target-date"
                hint="Optional. We will tell you honestly whether it is realistic."
              >
                <input
                  id="target-date"
                  type="date"
                  value={target}
                  onChange={(event) => setTarget(event.target.value)}
                  className={inputClasses}
                />
              </Field>
            </div>
          </Card>
        ) : null}

        {/* ---- 4. How it works ---- */}
        {step === 4 ? (
          <Card className="p-6 lg:p-8">
            <h1 className="text-2xl font-bold text-ink">How progress works here</h1>
            <p className="mt-2 text-muted">Four things drive everything. None of them is a clock.</p>

            <dl className="mt-6 space-y-4">
              {[
                {
                  Icon: SparkIcon,
                  term: 'XP',
                  detail:
                    'Earned for lessons, exercises and knowledge checks. Hints and repeated attempts earn a little less — but never nothing, because struggling and then succeeding is real learning. Re-doing something you have already passed earns nothing at all.',
                },
                {
                  Icon: TargetIcon,
                  term: 'Skill mastery',
                  detail:
                    'Tracked separately for 26 skills. A skill becomes mastered when several pieces of evidence agree, not when one lucky answer lands. Weak skills come back as targeted practice.',
                },
                {
                  Icon: FlameIcon,
                  term: 'Streaks',
                  detail:
                    'A count of consecutive days you studied. A streak survives until midnight, so missing a morning does not cost you the day.',
                },
                {
                  Icon: TrophyIcon,
                  term: 'Achievements and the final project',
                  detail:
                    'Achievements mark genuine milestones. Your capstone website grows a piece at a time from Level 1 — it is never generated for you at the end.',
                },
              ].map(({ Icon, term, detail }) => (
                <div key={term} className="flex gap-3.5">
                  <span className="mt-0.5 shrink-0 text-accent" aria-hidden="true">
                    <Icon size={20} />
                  </span>
                  <div>
                    <dt className="font-semibold text-ink">{term}</dt>
                    <dd className="mt-0.5 text-sm text-muted">{detail}</dd>
                  </div>
                </div>
              ))}
            </dl>
          </Card>
        ) : null}

        {/* ---- 5. Project choice ---- */}
        {step === 5 ? (
          <Card className="p-6 lg:p-8">
            <h1 className="text-2xl font-bold text-ink">Choose your final project</h1>
            <p className="mt-2 text-muted">
              Every module adds a real piece to this site. Pick something you would genuinely find
              useful — it makes writing the content far easier.
            </p>

            <fieldset className="mt-6">
              <legend className="sr-only">Final project type</legend>
              <div className="grid gap-3 sm:grid-cols-2">
                {projects.map((choice) => (
                  <label
                    key={choice.slug}
                    className={cx(
                      'cursor-pointer overflow-hidden rounded-lg border transition-colors',
                      project === choice.slug
                        ? 'border-[hsl(var(--accent))] ring-2 ring-[hsl(var(--accent)/0.3)]'
                        : 'border-app hover:border-strong',
                    )}
                  >
                    <input
                      type="radio"
                      name="project-choice"
                      value={choice.slug}
                      checked={project === choice.slug}
                      onChange={() => setProject(choice.slug)}
                      className="sr-only"
                    />
                    <span className="block aspect-[16/9] overflow-hidden bg-[hsl(var(--bg-subtle))]">
                      {/* eslint-disable-next-line @next/next/no-img-element */}
                      <img
                        src={choice.heroPath}
                        alt=""
                        className="h-full w-full object-cover"
                        loading="lazy"
                      />
                    </span>
                    <span className="block p-3.5">
                      <span className="flex items-center gap-2">
                        <span className="font-semibold text-ink">{choice.name}</span>
                        {project === choice.slug ? (
                          <Badge tone="accent">
                            <CheckIcon size={11} /> Chosen
                          </Badge>
                        ) : null}
                      </span>
                      <span className="mt-0.5 block text-sm text-muted">{choice.tagline}</span>
                      <span className="mt-1.5 block text-xs text-faint">
                        For: {choice.audience}
                      </span>
                    </span>
                  </label>
                ))}
              </div>
            </fieldset>
          </Card>
        ) : null}

        {/* ---- 6. Plan and first activity ---- */}
        {step === 6 ? (
          <div className="space-y-5">
            <Card className="p-6 lg:p-8">
              <h1 className="text-2xl font-bold text-ink">Your plan</h1>
              <p className="mt-2 text-muted">
                Built from your answers. It will adjust itself as you go — this is a starting
                estimate, not a deadline.
              </p>

              <dl className="mt-6 grid gap-3 sm:grid-cols-3">
                {[
                  ['Recommended pace', `${lessonsPerWeek} lessons/week`],
                  ['Estimated to finish', `about ${estimatedDays} days`],
                  ['Weekly study time', `${Math.round(minutesPerWeek)} minutes`],
                ].map(([label, value]) => (
                  <div key={label} className="rounded-lg border border-app p-4">
                    <dt className="text-xs font-semibold uppercase tracking-wide text-muted">
                      {label}
                    </dt>
                    <dd className="mt-1 text-lg font-bold text-ink">{value}</dd>
                  </div>
                ))}
              </dl>

              {estimatedDays > 45 ? (
                <Callout tone="note" title="That is a longer route, and that is fine">
                  <p>
                    At {minutes} minutes on {studyDaysPerWeek}{' '}
                    {studyDaysPerWeek === 1 ? 'day' : 'days'} a week, this course takes about{' '}
                    {estimatedDays} days rather than 30. Adding one more study day a week, or
                    fifteen more minutes, would bring it closer. Either way, you will finish.
                  </p>
                </Callout>
              ) : null}

              <Callout tone="tip" title="What you will be able to build">
                <p>
                  By the end you will have a complete multi-page website with semantic structure,
                  responsive images, accessible video with captions, a working form, structured
                  data and valid HTML throughout — built entirely by you, and ready to publish
                  anywhere.
                </p>
              </Callout>
            </Card>

            <Card className="p-6 lg:p-8">
              <h2 className="text-xl font-bold text-ink">Your first two lines of HTML</h2>
              <p className="mt-2 text-muted">
                Before you go any further — wrap the first line in{' '}
                <code className="rounded bg-[hsl(var(--bg-subtle))] px-1.5 py-0.5 font-mono text-sm">
                  &lt;h1&gt;…&lt;/h1&gt;
                </code>{' '}
                and the second in{' '}
                <code className="rounded bg-[hsl(var(--bg-subtle))] px-1.5 py-0.5 font-mono text-sm">
                  &lt;p&gt;…&lt;/p&gt;
                </code>
                . Watch the preview change as you type.
              </p>

              <div className="mt-5 grid gap-3 md:grid-cols-2">
                <div>
                  <label htmlFor="first-activity" className="mb-1.5 block text-sm font-semibold text-ink">
                    Your HTML
                  </label>
                  <textarea
                    id="first-activity"
                    value={activityCode}
                    onChange={(event) => setActivityCode(event.target.value)}
                    rows={6}
                    spellCheck={false}
                    className="w-full rounded-lg border border-app bg-surface p-3 font-mono text-sm text-ink"
                  />
                  <div className="mt-2 flex flex-wrap gap-2">
                    <Button
                      type="button"
                      variant="ghost"
                      size="sm"
                      onClick={() => setActivityCode(FIRST_ACTIVITY_STARTER)}
                    >
                      Reset
                    </Button>
                    <Button
                      type="button"
                      variant="ghost"
                      size="sm"
                      onClick={() => setActivityCode(FIRST_ACTIVITY_SOLVED)}
                    >
                      Show me
                    </Button>
                  </div>
                </div>
                <div>
                  <p className="mb-1.5 text-sm font-semibold text-ink">Live preview</p>
                  <InlinePreview code={activityCode} label="Preview of your first HTML" height={170} />
                </div>
              </div>

              <p
                aria-live="polite"
                className={cx(
                  'mt-4 rounded-lg border px-4 py-3 text-sm font-medium',
                  activityDone
                    ? 'border-[hsl(var(--success)/0.35)] bg-[hsl(var(--success-soft))] text-[hsl(var(--success))]'
                    : 'border-app bg-[hsl(var(--bg-subtle))] text-muted',
                )}
              >
                {activityDone
                  ? 'That is a heading and a paragraph — you have written HTML. Everything else builds on exactly this.'
                  : 'Add an <h1> around the first line and a <p> around the second.'}
              </p>
            </Card>
          </div>
        ) : null}

        {/* ---- Navigation ---- */}
        <div className="mt-6 flex flex-wrap items-center justify-between gap-3">
          <Button
            type="button"
            variant="ghost"
            onClick={() => setStep((s) => Math.max(1, s - 1))}
            disabled={step === 1}
          >
            <ArrowLeftIcon size={16} />
            Back
          </Button>

          {step < TOTAL_STEPS ? (
            <Button
              type="button"
              size="lg"
              onClick={() => setStep((s) => Math.min(TOTAL_STEPS, s + 1))}
              disabled={!canAdvance}
            >
              Continue
              <ArrowRightIcon size={18} />
            </Button>
          ) : (
            <StartButton />
          )}
        </div>
      </form>
    </div>
  );
}

function StartButton() {
  const { pending } = useFormStatus();
  return (
    <Button type="submit" size="lg" disabled={pending}>
      {pending ? 'Setting up…' : 'Start Level 1'}
      <ArrowRightIcon size={18} />
    </Button>
  );
}
