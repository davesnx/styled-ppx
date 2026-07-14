/* eslint-env node */
/**
 * Wrapper around nextra's loader that injects a custom shiki highlighter.
 *
 * Why this exists: Turbopack requires loader options to be JSON-serializable,
 * so the `getHighlighter` function (needed to register the Reason/OCaml/mlx/
 * dune grammars) cannot be passed through `next.config.mjs`. Loader *code* has
 * no such restriction, so this file interposes on nextra's loader and injects
 * the highlighter into the options at runtime. `next.config.mjs` remaps
 * nextra's turbopack rules to point here.
 *
 * Note: Turbopack evaluates loaders through its own bundler, so every import
 * in this file must be a static specifier (no computed paths, no __dirname).
 */
const nextraLoader = require("./node_modules/nextra/loader.cjs");

const reasonGrammar = {
  ...require("./syntaxes/reason.tmLanguage.json"),
  sourceName: "reason",
  name: "reason",
};

const ocamlGrammar = {
  ...require("./syntaxes/ocaml.tmLanguage.json"),
  sourceName: "ocaml",
  name: "ocaml",
};

// OCaml syntax dialect with JSX support (https://github.com/ocaml-mlx/mlx)
const mlxGrammar = {
  ...require("./syntaxes/mlx.tmLanguage.json"),
  sourceName: "mlx",
  name: "mlx",
};

const styledPpxCssGrammar = {
  ...require("../editors/vscode/syntaxes/css-styled-ppx.json"),
  injectTo: ["source.ocaml", "source.ocaml.mlx", "source.reason"],
};

const styledPpxOCamlGrammar = {
  ...require("../editors/vscode/syntaxes/styled-ppx-ocaml.json"),
  injectTo: ["source.ocaml", "source.ocaml.mlx"],
};

const styledPpxReasonGrammar = {
  ...require("../editors/vscode/syntaxes/styled-ppx-reason.json"),
  injectTo: ["source.reason"],
};

const duneGrammar = {
  ...require("./syntaxes/dune.tmLanguage.json"),
  name: "dune",
};

/** Same shape as nextra's default `getHighlighter`, plus our grammars. */
async function getHighlighter(options) {
  // shiki is ESM-only; import lazily from this CJS module.
  const { bundledLanguages, createHighlighter } = await import("shiki");
  return createHighlighter({
    ...options,
    langs: [
      ...Object.keys(bundledLanguages),
      reasonGrammar,
      ocamlGrammar,
      mlxGrammar,
      styledPpxCssGrammar,
      styledPpxOCamlGrammar,
      styledPpxReasonGrammar,
      duneGrammar,
    ],
  });
}

module.exports = function loader(code) {
  const options = this.getOptions();
  // Only MDX-compile invocations carry `mdxOptions`; nextra also uses its
  // loader for page-map generation, which must be left untouched.
  const ctx = options.mdxOptions
    ? Object.create(this, {
      getOptions: {
        value: () => ({
          ...options,
          mdxOptions: {
            ...options.mdxOptions,
            rehypePrettyCodeOptions: {
              ...options.mdxOptions.rehypePrettyCodeOptions,
              getHighlighter,
            },
          },
        }),
      },
    })
    : this;
  return nextraLoader.call(ctx, code);
};
