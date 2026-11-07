import { existsSync } from "node:fs";
import type { Case, El } from "../src/case.ts";
import { casesDir, loadCases } from "../src/load.ts";
import { selftestCases } from "./_selftest.ts";
import { CandidateError, makePpx } from "./candidate.ts";

const args = process.argv.slice(2);
const envIndex = args.indexOf("--env");
const env = envIndex >= 0 ? args.splice(envIndex, 2)[1] : "production";
const id = args[0];
if (!id || (env !== "production" && env !== "development")) {
  console.error("usage: node --experimental-strip-types pipeline/render.ts <case-id> [--env production|development]");
  process.exit(2);
}

const all: Case[] = [...selftestCases, ...(existsSync(casesDir) ? await loadCases() : [])];
const c = all.find((x) => x.id === id);
if (!c) {
  console.error(`no case ${id}`);
  process.exit(2);
}

const flatten = (tree: El[]): El[] => tree.flatMap((el) => [el, ...flatten(el.children ?? [])]);
const ppx = makePpx({ env });
try {
  const { css, html } = await ppx.render(c, Object.fromEntries(flatten(c.tree).map((el) => [el.id, el.merge])));
  console.log(`${css}\n${html}`);
} catch (e) {
  if (!(e instanceof CandidateError)) throw e;
  console.log(`${e.kind} failure:\n${e.message}`);
  if (e.rendered) console.log(`${e.rendered.css}\n${e.rendered.html}`);
  process.exitCode = 1;
} finally {
  await ppx.close();
}
