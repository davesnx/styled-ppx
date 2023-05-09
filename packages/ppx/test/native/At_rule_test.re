open Alcotest;
open Ppxlib;

let loc = Location.none;

/* https://www.w3.org/TR/mediaqueries-5 */
let media_query_tests = [
  (
    "(min-width: 33px)",
    [%expr [%cx "@media (min-width: 33px) {}"]],
    [%expr
      CssJs.style(. [|CssJs.media(. {js|(min-width: 33px)|js}, [||])|])
    ],
  ),
  (
    "screen and (min-width: 33px) or (max-height: 15rem)",
    [%expr
      [%cx "@media screen and (min-width: 33px) or (max-height: 15rem) {}"]
    ],
    [%expr
      CssJs.style(. [|
        CssJs.media(.
          {js|screen and (min-width: 33px) or (max-height: 15rem)|js},
          [||],
        ),
      |])
    ],
  ),
  (
    "(hover: hover)",
    [%expr [%cx "@media (hover: hover) {}"]],
    [%expr CssJs.style(. [|CssJs.media(. {js|(hover: hover)|js}, [||])|])],
  ),
  (
    "(hover: hover) and (color)",
    [%expr [%cx "@media (hover: hover) and (color) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.media(. {js|(hover: hover) and (color)|js}, [||]),
      |])
    ],
  ),
  (
    "not all and (monochrome)",
    [%expr [%cx "@media not all and (monochrome) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.media(. {js|not all and (monochrome)|js}, [||]),
      |])
    ],
  ),
  (
    "print and (color)",
    [%expr [%cx "@media print and (color) {}"]],
    [%expr
      CssJs.style(. [|CssJs.media(. {js|print and (color)|js}, [||])|])
    ],
  ),
  (
    "(max-height: $(wat)",
    [%expr [%cx "@media (max-height: $(wat)) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.media(. {js|(max-height: |js} ++ wat ++ {js|)|js}, [||]),
      |])
    ],
  ),
  (
    "($(wat))",
    [%expr [%cx "@media ($(wat)) {}"]],
    [%expr
      CssJs.style(. [|CssJs.media(. {js|(|js} ++ wat ++ {js|)|js}, [||])|])
    ],
  ),
  (
    "$(wat)",
    [%expr [%cx "@media $(wat) {}"]],
    [%expr CssJs.style(. [|CssJs.media(. wat, [||])|])],
  ),
  (
    "(max-height: $(wat))",
    [%expr [%cx "@media (max-height: $(wat)) {}"]],
    [%expr
      CssJs.style(. [|
        CssJs.media(. {js|(max-height: |js} ++ wat ++ {js|)|js}, [||]),
      |])
    ],
  ),
  /* Nested is not supported in code-gen
     https://www.w3.org/TR/mediaqueries-5/#media-conditions */
  /* (
       "(not (color)) and (not (hover))",
       [%expr [%cx "@media (not (color)) and (not (hover)) {}"]],
       [%expr CssJs.style(. [|CssJs.media(. {js|((not (color)) and (not (hover))|js}, [||])|])]
     ), */
  /* "@media screen, print and (color) {}" */
];

let keyframe_tests = [
  (
    {|%keyframe "0% { color: red } 100% { color: green }"|},
    [%expr [%keyframe "0% { color: red } 100% { color: green }"]],
    [%expr
      CssJs.keyframes(. [|
        (0, [|CssJs.color(CssJs.red)|]),
        (100, [|CssJs.color(CssJs.green)|]),
      |])
    ],
  ),
  (
    {|%keyframe "0%, 50%, 3% { color: red } 100% { color: green }"|},
    [%expr [%keyframe "0%, 50%, 3% { color: red } 100% { color: green }"]],
    [%expr
      CssJs.keyframes(. [|
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
      CssJs.keyframes(. [|
        (0, [|CssJs.color(CssJs.red)|]),
        (100, [|CssJs.color(CssJs.green)|]),
      |])
    ],
  ),
  (
    {|%keyframe "from { color: red } to { color: green }"|},
    [%expr [%keyframe "{ from { color: red } to { color: green }}"]],
    [%expr
      CssJs.keyframes(. [|
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
