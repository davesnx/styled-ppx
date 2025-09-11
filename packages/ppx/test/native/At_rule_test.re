let loc = Ppxlib.Location.none;

/* https://www.w3.org/TR/mediaqueries-5 */
let media_query_tests = [
  /* TODO: An extra white space is created at the end of all tests, however this
     is currently patched by a [... |> String.trim] that is applied when rendering
     the media query in [render_media_query] function in [css_to_emotions] file. */
  (
    "(min-width: 33px)",
    [%expr [%cx "@media (min-width: 33px) {}"]],
    [%expr CSS.style([|CSS.media({js|(min-width: 33px)|js}, [||])|])],
  ),
  (
    "(min-width: 33px), (min-width: 13px)",
    [%expr [%cx "@media (min-width: 33px), (min-width: 13px) {}"]],
    [%expr
      CSS.style([|
        CSS.media({js|(min-width: 33px), (min-width: 13px)|js}, [||]),
      |])
    ],
  ),
  (
    "(width >= 33px)",
    [%expr [%cx "@media (width >= 33px) {}"]],
    [%expr CSS.style([|CSS.media({js|(width >= 33px)|js}, [||])|])],
  ),
  (
    "(width <= 33px)",
    [%expr [%cx "@media (width <= 33px) {}"]],
    [%expr CSS.style([|CSS.media({js|(width <= 33px)|js}, [||])|])],
  ),
  (
    "(width < 33px)",
    [%expr [%cx "@media (width < 33px) {}"]],
    [%expr CSS.style([|CSS.media({js|(width < 33px)|js}, [||])|])],
  ),
  (
    "(width > 33px)",
    [%expr [%cx "@media (width > 33px) {}"]],
    [%expr CSS.style([|CSS.media({js|(width > 33px)|js}, [||])|])],
  ),
  (
    "(30em <= width <= 50em)",
    [%expr [%cx "@media (30em <= width <= 50em) {}"]],
    [%expr CSS.style([|CSS.media({js|(30em <= width <= 50em)|js}, [||])|])],
  ),
  (
    "(30em < width < 50em)",
    [%expr [%cx "@media (30em < width < 50em) {}"]],
    [%expr CSS.style([|CSS.media({js|(30em < width < 50em)|js}, [||])|])],
  ),
  (
    "(hover: hover)",
    [%expr [%cx "@media (hover: hover) {}"]],
    [%expr CSS.style([|CSS.media({js|(hover: hover)|js}, [||])|])],
  ),
  (
    "print",
    [%expr [%cx "@media print {}"]],
    [%expr CSS.style([|CSS.media({js|print|js}, [||])|])],
  ),
  (
    "not print",
    [%expr [%cx "@media not print {}"]],
    [%expr CSS.style([|CSS.media({js|not print|js}, [||])|])],
  ),
  (
    "screen and (color))",
    [%expr [%cx "@media screen and (color) {}"]],
    [%expr CSS.style([|CSS.media({js|screen and (color)|js}, [||])|])],
  ),
  (
    "(screen)",
    [%expr [%cx "@media (screen) {}"]],
    [%expr CSS.style([|CSS.media({js|(screen)|js}, [||])|])],
  ),
  (
    "screen, print",
    [%expr [%cx "@media screen, print {}"]],
    [%expr CSS.style([|CSS.media({js|screen, print|js}, [||])|])],
  ),
  (
    "((screen) and (color))",
    [%expr [%cx "@media ((screen) and (color)) {}"]],
    [%expr CSS.style([|CSS.media({js|((screen) and (color))|js}, [||])|])],
  ),
  (
    "not screen and (color)",
    [%expr [%cx "@media not screen and (color) {}"]],
    [%expr CSS.style([|CSS.media({js|not screen and (color)|js}, [||])|])],
  ),
  (
    "(not ((screen) and (color))))",
    [%expr [%cx "@media (not ((screen) and (color))) {}"]],
    [%expr
      CSS.style([|CSS.media({js|(not ((screen) and (color)))|js}, [||])|])
    ],
  ),
  (
    "(hover: hover) and (color)",
    [%expr [%cx "@media (hover: hover) and (color) {}"]],
    [%expr
      CSS.style([|CSS.media({js|(hover: hover) and (color)|js}, [||])|])
    ],
  ),
  (
    "(not (color)) and (not (hover))",
    [%expr [%cx "@media (not (color)) and (not (hover)) {}"]],
    [%expr
      CSS.style([|CSS.media({js|(not (color)) and (not (hover))|js}, [||])|])
    ],
  ),
  (
    "screen and (min-width: 33px) and (max-height: 15rem)",
    [%expr
      [%cx "@media screen and (min-width: 33px) and (max-height: 15rem) {}"]
    ],
    [%expr
      CSS.style([|
        CSS.media(
          {js|screen and (min-width: 33px) and (max-height: 15rem)|js},
          [||],
        ),
      |])
    ],
  ),
  (
    "(all)",
    [%expr [%cx "@media (all) {}"]],
    [%expr CSS.style([|CSS.media({js|(all)|js}, [||])|])],
  ),
  (
    "all and (not (hover))",
    [%expr [%cx "@media all and (not (hover)){}"]],
    [%expr CSS.style([|CSS.media({js|all and (not (hover))|js}, [||])|])],
  ),
  (
    "not all and (monochrome)",
    [%expr [%cx "@media not all and (monochrome) {}"]],
    [%expr CSS.style([|CSS.media({js|not all and (monochrome)|js}, [||])|])],
  ),
  (
    "screen, print and (color)",
    [%expr [%cx "@media screen, print and (color) {}"]],
    [%expr
      CSS.style([|CSS.media({js|screen, print and (color)|js}, [||])|])
    ],
  ),
  (
    "(min-height: 680px), screen and (orientation: portrait)",
    [%expr
      [%cx "@media (min-height: 680px), screen and (orientation: portrait) {}"]
    ],
    [%expr
      CSS.style([|
        CSS.media(
          {js|(min-height: 680px), screen and (orientation: portrait)|js},
          [||],
        ),
      |])
    ],
  ),
  (
    "(not (color)) or (hover)",
    [%expr [%cx "@media (not (color)) or (hover) {}"]],
    [%expr CSS.style([|CSS.media({js|(not (color)) or (hover)|js}, [||])|])],
  ),
  (
    "(max-height: $(wat)",
    [%expr [%cx "@media (max-height: $(wat)) {}"]],
    [%expr
      CSS.style([|
        CSS.media({js|(max-height: |js} ++ wat ++ {js|)|js}, [||]),
      |])
    ],
  ),
  (
    "$(wat)",
    [%expr [%cx "@media $(wat) {}"]],
    [%expr CSS.style([|CSS.media(wat, [||])|])],
  ),
  (
    "@media $(Media.tabletUp) and $(largeDesktopDown)",
    [%expr [%cx "@media $(Media.tabletUp) and $(largeDesktopDown){}"]],
    [%expr
      CSS.style([|
        CSS.media(Media.tabletUp ++ {js| and |js} ++ largeDesktopDown, [||]),
      |])
    ],
  ),
  (
    /* TODO: Function values are not valid values in the media query. */
    "@media (width: calc( 1px + 2px ))",
    [%expr [%cx "@media (width: calc( 1px + 2px )) {}"]],
    [%expr
      CSS.style([|CSS.media({js|(width: calc( 1px + 2px ))|js}, [||])|])
    ],
  ),
];

