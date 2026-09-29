let block = [%css {|
  @media (min-width: calc(2px + 1px)) { color: red; }
  @media (min-width: calc(1000px - 2%)) { color: red; }
|}];

let _ = block;
