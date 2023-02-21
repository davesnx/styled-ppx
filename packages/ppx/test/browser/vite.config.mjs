import { defineConfig } from 'vite';
import rescript from '@jihchi/vite-plugin-rescript';

export default defineConfig({
  test: {
    include: ["**/src/**/*_test.bs.js"],
    globals: true,
    environment: "jsdom",
  },
  plugins: [
    rescript(),
  ],
})
