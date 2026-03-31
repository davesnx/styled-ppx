open Types
open Support

module Legacy_linear_gradient_arguments =
  [%spec_module
  "[ <extended-angle> | <side-or-corner> ]? ',' <color-stop-list>"]

let legacy_linear_gradient_arguments :
  legacy_linear_gradient_arguments Rule.rule =
  Legacy_linear_gradient_arguments.rule

module Legacy_radial_gradient_shape =
  [%spec_module
  "'circle' | 'ellipse'", (module Css_types.LegacyRadialGradientShape)]

let legacy_radial_gradient_shape : legacy_radial_gradient_shape Rule.rule =
  Legacy_radial_gradient_shape.rule

module Legacy_radial_gradient_size =
  [%spec_module
  "'closest-side' | 'closest-corner' | 'farthest-side' | 'farthest-corner' | \
   'contain' | 'cover'",
  (module Css_types.LegacyRadialGradientSize)]

let legacy_radial_gradient_size : legacy_radial_gradient_size Rule.rule =
  Legacy_radial_gradient_size.rule

module Legacy_radial_gradient_arguments =
  [%spec_module
  "[ <position> ',' ]? [ [ <legacy-radial-gradient-shape> || \
   <legacy-radial-gradient-size> | [ <extended-length> | <extended-percentage> \
   ]{2} ] ',' ]? <color-stop-list>"]

let legacy_radial_gradient_arguments :
  legacy_radial_gradient_arguments Rule.rule =
  Legacy_radial_gradient_arguments.rule

module Legacy_linear_gradient =
  [%spec_module
  "-moz-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -webkit-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -o-linear-gradient( <legacy-linear-gradient-arguments> )",
  (module Css_types.LegacyLinearGradient)]

let legacy_linear_gradient : legacy_linear_gradient Rule.rule =
  Legacy_linear_gradient.rule

module Legacy_radial_gradient =
  [%spec_module
  "-moz-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -webkit-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -o-radial-gradient( <legacy-radial-gradient-arguments> )",
  (module Css_types.LegacyRadialGradient)]

let legacy_radial_gradient : legacy_radial_gradient Rule.rule =
  Legacy_radial_gradient.rule

module Legacy_repeating_linear_gradient =
  [%spec_module
  "-moz-repeating-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -webkit-repeating-linear-gradient( <legacy-linear-gradient-arguments> ) | \
   -o-repeating-linear-gradient( <legacy-linear-gradient-arguments> )"]

let legacy_repeating_linear_gradient :
  legacy_repeating_linear_gradient Rule.rule =
  Legacy_repeating_linear_gradient.rule

module Legacy_repeating_radial_gradient =
  [%spec_module
  "-moz-repeating-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -webkit-repeating-radial-gradient( <legacy-radial-gradient-arguments> ) | \
   -o-repeating-radial-gradient( <legacy-radial-gradient-arguments> )"]

let legacy_repeating_radial_gradient :
  legacy_repeating_radial_gradient Rule.rule =
  Legacy_repeating_radial_gradient.rule

(* Legacy_gradient depends on all the above, so it must come last *)
module Legacy_gradient =
  [%spec_module
  "<-webkit-gradient()> | <legacy-linear-gradient> | \
   <legacy-repeating-linear-gradient> | <legacy-radial-gradient> | \
   <legacy-repeating-radial-gradient>",
  (module Css_types.LegacyGradient)]

let legacy_gradient : legacy_gradient Rule.rule = Legacy_gradient.rule

module Non_standard_color =
  [%spec_module
  "'-moz-ButtonDefault' | '-moz-ButtonHoverFace' | '-moz-ButtonHoverText' | \
   '-moz-CellHighlight' | '-moz-CellHighlightText' | '-moz-Combobox' | \
   '-moz-ComboboxText' | '-moz-Dialog' | '-moz-DialogText' | \
   '-moz-dragtargetzone' | '-moz-EvenTreeRow' | '-moz-Field' | \
   '-moz-FieldText' | '-moz-html-CellHighlight' | \
   '-moz-html-CellHighlightText' | '-moz-mac-accentdarkestshadow' | \
   '-moz-mac-accentdarkshadow' | '-moz-mac-accentface' | \
   '-moz-mac-accentlightesthighlight' | '-moz-mac-accentlightshadow' | \
   '-moz-mac-accentregularhighlight' | '-moz-mac-accentregularshadow' | \
   '-moz-mac-chrome-active' | '-moz-mac-chrome-inactive' | \
   '-moz-mac-focusring' | '-moz-mac-menuselect' | '-moz-mac-menushadow' | \
   '-moz-mac-menutextselect' | '-moz-MenuHover' | '-moz-MenuHoverText' | \
   '-moz-MenuBarText' | '-moz-MenuBarHoverText' | '-moz-nativehyperlinktext' | \
   '-moz-OddTreeRow' | '-moz-win-communicationstext' | '-moz-win-mediatext' | \
   '-moz-activehyperlinktext' | '-moz-default-background-color' | \
   '-moz-default-color' | '-moz-hyperlinktext' | '-moz-visitedhyperlinktext' | \
   '-webkit-activelink' | '-webkit-focus-ring-color' | '-webkit-link' | \
   '-webkit-text'",
  (module Css_types.NonStandardColor)]

let non_standard_color : non_standard_color Rule.rule = Non_standard_color.rule

module Non_standard_font =
  [%spec_module
  "'-apple-system-body' | '-apple-system-headline' | \
   '-apple-system-subheadline' | '-apple-system-caption1' | \
   '-apple-system-caption2' | '-apple-system-footnote' | \
   '-apple-system-short-body' | '-apple-system-short-headline' | \
   '-apple-system-short-subheadline' | '-apple-system-short-caption1' | \
   '-apple-system-short-footnote' | '-apple-system-tall-body'",
  (module Css_types.NonStandardFont)]

let non_standard_font : non_standard_font Rule.rule = Non_standard_font.rule

module Non_standard_image_rendering =
  [%spec_module
  "'optimize-contrast' | '-moz-crisp-edges' | '-o-crisp-edges' | \
   '-webkit-optimize-contrast'",
  (module Css_types.NonStandardImageRendering)]

let non_standard_image_rendering : non_standard_image_rendering Rule.rule =
  Non_standard_image_rendering.rule

module Non_standard_overflow =
  [%spec_module
  "'-moz-scrollbars-none' | '-moz-scrollbars-horizontal' | \
   '-moz-scrollbars-vertical' | '-moz-hidden-unscrollable'",
  (module Css_types.NonStandardOverflow)]

let non_standard_overflow : non_standard_overflow Rule.rule =
  Non_standard_overflow.rule

module Non_standard_width =
  [%spec_module
  "'min-intrinsic' | 'intrinsic' | '-moz-min-content' | '-moz-max-content' | \
   '-webkit-min-content' | '-webkit-max-content'",
  (module Css_types.NonStandardWidth)]

let non_standard_width : non_standard_width Rule.rule = Non_standard_width.rule

module Webkit_gradient_color_stop =
  [%spec_module
  "from( <color> ) | color-stop( [ <alpha-value> | <extended-percentage> ] ',' \
   <color> ) | to( <color> )",
  (module Css_types.WebkitGradientColorStop)]

let webkit_gradient_color_stop : webkit_gradient_color_stop Rule.rule =
  Webkit_gradient_color_stop.rule

module Webkit_gradient_point =
  [%spec_module
  "[ 'left' | 'center' | 'right' | <extended-length> | <extended-percentage> ] \
   [ 'top' | 'center' | 'bottom' | <extended-length> | <extended-percentage> ]",
  (module Css_types.WebkitGradientPoint)]

let webkit_gradient_point : webkit_gradient_point Rule.rule =
  Webkit_gradient_point.rule

module Webkit_gradient_radius =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.WebkitGradientRadius)]

let webkit_gradient_radius : webkit_gradient_radius Rule.rule =
  Webkit_gradient_radius.rule

module Webkit_gradient_type =
  [%spec_module
  "'linear' | 'radial'", (module Css_types.WebkitGradientType)]

let webkit_gradient_type : webkit_gradient_type Rule.rule =
  Webkit_gradient_type.rule

module Webkit_mask_box_repeat =
  [%spec_module
  "'repeat' | 'stretch' | 'round'", (module Css_types.WebkitMaskBoxRepeat)]

let webkit_mask_box_repeat : webkit_mask_box_repeat Rule.rule =
  Webkit_mask_box_repeat.rule

module Webkit_mask_clip_style =
  [%spec_module
  "'border' | 'border-box' | 'padding' | 'padding-box' | 'content' | \
   'content-box' | 'text'",
  (module Css_types.WebkitMaskClipStyle)]

let webkit_mask_clip_style : webkit_mask_clip_style Rule.rule =
  Webkit_mask_clip_style.rule

module Absolute_size =
  [%spec_module
  "'xx-small' | 'x-small' | 'small' | 'medium' | 'large' | 'x-large' | \
   'xx-large' | 'xxx-large'",
  (module Css_types.AbsoluteSize)]

let absolute_size : absolute_size Rule.rule = Absolute_size.rule

module Age = [%spec_module "'child' | 'young' | 'old'", (module Css_types.Age)]

let age : age Rule.rule = Age.rule

module Alpha_value =
  [%spec_module
  "<number> | <extended-percentage>", (module Css_types.AlphaValue)]

let alpha_value : alpha_value Rule.rule = Alpha_value.rule

module Angular_color_hint =
  [%spec_module
  "<extended-angle> | <extended-percentage>",
  (module Css_types.AngularColorHint)]

let angular_color_hint : angular_color_hint Rule.rule = Angular_color_hint.rule

