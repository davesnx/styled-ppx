import Os from "node:os";
import Path from "node:path";
import URL from "node:url";
import Fs from "node:fs";
import Nextra from "nextra";
import { createHighlighter } from "shiki";
import { bundledLanguages } from "shiki/langs";

const __dirname = Path.dirname(URL.fileURLToPath(import.meta.url));
const syntaxes = Path.join(__dirname, "syntaxes");
const editors = Path.join(__dirname, "..", "editors");

const reasonGrammar = {
  ...JSON.parse(
    Fs.readFileSync(Path.join(syntaxes, "reason.tmLanguage.json"), "utf8")
  ),
  sourceName: "reason",
  name: "reason",
};

const ocamlGrammar = {
  ...JSON.parse(
    Fs.readFileSync(Path.join(syntaxes, "ocaml.tmLanguage.json"), "utf8")
  ),
  sourceName: "ocaml",
  name: "ocaml",
};

// OCaml syntax dialect with JSX support (https://github.com/ocaml-mlx/mlx)
const mlxGrammar = {
  ...JSON.parse(
    Fs.readFileSync(Path.join(syntaxes, "mlx.tmLanguage.json"), "utf8")
  ),
  sourceName: "mlx",
  name: "mlx",
};

const styledPpxCssGrammar = {
  ...JSON.parse(
    Fs.readFileSync(
      Path.join(editors, "vscode/syntaxes/css-styled-ppx.json"),
      "utf8"
    )
  ),
  injectTo: ["source.ocaml", "source.ocaml.mlx", "source.reason"],
};

const styledPpxOCamlGrammar = {
  ...JSON.parse(
    Fs.readFileSync(
      Path.join(editors, "vscode/syntaxes/styled-ppx-ocaml.json"),
      "utf8"
    )
  ),
  injectTo: ["source.ocaml", "source.ocaml.mlx"],
};

const styledPpxReasonGrammar = {
  ...JSON.parse(
    Fs.readFileSync(
      Path.join(editors, "vscode/syntaxes/styled-ppx-reason.json"),
      "utf8"
    )
  ),
  injectTo: ["source.reason"],
};

const duneGrammar = {
  ...JSON.parse(
    Fs.readFileSync(Path.join(syntaxes, "dune.tmLanguage.json"), "utf8")
  ),
  name: "dune",
};

const customLangs = [
  ...Object.keys(bundledLanguages),
  reasonGrammar,
  ocamlGrammar,
  mlxGrammar,
  styledPpxCssGrammar,
  styledPpxOCamlGrammar,
  styledPpxReasonGrammar,
  duneGrammar,
];

const withNextra = Nextra({
  mdxOptions: {
    rehypePrettyCodeOptions: {
      theme: { light: "github-light", dark: "github-dark-dimmed" },
      getHighlighter: (options) =>
        createHighlighter({
          ...options,
          langs: customLangs,
        }),
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
