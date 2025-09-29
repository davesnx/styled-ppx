let css = main => [%cx2
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: flex;

  .lola {
    display: flex;
  }
|}
];

<div className={css(CSS.red)} />;
