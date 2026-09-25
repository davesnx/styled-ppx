/* Tests for the [Shorthand] and [Alias] kinds (Types.ml) and the query API
   they feed (Registry.ml's [shorthands]/[is_shorthand]/[direct_longhands]/
   [aliases]/[is_alias]/[canonical_name_of]) - not the value grammars
   themselves (those are covered elsewhere). See .workplace/plans/
   atom-slot-keys_PLAN.md for why this data now lives in css-grammar instead
   of a separate table in slot_key. */

module Parser = Css_grammar;
let check = Alcotest_extra.check;

let all_shorthands = Parser.shorthands();
let all_property_names = Parser.property_names();

/* Every longhand a shorthand names (settable or reset-only - see each
   registration site's own citation comment) must itself be a registered
   property, even when it is also a shorthand (e.g. "border" -> "border-
   width" -> "border-top-width" - each link in that chain is independently
   checked, one level at a time; this is not a transitive-closure check). */
let coverage_tests: tests = [
  test("every shorthand's direct longhands are themselves registered", _ => {
    let unknown =
      all_shorthands
      |> List.concat_map(((_shorthand, longhands)) => longhands)
      |> List.sort_uniq(String.compare)
      |> List.filter(name => !List.mem(name, all_property_names));
    check(~__POS__, Alcotest.list(Alcotest.string), unknown, []);
  }),
  test("every shorthand's own name is itself a registered property", _ => {
    let unknown =
      all_shorthands
      |> List.map(((shorthand, _)) => shorthand)
      |> List.filter(name => !List.mem(name, all_property_names));
    check(~__POS__, Alcotest.list(Alcotest.string), unknown, []);
  }),
  test("no duplicate shorthand registrations", _ => {
    let names = all_shorthands |> List.map(((shorthand, _)) => shorthand);
    check(
      ~__POS__,
      Alcotest.int,
      List.length(List.sort_uniq(String.compare, names)),
      List.length(names),
    );
  }),
];

/* A cycle would mean some shorthand's own longhand chain (transitively,
   through other shorthands) reaches back to itself - [walk] detects that
   via a "currently visiting" set, the same technique slot_key's own
   [leaves_of] uses to make its transitive expansion always terminate. */
let has_no_cycle_from = shorthand => {
  let rec walk = (visiting, name) =>
    if (List.mem(name, visiting)) {
      false;
    } else {
      switch (Parser.direct_longhands(name)) {
      | None => true
      | Some(children) => List.for_all(walk([name, ...visiting]), children)
      };
    };
  walk([], shorthand);
};

let cycle_tests: tests = [
  test("every shorthand's expansion is acyclic", _ => {
    let cyclic =
      all_shorthands
      |> List.map(((shorthand, _)) => shorthand)
      |> List.filter(sh => !has_no_cycle_from(sh));
    check(~__POS__, Alcotest.list(Alcotest.string), cyclic, []);
  }),
];

/* Pinned snapshot: the exact (shorthand, direct longhands) data this table
   should hold, per the spec section cited in a comment at each shorthand's
   own registration site in its Properties file. This is what actually enforces
   "matches the spec" - an accidental edit to a registration's longhand list
   fails here even though every longhand still resolves (which the coverage
   tests above would not catch on their own). Sourced 2026-09-25 - see the
   corresponding property-table session report for the citations. */
