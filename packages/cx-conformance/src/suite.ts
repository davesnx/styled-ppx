import type { Candidate, Case, Expect } from "./case.ts";
import type { Cover } from "./coverage.ts";
import { emotion } from "./candidates/emotion.ts";
import { expandOrders, type CaseOrder } from "./orders.ts";
import { compare, resolveProbes, type Diff, type Prober, type Reading } from "./probe.ts";

export type Status = "pass" | "fail" | "known-fail" | "now-passing" | "error";

export const unexpected: ReadonlySet<Status> = new Set(["fail", "now-passing", "error"]);

export type OrderResult = { label: string; diffs: Diff[]; error?: string };

export type CaseResult = {
  id: string;
  title: string;
  expect: Expect;
  status: Status;
  total: number;
  orders: OrderResult[];
};

export type Suite = {
  prober: Prober;
  cover: Cover;
  cap: number;
  oracle: Map<string, Promise<Reading>>;
};

const message = (e: unknown) => (e instanceof Error ? e.message : String(e));
const kindOf = (e: unknown) =>
  typeof e === "object" && e !== null && "kind" in e && typeof e.kind === "string" ? e.kind : "error";

function oracleReading(s: Suite, c: Case, o: CaseOrder): Promise<Reading> {
  const key = `${c.id}\u0000${o.label}`;
  let reading = s.oracle.get(key);
  if (!reading) {
    const probes = resolveProbes(c, s.cover);
    reading = emotion.render(c, o.order).then((r) => s.prober.read(r, probes));
    s.oracle.set(key, reading);
  }
  return reading;
}

export async function runCase(s: Suite, c: Case, candidate: Candidate, pinned: boolean): Promise<CaseResult> {
  const probes = resolveProbes(c, s.cover);
  const { orders, total } = expandOrders(c, s.cap);
  let oracleError: string | undefined;
  const results = await Promise.all(
    orders.map(async (o): Promise<OrderResult> => {
      let oracle: Reading;
      try {
        oracle = await oracleReading(s, c, o);
      } catch (e) {
        oracleError = `oracle: ${message(e)}`;
        return { label: o.label, diffs: [], error: oracleError };
      }
      try {
        const reading = await s.prober.read(await candidate.render(c, o.order), probes);
        return { label: o.label, diffs: compare(probes, oracle, reading) };
      } catch (e) {
        return { label: o.label, diffs: [], error: `${candidate.name} ${kindOf(e)}: ${message(e)}` };
      }
    }),
  );
  const expect: Expect = pinned ? (c.expect ?? { kind: "pass" }) : { kind: "pass" };
  const failed = results.some((r) => r.diffs.length > 0 || r.error);
  const status: Status = oracleError
    ? "error"
    : expect.kind === "pass"
      ? failed ? "fail" : "pass"
      : failed ? "known-fail" : "now-passing";
  return { id: c.id, title: c.title, expect, status, total, orders: results };
}
