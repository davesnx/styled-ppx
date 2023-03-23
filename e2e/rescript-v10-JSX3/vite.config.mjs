import { defineConfig } from 'vite';

export default defineConfig({
  test: {
    include: ["**/src/**/*_test.bs.js"],
    globals: true,
    environment: "jsdom",
  }
})
