CSS3 `var(--name, fallback)` is admitted by the cx2 parser. The fallback
round-trips verbatim through the rendered stylesheet (linear-gradient,
nested `var()`, length values — anything goes inside the fallback slot).

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "._a_4etc9m{color:var(--theme);}"]
  [@@@css "._a_4ebdk9{color:var(--theme-color, blue);}"]
  [@@@css "._a_7p5tjf{margin:var(--gap, 16px);}"]
  [@@@css
    "._a_39b3vj{background:var(--bg, linear-gradient(0deg, red, blue));}"]
  [@@@css "._a_4e5a9q{color:var(--theme, var(--fallback, red));}"]
  [@@@css.bindings
    [("Input.plain", "_id_10kpmqu", "_a_4etc9m");
    ("Input.withFallback", "_id_asai3x", "_a_4ebdk9");
    ("Input.lengthFallback", "_id_182qjjd", "_a_7p5tjf");
    ("Input.complexFallback", "_id_sn6ceu", "_a_39b3vj");
    ("Input.nested", "_id_swo4az", "_a_4e5a9q")]]
  let plain = CSS.make "label:plain _id_10kpmqu _a_4etc9m" []
  let withFallback = CSS.make "label:withFallback _id_asai3x _a_4ebdk9" []
  let lengthFallback = CSS.make "label:lengthFallback _id_182qjjd _a_7p5tjf" []
  let complexFallback =
    CSS.make "label:complexFallback _id_sn6ceu _a_39b3vj" []
  let nested = CSS.make "label:nested _id_swo4az _a_4e5a9q" []
