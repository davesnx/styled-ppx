Golden hashes: a stable pin on the classNames produced for representative
[%css] shapes. Class names are derived from the rendered declaration text via Hash64, so any
change to `Render` (whitespace, escaping, numeric formatting), to atomization,
or to Hash64 cascades into every emitted className.

Without this pin, a no-op-intended refactor silently busts every cached
className downstream — browser caches, CDN caches, persisted DOM
identifiers all break. Update this test only when the change is intended;
the diff IS the blast radius.

  $ ../../../standalone.exe --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css.atoms
    [("_a7fadbhEW", ["._a7fadbhEW{color:red;}"], 1, 0, 1,
       [("value", "adbhEW", "val\\07f\\0& | \\0color:red")]);
    ("_actal1K5c", ["._actal1K5c{margin:10px;}"], 1, 0, 4,
      [("value", "al1K5c", "val\\0ct\\0& | \\0margin:10px")]);
    ("_afyhaCP9E", ["._afyhaCP9E{padding:20px;}"], 1, 0, 4,
      [("value", "haCP9E", "val\\0fy\\0& | \\0padding:20px")]);
    ("_a7fCPHFf-", ["._a7fCPHFf-{color:blue;}"], 1, 0, 1,
      [("value", "CPHFf-", "val\\07f\\0& | \\0color:blue")]);
    ("_a7fn70fsU", ["._a7fn70fsU{color:black;}"], 1, 0, 1,
      [("value", "n70fsU", "val\\07f\\0& | \\0color:black")]);
    ("_c7f1Tl5-wX5Zn_K", ["._c7f1Tl5-wX5Zn_K:hover{color:white;}"], 2, 1, 1,
      [("ctx", "1Tl5-w", "ctx\\0&:hover | ");
      ("value", "X5Zn_K", "val\\07f\\0&:hover | \\0color:white")]);
    ("_bAC7f5JrtD67ffiDtDHWBs5rK",
      ["._bAC7f5JrtD67ffiDtDHWBs5rK .a{color:green;}";
      "._bAC7f5JrtD67ffiDtDHWBs5rK .b{color:green;}"], 0, 1, 2,
      [("ctx", "5JrtD6", "ctx\\0& .a | ");
      ("ctx", "fiDtDH", "ctx\\0& .b | ");
      ("value", "WBs5rK",
        "bval\\0& .a | \\07f\\0color:green\\0& .b | \\07f\\0color:green")]);
    ("_c7fP3RA54yz8J2j",
      ["@media (min-width:768px){._c7fP3RA54yz8J2j .a{color:red;}}"], 0, 2, 1,
      [("ctx", "P3RA54", "ctx\\0& .a | @media (min-width:768px) | ");
      ("value", "yz8J2j",
        "val\\07f\\0& .a | @media (min-width:768px) | \\0color:red")]);
    ("_an8qYbiEc", ["._an8qYbiEc{width:1.5rem;}"], 1, 0, 1,
      [("value", "qYbiEc", "val\\0n8\\0& | \\0width:1.5rem")]);
    ("_af9B4nh92", ["._af9B4nh92{opacity:0.5;}"], 1, 0, 1,
      [("value", "B4nh92", "val\\0f9\\0& | \\0opacity:0.5")]);
    ("_a7fLyB3G1", ["._a7fLyB3G1{color:var(--theme, blue);}"], 1, 0, 1,
      [("value", "LyB3G1", "val\\07f\\0& | \\0color:var(--theme, blue)")]);
    ("_ijxrs__xh", [], 1, 0, 0,
      [("id", "_ijxrs__xh", "bind\\0\\0Input\\0\\0solid\\00")]);
    ("_i3CYVHwSU", [], 1, 0, 0,
      [("id", "_i3CYVHwSU", "bind\\0\\0Input\\0\\0multi\\00")]);
    ("_i-QpDUWl7", [], 1, 0, 0,
      [("id", "_i-QpDUWl7", "bind\\0\\0Input\\0\\0hovered\\00")]);
    ("_iRbdWAU7_", [], 1, 0, 0,
      [("id", "_iRbdWAU7_", "bind\\0\\0Input\\0\\0multiSel\\00")]);
    ("_ivioO1pp-", [], 1, 0, 0,
      [("id", "_ivioO1pp-", "bind\\0\\0Input\\0\\0withMedia\\00")]);
    ("_iz9h8px1z", [], 1, 0, 0,
      [("id", "_iz9h8px1z", "bind\\0\\0Input\\0\\0units\\00")]);
    ("_iIOXhQNdE", [], 1, 0, 0,
      [("id", "_iIOXhQNdE", "bind\\0\\0Input\\0\\0withFallback\\00")])]]
  [@@@css.bindings
    [("Input.solid", "_ijxrs__xh _a7fadbhEW", "_ijxrs__xh");
    ("Input.multi", "_i3CYVHwSU _actal1K5c _afyhaCP9E _a7fCPHFf-",
      "_i3CYVHwSU");
    ("Input.hovered", "_i-QpDUWl7 _a7fn70fsU _c7f1Tl5-wX5Zn_K", "_i-QpDUWl7");
    ("Input.multiSel", "_iRbdWAU7_ _bAC7f5JrtD67ffiDtDHWBs5rK", "_iRbdWAU7_");
    ("Input.withMedia", "_ivioO1pp- _c7fP3RA54yz8J2j", "_ivioO1pp-");
    ("Input.units", "_iz9h8px1z _an8qYbiEc _af9B4nh92", "_iz9h8px1z");
    ("Input.withFallback", "_iIOXhQNdE _a7fLyB3G1", "_iIOXhQNdE")]]
  let solid = CSS.make "_ijxrs__xh _a7fadbhEW" []
  let multi = CSS.make "_i3CYVHwSU _actal1K5c _afyhaCP9E _a7fCPHFf-" []
  let hovered = CSS.make "_i-QpDUWl7 _a7fn70fsU _c7f1Tl5-wX5Zn_K" []
  let multiSel = CSS.make "_iRbdWAU7_ _bAC7f5JrtD67ffiDtDHWBs5rK" []
  let withMedia = CSS.make "_ivioO1pp- _c7fP3RA54yz8J2j" []
  let units = CSS.make "_iz9h8px1z _an8qYbiEc _af9B4nh92" []
  let withFallback = CSS.make "_iIOXhQNdE _a7fLyB3G1" []
