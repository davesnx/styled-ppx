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
  [@css ".a-1g93gy9{display:ruby;}"];
  [@css ".a-1jsb5b1{display:ruby-base;}"];
  [@css ".a-7miprk{display:ruby-text;}"];
  [@css ".a-5ep41v{display:ruby-base-container;}"];
  [@css ".a-o1juuf{display:ruby-text-container;}"];
  
  CSS.make("a-1g93gy9", []);
  CSS.make("a-1jsb5b1", []);
  CSS.make("a-7miprk", []);
  CSS.make("a-5ep41v", []);
  CSS.make("a-o1juuf", []);
