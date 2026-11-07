open Types
open Support

module Property_media_any_hover =
  [%spec_module
  "none | hover", (module Css_types.MediaAnyHover)]

let property_media_any_hover : property_media_any_hover Rule.rule =
  Property_media_any_hover.rule

module Property_media_any_pointer =
  [%spec_module
  "none | coarse | fine", (module Css_types.MediaAnyPointer)]

let property_media_any_pointer : property_media_any_pointer Rule.rule =
  Property_media_any_pointer.rule

module Property_media_pointer =
  [%spec_module
  "none | coarse | fine", (module Css_types.MediaPointer)]

let property_media_pointer : property_media_pointer Rule.rule =
  Property_media_pointer.rule

module Property_media_max_aspect_ratio =
  [%spec_module
  "<ratio>", (module Css_types.MediaMaxAspectRatio)]

let property_media_max_aspect_ratio : property_media_max_aspect_ratio Rule.rule
    =
  Property_media_max_aspect_ratio.rule

module Property_media_min_aspect_ratio =
  [%spec_module
  "<ratio>", (module Css_types.MediaMinAspectRatio)]

let property_media_min_aspect_ratio : property_media_min_aspect_ratio Rule.rule
    =
  Property_media_min_aspect_ratio.rule

module Property_media_min_color =
  [%spec_module
  "<integer>", (module Css_types.MediaMinColor)]

let property_media_min_color : property_media_min_color Rule.rule =
  Property_media_min_color.rule

module Property_media_color_gamut =
  [%spec_module
  "'srgb' | 'p3' | 'rec2020'", (module Css_types.MediaColorGamut)]

let property_media_color_gamut : property_media_color_gamut Rule.rule =
  Property_media_color_gamut.rule

module Property_media_color_index =
  [%spec_module
  "<integer>", (module Css_types.MediaColorIndex)]

let property_media_color_index : property_media_color_index Rule.rule =
  Property_media_color_index.rule

module Property_media_min_color_index =
  [%spec_module
  "<integer>", (module Css_types.MediaMinColorIndex)]

let property_media_min_color_index : property_media_min_color_index Rule.rule =
  Property_media_min_color_index.rule

module Property_media_display_mode =
  [%spec_module
  "'fullscreen' | 'standalone' | 'minimal-ui' | 'browser'",
  (module Css_types.MediaDisplayMode)]

let property_media_display_mode : property_media_display_mode Rule.rule =
  Property_media_display_mode.rule

module Property_media_forced_colors =
  [%spec_module
  "'none' | 'active'", (module Css_types.MediaForcedColors)]

let property_media_forced_colors : property_media_forced_colors Rule.rule =
  Property_media_forced_colors.rule

module Property_media_grid =
  [%spec_module
  "<integer>", (module Css_types.MediaGrid)]

let property_media_grid : property_media_grid Rule.rule =
  Property_media_grid.rule

module Property_media_hover =
  [%spec_module
  "'hover' | 'none'", (module Css_types.MediaHover)]

let property_media_hover : property_media_hover Rule.rule =
  Property_media_hover.rule

module Property_media_inverted_colors =
  [%spec_module
  "'inverted' | 'none'", (module Css_types.MediaInvertedColors)]

let property_media_inverted_colors : property_media_inverted_colors Rule.rule =
  Property_media_inverted_colors.rule

module Property_media_monochrome =
  [%spec_module
  "<integer>", (module Css_types.MediaMonochrome)]

let property_media_monochrome : property_media_monochrome Rule.rule =
  Property_media_monochrome.rule

module Property_media_prefers_color_scheme =
  [%spec_module
  "'dark' | 'light'", (module Css_types.MediaPrefersColorScheme)]

let property_media_prefers_color_scheme :
  property_media_prefers_color_scheme Rule.rule =
  Property_media_prefers_color_scheme.rule

module Property_media_prefers_contrast =
  [%spec_module
  "'no-preference' | 'more' | 'less'", (module Css_types.MediaPrefersContrast)]

