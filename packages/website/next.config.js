const Path = require("path");
const withNextra = require("nextra");

const { getHighlighter, BUNDLED_LANGUAGES } = require('shiki');

const langs = [
  ...BUNDLED_LANGUAGES,
  {
    id: 'rescript',
    scopeName: 'source.rescript',
    path: Path.join(__dirname, './syntax/rescript.tmLanguage.json'),
  },
// Another day we will try to make all grammars work in the website
//  {
//    id: 'styled-ppx-rescript',
//    scopeName: 'source.styled-ppx-rescript',
//    path: Path.join(__dirname, '..', 'editors/vscode/syntaxes/styled-ppx-rescript.json'),
//    embeddedLangs: ['rescript', 'css', 'scss', 'styled-ppx-ocaml', 'styled-ppx-css'],
//  },
//  {
//    id: 'styled-ppx-ocaml',
//    scopeName: 'source.styled-ppx-ocaml',
//    path: Path.join(__dirname, '..', 'editors/vscode/syntaxes/styled-ppx-ocaml.json'),
//    embeddedLangs: ['css', 'scss', 'styled-ppx-css']
//  },
//  {
//    id: 'styled-ppx-css',
//    scopeName: 'source.css.styled-ppx',
//    path: Path.join(__dirname, '..', 'editors/vscode/syntaxes/css.styled-ppx.json'),
//    embeddedLangs: ['css', 'scss']
//  },
];

module.exports = withNextra({
  i18n: {
    locales: ["en-US"],
    defaultLocale: "en-US",
  },
  theme: "nextra-theme-docs",
  themeConfig: "./theme.config.js",
/* unstable_staticImage: true,
  unstable_flexsearch: true, */
  mdxOptions: {
    rehypePrettyCodeOptions: {
      theme: 'github-dark-dimmed',
      getHighlighter: options => {
        return getHighlighter({
          ...options,
          langs
        });
      },
    }
  }
});
