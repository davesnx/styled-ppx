let hover = [%css {| &:hover { color: red; } |}];
let focus = [%css {| &:focus { color: blue; } |}];

let _ = CSS.className([%css {|
  &:focus { color: blue; }
  &:hover { color: red; }
|}]);

let _ = (hover, focus);
