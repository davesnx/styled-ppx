import type { Case } from "../src/case.ts";
import { M1, knownFail } from "./lib/build.ts";

const source = "property-class-codebase.md section F";
const own = (what: string) =>
  knownFail(
    "decision-14",
    `${what}: the block carries the same class on parent and child, so cx prints the parent's descendant rule after the child's own declaration and the descendant rule wins the tie; the design keeps decision 3 (the child's own atom wins)`,
  );

const nested = (id: string, title: string, why: string, block: string, probes: Case["probes"], extra: Partial<Case> = {}, depth = 2): Case => ({
  id,
  title,
  why,
  source,
  blocks: { r: block },
  tree: [
    {
      id: "p",
      merge: ["r"],
      children: [{ id: "c", merge: ["r"], ...(depth > 2 ? { children: [{ id: "g", merge: ["r"] }] } : {}) }],
    },
  ],
  probes,
  ...extra,
});

const all: Case[] = [
  nested(
    "recursive-01",
    "one block with own margin-top and `& > *` margin-top, nested in itself",
    "Shape F.1: own `p` and a child `p` in one block, tie on specificity (0,1,0); the component renders inside itself.",
    "margin-top:4px; & > *{margin-top:0;}",
    [{ el: "c", props: ["margin-top"] }],
    { expect: own("`& > *` against the own declaration") },
  ),
  nested(
    "recursive-02",
    "own margin-top and `& *` descendant rule, three levels",
    "`& *` is (0,1,0) and ties with the own class; the grandchild matches the rule of both ancestors.",
    "margin-top:4px; & *{margin-top:0;}",
    [{ el: "c", props: ["margin-top"] }, { el: "g", props: ["margin-top"] }],
    { expect: own("`& *` against the own declaration") },
    3,
  ),
  nested(
    "recursive-03",
    "own declaration and `& :where(div)` rule, nested in itself",
    "`& :where(...)` has zero inner specificity: (0,1,0), a tie with the own class (Discoverable_Css `page`).",
    "margin-top:4px; & :where(div){margin-top:0;}",
    [{ el: "c", props: ["margin-top"] }],
    { expect: own("`& :where(div)` against the own declaration") },
  ),
  nested(
    "recursive-04",
    "own conditional declaration listed before `& > *`, nested in itself",
    "Shape: the child's own atom is conditional, the parent's descendant rule is base. cx prints the media rule and then `& > *` in source order, so `& > *` wins while the media query matches.",
    `${M1}{margin-top:4px;} & > *{margin-top:0;}`,
    [{ el: "c", props: ["margin-top"] }],
    { expect: own("conditional own declaration written before `& > *`") },
  ),
  nested(
    "recursive-05",
    "own conditional declaration listed after `& > *`, nested in itself",
    "The reverse source order: cx prints the media rule last, so the child's own value wins, as in the design.",
    `& > *{margin-top:0;} ${M1}{margin-top:4px;}`,
    [{ el: "c", props: ["margin-top"] }],
  ),
  nested(
    "recursive-06",
    "`& > div` against the own declaration, nested in itself (Tooltip)",
    "`& > div` is (0,1,1) and beats the own class under every design, so there is no tie.",
    "display:block; & > div{display:inline-flex;}",
    [{ el: "c", props: ["display"] }],
  ),
  nested(
    "recursive-07",
    "own declaration equal to the `& > *` value, nested in itself",
    "Same value in both rules (agent-desk minWidth 0 against the reset): the winner does not show.",
    "min-width:0; & > *{min-width:0;}",
    [{ el: "c", props: ["min-width"] }],
  ),
  {
    id: "recursive-08",
    title: "static merge, own min-height in one operand, `& > *` reset in another, inner class created after the outer rule",
    why: "Shape F.2 (Stack): the inner Stack's merged class is inserted after the outer's, so the inner's own `min-height` comes later in the sheet than the outer's `& > *` rule and wins in cx as well. This is emotion's insertion order (RT-16), not a property of cx.",
    source,
    blocks: { grid: "display:grid;", childrenMin: "& > *{min-height:0;}", min400: "min-height:400px;" },
    tree: [{ id: "stack", merge: ["grid", "childrenMin"], children: [{ id: "inner", merge: ["min400", "grid", "childrenMin"] }] }],
    probes: [{ el: "inner", props: ["min-height"] }],
    orders: "as-written",
  },
];

export const cases: Case[] = all;
