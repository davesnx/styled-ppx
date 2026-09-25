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
  [@css ".a-d1zs7t{text-transform:full-width;}"];
  [@css ".a-d1cm01{text-transform:full-size-kana;}"];
  [@css ".a-c3d4rk{-moz-tab-size:4;-o-tab-size:4;tab-size:4;}"];
  [@css ".a-c3seav{-moz-tab-size:1em;-o-tab-size:1em;tab-size:1em;}"];
  [@css ".a-7kf57d{line-break:auto;}"];
  [@css ".a-7ku21a{line-break:loose;}"];
  [@css ".a-7ktxm8{line-break:normal;}"];
  [@css ".a-7kkryp{line-break:strict;}"];
  [@css ".a-7k3sz0{line-break:anywhere;}"];
  [@css ".a-eegras{word-break:normal;}"];
  [@css ".a-ee2x84{word-break:keep-all;}"];
  [@css ".a-ee9omi{word-break:break-all;}"];
  [@css ".a-e95a1r{white-space:break-spaces;}"];
  [@css
    ".a-6ryffq{-webkit-hyphens:auto;-moz-hyphens:auto;-ms-hyphens:auto;hyphens:auto;}"
  ];
  [@css
    ".a-6rmz35{-webkit-hyphens:manual;-moz-hyphens:manual;-ms-hyphens:manual;hyphens:manual;}"
  ];
  [@css
    ".a-6rs3eu{-webkit-hyphens:none;-moz-hyphens:none;-ms-hyphens:none;hyphens:none;}"
  ];
  [@css ".a-8xlw6e{overflow-wrap:normal;}"];
  [@css ".a-8xkrze{overflow-wrap:break-word;}"];
  [@css ".a-8x4jlj{overflow-wrap:anywhere;}"];
  [@css ".a-8xzy01{word-wrap:normal;}"];
  [@css ".a-8xpt08{word-wrap:break-word;}"];
  [@css ".a-8xnm8r{word-wrap:anywhere;}"];
  [@css ".a-c5f5ff{text-align:start;}"];
  [@css ".a-c5k842{text-align:end;}"];
  [@css ".a-c5rihr{text-align:left;}"];
  [@css ".a-c5uf1z{text-align:right;}"];
  [@css ".a-c5606m{text-align:center;}"];
  [@css ".a-c5vos8{text-align:justify;}"];
  [@css ".a-c58mhn{text-align:match-parent;}"];
  [@css ".a-c53ksq{text-align:justify-all;}"];
  [@css ".a-c6rn5a{text-align-all:start;}"];
  [@css ".a-c6ch4g{text-align-all:end;}"];
  [@css ".a-c6rnp3{text-align-all:left;}"];
  [@css ".a-c6xe7j{text-align-all:right;}"];
  [@css ".a-c6c0st{text-align-all:center;}"];
  [@css ".a-c651av{text-align-all:justify;}"];
  [@css ".a-c6rne5{text-align-all:match-parent;}"];
  [@css ".a-c7wb1w{text-align-last:auto;}"];
  [@css ".a-c7axb4{text-align-last:start;}"];
  [@css ".a-c7t416{text-align-last:end;}"];
  [@css ".a-c76fl7{text-align-last:left;}"];
  [@css ".a-c7b6fv{text-align-last:right;}"];
  [@css ".a-c70fqu{text-align-last:center;}"];
  [@css ".a-c7asgv{text-align-last:justify;}"];
  [@css ".a-c770fx{text-align-last:match-parent;}"];
  [@css ".a-crqbb2{text-justify:auto;}"];
  [@css ".a-crbh2m{text-justify:none;}"];
  [@css ".a-crsqlp{text-justify:inter-word;}"];
  [@css ".a-crz8sg{text-justify:inter-character;}"];
  [@css ".a-egc0xc{word-spacing:50%;}"];
  [@css ".a-cqmiop{text-indent:1em hanging;}"];
  [@css ".a-cqot2l{text-indent:1em each-line;}"];
  [@css ".a-cqr8hy{text-indent:1em hanging each-line;}"];
  [@css ".a-6k3lqv{hanging-punctuation:none;}"];
  [@css ".a-6kjo68{hanging-punctuation:first;}"];
  [@css ".a-6k534q{hanging-punctuation:last;}"];
  [@css ".a-6k34w2{hanging-punctuation:force-end;}"];
  [@css ".a-6kc78w{hanging-punctuation:allow-end;}"];
  [@css ".a-6kgwj2{hanging-punctuation:first last;}"];
  [@css ".a-6ks42f{hanging-punctuation:first force-end;}"];
  [@css ".a-6kcfy1{hanging-punctuation:first force-end last;}"];
  [@css ".a-6kznai{hanging-punctuation:first allow-end last;}"];
  [@css ".a-d4w0i2{text-wrap:wrap;}"];
  [@css ".a-d4kd96{text-wrap:nowrap;}"];
  [@css ".a-d4oged{text-wrap:balance;}"];
  [@css ".a-d4w6iq{text-wrap:stable;}"];
  [@css ".a-d43dgl{text-wrap:pretty;}"];
  [@css ".a-d5b0wo{text-wrap-mode:wrap;}"];
  [@css ".a-d5odyq{text-wrap-mode:nowrap;}"];
  [@css ".a-d6lvfv{text-wrap-style:auto;}"];
  [@css ".a-d6ejd6{text-wrap-style:balance;}"];
  [@css ".a-d6qii6{text-wrap-style:stable;}"];
  [@css ".a-d664fg{text-wrap-style:pretty;}"];
  [@css ".a-6m76yp{hyphenate-character:auto;}"];
  [@css ".a-6qqykq{hyphenate-limit-zone:1%;}"];
  [@css ".a-6qimjy{hyphenate-limit-zone:1em;}"];
  [@css ".a-6nlbs0{hyphenate-limit-chars:auto;}"];
  [@css ".a-6np8d5{hyphenate-limit-chars:5;}"];
  [@css ".a-6px7k1{hyphenate-limit-lines:no-limit;}"];
  [@css ".a-6prd43{hyphenate-limit-lines:2;}"];
  
  CSS.make("a-d1zs7t", []);
  CSS.make("a-d1cm01", []);
  
  CSS.make("a-c3d4rk", []);
  CSS.make("a-c3seav", []);
  CSS.make("a-7kf57d", []);
  CSS.make("a-7ku21a", []);
  CSS.make("a-7ktxm8", []);
  CSS.make("a-7kkryp", []);
  CSS.make("a-7k3sz0", []);
  CSS.make("a-eegras", []);
  CSS.make("a-ee2x84", []);
  CSS.make("a-ee9omi", []);
  CSS.make("a-e95a1r", []);
  CSS.make("a-6ryffq", []);
  CSS.make("a-6rmz35", []);
  CSS.make("a-6rs3eu", []);
  CSS.make("a-8xlw6e", []);
  CSS.make("a-8xkrze", []);
  CSS.make("a-8x4jlj", []);
  CSS.make("a-8xzy01", []);
  CSS.make("a-8xpt08", []);
  CSS.make("a-8xnm8r", []);
  CSS.make("a-c5f5ff", []);
  CSS.make("a-c5k842", []);
  CSS.make("a-c5rihr", []);
  CSS.make("a-c5uf1z", []);
  CSS.make("a-c5606m", []);
  CSS.make("a-c5vos8", []);
  CSS.make("a-c58mhn", []);
  CSS.make("a-c53ksq", []);
  CSS.make("a-c6rn5a", []);
  CSS.make("a-c6ch4g", []);
  CSS.make("a-c6rnp3", []);
  CSS.make("a-c6xe7j", []);
  CSS.make("a-c6c0st", []);
  CSS.make("a-c651av", []);
  CSS.make("a-c6rne5", []);
  CSS.make("a-c7wb1w", []);
  CSS.make("a-c7axb4", []);
  CSS.make("a-c7t416", []);
  CSS.make("a-c76fl7", []);
  CSS.make("a-c7b6fv", []);
  CSS.make("a-c70fqu", []);
  CSS.make("a-c7asgv", []);
  CSS.make("a-c770fx", []);
  CSS.make("a-crqbb2", []);
  CSS.make("a-crbh2m", []);
  CSS.make("a-crsqlp", []);
  CSS.make("a-crz8sg", []);
  CSS.make("a-egc0xc", []);
  CSS.make("a-cqmiop", []);
  CSS.make("a-cqot2l", []);
  CSS.make("a-cqr8hy", []);
  CSS.make("a-6k3lqv", []);
  CSS.make("a-6kjo68", []);
  CSS.make("a-6k534q", []);
  CSS.make("a-6k34w2", []);
  CSS.make("a-6kc78w", []);
  CSS.make("a-6kgwj2", []);
  CSS.make("a-6ks42f", []);
  CSS.make("a-6kcfy1", []);
  CSS.make("a-6kznai", []);
  
  CSS.make("a-d4w0i2", []);
  CSS.make("a-d4kd96", []);
  CSS.make("a-d4oged", []);
  CSS.make("a-d4w6iq", []);
  CSS.make("a-d43dgl", []);
  CSS.make("a-d5b0wo", []);
  CSS.make("a-d5odyq", []);
  CSS.make("a-d6lvfv", []);
  CSS.make("a-d6ejd6", []);
  CSS.make("a-d6qii6", []);
  CSS.make("a-d664fg", []);
  
  CSS.make("a-6m76yp", []);
  CSS.make("a-6qqykq", []);
  CSS.make("a-6qimjy", []);
  CSS.make("a-6nlbs0", []);
  CSS.make("a-6np8d5", []);
  
  CSS.make("a-6px7k1", []);
  CSS.make("a-6prd43", []);
