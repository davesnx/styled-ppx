CSS3 `var(--name, fallback)` is admitted by the cx2 parser. The fallback
round-trips verbatim through the rendered stylesheet (linear-gradient,
nested `var()`, length values — anything goes inside the fallback slot).

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-51tc9m{color:var(--theme);}"]
  [@@@css ".css-1c6bdk9{color:var(--theme-color, blue);}"]
  [@@@css ".css-11h5tjf{margin:var(--gap, 16px);}"]
  [@@@css
    ".css-chb3vj{background:var(--bg, linear-gradient(0deg, red, blue));}"]
  [@@@css ".css-1cn5a9q{color:var(--theme, var(--fallback, red));}"]
  [@@@css.bindings
    [("Input.plain", "cid-10kpmqu", "css-51tc9m");
    ("Input.withFallback", "cid-asai3x", "css-1c6bdk9");
    ("Input.lengthFallback", "cid-182qjjd", "css-11h5tjf");
    ("Input.complexFallback", "cid-sn6ceu", "css-chb3vj");
    ("Input.nested", "cid-swo4az", "css-1cn5a9q")]]
  let plain = CSS.make "label:plain cid-10kpmqu css-51tc9m" []
  let withFallback = CSS.make "label:withFallback cid-asai3x css-1c6bdk9" []
  let lengthFallback =
    CSS.make "label:lengthFallback cid-182qjjd css-11h5tjf" []
  let complexFallback =
    CSS.make "label:complexFallback cid-sn6ceu css-chb3vj" []
  let nested = CSS.make "label:nested cid-swo4az css-1cn5a9q" []
