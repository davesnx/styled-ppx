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
  [@css "._a_8dlko4{mix-blend-mode:normal;}"];
  [@css "._a_8dvjpz{mix-blend-mode:multiply;}"];
  [@css "._a_8dk0am{mix-blend-mode:screen;}"];
  [@css "._a_8dzyj4{mix-blend-mode:overlay;}"];
  [@css "._a_8dt403{mix-blend-mode:darken;}"];
  [@css "._a_8dm2bs{mix-blend-mode:lighten;}"];
  [@css "._a_8dhaz0{mix-blend-mode:color-dodge;}"];
  [@css "._a_8dw6n1{mix-blend-mode:color-burn;}"];
  [@css "._a_8dzgq9{mix-blend-mode:hard-light;}"];
  [@css "._a_8dndlc{mix-blend-mode:soft-light;}"];
  [@css "._a_8d54fr{mix-blend-mode:difference;}"];
  [@css "._a_8dbobq{mix-blend-mode:exclusion;}"];
  [@css "._a_8duj9e{mix-blend-mode:hue;}"];
  [@css "._a_8dqzf6{mix-blend-mode:saturation;}"];
  [@css "._a_8d0k1i{mix-blend-mode:color;}"];
  [@css "._a_8dszft{mix-blend-mode:luminosity;}"];
  [@css "._a_7ajmn5{isolation:auto;}"];
  [@css "._a_7anam7{isolation:isolate;}"];
  [@css "._a_3a0fcc{background-blend-mode:normal;}"];
  [@css "._a_3awb0u{background-blend-mode:multiply;}"];
  [@css "._a_3amqbu{background-blend-mode:screen;}"];
  [@css "._a_3akb0h{background-blend-mode:overlay;}"];
  [@css "._a_3aejn3{background-blend-mode:darken;}"];
  [@css "._a_3agoey{background-blend-mode:lighten;}"];
  [@css "._a_3ayjd5{background-blend-mode:color-dodge;}"];
  [@css "._a_3a39ay{background-blend-mode:color-burn;}"];
  [@css "._a_3abqd8{background-blend-mode:hard-light;}"];
  [@css "._a_3ae5j0{background-blend-mode:soft-light;}"];
  [@css "._a_3a2r9t{background-blend-mode:difference;}"];
  [@css "._a_3anlb2{background-blend-mode:exclusion;}"];
  [@css "._a_3ay3l6{background-blend-mode:hue;}"];
  [@css "._a_3aoyo7{background-blend-mode:saturation;}"];
  [@css "._a_3axi8v{background-blend-mode:color;}"];
  [@css "._a_3a9g5x{background-blend-mode:luminosity;}"];
  [@css "._a_3al4fq{background-blend-mode:normal, multiply;}"];
  [@css.blocks
    [
      (2, "_a_8dlko4"),
      (3, "_a_8dvjpz"),
      (4, "_a_8dk0am"),
      (5, "_a_8dzyj4"),
      (6, "_a_8dt403"),
      (7, "_a_8dm2bs"),
      (8, "_a_8dhaz0"),
      (9, "_a_8dw6n1"),
      (10, "_a_8dzgq9"),
      (11, "_a_8dndlc"),
      (12, "_a_8d54fr"),
      (13, "_a_8dbobq"),
      (14, "_a_8duj9e"),
      (15, "_a_8dqzf6"),
      (16, "_a_8d0k1i"),
      (17, "_a_8dszft"),
      (18, "_a_7ajmn5"),
      (19, "_a_7anam7"),
      (20, "_a_3a0fcc"),
      (21, "_a_3awb0u"),
      (22, "_a_3amqbu"),
      (23, "_a_3akb0h"),
      (24, "_a_3aejn3"),
      (25, "_a_3agoey"),
      (26, "_a_3ayjd5"),
      (27, "_a_3a39ay"),
      (28, "_a_3abqd8"),
      (29, "_a_3ae5j0"),
      (30, "_a_3a2r9t"),
      (31, "_a_3anlb2"),
      (32, "_a_3ay3l6"),
      (33, "_a_3aoyo7"),
      (34, "_a_3axi8v"),
      (35, "_a_3a9g5x"),
      (36, "_a_3al4fq"),
    ]
  ];
  
  CSS.make("_a_8dlko4", []);
  CSS.make("_a_8dvjpz", []);
  CSS.make("_a_8dk0am", []);
  CSS.make("_a_8dzyj4", []);
  CSS.make("_a_8dt403", []);
  CSS.make("_a_8dm2bs", []);
  CSS.make("_a_8dhaz0", []);
  CSS.make("_a_8dw6n1", []);
  CSS.make("_a_8dzgq9", []);
  CSS.make("_a_8dndlc", []);
  CSS.make("_a_8d54fr", []);
  CSS.make("_a_8dbobq", []);
  CSS.make("_a_8duj9e", []);
  CSS.make("_a_8dqzf6", []);
  CSS.make("_a_8d0k1i", []);
  CSS.make("_a_8dszft", []);
  CSS.make("_a_7ajmn5", []);
  CSS.make("_a_7anam7", []);
  CSS.make("_a_3a0fcc", []);
  CSS.make("_a_3awb0u", []);
  CSS.make("_a_3amqbu", []);
  CSS.make("_a_3akb0h", []);
  CSS.make("_a_3aejn3", []);
  CSS.make("_a_3agoey", []);
  CSS.make("_a_3ayjd5", []);
  CSS.make("_a_3a39ay", []);
  CSS.make("_a_3abqd8", []);
  CSS.make("_a_3ae5j0", []);
  CSS.make("_a_3a2r9t", []);
  CSS.make("_a_3anlb2", []);
  CSS.make("_a_3ay3l6", []);
  CSS.make("_a_3aoyo7", []);
  CSS.make("_a_3axi8v", []);
  CSS.make("_a_3a9g5x", []);
  CSS.make("_a_3al4fq", []);
