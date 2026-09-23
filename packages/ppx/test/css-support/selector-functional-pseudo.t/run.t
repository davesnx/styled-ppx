Functional pseudo-elements (`::part()`, `::slotted()`) and the Selectors
Level 4 "of S" form of `:nth-child()`/`:nth-last-child()` were both
unparseable (.workplace/docs/parser-audit-defects.md #7, #8): the lexer only
special-cases `nth-*` names for An+B payloads, so no other identifier
followed by `(` ever reached a pseudo-element parser, and `parse_nth_payload`
had no branch for the `of` keyword.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".css-1scn809-_part::part(foo){color:red;}"];
  [@css ".css-upe6d9-_slotted::slotted(.bar){color:blue;}"];
  [@css ".css-1uy51rt-_nth_child_of:nth-child(2n+1 of .x){color:green;}"];
  [@css
    ".css-1qws5ty-_nth_last_child_of_list:nth-last-child(odd of .a,.b){color:yellow;}"
  ];
  [@css.bindings
    [
      ("Input._part", "css-1scn809-_part"),
      ("Input._slotted", "css-upe6d9-_slotted"),
      ("Input._nth_child_of", "css-1uy51rt-_nth_child_of"),
      ("Input._nth_last_child_of_list", "css-1qws5ty-_nth_last_child_of_list"),
    ]
  ];
  
  let _part = CSS.make("css-1scn809-_part", []);
  
  let _slotted = CSS.make("css-upe6d9-_slotted", []);
  
  let _nth_child_of = CSS.make("css-1uy51rt-_nth_child_of", []);
  
  let _nth_last_child_of_list =
    CSS.make("css-1qws5ty-_nth_last_child_of_list", []);

  $ dune build
