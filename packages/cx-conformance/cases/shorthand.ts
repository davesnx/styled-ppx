import type { Case } from "../src/case.ts";
import { knownFail, merge } from "./lib/build.ts";

type Row = [id: string, title: string, a: string, b: string, props: string, note?: string];

const covers = (title: string) =>
  `Cover table: the merge must drop the earlier longhand when a later shorthand in the same context covers it, and the sheet must put the longhand after the shorthand. ${title}.`;

const nested: Row[] = [
  ["shorthand-01", "margin, four values, then margin-bottom", "margin:1px 2px 3px 4px;", "margin-bottom:9px;", "margin-top margin-bottom margin-left"],
  ["shorthand-02", "margin:auto then margin-left", "margin:auto;", "margin-left:3px;", "margin-left margin-right"],
  ["shorthand-03", "padding two values then padding-left", "padding:6px 0;", "padding-left:32px;", "padding-left padding-top padding-right"],
  ["shorthand-04", "inset two values then left", "inset:1px 2px;", "left:7px;", "left right top"],
  ["shorthand-05", "border then border-top-color", "border:1px solid red;", "border-top-color:blue;", "border-top-color border-left-color border-top-width"],
  ["shorthand-06", "border then border-left-width", "border:1px solid red;", "border-left-width:5px;", "border-left-width border-top-width"],
  ["shorthand-07", "border then border-top (nested shorthands)", "border:1px solid red;", "border-top:3px dashed blue;", "border-top-color border-top-style border-left-color"],
  ["shorthand-08", "border then border-color (nested shorthands)", "border:1px solid red;", "border-color:blue;", "border-top-color border-left-width"],
  ["shorthand-09", "border then border-image-slice (reset-only)", "border:1px solid red;", "border-image-slice:3;", "border-image-slice"],
  ["shorthand-10", "border-width then border-top-width", "border-style:solid;border-width:1px;", "border-top-width:4px;", "border-top-width border-left-width", "border-style keeps the computed width non-zero"],
  ["shorthand-11", "border-style then border-left-style", "border-style:solid;", "border-left-style:dotted;", "border-left-style border-top-style"],
  ["shorthand-12", "border-color then border-right-color", "border-color:red;", "border-right-color:blue;", "border-right-color border-top-color"],
  ["shorthand-13", "border-top then border-top-color", "border-top:1px solid red;", "border-top-color:blue;", "border-top-color border-top-width"],
  ["shorthand-14", "border-radius then border-top-left-radius", "border-radius:8px;", "border-top-left-radius:0;", "border-top-left-radius border-bottom-right-radius"],
  ["shorthand-15", "border-image then border-image-slice", "border-image:linear-gradient(red,blue) 1;", "border-image-slice:2;", "border-image-slice border-image-source"],
  ["shorthand-16", "outline then outline-color", "outline:2px solid red;", "outline-color:blue;", "outline-color outline-width"],
  ["shorthand-17", "font then font-weight", "font:16px serif;", "font-weight:700;", "font-weight font-size"],
  ["shorthand-18", "font then font-variant-caps (reset-only)", "font:16px serif;", "font-variant-caps:small-caps;", "font-variant-caps"],
  ["shorthand-19", "font then font-feature-settings (reset-only)", "font:16px serif;", "font-feature-settings:\"liga\" 0;", "font-feature-settings"],
  ["shorthand-20", "font then font-variation-settings (reset-only)", "font:16px serif;", "font-variation-settings:\"wght\" 400;", "font-variation-settings"],
  ["shorthand-21", "font then font-optical-sizing (reset-only)", "font:16px serif;", "font-optical-sizing:none;", "font-optical-sizing"],
  ["shorthand-22", "font then font-size-adjust (reset-only)", "font:16px serif;", "font-size-adjust:0.5;", "font-size-adjust"],
  ["shorthand-23", "font then font-stretch", "font:16px serif;", "font-stretch:condensed;", "font-stretch"],
  ["shorthand-24", "font then font-variant-ligatures (reset-only)", "font:16px serif;", "font-variant-ligatures:none;", "font-variant-ligatures"],
  ["shorthand-25", "font then font-variant-numeric (reset-only)", "font:16px serif;", "font-variant-numeric:tabular-nums;", "font-variant-numeric"],
  ["shorthand-26", "font then font-variant-position (reset-only)", "font:16px serif;", "font-variant-position:sub;", "font-variant-position"],
  ["shorthand-27", "font then font-variant-east-asian (reset-only)", "font:16px serif;", "font-variant-east-asian:ruby;", "font-variant-east-asian"],
  ["shorthand-28", "font then font-variant-emoji (reset-only)", "font:16px serif;", "font-variant-emoji:text;", "font-variant-emoji"],
  ["shorthand-29", "font then font-variant (nested shorthands)", "font:16px serif;", "font-variant:small-caps;", "font-variant-caps font-size"],
  ["shorthand-30", "font-variant then font-variant-numeric", "font-variant:small-caps;", "font-variant-numeric:tabular-nums;", "font-variant-numeric font-variant-caps"],
  ["shorthand-31", "font-synthesis then font-synthesis-weight", "font-synthesis:none;", "font-synthesis-weight:auto;", "font-synthesis-weight font-synthesis-style"],
  ["shorthand-32", "background then background-image", "background:red;", "background-image:linear-gradient(red,blue);", "background-image background-color"],
  ["shorthand-33", "background then background-position-x (three levels)", "background:red;", "background-position-x:10px;", "background-position-x background-position-y"],
  ["shorthand-34", "background then background-position (nested shorthands)", "background:red;", "background-position:10px 20px;", "background-position-x background-position-y background-color"],
  ["shorthand-35", "background-position then background-position-x", "background-position:10px 20px;", "background-position-x:5px;", "background-position-x background-position-y"],
  ["shorthand-36", "background then background-clip", "background:red;", "background-clip:content-box;", "background-clip background-color"],
  ["shorthand-37", "background then background-size", "background:red;", "background-size:10px;", "background-size"],
  ["shorthand-38", "mask then mask-image", "mask:none;", "mask-image:linear-gradient(red,blue);", "mask-image"],
  ["shorthand-39", "mask then mask-size", "mask:none;", "mask-size:10px;", "mask-size"],
  ["shorthand-40", "grid then grid-template-columns", "grid:auto-flow / 10px;", "grid-template-columns:20px;", "grid-template-columns grid-auto-flow"],
  ["shorthand-41", "grid then grid-auto-flow", "grid:auto-flow / 10px;", "grid-auto-flow:column;", "grid-auto-flow grid-template-columns"],
  ["shorthand-42", "grid-template then grid-template-areas", "grid-template:\"a\" 10px / 20px;", "grid-template-areas:\"b\";", "grid-template-areas grid-template-rows"],
  ["shorthand-43", "grid-template then grid-template-rows", "grid-template:\"a\" 10px / 20px;", "grid-template-rows:5px;", "grid-template-rows grid-template-columns"],
  ["shorthand-44", "grid-area then grid-row-start", "grid-area:2 / 1;", "grid-row-start:3;", "grid-row-start grid-column-start"],
  ["shorthand-45", "grid-area then grid-row (nested shorthands)", "grid-area:2 / 1 / 4 / 3;", "grid-row:1 / 2;", "grid-row-start grid-row-end grid-column-end"],
  ["shorthand-46", "grid-row then grid-row-end", "grid-row:1 / 3;", "grid-row-end:2;", "grid-row-end grid-row-start"],
  ["shorthand-47", "grid-column then grid-column-start", "grid-column:1 / 3;", "grid-column-start:2;", "grid-column-start grid-column-end"],
  ["shorthand-48", "gap then row-gap", "gap:1px 2px;", "row-gap:5px;", "row-gap column-gap"],
  ["shorthand-49", "flex then flex-grow", "flex:1;", "flex-grow:2;", "flex-grow flex-basis"],
  ["shorthand-50", "flex-flow then flex-direction", "flex-flow:row wrap;", "flex-direction:column;", "flex-direction flex-wrap"],
  ["shorthand-51", "flex-flow then flex-wrap", "flex-flow:column wrap;", "flex-wrap:nowrap;", "flex-wrap flex-direction"],
  ["shorthand-52", "place-content then justify-content", "place-content:center;", "justify-content:end;", "justify-content align-content"],
  ["shorthand-53", "place-self then align-self", "place-self:center;", "align-self:end;", "align-self justify-self"],
  ["shorthand-54", "transition then transition-property", "transition:opacity 1s;", "transition-property:color;", "transition-property transition-duration"],
  ["shorthand-55", "transition then transition-delay", "transition:opacity 1s;", "transition-delay:2s;", "transition-delay"],
  ["shorthand-56", "transition then transition-behavior", "transition:opacity 1s;", "transition-behavior:allow-discrete;", "transition-behavior"],
  ["shorthand-57", "animation then animation-duration", "animation:none;", "animation-duration:2s;", "animation-duration animation-name"],
  ["shorthand-58", "animation then animation-timeline (reset-only)", "animation:none;", "animation-timeline:none;", "animation-timeline"],
  ["shorthand-59", "text-decoration then text-decoration-color", "text-decoration:underline;", "text-decoration-color:red;", "text-decoration-color text-decoration-line"],
  ["shorthand-60", "text-decoration then text-decoration-thickness", "text-decoration:underline;", "text-decoration-thickness:2px;", "text-decoration-thickness"],
  ["shorthand-61", "text-decoration then text-decoration-style", "text-decoration:underline;", "text-decoration-style:dotted;", "text-decoration-style"],
  ["shorthand-62", "list-style then list-style-type", "list-style:none;", "list-style-type:square;", "list-style-type list-style-position"],
  ["shorthand-63", "list-style then list-style-position", "list-style:square;", "list-style-position:inside;", "list-style-position list-style-type"],
  ["shorthand-64", "overflow then overflow-x", "overflow:hidden;", "overflow-x:auto;", "overflow-x overflow-y"],
  ["shorthand-65", "white-space then white-space-collapse", "white-space:nowrap;", "white-space-collapse:preserve;", "white-space-collapse text-wrap-mode"],
  ["shorthand-66", "white-space then text-wrap-mode", "white-space:pre;", "text-wrap-mode:wrap;", "text-wrap-mode white-space-collapse"],
  ["shorthand-67", "text-wrap then text-wrap-mode", "text-wrap:balance;", "text-wrap-mode:nowrap;", "text-wrap-mode text-wrap-style"],
  ["shorthand-68", "text-wrap then text-wrap-style", "text-wrap:nowrap;", "text-wrap-style:pretty;", "text-wrap-style text-wrap-mode"],
  ["shorthand-69", "columns then column-count", "columns:2;", "column-count:3;", "column-count column-width"],
  ["shorthand-70", "columns then column-width", "columns:2;", "column-width:10px;", "column-width column-count"],
  ["shorthand-71", "container then container-type", "container:a / inline-size;", "container-type:normal;", "container-type container-name"],
  ["shorthand-72", "container then container-name", "container:a / inline-size;", "container-name:b;", "container-name container-type"],
  ["shorthand-73", "scroll-margin then scroll-margin-top", "scroll-margin:2px;", "scroll-margin-top:3px;", "scroll-margin-top scroll-margin-left"],
  ["shorthand-74", "scroll-padding then scroll-padding-left", "scroll-padding:2px;", "scroll-padding-left:3px;", "scroll-padding-left scroll-padding-top"],
  ["shorthand-75", "overscroll-behavior then overscroll-behavior-x", "overscroll-behavior:contain;", "overscroll-behavior-x:none;", "overscroll-behavior-x overscroll-behavior-y"],
  ["shorthand-76", "text-emphasis then text-emphasis-color", "text-emphasis:\"x\" red;", "text-emphasis-color:blue;", "text-emphasis-color text-emphasis-style"],
  ["shorthand-77", "-webkit-text-stroke then -webkit-text-stroke-color", "-webkit-text-stroke:1px red;", "-webkit-text-stroke-color:blue;", "-webkit-text-stroke-color -webkit-text-stroke-width"],
];

