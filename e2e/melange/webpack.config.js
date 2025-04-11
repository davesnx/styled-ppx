const Path = require("path")

module.exports = {
  mode: "development",
  entry: "../../_build/default/e2e/melange/e2e-melange/e2e/melange/client.bs.js",
  resolve: {
    modules: [Path.resolve(__dirname, 'node_modules'), 'node_modules']
  }
}
