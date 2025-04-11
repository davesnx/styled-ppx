open Ppxlib;

let render:
  (~loc: Location.t, string, string, bool) =>
  result(
    list(Parsetree.expression),
    [
      | `Invalid_value(string)
      | `Property_not_found
      | `Impossible_state
    ],
  );