const notCovered: Row[] = [
  ["shorthand-78", "outline does not reset outline-offset", "outline-offset:3px;", "outline:2px solid red;", "outline-offset outline-color"],
  ["shorthand-79", "font does not reset letter-spacing", "letter-spacing:2px;", "font:16px serif;", "letter-spacing"],
  ["shorthand-80", "font does not reset font-synthesis (Chromium)", "font-synthesis:none;", "font:16px serif;", "font-synthesis-weight font-synthesis-style"],
  ["shorthand-81", "background does not reset background-blend-mode", "background-blend-mode:multiply;", "background:red;", "background-blend-mode background-color"],
  ["shorthand-82", "grid does not reset row-gap (Chromium)", "row-gap:5px;", "grid:auto-flow / 10px;", "row-gap grid-auto-flow"],
  ["shorthand-83", "flex does not reset order", "order:2;", "flex:1;", "order flex-grow"],
  ["shorthand-84", "mask does not reset mask-type", "mask-type:alpha;", "mask:none;", "mask-type"],
  ["shorthand-85", "text-decoration does not reset text-underline-offset", "text-underline-offset:3px;", "text-decoration:underline;", "text-underline-offset"],
  ["shorthand-86", "stroke is not a shorthand of stroke-width", "stroke-width:3;", "stroke:red;", "stroke-width"],
  ["shorthand-87", "border does not reset border-radius", "border-radius:4px;", "border:1px solid red;", "border-top-left-radius"],
  ["shorthand-88", "animation does not reset animation-composition", "animation-composition:add;", "animation:none;", "animation-composition"],
];

