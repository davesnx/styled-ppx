let child = [%css {||}];

let hoverParent = [%css {|
  &:hover .$(child) { color: red; }
|}];

let linkOther = [%css {|
  &:link { color: blue; }
|}];

let _ = (child, hoverParent, linkOther);