module Angular_color_stop =
  [%spec_module
  "<color> && [ <color-stop-angle> ]?", (module Css_types.AngularColorStop)]

let angular_color_stop : angular_color_stop Rule.rule = Angular_color_stop.rule

module Angular_color_stop_list =
  [%spec_module
  "[ <angular-color-stop> [ ',' <angular-color-hint> ]? ]# ',' \
   <angular-color-stop>",
  (module Css_types.AngularColorStopList)]

let angular_color_stop_list : angular_color_stop_list Rule.rule =
  Angular_color_stop_list.rule

module Animateable_feature =
  [%spec_module
  "'scroll-position' | 'contents' | <custom-ident>",
  (module Css_types.AnimateableFeature)]

let animateable_feature : animateable_feature Rule.rule =
  Animateable_feature.rule

module Attachment =
  [%spec_module
  "'scroll' | 'fixed' | 'local'", (module Css_types.Attachment)]

let attachment : attachment Rule.rule = Attachment.rule

module Attr_fallback =
  [%spec_module
  "<any-value>", (module Css_types.AttrFallback)]

let attr_fallback : attr_fallback Rule.rule = Attr_fallback.rule

module Attr_matcher =
  [%spec_module
  "[ '~' | '|' | '^' | '$' | '*' ]? '='", (module Css_types.AttrMatcher)]

let attr_matcher : attr_matcher Rule.rule = Attr_matcher.rule

module Attr_modifier =
  [%spec_module
  "'i' | 's'", (module Css_types.AttrModifier)]

let attr_modifier : attr_modifier Rule.rule = Attr_modifier.rule

module Attribute_selector =
  [%spec_module
  "'[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [ <string-token> | \
   <ident-token> ] [ <attr-modifier> ]? ']'",
  (module Css_types.AttributeSelector)]

let attribute_selector : attribute_selector Rule.rule = Attribute_selector.rule

module Auto_repeat =
  [%spec_module
  "repeat( [ 'auto-fill' | 'auto-fit' ] ',' [ [ <line-names> ]? <fixed-size> \
   ]+ [ <line-names> ]? )",
  (module Css_types.AutoRepeat)]

let auto_repeat : auto_repeat Rule.rule = Auto_repeat.rule

module Auto_track_list =
  [%spec_module
  "[ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ <line-names> ]? \
   <auto-repeat> [ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ \
   <line-names> ]?",
  (module Css_types.AutoTrackList)]

let auto_track_list : auto_track_list Rule.rule = Auto_track_list.rule

module Baseline_position =
  [%spec_module
  "[ 'first' | 'last' ]? 'baseline'", (module Css_types.BaselinePosition)]

let baseline_position : baseline_position Rule.rule = Baseline_position.rule

module Basic_shape =
  [%spec_module
  "<inset()> | <circle()> | <ellipse()> | <polygon()> | <path()>",
  (module Css_types.BasicShape)]

let basic_shape : basic_shape Rule.rule = Basic_shape.rule

module Bg_image = [%spec_module "'none' | <image>", (module Css_types.BgImage)]

let bg_image : bg_image Rule.rule = Bg_image.rule

module Bg_layer =
  [%spec_module
  "<bg-image> || <bg-position> [ '/' <bg-size> ]? || <repeat-style> || \
   <attachment> || <box> || <box>",
  (module Css_types.BgLayer)]

let bg_layer : bg_layer Rule.rule = Bg_layer.rule

module Bg_position =
  [%spec_module
  "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ] | \
   [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | \
   'bottom' | <length-percentage> ] | [ 'center' | [ 'left' | 'right' ] \
   <length-percentage>? ] && [ 'center' | [ 'top' | 'bottom' ] \
   <length-percentage>? ]",
  (module Css_types.BgPosition)]

let bg_position : bg_position Rule.rule = Bg_position.rule

(* one_bg_size isn't part of the spec, helps us with Type generation *)
module One_bg_size =
  [%spec_module
  "[ <extended-length> | <extended-percentage> | 'auto' ] [ <extended-length> \
   | <extended-percentage> | 'auto' ]?",
  (module Css_types.OneBgSize)]

let one_bg_size : one_bg_size Rule.rule = One_bg_size.rule

module Bg_size =
  [%spec_module
  "<one-bg-size> | 'cover' | 'contain'", (module Css_types.BgSize)]

let bg_size : bg_size Rule.rule = Bg_size.rule

module Blend_mode =
  [%spec_module
  "'normal' | 'multiply' | 'screen' | 'overlay' | 'darken' | 'lighten' | \
   'color-dodge' | 'color-burn' | 'hard-light' | 'soft-light' | 'difference' | \
   'exclusion' | 'hue' | 'saturation' | 'color' | 'luminosity'",
  (module Css_types.BlendMode)]

let blend_mode : blend_mode Rule.rule = Blend_mode.rule

(* border_radius value supports 1-4 values with optional "/" for horizontal/vertical *)
module Box =
  [%spec_module
  "'border-box' | 'padding-box' | 'content-box'", (module Css_types.Box)]

let box : box Rule.rule = Box.rule

module Calc_product =
  [%spec_module
  "<calc-value> [ '*' <calc-value> | '/' <number> ]*",
  (module Css_types.CalcProduct)]

let calc_product : calc_product Rule.rule = Calc_product.rule

module Dimension =
  [%spec_module
  "<extended-length> | <extended-time> | <extended-frequency> | <resolution>",
  (module Css_types.Dimension)]

let dimension : dimension Rule.rule = Dimension.rule

module Calc_sum =
  [%spec_module
  "<calc-product> [ [ '+' | '-' ] <calc-product> ]*", (module Css_types.CalcSum)]

let calc_sum : calc_sum Rule.rule = Calc_sum.rule

module Calc_value =
  [%spec_module
  "<number> | <extended-length> | <extended-percentage> | <extended-angle> | \
   <extended-time> | '(' <calc-sum> ')'",
  (module Css_types.CalcValue)]

let calc_value : calc_value Rule.rule = Calc_value.rule

module Cf_final_image =
  [%spec_module
  "<image> | <color>", (module Css_types.CfFinalImage)]

let cf_final_image : cf_final_image Rule.rule = Cf_final_image.rule

module Cf_mixing_image =
  [%spec_module
  "[ <extended-percentage> ]? && <image>", (module Css_types.CfMixingImage)]

let cf_mixing_image : cf_mixing_image Rule.rule = Cf_mixing_image.rule

module Class_selector =
  [%spec_module
  "'.' <ident-token>", (module Css_types.ClassSelector)]

let class_selector : class_selector Rule.rule = Class_selector.rule

module Clip_source = [%spec_module "<url>", (module Css_types.ClipSource)]

let clip_source : clip_source Rule.rule = Clip_source.rule

module Color =
  [%spec_module
  "<rgb()> | <rgba()> | <hsl()> | <hsla()> | <hwb()> | <lab()> | <lch()> | \
   <oklab()> | <oklch()> | <color()> | <light-dark()> | <hex-color> | \
   <named-color> | 'currentColor' | <deprecated-system-color> | \
   <interpolation> | <var()> | <color-mix()>",
  (module Css_types.Color)]

let color : color Rule.rule = Color.rule

module Color_stop =
  [%spec_module
  "<color-stop-length> | <color-stop-angle>", (module Css_types.ColorStop)]

let color_stop : color_stop Rule.rule = Color_stop.rule

module Color_stop_angle =
  [%spec_module
  "[ <extended-angle> ]{1,2}", (module Css_types.ColorStopAngle)]

let color_stop_angle : color_stop_angle Rule.rule = Color_stop_angle.rule

module Color_stop_length =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.ColorStopLength)]

let color_stop_length : color_stop_length Rule.rule = Color_stop_length.rule

(* color_stop_list is modified from the original spec, here is a simplified version where it tries to be fully compatible but easier for code-gen:

   The current impl allows values that aren't really supported such as: `linear-gradient(0deg, 10%, blue)` which is invalid, but we allow it for now to make it easier to generate the types. The correct value would require always a color to be in the first position `linear-gradient(0deg, red, 10%, blue);`

   The original spec is `color_stop_list = [%spec_module "[ <linear-color-stop> [ ',' <linear-color-hint> ]? ]# ',' <linear-color-stop>"]`
   *)
module Color_stop_list =
  [%spec_module
  "[ [<color>? <length-percentage>] | [<color> <length-percentage>?] ]#",
  (module Css_types.ColorStopList)]

let color_stop_list : color_stop_list Rule.rule = Color_stop_list.rule

module Hue_interpolation_method =
  [%spec_module
  " [ 'shorter' | 'longer' | 'increasing' | 'decreasing' ] && 'hue' ",
  (module Css_types.HueInterpolationMethod)]

let hue_interpolation_method : hue_interpolation_method Rule.rule =
  Hue_interpolation_method.rule

module Polar_color_space =
  [%spec_module
  " 'hsl' | 'hwb' | 'lch' | 'oklch' ", (module Css_types.PolarColorSpace)]

let polar_color_space : polar_color_space Rule.rule = Polar_color_space.rule

module Rectangular_color_space =
  [%spec_module
  " 'srgb' | 'srgb-linear' | 'display-p3' | 'a98-rgb' | 'prophoto-rgb' | \
   'rec2020' | 'lab' | 'oklab' | 'xyz' | 'xyz-d50' | 'xyz-d65' ",
  (module Css_types.RectangularColorSpace)]

let rectangular_color_space : rectangular_color_space Rule.rule =
  Rectangular_color_space.rule

module Color_interpolation_method =
  [%spec_module
  " 'in' && [<rectangular-color-space> | <polar-color-space> \
   <hue-interpolation-method>?] ",
  (module Css_types.ColorInterpolationMethod)]