let property_media_prefers_contrast : property_media_prefers_contrast Rule.rule
    =
  Property_media_prefers_contrast.rule

module Property_media_prefers_reduced_motion =
  [%spec_module
  "'no-preference' | 'reduce'", (module Css_types.MediaPrefersReducedMotion)]

let property_media_prefers_reduced_motion :
  property_media_prefers_reduced_motion Rule.rule =
  Property_media_prefers_reduced_motion.rule

module Property_media_resolution =
  [%spec_module
  "<resolution>", (module Css_types.MediaResolution)]

let property_media_resolution : property_media_resolution Rule.rule =
  Property_media_resolution.rule

module Property_media_min_resolution =
  [%spec_module
  "<resolution>", (module Css_types.MediaMinResolution)]

let property_media_min_resolution : property_media_min_resolution Rule.rule =
  Property_media_min_resolution.rule

module Property_media_max_resolution =
  [%spec_module
  "<resolution>", (module Css_types.MediaMaxResolution)]

let property_media_max_resolution : property_media_max_resolution Rule.rule =
  Property_media_max_resolution.rule

module Property_media_scripting =
  [%spec_module
  "'none' | 'initial-only' | 'enabled'", (module Css_types.MediaScripting)]

let property_media_scripting : property_media_scripting Rule.rule =
  Property_media_scripting.rule

module Property_media_update =
  [%spec_module
  "'none' | 'slow' | 'fast'", (module Css_types.MediaUpdate)]

let property_media_update : property_media_update Rule.rule =
  Property_media_update.rule

module Property_media_orientation =
  [%spec_module
  "'portrait' | 'landscape'", (module Css_types.MediaOrientation)]

let property_media_orientation : property_media_orientation Rule.rule =
  Property_media_orientation.rule

module Property_media_type =
  [%spec_module
  "<ident>", (module Css_types.MediaType)]

let property_media_type : property_media_type Rule.rule =
  Property_media_type.rule

let entries : (kind * packed_rule) list =
  [
    Property "media-type", pack_module (module Property_media_type);
    Property "media-any-hover", pack_module (module Property_media_any_hover);
    ( Property "media-any-pointer",
      pack_module (module Property_media_any_pointer) );
    ( Property "media-color-gamut",
      pack_module (module Property_media_color_gamut) );
    ( Property "media-color-index",
      pack_module (module Property_media_color_index) );
    ( Property "media-display-mode",
      pack_module (module Property_media_display_mode) );
    ( Property "media-forced-colors",
      pack_module (module Property_media_forced_colors) );
    Property "media-grid", pack_module (module Property_media_grid);
    Property "media-hover", pack_module (module Property_media_hover);
    ( Property "media-inverted-colors",
      pack_module (module Property_media_inverted_colors) );
    ( Property "media-max-aspect-ratio",
      pack_module (module Property_media_max_aspect_ratio) );
    ( Property "media-max-resolution",
      pack_module (module Property_media_max_resolution) );
    ( Property "media-min-aspect-ratio",
      pack_module (module Property_media_min_aspect_ratio) );
    ( Property "media-min-color-index",
      pack_module (module Property_media_min_color_index) );
    ( Property "media-min-resolution",
      pack_module (module Property_media_min_resolution) );
    Property "media-monochrome", pack_module (module Property_media_monochrome);
    ( Property "media-orientation",
      pack_module (module Property_media_orientation) );
    Property "media-pointer", pack_module (module Property_media_pointer);
    ( Property "media-prefers-color-scheme",
      pack_module (module Property_media_prefers_color_scheme) );
    ( Property "media-prefers-contrast",
      pack_module (module Property_media_prefers_contrast) );
    ( Property "media-prefers-reduced-motion",
      pack_module (module Property_media_prefers_reduced_motion) );
    Property "media-resolution", pack_module (module Property_media_resolution);
    Property "media-scripting", pack_module (module Property_media_scripting);
    Property "media-update", pack_module (module Property_media_update);
    Property "media-min-color", pack_module (module Property_media_min_color);
  ]
