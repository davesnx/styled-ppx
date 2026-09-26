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
  [@css "._a_5r3gy9{display:ruby;}"];
  [@css "._a_5rb5b1{display:ruby-base;}"];
  [@css "._a_5riprk{display:ruby-text;}"];
  [@css "._a_5rp41v{display:ruby-base-container;}"];
  [@css "._a_5rjuuf{display:ruby-text-container;}"];
  
  CSS.make("_a_5r3gy9", []);
  CSS.make("_a_5rb5b1", []);
  CSS.make("_a_5riprk", []);
  CSS.make("_a_5rp41v", []);
  CSS.make("_a_5rjuuf", []);
