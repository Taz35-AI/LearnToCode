import type { NextConfig } from 'next';

/**
 * Security headers applied to every response.
 *
 * Note: the learner code preview is rendered inside a fully sandboxed iframe
 * (`sandbox=""`, i.e. no `allow-scripts`), so learner-authored markup can never
 * execute JavaScript in any origin. These headers are the second line of defence.
 */
const securityHeaders = [
  { key: 'X-Content-Type-Options', value: 'nosniff' },
  { key: 'X-Frame-Options', value: 'SAMEORIGIN' },
  { key: 'Referrer-Policy', value: 'strict-origin-when-cross-origin' },
  { key: 'X-DNS-Prefetch-Control', value: 'on' },
  {
    key: 'Permissions-Policy',
    value: 'camera=(), microphone=(), geolocation=(), interest-cohort=()',
  },
];

const nextConfig: NextConfig = {
  reactStrictMode: true,
  poweredByHeader: false,
  async headers() {
    return [{ source: '/:path*', headers: securityHeaders }];
  },
};

export default nextConfig;
