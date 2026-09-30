/* [%styled.<tag>] components get the same `label:<ModuleName>` marker as
   [%css] bindings, through Dev_mode.marker, keyed off the module name the
   component is bound to - for both a static payload and a dynamic
   (labeled-argument function) payload. */

module Box = [%styled.div {| color: red; |}];

module Button = [%styled.button
  (~color: CSS.Types.Color.t) => {|
color: $(color);
|}
];
