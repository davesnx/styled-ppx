let woo = [%cx2 "display: flex;"];

let css = main => [%cx2
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: flex;
|}
];

<div style={css(CSS.red)} />;
