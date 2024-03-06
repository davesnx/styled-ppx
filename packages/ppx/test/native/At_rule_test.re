open Alcotest;
open Ppxlib;

let loc = Location.none;

/* https://www.w3.org/TR/mediaqueries-5 */
let media_query_tests = [
  /* TODO: An extra white space is created at the end of all tests, however this
     is currently patched by a [... |> String.trim] that is applied when rendering
     the media query in [render_media_query] function in [css_to_emotions] file. */
  (
    "(min-width: 33px)",
    [%expr [%cx "@media (min-width: 33px) {}"]],
    [%expr CssJs.style([|CssJs.media({js|(min-width: 33px)|js}, [||])|])],
  ),
  (
    "(min-width: 33px)",
    [%expr [%cx "@media (min-width: 33px), (min-width: 13px) {}"]],
    [%expr
      CssJs.style([|
        CssJs.media({js|(min-width: 33px), (min-width: 13px)|js}, [||]),
      |])
    ],
  ),
  (
    "(width >= 33px)",
    [%expr [%cx "@media (width >= 33px) {}"]],
    [%expr CssJs.style([|CssJs.media({js|(width >= 33px)|js}, [||])|])],
  ),
  (
    "(width <= 33px)",
    [%expr [%cx "@media (width <= 33px) {}"]],
    [%expr CssJs.style([|CssJs.media({js|(width <= 33px)|js}, [||])|])],
  ),
  (
    "(width < 33px)",
    [%expr [%cx "@media (width < 33px) {}"]],
    [%expr CssJs.style([|CssJs.media({js|(width < 33px)|js}, [||])|])],
  ),
  (
    "(width > 33px)",
    [%expr [%cx "@media (width > 33px) {}"]],
    [%expr CssJs.style([|CssJs.media({js|(width > 33px)|js}, [||])|])],
  ),
  (
    "(30em <= width <= 50em)",
    [%expr [%cx "@media (30em <= width <= 50em) {}"]],
    [%expr
      CssJs.style([|CssJs.media({js|(30em <= width <= 50em)|js}, [||])|])
    ],
  ),
  (
    "(30em < width < 50em)",
    [%expr [%cx "@media (30em < width < 50em) {}"]],
    [%expr
      CssJs.style([|CssJs.media({js|(30em < width < 50em)|js}, [||])|])
    ],
  ),
  (
    "(hover: hover)",
    [%expr [%cx "@media (hover: hover) {}"]],
    [%expr CssJs.style([|CssJs.media({js|(hover: hover)|js}, [||])|])],
  ),
  (
    "print",
    [%expr [%cx "@media print {}"]],
    [%expr CssJs.style([|CssJs.media({js|print|js}, [||])|])],
  ),
  (
    "not print",
    [%expr [%cx "@media not print {}"]],
    [%expr CssJs.style([|CssJs.media({js|not print|js}, [||])|])],
  ),
  (
    "screen and (color))",
    [%expr [%cx "@media screen and (color) {}"]],
    [%expr CssJs.style([|CssJs.media({js|screen and (color)|js}, [||])|])],
  ),
  (
    "(screen)",
    [%expr [%cx "@media (screen) {}"]],
    [%expr CssJs.style([|CssJs.media({js|(screen)|js}, [||])|])],
  ),
  (
    "screen, print",
    [%expr [%cx "@media screen, print {}"]],
    [%expr CssJs.style([|CssJs.media({js|screen, print|js}, [||])|])],
  ),
  (
    "(screen, print)",
    [%expr [%cx "@media (screen, print) {}"]],
    [%expr CssJs.style([|CssJs.media({js|(screen, print)|js}, [||])|])],
  ),
  (
    "(screen and (color))",
    [%expr [%cx "@media (screen and (color)) {}"]],
    [%expr CssJs.style([|CssJs.media({js|(screen and (color))|js}, [||])|])],
  ),
  (
    "not screen and (color)",
    [%expr [%cx "@media not screen and (color) {}"]],
    [%expr
      CssJs.style([|CssJs.media({js|not screen and (color)|js}, [||])|])
    ],
  ),
  (
    "(not (screen and (color))))",
    [%expr [%cx "@media (not (screen and (color))) {}"]],
    [%expr
      CssJs.style([|CssJs.media({js|(not (screen and (color)))|js}, [||])|])
    ],
  ),
  (
    "(hover: hover) and (color)",
    [%expr [%cx "@media (hover: hover) and (color) {}"]],
    [%expr
      CssJs.style([|CssJs.media({js|(hover: hover) and (color)|js}, [||])|])
    ],
  ),
  (
    "(not (color)) and (not (hover))",
    [%expr [%cx "@media (not (color)) and (not (hover)) {}"]],
    [%expr
      CssJs.style([|
        CssJs.media({js|(not (color)) and (not (hover))|js}, [||]),
      |])
    ],
  ),
  (
    "screen and (min-width: 33px) and (max-height: 15rem)",
    [%expr
      [%cx "@media screen and (min-width: 33px) and (max-height: 15rem) {}"]
    ],
    [%expr
      CssJs.style([|
        CssJs.media(
          {js|screen and (min-width: 33px) and (max-height: 15rem)|js},
          [||],
        ),
      |])
    ],
  ),
  (
    "(all)",
    [%expr [%cx "@media (all) {}"]],
    [%expr CssJs.style([|CssJs.media({js|(all)|js}, [||])|])],
  ),
  (
    "all and (not (hover))",
    [%expr [%cx "@media all and (not (hover)){}"]],
    [%expr
      CssJs.style([|CssJs.media({js|all and (not (hover))|js}, [||])|])
    ],
  ),
  (
    "not all and (monochrome)",
    [%expr [%cx "@media not all and (monochrome) {}"]],
    [%expr
      CssJs.style([|CssJs.media({js|not all and (monochrome)|js}, [||])|])
    ],
  ),
  (
    "screen, print and (color)",
    [%expr [%cx "@media screen, print and (color) {}"]],
    [%expr
      CssJs.style([|CssJs.media({js|screen, print and (color)|js}, [||])|])
    ],
  ),
  (
    "(min-height: 680px), screen and (orientation: portrait)",
    [%expr
      [%cx "@media (min-height: 680px), screen and (orientation: portrait) {}"]
    ],
    [%expr
      CssJs.style([|
        CssJs.media(
          {js|(min-height: 680px), screen and (orientation: portrait)|js},
          [||],
        ),
      |])
    ],
  ),
  (
    "(not (color)) or (hover)",
    [%expr [%cx "@media (not (color)) or (hover) {}"]],
    [%expr
      CssJs.style([|CssJs.media({js|(not (color)) or (hover)|js}, [||])|])
    ],
  ),
  (
    "(max-height: $(wat)",
    [%expr [%cx "@media (max-height: $(wat)) {}"]],
    [%expr
      CssJs.style([|
        CssJs.media({js|(max-height: |js} ++ wat ++ {js|)|js}, [||]),
      |])
    ],
  ),
  (
    "$(wat)",
    [%expr [%cx "@media $(wat) {}"]],
    [%expr CssJs.style([|CssJs.media(wat, [||])|])],
  ),
  (
    /* TODO: Function values are not valid values in the media query. */
    "@media (width: calc( 1px + 2px ))",
    [%expr [%cx "@media (width: calc( 1px + 2px )) {}"]],
    [%expr
      CssJs.style([|CssJs.media({js|(width: calc( 1px + 2px ))|js}, [||])|])
    ],
  ),
];

