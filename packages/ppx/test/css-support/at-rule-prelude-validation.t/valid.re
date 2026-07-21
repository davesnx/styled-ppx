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
