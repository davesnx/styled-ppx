open Types
open Support

module Property_opacity =
  [%spec_module
  "<alpha-value>", (module Css_types.Opacity)]

let property_opacity : property_opacity Rule.rule = Property_opacity.rule

let entries : (kind * packed_rule) list =
  [
    Property "opacity", pack_module (module Property_opacity);
  ]
