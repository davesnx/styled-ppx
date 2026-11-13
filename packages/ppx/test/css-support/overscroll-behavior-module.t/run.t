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
  [@css ".css-183qc41{overscroll-behavior:contain;}"];
  [@css ".css-1tcabbe{overscroll-behavior:none;}"];
  [@css ".css-1ftofrx{overscroll-behavior:auto;}"];
  [@css ".css-xmtpkl{overscroll-behavior:contain contain;}"];
  [@css ".css-ahymta{overscroll-behavior:none contain;}"];
  [@css ".css-13bil7o{overscroll-behavior:auto contain;}"];
  [@css ".css-1pgaylk{overscroll-behavior:contain none;}"];
  [@css ".css-8e2i3v{overscroll-behavior:none none;}"];
  [@css ".css-1n852e{overscroll-behavior:auto none;}"];
  [@css ".css-1cesl7z{overscroll-behavior:contain auto;}"];
  [@css ".css-bbenn7{overscroll-behavior:none auto;}"];
  [@css ".css-ynwlrd{overscroll-behavior:auto auto;}"];
  [@css ".css-10cg5qt{overscroll-behavior-x:contain;}"];
  [@css ".css-144hd2r{overscroll-behavior-x:none;}"];
  [@css ".css-wdcbio{overscroll-behavior-x:auto;}"];
  [@css ".css-6qqbu4{overscroll-behavior-y:contain;}"];
  [@css ".css-1fdrc1e{overscroll-behavior-y:none;}"];
  [@css ".css-3rcoki{overscroll-behavior-y:auto;}"];
  [@css ".css-6rvysl{overscroll-behavior-inline:contain;}"];
  [@css ".css-1w8wqx2{overscroll-behavior-inline:none;}"];
  [@css ".css-1w2dg7m{overscroll-behavior-inline:auto;}"];
  [@css ".css-kb1t74{overscroll-behavior-block:contain;}"];
  [@css ".css-t3ggkg{overscroll-behavior-block:none;}"];
  [@css ".css-yuokuo{overscroll-behavior-block:auto;}"];
  [@css.classes
    [
      ("css-183qc41", 0, "", "input.re", 2, 8, 2, 36),
      ("css-1tcabbe", 1, "", "input.re", 3, 8, 3, 33),
      ("css-1ftofrx", 2, "", "input.re", 4, 8, 4, 33),
      ("css-xmtpkl", 3, "", "input.re", 5, 8, 5, 44),
      ("css-ahymta", 4, "", "input.re", 6, 8, 6, 41),
      ("css-13bil7o", 5, "", "input.re", 7, 8, 7, 41),
      ("css-1pgaylk", 6, "", "input.re", 8, 8, 8, 41),
      ("css-8e2i3v", 7, "", "input.re", 9, 8, 9, 38),
      ("css-1n852e", 8, "", "input.re", 10, 8, 10, 38),
      ("css-1cesl7z", 9, "", "input.re", 11, 8, 11, 41),
      ("css-bbenn7", 10, "", "input.re", 12, 8, 12, 38),
      ("css-ynwlrd", 11, "", "input.re", 13, 8, 13, 38),
      ("css-10cg5qt", 12, "", "input.re", 14, 8, 14, 38),
      ("css-144hd2r", 13, "", "input.re", 15, 8, 15, 35),
      ("css-wdcbio", 14, "", "input.re", 16, 8, 16, 35),
      ("css-6qqbu4", 15, "", "input.re", 17, 8, 17, 38),
      ("css-1fdrc1e", 16, "", "input.re", 18, 8, 18, 35),
      ("css-3rcoki", 17, "", "input.re", 19, 8, 19, 35),
      ("css-6rvysl", 18, "", "input.re", 20, 8, 20, 43),
      ("css-1w8wqx2", 19, "", "input.re", 21, 8, 21, 40),
      ("css-1w2dg7m", 20, "", "input.re", 22, 8, 22, 40),
      ("css-kb1t74", 21, "", "input.re", 23, 8, 23, 42),
      ("css-t3ggkg", 22, "", "input.re", 24, 8, 24, 39),
      ("css-yuokuo", 23, "", "input.re", 25, 8, 25, 39),
    ]
  ];
  
  CSS.make("css-183qc41", []);
  CSS.make("css-1tcabbe", []);
  CSS.make("css-1ftofrx", []);
  CSS.make("css-xmtpkl", []);
  CSS.make("css-ahymta", []);
  CSS.make("css-13bil7o", []);
  CSS.make("css-1pgaylk", []);
  CSS.make("css-8e2i3v", []);
  CSS.make("css-1n852e", []);
  CSS.make("css-1cesl7z", []);
  CSS.make("css-bbenn7", []);
  CSS.make("css-ynwlrd", []);
  CSS.make("css-10cg5qt", []);
  CSS.make("css-144hd2r", []);
  CSS.make("css-wdcbio", []);
  CSS.make("css-6qqbu4", []);
  CSS.make("css-1fdrc1e", []);
  CSS.make("css-3rcoki", []);
  CSS.make("css-6rvysl", []);
  CSS.make("css-1w8wqx2", []);
  CSS.make("css-1w2dg7m", []);
  CSS.make("css-kb1t74", []);
  CSS.make("css-t3ggkg", []);
  CSS.make("css-yuokuo", []);
