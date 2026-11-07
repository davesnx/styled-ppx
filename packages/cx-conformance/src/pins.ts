import { existsSync, readFileSync, writeFileSync } from "node:fs";
import type { Case } from "./case.ts";
import type { CaseResult, OrderResult } from "./suite.ts";

export const pinsPath = new URL("../pins.json", import.meta.url);

export type PinnedName = "model" | "ppx";
export type Pin = string[] | Record<PinnedName, string[]>;
export type Pins = Record<string, Pin>;

export const isPinned = (name: string): name is PinnedName => name === "model" || name === "ppx";

export const diffLines = (orders: OrderResult[]): string[] =>
  orders.flatMap((o) => [
    ...(o.error ? [`${o.label} | ${o.error}`] : []),
    ...o.diffs.map((d) => `${o.label} | ${d.probe} | ${d.prop}: cx ${d.oracle}, got ${d.candidate}`),
  ]);

export function loadPins(cases: Case[]): Pins {
  const pins = (existsSync(pinsPath) ? JSON.parse(readFileSync(pinsPath, "utf8")) : {}) as Pins;
  const knownFail = new Set(cases.filter((c) => c.expect?.kind === "known-fail").map((c) => c.id));
  const stale = Object.keys(pins).filter((id) => !knownFail.has(id));
  if (stale.length > 0) throw new Error(`pins.json: ${stale.join(" ")} not pinned known-fail; run --write-pins`);
  return pins;
}

export function checkPin(r: CaseResult, pins: Pins, name: PinnedName): CaseResult {
  if (r.status !== "known-fail") return r;
  const pin = pins[r.id];
  const want = pin === undefined ? undefined : Array.isArray(pin) ? pin : pin[name];
  if (want === undefined) return { ...r, status: "fail", pinMismatch: "no entry in pins.json" };
  const got = diffLines(r.orders);
  if (JSON.stringify(got) === JSON.stringify(want)) return r;
  const extra = got.find((l) => !want.includes(l));
  const missing = want.find((l) => !got.includes(l));
  return {
    ...r,
    status: "fail",
    pinMismatch: extra ? `not in pins.json: ${extra}` : missing ? `in pins.json, not seen: ${missing}` : "same lines as pins.json in another order",
  };
}

export function writePins(lines: Record<PinnedName, Map<string, string[]>>): string {
  const ids = [...new Set([...lines.model.keys(), ...lines.ppx.keys()])].sort();
  const out: Pins = {};
  for (const id of ids) {
    const model = lines.model.get(id) ?? [];
    const ppx = lines.ppx.get(id) ?? [];
    out[id] = JSON.stringify(model) === JSON.stringify(ppx) ? model : { model, ppx };
  }
  writeFileSync(pinsPath, JSON.stringify(out, null, 1) + "\n");
  return pinsPath.pathname;
}
