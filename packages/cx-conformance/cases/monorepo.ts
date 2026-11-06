import type { Case } from "../src/case.ts";
import { knownFail, merge, vp } from "./lib/build.ts";

const MR = "frontend/packages/";
const px = (n: number) => ({ css: `${n}px`, reason: `\`px(${n})` });
const color = (name: string, hex: string) => ({ css: `#${hex}`, reason: `CSS.${name}` });

const stack = `${MR}ahkit/src/shared/Stack.re:2-17`;
const textarea = `${MR}ahkit/src/widgets/Textarea.re:118-123`;
const logo = `${MR}static/universal/native/src/components/Logo_Css.ml:7-17; onePixelUp ${MR}static/universal/native/src/components/MobileMenu_Css.ml:143; call site MobileMenu.re:127 (onePixelUp +++ logo +++ logoImage)`;
const seo = `${MR}static/universal/native/src/pages/SeoGlossaryDefinition_Css.ml:41-51,99-101`;
const ppc = `${MR}static/universal/native/src/components/plans-pricing/PPTableComparison_Css.ml:8-44; call sites PPTableComparison.re:119,126 (row +++ rowToolPadding)`;
const ppo = `${MR}static/universal/native/src/components/plans-pricing/PPTableOverview_Css.ml:135-154; call site PPTableOverview.mlx (featureCell +++ featureTitleCell)`;
const button = `${MR}ahkit/src/shared/Button.re:506-534`;
const ghost = `${MR}on-page/src/components/AiChatConversation.re:74-86`;
const sa = `${MR}site-audit/src/components/UrlDetailsPanel/SaUrlDetailsPanel_Css.ml:58-73`;

const row = `
  display: grid;
  grid-template-columns: 256px 1fr 1fr 1fr 1fr;
  grid-column-gap: 24px;
  align-items: center;
  padding: 4px 0;

  @media (max-width: 1279px) {
    grid-template-columns: 1fr 1fr 1fr 1fr;
    grid-column-gap: 12px;
    padding: 6px 0;

    & > :first-child {
      grid-column: span 4;
    }
  }`;
const rowToolPadding = `
  padding-top: $(px4);
  padding-bottom: $(px4);
  margin-right: $(tableSideNegativeCompensation);
  margin-left: $(tableSideNegativeCompensation);
  padding-right: $(tableSidePadding);
  padding-left: $(tableSidePadding);

  @media (max-width: 767px) {
    margin-right: $(tableSideNegativeCompensationMobile);
    margin-left: $(tableSideNegativeCompensationMobile);
    padding-right: $(tableSidePaddingMobile);
    padding-left: $(tableSidePaddingMobile);
  }`;
const rowVars = {
  px4: px(4),
  tableSideNegativeCompensation: px(-32),
  tableSidePadding: px(32),
  tableSideNegativeCompensationMobile: px(-16),
  tableSidePaddingMobile: px(16),
};

const featureCell = `
  display: grid;
  grid-template-columns: auto auto;
  justify-content: space-between;
  align-items: baseline;
  padding: 4px $(columnHorizontalGap);
  margin-right: -1px;
  margin-left: -1px;
  position: relative;

  @media (max-width: 767px) {
    padding: 4px $(columnHorizontalGapMobile);
  };`;
const featureTitleCell = `
  margin-bottom: 4px;
  padding-top: 0;
  padding-bottom: 0;`;

const colorWhite = `
  color: $(textPrimary);
  background-color: $(bgBox);
  border: 1px solid $(borderControlAlpha);

  &:hover {
    color: $(textPrimary);
    border-color: $(borderControlHoverAlpha);
  }

  &:active {
    background-color: $(bgControlActive);
    border-color: $(borderControlHoverAlpha);
  }

  &:focus {
    color: $(textPrimary);
    background-color: $(bgControlHover);
    border-color: $(borderControlHoverAlpha);
  }

  &:disabled:not(&.$(buttonLoadingAnimation)), &.$(buttonDisabled) {
    border-color: $(borderControlDisabled);
    background-color: $(bgControlDisabled);
    color: $(textTertiary);
  }`;
