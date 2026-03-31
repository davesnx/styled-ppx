open Types
open Support

module Property_perspective =
  [%spec_module
  "'none' | <extended-length>", (module Css_types.Perspective)]

let property_perspective : property_perspective Rule.rule =
  Property_perspective.rule

let entries : (kind * packed_rule) list =
  [
    Property "perspective", pack_module (module Property_perspective);
  ]
