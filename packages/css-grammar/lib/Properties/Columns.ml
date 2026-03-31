open Types
open Support

module Property_columns =
  [%spec_module
  "<'column-width'> || <'column-count'>", (module Css_types.Columns)]

let property_columns : property_columns Rule.rule = Property_columns.rule

let entries : (kind * packed_rule) list =
  [
    Property "columns", pack_module (module Property_columns);
  ]
