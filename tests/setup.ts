import '@testing-library/jest-dom/vitest';

/**
 * Test setup.
 *
 * jsdom lacks a few browser APIs the components touch. Rather than mocking
 * behaviour, these are minimal stand-ins that let a component render so its
 * markup and accessibility properties can be asserted.
 */

if (!globalThis.matchMedia) {
  globalThis.matchMedia = ((query: string) => ({
    matches: false,
    media: query,
    onchange: null,
    addListener: () => {},
    removeListener: () => {},
    addEventListener: () => {},
    removeEventListener: () => {},
    dispatchEvent: () => false,
  })) as unknown as typeof globalThis.matchMedia;
}

if (!globalThis.requestAnimationFrame) {
  globalThis.requestAnimationFrame = ((callback: FrameRequestCallback) =>
    setTimeout(() => callback(0), 0) as unknown as number) as typeof globalThis.requestAnimationFrame;
}
