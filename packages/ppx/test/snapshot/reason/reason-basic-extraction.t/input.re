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

let fadeIn = [%keyframe2 {|
  from { opacity: 0; }
  to { opacity: 1; }
|}];

let slideIn = [%keyframe2 {|
  0% { transform: translateX(-100%); }
  100% { transform: translateX(0); }
|}];

[%styled.global2 {|
  body {
    margin: 0;
    padding: 0;
  }

  * {
    box-sizing: border-box;
  }
|}];

<div className={css(CSS.red)} />;
