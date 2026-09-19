  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-14ksm7b{color:blue;}"];
  [@css ".css-ggod7l{background-color:green;}"];
  [@css.bindings
    [
      ("Output.cssRule", "cid-feg3n0", "css-14ksm7b"),
      ("Output.classNameWithCss", "cid-wvmpur", "css-ggod7l"),
    ]
  ];
  let className = [%cx "display: block;"];
  let classNameWithMultiLine = [%cx {| display: block; |}];
  let classNameWithArray = [%cx [|cssProperty|]];
  let cssRule = CSS.make("cx-cssRule cid-feg3n0 css-14ksm7b", []);
  let classNameWithCss = [%cx
    [|cssRule, CSS.make("cx-classNameWithCss cid-wvmpur css-ggod7l", [])|]
  ];
