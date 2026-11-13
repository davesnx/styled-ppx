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
  [@css ".css-3wbcxr{-webkit-print-color-adjust:economy;color-adjust:economy;}"];
  [@css ".css-1lszhcn{-webkit-print-color-adjust:exact;color-adjust:exact;}"];
  [@css ".css-yl4w22{forced-color-adjust:auto;}"];
  [@css ".css-1jyhcxx{forced-color-adjust:none;}"];
  [@css ".css-1tekp75{forced-color-adjust:preserve-parent-color;}"];
  [@css ".css-1qymq7y{color-scheme:normal;}"];
  [@css ".css-6b7kbj{color-scheme:light;}"];
  [@css ".css-1ay18vt{color-scheme:dark;}"];
  [@css ".css-1ti0rb7{color-scheme:light dark;}"];
  [@css ".css-1j1vq9m{color-scheme:dark light;}"];
  [@css ".css-12zg3gc{color-scheme:only light;}"];
  [@css ".css-1vmhhz6{color-scheme:light only;}"];
  [@css ".css-198vrbp{color-scheme:light light;}"];
  [@css ".css-cpudfk{color-scheme:dark dark;}"];
  [@css ".css-1ksr3af{color-scheme:light purple;}"];
  [@css ".css-1chpnt6{color-scheme:purple dark interesting;}"];
  [@css ".css-1hglvkd{color-scheme:none;}"];
  [@css ".css-9z19gc{color-scheme:light none;}"];
  [@css.classes
    [
      ("css-3wbcxr", 0, "", "input.re", 2, 8, 2, 29),
      ("css-1lszhcn", 1, "", "input.re", 3, 8, 3, 27),
      ("css-yl4w22", 2, "", "input.re", 4, 8, 4, 33),
      ("css-1jyhcxx", 3, "", "input.re", 5, 8, 5, 33),
      ("css-1tekp75", 4, "", "input.re", 6, 8, 6, 50),
      ("css-1qymq7y", 5, "", "input.re", 7, 8, 7, 28),
      ("css-6b7kbj", 6, "", "input.re", 8, 8, 8, 27),
      ("css-1ay18vt", 7, "", "input.re", 9, 8, 9, 26),
      ("css-1ti0rb7", 8, "", "input.re", 10, 8, 10, 32),
      ("css-1j1vq9m", 9, "", "input.re", 11, 8, 11, 32),
      ("css-12zg3gc", 10, "", "input.re", 12, 8, 12, 32),
      ("css-1vmhhz6", 11, "", "input.re", 13, 8, 13, 32),
      ("css-198vrbp", 12, "", "input.re", 14, 8, 14, 33),
      ("css-cpudfk", 13, "", "input.re", 15, 8, 15, 31),
      ("css-1ksr3af", 14, "", "input.re", 16, 8, 16, 34),
      ("css-1chpnt6", 15, "", "input.re", 17, 8, 17, 45),
      ("css-1hglvkd", 16, "", "input.re", 18, 8, 18, 26),
      ("css-9z19gc", 17, "", "input.re", 19, 8, 19, 32),
    ]
  ];
  
  CSS.make("css-3wbcxr", []);
  CSS.make("css-1lszhcn", []);
  CSS.make("css-yl4w22", []);
  CSS.make("css-1jyhcxx", []);
  CSS.make("css-1tekp75", []);
  CSS.make("css-1qymq7y", []);
  CSS.make("css-6b7kbj", []);
  CSS.make("css-1ay18vt", []);
  CSS.make("css-1ti0rb7", []);
  CSS.make("css-1j1vq9m", []);
  CSS.make("css-12zg3gc", []);
  CSS.make("css-1vmhhz6", []);
  CSS.make("css-198vrbp", []);
  CSS.make("css-cpudfk", []);
  CSS.make("css-1ksr3af", []);
  CSS.make("css-1chpnt6", []);
  CSS.make("css-1hglvkd", []);
  CSS.make("css-9z19gc", []);
