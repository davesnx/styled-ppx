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
  [@css ".css-1c5u7cw::part(foo){color:red;}"];
  [@css ".css-onulzn::slotted(.bar){color:blue;}"];
  [@css ".css-67wgxj:nth-child(2n+1 of .x){color:green;}"];
  [@css ".css-175fuhq:nth-last-child(odd of .a,.b){color:yellow;}"];
  [@css.classes
    [
      ("css-1c5u7cw", 0, "Input._part", "input.re", 9, 2, 10, 0),
      ("css-onulzn", 1, "Input._slotted", "input.re", 15, 2, 16, 0),
      ("css-67wgxj", 2, "Input._nth_child_of", "input.re", 21, 2, 22, 0),
      (
        "css-175fuhq",
        3,
        "Input._nth_last_child_of_list",
        "input.re",
        27,
        2,
        28,
        0,
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input._part", "css-1c5u7cw"),
      ("Input._slotted", "css-onulzn"),
      ("Input._nth_child_of", "css-67wgxj"),
      ("Input._nth_last_child_of_list", "css-175fuhq"),
    ]
  ];
  
  let _part = CSS.make("css-1c5u7cw", []);
  
  let _slotted = CSS.make("css-onulzn", []);
  
  let _nth_child_of = CSS.make("css-67wgxj", []);
  
  let _nth_last_child_of_list = CSS.make("css-175fuhq", []);

  $ dune build
