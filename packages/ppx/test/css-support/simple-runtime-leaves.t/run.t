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
  [@css ".a-5u2ddt{empty-cells:show;}"];
  [@css ".a-5uav7h{empty-cells:hide;}"];
  [@css ".a-5vzhlp{field-sizing:content;}"];
  [@css ".a-5vat5c{field-sizing:fixed;}"];
  [@css ".a-797wts{interpolate-size:numeric-only;}"];
  [@css ".a-794lek{interpolate-size:allow-keywords;}"];
  [@css ".a-6xo2dy{initial-letter:normal;}"];
  [@css ".a-6xwub8{initial-letter:1.5;}"];
  [@css ".a-6x0l7m{initial-letter:1.5 2;}"];
  [@css ".a-6ybm9f{initial-letter-align:auto;}"];
  [@css ".a-6ynpsj{initial-letter-align:alphabetic;}"];
  [@css ".a-6ywje6{initial-letter-align:hanging;}"];
  [@css ".a-6ytz0y{initial-letter-align:ideographic;}"];
  [@css ".a-6uqonx{image-resolution:from-image;}"];
  [@css ".a-6u4m46{image-resolution:96dpi;}"];
  [@css ".a-6ubtb7{image-resolution:2dppx;}"];
  [@css ".a-6uwnyr{image-resolution:from-image snap;}"];
  [@css ".a-6uehnm{image-resolution:96dpi snap;}"];
  
  CSS.make("a-5u2ddt", []);
  CSS.make("a-5uav7h", []);
  CSS.make("a-5vzhlp", []);
  CSS.make("a-5vat5c", []);
  CSS.make("a-797wts", []);
  CSS.make("a-794lek", []);
  CSS.make("a-6xo2dy", []);
  CSS.make("a-6xwub8", []);
  CSS.make("a-6x0l7m", []);
  CSS.make("a-6ybm9f", []);
  CSS.make("a-6ynpsj", []);
  CSS.make("a-6ywje6", []);
  CSS.make("a-6ytz0y", []);
  CSS.make("a-6uqonx", []);
  CSS.make("a-6u4m46", []);
  CSS.make("a-6ubtb7", []);
  CSS.make("a-6uwnyr", []);
  CSS.make("a-6uehnm", []);
