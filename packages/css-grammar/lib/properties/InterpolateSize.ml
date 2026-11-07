open Types
open Support

module Property_interpolate_size =
  [%spec_module
  "'numeric-only' | 'allow-keywords'", (module Css_types.InterpolateSize)]

let property_interpolate_size : property_interpolate_size Rule.rule =
  Property_interpolate_size.rule

let entries : (kind * packed_rule) list =
  [
    Property "interpolate-size", pack_module (module Property_interpolate_size);
  ]
