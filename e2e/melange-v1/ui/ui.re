let stack = [%cx "display: flex; flex-direction: column"];
let stackGap = gap => [%cx "gap: $(gap)"];

let selectors = [%cx {|
  color: red;

  &:hover {
    color: blue;
  }
|}];