let color_interpolation_method : color_interpolation_method Rule.rule =
  Color_interpolation_method.rule

(* TODO: Use <extended-percentage> *)
module Combinator =
  [%spec_module
  "'>' | '+' | '~' | '||'", (module Css_types.Combinator)]

let combinator : combinator Rule.rule = Combinator.rule

module Common_lig_values =
  [%spec_module
  "'common-ligatures' | 'no-common-ligatures'",
  (module Css_types.CommonLigValues)]

let common_lig_values : common_lig_values Rule.rule = Common_lig_values.rule

module Compat_auto =
  [%spec_module
  "'searchfield' | 'textarea' | 'push-button' | 'slider-horizontal' | \
   'checkbox' | 'radio' | 'square-button' | 'menulist' | 'listbox' | 'meter' | \
   'progress-bar'",
  (module Css_types.CompatAuto)]

let compat_auto : compat_auto Rule.rule = Compat_auto.rule

module Complex_selector =
  [%spec_module
  "<compound-selector> [ [ <combinator> ]? <compound-selector> ]*",
  (module Css_types.ComplexSelector)]

let complex_selector : complex_selector Rule.rule = Complex_selector.rule

module Complex_selector_list =
  [%spec_module
  "[ <complex-selector> ]#", (module Css_types.ComplexSelectorList)]

let complex_selector_list : complex_selector_list Rule.rule =
  Complex_selector_list.rule

module Composite_style =
  [%spec_module
  "'clear' | 'copy' | 'source-over' | 'source-in' | 'source-out' | \
   'source-atop' | 'destination-over' | 'destination-in' | 'destination-out' | \
   'destination-atop' | 'xor'",
  (module Css_types.CompositeStyle)]

let composite_style : composite_style Rule.rule = Composite_style.rule

module Compositing_operator =
  [%spec_module
  "'add' | 'subtract' | 'intersect' | 'exclude'",
  (module Css_types.CompositingOperator)]

let compositing_operator : compositing_operator Rule.rule =
  Compositing_operator.rule

module Compound_selector =
  [%spec_module
  "[ <type-selector> ]? [ <subclass-selector> ]* [ <pseudo-element-selector> [ \
   <pseudo-class-selector> ]* ]*",
  (module Css_types.CompoundSelector)]

let compound_selector : compound_selector Rule.rule = Compound_selector.rule

module Compound_selector_list =
  [%spec_module
  "[ <compound-selector> ]#", (module Css_types.CompoundSelectorList)]

let compound_selector_list : compound_selector_list Rule.rule =
  Compound_selector_list.rule

module Content_distribution =
  [%spec_module
  "'space-between' | 'space-around' | 'space-evenly' | 'stretch'",
  (module Css_types.ContentDistribution)]

let content_distribution : content_distribution Rule.rule =
  Content_distribution.rule

module Content_list =
  [%spec_module
  "[ <string> | 'contents' | <url> | <quote> | <attr()> | counter( <ident> ',' \
   [ <'list-style-type'> ]? ) ]+",
  (module Css_types.ContentList)]

let content_list : content_list Rule.rule = Content_list.rule

module Content_position =
  [%spec_module
  "'center' | 'start' | 'end' | 'flex-start' | 'flex-end'",
  (module Css_types.ContentPosition)]

let content_position : content_position Rule.rule = Content_position.rule

module Content_replacement =
  [%spec_module
  "<image>", (module Css_types.ContentReplacement)]

let content_replacement : content_replacement Rule.rule =
  Content_replacement.rule

module Contextual_alt_values =
  [%spec_module
  "'contextual' | 'no-contextual'", (module Css_types.ContextualAltValues)]

let contextual_alt_values : contextual_alt_values Rule.rule =
  Contextual_alt_values.rule

module Counter_style =
  [%spec_module
  "<counter-style-name> | <symbols()>", (module Css_types.CounterStyle)]

let counter_style : counter_style Rule.rule = Counter_style.rule

module Counter_style_name =
  [%spec_module
  "<custom-ident>", (module Css_types.CounterStyleName)]

let counter_style_name : counter_style_name Rule.rule = Counter_style_name.rule

module Counter_name =
  [%spec_module
  "<custom-ident>", (module Css_types.CounterName)]

let counter_name : counter_name Rule.rule = Counter_name.rule

module Cubic_bezier_timing_function =
  [%spec_module
  "'ease' | 'ease-in' | 'ease-out' | 'ease-in-out' | cubic-bezier( <number> \
   ',' <number> ',' <number> ',' <number> )",
  (module Css_types.CubicBezierTimingFunction)]

let cubic_bezier_timing_function : cubic_bezier_timing_function Rule.rule =
  Cubic_bezier_timing_function.rule

module Declaration =
  [%spec_module
  "<ident-token> ':' [ <declaration-value> ]? [ '!' 'important' ]?",
  (module Css_types.Declaration)]

let declaration : declaration Rule.rule = Declaration.rule

module Declaration_list =
  [%spec_module
  "[ [ <declaration> ]? ';' ]* [ <declaration> ]?",
  (module Css_types.DeclarationList)]

let declaration_list : declaration_list Rule.rule = Declaration_list.rule

module Deprecated_system_color =
  [%spec_module
  "'ActiveBorder' | 'ActiveCaption' | 'AppWorkspace' | 'Background' | \
   'ButtonFace' | 'ButtonHighlight' | 'ButtonShadow' | 'ButtonText' | \
   'CaptionText' | 'GrayText' | 'Highlight' | 'HighlightText' | \
   'InactiveBorder' | 'InactiveCaption' | 'InactiveCaptionText' | \
   'InfoBackground' | 'InfoText' | 'Menu' | 'MenuText' | 'Scrollbar' | \
   'ThreeDDarkShadow' | 'ThreeDFace' | 'ThreeDHighlight' | 'ThreeDLightShadow' \
   | 'ThreeDShadow' | 'Window' | 'WindowFrame' | 'WindowText'",
  (module Css_types.DeprecatedSystemColor)]

let deprecated_system_color : deprecated_system_color Rule.rule =
  Deprecated_system_color.rule

module Discretionary_lig_values =
  [%spec_module
  "'discretionary-ligatures' | 'no-discretionary-ligatures'",
  (module Css_types.DiscretionaryLigValues)]

let discretionary_lig_values : discretionary_lig_values Rule.rule =
  Discretionary_lig_values.rule

module Display_box =
  [%spec_module
  "'contents' | 'none'", (module Css_types.DisplayBox)]

let display_box : display_box Rule.rule = Display_box.rule

module Display_inside =
  [%spec_module
  "'flow' | 'flow-root' | 'table' | 'flex' | 'grid' | 'ruby'",
  (module Css_types.DisplayInside)]

let display_inside : display_inside Rule.rule = Display_inside.rule

module Display_internal =
  [%spec_module
  "'table-row-group' | 'table-header-group' | 'table-footer-group' | \
   'table-row' | 'table-cell' | 'table-column-group' | 'table-column' | \
   'table-caption' | 'ruby-base' | 'ruby-text' | 'ruby-base-container' | \
   'ruby-text-container'",
  (module Css_types.DisplayInternal)]

let display_internal : display_internal Rule.rule = Display_internal.rule

module Display_legacy =
  [%spec_module
  "'inline-block' | 'inline-list-item' | 'inline-table' | 'inline-flex' | \
   'inline-grid'",
  (module Css_types.DisplayLegacy)]

let display_legacy : display_legacy Rule.rule = Display_legacy.rule

module Display_listitem =
  [%spec_module
  "[ <display-outside> ]? && [ 'flow' | 'flow-root' ]? && 'list-item'",
  (module Css_types.DisplayListitem)]

let display_listitem : display_listitem Rule.rule = Display_listitem.rule

module Display_outside =
  [%spec_module
  "'block' | 'inline' | 'run-in'", (module Css_types.DisplayOutside)]

let display_outside : display_outside Rule.rule = Display_outside.rule

module East_asian_variant_values =
  [%spec_module
  "'jis78' | 'jis83' | 'jis90' | 'jis04' | 'simplified' | 'traditional'",
  (module Css_types.EastAsianVariantValues)]

let east_asian_variant_values : east_asian_variant_values Rule.rule =
  East_asian_variant_values.rule

module East_asian_width_values =
  [%spec_module
  "'full-width' | 'proportional-width'", (module Css_types.EastAsianWidthValues)]

let east_asian_width_values : east_asian_width_values Rule.rule =
  East_asian_width_values.rule

module Ending_shape =
  [%spec_module
  "'circle' | 'ellipse'", (module Css_types.EndingShape)]

let ending_shape : ending_shape Rule.rule = Ending_shape.rule

module Explicit_track_list =
  [%spec_module
  "[ [ <line-names> ]? <track-size> ]+ [ <line-names> ]?",
  (module Css_types.ExplicitTrackList)]

let explicit_track_list : explicit_track_list Rule.rule =
  Explicit_track_list.rule

module Family_name =
  [%spec_module
  "<string> | <custom-ident>", (module Css_types.FamilyName)]

let family_name : family_name Rule.rule = Family_name.rule

module Feature_tag_value =
  [%spec_module
  "<string> [ <integer> | 'on' | 'off' ]?", (module Css_types.FeatureTagValue)]

let feature_tag_value : feature_tag_value Rule.rule = Feature_tag_value.rule

module Feature_type =
  [%spec_module
  "'@stylistic' | '@historical-forms' | '@styleset' | '@character-variant' | \
   '@swash' | '@ornaments' | '@annotation'",
  (module Css_types.FeatureType)]

let feature_type : feature_type Rule.rule = Feature_type.rule

