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
  (* MQ4 adds 'infinite' for media without resolution limits. *)
  "<resolution> | 'infinite'", (module Css_types.MediaResolution)]

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

(* The grammars below exist only so At_rule_prelude can validate @media /
   @container feature values; the values never reach runtime emission, so
   the modules carry no runtime type. One module covers each value class
   and is registered under every feature name sharing it. *)

module Property_media_length_feature = [%spec_module "<extended-length>"]

let property_media_length_feature : property_media_length_feature Rule.rule =
  Property_media_length_feature.rule

module Property_media_ratio_feature = [%spec_module "<ratio>"]

let property_media_ratio_feature : property_media_ratio_feature Rule.rule =
  Property_media_ratio_feature.rule

module Property_media_integer_feature = [%spec_module "<integer>"]

let property_media_integer_feature : property_media_integer_feature Rule.rule =
  Property_media_integer_feature.rule

(* Compat device-pixel-ratio spellings take a bare <number> (e.g. 1.5). *)
module Property_media_number_feature = [%spec_module "<number>"]

let property_media_number_feature : property_media_number_feature Rule.rule =
  Property_media_number_feature.rule

module Property_media_scan = [%spec_module "'interlace' | 'progressive'"]

let property_media_scan : property_media_scan Rule.rule =
  Property_media_scan.rule

module Property_media_overflow_block =
  [%spec_module
  "'none' | 'scroll' | 'paged'"]

let property_media_overflow_block : property_media_overflow_block Rule.rule =
  Property_media_overflow_block.rule

module Property_media_overflow_inline = [%spec_module "'none' | 'scroll'"]

let property_media_overflow_inline : property_media_overflow_inline Rule.rule =
  Property_media_overflow_inline.rule

(* Shared by dynamic-range and video-dynamic-range. *)
module Property_media_dynamic_range = [%spec_module "'standard' | 'high'"]

let property_media_dynamic_range : property_media_dynamic_range Rule.rule =
  Property_media_dynamic_range.rule

(* Shared by prefers-reduced-transparency and prefers-reduced-data. *)
module Property_media_prefers_reduced =
  [%spec_module
  "'no-preference' | 'reduce'"]

let property_media_prefers_reduced : property_media_prefers_reduced Rule.rule =
  Property_media_prefers_reduced.rule

module Property_media_nav_controls = [%spec_module "'none' | 'back'"]

let property_media_nav_controls : property_media_nav_controls Rule.rule =
  Property_media_nav_controls.rule

module Property_media_environment_blending =
  [%spec_module
  "'opaque' | 'additive' | 'subtractive'"]

let property_media_environment_blending :
  property_media_environment_blending Rule.rule =
  Property_media_environment_blending.rule

module Property_media_device_posture = [%spec_module "'continuous' | 'folded'"]

let property_media_device_posture : property_media_device_posture Rule.rule =
  Property_media_device_posture.rule

module Property_media_video_color_gamut =
  [%spec_module
  "'srgb' | 'p3' | 'rec2020'"]

