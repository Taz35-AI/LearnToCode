# Handover — HTML Hero → full front-end platform

> **Read this first if you are picking up this project in a new session.**
> It records the approved plan, what exists, and the decisions that cost real
> time to discover. The README describes the application; this describes the
> *work*.
>
> Last updated at commit `28c0de7`.

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
| **A** | Rebuild the learning engine on evidence | **Done** |
| **B** | Fix the HTML course's known gaps | Not started |
| **C** | Complete CSS course | Not started |
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
| Levels / modules / lessons | 12 / 20 / 48 |
| Lesson content blocks | 498 |
| Exercises / questions | 91 / 220 |
| Reviewable items | 195 |
| Tracked skills | 26 |
| Media assets | 38 (136 files, all CC0, self-generated) |
| Automated tests | 464 across 7 files |
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

### Part A, NOT delivered — be honest about this

The engine works and the `/review` page uses it. These pieces of the approved
Part A scope were **not** built:

- **Lesson warm-ups are not wired in.** `composeLessonWarmUp` exists and is
  tested, but no lesson renders one. Lessons still open with objectives, not
  with retrieval.
- **The new block types are unused.** `pretest`, `recall`, `predict_check`,
  `self_explain`, `worked_example` and `recap` exist in the enum and in the
  database. No authoring builders exist for them in `src/content/types.ts`,
  and no lesson uses one.
- **Module and level recaps do not exist.** The three-level recap structure
  (module recall → level cumulative review → cross-level queue) is only
  delivered at the third level, via `/review`.
- **Exercise review items are never served.** 79 of the 195 items are
  exercises; `/review` only renders questions. The composer selects them and
  then they are filtered out.
- **No calibration surfaced outside `/review`.** Ordinary lesson quizzes do
  not ask for confidence, so calibration only measures review answers despite
  the schema supporting it everywhere.

**Finish these before starting Part B**, because Part B authors ~40 new
lessons and they should use the new block types from the start rather than be
retrofitted.

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

Zero to professional: the cascade, specificity and inheritance; the box model;
Flexbox and Grid taught until fluent; responsive design and container queries;
custom properties; typography and colour systems; transitions and animation;
architecture and naming that scales; developer tools; and how CSS and HTML
relate. A graduate must be able to make their site *look* finished.

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
