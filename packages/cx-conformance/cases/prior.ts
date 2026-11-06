import type { Case } from "../src/case.ts";
import { M1, M2, knownFail, merge } from "./lib/build.ts";

const src = "class-name-encoding-research.md §9.4 (session styled-ppx-34, cases-def.cjs)";
const partial = knownFail("RT-01", "partial shorthand overlap in one context: neither atom can be dropped, so a fixed sheet gives one winner for both merge orders");
const logical = knownFail("RT-06", "logical and physical properties are separate keys; the sheet order decides, not the merge order");
const overlap = knownFail("RT-05", "two different conditions that both match, from different operands: cx follows argument order, a fixed sheet cannot");

const p = (
  id: string,
  title: string,
  blocks: string[],
  props: string,
  extra: Partial<Parameters<typeof merge>[4]> = {},
): Case => merge(id, title, blocks, props.split(" "), { why: `Prior case ${id}: ${title}.`, source: src, ...extra });

export const cases: Case[] = [
  p("T01", "same property", ["width:10px;", "width:20px;"], "width"),
  p("T02", "shorthand then longhand", ["margin:10px;", "margin-top:0;"], "margin-top margin-left"),
  p("T03", "longhand then shorthand", ["margin-top:0;", "margin:10px;"], "margin-top"),
  p("T04", "partial: border-top then border-color", ["border-top:1px solid red;", "border-color:blue;"], "border-top-color border-left-color", { expect: partial }),
  p("T05", "partial: border-color then border-top", ["border-color:blue;", "border-top:1px solid red;"], "border-top-color border-left-color", { expect: partial }),
  p("T06", "partial: border-left then border-width", ["border-left:5px solid red;", "border-width:1px;"], "border-left-width border-left-style", { expect: partial }),
  p("T07", "font resets line-height", ["line-height:30px;", "font:16px serif;"], "line-height"),
  p("T08", "line-height after font", ["font:16px serif;", "line-height:30px;"], "line-height font-size"),
  p("T09", "font resets reset-only font-kerning", ["font-kerning:none;", "font:16px serif;"], "font-kerning"),
  p("T10", "border resets border-image", ["border-image:linear-gradient(red,blue) 1;", "border:1px solid;"], "border-image-source"),
  p("T11", "background resets background-color", ["background-color:red;", "background:none;"], "background-color"),
  p("T12", "background-color after background", ["background:linear-gradient(red,blue);", "background-color:red;"], "background-color background-image"),
  p("T13", "inset resets top", ["top:5px;", "inset:0;"], "top"),
  p("T14", "top after inset", ["inset:0;", "top:5px;"], "top left"),
  p("T15", "place-items then align-items", ["place-items:center;", "align-items:end;"], "align-items justify-items"),
  p("T16", "flex resets flex-basis", ["flex-basis:10px;", "flex:1;"], "flex-basis"),
  p("T17", "grid-area resets grid-row-start", ["grid-row-start:2;", "grid-area:auto;"], "grid-row-start"),
  p("T18", "transition then transition-duration", ["transition:opacity 1s;", "transition-duration:2s;"], "transition-duration transition-property"),
  p("T19", "margin-inline vs margin-left (ltr)", ["margin-left:5px;", "margin-inline:0;"], "margin-left", { expect: logical }),
  p("T20", "margin-left after margin-inline (ltr)", ["margin-inline:0;", "margin-left:5px;"], "margin-left margin-right", { expect: logical }),
  p("T21", "margin-inline-start vs margin-left, ltr", ["margin-left:5px;", "margin-inline-start:0;"], "margin-left", { expect: logical }),
  p("T22", "margin-inline-start vs margin-left, rtl", ["margin-left:5px;", "margin-inline-start:0;"], "margin-left margin-right", { dir: "rtl" }),
  merge("T23", "interpolated shorthand then longhand", { w: "--m: 7px;", a: "margin:var(--m);", b: "margin-top:0;" }, ["margin-top", "margin-left"], {
    why: "Prior case T23: a shorthand whose value is a var() still covers the longhand; the parent sets --m.",
    source: src,
    wrap: ["w"],
  }),
  p("T24", "three blocks A B C", ["margin:1px;", "margin-top:2px;", "margin:3px;"], "margin-top"),
  p("T25", "three blocks A C B", ["margin:1px;", "margin:3px;", "margin-top:2px;"], "margin-top"),
  p("T26", "base after earlier @media (cross-block)", [`${M1}{padding-top:1px;}`, "padding-top:2px;"], "padding-top"),
  p("T27", "@media shorthand then base longhand", [`${M1}{padding:6px 0;}`, "padding-left:32px;"], "padding-left padding-top"),
  p("T28", "base shorthand then @media longhand", ["padding:6px;", `${M1}{padding-left:32px;}`], "padding-left padding-top"),
  p("T29", "two overlapping @media, A then B", [`${M1}{padding-top:1px;}`, `${M2}{padding-top:2px;}`], "padding-top", { expect: overlap }),
  p("T30", "two overlapping @media, B then A", [`${M2}{padding-top:2px;}`, `${M1}{padding-top:1px;}`], "padding-top", { expect: overlap }),
  p("T31", "two equal-specificity pseudo-classes", ["&:first-child{color:red;}", "&:last-child{color:blue;}"], "color", { expect: overlap }),
  p("T32", "pseudo-class vs later base (specificity)", ["&:first-child{color:red;}", "color:blue;"], "color"),
  p("T33", "important vs later normal", ["color:red !important;", "color:blue;"], "color"),
  p("T34", "one block: @media before base", [`${M1}{padding-top:1px;}padding-top:2px;`], "padding-top"),
  p("T35", "one block: two overlapping @media", [`${M1}{padding-top:1px;}${M2}{padding:2px;}`], "padding-top"),
  p("T36", "one block: border-top then border-color", ["border-top:1px solid red;border-color:blue;"], "border-top-color"),
  p("T37", "same property in base and @media, A then B", [`color:red;${M1}{color:green;}`, "color:blue;"], "color"),
];
