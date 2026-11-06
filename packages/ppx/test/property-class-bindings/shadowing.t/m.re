let m = [%css {||}];
let m = [%css "color: red;"];
let m = [%css "color: blue;"];

module Inner = {
  let m = [%css {||}];
  let m = [%css "color: green;"];
};

let card = [%css
  {|
  color: black;
  &.$(m) { color: purple; }
|}
];
