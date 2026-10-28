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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    (
      "._a_eco6vg{width:calc(50% + 4px);}",
      "_a_eco6vg",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ecj19s{width:calc(20px - 10px);}",
      "_a_ecj19s",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_eco4ty{width:calc(100vh - calc(2rem + 120px));}",
      "_a_eco4ty",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ecuhfp{width:calc(100vh * 2);}",
      "_a_ecuhfp",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ec8hw4{width:calc(2 * 120px);}",
      "_a_ec8hw4",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (1, "", [0]),
      (2, "", [1]),
      (3, "", [2]),
      (4, "", [3]),
      (5, "", [4]),
    ]
  ];
  CSS.make("_a_eco6vg", []);
  CSS.make("_a_ecj19s", []);
  CSS.make("_a_eco4ty", []);
  CSS.make("_a_ecuhfp", []);
  CSS.make("_a_ec8hw4", []);

  $ dune build
