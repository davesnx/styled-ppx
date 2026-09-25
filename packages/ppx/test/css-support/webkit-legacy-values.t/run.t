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
    ".a-oh9l4c{background:-webkit-gradient(linear, left top, left bottom, from(red), to(blue));}"
  ];
  [@css
    ".a-1kr95w2{background:-webkit-gradient(radial, center center, 0px, center center, 100px, from(blue), to(red));}"
  ];
  [@css
    ".a-vnsa3w{-webkit-mask-box-image:url(\"mask.png\") 10px 10px 10px 10px stretch stretch;}"
  ];
  [@css
    ".a-1dg3brk{-webkit-mask-box-image:url(\"mask.png\") 5% 5% 5% 5% round repeat;}"
  ];
  
  CSS.make("a-oh9l4c", []);
  CSS.make("a-1kr95w2", []);
  
  CSS.make("a-vnsa3w", []);
  CSS.make("a-1dg3brk", []);
