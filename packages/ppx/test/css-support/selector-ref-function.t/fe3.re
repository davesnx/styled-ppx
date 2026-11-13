module M = {
  let v = 1;
};
let e = [%css "&.$(M.v) { color: red; }"];
