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
    ".css-9y6172{user-select:none;}\n.css-1gs5e0q:nth-last-child(1){stroke-opacity:0;}\n.css-1fqvgu0 .recharts-scatter .recharts-scatter-symbol .recharts-symbols{opacity:0.8;}\n.css-vv2q96:hover{opacity:1;}\n"
  ];
  
  let _chart =
    CSS.make("css-9y6172 css-1gs5e0q css-1gs5e0q css-1fqvgu0 css-vv2q96", []);
