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
  [@css "._a_8zho3a{overscroll-behavior:contain;}"];
  [@css "._a_8z7j1d{overscroll-behavior:none;}"];
  [@css "._a_8zukkc{overscroll-behavior:auto;}"];
  [@css "._a_8zxxxe{overscroll-behavior:contain contain;}"];
  [@css "._a_8zypmu{overscroll-behavior:none contain;}"];
  [@css "._a_8zmwul{overscroll-behavior:auto contain;}"];
  [@css "._a_8zbl4h{overscroll-behavior:contain none;}"];
  [@css "._a_8zanq6{overscroll-behavior:none none;}"];
  [@css "._a_8zyhlg{overscroll-behavior:auto none;}"];
  [@css "._a_8z9kl3{overscroll-behavior:contain auto;}"];
  [@css "._a_8zifvx{overscroll-behavior:none auto;}"];
  [@css "._a_8zmixw{overscroll-behavior:auto auto;}"];
  [@css "._a_92zttn{overscroll-behavior-x:contain;}"];
  [@css "._a_92zrzr{overscroll-behavior-x:none;}"];
  [@css "._a_92jltw{overscroll-behavior-x:auto;}"];
  [@css "._a_93sund{overscroll-behavior-y:contain;}"];
  [@css "._a_93t8de{overscroll-behavior-y:none;}"];
  [@css "._a_93yb72{overscroll-behavior-y:auto;}"];
  [@css "._a_91sm2h{overscroll-behavior-inline:contain;}"];
  [@css "._a_91iqqo{overscroll-behavior-inline:none;}"];
  [@css "._a_91kyxi{overscroll-behavior-inline:auto;}"];
  [@css "._a_90qfuu{overscroll-behavior-block:contain;}"];
  [@css "._a_90iw13{overscroll-behavior-block:none;}"];
  [@css "._a_90unay{overscroll-behavior-block:auto;}"];
  
  CSS.make("_a_8zho3a", []);
  CSS.make("_a_8z7j1d", []);
  CSS.make("_a_8zukkc", []);
  CSS.make("_a_8zxxxe", []);
  CSS.make("_a_8zypmu", []);
  CSS.make("_a_8zmwul", []);
  CSS.make("_a_8zbl4h", []);
  CSS.make("_a_8zanq6", []);
  CSS.make("_a_8zyhlg", []);
  CSS.make("_a_8z9kl3", []);
  CSS.make("_a_8zifvx", []);
  CSS.make("_a_8zmixw", []);
  CSS.make("_a_92zttn", []);
  CSS.make("_a_92zrzr", []);
  CSS.make("_a_92jltw", []);
  CSS.make("_a_93sund", []);
  CSS.make("_a_93t8de", []);
  CSS.make("_a_93yb72", []);
  CSS.make("_a_91sm2h", []);
  CSS.make("_a_91iqqo", []);
  CSS.make("_a_91kyxi", []);
  CSS.make("_a_90qfuu", []);
  CSS.make("_a_90iw13", []);
  CSS.make("_a_90unay", []);
