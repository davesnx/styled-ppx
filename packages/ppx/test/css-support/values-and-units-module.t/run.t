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
  [@css "._a_ecmhzu{width:5rem;}"];
  [@css "._a_ecmtw2{width:5ch;}"];
  [@css "._a_ecqw8v{width:5vw;}"];
  [@css "._a_ecjpn0{width:5vh;}"];
  [@css "._a_ecyuy0{width:5vmin;}"];
  [@css "._a_ecjkyq{width:5vmax;}"];
  [@css "._a_ecqvys{width:calc(1px + 2px);}"];
  [@css "._a_ecfuw8{width:calc(5px * 2);}"];
  [@css "._a_ec3oae{width:calc(5px - 10px);}"];
  [@css "._a_ecodca{width:calc(1vw - 1px);}"];
  [@css "._a_ectqhb{width:100%;}"];
  [@css "._a_941t7g{padding:5rem;}"];
  [@css "._a_948q7f{padding:5ch;}"];
  [@css "._a_94w8ry{padding:5vw;}"];
  [@css "._a_94vl0f{padding:5vh;}"];
  [@css "._a_94nbv5{padding:5vmin;}"];
  [@css "._a_94tnlf{padding:5vmax;}"];
  
  CSS.make("_a_ecmhzu", []);
  CSS.make("_a_ecmtw2", []);
  CSS.make("_a_ecqw8v", []);
  CSS.make("_a_ecjpn0", []);
  CSS.make("_a_ecyuy0", []);
  CSS.make("_a_ecjkyq", []);
  CSS.make("_a_ecqvys", []);
  CSS.make("_a_ecfuw8", []);
  CSS.make("_a_ecfuw8", []);
  CSS.make("_a_ec3oae", []);
  CSS.make("_a_ecodca", []);
  CSS.make("_a_ectqhb", []);
  CSS.make("_a_941t7g", []);
  CSS.make("_a_948q7f", []);
  CSS.make("_a_94w8ry", []);
  CSS.make("_a_94vl0f", []);
  CSS.make("_a_94nbv5", []);
  CSS.make("_a_94tnlf", []);