module Feature_value_block =
  [%spec_module
  "<feature-type> '{' <feature-value-declaration-list> '}'",
  (module Css_types.FeatureValueBlock)]

let feature_value_block : feature_value_block Rule.rule =
  Feature_value_block.rule

module Feature_value_block_list =
  [%spec_module
  "[ <feature-value-block> ]+", (module Css_types.FeatureValueBlockList)]

let feature_value_block_list : feature_value_block_list Rule.rule =
  Feature_value_block_list.rule

module Feature_value_declaration =
  [%spec_module
  "<custom-ident> ':' [ <integer> ]+ ';'",
  (module Css_types.FeatureValueDeclaration)]

let feature_value_declaration : feature_value_declaration Rule.rule =
  Feature_value_declaration.rule

module Feature_value_declaration_list =
  [%spec_module
  "<feature-value-declaration>"]

let feature_value_declaration_list : feature_value_declaration_list Rule.rule =
  Feature_value_declaration_list.rule

module Feature_value_name =
  [%spec_module
  "<custom-ident>", (module Css_types.FeatureValueName)]

let feature_value_name : feature_value_name Rule.rule = Feature_value_name.rule

(* <zero> represents the literal value 0, used in contexts like rotate(0) *)
module Zero = [%spec_module "'0'"]

let zero : zero Rule.rule = Zero.rule

module Filter_function =
  [%spec_module
  "<blur()> | <brightness()> | <contrast()> | <drop-shadow()> | <grayscale()> \
   | <hue-rotate()> | <invert()> | <opacity()> | <saturate()> | <sepia()>",
  (module Css_types.FilterFunction)]

let filter_function : filter_function Rule.rule = Filter_function.rule

module Filter_function_list =
  [%spec_module
  "[ <filter-function> | <url> ]+", (module Css_types.FilterFunctionList)]

let filter_function_list : filter_function_list Rule.rule =
  Filter_function_list.rule

module Final_bg_layer =
  [%spec_module
  "<'background-color'> || <bg-image> || <bg-position> [ '/' <bg-size> ]? || \
   <repeat-style> || <attachment> || <box> || <box>",
  (module Css_types.FinalBgLayer)]

let final_bg_layer : final_bg_layer Rule.rule = Final_bg_layer.rule

module Line_names =
  [%spec_module
  "'[' <custom-ident>* ']'", (module Css_types.LineNames)]

let line_names : line_names Rule.rule = Line_names.rule

module Fixed_breadth =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.FixedBreadth)]

let fixed_breadth : fixed_breadth Rule.rule = Fixed_breadth.rule

module Fixed_repeat =
  [%spec_module
  "repeat( <positive-integer> ',' [ [ <line-names> ]? <fixed-size> ]+ [ \
   <line-names> ]? )",
  (module Css_types.FixedRepeat)]

let fixed_repeat : fixed_repeat Rule.rule = Fixed_repeat.rule

module Fixed_size =
  [%spec_module
  "<fixed-breadth> | minmax( <fixed-breadth> ',' <track-breadth> ) | minmax( \
   <inflexible-breadth> ',' <fixed-breadth> )",
  (module Css_types.FixedSize)]

let fixed_size : fixed_size Rule.rule = Fixed_size.rule

module Font_stretch_absolute =
  [%spec_module
  "'normal' | 'ultra-condensed' | 'extra-condensed' | 'condensed' | \
   'semi-condensed' | 'semi-expanded' | 'expanded' | 'extra-expanded' | \
   'ultra-expanded' | <extended-percentage>",
  (module Css_types.FontStretchAbsolute)]

let font_stretch_absolute : font_stretch_absolute Rule.rule =
  Font_stretch_absolute.rule

module Font_variant_css21 =
  [%spec_module
  "'normal' | 'small-caps'", (module Css_types.FontVariantCss21)]

let font_variant_css21 : font_variant_css21 Rule.rule = Font_variant_css21.rule

module Font_weight_absolute =
  [%spec_module
  "'normal' | 'bold' | <integer>", (module Css_types.FontWeightAbsolute)]

let font_weight_absolute : font_weight_absolute Rule.rule =
  Font_weight_absolute.rule

(* We don't support attr() with fallback value (since it's a declaration value) yet, original spec is: "attr(<attr-name> <attr-type>? , <declaration-value>?)" *)
(* drop-shadow can have 2 length module order doesn't matter, we changed to be more restrict module always expect 3 *)
module Predefined_color_space =
  [%spec_module
  " 'srgb' | 'srgb-linear' | 'display-p3' | 'a98-rgb' | 'prophoto-rgb' | \
   'rec2020' | 'xyz' | 'xyz-d50' | 'xyz-d65' "]

let predefined_color_space : predefined_color_space Rule.rule =
  Predefined_color_space.rule

module Gender =
  [%spec_module
  "'male' | 'female' | 'neutral'", (module Css_types.Gender)]

let gender : gender Rule.rule = Gender.rule

module General_enclosed =
  [%spec_module
  "<function-token> <any-value> ')' | '(' <ident> <any-value> ')'",
  (module Css_types.GeneralEnclosed)]

let general_enclosed : general_enclosed Rule.rule = General_enclosed.rule

module Generic_family =
  [%spec_module
  "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace' | \
   '-apple-system'",
  (module Css_types.GenericFamily)]

let generic_family : generic_family Rule.rule = Generic_family.rule

module Generic_name =
  [%spec_module
  "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace'",
  (module Css_types.GenericName)]

let generic_name : generic_name Rule.rule = Generic_name.rule

module Generic_voice =
  [%spec_module
  "[ <age> ]? <gender> [ <integer> ]?", (module Css_types.GenericVoice)]

let generic_voice : generic_voice Rule.rule = Generic_voice.rule

module Geometry_box =
  [%spec_module
  "<shape-box> | 'fill-box' | 'stroke-box' | 'view-box'",
  (module Css_types.GeometryBox)]

let geometry_box : geometry_box Rule.rule = Geometry_box.rule

module Gradient =
  [%spec_module
  "<linear-gradient()> | <repeating-linear-gradient()> | <radial-gradient()> | \
   <repeating-radial-gradient()> | <conic-gradient()> | <legacy-gradient>",
  (module Css_types.Gradient)]

let gradient : gradient Rule.rule = Gradient.rule

module Grid_line =
  [%spec_module
  "<custom-ident-without-span-or-auto> | <integer> && [ \
   <custom-ident-without-span-or-auto> ]? | 'span' && [ <integer> || \
   <custom-ident-without-span-or-auto> ] | 'auto' | <interpolation>",
  (module Css_types.GridLine)]

let grid_line : grid_line Rule.rule = Grid_line.rule

module Historical_lig_values =
  [%spec_module
  "'historical-ligatures' | 'no-historical-ligatures'",
  (module Css_types.HistoricalLigValues)]

let historical_lig_values : historical_lig_values Rule.rule =
  Historical_lig_values.rule

module Hue =
  [%spec_module
  "<number> | <extended-angle>", (module Css_types.Hue)]

let hue : hue Rule.rule = Hue.rule

module Id_selector =
  [%spec_module
  "<hash-token>", (module Css_types.IdSelector)]

let id_selector : id_selector Rule.rule = Id_selector.rule

module Image =
  [%spec_module
  "<url> | <image()> | <image-set()> | <element()> | <paint()> | \
   <cross-fade()> | <gradient> | <interpolation>",
  (module Css_types.Image)]

let image : image Rule.rule = Image.rule

module Image_set_option =
  [%spec_module
  "[ <image> | <string> ] <resolution>", (module Css_types.ImageSetOption)]

let image_set_option : image_set_option Rule.rule = Image_set_option.rule

module Image_src =
  [%spec_module
  "<url> | <string>", (module Css_types.ImageSrc)]

let image_src : image_src Rule.rule = Image_src.rule

module Image_tags = [%spec_module "'ltr' | 'rtl'", (module Css_types.ImageTags)]

let image_tags : image_tags Rule.rule = Image_tags.rule

module Inflexible_breadth =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'min-content' | 'max-content' | \
   'auto'",
  (module Css_types.InflexibleBreadth)]

let inflexible_breadth : inflexible_breadth Rule.rule = Inflexible_breadth.rule

module Keyframe_block =
  [%spec_module
  "[ <keyframe-selector> ]# '{' <declaration-list> '}'",
  (module Css_types.KeyframeBlock)]

let keyframe_block : keyframe_block Rule.rule = Keyframe_block.rule

module Keyframe_block_list =
  [%spec_module
  "[ <keyframe-block> ]+", (module Css_types.KeyframeBlockList)]

let keyframe_block_list : keyframe_block_list Rule.rule =
  Keyframe_block_list.rule

module Keyframe_selector =
  [%spec_module
  "'from' | 'to' | <extended-percentage>", (module Css_types.KeyframeSelector)]

let keyframe_selector : keyframe_selector Rule.rule = Keyframe_selector.rule

module Keyframes_name =
  [%spec_module
  "<custom-ident> | <string>", (module Css_types.KeyframesName)]

let keyframes_name : keyframes_name Rule.rule = Keyframes_name.rule

module Leader_type =
  [%spec_module
  "'dotted' | 'solid' | 'space' | <string>", (module Css_types.LeaderType)]

let leader_type : leader_type Rule.rule = Leader_type.rule

module Line_name_list =
  [%spec_module
  "[ <line-names> | <name-repeat> ]+", (module Css_types.LineNameList)]

let line_name_list : line_name_list Rule.rule = Line_name_list.rule

module Line_style =
  [%spec_module
  "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | \
   'ridge' | 'inset' | 'outset'",
  (module Css_types.LineStyle)]

