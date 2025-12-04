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
  
  CSS.direction(`ltr);
  CSS.direction(`rtl);
  CSS.unicodeBidi(`normal);
  CSS.unicodeBidi(`embed);
  CSS.unicodeBidi(`isolate);
  CSS.unicodeBidi(`bidiOverride);
  CSS.unicodeBidi(`isolateOverride);
  CSS.unicodeBidi(`plaintext);
  CSS.writingMode(`horizontalTb);
  CSS.writingMode(`verticalRl);
  CSS.writingMode(`verticalLr);
  CSS.textOrientation(`mixed);
  CSS.textOrientation(`upright);
  CSS.textOrientation(`sideways);
  CSS.unsafe({js|textCombineUpright|js}, {js|none|js});
  CSS.unsafe({js|textCombineUpright|js}, {js|all|js});
  
  CSS.writingMode(`sidewaysRl);
  CSS.writingMode(`sidewaysLr);
  CSS.unsafe({js|textCombineUpright|js}, {js|digits 2|js});
