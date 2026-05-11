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
  [@css ".css-yb08bu{offset:none;}"];
  [@css ".css-3s0roh{offset:auto;}"];
  [@css ".css-17bq43b{offset:center;}"];
  [@css ".css-gb2u3l{offset:200px 100px;}"];
  [@css ".css-bdqvfn{offset:margin-box;}"];
  [@css ".css-131fcn7{offset:border-box;}"];
  [@css ".css-1nfin4h{offset:padding-box;}"];
  [@css ".css-sbcd7d{offset:content-box;}"];
  [@css ".css-1m3b2is{offset:fill-box;}"];
  [@css ".css-1n2bqhs{offset:stroke-box;}"];
  [@css ".css-1ygeoo7{offset:view-box;}"];
  [@css ".css-1ub9jbl{offset:path(\"M 20 20 H 80 V 30\");}"];
  [@css ".css-18qkclk{offset:url(\"image.png\");}"];
  [@css ".css-167in5y{offset:ray(45deg closest-side);}"];
  [@css ".css-1y80jt4{offset:ray(45deg closest-side) 10%;}"];
  [@css ".css-usdq6h{offset:ray(45deg closest-side) 10% reverse;}"];
  [@css ".css-7lsvdf{offset:ray(45deg closest-side) reverse 10%;}"];
  [@css ".css-drqvtx{offset:auto / center;}"];
  [@css ".css-1wqh264{offset:center / 200px 100px;}"];
  [@css ".css-vszycc{offset:ray(45deg closest-side) / 200px 100px;}"];
  [@css ".css-1dt99ro{offset-path:none;}"];
  [@css ".css-19drnrp{offset-path:ray(45deg closest-side);}"];
  [@css ".css-5yyl6h{offset-path:ray(45deg farthest-side);}"];
  [@css ".css-1getk4n{offset-path:ray(45deg closest-corner);}"];
  [@css ".css-19aa34v{offset-path:ray(45deg farthest-corner);}"];
  [@css ".css-7zzxur{offset-path:ray(100grad closest-side contain);}"];
  [@css ".css-gsmbjm{offset-path:margin-box;}"];
  [@css ".css-4sghf5{offset-path:border-box;}"];
  [@css ".css-1w35ixk{offset-path:padding-box;}"];
  [@css ".css-1rv9k08{offset-path:content-box;}"];
  [@css ".css-1vy8rjx{offset-path:fill-box;}"];
  [@css ".css-4oee2x{offset-path:stroke-box;}"];
  [@css ".css-cq3loi{offset-path:view-box;}"];
  [@css ".css-p66ry6{offset-path:circle(60%) margin-box;}"];
  [@css ".css-sokto5{offset-distance:10%;}"];
  [@css ".css-o7ibr3{offset-position:auto;}"];
  [@css ".css-ioz6wa{offset-position:200px;}"];
  [@css ".css-623fe7{offset-position:200px 100px;}"];
  [@css ".css-1kqzfje{offset-position:center;}"];
  [@css ".css-1w008zo{offset-anchor:auto;}"];
  [@css ".css-2hvp1o{offset-anchor:200px;}"];
  [@css ".css-1d9ar84{offset-anchor:200px 100px;}"];
  [@css ".css-afgyzg{offset-anchor:center;}"];
  [@css ".css-1e6fec8{offset-rotate:auto;}"];
  [@css ".css-1xv6haa{offset-rotate:0deg;}"];
  [@css ".css-1tqrfcf{offset-rotate:reverse;}"];
  [@css ".css-18vu5ss{offset-rotate:-45deg;}"];
  [@css ".css-1p3eddq{offset-rotate:auto 180deg;}"];
  [@css ".css-lj3wxn{offset-rotate:reverse 45deg;}"];
  [@css ".css-1mhkmna{offset-rotate:2turn reverse;}"];
  
  CSS.make("css-yb08bu", []);
  CSS.make("css-3s0roh", []);
  CSS.make("css-17bq43b", []);
  CSS.make("css-gb2u3l", []);
  
  CSS.make("css-bdqvfn", []);
  CSS.make("css-131fcn7", []);
  CSS.make("css-1nfin4h", []);
  CSS.make("css-sbcd7d", []);
  CSS.make("css-1m3b2is", []);
  CSS.make("css-1n2bqhs", []);
  CSS.make("css-1ygeoo7", []);
  
  CSS.make("css-1ub9jbl", []);
  CSS.make("css-18qkclk", []);
  CSS.make("css-167in5y", []);
  CSS.make("css-1y80jt4", []);
  CSS.make("css-usdq6h", []);
  
  CSS.make("css-7lsvdf", []);
  
  CSS.make("css-drqvtx", []);
  CSS.make("css-1wqh264", []);
  CSS.make("css-vszycc", []);
  
  CSS.make("css-1dt99ro", []);
  CSS.make("css-19drnrp", []);
  CSS.make("css-5yyl6h", []);
  CSS.make("css-1getk4n", []);
  CSS.make("css-19aa34v", []);
  
  CSS.make("css-7zzxur", []);
  
  CSS.make("css-gsmbjm", []);
  CSS.make("css-4sghf5", []);
  CSS.make("css-1w35ixk", []);
  CSS.make("css-1rv9k08", []);
  CSS.make("css-1vy8rjx", []);
  CSS.make("css-4oee2x", []);
  CSS.make("css-cq3loi", []);
  CSS.make("css-p66ry6", []);
  
  CSS.make("css-sokto5", []);
  CSS.make("css-o7ibr3", []);
  CSS.make("css-ioz6wa", []);
  CSS.make("css-623fe7", []);
  CSS.make("css-1kqzfje", []);
  CSS.make("css-1w008zo", []);
  CSS.make("css-2hvp1o", []);
  CSS.make("css-1d9ar84", []);
  CSS.make("css-afgyzg", []);
  CSS.make("css-1e6fec8", []);
  CSS.make("css-1xv6haa", []);
  CSS.make("css-1tqrfcf", []);
  CSS.make("css-18vu5ss", []);
  CSS.make("css-1p3eddq", []);
  CSS.make("css-lj3wxn", []);
  CSS.make("css-1mhkmna", []);
