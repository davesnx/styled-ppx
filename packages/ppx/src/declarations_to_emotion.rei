open Ppxlib;

let parse_declarations:
  (~loc: Location.t, string, string, bool) =>
  result(
    list(Parsetree.expression),
    [ | `Invalid_value(string) | `Not_found],
  );
