open Standard
open Modifier
open Rule.Match
open Styled_ppx_css_parser
module StringMap = Map.Make (String)

[@@@warning "-8-26-27"]

(* https://developer.mozilla.org/en-US/docs/Web/CSS/gradient *)
module rec Legacy_gradient =
  [%value.rec
    "<-webkit-gradient()> | <-legacy-linear-gradient> | \
     <-legacy-repeating-linear-gradient> | <-legacy-radial-gradient> | \
     <-legacy-repeating-radial-gradient>"]

and Legacy_linear_gradient =
  [%value.rec
    "-moz-linear-gradient( <-legacy-linear-gradient-arguments> ) | \
     -webkit-linear-gradient( <-legacy-linear-gradient-arguments> ) | \
     -o-linear-gradient( <-legacy-linear-gradient-arguments> )"]

and Legacy_linear_gradient_arguments =
  [%value.rec "[ <extended-angle> | <side-or-corner> ]? ',' <color-stop-list>"]

and Legacy_radial_gradient =
  [%value.rec
    "-moz-radial-gradient( <-legacy-radial-gradient-arguments> ) | \
     -webkit-radial-gradient( <-legacy-radial-gradient-arguments> ) | \
     -o-radial-gradient( <-legacy-radial-gradient-arguments> )"]

and Legacy_radial_gradient_arguments =
  [%value.rec
    "[ <position> ',' ]? [ [ <-legacy-radial-gradient-shape> || \
     <-legacy-radial-gradient-size> | [ <extended-length> | \
     <extended-percentage> ]{2} ] ',' ]? <color-stop-list>"]

and Legacy_radial_gradient_shape = [%value.rec "'circle' | 'ellipse'"]

and Legacy_radial_gradient_size =
  [%value.rec
    "'closest-side' | 'closest-corner' | 'farthest-side' | 'farthest-corner' | \
     'contain' | 'cover'"]

and Legacy_repeating_linear_gradient =
  [%value.rec
    "-moz-repeating-linear-gradient( <-legacy-linear-gradient-arguments> ) | \
     -webkit-repeating-linear-gradient( <-legacy-linear-gradient-arguments> ) \
     | -o-repeating-linear-gradient( <-legacy-linear-gradient-arguments> )"]

and Legacy_repeating_radial_gradient =
  [%value.rec
    "-moz-repeating-radial-gradient( <-legacy-radial-gradient-arguments> ) | \
     -webkit-repeating-radial-gradient( <-legacy-radial-gradient-arguments> ) \
     | -o-repeating-radial-gradient( <-legacy-radial-gradient-arguments> )"]

and Non_standard_color =
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

and Non_standard_font =
  [%value.rec
    "'-apple-system-body' | '-apple-system-headline' | \
     '-apple-system-subheadline' | '-apple-system-caption1' | \
     '-apple-system-caption2' | '-apple-system-footnote' | \
     '-apple-system-short-body' | '-apple-system-short-headline' | \
     '-apple-system-short-subheadline' | '-apple-system-short-caption1' | \
     '-apple-system-short-footnote' | '-apple-system-tall-body'"]

and Non_standard_image_rendering =
  [%value.rec
    "'optimize-contrast' | '-moz-crisp-edges' | '-o-crisp-edges' | \
     '-webkit-optimize-contrast'"]

and Non_standard_overflow =
  [%value.rec
    "'-moz-scrollbars-none' | '-moz-scrollbars-horizontal' | \
     '-moz-scrollbars-vertical' | '-moz-hidden-unscrollable'"]

and Non_standard_width =
  [%value.rec
    "'min-intrinsic' | 'intrinsic' | '-moz-min-content' | '-moz-max-content' | \
     '-webkit-min-content' | '-webkit-max-content'"]

and Webkit_gradient_color_stop =
  [%value.rec
    "from( <color> ) | color-stop( [ <alpha-value> | <extended-percentage> ] \
     ',' <color> ) | to( <color> )"]

and Webkit_gradient_point =
  [%value.rec
    "[ 'left' | 'center' | 'right' | <extended-length> | <extended-percentage> \
     ] [ 'top' | 'center' | 'bottom' | <extended-length> | \
     <extended-percentage> ]"]

and Webkit_gradient_radius =
  [%value.rec "<extended-length> | <extended-percentage>"]

and Webkit_gradient_type = [%value.rec "'linear' | 'radial'"]
and Webkit_mask_box_repeat = [%value.rec "'repeat' | 'stretch' | 'round'"]

and Webkit_mask_clip_style =
  [%value.rec
    "'border' | 'border-box' | 'padding' | 'padding-box' | 'content' | \
     'content-box' | 'text'"]

and Absolute_size =
  [%value.rec
    "'xx-small' | 'x-small' | 'small' | 'medium' | 'large' | 'x-large' | \
     'xx-large' | 'xxx-large'"]

and Age = [%value.rec "'child' | 'young' | 'old'"]
and Alpha_value = [%value.rec "<number> | <extended-percentage>"]
and Angular_color_hint = [%value.rec "<extended-angle> | <extended-percentage>"]
and Angular_color_stop = [%value.rec "<color> && [ <color-stop-angle> ]?"]

and Angular_color_stop_list =
  [%value.rec
    "[ <angular-color-stop> [ ',' <angular-color-hint> ]? ]# ',' \
     <angular-color-stop>"]

and Animateable_feature =
  [%value.rec "'scroll-position' | 'contents' | <custom-ident>"]

and Attachment = [%value.rec "'scroll' | 'fixed' | 'local'"]
and Attr_fallback = [%value.rec "<any-value>"]
and Attr_matcher = [%value.rec "[ '~' | '|' | '^' | '$' | '*' ]? '='"]
and Attr_modifier = [%value.rec "'i' | 's'"]

and Attribute_selector =
  [%value.rec
    "'[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [ <string-token> | \
     <ident-token> ] [ <attr-modifier> ]? ']'"]

and Auto_repeat =
  [%value.rec
    "repeat( [ 'auto-fill' | 'auto-fit' ] ',' [ [ <line-names> ]? <fixed-size> \
     ]+ [ <line-names> ]? )"]

and Auto_track_list =
  [%value.rec
    "[ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ <line-names> \
     ]? <auto-repeat> [ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* \
     [ <line-names> ]?"]

and Baseline_position = [%value.rec "[ 'first' | 'last' ]? 'baseline'"]

and Basic_shape =
  [%value.rec "<inset()> | <circle()> | <ellipse()> | <polygon()> | <path()>"]

and Bg_image = [%value.rec "'none' | <image>"]

and Bg_layer =
  [%value.rec
    "<bg-image> || <bg-position> [ '/' <bg-size> ]? || <repeat-style> || \
     <attachment> || <box> || <box>"]

and Bg_position =
  [%value.rec
    "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ]\n\
    \  | [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | \
     'center' | 'bottom' | <length-percentage> ]\n\
    \  | [ 'center' | [ 'left' | 'right' ] <length-percentage>? ] && [ \
     'center' | [ 'top' | 'bottom' ] <length-percentage>? ]"]

(* one_bg_size isn't part of the spec, helps us with Type generation *)
and One_bg_size =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | 'auto' ] [ \
     <extended-length> | <extended-percentage> | 'auto' ]?"]

and Bg_size = [%value.rec "<one-bg-size> | 'cover' | 'contain'"]

and Blend_mode =
  [%value.rec
    "'normal' | 'multiply' | 'screen' | 'overlay' | 'darken' | 'lighten' | \
     'color-dodge' | 'color-burn' | 'hard-light' | 'soft-light' | 'difference' \
     | 'exclusion' | 'hue' | 'saturation' | 'color' | 'luminosity'"]

(* and border_radius = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"] *)
and Border_radius = [%value.rec "<extended-length> | <extended-percentage>"]
and Bottom = [%value.rec "<extended-length> | 'auto'"]
and Box = [%value.rec "'border-box' | 'padding-box' | 'content-box'"]

and Calc_product =
  [%value.rec "<calc-value> [ '*' <calc-value> | '/' <number> ]*"]

and Dimension =
  [%value.rec
    "<extended-length> | <extended-time> | <extended-frequency> | <resolution>"]

and Calc_sum = [%value.rec "<calc-product> [ [ '+' | '-' ] <calc-product> ]*"]

(* and calc_value = [%value.rec "<number> | <dimension> | <extended-percentage> | <calc>"] *)
and Calc_value =
  [%value.rec
    "<number> | <extended-length> | <extended-percentage> | <extended-angle> | \
     <extended-time> | '(' <calc-sum> ')'"]

and Cf_final_image = [%value.rec "<image> | <color>"]
and Cf_mixing_image = [%value.rec "[ <extended-percentage> ]? && <image>"]
and Class_selector = [%value.rec "'.' <ident-token>"]
and Clip_source = [%value.rec "<url>"]

and Color =
  [%value.rec
    "<rgb()> | <rgba()> | <hsl()> | <hsla()> | <hex-color> | <named-color> | \
     'currentColor' | <deprecated-system-color> | <interpolation> | <var()> | \
     <color-mix()>"]

and Color_stop = [%value.rec "<color-stop-length> | <color-stop-angle>"]
and Color_stop_angle = [%value.rec "[ <extended-angle> ]{1,2}"]

(* and color_stop_length = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"] *)
and Color_stop_length = [%value.rec "<extended-length> | <extended-percentage>"]

(* color_stop_list is modified from the original spec, here is a simplified version where it tries to be fully compatible but easier for code-gen:

   The current impl allows values that aren't really supported such as: `linear-gradient(0deg, 10%, blue)` which is invalid, but we allow it for now to make it easier to generate the types. The correct value would require always a color to be in the first position `linear-gradient(0deg, red, 10%, blue),`

   The original spec is `color_stop_list = [%value.rec "[ <linear-color-stop> [ ',' <linear-color-hint> ]? ]# ',' <linear-color-stop>"]`
   *)
and Color_stop_list =
  [%value.rec
    "[ [<color>? <length-percentage>] | [<color> <length-percentage>?] ]#"]

and Hue_interpolation_method =
  [%value.rec
    " [ 'shorter' | 'longer' | 'increasing' | 'decreasing' ] && 'hue' "]

and Polar_color_space = [%value.rec " 'hsl' | 'hwb' | 'lch' | 'oklch' "]

and Rectangular_color_space =
  [%value.rec
    " 'srgb' | 'srgb-linear' | 'display-p3' | 'a98-rgb' | 'prophoto-rgb' | \
     'rec2020' | 'lab' | 'oklab' | 'xyz' | 'xyz-d50' | 'xyz-d65' "]

and Color_interpolation_method =
  [%value.rec
    " 'in' && [<rectangular-color-space> | <polar-color-space> \
     <hue-interpolation-method>?] "]

and Function_color_mix =
  [%value.rec
    (* TODO: Use <extended-percentage> *)
    "color-mix(<color-interpolation-method> ',' [ <color> && <percentage>? ] \
     ',' [ <color> && <percentage>? ])"]

and Combinator = [%value.rec "'>' | '+' | '~' | '||'"]

and Common_lig_values =
  [%value.rec "'common-ligatures' | 'no-common-ligatures'"]

and Compat_auto =
  [%value.rec
    "'searchfield' | 'textarea' | 'push-button' | 'slider-horizontal' | \
     'checkbox' | 'radio' | 'square-button' | 'menulist' | 'listbox' | 'meter' \
     | 'progress-bar'"]

and Complex_selector =
  [%value.rec "<compound-selector> [ [ <combinator> ]? <compound-selector> ]*"]

and Complex_selector_list = [%value.rec "[ <complex-selector> ]#"]

and Composite_style =
  [%value.rec
    "'clear' | 'copy' | 'source-over' | 'source-in' | 'source-out' | \
     'source-atop' | 'destination-over' | 'destination-in' | 'destination-out' \
     | 'destination-atop' | 'xor'"]

and Compositing_operator =
  [%value.rec "'add' | 'subtract' | 'intersect' | 'exclude'"]

and Compound_selector =
  [%value.rec
    "[ <type-selector> ]? [ <subclass-selector> ]* [ <pseudo-element-selector> \
     [ <pseudo-class-selector> ]* ]*"]

and Compound_selector_list = [%value.rec "[ <compound-selector> ]#"]

and Content_distribution =
  [%value.rec "'space-between' | 'space-around' | 'space-evenly' | 'stretch'"]

and Content_list =
  [%value.rec
    "[ <string> | 'contents' | <url> | <quote> | <attr()> | counter( <ident> \
     ',' [ <'list-style-type'> ]? ) ]+"]

and Content_position =
  [%value.rec "'center' | 'start' | 'end' | 'flex-start' | 'flex-end'"]

and Content_replacement = [%value.rec "<image>"]
and Contextual_alt_values = [%value.rec "'contextual' | 'no-contextual'"]
and Counter_style = [%value.rec "<counter-style-name> | <symbols()>"]
and Counter_style_name = [%value.rec "<custom-ident>"]
and Counter_name = [%value.rec "<custom-ident>"]

and Cubic_bezier_timing_function =
  [%value.rec
    "'ease' | 'ease-in' | 'ease-out' | 'ease-in-out' | cubic-bezier( <number> \
     ',' <number> ',' <number> ',' <number> )"]

and Declaration =
  [%value.rec "<ident-token> ':' [ <declaration-value> ]? [ '!' 'important' ]?"]

and Declaration_list =
  [%value.rec "[ [ <declaration> ]? ';' ]* [ <declaration> ]?"]

and Deprecated_system_color =
  [%value.rec
    "'ActiveBorder' | 'ActiveCaption' | 'AppWorkspace' | 'Background' | \
     'ButtonFace' | 'ButtonHighlight' | 'ButtonShadow' | 'ButtonText' | \
     'CaptionText' | 'GrayText' | 'Highlight' | 'HighlightText' | \
     'InactiveBorder' | 'InactiveCaption' | 'InactiveCaptionText' | \
     'InfoBackground' | 'InfoText' | 'Menu' | 'MenuText' | 'Scrollbar' | \
     'ThreeDDarkShadow' | 'ThreeDFace' | 'ThreeDHighlight' | \
     'ThreeDLightShadow' | 'ThreeDShadow' | 'Window' | 'WindowFrame' | \
     'WindowText'"]

and Discretionary_lig_values =
  [%value.rec "'discretionary-ligatures' | 'no-discretionary-ligatures'"]

and Display_box = [%value.rec "'contents' | 'none'"]

and Display_inside =
  [%value.rec "'flow' | 'flow-root' | 'table' | 'flex' | 'grid' | 'ruby'"]

and Display_internal =
  [%value.rec
    "'table-row-group' | 'table-header-group' | 'table-footer-group' | \
     'table-row' | 'table-cell' | 'table-column-group' | 'table-column' | \
     'table-caption' | 'ruby-base' | 'ruby-text' | 'ruby-base-container' | \
     'ruby-text-container'"]

and Display_legacy =
  [%value.rec
    "'inline-block' | 'inline-list-item' | 'inline-table' | 'inline-flex' | \
     'inline-grid'"]

and Display_listitem =
  [%value.rec
    "[ <display-outside> ]? && [ 'flow' | 'flow-root' ]? && 'list-item'"]

and Display_outside = [%value.rec "'block' | 'inline' | 'run-in'"]

and East_asian_variant_values =
  [%value.rec
    "'jis78' | 'jis83' | 'jis90' | 'jis04' | 'simplified' | 'traditional'"]

and East_asian_width_values = [%value.rec "'full-width' | 'proportional-width'"]
and Ending_shape = [%value.rec "'circle' | 'ellipse'"]

and Explicit_track_list =
  [%value.rec "[ [ <line-names> ]? <track-size> ]+ [ <line-names> ]?"]

and Family_name = [%value.rec "<string> | <custom-ident>"]
and Feature_tag_value = [%value.rec "<string> [ <integer> | 'on' | 'off' ]?"]

and Feature_type =
  [%value.rec
    "'@stylistic' | '@historical-forms' | '@styleset' | '@character-variant' | \
     '@swash' | '@ornaments' | '@annotation'"]

and Feature_value_block =
  [%value.rec "<feature-type> '{' <feature-value-declaration-list> '}'"]

and Feature_value_block_list = [%value.rec "[ <feature-value-block> ]+"]

and Feature_value_declaration =
  [%value.rec "<custom-ident> ':' [ <integer> ]+ ';'"]

and Feature_value_declaration_list = [%value.rec "<feature-value-declaration>"]
and Feature_value_name = [%value.rec "<custom-ident>"]
and Fill_rule = [%value.rec "'nonzero' | 'evenodd'"]

and Filter_function =
  [%value.rec
    "<blur()> | <brightness()> | <contrast()> | <drop-shadow()> | \
     <grayscale()> | <hue-rotate()> | <invert()> | <opacity()> | <saturate()> \
     | <sepia()>"]

and Filter_function_list = [%value.rec "[ <filter-function> | <url> ]+"]

and Final_bg_layer =
  [%value.rec
    "<'background-color'> || <bg-image> || <bg-position> [ '/' <bg-size> ]? || \
     <repeat-style> || <attachment> || <box> || <box>"]

and Line_names = [%value.rec "'[' <custom-ident>* ']'"]
and Fixed_breadth = [%value.rec "<extended-length> | <extended-percentage>"]

and Fixed_repeat =
  [%value.rec
    "repeat( <positive-integer> ',' [ [ <line-names> ]? <fixed-size> ]+ [ \
     <line-names> ]? )"]

and Fixed_size =
  [%value.rec
    "<fixed-breadth> | minmax( <fixed-breadth> ',' <track-breadth> ) | minmax( \
     <inflexible-breadth> ',' <fixed-breadth> )"]

and Font_stretch_absolute =
  [%value.rec
    "'normal' | 'ultra-condensed' | 'extra-condensed' | 'condensed' | \
     'semi-condensed' | 'semi-expanded' | 'expanded' | 'extra-expanded' | \
     'ultra-expanded' | <extended-percentage>"]

and Font_variant_css21 = [%value.rec "'normal' | 'small-caps'"]
and Font_weight_absolute = [%value.rec "'normal' | 'bold' | <integer>"]

and Function__webkit_gradient =
  [%value.rec
    "-webkit-gradient( <-webkit-gradient-type> ',' <-webkit-gradient-point> [ \
     ',' <-webkit-gradient-point> | ',' <-webkit-gradient-radius> ',' \
     <-webkit-gradient-point> ] [ ',' <-webkit-gradient-radius> ]? [ ',' \
     <-webkit-gradient-color-stop> ]* )"]

(* We don't support attr() with fallback value (since it's a declaration value) yet, original spec is: "attr(<attr-name> <attr-type>? , <declaration-value>?)" *)
and Function_attr = [%value.rec "attr(<attr-name> <attr-type>?)"]

(* and function_attr = [%value.rec
     "attr(<attr-name> <attr-type>? , <declaration-value>?)"
   ] *)
and Function_blur = [%value.rec "blur( <extended-length> )"]
and Function_brightness = [%value.rec "brightness( <number-percentage> )"]
and Function_calc = [%value.rec "calc( <calc-sum> )"]

and Function_circle =
  [%value.rec "circle( [ <shape-radius> ]? [ 'at' <position> ]? )"]

and Function_clamp = [%value.rec "clamp( [ <calc-sum> ]#{3} )"]

and Function_conic_gradient =
  [%value.rec
    "conic-gradient( [ 'from' <extended-angle> ]? [ 'at' <position> ]? ',' \
     <angular-color-stop-list> )"]

and Function_contrast = [%value.rec "contrast( <number-percentage> )"]

and Function_counter =
  [%value.rec "counter( <counter-name> , <counter-style>? )"]

and Function_counters =
  [%value.rec
    "counters( <custom-ident> ',' <string> ',' [ <counter-style> ]? )"]

and Function_cross_fade =
  [%value.rec "cross-fade( <cf-mixing-image> ',' [ <cf-final-image> ]? )"]

(* drop-shadow can have 2 length and order doesn't matter, we changed to be more restrict and always expect 3 *)
and Function_drop_shadow =
  [%value.rec
    "drop-shadow(<extended-length> <extended-length> <extended-length> [ \
     <color> ]?)"]

and Function_element = [%value.rec "element( <id-selector> )"]

and Function_ellipse =
  [%value.rec "ellipse( [ [ <shape-radius> ]{2} ]? [ 'at' <position> ]? )"]

and Function_env =
  [%value.rec "env( <custom-ident> ',' [ <declaration-value> ]? )"]

and Function_fit_content =
  [%value.rec "fit-content( <extended-length> | <extended-percentage> )"]

and Function_grayscale = [%value.rec "grayscale( <number-percentage> )"]

and Function_hsl =
  [%value.rec
    " hsl( <hue> <extended-percentage> <extended-percentage> [ '/' \
     <alpha-value> ]? )\n\
    \  | hsl( <hue> ',' <extended-percentage> ',' <extended-percentage> [ ',' \
     <alpha-value> ]? )"]

and Function_hsla =
  [%value.rec
    " hsla( <hue> <extended-percentage> <extended-percentage> [ '/' \
     <alpha-value> ]? )\n\
    \  | hsla( <hue> ',' <extended-percentage> ',' <extended-percentage> ',' [ \
     <alpha-value> ]? )"]

and Function_hue_rotate = [%value.rec "hue-rotate( <extended-angle> )"]

and Function_image =
  [%value.rec "image( [ <image-tags> ]? [ <image-src> ]? ',' [ <color> ]? )"]

and Function_image_set = [%value.rec "image-set( [ <image-set-option> ]# )"]

and Function_inset =
  [%value.rec
    "inset( [ <extended-length> | <extended-percentage> ]{1,4} [ 'round' \
     <'border-radius'> ]? )"]

and Function_invert = [%value.rec "invert( <number-percentage> )"]
and Function_leader = [%value.rec "leader( <leader-type> )"]

and Function_linear_gradient =
  [%value.rec
    "linear-gradient( [ [<extended-angle> ','] | ['to' <side-or-corner> ','] \
     ]? <color-stop-list> )"]

(* and function_linear_gradient = [%value.rec "linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? ',' <color-stop-list> )"] *)
and Function_matrix = [%value.rec "matrix( [ <number> ]#{6} )"]
and Function_matrix3d = [%value.rec "matrix3d( [ <number> ]#{16} )"]
and Function_max = [%value.rec "max( [ <calc-sum> ]# )"]
and Function_min = [%value.rec "min( [ <calc-sum> ]# )"]

and Function_minmax =
  [%value.rec
    "minmax( [ <extended-length> | <extended-percentage> | 'min-content' | \
     'max-content' | 'auto' ] ',' [ <extended-length> | <extended-percentage> \
     | <flex-value> | 'min-content' | 'max-content' | 'auto' ] )"]

and Function_opacity = [%value.rec "opacity( <number-percentage> )"]

and Function_paint =
  [%value.rec "paint( <ident> ',' [ <declaration-value> ]? )"]

and Function_path = [%value.rec "path( <string> )"]
and Function_perspective = [%value.rec "perspective( <property-perspective> )"]

and Function_polygon =
  [%value.rec
    "polygon( [ <fill-rule> ',' ]? [ <length-percentage> <length-percentage> \
     ]# )"]

and Function_radial_gradient =
  [%value.rec
    "radial-gradient( <ending-shape>? <radial-size>? ['at' <position> ]? ','? \
     <color-stop-list> )"]

and Function_repeating_linear_gradient =
  [%value.rec
    "repeating-linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? \
     ',' <color-stop-list> )"]

and Function_repeating_radial_gradient =
  [%value.rec
    "repeating-radial-gradient( [ <ending-shape> || <size> ]? [ 'at' \
     <position> ]? ',' <color-stop-list> )"]

and Function_rgb =
  [%value.rec
    "\n\
    \    rgb( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? )\n\
    \  | rgb( [ <number> ]{3} [ '/' <alpha-value> ]? )\n\
    \  | rgb( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? )\n\
    \  | rgb( [ <number> ]#{3} [ ',' <alpha-value> ]? )\n"]

and Function_rgba =
  [%value.rec
    "\n\
    \    rgba( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? )\n\
    \  | rgba( [ <number> ]{3} [ '/' <alpha-value> ]? )\n\
    \  | rgba( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? )\n\
    \  | rgba( [ <number> ]#{3} [ ',' <alpha-value> ]? )\n"]

and Function_rotate = [%value.rec "rotate( <extended-angle> | <zero> )"]

and Function_rotate3d =
  [%value.rec
    "rotate3d( <number> ',' <number> ',' <number> ',' [ <extended-angle> | \
     <zero> ] )"]

and Function_rotateX = [%value.rec "rotateX( <extended-angle> | <zero> )"]
and Function_rotateY = [%value.rec "rotateY( <extended-angle> | <zero> )"]
and Function_rotateZ = [%value.rec "rotateZ( <extended-angle> | <zero> )"]
and Function_saturate = [%value.rec "saturate( <number-percentage> )"]
and Function_scale = [%value.rec "scale( <number> [',' [ <number> ]]? )"]

and Function_scale3d =
  [%value.rec "scale3d( <number> ',' <number> ',' <number> )"]

and Function_scaleX = [%value.rec "scaleX( <number> )"]
and Function_scaleY = [%value.rec "scaleY( <number> )"]
and Function_scaleZ = [%value.rec "scaleZ( <number> )"]
and Function_sepia = [%value.rec "sepia( <number-percentage> )"]

and Function_skew =
  [%value.rec
    "skew( [ <extended-angle> | <zero> ] [',' [ <extended-angle> | <zero> ]]? )"]

and Function_skewX = [%value.rec "skewX( <extended-angle> | <zero> )"]
and Function_skewY = [%value.rec "skewY( <extended-angle> | <zero> )"]

and Function_symbols =
  [%value.rec "symbols( [ <symbols-type> ]? [ <string> | <image> ]+ )"]

and Function_target_counter =
  [%value.rec
    "target-counter( [ <string> | <url> ] ',' <custom-ident> ',' [ \
     <counter-style> ]? )"]

and Function_target_counters =
  [%value.rec
    "target-counters( [ <string> | <url> ] ',' <custom-ident> ',' <string> ',' \
     [ <counter-style> ]? )"]

and Function_target_text =
  [%value.rec
    "target-text( [ <string> | <url> ] ',' [ 'content' | 'before' | 'after' | \
     'first-letter' ]? )"]

and Function_translate =
  [%value.rec
    "translate( [<extended-length> | <extended-percentage>] [',' [ \
     <extended-length> | <extended-percentage> ]]? )"]

and Function_translate3d =
  [%value.rec
    "translate3d( [<extended-length> | <extended-percentage>] ',' \
     [<extended-length> | <extended-percentage>] ',' <extended-length> )"]

and Function_translateX =
  [%value.rec "translateX( [<extended-length> | <extended-percentage>] )"]

and Function_translateY =
  [%value.rec "translateY( [<extended-length> | <extended-percentage>] )"]

and Function_translateZ = [%value.rec "translateZ( <extended-length> )"]

(* and function_var = [%value.rec "var( <ident> ',' [ <declaration-value> ]? )"] *)
and Function_var = [%value.rec "var( <ident> )"]
and Gender = [%value.rec "'male' | 'female' | 'neutral'"]

and General_enclosed =
  [%value.rec "<function-token> <any-value> ')' | '(' <ident> <any-value> ')'"]

and Generic_family =
  [%value.rec
    "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace' | \
     '-apple-system'"]

and Generic_name =
  [%value.rec "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace'"]

and Generic_voice = [%value.rec "[ <age> ]? <gender> [ <integer> ]?"]

and Geometry_box =
  [%value.rec "<shape-box> | 'fill-box' | 'stroke-box' | 'view-box'"]

and Gradient =
  [%value.rec
    "<linear-gradient()> | <repeating-linear-gradient()> | <radial-gradient()> \
     | <repeating-radial-gradient()> | <conic-gradient()> | <-legacy-gradient>"]

and Grid_line =
  [%value.rec
    "<custom-ident-without-span-or-auto> | <integer> && [ \
     <custom-ident-without-span-or-auto> ]? | 'span' && [ <integer> || \
     <custom-ident-without-span-or-auto> ] | 'auto' | <interpolation>"]

and Historical_lig_values =
  [%value.rec "'historical-ligatures' | 'no-historical-ligatures'"]

and Hue = [%value.rec "<number> | <extended-angle>"]
and Id_selector = [%value.rec "<hash-token>"]

and Image =
  [%value.rec
    "<url> | <image()> | <image-set()> | <element()> | <paint()> | \
     <cross-fade()> | <gradient> | <interpolation>"]

and Image_set_option = [%value.rec "[ <image> | <string> ] <resolution>"]
and Image_src = [%value.rec "<url> | <string>"]
and Image_tags = [%value.rec "'ltr' | 'rtl'"]

and Inflexible_breadth =
  [%value.rec
    "<extended-length> | <extended-percentage> | 'min-content' | 'max-content' \
     | 'auto'"]

and Keyframe_block =
  [%value.rec "[ <keyframe-selector> ]# '{' <declaration-list> '}'"]

and Keyframe_block_list = [%value.rec "[ <keyframe-block> ]+"]
and Keyframe_selector = [%value.rec "'from' | 'to' | <extended-percentage>"]
and Keyframes_name = [%value.rec "<custom-ident> | <string>"]
and Leader_type = [%value.rec "'dotted' | 'solid' | 'space' | <string>"]
and Left = [%value.rec "<extended-length> | 'auto'"]
and Line_name_list = [%value.rec "[ <line-names> | <name-repeat> ]+"]

and Line_style =
  [%value.rec
    "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | \
     'ridge' | 'inset' | 'outset'"]

and Line_width = [%value.rec "<extended-length> | 'thin' | 'medium' | 'thick'"]
and Linear_color_hint = [%value.rec "<extended-length> | <extended-percentage>"]
and Linear_color_stop = [%value.rec "<color> <length-percentage>?"]
and Mask_image = [%value.rec "[ <mask-reference> ]#"]

and Mask_layer =
  [%value.rec
    "<mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || \
     <geometry-box> || [ <geometry-box> | 'no-clip' ] || \
     <compositing-operator> || <masking-mode>"]

and Mask_position =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' \
     ] [ <extended-length> | <extended-percentage> | 'top' | 'center' | \
     'bottom' ]?"]

and Mask_reference = [%value.rec "'none' | <image> | <mask-source>"]
and Mask_source = [%value.rec "<url>"]
and Masking_mode = [%value.rec "'alpha' | 'luminance' | 'match-source'"]
and Mf_comparison = [%value.rec "<mf-lt> | <mf-gt> | <mf-eq>"]
and Mf_eq = [%value.rec "'='"]
and Mf_gt = [%value.rec "'>=' | '>'"]
and Mf_lt = [%value.rec "'<=' | '<'"]

and Mf_value =
  [%value.rec "<number> | <dimension> | <ident> | <ratio> | <interpolation>"]

and Mf_name = [%value.rec "<ident>"]

and Mf_range =
  [%value.rec
    "<mf-name> <mf-comparison> <mf-value> | <mf-value> <mf-comparison> \
     <mf-name> | <mf-value> <mf-lt> <mf-name> <mf-lt> <mf-value> | <mf-value> \
     <mf-gt> <mf-name> <mf-gt> <mf-value>"]

and Mf_boolean = [%value.rec "<mf-name>"]
and Mf_plain = [%value.rec "<mf-name> ':' <mf-value>"]

and Media_feature =
  [%value.rec "'(' [ <mf-plain> | <mf-boolean> | <mf-range> ] ')'"]

and Media_in_parens =
  [%value.rec "'(' <media-condition> ')' | <media-feature> | <interpolation>"]

and Media_or = [%value.rec "'or' <media-in-parens>"]
and Media_and = [%value.rec "'and' <media-in-parens>"]
and Media_not = [%value.rec "'not' <media-in-parens>"]

and Media_condition_without_or =
  [%value.rec "<media-not> | <media-in-parens> <media-and>*"]

and Media_condition =
  [%value.rec "<media-not> | <media-in-parens> [ <media-and>* | <media-or>* ]"]

and Media_query =
  [%value.rec
    "<media-condition> | [ 'not' | 'only' ]? <media-type> [ 'and' \
     <media-condition-without-or> ]?"]

and Media_query_list = [%value.rec "[ <media-query> ]# | <interpolation>"]
and Container_condition_list = [%value.rec "<container-condition>#"]
and Container_condition = [%value.rec "[ <container-name> ]? <container-query>"]

and Container_query =
  [%value.rec
    "'not' <query-in-parens> | <query-in-parens> [ [ 'and' <query-in-parens> \
     ]* | [ 'or' <query-in-parens> ]* ]"]

and Query_in_parens =
  [%value.rec
    "'(' <container-query> ')' | '(' <size-feature> ')' | style( <style-query> \
     )"]

and Size_feature = [%value.rec "<mf-plain> | <mf-boolean> | <mf-range>"]

and Style_query =
  [%value.rec
    "'not' <style-in-parens> | <style-in-parens> [ [ and <style-in-parens> ]* \
     | [ or <style-in-parens> ]* ] | <style-feature>"]

and Style_feature = [%value.rec "<dashed_ident> ':' <mf-value>"]

and Style_in_parens =
  [%value.rec "'(' <style-query> ')' | '(' <style-feature> ')'"]

and Name_repeat =
  [%value.rec
    "repeat( [ <positive-integer> | 'auto-fill' ] ',' [ <line-names> ]+ )"]

and Named_color =
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

and Namespace_prefix = [%value.rec "<ident>"]
and Ns_prefix = [%value.rec "[ <ident-token> | '*' ]? '|'"]
and Nth = [%value.rec "<an-plus-b> | 'even' | 'odd'"]
and Number_one_or_greater = [%value.rec "<number>"]
and Number_percentage = [%value.rec "<number> | <extended-percentage>"]
and Number_zero_one = [%value.rec "<number>"]
and Numeric_figure_values = [%value.rec "'lining-nums' | 'oldstyle-nums'"]

and Numeric_fraction_values =
  [%value.rec "'diagonal-fractions' | 'stacked-fractions'"]

and Numeric_spacing_values = [%value.rec "'proportional-nums' | 'tabular-nums'"]
and Outline_radius = [%value.rec "<extended-length> | <extended-percentage>"]
and Overflow_position = [%value.rec "'unsafe' | 'safe'"]

and Page_body =
  [%value.rec
    "[ <declaration> ]? [ ';' <page-body> ]? | <page-margin-box> <page-body>"]

and Page_margin_box =
  [%value.rec "<page-margin-box-type> '{' <declaration-list> '}'"]

and Page_margin_box_type =
  [%value.rec
    "'@top-left-corner' | '@top-left' | '@top-center' | '@top-right' | \
     '@top-right-corner' | '@bottom-left-corner' | '@bottom-left' | \
     '@bottom-center' | '@bottom-right' | '@bottom-right-corner' | '@left-top' \
     | '@left-middle' | '@left-bottom' | '@right-top' | '@right-middle' | \
     '@right-bottom'"]

and Page_selector =
  [%value.rec "[ <pseudo-page> ]+ | <ident> [ <pseudo-page> ]*"]

and Page_selector_list = [%value.rec "[ [ <page-selector> ]# ]?"]

and Paint =
  [%value.rec
    "'none' | <color> | <url> [ 'none' | <color> ]? | 'context-fill' | \
     'context-stroke' | <interpolation>"]

and Position =
  [%value.rec
    "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ]\n\
    \  | [ 'left' | 'center' | 'right' ] && [ 'top' | 'center' | 'bottom' ]\n\
    \  | [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | \
     'center' | 'bottom' | <length-percentage> ]\n\
    \  | [ [ 'left' | 'right' ] <length-percentage> ] && [ [ 'top' | 'bottom' \
     ] <length-percentage> ]"]

and Positive_integer = [%value.rec "<integer>"]

and Property__moz_appearance =
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

and Property__moz_background_clip = [%value.rec "'padding' | 'border'"]
and Property__moz_binding = [%value.rec "<url> | 'none'"]
and Property__moz_border_bottom_colors = [%value.rec "[ <color> ]+ | 'none'"]
and Property__moz_border_left_colors = [%value.rec "[ <color> ]+ | 'none'"]

and Property__moz_border_radius_bottomleft =
  [%value.rec "<'border-bottom-left-radius'>"]

and Property__moz_border_radius_bottomright =
  [%value.rec "<'border-bottom-right-radius'>"]

and Property__moz_border_radius_topleft =
  [%value.rec "<'border-top-left-radius'>"]

and Property__moz_border_radius_topright =
  [%value.rec "<'border-bottom-right-radius'>"]

(* TODO: Remove interpolation without <> *)
and Property__moz_border_right_colors =
  [%value.rec "[ <color> ]+ | 'none' | interpolation"]

(* TODO: Remove interpolation without <> *)
and Property__moz_border_top_colors =
  [%value.rec "[ <color> ]+ | 'none' | interpolation"]

and Property__moz_context_properties =
  [%value.rec
    "'none' | [ 'fill' | 'fill-opacity' | 'stroke' | 'stroke-opacity' ]#"]

and Property__moz_control_character_visibility =
  [%value.rec "'visible' | 'hidden'"]

and Property__moz_float_edge =
  [%value.rec "'border-box' | 'content-box' | 'margin-box' | 'padding-box'"]

and Property__moz_force_broken_image_icon = [%value.rec "<integer>"]
and Property__moz_image_region = [%value.rec "<shape> | 'auto'"]

and Property__moz_orient =
  [%value.rec "'inline' | 'block' | 'horizontal' | 'vertical'"]

and Property__moz_osx_font_smoothing = [%value.rec "'auto' | 'grayscale'"]

and Property__moz_outline_radius =
  [%value.rec "[ <outline-radius> ]{1,4} [ '/' [ <outline-radius> ]{1,4} ]?"]

and Property__moz_outline_radius_bottomleft = [%value.rec "<outline-radius>"]
and Property__moz_outline_radius_bottomright = [%value.rec "<outline-radius>"]
and Property__moz_outline_radius_topleft = [%value.rec "<outline-radius>"]
and Property__moz_outline_radius_topright = [%value.rec "<outline-radius>"]
and Property__moz_stack_sizing = [%value.rec "'ignore' | 'stretch-to-fit'"]
and Property__moz_text_blink = [%value.rec "'none' | 'blink'"]

and Property__moz_user_focus =
  [%value.rec
    "'ignore' | 'normal' | 'select-after' | 'select-before' | 'select-menu' | \
     'select-same' | 'select-all' | 'none'"]

and Property__moz_user_input =
  [%value.rec "'auto' | 'none' | 'enabled' | 'disabled'"]

and Property__moz_user_modify =
  [%value.rec "'read-only' | 'read-write' | 'write-only'"]

and Property__moz_user_select =
  [%value.rec "'none' | 'text' | 'all' | '-moz-none'"]

and Property__moz_window_dragging = [%value.rec "'drag' | 'no-drag'"]

and Property__moz_window_shadow =
  [%value.rec "'default' | 'menu' | 'tooltip' | 'sheet' | 'none'"]

and Property__webkit_appearance =
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

and Property__webkit_background_clip =
  [%value.rec "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#"]

and Property__webkit_border_before =
  [%value.rec "<'border-width'> || <'border-style'> || <'color'>"]

and Property__webkit_border_before_color = [%value.rec "<'color'>"]
and Property__webkit_border_before_style = [%value.rec "<'border-style'>"]
and Property__webkit_border_before_width = [%value.rec "<'border-width'>"]

and Property__webkit_box_reflect =
  [%value.rec
    "[ 'above' | 'below' | 'right' | 'left' ]? [ <extended-length> ]? [ \
     <image> ]?"]

and Property__webkit_column_break_after =
  [%value.rec "'always' | 'auto' | 'avoid'"]

and Property__webkit_column_break_before =
  [%value.rec "'always' | 'auto' | 'avoid'"]

and Property__webkit_column_break_inside =
  [%value.rec "'always' | 'auto' | 'avoid'"]

and Property__webkit_font_smoothing =
  [%value.rec "'auto' | 'none' | 'antialiased' | 'subpixel-antialiased'"]

and Property__webkit_line_clamp = [%value.rec "'none' | <integer>"]

and Property__webkit_mask =
  [%value.rec
    "[ <mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || \
     [ <box> | 'border' | 'padding' | 'content' | 'text' ] || [ <box> | \
     'border' | 'padding' | 'content' ] ]#"]

and Property__webkit_mask_attachment = [%value.rec "[ <attachment> ]#"]

and Property__webkit_mask_box_image =
  [%value.rec
    "[ <url> | <gradient> | 'none' ] [ [ <extended-length> | \
     <extended-percentage> ]{4} [ <-webkit-mask-box-repeat> ]{2} ]?"]

and Property__webkit_mask_clip =
  [%value.rec "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#"]

and Property__webkit_mask_composite = [%value.rec "[ <composite-style> ]#"]
and Property__webkit_mask_image = [%value.rec "[ <mask-reference> ]#"]

and Property__webkit_mask_origin =
  [%value.rec "[ <box> | 'border' | 'padding' | 'content' ]#"]

and Property__webkit_mask_position = [%value.rec "[ <position> ]#"]

and Property__webkit_mask_position_x =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' \
     ]#"]

and Property__webkit_mask_position_y =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' \
     ]#"]

and Property__webkit_mask_repeat = [%value.rec "[ <repeat-style> ]#"]

and Property__webkit_mask_repeat_x =
  [%value.rec "'repeat' | 'no-repeat' | 'space' | 'round'"]

and Property__webkit_mask_repeat_y =
  [%value.rec "'repeat' | 'no-repeat' | 'space' | 'round'"]

and Property__webkit_mask_size = [%value.rec "[ <bg-size> ]#"]
and Property__webkit_overflow_scrolling = [%value.rec "'auto' | 'touch'"]
and Property__webkit_print_color_adjust = [%value.rec "'economy' | 'exact'"]
and Property__webkit_tap_highlight_color = [%value.rec "<color>"]
and Property__webkit_text_fill_color = [%value.rec "<color>"]

and Property__webkit_text_security =
  [%value.rec "'none' | 'circle' | 'disc' | 'square'"]

and Property__webkit_text_stroke = [%value.rec "<extended-length> || <color>"]
and Property__webkit_text_stroke_color = [%value.rec "<color>"]
and Property__webkit_text_stroke_width = [%value.rec "<extended-length>"]
and Property__webkit_touch_callout = [%value.rec "'default' | 'none'"]
and Property__webkit_user_drag = [%value.rec "'none' | 'element' | 'auto'"]

and Property__webkit_user_modify =
  [%value.rec "'read-only' | 'read-write' | 'read-write-plaintext-only'"]

and Property__webkit_user_select =
  [%value.rec "'auto' | 'none' | 'text' | 'all'"]

and Property_align_content =
  [%value.rec
    "'normal' | <baseline-position> | <content-distribution> | [ \
     <overflow-position> ]? <content-position>"]

and Property_align_items =
  [%value.rec
    "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? \
     <self-position> | <interpolation>"]

and Property_align_self =
  [%value.rec
    "'auto' | 'normal' | 'stretch' | <baseline-position> | [ \
     <overflow-position> ]? <self-position> | <interpolation>"]

and Property_alignment_baseline =
  [%value.rec
    "'auto' | 'baseline' | 'before-edge' | 'text-before-edge' | 'middle' | \
     'central' | 'after-edge' | 'text-after-edge' | 'ideographic' | \
     'alphabetic' | 'hanging' | 'mathematical'"]

and Property_all = [%value.rec "'initial' | 'inherit' | 'unset' | 'revert'"]

and Property_animation =
  [%value.rec "[ <single-animation> | <single-animation-no-interp> ]#"]

and Property_animation_delay = [%value.rec "[ <extended-time> ]#"]

and Property_animation_direction =
  [%value.rec "[ <single-animation-direction> ]#"]

and Property_animation_duration = [%value.rec "[ <extended-time> ]#"]

and Property_animation_fill_mode =
  [%value.rec "[ <single-animation-fill-mode> ]#"]

and Property_animation_iteration_count =
  [%value.rec "[ <single-animation-iteration-count> ]#"]

and Property_animation_name =
  [%value.rec "[ <keyframes-name> | 'none' | <interpolation> ]#"]

and Property_animation_play_state =
  [%value.rec "[ <single-animation-play-state> ]#"]

and Property_animation_timing_function = [%value.rec "[ <timing-function> ]#"]

and Property_appearance =
  [%value.rec
    "'none' | 'auto' | 'button' | 'textfield' | 'menulist-button' | \
     <compat-auto>"]

and Property_aspect_ratio = [%value.rec "'auto' | <ratio>"]

and Property_azimuth =
  [%value.rec
    "<extended-angle> | [ 'left-side' | 'far-left' | 'left' | 'center-left' | \
     'center' | 'center-right' | 'right' | 'far-right' | 'right-side' ] || \
     'behind' | 'leftwards' | 'rightwards'"]

and Property_backdrop_filter =
  [%value.rec "'none' | <interpolation> | <filter-function-list>"]

and Property_backface_visibility = [%value.rec "'visible' | 'hidden'"]
and Property_background = [%value.rec "[ <bg-layer> ',' ]* <final-bg-layer>"]
and Property_background_attachment = [%value.rec "[ <attachment> ]#"]
and Property_background_blend_mode = [%value.rec "[ <blend-mode> ]#"]

and Property_background_clip =
  [%value.rec "[ <box> | 'text' | 'border-area' ]#"]

and Property_background_color = [%value.rec "<color>"]
and Property_background_image = [%value.rec "[ <bg-image> ]#"]
and Property_background_origin = [%value.rec "[ <box> ]#"]
and Property_background_position = [%value.rec "[ <bg-position> ]#"]

and Property_background_position_x =
  [%value.rec
    "[ 'center' | [ 'left' | 'right' | 'x-start' | 'x-end' ]? [ \
     <extended-length> | <extended-percentage> ]? ]#"]

and Property_background_position_y =
  [%value.rec
    "[ 'center' | [ 'top' | 'bottom' | 'y-start' | 'y-end' ]? [ \
     <extended-length> | <extended-percentage> ]? ]#"]

and Property_background_repeat = [%value.rec "[ <repeat-style> ]#"]
and Property_background_size = [%value.rec "[ <bg-size> ]#"]

and Property_baseline_shift =
  [%value.rec "'baseline' | 'sub' | 'super' | <svg-length>"]

and Property_behavior = [%value.rec "[ <url> ]+"]
and Property_block_overflow = [%value.rec "'clip' | 'ellipsis' | <string>"]
and Property_block_size = [%value.rec "<'width'>"]

and Property_border =
  [%value.rec
    "'none' | [ <line-width> | <interpolation> ] | [ <line-width> | \
     <interpolation> ] [ <line-style> | <interpolation> ] | [ <line-width> | \
     <interpolation> ] [ <line-style> | <interpolation> ] [ <color> | \
     <interpolation> ]"]

and Property_border_block = [%value.rec "<'border'>"]
and Property_border_block_color = [%value.rec "[ <'border-top-color'> ]{1,2}"]
and Property_border_block_end = [%value.rec "<'border'>"]
and Property_border_block_end_color = [%value.rec "<'border-top-color'>"]
and Property_border_block_end_style = [%value.rec "<'border-top-style'>"]
and Property_border_block_end_width = [%value.rec "<'border-top-width'>"]
and Property_border_block_start = [%value.rec "<'border'>"]
and Property_border_block_start_color = [%value.rec "<'border-top-color'>"]
and Property_border_block_start_style = [%value.rec "<'border-top-style'>"]
and Property_border_block_start_width = [%value.rec "<'border-top-width'>"]
and Property_border_block_style = [%value.rec "<'border-top-style'>"]
and Property_border_block_width = [%value.rec "<'border-top-width'>"]
and Property_border_bottom = [%value.rec "<'border'>"]
and Property_border_bottom_color = [%value.rec "<'border-top-color'>"]

and Property_border_bottom_left_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and Property_border_bottom_right_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and Property_border_bottom_style = [%value.rec "<line-style>"]
and Property_border_bottom_width = [%value.rec "<line-width>"]
and Property_border_collapse = [%value.rec "'collapse' | 'separate'"]
and Property_border_color = [%value.rec "[ <color> ]{1,4}"]

and Property_border_end_end_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and Property_border_end_start_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and Property_border_image =
  [%value.rec
    "<'border-image-source'> || <'border-image-slice'> [ '/' \
     <'border-image-width'> | '/' [ <'border-image-width'> ]? '/' \
     <'border-image-outset'> ]? || <'border-image-repeat'>"]

and Property_border_image_outset =
  [%value.rec "[ <extended-length> | <number> ]{1,4}"]

and Property_border_image_repeat =
  [%value.rec "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}"]

and Property_border_image_slice =
  [%value.rec "[ <number-percentage> ]{1,4} && [ 'fill' ]?"]

and Property_border_image_source = [%value.rec "'none' | <image>"]

and Property_border_image_width =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}"]

and Property_border_inline = [%value.rec "<'border'>"]
and Property_border_inline_color = [%value.rec "[ <'border-top-color'> ]{1,2}"]
and Property_border_inline_end = [%value.rec "<'border'>"]
and Property_border_inline_end_color = [%value.rec "<'border-top-color'>"]
and Property_border_inline_end_style = [%value.rec "<'border-top-style'>"]
and Property_border_inline_end_width = [%value.rec "<'border-top-width'>"]
and Property_border_inline_start = [%value.rec "<'border'>"]
and Property_border_inline_start_color = [%value.rec "<'border-top-color'>"]
and Property_border_inline_start_style = [%value.rec "<'border-top-style'>"]
and Property_border_inline_start_width = [%value.rec "<'border-top-width'>"]
and Property_border_inline_style = [%value.rec "<'border-top-style'>"]
and Property_border_inline_width = [%value.rec "<'border-top-width'>"]
and Property_border_left = [%value.rec "<'border'>"]
and Property_border_left_color = [%value.rec "<color>"]
and Property_border_left_style = [%value.rec "<line-style>"]
and Property_border_left_width = [%value.rec "<line-width>"]

(* border-radius isn't supported with the entire spec in bs-css: `"[ <extended-length> | <extended-percentage> ]{1,4} [ '/' [ <extended-length> | <extended-percentage> ]{1,4} ]?"` *)
and Property_border_radius =
  [%value.rec "<extended-length> | <extended-percentage>"]

and Property_border_right = [%value.rec "<'border'>"]
and Property_border_right_color = [%value.rec "<color>"]
and Property_border_right_style = [%value.rec "<line-style>"]
and Property_border_right_width = [%value.rec "<line-width>"]

and Property_border_spacing =
  [%value.rec "<extended-length> [ <extended-length> ]?"]

and Property_border_start_end_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and Property_border_start_start_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

(* bs-css doesn't support list of styles, the original spec is: `[ <line-style> ]{1,4}` *)
and Property_border_style = [%value.rec "<line-style>"]
and Property_border_top = [%value.rec "<'border'>"]
and Property_border_top_color = [%value.rec "<color>"]

and Property_border_top_left_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and Property_border_top_right_radius =
  [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]

and Property_border_top_style = [%value.rec "<line-style>"]
and Property_border_top_width = [%value.rec "<line-width>"]
and Property_border_width = [%value.rec "[ <line-width> ]{1,4}"]

and Property_bottom =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and Property_box_align =
  [%value.rec "'start' | 'center' | 'end' | 'baseline' | 'stretch'"]

and Property_box_decoration_break = [%value.rec "'slice' | 'clone'"]
and Property_box_direction = [%value.rec "'normal' | 'reverse' | 'inherit'"]
and Property_box_flex = [%value.rec "<number>"]
and Property_box_flex_group = [%value.rec "<integer>"]
and Property_box_lines = [%value.rec "'single' | 'multiple'"]
and Property_box_ordinal_group = [%value.rec "<integer>"]

and Property_box_orient =
  [%value.rec
    "'horizontal' | 'vertical' | 'inline-axis' | 'block-axis' | 'inherit'"]

and Property_box_pack = [%value.rec "'start' | 'center' | 'end' | 'justify'"]

and Property_box_shadow =
  [%value.rec "'none' | <interpolation> | [ <shadow> ]#"]

and Property_box_sizing = [%value.rec "'content-box' | 'border-box'"]

and Property_break_after =
  [%value.rec
    "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | \
     'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' \
     | 'region'"]

and Property_break_before =
  [%value.rec
    "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | \
     'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' \
     | 'region'"]

and Property_break_inside =
  [%value.rec
    "'auto' | 'avoid' | 'avoid-page' | 'avoid-column' | 'avoid-region'"]

and Property_caption_side =
  [%value.rec
    "'top' | 'bottom' | 'block-start' | 'block-end' | 'inline-start' | \
     'inline-end'"]

and Property_caret_color = [%value.rec "'auto' | <color>"]

and Property_clear =
  [%value.rec
    "'none' | 'left' | 'right' | 'both' | 'inline-start' | 'inline-end'"]

and Property_clip = [%value.rec "<shape> | 'auto'"]

and Property_clip_path =
  [%value.rec "<clip-source> | <basic-shape> || <geometry-box> | 'none'"]

and Property_clip_rule = [%value.rec "'nonzero' | 'evenodd'"]
and Property_color = [%value.rec "<color>"]

and Property_color_interpolation_filters =
  [%value.rec "'auto' | 'sRGB' | 'linearRGB'"]

and Property_color_interpolation = [%value.rec "'auto' | 'sRGB' | 'linearRGB'"]
and Property_color_adjust = [%value.rec "'economy' | 'exact'"]
and Property_column_count = [%value.rec "<integer> | 'auto'"]
and Property_column_fill = [%value.rec "'auto' | 'balance' | 'balance-all'"]

and Property_column_gap =
  [%value.rec "'normal' | <extended-length> | <extended-percentage>"]

and Property_column_rule =
  [%value.rec
    "<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>"]

and Property_column_rule_color = [%value.rec "<color>"]
and Property_column_rule_style = [%value.rec "<'border-style'>"]
and Property_column_rule_width = [%value.rec "<'border-width'>"]
and Property_column_span = [%value.rec "'none' | 'all'"]
and Property_column_width = [%value.rec "<extended-length> | 'auto'"]
and Property_columns = [%value.rec "<'column-width'> || <'column-count'>"]

and Property_contain =
  [%value.rec
    "'none' | 'strict' | 'content' | 'size' || 'layout' || 'style' || 'paint'"]

and Property_content =
  [%value.rec
    "'normal' | 'none' | <string> | <interpolation> | [ <content-replacement> \
     | <content-list> ] [ '/' <string> ]?"]

and Property_content_visibility = [%value.rec "'visible' | 'hidden' | 'auto'"]

and Property_counter_increment =
  [%value.rec "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]

and Property_counter_reset =
  [%value.rec "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]

and Property_counter_set =
  [%value.rec "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]

and Property_cue = [%value.rec "<'cue-before'> [ <'cue-after'> ]?"]
and Property_cue_after = [%value.rec "<url> [ <decibel> ]? | 'none'"]
and Property_cue_before = [%value.rec "<url> [ <decibel> ]? | 'none'"]

(* and property_cursor = [%value.rec
     "[ <url> [ <x> <y> ]? ',' ]* [ 'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | 'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | 'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | 'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | 'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | 'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | 'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' | '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' ] | <interpolation>"
   ] *)
(* Removed [ <url> [ <x> <y> ]? ',' ]* *)
and Property_cursor =
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

and Property_direction = [%value.rec "'ltr' | 'rtl'"]

and Property_display =
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

and Property_dominant_baseline =
  [%value.rec
    "'auto' | 'use-script' | 'no-change' | 'reset-size' | 'ideographic' | \
     'alphabetic' | 'hanging' | 'mathematical' | 'central' | 'middle' | \
     'text-after-edge' | 'text-before-edge'"]

and Property_empty_cells = [%value.rec "'show' | 'hide'"]
and Property_fill = [%value.rec "<paint>"]
and Property_fill_opacity = [%value.rec "<alpha-value>"]
and Property_fill_rule = [%value.rec "'nonzero' | 'evenodd'"]

and Property_filter =
  [%value.rec "'none' | <interpolation> | <filter-function-list>"]

and Property_flex =
  [%value.rec
    "'none' | [<'flex-grow'> [ <'flex-shrink'> ]? || <'flex-basis'>] | \
     <interpolation>"]

and Property_flex_basis = [%value.rec "'content' | <'width'> | <interpolation>"]

and Property_flex_direction =
  [%value.rec "'row' | 'row-reverse' | 'column' | 'column-reverse'"]

and Property_flex_flow = [%value.rec "<'flex-direction'> || <'flex-wrap'>"]
and Property_flex_grow = [%value.rec "<number> | <interpolation>"]
and Property_flex_shrink = [%value.rec "<number> | <interpolation>"]
and Property_flex_wrap = [%value.rec "'nowrap' | 'wrap' | 'wrap-reverse'"]

and Property_float =
  [%value.rec "'left' | 'right' | 'none' | 'inline-start' | 'inline-end'"]

and Property_font =
  [%value.rec
    "[ <'font-style'> || <font-variant-css21> || <'font-weight'> || \
     <'font-stretch'> ]? <'font-size'> [ '/' <'line-height'> ]? \
     <'font-family'> | 'caption' | 'icon' | 'menu' | 'message-box' | \
     'small-caption' | 'status-bar'"]

and Font_families =
  [%value.rec "[ <family-name> | <generic-family> | <interpolation> ]#"]

and Property_font_family = [%value.rec "<font_families> | <interpolation>"]

and Property_font_feature_settings =
  [%value.rec "'normal' | [ <feature-tag-value> ]#"]

and Property_font_kerning = [%value.rec "'auto' | 'normal' | 'none'"]
and Property_font_language_override = [%value.rec "'normal' | <string>"]
and Property_font_optical_sizing = [%value.rec "'auto' | 'none'"]
and Property_font_palette = [%value.rec "'normal' | 'light' | 'dark'"]

and Property_font_size =
  [%value.rec
    "<absolute-size> | <relative-size> | <extended-length> | \
     <extended-percentage>"]

and Property_font_size_adjust = [%value.rec "'none' | <number>"]

and Property_font_smooth =
  [%value.rec
    "'auto' | 'never' | 'always' | <absolute-size> | <extended-length>"]

and Property_font_stretch = [%value.rec "<font-stretch-absolute>"]

and Property_font_style =
  [%value.rec
    "'normal' | 'italic' | 'oblique' | <interpolation> | [ 'oblique' \
     <extended-angle> ]?"]

and Property_font_synthesis =
  [%value.rec "'none' | [ 'weight' || 'style' || 'small-caps' || 'position' ]"]

and Property_font_synthesis_weight = [%value.rec "'auto' | 'none'"]
and Property_font_synthesis_style = [%value.rec "'auto' | 'none'"]
and Property_font_synthesis_small_caps = [%value.rec "'auto' | 'none'"]
and Property_font_synthesis_position = [%value.rec "'auto' | 'none'"]

and Property_font_variant =
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

and Property_font_variant_alternates =
  [%value.rec
    "'normal' | stylistic( <feature-value-name> ) || 'historical-forms' || \
     styleset( [ <feature-value-name> ]# ) || character-variant( [ \
     <feature-value-name> ]# ) || swash( <feature-value-name> ) || ornaments( \
     <feature-value-name> ) || annotation( <feature-value-name> )"]

and Property_font_variant_caps =
  [%value.rec
    "'normal' | 'small-caps' | 'all-small-caps' | 'petite-caps' | \
     'all-petite-caps' | 'unicase' | 'titling-caps'"]

and Property_font_variant_east_asian =
  [%value.rec
    "'normal' | <east-asian-variant-values> || <east-asian-width-values> || \
     'ruby'"]

and Property_font_variant_ligatures =
  [%value.rec
    "'normal' | 'none' | <common-lig-values> || <discretionary-lig-values> || \
     <historical-lig-values> || <contextual-alt-values>"]

and Property_font_variant_numeric =
  [%value.rec
    "'normal' | <numeric-figure-values> || <numeric-spacing-values> || \
     <numeric-fraction-values> || 'ordinal' || 'slashed-zero'"]

and Property_font_variant_position = [%value.rec "'normal' | 'sub' | 'super'"]

and Property_font_variation_settings =
  [%value.rec "'normal' | [ <string> <number> ]#"]

and Property_font_variant_emoji =
  [%value.rec "'normal' | 'text' | 'emoji' | 'unicode'"]

and Property_font_weight =
  [%value.rec "<font-weight-absolute> | 'bolder' | 'lighter' | <interpolation>"]

and Property_gap = [%value.rec "<'row-gap'> [ <'column-gap'> ]?"]
and Property_glyph_orientation_horizontal = [%value.rec "<extended-angle>"]
and Property_glyph_orientation_vertical = [%value.rec "<extended-angle>"]

and Property_grid =
  [%value.rec
    "<'grid-template'>\n\
    \  | <'grid-template-rows'> '/' [ 'auto-flow' && [ 'dense' ]? ] [ \
     <'grid-auto-columns'> ]?\n\
    \  | [ 'auto-flow' && [ 'dense' ]? ] [ <'grid-auto-rows'> ]? '/' \
     <'grid-template-columns'>"]

and Property_grid_area = [%value.rec "<grid-line> [ '/' <grid-line> ]{0,3}"]
and Property_grid_auto_columns = [%value.rec "[ <track-size> ]+"]

and Property_grid_auto_flow =
  [%value.rec "[ [ 'row' | 'column' ] || 'dense' ] | <interpolation>"]

and Property_grid_auto_rows = [%value.rec "[ <track-size> ]+"]
and Property_grid_column = [%value.rec "<grid-line> [ '/' <grid-line> ]?"]
and Property_grid_column_end = [%value.rec "<grid-line>"]

and Property_grid_column_gap =
  [%value.rec "<extended-length> | <extended-percentage>"]

and Property_grid_column_start = [%value.rec "<grid-line>"]
and Property_grid_gap = [%value.rec "<'grid-row-gap'> [ <'grid-column-gap'> ]?"]
and Property_grid_row = [%value.rec "<grid-line> [ '/' <grid-line> ]?"]
and Property_grid_row_end = [%value.rec "<grid-line>"]

and Property_grid_row_gap =
  [%value.rec "<extended-length> | <extended-percentage>"]

and Property_grid_row_start = [%value.rec "<grid-line>"]

and Property_grid_template =
  [%value.rec
    "'none' | <'grid-template-rows'> '/' <'grid-template-columns'> | [ [ \
     <line-names> ]? <string> [ <track-size> ]? [ <line-names> ]? ]+ [ '/' \
     <explicit-track-list> ]?"]

and Property_grid_template_areas =
  [%value.rec "'none' | [ <string> | <interpolation> ]+"]

and Property_grid_template_columns =
  [%value.rec
    "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> \
     ]? | 'masonry' | <interpolation>"]

and Property_grid_template_rows =
  [%value.rec
    "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> \
     ]? | 'masonry' | <interpolation>"]

and Property_hanging_punctuation =
  [%value.rec "'none' | 'first' || [ 'force-end' | 'allow-end' ] || 'last'"]

and Property_height =
  [%value.rec
    "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
     'max-content' | 'fit-content' | fit-content( <extended-length> | \
     <extended-percentage> )"]

and Property_hyphens = [%value.rec "'none' | 'manual' | 'auto'"]
and Property_hyphenate_character = [%value.rec "'auto' | <string-token>"]
and Property_hyphenate_limit_chars = [%value.rec "'auto' | <integer>"]
and Property_hyphenate_limit_lines = [%value.rec "'no-limit' | <integer>"]

and Property_hyphenate_limit_zone =
  [%value.rec "<extended-length> | <extended-percentage>"]

and Property_image_orientation =
  [%value.rec "'from-image' | <extended-angle> | [ <extended-angle> ]? 'flip'"]

and Property_image_rendering =
  [%value.rec "'auto' |'smooth' | 'high-quality' | 'crisp-edges' | 'pixelated'"]

and Property_image_resolution =
  [%value.rec "[ 'from-image' || <resolution> ] && [ 'snap' ]?"]

and Property_ime_mode =
  [%value.rec "'auto' | 'normal' | 'active' | 'inactive' | 'disabled'"]

and Property_initial_letter = [%value.rec "'normal' | <number> [ <integer> ]?"]

and Property_initial_letter_align =
  [%value.rec "'auto' | 'alphabetic' | 'hanging' | 'ideographic'"]

and Property_inline_size = [%value.rec "<'width'>"]
and Property_inset = [%value.rec "[ <'top'> ]{1,4}"]
and Property_inset_block = [%value.rec "[ <'top'> ]{1,2}"]
and Property_inset_block_end = [%value.rec "<'top'>"]
and Property_inset_block_start = [%value.rec "<'top'>"]
and Property_inset_inline = [%value.rec "[ <'top'> ]{1,2}"]
and Property_inset_inline_end = [%value.rec "<'top'>"]
and Property_inset_inline_start = [%value.rec "<'top'>"]
and Property_isolation = [%value.rec "'auto' | 'isolate'"]

and Property_justify_content =
  [%value.rec
    "'normal' | <content-distribution> | [ <overflow-position> ]? [ \
     <content-position> | 'left' | 'right' ]"]

and Property_justify_items =
  [%value.rec
    "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? [ \
     <self-position> | 'left' | 'right' ] | 'legacy' | 'legacy' && [ 'left' | \
     'right' | 'center' ]"]

and Property_justify_self =
  [%value.rec
    "'auto' | 'normal' | 'stretch' | <baseline-position> | [ \
     <overflow-position> ]? [ <self-position> | 'left' | 'right' ]"]

and Property_kerning = [%value.rec "'auto' | <svg-length>"]

and Property_layout_grid =
  [%value.rec "'auto' | <custom-ident> | <integer> && [ <custom-ident> ]?"]

and Property_layout_grid_char =
  [%value.rec "'auto' | <custom-ident> | <string>"]

and Property_layout_grid_line =
  [%value.rec "'auto' | <custom-ident> | <string>"]

and Property_layout_grid_mode =
  [%value.rec "'auto' | <custom-ident> | <string>"]

and Property_layout_grid_type =
  [%value.rec "'auto' | <custom-ident> | <string>"]

and Property_left =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and Property_letter_spacing =
  [%value.rec "'normal' | <extended-length> | <extended-percentage>"]

and Property_line_break =
  [%value.rec
    "'auto' | 'loose' | 'normal' | 'strict' | 'anywhere' | <interpolation>"]

and Property_line_clamp = [%value.rec "'none' | <integer>"]

and Property_line_height =
  [%value.rec "'normal' | <number> | <extended-length> | <extended-percentage>"]

and Property_line_height_step = [%value.rec "<extended-length>"]

and Property_list_style =
  [%value.rec
    "<'list-style-type'> || <'list-style-position'> || <'list-style-image'>"]

and Property_list_style_image = [%value.rec "'none' | <image>"]
and Property_list_style_position = [%value.rec "'inside' | 'outside'"]

and Property_list_style_type =
  [%value.rec "<counter-style> | <string> | 'none'"]

and Property_margin =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | 'auto' | <interpolation> \
     ]{1,4}"]

and Property_margin_block = [%value.rec "[ <'margin-left'> ]{1,2}"]
and Property_margin_block_end = [%value.rec "<'margin-left'>"]
and Property_margin_block_start = [%value.rec "<'margin-left'>"]

and Property_margin_bottom =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and Property_margin_inline = [%value.rec "[ <'margin-left'> ]{1,2}"]
and Property_margin_inline_end = [%value.rec "<'margin-left'>"]
and Property_margin_inline_start = [%value.rec "<'margin-left'>"]

and Property_margin_left =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and Property_margin_right =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and Property_margin_top =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and Property_margin_trim = [%value.rec "'none' | 'in-flow' | 'all'"]
and Property_marker = [%value.rec "'none' | <url>"]
and Property_marker_end = [%value.rec "'none' | <url>"]
and Property_marker_mid = [%value.rec "'none' | <url>"]
and Property_marker_start = [%value.rec "'none' | <url>"]
and Property_mask = [%value.rec "[ <mask-layer> ]#"]

and Property_mask_border =
  [%value.rec
    "<'mask-border-source'> || <'mask-border-slice'> [ '/' [ \
     <'mask-border-width'> ]? [ '/' <'mask-border-outset'> ]? ]? || \
     <'mask-border-repeat'> || <'mask-border-mode'>"]

and Property_mask_border_mode = [%value.rec "'luminance' | 'alpha'"]

and Property_mask_border_outset =
  [%value.rec "[ <extended-length> | <number> ]{1,4}"]

and Property_mask_border_repeat =
  [%value.rec "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}"]

and Property_mask_border_slice =
  [%value.rec "[ <number-percentage> ]{1,4} [ 'fill' ]?"]

and Property_mask_border_source = [%value.rec "'none' | <image>"]

and Property_mask_border_width =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}"]

and Property_mask_clip = [%value.rec "[ <geometry-box> | 'no-clip' ]#"]
and Property_mask_composite = [%value.rec "[ <compositing-operator> ]#"]
and Property_mask_image = [%value.rec "[ <mask-reference> ]#"]
and Property_mask_mode = [%value.rec "[ <masking-mode> ]#"]
and Property_mask_origin = [%value.rec "[ <geometry-box> ]#"]
and Property_mask_position = [%value.rec "[ <position> ]#"]
and Property_mask_repeat = [%value.rec "[ <repeat-style> ]#"]
and Property_mask_size = [%value.rec "[ <bg-size> ]#"]
and Property_mask_type = [%value.rec "'luminance' | 'alpha'"]

and Property_masonry_auto_flow =
  [%value.rec "[ 'pack' | 'next' ] || [ 'definite-first' | 'ordered' ]"]

and Property_max_block_size = [%value.rec "<'max-width'>"]

and Property_max_height =
  [%value.rec
    "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
     'max-content' | 'fit-content' | fit-content( <extended-length> | \
     <extended-percentage> )"]

and Property_max_inline_size = [%value.rec "<'max-width'>"]
and Property_max_lines = [%value.rec "'none' | <integer>"]

and Property_max_width =
  [%value.rec
    "<extended-length> | <extended-percentage> | 'none' | 'max-content' | \
     'min-content' | 'fit-content' | fit-content( <extended-length> | \
     <extended-percentage> ) | 'fill-available' | <-non-standard-width>"]

and Property_min_block_size = [%value.rec "<'min-width'>"]

and Property_min_height =
  [%value.rec
    "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
     'max-content' | 'fit-content' | fit-content( <extended-length> | \
     <extended-percentage> )"]

and Property_min_inline_size = [%value.rec "<'min-width'>"]

and Property_min_width =
  [%value.rec
    "<extended-length> | <extended-percentage> | 'auto' | 'max-content' | \
     'min-content' | 'fit-content' | fit-content( <extended-length> | \
     <extended-percentage> ) | 'fill-available' | <-non-standard-width>"]

and Property_mix_blend_mode = [%value.rec "<blend-mode>"]
and Property_media_any_hover = [%value.rec "none | hover"]
and Property_media_any_pointer = [%value.rec "none | coarse | fine"]
and Property_media_pointer = [%value.rec "none | coarse | fine"]
and Property_media_max_aspect_ratio = [%value.rec "<ratio>"]
and Property_media_min_aspect_ratio = [%value.rec "<ratio>"]
and Property_media_min_color = [%value.rec "<integer>"]
and Property_media_color_gamut = [%value.rec "'srgb' | 'p3' | 'rec2020'"]
and Property_media_color_index = [%value.rec "<integer>"]
and Property_media_min_color_index = [%value.rec "<integer>"]

and Property_media_display_mode =
  [%value.rec "'fullscreen' | 'standalone' | 'minimal-ui' | 'browser'"]

and Property_media_forced_colors = [%value.rec "'none' | 'active'"]

and Property_forced_color_adjust =
  [%value.rec "'auto' | 'none' | 'preserve-parent-color'"]

and Property_media_grid = [%value.rec "<integer>"]
and Property_media_hover = [%value.rec "'hover' | 'none'"]
and Property_media_inverted_colors = [%value.rec "'inverted' | 'none'"]
and Property_media_monochrome = [%value.rec "<integer>"]
and Property_media_prefers_color_scheme = [%value.rec "'dark' | 'light'"]

and Property_color_scheme =
  [%value.rec "'normal' |\n  [ 'dark' | 'light' | <custom-ident> ]+ && 'only'?"]

and Property_media_prefers_contrast =
  [%value.rec "'no-preference' | 'more' | 'less'"]

and Property_media_prefers_reduced_motion =
  [%value.rec "'no-preference' | 'reduce'"]

and Property_media_resolution = [%value.rec "<resolution>"]
and Property_media_min_resolution = [%value.rec "<resolution>"]
and Property_media_max_resolution = [%value.rec "<resolution>"]

and Property_media_scripting =
  [%value.rec "'none' | 'initial-only' | 'enabled'"]

and Property_media_update = [%value.rec "'none' | 'slow' | 'fast'"]
and Property_media_orientation = [%value.rec "'portrait' | 'landscape'"]

and Property_object_fit =
  [%value.rec "'fill' | 'contain' | 'cover' | 'none' | 'scale-down'"]

and Property_object_position = [%value.rec "<position>"]

and Property_offset =
  [%value.rec
    "[ [ <'offset-position'> ]? <'offset-path'> [ <'offset-distance'> || \
     <'offset-rotate'> ]? ]? [ '/' <'offset-anchor'> ]?"]

and Property_offset_anchor = [%value.rec "'auto' | <position>"]

and Property_offset_distance =
  [%value.rec "<extended-length> | <extended-percentage>"]

and Property_offset_path =
  [%value.rec
    "'none' | ray( <extended-angle> && [ <ray_size> ]? && [ 'contain' ]? ) | \
     <path()> | <url> | <basic-shape> || <geometry-box>"]

and Property_offset_position = [%value.rec "'auto' | <position>"]

and Property_offset_rotate =
  [%value.rec "[ 'auto' | 'reverse' ] || <extended-angle>"]

and Property_opacity = [%value.rec "<alpha-value>"]
and Property_order = [%value.rec "<integer>"]
and Property_orphans = [%value.rec "<integer>"]

and Property_outline =
  [%value.rec
    "'none' | <'outline-width'> | [ <'outline-width'> <'outline-style'> ] | [ \
     <'outline-width'> <'outline-style'> [ <color> | <interpolation> ]]"]

and Property_outline_color = [%value.rec "<color>"]
and Property_outline_offset = [%value.rec "<extended-length>"]

and Property_outline_style =
  [%value.rec "'auto' | <line-style> | <interpolation>"]

and Property_outline_width = [%value.rec "<line-width> | <interpolation>"]

and Property_overflow =
  [%value.rec
    "[ 'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' ]{1,2} | \
     <-non-standard-overflow> | <interpolation>"]

and Property_overflow_anchor = [%value.rec "'auto' | 'none'"]

and Property_overflow_block =
  [%value.rec
    "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

and Property_overflow_clip_margin =
  [%value.rec "<visual-box> || <extended-length>"]

and Property_overflow_inline =
  [%value.rec
    "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

and Property_overflow_wrap = [%value.rec "'normal' | 'break-word' | 'anywhere'"]

and Property_overflow_x =
  [%value.rec
    "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

and Property_overflow_y =
  [%value.rec
    "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | <interpolation>"]

and Property_overscroll_behavior =
  [%value.rec "[ 'contain' | 'none' | 'auto' ]{1,2}"]

and Property_overscroll_behavior_block =
  [%value.rec "'contain' | 'none' | 'auto'"]

and Property_overscroll_behavior_inline =
  [%value.rec "'contain' | 'none' | 'auto'"]

and Property_overscroll_behavior_x = [%value.rec "'contain' | 'none' | 'auto'"]
and Property_overscroll_behavior_y = [%value.rec "'contain' | 'none' | 'auto'"]

and Property_padding =
  [%value.rec
    "[ <extended-length> | <extended-percentage> | <interpolation> ]{1,4}"]

and Property_padding_block = [%value.rec "[ <'padding-left'> ]{1,2}"]
and Property_padding_block_end = [%value.rec "<'padding-left'>"]
and Property_padding_block_start = [%value.rec "<'padding-left'>"]

and Property_padding_bottom =
  [%value.rec "<extended-length> | <extended-percentage>"]

and Property_padding_inline = [%value.rec "[ <'padding-left'> ]{1,2}"]
and Property_padding_inline_end = [%value.rec "<'padding-left'>"]
and Property_padding_inline_start = [%value.rec "<'padding-left'>"]

and Property_padding_left =
  [%value.rec "<extended-length> | <extended-percentage>"]

and Property_padding_right =
  [%value.rec "<extended-length> | <extended-percentage>"]

and Property_padding_top =
  [%value.rec "<extended-length> | <extended-percentage>"]

and Property_page_break_after =
  [%value.rec
    "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'"]

and Property_page_break_before =
  [%value.rec
    "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'"]

and Property_page_break_inside = [%value.rec "'auto' | 'avoid'"]

and Property_paint_order =
  [%value.rec "'normal' | 'fill' || 'stroke' || 'markers'"]

and Property_pause = [%value.rec "<'pause-before'> [ <'pause-after'> ]?"]

and Property_pause_after =
  [%value.rec
    "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
     'x-strong'"]

and Property_pause_before =
  [%value.rec
    "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
     'x-strong'"]

and Property_perspective = [%value.rec "'none' | <extended-length>"]
and Property_perspective_origin = [%value.rec "<position>"]

and Property_place_content =
  [%value.rec "<'align-content'> [ <'justify-content'> ]?"]

and Property_place_items = [%value.rec "<'align-items'> [ <'justify-items'> ]?"]
and Property_place_self = [%value.rec "<'align-self'> [ <'justify-self'> ]?"]

and Property_pointer_events =
  [%value.rec
    "'auto' | 'none' | 'visiblePainted' | 'visibleFill' | 'visibleStroke' | \
     'visible' | 'painted' | 'fill' | 'stroke' | 'all' | 'inherit'"]

and Property_position =
  [%value.rec
    "'static' | 'relative' | 'absolute' | 'sticky' | 'fixed' | '-webkit-sticky'"]

and Property_quotes = [%value.rec "'none' | 'auto' | [ <string> <string> ]+"]

and Property_resize =
  [%value.rec
    "'none' | 'both' | 'horizontal' | 'vertical' | 'block' | 'inline'"]

and Property_rest = [%value.rec "<'rest-before'> [ <'rest-after'> ]?"]

and Property_rest_after =
  [%value.rec
    "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
     'x-strong'"]

and Property_rest_before =
  [%value.rec
    "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
     'x-strong'"]

and Property_right =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and Property_rotate =
  [%value.rec
    "'none' | <extended-angle> | [ 'x' | 'y' | 'z' | [ <number> ]{3} ] && \
     <extended-angle>"]

and Property_row_gap =
  [%value.rec "'normal' | <extended-length> | <extended-percentage>"]

and Property_ruby_align =
  [%value.rec "'start' | 'center' | 'space-between' | 'space-around'"]

and Property_ruby_merge = [%value.rec "'separate' | 'collapse' | 'auto'"]
and Property_ruby_position = [%value.rec "'over' | 'under' | 'inter-character'"]
and Property_scale = [%value.rec "'none' | [ <number-percentage> ]{1,3}"]
and Property_scroll_behavior = [%value.rec "'auto' | 'smooth'"]
and Property_scroll_margin = [%value.rec "[ <extended-length> ]{1,4}"]
and Property_scroll_margin_block = [%value.rec "[ <extended-length> ]{1,2}"]
and Property_scroll_margin_block_end = [%value.rec "<extended-length>"]
and Property_scroll_margin_block_start = [%value.rec "<extended-length>"]
and Property_scroll_margin_bottom = [%value.rec "<extended-length>"]
and Property_scroll_margin_inline = [%value.rec "[ <extended-length> ]{1,2}"]
and Property_scroll_margin_inline_end = [%value.rec "<extended-length>"]
and Property_scroll_margin_inline_start = [%value.rec "<extended-length>"]
and Property_scroll_margin_left = [%value.rec "<extended-length>"]
and Property_scroll_margin_right = [%value.rec "<extended-length>"]
and Property_scroll_margin_top = [%value.rec "<extended-length>"]

and Property_scroll_padding =
  [%value.rec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,4}"]

and Property_scroll_padding_block =
  [%value.rec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]

and Property_scroll_padding_block_end =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and Property_scroll_padding_block_start =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and Property_scroll_padding_bottom =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and Property_scroll_padding_inline =
  [%value.rec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]

and Property_scroll_padding_inline_end =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and Property_scroll_padding_inline_start =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and Property_scroll_padding_left =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and Property_scroll_padding_right =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and Property_scroll_padding_top =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and Property_scroll_snap_align =
  [%value.rec "[ 'none' | 'start' | 'end' | 'center' ]{1,2}"]

and Property_scroll_snap_coordinate = [%value.rec "'none' | [ <position> ]#"]
and Property_scroll_snap_destination = [%value.rec "<position>"]

and Property_scroll_snap_points_x =
  [%value.rec "'none' | repeat( <extended-length> | <extended-percentage> )"]

and Property_scroll_snap_points_y =
  [%value.rec "'none' | repeat( <extended-length> | <extended-percentage> )"]

and Property_scroll_snap_stop = [%value.rec "'normal' | 'always'"]

and Property_scroll_snap_type =
  [%value.rec
    "'none' | [ 'x' | 'y' | 'block' | 'inline' | 'both' ] [ 'mandatory' | \
     'proximity' ]?"]

and Property_scroll_snap_type_x =
  [%value.rec "'none' | 'mandatory' | 'proximity'"]

and Property_scroll_snap_type_y =
  [%value.rec "'none' | 'mandatory' | 'proximity'"]

and Property_scrollbar_color = [%value.rec "'auto' | [ <color> <color> ]"]
and Property_scrollbar_width = [%value.rec "'auto' | 'thin' | 'none'"]

and Property_scrollbar_gutter =
  [%value.rec "'auto' | 'stable' && 'both-edges'?"]

and Property_scrollbar_3dlight_color = [%value.rec "<color>"]
and Property_scrollbar_arrow_color = [%value.rec "<color>"]
and Property_scrollbar_base_color = [%value.rec "<color>"]
and Property_scrollbar_darkshadow_color = [%value.rec "<color>"]
and Property_scrollbar_face_color = [%value.rec "<color>"]
and Property_scrollbar_highlight_color = [%value.rec "<color>"]
and Property_scrollbar_shadow_color = [%value.rec "<color>"]
and Property_scrollbar_track_color = [%value.rec "<color>"]
and Property_shape_image_threshold = [%value.rec "<alpha-value>"]

and Property_shape_margin =
  [%value.rec "<extended-length> | <extended-percentage>"]

and Property_shape_outside =
  [%value.rec "'none' | <shape-box> || <basic-shape> | <image>"]

and Property_shape_rendering =
  [%value.rec "'auto' | 'optimizeSpeed' | 'crispEdges' | 'geometricPrecision'"]

and Property_speak = [%value.rec "'auto' | 'none' | 'normal'"]

and Property_speak_as =
  [%value.rec
    "'normal' | 'spell-out' || 'digits' || [ 'literal-punctuation' | \
     'no-punctuation' ]"]

and Property_src =
  [%value.rec
    "[ <url> [ format( [ <string> ]# ) ]? | local( <family-name> ) ]#"]

and Property_stroke = [%value.rec "<paint>"]
and Property_stroke_dasharray = [%value.rec "'none' | [ [ <svg-length> ]+ ]#"]
and Property_stroke_dashoffset = [%value.rec "<svg-length>"]
and Property_stroke_linecap = [%value.rec "'butt' | 'round' | 'square'"]
and Property_stroke_linejoin = [%value.rec "'miter' | 'round' | 'bevel'"]
and Property_stroke_miterlimit = [%value.rec "<number-one-or-greater>"]
and Property_stroke_opacity = [%value.rec "<alpha-value>"]
and Property_stroke_width = [%value.rec "<svg-length>"]
and Property_tab_size = [%value.rec " <number> | <extended-length>"]
and Property_table_layout = [%value.rec "'auto' | 'fixed'"]

and Property_text_autospace =
  [%value.rec
    "'none' | 'ideograph-alpha' | 'ideograph-numeric' | \
     'ideograph-parenthesis' | 'ideograph-space'"]

and Property_text_blink = [%value.rec "'none' | 'blink' | 'blink-anywhere'"]

and Property_text_align =
  [%value.rec
    "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | \
     'match-parent' | 'justify-all'"]

and Property_text_align_all =
  [%value.rec
    "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent'"]

and Property_text_align_last =
  [%value.rec
    "'auto' | 'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | \
     'match-parent'"]

and Property_text_anchor = [%value.rec "'start' | 'middle' | 'end'"]

and Property_text_combine_upright =
  [%value.rec "'none' | 'all' | 'digits' [ <integer> ]?"]

and Property_text_decoration =
  [%value.rec
    "<'text-decoration-color'> || <'text-decoration-style'> || \
     <'text-decoration-thickness'> || <'text-decoration-line'>"]

and Property_text_justify_trim = [%value.rec "'none' | 'all' | 'auto'"]

and Property_text_kashida =
  [%value.rec "'none' | 'horizontal' | 'vertical' | 'both'"]

and Property_text_kashida_space = [%value.rec "'normal' | 'pre' | 'post'"]
and Property_text_decoration_color = [%value.rec "<color>"]

(* Spec doesn't contain spelling-error and grammar-error: https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration-line but this list used to have them | 'spelling-error' | 'grammar-error'. Leaving this comment here for reference *)
(* and this definition has changed from the origianl, it might be a bug on the spec or our Generator,
   but simplifying to "|" simplifies it and solves the bug *)
and Property_text_decoration_line =
  [%value.rec
    "'none' | <interpolation> | [ 'underline' || 'overline' || 'line-through' \
     || 'blink' ]"]

and Property_text_decoration_skip =
  [%value.rec
    "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' \
     ] || 'edges' || 'box-decoration'"]

and Property_text_decoration_skip_self =
  [%value.rec
    "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' \
     ] || 'edges' || 'box-decoration'"]

and Property_text_decoration_skip_ink = [%value.rec "'auto' | 'all' | 'none'"]
and Property_text_decoration_skip_box = [%value.rec "'none' | 'all'"]

and Property_text_decoration_skip_spaces =
  [%value.rec
    "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' \
     ] || 'edges' || 'box-decoration'"]

and Property_text_decoration_skip_inset = [%value.rec "'none' | 'auto'"]

and Property_text_decoration_style =
  [%value.rec "'solid' | 'double' | 'dotted' | 'dashed' | 'wavy'"]

and Property_text_decoration_thickness =
  [%value.rec
    "'auto' | 'from-font' | <extended-length> | <extended-percentage>"]

and Property_text_emphasis =
  [%value.rec "<'text-emphasis-style'> || <'text-emphasis-color'>"]

and Property_text_emphasis_color = [%value.rec "<color>"]

and Property_text_emphasis_position =
  [%value.rec "[ 'over' | 'under' ] && [ 'right' | 'left' ]?"]

and Property_text_emphasis_style =
  [%value.rec
    "'none' | [ 'filled' | 'open' ] || [ 'dot' | 'circle' | 'double-circle' | \
     'triangle' | 'sesame' ] | <string>"]

and Property_text_indent =
  [%value.rec
    "[<extended-length> | <extended-percentage>] && [ 'hanging' ]? && [ \
     'each-line' ]?"]

and Property_text_justify =
  [%value.rec "'auto' | 'inter-character' | 'inter-word' | 'none'"]

and Property_text_orientation = [%value.rec "'mixed' | 'upright' | 'sideways'"]

and Property_text_overflow =
  [%value.rec "[ 'clip' | 'ellipsis' | <string> ]{1,2}"]

and Property_text_rendering =
  [%value.rec
    "'auto' | 'optimizeSpeed' | 'optimizeLegibility' | 'geometricPrecision'"]

and Property_text_shadow =
  [%value.rec "'none' | <interpolation> | [ <shadow-t> ]#"]

and Property_text_size_adjust =
  [%value.rec "'none' | 'auto' | <extended-percentage>"]

and Property_text_transform =
  [%value.rec
    "'none' | 'capitalize' | 'uppercase' | 'lowercase' | 'full-width' | \
     'full-size-kana'"]

and Property_text_underline_offset =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and Property_text_underline_position =
  [%value.rec "'auto' | 'from-font' | 'under' || [ 'left' | 'right' ]"]

and Property_top =
  [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]

and Property_touch_action =
  [%value.rec
    "'auto' | 'none' | [ 'pan-x' | 'pan-left' | 'pan-right' ] || [ 'pan-y' | \
     'pan-up' | 'pan-down' ] || 'pinch-zoom' | 'manipulation'"]

and Property_transform = [%value.rec "'none' | <transform-list>"]

and Property_transform_box =
  [%value.rec
    "'content-box' | 'border-box' | 'fill-box' | 'stroke-box' | 'view-box'"]

and Property_transform_origin =
  [%value.rec
    "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ]\n\
    \  | [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | \
     'center' | 'bottom' | <length-percentage> ] <length>?\n\
    \  | [[ 'center' | 'left' | 'right' ] && [ 'center' | 'top' | 'bottom' ]] \
     <length>? "]

and Property_transform_style = [%value.rec "'flat' | 'preserve-3d'"]

and Property_transition =
  [%value.rec "[ <single-transition> | <single-transition-no-interp> ]#"]

and Property_transition_behavior = [%value.rec "<transition-behavior-value>#"]
and Property_transition_delay = [%value.rec "[ <extended-time> ]#"]
and Property_transition_duration = [%value.rec "[ <extended-time> ]#"]

and Property_transition_property =
  [%value.rec "[ <single-transition-property> ]# | 'none'"]

and Property_transition_timing_function = [%value.rec "[ <timing-function> ]#"]

and Property_translate =
  [%value.rec "'none' | <length-percentage> [ <length-percentage> <length>? ]?"]

and Property_unicode_bidi =
  [%value.rec
    "'normal' | 'embed' | 'isolate' | 'bidi-override' | 'isolate-override' | \
     'plaintext' | '-moz-isolate' | '-moz-isolate-override' | '-moz-plaintext' \
     | '-webkit-isolate'"]

and Property_unicode_range = [%value.rec "[ <urange> ]#"]

and Property_user_select =
  [%value.rec "'auto' | 'text' | 'none' | 'contain' | 'all' | <interpolation>"]

and Property_vertical_align =
  [%value.rec
    "'baseline' | 'sub' | 'super' | 'text-top' | 'text-bottom' | 'middle' | \
     'top' | 'bottom' | <extended-percentage> | <extended-length>"]

and Property_visibility =
  [%value.rec "'visible' | 'hidden' | 'collapse' | <interpolation>"]

and Property_voice_balance =
  [%value.rec
    "<number> | 'left' | 'center' | 'right' | 'leftwards' | 'rightwards'"]

and Property_voice_duration = [%value.rec "'auto' | <extended-time>"]

and Property_voice_family =
  [%value.rec
    "[ [ <family-name> | <generic-voice> ] ',' ]* [ <family-name> | \
     <generic-voice> ] | 'preserve'"]

and Property_voice_pitch =
  [%value.rec
    "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | \
     'high' | 'x-high' ] || [ <extended-frequency> | <semitones> | \
     <extended-percentage> ]"]

and Property_voice_range =
  [%value.rec
    "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | \
     'high' | 'x-high' ] || [ <extended-frequency> | <semitones> | \
     <extended-percentage> ]"]

and Property_voice_rate =
  [%value.rec
    "[ 'normal' | 'x-slow' | 'slow' | 'medium' | 'fast' | 'x-fast' ] || \
     <extended-percentage>"]

and Property_voice_stress =
  [%value.rec "'normal' | 'strong' | 'moderate' | 'none' | 'reduced'"]

and Property_voice_volume =
  [%value.rec
    "'silent' | [ 'x-soft' | 'soft' | 'medium' | 'loud' | 'x-loud' ] || \
     <decibel>"]

and Property_white_space =
  [%value.rec
    "'normal' | 'pre' | 'nowrap' | 'pre-wrap' | 'pre-line' | 'break-spaces'"]

and Property_widows = [%value.rec "<integer>"]

and Property_width =
  [%value.rec
    "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
     'max-content' | 'fit-content' | fit-content( <extended-length> | \
     <extended-percentage> )"]

and Property_will_change = [%value.rec "'auto' | [ <animateable-feature> ]#"]

and Property_word_break =
  [%value.rec "'normal' | 'break-all' | 'keep-all' | 'break-word'"]

and Property_word_spacing =
  [%value.rec "'normal' | <extended-length> | <extended-percentage>"]

and Property_word_wrap = [%value.rec "'normal' | 'break-word' | 'anywhere'"]

and Property_writing_mode =
  [%value.rec
    "'horizontal-tb' | 'vertical-rl' | 'vertical-lr' | 'sideways-rl' | \
     'sideways-lr' | <svg-writing-mode>"]

and Property_z_index = [%value.rec "'auto' | <integer> | <interpolation>"]

and Property_zoom =
  [%value.rec "'normal' | 'reset' | <number> | <extended-percentage>"]

and Property_container =
  [%value.rec "<'container-name'> [ '/' <'container-type'> ]?"]

and Property_container_name = [%value.rec "<custom-ident>+ | 'none'"]
and Property_container_type = [%value.rec "'normal' | 'size' | 'inline-size'"]
and Property_nav_down = [%value.rec "'auto' | <integer> | <interpolation>"]
and Property_nav_left = [%value.rec "'auto' | <integer> | <interpolation>"]
and Property_nav_right = [%value.rec "'auto' | <integer> | <interpolation>"]
and Property_nav_up = [%value.rec "'auto' | <integer> | <interpolation>"]

and Pseudo_class_selector =
  [%value.rec "':' <ident-token> | ':' <function-token> <any-value> ')'"]

and Pseudo_element_selector = [%value.rec "':' <pseudo-class-selector>"]
and Pseudo_page = [%value.rec "':' [ 'left' | 'right' | 'first' | 'blank' ]"]

and Quote =
  [%value.rec
    "'open-quote' | 'close-quote' | 'no-open-quote' | 'no-close-quote'"]

and Ratio = [%value.rec "<integer> '/' <integer> | <number> | <interpolation>"]
and Relative_selector = [%value.rec "[ <combinator> ]? <complex-selector>"]
and Relative_selector_list = [%value.rec "[ <relative-selector> ]#"]
and Relative_size = [%value.rec "'larger' | 'smaller'"]

and Repeat_style =
  [%value.rec
    "'repeat-x' | 'repeat-y' | [ 'repeat' | 'space' | 'round' | 'no-repeat' ] \
     [ 'repeat' | 'space' | 'round' | 'no-repeat' ]?"]

and Right = [%value.rec "<extended-length> | 'auto'"]

and Self_position =
  [%value.rec
    "'center' | 'start' | 'end' | 'self-start' | 'self-end' | 'flex-start' | \
     'flex-end'"]

and Shadow =
  [%value.rec
    "[ 'inset' ]? [ <extended-length> | <interpolation> ]{4} [ <color> | \
     <interpolation> ]?"]

and Shadow_t =
  [%value.rec
    "[ <extended-length> | <interpolation> ]{3} [ <color> | <interpolation> ]?"]

and Shape =
  [%value.rec
    "rect( <top> ',' <right> ',' <bottom> ',' <left> ) | rect( <top> <right> \
     <bottom> <left> )"]

and Shape_box = [%value.rec "<box> | 'margin-box'"]

and Shape_radius =
  [%value.rec
    "<extended-length> | <extended-percentage> | 'closest-side' | \
     'farthest-side'"]

and Side_or_corner = [%value.rec "[ 'left' | 'right' ] || [ 'top' | 'bottom' ]"]

and Single_animation =
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

and Single_animation_no_interp =
  [%value.rec
    "[ <keyframes-name> | 'none' ] || <extended-time-no-interp> || \
     <timing-function-no-interp> || <extended-time-no-interp> || \
     <single-animation-iteration-count-no-interp> || \
     <single-animation-direction-no-interp> || \
     <single-animation-fill-mode-no-interp> || \
     <single-animation-play-state-no-interp>"]

and Single_animation_direction =
  [%value.rec
    "'normal' | 'reverse' | 'alternate' | 'alternate-reverse' | <interpolation>"]

and Single_animation_direction_no_interp =
  [%value.rec "'normal' | 'reverse' | 'alternate' | 'alternate-reverse'"]

and Single_animation_fill_mode =
  [%value.rec "'none' | 'forwards' | 'backwards' | 'both' | <interpolation>"]

and Single_animation_fill_mode_no_interp =
  [%value.rec "'none' | 'forwards' | 'backwards' | 'both'"]

and Single_animation_iteration_count =
  [%value.rec "'infinite' | <number> | <interpolation>"]

and Single_animation_iteration_count_no_interp =
  [%value.rec "'infinite' | <number>"]

and Single_animation_play_state =
  [%value.rec "'running' | 'paused' | <interpolation>"]

and Single_animation_play_state_no_interp = [%value.rec "'running' | 'paused'"]

and Single_transition_no_interp =
  [%value.rec
    "[ <single-transition-property-no-interp> | 'none' ] || \
     <extended-time-no-interp> || <timing-function-no-interp> || \
     <extended-time-no-interp> || <transition-behavior-value-no-interp>"]

and Single_transition =
  [%value.rec
    "[<single-transition-property> | 'none']\n\
    \  | [ [<single-transition-property> | 'none'] <extended-time> ]\n\
    \  | [ [<single-transition-property> | 'none'] <extended-time> \
     <timing-function> ]\n\
    \  | [ [<single-transition-property> | 'none'] <extended-time> \
     <timing-function> <extended-time> ]\n\
    \  | [ [<single-transition-property> | 'none'] <extended-time> \
     <timing-function> <extended-time> <transition-behavior-value> ]"]

and Single_transition_property =
  [%value.rec "<custom-ident> | <interpolation> | 'all'"]

and Single_transition_property_no_interp = [%value.rec "<custom-ident> | 'all'"]

and Size =
  [%value.rec
    "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
     <extended-length> | [ <extended-length> | <extended-percentage> ]{2}"]

and Ray_size =
  [%value.rec
    "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
     'sides'"]

and Radial_size =
  [%value.rec
    "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | \
     <extended-length> | [ <extended-length> | <extended-percentage> ]{2}"]

and Step_position =
  [%value.rec
    "'jump-start' | 'jump-end' | 'jump-none' | 'jump-both' | 'start' | 'end'"]

and Step_timing_function =
  [%value.rec
    "'step-start' | 'step-end' | steps( <integer> [ ',' <step-position> ]? )"]

and Subclass_selector =
  [%value.rec
    "<id-selector> | <class-selector> | <attribute-selector> | \
     <pseudo-class-selector>"]

and Supports_condition =
  [%value.rec
    "'not' <supports-in-parens> | <supports-in-parens> [ 'and' \
     <supports-in-parens> ]* | <supports-in-parens> [ 'or' \
     <supports-in-parens> ]*"]

and Supports_decl = [%value.rec "'(' <declaration> ')'"]
and Supports_feature = [%value.rec "<supports-decl> | <supports-selector-fn>"]

and Supports_in_parens =
  [%value.rec "'(' <supports-condition> ')' | <supports-feature>"]

and Supports_selector_fn = [%value.rec "selector( <complex-selector> )"]

and Svg_length =
  [%value.rec "<extended-percentage> | <extended-length> | <number>"]

and Svg_writing_mode =
  [%value.rec "'lr-tb' | 'rl-tb' | 'tb-rl' | 'lr' | 'rl' | 'tb'"]

and Symbol = [%value.rec "<string> | <image> | <custom-ident>"]

and Symbols_type =
  [%value.rec "'cyclic' | 'numeric' | 'alphabetic' | 'symbolic' | 'fixed'"]

and Target =
  [%value.rec "<target-counter()> | <target-counters()> | <target-text()>"]

and Url = [%value.rec "<url-no-interp> | url( <interpolation> )"]

and Extended_length =
  [%value.rec "<length> | <calc()> | <interpolation> | <min()> | <max()>"]

and Length_percentage = [%value.rec "<extended-length> | <extended-percentage>"]

and Extended_frequency =
  [%value.rec "<frequency> | <calc()> | <interpolation> | <min()> | <max()>"]

and Extended_angle =
  [%value.rec "<angle> | <calc()> | <interpolation> | <min()> | <max()>"]

and Extended_time =
  [%value.rec "<time> | <calc()> | <interpolation> | <min()> | <max()>"]

and Extended_time_no_interp =
  [%value.rec "<time> | <calc()> | <min()> | <max()>"]

and Extended_percentage =
  [%value.rec "<percentage> | <calc()> | <interpolation> | <min()> | <max()> "]

and Timing_function =
  [%value.rec
    "'linear' | <cubic-bezier-timing-function> | <step-timing-function> | \
     <interpolation>"]

and Timing_function_no_interp =
  [%value.rec
    "'linear' | <cubic-bezier-timing-function> | <step-timing-function>"]

and Top = [%value.rec "<extended-length> | 'auto'"]

and Track_breadth =
  [%value.rec
    "<extended-length> | <extended-percentage> | <flex-value> | 'min-content' \
     | 'max-content' | 'auto'"]

and Track_group =
  [%value.rec
    "'(' [ [ <string> ]* <track-minmax> [ <string> ]* ]+ ')' [ '[' \
     <positive-integer> ']' ]? | <track-minmax>"]

and Track_list =
  [%value.rec
    "[ [ <line-names> ]? [ <track-size> | <track-repeat> ] ]+ [ <line-names> ]?"]

and Track_list_v0 =
  [%value.rec "[ [ <string> ]* <track-group> [ <string> ]* ]+ | 'none'"]

and Track_minmax =
  [%value.rec
    "minmax( <track-breadth> ',' <track-breadth> ) | 'auto' | <track-breadth> \
     | fit-content( <extended-length> | <extended-percentage> )"]

and Track_repeat =
  [%value.rec
    "repeat( <positive-integer> ',' [ [ <line-names> ]? <track-size> ]+ [ \
     <line-names> ]? )"]

and Track_size =
  [%value.rec
    "<track-breadth> | minmax( <inflexible-breadth> ',' <track-breadth> ) | \
     fit-content( <extended-length> | <extended-percentage> )"]

and Transform_function =
  [%value.rec
    "<matrix()> | <translate()> | <translateX()> | <translateY()> | <scale()> \
     | <scaleX()> | <scaleY()> | <rotate()> | <skew()> | <skewX()> | <skewY()> \
     | <matrix3d()> | <translate3d()> | <translateZ()> | <scale3d()> | \
     <scaleZ()> | <rotate3d()> | <rotateX()> | <rotateY()> | <rotateZ()> | \
     <perspective()>"]

and Transform_list = [%value.rec "[ <transform-function> ]+"]

and Transition_behavior_value =
  [%value.rec "'normal' | 'allow-discrete' | <interpolation>"]

and Transition_behavior_value_no_interp =
  [%value.rec "'normal' | 'allow-discrete'"]

and Type_or_unit =
  [%value.rec
    "'string' | 'color' | 'url' | 'integer' | 'number' | 'length' | 'angle' | \
     'time' | 'frequency' | 'cap' | 'ch' | 'em' | 'ex' | 'ic' | 'lh' | 'rlh' | \
     'rem' | 'vb' | 'vi' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'mm' | 'Q' | 'cm' | \
     'in' | 'pt' | 'pc' | 'px' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | 's' \
     | 'Hz' | 'kHz' | '%'"]

and Type_selector = [%value.rec "<wq-name> | [ <ns-prefix> ]? '*'"]

and Viewport_length =
  [%value.rec "'auto' | <extended-length> | <extended-percentage>"]

and Visual_box = [%value.rec "'content-box' | 'padding-box' | 'border-box'"]
and Wq_name = [%value.rec "[ <ns-prefix> ]? <ident-token>"]
and Attr_name = [%value.rec "[ <ident-token>? '|' ]? <ident-token>"]

and Attr_unit =
  [%value.rec
    "'%' | 'em' | 'ex' | 'ch' | 'rem' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'cm' | \
     'mm' | 'in' | 'px' | 'pt' | 'pc' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' \
     | 's' | 'Hz' | 'kHz'"]

and Syntax_type_name =
  [%value.rec
    "'angle' | 'color' | 'custom-ident' | 'image' | 'integer' | 'length' | \
     'length-percentage' | 'number' | 'percentage' | 'resolution' | 'string' | \
     'time' | 'url' | 'transform-function'"]

and Syntax_multiplier = [%value.rec "'#' | '+'"]

and Syntax_single_component =
  [%value.rec "'<' <syntax-type-name> '>' | <ident>"]

and Syntax_string = [%value.rec "<string>"]
and Syntax_combinator = [%value.rec "'|'"]

and Syntax_component =
  [%value.rec
    "<syntax-single-component> [ <syntax-multiplier> ]? | '<' 'transform-list' \
     '>'"]

and Syntax =
  [%value.rec
    "'*' | <syntax-component> [ <syntax-combinator> <syntax-component> ]* | \
     <syntax-string>"]

(*
 We don't support type() yet, original spec is: "type( <syntax> ) | 'raw-string' | <attr-unit>" *)
and Attr_type = [%value.rec "'raw-string' | <attr-unit>"]
and X = [%value.rec "<number>"]
and Y = [%value.rec "<number>"]

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
      let tokens = tokens |> List.map Tokens.show_token |> String.concat " " in
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

let packed_rules : (module RULE) list =
  [
value "-legacy-gradient" Legacy_gradient.parser;
value "-legacy-linear-gradient" Legacy_linear_gradient.parser;
value "-legacy-linear-gradient-arguments" Legacy_linear_gradient_arguments.parser;
value "-legacy-radial-gradient" Legacy_radial_gradient.parser;
value "-legacy-radial-gradient-arguments" Legacy_radial_gradient_arguments.parser;
value "-legacy-radial-gradient-shape" Legacy_radial_gradient_shape.parser;
value "-legacy-radial-gradient-size" Legacy_radial_gradient_size.parser;
value "-legacy-repeating-linear-gradient" Legacy_repeating_linear_gradient.parser;
value "-legacy-repeating-radial-gradient" Legacy_repeating_radial_gradient.parser;
value "-non-standard-color" Non_standard_color.parser;
value "-non-standard-font" Non_standard_font.parser;
value "-non-standard-image-rendering" Non_standard_image_rendering.parser;
value "-non-standard-overflow" Non_standard_overflow.parser;
value "-non-standard-width" Non_standard_width.parser;
value "-webkit-gradient-color-stop" Webkit_gradient_color_stop.parser;
value "-webkit-gradient-point" Webkit_gradient_point.parser;
value "-webkit-gradient-radius" Webkit_gradient_radius.parser;
value "-webkit-gradient-type" Webkit_gradient_type.parser;
value "-webkit-mask-box-repeat" Webkit_mask_box_repeat.parser;
value "-webkit-mask-clip-style" Webkit_mask_clip_style.parser;
value "absolute-size" Absolute_size.parser;
value "attr-name" Attr_name.parser;
value "attr-type" Attr_type.parser;
value "attr-unit" Attr_unit.parser;
value "syntax" Syntax.parser;
value "syntax-combinator" Syntax_combinator.parser;
value "syntax-component" Syntax_component.parser;
value "syntax-multiplier" Syntax_multiplier.parser;
value "syntax-single-component" Syntax_single_component.parser;
value "syntax-string" Syntax_string.parser;
value "syntax-type-name" Syntax_type_name.parser;
value "age" Age.parser;
value "alpha-value" Alpha_value.parser;
value "angular-color-hint" Angular_color_hint.parser;
value "angular-color-stop" Angular_color_stop.parser;
value "angular-color-stop-list" Angular_color_stop_list.parser;
value "hue-interpolation-method" Hue_interpolation_method.parser;
value "polar-color-space" Polar_color_space.parser;
value "rectangular-color-space" Rectangular_color_space.parser;
value "color-interpolation-method" Color_interpolation_method.parser;
value "animateable-feature" Animateable_feature.parser;
value "attachment" Attachment.parser;
value "attr-fallback" Attr_fallback.parser;
value "attr-matcher" Attr_matcher.parser;
value "attr-modifier" Attr_modifier.parser;
value "attr-name" Attr_name.parser;
value "attribute-selector" Attribute_selector.parser;
value "auto-repeat" Auto_repeat.parser;
value "auto-track-list" Auto_track_list.parser;
value "baseline-position" Baseline_position.parser;
value "basic-shape" Basic_shape.parser;
value "bg-image" Bg_image.parser;
value "bg-layer" Bg_layer.parser;
value "bg-position" Bg_position.parser;
value "bg-size" Bg_size.parser;
value "blend-mode" Blend_mode.parser;
value "border-radius" Border_radius.parser;
value "bottom" Bottom.parser;
value "box" Box.parser;
value "calc-product" Calc_product.parser;
value "calc-sum" Calc_sum.parser;
value "calc-value" Calc_value.parser;
value "cf-final-image" Cf_final_image.parser;
value "cf-mixing-image" Cf_mixing_image.parser;
value "class-selector" Class_selector.parser;
value "clip-source" Clip_source.parser;
value "color" Color.parser;
value "color-stop" Color_stop.parser;
value "color-stop-angle" Color_stop_angle.parser;
value "color-stop-length" Color_stop_length.parser;
value "color-stop-list" Color_stop_list.parser;
value "combinator" Combinator.parser;
value "common-lig-values" Common_lig_values.parser;
value "compat-auto" Compat_auto.parser;
value "complex-selector" Complex_selector.parser;
value "complex-selector-list" Complex_selector_list.parser;
value "composite-style" Composite_style.parser;
value "compositing-operator" Compositing_operator.parser;
value "compound-selector" Compound_selector.parser;
value "compound-selector-list" Compound_selector_list.parser;
value "content-distribution" Content_distribution.parser;
value "content-list" Content_list.parser;
value "content-position" Content_position.parser;
value "content-replacement" Content_replacement.parser;
value "contextual-alt-values" Contextual_alt_values.parser;
value "counter-style" Counter_style.parser;
value "counter-style-name" Counter_style_name.parser;
value "cubic-bezier-timing-function" Cubic_bezier_timing_function.parser;
value "declaration" Declaration.parser;
value "declaration-list" Declaration_list.parser;
value "deprecated-system-color" Deprecated_system_color.parser;
value "discretionary-lig-values" Discretionary_lig_values.parser;
value "display-box" Display_box.parser;
value "display-inside" Display_inside.parser;
value "display-internal" Display_internal.parser;
value "display-legacy" Display_legacy.parser;
value "display-listitem" Display_listitem.parser;
value "display-outside" Display_outside.parser;
value "east-asian-variant-values" East_asian_variant_values.parser;
value "east-asian-width-values" East_asian_width_values.parser;
value "ending-shape" Ending_shape.parser;
value "explicit-track-list" Explicit_track_list.parser;
value "family-name" Family_name.parser;
value "feature-tag-value" Feature_tag_value.parser;
value "feature-type" Feature_type.parser;
value "feature-value-block" Feature_value_block.parser;
value "feature-value-block-list" Feature_value_block_list.parser;
value "feature-value-declaration" Feature_value_declaration.parser;
value "feature-value-declaration-list" Feature_value_declaration_list.parser;
value "feature-value-name" Feature_value_name.parser;
value "fill-rule" Fill_rule.parser;
value "filter-function" Filter_function.parser;
value "filter-function-list" Filter_function_list.parser;
value "final-bg-layer" Final_bg_layer.parser;
value "fixed-breadth" Fixed_breadth.parser;
value "fixed-repeat" Fixed_repeat.parser;
value "fixed-size" Fixed_size.parser;
value "font-stretch-absolute" Font_stretch_absolute.parser;
value "font-variant-css21" Font_variant_css21.parser;
value "font-weight-absolute" Font_weight_absolute.parser;
fn "-webkit-gradient" Function__webkit_gradient.parser;
fn "attr" Function_attr.parser;
fn "blur" Function_blur.parser;
fn "brightness" Function_brightness.parser;
fn "calc" Function_calc.parser;
fn "circle" Function_circle.parser;
fn "clamp" Function_clamp.parser;
fn "conic-gradient" Function_conic_gradient.parser;
fn "contrast" Function_contrast.parser;
fn "counter" Function_counter.parser;
fn "counters" Function_counters.parser;
fn "cross-fade" Function_cross_fade.parser;
fn "drop-shadow" Function_drop_shadow.parser;
fn "element" Function_element.parser;
fn "ellipse" Function_ellipse.parser;
fn "env" Function_env.parser;
fn "fit-content" Function_fit_content.parser;
fn "grayscale" Function_grayscale.parser;
fn "hsl" Function_hsl.parser;
fn "hsla" Function_hsla.parser;
fn "hue-rotate" Function_hue_rotate.parser;
fn "image" Function_image.parser;
fn "image-set" Function_image_set.parser;
fn "inset" Function_inset.parser;
fn "invert" Function_invert.parser;
fn "leader" Function_leader.parser;
fn "linear-gradient" Function_linear_gradient.parser;
fn "matrix" Function_matrix.parser;
fn "matrix3d" Function_matrix3d.parser;
fn "max" Function_max.parser;
fn "min" Function_min.parser;
fn "minmax" Function_minmax.parser;
fn "opacity" Function_opacity.parser;
fn "paint" Function_paint.parser;
fn "path" Function_path.parser;
fn "perspective" Function_perspective.parser;
fn "polygon" Function_polygon.parser;
fn "radial-gradient" Function_radial_gradient.parser;
fn "repeating-linear-gradient" Function_repeating_linear_gradient.parser;
fn "repeating-radial-gradient" Function_repeating_radial_gradient.parser;
fn "rgb" Function_rgb.parser;
fn "rgba" Function_rgba.parser;
fn "rotate" Function_rotate.parser;
fn "rotate3d" Function_rotate3d.parser;
fn "rotateX" Function_rotateX.parser;
fn "rotateY" Function_rotateY.parser;
fn "rotateZ" Function_rotateZ.parser;
fn "saturate" Function_saturate.parser;
fn "scale" Function_scale.parser;
fn "scale3d" Function_scale3d.parser;
fn "scaleX" Function_scaleX.parser;
fn "scaleY" Function_scaleY.parser;
fn "scaleZ" Function_scaleZ.parser;
fn "sepia" Function_sepia.parser;
fn "skew" Function_skew.parser;
fn "skewX" Function_skewX.parser;
fn "skewY" Function_skewY.parser;
fn "symbols" Function_symbols.parser;
fn "target-counter" Function_target_counter.parser;
fn "target-counters" Function_target_counters.parser;
fn "target-text" Function_target_text.parser;
fn "translate" Function_translate.parser;
fn "translate3d" Function_translate3d.parser;
fn "translateX" Function_translateX.parser;
fn "translateY" Function_translateY.parser;
fn "translateZ" Function_translateZ.parser;
fn "var" Function_var.parser;
value "gender" Gender.parser;
value "general-enclosed" General_enclosed.parser;
value "generic-family" Generic_family.parser;
value "generic-name" Generic_name.parser;
value "generic-voice" Generic_voice.parser;
value "geometry-box" Geometry_box.parser;
value "gradient" Gradient.parser;
value "grid-line" Grid_line.parser;
value "historical-lig-values" Historical_lig_values.parser;
value "hue" Hue.parser;
value "id-selector" Id_selector.parser;
value "image" Image.parser;
value "image-set-option" Image_set_option.parser;
value "image-src" Image_src.parser;
value "image-tags" Image_tags.parser;
value "inflexible-breadth" Inflexible_breadth.parser;
value "keyframe-block" Keyframe_block.parser;
value "keyframe-block-list" Keyframe_block_list.parser;
value "keyframe-selector" Keyframe_selector.parser;
value "keyframes-name" Keyframes_name.parser;
value "leader-type" Leader_type.parser;
value "left" Left.parser;
value "line-name-list" Line_name_list.parser;
value "line-names" Line_names.parser;
value "line-style" Line_style.parser;
value "line-width" Line_width.parser;
value "linear-color-hint" Linear_color_hint.parser;
value "linear-color-stop" Linear_color_stop.parser;
value "mask-image" Mask_image.parser;
value "mask-layer" Mask_layer.parser;
value "mask-position" Mask_position.parser;
value "mask-reference" Mask_reference.parser;
value "mask-source" Mask_source.parser;
value "masking-mode" Masking_mode.parser;
mq "and" Media_and.parser;
mq "condition" Media_condition.parser;
mq "condition-without-or" Media_condition_without_or.parser;
mq "feature" Media_feature.parser;
mq "in-parens" Media_in_parens.parser;
mq "not" Media_not.parser;
mq "or" Media_or.parser;
mq "query" Media_query.parser;
mq "query-list" Media_query_list.parser;
mq "type" Media_type.parser;
value "mf-boolean" Mf_boolean.parser;
value "mf-name" Mf_name.parser;
value "mf-plain" Mf_plain.parser;
value "mf-range" Mf_range.parser;
value "mf-value" Mf_value.parser;
value "name-repeat" Name_repeat.parser;
value "named-color" Named_color.parser;
value "namespace-prefix" Namespace_prefix.parser;
value "ns-prefix" Ns_prefix.parser;
value "nth" Nth.parser;
value "number-one-or-greater" Number_one_or_greater.parser;
value "number-percentage" Number_percentage.parser;
value "alpha-value" Number_zero_one.parser;
value "numeric-figure-values" Numeric_figure_values.parser;
value "numeric-fraction-values" Numeric_fraction_values.parser;
value "numeric-spacing-values" Numeric_spacing_values.parser;
value "outline-radius" Outline_radius.parser;
value "overflow-position" Overflow_position.parser;
value "page-body" Page_body.parser;
value "page-margin-box" Page_margin_box.parser;
value "page-margin-box-type" Page_margin_box_type.parser;
value "page-selector" Page_selector.parser;
value "page-selector-list" Page_selector_list.parser;
value "paint" Paint.parser;
value "position" Position.parser;
value "positive-integer" Positive_integer.parser;
prop "-moz-appearance" Property__moz_appearance.parser;
prop "-moz-background-clip" Property__moz_background_clip.parser;
prop "-moz-binding" Property__moz_binding.parser;
prop "-moz-border-bottom-colors" Property__moz_border_bottom_colors.parser;
prop "-moz-border-left-colors" Property__moz_border_left_colors.parser;
prop "-moz-border-radius-bottomleft" Property__moz_border_radius_bottomleft.parser;
prop "-moz-border-radius-bottomright" Property__moz_border_radius_bottomright.parser;
prop "-moz-border-radius-topleft" Property__moz_border_radius_topleft.parser;
prop "-moz-border-radius-topright" Property__moz_border_radius_topright.parser;
prop "-moz-border-right-colors" Property__moz_border_right_colors.parser;
prop "-moz-border-top-colors" Property__moz_border_top_colors.parser;
prop "-moz-context-properties" Property__moz_context_properties.parser;
prop "-moz-control-character-visibility" Property__moz_control_character_visibility.parser;
prop "-moz-float-edge" Property__moz_float_edge.parser;
prop "-moz-force-broken-image-icon" Property__moz_force_broken_image_icon.parser;
prop "-moz-image-region" Property__moz_image_region.parser;
prop "-moz-orient" Property__moz_orient.parser;
prop "-moz-osx-font-smoothing" Property__moz_osx_font_smoothing.parser;
prop "-moz-outline-radius" Property__moz_outline_radius.parser;
prop "-moz-outline-radius-bottomleft" Property__moz_outline_radius_bottomleft.parser;
prop "-moz-outline-radius-bottomright" Property__moz_outline_radius_bottomright.parser;
prop "-moz-outline-radius-topleft" Property__moz_outline_radius_topleft.parser;
prop "-moz-outline-radius-topright" Property__moz_outline_radius_topright.parser;
prop "-moz-stack-sizing" Property__moz_stack_sizing.parser;
prop "-moz-text-blink" Property__moz_text_blink.parser;
prop "-moz-user-focus" Property__moz_user_focus.parser;
prop "-moz-user-input" Property__moz_user_input.parser;
prop "-moz-user-modify" Property__moz_user_modify.parser;
prop "-moz-user-select" Property__moz_user_select.parser;
prop "-moz-window-dragging" Property__moz_window_dragging.parser;
prop "-moz-window-shadow" Property__moz_window_shadow.parser;
prop "-webkit-appearance" Property__webkit_appearance.parser;
prop "-webkit-background-clip" Property__webkit_background_clip.parser;
prop "-webkit-border-before" Property__webkit_border_before.parser;
prop "-webkit-border-before-color" Property__webkit_border_before_color.parser;
prop "-webkit-border-before-style" Property__webkit_border_before_style.parser;
prop "-webkit-border-before-width" Property__webkit_border_before_width.parser;
prop "-webkit-box-reflect" Property__webkit_box_reflect.parser;
prop "-webkit-box-shadow" Property_box_shadow.parser;
prop "-webkit-box-orient" Property_box_orient.parser;
prop "-webkit-column-break-after" Property__webkit_column_break_after.parser;
prop "-webkit-column-break-before" Property__webkit_column_break_before.parser;
prop "-webkit-column-break-inside" Property__webkit_column_break_inside.parser;
prop "-webkit-font-smoothing" Property__webkit_font_smoothing.parser;
prop "-webkit-line-clamp" Property__webkit_line_clamp.parser;
prop "-webkit-mask" Property__webkit_mask.parser;
prop "-webkit-mask-attachment" Property__webkit_mask_attachment.parser;
prop "-webkit-mask-box-image" Property__webkit_mask_box_image.parser;
prop "-webkit-mask-clip" Property__webkit_mask_clip.parser;
prop "-webkit-mask-composite" Property__webkit_mask_composite.parser;
prop "-webkit-mask-image" Property__webkit_mask_image.parser;
prop "-webkit-mask-origin" Property__webkit_mask_origin.parser;
prop "-webkit-mask-position" Property__webkit_mask_position.parser;
prop "-webkit-mask-position-x" Property__webkit_mask_position_x.parser;
prop "-webkit-mask-position-y" Property__webkit_mask_position_y.parser;
prop "-webkit-mask-repeat" Property__webkit_mask_repeat.parser;
prop "-webkit-mask-repeat-x" Property__webkit_mask_repeat_x.parser;
prop "-webkit-mask-repeat-y" Property__webkit_mask_repeat_y.parser;
prop "-webkit-mask-size" Property__webkit_mask_size.parser;
prop "-webkit-overflow-scrolling" Property__webkit_overflow_scrolling.parser;
prop "-webkit-print-color-adjust" Property__webkit_print_color_adjust.parser;
prop "-webkit-tap-highlight-color" Property__webkit_tap_highlight_color.parser;
prop "-webkit-text-fill-color" Property__webkit_text_fill_color.parser;
prop "-webkit-text-security" Property__webkit_text_security.parser;
prop "-webkit-text-stroke" Property__webkit_text_stroke.parser;
prop "-webkit-text-stroke-color" Property__webkit_text_stroke_color.parser;
prop "-webkit-text-stroke-width" Property__webkit_text_stroke_width.parser;
prop "-webkit-touch-callout" Property__webkit_touch_callout.parser;
prop "-webkit-user-drag" Property__webkit_user_drag.parser;
prop "-webkit-user-modify" Property__webkit_user_modify.parser;
prop "-webkit-user-select" Property__webkit_user_select.parser;
prop "align-content" Property_align_content.parser;
prop "align-items" Property_align_items.parser;
prop "align-self" Property_align_self.parser;
prop "alignment-baseline" Property_alignment_baseline.parser;
prop "all" Property_all.parser;
prop "animation" Property_animation.parser;
prop "animation-delay" Property_animation_delay.parser;
prop "animation-direction" Property_animation_direction.parser;
prop "animation-duration" Property_animation_duration.parser;
prop "animation-fill-mode" Property_animation_fill_mode.parser;
prop "animation-iteration-count" Property_animation_iteration_count.parser;
prop "animation-name" Property_animation_name.parser;
prop "animation-play-state" Property_animation_play_state.parser;
prop "animation-timing-function" Property_animation_timing_function.parser;
prop "appearance" Property_appearance.parser;
prop "aspect-ratio" Property_aspect_ratio.parser;
prop "azimuth" Property_azimuth.parser;
prop "backdrop-filter" Property_backdrop_filter.parser;
prop "backface-visibility" Property_backface_visibility.parser;
prop "background" Property_background.parser;
prop "background-attachment" Property_background_attachment.parser;
prop "background-blend-mode" Property_background_blend_mode.parser;
prop "background-clip" Property_background_clip.parser;
prop "background-color" Property_background_color.parser;
prop "background-image" Property_background_image.parser;
prop "background-origin" Property_background_origin.parser;
prop "background-position" Property_background_position.parser;
prop "background-position-x" Property_background_position_x.parser;
prop "background-position-y" Property_background_position_y.parser;
prop "background-repeat" Property_background_repeat.parser;
prop "background-size" Property_background_size.parser;
prop "baseline-shift" Property_baseline_shift.parser;
prop "behavior" Property_behavior.parser;
prop "block-overflow" Property_block_overflow.parser;
prop "block-size" Property_block_size.parser;
prop "border" Property_border.parser;
prop "border-block" Property_border_block.parser;
prop "border-block-color" Property_border_block_color.parser;
prop "border-block-end" Property_border_block_end.parser;
prop "border-block-end-color" Property_border_block_end_color.parser;
prop "border-block-end-style" Property_border_block_end_style.parser;
prop "border-block-end-width" Property_border_block_end_width.parser;
prop "border-block-start" Property_border_block_start.parser;
prop "border-block-start-color" Property_border_block_start_color.parser;
prop "border-block-start-style" Property_border_block_start_style.parser;
prop "border-block-start-width" Property_border_block_start_width.parser;
prop "border-block-style" Property_border_block_style.parser;
prop "border-block-width" Property_border_block_width.parser;
prop "border-bottom" Property_border_bottom.parser;
prop "border-bottom-color" Property_border_bottom_color.parser;
prop "border-bottom-left-radius" Property_border_bottom_left_radius.parser;
prop "border-bottom-right-radius" Property_border_bottom_right_radius.parser;
prop "border-bottom-style" Property_border_bottom_style.parser;
prop "border-bottom-width" Property_border_bottom_width.parser;
prop "border-collapse" Property_border_collapse.parser;
prop "border-color" Property_border_color.parser;
prop "border-end-end-radius" Property_border_end_end_radius.parser;
prop "border-end-start-radius" Property_border_end_start_radius.parser;
prop "border-image" Property_border_image.parser;
prop "border-image-outset" Property_border_image_outset.parser;
prop "border-image-repeat" Property_border_image_repeat.parser;
prop "border-image-slice" Property_border_image_slice.parser;
prop "border-image-source" Property_border_image_source.parser;
prop "border-image-width" Property_border_image_width.parser;
prop "border-inline" Property_border_inline.parser;
prop "border-inline-color" Property_border_inline_color.parser;
prop "border-inline-end" Property_border_inline_end.parser;
prop "border-inline-end-color" Property_border_inline_end_color.parser;
prop "border-inline-end-style" Property_border_inline_end_style.parser;
prop "border-inline-end-width" Property_border_inline_end_width.parser;
prop "border-inline-start" Property_border_inline_start.parser;
prop "border-inline-start-color" Property_border_inline_start_color.parser;
prop "border-inline-start-style" Property_border_inline_start_style.parser;
prop "border-inline-start-width" Property_border_inline_start_width.parser;
prop "border-inline-style" Property_border_inline_style.parser;
prop "border-inline-width" Property_border_inline_width.parser;
prop "border-left" Property_border_left.parser;
prop "border-left-color" Property_border_left_color.parser;
prop "border-left-style" Property_border_left_style.parser;
prop "border-left-width" Property_border_left_width.parser;
prop "border-radius" Property_border_radius.parser;
prop "border-right" Property_border_right.parser;
prop "border-right-color" Property_border_right_color.parser;
prop "border-right-style" Property_border_right_style.parser;
prop "border-right-width" Property_border_right_width.parser;
prop "border-spacing" Property_border_spacing.parser;
prop "border-start-end-radius" Property_border_start_end_radius.parser;
prop "border-start-start-radius" Property_border_start_start_radius.parser;
prop "border-style" Property_border_style.parser;
prop "border-top" Property_border_top.parser;
prop "border-top-color" Property_border_top_color.parser;
prop "border-top-left-radius" Property_border_top_left_radius.parser;
prop "border-top-right-radius" Property_border_top_right_radius.parser;
prop "border-top-style" Property_border_top_style.parser;
prop "border-top-width" Property_border_top_width.parser;
prop "border-width" Property_border_width.parser;
prop "bottom" Property_bottom.parser;
prop "box-align" Property_box_align.parser;
prop "box-decoration-break" Property_box_decoration_break.parser;
prop "box-direction" Property_box_direction.parser;
prop "box-flex" Property_box_flex.parser;
prop "box-flex-group" Property_box_flex_group.parser;
prop "box-lines" Property_box_lines.parser;
prop "box-ordinal-group" Property_box_ordinal_group.parser;
prop "box-orient" Property_box_orient.parser;
prop "box-pack" Property_box_pack.parser;
prop "box-shadow" Property_box_shadow.parser;
prop "box-sizing" Property_box_sizing.parser;
prop "break-after" Property_break_after.parser;
prop "break-before" Property_break_before.parser;
prop "break-inside" Property_break_inside.parser;
prop "caption-side" Property_caption_side.parser;
prop "caret-color" Property_caret_color.parser;
prop "clear" Property_clear.parser;
prop "clip" Property_clip.parser;
prop "clip-path" Property_clip_path.parser;
prop "clip-rule" Property_clip_rule.parser;
prop "color" Property_color.parser;
prop "color-adjust" Property_color_adjust.parser;
prop "color-scheme" Property_color_scheme.parser;
prop "column-count" Property_column_count.parser;
prop "column-fill" Property_column_fill.parser;
prop "column-gap" Property_column_gap.parser;
prop "column-rule" Property_column_rule.parser;
prop "column-rule-color" Property_column_rule_color.parser;
prop "column-rule-style" Property_column_rule_style.parser;
prop "column-rule-width" Property_column_rule_width.parser;
prop "column-span" Property_column_span.parser;
prop "column-width" Property_column_width.parser;
prop "columns" Property_columns.parser;
prop "contain" Property_contain.parser;
prop "content" Property_content.parser;
prop "counter-increment" Property_counter_increment.parser;
prop "counter-reset" Property_counter_reset.parser;
prop "counter-set" Property_counter_set.parser;
prop "cue" Property_cue.parser;
prop "cue-after" Property_cue_after.parser;
prop "cue-before" Property_cue_before.parser;
prop "cursor" Property_cursor.parser;
prop "direction" Property_direction.parser;
prop "display" Property_display.parser;
prop "dominant-baseline" Property_dominant_baseline.parser;
prop "empty-cells" Property_empty_cells.parser;
prop "fill" Property_fill.parser;
prop "fill-opacity" Property_fill_opacity.parser;
prop "fill-rule" Property_fill_rule.parser;
prop "filter" Property_filter.parser;
prop "flex" Property_flex.parser;
prop "flex-basis" Property_flex_basis.parser;
prop "flex-direction" Property_flex_direction.parser;
prop "flex-flow" Property_flex_flow.parser;
prop "flex-grow" Property_flex_grow.parser;
prop "flex-shrink" Property_flex_shrink.parser;
prop "flex-wrap" Property_flex_wrap.parser;
prop "float" Property_float.parser;
prop "font" Property_font.parser;
prop "font-family" Property_font_family.parser;
prop "font-feature-settings" Property_font_feature_settings.parser;
prop "font-kerning" Property_font_kerning.parser;
prop "font-language-override" Property_font_language_override.parser;
prop "font-optical-sizing" Property_font_optical_sizing.parser;
prop "font-palette" Property_font_palette.parser;
prop "font-variant-emoji" Property_font_variant_emoji.parser;
prop "font-size" Property_font_size.parser;
prop "font-size-adjust" Property_font_size_adjust.parser;
prop "font-smooth" Property_font_smooth.parser;
prop "font-stretch" Property_font_stretch.parser;
prop "font-style" Property_font_style.parser;
prop "font-synthesis" Property_font_synthesis.parser;
prop "font-synthesis-weight" Property_font_synthesis_weight.parser;
prop "font-synthesis-style" Property_font_synthesis_style.parser;
prop "font-synthesis-small-caps" Property_font_synthesis_small_caps.parser;
prop "font-synthesis-position" Property_font_synthesis_position.parser;
prop "font-variant" Property_font_variant.parser;
prop "font-variant-alternates" Property_font_variant_alternates.parser;
prop "font-variant-caps" Property_font_variant_caps.parser;
prop "font-variant-east-asian" Property_font_variant_east_asian.parser;
prop "font-variant-ligatures" Property_font_variant_ligatures.parser;
prop "font-variant-numeric" Property_font_variant_numeric.parser;
prop "font-variant-position" Property_font_variant_position.parser;
prop "font-variation-settings" Property_font_variation_settings.parser;
prop "font-weight" Property_font_weight.parser;
prop "gap" Property_gap.parser;
prop "glyph-orientation-horizontal" Property_glyph_orientation_horizontal.parser;
prop "glyph-orientation-vertical" Property_glyph_orientation_vertical.parser;
prop "grid" Property_grid.parser;
prop "grid-area" Property_grid_area.parser;
prop "grid-auto-columns" Property_grid_auto_columns.parser;
prop "grid-auto-flow" Property_grid_auto_flow.parser;
prop "grid-auto-rows" Property_grid_auto_rows.parser;
prop "grid-column" Property_grid_column.parser;
prop "grid-column-end" Property_grid_column_end.parser;
prop "grid-column-gap" Property_grid_column_gap.parser;
prop "grid-column-start" Property_grid_column_start.parser;
prop "grid-gap" Property_grid_gap.parser;
prop "grid-row" Property_grid_row.parser;
prop "grid-row-end" Property_grid_row_end.parser;
prop "grid-row-gap" Property_grid_row_gap.parser;
prop "grid-row-start" Property_grid_row_start.parser;
prop "grid-template" Property_grid_template.parser;
prop "grid-template-areas" Property_grid_template_areas.parser;
prop "grid-template-columns" Property_grid_template_columns.parser;
prop "grid-template-rows" Property_grid_template_rows.parser;
prop "hanging-punctuation" Property_hanging_punctuation.parser;
prop "height" Property_height.parser;
prop "hyphens" Property_hyphens.parser;
prop "image-orientation" Property_image_orientation.parser;
prop "image-rendering" Property_image_rendering.parser;
prop "image-resolution" Property_image_resolution.parser;
prop "ime-mode" Property_ime_mode.parser;
prop "initial-letter" Property_initial_letter.parser;
prop "initial-letter-align" Property_initial_letter_align.parser;
prop "inline-size" Property_inline_size.parser;
prop "inset" Property_inset.parser;
prop "inset-block" Property_inset_block.parser;
prop "inset-block-end" Property_inset_block_end.parser;
prop "inset-block-start" Property_inset_block_start.parser;
prop "inset-inline" Property_inset_inline.parser;
prop "inset-inline-end" Property_inset_inline_end.parser;
prop "inset-inline-start" Property_inset_inline_start.parser;
prop "isolation" Property_isolation.parser;
prop "justify-content" Property_justify_content.parser;
prop "justify-items" Property_justify_items.parser;
prop "justify-self" Property_justify_self.parser;
prop "kerning" Property_kerning.parser;
prop "left" Property_left.parser;
prop "letter-spacing" Property_letter_spacing.parser;
prop "line-break" Property_line_break.parser;
prop "line-clamp" Property_line_clamp.parser;
prop "line-height" Property_line_height.parser;
prop "line-height-step" Property_line_height_step.parser;
prop "list-style" Property_list_style.parser;
prop "list-style-image" Property_list_style_image.parser;
prop "list-style-position" Property_list_style_position.parser;
prop "list-style-type" Property_list_style_type.parser;
prop "margin" Property_margin.parser;
prop "margin-block" Property_margin_block.parser;
prop "margin-block-end" Property_margin_block_end.parser;
prop "margin-block-start" Property_margin_block_start.parser;
prop "margin-bottom" Property_margin_bottom.parser;
prop "margin-inline" Property_margin_inline.parser;
prop "margin-inline-end" Property_margin_inline_end.parser;
prop "margin-inline-start" Property_margin_inline_start.parser;
prop "margin-left" Property_margin_left.parser;
prop "margin-right" Property_margin_right.parser;
prop "margin-top" Property_margin_top.parser;
prop "margin-trim" Property_margin_trim.parser;
prop "marker" Property_marker.parser;
prop "marker-end" Property_marker_end.parser;
prop "marker-mid" Property_marker_mid.parser;
prop "marker-start" Property_marker_start.parser;
prop "mask" Property_mask.parser;
prop "mask-border" Property_mask_border.parser;
prop "mask-border-mode" Property_mask_border_mode.parser;
prop "mask-border-outset" Property_mask_border_outset.parser;
prop "mask-border-repeat" Property_mask_border_repeat.parser;
prop "mask-border-slice" Property_mask_border_slice.parser;
prop "mask-border-source" Property_mask_border_source.parser;
prop "mask-border-width" Property_mask_border_width.parser;
prop "mask-clip" Property_mask_clip.parser;
prop "mask-composite" Property_mask_composite.parser;
prop "mask-image" Property_mask_image.parser;
prop "mask-mode" Property_mask_mode.parser;
prop "mask-origin" Property_mask_origin.parser;
prop "mask-position" Property_mask_position.parser;
prop "mask-repeat" Property_mask_repeat.parser;
prop "mask-size" Property_mask_size.parser;
prop "mask-type" Property_mask_type.parser;
prop "masonry-auto-flow" Property_masonry_auto_flow.parser;
prop "max-block-size" Property_max_block_size.parser;
prop "max-height" Property_max_height.parser;
prop "max-inline-size" Property_max_inline_size.parser;
prop "max-lines" Property_max_lines.parser;
prop "max-width" Property_max_width.parser;
prop "min-block-size" Property_min_block_size.parser;
prop "min-height" Property_min_height.parser;
prop "min-inline-size" Property_min_inline_size.parser;
prop "min-width" Property_min_width.parser;
prop "mix-blend-mode" Property_mix_blend_mode.parser;
prop "object-fit" Property_object_fit.parser;
prop "object-position" Property_object_position.parser;
prop "offset" Property_offset.parser;
prop "offset-anchor" Property_offset_anchor.parser;
prop "offset-distance" Property_offset_distance.parser;
prop "offset-path" Property_offset_path.parser;
prop "offset-position" Property_offset_position.parser;
prop "offset-rotate" Property_offset_rotate.parser;
prop "opacity" Property_opacity.parser;
prop "order" Property_order.parser;
prop "orphans" Property_orphans.parser;
prop "outline" Property_outline.parser;
prop "outline-color" Property_outline_color.parser;
prop "outline-offset" Property_outline_offset.parser;
prop "outline-style" Property_outline_style.parser;
prop "outline-width" Property_outline_width.parser;
prop "overflow" Property_overflow.parser;
prop "overflow-anchor" Property_overflow_anchor.parser;
prop "overflow-block" Property_overflow_block.parser;
prop "overflow-clip-margin" Property_overflow_clip_margin.parser;
prop "overflow-inline" Property_overflow_inline.parser;
prop "overflow-wrap" Property_overflow_wrap.parser;
prop "overflow-x" Property_overflow_x.parser;
prop "overflow-y" Property_overflow_y.parser;
prop "overscroll-behavior" Property_overscroll_behavior.parser;
prop "overscroll-behavior-block" Property_overscroll_behavior_block.parser;
prop "overscroll-behavior-inline" Property_overscroll_behavior_inline.parser;
prop "overscroll-behavior-x" Property_overscroll_behavior_x.parser;
prop "overscroll-behavior-y" Property_overscroll_behavior_y.parser;
prop "any-hover" Property_media_any_hover.parser;
prop "any-pointer" Property_media_any_pointer.parser;
prop "pointer" Property_media_pointer.parser;
prop "max-aspect-ratio" Property_media_max_aspect_ratio.parser;
prop "min-aspect-ratio" Property_media_min_aspect_ratio.parser;
prop "min-color" Property_media_min_color.parser;
prop "color-gamut" Property_media_color_gamut.parser;
prop "color-index" Property_media_color_index.parser;
prop "min-color-index" Property_media_min_color_index.parser;
prop "display-mode" Property_media_display_mode.parser;
prop "forced-colors" Property_media_forced_colors.parser;
prop "forced-color-adjust" Property_forced_color_adjust.parser;
prop "grid" Property_media_grid.parser;
prop "hover" Property_media_hover.parser;
prop "inverted-colors" Property_media_inverted_colors.parser;
prop "monochrome" Property_media_monochrome.parser;
prop "prefers-color-scheme" Property_media_prefers_color_scheme.parser;
prop "prefers-contrast" Property_media_prefers_contrast.parser;
prop "prefers-reduced-motion" Property_media_prefers_reduced_motion.parser;
prop "resolution" Property_media_resolution.parser;
prop "min-resolution" Property_media_min_resolution.parser;
prop "max-resolution" Property_media_max_resolution.parser;
prop "scripting" Property_media_scripting.parser;
prop "update" Property_media_update.parser;
prop "orientation" Property_media_orientation.parser;
prop "padding" Property_padding.parser;
prop "padding-block" Property_padding_block.parser;
prop "padding-block-end" Property_padding_block_end.parser;
prop "padding-block-start" Property_padding_block_start.parser;
prop "padding-bottom" Property_padding_bottom.parser;
prop "padding-inline" Property_padding_inline.parser;
prop "padding-inline-end" Property_padding_inline_end.parser;
prop "padding-inline-start" Property_padding_inline_start.parser;
prop "padding-left" Property_padding_left.parser;
prop "padding-right" Property_padding_right.parser;
prop "padding-top" Property_padding_top.parser;
prop "page-break-after" Property_page_break_after.parser;
prop "page-break-before" Property_page_break_before.parser;
prop "page-break-inside" Property_page_break_inside.parser;
prop "paint-order" Property_paint_order.parser;
prop "pause" Property_pause.parser;
prop "pause-after" Property_pause_after.parser;
prop "pause-before" Property_pause_before.parser;
prop "perspective" Property_perspective.parser;
prop "perspective-origin" Property_perspective_origin.parser;
prop "place-content" Property_place_content.parser;
prop "place-items" Property_place_items.parser;
prop "place-self" Property_place_self.parser;
prop "pointer-events" Property_pointer_events.parser;
prop "position" Property_position.parser;
prop "quotes" Property_quotes.parser;
prop "resize" Property_resize.parser;
prop "rest" Property_rest.parser;
prop "rest-after" Property_rest_after.parser;
prop "rest-before" Property_rest_before.parser;
prop "right" Property_right.parser;
prop "rotate" Property_rotate.parser;
prop "row-gap" Property_row_gap.parser;
prop "ruby-align" Property_ruby_align.parser;
prop "ruby-merge" Property_ruby_merge.parser;
prop "ruby-position" Property_ruby_position.parser;
prop "scale" Property_scale.parser;
prop "scroll-behavior" Property_scroll_behavior.parser;
prop "scroll-margin" Property_scroll_margin.parser;
prop "scroll-margin-block" Property_scroll_margin_block.parser;
prop "scroll-margin-block-end" Property_scroll_margin_block_end.parser;
prop "scroll-margin-block-start" Property_scroll_margin_block_start.parser;
prop "scroll-margin-bottom" Property_scroll_margin_bottom.parser;
prop "scroll-margin-inline" Property_scroll_margin_inline.parser;
prop "scroll-margin-inline-end" Property_scroll_margin_inline_end.parser;
prop "scroll-margin-inline-start" Property_scroll_margin_inline_start.parser;
prop "scroll-margin-left" Property_scroll_margin_left.parser;
prop "scroll-margin-right" Property_scroll_margin_right.parser;
prop "scroll-margin-top" Property_scroll_margin_top.parser;
prop "scroll-padding" Property_scroll_padding.parser;
prop "scroll-padding-block" Property_scroll_padding_block.parser;
prop "scroll-padding-block-end" Property_scroll_padding_block_end.parser;
prop "scroll-padding-block-start" Property_scroll_padding_block_start.parser;
prop "scroll-padding-bottom" Property_scroll_padding_bottom.parser;
prop "scroll-padding-inline" Property_scroll_padding_inline.parser;
prop "scroll-padding-inline-end" Property_scroll_padding_inline_end.parser;
prop "scroll-padding-inline-start" Property_scroll_padding_inline_start.parser;
prop "scroll-padding-left" Property_scroll_padding_left.parser;
prop "scroll-padding-right" Property_scroll_padding_right.parser;
prop "scroll-padding-top" Property_scroll_padding_top.parser;
prop "scroll-snap-align" Property_scroll_snap_align.parser;
prop "scroll-snap-coordinate" Property_scroll_snap_coordinate.parser;
prop "scroll-snap-destination" Property_scroll_snap_destination.parser;
prop "scroll-snap-points-x" Property_scroll_snap_points_x.parser;
prop "scroll-snap-points-y" Property_scroll_snap_points_y.parser;
prop "scroll-snap-stop" Property_scroll_snap_stop.parser;
prop "scroll-snap-type" Property_scroll_snap_type.parser;
prop "scroll-snap-type-x" Property_scroll_snap_type_x.parser;
prop "scroll-snap-type-y" Property_scroll_snap_type_y.parser;
prop "scrollbar-color" Property_scrollbar_color.parser;
prop "scrollbar-width" Property_scrollbar_width.parser;
prop "scrollbar-gutter" Property_scrollbar_gutter.parser;
prop "shape-image-threshold" Property_shape_image_threshold.parser;
prop "shape-margin" Property_shape_margin.parser;
prop "shape-outside" Property_shape_outside.parser;
prop "shape-rendering" Property_shape_rendering.parser;
prop "speak" Property_speak.parser;
prop "speak-as" Property_speak_as.parser;
prop "src" Property_src.parser;
prop "stroke" Property_stroke.parser;
prop "stroke-dasharray" Property_stroke_dasharray.parser;
prop "stroke-dashoffset" Property_stroke_dashoffset.parser;
prop "stroke-linecap" Property_stroke_linecap.parser;
prop "stroke-linejoin" Property_stroke_linejoin.parser;
prop "stroke-miterlimit" Property_stroke_miterlimit.parser;
prop "stroke-opacity" Property_stroke_opacity.parser;
prop "stroke-width" Property_stroke_width.parser;
prop "tab-size" Property_tab_size.parser;
prop "table-layout" Property_table_layout.parser;
prop "text-align" Property_text_align.parser;
prop "text-align-all" Property_text_align_all.parser;
prop "text-align-last" Property_text_align_last.parser;
prop "text-anchor" Property_text_anchor.parser;
prop "text-combine-upright" Property_text_combine_upright.parser;
prop "text-decoration" Property_text_decoration.parser;
prop "text-decoration-color" Property_text_decoration_color.parser;
prop "text-decoration-line" Property_text_decoration_line.parser;
prop "text-decoration-skip" Property_text_decoration_skip.parser;
prop "text-decoration-skip-ink" Property_text_decoration_skip_ink.parser;
prop "text-decoration-skip-box" Property_text_decoration_skip_box.parser;
prop "text-decoration-skip-inset" Property_text_decoration_skip_inset.parser;
prop "text-decoration-style" Property_text_decoration_style.parser;
prop "text-decoration-thickness" Property_text_decoration_thickness.parser;
prop "text-emphasis" Property_text_emphasis.parser;
prop "text-emphasis-color" Property_text_emphasis_color.parser;
prop "text-emphasis-position" Property_text_emphasis_position.parser;
prop "text-emphasis-style" Property_text_emphasis_style.parser;
prop "text-indent" Property_text_indent.parser;
prop "text-justify" Property_text_justify.parser;
prop "text-orientation" Property_text_orientation.parser;
prop "text-overflow" Property_text_overflow.parser;
prop "text-rendering" Property_text_rendering.parser;
prop "text-shadow" Property_text_shadow.parser;
prop "text-size-adjust" Property_text_size_adjust.parser;
prop "text-transform" Property_text_transform.parser;
prop "text-underline-offset" Property_text_underline_offset.parser;
prop "text-underline-position" Property_text_underline_position.parser;
prop "top" Property_top.parser;
prop "touch-action" Property_touch_action.parser;
prop "transform" Property_transform.parser;
prop "transform-box" Property_transform_box.parser;
prop "transform-origin" Property_transform_origin.parser;
prop "transform-style" Property_transform_style.parser;
prop "transition" Property_transition.parser;
prop "transition-behavior" Property_transition_behavior.parser;
prop "transition-delay" Property_transition_delay.parser;
prop "transition-duration" Property_transition_duration.parser;
prop "transition-property" Property_transition_property.parser;
prop "transition-timing-function" Property_transition_timing_function.parser;
prop "translate" Property_translate.parser;
prop "unicode-bidi" Property_unicode_bidi.parser;
prop "unicode-range" Property_unicode_range.parser;
prop "user-select" Property_user_select.parser;
prop "vertical-align" Property_vertical_align.parser;
prop "visibility" Property_visibility.parser;
prop "voice-balance" Property_voice_balance.parser;
prop "voice-duration" Property_voice_duration.parser;
prop "voice-family" Property_voice_family.parser;
prop "voice-pitch" Property_voice_pitch.parser;
prop "voice-range" Property_voice_range.parser;
prop "voice-rate" Property_voice_rate.parser;
prop "voice-stress" Property_voice_stress.parser;
prop "voice-volume" Property_voice_volume.parser;
prop "white-space" Property_white_space.parser;
prop "widows" Property_widows.parser;
prop "width" Property_width.parser;
prop "will-change" Property_will_change.parser;
prop "word-break" Property_word_break.parser;
prop "word-spacing" Property_word_spacing.parser;
prop "word-wrap" Property_word_wrap.parser;
prop "writing-mode" Property_writing_mode.parser;
prop "z-index" Property_z_index.parser;
prop "zoom" Property_zoom.parser;
prop "container" Property_container.parser;
prop "container-name" Property_container_name.parser;
prop "container-type" Property_container_type.parser;
value "pseudo-class-selector" Pseudo_class_selector.parser;
value "pseudo-element-selector" Pseudo_element_selector.parser;
value "pseudo-page" Pseudo_page.parser;
value "quote" Quote.parser;
value "ratio" Ratio.parser;
value "relative-selector" Relative_selector.parser;
value "relative-selector-list" Relative_selector_list.parser;
value "relative-size" Relative_size.parser;
value "repeat-style" Repeat_style.parser;
value "right" Right.parser;
value "self-position" Self_position.parser;
value "shadow" Shadow.parser;
value "shadow-t" Shadow_t.parser;
value "shape" Shape.parser;
value "shape-box" Shape_box.parser;
value "shape-radius" Shape_radius.parser;
value "side-or-corner" Side_or_corner.parser;
value "single-animation" Single_animation.parser;
value "font-families" Font_families.parser;
value "single-animation-direction" Single_animation_direction.parser;
value "single-animation-fill-mode" Single_animation_fill_mode.parser;
value "single-animation-iteration-count" Single_animation_iteration_count.parser;
value "single-animation-play-state" Single_animation_play_state.parser;
value "single-transition" Single_transition.parser;
value "single-transition-property" Single_transition_property.parser;
value "size" Size.parser;
value "ray-size" Ray_size.parser;
value "radial-size" Radial_size.parser;
value "step-position" Step_position.parser;
value "step-timing-function" Step_timing_function.parser;
value "subclass-selector" Subclass_selector.parser;
value "supports-condition" Supports_condition.parser;
value "supports-decl" Supports_decl.parser;
value "supports-feature" Supports_feature.parser;
value "supports-in-parens" Supports_in_parens.parser;
value "supports-selector-fn" Supports_selector_fn.parser;
value "svg-length" Svg_length.parser;
value "svg-writing-mode" Svg_writing_mode.parser;
value "symbol" Symbol.parser;
value "symbols-type" Symbols_type.parser;
value "target" Target.parser;
value "timing-function" Timing_function.parser;
value "top" Top.parser;
value "track-breadth" Track_breadth.parser;
value "track-group" Track_group.parser;
value "track-list" Track_list.parser;
value "track-list-v0" Track_list_v0.parser;
value "track-minmax" Track_minmax.parser;
value "track-repeat" Track_repeat.parser;
value "track-size" Track_size.parser;
value "transform-function" Transform_function.parser;
value "transform-list" Transform_list.parser;
value "type-or-unit" Type_or_unit.parser;
value "type-selector" Type_selector.parser;
value "viewport-length" Viewport_length.parser;
value "wq-name" Wq_name.parser;
value "x" X.parser;
value "y" Y.parser;
    (* TODO: calc needs to be available in length *)
value "extended-length" Extended_length.parser;
value "extended-frequency" Extended_frequency.parser;
value "extended-angle" Extended_angle.parser;
value "extended-time" Extended_time.parser;
value "extended-percentage" Extended_percentage.parser;
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
