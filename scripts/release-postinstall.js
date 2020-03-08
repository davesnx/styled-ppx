#!/usr/bin/env node

const path = require("path");
const cp = require("child_process");
const fs = require("fs");

const platform = process.platform;

const binariesToCopy = ["styled-ppx.exe"];

function find_arch() {
  // The running binary is 64-bit, so the OS is clearly 64-bit.
  if (process.arch === "x64") {
    return "x64";
  }

  // All recent versions of Mac OS are 64-bit.
  if (process.platform === "darwin") {
    return "x64";
  }

  // On Windows, the most reliable way to detect a 64-bit OS from within a 32-bit
  // app is based on the presence of a WOW64 file: %SystemRoot%\SysNative.
  // See: https://twitter.com/feross/status/776949077208510464
  if (process.platform === "win32") {
    var useEnv = false;
    try {
      useEnv = !!(
        process.env.SYSTEMROOT && fs.statSync(process.env.SYSTEMROOT)
      );
    } catch (err) {}

    const sysRoot = useEnv ? process.env.SYSTEMROOT : "C:\\Windows";

    // If %SystemRoot%\SysNative exists, we are in a WOW64 FS Redirected application.
    const isWOW64 = false;
    try {
      isWOW64 = !!fs.statSync(path.join(sysRoot, "sysnative"));
    } catch (err) {}

    return isWOW64 ? "x64" : "x86";
  }

  if (process.platform === "linux") {
    const output = cp.execSync("getconf LONG_BIT", { encoding: "utf8" });
    return output === "64\n" ? "x64" : "x86";
  }

  return "x86";
}

// Implementing it b/c we don"t want to depend on fs.copyFileSync which appears only in node@8.x
function copyFileSync(sourcePath, destPath) {
  const data = fs.readFileSync(sourcePath);
  const stat = fs.statSync(sourcePath);
  fs.writeFileSync(destPath, data);
  fs.chmodSync(destPath, stat.mode);
}

const copyPlatformBinaries = platformPath => {
  const platformBuildPath = path.join(__dirname, platformPath);

  binariesToCopy.forEach(binaryPath => {
    const sourcePath = path.join(platformBuildPath, binaryPath);
    const destPath = path.join(__dirname, binaryPath);
    if (fs.existsSync(destPath)) {
      fs.unlinkSync(destPath);
    }
    copyFileSync(sourcePath, destPath);
    fs.chmodSync(destPath, 0o755);
  });
};

const arch = find_arch();
const platformPath = "platform-" + platform + "-" + arch;
const supported = fs.existsSync(platformPath);

if (!supported) {
  console.error("styled-ppx does not support this platform :(");
  console.error("");
  console.error("If you want styled-ppx to support this platform natively,");
  console.error(
    "please open an issue here: https://github.com/davesnx/styled-ppx/issues/new"
  );
  console.error("Specify that you are on the " + platform + " platform,");
  console.error("and on the " + arch + " architecture.");
  process.exit(1);
}

copyPlatformBinaries(platformPath);
