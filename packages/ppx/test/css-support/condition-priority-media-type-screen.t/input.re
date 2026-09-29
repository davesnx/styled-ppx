let q = [%css {|
  @media screen and (min-width: 900px) { color: blue; }
|}];

let p = [%css {|
  @media screen and (min-width: 600px) { color: red; }
|}];

let _ = (p, q);
