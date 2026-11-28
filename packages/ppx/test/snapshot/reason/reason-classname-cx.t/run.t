  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-vdivzk1{color:blue;}"];
  [@css ".css-vdivwxh{background-color:green;}"];
  [@css.classes
    [
      ("css-vdivzk1", 0, "Output.cssRule", "output.ml", 4, 21, 4, 33),
      ("css-vdivwxh", 1, "Output.classNameWithCss", "output.ml", 5, 46, 5, 70),
    ]
  ];
  [@css.bindings
    [
      ("Output.cssRule", "css-vdivzk1"),
      ("Output.classNameWithCss", "css-vdivwxh"),
    ]
  ];
  let className = [%cx "display: block;"];
  let classNameWithMultiLine = [%cx {| display: block; |}];
  let classNameWithArray = [%cx [|cssProperty|]];
  let cssRule = CSS.make("css-vdivzk1", []);
  let classNameWithCss = [%cx [|cssRule, CSS.make("css-vdivwxh", [])|]];
