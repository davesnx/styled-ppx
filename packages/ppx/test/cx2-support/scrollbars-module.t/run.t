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
    ".css-1l9f62p { scrollbar-color: auto; }\n.css-113vvmz { scrollbar-color: red blue; }\n.css-1161gxd { scrollbar-width: auto; }\n.css-1od5psd { scrollbar-width: thin; }\n.css-1u2ddff { scrollbar-width: none; }\n"
  ];
  CSS.make("css-1l9f62p", []);
  CSS.make("css-113vvmz", []);
  CSS.make("css-1161gxd", []);
  CSS.make("css-1od5psd", []);
  CSS.make("css-1u2ddff", []);
