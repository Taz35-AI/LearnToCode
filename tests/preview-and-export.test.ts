import { describe, expect, it } from 'vitest';
import { buildPreviewDocument, PREVIEW_CSP, sanitiseForPreview } from '@/lib/preview/sanitise';
import { buildZip, crc32, exportReadme } from '@/lib/project/export';
import { buildCapstoneChecklist, isSubstantialPage } from '@/lib/project/checklist';
import { certificateSerial, formatMinutes, percent, plural, relativeTime } from '@/lib/utils';

/**
 * Preview isolation and project export.
 *
 * The preview is the one place learner-authored content is rendered, so its
 * tests are about what must NOT survive: scripts, event handlers, javascript:
 * URLs and remote requests.
 */

describe('preview sanitising', () => {
  it('removes script elements and says so', () => {
    const { html, notices } = sanitiseForPreview('<p>Hi</p><script>alert(1)</script>');
    expect(html).not.toContain('<script');
    expect(html).toContain('<p>Hi</p>');
    expect(notices.join(' ')).toContain('does not run JavaScript');
  });

  it('removes a script with attributes and a src', () => {
    const { html } = sanitiseForPreview('<script src="https://evil.example/x.js" defer></script>');
    expect(html).not.toContain('script');
  });

  it('removes inline event handlers however they are quoted', () => {
    const { html } = sanitiseForPreview(
      `<div onclick="go()">a</div><img src="x.jpg" onerror='steal()' alt="x"><a onmouseover=go()>b</a>`,
    );
    expect(html).not.toMatch(/onclick/i);
    expect(html).not.toMatch(/onerror/i);
    expect(html).not.toMatch(/onmouseover/i);
  });

  it('neutralises javascript: and data:text/html URLs', () => {
    const { html } = sanitiseForPreview(
      `<a href="javascript:alert(1)">x</a><iframe src="data:text/html,<script>alert(1)</script>"></iframe>`,
    );
    expect(html).not.toMatch(/javascript:/i);
    expect(html).not.toMatch(/data:text\/html/i);
    expect(html).toContain('data-blocked-url');
  });

  it('blocks remote assets so lessons work offline and nothing is hotlinked', () => {
    const { html, notices } = sanitiseForPreview(
      '<img src="https://example.com/a.jpg" alt="x"><img src="//cdn.example/b.jpg" alt="y">',
    );

    // The URL must no longer sit in a fetching attribute — that is what stops
    // the request. It is retained as an inert `data-` attribute so the learner
    // can see exactly what was blocked rather than watching it vanish.
    expect(html).not.toMatch(/\ssrc\s*=\s*["']https?:/i);
    expect(html).not.toMatch(/\ssrc\s*=\s*["']\/\//);
    expect(html).toContain('data-remote-src="https://example.com/a.jpg"');
    expect(notices.join(' ')).toContain('Use the media library');
  });

  it('leaves local media, structure and inline styling untouched', () => {
    const original = `<main><h1>Hi</h1><img src="/learning-media/images/coast-sunrise.jpg" alt="Sunrise"><p style="color:red">Red</p></main>`;
    const { html, notices } = sanitiseForPreview(original);
    expect(html).toBe(original);
    expect(notices).toHaveLength(0);
  });

  it('removes object, embed and base elements', () => {
    const { html } = sanitiseForPreview(
      '<object data="x.swf"></object><embed src="y.swf"><base href="https://evil.example/">',
    );
    expect(html).not.toMatch(/<object/i);
    expect(html).not.toMatch(/<embed/i);
    expect(html).not.toMatch(/<base/i);
  });
});

describe('preview document', () => {
  it('injects a restrictive CSP that forbids scripts entirely', () => {
    const { html } = buildPreviewDocument('<p>Hi</p>');
    expect(html).toContain(PREVIEW_CSP);
    expect(PREVIEW_CSP).toContain("script-src 'none'");
    expect(PREVIEW_CSP).toContain("default-src 'none'");
    expect(PREVIEW_CSP).toContain("form-action 'none'");
  });

  it('wraps a fragment in a complete document', () => {
    const { html } = buildPreviewDocument('<h1>Hi</h1>');
    expect(html).toContain('<!DOCTYPE html>');
    expect(html).toContain('<html lang="en"');
    expect(html).toContain('<h1>Hi</h1>');
  });

  it("preserves a learner's own full document and injects into its head", () => {
    const learner = `<!DOCTYPE html>\n<html lang="fr">\n  <head><title>Bonjour</title></head>\n  <body><h1>Salut</h1></body>\n</html>`;
    const { html } = buildPreviewDocument(learner);
    expect(html).toContain('lang="fr"');
    expect(html).toContain('<title>Bonjour</title>');
    expect(html).toContain(PREVIEW_CSP);
    // The learner's structure is untouched — only presentation was added.
    expect(html).toContain('<h1>Salut</h1>');
  });

  it('creates a head when the learner omitted one', () => {
    const { html } = buildPreviewDocument('<html><body><h1>Hi</h1></body></html>');
    expect(html).toContain('<head>');
    expect(html).toContain(PREVIEW_CSP);
  });

  it('supplies the platform stylesheet, clearly marked as the platform’s', () => {
    const { html } = buildPreviewDocument('<h1>Hi</h1>', { withStarterStyles: true });
    expect(html).toContain('data-html-hero="preview-styles"');

    const bare = buildPreviewDocument('<h1>Hi</h1>', { withStarterStyles: false });
    expect(bare.html).not.toContain('data-html-hero');
  });

  it('honours the dark theme', () => {
    const { html } = buildPreviewDocument('<h1>Hi</h1>', { theme: 'dark' });
    expect(html).toContain('color-scheme: dark');
  });

  it('carries no executable content through, whatever is thrown at it', () => {
    const nasty = `
      <script>fetch('/steal')</script>
      <img src=x onerror="fetch('/steal')" alt="">
      <a href="javascript:void(0)">x</a>
      <iframe src="data:text/html,<script>x</script>"></iframe>
      <svg onload="alert(1)"></svg>
      <body onload="alert(1)">`;
    const { html } = buildPreviewDocument(nasty);

    expect(html).not.toMatch(/<script[\s>]/i);
    expect(html).not.toMatch(/\son\w+\s*=/i);
    expect(html).not.toMatch(/javascript:/i);
    expect(html).not.toMatch(/data:text\/html/i);
  });
});

describe('project export', () => {
  const files = [
    { path: 'index.html', content: '<!DOCTYPE html><html lang="en"><body><h1>Home</h1></body></html>' },
    { path: 'about.html', content: '<!DOCTYPE html><html lang="en"><body><h1>About</h1></body></html>' },
  ];

  it('produces a valid ZIP signature and central directory', () => {
    const zip = buildZip(files);
    // Local file header
    expect([zip[0], zip[1], zip[2], zip[3]]).toEqual([0x50, 0x4b, 0x03, 0x04]);
    // End of central directory, last 22 bytes
    const eocd = zip.length - 22;
    expect([zip[eocd], zip[eocd + 1], zip[eocd + 2], zip[eocd + 3]]).toEqual([0x50, 0x4b, 0x05, 0x06]);
  });

  it('records the correct number of entries', () => {
    const zip = buildZip(files);
    const view = new DataView(zip.buffer, zip.byteOffset, zip.byteLength);
    const eocd = zip.length - 22;
    expect(view.getUint16(eocd + 8, true)).toBe(files.length);
    expect(view.getUint16(eocd + 10, true)).toBe(files.length);
  });

  it('stores every filename and its content verbatim', () => {
    const zip = buildZip(files);
    const text = new TextDecoder().decode(zip);
    for (const file of files) {
      expect(text).toContain(file.path);
      expect(text).toContain('<h1>Home</h1>');
    }
  });

  it('handles an empty project without producing a corrupt archive', () => {
    const zip = buildZip([]);
    expect(zip.length).toBe(22);
    expect([zip[0], zip[1], zip[2], zip[3]]).toEqual([0x50, 0x4b, 0x05, 0x06]);
  });

  it('computes CRC-32 correctly against a known value', () => {
    // The canonical CRC-32 of "123456789".
    expect(crc32(new TextEncoder().encode('123456789'))).toBe(0xcbf43926);
    expect(crc32(new Uint8Array())).toBe(0);
  });

  it('writes a README that explains publishing and licensing', () => {
    const readme = exportReadme("Alex's portfolio", files);
    expect(readme).toContain("Alex's portfolio");
    expect(readme).toContain('index.html');
    expect(readme).toContain('validator.w3.org');
    expect(readme).toContain('CC0-1.0');
    expect(readme).toContain('GitHub Pages');
  });
});

describe('capstone checklist', () => {
  const completePage = (title: string, extra = '') => `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>${title} — My site</title>
    <meta name="description" content="A page about ${title}.">
    <link rel="icon" href="/learning-media/favicon.svg">
    <meta property="og:title" content="${title}">
    <meta property="og:description" content="About ${title}">
    <meta property="og:image" content="https://example.test/a.jpg">
    <script type="application/ld+json">{"@context":"https://schema.org","@type":"LocalBusiness"}</script>
  </head>
  <body>
    <a href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About</a></li>
          <li><a href="services.html">Services</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>${title}</h1>
      <h2>A section</h2>
      ${extra}
    </main>
    <footer><p>&copy; 2026</p></footer>
  </body>
</html>`;

  const pages = [
    {
      path: 'index.html',
      content: completePage(
        'Home',
        `<img src="/learning-media/images/coast-sunrise-1200.jpg"
              srcset="/learning-media/images/coast-sunrise-480.jpg 480w"
              sizes="100vw" alt="Sunrise over a calm sea" width="1200" height="800">
         <figure>
           <img src="/learning-media/images/forest-path-1200.jpg" alt="A path between tall trees" width="1200" height="800">
           <figcaption>The wooded section.</figcaption>
         </figure>
         <video controls><track kind="captions" src="/learning-media/captions/page-anatomy.en.vtt" srclang="en"></video>
         <ul><li>One</li><li>Two</li></ul>
         <table><caption>Rates</caption><tr><th scope="col">Bike</th><th scope="row">Hybrid</th></tr></table>
         <details><summary>A question</summary><p>An answer.</p></details>
         <form><label for="n">Name</label><input id="n" name="n"></form>`,
      ),
    },
    { path: 'about.html', content: completePage('About') },
    { path: 'services.html', content: completePage('Services') },
    { path: 'contact.html', content: completePage('Contact') },
    { path: 'extra.html', content: completePage('Extra') },
  ];

  it('passes a complete, correct project', () => {
    const results = buildCapstoneChecklist(pages);
    const failing = results.filter((r) => !r.met).map((r) => `${r.label}: ${r.detail}`);
    expect(failing).toEqual([]);
  });

  it('reports too few pages', () => {
    const results = buildCapstoneChecklist(pages.slice(0, 2));
    const item = results.find((r) => r.label === 'At least five pages');
    expect(item?.met).toBe(false);
    expect(item?.detail).toContain('You have 2');
  });

  it('catches duplicate titles across pages', () => {
    const duplicated = pages.map((p) => ({ ...p, content: completePage('Home') }));
    const results = buildCapstoneChecklist(duplicated);
    expect(results.find((r) => r.label === 'No two pages share a title')?.met).toBe(false);
  });

  it('catches a broken internal link and names the page', () => {
    const broken = [
      { ...pages[0]!, content: pages[0]!.content.replace('about.html', 'abuot.html') },
      ...pages.slice(1),
    ];
    const results = buildCapstoneChecklist(broken);
    const item = results.find((r) => r.label === 'No broken internal links');
    expect(item?.met).toBe(false);
    expect(item?.detail).toContain('abuot.html');
  });

  it('catches missing media', () => {
    const broken = [
      { ...pages[0]!, content: pages[0]!.content.replace('coast-sunrise-1200.jpg', 'nope.jpg') },
      ...pages.slice(1),
    ];
    const results = buildCapstoneChecklist(broken);
    expect(results.find((r) => r.label === 'No missing media')?.met).toBe(false);
  });

  it('catches poor alt text', () => {
    const broken = [
      { ...pages[0]!, content: pages[0]!.content.replace('alt="Sunrise over a calm sea"', 'alt="image"') },
      ...pages.slice(1),
    ];
    const results = buildCapstoneChecklist(broken);
    expect(results.find((r) => r.label === 'Meaningful alt text on every image')?.met).toBe(false);
  });

  it('catches a skipped heading level', () => {
    const broken = [
      { ...pages[0]!, content: pages[0]!.content.replace('<h2>A section</h2>', '<h4>A section</h4>') },
      ...pages.slice(1),
    ];
    const results = buildCapstoneChecklist(broken);
    expect(results.find((r) => r.label === 'Correct heading hierarchy everywhere')?.met).toBe(false);
  });

  it('catches a missing skip link', () => {
    const broken = pages.map((p) => ({
      ...p,
      content: p.content.replace('<a href="#main">Skip to main content</a>', ''),
    }));
    const results = buildCapstoneChecklist(broken);
    expect(results.find((r) => r.label === 'A skip link on every page')?.met).toBe(false);
  });
});

describe('formatting helpers', () => {
  it('formats durations readably', () => {
    expect(formatMinutes(45)).toBe('45 min');
    expect(formatMinutes(60)).toBe('1 h');
    expect(formatMinutes(80)).toBe('1 h 20 min');
    expect(formatMinutes(0)).toBe('0 min');
  });

  it('pluralises correctly', () => {
    expect(plural(1, 'lesson')).toBe('1 lesson');
    expect(plural(3, 'lesson')).toBe('3 lessons');
  });

  it('computes percentages safely', () => {
    expect(percent(1, 4)).toBe(25);
    expect(percent(5, 0)).toBe(0);
    expect(percent(9, 4)).toBe(100);
  });

  it('describes relative times', () => {
    const now = new Date('2026-03-10T12:00:00Z');
    expect(relativeTime('2026-03-10T11:59:30Z', now)).toBe('just now');
    expect(relativeTime('2026-03-10T11:00:00Z', now)).toBe('1 hour ago');
    expect(relativeTime('2026-03-08T12:00:00Z', now)).toBe('2 days ago');
    expect(relativeTime(null, now)).toBe('never');
    expect(relativeTime('not a date', now)).toBe('never');
  });

  it('builds a stable, readable certificate serial', () => {
    const issued = new Date('2026-06-01T00:00:00Z');
    const serial = certificateSerial('11111111-2222-3333-4444-555555555555', issued);
    expect(serial).toBe('HH-2026-11111111');
    expect(certificateSerial('11111111-2222-3333-4444-555555555555', issued)).toBe(serial);
  });
});

describe('page substance', () => {
  const starter = `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>About — Riverside Cycle Hire</title>
    <meta name="description" content="Who we are and why we started.">
  </head>
  <body>
    <a class="skip-link" href="#main">Skip to main content</a>
    <header>
      <nav aria-label="Main">
        <ul>
          <li><a href="index.html">Home</a></li>
        </ul>
      </nav>
    </header>
    <main id="main">
      <h1>About</h1>
      <p>Who we are and why we started.</p>
      <!-- Each module mission adds a real piece to this page. -->
    </main>
    <footer>
      <p>&copy; 2026 Riverside Cycle Hire</p>
    </footer>
  </body>
</html>`;

  it('does not count the seeded starter page, long though it is', () => {
    // The starter is well over 400 characters, which is exactly why length
    // alone cannot be the measure.
    expect(starter.length).toBeGreaterThan(400);
    expect(isSubstantialPage(starter)).toBe(false);
  });

  it('counts a page once the learner has written real content into it', () => {
    const written = starter.replace(
      '<!-- Each module mission adds a real piece to this page. -->',
      `<section>
         <h2>How we started</h2>
         <p>We opened in 2019 with eight bikes and a shed by the towpath. Today we
            keep sixty machines on the road, from tow-along trailers to touring
            bikes, and we still service every one of them ourselves.</p>
         <ul>
           <li>Open seven days a week</li>
           <li>Helmets and route maps included</li>
         </ul>
       </section>`,
    );
    expect(isSubstantialPage(written)).toBe(true);
  });

  it('does not count structure without content, or content without structure', () => {
    expect(isSubstantialPage('<main><section></section></main>')).toBe(false);
    expect(
      isSubstantialPage(`<main><p>${'Words that go on and on. '.repeat(20)}</p></main>`),
    ).toBe(false);
  });
});
