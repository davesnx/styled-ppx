const { join } = require("path");
const nextra = require("nextra");
const { getHighlighter, BUNDLED_LANGUAGES } = require("shiki");

const langs = [
  ...BUNDLED_LANGUAGES,
  {
    id: "rescript",
    scopeName: "source.rescript",
    path: join(__dirname, "syntaxes/rescript.tmLanguage.json"),
  },
  {
    id: "reason",
    scopeName: "source.reason",
    path: join(__dirname, "syntaxes/reason.tmLanguage.json"),
  },
  {
    id: "styled-ppx-css",
    scopeName: "source.css.styled-ppx",
    path: join(
      __dirname,
      "../..",
      "editors/vscode/syntaxes/css.styled-ppx.json"
    ),
  },
  {
    id: "styled-ppx-ocaml",
    scopeName: "source.styled-ppx-ocaml",
    injectTo: ["source.ocaml"],
    path: join(
      __dirname,
      "../..",
      "editors/vscode/syntaxes/styled-ppx-ocaml.json"
    ),
  },
  {
    id: "styled-ppx-rescript",
    scopeName: "source.styled-ppx-rescript",
    injectTo: ["source.rescript"],
    path: join(
      __dirname,
      "../..",
      "editors/vscode/syntaxes/styled-ppx-rescript.json"
    ),
  },
  {
    id: "styled-ppx-reason",
    scopeName: "source.styled-ppx-reason",
    injectTo: ["source.reason"],
    path: join(
      __dirname,
      "../..",
      "editors/vscode/syntaxes/styled-ppx-reason.json"
    ),
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

module.exports = withNextra({ transpilePackages: ["nextra-theme-docs"] });
