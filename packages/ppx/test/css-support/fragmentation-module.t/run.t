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
  [@css ".css-ivpc611{break-before:auto;}"];
  [@css ".css-ivpc0ak{break-before:avoid;}"];
  [@css ".css-ivpcpr3{break-before:avoid-page;}"];
  [@css ".css-ivpcblt{break-before:page;}"];
  [@css ".css-ivpc0co{break-before:left;}"];
  [@css ".css-ivpcid0{break-before:right;}"];
  [@css ".css-ivpcpq1{break-before:recto;}"];
  [@css ".css-ivpc3ya{break-before:verso;}"];
  [@css ".css-ivpcox0{break-before:avoid-column;}"];
  [@css ".css-ivpcqs1{break-before:column;}"];
  [@css ".css-ivpccmu{break-before:avoid-region;}"];
  [@css ".css-ivpcmzh{break-before:region;}"];
  [@css ".css-ivpc88d{break-after:auto;}"];
  [@css ".css-ivpcae4{break-after:avoid;}"];
  [@css ".css-ivpcta3{break-after:avoid-page;}"];
  [@css ".css-ivpcjq4{break-after:page;}"];
  [@css ".css-ivpcfu3{break-after:left;}"];
  [@css ".css-ivpcjwh{break-after:right;}"];
  [@css ".css-ivpctnq{break-after:recto;}"];
  [@css ".css-ivpchu0{break-after:verso;}"];
  [@css ".css-ivpcn6f{break-after:avoid-column;}"];
  [@css ".css-ivpcuom{break-after:column;}"];
  [@css ".css-ivpcfvv{break-after:avoid-region;}"];
  [@css ".css-ivpcsf5{break-after:region;}"];
  [@css ".css-ivpc12g{break-inside:auto;}"];
  [@css ".css-ivpcoos{break-inside:avoid;}"];
  [@css ".css-ivpcctb{break-inside:avoid-page;}"];
  [@css ".css-ivpcri8{break-inside:avoid-column;}"];
  [@css ".css-ivpc6os{break-inside:avoid-region;}"];
  [@css
    ".css-ivpc13g{-webkit-box-decoration-break:slice;box-decoration-break:slice;}"
  ];
  [@css
    ".css-ivpc0mn{-webkit-box-decoration-break:clone;box-decoration-break:clone;}"
  ];
  [@css ".css-ivpccyg{orphans:1;}"];
  [@css ".css-ivpccmv{orphans:2;}"];
  [@css ".css-ivpcze3{widows:1;}"];
  [@css ".css-ivpc8eo{widows:2;}"];
  [@css.classes
    [
      ("css-ivpc611", 0, "", "input.re", 2, 8, 2, 26),
      ("css-ivpc0ak", 1, "", "input.re", 3, 8, 3, 27),
      ("css-ivpcpr3", 2, "", "input.re", 4, 8, 4, 32),
      ("css-ivpcblt", 3, "", "input.re", 5, 8, 5, 26),
      ("css-ivpc0co", 4, "", "input.re", 6, 8, 6, 26),
      ("css-ivpcid0", 5, "", "input.re", 7, 8, 7, 27),
      ("css-ivpcpq1", 6, "", "input.re", 8, 8, 8, 27),
      ("css-ivpc3ya", 7, "", "input.re", 9, 8, 9, 27),
      ("css-ivpcox0", 8, "", "input.re", 10, 8, 10, 34),
      ("css-ivpcqs1", 9, "", "input.re", 11, 8, 11, 28),
      ("css-ivpccmu", 10, "", "input.re", 12, 8, 12, 34),
      ("css-ivpcmzh", 11, "", "input.re", 13, 8, 13, 28),
      ("css-ivpc88d", 12, "", "input.re", 14, 8, 14, 25),
      ("css-ivpcae4", 13, "", "input.re", 15, 8, 15, 26),
      ("css-ivpcta3", 14, "", "input.re", 16, 8, 16, 31),
      ("css-ivpcjq4", 15, "", "input.re", 17, 8, 17, 25),
      ("css-ivpcfu3", 16, "", "input.re", 18, 8, 18, 25),
      ("css-ivpcjwh", 17, "", "input.re", 19, 8, 19, 26),
      ("css-ivpctnq", 18, "", "input.re", 20, 8, 20, 26),
      ("css-ivpchu0", 19, "", "input.re", 21, 8, 21, 26),
      ("css-ivpcn6f", 20, "", "input.re", 22, 8, 22, 33),
      ("css-ivpcuom", 21, "", "input.re", 23, 8, 23, 27),
      ("css-ivpcfvv", 22, "", "input.re", 24, 8, 24, 33),
      ("css-ivpcsf5", 23, "", "input.re", 25, 8, 25, 27),
      ("css-ivpc12g", 24, "", "input.re", 26, 8, 26, 26),
      ("css-ivpcoos", 25, "", "input.re", 27, 8, 27, 27),
      ("css-ivpcctb", 26, "", "input.re", 28, 8, 28, 32),
      ("css-ivpcri8", 27, "", "input.re", 29, 8, 29, 34),
      ("css-ivpc6os", 28, "", "input.re", 30, 8, 30, 34),
      ("css-ivpc13g", 29, "", "input.re", 31, 8, 31, 35),
      ("css-ivpc0mn", 30, "", "input.re", 32, 8, 32, 35),
      ("css-ivpccyg", 31, "", "input.re", 33, 8, 33, 18),
      ("css-ivpccmv", 32, "", "input.re", 34, 8, 34, 18),
      ("css-ivpcze3", 33, "", "input.re", 36, 8, 36, 17),
      ("css-ivpc8eo", 34, "", "input.re", 37, 8, 37, 17),
    ]
  ];
  
  CSS.make("css-ivpc611", []);
  CSS.make("css-ivpc0ak", []);
  CSS.make("css-ivpcpr3", []);
  CSS.make("css-ivpcblt", []);
  CSS.make("css-ivpc0co", []);
  CSS.make("css-ivpcid0", []);
  CSS.make("css-ivpcpq1", []);
  CSS.make("css-ivpc3ya", []);
  CSS.make("css-ivpcox0", []);
  CSS.make("css-ivpcqs1", []);
  CSS.make("css-ivpccmu", []);
  CSS.make("css-ivpcmzh", []);
  CSS.make("css-ivpc88d", []);
  CSS.make("css-ivpcae4", []);
  CSS.make("css-ivpcta3", []);
  CSS.make("css-ivpcjq4", []);
  CSS.make("css-ivpcfu3", []);
  CSS.make("css-ivpcjwh", []);
  CSS.make("css-ivpctnq", []);
  CSS.make("css-ivpchu0", []);
  CSS.make("css-ivpcn6f", []);
  CSS.make("css-ivpcuom", []);
  CSS.make("css-ivpcfvv", []);
  CSS.make("css-ivpcsf5", []);
  CSS.make("css-ivpc12g", []);
  CSS.make("css-ivpcoos", []);
  CSS.make("css-ivpcctb", []);
  CSS.make("css-ivpcri8", []);
  CSS.make("css-ivpc6os", []);
  CSS.make("css-ivpc13g", []);
  CSS.make("css-ivpc0mn", []);
  CSS.make("css-ivpccyg", []);
  CSS.make("css-ivpccmv", []);
  
  CSS.make("css-ivpcze3", []);
  CSS.make("css-ivpc8eo", []);
