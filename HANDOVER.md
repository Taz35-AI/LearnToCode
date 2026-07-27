# Handover — HTML Hero → full front-end platform

> **Read this first if you are picking up this project in a new session.**
> It records the approved plan, what exists, and the decisions that cost real
> time to discover. The README describes the application; this describes the
> *work*.
>
> Last updated after Part A was completed and verified against the live
> database, and Part B phase 1 (Level 8) was authored.

---

## 1. What the owner asked for

Turn a working HTML course into a complete front-end teaching platform —
**HTML → CSS → JavaScript** — built on learning techniques with real evidence
behind them rather than on intuition about what feels thorough.

Optimise for **shortest time to demonstrated mastery**, achieved by removing
redundancy and inefficient practice, *never* by cutting material. Nothing a
competent front-end developer actually needs may be trimmed.

The owner is the learner. They are a genuine beginner and intend to learn from
this themselves. That is why honesty about what is and is not finished matters
more here than usual: they will discover any gap by walking into it.

### Approved scope

| Part | Content | Status |
|---|---|---|
| **A** | Rebuild the learning engine on evidence | **Done and verified against the live database** |
| **B** | Fix the HTML course's known gaps | **Done** |
| **C** | Complete CSS course | **Foundation done**, content not started |
| **D** | Complete JavaScript course | Not started |

Order matters and was agreed: the engine changes how every later lesson is
authored, so authoring CSS or JS content first would mean rewriting it.

### Three decisions the owner explicitly approved

1. **Full depth, phased over multiple sessions.** Realistically 150–200
   lessons and 100+ hours of learner material — three to four times the
   current app. They chose depth over a tighter version.
2. **Relaxing the preview security boundary for JavaScript.** Running learner
   JS requires it. They agreed in principle; the design still has to be
   written down and justified (see §6).
3. **Start with Part A.** Done.

---

## 2. What exists now

A deployed, working application. Next.js 16 App Router, TypeScript strict,
Tailwind 4, Supabase auth + Postgres with RLS on every table.

| | |
|---|---|
| Levels / modules / lessons | 12 / 21 / 55 |
| Lesson content blocks | 664 (40 of them retrieval practice, across 18 lessons) |
| Exercises / questions | 105 / 241 |
| Reviewable items | 236 (both questions and exercises served) |
| Tracked skills | 26 |
| Media assets | 38 (136 files, all CC0, self-generated) |
| Automated tests | 582 across 9 files |
| RLS assertions | 29, against real PostgreSQL |

Live at `learn-to-code-nine.vercel.app`, Supabase project `fulazwoiwhtwumerjiex`.
Both `main` and `claude/html-hero-learning-app-g3oome` are kept on the same
commit; Vercel's production branch is the feature branch (see §7).

### Part A, delivered

- `src/lib/review/scheduler.ts` — FSRS 4.5 as published, with the fitted
  default weights. Stability / difficulty / retrievability, power-law
  forgetting, intervals to a 2-year cap.
- `src/lib/review/session.ts` — session composition: due items first,
  interleaved across skills, weighted toward weakness, resurfacing earlier
  levels. Also the lesson warm-up and the 7-day forecast.
- `src/lib/review/calibration.ts` — confidence vs outcome, Brier scoring,
  per-skill blind spots, plain-English verdicts.
- `supabase/migrations/0006_review_engine.sql` — `review_items`,
  `review_states`, `review_logs`, confidence on `quiz_attempts`, six new
  block types, `completion` exercise kind, RLS on all of it.
- `supabase/migrations/0007_deferrable_ordinals.sql` — ordering constraints
  checked at commit rather than per statement.
- `src/lib/data/review.ts`, `src/lib/actions/review.ts`,
  `src/app/(learn)/review/page.tsx`, `src/components/learn/review-session.tsx`.
- `src/lib/data/mastery.ts` — shared server-only mastery writer.

### Part A, remaining five items — delivered

The five gaps this document previously listed have been built.

