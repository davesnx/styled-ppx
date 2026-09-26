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
  [@css "._a_d1zs7t{text-transform:full-width;}"];
  [@css "._a_d1cm01{text-transform:full-size-kana;}"];
  [@css "._a_c3d4rk{-moz-tab-size:4;-o-tab-size:4;tab-size:4;}"];
  [@css "._a_c3seav{-moz-tab-size:1em;-o-tab-size:1em;tab-size:1em;}"];
  [@css "._a_7kf57d{line-break:auto;}"];
  [@css "._a_7ku21a{line-break:loose;}"];
  [@css "._a_7ktxm8{line-break:normal;}"];
  [@css "._a_7kkryp{line-break:strict;}"];
  [@css "._a_7k3sz0{line-break:anywhere;}"];
  [@css "._a_eegras{word-break:normal;}"];
  [@css "._a_ee2x84{word-break:keep-all;}"];
  [@css "._a_ee9omi{word-break:break-all;}"];
  [@css "._a_e95a1r{white-space:break-spaces;}"];
  [@css
    "._a_6ryffq{-webkit-hyphens:auto;-moz-hyphens:auto;-ms-hyphens:auto;hyphens:auto;}"
  ];
  [@css
    "._a_6rmz35{-webkit-hyphens:manual;-moz-hyphens:manual;-ms-hyphens:manual;hyphens:manual;}"
  ];
  [@css
    "._a_6rs3eu{-webkit-hyphens:none;-moz-hyphens:none;-ms-hyphens:none;hyphens:none;}"
  ];
  [@css "._a_8xlw6e{overflow-wrap:normal;}"];
  [@css "._a_8xkrze{overflow-wrap:break-word;}"];
  [@css "._a_8x4jlj{overflow-wrap:anywhere;}"];
  [@css "._a_8xzy01{word-wrap:normal;}"];
  [@css "._a_8xpt08{word-wrap:break-word;}"];
  [@css "._a_8xnm8r{word-wrap:anywhere;}"];
  [@css "._a_c5f5ff{text-align:start;}"];
  [@css "._a_c5k842{text-align:end;}"];
  [@css "._a_c5rihr{text-align:left;}"];
  [@css "._a_c5uf1z{text-align:right;}"];
  [@css "._a_c5606m{text-align:center;}"];
  [@css "._a_c5vos8{text-align:justify;}"];
  [@css "._a_c58mhn{text-align:match-parent;}"];
  [@css "._a_c53ksq{text-align:justify-all;}"];
  [@css "._a_c6rn5a{text-align-all:start;}"];
  [@css "._a_c6ch4g{text-align-all:end;}"];
  [@css "._a_c6rnp3{text-align-all:left;}"];
  [@css "._a_c6xe7j{text-align-all:right;}"];
  [@css "._a_c6c0st{text-align-all:center;}"];
  [@css "._a_c651av{text-align-all:justify;}"];
  [@css "._a_c6rne5{text-align-all:match-parent;}"];
  [@css "._a_c7wb1w{text-align-last:auto;}"];
  [@css "._a_c7axb4{text-align-last:start;}"];
  [@css "._a_c7t416{text-align-last:end;}"];
  [@css "._a_c76fl7{text-align-last:left;}"];
  [@css "._a_c7b6fv{text-align-last:right;}"];
  [@css "._a_c70fqu{text-align-last:center;}"];
  [@css "._a_c7asgv{text-align-last:justify;}"];
  [@css "._a_c770fx{text-align-last:match-parent;}"];
  [@css "._a_crqbb2{text-justify:auto;}"];
  [@css "._a_crbh2m{text-justify:none;}"];
  [@css "._a_crsqlp{text-justify:inter-word;}"];
  [@css "._a_crz8sg{text-justify:inter-character;}"];
  [@css "._a_egc0xc{word-spacing:50%;}"];
  [@css "._a_cqmiop{text-indent:1em hanging;}"];
  [@css "._a_cqot2l{text-indent:1em each-line;}"];
  [@css "._a_cqr8hy{text-indent:1em hanging each-line;}"];
  [@css "._a_6k3lqv{hanging-punctuation:none;}"];
  [@css "._a_6kjo68{hanging-punctuation:first;}"];
  [@css "._a_6k534q{hanging-punctuation:last;}"];
  [@css "._a_6k34w2{hanging-punctuation:force-end;}"];
  [@css "._a_6kc78w{hanging-punctuation:allow-end;}"];
  [@css "._a_6kgwj2{hanging-punctuation:first last;}"];
  [@css "._a_6ks42f{hanging-punctuation:first force-end;}"];
  [@css "._a_6kcfy1{hanging-punctuation:first force-end last;}"];
  [@css "._a_6kznai{hanging-punctuation:first allow-end last;}"];
  [@css "._a_d4w0i2{text-wrap:wrap;}"];
  [@css "._a_d4kd96{text-wrap:nowrap;}"];
  [@css "._a_d4oged{text-wrap:balance;}"];
  [@css "._a_d4w6iq{text-wrap:stable;}"];
  [@css "._a_d43dgl{text-wrap:pretty;}"];
  [@css "._a_d5b0wo{text-wrap-mode:wrap;}"];
  [@css "._a_d5odyq{text-wrap-mode:nowrap;}"];
  [@css "._a_d6lvfv{text-wrap-style:auto;}"];
  [@css "._a_d6ejd6{text-wrap-style:balance;}"];
  [@css "._a_d6qii6{text-wrap-style:stable;}"];
  [@css "._a_d664fg{text-wrap-style:pretty;}"];
  [@css "._a_6m76yp{hyphenate-character:auto;}"];
  [@css "._a_6qqykq{hyphenate-limit-zone:1%;}"];
  [@css "._a_6qimjy{hyphenate-limit-zone:1em;}"];
  [@css "._a_6nlbs0{hyphenate-limit-chars:auto;}"];
  [@css "._a_6np8d5{hyphenate-limit-chars:5;}"];
  [@css "._a_6px7k1{hyphenate-limit-lines:no-limit;}"];
  [@css "._a_6prd43{hyphenate-limit-lines:2;}"];
  
  CSS.make("_a_d1zs7t", []);
  CSS.make("_a_d1cm01", []);
  
  CSS.make("_a_c3d4rk", []);
  CSS.make("_a_c3seav", []);
  CSS.make("_a_7kf57d", []);
  CSS.make("_a_7ku21a", []);
  CSS.make("_a_7ktxm8", []);
  CSS.make("_a_7kkryp", []);
  CSS.make("_a_7k3sz0", []);
  CSS.make("_a_eegras", []);
  CSS.make("_a_ee2x84", []);
  CSS.make("_a_ee9omi", []);
  CSS.make("_a_e95a1r", []);
  CSS.make("_a_6ryffq", []);
  CSS.make("_a_6rmz35", []);
  CSS.make("_a_6rs3eu", []);
  CSS.make("_a_8xlw6e", []);
  CSS.make("_a_8xkrze", []);
  CSS.make("_a_8x4jlj", []);
  CSS.make("_a_8xzy01", []);
  CSS.make("_a_8xpt08", []);
  CSS.make("_a_8xnm8r", []);
  CSS.make("_a_c5f5ff", []);
  CSS.make("_a_c5k842", []);
  CSS.make("_a_c5rihr", []);
  CSS.make("_a_c5uf1z", []);
  CSS.make("_a_c5606m", []);
  CSS.make("_a_c5vos8", []);
  CSS.make("_a_c58mhn", []);
  CSS.make("_a_c53ksq", []);
  CSS.make("_a_c6rn5a", []);
  CSS.make("_a_c6ch4g", []);
  CSS.make("_a_c6rnp3", []);
  CSS.make("_a_c6xe7j", []);
  CSS.make("_a_c6c0st", []);
  CSS.make("_a_c651av", []);
  CSS.make("_a_c6rne5", []);
  CSS.make("_a_c7wb1w", []);
  CSS.make("_a_c7axb4", []);
  CSS.make("_a_c7t416", []);
  CSS.make("_a_c76fl7", []);
  CSS.make("_a_c7b6fv", []);
  CSS.make("_a_c70fqu", []);
  CSS.make("_a_c7asgv", []);
  CSS.make("_a_c770fx", []);
  CSS.make("_a_crqbb2", []);
  CSS.make("_a_crbh2m", []);
  CSS.make("_a_crsqlp", []);
  CSS.make("_a_crz8sg", []);
  CSS.make("_a_egc0xc", []);
  CSS.make("_a_cqmiop", []);
  CSS.make("_a_cqot2l", []);
  CSS.make("_a_cqr8hy", []);
  CSS.make("_a_6k3lqv", []);
  CSS.make("_a_6kjo68", []);
  CSS.make("_a_6k534q", []);
  CSS.make("_a_6k34w2", []);
  CSS.make("_a_6kc78w", []);
  CSS.make("_a_6kgwj2", []);
  CSS.make("_a_6ks42f", []);
  CSS.make("_a_6kcfy1", []);
  CSS.make("_a_6kznai", []);
  
  CSS.make("_a_d4w0i2", []);
  CSS.make("_a_d4kd96", []);
  CSS.make("_a_d4oged", []);
  CSS.make("_a_d4w6iq", []);
  CSS.make("_a_d43dgl", []);
  CSS.make("_a_d5b0wo", []);
  CSS.make("_a_d5odyq", []);
  CSS.make("_a_d6lvfv", []);
  CSS.make("_a_d6ejd6", []);
  CSS.make("_a_d6qii6", []);
  CSS.make("_a_d664fg", []);
  
  CSS.make("_a_6m76yp", []);
  CSS.make("_a_6qqykq", []);
  CSS.make("_a_6qimjy", []);
  CSS.make("_a_6nlbs0", []);
  CSS.make("_a_6np8d5", []);
  
  CSS.make("_a_6px7k1", []);
  CSS.make("_a_6prd43", []);
