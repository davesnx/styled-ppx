Empty `[%cx2 {||}]` bindings are minted as a unique className handle
with no extracted CSS rule. Consumer `&.$(name)` and `& .$(name)`
selectors must resolve to that handle, not silently drop.

Without this, the bug shape is: `let m = [%cx2 {||}]` registers `m -> []`
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

The empty binding `active` mints `css-0-active` (hash of empty + label).
No `[@@@css ...]` is emitted for it — there's nothing to write. The
consumer `container`'s nested rule keeps the `.css-0-active` qualifier,
so `background: blue` only applies when the class is actually present
on the element.

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".css-1443u2l-container{background:red;}"];
  [@css ".css-g57662-container.css-0-active{background:blue;}"];
  [@css ".css-q5fqw0-card{padding:1rem;}"];
  [@css ".css-19ehxda-card.css-0-selected{border-color:blue;}"];
  [@css ".css-17nqvvb-card.css-0-highlighted{background:yellow;}"];
  [@css ".css-k008qs-panel{display:flex;}"];
  [@css ".css-62yfsj-panel .css-0-actionButton{color:black;}"];
  [@css.bindings
    [
      ("Input.active", "css-0-active"),
      ("Input.container", "css-1443u2l-container css-g57662-container"),
      ("Input.selected", "css-0-selected"),
      ("Input.highlighted", "css-0-highlighted"),
      ("Input.card", "css-q5fqw0-card css-19ehxda-card css-17nqvvb-card"),
      ("Input.actionButton", "css-0-actionButton"),
      ("Input.panel", "css-k008qs-panel css-62yfsj-panel"),
    ]
  ];
  
  let active = CSS.make("css-0-active", []);
  
  let container = CSS.make("css-1443u2l-container css-g57662-container", []);
  
  let selected = CSS.make("css-0-selected", []);
  let highlighted = CSS.make("css-0-highlighted", []);
  
  let card = CSS.make("css-q5fqw0-card css-19ehxda-card css-17nqvvb-card", []);
  
  let actionButton = CSS.make("css-0-actionButton", []);
  
  let panel = CSS.make("css-k008qs-panel css-62yfsj-panel", []);
  
  let _ = (active, container, selected, highlighted, card, actionButton, panel);

  $ dune build
