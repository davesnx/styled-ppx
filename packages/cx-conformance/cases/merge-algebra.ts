import type { Case } from "../src/case.ts";
import { M1, knownFail, merge } from "./lib/build.ts";

const all: Case[] = [
  merge("merge-algebra-01", "merge with empty", { a: "color:red;", e: "" }, ["color"], { why: "`CSS.empty` is the identity on both sides." }),
  merge("merge-algebra-02", "merge with itself", { a: "margin:1px; margin-top:2px; @media (min-width:1px){color:red;}" }, ["margin-top", "color"], {
    why: "`merge(a, a)` equals `a`.",
  }),
  { ...merge("merge-algebra-03", "merge(a, a) explicit", { a: "margin:1px; margin-top:2px;" }, ["margin-top", "margin-left"], { why: "The same binding twice." }), tree: [{ id: "x", merge: ["a", "a"] }] },
  { ...merge("merge-algebra-04", "a, b, a with longhand and shorthand", { a: "margin-top:1px;", b: "margin:2px;" }, ["margin-top", "margin-left"], { why: "The second copy of a must win again; every permutation of [a, b, a]." }), tree: [{ id: "x", merge: ["a", "b", "a"] }] },
  { ...merge("merge-algebra-05", "a, b, a with shorthand and longhand", { a: "margin:2px;", b: "margin-top:1px;" }, ["margin-top", "margin-left"], { why: "The reverse roles." }), tree: [{ id: "x", merge: ["a", "b", "a"] }] },
  { ...merge("merge-algebra-06", "a, b, a with a condition", { a: `${M1}{color:red;}`, b: "color:blue;" }, ["color"], { why: "Repeated conditional operand." }), tree: [{ id: "x", merge: ["a", "b", "a"] }] },
  merge("merge-algebra-07", "four margin operands, every order", ["margin:1px;", "margin-top:2px;", "margin-left:3px;", "margin:4px 5px;"], ["margin-top", "margin-left", "margin-right", "margin-bottom"], {
    why: "Nested cover over 24 orders: the merge result must not depend on how the fold groups the operands.",
  }),
  merge("merge-algebra-08", "four border operands in the written order", ["border:1px solid red;", "border-top:2px dashed blue;", "border-top-color:green;", "border-width:3px;"], ["border-top-color", "border-top-width", "border-left-width", "border-top-style"], {
    why: "border > border-top > border-top-color and border > border-width > border-top-width; border-top vs border-width is a partial overlap, so the later border-width cannot drop border-top and the sheet picks border-top's width.",
    orders: "as-written",
    expect: knownFail("RT-01", "border-top then border-width is a partial overlap; the fixed sheet puts border-top (3 leaves) after border-width (4 leaves), cx gives border-width"),
  }),
  merge("merge-algebra-09", "three conditions and a base, every order", [`${M1}{color:red;}`, "color:blue;", "&:hover{color:green;}", "color:orange;"], ["color"], {
    why: "Conditional beats base, specificity beats both.",
    states: [[], ["hover"]],
  }),
  merge("merge-algebra-10", "long chain of twelve operands", [
    "display:block;margin:0;",
    "padding:4px;",
    "margin-top:2px;",
    "color:red;",
    `${M1}{padding:8px;}`,
    "padding-left:1px;",
    "border:1px solid red;",
    "border-color:blue;",
    "color:green;",
    "&:hover{color:orange;}",
    "margin:3px;",
    "display:flex;",
  ], ["display", "margin-top", "margin-left", "padding-top", "padding-left", "border-top-color", "color"], {
    why: "A long realistic chain (Stack-like) in the written order; every step is a nested cover or a base/conditional pair.",
    orders: "as-written",
    states: [[], ["hover"]],
  }),
  merge("merge-algebra-11", "long chain, reversed", [
    "display:flex;",
    "margin:3px;",
    "&:hover{color:orange;}",
    "color:green;",
    "border-color:blue;",
    "border:1px solid red;",
    "padding-left:1px;",
    `${M1}{padding:8px;}`,
    "color:red;",
    "margin-top:2px;",
    "padding:4px;",
    "display:block;margin:0;",
  ], ["display", "margin-top", "margin-left", "padding-top", "padding-left", "border-top-color", "color"], {
    why: "The same chain reversed.",
    orders: "as-written",
    states: [[], ["hover"]],
  }),
  merge("merge-algebra-12", "union cover: border-top, then widths and styles, then colors", ["border-top:1px solid red;", "border-width:2px;border-style:dashed;", "border-color:blue;"], ["border-top-width", "border-top-style", "border-top-color"], {
    why: "Found by the harness: b and c together cover a (cx: 2px dashed blue). A pairwise drop with a left fold, as `+++` does, keeps a (1px solid red). The decided merge normalizes the joined list, dropping every atom covered by the union of later atoms in the same context, so a is dropped in any fold (RT-25).",
    orders: "as-written",
  }),
  merge("merge-algebra-13", "same key and same value in both operands", ["color:red;", "color:red;padding:1px;"], ["color", "padding-top"], {
    why: "Identical atoms dedupe; the result is unchanged.",
  }),
  merge("merge-algebra-14", "only conditional atoms on both sides", [`${M1}{color:red;}`, `${M1}{padding:1px;}`], ["color", "padding-top"], {
    why: "Disjoint keys under one condition.",
  }),
];

export const cases: Case[] = all;