let line_style : line_style Rule.rule = Line_style.rule

module Line_width =
  [%spec_module
  "<extended-length> | 'thin' | 'medium' | 'thick'",
  (module Css_types.LineWidth)]

let line_width : line_width Rule.rule = Line_width.rule

module Linear_color_hint =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.LinearColorHint)]

let linear_color_hint : linear_color_hint Rule.rule = Linear_color_hint.rule

module Linear_color_stop =
  [%spec_module
  "<color> <length-percentage>?", (module Css_types.LinearColorStop)]

let linear_color_stop : linear_color_stop Rule.rule = Linear_color_stop.rule

module Mask_layer =
  [%spec_module
  "<mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || \
   <geometry-box> || [ <geometry-box> | 'no-clip' ] || <compositing-operator> \
   || <masking-mode>",
  (module Css_types.MaskLayer)]

let mask_layer : mask_layer Rule.rule = Mask_layer.rule

module Mask_reference =
  [%spec_module
  "'none' | <image> | <mask-source>", (module Css_types.MaskReference)]

let mask_reference : mask_reference Rule.rule = Mask_reference.rule

module Mask_source = [%spec_module "<url>", (module Css_types.MaskSource)]

let mask_source : mask_source Rule.rule = Mask_source.rule

module Masking_mode =
  [%spec_module
  "'alpha' | 'luminance' | 'match-source'", (module Css_types.MaskingMode)]

let masking_mode : masking_mode Rule.rule = Masking_mode.rule

module Mf_comparison =
  [%spec_module
  "<mf-lt> | <mf-gt> | <mf-eq>", (module Css_types.MfComparison)]

let mf_comparison : mf_comparison Rule.rule = Mf_comparison.rule

module Mf_eq = [%spec_module "'='", (module Css_types.MfEq)]

let mf_eq : mf_eq Rule.rule = Mf_eq.rule

module Mf_gt = [%spec_module "'>=' | '>'", (module Css_types.MfGt)]

let mf_gt : mf_gt Rule.rule = Mf_gt.rule

module Mf_lt = [%spec_module "'<=' | '<'", (module Css_types.MfLt)]

let mf_lt : mf_lt Rule.rule = Mf_lt.rule

module Mf_value =
  [%spec_module
  "<number> | <dimension> | <ident> | <ratio> | <interpolation> | <calc()>",
  (module Css_types.MfValue)]

let mf_value : mf_value Rule.rule = Mf_value.rule

module Mf_name = [%spec_module "<ident>", (module Css_types.MfName)]

let mf_name : mf_name Rule.rule = Mf_name.rule

module Mf_range =
  [%spec_module
  "<mf-name> <mf-comparison> <mf-value> | <mf-value> <mf-comparison> <mf-name> \
   | <mf-value> <mf-lt> <mf-name> <mf-lt> <mf-value> | <mf-value> <mf-gt> \
   <mf-name> <mf-gt> <mf-value>",
  (module Css_types.MfRange)]

let mf_range : mf_range Rule.rule = Mf_range.rule

module Mf_boolean = [%spec_module "<mf-name>", (module Css_types.MfBoolean)]

let mf_boolean : mf_boolean Rule.rule = Mf_boolean.rule

module Mf_plain =
  [%spec_module
  "<mf-name> ':' <mf-value>", (module Css_types.MfPlain)]

let mf_plain : mf_plain Rule.rule = Mf_plain.rule

module Media_feature =
  [%spec_module
  "'(' [ <mf-plain> | <mf-boolean> | <mf-range> ] ')'",
  (module Css_types.MediaFeature)]

let media_feature : media_feature Rule.rule = Media_feature.rule

module Media_in_parens =
  [%spec_module
  "<media-feature> | '(' <media-condition> ')' | <interpolation>",
  (module Css_types.MediaInParens)]

let media_in_parens : media_in_parens Rule.rule = Media_in_parens.rule

module Media_and =
  [%spec_module
  "'and' <media-in-parens>", (module Css_types.MediaAnd)]

let media_and : media_and Rule.rule = Media_and.rule

module Media_or =
  [%spec_module
  "'or' <media-in-parens>", (module Css_types.MediaOr)]

let media_or : media_or Rule.rule = Media_or.rule

module Media_not =
  [%spec_module
  "'not' <media-in-parens>", (module Css_types.MediaNot)]

let media_not : media_not Rule.rule = Media_not.rule

module Media_condition_without_or =
  [%spec_module
  "<media-not> | <media-in-parens> <media-and>*",
  (module Css_types.MediaConditionWithoutOr)]

let media_condition_without_or : media_condition_without_or Rule.rule =
  Media_condition_without_or.rule

module Media_condition =
  [%spec_module
  "<media-not> | <media-in-parens> [ <media-and>* | <media-or>* ]",
  (module Css_types.MediaCondition)]

let media_condition : media_condition Rule.rule = Media_condition.rule

module Media_query =
  [%spec_module
  "<media-condition> | [ 'not' | 'only' ]? <media-type> [ 'and' \
   <media-condition-without-or> ]?",
  (module Css_types.MediaQuery)]

let media_query : media_query Rule.rule = Media_query.rule

module Media_query_list =
  [%spec_module
  "[ <media-query> ]# | <interpolation>", (module Css_types.MediaQueryList)]

let media_query_list : media_query_list Rule.rule = Media_query_list.rule

module Container_condition_list =
  [%spec_module
  "<container-condition>#", (module Css_types.ContainerConditionList)]

let container_condition_list : container_condition_list Rule.rule =
  Container_condition_list.rule

module Container_condition =
  [%spec_module
  "[ <container-name> ]? <container-query>",
  (module Css_types.ContainerCondition)]

let container_condition : container_condition Rule.rule =
  Container_condition.rule

module Container_query =
  [%spec_module
  "'not' <query-in-parens> | <query-in-parens> [ [ 'and' <query-in-parens> ]* \
   | [ 'or' <query-in-parens> ]* ]",
  (module Css_types.ContainerQuery)]

let container_query : container_query Rule.rule = Container_query.rule

module Query_in_parens =
  [%spec_module
  "'(' <container-query> ')' | '(' <size-feature> ')' | style( <style-query> )",
  (module Css_types.QueryInParens)]

let query_in_parens : query_in_parens Rule.rule = Query_in_parens.rule

module Size_feature =
  [%spec_module
  "<mf-plain> | <mf-boolean> | <mf-range>", (module Css_types.SizeFeature)]

let size_feature : size_feature Rule.rule = Size_feature.rule

module Style_query =
  [%spec_module
  "'not' <style-in-parens> | <style-in-parens> [ [ module <style-in-parens> ]* \
   | [ or <style-in-parens> ]* ] | <style-feature>",
  (module Css_types.StyleQuery)]

let style_query : style_query Rule.rule = Style_query.rule

module Style_feature =
  [%spec_module
  "<dashed_ident> ':' <mf-value>", (module Css_types.StyleFeature)]

let style_feature : style_feature Rule.rule = Style_feature.rule

module Style_in_parens =
  [%spec_module
  "'(' <style-query> ')' | '(' <style-feature> ')'",
  (module Css_types.StyleInParens)]

let style_in_parens : style_in_parens Rule.rule = Style_in_parens.rule

module Name_repeat =
  [%spec_module
  "repeat( [ <positive-integer> | 'auto-fill' ] ',' [ <line-names> ]+ )",
  (module Css_types.NameRepeat)]

let name_repeat : name_repeat Rule.rule = Name_repeat.rule

module Named_color =
  [%spec_module
  "'transparent' | 'aliceblue' | 'antiquewhite' | 'aqua' | 'aquamarine' | \
   'azure' | 'beige' | 'bisque' | 'black' | 'blanchedalmond' | 'blue' | \
   'blueviolet' | 'brown' | 'burlywood' | 'cadetblue' | 'chartreuse' | \
   'chocolate' | 'coral' | 'cornflowerblue' | 'cornsilk' | 'crimson' | 'cyan' \
   | 'darkblue' | 'darkcyan' | 'darkgoldenrod' | 'darkgray' | 'darkgreen' | \
   'darkgrey' | 'darkkhaki' | 'darkmagenta' | 'darkolivegreen' | 'darkorange' \
   | 'darkorchid' | 'darkred' | 'darksalmon' | 'darkseagreen' | \
   'darkslateblue' | 'darkslategray' | 'darkslategrey' | 'darkturquoise' | \
   'darkviolet' | 'deeppink' | 'deepskyblue' | 'dimgray' | 'dimgrey' | \
   'dodgerblue' | 'firebrick' | 'floralwhite' | 'forestgreen' | 'fuchsia' | \
   'gainsboro' | 'ghostwhite' | 'gold' | 'goldenrod' | 'gray' | 'green' | \
   'greenyellow' | 'grey' | 'honeydew' | 'hotpink' | 'indianred' | 'indigo' | \
   'ivory' | 'khaki' | 'lavender' | 'lavenderblush' | 'lawngreen' | \
   'lemonchiffon' | 'lightblue' | 'lightcoral' | 'lightcyan' | \
   'lightgoldenrodyellow' | 'lightgray' | 'lightgreen' | 'lightgrey' | \
   'lightpink' | 'lightsalmon' | 'lightseagreen' | 'lightskyblue' | \
   'lightslategray' | 'lightslategrey' | 'lightsteelblue' | 'lightyellow' | \
   'lime' | 'limegreen' | 'linen' | 'magenta' | 'maroon' | 'mediumaquamarine' \
   | 'mediumblue' | 'mediumorchid' | 'mediumpurple' | 'mediumseagreen' | \
   'mediumslateblue' | 'mediumspringgreen' | 'mediumturquoise' | \
   'mediumvioletred' | 'midnightblue' | 'mintcream' | 'mistyrose' | 'moccasin' \
   | 'navajowhite' | 'navy' | 'oldlace' | 'olive' | 'olivedrab' | 'orange' | \
   'orangered' | 'orchid' | 'palegoldenrod' | 'palegreen' | 'paleturquoise' | \
   'palevioletred' | 'papayawhip' | 'peachpuff' | 'peru' | 'pink' | 'plum' | \
   'powderblue' | 'purple' | 'rebeccapurple' | 'red' | 'rosybrown' | \
   'royalblue' | 'saddlebrown' | 'salmon' | 'sandybrown' | 'seagreen' | \
   'seashell' | 'sienna' | 'silver' | 'skyblue' | 'slateblue' | 'slategray' | \
   'slategrey' | 'snow' | 'springgreen' | 'steelblue' | 'tan' | 'teal' | \
   'thistle' | 'tomato' | 'turquoise' | 'violet' | 'wheat' | 'white' | \
   'whitesmoke' | 'yellow' | 'yellowgreen' | <-non-standard-color>",
  (module Css_types.NamedColor)]

