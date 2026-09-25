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
  [@css ".a-5y335o{fill-rule:nonzero;}"];
  [@css ".a-5yje6q{fill-rule:evenodd;}"];
  [@css ".a-5x1axr{fill-opacity:0.5;}"];
  [@css ".a-5xmbij{fill-opacity:45%;}"];
  [@css ".a-c1fno8{stroke-width:0;}"];
  [@css ".a-c1bqje{stroke-width:1px;}"];
  [@css ".a-c1ssim{stroke-width:25%;}"];
  [@css ".a-bx3u6b{stroke-linecap:butt;}"];
  [@css ".a-bx96vv{stroke-linecap:round;}"];
  [@css ".a-bxdlez{stroke-linecap:square;}"];
  [@css ".a-bybou6{stroke-linejoin:miter;}"];
  [@css ".a-bycl19{stroke-linejoin:bevel;}"];
  [@css ".a-byzojx{stroke-linejoin:round;}"];
  [@css ".a-bz77up{stroke-miterlimit:4;}"];
  
  CSS.make("a-5y335o", []);
  CSS.make("a-5yje6q", []);
  
  CSS.make("a-5x1axr", []);
  CSS.make("a-5xmbij", []);
  
  CSS.make("a-c1fno8", []);
  CSS.make("a-c1bqje", []);
  CSS.make("a-c1ssim", []);
  
  CSS.make("a-bx3u6b", []);
  CSS.make("a-bx96vv", []);
  CSS.make("a-bxdlez", []);
  
  CSS.make("a-bybou6", []);
  CSS.make("a-bycl19", []);
  CSS.make("a-byzojx", []);
  
  CSS.make("a-bz77up", []);
