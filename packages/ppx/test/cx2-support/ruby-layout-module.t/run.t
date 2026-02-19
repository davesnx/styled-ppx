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
  [@css
    ".css-1g93gy9{display:ruby;}\n.css-1jsb5b1{display:ruby-base;}\n.css-7miprk{display:ruby-text;}\n.css-5ep41v{display:ruby-base-container;}\n.css-o1juuf{display:ruby-text-container;}\n"
  ];
  
  CSS.make("css-1g93gy9", []);
  CSS.make("css-1jsb5b1", []);
  CSS.make("css-7miprk", []);
  CSS.make("css-5ep41v", []);
  CSS.make("css-o1juuf", []);
