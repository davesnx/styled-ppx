import { defineConfig } from 'vite';

export default defineConfig({
  test: {
    include: ["*_test.bs.js"],
    globals: true,
    environment: "jsdom",
  },
  root: "src"
})
