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
    ".css-b0womj { line-clamp: none; }\n.css-1fs27kc { line-clamp: 1; }\n.css-1jxin0x { max-lines: none; }\n.css-lw7o5r { max-lines: 1; }\n.css-1no2p0s { overflow-x: visible; }\n.css-c01ve6 { overflow-x: hidden; }\n.css-i8v8da { overflow-x: clip; }\n.css-98edpd { overflow-x: scroll; }\n.css-10mly6l { overflow-x: auto; }\n.css-myufzg { overflow-y: visible; }\n.css-co2qb2 { overflow-y: hidden; }\n.css-vhc2cb { overflow-y: clip; }\n.css-dy5muu { overflow-y: scroll; }\n.css-1xbs9vq { overflow-y: auto; }\n.css-1970jkd { overflow-inline: visible; }\n.css-6u13g2 { overflow-inline: hidden; }\n.css-28mpw3 { overflow-inline: clip; }\n.css-mfvacj { overflow-inline: scroll; }\n.css-13oaqjh { overflow-inline: auto; }\n.css-12uvune { overflow-block: visible; }\n.css-16ut36 { overflow-block: hidden; }\n.css-wgeo5a { overflow-block: clip; }\n.css-1kh54cv { overflow-block: scroll; }\n.css-u3vuyu { overflow-block: auto; }\n.css-1ygdyr7 { scrollbar-gutter: auto; }\n.css-3q2bs4 { scrollbar-gutter: stable; }\n.css-1avw8l4 { scrollbar-gutter: both-edges stable; }\n.css-1xrd7cj { scrollbar-gutter: stable both-edges; }\n.css-rjyqmg { overflow-clip-margin: content-box; }\n.css-o9sv0s { overflow-clip-margin: padding-box; }\n.css-160a8xd { overflow-clip-margin: border-box; }\n.css-vjwyqg { overflow-clip-margin: 20px; }\n.css-65a9ms { overflow-clip-margin: 1em; }\n.css-14ndtzh { overflow-clip-margin: content-box 5px; }\n.css-1ua8zc5 { overflow-clip-margin: 5px content-box; }\n"
  ];
  CSS.make("css-b0womj", []);
  CSS.make("css-1fs27kc", []);
  
  CSS.make("css-1jxin0x", []);
  CSS.make("css-lw7o5r", []);
  CSS.make("css-1no2p0s", []);
  CSS.make("css-c01ve6", []);
  CSS.make("css-i8v8da", []);
  CSS.make("css-98edpd", []);
  CSS.make("css-10mly6l", []);
  CSS.make("css-myufzg", []);
  CSS.make("css-co2qb2", []);
  CSS.make("css-vhc2cb", []);
  CSS.make("css-dy5muu", []);
  CSS.make("css-1xbs9vq", []);
  CSS.make("css-1970jkd", []);
  CSS.make("css-6u13g2", []);
  CSS.make("css-28mpw3", []);
  CSS.make("css-mfvacj", []);
  CSS.make("css-13oaqjh", []);
  CSS.make("css-12uvune", []);
  CSS.make("css-16ut36", []);
  CSS.make("css-wgeo5a", []);
  CSS.make("css-1kh54cv", []);
  CSS.make("css-u3vuyu", []);
  CSS.make("css-1ygdyr7", []);
  CSS.make("css-3q2bs4", []);
  CSS.make("css-1avw8l4", []);
  CSS.make("css-1xrd7cj", []);
  CSS.make("css-rjyqmg", []);
  CSS.make("css-o9sv0s", []);
  CSS.make("css-160a8xd", []);
  CSS.make("css-vjwyqg", []);
  CSS.make("css-65a9ms", []);
  CSS.make("css-14ndtzh", []);
  CSS.make("css-1ua8zc5", []);
