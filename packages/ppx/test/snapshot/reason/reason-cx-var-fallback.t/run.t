CSS3 `var(--name, fallback)` is admitted by the cx2 parser. The fallback
round-trips verbatim through the rendered stylesheet (linear-gradient,
nested `var()`, length values — anything goes inside the fallback slot).

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-51tc9m-plain{color:var(--theme);}"]
  [@@@css ".css-1c6bdk9-withFallback{color:var(--theme-color, blue);}"]
  [@@@css ".css-11h5tjf-lengthFallback{margin:var(--gap, 16px);}"]
  [@@@css
    ".css-chb3vj-complexFallback{background:var(--bg, linear-gradient(0deg, red, blue));}"]
  [@@@css ".css-1cn5a9q-nested{color:var(--theme, var(--fallback, red));}"]
  [@@@css.bindings
    [("Input.plain", "cid-10kpmqu", "css-51tc9m-plain");
    ("Input.withFallback", "cid-asai3x", "css-1c6bdk9-withFallback");
    ("Input.lengthFallback", "cid-182qjjd", "css-11h5tjf-lengthFallback");
    ("Input.complexFallback", "cid-sn6ceu", "css-chb3vj-complexFallback");
    ("Input.nested", "cid-swo4az", "css-1cn5a9q-nested")]]
  let plain = CSS.make "cid-10kpmqu css-51tc9m-plain" []
  let withFallback = CSS.make "cid-asai3x css-1c6bdk9-withFallback" []
  let lengthFallback = CSS.make "cid-182qjjd css-11h5tjf-lengthFallback" []
  let complexFallback = CSS.make "cid-sn6ceu css-chb3vj-complexFallback" []
  let nested = CSS.make "cid-swo4az css-1cn5a9q-nested" []
