import { defineConfig, mergeConfig } from 'vitest/config'
import viteConfig from './vite.config.mjs'

/** @type {import('vite').UserConfig} */
export default mergeConfig(viteConfig, defineConfig({
  test: {
    include: ["*_test.bs.js"],
    globals: true,
    environment: "jsdom",
  },
}))
