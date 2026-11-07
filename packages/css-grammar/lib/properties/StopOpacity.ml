open Types
open Support

module Property_stop_opacity =
  [%spec_module
  "<alpha-value>", (module Css_types.Opacity)]

let property_stop_opacity : property_stop_opacity Rule.rule =
  Property_stop_opacity.rule

let entries : (kind * packed_rule) list =
  [ Property "stop-opacity", pack_module (module Property_stop_opacity) ]
