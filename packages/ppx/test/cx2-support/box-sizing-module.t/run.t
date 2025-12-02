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
    ".css-1u0t4vi { width: max-content; }\n.css-1elg4n7 { width: min-content; }\n.css-f74amn { width: fit-content(10%); }\n.css-1gt6j0n { min-width: max-content; }\n.css-hgsser { min-width: min-content; }\n.css-zc31zg { min-width: fit-content(10%); }\n.css-c745rk { max-width: max-content; }\n.css-1k1q7ha { max-width: min-content; }\n.css-18qqzwe { max-width: fit-content(10%); }\n.css-1wqm2b5 { height: max-content; }\n.css-1m46hxm { height: min-content; }\n.css-ojin7b { height: fit-content(10%); }\n.css-brocr8 { min-height: max-content; }\n.css-1ao9m3z { min-height: min-content; }\n.css-x07hca { min-height: fit-content(10%); }\n.css-1w642pn { max-height: max-content; }\n.css-3f7te3 { max-height: min-content; }\n.css-1ihf71h { max-height: fit-content(10%); }\n.css-gz7x27 { aspect-ratio: auto; }\n.css-kuzivx { aspect-ratio: 2; }\n.css-1hg44ge { aspect-ratio: 16 / 9; }\n.css-sa49tb { width: fit-content; }\n.css-ghg9qx { min-width: fit-content; }\n.css-w3kac2 { max-width: fit-content; }\n.css-sf3f9p { height: fit-content; }\n.css-16igyo { min-height: fit-content; }\n.css-wibc4l { max-height: fit-content; }\n"
  ];
  CSS.make("css-1u0t4vi", []);
  CSS.make("css-1elg4n7", []);
  CSS.make("css-f74amn", []);
  CSS.make("css-1gt6j0n", []);
  CSS.make("css-hgsser", []);
  CSS.make("css-zc31zg", []);
  CSS.make("css-c745rk", []);
  CSS.make("css-1k1q7ha", []);
  CSS.make("css-18qqzwe", []);
  CSS.make("css-1wqm2b5", []);
  CSS.make("css-1m46hxm", []);
  CSS.make("css-ojin7b", []);
  CSS.make("css-brocr8", []);
  CSS.make("css-1ao9m3z", []);
  CSS.make("css-x07hca", []);
  CSS.make("css-1w642pn", []);
  CSS.make("css-3f7te3", []);
  CSS.make("css-1ihf71h", []);
  
  CSS.make("css-gz7x27", []);
  CSS.make("css-kuzivx", []);
  CSS.make("css-1hg44ge", []);
  
  CSS.make("css-sa49tb", []);
  
  CSS.make("css-ghg9qx", []);
  
  CSS.make("css-w3kac2", []);
  
  CSS.make("css-sf3f9p", []);
  
  CSS.make("css-16igyo", []);
  
  CSS.make("css-wibc4l", []);
