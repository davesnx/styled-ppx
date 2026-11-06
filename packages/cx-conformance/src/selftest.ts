import type { Candidate, Case } from "./case.ts";
import { emotion } from "./candidates/emotion.ts";
import { makeModel, modelOptions, type ModelOptions } from "./candidates/model.ts";
import type { Cover } from "./coverage.ts";
import { priorCases } from "./prior.ts";
import { defaultViewport } from "./probe.ts";
import { runCase, unexpected, type Suite } from "./suite.ts";

const fontResetOnly = new Set([
  "font-kerning", "font-feature-settings", "font-variation-settings", "font-language-override",
  "font-size-adjust", "font-optical-sizing", "font-variant-ligatures", "font-variant-numeric",
  "font-variant-east-asian", "font-variant-alternates", "font-variant-position", "font-variant-emoji",
]);

const withoutResetOnly = (cover: Cover): Cover => (prop) => {
  if (prop === "font") return cover(prop).filter((l) => !fontResetOnly.has(l));
  if (prop === "border") return cover(prop).filter((l) => !l.startsWith("border-image-"));
  return cover(prop);
};

export type Variant = {
  name: string;
  options: (cover: Cover) => ModelOptions;
  mustFail: string[];
};

export const variants: Variant[] = [
  {
    name: "model-no-cover",
    options: (cover) => ({ ...modelOptions(cover), name: "model-no-cover", dropBy: "same-property" }),
    mustFail: ["T02", "T03"],
  },
  {
    name: "model-cross-context",
    options: (cover) => ({ ...modelOptions(cover), name: "model-cross-context", dropAcrossContexts: true }),
    mustFail: ["T26", "T28", "T37"],
  },
  {
    name: "model-no-tiers",
    options: (cover) => ({ ...modelOptions(cover), name: "model-no-tiers", tiers: false }),
    mustFail: ["T03", "T26", "T37"],
  },
  {
    name: "model-no-reset-only",
    options: (cover) => ({ ...modelOptions(withoutResetOnly(cover)), name: "model-no-reset-only" }),
    mustFail: ["T09", "T10"],
  },
];

async function failing(suite: Suite, candidate: Candidate, pinned: boolean): Promise<{ failed: string[]; bad: string[] }> {
  const results = await Promise.all(priorCases.map((c) => runCase(suite, c, candidate, pinned)));
  return {
    failed: results.filter((r) => r.status === "fail" || r.status === "known-fail").map((r) => r.id),
    bad: results.filter((r) => unexpected.has(r.status)).map((r) => `${r.id} (${r.status})`),
  };
}

const roleCase: Case = {
  id: "rt12",
  title: "child sets the variable the parent's descendant rule reads",
  why: "RT-12",
  blocks: { p: "& > *{margin-top:$(g);}", x: "padding-top:$(g);" },
  vars: { g: { css: "8px", reason: "parent value" } },
  tree: [{ id: "pe", merge: ["p"], children: [{ id: "ce", merge: ["x"] }] }],
  probes: [{ el: "ce" }],
};

async function varRoles(suite: Suite, mode: "roles" | "one-name"): Promise<{ margin: string; padding: string }> {
  const rendered = await makeModel({ ...modelOptions(suite.cover), vars: mode }).render(roleCase, {});
  const html = rendered.html.replace(/(id="ce"[^>]*style=")(--cxv-g(?:-d)?):8px/, "$1$2:99px");
  const [reading] = await suite.prober.read({ css: rendered.css, html }, [
    { el: "ce", viewport: defaultViewport, state: [], props: ["margin-top", "padding-top"], pseudos: [] },
  ]);
  return { margin: reading!["margin-top"]!, padding: reading!["padding-top"]! };
}

export async function selfTest(suite: Suite): Promise<number> {
  let ok = true;
  const check = (pass: boolean, line: string) => {
    ok &&= pass;
    console.log(`${pass ? "ok  " : "FAIL"} ${line}`);
  };

  const oracle = await failing(suite, emotion, false);
  check(oracle.bad.length === 0, `emotion vs emotion: ${oracle.bad.length} differences ${oracle.bad.join(" ")}`);

  const model = await failing(suite, makeModel(modelOptions(suite.cover)), true);
  check(model.bad.length === 0, `model on prior cases: unexpected ${model.bad.join(" ") || "none"}; known-fail ${model.failed.join(" ")}`);

  for (const v of variants) {
    const r = await failing(suite, makeModel(v.options(suite.cover)), false);
    const missed = v.mustFail.filter((id) => !r.failed.includes(id));
    const extra = r.failed.filter((id) => !model.failed.includes(id) && !v.mustFail.includes(id));
    check(
      missed.length === 0,
      `${v.name}: must fail ${v.mustFail.join(" ")}; ` +
        (missed.length > 0 ? `NOT DETECTED ${missed.join(" ")}` : "detected") +
        (extra.length > 0 ? `; also fails ${extra.join(" ")}` : ""),
    );
  }

  const roles = await varRoles(suite, "roles");
  check(
    roles.margin === "8px" && roles.padding === "99px",
    `var roles: child sets its own value 99px; parent's \`& > *\` rule reads margin-top ${roles.margin} (want 8px), child padding-top ${roles.padding} (want 99px)`,
  );
  const oneName = await varRoles(suite, "one-name");
  check(oneName.margin !== "8px", `one var name per property (no roles): margin-top ${oneName.margin}, must differ from 8px`);
  return ok ? 0 : 1;
}
