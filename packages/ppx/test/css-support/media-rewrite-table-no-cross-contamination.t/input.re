let block = [%css {|
  @media (min-width: 600px) { color: red; }
  @media (min-width: 900px) { color: blue; }
  @media (min-width: 600px) { width: 10px; }
  @media (min-width: 600px) {
    @media (orientation: landscape) { height: 1px; }
    @media (orientation: portrait) { height: 2px; }
  }
|}];

let _ = block;
