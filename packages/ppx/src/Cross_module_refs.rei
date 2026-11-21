type entry = {
  longident: string,
  loc: Ppxlib.Location.t,
};

let sentinel: string => string;

let record:
  (~file: string, ~longident: string, ~loc: Ppxlib.Location.t) => unit;

let drain: unit => (list(entry), list((string, Ppxlib.Location.t)));
