import { defineConfig } from 'vite';
import { externalizeDeps } from 'vite-plugin-externalize-deps'

export default defineConfig({
  test: {
    include: ["*_test.bs.js"],
    globals: true,
    environment: "jsdom",
  },
  root: "test",
  plugins: [externalizeDeps()],
})
