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
  [@css ".a-5r3gy9{display:ruby;}"];
  [@css ".a-5rb5b1{display:ruby-base;}"];
  [@css ".a-5riprk{display:ruby-text;}"];
  [@css ".a-5rp41v{display:ruby-base-container;}"];
  [@css ".a-5rjuuf{display:ruby-text-container;}"];
  
  CSS.make("a-5r3gy9", []);
  CSS.make("a-5rb5b1", []);
  CSS.make("a-5riprk", []);
  CSS.make("a-5rp41v", []);
  CSS.make("a-5rjuuf", []);
