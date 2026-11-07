import type { Case } from "../src/case.ts";
import { M1, M2, knownFail, merge, vp } from "./lib/build.ts";

const overlap = (what: string) =>
  knownFail("RT-05", `${what}: two different contexts that both match, from different operands. cx follows argument order; the merge keeps both atoms and a fixed sheet order gives one winner for both orders`);
const nestedScope = knownFail(
  "RT-04",
  "cx prints every nested rule (pseudo-class, descendant, conditional) after all base declarations, in argument order. 'Conditional beats base' is true only for the element's own top-level declarations; for a nested scope the unconditional and the conditional rule are ordered by argument order",
);
const textual = knownFail("RT-18", "equal conditions written differently are different contexts after whitespace-only normalization, so they act as two overlapping conditions");

const all: Case[] = [
  merge("conditions-01", "base vs @media, R1 shape, two viewports", ["margin-top:-1px;", "@media (max-width:767px){margin-top:0;}"], ["margin-top"], {
    why: "A conditional atom beats a base atom of the same property in both merge orders (decision 1); the base atom wins where the condition is false.",
    viewports: [vp(375), vp(1000)],
  }),
  merge("conditions-02", "same @media, same property", [`${M1}{color:red;}`, `${M1}{color:blue;}`], ["color"], {
    why: "Same context: the later atom drops the earlier one.",
  }),
  merge("conditions-03", "same @media, shorthand then longhand", [`${M1}{padding:6px 0;}`, `${M1}{padding-left:32px;}`], ["padding-left", "padding-top"], {
    why: "Cover and tier rules inside a condition.",
  }),
  merge("conditions-04", "@media whitespace variants are one context", ["@media (min-width:1px){color:red;}", "@media (min-width: 1px){color:blue;}"], ["color"], {
    why: "The design normalizes whitespace in media queries before hashing the context.",
  }),
  merge("conditions-05", "@media with extra spaces", ["@media   (min-width:1px)  {color:red;}", "@media (min-width:1px){color:blue;}"], ["color"], {
    why: "Whitespace normalization.",
  }),
  merge("conditions-06", "@media range syntax vs min-width", ["@media (min-width:1px){color:red;}", "@media (width >= 1px){color:blue;}"], ["color"], {
    why: "The same query in two syntaxes. Normalization does not unify them.",
    expect: textual,
  }),
  merge("conditions-07", "@media screen and vs bare feature", ["@media screen and (min-width:1px){color:red;}", "@media (min-width:1px){color:blue;}"], ["color"], {
    why: "`screen and` adds nothing on screen; still two texts.",
    expect: textual,
  }),
  merge("conditions-08", "@media feature order inside one query", ["@media (min-width:1px) and (max-width:2000px){color:red;}", "@media (max-width:2000px) and (min-width:1px){color:blue;}"], ["color"], {
    why: "`and` is commutative; whitespace normalization does not sort the features.",
    expect: textual,
  }),
  merge("conditions-09", "@media query-list order", ["@media (min-width:1px), (min-width:2px){color:red;}", "@media (min-width:2px), (min-width:1px){color:blue;}"], ["color"], {
    why: "A comma list is a union; the order does not matter to the browser.",
    expect: textual,
  }),
  merge("conditions-10", "nested @media in two orders", [`${M1}{${M2}{color:red;}}`, `${M2}{${M1}{color:blue;}}`], ["color"], {
    why: "Two nested conditions are a conjunction. The design must treat the condition list as a set, or this becomes an overlap.",
  }),
  merge("conditions-11", "&:hover inside @media vs @media inside &:hover", [`&:hover{${M1}{color:red;}}`, `${M1}{&:hover{color:blue;}}`], ["color"], {
    why: "The same context written with the at-rule inside or outside the selector.",
    states: [["hover"]],
  }),
  merge("conditions-12", "@media inside & {}", [`${M1}{& {color:red;}}`, `${M1}{color:blue;}`], ["color"], {
    why: "`& {}` inside a condition.",
  }),
  merge("conditions-13", "overlapping min/max ranges", ["@media (min-width:500px){color:red;}", "@media (max-width:800px){color:blue;}"], ["color"], {
    why: "Both match at 600px only. Outside the overlap only one applies.",
    viewports: [vp(400), vp(600), vp(900)],
    expect: overlap("min-width vs max-width"),
  }),
  merge("conditions-14", "disjoint ranges", ["@media (max-width:599px){color:red;}", "@media (min-width:600px){color:blue;}"], ["color"], {
    why: "Disjoint conditions never compete; any sheet order works.",
    viewports: [vp(400), vp(900)],
  }),
  merge("conditions-15", "@supports beats base", ["@supports (display:grid){display:grid;}", "display:block;"], ["display"], {
    why: "A conditional atom beats a base atom in both orders, for @supports too.",
  }),
  merge("conditions-16", "@supports vs @media", ["@supports (display:grid){color:red;}", `${M1}{color:blue;}`], ["color"], {
    why: "Two kinds of condition that both match.",
    expect: overlap("@supports vs @media"),
  }),
  merge("conditions-17", "@container beats base", { w: "container-type:inline-size;", a: "@container (min-width:1px){color:red;}", b: "color:blue;" }, ["color"], {
    why: "A container query on a child of a size container.",
    wrap: ["w"],
  }),
  merge("conditions-18", "@container vs @media", { w: "container-type:inline-size;", a: "@container (min-width:1px){color:red;}", b: `${M1}{color:blue;}` }, ["color"], {
    why: "Container query and media query both match.",
    wrap: ["w"],
    expect: overlap("@container vs @media"),
  }),
  merge("conditions-19", "@starting-style does not change the settled value", ["@starting-style{opacity:0;}", "opacity:0.5;"], ["opacity"], {
    why: "Sanity: a starting style is not a normal condition.",
  }),
  merge("conditions-20", "@media print does not match on screen", ["@media print{color:red;}", "color:blue;"], ["color"], {
    why: "A non-matching condition must not win.",
  }),
  merge("conditions-21", "prefers-color-scheme dark does not match", ["@media (prefers-color-scheme: dark){color:red;}", "color:blue;"], ["color"], {
    why: "Headless Chromium is light.",
  }),
  merge("conditions-22", "conditional vs base, three operands", [`${M1}{color:red;}`, "color:blue;", "color:green;"], ["color"], {
    why: "A later base atom never drops an earlier conditional one, also through chains.",
  }),
  merge("conditions-23", "@media with !important vs plain !important", [`${M1}{padding-top:1px !important;}`, "padding:2px !important;"], ["padding-top", "padding-left"], {
    why: "Importance does not change the base-before-conditional rule.",
  }),
  merge("conditions-24", "one block: hover then active (LVHA)", ["&:hover{color:red;} &:active{color:blue;}"], ["color"], {
    why: "Inside one block cx keeps source order: when hovered and active, the later `:active` rule wins. The design must keep a block's own order for overlapping contexts.",
    states: [["hover"], ["active"], ["hover", "active"]],
  }),
  merge("conditions-25", "one block: active then hover", ["&:active{color:green;} &:hover{color:orange;}"], ["color"], {
    why: "The opposite source order in another block (different values, so no shared atoms). A context-level fixed order between :hover and :active fails this case or the previous one.",
    states: [["hover", "active"]],
  }),
  merge("conditions-26", "one block: focus then focus-visible", ["&:focus{color:red;} &:focus-visible{color:blue;}"], ["color"], {
    why: "Source order inside one block.",
    states: [["focus"], ["focus", "focus-visible"]],
  }),
  merge("conditions-27", "one block: two overlapping @media, second wins", ["@media (min-width:2px){color:red;} @media (min-width:1px){color:blue;}"], ["color"], {
    why: "T35 shape with plain colors: source order inside one block.",
  }),
  merge("conditions-28", "one block: two overlapping @media, first is wider", ["@media (min-width:1px){color:purple;} @media (min-width:2px){color:teal;}"], ["color"], {
    why: "The reverse source order, different values: a fixed order by condition text fails one of these two.",
  }),
  merge("conditions-29", "one block: @media nested rule then plain nested rule (R2 shape)", ["& span{margin:1px;} @media (min-width:1px){& span{margin:2px;}} & span{margin:3px;}"], ["margin-top"], {
    why: "cx prints nested rules in source order; the later unconditional `& span` wins. A global 'conditional after plain' tier makes the @media rule win.",
    children: [{ id: "s", tag: "span", merge: [] }],
    probe: "s",
  }),
  {
    id: "conditions-30",
    title: "an atom shared with an earlier block keeps the later block's order",
    why: "Found by the harness generator. Block a has the 800px atom alone; block b has 700px then 800px. The 800px atom is one shared class, first seen in a; b's own order (800px last) must still hold. Only b is used.",
    blocks: { a: "@media (min-width:800px){opacity:0.5;}", b: "@media (min-width:700px){opacity:0.25;}@media (min-width:800px){opacity:0.5;}" },
    tree: [{ id: "y", merge: ["a"] }, { id: "x", merge: ["b"] }],
    probes: [{ el: "x", props: ["opacity"], viewport: { width: 1000, height: 800 } }],
  },
  merge("conditions-31", "across operands: hover vs focus", ["&:hover{color:red;}", "&:focus{color:blue;}"], ["color"], {
    why: "Both states at once: cx picks the later operand.",
    states: [["hover", "focus"]],
    expect: overlap(":hover vs :focus"),
  }),
  merge("conditions-32", "across operands: focus vs focus-visible", ["&:focus-visible{color:red;}", "&:focus{color:blue;}"], ["color"], {
    why: "Both match when focused by keyboard.",
    states: [["focus", "focus-visible"]],
    expect: overlap(":focus-visible vs :focus"),
  }),
  merge("conditions-33", "across operands: hover vs @media hover", ["&:hover{color:red;}", `${M1}{&:hover{color:blue;}}`], ["color"], {
    why: "Same scope, one conditional. Both are nested rules in cx, so argument order decides.",
    states: [["hover"]],
    expect: nestedScope,
  }),
  merge("conditions-34", "across operands: & span vs @media & span", [`${M1}{& span{color:red;}}`, "& span{color:blue;}"], ["color"], {
    why: "current-state §7.1, third bullet: the later operand's unconditional nested rule wins in cx.",
    children: [{ id: "s", tag: "span", merge: [] }],
    probe: "s",
    expect: nestedScope,
  }),
  merge("conditions-35", "hover:focus vs focus:hover", ["&:hover:focus{color:red;}", "&:focus:hover{color:blue;}"], ["color"], {
    why: "The design sorts pseudo-classes in a compound, so both are one context and the merge drops the earlier.",
    states: [["hover", "focus"]],
  }),
  merge("conditions-36", ":is(:hover) vs :hover", ["&:is(:hover){color:red;}", "&:hover{color:blue;}"], ["color"], {
    why: "Same meaning and specificity, different text.",
    states: [["hover"]],
    expect: overlap(":is(:hover) vs :hover"),
  }),
  merge("conditions-37", ":where(:hover) beats base in both orders", ["&:where(:hover){color:red;}", "color:blue;"], ["color"], {
    why: "Zero-specificity pseudo-class: equal specificity with the base atom. cx prints it after the base declarations in both orders, so the design must put every non-plain own scope after plain atoms whatever its specificity.",
    states: [["hover"]],
  }),
  merge("conditions-38", ":not(:hover) vs base", ["&:not(:hover){color:red;}", "color:blue;"], ["color"], {
    why: "Specificity decides.",
  }),
  merge("conditions-39", "focus-within on the element", ["&:focus-within{color:red;}", "color:blue;"], ["color"], {
    why: "A state pseudo-class beats a base atom by specificity.",
    states: [["focus-within"]],
  }),
  merge("conditions-40", "row/rowToolPadding @media pair, real order", {
    a: "padding:4px 0; @media (max-width:1279px){padding:6px 0;}",
    b: "padding-left:32px; @media (max-width:767px){padding-left:16px;}",
  }, ["padding-left", "padding-top"], {
    why: "Two overlapping max-width conditions from two operands (PPTableComparison row +++ rowToolPadding, simplified). At 375px both match; cx: b's rule is printed last.",
    orders: "as-written",
    viewports: [vp(375), vp(1000), vp(1400)],
  }),
  merge("conditions-41", "row/rowToolPadding @media pair, both orders", {
    a: "padding:4px 0; @media (max-width:1279px){padding:6px 0;}",
    b: "padding-left:32px; @media (max-width:767px){padding-left:16px;}",
  }, ["padding-left", "padding-top"], {
    why: "The same pair in both orders: at 375px the winner flips with the order in cx.",
    viewports: [vp(375), vp(1000), vp(1400)],
    expect: overlap("max-width:1279px vs max-width:767px"),
  }),
];

export const cases: Case[] = all;
