open Types
open Support

module Property_color = [%spec_module "<color>", (module Css_types.Color)]

let property_color : property_color Rule.rule = Property_color.rule

module Property_color_interpolation_filters =
  [%spec_module
  "'auto' | 'sRGB' | 'linearRGB'", (module Css_types.ColorInterpolationFilters)]

let property_color_interpolation_filters :
  property_color_interpolation_filters Rule.rule =
  Property_color_interpolation_filters.rule

module Property_color_interpolation =
  [%spec_module
  "'auto' | 'sRGB' | 'linearRGB'", (module Css_types.ColorInterpolation)]

let property_color_interpolation : property_color_interpolation Rule.rule =
  Property_color_interpolation.rule

module Property_color_adjust =
  [%spec_module
  "'economy' | 'exact'", (module Css_types.ColorAdjust)]

let property_color_adjust : property_color_adjust Rule.rule =
  Property_color_adjust.rule

module Property_color_scheme =
  [%spec_module
  "'normal' | [ 'dark' | 'light' | <custom-ident> ]+ && 'only'?",
  (module Css_types.ColorScheme)]

let property_color_scheme : property_color_scheme Rule.rule =
  Property_color_scheme.rule

module Property_color_rendering =
  [%spec_module
  "'auto' | 'optimizeSpeed' | 'optimizeQuality'",
  (module Css_types.ColorRendering)]

let property_color_rendering : property_color_rendering Rule.rule =
  Property_color_rendering.rule

let entries : (kind * packed_rule) list =
  [
    Property "color-scheme", pack_module (module Property_color_scheme);
    Property "color-adjust", pack_module (module Property_color_adjust);
    Property "color", pack_module (module Property_color);
    Property "color-interpolation", pack_module (module Property_color_interpolation);
    ( Property "color-interpolation-filters",
      pack_module (module Property_color_interpolation_filters) );
    Property "color-rendering", pack_module (module Property_color_rendering);
  ]
