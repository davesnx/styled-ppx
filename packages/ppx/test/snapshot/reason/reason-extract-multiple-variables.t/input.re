let css = (right, bottom, left) => [%cx2
  {|
  display: flex;
  margin: 8px $(right) $(bottom) $(left);
  background-color: $(CSS.black);
|}
];

<div styles={css(CSS.px(10), CSS.px(10), CSS.px(10))} />;

<span styles=[%cx2 "display: flex;"] />;
