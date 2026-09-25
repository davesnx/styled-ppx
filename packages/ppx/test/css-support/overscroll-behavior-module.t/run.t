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
  [@css ".a-8zho3a{overscroll-behavior:contain;}"];
  [@css ".a-8z7j1d{overscroll-behavior:none;}"];
  [@css ".a-8zukkc{overscroll-behavior:auto;}"];
  [@css ".a-8zxxxe{overscroll-behavior:contain contain;}"];
  [@css ".a-8zypmu{overscroll-behavior:none contain;}"];
  [@css ".a-8zmwul{overscroll-behavior:auto contain;}"];
  [@css ".a-8zbl4h{overscroll-behavior:contain none;}"];
  [@css ".a-8zanq6{overscroll-behavior:none none;}"];
  [@css ".a-8zyhlg{overscroll-behavior:auto none;}"];
  [@css ".a-8z9kl3{overscroll-behavior:contain auto;}"];
  [@css ".a-8zifvx{overscroll-behavior:none auto;}"];
  [@css ".a-8zmixw{overscroll-behavior:auto auto;}"];
  [@css ".a-92zttn{overscroll-behavior-x:contain;}"];
  [@css ".a-92zrzr{overscroll-behavior-x:none;}"];
  [@css ".a-92jltw{overscroll-behavior-x:auto;}"];
  [@css ".a-93sund{overscroll-behavior-y:contain;}"];
  [@css ".a-93t8de{overscroll-behavior-y:none;}"];
  [@css ".a-93yb72{overscroll-behavior-y:auto;}"];
  [@css ".a-91sm2h{overscroll-behavior-inline:contain;}"];
  [@css ".a-91iqqo{overscroll-behavior-inline:none;}"];
  [@css ".a-91kyxi{overscroll-behavior-inline:auto;}"];
  [@css ".a-90qfuu{overscroll-behavior-block:contain;}"];
  [@css ".a-90iw13{overscroll-behavior-block:none;}"];
  [@css ".a-90unay{overscroll-behavior-block:auto;}"];
  
  CSS.make("a-8zho3a", []);
  CSS.make("a-8z7j1d", []);
  CSS.make("a-8zukkc", []);
  CSS.make("a-8zxxxe", []);
  CSS.make("a-8zypmu", []);
  CSS.make("a-8zmwul", []);
  CSS.make("a-8zbl4h", []);
  CSS.make("a-8zanq6", []);
  CSS.make("a-8zyhlg", []);
  CSS.make("a-8z9kl3", []);
  CSS.make("a-8zifvx", []);
  CSS.make("a-8zmixw", []);
  CSS.make("a-92zttn", []);
  CSS.make("a-92zrzr", []);
  CSS.make("a-92jltw", []);
  CSS.make("a-93sund", []);
  CSS.make("a-93t8de", []);
  CSS.make("a-93yb72", []);
  CSS.make("a-91sm2h", []);
  CSS.make("a-91iqqo", []);
  CSS.make("a-91kyxi", []);
  CSS.make("a-90qfuu", []);
  CSS.make("a-90iw13", []);
  CSS.make("a-90unay", []);
