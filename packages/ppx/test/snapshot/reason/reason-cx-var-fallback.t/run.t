CSS3 `var(--name, fallback)` is admitted by the cx2 parser. The fallback
round-trips verbatim through the rendered stylesheet (linear-gradient,
nested `var()`, length values — anything goes inside the fallback slot).

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css ".css-51tc9m-plain{color:var(--theme)}"]
  [@@@css ".css-2006c-withFallback{color:var(--theme-color,blue)}"]
  [@@@css ".css-8u48yv-lengthFallback{margin:var(--gap,16px)}"]
  [@@@css
    ".css-1285dga-complexFallback{background:var(--bg,linear-gradient(0deg,red,blue))}"]
  [@@@css ".css-1wp8kr-nested{color:var(--theme,var(--fallback,red))}"]
  [@@@css.bindings
    [("Input.plain", "css-51tc9m-plain");
    ("Input.withFallback", "css-2006c-withFallback");
    ("Input.lengthFallback", "css-8u48yv-lengthFallback");
    ("Input.complexFallback", "css-1285dga-complexFallback");
    ("Input.nested", "css-1wp8kr-nested")]]
  let plain = CSS.make "css-51tc9m-plain" []
  let withFallback = CSS.make "css-2006c-withFallback" []
  let lengthFallback = CSS.make "css-8u48yv-lengthFallback" []
  let complexFallback = CSS.make "css-1285dga-complexFallback" []
  let nested = CSS.make "css-1wp8kr-nested" []
