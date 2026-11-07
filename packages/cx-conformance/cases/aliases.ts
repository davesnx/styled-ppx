import type { Case } from "../src/case.ts";
import { merge } from "./lib/build.ts";

type Row = [id: string, title: string, a: string, b: string, props: string, source?: string];

const rows: Row[] = [
  ["aliases-01", "word-wrap is overflow-wrap", "word-wrap:break-word;", "overflow-wrap:anywhere;", "overflow-wrap", "frontend/packages/account-settings/src/pages/AsMemberRow_Css.ml:14 (word-wrap)"],
  ["aliases-02", "grid-gap is the legacy name of gap", "grid-gap:1px;", "gap:2px;", "row-gap column-gap", "frontend/packages/static/universal/native/src/components/plans-pricing/PPTableOverview_Css.ml:167 (grid-gap)"],
  ["aliases-03", "grid-row-gap is row-gap", "grid-row-gap:1px;", "row-gap:2px;", "row-gap", "frontend/packages/static/universal/native/src/components/plans-pricing/PPTableComparison_Css.ml:27 (grid-row-gap)"],
  ["aliases-04", "grid-column-gap is column-gap", "grid-column-gap:24px;", "column-gap:8px;", "column-gap", "frontend/packages/static/universal/native/src/components/plans-pricing/PPTableComparison_Css.ml:11 (grid-column-gap)"],
  ["aliases-05", "grid-gap covers row-gap", "grid-gap:1px;", "row-gap:5px;", "row-gap column-gap"],
  ["aliases-06", "grid-gap covers grid-row-gap (two aliases)", "grid-row-gap:5px;", "grid-gap:1px;", "row-gap"],
  ["aliases-07", "-webkit-user-select is user-select", "-webkit-user-select:none;", "user-select:text;", "user-select"],
  ["aliases-08", "-webkit-appearance is appearance", "-webkit-appearance:none;", "appearance:auto;", "appearance"],
  ["aliases-09", "-webkit-box-shadow is box-shadow", "-webkit-box-shadow:none;", "box-shadow:1px 1px red;", "box-shadow"],
  ["aliases-10", "page-break-before maps to break-before", "page-break-before:always;", "break-before:column;", "break-before"],
];

const all: Case[] = rows.map(([id, title, a, b, props, source]) =>
  merge(id, title, [a, b], props.split(" "), {
    why: `Chromium treats the two names as one property, so the later declaration wins. The merge must give both names one property id (or the cover table must list the alias), otherwise both atoms stay and the sheet order decides. ${title}.`,
    ...(source ? { source } : {}),
  }),
);

all.push(
  merge("aliases-11", "prefixed and unprefixed pair in one block, then the unprefixed name", ["-webkit-user-select:none;user-select:none;", "user-select:text;"], ["user-select"], {
    why: "Authors write both names in one block. A later `user-select` must drop both of them; keying by source name keeps the `-webkit-` atom, which then wins or loses by sheet position.",
  }),
  merge("aliases-12", "unprefixed name, then prefixed name", ["user-select:text;", "-webkit-user-select:none;"], ["user-select"], {
    why: "The reverse: a later `-webkit-user-select` must override an earlier `user-select`.",
  }),
  merge("aliases-13", "gap in a condition vs grid-gap in the same condition", ["@media (min-width:1px){gap:1px;}", "@media (min-width:1px){grid-gap:2px;}"], ["row-gap"], {
    why: "Alias handling must also apply inside a condition.",
  }),
);

export const cases: Case[] = all;
