let css = main => [%cx
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: flex;
|}
];

<div style={css(CSS.red)} />;
