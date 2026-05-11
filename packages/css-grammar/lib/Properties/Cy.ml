open Types
open Support

module Property_cy =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.LengthPercentage)]

let property_cy : property_cy Rule.rule = Property_cy.rule

let entries : (kind * packed_rule) list =
  [ Property "cy", pack_module (module Property_cy) ]