const keywords: Row[] = [
  ["shorthand-89", "margin:inherit then margin-top", "margin:inherit;", "margin-top:5px;", "margin-top margin-left"],
  ["shorthand-90", "border:unset then border-top-color", "border:unset;", "border-top-color:red;", "border-top-color border-top-style"],
  ["shorthand-91", "font:inherit then font-kerning", "font:inherit;", "font-kerning:none;", "font-kerning font-size"],
  ["shorthand-92", "background:initial then background-color", "background:initial;", "background-color:red;", "background-color"],
  ["shorthand-93", "padding:revert then padding-left", "padding:revert;", "padding-left:4px;", "padding-left padding-top"],
  ["shorthand-94", "inset:auto then top", "inset:auto;", "top:3px;", "top left"],
  ["shorthand-95", "transition:initial then transition-duration", "transition:initial;", "transition-duration:2s;", "transition-duration"],
];

const partialRows: Row[] = [
  ["shorthand-96", "border-right then border-style", "border-right:2px dotted red;", "border-style:solid;", "border-right-style border-top-style"],
  ["shorthand-97", "border-bottom then border-width", "border-bottom:2px solid red;", "border-width:5px;", "border-bottom-width border-top-width"],
  ["shorthand-98", "border-left then border-color", "border-left:2px solid red;", "border-color:blue;", "border-left-color border-top-color"],
  ["shorthand-99", "border-block-start then border-block-color (logical)", "border-block-start:2px solid red;", "border-block-color:blue;", "border-top-color border-bottom-color"],
  ["shorthand-100", "border-inline-start then border-inline-width (logical)", "border-inline-start:2px solid red;", "border-inline-width:5px;", "border-left-width border-right-width"],
  ["shorthand-101", "white-space then text-wrap share text-wrap-mode", "white-space:nowrap;", "text-wrap:balance;", "text-wrap-mode white-space-collapse text-wrap-style"],
  ["shorthand-102", "four border sides vs border-color (union cover)", "border-top:1px solid red;border-right:1px solid red;border-bottom:1px solid red;border-left:1px solid red;", "border-color:blue;", "border-top-color border-left-color"],
];

