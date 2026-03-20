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
    ".css-1btho3a{overscroll-behavior:contain;}\n.css-1dl7j1d{overscroll-behavior:none;}\n.css-15jukkc{overscroll-behavior:auto;}\n.css-1o4xxxe{overscroll-behavior:contain contain;}\n.css-kjypmu{overscroll-behavior:none contain;}\n.css-12vmwul{overscroll-behavior:auto contain;}\n.css-5pbl4h{overscroll-behavior:contain none;}\n.css-1s8anq6{overscroll-behavior:none none;}\n.css-14myhlg{overscroll-behavior:auto none;}\n.css-1j49kl3{overscroll-behavior:contain auto;}\n.css-ioifvx{overscroll-behavior:none auto;}\n.css-13smixw{overscroll-behavior:auto auto;}\n.css-1t5zttn{overscroll-behavior-x:contain;}\n.css-crzrzr{overscroll-behavior-x:none;}\n.css-uhjltw{overscroll-behavior-x:auto;}\n.css-1oysund{overscroll-behavior-y:contain;}\n.css-1n0t8de{overscroll-behavior-y:none;}\n.css-seyb72{overscroll-behavior-y:auto;}\n.css-1vnsm2h{overscroll-behavior-inline:contain;}\n.css-f8iqqo{overscroll-behavior-inline:none;}\n.css-p5kyxi{overscroll-behavior-inline:auto;}\n.css-urqfuu{overscroll-behavior-block:contain;}\n.css-d8iw13{overscroll-behavior-block:none;}\n.css-ylunay{overscroll-behavior-block:auto;}\n"
  ];
  
  CSS.make("css-1btho3a", []);
  CSS.make("css-1dl7j1d", []);
  CSS.make("css-15jukkc", []);
  CSS.make("css-1o4xxxe", []);
  CSS.make("css-kjypmu", []);
  CSS.make("css-12vmwul", []);
  CSS.make("css-5pbl4h", []);
  CSS.make("css-1s8anq6", []);
  CSS.make("css-14myhlg", []);
  CSS.make("css-1j49kl3", []);
  CSS.make("css-ioifvx", []);
  CSS.make("css-13smixw", []);
  CSS.make("css-1t5zttn", []);
  CSS.make("css-crzrzr", []);
  CSS.make("css-uhjltw", []);
  CSS.make("css-1oysund", []);
  CSS.make("css-1n0t8de", []);
  CSS.make("css-seyb72", []);
  CSS.make("css-1vnsm2h", []);
  CSS.make("css-f8iqqo", []);
  CSS.make("css-p5kyxi", []);
  CSS.make("css-urqfuu", []);
  CSS.make("css-d8iw13", []);
  CSS.make("css-ylunay", []);
