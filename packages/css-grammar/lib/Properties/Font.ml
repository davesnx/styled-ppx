open Types
open Support

module Property_font =
  [%spec_module
  "[ <'font-style'> || <font-variant-css21> || <'font-weight'> || \
   <'font-stretch'> ]? <'font-size'> [ '/' <'line-height'> ]? <'font-family'> \
   | 'caption' | 'icon' | 'menu' | 'message-box' | 'small-caption' | \
   'status-bar'",
  (module Css_types.Font)]

let property_font : property_font Rule.rule = Property_font.rule

module Property_font_family =
  [%spec_module
  "<font_families> | <interpolation>", (module Css_types.FontFamily)]

let property_font_family : property_font_family Rule.rule =
  Property_font_family.rule

module Property_font_feature_settings =
  [%spec_module
  "'normal' | [ <feature-tag-value> ]#", (module Css_types.FontFeatureSettings)]

let property_font_feature_settings : property_font_feature_settings Rule.rule =
  Property_font_feature_settings.rule

module Property_font_display =
  [%spec_module
  "'auto' | 'block' | 'swap' | 'fallback' | 'optional'",
  (module Css_types.FontDisplay)]

let property_font_display : property_font_display Rule.rule =
  Property_font_display.rule

module Property_font_kerning =
  [%spec_module
  "'auto' | 'normal' | 'none'", (module Css_types.FontKerning)]

let property_font_kerning : property_font_kerning Rule.rule =
  Property_font_kerning.rule

module Property_font_language_override =
  [%spec_module
  "'normal' | <string>", (module Css_types.FontLanguageOverride)]

let property_font_language_override : property_font_language_override Rule.rule
    =
  Property_font_language_override.rule

module Property_font_optical_sizing =
  [%spec_module
  "'auto' | 'none'", (module Css_types.FontOpticalSizing)]

let property_font_optical_sizing : property_font_optical_sizing Rule.rule =
  Property_font_optical_sizing.rule

module Property_font_palette =
  [%spec_module
  "'normal' | 'light' | 'dark'", (module Css_types.FontPalette)]

let property_font_palette : property_font_palette Rule.rule =
  Property_font_palette.rule

module Property_font_size =
  [%spec_module
  "<absolute-size> | <relative-size> | <extended-length> | \
   <extended-percentage>",
  (module Css_types.FontSize)]

let property_font_size : property_font_size Rule.rule = Property_font_size.rule

module Property_font_size_adjust =
  [%spec_module
  "'none' | <number>", (module Css_types.FontSizeAdjust)]

let property_font_size_adjust : property_font_size_adjust Rule.rule =
  Property_font_size_adjust.rule

module Property_font_smooth =
  [%spec_module
  "'auto' | 'never' | 'always' | <absolute-size> | <extended-length>",
  (module Css_types.FontSmooth)]

let property_font_smooth : property_font_smooth Rule.rule =
  Property_font_smooth.rule

module Property_font_stretch =
  [%spec_module
  "<font-stretch-absolute>", (module Css_types.FontStretch)]

let property_font_stretch : property_font_stretch Rule.rule =
  Property_font_stretch.rule

module Property_font_width =
  [%spec_module
  "<font-stretch-absolute> | <percentage>", (module Css_types.FontStretch)]

let property_font_width = Property_font_width.rule

module Property_font_style =
  [%spec_module
  "'normal' | 'italic' | 'oblique' | <interpolation> | [ 'oblique' \
   <extended-angle> ]?",
  (module Css_types.FontStyle)]

let property_font_style : property_font_style Rule.rule =
  Property_font_style.rule

module Property_font_synthesis =
  [%spec_module
  "'none' | [ 'weight' || 'style' || 'small-caps' || 'position' ]",
  (module Css_types.FontSynthesis)]

let property_font_synthesis : property_font_synthesis Rule.rule =
  Property_font_synthesis.rule

module Property_font_synthesis_weight =
  [%spec_module
  "'auto' | 'none'", (module Css_types.FontSynthesisWeight)]

let property_font_synthesis_weight : property_font_synthesis_weight Rule.rule =
  Property_font_synthesis_weight.rule

module Property_font_synthesis_style =
  [%spec_module
  "'auto' | 'none'", (module Css_types.FontSynthesisStyle)]

let property_font_synthesis_style : property_font_synthesis_style Rule.rule =
  Property_font_synthesis_style.rule

module Property_font_synthesis_small_caps =
  [%spec_module
  "'auto' | 'none'", (module Css_types.FontSynthesisSmallCaps)]

let property_font_synthesis_small_caps :
  property_font_synthesis_small_caps Rule.rule =
  Property_font_synthesis_small_caps.rule

module Property_font_synthesis_position =
  [%spec_module
  "'auto' | 'none'", (module Css_types.FontSynthesisPosition)]

let property_font_synthesis_position :
  property_font_synthesis_position Rule.rule =
  Property_font_synthesis_position.rule

module Property_font_variant =
  [%spec_module
  "'normal' | 'none' | 'small-caps' | <common-lig-values> || \
   <discretionary-lig-values> || <historical-lig-values> || \
   <contextual-alt-values> || stylistic( <feature-value-name> ) || \
   'historical-forms' || styleset( [ <feature-value-name> ]# ) || \
   character-variant( [ <feature-value-name> ]# ) || swash( \
   <feature-value-name> ) || ornaments( <feature-value-name> ) || annotation( \
   <feature-value-name> ) || [ 'small-caps' | 'all-small-caps' | 'petite-caps' \
   | 'all-petite-caps' | 'unicase' | 'titling-caps' ] || \
   <numeric-figure-values> || <numeric-spacing-values> || \
   <numeric-fraction-values> || 'ordinal' || 'slashed-zero' || \
   <east-asian-variant-values> || <east-asian-width-values> || 'ruby' || 'sub' \
   || 'super' || 'text' || 'emoji' || 'unicode'",
  (module Css_types.FontVariant)]

