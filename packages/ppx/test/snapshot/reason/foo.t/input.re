let px100 = CSS.px(100);

let css = main => [%cx2
  {|
  color: $(main);
  background-color: $(CSS.black);
  flex: 1 1 $(px100);
  display: flex;

  .lola {
    display: flex;
  }
|}
];

<div className={css(CSS.red)} />;
