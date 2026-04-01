open Types
open Support

module Property_resize =
  [%spec_module
  "'none' | 'both' | 'horizontal' | 'vertical' | 'block' | 'inline'",
  (module Css_types.Resize)]

let property_resize : property_resize Rule.rule = Property_resize.rule

let entries : (kind * packed_rule) list =
  [ Property "resize", pack_module (module Property_resize) ]
