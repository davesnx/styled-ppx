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
  [@css "._a_3lv8v39725c._id_1ofey90{background:blue;}"];
  [@css "._a_94fqw0{padding:1rem;}"];
  [@css "._a_4p0n23hef5cnv6._id_okzmy{border-color:blue;}"];
  [@css "._a_rmeji39asz5._id_1jjszpn{background:yellow;}"];
  [@css "._a_5r08qs{display:flex;}"];
  [@css "._a_2nhg94em44p ._id_rmf27x{color:black;}"];
  [@css.bindings
    [
      ("Input.active", "_id_1ofey90", ""),
      ("Input.container", "_id_paugdl", "_a_393u2l _a_3lv8v39725c"),
      ("Input.selected", "_id_okzmy", ""),
      ("Input.highlighted", "_id_1jjszpn", ""),
      (
        "Input.card",
        "_id_cpyuub",
        "_a_94fqw0 _a_4p0n23hef5cnv6 _a_rmeji39asz5",
      ),
      ("Input.actionButton", "_id_rmf27x", ""),
      ("Input.panel", "_id_1qtuyxa", "_a_5r08qs _a_2nhg94em44p"),
    ]
  ];
  
  let active = CSS.make("label:active _id_1ofey90", []);
  
  let container =
    CSS.make("label:container _id_paugdl _a_393u2l _a_3lv8v39725c", []);
  
  let selected = CSS.make("label:selected _id_okzmy", []);
  let highlighted = CSS.make("label:highlighted _id_1jjszpn", []);
  
  let card =
    CSS.make(
      "label:card _id_cpyuub _a_94fqw0 _a_4p0n23hef5cnv6 _a_rmeji39asz5",
      [],
    );
  
  let actionButton = CSS.make("label:actionButton _id_rmf27x", []);
  
  let panel = CSS.make("label:panel _id_1qtuyxa _a_5r08qs _a_2nhg94em44p", []);
  
  let _ = (active, container, selected, highlighted, card, actionButton, panel);

  $ dune build
