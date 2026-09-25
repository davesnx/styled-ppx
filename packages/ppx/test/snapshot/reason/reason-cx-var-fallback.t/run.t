CSS3 `var(--name, fallback)` is admitted by the cx2 parser. The fallback
round-trips verbatim through the rendered stylesheet (linear-gradient,
nested `var()`, length values — anything goes inside the fallback slot).

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".a-4etc9m{color:var(--theme);}"]
  [@@@css ".a-4ebdk9{color:var(--theme-color, blue);}"]
  [@@@css ".a-7p5tjf{margin:var(--gap, 16px);}"]
  [@@@css ".a-39b3vj{background:var(--bg, linear-gradient(0deg, red, blue));}"]
  [@@@css ".a-4e5a9q{color:var(--theme, var(--fallback, red));}"]
  [@@@css.bindings
    [("Input.plain", "id-10kpmqu", "a-4etc9m");
    ("Input.withFallback", "id-asai3x", "a-4ebdk9");
    ("Input.lengthFallback", "id-182qjjd", "a-7p5tjf");
    ("Input.complexFallback", "id-sn6ceu", "a-39b3vj");
    ("Input.nested", "id-swo4az", "a-4e5a9q")]]
  let plain = CSS.make "label:plain id-10kpmqu a-4etc9m" []
  let withFallback = CSS.make "label:withFallback id-asai3x a-4ebdk9" []
  let lengthFallback = CSS.make "label:lengthFallback id-182qjjd a-7p5tjf" []
  let complexFallback = CSS.make "label:complexFallback id-sn6ceu a-39b3vj" []
  let nested = CSS.make "label:nested id-swo4az a-4e5a9q" []
