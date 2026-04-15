open Types
open Support

module Property_glyph_orientation_horizontal =
  [%spec_module
  "<extended-angle>", (module Css_types.Angle)]

let property_glyph_orientation_horizontal :
  property_glyph_orientation_horizontal Rule.rule =
  Property_glyph_orientation_horizontal.rule

module Property_glyph_orientation_vertical =
  [%spec_module
  "<extended-angle>", (module Css_types.Angle)]

let property_glyph_orientation_vertical :
  property_glyph_orientation_vertical Rule.rule =
  Property_glyph_orientation_vertical.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "glyph-orientation-horizontal",
      pack_module (module Property_glyph_orientation_horizontal) );
    ( Property "glyph-orientation-vertical",
      pack_module (module Property_glyph_orientation_vertical) );
  ]
