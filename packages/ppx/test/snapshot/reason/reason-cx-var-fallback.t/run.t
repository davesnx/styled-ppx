CSS3 `var(--name, fallback)` is admitted by the cx2 parser. The fallback
round-trips verbatim through the rendered stylesheet (linear-gradient,
nested `var()`, length values — anything goes inside the fallback slot).

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-ivpctn2{color:var(--theme);}"]
  [@@@css ".css-ivpc9zh{color:var(--theme-color, blue);}"]
  [@@@css ".css-ivpcroq{margin:var(--gap, 16px);}"]
  [@@@css
    ".css-ivpcp0s{background:var(--bg, linear-gradient(0deg, red, blue));}"]
  [@@@css ".css-ivpcldz{color:var(--theme, var(--fallback, red));}"]
  [@@@css.classes
    [("css-ivpctn2", 0, "Input.plain", "input.ml", 8, 21, 8, 42);
    ("css-ivpc9zh", 1, "Input.withFallback", "input.ml", 9, 28, 9, 61);
    ("css-ivpcroq", 2, "Input.lengthFallback", "input.ml", 10, 30, 10, 56);
    ("css-ivpcp0s", 3, "Input.complexFallback", "input.ml", 14, 2, 15, 0);
    ("css-ivpcldz", 4, "Input.nested", "input.ml", 17, 22, 17, 65)]]
  [@@@css.bindings
    [("Input.plain", "css-ivpctn2");
    ("Input.withFallback", "css-ivpc9zh");
    ("Input.lengthFallback", "css-ivpcroq");
    ("Input.complexFallback", "css-ivpcp0s");
    ("Input.nested", "css-ivpcldz")]]
  let plain = CSS.make "css-ivpctn2" []
  let withFallback = CSS.make "css-ivpc9zh" []
  let lengthFallback = CSS.make "css-ivpcroq" []
  let complexFallback = CSS.make "css-ivpcp0s" []
  let nested = CSS.make "css-ivpcldz" []
