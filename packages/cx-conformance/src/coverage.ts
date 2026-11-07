import { existsSync, readFileSync, writeFileSync } from "node:fs";
import type { Browser } from "playwright-core";

export type CoverageTable = {
  browser: string;
  method: string;
  extra: string[];
  checked: string[];
  shorthands: Record<string, string[]>;
};

export const coveragePath = new URL("../coverage.json", import.meta.url);

const method =
  "For every property name the browser exposes on CSSStyleDeclaration (camelCase " +
  "turned into dashed form) that CSS.supports with the value 'initial': set it to " +
  "'initial' on a scratch element's inline style and list the inline style's " +
  "longhands (when it lists only itself and is not a computed longhand, as `all` " +
  "does, read every computed longhand back instead). A property that lists more " +
  "than itself, or another name, is a " +
  "shorthand (or alias) and covers the listed longhands, reset-only members " +
  "included. Property names used by cases but not enumerated are added to `extra` " +
  "and derived the same way. Regenerate with --refresh-coverage.";

export async function deriveCoverage(browser: Browser, extra: string[]): Promise<CoverageTable> {
  const page = await browser.newPage();
  const { enumerated, checked, shorthands } = await page.evaluate((extra) => {
    const el = document.createElement("div");
    const names = new Set<string>();
    const style = el.style as unknown as Record<string, unknown>;
    for (const key in style) {
      if (typeof style[key] !== "string") continue;
      let dashed = key.replace(/[A-Z]/g, (m) => "-" + m.toLowerCase());
      if (dashed.startsWith("webkit-")) dashed = "-" + dashed;
      names.add(dashed);
    }
    const enumerated = [...names];
    for (const name of extra) names.add(name);
    const longhands = [...getComputedStyle(document.documentElement)];
    const out: Record<string, string[]> = {};
    for (const name of [...names].sort()) {
      if (!CSS.supports(name, "initial")) continue;
      el.removeAttribute("style");
      el.style.setProperty(name, "initial");
      let set = [...el.style];
      if (set.length === 1 && set[0] === name && !longhands.includes(name)) {
        set = longhands.filter((l) => el.style.getPropertyValue(l) !== "");
      }
      if (set.length > 0 && !(set.length === 1 && set[0] === name)) out[name] = set;
    }
    return { enumerated, checked: [...names].sort(), shorthands: out };
  }, extra);
  await page.close();
  const listed = new Set(enumerated);
  return { browser: browser.version(), method, extra: extra.filter((n) => !listed.has(n)), checked, shorthands };
}

export async function loadCoverage(browser: Browser, refresh: boolean, used: string[]): Promise<CoverageTable> {
  const old = existsSync(coveragePath)
    ? (JSON.parse(readFileSync(coveragePath, "utf8")) as CoverageTable)
    : undefined;
  const known = new Set(old?.checked ?? []);
  const missing = [...new Set(used)].filter((p) => !p.startsWith("--") && !known.has(p));
  if (old && !refresh && missing.length === 0) return old;
  const table = await deriveCoverage(browser, [...new Set([...(old?.extra ?? []), ...missing])].sort());
  writeFileSync(coveragePath, JSON.stringify(table, null, 1) + "\n");
  return table;
}

export type Cover = (prop: string) => readonly string[];

export function coverOf(table: CoverageTable): Cover {
  return (prop) => table.shorthands[prop] ?? [prop];
}
