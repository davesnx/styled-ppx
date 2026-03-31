open Types
open Support

module Property_r =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.LengthPercentage)]

let property_r : property_r Rule.rule = Property_r.rule

let entries : (kind * packed_rule) list =
  [
    Property "r", pack_module (module Property_r);
  ]
