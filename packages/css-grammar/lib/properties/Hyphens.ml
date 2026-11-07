open Types
open Support

module Property_hyphens =
  [%spec_module
  "'none' | 'manual' | 'auto'", (module Css_types.Hyphens)]

let property_hyphens : property_hyphens Rule.rule = Property_hyphens.rule

let entries : (kind * packed_rule) list =
  [ Property "hyphens", pack_module (module Property_hyphens) ]
