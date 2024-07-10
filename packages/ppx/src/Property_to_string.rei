open Ppxlib;

let parse_declarations:
  (string, string) =>
  result(
    list(Parsetree.expression),
    [ | `Invalid_value(string) | `Property_not_found],
  );