let property_font_variant : property_font_variant Rule.rule =
  Property_font_variant.rule

module Property_font_variant_alternates =
  [%spec_module
  "'normal' | stylistic( <feature-value-name> ) || 'historical-forms' || \
   styleset( [ <feature-value-name> ]# ) || character-variant( [ \
   <feature-value-name> ]# ) || swash( <feature-value-name> ) || ornaments( \
   <feature-value-name> ) || annotation( <feature-value-name> )",
  (module Css_types.FontVariantAlternates)]

let property_font_variant_alternates :
  property_font_variant_alternates Rule.rule =
  Property_font_variant_alternates.rule

module Property_font_variant_caps =
  [%spec_module
  "'normal' | 'small-caps' | 'all-small-caps' | 'petite-caps' | \
   'all-petite-caps' | 'unicase' | 'titling-caps'",
  (module Css_types.FontVariantCaps)]

let property_font_variant_caps : property_font_variant_caps Rule.rule =
  Property_font_variant_caps.rule

module Property_font_variant_east_asian =
  [%spec_module
  "'normal' | <east-asian-variant-values> || <east-asian-width-values> || \
   'ruby'",
  (module Css_types.FontVariantEastAsian)]

let property_font_variant_east_asian :
  property_font_variant_east_asian Rule.rule =
  Property_font_variant_east_asian.rule

module Property_font_variant_ligatures =
  [%spec_module
  "'normal' | 'none' | <common-lig-values> || <discretionary-lig-values> || \
   <historical-lig-values> || <contextual-alt-values>",
  (module Css_types.FontVariantLigatures)]

let property_font_variant_ligatures : property_font_variant_ligatures Rule.rule
    =
  Property_font_variant_ligatures.rule

module Property_font_variant_numeric =
  [%spec_module
  "'normal' | <numeric-figure-values> || <numeric-spacing-values> || \
   <numeric-fraction-values> || 'ordinal' || 'slashed-zero'",
  (module Css_types.FontVariantNumeric)]

let property_font_variant_numeric : property_font_variant_numeric Rule.rule =
  Property_font_variant_numeric.rule

module Property_font_variant_position =
  [%spec_module
  "'normal' | 'sub' | 'super'", (module Css_types.FontVariantPosition)]

let property_font_variant_position : property_font_variant_position Rule.rule =
  Property_font_variant_position.rule

module Property_font_variation_settings =
  [%spec_module
  "'normal' | [ <string> <number> ]#", (module Css_types.FontVariationSettings)]

let property_font_variation_settings :
  property_font_variation_settings Rule.rule =
  Property_font_variation_settings.rule

module Property_font_variant_emoji =
  [%spec_module
  "'normal' | 'text' | 'emoji' | 'unicode'", (module Css_types.FontVariantEmoji)]

let property_font_variant_emoji : property_font_variant_emoji Rule.rule =
  Property_font_variant_emoji.rule

module Property_font_weight =
  [%spec_module
  "<font-weight-absolute> | 'bolder' | 'lighter' | <interpolation>",
  (module Css_types.FontWeight)]

let property_font_weight : property_font_weight Rule.rule =
  Property_font_weight.rule

let entries : (kind * packed_rule) list =
  [
    Property "font-style", pack_module (module Property_font_style);
    ( Property "font-variant-caps",
      pack_module (module Property_font_variant_caps) );
    Property "font-stretch", pack_module (module Property_font_stretch);
    Property "font-width", pack_module (module Property_font_width);
    Property "font-kerning", pack_module (module Property_font_kerning);
    ( Property "font-variant-position",
      pack_module (module Property_font_variant_position) );
    ( Property "font-optical-sizing",
      pack_module (module Property_font_optical_sizing) );
    Property "font-palette", pack_module (module Property_font_palette);
    ( Property "font-synthesis-weight",
      pack_module (module Property_font_synthesis_weight) );
    ( Property "font-synthesis-style",
      pack_module (module Property_font_synthesis_style) );
    ( Property "font-synthesis-small-caps",
      pack_module (module Property_font_synthesis_small_caps) );
    ( Property "font-synthesis-position",
      pack_module (module Property_font_synthesis_position) );
    Property "font-display", pack_module (module Property_font_display);
    Property "font", pack_module (module Property_font);
    Property "font-family", pack_module (module Property_font_family);
    ( Property "font-feature-settings",
      pack_module (module Property_font_feature_settings) );
    ( Property "font-language-override",
      pack_module (module Property_font_language_override) );
    Property "font-size", pack_module (module Property_font_size);
    Property "font-size-adjust", pack_module (module Property_font_size_adjust);
    Property "font-smooth", pack_module (module Property_font_smooth);
    Property "font-synthesis", pack_module (module Property_font_synthesis);
    Property "font-variant", pack_module (module Property_font_variant);
    ( Property "font-variant-alternates",
      pack_module (module Property_font_variant_alternates) );
    ( Property "font-variant-east-asian",
      pack_module (module Property_font_variant_east_asian) );
    ( Property "font-variant-emoji",
      pack_module (module Property_font_variant_emoji) );
    ( Property "font-variant-ligatures",
      pack_module (module Property_font_variant_ligatures) );
    ( Property "font-variant-numeric",
      pack_module (module Property_font_variant_numeric) );
    ( Property "font-variation-settings",
      pack_module (module Property_font_variation_settings) );
    Property "font-weight", pack_module (module Property_font_weight);
  ]
