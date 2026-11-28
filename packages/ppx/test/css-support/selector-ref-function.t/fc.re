let cond = true;
let pick = cond ? [%css "width: 1px"] : [%css "width: 2px"];
let c = [%css "& .$(pick) { color: red; }"];
