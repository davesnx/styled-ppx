/* Interpolating declarations are atoms like static ones: each atom owns its var,
   named from the atom's class token, so one value across base / :hover /
   @media gives one var per atom. Identical declarations dedup to one class and
   var; different ones never collide, so cross-module identity and CSS.merge
   stay correct. */

let color = CSS.Types.Color.toString(`hex("3A57FC"));
let width = CSS.px(10);

/* One value across base / :hover / @media: three atoms, each with its own var
   and inline custom property. */
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

/* Interpolating declarations are atoms; static `display: flex` keeps its own
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

/* Same path, different serializers (Width vs Height): two distinct vars, one
   per atom. */
let twoTypes = [%css
  {|
  width: $(width);
  &:hover {
    height: $(width);
  }
|}
];

/* Two anonymous blocks with byte-identical interpolating declarations emit the
   same atoms and vars; the shared hover rule dedups to one. */
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
