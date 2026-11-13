type r = {cls: string};
let r = {cls: "x"};
let e = [%css "&.$(r.cls) { color: red; }"];
