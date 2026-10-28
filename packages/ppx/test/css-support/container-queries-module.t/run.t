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
      "._a_4v00027ccc{container-type:normal;}",
      "_a_4v00027ccc",
      "0,1,0 own",
      "175",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_4v00026sj7{container-type:size;}",
      "_a_4v00026sj7",
      "0,1,0 own",
      "175",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_4v0002zm71{container-type:inline-size;}",
      "_a_4v0002zm71",
      "0,1,0 own",
      "175",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_4v0001nlpx{container-name:none;}",
      "_a_4v0001nlpx",
      "0,1,0 own",
      "175",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4v0001baxz{container-name:sidebar;}",
      "_a_4v0001baxz",
      "0,1,0 own",
      "175",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4v0001qxl0{container-name:sidebar main;}",
      "_a_4v0001qxl0",
      "0,1,0 own",
      "175",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4ve1gg{container:sidebar / inline-size;}",
      "_a_4ve1gg",
      "0,1,0 own",
      "175",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_4vbl4h{container:sidebar / size;}",
      "_a_4vbl4h",
      "0,1,0 own",
      "175",
      3,
      false,
    )
  ];
  [@css
    ("._a_4v1iko{container:none;}", "_a_4v1iko", "0,1,0 own", "175", 3, false)
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
      (10, "", [8]),
    ]
  ];
  
  CSS.make("_a_4v00027ccc", []);
  CSS.make("_a_4v00026sj7", []);
  CSS.make("_a_4v0002zm71", []);
  CSS.make("_a_4v0001nlpx", []);
  CSS.make("_a_4v0001baxz", []);
  CSS.make("_a_4v0001qxl0", []);
  CSS.make("_a_4ve1gg", []);
  CSS.make("_a_4vbl4h", []);
  CSS.make("_a_4v1iko", []);
