let stack = [%cx "display: flex; flex-direction: column"];
let stackGap = gap => [%cx "gap: $(gap)"];

let selectors = [%cx {|
  color: red;

  &:hover {
    color: blue;
  }
|}];

let bounce = [%keyframe
  {|
  40% {
    transform: translate3d(0, -30px, 0);
  }

  70% {
    transform: translate3d(0, -15px, 0);
  }

  90% {
    transform: translate3d(0,-4px,0);
  }
|}
];

let code = [|`custom("Menlo"), `monospace|];
let lola = `auto;

let clx = [%cx
  {|
  animation-name: $(bounce);
  font-family: $(code);
  cursor: $(lola);
|}
];
