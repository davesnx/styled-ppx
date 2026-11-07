open Types
open Support

module Property_forced_color_adjust =
  [%spec_module
  "'auto' | 'none' | 'preserve-parent-color'",
  (module Css_types.ForcedColorAdjust)]

let property_forced_color_adjust : property_forced_color_adjust Rule.rule =
  Property_forced_color_adjust.rule

module Property__ms_high_contrast_adjust =
  [%spec_module
  "'auto' | 'none'", (module Css_types.ForcedColorAdjust)]

let property__ms_high_contrast_adjust = Property__ms_high_contrast_adjust.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "-ms-high-contrast-adjust",
      pack_module (module Property__ms_high_contrast_adjust) );
    ( Property "forced-color-adjust",
      pack_module (module Property_forced_color_adjust) );
  ]
