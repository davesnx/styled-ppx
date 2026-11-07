let before = [%css ".x + & { margin-top: 3px }"];
let after = [%css "& + .x { margin-top: 3px }"];
let both = [%css "& + & { margin-top: 3px }"];
let chain = [%css "& + .a + & { margin-top: 3px }"];
