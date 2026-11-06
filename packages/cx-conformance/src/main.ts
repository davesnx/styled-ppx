import { existsSync } from "node:fs";
import { parseArgs } from "node:util";
import type { Candidate, Case } from "./case.ts";
import { launch } from "./browser.ts";
import { mainConcat } from "./candidates/main-concat.ts";
import { makeModel, modelOptions } from "./candidates/model.ts";
import { coverOf, loadCoverage, type Cover } from "./coverage.ts";
import { declaredProps } from "./css.ts";
import { generate, generatorProps } from "./generate.ts";
import { globToRegExp, loadCases } from "./load.ts";
import { Prober } from "./probe.ts";
import { priorCases } from "./prior.ts";
import { summaryLine, writeReport } from "./report.ts";
import { selfTest, variants } from "./selftest.ts";
import { runCase, unexpected, type Suite } from "./suite.ts";

const usage = `usage: node --experimental-strip-types src/main.ts [options]
  --candidate <names>   comma list: model, main-concat, ppx, ${variants.map((v) => v.name).join(", ")} (default: model)
  --filter <glob>       case ids to run, comma list of globs with * and ?
  --prior               run the 37 prior cases from src/prior.ts instead of cases/
  --report              write report/<candidate>.md and report/<candidate>.json
  --cap <n>             max orders per case (default 64; deterministic sample above)
  --jobs <n>            browser pages in parallel (default 8)
  --generate <n>        property-based run: n random cases, model vs cx, shrink failures
  --seed <s>            generator seed (default 1)
  --self-test           check that broken model variants fail the prior cases they must fail
  --refresh-coverage    derive coverage.json again in Chromium`;

const { values: args } = parseArgs({
  options: {
    candidate: { type: "string", default: "model" },
    filter: { type: "string" },
    prior: { type: "boolean", default: false },
    report: { type: "boolean", default: false },
    cap: { type: "string", default: "64" },
    jobs: { type: "string", default: "8" },
    generate: { type: "string" },
    seed: { type: "string", default: "1" },
    "self-test": { type: "boolean", default: false },
    "refresh-coverage": { type: "boolean", default: false },
    help: { type: "boolean", default: false },
  },
});

if (args.help) {
  console.log(usage);
  process.exit(0);
}

const int = (name: string, s: string): number => {
  const n = Number(s);
  if (!Number.isInteger(n) || n < 0) throw new Error(`--${name}: expected a non-negative integer, got ${s}`);
  return n;
};

async function loadPpx(): Promise<Candidate | undefined> {
  const file = new URL("../pipeline/candidate.ts", import.meta.url);
  if (!existsSync(file)) return undefined;
  const mod = (await import(file.href)) as { candidate?: Candidate };
  if (!mod.candidate) throw new Error("pipeline/candidate.ts does not export `candidate: Candidate`");
  return mod.candidate;
}

async function candidateByName(name: string, cover: Cover): Promise<Candidate | undefined> {
  if (name === "model") return makeModel(modelOptions(cover));
  if (name === "main-concat") return mainConcat(cover);
  if (name === "ppx") return loadPpx();
  const v = variants.find((x) => x.name === name);
  if (v) return makeModel(v.options(cover));
  throw new Error(`unknown candidate ${name}\n${usage}`);
}

const pinned = (name: string) => name === "model" || name === "ppx";

async function main(): Promise<number> {
  const started = Date.now();
  const browser = await launch();
  try {
    const mode = args["self-test"] ? "self-test" : args.generate !== undefined ? "generate" : "suite";
    let cases: Case[] = mode === "suite" && !args.prior ? await loadCases() : priorCases;
    const used = mode === "generate" ? generatorProps : cases.flatMap(declaredProps);
    const cover = coverOf(await loadCoverage(browser, args["refresh-coverage"], used));
    const prober = await Prober.open(browser, int("jobs", args.jobs));
    const suite: Suite = { prober, cover, cap: int("cap", args.cap), oracle: new Map() };

    if (mode === "self-test") return await selfTest(suite);
    if (mode === "generate") return await generate(suite, int("generate", args.generate!), int("seed", args.seed));

    if (args.filter) {
      const re = globToRegExp(args.filter);
      cases = cases.filter((c) => re.test(c.id));
    }
    if (cases.length === 0) {
      console.error("no cases selected");
      return 1;
    }
    let bad = 0;
    for (const name of args.candidate.split(",")) {
      const candidate = await candidateByName(name, cover);
      if (!candidate) {
        console.log(`${name}: pipeline/candidate.ts not present, skipped`);
        continue;
      }
      const t0 = Date.now();
      const lifecycle = candidate as Candidate & { prepare?: (cs: Case[]) => Promise<void>; close?: () => Promise<void> };
      await lifecycle.prepare?.(cases);
      const results = await Promise.all(cases.map((c) => runCase(suite, c, candidate, pinned(name))));
      await lifecycle.close?.();
      console.log(`${summaryLine(name, results)} (${((Date.now() - t0) / 1000).toFixed(1)}s)`);
      for (const r of results.filter((r) => unexpected.has(r.status))) {
        bad++;
        const o = r.orders.find((o) => o.error || o.diffs.length > 0);
        const d = o?.diffs[0];
        const detail = o?.error ?? (d ? `${d.probe} ${d.prop}: cx ${d.oracle}, got ${d.candidate}` : "");
        console.log(`  ${r.status.toUpperCase()} ${r.id}: ${r.title}${o ? ` [${o.label}] ${detail}` : ""}`);
      }
      if (args.report) for (const f of writeReport(name, results)) console.log(`  wrote ${f}`);
    }
    console.log(`total ${((Date.now() - started) / 1000).toFixed(1)}s`);
    return bad > 0 ? 1 : 0;
  } finally {
    await browser.close();
  }
}

main().then(
  (code) => process.exit(code),
  (e: unknown) => {
    console.error(e instanceof Error ? e.message : e);
    process.exit(2);
  },
);
