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
    ".css-ndsipr { break-before: auto; }\n.css-djyiyg { break-before: avoid; }\n.css-1hqckqd { break-before: avoid-page; }\n.css-do48zc { break-before: page; }\n.css-1iu9p4d { break-before: left; }\n.css-1x4nkdg { break-before: right; }\n.css-13p6onj { break-before: recto; }\n.css-e0z3ap { break-before: verso; }\n.css-1qmtz18 { break-before: avoid-column; }\n.css-18v94rz { break-before: column; }\n.css-kgk3vh { break-before: avoid-region; }\n.css-pi6dgt { break-before: region; }\n.css-1n75zbf { break-after: auto; }\n.css-1sv08l3 { break-after: avoid; }\n.css-nu2yhy { break-after: avoid-page; }\n.css-gcosr3 { break-after: page; }\n.css-1ls213 { break-after: left; }\n.css-1b1y2er { break-after: right; }\n.css-fxyq61 { break-after: recto; }\n.css-ysevv7 { break-after: verso; }\n.css-4yrp6c { break-after: avoid-column; }\n.css-yjgp3 { break-after: column; }\n.css-1qs8xt { break-after: avoid-region; }\n.css-nhf9wo { break-after: region; }\n.css-x1n0ac { break-inside: auto; }\n.css-109tu3w { break-inside: avoid; }\n.css-xwnraj { break-inside: avoid-page; }\n.css-32k04q { break-inside: avoid-column; }\n.css-13wwaxq { break-inside: avoid-region; }\n.css-m9fwr5 { box-decoration-break: slice; }\n.css-16bylm5 { box-decoration-break: clone; }\n.css-cxmfbk { orphans: 1; }\n.css-1psaeje { orphans: 2; }\n.css-1jqrs1t { widows: 1; }\n.css-10j7fbh { widows: 2; }\n"
  ];
  CSS.make("css-ndsipr", []);
  CSS.make("css-djyiyg", []);
  CSS.make("css-1hqckqd", []);
  CSS.make("css-do48zc", []);
  CSS.make("css-1iu9p4d", []);
  CSS.make("css-1x4nkdg", []);
  CSS.make("css-13p6onj", []);
  CSS.make("css-e0z3ap", []);
  CSS.make("css-1qmtz18", []);
  CSS.make("css-18v94rz", []);
  CSS.make("css-kgk3vh", []);
  CSS.make("css-pi6dgt", []);
  CSS.make("css-1n75zbf", []);
  CSS.make("css-1sv08l3", []);
  CSS.make("css-nu2yhy", []);
  CSS.make("css-gcosr3", []);
  CSS.make("css-1ls213", []);
  CSS.make("css-1b1y2er", []);
  CSS.make("css-fxyq61", []);
  CSS.make("css-ysevv7", []);
  CSS.make("css-4yrp6c", []);
  CSS.make("css-yjgp3", []);
  CSS.make("css-1qs8xt", []);
  CSS.make("css-nhf9wo", []);
  CSS.make("css-x1n0ac", []);
  CSS.make("css-109tu3w", []);
  CSS.make("css-xwnraj", []);
  CSS.make("css-32k04q", []);
  CSS.make("css-13wwaxq", []);
  CSS.make("css-m9fwr5", []);
  CSS.make("css-16bylm5", []);
  CSS.make("css-cxmfbk", []);
  CSS.make("css-1psaeje", []);
  
  CSS.make("css-1jqrs1t", []);
  CSS.make("css-10j7fbh", []);
