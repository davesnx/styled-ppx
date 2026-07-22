/* All of these must keep compiling: structurally valid preludes with known
   feature names, in every supported form. */
let _plain = [%css "@media (min-width: 768px) { color: red; }"];
let _boolean = [%css "@media (monochrome) { color: red; }"];
let _range = [%css "@media (500px <= width <= 700px) { color: red; }"];
let _media_type = [%css "@media screen and (orientation: landscape) { color: red; }"];
let _nested = [%css
  "@media ((min-width: 30em) and (max-width: 60em)) { color: red; }"
];
let _discrete = [%css "@media (prefers-color-scheme: dark) { color: red; }"];
let _container_query = [%css "@container (inline-size > 40em) { color: red; }"];
/* @supports probes syntax the compiler may not know; it is exempt from deep
   validation by design. */
let _supports_unknown = [%css
  "@supports (some-future-property: banana) { color: red; }"
];
/* Feature values nesting functions skip value validation (the feature
   grammars only model literal values) but names are still checked. */
let _calc_value = [%css
  "@media (min-width: calc(700px + 2em)) { color: red; }"
];
/* Vendor media features (compat spec / historical spellings). */
let _webkit_dpr = [%css
  "@media (-webkit-min-device-pixel-ratio: 2) { color: red; }"
];
let _moz_dpr = [%css
  "@media (min--moz-device-pixel-ratio: 2) { color: red; }"
];
let _webkit_dpr_fractional = [%css
  "@media (-webkit-device-pixel-ratio: 1.5) { color: red; }"
];
/* Feature values are validated per value class: <extended-length>,
   <ratio>, <resolution>, <integer>, and discrete keyword sets. */
let _length_value = [%css "@media (device-width: 320px) { color: red; }"];
let _ratio_value = [%css "@media (aspect-ratio: 16/9) { color: red; }"];
let _ratio_number = [%css "@media (device-aspect-ratio: 1.777) { color: red; }"];
let _resolution_value = [%css "@media (min-resolution: 2dppx) { color: red; }"];
/* MQ4: 'infinite' for media without resolution limits. */
let _resolution_infinite = [%css "@media (resolution: infinite) { color: red; }"];
let _integer_value = [%css "@media (color: 8) { color: red; }"];
let _integer_segments = [%css
  "@media (horizontal-viewport-segments: 2) { color: red; }"
];
/* grid takes 0 | 1 per spec; any <integer> is accepted here. */
let _grid_value = [%css "@media (grid: 1) { color: red; }"];
let _keyword_scan = [%css "@media (scan: interlace) { color: red; }"];
let _keyword_overflow = [%css
  "@media (overflow-block: paged) and (overflow-inline: scroll) { color: red; }"
];
let _keyword_reduced_data = [%css
  "@media (prefers-reduced-data: reduce) { color: red; }"
];
let _keyword_dynamic_range = [%css
  "@media (video-dynamic-range: high) { color: red; }"
];
/* Range forms validate their comparison operands against the same
   grammars as colon-form values. */
let _range_operand = [%css "@media (width >= 400px) { color: red; }"];
let _range_ratio = [%css "@media (aspect-ratio > 4/3) { color: red; }"];
/* @container size features share the media grammars (plus the
   container-only inline-size/block-size). */
let _container_plain = [%css "@container (inline-size: 400px) { color: red; }"];
let _container_range = [%css "@container (block-size < 650px) { color: red; }"];
let _container_orientation = [%css
  "@container (orientation: landscape) { color: red; }"
];
/* min-/max- forms for range-type container size features. */
let _container_named_min_width = [%css
  "@container sidebar (min-width: 400px) { color: red; }"
];
let _container_max_width = [%css
  "@container (max-width: 600px) { color: red; }"
];
let _container_min_inline_size = [%css
  "@container (min-inline-size: 20em) { color: red; }"
];
let _container_max_aspect_ratio = [%css
  "@container (max-aspect-ratio: 16/9) { color: red; }"
];
let _container_open_range = [%css
  "@container (400px <= width) { color: red; }"
];
