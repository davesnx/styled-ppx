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
    ".css-iewixn{background:-webkit-gradient(linear, left top, left bottom, from(red), to(blue));}"
  ];
  [@css
    ".css-cflozv{background:-webkit-gradient(radial, center center, 0px, center center, 100px, from(blue), to(red));}"
  ];
  [@css
    ".css-ezfh3b{-webkit-mask-box-image:url(\"mask.png\") 10px 10px 10px 10px stretch stretch;}"
  ];
  [@css
    ".css-4obmqg{-webkit-mask-box-image:url(\"mask.png\") 5% 5% 5% 5% round repeat;}"
  ];
  [@css.classes
    [
      ("css-iewixn", 0, "", "input.re", 5, 4, 5, 84),
      ("css-cflozv", 1, "", "input.re", 8, 4, 8, 103),
      ("css-ezfh3b", 2, "", "input.re", 12, 8, 12, 81),
      ("css-4obmqg", 3, "", "input.re", 13, 8, 13, 70),
    ]
  ];
  
  CSS.make("css-iewixn", []);
  CSS.make("css-cflozv", []);
  
  CSS.make("css-ezfh3b", []);
  CSS.make("css-4obmqg", []);