let keyframe_tests = [
  (
    {|%keyframe "0% { color: red } 100% { color: green }"|},
    [%expr [%keyframe "0% { color: red } 100% { color: green }"]],
    [%expr
      CssJs.keyframes([|
        (0, [|CssJs.color(CssJs.red)|]),
        (100, [|CssJs.color(CssJs.green)|]),
      |])
    ],
  ),
  (
    {|%keyframe "0%, 50%, 3% { color: red } 100% { color: green }"|},
    [%expr [%keyframe "0%, 50%, 3% { color: red } 100% { color: green }"]],
    [%expr
      CssJs.keyframes([|
        (0, [|CssJs.color(CssJs.red)|]),
        (50, [|CssJs.color(CssJs.red)|]),
        (3, [|CssJs.color(CssJs.red)|]),
        (100, [|CssJs.color(CssJs.green)|]),
      |])
    ],
  ),
  (
    {|%keyframe "0% { color: red } 100% { color: green }"|},
    [%expr [%keyframe "{ 0% { color: red } 100% { color: green }}"]],
    [%expr
      CssJs.keyframes([|
        (0, [|CssJs.color(CssJs.red)|]),
        (100, [|CssJs.color(CssJs.green)|]),
      |])
    ],
  ),
  (
    {|%keyframe "from { color: red } to { color: green }"|},
    [%expr [%keyframe "{ from { color: red } to { color: green }}"]],
    [%expr
      CssJs.keyframes([|
        (0, [|CssJs.color(CssJs.red)|]),
        (100, [|CssJs.color(CssJs.green)|]),
      |])
    ],
  ),
];

let runner = tests =>
  List.map(
    item => {
      let (title, input, expected) = item;
      test_case(
        title,
        `Quick,
        () => {
          let pp_expr = (ppf, x) =>
            Fmt.pf(ppf, "%S", Pprintast.string_of_expression(x));
          let check_expr = testable(pp_expr, (==));
          check(check_expr, "", expected, input);
        },
      );
    },
    tests,
  );

let tests = List.append(runner(media_query_tests), runner(keyframe_tests));
