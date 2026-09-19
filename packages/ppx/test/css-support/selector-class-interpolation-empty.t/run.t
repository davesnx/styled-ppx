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
  [@css ".css-1443u2l-container{background:red;}"];
  [@css ".css-g57662-container.cid-1ofey90{background:blue;}"];
  [@css ".css-q5fqw0-card{padding:1rem;}"];
  [@css ".css-19ehxda-card.cid-okzmy{border-color:blue;}"];
  [@css ".css-17nqvvb-card.cid-1jjszpn{background:yellow;}"];
  [@css ".css-k008qs-panel{display:flex;}"];
  [@css ".css-62yfsj-panel .cid-rmf27x{color:black;}"];
  [@css.bindings
    [
      ("Input.active", "cid-1ofey90", ""),
      (
        "Input.container",
        "cid-paugdl",
        "css-1443u2l-container css-g57662-container",
      ),
      ("Input.selected", "cid-okzmy", ""),
      ("Input.highlighted", "cid-1jjszpn", ""),
      (
        "Input.card",
        "cid-cpyuub",
        "css-q5fqw0-card css-19ehxda-card css-17nqvvb-card",
      ),
      ("Input.actionButton", "cid-rmf27x", ""),
      ("Input.panel", "cid-1qtuyxa", "css-k008qs-panel css-62yfsj-panel"),
    ]
  ];
  
  let active = CSS.make("cid-1ofey90", []);
  
  let container =
    CSS.make("cid-paugdl css-1443u2l-container css-g57662-container", []);
  
  let selected = CSS.make("cid-okzmy", []);
  let highlighted = CSS.make("cid-1jjszpn", []);
  
  let card =
    CSS.make(
      "cid-cpyuub css-q5fqw0-card css-19ehxda-card css-17nqvvb-card",
      [],
    );
  
  let actionButton = CSS.make("cid-rmf27x", []);
  
  let panel = CSS.make("cid-1qtuyxa css-k008qs-panel css-62yfsj-panel", []);
  
  let _ = (active, container, selected, highlighted, card, actionButton, panel);

  $ dune build
