  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".a-4esm7b{color:blue;}"];
  [@css ".a-39004od7l{background-color:green;}"];
  [@css.bindings
    [
      ("Output.cssRule", "id-feg3n0", "a-4esm7b"),
      ("Output.classNameWithCss", "id-wvmpur", "a-39004od7l"),
    ]
  ];
  let className = [%cx "display: block;"];
  let classNameWithMultiLine = [%cx {| display: block; |}];
  let classNameWithArray = [%cx [|cssProperty|]];
  let cssRule = CSS.make("label:cssRule id-feg3n0 a-4esm7b", []);
  let classNameWithCss = [%cx
    [|cssRule, CSS.make("label:classNameWithCss id-wvmpur a-39004od7l", [])|]
  ];
