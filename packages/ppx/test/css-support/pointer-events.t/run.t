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
  [@css ".a-1bn2far{touch-action:auto;}"];
  [@css ".a-z0sbrd{touch-action:none;}"];
  [@css ".a-rvsu0a{touch-action:pan-x;}"];
  [@css ".a-1gecb00{touch-action:pan-y;}"];
  [@css ".a-11ee94{touch-action:pan-x pan-y;}"];
  [@css ".a-1cw4v8x{touch-action:manipulation;}"];
  [@css ".a-1alt8dp{touch-action:pan-left;}"];
  [@css ".a-1u0iuj3{touch-action:pan-right;}"];
  [@css ".a-54tga0{touch-action:pan-up;}"];
  [@css ".a-7apx43{touch-action:pan-down;}"];
  [@css ".a-1in9hg{touch-action:pan-left pan-up;}"];
  [@css ".a-10ugay6{touch-action:pinch-zoom;}"];
  [@css ".a-1gnive7{touch-action:pan-x pinch-zoom;}"];
  [@css ".a-1sg2qdh{touch-action:pan-y pinch-zoom;}"];
  [@css ".a-12jbds3{touch-action:pan-x pan-y pinch-zoom;}"];
  
  CSS.make("a-1bn2far", []);
  CSS.make("a-z0sbrd", []);
  CSS.make("a-rvsu0a", []);
  CSS.make("a-1gecb00", []);
  CSS.make("a-11ee94", []);
  CSS.make("a-1cw4v8x", []);
  
  CSS.make("a-1alt8dp", []);
  CSS.make("a-1u0iuj3", []);
  CSS.make("a-54tga0", []);
  CSS.make("a-7apx43", []);
  CSS.make("a-1in9hg", []);
  
  CSS.make("a-10ugay6", []);
  CSS.make("a-1gnive7", []);
  CSS.make("a-1sg2qdh", []);
  CSS.make("a-12jbds3", []);
