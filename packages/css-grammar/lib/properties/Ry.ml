open Types
open Support

module Property_ry =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.LengthPercentage)]

let property_ry : property_ry Rule.rule = Property_ry.rule

let entries : (kind * packed_rule) list =
  [ Property "ry", pack_module (module Property_ry) ]
