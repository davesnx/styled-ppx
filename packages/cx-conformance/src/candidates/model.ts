import type { Candidate, Case, El } from "../case.ts";
import type { Cover } from "../coverage.ts";
import {
  SELF,
  bindingRefs,
  declarations,
  mergeOf,
  renderTree,
  substitute,
  wrapRule,
  type Context,
  type Declaration,
  type Normalize,
} from "../css.ts";

export type Atom = {
  cls: string;
  pieces: Declaration[];
  bundle: boolean;
  sortKey: [tier: number, conditions: number];
  cov: number;
  first: number;
  owner: string | undefined;
  reads: string[];
};

export type Atomized = {
  atomsOf: Map<string, Atom[]>;
  atoms: Atom[];
  bindingIds: Map<string, string>;
};

export type VarMode = "baked" | "roles" | "one-name";

export type AtomizeOptions = {
  refs: "binding-id" | "atom-chain";
  normalize: Normalize;
  bundles: boolean;
  siblingIds: boolean;
  vars: VarMode;
};

const varToken = /var\((--cxv-\w+?(?:-d)?)\)/g;
const readsOf = (text: string): string[] => [...text.matchAll(varToken)].map((m) => m[1]!);
const varNameOf = (token: string): string => token.replace(/^--cxv-/, "").replace(/-d$/, "");

export function isSiblingScope(scope: string): boolean {
  const flat = scope.replace(/\([^()]*\)/g, "").replace(/\[[^\]]*\]/g, "");
  return flat.split(/\s*[+~]\s*/).slice(1).some((part) => part.includes(SELF));
}

function lastCombinator(selector: string): number {
  let depth = 0;
  let last = -1;
  [...selector].forEach((ch, i) => {
    if (ch === "(" || ch === "[") depth++;
    else if (ch === ")" || ch === "]") depth--;
    else if (depth === 0 && (ch === " " || ch === ">" || ch === "+" || ch === "~")) last = i;
  });
  return last;
}

export function tier(context: Context): number {
  const cut = lastCombinator(context.scope);
  if (cut >= 0 && context.scope.slice(0, cut).includes(SELF)) return 0;
  if (context.scope === "." + SELF && context.conditions.length === 0) return 1;
  return 2;
}

function conditionCount(context: Context): number {
  return context.conditions.length + (context.scope === "." + SELF ? 0 : 1);
}

function subject(context: Context): string {
  if (tier(context) === 0) return "descendant";
  return /::[a-z-]+/.exec(context.scope)?.[0] ?? "own";
}

const keyOf = (d: Declaration): [number, number] => [tier(d.context), conditionCount(d.context)];
const before = (x: [number, number], y: [number, number]) => x[0] < y[0] || (x[0] === y[0] && x[1] < y[1]);

function units(decls: Declaration[], cover: Cover, bundles: boolean): Declaration[][] {
  const parent = decls.map((_, i) => i);
  const find = (i: number): number => (parent[i] === i ? i : (parent[i] = find(parent[i]!)));
  const join = (i: number, j: number) => {
    const a = find(i), b = find(j);
    if (a === b) return false;
    parent[Math.max(a, b)] = Math.min(a, b);
    return true;
  };
  decls.forEach((d, i) =>
    decls.forEach((e, j) => {
      if (j > i && d.contextKey === e.contextKey && d.prop === e.prop) join(i, j);
    }),
  );
  if (bundles) {
    const leaves = decls.map((d) => new Set(cover(d.prop)));
    const members = (root: number) => decls.flatMap((_, k) => (find(k) === root ? [k] : []));
    const unitKey = (root: number): [number, number] => {
      const ks = members(root).map((k) => keyOf(decls[k]!));
      return [Math.max(...ks.map((k) => k[0])), Math.max(...ks.map((k) => k[1]))];
    };
    const isBundle = (root: number) => new Set(members(root).map((k) => decls[k]!.contextKey + "#" + decls[k]!.prop)).size > 1;
    let changed = true;
    while (changed) {
      changed = false;
      for (let i = 0; i < decls.length; i++) {
        for (let j = i + 1; j < decls.length; j++) {
          const d = decls[i]!, e = decls[j]!;
          const ri = find(i), rj = find(j);
          if (ri === rj || subject(d.context) !== subject(e.context)) continue;
          if (![...leaves[i]!].some((l) => leaves[j]!.has(l))) continue;
          const nested = [...leaves[i]!].every((l) => leaves[j]!.has(l)) || [...leaves[j]!].every((l) => leaves[i]!.has(l));
          if (d.contextKey === e.contextKey && nested && !isBundle(ri) && !isBundle(rj)) continue;
          if (d.contextKey !== e.contextKey && !isBundle(ri) && !isBundle(rj) && before(keyOf(d), keyOf(e))) continue;
          if (isBundle(ri) || isBundle(rj) ? before(unitKey(ri), unitKey(rj)) : false) continue;
          changed = join(i, j) || changed;
        }
      }
    }
  }
  const byRoot = new Map<number, number[]>();
  decls.forEach((_, k) => byRoot.set(find(k), [...(byRoot.get(find(k)) ?? []), k]));
  return [...byRoot.values()]
    .sort((a, b) => a[a.length - 1]! - b[b.length - 1]!)
    .map((ks) => ks.map((k) => decls[k]!));
}

