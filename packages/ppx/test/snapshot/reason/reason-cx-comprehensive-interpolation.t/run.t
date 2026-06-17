Comprehensive test for cx2 interpolation with various property types
  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-2v7e0k-test1{width:var(--var-1pt7v6j);}"];
  [@css ".css-lbwdj4-test1{height:var(--var-5wbckp);}"];
  [@css ".css-ur6cve-test1{min-width:var(--var-13rmwo7);}"];
  [@css ".css-9nbswy-test1{max-width:var(--var-drd6nb);}"];
  [@css ".css-1h6gv7y-test2{margin-top:var(--var-psro5k);}"];
  [@css ".css-1ojdfmn-test2{margin-bottom:var(--var-1bf96kj);}"];
  [@css ".css-6oe920-test2{padding-left:var(--var-1lashq5);}"];
  [@css ".css-kxyw4-test2{padding-right:var(--var-1ypifud);}"];
  [@css ".css-1j1vt57-test3{gap:var(--var-1q1g206);}"];
  [@css ".css-16533ek-test3{row-gap:var(--var-1bmtwcu);}"];
  [@css
    ".css-aq5h2o-test3{-webkit-column-gap:var(--var-1y2ceoh);column-gap:var(--var-1y2ceoh);}"
  ];
  [@css ".css-4bvljg-test4{color:var(--var-1qud8hh);}"];
  [@css ".css-1e9wc53-test4{background-color:var(--var-17s6q5x);}"];
  [@css ".css-t4dyfi-test4{border-top-color:var(--var-enchlk);}"];
  [@css ".css-ycpa9s-test5{flex-basis:var(--var-16vl5bp);}"];
  [@css ".css-en5xqq-test6{grid-row-start:var(--var-1mlik5c);}"];
  [@css ".css-1vcbsia-test6{grid-column-end:var(--var-17wnchf);}"];
  [@css ".css-rexok8-test7{top:var(--var-7pq2w7);}"];
  [@css ".css-16sky2z-test7{bottom:var(--var-ujz4nu);}"];
  [@css ".css-1bkxgpr-test8{z-index:var(--var-osv02l);}"];
  [@css ".css-1rsi5sr-test9{border-top-width:var(--var-1wr101a);}"];
  [@css ".css-g6afgo-test9{border-width:var(--var-hd5ziv);}"];
  [@css ".css-lbcu38-test10{letter-spacing:var(--var-1jtxlb8);}"];
  [@css ".css-1j0nnnq-test10{word-spacing:var(--var-1s6l74p);}"];
  [@css ".css-1dfkyy8-test11{width:var(--var-18c1xss);}"];
  [@css ".css-73nay0-test11{height:100px;}"];
  [@css ".css-tokvmb-test11{color:red;}"];
  [@css.bindings
    [
      (
        "Output.test1",
        "css-2v7e0k-test1 css-lbwdj4-test1 css-ur6cve-test1 css-9nbswy-test1",
      ),
      (
        "Output.test2",
        "css-1h6gv7y-test2 css-1ojdfmn-test2 css-6oe920-test2 css-kxyw4-test2",
      ),
      ("Output.test3", "css-1j1vt57-test3 css-16533ek-test3 css-aq5h2o-test3"),
      ("Output.test4", "css-4bvljg-test4 css-1e9wc53-test4 css-t4dyfi-test4"),
      ("Output.test5", "css-ycpa9s-test5"),
      ("Output.test6", "css-en5xqq-test6 css-1vcbsia-test6"),
      ("Output.test7", "css-rexok8-test7 css-16sky2z-test7"),
      ("Output.test8", "css-1bkxgpr-test8"),
      ("Output.test9", "css-1rsi5sr-test9 css-g6afgo-test9"),
      ("Output.test10", "css-lbcu38-test10 css-1j0nnnq-test10"),
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
      "css-2v7e0k-test1 css-lbwdj4-test1 css-ur6cve-test1 css-9nbswy-test1",
      [
        ("--var-1pt7v6j", CSS.Types.Width.toString(lengthVar)),
        ("--var-5wbckp", CSS.Types.Height.toString(lengthVar)),
        ("--var-13rmwo7", CSS.Types.MinWidth.toString(lengthVar)),
        ("--var-drd6nb", CSS.Types.MaxWidth.toString(lengthVar)),
      ],
    );
  let test2 =
    CSS.make(
      "css-1h6gv7y-test2 css-1ojdfmn-test2 css-6oe920-test2 css-kxyw4-test2",
      [
        ("--var-psro5k", CSS.Types.Margin.toString(lengthVar)),
        ("--var-1bf96kj", CSS.Types.Margin.toString(lengthVar)),
        ("--var-1lashq5", CSS.Types.Length.toString(lengthVar)),
        ("--var-1ypifud", CSS.Types.Length.toString(lengthVar)),
      ],
    );
  let test3 =
    CSS.make(
      "css-1j1vt57-test3 css-16533ek-test3 css-aq5h2o-test3",
      [
        ("--var-1q1g206", CSS.Types.Gap.toString(lengthVar)),
        ("--var-1bmtwcu", CSS.Types.Gap.toString(lengthVar)),
        ("--var-1y2ceoh", CSS.Types.Gap.toString(lengthVar)),
      ],
    );
  let test4 =
    CSS.make(
      "css-4bvljg-test4 css-1e9wc53-test4 css-t4dyfi-test4",
      [
        ("--var-1qud8hh", CSS.Types.Color.toString(colorVar)),
        ("--var-17s6q5x", CSS.Types.Color.toString(colorVar)),
        ("--var-enchlk", CSS.Types.Color.toString(colorVar)),
      ],
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
      "css-en5xqq-test6 css-1vcbsia-test6",
      [
        ("--var-1mlik5c", CSS.Types.GridRowStart.toString(gridLineVar)),
        ("--var-17wnchf", CSS.Types.GridColumnEnd.toString(gridLineVar)),
      ],
    );
  let topVar = CSS.px(20);
  let test7 =
    CSS.make(
      "css-rexok8-test7 css-16sky2z-test7",
      [
        ("--var-7pq2w7", CSS.Types.Top.toString(topVar)),
        ("--var-ujz4nu", CSS.Types.Bottom.toString(topVar)),
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
      "css-1rsi5sr-test9 css-g6afgo-test9",
      [
        ("--var-1wr101a", CSS.Types.LineWidth.toString(borderWidthVar)),
        ("--var-hd5ziv", CSS.Types.LineWidth.toString(borderWidthVar)),
      ],
    );
  let spacingVar = CSS.px(2);
  let test10 =
    CSS.make(
      "css-lbcu38-test10 css-1j0nnnq-test10",
      [
        ("--var-1jtxlb8", CSS.Types.LetterSpacing.toString(spacingVar)),
        ("--var-1s6l74p", CSS.Types.WordSpacing.toString(spacingVar)),
      ],
    );
  let test11 = width =>
    CSS.make(
      "css-1dfkyy8-test11 css-73nay0-test11 css-tokvmb-test11",
      [("--var-18c1xss", CSS.Types.Width.toString(width))],
    );
