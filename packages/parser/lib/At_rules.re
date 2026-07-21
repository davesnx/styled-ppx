/* Single source of truth for styled-ppx's at-rule classification.

   Consumed by:
   - [Resolve] (this package): the flattener passes descriptor blocks
     through verbatim.
   - [Css_file] in the PPX: only conditional group rules can be atomized
     in [%css] / [%styled.<tag>]; a blockless conditional group rule is
     rejected in [%styled.global].
   - [registry_dump] (styled-ppx.css-grammar-parser, re-exported as
     [Css_grammar.At_rules]): dumps [inventory] so the coverage oracle
     (scripts/css-oracle/report.mjs) derives the "At-rules" table of
     packages/css-grammar/data/coverage.md from code instead of a
     hand-maintained map. */

type classification =
  /* Conditional group rules: the condition distributes over the block, so
     [%css] atomizes them; also accepted in [%styled.global]. */
  | Atomized
  /* `@keyframes`: first-class via [%keyframe]; [%css] redirects there.
     Passes through verbatim in [%styled.global]. */
  | Keyframe_extension
  /* Blocks hold descriptors, not style rules: [%styled.global] passes them
     through verbatim; rejected in [%css]. */
  | Descriptor_passthrough
  /* Statement / grouping rules with no dedicated handling: rejected in
     [%css]; [%styled.global]'s flattener passes them through structurally
     (statement forms verbatim, block forms flattened). */
  | Global_passthrough;

let conditional_group_names = [
  "media",
  "supports",
  "container",
  "starting-style",
];

let descriptor_names = [
  "font-face",
  "property",
  "counter-style",
  "page",
  "font-palette-values",
  "font-feature-values",
  "view-transition",
];

/* NOT a filter: [Resolve]'s default arms pass ANY statement/group at-rule
   through structurally. This inventory names the spec at-rules known to
   work end to end that way; it exists for the coverage oracle only. */
let global_passthrough_names = [
  "import",
  "charset",
  "namespace",
  "layer",
  "scope",
];

let is_conditional_group = name =>
  List.mem(String.lowercase_ascii(name), conditional_group_names);

/* Blocks hold descriptors/keyframe selectors, not style rules. */
let is_descriptor_passthrough = name =>
  switch (String.lowercase_ascii(name)) {
  | "keyframes" => true
  | name => List.mem(name, descriptor_names)
  };

let inventory: list((string, classification)) =
  List.map(name => (name, Atomized), conditional_group_names)
  @ [("keyframes", Keyframe_extension)]
  @ List.map(name => (name, Descriptor_passthrough), descriptor_names)
  @ List.map(name => (name, Global_passthrough), global_passthrough_names);
