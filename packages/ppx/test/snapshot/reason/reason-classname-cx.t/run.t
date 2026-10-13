  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "._a_4esm7b{color:blue;}"];
  [@css "._a_39004od7l{background-color:green;}"];
  [@css.bindings
    [
      ("Output.cssRule", "_id_feg3n0", "_a_4esm7b"),
      ("Output.classNameWithCss", "_id_wvmpur", "_a_39004od7l"),
    ]
  ];
  let className = [%cx "display: block;"];
  let classNameWithMultiLine = [%cx {| display: block; |}];
  let classNameWithArray = [%cx [|cssProperty|]];
  let cssRule = CSS.make("label:cssRule _id_feg3n0 _a_4esm7b", []);
  let classNameWithCss = [%cx
    [|cssRule, CSS.make("label:classNameWithCss _id_wvmpur _a_39004od7l", [])|]
  ];
