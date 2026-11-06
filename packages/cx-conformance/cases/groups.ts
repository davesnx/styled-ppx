import type { Case } from "../src/case.ts";
import { M1, merge } from "./lib/build.ts";

const all: Case[] = [
  merge("groups-01", "display fallback group vs later display", ["display:-webkit-box;display:flex;", "display:grid;"], ["display"], {
    why: "A same-property group is one atom with one key; a later `display` drops the whole group, an earlier one is dropped by it.",
  }),
  merge("groups-02", "width fallback group vs later width", ["width:100px;width:calc(100% - 10px);", "width:50px;"], ["width"], {
    why: "Fallback pair for an older browser; one key.",
  }),
  merge("groups-03", "group with an interpolation", ["color:red;color:$(c);", "color:blue;"], ["color"], {
    why: "A group whose last member is dynamic.",
    vars: { c: { css: "green", reason: "CSS.green" } },
  }),
  merge("groups-04", "group inside a condition", [`${M1}{display:-webkit-box;display:flex;}`, `${M1}{display:block;}`], ["display"], {
    why: "Groups also form inside nested blocks.",
  }),
  merge("groups-05", "shorthand group then longhand", ["margin:0;margin:0 auto;", "margin-left:3px;"], ["margin-left", "margin-right"], {
    why: "A group of one shorthand still covers its longhands.",
  }),
  merge("groups-06", "line-clamp pattern vs later display", ["display:-webkit-box;-webkit-box-orient:vertical;-webkit-line-clamp:2;overflow:hidden;", "display:block;"], ["display", "-webkit-line-clamp", "overflow-y"], {
    why: "A common multi-property pattern: only the display atom is replaced.",
  }),
  merge("groups-07", "group split by another declaration", ["display:-webkit-box;color:red;display:flex;", "color:blue;"], ["display", "color"], {
    why: "The group sits at the last member; the color atom between them is independent.",
  }),
  merge("groups-08", "same property twice with a nested rule between", [`color:red;${M1}{color:green;}color:blue;`, "color:orange;"], ["color"], {
    why: "The base group (red, blue) is one atom; the @media atom stays and wins in both orders.",
  }),
  merge("groups-09", "one block: longhand then covering shorthand", ["margin-top:5px;margin:0;"], ["margin-top"], {
    why: "The later shorthand makes the earlier longhand dead. As two atoms, the longhand tier would win (5px); cx gives 0. The ppx must drop the dead longhand or group the two.",
  }),
  merge("groups-10", "one block: left then inset (harness generator)", ["position:relative;left:6px;inset:0px;"], ["left", "top"], {
    why: "Found by the harness generator: a later shorthand in the same block makes the earlier longhand dead; per-property atoms with shorthands first in the sheet give 6px, cx gives 0px.",
  }),
  merge("groups-11", "one block: border-color then border-top", ["border-color:blue;border-top:1px solid red;"], ["border-top-color", "border-left-color"], {
    why: "Partial overlap inside one block (T36 reversed): only the ppx sees the order, so it must group the two into one atom.",
  }),
  merge("groups-12", "one block: font-kerning then font", ["font-kerning:none;font:16px serif;"], ["font-kerning"], {
    why: "A reset-only member made dead by a later shorthand in the same block.",
  }),
  merge("groups-13", "one block: dead longhand, then a merge with another longhand", ["margin-top:5px;margin:0;", "margin-left:3px;"], ["margin-top", "margin-left"], {
    why: "After the in-block fix the block is one shorthand atom; the merge then treats it as usual.",
  }),
  merge("groups-14", "one block: partial-overlap group, then a merge that covers half of it", ["border-top:1px solid red;border-color:blue;", "border-top:2px dashed green;"], ["border-top-color", "border-left-color", "border-top-style"], {
    why: "A grouped multi-property atom meets a later operand that covers only part of it. The key of a grouped atom (several property ids) is undefined in the design.",
  }),
];

export const cases: Case[] = all;
