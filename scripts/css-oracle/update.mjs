/**
 * Refreshes the vendored CSS spec inventory from @webref/css (W3C's
 * machine-extracted spec data, MIT licensed). Run via `make css-oracle-update`
 * to sync against the latest specs; the slim result is committed so the
 * coverage report (`make css-oracle`) never needs network access.
 *
 * Output: packages/css-grammar/data/webref-css.json
 */
import { execSync } from "node:child_process";
import { mkdtempSync, readFileSync, writeFileSync, rmSync } from "node:fs";
import { tmpdir } from "node:os";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
const out = join(root, "packages", "css-grammar", "data", "webref-css.json");

const tmp = mkdtempSync(join(tmpdir(), "webref-css-"));
try {
  // --ignore-scripts: the package is consumed as data only (css.json), so
  // npm lifecycle scripts never need to run.
  execSync(
    "npm install @webref/css --ignore-scripts --no-save --no-audit --no-fund",
    { cwd: tmp, stdio: "inherit" },
  );
  const pkgDir = join(tmp, "node_modules", "@webref", "css");
  const version = JSON.parse(
    readFileSync(join(pkgDir, "package.json"), "utf8"),
  ).version;
  const data = JSON.parse(readFileSync(join(pkgDir, "css.json"), "utf8"));

  const specOf = (href) =>
    href?.match(/\/\/drafts\.csswg\.org\/([a-z0-9-]+)\//)?.[1] ??
    href?.match(/\/\/([a-z0-9-]+)\.spec\.whatwg\.org\//)?.[1] ??
    href?.match(/\/\/www\.w3\.org\/TR\/([a-zA-Z0-9-]+)\//)?.[1] ??
    href?.match(/\/\/drafts\.fxtf\.org\/([a-z0-9-]+)\//)?.[1] ??
    "unknown";

  const byName = (xs, extra = () => ({})) =>
    Object.fromEntries(
      xs
        .map((x) => [
          x.name,
          {
            ...(x.syntax ? { syntax: x.syntax } : {}),
            ...(x.legacyAliasOf ? { legacyAliasOf: x.legacyAliasOf } : {}),
            spec: specOf(x.href),
            ...extra(x),
          },
        ])
        // Code-point compare: localeCompare is locale-sensitive and could
        // produce spurious reorders across contributor machines.
        .sort(([a], [b]) => (a < b ? -1 : a > b ? 1 : 0)),
    );

  writeFileSync(
    out,
    JSON.stringify(
      {
        source: "@webref/css",
        version,
        license: "MIT (data machine-extracted from W3C specifications)",
        updated: new Date().toISOString().slice(0, 10),
        properties: byName(data.properties),
        atrules: byName(data.atrules, (a) => ({
          descriptors: (a.descriptors ?? []).map((d) => d.name),
        })),
        // Several specs export the same function/type name; dedupe so the
        // coverage report doesn't double-count.
        selectors: [...new Set(data.selectors.map((s) => s.name))].sort(),
        functions: [...new Set(data.functions.map((f) => f.name))].sort(),
        types: [...new Set(data.types.map((t) => t.name))].sort(),
      },
      null,
      1,
    ) + "\n",
  );
  console.log(`wrote ${out} (@webref/css ${version})`);
} finally {
  rmSync(tmp, { recursive: true, force: true });
}
