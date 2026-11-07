open Types
open Support

module Property_appearance =
  [%spec_module
  "'none' | 'auto' | 'button' | 'textfield' | 'menulist-button' | <compat-auto>",
  (module Css_types.Appearance)]

let property_appearance : property_appearance Rule.rule =
  Property_appearance.rule

let entries : (kind * packed_rule) list =
  [ Property "appearance", pack_module (module Property_appearance) ]