export function atomize(c: Case, cover: Cover, opts: AtomizeOptions): Atomized {
  const referenced = new Set(Object.values(c.blocks).flatMap(bindingRefs));
  const bindingIds = new Map<string, string>();
  for (const [name, css] of Object.entries(c.blocks)) {
    if (referenced.has(name) || css.trim() === "") bindingIds.set(name, `b-${name}`);
  }
  const interned = new Map<string, Atom>();
  const atomsOf = new Map<string, Atom[]>();
  const refClass = (other: string, stack: string[]): string => {
    if (opts.refs === "binding-id") return bindingIds.get(other)!;
    const chain = visit(other, stack).map((a) => a.cls);
    return chain.length > 0 ? chain.join(".") : bindingIds.get(other)!;
  };
  const varText = (name: string, value: string) => (opts.vars === "baked" ? value : `var(--cxv-${name})`);
  const visit = (name: string, stack: string[]): Atom[] => {
    const done = atomsOf.get(name);
    if (done) return done;
    if (stack.includes(name)) throw new Error(`${c.id}: cyclic .$(${name})`);
    const resolved = substitute(c, c.blocks[name]!, (other) => refClass(other, [...stack, name]), varText);
    const decls = declarations(resolved, opts.normalize).map((d) =>
      opts.vars === "roles" && tier(d.context) === 0 ? { ...d, text: d.text.replace(/(--cxv-\w+?)\)/g, "$1-d)") } : d,
    );
    const atoms = units(decls, cover, opts.bundles).map((pieces) => {
      const bundle = new Set(pieces.map((p) => p.contextKey + "#" + p.prop)).size > 1;
      const sibling = opts.siblingIds && pieces.some((p) => isSiblingScope(p.context.scope));
      if (sibling) bindingIds.set(name, `b-${name}`);
      const key = (sibling ? `owner ${name} ` : "") + (bundle ? "bundle " : "") + pieces.map((p) => `${p.contextKey} # ${p.text}`).join(" ; ");
      const keys = pieces.map(keyOf);
      const atom = interned.get(key) ?? {
        cls: `${bundle ? "B" : "a"}${interned.size}`,
        pieces,
        bundle,
        sortKey: [Math.max(...keys.map((k) => k[0])), Math.max(...keys.map((k) => k[1]))],
        cov: new Set(pieces.flatMap((p) => cover(p.prop).map((l) => p.contextKey + "#" + l))).size,
        first: interned.size,
        owner: sibling ? name : undefined,
        reads: [...new Set(pieces.flatMap((p) => readsOf(p.text)))],
      };
      interned.set(key, atom);
      return atom;
    });
    atomsOf.set(name, atoms);
    return atoms;
  };
  for (const name of Object.keys(c.blocks)) visit(name, []);
  return { atomsOf, atoms: [...interned.values()], bindingIds };
}

export function atomCss(a: Atom): string {
  const rules: { context: Context; contextKey: string; texts: string[] }[] = [];
  for (const p of a.pieces) {
    const last = rules[rules.length - 1];
    if (last && last.contextKey === p.contextKey) last.texts.push(p.text);
    else rules.push({ context: p.context, contextKey: p.contextKey, texts: [p.text] });
  }
  return rules
    .map((r) => wrapRule(r.context, a.owner && isSiblingScope(r.context.scope) ? `${a.cls}.b-${a.owner}` : a.cls, r.texts.join(";")))
    .join("");
}

export type ModelOptions = {
  name: string;
  vars?: VarMode;
  cover: Cover;
  dropBy: "coverage" | "same-property";
  dropAcrossContexts: boolean;
  tiers: boolean;
};

export function sheetOrder(atoms: Atom[], tiers: boolean): Atom[] {
  const key = (a: Atom) => (tiers ? [...a.sortKey, -a.cov, a.first] : [a.first]);
  return [...atoms].sort((x, y) => {
    const kx = key(x), ky = key(y);
    for (let i = 0; i < kx.length; i++) if (kx[i] !== ky[i]) return kx[i]! - ky[i]!;
    return 0;
  });
}

export function makeModel(opts: ModelOptions): Candidate {
  const cells = (a: Atom): string[] =>
    a.pieces.flatMap((p) => {
      const ctx = opts.dropAcrossContexts ? "" : p.contextKey;
      return opts.dropBy === "same-property" ? [`${ctx}#${p.prop}`] : opts.cover(p.prop).map((l) => `${ctx}#${l}`);
    });
  const coveredBy = (x: Atom, later: Atom[]): boolean => {
    const union = new Set(later.flatMap(cells));
    return cells(x).every((cell) => union.has(cell));
  };
  const normalize = (atoms: Atom[]): Atom[] => atoms.filter((x, i) => !coveredBy(x, atoms.slice(i + 1)));
  const merge2 = (a: Atom[], b: Atom[]): Atom[] => normalize([...a, ...b]);
  const merge = (operands: Atom[][]): Atom[] => operands.reduce(merge2, []);

  return {
    name: opts.name,
    async render(c: Case, order: Record<string, string[]>) {
      const vars = opts.vars ?? "roles";
      const { atomsOf, atoms, bindingIds } = atomize(c, opts.cover, { refs: "binding-id", normalize: "design", bundles: true, siblingIds: true, vars });
      const css = sheetOrder(atoms, opts.tiers).map(atomCss).join("\n");
      const keptOf = (el: El) => merge(mergeOf(el, order).map((n) => atomsOf.get(n)!));
      const html = renderTree(
        c.tree,
        (el) => {
          const ids = mergeOf(el, order).flatMap((n) => bindingIds.get(n) ?? []);
          return [...new Set([...keptOf(el).map((a) => a.cls), ...ids])].join(" ");
        },
        (el) => {
          const tokens = [...new Set(keptOf(el).flatMap((a) => a.reads))];
          return tokens.map((t) => `${t}:${c.vars![varNameOf(t)]!.css}`).join(";");
        },
      );
      return { css, html };
    },
  };
}

export const modelOptions = (cover: Cover): ModelOptions => ({
  name: "model",
  cover,
  dropBy: "coverage",
  dropAcrossContexts: false,
  tiers: true,
});
