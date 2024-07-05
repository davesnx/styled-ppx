open Ppxlib;

let render:
  (~loc: Location.t, string, string, bool) =>
  result(
    list(Parsetree.expression),
    [ | `Invalid_value(string) | `Not_found],
  );
