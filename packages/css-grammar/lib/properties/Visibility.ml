open Types
open Support

module Property_visibility =
  [%spec_module
  "'visible' | 'hidden' | 'collapse' | <interpolation>",
  (module Css_types.Visibility)]

let property_visibility : property_visibility Rule.rule =
  Property_visibility.rule

let entries : (kind * packed_rule) list =
  [ Property "visibility", pack_module (module Property_visibility) ]
