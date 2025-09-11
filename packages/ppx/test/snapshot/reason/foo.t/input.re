let css = main => [%cx2
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: fle;
|}
];

<div className={css(CSS.red)} />;
