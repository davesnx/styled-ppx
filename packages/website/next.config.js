const nextra = require("nextra");

module.exports = nextra({
  theme: "nextra-theme-docs",
  themeConfig: "./theme.config.js",
  unstable_staticImage: true,
});
