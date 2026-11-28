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
  [@css
    ".css-ivpccxr{-webkit-print-color-adjust:economy;color-adjust:economy;}"
  ];
  [@css ".css-ivpchcn{-webkit-print-color-adjust:exact;color-adjust:exact;}"];
  [@css ".css-ivpcw22{forced-color-adjust:auto;}"];
  [@css ".css-ivpccxx{forced-color-adjust:none;}"];
  [@css ".css-ivpcp75{forced-color-adjust:preserve-parent-color;}"];
  [@css ".css-ivpcq7y{color-scheme:normal;}"];
  [@css ".css-ivpckbj{color-scheme:light;}"];
  [@css ".css-ivpc8vt{color-scheme:dark;}"];
  [@css ".css-ivpcrb7{color-scheme:light dark;}"];
  [@css ".css-ivpcq9m{color-scheme:dark light;}"];
  [@css ".css-ivpc3gc{color-scheme:only light;}"];
  [@css ".css-ivpchz6{color-scheme:light only;}"];
  [@css ".css-ivpcrbp{color-scheme:light light;}"];
  [@css ".css-ivpcdfk{color-scheme:dark dark;}"];
  [@css ".css-ivpc3af{color-scheme:light purple;}"];
  [@css ".css-ivpcnt6{color-scheme:purple dark interesting;}"];
  [@css ".css-ivpcvkd{color-scheme:none;}"];
  [@css ".css-ivpc9gc{color-scheme:light none;}"];
  [@css.classes
    [
      ("css-ivpccxr", 0, "", "input.re", 2, 8, 2, 29),
      ("css-ivpchcn", 1, "", "input.re", 3, 8, 3, 27),
      ("css-ivpcw22", 2, "", "input.re", 4, 8, 4, 33),
      ("css-ivpccxx", 3, "", "input.re", 5, 8, 5, 33),
      ("css-ivpcp75", 4, "", "input.re", 6, 8, 6, 50),
      ("css-ivpcq7y", 5, "", "input.re", 7, 8, 7, 28),
      ("css-ivpckbj", 6, "", "input.re", 8, 8, 8, 27),
      ("css-ivpc8vt", 7, "", "input.re", 9, 8, 9, 26),
      ("css-ivpcrb7", 8, "", "input.re", 10, 8, 10, 32),
      ("css-ivpcq9m", 9, "", "input.re", 11, 8, 11, 32),
      ("css-ivpc3gc", 10, "", "input.re", 12, 8, 12, 32),
      ("css-ivpchz6", 11, "", "input.re", 13, 8, 13, 32),
      ("css-ivpcrbp", 12, "", "input.re", 14, 8, 14, 33),
      ("css-ivpcdfk", 13, "", "input.re", 15, 8, 15, 31),
      ("css-ivpc3af", 14, "", "input.re", 16, 8, 16, 34),
      ("css-ivpcnt6", 15, "", "input.re", 17, 8, 17, 45),
      ("css-ivpcvkd", 16, "", "input.re", 18, 8, 18, 26),
      ("css-ivpc9gc", 17, "", "input.re", 19, 8, 19, 32),
    ]
  ];
  
  CSS.make("css-ivpccxr", []);
  CSS.make("css-ivpchcn", []);
  CSS.make("css-ivpcw22", []);
  CSS.make("css-ivpccxx", []);
  CSS.make("css-ivpcp75", []);
  CSS.make("css-ivpcq7y", []);
  CSS.make("css-ivpckbj", []);
  CSS.make("css-ivpc8vt", []);
  CSS.make("css-ivpcrb7", []);
  CSS.make("css-ivpcq9m", []);
  CSS.make("css-ivpc3gc", []);
  CSS.make("css-ivpchz6", []);
  CSS.make("css-ivpcrbp", []);
  CSS.make("css-ivpcdfk", []);
  CSS.make("css-ivpc3af", []);
  CSS.make("css-ivpcnt6", []);
  CSS.make("css-ivpcvkd", []);
  CSS.make("css-ivpc9gc", []);
