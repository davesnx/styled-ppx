open Standard
open Modifier
open Rule.Match
open Styled_ppx_css_parser

let rec _legacy_gradient =
  [%value.rec
    "<-webkit-gradient()> | <-legacy-linear-gradient> | \
     <-legacy-repeating-linear-gradient> | <-legacy-radial-gradient> | \
     <-legacy-repeating-radial-gradient>"]

and _legacy_linear_gradient =
  [%value.rec
    "-moz-linear-gradient( <-legacy-linear-gradient-arguments> ) | \
     -webkit-linear-gradient( <-legacy-linear-gradient-arguments> ) | \
     -o-linear-gradient( <-legacy-linear-gradient-arguments> )"]

and _legacy_linear_gradient_arguments =
  [%value.rec "[ <extended-angle> | <side-or-corner> ]? ',' <color-stop-list>"]

and _legacy_radial_gradient =
  [%value.rec
    "-moz-radial-gradient( <-legacy-radial-gradient-arguments> ) | \
     -webkit-radial-gradient( <-legacy-radial-gradient-arguments> ) | \
     -o-radial-gradient( <-legacy-radial-gradient-arguments> )"]

and _legacy_radial_gradient_arguments =
  [%value.rec
    "[ <position> ',' ]? [ [ <-legacy-radial-gradient-shape> || \
     <-legacy-radial-gradient-size> | [ <extended-length> | \
     <extended-percentage> ]{2} ] ',' ]? <color-stop-list>"]

and _legacy_radial_gradient_shape = [%value.rec "'circle' | 'ellipse'"]

and _legacy_radial_gradient_size =
  [%value.rec
    "'closest-side' | 'closest-corner' | 'farthest-side' | 'farthest-corner' | \
     'contain' | 'cover'"]

and _legacy_repeating_linear_gradient =
  [%value.rec
    "-moz-repeating-linear-gradient( <-legacy-linear-gradient-arguments> ) | \
     -webkit-repeating-linear-gradient( <-legacy-linear-gradient-arguments> ) \
     | -o-repeating-linear-gradient( <-legacy-linear-gradient-arguments> )"]

and _legacy_repeating_radial_gradient =
  [%value.rec
    "-moz-repeating-radial-gradient( <-legacy-radial-gradient-arguments> ) | \
     -webkit-repeating-radial-gradient( <-legacy-radial-gradient-arguments> ) \
     | -o-repeating-radial-gradient( <-legacy-radial-gradient-arguments> )"]

