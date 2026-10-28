let sides = [%css {|
  @media (min-width: 600px) { margin-top: 1px; }
  @media (min-width: 900px) { margin-bottom: 2px; }
|}];

let color_then_width = [%css {|
  @media (min-width: 600px) { border-top-color: red; }
  @media (min-width: 900px) { border-width: 2px; }
|}];

let shorthand_then_side = [%css {|
  @media (min-width: 600px) { margin: 1px; }
  @media (min-width: 900px) { margin-top: 2px; }
|}];

let side_then_shorthand = [%css {|
  @media (min-width: 600px) { padding-top: 1px; }
  @media (min-width: 900px) { padding: 2px; }
|}];

let side_first = [%css {|
  @media (min-width: 900px) { margin-left: 2px; }
|}];

let shorthand_second = [%css {|
  @media (min-width: 600px) { margin: 3px; }
|}];

let _ = (sides, color_then_width, shorthand_then_side, side_then_shorthand);
let _ = CSS.merge(shorthand_second, side_first);
