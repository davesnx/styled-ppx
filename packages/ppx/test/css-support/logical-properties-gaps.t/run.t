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
  [@css "._a_7q0002gwfb{margin-block-start:auto;}"];
  [@css "._a_7q00022oos{margin-block-start:0;}"];
  [@css "._a_7q000217su{margin-block-start:10%;}"];
  [@css "._a_7q00025a1y{margin-block-start:calc(10px + 5%);}"];
  [@css "._a_7q0001lweg{margin-block-end:auto;}"];
  [@css "._a_7q0001x81y{margin-block-end:0;}"];
  [@css "._a_7q0001pv1b{margin-block-end:10%;}"];
  [@css "._a_7q00012cvy{margin-block-end:calc(10px + 5%);}"];
  [@css "._a_7r0002l53j{-webkit-margin-start:auto;margin-inline-start:auto;}"];
  [@css "._a_7r0002wkc2{-webkit-margin-start:0;margin-inline-start:0;}"];
  [@css "._a_7r0002u6cp{-webkit-margin-start:10%;margin-inline-start:10%;}"];
  [@css
    "._a_7r0002gejl{-webkit-margin-start:calc(10px + 5%);margin-inline-start:calc(10px + 5%);}"
  ];
  [@css "._a_7r00018jnk{-webkit-margin-end:auto;margin-inline-end:auto;}"];
  [@css "._a_7r0001jlf7{-webkit-margin-end:0;margin-inline-end:0;}"];
  [@css "._a_7r0001j3z4{-webkit-margin-end:10%;margin-inline-end:10%;}"];
  [@css
    "._a_7r0001dzrx{-webkit-margin-end:calc(10px + 5%);margin-inline-end:calc(10px + 5%);}"
  ];
  [@css "._a_950002rm8j{padding-block-start:0;}"];
  [@css "._a_9500027et8{padding-block-start:10%;}"];
  [@css "._a_950002iev7{padding-block-start:calc(10px + 5%);}"];
  [@css "._a_950001cfwc{padding-block-end:0;}"];
  [@css "._a_950001kgml{padding-block-end:10%;}"];
  [@css "._a_950001nqch{padding-block-end:calc(10px + 5%);}"];
  [@css "._a_960002s69z{-webkit-padding-start:0;padding-inline-start:0;}"];
  [@css "._a_960002ziqq{-webkit-padding-start:10%;padding-inline-start:10%;}"];
  [@css
    "._a_960002gmtp{-webkit-padding-start:calc(10px + 5%);padding-inline-start:calc(10px + 5%);}"
  ];
  [@css "._a_9600012g5x{-webkit-padding-end:0;padding-inline-end:0;}"];
  [@css "._a_960001gpxd{-webkit-padding-end:10%;padding-inline-end:10%;}"];
  [@css
    "._a_960001442x{-webkit-padding-end:calc(10px + 5%);padding-inline-end:calc(10px + 5%);}"
  ];
  [@css "._a_7qgd9e{margin-block:auto auto;}"];
  [@css "._a_7q7mti{margin-block:10px 20px;}"];
  [@css "._a_7qm4ct{margin-block:10% 20%;}"];
  [@css "._a_7rqsk6{margin-inline:auto auto;}"];
  [@css "._a_7r6zwf{margin-inline:10px 20px;}"];
  [@css "._a_7r06xy{margin-inline:10% 20%;}"];
  [@css "._a_95usfj{padding-block:10px 20px;}"];
  [@css "._a_95l5sm{padding-block:10% 20%;}"];
  [@css "._a_96y7fc{padding-inline:10px 20px;}"];
  [@css "._a_96p1qw{padding-inline:10% 20%;}"];
  [@css "._a_3i0010vlzl{border-block-width:thin;}"];
  [@css "._a_3i001093is{border-block-width:medium;}"];
  [@css "._a_3i0010cw9r{border-block-width:thick;}"];
  [@css "._a_3i0010t9g7{border-block-width:2px;}"];
  [@css "._a_3m0010eo1a{border-inline-width:thin;}"];
  [@css "._a_3m00102wgf{border-inline-width:medium;}"];
  [@css "._a_3m0010cr2x{border-inline-width:thick;}"];
  [@css "._a_3m0010yrtz{border-inline-width:2px;}"];
  [@css "._a_3i000itjkl{border-block-style:none;}"];
  [@css "._a_3i000ih45a{border-block-style:solid;}"];
  [@css "._a_3i000iesag{border-block-style:dashed;}"];
  [@css "._a_3m000ia3pa{border-inline-style:none;}"];
  [@css "._a_3m000itzyz{border-inline-style:solid;}"];
  [@css "._a_3m000ij1mb{border-inline-style:dashed;}"];
  
  CSS.make("_a_7q0002gwfb", []);
  CSS.make("_a_7q00022oos", []);
  CSS.make("_a_7q000217su", []);
  CSS.make("_a_7q00025a1y", []);
  CSS.make("_a_7q0001lweg", []);
  CSS.make("_a_7q0001x81y", []);
  CSS.make("_a_7q0001pv1b", []);
  CSS.make("_a_7q00012cvy", []);
  
  CSS.make("_a_7r0002l53j", []);
  CSS.make("_a_7r0002wkc2", []);
  CSS.make("_a_7r0002u6cp", []);
  CSS.make("_a_7r0002gejl", []);
  CSS.make("_a_7r00018jnk", []);
  CSS.make("_a_7r0001jlf7", []);
  CSS.make("_a_7r0001j3z4", []);
  CSS.make("_a_7r0001dzrx", []);
  
  CSS.make("_a_950002rm8j", []);
  CSS.make("_a_9500027et8", []);
  CSS.make("_a_950002iev7", []);
  CSS.make("_a_950001cfwc", []);
  CSS.make("_a_950001kgml", []);
  CSS.make("_a_950001nqch", []);
  
  CSS.make("_a_960002s69z", []);
  CSS.make("_a_960002ziqq", []);
  CSS.make("_a_960002gmtp", []);
  CSS.make("_a_9600012g5x", []);
  CSS.make("_a_960001gpxd", []);
  CSS.make("_a_960001442x", []);
  
  CSS.make("_a_7qgd9e", []);
  CSS.make("_a_7q7mti", []);
  CSS.make("_a_7qm4ct", []);
  CSS.make("_a_7rqsk6", []);
  CSS.make("_a_7r6zwf", []);
  CSS.make("_a_7r06xy", []);
  
  CSS.make("_a_95usfj", []);
  CSS.make("_a_95l5sm", []);
  CSS.make("_a_96y7fc", []);
  CSS.make("_a_96p1qw", []);
  
  CSS.make("_a_3i0010vlzl", []);
  CSS.make("_a_3i001093is", []);
  CSS.make("_a_3i0010cw9r", []);
  CSS.make("_a_3i0010t9g7", []);
  CSS.make("_a_3m0010eo1a", []);
  CSS.make("_a_3m00102wgf", []);
  CSS.make("_a_3m0010cr2x", []);
  CSS.make("_a_3m0010yrtz", []);
  
  CSS.make("_a_3i000itjkl", []);
  CSS.make("_a_3i000ih45a", []);
  CSS.make("_a_3i000iesag", []);
  CSS.make("_a_3m000ia3pa", []);
  CSS.make("_a_3m000itzyz", []);
  CSS.make("_a_3m000ij1mb", []);
