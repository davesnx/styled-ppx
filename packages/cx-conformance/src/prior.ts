import type { Case, Expect } from "./case.ts";

const M1 = "@media (min-width:1px)";
const M2 = "@media (min-width:2px)";

const partial: Expect = { kind: "known-fail", reason: "partial coverage in one context: a fixed sheet picks one winner for both orders (D)" };
const logical: Expect = { kind: "known-fail", reason: "logical and physical longhands are separate families: no drop, sheet position decides" };
const conditions: Expect = { kind: "known-fail", reason: "two conditions that can both hold, from different operands: cx uses merge order, the sheet a fixed order (open)" };

type Row = [id: string, title: string, blocks: string[], props: string, dir?: "rtl", expect?: Expect];

const rows: Row[] = [
  ["T01", "same property", ["width:10px;", "width:20px;"], "width"],
  ["T02", "shorthand then longhand", ["margin:10px;", "margin-top:0;"], "margin-top margin-left"],
  ["T03", "longhand then shorthand", ["margin-top:0;", "margin:10px;"], "margin-top"],
  ["T04", "partial: border-top then border-color", ["border-top:1px solid red;", "border-color:blue;"], "border-top-color border-left-color", undefined, partial],
  ["T05", "partial: border-color then border-top", ["border-color:blue;", "border-top:1px solid red;"], "border-top-color border-left-color", undefined, partial],
  ["T06", "partial: border-left then border-width", ["border-left:5px solid red;", "border-width:1px;"], "border-left-width border-left-style", undefined, partial],
  ["T07", "font resets line-height", ["line-height:30px;", "font:16px serif;"], "line-height"],
  ["T08", "line-height after font", ["font:16px serif;", "line-height:30px;"], "line-height font-size"],
  ["T09", "font resets reset-only font-kerning", ["font-kerning:none;", "font:16px serif;"], "font-kerning"],
  ["T10", "border resets border-image", ["border-image:linear-gradient(red,blue) 1;", "border:1px solid;"], "border-image-source"],
  ["T11", "background resets background-color", ["background-color:red;", "background:none;"], "background-color"],
  ["T12", "background-color after background", ["background:linear-gradient(red,blue);", "background-color:red;"], "background-color background-image"],
  ["T13", "inset resets top", ["top:5px;", "inset:0;"], "top"],
  ["T14", "top after inset", ["inset:0;", "top:5px;"], "top left"],
  ["T15", "place-items then align-items", ["place-items:center;", "align-items:end;"], "align-items justify-items"],
  ["T16", "flex resets flex-basis", ["flex-basis:10px;", "flex:1;"], "flex-basis"],
  ["T17", "grid-area resets grid-row-start", ["grid-row-start:2;", "grid-area:auto;"], "grid-row-start"],
  ["T18", "transition then transition-duration", ["transition:opacity 1s;", "transition-duration:2s;"], "transition-duration transition-property"],
  ["T19", "margin-inline vs margin-left (ltr)", ["margin-left:5px;", "margin-inline:0;"], "margin-left", undefined, logical],
  ["T20", "margin-left after margin-inline (ltr)", ["margin-inline:0;", "margin-left:5px;"], "margin-left margin-right", undefined, logical],
  ["T21", "margin-inline-start vs margin-left, ltr", ["margin-left:5px;", "margin-inline-start:0;"], "margin-left", undefined, logical],
  ["T22", "margin-inline-start vs margin-left, rtl", ["margin-left:5px;", "margin-inline-start:0;"], "margin-left margin-right", "rtl"],
  ["T23", "interpolated shorthand then longhand", ["margin:$(m);", "margin-top:0;"], "margin-top margin-left"],
  ["T24", "three blocks A B C", ["margin:1px;", "margin-top:2px;", "margin:3px;"], "margin-top"],
  ["T25", "three blocks A C B", ["margin:1px;", "margin:3px;", "margin-top:2px;"], "margin-top"],
  ["T26", "base after earlier @media (cross-block)", [`${M1}{padding-top:1px;}`, "padding-top:2px;"], "padding-top"],
  ["T27", "@media shorthand then base longhand", [`${M1}{padding:6px 0;}`, "padding-left:32px;"], "padding-left padding-top"],
  ["T28", "base shorthand then @media longhand", ["padding:6px;", `${M1}{padding-left:32px;}`], "padding-left padding-top"],
  ["T29", "two overlapping @media, A then B", [`${M1}{padding-top:1px;}`, `${M2}{padding-top:2px;}`], "padding-top", undefined, conditions],
  ["T30", "two overlapping @media, B then A", [`${M2}{padding-top:2px;}`, `${M1}{padding-top:1px;}`], "padding-top", undefined, conditions],
  ["T31", "two equal-specificity pseudo-classes", ["&:first-child{color:red;}", "&:last-child{color:blue;}"], "color", undefined, conditions],
  ["T32", "pseudo-class vs later base (specificity)", ["&:first-child{color:red;}", "color:blue;"], "color"],
  ["T33", "important vs later normal", ["color:red !important;", "color:blue;"], "color"],
  ["T34", "one block: @media before base", [`${M1}{padding-top:1px;}padding-top:2px;`], "padding-top"],
  ["T35", "one block: two overlapping @media", [`${M1}{padding-top:1px;}${M2}{padding:2px;}`], "padding-top"],
  ["T36", "one block: border-top then border-color", ["border-top:1px solid red;border-color:blue;"], "border-top-color"],
  ["T37", "same property in base and @media, A then B", [`color:red;${M1}{color:green;}`, "color:blue;"], "color"],
];

export const priorCases: Case[] = rows.map(([id, title, blocks, props, dir, expect]) => {
  const names = ["a", "b", "c"].slice(0, blocks.length);
  return {
    id,
    title,
    why: "prior case: cx winners that fixed tiers + key-aware drop must reach",
    source: ".workplace/docs/class-name-encoding-research.md §9.4",
    blocks: Object.fromEntries(names.map((n, i) => [n, blocks[i]!])),
    ...(blocks.some((b) => b.includes("$(m)")) ? { vars: { m: { css: "7px", reason: "CSS.px(7)" } } } : {}),
    tree: [{ id: "e", ...(dir ? { dir } : {}), merge: names }],
    probes: [{ el: "e", props: props.split(" ") }],
    orders: "all-permutations",
    ...(expect ? { expect } : {}),
  };
});
