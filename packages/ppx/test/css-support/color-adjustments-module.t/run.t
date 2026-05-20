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
  
  CSS.colorAdjust(`economy);
  CSS.colorAdjust(`exact);
  CSS.forcedColorAdjust(`auto);
  CSS.forcedColorAdjust(`none);
  CSS.forcedColorAdjust(`preserveParentColor);
  CSS.colorScheme(`value({js|normal|js}));
  CSS.colorScheme(`light);
  CSS.colorScheme(`dark);
  CSS.colorScheme(`value({js|light dark|js}));
  CSS.colorScheme(`value({js|dark light|js}));
  CSS.colorScheme(`value({js|only light|js}));
  CSS.colorScheme(`value({js|light only|js}));
  CSS.colorScheme(`value({js|light light|js}));
  CSS.colorScheme(`value({js|dark dark|js}));
  CSS.colorScheme(`value({js|light purple|js}));
  CSS.colorScheme(`value({js|purple dark interesting|js}));
  CSS.colorScheme(`value({js|none|js}));
  CSS.colorScheme(`value({js|light none|js}));
