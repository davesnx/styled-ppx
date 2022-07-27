const Path = require("path");
const Nextra = require("nextra");
const { getHighlighter, BUNDLED_LANGUAGES } = require('shiki');

const langs = [
  ...BUNDLED_LANGUAGES,
  {
    id: 'rescript',
    scopeName: 'source.rescript',
    path: Path.join(__dirname, './syntax/rescript.tmLanguage.json'),
  },
  /* {
    id: 'styled-ppx',
    scopeName: 'source.styled-ppx-rescript',
    path: Path.join(__dirname, '..', 'editors/vscode/syntaxes/styled-ppx-rescript.json'),
    embeddedLangs: ['css', 'rescript']
  }, */
];

module.exports = Nextra({
  i18n: {
    locales: ["en-US"],
    defaultLocale: "en-US",
  },
  theme: "nextra-theme-docs",
  themeConfig: "./theme.config.js",
  unstable_staticImage: true,
  unstable_flexsearch: true,
  mdxOptions: {
    rehypePrettyCodeOptions: {
      getHighlighter: options => {
        return getHighlighter({
          ...options,
          langs
        });
      },
    }
  }
});
