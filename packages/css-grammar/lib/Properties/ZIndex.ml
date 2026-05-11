open Types
open Support

module Property_z_index =
  [%spec_module
  "'auto' | <integer> | <interpolation>", (module Css_types.ZIndex)]

let property_z_index : property_z_index Rule.rule = Property_z_index.rule

let entries : (kind * packed_rule) list =
  [ Property "z-index", pack_module (module Property_z_index) ]
