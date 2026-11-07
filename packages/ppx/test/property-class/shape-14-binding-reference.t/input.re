let plain = [%css "color: green; padding: 1px"];
let card = [%css
  {|
  &.$(plain) { color: red }
  & .$(plain) { color: blue }
  &:not(.$(plain)) { color: black }
|}
];
