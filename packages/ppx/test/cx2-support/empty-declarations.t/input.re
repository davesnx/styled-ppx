[%cx2 ""];
[%cx2 {||}];
[%cx2 {js||js}];

/* `let _` is anonymous: no class is minted, preserves CSS.make("", []). */
let _ = [%cx2 {||}];

/* `let _a` is a named binding (the leading underscore only suppresses
   unused-variable warnings); the empty body mints a real class
   handle. */
let _a = [%cx2 ""];
let _a = [%cx2 {||}];
let _a = [%cx2 {js||js}];

let _a = [%cx2 "

"];

let _a = [%cx2 {|

|}];

let _a = [%cx2 {js|

|js}];
