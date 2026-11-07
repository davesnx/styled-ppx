import type { Case } from "../src/case.ts";
import { knownFail, merge } from "./lib/build.ts";

const lp = knownFail("RT-06", "logical and physical properties that map to the same side are separate keys; the merge keeps both and the sheet order picks one winner for both merge orders");

type Row = [id: string, title: string, a: string, b: string, props: string, opts?: { dir?: "rtl"; vertical?: boolean; disjoint?: boolean }];

const rows: Row[] = [
  ["logical-01", "padding-inline-start vs padding-left, ltr", "padding-inline-start:4px;", "padding-left:8px;", "padding-left"],
  ["logical-02", "padding-inline-start vs padding-right, rtl", "padding-inline-start:4px;", "padding-right:8px;", "padding-right padding-left", { dir: "rtl" }],
  ["logical-03", "padding-inline-start vs padding-left, rtl (disjoint)", "padding-inline-start:4px;", "padding-left:8px;", "padding-right padding-left", { dir: "rtl", disjoint: true }],
  ["logical-04", "inset-inline-start vs left", "inset-inline-start:5px;", "left:7px;", "left"],
  ["logical-05", "inset-inline vs right", "inset-inline:0;", "right:5px;", "right left"],
  ["logical-06", "inset-block vs top", "inset-block:1px;", "top:5px;", "top bottom"],
  ["logical-07", "inset vs inset-inline (both shorthands)", "inset:2px;", "inset-inline:1px;", "left right top"],
  ["logical-08", "inline-size vs width", "inline-size:10px;", "width:20px;", "width"],
  ["logical-09", "block-size vs height", "block-size:10px;", "height:20px;", "height"],
  ["logical-10", "min-inline-size vs min-width", "min-inline-size:10px;", "min-width:20px;", "min-width"],
  ["logical-11", "max-block-size vs max-height", "max-block-size:10px;", "max-height:20px;", "max-height"],
  ["logical-12", "margin-block vs margin-top", "margin-block:3px;", "margin-top:9px;", "margin-top margin-bottom"],
  ["logical-13", "margin-block-start vs margin-top", "margin-block-start:3px;", "margin-top:9px;", "margin-top"],
  ["logical-14", "margin vs margin-inline-start", "margin:1px;", "margin-inline-start:4px;", "margin-left margin-right"],
  ["logical-15", "padding-block vs padding-bottom", "padding-block:3px;", "padding-bottom:9px;", "padding-bottom padding-top"],
  ["logical-16", "border-inline-start-color vs border-left-color", "border-inline-start-color:green;", "border-left-color:red;", "border-left-color"],
  ["logical-17", "border-inline-start vs border-left", "border-inline-start:2px solid green;", "border-left:3px dotted red;", "border-left-color border-left-width border-left-style"],
  ["logical-18", "border-start-start-radius vs border-top-left-radius", "border-start-start-radius:4px;", "border-top-left-radius:9px;", "border-top-left-radius"],
  ["logical-19", "scroll-margin-inline-start vs scroll-margin-left", "scroll-margin-inline-start:4px;", "scroll-margin-left:9px;", "scroll-margin-left"],
  ["logical-20", "vertical-rl: margin-block-start vs margin-right", "writing-mode:vertical-rl;margin-block-start:3px;", "margin-right:9px;", "margin-right", { vertical: true }],
  ["logical-21", "vertical-rl: margin-inline vs margin-top", "writing-mode:vertical-rl;margin-inline:3px;", "margin-top:9px;", "margin-top margin-bottom", { vertical: true }],
  ["logical-22", "vertical-rl: inline-size vs height", "writing-mode:vertical-rl;inline-size:10px;", "height:20px;", "height", { vertical: true }],
  ["logical-23", "vertical-rl: margin-block vs margin-top (disjoint)", "writing-mode:vertical-rl;margin-block:3px;", "margin-top:9px;", "margin-top margin-left margin-right", { vertical: true, disjoint: true }],
];

const all: Case[] = rows.map(([id, title, a, b, props, o]) =>
  merge(id, title, [a, b], props.split(" "), {
    why: o?.disjoint
      ? `In this writing mode the logical and the physical property map to different sides, so the order does not matter; the merge must not drop either. ${title}.`
      : `Chromium resolves a logical property and the physical property it maps to by declaration order. The two are different property ids, so neither is dropped. ${title}.`,
    ...(o?.dir ? { dir: o.dir } : {}),
    ...(o?.disjoint ? {} : { expect: lp }),
  }),
);

all.push(
  merge("logical-24", "direction set in a merged operand changes the mapping", ["direction:rtl;margin-inline-start:4px;", "margin-left:9px;"], ["margin-left", "margin-right"], {
    why: "The writing mode can come from the same merge. A merge or table that assumes ltr would treat margin-inline-start as margin-left here; it is margin-right. Both orders give the same result because the sides are disjoint.",
  }),
  merge("logical-25", "logical in one condition, physical in the same condition", ["@media (min-width:1px){margin-inline-start:4px;}", "@media (min-width:1px){margin-left:9px;}"], ["margin-left"], {
    why: "Logical vs physical in the same context inside a condition.",
    expect: lp,
  }),
);

export const cases: Case[] = all;
