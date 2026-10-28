  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ("._a_4esm7b{color:blue;}", "_a_4esm7b", "0,1,0 own", "158", 1, false)];
  [@css
    (
      "._a_390004od7l{background-color:green;}",
      "_a_390004od7l",
      "0,1,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css.bindings
    [
      ("Output.cssRule", "_id_4f3t99", "_a_4esm7b"),
      ("Output.classNameWithCss", "_id_162zgi1", "_a_390004od7l"),
    ]
  ];
  [@css.blocks [(4, "_id_4f3t99", [0]), (5, "_id_162zgi1", [1])]];
  let className = [%cx "display: block;"];
  let classNameWithMultiLine = [%cx {| display: block; |}];
  let classNameWithArray = [%cx [|cssProperty|]];
  let cssRule = CSS.make("label:cssRule _id_4f3t99 _a_4esm7b", []);
  let classNameWithCss = [%cx
    [|
      cssRule,
      CSS.make("label:classNameWithCss _id_162zgi1 _a_390004od7l", []),
    |]
  ];
