import type { Case } from "../src/case.ts";
import { M1, knownFail, merge } from "./lib/build.ts";

type Row = [id: string, title: string, blocks: string[], props: string, why: string, extra?: Partial<Parameters<typeof merge>[4]>];

const rows: Row[] = [
  ["important-01", "important vs important, same property", ["color:red !important;", "color:blue !important;"], "color", "Same context including importance: the later drops the earlier."],
  ["important-02", "important in @media vs important base", [`${M1}{color:red !important;}`, "color:blue !important;"], "color", "Both important: cx prints the nested rule after base declarations, so the conditional one wins in both orders."],
  ["important-03", "mixed group: important then normal, vs later important", ["color:red !important;color:blue;", "color:green !important;"], "color", "A same-property group with mixed importance. The design must give the group's important part and normal part separate keys, or merge drops the wrong one."],
  ["important-04", "mixed group vs later normal", ["color:red !important;color:blue;", "color:green;"], "color", "The important member wins in both orders."],
  ["important-05", "mixed group: normal then important, vs later important", ["color:blue;color:red !important;", "color:green !important;"], "color", "As above, other source order."],
  ["important-06", "important shorthand vs normal longhand", ["margin:0 !important;", "margin-top:5px;"], "margin-top margin-left", "Different contexts; importance decides in both orders."],
  ["important-07", "important longhand vs normal shorthand", ["margin-top:5px !important;", "margin:0;"], "margin-top margin-left", "The normal shorthand must not drop the important longhand."],
  ["important-08", "important shorthand vs important longhand", ["margin:0 !important;", "margin-top:5px !important;"], "margin-top margin-left", "Same importance, same scope: cover and tier rules."],
  ["important-09", "important hover vs important base", ["&:hover{color:red !important;}", "color:blue !important;"], "color", "Specificity decides among important declarations.", { states: [["hover"]] }],
  ["important-10", "important base vs normal hover", ["color:blue !important;", "&:hover{color:red;}"], "color", "Important base beats a normal hover.", { states: [["hover"]] }],
  ["important-11", "important @media longhand vs important base shorthand", [`${M1}{padding-top:1px !important;}`, "padding:2px !important;"], "padding-top padding-left", "Conditional wins over base among important atoms."],
  ["important-12", "important custom property vs normal", ["--k:red !important;", "--k:blue;", "color:var(--k);"], "color", "Custom properties can be important; importance is part of the key."],
  ["important-13", "three operands: important, normal, important", ["color:red !important;", "color:blue;", "color:green !important;"], "color", "The last important wins; the normal one never does."],
  ["important-14", "important partial overlap", ["border-top:1px solid red !important;", "border-color:blue !important;"], "border-top-color border-left-color", "Partial overlap among important atoms.", { expect: knownFail("RT-01", "partial shorthand overlap across operands") }],
  ["important-15", "spacing in !important", ["color:red !important;", "color:blue ! important;"], "color", "`! important` and `!important` are the same flag; the context must not depend on its spelling."],
  ["important-16", "important interpolated value", ["color:$(c) !important;", "color:blue !important;"], "color", "Importance with an interpolation.", { vars: { c: { css: "red", reason: "CSS.red" } } }],
];

const all: Case[] = rows.map(([id, title, blocks, props, why, extra]) => merge(id, title, blocks, props.split(" "), { why, ...extra }));

export const cases: Case[] = all;