let expected_shorthands: list((string, list(string))) = [
  ("margin", ["margin-top", "margin-right", "margin-bottom", "margin-left"]),
  (
    "padding",
    ["padding-top", "padding-right", "padding-bottom", "padding-left"],
  ),
  ("margin-block", ["margin-block-start", "margin-block-end"]),
  ("margin-inline", ["margin-inline-start", "margin-inline-end"]),
  ("padding-block", ["padding-block-start", "padding-block-end"]),
  ("padding-inline", ["padding-inline-start", "padding-inline-end"]),
  ("inset", ["top", "right", "bottom", "left"]),
  ("inset-block", ["inset-block-start", "inset-block-end"]),
  ("inset-inline", ["inset-inline-start", "inset-inline-end"]),
  (
    "scroll-margin",
    [
      "scroll-margin-top",
      "scroll-margin-right",
      "scroll-margin-bottom",
      "scroll-margin-left",
    ],
  ),
  (
    "scroll-margin-block",
    ["scroll-margin-block-start", "scroll-margin-block-end"],
  ),
  (
    "scroll-margin-inline",
    ["scroll-margin-inline-start", "scroll-margin-inline-end"],
  ),
  (
    "scroll-padding",
    [
      "scroll-padding-top",
      "scroll-padding-right",
      "scroll-padding-bottom",
      "scroll-padding-left",
    ],
  ),
  (
    "scroll-padding-block",
    ["scroll-padding-block-start", "scroll-padding-block-end"],
  ),
  (
    "scroll-padding-inline",
    ["scroll-padding-inline-start", "scroll-padding-inline-end"],
  ),
  (
    "border-width",
    [
      "border-top-width",
      "border-right-width",
      "border-bottom-width",
      "border-left-width",
    ],
  ),
  (
    "border-style",
    [
      "border-top-style",
      "border-right-style",
      "border-bottom-style",
      "border-left-style",
    ],
  ),
  (
    "border-color",
    [
      "border-top-color",
      "border-right-color",
      "border-bottom-color",
      "border-left-color",
    ],
  ),
  (
    "border-top",
    ["border-top-width", "border-top-style", "border-top-color"],
  ),
  (
    "border-right",
    ["border-right-width", "border-right-style", "border-right-color"],
  ),
  (
    "border-bottom",
    ["border-bottom-width", "border-bottom-style", "border-bottom-color"],
  ),
  (
    "border-left",
    ["border-left-width", "border-left-style", "border-left-color"],
  ),
  (
    "border",
    ["border-width", "border-style", "border-color", "border-image"],
  ),
  (
    "border-radius",
    [
      "border-top-left-radius",
      "border-top-right-radius",
      "border-bottom-right-radius",
      "border-bottom-left-radius",
    ],
  ),
  /* CSS Borders and Box Decorations L4 (task 2, css-grammar-draft-properties):
     https://drafts.csswg.org/css-borders-4/ */
  (
    "border-top-radius",
    ["border-top-left-radius", "border-top-right-radius"],
  ),
  (
    "border-right-radius",
    ["border-top-right-radius", "border-bottom-right-radius"],
  ),
  (
    "border-bottom-radius",
    ["border-bottom-left-radius", "border-bottom-right-radius"],
  ),
  (
    "border-left-radius",
    ["border-top-left-radius", "border-bottom-left-radius"],
  ),
  (
    "border-block-start-radius",
    ["border-start-start-radius", "border-start-end-radius"],
  ),
  (
    "border-block-end-radius",
    ["border-end-start-radius", "border-end-end-radius"],
  ),
  (
    "border-inline-start-radius",
    ["border-start-start-radius", "border-end-start-radius"],
  ),
  (
    "border-inline-end-radius",
    ["border-start-end-radius", "border-end-end-radius"],
  ),
  (
    "border-block-clip",
    ["border-block-start-clip", "border-block-end-clip"],
  ),
  (
    "border-inline-clip",
    ["border-inline-start-clip", "border-inline-end-clip"],
  ),
  (
    "border-clip",
    [
      "border-top-clip",
      "border-right-clip",
      "border-bottom-clip",
      "border-left-clip",
    ],
  ),
  (
    "border-image",
    [
      "border-image-source",
      "border-image-slice",
      "border-image-width",
      "border-image-outset",
      "border-image-repeat",
    ],
  ),
  (
    "border-block",
    ["border-block-width", "border-block-style", "border-block-color"],
  ),
  (
    "border-block-width",
    ["border-block-start-width", "border-block-end-width"],
  ),
  (
    "border-block-style",
    ["border-block-start-style", "border-block-end-style"],
  ),
  (
    "border-block-color",
    ["border-block-start-color", "border-block-end-color"],
  ),
  (
    "border-block-start",
    [
      "border-block-start-width",
      "border-block-start-style",
      "border-block-start-color",
    ],
  ),
  (
    "border-block-end",
    [
      "border-block-end-width",
      "border-block-end-style",
      "border-block-end-color",
    ],
  ),
  (
    "border-inline",
    ["border-inline-width", "border-inline-style", "border-inline-color"],
  ),
  (
    "border-inline-width",
    ["border-inline-start-width", "border-inline-end-width"],
  ),
  (
    "border-inline-style",
    ["border-inline-start-style", "border-inline-end-style"],
  ),
  (
    "border-inline-color",
    ["border-inline-start-color", "border-inline-end-color"],
  ),
  (
    "border-inline-start",
    [
      "border-inline-start-width",
      "border-inline-start-style",
      "border-inline-start-color",
    ],
  ),
  (
    "border-inline-end",
    [
      "border-inline-end-width",
      "border-inline-end-style",
      "border-inline-end-color",
    ],
  ),
  ("outline", ["outline-color", "outline-style", "outline-width"]),
  (
    "background",
    [
      "background-image",
      "background-position",
      "background-size",
      "background-repeat",
      "background-origin",
      "background-clip",
      "background-attachment",
      "background-color",
    ],
  ),
  (
    "background-position",
    ["background-position-x", "background-position-y"],
  ),
  (
    "font",
    [
      "font-style",
      "font-variant",
      "font-weight",
      "font-stretch",
      "font-size",
      "line-height",
      "font-family",
      "font-feature-settings",
      "font-kerning",
      "font-language-override",
      "font-optical-sizing",
      "font-size-adjust",
      "font-variant-alternates",
      "font-variant-caps",
      "font-variant-east-asian",
      "font-variant-emoji",
      "font-variant-ligatures",
      "font-variant-numeric",
      "font-variant-position",
      "font-variation-settings",
    ],
  ),
  (
    "list-style",
    ["list-style-type", "list-style-position", "list-style-image"],
  ),
  (
    "text-decoration",
    [
      "text-decoration-line",
      "text-decoration-style",
      "text-decoration-color",
      "text-decoration-thickness",
    ],
  ),
  ("text-emphasis", ["text-emphasis-color", "text-emphasis-style"]),
  (
    "transition",
    [
      "transition-property",
      "transition-duration",
      "transition-timing-function",
      "transition-delay",
      "transition-behavior",
    ],
  ),
  (
    "animation",
    [
      "animation-name",
      "animation-duration",
      "animation-timing-function",
      "animation-delay",
      "animation-iteration-count",
      "animation-direction",
      "animation-fill-mode",
      "animation-play-state",
      "animation-timeline",
      "animation-composition",
      "animation-range",
    ],
  ),
  ("animation-range", ["animation-range-start", "animation-range-end"]),
  (
    "grid-template",
    ["grid-template-rows", "grid-template-columns", "grid-template-areas"],
  ),
  (
    "grid",
    [
      "grid-template",
      "grid-auto-rows",
      "grid-auto-columns",
      "grid-auto-flow",
    ],
  ),
  ("grid-row", ["grid-row-start", "grid-row-end"]),
  ("grid-column", ["grid-column-start", "grid-column-end"]),
  ("grid-area", ["grid-row", "grid-column"]),
  ("gap", ["row-gap", "column-gap"]),
  ("place-content", ["align-content", "justify-content"]),
  ("place-items", ["align-items", "justify-items"]),
  ("place-self", ["align-self", "justify-self"]),
  ("overflow", ["overflow-x", "overflow-y"]),
  (
    "overflow-clip-margin",
    [
      "overflow-clip-margin-top",
      "overflow-clip-margin-right",
      "overflow-clip-margin-bottom",
      "overflow-clip-margin-left",
    ],
  ),
  (
    "overflow-clip-margin-block",
    ["overflow-clip-margin-block-start", "overflow-clip-margin-block-end"],
  ),
  (
    "overflow-clip-margin-inline",
    ["overflow-clip-margin-inline-start", "overflow-clip-margin-inline-end"],
  ),
  ("flex", ["flex-grow", "flex-shrink", "flex-basis"]),
  ("flex-flow", ["flex-direction", "flex-wrap"]),
  ("columns", ["column-width", "column-count", "column-height"]),
  /* Task 2 (css-grammar-draft-properties): CSS Box Sizing L4, CSS Rhythmic
     Sizing L1. */
  ("max-size", ["max-width", "max-height"]),
  ("min-size", ["min-width", "min-height"]),
  (
    "block-step",
    [
      "block-step-size",
      "block-step-insert",
      "block-step-align",
      "block-step-round",
    ],
  ),
  (
    "column-rule",
    ["column-rule-color", "column-rule-style", "column-rule-width"],
  ),
  /* CSS Gaps L1: https://drafts.csswg.org/css-gaps-1/ */
  (
    "column-rule-inset-cap",
    ["column-rule-inset-cap-start", "column-rule-inset-cap-end"],
  ),
  (
    "column-rule-inset-junction",
    ["column-rule-inset-junction-start", "column-rule-inset-junction-end"],
  ),
  (
    "column-rule-inset-start",
    ["column-rule-inset-cap-start", "column-rule-inset-junction-start"],
  ),
  (
    "column-rule-inset-end",
    ["column-rule-inset-cap-end", "column-rule-inset-junction-end"],
  ),
  (
    "column-rule-inset",
    ["column-rule-inset-cap", "column-rule-inset-junction"],
  ),
  ("row-rule", ["row-rule-color", "row-rule-style", "row-rule-width"]),
  (
    "row-rule-inset-cap",
    ["row-rule-inset-cap-start", "row-rule-inset-cap-end"],
  ),
  (
    "row-rule-inset-junction",
    ["row-rule-inset-junction-start", "row-rule-inset-junction-end"],
  ),
  (
    "row-rule-inset-start",
    ["row-rule-inset-cap-start", "row-rule-inset-junction-start"],
  ),
  (
    "row-rule-inset-end",
    ["row-rule-inset-cap-end", "row-rule-inset-junction-end"],
  ),
  ("row-rule-inset", ["row-rule-inset-cap", "row-rule-inset-junction"]),
  ("rule", ["column-rule", "row-rule"]),
  ("rule-break", ["column-rule-break", "row-rule-break"]),
  ("rule-color", ["column-rule-color", "row-rule-color"]),
  ("rule-style", ["column-rule-style", "row-rule-style"]),
  ("rule-width", ["column-rule-width", "row-rule-width"]),
  (
    "rule-visibility-items",
    ["column-rule-visibility-items", "row-rule-visibility-items"],
  ),
  ("rule-inset-cap", ["column-rule-inset-cap", "row-rule-inset-cap"]),
  (
    "rule-inset-junction",
    ["column-rule-inset-junction", "row-rule-inset-junction"],
  ),
  ("rule-inset-end", ["column-rule-inset-end", "row-rule-inset-end"]),
  ("rule-inset", ["column-rule-inset", "row-rule-inset"]),
  (
    "rule-inset-start",
    [
      "column-rule-inset-cap-start",
      "column-rule-inset-junction-start",
      "row-rule-inset-cap-start",
      "row-rule-inset-junction-start",
    ],
  ),
  (
    "mask",
    [
      "mask-image",
      "mask-mode",
      "mask-position",
      "mask-size",
      "mask-repeat",
      "mask-origin",
      "mask-clip",
      "mask-composite",
      "mask-border",
    ],
  ),
  (
    "mask-border",
    [
      "mask-border-mode",
      "mask-border-outset",
      "mask-border-repeat",
      "mask-border-slice",
      "mask-border-source",
      "mask-border-width",
    ],
  ),
  ("container", ["container-name", "container-type"]),
  (
    "offset",
    [
      "offset-position",
      "offset-path",
      "offset-distance",
      "offset-rotate",
      "offset-anchor",
    ],
  ),
  (
    "-webkit-border-before",
    [
      "-webkit-border-before-color",
      "-webkit-border-before-style",
      "-webkit-border-before-width",
    ],
  ),
  (
    "-webkit-mask",
    [
      "-webkit-mask-attachment",
      "-webkit-mask-clip",
      "-webkit-mask-composite",
      "-webkit-mask-image",
      "-webkit-mask-origin",
      "-webkit-mask-position",
      "-webkit-mask-repeat",
      "-webkit-mask-size",
    ],
  ),
  (
    "-webkit-mask-position",
    ["-webkit-mask-position-x", "-webkit-mask-position-y"],
  ),
  (
    "-webkit-mask-repeat",
    ["-webkit-mask-repeat-x", "-webkit-mask-repeat-y"],
  ),
  (
    "-moz-outline-radius",
    [
      "-moz-outline-radius-bottomleft",
      "-moz-outline-radius-bottomright",
      "-moz-outline-radius-topleft",
      "-moz-outline-radius-topright",
    ],
  ),
];

