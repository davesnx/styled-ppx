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
    ".css-1ungwd0{break-before:auto;}\n.css-ogsw5z{break-before:avoid;}\n.css-1z0e3mx{break-before:avoid-page;}\n.css-1mxu2iv{break-before:page;}\n.css-1aeacmv{break-before:left;}\n.css-18ps0v2{break-before:right;}\n.css-1pnefcv{break-before:recto;}\n.css-7swwqb{break-before:verso;}\n.css-19gaz7b{break-before:avoid-column;}\n.css-u4inlv{break-before:column;}\n.css-1ubwpn3{break-before:avoid-region;}\n.css-1ynbno4{break-before:region;}\n.css-130801c{break-after:auto;}\n.css-5lf7vs{break-after:avoid;}\n.css-1p857zp{break-after:avoid-page;}\n.css-1hobk6r{break-after:page;}\n.css-1d6ekzp{break-after:left;}\n.css-14w5qvb{break-after:right;}\n.css-414tvf{break-after:recto;}\n.css-1d0k4gz{break-after:verso;}\n.css-7qiwkw{break-after:avoid-column;}\n.css-h5l3j6{break-after:column;}\n.css-1rayot9{break-after:avoid-region;}\n.css-11198ro{break-after:region;}\n.css-167fnl3{break-inside:auto;}\n.css-1ybn7nl{break-inside:avoid;}\n.css-c51xo4{break-inside:avoid-page;}\n.css-1d67h5w{break-inside:avoid-column;}\n.css-1a1pnax{break-inside:avoid-region;}\n.css-1iwipz1{box-decoration-break:slice;}\n.css-10thfn{box-decoration-break:clone;}\n.css-wb262r{orphans:1;}\n.css-1wd85qu{orphans:2;}\n.css-h7q94c{widows:1;}\n.css-15vmc20{widows:2;}\n"
  ];
  
  CSS.make("css-1ungwd0", []);
  CSS.make("css-ogsw5z", []);
  CSS.make("css-1z0e3mx", []);
  CSS.make("css-1mxu2iv", []);
  CSS.make("css-1aeacmv", []);
  CSS.make("css-18ps0v2", []);
  CSS.make("css-1pnefcv", []);
  CSS.make("css-7swwqb", []);
  CSS.make("css-19gaz7b", []);
  CSS.make("css-u4inlv", []);
  CSS.make("css-1ubwpn3", []);
  CSS.make("css-1ynbno4", []);
  CSS.make("css-130801c", []);
  CSS.make("css-5lf7vs", []);
  CSS.make("css-1p857zp", []);
  CSS.make("css-1hobk6r", []);
  CSS.make("css-1d6ekzp", []);
  CSS.make("css-14w5qvb", []);
  CSS.make("css-414tvf", []);
  CSS.make("css-1d0k4gz", []);
  CSS.make("css-7qiwkw", []);
  CSS.make("css-h5l3j6", []);
  CSS.make("css-1rayot9", []);
  CSS.make("css-11198ro", []);
  CSS.make("css-167fnl3", []);
  CSS.make("css-1ybn7nl", []);
  CSS.make("css-c51xo4", []);
  CSS.make("css-1d67h5w", []);
  CSS.make("css-1a1pnax", []);
  CSS.make("css-1iwipz1", []);
  CSS.make("css-10thfn", []);
  CSS.make("css-wb262r", []);
  CSS.make("css-1wd85qu", []);
  
  CSS.make("css-h7q94c", []);
  CSS.make("css-15vmc20", []);
