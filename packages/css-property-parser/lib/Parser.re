open Standard;
open Modifier;
open Rule.Match;
open Styled_ppx_css_parser;

module StringMap = Map.Make(String);

let (let.ok) = Result.bind;

/* https://developer.mozilla.org/en-US/docs/Web/CSS/gradient */
let rec _legacy_gradient = [%value.rec
  "<-webkit-gradient()> | <-legacy-linear-gradient> | <-legacy-repeating-linear-gradient> | <-legacy-radial-gradient> | <-legacy-repeating-radial-gradient>"
]
and _legacy_linear_gradient = [%value.rec
  "-moz-linear-gradient( <-legacy-linear-gradient-arguments> ) | -webkit-linear-gradient( <-legacy-linear-gradient-arguments> ) | -o-linear-gradient( <-legacy-linear-gradient-arguments> )"
]
and _legacy_linear_gradient_arguments = [%value.rec
  "[ <extended-angle> | <side-or-corner> ]? ',' <color-stop-list>"
]
and _legacy_radial_gradient = [%value.rec
  "-moz-radial-gradient( <-legacy-radial-gradient-arguments> ) | -webkit-radial-gradient( <-legacy-radial-gradient-arguments> ) | -o-radial-gradient( <-legacy-radial-gradient-arguments> )"
]
and _legacy_radial_gradient_arguments = [%value.rec
  "[ <position> ',' ]? [ [ <-legacy-radial-gradient-shape> || <-legacy-radial-gradient-size> | [ <extended-length> | <extended-percentage> ]{2} ] ',' ]? <color-stop-list>"
]
and _legacy_radial_gradient_shape = [%value.rec "'circle' | 'ellipse'"]
and _legacy_radial_gradient_size = [%value.rec
  "'closest-side' | 'closest-corner' | 'farthest-side' | 'farthest-corner' | 'contain' | 'cover'"
]
and _legacy_repeating_linear_gradient = [%value.rec
  "-moz-repeating-linear-gradient( <-legacy-linear-gradient-arguments> ) | -webkit-repeating-linear-gradient( <-legacy-linear-gradient-arguments> ) | -o-repeating-linear-gradient( <-legacy-linear-gradient-arguments> )"
]
and _legacy_repeating_radial_gradient = [%value.rec
  "-moz-repeating-radial-gradient( <-legacy-radial-gradient-arguments> ) | -webkit-repeating-radial-gradient( <-legacy-radial-gradient-arguments> ) | -o-repeating-radial-gradient( <-legacy-radial-gradient-arguments> )"
]
and _non_standard_color = [%value.rec
  "'-moz-ButtonDefault' | '-moz-ButtonHoverFace' | '-moz-ButtonHoverText' | '-moz-CellHighlight' | '-moz-CellHighlightText' | '-moz-Combobox' | '-moz-ComboboxText' | '-moz-Dialog' | '-moz-DialogText' | '-moz-dragtargetzone' | '-moz-EvenTreeRow' | '-moz-Field' | '-moz-FieldText' | '-moz-html-CellHighlight' | '-moz-html-CellHighlightText' | '-moz-mac-accentdarkestshadow' | '-moz-mac-accentdarkshadow' | '-moz-mac-accentface' | '-moz-mac-accentlightesthighlight' | '-moz-mac-accentlightshadow' | '-moz-mac-accentregularhighlight' | '-moz-mac-accentregularshadow' | '-moz-mac-chrome-active' | '-moz-mac-chrome-inactive' | '-moz-mac-focusring' | '-moz-mac-menuselect' | '-moz-mac-menushadow' | '-moz-mac-menutextselect' | '-moz-MenuHover' | '-moz-MenuHoverText' | '-moz-MenuBarText' | '-moz-MenuBarHoverText' | '-moz-nativehyperlinktext' | '-moz-OddTreeRow' | '-moz-win-communicationstext' | '-moz-win-mediatext' | '-moz-activehyperlinktext' | '-moz-default-background-color' | '-moz-default-color' | '-moz-hyperlinktext' | '-moz-visitedhyperlinktext' | '-webkit-activelink' | '-webkit-focus-ring-color' | '-webkit-link' | '-webkit-text'"
]
and _non_standard_font = [%value.rec
  "'-apple-system-body' | '-apple-system-headline' | '-apple-system-subheadline' | '-apple-system-caption1' | '-apple-system-caption2' | '-apple-system-footnote' | '-apple-system-short-body' | '-apple-system-short-headline' | '-apple-system-short-subheadline' | '-apple-system-short-caption1' | '-apple-system-short-footnote' | '-apple-system-tall-body'"
]
and _non_standard_image_rendering = [%value.rec
  "'optimize-contrast' | '-moz-crisp-edges' | '-o-crisp-edges' | '-webkit-optimize-contrast'"
]
and _non_standard_overflow = [%value.rec
  "'-moz-scrollbars-none' | '-moz-scrollbars-horizontal' | '-moz-scrollbars-vertical' | '-moz-hidden-unscrollable'"
]
and _non_standard_width = [%value.rec
  "'min-intrinsic' | 'intrinsic' | '-moz-min-content' | '-moz-max-content' | '-webkit-min-content' | '-webkit-max-content'"
]
and _webkit_gradient_color_stop = [%value.rec
  "from( <color> ) | color-stop( [ <alpha-value> | <extended-percentage> ] ',' <color> ) | to( <color> )"
]
and _webkit_gradient_point = [%value.rec
  "[ 'left' | 'center' | 'right' | <extended-length> | <extended-percentage> ] [ 'top' | 'center' | 'bottom' | <extended-length> | <extended-percentage> ]"
]
and _webkit_gradient_radius = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and _webkit_gradient_type = [%value.rec "'linear' | 'radial'"]
and _webkit_mask_box_repeat = [%value.rec "'repeat' | 'stretch' | 'round'"]
and _webkit_mask_clip_style = [%value.rec
  "'border' | 'border-box' | 'padding' | 'padding-box' | 'content' | 'content-box' | 'text'"
]
and absolute_size = [%value.rec
  "'xx-small' | 'x-small' | 'small' | 'medium' | 'large' | 'x-large' | 'xx-large' | 'xxx-large'"
]
and age = [%value.rec "'child' | 'young' | 'old'"]
and alpha_value = [%value.rec "<number> | <extended-percentage>"]
and angular_color_hint = [%value.rec
  "<extended-angle> | <extended-percentage>"
]
and angular_color_stop = [%value.rec "<color> && [ <color-stop-angle> ]?"]
and angular_color_stop_list = [%value.rec
  "[ <angular-color-stop> [ ',' <angular-color-hint> ]? ]# ',' <angular-color-stop>"
]
and animateable_feature = [%value.rec
  "'scroll-position' | 'contents' | <custom-ident>"
]
and attachment = [%value.rec "'scroll' | 'fixed' | 'local'"]
and attr_fallback = [%value.rec "<any-value>"]
and attr_matcher = [%value.rec "[ '~' | '|' | '^' | '$' | '*' ]? '='"]
and attr_modifier = [%value.rec "'i' | 's'"]
and attribute_selector = [%value.rec
  "'[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [ <string-token> | <ident-token> ] [ <attr-modifier> ]? ']'"
]
and auto_repeat = [%value.rec
  "repeat( [ 'auto-fill' | 'auto-fit' ] ',' [ [ <line-names> ]? <fixed-size> ]+ [ <line-names> ]? )"
]
and auto_track_list = [%value.rec
  "[ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ <line-names> ]? <auto-repeat> [ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ <line-names> ]?"
]
and baseline_position = [%value.rec "[ 'first' | 'last' ]? 'baseline'"]
and basic_shape = [%value.rec
  "<inset()> | <circle()> | <ellipse()> | <polygon()> | <path()>"
]
and bg_image = [%value.rec "'none' | <image>"]
and bg_layer = [%value.rec
  "<bg-image> || <bg-position> [ '/' <bg-size> ]? || <repeat-style> || <attachment> || <box> || <box>"
]
and bg_position = [%value.rec
  "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ]
  | [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | 'bottom' | <length-percentage> ]
  | [ 'center' | [ 'left' | 'right' ] <length-percentage>? ] && [ 'center' | [ 'top' | 'bottom' ] <length-percentage>? ]"
]
/* one_bg_size isn't part of the spec, helps us with Type generation */
and one_bg_size = [%value.rec
  "[ <extended-length> | <extended-percentage> | 'auto' ] [ <extended-length> | <extended-percentage> | 'auto' ]?"
]
and bg_size = [%value.rec "<one-bg-size> | 'cover' | 'contain'"]
and blend_mode = [%value.rec
  "'normal' | 'multiply' | 'screen' | 'overlay' | 'darken' | 'lighten' | 'color-dodge' | 'color-burn' | 'hard-light' | 'soft-light' | 'difference' | 'exclusion' | 'hue' | 'saturation' | 'color' | 'luminosity'"
]
/* and border_radius = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"] */
and border_radius = [%value.rec "<extended-length> | <extended-percentage>"]
and bottom = [%value.rec "<extended-length> | 'auto'"]
and box = [%value.rec "'border-box' | 'padding-box' | 'content-box'"]
and calc_product = [%value.rec
  "<calc-value> [ '*' <calc-value> | '/' <number> ]*"
]
and dimension = [%value.rec
  "<extended-length> | <extended-time> | <extended-frequency> | <resolution>"
]
and calc_sum = [%value.rec "<calc-product> [ [ '+' | '-' ] <calc-product> ]*"]
/* and calc_value = [%value.rec "<number> | <dimension> | <extended-percentage> | <calc>"] */
and calc_value = [%value.rec
  "<number> | <extended-length> | <extended-percentage> | <extended-angle> | <extended-time> | '(' <calc-sum> ')'"
]
and cf_final_image = [%value.rec "<image> | <color>"]
and cf_mixing_image = [%value.rec "[ <extended-percentage> ]? && <image>"]
and class_selector = [%value.rec "'.' <ident-token>"]
and clip_source = [%value.rec "<url>"]
and color = [%value.rec
  "<rgb()> | <rgba()> | <hsl()> | <hsla()> | <hex-color> | <named-color> | 'currentColor' | <deprecated-system-color> | <interpolation> | <var()> | <color-mix()>"
]
and color_stop = [%value.rec "<color-stop-length> | <color-stop-angle>"]
and color_stop_angle = [%value.rec "[ <extended-angle> ]{1,2}"]
/* and color_stop_length = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"] */
and color_stop_length = [%value.rec
  "<extended-length> | <extended-percentage>"
]
/* color_stop_list is modified from the original spec, here is a simplified version where it tries to be fully compatible but easier for code-gen:

   The current impl allows values that aren't really supported such as: `linear-gradient(0deg, 10%, blue)` which is invalid, but we allow it for now to make it easier to generate the types. The correct value would require always a color to be in the first position `linear-gradient(0deg, red, 10%, blue);`

   The original spec is `color_stop_list = [%value.rec "[ <linear-color-stop> [ ',' <linear-color-hint> ]? ]# ',' <linear-color-stop>"]`
   */
and color_stop_list = [%value.rec
  "[ [<color>? <length-percentage>] | [<color> <length-percentage>?] ]#"
]
and hue_interpolation_method = [%value.rec
  " [ 'shorter' | 'longer' | 'increasing' | 'decreasing' ] && 'hue' "
]
and polar_color_space = [%value.rec " 'hsl' | 'hwb' | 'lch' | 'oklch' "]
and rectangular_color_space = [%value.rec
  " 'srgb' | 'srgb-linear' | 'display-p3' | 'a98-rgb' | 'prophoto-rgb' | 'rec2020' | 'lab' | 'oklab' | 'xyz' | 'xyz-d50' | 'xyz-d65' "
]
and color_interpolation_method = [%value.rec
  " 'in' && [<rectangular-color-space> | <polar-color-space> <hue-interpolation-method>?] "
]
and function_color_mix = [%value.rec
  // TODO: Use <extended-percentage>
  "color-mix(<color-interpolation-method> ',' [ <color> && <percentage>? ] ',' [ <color> && <percentage>? ])"
]
and combinator = [%value.rec "'>' | '+' | '~' | '||'"]
and common_lig_values = [%value.rec
  "'common-ligatures' | 'no-common-ligatures'"
]
and compat_auto = [%value.rec
  "'searchfield' | 'textarea' | 'push-button' | 'slider-horizontal' | 'checkbox' | 'radio' | 'square-button' | 'menulist' | 'listbox' | 'meter' | 'progress-bar'"
]
and complex_selector = [%value.rec
  "<compound-selector> [ [ <combinator> ]? <compound-selector> ]*"
]
and complex_selector_list = [%value.rec "[ <complex-selector> ]#"]
and composite_style = [%value.rec
  "'clear' | 'copy' | 'source-over' | 'source-in' | 'source-out' | 'source-atop' | 'destination-over' | 'destination-in' | 'destination-out' | 'destination-atop' | 'xor'"
]
and compositing_operator = [%value.rec
  "'add' | 'subtract' | 'intersect' | 'exclude'"
]
and compound_selector = [%value.rec
  "[ <type-selector> ]? [ <subclass-selector> ]* [ <pseudo-element-selector> [ <pseudo-class-selector> ]* ]*"
]
and compound_selector_list = [%value.rec "[ <compound-selector> ]#"]
and content_distribution = [%value.rec
  "'space-between' | 'space-around' | 'space-evenly' | 'stretch'"
]
and content_list = [%value.rec
  "[ <string> | 'contents' | <url> | <quote> | <attr()> | counter( <ident> ',' [ <'list-style-type'> ]? ) ]+"
]
and content_position = [%value.rec
  "'center' | 'start' | 'end' | 'flex-start' | 'flex-end'"
]
and content_replacement = [%value.rec "<image>"]
and contextual_alt_values = [%value.rec "'contextual' | 'no-contextual'"]
and counter_style = [%value.rec "<counter-style-name> | <symbols()>"]
and counter_style_name = [%value.rec "<custom-ident>"]
and counter_name = [%value.rec "<custom-ident>"]
and cubic_bezier_timing_function = [%value.rec
  "'ease' | 'ease-in' | 'ease-out' | 'ease-in-out' | cubic-bezier( <number> ',' <number> ',' <number> ',' <number> )"
]
and declaration = [%value.rec
  "<ident-token> ':' [ <declaration-value> ]? [ '!' 'important' ]?"
]
and declaration_list = [%value.rec
  "[ [ <declaration> ]? ';' ]* [ <declaration> ]?"
]
and deprecated_system_color = [%value.rec
  "'ActiveBorder' | 'ActiveCaption' | 'AppWorkspace' | 'Background' | 'ButtonFace' | 'ButtonHighlight' | 'ButtonShadow' | 'ButtonText' | 'CaptionText' | 'GrayText' | 'Highlight' | 'HighlightText' | 'InactiveBorder' | 'InactiveCaption' | 'InactiveCaptionText' | 'InfoBackground' | 'InfoText' | 'Menu' | 'MenuText' | 'Scrollbar' | 'ThreeDDarkShadow' | 'ThreeDFace' | 'ThreeDHighlight' | 'ThreeDLightShadow' | 'ThreeDShadow' | 'Window' | 'WindowFrame' | 'WindowText'"
]
and discretionary_lig_values = [%value.rec
  "'discretionary-ligatures' | 'no-discretionary-ligatures'"
]
and display_box = [%value.rec "'contents' | 'none'"]
and display_inside = [%value.rec
  "'flow' | 'flow-root' | 'table' | 'flex' | 'grid' | 'ruby'"
]
and display_internal = [%value.rec
  "'table-row-group' | 'table-header-group' | 'table-footer-group' | 'table-row' | 'table-cell' | 'table-column-group' | 'table-column' | 'table-caption' | 'ruby-base' | 'ruby-text' | 'ruby-base-container' | 'ruby-text-container'"
]
and display_legacy = [%value.rec
  "'inline-block' | 'inline-list-item' | 'inline-table' | 'inline-flex' | 'inline-grid'"
]
and display_listitem = [%value.rec
  "[ <display-outside> ]? && [ 'flow' | 'flow-root' ]? && 'list-item'"
]
and display_outside = [%value.rec "'block' | 'inline' | 'run-in'"]
and east_asian_variant_values = [%value.rec
  "'jis78' | 'jis83' | 'jis90' | 'jis04' | 'simplified' | 'traditional'"
]
and east_asian_width_values = [%value.rec
  "'full-width' | 'proportional-width'"
]
and ending_shape = [%value.rec "'circle' | 'ellipse'"]
and explicit_track_list = [%value.rec
  "[ [ <line-names> ]? <track-size> ]+ [ <line-names> ]?"
]
and family_name = [%value.rec "<string> | <custom-ident>"]
and feature_tag_value = [%value.rec "<string> [ <integer> | 'on' | 'off' ]?"]
and feature_type = [%value.rec
  "'@stylistic' | '@historical-forms' | '@styleset' | '@character-variant' | '@swash' | '@ornaments' | '@annotation'"
]
and feature_value_block = [%value.rec
  "<feature-type> '{' <feature-value-declaration-list> '}'"
]
and feature_value_block_list = [%value.rec "[ <feature-value-block> ]+"]
and feature_value_declaration = [%value.rec
  "<custom-ident> ':' [ <integer> ]+ ';'"
]
and feature_value_declaration_list = [%value.rec "<feature-value-declaration>"]
and feature_value_name = [%value.rec "<custom-ident>"]
and fill_rule = [%value.rec "'nonzero' | 'evenodd'"]
and filter_function = [%value.rec
  "<blur()> | <brightness()> | <contrast()> | <drop-shadow()> | <grayscale()> | <hue-rotate()> | <invert()> | <opacity()> | <saturate()> | <sepia()>"
]
and filter_function_list = [%value.rec "[ <filter-function> | <url> ]+"]
and final_bg_layer = [%value.rec
  "<'background-color'> || <bg-image> || <bg-position> [ '/' <bg-size> ]? || <repeat-style> || <attachment> || <box> || <box>"
]
and line_names = [%value.rec "'[' <custom-ident>* ']'"]
and fixed_breadth = [%value.rec "<extended-length> | <extended-percentage>"]
and fixed_repeat = [%value.rec
  "repeat( <positive-integer> ',' [ [ <line-names> ]? <fixed-size> ]+ [ <line-names> ]? )"
]
and fixed_size = [%value.rec
  "<fixed-breadth> | minmax( <fixed-breadth> ',' <track-breadth> ) | minmax( <inflexible-breadth> ',' <fixed-breadth> )"
]
and font_stretch_absolute = [%value.rec
  "'normal' | 'ultra-condensed' | 'extra-condensed' | 'condensed' | 'semi-condensed' | 'semi-expanded' | 'expanded' | 'extra-expanded' | 'ultra-expanded' | <extended-percentage>"
]
and font_variant_css21 = [%value.rec "'normal' | 'small-caps'"]
and font_weight_absolute = [%value.rec "'normal' | 'bold' | <integer>"]
and function__webkit_gradient = [%value.rec
  "-webkit-gradient( <-webkit-gradient-type> ',' <-webkit-gradient-point> [ ',' <-webkit-gradient-point> | ',' <-webkit-gradient-radius> ',' <-webkit-gradient-point> ] [ ',' <-webkit-gradient-radius> ]? [ ',' <-webkit-gradient-color-stop> ]* )"
]
/* We don't support attr() with fallback value (since it's a declaration value) yet, original spec is: "attr(<attr-name> <attr-type>? , <declaration-value>?)" */
and function_attr = [%value.rec "attr(<attr-name> <attr-type>?)"]
/* and function_attr = [%value.rec
     "attr(<attr-name> <attr-type>? , <declaration-value>?)"
   ] */
