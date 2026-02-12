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
    ".css-kmzs7t{text-transform:full-width;}\n.css-1xpcm01{text-transform:full-size-kana;}\n.css-y1d4rk{tab-size:4;}\n.css-17xseav{tab-size:1em;}\n.css-1i9f57d{line-break:auto;}\n.css-1jpu21a{line-break:loose;}\n.css-n4txm8{line-break:normal;}\n.css-1tlkryp{line-break:strict;}\n.css-ym3sz0{line-break:anywhere;}\n.css-ktgras{word-break:normal;}\n.css-1nw2x84{word-break:keep-all;}\n.css-1hg9omi{word-break:break-all;}\n.css-1vw5a1r{white-space:break-spaces;}\n.css-y8yffq{hyphens:auto;}\n.css-16qmz35{hyphens:manual;}\n.css-1oys3eu{hyphens:none;}\n.css-kilw6e{overflow-wrap:normal;}\n.css-1wekrze{overflow-wrap:break-word;}\n.css-9x4jlj{overflow-wrap:anywhere;}\n.css-nvzy01{word-wrap:normal;}\n.css-kwpt08{word-wrap:break-word;}\n.css-1q4nm8r{word-wrap:anywhere;}\n.css-1eif5ff{text-align:start;}\n.css-1djk842{text-align:end;}\n.css-13brihr{text-align:left;}\n.css-s2uf1z{text-align:right;}\n.css-xi606m{text-align:center;}\n.css-tpvos8{text-align:justify;}\n.css-1jf8mhn{text-align:match-parent;}\n.css-1in3ksq{text-align:justify-all;}\n.css-ojrn5a{text-align-all:start;}\n.css-10ach4g{text-align-all:end;}\n.css-1hjrnp3{text-align-all:left;}\n.css-7uxe7j{text-align-all:right;}\n.css-q3c0st{text-align-all:center;}\n.css-6d51av{text-align-all:justify;}\n.css-8urne5{text-align-all:match-parent;}\n.css-1bxwb1w{text-align-last:auto;}\n.css-qnaxb4{text-align-last:start;}\n.css-8zt416{text-align-last:end;}\n.css-hu6fl7{text-align-last:left;}\n.css-zmb6fv{text-align-last:right;}\n.css-1ai0fqu{text-align-last:center;}\n.css-trasgv{text-align-last:justify;}\n.css-1oo70fx{text-align-last:match-parent;}\n.css-88qbb2{text-justify:auto;}\n.css-jlbh2m{text-justify:none;}\n.css-11asqlp{text-justify:inter-word;}\n.css-1s1z8sg{text-justify:inter-character;}\n.css-1d6c0xc{word-spacing:50%;}\n.css-1x8miop{text-indent:1em hanging;}\n.css-7sot2l{text-indent:1em each-line;}\n.css-q7r8hy{text-indent:1em hanging each-line;}\n.css-6z3lqv{hanging-punctuation:none;}\n.css-1t0jo68{hanging-punctuation:first;}\n.css-o1534q{hanging-punctuation:last;}\n.css-tu34w2{hanging-punctuation:force-end;}\n.css-m9c78w{hanging-punctuation:allow-end;}\n.css-19qgwj2{hanging-punctuation:first last;}\n.css-yms42f{hanging-punctuation:first force-end;}\n.css-10cfy1{hanging-punctuation:first force-end last;}\n.css-huznai{hanging-punctuation:first allow-end last;}\n.css-1qww0i2{text-wrap:wrap;}\n.css-1g7kd96{text-wrap:nowrap;}\n.css-1lsoged{text-wrap:balance;}\n.css-7rw6iq{text-wrap:stable;}\n.css-e53dgl{text-wrap:pretty;}\n.css-1uwb0wo{text-wrap-mode:wrap;}\n.css-smodyq{text-wrap-mode:nowrap;}\n.css-16ylvfv{text-wrap-style:auto;}\n.css-djejd6{text-wrap-style:balance;}\n.css-gfqii6{text-wrap-style:stable;}\n.css-z764fg{text-wrap-style:pretty;}\n"
  ];
  
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
