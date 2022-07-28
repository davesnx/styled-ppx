/* const Path = require("path"); */
const withNextra = require("nextra");

/* const { getHighlighter, BUNDLED_LANGUAGES } = require('shiki'); */

/* const langs = [
  ...BUNDLED_LANGUAGES,
  {
    id: 'rescript',
    scopeName: 'source.rescript',
    path: Path.join(__dirname, './syntax/rescript.tmLanguage.json'),
  },
  // This didn't work on nextra v2 beta 11, would be really sick
  {
    id: 'styled-ppx',
    scopeName: 'source.styled-ppx-rescript',
    path: Path.join(__dirname, '..', 'editors/vscode/syntaxes/styled-ppx-rescript.json'),
    embeddedLangs: ['css', 'rescript']
  },
]; */

module.exports = withNextra({
  i18n: {
    locales: ["en-US"],
    defaultLocale: "en-US",
  },
  theme: "nextra-theme-docs",
  themeConfig: "./theme.config.js",
  /* unstable_staticImage: true,
  unstable_flexsearch: true, */
/* mdxOptions: {
    rehypePrettyCodeOptions: {
      getHighlighter: options => {
        return getHighlighter({
          ...options,
          langs
        });
      },
    }
  } */
});
