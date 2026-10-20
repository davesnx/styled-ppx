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
  [@css "._a_4pgt40{contain:none;}"];
  [@css "._a_4pyisx{contain:strict;}"];
  [@css "._a_4p7x2x{contain:content;}"];
  [@css "._a_4p1cha{contain:size;}"];
  [@css "._a_4pw7cp{contain:layout;}"];
  [@css "._a_4pyn5q{contain:paint;}"];
  [@css "._a_4pjwgs{contain:size layout;}"];
  [@css "._a_4p7zd4{contain:size paint;}"];
  [@css "._a_4pc7bb{contain:size layout paint;}"];
  [@css "._a_eclzv6{width:5cqw;}"];
  [@css "._a_ecsy8j{width:5cqh;}"];
  [@css "._a_ecq9h0{width:5cqi;}"];
  [@css "._a_eccz18{width:5cqb;}"];
  [@css "._a_ecidqw{width:5cqmin;}"];
  [@css "._a_ec8ucx{width:5cqmax;}"];
  [@css "._a_4v00027ccc{container-type:normal;}"];
  [@css "._a_4v00026sj7{container-type:size;}"];
  [@css "._a_4v0002zm71{container-type:inline-size;}"];
  [@css "._a_4v0001nlpx{container-name:none;}"];
  [@css "._a_4v00019f0l{container-name:x;}"];
  [@css "._a_4v0001kmkr{container-name:x y;}"];
  [@css "._a_4v1iko{container:none;}"];
  [@css "._a_4v52qy{container:x / normal;}"];
  [@css "._a_4vcq8j{container:x / size;}"];
  [@css "._a_4va7f0{container:x / inline-size;}"];
  [@css "._a_4vppda{container:x y / size;}"];
  [@css.blocks
    [
      (2, "_a_4pgt40"),
      (3, "_a_4pyisx"),
      (4, "_a_4p7x2x"),
      (5, "_a_4p1cha"),
      (6, "_a_4pw7cp"),
      (7, "_a_4pyn5q"),
      (8, "_a_4pjwgs"),
      (9, "_a_4p7zd4"),
      (10, "_a_4pc7bb"),
      (22, "_a_eclzv6"),
      (23, "_a_ecsy8j"),
      (24, "_a_ecq9h0"),
      (25, "_a_eccz18"),
      (26, "_a_ecidqw"),
      (27, "_a_ec8ucx"),
      (28, "_a_4v00027ccc"),
      (29, "_a_4v00026sj7"),
      (30, "_a_4v0002zm71"),
      (31, "_a_4v0001nlpx"),
      (32, "_a_4v00019f0l"),
      (33, "_a_4v0001kmkr"),
      (34, "_a_4v1iko"),
      (35, "_a_4v52qy"),
      (36, "_a_4vcq8j"),
      (37, "_a_4va7f0"),
      (38, "_a_4vppda"),
    ]
  ];
  
  CSS.make("_a_4pgt40", []);
  CSS.make("_a_4pyisx", []);
  CSS.make("_a_4p7x2x", []);
  CSS.make("_a_4p1cha", []);
  CSS.make("_a_4pw7cp", []);
  CSS.make("_a_4pyn5q", []);
  CSS.make("_a_4pjwgs", []);
  CSS.make("_a_4p7zd4", []);
  CSS.make("_a_4pc7bb", []);
  
  CSS.make("_a_eclzv6", []);
  CSS.make("_a_ecsy8j", []);
  CSS.make("_a_ecq9h0", []);
  CSS.make("_a_eccz18", []);
  CSS.make("_a_ecidqw", []);
  CSS.make("_a_ec8ucx", []);
  CSS.make("_a_4v00027ccc", []);
  CSS.make("_a_4v00026sj7", []);
  CSS.make("_a_4v0002zm71", []);
  CSS.make("_a_4v0001nlpx", []);
  CSS.make("_a_4v00019f0l", []);
  CSS.make("_a_4v0001kmkr", []);
  CSS.make("_a_4v1iko", []);
  CSS.make("_a_4v52qy", []);
  CSS.make("_a_4vcq8j", []);
  CSS.make("_a_4va7f0", []);
  CSS.make("_a_4vppda", []);