and _non_standard_color =
  [%value.rec
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
     '-moz-MenuBarText' | '-moz-MenuBarHoverText' | '-moz-nativehyperlinktext' \
     | '-moz-OddTreeRow' | '-moz-win-communicationstext' | \
     '-moz-win-mediatext' | '-moz-activehyperlinktext' | \
     '-moz-default-background-color' | '-moz-default-color' | \
     '-moz-hyperlinktext' | '-moz-visitedhyperlinktext' | '-webkit-activelink' \
     | '-webkit-focus-ring-color' | '-webkit-link' | '-webkit-text'"]

and _non_standard_font =
  [%value.rec
    "'-apple-system-body' | '-apple-system-headline' | \
     '-apple-system-subheadline' | '-apple-system-caption1' | \
     '-apple-system-caption2' | '-apple-system-footnote' | \
     '-apple-system-short-body' | '-apple-system-short-headline' | \
     '-apple-system-short-subheadline' | '-apple-system-short-caption1' | \
     '-apple-system-short-footnote' | '-apple-system-tall-body'"]

and _non_standard_image_rendering =
  [%value.rec
    "'optimize-contrast' | '-moz-crisp-edges' | '-o-crisp-edges' | \
     '-webkit-optimize-contrast'"]

and _non_standard_overflow =
  [%value.rec
    "'-moz-scrollbars-none' | '-moz-scrollbars-horizontal' | \
     '-moz-scrollbars-vertical' | '-moz-hidden-unscrollable'"]

and _non_standard_width =
  [%value.rec
    "'min-intrinsic' | 'intrinsic' | '-moz-min-content' | '-moz-max-content' | \
     '-webkit-min-content' | '-webkit-max-content'"]

and _webkit_gradient_color_stop =
  [%value.rec
    "from( <color> ) | color-stop( [ <alpha-value> | <extended-percentage> ] \
     ',' <color> ) | to( <color> )"]

and _webkit_gradient_point =
  [%value.rec
    "[ 'left' | 'center' | 'right' | <extended-length> | <extended-percentage> \
     ] [ 'top' | 'center' | 'bottom' | <extended-length> | \
     <extended-percentage> ]"]

and _webkit_gradient_radius =
  [%value.rec "<extended-length> | <extended-percentage>"]

and _webkit_gradient_type = [%value.rec "'linear' | 'radial'"]
and _webkit_mask_box_repeat = [%value.rec "'repeat' | 'stretch' | 'round'"]

and _webkit_mask_clip_style =
  [%value.rec
    "'border' | 'border-box' | 'padding' | 'padding-box' | 'content' | \
     'content-box' | 'text'"]

and absolute_size =
  [%value.rec
    "'xx-small' | 'x-small' | 'small' | 'medium' | 'large' | 'x-large' | \
     'xx-large' | 'xxx-large'"]

and age = [%value.rec "'child' | 'young' | 'old'"]
and alpha_value = [%value.rec "<number> | <extended-percentage>"]
and angular_color_hint = [%value.rec "<extended-angle> | <extended-percentage>"]
and angular_color_stop = [%value.rec "<color> && [ <color-stop-angle> ]?"]

and angular_color_stop_list =
  [%value.rec
    "[ <angular-color-stop> [ ',' <angular-color-hint> ]? ]# ',' \
     <angular-color-stop>"]

and animateable_feature =
  [%value.rec "'scroll-position' | 'contents' | <custom-ident>"]

and attachment = [%value.rec "'scroll' | 'fixed' | 'local'"]
and attr_fallback = [%value.rec "<any-value>"]
and attr_matcher = [%value.rec "[ '~' | '|' | '^' | '$' | '*' ]? '='"]
and attr_modifier = [%value.rec "'i' | 's'"]

and attribute_selector =
  [%value.rec
    "'[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [ <string-token> | \
     <ident-token> ] [ <attr-modifier> ]? ']'"]

and auto_repeat =
  [%value.rec
    "repeat( [ 'auto-fill' | 'auto-fit' ] ',' [ [ <line-names> ]? <fixed-size> \
     ]+ [ <line-names> ]? )"]

and auto_track_list =
  [%value.rec
    "[ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ <line-names> \
     ]? <auto-repeat> [ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* \
     [ <line-names> ]?"]

and baseline_position = [%value.rec "[ 'first' | 'last' ]? 'baseline'"]

and basic_shape =
  [%value.rec "<inset()> | <circle()> | <ellipse()> | <polygon()> | <path()>"]

and bg_image = [%value.rec "'none' | <image>"]

and bg_layer =
  [%value.rec
    "<bg-image> || <bg-position> [ '/' <bg-size> ]? || <repeat-style> || \
     <attachment> || <box> || <box>"]

and bg_position =
  [%value.rec
    "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ]\n\
    \  | [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | \
     'center' | 'bottom' | <length-percentage> ]\n\
    \  | [ 'center' | [ 'left' | 'right' ] <length-percentage>? ] && [ \
     'center' | [ 'top' | 'bottom' ] <length-percentage>? ]"]

(* one_bg_size isn't part of the spec, helps us with Type generation *)
and one_bg_size =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | 'auto' ] [ \
     <extended-length> | <extended-percentage> | 'auto' ]?"]

and bg_size = [%value.rec "<one-bg-size> | 'cover' | 'contain'"]

and blend_mode =
  [%value.rec
    "'normal' | 'multiply' | 'screen' | 'overlay' | 'darken' | 'lighten' | \
     'color-dodge' | 'color-burn' | 'hard-light' | 'soft-light' | 'difference' \
     | 'exclusion' | 'hue' | 'saturation' | 'color' | 'luminosity'"]

(* and border_radius = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"] *)
and border_radius = [%value.rec "<extended-length> | <extended-percentage>"]
and bottom = [%value.rec "<extended-length> | 'auto'"]
and box = [%value.rec "'border-box' | 'padding-box' | 'content-box'"]

and calc_product =
  [%value.rec "<calc-value> [ '*' <calc-value> | '/' <number> ]*"]

and dimension =
  [%value.rec
    "<extended-length> | <extended-time> | <extended-frequency> | <resolution>"]

and calc_sum = [%value.rec "<calc-product> [ [ '+' | '-' ] <calc-product> ]*"]

(* and calc_value = [%value.rec "<number> | <dimension> | <extended-percentage> | <calc>"] *)
and calc_value =
  [%value.rec
    "<number> | <extended-length> | <extended-percentage> | <extended-angle> | \
     <extended-time> | '(' <calc-sum> ')'"]

and cf_final_image = [%value.rec "<image> | <color>"]
and cf_mixing_image = [%value.rec "[ <extended-percentage> ]? && <image>"]
and class_selector = [%value.rec "'.' <ident-token>"]
and clip_source = [%value.rec "<url>"]

and color =
  [%value.rec
    "<rgb()> | <rgba()> | <hsl()> | <hsla()> | <hex-color> | <named-color> | \
     'currentColor' | <deprecated-system-color> | <interpolation> | <var()> | \
     <color-mix()>"]

and color_stop = [%value.rec "<color-stop-length> | <color-stop-angle>"]
and color_stop_angle = [%value.rec "[ <extended-angle> ]{1,2}"]

(* and color_stop_length = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"] *)
and color_stop_length = [%value.rec "<extended-length> | <extended-percentage>"]

(* color_stop_list is modified from the original spec, here is a simplified version where it tries to be fully compatible but easier for code-gen:

   The current impl allows values that aren't really supported such as: `linear-gradient(0deg, 10%, blue)` which is invalid, but we allow it for now to make it easier to generate the types. The correct value would require always a color to be in the first position `linear-gradient(0deg, red, 10%, blue);`

   The original spec is `color_stop_list = [%value.rec "[ <linear-color-stop> [ ',' <linear-color-hint> ]? ]# ',' <linear-color-stop>"]`
   *)
and color_stop_list =
  [%value.rec
    "[ [<color>? <length-percentage>] | [<color> <length-percentage>?] ]#"]

and hue_interpolation_method =
  [%value.rec
    " [ 'shorter' | 'longer' | 'increasing' | 'decreasing' ] && 'hue' "]

and polar_color_space = [%value.rec " 'hsl' | 'hwb' | 'lch' | 'oklch' "]

and rectangular_color_space =
  [%value.rec
    " 'srgb' | 'srgb-linear' | 'display-p3' | 'a98-rgb' | 'prophoto-rgb' | \
     'rec2020' | 'lab' | 'oklab' | 'xyz' | 'xyz-d50' | 'xyz-d65' "]

and color_interpolation_method =
  [%value.rec
    " 'in' && [<rectangular-color-space> | <polar-color-space> \
     <hue-interpolation-method>?] "]

and function_color_mix =
  [%value.rec
    (* TODO: Use <extended-percentage> *)
    "color-mix(<color-interpolation-method> ',' [ <color> && <percentage>? ] \
     ',' [ <color> && <percentage>? ])"]

and combinator = [%value.rec "'>' | '+' | '~' | '||'"]

and common_lig_values =
  [%value.rec "'common-ligatures' | 'no-common-ligatures'"]

and compat_auto =
  [%value.rec
    "'searchfield' | 'textarea' | 'push-button' | 'slider-horizontal' | \
     'checkbox' | 'radio' | 'square-button' | 'menulist' | 'listbox' | 'meter' \
     | 'progress-bar'"]

and complex_selector =
  [%value.rec "<compound-selector> [ [ <combinator> ]? <compound-selector> ]*"]

and complex_selector_list = [%value.rec "[ <complex-selector> ]#"]

and composite_style =
  [%value.rec
    "'clear' | 'copy' | 'source-over' | 'source-in' | 'source-out' | \
     'source-atop' | 'destination-over' | 'destination-in' | 'destination-out' \
     | 'destination-atop' | 'xor'"]

and compositing_operator =
  [%value.rec "'add' | 'subtract' | 'intersect' | 'exclude'"]

and compound_selector =
  [%value.rec
    "[ <type-selector> ]? [ <subclass-selector> ]* [ <pseudo-element-selector> \
     [ <pseudo-class-selector> ]* ]*"]

and compound_selector_list = [%value.rec "[ <compound-selector> ]#"]

and content_distribution =
  [%value.rec "'space-between' | 'space-around' | 'space-evenly' | 'stretch'"]

and content_list =
  [%value.rec
    "[ <string> | 'contents' | <url> | <quote> | <attr()> | counter( <ident> \
     ',' [ <'list-style-type'> ]? ) ]+"]

and content_position =
  [%value.rec "'center' | 'start' | 'end' | 'flex-start' | 'flex-end'"]

and content_replacement = [%value.rec "<image>"]
and contextual_alt_values = [%value.rec "'contextual' | 'no-contextual'"]
and counter_style = [%value.rec "<counter-style-name> | <symbols()>"]
and counter_style_name = [%value.rec "<custom-ident>"]
and counter_name = [%value.rec "<custom-ident>"]

and cubic_bezier_timing_function =
  [%value.rec
    "'ease' | 'ease-in' | 'ease-out' | 'ease-in-out' | cubic-bezier( <number> \
     ',' <number> ',' <number> ',' <number> )"]

and declaration =
  [%value.rec "<ident-token> ':' [ <declaration-value> ]? [ '!' 'important' ]?"]

and declaration_list =
  [%value.rec "[ [ <declaration> ]? ';' ]* [ <declaration> ]?"]

and deprecated_system_color =
  [%value.rec
    "'ActiveBorder' | 'ActiveCaption' | 'AppWorkspace' | 'Background' | \
     'ButtonFace' | 'ButtonHighlight' | 'ButtonShadow' | 'ButtonText' | \
     'CaptionText' | 'GrayText' | 'Highlight' | 'HighlightText' | \
     'InactiveBorder' | 'InactiveCaption' | 'InactiveCaptionText' | \
     'InfoBackground' | 'InfoText' | 'Menu' | 'MenuText' | 'Scrollbar' | \
     'ThreeDDarkShadow' | 'ThreeDFace' | 'ThreeDHighlight' | \
     'ThreeDLightShadow' | 'ThreeDShadow' | 'Window' | 'WindowFrame' | \
     'WindowText'"]

and discretionary_lig_values =
  [%value.rec "'discretionary-ligatures' | 'no-discretionary-ligatures'"]

and display_box = [%value.rec "'contents' | 'none'"]

and display_inside =
  [%value.rec "'flow' | 'flow-root' | 'table' | 'flex' | 'grid' | 'ruby'"]

and display_internal =
  [%value.rec
    "'table-row-group' | 'table-header-group' | 'table-footer-group' | \
     'table-row' | 'table-cell' | 'table-column-group' | 'table-column' | \
     'table-caption' | 'ruby-base' | 'ruby-text' | 'ruby-base-container' | \
     'ruby-text-container'"]

and display_legacy =
  [%value.rec
    "'inline-block' | 'inline-list-item' | 'inline-table' | 'inline-flex' | \
     'inline-grid'"]

and display_listitem =
  [%value.rec
    "[ <display-outside> ]? && [ 'flow' | 'flow-root' ]? && 'list-item'"]

and display_outside = [%value.rec "'block' | 'inline' | 'run-in'"]

and east_asian_variant_values =
  [%value.rec
    "'jis78' | 'jis83' | 'jis90' | 'jis04' | 'simplified' | 'traditional'"]

and east_asian_width_values = [%value.rec "'full-width' | 'proportional-width'"]
and ending_shape = [%value.rec "'circle' | 'ellipse'"]

and explicit_track_list =
  [%value.rec "[ [ <line-names> ]? <track-size> ]+ [ <line-names> ]?"]

and family_name = [%value.rec "<string> | <custom-ident>"]
and feature_tag_value = [%value.rec "<string> [ <integer> | 'on' | 'off' ]?"]

and feature_type =
  [%value.rec
    "'@stylistic' | '@historical-forms' | '@styleset' | '@character-variant' | \
     '@swash' | '@ornaments' | '@annotation'"]

and feature_value_block =
  [%value.rec "<feature-type> '{' <feature-value-declaration-list> '}'"]

and feature_value_block_list = [%value.rec "[ <feature-value-block> ]+"]

and feature_value_declaration =
  [%value.rec "<custom-ident> ':' [ <integer> ]+ ';'"]

and feature_value_declaration_list = [%value.rec "<feature-value-declaration>"]
and feature_value_name = [%value.rec "<custom-ident>"]
and fill_rule = [%value.rec "'nonzero' | 'evenodd'"]

and filter_function =
  [%value.rec
    "<blur()> | <brightness()> | <contrast()> | <drop-shadow()> | \
     <grayscale()> | <hue-rotate()> | <invert()> | <opacity()> | <saturate()> \
     | <sepia()>"]

and filter_function_list = [%value.rec "[ <filter-function> | <url> ]+"]

and final_bg_layer =
  [%value.rec
    "<'background-color'> || <bg-image> || <bg-position> [ '/' <bg-size> ]? || \
     <repeat-style> || <attachment> || <box> || <box>"]

and line_names = [%value.rec "'[' <custom-ident>* ']'"]
and fixed_breadth = [%value.rec "<extended-length> | <extended-percentage>"]

and fixed_repeat =
  [%value.rec
    "repeat( <positive-integer> ',' [ [ <line-names> ]? <fixed-size> ]+ [ \
     <line-names> ]? )"]

and fixed_size =
  [%value.rec
    "<fixed-breadth> | minmax( <fixed-breadth> ',' <track-breadth> ) | minmax( \
     <inflexible-breadth> ',' <fixed-breadth> )"]

and font_stretch_absolute =
  [%value.rec
    "'normal' | 'ultra-condensed' | 'extra-condensed' | 'condensed' | \
     'semi-condensed' | 'semi-expanded' | 'expanded' | 'extra-expanded' | \
     'ultra-expanded' | <extended-percentage>"]

and font_variant_css21 = [%value.rec "'normal' | 'small-caps'"]
and font_weight_absolute = [%value.rec "'normal' | 'bold' | <integer>"]

and function__webkit_gradient =
  [%value.rec
    "-webkit-gradient( <-webkit-gradient-type> ',' <-webkit-gradient-point> [ \
     ',' <-webkit-gradient-point> | ',' <-webkit-gradient-radius> ',' \
     <-webkit-gradient-point> ] [ ',' <-webkit-gradient-radius> ]? [ ',' \
     <-webkit-gradient-color-stop> ]* )"]

(* We don't support attr() with fallback value (since it's a declaration value) yet, original spec is: "attr(<attr-name> <attr-type>? , <declaration-value>?)" *)
and function_attr = [%value.rec "attr(<attr-name> <attr-type>?)"]

(* and function_attr = [%value.rec
     "attr(<attr-name> <attr-type>? , <declaration-value>?)"
   ] *)
and function_blur = [%value.rec "blur( <extended-length> )"]
and function_brightness = [%value.rec "brightness( <number-percentage> )"]
and function_calc = [%value.rec "calc( <calc-sum> )"]

and function_circle =
  [%value.rec "circle( [ <shape-radius> ]? [ 'at' <position> ]? )"]

and function_clamp = [%value.rec "clamp( [ <calc-sum> ]#{3} )"]

and function_conic_gradient =
  [%value.rec
    "conic-gradient( [ 'from' <extended-angle> ]? [ 'at' <position> ]? ',' \
     <angular-color-stop-list> )"]

and function_contrast = [%value.rec "contrast( <number-percentage> )"]

and function_counter =
  [%value.rec "counter( <counter-name> , <counter-style>? )"]

and function_counters =
  [%value.rec
    "counters( <custom-ident> ',' <string> ',' [ <counter-style> ]? )"]

and function_cross_fade =
  [%value.rec "cross-fade( <cf-mixing-image> ',' [ <cf-final-image> ]? )"]

(* drop-shadow can have 2 length and order doesn't matter, we changed to be more restrict and always expect 3 *)
and function_drop_shadow =
  [%value.rec
    "drop-shadow(<extended-length> <extended-length> <extended-length> [ \
     <color> ]?)"]

and function_element = [%value.rec "element( <id-selector> )"]

and function_ellipse =
  [%value.rec "ellipse( [ [ <shape-radius> ]{2} ]? [ 'at' <position> ]? )"]

and function_env =
  [%value.rec "env( <custom-ident> ',' [ <declaration-value> ]? )"]

and function_fit_content =
  [%value.rec "fit-content( <extended-length> | <extended-percentage> )"]

and function_grayscale = [%value.rec "grayscale( <number-percentage> )"]

and function_hsl =
  [%value.rec
    " hsl( <hue> <extended-percentage> <extended-percentage> [ '/' \
     <alpha-value> ]? )\n\
    \  | hsl( <hue> ',' <extended-percentage> ',' <extended-percentage> [ ',' \
     <alpha-value> ]? )"]

and function_hsla =
  [%value.rec
    " hsla( <hue> <extended-percentage> <extended-percentage> [ '/' \
     <alpha-value> ]? )\n\
    \  | hsla( <hue> ',' <extended-percentage> ',' <extended-percentage> ',' [ \
     <alpha-value> ]? )"]

and function_hue_rotate = [%value.rec "hue-rotate( <extended-angle> )"]

and function_image =
  [%value.rec "image( [ <image-tags> ]? [ <image-src> ]? ',' [ <color> ]? )"]

and function_image_set = [%value.rec "image-set( [ <image-set-option> ]# )"]

and function_inset =
  [%value.rec
    "inset( [ <extended-length> | <extended-percentage> ]{1,4} [ 'round' \
     <'border-radius'> ]? )"]

and function_invert = [%value.rec "invert( <number-percentage> )"]
and function_leader = [%value.rec "leader( <leader-type> )"]

and function_linear_gradient =
  [%value.rec
    "linear-gradient( [ [<extended-angle> ','] | ['to' <side-or-corner> ','] \
     ]? <color-stop-list> )"]

(* and function_linear_gradient = [%value.rec "linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? ',' <color-stop-list> )"] *)
and function_matrix = [%value.rec "matrix( [ <number> ]#{6} )"]
and function_matrix3d = [%value.rec "matrix3d( [ <number> ]#{16} )"]
and function_max = [%value.rec "max( [ <calc-sum> ]# )"]
and function_min = [%value.rec "min( [ <calc-sum> ]# )"]

and function_minmax =
  [%value.rec
    "minmax( [ <extended-length> | <extended-percentage> | 'min-content' | \
     'max-content' | 'auto' ] ',' [ <extended-length> | <extended-percentage> \
     | <flex-value> | 'min-content' | 'max-content' | 'auto' ] )"]

and function_opacity = [%value.rec "opacity( <number-percentage> )"]

and function_paint =
  [%value.rec "paint( <ident> ',' [ <declaration-value> ]? )"]

and function_path = [%value.rec "path( <string> )"]
and function_perspective = [%value.rec "perspective( <property-perspective> )"]

and function_polygon =
  [%value.rec
    "polygon( [ <fill-rule> ',' ]? [ <length-percentage> <length-percentage> \
     ]# )"]

and function_radial_gradient =
  [%value.rec
    "radial-gradient( <ending-shape>? <radial-size>? ['at' <position> ]? ','? \
     <color-stop-list> )"]

and function_repeating_linear_gradient =
  [%value.rec
    "repeating-linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? \
     ',' <color-stop-list> )"]

and function_repeating_radial_gradient =
  [%value.rec
    "repeating-radial-gradient( [ <ending-shape> || <size> ]? [ 'at' \
     <position> ]? ',' <color-stop-list> )"]

and function_rgb =
  [%value.rec
    "\n\
    \    rgb( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? )\n\
    \  | rgb( [ <number> ]{3} [ '/' <alpha-value> ]? )\n\
    \  | rgb( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? )\n\
    \  | rgb( [ <number> ]#{3} [ ',' <alpha-value> ]? )\n"]

and function_rgba =
  [%value.rec
    "\n\
    \    rgba( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? )\n\
    \  | rgba( [ <number> ]{3} [ '/' <alpha-value> ]? )\n\
    \  | rgba( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? )\n\
    \  | rgba( [ <number> ]#{3} [ ',' <alpha-value> ]? )\n"]

and function_rotate = [%value.rec "rotate( <extended-angle> | <zero> )"]

and function_rotate3d =
  [%value.rec
    "rotate3d( <number> ',' <number> ',' <number> ',' [ <extended-angle> | \
     <zero> ] )"]

and function_rotateX = [%value.rec "rotateX( <extended-angle> | <zero> )"]
and function_rotateY = [%value.rec "rotateY( <extended-angle> | <zero> )"]
and function_rotateZ = [%value.rec "rotateZ( <extended-angle> | <zero> )"]
and function_saturate = [%value.rec "saturate( <number-percentage> )"]
and function_scale = [%value.rec "scale( <number> [',' [ <number> ]]? )"]

and function_scale3d =
  [%value.rec "scale3d( <number> ',' <number> ',' <number> )"]

and function_scaleX = [%value.rec "scaleX( <number> )"]
and function_scaleY = [%value.rec "scaleY( <number> )"]
and function_scaleZ = [%value.rec "scaleZ( <number> )"]
and function_sepia = [%value.rec "sepia( <number-percentage> )"]

and function_skew =
  [%value.rec
    "skew( [ <extended-angle> | <zero> ] [',' [ <extended-angle> | <zero> ]]? )"]

and function_skewX = [%value.rec "skewX( <extended-angle> | <zero> )"]
and function_skewY = [%value.rec "skewY( <extended-angle> | <zero> )"]

and function_symbols =
  [%value.rec "symbols( [ <symbols-type> ]? [ <string> | <image> ]+ )"]

and function_target_counter =
  [%value.rec
    "target-counter( [ <string> | <url> ] ',' <custom-ident> ',' [ \
     <counter-style> ]? )"]

and function_target_counters =
  [%value.rec
    "target-counters( [ <string> | <url> ] ',' <custom-ident> ',' <string> ',' \
     [ <counter-style> ]? )"]

and function_target_text =
  [%value.rec
    "target-text( [ <string> | <url> ] ',' [ 'content' | 'before' | 'after' | \
     'first-letter' ]? )"]

and function_translate =
  [%value.rec
    "translate( [<extended-length> | <extended-percentage>] [',' [ \
     <extended-length> | <extended-percentage> ]]? )"]

and function_translate3d =
  [%value.rec
    "translate3d( [<extended-length> | <extended-percentage>] ',' \
     [<extended-length> | <extended-percentage>] ',' <extended-length> )"]

and function_translateX =
  [%value.rec "translateX( [<extended-length> | <extended-percentage>] )"]

and function_translateY =
  [%value.rec "translateY( [<extended-length> | <extended-percentage>] )"]

and function_translateZ = [%value.rec "translateZ( <extended-length> )"]

(* and function_var = [%value.rec "var( <ident> ',' [ <declaration-value> ]? )"] *)
and function_var = [%value.rec "var( <ident> )"]
and gender = [%value.rec "'male' | 'female' | 'neutral'"]

and general_enclosed =
  [%value.rec "<function-token> <any-value> ')' | '(' <ident> <any-value> ')'"]

and generic_family =
  [%value.rec
    "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace' | \
     '-apple-system'"]

and generic_name =
  [%value.rec "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace'"]

and generic_voice = [%value.rec "[ <age> ]? <gender> [ <integer> ]?"]

and geometry_box =
  [%value.rec "<shape-box> | 'fill-box' | 'stroke-box' | 'view-box'"]

and gradient =
  [%value.rec
    "<linear-gradient()> | <repeating-linear-gradient()> | <radial-gradient()> \
     | <repeating-radial-gradient()> | <conic-gradient()> | <-legacy-gradient>"]

and grid_line =
  [%value.rec
    "<custom-ident-without-span-or-auto> | <integer> && [ \
     <custom-ident-without-span-or-auto> ]? | 'span' && [ <integer> || \
     <custom-ident-without-span-or-auto> ] | 'auto' | <interpolation>"]

and historical_lig_values =
  [%value.rec "'historical-ligatures' | 'no-historical-ligatures'"]

and hue = [%value.rec "<number> | <extended-angle>"]
and id_selector = [%value.rec "<hash-token>"]

and image =
  [%value.rec
    "<url> | <image()> | <image-set()> | <element()> | <paint()> | \
     <cross-fade()> | <gradient> | <interpolation>"]

and image_set_option = [%value.rec "[ <image> | <string> ] <resolution>"]
and image_src = [%value.rec "<url> | <string>"]
and image_tags = [%value.rec "'ltr' | 'rtl'"]

and inflexible_breadth =
  [%value.rec
    "<extended-length> | <extended-percentage> | 'min-content' | 'max-content' \
     | 'auto'"]

and keyframe_block =
  [%value.rec "[ <keyframe-selector> ]# '{' <declaration-list> '}'"]

and keyframe_block_list = [%value.rec "[ <keyframe-block> ]+"]
and keyframe_selector = [%value.rec "'from' | 'to' | <extended-percentage>"]
and keyframes_name = [%value.rec "<custom-ident> | <string>"]
and leader_type = [%value.rec "'dotted' | 'solid' | 'space' | <string>"]
and left = [%value.rec "<extended-length> | 'auto'"]
and line_name_list = [%value.rec "[ <line-names> | <name-repeat> ]+"]

and line_style =
  [%value.rec
    "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | \
     'ridge' | 'inset' | 'outset'"]

and line_width = [%value.rec "<extended-length> | 'thin' | 'medium' | 'thick'"]
and linear_color_hint = [%value.rec "<extended-length> | <extended-percentage>"]
and linear_color_stop = [%value.rec "<color> <length-percentage>?"]
and mask_image = [%value.rec "[ <mask-reference> ]#"]

and mask_layer =
  [%value.rec
    "<mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || \
     <geometry-box> || [ <geometry-box> | 'no-clip' ] || \
     <compositing-operator> || <masking-mode>"]

and mask_position =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' \
     ] [ <extended-length> | <extended-percentage> | 'top' | 'center' | \
     'bottom' ]?"]

and mask_reference = [%value.rec "'none' | <image> | <mask-source>"]
and mask_source = [%value.rec "<url>"]
and masking_mode = [%value.rec "'alpha' | 'luminance' | 'match-source'"]
and mf_comparison = [%value.rec "<mf-lt> | <mf-gt> | <mf-eq>"]
and mf_eq = [%value.rec "'='"]
and mf_gt = [%value.rec "'>=' | '>'"]
and mf_lt = [%value.rec "'<=' | '<'"]

and mf_value =
  [%value.rec "<number> | <dimension> | <ident> | <ratio> | <interpolation>"]

and mf_name = [%value.rec "<ident>"]

and mf_range =
  [%value.rec
    "<mf-name> <mf-comparison> <mf-value> | <mf-value> <mf-comparison> \
     <mf-name> | <mf-value> <mf-lt> <mf-name> <mf-lt> <mf-value> | <mf-value> \
     <mf-gt> <mf-name> <mf-gt> <mf-value>"]

and mf_boolean = [%value.rec "<mf-name>"]
and mf_plain = [%value.rec "<mf-name> ':' <mf-value>"]

and media_feature =
  [%value.rec "'(' [ <mf-plain> | <mf-boolean> | <mf-range> ] ')'"]

and media_in_parens =
  [%value.rec "'(' <media-condition> ')' | <media-feature> | <interpolation>"]

and media_or = [%value.rec "'or' <media-in-parens>"]
and media_and = [%value.rec "'and' <media-in-parens>"]
and media_not = [%value.rec "'not' <media-in-parens>"]

and media_condition_without_or =
  [%value.rec "<media-not> | <media-in-parens> <media-and>*"]

and media_condition =
  [%value.rec "<media-not> | <media-in-parens> [ <media-and>* | <media-or>* ]"]

and media_query =
  [%value.rec
    "<media-condition> | [ 'not' | 'only' ]? <media-type> [ 'and' \
     <media-condition-without-or> ]?"]

and media_query_list = [%value.rec "[ <media-query> ]# | <interpolation>"]
and container_condition_list = [%value.rec "<container-condition>#"]
and container_condition = [%value.rec "[ <container-name> ]? <container-query>"]

and container_query =
  [%value.rec
    "'not' <query-in-parens> | <query-in-parens> [ [ 'and' <query-in-parens> \
     ]* | [ 'or' <query-in-parens> ]* ]"]

and query_in_parens =
  [%value.rec
    "'(' <container-query> ')' | '(' <size-feature> ')' | style( <style-query> \
     )"]

and size_feature = [%value.rec "<mf-plain> | <mf-boolean> | <mf-range>"]

and style_query =
  [%value.rec
    "'not' <style-in-parens> | <style-in-parens> [ [ and <style-in-parens> ]* \
     | [ or <style-in-parens> ]* ] | <style-feature>"]

and style_feature = [%value.rec "<dashed_ident> ':' <mf-value>"]

and style_in_parens =
  [%value.rec "'(' <style-query> ')' | '(' <style-feature> ')'"]

and name_repeat =
  [%value.rec
    "repeat( [ <positive-integer> | 'auto-fill' ] ',' [ <line-names> ]+ )"]

and named_color =
  [%value.rec
    "'transparent' | 'aliceblue' | 'antiquewhite' | 'aqua' | 'aquamarine' | \
     'azure' | 'beige' | 'bisque' | 'black' | 'blanchedalmond' | 'blue' | \
     'blueviolet' | 'brown' | 'burlywood' | 'cadetblue' | 'chartreuse' | \
     'chocolate' | 'coral' | 'cornflowerblue' | 'cornsilk' | 'crimson' | \
     'cyan' | 'darkblue' | 'darkcyan' | 'darkgoldenrod' | 'darkgray' | \
     'darkgreen' | 'darkgrey' | 'darkkhaki' | 'darkmagenta' | 'darkolivegreen' \
     | 'darkorange' | 'darkorchid' | 'darkred' | 'darksalmon' | 'darkseagreen' \
     | 'darkslateblue' | 'darkslategray' | 'darkslategrey' | 'darkturquoise' | \
     'darkviolet' | 'deeppink' | 'deepskyblue' | 'dimgray' | 'dimgrey' | \
     'dodgerblue' | 'firebrick' | 'floralwhite' | 'forestgreen' | 'fuchsia' | \
     'gainsboro' | 'ghostwhite' | 'gold' | 'goldenrod' | 'gray' | 'green' | \
     'greenyellow' | 'grey' | 'honeydew' | 'hotpink' | 'indianred' | 'indigo' \
     | 'ivory' | 'khaki' | 'lavender' | 'lavenderblush' | 'lawngreen' | \
     'lemonchiffon' | 'lightblue' | 'lightcoral' | 'lightcyan' | \
     'lightgoldenrodyellow' | 'lightgray' | 'lightgreen' | 'lightgrey' | \
     'lightpink' | 'lightsalmon' | 'lightseagreen' | 'lightskyblue' | \
     'lightslategray' | 'lightslategrey' | 'lightsteelblue' | 'lightyellow' | \
     'lime' | 'limegreen' | 'linen' | 'magenta' | 'maroon' | \
     'mediumaquamarine' | 'mediumblue' | 'mediumorchid' | 'mediumpurple' | \
     'mediumseagreen' | 'mediumslateblue' | 'mediumspringgreen' | \
     'mediumturquoise' | 'mediumvioletred' | 'midnightblue' | 'mintcream' | \
     'mistyrose' | 'moccasin' | 'navajowhite' | 'navy' | 'oldlace' | 'olive' | \
     'olivedrab' | 'orange' | 'orangered' | 'orchid' | 'palegoldenrod' | \
     'palegreen' | 'paleturquoise' | 'palevioletred' | 'papayawhip' | \
     'peachpuff' | 'peru' | 'pink' | 'plum' | 'powderblue' | 'purple' | \
     'rebeccapurple' | 'red' | 'rosybrown' | 'royalblue' | 'saddlebrown' | \
     'salmon' | 'sandybrown' | 'seagreen' | 'seashell' | 'sienna' | 'silver' | \
     'skyblue' | 'slateblue' | 'slategray' | 'slategrey' | 'snow' | \
     'springgreen' | 'steelblue' | 'tan' | 'teal' | 'thistle' | 'tomato' | \
     'turquoise' | 'violet' | 'wheat' | 'white' | 'whitesmoke' | 'yellow' | \
     'yellowgreen' | <-non-standard-color>"]

and namespace_prefix = [%value.rec "<ident>"]
and ns_prefix = [%value.rec "[ <ident-token> | '*' ]? '|'"]
and nth = [%value.rec "<an-plus-b> | 'even' | 'odd'"]
and number_one_or_greater = [%value.rec "<number>"]
and number_percentage = [%value.rec "<number> | <extended-percentage>"]
and number_zero_one = [%value.rec "<number>"]
and numeric_figure_values = [%value.rec "'lining-nums' | 'oldstyle-nums'"]

and numeric_fraction_values =
  [%value.rec "'diagonal-fractions' | 'stacked-fractions'"]

and numeric_spacing_values = [%value.rec "'proportional-nums' | 'tabular-nums'"]
and outline_radius = [%value.rec "<extended-length> | <extended-percentage>"]
and overflow_position = [%value.rec "'unsafe' | 'safe'"]

and page_body =
  [%value.rec
    "[ <declaration> ]? [ ';' <page-body> ]? | <page-margin-box> <page-body>"]

and page_margin_box =
  [%value.rec "<page-margin-box-type> '{' <declaration-list> '}'"]

and page_margin_box_type =
  [%value.rec
    "'@top-left-corner' | '@top-left' | '@top-center' | '@top-right' | \
     '@top-right-corner' | '@bottom-left-corner' | '@bottom-left' | \
     '@bottom-center' | '@bottom-right' | '@bottom-right-corner' | '@left-top' \
     | '@left-middle' | '@left-bottom' | '@right-top' | '@right-middle' | \
     '@right-bottom'"]

and page_selector =
  [%value.rec "[ <pseudo-page> ]+ | <ident> [ <pseudo-page> ]*"]

and page_selector_list = [%value.rec "[ [ <page-selector> ]# ]?"]

and paint =
  [%value.rec
    "'none' | <color> | <url> [ 'none' | <color> ]? | 'context-fill' | \
     'context-stroke' | <interpolation>"]

and position =
  [%value.rec
    "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ]\n\
    \  | [ 'left' | 'center' | 'right' ] && [ 'top' | 'center' | 'bottom' ]\n\
    \  | [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | \
     'center' | 'bottom' | <length-percentage> ]\n\
    \  | [ [ 'left' | 'right' ] <length-percentage> ] && [ [ 'top' | 'bottom' \
     ] <length-percentage> ]"]

and positive_integer = [%value.rec "<integer>"]

and property__moz_appearance =
  [%value.rec
    "'none' | 'button' | 'button-arrow-down' | 'button-arrow-next' | \
     'button-arrow-previous' | 'button-arrow-up' | 'button-bevel' | \
     'button-focus' | 'caret' | 'checkbox' | 'checkbox-container' | \
     'checkbox-label' | 'checkmenuitem' | 'dualbutton' | 'groupbox' | \
     'listbox' | 'listitem' | 'menuarrow' | 'menubar' | 'menucheckbox' | \
     'menuimage' | 'menuitem' | 'menuitemtext' | 'menulist' | \
     'menulist-button' | 'menulist-text' | 'menulist-textfield' | 'menupopup' \
     | 'menuradio' | 'menuseparator' | 'meterbar' | 'meterchunk' | \
     'progressbar' | 'progressbar-vertical' | 'progresschunk' | \
     'progresschunk-vertical' | 'radio' | 'radio-container' | 'radio-label' | \
     'radiomenuitem' | 'range' | 'range-thumb' | 'resizer' | 'resizerpanel' | \
     'scale-horizontal' | 'scalethumbend' | 'scalethumb-horizontal' | \
     'scalethumbstart' | 'scalethumbtick' | 'scalethumb-vertical' | \
     'scale-vertical' | 'scrollbarbutton-down' | 'scrollbarbutton-left' | \
     'scrollbarbutton-right' | 'scrollbarbutton-up' | \
     'scrollbarthumb-horizontal' | 'scrollbarthumb-vertical' | \
     'scrollbartrack-horizontal' | 'scrollbartrack-vertical' | 'searchfield' | \
     'separator' | 'sheet' | 'spinner' | 'spinner-downbutton' | \
     'spinner-textfield' | 'spinner-upbutton' | 'splitter' | 'statusbar' | \
     'statusbarpanel' | 'tab' | 'tabpanel' | 'tabpanels' | \
     'tab-scroll-arrow-back' | 'tab-scroll-arrow-forward' | 'textfield' | \
     'textfield-multiline' | 'toolbar' | 'toolbarbutton' | \
     'toolbarbutton-dropdown' | 'toolbargripper' | 'toolbox' | 'tooltip' | \
     'treeheader' | 'treeheadercell' | 'treeheadersortarrow' | 'treeitem' | \
     'treeline' | 'treetwisty' | 'treetwistyopen' | 'treeview' | \
     '-moz-mac-unified-toolbar' | '-moz-win-borderless-glass' | \
     '-moz-win-browsertabbar-toolbox' | '-moz-win-communicationstext' | \
     '-moz-win-communications-toolbox' | '-moz-win-exclude-glass' | \
     '-moz-win-glass' | '-moz-win-mediatext' | '-moz-win-media-toolbox' | \
     '-moz-window-button-box' | '-moz-window-button-box-maximized' | \
     '-moz-window-button-close' | '-moz-window-button-maximize' | \
     '-moz-window-button-minimize' | '-moz-window-button-restore' | \
     '-moz-window-frame-bottom' | '-moz-window-frame-left' | \
     '-moz-window-frame-right' | '-moz-window-titlebar' | \
     '-moz-window-titlebar-maximized'"]

and property__moz_background_clip = [%value.rec "'padding' | 'border'"]
and property__moz_binding = [%value.rec "<url> | 'none'"]
and property__moz_border_bottom_colors = [%value.rec "[ <color> ]+ | 'none'"]
and property__moz_border_left_colors = [%value.rec "[ <color> ]+ | 'none'"]

and property__moz_border_radius_bottomleft =
  [%value.rec "<'border-bottom-left-radius'>"]

and property__moz_border_radius_bottomright =
  [%value.rec "<'border-bottom-right-radius'>"]

and property__moz_border_radius_topleft =
  [%value.rec "<'border-top-left-radius'>"]

and property__moz_border_radius_topright =
  [%value.rec "<'border-bottom-right-radius'>"]

(* TODO: Remove interpolation without <> *)
and property__moz_border_right_colors =
  [%value.rec "[ <color> ]+ | 'none' | interpolation"]

(* TODO: Remove interpolation without <> *)
and property__moz_border_top_colors =
  [%value.rec "[ <color> ]+ | 'none' | interpolation"]

and property__moz_context_properties =
  [%value.rec
    "'none' | [ 'fill' | 'fill-opacity' | 'stroke' | 'stroke-opacity' ]#"]

and property__moz_control_character_visibility =
  [%value.rec "'visible' | 'hidden'"]

and property__moz_float_edge =
  [%value.rec "'border-box' | 'content-box' | 'margin-box' | 'padding-box'"]

and property__moz_force_broken_image_icon = [%value.rec "<integer>"]
and property__moz_image_region = [%value.rec "<shape> | 'auto'"]

and property__moz_orient =
  [%value.rec "'inline' | 'block' | 'horizontal' | 'vertical'"]

and property__moz_osx_font_smoothing = [%value.rec "'auto' | 'grayscale'"]

and property__moz_outline_radius =
  [%value.rec "[ <outline-radius> ]{1,4} [ '/' [ <outline-radius> ]{1,4} ]?"]

and property__moz_outline_radius_bottomleft = [%value.rec "<outline-radius>"]
and property__moz_outline_radius_bottomright = [%value.rec "<outline-radius>"]
and property__moz_outline_radius_topleft = [%value.rec "<outline-radius>"]
and property__moz_outline_radius_topright = [%value.rec "<outline-radius>"]
and property__moz_stack_sizing = [%value.rec "'ignore' | 'stretch-to-fit'"]
and property__moz_text_blink = [%value.rec "'none' | 'blink'"]

and property__moz_user_focus =
  [%value.rec
    "'ignore' | 'normal' | 'select-after' | 'select-before' | 'select-menu' | \
     'select-same' | 'select-all' | 'none'"]

and property__moz_user_input =
  [%value.rec "'auto' | 'none' | 'enabled' | 'disabled'"]

and property__moz_user_modify =
  [%value.rec "'read-only' | 'read-write' | 'write-only'"]

and property__moz_user_select =
  [%value.rec "'none' | 'text' | 'all' | '-moz-none'"]

and property__moz_window_dragging = [%value.rec "'drag' | 'no-drag'"]

and property__moz_window_shadow =
  [%value.rec "'default' | 'menu' | 'tooltip' | 'sheet' | 'none'"]

and property__webkit_appearance =
  [%value.rec
    "'none' | 'button' | 'button-bevel' | 'caps-lock-indicator' | 'caret' | \
     'checkbox' | 'default-button' | 'listbox' | 'listitem' | \
     'media-fullscreen-button' | 'media-mute-button' | 'media-play-button' | \
     'media-seek-back-button' | 'media-seek-forward-button' | 'media-slider' | \
     'media-sliderthumb' | 'menulist' | 'menulist-button' | 'menulist-text' | \
     'menulist-textfield' | 'push-button' | 'radio' | 'scrollbarbutton-down' | \
     'scrollbarbutton-left' | 'scrollbarbutton-right' | 'scrollbarbutton-up' | \
     'scrollbargripper-horizontal' | 'scrollbargripper-vertical' | \
     'scrollbarthumb-horizontal' | 'scrollbarthumb-vertical' | \
     'scrollbartrack-horizontal' | 'scrollbartrack-vertical' | 'searchfield' | \
     'searchfield-cancel-button' | 'searchfield-decoration' | \
     'searchfield-results-button' | 'searchfield-results-decoration' | \
     'slider-horizontal' | 'slider-vertical' | 'sliderthumb-horizontal' | \
     'sliderthumb-vertical' | 'square-button' | 'textarea' | 'textfield'"]

and property__webkit_background_clip =
  [%value.rec "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#"]

and property__webkit_border_before =
  [%value.rec "<'border-width'> || <'border-style'> || <'color'>"]

and property__webkit_border_before_color = [%value.rec "<'color'>"]
and property__webkit_border_before_style = [%value.rec "<'border-style'>"]
and property__webkit_border_before_width = [%value.rec "<'border-width'>"]

and property__webkit_box_reflect =
  [%value.rec
    "[ 'above' | 'below' | 'right' | 'left' ]? [ <extended-length> ]? [ \
     <image> ]?"]

and property__webkit_column_break_after =
  [%value.rec "'always' | 'auto' | 'avoid'"]

and property__webkit_column_break_before =
  [%value.rec "'always' | 'auto' | 'avoid'"]

and property__webkit_column_break_inside =
  [%value.rec "'always' | 'auto' | 'avoid'"]

and property__webkit_font_smoothing =
  [%value.rec "'auto' | 'none' | 'antialiased' | 'subpixel-antialiased'"]

and property__webkit_line_clamp = [%value.rec "'none' | <integer>"]

and property__webkit_mask =
  [%value.rec
    "[ <mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || \
     [ <box> | 'border' | 'padding' | 'content' | 'text' ] || [ <box> | \
     'border' | 'padding' | 'content' ] ]#"]

and property__webkit_mask_attachment = [%value.rec "[ <attachment> ]#"]

and property__webkit_mask_box_image =
  [%value.rec
    "[ <url> | <gradient> | 'none' ] [ [ <extended-length> | \
     <extended-percentage> ]{4} [ <-webkit-mask-box-repeat> ]{2} ]?"]

and property__webkit_mask_clip =
  [%value.rec "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#"]

and property__webkit_mask_composite = [%value.rec "[ <composite-style> ]#"]
and property__webkit_mask_image = [%value.rec "[ <mask-reference> ]#"]

and property__webkit_mask_origin =
  [%value.rec "[ <box> | 'border' | 'padding' | 'content' ]#"]

and property__webkit_mask_position = [%value.rec "[ <position> ]#"]

and property__webkit_mask_position_x =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' \
     ]#"]

and property__webkit_mask_position_y =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' \
     ]#"]

and property__webkit_mask_repeat = [%value.rec "[ <repeat-style> ]#"]

and property__webkit_mask_repeat_x =
  [%value.rec "'repeat' | 'no-repeat' | 'space' | 'round'"]

and property__webkit_mask_repeat_y =
  [%value.rec "'repeat' | 'no-repeat' | 'space' | 'round'"]

and property__webkit_mask_size = [%value.rec "[ <bg-size> ]#"]
and property__webkit_overflow_scrolling = [%value.rec "'auto' | 'touch'"]
and property__webkit_print_color_adjust = [%value.rec "'economy' | 'exact'"]
and property__webkit_tap_highlight_color = [%value.rec "<color>"]
and property__webkit_text_fill_color = [%value.rec "<color>"]

and property__webkit_text_security =
  [%value.rec "'none' | 'circle' | 'disc' | 'square'"]

and property__webkit_text_stroke = [%value.rec "<extended-length> || <color>"]
and property__webkit_text_stroke_color = [%value.rec "<color>"]
and property__webkit_text_stroke_width = [%value.rec "<extended-length>"]
and property__webkit_touch_callout = [%value.rec "'default' | 'none'"]
and property__webkit_user_drag = [%value.rec "'none' | 'element' | 'auto'"]

and property__webkit_user_modify =
  [%value.rec "'read-only' | 'read-write' | 'read-write-plaintext-only'"]

and property__webkit_user_select =
  [%value.rec "'auto' | 'none' | 'text' | 'all'"]

and property_align_content =
  [%value.rec
    "'normal' | <baseline-position> | <content-distribution> | [ \
     <overflow-position> ]? <content-position>"]

and property_align_items =
  [%value.rec
    "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? \
     <self-position> | <interpolation>"]

and property_align_self =
  [%value.rec
    "'auto' | 'normal' | 'stretch' | <baseline-position> | [ \
     <overflow-position> ]? <self-position> | <interpolation>"]

and property_alignment_baseline =
  [%value.rec
    "'auto' | 'baseline' | 'before-edge' | 'text-before-edge' | 'middle' | \
     'central' | 'after-edge' | 'text-after-edge' | 'ideographic' | \
     'alphabetic' | 'hanging' | 'mathematical'"]

and property_all = [%value.rec "'initial' | 'inherit' | 'unset' | 'revert'"]

and property_animation =
  [%value.rec "[ <single-animation> | <single-animation-no-interp> ]#"]

and property_animation_delay = [%value.rec "[ <extended-time> ]#"]

and property_animation_direction =
  [%value.rec "[ <single-animation-direction> ]#"]

and property_animation_duration = [%value.rec "[ <extended-time> ]#"]

and property_animation_fill_mode =
  [%value.rec "[ <single-animation-fill-mode> ]#"]

and property_animation_iteration_count =
  [%value.rec "[ <single-animation-iteration-count> ]#"]

and property_animation_name =
  [%value.rec "[ <keyframes-name> | 'none' | <interpolation> ]#"]

and property_animation_play_state =
  [%value.rec "[ <single-animation-play-state> ]#"]

and property_animation_timing_function = [%value.rec "[ <timing-function> ]#"]

and property_appearance =
  [%value.rec
    "'none' | 'auto' | 'button' | 'textfield' | 'menulist-button' | \
     <compat-auto>"]

and property_aspect_ratio = [%value.rec "'auto' | <ratio>"]

and property_azimuth =
  [%value.rec
    "<extended-angle> | [ 'left-side' | 'far-left' | 'left' | 'center-left' | \
     'center' | 'center-right' | 'right' | 'far-right' | 'right-side' ] || \
     'behind' | 'leftwards' | 'rightwards'"]

and property_backdrop_filter =
  [%value.rec "'none' | <interpolation> | <filter-function-list>"]

and property_backface_visibility = [%value.rec "'visible' | 'hidden'"]
and property_background = [%value.rec "[ <bg-layer> ',' ]* <final-bg-layer>"]
and property_background_attachment = [%value.rec "[ <attachment> ]#"]
and property_background_blend_mode = [%value.rec "[ <blend-mode> ]#"]

and property_background_clip =
  [%value.rec "[ <box> | 'text' | 'border-area' ]#"]

and property_background_color = [%value.rec "<color>"]
and property_background_image = [%value.rec "[ <bg-image> ]#"]
and property_background_origin = [%value.rec "[ <box> ]#"]
and property_background_position = [%value.rec "[ <bg-position> ]#"]

and property_background_position_x =
  [%value.rec
    "[ 'center' | [ 'left' | 'right' | 'x-start' | 'x-end' ]? [ \
     <extended-length> | <extended-percentage> ]? ]#"]

and property_background_position_y =
  [%value.rec
    "[ 'center' | [ 'top' | 'bottom' | 'y-start' | 'y-end' ]? [ \
     <extended-length> | <extended-percentage> ]? ]#"]

and property_background_repeat = [%value.rec "[ <repeat-style> ]#"]
and property_background_size = [%value.rec "[ <bg-size> ]#"]

and property_baseline_shift =
  [%value.rec "'baseline' | 'sub' | 'super' | <svg-length>"]

and property_behavior = [%value.rec "[ <url> ]+"]
and property_block_overflow = [%value.rec "'clip' | 'ellipsis' | <string>"]
and property_block_size = [%value.rec "<'width'>"]

and property_border =
  [%value.rec
    "'none' | [ <line-width> | <interpolation> ] | [ <line-width> | \
     <interpolation> ] [ <line-style> | <interpolation> ] | [ <line-width> | \
     <interpolation> ] [ <line-style> | <interpolation> ] [ <color> | \
     <interpolation> ]"]

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

and property_border_bottom_left_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and property_border_bottom_right_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and property_border_bottom_style = [%value.rec "<line-style>"]
and property_border_bottom_width = [%value.rec "<line-width>"]
and property_border_collapse = [%value.rec "'collapse' | 'separate'"]
and property_border_color = [%value.rec "[ <color> ]{1,4}"]

and property_border_end_end_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and property_border_end_start_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and property_border_image =
  [%value.rec
    "<'border-image-source'> || <'border-image-slice'> [ '/' \
     <'border-image-width'> | '/' [ <'border-image-width'> ]? '/' \
     <'border-image-outset'> ]? || <'border-image-repeat'>"]

and property_border_image_outset =
  [%value.rec "[ <extended-length> | <number> ]{1,4}"]

and property_border_image_repeat =
  [%value.rec "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}"]

and property_border_image_slice =
  [%value.rec "[ <number-percentage> ]{1,4} && [ 'fill' ]?"]

and property_border_image_source = [%value.rec "'none' | <image>"]

and property_border_image_width =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}"]

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

(* border-radius isn't supported with the entire spec in bs-css: `"[ <extended-length> | <extended-percentage> ]{1,4} [ '/' [ <extended-length> | <extended-percentage> ]{1,4} ]?"` *)
and property_border_radius =
  [%value.rec "<extended-length> | <extended-percentage>"]

and property_border_right = [%value.rec "<'border'>"]
and property_border_right_color = [%value.rec "<color>"]
and property_border_right_style = [%value.rec "<line-style>"]
and property_border_right_width = [%value.rec "<line-width>"]

and property_border_spacing =
  [%value.rec "<extended-length> [ <extended-length> ]?"]

and property_border_start_end_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and property_border_start_start_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

(* bs-css doesn't support list of styles, the original spec is: `[ <line-style> ]{1,4}` *)
and property_border_style = [%value.rec "<line-style>"]
and property_border_top = [%value.rec "<'border'>"]
and property_border_top_color = [%value.rec "<color>"]

and property_border_top_left_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and property_border_top_right_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and property_border_top_style = [%value.rec "<line-style>"]
and property_border_top_width = [%value.rec "<line-width>"]
and property_border_width = [%value.rec "[ <line-width> ]{1,4}"]

and property_bottom =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and property_box_align =
  [%value.rec "'start' | 'center' | 'end' | 'baseline' | 'stretch'"]

and property_box_decoration_break = [%value.rec "'slice' | 'clone'"]
and property_box_direction = [%value.rec "'normal' | 'reverse' | 'inherit'"]
and property_box_flex = [%value.rec "<number>"]
and property_box_flex_group = [%value.rec "<integer>"]
and property_box_lines = [%value.rec "'single' | 'multiple'"]
and property_box_ordinal_group = [%value.rec "<integer>"]

and property_box_orient =
  [%value.rec
    "'horizontal' | 'vertical' | 'inline-axis' | 'block-axis' | 'inherit'"]

and property_box_pack = [%value.rec "'start' | 'center' | 'end' | 'justify'"]

and property_box_shadow =
  [%value.rec "'none' | <interpolation> | [ <shadow> ]#"]

and property_box_sizing = [%value.rec "'content-box' | 'border-box'"]

and property_break_after =
  [%value.rec
    "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | \
     'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' \
     | 'region'"]

and property_break_before =
  [%value.rec
    "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | \
     'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' \
     | 'region'"]

and property_break_inside =
  [%value.rec
    "'auto' | 'avoid' | 'avoid-page' | 'avoid-column' | 'avoid-region'"]

and property_caption_side =
  [%value.rec
    "'top' | 'bottom' | 'block-start' | 'block-end' | 'inline-start' | \
     'inline-end'"]

and property_caret_color = [%value.rec "'auto' | <color>"]

and property_clear =
  [%value.rec
    "'none' | 'left' | 'right' | 'both' | 'inline-start' | 'inline-end'"]

and property_clip = [%value.rec "<shape> | 'auto'"]

and property_clip_path =
  [%value.rec "<clip-source> | <basic-shape> || <geometry-box> | 'none'"]

and property_clip_rule = [%value.rec "'nonzero' | 'evenodd'"]
and property_color = [%value.rec "<color>"]

and property_color_interpolation_filters =
  [%value.rec "'auto' | 'sRGB' | 'linearRGB'"]

and property_color_interpolation = [%value.rec "'auto' | 'sRGB' | 'linearRGB'"]
and property_color_adjust = [%value.rec "'economy' | 'exact'"]
and property_column_count = [%value.rec "<integer> | 'auto'"]
and property_column_fill = [%value.rec "'auto' | 'balance' | 'balance-all'"]

and property_column_gap =
  [%value.rec "'normal' | <extended-length> | <extended-percentage>"]

and property_column_rule =
  [%value.rec
    "<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>"]

and property_column_rule_color = [%value.rec "<color>"]
and property_column_rule_style = [%value.rec "<'border-style'>"]
and property_column_rule_width = [%value.rec "<'border-width'>"]
and property_column_span = [%value.rec "'none' | 'all'"]
and property_column_width = [%value.rec "<extended-length> | 'auto'"]
and property_columns = [%value.rec "<'column-width'> || <'column-count'>"]

and property_contain =
  [%value.rec
    "'none' | 'strict' | 'content' | 'size' || 'layout' || 'style' || 'paint'"]

and property_content =
  [%value.rec
    "'normal' | 'none' | <string> | <interpolation> | [ <content-replacement> \
     | <content-list> ] [ '/' <string> ]?"]

and property_content_visibility = [%value.rec "'visible' | 'hidden' | 'auto'"]

and property_counter_increment =
  [%value.rec "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]

and property_counter_reset =
  [%value.rec "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]

and property_counter_set =
  [%value.rec "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]

and property_cue = [%value.rec "<'cue-before'> [ <'cue-after'> ]?"]
and property_cue_after = [%value.rec "<url> [ <decibel> ]? | 'none'"]
and property_cue_before = [%value.rec "<url> [ <decibel> ]? | 'none'"]

(* and property_cursor = [%value.rec
     "[ <url> [ <x> <y> ]? ',' ]* [ 'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | 'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | 'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | 'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | 'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | 'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | 'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' | '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' ] | <interpolation>"
   ] *)
(* Removed [ <url> [ <x> <y> ]? ',' ]* *)
and property_cursor =
  [%value.rec
    "'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | \
     'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | \
     'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | \
     'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | \
     'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | \
     'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | \
     'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | \
     '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' \
     | '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' | <interpolation>"]

and property_direction = [%value.rec "'ltr' | 'rtl'"]

and property_display =
  [%value.rec
    "'block' | 'contents' | 'flex' | 'flow' | 'flow-root' | 'grid' | 'inline' \
     | 'inline-block' | 'inline-flex' | 'inline-grid' | 'inline-list-item' | \
     'inline-table' | 'list-item' | 'none' | 'ruby' | 'ruby-base' | \
     'ruby-base-container' | 'ruby-text' | 'ruby-text-container' | 'run-in' | \
     'table' | 'table-caption' | 'table-cell' | 'table-column' | \
     'table-column-group' | 'table-footer-group' | 'table-header-group' | \
     'table-row' | 'table-row-group' | '-webkit-flex' | '-webkit-inline-flex' \
     | '-webkit-box' | '-webkit-inline-box' | '-moz-inline-stack' | '-moz-box' \
     | '-moz-inline-box'"]

and property_dominant_baseline =
  [%value.rec
    "'auto' | 'use-script' | 'no-change' | 'reset-size' | 'ideographic' | \
     'alphabetic' | 'hanging' | 'mathematical' | 'central' | 'middle' | \
     'text-after-edge' | 'text-before-edge'"]

and property_empty_cells = [%value.rec "'show' | 'hide'"]
and property_fill = [%value.rec "<paint>"]
and property_fill_opacity = [%value.rec "<alpha-value>"]
and property_fill_rule = [%value.rec "'nonzero' | 'evenodd'"]

and property_filter =
  [%value.rec "'none' | <interpolation> | <filter-function-list>"]

and property_flex =
  [%value.rec
    "'none' | [<'flex-grow'> [ <'flex-shrink'> ]? || <'flex-basis'>] | \
     <interpolation>"]

and property_flex_basis = [%value.rec "'content' | <'width'> | <interpolation>"]

and property_flex_direction =
  [%value.rec "'row' | 'row-reverse' | 'column' | 'column-reverse'"]

and property_flex_flow = [%value.rec "<'flex-direction'> || <'flex-wrap'>"]
and property_flex_grow = [%value.rec "<number> | <interpolation>"]
and property_flex_shrink = [%value.rec "<number> | <interpolation>"]
and property_flex_wrap = [%value.rec "'nowrap' | 'wrap' | 'wrap-reverse'"]

and property_float =
  [%value.rec "'left' | 'right' | 'none' | 'inline-start' | 'inline-end'"]

and property_font =
  [%value.rec
    "[ <'font-style'> || <font-variant-css21> || <'font-weight'> || \
     <'font-stretch'> ]? <'font-size'> [ '/' <'line-height'> ]? \
     <'font-family'> | 'caption' | 'icon' | 'menu' | 'message-box' | \
     'small-caption' | 'status-bar'"]

and font_families =
  [%value.rec "[ <family-name> | <generic-family> | <interpolation> ]#"]

and property_font_family = [%value.rec "<font_families> | <interpolation>"]

and property_font_feature_settings =
  [%value.rec "'normal' | [ <feature-tag-value> ]#"]

and property_font_display =
  [%value.rec "'auto' | 'block' | 'swap' | 'fallback' | 'optional'"]

and property_font_kerning = [%value.rec "'auto' | 'normal' | 'none'"]
and property_font_language_override = [%value.rec "'normal' | <string>"]
and property_font_optical_sizing = [%value.rec "'auto' | 'none'"]
and property_font_palette = [%value.rec "'normal' | 'light' | 'dark'"]

and property_font_size =
  [%value.rec
    "<absolute-size> | <relative-size> | <extended-length> | \
     <extended-percentage>"]

and property_font_size_adjust = [%value.rec "'none' | <number>"]

and property_font_smooth =
  [%value.rec
    "'auto' | 'never' | 'always' | <absolute-size> | <extended-length>"]

and property_font_stretch = [%value.rec "<font-stretch-absolute>"]

and property_font_style =
  [%value.rec
    "'normal' | 'italic' | 'oblique' | <interpolation> | [ 'oblique' \
     <extended-angle> ]?"]

and property_font_synthesis =
  [%value.rec "'none' | [ 'weight' || 'style' || 'small-caps' || 'position' ]"]

and property_font_synthesis_weight = [%value.rec "'auto' | 'none'"]
and property_font_synthesis_style = [%value.rec "'auto' | 'none'"]
and property_font_synthesis_small_caps = [%value.rec "'auto' | 'none'"]
and property_font_synthesis_position = [%value.rec "'auto' | 'none'"]

and property_font_variant =
  [%value.rec
    "'normal' | 'none' | 'small-caps' | <common-lig-values> || \
     <discretionary-lig-values> || <historical-lig-values> || \
     <contextual-alt-values> || stylistic( <feature-value-name> ) || \
     'historical-forms' || styleset( [ <feature-value-name> ]# ) || \
     character-variant( [ <feature-value-name> ]# ) || swash( \
     <feature-value-name> ) || ornaments( <feature-value-name> ) || \
     annotation( <feature-value-name> ) || [ 'small-caps' | 'all-small-caps' | \
     'petite-caps' | 'all-petite-caps' | 'unicase' | 'titling-caps' ] || \
     <numeric-figure-values> || <numeric-spacing-values> || \
     <numeric-fraction-values> || 'ordinal' || 'slashed-zero' || \
     <east-asian-variant-values> || <east-asian-width-values> || 'ruby' || \
     'sub' || 'super' || 'text' || 'emoji' || 'unicode'"]

and property_font_variant_alternates =
  [%value.rec
    "'normal' | stylistic( <feature-value-name> ) || 'historical-forms' || \
     styleset( [ <feature-value-name> ]# ) || character-variant( [ \
     <feature-value-name> ]# ) || swash( <feature-value-name> ) || ornaments( \
     <feature-value-name> ) || annotation( <feature-value-name> )"]

and property_font_variant_caps =
  [%value.rec
    "'normal' | 'small-caps' | 'all-small-caps' | 'petite-caps' | \
     'all-petite-caps' | 'unicase' | 'titling-caps'"]

and property_font_variant_east_asian =
  [%value.rec
    "'normal' | <east-asian-variant-values> || <east-asian-width-values> || \
     'ruby'"]

and property_font_variant_ligatures =
  [%value.rec
    "'normal' | 'none' | <common-lig-values> || <discretionary-lig-values> || \
     <historical-lig-values> || <contextual-alt-values>"]

and property_font_variant_numeric =
  [%value.rec
    "'normal' | <numeric-figure-values> || <numeric-spacing-values> || \
     <numeric-fraction-values> || 'ordinal' || 'slashed-zero'"]

and property_font_variant_position = [%value.rec "'normal' | 'sub' | 'super'"]

and property_font_variation_settings =
  [%value.rec "'normal' | [ <string> <number> ]#"]

and property_font_variant_emoji =
  [%value.rec "'normal' | 'text' | 'emoji' | 'unicode'"]

and property_font_weight =
  [%value.rec "<font-weight-absolute> | 'bolder' | 'lighter' | <interpolation>"]

and property_gap = [%value.rec "<'row-gap'> [ <'column-gap'> ]?"]
and property_glyph_orientation_horizontal = [%value.rec "<extended-angle>"]
and property_glyph_orientation_vertical = [%value.rec "<extended-angle>"]

and property_grid =
  [%value.rec
    "<'grid-template'>\n\
    \  | <'grid-template-rows'> '/' [ 'auto-flow' && [ 'dense' ]? ] [ \
     <'grid-auto-columns'> ]?\n\
    \  | [ 'auto-flow' && [ 'dense' ]? ] [ <'grid-auto-rows'> ]? '/' \
     <'grid-template-columns'>"]

and property_grid_area = [%value.rec "<grid-line> [ '/' <grid-line> ]{0,3}"]
and property_grid_auto_columns = [%value.rec "[ <track-size> ]+"]

and property_grid_auto_flow =
  [%value.rec "[ [ 'row' | 'column' ] || 'dense' ] | <interpolation>"]

and property_grid_auto_rows = [%value.rec "[ <track-size> ]+"]
and property_grid_column = [%value.rec "<grid-line> [ '/' <grid-line> ]?"]
and property_grid_column_end = [%value.rec "<grid-line>"]

and property_grid_column_gap =
  [%value.rec "<extended-length> | <extended-percentage>"]

and property_grid_column_start = [%value.rec "<grid-line>"]
and property_grid_gap = [%value.rec "<'grid-row-gap'> [ <'grid-column-gap'> ]?"]
and property_grid_row = [%value.rec "<grid-line> [ '/' <grid-line> ]?"]
and property_grid_row_end = [%value.rec "<grid-line>"]

and property_grid_row_gap =
  [%value.rec "<extended-length> | <extended-percentage>"]

and property_grid_row_start = [%value.rec "<grid-line>"]

and property_grid_template =
  [%value.rec
    "'none' | <'grid-template-rows'> '/' <'grid-template-columns'> | [ [ \
     <line-names> ]? <string> [ <track-size> ]? [ <line-names> ]? ]+ [ '/' \
     <explicit-track-list> ]?"]

and property_grid_template_areas =
  [%value.rec "'none' | [ <string> | <interpolation> ]+"]

and property_grid_template_columns =
  [%value.rec
    "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> \
     ]? | 'masonry' | <interpolation>"]

and property_grid_template_rows =
  [%value.rec
    "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> \
     ]? | 'masonry' | <interpolation>"]

and property_hanging_punctuation =
  [%value.rec "'none' | 'first' || [ 'force-end' | 'allow-end' ] || 'last'"]

and property_height =
  [%value.rec
    "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
     'max-content' | 'fit-content' | fit-content( <extended-length> | \
     <extended-percentage> )"]

and property_hyphens = [%value.rec "'none' | 'manual' | 'auto'"]
and property_hyphenate_character = [%value.rec "'auto' | <string-token>"]
and property_hyphenate_limit_chars = [%value.rec "'auto' | <integer>"]
and property_hyphenate_limit_lines = [%value.rec "'no-limit' | <integer>"]

and property_hyphenate_limit_zone =
  [%value.rec "<extended-length> | <extended-percentage>"]

and property_image_orientation =
  [%value.rec "'from-image' | <extended-angle> | [ <extended-angle> ]? 'flip'"]

and property_image_rendering =
  [%value.rec "'auto' |'smooth' | 'high-quality' | 'crisp-edges' | 'pixelated'"]

and property_image_resolution =
  [%value.rec "[ 'from-image' || <resolution> ] && [ 'snap' ]?"]

and property_ime_mode =
  [%value.rec "'auto' | 'normal' | 'active' | 'inactive' | 'disabled'"]

and property_initial_letter = [%value.rec "'normal' | <number> [ <integer> ]?"]

and property_initial_letter_align =
  [%value.rec "'auto' | 'alphabetic' | 'hanging' | 'ideographic'"]

and property_inline_size = [%value.rec "<'width'>"]
and property_inset = [%value.rec "[ <'top'> ]{1,4}"]
and property_inset_block = [%value.rec "[ <'top'> ]{1,2}"]
and property_inset_block_end = [%value.rec "<'top'>"]
and property_inset_block_start = [%value.rec "<'top'>"]
and property_inset_inline = [%value.rec "[ <'top'> ]{1,2}"]
and property_inset_inline_end = [%value.rec "<'top'>"]
and property_inset_inline_start = [%value.rec "<'top'>"]
and property_isolation = [%value.rec "'auto' | 'isolate'"]

and property_justify_content =
  [%value.rec
    "'normal' | <content-distribution> | [ <overflow-position> ]? [ \
     <content-position> | 'left' | 'right' ]"]

and property_justify_items =
  [%value.rec
    "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? [ \
     <self-position> | 'left' | 'right' ] | 'legacy' | 'legacy' && [ 'left' | \
     'right' | 'center' ]"]

and property_justify_self =
  [%value.rec
    "'auto' | 'normal' | 'stretch' | <baseline-position> | [ \
     <overflow-position> ]? [ <self-position> | 'left' | 'right' ]"]

and property_kerning = [%value.rec "'auto' | <svg-length>"]

and property_layout_grid =
  [%value.rec "'auto' | <custom-ident> | <integer> && [ <custom-ident> ]?"]

and property_layout_grid_char =
  [%value.rec "'auto' | <custom-ident> | <string>"]

and property_layout_grid_line =
  [%value.rec "'auto' | <custom-ident> | <string>"]

and property_layout_grid_mode =
  [%value.rec "'auto' | <custom-ident> | <string>"]

and property_layout_grid_type =
  [%value.rec "'auto' | <custom-ident> | <string>"]

and property_left =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and property_letter_spacing =
  [%value.rec "'normal' | <extended-length> | <extended-percentage>"]

and property_line_break =
  [%value.rec
    "'auto' | 'loose' | 'normal' | 'strict' | 'anywhere' | <interpolation>"]

and property_line_clamp = [%value.rec "'none' | <integer>"]

and property_line_height =
  [%value.rec "'normal' | <number> | <extended-length> | <extended-percentage>"]

and property_line_height_step = [%value.rec "<extended-length>"]

and property_list_style =
  [%value.rec
    "<'list-style-type'> || <'list-style-position'> || <'list-style-image'>"]

and property_list_style_image = [%value.rec "'none' | <image>"]
and property_list_style_position = [%value.rec "'inside' | 'outside'"]

and property_list_style_type =
  [%value.rec "<counter-style> | <string> | 'none'"]

and property_margin =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | 'auto' | <interpolation> \
     ]{1,4}"]

and property_margin_block = [%value.rec "[ <'margin-left'> ]{1,2}"]
and property_margin_block_end = [%value.rec "<'margin-left'>"]
and property_margin_block_start = [%value.rec "<'margin-left'>"]

and property_margin_bottom =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and property_margin_inline = [%value.rec "[ <'margin-left'> ]{1,2}"]
and property_margin_inline_end = [%value.rec "<'margin-left'>"]
and property_margin_inline_start = [%value.rec "<'margin-left'>"]

and property_margin_left =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and property_margin_right =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and property_margin_top =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and property_margin_trim = [%value.rec "'none' | 'in-flow' | 'all'"]
and property_marker = [%value.rec "'none' | <url>"]
and property_marker_end = [%value.rec "'none' | <url>"]
and property_marker_mid = [%value.rec "'none' | <url>"]
and property_marker_start = [%value.rec "'none' | <url>"]
and property_mask = [%value.rec "[ <mask-layer> ]#"]

and property_mask_border =
  [%value.rec
    "<'mask-border-source'> || <'mask-border-slice'> [ '/' [ \
     <'mask-border-width'> ]? [ '/' <'mask-border-outset'> ]? ]? || \
     <'mask-border-repeat'> || <'mask-border-mode'>"]

and property_mask_border_mode = [%value.rec "'luminance' | 'alpha'"]

and property_mask_border_outset =
  [%value.rec "[ <extended-length> | <number> ]{1,4}"]

and property_mask_border_repeat =
  [%value.rec "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}"]

and property_mask_border_slice =
  [%value.rec "[ <number-percentage> ]{1,4} [ 'fill' ]?"]

and property_mask_border_source = [%value.rec "'none' | <image>"]

and property_mask_border_width =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}"]

and property_mask_clip = [%value.rec "[ <geometry-box> | 'no-clip' ]#"]
and property_mask_composite = [%value.rec "[ <compositing-operator> ]#"]
and property_mask_image = [%value.rec "[ <mask-reference> ]#"]
and property_mask_mode = [%value.rec "[ <masking-mode> ]#"]
and property_mask_origin = [%value.rec "[ <geometry-box> ]#"]
and property_mask_position = [%value.rec "[ <position> ]#"]
and property_mask_repeat = [%value.rec "[ <repeat-style> ]#"]
and property_mask_size = [%value.rec "[ <bg-size> ]#"]
and property_mask_type = [%value.rec "'luminance' | 'alpha'"]

and property_masonry_auto_flow =
  [%value.rec "[ 'pack' | 'next' ] || [ 'definite-first' | 'ordered' ]"]

and property_max_block_size = [%value.rec "<'max-width'>"]

and property_max_height =
  [%value.rec
    "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
     'max-content' | 'fit-content' | fit-content( <extended-length> | \
     <extended-percentage> )"]

and property_max_inline_size = [%value.rec "<'max-width'>"]
and property_max_lines = [%value.rec "'none' | <integer>"]

and property_max_width =
  [%value.rec
    "<extended-length> | <extended-percentage> | 'none' | 'max-content' | \
     'min-content' | 'fit-content' | fit-content( <extended-length> | \
     <extended-percentage> ) | 'fill-available' | <-non-standard-width>"]

and property_min_block_size = [%value.rec "<'min-width'>"]

and property_min_height =
  [%value.rec
    "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
     'max-content' | 'fit-content' | fit-content( <extended-length> | \
     <extended-percentage> )"]

and property_min_inline_size = [%value.rec "<'min-width'>"]

and property_min_width =
  [%value.rec
    "<extended-length> | <extended-percentage> | 'auto' | 'max-content' | \
     'min-content' | 'fit-content' | fit-content( <extended-length> | \
     <extended-percentage> ) | 'fill-available' | <-non-standard-width>"]

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

and property_media_display_mode =
  [%value.rec "'fullscreen' | 'standalone' | 'minimal-ui' | 'browser'"]

and property_media_forced_colors = [%value.rec "'none' | 'active'"]

and property_forced_color_adjust =
  [%value.rec "'auto' | 'none' | 'preserve-parent-color'"]

and property_media_grid = [%value.rec "<integer>"]
and property_media_hover = [%value.rec "'hover' | 'none'"]
and property_media_inverted_colors = [%value.rec "'inverted' | 'none'"]
and property_media_monochrome = [%value.rec "<integer>"]
and property_media_prefers_color_scheme = [%value.rec "'dark' | 'light'"]

and property_color_scheme =
  [%value.rec "'normal' |\n  [ 'dark' | 'light' | <custom-ident> ]+ && 'only'?"]

and property_media_prefers_contrast =
  [%value.rec "'no-preference' | 'more' | 'less'"]

and property_media_prefers_reduced_motion =
  [%value.rec "'no-preference' | 'reduce'"]

and property_media_resolution = [%value.rec "<resolution>"]
and property_media_min_resolution = [%value.rec "<resolution>"]
and property_media_max_resolution = [%value.rec "<resolution>"]

and property_media_scripting =
  [%value.rec "'none' | 'initial-only' | 'enabled'"]

and property_media_update = [%value.rec "'none' | 'slow' | 'fast'"]
and property_media_orientation = [%value.rec "'portrait' | 'landscape'"]

and property_object_fit =
  [%value.rec "'fill' | 'contain' | 'cover' | 'none' | 'scale-down'"]

and property_object_position = [%value.rec "<position>"]

and property_offset =
  [%value.rec
    "[ [ <'offset-position'> ]? <'offset-path'> [ <'offset-distance'> || \
     <'offset-rotate'> ]? ]? [ '/' <'offset-anchor'> ]?"]

and property_offset_anchor = [%value.rec "'auto' | <position>"]

and property_offset_distance =
  [%value.rec "<extended-length> | <extended-percentage>"]

and property_offset_path =
  [%value.rec
    "'none' | ray( <extended-angle> && [ <ray_size> ]? && [ 'contain' ]? ) | \
     <path()> | <url> | <basic-shape> || <geometry-box>"]

and property_offset_position = [%value.rec "'auto' | <position>"]

and property_offset_rotate =
  [%value.rec "[ 'auto' | 'reverse' ] || <extended-angle>"]

and property_opacity = [%value.rec "<alpha-value>"]
and property_order = [%value.rec "<integer>"]
and property_orphans = [%value.rec "<integer>"]

and property_outline =
  [%value.rec
    "'none' | <'outline-width'> | [ <'outline-width'> <'outline-style'> ] | [ \
     <'outline-width'> <'outline-style'> [ <color> | <interpolation> ]]"]

and property_outline_color = [%value.rec "<color>"]
and property_outline_offset = [%value.rec "<extended-length>"]

and property_outline_style =
  [%value.rec "'auto' | <line-style> | <interpolation>"]

and property_outline_width = [%value.rec "<line-width> | <interpolation>"]

and property_overflow =
  [%value.rec
    "[ 'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' ]{1,2} | \
     <-non-standard-overflow> | <interpolation>"]

and property_overflow_anchor = [%value.rec "'auto' | 'none'"]

and property_overflow_block =
  [%value.rec
    "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

and property_overflow_clip_margin =
  [%value.rec "<visual-box> || <extended-length>"]

and property_overflow_inline =
  [%value.rec
    "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

and property_overflow_wrap = [%value.rec "'normal' | 'break-word' | 'anywhere'"]

and property_overflow_x =
  [%value.rec
    "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

and property_overflow_y =
  [%value.rec
    "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

and property_overscroll_behavior =
  [%value.rec "[ 'contain' | 'none' | 'auto' ]{1,2}"]

and property_overscroll_behavior_block =
  [%value.rec "'contain' | 'none' | 'auto'"]

and property_overscroll_behavior_inline =
  [%value.rec "'contain' | 'none' | 'auto'"]

and property_overscroll_behavior_x = [%value.rec "'contain' | 'none' | 'auto'"]
and property_overscroll_behavior_y = [%value.rec "'contain' | 'none' | 'auto'"]

and property_padding =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | <interpolation> ]{1,4}"]

and property_padding_block = [%value.rec "[ <'padding-left'> ]{1,2}"]
and property_padding_block_end = [%value.rec "<'padding-left'>"]
and property_padding_block_start = [%value.rec "<'padding-left'>"]

and property_padding_bottom =
  [%value.rec "<extended-length> | <extended-percentage>"]

and property_padding_inline = [%value.rec "[ <'padding-left'> ]{1,2}"]
and property_padding_inline_end = [%value.rec "<'padding-left'>"]
and property_padding_inline_start = [%value.rec "<'padding-left'>"]

and property_padding_left =
  [%value.rec "<extended-length> | <extended-percentage>"]

and property_padding_right =
  [%value.rec "<extended-length> | <extended-percentage>"]

and property_padding_top =
  [%value.rec "<extended-length> | <extended-percentage>"]

and property_page_break_after =
  [%value.rec
    "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'"]

and property_page_break_before =
  [%value.rec
    "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'"]

and property_page_break_inside = [%value.rec "'auto' | 'avoid'"]

and property_paint_order =
  [%value.rec "'normal' | 'fill' || 'stroke' || 'markers'"]

and property_pause = [%value.rec "<'pause-before'> [ <'pause-after'> ]?"]

and property_pause_after =
  [%value.rec
    "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
     'x-strong'"]

and property_pause_before =
  [%value.rec
    "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
     'x-strong'"]

and property_perspective = [%value.rec "'none' | <extended-length>"]
and property_perspective_origin = [%value.rec "<position>"]

and property_place_content =
  [%value.rec "<'align-content'> [ <'justify-content'> ]?"]

and property_place_items = [%value.rec "<'align-items'> [ <'justify-items'> ]?"]
and property_place_self = [%value.rec "<'align-self'> [ <'justify-self'> ]?"]

and property_pointer_events =
  [%value.rec
    "'auto' | 'none' | 'visiblePainted' | 'visibleFill' | 'visibleStroke' | \
     'visible' | 'painted' | 'fill' | 'stroke' | 'all' | 'inherit'"]

and property_position =
  [%value.rec
    "'static' | 'relative' | 'absolute' | 'sticky' | 'fixed' | '-webkit-sticky'"]

and property_quotes = [%value.rec "'none' | 'auto' | [ <string> <string> ]+"]

and property_resize =
  [%value.rec
    "'none' | 'both' | 'horizontal' | 'vertical' | 'block' | 'inline'"]

and property_rest = [%value.rec "<'rest-before'> [ <'rest-after'> ]?"]

and property_rest_after =
  [%value.rec
    "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
     'x-strong'"]

and property_rest_before =
  [%value.rec
    "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
     'x-strong'"]

and property_right =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and property_rotate =
  [%value.rec
    "'none' | <extended-angle> | [ 'x' | 'y' | 'z' | [ <number> ]{3} ] && \
     <extended-angle>"]

and property_row_gap =
  [%value.rec "'normal' | <extended-length> | <extended-percentage>"]

and property_ruby_align =
  [%value.rec "'start' | 'center' | 'space-between' | 'space-around'"]

and property_ruby_merge = [%value.rec "'separate' | 'collapse' | 'auto'"]
and property_ruby_position = [%value.rec "'over' | 'under' | 'inter-character'"]
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

and property_scroll_padding =
  [%value.rec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,4}"]

and property_scroll_padding_block =
  [%value.rec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]

and property_scroll_padding_block_end =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and property_scroll_padding_block_start =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and property_scroll_padding_bottom =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and property_scroll_padding_inline =
  [%value.rec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]

and property_scroll_padding_inline_end =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and property_scroll_padding_inline_start =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and property_scroll_padding_left =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and property_scroll_padding_right =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and property_scroll_padding_top =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and property_scroll_snap_align =
  [%value.rec "[ 'none' | 'start' | 'end' | 'center' ]{1,2}"]

and property_scroll_snap_coordinate = [%value.rec "'none' | [ <position> ]#"]
and property_scroll_snap_destination = [%value.rec "<position>"]

and property_scroll_snap_points_x =
  [%value.rec "'none' | repeat( <extended-length> | <extended-percentage> )"]

and property_scroll_snap_points_y =
  [%value.rec "'none' | repeat( <extended-length> | <extended-percentage> )"]

and property_scroll_snap_stop = [%value.rec "'normal' | 'always'"]

and property_scroll_snap_type =
  [%value.rec
    "'none' | [ 'x' | 'y' | 'block' | 'inline' | 'both' ] [ 'mandatory' | \
     'proximity' ]?"]

and property_scroll_snap_type_x =
  [%value.rec "'none' | 'mandatory' | 'proximity'"]

and property_scroll_snap_type_y =
  [%value.rec "'none' | 'mandatory' | 'proximity'"]

and property_scrollbar_color = [%value.rec "'auto' | [ <color> <color> ]"]
and property_scrollbar_width = [%value.rec "'auto' | 'thin' | 'none'"]

and property_scrollbar_gutter =
  [%value.rec "'auto' | 'stable' && 'both-edges'?"]

and property_scrollbar_3dlight_color = [%value.rec "<color>"]
and property_scrollbar_arrow_color = [%value.rec "<color>"]
and property_scrollbar_base_color = [%value.rec "<color>"]
and property_scrollbar_darkshadow_color = [%value.rec "<color>"]
and property_scrollbar_face_color = [%value.rec "<color>"]
and property_scrollbar_highlight_color = [%value.rec "<color>"]
and property_scrollbar_shadow_color = [%value.rec "<color>"]
and property_scrollbar_track_color = [%value.rec "<color>"]
and property_shape_image_threshold = [%value.rec "<alpha-value>"]

and property_shape_margin =
  [%value.rec "<extended-length> | <extended-percentage>"]

and property_shape_outside =
  [%value.rec "'none' | <shape-box> || <basic-shape> | <image>"]

and property_shape_rendering =
  [%value.rec "'auto' | 'optimizeSpeed' | 'crispEdges' | 'geometricPrecision'"]

and property_speak = [%value.rec "'auto' | 'none' | 'normal'"]

and property_speak_as =
  [%value.rec
    "'normal' | 'spell-out' || 'digits' || [ 'literal-punctuation' | \
     'no-punctuation' ]"]

and property_src =
  [%value.rec
    "[ <url> [ format( [ <string> ]# ) ]? | local( <family-name> ) ]#"]

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

and property_text_autospace =
  [%value.rec
    "'none' | 'ideograph-alpha' | 'ideograph-numeric' | \
     'ideograph-parenthesis' | 'ideograph-space'"]

and property_text_blink = [%value.rec "'none' | 'blink' | 'blink-anywhere'"]

and property_text_align =
  [%value.rec
    "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | \
     'match-parent' | 'justify-all'"]

and property_text_align_all =
  [%value.rec
    "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent'"]

and property_text_align_last =
  [%value.rec
    "'auto' | 'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | \
     'match-parent'"]

and property_text_anchor = [%value.rec "'start' | 'middle' | 'end'"]

and property_text_combine_upright =
  [%value.rec "'none' | 'all' | 'digits' [ <integer> ]?"]

and property_text_decoration =
  [%value.rec
    "<'text-decoration-color'> || <'text-decoration-style'> || \
     <'text-decoration-thickness'> || <'text-decoration-line'>"]

and property_text_justify_trim = [%value.rec "'none' | 'all' | 'auto'"]

and property_text_kashida =
  [%value.rec "'none' | 'horizontal' | 'vertical' | 'both'"]

and property_text_kashida_space = [%value.rec "'normal' | 'pre' | 'post'"]
and property_text_decoration_color = [%value.rec "<color>"]

(* Spec doesn't contain spelling-error and grammar-error: https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-line but this list used to have them | 'spelling-error' | 'grammar-error'. Leaving this comment here for reference *)
(* and this definition has changed from the origianl, it might be a bug on the spec or our Generator,
   but simplifying to "|" simplifies it and solves the bug *)
and property_text_decoration_line =
  [%value.rec
    "'none' | <interpolation> | [ 'underline' || 'overline' || 'line-through' \
     || 'blink' ]"]

and property_text_decoration_skip =
  [%value.rec
    "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' \
     ] || 'edges' || 'box-decoration'"]

and property_text_decoration_skip_self =
  [%value.rec
    "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' \
     ] || 'edges' || 'box-decoration'"]

and property_text_decoration_skip_ink = [%value.rec "'auto' | 'all' | 'none'"]
and property_text_decoration_skip_box = [%value.rec "'none' | 'all'"]

and property_text_decoration_skip_spaces =
  [%value.rec
    "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' \
     ] || 'edges' || 'box-decoration'"]

and property_text_decoration_skip_inset = [%value.rec "'none' | 'auto'"]

and property_text_decoration_style =
  [%value.rec "'solid' | 'double' | 'dotted' | 'dashed' | 'wavy'"]

and property_text_decoration_thickness =
  [%value.rec
    "'auto' | 'from-font' | <extended-length> | <extended-percentage>"]

and property_text_emphasis =
  [%value.rec "<'text-emphasis-style'> || <'text-emphasis-color'>"]

and property_text_emphasis_color = [%value.rec "<color>"]

and property_text_emphasis_position =
  [%value.rec "[ 'over' | 'under' ] && [ 'right' | 'left' ]?"]

and property_text_emphasis_style =
  [%value.rec
    "'none' | [ 'filled' | 'open' ] || [ 'dot' | 'circle' | 'double-circle' | \
     'triangle' | 'sesame' ] | <string>"]

and property_text_indent =
  [%value.rec
    "[<extended-length> | <extended-percentage>] && [ 'hanging' ]? && [ \
     'each-line' ]?"]

and property_text_justify =
  [%value.rec "'auto' | 'inter-character' | 'inter-word' | 'none'"]

and property_text_orientation = [%value.rec "'mixed' | 'upright' | 'sideways'"]

and property_text_overflow =
  [%value.rec "[ 'clip' | 'ellipsis' | <string> ]{1,2}"]

and property_text_rendering =
  [%value.rec
    "'auto' | 'optimizeSpeed' | 'optimizeLegibility' | 'geometricPrecision'"]

and property_text_shadow =
  [%value.rec "'none' | <interpolation> | [ <shadow-t> ]#"]

and property_text_size_adjust =
  [%value.rec "'none' | 'auto' | <extended-percentage>"]

and property_text_transform =
  [%value.rec
    "'none' | 'capitalize' | 'uppercase' | 'lowercase' | 'full-width' | \
     'full-size-kana'"]

and property_text_underline_offset =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and property_text_underline_position =
  [%value.rec "'auto' | 'from-font' | 'under' || [ 'left' | 'right' ]"]

and property_top =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and property_touch_action =
  [%value.rec
    "'auto' | 'none' | [ 'pan-x' | 'pan-left' | 'pan-right' ] || [ 'pan-y' | \
     'pan-up' | 'pan-down' ] || 'pinch-zoom' | 'manipulation'"]

and property_transform = [%value.rec "'none' | <transform-list>"]

and property_transform_box =
  [%value.rec
    "'content-box' | 'border-box' | 'fill-box' | 'stroke-box' | 'view-box'"]

and property_transform_origin =
  [%value.rec
    "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ]\n\
    \  | [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | \
     'center' | 'bottom' | <length-percentage> ] <length>?\n\
    \  | [[ 'center' | 'left' | 'right' ] && [ 'center' | 'top' | 'bottom' ]] \
     <length>? "]

and property_transform_style = [%value.rec "'flat' | 'preserve-3d'"]

and property_transition =
  [%value.rec "[ <single-transition> | <single-transition-no-interp> ]#"]

and property_transition_behavior = [%value.rec "<transition-behavior-value>#"]
and property_transition_delay = [%value.rec "[ <extended-time> ]#"]
and property_transition_duration = [%value.rec "[ <extended-time> ]#"]

and property_transition_property =
  [%value.rec "[ <single-transition-property> ]# | 'none'"]

and property_transition_timing_function = [%value.rec "[ <timing-function> ]#"]

and property_translate =
  [%value.rec "'none' | <length-percentage> [ <length-percentage> <length>? ]?"]

and property_unicode_bidi =
  [%value.rec
    "'normal' | 'embed' | 'isolate' | 'bidi-override' | 'isolate-override' | \
     'plaintext' | '-moz-isolate' | '-moz-isolate-override' | '-moz-plaintext' \
     | '-webkit-isolate'"]

and property_unicode_range = [%value.rec "[ <urange> ]#"]

and property_user_select =
  [%value.rec "'auto' | 'text' | 'none' | 'contain' | 'all' | <interpolation>"]

and property_vertical_align =
  [%value.rec
    "'baseline' | 'sub' | 'super' | 'text-top' | 'text-bottom' | 'middle' | \
     'top' | 'bottom' | <extended-percentage> | <extended-length>"]

and property_visibility =
  [%value.rec "'visible' | 'hidden' | 'collapse' | <interpolation>"]

and property_voice_balance =
  [%value.rec
    "<number> | 'left' | 'center' | 'right' | 'leftwards' | 'rightwards'"]

and property_voice_duration = [%value.rec "'auto' | <extended-time>"]

and property_voice_family =
  [%value.rec
    "[ [ <family-name> | <generic-voice> ] ',' ]* [ <family-name> | \
     <generic-voice> ] | 'preserve'"]

and property_voice_pitch =
  [%value.rec
    "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | \
     'high' | 'x-high' ] || [ <extended-frequency> | <semitones> | \
     <extended-percentage> ]"]

and property_voice_range =
  [%value.rec
    "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | \
     'high' | 'x-high' ] || [ <extended-frequency> | <semitones> | \
     <extended-percentage> ]"]

and property_voice_rate =
  [%value.rec
    "[ 'normal' | 'x-slow' | 'slow' | 'medium' | 'fast' | 'x-fast' ] || \
     <extended-percentage>"]

and property_voice_stress =
  [%value.rec "'normal' | 'strong' | 'moderate' | 'none' | 'reduced'"]

and property_voice_volume =
  [%value.rec
    "'silent' | [ 'x-soft' | 'soft' | 'medium' | 'loud' | 'x-loud' ] || \
     <decibel>"]

and property_white_space =
  [%value.rec
    "'normal' | 'pre' | 'nowrap' | 'pre-wrap' | 'pre-line' | 'break-spaces'"]

and property_widows = [%value.rec "<integer>"]

and property_width =
  [%value.rec
    "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
     'max-content' | 'fit-content' | fit-content( <extended-length> | \
     <extended-percentage> )"]

and property_will_change = [%value.rec "'auto' | [ <animateable-feature> ]#"]

and property_word_break =
  [%value.rec "'normal' | 'break-all' | 'keep-all' | 'break-word'"]

and property_word_spacing =
  [%value.rec "'normal' | <extended-length> | <extended-percentage>"]

and property_word_wrap = [%value.rec "'normal' | 'break-word' | 'anywhere'"]

and property_writing_mode =
  [%value.rec
    "'horizontal-tb' | 'vertical-rl' | 'vertical-lr' | 'sideways-rl' | \
     'sideways-lr' | <svg-writing-mode>"]

and property_z_index = [%value.rec "'auto' | <integer> | <interpolation>"]

and property_zoom =
  [%value.rec "'normal' | 'reset' | <number> | <extended-percentage>"]

and property_container =
  [%value.rec "<'container-name'> [ '/' <'container-type'> ]?"]

and property_container_name = [%value.rec "<custom-ident>+ | 'none'"]
and property_container_type = [%value.rec "'normal' | 'size' | 'inline-size'"]
and property_nav_down = [%value.rec "'auto' | <integer> | <interpolation>"]
and property_nav_left = [%value.rec "'auto' | <integer> | <interpolation>"]
and property_nav_right = [%value.rec "'auto' | <integer> | <interpolation>"]
and property_nav_up = [%value.rec "'auto' | <integer> | <interpolation>"]
and property_accent_color = [%value.rec "'auto' | <color>"]

and property_animation_composition =
  [%value.rec "[ 'replace' | 'add' | 'accumulate' ]#"]

and property_animation_range =
  [%value.rec "[ 'normal' | <extended-length> | <extended-percentage> ]{1,2}"]

and property_animation_range_end =
  [%value.rec "'normal' | <extended-length> | <extended-percentage>"]

and property_animation_range_start =
  [%value.rec "'normal' | <extended-length> | <extended-percentage>"]

and property_animation_timeline = [%value.rec "[ 'none' | <custom-ident> ]#"]
and property_field_sizing = [%value.rec "'content' | 'fixed'"]
and property_interpolate_size = [%value.rec "'numeric-only' | 'allow-keywords'"]
and property_media_type = [%value.rec "<ident>"]
and property_overlay = [%value.rec "'none' | 'auto'"]

and property_scroll_timeline =
  [%value.rec
    "[ 'none' | <custom-ident> ]# [ 'block' | 'inline' | 'x' | 'y' ]#"]

and property_scroll_timeline_axis =
  [%value.rec "[ 'block' | 'inline' | 'x' | 'y' ]#"]

and property_scroll_timeline_name = [%value.rec "[ 'none' | <custom-ident> ]#"]

and property_text_wrap =
  [%value.rec "'wrap' | 'nowrap' | 'balance' | 'stable' | 'pretty'"]

and property_view_timeline =
  [%value.rec
    "[ 'none' | <custom-ident> ]# [ 'block' | 'inline' | 'x' | 'y' ]#"]

and property_view_timeline_axis =
  [%value.rec "[ 'block' | 'inline' | 'x' | 'y' ]#"]

and property_view_timeline_inset =
  [%value.rec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]

and property_view_timeline_name = [%value.rec "[ 'none' | <custom-ident> ]#"]
and property_view_transition_name = [%value.rec "'none' | <custom-ident>"]
and property_anchor_name = [%value.rec "'none' | [ <dashed-ident> ]#"]
and property_anchor_scope = [%value.rec "'none' | 'all' | [ <dashed-ident> ]#"]
and property_position_anchor = [%value.rec "'auto' | <dashed-ident>"]

and property_position_area =
  [%value.rec
    "'none' | [ 'top' | 'bottom' | 'left' | 'right' | 'center' | 'self-start' \
     | 'self-end' | 'start' | 'end' ]"]

and property_position_try =
  [%value.rec "'none' | [ <dashed-ident> | <try-tactic> ]#"]

and property_position_try_fallbacks =
  [%value.rec "'none' | [ <dashed-ident> | <try-tactic> ]#"]

and property_position_try_options =
  [%value.rec "'none' | [ 'flip-block' || 'flip-inline' || 'flip-start' ]"]

and property_position_visibility =
  [%value.rec "'always' | 'anchors-valid' | 'anchors-visible' | 'no-overflow'"]

and property_inset_area =
  [%value.rec
    "'none' | [ 'top' | 'bottom' | 'left' | 'right' | 'center' | 'self-start' \
     | 'self-end' | 'start' | 'end' ]{1,2}"]

and property_scroll_start =
  [%value.rec
    "'auto' | 'start' | 'end' | 'center' | 'top' | 'bottom' | 'left' | 'right' \
     | <extended-length> | <extended-percentage>"]

and property_scroll_start_block =
  [%value.rec
    "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
     <extended-percentage>"]

and property_scroll_start_inline =
  [%value.rec
    "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
     <extended-percentage>"]

and property_scroll_start_x =
  [%value.rec
    "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
     <extended-percentage>"]

and property_scroll_start_y =
  [%value.rec
    "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
     <extended-percentage>"]

and property_scroll_start_target = [%value.rec "'none' | 'auto'"]
and property_scroll_start_target_block = [%value.rec "'none' | 'auto'"]
and property_scroll_start_target_inline = [%value.rec "'none' | 'auto'"]
and property_scroll_start_target_x = [%value.rec "'none' | 'auto'"]
and property_scroll_start_target_y = [%value.rec "'none' | 'auto'"]

and property_text_spacing_trim =
  [%value.rec "'normal' | 'space-all' | 'space-first' | 'trim-start'"]

and property_word_space_transform =
  [%value.rec "'none' | 'auto' | 'ideograph-alpha' | 'ideograph-numeric'"]

and property_reading_flow =
  [%value.rec
    "'normal' | 'flex-visual' | 'flex-flow' | 'grid-rows' | 'grid-columns' | \
     'grid-order'"]

and property_math_depth =
  [%value.rec "'auto-add' | 'add(' <integer> ')' | <integer>"]

and property_math_shift = [%value.rec "'normal' | 'compact'"]
and property_math_style = [%value.rec "'normal' | 'compact'"]
and property_text_wrap_mode = [%value.rec "'wrap' | 'nowrap'"]

and property_text_wrap_style =
  [%value.rec "'auto' | 'balance' | 'stable' | 'pretty'"]

and property_white_space_collapse =
  [%value.rec
    "'collapse' | 'preserve' | 'preserve-breaks' | 'preserve-spaces' | \
     'break-spaces'"]

and property_text_box_trim =
  [%value.rec "'none' | 'trim-start' | 'trim-end' | 'trim-both'"]

and property_text_box_edge =
  [%value.rec "'leading' | 'text' | 'cap' | 'ex' | 'alphabetic'"]

(* Print and paged media properties *)
and property_page = [%value.rec "'auto' | <custom-ident>"]

and property_size =
  [%value.rec
    "<extended-length>{1,2} | 'auto' | [ 'A5' | 'A4' | 'A3' | 'B5' | 'B4' | \
     'JIS-B5' | 'JIS-B4' | 'letter' | 'legal' | 'ledger' ] [ 'portrait' | \
     'landscape' ]?"]

and property_marks = [%value.rec "'none' | 'crop' || 'cross'"]
and property_bleed = [%value.rec "'auto' | <extended-length>"]

(* More modern layout and effect properties *)
and property_backdrop_blur = [%value.rec "<extended-length>"]
and property_scrollbar_color_legacy = [%value.rec "<color>"]

(* SVG paint server properties *)
and property_stop_color = [%value.rec "<color>"]
and property_stop_opacity = [%value.rec "<alpha-value>"]
and property_flood_color = [%value.rec "<color>"]
and property_flood_opacity = [%value.rec "<alpha-value>"]
and property_lighting_color = [%value.rec "<color>"]

and property_color_rendering =
  [%value.rec "'auto' | 'optimizeSpeed' | 'optimizeQuality'"]

and property_vector_effect = [%value.rec "'none' | 'non-scaling-stroke'"]

(* SVG geometry properties *)
and property_cx = [%value.rec "<extended-length> | <extended-percentage>"]
and property_cy = [%value.rec "<extended-length> | <extended-percentage>"]
and property_d = [%value.rec "'none' | <string>"]
and property_r = [%value.rec "<extended-length> | <extended-percentage>"]

and property_rx =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and property_ry =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and property_x = [%value.rec "<extended-length> | <extended-percentage>"]
and property_y = [%value.rec "<extended-length> | <extended-percentage>"]

(* Contain intrinsic sizing *)
and property_contain_intrinsic_size =
  [%value.rec "'none' | [ 'auto' ]? <extended-length>{1,2}"]

and property_contain_intrinsic_width =
  [%value.rec "'none' | 'auto' <extended-length> | <extended-length>"]

and property_contain_intrinsic_height =
  [%value.rec "'none' | 'auto' <extended-length> | <extended-length>"]

and property_contain_intrinsic_block_size =
  [%value.rec "'none' | 'auto' <extended-length> | <extended-length>"]

and property_contain_intrinsic_inline_size =
  [%value.rec "'none' | 'auto' <extended-length> | <extended-length>"]

(* Print *)
and property_print_color_adjust = [%value.rec "'economy' | 'exact'"]

(* Ruby *)
and property_ruby_overhang = [%value.rec "'auto' | 'none'"]

(* Timeline scope *)
and property_timeline_scope =
  [%value.rec "[ 'none' | <custom-ident> | <dashed-ident> ]#"]

(* Scroll driven animations *)
and property_animation_delay_end = [%value.rec "[ <extended-time> ]#"]
and property_animation_delay_start = [%value.rec "[ <extended-time> ]#"]

(* Custom properties for at-rules *)
and property_syntax = [%value.rec "<string>"]
and property_inherits = [%value.rec "'true' | 'false'"]
and property_initial_value = [%value.rec "<string>"]

(* Additional modern properties *)
and property_scroll_marker_group = [%value.rec "'none' | 'before' | 'after'"]

and property_container_name_computed =
  [%value.rec "'none' | [ <custom-ident> ]#"]

and property_text_edge = [%value.rec "[ 'leading' | <'text-box-edge'> ]{1,2}"]

and property_hyphenate_limit_last =
  [%value.rec "'none' | 'always' | 'column' | 'page' | 'spread'"]

and pseudo_class_selector =
  [%value.rec "':' <ident-token> | ':' <function-token> <any-value> ')'"]

and pseudo_element_selector = [%value.rec "':' <pseudo-class-selector>"]
and pseudo_page = [%value.rec "':' [ 'left' | 'right' | 'first' | 'blank' ]"]

and quote =
  [%value.rec
    "'open-quote' | 'close-quote' | 'no-open-quote' | 'no-close-quote'"]

and ratio = [%value.rec "<integer> '/' <integer> | <number> | <interpolation>"]
and relative_selector = [%value.rec "[ <combinator> ]? <complex-selector>"]
and relative_selector_list = [%value.rec "[ <relative-selector> ]#"]
and relative_size = [%value.rec "'larger' | 'smaller'"]

and repeat_style =
  [%value.rec
    "'repeat-x' | 'repeat-y' | [ 'repeat' | 'space' | 'round' | 'no-repeat' ] \
     [ 'repeat' | 'space' | 'round' | 'no-repeat' ]?"]

and right = [%value.rec "<extended-length> | 'auto'"]

and self_position =
  [%value.rec
    "'center' | 'start' | 'end' | 'self-start' | 'self-end' | 'flex-start' | \
     'flex-end'"]

and shadow =
  [%value.rec
    "[ 'inset' ]? [ <extended-length> | <interpolation> ]{4} [ <color> | \
     <interpolation> ]?"]

and shadow_t =
  [%value.rec
    "[ <extended-length> | <interpolation> ]{3} [ <color> | <interpolation> ]?"]

and shape =
  [%value.rec
    "rect( <top> ',' <right> ',' <bottom> ',' <left> ) | rect( <top> <right> \
     <bottom> <left> )"]

and shape_box = [%value.rec "<box> | 'margin-box'"]

and shape_radius =
  [%value.rec
    "<extended-length> | <extended-percentage> | 'closest-side' | \
     'farthest-side'"]

and side_or_corner = [%value.rec "[ 'left' | 'right' ] || [ 'top' | 'bottom' ]"]

and single_animation =
  [%value.rec
    "[ [ <keyframes-name> | 'none' | <interpolation> ] ]\n\
    \  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> ]\n\
    \  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> \
     <timing-function> ]\n\
    \  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> \
     <timing-function> <extended-time> ]\n\
    \  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> \
     <timing-function> <extended-time> <single-animation-iteration-count> ]\n\
    \  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> \
     <timing-function> <extended-time> <single-animation-iteration-count> \
     <single-animation-direction> ]\n\
    \  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> \
     <timing-function> <extended-time> <single-animation-iteration-count> \
     <single-animation-direction> <single-animation-fill-mode> ]\n\
    \  | [ [ <keyframes-name> | 'none' | <interpolation> ] <extended-time> \
     <timing-function> <extended-time> <single-animation-iteration-count> \
     <single-animation-direction> <single-animation-fill-mode> \
     <single-animation-play-state> ]"]

and single_animation_no_interp =
  [%value.rec
    "[ <keyframes-name> | 'none' ] || <extended-time-no-interp> || \
     <timing-function-no-interp> || <extended-time-no-interp> || \
     <single-animation-iteration-count-no-interp> || \
     <single-animation-direction-no-interp> || \
     <single-animation-fill-mode-no-interp> || \
     <single-animation-play-state-no-interp>"]

and single_animation_direction =
  [%value.rec
    "'normal' | 'reverse' | 'alternate' | 'alternate-reverse' | <interpolation>"]

and single_animation_direction_no_interp =
  [%value.rec "'normal' | 'reverse' | 'alternate' | 'alternate-reverse'"]

and single_animation_fill_mode =
  [%value.rec "'none' | 'forwards' | 'backwards' | 'both' | <interpolation>"]

and single_animation_fill_mode_no_interp =
  [%value.rec "'none' | 'forwards' | 'backwards' | 'both'"]

and single_animation_iteration_count =
  [%value.rec "'infinite' | <number> | <interpolation>"]

and single_animation_iteration_count_no_interp =
  [%value.rec "'infinite' | <number>"]

and single_animation_play_state =
  [%value.rec "'running' | 'paused' | <interpolation>"]

and single_animation_play_state_no_interp = [%value.rec "'running' | 'paused'"]

and single_transition_no_interp =
  [%value.rec
    "[ <single-transition-property-no-interp> | 'none' ] || \
     <extended-time-no-interp> || <timing-function-no-interp> || \
     <extended-time-no-interp> || <transition-behavior-value-no-interp>"]

and single_transition =
  [%value.rec
    "[<single-transition-property> | 'none']\n\
    \  | [ [<single-transition-property> | 'none'] <extended-time> ]\n\
    \  | [ [<single-transition-property> | 'none'] <extended-time> \
     <timing-function> ]\n\
    \  | [ [<single-transition-property> | 'none'] <extended-time> \
     <timing-function> <extended-time> ]\n\
    \  | [ [<single-transition-property> | 'none'] <extended-time> \
     <timing-function> <extended-time> <transition-behavior-value> ]"]

and single_transition_property =
  [%value.rec "<custom-ident> | <interpolation> | 'all'"]

and single_transition_property_no_interp = [%value.rec "<custom-ident> | 'all'"]

and size =
  [%value.rec
    "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
     <extended-length> | [ <extended-length> | <extended-percentage> ]{2}"]

and ray_size =
  [%value.rec
    "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
     'sides'"]

and radial_size =
  [%value.rec
    "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
     <extended-length> | [ <extended-length> | <extended-percentage> ]{2}"]

and step_position =
  [%value.rec
    "'jump-start' | 'jump-end' | 'jump-none' | 'jump-both' | 'start' | 'end'"]

and step_timing_function =
  [%value.rec
    "'step-start' | 'step-end' | steps( <integer> [ ',' <step-position> ]? )"]

and subclass_selector =
  [%value.rec
    "<id-selector> | <class-selector> | <attribute-selector> | \
     <pseudo-class-selector>"]

and supports_condition =
  [%value.rec
    "'not' <supports-in-parens> | <supports-in-parens> [ 'and' \
     <supports-in-parens> ]* | <supports-in-parens> [ 'or' \
     <supports-in-parens> ]*"]

and supports_decl = [%value.rec "'(' <declaration> ')'"]
and supports_feature = [%value.rec "<supports-decl> | <supports-selector-fn>"]

and supports_in_parens =
  [%value.rec "'(' <supports-condition> ')' | <supports-feature>"]

and supports_selector_fn = [%value.rec "selector( <complex-selector> )"]

and svg_length =
  [%value.rec "<extended-percentage> | <extended-length> | <number>"]

and svg_writing_mode =
  [%value.rec "'lr-tb' | 'rl-tb' | 'tb-rl' | 'lr' | 'rl' | 'tb'"]

and symbol = [%value.rec "<string> | <image> | <custom-ident>"]

and symbols_type =
  [%value.rec "'cyclic' | 'numeric' | 'alphabetic' | 'symbolic' | 'fixed'"]

and target =
  [%value.rec "<target-counter()> | <target-counters()> | <target-text()>"]

and url = [%value.rec "<url-no-interp> | url( <interpolation> )"]

and extended_length =
  [%value.rec "<length> | <calc()> | <interpolation> | <min()> | <max()>"]

and length_percentage = [%value.rec "<extended-length> | <extended-percentage>"]

and extended_frequency =
  [%value.rec "<frequency> | <calc()> | <interpolation> | <min()> | <max()>"]

and extended_angle =
  [%value.rec "<angle> | <calc()> | <interpolation> | <min()> | <max()>"]

and extended_time =
  [%value.rec "<time> | <calc()> | <interpolation> | <min()> | <max()>"]

and extended_time_no_interp =
  [%value.rec "<time> | <calc()> | <min()> | <max()>"]

and extended_percentage =
  [%value.rec "<percentage> | <calc()> | <interpolation> | <min()> | <max()> "]

and timing_function =
  [%value.rec
    "'linear' | <cubic-bezier-timing-function> | <step-timing-function> | \
     <interpolation>"]

and timing_function_no_interp =
  [%value.rec
    "'linear' | <cubic-bezier-timing-function> | <step-timing-function>"]

and top = [%value.rec "<extended-length> | 'auto'"]
and try_tactic = [%value.rec "'flip-block' | 'flip-inline' | 'flip-start'"]

and track_breadth =
  [%value.rec
    "<extended-length> | <extended-percentage> | <flex-value> | 'min-content' \
     | 'max-content' | 'auto'"]

and track_group =
  [%value.rec
    "'(' [ [ <string> ]* <track-minmax> [ <string> ]* ]+ ')' [ '[' \
     <positive-integer> ']' ]? | <track-minmax>"]

and track_list =
  [%value.rec
    "[ [ <line-names> ]? [ <track-size> | <track-repeat> ] ]+ [ <line-names> ]?"]

and track_list_v0 =
  [%value.rec "[ [ <string> ]* <track-group> [ <string> ]* ]+ | 'none'"]

and track_minmax =
  [%value.rec
    "minmax( <track-breadth> ',' <track-breadth> ) | 'auto' | <track-breadth> \
     | fit-content( <extended-length> | <extended-percentage> )"]

and track_repeat =
  [%value.rec
    "repeat( <positive-integer> ',' [ [ <line-names> ]? <track-size> ]+ [ \
     <line-names> ]? )"]

and track_size =
  [%value.rec
    "<track-breadth> | minmax( <inflexible-breadth> ',' <track-breadth> ) | \
     fit-content( <extended-length> | <extended-percentage> )"]

and transform_function =
  [%value.rec
    "<matrix()> | <translate()> | <translateX()> | <translateY()> | <scale()> \
     | <scaleX()> | <scaleY()> | <rotate()> | <skew()> | <skewX()> | <skewY()> \
     | <matrix3d()> | <translate3d()> | <translateZ()> | <scale3d()> | \
     <scaleZ()> | <rotate3d()> | <rotateX()> | <rotateY()> | <rotateZ()> | \
     <perspective()>"]

and transform_list = [%value.rec "[ <transform-function> ]+"]

and transition_behavior_value =
  [%value.rec "'normal' | 'allow-discrete' | <interpolation>"]

and transition_behavior_value_no_interp =
  [%value.rec "'normal' | 'allow-discrete'"]

and type_or_unit =
  [%value.rec
    "'string' | 'color' | 'url' | 'integer' | 'number' | 'length' | 'angle' | \
     'time' | 'frequency' | 'cap' | 'ch' | 'em' | 'ex' | 'ic' | 'lh' | 'rlh' | \
     'rem' | 'vb' | 'vi' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'mm' | 'Q' | 'cm' | \
     'in' | 'pt' | 'pc' | 'px' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | 's' \
     | 'Hz' | 'kHz' | '%'"]

and type_selector = [%value.rec "<wq-name> | [ <ns-prefix> ]? '*'"]

and viewport_length =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and visual_box = [%value.rec "'content-box' | 'padding-box' | 'border-box'"]
and wq_name = [%value.rec "[ <ns-prefix> ]? <ident-token>"]
and attr_name = [%value.rec "[ <ident-token>? '|' ]? <ident-token>"]

and attr_unit =
  [%value.rec
    "'%' | 'em' | 'ex' | 'ch' | 'rem' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'cm' | \
     'mm' | 'in' | 'px' | 'pt' | 'pc' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' \
     | 's' | 'Hz' | 'kHz'"]

and syntax_type_name =
  [%value.rec
    "'angle' | 'color' | 'custom-ident' | 'image' | 'integer' | 'length' | \
     'length-percentage' | 'number' | 'percentage' | 'resolution' | 'string' | \
     'time' | 'url' | 'transform-function'"]

and syntax_multiplier = [%value.rec "'#' | '+'"]

and syntax_single_component =
  [%value.rec "'<' <syntax-type-name> '>' | <ident>"]

and syntax_string = [%value.rec "<string>"]
and syntax_combinator = [%value.rec "'|'"]

and syntax_component =
  [%value.rec
    "<syntax-single-component> [ <syntax-multiplier> ]? | '<' 'transform-list' \
     '>'"]

and syntax =
  [%value.rec
    "'*' | <syntax-component> [ <syntax-combinator> <syntax-component> ]* | \
     <syntax-string>"]

(* (*
 We don't support type() yet, original spec is: "type( <syntax> ) | 'raw-string' | <attr-unit>" *) *)
and attr_type = [%value.rec "'raw-string' | <attr-unit>"]
and x = [%value.rec "<number>"]
and y = [%value.rec "<number>"]

let ( let+ ) = Result.bind

let apply_parser (parser, tokens_with_loc) =
  let open Styled_ppx_css_parser.Lexer in
  let tokens =
    tokens_with_loc
    |> List.map (fun { txt; _ } ->
         match txt with Ok token -> token | Error (token, _) -> token)
  in

  let tokens_without_ws =
    tokens |> List.filter (( != ) Styled_ppx_css_parser.Parser.WS)
  in

  let output, remaining_tokens = parser tokens_without_ws in
  let+ output =
    match output with
    | Ok data -> Ok data
    (* TODO: Don't ignore the rest of messages *)
    | Error (message :: _) -> Error message
    | Error [] -> Error "weird"
  in
  let+ () =
    match remaining_tokens with
    | [] | [ Styled_ppx_css_parser.Parser.EOF ] -> Ok ()
    | tokens ->
      let tokens = tokens |> List.map Tokens.show_token |> String.concat ", " in
      Error ("tokens remaining: " ^ tokens)
  in
  Ok output

let parse (rule_parser : 'a Rule.rule) input =
  let tokens_with_loc = Styled_ppx_css_parser.Lexer.from_string input in
  apply_parser (rule_parser, tokens_with_loc)

let check (prop : 'a Rule.rule) value = parse prop value |> Result.is_ok

(*
  Heterogeneous rule storage using first-class modules

  This solution uses existential types to store CSS property, media query, rules, values and functions that return different CSS parsed types in a single collection.
 *)

type kind =
  | Value of string
    (* CSS Value types: color, length, angle, etc. - the primitive vocabulary *)
  | Property of
      string (* CSS Properties: width, flex-basis, etc. - compose values *)
  | Media_query of string (* Media query rules *)
  | Function of string (* CSS Functions: rgb(), calc(), etc. *)

module type RULE = sig
  type result

  val rule : result Rule.rule
  val name : kind
end

(* CSS Properties *)
let prop (type a) (name : string) (rule : a Rule.rule) : (module RULE) =
  (module struct
    type result = a

    let rule = rule
    let name = Property name
  end)

(* CSS Media Queries *)
let mq (type a) (name : string) (rule : a Rule.rule) : (module RULE) =
  (module struct
    type result = a

    let rule = rule
    let name = Media_query name
  end)

(* https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Values_and_Units *)
let value (type a) (name : string) (rule : a Rule.rule) : (module RULE) =
  (module struct
    type result = a

    let rule = rule
    let name = Value name
  end)

(* CSS Functions *)
let fn (type a) (name : string) (rule : a Rule.rule) : (module RULE) =
  (module struct
    type result = a

    let rule = rule
    let name = Function name
  end)

(* type all = [
  | Types._legacy_gradient
  | Types._legacy_linear_gradient
  | Types._legacy_linear_gradient_arguments
  | Types._legacy_radial_gradient
  | Types._legacy_radial_gradient_arguments
  | Types._legacy_radial_gradient_shape
  | Types._legacy_radial_gradient_size
  | Types._legacy_repeating_linear_gradient
  | Types._legacy_repeating_radial_gradient
  | Types._non_standard_color
  | Types._non_standard_font
  | Types._non_standard_image_rendering
  | Types._non_standard_overflow
  | Types._non_standard_width
  | Types._webkit_gradient_color_stop
] *)

let packed_rules : (module RULE) list =
  [
    fn "-webkit-gradient" function__webkit_gradient;
    fn "attr" function_attr;
    fn "blur" function_blur;
    fn "brightness" function_brightness;
    fn "calc" function_calc;
    fn "circle" function_circle;
    fn "clamp" function_clamp;
    fn "conic-gradient" function_conic_gradient;
    fn "contrast" function_contrast;
    fn "counter" function_counter;
    fn "counters" function_counters;
    fn "cross-fade" function_cross_fade;
    fn "drop-shadow" function_drop_shadow;
    fn "element" function_element;
    fn "ellipse" function_ellipse;
    fn "env" function_env;
    fn "fit-content" function_fit_content;
    fn "grayscale" function_grayscale;
    fn "hsl" function_hsl;
    fn "hsla" function_hsla;
    fn "hue-rotate" function_hue_rotate;
    fn "image-set" function_image_set;
    fn "image" function_image;
    fn "inset" function_inset;
    fn "invert" function_invert;
    fn "leader" function_leader;
    fn "linear-gradient" function_linear_gradient;
    fn "matrix" function_matrix;
    fn "matrix3d" function_matrix3d;
    fn "max" function_max;
    fn "min" function_min;
    fn "minmax" function_minmax;
    fn "opacity" function_opacity;
    fn "paint" function_paint;
    fn "path" function_path;
    fn "perspective" function_perspective;
    fn "polygon" function_polygon;
    fn "radial-gradient" function_radial_gradient;
    fn "repeating-linear-gradient" function_repeating_linear_gradient;
    fn "repeating-radial-gradient" function_repeating_radial_gradient;
    fn "rgb" function_rgb;
    fn "rgba" function_rgba;
    fn "rotate" function_rotate;
    fn "rotate3d" function_rotate3d;
    fn "rotateX" function_rotateX;
    fn "rotateY" function_rotateY;
    fn "rotateZ" function_rotateZ;
    fn "saturate" function_saturate;
    fn "scale" function_scale;
    fn "scale3d" function_scale3d;
    fn "scaleX" function_scaleX;
    fn "scaleY" function_scaleY;
    fn "scaleZ" function_scaleZ;
    fn "sepia" function_sepia;
    fn "skew" function_skew;
    fn "skewX" function_skewX;
    fn "skewY" function_skewY;
    fn "symbols" function_symbols;
    fn "target-counter" function_target_counter;
    fn "target-counters" function_target_counters;
    fn "target-text" function_target_text;
    fn "translate" function_translate;
    fn "translate3d" function_translate3d;
    fn "translateX" function_translateX;
    fn "translateY" function_translateY;
    fn "translateZ" function_translateZ;
    fn "var" function_var;
    mq "and" media_and;
    mq "condition-without-or" media_condition_without_or;
    mq "condition" media_condition;
    mq "feature" media_feature;
    mq "in-parens" media_in_parens;
    mq "not" media_not;
    mq "or" media_or;
    mq "query-list" media_query_list;
    mq "query" media_query;
    mq "type" media_type;
    mq "type" property_media_type;
    prop "-moz-appearance" property__moz_appearance;
    prop "-moz-background-clip" property__moz_background_clip;
    prop "-moz-binding" property__moz_binding;
    prop "-moz-border-bottom-colors" property__moz_border_bottom_colors;
    prop "-moz-border-left-colors" property__moz_border_left_colors;
    prop "-moz-border-radius-bottomleft" property__moz_border_radius_bottomleft;
    prop "-moz-border-radius-bottomright"
      property__moz_border_radius_bottomright;
    prop "-moz-border-radius-topleft" property__moz_border_radius_topleft;
    prop "-moz-border-radius-topright" property__moz_border_radius_topright;
    prop "-moz-border-right-colors" property__moz_border_right_colors;
    prop "-moz-border-top-colors" property__moz_border_top_colors;
    prop "-moz-context-properties" property__moz_context_properties;
    prop "-moz-control-character-visibility"
      property__moz_control_character_visibility;
    prop "-moz-float-edge" property__moz_float_edge;
    prop "-moz-force-broken-image-icon" property__moz_force_broken_image_icon;
    prop "-moz-image-region" property__moz_image_region;
    prop "-moz-orient" property__moz_orient;
    prop "-moz-osx-font-smoothing" property__moz_osx_font_smoothing;
    prop "-moz-outline-radius-bottomleft"
      property__moz_outline_radius_bottomleft;
    prop "-moz-outline-radius-bottomright"
      property__moz_outline_radius_bottomright;
    prop "-moz-outline-radius-topleft" property__moz_outline_radius_topleft;
    prop "-moz-outline-radius-topright" property__moz_outline_radius_topright;
    prop "-moz-outline-radius" property__moz_outline_radius;
    prop "-moz-stack-sizing" property__moz_stack_sizing;
    prop "-moz-text-blink" property__moz_text_blink;
    prop "-moz-user-focus" property__moz_user_focus;
    prop "-moz-user-input" property__moz_user_input;
    prop "-moz-user-modify" property__moz_user_modify;
    prop "-moz-user-select" property__moz_user_select;
    prop "-moz-window-dragging" property__moz_window_dragging;
    prop "-moz-window-shadow" property__moz_window_shadow;
    prop "-webkit-appearance" property__webkit_appearance;
    prop "-webkit-background-clip" property__webkit_background_clip;
    prop "-webkit-border-before-color" property__webkit_border_before_color;
    prop "-webkit-border-before-style" property__webkit_border_before_style;
    prop "-webkit-border-before-width" property__webkit_border_before_width;
    prop "-webkit-border-before" property__webkit_border_before;
    prop "-webkit-box-orient" property_box_orient;
    prop "-webkit-box-reflect" property__webkit_box_reflect;
    prop "-webkit-box-shadow" property_box_shadow;
    prop "-webkit-column-break-after" property__webkit_column_break_after;
    prop "-webkit-column-break-before" property__webkit_column_break_before;
    prop "-webkit-column-break-inside" property__webkit_column_break_inside;
    prop "-webkit-font-smoothing" property__webkit_font_smoothing;
    prop "-webkit-line-clamp" property__webkit_line_clamp;
    prop "-webkit-mask-attachment" property__webkit_mask_attachment;
    prop "-webkit-mask-box-image" property__webkit_mask_box_image;
    prop "-webkit-mask-clip" property__webkit_mask_clip;
    prop "-webkit-mask-composite" property__webkit_mask_composite;
    prop "-webkit-mask-image" property__webkit_mask_image;
    prop "-webkit-mask-origin" property__webkit_mask_origin;
    prop "-webkit-mask-position-x" property__webkit_mask_position_x;
    prop "-webkit-mask-position-y" property__webkit_mask_position_y;
    prop "-webkit-mask-position" property__webkit_mask_position;
    prop "-webkit-mask-repeat-x" property__webkit_mask_repeat_x;
    prop "-webkit-mask-repeat-y" property__webkit_mask_repeat_y;
    prop "-webkit-mask-repeat" property__webkit_mask_repeat;
    prop "-webkit-mask-size" property__webkit_mask_size;
    prop "-webkit-mask" property__webkit_mask;
    prop "-webkit-overflow-scrolling" property__webkit_overflow_scrolling;
    prop "-webkit-print-color-adjust" property__webkit_print_color_adjust;
    prop "-webkit-tap-highlight-color" property__webkit_tap_highlight_color;
    prop "-webkit-text-fill-color" property__webkit_text_fill_color;
    prop "-webkit-text-security" property__webkit_text_security;
    prop "-webkit-text-stroke-color" property__webkit_text_stroke_color;
    prop "-webkit-text-stroke-width" property__webkit_text_stroke_width;
    prop "-webkit-text-stroke" property__webkit_text_stroke;
    prop "-webkit-touch-callout" property__webkit_touch_callout;
    prop "-webkit-user-drag" property__webkit_user_drag;
    prop "-webkit-user-modify" property__webkit_user_modify;
    prop "-webkit-user-select" property__webkit_user_select;
    prop "accent-color" property_accent_color;
    prop "align-content" property_align_content;
    prop "align-items" property_align_items;
    prop "align-self" property_align_self;
    prop "alignment-baseline" property_alignment_baseline;
    prop "all" property_all;
    prop "anchor-name" property_anchor_name;
    prop "anchor-scope" property_anchor_scope;
    prop "animation-composition" property_animation_composition;
    prop "animation-delay-end" property_animation_delay_end;
    prop "animation-delay-start" property_animation_delay_start;
    prop "animation-delay" property_animation_delay;
    prop "animation-direction" property_animation_direction;
    prop "animation-duration" property_animation_duration;
    prop "animation-fill-mode" property_animation_fill_mode;
    prop "animation-iteration-count" property_animation_iteration_count;
    prop "animation-name" property_animation_name;
    prop "animation-play-state" property_animation_play_state;
    prop "animation-range-end" property_animation_range_end;
    prop "animation-range-start" property_animation_range_start;
    prop "animation-range" property_animation_range;
    prop "animation-timeline" property_animation_timeline;
    prop "animation-timing-function" property_animation_timing_function;
    prop "animation" property_animation;
    prop "any-hover" property_media_any_hover;
    prop "any-pointer" property_media_any_pointer;
    prop "appearance" property_appearance;
    prop "aspect-ratio" property_aspect_ratio;
    prop "azimuth" property_azimuth;
    prop "backdrop-blur" property_backdrop_blur;
    prop "backdrop-filter" property_backdrop_filter;
    prop "backface-visibility" property_backface_visibility;
    prop "background-attachment" property_background_attachment;
    prop "background-blend-mode" property_background_blend_mode;
    prop "background-clip" property_background_clip;
    prop "background-color" property_background_color;
    prop "background-image" property_background_image;
    prop "background-origin" property_background_origin;
    prop "background-position-x" property_background_position_x;
    prop "background-position-y" property_background_position_y;
    prop "background-position" property_background_position;
    prop "background-repeat" property_background_repeat;
    prop "background-size" property_background_size;
    prop "background" property_background;
    prop "baseline-shift" property_baseline_shift;
    prop "behavior" property_behavior;
    prop "bleed" property_bleed;
    prop "block-overflow" property_block_overflow;
    prop "block-size" property_block_size;
    prop "border-block-color" property_border_block_color;
    prop "border-block-end-color" property_border_block_end_color;
    prop "border-block-end-style" property_border_block_end_style;
    prop "border-block-end-width" property_border_block_end_width;
    prop "border-block-end" property_border_block_end;
    prop "border-block-start-color" property_border_block_start_color;
    prop "border-block-start-style" property_border_block_start_style;
    prop "border-block-start-width" property_border_block_start_width;
    prop "border-block-start" property_border_block_start;
    prop "border-block-style" property_border_block_style;
    prop "border-block-width" property_border_block_width;
    prop "border-block" property_border_block;
    prop "border-bottom-color" property_border_bottom_color;
    prop "border-bottom-left-radius" property_border_bottom_left_radius;
    prop "border-bottom-right-radius" property_border_bottom_right_radius;
    prop "border-bottom-style" property_border_bottom_style;
    prop "border-bottom-width" property_border_bottom_width;
    prop "border-bottom" property_border_bottom;
    prop "border-collapse" property_border_collapse;
    prop "border-color" property_border_color;
    prop "border-end-end-radius" property_border_end_end_radius;
    prop "border-end-start-radius" property_border_end_start_radius;
    prop "border-image-outset" property_border_image_outset;
    prop "border-image-repeat" property_border_image_repeat;
    prop "border-image-slice" property_border_image_slice;
    prop "border-image-source" property_border_image_source;
    prop "border-image-width" property_border_image_width;
    prop "border-image" property_border_image;
    prop "border-inline-color" property_border_inline_color;
    prop "border-inline-end-color" property_border_inline_end_color;
    prop "border-inline-end-style" property_border_inline_end_style;
    prop "border-inline-end-width" property_border_inline_end_width;
    prop "border-inline-end" property_border_inline_end;
    prop "border-inline-start-color" property_border_inline_start_color;
    prop "border-inline-start-style" property_border_inline_start_style;
    prop "border-inline-start-width" property_border_inline_start_width;
    prop "border-inline-start" property_border_inline_start;
    prop "border-inline-style" property_border_inline_style;
    prop "border-inline-width" property_border_inline_width;
    prop "border-inline" property_border_inline;
    prop "border-left-color" property_border_left_color;
    prop "border-left-style" property_border_left_style;
    prop "border-left-width" property_border_left_width;
    prop "border-left" property_border_left;
    prop "border-radius" property_border_radius;
    prop "border-right-color" property_border_right_color;
    prop "border-right-style" property_border_right_style;
    prop "border-right-width" property_border_right_width;
    prop "border-right" property_border_right;
    prop "border-spacing" property_border_spacing;
    prop "border-start-end-radius" property_border_start_end_radius;
    prop "border-start-start-radius" property_border_start_start_radius;
    prop "border-style" property_border_style;
    prop "border-top-color" property_border_top_color;
    prop "border-top-left-radius" property_border_top_left_radius;
    prop "border-top-right-radius" property_border_top_right_radius;
    prop "border-top-style" property_border_top_style;
    prop "border-top-width" property_border_top_width;
    prop "border-top" property_border_top;
    prop "border-width" property_border_width;
    prop "border" property_border;
    prop "bottom" property_bottom;
    prop "box-align" property_box_align;
    prop "box-decoration-break" property_box_decoration_break;
    prop "box-direction" property_box_direction;
    prop "box-flex-group" property_box_flex_group;
    prop "box-flex" property_box_flex;
    prop "box-lines" property_box_lines;
    prop "box-ordinal-group" property_box_ordinal_group;
    prop "box-orient" property_box_orient;
    prop "box-pack" property_box_pack;
    prop "box-shadow" property_box_shadow;
    prop "box-sizing" property_box_sizing;
    prop "break-after" property_break_after;
    prop "break-before" property_break_before;
    prop "break-inside" property_break_inside;
    prop "caption-side" property_caption_side;
    prop "caret-color" property_caret_color;
    prop "clear" property_clear;
    prop "clip-path" property_clip_path;
    prop "clip-rule" property_clip_rule;
    prop "clip" property_clip;
    prop "color-adjust" property_color_adjust;
    prop "color-gamut" property_media_color_gamut;
    prop "color-index" property_media_color_index;
    prop "color-interpolation-filters" property_color_interpolation_filters;
    prop "color-interpolation" property_color_interpolation;
    prop "color-rendering" property_color_rendering;
    prop "color-scheme" property_color_scheme;
    prop "color" property_color;
    prop "column-count" property_column_count;
    prop "column-fill" property_column_fill;
    prop "column-gap" property_column_gap;
    prop "column-rule-color" property_column_rule_color;
    prop "column-rule-style" property_column_rule_style;
    prop "column-rule-width" property_column_rule_width;
    prop "column-rule" property_column_rule;
    prop "column-span" property_column_span;
    prop "column-width" property_column_width;
    prop "columns" property_columns;
    prop "contain-intrinsic-block-size" property_contain_intrinsic_block_size;
    prop "contain-intrinsic-height" property_contain_intrinsic_height;
    prop "contain-intrinsic-inline-size" property_contain_intrinsic_inline_size;
    prop "contain-intrinsic-size" property_contain_intrinsic_size;
    prop "contain-intrinsic-width" property_contain_intrinsic_width;
    prop "contain" property_contain;
    prop "container-name-computed" property_container_name_computed;
    prop "container-name" property_container_name;
    prop "container-type" property_container_type;
    prop "container" property_container;
    prop "content-visibility" property_content_visibility;
    prop "content" property_content;
    prop "counter-increment" property_counter_increment;
    prop "counter-reset" property_counter_reset;
    prop "counter-set" property_counter_set;
    prop "cue-after" property_cue_after;
    prop "cue-before" property_cue_before;
    prop "cue" property_cue;
    prop "cursor" property_cursor;
    prop "cx" property_cx;
    prop "cy" property_cy;
    prop "d" property_d;
    prop "direction" property_direction;
    prop "display-mode" property_media_display_mode;
    prop "display" property_display;
    prop "dominant-baseline" property_dominant_baseline;
    prop "empty-cells" property_empty_cells;
    prop "field-sizing" property_field_sizing;
    prop "fill-opacity" property_fill_opacity;
    prop "fill-rule" property_fill_rule;
    prop "fill" property_fill;
    prop "filter" property_filter;
    prop "flex-basis" property_flex_basis;
    prop "flex-direction" property_flex_direction;
    prop "flex-flow" property_flex_flow;
    prop "flex-grow" property_flex_grow;
    prop "flex-shrink" property_flex_shrink;
    prop "flex-wrap" property_flex_wrap;
    prop "flex" property_flex;
    prop "float" property_float;
    prop "flood-color" property_flood_color;
    prop "flood-opacity" property_flood_opacity;
    prop "font-display" property_font_display;
    prop "font-family" property_font_family;
    prop "font-feature-settings" property_font_feature_settings;
    prop "font-kerning" property_font_kerning;
    prop "font-language-override" property_font_language_override;
    prop "font-optical-sizing" property_font_optical_sizing;
    prop "font-palette" property_font_palette;
    prop "font-size-adjust" property_font_size_adjust;
    prop "font-size" property_font_size;
    prop "font-smooth" property_font_smooth;
    prop "font-stretch" property_font_stretch;
    prop "font-style" property_font_style;
    prop "font-synthesis-position" property_font_synthesis_position;
    prop "font-synthesis-small-caps" property_font_synthesis_small_caps;
    prop "font-synthesis-style" property_font_synthesis_style;
    prop "font-synthesis-weight" property_font_synthesis_weight;
    prop "font-synthesis" property_font_synthesis;
    prop "font-variant-alternates" property_font_variant_alternates;
    prop "font-variant-caps" property_font_variant_caps;
    prop "font-variant-east-asian" property_font_variant_east_asian;
    prop "font-variant-emoji" property_font_variant_emoji;
    prop "font-variant-ligatures" property_font_variant_ligatures;
    prop "font-variant-numeric" property_font_variant_numeric;
    prop "font-variant-position" property_font_variant_position;
    prop "font-variant" property_font_variant;
    prop "font-variation-settings" property_font_variation_settings;
    prop "font-weight" property_font_weight;
    prop "font" property_font;
    prop "forced-color-adjust" property_forced_color_adjust;
    prop "forced-colors" property_media_forced_colors;
    prop "gap" property_gap;
    prop "glyph-orientation-horizontal" property_glyph_orientation_horizontal;
    prop "glyph-orientation-vertical" property_glyph_orientation_vertical;
    prop "grid-area" property_grid_area;
    prop "grid-auto-columns" property_grid_auto_columns;
    prop "grid-auto-flow" property_grid_auto_flow;
    prop "grid-auto-rows" property_grid_auto_rows;
    prop "grid-column-end" property_grid_column_end;
    prop "grid-column-gap" property_grid_column_gap;
    prop "grid-column-start" property_grid_column_start;
    prop "grid-column" property_grid_column;
    prop "grid-gap" property_grid_gap;
    prop "grid-row-end" property_grid_row_end;
    prop "grid-row-gap" property_grid_row_gap;
    prop "grid-row-start" property_grid_row_start;
    prop "grid-row" property_grid_row;
    prop "grid-template-areas" property_grid_template_areas;
    prop "grid-template-columns" property_grid_template_columns;
    prop "grid-template-rows" property_grid_template_rows;
    prop "grid-template" property_grid_template;
    prop "grid" property_grid;
    prop "grid" property_media_grid;
    prop "hanging-punctuation" property_hanging_punctuation;
    prop "height" property_height;
    prop "hover" property_media_hover;
    prop "hyphenate-character" property_hyphenate_character;
    prop "hyphenate-limit-chars" property_hyphenate_limit_chars;
    prop "hyphenate-limit-last" property_hyphenate_limit_last;
    prop "hyphenate-limit-lines" property_hyphenate_limit_lines;
    prop "hyphenate-limit-zone" property_hyphenate_limit_zone;
    prop "hyphens" property_hyphens;
    prop "image-orientation" property_image_orientation;
    prop "image-rendering" property_image_rendering;
    prop "image-resolution" property_image_resolution;
    prop "ime-mode" property_ime_mode;
    prop "inherits" property_inherits;
    prop "initial-letter-align" property_initial_letter_align;
    prop "initial-letter" property_initial_letter;
    prop "initial-value" property_initial_value;
    prop "inline-size" property_inline_size;
    prop "inset-area" property_inset_area;
    prop "inset-block-end" property_inset_block_end;
    prop "inset-block-start" property_inset_block_start;
    prop "inset-block" property_inset_block;
    prop "inset-inline-end" property_inset_inline_end;
    prop "inset-inline-start" property_inset_inline_start;
    prop "inset-inline" property_inset_inline;
    prop "inset" property_inset;
    prop "interpolate-size" property_interpolate_size;
    prop "inverted-colors" property_media_inverted_colors;
    prop "isolation" property_isolation;
    prop "justify-content" property_justify_content;
    prop "justify-items" property_justify_items;
    prop "justify-self" property_justify_self;
    prop "kerning" property_kerning;
    prop "layout-grid-char" property_layout_grid_char;
    prop "layout-grid-line" property_layout_grid_line;
    prop "layout-grid-mode" property_layout_grid_mode;
    prop "layout-grid-type" property_layout_grid_type;
    prop "layout-grid" property_layout_grid;
    prop "left" property_left;
    prop "letter-spacing" property_letter_spacing;
    prop "lighting-color" property_lighting_color;
    prop "line-break" property_line_break;
    prop "line-clamp" property_line_clamp;
    prop "line-height-step" property_line_height_step;
    prop "line-height" property_line_height;
    prop "list-style-image" property_list_style_image;
    prop "list-style-position" property_list_style_position;
    prop "list-style-type" property_list_style_type;
    prop "list-style" property_list_style;
    prop "margin-block-end" property_margin_block_end;
    prop "margin-block-start" property_margin_block_start;
    prop "margin-block" property_margin_block;
    prop "margin-bottom" property_margin_bottom;
    prop "margin-inline-end" property_margin_inline_end;
    prop "margin-inline-start" property_margin_inline_start;
    prop "margin-inline" property_margin_inline;
    prop "margin-left" property_margin_left;
    prop "margin-right" property_margin_right;
    prop "margin-top" property_margin_top;
    prop "margin-trim" property_margin_trim;
    prop "margin" property_margin;
    prop "marker-end" property_marker_end;
    prop "marker-mid" property_marker_mid;
    prop "marker-start" property_marker_start;
    prop "marker" property_marker;
    prop "marks" property_marks;
    prop "mask-border-mode" property_mask_border_mode;
    prop "mask-border-outset" property_mask_border_outset;
    prop "mask-border-repeat" property_mask_border_repeat;
    prop "mask-border-slice" property_mask_border_slice;
    prop "mask-border-source" property_mask_border_source;
    prop "mask-border-width" property_mask_border_width;
    prop "mask-border" property_mask_border;
    prop "mask-clip" property_mask_clip;
    prop "mask-composite" property_mask_composite;
    prop "mask-image" property_mask_image;
    prop "mask-mode" property_mask_mode;
    prop "mask-origin" property_mask_origin;
    prop "mask-position" property_mask_position;
    prop "mask-repeat" property_mask_repeat;
    prop "mask-size" property_mask_size;
    prop "mask-type" property_mask_type;
    prop "mask" property_mask;
    prop "masonry-auto-flow" property_masonry_auto_flow;
    prop "math-depth" property_math_depth;
    prop "math-shift" property_math_shift;
    prop "math-style" property_math_style;
    prop "max-aspect-ratio" property_media_max_aspect_ratio;
    prop "max-block-size" property_max_block_size;
    prop "max-height" property_max_height;
    prop "max-inline-size" property_max_inline_size;
    prop "max-lines" property_max_lines;
    prop "max-resolution" property_media_max_resolution;
    prop "max-width" property_max_width;
    prop "min-aspect-ratio" property_media_min_aspect_ratio;
    prop "min-block-size" property_min_block_size;
    prop "min-color-index" property_media_min_color_index;
    prop "min-color" property_media_min_color;
    prop "min-height" property_min_height;
    prop "min-inline-size" property_min_inline_size;
    prop "min-resolution" property_media_min_resolution;
    prop "min-width" property_min_width;
    prop "mix-blend-mode" property_mix_blend_mode;
    prop "monochrome" property_media_monochrome;
    prop "nav-down" property_nav_down;
    prop "nav-left" property_nav_left;
    prop "nav-right" property_nav_right;
    prop "nav-up" property_nav_up;
    prop "object-fit" property_object_fit;
    prop "object-position" property_object_position;
    prop "offset-anchor" property_offset_anchor;
    prop "offset-distance" property_offset_distance;
    prop "offset-path" property_offset_path;
    prop "offset-position" property_offset_position;
    prop "offset-rotate" property_offset_rotate;
    prop "offset" property_offset;
    prop "opacity" property_opacity;
    prop "order" property_order;
    prop "orientation" property_media_orientation;
    prop "orphans" property_orphans;
    prop "outline-color" property_outline_color;
    prop "outline-offset" property_outline_offset;
    prop "outline-style" property_outline_style;
    prop "outline-width" property_outline_width;
    prop "outline" property_outline;
    prop "overflow-anchor" property_overflow_anchor;
    prop "overflow-block" property_overflow_block;
    prop "overflow-clip-margin" property_overflow_clip_margin;
    prop "overflow-inline" property_overflow_inline;
    prop "overflow-wrap" property_overflow_wrap;
    prop "overflow-x" property_overflow_x;
    prop "overflow-y" property_overflow_y;
    prop "overflow" property_overflow;
    prop "overlay" property_overlay;
    prop "overscroll-behavior-block" property_overscroll_behavior_block;
    prop "overscroll-behavior-inline" property_overscroll_behavior_inline;
    prop "overscroll-behavior-x" property_overscroll_behavior_x;
    prop "overscroll-behavior-y" property_overscroll_behavior_y;
    prop "overscroll-behavior" property_overscroll_behavior;
    prop "padding-block-end" property_padding_block_end;
    prop "padding-block-start" property_padding_block_start;
    prop "padding-block" property_padding_block;
    prop "padding-bottom" property_padding_bottom;
    prop "padding-inline-end" property_padding_inline_end;
    prop "padding-inline-start" property_padding_inline_start;
    prop "padding-inline" property_padding_inline;
    prop "padding-left" property_padding_left;
    prop "padding-right" property_padding_right;
    prop "padding-top" property_padding_top;
    prop "padding" property_padding;
    prop "page-break-after" property_page_break_after;
    prop "page-break-before" property_page_break_before;
    prop "page-break-inside" property_page_break_inside;
    prop "page" property_page;
    prop "paint-order" property_paint_order;
    prop "pause-after" property_pause_after;
    prop "pause-before" property_pause_before;
    prop "pause" property_pause;
    prop "perspective-origin" property_perspective_origin;
    prop "perspective" property_perspective;
    prop "place-content" property_place_content;
    prop "place-items" property_place_items;
    prop "place-self" property_place_self;
    prop "pointer-events" property_pointer_events;
    prop "pointer" property_media_pointer;
    prop "position-anchor" property_position_anchor;
    prop "position-area" property_position_area;
    prop "position-try-fallbacks" property_position_try_fallbacks;
    prop "position-try-options" property_position_try_options;
    prop "position-try" property_position_try;
    prop "position-visibility" property_position_visibility;
    prop "position" property_position;
    prop "prefers-color-scheme" property_media_prefers_color_scheme;
    prop "prefers-contrast" property_media_prefers_contrast;
    prop "prefers-reduced-motion" property_media_prefers_reduced_motion;
    prop "print-color-adjust" property_print_color_adjust;
    prop "quotes" property_quotes;
    prop "r" property_r;
    prop "reading-flow" property_reading_flow;
    prop "resize" property_resize;
    prop "resolution" property_media_resolution;
    prop "rest-after" property_rest_after;
    prop "rest-before" property_rest_before;
    prop "rest" property_rest;
    prop "right" property_right;
    prop "rotate" property_rotate;
    prop "row-gap" property_row_gap;
    prop "ruby-align" property_ruby_align;
    prop "ruby-merge" property_ruby_merge;
    prop "ruby-overhang" property_ruby_overhang;
    prop "ruby-position" property_ruby_position;
    prop "rx" property_rx;
    prop "ry" property_ry;
    prop "scale" property_scale;
    prop "scripting" property_media_scripting;
    prop "scroll-behavior" property_scroll_behavior;
    prop "scroll-margin-block-end" property_scroll_margin_block_end;
    prop "scroll-margin-block-start" property_scroll_margin_block_start;
    prop "scroll-margin-block" property_scroll_margin_block;
    prop "scroll-margin-bottom" property_scroll_margin_bottom;
    prop "scroll-margin-inline-end" property_scroll_margin_inline_end;
    prop "scroll-margin-inline-start" property_scroll_margin_inline_start;
    prop "scroll-margin-inline" property_scroll_margin_inline;
    prop "scroll-margin-left" property_scroll_margin_left;
    prop "scroll-margin-right" property_scroll_margin_right;
    prop "scroll-margin-top" property_scroll_margin_top;
    prop "scroll-margin" property_scroll_margin;
    prop "scroll-marker-group" property_scroll_marker_group;
    prop "scroll-padding-block-end" property_scroll_padding_block_end;
    prop "scroll-padding-block-start" property_scroll_padding_block_start;
    prop "scroll-padding-block" property_scroll_padding_block;
    prop "scroll-padding-bottom" property_scroll_padding_bottom;
    prop "scroll-padding-inline-end" property_scroll_padding_inline_end;
    prop "scroll-padding-inline-start" property_scroll_padding_inline_start;
    prop "scroll-padding-inline" property_scroll_padding_inline;
    prop "scroll-padding-left" property_scroll_padding_left;
    prop "scroll-padding-right" property_scroll_padding_right;
    prop "scroll-padding-top" property_scroll_padding_top;
    prop "scroll-padding" property_scroll_padding;
    prop "scroll-snap-align" property_scroll_snap_align;
    prop "scroll-snap-coordinate" property_scroll_snap_coordinate;
    prop "scroll-snap-destination" property_scroll_snap_destination;
    prop "scroll-snap-points-x" property_scroll_snap_points_x;
    prop "scroll-snap-points-y" property_scroll_snap_points_y;
    prop "scroll-snap-stop" property_scroll_snap_stop;
    prop "scroll-snap-type-x" property_scroll_snap_type_x;
    prop "scroll-snap-type-y" property_scroll_snap_type_y;
    prop "scroll-snap-type" property_scroll_snap_type;
    prop "scroll-start-block" property_scroll_start_block;
    prop "scroll-start-inline" property_scroll_start_inline;
    prop "scroll-start-target-block" property_scroll_start_target_block;
    prop "scroll-start-target-inline" property_scroll_start_target_inline;
    prop "scroll-start-target-x" property_scroll_start_target_x;
    prop "scroll-start-target-y" property_scroll_start_target_y;
    prop "scroll-start-target" property_scroll_start_target;
    prop "scroll-start-x" property_scroll_start_x;
    prop "scroll-start-y" property_scroll_start_y;
    prop "scroll-start" property_scroll_start;
    prop "scroll-timeline-axis" property_scroll_timeline_axis;
    prop "scroll-timeline-name" property_scroll_timeline_name;
    prop "scroll-timeline" property_scroll_timeline;
    prop "scrollbar-3dlight-color" property_scrollbar_3dlight_color;
    prop "scrollbar-arrow-color" property_scrollbar_arrow_color;
    prop "scrollbar-base-color" property_scrollbar_base_color;
    prop "scrollbar-color" property_scrollbar_color;
    prop "scrollbar-darkshadow-color" property_scrollbar_darkshadow_color;
    prop "scrollbar-face-color" property_scrollbar_face_color;
    prop "scrollbar-gutter" property_scrollbar_gutter;
    prop "scrollbar-highlight-color" property_scrollbar_highlight_color;
    prop "scrollbar-shadow-color" property_scrollbar_shadow_color;
    prop "scrollbar-track-color" property_scrollbar_track_color;
    prop "scrollbar-width" property_scrollbar_width;
    prop "shape-image-threshold" property_shape_image_threshold;
    prop "shape-margin" property_shape_margin;
    prop "shape-outside" property_shape_outside;
    prop "shape-rendering" property_shape_rendering;
    prop "size" property_size;
    prop "speak-as" property_speak_as;
    prop "speak" property_speak;
    prop "src" property_src;
    prop "stop-color" property_stop_color;
    prop "stop-opacity" property_stop_opacity;
    prop "stroke-dasharray" property_stroke_dasharray;
    prop "stroke-dashoffset" property_stroke_dashoffset;
    prop "stroke-linecap" property_stroke_linecap;
    prop "stroke-linejoin" property_stroke_linejoin;
    prop "stroke-miterlimit" property_stroke_miterlimit;
    prop "stroke-opacity" property_stroke_opacity;
    prop "stroke-width" property_stroke_width;
    prop "stroke" property_stroke;
    prop "syntax" property_syntax;
    prop "tab-size" property_tab_size;
    prop "table-layout" property_table_layout;
    prop "text-align-all" property_text_align_all;
    prop "text-align-last" property_text_align_last;
    prop "text-align" property_text_align;
    prop "text-anchor" property_text_anchor;
    prop "text-autospace" property_text_autospace;
    prop "text-blink" property_text_blink;
    prop "text-box-edge" property_text_box_edge;
    prop "text-box-trim" property_text_box_trim;
    prop "text-combine-upright" property_text_combine_upright;
    prop "text-decoration-color" property_text_decoration_color;
    prop "text-decoration-line" property_text_decoration_line;
    prop "text-decoration-skip-box" property_text_decoration_skip_box;
    prop "text-decoration-skip-ink" property_text_decoration_skip_ink;
    prop "text-decoration-skip-inset" property_text_decoration_skip_inset;
    prop "text-decoration-skip-self" property_text_decoration_skip_self;
    prop "text-decoration-skip-spaces" property_text_decoration_skip_spaces;
    prop "text-decoration-skip" property_text_decoration_skip;
    prop "text-decoration-style" property_text_decoration_style;
    prop "text-decoration-thickness" property_text_decoration_thickness;
    prop "text-decoration" property_text_decoration;
    prop "text-edge" property_text_edge;
    prop "text-emphasis-color" property_text_emphasis_color;
    prop "text-emphasis-position" property_text_emphasis_position;
    prop "text-emphasis-style" property_text_emphasis_style;
    prop "text-emphasis" property_text_emphasis;
    prop "text-indent" property_text_indent;
    prop "text-justify-trim" property_text_justify_trim;
    prop "text-justify" property_text_justify;
    prop "text-kashida-space" property_text_kashida_space;
    prop "text-kashida" property_text_kashida;
    prop "text-orientation" property_text_orientation;
    prop "text-overflow" property_text_overflow;
    prop "text-rendering" property_text_rendering;
    prop "text-shadow" property_text_shadow;
    prop "text-size-adjust" property_text_size_adjust;
    prop "text-spacing-trim" property_text_spacing_trim;
    prop "text-transform" property_text_transform;
    prop "text-underline-offset" property_text_underline_offset;
    prop "text-underline-position" property_text_underline_position;
    prop "text-wrap-mode" property_text_wrap_mode;
    prop "text-wrap-style" property_text_wrap_style;
    prop "text-wrap" property_text_wrap;
    prop "timeline-scope" property_timeline_scope;
    prop "top" property_top;
    prop "touch-action" property_touch_action;
    prop "transform-box" property_transform_box;
    prop "transform-origin" property_transform_origin;
    prop "transform-style" property_transform_style;
    prop "transform" property_transform;
    prop "transition-behavior" property_transition_behavior;
    prop "transition-delay" property_transition_delay;
    prop "transition-duration" property_transition_duration;
    prop "transition-property" property_transition_property;
    prop "transition-timing-function" property_transition_timing_function;
    prop "transition" property_transition;
    prop "translate" property_translate;
    prop "unicode-bidi" property_unicode_bidi;
    prop "unicode-range" property_unicode_range;
    prop "update" property_media_update;
    prop "user-select" property_user_select;
    prop "vector-effect" property_vector_effect;
    prop "vertical-align" property_vertical_align;
    prop "view-timeline-axis" property_view_timeline_axis;
    prop "view-timeline-inset" property_view_timeline_inset;
    prop "view-timeline-name" property_view_timeline_name;
    prop "view-timeline" property_view_timeline;
    prop "view-transition-name" property_view_transition_name;
    prop "visibility" property_visibility;
    prop "voice-balance" property_voice_balance;
    prop "voice-duration" property_voice_duration;
    prop "voice-family" property_voice_family;
    prop "voice-pitch" property_voice_pitch;
    prop "voice-range" property_voice_range;
    prop "voice-rate" property_voice_rate;
    prop "voice-stress" property_voice_stress;
    prop "voice-volume" property_voice_volume;
    prop "white-space-collapse" property_white_space_collapse;
    prop "white-space" property_white_space;
    prop "widows" property_widows;
    prop "width" property_width;
    prop "will-change" property_will_change;
    prop "word-break" property_word_break;
    prop "word-space-transform" property_word_space_transform;
    prop "word-spacing" property_word_spacing;
    prop "word-wrap" property_word_wrap;
    prop "writing-mode" property_writing_mode;
    prop "x" property_x;
    prop "y" property_y;
    prop "z-index" property_z_index;
    prop "zoom" property_zoom;
    value "-legacy-gradient" _legacy_gradient;
    value "-legacy-linear-gradient-arguments" _legacy_linear_gradient_arguments;
    value "-legacy-linear-gradient" _legacy_linear_gradient;
    value "-legacy-radial-gradient-arguments" _legacy_radial_gradient_arguments;
    value "-legacy-radial-gradient-shape" _legacy_radial_gradient_shape;
    value "-legacy-radial-gradient-size" _legacy_radial_gradient_size;
    value "-legacy-radial-gradient" _legacy_radial_gradient;
    value "-legacy-repeating-linear-gradient" _legacy_repeating_linear_gradient;
    value "-legacy-repeating-radial-gradient" _legacy_repeating_radial_gradient;
    value "-non-standard-color" _non_standard_color;
    value "-non-standard-font" _non_standard_font;
    value "-non-standard-image-rendering" _non_standard_image_rendering;
    value "-non-standard-overflow" _non_standard_overflow;
    value "-non-standard-width" _non_standard_width;
    value "-webkit-gradient-color-stop" _webkit_gradient_color_stop;
    value "-webkit-gradient-point" _webkit_gradient_point;
    value "-webkit-gradient-radius" _webkit_gradient_radius;
    value "-webkit-gradient-type" _webkit_gradient_type;
    value "-webkit-mask-box-repeat" _webkit_mask_box_repeat;
    value "-webkit-mask-clip-style" _webkit_mask_clip_style;
    value "absolute-size" absolute_size;
    value "age" age;
    value "alpha-value" alpha_value;
    value "alpha-value" number_zero_one;
    value "angular-color-hint" angular_color_hint;
    value "angular-color-stop-list" angular_color_stop_list;
    value "angular-color-stop" angular_color_stop;
    value "animateable-feature" animateable_feature;
    value "attachment" attachment;
    value "attr-fallback" attr_fallback;
    value "attr-matcher" attr_matcher;
    value "attr-modifier" attr_modifier;
    value "attr-name" attr_name;
    value "attr-name" attr_name;
    value "attr-type" attr_type;
    value "attr-unit" attr_unit;
    value "attribute-selector" attribute_selector;
    value "auto-repeat" auto_repeat;
    value "auto-track-list" auto_track_list;
    value "baseline-position" baseline_position;
    value "basic-shape" basic_shape;
    value "bg-image" bg_image;
    value "bg-layer" bg_layer;
    value "bg-position" bg_position;
    value "bg-size" bg_size;
    value "blend-mode" blend_mode;
    value "border-radius" border_radius;
    value "bottom" bottom;
    value "box" box;
    value "calc-product" calc_product;
    value "calc-sum" calc_sum;
    value "calc-value" calc_value;
    value "cf-final-image" cf_final_image;
    value "cf-mixing-image" cf_mixing_image;
    value "class-selector" class_selector;
    value "clip-source" clip_source;
    value "color-interpolation-method" color_interpolation_method;
    value "color-stop-angle" color_stop_angle;
    value "color-stop-length" color_stop_length;
    value "color-stop-list" color_stop_list;
    value "color-stop" color_stop;
    value "color" color;
    value "combinator" combinator;
    value "common-lig-values" common_lig_values;
    value "compat-auto" compat_auto;
    value "complex-selector-list" complex_selector_list;
    value "complex-selector" complex_selector;
    value "composite-style" composite_style;
    value "compositing-operator" compositing_operator;
    value "compound-selector-list" compound_selector_list;
    value "compound-selector" compound_selector;
    value "content-distribution" content_distribution;
    value "content-list" content_list;
    value "content-position" content_position;
    value "content-replacement" content_replacement;
    value "contextual-alt-values" contextual_alt_values;
    value "counter-style-name" counter_style_name;
    value "counter-style" counter_style;
    value "cubic-bezier-timing-function" cubic_bezier_timing_function;
    value "declaration-list" declaration_list;
    value "declaration" declaration;
    value "deprecated-system-color" deprecated_system_color;
    value "discretionary-lig-values" discretionary_lig_values;
    value "display-box" display_box;
    value "display-inside" display_inside;
    value "display-internal" display_internal;
    value "display-legacy" display_legacy;
    value "display-listitem" display_listitem;
    value "display-outside" display_outside;
    value "east-asian-variant-values" east_asian_variant_values;
    value "east-asian-width-values" east_asian_width_values;
    value "ending-shape" ending_shape;
    value "explicit-track-list" explicit_track_list;
    value "family-name" family_name;
    value "feature-tag-value" feature_tag_value;
    value "feature-type" feature_type;
    value "feature-value-block-list" feature_value_block_list;
    value "feature-value-block" feature_value_block;
    value "feature-value-declaration-list" feature_value_declaration_list;
    value "feature-value-declaration" feature_value_declaration;
    value "feature-value-name" feature_value_name;
    value "fill-rule" fill_rule;
    value "filter-function-list" filter_function_list;
    value "filter-function" filter_function;
    value "final-bg-layer" final_bg_layer;
    value "fixed-breadth" fixed_breadth;
    value "fixed-repeat" fixed_repeat;
    value "fixed-size" fixed_size;
    value "font-families" font_families;
    value "font-stretch-absolute" font_stretch_absolute;
    value "font-variant-css21" font_variant_css21;
    value "font-weight-absolute" font_weight_absolute;
    value "gender" gender;
    value "general-enclosed" general_enclosed;
    value "generic-family" generic_family;
    value "generic-name" generic_name;
    value "generic-voice" generic_voice;
    value "geometry-box" geometry_box;
    value "gradient" gradient;
    value "grid-line" grid_line;
    value "historical-lig-values" historical_lig_values;
    value "hue-interpolation-method" hue_interpolation_method;
    value "hue" hue;
    value "id-selector" id_selector;
    value "image-set-option" image_set_option;
    value "image-src" image_src;
    value "image-tags" image_tags;
    value "image" image;
    value "inflexible-breadth" inflexible_breadth;
    value "keyframe-block-list" keyframe_block_list;
    value "keyframe-block" keyframe_block;
    value "keyframe-selector" keyframe_selector;
    value "keyframes-name" keyframes_name;
    value "leader-type" leader_type;
    value "left" left;
    value "line-name-list" line_name_list;
    value "line-names" line_names;
    value "line-style" line_style;
    value "line-width" line_width;
    value "linear-color-hint" linear_color_hint;
    value "linear-color-stop" linear_color_stop;
    value "mask-image" mask_image;
    value "mask-layer" mask_layer;
    value "mask-position" mask_position;
    value "mask-reference" mask_reference;
    value "mask-source" mask_source;
    value "masking-mode" masking_mode;
    value "mf-boolean" mf_boolean;
    value "mf-name" mf_name;
    value "mf-plain" mf_plain;
    value "mf-range" mf_range;
    value "mf-value" mf_value;
    value "name-repeat" name_repeat;
    value "named-color" named_color;
    value "namespace-prefix" namespace_prefix;
    value "ns-prefix" ns_prefix;
    value "nth" nth;
    value "number-one-or-greater" number_one_or_greater;
    value "number-percentage" number_percentage;
    value "numeric-figure-values" numeric_figure_values;
    value "numeric-fraction-values" numeric_fraction_values;
    value "numeric-spacing-values" numeric_spacing_values;
    value "outline-radius" outline_radius;
    value "overflow-position" overflow_position;
    value "page-body" page_body;
    value "page-margin-box-type" page_margin_box_type;
    value "page-margin-box" page_margin_box;
    value "page-selector-list" page_selector_list;
    value "page-selector" page_selector;
    value "paint" paint;
    value "polar-color-space" polar_color_space;
    value "position" position;
    value "positive-integer" positive_integer;
    value "pseudo-class-selector" pseudo_class_selector;
    value "pseudo-element-selector" pseudo_element_selector;
    value "pseudo-page" pseudo_page;
    value "quote" quote;
    value "radial-size" radial_size;
    value "ratio" ratio;
    value "ray-size" ray_size;
    value "rectangular-color-space" rectangular_color_space;
    value "relative-selector-list" relative_selector_list;
    value "relative-selector" relative_selector;
    value "relative-size" relative_size;
    value "repeat-style" repeat_style;
    value "right" right;
    value "self-position" self_position;
    value "shadow-t" shadow_t;
    value "shadow" shadow;
    value "shape-box" shape_box;
    value "shape-radius" shape_radius;
    value "shape" shape;
    value "side-or-corner" side_or_corner;
    value "single-animation-direction" single_animation_direction;
    value "single-animation-fill-mode" single_animation_fill_mode;
    value "single-animation-iteration-count" single_animation_iteration_count;
    value "single-animation-play-state" single_animation_play_state;
    value "single-animation" single_animation;
    value "single-transition-property" single_transition_property;
    value "single-transition" single_transition;
    value "size" size;
    value "step-position" step_position;
    value "step-timing-function" step_timing_function;
    value "subclass-selector" subclass_selector;
    value "supports-condition" supports_condition;
    value "supports-decl" supports_decl;
    value "supports-feature" supports_feature;
    value "supports-in-parens" supports_in_parens;
    value "supports-selector-fn" supports_selector_fn;
    value "svg-length" svg_length;
    value "svg-writing-mode" svg_writing_mode;
    value "symbol" symbol;
    value "symbols-type" symbols_type;
    value "syntax-combinator" syntax_combinator;
    value "syntax-component" syntax_component;
    value "syntax-multiplier" syntax_multiplier;
    value "syntax-single-component" syntax_single_component;
    value "syntax-string" syntax_string;
    value "syntax-type-name" syntax_type_name;
    value "syntax" syntax;
    value "target" target;
    value "timing-function" timing_function;
    value "top" top;
    value "track-breadth" track_breadth;
    value "track-group" track_group;
    value "track-list-v0" track_list_v0;
    value "track-list" track_list;
    value "track-minmax" track_minmax;
    value "track-repeat" track_repeat;
    value "track-size" track_size;
    value "transform-function" transform_function;
    value "transform-list" transform_list;
    value "try-tactic" try_tactic;
    value "type-or-unit" type_or_unit;
    value "type-selector" type_selector;
    value "viewport-length" viewport_length;
    value "wq-name" wq_name;
    value "x" x;
    value "y" y;
    (* TODO: calc needs to be available in length *)
    value "extended-length" extended_length;
    value "extended-frequency" extended_frequency;
    value "extended-angle" extended_angle;
    value "extended-time" extended_time;
    value "extended-percentage" extended_percentage;
  ]

(* Apply a packed rule to tokens and check if it's valid *)
let apply_packed_rule packed_rule tokens =
  let module R = (val packed_rule : RULE) in
  let result, remaining = R.rule tokens in
  R.name, Result.is_ok result, remaining

let find_rule (property : string) =
  packed_rules
  |> List.find_opt (fun packed_rule ->
       let module R = (val packed_rule : RULE) in
       match R.name with Property name -> property = name | _ -> false)

(* let apply_rule_by_name (name, tokens) =
     find_rule_by_name(name)
     |> Option.map(fun rule -> apply_packed_rule(rule, tokens))
   *)

let check_rule (rule, value) =
  let module R = (val rule : RULE) in
  parse R.rule value |> Result.is_ok

let check_property ~loc ~name value :
  ( unit,
    Styled_ppx_css_parser.Ast.loc
    * [> `Invalid_value of string | `Property_not_found ] )
  result =
  match find_rule name with
  | Some rule ->
    let module R = (val rule : RULE) in
    (match parse R.rule value with
    | Ok _ -> Ok ()
    | Error message -> Error (loc, `Invalid_value message))
  | None -> Error (loc, `Property_not_found)
