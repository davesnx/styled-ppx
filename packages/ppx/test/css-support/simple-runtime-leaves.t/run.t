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
  
  CSS.emptyCells(`show);
  CSS.emptyCells(`hide);
  CSS.fieldSizing(`content);
  CSS.fieldSizing(`fixed);
  CSS.interpolateSize(`numericOnly);
  CSS.interpolateSize(`allowKeywords);
  CSS.initialLetter(`normal);
  CSS.initialLetter(`num(1.5));
  CSS.initialLetter(`value({js|1.5 2|js}));
  CSS.initialLetterAlign(`auto);
  CSS.initialLetterAlign(`alphabetic);
  CSS.initialLetterAlign(`hanging);
  CSS.initialLetterAlign(`ideographic);
  CSS.imageResolution(`fromImage);
  CSS.imageResolution(`value({js|96dpi|js}));
  CSS.imageResolution(`value({js|2dppx|js}));
  CSS.imageResolution(`value({js|from-image snap|js}));
  CSS.imageResolution(`value({js|96dpi snap|js}));
