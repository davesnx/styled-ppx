Comprehensive test for cx2 interpolation with various property types
  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --ubj1i5-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --ubj1i5-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --ubj1i5-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --ubj1i5-3{syntax:\"*\";inherits:false;}"];
  [@css "@property --1m3cgby-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1m3cgby-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --64n598-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1r2kd15-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --17kihyh-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1ru2qt3-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1ru2qt3-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --11yi134-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --11yi134-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --fapduw-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --10rpcqh-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --udueyp-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --udueyp-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --5kfx3l-0{syntax:\"*\";inherits:false;}"];
  [@css
    ".css-ubj1i5{width:var(--ubj1i5-0);height:var(--ubj1i5-1);min-width:var(--ubj1i5-2);max-width:var(--ubj1i5-3);}"
  ];
  [@css
    ".css-1m3cgby{margin-top:var(--1m3cgby-0);margin-bottom:var(--1m3cgby-0);padding-left:var(--1m3cgby-1);padding-right:var(--1m3cgby-1);}"
  ];
  [@css
    ".css-64n598{gap:var(--64n598-0);row-gap:var(--64n598-0);-webkit-column-gap:var(--64n598-0);column-gap:var(--64n598-0);}"
  ];
  [@css
    ".css-1r2kd15{color:var(--1r2kd15-0);background-color:var(--1r2kd15-0);border-top-color:var(--1r2kd15-0);}"
  ];
  [@css ".css-17kihyh{flex-basis:var(--17kihyh-0);}"];
  [@css
    ".css-1ru2qt3{grid-row-start:var(--1ru2qt3-0);grid-column-end:var(--1ru2qt3-1);}"
  ];
  [@css ".css-11yi134{top:var(--11yi134-0);bottom:var(--11yi134-1);}"];
  [@css ".css-fapduw{z-index:var(--fapduw-0);}"];
  [@css
    ".css-10rpcqh{border-top-width:var(--10rpcqh-0);border-width:var(--10rpcqh-0);}"
  ];
  [@css
    ".css-udueyp{letter-spacing:var(--udueyp-0);word-spacing:var(--udueyp-1);}"
  ];
  [@css ".css-5kfx3l{width:var(--5kfx3l-0);height:100px;color:red;}"];
  [@css.classes
    [
      ("css-ubj1i5", 18, "Output.test1", "output.ml", 8, 2, 12, 0),
      ("css-1m3cgby", 19, "Output.test2", "output.ml", 16, 2, 20, 0),
      ("css-64n598", 20, "Output.test3", "output.ml", 24, 2, 27, 0),
      ("css-1r2kd15", 21, "Output.test4", "output.ml", 31, 2, 34, 0),
      ("css-17kihyh", 22, "Output.test5", "output.ml", 37, 2, 38, 0),
      ("css-1ru2qt3", 23, "Output.test6", "output.ml", 43, 2, 45, 0),
      ("css-11yi134", 24, "Output.test7", "output.ml", 48, 2, 50, 0),
      ("css-fapduw", 25, "Output.test8", "output.ml", 53, 2, 54, 0),
      ("css-10rpcqh", 26, "Output.test9", "output.ml", 59, 2, 61, 0),
      ("css-udueyp", 27, "Output.test10", "output.ml", 66, 2, 68, 0),
      ("css-5kfx3l", 28, "Output.test11", "output.ml", 71, 2, 74, 0),
    ]
  ];
  [@css.bindings
    [
      ("Output.test1", "css-ubj1i5"),
      ("Output.test2", "css-1m3cgby"),
      ("Output.test3", "css-64n598"),
      ("Output.test4", "css-1r2kd15"),
      ("Output.test5", "css-17kihyh"),
      ("Output.test6", "css-1ru2qt3"),
      ("Output.test7", "css-11yi134"),
      ("Output.test8", "css-fapduw"),
      ("Output.test9", "css-10rpcqh"),
      ("Output.test10", "css-udueyp"),
      ("Output.test11", ""),
    ]
  ];
  let lengthVar = CSS.px(10);
  let colorVar = CSS.red;
  let percentVar = CSS.pct(50.0);
  let autoVar = `auto;
  let test1 =
    CSS.make(
      "css-ubj1i5",
      [
        ("--ubj1i5-0", CSS.Types.Width.toString(lengthVar)),
        ("--ubj1i5-1", CSS.Types.Height.toString(lengthVar)),
        ("--ubj1i5-2", CSS.Types.MinWidth.toString(lengthVar)),
        ("--ubj1i5-3", CSS.Types.MaxWidth.toString(lengthVar)),
      ],
    );
  let test2 =
    CSS.make(
      "css-1m3cgby",
      [
        ("--1m3cgby-0", CSS.Types.Margin.toString(lengthVar)),
        ("--1m3cgby-1", CSS.Types.Length.toString(lengthVar)),
      ],
    );
  let test3 =
    CSS.make(
      "css-64n598",
      [("--64n598-0", CSS.Types.Gap.toString(lengthVar))],
    );
  let test4 =
    CSS.make(
      "css-1r2kd15",
      [("--1r2kd15-0", CSS.Types.Color.toString(colorVar))],
    );
  let flexBasisVar = CSS.px(100);
  let test5 =
    CSS.make(
      "css-17kihyh",
      [("--17kihyh-0", CSS.Types.FlexBasis.toString(flexBasisVar))],
    );
  let gridLineVar = `auto;
  let test6 =
    CSS.make(
      "css-1ru2qt3",
      [
        ("--1ru2qt3-0", CSS.Types.GridRowStart.toString(gridLineVar)),
        ("--1ru2qt3-1", CSS.Types.GridColumnEnd.toString(gridLineVar)),
      ],
    );
  let topVar = CSS.px(20);
  let test7 =
    CSS.make(
      "css-11yi134",
      [
        ("--11yi134-0", CSS.Types.Top.toString(topVar)),
        ("--11yi134-1", CSS.Types.Bottom.toString(topVar)),
      ],
    );
  let zIndexVar = `num(10);
  let test8 =
    CSS.make(
      "css-fapduw",
      [("--fapduw-0", CSS.Types.ZIndex.toString(zIndexVar))],
    );
  let borderWidthVar = `medium;
  let test9 =
    CSS.make(
      "css-10rpcqh",
      [("--10rpcqh-0", CSS.Types.LineWidth.toString(borderWidthVar))],
    );
  let spacingVar = CSS.px(2);
  let test10 =
    CSS.make(
      "css-udueyp",
      [
        ("--udueyp-0", CSS.Types.LetterSpacing.toString(spacingVar)),
        ("--udueyp-1", CSS.Types.WordSpacing.toString(spacingVar)),
      ],
    );
  let test11 = width =>
    CSS.make(
      "css-5kfx3l",
      [("--5kfx3l-0", CSS.Types.Width.toString(width))],
    );
