#!/usr/bin/env tsx
/**
 * Fails the build if any path claimed by the media manifest is missing from
 * `public/`, or is zero bytes.
 *
 * This runs as the first step of `npm run build`, so a broken image, video,
 * poster or captions file can never reach production.
 */

import { existsSync } from 'node:fs';
import { readdir, stat } from 'node:fs/promises';
import { join, relative } from 'node:path';
import { fileURLToPath } from 'node:url';
import { allMediaPaths, MEDIA_ASSETS } from '../src/content/media/manifest';

const ROOT = fileURLToPath(new URL('..', import.meta.url));
const PUBLIC = join(ROOT, 'public');
const MEDIA_DIR = join(PUBLIC, 'learning-media');

async function walk(dir: string): Promise<string[]> {
  const out: string[] = [];
  for (const entry of await readdir(dir, { withFileTypes: true })) {
    const full = join(dir, entry.name);
    if (entry.isDirectory()) out.push(...(await walk(full)));
    else out.push(full);
  }
  return out;
}

async function main(): Promise<void> {
  if (!existsSync(MEDIA_DIR)) {
    console.error(
      '\n✗ public/learning-media is missing.\n' +
        '  Run: npm run media:generate  (needs python3 with pillow + imageio-ffmpeg)\n',
    );
    process.exit(1);
  }

  const declared = allMediaPaths();
  const missing: string[] = [];
  const empty: string[] = [];

  for (const path of declared) {
    const file = join(PUBLIC, path.replace(/^\//, ''));
    if (!existsSync(file)) {
      missing.push(path);
      continue;
    }
    if ((await stat(file)).size === 0) empty.push(path);
  }

  // Every asset that claims captions or a poster must actually have them.
  for (const asset of MEDIA_ASSETS) {
    if (asset.kind === 'video') {
      if (!asset.posterPath) missing.push(`${asset.slug}: declares no poster`);
      if (!asset.captionsPath) missing.push(`${asset.slug}: declares no captions`);
    }
  }

  if (missing.length > 0) {
    console.error(`\n✗ ${missing.length} media file(s) referenced by the manifest are missing:`);
    for (const p of missing.slice(0, 25)) console.error(`    ${p}`);
    console.error('\n  Run: npm run media:generate\n');
    process.exit(1);
  }

  if (empty.length > 0) {
    console.error(`\n✗ ${empty.length} media file(s) are zero bytes:`);
    for (const p of empty.slice(0, 25)) console.error(`    ${p}`);
    process.exit(1);
  }

  const onDisk = (await walk(MEDIA_DIR)).map(
    (f) => `/${relative(PUBLIC, f).split('\\').join('/')}`,
  );
  const declaredSet = new Set(declared);
  const orphans = onDisk.filter((p) => !declaredSet.has(p) && !p.endsWith('generated.json'));

  console.log(
    `✓ media check passed — ${declared.length} declared assets present (${MEDIA_ASSETS.length} library entries).`,
  );
  if (orphans.length > 0) {
    console.log(`  note: ${orphans.length} generated file(s) are not referenced by the manifest.`);
  }
}

main().catch((error: unknown) => {
  console.error(error);
  process.exit(1);
});
