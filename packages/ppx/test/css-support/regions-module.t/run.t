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
  [@css ".a-eacf4s{flow-from:none;}"];
  [@css ".a-12dxqeo{flow-from:named-flow;}"];
  [@css ".a-1gnxqr6{flow-into:none;}"];
  [@css ".a-1p2ywcc{flow-into:named-flow;}"];
  [@css ".a-11m8xd9{flow-into:named-flow element;}"];
  [@css ".a-yotzaz{flow-into:named-flow content;}"];
  [@css ".a-u82igy{region-fragment:auto;}"];
  [@css ".a-8r95p4{region-fragment:break;}"];
  
  CSS.make("a-eacf4s", []);
  CSS.make("a-12dxqeo", []);
  CSS.make("a-1gnxqr6", []);
  CSS.make("a-1p2ywcc", []);
  CSS.make("a-11m8xd9", []);
  CSS.make("a-yotzaz", []);
  CSS.make("a-u82igy", []);
  CSS.make("a-8r95p4", []);
