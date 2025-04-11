const Path = require("path")

module.exports = {
  mode: "development",
  entry: "../../_build/default/demo/melange/demo-melange/demo/melange/client.bs.js",
  resolve: {
    modules: [Path.resolve(__dirname, 'node_modules'), 'node_modules']
  }
}
