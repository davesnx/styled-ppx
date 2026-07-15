import Fs from "node:fs";
import Os from "node:os";
import Path from "node:path";
import URL from "node:url";
import Nextra from "nextra";
import { bundledLanguages, createHighlighter } from "shiki";

const __dirname = Path.dirname(URL.fileURLToPath(import.meta.url));

const loadGrammar = (relativePath, metadata) => ({
  ...JSON.parse(Fs.readFileSync(Path.join(__dirname, relativePath), "utf8")),
  ...metadata,
});

const customLanguages = [
  ...Object.keys(bundledLanguages),
  loadGrammar("syntaxes/reason.tmLanguage.json", {
    sourceName: "reason",
    name: "reason",
  }),
  loadGrammar("syntaxes/ocaml.tmLanguage.json", {
    sourceName: "ocaml",
    name: "ocaml",
  }),
  loadGrammar("syntaxes/mlx.tmLanguage.json", {
    sourceName: "mlx",
    name: "mlx",
  }),
  loadGrammar("../editors/vscode/syntaxes/css-styled-ppx.json", {
    injectTo: ["source.ocaml", "source.ocaml.mlx", "source.reason"],
  }),
  loadGrammar("../editors/vscode/syntaxes/styled-ppx-ocaml.json", {
    injectTo: ["source.ocaml", "source.ocaml.mlx"],
  }),
  loadGrammar("../editors/vscode/syntaxes/styled-ppx-reason.json", {
    injectTo: ["source.reason"],
  }),
  loadGrammar("syntaxes/dune.tmLanguage.json", { name: "dune" }),
];

const withNextra = Nextra({
  mdxOptions: {
    rehypePrettyCodeOptions: {
      theme: { light: "github-light", dark: "github-dark-dimmed" },
      getHighlighter: (options) =>
        createHighlighter({ ...options, langs: customLanguages }),
    },
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
