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
  [@css ".css-ivpcc41{overscroll-behavior:contain;}"];
  [@css ".css-ivpcbbe{overscroll-behavior:none;}"];
  [@css ".css-ivpcfrx{overscroll-behavior:auto;}"];
  [@css ".css-ivpcpkl{overscroll-behavior:contain contain;}"];
  [@css ".css-ivpcmta{overscroll-behavior:none contain;}"];
  [@css ".css-ivpcl7o{overscroll-behavior:auto contain;}"];
  [@css ".css-ivpcylk{overscroll-behavior:contain none;}"];
  [@css ".css-ivpci3v{overscroll-behavior:none none;}"];
  [@css ".css-ivpc52e{overscroll-behavior:auto none;}"];
  [@css ".css-ivpcl7z{overscroll-behavior:contain auto;}"];
  [@css ".css-ivpcnn7{overscroll-behavior:none auto;}"];
  [@css ".css-ivpclrd{overscroll-behavior:auto auto;}"];
  [@css ".css-ivpc5qt{overscroll-behavior-x:contain;}"];
  [@css ".css-ivpcd2r{overscroll-behavior-x:none;}"];
  [@css ".css-ivpcbio{overscroll-behavior-x:auto;}"];
  [@css ".css-ivpcbu4{overscroll-behavior-y:contain;}"];
  [@css ".css-ivpcc1e{overscroll-behavior-y:none;}"];
  [@css ".css-ivpcoki{overscroll-behavior-y:auto;}"];
  [@css ".css-ivpcysl{overscroll-behavior-inline:contain;}"];
  [@css ".css-ivpcqx2{overscroll-behavior-inline:none;}"];
  [@css ".css-ivpcg7m{overscroll-behavior-inline:auto;}"];
  [@css ".css-ivpct74{overscroll-behavior-block:contain;}"];
  [@css ".css-ivpcgkg{overscroll-behavior-block:none;}"];
  [@css ".css-ivpckuo{overscroll-behavior-block:auto;}"];
  [@css.classes
    [
      ("css-ivpcc41", 0, "", "input.re", 2, 8, 2, 36),
      ("css-ivpcbbe", 1, "", "input.re", 3, 8, 3, 33),
      ("css-ivpcfrx", 2, "", "input.re", 4, 8, 4, 33),
      ("css-ivpcpkl", 3, "", "input.re", 5, 8, 5, 44),
      ("css-ivpcmta", 4, "", "input.re", 6, 8, 6, 41),
      ("css-ivpcl7o", 5, "", "input.re", 7, 8, 7, 41),
      ("css-ivpcylk", 6, "", "input.re", 8, 8, 8, 41),
      ("css-ivpci3v", 7, "", "input.re", 9, 8, 9, 38),
      ("css-ivpc52e", 8, "", "input.re", 10, 8, 10, 38),
      ("css-ivpcl7z", 9, "", "input.re", 11, 8, 11, 41),
      ("css-ivpcnn7", 10, "", "input.re", 12, 8, 12, 38),
      ("css-ivpclrd", 11, "", "input.re", 13, 8, 13, 38),
      ("css-ivpc5qt", 12, "", "input.re", 14, 8, 14, 38),
      ("css-ivpcd2r", 13, "", "input.re", 15, 8, 15, 35),
      ("css-ivpcbio", 14, "", "input.re", 16, 8, 16, 35),
      ("css-ivpcbu4", 15, "", "input.re", 17, 8, 17, 38),
      ("css-ivpcc1e", 16, "", "input.re", 18, 8, 18, 35),
      ("css-ivpcoki", 17, "", "input.re", 19, 8, 19, 35),
      ("css-ivpcysl", 18, "", "input.re", 20, 8, 20, 43),
      ("css-ivpcqx2", 19, "", "input.re", 21, 8, 21, 40),
      ("css-ivpcg7m", 20, "", "input.re", 22, 8, 22, 40),
      ("css-ivpct74", 21, "", "input.re", 23, 8, 23, 42),
      ("css-ivpcgkg", 22, "", "input.re", 24, 8, 24, 39),
      ("css-ivpckuo", 23, "", "input.re", 25, 8, 25, 39),
    ]
  ];
  
  CSS.make("css-ivpcc41", []);
  CSS.make("css-ivpcbbe", []);
  CSS.make("css-ivpcfrx", []);
  CSS.make("css-ivpcpkl", []);
  CSS.make("css-ivpcmta", []);
  CSS.make("css-ivpcl7o", []);
  CSS.make("css-ivpcylk", []);
  CSS.make("css-ivpci3v", []);
  CSS.make("css-ivpc52e", []);
  CSS.make("css-ivpcl7z", []);
  CSS.make("css-ivpcnn7", []);
  CSS.make("css-ivpclrd", []);
  CSS.make("css-ivpc5qt", []);
  CSS.make("css-ivpcd2r", []);
  CSS.make("css-ivpcbio", []);
  CSS.make("css-ivpcbu4", []);
  CSS.make("css-ivpcc1e", []);
  CSS.make("css-ivpcoki", []);
  CSS.make("css-ivpcysl", []);
  CSS.make("css-ivpcqx2", []);
  CSS.make("css-ivpcg7m", []);
  CSS.make("css-ivpct74", []);
  CSS.make("css-ivpcgkg", []);
  CSS.make("css-ivpckuo", []);
