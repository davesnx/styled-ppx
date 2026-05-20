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
  [@css ".css-1ungwd0{break-before:auto;}"];
  [@css ".css-ogsw5z{break-before:avoid;}"];
  [@css ".css-1z0e3mx{break-before:avoid-page;}"];
  [@css ".css-1mxu2iv{break-before:page;}"];
  [@css ".css-1aeacmv{break-before:left;}"];
  [@css ".css-18ps0v2{break-before:right;}"];
  [@css ".css-1pnefcv{break-before:recto;}"];
  [@css ".css-7swwqb{break-before:verso;}"];
  [@css ".css-19gaz7b{break-before:avoid-column;}"];
  [@css ".css-u4inlv{break-before:column;}"];
  [@css ".css-1ubwpn3{break-before:avoid-region;}"];
  [@css ".css-1ynbno4{break-before:region;}"];
  [@css ".css-130801c{break-after:auto;}"];
  [@css ".css-5lf7vs{break-after:avoid;}"];
  [@css ".css-1p857zp{break-after:avoid-page;}"];
  [@css ".css-1hobk6r{break-after:page;}"];
  [@css ".css-1d6ekzp{break-after:left;}"];
  [@css ".css-14w5qvb{break-after:right;}"];
  [@css ".css-414tvf{break-after:recto;}"];
  [@css ".css-1d0k4gz{break-after:verso;}"];
  [@css ".css-7qiwkw{break-after:avoid-column;}"];
  [@css ".css-h5l3j6{break-after:column;}"];
  [@css ".css-1rayot9{break-after:avoid-region;}"];
  [@css ".css-11198ro{break-after:region;}"];
  [@css ".css-167fnl3{break-inside:auto;}"];
  [@css ".css-1ybn7nl{break-inside:avoid;}"];
  [@css ".css-c51xo4{break-inside:avoid-page;}"];
  [@css ".css-1d67h5w{break-inside:avoid-column;}"];
  [@css ".css-1a1pnax{break-inside:avoid-region;}"];
  [@css ".css-1iwipz1{box-decoration-break:slice;}"];
  [@css ".css-10thfn{box-decoration-break:clone;}"];
  [@css ".css-wb262r{orphans:1;}"];
  [@css ".css-1wd85qu{orphans:2;}"];
  [@css ".css-h7q94c{widows:1;}"];
  [@css ".css-15vmc20{widows:2;}"];
  
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
