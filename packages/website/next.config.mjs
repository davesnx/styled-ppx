import Os from "node:os";
import Path from "node:path";
import URL from "node:url";
import Nextra from "nextra";

const __dirname = Path.dirname(URL.fileURLToPath(import.meta.url));

const withNextra = Nextra({
  mdxOptions: {
    // Only JSON-serializable options can live here: Turbopack passes them to
    // the loader as data. The custom highlighter (Reason/OCaml/mlx/dune
    // grammars) is injected at runtime by ./nextra-loader.cjs instead.
    rehypePrettyCodeOptions: {
      theme: { light: "github-light", dark: "github-dark-dimmed" },
    },
  },
});

/** @type {import('next').NextConfig} */
const nextConfig = {
  // This package is a standalone app with its own lockfile; without this,
  // Next infers the repository root (which also has a package-lock.json).
  outputFileTracingRoot: __dirname,
  turbopack: {
    root: __dirname,
  },
  typescript: {
    ignoreBuildErrors: true,
  },
  experimental: {
    // Cap static-generation workers: Next spawns one per CPU, which
    // explodes on many-core machines (25 pages don't need 512 workers).
    cpus: Math.min(8, Os.cpus().length),
  },
};

const config = withNextra(nextConfig);

// Remap nextra's loader to our wrapper, which injects the non-serializable
// highlighter options (see ./nextra-loader.cjs).
const customLoader = Path.join(__dirname, "nextra-loader.cjs");
for (const rule of Object.values(config.turbopack.rules)) {
  for (const entry of rule.loaders ?? []) {
    if (entry.loader.endsWith(`nextra${Path.sep}loader.cjs`)) {
      entry.loader = customLoader;
    }
  }
}

export default config;
