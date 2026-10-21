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
  [@css "._a_4v00027ccc{container-type:normal;}"];
  [@css "._a_4v00026sj7{container-type:size;}"];
  [@css "._a_4v0002zm71{container-type:inline-size;}"];
  [@css "._a_4v0001nlpx{container-name:none;}"];
  [@css "._a_4v0001baxz{container-name:sidebar;}"];
  [@css "._a_4v0001qxl0{container-name:sidebar main;}"];
  [@css "._a_4ve1gg{container:sidebar / inline-size;}"];
  [@css "._a_4vbl4h{container:sidebar / size;}"];
  [@css "._a_4v1iko{container:none;}"];
  [@css.blocks
    [
      (2, "_a_4v00027ccc"),
      (3, "_a_4v00026sj7"),
      (4, "_a_4v0002zm71"),
      (5, "_a_4v0001nlpx"),
      (6, "_a_4v0001baxz"),
      (7, "_a_4v0001qxl0"),
      (8, "_a_4ve1gg"),
      (9, "_a_4vbl4h"),
      (10, "_a_4v1iko"),
    ]
  ];
  
  CSS.make("_a_4v00027ccc", []);
  CSS.make("_a_4v00026sj7", []);
  CSS.make("_a_4v0002zm71", []);
  CSS.make("_a_4v0001nlpx", []);
  CSS.make("_a_4v0001baxz", []);
  CSS.make("_a_4v0001qxl0", []);
  CSS.make("_a_4ve1gg", []);
  CSS.make("_a_4vbl4h", []);
  CSS.make("_a_4v1iko", []);