const iconGhost = `
  background-color: transparent;

  &:focus {
    background-color: $(bgControlHover);
  }

  &:active {
    background-color: $(bgControlActive);
  }`;
const buttonVars = {
  textPrimary: color("black", "000000"),
  bgBox: color("white", "FFFFFF"),
  borderControlAlpha: color("silver", "C0C0C0"),
  borderControlHoverAlpha: color("gray", "808080"),
  bgControlActive: color("navy", "000080"),
  bgControlHover: color("teal", "008080"),
  borderControlDisabled: color("lightgray", "D3D3D3"),
  bgControlDisabled: color("darkgray", "A9A9A9"),
  textTertiary: color("olive", "808000"),
};

const all: Case[] = [
  {
    id: "monorepo-01",
    title: "Stack children min-height vs Textarea's own min-height",
    why: "Stack sets `& > * { min-height: 0 }` on every child; a Textarea inside sets its own `min-height`. Decision 3: the child's own atom wins.",
    source: `${stack}; ${textarea}`,
    blocks: {
      grid: "display: grid;",
      stackChildrenMinWidth: "& > * { min-width: 0; }",
      stackChildrenMinHeight: "& > * { min-height: 0; }",
      textareaMinHeight: "min-height: $(minHeight)",
    },
    vars: { minHeight: px(60) },
    tree: [{ id: "stack", merge: ["grid", "stackChildrenMinWidth", "stackChildrenMinHeight"], children: [{ id: "ta", tag: "textarea", merge: ["textareaMinHeight"] }] }],
    probes: [{ el: "ta", props: ["min-height", "min-width"] }],
    orders: "as-written",
  },
  {
    id: "monorepo-02",
    title: "Stack children min-height without an own value",
    why: "Sanity: the Stack rule applies when the child has no own min-height.",
    source: stack,
    blocks: { grid: "display: grid;", stackChildrenMinHeight: "& > * { min-height: 0; }", other: "color: red;" },
    tree: [{ id: "stack", merge: ["grid", "stackChildrenMinHeight"], children: [{ id: "c", tag: "textarea", merge: ["other"] }] }],
    probes: [{ el: "c", props: ["min-height"] }],
    orders: "as-written",
  },
  merge("monorepo-03", "R1: onePixelUp +++ logo +++ logoImage", {
    onePixelUp: "margin-top: -1px;",
    logo: `width: 69px; min-width: 69px; height: 20px; text-indent: -1000em; margin-right: 25px; @media (max-width: 767px) { margin-top: 0; }`,
    logoImage: "background-image: linear-gradient(red, blue);",
  }, ["margin-top", "margin-right"], {
    why: "cx: logo's conditional `margin-top: 0` beats onePixelUp's base -1px at 375px in every order (the R1 rewrite deleted it to keep the old-pin -1px).",
    source: logo,
    viewports: [vp(375), vp(1000)],
  }),
  {
    id: "monorepo-04",
    title: "R2: SeoGlossaryDefinition blockquote margin",
    why: "One block: `blockquote, pre { margin: A; @media { margin: B } } ... figure, blockquote { margin: C }`. cx prints the nested rules in source order, so C wins at 375px. A global 'conditional after plain' tier gives B.",
    source: seo,
    blocks: {
      definition: `
  blockquote, pre {
    padding: $(px16) $(px24);
    margin: 0 $(negativePx24) $(px16) $(negativePx24);
    white-space: normal;

    @media (max-width: 767px) {
      margin: 0 $(negativePx16) $(px16) $(negativePx16);
    }
  }

  figure, blockquote {
    margin: 0 0 $(px16) 0;
  }`,
    },
    vars: { px16: px(16), px24: px(24), negativePx24: px(-24), negativePx16: px(-16) },
    tree: [{ id: "def", merge: ["definition"], children: [{ id: "bq", tag: "blockquote", merge: [] }, { id: "pre", tag: "pre", merge: [] }] }],
    probes: [
      { el: "bq", props: ["margin-left", "margin-bottom", "padding-left"], viewport: vp(375) },
      { el: "bq", props: ["margin-left", "margin-bottom"], viewport: vp(1000) },
      { el: "pre", props: ["margin-left"], viewport: vp(375) },
    ],
  },
  merge("monorepo-05", "R3/R4: row +++ rowToolPadding, call-site order", { row, rowToolPadding }, ["padding-top", "padding-bottom", "padding-left", "padding-right", "margin-left"], {
    why: "cx: row's `@media (max-width:1279px) { padding: 6px 0 }` is printed after every base declaration, so at 1000px it beats rowToolPadding's base padding (R3: 6px top, R4: 0 left). At 375px rowToolPadding's own `@media (max-width:767px)` is printed after row's.",
    source: ppc,
    vars: rowVars,
    orders: "as-written",
    viewports: [vp(375), vp(1000), vp(1400)],
  }),
  merge("monorepo-06", "R3/R4: row and rowToolPadding in both orders", { row, rowToolPadding }, ["padding-top", "padding-left"], {
    why: "In the other order cx flips the 375px winner between the two overlapping max-width conditions.",
    source: ppc,
    vars: rowVars,
    viewports: [vp(375), vp(1000), vp(1400)],
    expect: knownFail("RT-05", "(max-width:1279px) and (max-width:767px) from different operands both match at 375px"),
  }),
  merge("monorepo-07", "R5: row's base padding shorthand vs a later longhand", { row: "padding: 4px 0;", tool: "padding-top: 2px;" }, ["padding-top", "padding-left"], {
    why: "R5 rewrote `padding: 4px 0` as longhands 'for robustness'; shorthand then longhand in one context is a nested cover and must work without it.",
    source: ppc,
  }),
  merge("monorepo-08", "R6: featureCell +++ featureTitleCell", { featureCell, featureTitleCell }, ["padding-top", "padding-bottom", "padding-left"], {
    why: "cx: featureCell's `@media (max-width:767px) { padding: 4px ... }` beats featureTitleCell's base `padding-top: 0` at 375px; at 1000px the title's later longhands win in the call-site order.",
    source: ppo,
    vars: { columnHorizontalGap: px(32), columnHorizontalGapMobile: px(16) },
    viewports: [vp(375), vp(1000)],
  }),
  merge("monorepo-09", "R8: Button colorWhite states", {
    buttonLoadingAnimation: "background-size: 1rem 1rem;",
    buttonDisabled: "pointer-events: none;",
    colorWhite,
  }, ["color", "background-color", "border-top-color"], {
    why: "One block with :hover, :active, :focus in source order: with focus and active together, the later `:focus` wins (cx).",
    source: button,
    vars: buttonVars,
    tag: "button",
    use: ["colorWhite"],
    orders: "as-written",
    states: [[], ["hover"], ["active"], ["focus"], ["focus", "active"], ["hover", "active"], ["hover", "focus"]],
  }),
  {
    id: "monorepo-10",
    title: "R8: colorWhite and iconGhost share :focus/:active atoms in opposite orders",
    why: "colorWhite writes `&:active` before `&:focus`; iconGhost writes `&:focus` before `&:active`, with the same `background-color` declarations. As separate atoms they would be shared classes with one sheet position; in-block bundles (two overlapping contexts whose sheet key does not keep source order go into one bundle class) give each block its own order.",
    source: `${button}; ${ghost}`,
    blocks: { buttonLoadingAnimation: "background-size: 1rem 1rem;", buttonDisabled: "pointer-events: none;", colorWhite, iconGhost },
    vars: buttonVars,
    tree: [{ id: "white", tag: "button", merge: ["colorWhite"] }, { id: "ghost", tag: "button", merge: ["iconGhost"] }],
    probes: [
      { el: "white", props: ["background-color"], state: ["focus", "active"] },
      { el: "ghost", props: ["background-color"], state: ["focus", "active"] },
    ],
  },
  merge("monorepo-11", "R8: colorWhite disabled marker", {
    buttonLoadingAnimation: "background-size: 1rem 1rem;",
    buttonDisabled: "pointer-events: none;",
    colorWhite,
  }, ["color", "background-color"], {
    why: "`&.$(buttonDisabled)` needs the binding's class on the element: the baseline keeps it (plain cx(colorWhite, buttonDisabled) has neither class).",
    source: button,
    vars: buttonVars,
    tag: "button",
    use: ["colorWhite", "buttonDisabled"],
  }),
  merge("monorepo-12", "missingPageLink: text-decoration then text-decoration-color, merged with a later text-decoration", {
    missingPageLink: `
  cursor: pointer;
  color: $(textPrimary);
  text-decoration: underline;
  text-decoration-color: $(linkNeutral);

  &:focus {
    outline: 2px solid $(accent);
    color: $(textPrimary);
  }
  &:hover {
    color: $(textAccent);
    text-decoration: underline;
    text-decoration-color: $(linkAccent);
  }`,
    plain: "text-decoration: none;",
  }, ["text-decoration-line", "text-decoration-color", "color"], {
    why: "The most common shorthand+longhand pair in one block (63 sites), then a merge that resets the shorthand.",
    source: sa,
    vars: { textPrimary: color("black", "000000"), linkNeutral: color("gray", "808080"), accent: color("blue", "0000FF"), textAccent: color("navy", "000080"), linkAccent: color("teal", "008080") },
    states: [[], ["hover"]],
  }),
  {
    id: "monorepo-13",
    title: "Stack in Stack: inner minHeight 400 against the outer `& > *` min-height reset",
    why: "brand-radar SuggestedPromptsTab.mlx:393: the inner Stack sets min-height 400 and sits inside a Stack whose `& > *` sets min-height 0 (same specificity). An earlier identical Stack makes the inner's merged class exist before the outer's, so in cx the outer's rule comes later in the sheet and gives 0. The design gives 400 (decision 3: the child's own atom wins), which is what the author wants.",
    source: `${MR}brand-radar/src/components/SuggestedPromptsTab.mlx:393; ${stack}`,
    blocks: { grid: "display: grid;", stackChildrenMinHeight: "& > * { min-height: 0; }", minHeight: "min-height: 400px;" },
    tree: [
      { id: "warm", merge: ["minHeight", "grid", "stackChildrenMinHeight"] },
      { id: "stack", merge: ["grid", "stackChildrenMinHeight"], children: [{ id: "inner", merge: ["minHeight", "grid", "stackChildrenMinHeight"] }] },
    ],
    probes: [{ el: "inner", props: ["min-height"] }],
    orders: "as-written",
    expect: knownFail("decision-14", "the inner Stack's class exists before the outer's, so the outer `& > *` rule comes later in the sheet and wins the tie in cx (0); the design keeps decision 3 (400)"),
  },
  {
    id: "monorepo-14",
    title: "Stack in Stack: inner minWidth 0 against the outer `& > *` min-width reset",
    why: "agent-desk AgentDeskConnectorsPage.mlx:719: the inner value equals the reset (0), so the winner does not show.",
    source: `${MR}agent-desk/src/pages/AgentDeskConnectorsPage.mlx:719; ${stack}`,
    blocks: { grid: "display: grid;", stackChildrenMinWidth: "& > * { min-width: 0; }", minWidth: "min-width: 0;" },
    tree: [
      { id: "warm", merge: ["minWidth", "grid", "stackChildrenMinWidth"] },
      { id: "stack", merge: ["grid", "stackChildrenMinWidth"], children: [{ id: "inner", merge: ["minWidth", "grid", "stackChildrenMinWidth"] }] },
    ],
    probes: [{ el: "inner", props: ["min-width"] }],
    orders: "as-written",
  },
];

export const cases: Case[] = all;
