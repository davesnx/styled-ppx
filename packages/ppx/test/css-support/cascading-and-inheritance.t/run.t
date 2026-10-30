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
    ("._a_4eyg6i{color:unset;}", "_a_4eyg6i", "0,1,0 own", "158", 1, false)
  ];
  [@css
    (
      "._a_655m9shh2p{font-weight:unset;}",
      "_a_655m9shh2p",
      "0,1,0 own",
      "221",
      262144,
      false,
    )
  ];
  [@css
    (
      "._a_3900086y3o{background-image:unset;}",
      "_a_3900086y3o",
      "0,1,0 own",
      "117",
      8,
      false,
    )
  ];
  [@css
    ("._a_ecvyp6{width:unset;}", "_a_ecvyp6", "0,1,0 own", "516", 1, false)
  ];
  [@css.blocks
    [(2, "", [0]), (3, "", [1]), (4, "", [2]), (5, "", [3])]
  ];
  
  CSS.make("_a_4eyg6i", []);
  CSS.make("_a_655m9shh2p", []);
  CSS.make("_a_3900086y3o", []);
  CSS.make("_a_ecvyp6", []);
