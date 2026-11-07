import type { Case } from "../src/case.ts";
import { M1, merge } from "./lib/build.ts";

const c = { css: "red", reason: "CSS.red" };
const p = { css: "7px", reason: "`px(7)" };
const why = (s: string) =>
  `${s} The merged carrier holds the same inline var key twice. Native server-reason-react appends (two entries in the style attribute), Melange Object.assign keeps one: the class strings match, the style strings do not (hydration-duplicate-style-rootcause.md). They pass \`ppx\` with the pinned server-reason-react, whose combine keeps one entry; a hydration failure here means the duplicate is back.`;

const all: Case[] = [
  { ...merge("hydration-01", "one interpolated block merged twice", { a: "color:$(c);" }, ["color"], { why: why("merge(a, a)."), vars: { c } }), tree: [{ id: "x", merge: ["a", "a"] }] },
  merge("hydration-02", "two blocks with the same interpolated atom", ["color:$(c);", "color:$(c);padding:1px;"], ["color", "padding-top"], {
    why: why("Two bindings write the same atom text, so they share one var name."),
    vars: { c },
  }),
  { ...merge("hydration-03", "a +++ b +++ a with an interpolation", { a: "padding:$(p);", b: "color:blue;" }, ["padding-top", "color"], { why: why("The repeated operand sets the var again."), vars: { p } }), tree: [{ id: "x", merge: ["a", "b", "a"] }] },
  merge("hydration-04", "same interpolation in base and in a condition of two blocks", [`color:$(c);${M1}{color:$(c);}`, `${M1}{color:$(c);}`], ["color"], {
    why: why("The conditional atom text is the same in both blocks."),
    vars: { c },
  }),
  { ...merge("hydration-05", "three copies of one block among others", { a: "margin:$(p);", b: "margin-top:0;", d: "color:blue;" }, ["margin-top", "margin-left", "color"], { why: why("Long chain with the same interpolated block three times."), vars: { p }, orders: "as-written" }), tree: [{ id: "x", merge: ["a", "b", "a", "d", "a"] }] },
];

export const cases: Case[] = all;
