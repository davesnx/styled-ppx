REGRESSION TEST — [%css] does not deduplicate one binding across different
CSS runtime types. See input.re for the full rationale.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --vdiv2ov{syntax:\"*\";inherits:false;}"];
  [@css "@property --vdivftt{syntax:\"*\";inherits:false;}"];
  [@css ".css-vdivjar{margin-left:var(--vdiv2ov);padding-left:var(--vdivftt);}"];
  [@css.classes
    [("css-vdivjar", 2, "Output.layout", "output.ml", 4, 2, 6, 0)]
  ];
  [@css.bindings [("Output.layout", "css-vdivjar")]];
  let lengthVar = CSS.px(10);
  let layout =
    CSS.make(
      "css-vdivjar",
      [
        ("--vdiv2ov", CSS.Types.Margin.toString(lengthVar)),
        ("--vdivftt", CSS.Types.Length.toString(lengthVar)),
      ],
    );
