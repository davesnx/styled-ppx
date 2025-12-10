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
  
  CSS.display(`grid);
  CSS.display(`inlineGrid);
  CSS.gridTemplateColumns(`none);
  CSS.gridTemplateColumns(`tracks([|`auto|]));
  CSS.gridTemplateColumns(`tracks([|`pxFloat(100.)|]));
  CSS.gridTemplateColumns(`tracks([|`fr(1.)|]));
  CSS.gridTemplateColumns(`tracks([|`pxFloat(100.), `fr(1.), `auto|]));
  CSS.gridTemplateColumns(
    `tracks([|`repeat((`num(2), [|`pxFloat(100.), `fr(1.)|]))|]),
  );
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
  CSS.gridTemplateColumns(
    `tracks([|`repeat((`autoFill, [|`minmax((`ch(25.), `fr(1.)))|]))|]),
  );
  CSS.gridTemplateColumns(
    `tracks([|
      `lineNames({js|[col-end]|js}),
      `pxFloat(10.),
      `lineNames({js|[col-start]|js}),
      `pxFloat(250.),
    |]),
  );
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
  CSS.gridTemplateColumns(
    `tracks([|
      `pxFloat(200.),
      `repeat((`autoFill, [|`pxFloat(100.)|])),
      `pxFloat(300.),
    |]),
  );
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
  CSS.gridTemplateColumns(value);
  CSS.gridTemplateRows(`none);
  CSS.gridTemplateRows(`tracks([|`auto|]));
  CSS.gridTemplateRows(`tracks([|`pxFloat(100.)|]));
  CSS.gridTemplateRows(`tracks([|`fr(1.)|]));
  CSS.gridTemplateRows(`tracks([|`pxFloat(100.), `fr(1.), `auto|]));
  CSS.gridTemplateRows(
    `tracks([|`repeat((`num(2), [|`pxFloat(100.), `fr(1.)|]))|]),
  );
  CSS.gridTemplateRows(
    `tracks([|
      `pxFloat(100.),
      `fr(1.),
      `maxContent,
      `minmax((`minContent, `fr(1.))),
    |]),
  );
  CSS.gridTemplateRows(
    `tracks([|
      `lineNames({js|[row-end]|js}),
      `pxFloat(10.),
      `lineNames({js|[row-start]|js}),
      `pxFloat(250.),
    |]),
  );
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
  CSS.gridTemplateAreas(`none);
  CSS.gridTemplateAreas(`areas([|{js|articles|js}|]));
  CSS.gridTemplateAreas(`areas([|{js|head head|js}|]));
  CSS.gridTemplateAreas(
    `areas([|{js|head head|js}, {js|nav main|js}, {js|foot ....|js}|]),
  );
  CSS.gridTemplate(`none);
  CSS.gridTemplate(
    `rowsColumns((
      `tracks([|`auto, `fr(1.), `auto|]),
      `tracks([|`auto, `fr(1.)|]),
    )),
  );
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
  CSS.gridAutoColumns(`trackSizes([|`auto|]));
  CSS.gridAutoColumns(`trackSizes([|`fr(1.)|]));
  CSS.gridAutoColumns(`trackSizes([|`pxFloat(100.)|]));
  CSS.gridAutoColumns(`trackSizes([|`maxContent|]));
  CSS.gridAutoColumns(`trackSizes([|`minmax((`minContent, `fr(1.)))|]));
  CSS.gridAutoColumns(`trackSizes([|`minContent, `maxContent, `auto|]));
  CSS.gridAutoColumns(
    `trackSizes([|`pxFloat(100.), `pxFloat(150.), `pxFloat(390.)|]),
  );
  CSS.gridAutoColumns(
    `trackSizes([|
      `pxFloat(100.),
      `minmax((`pxFloat(100.), `auto)),
      `percent(10.),
      `fr(0.5),
      `fitContent(`pxFloat(400.)),
    |]),
  );
  CSS.gridAutoRows(`trackSizes([|`auto|]));
  CSS.gridAutoRows(`trackSizes([|`fr(1.)|]));
  CSS.gridAutoRows(`trackSizes([|`pxFloat(100.)|]));
  CSS.gridAutoRows(`trackSizes([|`pxFloat(100.), `percent(30.)|]));
  CSS.gridAutoRows(`trackSizes([|`pxFloat(100.), `percent(30.), `em(1.)|]));
  CSS.gridAutoRows(`trackSizes([|`minContent|]));
  CSS.gridAutoRows(`trackSizes([|`minmax((`minContent, `fr(1.)))|]));
  CSS.gridAutoRows(`trackSizes([|`minContent, `maxContent, `auto|]));
  CSS.gridAutoRows(
    `trackSizes([|
      `pxFloat(100.),
      `minmax((`pxFloat(100.), `auto)),
      `percent(10.),
      `fr(0.5),
      `fitContent(`pxFloat(400.)),
    |]),
  );
  CSS.gridAutoFlow(`row);
  CSS.gridAutoFlow(`column);
  CSS.gridAutoFlow(`rowDense);
  CSS.gridAutoFlow(`columnDense);
  CSS.gridProperty(
    `autoRows((false, Some([|`fr(1.)|]), `tracks([|`pxFloat(100.)|]))),
  );
  CSS.gridProperty(`autoColumns((`none, false, Some([|`fr(1.)|]))));
  CSS.gridProperty(`autoRows((false, None, `tracks([|`auto, `fr(1.)|]))));
  CSS.gridProperty(
    `autoColumns((
      `tracks([|`repeat((`autoFill, [|`em(5.)|]))|]),
      false,
      Some([|`fr(1.)|]),
    )),
  );
  CSS.gridProperty(
    `autoRows((
      false,
      Some([|`fr(1.)|]),
      `tracks([|`repeat((`autoFill, [|`em(5.)|]))|]),
    )),
  );
  CSS.gridProperty(
    `template(
      `areasRowsColumns((
        [|
          `area({js|H    H |js}),
          `area({js|A    B |js}),
          `area({js|F    F |js}),
          `pxFloat(30.),
        |],
        [|`auto, `fr(1.)|],
      )),
    ),
  );
  CSS.gridRowStart(`auto);
  CSS.gridRowStart(`num(4));
  CSS.gridRowStart(`ident({js|C|js}));
  CSS.gridRowStart(`numIdent((2, {js|C|js})));
  CSS.gridRowStart(`span(`ident({js|C|js})));
  CSS.gridRowStart(`span(`num(1)));
  CSS.gridColumnStart(`auto);
  CSS.gridColumnStart(`num(4));
  CSS.gridColumnStart(`ident({js|C|js}));
  CSS.gridColumnStart(`numIdent((2, {js|C|js})));
  CSS.gridColumnStart(`span(`ident({js|C|js})));
  CSS.gridColumnStart(`span(`num(1)));
  CSS.gridRowEnd(`auto);
  CSS.gridRowEnd(`num(4));
  CSS.gridRowEnd(`ident({js|C|js}));
  CSS.gridRowEnd(`numIdent((2, {js|C|js})));
  CSS.gridRowEnd(`span(`ident({js|C|js})));
  CSS.gridRowEnd(`span(`num(1)));
  CSS.gridColumnEnd(`auto);
  CSS.gridColumnEnd(`num(4));
  CSS.gridColumnEnd(`ident({js|C|js}));
  CSS.gridColumnEnd(`numIdent((2, {js|C|js})));
  CSS.gridColumnEnd(`span(`ident({js|C|js})));
  CSS.gridColumnEnd(`span(`num(1)));
  CSS.gridColumn(`auto);
  CSS.gridColumn(`num(1));
  CSS.gridColumn(`num(-1));
  CSS.gridColumn2(`num(1), `num(1));
  CSS.gridColumn2(`num(1), `num(-1));
  CSS.gridColumn2(`auto, `auto);
  CSS.gridColumn2(`num(2), `span(`num(2)));
  CSS.gridRow(`auto);
  CSS.gridRow(`num(1));
  CSS.gridRow(`num(-1));
  CSS.gridRow2(`num(1), `num(1));
  CSS.gridRow2(`num(1), `num(-1));
  CSS.gridRow2(`auto, `auto);
  CSS.gridRow2(`num(2), `span(`num(2)));
  CSS.gridArea2(`num(1), `num(1));
  let area = `num(33);
  CSS.gridArea(area);
  CSS.gridArea2(`num(1), `span(`num(1)));
  CSS.gridArea3(`span(`num(1)), `num(10), `num(-1));
  CSS.gridColumnGap(`zero);
  CSS.gridColumnGap(`em(1.));
  CSS.gridRowGap(`zero);
  CSS.gridRowGap(`em(1.));
  CSS.gridGap2(~rowGap=`zero, ~columnGap=`zero);
  CSS.gridGap2(~rowGap=`zero, ~columnGap=`em(1.));
  CSS.gridGap(`em(1.));
  CSS.gridGap2(~rowGap=`em(1.), ~columnGap=`em(1.));
  
  CSS.gridTemplateColumns(`tracks([|`subgrid|]));
  CSS.gridTemplateColumns(`tracks([|`subgrid, `lineNames({js|[sub-a]|js})|]));
  CSS.gridTemplateColumns(
    `tracks([|
      `subgrid,
      `lineNames({js|[sub-a]|js}),
      `lineNames({js|[sub-b]|js}),
    |]),
  );
  CSS.gridTemplateColumns(
    `tracks([|
      `subgrid,
      `repeat((`num(1), [|`lineNames({js|[sub-a]|js})|])),
    |]),
  );
  CSS.gridTemplateColumns(
    `tracks([|
      `subgrid,
      `repeat((
        `num(2),
        [|`lineNames({js|[sub-a]|js}), `lineNames({js|[sub-b]|js})|],
      )),
      `lineNames({js|[sub-c]|js}),
    |]),
  );
  CSS.gridTemplateColumns(
    `tracks([|
      `subgrid,
      `repeat((
        `autoFill,
        [|`lineNames({js|[sub-a]|js}), `lineNames({js|[sub-b]|js})|],
      )),
    |]),
  );
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
  CSS.gridTemplateRows(`tracks([|`subgrid|]));
  CSS.gridTemplateRows(`tracks([|`subgrid, `lineNames({js|[sub-a]|js})|]));
  CSS.gridTemplateRows(
    `tracks([|
      `subgrid,
      `lineNames({js|[sub-a]|js}),
      `lineNames({js|[sub-b]|js}),
    |]),
  );
  CSS.gridTemplateRows(
    `tracks([|
      `subgrid,
      `repeat((`num(1), [|`lineNames({js|[sub-a]|js})|])),
    |]),
  );
  CSS.gridTemplateRows(
    `tracks([|
      `subgrid,
      `repeat((
        `num(2),
        [|`lineNames({js|[sub-a]|js}), `lineNames({js|[sub-b]|js})|],
      )),
      `lineNames({js|[sub-c]|js}),
    |]),
  );
  CSS.gridTemplateRows(
    `tracks([|
      `subgrid,
      `repeat((
        `autoFill,
        [|`lineNames({js|[sub-a]|js}), `lineNames({js|[sub-b]|js})|],
      )),
    |]),
  );
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
  
  CSS.gridTemplateColumns(`masonry);
  CSS.gridTemplateRows(`masonry);
  CSS.unsafe({js|masonryAutoFlow|js}, {js|pack|js});
  CSS.unsafe({js|masonryAutoFlow|js}, {js|next|js});
  CSS.unsafe({js|masonryAutoFlow|js}, {js|definite-first|js});
  CSS.unsafe({js|masonryAutoFlow|js}, {js|ordered|js});
  CSS.unsafe({js|masonryAutoFlow|js}, {js|pack definite-first|js});
  CSS.unsafe({js|masonryAutoFlow|js}, {js|pack ordered|js});
  CSS.unsafe({js|masonryAutoFlow|js}, {js|next definite-first|js});
  CSS.unsafe({js|masonryAutoFlow|js}, {js|next ordered|js});
  CSS.unsafe({js|masonryAutoFlow|js}, {js|ordered pack|js});
