import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import fs from "node:fs"
import nextra from "nextra";
import { getHighlighter } from "shiki";
import { bundledLanguages } from "shiki/langs";

const __dirname = dirname(fileURLToPath(import.meta.url));
const rescriptGrammar = JSON.parse(
  fs.readFileSync(join(__dirname, "syntaxes/rescript.tmLanguage.json"), "utf8")
);
const reasonGrammar = JSON.parse(
  fs.readFileSync(join(__dirname, "syntaxes/reason.tmLanguage.json"), "utf8")
);
const styledPpxCssGrammar = JSON.parse(
  fs.readFileSync(
    join(__dirname, "../..", "editors/vscode/syntaxes/css.styled-ppx.json"),
    "utf8"
  )
);
const styledPpxOCamlGrammar = JSON.parse(
  fs.readFileSync(
    join(__dirname, "../..", "editors/vscode/syntaxes/styled-ppx-ocaml.json"),
    "utf8"
  )
);
const styledPpxReScriptGrammar = JSON.parse(
  fs.readFileSync(
    join(
      __dirname,
      "../..",
      "editors/vscode/syntaxes/styled-ppx-rescript.json"
    ),
    "utf8"
  )
);
const styledPpxReasonGrammar = JSON.parse(
  fs.readFileSync(
    join(__dirname, "../..", "editors/vscode/syntaxes/styled-ppx-reason.json"),
    "utf8"
  )
);

const langs = [
  ...Object.keys(bundledLanguages),
  {
    //id: "rescript",
    //scopeName: "source.rescript",
    //path: join(__dirname, "syntaxes/rescript.tmLanguage.json"),
    ...rescriptGrammar,
    name: "rescript",
  },
  {
    //id: "reason",
    //scopeName: "source.reason",
    //path: join(__dirname, "syntaxes/reason.tmLanguage.json"),
    ...reasonGrammar,
    name: "reason",
  },
  {
    //id: "styled-ppx-css",
    //scopeName: "source.css.styled-ppx",
    //path: join(
    //  __dirname,
    //  "../..",
    //  "editors/vscode/syntaxes/css.styled-ppx.json"
    //),
    ...styledPpxCssGrammar,
    name: "styled-ppx-css",
  },
  {
    //id: "styled-ppx-ocaml",
    //scopeName: "source.styled-ppx-ocaml",
    //path: join(
    //  __dirname,
    //  "../..",
    //  "editors/vscode/syntaxes/styled-ppx-ocaml.json"
    //),
    ...styledPpxOCamlGrammar,
    injectTo: ["source.ocaml"],
    name: "styled-ppx-ocaml",
  },
  {
    //id: "styled-ppx-rescript",
    //scopeName: "source.styled-ppx-rescript",
    //path: join(
    //  __dirname,
    //  "../..",
    //  "editors/vscode/syntaxes/styled-ppx-rescript.json"
    //),
    ...styledPpxReScriptGrammar,
    injectTo: ["source.rescript"],
    name: "styled-ppx-rescript",
  },
  {
    //id: "styled-ppx-reason",
    //scopeName: "source.styled-ppx-reason",
    //injectTo: ["source.reason"],
    //path: join(
    //  __dirname,
    //  "../..",
    //  "editors/vscode/syntaxes/styled-ppx-reason.json"
    //),
    ...styledPpxReasonGrammar,
    injectTo: ["source.reason"],
    name: "styled-ppx-reason",
  },
];

const withNextra = nextra({
  theme: "nextra-theme-docs",
  themeConfig: "./theme.config.js",
  mdxOptions: {
    rehypePrettyCodeOptions: {
      theme: "github-light",
      getHighlighter: (options) =>
        getHighlighter({
          ...options,
          langs,
        }),
    },
  },
});

export default withNextra({
  transpilePackages: ["nextra-theme-docs", "nextra"],
});
