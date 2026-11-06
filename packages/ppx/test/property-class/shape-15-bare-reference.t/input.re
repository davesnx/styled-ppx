let plain = [%css "color: green"];
let card = [%css "&:not($(plain)) { color: black }"];
