REGRESSION TEST — [%css] does not deduplicate one binding across different
CSS runtime types. See input.re for the full rationale.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-1mfmiq8-layout{margin-left:var(--var-12br693);}"];
  [@css ".css-1mfmiq8-layout{padding-left:var(--var-8edltm);}"];
  [@css.bindings [("Output.layout", "css-1mfmiq8-layout")]];
  let lengthVar = CSS.px(10);
  let layout =
    CSS.make(
      "css-1mfmiq8-layout",
      [
        ("--var-12br693", CSS.Types.Margin.toString(lengthVar)),
        ("--var-8edltm", CSS.Types.Length.toString(lengthVar)),
      ],
    );