- **The six retrieval block types are authored, rendered and validated.**
  Builders in `src/content/types.ts`: `pretest`, `recall`, `predictCheck`,
  `selfExplain`, `workedExample`, `activeRecap`. The last is named that way
  because `recap` was already taken by the `summary` builder that 48 lessons
  call — do not rename it. `blockProblems()` lives beside them and the seed
  generator calls it, so a pretest with one option or a worked example with no
  reasoning fails the build with a message naming the lesson. Renderers are in
  `lesson-blocks.tsx`; every one withholds its answer until the learner
  commits, which is asserted per type in `components.test.tsx`.
- **Lesson warm-ups are wired in.** `getLessonWarmUp` composes them,
  `LessonWarmUp` renders them at the top of every lesson. Questions only,
  drawn from earlier lessons and never the current one, skippable rather than
  a gate. `warmUpSkillsFor` is the pure skill-derivation function.
- **Exercise review items are served.** `getReviewExercises` +
  `answerReviewExerciseAction` + the exercise branch of `ReviewSession`. Graded
  by the same evaluator and the same requirement rows as the lesson, via the
  shared `requirementFromRow`. No XP, and deliberately **not** written to
  `exercise_attempts` — that table feeds the first-pass streak the achievements
  are computed from.
- **Confidence is asked on ordinary lesson quizzes**, and required rather than
  optional: an optional rating is filled in when the learner feels sure and
  skipped when they do not, so the report would be built from a sample selected
  by the bias it exists to measure. `getCalibrationHistory` now also folds in
  `review_logs` confidence for *exercise* items, which have no `quiz_attempts`
  row.
- **Module recall and level cumulative review exist**, at
  `/review/module/[slug]` and `/review/level/[slug]`, linked from the roadmap
  and from `/review`. All three surfaces share `composeSession`.

No migration was needed: everything the five items required was already in
0006. The TypeScript enums in `database.types.ts` were, however, missing all
six block types, `completion` and `review` — they had been added to the
database and never to the types. Adding them immediately surfaced a real gap
(`completion` had no label in the workbench).

### Verified in the running application

Every item above was exercised against the live Supabase project and in a
browser, not only under test: the warm-up drawing a real question from a
previously studied lesson; all six block types rendering and withholding their
answers; an exercise reviewed, graded, failed, re-queued and passed on the
retry; a session run to completion; and the calibration blind-spot detector
firing on real answers.

**The review pool had never actually been loaded.** `review_items` held zero
rows on the live database — the seed that builds the pool was generated but
never applied — so `/review` had been serving nothing at all. Fixed, and the
health check now asserts the pool is present, because it previously reported
PASS on a database missing the entire feature.

### Still not done

- **Only 10 of the 52 lessons use a retrieval block** (23 blocks). Deliberate:
  prove the pipeline, then author broadly rather than retrofit twice. All six
  types are used, and `curriculum.test.ts` fails if that stops being true.

---

## 3. Decisions that are load-bearing — do not casually reverse

Each of these cost real time to find. The reasoning is in the code comments
and commit messages too, but they are collected here because a fresh session
will otherwise re-derive them the hard way.

### The seed must never delete catalogue rows

Learner progress references the catalogue by foreign key with `ON DELETE
CASCADE`. Deleting a lesson to re-insert it **deletes every learner's progress
through it**. This was a real bug, proven and fixed: five progress rows in,
zero out.

Everything a learner can reference is upserted by slug. Only rows nothing owns
(blocks, requirements, options, join tables) are replaced wholesale. Content
genuinely removed from `src/content/` is deleted at the end of the seed, which
is the one place learner data is legitimately lost.

**If you add a catalogue table that learner data references, it must upsert.**

### `middleware`, not `proxy`

Next 16 deprecates the `middleware` file convention in favour of `proxy` and
prints a warning on every build. **Do not follow that advice.** `proxy` builds
cleanly and then Vercel serves 404 for every path the matcher covers — the
deployment reports success while the site is entirely dead. This was diagnosed
the expensive way.

The entry point is `src/middleware.ts` — inside `src/`, importing relatively.
A root-level `middleware.ts` importing via the `@/` alias fails Vercel's Edge
Function packaging with "referencing unsupported modules", passing `next build`
and failing deployment.

