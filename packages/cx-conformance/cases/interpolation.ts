import type { Case } from "../src/case.ts";
import { M1, merge } from "./lib/build.ts";

const c = { css: "red", reason: "CSS.red" };
const p = { css: "7px", reason: "`px(7)" };

const all: Case[] = [
  merge("interpolation-01", "interpolated color vs static color", ["color:$(c);", "color:blue;"], ["color"], {
    why: "An interpolated atom has the same key as a static one.",
    vars: { c },
  }),
  merge("interpolation-02", "interpolated shorthand then longhand", ["padding:$(p);", "padding-top:0;"], ["padding-top", "padding-left"], {
    why: "Cover does not need the value.",
    vars: { p },
  }),
  merge("interpolation-03", "bundle split: one interpolation in base, hover and @media", [`color:$(c); &:hover{color:$(c);} ${M1}{color:$(c);}`, "color:blue;"], ["color"], {
    why: "Today the three rules share one bundle class. After the split, b drops only the base atom; hover and @media stay.",
    vars: { c },
    states: [[], ["hover"]],
  }),
  merge("interpolation-04", "bundle split: interpolated hover shorthand vs hover longhand", ["padding:$(p); &:hover{padding:$(p);}", "&:hover{padding-top:0;}"], ["padding-top", "padding-left"], {
    why: "Per-atom keys inside a former bundle.",
    vars: { p },
    states: [[], ["hover"]],
  }),
  merge("interpolation-05", "bundle split: two properties, one overridden", ["color:$(c); padding:$(p);", "padding:1px;"], ["color", "padding-top"], {
    why: "The split must keep the color atom and its variable when padding is dropped.",
    vars: { c, p },
  }),
  merge("interpolation-06", "one variable read by two operands", ["color:$(c);", "background-color:$(c);"], ["color", "background-color"], {
    why: "Two atoms read the same source name; each gets its own variable.",
    vars: { c },
  }),
  merge("interpolation-07", "the same atom text in two operands", ["color:$(c);", "color:$(c);"], ["color"], {
    why: "Identical atoms: one class, two copies of the variable; the last wins.",
    vars: { c },
  }),
  merge("interpolation-08", "interpolation used twice in one declaration", ["margin:$(p) $(p);", "margin-left:0;"], ["margin-top", "margin-left"], {
    why: "Occurrence-suffixed variables.",
    vars: { p },
  }),
  merge("interpolation-09", "interpolated value is a CSS-wide keyword", { w: "color:green;", a: "color:$(k);", b: "color:blue;" }, ["color"], {
    why: "The variable holds `inherit`.",
    vars: { k: { css: "inherit", reason: "`inherit_" } },
    wrap: ["w"],
  }),
  merge("interpolation-10", "var() fallback vs static", ["color:var(--undefined-k, green);", "color:red;"], ["color"], {
    why: "A fallback inside a static value.",
  }),
  merge("interpolation-11", "custom property set twice, read by a third", ["--k:red;", "--k:blue;", "color:var(--k);"], ["color"], {
    why: "Custom properties are keys like any other.",
  }),
  merge("interpolation-12", "custom property names are case-sensitive", ["--k:red;", "--K:blue;", "color:var(--k);"], ["color"], {
    why: "`--k` and `--K` are two properties; the merge must not drop `--k`.",
  }),
  {
    id: "interpolation-13",
    title: "custom property set on the parent, read by the child",
    why: "Merge on the parent decides which value the child inherits.",
    blocks: { a: "--k:red;", b: "--k:blue;", r: "color:var(--k);" },
    tree: [{ id: "p", merge: ["a", "b"], children: [{ id: "x", merge: ["r"] }] }],
    probes: [{ el: "x", props: ["color"] }],
  },
  merge("interpolation-14", "interpolated custom property vs static", ["--k:$(k);", "--k:blue;", "color:var(--k);"], ["color"], {
    why: "An interpolated custom property (the ppx types `$(x)` in a custom property as string).",
    vars: { k: { css: "red", reason: "\"red\"" } },
  }),
  merge("interpolation-15", "custom property in @media vs base", [`${M1}{--k:red;}`, "--k:blue;", "color:var(--k);"], ["color"], {
    why: "Conditional custom property beats base in both orders.",
  }),
  merge("interpolation-16", "interpolation in a selector list", ["&:hover, &:focus{color:$(c);}", "&:focus{color:blue;}"], ["color"], {
    why: "A split selector list keeps per-atom variables.",
    vars: { c },
    states: [["hover"], ["focus"]],
  }),
  {
    id: "interpolation-17",
    title: "interpolation in a descendant scope vs the child's own atom",
    why: "Decision 3 with a variable: the parent sets the variable inline, the child reads it through the parent's rule.",
    blocks: { p: "& > *{color:$(c);}", x: "color:blue;" },
    vars: { c },
    tree: [{ id: "pe", merge: ["p"], children: [{ id: "x", merge: ["x"] }, { id: "y", merge: [] }] }],
    probes: [{ el: "x", props: ["color"] }, { el: "y", props: ["color"] }],
  },
  merge("interpolation-18", "interpolated shorthand partially overridden in a condition", ["padding:$(p);", `${M1}{padding-left:0;}`], ["padding-left", "padding-top"], {
    why: "The conditional longhand wins in both orders.",
    vars: { p },
  }),
];

export const cases: Case[] = all;
