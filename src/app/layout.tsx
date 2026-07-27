import type { Metadata, Viewport } from 'next';
import './globals.css';

export const metadata: Metadata = {
  title: {
    default: 'HTML Hero — learn HTML properly, from complete beginner to professional',
    template: '%s — HTML Hero',
  },
  description:
    'A mastery-based interactive course that takes you from never having written a tag to building, validating and publishing a professional multi-page website.',
  applicationName: 'HTML Hero',
  authors: [{ name: 'HTML Hero' }],
  icons: {
    icon: [{ url: '/learning-media/favicon.svg', type: 'image/svg+xml' }],
    apple: '/learning-media/favicon.png',
  },
  openGraph: {
    title: 'HTML Hero',
    description:
      'Learn HTML properly: twelve mastery levels, real coding exercises, and one professional website you build as you go.',
    type: 'website',
  },
  robots: { index: true, follow: true },
};

export const viewport: Viewport = {
  width: 'device-width',
  initialScale: 1,
  themeColor: [
    { media: '(prefers-color-scheme: light)', color: '#ffffff' },
    { media: '(prefers-color-scheme: dark)', color: '#0e131b' },
  ],
};

/**
 * Applies the learner's saved theme before first paint.
 *
 * This is the one place the application uses an inline script: without it the
 * page renders in the system theme and then visibly flips, which is worse than
 * the tiny script it takes to avoid. It reads only from localStorage and sets
 * two attributes.
 */
const THEME_SCRIPT = `
(function () {
  try {
    var theme = localStorage.getItem('html-hero-theme');
    if (theme === 'light' || theme === 'dark') {
      document.documentElement.setAttribute('data-theme', theme);
    }
    if (localStorage.getItem('html-hero-reduced-motion') === 'true') {
      document.documentElement.setAttribute('data-reduced-motion', 'true');
    }
  } catch (e) {}
})();
`.trim();

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" suppressHydrationWarning>
      <head>
        <script dangerouslySetInnerHTML={{ __html: THEME_SCRIPT }} />
      </head>
      <body className="bg-app text-ink antialiased min-h-screen">{children}</body>
    </html>
  );
}
