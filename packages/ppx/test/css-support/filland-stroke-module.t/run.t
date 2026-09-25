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
  [@css ".a-1er335o{fill-rule:nonzero;}"];
  [@css ".a-1uqje6q{fill-rule:evenodd;}"];
  [@css ".a-h01axr{fill-opacity:0.5;}"];
  [@css ".a-1p4mbij{fill-opacity:45%;}"];
  [@css ".a-stfno8{stroke-width:0;}"];
  [@css ".a-7hbqje{stroke-width:1px;}"];
  [@css ".a-11bssim{stroke-width:25%;}"];
  [@css ".a-16f3u6b{stroke-linecap:butt;}"];
  [@css ".a-1me96vv{stroke-linecap:round;}"];
  [@css ".a-1j4dlez{stroke-linecap:square;}"];
  [@css ".a-8vbou6{stroke-linejoin:miter;}"];
  [@css ".a-1t1cl19{stroke-linejoin:bevel;}"];
  [@css ".a-8mzojx{stroke-linejoin:round;}"];
  [@css ".a-1a477up{stroke-miterlimit:4;}"];
  
  CSS.make("a-1er335o", []);
  CSS.make("a-1uqje6q", []);
  
  CSS.make("a-h01axr", []);
  CSS.make("a-1p4mbij", []);
  
  CSS.make("a-stfno8", []);
  CSS.make("a-7hbqje", []);
  CSS.make("a-11bssim", []);
  
  CSS.make("a-16f3u6b", []);
  CSS.make("a-1me96vv", []);
  CSS.make("a-1j4dlez", []);
  
  CSS.make("a-8vbou6", []);
  CSS.make("a-1t1cl19", []);
  CSS.make("a-8mzojx", []);
  
  CSS.make("a-1a477up", []);
