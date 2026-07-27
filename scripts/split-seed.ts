#!/usr/bin/env tsx
/**
 * Splits `supabase/seed.sql` into parts small enough to paste into the Supabase
 * SQL editor.
 *
 * Loading the seed with `psql` is the better route, but it needs a terminal,
 * the Supabase CLI or psql installed, and a database password. This gives an
 * alternative that needs none of them: open a part on GitHub, copy, paste into
 * the SQL editor, run, repeat. Nothing to install.
 *
 * The seed is one big transaction. Each part is wrapped in its own
 * `begin`/`commit`, so parts must be run in order — part 1 clears the
 * catalogue, and later parts insert rows that reference earlier ones. Re-running
 * from part 1 is always safe.
 *
 * Splitting happens on statement boundaries found by scanning, not by counting
 * lines: a semicolon inside a quoted string or a dollar-quoted block is not a
 * statement end, and the course text contains plenty of punctuation.
 *
 * Run: npm run seed:split
 */

import { readFile, writeFile, rm, mkdir } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import { join } from 'node:path';

const ROOT = fileURLToPath(new URL('..', import.meta.url));
const SOURCE = join(ROOT, 'supabase', 'seed.sql');
const OUT_DIR = join(ROOT, 'supabase', 'seed-parts');

/** Comfortably under what a browser textarea handles without lagging. */
const TARGET_BYTES = 180_000;

/** Splits SQL into statements, respecting quoting so text content is safe. */
function splitStatements(sql: string): string[] {
  const statements: string[] = [];
  let start = 0;
  let i = 0;

  while (i < sql.length) {
    const char = sql[i];

    // Line comment — runs to the end of the line.
    if (char === '-' && sql[i + 1] === '-') {
      const newline = sql.indexOf('\n', i);
      i = newline === -1 ? sql.length : newline + 1;
      continue;
    }

    // Single-quoted string. '' is an escaped quote, not a terminator.
    if (char === "'") {
      i += 1;
      while (i < sql.length) {
        if (sql[i] === "'") {
          if (sql[i + 1] === "'") {
            i += 2;
            continue;
          }
          i += 1;
          break;
        }
        i += 1;
      }
      continue;
    }

    // Dollar-quoted block, e.g. $$ ... $$ or $tag$ ... $tag$.
    if (char === '$') {
      const tag = /^\$[A-Za-z_]*\$/.exec(sql.slice(i));
      if (tag) {
        const close = sql.indexOf(tag[0], i + tag[0].length);
        i = close === -1 ? sql.length : close + tag[0].length;
        continue;
      }
    }

    if (char === ';') {
      statements.push(sql.slice(start, i + 1).trim());
      start = i + 1;
      i += 1;
      continue;
    }

    i += 1;
  }

  const tail = sql.slice(start).trim();
  if (tail.length > 0) statements.push(tail);

  return statements.filter((s) => s.length > 0);
}

const sql = await readFile(SOURCE, 'utf8');

// The whole seed is one transaction; each part gets its own instead.
const statements = splitStatements(sql).filter(
  (s) => s.toLowerCase() !== 'begin;' && s.toLowerCase() !== 'commit;',
);

const parts: string[][] = [];
let current: string[] = [];
let size = 0;

for (const statement of statements) {
  if (size > 0 && size + statement.length > TARGET_BYTES) {
    parts.push(current);
    current = [];
    size = 0;
  }
  current.push(statement);
  size += statement.length + 1;
}
if (current.length > 0) parts.push(current);

await rm(OUT_DIR, { recursive: true, force: true });
await mkdir(OUT_DIR, { recursive: true });

const total = parts.length;
const pad = (n: number) => String(n).padStart(2, '0');

for (const [index, statementsInPart] of parts.entries()) {
  const number = index + 1;
  const header = [
    `-- HTML Hero — course seed, part ${number} of ${total}`,
    '--',
    '-- GENERATED FILE. Do not edit by hand.',
    '-- Source: supabase/seed.sql  ·  Regenerate: npm run seed:split',
    '--',
    '-- Run the parts IN ORDER in the Supabase SQL editor. Part 1 clears the',
    '-- course catalogue; later parts insert rows that reference earlier ones.',
    '-- Learner accounts and progress are never touched.',
    '--',
    number === 1
      ? '-- This is the first part. Run it before any other.'
      : `-- Run part ${number - 1} first.`,
    '',
    'begin;',
    '',
  ].join('\n');

  const body = statementsInPart.join('\n');
  const footer = ['', '', 'commit;', ''].join('\n');

  await writeFile(join(OUT_DIR, `${pad(number)}.sql`), header + body + footer, 'utf8');
}

const sizes = parts.map((p) => p.reduce((sum, s) => sum + s.length + 1, 0));
const largest = Math.max(...sizes);

console.log(`✓ supabase/seed-parts/ — ${total} parts, largest ${Math.round(largest / 1024)} KB`);
console.log(`  ${statements.length} statements split from ${Math.round(sql.length / 1024)} KB`);
