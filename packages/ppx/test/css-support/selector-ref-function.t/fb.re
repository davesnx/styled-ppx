let pick = big => big ? [%css "width: 1px"] : [%css "width: 2px"];
let b = [%css "& .$(pick) { color: red; }"];
