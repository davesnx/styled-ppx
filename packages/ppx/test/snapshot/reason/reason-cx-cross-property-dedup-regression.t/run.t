REGRESSION TEST — [%css] does not deduplicate one binding across different
CSS runtime types. See input.re for the full rationale.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "@property --lengthVar-12br693{syntax:\"*\";inherits:false;}"];
  [@css "@property --lengthVar-8edltm{syntax:\"*\";inherits:false;}"];
  [@css ".css-1mfmiq8-layout{margin-left:var(--lengthVar-12br693);}"];
  [@css ".css-1mfmiq8-layout{padding-left:var(--lengthVar-8edltm);}"];
  [@css.bindings [("Output.layout", "css-1mfmiq8-layout")]];
  let lengthVar = CSS.px(10);
  let layout =
    CSS.make(
      "css-1mfmiq8-layout",
      [
        ("--lengthVar-12br693", CSS.Types.Margin.toString(lengthVar)),
        ("--lengthVar-8edltm", CSS.Types.Length.toString(lengthVar)),
      ],
    );
