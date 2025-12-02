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
    ".css-gqhmy { offset: none; }\n.css-1410ddm { offset: auto; }\n.css-1ifsus1 { offset: center; }\n.css-1qjsgnd { offset: 200px 100px; }\n.css-xv3jgi { offset: margin-box; }\n.css-1jdx6cj { offset: border-box; }\n.css-1bgm1od { offset: padding-box; }\n.css-6i40c3 { offset: content-box; }\n.css-18jof08 { offset: fill-box; }\n.css-12jawhd { offset: stroke-box; }\n.css-1ujg4t5 { offset: view-box; }\n.css-ykcz58 { offset: path(\"M 20 20 H 80 V 30\"); }\n.css-uyafri { offset: url(\"image.png\"); }\n.css-1p4bd1t { offset: ray(45deg closest-side); }\n.css-e7vqlg { offset: ray(45deg closest-side) 10%; }\n.css-1mtq38s { offset: ray(45deg closest-side) 10% reverse; }\n.css-11s2m7b { offset: ray(45deg closest-side) reverse 10%; }\n.css-1w0ueiv { offset: auto / center; }\n.css-1a80n7e { offset: center / 200px 100px; }\n.css-1rgw6vp { offset: ray(45deg closest-side) / 200px 100px; }\n.css-m2549l { offset-path: none; }\n.css-1896ke8 { offset-path: ray(45deg closest-side); }\n.css-fpo65b { offset-path: ray(45deg farthest-side); }\n.css-57j4bh { offset-path: ray(45deg closest-corner); }\n.css-12pwcev { offset-path: ray(45deg farthest-corner); }\n.css-a51dpy { offset-path: ray(100grad closest-side contain); }\n.css-1ei1rlz { offset-path: margin-box; }\n.css-wgeboe { offset-path: border-box; }\n.css-lv591x { offset-path: padding-box; }\n.css-15043i4 { offset-path: content-box; }\n.css-1efrgkq { offset-path: fill-box; }\n.css-84dqel { offset-path: stroke-box; }\n.css-h1ouam { offset-path: view-box; }\n.css-1cegpd8 { offset-path: circle(60%) margin-box; }\n.css-u6mgvj { offset-distance: 10%; }\n.css-10a7by4 { offset-position: auto; }\n.css-1fhvbwo { offset-position: 200px; }\n.css-aheria { offset-position: 200px 100px; }\n.css-rm71xq { offset-position: center; }\n.css-17h3bl5 { offset-anchor: auto; }\n.css-py8p2y { offset-anchor: 200px; }\n.css-15l4h0o { offset-anchor: 200px 100px; }\n.css-cuh1ad { offset-anchor: center; }\n.css-td5cu8 { offset-rotate: auto; }\n.css-q7os3g { offset-rotate: 0deg; }\n.css-1argmfh { offset-rotate: reverse; }\n.css-5sl13x { offset-rotate: -45deg; }\n.css-v2472y { offset-rotate: auto 180deg; }\n.css-ng84z4 { offset-rotate: reverse 45deg; }\n.css-11qku7t { offset-rotate: 2turn reverse; }\n"
  ];
  CSS.make("css-gqhmy", []);
  CSS.make("css-1410ddm", []);
  CSS.make("css-1ifsus1", []);
  CSS.make("css-1qjsgnd", []);
  
  CSS.make("css-xv3jgi", []);
  CSS.make("css-1jdx6cj", []);
  CSS.make("css-1bgm1od", []);
  CSS.make("css-6i40c3", []);
  CSS.make("css-18jof08", []);
  CSS.make("css-12jawhd", []);
  CSS.make("css-1ujg4t5", []);
  
  CSS.make("css-ykcz58", []);
  CSS.make("css-uyafri", []);
  CSS.make("css-1p4bd1t", []);
  CSS.make("css-e7vqlg", []);
  CSS.make("css-1mtq38s", []);
  
  CSS.make("css-11s2m7b", []);
  
  CSS.make("css-1w0ueiv", []);
  CSS.make("css-1a80n7e", []);
  CSS.make("css-1rgw6vp", []);
  
  CSS.make("css-m2549l", []);
  CSS.make("css-1896ke8", []);
  CSS.make("css-fpo65b", []);
  CSS.make("css-57j4bh", []);
  CSS.make("css-12pwcev", []);
  
  CSS.make("css-a51dpy", []);
  
  CSS.make("css-1ei1rlz", []);
  CSS.make("css-wgeboe", []);
  CSS.make("css-lv591x", []);
  CSS.make("css-15043i4", []);
  CSS.make("css-1efrgkq", []);
  CSS.make("css-84dqel", []);
  CSS.make("css-h1ouam", []);
  CSS.make("css-1cegpd8", []);
  
  CSS.make("css-u6mgvj", []);
  CSS.make("css-10a7by4", []);
  CSS.make("css-1fhvbwo", []);
  CSS.make("css-aheria", []);
  CSS.make("css-rm71xq", []);
  CSS.make("css-17h3bl5", []);
  CSS.make("css-py8p2y", []);
  CSS.make("css-15l4h0o", []);
  CSS.make("css-cuh1ad", []);
  CSS.make("css-td5cu8", []);
  CSS.make("css-q7os3g", []);
  CSS.make("css-1argmfh", []);
  CSS.make("css-5sl13x", []);
  CSS.make("css-v2472y", []);
  CSS.make("css-ng84z4", []);
  CSS.make("css-11qku7t", []);
