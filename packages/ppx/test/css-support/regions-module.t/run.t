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
  [@css "._a_ftcf4s{flow-from:none;}"];
  [@css "._a_ftxqeo{flow-from:named-flow;}"];
  [@css "._a_fuxqr6{flow-into:none;}"];
  [@css "._a_fuywcc{flow-into:named-flow;}"];
  [@css "._a_fu8xd9{flow-into:named-flow element;}"];
  [@css "._a_futzaz{flow-into:named-flow content;}"];
  [@css "._a_gc2igy{region-fragment:auto;}"];
  [@css "._a_gc95p4{region-fragment:break;}"];
  
  CSS.make("_a_ftcf4s", []);
  CSS.make("_a_ftxqeo", []);
  CSS.make("_a_fuxqr6", []);
  CSS.make("_a_fuywcc", []);
  CSS.make("_a_fu8xd9", []);
  CSS.make("_a_futzaz", []);
  CSS.make("_a_gc2igy", []);
  CSS.make("_a_gc95p4", []);
