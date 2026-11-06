import type { Case, El, Probe, PseudoState, Viewport } from "./case.ts";
import { makeModel, modelOptions } from "./candidates/model.ts";
import type { Cover } from "./coverage.ts";
import { rng, seedOf, type Rng } from "./orders.ts";
import { defaultViewport, resolveProbes } from "./probe.ts";
import { runCase, type Suite } from "./suite.ts";

const values: Record<string, string[]> = {
  margin: ["1px", "2px 3px"],
  "margin-top": ["4px"],
  "margin-left": ["5px"],
  "margin-inline": ["6px"],
  "margin-inline-start": ["7px"],
  padding: ["1px", "2px 3px 4px"],
  "padding-top": ["5px"],
  "padding-left": ["6px"],
  "padding-block": ["7px"],
  border: ["1px solid red", "2px dashed blue"],
  "border-top": ["3px dotted green"],
  "border-left": ["5px solid teal"],
  "border-color": ["purple"],
  "border-width": ["4px"],
  "border-style": ["double"],
  "border-top-color": ["orange"],
  font: ["16px serif", "italic 700 12px/2 monospace"],
  "line-height": ["30px"],
  "font-size": ["20px"],
  "font-weight": ["300"],
  "font-kerning": ["none"],
  background: ["none", "linear-gradient(red, blue)"],
  "background-color": ["red", "blue"],
  "background-image": ["linear-gradient(green, yellow)"],
  inset: ["0px", "1px 2px"],
  top: ["5px"],
  left: ["6px"],
  flex: ["1", "2 3 4px"],
  "flex-basis": ["10px"],
  "flex-grow": ["5"],
  "place-items": ["center"],
  "align-items": ["end"],
  transition: ["opacity 1s"],
  "transition-duration": ["2s"],
  color: ["red", "blue", "green"],
  width: ["10px", "20px"],
  display: ["block", "flex"],
  opacity: ["0.5", "0.25"],
};

export const generatorProps = Object.keys(values);

const contexts = ["base", "m1", "m2", "m3", "hover", "before", "child"] as const;
type Ctx = (typeof contexts)[number];
const ctxWeights: Record<Ctx, number> = { base: 40, m1: 10, m2: 10, m3: 8, hover: 12, before: 8, child: 8 };
const media: Partial<Record<Ctx, string>> = {
  m1: "@media (min-width:700px)",
  m2: "@media (min-width:800px)",
  m3: "@media (max-width:600px)",
};
const viewports: Viewport[] = [1024, 750, 500].map((width) => ({ width, height: 768 }));
const states: PseudoState[][] = [[], ["hover"]];

type GDecl = { ctx: Ctx; prop: string; value: string; important: boolean };
type GCase = { blocks: GDecl[][]; merges: number[][] };

const names = "abcdefgh";

function families(cover: Cover): string[][] {
  const props = Object.keys(values);
  const parent = new Map(props.map((p) => [p, p]));
  const find = (p: string): string => (parent.get(p) === p ? p : find(parent.get(p)!));
  for (const a of props) {
    for (const b of props) {
      const cb = new Set(cover(b));
      if (cover(a).some((l) => cb.has(l))) parent.set(find(a), find(b));
    }
  }
  const groups = new Map<string, string[]>();
  for (const p of props) groups.set(find(p), [...(groups.get(find(p)) ?? []), p]);
  return [...groups.values()];
}

const pick = <T>(r: Rng, xs: readonly T[]): T => xs[Math.floor(r() * xs.length)]!;
const int = (r: Rng, lo: number, hi: number) => lo + Math.floor(r() * (hi - lo + 1));

function pickCtx(r: Rng): Ctx {
  const total = contexts.reduce((n, c) => n + ctxWeights[c], 0);
  let x = r() * total;
  for (const c of contexts) if ((x -= ctxWeights[c]) < 0) return c;
  return "base";
}

function shuffle<T>(r: Rng, xs: T[]): T[] {
  const out = [...xs];
  for (let i = out.length - 1; i > 0; i--) {
    const j = Math.floor(r() * (i + 1));
    [out[i], out[j]] = [out[j]!, out[i]!];
  }
  return out;
}

function randomCase(r: Rng, fams: string[][]): GCase {
  const chosen = [pick(r, fams), ...(r() < 0.5 ? [pick(r, fams)] : [])].flat();
  const blocks = Array.from({ length: int(r, 2, 4) }, () =>
    Array.from({ length: int(r, 1, 3) }, (): GDecl => {
      const prop = pick(r, chosen);
      return { ctx: pickCtx(r), prop, value: pick(r, values[prop]!), important: r() < 0.06 };
    }),
  );
  const merges = Array.from({ length: int(r, 1, 3) }, (_, i) => {
    const size = int(r, i === 0 ? 2 : 1, blocks.length);
    return shuffle(r, [...blocks.keys()]).slice(0, size);
  });
  return { blocks, merges };
}

