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
  [@css ".css-ivpcfxf{contain:none;}"];
  [@css ".css-ivpcnjq{contain:strict;}"];
  [@css ".css-ivpccu8{contain:content;}"];
  [@css ".css-ivpcg5i{contain:size;}"];
  [@css ".css-ivpczf1{contain:layout;}"];
  [@css ".css-ivpc1dr{contain:paint;}"];
  [@css ".css-ivpczjb{contain:size layout;}"];
  [@css ".css-ivpc8vn{contain:size paint;}"];
  [@css ".css-ivpc488{contain:size layout paint;}"];
  [@css ".css-ivpcmdv{width:5cqw;}"];
  [@css ".css-ivpc9tu{width:5cqh;}"];
  [@css ".css-ivpceqv{width:5cqi;}"];
  [@css ".css-ivpce9s{width:5cqb;}"];
  [@css ".css-ivpcr6c{width:5cqmin;}"];
  [@css ".css-ivpcsu7{width:5cqmax;}"];
  [@css ".css-ivpce9t{container-type:normal;}"];
  [@css ".css-ivpc0r1{container-type:size;}"];
  [@css ".css-ivpcny7{container-type:inline-size;}"];
  [@css ".css-ivpce7l{container-name:none;}"];
  [@css ".css-ivpcu61{container-name:x;}"];
  [@css ".css-ivpc7uy{container-name:x y;}"];
  [@css ".css-ivpckoc{container:none;}"];
  [@css ".css-ivpcc8b{container:x / normal;}"];
  [@css ".css-ivpctgm{container:x / size;}"];
  [@css ".css-ivpcxt8{container:x / inline-size;}"];
  [@css ".css-ivpciky{container:x y / size;}"];
  [@css.classes
    [
      ("css-ivpcfxf", 0, "", "input.re", 2, 8, 2, 21),
      ("css-ivpcnjq", 1, "", "input.re", 3, 8, 3, 23),
      ("css-ivpccu8", 2, "", "input.re", 4, 8, 4, 24),
      ("css-ivpcg5i", 3, "", "input.re", 5, 8, 5, 21),
      ("css-ivpczf1", 4, "", "input.re", 6, 8, 6, 23),
      ("css-ivpc1dr", 5, "", "input.re", 7, 8, 7, 22),
      ("css-ivpczjb", 6, "", "input.re", 8, 8, 8, 28),
      ("css-ivpc8vn", 7, "", "input.re", 9, 8, 9, 27),
      ("css-ivpc488", 8, "", "input.re", 10, 8, 10, 34),
      ("css-ivpcmdv", 9, "", "input.re", 22, 8, 22, 20),
      ("css-ivpc9tu", 10, "", "input.re", 23, 8, 23, 20),
      ("css-ivpceqv", 11, "", "input.re", 24, 8, 24, 20),
      ("css-ivpce9s", 12, "", "input.re", 25, 8, 25, 20),
      ("css-ivpcr6c", 13, "", "input.re", 26, 8, 26, 22),
      ("css-ivpcsu7", 14, "", "input.re", 27, 8, 27, 22),
      ("css-ivpce9t", 15, "", "input.re", 28, 8, 28, 30),
      ("css-ivpc0r1", 16, "", "input.re", 29, 8, 29, 28),
      ("css-ivpcny7", 17, "", "input.re", 30, 8, 30, 35),
      ("css-ivpce7l", 18, "", "input.re", 31, 8, 31, 28),
      ("css-ivpcu61", 19, "", "input.re", 32, 8, 32, 25),
      ("css-ivpc7uy", 20, "", "input.re", 33, 8, 33, 27),
      ("css-ivpckoc", 21, "", "input.re", 34, 8, 34, 23),
      ("css-ivpcc8b", 22, "", "input.re", 35, 8, 35, 29),
      ("css-ivpctgm", 23, "", "input.re", 36, 8, 36, 27),
      ("css-ivpcxt8", 24, "", "input.re", 37, 8, 37, 34),
      ("css-ivpciky", 25, "", "input.re", 38, 8, 38, 29),
    ]
  ];
  
  CSS.make("css-ivpcfxf", []);
  CSS.make("css-ivpcnjq", []);
  CSS.make("css-ivpccu8", []);
  CSS.make("css-ivpcg5i", []);
  CSS.make("css-ivpczf1", []);
  CSS.make("css-ivpc1dr", []);
  CSS.make("css-ivpczjb", []);
  CSS.make("css-ivpc8vn", []);
  CSS.make("css-ivpc488", []);
  
  CSS.make("css-ivpcmdv", []);
  CSS.make("css-ivpc9tu", []);
  CSS.make("css-ivpceqv", []);
  CSS.make("css-ivpce9s", []);
  CSS.make("css-ivpcr6c", []);
  CSS.make("css-ivpcsu7", []);
  CSS.make("css-ivpce9t", []);
  CSS.make("css-ivpc0r1", []);
  CSS.make("css-ivpcny7", []);
  CSS.make("css-ivpce7l", []);
  CSS.make("css-ivpcu61", []);
  CSS.make("css-ivpc7uy", []);
  CSS.make("css-ivpckoc", []);
  CSS.make("css-ivpcc8b", []);
  CSS.make("css-ivpctgm", []);
  CSS.make("css-ivpcxt8", []);
  CSS.make("css-ivpciky", []);
