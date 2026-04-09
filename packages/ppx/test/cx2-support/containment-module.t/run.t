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
  [@css ".css-2agt40{contain:none;}"];
  [@css ".css-deyisx{contain:strict;}"];
  [@css ".css-1x07x2x{contain:content;}"];
  [@css ".css-eq1cha{contain:size;}"];
  [@css ".css-bzw7cp{contain:layout;}"];
  [@css ".css-52yn5q{contain:paint;}"];
  [@css ".css-j5jwgs{contain:size layout;}"];
  [@css ".css-567zd4{contain:size paint;}"];
  [@css ".css-1ubc7bb{contain:size layout paint;}"];
  
  CSS.make("css-2agt40", []);
  CSS.make("css-deyisx", []);
  CSS.make("css-1x07x2x", []);
  CSS.make("css-eq1cha", []);
  CSS.make("css-bzw7cp", []);
  CSS.make("css-52yn5q", []);
  CSS.make("css-j5jwgs", []);
  CSS.make("css-567zd4", []);
  CSS.make("css-1ubc7bb", []);
  
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
