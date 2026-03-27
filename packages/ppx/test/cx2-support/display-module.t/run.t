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
    ".css-1153jk8{display:run-in;}\n.css-lmlerk{display:flow;}\n.css-1jnposs{display:flow-root;}\n"
  ];
  
  CSS.make("css-1153jk8", []);
  CSS.make("css-lmlerk", []);
  CSS.make("css-1jnposs", []);
