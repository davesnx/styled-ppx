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
  [@css ".a-1btho3a{overscroll-behavior:contain;}"];
  [@css ".a-1dl7j1d{overscroll-behavior:none;}"];
  [@css ".a-15jukkc{overscroll-behavior:auto;}"];
  [@css ".a-1o4xxxe{overscroll-behavior:contain contain;}"];
  [@css ".a-kjypmu{overscroll-behavior:none contain;}"];
  [@css ".a-12vmwul{overscroll-behavior:auto contain;}"];
  [@css ".a-5pbl4h{overscroll-behavior:contain none;}"];
  [@css ".a-1s8anq6{overscroll-behavior:none none;}"];
  [@css ".a-14myhlg{overscroll-behavior:auto none;}"];
  [@css ".a-1j49kl3{overscroll-behavior:contain auto;}"];
  [@css ".a-ioifvx{overscroll-behavior:none auto;}"];
  [@css ".a-13smixw{overscroll-behavior:auto auto;}"];
  [@css ".a-1t5zttn{overscroll-behavior-x:contain;}"];
  [@css ".a-crzrzr{overscroll-behavior-x:none;}"];
  [@css ".a-uhjltw{overscroll-behavior-x:auto;}"];
  [@css ".a-1oysund{overscroll-behavior-y:contain;}"];
  [@css ".a-1n0t8de{overscroll-behavior-y:none;}"];
  [@css ".a-seyb72{overscroll-behavior-y:auto;}"];
  [@css ".a-1vnsm2h{overscroll-behavior-inline:contain;}"];
  [@css ".a-f8iqqo{overscroll-behavior-inline:none;}"];
  [@css ".a-p5kyxi{overscroll-behavior-inline:auto;}"];
  [@css ".a-urqfuu{overscroll-behavior-block:contain;}"];
  [@css ".a-d8iw13{overscroll-behavior-block:none;}"];
  [@css ".a-ylunay{overscroll-behavior-block:auto;}"];
  
  CSS.make("a-1btho3a", []);
  CSS.make("a-1dl7j1d", []);
  CSS.make("a-15jukkc", []);
  CSS.make("a-1o4xxxe", []);
  CSS.make("a-kjypmu", []);
  CSS.make("a-12vmwul", []);
  CSS.make("a-5pbl4h", []);
  CSS.make("a-1s8anq6", []);
  CSS.make("a-14myhlg", []);
  CSS.make("a-1j49kl3", []);
  CSS.make("a-ioifvx", []);
  CSS.make("a-13smixw", []);
  CSS.make("a-1t5zttn", []);
  CSS.make("a-crzrzr", []);
  CSS.make("a-uhjltw", []);
  CSS.make("a-1oysund", []);
  CSS.make("a-1n0t8de", []);
  CSS.make("a-seyb72", []);
  CSS.make("a-1vnsm2h", []);
  CSS.make("a-f8iqqo", []);
  CSS.make("a-p5kyxi", []);
  CSS.make("a-urqfuu", []);
  CSS.make("a-d8iw13", []);
  CSS.make("a-ylunay", []);
