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
  [@css "._in_1kbzua4{color:var(--color-3f9mj1);}"];
  [@css "._in_1kbzua4:hover{color:var(--color-3f9mj1);}"];
  [@css "@media (max-width: 768px) {._in_1kbzua4{color:var(--color-3f9mj1);}}"];
  [@css "._a_5r08qs{display:flex;}"];
  [@css "._in_1upqar2{color:var(--color-13vjntp);}"];
  [@css "._in_1upqar2:hover{color:var(--color-13vjntp);}"];
  [@css "._in_e286e6{width:var(--width-1v9ua);}"];
  [@css "._in_e286e6:hover{height:var(--width-c62vcf);}"];
  [@css "._a_4esjgz{color:var(--color-1a279q8);}"];
  [@css "._a_3900412gx{background-color:var(--accent-1gxhmqu);}"];
  [@css "._a_4ekvmb{color:red;}"];
  [@css "._a_qyw7u4ebwy0:hover{color:var(--color-4uzv5u);}"];
  [@css.bindings
    [
      ("Output.multiVariant", "_id_1be0zju", "_in_1kbzua4"),
      ("Output.mixed", "_id_11av61d", "_a_5r08qs _in_1upqar2"),
      ("Output.twoTypes", "_id_1ybygzf", "_in_e286e6"),
      ("Output.separateValues", "_id_1y219dc", "_a_4esjgz _a_3900412gx"),
      ("Output.partialShare", "_id_r0r4jt", "_in_1upqar2 _a_3900412gx"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let width = CSS.px(10);
  let accent = CSS.Types.Color.toString(`hex("00A67D"));
  let multiVariant =
    CSS.make(
      "label:multiVariant _id_1be0zju _in_1kbzua4",
      [("--color-3f9mj1", CSS.Types.Color.toString(color))],
    );
  let mixed =
    CSS.make(
      "label:mixed _id_11av61d _a_5r08qs _in_1upqar2",
      [("--color-13vjntp", CSS.Types.Color.toString(color))],
    );
  let twoTypes =
    CSS.make(
      "label:twoTypes _id_1ybygzf _in_e286e6",
      [
        ("--width-1v9ua", CSS.Types.Width.toString(width)),
        ("--width-c62vcf", CSS.Types.Height.toString(width)),
      ],
    );
  let separateValues =
    CSS.make(
      "label:separateValues _id_1y219dc _a_4esjgz _a_3900412gx",
      [
        ("--color-1a279q8", CSS.Types.Color.toString(color)),
        ("--accent-1gxhmqu", CSS.Types.Color.toString(accent)),
      ],
    );
  let partialShare =
    CSS.make(
      "label:partialShare _id_r0r4jt _in_1upqar2 _a_3900412gx",
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
