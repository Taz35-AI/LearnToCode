/**
 * Project export.
 *
 * The learner's site is a set of plain files, so exporting is a matter of
 * writing them out — no build step, no bundler, nothing to compile. That is
 * exactly the point Level 12 makes about static HTML, so the export mirrors it:
 * what you download is what you wrote.
 *
 * The archive is a stored (uncompressed) ZIP written by hand. A ZIP writer is
 * about eighty lines when nothing is compressed, which is a better trade than
 * adding a dependency for one feature.
 */

export interface ExportFile {
  path: string;
  content: string;
}

/** CRC-32, as required by the ZIP format. */
const CRC_TABLE = (() => {
  const table = new Uint32Array(256);
  for (let i = 0; i < 256; i += 1) {
    let c = i;
    for (let k = 0; k < 8; k += 1) {
      c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
    }
    table[i] = c >>> 0;
  }
  return table;
})();

export function crc32(bytes: Uint8Array): number {
  let crc = 0xffffffff;
  for (let i = 0; i < bytes.length; i += 1) {
    crc = (crc >>> 8) ^ (CRC_TABLE[(crc ^ (bytes[i] ?? 0)) & 0xff] ?? 0);
  }
  return (crc ^ 0xffffffff) >>> 0;
}

function writeUint32(view: DataView, offset: number, value: number): void {
  view.setUint32(offset, value >>> 0, true);
}

function writeUint16(view: DataView, offset: number, value: number): void {
  view.setUint16(offset, value & 0xffff, true);
}

/**
 * Builds a ZIP archive with all entries stored uncompressed.
 *
 * Returns the raw bytes; the caller decides what to do with them, which keeps
 * this function testable in Node without any DOM.
 */
export function buildZip(files: ExportFile[]): Uint8Array {
  const encoder = new TextEncoder();

  const entries = files.map((file) => {
    const nameBytes = encoder.encode(file.path);
    const dataBytes = encoder.encode(file.content);
    return { nameBytes, dataBytes, crc: crc32(dataBytes), offset: 0 };
  });

  const localSize = entries.reduce(
    (sum, entry) => sum + 30 + entry.nameBytes.length + entry.dataBytes.length,
    0,
  );
  const centralSize = entries.reduce((sum, entry) => sum + 46 + entry.nameBytes.length, 0);
  const total = localSize + centralSize + 22;

  const buffer = new ArrayBuffer(total);
  const bytes = new Uint8Array(buffer);
  const view = new DataView(buffer);
  let offset = 0;

  // --- Local file headers + data ---
  for (const entry of entries) {
    entry.offset = offset;

    writeUint32(view, offset, 0x04034b50); // local file header signature
    writeUint16(view, offset + 4, 20); // version needed
    writeUint16(view, offset + 6, 0); // flags
    writeUint16(view, offset + 8, 0); // method: 0 = stored
    writeUint16(view, offset + 10, 0); // mod time
    writeUint16(view, offset + 12, 0); // mod date
    writeUint32(view, offset + 14, entry.crc);
    writeUint32(view, offset + 18, entry.dataBytes.length); // compressed size
    writeUint32(view, offset + 22, entry.dataBytes.length); // uncompressed size
    writeUint16(view, offset + 26, entry.nameBytes.length);
    writeUint16(view, offset + 28, 0); // extra field length
    offset += 30;

    bytes.set(entry.nameBytes, offset);
    offset += entry.nameBytes.length;
    bytes.set(entry.dataBytes, offset);
    offset += entry.dataBytes.length;
  }

  // --- Central directory ---
  const centralStart = offset;
  for (const entry of entries) {
    writeUint32(view, offset, 0x02014b50); // central directory signature
    writeUint16(view, offset + 4, 20); // version made by
    writeUint16(view, offset + 6, 20); // version needed
    writeUint16(view, offset + 8, 0); // flags
    writeUint16(view, offset + 10, 0); // method
    writeUint16(view, offset + 12, 0); // mod time
    writeUint16(view, offset + 14, 0); // mod date
    writeUint32(view, offset + 16, entry.crc);
    writeUint32(view, offset + 20, entry.dataBytes.length);
    writeUint32(view, offset + 24, entry.dataBytes.length);
    writeUint16(view, offset + 28, entry.nameBytes.length);
    writeUint16(view, offset + 30, 0); // extra length
    writeUint16(view, offset + 32, 0); // comment length
    writeUint16(view, offset + 34, 0); // disk number
    writeUint16(view, offset + 36, 0); // internal attributes
    writeUint32(view, offset + 38, 0); // external attributes
    writeUint32(view, offset + 42, entry.offset);
    offset += 46;

    bytes.set(entry.nameBytes, offset);
    offset += entry.nameBytes.length;
  }

  // --- End of central directory ---
  writeUint32(view, offset, 0x06054b50);
  writeUint16(view, offset + 4, 0); // disk number
  writeUint16(view, offset + 6, 0); // disk with central directory
  writeUint16(view, offset + 8, entries.length);
  writeUint16(view, offset + 10, entries.length);
  writeUint32(view, offset + 12, offset - centralStart);
  writeUint32(view, offset + 16, centralStart);
  writeUint16(view, offset + 20, 0); // comment length

  return bytes;
}

/** A README explaining what the learner has just downloaded and how to use it. */
export function exportReadme(projectName: string, files: ExportFile[]): string {
  return `# ${projectName}

Built with HTML Hero.

## What is in here

${files.map((file) => `- \`${file.path}\``).join('\n')}

## Opening it

Double-click \`index.html\`. That is genuinely all — HTML runs as it is, with
nothing to install, compile or build.

## Publishing it

A static site can be hosted almost anywhere, usually free:

- Drag this folder onto a static host such as Netlify or Cloudflare Pages.
- Push it to a GitHub repository and switch on GitHub Pages.
- Upload it by FTP to any traditional web host.

Whichever you choose, the files you upload are exactly these files.

## Before you publish

1. Run every page through https://validator.w3.org — aim for zero errors.
2. Tab through each page: everything reachable, focus always visible.
3. Open the browser Network panel and reload: no 404s.
4. Check each page has its own \`<title>\` and \`<meta name="description">\`.
5. Open it on a real phone.

## Media

Any file under \`learning-media/\` referenced by these pages comes from the
HTML Hero media library and is released under CC0-1.0 (public domain). You may
use it anywhere, with or without attribution. Copy those files alongside your
pages when you publish, or replace them with your own.
`;
}

/** Triggers a browser download of the project as a ZIP. */
export function exportProject(projectName: string, files: ExportFile[]): void {
  const slug =
    projectName
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-|-$/g, '') || 'my-site';

  const all: ExportFile[] = [
    ...files,
    { path: 'README.md', content: exportReadme(projectName, files) },
  ];

  const bytes = buildZip(all);
  const blob = new Blob([bytes.slice().buffer as ArrayBuffer], { type: 'application/zip' });
  const url = URL.createObjectURL(blob);

  const link = document.createElement('a');
  link.href = url;
  link.download = `${slug}.zip`;
  document.body.append(link);
  link.click();
  link.remove();
  URL.revokeObjectURL(url);
}
