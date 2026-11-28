let blue = CSS.blue;
let tone = [%css "color: $(blue)"];
let host = [%css "&.$(tone) { padding: 1px; }"];
let tag = "span";
let tagged = [%css "& $(tag) { color: red; }"];
