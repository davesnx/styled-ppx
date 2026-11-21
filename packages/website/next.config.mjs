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
    cpus: Math.min(8, Os.cpus().length),
  },
};

export default withNextra(nextConfig);
