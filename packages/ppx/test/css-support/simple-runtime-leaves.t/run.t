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
  [@css "._a_5u2ddt{empty-cells:show;}"];
  [@css "._a_5uav7h{empty-cells:hide;}"];
  [@css "._a_5vzhlp{field-sizing:content;}"];
  [@css "._a_5vat5c{field-sizing:fixed;}"];
  [@css "._a_797wts{interpolate-size:numeric-only;}"];
  [@css "._a_794lek{interpolate-size:allow-keywords;}"];
  [@css "._a_6xo2dy{initial-letter:normal;}"];
  [@css "._a_6xwub8{initial-letter:1.5;}"];
  [@css "._a_6x0l7m{initial-letter:1.5 2;}"];
  [@css "._a_6ybm9f{initial-letter-align:auto;}"];
  [@css "._a_6ynpsj{initial-letter-align:alphabetic;}"];
  [@css "._a_6ywje6{initial-letter-align:hanging;}"];
  [@css "._a_6ytz0y{initial-letter-align:ideographic;}"];
  [@css "._a_6uqonx{image-resolution:from-image;}"];
  [@css "._a_6u4m46{image-resolution:96dpi;}"];
  [@css "._a_6ubtb7{image-resolution:2dppx;}"];
  [@css "._a_6uwnyr{image-resolution:from-image snap;}"];
  [@css "._a_6uehnm{image-resolution:96dpi snap;}"];
  
  CSS.make("_a_5u2ddt", []);
  CSS.make("_a_5uav7h", []);
  CSS.make("_a_5vzhlp", []);
  CSS.make("_a_5vat5c", []);
  CSS.make("_a_797wts", []);
  CSS.make("_a_794lek", []);
  CSS.make("_a_6xo2dy", []);
  CSS.make("_a_6xwub8", []);
  CSS.make("_a_6x0l7m", []);
  CSS.make("_a_6ybm9f", []);
  CSS.make("_a_6ynpsj", []);
  CSS.make("_a_6ywje6", []);
  CSS.make("_a_6ytz0y", []);
  CSS.make("_a_6uqonx", []);
  CSS.make("_a_6u4m46", []);
  CSS.make("_a_6ubtb7", []);
  CSS.make("_a_6uwnyr", []);
  CSS.make("_a_6uehnm", []);
