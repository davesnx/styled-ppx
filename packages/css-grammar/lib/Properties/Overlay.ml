open Types
open Support

module Property_overlay =
  [%spec_module
  "'none' | 'auto'", (module Css_types.Overlay)]

let property_overlay : property_overlay Rule.rule = Property_overlay.rule

let entries : (kind * packed_rule) list =
  [ Property "overlay", pack_module (module Property_overlay) ]
