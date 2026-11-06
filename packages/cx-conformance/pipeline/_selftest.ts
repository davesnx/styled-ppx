import assert from "node:assert/strict";
import { fileURLToPath } from "node:url";
import type { Case } from "../src/case.ts";
import { CandidateError, makePpx } from "./candidate.ts";

const base = { why: "pipeline self test", probes: [] };

export const selftestCases: Case[] = [
  {
    ...base,
    id: "selftest-static",
    title: "two static blocks merged",
    blocks: { a: "color: red;", b: "color: blue; display: block;" },
    tree: [{ id: "x", merge: ["a", "b"] }],
  },
  {
    ...base,
    id: "selftest-var",
    title: "interpolated value becomes a custom property on style",
    blocks: { a: "color: $(tone);", b: "padding: 4px;" },
    vars: { tone: { css: "#00f", reason: "CSS.blue" } },
    tree: [{ id: "x", dir: "rtl", merge: ["b", "a"], children: [{ id: "y", tag: "span", merge: ["b"] }] }],
  },
  {
    ...base,
    id: "selftest-ref",
    title: "selector reference to another binding",
    blocks: { b: "color: blue; .$(a) & { color: green; }", a: "margin: 0;" },
    tree: [{ id: "p", merge: ["a"], children: [{ id: "c", merge: ["b"] }] }, { id: "none", merge: [] }],
  },
  {
    ...base,
    id: "selftest-twice",
    title: "the same interpolated block merged twice repeats the custom property natively",
    blocks: { a: "color: $(tone);" },
    vars: { tone: { css: "#00f", reason: "CSS.blue" } },
    tree: [{ id: "x", merge: ["a", "a"] }],
  },
  {
    ...base,
    id: "selftest-broken",
    title: "unknown property fails to compile",
    blocks: { a: "colr: red;" },
    tree: [{ id: "x", merge: ["a"] }],
  },
];

async function main(): Promise<void> {
  const env = process.argv.includes("--development") ? "development" : "production";
  const ppx = makePpx({ env });
  await ppx.prepare(selftestCases);
  for (const c of selftestCases) {
    const order = Object.fromEntries(flatten(c.tree).map((el) => [el.id, el.merge]));
    try {
      const { css, html } = await ppx.render(c, order);
      console.log(`== ${c.id}\n${css}\n${html}\n`);
    } catch (e) {
      if (!(e instanceof CandidateError)) throw e;
      console.log(`== ${c.id}: ${e.kind} failure\n${e.message}\n${e.rendered ? `${e.rendered.css}\n${e.rendered.html}\n` : ""}`);
    }
  }
  const reversed = await ppx.render(selftestCases[0]!, { x: ["b", "a"] }).catch((e: unknown) => {
    if (e instanceof CandidateError && e.rendered) return e.rendered;
    throw e;
  });
  assert.match(reversed.html, /class="[^"]+"/);
  await assert.rejects(ppx.render(selftestCases[4]!, { x: ["a"] }), (e) => e instanceof CandidateError && e.kind === "compile");
  await assert.rejects(ppx.render(selftestCases[3]!, { x: ["a", "a"] }), (e) => e instanceof CandidateError && e.kind === "hydration");
  await ppx.close();
}

function flatten(tree: Case["tree"]): Case["tree"] {
  return tree.flatMap((el) => [el, ...flatten(el.children ?? [])]);
}

if (process.argv[1] === fileURLToPath(import.meta.url)) await main();
