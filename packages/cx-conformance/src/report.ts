import { mkdirSync, writeFileSync } from "node:fs";
import type { CaseResult, Status } from "./suite.ts";

export const reportDir = new URL("../report/", import.meta.url);

const statuses: Status[] = ["pass", "fail", "known-fail", "now-passing", "error"];

export function counts(results: CaseResult[]): Record<Status, number> {
  const out = Object.fromEntries(statuses.map((s) => [s, 0])) as Record<Status, number>;
  for (const r of results) out[r.status]++;
  return out;
}

export function summaryLine(candidate: string, results: CaseResult[]): string {
  const n = counts(results);
  const orders = results.reduce((k, r) => k + r.orders.length, 0);
  return `${candidate}: ${results.length} cases, ${orders} case-orders: ` + statuses.map((s) => `${n[s]} ${s}`).join(", ");
}

const cell = (s: string) => s.replace(/\|/g, "\\|").replace(/\n/g, " ");

function firstDiff(r: CaseResult): string {
  for (const o of r.orders) {
    if (o.error) return `${o.label}: ${o.error}`;
    const d = o.diffs[0];
    if (d) return `${o.label}: ${d.probe} ${d.prop}: cx \`${d.oracle}\`, got \`${d.candidate}\``;
  }
  return "";
}

export function writeReport(candidate: string, results: CaseResult[]): string[] {
  mkdirSync(reportDir, { recursive: true });
  const rows = results.map((r) => {
    const failing = r.orders.filter((o) => o.error || o.diffs.length > 0).length;
    const sampled = r.total > r.orders.length ? ` (sampled from ${r.total})` : "";
    const pin = r.expect.kind === "known-fail" ? r.expect.reason + (r.expect.issue ? ` (${r.expect.issue})` : "") : "";
    return `| ${cell(r.id)} | ${cell(r.title)} | ${r.status} | ${failing}/${r.orders.length}${sampled} | ${cell(firstDiff(r))} | ${cell(pin)} |`;
  });
  const md = [
    `# cx conformance: ${candidate}`,
    "",
    summaryLine(candidate, results),
    "",
    "Oracle: `@emotion/css` 11.13.5 `cx`, computed styles in headless Chromium.",
    "Statuses `fail`, `now-passing` and `error` are unexpected.",
    "",
    "| Case | Title | Status | Failing orders | First difference | Pin |",
    "|---|---|---|---|---|---|",
    ...rows,
    "",
  ].join("\n");
  const json = {
    candidate,
    counts: counts(results),
    cases: results.map((r) => ({
      id: r.id,
      title: r.title,
      status: r.status,
      expect: r.expect,
      orders: r.orders.length,
      totalOrders: r.total,
      diffs: r.orders.flatMap((o) => [
        ...(o.error ? [{ order: o.label, error: o.error }] : []),
        ...o.diffs.map((d) => ({ order: o.label, ...d })),
      ]),
    })),
  };
  const mdPath = new URL(`${candidate}.md`, reportDir);
  const jsonPath = new URL(`${candidate}.json`, reportDir);
  writeFileSync(mdPath, md);
  writeFileSync(jsonPath, JSON.stringify(json, null, 1) + "\n");
  return [mdPath.pathname, jsonPath.pathname];
}
