open Types
open Support

module Property_accent_color =
  [%spec_module
  "'auto' | <color>", (module Css_types.AccentColor)]

let property_accent_color : property_accent_color Rule.rule =
  Property_accent_color.rule

let entries : (kind * packed_rule) list =
  [ Property "accent-color", pack_module (module Property_accent_color) ]
