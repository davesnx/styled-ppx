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
  [@css ".a-1ww2ddt{empty-cells:show;}"];
  [@css ".a-2uav7h{empty-cells:hide;}"];
  [@css ".a-1wyzhlp{field-sizing:content;}"];
  [@css ".a-1rpat5c{field-sizing:fixed;}"];
  [@css ".a-1eo7wts{interpolate-size:numeric-only;}"];
  [@css ".a-ja4lek{interpolate-size:allow-keywords;}"];
  [@css ".a-19bo2dy{initial-letter:normal;}"];
  [@css ".a-12uwub8{initial-letter:1.5;}"];
  [@css ".a-1h50l7m{initial-letter:1.5 2;}"];
  [@css ".a-mobm9f{initial-letter-align:auto;}"];
  [@css ".a-1hnpsj{initial-letter-align:alphabetic;}"];
  [@css ".a-1hjwje6{initial-letter-align:hanging;}"];
  [@css ".a-nrtz0y{initial-letter-align:ideographic;}"];
  [@css ".a-5cqonx{image-resolution:from-image;}"];
  [@css ".a-1od4m46{image-resolution:96dpi;}"];
  [@css ".a-m6btb7{image-resolution:2dppx;}"];
  [@css ".a-1g7wnyr{image-resolution:from-image snap;}"];
  [@css ".a-8kehnm{image-resolution:96dpi snap;}"];
  
  CSS.make("a-1ww2ddt", []);
  CSS.make("a-2uav7h", []);
  CSS.make("a-1wyzhlp", []);
  CSS.make("a-1rpat5c", []);
  CSS.make("a-1eo7wts", []);
  CSS.make("a-ja4lek", []);
  CSS.make("a-19bo2dy", []);
  CSS.make("a-12uwub8", []);
  CSS.make("a-1h50l7m", []);
  CSS.make("a-mobm9f", []);
  CSS.make("a-1hnpsj", []);
  CSS.make("a-1hjwje6", []);
  CSS.make("a-nrtz0y", []);
  CSS.make("a-5cqonx", []);
  CSS.make("a-1od4m46", []);
  CSS.make("a-m6btb7", []);
  CSS.make("a-1g7wnyr", []);
  CSS.make("a-8kehnm", []);
