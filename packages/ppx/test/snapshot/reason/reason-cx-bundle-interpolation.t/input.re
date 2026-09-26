/* Selective atomization: only interpolating declarations that share the
   SAME source path bundle - one content-addressed class and one var per
   (source-path, runtime-type) across base / :hover / @media. Two
   declarations that merely both interpolate, but different, unrelated
   values, do NOT bundle: each mints its own real, slot-keyed class and
   merges independently. Static declarations keep their own shared atom
   class. Identical bundles dedup to identical class + var; different
   bundles never collide, so cross-module identity and CSS.merge stay
   correct. */

let color = CSS.Types.Color.toString(`hex("3A57FC"));
let width = CSS.px(10);
let accent = CSS.Types.Color.toString(`hex("00A67D"));

/* One value across base / :hover / @media collapses to one var, one inline
   custom property, three rules sharing the bundle class. */
let multiVariant = [%css
  {|
  color: $(color);
  &:hover {
    color: $(color);
  }
  @media (max-width: 768px) {
    color: $(color);
  }
|}
];

/* Interpolating declarations bundle; static `display: flex` keeps its own
   shared atom class. */
let mixed = [%css
  {|
  display: flex;
  color: $(color);
  &:hover {
    color: $(color);
  }
|}
];

/* Same path, different serializers (Width vs Height): two distinct vars in one
   bundle. */
let twoTypes = [%css
  {|
  width: $(width);
  &:hover {
    height: $(width);
  }
|}
];

/* Two unrelated interpolated values in one block: `color` and `accent`
   share no path, so neither needs the other's variable - each mints its
   own real, slot-keyed `_a_` class instead of one shared bundle. */
let separateValues = [%css
  {|
  color: $(color);
  background-color: $(accent);
|}
];

/* Mixed sharing: `color` is used twice (base + :hover) and must still
   share one variable between them; `accent` is used once in the same
   block and stays its own real atom, not swept into `color`'s bundle. */
let partialShare = [%css
  {|
  color: $(color);
  &:hover {
    color: $(color);
  }
  background-color: $(accent);
|}
];

/* Two anonymous blocks with a byte-identical interpolating bundle emit the same
   bundle class and var; the shared hover rule dedups to one. */
let _ = [%css {|
  color: red;
  &:hover {
    color: $(color);
  }
|}];

let _ = [%css {|
  display: flex;
  &:hover {
    color: $(color);
  }
|}];
