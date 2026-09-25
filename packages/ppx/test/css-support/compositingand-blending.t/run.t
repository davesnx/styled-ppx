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
  [@css ".a-8dlko4{mix-blend-mode:normal;}"];
  [@css ".a-8dvjpz{mix-blend-mode:multiply;}"];
  [@css ".a-8dk0am{mix-blend-mode:screen;}"];
  [@css ".a-8dzyj4{mix-blend-mode:overlay;}"];
  [@css ".a-8dt403{mix-blend-mode:darken;}"];
  [@css ".a-8dm2bs{mix-blend-mode:lighten;}"];
  [@css ".a-8dhaz0{mix-blend-mode:color-dodge;}"];
  [@css ".a-8dw6n1{mix-blend-mode:color-burn;}"];
  [@css ".a-8dzgq9{mix-blend-mode:hard-light;}"];
  [@css ".a-8dndlc{mix-blend-mode:soft-light;}"];
  [@css ".a-8d54fr{mix-blend-mode:difference;}"];
  [@css ".a-8dbobq{mix-blend-mode:exclusion;}"];
  [@css ".a-8duj9e{mix-blend-mode:hue;}"];
  [@css ".a-8dqzf6{mix-blend-mode:saturation;}"];
  [@css ".a-8d0k1i{mix-blend-mode:color;}"];
  [@css ".a-8dszft{mix-blend-mode:luminosity;}"];
  [@css ".a-7ajmn5{isolation:auto;}"];
  [@css ".a-7anam7{isolation:isolate;}"];
  [@css ".a-3a0fcc{background-blend-mode:normal;}"];
  [@css ".a-3awb0u{background-blend-mode:multiply;}"];
  [@css ".a-3amqbu{background-blend-mode:screen;}"];
  [@css ".a-3akb0h{background-blend-mode:overlay;}"];
  [@css ".a-3aejn3{background-blend-mode:darken;}"];
  [@css ".a-3agoey{background-blend-mode:lighten;}"];
  [@css ".a-3ayjd5{background-blend-mode:color-dodge;}"];
  [@css ".a-3a39ay{background-blend-mode:color-burn;}"];
  [@css ".a-3abqd8{background-blend-mode:hard-light;}"];
  [@css ".a-3ae5j0{background-blend-mode:soft-light;}"];
  [@css ".a-3a2r9t{background-blend-mode:difference;}"];
  [@css ".a-3anlb2{background-blend-mode:exclusion;}"];
  [@css ".a-3ay3l6{background-blend-mode:hue;}"];
  [@css ".a-3aoyo7{background-blend-mode:saturation;}"];
  [@css ".a-3axi8v{background-blend-mode:color;}"];
  [@css ".a-3a9g5x{background-blend-mode:luminosity;}"];
  [@css ".a-3al4fq{background-blend-mode:normal, multiply;}"];
  
  CSS.make("a-8dlko4", []);
  CSS.make("a-8dvjpz", []);
  CSS.make("a-8dk0am", []);
  CSS.make("a-8dzyj4", []);
  CSS.make("a-8dt403", []);
  CSS.make("a-8dm2bs", []);
  CSS.make("a-8dhaz0", []);
  CSS.make("a-8dw6n1", []);
  CSS.make("a-8dzgq9", []);
  CSS.make("a-8dndlc", []);
  CSS.make("a-8d54fr", []);
  CSS.make("a-8dbobq", []);
  CSS.make("a-8duj9e", []);
  CSS.make("a-8dqzf6", []);
  CSS.make("a-8d0k1i", []);
  CSS.make("a-8dszft", []);
  CSS.make("a-7ajmn5", []);
  CSS.make("a-7anam7", []);
  CSS.make("a-3a0fcc", []);
  CSS.make("a-3awb0u", []);
  CSS.make("a-3amqbu", []);
  CSS.make("a-3akb0h", []);
  CSS.make("a-3aejn3", []);
  CSS.make("a-3agoey", []);
  CSS.make("a-3ayjd5", []);
  CSS.make("a-3a39ay", []);
  CSS.make("a-3abqd8", []);
  CSS.make("a-3ae5j0", []);
  CSS.make("a-3a2r9t", []);
  CSS.make("a-3anlb2", []);
  CSS.make("a-3ay3l6", []);
  CSS.make("a-3aoyo7", []);
  CSS.make("a-3axi8v", []);
  CSS.make("a-3a9g5x", []);
  CSS.make("a-3al4fq", []);