function declCss(d: GDecl): string {
  const decl = `${d.prop}:${d.value}${d.important ? " !important" : ""};`;
  const m = media[d.ctx];
  if (m) return `${m}{${decl}}`;
  if (d.ctx === "hover") return `&:hover{${decl}}`;
  if (d.ctx === "before") return `&::before{content:"";${decl}}`;
  if (d.ctx === "child") return `& > *{${decl}}`;
  return decl;
}

function toCase(g: GCase, id: string, probes?: Probe[]): Case {
  const els: El[] = g.merges.map((m, i) => ({ id: `e${i}`, merge: m.map((b) => names[b]!) }));
  const [root, ...children] = els;
  return {
    id,
    title: "generated",
    why: "random case from --generate",
    blocks: Object.fromEntries(g.blocks.map((b, i) => [names[i]!, b.map(declCss).join("")])),
    tree: [{ ...root!, ...(children.length > 0 ? { children } : {}) }],
    probes:
      probes ??
      els.flatMap((el) =>
        viewports.flatMap((viewport) =>
          states.map((state) => ({ el: el.id, viewport, ...(state.length > 0 ? { state } : {}) })),
        ),
      ),
    orders: "all-permutations",
  };
}

function compact(v: unknown, indent: string): string {
  const flat = JSON.stringify(v);
  if (flat.length <= 72 || typeof v !== "object" || v === null) return flat;
  const inner = indent + "  ";
  if (Array.isArray(v)) return `[\n${v.map((x) => inner + compact(x, inner)).join(",\n")}\n${indent}]`;
  const entries = Object.entries(v).map(([k, x]) => `${inner}${/^[a-z]\w*$/i.test(k) ? k : JSON.stringify(k)}: ${compact(x, inner)}`);
  return `{\n${entries.join(",\n")}\n${indent}}`;
}

function* reductions(g: GCase): Generator<GCase> {
  for (let i = 0; i < g.merges.length && g.merges.length > 1; i++) {
    yield { ...g, merges: g.merges.filter((_, k) => k !== i) };
  }
  for (let j = 0; j < g.blocks.length && g.blocks.length > 1; j++) {
    const merges = g.merges.map((m) => m.filter((b) => b !== j).map((b) => (b > j ? b - 1 : b)));
    if (merges.some((m) => m.length === 0)) continue;
    yield { blocks: g.blocks.filter((_, k) => k !== j), merges };
  }
  for (let i = 0; i < g.merges.length; i++) {
    for (let k = 0; k < g.merges[i]!.length && g.merges[i]!.length > 1; k++) {
      yield { ...g, merges: g.merges.map((m, x) => (x === i ? m.filter((_, y) => y !== k) : m)) };
    }
  }
  const withDecl = (j: number, k: number, d: GDecl | undefined): GCase => ({
    ...g,
    blocks: g.blocks.map((b, x) =>
      x === j ? (d ? b.map((e, y) => (y === k ? d : e)) : b.filter((_, y) => y !== k)) : b,
    ),
  });
  for (let j = 0; j < g.blocks.length; j++) {
    const b = g.blocks[j]!;
    for (let k = 0; k < b.length; k++) {
      const d = b[k]!;
      if (b.length > 1) yield withDecl(j, k, undefined);
      if (d.important) yield withDecl(j, k, { ...d, important: false });
      if (d.ctx !== "base") yield withDecl(j, k, { ...d, ctx: "base" });
      if (d.value !== values[d.prop]![0]) yield withDecl(j, k, { ...d, value: values[d.prop]![0]! });
    }
  }
}

const shapes = {
  decision14: "recursive component (the child carries a block the parent also carries, so cx inserts the child's own class before the parent's `& > *` rule): decision 14, accepted 2026-11-06",
  descendant: "NEW: descendant scope on a child that does not carry the block",
  partial: "RT-01, accepted (decision 6): partial coverage across operands (like T04-T06)",
  logical: "RT-06, accepted (decision 9): logical vs physical longhands (like T19-T21)",
  conditions: "RT-05, accepted (decision 7): overlapping conditions from different operands (like T29-T31)",
  bundleResidual: "OPEN (RT-22 residual): a later operand overrides one context of an in-block bundle; the rest of the bundle stays and its sheet position against the later atom is fixed",
  inBlockConditions: "overlapping conditions in one block (like T35)",
  inBlockShadow: "one block, one context: a later shorthand does not drop an earlier longhand of the same block",
  unknown: "NEW: no known shape",
} as const;

