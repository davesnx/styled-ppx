let support_property: string => bool;
let parse_declarations:
  ((string, string)) =>
  result(
    list(Migrate_parsetree.Ast_410.Parsetree.expression),
    [ | `Invalid_value(string) | `Not_found],
  );
