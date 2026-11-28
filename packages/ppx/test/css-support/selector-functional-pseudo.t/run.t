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
  [@css ".css-ivpc7cw::part(foo){color:red;}"];
  [@css ".css-ivpclzn::slotted(.bar){color:blue;}"];
  [@css ".css-ivpcgxj:nth-child(2n+1 of .x){color:green;}"];
  [@css ".css-ivpcuhq:nth-last-child(odd of .a,.b){color:yellow;}"];
  [@css.classes
    [
      ("css-ivpc7cw", 0, "Input._part", "input.re", 9, 2, 10, 0),
      ("css-ivpclzn", 1, "Input._slotted", "input.re", 15, 2, 16, 0),
      ("css-ivpcgxj", 2, "Input._nth_child_of", "input.re", 21, 2, 22, 0),
      (
        "css-ivpcuhq",
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
      ("Input._part", "css-ivpc7cw"),
      ("Input._slotted", "css-ivpclzn"),
      ("Input._nth_child_of", "css-ivpcgxj"),
      ("Input._nth_last_child_of_list", "css-ivpcuhq"),
    ]
  ];
  
  let _part = CSS.make("css-ivpc7cw", []);
  
  let _slotted = CSS.make("css-ivpclzn", []);
  
  let _nth_child_of = CSS.make("css-ivpcgxj", []);
  
  let _nth_last_child_of_list = CSS.make("css-ivpcuhq", []);

  $ dune build
