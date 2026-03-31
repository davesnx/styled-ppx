open Ppxlib;

let render:
  (
    ~loc: Location.t,
    ~raw_value_source: string,
    string,
    Styled_ppx_css_parser.Ast.component_value_list,
    bool,
  ) =>
  result(
    list(Parsetree.expression),
    [
      | `Invalid_value(string)
      | `Property_not_found
      | `Impossible_state
    ],
  );
