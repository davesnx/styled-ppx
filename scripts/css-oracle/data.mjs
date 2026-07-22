/**
 * Shared data loading and derivations for the CSS coverage oracle.
 *
 * Joins the css-grammar registry dump (registry_dump.exe output) with the
 * vendored @webref/css spec inventory and derives every coverage fact the
 * generated artifacts render:
 *   - scripts/css-oracle/report.mjs       -> packages/css-grammar/data/coverage.md
 *   - scripts/css-oracle/support-page.mjs -> packages/website/src/generated/css-support-tables.mdx
 *
 * Keep all classification and derivation logic here so both artifacts stay
 * on a single derivation chain; the render scripts are presentation only.
 */
import { readFileSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

export const root = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
export const dataDir = join(root, "packages", "css-grammar", "data");
export const coveragePath = join(dataDir, "coverage.md");
export const supportFragmentPath = join(
  root, "packages", "website", "src", "generated", "css-support-tables.mdx",
);

/* At-rule classification comes from the registry dump (single source of
   truth: packages/parser/lib/At_rules.re, dumped via registry_dump.ml).
   Everything below is presentation only: class → status text, plus
   per-name notes that add nuance without affecting the classification. */
const atRuleClassStatus = {
  atomized: "supported in `[%css]` and `[%styled.global]`",
  "atomized-block-only":
    "block form supported in `[%css]` and `[%styled.global]`",
  "keyframe-extension": "first-class via `[%keyframe]`",
  "descriptor-passthrough": "passthrough in `[%styled.global]`",
  "global-passthrough": "passthrough in `[%styled.global]`",
};
const atRuleNotes = {
  "@property": "auto-emitted by the pipeline",
  "@import": "no position enforcement",
  "@charset": "no position enforcement",
  "@namespace": "no position enforcement",
  "@layer": "statement form `[%styled.global]`-only",
  "@scope": "flattened",
  "@font-feature-values": "descriptors unvalidated",
};

export const pageMargin = new Set([
  "@top-left-corner", "@top-left", "@top-center", "@top-right",
  "@top-right-corner", "@bottom-left-corner", "@bottom-left",
  "@bottom-center", "@bottom-right", "@bottom-right-corner",
  "@left-top", "@left-middle", "@left-bottom",
  "@right-top", "@right-middle", "@right-bottom",
]);

/* Spec shortname → published-draft URL. @webref shortnames map onto the
   CSSWG drafts server except for the FXTF specs and the WHATWG compat
   spec; `unknown` groups SVG/MathML properties webref carries without a
   CSS spec label and has no single URL. */
const fxtfSpecs = new Set([
  "compositing-1", "compositing-2", "fill-stroke-3",
  "filter-effects-1", "filter-effects-2", "motion-1",
]);
export const specUrl = (spec) => {
  if (spec === "unknown") return null;
  if (spec === "compat") return "https://compat.spec.whatwg.org/";
  if (fxtfSpecs.has(spec)) return `https://drafts.fxtf.org/${spec}/`;
  return `https://drafts.csswg.org/${spec}/`;
};

export const loadOracle = (dumpPath) => {
  const webref = JSON.parse(
    readFileSync(join(dataDir, "webref-css.json"), "utf8"),
  );

  const dump = readFileSync(dumpPath, "utf8")
    .trim()
    .split("\n")
    .map((line) => line.split("\t"));
  const registered = (kind) =>
    new Set(dump.filter(([k]) => k === kind).map(([, name]) => name));

  const properties = registered("property");
  const functions = registered("function");
  const mediaFeatures = registered("media-feature");
  const atRuleClasses = new Map(
    dump.filter(([k]) => k === "at-rule").map(([, name, cls]) => [name, cls]),
  );

  const atRuleStatus = (name) => {
    const cls = atRuleClasses.get(name);
    if (cls === undefined) return "**not supported**";
    const status = atRuleClassStatus[cls];
    if (status === undefined) {
      throw new Error(`unknown at-rule class '${cls}' in registry dump`);
    }
    const note = atRuleNotes[name];
    return note ? `${status} (${note})` : status;
  };

  /* ---- Properties ---- */
  const specProps = Object.entries(webref.properties);
  const stdProps = specProps.filter(([, v]) => !v.legacyAliasOf);
  const aliasProps = specProps.filter(([, v]) => v.legacyAliasOf);
  const missing = stdProps.filter(([name]) => !properties.has(name));
  const missingAliases = aliasProps.filter(([name]) => !properties.has(name));
  const extra = [...properties].filter(
    (name) =>
      !Object.hasOwn(webref.properties, name) &&
      !name.startsWith("media-") &&
      name !== "--*",
  );

  /* Per-spec property coverage: standard properties grouped by the spec
     shortname webref attributes them to. */
  const propertiesBySpec = new Map();
  for (const [name, v] of stdProps) {
    const entry = propertiesBySpec.get(v.spec) ?? { total: 0, covered: 0 };
    entry.total += 1;
    if (properties.has(name)) entry.covered += 1;
    propertiesBySpec.set(v.spec, entry);
  }

  /* ---- Functions ---- */
  const fnNames = webref.functions;
  const missingFns = fnNames.filter((f) => !functions.has(f));

  /* ---- Media features ---- */
  const specMediaFeatures = (webref.atrules["@media"]?.descriptors ?? []).sort();
  const missingMedia = specMediaFeatures.filter((f) => !mediaFeatures.has(f));

  /* ---- At-rules ---- */
  const specAtRules = Object.keys(webref.atrules)
    .filter((a) => !pageMargin.has(a) && !a.startsWith("@-"))
    .sort();
  const handledAtRules = specAtRules.filter((a) => atRuleClasses.has(a));

  return {
    webref,
    properties, functions, mediaFeatures, atRuleClasses, atRuleStatus,
    stdProps, aliasProps, missing, missingAliases, extra, propertiesBySpec,
    fnNames, missingFns,
    specMediaFeatures, missingMedia,
    specAtRules, handledAtRules,
  };
};
