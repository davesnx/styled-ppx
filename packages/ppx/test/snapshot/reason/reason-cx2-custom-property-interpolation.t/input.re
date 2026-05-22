/* Custom-property declarations in [%css] accept any string interpolation
   verbatim - no Cascading.toString wrap, no validation, just passthrough.
   The expression must be a [string]; whatever it contains is the
   responsibility of the caller (matches the contract of CSS.unsafe).

   This is the "unsafe escape hatch" for `--*` declarations until typed
   custom-property declarations land. See
   `packages/ppx/src/Css_file.re`'s `CustomProperty` var_type. */

let colorStr = CSS.Types.Color.toString(`hex("3A57FC"));
let plainStr = "10px";

/* Whole-value interpolation: the canonical case from the bug report. */
let row = [%css {|
  --color-link: $(colorStr);
|}];

/* Multiple custom-property declarations sharing one block. */
let theme = [%css
  {|
  --color-link: $(colorStr);
  --spacing: $(plainStr);
|}
];

/* Function param: the [string] requirement is enforced through normal
   type inference. */
let dyn = value => [%css {|
  --token: $(value);
|}];
