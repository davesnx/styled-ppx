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
    ".css-1bn2far{touch-action:auto;}\n.css-z0sbrd{touch-action:none;}\n.css-rvsu0a{touch-action:pan-x;}\n.css-1gecb00{touch-action:pan-y;}\n.css-11ee94{touch-action:pan-x pan-y;}\n.css-1cw4v8x{touch-action:manipulation;}\n.css-1alt8dp{touch-action:pan-left;}\n.css-1u0iuj3{touch-action:pan-right;}\n.css-54tga0{touch-action:pan-up;}\n.css-7apx43{touch-action:pan-down;}\n.css-1in9hg{touch-action:pan-left pan-up;}\n.css-10ugay6{touch-action:pinch-zoom;}\n.css-1gnive7{touch-action:pan-x pinch-zoom;}\n.css-1sg2qdh{touch-action:pan-y pinch-zoom;}\n.css-12jbds3{touch-action:pan-x pan-y pinch-zoom;}\n"
  ];
  
  CSS.make("css-1bn2far", []);
  CSS.make("css-z0sbrd", []);
  CSS.make("css-rvsu0a", []);
  CSS.make("css-1gecb00", []);
  CSS.make("css-11ee94", []);
  CSS.make("css-1cw4v8x", []);
  
  CSS.make("css-1alt8dp", []);
  CSS.make("css-1u0iuj3", []);
  CSS.make("css-54tga0", []);
  CSS.make("css-7apx43", []);
  CSS.make("css-1in9hg", []);
  
  CSS.make("css-10ugay6", []);
  CSS.make("css-1gnive7", []);
  CSS.make("css-1sg2qdh", []);
  CSS.make("css-12jbds3", []);
