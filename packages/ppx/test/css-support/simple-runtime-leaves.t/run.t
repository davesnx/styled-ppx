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
  [@css ".css-ivpct7h{empty-cells:show;}"];
  [@css ".css-ivpc5uk{empty-cells:hide;}"];
  [@css ".css-ivpckml{field-sizing:content;}"];
  [@css ".css-ivpc3am{field-sizing:fixed;}"];
  [@css ".css-ivpc9an{interpolate-size:numeric-only;}"];
  [@css ".css-ivpczjl{interpolate-size:allow-keywords;}"];
  [@css ".css-ivpctgw{initial-letter:normal;}"];
  [@css ".css-ivpc4nd{initial-letter:1.5;}"];
  [@css ".css-ivpc1cu{initial-letter:1.5 2;}"];
  [@css ".css-ivpcd8k{initial-letter-align:auto;}"];
  [@css ".css-ivpcb1j{initial-letter-align:alphabetic;}"];
  [@css ".css-ivpc2hj{initial-letter-align:hanging;}"];
  [@css ".css-ivpc0il{initial-letter-align:ideographic;}"];
  [@css ".css-ivpceq3{image-resolution:from-image;}"];
  [@css ".css-ivpchdw{image-resolution:96dpi;}"];
  [@css ".css-ivpcx03{image-resolution:2dppx;}"];
  [@css ".css-ivpcook{image-resolution:from-image snap;}"];
  [@css ".css-ivpc3wu{image-resolution:96dpi snap;}"];
  [@css.classes
    [
      ("css-ivpct7h", 0, "", "input.re", 2, 8, 2, 25),
      ("css-ivpc5uk", 1, "", "input.re", 3, 8, 3, 25),
      ("css-ivpckml", 2, "", "input.re", 4, 8, 4, 29),
      ("css-ivpc3am", 3, "", "input.re", 5, 8, 5, 27),
      ("css-ivpc9an", 4, "", "input.re", 6, 8, 6, 38),
      ("css-ivpczjl", 5, "", "input.re", 7, 8, 7, 40),
      ("css-ivpctgw", 6, "", "input.re", 8, 8, 8, 30),
      ("css-ivpc4nd", 7, "", "input.re", 9, 8, 9, 27),
      ("css-ivpc1cu", 8, "", "input.re", 10, 8, 10, 29),
      ("css-ivpcd8k", 9, "", "input.re", 11, 8, 11, 34),
      ("css-ivpcb1j", 10, "", "input.re", 12, 8, 12, 40),
      ("css-ivpc2hj", 11, "", "input.re", 13, 8, 13, 37),
      ("css-ivpc0il", 12, "", "input.re", 14, 8, 14, 41),
      ("css-ivpceq3", 13, "", "input.re", 15, 8, 15, 36),
      ("css-ivpchdw", 14, "", "input.re", 16, 8, 16, 31),
      ("css-ivpcx03", 15, "", "input.re", 17, 8, 17, 31),
      ("css-ivpcook", 16, "", "input.re", 18, 8, 18, 41),
      ("css-ivpc3wu", 17, "", "input.re", 19, 8, 19, 36),
    ]
  ];
  
  CSS.make("css-ivpct7h", []);
  CSS.make("css-ivpc5uk", []);
  CSS.make("css-ivpckml", []);
  CSS.make("css-ivpc3am", []);
  CSS.make("css-ivpc9an", []);
  CSS.make("css-ivpczjl", []);
  CSS.make("css-ivpctgw", []);
  CSS.make("css-ivpc4nd", []);
  CSS.make("css-ivpc1cu", []);
  CSS.make("css-ivpcd8k", []);
  CSS.make("css-ivpcb1j", []);
  CSS.make("css-ivpc2hj", []);
  CSS.make("css-ivpc0il", []);
  CSS.make("css-ivpceq3", []);
  CSS.make("css-ivpchdw", []);
  CSS.make("css-ivpcx03", []);
  CSS.make("css-ivpcook", []);
  CSS.make("css-ivpc3wu", []);
