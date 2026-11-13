let red = CSS.red;
let blue = CSS.blue;

let a1 = c => [%css "color: $(c)"];
let b1 = c => [%css "color: $(c)"];

let a2 = x => [%css "color: $(x)"];
let b2 = y => [%css "color: $(y)"];

let b3 = c => [%css "color: $(c); background-color: $(c)"];

let own = c => [%css "border-color: $(c)"];

let direct = c => [%css "& > * { color: $(c) }"];
let desc = c => [%css "& .child { color: $(c) }"];

let f = x => [%css "color: $(x)"];

let tone = [%css "color: $(blue)"];
let host = [%css "&.$(tone) { outline-color: $(red) }"];

