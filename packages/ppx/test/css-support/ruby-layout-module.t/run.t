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
    ("._a_5r3gy9{display:ruby;}", "_a_5r3gy9", "0,1,0 own", "207", 1, false)
  ];
  [@css
    (
      "._a_5rb5b1{display:ruby-base;}",
      "_a_5rb5b1",
      "0,1,0 own",
      "207",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5riprk{display:ruby-text;}",
      "_a_5riprk",
      "0,1,0 own",
      "207",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5rp41v{display:ruby-base-container;}",
      "_a_5rp41v",
      "0,1,0 own",
      "207",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_5rjuuf{display:ruby-text-container;}",
      "_a_5rjuuf",
      "0,1,0 own",
      "207",
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
  
  CSS.make("_a_5r3gy9", []);
  CSS.make("_a_5rb5b1", []);
  CSS.make("_a_5riprk", []);
  CSS.make("_a_5rp41v", []);
  CSS.make("_a_5rjuuf", []);
