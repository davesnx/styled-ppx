  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-1x8xzk1{color:blue;}"];
  [@css ".css-1ebqwxh{background-color:green;}"];
  [@css.classes
    [
      ("css-1x8xzk1", 0, "Output.cssRule", "output.ml", 4, 21, 4, 33),
      ("css-1ebqwxh", 1, "Output.classNameWithCss", "output.ml", 5, 46, 5, 70),
    ]
  ];
  [@css.bindings
    [
      ("Output.cssRule", "css-1x8xzk1"),
      ("Output.classNameWithCss", "css-1ebqwxh"),
    ]
  ];
  let className = [%cx "display: block;"];
  let classNameWithMultiLine = [%cx {| display: block; |}];
  let classNameWithArray = [%cx [|cssProperty|]];
  let cssRule = CSS.make("css-1x8xzk1", []);
  let classNameWithCss = [%cx [|cssRule, CSS.make("css-1ebqwxh", [])|]];
