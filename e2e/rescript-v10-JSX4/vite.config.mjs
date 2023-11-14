import { defineConfig } from 'vite';
import { externalizeDeps } from 'vite-plugin-externalize-deps'
import createReScriptPlugin from '@jihchi/vite-plugin-rescript';

/** @type {import('vite').UserConfig} */
export default defineConfig({
  root: "src",
  optimizeDeps: {
    include: ['@emotion/css'],
  },
  plugins: [],
})
