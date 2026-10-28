This test covers autoprefixer entries that emitted a prefixed property or
value no browser ever read, or that read the value with a different syntax
than the modern, unprefixed one:

- `mask-mode`/`mask-composite` never shipped as `-webkit-mask-mode` /
`-webkit-mask-composite` with the standard keywords (WebKit's
`-webkit-mask-composite` uses an unrelated keyword set).
- `-ms-grid-row`/`-ms-grid-column` only ever accepted a single line number,
not the modern `<start> / <end>` syntax.
- `-ms-scroll-snap-type` and old `-webkit-scroll-snap-type` predate the axis
keyword (`x`/`y`/`both`) and only accepted a bare strictness keyword.
- `margin-inline-start`/`-end` and `padding-inline-start`/`-end` prefix to
`-webkit-margin-start`/`-end` and `-webkit-padding-start`/`-end`: WebKit
drops "inline" from the name, it does not just add a vendor prefix to it.
- `-ms-writing-mode` reads `lr-tb`/`tb-rl`/... instead of
`horizontal-tb`/`vertical-rl`/....
- `-webkit-min-content` shipped in old WebKit/Blink, but Chrome 46+ and
Safari 11+ read unprefixed `min-content`; `-moz-min-content` stays for
Firefox before 66.
- `min-width: fill-available` (accepted directly, per the CSS Sizing draft)
prefixed its Firefox variant as `-moz-fill-available` instead of the real
`-moz-available`.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ cat > input.re << EOF
  > [%css {|mask-mode: alpha;|}];
  > [%css {|mask-composite: exclude;|}];
  > [%css {|grid-row: 1 / 3;|}];
  > [%css {|grid-column: 2;|}];
  > [%css {|scroll-snap-type: y mandatory;|}];
  > [%css {|margin-inline-start: 10px;|}];
  > [%css {|margin-inline-end: 10px;|}];
  > [%css {|padding-inline-start: 10px;|}];
  > [%css {|padding-inline-end: 10px;|}];
  > [%css {|writing-mode: vertical-rl;|}];
  > [%css {|min-width: min-content;|}];
  > [%css {|min-width: fill-available;|}];
  > EOF

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    (
      "._a_7y00e8dp5t{mask-mode:alpha;}",
      "_a_7y00e8dp5t",
      "0,1,0 own",
      "286",
      512,
      false,
    )
  ];
  [@css
    (
      "._a_7y003k57xj{mask-composite:exclude;}",
      "_a_7y003k57xj",
      "0,1,0 own",
      "286",
      128,
      false,
    )
  ];
  [@css
    (
      "._a_6j000cozaa{grid-row:1 / 3;}",
      "_a_6j000cozaa",
      "0,1,0 own",
      "235",
      12,
      false,
    )
  ];
  [@css
    (
      "._a_6j0003zjvj{grid-column:2;}",
      "_a_6j0003zjvj",
      "0,1,0 own",
      "235",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_ap8bwf{scroll-snap-type:y mandatory;}",
      "_a_ap8bwf",
      "0,1,0 own",
      "385",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_7r0002bip2{-webkit-margin-start:10px;margin-inline-start:10px;}",
      "_a_7r0002bip2",
      "0,1,0 own",
      "279",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_7r0001lgiv{-webkit-margin-end:10px;margin-inline-end:10px;}",
      "_a_7r0001lgiv",
      "0,1,0 own",
      "279",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_960002js84{-webkit-padding-start:10px;padding-inline-start:10px;}",
      "_a_960002js84",
      "0,1,0 own",
      "330",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_960001ob79{-webkit-padding-end:10px;padding-inline-end:10px;}",
      "_a_960001ob79",
      "0,1,0 own",
      "330",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_ehrbdf{-webkit-writing-mode:vertical-rl;writing-mode:vertical-rl;}",
      "_a_ehrbdf",
      "0,1,0 own",
      "521",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8creoz{min-width:-moz-min-content;min-width:min-content;}",
      "_a_8creoz",
      "0,1,0 own",
      "300",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_8ch21t{min-width:-webkit-fill-available;min-width:-moz-available;min-width:fill-available;}",
      "_a_8ch21t",
      "0,1,0 own",
      "300",
      1,
      false,
    )
  ];
  [@css.blocks
    [
      (1, "", [0]),
      (2, "", [1]),
      (3, "", [2]),
      (4, "", [3]),
      (5, "", [4]),
      (6, "", [5]),
      (7, "", [6]),
      (8, "", [7]),
      (9, "", [8]),
      (10, "", [9]),
      (11, "", [10]),
      (12, "", [11]),
    ]
  ];
  CSS.make("_a_7y00e8dp5t", []);
  CSS.make("_a_7y003k57xj", []);
  CSS.make("_a_6j000cozaa", []);
  CSS.make("_a_6j0003zjvj", []);
  CSS.make("_a_ap8bwf", []);
  CSS.make("_a_7r0002bip2", []);
  CSS.make("_a_7r0001lgiv", []);
  CSS.make("_a_960002js84", []);
  CSS.make("_a_960001ob79", []);
  CSS.make("_a_ehrbdf", []);
  CSS.make("_a_8creoz", []);
  CSS.make("_a_8ch21t", []);
