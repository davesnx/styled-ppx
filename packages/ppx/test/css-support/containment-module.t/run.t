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
  [@css ".css-12vrfxf{contain:none;}"];
  [@css ".css-1ugbnjq{contain:strict;}"];
  [@css ".css-1kexcu8{contain:content;}"];
  [@css ".css-34bg5i{contain:size;}"];
  [@css ".css-17y0zf1{contain:layout;}"];
  [@css ".css-fx31dr{contain:paint;}"];
  [@css ".css-1o2hzjb{contain:size layout;}"];
  [@css ".css-1dq18vn{contain:size paint;}"];
  [@css ".css-1hpq488{contain:size layout paint;}"];
  [@css ".css-1dvamdv{width:5cqw;}"];
  [@css ".css-wch9tu{width:5cqh;}"];
  [@css ".css-lqqeqv{width:5cqi;}"];
  [@css ".css-1p5je9s{width:5cqb;}"];
  [@css ".css-1hzhr6c{width:5cqmin;}"];
  [@css ".css-e8esu7{width:5cqmax;}"];
  [@css ".css-sque9t{container-type:normal;}"];
  [@css ".css-17sx0r1{container-type:size;}"];
  [@css ".css-14hqny7{container-type:inline-size;}"];
  [@css ".css-12bke7l{container-name:none;}"];
  [@css ".css-1xjsu61{container-name:x;}"];
  [@css ".css-1dos7uy{container-name:x y;}"];
  [@css ".css-hqkkoc{container:none;}"];
  [@css ".css-5xtc8b{container:x / normal;}"];
  [@css ".css-tnctgm{container:x / size;}"];
  [@css ".css-10i4xt8{container:x / inline-size;}"];
  [@css ".css-mnfiky{container:x y / size;}"];
  [@css.classes
    [
      ("css-12vrfxf", 0, "", "input.re", 2, 8, 2, 21),
      ("css-1ugbnjq", 1, "", "input.re", 3, 8, 3, 23),
      ("css-1kexcu8", 2, "", "input.re", 4, 8, 4, 24),
      ("css-34bg5i", 3, "", "input.re", 5, 8, 5, 21),
      ("css-17y0zf1", 4, "", "input.re", 6, 8, 6, 23),
      ("css-fx31dr", 5, "", "input.re", 7, 8, 7, 22),
      ("css-1o2hzjb", 6, "", "input.re", 8, 8, 8, 28),
      ("css-1dq18vn", 7, "", "input.re", 9, 8, 9, 27),
      ("css-1hpq488", 8, "", "input.re", 10, 8, 10, 34),
      ("css-1dvamdv", 9, "", "input.re", 22, 8, 22, 20),
      ("css-wch9tu", 10, "", "input.re", 23, 8, 23, 20),
      ("css-lqqeqv", 11, "", "input.re", 24, 8, 24, 20),
      ("css-1p5je9s", 12, "", "input.re", 25, 8, 25, 20),
      ("css-1hzhr6c", 13, "", "input.re", 26, 8, 26, 22),
      ("css-e8esu7", 14, "", "input.re", 27, 8, 27, 22),
      ("css-sque9t", 15, "", "input.re", 28, 8, 28, 30),
      ("css-17sx0r1", 16, "", "input.re", 29, 8, 29, 28),
      ("css-14hqny7", 17, "", "input.re", 30, 8, 30, 35),
      ("css-12bke7l", 18, "", "input.re", 31, 8, 31, 28),
      ("css-1xjsu61", 19, "", "input.re", 32, 8, 32, 25),
      ("css-1dos7uy", 20, "", "input.re", 33, 8, 33, 27),
      ("css-hqkkoc", 21, "", "input.re", 34, 8, 34, 23),
      ("css-5xtc8b", 22, "", "input.re", 35, 8, 35, 29),
      ("css-tnctgm", 23, "", "input.re", 36, 8, 36, 27),
      ("css-10i4xt8", 24, "", "input.re", 37, 8, 37, 34),
      ("css-mnfiky", 25, "", "input.re", 38, 8, 38, 29),
    ]
  ];
  
  CSS.make("css-12vrfxf", []);
  CSS.make("css-1ugbnjq", []);
  CSS.make("css-1kexcu8", []);
  CSS.make("css-34bg5i", []);
  CSS.make("css-17y0zf1", []);
  CSS.make("css-fx31dr", []);
  CSS.make("css-1o2hzjb", []);
  CSS.make("css-1dq18vn", []);
  CSS.make("css-1hpq488", []);
  
  CSS.make("css-1dvamdv", []);
  CSS.make("css-wch9tu", []);
  CSS.make("css-lqqeqv", []);
  CSS.make("css-1p5je9s", []);
  CSS.make("css-1hzhr6c", []);
  CSS.make("css-e8esu7", []);
  CSS.make("css-sque9t", []);
  CSS.make("css-17sx0r1", []);
  CSS.make("css-14hqny7", []);
  CSS.make("css-12bke7l", []);
  CSS.make("css-1xjsu61", []);
  CSS.make("css-1dos7uy", []);
  CSS.make("css-hqkkoc", []);
  CSS.make("css-5xtc8b", []);
  CSS.make("css-tnctgm", []);
  CSS.make("css-10i4xt8", []);
  CSS.make("css-mnfiky", []);
