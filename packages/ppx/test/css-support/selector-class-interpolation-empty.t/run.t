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
  [@css ".a-393u2l{background:red;}"];
  [@css ".a-pwpfa397662.id-1ofey90{background:blue;}"];
  [@css ".a-94fqw0{padding:1rem;}"];
  [@css ".a-ezau73hef5hxda.id-okzmy{border-color:blue;}"];
  [@css ".a-gk5o139qvvb.id-1jjszpn{background:yellow;}"];
  [@css ".a-5r08qs{display:flex;}"];
  [@css ".a-kpacu4eyfsj .id-rmf27x{color:black;}"];
  [@css.bindings
    [
      ("Input.active", "id-1ofey90", ""),
      ("Input.container", "id-paugdl", "a-393u2l a-pwpfa397662"),
      ("Input.selected", "id-okzmy", ""),
      ("Input.highlighted", "id-1jjszpn", ""),
      ("Input.card", "id-cpyuub", "a-94fqw0 a-ezau73hef5hxda a-gk5o139qvvb"),
      ("Input.actionButton", "id-rmf27x", ""),
      ("Input.panel", "id-1qtuyxa", "a-5r08qs a-kpacu4eyfsj"),
    ]
  ];
  
  let active = CSS.make("label:active id-1ofey90", []);
  
  let container =
    CSS.make("label:container id-paugdl a-393u2l a-pwpfa397662", []);
  
  let selected = CSS.make("label:selected id-okzmy", []);
  let highlighted = CSS.make("label:highlighted id-1jjszpn", []);
  
  let card =
    CSS.make(
      "label:card id-cpyuub a-94fqw0 a-ezau73hef5hxda a-gk5o139qvvb",
      [],
    );
  
  let actionButton = CSS.make("label:actionButton id-rmf27x", []);
  
  let panel = CSS.make("label:panel id-1qtuyxa a-5r08qs a-kpacu4eyfsj", []);
  
  let _ = (active, container, selected, highlighted, card, actionButton, panel);

  $ dune build
