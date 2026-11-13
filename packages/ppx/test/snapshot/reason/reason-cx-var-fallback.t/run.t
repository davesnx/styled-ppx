CSS3 `var(--name, fallback)` is admitted by the cx2 parser. The fallback
round-trips verbatim through the rendered stylesheet (linear-gradient,
nested `var()`, length values — anything goes inside the fallback slot).

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-ni5tn2{color:var(--theme);}"]
  [@@@css ".css-isr9zh{color:var(--theme-color, blue);}"]
  [@@@css ".css-15v6roq{margin:var(--gap, 16px);}"]
  [@@@css
    ".css-c7mp0s{background:var(--bg, linear-gradient(0deg, red, blue));}"]
  [@@@css ".css-11x2ldz{color:var(--theme, var(--fallback, red));}"]
  [@@@css.classes
    [("css-ni5tn2", 0, "Input.plain", "input.ml", 8, 21, 8, 42);
    ("css-isr9zh", 1, "Input.withFallback", "input.ml", 9, 28, 9, 61);
    ("css-15v6roq", 2, "Input.lengthFallback", "input.ml", 10, 30, 10, 56);
    ("css-c7mp0s", 3, "Input.complexFallback", "input.ml", 14, 2, 15, 0);
    ("css-11x2ldz", 4, "Input.nested", "input.ml", 17, 22, 17, 65)]]
  [@@@css.bindings
    [("Input.plain", "css-ni5tn2");
    ("Input.withFallback", "css-isr9zh");
    ("Input.lengthFallback", "css-15v6roq");
    ("Input.complexFallback", "css-c7mp0s");
    ("Input.nested", "css-11x2ldz")]]
  let plain = CSS.make "css-ni5tn2" []
  let withFallback = CSS.make "css-isr9zh" []
  let lengthFallback = CSS.make "css-15v6roq" []
  let complexFallback = CSS.make "css-c7mp0s" []
  let nested = CSS.make "css-11x2ldz" []
