'use client';

import { cx } from '@/lib/utils';

/**
 * Switches which course the learner is working in.
 *
 * A plain form of submit buttons rather than a `<select>` with an onChange
 * handler: it works before JavaScript loads, each option is a real focusable
 * control, and the current course is announced by `aria-current` rather than
 * implied by colour alone. With two or three courses a segmented control is
 * also faster to use than a menu — the choice is visible without opening it.
 */
export function CourseSwitcher({
  courses,
  activeSlug,
  action,
  onSwitch,
}: {
  courses: { slug: string; title: string }[];
  activeSlug: string;
  action: (formData: FormData) => void;
  onSwitch?: () => void;
}) {
  // One course is not a choice, so nothing is rendered for it.
  if (courses.length < 2) return null;

  return (
    <form action={action} onSubmit={onSwitch}>
      <fieldset>
        <legend className="mb-1.5 text-xs font-semibold uppercase tracking-wide text-muted">
          Course
        </legend>
        <div className="flex flex-col gap-1">
          {courses.map((course) => {
            const isActive = course.slug === activeSlug;
            return (
              <button
                key={course.slug}
                type="submit"
                name="course"
                value={course.slug}
                aria-current={isActive ? 'true' : undefined}
                className={cx(
                  'rounded-lg px-3 py-2 text-left text-sm font-medium transition-colors min-h-[2.5rem]',
                  isActive
                    ? 'bg-[hsl(var(--accent-soft))] text-[hsl(var(--accent))]'
                    : 'text-muted hover:bg-[hsl(var(--bg-subtle))] hover:text-ink',
                )}
              >
                {course.title}
                {isActive ? <span className="sr-only"> (current course)</span> : null}
              </button>
            );
          })}
        </div>
      </fieldset>
    </form>
  );
}
