open Types
open Support

module Property_columns =
  [%spec_module
  "<'column-width'> || <'column-count'>", (module Css_types.Columns)]

let property_columns : property_columns Rule.rule = Property_columns.rule

let entries : (kind * packed_rule) list =
  (* Multi-column Layout L2: https://www.w3.org/TR/css-multicol-2/#columns, #column-rule-style *)
  [
    ( Shorthand ("columns", [ "column-width"; "column-count"; "column-height" ]),
      pack_module (module Property_columns) );
  ]
