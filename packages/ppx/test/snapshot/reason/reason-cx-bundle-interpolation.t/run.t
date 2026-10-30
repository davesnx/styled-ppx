Plan 3b/option (c): a block's interpolating declarations share one bundle
class and one var per (source-path, runtime-type) across base / :hover /
@media variants - but only when TWO OR MORE of them interpolate the SAME
source path (`multiVariant`, `mixed`, `twoTypes` below). `separateValues`
and `partialShare` cover the negative case: two declarations that merely
both interpolate, but different, unrelated values, do not share anything -
each mints its own real, slot-keyed `_a_` class, and `CSS.merge` resolves
them independently. The last two anonymous bindings each have exactly ONE
interpolating declaration overall, so they are not bundles at all: each
mints its own real, slot-keyed `_a_` class instead.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-3f9mj1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-13vjntp{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-1v9ua{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-c62vcf{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-1a279q8{syntax:\"*\";inherits:false;}"];
  [@css "@property --accent-1gxhmqu{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-4uzv5u{syntax:\"*\";inherits:false;}"];
  [@css
    (
      "._in_1kbzua4{color:var(--color-3f9mj1);}",
      "_in_1kbzua4",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._in_1kbzua4:hover{color:var(--color-3f9mj1);}",
      "_in_1kbzua4",
      "0,2,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "@media (max-width: 768px) {._in_1kbzua4{color:var(--color-3f9mj1);}}",
      "_in_1kbzua4",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)
  ];
  [@css
    (
      "._in_1upqar2{color:var(--color-13vjntp);}",
      "_in_1upqar2",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._in_1upqar2:hover{color:var(--color-13vjntp);}",
      "_in_1upqar2",
      "0,2,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._in_e286e6{width:var(--width-1v9ua);}",
      "_in_e286e6",
      "0,1,0 own",
      "516",
      1,
      false,
    )
  ];
  [@css
    (
      "._in_e286e6:hover{height:var(--width-c62vcf);}",
      "_in_e286e6",
      "0,2,0 own",
      "237",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_4esjgz{color:var(--color-1a279q8);}",
      "_a_4esjgz",
      "0,1,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_39000412gx{background-color:var(--accent-1gxhmqu);}",
      "_a_39000412gx",
      "0,1,0 own",
      "117",
      4,
      false,
    )
  ];
  [@css ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)];
  [@css
    (
      "._a_qyw7u4ebwy0:hover{color:var(--color-4uzv5u);}",
      "_a_qyw7u4ebwy0",
      "0,2,0 own",
      "158",
      1,
      false,
    )
  ];
  [@css.bindings
    [
      ("Output.multiVariant", "_id_8hlpz9", "_in_1kbzua4"),
      ("Output.mixed", "_id_1i6efdo", "_a_5r08qs _in_1upqar2"),
      ("Output.twoTypes", "_id_ero4cc", "_in_e286e6"),
      ("Output.separateValues", "_id_1vavuos", "_a_4esjgz _a_39000412gx"),
      ("Output.partialShare", "_id_xgnn3y", "_in_1upqar2 _a_39000412gx"),
    ]
  ];
  [@css.blocks
    [
      (6, "_id_8hlpz9", [7, 8, 9]),
      (17, "_id_1i6efdo", [10, 11, 12]),
      (25, "_id_ero4cc", [13, 14]),
      (32, "_id_1vavuos", [15, 16]),
      (38, "_id_xgnn3y", [11, 16, 12]),
      (45, "", [17, 18]),
      (51, "", [10, 18]),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let width = CSS.px(10);
  let accent = CSS.Types.Color.toString(`hex("00A67D"));
  let multiVariant =
    CSS.make(
      "label:multiVariant _id_8hlpz9 _in_1kbzua4",
      [("--color-3f9mj1", CSS.Types.Color.toString(color))],
    );
  let mixed =
    CSS.make(
      "label:mixed _id_1i6efdo _a_5r08qs _in_1upqar2",
      [("--color-13vjntp", CSS.Types.Color.toString(color))],
    );
  let twoTypes =
    CSS.make(
      "label:twoTypes _id_ero4cc _in_e286e6",
      [
        ("--width-1v9ua", CSS.Types.Width.toString(width)),
        ("--width-c62vcf", CSS.Types.Height.toString(width)),
      ],
    );
  let separateValues =
    CSS.make(
      "label:separateValues _id_1vavuos _a_4esjgz _a_39000412gx",
      [
        ("--color-1a279q8", CSS.Types.Color.toString(color)),
        ("--accent-1gxhmqu", CSS.Types.Color.toString(accent)),
      ],
    );
  let partialShare =
    CSS.make(
      "label:partialShare _id_xgnn3y _in_1upqar2 _a_39000412gx",
      [
        ("--color-13vjntp", CSS.Types.Color.toString(color)),
        ("--accent-1gxhmqu", CSS.Types.Color.toString(accent)),
      ],
    );
  let _ =
    CSS.make(
      "_a_4ekvmb _a_qyw7u4ebwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
  let _ =
    CSS.make(
      "_a_5r08qs _a_qyw7u4ebwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
