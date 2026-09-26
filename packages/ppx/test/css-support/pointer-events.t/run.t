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
  [@css "._a_dh2far{touch-action:auto;}"];
  [@css "._a_dhsbrd{touch-action:none;}"];
  [@css "._a_dhsu0a{touch-action:pan-x;}"];
  [@css "._a_dhcb00{touch-action:pan-y;}"];
  [@css "._a_dhee94{touch-action:pan-x pan-y;}"];
  [@css "._a_dh4v8x{touch-action:manipulation;}"];
  [@css "._a_dht8dp{touch-action:pan-left;}"];
  [@css "._a_dhiuj3{touch-action:pan-right;}"];
  [@css "._a_dhtga0{touch-action:pan-up;}"];
  [@css "._a_dhpx43{touch-action:pan-down;}"];
  [@css "._a_dhn9hg{touch-action:pan-left pan-up;}"];
  [@css "._a_dhgay6{touch-action:pinch-zoom;}"];
  [@css "._a_dhive7{touch-action:pan-x pinch-zoom;}"];
  [@css "._a_dh2qdh{touch-action:pan-y pinch-zoom;}"];
  [@css "._a_dhbds3{touch-action:pan-x pan-y pinch-zoom;}"];
  
  CSS.make("_a_dh2far", []);
  CSS.make("_a_dhsbrd", []);
  CSS.make("_a_dhsu0a", []);
  CSS.make("_a_dhcb00", []);
  CSS.make("_a_dhee94", []);
  CSS.make("_a_dh4v8x", []);
  
  CSS.make("_a_dht8dp", []);
  CSS.make("_a_dhiuj3", []);
  CSS.make("_a_dhtga0", []);
  CSS.make("_a_dhpx43", []);
  CSS.make("_a_dhn9hg", []);
  
  CSS.make("_a_dhgay6", []);
  CSS.make("_a_dhive7", []);
  CSS.make("_a_dh2qdh", []);
  CSS.make("_a_dhbds3", []);
