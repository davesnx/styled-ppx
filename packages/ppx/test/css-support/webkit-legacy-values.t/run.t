This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

Regression test for dash-prefixed webkit registry keys: <-webkit-gradient-type>
and <-webkit-mask-box-repeat> used to be referenced without the leading dash,
crashing the compiler with "Rule not found in registry: webkit-gradient-type"
and "Rule not found in registry: webkit-mask-box-repeat".

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
      "._a_399l4c{background:-webkit-gradient(linear, left top, left bottom, from(red), to(blue));}",
      "_a_399l4c",
      "0,1,0 own",
      "117",
      511,
      false,
    )
  ];
  [@css
    (
      "._a_3995w2{background:-webkit-gradient(radial, center center, 0px, center center, 100px, from(blue), to(red));}",
      "_a_3995w2",
      "0,1,0 own",
      "117",
      511,
      false,
    )
  ];
  [@css
    (
      "._a_2gsa3w{-webkit-mask-box-image:url(\"mask.png\") 10px 10px 10px 10px stretch stretch;}",
      "_a_2gsa3w",
      "0,1,0 own",
      "88",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_2g3brk{-webkit-mask-box-image:url(\"mask.png\") 5% 5% 5% 5% round repeat;}",
      "_a_2g3brk",
      "0,1,0 own",
      "88",
      1,
      false,
    )
  ];
  [@css.blocks
    [(5, "", [0]), (8, "", [1]), (12, "", [2]), (13, "", [3])]
  ];
  
  CSS.make("_a_399l4c", []);
  CSS.make("_a_3995w2", []);
  
  CSS.make("_a_2gsa3w", []);
  CSS.make("_a_2g3brk", []);
