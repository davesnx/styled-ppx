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
  [@css "._a_43gwd0{break-before:auto;}"];
  [@css "._a_43sw5z{break-before:avoid;}"];
  [@css "._a_43e3mx{break-before:avoid-page;}"];
  [@css "._a_43u2iv{break-before:page;}"];
  [@css "._a_43acmv{break-before:left;}"];
  [@css "._a_43s0v2{break-before:right;}"];
  [@css "._a_43efcv{break-before:recto;}"];
  [@css "._a_43wwqb{break-before:verso;}"];
  [@css "._a_43az7b{break-before:avoid-column;}"];
  [@css "._a_43inlv{break-before:column;}"];
  [@css "._a_43wpn3{break-before:avoid-region;}"];
  [@css "._a_43bno4{break-before:region;}"];
  [@css "._a_42801c{break-after:auto;}"];
  [@css "._a_42f7vs{break-after:avoid;}"];
  [@css "._a_4257zp{break-after:avoid-page;}"];
  [@css "._a_42bk6r{break-after:page;}"];
  [@css "._a_42ekzp{break-after:left;}"];
  [@css "._a_425qvb{break-after:right;}"];
  [@css "._a_424tvf{break-after:recto;}"];
  [@css "._a_42k4gz{break-after:verso;}"];
  [@css "._a_42iwkw{break-after:avoid-column;}"];
  [@css "._a_42l3j6{break-after:column;}"];
  [@css "._a_42yot9{break-after:avoid-region;}"];
  [@css "._a_4298ro{break-after:region;}"];
  [@css "._a_44fnl3{break-inside:auto;}"];
  [@css "._a_44n7nl{break-inside:avoid;}"];
  [@css "._a_441xo4{break-inside:avoid-page;}"];
  [@css "._a_447h5w{break-inside:avoid-column;}"];
  [@css "._a_44pnax{break-inside:avoid-region;}"];
  [@css
    "._a_3sipz1{-webkit-box-decoration-break:slice;box-decoration-break:slice;}"
  ];
  [@css
    "._a_3sthfn{-webkit-box-decoration-break:clone;box-decoration-break:clone;}"
  ];
  [@css "._a_8o262r{orphans:1;}"];
  [@css "._a_8o85qu{orphans:2;}"];
  [@css "._a_ebq94c{widows:1;}"];
  [@css "._a_ebmc20{widows:2;}"];
  
  CSS.make("_a_43gwd0", []);
  CSS.make("_a_43sw5z", []);
  CSS.make("_a_43e3mx", []);
  CSS.make("_a_43u2iv", []);
  CSS.make("_a_43acmv", []);
  CSS.make("_a_43s0v2", []);
  CSS.make("_a_43efcv", []);
  CSS.make("_a_43wwqb", []);
  CSS.make("_a_43az7b", []);
  CSS.make("_a_43inlv", []);
  CSS.make("_a_43wpn3", []);
  CSS.make("_a_43bno4", []);
  CSS.make("_a_42801c", []);
  CSS.make("_a_42f7vs", []);
  CSS.make("_a_4257zp", []);
  CSS.make("_a_42bk6r", []);
  CSS.make("_a_42ekzp", []);
  CSS.make("_a_425qvb", []);
  CSS.make("_a_424tvf", []);
  CSS.make("_a_42k4gz", []);
  CSS.make("_a_42iwkw", []);
  CSS.make("_a_42l3j6", []);
  CSS.make("_a_42yot9", []);
  CSS.make("_a_4298ro", []);
  CSS.make("_a_44fnl3", []);
  CSS.make("_a_44n7nl", []);
  CSS.make("_a_441xo4", []);
  CSS.make("_a_447h5w", []);
  CSS.make("_a_44pnax", []);
  CSS.make("_a_3sipz1", []);
  CSS.make("_a_3sthfn", []);
  CSS.make("_a_8o262r", []);
  CSS.make("_a_8o85qu", []);
  
  CSS.make("_a_ebq94c", []);
  CSS.make("_a_ebmc20", []);
