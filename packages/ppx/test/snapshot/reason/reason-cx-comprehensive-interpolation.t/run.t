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
  [@css ".in-b8f0pi{width:var(--lengthVar-1fwod6p);}"];
  [@css ".in-b8f0pi{height:var(--lengthVar-5g6bk9);}"];
  [@css ".in-b8f0pi{min-width:var(--lengthVar-1qqvx43);}"];
  [@css ".in-b8f0pi{max-width:var(--lengthVar-11faw47);}"];
  [@css ".in-1swajk7{margin-top:var(--lengthVar-oy21bt);}"];
  [@css ".in-1swajk7{margin-bottom:var(--lengthVar-oy21bt);}"];
  [@css ".in-1swajk7{padding-left:var(--lengthVar-1lpa833);}"];
  [@css ".in-1swajk7{padding-right:var(--lengthVar-1lpa833);}"];
  [@css
    ".a-6fvyy6{gap:var(--lengthVar-vh1osb);row-gap:var(--lengthVar-vh1osb);-webkit-column-gap:var(--lengthVar-vh1osb);column-gap:var(--lengthVar-vh1osb);}"
  ];
  [@css ".in-1vzwmoy{color:var(--colorVar-14sye4i);}"];
  [@css ".in-1vzwmoy{background-color:var(--colorVar-14sye4i);}"];
  [@css ".in-1vzwmoy{border-top-color:var(--colorVar-14sye4i);}"];
  [@css ".a-60001pa9s{flex-basis:var(--flexBasisVar-16vl5bp);}"];
  [@css ".in-1knt7y9{grid-row-start:var(--gridLineVar-1qxvc00);}"];
  [@css ".in-1knt7y9{grid-column-end:var(--gridLineVar-175omdk);}"];
  [@css ".in-1d6x35p{top:var(--topVar-1iqysbe);}"];
  [@css ".in-1d6x35p{bottom:var(--topVar-10dkp5m);}"];
  [@css ".a-ekxgpr{z-index:var(--zIndexVar-osv02l);}"];
  [@css
    ".a-3hlokzkxi{border-top-width:var(--borderWidthVar-1nwhzbd);border-width:var(--borderWidthVar-1nwhzbd);}"
  ];
  [@css ".in-zoi7e9{letter-spacing:var(--spacingVar-15s0ecx);}"];
  [@css ".in-zoi7e9{word-spacing:var(--spacingVar-1m50b62);}"];
  [@css ".a-eckyy8{width:var(--width-18c1xss);}"];
  [@css ".a-6lnay0{height:100px;}"];
  [@css ".a-4ekvmb{color:red;}"];
  [@css.bindings
    [
      ("Output.test1", "id-1jhxcqu", "in-b8f0pi"),
      ("Output.test2", "id-zesghj", "in-1swajk7"),
      ("Output.test3", "id-12rsoz0", "a-6fvyy6"),
      ("Output.test4", "id-puktrw", "in-1vzwmoy"),
      ("Output.test5", "id-1nw36ql", "a-60001pa9s"),
      ("Output.test6", "id-7ivz4", "in-1knt7y9"),
      ("Output.test7", "id-iq7p3", "in-1d6x35p"),
      ("Output.test8", "id-yq2qob", "a-ekxgpr"),
      ("Output.test9", "id-1u4o5z6", "a-3hlokzkxi"),
      ("Output.test10", "id-1egwgp0", "in-zoi7e9"),
      ("Output.test11", "id-16lxxsk", "a-eckyy8 a-6lnay0 a-4ekvmb"),
    ]
  ];
  let lengthVar = CSS.px(10);
  let colorVar = CSS.red;
  let percentVar = CSS.pct(50.0);
  let autoVar = `auto;
  let test1 =
    CSS.make(
      "label:test1 id-1jhxcqu in-b8f0pi",
      [
        ("--lengthVar-1fwod6p", CSS.Types.Width.toString(lengthVar)),
        ("--lengthVar-5g6bk9", CSS.Types.Height.toString(lengthVar)),
        ("--lengthVar-1qqvx43", CSS.Types.MinWidth.toString(lengthVar)),
        ("--lengthVar-11faw47", CSS.Types.MaxWidth.toString(lengthVar)),
      ],
    );
  let test2 =
    CSS.make(
      "label:test2 id-zesghj in-1swajk7",
      [
        ("--lengthVar-oy21bt", CSS.Types.Margin.toString(lengthVar)),
        ("--lengthVar-1lpa833", CSS.Types.Length.toString(lengthVar)),
      ],
    );
  let test3 =
    CSS.make(
      "label:test3 id-12rsoz0 a-6fvyy6",
      [("--lengthVar-vh1osb", CSS.Types.Gap.toString(lengthVar))],
    );
  let test4 =
    CSS.make(
      "label:test4 id-puktrw in-1vzwmoy",
      [("--colorVar-14sye4i", CSS.Types.Color.toString(colorVar))],
    );
  let flexBasisVar = CSS.px(100);
  let test5 =
    CSS.make(
      "label:test5 id-1nw36ql a-60001pa9s",
      [
        ("--flexBasisVar-16vl5bp", CSS.Types.FlexBasis.toString(flexBasisVar)),
      ],
    );
  let gridLineVar = `auto;
  let test6 =
    CSS.make(
      "label:test6 id-7ivz4 in-1knt7y9",
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
      "label:test7 id-iq7p3 in-1d6x35p",
      [
        ("--topVar-1iqysbe", CSS.Types.Top.toString(topVar)),
        ("--topVar-10dkp5m", CSS.Types.Bottom.toString(topVar)),
      ],
    );
  let zIndexVar = `num(10);
  let test8 =
    CSS.make(
      "label:test8 id-yq2qob a-ekxgpr",
      [("--zIndexVar-osv02l", CSS.Types.ZIndex.toString(zIndexVar))],
    );
  let borderWidthVar = `medium;
  let test9 =
    CSS.make(
      "label:test9 id-1u4o5z6 a-3hlokzkxi",
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
      "label:test10 id-1egwgp0 in-zoi7e9",
      [
        ("--spacingVar-15s0ecx", CSS.Types.LetterSpacing.toString(spacingVar)),
        ("--spacingVar-1m50b62", CSS.Types.WordSpacing.toString(spacingVar)),
      ],
    );
  let test11 = width =>
    CSS.make(
      "label:test11 id-16lxxsk a-eckyy8 a-6lnay0 a-4ekvmb",
      [("--width-18c1xss", CSS.Types.Width.toString(width))],
    );