let property_media_video_color_gamut :
  property_media_video_color_gamut Rule.rule =
  Property_media_video_color_gamut.rule

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
    (* Length features: <extended-length>. media-inline-size and
       media-block-size are @container-only size features; the media- key
       prefix is just the registry namespace At_rule_prelude looks up. *)
    Property "media-width", pack_module (module Property_media_length_feature);
    ( Property "media-min-width",
      pack_module (module Property_media_length_feature) );
    ( Property "media-max-width",
      pack_module (module Property_media_length_feature) );
    Property "media-height", pack_module (module Property_media_length_feature);
    ( Property "media-min-height",
      pack_module (module Property_media_length_feature) );
    ( Property "media-max-height",
      pack_module (module Property_media_length_feature) );
    ( Property "media-device-width",
      pack_module (module Property_media_length_feature) );
    ( Property "media-min-device-width",
      pack_module (module Property_media_length_feature) );
    ( Property "media-max-device-width",
      pack_module (module Property_media_length_feature) );
    ( Property "media-device-height",
      pack_module (module Property_media_length_feature) );
    ( Property "media-min-device-height",
      pack_module (module Property_media_length_feature) );
    ( Property "media-max-device-height",
      pack_module (module Property_media_length_feature) );
    ( Property "media-inline-size",
      pack_module (module Property_media_length_feature) );
    ( Property "media-min-inline-size",
      pack_module (module Property_media_length_feature) );
    ( Property "media-max-inline-size",
      pack_module (module Property_media_length_feature) );
    ( Property "media-block-size",
      pack_module (module Property_media_length_feature) );
    ( Property "media-min-block-size",
      pack_module (module Property_media_length_feature) );
    ( Property "media-max-block-size",
      pack_module (module Property_media_length_feature) );
    (* Ratio features: <ratio> (min/max-aspect-ratio predate these and keep
       their own modules above). *)
    ( Property "media-aspect-ratio",
      pack_module (module Property_media_ratio_feature) );
    ( Property "media-device-aspect-ratio",
      pack_module (module Property_media_ratio_feature) );
    ( Property "media-min-device-aspect-ratio",
      pack_module (module Property_media_ratio_feature) );
    ( Property "media-max-device-aspect-ratio",
      pack_module (module Property_media_ratio_feature) );
    (* Integer features: <integer>. *)
    Property "media-color", pack_module (module Property_media_integer_feature);
    ( Property "media-max-color",
      pack_module (module Property_media_integer_feature) );
    ( Property "media-max-color-index",
      pack_module (module Property_media_integer_feature) );
    ( Property "media-min-monochrome",
      pack_module (module Property_media_integer_feature) );
    ( Property "media-max-monochrome",
      pack_module (module Property_media_integer_feature) );
    ( Property "media-horizontal-viewport-segments",
      pack_module (module Property_media_integer_feature) );
    ( Property "media-min-horizontal-viewport-segments",
      pack_module (module Property_media_integer_feature) );
    ( Property "media-max-horizontal-viewport-segments",
      pack_module (module Property_media_integer_feature) );
    ( Property "media-vertical-viewport-segments",
      pack_module (module Property_media_integer_feature) );
    ( Property "media-min-vertical-viewport-segments",
      pack_module (module Property_media_integer_feature) );
    ( Property "media-max-vertical-viewport-segments",
      pack_module (module Property_media_integer_feature) );
    (* -webkit-transform-3d probes with 0/1 per the compat spec. *)
    ( Property "media--webkit-transform-3d",
      pack_module (module Property_media_integer_feature) );
    (* Compat device-pixel-ratio features: <number>. *)
    ( Property "media--moz-device-pixel-ratio",
      pack_module (module Property_media_number_feature) );
    ( Property "media-min--moz-device-pixel-ratio",
      pack_module (module Property_media_number_feature) );
    ( Property "media-max--moz-device-pixel-ratio",
      pack_module (module Property_media_number_feature) );
    ( Property "media--webkit-device-pixel-ratio",
      pack_module (module Property_media_number_feature) );
    ( Property "media--webkit-min-device-pixel-ratio",
      pack_module (module Property_media_number_feature) );
    ( Property "media--webkit-max-device-pixel-ratio",
      pack_module (module Property_media_number_feature) );
    (* Discrete keyword features (MQ5, Device Posture API). *)
    Property "media-scan", pack_module (module Property_media_scan);
    ( Property "media-overflow-block",
      pack_module (module Property_media_overflow_block) );
    ( Property "media-overflow-inline",
      pack_module (module Property_media_overflow_inline) );
    ( Property "media-dynamic-range",
      pack_module (module Property_media_dynamic_range) );
    ( Property "media-video-dynamic-range",
      pack_module (module Property_media_dynamic_range) );
    ( Property "media-prefers-reduced-transparency",
      pack_module (module Property_media_prefers_reduced) );
    ( Property "media-prefers-reduced-data",
      pack_module (module Property_media_prefers_reduced) );
    ( Property "media-nav-controls",
      pack_module (module Property_media_nav_controls) );
    ( Property "media-environment-blending",
      pack_module (module Property_media_environment_blending) );
    ( Property "media-device-posture",
      pack_module (module Property_media_device_posture) );
    ( Property "media-video-color-gamut",
      pack_module (module Property_media_video_color_gamut) );
  ]
