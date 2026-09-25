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
- `-webkit-min-content` never existed (old WebKit's alias was the unrelated
`min-intrinsic` keyword); only Firefox needed a prefix for `min-content`.
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
  [@css ".css-1avdp5t{mask-mode:alpha;}"];
  [@css ".css-1dn57xj{mask-composite:exclude;}"];
  [@css ".css-9nozaa{grid-row:1 / 3;}"];
  [@css ".css-1skzjvj{grid-column:2;}"];
  [@css ".css-sj8bwf{scroll-snap-type:y mandatory;}"];
  [@css ".css-14lbip2{-webkit-margin-start:10px;margin-inline-start:10px;}"];
  [@css ".css-avlgiv{-webkit-margin-end:10px;margin-inline-end:10px;}"];
  [@css ".css-i5js84{-webkit-padding-start:10px;padding-inline-start:10px;}"];
  [@css ".css-1kwob79{-webkit-padding-end:10px;padding-inline-end:10px;}"];
  [@css
    ".css-zorbdf{-webkit-writing-mode:vertical-rl;writing-mode:vertical-rl;}"
  ];
  [@css ".css-vlreoz{min-width:-moz-min-content;min-width:min-content;}"];
  [@css
    ".css-ath21t{min-width:-webkit-fill-available;min-width:-moz-available;min-width:fill-available;}"
  ];
  CSS.make("css-1avdp5t", []);
  CSS.make("css-1dn57xj", []);
  CSS.make("css-9nozaa", []);
  CSS.make("css-1skzjvj", []);
  CSS.make("css-sj8bwf", []);
  CSS.make("css-14lbip2", []);
  CSS.make("css-avlgiv", []);
  CSS.make("css-i5js84", []);
  CSS.make("css-1kwob79", []);
  CSS.make("css-zorbdf", []);
  CSS.make("css-vlreoz", []);
  CSS.make("css-ath21t", []);
