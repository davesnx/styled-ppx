let m = [%css {||}];

let card = [%css
  {|
  color: black;
  &.$(m) { color: green; }
  &:not(.$(m)) { color: red; }
|}
];

module Inner = {
  let m = [%css {||}];
};
