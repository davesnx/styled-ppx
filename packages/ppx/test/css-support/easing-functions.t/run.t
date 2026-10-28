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
      "._a_dm000gudp6{transition-timing-function:steps(2, jump-start);}",
      "_a_dm000gudp6",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000gegan{transition-timing-function:steps(2, jump-end);}",
      "_a_dm000gegan",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000gsz2c{transition-timing-function:steps(1, jump-both);}",
      "_a_dm000gsz2c",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css
    (
      "._a_dm000g8w8e{transition-timing-function:steps(2, jump-none);}",
      "_a_dm000g8w8e",
      "0,1,0 own",
      "490",
      16,
      false,
    )
  ];
  [@css.blocks
    [(2, "", [0]), (3, "", [1]), (4, "", [2]), (5, "", [3])]
  ];
  
  CSS.make("_a_dm000gudp6", []);
  CSS.make("_a_dm000gegan", []);
  CSS.make("_a_dm000gsz2c", []);
  CSS.make("_a_dm000g8w8e", []);
