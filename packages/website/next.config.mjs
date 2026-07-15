import Os from "node:os";
import Nextra from "nextra";
import { rehypePrettyCodeOptions } from "./highlighter.mjs";

const withNextra = Nextra({
  mdxOptions: {
    rehypePrettyCodeOptions,
  },
});

/** @type {import('next').NextConfig} */
const nextConfig = {
  typescript: {
    ignoreBuildErrors: true,
  },
  experimental: {
    // Cap static-generation workers: Next spawns one per CPU, which
    // explodes on many-core machines (25 pages don't need 512 workers).
    cpus: Math.min(8, Os.cpus().length),
  },
};

export default withNextra(nextConfig);
