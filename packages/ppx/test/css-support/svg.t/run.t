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
      "._a_9k0k8p{pointer-events:auto;}",
      "_a_9k0k8p",
      "0,1,0 own",
      "344",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9k73s1{pointer-events:visiblePainted;}",
      "_a_9k73s1",
      "0,1,0 own",
      "344",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9kle2q{pointer-events:visibleFill;}",
      "_a_9kle2q",
      "0,1,0 own",
      "344",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9k4ebn{pointer-events:visibleStroke;}",
      "_a_9k4ebn",
      "0,1,0 own",
      "344",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9ksh4e{pointer-events:visible;}",
      "_a_9ksh4e",
      "0,1,0 own",
      "344",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9k29yp{pointer-events:painted;}",
      "_a_9k29yp",
      "0,1,0 own",
      "344",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9kh5dc{pointer-events:fill;}",
      "_a_9kh5dc",
      "0,1,0 own",
      "344",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9kii8d{pointer-events:stroke;}",
      "_a_9kii8d",
      "0,1,0 own",
      "344",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9k7k7s{pointer-events:all;}",
      "_a_9k7k7s",
      "0,1,0 own",
      "344",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9kbp0l{pointer-events:none;}",
      "_a_9kbp0l",
      "0,1,0 own",
      "344",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (67, "", [0]),
      (69, "", [1]),
      (70, "", [2]),
      (71, "", [3]),
      (72, "", [4]),
      (73, "", [5]),
      (74, "", [6]),
      (75, "", [7]),
      (76, "", [8]),
      (77, "", [9]),
    ]
  ];
  
  CSS.make("_a_9k0k8p", []);
  
  CSS.make("_a_9k73s1", []);
  CSS.make("_a_9kle2q", []);
  CSS.make("_a_9k4ebn", []);
  CSS.make("_a_9ksh4e", []);
  CSS.make("_a_9k29yp", []);
  CSS.make("_a_9kh5dc", []);
  CSS.make("_a_9kii8d", []);
  CSS.make("_a_9k7k7s", []);
  CSS.make("_a_9kbp0l", []);
