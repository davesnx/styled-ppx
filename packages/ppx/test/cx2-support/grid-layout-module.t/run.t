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
    ".css-1d7rma { display: grid; }\n.css-dtj0 { display: inline-grid; }\n.css-1uhftp6 { grid-template-columns: none; }\n.css-1d44bgp { grid-template-columns: auto; }\n.css-z1qb94 { grid-template-columns: 100px; }\n.css-f726qx { grid-template-columns: 1fr; }\n.css-x2nmxr { grid-template-columns: 100px 1fr auto; }\n.css-1rpyaos { grid-template-columns: repeat(2, 100px 1fr); }\n.css-hv9q82 { grid-template-columns: repeat(auto-fill, minmax(25ch, 1fr)); }\n.css-w8gmet { grid-template-columns: 10px [col-start] 250px [col-end]; }\n.css-17q21av { grid-template-columns: 200px repeat(auto-fill, 100px) 300px; }\n.css-5h8l4l { grid-template-columns: var(--var-7wrrwo); }\n.css-60hsgl { grid-template-rows: none; }\n.css-1s26n4k { grid-template-rows: auto; }\n.css-1c3w97y { grid-template-rows: 100px; }\n.css-1i7eydw { grid-template-rows: 1fr; }\n.css-1fn96an { grid-template-rows: 100px 1fr auto; }\n.css-zj4dsv { grid-template-rows: repeat(2, 100px 1fr); }\n.css-14y33c4 { grid-template-rows: 100px 1fr max-content minmax(min-content, 1fr); }\n.css-vypf2y { grid-template-rows: 10px [row-start] 250px [row-end]; }\n.css-1fml6gj { grid-template-areas: none; }\n.css-epgzi2 { grid-template-areas: \"articles\"; }\n.css-7r4ecx { grid-template-areas: \"head head\"; }\n.css-qa7pr4 { grid-template-areas: \"head head\" \"nav main\" \"foot ....\"; }\n.css-1uxzvxf { grid-template: none; }\n.css-771on7 { grid-template: auto 1fr auto / auto 1fr; }\n.css-10oo3xq { grid-auto-columns: auto; }\n.css-hvr9bx { grid-auto-columns: 1fr; }\n.css-1lb7q6i { grid-auto-columns: 100px; }\n.css-ms31qq { grid-auto-columns: max-content; }\n.css-4yj56i { grid-auto-columns: minmax(min-content, 1fr); }\n.css-4njln { grid-auto-columns: min-content max-content auto; }\n.css-uh5t06 { grid-auto-columns: 100px 150px 390px; }\n.css-84qlhc { grid-auto-rows: auto; }\n.css-lr7mww { grid-auto-rows: 1fr; }\n.css-55vih4 { grid-auto-rows: 100px; }\n.css-42wuti { grid-auto-rows: 100px 30%; }\n.css-1rlwls4 { grid-auto-rows: 100px 30% 1em; }\n.css-1m0sffo { grid-auto-rows: min-content; }\n.css-1tauyr { grid-auto-rows: minmax(min-content, 1fr); }\n.css-1xk2ioj { grid-auto-rows: min-content max-content auto; }\n.css-1w0dtps { grid-auto-flow: row; }\n.css-1o26r0w { grid-auto-flow: column; }\n.css-11xpt5 { grid-auto-flow: row dense; }\n.css-1qor38p { grid-auto-flow: column dense; }\n.css-1c4exck { grid: auto-flow 1fr / 100px; }\n.css-hcp9rp { grid: none / auto-flow 1fr; }\n.css-1wkm8jy { grid: auto-flow / auto 1fr; }\n.css-1j65ehh { grid: repeat(auto-fill, 5em) / auto-flow 1fr; }\n.css-1qcsksp { grid: auto-flow 1fr / repeat(auto-fill, 5em); }\n.css-1ox68ip { grid: \"H    H \" \"A    B \" \"F    F \" 30px / auto 1fr; }\n.css-1x867ne { grid-row-start: auto; }\n.css-ltm8o1 { grid-row-start: 4; }\n.css-8h24kc { grid-row-start: C; }\n.css-15fe4em { grid-row-start: C 2; }\n.css-7cf6l0 { grid-row-start: span C; }\n.css-1v0u1fc { grid-row-start: span 1; }\n.css-10w33qd { grid-column-start: auto; }\n.css-1o4gye9 { grid-column-start: 4; }\n.css-11da55r { grid-column-start: C; }\n.css-1k2cren { grid-column-start: C 2; }\n.css-1xmllie { grid-column-start: span C; }\n.css-xy0wol { grid-column-start: span 1; }\n.css-1eg93b9 { grid-row-end: auto; }\n.css-1nhidt8 { grid-row-end: 4; }\n.css-1qkm6w { grid-row-end: C; }\n.css-1ew8pwq { grid-row-end: C 2; }\n.css-auhk73 { grid-row-end: span C; }\n.css-12teouq { grid-row-end: span 1; }\n.css-y253vc { grid-column-end: auto; }\n.css-ux9u00 { grid-column-end: 4; }\n.css-mdxj7x { grid-column-end: C; }\n.css-1qqijkw { grid-column-end: C 2; }\n.css-15xdswy { grid-column-end: span C; }\n.css-ikvv6w { grid-column-end: span 1; }\n.css-j7l155 { grid-column: auto; }\n.css-skd36z { grid-column: 1; }\n.css-74kfdf { grid-column: -1; }\n.css-1afkk5z { grid-column: 1 / 1; }\n.css-1jmdi84 { grid-column: 1 / -1; }\n.css-3qzffg { grid-column: auto / auto; }\n.css-1l7gqrj { grid-column: 2 / span 2; }\n.css-6b3dv4 { grid-row: auto; }\n.css-4mta9i { grid-row: 1; }\n.css-1dg308t { grid-row: -1; }\n.css-rogeog { grid-row: 1 / 1; }\n.css-1ney71n { grid-row: 1 / -1; }\n.css-1yql881 { grid-row: auto / auto; }\n.css-4iq44b { grid-row: 2 / span 2; }\n.css-gjzd4g { grid-area: 1 / 1; }\n.css-48iwih { grid-area: var(--var-1l7l92x); }\n.css-3gxo8c { grid-area: 1 / span 1; }\n.css-z8rhft { grid-area: span 1 / 10 / -1; }\n.css-1p8f0m4 { grid-column-gap: 0; }\n.css-1h04h3p { grid-column-gap: 1em; }\n.css-1i4xhml { grid-row-gap: 0; }\n.css-e4owdl { grid-row-gap: 1em; }\n.css-1fhkstl { grid-gap: 0 0; }\n.css-1qsh2vu { grid-gap: 0 1em; }\n.css-1r7ztoi { grid-gap: 1em; }\n.css-1bxmqm3 { grid-gap: 1em 1em; }\n.css-gpuv4i { grid-template-columns: subgrid; }\n.css-55c3bh { grid-template-columns: subgrid [sub-a]; }\n.css-bq5qj5 { grid-template-columns: subgrid [sub-a] [sub-b]; }\n.css-rzamxl { grid-template-columns: subgrid repeat(1, [sub-a]); }\n.css-12t908s { grid-template-columns: subgrid repeat(2, [sub-a] [sub-b]) [sub-c]; }\n.css-ysrlu5 { grid-template-columns: subgrid repeat(auto-fill, [sub-a] [sub-b]); }\n.css-cfexw1 { grid-template-rows: subgrid; }\n.css-f5bbxp { grid-template-rows: subgrid [sub-a]; }\n.css-10mrpul { grid-template-rows: subgrid [sub-a] [sub-b]; }\n.css-192pdbj { grid-template-rows: subgrid repeat(1, [sub-a]); }\n.css-1vr5591 { grid-template-rows: subgrid repeat(2, [sub-a] [sub-b]) [sub-c]; }\n.css-3gk74e { grid-template-rows: subgrid repeat(auto-fill, [sub-a] [sub-b]); }\n.css-1ibv6em { grid-template-columns: masonry; }\n.css-oub0h8 { grid-template-rows: masonry ; }\n.css-1vwyy2s { masonry-auto-flow: pack; }\n.css-1s9y5qm { masonry-auto-flow: next; }\n.css-16h6a02 { masonry-auto-flow: definite-first; }\n.css-90inlv { masonry-auto-flow: ordered; }\n.css-9cp6ve { masonry-auto-flow: pack definite-first; }\n.css-yksl4h { masonry-auto-flow: pack ordered; }\n.css-1d9xtwz { masonry-auto-flow: next definite-first; }\n.css-prv4cj { masonry-auto-flow: next ordered; }\n.css-1ydubsb { masonry-auto-flow: ordered pack; }\n"
  ];
  CSS.make("css-1d7rma", []);
  CSS.make("css-dtj0", []);
  CSS.make("css-1uhftp6", []);
  CSS.make("css-1d44bgp", []);
  CSS.make("css-z1qb94", []);
  CSS.make("css-f726qx", []);
  CSS.make("css-x2nmxr", []);
  CSS.make("css-1rpyaos", []);
  CSS.gridTemplateColumns(
    `tracks([|
      `repeat((
        `num(4),
        [|
          `pxFloat(10.),
          `lineNames({js|[col-start]|js}),
          `pxFloat(250.),
          `lineNames({js|[col-end]|js}),
        |],
      )),
      `pxFloat(10.),
    |]),
  );
  CSS.gridTemplateColumns(
    `tracks([|
      `pxFloat(100.),
      `fr(1.),
      `maxContent,
      `minmax((`minContent, `fr(1.))),
    |]),
  );
  CSS.make("css-hv9q82", []);
  CSS.make("css-w8gmet", []);
  CSS.gridTemplateColumns(
    `tracks([|
      `lineNames({js|[last]|js}),
      `lineNames({js|[first nav-start]|js}),
      `pxFloat(150.),
      `lineNames({js|[main-start]|js}),
      `fr(1.),
    |]),
  );
  CSS.gridTemplateColumns(
    `tracks([|
      `pxFloat(10.),
      `lineNames({js|[col-start]|js}),
      `pxFloat(250.),
      `lineNames({js|[col-end]|js}),
      `pxFloat(10.),
      `lineNames({js|[col-start]|js}),
      `pxFloat(250.),
      `lineNames({js|[col-end]|js}),
      `pxFloat(10.),
    |]),
  );
  CSS.gridTemplateColumns(
    `tracks([|
      `lineNames({js|[a]|js}),
      `auto,
      `lineNames({js|[b]|js}),
      `minmax((`minContent, `fr(1.))),
      `lineNames({js|[b c d]|js}),
      `repeat((`num(2), [|`lineNames({js|[e]|js}), `pxFloat(40.)|])),
      `repeat((`num(5), [|`auto|])),
    |]),
  );
  CSS.make("css-17q21av", []);
  CSS.gridTemplateColumns(
    `tracks([|
      `minmax((`pxFloat(100.), `maxContent)),
      `repeat((`autoFill, [|`pxFloat(200.)|])),
      `percent(20.),
    |]),
  );
  CSS.gridTemplateColumns(
    `tracks([|
      `lineNames({js|[linename1]|js}),
      `pxFloat(100.),
      `lineNames({js|[linename2]|js}),
      `repeat((
        `autoFit,
        [|`lineNames({js|[linename3 linename4]|js}), `pxFloat(300.)|],
      )),
      `pxFloat(100.),
    |]),
  );
  
  CSS.gridTemplateColumns(
    `tracks([|
      `lineNames({js|[linename1 linename2]|js}),
      `pxFloat(100.),
      `repeat((
        `autoFit,
        [|`lineNames({js|[linename1]|js}), `pxFloat(300.)|],
      )),
      `lineNames({js|[linename3]|js}),
    |]),
  );
  let value =
    CSS.tracks([|
      CSS.repeatFn(
        CSS.numInt(4),
        [|
          CSS.pxFloat(10.),
          CSS.lineNames({js|[col-start]|js}),
          CSS.pxFloat(250.),
          CSS.lineNames({js|[col-end]|js}),
        |],
      ),
      CSS.pxFloat(10.),
    |]);
  CSS.make(
    "css-5h8l4l",
    [("--var-7wrrwo", CSS.Types.GridTemplateColumns.toString(value))],
  );
  CSS.make("css-60hsgl", []);
  CSS.make("css-1s26n4k", []);
  CSS.make("css-1c3w97y", []);
  CSS.make("css-1i7eydw", []);
  CSS.make("css-1fn96an", []);
  CSS.make("css-zj4dsv", []);
  CSS.make("css-14y33c4", []);
  CSS.make("css-vypf2y", []);
  CSS.gridTemplateRows(
    `tracks([|
      `lineNames({js|[last]|js}),
      `lineNames({js|[first header-start]|js}),
      `pxFloat(50.),
      `lineNames({js|[main-start]|js}),
      `fr(1.),
      `lineNames({js|[footer-start]|js}),
      `pxFloat(50.),
    |]),
  );
  CSS.make("css-1fml6gj", []);
  CSS.make("css-epgzi2", []);
  CSS.make("css-7r4ecx", []);
  CSS.make("css-qa7pr4", []);
  CSS.make("css-1uxzvxf", []);
  CSS.make("css-771on7", []);
  CSS.gridTemplate(
    `areasRowsColumns((
      [|
        `lineNames({js|[header-top]|js}),
        `area({js|a   a   a|js}),
        `lineNames({js|[header-bottom]|js}),
        `lineNames({js|[main-top]|js}),
        `area({js|b   b   b|js}),
        `fr(1.),
        `lineNames({js|[main-bottom]|js}),
      |],
      [|`auto, `fr(1.), `auto|],
    )),
  );
  CSS.make("css-10oo3xq", []);
  CSS.make("css-hvr9bx", []);
  CSS.make("css-1lb7q6i", []);
  CSS.make("css-ms31qq", []);
  CSS.make("css-4yj56i", []);
  CSS.make("css-4njln", []);
  CSS.make("css-uh5t06", []);
  CSS.gridAutoColumns(
    `trackSizes([|
      `pxFloat(100.),
      `minmax((`pxFloat(100.), `auto)),
      `percent(10.),
      `fr(0.5),
      `fitContent(`pxFloat(400.)),
    |]),
  );
  CSS.make("css-84qlhc", []);
  CSS.make("css-lr7mww", []);
  CSS.make("css-55vih4", []);
  CSS.make("css-42wuti", []);
  CSS.make("css-1rlwls4", []);
  CSS.make("css-1m0sffo", []);
  CSS.make("css-1tauyr", []);
  CSS.make("css-1xk2ioj", []);
  CSS.gridAutoRows(
    `trackSizes([|
      `pxFloat(100.),
      `minmax((`pxFloat(100.), `auto)),
      `percent(10.),
      `fr(0.5),
      `fitContent(`pxFloat(400.)),
    |]),
  );
  CSS.make("css-1w0dtps", []);
  CSS.make("css-1o26r0w", []);
  CSS.make("css-11xpt5", []);
  CSS.make("css-1qor38p", []);
  CSS.make("css-1c4exck", []);
  CSS.make("css-hcp9rp", []);
  CSS.make("css-1wkm8jy", []);
  CSS.make("css-1j65ehh", []);
  CSS.make("css-1qcsksp", []);
  CSS.make("css-1ox68ip", []);
  CSS.make("css-1x867ne", []);
  CSS.make("css-ltm8o1", []);
  CSS.make("css-8h24kc", []);
  CSS.make("css-15fe4em", []);
  CSS.make("css-7cf6l0", []);
  CSS.make("css-1v0u1fc", []);
  CSS.make("css-10w33qd", []);
  CSS.make("css-1o4gye9", []);
  CSS.make("css-11da55r", []);
  CSS.make("css-1k2cren", []);
  CSS.make("css-1xmllie", []);
  CSS.make("css-xy0wol", []);
  CSS.make("css-1eg93b9", []);
  CSS.make("css-1nhidt8", []);
  CSS.make("css-1qkm6w", []);
  CSS.make("css-1ew8pwq", []);
  CSS.make("css-auhk73", []);
  CSS.make("css-12teouq", []);
  CSS.make("css-y253vc", []);
  CSS.make("css-ux9u00", []);
  CSS.make("css-mdxj7x", []);
  CSS.make("css-1qqijkw", []);
  CSS.make("css-15xdswy", []);
  CSS.make("css-ikvv6w", []);
  CSS.make("css-j7l155", []);
  CSS.make("css-skd36z", []);
  CSS.make("css-74kfdf", []);
  CSS.make("css-1afkk5z", []);
  CSS.make("css-1jmdi84", []);
  CSS.make("css-3qzffg", []);
  CSS.make("css-1l7gqrj", []);
  CSS.make("css-6b3dv4", []);
  CSS.make("css-4mta9i", []);
  CSS.make("css-1dg308t", []);
  CSS.make("css-rogeog", []);
  CSS.make("css-1ney71n", []);
  CSS.make("css-1yql881", []);
  CSS.make("css-4iq44b", []);
  CSS.make("css-gjzd4g", []);
  let area = `num(33);
  CSS.make(
    "css-48iwih",
    [("--var-1l7l92x", CSS.Types.GridArea.toString(area))],
  );
  CSS.make("css-3gxo8c", []);
  CSS.make("css-z8rhft", []);
  CSS.make("css-1p8f0m4", []);
  CSS.make("css-1h04h3p", []);
  CSS.make("css-1i4xhml", []);
  CSS.make("css-e4owdl", []);
  CSS.make("css-1fhkstl", []);
  CSS.make("css-1qsh2vu", []);
  CSS.make("css-1r7ztoi", []);
  CSS.make("css-1bxmqm3", []);
  
  CSS.make("css-gpuv4i", []);
  CSS.make("css-55c3bh", []);
  CSS.make("css-bq5qj5", []);
  CSS.make("css-rzamxl", []);
  CSS.make("css-12t908s", []);
  CSS.make("css-ysrlu5", []);
  CSS.gridTemplateColumns(
    `tracks([|
      `subgrid,
      `lineNames({js|[sub-a]|js}),
      `repeat((
        `autoFill,
        [|
          `lineNames({js|[sub-b]|js}),
          `lineNames({js|[sub-c]|js}),
          `lineNames({js|[sub-d]|js}),
        |],
      )),
      `lineNames({js|[sub-e]|js}),
      `repeat((`num(1), [|`lineNames({js|[sub-g]|js})|])),
    |]),
  );
  CSS.make("css-cfexw1", []);
  CSS.make("css-f5bbxp", []);
  CSS.make("css-10mrpul", []);
  CSS.make("css-192pdbj", []);
  CSS.make("css-1vr5591", []);
  CSS.make("css-3gk74e", []);
  CSS.gridTemplateRows(
    `tracks([|
      `subgrid,
      `lineNames({js|[sub-a]|js}),
      `repeat((
        `autoFill,
        [|
          `lineNames({js|[sub-b]|js}),
          `lineNames({js|[sub-c]|js}),
          `lineNames({js|[sub-d]|js}),
        |],
      )),
      `lineNames({js|[sub-e]|js}),
      `repeat((`num(1), [|`lineNames({js|[sub-g]|js})|])),
    |]),
  );
  
  CSS.make("css-1ibv6em", []);
  CSS.make("css-oub0h8", []);
  CSS.make("css-1vwyy2s", []);
  CSS.make("css-1s9y5qm", []);
  CSS.make("css-16h6a02", []);
  CSS.make("css-90inlv", []);
  CSS.make("css-9cp6ve", []);
  CSS.make("css-yksl4h", []);
  CSS.make("css-1d9xtwz", []);
  CSS.make("css-prv4cj", []);
  CSS.make("css-1ydubsb", []);
