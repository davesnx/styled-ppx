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
  [@css "._a_fucf4s{flow-from:none;}"];
  [@css "._a_fuxqeo{flow-from:named-flow;}"];
  [@css "._a_fvxqr6{flow-into:none;}"];
  [@css "._a_fvywcc{flow-into:named-flow;}"];
  [@css "._a_fv8xd9{flow-into:named-flow element;}"];
  [@css "._a_fvtzaz{flow-into:named-flow content;}"];
  [@css "._a_gd2igy{region-fragment:auto;}"];
  [@css "._a_gd95p4{region-fragment:break;}"];
  
  CSS.make("_a_fucf4s", []);
  CSS.make("_a_fuxqeo", []);
  CSS.make("_a_fvxqr6", []);
  CSS.make("_a_fvywcc", []);
  CSS.make("_a_fv8xd9", []);
  CSS.make("_a_fvtzaz", []);
  CSS.make("_a_gd2igy", []);
  CSS.make("_a_gd95p4", []);
