open Types
open Support

module Property_marker =
  [%spec_module
  "'none' | <url>", (module Css_types.Marker)]

let property_marker : property_marker Rule.rule = Property_marker.rule

let entries : (kind * packed_rule) list =
  [ Property "marker", pack_module (module Property_marker) ]
