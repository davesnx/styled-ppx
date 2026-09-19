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

The empty binding `active` mints only its identity class (`cid-...`,
independent of content - see `Hash_class.identity_class`); its
`class_string` in `[@@@css.bindings ...]` is `""` and no `[@@@css ...]`
rule is emitted for it. The consumer `container`'s nested rule keeps a
`.cid-...` qualifier, so `background: blue` only applies when the class
is actually present on the element.

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".css-1443u2l{background:red;}"];
  [@css ".css-g57662.cid-1ofey90{background:blue;}"];
  [@css ".css-q5fqw0{padding:1rem;}"];
  [@css ".css-19ehxda.cid-okzmy{border-color:blue;}"];
  [@css ".css-17nqvvb.cid-1jjszpn{background:yellow;}"];
  [@css ".css-k008qs{display:flex;}"];
  [@css ".css-62yfsj .cid-rmf27x{color:black;}"];
  [@css.bindings
    [
      ("Input.active", "cid-1ofey90", ""),
      ("Input.container", "cid-paugdl", "css-1443u2l css-g57662"),
      ("Input.selected", "cid-okzmy", ""),
      ("Input.highlighted", "cid-1jjszpn", ""),
      ("Input.card", "cid-cpyuub", "css-q5fqw0 css-19ehxda css-17nqvvb"),
      ("Input.actionButton", "cid-rmf27x", ""),
      ("Input.panel", "cid-1qtuyxa", "css-k008qs css-62yfsj"),
    ]
  ];
  
  let active = CSS.make("cx-active cid-1ofey90", []);
  
  let container =
    CSS.make("cx-container cid-paugdl css-1443u2l css-g57662", []);
  
  let selected = CSS.make("cx-selected cid-okzmy", []);
  let highlighted = CSS.make("cx-highlighted cid-1jjszpn", []);
  
  let card =
    CSS.make("cx-card cid-cpyuub css-q5fqw0 css-19ehxda css-17nqvvb", []);
  
  let actionButton = CSS.make("cx-actionButton cid-rmf27x", []);
  
  let panel = CSS.make("cx-panel cid-1qtuyxa css-k008qs css-62yfsj", []);
  
  let _ = (active, container, selected, highlighted, card, actionButton, panel);

  $ dune build
