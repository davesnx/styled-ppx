CSS3 `var(--name, fallback)` is admitted by the cx2 parser. The fallback
round-trips verbatim through the rendered stylesheet (linear-gradient,
nested `var()`, length values — anything goes inside the fallback slot).

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".a-51tc9m{color:var(--theme);}"]
  [@@@css ".a-1c6bdk9{color:var(--theme-color, blue);}"]
  [@@@css ".a-11h5tjf{margin:var(--gap, 16px);}"]
  [@@@css ".a-chb3vj{background:var(--bg, linear-gradient(0deg, red, blue));}"]
  [@@@css ".a-1cn5a9q{color:var(--theme, var(--fallback, red));}"]
  [@@@css.bindings
    [("Input.plain", "id-10kpmqu", "a-51tc9m");
    ("Input.withFallback", "id-asai3x", "a-1c6bdk9");
    ("Input.lengthFallback", "id-182qjjd", "a-11h5tjf");
    ("Input.complexFallback", "id-sn6ceu", "a-chb3vj");
    ("Input.nested", "id-swo4az", "a-1cn5a9q")]]
  let plain = CSS.make "label:plain id-10kpmqu a-51tc9m" []
  let withFallback = CSS.make "label:withFallback id-asai3x a-1c6bdk9" []
  let lengthFallback = CSS.make "label:lengthFallback id-182qjjd a-11h5tjf" []
  let complexFallback = CSS.make "label:complexFallback id-sn6ceu a-chb3vj" []
  let nested = CSS.make "label:nested id-swo4az a-1cn5a9q" []
