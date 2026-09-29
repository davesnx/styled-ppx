let q = [%css {|
  @media (min-width: 900px) { color: blue; }
|}];

let p = [%css {|
  @media (min-width: 600px) { color: red; }
|}];

let _ = (p, q);
