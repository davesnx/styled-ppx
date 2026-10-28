Empty `[%css {||}]` bindings are minted as a unique className handle
with no extracted CSS rule. Consumer `&.$(name)` and `& .$(name)`
selectors must resolve to that handle, not silently drop.

Without this, the bug shape is: `let m = [%css {||}]` registers `m -> []`
in the per-file class registry, then `&.$(m) { ... }` resolves to an
empty class chain (`List.map(_, []) = []`), the `&.$(m)` qualifier is
gone from the extracted selector, and the rule applies unconditionally
to every consumer.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

The empty binding `active` mints only its identity class (`id-...`,
independent of content - see `Hash_class.identity_class`); its
`class_string` in `[@@@css.bindings ...]` is `""` and no `[@@@css ...]`
rule is emitted for it. The consumer `container`'s nested rule keeps a
`.id-...` qualifier, so `background: blue` only applies when the class
is actually present on the element.

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "._a_393u2l{background:red;}"];
  [@css "._a_dp7m3390ev8._id_djcvv9{background:blue;}"];
  [@css "._a_94fqw0{padding:1rem;}"];
  [@css "._a_kbodp3h0ef5hi8t._id_1nlj7be{border-color:blue;}"];
  [@css "._a_r1su339tl93._id_79qigv{background:yellow;}"];
  [@css "._a_5r08qs{display:flex;}"];
  [@css "._a_gmy164etpbt ._id_g2b8cb{color:black;}"];
  [@css.bindings
    [
      ("Input.active", "_id_djcvv9", ""),
      ("Input.container", "_id_ls0dio", "_a_393u2l _a_dp7m3390ev8"),
      ("Input.selected", "_id_1nlj7be", ""),
      ("Input.highlighted", "_id_79qigv", ""),
      (
        "Input.card",
        "_id_10ieij6",
        "_a_94fqw0 _a_kbodp3h0ef5hi8t _a_r1su339tl93",
      ),
      ("Input.actionButton", "_id_g2b8cb", ""),
      ("Input.panel", "_id_1w26e1r", "_a_5r08qs _a_gmy164etpbt"),
    ]
  ];
  [@css.blocks
    [
      (15, "_id_djcvv9"),
      (18, "_id_ls0dio _a_393u2l _a_dp7m3390ev8"),
      (31, "_id_1nlj7be"),
      (32, "_id_79qigv"),
      (35, "_id_10ieij6 _a_94fqw0 _a_kbodp3h0ef5hi8t _a_r1su339tl93"),
      (51, "_id_g2b8cb"),
      (54, "_id_1w26e1r _a_5r08qs _a_gmy164etpbt"),
    ]
  ];
  
  let active = CSS.make("label:active _id_djcvv9", []);
  
  let container =
    CSS.make("label:container _id_ls0dio _a_393u2l _a_dp7m3390ev8", []);
  
  let selected = CSS.make("label:selected _id_1nlj7be", []);
  let highlighted = CSS.make("label:highlighted _id_79qigv", []);
  
  let card =
    CSS.make(
      "label:card _id_10ieij6 _a_94fqw0 _a_kbodp3h0ef5hi8t _a_r1su339tl93",
      [],
    );
  
  let actionButton = CSS.make("label:actionButton _id_g2b8cb", []);
  
  let panel = CSS.make("label:panel _id_1w26e1r _a_5r08qs _a_gmy164etpbt", []);
  
  let _ = (active, container, selected, highlighted, card, actionButton, panel);

  $ dune build
