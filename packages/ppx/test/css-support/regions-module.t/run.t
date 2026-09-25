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
  [@css ".css-eacf4s{flow-from:none;}"];
  [@css ".css-12dxqeo{flow-from:named-flow;}"];
  [@css ".css-1gnxqr6{flow-into:none;}"];
  [@css ".css-1p2ywcc{flow-into:named-flow;}"];
  [@css ".css-11m8xd9{flow-into:named-flow element;}"];
  [@css ".css-yotzaz{flow-into:named-flow content;}"];
  [@css ".css-u82igy{region-fragment:auto;}"];
  [@css ".css-8r95p4{region-fragment:break;}"];
  
  CSS.make("css-eacf4s", []);
  CSS.make("css-12dxqeo", []);
  CSS.make("css-1gnxqr6", []);
  CSS.make("css-1p2ywcc", []);
  CSS.make("css-11m8xd9", []);
  CSS.make("css-yotzaz", []);
  CSS.make("css-u82igy", []);
  CSS.make("css-8r95p4", []);