function classify(g: GCase, cover: Cover): string {
  const decls = g.blocks.flatMap((b, block) => b.map((d) => ({ ...d, block })));
  const childDecls = decls.filter((d) => d.ctx === "child");
  if (childDecls.length > 0) {
    const parentBlocks = g.merges[0]!;
    const shared = g.merges.slice(1).some((m) => m.some((b) => parentBlocks.includes(b)));
    return shared && childDecls.some((d) => parentBlocks.includes(d.block)) ? shapes.decision14 : shapes.descendant;
  }
  const found = new Set<string>();
  decls.forEach((x, i) =>
    decls.slice(i + 1).forEach((y) => {
      const cx = new Set(cover(x.prop)), cy = new Set(cover(y.prop));
      const shared = [...cx].filter((l) => cy.has(l));
      if (shared.length === 0) {
        if (/-(inline|block)/.test(x.prop + " " + y.prop)) found.add(shapes.logical);
        return;
      }
      const nested = shared.length === cx.size || shared.length === cy.size;
      if (x.ctx === y.ctx && x.important === y.important) {
        if (!nested) found.add(shapes.partial);
        else if (x.block === y.block && x.prop !== y.prop) found.add(shapes.inBlockShadow);
      } else if (x.ctx !== "base" && y.ctx !== "base" && x.important === y.important) {
        found.add(x.block === y.block ? shapes.inBlockConditions : shapes.conditions);
      }
    }),
  );
  if (found.has(shapes.conditions) && found.has(shapes.inBlockConditions)) return shapes.bundleResidual;
  return [...found].sort().join(" + ") || shapes.unknown;
}

export async function generate(suite: Suite, n: number, seed: number): Promise<number> {
  const model = makeModel(modelOptions(suite.cover));
  const fams = families(suite.cover);
  const r = rng(seed);
  const generated = Array.from({ length: n }, () => randomCase(r, fams));
  const cap = Math.min(suite.cap, 12);
  const s: Suite = { ...suite, cap };
  const check = async (g: GCase) => {
    const c = toCase(g, `gen-${seed}-${seedOf(JSON.stringify(g)).toString(36)}`);
    const res = await runCase(s, c, model, false);
    return { c, res, failed: res.status === "fail" };
  };
  const t0 = Date.now();
  const first = await Promise.all(generated.map(check));
  const failures = first.flatMap((x, i) => (x.failed ? [i] : []));
  const errors = first.filter((x) => x.res.status === "error");
  console.log(
    `generated ${n} cases (seed ${seed}), ${first.reduce((k, x) => k + x.res.orders.length, 0)} case-orders: ` +
      `${failures.length} model failures, ${errors.length} oracle errors (${((Date.now() - t0) / 1000).toFixed(1)}s)`,
  );
  for (const e of errors) console.log(`  oracle error: ${e.res.orders.find((o) => o.error)?.error}`);

  const minimal = new Map<string, { g: GCase; count: number; from: number[] }>();
  const size = (g: GCase) => g.blocks.flat().length + g.merges.flat().length;
  for (const i of failures) {
    let cur = generated[i]!;
    let progress = true;
    while (progress) {
      progress = false;
      for (const next of reductions(cur)) {
        if ((await check(next)).failed) {
          cur = next;
          progress = true;
          break;
        }
      }
    }
    const shape = classify(cur, s.cover);
    const seen = minimal.get(shape);
    if (seen) {
      seen.count++;
      seen.from.push(i);
      if (size(cur) < size(seen.g)) seen.g = cur;
    } else minimal.set(shape, { g: cur, count: 1, from: [i] });
  }

  let k = 0;
  for (const [shape, { g, count, from }] of minimal) {
    const { c, res } = await check(g);
    const probes = resolveProbes(c, s.cover);
    const failingProbes = new Map<string, Probe & { props: string[] }>();
    for (const o of res.orders) {
      for (const d of o.diffs) {
        const p = probes[d.index]!;
        const key = JSON.stringify([p.el, p.viewport, p.state]);
        const entry = failingProbes.get(key) ?? {
          el: p.el,
          viewport: p.viewport,
          ...(p.state.length > 0 ? { state: p.state } : {}),
          props: [],
        };
        const prop = d.prop.replace(/^::(before|after) /, "");
        if (!entry.props.includes(prop)) entry.props.push(prop);
        failingProbes.set(key, entry);
      }
    }
    const kept = [...failingProbes.values()].slice(0, 1).map((p) =>
      p.viewport && p.viewport.width === defaultViewport.width && p.viewport.height === defaultViewport.height
        ? { ...p, viewport: undefined }
        : p,
    );
    const out = toCase(g, `gen-${seed}-${++k}`, kept.map((p) => JSON.parse(JSON.stringify(p)) as Probe));
    out.title = shape;
    out.why = `--generate ${n} --seed ${seed}: smallest shrunk case of ${count} with this shape (generated cases ${from.join(", ")})`;
    const firstFail = res.orders.find((o) => o.diffs.length > 0)!;
    const d = firstFail.diffs[0]!;
    console.log(`\n// ${count}x ${shape}\n// ${firstFail.label}: ${d.probe} ${d.prop}: cx ${d.oracle}, model ${d.candidate}`);
    console.log(compact(out, "") + ",");
  }
  return failures.length > 0 ? 1 : 0;
}
