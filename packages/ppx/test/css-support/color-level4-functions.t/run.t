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
  [@css ".css-bnptbu{color:hwb(0 0% 0%);}"];
  [@css ".css-1mblb2t{color:hwb(0 0% 0% / 0.5);}"];
  [@css ".css-lg1f0r{color:hwb(120 30% 50%);}"];
  [@css ".css-ormwno{color:hwb(120 30% 50% / 0.8);}"];
  [@css ".css-ur1xcv{color:lab(0% 0 0);}"];
  [@css ".css-1iql3fx{color:lab(0% 0 0 / 0.5);}"];
  [@css ".css-hjgbbo{color:lab(50% 20 -30);}"];
  [@css ".css-18cjeww{color:lab(50% 20 -30 / 0.8);}"];
  [@css ".css-11vkfnq{color:lch(0% 0 0);}"];
  [@css ".css-u1q2ls{color:lch(0% 0 0 / 0.5);}"];
  [@css ".css-148g4jb{color:lch(50% 30 120);}"];
  [@css ".css-1abbh44{color:lch(50% 30 120 / 0.8);}"];
  [@css ".css-10pmbsj{color:oklab(0% 0 0);}"];
  [@css ".css-8gkf00{color:oklab(0% 0 0 / 0.5);}"];
  [@css ".css-1ipacd4{color:oklab(50% 0.1 -0.1);}"];
  [@css ".css-jcgvfl{color:oklab(50% 0.1 -0.1 / 0.8);}"];
  [@css ".css-s5w9qu{color:oklch(0% 0 0);}"];
  [@css ".css-1p4h1k5{color:oklch(0% 0 0 / 0.5);}"];
  [@css ".css-1055z2j{color:oklch(50% 0.15 120);}"];
  [@css ".css-1h9luns{color:oklch(50% 0.15 120 / 0.8);}"];
  [@css ".css-cp1nl2{color:light-dark(white, black);}"];
  [@css ".css-mvuhhk{color:light-dark(#fff, #000);}"];
  [@css ".css-rh7zen{color:light-dark(rgb(255, 255, 255), rgb(0, 0, 0));}"];
  [@css ".css-1dh06od{background-color:light-dark(#f0f0f0, #1a1a1a);}"];
  [@css ".css-1ghxumr{color:color(srgb 1 0.5 0);}"];
  [@css ".css-gjwufj{color:color(srgb 1 0.5 0 / 0.5);}"];
  [@css ".css-x07c30{color:color(display-p3 1 0.5 0);}"];
  [@css ".css-1stm6c9{color:color(display-p3 1 0.5 0 / 0.5);}"];
  [@css ".css-1u31guk{background-color:hwb(0 0% 0%);}"];
  [@css ".css-e66xwf{background-color:lab(50% 20 -30);}"];
  [@css ".css-1u31ddj{background-color:lch(50% 30 120);}"];
  [@css ".css-ctwakm{background-color:oklab(50% 0.1 -0.1);}"];
  [@css ".css-1hvbhzb{background-color:oklch(50% 0.15 120);}"];
  [@css.classes
    [
      ("css-bnptbu", 0, "", "input.re", 4, 8, 4, 27),
      ("css-1mblb2t", 1, "", "input.re", 5, 8, 5, 32),
      ("css-lg1f0r", 2, "", "input.re", 6, 8, 6, 31),
      ("css-ormwno", 3, "", "input.re", 7, 8, 7, 37),
      ("css-ur1xcv", 4, "", "input.re", 10, 8, 10, 26),
      ("css-1iql3fx", 5, "", "input.re", 11, 8, 11, 31),
      ("css-hjgbbo", 6, "", "input.re", 12, 8, 12, 30),
      ("css-18cjeww", 7, "", "input.re", 13, 8, 13, 36),
      ("css-11vkfnq", 8, "", "input.re", 16, 8, 16, 26),
      ("css-u1q2ls", 9, "", "input.re", 17, 8, 17, 31),
      ("css-148g4jb", 10, "", "input.re", 18, 8, 18, 30),
      ("css-1abbh44", 11, "", "input.re", 19, 8, 19, 36),
      ("css-10pmbsj", 12, "", "input.re", 22, 8, 22, 28),
      ("css-8gkf00", 13, "", "input.re", 23, 8, 23, 33),
      ("css-1ipacd4", 14, "", "input.re", 24, 8, 24, 34),
      ("css-jcgvfl", 15, "", "input.re", 25, 8, 25, 40),
      ("css-s5w9qu", 16, "", "input.re", 28, 8, 28, 28),
      ("css-1p4h1k5", 17, "", "input.re", 29, 8, 29, 33),
      ("css-1055z2j", 18, "", "input.re", 30, 8, 30, 34),
      ("css-1h9luns", 19, "", "input.re", 31, 8, 31, 40),
      ("css-cp1nl2", 20, "", "input.re", 34, 8, 34, 39),
      ("css-mvuhhk", 21, "", "input.re", 35, 8, 35, 37),
      ("css-rh7zen", 22, "", "input.re", 36, 8, 36, 59),
      ("css-1dh06od", 23, "", "input.re", 37, 8, 37, 54),
      ("css-1ghxumr", 24, "", "input.re", 40, 8, 40, 34),
      ("css-gjwufj", 25, "", "input.re", 41, 8, 41, 40),
      ("css-x07c30", 26, "", "input.re", 42, 8, 42, 40),
      ("css-1stm6c9", 27, "", "input.re", 43, 8, 43, 46),
      ("css-1u31guk", 28, "", "input.re", 46, 8, 46, 38),
      ("css-e66xwf", 29, "", "input.re", 47, 8, 47, 41),
      ("css-1u31ddj", 30, "", "input.re", 48, 8, 48, 41),
      ("css-ctwakm", 31, "", "input.re", 49, 8, 49, 45),
      ("css-1hvbhzb", 32, "", "input.re", 50, 8, 50, 45),
    ]
  ];
  
  CSS.make("css-bnptbu", []);
  CSS.make("css-1mblb2t", []);
  CSS.make("css-lg1f0r", []);
  CSS.make("css-ormwno", []);
  
  CSS.make("css-ur1xcv", []);
  CSS.make("css-1iql3fx", []);
  CSS.make("css-hjgbbo", []);
  CSS.make("css-18cjeww", []);
  
  CSS.make("css-11vkfnq", []);
  CSS.make("css-u1q2ls", []);
  CSS.make("css-148g4jb", []);
  CSS.make("css-1abbh44", []);
  
  CSS.make("css-10pmbsj", []);
  CSS.make("css-8gkf00", []);
  CSS.make("css-1ipacd4", []);
  CSS.make("css-jcgvfl", []);
  
  CSS.make("css-s5w9qu", []);
  CSS.make("css-1p4h1k5", []);
  CSS.make("css-1055z2j", []);
  CSS.make("css-1h9luns", []);
  
  CSS.make("css-cp1nl2", []);
  CSS.make("css-mvuhhk", []);
  CSS.make("css-rh7zen", []);
  CSS.make("css-1dh06od", []);
  
  CSS.make("css-1ghxumr", []);
  CSS.make("css-gjwufj", []);
  CSS.make("css-x07c30", []);
  CSS.make("css-1stm6c9", []);
  
  CSS.make("css-1u31guk", []);
  CSS.make("css-e66xwf", []);
  CSS.make("css-1u31ddj", []);
  CSS.make("css-ctwakm", []);
  CSS.make("css-1hvbhzb", []);
