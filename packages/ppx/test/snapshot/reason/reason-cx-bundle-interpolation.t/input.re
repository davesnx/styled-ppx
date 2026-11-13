/* A block has one class and one var per (source path, runtime type), shared
   by its base, :hover and @media rules. Static and interpolated declarations
   sit in the same rule. Two blocks never share a var, even when their content
   is the same, so a merge of two blocks keeps both values apart.
*/

let color = CSS.Types.Color.toString(`hex("3A57FC"));
let width = CSS.px(10);

/* One value across base / :hover / @media collapses to one var, one inline
   custom property, three rules on the block's class. */
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

/* Static `display: flex` and the interpolated `color` are in one rule on the
   block's class. */
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
   block. */
let twoTypes = [%css
  {|
  width: $(width);
  &:hover {
    height: $(width);
  }
|}
];

/* Two anonymous blocks with the same interpolated hover rule: each block has
   its own class and its own var. */
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
