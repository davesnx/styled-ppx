import Path from "node:path";
import URL from "node:url";
import Fs from "node:fs";
import nextra from "nextra";
import * as Shiki from "shiki";
import { bundledLanguages } from "shiki/langs";

const __dirname = Path.dirname(URL.fileURLToPath(import.meta.url));

const syntaxes = Path.join(__dirname, "syntaxes");
const editors = Path.join(__dirname, "..", "..", "editors");

const rescriptGrammar = {
  ...JSON.parse(
    Fs.readFileSync(Path.join(syntaxes, "rescript.tmLanguage.json"), "utf8")
  ),
  name: "rescript",
};

const reasonGrammar = {
  ...JSON.parse(
    Fs.readFileSync(Path.join(syntaxes, "reason.tmLanguage.json"), "utf8")
  ),
  name: "reason",
};

const styledPpxCssGrammar = JSON.parse(
  Fs.readFileSync(
    Path.join(editors, "vscode/syntaxes/css.styled-ppx.json"),
    "utf8"
  )
);

const styledPpxOCamlGrammar = {
  ...JSON.parse(
    Fs.readFileSync(
      Path.join(editors, "vscode/syntaxes/styled-ppx-ocaml.json"),
      "utf8"
    )
  ),
  injectTo: ["source.ocaml"],
};

const styledPpxReScriptGrammar = {
  ...JSON.parse(
    Fs.readFileSync(
      Path.join(editors, "vscode/syntaxes/styled-ppx-rescript.json"),
      "utf8"
    )
  ),
  injectTo: ["source.rescript"],
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

const withNextra = nextra({
  theme: "nextra-theme-docs",
  themeConfig: "./theme.config.tsx",
  mdxOptions: {
    rehypePrettyCodeOptions: {
      theme: { light: "github-light", dark: "github-dark-dimmed" },
      getHighlighter: (options) =>
        Shiki.getHighlighter({
          ...options,
          langs: [
            ...Object.keys(bundledLanguages),
            rescriptGrammar,
            reasonGrammar,
            styledPpxCssGrammar,
            styledPpxOCamlGrammar,
            styledPpxReScriptGrammar,
            styledPpxReasonGrammar,
          ],
        }),
    },
  },
});

/**
 * @type {import('next').Config}
 */
const nextConfig = {};

export default withNextra(nextConfig);