let keyframe_tests = [
  (
    {|%keyframe "0%, 50%, 3% { color: red } 100% { color: green }"|},
    [%expr [%keyframe "0%, 50%, 3% { color: red } 100% { color: green }"]],
    [%expr
      CSS.keyframes([|
        (0, [|CSS.color(CSS.red)|]),
        (50, [|CSS.color(CSS.red)|]),
        (3, [|CSS.color(CSS.red)|]),
        (100, [|CSS.color(CSS.green)|]),
      |])
    ],
  ),
  (
    {|%keyframe "0% { color: red } 100% { color: green }"|},
    [%expr [%keyframe "{ 0% { color: red } 100% { color: green }}"]],
    [%expr
      CSS.keyframes([|
        (0, [|CSS.color(CSS.red)|]),
        (100, [|CSS.color(CSS.green)|]),
      |])
    ],
  ),
  (
    {|%keyframe "from { color: red } to { color: green }"|},
    [%expr [%keyframe "{ from { color: red } to { color: green }}"]],
    [%expr
      CSS.keyframes([|
        (0, [|CSS.color(CSS.red)|]),
        (100, [|CSS.color(CSS.green)|]),
      |])
    ],
  ),
];

let container_query_tests = [
  (
    "(min-width: 150px)",
    [%expr [%cx "@container (min-width: 150px) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|@container (min-width: 150px)|js}|], [||]),
      |])
    ],
  ),
  (
    "(max-width: 1000px)",
    [%expr [%cx "@container (max-width: 1000px) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|@container (max-width: 1000px)|js}|], [||]),
      |])
    ],
  ),
  (
    "name (width >= 150px)",
    [%expr [%cx "@container name (width >= 150px) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|@container name (width >= 150px)|js}|], [||]),
      |])
    ],
  ),
  (
    "(height >= 150px)",
    [%expr [%cx "@container (height >= 150px) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|@container (height >= 150px)|js}|], [||]),
      |])
    ],
  ),
  (
    "(inline-size >= 150px)",
    [%expr [%cx "@container (inline-size >= 150px) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany(
          [|{js|@container (inline-size >= 150px)|js}|],
          [||],
        ),
      |])
    ],
  ),
  (
    "(block-size >= 150px)",
    [%expr [%cx "@container (block-size >= 150px) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|@container (block-size >= 150px)|js}|], [||]),
      |])
    ],
  ),
  (
    "(aspect-ratio: 1 / 1)",
    [%expr [%cx "@container (aspect-ratio: 1 / 1) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany([|{js|@container (aspect-ratio: 1 / 1)|js}|], [||]),
      |])
    ],
  ),
  (
    "(orientation: portrait)",
    [%expr [%cx "@container (orientation: portrait) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany(
          [|{js|@container (orientation: portrait)|js}|],
          [||],
        ),
      |])
    ],
  ),
  (
    "(width >= 150px) and (orientation: portrait)",
    [%expr [%cx "@container (width >= 150px) and (orientation: portrait) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany(
          [|{js|@container (width >= 150px) and (orientation: portrait)|js}|],
          [||],
        ),
      |])
    ],
  ),
  (
    "name not (width < 150px)",
    [%expr [%cx "@container name not (width < 150px) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany(
          [|{js|@container name not (width < 150px)|js}|],
          [||],
        ),
      |])
    ],
  ),
  (
    "(width >= 150px) or (orientation: portrait)",
    [%expr [%cx "@container (width >= 150px) or (orientation: portrait) {}"]],
    [%expr
      CSS.style([|
        CSS.selectorMany(
          [|{js|@container (width >= 150px) or (orientation: portrait)|js}|],
          [||],
        ),
      |])
    ],
  ),
];

let runner = tests =>
  List.map(
    item => {
      let (title, input, expected) = item;
      test(
        title,
        () => {
          let pp_expr = (ppf, x) =>
            Fmt.pf(ppf, "%S", Ppxlib.Pprintast.string_of_expression(x));
          let check_expr = Alcotest.testable(pp_expr, (==));
          check(~__POS__, check_expr, expected, input);
        },
      );
    },
    tests,
  );

let tests =
  List.concat([
    runner(media_query_tests),
    runner(keyframe_tests),
    runner(container_query_tests),
  ]);
