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
  [@css ".css-1btho3a{overscroll-behavior:contain;}"];
  [@css ".css-1dl7j1d{overscroll-behavior:none;}"];
  [@css ".css-15jukkc{overscroll-behavior:auto;}"];
  [@css ".css-1o4xxxe{overscroll-behavior:contain contain;}"];
  [@css ".css-kjypmu{overscroll-behavior:none contain;}"];
  [@css ".css-12vmwul{overscroll-behavior:auto contain;}"];
  [@css ".css-5pbl4h{overscroll-behavior:contain none;}"];
  [@css ".css-1s8anq6{overscroll-behavior:none none;}"];
  [@css ".css-14myhlg{overscroll-behavior:auto none;}"];
  [@css ".css-1j49kl3{overscroll-behavior:contain auto;}"];
  [@css ".css-ioifvx{overscroll-behavior:none auto;}"];
  [@css ".css-13smixw{overscroll-behavior:auto auto;}"];
  [@css ".css-1t5zttn{overscroll-behavior-x:contain;}"];
  [@css ".css-crzrzr{overscroll-behavior-x:none;}"];
  [@css ".css-uhjltw{overscroll-behavior-x:auto;}"];
  [@css ".css-1oysund{overscroll-behavior-y:contain;}"];
  [@css ".css-1n0t8de{overscroll-behavior-y:none;}"];
  [@css ".css-seyb72{overscroll-behavior-y:auto;}"];
  [@css ".css-1vnsm2h{overscroll-behavior-inline:contain;}"];
  [@css ".css-f8iqqo{overscroll-behavior-inline:none;}"];
  [@css ".css-p5kyxi{overscroll-behavior-inline:auto;}"];
  [@css ".css-urqfuu{overscroll-behavior-block:contain;}"];
  [@css ".css-d8iw13{overscroll-behavior-block:none;}"];
  [@css ".css-ylunay{overscroll-behavior-block:auto;}"];
  
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
