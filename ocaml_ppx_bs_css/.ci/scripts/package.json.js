
const fs = require("fs");
const path = require("path");

const mainPackageJson = require("../../package.json");
const packageJson = JSON.stringify(
  {
    name: mainPackageJson.name,
    version: mainPackageJson.version,
    description: mainPackageJson.description,
    license: mainPackageJson.license,
    files: ["bin", "postinstall.js"],
    keywords: mainPackageJson.keywords,
    scripts: {
      postinstall: "node ./postinstall.js"
    }
  },
  null,
  2
);

fs.writeFileSync(
  path.join(__dirname, "..", "..", "_release", "package.json"),
  packageJson,
  {encoding: "utf8"},
);