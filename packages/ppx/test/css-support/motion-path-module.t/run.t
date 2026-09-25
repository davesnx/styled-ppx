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
  [@css ".a-yb08bu{offset:none;}"];
  [@css ".a-3s0roh{offset:auto;}"];
  [@css ".a-17bq43b{offset:center;}"];
  [@css ".a-gb2u3l{offset:200px 100px;}"];
  [@css ".a-bdqvfn{offset:margin-box;}"];
  [@css ".a-131fcn7{offset:border-box;}"];
  [@css ".a-1nfin4h{offset:padding-box;}"];
  [@css ".a-sbcd7d{offset:content-box;}"];
  [@css ".a-1m3b2is{offset:fill-box;}"];
  [@css ".a-1n2bqhs{offset:stroke-box;}"];
  [@css ".a-1ygeoo7{offset:view-box;}"];
  [@css ".a-1ub9jbl{offset:path(\"M 20 20 H 80 V 30\");}"];
  [@css ".a-18qkclk{offset:url(\"image.png\");}"];
  [@css ".a-167in5y{offset:ray(45deg closest-side);}"];
  [@css ".a-1y80jt4{offset:ray(45deg closest-side) 10%;}"];
  [@css ".a-usdq6h{offset:ray(45deg closest-side) 10% reverse;}"];
  [@css ".a-7lsvdf{offset:ray(45deg closest-side) reverse 10%;}"];
  [@css ".a-drqvtx{offset:auto / center;}"];
  [@css ".a-1wqh264{offset:center / 200px 100px;}"];
  [@css ".a-vszycc{offset:ray(45deg closest-side) / 200px 100px;}"];
  [@css ".a-1dt99ro{offset-path:none;}"];
  [@css ".a-19drnrp{offset-path:ray(45deg closest-side);}"];
  [@css ".a-5yyl6h{offset-path:ray(45deg farthest-side);}"];
  [@css ".a-1getk4n{offset-path:ray(45deg closest-corner);}"];
  [@css ".a-19aa34v{offset-path:ray(45deg farthest-corner);}"];
  [@css ".a-7zzxur{offset-path:ray(100grad closest-side contain);}"];
  [@css ".a-gsmbjm{offset-path:margin-box;}"];
  [@css ".a-4sghf5{offset-path:border-box;}"];
  [@css ".a-1w35ixk{offset-path:padding-box;}"];
  [@css ".a-1rv9k08{offset-path:content-box;}"];
  [@css ".a-1vy8rjx{offset-path:fill-box;}"];
  [@css ".a-4oee2x{offset-path:stroke-box;}"];
  [@css ".a-cq3loi{offset-path:view-box;}"];
  [@css ".a-p66ry6{offset-path:circle(60%) margin-box;}"];
  [@css ".a-sokto5{offset-distance:10%;}"];
  [@css ".a-o7ibr3{offset-position:auto;}"];
  [@css ".a-ioz6wa{offset-position:200px;}"];
  [@css ".a-623fe7{offset-position:200px 100px;}"];
  [@css ".a-1kqzfje{offset-position:center;}"];
  [@css ".a-1w008zo{offset-anchor:auto;}"];
  [@css ".a-2hvp1o{offset-anchor:200px;}"];
  [@css ".a-1d9ar84{offset-anchor:200px 100px;}"];
  [@css ".a-afgyzg{offset-anchor:center;}"];
  [@css ".a-1e6fec8{offset-rotate:auto;}"];
  [@css ".a-1xv6haa{offset-rotate:0deg;}"];
  [@css ".a-1tqrfcf{offset-rotate:reverse;}"];
  [@css ".a-18vu5ss{offset-rotate:-45deg;}"];
  [@css ".a-1p3eddq{offset-rotate:auto 180deg;}"];
  [@css ".a-lj3wxn{offset-rotate:reverse 45deg;}"];
  [@css ".a-1mhkmna{offset-rotate:2turn reverse;}"];
  
  CSS.make("a-yb08bu", []);
  CSS.make("a-3s0roh", []);
  CSS.make("a-17bq43b", []);
  CSS.make("a-gb2u3l", []);
  
  CSS.make("a-bdqvfn", []);
  CSS.make("a-131fcn7", []);
  CSS.make("a-1nfin4h", []);
  CSS.make("a-sbcd7d", []);
  CSS.make("a-1m3b2is", []);
  CSS.make("a-1n2bqhs", []);
  CSS.make("a-1ygeoo7", []);
  
  CSS.make("a-1ub9jbl", []);
  CSS.make("a-18qkclk", []);
  CSS.make("a-167in5y", []);
  CSS.make("a-1y80jt4", []);
  CSS.make("a-usdq6h", []);
  
  CSS.make("a-7lsvdf", []);
  
  CSS.make("a-drqvtx", []);
  CSS.make("a-1wqh264", []);
  CSS.make("a-vszycc", []);
  
  CSS.make("a-1dt99ro", []);
  CSS.make("a-19drnrp", []);
  CSS.make("a-5yyl6h", []);
  CSS.make("a-1getk4n", []);
  CSS.make("a-19aa34v", []);
  
  CSS.make("a-7zzxur", []);
  
  CSS.make("a-gsmbjm", []);
  CSS.make("a-4sghf5", []);
  CSS.make("a-1w35ixk", []);
  CSS.make("a-1rv9k08", []);
  CSS.make("a-1vy8rjx", []);
  CSS.make("a-4oee2x", []);
  CSS.make("a-cq3loi", []);
  CSS.make("a-p66ry6", []);
  
  CSS.make("a-sokto5", []);
  CSS.make("a-o7ibr3", []);
  CSS.make("a-ioz6wa", []);
  CSS.make("a-623fe7", []);
  CSS.make("a-1kqzfje", []);
  CSS.make("a-1w008zo", []);
  CSS.make("a-2hvp1o", []);
  CSS.make("a-1d9ar84", []);
  CSS.make("a-afgyzg", []);
  CSS.make("a-1e6fec8", []);
  CSS.make("a-1xv6haa", []);
  CSS.make("a-1tqrfcf", []);
  CSS.make("a-18vu5ss", []);
  CSS.make("a-1p3eddq", []);
  CSS.make("a-lj3wxn", []);
  CSS.make("a-1mhkmna", []);
