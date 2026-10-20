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
  [@css "._a_5y335o{fill-rule:nonzero;}"];
  [@css "._a_5yje6q{fill-rule:evenodd;}"];
  [@css "._a_5x1axr{fill-opacity:0.5;}"];
  [@css "._a_5xmbij{fill-opacity:45%;}"];
  [@css "._a_c1fno8{stroke-width:0;}"];
  [@css "._a_c1bqje{stroke-width:1px;}"];
  [@css "._a_c1ssim{stroke-width:25%;}"];
  [@css "._a_bx3u6b{stroke-linecap:butt;}"];
  [@css "._a_bx96vv{stroke-linecap:round;}"];
  [@css "._a_bxdlez{stroke-linecap:square;}"];
  [@css "._a_bybou6{stroke-linejoin:miter;}"];
  [@css "._a_bycl19{stroke-linejoin:bevel;}"];
  [@css "._a_byzojx{stroke-linejoin:round;}"];
  [@css "._a_bz77up{stroke-miterlimit:4;}"];
  [@css.blocks
    [
      (7, "_a_5y335o"),
      (8, "_a_5yje6q"),
      (62, "_a_5x1axr"),
      (63, "_a_5xmbij"),
      (69, "_a_c1fno8"),
      (70, "_a_c1bqje"),
      (71, "_a_c1ssim"),
      (75, "_a_bx3u6b"),
      (76, "_a_bx96vv"),
      (77, "_a_bxdlez"),
      (80, "_a_bybou6"),
      (81, "_a_bycl19"),
      (82, "_a_byzojx"),
      (87, "_a_bz77up"),
    ]
  ];
  
  CSS.make("_a_5y335o", []);
  CSS.make("_a_5yje6q", []);
  
  CSS.make("_a_5x1axr", []);
  CSS.make("_a_5xmbij", []);
  
  CSS.make("_a_c1fno8", []);
  CSS.make("_a_c1bqje", []);
  CSS.make("_a_c1ssim", []);
  
  CSS.make("_a_bx3u6b", []);
  CSS.make("_a_bx96vv", []);
  CSS.make("_a_bxdlez", []);
  
  CSS.make("_a_bybou6", []);
  CSS.make("_a_bycl19", []);
  CSS.make("_a_byzojx", []);
  
  CSS.make("_a_bz77up", []);
