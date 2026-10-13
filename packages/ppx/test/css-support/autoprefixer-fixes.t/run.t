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
  [@css "._a_7y0e8dp5t{mask-mode:alpha;}"];
  [@css "._a_7y03k57xj{mask-composite:exclude;}"];
  [@css "._a_6j00cozaa{grid-row:1 / 3;}"];
  [@css "._a_6j003zjvj{grid-column:2;}"];
  [@css "._a_ap8bwf{scroll-snap-type:y mandatory;}"];
  [@css "._a_7r002bip2{-webkit-margin-start:10px;margin-inline-start:10px;}"];
  [@css "._a_7r001lgiv{-webkit-margin-end:10px;margin-inline-end:10px;}"];
  [@css "._a_96002js84{-webkit-padding-start:10px;padding-inline-start:10px;}"];
  [@css "._a_96001ob79{-webkit-padding-end:10px;padding-inline-end:10px;}"];
  [@css
    "._a_ehrbdf{-webkit-writing-mode:vertical-rl;writing-mode:vertical-rl;}"
  ];
  [@css "._a_8creoz{min-width:-moz-min-content;min-width:min-content;}"];
  [@css
    "._a_8ch21t{min-width:-webkit-fill-available;min-width:-moz-available;min-width:fill-available;}"
  ];
  CSS.make("_a_7y0e8dp5t", []);
  CSS.make("_a_7y03k57xj", []);
  CSS.make("_a_6j00cozaa", []);
  CSS.make("_a_6j003zjvj", []);
  CSS.make("_a_ap8bwf", []);
  CSS.make("_a_7r002bip2", []);
  CSS.make("_a_7r001lgiv", []);
  CSS.make("_a_96002js84", []);
  CSS.make("_a_96001ob79", []);
  CSS.make("_a_ehrbdf", []);
  CSS.make("_a_8creoz", []);
  CSS.make("_a_8ch21t", []);
