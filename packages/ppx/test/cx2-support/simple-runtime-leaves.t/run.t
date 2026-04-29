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
  [@css ".css-1ww2ddt{empty-cells:show;}"];
  [@css ".css-2uav7h{empty-cells:hide;}"];
  [@css ".css-1wyzhlp{field-sizing:content;}"];
  [@css ".css-1rpat5c{field-sizing:fixed;}"];
  [@css ".css-1eo7wts{interpolate-size:numeric-only;}"];
  [@css ".css-ja4lek{interpolate-size:allow-keywords;}"];
  [@css ".css-19bo2dy{initial-letter:normal;}"];
  [@css ".css-12uwub8{initial-letter:1.5;}"];
  [@css ".css-1h50l7m{initial-letter:1.5 2;}"];
  [@css ".css-mobm9f{initial-letter-align:auto;}"];
  [@css ".css-1hnpsj{initial-letter-align:alphabetic;}"];
  [@css ".css-1hjwje6{initial-letter-align:hanging;}"];
  [@css ".css-nrtz0y{initial-letter-align:ideographic;}"];
  [@css ".css-5cqonx{image-resolution:from-image;}"];
  [@css ".css-1od4m46{image-resolution:96dpi;}"];
  [@css ".css-m6btb7{image-resolution:2dppx;}"];
  [@css ".css-1g7wnyr{image-resolution:from-image snap;}"];
  [@css ".css-8kehnm{image-resolution:96dpi snap;}"];
  
  CSS.make("css-1ww2ddt", []);
  CSS.make("css-2uav7h", []);
  CSS.make("css-1wyzhlp", []);
  CSS.make("css-1rpat5c", []);
  CSS.make("css-1eo7wts", []);
  CSS.make("css-ja4lek", []);
  CSS.make("css-19bo2dy", []);
  CSS.make("css-12uwub8", []);
  CSS.make("css-1h50l7m", []);
  CSS.make("css-mobm9f", []);
  CSS.make("css-1hnpsj", []);
  CSS.make("css-1hjwje6", []);
  CSS.make("css-nrtz0y", []);
  CSS.make("css-5cqonx", []);
  CSS.make("css-1od4m46", []);
  CSS.make("css-m6btb7", []);
  CSS.make("css-1g7wnyr", []);
  CSS.make("css-8kehnm", []);
