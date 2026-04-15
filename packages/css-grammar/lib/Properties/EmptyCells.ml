open Types
open Support

module Property_empty_cells =
  [%spec_module
  "'show' | 'hide'", (module Css_types.EmptyCells)]

let property_empty_cells : property_empty_cells Rule.rule =
  Property_empty_cells.rule

let entries : (kind * packed_rule) list =
  [ Property "empty-cells", pack_module (module Property_empty_cells) ]
