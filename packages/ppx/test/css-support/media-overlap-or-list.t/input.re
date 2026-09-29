let block = [%css {|
  @media (min-width: 600px), (min-width: 1200px) and (orientation: landscape) { color: red; }
  @media (min-width: 900px) { color: blue; }
|}];

let _ = block;
