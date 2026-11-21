const path = require("path");
const runTests = require("vscode-test").runTests;

async function main() {
  try {
    const extensionDevelopmentPath = path.resolve(__dirname, "../");

    const extensionTestsPath = path.resolve(__dirname, "./suite/index");

    const launchArgs = [
      "--disable-extensions",
    ];

    await runTests({
      extensionDevelopmentPath,
      extensionTestsPath,
      launchArgs,
    });
  } catch (err) {
    console.error("Failed to run tests");
    process.exit(1);
  }
}

main();
