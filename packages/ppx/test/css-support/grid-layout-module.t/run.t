This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./input.re.ml | refmt --parse ml --print re
  [@ocaml.ppx.context
    {
      tool_name: "ppx_driver",
      include_dirs: [],
      load_path: [],
      open_modules: [],
      for_package: None,
      debug: false,
      use_threads: false,
      use_vmthreads: false,
      recursive_types: false,
      principal: false,
      transparent_modules: false,
      unboxed_types: false,
      unsafe_string: false,
      cookies: [],
    }
  ];
  CssJs.display(`grid);
  CssJs.display(`inlineGrid);
  CssJs.gridTemplateColumns([|`none|]);
  CssJs.gridTemplateColumns([|`auto|]);
  CssJs.gridTemplateColumns([|`pxFloat(100.)|]);
  CssJs.gridTemplateColumns([|`fr(1.)|]);
  CssJs.gridTemplateColumns([|`pxFloat(100.), `fr(1.), `auto|]);
  CssJs.gridTemplateColumns([|
    `repeat((`num(2), [|`pxFloat(100.), `fr(1.)|])),
  |]);
  CssJs.gridTemplateColumns([|
    `repeat((
      `num(4),
      [|
        `pxFloat(10.),
        `name({|[col-start]|}),
        `pxFloat(250.),
        `name({|[col-end]|}),
      |],
    )),
    `pxFloat(10.),
  |]);
  CssJs.gridTemplateColumns([|
    `pxFloat(100.),
    `fr(1.),
    `maxContent,
    `minmax((`minContent, `fr(1.))),
  |]);
  CssJs.gridTemplateColumns([|
    `repeat((`autoFill, [|`minmax((`ch(25.), `fr(1.)))|])),
  |]);
  CssJs.gridTemplateColumns([|
    `name({|[col-end]|}),
    `pxFloat(10.),
    `name({|[col-start]|}),
    `pxFloat(250.),
  |]);
  CssJs.gridTemplateColumns([|
    `name({|[last]|}),
    `name({|[first nav-start]|}),
    `pxFloat(150.),
    `name({|[main-start]|}),
    `fr(1.),
  |]);
  CssJs.gridTemplateColumns([|
    `pxFloat(10.),
    `name({|[col-start]|}),
    `pxFloat(250.),
    `name({|[col-end]|}),
    `pxFloat(10.),
    `name({|[col-start]|}),
    `pxFloat(250.),
    `name({|[col-end]|}),
    `pxFloat(10.),
  |]);
  CssJs.gridTemplateColumns([|
    `name({|[a]|}),
    `auto,
    `name({|[b]|}),
    `minmax((`minContent, `fr(1.))),
    `name({|[b c d]|}),
    `repeat((`num(2), [|`name({|[e]|}), `pxFloat(40.)|])),
    `repeat((`num(5), [|`auto|])),
  |]);
  CssJs.gridTemplateColumns([|
    `pxFloat(200.),
    `repeat((`autoFill, [|`pxFloat(100.)|])),
    `pxFloat(300.),
  |]);
  CssJs.gridTemplateColumns([|
    `minmax((`pxFloat(100.), `maxContent)),
    `repeat((`autoFill, [|`pxFloat(200.)|])),
    `percent(20.),
  |]);
  CssJs.gridTemplateColumns([|
    `name({|[linename1]|}),
    `pxFloat(100.),
    `name({|[linename2]|}),
    `repeat((
      `autoFit,
      [|`name({|[linename3 linename4]|}), `pxFloat(300.)|],
    )),
    `pxFloat(100.),
  |]);
  CssJs.gridTemplateColumns([|
    `name({|[linename1 linename2]|}),
    `pxFloat(100.),
    `repeat((`autoFit, [|`name({|[linename1]|}), `pxFloat(300.)|])),
    `name({|[linename3]|}),
  |]);
  let value = [|
    `repeat((
      `num(4),
      [|
        `pxFloat(10.),
        `name({js|[col-start]|js}),
        `pxFloat(250.),
        `name({js|[col-end]|js}),
      |],
    )),
    `pxFloat(10.),
  |];
  (CssJs.gridTemplateColumns(value): CssJs.rule);
  CssJs.gridTemplateRows([|`none|]);
  CssJs.gridTemplateRows([|`auto|]);
  CssJs.gridTemplateRows([|`pxFloat(100.)|]);
  CssJs.gridTemplateRows([|`fr(1.)|]);
  CssJs.gridTemplateRows([|`pxFloat(100.), `fr(1.), `auto|]);
  CssJs.gridTemplateRows([|
    `repeat((`num(2), [|`pxFloat(100.), `fr(1.)|])),
  |]);
  CssJs.gridTemplateRows([|
    `pxFloat(100.),
    `fr(1.),
    `maxContent,
    `minmax((`minContent, `fr(1.))),
  |]);
  CssJs.gridTemplateRows([|
    `name({|[row-end]|}),
    `pxFloat(10.),
    `name({|[row-start]|}),
    `pxFloat(250.),
  |]);
  CssJs.gridTemplateRows([|
    `name({|[last]|}),
    `name({|[first header-start]|}),
    `pxFloat(50.),
    `name({|[main-start]|}),
    `fr(1.),
    `name({|[footer-start]|}),
    `pxFloat(50.),
  |]);
  CssJs.unsafe({|gridTemplateAreas|}, {|none|});
  CssJs.unsafe({|gridTemplateAreas|}, {|'articles'|});
  CssJs.unsafe({|gridTemplateAreas|}, {|'head head'|});
  CssJs.unsafe({|gridTemplateAreas|}, {|'head head' 'nav main' 'foot ....'|});
  CssJs.unsafe({|gridTemplate|}, {|none|});
  CssJs.unsafe({|gridTemplate|}, {|auto 1fr auto / auto 1fr|});
  CssJs.unsafe(
    {|gridTemplate|},
    {|[header-top] 'a   a   a' [header-bottom] [main-top] 'b   b   b' 1fr [main-bottom] / auto 1fr auto|},
  );
  CssJs.unsafe({|gridAutoColumns|}, {|auto|});
  CssJs.unsafe({|gridAutoColumns|}, {|1fr|});
  CssJs.unsafe({|gridAutoColumns|}, {|100px|});
  CssJs.unsafe({|gridAutoColumns|}, {|max-content|});
  CssJs.unsafe({|gridAutoColumns|}, {|minmax(min-content, 1fr)|});
  CssJs.unsafe({|gridAutoColumns|}, {|min-content max-content auto|});
  CssJs.unsafe({|gridAutoColumns|}, {|100px 150px 390px|});
  CssJs.unsafe(
    {|gridAutoColumns|},
    {|100px minmax(100px, auto) 10% 0.5fr fit-content(400px)|},
  );
  CssJs.unsafe({|gridAutoRows|}, {|auto|});
  CssJs.unsafe({|gridAutoRows|}, {|1fr|});
  CssJs.unsafe({|gridAutoRows|}, {|100px|});
  CssJs.unsafe({|gridAutoRows|}, {|100px 30%|});
  CssJs.unsafe({|gridAutoRows|}, {|100px 30% 1em|});
  CssJs.unsafe({|gridAutoRows|}, {|min-content|});
  CssJs.unsafe({|gridAutoRows|}, {|minmax(min-content, 1fr)|});
  CssJs.unsafe({|gridAutoRows|}, {|min-content max-content auto|});
  CssJs.unsafe(
    {|gridAutoRows|},
    {|100px minmax(100px, auto) 10% 0.5fr fit-content(400px)|},
  );
  CssJs.unsafe({|gridAutoFlow|}, {|row|});
  CssJs.unsafe({|gridAutoFlow|}, {|column|});
  CssJs.unsafe({|gridAutoFlow|}, {|row dense|});
  CssJs.unsafe({|gridAutoFlow|}, {|column dense|});
  CssJs.unsafe({|gridRowStart|}, {|auto|});
  CssJs.unsafe({|gridRowStart|}, {|4|});
  CssJs.unsafe({|gridRowStart|}, {|C|});
  CssJs.unsafe({|gridRowStart|}, {|C 2|});
  CssJs.unsafe({|gridColumnStart|}, {|auto|});
  CssJs.unsafe({|gridColumnStart|}, {|4|});
  CssJs.unsafe({|gridColumnStart|}, {|C|});
  CssJs.unsafe({|gridColumnStart|}, {|C 2|});
  CssJs.unsafe({|gridRowEnd|}, {|auto|});
  CssJs.unsafe({|gridRowEnd|}, {|4|});
  CssJs.unsafe({|gridRowEnd|}, {|C|});
  CssJs.unsafe({|gridRowEnd|}, {|C 2|});
  CssJs.unsafe({|gridColumnEnd|}, {|auto|});
  CssJs.unsafe({|gridColumnEnd|}, {|4|});
  CssJs.unsafe({|gridColumnEnd|}, {|C|});
  CssJs.unsafe({|gridColumnEnd|}, {|C 2|});
  CssJs.unsafe({|gridColumn|}, {|auto|});
  CssJs.unsafe({|gridColumn|}, {|1|});
  CssJs.unsafe({|gridColumn|}, {|-1|});
  CssJs.unsafe({|gridRow|}, {|auto|});
  CssJs.unsafe({|gridRow|}, {|1|});
  CssJs.unsafe({|gridRow|}, {|-1|});
  CssJs.gridColumnGap(`zero);
  CssJs.gridColumnGap(`em(1.));
  CssJs.gridRowGap(`zero);
  CssJs.gridRowGap(`em(1.));
  CssJs.unsafe({|gridGap|}, {|0 0|});
  CssJs.unsafe({|gridGap|}, {|0 1em|});
  CssJs.gridGap(`em(1.));
  CssJs.unsafe({|gridGap|}, {|1em 1em|});
  CssJs.gridTemplateColumns([|`subgrid|]);
  CssJs.gridTemplateColumns([|`subgrid, `name({|[sub-a]|})|]);
  CssJs.gridTemplateColumns([|
    `subgrid,
    `name({|[sub-a]|}),
    `name({|[sub-b]|}),
  |]);
  CssJs.gridTemplateColumns([|
    `subgrid,
    `repeat((`num(1), [|`name({|[sub-a]|})|])),
  |]);
  CssJs.gridTemplateColumns([|
    `subgrid,
    `repeat((`num(2), [|`name({|[sub-a]|}), `name({|[sub-b]|})|])),
    `name({|[sub-c]|}),
  |]);
  CssJs.gridTemplateColumns([|
    `subgrid,
    `repeat((`autoFill, [|`name({|[sub-a]|}), `name({|[sub-b]|})|])),
  |]);
  CssJs.gridTemplateColumns([|
    `subgrid,
    `name({|[sub-a]|}),
    `repeat((
      `autoFill,
      [|`name({|[sub-b]|}), `name({|[sub-c]|}), `name({|[sub-d]|})|],
    )),
    `name({|[sub-e]|}),
    `repeat((`num(1), [|`name({|[sub-g]|})|])),
  |]);
  CssJs.gridTemplateRows([|`subgrid|]);
  CssJs.gridTemplateRows([|`subgrid, `name({|[sub-a]|})|]);
  CssJs.gridTemplateRows([|
    `subgrid,
    `name({|[sub-a]|}),
    `name({|[sub-b]|}),
  |]);
  CssJs.gridTemplateRows([|
    `subgrid,
    `repeat((`num(1), [|`name({|[sub-a]|})|])),
  |]);
  CssJs.gridTemplateRows([|
    `subgrid,
    `repeat((`num(2), [|`name({|[sub-a]|}), `name({|[sub-b]|})|])),
    `name({|[sub-c]|}),
  |]);
  CssJs.gridTemplateRows([|
    `subgrid,
    `repeat((`autoFill, [|`name({|[sub-a]|}), `name({|[sub-b]|})|])),
  |]);
  CssJs.gridTemplateRows([|
    `subgrid,
    `name({|[sub-a]|}),
    `repeat((
      `autoFill,
      [|`name({|[sub-b]|}), `name({|[sub-c]|}), `name({|[sub-d]|})|],
    )),
    `name({|[sub-e]|}),
    `repeat((`num(1), [|`name({|[sub-g]|})|])),
  |]);
