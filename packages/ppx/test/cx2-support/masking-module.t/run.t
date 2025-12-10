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


  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-z3n8d4 { clip-path: url(\"#clip\"); }\n.css-1dvjp0a { clip-path: inset(50%); }\n.css-uw2gol { clip-path: path(\"M 20 20 H 80 V 30\"); }\n.css-lxe1gh { clip-path: polygon(50% 100%, 0 0, 100% 0); }\n.css-10to5xt { clip-path: polygon(evenodd, 0% 0%, 50% 50%, 0% 100%); }\n.css-v54nk3 { clip-path: polygon(nonzero, 0% 0%, 50% 50%, 0% 100%); }\n.css-1snnsa0 { clip-path: border-box; }\n.css-1ypt5p { clip-path: padding-box; }\n.css-1gm3m6h { clip-path: content-box; }\n.css-1yip9gi { clip-path: margin-box; }\n.css-qn4e6j { clip-path: fill-box; }\n.css-cdj5g8 { clip-path: stroke-box; }\n.css-1636qdt { clip-path: view-box; }\n.css-eylmim { clip-path: none; }\n.css-qd8str { clip-rule: nonzero; }\n.css-cq0ctl { clip-rule: evenodd; }\n.css-2ukfkg { mask-image: none; }\n.css-xrdjzm { mask-image: linear-gradient(45deg, #333, #000); }\n.css-xbc1 { mask-image: url(\"image.png\"); }\n.css-1b0mr3s { mask-mode: alpha; }\n.css-5ezr8h { mask-mode: luminance; }\n.css-fb4qwz { mask-mode: match-source; }\n.css-16hz29a { mask-repeat: repeat-x; }\n.css-1rtrnhy { mask-repeat: repeat-y; }\n.css-k6vz1s { mask-repeat: repeat; }\n.css-52w0kr { mask-repeat: space; }\n.css-m4a4wy { mask-repeat: round; }\n.css-13odl3r { mask-repeat: no-repeat; }\n.css-1cn55ow { mask-repeat: repeat repeat; }\n.css-1u121op { mask-repeat: space repeat; }\n.css-1v5crnn { mask-repeat: round repeat; }\n.css-yu2key { mask-repeat: no-repeat repeat; }\n.css-abqmxb { mask-repeat: repeat space; }\n.css-1yqx3uf { mask-repeat: space space; }\n.css-1k8za9y { mask-repeat: round space; }\n.css-1ru5dwx { mask-repeat: no-repeat space; }\n.css-l5yu21 { mask-repeat: repeat round; }\n.css-16c9p7o { mask-repeat: space round; }\n.css-f5do92 { mask-repeat: round round; }\n.css-v4vynr { mask-repeat: no-repeat round; }\n.css-1xmdx0v { mask-repeat: repeat no-repeat; }\n.css-1hy2mj4 { mask-repeat: space no-repeat; }\n.css-1wg0ghu { mask-repeat: round no-repeat; }\n.css-9hvgri { mask-repeat: no-repeat no-repeat; }\n.css-15otve { mask-position: center; }\n.css-egl27m { mask-position: center center; }\n.css-mg9iuz { mask-position: left 50%; }\n.css-95syj5 { mask-position: bottom 10px right 20px; }\n.css-kcdjpy { mask-position: 1rem 1rem, center; }\n.css-1vp6ch1 { mask-clip: border-box; }\n.css-1c9telo { mask-clip: padding-box; }\n.css-4t2ydq { mask-clip: content-box; }\n.css-cxz7hi { mask-clip: margin-box; }\n.css-1tria9l { mask-clip: fill-box; }\n.css-br4nhd { mask-clip: stroke-box; }\n.css-19f4xc3 { mask-clip: view-box; }\n.css-1l9yvv { mask-clip: no-clip; }\n.css-1fxices { mask-origin: border-box; }\n.css-1k23bs7 { mask-origin: padding-box; }\n.css-gnw30p { mask-origin: content-box; }\n.css-3c4zy9 { mask-origin: margin-box; }\n.css-wprp1t { mask-origin: fill-box; }\n.css-18vrowk { mask-origin: stroke-box; }\n.css-1cb2dcf { mask-origin: view-box; }\n.css-1u0ht9p { mask-size: auto; }\n.css-m2fq66 { mask-size: 10px; }\n.css-1golpk8 { mask-size: cover; }\n.css-1ot9ekp { mask-size: contain; }\n.css-1mu4rou { mask-size: 50%; }\n.css-1mv9xga { mask-size: 10px auto; }\n.css-jx2qa6 { mask-size: auto 10%; }\n.css-1qtzujq { mask-size: 50em 50%; }\n.css-1bhh1lh { mask-composite: add; }\n.css-11accdw { mask-composite: subtract; }\n.css-1ropar4 { mask-composite: intersect; }\n.css-to8yfu { mask-composite: exclude; }\n.css-2x38mp { mask: top; }\n.css-4jnldj { mask: space; }\n.css-3ihnj7 { mask: url(\"image.png\"); }\n.css-1a9zgo9 { mask: url(\"image.png\") luminance; }\n.css-1qhjvbk { mask: url(\"image.png\") luminance top space; }\n.css-5envxq { mask-border-source: none; }\n.css-o1o9fw { mask-border-source: url(\"image.png\"); }\n.css-mbf1s5 { mask-border-slice: 0 fill; }\n.css-1z0dkx3 { mask-border-slice: 50% fill; }\n.css-1stlac { mask-border-slice: 1.1 fill; }\n.css-1pm4u0i { mask-border-slice: 0 1 fill; }\n.css-j575wg { mask-border-slice: 0 1 2 fill; }\n.css-oo5r5s { mask-border-slice: 0 1 2 3 fill; }\n.css-5onz4r { mask-border-width: auto; }\n.css-11z229h { mask-border-width: 10px; }\n.css-1y5cby0 { mask-border-width: 50%; }\n.css-12prqve { mask-border-width: 1; }\n.css-rq72er { mask-border-width: 1.0; }\n.css-1x0ynac { mask-border-width: auto 1; }\n.css-1718ifd { mask-border-width: auto 1 50%; }\n.css-1fub0yk { mask-border-width: auto 1 50% 1.1; }\n.css-13pup2k { mask-border-outset: 0; }\n.css-1wy9pat { mask-border-outset: 1.1; }\n.css-1l49bwg { mask-border-outset: 0 1; }\n.css-ac7rnh { mask-border-outset: 0 1 2; }\n.css-15negad { mask-border-outset: 0 1 2 3; }\n.css-l696je { mask-border-repeat: stretch; }\n.css-1m2f2uh { mask-border-repeat: repeat; }\n.css-1p3mobv { mask-border-repeat: round; }\n.css-15gtunp { mask-border-repeat: space; }\n.css-12s7mr2 { mask-border-repeat: stretch stretch; }\n.css-tzqk82 { mask-border-repeat: repeat stretch; }\n.css-e4liu2 { mask-border-repeat: round stretch; }\n.css-8870zt { mask-border-repeat: space stretch; }\n.css-1b2qb11 { mask-border-repeat: stretch repeat; }\n.css-72231i { mask-border-repeat: repeat repeat; }\n.css-11v2t74 { mask-border-repeat: round repeat; }\n.css-n2mfcv { mask-border-repeat: space repeat; }\n.css-80dslv { mask-border-repeat: stretch round; }\n.css-u3cxuw { mask-border-repeat: repeat round; }\n.css-1jdh0ti { mask-border-repeat: round round; }\n.css-ta3abt { mask-border-repeat: space round; }\n.css-eilhjl { mask-border-repeat: stretch space; }\n.css-13zn4zw { mask-border-repeat: repeat space; }\n.css-19wg9h3 { mask-border-repeat: round space; }\n.css-17fhwq9 { mask-border-repeat: space space; }\n.css-11777h3 { mask-border: url(\"image.png\"); }\n.css-18r8z1k { mask-type: luminance; }\n.css-1pvsio9 { mask-type: alpha; }\n"
  ];
  CSS.make("css-z3n8d4", []);
  CSS.make("css-1dvjp0a", []);
  CSS.make("css-uw2gol", []);
  CSS.make("css-lxe1gh", []);
  CSS.make("css-10to5xt", []);
  CSS.make("css-v54nk3", []);
  CSS.make("css-1snnsa0", []);
  CSS.make("css-1ypt5p", []);
  CSS.make("css-1gm3m6h", []);
  CSS.make("css-1yip9gi", []);
  CSS.make("css-qn4e6j", []);
  CSS.make("css-cdj5g8", []);
  CSS.make("css-1636qdt", []);
  CSS.make("css-eylmim", []);
  CSS.make("css-qd8str", []);
  CSS.make("css-cq0ctl", []);
  CSS.make("css-2ukfkg", []);
  CSS.make("css-xrdjzm", []);
  CSS.make("css-xbc1", []);
  CSS.make("css-1b0mr3s", []);
  CSS.make("css-5ezr8h", []);
  CSS.make("css-fb4qwz", []);
  CSS.make("css-16hz29a", []);
  CSS.make("css-1rtrnhy", []);
  CSS.make("css-k6vz1s", []);
  CSS.make("css-52w0kr", []);
  CSS.make("css-m4a4wy", []);
  CSS.make("css-13odl3r", []);
  CSS.make("css-1cn55ow", []);
  CSS.make("css-1u121op", []);
  CSS.make("css-1v5crnn", []);
  CSS.make("css-yu2key", []);
  CSS.make("css-abqmxb", []);
  CSS.make("css-1yqx3uf", []);
  CSS.make("css-1k8za9y", []);
  CSS.make("css-1ru5dwx", []);
  CSS.make("css-l5yu21", []);
  CSS.make("css-16c9p7o", []);
  CSS.make("css-f5do92", []);
  CSS.make("css-v4vynr", []);
  CSS.make("css-1xmdx0v", []);
  CSS.make("css-1hy2mj4", []);
  CSS.make("css-1wg0ghu", []);
  CSS.make("css-9hvgri", []);
  CSS.make("css-15otve", []);
  CSS.make("css-egl27m", []);
  CSS.make("css-mg9iuz", []);
  CSS.make("css-95syj5", []);
  CSS.make("css-kcdjpy", []);
  CSS.make("css-1vp6ch1", []);
  CSS.make("css-1c9telo", []);
  CSS.make("css-4t2ydq", []);
  CSS.make("css-cxz7hi", []);
  CSS.make("css-1tria9l", []);
  CSS.make("css-br4nhd", []);
  CSS.make("css-19f4xc3", []);
  CSS.make("css-1l9yvv", []);
  CSS.make("css-1fxices", []);
  CSS.make("css-1k23bs7", []);
  CSS.make("css-gnw30p", []);
  CSS.make("css-3c4zy9", []);
  CSS.make("css-wprp1t", []);
  CSS.make("css-18vrowk", []);
  CSS.make("css-1cb2dcf", []);
  CSS.make("css-1u0ht9p", []);
  CSS.make("css-m2fq66", []);
  CSS.make("css-1golpk8", []);
  CSS.make("css-1ot9ekp", []);
  CSS.make("css-m2fq66", []);
  CSS.make("css-1mu4rou", []);
  CSS.make("css-1mv9xga", []);
  CSS.make("css-jx2qa6", []);
  CSS.make("css-1qtzujq", []);
  CSS.make("css-1bhh1lh", []);
  CSS.make("css-11accdw", []);
  CSS.make("css-1ropar4", []);
  CSS.make("css-to8yfu", []);
  CSS.make("css-2x38mp", []);
  CSS.make("css-4jnldj", []);
  CSS.make("css-3ihnj7", []);
  CSS.make("css-1a9zgo9", []);
  CSS.make("css-1qhjvbk", []);
  CSS.make("css-5envxq", []);
  CSS.make("css-o1o9fw", []);
  CSS.make("css-mbf1s5", []);
  CSS.make("css-1z0dkx3", []);
  CSS.make("css-1stlac", []);
  CSS.make("css-1pm4u0i", []);
  CSS.make("css-j575wg", []);
  CSS.make("css-oo5r5s", []);
  CSS.make("css-5onz4r", []);
  CSS.make("css-11z229h", []);
  CSS.make("css-1y5cby0", []);
  CSS.make("css-12prqve", []);
  CSS.make("css-rq72er", []);
  CSS.make("css-1x0ynac", []);
  CSS.make("css-1718ifd", []);
  CSS.make("css-1fub0yk", []);
  CSS.make("css-13pup2k", []);
  CSS.make("css-1wy9pat", []);
  CSS.make("css-1l49bwg", []);
  CSS.make("css-ac7rnh", []);
  CSS.make("css-15negad", []);
  CSS.make("css-l696je", []);
  CSS.make("css-1m2f2uh", []);
  CSS.make("css-1p3mobv", []);
  CSS.make("css-15gtunp", []);
  CSS.make("css-12s7mr2", []);
  CSS.make("css-tzqk82", []);
  CSS.make("css-e4liu2", []);
  CSS.make("css-8870zt", []);
  CSS.make("css-1b2qb11", []);
  CSS.make("css-72231i", []);
  CSS.make("css-11v2t74", []);
  CSS.make("css-n2mfcv", []);
  CSS.make("css-80dslv", []);
  CSS.make("css-u3cxuw", []);
  CSS.make("css-1jdh0ti", []);
  CSS.make("css-ta3abt", []);
  CSS.make("css-eilhjl", []);
  CSS.make("css-13zn4zw", []);
  CSS.make("css-19wg9h3", []);
  CSS.make("css-17fhwq9", []);
  CSS.make("css-11777h3", []);
  CSS.make("css-18r8z1k", []);
  CSS.make("css-1pvsio9", []);
