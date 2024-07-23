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
  
  CSS.unsafe({js|direction|js}, {js|ltr|js});
  CSS.unsafe({js|direction|js}, {js|rtl|js});
  CSS.unsafe({js|unicodeBidi|js}, {js|normal|js});
  CSS.unsafe({js|unicodeBidi|js}, {js|embed|js});
  CSS.unsafe({js|unicodeBidi|js}, {js|isolate|js});
  CSS.unsafe({js|unicodeBidi|js}, {js|bidi-override|js});
  CSS.unsafe({js|unicodeBidi|js}, {js|isolate-override|js});
  CSS.unsafe({js|unicodeBidi|js}, {js|plaintext|js});
  CSS.unsafe({js|writingMode|js}, {js|horizontal-tb|js});
  CSS.unsafe({js|writingMode|js}, {js|vertical-rl|js});
  CSS.unsafe({js|writingMode|js}, {js|vertical-lr|js});
  CSS.unsafe({js|textOrientation|js}, {js|mixed|js});
  CSS.unsafe({js|textOrientation|js}, {js|upright|js});
  CSS.unsafe({js|textOrientation|js}, {js|sideways|js});
  CSS.unsafe({js|textCombineUpright|js}, {js|none|js});
  CSS.unsafe({js|textCombineUpright|js}, {js|all|js});
  
  CSS.unsafe({js|writingMode|js}, {js|sideways-rl|js});
  CSS.unsafe({js|writingMode|js}, {js|sideways-lr|js});
  CSS.unsafe({js|textCombineUpright|js}, {js|digits 2|js});
