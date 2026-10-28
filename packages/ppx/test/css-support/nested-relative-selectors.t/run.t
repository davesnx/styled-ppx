This test ensures CSS Nesting's relative-selector shorthand (a nested rule's
prelude starting with a bare combinator, `> .child`/`+ .sib`/`~ .sib`) parses
and resolves `&` identically to writing the combinator after an explicit `&`.
Each pair below must render and hash to the same atom.

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
      "._a_hfkiz4e0lf8 .parent > .child{color:red;}",
      "_a_hfkiz4e0lf8",
      "0,3,0 & .parent > .child",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_oicak4emckf .parent + .sibling{color:red;}",
      "_a_oicak4emckf",
      "0,3,0 & .parent + .sibling",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ehmrb4ewq26 .parent ~ .sibling{color:red;}",
      "_a_ehmrb4ewq26",
      "0,3,0 & .parent ~ .sibling",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_f8a2u4eqd0b .parent > .a.b:hover{color:red;}",
      "_a_f8a2u4eqd0b",
      "0,5,0 & .parent > .a.b:hover",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ew2o54eviu8 .parent > .a{color:red;}",
      "_a_ew2o54eviu8",
      "0,3,0 & .parent > .a",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ornrm4e0uum .parent + .b{color:red;}",
      "_a_ornrm4e0uum",
      "0,3,0 & .parent + .b",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "@media (min-width: 1px) {._a_7gls64e9ouy .parent > .child{color:red;}}",
      "_a_7gls64e9ouy",
      "0,3,0 & .parent > .child",
      "158",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (7, "", [0]),
      (8, "", [0]),
      (10, "", [1]),
      (11, "", [1]),
      (13, "", [2]),
      (14, "", [2]),
      (17, "", [3]),
      (18, "", [3]),
      (21, "", [4, 5]),
      (22, "", [4, 5]),
      (25, "", [6]),
      (26, "", [6]),
    ]
  ];
  
  CSS.make("_a_hfkiz4e0lf8", []);
  CSS.make("_a_hfkiz4e0lf8", []);
  
  CSS.make("_a_oicak4emckf", []);
  CSS.make("_a_oicak4emckf", []);
  
  CSS.make("_a_ehmrb4ewq26", []);
  CSS.make("_a_ehmrb4ewq26", []);
  
  CSS.make("_a_f8a2u4eqd0b", []);
  CSS.make("_a_f8a2u4eqd0b", []);
  
  CSS.make("_a_ew2o54eviu8 _a_ornrm4e0uum", []);
  CSS.make("_a_ew2o54eviu8 _a_ornrm4e0uum", []);
  
  CSS.make("_a_7gls64e9ouy", []);
  CSS.make("_a_7gls64e9ouy", []);
