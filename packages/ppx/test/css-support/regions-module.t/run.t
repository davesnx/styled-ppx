This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

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
    ("._a_ftcf4s{flow-from:none;}", "_a_ftcf4s", "0,1,0 own", "569", 1, false)
  ];
  [@css
    (
      "._a_ftxqeo{flow-from:named-flow;}",
      "_a_ftxqeo",
      "0,1,0 own",
      "569",
      1,
      false,
    )
  ];
  [@css
    ("._a_fuxqr6{flow-into:none;}", "_a_fuxqr6", "0,1,0 own", "570", 1, false)
  ];
  [@css
    (
      "._a_fuywcc{flow-into:named-flow;}",
      "_a_fuywcc",
      "0,1,0 own",
      "570",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_fu8xd9{flow-into:named-flow element;}",
      "_a_fu8xd9",
      "0,1,0 own",
      "570",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_futzaz{flow-into:named-flow content;}",
      "_a_futzaz",
      "0,1,0 own",
      "570",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gc2igy{region-fragment:auto;}",
      "_a_gc2igy",
      "0,1,0 own",
      "588",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_gc95p4{region-fragment:break;}",
      "_a_gc95p4",
      "0,1,0 own",
      "588",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (2, "", [0]),
      (3, "", [1]),
      (4, "", [2]),
      (5, "", [3]),
      (6, "", [4]),
      (7, "", [5]),
      (8, "", [6]),
      (9, "", [7]),
    ]
  ];
  
  CSS.make("_a_ftcf4s", []);
  CSS.make("_a_ftxqeo", []);
  CSS.make("_a_fuxqr6", []);
  CSS.make("_a_fuywcc", []);
  CSS.make("_a_fu8xd9", []);
  CSS.make("_a_futzaz", []);
  CSS.make("_a_gc2igy", []);
  CSS.make("_a_gc95p4", []);
