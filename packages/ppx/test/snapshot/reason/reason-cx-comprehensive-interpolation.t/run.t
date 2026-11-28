Comprehensive test for cx2 interpolation with various property types
  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --vdiv2nw{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivbou{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivaxb{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdiva8a{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdiv5ng{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdiv35s{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivqz3{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivumo{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivxlv{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivg0m{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivkrh{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdiv3mh{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivn0v{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivfyq{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdiv62f{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdiv5sa{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivz3l{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivv8w{syntax:\"*\";inherits:false;}"];
  [@css
    ".css-vdiv3lc{width:var(--vdiv2nw);height:var(--vdivbou);min-width:var(--vdivaxb);max-width:var(--vdiva8a);}"
  ];
  [@css
    ".css-vdiv4td{margin-top:var(--vdiv5ng);margin-bottom:var(--vdiv5ng);padding-left:var(--vdiv35s);padding-right:var(--vdiv35s);}"
  ];
  [@css
    ".css-vdivsce{gap:var(--vdivqz3);row-gap:var(--vdivqz3);-webkit-column-gap:var(--vdivqz3);column-gap:var(--vdivqz3);}"
  ];
  [@css
    ".css-vdivjqe{color:var(--vdivumo);background-color:var(--vdivumo);border-top-color:var(--vdivumo);}"
  ];
  [@css ".css-vdivh1q{flex-basis:var(--vdivxlv);}"];
  [@css
    ".css-vdivcez{grid-row-start:var(--vdivg0m);grid-column-end:var(--vdivkrh);}"
  ];
  [@css ".css-vdiv1kg{top:var(--vdiv3mh);bottom:var(--vdivn0v);}"];
  [@css ".css-vdivooe{z-index:var(--vdivfyq);}"];
  [@css
    ".css-vdivwdj{border-top-width:var(--vdiv62f);border-width:var(--vdiv62f);}"
  ];
  [@css
    ".css-vdivkrp{letter-spacing:var(--vdiv5sa);word-spacing:var(--vdivz3l);}"
  ];
  [@css ".css-vdivlre{width:var(--vdivv8w);height:100px;color:red;}"];
  [@css.classes
    [
      ("css-vdiv3lc", 18, "Output.test1", "output.ml", 8, 2, 12, 0),
      ("css-vdiv4td", 19, "Output.test2", "output.ml", 16, 2, 20, 0),
      ("css-vdivsce", 20, "Output.test3", "output.ml", 24, 2, 27, 0),
      ("css-vdivjqe", 21, "Output.test4", "output.ml", 31, 2, 34, 0),
      ("css-vdivh1q", 22, "Output.test5", "output.ml", 37, 2, 38, 0),
      ("css-vdivcez", 23, "Output.test6", "output.ml", 43, 2, 45, 0),
      ("css-vdiv1kg", 24, "Output.test7", "output.ml", 48, 2, 50, 0),
      ("css-vdivooe", 25, "Output.test8", "output.ml", 53, 2, 54, 0),
      ("css-vdivwdj", 26, "Output.test9", "output.ml", 59, 2, 61, 0),
      ("css-vdivkrp", 27, "Output.test10", "output.ml", 66, 2, 68, 0),
      ("css-vdivlre", 28, "Output.test11", "output.ml", 71, 2, 74, 0),
    ]
  ];
  [@css.bindings
    [
      ("Output.test1", "css-vdiv3lc"),
      ("Output.test2", "css-vdiv4td"),
      ("Output.test3", "css-vdivsce"),
      ("Output.test4", "css-vdivjqe"),
      ("Output.test5", "css-vdivh1q"),
      ("Output.test6", "css-vdivcez"),
      ("Output.test7", "css-vdiv1kg"),
      ("Output.test8", "css-vdivooe"),
      ("Output.test9", "css-vdivwdj"),
      ("Output.test10", "css-vdivkrp"),
      ("Output.test11", ""),
    ]
  ];
  let lengthVar = CSS.px(10);
  let colorVar = CSS.red;
  let percentVar = CSS.pct(50.0);
  let autoVar = `auto;
  let test1 =
    CSS.make(
      "css-vdiv3lc",
      [
        ("--vdiv2nw", CSS.Types.Width.toString(lengthVar)),
        ("--vdivbou", CSS.Types.Height.toString(lengthVar)),
        ("--vdivaxb", CSS.Types.MinWidth.toString(lengthVar)),
        ("--vdiva8a", CSS.Types.MaxWidth.toString(lengthVar)),
      ],
    );
  let test2 =
    CSS.make(
      "css-vdiv4td",
      [
        ("--vdiv5ng", CSS.Types.Margin.toString(lengthVar)),
        ("--vdiv35s", CSS.Types.Length.toString(lengthVar)),
      ],
    );
  let test3 =
    CSS.make(
      "css-vdivsce",
      [("--vdivqz3", CSS.Types.Gap.toString(lengthVar))],
    );
  let test4 =
    CSS.make(
      "css-vdivjqe",
      [("--vdivumo", CSS.Types.Color.toString(colorVar))],
    );
  let flexBasisVar = CSS.px(100);
  let test5 =
    CSS.make(
      "css-vdivh1q",
      [("--vdivxlv", CSS.Types.FlexBasis.toString(flexBasisVar))],
    );
  let gridLineVar = `auto;
  let test6 =
    CSS.make(
      "css-vdivcez",
      [
        ("--vdivg0m", CSS.Types.GridRowStart.toString(gridLineVar)),
        ("--vdivkrh", CSS.Types.GridColumnEnd.toString(gridLineVar)),
      ],
    );
  let topVar = CSS.px(20);
  let test7 =
    CSS.make(
      "css-vdiv1kg",
      [
        ("--vdiv3mh", CSS.Types.Top.toString(topVar)),
        ("--vdivn0v", CSS.Types.Bottom.toString(topVar)),
      ],
    );
  let zIndexVar = `num(10);
  let test8 =
    CSS.make(
      "css-vdivooe",
      [("--vdivfyq", CSS.Types.ZIndex.toString(zIndexVar))],
    );
  let borderWidthVar = `medium;
  let test9 =
    CSS.make(
      "css-vdivwdj",
      [("--vdiv62f", CSS.Types.LineWidth.toString(borderWidthVar))],
    );
  let spacingVar = CSS.px(2);
  let test10 =
    CSS.make(
      "css-vdivkrp",
      [
        ("--vdiv5sa", CSS.Types.LetterSpacing.toString(spacingVar)),
        ("--vdivz3l", CSS.Types.WordSpacing.toString(spacingVar)),
      ],
    );
  let test11 = width =>
    CSS.make(
      "css-vdivlre",
      [("--vdivv8w", CSS.Types.Width.toString(width))],
    );
