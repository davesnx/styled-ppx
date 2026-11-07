let m = [%css {||}];
let card = [%css "color: red; &.$(m) { color: blue; }"];
