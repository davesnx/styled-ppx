let support_property: string => bool;
let parse_declarations:
  ((string, list((Css_types.Component_value.t, Warnings.loc)))) =>
  result(
    list(Migrate_parsetree.Ast_410.Parsetree.expression),
    [ | `Invalid_value(string) | `Not_found],
  );
