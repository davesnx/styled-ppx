/* Same input as dev-mode-marker-styled.t but with production selected, to
   lock in that the `label:<ModuleName>` marker disappears for styled
   components in production too, same as it does for [%css] bindings. */

module Box = [%styled.div {| color: red; |}];

module Button = [%styled.button
  (~color: CSS.Types.Color.t) => {|
color: $(color);
|}
];
