import type { Case, El, Expect, Probe, PseudoState, Viewport } from "../../src/case.ts";

export const M1 = "@media (min-width:1px)";
export const M2 = "@media (min-width:2px)";

const accepted: Record<string, number> = { "RT-01": 6, "RT-05": 7, "RT-04": 8, "RT-06": 9, "decision-14": 14 };

export const knownFail = (issue: string, reason: string): Expect => ({
  kind: "known-fail",
  issue,
  reason: accepted[issue] ? `accepted 2026-11-06 (decision ${accepted[issue]}): ${reason}` : reason,
});

export type Opts = {
  why: string;
  source?: string;
  vars?: Case["vars"];
  dir?: "ltr" | "rtl";
  tag?: string;
  orders?: Case["orders"];
  expect?: Expect;
  viewports?: Viewport[];
  states?: PseudoState[][];
  wrap?: string[];
  children?: El[];
  probe?: string;
  use?: string[];
};

const names = (blocks: string[] | Record<string, string>): Record<string, string> =>
  Array.isArray(blocks) ? Object.fromEntries(blocks.map((b, i) => ["abcdefghijklmnop"[i]!, b])) : blocks;

export function probesFor(el: string, props: string[] | undefined, o: Pick<Opts, "viewports" | "states">): Probe[] {
  const viewports: (Viewport | undefined)[] = o.viewports ?? [undefined];
  const states: (PseudoState[] | undefined)[] = o.states ?? [undefined];
  return viewports.flatMap((viewport) =>
    states.map((state) => ({
      el,
      ...(props ? { props } : {}),
      ...(viewport ? { viewport } : {}),
      ...(state ? { state } : {}),
    })),
  );
}

export function merge(
  id: string,
  title: string,
  blocks: string[] | Record<string, string>,
  props: string[] | undefined,
  o: Opts,
): Case {
  const b = names(blocks);
  const own = o.use ?? Object.keys(b).filter((k) => !(o.wrap ?? []).includes(k));
  const target: El = {
    id: "x",
    merge: own,
    ...(o.tag ? { tag: o.tag } : {}),
    ...(o.dir ? { dir: o.dir } : {}),
    ...(o.children ? { children: o.children } : {}),
  };
  const tree: El[] = o.wrap ? [{ id: "w", merge: o.wrap, children: [target] }] : [target];
  return {
    id,
    title,
    why: o.why,
    ...(o.source ? { source: o.source } : {}),
    blocks: b,
    ...(o.vars ? { vars: o.vars } : {}),
    tree,
    probes: probesFor(o.probe ?? "x", props, o),
    ...(o.orders ? { orders: o.orders } : {}),
    ...(o.expect ? { expect: o.expect } : {}),
  };
}

export const vp = (width: number, height = 800): Viewport => ({ width, height });
