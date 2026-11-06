import type { Case } from "./case.ts";
import { elements } from "./css.ts";

export type Rng = () => number;

export function rng(seed: number): Rng {
  let s = seed >>> 0;
  return () => {
    s = (s + 0x6d2b79f5) >>> 0;
    let t = s;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

export function seedOf(text: string): number {
  let h = 2166136261;
  for (let i = 0; i < text.length; i++) h = Math.imul(h ^ text.charCodeAt(i), 16777619);
  return h >>> 0;
}

function permutations(xs: string[]): string[][] {
  if (xs.length <= 1) return [xs];
  const seen = new Set<string>();
  const out: string[][] = [];
  xs.forEach((x, i) => {
    for (const rest of permutations([...xs.slice(0, i), ...xs.slice(i + 1)])) {
      const p = [x, ...rest];
      const key = JSON.stringify(p);
      if (!seen.has(key)) {
        seen.add(key);
        out.push(p);
      }
    }
  });
  return out;
}

export type CaseOrder = { label: string; order: Record<string, string[]> };

export type Expanded = { orders: CaseOrder[]; total: number };

export function labelOf(order: Record<string, string[]>): string {
  return Object.entries(order)
    .map(([id, m]) => `${id}=${m.join("+")}`)
    .join(" ");
}

export function expandOrders(c: Case, cap: number): Expanded {
  const els = elements(c.tree);
  const asWritten = Object.fromEntries(els.map((el) => [el.id, el.merge]));
  if (c.orders === "as-written") return { orders: [{ label: labelOf(asWritten), order: asWritten }], total: 1 };
  const choices = els.map((el) => (el.merge.length >= 2 ? permutations(el.merge) : [el.merge]));
  const total = choices.reduce((n, ch) => n * ch.length, 1);
  const at = (index: number): Record<string, string[]> => {
    const order: Record<string, string[]> = {};
    let rest = index;
    els.forEach((el, i) => {
      const ch = choices[i]!;
      order[el.id] = ch[rest % ch.length]!;
      rest = Math.floor(rest / ch.length);
    });
    return order;
  };
  let indices: number[];
  if (total <= cap) {
    indices = [...Array(total).keys()];
  } else {
    const pick = rng(seedOf(c.id));
    const set = new Set<number>([0]);
    while (set.size < cap) set.add(Math.floor(pick() * total));
    indices = [...set].sort((a, b) => a - b);
  }
  return { orders: indices.map((i) => ({ label: labelOf(at(i)), order: at(i) })), total };
}
