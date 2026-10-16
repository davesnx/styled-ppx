Comprehensive test for cx2 interpolation with various property types
  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --lengthVar-1fwod6p{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-5g6bk9{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-1qqvx43{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-11faw47{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-oy21bt{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-1lpa833{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-vh1osb{syntax:\"*\";inherits:false;}"];
  [@css "@property --colorVar-14sye4i{syntax:\"*\";inherits:false;}"];
  [@css "@property --flexBasisVar-16vl5bp{syntax:\"*\";inherits:false;}"];
  [@css "@property --gridLineVar-1qxvc00{syntax:\"*\";inherits:false;}"];
  [@css "@property --gridLineVar-175omdk{syntax:\"*\";inherits:false;}"];
  [@css "@property --topVar-1iqysbe{syntax:\"*\";inherits:false;}"];
  [@css "@property --topVar-10dkp5m{syntax:\"*\";inherits:false;}"];
  [@css "@property --zIndexVar-osv02l{syntax:\"*\";inherits:false;}"];
  [@css "@property --borderWidthVar-1nwhzbd{syntax:\"*\";inherits:false;}"];
  [@css "@property --spacingVar-15s0ecx{syntax:\"*\";inherits:false;}"];
  [@css "@property --spacingVar-1m50b62{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-18c1xss{syntax:\"*\";inherits:false;}"];
  [@css "._a_ecycn1{width:var(--lengthVar-1fwod6p);}"];
  [@css "._a_6l0uxe{height:var(--lengthVar-5g6bk9);}"];
  [@css "._a_8c71xq{min-width:var(--lengthVar-1qqvx43);}"];
  [@css "._a_881fz4{max-width:var(--lengthVar-11faw47);}"];
  [@css "._a_7p0082cnj{margin-top:var(--lengthVar-oy21bt);}"];
  [@css "._a_7p001svkk{margin-bottom:var(--lengthVar-oy21bt);}"];
  [@css "._a_94002wnd4{padding-left:var(--lengthVar-1lpa833);}"];
  [@css "._a_94004e60a{padding-right:var(--lengthVar-1lpa833);}"];
  [@css
    "._a_6fvyy6{gap:var(--lengthVar-vh1osb);row-gap:var(--lengthVar-vh1osb);-webkit-column-gap:var(--lengthVar-vh1osb);column-gap:var(--lengthVar-vh1osb);}"
  ];
  [@css "._a_4elu6g{color:var(--colorVar-14sye4i);}"];
  [@css "._a_39004b4vw{background-color:var(--colorVar-14sye4i);}"];
  [@css "._a_3hcn4pmfs{border-top-color:var(--colorVar-14sye4i);}"];
  [@css "._a_60001pa9s{flex-basis:var(--flexBasisVar-16vl5bp);}"];
  [@css "._a_6j008pajf{grid-row-start:var(--gridLineVar-1qxvc00);}"];
  [@css "._a_6j001zfv9{grid-column-end:var(--gridLineVar-175omdk);}"];
  [@css "._a_71008nazj{top:var(--topVar-1iqysbe);}"];
  [@css "._a_710011us7{bottom:var(--topVar-10dkp5m);}"];
  [@css "._a_ekxgpr{z-index:var(--zIndexVar-osv02l);}"];
  [@css
    "._a_3hlokzkxi{border-top-width:var(--borderWidthVar-1nwhzbd);border-width:var(--borderWidthVar-1nwhzbd);}"
  ];
  [@css "._a_7id9x9{letter-spacing:var(--spacingVar-15s0ecx);}"];
  [@css "._a_egi5r7{word-spacing:var(--spacingVar-1m50b62);}"];
  [@css "._a_eckyy8{width:var(--width-18c1xss);}"];
  [@css "._a_6lnay0{height:100px;}"];
  [@css "._a_4ekvmb{color:red;}"];
  [@css.bindings
    [
      ("Output.test1", "_id_1jhxcqu", "_a_ecycn1 _a_6l0uxe _a_8c71xq _a_881fz4"),
      (
        "Output.test2",
        "_id_zesghj",
        "_a_7p0082cnj _a_7p001svkk _a_94002wnd4 _a_94004e60a",
      ),
      ("Output.test3", "_id_12rsoz0", "_a_6fvyy6"),
      ("Output.test4", "_id_puktrw", "_a_4elu6g _a_39004b4vw _a_3hcn4pmfs"),
      ("Output.test5", "_id_1nw36ql", "_a_60001pa9s"),
      ("Output.test6", "_id_7ivz4", "_a_6j008pajf _a_6j001zfv9"),
      ("Output.test7", "_id_iq7p3", "_a_71008nazj _a_710011us7"),
      ("Output.test8", "_id_yq2qob", "_a_ekxgpr"),
      ("Output.test9", "_id_1u4o5z6", "_a_3hlokzkxi"),
      ("Output.test10", "_id_1egwgp0", "_a_7id9x9 _a_egi5r7"),
      ("Output.test11", "_id_16lxxsk", "_a_eckyy8 _a_6lnay0 _a_4ekvmb"),
    ]
  ];
  let lengthVar = CSS.px(10);
  let colorVar = CSS.red;
  let percentVar = CSS.pct(50.0);
  let autoVar = `auto;
  let test1 =
    CSS.make(
      "label:test1 _id_1jhxcqu _a_ecycn1 _a_6l0uxe _a_8c71xq _a_881fz4",
      [
        ("--lengthVar-1fwod6p", CSS.Types.Width.toString(lengthVar)),
        ("--lengthVar-5g6bk9", CSS.Types.Height.toString(lengthVar)),
        ("--lengthVar-1qqvx43", CSS.Types.MinWidth.toString(lengthVar)),
        ("--lengthVar-11faw47", CSS.Types.MaxWidth.toString(lengthVar)),
      ],
    );
  let test2 =
    CSS.make(
      "label:test2 _id_zesghj _a_7p0082cnj _a_7p001svkk _a_94002wnd4 _a_94004e60a",
      [
        ("--lengthVar-oy21bt", CSS.Types.Margin.toString(lengthVar)),
        ("--lengthVar-1lpa833", CSS.Types.Length.toString(lengthVar)),
      ],
    );
  let test3 =
    CSS.make(
      "label:test3 _id_12rsoz0 _a_6fvyy6",
      [("--lengthVar-vh1osb", CSS.Types.Gap.toString(lengthVar))],
    );
  let test4 =
    CSS.make(
      "label:test4 _id_puktrw _a_4elu6g _a_39004b4vw _a_3hcn4pmfs",
      [("--colorVar-14sye4i", CSS.Types.Color.toString(colorVar))],
    );
  let flexBasisVar = CSS.px(100);
  let test5 =
    CSS.make(
      "label:test5 _id_1nw36ql _a_60001pa9s",
      [
        ("--flexBasisVar-16vl5bp", CSS.Types.FlexBasis.toString(flexBasisVar)),
      ],
    );
  let gridLineVar = `auto;
  let test6 =
    CSS.make(
      "label:test6 _id_7ivz4 _a_6j008pajf _a_6j001zfv9",
      [
        ("--gridLineVar-1qxvc00", CSS.Types.GridRowStart.toString(gridLineVar)),
        (
          "--gridLineVar-175omdk",
          CSS.Types.GridColumnEnd.toString(gridLineVar),
        ),
      ],
    );
  let topVar = CSS.px(20);
  let test7 =
    CSS.make(
      "label:test7 _id_iq7p3 _a_71008nazj _a_710011us7",
      [
        ("--topVar-1iqysbe", CSS.Types.Top.toString(topVar)),
        ("--topVar-10dkp5m", CSS.Types.Bottom.toString(topVar)),
      ],
    );
  let zIndexVar = `num(10);
  let test8 =
    CSS.make(
      "label:test8 _id_yq2qob _a_ekxgpr",
      [("--zIndexVar-osv02l", CSS.Types.ZIndex.toString(zIndexVar))],
    );
  let borderWidthVar = `medium;
  let test9 =
    CSS.make(
      "label:test9 _id_1u4o5z6 _a_3hlokzkxi",
      [
        (
          "--borderWidthVar-1nwhzbd",
          CSS.Types.LineWidth.toString(borderWidthVar),
        ),
      ],
    );
  let spacingVar = CSS.px(2);
  let test10 =
    CSS.make(
      "label:test10 _id_1egwgp0 _a_7id9x9 _a_egi5r7",
      [
        ("--spacingVar-15s0ecx", CSS.Types.LetterSpacing.toString(spacingVar)),
        ("--spacingVar-1m50b62", CSS.Types.WordSpacing.toString(spacingVar)),
      ],
    );
  let test11 = width =>
    CSS.make(
      "label:test11 _id_16lxxsk _a_eckyy8 _a_6lnay0 _a_4ekvmb",
      [("--width-18c1xss", CSS.Types.Width.toString(width))],
    );
