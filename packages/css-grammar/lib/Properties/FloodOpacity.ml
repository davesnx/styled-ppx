open Types
open Support

module Property_flood_opacity =
  [%spec_module
  "<alpha-value>", (module Css_types.Opacity)]

let property_flood_opacity : property_flood_opacity Rule.rule =
  Property_flood_opacity.rule

let entries : (kind * packed_rule) list =
  [ Property "flood-opacity", pack_module (module Property_flood_opacity) ]
