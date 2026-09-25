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
  [@css ".a-1ungwd0{break-before:auto;}"];
  [@css ".a-ogsw5z{break-before:avoid;}"];
  [@css ".a-1z0e3mx{break-before:avoid-page;}"];
  [@css ".a-1mxu2iv{break-before:page;}"];
  [@css ".a-1aeacmv{break-before:left;}"];
  [@css ".a-18ps0v2{break-before:right;}"];
  [@css ".a-1pnefcv{break-before:recto;}"];
  [@css ".a-7swwqb{break-before:verso;}"];
  [@css ".a-19gaz7b{break-before:avoid-column;}"];
  [@css ".a-u4inlv{break-before:column;}"];
  [@css ".a-1ubwpn3{break-before:avoid-region;}"];
  [@css ".a-1ynbno4{break-before:region;}"];
  [@css ".a-130801c{break-after:auto;}"];
  [@css ".a-5lf7vs{break-after:avoid;}"];
  [@css ".a-1p857zp{break-after:avoid-page;}"];
  [@css ".a-1hobk6r{break-after:page;}"];
  [@css ".a-1d6ekzp{break-after:left;}"];
  [@css ".a-14w5qvb{break-after:right;}"];
  [@css ".a-414tvf{break-after:recto;}"];
  [@css ".a-1d0k4gz{break-after:verso;}"];
  [@css ".a-7qiwkw{break-after:avoid-column;}"];
  [@css ".a-h5l3j6{break-after:column;}"];
  [@css ".a-1rayot9{break-after:avoid-region;}"];
  [@css ".a-11198ro{break-after:region;}"];
  [@css ".a-167fnl3{break-inside:auto;}"];
  [@css ".a-1ybn7nl{break-inside:avoid;}"];
  [@css ".a-c51xo4{break-inside:avoid-page;}"];
  [@css ".a-1d67h5w{break-inside:avoid-column;}"];
  [@css ".a-1a1pnax{break-inside:avoid-region;}"];
  [@css
    ".a-1iwipz1{-webkit-box-decoration-break:slice;box-decoration-break:slice;}"
  ];
  [@css
    ".a-10thfn{-webkit-box-decoration-break:clone;box-decoration-break:clone;}"
  ];
  [@css ".a-wb262r{orphans:1;}"];
  [@css ".a-1wd85qu{orphans:2;}"];
  [@css ".a-h7q94c{widows:1;}"];
  [@css ".a-15vmc20{widows:2;}"];
  
  CSS.make("a-1ungwd0", []);
  CSS.make("a-ogsw5z", []);
  CSS.make("a-1z0e3mx", []);
  CSS.make("a-1mxu2iv", []);
  CSS.make("a-1aeacmv", []);
  CSS.make("a-18ps0v2", []);
  CSS.make("a-1pnefcv", []);
  CSS.make("a-7swwqb", []);
  CSS.make("a-19gaz7b", []);
  CSS.make("a-u4inlv", []);
  CSS.make("a-1ubwpn3", []);
  CSS.make("a-1ynbno4", []);
  CSS.make("a-130801c", []);
  CSS.make("a-5lf7vs", []);
  CSS.make("a-1p857zp", []);
  CSS.make("a-1hobk6r", []);
  CSS.make("a-1d6ekzp", []);
  CSS.make("a-14w5qvb", []);
  CSS.make("a-414tvf", []);
  CSS.make("a-1d0k4gz", []);
  CSS.make("a-7qiwkw", []);
  CSS.make("a-h5l3j6", []);
  CSS.make("a-1rayot9", []);
  CSS.make("a-11198ro", []);
  CSS.make("a-167fnl3", []);
  CSS.make("a-1ybn7nl", []);
  CSS.make("a-c51xo4", []);
  CSS.make("a-1d67h5w", []);
  CSS.make("a-1a1pnax", []);
  CSS.make("a-1iwipz1", []);
  CSS.make("a-10thfn", []);
  CSS.make("a-wb262r", []);
  CSS.make("a-1wd85qu", []);
  
  CSS.make("a-h7q94c", []);
  CSS.make("a-15vmc20", []);
