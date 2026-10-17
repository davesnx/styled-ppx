/* Selective atomization: only interpolating declarations that share the
   SAME source path share a variable - one var per (source-path,
   runtime-type) across base / :hover / @media, each declaration still its
   own real, slot-keyed class. Two declarations that merely both
   interpolate, but different, unrelated values, share nothing and merge
   independently. Static declarations keep their own shared atom class.
   Identical groups dedup to identical classes + var; different groups never
   collide, so cross-module identity and CSS.merge stay correct. */

let color = CSS.Types.Color.toString(`hex("3A57FC"));
let width = CSS.px(10);
let accent = CSS.Types.Color.toString(`hex("00A67D"));

/* One value across base / :hover / @media collapses to one var and one inline
   custom property, read by three rules with a class each. */
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

/* Interpolating declarations share a var; static `display: flex` keeps its own
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
   group. */
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
   own real, slot-keyed `_a_` class instead of sharing a variable. */
let separateValues = [%css
  {|
  color: $(color);
  background-color: $(accent);
|}
];

/* Mixed sharing: `color` is used twice (base + :hover) and must still
   share one variable between them; `accent` is used once in the same
   block and stays its own real atom, not swept into `color`'s group. */
let partialShare = [%css
  {|
  color: $(color);
  &:hover {
    color: $(color);
  }
  background-color: $(accent);
|}
];

/* Two anonymous blocks with a byte-identical interpolating group emit the same
   classes and var; the shared hover rule dedups to one. */
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
