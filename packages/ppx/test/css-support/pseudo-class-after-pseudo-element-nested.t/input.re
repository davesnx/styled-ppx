/* The same selector reached through nesting: `&::after { &:focus { ... } }`
   resolves to `&::after:focus`. The error points at the inner selector. */
let _x = [%css {|
  &::after {
    &:focus { color: red; }
  }
|}];
