let woo = [%cx2 "display: flex;"];

let css = main => [%cx2
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: flex;
|}
];

<div styles={css(CSS.red)} />;

let maybe_css = Some([%cx2 {|
  display: flex;
|}]);

<div styles=?maybe_css />;
