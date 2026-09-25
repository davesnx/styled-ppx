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
  [@css ".a-43gwd0{break-before:auto;}"];
  [@css ".a-43sw5z{break-before:avoid;}"];
  [@css ".a-43e3mx{break-before:avoid-page;}"];
  [@css ".a-43u2iv{break-before:page;}"];
  [@css ".a-43acmv{break-before:left;}"];
  [@css ".a-43s0v2{break-before:right;}"];
  [@css ".a-43efcv{break-before:recto;}"];
  [@css ".a-43wwqb{break-before:verso;}"];
  [@css ".a-43az7b{break-before:avoid-column;}"];
  [@css ".a-43inlv{break-before:column;}"];
  [@css ".a-43wpn3{break-before:avoid-region;}"];
  [@css ".a-43bno4{break-before:region;}"];
  [@css ".a-42801c{break-after:auto;}"];
  [@css ".a-42f7vs{break-after:avoid;}"];
  [@css ".a-4257zp{break-after:avoid-page;}"];
  [@css ".a-42bk6r{break-after:page;}"];
  [@css ".a-42ekzp{break-after:left;}"];
  [@css ".a-425qvb{break-after:right;}"];
  [@css ".a-424tvf{break-after:recto;}"];
  [@css ".a-42k4gz{break-after:verso;}"];
  [@css ".a-42iwkw{break-after:avoid-column;}"];
  [@css ".a-42l3j6{break-after:column;}"];
  [@css ".a-42yot9{break-after:avoid-region;}"];
  [@css ".a-4298ro{break-after:region;}"];
  [@css ".a-44fnl3{break-inside:auto;}"];
  [@css ".a-44n7nl{break-inside:avoid;}"];
  [@css ".a-441xo4{break-inside:avoid-page;}"];
  [@css ".a-447h5w{break-inside:avoid-column;}"];
  [@css ".a-44pnax{break-inside:avoid-region;}"];
  [@css
    ".a-3sipz1{-webkit-box-decoration-break:slice;box-decoration-break:slice;}"
  ];
  [@css
    ".a-3sthfn{-webkit-box-decoration-break:clone;box-decoration-break:clone;}"
  ];
  [@css ".a-8o262r{orphans:1;}"];
  [@css ".a-8o85qu{orphans:2;}"];
  [@css ".a-ebq94c{widows:1;}"];
  [@css ".a-ebmc20{widows:2;}"];
  
  CSS.make("a-43gwd0", []);
  CSS.make("a-43sw5z", []);
  CSS.make("a-43e3mx", []);
  CSS.make("a-43u2iv", []);
  CSS.make("a-43acmv", []);
  CSS.make("a-43s0v2", []);
  CSS.make("a-43efcv", []);
  CSS.make("a-43wwqb", []);
  CSS.make("a-43az7b", []);
  CSS.make("a-43inlv", []);
  CSS.make("a-43wpn3", []);
  CSS.make("a-43bno4", []);
  CSS.make("a-42801c", []);
  CSS.make("a-42f7vs", []);
  CSS.make("a-4257zp", []);
  CSS.make("a-42bk6r", []);
  CSS.make("a-42ekzp", []);
  CSS.make("a-425qvb", []);
  CSS.make("a-424tvf", []);
  CSS.make("a-42k4gz", []);
  CSS.make("a-42iwkw", []);
  CSS.make("a-42l3j6", []);
  CSS.make("a-42yot9", []);
  CSS.make("a-4298ro", []);
  CSS.make("a-44fnl3", []);
  CSS.make("a-44n7nl", []);
  CSS.make("a-441xo4", []);
  CSS.make("a-447h5w", []);
  CSS.make("a-44pnax", []);
  CSS.make("a-3sipz1", []);
  CSS.make("a-3sthfn", []);
  CSS.make("a-8o262r", []);
  CSS.make("a-8o85qu", []);
  
  CSS.make("a-ebq94c", []);
  CSS.make("a-ebmc20", []);
