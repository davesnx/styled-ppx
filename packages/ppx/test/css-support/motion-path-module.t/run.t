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
  [@css ".css-ivpc5x4{offset:none;}"];
  [@css ".css-ivpc3qe{offset:auto;}"];
  [@css ".css-ivpcftm{offset:center;}"];
  [@css ".css-ivpcabw{offset:200px 100px;}"];
  [@css ".css-ivpco3m{offset:margin-box;}"];
  [@css ".css-ivpc8oo{offset:border-box;}"];
  [@css ".css-ivpcqt7{offset:padding-box;}"];
  [@css ".css-ivpchvi{offset:content-box;}"];
  [@css ".css-ivpc61x{offset:fill-box;}"];
  [@css ".css-ivpchr6{offset:stroke-box;}"];
  [@css ".css-ivpcg2w{offset:view-box;}"];
  [@css ".css-ivpcbx6{offset:path(\"M 20 20 H 80 V 30\");}"];
  [@css ".css-ivpc3fb{offset:url(\"image.png\");}"];
  [@css ".css-ivpc47f{offset:ray(45deg closest-side);}"];
  [@css ".css-ivpcuzn{offset:ray(45deg closest-side) 10%;}"];
  [@css ".css-ivpcnlq{offset:ray(45deg closest-side) 10% reverse;}"];
  [@css ".css-ivpc8c0{offset:ray(45deg closest-side) reverse 10%;}"];
  [@css ".css-ivpcxhq{offset:auto / center;}"];
  [@css ".css-ivpca9h{offset:center / 200px 100px;}"];
  [@css ".css-ivpc769{offset:ray(45deg closest-side) / 200px 100px;}"];
  [@css ".css-ivpcixe{offset-path:none;}"];
  [@css ".css-ivpcpiv{offset-path:ray(45deg closest-side);}"];
  [@css ".css-ivpcmk6{offset-path:ray(45deg farthest-side);}"];
  [@css ".css-ivpce20{offset-path:ray(45deg closest-corner);}"];
  [@css ".css-ivpcyru{offset-path:ray(45deg farthest-corner);}"];
  [@css ".css-ivpcsys{offset-path:ray(100grad closest-side contain);}"];
  [@css ".css-ivpcn0q{offset-path:margin-box;}"];
  [@css ".css-ivpcxsd{offset-path:border-box;}"];
  [@css ".css-ivpco1o{offset-path:padding-box;}"];
  [@css ".css-ivpcmvc{offset-path:content-box;}"];
  [@css ".css-ivpc30m{offset-path:fill-box;}"];
  [@css ".css-ivpcaxm{offset-path:stroke-box;}"];
  [@css ".css-ivpc5gy{offset-path:view-box;}"];
  [@css ".css-ivpcjyf{offset-path:circle(60%) margin-box;}"];
  [@css ".css-ivpcupb{offset-distance:10%;}"];
  [@css ".css-ivpcmow{offset-position:auto;}"];
  [@css ".css-ivpcscp{offset-position:200px;}"];
  [@css ".css-ivpcce2{offset-position:200px 100px;}"];
  [@css ".css-ivpc6a2{offset-position:center;}"];
  [@css ".css-ivpcqlb{offset-anchor:auto;}"];
  [@css ".css-ivpc77j{offset-anchor:200px;}"];
  [@css ".css-ivpcpbs{offset-anchor:200px 100px;}"];
  [@css ".css-ivpcrt2{offset-anchor:center;}"];
  [@css ".css-ivpclf5{offset-rotate:auto;}"];
  [@css ".css-ivpcj05{offset-rotate:0deg;}"];
  [@css ".css-ivpcvve{offset-rotate:reverse;}"];
  [@css ".css-ivpcajd{offset-rotate:-45deg;}"];
  [@css ".css-ivpc16z{offset-rotate:auto 180deg;}"];
  [@css ".css-ivpco0x{offset-rotate:reverse 45deg;}"];
  [@css ".css-ivpcb51{offset-rotate:2turn reverse;}"];
  [@css.classes
    [
      ("css-ivpc5x4", 0, "", "input.re", 2, 8, 2, 20),
      ("css-ivpc3qe", 1, "", "input.re", 3, 8, 3, 20),
      ("css-ivpcftm", 2, "", "input.re", 4, 8, 4, 22),
      ("css-ivpcabw", 3, "", "input.re", 5, 8, 5, 27),
      ("css-ivpco3m", 4, "", "input.re", 9, 8, 9, 26),
      ("css-ivpc8oo", 5, "", "input.re", 10, 8, 10, 26),
      ("css-ivpcqt7", 6, "", "input.re", 11, 8, 11, 27),
      ("css-ivpchvi", 7, "", "input.re", 12, 8, 12, 27),
      ("css-ivpc61x", 8, "", "input.re", 13, 8, 13, 24),
      ("css-ivpchr6", 9, "", "input.re", 14, 8, 14, 26),
      ("css-ivpcg2w", 10, "", "input.re", 15, 8, 15, 24),
      ("css-ivpcbx6", 11, "", "input.re", 17, 8, 17, 41),
      ("css-ivpc3fb", 12, "", "input.re", 18, 8, 18, 30),
      ("css-ivpc47f", 13, "", "input.re", 19, 8, 19, 39),
      ("css-ivpcuzn", 14, "", "input.re", 20, 8, 20, 43),
      ("css-ivpcnlq", 15, "", "input.re", 21, 8, 21, 51),
      ("css-ivpc8c0", 16, "", "input.re", 26, 8, 26, 51),
      ("css-ivpcxhq", 17, "", "input.re", 35, 8, 35, 29),
      ("css-ivpca9h", 18, "", "input.re", 36, 8, 36, 36),
      ("css-ivpc769", 19, "", "input.re", 37, 8, 37, 53),
      ("css-ivpcixe", 20, "", "input.re", 53, 8, 53, 25),
      ("css-ivpcpiv", 21, "", "input.re", 54, 8, 54, 44),
      ("css-ivpcmk6", 22, "", "input.re", 55, 8, 55, 45),
      ("css-ivpce20", 23, "", "input.re", 56, 8, 56, 46),
      ("css-ivpcyru", 24, "", "input.re", 57, 8, 57, 47),
      ("css-ivpcsys", 25, "", "input.re", 60, 8, 60, 54),
      ("css-ivpcn0q", 26, "", "input.re", 65, 8, 65, 31),
      ("css-ivpcxsd", 27, "", "input.re", 66, 8, 66, 31),
      ("css-ivpco1o", 28, "", "input.re", 67, 8, 67, 32),
      ("css-ivpcmvc", 29, "", "input.re", 68, 8, 68, 32),
      ("css-ivpc30m", 30, "", "input.re", 69, 8, 69, 29),
      ("css-ivpcaxm", 31, "", "input.re", 70, 8, 70, 31),
      ("css-ivpc5gy", 32, "", "input.re", 71, 8, 71, 29),
      ("css-ivpcjyf", 33, "", "input.re", 72, 8, 72, 43),
      ("css-ivpcupb", 34, "", "input.re", 77, 8, 77, 28),
      ("css-ivpcmow", 35, "", "input.re", 78, 8, 78, 29),
      ("css-ivpcscp", 36, "", "input.re", 79, 8, 79, 30),
      ("css-ivpcce2", 37, "", "input.re", 80, 8, 80, 36),
      ("css-ivpc6a2", 38, "", "input.re", 81, 8, 81, 31),
      ("css-ivpcqlb", 39, "", "input.re", 82, 8, 82, 27),
      ("css-ivpc77j", 40, "", "input.re", 83, 8, 83, 28),
      ("css-ivpcpbs", 41, "", "input.re", 84, 8, 84, 34),
      ("css-ivpcrt2", 42, "", "input.re", 85, 8, 85, 29),
      ("css-ivpclf5", 43, "", "input.re", 86, 8, 86, 27),
      ("css-ivpcj05", 44, "", "input.re", 87, 8, 87, 27),
      ("css-ivpcvve", 45, "", "input.re", 88, 8, 88, 30),
      ("css-ivpcajd", 46, "", "input.re", 89, 8, 89, 29),
      ("css-ivpc16z", 47, "", "input.re", 90, 8, 90, 34),
      ("css-ivpco0x", 48, "", "input.re", 91, 8, 91, 36),
      ("css-ivpcb51", 49, "", "input.re", 92, 8, 92, 36),
    ]
  ];
  
  CSS.make("css-ivpc5x4", []);
  CSS.make("css-ivpc3qe", []);
  CSS.make("css-ivpcftm", []);
  CSS.make("css-ivpcabw", []);
  
  CSS.make("css-ivpco3m", []);
  CSS.make("css-ivpc8oo", []);
  CSS.make("css-ivpcqt7", []);
  CSS.make("css-ivpchvi", []);
  CSS.make("css-ivpc61x", []);
  CSS.make("css-ivpchr6", []);
  CSS.make("css-ivpcg2w", []);
  
  CSS.make("css-ivpcbx6", []);
  CSS.make("css-ivpc3fb", []);
  CSS.make("css-ivpc47f", []);
  CSS.make("css-ivpcuzn", []);
  CSS.make("css-ivpcnlq", []);
  
  CSS.make("css-ivpc8c0", []);
  
  CSS.make("css-ivpcxhq", []);
  CSS.make("css-ivpca9h", []);
  CSS.make("css-ivpc769", []);
  
  CSS.make("css-ivpcixe", []);
  CSS.make("css-ivpcpiv", []);
  CSS.make("css-ivpcmk6", []);
  CSS.make("css-ivpce20", []);
  CSS.make("css-ivpcyru", []);
  
  CSS.make("css-ivpcsys", []);
  
  CSS.make("css-ivpcn0q", []);
  CSS.make("css-ivpcxsd", []);
  CSS.make("css-ivpco1o", []);
  CSS.make("css-ivpcmvc", []);
  CSS.make("css-ivpc30m", []);
  CSS.make("css-ivpcaxm", []);
  CSS.make("css-ivpc5gy", []);
  CSS.make("css-ivpcjyf", []);
  
  CSS.make("css-ivpcupb", []);
  CSS.make("css-ivpcmow", []);
  CSS.make("css-ivpcscp", []);
  CSS.make("css-ivpcce2", []);
  CSS.make("css-ivpc6a2", []);
  CSS.make("css-ivpcqlb", []);
  CSS.make("css-ivpc77j", []);
  CSS.make("css-ivpcpbs", []);
  CSS.make("css-ivpcrt2", []);
  CSS.make("css-ivpclf5", []);
  CSS.make("css-ivpcj05", []);
  CSS.make("css-ivpcvve", []);
  CSS.make("css-ivpcajd", []);
  CSS.make("css-ivpc16z", []);
  CSS.make("css-ivpco0x", []);
  CSS.make("css-ivpcb51", []);
