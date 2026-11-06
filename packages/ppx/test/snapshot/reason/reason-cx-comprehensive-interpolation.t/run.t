Comprehensive test for cx2 interpolation with various property types
  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --lengthVar-19tma5g{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-35afkh{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-mxkm2h{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-14gqse{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-1nn4wdm{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-1k3vbt5{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-swuunj{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-1jqoric{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-1rn544a{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-2cwtxz{syntax:\"*\";inherits:false;}"];
  [@css "@property --colorVar-1rihxt6{syntax:\"*\";inherits:false;}"];
  [@css "@property --colorVar-yki0xp{syntax:\"*\";inherits:false;}"];
  [@css "@property --colorVar-1y1ysof{syntax:\"*\";inherits:false;}"];
  [@css "@property --flexBasisVar-mc1bq8{syntax:\"*\";inherits:false;}"];
  [@css "@property --gridLineVar-qk03w5{syntax:\"*\";inherits:false;}"];
  [@css "@property --gridLineVar-1bjw9k{syntax:\"*\";inherits:false;}"];
  [@css "@property --topVar-yauzt2{syntax:\"*\";inherits:false;}"];
  [@css "@property --topVar-1qs7one{syntax:\"*\";inherits:false;}"];
  [@css "@property --zIndexVar-tv0djl{syntax:\"*\";inherits:false;}"];
  [@css "@property --borderWidthVar-1rri29i{syntax:\"*\";inherits:false;}"];
  [@css "@property --spacingVar-8ooj17{syntax:\"*\";inherits:false;}"];
  [@css "@property --spacingVar-1wbqxry{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-s4afn7{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_an82GBmrP",
        ["._an82GBmrP{width:var(--lengthVar-19tma5g);}"],
        1,
        0,
        1,
        [("value", "2GBmrP", "val\\0n8\\0& | \\0width:$(lengthVar)")],
      ),
      (
        "_abd0ganeP",
        ["._abd0ganeP{height:var(--lengthVar-35afkh);}"],
        1,
        0,
        1,
        [("value", "0ganeP", "val\\0bd\\0& | \\0height:$(lengthVar)")],
      ),
      (
        "_aesTrax_E",
        ["._aesTrax_E{min-width:var(--lengthVar-mxkm2h);}"],
        1,
        0,
        1,
        [("value", "Trax_E", "val\\0es\\0& | \\0min-width:$(lengthVar)")],
      ),
      (
        "_adzrFtmJp",
        ["._adzrFtmJp{max-width:var(--lengthVar-14gqse);}"],
        1,
        0,
        1,
        [("value", "rFtmJp", "val\\0dz\\0& | \\0max-width:$(lengthVar)")],
      ),
      (
        "_ad3boUbFz",
        ["._ad3boUbFz{margin-top:var(--lengthVar-1nn4wdm);}"],
        1,
        0,
        1,
        [("value", "boUbFz", "val\\0d3\\0& | \\0margin-top:$(lengthVar)")],
      ),
      (
        "_acx15viCZ",
        ["._acx15viCZ{margin-bottom:var(--lengthVar-1k3vbt5);}"],
        1,
        0,
        1,
        [("value", "15viCZ", "val\\0cx\\0& | \\0margin-bottom:$(lengthVar)")],
      ),
      (
        "_ag6wgf6n2",
        ["._ag6wgf6n2{padding-left:var(--lengthVar-swuunj);}"],
        1,
        0,
        1,
        [("value", "wgf6n2", "val\\0g6\\0& | \\0padding-left:$(lengthVar)")],
      ),
      (
        "_ag7BzQviP",
        ["._ag7BzQviP{padding-right:var(--lengthVar-1jqoric);}"],
        1,
        0,
        1,
        [("value", "BzQviP", "val\\0g7\\0& | \\0padding-right:$(lengthVar)")],
      ),
      (
        "_ah8cgQkDG",
        ["._ah8cgQkDG{row-gap:var(--lengthVar-1rn544a);}"],
        1,
        0,
        1,
        [("value", "cgQkDG", "val\\0h8\\0& | \\0row-gap:$(lengthVar)")],
      ),
      (
        "_a7nUOju9J",
        [
          "._a7nUOju9J{-webkit-column-gap:var(--lengthVar-2cwtxz);column-gap:var(--lengthVar-2cwtxz);}",
        ],
        1,
        0,
        1,
        [("value", "UOju9J", "val\\07n\\0& | \\0column-gap:$(lengthVar)")],
      ),
      (
        "_a7f2wOwkt",
        ["._a7f2wOwkt{color:var(--colorVar-1rihxt6);}"],
        1,
        0,
        1,
        [("value", "2wOwkt", "val\\07f\\0& | \\0color:$(colorVar)")],
      ),
      (
        "_a4lDBiS7U",
        ["._a4lDBiS7U{background-color:var(--colorVar-yki0xp);}"],
        1,
        0,
        1,
        [
          ("value", "DBiS7U", "val\\04l\\0& | \\0background-color:$(colorVar)"),
        ],
      ),
      (
        "_a6kB2jTT4",
        ["._a6kB2jTT4{border-top-color:var(--colorVar-1y1ysof);}"],
        1,
        0,
        1,
        [
          ("value", "B2jTT4", "val\\06k\\0& | \\0border-top-color:$(colorVar)"),
        ],
      ),
      (
        "_a9qEKJob4",
        ["._a9qEKJob4{flex-basis:var(--flexBasisVar-mc1bq8);}"],
        1,
        0,
        1,
        [("value", "EKJob4", "val\\09q\\0& | \\0flex-basis:$(flexBasisVar)")],
      ),
      (
        "_ab7zUFAJ-",
        ["._ab7zUFAJ-{grid-row-start:var(--gridLineVar-qk03w5);}"],
        1,
        0,
        1,
        [
          ("value", "zUFAJ-", "val\\0b7\\0& | \\0grid-row-start:$(gridLineVar)"),
        ],
      ),
      (
        "_ab38p2210",
        ["._ab38p2210{grid-column-end:var(--gridLineVar-1bjw9k);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "8p2210",
            "val\\0b3\\0& | \\0grid-column-end:$(gridLineVar)",
          ),
        ],
      ),
      (
        "_am4ve_Ez6",
        ["._am4ve_Ez6{top:var(--topVar-yauzt2);}"],
        1,
        0,
        1,
        [("value", "ve_Ez6", "val\\0m4\\0& | \\0top:$(topVar)")],
      ),
      (
        "_a6qs74EYW",
        ["._a6qs74EYW{bottom:var(--topVar-1qs7one);}"],
        1,
        0,
        1,
        [("value", "s74EYW", "val\\06q\\0& | \\0bottom:$(topVar)")],
      ),
      (
        "_angq-0N6V",
        ["._angq-0N6V{z-index:var(--zIndexVar-tv0djl);}"],
        1,
        0,
        1,
        [("value", "q-0N6V", "val\\0ng\\0& | \\0z-index:$(zIndexVar)")],
      ),
      (
        "_a6p_cDNYj",
        ["._a6p_cDNYj{border-width:var(--borderWidthVar-1rri29i);}"],
        1,
        0,
        4,
        [
          (
            "value",
            "_cDNYj",
            "val\\06p\\0& | \\0border-width:$(borderWidthVar)",
          ),
        ],
      ),
      (
        "_acioKKlVn",
        ["._acioKKlVn{letter-spacing:var(--spacingVar-8ooj17);}"],
        1,
        0,
        1,
        [
          ("value", "oKKlVn", "val\\0ci\\0& | \\0letter-spacing:$(spacingVar)"),
        ],
      ),
      (
        "_anc_W9TJ4",
        ["._anc_W9TJ4{word-spacing:var(--spacingVar-1wbqxry);}"],
        1,
        0,
        1,
        [("value", "_W9TJ4", "val\\0nc\\0& | \\0word-spacing:$(spacingVar)")],
      ),
      (
        "_an8FHTy9P",
        ["._an8FHTy9P{width:var(--width-s4afn7);}"],
        1,
        0,
        1,
        [("value", "FHTy9P", "val\\0n8\\0& | \\0width:$(width)")],
      ),
      (
        "_abdq5rmvf",
        ["._abdq5rmvf{height:100px;}"],
        1,
        0,
        1,
        [("value", "q5rmvf", "val\\0bd\\0& | \\0height:100px")],
      ),
      (
        "_a7fadbhEW",
        ["._a7fadbhEW{color:red;}"],
        1,
        0,
        1,
        [("value", "adbhEW", "val\\07f\\0& | \\0color:red")],
      ),
      (
        "_ihc3NiiWI",
        [],
        1,
        0,
        0,
        [("id", "_ihc3NiiWI", "bind\\0\\0Output\\0\\0test1\\00")],
      ),
      (
        "_i3Fm0T20_",
        [],
        1,
        0,
        0,
        [("id", "_i3Fm0T20_", "bind\\0\\0Output\\0\\0test2\\00")],
      ),
      (
        "_isK63HGSc",
        [],
        1,
        0,
        0,
        [("id", "_isK63HGSc", "bind\\0\\0Output\\0\\0test3\\00")],
      ),
      (
        "_ipwau4U6Q",
        [],
        1,
        0,
        0,
        [("id", "_ipwau4U6Q", "bind\\0\\0Output\\0\\0test4\\00")],
      ),
      (
        "_iR0xof-yu",
        [],
        1,
        0,
        0,
        [("id", "_iR0xof-yu", "bind\\0\\0Output\\0\\0test5\\00")],
      ),
      (
        "_iF7DlOOZI",
        [],
        1,
        0,
        0,
        [("id", "_iF7DlOOZI", "bind\\0\\0Output\\0\\0test6\\00")],
      ),
      (
        "_isAImfuOp",
        [],
        1,
        0,
        0,
        [("id", "_isAImfuOp", "bind\\0\\0Output\\0\\0test7\\00")],
      ),
      (
        "_inj4fQj2N",
        [],
        1,
        0,
        0,
        [("id", "_inj4fQj2N", "bind\\0\\0Output\\0\\0test8\\00")],
      ),
      (
        "_iTFGCXCNV",
        [],
        1,
        0,
        0,
        [("id", "_iTFGCXCNV", "bind\\0\\0Output\\0\\0test9\\00")],
      ),
      (
        "_iBkRunDJz",
        [],
        1,
        0,
        0,
        [("id", "_iBkRunDJz", "bind\\0\\0Output\\0\\0test10\\00")],
      ),
      (
        "_i1Vu_neTT",
        [],
        1,
        0,
        0,
        [("id", "_i1Vu_neTT", "bind\\0\\0Output\\0\\0test11\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      (
        "Output.test1",
        "_ihc3NiiWI _an82GBmrP _abd0ganeP _aesTrax_E _adzrFtmJp",
        "_ihc3NiiWI",
      ),
      (
        "Output.test2",
        "_i3Fm0T20_ _ad3boUbFz _acx15viCZ _ag6wgf6n2 _ag7BzQviP",
        "_i3Fm0T20_",
      ),
      ("Output.test3", "_isK63HGSc _ah8cgQkDG _a7nUOju9J", "_isK63HGSc"),
      (
        "Output.test4",
        "_ipwau4U6Q _a7f2wOwkt _a4lDBiS7U _a6kB2jTT4",
        "_ipwau4U6Q",
      ),
      ("Output.test5", "_iR0xof-yu _a9qEKJob4", "_iR0xof-yu"),
      ("Output.test6", "_iF7DlOOZI _ab7zUFAJ- _ab38p2210", "_iF7DlOOZI"),
      ("Output.test7", "_isAImfuOp _am4ve_Ez6 _a6qs74EYW", "_isAImfuOp"),
      ("Output.test8", "_inj4fQj2N _angq-0N6V", "_inj4fQj2N"),
      ("Output.test9", "_iTFGCXCNV _a6p_cDNYj", "_iTFGCXCNV"),
      ("Output.test10", "_iBkRunDJz _acioKKlVn _anc_W9TJ4", "_iBkRunDJz"),
      (
        "Output.test11",
        "_i1Vu_neTT _an8FHTy9P _abdq5rmvf _a7fadbhEW",
        "_i1Vu_neTT",
      ),
    ]
  ];
  let lengthVar = CSS.px(10);
  let colorVar = CSS.red;
  let percentVar = CSS.pct(50.0);
  let autoVar = `auto;
  let test1 =
    CSS.make(
      "_ihc3NiiWI _an82GBmrP _abd0ganeP _aesTrax_E _adzrFtmJp",
      [
        ("--lengthVar-19tma5g", CSS.Types.Width.toString(lengthVar)),
        ("--lengthVar-35afkh", CSS.Types.Height.toString(lengthVar)),
        ("--lengthVar-mxkm2h", CSS.Types.MinWidth.toString(lengthVar)),
        ("--lengthVar-14gqse", CSS.Types.MaxWidth.toString(lengthVar)),
      ],
    );
  let test2 =
    CSS.make(
      "_i3Fm0T20_ _ad3boUbFz _acx15viCZ _ag6wgf6n2 _ag7BzQviP",
      [
        ("--lengthVar-1nn4wdm", CSS.Types.Margin.toString(lengthVar)),
        ("--lengthVar-1k3vbt5", CSS.Types.Margin.toString(lengthVar)),
        ("--lengthVar-swuunj", CSS.Types.Length.toString(lengthVar)),
        ("--lengthVar-1jqoric", CSS.Types.Length.toString(lengthVar)),
      ],
    );
  let test3 =
    CSS.make(
      "_isK63HGSc _ah8cgQkDG _a7nUOju9J",
      [
        ("--lengthVar-1rn544a", CSS.Types.Gap.toString(lengthVar)),
        ("--lengthVar-2cwtxz", CSS.Types.Gap.toString(lengthVar)),
      ],
    );
  let test4 =
    CSS.make(
      "_ipwau4U6Q _a7f2wOwkt _a4lDBiS7U _a6kB2jTT4",
      [
        ("--colorVar-1rihxt6", CSS.Types.Color.toString(colorVar)),
        ("--colorVar-yki0xp", CSS.Types.Color.toString(colorVar)),
        ("--colorVar-1y1ysof", CSS.Types.Color.toString(colorVar)),
      ],
    );
  let flexBasisVar = CSS.px(100);
  let test5 =
    CSS.make(
      "_iR0xof-yu _a9qEKJob4",
      [("--flexBasisVar-mc1bq8", CSS.Types.FlexBasis.toString(flexBasisVar))],
    );
  let gridLineVar = `auto;
  let test6 =
    CSS.make(
      "_iF7DlOOZI _ab7zUFAJ- _ab38p2210",
      [
        ("--gridLineVar-qk03w5", CSS.Types.GridRowStart.toString(gridLineVar)),
        (
          "--gridLineVar-1bjw9k",
          CSS.Types.GridColumnEnd.toString(gridLineVar),
        ),
      ],
    );
  let topVar = CSS.px(20);
  let test7 =
    CSS.make(
      "_isAImfuOp _am4ve_Ez6 _a6qs74EYW",
      [
        ("--topVar-yauzt2", CSS.Types.Top.toString(topVar)),
        ("--topVar-1qs7one", CSS.Types.Bottom.toString(topVar)),
      ],
    );
  let zIndexVar = `num(10);
  let test8 =
    CSS.make(
      "_inj4fQj2N _angq-0N6V",
      [("--zIndexVar-tv0djl", CSS.Types.ZIndex.toString(zIndexVar))],
    );
  let borderWidthVar = `medium;
  let test9 =
    CSS.make(
      "_iTFGCXCNV _a6p_cDNYj",
      [
        (
          "--borderWidthVar-1rri29i",
          CSS.Types.LineWidth.toString(borderWidthVar),
        ),
      ],
    );
  let spacingVar = CSS.px(2);
  let test10 =
    CSS.make(
      "_iBkRunDJz _acioKKlVn _anc_W9TJ4",
      [
        ("--spacingVar-8ooj17", CSS.Types.LetterSpacing.toString(spacingVar)),
        ("--spacingVar-1wbqxry", CSS.Types.WordSpacing.toString(spacingVar)),
      ],
    );
  let test11 = width =>
    CSS.make(
      "_i1Vu_neTT _an8FHTy9P _abdq5rmvf _a7fadbhEW",
      [("--width-s4afn7", CSS.Types.Width.toString(width))],
    );
