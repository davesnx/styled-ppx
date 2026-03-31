open Types
open Support

module Property_cx =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.LengthPercentage)]

let property_cx : property_cx Rule.rule = Property_cx.rule

let entries : (kind * packed_rule) list =
  [
    Property "cx", pack_module (module Property_cx);
  ]
