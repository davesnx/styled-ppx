Functional pseudo-elements (`::part()`, `::slotted()`) and the Selectors
Level 4 "of S" form of `:nth-child()`/`:nth-last-child()` were both
unparseable: the lexer only
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
  [@css
    (
      "._a_5r7jx4en809::part(foo){color:red;}",
      "_a_5r7jx4en809",
      "0,1,1 own::part(foo)",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_wmvcz4ee6d9::slotted(.bar){color:blue;}",
      "_a_wmvcz4ee6d9",
      "0,1,1 own::slotted(.bar)",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_da0h14e51rt:nth-child(2n+1 of .x){color:green;}",
      "_a_da0h14e51rt",
      "0,3,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_kj3e34es5ty:nth-last-child(odd of .a,.b){color:yellow;}",
      "_a_kj3e34es5ty",
      "0,3,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css.bindings
    [
      ("Input._part", "_id_1munzu", "_a_5r7jx4en809"),
      ("Input._slotted", "_id_2rmphz", "_a_wmvcz4ee6d9"),
      ("Input._nth_child_of", "_id_yct85k", "_a_da0h14e51rt"),
      ("Input._nth_last_child_of_list", "_id_xd3wqi", "_a_kj3e34es5ty"),
    ]
  ];
  [@css.blocks
    [
      (7, "_id_1munzu", [0]),
      (13, "_id_2rmphz", [1]),
      (19, "_id_yct85k", [2]),
      (25, "_id_xd3wqi", [3]),
    ]
  ];
  
  let _part = CSS.make("label:_part _id_1munzu _a_5r7jx4en809", []);
  
  let _slotted = CSS.make("label:_slotted _id_2rmphz _a_wmvcz4ee6d9", []);
  
  let _nth_child_of =
    CSS.make("label:_nth_child_of _id_yct85k _a_da0h14e51rt", []);
  
  let _nth_last_child_of_list =
    CSS.make("label:_nth_last_child_of_list _id_xd3wqi _a_kj3e34es5ty", []);

  $ dune build
