import type { Case } from "../src/case.ts";
import { M1, knownFail, merge } from "./lib/build.ts";

const overlap = (what: string) =>
  knownFail("RT-05", `${what}: two different contexts that both match one element, from different operands. cx follows argument order; a fixed sheet order cannot`);
const nestedScope = knownFail("RT-04", "both rules are nested rules in cx, printed in argument order; the design puts the conditional one last in both orders");

const parentChild = (
  id: string,
  title: string,
  why: string,
  parent: Record<string, string>,
  child: Record<string, string>,
  props: string[],
  extra: Partial<Case> & { childTag?: string; state?: Case["probes"][number]["state"] } = {},
): Case => {
  const { childTag, state, ...rest } = extra;
  return {
    id,
    title,
    why,
    blocks: { ...parent, ...child },
    tree: [{ id: "p", merge: Object.keys(parent), children: [{ id: "c", ...(childTag ? { tag: childTag } : {}), merge: Object.keys(child) }] }],
    probes: [{ el: "c", props, ...(state ? { state } : {}) }],
    ...rest,
  };
};

const all: Case[] = [
  merge("selectors-01", "selector list split, single states", ["&:hover, &:focus{color:red;}", "&:hover{color:blue;}"], ["color"], {
    why: "A selector list becomes one atom per selector; the later `&:hover` drops only the hover atom.",
    states: [["hover"], ["focus"]],
  }),
  merge("selectors-02", "selector list split, both states", ["&:hover, &:focus{color:red;}", "&:hover{color:blue;}"], ["color"], {
    why: "Hovered and focused: cx AB gives blue (b's rule is later); the design keeps a's focus atom and b's hover atom, so the sheet decides. Only one order has both atoms, so a sheet that puts b's hover atom after a's focus atom passes.",
    states: [["hover", "focus"]],
  }),
  merge("selectors-03", "explicit & {} vs base declaration", ["& {color:red;}", "color:blue;"], ["color"], {
    why: "cx prints `& {}` as a nested rule after all base declarations, so it wins in both orders. If the ppx folds `& {}` into the plain context, merge AB drops it and blue wins.",
    expect: knownFail("RT-04", "cx treats `& {}` as a nested rule printed after every base declaration; the design folds it into the plain context"),
  }),
  merge("selectors-04", "one block: same nested selector twice", ["&:hover{color:red;} &:hover{color:blue;}"], ["color"], {
    why: "Two nested rules with one key in one block become two atoms with the same key on one element. The ppx must keep only the later (cx: blue).",
    states: [["hover"]],
  }),
  merge("selectors-05", "one block: same @media twice", [`${M1}{color:red;} ${M1}{color:blue;}`], ["color"], {
    why: "Same as above with a condition.",
  }),
  merge("selectors-06", "one block: plain declaration, nested & {}, plain declaration", ["color:red; & {color:green;} color:blue;"], ["color"], {
    why: "stylis prints the base declarations first and the `& {}` rule after them, so green wins.",
  }),
  merge("selectors-07", "pseudo-element height, same key", ['&::before{content:"";display:block;height:10px;}', "&::before{height:20px;}"], ["height"], {
    why: "Pseudo-element atoms merge like any scope. The element's own height comes from its ::before box (probe of a pseudo-element by layout).",
  }),
  merge("selectors-08", "pseudo-element content:none removes the box", ['&::before{content:"";display:block;height:10px;}', "&::before{content:none;}"], ["height"], {
    why: "A later `content:none` drops the earlier content atom.",
  }),
  merge("selectors-09", "::before and ::after add up", ['&::before{content:"";display:block;height:10px;}', '&::after{content:"";display:block;height:5px;}'], ["height"], {
    why: "Different scopes, no conflict.",
  }),
  merge("selectors-10", "::before vs @media ::before", ['&::before{content:"";display:block;height:10px;}', `${M1}{&::before{height:30px;}}`], ["height"], {
    why: "Nested scope with and without a condition: cx uses argument order.",
    expect: nestedScope,
  }),
  merge("selectors-11", "hover::before vs ::before", ['&::before{content:"";display:block;height:10px;}', "&:hover::before{height:20px;}"], ["height"], {
    why: "Specificity decides.",
    states: [["hover"]],
  }),
  {
    id: "selectors-12",
    title: ":nth-child vs :not(:last-child)",
    why: "Two structural pseudo-classes with equal specificity that both match the first of two siblings.",
    blocks: { a: "&:nth-child(1){color:red;}", b: "&:not(:last-child){color:blue;}" },
    tree: [{ id: "p", merge: [], children: [{ id: "x", merge: ["a", "b"] }, { id: "y", merge: [] }] }],
    probes: [{ el: "x", props: ["color"] }],
    expect: overlap(":nth-child vs :not()"),
  },
  merge("selectors-13", ":has() specificity", ["&:has(span){color:red;}", "color:blue;"], ["color"], {
    why: "`:has(span)` adds (0,0,1); it beats the base atom.",
    children: [{ id: "s", tag: "span", merge: [] }],
  }),
  {
    id: "selectors-14",
    title: "ancestor id scope beats base",
    why: "`#outer &` has higher specificity than the base atom.",
    blocks: { a: "#outer &{color:red;}", b: "color:blue;" },
    tree: [{ id: "outer", merge: [], children: [{ id: "x", merge: ["a", "b"] }] }],
    probes: [{ el: "x", props: ["color"] }],
  },
  {
    id: "selectors-15",
    title: "ancestor id scope, same key twice",
    why: "Same context: the later drops the earlier.",
    blocks: { a: "#outer &{color:red;}", b: "#outer &{color:blue;}" },
    tree: [{ id: "outer", merge: [], children: [{ id: "x", merge: ["a", "b"] }] }],
    probes: [{ el: "x", props: ["color"] }],
  },
  {
    id: "selectors-16",
    title: ":where() ancestor scope vs base",
    why: "`*:where(#outer) &` (the `*` keeps stylis from gluing a leading `:` to the parent) has the same specificity as the base atom; cx prints it after base declarations in both orders.",
    blocks: { a: "*:where(#outer) &{color:red;}", b: "color:blue;" },
    tree: [{ id: "outer", merge: [], children: [{ id: "x", merge: ["a", "b"] }] }],
    probes: [{ el: "x", props: ["color"] }],
  },
  {
    id: "selectors-17",
    title: "ancestor scope vs hover, both match",
    why: "A zero-specificity ancestor scope plus :hover has the same specificity as :hover alone; both match, and cx follows argument order.",
    blocks: { a: "*:where(#outer) &:hover{color:red;}", b: "&:hover{color:blue;}" },
    tree: [{ id: "outer", merge: [], children: [{ id: "x", merge: ["a", "b"] }] }],
    probes: [{ el: "x", props: ["color"], state: ["hover"] }],
    expect: overlap("ancestor-scoped hover vs hover"),
  },
  parentChild("selectors-18", "child's own atom beats & > * (decision 3)", "Descendant scopes sit in an earlier tier than own atoms; the child's own atom wins the tie.", { p: "& > *{margin-top:0;}" }, { c: "margin-top:4px;" }, ["margin-top"]),
  parentChild("selectors-19", "& > * + * (Stack spacing) vs child's own margin", "Equal specificity: the child's own atom wins.", { p: "& > * + *{margin-top:8px;}" }, { c: "margin-top:4px;" }, ["margin-top"], {
    tree: [{ id: "p", merge: ["p"], children: [{ id: "c0", merge: [] }, { id: "c", merge: ["c"] }] }],
  }),
  parentChild("selectors-20", "& span beats the child's own atom by specificity", "`.p span` is (0,1,1).", { p: "& span{color:red;}" }, { c: "color:blue;" }, ["color"], { childTag: "span" }),
  parentChild("selectors-21", "conditional descendant vs child's own base atom", "Decision 3 vs decision 1: the parent's `@media{& > *}` atom is conditional, the child's own atom is base. cx (parent rule inserted first) gives the child's atom; so the descendant tier must be outside the condition tier.", { p: `${M1}{& > *{color:red;}}` }, { c: "color:blue;" }, ["color"]),
  parentChild("selectors-22", "descendant base vs child's conditional", "Child's own conditional atom wins.", { p: "& > *{color:red;}" }, { c: `${M1}{color:blue;}` }, ["color"]),
  parentChild("selectors-23", "descendant hover vs child's own hover", "`.p > *:hover` and `.c:hover` tie; the child's own atom wins.", { p: "& > *:hover{color:red;}" }, { c: "&:hover{color:blue;}" }, ["color"], { state: ["hover"] }),
  parentChild("selectors-24", "two parent operands: & span vs & > span", "Two different descendant scopes with equal specificity from two operands of the parent.", { p1: "& span{color:red;}", p2: "& > span{color:blue;}" }, { c: "" }, ["color"], {
    childTag: "span",
    expect: overlap("& span vs & > span"),
  }),
  parentChild("selectors-25", "two parent operands: & > * same key", "Same descendant scope: the later drops the earlier.", { p1: "& > *{margin-top:1px;}", p2: "& > *{margin-top:2px;}" }, { c: "" }, ["margin-top"]),
  parentChild("selectors-26", "two parent operands: & > * shorthand then longhand", "Cover inside a descendant scope.", { p1: "& > *{margin:1px;}", p2: "& > *{margin-top:2px;}" }, { c: "" }, ["margin-top", "margin-left"]),
  {
    id: "selectors-27",
    title: "& + & on siblings with the same single binding",
    why: "Both siblings carry the same class in cx and in the design.",
    blocks: { s: "& + &{margin-top:10px;}" },
    tree: [{ id: "p", merge: [], children: [{ id: "s1", merge: ["s"] }, { id: "s2", merge: ["s"] }] }],
    probes: [{ el: "s2", props: ["margin-top"] }],
  },
  {
    id: "selectors-28",
    title: "& + & when only the second sibling is merged with more",
    why: "cx: `.css-SX + .css-SX` needs the previous sibling to have the same merged class; it does not, so 0. The design's atom class sits on both siblings, so it matches (10px).",
    blocks: { s: "& + &{margin-top:10px;}", x: "color:red;" },
    tree: [{ id: "p", merge: [], children: [{ id: "s1", merge: ["s"] }, { id: "s2", merge: ["s", "x"] }] }],
    probes: [{ el: "s2", props: ["margin-top"] }],
    expect: knownFail("decision-16", "`& + &` means this component next to itself: both siblings carry the binding `s`; cx matches only siblings with the same merged class, and here the merged classes differ"),
  },
  {
    id: "selectors-29",
    title: "& + & on siblings with the same merge",
    why: "Same merged class in cx; same atom in the design.",
    blocks: { s: "& + &{margin-top:10px;}", x: "color:red;" },
    tree: [{ id: "p", merge: [], children: [{ id: "s1", merge: ["s", "x"] }, { id: "s2", merge: ["s", "x"] }] }],
    probes: [{ el: "s2", props: ["margin-top"] }],
    orders: "as-written",
  },
  {
    id: "selectors-30",
    title: "& ~ & with different merges",
    why: "As & + &.",
    blocks: { s: "& ~ &{margin-top:10px;}", x: "color:red;" },
    tree: [{ id: "p", merge: [], children: [{ id: "s1", merge: ["s", "x"] }, { id: "m", merge: [] }, { id: "s2", merge: ["s"] }] }],
    probes: [{ el: "s2", props: ["margin-top"] }],
    expect: knownFail("decision-16", "`& + &` means this component next to itself: both siblings carry the binding `s`; cx needs the same merged class on both"),
  },
  {
    id: "selectors-31",
    title: "& + & overridden by the second sibling's own operand",
    why: "The second sibling merges an operand that sets the same `& + &` key; both siblings must still match the surviving rule in the design; in cx the merged classes differ.",
    blocks: { s: "& + &{margin-top:10px;}", o: "& + &{margin-top:20px;}" },
    tree: [{ id: "p", merge: [], children: [{ id: "s1", merge: ["s", "o"] }, { id: "s2", merge: ["s", "o"] }] }],
    probes: [{ el: "s2", props: ["margin-top"] }],
  },
  {
    id: "selectors-32",
    title: "& + & with the same rule text in two bindings",
    why: "Decision 11: `&` in a sibling scope resolves to the binding id. Two bindings write the same `& + &` rule; the first sibling uses `t`, the second `s`. cx: `.css-s + .css-s` needs both siblings to carry s's class, so 0. An atom class shared by text would give 10px.",
    blocks: { s: "& + &{margin-top:10px;}", t: "& + &{margin-top:10px;} color:red;" },
    tree: [{ id: "p", merge: [], children: [{ id: "s1", merge: ["t"] }, { id: "s2", merge: ["s"] }] }],
    probes: [{ el: "s2", props: ["margin-top"] }],
  },
];

export const cases: Case[] = all;
