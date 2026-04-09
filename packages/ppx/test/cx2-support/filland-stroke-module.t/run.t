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
  [@css ".css-1er335o{fill-rule:nonzero;}"];
  [@css ".css-1uqje6q{fill-rule:evenodd;}"];
  [@css ".css-h01axr{fill-opacity:0.5;}"];
  [@css ".css-1p4mbij{fill-opacity:45%;}"];
  [@css ".css-stfno8{stroke-width:0;}"];
  [@css ".css-7hbqje{stroke-width:1px;}"];
  [@css ".css-11bssim{stroke-width:25%;}"];
  [@css ".css-16f3u6b{stroke-linecap:butt;}"];
  [@css ".css-1me96vv{stroke-linecap:round;}"];
  [@css ".css-hs62tc{stroke-linecap:square ;}"];
  [@css ".css-8vbou6{stroke-linejoin:miter;}"];
  [@css ".css-1t1cl19{stroke-linejoin:bevel;}"];
  [@css ".css-8mzojx{stroke-linejoin:round;}"];
  [@css ".css-1a477up{stroke-miterlimit:4;}"];
  
  CSS.make("css-1er335o", []);
  CSS.make("css-1uqje6q", []);
  
  CSS.make("css-h01axr", []);
  CSS.make("css-1p4mbij", []);
  
  CSS.make("css-stfno8", []);
  CSS.make("css-7hbqje", []);
  CSS.make("css-11bssim", []);
  
  CSS.make("css-16f3u6b", []);
  CSS.make("css-1me96vv", []);
  CSS.make("css-hs62tc", []);
  
  CSS.make("css-8vbou6", []);
  CSS.make("css-1t1cl19", []);
  CSS.make("css-8mzojx", []);
  
  CSS.make("css-1a477up", []);
