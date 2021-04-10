let support_property: string => bool;
let parse_declarations:
  ((string, string)) =>
  result(
    list(Ppxlib.Parsetree.expression),
    [ | `Invalid_value(string) | `Not_found],
  );
