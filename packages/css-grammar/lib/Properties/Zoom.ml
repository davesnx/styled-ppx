open Types
open Support

module Property_zoom =
  [%spec_module
  "'normal' | 'reset' | <number> | <extended-percentage>",
  (module Css_types.Zoom)]

let property_zoom : property_zoom Rule.rule = Property_zoom.rule

let entries : (kind * packed_rule) list =
  [ Property "zoom", pack_module (module Property_zoom) ]
