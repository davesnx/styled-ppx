import { existsSync, readdirSync } from "node:fs";
import { homedir } from "node:os";
import { join } from "node:path";
import { chromium, type Browser } from "playwright-core";

function findChromium(): string {
  const fromEnv = process.env.CX_CHROMIUM;
  if (fromEnv) return fromEnv;
  const cache = join(homedir(), ".cache", "ms-playwright");
  const shells = existsSync(cache)
    ? readdirSync(cache)
        .filter((d) => d.startsWith("chromium_headless_shell-"))
        .sort((a, b) => Number(b.split("-")[1]) - Number(a.split("-")[1]))
    : [];
  for (const dir of shells) {
    for (const sub of readdirSync(join(cache, dir))) {
      const exe = join(cache, dir, sub, "chrome-headless-shell");
      if (existsSync(exe)) return exe;
    }
  }
  if (existsSync("/usr/bin/chromium")) return "/usr/bin/chromium";
  throw new Error(
    "no Chromium found: set CX_CHROMIUM, or install a headless shell in ~/.cache/ms-playwright",
  );
}

export function launch(): Promise<Browser> {
  return chromium.launch({ executablePath: findChromium() });
}
