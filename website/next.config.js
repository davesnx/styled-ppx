const bsconfig = require("./bsconfig.json");

const transpileModules = ["bs-platform"].concat(bsconfig["bs-dependencies"]);
const withTM = require("next-transpile-modules")(transpileModules);

const config = {
  target: "serverless",
  pageExtensions: ["jsx", "js", "bs.js"],
};

module.exports = withTM(config);
