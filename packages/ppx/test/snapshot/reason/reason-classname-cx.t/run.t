  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-14ksm7b-cssRule{color:blue;}"];
  [@css ".css-ggod7l-classNameWithCss{background-color:green;}"];
  [@css.bindings
    [
      ("Output.cssRule", "css-14ksm7b-cssRule"),
      ("Output.classNameWithCss", "css-ggod7l-classNameWithCss"),
    ]
  ];
  let className = [%cx "display: block;"];
  let classNameWithMultiLine = [%cx {| display: block; |}];
  let classNameWithArray = [%cx [|cssProperty|]];
  let cssRule = CSS.make_labeled("cssRule", "css-14ksm7b-cssRule", []);
  let classNameWithCss = [%cx
    [|
      cssRule,
      CSS.make_labeled("classNameWithCss", "css-ggod7l-classNameWithCss", []),
    |]
  ];
