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
  [@css ".css-qflt7h{empty-cells:show;}"];
  [@css ".css-v575uk{empty-cells:hide;}"];
  [@css ".css-talkml{field-sizing:content;}"];
  [@css ".css-bsc3am{field-sizing:fixed;}"];
  [@css ".css-1aic9an{interpolate-size:numeric-only;}"];
  [@css ".css-sddzjl{interpolate-size:allow-keywords;}"];
  [@css ".css-1qkptgw{initial-letter:normal;}"];
  [@css ".css-9ft4nd{initial-letter:1.5;}"];
  [@css ".css-156x1cu{initial-letter:1.5 2;}"];
  [@css ".css-12nd8k{initial-letter-align:auto;}"];
  [@css ".css-1nn4b1j{initial-letter-align:alphabetic;}"];
  [@css ".css-1k1r2hj{initial-letter-align:hanging;}"];
  [@css ".css-1qy40il{initial-letter-align:ideographic;}"];
  [@css ".css-1h28eq3{image-resolution:from-image;}"];
  [@css ".css-1qsihdw{image-resolution:96dpi;}"];
  [@css ".css-1e8ox03{image-resolution:2dppx;}"];
  [@css ".css-apoook{image-resolution:from-image snap;}"];
  [@css ".css-1swo3wu{image-resolution:96dpi snap;}"];
  [@css.classes
    [
      ("css-qflt7h", 0, "", "input.re", 2, 8, 2, 25),
      ("css-v575uk", 1, "", "input.re", 3, 8, 3, 25),
      ("css-talkml", 2, "", "input.re", 4, 8, 4, 29),
      ("css-bsc3am", 3, "", "input.re", 5, 8, 5, 27),
      ("css-1aic9an", 4, "", "input.re", 6, 8, 6, 38),
      ("css-sddzjl", 5, "", "input.re", 7, 8, 7, 40),
      ("css-1qkptgw", 6, "", "input.re", 8, 8, 8, 30),
      ("css-9ft4nd", 7, "", "input.re", 9, 8, 9, 27),
      ("css-156x1cu", 8, "", "input.re", 10, 8, 10, 29),
      ("css-12nd8k", 9, "", "input.re", 11, 8, 11, 34),
      ("css-1nn4b1j", 10, "", "input.re", 12, 8, 12, 40),
      ("css-1k1r2hj", 11, "", "input.re", 13, 8, 13, 37),
      ("css-1qy40il", 12, "", "input.re", 14, 8, 14, 41),
      ("css-1h28eq3", 13, "", "input.re", 15, 8, 15, 36),
      ("css-1qsihdw", 14, "", "input.re", 16, 8, 16, 31),
      ("css-1e8ox03", 15, "", "input.re", 17, 8, 17, 31),
      ("css-apoook", 16, "", "input.re", 18, 8, 18, 41),
      ("css-1swo3wu", 17, "", "input.re", 19, 8, 19, 36),
    ]
  ];
  
  CSS.make("css-qflt7h", []);
  CSS.make("css-v575uk", []);
  CSS.make("css-talkml", []);
  CSS.make("css-bsc3am", []);
  CSS.make("css-1aic9an", []);
  CSS.make("css-sddzjl", []);
  CSS.make("css-1qkptgw", []);
  CSS.make("css-9ft4nd", []);
  CSS.make("css-156x1cu", []);
  CSS.make("css-12nd8k", []);
  CSS.make("css-1nn4b1j", []);
  CSS.make("css-1k1r2hj", []);
  CSS.make("css-1qy40il", []);
  CSS.make("css-1h28eq3", []);
  CSS.make("css-1qsihdw", []);
  CSS.make("css-1e8ox03", []);
  CSS.make("css-apoook", []);
  CSS.make("css-1swo3wu", []);
