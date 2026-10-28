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
    (
      "._a_b9p1bd{scrollbar-color:auto;}",
      "_a_b9p1bd",
      "0,1,0 own",
      "405",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_b9d6oa{scrollbar-color:red blue;}",
      "_a_b9d6oa",
      "0,1,0 own",
      "405",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bh07g6{scrollbar-width:auto;}",
      "_a_bh07g6",
      "0,1,0 own",
      "413",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bhrmx3{scrollbar-width:thin;}",
      "_a_bhrmx3",
      "0,1,0 own",
      "413",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_bhrjsx{scrollbar-width:none;}",
      "_a_bhrjsx",
      "0,1,0 own",
      "413",
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
    ]
  ];
  
  CSS.make("_a_b9p1bd", []);
  CSS.make("_a_b9d6oa", []);
  CSS.make("_a_bh07g6", []);
  CSS.make("_a_bhrmx3", []);
  CSS.make("_a_bhrjsx", []);
