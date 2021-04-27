open Ppxlib;
let support_property: string => bool;
let parse_declarations:
  ((string, string)) =>
  result(
    list(Parsetree.expression),
    [ | `Invalid_value(string) | `Not_found],
  );
let render_when_unsupported_features: (string, string) => Parsetree.expression