const inContext: [title: string, a: string, b: string, props: string][] = [
  ["margin then margin-top", "margin:10px;", "margin-top:0;", "margin-top margin-left"],
  ["font then line-height", "font:16px serif;", "line-height:30px;", "line-height font-size"],
  ["font-kerning then font (reset-only)", "font-kerning:none;", "font:16px serif;", "font-kerning"],
  ["background then background-color", "background:linear-gradient(red,blue);", "background-color:red;", "background-color background-image"],
  ["border then border-top-color", "border:1px solid red;", "border-top-color:blue;", "border-top-color border-left-color"],
  ["text-decoration then text-decoration-color", "text-decoration:underline;", "text-decoration-color:red;", "text-decoration-color text-decoration-line"],
  ["flex then flex-basis", "flex:1;", "flex-basis:10px;", "flex-basis flex-grow"],
  ["grid-area then grid-row-start", "grid-area:2 / 1;", "grid-row-start:3;", "grid-row-start grid-column-start"],
];

const contexts: [name: string, ids: string[], wrap: (body: string) => string, states?: ("hover")[][]][] = [
  ["inside @media", ["shorthand-103", "shorthand-104", "shorthand-105", "shorthand-106", "shorthand-107", "shorthand-108", "shorthand-109", "shorthand-110"], (b) => `@media (min-width:1px){${b}}`],
  ["inside &:hover", ["shorthand-111", "shorthand-112", "shorthand-113", "shorthand-114", "shorthand-115", "shorthand-116", "shorthand-117", "shorthand-118"], (b) => `&:hover{${b}}`, [["hover"]]],
  ["with !important", ["shorthand-119", "shorthand-120", "shorthand-121", "shorthand-122", "shorthand-123", "shorthand-124", "shorthand-125", "shorthand-126"], (b) => b.replace(/;$/, " !important;")],
  ["inside & > *", ["shorthand-127", "shorthand-128", "shorthand-129", "shorthand-130", "shorthand-131", "shorthand-132", "shorthand-133", "shorthand-134"], (b) => `& > *{${b}}`],
];

