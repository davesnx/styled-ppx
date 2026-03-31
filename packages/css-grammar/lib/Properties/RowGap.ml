open Types
open Support

module Property_row_gap =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage>", (module Css_types.Gap)]

let property_row_gap : property_row_gap Rule.rule = Property_row_gap.rule

let entries : (kind * packed_rule) list =
  [
    Property "row-gap", pack_module (module Property_row_gap);
  ]
