open Types
open Support

module Property_gap =
  [%spec_module
  "<'row-gap'> [ <'column-gap'> ]?", (module Css_types.Gap)]

let property_gap : property_gap Rule.rule = Property_gap.rule

let entries : (kind * packed_rule) list =
  [ Property "gap", pack_module (module Property_gap) ]
