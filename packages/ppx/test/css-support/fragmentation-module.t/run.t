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
  [@css ".css-j6x611{break-before:auto;}"];
  [@css ".css-4h10ak{break-before:avoid;}"];
  [@css ".css-193epr3{break-before:avoid-page;}"];
  [@css ".css-f7dblt{break-before:page;}"];
  [@css ".css-21h0co{break-before:left;}"];
  [@css ".css-1y81id0{break-before:right;}"];
  [@css ".css-184hpq1{break-before:recto;}"];
  [@css ".css-1tnq3ya{break-before:verso;}"];
  [@css ".css-1n52ox0{break-before:avoid-column;}"];
  [@css ".css-1s45qs1{break-before:column;}"];
  [@css ".css-feacmu{break-before:avoid-region;}"];
  [@css ".css-10scmzh{break-before:region;}"];
  [@css ".css-19b688d{break-after:auto;}"];
  [@css ".css-bw4ae4{break-after:avoid;}"];
  [@css ".css-kzwta3{break-after:avoid-page;}"];
  [@css ".css-1ld7jq4{break-after:page;}"];
  [@css ".css-kpffu3{break-after:left;}"];
  [@css ".css-vusjwh{break-after:right;}"];
  [@css ".css-2gftnq{break-after:recto;}"];
  [@css ".css-1hslhu0{break-after:verso;}"];
  [@css ".css-1edkn6f{break-after:avoid-column;}"];
  [@css ".css-nr8uom{break-after:column;}"];
  [@css ".css-jjhfvv{break-after:avoid-region;}"];
  [@css ".css-ffksf5{break-after:region;}"];
  [@css ".css-10jy12g{break-inside:auto;}"];
  [@css ".css-1wzeoos{break-inside:avoid;}"];
  [@css ".css-188ctb{break-inside:avoid-page;}"];
  [@css ".css-18lsri8{break-inside:avoid-column;}"];
  [@css ".css-183w6os{break-inside:avoid-region;}"];
  [@css
    ".css-16p713g{-webkit-box-decoration-break:slice;box-decoration-break:slice;}"
  ];
  [@css
    ".css-xc20mn{-webkit-box-decoration-break:clone;box-decoration-break:clone;}"
  ];
  [@css ".css-kv3cyg{orphans:1;}"];
  [@css ".css-jvbcmv{orphans:2;}"];
  [@css ".css-1qvwze3{widows:1;}"];
  [@css ".css-1g7s8eo{widows:2;}"];
  [@css.classes
    [
      ("css-j6x611", 0, "", "input.re", 2, 8, 2, 26),
      ("css-4h10ak", 1, "", "input.re", 3, 8, 3, 27),
      ("css-193epr3", 2, "", "input.re", 4, 8, 4, 32),
      ("css-f7dblt", 3, "", "input.re", 5, 8, 5, 26),
      ("css-21h0co", 4, "", "input.re", 6, 8, 6, 26),
      ("css-1y81id0", 5, "", "input.re", 7, 8, 7, 27),
      ("css-184hpq1", 6, "", "input.re", 8, 8, 8, 27),
      ("css-1tnq3ya", 7, "", "input.re", 9, 8, 9, 27),
      ("css-1n52ox0", 8, "", "input.re", 10, 8, 10, 34),
      ("css-1s45qs1", 9, "", "input.re", 11, 8, 11, 28),
      ("css-feacmu", 10, "", "input.re", 12, 8, 12, 34),
      ("css-10scmzh", 11, "", "input.re", 13, 8, 13, 28),
      ("css-19b688d", 12, "", "input.re", 14, 8, 14, 25),
      ("css-bw4ae4", 13, "", "input.re", 15, 8, 15, 26),
      ("css-kzwta3", 14, "", "input.re", 16, 8, 16, 31),
      ("css-1ld7jq4", 15, "", "input.re", 17, 8, 17, 25),
      ("css-kpffu3", 16, "", "input.re", 18, 8, 18, 25),
      ("css-vusjwh", 17, "", "input.re", 19, 8, 19, 26),
      ("css-2gftnq", 18, "", "input.re", 20, 8, 20, 26),
      ("css-1hslhu0", 19, "", "input.re", 21, 8, 21, 26),
      ("css-1edkn6f", 20, "", "input.re", 22, 8, 22, 33),
      ("css-nr8uom", 21, "", "input.re", 23, 8, 23, 27),
      ("css-jjhfvv", 22, "", "input.re", 24, 8, 24, 33),
      ("css-ffksf5", 23, "", "input.re", 25, 8, 25, 27),
      ("css-10jy12g", 24, "", "input.re", 26, 8, 26, 26),
      ("css-1wzeoos", 25, "", "input.re", 27, 8, 27, 27),
      ("css-188ctb", 26, "", "input.re", 28, 8, 28, 32),
      ("css-18lsri8", 27, "", "input.re", 29, 8, 29, 34),
      ("css-183w6os", 28, "", "input.re", 30, 8, 30, 34),
      ("css-16p713g", 29, "", "input.re", 31, 8, 31, 35),
      ("css-xc20mn", 30, "", "input.re", 32, 8, 32, 35),
      ("css-kv3cyg", 31, "", "input.re", 33, 8, 33, 18),
      ("css-jvbcmv", 32, "", "input.re", 34, 8, 34, 18),
      ("css-1qvwze3", 33, "", "input.re", 36, 8, 36, 17),
      ("css-1g7s8eo", 34, "", "input.re", 37, 8, 37, 17),
    ]
  ];
  
  CSS.make("css-j6x611", []);
  CSS.make("css-4h10ak", []);
  CSS.make("css-193epr3", []);
  CSS.make("css-f7dblt", []);
  CSS.make("css-21h0co", []);
  CSS.make("css-1y81id0", []);
  CSS.make("css-184hpq1", []);
  CSS.make("css-1tnq3ya", []);
  CSS.make("css-1n52ox0", []);
  CSS.make("css-1s45qs1", []);
  CSS.make("css-feacmu", []);
  CSS.make("css-10scmzh", []);
  CSS.make("css-19b688d", []);
  CSS.make("css-bw4ae4", []);
  CSS.make("css-kzwta3", []);
  CSS.make("css-1ld7jq4", []);
  CSS.make("css-kpffu3", []);
  CSS.make("css-vusjwh", []);
  CSS.make("css-2gftnq", []);
  CSS.make("css-1hslhu0", []);
  CSS.make("css-1edkn6f", []);
  CSS.make("css-nr8uom", []);
  CSS.make("css-jjhfvv", []);
  CSS.make("css-ffksf5", []);
  CSS.make("css-10jy12g", []);
  CSS.make("css-1wzeoos", []);
  CSS.make("css-188ctb", []);
  CSS.make("css-18lsri8", []);
  CSS.make("css-183w6os", []);
  CSS.make("css-16p713g", []);
  CSS.make("css-xc20mn", []);
  CSS.make("css-kv3cyg", []);
  CSS.make("css-jvbcmv", []);
  
  CSS.make("css-1qvwze3", []);
  CSS.make("css-1g7s8eo", []);