let named_color : named_color Rule.rule = Named_color.rule

module Namespace_prefix =
  [%spec_module
  "<ident>", (module Css_types.NamespacePrefix)]

let namespace_prefix : namespace_prefix Rule.rule = Namespace_prefix.rule

module Ns_prefix =
  [%spec_module
  "[ <ident-token> | '*' ]? '|'", (module Css_types.NsPrefix)]

let ns_prefix : ns_prefix Rule.rule = Ns_prefix.rule

module Nth =
  [%spec_module
  "<an-plus-b> | 'even' | 'odd'", (module Css_types.Nth)]

let nth : nth Rule.rule = Nth.rule

module Number_one_or_greater =
  [%spec_module
  "<number>", (module Css_types.NumberOneOrGreater)]

let number_one_or_greater : number_one_or_greater Rule.rule =
  Number_one_or_greater.rule

module Number_percentage =
  [%spec_module
  "<number> | <extended-percentage>", (module Css_types.NumberPercentage)]

let number_percentage : number_percentage Rule.rule = Number_percentage.rule

module Number_zero_one =
  [%spec_module
  "<number>", (module Css_types.NumberZeroOne)]

let number_zero_one : number_zero_one Rule.rule = Number_zero_one.rule

module Numeric_figure_values =
  [%spec_module
  "'lining-nums' | 'oldstyle-nums'", (module Css_types.NumericFigureValues)]

let numeric_figure_values : numeric_figure_values Rule.rule =
  Numeric_figure_values.rule

module Numeric_fraction_values =
  [%spec_module
  "'diagonal-fractions' | 'stacked-fractions'",
  (module Css_types.NumericFractionValues)]

let numeric_fraction_values : numeric_fraction_values Rule.rule =
  Numeric_fraction_values.rule

module Numeric_spacing_values =
  [%spec_module
  "'proportional-nums' | 'tabular-nums'",
  (module Css_types.NumericSpacingValues)]

let numeric_spacing_values : numeric_spacing_values Rule.rule =
  Numeric_spacing_values.rule

module Outline_radius =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.OutlineRadius)]

let outline_radius : outline_radius Rule.rule = Outline_radius.rule

module Overflow_position =
  [%spec_module
  "'unsafe' | 'safe'", (module Css_types.OverflowPosition)]

let overflow_position : overflow_position Rule.rule = Overflow_position.rule

module Page_body =
  [%spec_module
  "[ <declaration> ]? [ ';' <page-body> ]? | <page-margin-box> <page-body>",
  (module Css_types.PageBody)]

let page_body : page_body Rule.rule = Page_body.rule

module Page_margin_box =
  [%spec_module
  "<page-margin-box-type> '{' <declaration-list> '}'",
  (module Css_types.PageMarginBox)]

let page_margin_box : page_margin_box Rule.rule = Page_margin_box.rule

module Page_margin_box_type =
  [%spec_module
  "'@top-left-corner' | '@top-left' | '@top-center' | '@top-right' | \
   '@top-right-corner' | '@bottom-left-corner' | '@bottom-left' | \
   '@bottom-center' | '@bottom-right' | '@bottom-right-corner' | '@left-top' | \
   '@left-middle' | '@left-bottom' | '@right-top' | '@right-middle' | \
   '@right-bottom'",
  (module Css_types.PageMarginBoxType)]

let page_margin_box_type : page_margin_box_type Rule.rule =
  Page_margin_box_type.rule

module Page_selector =
  [%spec_module
  "[ <pseudo-page> ]+ | <ident> [ <pseudo-page> ]*",
  (module Css_types.PageSelector)]

let page_selector : page_selector Rule.rule = Page_selector.rule

module Page_selector_list =
  [%spec_module
  "[ [ <page-selector> ]# ]?", (module Css_types.PageSelectorList)]

let page_selector_list : page_selector_list Rule.rule = Page_selector_list.rule

module Paint =
  [%spec_module
  "'none' | <color> | <url> [ 'none' | <color> ]? | 'context-fill' | \
   'context-stroke' | <interpolation>",
  (module Css_types.Paint)]

let paint : paint Rule.rule = Paint.rule

module Position =
  [%spec_module
  "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ] | \
   [ 'left' | 'center' | 'right' ] && [ 'top' | 'center' | 'bottom' ] | [ \
   'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | \
   'bottom' | <length-percentage> ] | [ [ 'left' | 'right' ] \
   <length-percentage> ] && [ [ 'top' | 'bottom' ] <length-percentage> ]",
  (module Css_types.Position)]

let position : position Rule.rule = Position.rule

module Positive_integer =
  [%spec_module
  "<integer>", (module Css_types.PositiveInteger)]

let positive_integer : positive_integer Rule.rule = Positive_integer.rule

module Font_families =
  [%spec_module
  "[ <family-name> | <generic-family> | <interpolation> ]#",
  (module Css_types.FontFamily)]

let font_families : font_families Rule.rule = Font_families.rule

module Pseudo_class_selector =
  [%spec_module
  "':' <ident-token> | ':' <function-token> <any-value> ')'",
  (module Css_types.PseudoClassSelector)]

let pseudo_class_selector : pseudo_class_selector Rule.rule =
  Pseudo_class_selector.rule

module Pseudo_element_selector =
  [%spec_module
  "':' <pseudo-class-selector>", (module Css_types.PseudoElementSelector)]

let pseudo_element_selector : pseudo_element_selector Rule.rule =
  Pseudo_element_selector.rule

module Pseudo_page =
  [%spec_module
  "':' [ 'left' | 'right' | 'first' | 'blank' ]", (module Css_types.PseudoPage)]

let pseudo_page : pseudo_page Rule.rule = Pseudo_page.rule

module Quote =
  [%spec_module
  "'open-quote' | 'close-quote' | 'no-open-quote' | 'no-close-quote'",
  (module Css_types.Quote)]

let quote : quote Rule.rule = Quote.rule

module Ratio =
  [%spec_module
  "<integer> '/' <integer> | <number> | <interpolation>",
  (module Css_types.Ratio)]

let ratio : ratio Rule.rule = Ratio.rule

module Relative_selector =
  [%spec_module
  "[ <combinator> ]? <complex-selector>", (module Css_types.RelativeSelector)]

let relative_selector : relative_selector Rule.rule = Relative_selector.rule

module Relative_selector_list =
  [%spec_module
  "[ <relative-selector> ]#", (module Css_types.RelativeSelectorList)]

let relative_selector_list : relative_selector_list Rule.rule =
  Relative_selector_list.rule

module Relative_size =
  [%spec_module
  "'larger' | 'smaller'", (module Css_types.RelativeSize)]

let relative_size : relative_size Rule.rule = Relative_size.rule

module Repeat_style =
  [%spec_module
  "'repeat-x' | 'repeat-y' | [ 'repeat' | 'space' | 'round' | 'no-repeat' ] [ \
   'repeat' | 'space' | 'round' | 'no-repeat' ]?",
  (module Css_types.RepeatStyle)]

let repeat_style : repeat_style Rule.rule = Repeat_style.rule

module Self_position =
  [%spec_module
  "'center' | 'start' | 'end' | 'self-start' | 'self-end' | 'flex-start' | \
   'flex-end'",
  (module Css_types.SelfPosition)]

let self_position : self_position Rule.rule = Self_position.rule

module Shadow =
  [%spec_module
  "[ 'inset' ]? [ <extended-length> ]{2,4} [ <color> ]?"]

let shadow : shadow Rule.rule = Shadow.rule

module Shadow_t =
  [%spec_module
  "[ <extended-length> ]{2,3} [ <color> ]?", (module Css_types.TextShadow)]

let shadow_t : shadow_t Rule.rule = Shadow_t.rule

module Shape =
  [%spec_module
  "rect( [ <extended-length> | 'auto' ] ',' [ <extended-length> | 'auto' ] ',' [ <extended-length> | 'auto' ] ',' [ <extended-length> | 'auto' ] ) | rect( [ <extended-length> | 'auto' ] [ <extended-length> | 'auto' ] [ <extended-length> | 'auto' ] [ <extended-length> | 'auto' ] )",
  (module Css_types.Shape)]

let shape : shape Rule.rule = Shape.rule

module Shape_box =
  [%spec_module
  "<box> | 'margin-box'", (module Css_types.ShapeBox)]

let shape_box : shape_box Rule.rule = Shape_box.rule

module Shape_radius =
  [%spec_module
  "<extended-length> | <extended-percentage> | 'closest-side' | 'farthest-side'",
  (module Css_types.ShapeRadius)]

