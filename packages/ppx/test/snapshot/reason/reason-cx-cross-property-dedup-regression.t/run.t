REGRESSION TEST — [%css] does not deduplicate one binding across different
CSS runtime types. See input.re for the full rationale.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --lengthVar-1474whp{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-swuunj{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_ad19tzAtH",
        ["._ad19tzAtH{margin-left:var(--lengthVar-1474whp);}"],
        1,
        0,
        1,
        [("value", "9tzAtH", "val\\0d1\\0& | \\0margin-left:$(lengthVar)")],
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
        "_iZoFfEx6o",
        [],
        1,
        0,
        0,
        [("id", "_iZoFfEx6o", "bind\\0\\0Output\\0\\0layout\\00")],
      ),
    ]
  ];
  [@css.bindings
    [("Output.layout", "_iZoFfEx6o _ad19tzAtH _ag6wgf6n2", "_iZoFfEx6o")]
  ];
  let lengthVar = CSS.px(10);
  let layout =
    CSS.make(
      "_iZoFfEx6o _ad19tzAtH _ag6wgf6n2",
      [
        ("--lengthVar-1474whp", CSS.Types.Margin.toString(lengthVar)),
        ("--lengthVar-swuunj", CSS.Types.Length.toString(lengthVar)),
      ],
    );
