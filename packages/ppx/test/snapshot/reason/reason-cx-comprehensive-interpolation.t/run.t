Comprehensive test for cx2 interpolation with various property types
  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
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
  [@css ".css-b8f0pi-test1{width:var(--lengthVar-1fwod6p);}"];
  [@css ".css-b8f0pi-test1{height:var(--lengthVar-5g6bk9);}"];
  [@css ".css-b8f0pi-test1{min-width:var(--lengthVar-1qqvx43);}"];
  [@css ".css-b8f0pi-test1{max-width:var(--lengthVar-11faw47);}"];
  [@css ".css-1swajk7-test2{margin-top:var(--lengthVar-oy21bt);}"];
  [@css ".css-1swajk7-test2{margin-bottom:var(--lengthVar-oy21bt);}"];
  [@css ".css-1swajk7-test2{padding-left:var(--lengthVar-1lpa833);}"];
  [@css ".css-1swajk7-test2{padding-right:var(--lengthVar-1lpa833);}"];
  [@css ".css-1i6vyy6-test3{gap:var(--lengthVar-vh1osb);}"];
  [@css ".css-1i6vyy6-test3{row-gap:var(--lengthVar-vh1osb);}"];
  [@css
    ".css-1i6vyy6-test3{-webkit-column-gap:var(--lengthVar-vh1osb);column-gap:var(--lengthVar-vh1osb);}"
  ];
  [@css ".css-1vzwmoy-test4{color:var(--colorVar-14sye4i);}"];
  [@css ".css-1vzwmoy-test4{background-color:var(--colorVar-14sye4i);}"];
  [@css ".css-1vzwmoy-test4{border-top-color:var(--colorVar-14sye4i);}"];
  [@css ".css-ycpa9s-test5{flex-basis:var(--flexBasisVar-16vl5bp);}"];
  [@css ".css-1knt7y9-test6{grid-row-start:var(--gridLineVar-1qxvc00);}"];
  [@css ".css-1knt7y9-test6{grid-column-end:var(--gridLineVar-175omdk);}"];
  [@css ".css-1d6x35p-test7{top:var(--topVar-1iqysbe);}"];
  [@css ".css-1d6x35p-test7{bottom:var(--topVar-10dkp5m);}"];
  [@css ".css-1bkxgpr-test8{z-index:var(--zIndexVar-osv02l);}"];
  [@css ".css-1bezkxi-test9{border-top-width:var(--borderWidthVar-1nwhzbd);}"];
  [@css ".css-1bezkxi-test9{border-width:var(--borderWidthVar-1nwhzbd);}"];
  [@css ".css-zoi7e9-test10{letter-spacing:var(--spacingVar-15s0ecx);}"];
  [@css ".css-zoi7e9-test10{word-spacing:var(--spacingVar-1m50b62);}"];
  [@css ".css-1dfkyy8-test11{width:var(--width-18c1xss);}"];
  [@css ".css-73nay0-test11{height:100px;}"];
  [@css ".css-tokvmb-test11{color:red;}"];
  [@css.bindings
    [
      ("Output.test1", "css-b8f0pi-test1"),
      ("Output.test2", "css-1swajk7-test2"),
      ("Output.test3", "css-1i6vyy6-test3"),
      ("Output.test4", "css-1vzwmoy-test4"),
      ("Output.test5", "css-ycpa9s-test5"),
      ("Output.test6", "css-1knt7y9-test6"),
      ("Output.test7", "css-1d6x35p-test7"),
      ("Output.test8", "css-1bkxgpr-test8"),
      ("Output.test9", "css-1bezkxi-test9"),
      ("Output.test10", "css-zoi7e9-test10"),
      (
        "Output.test11",
        "css-1dfkyy8-test11 css-73nay0-test11 css-tokvmb-test11",
      ),
    ]
  ];
  let lengthVar = CSS.px(10);
  let colorVar = CSS.red;
  let percentVar = CSS.pct(50.0);
  let autoVar = `auto;
  let test1 =
    CSS.make(
      "css-b8f0pi-test1",
      [
        ("--lengthVar-1fwod6p", CSS.Types.Width.toString(lengthVar)),
        ("--lengthVar-5g6bk9", CSS.Types.Height.toString(lengthVar)),
        ("--lengthVar-1qqvx43", CSS.Types.MinWidth.toString(lengthVar)),
        ("--lengthVar-11faw47", CSS.Types.MaxWidth.toString(lengthVar)),
      ],
    );
  let test2 =
    CSS.make(
      "css-1swajk7-test2",
      [
        ("--lengthVar-oy21bt", CSS.Types.Margin.toString(lengthVar)),
        ("--lengthVar-1lpa833", CSS.Types.Length.toString(lengthVar)),
      ],
    );
  let test3 =
    CSS.make(
      "css-1i6vyy6-test3",
      [("--lengthVar-vh1osb", CSS.Types.Gap.toString(lengthVar))],
    );
  let test4 =
    CSS.make(
      "css-1vzwmoy-test4",
      [("--colorVar-14sye4i", CSS.Types.Color.toString(colorVar))],
    );
  let flexBasisVar = CSS.px(100);
  let test5 =
    CSS.make(
      "css-ycpa9s-test5",
      [
        ("--flexBasisVar-16vl5bp", CSS.Types.FlexBasis.toString(flexBasisVar)),
      ],
    );
  let gridLineVar = `auto;
  let test6 =
    CSS.make(
      "css-1knt7y9-test6",
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
      "css-1d6x35p-test7",
      [
        ("--topVar-1iqysbe", CSS.Types.Top.toString(topVar)),
        ("--topVar-10dkp5m", CSS.Types.Bottom.toString(topVar)),
      ],
    );
  let zIndexVar = `num(10);
  let test8 =
    CSS.make(
      "css-1bkxgpr-test8",
      [("--zIndexVar-osv02l", CSS.Types.ZIndex.toString(zIndexVar))],
    );
  let borderWidthVar = `medium;
  let test9 =
    CSS.make(
      "css-1bezkxi-test9",
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
      "css-zoi7e9-test10",
      [
        ("--spacingVar-15s0ecx", CSS.Types.LetterSpacing.toString(spacingVar)),
        ("--spacingVar-1m50b62", CSS.Types.WordSpacing.toString(spacingVar)),
      ],
    );
  let test11 = width =>
    CSS.make(
      "css-1dfkyy8-test11 css-73nay0-test11 css-tokvmb-test11",
      [("--width-18c1xss", CSS.Types.Width.toString(width))],
    );
