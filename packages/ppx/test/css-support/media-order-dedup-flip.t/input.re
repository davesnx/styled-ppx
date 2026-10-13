let blockA = [%css {|
  @media (min-width: 600px) { color: red; }
  @media (min-width: 900px) { color: blue; }
|}];

let blockB = [%css {|
  @media (min-width: 900px) { color: blue; }
  @media (min-width: 600px) { color: red; }
|}];

let _ = (blockA, blockB);
