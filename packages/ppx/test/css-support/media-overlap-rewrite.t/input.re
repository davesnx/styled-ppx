let block = [%css {|
  @media (min-width: 600px) { color: red; }
  @media (min-width: 900px) { color: blue; }
|}];

let _ = block;
