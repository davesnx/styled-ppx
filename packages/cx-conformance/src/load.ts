import { readdirSync } from "node:fs";
import type { Case } from "./case.ts";
import { bindingRefs, elements, varRefs } from "./css.ts";

export const casesDir = new URL("../cases/", import.meta.url);

export type LoadedCase = Case & { file: string };

export function validate(c: Case, where: string): string[] {
  const errors: string[] = [];
  const err = (msg: string) => errors.push(`${where}: case ${JSON.stringify(c.id)}: ${msg}`);
  if (typeof c.id !== "string" || c.id === "") err("missing id");
  if (!c.blocks || Object.keys(c.blocks).length === 0) err("no blocks");
  const blocks = new Set(Object.keys(c.blocks ?? {}));
  for (const [name, css] of Object.entries(c.blocks ?? {})) {
    if (typeof css !== "string") {
      err(`block ${name} is not a string`);
      continue;
    }
    for (const ref of bindingRefs(css)) if (!blocks.has(ref)) err(`block ${name}: .$(${ref}) is not a block`);
    for (const ref of varRefs(css)) if (!c.vars?.[ref]) err(`block ${name}: $(${ref}) is not in vars`);
  }
  const els = elements(c.tree ?? []);
  if (els.length === 0) err("empty tree");
  const ids = new Set<string>();
  for (const el of els) {
    if (typeof el.id !== "string" || !Array.isArray(el.merge) || !el.merge.every((m) => typeof m === "string")) {
      err(`element ${JSON.stringify(el.id)}: needs a string id and a merge list of block names`);
      continue;
    }
    if (ids.has(el.id)) err(`duplicate element id ${el.id}`);
    ids.add(el.id);
    for (const m of el.merge) if (!blocks.has(m)) err(`element ${el.id}: merge name ${m} is not a block`);
  }
  if (!c.probes || c.probes.length === 0) err("no probes");
  for (const p of c.probes ?? []) {
    if (!ids.has(p.el)) err(`probe element ${p.el} is not in the tree`);
    if (p.props !== undefined && (!Array.isArray(p.props) || p.props.length === 0)) err(`probe on ${p.el}: props must be a non-empty list`);
  }
  if (c.orders && c.orders !== "as-written" && c.orders !== "all-permutations") err(`bad orders ${c.orders}`);
  return errors;
}

export async function loadCases(): Promise<LoadedCase[]> {
  const files = readdirSync(casesDir).filter((f) => f.endsWith(".ts")).sort();
  const out: LoadedCase[] = [];
  const errors: string[] = [];
  const seen = new Map<string, string>();
  for (const file of files) {
    const mod = (await import(new URL(file, casesDir).href)) as { cases?: unknown };
    if (!Array.isArray(mod.cases)) {
      errors.push(`cases/${file}: does not export "cases: Case[]"`);
      continue;
    }
    for (const c of mod.cases as Case[]) {
      errors.push(...validate(c, `cases/${file}`));
      const prev = seen.get(c.id);
      if (prev) errors.push(`cases/${file}: case ${JSON.stringify(c.id)}: id also used in ${prev}`);
      seen.set(c.id, `cases/${file}`);
      out.push({ ...c, file });
    }
  }
  if (errors.length > 0) throw new Error("invalid cases:\n  " + errors.join("\n  "));
  return out;
}

export function globToRegExp(glob: string): RegExp {
  const body = glob
    .split(",")
    .map((g) => g.replace(/[.+^${}()|[\]\\]/g, "\\$&").replace(/\*/g, ".*").replace(/\?/g, "."))
    .join("|");
  return new RegExp(`^(?:${body})$`);
}
