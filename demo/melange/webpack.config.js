const Path = require("path")

module.exports = {
  mode: "development",
  entry: "../../_build/default/demo/melange/demo-melange/demo/melange/client.bs.js",
  devServer: {
    static: [
      Path.resolve(__dirname, "public"),
      Path.resolve(__dirname, "../../_build/default/demo/melange/public"),
    ],
  },
  resolve: {
    modules: [Path.resolve(__dirname, 'node_modules'), 'node_modules']
  }
}
