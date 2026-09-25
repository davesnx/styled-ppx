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
  [@css ".a-106lko4{mix-blend-mode:normal;}"];
  [@css ".a-yyvjpz{mix-blend-mode:multiply;}"];
  [@css ".a-g6k0am{mix-blend-mode:screen;}"];
  [@css ".a-jqzyj4{mix-blend-mode:overlay;}"];
  [@css ".a-1hwt403{mix-blend-mode:darken;}"];
  [@css ".a-1ywm2bs{mix-blend-mode:lighten;}"];
  [@css ".a-28haz0{mix-blend-mode:color-dodge;}"];
  [@css ".a-1aiw6n1{mix-blend-mode:color-burn;}"];
  [@css ".a-1bgzgq9{mix-blend-mode:hard-light;}"];
  [@css ".a-183ndlc{mix-blend-mode:soft-light;}"];
  [@css ".a-xl54fr{mix-blend-mode:difference;}"];
  [@css ".a-1yabobq{mix-blend-mode:exclusion;}"];
  [@css ".a-1htuj9e{mix-blend-mode:hue;}"];
  [@css ".a-1e9qzf6{mix-blend-mode:saturation;}"];
  [@css ".a-1mv0k1i{mix-blend-mode:color;}"];
  [@css ".a-10szft{mix-blend-mode:luminosity;}"];
  [@css ".a-139jmn5{isolation:auto;}"];
  [@css ".a-13cnam7{isolation:isolate;}"];
  [@css ".a-qf0fcc{background-blend-mode:normal;}"];
  [@css ".a-10bwb0u{background-blend-mode:multiply;}"];
  [@css ".a-89mqbu{background-blend-mode:screen;}"];
  [@css ".a-129kb0h{background-blend-mode:overlay;}"];
  [@css ".a-vlejn3{background-blend-mode:darken;}"];
  [@css ".a-1gtgoey{background-blend-mode:lighten;}"];
  [@css ".a-1p2yjd5{background-blend-mode:color-dodge;}"];
  [@css ".a-cz39ay{background-blend-mode:color-burn;}"];
  [@css ".a-hxbqd8{background-blend-mode:hard-light;}"];
  [@css ".a-1fze5j0{background-blend-mode:soft-light;}"];
  [@css ".a-dw2r9t{background-blend-mode:difference;}"];
  [@css ".a-1l0nlb2{background-blend-mode:exclusion;}"];
  [@css ".a-1way3l6{background-blend-mode:hue;}"];
  [@css ".a-12toyo7{background-blend-mode:saturation;}"];
  [@css ".a-1o4xi8v{background-blend-mode:color;}"];
  [@css ".a-909g5x{background-blend-mode:luminosity;}"];
  [@css ".a-m4l4fq{background-blend-mode:normal, multiply;}"];
  
  CSS.make("a-106lko4", []);
  CSS.make("a-yyvjpz", []);
  CSS.make("a-g6k0am", []);
  CSS.make("a-jqzyj4", []);
  CSS.make("a-1hwt403", []);
  CSS.make("a-1ywm2bs", []);
  CSS.make("a-28haz0", []);
  CSS.make("a-1aiw6n1", []);
  CSS.make("a-1bgzgq9", []);
  CSS.make("a-183ndlc", []);
  CSS.make("a-xl54fr", []);
  CSS.make("a-1yabobq", []);
  CSS.make("a-1htuj9e", []);
  CSS.make("a-1e9qzf6", []);
  CSS.make("a-1mv0k1i", []);
  CSS.make("a-10szft", []);
  CSS.make("a-139jmn5", []);
  CSS.make("a-13cnam7", []);
  CSS.make("a-qf0fcc", []);
  CSS.make("a-10bwb0u", []);
  CSS.make("a-89mqbu", []);
  CSS.make("a-129kb0h", []);
  CSS.make("a-vlejn3", []);
  CSS.make("a-1gtgoey", []);
  CSS.make("a-1p2yjd5", []);
  CSS.make("a-cz39ay", []);
  CSS.make("a-hxbqd8", []);
  CSS.make("a-1fze5j0", []);
  CSS.make("a-dw2r9t", []);
  CSS.make("a-1l0nlb2", []);
  CSS.make("a-1way3l6", []);
  CSS.make("a-12toyo7", []);
  CSS.make("a-1o4xi8v", []);
  CSS.make("a-909g5x", []);
  CSS.make("a-m4l4fq", []);
