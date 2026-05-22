[%css ""];
[%css {||}];
[%css {js||js}];

/* `let _` is anonymous: no class is minted, preserves CSS.make("", []). */
let _ = [%css {||}];

/* `let _a` is a named binding (the leading underscore only suppresses
   unused-variable warnings); the empty body mints a real class
   handle. */
let _a = [%css ""];
let _a = [%css {||}];
let _a = [%css {js||js}];

let _a = [%css "

"];

let _a = [%css {|

|}];

let _a = [%css {js|

|js}];
