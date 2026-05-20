open Types
open Support

module Property_perspective_origin =
  [%spec_module
  "<position>", (module Css_types.PerspectiveOrigin)]

let property_perspective_origin : property_perspective_origin Rule.rule =
  Property_perspective_origin.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "perspective-origin",
      pack_module (module Property_perspective_origin) );
  ]