### `vercel.json` pins the framework

The Vercel project was created when `main` held only a README, so framework
detection found no `package.json`, fell back to "Other", and kept that setting
permanently. It ran `next build` and then published `public/` as a static
site — every page 404, every asset fine. `vercel.json` declares
`"framework": "nextjs"` so this cannot recur.

### Row types are `type` aliases, never `interface`

In `src/lib/supabase/database.types.ts`. An interface has no implicit index
signature and will not satisfy postgrest's `GenericSchema`, producing dozens of
inscrutable `never` errors. Adding a table means adding a `type X = {…}` and
registering it in the `Tables` map.

### Nothing that writes progress may be exported from a `'use server'` file

Every export of such a module is an endpoint the browser can call. A mastery
writer exported there lets a client set its own skill levels and unlock
modules without answering anything. Shared write helpers go in `server-only`
modules — see `src/lib/data/mastery.ts`.

### Time is always an argument

`evaluateModuleGate` takes no clock. Neither does anything in
`src/lib/review/`. This is what makes "unlocked by understanding, never by a
day number" enforceable rather than merely claimed, and it is why a schedule
years out can be asserted exactly in a test. Do not introduce `Date.now()`
into these modules.

### XP and review history are append-only

`xp_transactions` has `UNIQUE (user_id, source_type, source_id)`, so a replayed
request cannot pay twice. `review_logs` has no UPDATE or DELETE policy — under
RLS the absence of a policy is a denial, so a learner cannot rewrite their own
review history even though they own it. A learner who can rewrite it can
manufacture a schedule.

### Assessment questions are not review items

Recycling the questions that measure learning as practice turns the measurement
into a memory test of itself. Project missions are excluded too — they build
the learner's own site and mean nothing repeated out of context.

---

## 4. Part B — fix the HTML course's known gaps

### Part B — delivered

| | before | after |
|---|---|---|
| Lessons | 48 | 55 |
| Exercises | 91 | 105 |
| Questions | 220 | 241 |
| Content blocks | 498 | 664 |
| Lessons with an interactive demo | 13 | **55 — all of them** |
| Media assets never shown | 14 | **0** |
| Retrieval-practice blocks | 0 | 40, across 18 lessons |

**B1 — Level 8 Accessibility.** 3 lessons → 7, split into `accessibility-foundations`
and a new `aria-and-accessible-forms`; Level 9's prerequisite re-pointed at the
later module. New: `keyboard-and-focus-management`, `accessible-names-in-depth`,
`aria-live-and-state`, `accessible-forms-in-depth`.

**B2 — Levels 10 and 11.** `third-party-and-embeds` (the real cost of an embed,
and the placeholder pattern) and `a-method-for-debugging` (bisection, minimal
reproductions, one change at a time).

*A lesson was written and then deleted here.* An images/layout-stability lesson
duplicated the existing `loading-strategy` almost entirely — dimensions, lazy,
`fetchpriority`, resource hints. Two lessons teaching the same attributes from
scratch is exactly the redundancy this project optimises against, so it was
removed and `third-party-and-embeds` trimmed to cross-reference rather than
re-teach. **If you extend a level, read its existing lessons first.**

**B3 — Level 9.** `language-and-internationalisation`: `lang`, `dir`, and why a
wrong `lang` is worse than a missing one.

**B4 — Demonstrations.** Every one of the 55 lessons now has an
`interactive_demo`. This was 13 of 48.

**B5 — Media.** All 38 assets are now shown somewhere they teach something —
audio in the audio lesson, the reflow video where responsive layout is taught,
the neutral placeholder where decorative alt text is explained.

**B6 — Cumulative review.** `recall` blocks in the milestones of Levels 6 and
8–12, each reaching back several levels by name. This complements
`/review/level/[slug]`, which resurfaces earlier material automatically.

Every new lesson opens with a `pretest` and closes with an `activeRecap`, and
uses at least one of `predict_check`, `self_explain` or `worked_example`.

### Notes for whoever extends this

- **The health check regenerates itself.** `npm run seed:generate` rewrites the
  expected counts in `supabase/tests/verify-database.sql`, and
  `curriculum.test.ts` asserts the two agree. Do not hand-edit those numbers.
