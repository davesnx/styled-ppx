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

/* Get the CSS runtime function for a property with a dynamic variable value */
let get_css_function_for_property:
  (~loc: Location.t, string, Parsetree.expression) => Parsetree.expression;