const all: Case[] = [
  ...nested.map(([id, title, a, b, props, note]) =>
    merge(id, title, [a, b], props.split(" "), {
      why: covers(title) + (note ? ` ${note}.` : ""),
    }),
  ),
  ...notCovered.map(([id, title, a, b, props]) =>
    merge(id, title, [a, b], props.split(" "), {
      why: `The cover table must not over-reach: the browser keeps the longhand, so the merge must keep it in both orders. ${title}.`,
    }),
  ),
  ...keywords.map(([id, title, a, b, props]) =>
    merge(id, title, { w: "margin:3px;padding:2px;font:20px monospace;border:3px dashed green;", a, b }, props.split(" "), {
      why: `A CSS-wide keyword on a shorthand sets every covered longhand, so it covers like any other value. ${title}. The parent gives inherit something to inherit.`,
      wrap: ["w"],
    }),
  ),
  ...partialRows.map(([id, title, a, b, props]) =>
    merge(id, title, [a, b], props.split(" "), {
      why: `Partial overlap: the two properties share some longhands and each has others of its own, so the merge must keep both, and only the order of the two rules can pick the winner. ${title}.`,
      expect: knownFail("RT-01", "partial shorthand overlap across operands: a fixed sheet gives the same winner in both merge orders, cx follows the merge order"),
    }),
  ),
  ...contexts.flatMap(([ctx, ids, wrap, states]) =>
    inContext.map(([title, a, b, props], i) =>
      ctx === "inside & > *"
        ? {
            id: ids[i]!,
            title: `${title}, ${ctx}`,
            why: `Cover and tier rules must hold in every context, not only the plain one: ${ctx}.`,
            blocks: { a: wrap(a), b: wrap(b) },
            tree: [{ id: "p", merge: ["a", "b"], children: [{ id: "x", merge: [] }] }],
            probes: [{ el: "x", props: props.split(" ") }],
          }
        : merge(ids[i]!, `${title}, ${ctx}`, [wrap(a), wrap(b)], props.split(" "), {
            why: `Cover and tier rules must hold in every context, not only the plain one: ${ctx}.`,
            ...(states ? { states } : {}),
          }),
    ),
  ),
  merge("shorthand-135", "all:unset then color", { w: "color:green;display:flex;", a: "all:unset;", b: "color:red;" }, ["color", "display"], {
    why: "`all` covers every property except direction, unicode-bidi and custom properties. A later `all` must drop an earlier `color`; a later `color` must beat an earlier `all`. The parent gives `unset` an inherited color.",
    wrap: ["w"],
  }),
  merge("shorthand-136", "all:revert then display", ["display:flex;", "all:revert;"], ["display"], {
    why: "`all: revert` after `display:flex` resets display to the user-agent value; the reverse order keeps flex.",
  }),
  merge("shorthand-137", "all:initial keeps custom properties", { a: "--k:red;", b: "all:initial;", r: "color:var(--k, blue);" }, ["color"], {
    why: "`all` does not reset custom properties, so a merge must not drop `--k` when `all` follows it.",
  }),
  merge("shorthand-138", "shorthand with var() then longhand", { w: "--b:2px solid red;", a: "border:var(--b);", b: "border-top-color:blue;" }, ["border-top-color", "border-left-color"], {
    why: "A shorthand with a var() value is pending substitution but still covers its longhands in declaration order.",
    wrap: ["w"],
  }),
  merge("shorthand-139", "shorthand with undefined var() then longhand", ["font:var(--nope);", "line-height:30px;"], ["line-height", "font-size"], {
    why: "An invalid-at-computed-value shorthand resets every longhand; a later longhand still wins, an earlier one is still covered.",
  }),
  merge("shorthand-140", "padding with var() fallback then padding-top", ["padding:var(--nope, 3px);", "padding-top:0;"], ["padding-top", "padding-left"], {
    why: "var() with a fallback in a shorthand.",
  }),
];

export const cases: Case[] = all;
