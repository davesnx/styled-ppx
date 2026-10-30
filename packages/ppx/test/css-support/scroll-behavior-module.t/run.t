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
      "._a_aahc5w{scroll-behavior:auto;}",
      "_a_aahc5w",
      "0,1,0 own",
      "370",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_aajuhq{scroll-behavior:smooth;}",
      "_a_aajuhq",
      "0,1,0 own",
      "370",
      1,
      false,
    )
  ];
  [@css.blocks [(2, "", [0]), (3, "", [1])]];
  
  CSS.make("_a_aahc5w", []);
  CSS.make("_a_aajuhq", []);
