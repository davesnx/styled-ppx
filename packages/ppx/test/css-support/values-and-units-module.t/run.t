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
  [@css ".a-ecmhzu{width:5rem;}"];
  [@css ".a-ecmtw2{width:5ch;}"];
  [@css ".a-ecqw8v{width:5vw;}"];
  [@css ".a-ecjpn0{width:5vh;}"];
  [@css ".a-ecyuy0{width:5vmin;}"];
  [@css ".a-ecjkyq{width:5vmax;}"];
  [@css ".a-ecqvys{width:calc(1px + 2px);}"];
  [@css ".a-ecfuw8{width:calc(5px * 2);}"];
  [@css ".a-ec3oae{width:calc(5px - 10px);}"];
  [@css ".a-ecodca{width:calc(1vw - 1px);}"];
  [@css ".a-ectqhb{width:100%;}"];
  [@css ".a-941t7g{padding:5rem;}"];
  [@css ".a-948q7f{padding:5ch;}"];
  [@css ".a-94w8ry{padding:5vw;}"];
  [@css ".a-94vl0f{padding:5vh;}"];
  [@css ".a-94nbv5{padding:5vmin;}"];
  [@css ".a-94tnlf{padding:5vmax;}"];
  
  CSS.make("a-ecmhzu", []);
  CSS.make("a-ecmtw2", []);
  CSS.make("a-ecqw8v", []);
  CSS.make("a-ecjpn0", []);
  CSS.make("a-ecyuy0", []);
  CSS.make("a-ecjkyq", []);
  CSS.make("a-ecqvys", []);
  CSS.make("a-ecfuw8", []);
  CSS.make("a-ecfuw8", []);
  CSS.make("a-ec3oae", []);
  CSS.make("a-ecodca", []);
  CSS.make("a-ectqhb", []);
  CSS.make("a-941t7g", []);
  CSS.make("a-948q7f", []);
  CSS.make("a-94w8ry", []);
  CSS.make("a-94vl0f", []);
  CSS.make("a-94nbv5", []);
  CSS.make("a-94tnlf", []);

