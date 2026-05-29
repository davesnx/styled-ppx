let previousHeight = 20;
let currentHeight = 80;

let prev = `px(previousHeight);
let current = `px(currentHeight);

let animation = [%keyframe {|
  0% { height: $(prev) }
  100% { height: $(current) }
|}];

let styles = [%css {|
  animation-name: $(animation);
  animation-duration: 180ms;
|}];

let shorthand = [%css {|
  animation: $(animation) 180ms ease-out 0s 1 normal both;
|}];
