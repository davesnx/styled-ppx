Comprehensive test for cx2 interpolation with various property types
  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-b8f0pi-test1{width:var(--var-1fwod6p);}"];
  [@css ".css-b8f0pi-test1{height:var(--var-5g6bk9);}"];
  [@css ".css-b8f0pi-test1{min-width:var(--var-1qqvx43);}"];
  [@css ".css-b8f0pi-test1{max-width:var(--var-11faw47);}"];
  [@css ".css-1swajk7-test2{margin-top:var(--var-oy21bt);}"];
  [@css ".css-1swajk7-test2{margin-bottom:var(--var-oy21bt);}"];
  [@css ".css-1swajk7-test2{padding-left:var(--var-1lpa833);}"];
  [@css ".css-1swajk7-test2{padding-right:var(--var-1lpa833);}"];
  [@css ".css-1i6vyy6-test3{gap:var(--var-vh1osb);}"];
  [@css ".css-1i6vyy6-test3{row-gap:var(--var-vh1osb);}"];
  [@css
    ".css-1i6vyy6-test3{-webkit-column-gap:var(--var-vh1osb);column-gap:var(--var-vh1osb);}"
  ];
  [@css ".css-1vzwmoy-test4{color:var(--var-14sye4i);}"];
  [@css ".css-1vzwmoy-test4{background-color:var(--var-14sye4i);}"];
  [@css ".css-1vzwmoy-test4{border-top-color:var(--var-14sye4i);}"];
  [@css ".css-ycpa9s-test5{flex-basis:var(--var-16vl5bp);}"];
  [@css ".css-1knt7y9-test6{grid-row-start:var(--var-1qxvc00);}"];
  [@css ".css-1knt7y9-test6{grid-column-end:var(--var-175omdk);}"];
  [@css ".css-1d6x35p-test7{top:var(--var-1iqysbe);}"];
  [@css ".css-1d6x35p-test7{bottom:var(--var-10dkp5m);}"];
  [@css ".css-1bkxgpr-test8{z-index:var(--var-osv02l);}"];
  [@css ".css-1bezkxi-test9{border-top-width:var(--var-1nwhzbd);}"];
  [@css ".css-1bezkxi-test9{border-width:var(--var-1nwhzbd);}"];
  [@css ".css-zoi7e9-test10{letter-spacing:var(--var-15s0ecx);}"];
  [@css ".css-zoi7e9-test10{word-spacing:var(--var-1m50b62);}"];
  [@css ".css-1dfkyy8-test11{width:var(--var-18c1xss);}"];
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
        ("--var-1fwod6p", CSS.Types.Width.toString(lengthVar)),
        ("--var-5g6bk9", CSS.Types.Height.toString(lengthVar)),
        ("--var-1qqvx43", CSS.Types.MinWidth.toString(lengthVar)),
        ("--var-11faw47", CSS.Types.MaxWidth.toString(lengthVar)),
      ],
    );
  let test2 =
    CSS.make(
      "css-1swajk7-test2",
      [
        ("--var-oy21bt", CSS.Types.Margin.toString(lengthVar)),
        ("--var-1lpa833", CSS.Types.Length.toString(lengthVar)),
      ],
    );
  let test3 =
    CSS.make(
      "css-1i6vyy6-test3",
      [("--var-vh1osb", CSS.Types.Gap.toString(lengthVar))],
    );
  let test4 =
    CSS.make(
      "css-1vzwmoy-test4",
      [("--var-14sye4i", CSS.Types.Color.toString(colorVar))],
    );
  let flexBasisVar = CSS.px(100);
  let test5 =
    CSS.make(
      "css-ycpa9s-test5",
      [("--var-16vl5bp", CSS.Types.FlexBasis.toString(flexBasisVar))],
    );
  let gridLineVar = `auto;
  let test6 =
    CSS.make(
      "css-1knt7y9-test6",
      [
        ("--var-1qxvc00", CSS.Types.GridRowStart.toString(gridLineVar)),
        ("--var-175omdk", CSS.Types.GridColumnEnd.toString(gridLineVar)),
      ],
    );
  let topVar = CSS.px(20);
  let test7 =
    CSS.make(
      "css-1d6x35p-test7",
      [
        ("--var-1iqysbe", CSS.Types.Top.toString(topVar)),
        ("--var-10dkp5m", CSS.Types.Bottom.toString(topVar)),
      ],
    );
  let zIndexVar = `num(10);
  let test8 =
    CSS.make(
      "css-1bkxgpr-test8",
      [("--var-osv02l", CSS.Types.ZIndex.toString(zIndexVar))],
    );
  let borderWidthVar = `medium;
  let test9 =
    CSS.make(
      "css-1bezkxi-test9",
      [("--var-1nwhzbd", CSS.Types.LineWidth.toString(borderWidthVar))],
    );
  let spacingVar = CSS.px(2);
  let test10 =
    CSS.make(
      "css-zoi7e9-test10",
      [
        ("--var-15s0ecx", CSS.Types.LetterSpacing.toString(spacingVar)),
        ("--var-1m50b62", CSS.Types.WordSpacing.toString(spacingVar)),
      ],
    );
  let test11 = width =>
    CSS.make(
      "css-1dfkyy8-test11 css-73nay0-test11 css-tokvmb-test11",
      [("--var-18c1xss", CSS.Types.Width.toString(width))],
    );
