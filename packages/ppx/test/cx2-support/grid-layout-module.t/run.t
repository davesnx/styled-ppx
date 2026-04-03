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
    ".css-lgj0h8{display:grid;}\n.css-19rux3o{display:inline-grid;}\n.css-1xsawez{grid-template-columns:none;}\n.css-mod5pp{grid-template-columns:auto;}\n.css-1cmnoai{grid-template-columns:100px;}\n.css-1ez2f7z{grid-template-columns:1fr;}\n.css-1ey77wr{grid-template-columns:100px 1fr auto;}\n.css-k831z1{grid-template-columns:repeat(2, 100px 1fr);}\n.css-djxfq4{grid-template-columns:repeat(auto-fill, minmax(25ch, 1fr));}\n.css-gs16i{grid-template-columns:10px [col-start] 250px [col-end];}\n.css-1v52g5g{grid-template-columns:200px repeat(auto-fill, 100px) 300px;}\n.css-68fuud{grid-template-columns:var(--var-7wrrwo);}\n.css-1p5ongh{grid-template-rows:none;}\n.css-1xkhlg{grid-template-rows:auto;}\n.css-1w8gpmy{grid-template-rows:100px;}\n.css-1t6x5k1{grid-template-rows:1fr;}\n.css-blm4xw{grid-template-rows:100px 1fr auto;}\n.css-1hq639k{grid-template-rows:repeat(2, 100px 1fr);}\n.css-17zs3t3{grid-template-rows:100px 1fr max-content minmax(min-content, 1fr);}\n.css-3ev40g{grid-template-rows:10px [row-start] 250px [row-end];}\n.css-19kvbk0{grid-template-areas:none;}\n.css-hrjsxg{grid-template-areas:\"articles\";}\n.css-2debm2{grid-template-areas:\"head head\";}\n.css-iaajlc{grid-template-areas:\"head head\" \"nav main\" \"foot ....\";}\n.css-rpk02x{grid-template:none;}\n.css-vvof85{grid-template:auto 1fr auto / auto 1fr;}\n.css-fyct2f{grid-auto-columns:auto;}\n.css-na788q{grid-auto-columns:1fr;}\n.css-3wucm7{grid-auto-columns:100px;}\n.css-xmrl89{grid-auto-columns:max-content;}\n.css-mhb58e{grid-auto-columns:minmax(min-content, 1fr);}\n.css-1m0p52j{grid-auto-columns:min-content max-content auto;}\n.css-1yyetth{grid-auto-columns:100px 150px 390px;}\n.css-3sj1cp{grid-auto-rows:auto;}\n.css-4m87mn{grid-auto-rows:1fr;}\n.css-1gcjdl6{grid-auto-rows:100px;}\n.css-1ewn8ka{grid-auto-rows:100px 30%;}\n.css-xgogvi{grid-auto-rows:100px 30% 1em;}\n.css-1jrlx9{grid-auto-rows:min-content;}\n.css-a5vdaf{grid-auto-rows:minmax(min-content, 1fr);}\n.css-1bw2nfb{grid-auto-rows:min-content max-content auto;}\n.css-1x6bia0{grid-auto-flow:row;}\n.css-qdmemo{grid-auto-flow:column;}\n.css-12rrdxo{grid-auto-flow:row dense;}\n.css-o8pbhg{grid-auto-flow:column dense;}\n.css-15smumt{grid:auto-flow 1fr / 100px;}\n.css-10utfa6{grid:none / auto-flow 1fr;}\n.css-1sawvt8{grid:auto-flow / auto 1fr;}\n.css-6uqmta{grid:repeat(auto-fill, 5em) / auto-flow 1fr;}\n.css-ibqq5h{grid:auto-flow 1fr / repeat(auto-fill, 5em);}\n.css-1dx5ht4{grid:\"H    H \" \"A    B \" \"F    F \" 30px / auto 1fr;}\n.css-23zjax{grid-row-start:auto;}\n.css-3bfvhq{grid-row-start:4;}\n.css-k44rsv{grid-row-start:C;}\n.css-3zn6f3{grid-row-start:C 2;}\n.css-1mbss9{grid-row-start:span C;}\n.css-12n8pbd{grid-row-start:span 1;}\n.css-qwrk85{grid-column-start:auto;}\n.css-9s6726{grid-column-start:4;}\n.css-1v57d9e{grid-column-start:C;}\n.css-1lr72n4{grid-column-start:C 2;}\n.css-z01anm{grid-column-start:span C;}\n.css-1in4khj{grid-column-start:span 1;}\n.css-12a2lck{grid-row-end:auto;}\n.css-n8owek{grid-row-end:4;}\n.css-nmst3l{grid-row-end:C;}\n.css-1a6qjrt{grid-row-end:C 2;}\n.css-1d0f9ww{grid-row-end:span C;}\n.css-1x7g46w{grid-row-end:span 1;}\n.css-ftor5z{grid-column-end:auto;}\n.css-1gs2sxp{grid-column-end:4;}\n.css-14jg5bp{grid-column-end:C;}\n.css-3m246j{grid-column-end:C 2;}\n.css-f91mgs{grid-column-end:span C;}\n.css-1c1oa7h{grid-column-end:span 1;}\n.css-ir1t2y{grid-column:auto;}\n.css-dhy4ls{grid-column:1;}\n.css-19dz211{grid-column:-1;}\n.css-1qd5pn{grid-column:1 / 1;}\n.css-180pmo8{grid-column:1 / -1;}\n.css-1f8f0lh{grid-column:auto / auto;}\n.css-1s94k46{grid-column:2 / span 2;}\n.css-1qnrhcf{grid-row:auto;}\n.css-y1eqmj{grid-row:1;}\n.css-1j6msv3{grid-row:-1;}\n.css-bpo7kt{grid-row:1 / 1;}\n.css-lybz7i{grid-row:1 / -1;}\n.css-img6o0{grid-row:auto / auto;}\n.css-g317bb{grid-row:2 / span 2;}\n.css-1s9x97r{grid-area:1 / 1;}\n.css-98twa{grid-area:var(--var-1l7l92x);}\n.css-1furmtw{grid-area:1 / span 1;}\n.css-aq007a{grid-area:span 1 / 10 / -1;}\n.css-dat3cm{grid-column-gap:0;}\n.css-r01ss7{grid-column-gap:1em;}\n.css-1r7vwck{grid-row-gap:0;}\n.css-6se9xb{grid-row-gap:1em;}\n.css-1wuqgkd{grid-gap:0 0;}\n.css-o0qfdq{grid-gap:0 1em;}\n.css-1qb22h1{grid-gap:1em;}\n.css-phizm2{grid-gap:1em 1em;}\n.css-ncl3nx{grid-template-columns:subgrid;}\n.css-5ektzg{grid-template-columns:subgrid [sub-a];}\n.css-29qjfz{grid-template-columns:subgrid [sub-a] [sub-b];}\n.css-44ecjn{grid-template-columns:subgrid repeat(1, [sub-a]);}\n.css-1qi17e0{grid-template-columns:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}\n.css-1mh93ua{grid-template-columns:subgrid repeat(auto-fill, [sub-a] [sub-b]);}\n.css-5fdu2f{grid-template-rows:subgrid;}\n.css-1lryyt1{grid-template-rows:subgrid [sub-a];}\n.css-y4pgnt{grid-template-rows:subgrid [sub-a] [sub-b];}\n.css-1e39v9m{grid-template-rows:subgrid repeat(1, [sub-a]);}\n.css-86hys9{grid-template-rows:subgrid repeat(2, [sub-a] [sub-b]) [sub-c];}\n.css-18ot659{grid-template-rows:subgrid repeat(auto-fill, [sub-a] [sub-b]);}\n.css-1rjo398{grid-template-columns:masonry;}\n.css-9glrzf{grid-template-rows:masonry ;}\n.css-p6owej{masonry-auto-flow:pack;}\n.css-u6wgmu{masonry-auto-flow:next;}\n.css-bjtv39{masonry-auto-flow:definite-first;}\n.css-5kn96u{masonry-auto-flow:ordered;}\n.css-ysl2hz{masonry-auto-flow:pack definite-first;}\n.css-9t7ym7{masonry-auto-flow:pack ordered;}\n.css-14f2buy{masonry-auto-flow:next definite-first;}\n.css-1rxw1v0{masonry-auto-flow:next ordered;}\n.css-nt4l3r{masonry-auto-flow:ordered pack;}\n"
  ];
  
  CSS.make("css-lgj0h8", []);
  CSS.make("css-19rux3o", []);
  CSS.make("css-1xsawez", []);
  CSS.make("css-mod5pp", []);
  CSS.make("css-1cmnoai", []);
  CSS.make("css-1ez2f7z", []);
  CSS.make("css-1ey77wr", []);
  CSS.make("css-k831z1", []);
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
  CSS.make("css-djxfq4", []);
  CSS.make("css-gs16i", []);
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
  CSS.make("css-1v52g5g", []);
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
    "css-68fuud",
    [("--var-7wrrwo", CSS.Types.GridTemplateColumns.toString(value))],
  );
  CSS.make("css-1p5ongh", []);
  CSS.make("css-1xkhlg", []);
  CSS.make("css-1w8gpmy", []);
  CSS.make("css-1t6x5k1", []);
  CSS.make("css-blm4xw", []);
  CSS.make("css-1hq639k", []);
  CSS.make("css-17zs3t3", []);
  CSS.make("css-3ev40g", []);
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
  CSS.make("css-19kvbk0", []);
  CSS.make("css-hrjsxg", []);
  CSS.make("css-2debm2", []);
  CSS.make("css-iaajlc", []);
  CSS.make("css-rpk02x", []);
  CSS.make("css-vvof85", []);
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
  CSS.make("css-fyct2f", []);
  CSS.make("css-na788q", []);
  CSS.make("css-3wucm7", []);
  CSS.make("css-xmrl89", []);
  CSS.make("css-mhb58e", []);
  CSS.make("css-1m0p52j", []);
  CSS.make("css-1yyetth", []);
  CSS.gridAutoColumns(
    `trackSizes([|
      `pxFloat(100.),
      `minmax((`pxFloat(100.), `auto)),
      `percent(10.),
      `fr(0.5),
      `fitContent(`pxFloat(400.)),
    |]),
  );
  CSS.make("css-3sj1cp", []);
  CSS.make("css-4m87mn", []);
  CSS.make("css-1gcjdl6", []);
  CSS.make("css-1ewn8ka", []);
  CSS.make("css-xgogvi", []);
  CSS.make("css-1jrlx9", []);
  CSS.make("css-a5vdaf", []);
  CSS.make("css-1bw2nfb", []);
  CSS.gridAutoRows(
    `trackSizes([|
      `pxFloat(100.),
      `minmax((`pxFloat(100.), `auto)),
      `percent(10.),
      `fr(0.5),
      `fitContent(`pxFloat(400.)),
    |]),
  );
  CSS.make("css-1x6bia0", []);
  CSS.make("css-qdmemo", []);
  CSS.make("css-12rrdxo", []);
  CSS.make("css-o8pbhg", []);
  CSS.make("css-15smumt", []);
  CSS.make("css-10utfa6", []);
  CSS.make("css-1sawvt8", []);
  CSS.make("css-6uqmta", []);
  CSS.make("css-ibqq5h", []);
  CSS.make("css-1dx5ht4", []);
  CSS.make("css-23zjax", []);
  CSS.make("css-3bfvhq", []);
  CSS.make("css-k44rsv", []);
  CSS.make("css-3zn6f3", []);
  CSS.make("css-1mbss9", []);
  CSS.make("css-12n8pbd", []);
  CSS.make("css-qwrk85", []);
  CSS.make("css-9s6726", []);
  CSS.make("css-1v57d9e", []);
  CSS.make("css-1lr72n4", []);
  CSS.make("css-z01anm", []);
  CSS.make("css-1in4khj", []);
  CSS.make("css-12a2lck", []);
  CSS.make("css-n8owek", []);
  CSS.make("css-nmst3l", []);
  CSS.make("css-1a6qjrt", []);
  CSS.make("css-1d0f9ww", []);
  CSS.make("css-1x7g46w", []);
  CSS.make("css-ftor5z", []);
  CSS.make("css-1gs2sxp", []);
  CSS.make("css-14jg5bp", []);
  CSS.make("css-3m246j", []);
  CSS.make("css-f91mgs", []);
  CSS.make("css-1c1oa7h", []);
  CSS.make("css-ir1t2y", []);
  CSS.make("css-dhy4ls", []);
  CSS.make("css-19dz211", []);
  CSS.make("css-1qd5pn", []);
  CSS.make("css-180pmo8", []);
  CSS.make("css-1f8f0lh", []);
  CSS.make("css-1s94k46", []);
  CSS.make("css-1qnrhcf", []);
  CSS.make("css-y1eqmj", []);
  CSS.make("css-1j6msv3", []);
  CSS.make("css-bpo7kt", []);
  CSS.make("css-lybz7i", []);
  CSS.make("css-img6o0", []);
  CSS.make("css-g317bb", []);
  CSS.make("css-1s9x97r", []);
  let area = `num(33);
  CSS.make(
    "css-98twa",
    [("--var-1l7l92x", CSS.Types.GridArea.toString(area))],
  );
  CSS.make("css-1furmtw", []);
  CSS.make("css-aq007a", []);
  CSS.make("css-dat3cm", []);
  CSS.make("css-r01ss7", []);
  CSS.make("css-1r7vwck", []);
  CSS.make("css-6se9xb", []);
  CSS.make("css-1wuqgkd", []);
  CSS.make("css-o0qfdq", []);
  CSS.make("css-1qb22h1", []);
  CSS.make("css-phizm2", []);
  
  CSS.make("css-ncl3nx", []);
  CSS.make("css-5ektzg", []);
  CSS.make("css-29qjfz", []);
  CSS.make("css-44ecjn", []);
  CSS.make("css-1qi17e0", []);
  CSS.make("css-1mh93ua", []);
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
  CSS.make("css-5fdu2f", []);
  CSS.make("css-1lryyt1", []);
  CSS.make("css-y4pgnt", []);
  CSS.make("css-1e39v9m", []);
  CSS.make("css-86hys9", []);
  CSS.make("css-18ot659", []);
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
  
  CSS.make("css-1rjo398", []);
  CSS.make("css-9glrzf", []);
  CSS.make("css-p6owej", []);
  CSS.make("css-u6wgmu", []);
  CSS.make("css-bjtv39", []);
  CSS.make("css-5kn96u", []);
  CSS.make("css-ysl2hz", []);
  CSS.make("css-9t7ym7", []);
  CSS.make("css-14f2buy", []);
  CSS.make("css-1rxw1v0", []);
  CSS.make("css-nt4l3r", []);
