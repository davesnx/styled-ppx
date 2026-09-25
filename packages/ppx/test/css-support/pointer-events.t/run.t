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
  [@css ".a-dh2far{touch-action:auto;}"];
  [@css ".a-dhsbrd{touch-action:none;}"];
  [@css ".a-dhsu0a{touch-action:pan-x;}"];
  [@css ".a-dhcb00{touch-action:pan-y;}"];
  [@css ".a-dhee94{touch-action:pan-x pan-y;}"];
  [@css ".a-dh4v8x{touch-action:manipulation;}"];
  [@css ".a-dht8dp{touch-action:pan-left;}"];
  [@css ".a-dhiuj3{touch-action:pan-right;}"];
  [@css ".a-dhtga0{touch-action:pan-up;}"];
  [@css ".a-dhpx43{touch-action:pan-down;}"];
  [@css ".a-dhn9hg{touch-action:pan-left pan-up;}"];
  [@css ".a-dhgay6{touch-action:pinch-zoom;}"];
  [@css ".a-dhive7{touch-action:pan-x pinch-zoom;}"];
  [@css ".a-dh2qdh{touch-action:pan-y pinch-zoom;}"];
  [@css ".a-dhbds3{touch-action:pan-x pan-y pinch-zoom;}"];
  
  CSS.make("a-dh2far", []);
  CSS.make("a-dhsbrd", []);
  CSS.make("a-dhsu0a", []);
  CSS.make("a-dhcb00", []);
  CSS.make("a-dhee94", []);
  CSS.make("a-dh4v8x", []);
  
  CSS.make("a-dht8dp", []);
  CSS.make("a-dhiuj3", []);
  CSS.make("a-dhtga0", []);
  CSS.make("a-dhpx43", []);
  CSS.make("a-dhn9hg", []);
  
  CSS.make("a-dhgay6", []);
  CSS.make("a-dhive7", []);
  CSS.make("a-dh2qdh", []);
  CSS.make("a-dhbds3", []);
