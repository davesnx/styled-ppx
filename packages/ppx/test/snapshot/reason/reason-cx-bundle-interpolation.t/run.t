Plan 3b: a block's interpolating declarations share one bundle class and one
var per (source-path, runtime-type) across base / :hover / @media variants.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --color-3f9mj1{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-13vjntp{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-1v9ua{syntax:\"*\";inherits:false;}"];
  [@css "@property --width-c62vcf{syntax:\"*\";inherits:false;}"];
  [@css "@property --color-4uzv5u{syntax:\"*\";inherits:false;}"];
  [@css ".csv-1kbzua4{color:var(--color-3f9mj1);}"];
  [@css ".csv-1kbzua4:hover{color:var(--color-3f9mj1);}"];
  [@css "@media (max-width: 768px) {.csv-1kbzua4{color:var(--color-3f9mj1);}}"];
  [@css ".css-k008qs{display:flex;}"];
  [@css ".csv-1upqar2{color:var(--color-13vjntp);}"];
  [@css ".csv-1upqar2:hover{color:var(--color-13vjntp);}"];
  [@css ".csv-e286e6{width:var(--width-1v9ua);}"];
  [@css ".csv-e286e6:hover{height:var(--width-c62vcf);}"];
  [@css ".css-tokvmb{color:red;}"];
  [@css ".csv-lfbwy0:hover{color:var(--color-4uzv5u);}"];
  [@css.bindings
    [
      ("Output.multiVariant", "cid-1be0zju", "csv-1kbzua4"),
      ("Output.mixed", "cid-11av61d", "css-k008qs csv-1upqar2"),
      ("Output.twoTypes", "cid-1ybygzf", "csv-e286e6"),
    ]
  ];
  let color = CSS.Types.Color.toString(`hex("3A57FC"));
  let width = CSS.px(10);
  let multiVariant =
    CSS.make(
      "label:multiVariant cid-1be0zju csv-1kbzua4",
      [("--color-3f9mj1", CSS.Types.Color.toString(color))],
    );
  let mixed =
    CSS.make(
      "label:mixed cid-11av61d css-k008qs csv-1upqar2",
      [("--color-13vjntp", CSS.Types.Color.toString(color))],
    );
  let twoTypes =
    CSS.make(
      "label:twoTypes cid-1ybygzf csv-e286e6",
      [
        ("--width-1v9ua", CSS.Types.Width.toString(width)),
        ("--width-c62vcf", CSS.Types.Height.toString(width)),
      ],
    );
  let _ =
    CSS.make(
      "css-tokvmb csv-lfbwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
  let _ =
    CSS.make(
      "css-k008qs csv-lfbwy0",
      [("--color-4uzv5u", CSS.Types.Color.toString(color))],
    );
