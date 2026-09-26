Plan 3b: a block's interpolating declarations share one bundle class and one
var per (source-path, runtime-type) across base / :hover / @media variants -
but only when TWO OR MORE of them share the block (`multiVariant`, `mixed`,
`twoTypes` below). The last two anonymous bindings each have exactly ONE
interpolating declaration, so they are not bundles at all: each mints its
own real, slot-keyed `a-` class instead.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-3f9mj1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-13vjntp{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-1v9ua{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-c62vcf{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-4uzv5u{syntax:\"*\";inherits:false;}"];
  [@css ".in-1kbzua4{color:var(--color-3f9mj1);}"];
  [@css ".in-1kbzua4:hover{color:var(--color-3f9mj1);}"];
  [@css "@media (max-width: 768px) {.in-1kbzua4{color:var(--color-3f9mj1);}}"];
  [@css ".a-5r08qs{display:flex;}"];
  [@css ".in-1upqar2{color:var(--color-13vjntp);}"];
  [@css ".in-1upqar2:hover{color:var(--color-13vjntp);}"];
  [@css ".in-e286e6{width:var(--width-1v9ua);}"];
  [@css ".in-e286e6:hover{height:var(--width-c62vcf);}"];
  [@css ".a-4ekvmb{color:red;}"];
  [@css ".a-qyw7u4ebwy0:hover{color:var(--color-4uzv5u);}"];
  [@css.bindings
    [
      ("Output.multiVariant", "id-1be0zju", "in-1kbzua4"),
      ("Output.mixed", "id-11av61d", "a-5r08qs in-1upqar2"),
      ("Output.twoTypes", "id-1ybygzf", "in-e286e6"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let width = CSS.px(10);
  let multiVariant =
    CSS.make(
      "label:multiVariant id-1be0zju in-1kbzua4",
      [("--color-3f9mj1", CSS.Types.Color.toString(color))],
    );
  let mixed =
    CSS.make(
      "label:mixed id-11av61d a-5r08qs in-1upqar2",
      [("--color-13vjntp", CSS.Types.Color.toString(color))],
    );
  let twoTypes =
    CSS.make(
      "label:twoTypes id-1ybygzf in-e286e6",
      [
        ("--width-1v9ua", CSS.Types.Width.toString(width)),
        ("--width-c62vcf", CSS.Types.Height.toString(width)),
      ],
    );
  let _ =
    CSS.make(
      "a-4ekvmb a-qyw7u4ebwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
  let _ =
    CSS.make(
      "a-5r08qs a-qyw7u4ebwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
