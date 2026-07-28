# HTML Hero

A mastery-based interactive learning platform that takes a complete beginner —
someone who has never written a tag — to building, validating, improving,
exporting and publishing a professional multi-page website in modern HTML.

The course is **not** organised as Day 1, Day 2, Day 3. It is organised as
twelve mastery levels containing modules, lessons, exercises, debugging
challenges, knowledge checks and milestone projects. A module unlocks when the
learner has demonstrated the skills it builds on — never because time has
passed. Thirty days at 45–75 minutes a day is the recommended target, and the
application derives a personalised, continuously-updated estimate from what the
learner has actually completed.

---

> **Continuing this project?** Read [`HANDOVER.md`](HANDOVER.md) first — it
> records the approved plan, what is and is not finished, and the decisions
> that are load-bearing.

## Contents

- [What is in the box](#what-is-in-the-box)
- [Technology stack](#technology-stack)
- [Architecture](#architecture)
- [Folder structure](#folder-structure)
- [Prerequisites](#prerequisites)
- [Local installation](#local-installation)
- [Supabase setup](#supabase-setup)
- [Environment variables](#environment-variables)
- [Database migrations](#database-migrations)
- [Seeding the course](#seeding-the-course)
- [Media asset setup](#media-asset-setup)
- [Media licensing and attribution](#media-licensing-and-attribution)
- [Development commands](#development-commands)
- [Testing](#testing)
- [Production build](#production-build)
- [Deployment](#deployment)
- [Security notes](#security-notes)
- [Editing the course](#editing-the-course)
- [Known limitations](#known-limitations)

---

## What is in the box

The platform now teaches **two courses**. HTML Hero comes first; CSS Architect
depends on it and styles the site the learner built there.

| | HTML Hero | CSS Architect | Programme |
|---|---|---|---|
| Mastery levels | 12 | 12 | 24 |
| Modules | 21 | 12 | 33 |
| Interactive lessons | 55 | 37 | 92 |
| Lesson content blocks | 664 | 342 | 1,006 |
| Coding exercises | 105 | 50 | 155 |
| Debugging challenges | 32 | 20 | 52 |
| Capstone project missions | 12 | 1 | 13 |
| Knowledge-check and assessment questions | 241 | 175 | 416 |
| Milestone assessments | 12 (with the final) | 12 (with the final) | 24 |

| | |
|---|---|
| Tracked skills | 26 |
| Spaced-repetition items | 376 |
| Achievements | 22 |
| Capstone project types | 10 |
| Learning-media assets | 38 (136 files) |
| Estimated learner time | ~2,163 minutes (~36 hours) |
| Automated tests | 704 |

### HTML Hero — the twelve levels

1. **HTML Explorer** — how the web works, tags, elements, attributes, nesting, the document skeleton
2. **Content Builder** — headings, paragraphs, text semantics, quotations, dates, entities, lists
3. **Navigation Architect** — links, relative paths, fragments, menus, breadcrumbs, skip links
4. **Media Specialist** — images, alt text, `srcset`, `<picture>`, video, audio, captions, iframes
5. **Structure Professional** — semantic landmarks, sections vs articles, project organisation
6. **Data and Forms Builder** — accessible tables, forms, validation attributes, GET vs POST
7. **Native Interaction Expert** — `details`, `dialog`, `popover`, `progress`, `meter`, `datalist`
8. **Accessibility Champion** — the accessibility tree, keyboard testing, WCAG 2.2 AA, ARIA
9. **Metadata, SEO and Discoverability** — titles, descriptions, canonicals, Open Graph, JSON-LD
10. **HTML Performance and Security** — loading strategy, `defer`, sandboxing, referrer policy, CSP
11. **Debugging and Validation Master** — validator output, developer tools, methodical repair
12. **HTML Hero Capstone** — assembling, reviewing, exporting and publishing the finished site

Every level ends with a milestone project and an assessment the learner must
pass to progress.

### CSS Architect — the twelve levels

1. **The Cascade** — what a rule is, specificity, inheritance, diagnosis
2. **Boxes and Selectors** — the four layers, `box-sizing`, combinators, attribute selectors
3. **Flow, Position and Stacking** — normal flow, positioning, z-index and stacking contexts
4. **Flexbox** — main and cross axes, growing, shrinking, distributing space
5. **Grid** — tracks, areas, implicit rows, and responsive grids with no media queries
6. **Responsive Design** — fluid values, content-derived breakpoints, container queries
7. **Custom Properties** — design tokens that live in the cascade, and theming
8. **Typography and Colour** — measure, leading, scale, and the contrast requirements
9. **Transitions and Motion** — what is cheap to animate, and `prefers-reduced-motion`
10. **Architecture and Scale** — naming, flat specificity, `@layer`, deletable CSS
11. **Debugging CSS** — the inspector, computed values, and the six usual causes
12. **Capstone: Styling Your Site** — styling the site built in the HTML course

The cascade is taught **first** rather than last, because nearly every hour lost
to CSS is a cascade misunderstanding rather than a missing property. Exercises
are graded on the **resolved** value the cascade produced, never on source text,
so any correct route passes.

---

## Technology stack

- **Next.js 16** (App Router, React Server Components, Server Actions)
- **TypeScript 5.9** in strict mode, plus `noUncheckedIndexedAccess`
- **Tailwind CSS 4** with CSS-variable design tokens
- **Supabase** — Auth (cookie sessions via `@supabase/ssr`) and PostgreSQL
- **CodeMirror 6** for the HTML editor, loaded client-side only
- **Zod 4** for validation, shared between client and server
- **node-html-parser** for structural evaluation
- **Vitest** + Testing Library for tests

Dependencies were kept deliberately few. There is no state-management library,
no component library, no ZIP library (project export writes the archive
directly), no icon package (icons are inline SVG) and no markdown parser.

---

## Architecture

### Rendering and data flow

Pages are React Server Components that read through a server-only data layer
(`src/lib/data/`). All mutations are Server Actions (`src/lib/actions/`). The
browser never talks to the database directly for anything that affects
progress.

### The three security boundaries

**1. Row Level Security.** Every learner-owned table carries a policy of
`auth.uid() = user_id` for select, insert, update and delete. A learner cannot
read or write another learner's rows even with a crafted request. This is
verified end-to-end against a real PostgreSQL server by `npm run test:rls`,
which asserts 29 properties including cross-user isolation, catalogue
read-only-ness and the append-only XP and review ledgers.

**2. Answer keys never reach the browser.** `quiz_options.is_correct` and
`exercises.reference_solution` are stripped in the data layer before a page
renders. A reference solution is only included once the learner has actually
passed that exercise. Grading happens exclusively in Server Actions using
criteria loaded from the database — nothing the client sends is trusted.

**3. Preview isolation.** Learner-authored HTML renders inside an iframe with
`sandbox=""` — no `allow-scripts`, no `allow-same-origin`, no `allow-forms`.
Script execution is impossible at the browser level. As defence in depth, the
markup is also passed through a sanitiser that removes `<script>`, inline event
handlers, `javascript:` URLs and remote asset references, and a restrictive
Content-Security-Policy is injected into the preview document. Anything removed
is reported to the learner rather than silently dropped.

### Duplicate-XP prevention

`xp_transactions` has `UNIQUE (user_id, source_type, source_id)`. Every award is
keyed by its source, so re-submitting a solved exercise is rejected by the
database rather than by an application code path that could be bypassed. The
same pattern protects achievements and streak milestones.

### The evaluator

Exercises are graded **structurally, never by string comparison**. Requirements
are rows in `exercise_requirements` describing shape: required elements, counts,
attribute presence and values, nesting, accessible names, alt-text quality,
heading order, duplicate ids, unsafe scripts and local media resolution. Two
learners writing entirely different prose both pass, provided the structure is
right — a property asserted directly in `tests/evaluator.test.ts`.

The evaluator runs two passes. A DOM pass (via `node-html-parser`) answers
structural questions the way a browser would. A hand-written source scanner
catches what a DOM parser silently repairs: unclosed tags, stray closing tags,
overlapping elements, unterminated attribute quotes, and invalid nesting a
browser auto-closes (such as a `<div>` inside a `<p>`). Those repairs are the
mistakes beginners actually make, and they would otherwise be invisible.

### Mastery and pacing

Skill mastery is an exponentially weighted moving average over evidence, with
evidence weighted by how much it proves — a coding exercise counts more than a
multiple-choice answer, and a success reached with four hints counts less than a
clean one. A skill is only *mastered* when the score is high **and** there are at
least three pieces of evidence, so a single lucky answer never masters anything.

`evaluateModuleGate` takes no clock argument at all. Unlocking is a pure
function of completed prerequisites and demonstrated mastery — the course's
central promise, enforced by construction.

Pacing is separate from the curriculum. `recommendPace` turns the learner's
onboarding answers into a plan (with a 0.85 realism factor, because
self-reported study time is optimistic), and `buildPaceReport` compares it with
the lessons actually completed to produce a live completion estimate.

---

## Folder structure

```
├── next.config.ts                 Security headers
├── public/learning-media/         All course media (generated, CC0)
│   ├── images/                    Raster scenes at 480/800/1200/1600 px, JPEG + WebP
│   ├── svg/                       Hand-authored diagrams
│   ├── icons/                     24×24 line icons
│   ├── video/                     MP4 + WebM explainers
│   ├── posters/                   Video poster images
│   ├── captions/                  WebVTT caption files
│   └── audio/                     MP3 + WAV clips
├── scripts/
│   ├── generate_media.py          Generates every media asset from scratch
│   ├── verify-media.ts            Fails the build on any missing asset
│   ├── generate-seed.ts           Compiles the curriculum into SQL
│   ├── split-seed.ts              Splits seed.sql for the Supabase SQL editor
│   └── test-rls.sh                Verifies RLS against real PostgreSQL
├── supabase/
│   ├── migrations/                0001–0005, applied in filename order
│   ├── tests/                     RLS assertions + local Supabase shim
│   ├── seed.sql                   Generated — do not edit by hand
│   └── seed-parts/                The same seed split into pasteable files
├── src/
│   ├── middleware.ts              Session refresh + route protection
│   ├── app/
│   │   ├── (auth)/                Sign in, register, password reset
│   │   ├── (learn)/               Protected learner routes
│   │   ├── auth/callback/         Email-link session exchange
│   │   ├── onboarding/            The six-step plan builder
│   │   └── page.tsx               Public landing page
│   ├── components/
│   │   ├── ui/                    Design-system primitives and icons
│   │   ├── editor/                Editor, preview, media picker, workbench
│   │   ├── learn/                 Lesson renderer, quiz, shell, onboarding
│   │   └── auth/                  Authentication forms
│   ├── content/
│   │   ├── levels/                level-01.ts … level-12.ts — the curriculum
│   │   ├── media/manifest.ts      Media library with licence metadata
│   │   ├── skills.ts              The 26 tracked skills and their graph
│   │   ├── achievements.ts        Achievement definitions
│   │   ├── projects.ts            The 10 capstone project types
│   │   ├── types.ts               Authoring format and builders
│   │   └── course.ts              Course assembly and statistics
│   └── lib/
│       ├── supabase/              Browser, server, admin clients + types
│       ├── data/                  Server-only read layer
│       ├── actions/               Server Actions and Zod schemas
│       ├── evaluator/             Structural HTML evaluation
│       ├── preview/               Sanitising and the starter stylesheet
│       ├── progress/              XP, mastery, pace, achievements
│       └── project/               Capstone checklist and export
└── tests/                         594 tests across 9 files
```

---

## Prerequisites

- **Node.js 20.9+** and npm
- A **Supabase** project (the free tier is sufficient)
- **Python 3.9+** with `pillow` and `imageio-ffmpeg` — only if you want to
  regenerate the media; the generated files are committed

---

## Local installation

```bash
git clone <your-fork-url> html-hero
cd html-hero
npm install
cp .env.example .env.local     # then fill in the Supabase values
npm run dev
```

The application runs at <http://localhost:3000>. Without Supabase credentials
it starts and shows a setup screen explaining exactly what is missing rather
than crashing.

---

## Supabase setup

1. Create a project at [supabase.com](https://supabase.com).
2. Copy the **Project URL** and **anon public** key from
   *Project Settings → API* into `.env.local`.
3. Under *Authentication → URL Configuration*, set the **Site URL** to
   `http://localhost:3000` and add `http://localhost:3000/auth/callback` to the
   redirect allow-list. Add your production URLs there too when you deploy.
4. Under *Authentication → Providers → Email*, decide whether to require email
   confirmation. With it on, a new learner receives a confirmation link and the
   registration form says so; with it off they are signed straight in.
5. Apply the migrations and load the seed (below).

---

## Environment variables

| Variable | Scope | Purpose |
|---|---|---|
| `NEXT_PUBLIC_SUPABASE_URL` | Public | Your project URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Public | The anon key — public by design; RLS governs access |
| `NEXT_PUBLIC_SITE_URL` | Public | Canonical origin for auth redirect URLs |
| `SUPABASE_SERVICE_ROLE_KEY` | **Server only** | Bypasses RLS. Needed only for seeding and maintenance |

The service-role key is read exclusively through `serverEnv()` in
`src/lib/env.ts`, which throws if called in the browser. Nothing under
`src/app` imports it, and the application does not need it at runtime.

---

## Database migrations

Apply in filename order.

**With the Supabase CLI:**

```bash
supabase link --project-ref <your-project-ref>
supabase db push
```

**Or with the SQL editor** — paste and run each file in turn:

| File | Contents |
|---|---|
| `0001_foundation.sql` | Extensions, enums, the `updated_at` trigger |
| `0002_catalogue.sql` | 18 course-catalogue tables, indexes, triggers |
| `0003_learner.sql` | 14 learner-owned tables and the new-user bootstrap |
| `0004_rls.sql` | Row Level Security on every table |
| `0005_views.sql` | Reporting views with `security_invoker` |
| `0006_review_engine.sql` | Spaced repetition, review history, calibration |
| `0007_deferrable_ordinals.sql` | Ordering constraints checked at commit, not per statement |

---

## Seeding the course

The curriculum is authored as typed TypeScript under `src/content/`, then
compiled into normalised SQL:

```bash
npm run seed:generate
```

This validates the whole course before emitting anything — unknown skill slugs,
missing media, duplicate exercise slugs, questions with no correct answer and
prerequisite cycles all fail the build with a specific message. It then writes
`supabase/seed.sql`, roughly 3,100 idempotent statements.

Load it into your project:

```bash
psql "$SUPABASE_DB_URL" -f supabase/seed.sql
```

The seed is idempotent, and re-running it preserves learner progress.

That is worth spelling out, because it is easy to get wrong and expensive when
you do. Learner progress hangs off the catalogue by foreign key, and those keys
cascade: deleting a lesson to re-insert it deletes every learner's progress
through it, along with their quiz attempts, exercise attempts, saved code and
review schedule. So every row a learner can reference — levels, modules,
lessons, exercises, questions, assessments, skills, achievements and project
templates — is matched on its slug and **updated in place**, never dropped and
rebuilt. Only rows nothing owns are replaced wholesale: lesson blocks,
exercise requirements, quiz options and the join tables.

Content genuinely removed from `src/content/` is deleted at the end of the
seed. That is the one place learner data is lost, and it is correct: progress
through a lesson that no longer exists has nowhere to live.

Ordering constraints are deferrable so that inserting a lesson in the middle of
a module — which renumbers everything after it — does not transiently violate
`(module_id, ordinal)` part-way through the transaction.

### Without a terminal

`seed.sql` is about 1.2 MB, which is too much to paste into the SQL editor in
one go. `supabase/seed-parts/` holds the same statements split into seven
files of roughly 175 KB, so the whole course can be loaded from the browser
with nothing installed:

```bash
npm run seed:split   # regenerates the parts from seed.sql
```

Open each part, copy it, paste it into the Supabase SQL editor and run it —
**in order**, 01 through 07. Part 01 clears the catalogue and later parts
insert rows referencing earlier ones, so order matters; if a part fails, start
again from 01.

The split happens on statement boundaries found by scanning for quoting and
dollar-quoted blocks, not by counting lines, so lesson text containing
semicolons cannot break a file. Loading the parts produces a byte-identical
catalogue to loading `seed.sql` — verified by comparing content hashes of
lesson blocks, exercise requirements, quiz options and the lesson tree.

---

## Media asset setup

Every image, video, audio clip, poster and caption file used by the course is
**generated from scratch by this repository**, committed, and served locally.
Nothing is downloaded at build or run time and nothing is hotlinked, so every
lesson works offline.

The generated files are committed, so no action is needed for a normal install.
To regenerate them:

```bash
pip install pillow imageio-ffmpeg
npm run media:generate
```

`scripts/generate_media.py` renders the raster scenes with Pillow, writes the
SVG diagrams and icons as hand-authored markup, encodes the videos from
generated frames with ffmpeg, and synthesises the audio from mathematical
expressions.

`npm run media:verify` runs as the first step of `npm run build` and fails if
any path declared in the manifest is missing or zero bytes — a broken image
cannot reach production.

---

## Media licensing and attribution

**Every asset is released under [CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/)**
(a public-domain dedication). Learners may use any of it in their own projects,
including commercially, with no attribution required.

This position is unambiguous because none of it is third-party work: the raster
scenes are rendered procedurally from code, the diagrams and icons are
hand-authored SVG, the videos are encoded from generated frames, and the audio
is synthesised. No asset is a photograph of a real place or person, and none
derives from an existing work.

For every asset, `src/content/media/manifest.ts` records the title, creator,
source, licence, licence URL, attribution text, local path and retrieval date.
The same data is seeded into `media_attributions` and displayed on the in-app
`/media` page.

### If you add third-party media

The manifest and the `media_attributions` table already have fields for it.
Before adding anything:

1. Verify the licence of **that individual file** — do not assume a site-wide
   licence applies to every asset on it.
2. Download it into `public/learning-media/`; never hotlink.
3. Record title, creator, source URL, licence, licence URL, required
   attribution text and the retrieval date.
4. Add it to `MEDIA_ASSETS` and run `npm run media:verify`.
5. If attribution is required, the `/media` page displays it automatically.

Do not add anything whose licensing is unclear.

---

## Development commands

| Command | What it does |
|---|---|
| `npm run dev` | Development server at localhost:3000 |
| `npm run build` | Verifies media, then builds for production |
| `npm start` | Serves the production build |
| `npm run lint` | ESLint, including the React purity rules |
| `npm run typecheck` | `tsc --noEmit` in strict mode |
| `npm test` | The full Vitest suite |
| `npm run test:watch` | Vitest in watch mode |
| `npm run test:rls` | RLS verification against a throwaway PostgreSQL |
| `npm run media:generate` | Regenerates every media asset |
| `npm run media:verify` | Checks every declared asset exists |
| `npm run seed:generate` | Validates the curriculum and writes `seed.sql` |
| `npm run seed:split` | Splits `seed.sql` into browser-pasteable parts |
| `npm run check` | lint → typecheck → test → build |

---

## Testing

```bash
npm test          # 594 tests
npm run test:rls  # 21 database-level assertions (needs PostgreSQL)
```

| File | Covers |
|---|---|
| `evaluator.test.ts` | Structural evaluation, every requirement kind, accessible names, alt-text quality, source scanning, nesting rules, media-path validation |
| `progress.test.ts` | XP rules and duplicate prevention, learner levels, mastery, module gating, adaptive practice, pace, streaks, achievements |
| `curriculum.test.ts` | Every reference solution passes its own requirements; no starter code already passes; media, skills and prerequisites all resolve; no graph cycles; quiz integrity; retrieval-block validation; the 30-day calibration |
| `preview-and-export.test.ts` | Preview sanitising and CSP, ZIP export and CRC-32, the capstone checklist |
| `components.test.tsx` | Accessible names, ARIA on progress bars, field associations, lesson-block rendering, retrieval blocks withholding their answers, quiz behaviour and confidence |
| `review-ui.test.tsx` | The review session and lesson warm-up: confidence collected before the answer, answers withheld until commitment, exercises served, failed items re-queued |
| `auth-and-validation.test.ts` | Route protection through the real middleware, and every Zod schema |
| `supabase/tests/rls.sql` | Cross-user isolation, read-only catalogue, append-only XP, anonymous access limits |

Two of these deserve a mention because they are the ones that stop the course
shipping broken: `curriculum.test.ts` runs **every one of the 91 reference
solutions through the real evaluator** and requires it to pass its own
requirements, and separately requires that no starter code already passes —
which would make an exercise a no-op.

---

## Production build

```bash
npm run check   # lint, typecheck, test, build
```

All four must pass before deploying. `npm run build` runs the media check
first, so a missing asset fails the build rather than reaching users.

---

## Deployment

The application is a standard Next.js app and deploys anywhere Next.js runs.

**Vercel:**

1. Import the repository.
2. Add `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY` and
   `NEXT_PUBLIC_SITE_URL` (your production domain).
3. Do **not** add `SUPABASE_SERVICE_ROLE_KEY` — it is not needed at runtime.
4. In Supabase, add your production URL and `/auth/callback` to the redirect
   allow-list.

**Self-hosting or Docker:** `npm run build` then `npm start`, with the same
environment variables. Node 20.9+ is required.

---

## Security notes

- **RLS on every learner table**, verified against a real database in CI-able
  form by `npm run test:rls`.
- **The anon key is public by design.** It grants nothing on its own; RLS
  decides what each request may do.
- **The service-role key never reaches the browser.** It is read only through
  `serverEnv()`, which throws if called client-side, in a module marked
  `import 'server-only'`.
- **Learner code cannot execute.** The preview iframe has `sandbox=""` with no
  `allow-scripts`, plus sanitising and a restrictive CSP as defence in depth.
- **Grading is server-side.** Requirements come from the database; the client's
  claims about hints, duration and correctness are validated and bounded.
- **XP cannot be farmed.** Uniqueness is enforced by a database constraint.
- **The XP ledger is append-only** — the update and delete policies are dropped
  deliberately, so a total can be trusted.
- **Auth responses do not leak account existence.** Wrong password and unknown
  address return the same message, and password reset always reports success.
- **Redirects are validated** as same-origin relative paths, so a crafted
  `?next=` cannot bounce a signed-in learner elsewhere.
- **Security headers** are set in `next.config.ts`: `X-Content-Type-Options`,
  `X-Frame-Options`, `Referrer-Policy` and `Permissions-Policy`.
- **Project file paths are pattern-validated**, blocking traversal and
  unexpected extensions.

---

## Editing the course

Content lives in `src/content/` as typed TypeScript and is compiled into
normalised database rows — many small rows, never one oversized JSON field.
Lessons, exercises, requirements, media, quizzes and module ordering can all be
changed without touching the learner interface.

To add a lesson:

1. Add a `LessonSpec` to the relevant `src/content/levels/level-NN.ts`, using
   the builders in `src/content/types.ts` (`objectives`, `prose`, `term`,
   `callout`, `code`, `annotated`, `compare`, `demo`, `checklist`, `recap`, …).
2. Give it at least one exercise with structural requirements.
3. Run `npm test` — the curriculum tests will tell you if the reference
   solution does not pass, if media is missing, or if a skill slug is unknown.
4. Run `npm run seed:generate` and reload the seed.

Because the interface is driven by `block_type`, adding a new kind of content
block means one case in `src/components/learn/lesson-blocks.tsx` and one
builder — no page changes.

---

## Known limitations

- **Course content must be seeded.** Without loading `supabase/seed.sql` the
  application runs but has no lessons. The dashboard says so explicitly.
- **The final assessment gates the certificate.** A learner who finishes every
  lesson but has not passed the final assessment sees a progress breakdown
  rather than a certificate. This is deliberate.
- **Screen-reader testing was not performed.** The application follows the
  practices the course teaches — landmarks, labels, live regions, focus
  management, visible focus, reduced-motion support — and the component tests
  assert accessible names and ARIA properties. That is not the same as testing
  with NVDA, JAWS or VoiceOver, which remains outstanding.
- **The media library is stylised, not photographic.** Assets are rendered
  procedurally, which is what makes the licence position unambiguous. They read
  as clean illustrations rather than photographs, and the `/media` page says so.
- **Project export bundles the learner's HTML only.** Media referenced from
  `/learning-media/` must be copied alongside it; the exported README explains
  this.
- **`npm audit` reports advisories in dev-only dependencies.** They are all
  transitive within packages already at their latest published version
  (`minimatch`/`brace-expansion` under ESLint, `postcss` and `sharp` under
  Next.js), with no fixed release available. They affect build tooling, not
  the deployed application. Re-check with `npm audit` after upgrading.
- **No offline mode.** The application needs a connection to Supabase to save
  progress. Media and previews work offline once the page has loaded.

---

## Licence

Application code: MIT.
Learning media: CC0-1.0 — see [Media licensing and attribution](#media-licensing-and-attribution).