let sort_pair = ((name, children)) => (
  name,
  List.sort(String.compare, children),
);
let normalize = list => list |> List.map(sort_pair) |> List.sort(compare);

let snapshot_tests: tests = [
  test("registered shorthand count matches the pinned list", _ => {
    check(
      ~__POS__,
      Alcotest.int,
      List.length(all_shorthands),
      List.length(expected_shorthands),
    )
  }),
  test(
    "every registered shorthand's longhands match the pinned, spec-cited \
        list exactly",
    _ => {
    check(
      ~__POS__,
      Alcotest.list(
        Alcotest.pair(Alcotest.string, Alcotest.list(Alcotest.string)),
      ),
      normalize(all_shorthands),
      normalize(expected_shorthands),
    )
  }),
];

/* --- Aliases: true 1:1 property-name synonyms, not shorthands --------- */

let all_aliases = Parser.aliases();

let expected_aliases: list((string, string)) = [
  ("font-width", "font-stretch"),
  ("grid-gap", "gap"),
  ("grid-row-gap", "row-gap"),
  ("grid-column-gap", "column-gap"),
  ("word-wrap", "overflow-wrap"),
];

let alias_tests: tests = [
  test(
    "every alias's own name and canonical name are both registered \
        properties",
    _ => {
    let unknown =
      all_aliases
      |> List.concat_map(((name, canonical)) => [name, canonical])
      |> List.sort_uniq(String.compare)
      |> List.filter(name => !List.mem(name, all_property_names));
    check(~__POS__, Alcotest.list(Alcotest.string), unknown, []);
  }),
  test("no duplicate alias registrations", _ => {
    let names = all_aliases |> List.map(((name, _)) => name);
    check(
      ~__POS__,
      Alcotest.int,
      List.length(List.sort_uniq(String.compare, names)),
      List.length(names),
    );
  }),
  test("the registered aliases match the pinned, spec-cited list exactly", _ => {
    check(
      ~__POS__,
      Alcotest.list(Alcotest.pair(Alcotest.string, Alcotest.string)),
      List.sort(compare, all_aliases),
      List.sort(compare, expected_aliases),
    )
  }),
];

let tests: tests =
  List.concat([coverage_tests, cycle_tests, snapshot_tests, alias_tests]);
