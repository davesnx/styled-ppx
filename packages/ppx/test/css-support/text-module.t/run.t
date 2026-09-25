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
  [@css ".a-kmzs7t{text-transform:full-width;}"];
  [@css ".a-1xpcm01{text-transform:full-size-kana;}"];
  [@css ".a-y1d4rk{-moz-tab-size:4;-o-tab-size:4;tab-size:4;}"];
  [@css ".a-17xseav{-moz-tab-size:1em;-o-tab-size:1em;tab-size:1em;}"];
  [@css ".a-1i9f57d{line-break:auto;}"];
  [@css ".a-1jpu21a{line-break:loose;}"];
  [@css ".a-n4txm8{line-break:normal;}"];
  [@css ".a-1tlkryp{line-break:strict;}"];
  [@css ".a-ym3sz0{line-break:anywhere;}"];
  [@css ".a-ktgras{word-break:normal;}"];
  [@css ".a-1nw2x84{word-break:keep-all;}"];
  [@css ".a-1hg9omi{word-break:break-all;}"];
  [@css ".a-1vw5a1r{white-space:break-spaces;}"];
  [@css
    ".a-y8yffq{-webkit-hyphens:auto;-moz-hyphens:auto;-ms-hyphens:auto;hyphens:auto;}"
  ];
  [@css
    ".a-16qmz35{-webkit-hyphens:manual;-moz-hyphens:manual;-ms-hyphens:manual;hyphens:manual;}"
  ];
  [@css
    ".a-1oys3eu{-webkit-hyphens:none;-moz-hyphens:none;-ms-hyphens:none;hyphens:none;}"
  ];
  [@css ".a-kilw6e{overflow-wrap:normal;}"];
  [@css ".a-1wekrze{overflow-wrap:break-word;}"];
  [@css ".a-9x4jlj{overflow-wrap:anywhere;}"];
  [@css ".a-nvzy01{word-wrap:normal;}"];
  [@css ".a-kwpt08{word-wrap:break-word;}"];
  [@css ".a-1q4nm8r{word-wrap:anywhere;}"];
  [@css ".a-1eif5ff{text-align:start;}"];
  [@css ".a-1djk842{text-align:end;}"];
  [@css ".a-13brihr{text-align:left;}"];
  [@css ".a-s2uf1z{text-align:right;}"];
  [@css ".a-xi606m{text-align:center;}"];
  [@css ".a-tpvos8{text-align:justify;}"];
  [@css ".a-1jf8mhn{text-align:match-parent;}"];
  [@css ".a-1in3ksq{text-align:justify-all;}"];
  [@css ".a-ojrn5a{text-align-all:start;}"];
  [@css ".a-10ach4g{text-align-all:end;}"];
  [@css ".a-1hjrnp3{text-align-all:left;}"];
  [@css ".a-7uxe7j{text-align-all:right;}"];
  [@css ".a-q3c0st{text-align-all:center;}"];
  [@css ".a-6d51av{text-align-all:justify;}"];
  [@css ".a-8urne5{text-align-all:match-parent;}"];
  [@css ".a-1bxwb1w{text-align-last:auto;}"];
  [@css ".a-qnaxb4{text-align-last:start;}"];
  [@css ".a-8zt416{text-align-last:end;}"];
  [@css ".a-hu6fl7{text-align-last:left;}"];
  [@css ".a-zmb6fv{text-align-last:right;}"];
  [@css ".a-1ai0fqu{text-align-last:center;}"];
  [@css ".a-trasgv{text-align-last:justify;}"];
  [@css ".a-1oo70fx{text-align-last:match-parent;}"];
  [@css ".a-88qbb2{text-justify:auto;}"];
  [@css ".a-jlbh2m{text-justify:none;}"];
  [@css ".a-11asqlp{text-justify:inter-word;}"];
  [@css ".a-1s1z8sg{text-justify:inter-character;}"];
  [@css ".a-1d6c0xc{word-spacing:50%;}"];
  [@css ".a-1x8miop{text-indent:1em hanging;}"];
  [@css ".a-7sot2l{text-indent:1em each-line;}"];
  [@css ".a-q7r8hy{text-indent:1em hanging each-line;}"];
  [@css ".a-6z3lqv{hanging-punctuation:none;}"];
  [@css ".a-1t0jo68{hanging-punctuation:first;}"];
  [@css ".a-o1534q{hanging-punctuation:last;}"];
  [@css ".a-tu34w2{hanging-punctuation:force-end;}"];
  [@css ".a-m9c78w{hanging-punctuation:allow-end;}"];
  [@css ".a-19qgwj2{hanging-punctuation:first last;}"];
  [@css ".a-yms42f{hanging-punctuation:first force-end;}"];
  [@css ".a-10cfy1{hanging-punctuation:first force-end last;}"];
  [@css ".a-huznai{hanging-punctuation:first allow-end last;}"];
  [@css ".a-1qww0i2{text-wrap:wrap;}"];
  [@css ".a-1g7kd96{text-wrap:nowrap;}"];
  [@css ".a-1lsoged{text-wrap:balance;}"];
  [@css ".a-7rw6iq{text-wrap:stable;}"];
  [@css ".a-e53dgl{text-wrap:pretty;}"];
  [@css ".a-1uwb0wo{text-wrap-mode:wrap;}"];
  [@css ".a-smodyq{text-wrap-mode:nowrap;}"];
  [@css ".a-16ylvfv{text-wrap-style:auto;}"];
  [@css ".a-djejd6{text-wrap-style:balance;}"];
  [@css ".a-gfqii6{text-wrap-style:stable;}"];
  [@css ".a-z764fg{text-wrap-style:pretty;}"];
  [@css ".a-ga76yp{hyphenate-character:auto;}"];
  [@css ".a-r4qykq{hyphenate-limit-zone:1%;}"];
  [@css ".a-j6imjy{hyphenate-limit-zone:1em;}"];
  [@css ".a-vclbs0{hyphenate-limit-chars:auto;}"];
  [@css ".a-1bnp8d5{hyphenate-limit-chars:5;}"];
  [@css ".a-3tx7k1{hyphenate-limit-lines:no-limit;}"];
  [@css ".a-16vrd43{hyphenate-limit-lines:2;}"];
  
  CSS.make("a-kmzs7t", []);
  CSS.make("a-1xpcm01", []);
  
  CSS.make("a-y1d4rk", []);
  CSS.make("a-17xseav", []);
  CSS.make("a-1i9f57d", []);
  CSS.make("a-1jpu21a", []);
  CSS.make("a-n4txm8", []);
  CSS.make("a-1tlkryp", []);
  CSS.make("a-ym3sz0", []);
  CSS.make("a-ktgras", []);
  CSS.make("a-1nw2x84", []);
  CSS.make("a-1hg9omi", []);
  CSS.make("a-1vw5a1r", []);
  CSS.make("a-y8yffq", []);
  CSS.make("a-16qmz35", []);
  CSS.make("a-1oys3eu", []);
  CSS.make("a-kilw6e", []);
  CSS.make("a-1wekrze", []);
  CSS.make("a-9x4jlj", []);
  CSS.make("a-nvzy01", []);
  CSS.make("a-kwpt08", []);
  CSS.make("a-1q4nm8r", []);
  CSS.make("a-1eif5ff", []);
  CSS.make("a-1djk842", []);
  CSS.make("a-13brihr", []);
  CSS.make("a-s2uf1z", []);
  CSS.make("a-xi606m", []);
  CSS.make("a-tpvos8", []);
  CSS.make("a-1jf8mhn", []);
  CSS.make("a-1in3ksq", []);
  CSS.make("a-ojrn5a", []);
  CSS.make("a-10ach4g", []);
  CSS.make("a-1hjrnp3", []);
  CSS.make("a-7uxe7j", []);
  CSS.make("a-q3c0st", []);
  CSS.make("a-6d51av", []);
  CSS.make("a-8urne5", []);
  CSS.make("a-1bxwb1w", []);
  CSS.make("a-qnaxb4", []);
  CSS.make("a-8zt416", []);
  CSS.make("a-hu6fl7", []);
  CSS.make("a-zmb6fv", []);
  CSS.make("a-1ai0fqu", []);
  CSS.make("a-trasgv", []);
  CSS.make("a-1oo70fx", []);
  CSS.make("a-88qbb2", []);
  CSS.make("a-jlbh2m", []);
  CSS.make("a-11asqlp", []);
  CSS.make("a-1s1z8sg", []);
  CSS.make("a-1d6c0xc", []);
  CSS.make("a-1x8miop", []);
  CSS.make("a-7sot2l", []);
  CSS.make("a-q7r8hy", []);
  CSS.make("a-6z3lqv", []);
  CSS.make("a-1t0jo68", []);
  CSS.make("a-o1534q", []);
  CSS.make("a-tu34w2", []);
  CSS.make("a-m9c78w", []);
  CSS.make("a-19qgwj2", []);
  CSS.make("a-yms42f", []);
  CSS.make("a-10cfy1", []);
  CSS.make("a-huznai", []);
  
  CSS.make("a-1qww0i2", []);
  CSS.make("a-1g7kd96", []);
  CSS.make("a-1lsoged", []);
  CSS.make("a-7rw6iq", []);
  CSS.make("a-e53dgl", []);
  CSS.make("a-1uwb0wo", []);
  CSS.make("a-smodyq", []);
  CSS.make("a-16ylvfv", []);
  CSS.make("a-djejd6", []);
  CSS.make("a-gfqii6", []);
  CSS.make("a-z764fg", []);
  
  CSS.make("a-ga76yp", []);
  CSS.make("a-r4qykq", []);
  CSS.make("a-j6imjy", []);
  CSS.make("a-vclbs0", []);
  CSS.make("a-1bnp8d5", []);
  
  CSS.make("a-3tx7k1", []);
  CSS.make("a-16vrd43", []);
