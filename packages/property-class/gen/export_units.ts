import { readFileSync, writeFileSync } from "node:fs";
import { loadCases } from "../../cx-conformance/src/load.ts";
import { coverOf, type CoverageTable } from "../../cx-conformance/src/coverage.ts";
import { atomize, tier } from "../../cx-conformance/src/candidates/model.ts";
import { SELF, declarations, substitute, type Declaration } from "../../cx-conformance/src/css.ts";

type Decl = { scope: string; conditions: string[]; important: boolean; prop: string; text: string };
type Unit = { pieces: Declaration[]; bundle: boolean; tier: number; conds: number; cover: number };

const out = process.argv[2];
if (!out) throw new Error("usage: export_units.ts <output.json>");

const table = JSON.parse(
  readFileSync(new URL("../../cx-conformance/coverage.json", import.meta.url), "utf8"),
) as CoverageTable;
const cover = coverOf(table);

const plain = (d: Declaration): Decl => ({
  scope: d.context.scope.replaceAll("." + SELF, "&"),
  conditions: d.context.conditions,
  important: d.context.important,
  prop: d.prop,
  text: d.text,
});

const conditionCount = (d: Declaration): number =>
  d.context.conditions.length + (d.context.scope === "." + SELF ? 0 : 1);

const cellsOf = (pieces: Declaration[]): string[] =>
  pieces.flatMap((p) => cover(p.prop).map((leaf) => `${p.contextKey}#${leaf}`));

const unitOf = (pieces: Declaration[]): Unit => ({
  pieces,
  bundle: new Set(pieces.map((p) => `${p.contextKey}#${p.prop}`)).size > 1,
  tier: Math.max(...pieces.map((p) => tier(p.context))),
  conds: Math.max(...pieces.map(conditionCount)),
  cover: new Set(cellsOf(pieces)).size,
});

// The model bundles a same-property group of mixed importance (RT-09); the design splits it by importance.
const splitByImportance = (u: Unit): Unit[] => {
  if (new Set(u.pieces.map((p) => p.context.important)).size < 2) return [u];
  if (new Set(u.pieces.map((p) => p.prop)).size !== 1) {
    throw new Error("mixed importance in a unit of several properties: the split is not exact");
  }
  return [false, true]
    .map((important) => u.pieces.filter((p) => p.context.important === important))
    .sort((a, b) => u.pieces.indexOf(a[a.length - 1]!) - u.pieces.indexOf(b[b.length - 1]!))
    .map(unitOf);
};

const blocks: string[] = [];
for (const c of await loadCases()) {
  const model = atomize(c, cover, {
    refs: "binding-id",
    normalize: "design",
    bundles: true,
    siblingIds: true,
    vars: "roles",
  });
  for (const name of Object.keys(c.blocks)) {
    const resolved = substitute(
      c,
      c.blocks[name]!,
      (other) => model.bindingIds.get(other)!,
      (varName) => `var(--cxv-${varName})`,
    );
    const decls = declarations(resolved, "design").map((d) =>
      tier(d.context) === 0 ? { ...d, text: d.text.replace(/(--cxv-\w+?)\)/g, "$1-d)") } : d,
    );
    const modelUnits = model.atomsOf.get(name)!.map((a) => unitOf(a.pieces));
    modelUnits.forEach((u, i) => {
      const a = model.atomsOf.get(name)![i]!;
      if (u.bundle !== a.bundle || u.tier !== a.sortKey[0] || u.conds !== a.sortKey[1] || u.cover !== a.cov) {
        throw new Error(`${c.id}/${name}: unit ${i} attributes differ from the model's atom`);
      }
    });
    const units = modelUnits.flatMap(splitByImportance);
    const covered = units.reduce((n, u) => n + u.pieces.length, 0);
    if (covered !== decls.length) {
      throw new Error(`${c.id}/${name}: ${decls.length} declarations, ${covered} in units`);
    }
    const rows = units.map((u, i) => {
      const later = new Set(units.slice(i + 1).flatMap((v) => cellsOf(v.pieces)));
      return {
        pieces: u.pieces.map(plain),
        bundle: u.bundle,
        tier: u.tier,
        conds: u.conds,
        cover: u.cover,
        dead: cellsOf(u.pieces).every((cell) => later.has(cell)),
      };
    });
    blocks.push(JSON.stringify({ case: c.id, block: name, decls: decls.map(plain), units: rows }));
  }
}

writeFileSync(out, "[\n" + blocks.join(",\n") + "\n]\n");