- **A reference solution must pass its own requirements**, so an exercise
  cannot ask the learner to leave something broken. One was rewritten from
  "reduce but keep the fault" to "reduce, then repair" for this reason.
- **Backticks belong in prose fields only.** `code`, term `example`, starter
  code and reference solutions are rendered verbatim; a test enforces this.

### The original Part B assessment, for reference

Assessed from the database, not impressions:

| Levels | Lessons | Exercises |
|---|---|---|
| 1–4 (fundamentals) | 22 | 47 |
| 7–12 (professional) | 18 | 29 |

The coverage tapers exactly where it should deepen.

1. **Levels 8–11 are thin and matter most.** Accessibility is 3 lessons, 5
   exercises, ~29 minutes of teaching — ARIA gets 15 minutes, and bad ARIA is
   worse than none. Performance/security and debugging get 4 exercises each.
   Roughly double all four.
2. **Only 13 of 48 lessons have an interactive demo.** Every lesson should.
3. **38 media assets exist; 2 lessons use a dedicated media block.** 14 assets
   are never shown at all (the seed generator warns about this on every run).
4. **No cumulative review of earlier levels inside later ones.**

Content lives in `src/content/levels/level-NN.ts` as typed TypeScript, compiled
by `npm run seed:generate`, which validates everything — unknown skill slugs,
missing media, duplicate exercise slugs, questions with no correct answer and
prerequisite cycles all fail the build with a specific message.

---

## 5. Part C — CSS course

### Foundation — done

Both engineering prerequisites this section warned about are built and tested.

**Multi-course programme.** `supabase/migrations/0008_multi_course.sql` adds
`courses.ordinal`, `accent`, `outcome` and `is_published`, plus a
`course_prerequisites` table. Nothing was dropped or rebuilt: every column has a
default that leaves the HTML course where it was, because a learner's plan and
certificate cascade from `courses.id`.

Content is now a programme. `CourseSpec` in `src/content/types.ts`, courses in
`src/content/courses/`, and `course.ts` exposes `COURSES`, `publishedCourses()`,
`programmeStats()` and per-course `courseStats(course)`. The seed generator
emits every course and reports each one separately, marking unpublished ones.

**`isPublished: false` is the mechanism that matters.** The CSS course is
seeded, loadable and testable while being invisible to learners and absent from
every statistic. The alternative — a long-lived branch — means content that is
never seeded and never actually run until it all lands at once.

**The CSS evaluator.** `src/lib/evaluator/css-parse.ts` and `css-cascade.ts`,
with 43 tests in `tests/css-evaluator.test.ts`. It resolves specificity,
`!important`, source order, inline styles, inheritance, `@media` conditions and
`var()` substitution — then requirements ask about the *resolved* value.

Nothing matches source text, which is what keeps the HTML evaluator's promise
intact for CSS: `tests/css-evaluator.test.ts` asserts that four genuinely
different stylesheets reaching the same colour all grade identically.

Three real bugs were found by those tests and fixed: `:root` never matched (the
HTML parser has no such selector, so every `var()` resolved empty), media
queries compared with significant whitespace, and a stray `}` silently discarded
the rest of a stylesheet — which would have let broken CSS pass.

### Still to build

The twelve levels. The planned order is in `src/content/courses/css.ts` and
starts with the cascade rather than ending with it, because nearly every hour
lost to CSS is a cascade misunderstanding. The capstone styles the site the
learner already built in the HTML course.

### The original Part C assessment, for reference

**Technical work this requires:**

- **Multi-course schema.** A `courses` table exists and levels reference it,
  but nothing else is course-aware — the roadmap, dashboard, pace model and
  gating all assume one course. Needs a course dimension and cross-course
  prerequisites, with a migration that preserves existing progress.
- **A CSS evaluator.** The current evaluator inspects HTML structure. CSS needs
  its own, checking applied/computed results and declarations, never string
  comparison — matching the existing principle that different valid solutions
  all pass. `src/lib/evaluator/` is the model to follow: a DOM pass plus a
  source pass that catches what parsers silently repair.