let shape_radius : shape_radius Rule.rule = Shape_radius.rule

module Side_or_corner =
  [%spec_module
  "[ 'left' | 'right' ] || [ 'top' | 'bottom' ]",
  (module Css_types.SideOrCorner)]

let side_or_corner : side_or_corner Rule.rule = Side_or_corner.rule

module Single_animation =
  [%spec_module
  "[ [ <keyframes-name> | 'none' | <interpolation> ] ] | [ [ <keyframes-name> \
   | 'none' | <interpolation> ] <extended-time> ] | [ [ <keyframes-name> | \
   'none' | <interpolation> ] <extended-time> <timing-function> ] | [ [ \
   <keyframes-name> | 'none' | <interpolation> ] <extended-time> \
   <timing-function> <extended-time> ] | [ [ <keyframes-name> | 'none' | \
   <interpolation> ] <extended-time> <timing-function> <extended-time> \
   <single-animation-iteration-count> ] | [ [ <keyframes-name> | 'none' | \
   <interpolation> ] <extended-time> <timing-function> <extended-time> \
   <single-animation-iteration-count> <single-animation-direction> ] | [ [ \
   <keyframes-name> | 'none' | <interpolation> ] <extended-time> \
   <timing-function> <extended-time> <single-animation-iteration-count> \
   <single-animation-direction> <single-animation-fill-mode> ] | [ [ \
   <keyframes-name> | 'none' | <interpolation> ] <extended-time> \
   <timing-function> <extended-time> <single-animation-iteration-count> \
   <single-animation-direction> <single-animation-fill-mode> \
   <single-animation-play-state> ]",
  (module Css_types.SingleAnimation)]

let single_animation : single_animation Rule.rule = Single_animation.rule

(* Uses || (any order) per CSS spec. The or_ combinator's match_longest
   tie-breaking assigns the FIRST input <time> to position 3 (last matching
   rule) and the SECOND input <time> to position 1 (first matching rule).
   This means: tuple position 1 = delay, tuple position 3 = duration.
   See render_single_animation_no_interp in Property_to_runtime.re. *)
module Single_animation_no_interp =
  [%spec_module
  "[ <keyframes-name> | 'none' ] || <extended-time-no-interp> || \
   <timing-function-no-interp> || <extended-time-no-interp> || \
   <single-animation-iteration-count-no-interp> || \
   <single-animation-direction-no-interp> || \
   <single-animation-fill-mode-no-interp> || \
   <single-animation-play-state-no-interp>",
  (module Css_types.SingleAnimationNoInterp)]

let single_animation_no_interp : single_animation_no_interp Rule.rule =
  Single_animation_no_interp.rule

module Single_animation_direction =
  [%spec_module
  "'normal' | 'reverse' | 'alternate' | 'alternate-reverse' | <interpolation>",
  (module Css_types.SingleAnimationDirection)]

let single_animation_direction : single_animation_direction Rule.rule =
  Single_animation_direction.rule

module Single_animation_direction_no_interp =
  [%spec_module
  "'normal' | 'reverse' | 'alternate' | 'alternate-reverse'"]

let single_animation_direction_no_interp :
  single_animation_direction_no_interp Rule.rule =
  Single_animation_direction_no_interp.rule

module Single_animation_fill_mode =
  [%spec_module
  "'none' | 'forwards' | 'backwards' | 'both' | <interpolation>",
  (module Css_types.SingleAnimationFillMode)]

let single_animation_fill_mode : single_animation_fill_mode Rule.rule =
  Single_animation_fill_mode.rule

module Single_animation_fill_mode_no_interp =
  [%spec_module
  "'none' | 'forwards' | 'backwards' | 'both'"]

let single_animation_fill_mode_no_interp :
  single_animation_fill_mode_no_interp Rule.rule =
  Single_animation_fill_mode_no_interp.rule

module Single_animation_iteration_count =
  [%spec_module
  "'infinite' | <number> | <interpolation>"]

let single_animation_iteration_count :
  single_animation_iteration_count Rule.rule =
  Single_animation_iteration_count.rule

module Single_animation_iteration_count_no_interp =
  [%spec_module
  "'infinite' | <number>"]

let single_animation_iteration_count_no_interp :
  single_animation_iteration_count_no_interp Rule.rule =
  Single_animation_iteration_count_no_interp.rule

module Single_animation_play_state =
  [%spec_module
  "'running' | 'paused' | <interpolation>",
  (module Css_types.SingleAnimationPlayState)]

let single_animation_play_state : single_animation_play_state Rule.rule =
  Single_animation_play_state.rule

module Single_animation_play_state_no_interp =
  [%spec_module
  "'running' | 'paused'"]

let single_animation_play_state_no_interp :
  single_animation_play_state_no_interp Rule.rule =
  Single_animation_play_state_no_interp.rule

module Single_transition_no_interp =
  [%spec_module
  "[ <single-transition-property-no-interp> | 'none' ] || \
   <extended-time-no-interp> || <timing-function-no-interp> || \
   <extended-time-no-interp> || <transition-behavior-value-no-interp>",
  (module Css_types.SingleTransitionNoInterp)]

let single_transition_no_interp : single_transition_no_interp Rule.rule =
  Single_transition_no_interp.rule

module Single_transition =
  [%spec_module
  "[<single-transition-property> | 'none'] | [ [<single-transition-property> | \
   'none'] <extended-time> ] | [ [<single-transition-property> | 'none'] \
   <extended-time> <timing-function> ] | [ [<single-transition-property> | \
   'none'] <extended-time> <timing-function> <extended-time> ] | [ \
   [<single-transition-property> | 'none'] <extended-time> <timing-function> \
   <extended-time> <transition-behavior-value> ]",
  (module Css_types.SingleTransition)]

let single_transition : single_transition Rule.rule = Single_transition.rule

module Single_transition_property =
  [%spec_module
  "<custom-ident> | <interpolation> | 'all'",
  (module Css_types.TransitionProperty)]

let single_transition_property : single_transition_property Rule.rule =
  Single_transition_property.rule

module Single_transition_property_no_interp =
  [%spec_module
  "<custom-ident> | 'all'"]

let single_transition_property_no_interp :
  single_transition_property_no_interp Rule.rule =
  Single_transition_property_no_interp.rule

module Ray_size =
  [%spec_module
  "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
   'sides'",
  (module Css_types.RaySize)]

let ray_size : ray_size Rule.rule = Ray_size.rule

module Radial_size =
  [%spec_module
  "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
   <extended-length> | [ <extended-length> | <extended-percentage> ]{2}",
  (module Css_types.RadialSize)]

let radial_size : radial_size Rule.rule = Radial_size.rule

module Step_position =
  [%spec_module
  "'jump-start' | 'jump-end' | 'jump-none' | 'jump-both' | 'start' | 'end'",
  (module Css_types.StepPosition)]

let step_position : step_position Rule.rule = Step_position.rule

module Step_timing_function =
  [%spec_module
  "'step-start' | 'step-end' | steps( <integer> [ ',' <step-position> ]? )",
  (module Css_types.StepTimingFunction)]

let step_timing_function : step_timing_function Rule.rule =
  Step_timing_function.rule

module Subclass_selector =
  [%spec_module
  "<id-selector> | <class-selector> | <attribute-selector> | \
   <pseudo-class-selector>",
  (module Css_types.SubclassSelector)]

let subclass_selector : subclass_selector Rule.rule = Subclass_selector.rule

module Supports_condition =
  [%spec_module
  "'not' <supports-in-parens> | <supports-in-parens> [ 'and' \
   <supports-in-parens> ]* | <supports-in-parens> [ 'or' <supports-in-parens> \
   ]*",
  (module Css_types.SupportsCondition)]

let supports_condition : supports_condition Rule.rule = Supports_condition.rule

module Supports_decl =
  [%spec_module
  "'(' <declaration> ')'", (module Css_types.SupportsDecl)]

let supports_decl : supports_decl Rule.rule = Supports_decl.rule

module Supports_feature =
  [%spec_module
  "<supports-decl> | <supports-selector-fn>", (module Css_types.SupportsFeature)]

let supports_feature : supports_feature Rule.rule = Supports_feature.rule

module Supports_in_parens =
  [%spec_module
  "'(' <supports-condition> ')' | <supports-feature>",
  (module Css_types.SupportsInParens)]

let supports_in_parens : supports_in_parens Rule.rule = Supports_in_parens.rule

module Supports_selector_fn =
  [%spec_module
  "selector( <complex-selector> )", (module Css_types.SupportsSelectorFn)]

let supports_selector_fn : supports_selector_fn Rule.rule =
  Supports_selector_fn.rule

module Svg_length =
  [%spec_module
  "<extended-percentage> | <extended-length> | <number>",
  (module Css_types.SvgLength)]

let svg_length : svg_length Rule.rule = Svg_length.rule

module Svg_writing_mode =
  [%spec_module
  "'lr-tb' | 'rl-tb' | 'tb-rl' | 'lr' | 'rl' | 'tb'",
  (module Css_types.SvgWritingMode)]

let svg_writing_mode : svg_writing_mode Rule.rule = Svg_writing_mode.rule

module Symbol =
  [%spec_module
  "<string> | <image> | <custom-ident>", (module Css_types.Symbol)]

let symbol : symbol Rule.rule = Symbol.rule

module Symbols_type =
  [%spec_module
  "'cyclic' | 'numeric' | 'alphabetic' | 'symbolic' | 'fixed'",
  (module Css_types.SymbolsType)]

let symbols_type : symbols_type Rule.rule = Symbols_type.rule

module Target =
  [%spec_module
  "<target-counter()> | <target-counters()> | <target-text()>",
  (module Css_types.Target)]

