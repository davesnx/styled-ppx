open Types
open Support

module Property_backface_visibility =
  [%spec_module
  "'visible' | 'hidden'", (module Css_types.BackfaceVisibility)]

let property_backface_visibility : property_backface_visibility Rule.rule =
  Property_backface_visibility.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "backface-visibility",
      pack_module (module Property_backface_visibility) );
  ]
