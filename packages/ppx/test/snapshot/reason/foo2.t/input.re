let css = main => [%cx
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: flex;
|}
];

<div className={css(CSS.red)} />;
