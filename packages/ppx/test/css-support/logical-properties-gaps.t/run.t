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
  [@css "._a_7q002gwfb{margin-block-start:auto;}"];
  [@css "._a_7q0022oos{margin-block-start:0;}"];
  [@css "._a_7q00217su{margin-block-start:10%;}"];
  [@css "._a_7q0025a1y{margin-block-start:calc(10px + 5%);}"];
  [@css "._a_7q001lweg{margin-block-end:auto;}"];
  [@css "._a_7q001x81y{margin-block-end:0;}"];
  [@css "._a_7q001pv1b{margin-block-end:10%;}"];
  [@css "._a_7q0012cvy{margin-block-end:calc(10px + 5%);}"];
  [@css
    "._a_7r002l53j{-webkit-margin-inline-start:auto;margin-inline-start:auto;}"
  ];
  [@css "._a_7r002wkc2{-webkit-margin-inline-start:0;margin-inline-start:0;}"];
  [@css
    "._a_7r002u6cp{-webkit-margin-inline-start:10%;margin-inline-start:10%;}"
  ];
  [@css
    "._a_7r002gejl{-webkit-margin-inline-start:calc(10px + 5%);margin-inline-start:calc(10px + 5%);}"
  ];
  [@css "._a_7r0018jnk{-webkit-margin-inline-end:auto;margin-inline-end:auto;}"];
  [@css "._a_7r001jlf7{-webkit-margin-inline-end:0;margin-inline-end:0;}"];
  [@css "._a_7r001j3z4{-webkit-margin-inline-end:10%;margin-inline-end:10%;}"];
  [@css
    "._a_7r001dzrx{-webkit-margin-inline-end:calc(10px + 5%);margin-inline-end:calc(10px + 5%);}"
  ];
  [@css "._a_95002rm8j{padding-block-start:0;}"];
  [@css "._a_950027et8{padding-block-start:10%;}"];
  [@css "._a_95002iev7{padding-block-start:calc(10px + 5%);}"];
  [@css "._a_95001cfwc{padding-block-end:0;}"];
  [@css "._a_95001kgml{padding-block-end:10%;}"];
  [@css "._a_95001nqch{padding-block-end:calc(10px + 5%);}"];
  [@css "._a_96002s69z{-webkit-padding-inline-start:0;padding-inline-start:0;}"];
  [@css
    "._a_96002ziqq{-webkit-padding-inline-start:10%;padding-inline-start:10%;}"
  ];
  [@css
    "._a_96002gmtp{-webkit-padding-inline-start:calc(10px + 5%);padding-inline-start:calc(10px + 5%);}"
  ];
  [@css "._a_960012g5x{-webkit-padding-inline-end:0;padding-inline-end:0;}"];
  [@css "._a_96001gpxd{-webkit-padding-inline-end:10%;padding-inline-end:10%;}"];
  [@css
    "._a_96001442x{-webkit-padding-inline-end:calc(10px + 5%);padding-inline-end:calc(10px + 5%);}"
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
  [@css "._a_3i010vlzl{border-block-width:thin;}"];
  [@css "._a_3i01093is{border-block-width:medium;}"];
  [@css "._a_3i010cw9r{border-block-width:thick;}"];
  [@css "._a_3i010t9g7{border-block-width:2px;}"];
  [@css "._a_3m010eo1a{border-inline-width:thin;}"];
  [@css "._a_3m0102wgf{border-inline-width:medium;}"];
  [@css "._a_3m010cr2x{border-inline-width:thick;}"];
  [@css "._a_3m010yrtz{border-inline-width:2px;}"];
  [@css "._a_3i00itjkl{border-block-style:none;}"];
  [@css "._a_3i00ih45a{border-block-style:solid;}"];
  [@css "._a_3i00iesag{border-block-style:dashed;}"];
  [@css "._a_3m00ia3pa{border-inline-style:none;}"];
  [@css "._a_3m00itzyz{border-inline-style:solid;}"];
  [@css "._a_3m00ij1mb{border-inline-style:dashed;}"];
  
  CSS.make("_a_7q002gwfb", []);
  CSS.make("_a_7q0022oos", []);
  CSS.make("_a_7q00217su", []);
  CSS.make("_a_7q0025a1y", []);
  CSS.make("_a_7q001lweg", []);
  CSS.make("_a_7q001x81y", []);
  CSS.make("_a_7q001pv1b", []);
  CSS.make("_a_7q0012cvy", []);
  
  CSS.make("_a_7r002l53j", []);
  CSS.make("_a_7r002wkc2", []);
  CSS.make("_a_7r002u6cp", []);
  CSS.make("_a_7r002gejl", []);
  CSS.make("_a_7r0018jnk", []);
  CSS.make("_a_7r001jlf7", []);
  CSS.make("_a_7r001j3z4", []);
  CSS.make("_a_7r001dzrx", []);
  
  CSS.make("_a_95002rm8j", []);
  CSS.make("_a_950027et8", []);
  CSS.make("_a_95002iev7", []);
  CSS.make("_a_95001cfwc", []);
  CSS.make("_a_95001kgml", []);
  CSS.make("_a_95001nqch", []);
  
  CSS.make("_a_96002s69z", []);
  CSS.make("_a_96002ziqq", []);
  CSS.make("_a_96002gmtp", []);
  CSS.make("_a_960012g5x", []);
  CSS.make("_a_96001gpxd", []);
  CSS.make("_a_96001442x", []);
  
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
  
  CSS.make("_a_3i010vlzl", []);
  CSS.make("_a_3i01093is", []);
  CSS.make("_a_3i010cw9r", []);
  CSS.make("_a_3i010t9g7", []);
  CSS.make("_a_3m010eo1a", []);
  CSS.make("_a_3m0102wgf", []);
  CSS.make("_a_3m010cr2x", []);
  CSS.make("_a_3m010yrtz", []);
  
  CSS.make("_a_3i00itjkl", []);
  CSS.make("_a_3i00ih45a", []);
  CSS.make("_a_3i00iesag", []);
  CSS.make("_a_3m00ia3pa", []);
  CSS.make("_a_3m00itzyz", []);
  CSS.make("_a_3m00ij1mb", []);
