  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css.atoms
    [
      (
        "_a7fCPHFf-",
        ["._a7fCPHFf-{color:blue;}"],
        1,
        0,
        1,
        [("value", "CPHFf-", "val\\07f\\0& | \\0color:blue")],
      ),
      (
        "_a4lfH_5UH",
        ["._a4lfH_5UH{background-color:green;}"],
        1,
        0,
        1,
        [("value", "fH_5UH", "val\\04l\\0& | \\0background-color:green")],
      ),
      (
        "_ikl_ZBUY5",
        [],
        1,
        0,
        0,
        [("id", "_ikl_ZBUY5", "bind\\0\\0Output\\0\\0cssRule\\00")],
      ),
      (
        "_iUXwPu4Eb",
        [],
        1,
        0,
        0,
        [("id", "_iUXwPu4Eb", "bind\\0\\0Output\\0\\0classNameWithCss\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Output.cssRule", "_ikl_ZBUY5 _a7fCPHFf-", "_ikl_ZBUY5"),
      ("Output.classNameWithCss", "_iUXwPu4Eb _a4lfH_5UH", "_iUXwPu4Eb"),
    ]
  ];
  let className = [%cx "display: block;"];
  let classNameWithMultiLine = [%cx {| display: block; |}];
  let classNameWithArray = [%cx [|cssProperty|]];
  let cssRule = CSS.make("_ikl_ZBUY5 _a7fCPHFf-", []);
  let classNameWithCss = [%cx
    [|cssRule, CSS.make("_iUXwPu4Eb _a4lfH_5UH", [])|]
  ];
