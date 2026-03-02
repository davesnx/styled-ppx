Comprehensive test for cx2 interpolation with various property types
  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    ".css-2v7e0k{width:var(--var-yq31wd);}\n.css-lbwdj4{height:var(--var-yq31wd);}\n.css-ur6cve{min-width:var(--var-yq31wd);}\n.css-9nbswy{max-width:var(--var-yq31wd);}\n.css-1h6gv7y{margin-top:var(--var-yq31wd);}\n.css-1ojdfmn{margin-bottom:var(--var-yq31wd);}\n.css-6oe920{padding-left:var(--var-yq31wd);}\n.css-kxyw4{padding-right:var(--var-yq31wd);}\n.css-1j1vt57{gap:var(--var-yq31wd);}\n.css-16533ek{row-gap:var(--var-yq31wd);}\n.css-aq5h2o{column-gap:var(--var-yq31wd);}\n.css-4bvljg{color:var(--var-15252qs);}\n.css-1e9wc53{background-color:var(--var-15252qs);}\n.css-t4dyfi{border-top-color:var(--var-15252qs);}\n.css-ycpa9s{flex-basis:var(--var-x7fhjg);}\n.css-en5xqq{grid-row-start:var(--var-4ff4w4);}\n.css-1vcbsia{grid-column-end:var(--var-4ff4w4);}\n.css-rexok8{top:var(--var-1n3wsy);}\n.css-16sky2z{bottom:var(--var-1n3wsy);}\n.css-1bkxgpr{z-index:var(--var-fd7qxc);}\n.css-1rsi5sr{border-top-width:var(--var-wag9af);}\n.css-g6afgo{border-width:var(--var-wag9af);}\n.css-lbcu38{letter-spacing:var(--var-apx1x0);}\n.css-1j0nnnq{word-spacing:var(--var-apx1x0);}\n.css-1dfkyy8{width:var(--var-a9b677);}\n.css-73nay0{height:100px;}\n.css-tokvmb{color:red;}\n"
  ];
  let lengthVar = CSS.px(10);
  let colorVar = CSS.red;
  let percentVar = CSS.pct(50.0);
  let autoVar = `auto;
  let test1 =
    CSS.make(
      "css-2v7e0k css-lbwdj4 css-ur6cve css-9nbswy",
      [("--var-yq31wd", CSS.Types.Width.toString(lengthVar))],
    );
  let test2 =
    CSS.make(
      "css-1h6gv7y css-1ojdfmn css-6oe920 css-kxyw4",
      [("--var-yq31wd", CSS.Types.Length.toString(lengthVar))],
    );
  let test3 =
    CSS.make(
      "css-1j1vt57 css-16533ek css-aq5h2o",
      [("--var-yq31wd", CSS.Types.Gap.toString(lengthVar))],
    );
  let test4 =
    CSS.make(
      "css-4bvljg css-1e9wc53 css-t4dyfi",
      [("--var-15252qs", CSS.Types.Color.toString(colorVar))],
    );
  let flexBasisVar = CSS.px(100);
  let test5 =
    CSS.make(
      "css-ycpa9s",
      [("--var-x7fhjg", CSS.Types.FlexBasis.toString(flexBasisVar))],
    );
  let gridLineVar = `auto;
  let test6 =
    CSS.make(
      "css-en5xqq css-1vcbsia",
      [("--var-4ff4w4", CSS.Types.GridRowStart.toString(gridLineVar))],
    );
  let topVar = CSS.px(20);
  let test7 =
    CSS.make(
      "css-rexok8 css-16sky2z",
      [("--var-1n3wsy", CSS.Types.Top.toString(topVar))],
    );
  let zIndexVar = `num(10);
  let test8 =
    CSS.make(
      "css-1bkxgpr",
      [("--var-fd7qxc", CSS.Types.ZIndex.toString(zIndexVar))],
    );
  let borderWidthVar = `medium;
  let test9 =
    CSS.make(
      "css-1rsi5sr css-g6afgo",
      [("--var-wag9af", CSS.Types.Length.toString(borderWidthVar))],
    );
  let spacingVar = CSS.px(2);
  let test10 =
    CSS.make(
      "css-lbcu38 css-1j0nnnq",
      [("--var-apx1x0", CSS.Types.LetterSpacing.toString(spacingVar))],
    );
  let test11 = width =>
    CSS.make(
      "css-1dfkyy8 css-73nay0 css-tokvmb",
      [("--var-a9b677", CSS.Types.Width.toString(width))],
    );

