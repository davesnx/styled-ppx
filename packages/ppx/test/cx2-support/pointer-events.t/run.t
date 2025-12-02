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
    ".css-3tw08n { touch-action: auto; }\n.css-2n5rpj { touch-action: none; }\n.css-1kh2ysa { touch-action: pan-x; }\n.css-1lf76sj { touch-action: pan-y; }\n.css-14sq7ic { touch-action: pan-x pan-y; }\n.css-1yg38p7 { touch-action: manipulation; }\n.css-tt0e6t { touch-action: pan-left; }\n.css-goejte { touch-action: pan-right; }\n.css-jjqq6u { touch-action: pan-up; }\n.css-boiuh0 { touch-action: pan-down; }\n.css-1dn01vx { touch-action: pan-left pan-up; }\n.css-16vshod { touch-action: pinch-zoom; }\n.css-17rss87 { touch-action: pan-x pinch-zoom; }\n.css-e2c6qf { touch-action: pan-y pinch-zoom; }\n.css-9le9p3 { touch-action: pan-x pan-y pinch-zoom; }\n"
  ];
  CSS.make("css-3tw08n", []);
  CSS.make("css-2n5rpj", []);
  CSS.make("css-1kh2ysa", []);
  CSS.make("css-1lf76sj", []);
  CSS.make("css-14sq7ic", []);
  CSS.make("css-1yg38p7", []);
  
  CSS.make("css-tt0e6t", []);
  CSS.make("css-goejte", []);
  CSS.make("css-jjqq6u", []);
  CSS.make("css-boiuh0", []);
  CSS.make("css-1dn01vx", []);
  
  CSS.make("css-16vshod", []);
  CSS.make("css-17rss87", []);
  CSS.make("css-e2c6qf", []);
  CSS.make("css-9le9p3", []);