and function_blur = [%value.rec "blur( <extended-length> )"]
and function_brightness = [%value.rec "brightness( <number-percentage> )"]
and function_calc = [%value.rec "calc( <calc-sum> )"]
and function_circle = [%value.rec
  "circle( [ <shape-radius> ]? [ 'at' <position> ]? )"
]
and function_clamp = [%value.rec "clamp( [ <calc-sum> ]#{3} )"]
and function_conic_gradient = [%value.rec
  "conic-gradient( [ 'from' <extended-angle> ]? [ 'at' <position> ]? ',' <angular-color-stop-list> )"
]
and function_contrast = [%value.rec "contrast( <number-percentage> )"]
and function_counter = [%value.rec
  "counter( <counter-name> , <counter-style>? )"
]
and function_counters = [%value.rec
  "counters( <custom-ident> ',' <string> ',' [ <counter-style> ]? )"
]
and function_cross_fade = [%value.rec
  "cross-fade( <cf-mixing-image> ',' [ <cf-final-image> ]? )"
]
/* drop-shadow can have 2 length and order doesn't matter, we changed to be more restrict and always expect 3 */
and function_drop_shadow = [%value.rec
  "drop-shadow(<extended-length> <extended-length> <extended-length> [ <color> ]?)"
]
and function_element = [%value.rec "element( <id-selector> )"]
and function_ellipse = [%value.rec
  "ellipse( [ [ <shape-radius> ]{2} ]? [ 'at' <position> ]? )"
]
and function_env = [%value.rec
  "env( <custom-ident> ',' [ <declaration-value> ]? )"
]
and function_fit_content = [%value.rec
  "fit-content( <extended-length> | <extended-percentage> )"
]
and function_grayscale = [%value.rec "grayscale( <number-percentage> )"]
and function_hsl = [%value.rec
  " hsl( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> ]? )
  | hsl( <hue> ',' <extended-percentage> ',' <extended-percentage> [ ',' <alpha-value> ]? )"
]
and function_hsla = [%value.rec
  " hsla( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> ]? )
  | hsla( <hue> ',' <extended-percentage> ',' <extended-percentage> ',' [ <alpha-value> ]? )"
]
and function_hue_rotate = [%value.rec "hue-rotate( <extended-angle> )"]
and function_image = [%value.rec
  "image( [ <image-tags> ]? [ <image-src> ]? ',' [ <color> ]? )"
]
and function_image_set = [%value.rec "image-set( [ <image-set-option> ]# )"]
and function_inset = [%value.rec
  "inset( [ <extended-length> | <extended-percentage> ]{1,4} [ 'round' <'border-radius'> ]? )"
]
and function_invert = [%value.rec "invert( <number-percentage> )"]
and function_leader = [%value.rec "leader( <leader-type> )"]
and function_linear_gradient = [%value.rec
  "linear-gradient( [ [<extended-angle> ','] | ['to' <side-or-corner> ','] ]? <color-stop-list> )"
]
/* and function_linear_gradient = [%value.rec "linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? ',' <color-stop-list> )"] */
and function_matrix = [%value.rec "matrix( [ <number> ]#{6} )"]
and function_matrix3d = [%value.rec "matrix3d( [ <number> ]#{16} )"]
and function_max = [%value.rec "max( [ <calc-sum> ]# )"]
and function_min = [%value.rec "min( [ <calc-sum> ]# )"]
and function_minmax = [%value.rec
  "minmax( [ <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'auto' ] ',' [ <extended-length> | <extended-percentage> | <flex-value> | 'min-content' | 'max-content' | 'auto' ] )"
]
and function_opacity = [%value.rec "opacity( <number-percentage> )"]
and function_paint = [%value.rec
  "paint( <ident> ',' [ <declaration-value> ]? )"
]
and function_path = [%value.rec "path( <string> )"]
and function_perspective = [%value.rec "perspective( <property-perspective> )"]
and function_polygon = [%value.rec
  "polygon( [ <fill-rule> ',' ]? [ <length-percentage> <length-percentage> ]# )"
]
and function_radial_gradient = [%value.rec
  "radial-gradient( <ending-shape>? <radial-size>? ['at' <position> ]? ','? <color-stop-list> )"
]
and function_repeating_linear_gradient = [%value.rec
  "repeating-linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? ',' <color-stop-list> )"
]
and function_repeating_radial_gradient = [%value.rec
  "repeating-radial-gradient( [ <ending-shape> || <size> ]? [ 'at' <position> ]? ',' <color-stop-list> )"
]
and function_rgb = [%value.rec
  "
    rgb( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? )
  | rgb( [ <number> ]{3} [ '/' <alpha-value> ]? )
  | rgb( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? )
  | rgb( [ <number> ]#{3} [ ',' <alpha-value> ]? )
"
]
and function_rgba = [%value.rec
  "
    rgba( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? )
  | rgba( [ <number> ]{3} [ '/' <alpha-value> ]? )
  | rgba( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? )
  | rgba( [ <number> ]#{3} [ ',' <alpha-value> ]? )
"
]
and function_rotate = [%value.rec "rotate( <extended-angle> | <zero> )"]
and function_rotate3d = [%value.rec
  "rotate3d( <number> ',' <number> ',' <number> ',' [ <extended-angle> | <zero> ] )"
]
and function_rotateX = [%value.rec "rotateX( <extended-angle> | <zero> )"]
and function_rotateY = [%value.rec "rotateY( <extended-angle> | <zero> )"]
and function_rotateZ = [%value.rec "rotateZ( <extended-angle> | <zero> )"]
and function_saturate = [%value.rec "saturate( <number-percentage> )"]
and function_scale = [%value.rec "scale( <number> [',' [ <number> ]]? )"]
and function_scale3d = [%value.rec
  "scale3d( <number> ',' <number> ',' <number> )"
]
and function_scaleX = [%value.rec "scaleX( <number> )"]
and function_scaleY = [%value.rec "scaleY( <number> )"]
and function_scaleZ = [%value.rec "scaleZ( <number> )"]
and function_sepia = [%value.rec "sepia( <number-percentage> )"]
and function_skew = [%value.rec
  "skew( [ <extended-angle> | <zero> ] [',' [ <extended-angle> | <zero> ]]? )"
]
and function_skewX = [%value.rec "skewX( <extended-angle> | <zero> )"]
and function_skewY = [%value.rec "skewY( <extended-angle> | <zero> )"]
and function_symbols = [%value.rec
  "symbols( [ <symbols-type> ]? [ <string> | <image> ]+ )"
]
and function_target_counter = [%value.rec
  "target-counter( [ <string> | <url> ] ',' <custom-ident> ',' [ <counter-style> ]? )"
]
and function_target_counters = [%value.rec
  "target-counters( [ <string> | <url> ] ',' <custom-ident> ',' <string> ',' [ <counter-style> ]? )"
]
and function_target_text = [%value.rec
  "target-text( [ <string> | <url> ] ',' [ 'content' | 'before' | 'after' | 'first-letter' ]? )"
]
and function_translate = [%value.rec
  "translate( [<extended-length> | <extended-percentage>] [',' [ <extended-length> | <extended-percentage> ]]? )"
]
and function_translate3d = [%value.rec
  "translate3d( [<extended-length> | <extended-percentage>] ',' [<extended-length> | <extended-percentage>] ',' <extended-length> )"
]
and function_translateX = [%value.rec
  "translateX( [<extended-length> | <extended-percentage>] )"
]
and function_translateY = [%value.rec
  "translateY( [<extended-length> | <extended-percentage>] )"
]
and function_translateZ = [%value.rec "translateZ( <extended-length> )"]
/* and function_var = [%value.rec "var( <ident> ',' [ <declaration-value> ]? )"] */
and function_var = [%value.rec "var( <ident> )"]
and gender = [%value.rec "'male' | 'female' | 'neutral'"]
and general_enclosed = [%value.rec
  "<function-token> <any-value> ')' | '(' <ident> <any-value> ')'"
]
and generic_family = [%value.rec
  "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace' | '-apple-system'"
]
and generic_name = [%value.rec
  "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace'"
]
and generic_voice = [%value.rec "[ <age> ]? <gender> [ <integer> ]?"]
and geometry_box = [%value.rec
  "<shape-box> | 'fill-box' | 'stroke-box' | 'view-box'"
]
and gradient = [%value.rec
  "<linear-gradient()> | <repeating-linear-gradient()> | <radial-gradient()> | <repeating-radial-gradient()> | <conic-gradient()> | <-legacy-gradient>"
]
and grid_line = [%value.rec
  "<custom-ident-without-span-or-auto> | <integer> && [ <custom-ident-without-span-or-auto> ]? | 'span' && [ <integer> || <custom-ident-without-span-or-auto> ] | 'auto' | <interpolation>"
]
and historical_lig_values = [%value.rec
  "'historical-ligatures' | 'no-historical-ligatures'"
]
and hue = [%value.rec "<number> | <extended-angle>"]
and id_selector = [%value.rec "<hash-token>"]
and image = [%value.rec
  "<url> | <image()> | <image-set()> | <element()> | <paint()> | <cross-fade()> | <gradient> | <interpolation>"
]
and image_set_option = [%value.rec "[ <image> | <string> ] <resolution>"]
and image_src = [%value.rec "<url> | <string>"]
and image_tags = [%value.rec "'ltr' | 'rtl'"]
and inflexible_breadth = [%value.rec
  "<extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'auto'"
]
and keyframe_block = [%value.rec
  "[ <keyframe-selector> ]# '{' <declaration-list> '}'"
]
and keyframe_block_list = [%value.rec "[ <keyframe-block> ]+"]
and keyframe_selector = [%value.rec "'from' | 'to' | <extended-percentage>"]
and keyframes_name = [%value.rec "<custom-ident> | <string>"]
and leader_type = [%value.rec "'dotted' | 'solid' | 'space' | <string>"]
and left = [%value.rec "<extended-length> | 'auto'"]
and line_name_list = [%value.rec "[ <line-names> | <name-repeat> ]+"]
and line_style = [%value.rec
  "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | 'ridge' | 'inset' | 'outset'"
]
and line_width = [%value.rec "<extended-length> | 'thin' | 'medium' | 'thick'"]
and linear_color_hint = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and linear_color_stop = [%value.rec "<color> <length-percentage>?"]
and mask_image = [%value.rec "[ <mask-reference> ]#"]
and mask_layer = [%value.rec
  "<mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || <geometry-box> || [ <geometry-box> | 'no-clip' ] || <compositing-operator> || <masking-mode>"
]
and mask_position = [%value.rec
  "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' ] [ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' ]?"
]
and mask_reference = [%value.rec "'none' | <image> | <mask-source>"]
and mask_source = [%value.rec "<url>"]
and masking_mode = [%value.rec "'alpha' | 'luminance' | 'match-source'"]
and mf_comparison = [%value.rec "<mf-lt> | <mf-gt> | <mf-eq>"]
and mf_eq = [%value.rec "'='"]
and mf_gt = [%value.rec "'>=' | '>'"]
and mf_lt = [%value.rec "'<=' | '<'"]
and mf_value = [%value.rec
  "<number> | <dimension> | <ident> | <ratio> | <interpolation>"
]
and mf_name = [%value.rec "<ident>"]
and mf_range = [%value.rec
  "<mf-name> <mf-comparison> <mf-value> | <mf-value> <mf-comparison> <mf-name> | <mf-value> <mf-lt> <mf-name> <mf-lt> <mf-value> | <mf-value> <mf-gt> <mf-name> <mf-gt> <mf-value>"
]
and mf_boolean = [%value.rec "<mf-name>"]
and mf_plain = [%value.rec "<mf-name> ':' <mf-value>"]
and media_feature = [%value.rec
  "'(' [ <mf-plain> | <mf-boolean> | <mf-range> ] ')'"
]
and media_in_parens = [%value.rec
  "'(' <media-condition> ')' | <media-feature> | <interpolation>"
]
and media_or = [%value.rec "'or' <media-in-parens>"]
and media_and = [%value.rec "'and' <media-in-parens>"]
and media_not = [%value.rec "'not' <media-in-parens>"]
and media_condition_without_or = [%value.rec
  "<media-not> | <media-in-parens> <media-and>*"
]
and media_condition = [%value.rec
  "<media-not> | <media-in-parens> [ <media-and>* | <media-or>* ]"
]
and media_query = [%value.rec
  "<media-condition> | [ 'not' | 'only' ]? <media-type> [ 'and' <media-condition-without-or> ]?"
]
and media_query_list = [%value.rec "[ <media-query> ]# | <interpolation>"]
and container_condition_list = [%value.rec "<container-condition>#"]
and container_condition = [%value.rec
  "[ <container-name> ]? <container-query>"
]
and container_query = [%value.rec
  "'not' <query-in-parens> | <query-in-parens> [ [ 'and' <query-in-parens> ]* | [ 'or' <query-in-parens> ]* ]"
]
and query_in_parens = [%value.rec
  "'(' <container-query> ')' | '(' <size-feature> ')' | style( <style-query> )"
]
and size_feature = [%value.rec "<mf-plain> | <mf-boolean> | <mf-range>"]
and style_query = [%value.rec
  "'not' <style-in-parens> | <style-in-parens> [ [ and <style-in-parens> ]* | [ or <style-in-parens> ]* ] | <style-feature>"
]
and style_feature = [%value.rec "<dashed_ident> ':' <mf-value>"]
and style_in_parens = [%value.rec
  "'(' <style-query> ')' | '(' <style-feature> ')'"
]
and name_repeat = [%value.rec
  "repeat( [ <positive-integer> | 'auto-fill' ] ',' [ <line-names> ]+ )"
]
and named_color = [%value.rec
  "'transparent' | 'aliceblue' | 'antiquewhite' | 'aqua' | 'aquamarine' | 'azure' | 'beige' | 'bisque' | 'black' | 'blanchedalmond' | 'blue' | 'blueviolet' | 'brown' | 'burlywood' | 'cadetblue' | 'chartreuse' | 'chocolate' | 'coral' | 'cornflowerblue' | 'cornsilk' | 'crimson' | 'cyan' | 'darkblue' | 'darkcyan' | 'darkgoldenrod' | 'darkgray' | 'darkgreen' | 'darkgrey' | 'darkkhaki' | 'darkmagenta' | 'darkolivegreen' | 'darkorange' | 'darkorchid' | 'darkred' | 'darksalmon' | 'darkseagreen' | 'darkslateblue' | 'darkslategray' | 'darkslategrey' | 'darkturquoise' | 'darkviolet' | 'deeppink' | 'deepskyblue' | 'dimgray' | 'dimgrey' | 'dodgerblue' | 'firebrick' | 'floralwhite' | 'forestgreen' | 'fuchsia' | 'gainsboro' | 'ghostwhite' | 'gold' | 'goldenrod' | 'gray' | 'green' | 'greenyellow' | 'grey' | 'honeydew' | 'hotpink' | 'indianred' | 'indigo' | 'ivory' | 'khaki' | 'lavender' | 'lavenderblush' | 'lawngreen' | 'lemonchiffon' | 'lightblue' | 'lightcoral' | 'lightcyan' | 'lightgoldenrodyellow' | 'lightgray' | 'lightgreen' | 'lightgrey' | 'lightpink' | 'lightsalmon' | 'lightseagreen' | 'lightskyblue' | 'lightslategray' | 'lightslategrey' | 'lightsteelblue' | 'lightyellow' | 'lime' | 'limegreen' | 'linen' | 'magenta' | 'maroon' | 'mediumaquamarine' | 'mediumblue' | 'mediumorchid' | 'mediumpurple' | 'mediumseagreen' | 'mediumslateblue' | 'mediumspringgreen' | 'mediumturquoise' | 'mediumvioletred' | 'midnightblue' | 'mintcream' | 'mistyrose' | 'moccasin' | 'navajowhite' | 'navy' | 'oldlace' | 'olive' | 'olivedrab' | 'orange' | 'orangered' | 'orchid' | 'palegoldenrod' | 'palegreen' | 'paleturquoise' | 'palevioletred' | 'papayawhip' | 'peachpuff' | 'peru' | 'pink' | 'plum' | 'powderblue' | 'purple' | 'rebeccapurple' | 'red' | 'rosybrown' | 'royalblue' | 'saddlebrown' | 'salmon' | 'sandybrown' | 'seagreen' | 'seashell' | 'sienna' | 'silver' | 'skyblue' | 'slateblue' | 'slategray' | 'slategrey' | 'snow' | 'springgreen' | 'steelblue' | 'tan' | 'teal' | 'thistle' | 'tomato' | 'turquoise' | 'violet' | 'wheat' | 'white' | 'whitesmoke' | 'yellow' | 'yellowgreen' | <-non-standard-color>"
]
and namespace_prefix = [%value.rec "<ident>"]
and ns_prefix = [%value.rec "[ <ident-token> | '*' ]? '|'"]
and nth = [%value.rec "<an-plus-b> | 'even' | 'odd'"]
and number_one_or_greater = [%value.rec "<number>"]
and number_percentage = [%value.rec "<number> | <extended-percentage>"]
and number_zero_one = [%value.rec "<number>"]
and numeric_figure_values = [%value.rec "'lining-nums' | 'oldstyle-nums'"]
and numeric_fraction_values = [%value.rec
  "'diagonal-fractions' | 'stacked-fractions'"
]
and numeric_spacing_values = [%value.rec
  "'proportional-nums' | 'tabular-nums'"
]
and outline_radius = [%value.rec "<extended-length> | <extended-percentage>"]
and overflow_position = [%value.rec "'unsafe' | 'safe'"]
and page_body = [%value.rec
  "[ <declaration> ]? [ ';' <page-body> ]? | <page-margin-box> <page-body>"
]
and page_margin_box = [%value.rec
  "<page-margin-box-type> '{' <declaration-list> '}'"
]
and page_margin_box_type = [%value.rec
  "'@top-left-corner' | '@top-left' | '@top-center' | '@top-right' | '@top-right-corner' | '@bottom-left-corner' | '@bottom-left' | '@bottom-center' | '@bottom-right' | '@bottom-right-corner' | '@left-top' | '@left-middle' | '@left-bottom' | '@right-top' | '@right-middle' | '@right-bottom'"
]
and page_selector = [%value.rec
  "[ <pseudo-page> ]+ | <ident> [ <pseudo-page> ]*"
]
and page_selector_list = [%value.rec "[ [ <page-selector> ]# ]?"]
and paint = [%value.rec
  "'none' | <color> | <url> [ 'none' | <color> ]? | 'context-fill' | 'context-stroke' | <interpolation>"
]
and position = [%value.rec
  "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ]
  | [ 'left' | 'center' | 'right' ] && [ 'top' | 'center' | 'bottom' ]
  | [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | 'bottom' | <length-percentage> ]
  | [ [ 'left' | 'right' ] <length-percentage> ] && [ [ 'top' | 'bottom' ] <length-percentage> ]"
]
and positive_integer = [%value.rec "<integer>"]
and property__moz_appearance = [%value.rec
  "'none' | 'button' | 'button-arrow-down' | 'button-arrow-next' | 'button-arrow-previous' | 'button-arrow-up' | 'button-bevel' | 'button-focus' | 'caret' | 'checkbox' | 'checkbox-container' | 'checkbox-label' | 'checkmenuitem' | 'dualbutton' | 'groupbox' | 'listbox' | 'listitem' | 'menuarrow' | 'menubar' | 'menucheckbox' | 'menuimage' | 'menuitem' | 'menuitemtext' | 'menulist' | 'menulist-button' | 'menulist-text' | 'menulist-textfield' | 'menupopup' | 'menuradio' | 'menuseparator' | 'meterbar' | 'meterchunk' | 'progressbar' | 'progressbar-vertical' | 'progresschunk' | 'progresschunk-vertical' | 'radio' | 'radio-container' | 'radio-label' | 'radiomenuitem' | 'range' | 'range-thumb' | 'resizer' | 'resizerpanel' | 'scale-horizontal' | 'scalethumbend' | 'scalethumb-horizontal' | 'scalethumbstart' | 'scalethumbtick' | 'scalethumb-vertical' | 'scale-vertical' | 'scrollbarbutton-down' | 'scrollbarbutton-left' | 'scrollbarbutton-right' | 'scrollbarbutton-up' | 'scrollbarthumb-horizontal' | 'scrollbarthumb-vertical' | 'scrollbartrack-horizontal' | 'scrollbartrack-vertical' | 'searchfield' | 'separator' | 'sheet' | 'spinner' | 'spinner-downbutton' | 'spinner-textfield' | 'spinner-upbutton' | 'splitter' | 'statusbar' | 'statusbarpanel' | 'tab' | 'tabpanel' | 'tabpanels' | 'tab-scroll-arrow-back' | 'tab-scroll-arrow-forward' | 'textfield' | 'textfield-multiline' | 'toolbar' | 'toolbarbutton' | 'toolbarbutton-dropdown' | 'toolbargripper' | 'toolbox' | 'tooltip' | 'treeheader' | 'treeheadercell' | 'treeheadersortarrow' | 'treeitem' | 'treeline' | 'treetwisty' | 'treetwistyopen' | 'treeview' | '-moz-mac-unified-toolbar' | '-moz-win-borderless-glass' | '-moz-win-browsertabbar-toolbox' | '-moz-win-communicationstext' | '-moz-win-communications-toolbox' | '-moz-win-exclude-glass' | '-moz-win-glass' | '-moz-win-mediatext' | '-moz-win-media-toolbox' | '-moz-window-button-box' | '-moz-window-button-box-maximized' | '-moz-window-button-close' | '-moz-window-button-maximize' | '-moz-window-button-minimize' | '-moz-window-button-restore' | '-moz-window-frame-bottom' | '-moz-window-frame-left' | '-moz-window-frame-right' | '-moz-window-titlebar' | '-moz-window-titlebar-maximized'"
]
and property__moz_background_clip = [%value.rec "'padding' | 'border'"]
and property__moz_binding = [%value.rec "<url> | 'none'"]
and property__moz_border_bottom_colors = [%value.rec "[ <color> ]+ | 'none'"]
and property__moz_border_left_colors = [%value.rec "[ <color> ]+ | 'none'"]
and property__moz_border_radius_bottomleft = [%value.rec
  "<'border-bottom-left-radius'>"
]
and property__moz_border_radius_bottomright = [%value.rec
  "<'border-bottom-right-radius'>"
]
and property__moz_border_radius_topleft = [%value.rec
  "<'border-top-left-radius'>"
]
and property__moz_border_radius_topright = [%value.rec
  "<'border-bottom-right-radius'>"
]
/* TODO: Remove interpolation without <> */
and property__moz_border_right_colors = [%value.rec
  "[ <color> ]+ | 'none' | interpolation"
]
/* TODO: Remove interpolation without <> */
and property__moz_border_top_colors = [%value.rec
  "[ <color> ]+ | 'none' | interpolation"
]
and property__moz_context_properties = [%value.rec
  "'none' | [ 'fill' | 'fill-opacity' | 'stroke' | 'stroke-opacity' ]#"
]
and property__moz_control_character_visibility = [%value.rec
  "'visible' | 'hidden'"
]
and property__moz_float_edge = [%value.rec
  "'border-box' | 'content-box' | 'margin-box' | 'padding-box'"
]
and property__moz_force_broken_image_icon = [%value.rec "<integer>"]
and property__moz_image_region = [%value.rec "<shape> | 'auto'"]
and property__moz_orient = [%value.rec
  "'inline' | 'block' | 'horizontal' | 'vertical'"
]
and property__moz_osx_font_smoothing = [%value.rec "'auto' | 'grayscale'"]
and property__moz_outline_radius = [%value.rec
  "[ <outline-radius> ]{1,4} [ '/' [ <outline-radius> ]{1,4} ]?"
]
and property__moz_outline_radius_bottomleft = [%value.rec "<outline-radius>"]
and property__moz_outline_radius_bottomright = [%value.rec "<outline-radius>"]
and property__moz_outline_radius_topleft = [%value.rec "<outline-radius>"]
and property__moz_outline_radius_topright = [%value.rec "<outline-radius>"]
and property__moz_stack_sizing = [%value.rec "'ignore' | 'stretch-to-fit'"]
and property__moz_text_blink = [%value.rec "'none' | 'blink'"]
and property__moz_user_focus = [%value.rec
  "'ignore' | 'normal' | 'select-after' | 'select-before' | 'select-menu' | 'select-same' | 'select-all' | 'none'"
]
and property__moz_user_input = [%value.rec
  "'auto' | 'none' | 'enabled' | 'disabled'"
]
and property__moz_user_modify = [%value.rec
  "'read-only' | 'read-write' | 'write-only'"
]
and property__moz_user_select = [%value.rec
  "'none' | 'text' | 'all' | '-moz-none'"
]
and property__moz_window_dragging = [%value.rec "'drag' | 'no-drag'"]
and property__moz_window_shadow = [%value.rec
  "'default' | 'menu' | 'tooltip' | 'sheet' | 'none'"
]
and property__webkit_appearance = [%value.rec
  "'none' | 'button' | 'button-bevel' | 'caps-lock-indicator' | 'caret' | 'checkbox' | 'default-button' | 'listbox' | 'listitem' | 'media-fullscreen-button' | 'media-mute-button' | 'media-play-button' | 'media-seek-back-button' | 'media-seek-forward-button' | 'media-slider' | 'media-sliderthumb' | 'menulist' | 'menulist-button' | 'menulist-text' | 'menulist-textfield' | 'push-button' | 'radio' | 'scrollbarbutton-down' | 'scrollbarbutton-left' | 'scrollbarbutton-right' | 'scrollbarbutton-up' | 'scrollbargripper-horizontal' | 'scrollbargripper-vertical' | 'scrollbarthumb-horizontal' | 'scrollbarthumb-vertical' | 'scrollbartrack-horizontal' | 'scrollbartrack-vertical' | 'searchfield' | 'searchfield-cancel-button' | 'searchfield-decoration' | 'searchfield-results-button' | 'searchfield-results-decoration' | 'slider-horizontal' | 'slider-vertical' | 'sliderthumb-horizontal' | 'sliderthumb-vertical' | 'square-button' | 'textarea' | 'textfield'"
]
and property__webkit_background_clip = [%value.rec
  "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#"
]
and property__webkit_border_before = [%value.rec
  "<'border-width'> || <'border-style'> || <'color'>"
]
and property__webkit_border_before_color = [%value.rec "<'color'>"]
and property__webkit_border_before_style = [%value.rec "<'border-style'>"]
and property__webkit_border_before_width = [%value.rec "<'border-width'>"]
and property__webkit_box_reflect = [%value.rec
  "[ 'above' | 'below' | 'right' | 'left' ]? [ <extended-length> ]? [ <image> ]?"
]
and property__webkit_column_break_after = [%value.rec
  "'always' | 'auto' | 'avoid'"
]
and property__webkit_column_break_before = [%value.rec
  "'always' | 'auto' | 'avoid'"
]
and property__webkit_column_break_inside = [%value.rec
  "'always' | 'auto' | 'avoid'"
]
and property__webkit_font_smoothing = [%value.rec
  "'auto' | 'none' | 'antialiased' | 'subpixel-antialiased'"
]
and property__webkit_line_clamp = [%value.rec "'none' | <integer>"]
and property__webkit_mask = [%value.rec
  "[ <mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || [ <box> | 'border' | 'padding' | 'content' | 'text' ] || [ <box> | 'border' | 'padding' | 'content' ] ]#"
]
and property__webkit_mask_attachment = [%value.rec "[ <attachment> ]#"]
and property__webkit_mask_box_image = [%value.rec
  "[ <url> | <gradient> | 'none' ] [ [ <extended-length> | <extended-percentage> ]{4} [ <-webkit-mask-box-repeat> ]{2} ]?"
]
and property__webkit_mask_clip = [%value.rec
  "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#"
]
and property__webkit_mask_composite = [%value.rec "[ <composite-style> ]#"]
and property__webkit_mask_image = [%value.rec "[ <mask-reference> ]#"]
and property__webkit_mask_origin = [%value.rec
  "[ <box> | 'border' | 'padding' | 'content' ]#"
]
and property__webkit_mask_position = [%value.rec "[ <position> ]#"]
and property__webkit_mask_position_x = [%value.rec
  "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' ]#"
]
and property__webkit_mask_position_y = [%value.rec
  "[ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' ]#"
]
and property__webkit_mask_repeat = [%value.rec "[ <repeat-style> ]#"]
and property__webkit_mask_repeat_x = [%value.rec
  "'repeat' | 'no-repeat' | 'space' | 'round'"
]
and property__webkit_mask_repeat_y = [%value.rec
  "'repeat' | 'no-repeat' | 'space' | 'round'"
]
and property__webkit_mask_size = [%value.rec "[ <bg-size> ]#"]
and property__webkit_overflow_scrolling = [%value.rec "'auto' | 'touch'"]
and property__webkit_print_color_adjust = [%value.rec "'economy' | 'exact'"]
and property__webkit_tap_highlight_color = [%value.rec "<color>"]
and property__webkit_text_fill_color = [%value.rec "<color>"]
and property__webkit_text_security = [%value.rec
  "'none' | 'circle' | 'disc' | 'square'"
]
and property__webkit_text_stroke = [%value.rec "<extended-length> || <color>"]
and property__webkit_text_stroke_color = [%value.rec "<color>"]
and property__webkit_text_stroke_width = [%value.rec "<extended-length>"]
and property__webkit_touch_callout = [%value.rec "'default' | 'none'"]
and property__webkit_user_drag = [%value.rec "'none' | 'element' | 'auto'"]
and property__webkit_user_modify = [%value.rec
  "'read-only' | 'read-write' | 'read-write-plaintext-only'"
]
and property__webkit_user_select = [%value.rec
  "'auto' | 'none' | 'text' | 'all'"
]
and property_align_content = [%value.rec
  "'normal' | <baseline-position> | <content-distribution> | [ <overflow-position> ]? <content-position>"
]
and property_align_items = [%value.rec
  "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? <self-position> | <interpolation>"
]
and property_align_self = [%value.rec
  "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? <self-position> | <interpolation>"
]
and property_alignment_baseline = [%value.rec
  "'auto' | 'baseline' | 'before-edge' | 'text-before-edge' | 'middle' | 'central' | 'after-edge' | 'text-after-edge' | 'ideographic' | 'alphabetic' | 'hanging' | 'mathematical'"
]
and property_all = [%value.rec "'initial' | 'inherit' | 'unset' | 'revert'"]
and property_animation = [%value.rec
  "[ <single-animation> | <single-animation-no-interp> ]#"
]
and property_animation_delay = [%value.rec "[ <extended-time> ]#"]
and property_animation_direction = [%value.rec
  "[ <single-animation-direction> ]#"
]
and property_animation_duration = [%value.rec "[ <extended-time> ]#"]
and property_animation_fill_mode = [%value.rec
  "[ <single-animation-fill-mode> ]#"
]
and property_animation_iteration_count = [%value.rec
  "[ <single-animation-iteration-count> ]#"
]
and property_animation_name = [%value.rec
  "[ <keyframes-name> | 'none' | <interpolation> ]#"
]
and property_animation_play_state = [%value.rec
  "[ <single-animation-play-state> ]#"
]
and property_animation_timing_function = [%value.rec "[ <timing-function> ]#"]
and property_appearance = [%value.rec
  "'none' | 'auto' | 'button' | 'textfield' | 'menulist-button' | <compat-auto>"
]
and property_aspect_ratio = [%value.rec "'auto' | <ratio>"]
and property_azimuth = [%value.rec
  "<extended-angle> | [ 'left-side' | 'far-left' | 'left' | 'center-left' | 'center' | 'center-right' | 'right' | 'far-right' | 'right-side' ] || 'behind' | 'leftwards' | 'rightwards'"
]
and property_backdrop_filter = [%value.rec
  "'none' | <interpolation> | <filter-function-list>"
]
and property_backface_visibility = [%value.rec "'visible' | 'hidden'"]
and property_background = [%value.rec "[ <bg-layer> ',' ]* <final-bg-layer>"]
and property_background_attachment = [%value.rec "[ <attachment> ]#"]
and property_background_blend_mode = [%value.rec "[ <blend-mode> ]#"]
and property_background_clip = [%value.rec
  "[ <box> | 'text' | 'border-area' ]#"
]
and property_background_color = [%value.rec "<color>"]
and property_background_image = [%value.rec "[ <bg-image> ]#"]
and property_background_origin = [%value.rec "[ <box> ]#"]
and property_background_position = [%value.rec "[ <bg-position> ]#"]
and property_background_position_x = [%value.rec
  "[ 'center' | [ 'left' | 'right' | 'x-start' | 'x-end' ]? [ <extended-length> | <extended-percentage> ]? ]#"
]
and property_background_position_y = [%value.rec
  "[ 'center' | [ 'top' | 'bottom' | 'y-start' | 'y-end' ]? [ <extended-length> | <extended-percentage> ]? ]#"
]
and property_background_repeat = [%value.rec "[ <repeat-style> ]#"]
and property_background_size = [%value.rec "[ <bg-size> ]#"]
and property_baseline_shift = [%value.rec
  "'baseline' | 'sub' | 'super' | <svg-length>"
]
and property_behavior = [%value.rec "[ <url> ]+"]
and property_block_overflow = [%value.rec "'clip' | 'ellipsis' | <string>"]
and property_block_size = [%value.rec "<'width'>"]
and property_border = [%value.rec
  "'none' | [ <line-width> | <interpolation> ] | [ <line-width> | <interpolation> ] [ <line-style> | <interpolation> ] | [ <line-width> | <interpolation> ] [ <line-style> | <interpolation> ] [ <color> | <interpolation> ]"
]
and property_border_block = [%value.rec "<'border'>"]
and property_border_block_color = [%value.rec "[ <'border-top-color'> ]{1,2}"]
and property_border_block_end = [%value.rec "<'border'>"]
and property_border_block_end_color = [%value.rec "<'border-top-color'>"]
and property_border_block_end_style = [%value.rec "<'border-top-style'>"]
and property_border_block_end_width = [%value.rec "<'border-top-width'>"]
and property_border_block_start = [%value.rec "<'border'>"]
and property_border_block_start_color = [%value.rec "<'border-top-color'>"]
and property_border_block_start_style = [%value.rec "<'border-top-style'>"]
and property_border_block_start_width = [%value.rec "<'border-top-width'>"]
and property_border_block_style = [%value.rec "<'border-top-style'>"]
and property_border_block_width = [%value.rec "<'border-top-width'>"]
and property_border_bottom = [%value.rec "<'border'>"]
and property_border_bottom_color = [%value.rec "<'border-top-color'>"]
and property_border_bottom_left_radius = [%value.rec
  "[ <extended-length> | <extended-percentage> ]{1,2}"
]
and property_border_bottom_right_radius = [%value.rec
  "[ <extended-length> | <extended-percentage> ]{1,2}"
]
and property_border_bottom_style = [%value.rec "<line-style>"]
and property_border_bottom_width = [%value.rec "<line-width>"]
and property_border_collapse = [%value.rec "'collapse' | 'separate'"]
and property_border_color = [%value.rec "[ <color> ]{1,4}"]
and property_border_end_end_radius = [%value.rec
  "[ <extended-length> | <extended-percentage> ]{1,2}"
]
and property_border_end_start_radius = [%value.rec
  "[ <extended-length> | <extended-percentage> ]{1,2}"
]
and property_border_image = [%value.rec
  "<'border-image-source'> || <'border-image-slice'> [ '/' <'border-image-width'> | '/' [ <'border-image-width'> ]? '/' <'border-image-outset'> ]? || <'border-image-repeat'>"
]
and property_border_image_outset = [%value.rec
  "[ <extended-length> | <number> ]{1,4}"
]
and property_border_image_repeat = [%value.rec
  "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}"
]
and property_border_image_slice = [%value.rec
  "[ <number-percentage> ]{1,4} && [ 'fill' ]?"
]
and property_border_image_source = [%value.rec "'none' | <image>"]
and property_border_image_width = [%value.rec
  "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}"
]
and property_border_inline = [%value.rec "<'border'>"]
and property_border_inline_color = [%value.rec "[ <'border-top-color'> ]{1,2}"]
and property_border_inline_end = [%value.rec "<'border'>"]
and property_border_inline_end_color = [%value.rec "<'border-top-color'>"]
and property_border_inline_end_style = [%value.rec "<'border-top-style'>"]
and property_border_inline_end_width = [%value.rec "<'border-top-width'>"]
and property_border_inline_start = [%value.rec "<'border'>"]
and property_border_inline_start_color = [%value.rec "<'border-top-color'>"]
and property_border_inline_start_style = [%value.rec "<'border-top-style'>"]
and property_border_inline_start_width = [%value.rec "<'border-top-width'>"]
and property_border_inline_style = [%value.rec "<'border-top-style'>"]
and property_border_inline_width = [%value.rec "<'border-top-width'>"]
and property_border_left = [%value.rec "<'border'>"]
and property_border_left_color = [%value.rec "<color>"]
and property_border_left_style = [%value.rec "<line-style>"]
and property_border_left_width = [%value.rec "<line-width>"]
/* border-radius isn't supported with the entire spec in bs-css: `"[ <extended-length> | <extended-percentage> ]{1,4} [ '/' [ <extended-length> | <extended-percentage> ]{1,4} ]?"` */
and property_border_radius = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and property_border_right = [%value.rec "<'border'>"]
and property_border_right_color = [%value.rec "<color>"]
and property_border_right_style = [%value.rec "<line-style>"]
and property_border_right_width = [%value.rec "<line-width>"]
and property_border_spacing = [%value.rec
  "<extended-length> [ <extended-length> ]?"
]
and property_border_start_end_radius = [%value.rec
  "[ <extended-length> | <extended-percentage> ]{1,2}"
]
and property_border_start_start_radius = [%value.rec
  "[ <extended-length> | <extended-percentage> ]{1,2}"
]
/* bs-css doesn't support list of styles, the original spec is: `[ <line-style> ]{1,4}` */
and property_border_style = [%value.rec "<line-style>"]
and property_border_top = [%value.rec "<'border'>"]
and property_border_top_color = [%value.rec "<color>"]
and property_border_top_left_radius = [%value.rec
  "[ <extended-length> | <extended-percentage> ]{1,2}"
]
and property_border_top_right_radius = [%value.rec
  "[ <extended-length> | <extended-percentage> ]{1,2}"
]
and property_border_top_style = [%value.rec "<line-style>"]
and property_border_top_width = [%value.rec "<line-width>"]
and property_border_width = [%value.rec "[ <line-width> ]{1,4}"]
and property_bottom = [%value.rec
  "<extended-length> | <extended-percentage> | 'auto'"
]
and property_box_align = [%value.rec
  "'start' | 'center' | 'end' | 'baseline' | 'stretch'"
]
and property_box_decoration_break = [%value.rec "'slice' | 'clone'"]
and property_box_direction = [%value.rec "'normal' | 'reverse' | 'inherit'"]
and property_box_flex = [%value.rec "<number>"]
and property_box_flex_group = [%value.rec "<integer>"]
and property_box_lines = [%value.rec "'single' | 'multiple'"]
and property_box_ordinal_group = [%value.rec "<integer>"]
and property_box_orient = [%value.rec
  "'horizontal' | 'vertical' | 'inline-axis' | 'block-axis' | 'inherit'"
]
and property_box_pack = [%value.rec "'start' | 'center' | 'end' | 'justify'"]
and property_box_shadow = [%value.rec
  "'none' | <interpolation> | [ <shadow> ]#"
]
and property_box_sizing = [%value.rec "'content-box' | 'border-box'"]
and property_break_after = [%value.rec
  "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | 'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' | 'region'"
]
and property_break_before = [%value.rec
  "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | 'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' | 'region'"
]
and property_break_inside = [%value.rec
  "'auto' | 'avoid' | 'avoid-page' | 'avoid-column' | 'avoid-region'"
]
and property_caption_side = [%value.rec
  "'top' | 'bottom' | 'block-start' | 'block-end' | 'inline-start' | 'inline-end'"
]
and property_caret_color = [%value.rec "'auto' | <color>"]
and property_clear = [%value.rec
  "'none' | 'left' | 'right' | 'both' | 'inline-start' | 'inline-end'"
]
and property_clip = [%value.rec "<shape> | 'auto'"]
and property_clip_path = [%value.rec
  "<clip-source> | <basic-shape> || <geometry-box> | 'none'"
]
and property_clip_rule = [%value.rec "'nonzero' | 'evenodd'"]
and property_color = [%value.rec "<color>"]
and property_color_interpolation_filters = [%value.rec
  "'auto' | 'sRGB' | 'linearRGB'"
]
and property_color_interpolation = [%value.rec "'auto' | 'sRGB' | 'linearRGB'"]
and property_color_adjust = [%value.rec "'economy' | 'exact'"]
and property_column_count = [%value.rec "<integer> | 'auto'"]
and property_column_fill = [%value.rec "'auto' | 'balance' | 'balance-all'"]
and property_column_gap = [%value.rec
  "'normal' | <extended-length> | <extended-percentage>"
]
and property_column_rule = [%value.rec
  "<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>"
]
and property_column_rule_color = [%value.rec "<color>"]
and property_column_rule_style = [%value.rec "<'border-style'>"]
and property_column_rule_width = [%value.rec "<'border-width'>"]
and property_column_span = [%value.rec "'none' | 'all'"]
and property_column_width = [%value.rec "<extended-length> | 'auto'"]
and property_columns = [%value.rec "<'column-width'> || <'column-count'>"]
and property_contain = [%value.rec
  "'none' | 'strict' | 'content' | 'size' || 'layout' || 'style' || 'paint'"
]
and property_content = [%value.rec
  "'normal' | 'none' | <string> | <interpolation> | [ <content-replacement> | <content-list> ] [ '/' <string> ]?"
]
and property_content_visibility = [%value.rec "'visible' | 'hidden' | 'auto'"]
and property_counter_increment = [%value.rec
  "[ <custom-ident> [ <integer> ]? ]+ | 'none'"
]
and property_counter_reset = [%value.rec
  "[ <custom-ident> [ <integer> ]? ]+ | 'none'"
]
and property_counter_set = [%value.rec
  "[ <custom-ident> [ <integer> ]? ]+ | 'none'"
]
and property_cue = [%value.rec "<'cue-before'> [ <'cue-after'> ]?"]
and property_cue_after = [%value.rec "<url> [ <decibel> ]? | 'none'"]
and property_cue_before = [%value.rec "<url> [ <decibel> ]? | 'none'"]
/* and property_cursor = [%value.rec
     "[ <url> [ <x> <y> ]? ',' ]* [ 'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | 'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | 'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | 'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | 'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | 'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | 'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' | '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' ] | <interpolation>"
   ] */
/* Removed [ <url> [ <x> <y> ]? ',' ]* */
and property_cursor = [%value.rec
  "'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | 'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | 'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | 'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | 'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | 'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | 'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' | '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' | <interpolation>"
]
and property_direction = [%value.rec "'ltr' | 'rtl'"]
and property_display = [%value.rec
  "'block' | 'contents' | 'flex' | 'flow' | 'flow-root' | 'grid' | 'inline' | 'inline-block' | 'inline-flex' | 'inline-grid' | 'inline-list-item' | 'inline-table' | 'list-item' | 'none' | 'ruby' | 'ruby-base' | 'ruby-base-container' | 'ruby-text' | 'ruby-text-container' | 'run-in' | 'table' | 'table-caption' | 'table-cell' | 'table-column' | 'table-column-group' | 'table-footer-group' | 'table-header-group' | 'table-row' | 'table-row-group' | '-webkit-flex' | '-webkit-inline-flex' | '-webkit-box' | '-webkit-inline-box' | '-moz-inline-stack' | '-moz-box' | '-moz-inline-box'"
]
and property_dominant_baseline = [%value.rec
  "'auto' | 'use-script' | 'no-change' | 'reset-size' | 'ideographic' | 'alphabetic' | 'hanging' | 'mathematical' | 'central' | 'middle' | 'text-after-edge' | 'text-before-edge'"
]
and property_empty_cells = [%value.rec "'show' | 'hide'"]
and property_fill = [%value.rec "<paint>"]
and property_fill_opacity = [%value.rec "<alpha-value>"]
and property_fill_rule = [%value.rec "'nonzero' | 'evenodd'"]
and property_filter = [%value.rec
  "'none' | <interpolation> | <filter-function-list>"
]
and property_flex = [%value.rec
  "'none' | [<'flex-grow'> [ <'flex-shrink'> ]? || <'flex-basis'>] | <interpolation>"
]
and property_flex_basis = [%value.rec
  "'content' | <'width'> | <interpolation>"
]
and property_flex_direction = [%value.rec
  "'row' | 'row-reverse' | 'column' | 'column-reverse'"
]
and property_flex_flow = [%value.rec "<'flex-direction'> || <'flex-wrap'>"]
and property_flex_grow = [%value.rec "<number> | <interpolation>"]
and property_flex_shrink = [%value.rec "<number> | <interpolation>"]
and property_flex_wrap = [%value.rec "'nowrap' | 'wrap' | 'wrap-reverse'"]
and property_float = [%value.rec
  "'left' | 'right' | 'none' | 'inline-start' | 'inline-end'"
]
and property_font = [%value.rec
  "[ <'font-style'> || <font-variant-css21> || <'font-weight'> || <'font-stretch'> ]? <'font-size'> [ '/' <'line-height'> ]? <'font-family'> | 'caption' | 'icon' | 'menu' | 'message-box' | 'small-caption' | 'status-bar'"
]
and font_families = [%value.rec
  "[ <family-name> | <generic-family> | <interpolation> ]#"
]
and property_font_family = [%value.rec "<font_families> | <interpolation>"]
and property_font_feature_settings = [%value.rec
  "'normal' | [ <feature-tag-value> ]#"
]
and property_font_kerning = [%value.rec "'auto' | 'normal' | 'none'"]
and property_font_language_override = [%value.rec "'normal' | <string>"]
and property_font_optical_sizing = [%value.rec "'auto' | 'none'"]
and property_font_palette = [%value.rec "'normal' | 'light' | 'dark'"]
and property_font_size = [%value.rec
  "<absolute-size> | <relative-size> | <extended-length> | <extended-percentage>"
]
and property_font_size_adjust = [%value.rec "'none' | <number>"]
and property_font_smooth = [%value.rec
  "'auto' | 'never' | 'always' | <absolute-size> | <extended-length>"
]
and property_font_stretch = [%value.rec "<font-stretch-absolute>"]
and property_font_style = [%value.rec
  "'normal' | 'italic' | 'oblique' | <interpolation> | [ 'oblique' <extended-angle> ]?"
]
and property_font_synthesis = [%value.rec
  "'none' | [ 'weight' || 'style' || 'small-caps' || 'position' ]"
]
and property_font_synthesis_weight = [%value.rec "'auto' | 'none'"]
and property_font_synthesis_style = [%value.rec "'auto' | 'none'"]
and property_font_synthesis_small_caps = [%value.rec "'auto' | 'none'"]
and property_font_synthesis_position = [%value.rec "'auto' | 'none'"]
and property_font_variant = [%value.rec
  "'normal' | 'none' | 'small-caps' | <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic( <feature-value-name> ) || 'historical-forms' || styleset( [ <feature-value-name> ]# ) || character-variant( [ <feature-value-name> ]# ) || swash( <feature-value-name> ) || ornaments( <feature-value-name> ) || annotation( <feature-value-name> ) || [ 'small-caps' | 'all-small-caps' | 'petite-caps' | 'all-petite-caps' | 'unicase' | 'titling-caps' ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || 'ordinal' || 'slashed-zero' || <east-asian-variant-values> || <east-asian-width-values> || 'ruby' || 'sub' || 'super' || 'text' || 'emoji' || 'unicode'"
]
and property_font_variant_alternates = [%value.rec
  "'normal' | stylistic( <feature-value-name> ) || 'historical-forms' || styleset( [ <feature-value-name> ]# ) || character-variant( [ <feature-value-name> ]# ) || swash( <feature-value-name> ) || ornaments( <feature-value-name> ) || annotation( <feature-value-name> )"
]
and property_font_variant_caps = [%value.rec
  "'normal' | 'small-caps' | 'all-small-caps' | 'petite-caps' | 'all-petite-caps' | 'unicase' | 'titling-caps'"
]
and property_font_variant_east_asian = [%value.rec
  "'normal' | <east-asian-variant-values> || <east-asian-width-values> || 'ruby'"
]
and property_font_variant_ligatures = [%value.rec
  "'normal' | 'none' | <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values>"
]
and property_font_variant_numeric = [%value.rec
  "'normal' | <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || 'ordinal' || 'slashed-zero'"
]
and property_font_variant_position = [%value.rec "'normal' | 'sub' | 'super'"]
and property_font_variation_settings = [%value.rec
  "'normal' | [ <string> <number> ]#"
]
and property_font_variant_emoji = [%value.rec
  "'normal' | 'text' | 'emoji' | 'unicode'"
]
and property_font_weight = [%value.rec
  "<font-weight-absolute> | 'bolder' | 'lighter' | <interpolation>"
]
and property_gap = [%value.rec "<'row-gap'> [ <'column-gap'> ]?"]
and property_glyph_orientation_horizontal = [%value.rec "<extended-angle>"]
and property_glyph_orientation_vertical = [%value.rec "<extended-angle>"]
and property_grid = [%value.rec
  "<'grid-template'>
  | <'grid-template-rows'> '/' [ 'auto-flow' && [ 'dense' ]? ] [ <'grid-auto-columns'> ]?
  | [ 'auto-flow' && [ 'dense' ]? ] [ <'grid-auto-rows'> ]? '/' <'grid-template-columns'>"
]
and property_grid_area = [%value.rec "<grid-line> [ '/' <grid-line> ]{0,3}"]
and property_grid_auto_columns = [%value.rec "[ <track-size> ]+"]
and property_grid_auto_flow = [%value.rec
  "[ [ 'row' | 'column' ] || 'dense' ] | <interpolation>"
]
and property_grid_auto_rows = [%value.rec "[ <track-size> ]+"]
and property_grid_column = [%value.rec "<grid-line> [ '/' <grid-line> ]?"]
and property_grid_column_end = [%value.rec "<grid-line>"]
and property_grid_column_gap = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and property_grid_column_start = [%value.rec "<grid-line>"]
and property_grid_gap = [%value.rec
  "<'grid-row-gap'> [ <'grid-column-gap'> ]?"
]
and property_grid_row = [%value.rec "<grid-line> [ '/' <grid-line> ]?"]
and property_grid_row_end = [%value.rec "<grid-line>"]
and property_grid_row_gap = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and property_grid_row_start = [%value.rec "<grid-line>"]
and property_grid_template = [%value.rec
  "'none' | <'grid-template-rows'> '/' <'grid-template-columns'> | [ [ <line-names> ]? <string> [ <track-size> ]? [ <line-names> ]? ]+ [ '/' <explicit-track-list> ]?"
]
and property_grid_template_areas = [%value.rec
  "'none' | [ <string> | <interpolation> ]+"
]
and property_grid_template_columns = [%value.rec
  "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]? | 'masonry' | <interpolation>"
]
and property_grid_template_rows = [%value.rec
  "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]? | 'masonry' | <interpolation>"
]
and property_hanging_punctuation = [%value.rec
  "'none' | 'first' || [ 'force-end' | 'allow-end' ] || 'last'"
]
and property_height = [%value.rec
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"
]
and property_hyphens = [%value.rec "'none' | 'manual' | 'auto'"]
and property_hyphenate_character = [%value.rec "'auto' | <string-token>"]
and property_hyphenate_limit_chars = [%value.rec "'auto' | <integer>"]
and property_hyphenate_limit_lines = [%value.rec "'no-limit' | <integer>"]
and property_hyphenate_limit_zone = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and property_image_orientation = [%value.rec
  "'from-image' | <extended-angle> | [ <extended-angle> ]? 'flip'"
]
and property_image_rendering = [%value.rec
  "'auto' |'smooth' | 'high-quality' | 'crisp-edges' | 'pixelated'"
]
and property_image_resolution = [%value.rec
  "[ 'from-image' || <resolution> ] && [ 'snap' ]?"
]
and property_ime_mode = [%value.rec
  "'auto' | 'normal' | 'active' | 'inactive' | 'disabled'"
]
and property_initial_letter = [%value.rec "'normal' | <number> [ <integer> ]?"]
and property_initial_letter_align = [%value.rec
  "'auto' | 'alphabetic' | 'hanging' | 'ideographic'"
]
and property_inline_size = [%value.rec "<'width'>"]
and property_inset = [%value.rec "[ <'top'> ]{1,4}"]
and property_inset_block = [%value.rec "[ <'top'> ]{1,2}"]
and property_inset_block_end = [%value.rec "<'top'>"]
and property_inset_block_start = [%value.rec "<'top'>"]
and property_inset_inline = [%value.rec "[ <'top'> ]{1,2}"]
and property_inset_inline_end = [%value.rec "<'top'>"]
and property_inset_inline_start = [%value.rec "<'top'>"]
and property_isolation = [%value.rec "'auto' | 'isolate'"]
and property_justify_content = [%value.rec
  "'normal' | <content-distribution> | [ <overflow-position> ]? [ <content-position> | 'left' | 'right' ]"
]
and property_justify_items = [%value.rec
  "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? [ <self-position> | 'left' | 'right' ] | 'legacy' | 'legacy' && [ 'left' | 'right' | 'center' ]"
]
and property_justify_self = [%value.rec
  "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? [ <self-position> | 'left' | 'right' ]"
]
and property_kerning = [%value.rec "'auto' | <svg-length>"]
and property_layout_grid = [%value.rec
  "'auto' | <custom-ident> | <integer> && [ <custom-ident> ]?"
]
and property_layout_grid_char = [%value.rec
  "'auto' | <custom-ident> | <string>"
]
and property_layout_grid_line = [%value.rec
  "'auto' | <custom-ident> | <string>"
]
and property_layout_grid_mode = [%value.rec
  "'auto' | <custom-ident> | <string>"
]
and property_layout_grid_type = [%value.rec
  "'auto' | <custom-ident> | <string>"
]
and property_left = [%value.rec
  "<extended-length> | <extended-percentage> | 'auto'"
]
and property_letter_spacing = [%value.rec
  "'normal' | <extended-length> | <extended-percentage>"
]
and property_line_break = [%value.rec
  "'auto' | 'loose' | 'normal' | 'strict' | 'anywhere' | <interpolation>"
]
and property_line_clamp = [%value.rec "'none' | <integer>"]
and property_line_height = [%value.rec
  "'normal' | <number> | <extended-length> | <extended-percentage>"
]
and property_line_height_step = [%value.rec "<extended-length>"]
and property_list_style = [%value.rec
  "<'list-style-type'> || <'list-style-position'> || <'list-style-image'>"
]
and property_list_style_image = [%value.rec "'none' | <image>"]
and property_list_style_position = [%value.rec "'inside' | 'outside'"]
and property_list_style_type = [%value.rec
  "<counter-style> | <string> | 'none'"
]
and property_margin = [%value.rec
  "[ <extended-length> | <extended-percentage> | 'auto' | <interpolation> ]{1,4}"
]
and property_margin_block = [%value.rec "[ <'margin-left'> ]{1,2}"]
and property_margin_block_end = [%value.rec "<'margin-left'>"]
and property_margin_block_start = [%value.rec "<'margin-left'>"]
and property_margin_bottom = [%value.rec
  "<extended-length> | <extended-percentage> | 'auto'"
]
and property_margin_inline = [%value.rec "[ <'margin-left'> ]{1,2}"]
and property_margin_inline_end = [%value.rec "<'margin-left'>"]
and property_margin_inline_start = [%value.rec "<'margin-left'>"]
and property_margin_left = [%value.rec
  "<extended-length> | <extended-percentage> | 'auto'"
]
and property_margin_right = [%value.rec
  "<extended-length> | <extended-percentage> | 'auto'"
]
and property_margin_top = [%value.rec
  "<extended-length> | <extended-percentage> | 'auto'"
]
and property_margin_trim = [%value.rec "'none' | 'in-flow' | 'all'"]
and property_marker = [%value.rec "'none' | <url>"]
and property_marker_end = [%value.rec "'none' | <url>"]
and property_marker_mid = [%value.rec "'none' | <url>"]
and property_marker_start = [%value.rec "'none' | <url>"]
and property_mask = [%value.rec "[ <mask-layer> ]#"]
and property_mask_border = [%value.rec
  "<'mask-border-source'> || <'mask-border-slice'> [ '/' [ <'mask-border-width'> ]? [ '/' <'mask-border-outset'> ]? ]? || <'mask-border-repeat'> || <'mask-border-mode'>"
]
and property_mask_border_mode = [%value.rec "'luminance' | 'alpha'"]
and property_mask_border_outset = [%value.rec
  "[ <extended-length> | <number> ]{1,4}"
]
and property_mask_border_repeat = [%value.rec
  "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}"
]
and property_mask_border_slice = [%value.rec
  "[ <number-percentage> ]{1,4} [ 'fill' ]?"
]
and property_mask_border_source = [%value.rec "'none' | <image>"]
and property_mask_border_width = [%value.rec
  "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}"
]
and property_mask_clip = [%value.rec "[ <geometry-box> | 'no-clip' ]#"]
and property_mask_composite = [%value.rec "[ <compositing-operator> ]#"]
and property_mask_image = [%value.rec "[ <mask-reference> ]#"]
and property_mask_mode = [%value.rec "[ <masking-mode> ]#"]
and property_mask_origin = [%value.rec "[ <geometry-box> ]#"]
and property_mask_position = [%value.rec "[ <position> ]#"]
and property_mask_repeat = [%value.rec "[ <repeat-style> ]#"]
and property_mask_size = [%value.rec "[ <bg-size> ]#"]
and property_mask_type = [%value.rec "'luminance' | 'alpha'"]
and property_masonry_auto_flow = [%value.rec
  "[ 'pack' | 'next' ] || [ 'definite-first' | 'ordered' ]"
]
and property_max_block_size = [%value.rec "<'max-width'>"]
and property_max_height = [%value.rec
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"
]
and property_max_inline_size = [%value.rec "<'max-width'>"]
and property_max_lines = [%value.rec "'none' | <integer>"]
and property_max_width = [%value.rec
  "<extended-length> | <extended-percentage> | 'none' | 'max-content' | 'min-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> ) | 'fill-available' | <-non-standard-width>"
]
and property_min_block_size = [%value.rec "<'min-width'>"]
and property_min_height = [%value.rec
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"
]
and property_min_inline_size = [%value.rec "<'min-width'>"]
and property_min_width = [%value.rec
  "<extended-length> | <extended-percentage> | 'auto' | 'max-content' | 'min-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> ) | 'fill-available' | <-non-standard-width>"
]
and property_mix_blend_mode = [%value.rec "<blend-mode>"]
and property_media_any_hover = [%value.rec "none | hover"]
and property_media_any_pointer = [%value.rec "none | coarse | fine"]
and property_media_pointer = [%value.rec "none | coarse | fine"]
and property_media_max_aspect_ratio = [%value.rec "<ratio>"]
and property_media_min_aspect_ratio = [%value.rec "<ratio>"]
and property_media_min_color = [%value.rec "<integer>"]
and property_media_color_gamut = [%value.rec "'srgb' | 'p3' | 'rec2020'"]
and property_media_color_index = [%value.rec "<integer>"]
and property_media_min_color_index = [%value.rec "<integer>"]
and property_media_display_mode = [%value.rec
  "'fullscreen' | 'standalone' | 'minimal-ui' | 'browser'"
]
and property_media_forced_colors = [%value.rec "'none' | 'active'"]
and property_forced_color_adjust = [%value.rec
  "'auto' | 'none' | 'preserve-parent-color'"
]
and property_media_grid = [%value.rec "<integer>"]
and property_media_hover = [%value.rec "'hover' | 'none'"]
and property_media_inverted_colors = [%value.rec "'inverted' | 'none'"]
and property_media_monochrome = [%value.rec "<integer>"]
and property_media_prefers_color_scheme = [%value.rec "'dark' | 'light'"]
and property_color_scheme = [%value.rec
  "'normal' |
  [ 'dark' | 'light' | <custom-ident> ]+ && 'only'?"
]
and property_media_prefers_contrast = [%value.rec
  "'no-preference' | 'more' | 'less'"
]
and property_media_prefers_reduced_motion = [%value.rec
  "'no-preference' | 'reduce'"
]
and property_media_resolution = [%value.rec "<resolution>"]
and property_media_min_resolution = [%value.rec "<resolution>"]
and property_media_max_resolution = [%value.rec "<resolution>"]
and property_media_scripting = [%value.rec
  "'none' | 'initial-only' | 'enabled'"
]
and property_media_update = [%value.rec "'none' | 'slow' | 'fast'"]
and property_media_orientation = [%value.rec "'portrait' | 'landscape'"]
and property_object_fit = [%value.rec
  "'fill' | 'contain' | 'cover' | 'none' | 'scale-down'"
]
and property_object_position = [%value.rec "<position>"]
and property_offset = [%value.rec
  "[ [ <'offset-position'> ]? <'offset-path'> [ <'offset-distance'> || <'offset-rotate'> ]? ]? [ '/' <'offset-anchor'> ]?"
]
and property_offset_anchor = [%value.rec "'auto' | <position>"]
and property_offset_distance = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and property_offset_path = [%value.rec
  "'none' | ray( <extended-angle> && [ <ray_size> ]? && [ 'contain' ]? ) | <path()> | <url> | <basic-shape> || <geometry-box>"
]
and property_offset_position = [%value.rec "'auto' | <position>"]
and property_offset_rotate = [%value.rec
  "[ 'auto' | 'reverse' ] || <extended-angle>"
]
and property_opacity = [%value.rec "<alpha-value>"]
and property_order = [%value.rec "<integer>"]
and property_orphans = [%value.rec "<integer>"]
and property_outline = [%value.rec
  "'none' | <'outline-width'> | [ <'outline-width'> <'outline-style'> ] | [ <'outline-width'> <'outline-style'> [ <color> | <interpolation> ]]"
]
and property_outline_color = [%value.rec "<color>"]
and property_outline_offset = [%value.rec "<extended-length>"]
and property_outline_style = [%value.rec
  "'auto' | <line-style> | <interpolation>"
]
and property_outline_width = [%value.rec "<line-width> | <interpolation>"]
and property_overflow = [%value.rec
  "[ 'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' ]{1,2} | <-non-standard-overflow> | <interpolation>"
]
and property_overflow_anchor = [%value.rec "'auto' | 'none'"]
and property_overflow_block = [%value.rec
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"
]
and property_overflow_clip_margin = [%value.rec
  "<visual-box> || <extended-length>"
]
and property_overflow_inline = [%value.rec
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"
]
and property_overflow_wrap = [%value.rec
  "'normal' | 'break-word' | 'anywhere'"
]
and property_overflow_x = [%value.rec
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"
]
and property_overflow_y = [%value.rec
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"
]
and property_overscroll_behavior = [%value.rec
  "[ 'contain' | 'none' | 'auto' ]{1,2}"
]
and property_overscroll_behavior_block = [%value.rec
  "'contain' | 'none' | 'auto'"
]
and property_overscroll_behavior_inline = [%value.rec
  "'contain' | 'none' | 'auto'"
]
and property_overscroll_behavior_x = [%value.rec "'contain' | 'none' | 'auto'"]
and property_overscroll_behavior_y = [%value.rec "'contain' | 'none' | 'auto'"]
and property_padding = [%value.rec
  "[ <extended-length> | <extended-percentage> | <interpolation> ]{1,4}"
]
and property_padding_block = [%value.rec "[ <'padding-left'> ]{1,2}"]
and property_padding_block_end = [%value.rec "<'padding-left'>"]
and property_padding_block_start = [%value.rec "<'padding-left'>"]
and property_padding_bottom = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and property_padding_inline = [%value.rec "[ <'padding-left'> ]{1,2}"]
and property_padding_inline_end = [%value.rec "<'padding-left'>"]
and property_padding_inline_start = [%value.rec "<'padding-left'>"]
and property_padding_left = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and property_padding_right = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and property_padding_top = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and property_page_break_after = [%value.rec
  "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'"
]
and property_page_break_before = [%value.rec
  "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'"
]
and property_page_break_inside = [%value.rec "'auto' | 'avoid'"]
and property_paint_order = [%value.rec
  "'normal' | 'fill' || 'stroke' || 'markers'"
]
and property_pause = [%value.rec "<'pause-before'> [ <'pause-after'> ]?"]
and property_pause_after = [%value.rec
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | 'x-strong'"
]
and property_pause_before = [%value.rec
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | 'x-strong'"
]
and property_perspective = [%value.rec "'none' | <extended-length>"]
and property_perspective_origin = [%value.rec "<position>"]
and property_place_content = [%value.rec
  "<'align-content'> [ <'justify-content'> ]?"
]
and property_place_items = [%value.rec
  "<'align-items'> [ <'justify-items'> ]?"
]
and property_place_self = [%value.rec "<'align-self'> [ <'justify-self'> ]?"]
and property_pointer_events = [%value.rec
  "'auto' | 'none' | 'visiblePainted' | 'visibleFill' | 'visibleStroke' | 'visible' | 'painted' | 'fill' | 'stroke' | 'all' | 'inherit'"
]
and property_position = [%value.rec
  "'static' | 'relative' | 'absolute' | 'sticky' | 'fixed' | '-webkit-sticky'"
]
and property_quotes = [%value.rec "'none' | 'auto' | [ <string> <string> ]+"]
and property_resize = [%value.rec
  "'none' | 'both' | 'horizontal' | 'vertical' | 'block' | 'inline'"
]
and property_rest = [%value.rec "<'rest-before'> [ <'rest-after'> ]?"]
and property_rest_after = [%value.rec
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | 'x-strong'"
]
and property_rest_before = [%value.rec
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | 'x-strong'"
]
and property_right = [%value.rec
  "<extended-length> | <extended-percentage> | 'auto'"
]
and property_rotate = [%value.rec
  "'none' | <extended-angle> | [ 'x' | 'y' | 'z' | [ <number> ]{3} ] && <extended-angle>"
]
and property_row_gap = [%value.rec
  "'normal' | <extended-length> | <extended-percentage>"
]
and property_ruby_align = [%value.rec
  "'start' | 'center' | 'space-between' | 'space-around'"
]
and property_ruby_merge = [%value.rec "'separate' | 'collapse' | 'auto'"]
and property_ruby_position = [%value.rec
  "'over' | 'under' | 'inter-character'"
]
and property_scale = [%value.rec "'none' | [ <number-percentage> ]{1,3}"]
and property_scroll_behavior = [%value.rec "'auto' | 'smooth'"]
and property_scroll_margin = [%value.rec "[ <extended-length> ]{1,4}"]
and property_scroll_margin_block = [%value.rec "[ <extended-length> ]{1,2}"]
and property_scroll_margin_block_end = [%value.rec "<extended-length>"]
and property_scroll_margin_block_start = [%value.rec "<extended-length>"]
and property_scroll_margin_bottom = [%value.rec "<extended-length>"]
and property_scroll_margin_inline = [%value.rec "[ <extended-length> ]{1,2}"]
and property_scroll_margin_inline_end = [%value.rec "<extended-length>"]
and property_scroll_margin_inline_start = [%value.rec "<extended-length>"]
and property_scroll_margin_left = [%value.rec "<extended-length>"]
and property_scroll_margin_right = [%value.rec "<extended-length>"]
and property_scroll_margin_top = [%value.rec "<extended-length>"]
and property_scroll_padding = [%value.rec
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,4}"
]
and property_scroll_padding_block = [%value.rec
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"
]
and property_scroll_padding_block_end = [%value.rec
  "'auto' | <extended-length> | <extended-percentage>"
]
and property_scroll_padding_block_start = [%value.rec
  "'auto' | <extended-length> | <extended-percentage>"
]
and property_scroll_padding_bottom = [%value.rec
  "'auto' | <extended-length> | <extended-percentage>"
]
and property_scroll_padding_inline = [%value.rec
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"
]
and property_scroll_padding_inline_end = [%value.rec
  "'auto' | <extended-length> | <extended-percentage>"
]
and property_scroll_padding_inline_start = [%value.rec
  "'auto' | <extended-length> | <extended-percentage>"
]
and property_scroll_padding_left = [%value.rec
  "'auto' | <extended-length> | <extended-percentage>"
]
and property_scroll_padding_right = [%value.rec
  "'auto' | <extended-length> | <extended-percentage>"
]
and property_scroll_padding_top = [%value.rec
  "'auto' | <extended-length> | <extended-percentage>"
]
and property_scroll_snap_align = [%value.rec
  "[ 'none' | 'start' | 'end' | 'center' ]{1,2}"
]
and property_scroll_snap_coordinate = [%value.rec "'none' | [ <position> ]#"]
and property_scroll_snap_destination = [%value.rec "<position>"]
and property_scroll_snap_points_x = [%value.rec
  "'none' | repeat( <extended-length> | <extended-percentage> )"
]
and property_scroll_snap_points_y = [%value.rec
  "'none' | repeat( <extended-length> | <extended-percentage> )"
]
and property_scroll_snap_stop = [%value.rec "'normal' | 'always'"]
and property_scroll_snap_type = [%value.rec
  "'none' | [ 'x' | 'y' | 'block' | 'inline' | 'both' ] [ 'mandatory' | 'proximity' ]?"
]
and property_scroll_snap_type_x = [%value.rec
  "'none' | 'mandatory' | 'proximity'"
]
and property_scroll_snap_type_y = [%value.rec
  "'none' | 'mandatory' | 'proximity'"
]
and property_scrollbar_color = [%value.rec "'auto' | [ <color> <color> ]"]
and property_scrollbar_width = [%value.rec "'auto' | 'thin' | 'none'"]
and property_scrollbar_gutter = [%value.rec
  "'auto' | 'stable' && 'both-edges'?"
]
and property_scrollbar_3dlight_color = [%value.rec "<color>"]
and property_scrollbar_arrow_color = [%value.rec "<color>"]
and property_scrollbar_base_color = [%value.rec "<color>"]
and property_scrollbar_darkshadow_color = [%value.rec "<color>"]
and property_scrollbar_face_color = [%value.rec "<color>"]
and property_scrollbar_highlight_color = [%value.rec "<color>"]
and property_scrollbar_shadow_color = [%value.rec "<color>"]
and property_scrollbar_track_color = [%value.rec "<color>"]
and property_shape_image_threshold = [%value.rec "<alpha-value>"]
and property_shape_margin = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and property_shape_outside = [%value.rec
  "'none' | <shape-box> || <basic-shape> | <image>"
]
and property_shape_rendering = [%value.rec
  "'auto' | 'optimizeSpeed' | 'crispEdges' | 'geometricPrecision'"
]
and property_speak = [%value.rec "'auto' | 'none' | 'normal'"]
and property_speak_as = [%value.rec
  "'normal' | 'spell-out' || 'digits' || [ 'literal-punctuation' | 'no-punctuation' ]"
]
and property_src = [%value.rec
  "[ <url> [ format( [ <string> ]# ) ]? | local( <family-name> ) ]#"
]
and property_stroke = [%value.rec "<paint>"]
and property_stroke_dasharray = [%value.rec "'none' | [ [ <svg-length> ]+ ]#"]
and property_stroke_dashoffset = [%value.rec "<svg-length>"]
and property_stroke_linecap = [%value.rec "'butt' | 'round' | 'square'"]
and property_stroke_linejoin = [%value.rec "'miter' | 'round' | 'bevel'"]
and property_stroke_miterlimit = [%value.rec "<number-one-or-greater>"]
and property_stroke_opacity = [%value.rec "<alpha-value>"]
and property_stroke_width = [%value.rec "<svg-length>"]
and property_tab_size = [%value.rec " <number> | <extended-length>"]
and property_table_layout = [%value.rec "'auto' | 'fixed'"]
and property_text_autospace = [%value.rec
  "'none' | 'ideograph-alpha' | 'ideograph-numeric' | 'ideograph-parenthesis' | 'ideograph-space'"
]
and property_text_blink = [%value.rec "'none' | 'blink' | 'blink-anywhere'"]
and property_text_align = [%value.rec
  "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent' | 'justify-all'"
]
and property_text_align_all = [%value.rec
  "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent'"
]
and property_text_align_last = [%value.rec
  "'auto' | 'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent'"
]
and property_text_anchor = [%value.rec "'start' | 'middle' | 'end'"]
and property_text_combine_upright = [%value.rec
  "'none' | 'all' | 'digits' [ <integer> ]?"
]
and property_text_decoration = [%value.rec
  "<'text-decoration-color'> || <'text-decoration-style'> || <'text-decoration-thickness'> || <'text-decoration-line'>"
]
and property_text_justify_trim = [%value.rec "'none' | 'all' | 'auto'"]
and property_text_kashida = [%value.rec
  "'none' | 'horizontal' | 'vertical' | 'both'"
]
and property_text_kashida_space = [%value.rec "'normal' | 'pre' | 'post'"]
and property_text_decoration_color = [%value.rec "<color>"]
/* Spec doesn't contain spelling-error and grammar-error: https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-line but this list used to have them | 'spelling-error' | 'grammar-error'. Leaving this comment here for reference */
/* and this definition has changed from the origianl, it might be a bug on the spec or our Generator,
   but simplifying to "|" simplifies it and solves the bug */
and property_text_decoration_line = [%value.rec
  "'none' | <interpolation> | [ 'underline' || 'overline' || 'line-through' || 'blink' ]"
]
and property_text_decoration_skip = [%value.rec
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] || 'edges' || 'box-decoration'"
]
and property_text_decoration_skip_self = [%value.rec
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] || 'edges' || 'box-decoration'"
]
and property_text_decoration_skip_ink = [%value.rec "'auto' | 'all' | 'none'"]
and property_text_decoration_skip_box = [%value.rec "'none' | 'all'"]
and property_text_decoration_skip_spaces = [%value.rec
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] || 'edges' || 'box-decoration'"
]
and property_text_decoration_skip_inset = [%value.rec "'none' | 'auto'"]

