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
  [@css ".css-168gwfb{margin-block-start:auto}"];
  [@css ".css-8f2oos{margin-block-start:0}"];
  [@css ".css-2t17su{margin-block-start:10%}"];
  [@css ".css-1ly5a1y{margin-block-start:calc(10px + 5%)}"];
  [@css ".css-r2lweg{margin-block-end:auto}"];
  [@css ".css-zwx81y{margin-block-end:0}"];
  [@css ".css-mrpv1b{margin-block-end:10%}"];
  [@css ".css-18s2cvy{margin-block-end:calc(10px + 5%)}"];
  [@css
    ".css-8bl53j{-webkit-margin-inline-start:auto;margin-inline-start:auto}"
  ];
  [@css ".css-1towkc2{-webkit-margin-inline-start:0;margin-inline-start:0}"];
  [@css ".css-1m3u6cp{-webkit-margin-inline-start:10%;margin-inline-start:10%}"];
  [@css
    ".css-1e3gejl{-webkit-margin-inline-start:calc(10px + 5%);margin-inline-start:calc(10px + 5%)}"
  ];
  [@css ".css-17o8jnk{-webkit-margin-inline-end:auto;margin-inline-end:auto}"];
  [@css ".css-nqjlf7{-webkit-margin-inline-end:0;margin-inline-end:0}"];
  [@css ".css-174j3z4{-webkit-margin-inline-end:10%;margin-inline-end:10%}"];
  [@css
    ".css-c7dzrx{-webkit-margin-inline-end:calc(10px + 5%);margin-inline-end:calc(10px + 5%)}"
  ];
  [@css ".css-1fqrm8j{padding-block-start:0}"];
  [@css ".css-4y7et8{padding-block-start:10%}"];
  [@css ".css-kriev7{padding-block-start:calc(10px + 5%)}"];
  [@css ".css-1j8cfwc{padding-block-end:0}"];
  [@css ".css-4ckgml{padding-block-end:10%}"];
  [@css ".css-f1nqch{padding-block-end:calc(10px + 5%)}"];
  [@css ".css-9qs69z{-webkit-padding-inline-start:0;padding-inline-start:0}"];
  [@css
    ".css-x4ziqq{-webkit-padding-inline-start:10%;padding-inline-start:10%}"
  ];
  [@css
    ".css-81gmtp{-webkit-padding-inline-start:calc(10px + 5%);padding-inline-start:calc(10px + 5%)}"
  ];
  [@css ".css-1ny2g5x{-webkit-padding-inline-end:0;padding-inline-end:0}"];
  [@css ".css-116gpxd{-webkit-padding-inline-end:10%;padding-inline-end:10%}"];
  [@css
    ".css-rr442x{-webkit-padding-inline-end:calc(10px + 5%);padding-inline-end:calc(10px + 5%)}"
  ];
  [@css ".css-mogd9e{margin-block:auto auto}"];
  [@css ".css-14y7mti{margin-block:10px 20px}"];
  [@css ".css-um4ct{margin-block:10% 20%}"];
  [@css ".css-3mqsk6{margin-inline:auto auto}"];
  [@css ".css-15o6zwf{margin-inline:10px 20px}"];
  [@css ".css-8i06xy{margin-inline:10% 20%}"];
  [@css ".css-9dusfj{padding-block:10px 20px}"];
  [@css ".css-pxl5sm{padding-block:10% 20%}"];
  [@css ".css-1o9y7fc{padding-inline:10px 20px}"];
  [@css ".css-d9p1qw{padding-inline:10% 20%}"];
  [@css ".css-1wfvlzl{border-block-width:thin}"];
  [@css ".css-bl93is{border-block-width:medium}"];
  [@css ".css-1bbcw9r{border-block-width:thick}"];
  [@css ".css-1y1t9g7{border-block-width:2px}"];
  [@css ".css-1h5eo1a{border-inline-width:thin}"];
  [@css ".css-17b2wgf{border-inline-width:medium}"];
  [@css ".css-1m0cr2x{border-inline-width:thick}"];
  [@css ".css-1b2yrtz{border-inline-width:2px}"];
  [@css ".css-1v3tjkl{border-block-style:none}"];
  [@css ".css-tvh45a{border-block-style:solid}"];
  [@css ".css-v2esag{border-block-style:dashed}"];
  [@css ".css-vca3pa{border-inline-style:none}"];
  [@css ".css-1qbtzyz{border-inline-style:solid}"];
  [@css ".css-16nj1mb{border-inline-style:dashed}"];
  
  CSS.make("css-168gwfb", []);
  CSS.make("css-8f2oos", []);
  CSS.make("css-2t17su", []);
  CSS.make("css-1ly5a1y", []);
  CSS.make("css-r2lweg", []);
  CSS.make("css-zwx81y", []);
  CSS.make("css-mrpv1b", []);
  CSS.make("css-18s2cvy", []);
  
  CSS.make("css-8bl53j", []);
  CSS.make("css-1towkc2", []);
  CSS.make("css-1m3u6cp", []);
  CSS.make("css-1e3gejl", []);
  CSS.make("css-17o8jnk", []);
  CSS.make("css-nqjlf7", []);
  CSS.make("css-174j3z4", []);
  CSS.make("css-c7dzrx", []);
  
  CSS.make("css-1fqrm8j", []);
  CSS.make("css-4y7et8", []);
  CSS.make("css-kriev7", []);
  CSS.make("css-1j8cfwc", []);
  CSS.make("css-4ckgml", []);
  CSS.make("css-f1nqch", []);
  
  CSS.make("css-9qs69z", []);
  CSS.make("css-x4ziqq", []);
  CSS.make("css-81gmtp", []);
  CSS.make("css-1ny2g5x", []);
  CSS.make("css-116gpxd", []);
  CSS.make("css-rr442x", []);
  
  CSS.make("css-mogd9e", []);
  CSS.make("css-14y7mti", []);
  CSS.make("css-um4ct", []);
  CSS.make("css-3mqsk6", []);
  CSS.make("css-15o6zwf", []);
  CSS.make("css-8i06xy", []);
  
  CSS.make("css-9dusfj", []);
  CSS.make("css-pxl5sm", []);
  CSS.make("css-1o9y7fc", []);
  CSS.make("css-d9p1qw", []);
  
  CSS.make("css-1wfvlzl", []);
  CSS.make("css-bl93is", []);
  CSS.make("css-1bbcw9r", []);
  CSS.make("css-1y1t9g7", []);
  CSS.make("css-1h5eo1a", []);
  CSS.make("css-17b2wgf", []);
  CSS.make("css-1m0cr2x", []);
  CSS.make("css-1b2yrtz", []);
  
  CSS.make("css-1v3tjkl", []);
  CSS.make("css-tvh45a", []);
  CSS.make("css-v2esag", []);
  CSS.make("css-vca3pa", []);
  CSS.make("css-1qbtzyz", []);
  CSS.make("css-16nj1mb", []);
