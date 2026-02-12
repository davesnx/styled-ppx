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
  [@css
    ".css-106lko4{mix-blend-mode:normal;}\n.css-yyvjpz{mix-blend-mode:multiply;}\n.css-g6k0am{mix-blend-mode:screen;}\n.css-jqzyj4{mix-blend-mode:overlay;}\n.css-1hwt403{mix-blend-mode:darken;}\n.css-1ywm2bs{mix-blend-mode:lighten;}\n.css-28haz0{mix-blend-mode:color-dodge;}\n.css-1aiw6n1{mix-blend-mode:color-burn;}\n.css-1bgzgq9{mix-blend-mode:hard-light;}\n.css-183ndlc{mix-blend-mode:soft-light;}\n.css-xl54fr{mix-blend-mode:difference;}\n.css-1yabobq{mix-blend-mode:exclusion;}\n.css-1htuj9e{mix-blend-mode:hue;}\n.css-1e9qzf6{mix-blend-mode:saturation;}\n.css-1mv0k1i{mix-blend-mode:color;}\n.css-10szft{mix-blend-mode:luminosity;}\n.css-139jmn5{isolation:auto;}\n.css-13cnam7{isolation:isolate;}\n.css-qf0fcc{background-blend-mode:normal;}\n.css-10bwb0u{background-blend-mode:multiply;}\n.css-89mqbu{background-blend-mode:screen;}\n.css-129kb0h{background-blend-mode:overlay;}\n.css-vlejn3{background-blend-mode:darken;}\n.css-1gtgoey{background-blend-mode:lighten;}\n.css-1p2yjd5{background-blend-mode:color-dodge;}\n.css-cz39ay{background-blend-mode:color-burn;}\n.css-hxbqd8{background-blend-mode:hard-light;}\n.css-1fze5j0{background-blend-mode:soft-light;}\n.css-dw2r9t{background-blend-mode:difference;}\n.css-1l0nlb2{background-blend-mode:exclusion;}\n.css-1way3l6{background-blend-mode:hue;}\n.css-12toyo7{background-blend-mode:saturation;}\n.css-1o4xi8v{background-blend-mode:color;}\n.css-909g5x{background-blend-mode:luminosity;}\n.css-m4l4fq{background-blend-mode:normal, multiply;}\n"
  ];
  
  CSS.make("css-106lko4", []);
  CSS.make("css-yyvjpz", []);
  CSS.make("css-g6k0am", []);
  CSS.make("css-jqzyj4", []);
  CSS.make("css-1hwt403", []);
  CSS.make("css-1ywm2bs", []);
  CSS.make("css-28haz0", []);
  CSS.make("css-1aiw6n1", []);
  CSS.make("css-1bgzgq9", []);
  CSS.make("css-183ndlc", []);
  CSS.make("css-xl54fr", []);
  CSS.make("css-1yabobq", []);
  CSS.make("css-1htuj9e", []);
  CSS.make("css-1e9qzf6", []);
  CSS.make("css-1mv0k1i", []);
  CSS.make("css-10szft", []);
  CSS.make("css-139jmn5", []);
  CSS.make("css-13cnam7", []);
  CSS.make("css-qf0fcc", []);
  CSS.make("css-10bwb0u", []);
  CSS.make("css-89mqbu", []);
  CSS.make("css-129kb0h", []);
  CSS.make("css-vlejn3", []);
  CSS.make("css-1gtgoey", []);
  CSS.make("css-1p2yjd5", []);
  CSS.make("css-cz39ay", []);
  CSS.make("css-hxbqd8", []);
  CSS.make("css-1fze5j0", []);
  CSS.make("css-dw2r9t", []);
  CSS.make("css-1l0nlb2", []);
  CSS.make("css-1way3l6", []);
  CSS.make("css-12toyo7", []);
  CSS.make("css-1o4xi8v", []);
  CSS.make("css-909g5x", []);
  CSS.make("css-m4l4fq", []);