and property_text_decoration_style = [%value.rec
  "'solid' | 'double' | 'dotted' | 'dashed' | 'wavy'"
]
and property_text_decoration_thickness = [%value.rec
  "'auto' | 'from-font' | <extended-length> | <extended-percentage>"
]
and property_text_emphasis = [%value.rec
  "<'text-emphasis-style'> || <'text-emphasis-color'>"
]
and property_text_emphasis_color = [%value.rec "<color>"]
and property_text_emphasis_position = [%value.rec
  "[ 'over' | 'under' ] && [ 'right' | 'left' ]?"
]
and property_text_emphasis_style = [%value.rec
  "'none' | [ 'filled' | 'open' ] || [ 'dot' | 'circle' | 'double-circle' | 'triangle' | 'sesame' ] | <string>"
]
and property_text_indent = [%value.rec
  "[<extended-length> | <extended-percentage>] && [ 'hanging' ]? && [ 'each-line' ]?"
]
and property_text_justify = [%value.rec
  "'auto' | 'inter-character' | 'inter-word' | 'none'"
]
and property_text_orientation = [%value.rec "'mixed' | 'upright' | 'sideways'"]
and property_text_overflow = [%value.rec
  "[ 'clip' | 'ellipsis' | <string> ]{1,2}"
]
and property_text_rendering = [%value.rec
  "'auto' | 'optimizeSpeed' | 'optimizeLegibility' | 'geometricPrecision'"
]
and property_text_shadow = [%value.rec
  "'none' | <interpolation> | [ <shadow-t> ]#"
]
and property_text_size_adjust = [%value.rec
  "'none' | 'auto' | <extended-percentage>"
]
and property_text_transform = [%value.rec
  "'none' | 'capitalize' | 'uppercase' | 'lowercase' | 'full-width' | 'full-size-kana'"
]
and property_text_underline_offset = [%value.rec
  "'auto' | <extended-length> | <extended-percentage>"
]
and property_text_underline_position = [%value.rec
  "'auto' | 'from-font' | 'under' || [ 'left' | 'right' ]"
]
and property_top = [%value.rec
  "<extended-length> | <extended-percentage> | 'auto'"
]
and property_touch_action = [%value.rec
  "'auto' | 'none' | [ 'pan-x' | 'pan-left' | 'pan-right' ] || [ 'pan-y' | 'pan-up' | 'pan-down' ] || 'pinch-zoom' | 'manipulation'"
]
and property_transform = [%value.rec "'none' | <transform-list>"]
and property_transform_box = [%value.rec
  "'content-box' | 'border-box' | 'fill-box' | 'stroke-box' | 'view-box'"
]
and property_transform_origin = [%value.rec
  "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ]
  | [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | 'bottom' | <length-percentage> ] <length>?
  | [[ 'center' | 'left' | 'right' ] && [ 'center' | 'top' | 'bottom' ]] <length>? "
]
and property_transform_style = [%value.rec "'flat' | 'preserve-3d'"]
and property_transition = [%value.rec
  "[ <single-transition> | <single-transition-no-interp> ]#"
]
and property_transition_behavior = [%value.rec "<transition-behavior-value>#"]
and property_transition_delay = [%value.rec "[ <extended-time> ]#"]
and property_transition_duration = [%value.rec "[ <extended-time> ]#"]
and property_transition_property = [%value.rec
  "[ <single-transition-property> ]# | 'none'"
]
and property_transition_timing_function = [%value.rec "[ <timing-function> ]#"]
and property_translate = [%value.rec
  "'none' | <length-percentage> [ <length-percentage> <length>? ]?"
]
and property_unicode_bidi = [%value.rec
  "'normal' | 'embed' | 'isolate' | 'bidi-override' | 'isolate-override' | 'plaintext' | '-moz-isolate' | '-moz-isolate-override' | '-moz-plaintext' | '-webkit-isolate'"
]
and property_unicode_range = [%value.rec "[ <urange> ]#"]
and property_user_select = [%value.rec
  "'auto' | 'text' | 'none' | 'contain' | 'all' | <interpolation>"
]
and property_vertical_align = [%value.rec
  "'baseline' | 'sub' | 'super' | 'text-top' | 'text-bottom' | 'middle' | 'top' | 'bottom' | <extended-percentage> | <extended-length>"
]
and property_visibility = [%value.rec
  "'visible' | 'hidden' | 'collapse' | <interpolation>"
]
and property_voice_balance = [%value.rec
  "<number> | 'left' | 'center' | 'right' | 'leftwards' | 'rightwards'"
]
and property_voice_duration = [%value.rec "'auto' | <extended-time>"]
and property_voice_family = [%value.rec
  "[ [ <family-name> | <generic-voice> ] ',' ]* [ <family-name> | <generic-voice> ] | 'preserve'"
]
and property_voice_pitch = [%value.rec
  "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | 'high' | 'x-high' ] || [ <extended-frequency> | <semitones> | <extended-percentage> ]"
]
and property_voice_range = [%value.rec
  "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | 'high' | 'x-high' ] || [ <extended-frequency> | <semitones> | <extended-percentage> ]"
]
and property_voice_rate = [%value.rec
  "[ 'normal' | 'x-slow' | 'slow' | 'medium' | 'fast' | 'x-fast' ] || <extended-percentage>"
]
and property_voice_stress = [%value.rec
  "'normal' | 'strong' | 'moderate' | 'none' | 'reduced'"
]
and property_voice_volume = [%value.rec
  "'silent' | [ 'x-soft' | 'soft' | 'medium' | 'loud' | 'x-loud' ] || <decibel>"
]
and property_white_space = [%value.rec
  "'normal' | 'pre' | 'nowrap' | 'pre-wrap' | 'pre-line' | 'break-spaces'"
]
and property_widows = [%value.rec "<integer>"]
and property_width = [%value.rec
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"
]
and property_will_change = [%value.rec "'auto' | [ <animateable-feature> ]#"]
and property_word_break = [%value.rec
  "'normal' | 'break-all' | 'keep-all' | 'break-word'"
]
and property_word_spacing = [%value.rec
  "'normal' | <extended-length> | <extended-percentage>"
]
and property_word_wrap = [%value.rec "'normal' | 'break-word' | 'anywhere'"]
and property_writing_mode = [%value.rec
  "'horizontal-tb' | 'vertical-rl' | 'vertical-lr' | 'sideways-rl' | 'sideways-lr' | <svg-writing-mode>"
]
and property_z_index = [%value.rec "'auto' | <integer> | <interpolation>"]
and property_zoom = [%value.rec
  "'normal' | 'reset' | <number> | <extended-percentage>"
]
and property_container = [%value.rec
  "<'container-name'> [ '/' <'container-type'> ]?"
]
and property_container_name = [%value.rec "<custom-ident>+ | 'none'"]
and property_container_type = [%value.rec "'normal' | 'size' | 'inline-size'"]
and property_nav_down = [%value.rec "'auto' | <integer> | <interpolation>"]
and property_nav_left = [%value.rec "'auto' | <integer> | <interpolation>"]
and property_nav_right = [%value.rec "'auto' | <integer> | <interpolation>"]
and property_nav_up = [%value.rec "'auto' | <integer> | <interpolation>"]
and pseudo_class_selector = [%value.rec
  "':' <ident-token> | ':' <function-token> <any-value> ')'"
]
and pseudo_element_selector = [%value.rec "':' <pseudo-class-selector>"]
and pseudo_page = [%value.rec "':' [ 'left' | 'right' | 'first' | 'blank' ]"]
and quote = [%value.rec
  "'open-quote' | 'close-quote' | 'no-open-quote' | 'no-close-quote'"
]
and ratio = [%value.rec "<integer> '/' <integer> | <number> | <interpolation>"]
and relative_selector = [%value.rec "[ <combinator> ]? <complex-selector>"]
and relative_selector_list = [%value.rec "[ <relative-selector> ]#"]
and relative_size = [%value.rec "'larger' | 'smaller'"]
and repeat_style = [%value.rec
  "'repeat-x' | 'repeat-y' | [ 'repeat' | 'space' | 'round' | 'no-repeat' ] [ 'repeat' | 'space' | 'round' | 'no-repeat' ]?"
]
and right = [%value.rec "<extended-length> | 'auto'"]
and self_position = [%value.rec
  "'center' | 'start' | 'end' | 'self-start' | 'self-end' | 'flex-start' | 'flex-end'"
]
and shadow = [%value.rec
  "[ 'inset' ]? [ <extended-length> | <interpolation> ]{4} [ <color> | <interpolation> ]?"
]
and shadow_t = [%value.rec
  "[ <extended-length> | <interpolation> ]{3} [ <color> | <interpolation> ]?"
]
and shape = [%value.rec
  "rect( <top> ',' <right> ',' <bottom> ',' <left> ) | rect( <top> <right> <bottom> <left> )"
]
and shape_box = [%value.rec "<box> | 'margin-box'"]
and shape_radius = [%value.rec
  "<extended-length> | <extended-percentage> | 'closest-side' | 'farthest-side'"
]
and side_or_corner = [%value.rec
  "[ 'left' | 'right' ] || [ 'top' | 'bottom' ]"
]
and single_animation = [%value.rec
  "[ [ <keyframes-name> | 'none' | <interpolation> ] ]
  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> ]
  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> <timing-function> ]
  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> <timing-function> <extended-time> ]
  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> <timing-function> <extended-time> <single-animation-iteration-count> ]
  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> <timing-function> <extended-time> <single-animation-iteration-count> <single-animation-direction> ]
  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> <timing-function> <extended-time> <single-animation-iteration-count> <single-animation-direction> <single-animation-fill-mode> ]
  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> <timing-function> <extended-time> <single-animation-iteration-count> <single-animation-direction> <single-animation-fill-mode> <single-animation-play-state> ]"
]
and single_animation_no_interp = [%value.rec
  "[ <keyframes-name> | 'none' ] || <extended-time-no-interp> || <timing-function-no-interp> || <extended-time-no-interp> || <single-animation-iteration-count-no-interp> || <single-animation-direction-no-interp> || <single-animation-fill-mode-no-interp> || <single-animation-play-state-no-interp>"
]
and single_animation_direction = [%value.rec
  "'normal' | 'reverse' | 'alternate' | 'alternate-reverse' | <interpolation>"
]
and single_animation_direction_no_interp = [%value.rec
  "'normal' | 'reverse' | 'alternate' | 'alternate-reverse'"
]
and single_animation_fill_mode = [%value.rec
  "'none' | 'forwards' | 'backwards' | 'both' | <interpolation>"
]
and single_animation_fill_mode_no_interp = [%value.rec
  "'none' | 'forwards' | 'backwards' | 'both'"
]
and single_animation_iteration_count = [%value.rec
  "'infinite' | <number> | <interpolation>"
]
and single_animation_iteration_count_no_interp = [%value.rec
  "'infinite' | <number>"
]
and single_animation_play_state = [%value.rec
  "'running' | 'paused' | <interpolation>"
]
and single_animation_play_state_no_interp = [%value.rec "'running' | 'paused'"]
and single_transition_no_interp = [%value.rec
  "[ <single-transition-property-no-interp> | 'none' ] || <extended-time-no-interp> || <timing-function-no-interp> || <extended-time-no-interp> || <transition-behavior-value-no-interp>"
]
and single_transition = [%value.rec
  "[<single-transition-property> | 'none']
  | [ [<single-transition-property> | 'none'] <extended-time> ]
  | [ [<single-transition-property> | 'none'] <extended-time> <timing-function> ]
  | [ [<single-transition-property> | 'none'] <extended-time> <timing-function> <extended-time> ]
  | [ [<single-transition-property> | 'none'] <extended-time> <timing-function> <extended-time> <transition-behavior-value> ]"
]
and single_transition_property = [%value.rec
  "<custom-ident> | <interpolation> | 'all'"
]
and single_transition_property_no_interp = [%value.rec
  "<custom-ident> | 'all'"
]
and size = [%value.rec
  "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | <extended-length> | [ <extended-length> | <extended-percentage> ]{2}"
]
and ray_size = [%value.rec
  "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | 'sides'"
]
and radial_size = [%value.rec
  "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | <extended-length> | [ <extended-length> | <extended-percentage> ]{2}"
]
and step_position = [%value.rec
  "'jump-start' | 'jump-end' | 'jump-none' | 'jump-both' | 'start' | 'end'"
]
and step_timing_function = [%value.rec
  "'step-start' | 'step-end' | steps( <integer> [ ',' <step-position> ]? )"
]
and subclass_selector = [%value.rec
  "<id-selector> | <class-selector> | <attribute-selector> | <pseudo-class-selector>"
]
and supports_condition = [%value.rec
  "'not' <supports-in-parens> | <supports-in-parens> [ 'and' <supports-in-parens> ]* | <supports-in-parens> [ 'or' <supports-in-parens> ]*"
]
and supports_decl = [%value.rec "'(' <declaration> ')'"]
and supports_feature = [%value.rec "<supports-decl> | <supports-selector-fn>"]
and supports_in_parens = [%value.rec
  "'(' <supports-condition> ')' | <supports-feature>"
]
and supports_selector_fn = [%value.rec "selector( <complex-selector> )"]
and svg_length = [%value.rec
  "<extended-percentage> | <extended-length> | <number>"
]
and svg_writing_mode = [%value.rec
  "'lr-tb' | 'rl-tb' | 'tb-rl' | 'lr' | 'rl' | 'tb'"
]
and symbol = [%value.rec "<string> | <image> | <custom-ident>"]
and symbols_type = [%value.rec
  "'cyclic' | 'numeric' | 'alphabetic' | 'symbolic' | 'fixed'"
]
and target = [%value.rec
  "<target-counter()> | <target-counters()> | <target-text()>"
]
and url = [%value.rec "<url-no-interp> | url( <interpolation> )"]
and extended_length = [%value.rec
  "<length> | <calc()> | <interpolation> | <min()> | <max()>"
]
and length_percentage = [%value.rec
  "<extended-length> | <extended-percentage>"
]
and extended_frequency = [%value.rec
  "<frequency> | <calc()> | <interpolation> | <min()> | <max()>"
]
and extended_angle = [%value.rec
  "<angle> | <calc()> | <interpolation> | <min()> | <max()>"
]
and extended_time = [%value.rec
  "<time> | <calc()> | <interpolation> | <min()> | <max()>"
]
and extended_time_no_interp = [%value.rec
  "<time> | <calc()> | <min()> | <max()>"
]
and extended_percentage = [%value.rec
  "<percentage> | <calc()> | <interpolation> | <min()> | <max()> "
]
and timing_function = [%value.rec
  "'linear' | <cubic-bezier-timing-function> | <step-timing-function> | <interpolation>"
]
and timing_function_no_interp = [%value.rec
  "'linear' | <cubic-bezier-timing-function> | <step-timing-function>"
]
and top = [%value.rec "<extended-length> | 'auto'"]
and track_breadth = [%value.rec
  "<extended-length> | <extended-percentage> | <flex-value> | 'min-content' | 'max-content' | 'auto'"
]
and track_group = [%value.rec
  "'(' [ [ <string> ]* <track-minmax> [ <string> ]* ]+ ')' [ '[' <positive-integer> ']' ]? | <track-minmax>"
]
and track_list = [%value.rec
  "[ [ <line-names> ]? [ <track-size> | <track-repeat> ] ]+ [ <line-names> ]?"
]
and track_list_v0 = [%value.rec
  "[ [ <string> ]* <track-group> [ <string> ]* ]+ | 'none'"
]
and track_minmax = [%value.rec
  "minmax( <track-breadth> ',' <track-breadth> ) | 'auto' | <track-breadth> | fit-content( <extended-length> | <extended-percentage> )"
]
and track_repeat = [%value.rec
  "repeat( <positive-integer> ',' [ [ <line-names> ]? <track-size> ]+ [ <line-names> ]? )"
]
and track_size = [%value.rec
  "<track-breadth> | minmax( <inflexible-breadth> ',' <track-breadth> ) | fit-content( <extended-length> | <extended-percentage> )"
]
and transform_function = [%value.rec
  "<matrix()> | <translate()> | <translateX()> | <translateY()> | <scale()> | <scaleX()> | <scaleY()> | <rotate()> | <skew()> | <skewX()> | <skewY()> | <matrix3d()> | <translate3d()> | <translateZ()> | <scale3d()> | <scaleZ()> | <rotate3d()> | <rotateX()> | <rotateY()> | <rotateZ()> | <perspective()>"
]
and transform_list = [%value.rec "[ <transform-function> ]+"]
and transition_behavior_value = [%value.rec
  "'normal' | 'allow-discrete' | <interpolation>"
]
and transition_behavior_value_no_interp = [%value.rec
  "'normal' | 'allow-discrete'"
]
and type_or_unit = [%value.rec
  "'string' | 'color' | 'url' | 'integer' | 'number' | 'length' | 'angle' | 'time' | 'frequency' | 'cap' | 'ch' | 'em' | 'ex' | 'ic' | 'lh' | 'rlh' | 'rem' | 'vb' | 'vi' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'mm' | 'Q' | 'cm' | 'in' | 'pt' | 'pc' | 'px' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | 's' | 'Hz' | 'kHz' | '%'"
]
and type_selector = [%value.rec "<wq-name> | [ <ns-prefix> ]? '*'"]
and viewport_length = [%value.rec
  "'auto' | <extended-length> | <extended-percentage>"
]
and visual_box = [%value.rec "'content-box' | 'padding-box' | 'border-box'"]
and wq_name = [%value.rec "[ <ns-prefix> ]? <ident-token>"]
and attr_name = [%value.rec "[ <ident-token>? '|' ]? <ident-token>"]
and attr_unit = [%value.rec
  "'%' | 'em' | 'ex' | 'ch' | 'rem' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'cm' | 'mm' | 'in' | 'px' | 'pt' | 'pc' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | 's' | 'Hz' | 'kHz'"
]
and syntax_type_name = [%value.rec
  "'angle' | 'color' | 'custom-ident' | 'image' | 'integer' | 'length' | 'length-percentage' | 'number' | 'percentage' | 'resolution' | 'string' | 'time' | 'url' | 'transform-function'"
]
and syntax_multiplier = [%value.rec "'#' | '+'"]
and syntax_single_component = [%value.rec
  "'<' <syntax-type-name> '>' | <ident>"
]
and syntax_string = [%value.rec "<string>"]
and syntax_combinator = [%value.rec "'|'"]
and syntax_component = [%value.rec
  "<syntax-single-component> [ <syntax-multiplier> ]? | '<' 'transform-list' '>'"
]
and syntax = [%value.rec
  "'*' | <syntax-component> [ <syntax-combinator> <syntax-component> ]* | <syntax-string>"
]
/*
 We don't support type() yet, original spec is: "type( <syntax> ) | 'raw-string' | <attr-unit>" */
