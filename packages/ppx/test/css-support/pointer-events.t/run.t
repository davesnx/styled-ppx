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
  [@css ".css-1bn2far{touch-action:auto;}"];
  [@css ".css-z0sbrd{touch-action:none;}"];
  [@css ".css-rvsu0a{touch-action:pan-x;}"];
  [@css ".css-1gecb00{touch-action:pan-y;}"];
  [@css ".css-11ee94{touch-action:pan-x pan-y;}"];
  [@css ".css-1cw4v8x{touch-action:manipulation;}"];
  [@css ".css-1alt8dp{touch-action:pan-left;}"];
  [@css ".css-1u0iuj3{touch-action:pan-right;}"];
  [@css ".css-54tga0{touch-action:pan-up;}"];
  [@css ".css-7apx43{touch-action:pan-down;}"];
  [@css ".css-1in9hg{touch-action:pan-left pan-up;}"];
  [@css ".css-10ugay6{touch-action:pinch-zoom;}"];
  [@css ".css-1gnive7{touch-action:pan-x pinch-zoom;}"];
  [@css ".css-1sg2qdh{touch-action:pan-y pinch-zoom;}"];
  [@css ".css-12jbds3{touch-action:pan-x pan-y pinch-zoom;}"];
  
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