let target : target Rule.rule = Target.rule

module Url =
  [%spec_module
  "<url-no-interp> | url( <interpolation> )", (module Css_types.Url)]

let url : url Rule.rule = Url.rule

(* https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/length-percentage#use_in_calc *)
module Extended_length =
  [%spec_module
  "<length> | <calc()> | <interpolation> | <min()> | <max()>",
  (module Css_types.Length)]

let extended_length : extended_length Rule.rule = Extended_length.rule

(* https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/length-percentage#use_in_calc *)
module Length_percentage =
  [%spec_module
  "<extended-length> | <extended-percentage>",
  (module Css_types.LengthPercentage)]

let length_percentage : length_percentage Rule.rule = Length_percentage.rule

module Extended_frequency =
  [%spec_module
  "<frequency> | <calc()> | <interpolation> | <min()> | <max()>",
  (module Css_types.Frequency)]

let extended_frequency : extended_frequency Rule.rule = Extended_frequency.rule

module Extended_angle =
  [%spec_module
  "<angle> | <calc()> | <interpolation> | <min()> | <max()>",
  (module Css_types.Angle)]

let extended_angle : extended_angle Rule.rule = Extended_angle.rule

module Extended_time =
  [%spec_module
  "<time> | <calc()> | <interpolation> | <min()> | <max()>",
  (module Css_types.Time)]

let extended_time : extended_time Rule.rule = Extended_time.rule

module Extended_time_no_interp =
  [%spec_module
  "<time> | <calc()> | <min()> | <max()>", (module Css_types.Time)]

let extended_time_no_interp : extended_time_no_interp Rule.rule =
  Extended_time_no_interp.rule

module Extended_percentage =
  [%spec_module
  "<percentage> | <calc()> | <interpolation> | <min()> | <max()> ",
  (module Css_types.Percentage)]

let extended_percentage : extended_percentage Rule.rule =
  Extended_percentage.rule

module Timing_function =
  [%spec_module
  "'linear' | <cubic-bezier-timing-function> | <step-timing-function> | \
   <interpolation>",
  (module Css_types.TransitionTimingFunction)]

let timing_function : timing_function Rule.rule = Timing_function.rule

module Timing_function_no_interp =
  [%spec_module
  "'linear' | <cubic-bezier-timing-function> | <step-timing-function>",
  (module Css_types.TimingFunctionNoInterp)]

let timing_function_no_interp : timing_function_no_interp Rule.rule =
  Timing_function_no_interp.rule

module Try_tactic =
  [%spec_module
  "'flip-block' | 'flip-inline' | 'flip-start'", (module Css_types.TryTactic)]

let try_tactic : try_tactic Rule.rule = Try_tactic.rule

module Track_breadth =
  [%spec_module
  "<extended-length> | <extended-percentage> | <flex-value> | 'min-content' | \
   'max-content' | 'auto'",
  (module Css_types.TrackBreadth)]

let track_breadth : track_breadth Rule.rule = Track_breadth.rule

module Track_group =
  [%spec_module
  "'(' [ [ <string> ]* <track-minmax> [ <string> ]* ]+ ')' [ '[' \
   <positive-integer> ']' ]? | <track-minmax>",
  (module Css_types.TrackGroup)]

let track_group : track_group Rule.rule = Track_group.rule

module Track_list =
  [%spec_module
  "[ [ <line-names> ]? [ <track-size> | <track-repeat> ] ]+ [ <line-names> ]?",
  (module Css_types.TrackList)]

let track_list : track_list Rule.rule = Track_list.rule

module Track_list_v0 =
  [%spec_module
  "[ [ <string> ]* <track-group> [ <string> ]* ]+ | 'none'",
  (module Css_types.TrackListV0)]

let track_list_v0 : track_list_v0 Rule.rule = Track_list_v0.rule

module Track_minmax =
  [%spec_module
  "minmax( <track-breadth> ',' <track-breadth> ) | 'auto' | <track-breadth> | \
   fit-content( <extended-length> | <extended-percentage> )",
  (module Css_types.TrackMinmax)]

let track_minmax : track_minmax Rule.rule = Track_minmax.rule

module Track_repeat =
  [%spec_module
  "repeat( <positive-integer> ',' [ [ <line-names> ]? <track-size> ]+ [ \
   <line-names> ]? )",
  (module Css_types.TrackRepeat)]

let track_repeat : track_repeat Rule.rule = Track_repeat.rule

module Track_size =
  [%spec_module
  "<track-breadth> | minmax( <inflexible-breadth> ',' <track-breadth> ) | \
   fit-content( <extended-length> | <extended-percentage> )",
  (module Css_types.TrackSize)]

let track_size : track_size Rule.rule = Track_size.rule

module Transform_function =
  [%spec_module
  "<matrix()> | <translate()> | <translateX()> | <translateY()> | <scale()> | \
   <scaleX()> | <scaleY()> | <rotate()> | <skew()> | <skewX()> | <skewY()> | \
   <matrix3d()> | <translate3d()> | <translateZ()> | <scale3d()> | <scaleZ()> \
   | <rotate3d()> | <rotateX()> | <rotateY()> | <rotateZ()> | <perspective()>",
  (module Css_types.TransformFunction)]

let transform_function : transform_function Rule.rule = Transform_function.rule

module Transform_list =
  [%spec_module
  "[ <transform-function> ]+", (module Css_types.TransformList)]

let transform_list : transform_list Rule.rule = Transform_list.rule

module Transition_behavior_value =
  [%spec_module
  "'normal' | 'allow-discrete' | <interpolation>",
  (module Css_types.TransitionBehavior)]

let transition_behavior_value : transition_behavior_value Rule.rule =
  Transition_behavior_value.rule

module Transition_behavior_value_no_interp =
  [%spec_module
  "'normal' | 'allow-discrete'"]

let transition_behavior_value_no_interp :
  transition_behavior_value_no_interp Rule.rule =
  Transition_behavior_value_no_interp.rule

module Type_or_unit =
  [%spec_module
  "'string' | 'color' | 'url' | 'integer' | 'number' | 'length' | 'angle' | \
   'time' | 'frequency' | 'cap' | 'ch' | 'em' | 'ex' | 'ic' | 'lh' | 'rlh' | \
   'rem' | 'vb' | 'vi' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'mm' | 'Q' | 'cm' | \
   'in' | 'pt' | 'pc' | 'px' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | 's' | \
   'Hz' | 'kHz' | '%'",
  (module Css_types.TypeOrUnit)]

let type_or_unit : type_or_unit Rule.rule = Type_or_unit.rule

module Type_selector =
  [%spec_module
  "<wq-name> | [ <ns-prefix> ]? '*'", (module Css_types.TypeSelector)]

let type_selector : type_selector Rule.rule = Type_selector.rule

module Viewport_length =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.ViewportLength)]

let viewport_length : viewport_length Rule.rule = Viewport_length.rule

module Visual_box =
  [%spec_module
  "'content-box' | 'padding-box' | 'border-box'", (module Css_types.VisualBox)]

let visual_box : visual_box Rule.rule = Visual_box.rule

module Wq_name =
  [%spec_module
  "[ <ns-prefix> ]? <ident-token>", (module Css_types.WqName)]

let wq_name : wq_name Rule.rule = Wq_name.rule

module Attr_name =
  [%spec_module
  "[ <ident-token>? '|' ]? <ident-token>", (module Css_types.AttrName)]

let attr_name : attr_name Rule.rule = Attr_name.rule

module Attr_unit =
  [%spec_module
  "'%' | 'em' | 'ex' | 'ch' | 'rem' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'cm' | \
   'mm' | 'in' | 'px' | 'pt' | 'pc' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | \
   's' | 'Hz' | 'kHz'",
  (module Css_types.AttrUnit)]

let attr_unit : attr_unit Rule.rule = Attr_unit.rule

module Syntax_type_name =
  [%spec_module
  "'angle' | 'color' | 'custom-ident' | 'image' | 'integer' | 'length' | \
   'length-percentage' | 'number' | 'percentage' | 'resolution' | 'string' | \
   'time' | 'url' | 'transform-function'",
  (module Css_types.SyntaxTypeName)]

let syntax_type_name : syntax_type_name Rule.rule = Syntax_type_name.rule

module Syntax_multiplier =
  [%spec_module
  "'#' | '+'", (module Css_types.SyntaxMultiplier)]

let syntax_multiplier : syntax_multiplier Rule.rule = Syntax_multiplier.rule

module Syntax_single_component =
  [%spec_module
  "'<' <syntax-type-name> '>' | <ident>",
  (module Css_types.SyntaxSingleComponent)]

let syntax_single_component : syntax_single_component Rule.rule =
  Syntax_single_component.rule

module Syntax_string =
  [%spec_module
  "<string>", (module Css_types.SyntaxString)]

let syntax_string : syntax_string Rule.rule = Syntax_string.rule

module Syntax_combinator =
  [%spec_module
  "'|'", (module Css_types.SyntaxCombinator)]

let syntax_combinator : syntax_combinator Rule.rule = Syntax_combinator.rule

module Syntax_component =
  [%spec_module
  "<syntax-single-component> [ <syntax-multiplier> ]? | '<' 'transform-list' \
   '>'",
  (module Css_types.SyntaxComponent)]

let syntax_component : syntax_component Rule.rule = Syntax_component.rule

(* (*
 We don't support type() yet, original spec is: "type( <syntax> ) | 'raw-string' | <attr-unit>" *) *)
module Attr_type =
  [%spec_module
  "'raw-string' | <attr-unit>", (module Css_types.AttrType)]

let attr_type : attr_type Rule.rule = Attr_type.rule
