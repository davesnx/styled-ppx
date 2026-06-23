/* Selective atomization: a block's interpolating declarations share one
   content-addressed bundle class and one var per (source-path, runtime-type)
   across base / :hover / @media. Static declarations keep their own shared
   atom class. Identical bundles dedup to identical class + var; different
   bundles never collide, so cross-module identity and CSS.merge stay correct. */

let color = CSS.Types.Color.toString(`hex("3A57FC"));
let width = CSS.px(10);

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
