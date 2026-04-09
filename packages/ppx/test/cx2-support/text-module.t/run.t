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
  [@css ".css-kmzs7t{text-transform:full-width;}"];
  [@css ".css-1xpcm01{text-transform:full-size-kana;}"];
  [@css ".css-y1d4rk{tab-size:4;}"];
  [@css ".css-17xseav{tab-size:1em;}"];
  [@css ".css-1i9f57d{line-break:auto;}"];
  [@css ".css-1jpu21a{line-break:loose;}"];
  [@css ".css-n4txm8{line-break:normal;}"];
  [@css ".css-1tlkryp{line-break:strict;}"];
  [@css ".css-ym3sz0{line-break:anywhere;}"];
  [@css ".css-ktgras{word-break:normal;}"];
  [@css ".css-1nw2x84{word-break:keep-all;}"];
  [@css ".css-1hg9omi{word-break:break-all;}"];
  [@css ".css-1vw5a1r{white-space:break-spaces;}"];
  [@css ".css-y8yffq{hyphens:auto;}"];
  [@css ".css-16qmz35{hyphens:manual;}"];
  [@css ".css-1oys3eu{hyphens:none;}"];
  [@css ".css-kilw6e{overflow-wrap:normal;}"];
  [@css ".css-1wekrze{overflow-wrap:break-word;}"];
  [@css ".css-9x4jlj{overflow-wrap:anywhere;}"];
  [@css ".css-nvzy01{word-wrap:normal;}"];
  [@css ".css-kwpt08{word-wrap:break-word;}"];
  [@css ".css-1q4nm8r{word-wrap:anywhere;}"];
  [@css ".css-1eif5ff{text-align:start;}"];
  [@css ".css-1djk842{text-align:end;}"];
  [@css ".css-13brihr{text-align:left;}"];
  [@css ".css-s2uf1z{text-align:right;}"];
  [@css ".css-xi606m{text-align:center;}"];
  [@css ".css-tpvos8{text-align:justify;}"];
  [@css ".css-1jf8mhn{text-align:match-parent;}"];
  [@css ".css-1in3ksq{text-align:justify-all;}"];
  [@css ".css-ojrn5a{text-align-all:start;}"];
  [@css ".css-10ach4g{text-align-all:end;}"];
  [@css ".css-1hjrnp3{text-align-all:left;}"];
  [@css ".css-7uxe7j{text-align-all:right;}"];
  [@css ".css-q3c0st{text-align-all:center;}"];
  [@css ".css-6d51av{text-align-all:justify;}"];
  [@css ".css-8urne5{text-align-all:match-parent;}"];
  [@css ".css-1bxwb1w{text-align-last:auto;}"];
  [@css ".css-qnaxb4{text-align-last:start;}"];
  [@css ".css-8zt416{text-align-last:end;}"];
  [@css ".css-hu6fl7{text-align-last:left;}"];
  [@css ".css-zmb6fv{text-align-last:right;}"];
  [@css ".css-1ai0fqu{text-align-last:center;}"];
  [@css ".css-trasgv{text-align-last:justify;}"];
  [@css ".css-1oo70fx{text-align-last:match-parent;}"];
  [@css ".css-88qbb2{text-justify:auto;}"];
  [@css ".css-jlbh2m{text-justify:none;}"];
  [@css ".css-11asqlp{text-justify:inter-word;}"];
  [@css ".css-1s1z8sg{text-justify:inter-character;}"];
  [@css ".css-1d6c0xc{word-spacing:50%;}"];
  [@css ".css-1x8miop{text-indent:1em hanging;}"];
  [@css ".css-7sot2l{text-indent:1em each-line;}"];
  [@css ".css-q7r8hy{text-indent:1em hanging each-line;}"];
  [@css ".css-6z3lqv{hanging-punctuation:none;}"];
  [@css ".css-1t0jo68{hanging-punctuation:first;}"];
  [@css ".css-o1534q{hanging-punctuation:last;}"];
  [@css ".css-tu34w2{hanging-punctuation:force-end;}"];
  [@css ".css-m9c78w{hanging-punctuation:allow-end;}"];
  [@css ".css-19qgwj2{hanging-punctuation:first last;}"];
  [@css ".css-yms42f{hanging-punctuation:first force-end;}"];
  [@css ".css-10cfy1{hanging-punctuation:first force-end last;}"];
  [@css ".css-huznai{hanging-punctuation:first allow-end last;}"];
  [@css ".css-1qww0i2{text-wrap:wrap;}"];
  [@css ".css-1g7kd96{text-wrap:nowrap;}"];
  [@css ".css-1lsoged{text-wrap:balance;}"];
  [@css ".css-7rw6iq{text-wrap:stable;}"];
  [@css ".css-e53dgl{text-wrap:pretty;}"];
  [@css ".css-1uwb0wo{text-wrap-mode:wrap;}"];
  [@css ".css-smodyq{text-wrap-mode:nowrap;}"];
  [@css ".css-16ylvfv{text-wrap-style:auto;}"];
  [@css ".css-djejd6{text-wrap-style:balance;}"];
  [@css ".css-gfqii6{text-wrap-style:stable;}"];
  [@css ".css-z764fg{text-wrap-style:pretty;}"];
  [@css ".css-ga76yp{hyphenate-character:auto;}"];
  [@css ".css-r4qykq{hyphenate-limit-zone:1%;}"];
  [@css ".css-j6imjy{hyphenate-limit-zone:1em;}"];
  [@css ".css-vclbs0{hyphenate-limit-chars:auto;}"];
  [@css ".css-1bnp8d5{hyphenate-limit-chars:5;}"];
  [@css ".css-3tx7k1{hyphenate-limit-lines:no-limit;}"];
  [@css ".css-16vrd43{hyphenate-limit-lines:2;}"];
  
  CSS.make("css-kmzs7t", []);
  CSS.make("css-1xpcm01", []);
  
  CSS.make("css-y1d4rk", []);
  CSS.make("css-17xseav", []);
  CSS.make("css-1i9f57d", []);
  CSS.make("css-1jpu21a", []);
  CSS.make("css-n4txm8", []);
  CSS.make("css-1tlkryp", []);
  CSS.make("css-ym3sz0", []);
  CSS.make("css-ktgras", []);
  CSS.make("css-1nw2x84", []);
  CSS.make("css-1hg9omi", []);
  CSS.make("css-1vw5a1r", []);
  CSS.make("css-y8yffq", []);
  CSS.make("css-16qmz35", []);
  CSS.make("css-1oys3eu", []);
  CSS.make("css-kilw6e", []);
  CSS.make("css-1wekrze", []);
  CSS.make("css-9x4jlj", []);
  CSS.make("css-nvzy01", []);
  CSS.make("css-kwpt08", []);
  CSS.make("css-1q4nm8r", []);
  CSS.make("css-1eif5ff", []);
  CSS.make("css-1djk842", []);
  CSS.make("css-13brihr", []);
  CSS.make("css-s2uf1z", []);
  CSS.make("css-xi606m", []);
  CSS.make("css-tpvos8", []);
  CSS.make("css-1jf8mhn", []);
  CSS.make("css-1in3ksq", []);
  CSS.make("css-ojrn5a", []);
  CSS.make("css-10ach4g", []);
  CSS.make("css-1hjrnp3", []);
  CSS.make("css-7uxe7j", []);
  CSS.make("css-q3c0st", []);
  CSS.make("css-6d51av", []);
  CSS.make("css-8urne5", []);
  CSS.make("css-1bxwb1w", []);
  CSS.make("css-qnaxb4", []);
  CSS.make("css-8zt416", []);
  CSS.make("css-hu6fl7", []);
  CSS.make("css-zmb6fv", []);
  CSS.make("css-1ai0fqu", []);
  CSS.make("css-trasgv", []);
  CSS.make("css-1oo70fx", []);
  CSS.make("css-88qbb2", []);
  CSS.make("css-jlbh2m", []);
  CSS.make("css-11asqlp", []);
  CSS.make("css-1s1z8sg", []);
  CSS.make("css-1d6c0xc", []);
  CSS.make("css-1x8miop", []);
  CSS.make("css-7sot2l", []);
  CSS.make("css-q7r8hy", []);
  CSS.make("css-6z3lqv", []);
  CSS.make("css-1t0jo68", []);
  CSS.make("css-o1534q", []);
  CSS.make("css-tu34w2", []);
  CSS.make("css-m9c78w", []);
  CSS.make("css-19qgwj2", []);
  CSS.make("css-yms42f", []);
  CSS.make("css-10cfy1", []);
  CSS.make("css-huznai", []);
  
  CSS.make("css-1qww0i2", []);
  CSS.make("css-1g7kd96", []);
  CSS.make("css-1lsoged", []);
  CSS.make("css-7rw6iq", []);
  CSS.make("css-e53dgl", []);
  CSS.make("css-1uwb0wo", []);
  CSS.make("css-smodyq", []);
  CSS.make("css-16ylvfv", []);
  CSS.make("css-djejd6", []);
  CSS.make("css-gfqii6", []);
  CSS.make("css-z764fg", []);
  
  CSS.make("css-ga76yp", []);
  CSS.make("css-r4qykq", []);
  CSS.make("css-j6imjy", []);
  CSS.make("css-vclbs0", []);
  CSS.make("css-1bnp8d5", []);
  
  CSS.make("css-3tx7k1", []);
  CSS.make("css-16vrd43", []);
