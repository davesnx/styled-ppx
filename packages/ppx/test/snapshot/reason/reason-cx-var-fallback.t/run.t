CSS3 `var(--name, fallback)` is admitted by the cx2 parser. The fallback
round-trips verbatim through the rendered stylesheet (linear-gradient,
nested `var()`, length values — anything goes inside the fallback slot).

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css.atoms
    [("_a7fZCCIz6", ["._a7fZCCIz6{color:var(--theme);}"], 1, 0, 1,
       [("value", "ZCCIz6", "val\\07f\\0& | \\0color:var(--theme)")]);
    ("_a7fJ48b5_", ["._a7fJ48b5_{color:var(--theme-color, blue);}"], 1, 0, 1,
      [("value", "J48b5_", "val\\07f\\0& | \\0color:var(--theme-color, blue)")]);
    ("_actfbTeeN", ["._actfbTeeN{margin:var(--gap, 16px);}"], 1, 0, 4,
      [("value", "fbTeeN", "val\\0ct\\0& | \\0margin:var(--gap, 16px)")]);
    ("_a4hpv6l0t",
      ["._a4hpv6l0t{background:var(--bg, linear-gradient(0deg, red, blue));}"],
      1, 0, 9,
      [("value", "pv6l0t",
         "val\\04h\\0& | \\0background:var(--bg, linear-gradient(0deg, red, blue))")]);
    ("_a7fUdcllx", ["._a7fUdcllx{color:var(--theme, var(--fallback, red));}"],
      1, 0, 1,
      [("value", "Udcllx",
         "val\\07f\\0& | \\0color:var(--theme, var(--fallback, red))")]);
    ("_iHxrM1VrW", [], 1, 0, 0,
      [("id", "_iHxrM1VrW", "bind\\0\\0Input\\0\\0plain\\00")]);
    ("_iIOXhQNdE", [], 1, 0, 0,
      [("id", "_iIOXhQNdE", "bind\\0\\0Input\\0\\0withFallback\\00")]);
    ("_i3HrPEnDG", [], 1, 0, 0,
      [("id", "_i3HrPEnDG", "bind\\0\\0Input\\0\\0lengthFallback\\00")]);
    ("_iWwdNYhhG", [], 1, 0, 0,
      [("id", "_iWwdNYhhG", "bind\\0\\0Input\\0\\0complexFallback\\00")]);
    ("_iQIM0ep0T", [], 1, 0, 0,
      [("id", "_iQIM0ep0T", "bind\\0\\0Input\\0\\0nested\\00")])]]
  [@@@css.bindings
    [("Input.plain", "_iHxrM1VrW _a7fZCCIz6", "_iHxrM1VrW");
    ("Input.withFallback", "_iIOXhQNdE _a7fJ48b5_", "_iIOXhQNdE");
    ("Input.lengthFallback", "_i3HrPEnDG _actfbTeeN", "_i3HrPEnDG");
    ("Input.complexFallback", "_iWwdNYhhG _a4hpv6l0t", "_iWwdNYhhG");
    ("Input.nested", "_iQIM0ep0T _a7fUdcllx", "_iQIM0ep0T")]]
  let plain = CSS.make "_iHxrM1VrW _a7fZCCIz6" []
  let withFallback = CSS.make "_iIOXhQNdE _a7fJ48b5_" []
  let lengthFallback = CSS.make "_i3HrPEnDG _actfbTeeN" []
  let complexFallback = CSS.make "_iWwdNYhhG _a4hpv6l0t" []
  let nested = CSS.make "_iQIM0ep0T _a7fUdcllx" []
