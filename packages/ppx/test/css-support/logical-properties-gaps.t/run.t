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
  [@css ".a-168gwfb{margin-block-start:auto;}"];
  [@css ".a-8f2oos{margin-block-start:0;}"];
  [@css ".a-2t17su{margin-block-start:10%;}"];
  [@css ".a-1ly5a1y{margin-block-start:calc(10px + 5%);}"];
  [@css ".a-r2lweg{margin-block-end:auto;}"];
  [@css ".a-zwx81y{margin-block-end:0;}"];
  [@css ".a-mrpv1b{margin-block-end:10%;}"];
  [@css ".a-18s2cvy{margin-block-end:calc(10px + 5%);}"];
  [@css ".a-8bl53j{-webkit-margin-inline-start:auto;margin-inline-start:auto;}"];
  [@css ".a-1towkc2{-webkit-margin-inline-start:0;margin-inline-start:0;}"];
  [@css ".a-1m3u6cp{-webkit-margin-inline-start:10%;margin-inline-start:10%;}"];
  [@css
    ".a-1e3gejl{-webkit-margin-inline-start:calc(10px + 5%);margin-inline-start:calc(10px + 5%);}"
  ];
  [@css ".a-17o8jnk{-webkit-margin-inline-end:auto;margin-inline-end:auto;}"];
  [@css ".a-nqjlf7{-webkit-margin-inline-end:0;margin-inline-end:0;}"];
  [@css ".a-174j3z4{-webkit-margin-inline-end:10%;margin-inline-end:10%;}"];
  [@css
    ".a-c7dzrx{-webkit-margin-inline-end:calc(10px + 5%);margin-inline-end:calc(10px + 5%);}"
  ];
  [@css ".a-1fqrm8j{padding-block-start:0;}"];
  [@css ".a-4y7et8{padding-block-start:10%;}"];
  [@css ".a-kriev7{padding-block-start:calc(10px + 5%);}"];
  [@css ".a-1j8cfwc{padding-block-end:0;}"];
  [@css ".a-4ckgml{padding-block-end:10%;}"];
  [@css ".a-f1nqch{padding-block-end:calc(10px + 5%);}"];
  [@css ".a-9qs69z{-webkit-padding-inline-start:0;padding-inline-start:0;}"];
  [@css ".a-x4ziqq{-webkit-padding-inline-start:10%;padding-inline-start:10%;}"];
  [@css
    ".a-81gmtp{-webkit-padding-inline-start:calc(10px + 5%);padding-inline-start:calc(10px + 5%);}"
  ];
  [@css ".a-1ny2g5x{-webkit-padding-inline-end:0;padding-inline-end:0;}"];
  [@css ".a-116gpxd{-webkit-padding-inline-end:10%;padding-inline-end:10%;}"];
  [@css
    ".a-rr442x{-webkit-padding-inline-end:calc(10px + 5%);padding-inline-end:calc(10px + 5%);}"
  ];
  [@css ".a-mogd9e{margin-block:auto auto;}"];
  [@css ".a-14y7mti{margin-block:10px 20px;}"];
  [@css ".a-um4ct{margin-block:10% 20%;}"];
  [@css ".a-3mqsk6{margin-inline:auto auto;}"];
  [@css ".a-15o6zwf{margin-inline:10px 20px;}"];
  [@css ".a-8i06xy{margin-inline:10% 20%;}"];
  [@css ".a-9dusfj{padding-block:10px 20px;}"];
  [@css ".a-pxl5sm{padding-block:10% 20%;}"];
  [@css ".a-1o9y7fc{padding-inline:10px 20px;}"];
  [@css ".a-d9p1qw{padding-inline:10% 20%;}"];
  [@css ".a-1wfvlzl{border-block-width:thin;}"];
  [@css ".a-bl93is{border-block-width:medium;}"];
  [@css ".a-1bbcw9r{border-block-width:thick;}"];
  [@css ".a-1y1t9g7{border-block-width:2px;}"];
  [@css ".a-1h5eo1a{border-inline-width:thin;}"];
  [@css ".a-17b2wgf{border-inline-width:medium;}"];
  [@css ".a-1m0cr2x{border-inline-width:thick;}"];
  [@css ".a-1b2yrtz{border-inline-width:2px;}"];
  [@css ".a-1v3tjkl{border-block-style:none;}"];
  [@css ".a-tvh45a{border-block-style:solid;}"];
  [@css ".a-v2esag{border-block-style:dashed;}"];
  [@css ".a-vca3pa{border-inline-style:none;}"];
  [@css ".a-1qbtzyz{border-inline-style:solid;}"];
  [@css ".a-16nj1mb{border-inline-style:dashed;}"];
  
  CSS.make("a-168gwfb", []);
  CSS.make("a-8f2oos", []);
  CSS.make("a-2t17su", []);
  CSS.make("a-1ly5a1y", []);
  CSS.make("a-r2lweg", []);
  CSS.make("a-zwx81y", []);
  CSS.make("a-mrpv1b", []);
  CSS.make("a-18s2cvy", []);
  
  CSS.make("a-8bl53j", []);
  CSS.make("a-1towkc2", []);
  CSS.make("a-1m3u6cp", []);
  CSS.make("a-1e3gejl", []);
  CSS.make("a-17o8jnk", []);
  CSS.make("a-nqjlf7", []);
  CSS.make("a-174j3z4", []);
  CSS.make("a-c7dzrx", []);
  
  CSS.make("a-1fqrm8j", []);
  CSS.make("a-4y7et8", []);
  CSS.make("a-kriev7", []);
  CSS.make("a-1j8cfwc", []);
  CSS.make("a-4ckgml", []);
  CSS.make("a-f1nqch", []);
  
  CSS.make("a-9qs69z", []);
  CSS.make("a-x4ziqq", []);
  CSS.make("a-81gmtp", []);
  CSS.make("a-1ny2g5x", []);
  CSS.make("a-116gpxd", []);
  CSS.make("a-rr442x", []);
  
  CSS.make("a-mogd9e", []);
  CSS.make("a-14y7mti", []);
  CSS.make("a-um4ct", []);
  CSS.make("a-3mqsk6", []);
  CSS.make("a-15o6zwf", []);
  CSS.make("a-8i06xy", []);
  
  CSS.make("a-9dusfj", []);
  CSS.make("a-pxl5sm", []);
  CSS.make("a-1o9y7fc", []);
  CSS.make("a-d9p1qw", []);
  
  CSS.make("a-1wfvlzl", []);
  CSS.make("a-bl93is", []);
  CSS.make("a-1bbcw9r", []);
  CSS.make("a-1y1t9g7", []);
  CSS.make("a-1h5eo1a", []);
  CSS.make("a-17b2wgf", []);
  CSS.make("a-1m0cr2x", []);
  CSS.make("a-1b2yrtz", []);
  
  CSS.make("a-1v3tjkl", []);
  CSS.make("a-tvh45a", []);
  CSS.make("a-v2esag", []);
  CSS.make("a-vca3pa", []);
  CSS.make("a-1qbtzyz", []);
  CSS.make("a-16nj1mb", []);
