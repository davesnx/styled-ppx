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
    ".css-yj8ia4 { contain: none; }\n.css-1aqz4e7 { contain: strict; }\n.css-zx9v85 { contain: content; }\n.css-1yuvsji { contain: size; }\n.css-17wd0pe { contain: layout; }\n.css-1h2w31f { contain: paint; }\n.css-1sblxyw { contain: size layout; }\n.css-dfscxk { contain: size paint; }\n.css-1vxa2yt { contain: size layout paint; }\n"
  ];
  CSS.make("css-yj8ia4", []);
  CSS.make("css-1aqz4e7", []);
  CSS.make("css-zx9v85", []);
  CSS.make("css-1yuvsji", []);
  CSS.make("css-17wd0pe", []);
  CSS.make("css-1h2w31f", []);
  CSS.make("css-1sblxyw", []);
  CSS.make("css-dfscxk", []);
  CSS.make("css-1vxa2yt", []);
  
  CSS.style([|CSS.width(`cqw(5.))|]);
  CSS.style([|CSS.width(`cqh(5.))|]);
  CSS.style([|CSS.width(`cqi(5.))|]);
  CSS.style([|CSS.width(`cqb(5.))|]);
  CSS.style([|CSS.width(`cqmin(5.))|]);
  CSS.style([|CSS.width(`cqmax(5.))|]);
  CSS.style([|CSS.unsafe({js|containerType|js}, {js|normal|js})|]);
  CSS.style([|CSS.unsafe({js|containerType|js}, {js|size|js})|]);
  CSS.style([|CSS.unsafe({js|containerType|js}, {js|inline-size|js})|]);
  CSS.style([|CSS.unsafe({js|containerName|js}, {js|none|js})|]);
  CSS.style([|CSS.unsafe({js|containerName|js}, {js|x|js})|]);
  CSS.style([|CSS.unsafe({js|containerName|js}, {js|x y|js})|]);
  CSS.style([|CSS.unsafe({js|container|js}, {js|none|js})|]);
  CSS.style([|CSS.unsafe({js|container|js}, {js|x / normal|js})|]);
  CSS.style([|CSS.unsafe({js|container|js}, {js|x / size|js})|]);
  CSS.style([|CSS.unsafe({js|container|js}, {js|x / inline-size|js})|]);
  CSS.style([|CSS.unsafe({js|container|js}, {js|x y / size|js})|]);