and attr_type = [%value.rec "'raw-string' | <attr-unit>"]
and x = [%value.rec "<number>"]
and y = [%value.rec "<number>"];

let apply_parser = (parser, tokens_with_loc) => {
  open Styled_ppx_css_parser.Lexer;

  let tokens =
    tokens_with_loc
    |> List.map(({txt, _}) =>
         switch (txt) {
         | Ok(token) => token
         | Error((token, _)) => token
         }
       )
    |> List.rev;

  let tokens_without_ws = tokens |> List.filter((!=)(Tokens.WS));

  let (output, remaining_tokens) = parser(tokens_without_ws);
  let.ok output =
    switch (output) {
    | Ok(data) => Ok(data)
    | Error([message, ..._]) => Error(message)
    | Error([]) => Error("weird")
    };
  let.ok () =
    switch (remaining_tokens) {
    | []
    | [Tokens.EOF] => Ok()
    | tokens =>
      let tokens =
        tokens |> List.map(Tokens.show_token) |> String.concat(", ");
      Error("tokens remaining: " ++ tokens);
    };
  Ok(output);
};

let parse = (rule_parser: Rule.rule('a), str) => {
  let.ok tokens_with_loc =
    Styled_ppx_css_parser.Lexer.from_string(str)
    |> Result.map_error(_ => "frozen");

  apply_parser(rule_parser, tokens_with_loc);
};

let check = (prop: Rule.rule('a), value) =>
  parse(prop, value) |> Result.is_ok;

/*
 Heterogeneous rule storage using first-class modules

 This solution uses existential types to store CSS property, media query, rules, abstraction and function that return different CSS parsed types in a single collection. */

type kind =
  | Abstraction(string)
  | Property(string)
  | Media_query(string)
  | Function(string);

module type RULE = {
  type result;
  let rule: Rule.rule(result);
  let name: kind;
};

let property = (type a, name: string, rule: Rule.rule(a)): (module RULE) => {
  (module
   {
     type result = a;
     let rule = rule;
     let name = Property(name);
   });
};

let mediaquery = (type a, name: string, rule: Rule.rule(a)): (module RULE) => {
  (module
   {
     type result = a;
     let rule = rule;
     let name = Media_query(name);
   });
};

let abstraction = (type a, name: string, rule: Rule.rule(a)): (module RULE) => {
  (module
   {
     type result = a;
     let rule = rule;
     let name = Abstraction(name);
   });
};

let function_ = (type a, name: string, rule: Rule.rule(a)): (module RULE) => {
  (module
   {
     type result = a;
     let rule = rule;
     let name = Function(name);
   });
};

let packed_rules: list(module RULE) = [
  abstraction("-legacy-gradient", _legacy_gradient),
  abstraction("-legacy-linear-gradient", _legacy_linear_gradient),
  abstraction(
    "-legacy-linear-gradient-arguments",
    _legacy_linear_gradient_arguments,
  ),
  abstraction("-legacy-radial-gradient", _legacy_radial_gradient),
  abstraction(
    "-legacy-radial-gradient-arguments",
    _legacy_radial_gradient_arguments,
  ),
  abstraction("-legacy-radial-gradient-shape", _legacy_radial_gradient_shape),
  abstraction("-legacy-radial-gradient-size", _legacy_radial_gradient_size),
  abstraction(
    "-legacy-repeating-linear-gradient",
    _legacy_repeating_linear_gradient,
  ),
  abstraction(
    "-legacy-repeating-radial-gradient",
    _legacy_repeating_radial_gradient,
  ),
  abstraction("-non-standard-color", _non_standard_color),
  abstraction("-non-standard-font", _non_standard_font),
  abstraction("-non-standard-image-rendering", _non_standard_image_rendering),
  abstraction("-non-standard-overflow", _non_standard_overflow),
  abstraction("-non-standard-width", _non_standard_width),
  abstraction("-webkit-gradient-color-stop", _webkit_gradient_color_stop),
  abstraction("-webkit-gradient-point", _webkit_gradient_point),
  abstraction("-webkit-gradient-radius", _webkit_gradient_radius),
  abstraction("-webkit-gradient-type", _webkit_gradient_type),
  abstraction("-webkit-mask-box-repeat", _webkit_mask_box_repeat),
  abstraction("-webkit-mask-clip-style", _webkit_mask_clip_style),
  abstraction("absolute-size", absolute_size),
  abstraction("attr-name", attr_name),
  abstraction("attr-type", attr_type),
  abstraction("attr-unit", attr_unit),
  abstraction("syntax", syntax),
  abstraction("syntax-combinator", syntax_combinator),
  abstraction("syntax-component", syntax_component),
  abstraction("syntax-multiplier", syntax_multiplier),
  abstraction("syntax-single-component", syntax_single_component),
  abstraction("syntax-string", syntax_string),
  abstraction("syntax-type-name", syntax_type_name),
  abstraction("age", age),
  abstraction("alpha-value", alpha_value),
  abstraction("angular-color-hint", angular_color_hint),
  abstraction("angular-color-stop", angular_color_stop),
  abstraction("angular-color-stop-list", angular_color_stop_list),
  abstraction("hue-interpolation-method", hue_interpolation_method),
  abstraction("polar-color-space", polar_color_space),
  abstraction("rectangular-color-space", rectangular_color_space),
  abstraction("color-interpolation-method", color_interpolation_method),
  abstraction("animateable-feature", animateable_feature),
  abstraction("attachment", attachment),
  abstraction("attr-fallback", attr_fallback),
  abstraction("attr-matcher", attr_matcher),
  abstraction("attr-modifier", attr_modifier),
  abstraction("attr-name", attr_name),
  abstraction("attribute-selector", attribute_selector),
  abstraction("auto-repeat", auto_repeat),
  abstraction("auto-track-list", auto_track_list),
  abstraction("baseline-position", baseline_position),
  abstraction("basic-shape", basic_shape),
  abstraction("bg-image", bg_image),
  abstraction("bg-layer", bg_layer),
  abstraction("bg-position", bg_position),
  abstraction("bg-size", bg_size),
  abstraction("blend-mode", blend_mode),
  abstraction("border-radius", border_radius),
  abstraction("bottom", bottom),
  abstraction("box", box),
  abstraction("calc-product", calc_product),
  abstraction("calc-sum", calc_sum),
  abstraction("calc-value", calc_value),
  abstraction("cf-final-image", cf_final_image),
  abstraction("cf-mixing-image", cf_mixing_image),
  abstraction("class-selector", class_selector),
  abstraction("clip-source", clip_source),
  abstraction("color", color),
  abstraction("color-stop", color_stop),
  abstraction("color-stop-angle", color_stop_angle),
  abstraction("color-stop-length", color_stop_length),
  abstraction("color-stop-list", color_stop_list),
  abstraction("combinator", combinator),
  abstraction("common-lig-values", common_lig_values),
  abstraction("compat-auto", compat_auto),
  abstraction("complex-selector", complex_selector),
  abstraction("complex-selector-list", complex_selector_list),
  abstraction("composite-style", composite_style),
  abstraction("compositing-operator", compositing_operator),
  abstraction("compound-selector", compound_selector),
  abstraction("compound-selector-list", compound_selector_list),
  abstraction("content-distribution", content_distribution),
  abstraction("content-list", content_list),
  abstraction("content-position", content_position),
  abstraction("content-replacement", content_replacement),
  abstraction("contextual-alt-values", contextual_alt_values),
  abstraction("counter-style", counter_style),
  abstraction("counter-style-name", counter_style_name),
  abstraction("cubic-bezier-timing-function", cubic_bezier_timing_function),
  abstraction("declaration", declaration),
  abstraction("declaration-list", declaration_list),
  abstraction("deprecated-system-color", deprecated_system_color),
  abstraction("discretionary-lig-values", discretionary_lig_values),
  abstraction("display-box", display_box),
  abstraction("display-inside", display_inside),
  abstraction("display-internal", display_internal),
  abstraction("display-legacy", display_legacy),
  abstraction("display-listitem", display_listitem),
  abstraction("display-outside", display_outside),
  abstraction("east-asian-variant-values", east_asian_variant_values),
  abstraction("east-asian-width-values", east_asian_width_values),
  abstraction("ending-shape", ending_shape),
  abstraction("explicit-track-list", explicit_track_list),
  abstraction("family-name", family_name),
  abstraction("feature-tag-value", feature_tag_value),
  abstraction("feature-type", feature_type),
  abstraction("feature-value-block", feature_value_block),
  abstraction("feature-value-block-list", feature_value_block_list),
  abstraction("feature-value-declaration", feature_value_declaration),
  abstraction(
    "feature-value-declaration-list",
    feature_value_declaration_list,
  ),
  abstraction("feature-value-name", feature_value_name),
  abstraction("fill-rule", fill_rule),
  abstraction("filter-function", filter_function),
  abstraction("filter-function-list", filter_function_list),
  abstraction("final-bg-layer", final_bg_layer),
  abstraction("fixed-breadth", fixed_breadth),
  abstraction("fixed-repeat", fixed_repeat),
  abstraction("fixed-size", fixed_size),
  abstraction("font-stretch-absolute", font_stretch_absolute),
  abstraction("font-variant-css21", font_variant_css21),
  abstraction("font-weight-absolute", font_weight_absolute),
  function_("-webkit-gradient", function__webkit_gradient),
  function_("attr", function_attr),
  function_("blur", function_blur),
  function_("brightness", function_brightness),
  function_("calc", function_calc),
  function_("circle", function_circle),
  function_("clamp", function_clamp),
  function_("conic-gradient", function_conic_gradient),
  function_("contrast", function_contrast),
  function_("counter", function_counter),
  function_("counters", function_counters),
  function_("cross-fade", function_cross_fade),
  function_("drop-shadow", function_drop_shadow),
  function_("element", function_element),
  function_("ellipse", function_ellipse),
  function_("env", function_env),
  function_("fit-content", function_fit_content),
  function_("grayscale", function_grayscale),
  function_("hsl", function_hsl),
  function_("hsla", function_hsla),
  function_("hue-rotate", function_hue_rotate),
  function_("image", function_image),
  function_("image-set", function_image_set),
  function_("inset", function_inset),
  function_("invert", function_invert),
  function_("leader", function_leader),
  function_("linear-gradient", function_linear_gradient),
  function_("matrix", function_matrix),
  function_("matrix3d", function_matrix3d),
  function_("max", function_max),
  function_("min", function_min),
  function_("minmax", function_minmax),
  function_("opacity", function_opacity),
  function_("paint", function_paint),
  function_("path", function_path),
  function_("perspective", function_perspective),
  function_("polygon", function_polygon),
  function_("radial-gradient", function_radial_gradient),
  function_("repeating-linear-gradient", function_repeating_linear_gradient),
  function_("repeating-radial-gradient", function_repeating_radial_gradient),
  function_("rgb", function_rgb),
  function_("rgba", function_rgba),
  function_("rotate", function_rotate),
  function_("rotate3d", function_rotate3d),
  function_("rotateX", function_rotateX),
  function_("rotateY", function_rotateY),
  function_("rotateZ", function_rotateZ),
  function_("saturate", function_saturate),
  function_("scale", function_scale),
  function_("scale3d", function_scale3d),
  function_("scaleX", function_scaleX),
  function_("scaleY", function_scaleY),
  function_("scaleZ", function_scaleZ),
  function_("sepia", function_sepia),
  function_("skew", function_skew),
  function_("skewX", function_skewX),
  function_("skewY", function_skewY),
  function_("symbols", function_symbols),
  function_("target-counter", function_target_counter),
  function_("target-counters", function_target_counters),
  function_("target-text", function_target_text),
  function_("translate", function_translate),
  function_("translate3d", function_translate3d),
  function_("translateX", function_translateX),
  function_("translateY", function_translateY),
  function_("translateZ", function_translateZ),
  function_("var", function_var),
  abstraction("gender", gender),
  abstraction("general-enclosed", general_enclosed),
  abstraction("generic-family", generic_family),
  abstraction("generic-name", generic_name),
  abstraction("generic-voice", generic_voice),
  abstraction("geometry-box", geometry_box),
  abstraction("gradient", gradient),
  abstraction("grid-line", grid_line),
  abstraction("historical-lig-values", historical_lig_values),
  abstraction("hue", hue),
  abstraction("id-selector", id_selector),
  abstraction("image", image),
  abstraction("image-set-option", image_set_option),
  abstraction("image-src", image_src),
  abstraction("image-tags", image_tags),
  abstraction("inflexible-breadth", inflexible_breadth),
  abstraction("keyframe-block", keyframe_block),
  abstraction("keyframe-block-list", keyframe_block_list),
  abstraction("keyframe-selector", keyframe_selector),
  abstraction("keyframes-name", keyframes_name),
  abstraction("leader-type", leader_type),
  abstraction("left", left),
  abstraction("line-name-list", line_name_list),
  abstraction("line-names", line_names),
  abstraction("line-style", line_style),
  abstraction("line-width", line_width),
  abstraction("linear-color-hint", linear_color_hint),
  abstraction("linear-color-stop", linear_color_stop),
  abstraction("mask-image", mask_image),
  abstraction("mask-layer", mask_layer),
  abstraction("mask-position", mask_position),
  abstraction("mask-reference", mask_reference),
  abstraction("mask-source", mask_source),
  abstraction("masking-mode", masking_mode),
  mediaquery("and", media_and),
  mediaquery("condition", media_condition),
  mediaquery("condition-without-or", media_condition_without_or),
  mediaquery("feature", media_feature),
  mediaquery("in-parens", media_in_parens),
  mediaquery("not", media_not),
  mediaquery("or", media_or),
  mediaquery("query", media_query),
  mediaquery("query-list", media_query_list),
  mediaquery("type", media_type),
  abstraction("mf-boolean", mf_boolean),
  abstraction("mf-name", mf_name),
  abstraction("mf-plain", mf_plain),
  abstraction("mf-range", mf_range),
  abstraction("mf-value", mf_value),
  abstraction("name-repeat", name_repeat),
  abstraction("named-color", named_color),
  abstraction("namespace-prefix", namespace_prefix),
  abstraction("ns-prefix", ns_prefix),
  abstraction("nth", nth),
  abstraction("number-one-or-greater", number_one_or_greater),
  abstraction("number-percentage", number_percentage),
  abstraction("alpha-value", number_zero_one),
  abstraction("numeric-figure-values", numeric_figure_values),
  abstraction("numeric-fraction-values", numeric_fraction_values),
  abstraction("numeric-spacing-values", numeric_spacing_values),
  abstraction("outline-radius", outline_radius),
  abstraction("overflow-position", overflow_position),
  abstraction("page-body", page_body),
  abstraction("page-margin-box", page_margin_box),
  abstraction("page-margin-box-type", page_margin_box_type),
  abstraction("page-selector", page_selector),
  abstraction("page-selector-list", page_selector_list),
  abstraction("paint", paint),
  abstraction("position", position),
  abstraction("positive-integer", positive_integer),
  property("-moz-appearance", property__moz_appearance),
  property("-moz-background-clip", property__moz_background_clip),
  property("-moz-binding", property__moz_binding),
  property("-moz-border-bottom-colors", property__moz_border_bottom_colors),
  property("-moz-border-left-colors", property__moz_border_left_colors),
  property(
    "-moz-border-radius-bottomleft",
    property__moz_border_radius_bottomleft,
  ),
  property(
    "-moz-border-radius-bottomright",
    property__moz_border_radius_bottomright,
  ),
  property("-moz-border-radius-topleft", property__moz_border_radius_topleft),
  property(
    "-moz-border-radius-topright",
    property__moz_border_radius_topright,
  ),
  property("-moz-border-right-colors", property__moz_border_right_colors),
  property("-moz-border-top-colors", property__moz_border_top_colors),
  property("-moz-context-properties", property__moz_context_properties),
  property(
    "-moz-control-character-visibility",
    property__moz_control_character_visibility,
  ),
  property("-moz-float-edge", property__moz_float_edge),
  property(
    "-moz-force-broken-image-icon",
    property__moz_force_broken_image_icon,
  ),
  property("-moz-image-region", property__moz_image_region),
  property("-moz-orient", property__moz_orient),
  property("-moz-osx-font-smoothing", property__moz_osx_font_smoothing),
  property("-moz-outline-radius", property__moz_outline_radius),
  property(
    "-moz-outline-radius-bottomleft",
    property__moz_outline_radius_bottomleft,
  ),
  property(
    "-moz-outline-radius-bottomright",
    property__moz_outline_radius_bottomright,
  ),
  property(
    "-moz-outline-radius-topleft",
    property__moz_outline_radius_topleft,
  ),
  property(
    "-moz-outline-radius-topright",
    property__moz_outline_radius_topright,
  ),
  property("-moz-stack-sizing", property__moz_stack_sizing),
  property("-moz-text-blink", property__moz_text_blink),
  property("-moz-user-focus", property__moz_user_focus),
  property("-moz-user-input", property__moz_user_input),
  property("-moz-user-modify", property__moz_user_modify),
  property("-moz-user-select", property__moz_user_select),
  property("-moz-window-dragging", property__moz_window_dragging),
  property("-moz-window-shadow", property__moz_window_shadow),
  property("-webkit-appearance", property__webkit_appearance),
  property("-webkit-background-clip", property__webkit_background_clip),
  property("-webkit-border-before", property__webkit_border_before),
  property(
    "-webkit-border-before-color",
    property__webkit_border_before_color,
  ),
  property(
    "-webkit-border-before-style",
    property__webkit_border_before_style,
  ),
  property(
    "-webkit-border-before-width",
    property__webkit_border_before_width,
  ),
  property("-webkit-box-reflect", property__webkit_box_reflect),
  property("-webkit-box-shadow", property_box_shadow),
  property("-webkit-box-orient", property_box_orient),
  property("-webkit-column-break-after", property__webkit_column_break_after),
  property(
    "-webkit-column-break-before",
    property__webkit_column_break_before,
  ),
  property(
    "-webkit-column-break-inside",
    property__webkit_column_break_inside,
  ),
  property("-webkit-font-smoothing", property__webkit_font_smoothing),
  property("-webkit-line-clamp", property__webkit_line_clamp),
  property("-webkit-mask", property__webkit_mask),
  property("-webkit-mask-attachment", property__webkit_mask_attachment),
  property("-webkit-mask-box-image", property__webkit_mask_box_image),
  property("-webkit-mask-clip", property__webkit_mask_clip),
  property("-webkit-mask-composite", property__webkit_mask_composite),
  property("-webkit-mask-image", property__webkit_mask_image),
  property("-webkit-mask-origin", property__webkit_mask_origin),
  property("-webkit-mask-position", property__webkit_mask_position),
  property("-webkit-mask-position-x", property__webkit_mask_position_x),
  property("-webkit-mask-position-y", property__webkit_mask_position_y),
  property("-webkit-mask-repeat", property__webkit_mask_repeat),
  property("-webkit-mask-repeat-x", property__webkit_mask_repeat_x),
  property("-webkit-mask-repeat-y", property__webkit_mask_repeat_y),
  property("-webkit-mask-size", property__webkit_mask_size),
  property("-webkit-overflow-scrolling", property__webkit_overflow_scrolling),
  property("-webkit-print-color-adjust", property__webkit_print_color_adjust),
  property(
    "-webkit-tap-highlight-color",
    property__webkit_tap_highlight_color,
  ),
  property("-webkit-text-fill-color", property__webkit_text_fill_color),
  property("-webkit-text-security", property__webkit_text_security),
  property("-webkit-text-stroke", property__webkit_text_stroke),
  property("-webkit-text-stroke-color", property__webkit_text_stroke_color),
  property("-webkit-text-stroke-width", property__webkit_text_stroke_width),
  property("-webkit-touch-callout", property__webkit_touch_callout),
  property("-webkit-user-drag", property__webkit_user_drag),
  property("-webkit-user-modify", property__webkit_user_modify),
  property("-webkit-user-select", property__webkit_user_select),
  property("align-content", property_align_content),
  property("align-items", property_align_items),
  property("align-self", property_align_self),
  property("alignment-baseline", property_alignment_baseline),
  property("all", property_all),
  property("animation", property_animation),
  property("animation-delay", property_animation_delay),
  property("animation-direction", property_animation_direction),
  property("animation-duration", property_animation_duration),
  property("animation-fill-mode", property_animation_fill_mode),
  property("animation-iteration-count", property_animation_iteration_count),
  property("animation-name", property_animation_name),
  property("animation-play-state", property_animation_play_state),
  property("animation-timing-function", property_animation_timing_function),
  property("appearance", property_appearance),
  property("aspect-ratio", property_aspect_ratio),
  property("azimuth", property_azimuth),
  property("backdrop-filter", property_backdrop_filter),
  property("backface-visibility", property_backface_visibility),
  property("background", property_background),
  property("background-attachment", property_background_attachment),
  property("background-blend-mode", property_background_blend_mode),
  property("background-clip", property_background_clip),
  property("background-color", property_background_color),
  property("background-image", property_background_image),
  property("background-origin", property_background_origin),
  property("background-position", property_background_position),
  property("background-position-x", property_background_position_x),
  property("background-position-y", property_background_position_y),
  property("background-repeat", property_background_repeat),
  property("background-size", property_background_size),
  property("baseline-shift", property_baseline_shift),
  property("behavior", property_behavior),
  property("block-overflow", property_block_overflow),
  property("block-size", property_block_size),
  property("border", property_border),
  property("border-block", property_border_block),
  property("border-block-color", property_border_block_color),
  property("border-block-end", property_border_block_end),
  property("border-block-end-color", property_border_block_end_color),
  property("border-block-end-style", property_border_block_end_style),
  property("border-block-end-width", property_border_block_end_width),
  property("border-block-start", property_border_block_start),
  property("border-block-start-color", property_border_block_start_color),
  property("border-block-start-style", property_border_block_start_style),
  property("border-block-start-width", property_border_block_start_width),
  property("border-block-style", property_border_block_style),
  property("border-block-width", property_border_block_width),
  property("border-bottom", property_border_bottom),
  property("border-bottom-color", property_border_bottom_color),
  property("border-bottom-left-radius", property_border_bottom_left_radius),
  property("border-bottom-right-radius", property_border_bottom_right_radius),
  property("border-bottom-style", property_border_bottom_style),
  property("border-bottom-width", property_border_bottom_width),
  property("border-collapse", property_border_collapse),
  property("border-color", property_border_color),
  property("border-end-end-radius", property_border_end_end_radius),
  property("border-end-start-radius", property_border_end_start_radius),
  property("border-image", property_border_image),
  property("border-image-outset", property_border_image_outset),
  property("border-image-repeat", property_border_image_repeat),
  property("border-image-slice", property_border_image_slice),
  property("border-image-source", property_border_image_source),
  property("border-image-width", property_border_image_width),
  property("border-inline", property_border_inline),
  property("border-inline-color", property_border_inline_color),
  property("border-inline-end", property_border_inline_end),
  property("border-inline-end-color", property_border_inline_end_color),
  property("border-inline-end-style", property_border_inline_end_style),
  property("border-inline-end-width", property_border_inline_end_width),
  property("border-inline-start", property_border_inline_start),
  property("border-inline-start-color", property_border_inline_start_color),
  property("border-inline-start-style", property_border_inline_start_style),
  property("border-inline-start-width", property_border_inline_start_width),
  property("border-inline-style", property_border_inline_style),
  property("border-inline-width", property_border_inline_width),
  property("border-left", property_border_left),
  property("border-left-color", property_border_left_color),
  property("border-left-style", property_border_left_style),
  property("border-left-width", property_border_left_width),
  property("border-radius", property_border_radius),
  property("border-right", property_border_right),
  property("border-right-color", property_border_right_color),
  property("border-right-style", property_border_right_style),
  property("border-right-width", property_border_right_width),
  property("border-spacing", property_border_spacing),
  property("border-start-end-radius", property_border_start_end_radius),
  property("border-start-start-radius", property_border_start_start_radius),
  property("border-style", property_border_style),
  property("border-top", property_border_top),
  property("border-top-color", property_border_top_color),
  property("border-top-left-radius", property_border_top_left_radius),
  property("border-top-right-radius", property_border_top_right_radius),
  property("border-top-style", property_border_top_style),
  property("border-top-width", property_border_top_width),
  property("border-width", property_border_width),
  property("bottom", property_bottom),
  property("box-align", property_box_align),
  property("box-decoration-break", property_box_decoration_break),
  property("box-direction", property_box_direction),
  property("box-flex", property_box_flex),
  property("box-flex-group", property_box_flex_group),
  property("box-lines", property_box_lines),
  property("box-ordinal-group", property_box_ordinal_group),
  property("box-orient", property_box_orient),
  property("box-pack", property_box_pack),
  property("box-shadow", property_box_shadow),
  property("box-sizing", property_box_sizing),
  property("break-after", property_break_after),
  property("break-before", property_break_before),
  property("break-inside", property_break_inside),
  property("caption-side", property_caption_side),
  property("caret-color", property_caret_color),
  property("clear", property_clear),
  property("clip", property_clip),
  property("clip-path", property_clip_path),
  property("clip-rule", property_clip_rule),
  property("color", property_color),
  property("color-adjust", property_color_adjust),
  property("color-scheme", property_color_scheme),
  property("column-count", property_column_count),
  property("column-fill", property_column_fill),
  property("column-gap", property_column_gap),
  property("column-rule", property_column_rule),
  property("column-rule-color", property_column_rule_color),
  property("column-rule-style", property_column_rule_style),
  property("column-rule-width", property_column_rule_width),
  property("column-span", property_column_span),
  property("column-width", property_column_width),
  property("columns", property_columns),
  property("contain", property_contain),
  property("content", property_content),
  property("counter-increment", property_counter_increment),
  property("counter-reset", property_counter_reset),
  property("counter-set", property_counter_set),
  property("cue", property_cue),
  property("cue-after", property_cue_after),
  property("cue-before", property_cue_before),
  property("cursor", property_cursor),
  property("direction", property_direction),
  property("display", property_display),
  property("dominant-baseline", property_dominant_baseline),
  property("empty-cells", property_empty_cells),
  property("fill", property_fill),
  property("fill-opacity", property_fill_opacity),
  property("fill-rule", property_fill_rule),
  property("filter", property_filter),
  property("flex", property_flex),
  property("flex-basis", property_flex_basis),
  property("flex-direction", property_flex_direction),
  property("flex-flow", property_flex_flow),
  property("flex-grow", property_flex_grow),
  property("flex-shrink", property_flex_shrink),
  property("flex-wrap", property_flex_wrap),
  property("float", property_float),
  property("font", property_font),
  property("font-family", property_font_family),
  property("font-feature-settings", property_font_feature_settings),
  property("font-kerning", property_font_kerning),
  property("font-language-override", property_font_language_override),
  property("font-optical-sizing", property_font_optical_sizing),
  property("font-palette", property_font_palette),
  property("font-variant-emoji", property_font_variant_emoji),
  property("font-size", property_font_size),
  property("font-size-adjust", property_font_size_adjust),
  property("font-smooth", property_font_smooth),
  property("font-stretch", property_font_stretch),
  property("font-style", property_font_style),
  property("font-synthesis", property_font_synthesis),
  property("font-synthesis-weight", property_font_synthesis_weight),
  property("font-synthesis-style", property_font_synthesis_style),
  property("font-synthesis-small-caps", property_font_synthesis_small_caps),
  property("font-synthesis-position", property_font_synthesis_position),
  property("font-variant", property_font_variant),
  property("font-variant-alternates", property_font_variant_alternates),
  property("font-variant-caps", property_font_variant_caps),
  property("font-variant-east-asian", property_font_variant_east_asian),
  property("font-variant-ligatures", property_font_variant_ligatures),
  property("font-variant-numeric", property_font_variant_numeric),
  property("font-variant-position", property_font_variant_position),
  property("font-variation-settings", property_font_variation_settings),
  property("font-weight", property_font_weight),
  property("gap", property_gap),
  property(
    "glyph-orientation-horizontal",
    property_glyph_orientation_horizontal,
  ),
  property("glyph-orientation-vertical", property_glyph_orientation_vertical),
  property("grid", property_grid),
  property("grid-area", property_grid_area),
  property("grid-auto-columns", property_grid_auto_columns),
  property("grid-auto-flow", property_grid_auto_flow),
  property("grid-auto-rows", property_grid_auto_rows),
  property("grid-column", property_grid_column),
  property("grid-column-end", property_grid_column_end),
  property("grid-column-gap", property_grid_column_gap),
  property("grid-column-start", property_grid_column_start),
  property("grid-gap", property_grid_gap),
  property("grid-row", property_grid_row),
  property("grid-row-end", property_grid_row_end),
  property("grid-row-gap", property_grid_row_gap),
  property("grid-row-start", property_grid_row_start),
  property("grid-template", property_grid_template),
  property("grid-template-areas", property_grid_template_areas),
  property("grid-template-columns", property_grid_template_columns),
  property("grid-template-rows", property_grid_template_rows),
  property("hanging-punctuation", property_hanging_punctuation),
  property("height", property_height),
  property("hyphens", property_hyphens),
  property("image-orientation", property_image_orientation),
  property("image-rendering", property_image_rendering),
  property("image-resolution", property_image_resolution),
  property("ime-mode", property_ime_mode),
  property("initial-letter", property_initial_letter),
  property("initial-letter-align", property_initial_letter_align),
  property("inline-size", property_inline_size),
  property("inset", property_inset),
  property("inset-block", property_inset_block),
  property("inset-block-end", property_inset_block_end),
  property("inset-block-start", property_inset_block_start),
  property("inset-inline", property_inset_inline),
  property("inset-inline-end", property_inset_inline_end),
  property("inset-inline-start", property_inset_inline_start),
  property("isolation", property_isolation),
  property("justify-content", property_justify_content),
  property("justify-items", property_justify_items),
  property("justify-self", property_justify_self),
  property("kerning", property_kerning),
  property("left", property_left),
  property("letter-spacing", property_letter_spacing),
  property("line-break", property_line_break),
  property("line-clamp", property_line_clamp),
  property("line-height", property_line_height),
  property("line-height-step", property_line_height_step),
  property("list-style", property_list_style),
  property("list-style-image", property_list_style_image),
  property("list-style-position", property_list_style_position),
  property("list-style-type", property_list_style_type),
  property("margin", property_margin),
  property("margin-block", property_margin_block),
  property("margin-block-end", property_margin_block_end),
  property("margin-block-start", property_margin_block_start),
  property("margin-bottom", property_margin_bottom),
  property("margin-inline", property_margin_inline),
  property("margin-inline-end", property_margin_inline_end),
  property("margin-inline-start", property_margin_inline_start),
  property("margin-left", property_margin_left),
  property("margin-right", property_margin_right),
  property("margin-top", property_margin_top),
  property("margin-trim", property_margin_trim),
  property("marker", property_marker),
  property("marker-end", property_marker_end),
  property("marker-mid", property_marker_mid),
  property("marker-start", property_marker_start),
  property("mask", property_mask),
  property("mask-border", property_mask_border),
  property("mask-border-mode", property_mask_border_mode),
  property("mask-border-outset", property_mask_border_outset),
  property("mask-border-repeat", property_mask_border_repeat),
  property("mask-border-slice", property_mask_border_slice),
  property("mask-border-source", property_mask_border_source),
  property("mask-border-width", property_mask_border_width),
  property("mask-clip", property_mask_clip),
  property("mask-composite", property_mask_composite),
  property("mask-image", property_mask_image),
  property("mask-mode", property_mask_mode),
  property("mask-origin", property_mask_origin),
  property("mask-position", property_mask_position),
  property("mask-repeat", property_mask_repeat),
  property("mask-size", property_mask_size),
  property("mask-type", property_mask_type),
  property("masonry-auto-flow", property_masonry_auto_flow),
  property("max-block-size", property_max_block_size),
  property("max-height", property_max_height),
  property("max-inline-size", property_max_inline_size),
  property("max-lines", property_max_lines),
  property("max-width", property_max_width),
  property("min-block-size", property_min_block_size),
  property("min-height", property_min_height),
  property("min-inline-size", property_min_inline_size),
  property("min-width", property_min_width),
  property("mix-blend-mode", property_mix_blend_mode),
  property("object-fit", property_object_fit),
  property("object-position", property_object_position),
  property("offset", property_offset),
  property("offset-anchor", property_offset_anchor),
  property("offset-distance", property_offset_distance),
  property("offset-path", property_offset_path),
  property("offset-position", property_offset_position),
  property("offset-rotate", property_offset_rotate),
  property("opacity", property_opacity),
  property("order", property_order),
  property("orphans", property_orphans),
  property("outline", property_outline),
  property("outline-color", property_outline_color),
  property("outline-offset", property_outline_offset),
  property("outline-style", property_outline_style),
  property("outline-width", property_outline_width),
  property("overflow", property_overflow),
  property("overflow-anchor", property_overflow_anchor),
  property("overflow-block", property_overflow_block),
  property("overflow-clip-margin", property_overflow_clip_margin),
  property("overflow-inline", property_overflow_inline),
  property("overflow-wrap", property_overflow_wrap),
  property("overflow-x", property_overflow_x),
  property("overflow-y", property_overflow_y),
  property("overscroll-behavior", property_overscroll_behavior),
  property("overscroll-behavior-block", property_overscroll_behavior_block),
  property("overscroll-behavior-inline", property_overscroll_behavior_inline),
  property("overscroll-behavior-x", property_overscroll_behavior_x),
  property("overscroll-behavior-y", property_overscroll_behavior_y),
  property("any-hover", property_media_any_hover),
  property("any-pointer", property_media_any_pointer),
  property("pointer", property_media_pointer),
  property("max-aspect-ratio", property_media_max_aspect_ratio),
  property("min-aspect-ratio", property_media_min_aspect_ratio),
  property("min-color", property_media_min_color),
  property("color-gamut", property_media_color_gamut),
  property("color-index", property_media_color_index),
  property("min-color-index", property_media_min_color_index),
  property("display-mode", property_media_display_mode),
  property("forced-colors", property_media_forced_colors),
  property("forced-color-adjust", property_forced_color_adjust),
  property("grid", property_media_grid),
  property("hover", property_media_hover),
  property("inverted-colors", property_media_inverted_colors),
  property("monochrome", property_media_monochrome),
  property("prefers-color-scheme", property_media_prefers_color_scheme),
  property("prefers-contrast", property_media_prefers_contrast),
  property("prefers-reduced-motion", property_media_prefers_reduced_motion),
  property("resolution", property_media_resolution),
  property("min-resolution", property_media_min_resolution),
  property("max-resolution", property_media_max_resolution),
  property("scripting", property_media_scripting),
  property("update", property_media_update),
  property("orientation", property_media_orientation),
  property("padding", property_padding),
  property("padding-block", property_padding_block),
  property("padding-block-end", property_padding_block_end),
  property("padding-block-start", property_padding_block_start),
  property("padding-bottom", property_padding_bottom),
  property("padding-inline", property_padding_inline),
  property("padding-inline-end", property_padding_inline_end),
  property("padding-inline-start", property_padding_inline_start),
  property("padding-left", property_padding_left),
  property("padding-right", property_padding_right),
  property("padding-top", property_padding_top),
  property("page-break-after", property_page_break_after),
  property("page-break-before", property_page_break_before),
  property("page-break-inside", property_page_break_inside),
  property("paint-order", property_paint_order),
  property("pause", property_pause),
  property("pause-after", property_pause_after),
  property("pause-before", property_pause_before),
  property("perspective", property_perspective),
  property("perspective-origin", property_perspective_origin),
  property("place-content", property_place_content),
  property("place-items", property_place_items),
  property("place-self", property_place_self),
  property("pointer-events", property_pointer_events),
  property("position", property_position),
  property("quotes", property_quotes),
  property("resize", property_resize),
  property("rest", property_rest),
  property("rest-after", property_rest_after),
  property("rest-before", property_rest_before),
  property("right", property_right),
  property("rotate", property_rotate),
  property("row-gap", property_row_gap),
  property("ruby-align", property_ruby_align),
  property("ruby-merge", property_ruby_merge),
  property("ruby-position", property_ruby_position),
  property("scale", property_scale),
  property("scroll-behavior", property_scroll_behavior),
  property("scroll-margin", property_scroll_margin),
  property("scroll-margin-block", property_scroll_margin_block),
  property("scroll-margin-block-end", property_scroll_margin_block_end),
  property("scroll-margin-block-start", property_scroll_margin_block_start),
  property("scroll-margin-bottom", property_scroll_margin_bottom),
  property("scroll-margin-inline", property_scroll_margin_inline),
  property("scroll-margin-inline-end", property_scroll_margin_inline_end),
  property("scroll-margin-inline-start", property_scroll_margin_inline_start),
  property("scroll-margin-left", property_scroll_margin_left),
  property("scroll-margin-right", property_scroll_margin_right),
  property("scroll-margin-top", property_scroll_margin_top),
  property("scroll-padding", property_scroll_padding),
  property("scroll-padding-block", property_scroll_padding_block),
  property("scroll-padding-block-end", property_scroll_padding_block_end),
  property("scroll-padding-block-start", property_scroll_padding_block_start),
  property("scroll-padding-bottom", property_scroll_padding_bottom),
  property("scroll-padding-inline", property_scroll_padding_inline),
  property("scroll-padding-inline-end", property_scroll_padding_inline_end),
  property(
    "scroll-padding-inline-start",
    property_scroll_padding_inline_start,
  ),
  property("scroll-padding-left", property_scroll_padding_left),
  property("scroll-padding-right", property_scroll_padding_right),
  property("scroll-padding-top", property_scroll_padding_top),
  property("scroll-snap-align", property_scroll_snap_align),
  property("scroll-snap-coordinate", property_scroll_snap_coordinate),
  property("scroll-snap-destination", property_scroll_snap_destination),
  property("scroll-snap-points-x", property_scroll_snap_points_x),
  property("scroll-snap-points-y", property_scroll_snap_points_y),
  property("scroll-snap-stop", property_scroll_snap_stop),
  property("scroll-snap-type", property_scroll_snap_type),
  property("scroll-snap-type-x", property_scroll_snap_type_x),
  property("scroll-snap-type-y", property_scroll_snap_type_y),
  property("scrollbar-color", property_scrollbar_color),
  property("scrollbar-width", property_scrollbar_width),
  property("scrollbar-gutter", property_scrollbar_gutter),
  property("shape-image-threshold", property_shape_image_threshold),
  property("shape-margin", property_shape_margin),
  property("shape-outside", property_shape_outside),
  property("shape-rendering", property_shape_rendering),
  property("speak", property_speak),
  property("speak-as", property_speak_as),
  property("src", property_src),
  property("stroke", property_stroke),
  property("stroke-dasharray", property_stroke_dasharray),
  property("stroke-dashoffset", property_stroke_dashoffset),
  property("stroke-linecap", property_stroke_linecap),
  property("stroke-linejoin", property_stroke_linejoin),
  property("stroke-miterlimit", property_stroke_miterlimit),
  property("stroke-opacity", property_stroke_opacity),
  property("stroke-width", property_stroke_width),
  property("tab-size", property_tab_size),
  property("table-layout", property_table_layout),
  property("text-align", property_text_align),
  property("text-align-all", property_text_align_all),
  property("text-align-last", property_text_align_last),
  property("text-anchor", property_text_anchor),
  property("text-combine-upright", property_text_combine_upright),
  property("text-decoration", property_text_decoration),
  property("text-decoration-color", property_text_decoration_color),
  property("text-decoration-line", property_text_decoration_line),
  property("text-decoration-skip", property_text_decoration_skip),
  property("text-decoration-skip-ink", property_text_decoration_skip_ink),
  property("text-decoration-skip-box", property_text_decoration_skip_box),
  property("text-decoration-skip-inset", property_text_decoration_skip_inset),
  property("text-decoration-style", property_text_decoration_style),
  property("text-decoration-thickness", property_text_decoration_thickness),
  property("text-emphasis", property_text_emphasis),
  property("text-emphasis-color", property_text_emphasis_color),
  property("text-emphasis-position", property_text_emphasis_position),
  property("text-emphasis-style", property_text_emphasis_style),
  property("text-indent", property_text_indent),
  property("text-justify", property_text_justify),
  property("text-orientation", property_text_orientation),
  property("text-overflow", property_text_overflow),
  property("text-rendering", property_text_rendering),
  property("text-shadow", property_text_shadow),
  property("text-size-adjust", property_text_size_adjust),
  property("text-transform", property_text_transform),
  property("text-underline-offset", property_text_underline_offset),
  property("text-underline-position", property_text_underline_position),
  property("top", property_top),
  property("touch-action", property_touch_action),
  property("transform", property_transform),
  property("transform-box", property_transform_box),
  property("transform-origin", property_transform_origin),
  property("transform-style", property_transform_style),
  property("transition", property_transition),
  property("transition-behavior", property_transition_behavior),
  property("transition-delay", property_transition_delay),
  property("transition-duration", property_transition_duration),
  property("transition-property", property_transition_property),
  property("transition-timing-function", property_transition_timing_function),
  property("translate", property_translate),
  property("unicode-bidi", property_unicode_bidi),
  property("unicode-range", property_unicode_range),
  property("user-select", property_user_select),
  property("vertical-align", property_vertical_align),
  property("visibility", property_visibility),
  property("voice-balance", property_voice_balance),
  property("voice-duration", property_voice_duration),
  property("voice-family", property_voice_family),
  property("voice-pitch", property_voice_pitch),
  property("voice-range", property_voice_range),
  property("voice-rate", property_voice_rate),
  property("voice-stress", property_voice_stress),
  property("voice-volume", property_voice_volume),
  property("white-space", property_white_space),
  property("widows", property_widows),
  property("width", property_width),
  property("will-change", property_will_change),
  property("word-break", property_word_break),
  property("word-spacing", property_word_spacing),
  property("word-wrap", property_word_wrap),
  property("writing-mode", property_writing_mode),
  property("z-index", property_z_index),
  property("zoom", property_zoom),
  property("container", property_container),
  property("container-name", property_container_name),
  property("container-type", property_container_type),
  abstraction("pseudo-class-selector", pseudo_class_selector),
  abstraction("pseudo-element-selector", pseudo_element_selector),
  abstraction("pseudo-page", pseudo_page),
  abstraction("quote", quote),
  abstraction("ratio", ratio),
  abstraction("relative-selector", relative_selector),
  abstraction("relative-selector-list", relative_selector_list),
  abstraction("relative-size", relative_size),
  abstraction("repeat-style", repeat_style),
  abstraction("right", right),
  abstraction("self-position", self_position),
  abstraction("shadow", shadow),
  abstraction("shadow-t", shadow_t),
  abstraction("shape", shape),
  abstraction("shape-box", shape_box),
  abstraction("shape-radius", shape_radius),
  abstraction("side-or-corner", side_or_corner),
  abstraction("single-animation", single_animation),
  abstraction("font-families", font_families),
  abstraction("single-animation-direction", single_animation_direction),
  abstraction("single-animation-fill-mode", single_animation_fill_mode),
  abstraction(
    "single-animation-iteration-count",
    single_animation_iteration_count,
  ),
  abstraction("single-animation-play-state", single_animation_play_state),
  abstraction("single-transition", single_transition),
  abstraction("single-transition-property", single_transition_property),
  abstraction("size", size),
  abstraction("ray-size", ray_size),
  abstraction("radial-size", radial_size),
  abstraction("step-position", step_position),
  abstraction("step-timing-function", step_timing_function),
  abstraction("subclass-selector", subclass_selector),
  abstraction("supports-condition", supports_condition),
  abstraction("supports-decl", supports_decl),
  abstraction("supports-feature", supports_feature),
  abstraction("supports-in-parens", supports_in_parens),
  abstraction("supports-selector-fn", supports_selector_fn),
  abstraction("svg-length", svg_length),
  abstraction("svg-writing-mode", svg_writing_mode),
  abstraction("symbol", symbol),
  abstraction("symbols-type", symbols_type),
  abstraction("target", target),
  abstraction("timing-function", timing_function),
  abstraction("top", top),
  abstraction("track-breadth", track_breadth),
  abstraction("track-group", track_group),
  abstraction("track-list", track_list),
  abstraction("track-list-v0", track_list_v0),
  abstraction("track-minmax", track_minmax),
  abstraction("track-repeat", track_repeat),
  abstraction("track-size", track_size),
  abstraction("transform-function", transform_function),
  abstraction("transform-list", transform_list),
  abstraction("type-or-unit", type_or_unit),
  abstraction("type-selector", type_selector),
  abstraction("viewport-length", viewport_length),
  abstraction("wq-name", wq_name),
  abstraction("x", x),
  abstraction("y", y),
  /* TODO: calc needs to be available in length */
  abstraction("extended-length", extended_length),
  abstraction("extended-frequency", extended_frequency),
  abstraction("extended-angle", extended_angle),
  abstraction("extended-time", extended_time),
  abstraction("extended-percentage", extended_percentage),
];

/* Apply a packed rule to tokens and check if it's valid */
let apply_packed_rule = (packed_rule, tokens) => {
  module R = (val packed_rule: RULE);
  let (result, remaining) = R.rule(tokens);
  (R.name, Result.is_ok(result), remaining);
};

let find_rule = (property: string) => {
  packed_rules
  |> List.find_opt(packed_rule => {
       module R = (val packed_rule: RULE);
       switch (R.name) {
       | Property(name) => property == name
       | _ => false
       };
     });
};

/* let apply_rule_by_name = (name, tokens) => {
     find_rule_by_name(name)
     |> Option.map(rule => apply_packed_rule(rule, tokens));
   }; */

let check_rule = (packed_rule, value) => {
  module R = (val packed_rule: RULE);
  parse(R.rule, value) |> Result.is_ok;
};

let check_property = (~name, value)
    : result(
        unit,
        [>
          | `Invalid_value(string)
          | `Property_not_found
        ],
      ) => {
  switch (find_rule(name)) {
  | Some(rule) =>
    module R = (val rule: RULE);
    switch (parse(R.rule, value)) {
    | Ok(_) => Ok()
    | Error(message) => Error(`Invalid_value(message))
    };
  | None => Error(`Property_not_found)
  };
};
