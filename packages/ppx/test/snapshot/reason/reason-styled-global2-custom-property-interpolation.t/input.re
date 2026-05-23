/* Custom-property declarations in [%styled.global] accept any string
   interpolation verbatim - mirrors the [%css] behaviour. The generated
   `to_string` emits the value with no `Cascading.toString` wrap, so any
   `string` expression flows straight into the `:root { --foo: ...; }`
   block. */

let primary = CSS.Types.Color.toString(`hex("3A57FC"));
let gutter = "16px";

module Theme = [%styled.global
  {|
  :root {
    --color-primary: $(primary);
    --gutter: $(gutter);
  }
|}
];
