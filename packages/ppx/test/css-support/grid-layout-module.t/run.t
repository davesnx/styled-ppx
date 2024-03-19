This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat >dune-project <<EOF
  > (lang dune 3.10)
  > EOF

  $ cat >dune <<EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx.lib)))
  > EOF

  $ dune build
  File "input.re", line 38, characters 22-35:
  Error: Unbound value externals
  [1]

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
        `name({js|[col-start]|js}),
        `pxFloat(250.),
        `name({js|[col-end]|js}),
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
    `name({js|[col-end]|js}),
    `pxFloat(10.),
    `name({js|[col-start]|js}),
    `pxFloat(250.),
  |]);
  CssJs.gridTemplateColumns([|
    `name({js|[last]|js}),
    `name({js|[first nav-start]|js}),
    `pxFloat(150.),
    `name({js|[main-start]|js}),
    `fr(1.),
  |]);
  CssJs.gridTemplateColumns([|
    `pxFloat(10.),
    `name({js|[col-start]|js}),
    `pxFloat(250.),
    `name({js|[col-end]|js}),
    `pxFloat(10.),
    `name({js|[col-start]|js}),
    `pxFloat(250.),
    `name({js|[col-end]|js}),
    `pxFloat(10.),
  |]);
  CssJs.gridTemplateColumns([|
    `name({js|[a]|js}),
    `auto,
    `name({js|[b]|js}),
    `minmax((`minContent, `fr(1.))),
    `name({js|[b c d]|js}),
    `repeat((`num(2), [|`name({js|[e]|js}), `pxFloat(40.)|])),
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
    `name({js|[linename1]|js}),
    `pxFloat(100.),
    `name({js|[linename2]|js}),
    `repeat((
      `autoFit,
      [|`name({js|[linename3 linename4]|js}), `pxFloat(300.)|],
    )),
    `pxFloat(100.),
  |]);
  CssJs.gridTemplateColumns([|
    `name({js|[linename1 linename2]|js}),
    `pxFloat(100.),
    `repeat((`autoFit, [|`name({js|[linename1]|js}), `pxFloat(300.)|])),
    `name({js|[linename3]|js}),
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
    `name({js|[row-end]|js}),
    `pxFloat(10.),
    `name({js|[row-start]|js}),
    `pxFloat(250.),
  |]);
  CssJs.gridTemplateRows([|
    `name({js|[last]|js}),
    `name({js|[first header-start]|js}),
    `pxFloat(50.),
    `name({js|[main-start]|js}),
    `fr(1.),
    `name({js|[footer-start]|js}),
    `pxFloat(50.),
  |]);
  CssJs.unsafe({js|gridTemplateAreas|js}, {js|none|js});
  CssJs.unsafe({js|gridTemplateAreas|js}, {js|'articles'|js});
  CssJs.unsafe({js|gridTemplateAreas|js}, {js|'head head'|js});
  CssJs.unsafe(
    {js|gridTemplateAreas|js},
    {js|'head head' 'nav main' 'foot ....'|js},
  );
  CssJs.unsafe({js|gridTemplate|js}, {js|none|js});
  CssJs.unsafe({js|gridTemplate|js}, {js|auto 1fr auto / auto 1fr|js});
  CssJs.unsafe(
    {js|gridTemplate|js},
    {js|[header-top] 'a   a   a' [header-bottom] [main-top] 'b   b   b' 1fr [main-bottom] / auto 1fr auto|js},
  );
  CssJs.unsafe({js|gridAutoColumns|js}, {js|auto|js});
  CssJs.unsafe({js|gridAutoColumns|js}, {js|1fr|js});
  CssJs.unsafe({js|gridAutoColumns|js}, {js|100px|js});
  CssJs.unsafe({js|gridAutoColumns|js}, {js|max-content|js});
  CssJs.unsafe({js|gridAutoColumns|js}, {js|minmax(min-content, 1fr)|js});
  CssJs.unsafe({js|gridAutoColumns|js}, {js|min-content max-content auto|js});
  CssJs.unsafe({js|gridAutoColumns|js}, {js|100px 150px 390px|js});
  CssJs.unsafe(
    {js|gridAutoColumns|js},
    {js|100px minmax(100px, auto) 10% 0.5fr fit-content(400px)|js},
  );
  CssJs.unsafe({js|gridAutoRows|js}, {js|auto|js});
  CssJs.unsafe({js|gridAutoRows|js}, {js|1fr|js});
  CssJs.unsafe({js|gridAutoRows|js}, {js|100px|js});
  CssJs.unsafe({js|gridAutoRows|js}, {js|100px 30%|js});
  CssJs.unsafe({js|gridAutoRows|js}, {js|100px 30% 1em|js});
  CssJs.unsafe({js|gridAutoRows|js}, {js|min-content|js});
  CssJs.unsafe({js|gridAutoRows|js}, {js|minmax(min-content, 1fr)|js});
  CssJs.unsafe({js|gridAutoRows|js}, {js|min-content max-content auto|js});
  CssJs.unsafe(
    {js|gridAutoRows|js},
    {js|100px minmax(100px, auto) 10% 0.5fr fit-content(400px)|js},
  );
  CssJs.unsafe({js|gridAutoFlow|js}, {js|row|js});
  CssJs.unsafe({js|gridAutoFlow|js}, {js|column|js});
  CssJs.unsafe({js|gridAutoFlow|js}, {js|row dense|js});
  CssJs.unsafe({js|gridAutoFlow|js}, {js|column dense|js});
  CssJs.unsafe({js|gridRowStart|js}, {js|auto|js});
  CssJs.unsafe({js|gridRowStart|js}, {js|4|js});
  CssJs.unsafe({js|gridRowStart|js}, {js|C|js});
  CssJs.unsafe({js|gridRowStart|js}, {js|C 2|js});
  CssJs.unsafe({js|gridColumnStart|js}, {js|auto|js});
  CssJs.unsafe({js|gridColumnStart|js}, {js|4|js});
  CssJs.unsafe({js|gridColumnStart|js}, {js|C|js});
  CssJs.unsafe({js|gridColumnStart|js}, {js|C 2|js});
  CssJs.unsafe({js|gridRowEnd|js}, {js|auto|js});
  CssJs.unsafe({js|gridRowEnd|js}, {js|4|js});
  CssJs.unsafe({js|gridRowEnd|js}, {js|C|js});
  CssJs.unsafe({js|gridRowEnd|js}, {js|C 2|js});
  CssJs.unsafe({js|gridColumnEnd|js}, {js|auto|js});
  CssJs.unsafe({js|gridColumnEnd|js}, {js|4|js});
  CssJs.unsafe({js|gridColumnEnd|js}, {js|C|js});
  CssJs.unsafe({js|gridColumnEnd|js}, {js|C 2|js});
  CssJs.unsafe({js|gridColumn|js}, {js|auto|js});
  CssJs.unsafe({js|gridColumn|js}, {js|1|js});
  CssJs.unsafe({js|gridColumn|js}, {js|-1|js});
  CssJs.unsafe({js|gridRow|js}, {js|auto|js});
  CssJs.unsafe({js|gridRow|js}, {js|1|js});
  CssJs.unsafe({js|gridRow|js}, {js|-1|js});
  CssJs.gridColumnGap(`zero);
  CssJs.gridColumnGap(`em(1.));
  CssJs.gridRowGap(`zero);
  CssJs.gridRowGap(`em(1.));
  CssJs.unsafe({js|gridGap|js}, {js|0 0|js});
  CssJs.unsafe({js|gridGap|js}, {js|0 1em|js});
  CssJs.gridGap(`em(1.));
  CssJs.unsafe({js|gridGap|js}, {js|1em 1em|js});
  CssJs.gridTemplateColumns([|`subgrid|]);
  CssJs.gridTemplateColumns([|`subgrid, `name({js|[sub-a]|js})|]);
  CssJs.gridTemplateColumns([|
    `subgrid,
    `name({js|[sub-a]|js}),
    `name({js|[sub-b]|js}),
  |]);
  CssJs.gridTemplateColumns([|
    `subgrid,
    `repeat((`num(1), [|`name({js|[sub-a]|js})|])),
  |]);
  CssJs.gridTemplateColumns([|
    `subgrid,
    `repeat((`num(2), [|`name({js|[sub-a]|js}), `name({js|[sub-b]|js})|])),
    `name({js|[sub-c]|js}),
  |]);
  CssJs.gridTemplateColumns([|
    `subgrid,
    `repeat((`autoFill, [|`name({js|[sub-a]|js}), `name({js|[sub-b]|js})|])),
  |]);
  CssJs.gridTemplateColumns([|
    `subgrid,
    `name({js|[sub-a]|js}),
    `repeat((
      `autoFill,
      [|
        `name({js|[sub-b]|js}),
        `name({js|[sub-c]|js}),
        `name({js|[sub-d]|js}),
      |],
    )),
    `name({js|[sub-e]|js}),
    `repeat((`num(1), [|`name({js|[sub-g]|js})|])),
  |]);
  CssJs.gridTemplateRows([|`subgrid|]);
  CssJs.gridTemplateRows([|`subgrid, `name({js|[sub-a]|js})|]);
  CssJs.gridTemplateRows([|
    `subgrid,
    `name({js|[sub-a]|js}),
    `name({js|[sub-b]|js}),
  |]);
  CssJs.gridTemplateRows([|
    `subgrid,
    `repeat((`num(1), [|`name({js|[sub-a]|js})|])),
  |]);
  CssJs.gridTemplateRows([|
    `subgrid,
    `repeat((`num(2), [|`name({js|[sub-a]|js}), `name({js|[sub-b]|js})|])),
    `name({js|[sub-c]|js}),
  |]);
  CssJs.gridTemplateRows([|
    `subgrid,
    `repeat((`autoFill, [|`name({js|[sub-a]|js}), `name({js|[sub-b]|js})|])),
  |]);
  CssJs.gridTemplateRows([|
    `subgrid,
    `name({js|[sub-a]|js}),
    `repeat((
      `autoFill,
      [|
        `name({js|[sub-b]|js}),
        `name({js|[sub-c]|js}),
        `name({js|[sub-d]|js}),
      |],
    )),
    `name({js|[sub-e]|js}),
    `repeat((`num(1), [|`name({js|[sub-g]|js})|])),
  |]);
