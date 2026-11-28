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
  [@css ".css-ivpctbu{color:hwb(0 0% 0%);}"];
  [@css ".css-ivpcb2t{color:hwb(0 0% 0% / 0.5);}"];
  [@css ".css-ivpcf0r{color:hwb(120 30% 50%);}"];
  [@css ".css-ivpcwno{color:hwb(120 30% 50% / 0.8);}"];
  [@css ".css-ivpcxcv{color:lab(0% 0 0);}"];
  [@css ".css-ivpc3fx{color:lab(0% 0 0 / 0.5);}"];
  [@css ".css-ivpcbbo{color:lab(50% 20 -30);}"];
  [@css ".css-ivpceww{color:lab(50% 20 -30 / 0.8);}"];
  [@css ".css-ivpcfnq{color:lch(0% 0 0);}"];
  [@css ".css-ivpc2ls{color:lch(0% 0 0 / 0.5);}"];
  [@css ".css-ivpc4jb{color:lch(50% 30 120);}"];
  [@css ".css-ivpch44{color:lch(50% 30 120 / 0.8);}"];
  [@css ".css-ivpcbsj{color:oklab(0% 0 0);}"];
  [@css ".css-ivpcf00{color:oklab(0% 0 0 / 0.5);}"];
  [@css ".css-ivpccd4{color:oklab(50% 0.1 -0.1);}"];
  [@css ".css-ivpcvfl{color:oklab(50% 0.1 -0.1 / 0.8);}"];
  [@css ".css-ivpc9qu{color:oklch(0% 0 0);}"];
  [@css ".css-ivpc1k5{color:oklch(0% 0 0 / 0.5);}"];
  [@css ".css-ivpcz2j{color:oklch(50% 0.15 120);}"];
  [@css ".css-ivpcuns{color:oklch(50% 0.15 120 / 0.8);}"];
  [@css ".css-ivpcnl2{color:light-dark(white, black);}"];
  [@css ".css-ivpchhk{color:light-dark(#fff, #000);}"];
  [@css ".css-ivpczen{color:light-dark(rgb(255, 255, 255), rgb(0, 0, 0));}"];
  [@css ".css-ivpc6od{background-color:light-dark(#f0f0f0, #1a1a1a);}"];
  [@css ".css-ivpcumr{color:color(srgb 1 0.5 0);}"];
  [@css ".css-ivpcufj{color:color(srgb 1 0.5 0 / 0.5);}"];
  [@css ".css-ivpcc30{color:color(display-p3 1 0.5 0);}"];
  [@css ".css-ivpc6c9{color:color(display-p3 1 0.5 0 / 0.5);}"];
  [@css ".css-ivpcguk{background-color:hwb(0 0% 0%);}"];
  [@css ".css-ivpcxwf{background-color:lab(50% 20 -30);}"];
  [@css ".css-ivpcddj{background-color:lch(50% 30 120);}"];
  [@css ".css-ivpcakm{background-color:oklab(50% 0.1 -0.1);}"];
  [@css ".css-ivpchzb{background-color:oklch(50% 0.15 120);}"];
  [@css.classes
    [
      ("css-ivpctbu", 0, "", "input.re", 4, 8, 4, 27),
      ("css-ivpcb2t", 1, "", "input.re", 5, 8, 5, 32),
      ("css-ivpcf0r", 2, "", "input.re", 6, 8, 6, 31),
      ("css-ivpcwno", 3, "", "input.re", 7, 8, 7, 37),
      ("css-ivpcxcv", 4, "", "input.re", 10, 8, 10, 26),
      ("css-ivpc3fx", 5, "", "input.re", 11, 8, 11, 31),
      ("css-ivpcbbo", 6, "", "input.re", 12, 8, 12, 30),
      ("css-ivpceww", 7, "", "input.re", 13, 8, 13, 36),
      ("css-ivpcfnq", 8, "", "input.re", 16, 8, 16, 26),
      ("css-ivpc2ls", 9, "", "input.re", 17, 8, 17, 31),
      ("css-ivpc4jb", 10, "", "input.re", 18, 8, 18, 30),
      ("css-ivpch44", 11, "", "input.re", 19, 8, 19, 36),
      ("css-ivpcbsj", 12, "", "input.re", 22, 8, 22, 28),
      ("css-ivpcf00", 13, "", "input.re", 23, 8, 23, 33),
      ("css-ivpccd4", 14, "", "input.re", 24, 8, 24, 34),
      ("css-ivpcvfl", 15, "", "input.re", 25, 8, 25, 40),
      ("css-ivpc9qu", 16, "", "input.re", 28, 8, 28, 28),
      ("css-ivpc1k5", 17, "", "input.re", 29, 8, 29, 33),
      ("css-ivpcz2j", 18, "", "input.re", 30, 8, 30, 34),
      ("css-ivpcuns", 19, "", "input.re", 31, 8, 31, 40),
      ("css-ivpcnl2", 20, "", "input.re", 34, 8, 34, 39),
      ("css-ivpchhk", 21, "", "input.re", 35, 8, 35, 37),
      ("css-ivpczen", 22, "", "input.re", 36, 8, 36, 59),
      ("css-ivpc6od", 23, "", "input.re", 37, 8, 37, 54),
      ("css-ivpcumr", 24, "", "input.re", 40, 8, 40, 34),
      ("css-ivpcufj", 25, "", "input.re", 41, 8, 41, 40),
      ("css-ivpcc30", 26, "", "input.re", 42, 8, 42, 40),
      ("css-ivpc6c9", 27, "", "input.re", 43, 8, 43, 46),
      ("css-ivpcguk", 28, "", "input.re", 46, 8, 46, 38),
      ("css-ivpcxwf", 29, "", "input.re", 47, 8, 47, 41),
      ("css-ivpcddj", 30, "", "input.re", 48, 8, 48, 41),
      ("css-ivpcakm", 31, "", "input.re", 49, 8, 49, 45),
      ("css-ivpchzb", 32, "", "input.re", 50, 8, 50, 45),
    ]
  ];
  
  CSS.make("css-ivpctbu", []);
  CSS.make("css-ivpcb2t", []);
  CSS.make("css-ivpcf0r", []);
  CSS.make("css-ivpcwno", []);
  
  CSS.make("css-ivpcxcv", []);
  CSS.make("css-ivpc3fx", []);
  CSS.make("css-ivpcbbo", []);
  CSS.make("css-ivpceww", []);
  
  CSS.make("css-ivpcfnq", []);
  CSS.make("css-ivpc2ls", []);
  CSS.make("css-ivpc4jb", []);
  CSS.make("css-ivpch44", []);
  
  CSS.make("css-ivpcbsj", []);
  CSS.make("css-ivpcf00", []);
  CSS.make("css-ivpccd4", []);
  CSS.make("css-ivpcvfl", []);
  
  CSS.make("css-ivpc9qu", []);
  CSS.make("css-ivpc1k5", []);
  CSS.make("css-ivpcz2j", []);
  CSS.make("css-ivpcuns", []);
  
  CSS.make("css-ivpcnl2", []);
  CSS.make("css-ivpchhk", []);
  CSS.make("css-ivpczen", []);
  CSS.make("css-ivpc6od", []);
  
  CSS.make("css-ivpcumr", []);
  CSS.make("css-ivpcufj", []);
  CSS.make("css-ivpcc30", []);
  CSS.make("css-ivpc6c9", []);
  
  CSS.make("css-ivpcguk", []);
  CSS.make("css-ivpcxwf", []);
  CSS.make("css-ivpcddj", []);
  CSS.make("css-ivpcakm", []);
  CSS.make("css-ivpchzb", []);