---

## 6. Part D — JavaScript course

Zero to front-end capable: values, types, control flow; functions and scope;
arrays and objects; the DOM and events; forms and validation; asynchrony,
fetch and error handling; modules; debugging; testing basics; building real
interactive features on their own HTML and CSS.

### The security boundary — the largest risk in the whole plan

The preview iframe is currently `sandbox=""`: no `allow-scripts`, no
`allow-same-origin`, no `allow-forms`. **Script execution is impossible by
construction.** That is one of the three security boundaries the README
documents, and it is deliberate.

Running learner JavaScript requires relaxing it. The owner has agreed in
principle. Before writing any of it, the design must be recorded:

- Isolated execution with no access to the parent origin
- No session, cookie or token exposure
- Resource and timeout limits, so an infinite loop cannot hang the tab
- **Behavioural tests, not output-string matching** — the same principle as
  the HTML evaluator
- A written threat model justifying the change

`src/lib/preview/sanitise.ts` holds the current sanitiser and CSP. Do not
quietly widen `sandbox` — the change deserves its own commit and its own
explanation.

---

## 7. Operational notes

### Repository

- Develop on `claude/html-hero-learning-app-g3oome`; `main` carries the same
  commits. Push both.
- **Vercel's production branch is the feature branch**, not `main`. A push to
  `main` alone builds a *preview* and never reaches the domain. This caused
  hours of confusion. Either push both branches, or change Vercel →
  Settings → Git → Production Branch to `main`.
- Vercel can skip building two branches that point at the same commit, so a
  no-op push may not trigger a deployment.

### Commands

```bash
npm run check           # lint, typecheck, 464 tests, production build
npm run test:rls        # 29 RLS assertions (needs PostgreSQL binaries)
npm run seed:generate   # validate the curriculum and write seed.sql
npm run seed:split      # split seed.sql into browser-pasteable parts
npm run media:verify    # runs as part of build; fails on any missing asset
```

`supabase/tests/verify-database.sql` is a read-only health check for a live
database — paste it into the Supabase SQL editor after any migration or seed.

### Applying changes to the owner's database

They have the Supabase CLI linked. Migrations `0001`–`0005` were applied by
hand before the CLI existed, then repaired into its history, so
`supabase db push` works normally now.

The seed is 1.3 MB — too large for the SQL editor in one piece, hence
`supabase/seed-parts/01.sql` … `08.sql`. **Regenerate the parts whenever
`seed.sql` changes**, or they silently drift.

### Environment

The cloud sandbox **cannot reach `*.supabase.co`** (network policy) or the
owner's localhost. Every database operation must be handed to them as SQL or a
command. A session running on their own machine does not have this limitation
and is markedly better for this project — that is why this document exists.

**A local session still needs credentials, and as of this writing they are not
on disk.** There is no `.env.local` in the repository root, only an empty
`.env.local.txt`, and the Supabase CLI is linked to `fulazwoiwhtwumerjiex` but
not authenticated (`supabase projects list` → *"Access token not provided"*).
So a local session can build, lint, typecheck and test, and can do nothing at
all against the database or in a browser.

`psql` is **not** required. The CLI does the same jobs:

```bash
supabase db push  --db-url "<direct connection string>"
supabase db query --db-url "<direct connection string>" -f supabase/seed.sql
supabase db query --db-url "<direct connection string>" -f supabase/tests/verify-database.sql
```

The connection string is in Supabase under Project Settings → Database. That
one value plus a populated `.env.local` unblocks everything.

---

## 8. Standing expectations

From the owner, and worth keeping:

- Report honestly at each phase, **including shortfalls**. An overstated claim
  is worse than a gap, because they will find it by walking into it.
- No feature left as a TODO. Nothing described as working unless it has been
  run.
- Define measurable mastery criteria; never claim "guaranteed" learning.
- Every new term defined before it is used.
- Accessibility and keyboard operability maintained throughout.
- Lint, typecheck, tests and build all pass; new logic gets new tests.
- No rewrite, no redesign of the visual language, no dependency that has not
  earned its place.
