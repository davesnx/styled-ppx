open Standard;
open Combinator;
open Modifier;
open Rule.Match;
open Parser_helper;

let rec _legacy_gradient = [%value.rec "<-webkit-gradient()> | <-legacy-linear-gradient> | <-legacy-repeating-linear-gradient> | <-legacy-radial-gradient> | <-legacy-repeating-radial-gradient>"]
and _legacy_linear_gradient = [%value.rec "-moz-linear-gradient( <-legacy-linear-gradient-arguments> ) | -webkit-linear-gradient( <-legacy-linear-gradient-arguments> ) | -o-linear-gradient( <-legacy-linear-gradient-arguments> )"]
and _legacy_linear_gradient_arguments = [%value.rec "[ <extended-angle> | <side-or-corner> ]? ',' <color-stop-list>"]
and _legacy_radial_gradient = [%value.rec "-moz-radial-gradient( <-legacy-radial-gradient-arguments> ) | -webkit-radial-gradient( <-legacy-radial-gradient-arguments> ) | -o-radial-gradient( <-legacy-radial-gradient-arguments> )"]
and _legacy_radial_gradient_arguments = [%value.rec "[ <position> ',' ]? [ [ <-legacy-radial-gradient-shape> || <-legacy-radial-gradient-size> | [ <extended-length> | <extended-percentage> ]{2} ] ',' ]? <color-stop-list>"]
and _legacy_radial_gradient_shape = [%value.rec "'circle' | 'ellipse'"]
and _legacy_radial_gradient_size = [%value.rec "'closest-side' | 'closest-corner' | 'farthest-side' | 'farthest-corner' | 'contain' | 'cover'"]
and _legacy_repeating_linear_gradient = [%value.rec "-moz-repeating-linear-gradient( <-legacy-linear-gradient-arguments> ) | -webkit-repeating-linear-gradient( <-legacy-linear-gradient-arguments> ) | -o-repeating-linear-gradient( <-legacy-linear-gradient-arguments> )"]
and _legacy_repeating_radial_gradient = [%value.rec "-moz-repeating-radial-gradient( <-legacy-radial-gradient-arguments> ) | -webkit-repeating-radial-gradient( <-legacy-radial-gradient-arguments> ) | -o-repeating-radial-gradient( <-legacy-radial-gradient-arguments> )"]
and _ms_filter = [%value.rec "<string>"]
and _ms_filter_function = [%value.rec "<-ms-filter-function-progid> | <-ms-filter-function-legacy>"]
and _ms_filter_function_legacy = [%value.rec "<ident-token> | <function-token> [ <any-value> ]? ')'"]
and _ms_filter_function_list = [%value.rec "[ <-ms-filter-function> ]+"]
and _ms_filter_function_progid = [%value.rec "'progid:' [ <ident-token> '.' ]* [ <ident-token> | <function-token> [ <any-value> ]? ')' ]"]
and _non_standard_color = [%value.rec "'-moz-ButtonDefault' | '-moz-ButtonHoverFace' | '-moz-ButtonHoverText' | '-moz-CellHighlight' | '-moz-CellHighlightText' | '-moz-Combobox' | '-moz-ComboboxText' | '-moz-Dialog' | '-moz-DialogText' | '-moz-dragtargetzone' | '-moz-EvenTreeRow' | '-moz-Field' | '-moz-FieldText' | '-moz-html-CellHighlight' | '-moz-html-CellHighlightText' | '-moz-mac-accentdarkestshadow' | '-moz-mac-accentdarkshadow' | '-moz-mac-accentface' | '-moz-mac-accentlightesthighlight' | '-moz-mac-accentlightshadow' | '-moz-mac-accentregularhighlight' | '-moz-mac-accentregularshadow' | '-moz-mac-chrome-active' | '-moz-mac-chrome-inactive' | '-moz-mac-focusring' | '-moz-mac-menuselect' | '-moz-mac-menushadow' | '-moz-mac-menutextselect' | '-moz-MenuHover' | '-moz-MenuHoverText' | '-moz-MenuBarText' | '-moz-MenuBarHoverText' | '-moz-nativehyperlinktext' | '-moz-OddTreeRow' | '-moz-win-communicationstext' | '-moz-win-mediatext' | '-moz-activehyperlinktext' | '-moz-default-background-color' | '-moz-default-color' | '-moz-hyperlinktext' | '-moz-visitedhyperlinktext' | '-webkit-activelink' | '-webkit-focus-ring-color' | '-webkit-link' | '-webkit-text'"]
and _non_standard_font = [%value.rec "'-apple-system-body' | '-apple-system-headline' | '-apple-system-subheadline' | '-apple-system-caption1' | '-apple-system-caption2' | '-apple-system-footnote' | '-apple-system-short-body' | '-apple-system-short-headline' | '-apple-system-short-subheadline' | '-apple-system-short-caption1' | '-apple-system-short-footnote' | '-apple-system-tall-body'"]
and _non_standard_image_rendering = [%value.rec "'optimize-contrast' | '-moz-crisp-edges' | '-o-crisp-edges' | '-webkit-optimize-contrast'"]
and _non_standard_overflow = [%value.rec "'-moz-scrollbars-none' | '-moz-scrollbars-horizontal' | '-moz-scrollbars-vertical' | '-moz-hidden-unscrollable'"]
and _non_standard_width = [%value.rec "'min-intrinsic' | 'intrinsic' | '-moz-min-content' | '-moz-max-content' | '-webkit-min-content' | '-webkit-max-content'"]
and _webkit_gradient_color_stop = [%value.rec "from( <color> ) | color-stop( [ <alpha-value> | <extended-percentage> ] ',' <color> ) | to( <color> )"]
and _webkit_gradient_point = [%value.rec "[ 'left' | 'center' | 'right' | <extended-length> | <extended-percentage> ] [ 'top' | 'center' | 'bottom' | <extended-length> | <extended-percentage> ]"]
and _webkit_gradient_radius = [%value.rec "<extended-length> | <extended-percentage>"]
and _webkit_gradient_type = [%value.rec "'linear' | 'radial'"]
and _webkit_mask_box_repeat = [%value.rec "'repeat' | 'stretch' | 'round'"]
and _webkit_mask_clip_style = [%value.rec "'border' | 'border-box' | 'padding' | 'padding-box' | 'content' | 'content-box' | 'text'"]
and absolute_size = [%value.rec "'xx-small' | 'x-small' | 'small' | 'medium' | 'large' | 'x-large' | 'xx-large' | 'xxx-large'"]
and age = [%value.rec "'child' | 'young' | 'old'"]
and alpha_value = [%value.rec "<number> | <extended-percentage>"]
and angular_color_hint = [%value.rec "<extended-angle> | <extended-percentage>"]
and angular_color_stop = [%value.rec "<color> && [ <color-stop-angle> ]?"]
and angular_color_stop_list = [%value.rec "[ <angular-color-stop> [ ',' <angular-color-hint> ]? ]# ',' <angular-color-stop>"]
and animateable_feature = [%value.rec "'scroll-position' | 'contents' | <custom-ident>"]
and attachment = [%value.rec "'scroll' | 'fixed' | 'local'"]
and attr_fallback = [%value.rec "<any-value>"]
and attr_matcher = [%value.rec "[ '~' | '|' | '^' | '$' | '*' ]? '='"]
and attr_modifier = [%value.rec "'i' | 's'"]
and attr_name = [%value.rec "<wq-name>"]
and attribute_selector = [%value.rec "'[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [ <string-token> | <ident-token> ] [ <attr-modifier> ]? ']'"]
and auto_repeat = [%value.rec "repeat( [ 'auto-fill' | 'auto-fit' ] ',' [ [ <line-names> ]? <fixed-size> ]+ [ <line-names> ]? )"]
and auto_track_list = [%value.rec "[ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ <line-names> ]? <auto-repeat> [ [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] ]* [ <line-names> ]?"]
and baseline_position = [%value.rec "[ 'first' | 'last' ]? 'baseline'"]
and basic_shape = [%value.rec "<inset()> | <circle()> | <ellipse()> | <polygon()> | <path()>"]
and bg_image = [%value.rec "'none' | <image>"]
and bg_layer = [%value.rec "<bg-image> || <bg-position> [ '/' <bg-size> ]? || <repeat-style> || <attachment> || <box> || <box>"]
and bg_position = [%value.rec "'left' | 'center' | 'right' | 'top' | 'bottom' | <extended-length> | <extended-percentage> | [ 'left' | 'center' | 'right' | <extended-length> | <extended-percentage> ] [ 'top' | 'center' | 'bottom' | <extended-length> | <extended-percentage> ] | [ 'center' | [ 'left' | 'right' ] [ <extended-length> | <extended-percentage> ]? ] && [ 'center' | [ 'top' | 'bottom' ] [ <extended-length> | <extended-percentage> ]? ]"]
and bg_size = [%value.rec "[ <extended-length> | <extended-percentage> | 'auto' ]{1,2} | 'cover' | 'contain'"]
and blend_mode = [%value.rec "'normal' | 'multiply' | 'screen' | 'overlay' | 'darken' | 'lighten' | 'color-dodge' | 'color-burn' | 'hard-light' | 'soft-light' | 'difference' | 'exclusion' | 'hue' | 'saturation' | 'color' | 'luminosity'"]
/* and border_radius = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"] */
and border_radius = [%value.rec "<extended-length> | <extended-percentage>"]
and bottom = [%value.rec "<extended-length> | 'auto'"]
and box = [%value.rec "'border-box' | 'padding-box' | 'content-box'"]
and calc_product = [%value.rec "<calc-value> [ '*' <calc-value> | '/' <number> ]*"]
and calc_sum = [%value.rec "<calc-product> [ [ '+' | '-' ] <calc-product> ]*"]
/* and calc_value = [%value.rec "<number> | <dimension> | <extended-percentage> | <calc>"] */
and calc_value = [%value.rec "<number> | <extended-length> | <extended-percentage> | <calc()>"]
and cf_final_image = [%value.rec "<image> | <color>"]
and cf_mixing_image = [%value.rec "[ <extended-percentage> ]? && <image>"]
and class_selector = [%value.rec "'.' <ident-token>"]
and clip_source = [%value.rec "<url>"]
and color = [%value.rec "<rgb()> | <rgba()> | <hsl()> | <hsla()> | <hex-color> | <named-color> | 'currentColor' | <deprecated-system-color> | <interpolation> | <var()>"]
and color_stop = [%value.rec "<color-stop-length> | <color-stop-angle>"]
and color_stop_angle = [%value.rec "[ <extended-angle> ]{1,2}"]
and color_stop_length = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]
and color_stop_list = [%value.rec "[ <linear-color-stop> [ ',' <linear-color-hint> ]? ]# ',' <linear-color-stop>"]
and combinator = [%value.rec "'>' | '+' | '~' | '||'"]
and common_lig_values = [%value.rec "'common-ligatures' | 'no-common-ligatures'"]
and compat_auto = [%value.rec "'searchfield' | 'textarea' | 'push-button' | 'slider-horizontal' | 'checkbox' | 'radio' | 'square-button' | 'menulist' | 'listbox' | 'meter' | 'progress-bar'"]
and complex_selector = [%value.rec "<compound-selector> [ [ <combinator> ]? <compound-selector> ]*"]
and complex_selector_list = [%value.rec "[ <complex-selector> ]#"]
and composite_style = [%value.rec "'clear' | 'copy' | 'source-over' | 'source-in' | 'source-out' | 'source-atop' | 'destination-over' | 'destination-in' | 'destination-out' | 'destination-atop' | 'xor'"]
and compositing_operator = [%value.rec "'add' | 'subtract' | 'intersect' | 'exclude'"]
and compound_selector = [%value.rec "[ <type-selector> ]? [ <subclass-selector> ]* [ <pseudo-element-selector> [ <pseudo-class-selector> ]* ]*"]
and compound_selector_list = [%value.rec "[ <compound-selector> ]#"]
and content_distribution = [%value.rec "'space-between' | 'space-around' | 'space-evenly' | 'stretch'"]
and content_list = [%value.rec "[ <string> | 'contents' | <url> | <quote> | <attr()> | counter( <ident> ',' [ <'list-style-type'> ]? ) ]+"]
and content_position = [%value.rec "'center' | 'start' | 'end' | 'flex-start' | 'flex-end'"]
and content_replacement = [%value.rec "<image>"]
and contextual_alt_values = [%value.rec "'contextual' | 'no-contextual'"]
and counter_style = [%value.rec "<counter-style-name>"]
and counter_style_name = [%value.rec "<custom-ident>"]
and cubic_bezier_timing_function = [%value.rec "'ease' | 'ease-in' | 'ease-out' | 'ease-in-out' | cubic-bezier( <number> ',' <number> ',' <number> ',' <number> )"]
and declaration = [%value.rec "<ident-token> ':' [ <declaration-value> ]? [ '!' 'important' ]?"]
and declaration_list = [%value.rec "[ [ <declaration> ]? ';' ]* [ <declaration> ]?"]
and deprecated_system_color = [%value.rec "'ActiveBorder' | 'ActiveCaption' | 'AppWorkspace' | 'Background' | 'ButtonFace' | 'ButtonHighlight' | 'ButtonShadow' | 'ButtonText' | 'CaptionText' | 'GrayText' | 'Highlight' | 'HighlightText' | 'InactiveBorder' | 'InactiveCaption' | 'InactiveCaptionText' | 'InfoBackground' | 'InfoText' | 'Menu' | 'MenuText' | 'Scrollbar' | 'ThreeDDarkShadow' | 'ThreeDFace' | 'ThreeDHighlight' | 'ThreeDLightShadow' | 'ThreeDShadow' | 'Window' | 'WindowFrame' | 'WindowText'"]
and discretionary_lig_values = [%value.rec "'discretionary-ligatures' | 'no-discretionary-ligatures'"]
and display_box = [%value.rec "'contents' | 'none'"]
and display_inside = [%value.rec "'flow' | 'flow-root' | 'table' | 'flex' | 'grid' | 'ruby'"]
and display_internal = [%value.rec "'table-row-group' | 'table-header-group' | 'table-footer-group' | 'table-row' | 'table-cell' | 'table-column-group' | 'table-column' | 'table-caption' | 'ruby-base' | 'ruby-text' | 'ruby-base-container' | 'ruby-text-container'"]
and display_legacy = [%value.rec "'inline-block' | 'inline-list-item' | 'inline-table' | 'inline-flex' | 'inline-grid'"]
and display_listitem = [%value.rec "[ <display-outside> ]? && [ 'flow' | 'flow-root' ]? && 'list-item'"]
and display_outside = [%value.rec "'block' | 'inline' | 'run-in'"]
and east_asian_variant_values = [%value.rec "'jis78' | 'jis83' | 'jis90' | 'jis04' | 'simplified' | 'traditional'"]
and east_asian_width_values = [%value.rec "'full-width' | 'proportional-width'"]
and ending_shape = [%value.rec "'circle' | 'ellipse'"]
and explicit_track_list = [%value.rec "[ [ <line-names> ]? <track-size> ]+ [ <line-names> ]?"]
and family_name = [%value.rec "<string> | [ <custom-ident> ]+"]
and feature_tag_value = [%value.rec "<string> [ <integer> | 'on' | 'off' ]?"]
and feature_type = [%value.rec "'@stylistic' | '@historical-forms' | '@styleset' | '@character-variant' | '@swash' | '@ornaments' | '@annotation'"]
and feature_value_block = [%value.rec "<feature-type> '{' <feature-value-declaration-list> '}'"]
and feature_value_block_list = [%value.rec "[ <feature-value-block> ]+"]
and feature_value_declaration = [%value.rec "<custom-ident> ':' [ <integer> ]+ ';'"]
and feature_value_declaration_list = [%value.rec "<feature-value-declaration>"]
and feature_value_name = [%value.rec "<custom-ident>"]
and fill_rule = [%value.rec "'nonzero' | 'evenodd'"]
and filter_function = [%value.rec "<blur()> | <brightness()> | <contrast()> | <drop-shadow()> | <grayscale()> | <hue-rotate()> | <invert()> | <opacity()> | <saturate()> | <sepia()>"]
and filter_function_list = [%value.rec "[ <filter-function> | <url> ]+"]
and final_bg_layer = [%value.rec "<'background-color'> || <bg-image> || <bg-position> [ '/' <bg-size> ]? || <repeat-style> || <attachment> || <box> || <box>"]
and fixed_breadth = [%value.rec "<extended-length> | <extended-percentage>"]
and fixed_repeat = [%value.rec "repeat( <positive-integer> ',' [ [ <line-names> ]? <fixed-size> ]+ [ <line-names> ]? )"]
and fixed_size = [%value.rec "<fixed-breadth> | minmax( <fixed-breadth> ',' <track-breadth> ) | minmax( <inflexible-breadth> ',' <fixed-breadth> )"]
and font_stretch_absolute = [%value.rec "'normal' | 'ultra-condensed' | 'extra-condensed' | 'condensed' | 'semi-condensed' | 'semi-expanded' | 'expanded' | 'extra-expanded' | 'ultra-expanded' | <extended-percentage>"]
and font_variant_css21 = [%value.rec "'normal' | 'small-caps'"]
and font_weight_absolute = [%value.rec "'normal' | 'bold' | <number>"]
and function__webkit_gradient = [%value.rec "-webkit-gradient( <-webkit-gradient-type> ',' <-webkit-gradient-point> [ ',' <-webkit-gradient-point> | ',' <-webkit-gradient-radius> ',' <-webkit-gradient-point> ] [ ',' <-webkit-gradient-radius> ]? [ ',' <-webkit-gradient-color-stop> ]* )"]
and function_attr = [%value.rec "attr( <attr-name> [ <type-or-unit> ]? [ ',' <attr-fallback> ]? )"]
and function_blur = [%value.rec "blur( <extended-length> )"]
and function_brightness = [%value.rec "brightness( <number-percentage> )"]
and function_calc = [%value.rec "calc( <calc-sum> )"]
and function_circle = [%value.rec "circle( [ <shape-radius> ]? [ 'at' <position> ]? )"]
and function_clamp = [%value.rec "clamp( [ <calc-sum> ]#{3} )"]
and function_conic_gradient = [%value.rec "conic-gradient( [ 'from' <extended-angle> ]? [ 'at' <position> ]? ',' <angular-color-stop-list> )"]
and function_contrast = [%value.rec "contrast( <number-percentage> )"]
and function_counter = [%value.rec "counter( <custom-ident> ',' [ <counter-style> ]? )"]
and function_counters = [%value.rec "counters( <custom-ident> ',' <string> ',' [ <counter-style> ]? )"]
and function_cross_fade = [%value.rec "cross-fade( <cf-mixing-image> ',' [ <cf-final-image> ]? )"]
and function_drop_shadow = [%value.rec "drop-shadow( [ <extended-length> ]{2,3} [ <color> ]? )"]
and function_element = [%value.rec "element( <id-selector> )"]
and function_ellipse = [%value.rec "ellipse( [ [ <shape-radius> ]{2} ]? [ 'at' <position> ]? )"]
and function_env = [%value.rec "env( <custom-ident> ',' [ <declaration-value> ]? )"]
and function_fit_content = [%value.rec "fit-content( <extended-length> | <extended-percentage> )"]
and function_grayscale = [%value.rec "grayscale( <number-percentage> )"]
and function_hsl = [%value.rec " hsl( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> ]? )
  | hsl( <hue> ',' <extended-percentage> ',' <extended-percentage> [ ',' <alpha-value> ]? )"]
and function_hsla = [%value.rec " hsla( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> ]? )
  | hsla( <hue> ',' <extended-percentage> ',' <extended-percentage> ',' [ <alpha-value> ]? )"]
and function_hue_rotate = [%value.rec "hue-rotate( <extended-angle> )"]
and function_image = [%value.rec "image( [ <image-tags> ]? [ <image-src> ]? ',' [ <color> ]? )"]
and function_image_set = [%value.rec "image-set( [ <image-set-option> ]# )"]
and function_inset = [%value.rec "inset( [ <extended-length> | <extended-percentage> ]{1,4} [ 'round' <'border-radius'> ]? )"]
and function_invert = [%value.rec "invert( <number-percentage> )"]
and function_leader = [%value.rec "leader( <leader-type> )"]
and function_linear_gradient = [%value.rec "linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? ',' <color-stop-list> )"]
and function_matrix = [%value.rec "matrix( [ <number> ]#{6} )"]
and function_matrix3d = [%value.rec "matrix3d( [ <number> ]#{16} )"]
and function_max = [%value.rec "max( [ <calc-sum> ]# )"]
and function_min = [%value.rec "min( [ <calc-sum> ]# )"]
and function_minmax = [%value.rec "minmax( [ <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'auto' ] ',' [ <extended-length> | <extended-percentage> | <flex-value> | 'min-content' | 'max-content' | 'auto' ] )"]
and function_opacity = [%value.rec "opacity( <number-percentage> )"]
and function_paint = [%value.rec "paint( <ident> ',' [ <declaration-value> ]? )"]
and function_path = [%value.rec "path( <string> )"]
and function_perspective = [%value.rec "perspective( <property-perspective> )"]
and function_polygon = [%value.rec "polygon( [ <fill-rule> ]? ',' [ <extended-length> | <extended-percentage> <extended-length> | <extended-percentage> ]# )"]
and function_radial_gradient = [%value.rec "radial-gradient( [ <ending-shape> || <size> ]? [ 'at' <position> ]? ',' <color-stop-list> )"]
and function_repeating_linear_gradient = [%value.rec "repeating-linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? ',' <color-stop-list> )"]
and function_repeating_radial_gradient = [%value.rec "repeating-radial-gradient( [ <ending-shape> || <size> ]? [ 'at' <position> ]? ',' <color-stop-list> )"]
and function_rgb = [%value.rec "
    rgb( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? )
  | rgb( [ <number> ]{3} [ '/' <alpha-value> ]? )
  | rgb( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? )
  | rgb( [ <number> ]#{3} [ ',' <alpha-value> ]? )
"]
and function_rgba = [%value.rec "
    rgba( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? )
  | rgba( [ <number> ]{3} [ '/' <alpha-value> ]? )
  | rgba( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? )
  | rgba( [ <number> ]#{3} [ ',' <alpha-value> ]? )
"]
and function_rotate = [%value.rec "rotate( <extended-angle> | <zero> )"]
and function_rotate3d = [%value.rec "rotate3d( <number> ',' <number> ',' <number> ',' [ <extended-angle> | <zero> ] )"]
and function_rotateX = [%value.rec "rotateX( <extended-angle> | <zero> )"]
and function_rotateY = [%value.rec "rotateY( <extended-angle> | <zero> )"]
and function_rotateZ = [%value.rec "rotateZ( <extended-angle> | <zero> )"]
and function_saturate = [%value.rec "saturate( <number-percentage> )"]
and function_scale = [%value.rec "scale( <number> [',' [ <number> ]]? )"]
and function_scale3d = [%value.rec "scale3d( <number> ',' <number> ',' <number> )"]
and function_scaleX = [%value.rec "scaleX( <number> )"]
and function_scaleY = [%value.rec "scaleY( <number> )"]
and function_scaleZ = [%value.rec "scaleZ( <number> )"]
and function_sepia = [%value.rec "sepia( <number-percentage> )"]
and function_skew = [%value.rec "skew( [ <extended-angle> | <zero> ] [',' [ <extended-angle> | <zero> ]]? )"]
and function_skewX = [%value.rec "skewX( <extended-angle> | <zero> )"]
and function_skewY = [%value.rec "skewY( <extended-angle> | <zero> )"]
and function_target_counter = [%value.rec "target-counter( [ <string> | <url> ] ',' <custom-ident> ',' [ <counter-style> ]? )"]
and function_target_counters = [%value.rec "target-counters( [ <string> | <url> ] ',' <custom-ident> ',' <string> ',' [ <counter-style> ]? )"]
and function_target_text = [%value.rec "target-text( [ <string> | <url> ] ',' [ 'content' | 'before' | 'after' | 'first-letter' ]? )"]
and function_translate = [%value.rec "translate( [<extended-length> | <extended-percentage>] [',' [ <extended-length> | <extended-percentage> ]]? )"]
and function_translate3d = [%value.rec "translate3d( [<extended-length> | <extended-percentage>] ',' [<extended-length> | <extended-percentage>] ',' <extended-length> )"]
and function_translateX = [%value.rec "translateX( [<extended-length> | <extended-percentage>] )"]
and function_translateY = [%value.rec "translateY( [<extended-length> | <extended-percentage>] )"]
and function_translateZ = [%value.rec "translateZ( <extended-length> )"]
/* and function_var = [%value.rec "var( <ident> ',' [ <declaration-value> ]? )"] */
and function_var = [%value.rec "var( <ident> )"]
and gender = [%value.rec "'male' | 'female' | 'neutral'"]
and general_enclosed = [%value.rec "<function-token> <any-value> ')' | '(' <ident> <any-value> ')'"]
and generic_family = [%value.rec "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace' | '-apple-system'"]
and generic_name = [%value.rec "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace'"]
and generic_voice = [%value.rec "[ <age> ]? <gender> [ <integer> ]?"]
and geometry_box = [%value.rec "<shape-box> | 'fill-box' | 'stroke-box' | 'view-box'"]
and gradient = [%value.rec "<linear-gradient()> | <repeating-linear-gradient()> | <radial-gradient()> | <repeating-radial-gradient()> | <conic-gradient()> | <-legacy-gradient>"]
and grid_line = [%value.rec "'auto' | <custom-ident> | <integer> && [ <custom-ident> ]? | 'span' && [ <integer> || <custom-ident> ]"]
and historical_lig_values = [%value.rec "'historical-ligatures' | 'no-historical-ligatures'"]
and hue = [%value.rec "<number> | <extended-angle>"]
and id_selector = [%value.rec "<hash-token>"]
and image = [%value.rec "<url> | <image()> | <image-set()> | <element()> | <paint()> | <cross-fade()> | <gradient> | <interpolation>"]
and image_set_option = [%value.rec "[ <image> | <string> ] <resolution>"]
and image_src = [%value.rec "<url> | <string>"]
and image_tags = [%value.rec "'ltr' | 'rtl'"]
and inflexible_breadth = [%value.rec "<extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'auto'"]
and keyframe_block = [%value.rec "[ <keyframe-selector> ]# '{' <declaration-list> '}'"]
and keyframe_block_list = [%value.rec "[ <keyframe-block> ]+"]
and keyframe_selector = [%value.rec "'from' | 'to' | <extended-percentage>"]
and keyframes_name = [%value.rec "<custom-ident> | <string>"]
and leader_type = [%value.rec "'dotted' | 'solid' | 'space' | <string>"]
and left = [%value.rec "<extended-length> | 'auto'"]
and line_name_list = [%value.rec "[ <line-names> | <name-repeat> ]+"]
/* and line_names = [%value.rec "[ '[' <custom-ident> ']' ]*"] */
and line_style = [%value.rec "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | 'ridge' | 'inset' | 'outset'"]
and line_width = [%value.rec "<extended-length> | 'thin' | 'medium' | 'thick'"]
and linear_color_hint = [%value.rec "<extended-length> | <extended-percentage>"]
and linear_color_stop = [%value.rec "<color> [ <color-stop-length> ]?"]
and mask_image = [%value.rec "[ <mask-reference> ]#"]
and mask_layer = [%value.rec "<mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || <geometry-box> || [ <geometry-box> | 'no-clip' ] || <compositing-operator> || <masking-mode>"]
and mask_position = [%value.rec "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' ] [ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' ]?"]
and mask_reference = [%value.rec "'none' | <image> | <mask-source>"]
and mask_source = [%value.rec "<url>"]
and masking_mode = [%value.rec "'alpha' | 'luminance' | 'match-source'"]
and media_and = [%value.rec "<media-in-parens> [ 'and' <media-in-parens> ]+"]
and media_condition = [%value.rec "<media-not> | <media-and> | <media-or> | <media-in-parens>"]
and media_condition_without_or = [%value.rec "<media-not> | <media-and> | <media-in-parens>"]
and media_feature = [%value.rec "'(' [ <mf-plain> | <mf-boolean> | <mf-range> ] ')'"]
and media_in_parens = [%value.rec "'(' <media-condition> ')' | <media-feature> | <general-enclosed>"]
and media_not = [%value.rec "'not' <media-in-parens>"]
and media_or = [%value.rec "<media-in-parens> [ 'or' <media-in-parens> ]+"]
and media_query = [%value.rec "<media-condition> | [ 'not' | 'only' ]? <media-type> [ 'and' <media-condition-without-or> ]?"]
and media_query_list = [%value.rec "[ <media-query> ]#"]
and media_type = [%value.rec "<ident>"]
and mf_boolean = [%value.rec "<mf-name>"]
and mf_name = [%value.rec "<ident>"]
and mf_plain = [%value.rec "<mf-name> ':' <mf-value>"]
and mf_range = [%value.rec "<mf-name> [ '<' | '>' ]? [ '=' ]? <mf-value> | <mf-value> [ '<' | '>' ]? [ '=' ]? <mf-name> | <mf-value> '<' [ '=' ]? <mf-name> '<' [ '=' ]? <mf-value> | <mf-value> '>' [ '=' ]? <mf-name> '>' [ '=' ]? <mf-value>"]
and mf_value = [%value.rec "<number> | <dimension> | <ident> | <ratio>"]
and name_repeat = [%value.rec "repeat( [ <positive-integer> | 'auto-fill' ] ',' [ <line-names> ]+ )"]
and named_color = [%value.rec "'transparent' | 'aliceblue' | 'antiquewhite' | 'aqua' | 'aquamarine' | 'azure' | 'beige' | 'bisque' | 'black' | 'blanchedalmond' | 'blue' | 'blueviolet' | 'brown' | 'burlywood' | 'cadetblue' | 'chartreuse' | 'chocolate' | 'coral' | 'cornflowerblue' | 'cornsilk' | 'crimson' | 'cyan' | 'darkblue' | 'darkcyan' | 'darkgoldenrod' | 'darkgray' | 'darkgreen' | 'darkgrey' | 'darkkhaki' | 'darkmagenta' | 'darkolivegreen' | 'darkorange' | 'darkorchid' | 'darkred' | 'darksalmon' | 'darkseagreen' | 'darkslateblue' | 'darkslategray' | 'darkslategrey' | 'darkturquoise' | 'darkviolet' | 'deeppink' | 'deepskyblue' | 'dimgray' | 'dimgrey' | 'dodgerblue' | 'firebrick' | 'floralwhite' | 'forestgreen' | 'fuchsia' | 'gainsboro' | 'ghostwhite' | 'gold' | 'goldenrod' | 'gray' | 'green' | 'greenyellow' | 'grey' | 'honeydew' | 'hotpink' | 'indianred' | 'indigo' | 'ivory' | 'khaki' | 'lavender' | 'lavenderblush' | 'lawngreen' | 'lemonchiffon' | 'lightblue' | 'lightcoral' | 'lightcyan' | 'lightgoldenrodyellow' | 'lightgray' | 'lightgreen' | 'lightgrey' | 'lightpink' | 'lightsalmon' | 'lightseagreen' | 'lightskyblue' | 'lightslategray' | 'lightslategrey' | 'lightsteelblue' | 'lightyellow' | 'lime' | 'limegreen' | 'linen' | 'magenta' | 'maroon' | 'mediumaquamarine' | 'mediumblue' | 'mediumorchid' | 'mediumpurple' | 'mediumseagreen' | 'mediumslateblue' | 'mediumspringgreen' | 'mediumturquoise' | 'mediumvioletred' | 'midnightblue' | 'mintcream' | 'mistyrose' | 'moccasin' | 'navajowhite' | 'navy' | 'oldlace' | 'olive' | 'olivedrab' | 'orange' | 'orangered' | 'orchid' | 'palegoldenrod' | 'palegreen' | 'paleturquoise' | 'palevioletred' | 'papayawhip' | 'peachpuff' | 'peru' | 'pink' | 'plum' | 'powderblue' | 'purple' | 'rebeccapurple' | 'red' | 'rosybrown' | 'royalblue' | 'saddlebrown' | 'salmon' | 'sandybrown' | 'seagreen' | 'seashell' | 'sienna' | 'silver' | 'skyblue' | 'slateblue' | 'slategray' | 'slategrey' | 'snow' | 'springgreen' | 'steelblue' | 'tan' | 'teal' | 'thistle' | 'tomato' | 'turquoise' | 'violet' | 'wheat' | 'white' | 'whitesmoke' | 'yellow' | 'yellowgreen' | <-non-standard-color>"]
and namespace_prefix = [%value.rec "<ident>"]
and ns_prefix = [%value.rec "[ <ident-token> | '*' ]? '|'"]
and nth = [%value.rec "<an-plus-b> | 'even' | 'odd'"]
and number_one_or_greater = [%value.rec "<number>"]
and number_percentage = [%value.rec "<number> | <extended-percentage>"]
and number_zero_one = [%value.rec "<number>"]
and numeric_figure_values = [%value.rec "'lining-nums' | 'oldstyle-nums'"]
and numeric_fraction_values = [%value.rec "'diagonal-fractions' | 'stacked-fractions'"]
and numeric_spacing_values = [%value.rec "'proportional-nums' | 'tabular-nums'"]
and outline_radius = [%value.rec "<extended-length> | <extended-percentage>"]
and overflow_position = [%value.rec "'unsafe' | 'safe'"]
and page_body = [%value.rec "[ <declaration> ]? [ ';' <page-body> ]? | <page-margin-box> <page-body>"]
and page_margin_box = [%value.rec "<page-margin-box-type> '{' <declaration-list> '}'"]
and page_margin_box_type = [%value.rec "'@top-left-corner' | '@top-left' | '@top-center' | '@top-right' | '@top-right-corner' | '@bottom-left-corner' | '@bottom-left' | '@bottom-center' | '@bottom-right' | '@bottom-right-corner' | '@left-top' | '@left-middle' | '@left-bottom' | '@right-top' | '@right-middle' | '@right-bottom'"]
and page_selector = [%value.rec "[ <pseudo-page> ]+ | <ident> [ <pseudo-page> ]*"]
and page_selector_list = [%value.rec "[ [ <page-selector> ]# ]?"]
and paint = [%value.rec "'none' | <color> | <url> [ 'none' | <color> ]? | 'context-fill' | 'context-stroke'"]
and position = [%value.rec "[ 'left' | 'center' | 'right' ] || [ 'top' | 'center' | 'bottom' ] | [ 'left' | 'center' | 'right' | <extended-length> | <extended-percentage> ] [ 'top' | 'center' | 'bottom' | <extended-length> | <extended-percentage> ]? | [ 'left' | 'right' ] [<extended-length> | <extended-percentage>] && [ 'top' | 'bottom' ] [<extended-length> | <extended-percentage>]"]
and positive_integer = [%value.rec "<integer>"]
and property__moz_appearance = [%value.rec "'none' | 'button' | 'button-arrow-down' | 'button-arrow-next' | 'button-arrow-previous' | 'button-arrow-up' | 'button-bevel' | 'button-focus' | 'caret' | 'checkbox' | 'checkbox-container' | 'checkbox-label' | 'checkmenuitem' | 'dualbutton' | 'groupbox' | 'listbox' | 'listitem' | 'menuarrow' | 'menubar' | 'menucheckbox' | 'menuimage' | 'menuitem' | 'menuitemtext' | 'menulist' | 'menulist-button' | 'menulist-text' | 'menulist-textfield' | 'menupopup' | 'menuradio' | 'menuseparator' | 'meterbar' | 'meterchunk' | 'progressbar' | 'progressbar-vertical' | 'progresschunk' | 'progresschunk-vertical' | 'radio' | 'radio-container' | 'radio-label' | 'radiomenuitem' | 'range' | 'range-thumb' | 'resizer' | 'resizerpanel' | 'scale-horizontal' | 'scalethumbend' | 'scalethumb-horizontal' | 'scalethumbstart' | 'scalethumbtick' | 'scalethumb-vertical' | 'scale-vertical' | 'scrollbarbutton-down' | 'scrollbarbutton-left' | 'scrollbarbutton-right' | 'scrollbarbutton-up' | 'scrollbarthumb-horizontal' | 'scrollbarthumb-vertical' | 'scrollbartrack-horizontal' | 'scrollbartrack-vertical' | 'searchfield' | 'separator' | 'sheet' | 'spinner' | 'spinner-downbutton' | 'spinner-textfield' | 'spinner-upbutton' | 'splitter' | 'statusbar' | 'statusbarpanel' | 'tab' | 'tabpanel' | 'tabpanels' | 'tab-scroll-arrow-back' | 'tab-scroll-arrow-forward' | 'textfield' | 'textfield-multiline' | 'toolbar' | 'toolbarbutton' | 'toolbarbutton-dropdown' | 'toolbargripper' | 'toolbox' | 'tooltip' | 'treeheader' | 'treeheadercell' | 'treeheadersortarrow' | 'treeitem' | 'treeline' | 'treetwisty' | 'treetwistyopen' | 'treeview' | '-moz-mac-unified-toolbar' | '-moz-win-borderless-glass' | '-moz-win-browsertabbar-toolbox' | '-moz-win-communicationstext' | '-moz-win-communications-toolbox' | '-moz-win-exclude-glass' | '-moz-win-glass' | '-moz-win-mediatext' | '-moz-win-media-toolbox' | '-moz-window-button-box' | '-moz-window-button-box-maximized' | '-moz-window-button-close' | '-moz-window-button-maximize' | '-moz-window-button-minimize' | '-moz-window-button-restore' | '-moz-window-frame-bottom' | '-moz-window-frame-left' | '-moz-window-frame-right' | '-moz-window-titlebar' | '-moz-window-titlebar-maximized'"]
and property__moz_background_clip = [%value.rec "'padding' | 'border'"]
and property__moz_binding = [%value.rec "<url> | 'none'"]
and property__moz_border_bottom_colors = [%value.rec "[ <color> ]+ | 'none'"]
and property__moz_border_left_colors = [%value.rec "[ <color> ]+ | 'none'"]
and property__moz_border_radius_bottomleft = [%value.rec "<'border-bottom-left-radius'>"]
and property__moz_border_radius_bottomright = [%value.rec "<'border-bottom-right-radius'>"]
and property__moz_border_radius_topleft = [%value.rec "<'border-top-left-radius'>"]
and property__moz_border_radius_topright = [%value.rec "<'border-bottom-right-radius'>"]
/* TODO: Remove interpolation without <> */
and property__moz_border_right_colors = [%value.rec "[ <color> ]+ | 'none' | interpolation"]
/* TODO: Remove interpolation without <> */
and property__moz_border_top_colors = [%value.rec "[ <color> ]+ | 'none' | interpolation"]
and property__moz_context_properties = [%value.rec "'none' | [ 'fill' | 'fill-opacity' | 'stroke' | 'stroke-opacity' ]#"]
and property__moz_control_character_visibility = [%value.rec "'visible' | 'hidden'"]
and property__moz_float_edge = [%value.rec "'border-box' | 'content-box' | 'margin-box' | 'padding-box'"]
and property__moz_force_broken_image_icon = [%value.rec "<integer>"]
and property__moz_image_region = [%value.rec "<shape> | 'auto'"]
and property__moz_orient = [%value.rec "'inline' | 'block' | 'horizontal' | 'vertical'"]
and property__moz_osx_font_smoothing = [%value.rec "'auto' | 'grayscale'"]
and property__moz_outline_radius = [%value.rec "[ <outline-radius> ]{1,4} [ '/' [ <outline-radius> ]{1,4} ]?"]
and property__moz_outline_radius_bottomleft = [%value.rec "<outline-radius>"]
and property__moz_outline_radius_bottomright = [%value.rec "<outline-radius>"]
and property__moz_outline_radius_topleft = [%value.rec "<outline-radius>"]
and property__moz_outline_radius_topright = [%value.rec "<outline-radius>"]
and property__moz_stack_sizing = [%value.rec "'ignore' | 'stretch-to-fit'"]
and property__moz_text_blink = [%value.rec "'none' | 'blink'"]
and property__moz_user_focus = [%value.rec "'ignore' | 'normal' | 'select-after' | 'select-before' | 'select-menu' | 'select-same' | 'select-all' | 'none'"]
and property__moz_user_input = [%value.rec "'auto' | 'none' | 'enabled' | 'disabled'"]
and property__moz_user_modify = [%value.rec "'read-only' | 'read-write' | 'write-only'"]
and property__moz_user_select = [%value.rec "'none' | 'text' | 'all' | '-moz-none'"]
and property__moz_window_dragging = [%value.rec "'drag' | 'no-drag'"]
and property__moz_window_shadow = [%value.rec "'default' | 'menu' | 'tooltip' | 'sheet' | 'none'"]
and property__ms_accelerator = [%value.rec "'false' | 'true'"]
and property__ms_block_progression = [%value.rec "'tb' | 'rl' | 'bt' | 'lr'"]
and property__ms_content_zoom_chaining = [%value.rec "'none' | 'chained'"]
and property__ms_content_zoom_limit = [%value.rec "<'-ms-content-zoom-limit-min'> <'-ms-content-zoom-limit-max'>"]
and property__ms_content_zoom_limit_max = [%value.rec "<extended-percentage>"]
and property__ms_content_zoom_limit_min = [%value.rec "<extended-percentage>"]
and property__ms_content_zoom_snap = [%value.rec "<'-ms-content-zoom-snap-type'> || <'-ms-content-zoom-snap-points'>"]
and property__ms_content_zoom_snap_points = [%value.rec "snapInterval( <extended-percentage> ',' <extended-percentage> ) | snapList( [ <extended-percentage> ]# )"]
and property__ms_content_zoom_snap_type = [%value.rec "'none' | 'proximity' | 'mandatory'"]
and property__ms_content_zooming = [%value.rec "'none' | 'zoom'"]
and property__ms_filter = [%value.rec "<string>"]
and property__ms_flex_align = [%value.rec "'start' | 'end' | 'center' | 'baseline' | 'stretch'"]
and property__ms_flex_item_align = [%value.rec "'auto' | 'start' | 'end' | 'center' | 'baseline' | 'stretch'"]
and property__ms_flex_line_pack = [%value.rec "'start' | 'end' | 'center' | 'justify' | 'distribute' | 'stretch'"]
and property__ms_flex_negative = [%value.rec "<'flex-shrink'>"]
and property__ms_flex_order = [%value.rec "<integer>"]
and property__ms_flex_pack = [%value.rec "'start' | 'end' | 'center' | 'justify' | 'distribute'"]
and property__ms_flex_positive = [%value.rec "<'flex-grow'>"]
and property__ms_flex_preferred_size = [%value.rec "<'flex-basis'>"]
and property__ms_flow_from = [%value.rec "[ 'none' | <custom-ident> ]#"]
and property__ms_flow_into = [%value.rec "[ 'none' | <custom-ident> ]#"]
and property__ms_grid_column_align = [%value.rec "'start' | 'end' | 'center' | 'stretch'"]
and property__ms_grid_columns = [%value.rec "<track-list-v0>"]
and property__ms_grid_row_align = [%value.rec "'start' | 'end' | 'center' | 'stretch'"]
and property__ms_grid_rows = [%value.rec "<track-list-v0>"]
and property__ms_high_contrast_adjust = [%value.rec "'auto' | 'none'"]
and property__ms_hyphenate_limit_chars = [%value.rec "'auto' | [ <integer> ]{1,3}"]
and property__ms_hyphenate_limit_last = [%value.rec "'none' | 'always' | 'column' | 'page' | 'spread'"]
and property__ms_hyphenate_limit_lines = [%value.rec "'no-limit' | <integer>"]
and property__ms_hyphenate_limit_zone = [%value.rec "<extended-percentage> | <extended-length>"]
and property__ms_ime_align = [%value.rec "'auto' | 'after'"]
and property__ms_interpolation_mode = [%value.rec "'nearest-neighbor' | 'bicubic'"]
and property__ms_overflow_style = [%value.rec "'auto' | 'none' | 'scrollbar' | '-ms-autohiding-scrollbar'"]
and property__ms_scroll_chaining = [%value.rec "'chained' | 'none'"]
and property__ms_scroll_limit = [%value.rec "<'-ms-scroll-limit-x-min'> <'-ms-scroll-limit-y-min'> <'-ms-scroll-limit-x-max'> <'-ms-scroll-limit-y-max'>"]
and property__ms_scroll_limit_x_max = [%value.rec "'auto' | <extended-length>"]
and property__ms_scroll_limit_x_min = [%value.rec "<extended-length>"]
and property__ms_scroll_limit_y_max = [%value.rec "'auto' | <extended-length>"]
and property__ms_scroll_limit_y_min = [%value.rec "<extended-length>"]
and property__ms_scroll_rails = [%value.rec "'none' | 'railed'"]
and property__ms_scroll_snap_points_x = [%value.rec "snapInterval( <extended-length> | <extended-percentage> ',' <extended-length> | <extended-percentage> ) | snapList( [ <extended-length> | <extended-percentage> ]# )"]
and property__ms_scroll_snap_points_y = [%value.rec "snapInterval( <extended-length> | <extended-percentage> ',' <extended-length> | <extended-percentage> ) | snapList( [ <extended-length> | <extended-percentage> ]# )"]
and property__ms_scroll_snap_type = [%value.rec "'none' | 'proximity' | 'mandatory'"]
and property__ms_scroll_snap_x = [%value.rec "<'-ms-scroll-snap-type'> <'-ms-scroll-snap-points-x'>"]
and property__ms_scroll_snap_y = [%value.rec "<'-ms-scroll-snap-type'> <'-ms-scroll-snap-points-y'>"]
and property__ms_scroll_translation = [%value.rec "'none' | 'vertical-to-horizontal'"]
and property__ms_scrollbar_3dlight_color = [%value.rec "<color>"]
and property__ms_scrollbar_arrow_color = [%value.rec "<color>"]
and property__ms_scrollbar_base_color = [%value.rec "<color>"]
and property__ms_scrollbar_darkshadow_color = [%value.rec "<color>"]
and property__ms_scrollbar_face_color = [%value.rec "<color>"]
and property__ms_scrollbar_highlight_color = [%value.rec "<color>"]
and property__ms_scrollbar_shadow_color = [%value.rec "<color>"]
and property__ms_scrollbar_track_color = [%value.rec "<color>"]
and property__ms_text_autospace = [%value.rec "'none' | 'ideograph-alpha' | 'ideograph-numeric' | 'ideograph-parenthesis' | 'ideograph-space'"]
and property__ms_touch_select = [%value.rec "'grippers' | 'none'"]
and property__ms_user_select = [%value.rec "'none' | 'element' | 'text'"]
and property__ms_wrap_flow = [%value.rec "'auto' | 'both' | 'start' | 'end' | 'maximum' | 'clear'"]
and property__ms_wrap_margin = [%value.rec "<extended-length>"]
and property__ms_wrap_through = [%value.rec "'wrap' | 'none'"]
and property__webkit_appearance = [%value.rec "'none' | 'button' | 'button-bevel' | 'caps-lock-indicator' | 'caret' | 'checkbox' | 'default-button' | 'listbox' | 'listitem' | 'media-fullscreen-button' | 'media-mute-button' | 'media-play-button' | 'media-seek-back-button' | 'media-seek-forward-button' | 'media-slider' | 'media-sliderthumb' | 'menulist' | 'menulist-button' | 'menulist-text' | 'menulist-textfield' | 'push-button' | 'radio' | 'scrollbarbutton-down' | 'scrollbarbutton-left' | 'scrollbarbutton-right' | 'scrollbarbutton-up' | 'scrollbargripper-horizontal' | 'scrollbargripper-vertical' | 'scrollbarthumb-horizontal' | 'scrollbarthumb-vertical' | 'scrollbartrack-horizontal' | 'scrollbartrack-vertical' | 'searchfield' | 'searchfield-cancel-button' | 'searchfield-decoration' | 'searchfield-results-button' | 'searchfield-results-decoration' | 'slider-horizontal' | 'slider-vertical' | 'sliderthumb-horizontal' | 'sliderthumb-vertical' | 'square-button' | 'textarea' | 'textfield'"]
and property__webkit_background_clip = [%value.rec "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#"]
and property__webkit_border_before = [%value.rec "<'border-width'> || <'border-style'> || <'color'>"]
and property__webkit_border_before_color = [%value.rec "<'color'>"]
and property__webkit_border_before_style = [%value.rec "<'border-style'>"]
and property__webkit_border_before_width = [%value.rec "<'border-width'>"]
and property__webkit_box_reflect = [%value.rec "[ 'above' | 'below' | 'right' | 'left' ]? [ <extended-length> ]? [ <image> ]?"]
and property__webkit_column_break_after = [%value.rec "'always' | 'auto' | 'avoid'"]
and property__webkit_column_break_before = [%value.rec "'always' | 'auto' | 'avoid'"]
and property__webkit_column_break_inside = [%value.rec "'always' | 'auto' | 'avoid'"]
and property__webkit_font_smoothing = [%value.rec "'auto' | 'none' | 'antialiased' | 'subpixel-antialiased'"]
and property__webkit_line_clamp = [%value.rec "'none' | <integer>"]
and property__webkit_mask = [%value.rec "[ <mask-reference> || <position> [ '/' <bg-size> ]? || <repeat-style> || [ <box> | 'border' | 'padding' | 'content' | 'text' ] || [ <box> | 'border' | 'padding' | 'content' ] ]#"]
and property__webkit_mask_attachment = [%value.rec "[ <attachment> ]#"]
and property__webkit_mask_box_image = [%value.rec "[ <url> | <gradient> | 'none' ] [ [ <extended-length> | <extended-percentage> ]{4} [ <-webkit-mask-box-repeat> ]{2} ]?"]
and property__webkit_mask_clip = [%value.rec "[ <box> | 'border' | 'padding' | 'content' | 'text' ]#"]
and property__webkit_mask_composite = [%value.rec "[ <composite-style> ]#"]
and property__webkit_mask_image = [%value.rec "[ <mask-reference> ]#"]
and property__webkit_mask_origin = [%value.rec "[ <box> | 'border' | 'padding' | 'content' ]#"]
and property__webkit_mask_position = [%value.rec "[ <position> ]#"]
and property__webkit_mask_position_x = [%value.rec "[ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' ]#"]
and property__webkit_mask_position_y = [%value.rec "[ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' ]#"]
and property__webkit_mask_repeat = [%value.rec "[ <repeat-style> ]#"]
and property__webkit_mask_repeat_x = [%value.rec "'repeat' | 'no-repeat' | 'space' | 'round'"]
and property__webkit_mask_repeat_y = [%value.rec "'repeat' | 'no-repeat' | 'space' | 'round'"]
and property__webkit_mask_size = [%value.rec "[ <bg-size> ]#"]
and property__webkit_overflow_scrolling = [%value.rec "'auto' | 'touch'"]
and property__webkit_print_color_adjust = [%value.rec "'economy' | 'exact'"]
and property__webkit_tap_highlight_color = [%value.rec "<color>"]
and property__webkit_text_fill_color = [%value.rec "<color>"]
and property__webkit_text_security = [%value.rec "'none' | 'circle' | 'disc' | 'square'"]
and property__webkit_text_stroke = [%value.rec "<extended-length> || <color>"]
and property__webkit_text_stroke_color = [%value.rec "<color>"]
and property__webkit_text_stroke_width = [%value.rec "<extended-length>"]
and property__webkit_touch_callout = [%value.rec "'default' | 'none'"]
and property__webkit_user_drag = [%value.rec "'none' | 'element' | 'auto'"]
and property__webkit_user_modify = [%value.rec "'read-only' | 'read-write' | 'read-write-plaintext-only'"]
and property__webkit_user_select = [%value.rec "'auto' | 'none' | 'text' | 'all'"]
and property_align_content = [%value.rec "'normal' | <baseline-position> | <content-distribution> | [ <overflow-position> ]? <content-position>"]
and property_align_items = [%value.rec "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? <self-position>"]
and property_align_self = [%value.rec "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? <self-position>"]
and property_alignment_baseline = [%value.rec "'auto' | 'baseline' | 'before-edge' | 'text-before-edge' | 'middle' | 'central' | 'after-edge' | 'text-after-edge' | 'ideographic' | 'alphabetic' | 'hanging' | 'mathematical'"]
and property_all = [%value.rec "'initial' | 'inherit' | 'unset' | 'revert'"]
and property_animation = [%value.rec "[ <single-animation> ]#"]
and property_animation_delay = [%value.rec "[ <extended-time> ]#"]
and property_animation_direction = [%value.rec "[ <single-animation-direction> ]#"]
and property_animation_duration = [%value.rec "[ <extended-time> ]#"]
and property_animation_fill_mode = [%value.rec "[ <single-animation-fill-mode> ]#"]
and property_animation_iteration_count = [%value.rec "[ <single-animation-iteration-count> ]#"]
and property_animation_name = [%value.rec "[ 'none' | <keyframes-name> ]#"]
and property_animation_play_state = [%value.rec "[ <single-animation-play-state> ]#"]
and property_animation_timing_function = [%value.rec "[ <timing-function> ]#"]
and property_appearance = [%value.rec "'none' | 'auto' | 'button' | 'textfield' | 'menulist-button' | <compat-auto>"]
and property_aspect_ratio = [%value.rec "'auto' | <ratio>"]
and property_azimuth = [%value.rec "<extended-angle> | [ 'left-side' | 'far-left' | 'left' | 'center-left' | 'center' | 'center-right' | 'right' | 'far-right' | 'right-side' ] || 'behind' | 'leftwards' | 'rightwards'"]
and property_backdrop_filter = [%value.rec "'none' | <filter-function-list>"]
and property_backface_visibility = [%value.rec "'visible' | 'hidden'"]
and property_background = [%value.rec "[ <bg-layer> ',' ]* <final-bg-layer>"]
and property_background_attachment = [%value.rec "[ <attachment> ]#"]
and property_background_blend_mode = [%value.rec "[ <blend-mode> ]#"]
and property_background_clip = [%value.rec "[ <box> ]#"]
and property_background_color = [%value.rec "<color>"]
and property_background_image = [%value.rec "[ <bg-image> ]#"]
and property_background_origin = [%value.rec "[ <box> ]#"]
and property_background_position = [%value.rec "[ <bg-position> ]#"]
and property_background_position_x = [%value.rec "[ 'center' | [ 'left' | 'right' | 'x-start' | 'x-end' ]? [ <extended-length> | <extended-percentage> ]? ]#"]
and property_background_position_y = [%value.rec "[ 'center' | [ 'top' | 'bottom' | 'y-start' | 'y-end' ]? [ <extended-length> | <extended-percentage> ]? ]#"]
and property_background_repeat = [%value.rec "[ <repeat-style> ]#"]
and property_background_size = [%value.rec "[ <bg-size> ]#"]
and property_baseline_shift = [%value.rec "'baseline' | 'sub' | 'super' | <svg-length>"]
and property_behavior = [%value.rec "[ <url> ]+"]
and property_block_overflow = [%value.rec "'clip' | 'ellipsis' | <string>"]
and property_block_size = [%value.rec "<'width'>"]
and property_border = [%value.rec "'none' | [ <line-width> | <interpolation> ] | [ <line-width> | <interpolation> ] [ <line-style> | <interpolation> ] | [ <line-width> | <interpolation> ] [ <line-style> | <interpolation> ] [ <color> | <interpolation> ]"]
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
and property_border_bottom_left_radius = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]
and property_border_bottom_right_radius = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]
and property_border_bottom_style = [%value.rec "<line-style>"]
and property_border_bottom_width = [%value.rec "<line-width>"]
and property_border_collapse = [%value.rec "'collapse' | 'separate'"]
and property_border_color = [%value.rec "[ <color> ]{1,4}"]
and property_border_end_end_radius = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]
and property_border_end_start_radius = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]
and property_border_image = [%value.rec "<'border-image-source'> || <'border-image-slice'> [ '/' <'border-image-width'> | '/' [ <'border-image-width'> ]? '/' <'border-image-outset'> ]? || <'border-image-repeat'>"]
and property_border_image_outset = [%value.rec "[ <extended-length> | <number> ]{1,4}"]
and property_border_image_repeat = [%value.rec "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}"]
and property_border_image_slice = [%value.rec "[ <number-percentage> ]{1,4} && [ 'fill' ]?"]
and property_border_image_source = [%value.rec "'none' | <image>"]
and property_border_image_width = [%value.rec "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}"]
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
and property_border_radius = [%value.rec "<extended-length> | <extended-percentage>"]
and property_border_right = [%value.rec "<'border'>"]
and property_border_right_color = [%value.rec "<color>"]
and property_border_right_style = [%value.rec "<line-style>"]
and property_border_right_width = [%value.rec "<line-width>"]
and property_border_spacing = [%value.rec "<extended-length> [ <extended-length> ]?"]
and property_border_start_end_radius = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]
and property_border_start_start_radius = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]
/* bs-css doesn't support list of styles, the original spec is: `[ <line-style> ]{1,4}` */
and property_border_style = [%value.rec "<line-style>"]
and property_border_top = [%value.rec "<'border'>"]
and property_border_top_color = [%value.rec "<color>"]
and property_border_top_left_radius = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]
and property_border_top_right_radius = [%value.rec "[ <extended-length> | <extended-percentage> ]{1,2}"]
and property_border_top_style = [%value.rec "<line-style>"]
and property_border_top_width = [%value.rec "<line-width>"]
and property_border_width = [%value.rec "[ <line-width> ]{1,4}"]
and property_bottom = [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]
and property_box_align = [%value.rec "'start' | 'center' | 'end' | 'baseline' | 'stretch'"]
and property_box_decoration_break = [%value.rec "'slice' | 'clone'"]
and property_box_direction = [%value.rec "'normal' | 'reverse' | 'inherit'"]
and property_box_flex = [%value.rec "<number>"]
and property_box_flex_group = [%value.rec "<integer>"]
and property_box_lines = [%value.rec "'single' | 'multiple'"]
and property_box_ordinal_group = [%value.rec "<integer>"]
and property_box_orient = [%value.rec "'horizontal' | 'vertical' | 'inline-axis' | 'block-axis' | 'inherit'"]
and property_box_pack = [%value.rec "'start' | 'center' | 'end' | 'justify'"]
and property_box_shadow = [%value.rec "'none' | [ <shadow> ]#"]
and property_box_sizing = [%value.rec "'content-box' | 'border-box'"]
and property_break_after = [%value.rec "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | 'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' | 'region'"]
and property_break_before = [%value.rec "'auto' | 'avoid' | 'always' | 'all' | 'avoid-page' | 'page' | 'left' | 'right' | 'recto' | 'verso' | 'avoid-column' | 'column' | 'avoid-region' | 'region'"]
and property_break_inside = [%value.rec "'auto' | 'avoid' | 'avoid-page' | 'avoid-column' | 'avoid-region'"]
and property_caption_side = [%value.rec "'top' | 'bottom' | 'block-start' | 'block-end' | 'inline-start' | 'inline-end'"]
and property_caret_color = [%value.rec "'auto' | <color>"]
and property_clear = [%value.rec "'none' | 'left' | 'right' | 'both' | 'inline-start' | 'inline-end'"]
and property_clip = [%value.rec "<shape> | 'auto'"]
and property_clip_path = [%value.rec "<clip-source> | <basic-shape> || <geometry-box> | 'none'"]
and property_clip_rule = [%value.rec "'nonzero' | 'evenodd'"]
and property_color = [%value.rec "<color>"]
and property_color_adjust = [%value.rec "'economy' | 'exact'"]
and property_column_count = [%value.rec "<integer> | 'auto'"]
and property_column_fill = [%value.rec "'auto' | 'balance' | 'balance-all'"]
and property_column_gap = [%value.rec "'normal' | <extended-length> | <extended-percentage>"]
and property_column_rule = [%value.rec "<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>"]
and property_column_rule_color = [%value.rec "<color>"]
and property_column_rule_style = [%value.rec "<'border-style'>"]
and property_column_rule_width = [%value.rec "<'border-width'>"]
and property_column_span = [%value.rec "'none' | 'all'"]
and property_column_width = [%value.rec "<extended-length> | 'auto'"]
and property_columns = [%value.rec "<'column-width'> || <'column-count'>"]
and property_contain = [%value.rec "'none' | 'strict' | 'content' | 'size' || 'layout' || 'style' || 'paint'"]
and property_content = [%value.rec "'normal' | 'none' | [ <content-replacement> | <content-list> ] [ '/' <string> ]?"]
and property_counter_increment = [%value.rec "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]
and property_counter_reset = [%value.rec "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]
and property_counter_set = [%value.rec "[ <custom-ident> [ <integer> ]? ]+ | 'none'"]
and property_cue = [%value.rec "<'cue-before'> [ <'cue-after'> ]?"]
and property_cue_after = [%value.rec "<url> [ <decibel> ]? | 'none'"]
and property_cue_before = [%value.rec "<url> [ <decibel> ]? | 'none'"]
and property_cursor = [%value.rec "[ <url> [ <x> <y> ]? ',' ]* [ 'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | 'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | 'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | 'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | 'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | 'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | 'zoom-out' | 'grab' | 'grabbing' | 'hand' | '-webkit-grab' | '-webkit-grabbing' | '-webkit-zoom-in' | '-webkit-zoom-out' | '-moz-grab' | '-moz-grabbing' | '-moz-zoom-in' | '-moz-zoom-out' ]"]
and property_direction = [%value.rec "'ltr' | 'rtl'"]
and property_display = [%value.rec "'block' | 'contents' | 'flex' | 'flow' | 'flow-root' | 'grid' | 'inline' | 'inline-block' | 'inline-flex' | 'inline-grid' | 'inline-list-item' | 'inline-table' | 'list-item' | 'none' | 'ruby' | 'ruby-base' | 'ruby-base-container' | 'ruby-text' | 'ruby-text-container' | 'run-in' | 'table' | 'table-caption' | 'table-cell' | 'table-column' | 'table-column-group' | 'table-footer-group' | 'table-header-group' | 'table-row' | 'table-row-group' | '-ms-flexbox' | '-ms-inline-flexbox' | '-ms-grid' | '-ms-inline-grid' | '-webkit-flex' | '-webkit-inline-flex' | '-webkit-box' | '-webkit-inline-box' | '-moz-inline-stack' | '-moz-box' | '-moz-inline-box'"]
and property_dominant_baseline = [%value.rec "'auto' | 'use-script' | 'no-change' | 'reset-size' | 'ideographic' | 'alphabetic' | 'hanging' | 'mathematical' | 'central' | 'middle' | 'text-after-edge' | 'text-before-edge'"]
and property_empty_cells = [%value.rec "'show' | 'hide'"]
and property_fill = [%value.rec "<paint>"]
and property_fill_opacity = [%value.rec "<alpha-value>"]
and property_fill_rule = [%value.rec "'nonzero' | 'evenodd'"]
and property_filter = [%value.rec "'none' | <filter-function-list> | <-ms-filter-function-list>"]
and property_flex = [%value.rec "'none' | <'flex-grow'> [ <'flex-shrink'> ]? || <'flex-basis'>"]
and property_flex_basis = [%value.rec "'content' | <'width'>"]
and property_flex_direction = [%value.rec "'row' | 'row-reverse' | 'column' | 'column-reverse'"]
and property_flex_flow = [%value.rec "<'flex-direction'> || <'flex-wrap'>"]
and property_flex_grow = [%value.rec "<number>"]
and property_flex_shrink = [%value.rec "<number>"]
and property_flex_wrap = [%value.rec "'nowrap' | 'wrap' | 'wrap-reverse'"]
and property_float = [%value.rec "'left' | 'right' | 'none' | 'inline-start' | 'inline-end'"]
and property_font = [%value.rec "[ <'font-style'> || <font-variant-css21> || <'font-weight'> || <'font-stretch'> ]? <'font-size'> [ '/' <'line-height'> ]? <'font-family'> | 'caption' | 'icon' | 'menu' | 'message-box' | 'small-caption' | 'status-bar'"]
and property_font_family = [%value.rec "[ <family-name> | <generic-family> ]#"]
and property_font_feature_settings = [%value.rec "'normal' | [ <feature-tag-value> ]#"]
and property_font_kerning = [%value.rec "'auto' | 'normal' | 'none'"]
and property_font_language_override = [%value.rec "'normal' | <string>"]
and property_font_optical_sizing = [%value.rec "'auto' | 'none'"]
and property_font_size = [%value.rec "<absolute-size> | <relative-size> | <extended-length> | <extended-percentage>"]
and property_font_size_adjust = [%value.rec "'none' | <number>"]
and property_font_smooth = [%value.rec "'auto' | 'never' | 'always' | <absolute-size> | <extended-length>"]
and property_font_stretch = [%value.rec "<font-stretch-absolute>"]
and property_font_style = [%value.rec "'normal' | 'italic' | 'oblique' [ <extended-angle> ]?"]
and property_font_synthesis = [%value.rec "'none' | 'weight' || 'style'"]
and property_font_variant = [%value.rec "'normal' | 'none' | <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic( <feature-value-name> ) || 'historical-forms' || styleset( [ <feature-value-name> ]# ) || character-variant( [ <feature-value-name> ]# ) || swash( <feature-value-name> ) || ornaments( <feature-value-name> ) || annotation( <feature-value-name> ) || [ 'small-caps' | 'all-small-caps' | 'petite-caps' | 'all-petite-caps' | 'unicase' | 'titling-caps' ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || 'ordinal' || 'slashed-zero' || <east-asian-variant-values> || <east-asian-width-values> || 'ruby'"]
and property_font_variant_alternates = [%value.rec "'normal' | stylistic( <feature-value-name> ) || 'historical-forms' || styleset( [ <feature-value-name> ]# ) || character-variant( [ <feature-value-name> ]# ) || swash( <feature-value-name> ) || ornaments( <feature-value-name> ) || annotation( <feature-value-name> )"]
and property_font_variant_caps = [%value.rec "'normal' | 'small-caps' | 'all-small-caps' | 'petite-caps' | 'all-petite-caps' | 'unicase' | 'titling-caps'"]
and property_font_variant_east_asian = [%value.rec "'normal' | <east-asian-variant-values> || <east-asian-width-values> || 'ruby'"]
and property_font_variant_ligatures = [%value.rec "'normal' | 'none' | <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values>"]
and property_font_variant_numeric = [%value.rec "'normal' | <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || 'ordinal' || 'slashed-zero'"]
and property_font_variant_position = [%value.rec "'normal' | 'sub' | 'super'"]
and property_font_variation_settings = [%value.rec "'normal' | [ <string> <number> ]#"]
and property_font_weight = [%value.rec "<font-weight-absolute> | 'bolder' | 'lighter'"]
and property_gap = [%value.rec "<'row-gap'> [ <'column-gap'> ]?"]
and property_glyph_orientation_horizontal = [%value.rec "<extended-angle>"]
and property_glyph_orientation_vertical = [%value.rec "<extended-angle>"]
and property_grid = [%value.rec "<'grid-template'> | <'grid-template-rows'> '/' [ 'auto-flow' && [ 'dense' ]? ] [ <'grid-auto-columns'> ]? | [ 'auto-flow' && [ 'dense' ]? ] [ <'grid-auto-rows'> ]? '/' <'grid-template-columns'>"]
and property_grid_area = [%value.rec "<grid-line> [ '/' <grid-line> ]{0,3}"]
and property_grid_auto_columns = [%value.rec "[ <track-size> ]+"]
and property_grid_auto_flow = [%value.rec "[ 'row' | 'column' ] || 'dense'"]
and property_grid_auto_rows = [%value.rec "[ <track-size> ]+"]
and property_grid_column = [%value.rec "<grid-line> [ '/' <grid-line> ]?"]
and property_grid_column_end = [%value.rec "<grid-line>"]
and property_grid_column_gap = [%value.rec "<extended-length> | <extended-percentage>"]
and property_grid_column_start = [%value.rec "<grid-line>"]
and property_grid_gap = [%value.rec "<'grid-row-gap'> [ <'grid-column-gap'> ]?"]
and property_grid_row = [%value.rec "<grid-line> [ '/' <grid-line> ]?"]
and property_grid_row_end = [%value.rec "<grid-line>"]
and property_grid_row_gap = [%value.rec "<extended-length> | <extended-percentage>"]
and property_grid_row_start = [%value.rec "<grid-line>"]
and property_grid_template = [%value.rec "'none' | <'grid-template-rows'> '/' <'grid-template-columns'> | [ [ <line-names> ]? <string> [ <track-size> ]? [ <line-names> ]? ]+ [ '/' <explicit-track-list> ]?"]
and property_grid_template_areas = [%value.rec "'none' | [ <string> ]+"]
and property_grid_template_columns = [%value.rec "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]?"]
and property_grid_template_rows = [%value.rec "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]?"]
and property_hanging_punctuation = [%value.rec "'none' | 'first' || [ 'force-end' | 'allow-end' ] || 'last'"]
and property_height = [%value.rec "'auto' | <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"]
and property_hyphens = [%value.rec "'none' | 'manual' | 'auto'"]
and property_image_orientation = [%value.rec "'from-image' | <extended-angle> | [ <extended-angle> ]? 'flip'"]
and property_image_rendering = [%value.rec "'auto' | 'crisp-edges' | 'pixelated' | 'optimizeSpeed' | 'optimizeQuality' | <-non-standard-image-rendering>"]
and property_image_resolution = [%value.rec "[ 'from-image' || <resolution> ] && [ 'snap' ]?"]
and property_ime_mode = [%value.rec "'auto' | 'normal' | 'active' | 'inactive' | 'disabled'"]
and property_initial_letter = [%value.rec "'normal' | <number> [ <integer> ]?"]
and property_initial_letter_align = [%value.rec "'auto' | 'alphabetic' | 'hanging' | 'ideographic'"]
and property_inline_size = [%value.rec "<'width'>"]
and property_inset = [%value.rec "[ <'top'> ]{1,4}"]
and property_inset_block = [%value.rec "[ <'top'> ]{1,2}"]
and property_inset_block_end = [%value.rec "<'top'>"]
and property_inset_block_start = [%value.rec "<'top'>"]
and property_inset_inline = [%value.rec "[ <'top'> ]{1,2}"]
and property_inset_inline_end = [%value.rec "<'top'>"]
and property_inset_inline_start = [%value.rec "<'top'>"]
and property_isolation = [%value.rec "'auto' | 'isolate'"]
and property_justify_content = [%value.rec "'normal' | <content-distribution> | [ <overflow-position> ]? [ <content-position> | 'left' | 'right' ]"]
and property_justify_items = [%value.rec "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? [ <self-position> | 'left' | 'right' ] | 'legacy' | 'legacy' && [ 'left' | 'right' | 'center' ]"]
and property_justify_self = [%value.rec "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? [ <self-position> | 'left' | 'right' ]"]
and property_kerning = [%value.rec "'auto' | <svg-length>"]
and property_left = [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]
and property_letter_spacing = [%value.rec "'normal' | <extended-length> | <extended-percentage>"]
and property_line_break = [%value.rec "'auto' | 'loose' | 'normal' | 'strict' | 'anywhere'"]
and property_line_clamp = [%value.rec "'none' | <integer>"]
and property_line_height = [%value.rec "'normal' | <number> | <extended-length> | <extended-percentage>" ]
and property_line_height_step = [%value.rec "<extended-length>"]
and property_list_style = [%value.rec "<'list-style-type'> || <'list-style-position'> || <'list-style-image'>"]
and property_list_style_image = [%value.rec "<url> | 'none'"]
and property_list_style_position = [%value.rec "'inside' | 'outside'"]
and property_list_style_type = [%value.rec "<counter-style> | <string> | 'none'"]
and property_margin = [%value.rec "[ <extended-length> | <extended-percentage> | 'auto' | <interpolation> ]{1,4}"]
and property_margin_block = [%value.rec "[ <'margin-left'> ]{1,2}"]
and property_margin_block_end = [%value.rec "<'margin-left'>"]
and property_margin_block_start = [%value.rec "<'margin-left'>"]
and property_margin_bottom = [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]
and property_margin_inline = [%value.rec "[ <'margin-left'> ]{1,2}"]
and property_margin_inline_end = [%value.rec "<'margin-left'>"]
and property_margin_inline_start = [%value.rec "<'margin-left'>"]
and property_margin_left = [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]
and property_margin_right = [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]
and property_margin_top = [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]
and property_margin_trim = [%value.rec "'none' | 'in-flow' | 'all'"]
and property_marker = [%value.rec "'none' | <url>"]
and property_marker_end = [%value.rec "'none' | <url>"]
and property_marker_mid = [%value.rec "'none' | <url>"]
and property_marker_start = [%value.rec "'none' | <url>"]
and property_mask = [%value.rec "[ <mask-layer> ]#"]
and property_mask_border = [%value.rec "<'mask-border-source'> || <'mask-border-slice'> [ '/' [ <'mask-border-width'> ]? [ '/' <'mask-border-outset'> ]? ]? || <'mask-border-repeat'> || <'mask-border-mode'>"]
and property_mask_border_mode = [%value.rec "'luminance' | 'alpha'"]
and property_mask_border_outset = [%value.rec "[ <extended-length> | <number> ]{1,4}"]
and property_mask_border_repeat = [%value.rec "[ 'stretch' | 'repeat' | 'round' | 'space' ]{1,2}"]
and property_mask_border_slice = [%value.rec "[ <number-percentage> ]{1,4} [ 'fill' ]?"]
and property_mask_border_source = [%value.rec "'none' | <image>"]
and property_mask_border_width = [%value.rec "[ <extended-length> | <extended-percentage> | <number> | 'auto' ]{1,4}"]
and property_mask_clip = [%value.rec "[ <geometry-box> | 'no-clip' ]#"]
and property_mask_composite = [%value.rec "[ <compositing-operator> ]#"]
and property_mask_image = [%value.rec "[ <mask-reference> ]#"]
and property_mask_mode = [%value.rec "[ <masking-mode> ]#"]
and property_mask_origin = [%value.rec "[ <geometry-box> ]#"]
and property_mask_position = [%value.rec "[ <position> ]#"]
and property_mask_repeat = [%value.rec "[ <repeat-style> ]#"]
and property_mask_size = [%value.rec "[ <bg-size> ]#"]
and property_mask_type = [%value.rec "'luminance' | 'alpha'"]
and property_max_block_size = [%value.rec "<'max-width'>"]
and property_max_height = [%value.rec "'auto' | <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"]
and property_max_inline_size = [%value.rec "<'max-width'>"]
and property_max_lines = [%value.rec "'none' | <integer>"]
and property_max_width = [%value.rec "<extended-length> | <extended-percentage> | 'none' | 'max-content' | 'min-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> ) | 'fill-available' | <-non-standard-width>"]
and property_min_block_size = [%value.rec "<'min-width'>"]
and property_min_height = [%value.rec "'auto' | <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"]
and property_min_inline_size = [%value.rec "<'min-width'>"]
and property_min_width = [%value.rec "<extended-length> | <extended-percentage> | 'auto' | 'max-content' | 'min-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> ) | 'fill-available' | <-non-standard-width>"]
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
and property_media_display_mode = [%value.rec "'fullscreen' | 'standalone' | 'minimal-ui' | 'browser'"]
and property_media_forced_colors = [%value.rec "'none' | 'active'"]
and property_media_grid = [%value.rec "<integer>"]
and property_media_hover = [%value.rec "'hover' | 'none'"]
and property_media_inverted_colors = [%value.rec "'inverted' | 'none'"]
and property_media_monochrome = [%value.rec "<integer>"]
and property_media_prefers_color_scheme = [%value.rec "'dark' | 'light'"]
and property_media_prefers_contrast = [%value.rec "'no-preference' | 'more' | 'less'"]
and property_media_prefers_reduced_motion = [%value.rec "'no-preference' | 'reduce'"]
and property_media_resolution = [%value.rec "<resolution>"]
and property_media_min_resolution = [%value.rec "<resolution>"]
and property_media_max_resolution = [%value.rec "<resolution>"]
and property_media_scripting = [%value.rec "'none' | 'initial-only' | 'enabled'"]
and property_media_update = [%value.rec "'none' | 'slow' | 'fast'"]
and property_media_orientation = [%value.rec "'portrait' | 'landscape'"]
and property_object_fit = [%value.rec "'fill' | 'contain' | 'cover' | 'none' | 'scale-down'"]
and property_object_position = [%value.rec "<position>"]
and property_offset = [%value.rec "[ [ <'offset-position'> ]? <'offset-path'> [ <'offset-distance'> || <'offset-rotate'> ]? ]? [ '/' <'offset-anchor'> ]?"]
and property_offset_anchor = [%value.rec "'auto' | <position>"]
and property_offset_distance = [%value.rec "<extended-length> | <extended-percentage>"]
and property_offset_path = [%value.rec "'none' | ray( <extended-angle> && [ <size> ]? && [ 'contain' ]? ) | <path()> | <url> | <basic-shape> || <geometry-box>"]
and property_offset_position = [%value.rec "'auto' | <position>"]
and property_offset_rotate = [%value.rec "[ 'auto' | 'reverse' ] || <extended-angle>"]
and property_opacity = [%value.rec "<alpha-value>"]
and property_order = [%value.rec "<integer>"]
and property_orphans = [%value.rec "<integer>"]
and property_outline = [%value.rec "'none' | <'outline-width'> | [ <'outline-width'> <'outline-style'> ] | [ <'outline-width'> <'outline-style'> [ <color> | <interpolation> ]]"]
and property_outline_color = [%value.rec "<color>"]
and property_outline_offset = [%value.rec "<extended-length>"]
and property_outline_style = [%value.rec "'auto' | <line-style> | <interpolation>"]
and property_outline_width = [%value.rec "<line-width> | <interpolation>"]
and property_overflow = [%value.rec "[ 'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' ]{1,2} | <-non-standard-overflow>"]
and property_overflow_anchor = [%value.rec "'auto' | 'none'"]
and property_overflow_block = [%value.rec "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto'"]
and property_overflow_clip_box = [%value.rec "'padding-box' | 'content-box'"]
and property_overflow_inline = [%value.rec "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto' | 'none | 'optional-paged' | 'paged'"]
and property_overflow_wrap = [%value.rec "'normal' | 'break-word' | 'anywhere'"]
and property_overflow_x = [%value.rec "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto'"]
and property_overflow_y = [%value.rec "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto'"]
and property_overscroll_behavior = [%value.rec "[ 'contain' | 'none' | 'auto' ]{1,2}"]
and property_overscroll_behavior_block = [%value.rec "'contain' | 'none' | 'auto'"]
and property_overscroll_behavior_inline = [%value.rec "'contain' | 'none' | 'auto'"]
and property_overscroll_behavior_x = [%value.rec "'contain' | 'none' | 'auto'"]
and property_overscroll_behavior_y = [%value.rec "'contain' | 'none' | 'auto'"]
and property_padding = [%value.rec "[ <extended-length> | <extended-percentage> | <interpolation> ]{1,4}"]
and property_padding_block = [%value.rec "[ <'padding-left'> ]{1,2}"]
and property_padding_block_end = [%value.rec "<'padding-left'>"]
and property_padding_block_start = [%value.rec "<'padding-left'>"]
and property_padding_bottom = [%value.rec "<extended-length> | <extended-percentage>"]
and property_padding_inline = [%value.rec "[ <'padding-left'> ]{1,2}"]
and property_padding_inline_end = [%value.rec "<'padding-left'>"]
and property_padding_inline_start = [%value.rec "<'padding-left'>"]
and property_padding_left = [%value.rec "<extended-length> | <extended-percentage>"]
and property_padding_right = [%value.rec "<extended-length> | <extended-percentage>"]
and property_padding_top = [%value.rec "<extended-length> | <extended-percentage>"]
and property_page_break_after = [%value.rec "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'"]
and property_page_break_before = [%value.rec "'auto' | 'always' | 'avoid' | 'left' | 'right' | 'recto' | 'verso'"]
and property_page_break_inside = [%value.rec "'auto' | 'avoid'"]
and property_paint_order = [%value.rec "'normal' | 'fill' || 'stroke' || 'markers'"]
and property_pause = [%value.rec "<'pause-before'> [ <'pause-after'> ]?"]
and property_pause_after = [%value.rec "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | 'x-strong'"]
and property_pause_before = [%value.rec "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | 'x-strong'"]
and property_perspective = [%value.rec "'none' | <extended-length>"]
and property_perspective_origin = [%value.rec "<position>"]
and property_place_content = [%value.rec "<'align-content'> [ <'justify-content'> ]?"]
and property_place_items = [%value.rec "<'align-items'> [ <'justify-items'> ]?"]
and property_place_self = [%value.rec "<'align-self'> [ <'justify-self'> ]?"]
and property_pointer_events = [%value.rec "'auto' | 'none' | 'visiblePainted' | 'visibleFill' | 'visibleStroke' | 'visible' | 'painted' | 'fill' | 'stroke' | 'all' | 'inherit'"]
and property_position = [%value.rec "'static' | 'relative' | 'absolute' | 'sticky' | 'fixed' | '-webkit-sticky'"]
and property_quotes = [%value.rec "'none' | 'auto' | [ <string> <string> ]+"]
and property_resize = [%value.rec "'none' | 'both' | 'horizontal' | 'vertical' | 'block' | 'inline'"]
and property_rest = [%value.rec "<'rest-before'> [ <'rest-after'> ]?"]
and property_rest_after = [%value.rec "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | 'x-strong'"]
and property_rest_before = [%value.rec "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | 'x-strong'"]
and property_right = [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]
and property_rotate = [%value.rec "'none' | <extended-angle> | [ 'x' | 'y' | 'z' | [ <number> ]{3} ] && <extended-angle>"]
and property_row_gap = [%value.rec "'normal' | <extended-length> | <extended-percentage>"]
and property_ruby_align = [%value.rec "'start' | 'center' | 'space-between' | 'space-around'"]
and property_ruby_merge = [%value.rec "'separate' | 'collapse' | 'auto'"]
and property_ruby_position = [%value.rec "'over' | 'under' | 'inter-character'"]
and property_scale = [%value.rec "'none' | [ <number> ]{1,3}"]
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
and property_scroll_padding = [%value.rec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,4}"]
and property_scroll_padding_block = [%value.rec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]
and property_scroll_padding_block_end = [%value.rec "'auto' | <extended-length> | <extended-percentage>"]
and property_scroll_padding_block_start = [%value.rec "'auto' | <extended-length> | <extended-percentage>"]
and property_scroll_padding_bottom = [%value.rec "'auto' | <extended-length> | <extended-percentage>"]
and property_scroll_padding_inline = [%value.rec "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}"]
and property_scroll_padding_inline_end = [%value.rec "'auto' | <extended-length> | <extended-percentage>"]
and property_scroll_padding_inline_start = [%value.rec "'auto' | <extended-length> | <extended-percentage>"]
and property_scroll_padding_left = [%value.rec "'auto' | <extended-length> | <extended-percentage>"]
and property_scroll_padding_right = [%value.rec "'auto' | <extended-length> | <extended-percentage>"]
and property_scroll_padding_top = [%value.rec "'auto' | <extended-length> | <extended-percentage>"]
and property_scroll_snap_align = [%value.rec "[ 'none' | 'start' | 'end' | 'center' ]{1,2}"]
and property_scroll_snap_coordinate = [%value.rec "'none' | [ <position> ]#"]
and property_scroll_snap_destination = [%value.rec "<position>"]
and property_scroll_snap_points_x = [%value.rec "'none' | repeat( <extended-length> | <extended-percentage> )"]
and property_scroll_snap_points_y = [%value.rec "'none' | repeat( <extended-length> | <extended-percentage> )"]
and property_scroll_snap_stop = [%value.rec "'normal' | 'always'"]
and property_scroll_snap_type = [%value.rec "'none' | [ 'x' | 'y' | 'block' | 'inline' | 'both' ] [ 'mandatory' | 'proximity' ]?"]
and property_scroll_snap_type_x = [%value.rec "'none' | 'mandatory' | 'proximity'"]
and property_scroll_snap_type_y = [%value.rec "'none' | 'mandatory' | 'proximity'"]
and property_scrollbar_color = [%value.rec "'auto' | 'dark' | 'light' | [ <color> ]{2}"]
and property_scrollbar_width = [%value.rec "'auto' | 'thin' | 'none'"]
and property_shape_image_threshold = [%value.rec "<alpha-value>"]
and property_shape_margin = [%value.rec "<extended-length> | <extended-percentage>"]
and property_shape_outside = [%value.rec "'none' | <shape-box> || <basic-shape> | <image>"]
and property_shape_rendering = [%value.rec "'auto' | 'optimizeSpeed' | 'crispEdges' | 'geometricPrecision'"]
and property_speak = [%value.rec "'auto' | 'none' | 'normal'"]
and property_speak_as = [%value.rec "'normal' | 'spell-out' || 'digits' || [ 'literal-punctuation' | 'no-punctuation' ]"]
and property_src = [%value.rec "[ <url> [ format( [ <string> ]# ) ]? | local( <family-name> ) ]#"]
and property_stroke = [%value.rec "<paint>"]
and property_stroke_dasharray = [%value.rec "'none' | [ [ <svg-length> ]+ ]#"]
and property_stroke_dashoffset = [%value.rec "<svg-length>"]
and property_stroke_linecap = [%value.rec "'butt' | 'round' | 'square'"]
and property_stroke_linejoin = [%value.rec "'miter' | 'round' | 'bevel'"]
and property_stroke_miterlimit = [%value.rec "<number-one-or-greater>"]
and property_stroke_opacity = [%value.rec "<alpha-value>"]
and property_stroke_width = [%value.rec "<svg-length>"]
and property_tab_size = [%value.rec "<integer> | <extended-length>"]
and property_table_layout = [%value.rec "'auto' | 'fixed'"]
and property_text_align = [%value.rec "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent'"]
and property_text_align_last = [%value.rec "'auto' | 'start' | 'end' | 'left' | 'right' | 'center' | 'justify'"]
and property_text_anchor = [%value.rec "'start' | 'middle' | 'end'"]
and property_text_combine_upright = [%value.rec "'none' | 'all' | 'digits' [ <integer> ]?"]
and property_text_decoration = [%value.rec "<'text-decoration-line'> || <'text-decoration-style'> || <'text-decoration-color'> || <'text-decoration-thickness'>"]
and property_text_decoration_color = [%value.rec "<color>"]
and property_text_decoration_line = [%value.rec "'none' | 'underline' || 'overline' || 'line-through' || 'blink' | 'spelling-error' | 'grammar-error'"]
and property_text_decoration_skip = [%value.rec "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] || 'edges' || 'box-decoration'"]
and property_text_decoration_skip_ink = [%value.rec "'auto' | 'all' | 'none'"]
and property_text_decoration_style = [%value.rec "'solid' | 'double' | 'dotted' | 'dashed' | 'wavy'"]
and property_text_decoration_thickness = [%value.rec "'auto' | 'from-font' | <extended-length> | <extended-percentage>"]
and property_text_emphasis = [%value.rec "<'text-emphasis-style'> || <'text-emphasis-color'>"]
and property_text_emphasis_color = [%value.rec "<color>"]
and property_text_emphasis_position = [%value.rec "[ 'over' | 'under' ] && [ 'right' | 'left' ]"]
and property_text_emphasis_style = [%value.rec "'none' | [ 'filled' | 'open' ] || [ 'dot' | 'circle' | 'double-circle' | 'triangle' | 'sesame' ] | <string>"]
and property_text_indent = [%value.rec "[<extended-length> | <extended-percentage>] && [ 'hanging' ]? && [ 'each-line' ]?"]
and property_text_justify = [%value.rec "'auto' | 'inter-character' | 'inter-word' | 'none'"]
and property_text_orientation = [%value.rec "'mixed' | 'upright' | 'sideways'"]
and property_text_overflow = [%value.rec "[ 'clip' | 'ellipsis' | <string> ]{1,2}"]
and property_text_rendering = [%value.rec "'auto' | 'optimizeSpeed' | 'optimizeLegibility' | 'geometricPrecision'"]
and property_text_shadow = [%value.rec "'none' | [ <shadow-t> ]#"]
and property_text_size_adjust = [%value.rec "'none' | 'auto' | <extended-percentage>"]
and property_text_transform = [%value.rec "'none' | 'capitalize' | 'uppercase' | 'lowercase' | 'full-width' | 'full-size-kana'"]
and property_text_underline_offset = [%value.rec "'auto' | <extended-length> | <extended-percentage>"]
and property_text_underline_position = [%value.rec "'auto' | 'from-font' | 'under' || [ 'left' | 'right' ]"]
and property_top = [%value.rec "<extended-length> | <extended-percentage> | 'auto'"]
and property_touch_action = [%value.rec "'auto' | 'none' | [ 'pan-x' | 'pan-left' | 'pan-right' ] || [ 'pan-y' | 'pan-up' | 'pan-down' ] || 'pinch-zoom' | 'manipulation'"]
and property_transform = [%value.rec "'none' | <transform-list>"]
and property_transform_box = [%value.rec "'content-box' | 'border-box' | 'fill-box' | 'stroke-box' | 'view-box'"]
and property_transform_origin = [%value.rec "<extended-length> | <extended-percentage> | 'left' | 'center' | 'right' | 'top' | 'bottom' | [ [ <extended-length> | <extended-percentage> | 'left' | 'center' | 'right' ] && [ <extended-length> | <extended-percentage> | 'top' | 'center' | 'bottom' ] ] [ <extended-length> ]?"]
and property_transform_style = [%value.rec "'flat' | 'preserve-3d'"]
and property_transition = [%value.rec "[ <single-transition> ]#"]
and property_transition_delay = [%value.rec "[ <extended-time> ]#"]
and property_transition_duration = [%value.rec "[ <extended-time> ]#"]
and property_transition_property = [%value.rec "'none' | [ <single-transition-property> ]#"]
and property_transition_timing_function = [%value.rec "[ <timing-function> ]#"]
and property_translate = [%value.rec "'none' | <extended-length> | <extended-percentage> [ <extended-length> | <extended-percentage> [ <extended-length> ]? ]?"]
and property_unicode_bidi = [%value.rec "'normal' | 'embed' | 'isolate' | 'bidi-override' | 'isolate-override' | 'plaintext' | '-moz-isolate' | '-moz-isolate-override' | '-moz-plaintext' | '-webkit-isolate'"]
and property_unicode_range = [%value.rec "[ <urange> ]#"]
and property_user_select = [%value.rec "'auto' | 'text' | 'none' | 'contain' | 'all'"]
and property_vertical_align = [%value.rec "'baseline' | 'sub' | 'super' | 'text-top' | 'text-bottom' | 'middle' | 'top' | 'bottom' | <extended-percentage> | <extended-length>"]
and property_visibility = [%value.rec "'visible' | 'hidden' | 'collapse'"]
and property_voice_balance = [%value.rec "<number> | 'left' | 'center' | 'right' | 'leftwards' | 'rightwards'"]
and property_voice_duration = [%value.rec "'auto' | <extended-time>"]
and property_voice_family = [%value.rec "[ [ <family-name> | <generic-voice> ] ',' ]* [ <family-name> | <generic-voice> ] | 'preserve'"]
and property_voice_pitch = [%value.rec "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | 'high' | 'x-high' ] || [ <extended-frequency> | <semitones> | <extended-percentage> ]"]
and property_voice_range = [%value.rec "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | 'high' | 'x-high' ] || [ <extended-frequency> | <semitones> | <extended-percentage> ]"]
and property_voice_rate = [%value.rec "[ 'normal' | 'x-slow' | 'slow' | 'medium' | 'fast' | 'x-fast' ] || <extended-percentage>"]
and property_voice_stress = [%value.rec "'normal' | 'strong' | 'moderate' | 'none' | 'reduced'"]
and property_voice_volume = [%value.rec "'silent' | [ 'x-soft' | 'soft' | 'medium' | 'loud' | 'x-loud' ] || <decibel>"]
and property_white_space = [%value.rec "'normal' | 'pre' | 'nowrap' | 'pre-wrap' | 'pre-line' | 'break-spaces'"]
and property_widows = [%value.rec "<integer>"]
and property_width = [%value.rec "'auto' | <extended-length> | <extended-percentage> | 'min-content' | 'max-content' | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"]
and property_will_change = [%value.rec "'auto' | [ <animateable-feature> ]#"]
and property_word_break = [%value.rec "'normal' | 'break-all' | 'keep-all' | 'break-word'"]
and property_word_spacing = [%value.rec "'normal' | <extended-length> | <extended-percentage>"]
and property_word_wrap = [%value.rec "'normal' | 'break-word' | 'anywhere'"]
and property_writing_mode = [%value.rec "'horizontal-tb' | 'vertical-rl' | 'vertical-lr' | 'sideways-rl' | 'sideways-lr' | <svg-writing-mode>"]
and property_z_index = [%value.rec "'auto' | <integer>"]
and property_zoom = [%value.rec "'normal' | 'reset' | <number> | <extended-percentage>"]
and pseudo_class_selector = [%value.rec "':' <ident-token> | ':' <function-token> <any-value> ')'"]
and pseudo_element_selector = [%value.rec "':' <pseudo-class-selector>"]
and pseudo_page = [%value.rec "':' [ 'left' | 'right' | 'first' | 'blank' ]"]
and quote = [%value.rec "'open-quote' | 'close-quote' | 'no-open-quote' | 'no-close-quote'"]
and ratio = [%value.rec "<integer> '/' <integer> | <integer>"]
and relative_selector = [%value.rec "[ <combinator> ]? <complex-selector>"]
and relative_selector_list = [%value.rec "[ <relative-selector> ]#"]
and relative_size = [%value.rec "'larger' | 'smaller'"]
and repeat_style = [%value.rec "'repeat-x' | 'repeat-y' | [ 'repeat' | 'space' | 'round' | 'no-repeat' ]{1,2}"]
and right = [%value.rec "<extended-length> | 'auto'"]
and self_position = [%value.rec "'center' | 'start' | 'end' | 'self-start' | 'self-end' | 'flex-start' | 'flex-end'"]
and shadow = [%value.rec "[ 'inset' ]? [ <extended-length> | <interpolation> ]{4} [ <color> | <interpolation> ]?"]
and shadow_t = [%value.rec "[ <extended-length> | <interpolation> ]{3} [ <color> | <interpolation> ]?"]
and shape = [%value.rec "rect( <top> ',' <right> ',' <bottom> ',' <left> ) | rect( <top> <right> <bottom> <left> )"]
and shape_box = [%value.rec "<box> | 'margin-box'"]
and shape_radius = [%value.rec "<extended-length> | <extended-percentage> | 'closest-side' | 'farthest-side'"]
and side_or_corner = [%value.rec "[ 'left' | 'right' ] || [ 'top' | 'bottom' ]"]
and single_animation = [%value.rec "<extended-time> || <timing-function> || <extended-time> || <single-animation-iteration-count> || <single-animation-direction> || <single-animation-fill-mode> || <single-animation-play-state> || [ 'none' | <keyframes-name> ]"]
and single_animation_direction = [%value.rec "'normal' | 'reverse' | 'alternate' | 'alternate-reverse'"]
and single_animation_fill_mode = [%value.rec "'none' | 'forwards' | 'backwards' | 'both'"]
and single_animation_iteration_count = [%value.rec "'infinite' | <number>"]
and single_animation_play_state = [%value.rec "'running' | 'paused'"]
and single_transition = [%value.rec "[ 'none' | <single-transition-property> ] || <extended-time> || <timing-function> || <extended-time>"]
and single_transition_property = [%value.rec "'all' | <custom-ident>"]
and size = [%value.rec "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | <extended-length> | [ <extended-length> | <extended-percentage> ]{2}"]
and step_position = [%value.rec "'jump-start' | 'jump-end' | 'jump-none' | 'jump-both' | 'start' | 'end'"]
and step_timing_function = [%value.rec "'step-start' | 'step-end' | steps( <integer> [ ',' <step-position> ]? )"]
and subclass_selector = [%value.rec "<id-selector> | <class-selector> | <attribute-selector> | <pseudo-class-selector>"]
and supports_condition = [%value.rec "'not' <supports-in-parens> | <supports-in-parens> [ 'and' <supports-in-parens> ]* | <supports-in-parens> [ 'or' <supports-in-parens> ]*"]
and supports_decl = [%value.rec "'(' <declaration> ')'"]
and supports_feature = [%value.rec "<supports-decl> | <supports-selector-fn>"]
and supports_in_parens = [%value.rec "'(' <supports-condition> ')' | <supports-feature> | <general-enclosed>"]
and supports_selector_fn = [%value.rec "selector( <complex-selector> )"]
and svg_length = [%value.rec "<extended-percentage> | <extended-length> | <number>"]
and svg_writing_mode = [%value.rec "'lr-tb' | 'rl-tb' | 'tb-rl' | 'lr' | 'rl' | 'tb'"]
and symbol = [%value.rec "<string> | <image> | <custom-ident>"]
and target = [%value.rec "<target-counter()> | <target-counters()> | <target-text()>"]
and extended_length = [%value.rec "<length> | <calc()> | <interpolation>"]
and extended_frequency = [%value.rec "<frequency> | <calc()> | <interpolation>"]
and extended_angle = [%value.rec "<angle> | <calc()> | <interpolation>"]
and extended_time = [%value.rec "<time> | <calc()> | <interpolation>"]
and extended_percentage = [%value.rec "<percentage> | <calc()> | <interpolation>"]
and timing_function = [%value.rec "'linear' | <cubic-bezier-timing-function> | <step-timing-function>"]
and top = [%value.rec "<extended-length> | 'auto'"]
and track_breadth = [%value.rec "<extended-length> | <extended-percentage> | <flex-value> | 'min-content' | 'max-content' | 'auto'"]
and track_group = [%value.rec "'(' [ [ <string> ]* <track-minmax> [ <string> ]* ]+ ')' [ '[' <positive-integer> ']' ]? | <track-minmax>"]
and track_list = [%value.rec "[ [ <line-names> ]? [ <track-size> | <track-repeat> ] ]+ [ <line-names> ]?"]
and track_list_v0 = [%value.rec "[ [ <string> ]* <track-group> [ <string> ]* ]+ | 'none'"]
and track_minmax = [%value.rec "minmax( <track-breadth> ',' <track-breadth> ) | 'auto' | <track-breadth> | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"]
and track_repeat = [%value.rec "repeat( <positive-integer> ',' [ [ <line-names> ]? <track-size> ]+ [ <line-names> ]? )"]
and track_size = [%value.rec "<track-breadth> | minmax( <inflexible-breadth> ',' <track-breadth> ) | 'fit-content' | fit-content( <extended-length> | <extended-percentage> )"]
and transform_function = [%value.rec "<matrix()> | <translate()> | <translateX()> | <translateY()> | <scale()> | <scaleX()> | <scaleY()> | <rotate()> | <skew()> | <skewX()> | <skewY()> | <matrix3d()> | <translate3d()> | <translateZ()> | <scale3d()> | <scaleZ()> | <rotate3d()> | <rotateX()> | <rotateY()> | <rotateZ()> | <perspective()>"]
and transform_list = [%value.rec "[ <transform-function> ]+"]
and type_or_unit = [%value.rec "'string' | 'color' | 'url' | 'integer' | 'number' | 'length' | 'angle' | 'time' | 'frequency' | 'cap' | 'ch' | 'em' | 'ex' | 'ic' | 'lh' | 'rlh' | 'rem' | 'vb' | 'vi' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'mm' | 'Q' | 'cm' | 'in' | 'pt' | 'pc' | 'px' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | 's' | 'Hz' | 'kHz' | '%'"]
and type_selector = [%value.rec "<wq-name> | [ <ns-prefix> ]? '*'"]
and viewport_length = [%value.rec "'auto' | <extended-length> | <extended-percentage>"]
and wq_name = [%value.rec "[ <ns-prefix> ]? <ident-token>"]
and x = [%value.rec "<number>"]
and y = [%value.rec "<number>"];

let check_map =
  StringMap.of_seq(
    List.to_seq([
      ("-legacy-gradient", check(_legacy_gradient)),
      ("-legacy-linear-gradient", check(_legacy_linear_gradient)),
      (
        "-legacy-linear-gradient-arguments",
        check(_legacy_linear_gradient_arguments),
      ),
      ("-legacy-radial-gradient", check(_legacy_radial_gradient)),
      (
        "-legacy-radial-gradient-arguments",
        check(_legacy_radial_gradient_arguments),
      ),
      (
        "-legacy-radial-gradient-shape",
        check(_legacy_radial_gradient_shape),
      ),
      ("-legacy-radial-gradient-size", check(_legacy_radial_gradient_size)),
      (
        "-legacy-repeating-linear-gradient",
        check(_legacy_repeating_linear_gradient),
      ),
      (
        "-legacy-repeating-radial-gradient",
        check(_legacy_repeating_radial_gradient),
      ),
      ("-ms-filter", check(_ms_filter)),
      ("-ms-filter-function", check(_ms_filter_function)),
      ("-ms-filter-function-legacy", check(_ms_filter_function_legacy)),
      ("-ms-filter-function-list", check(_ms_filter_function_list)),
      ("-ms-filter-function-progid", check(_ms_filter_function_progid)),
      ("-non-standard-color", check(_non_standard_color)),
      ("-non-standard-font", check(_non_standard_font)),
      (
        "-non-standard-image-rendering",
        check(_non_standard_image_rendering),
      ),
      ("-non-standard-overflow", check(_non_standard_overflow)),
      ("-non-standard-width", check(_non_standard_width)),
      ("-webkit-gradient-color-stop", check(_webkit_gradient_color_stop)),
      ("-webkit-gradient-point", check(_webkit_gradient_point)),
      ("-webkit-gradient-radius", check(_webkit_gradient_radius)),
      ("-webkit-gradient-type", check(_webkit_gradient_type)),
      ("-webkit-mask-box-repeat", check(_webkit_mask_box_repeat)),
      ("-webkit-mask-clip-style", check(_webkit_mask_clip_style)),
      ("absolute-size", check(absolute_size)),
      ("age", check(age)),
      ("alpha-value", check(alpha_value)),
      ("angular-color-hint", check(angular_color_hint)),
      ("angular-color-stop", check(angular_color_stop)),
      ("angular-color-stop-list", check(angular_color_stop_list)),
      ("animateable-feature", check(animateable_feature)),
      ("attachment", check(attachment)),
      ("attr-fallback", check(attr_fallback)),
      ("attr-matcher", check(attr_matcher)),
      ("attr-modifier", check(attr_modifier)),
      ("attr-name", check(attr_name)),
      ("attribute-selector", check(attribute_selector)),
      ("auto-repeat", check(auto_repeat)),
      ("auto-track-list", check(auto_track_list)),
      ("baseline-position", check(baseline_position)),
      ("basic-shape", check(basic_shape)),
      ("bg-image", check(bg_image)),
      ("bg-layer", check(bg_layer)),
      ("bg-position", check(bg_position)),
      ("bg-size", check(bg_size)),
      ("blend-mode", check(blend_mode)),
      ("border-radius", check(border_radius)),
      ("bottom", check(bottom)),
      ("box", check(box)),
      ("calc-product", check(calc_product)),
      ("calc-sum", check(calc_sum)),
      ("calc-value", check(calc_value)),
      ("cf-final-image", check(cf_final_image)),
      ("cf-mixing-image", check(cf_mixing_image)),
      ("class-selector", check(class_selector)),
      ("clip-source", check(clip_source)),
      ("color", check(color)),
      ("color-stop", check(color_stop)),
      ("color-stop-angle", check(color_stop_angle)),
      ("color-stop-length", check(color_stop_length)),
      ("color-stop-list", check(color_stop_list)),
      ("combinator", check(combinator)),
      ("common-lig-values", check(common_lig_values)),
      ("compat-auto", check(compat_auto)),
      ("complex-selector", check(complex_selector)),
      ("complex-selector-list", check(complex_selector_list)),
      ("composite-style", check(composite_style)),
      ("compositing-operator", check(compositing_operator)),
      ("compound-selector", check(compound_selector)),
      ("compound-selector-list", check(compound_selector_list)),
      ("content-distribution", check(content_distribution)),
      ("content-list", check(content_list)),
      ("content-position", check(content_position)),
      ("content-replacement", check(content_replacement)),
      ("contextual-alt-values", check(contextual_alt_values)),
      ("counter-style", check(counter_style)),
      ("counter-style-name", check(counter_style_name)),
      ("cubic-bezier-timing-function", check(cubic_bezier_timing_function)),
      ("declaration", check(declaration)),
      ("declaration-list", check(declaration_list)),
      ("deprecated-system-color", check(deprecated_system_color)),
      ("discretionary-lig-values", check(discretionary_lig_values)),
      ("display-box", check(display_box)),
      ("display-inside", check(display_inside)),
      ("display-internal", check(display_internal)),
      ("display-legacy", check(display_legacy)),
      ("display-listitem", check(display_listitem)),
      ("display-outside", check(display_outside)),
      ("east-asian-variant-values", check(east_asian_variant_values)),
      ("east-asian-width-values", check(east_asian_width_values)),
      ("ending-shape", check(ending_shape)),
      ("explicit-track-list", check(explicit_track_list)),
      ("family-name", check(family_name)),
      ("feature-tag-value", check(feature_tag_value)),
      ("feature-type", check(feature_type)),
      ("feature-value-block", check(feature_value_block)),
      ("feature-value-block-list", check(feature_value_block_list)),
      ("feature-value-declaration", check(feature_value_declaration)),
      (
        "feature-value-declaration-list",
        check(feature_value_declaration_list),
      ),
      ("feature-value-name", check(feature_value_name)),
      ("fill-rule", check(fill_rule)),
      ("filter-function", check(filter_function)),
      ("filter-function-list", check(filter_function_list)),
      ("final-bg-layer", check(final_bg_layer)),
      ("fixed-breadth", check(fixed_breadth)),
      ("fixed-repeat", check(fixed_repeat)),
      ("fixed-size", check(fixed_size)),
      ("font-stretch-absolute", check(font_stretch_absolute)),
      ("font-variant-css21", check(font_variant_css21)),
      ("font-weight-absolute", check(font_weight_absolute)),
      ("function_-webkit-gradient", check(function__webkit_gradient)),
      ("function_attr", check(function_attr)),
      ("function_blur", check(function_blur)),
      ("function_brightness", check(function_brightness)),
      ("function_calc", check(function_calc)),
      ("function_circle", check(function_circle)),
      ("function_clamp", check(function_clamp)),
      ("function_conic-gradient", check(function_conic_gradient)),
      ("function_contrast", check(function_contrast)),
      ("function_counter", check(function_counter)),
      ("function_counters", check(function_counters)),
      ("function_cross-fade", check(function_cross_fade)),
      ("function_drop-shadow", check(function_drop_shadow)),
      ("function_element", check(function_element)),
      ("function_ellipse", check(function_ellipse)),
      ("function_env", check(function_env)),
      ("function_fit-content", check(function_fit_content)),
      ("function_grayscale", check(function_grayscale)),
      ("function_hsl", check(function_hsl)),
      ("function_hsla", check(function_hsla)),
      ("function_hue-rotate", check(function_hue_rotate)),
      ("function_image", check(function_image)),
      ("function_image-set", check(function_image_set)),
      ("function_inset", check(function_inset)),
      ("function_invert", check(function_invert)),
      ("function_leader", check(function_leader)),
      ("function_linear-gradient", check(function_linear_gradient)),
      ("function_matrix", check(function_matrix)),
      ("function_matrix3d", check(function_matrix3d)),
      ("function_max", check(function_max)),
      ("function_min", check(function_min)),
      ("function_minmax", check(function_minmax)),
      ("function_opacity", check(function_opacity)),
      ("function_paint", check(function_paint)),
      ("function_path", check(function_path)),
      ("function_perspective", check(function_perspective)),
      ("function_polygon", check(function_polygon)),
      ("function_radial-gradient", check(function_radial_gradient)),
      (
        "function_repeating-linear-gradient",
        check(function_repeating_linear_gradient),
      ),
      (
        "function_repeating-radial-gradient",
        check(function_repeating_radial_gradient),
      ),
      ("function_rgb", check(function_rgb)),
      ("function_rgba", check(function_rgba)),
      ("function_rotate", check(function_rotate)),
      ("function_rotate3d", check(function_rotate3d)),
      ("function_rotateX", check(function_rotateX)),
      ("function_rotateY", check(function_rotateY)),
      ("function_rotateZ", check(function_rotateZ)),
      ("function_saturate", check(function_saturate)),
      ("function_scale", check(function_scale)),
      ("function_scale3d", check(function_scale3d)),
      ("function_scaleX", check(function_scaleX)),
      ("function_scaleY", check(function_scaleY)),
      ("function_scaleZ", check(function_scaleZ)),
      ("function_sepia", check(function_sepia)),
      ("function_skew", check(function_skew)),
      ("function_skewX", check(function_skewX)),
      ("function_skewY", check(function_skewY)),
      ("function_target-counter", check(function_target_counter)),
      ("function_target-counters", check(function_target_counters)),
      ("function_target-text", check(function_target_text)),
      ("function_translate", check(function_translate)),
      ("function_translate3d", check(function_translate3d)),
      ("function_translateX", check(function_translateX)),
      ("function_translateY", check(function_translateY)),
      ("function_translateZ", check(function_translateZ)),
      ("function_var", check(function_var)),
      ("gender", check(gender)),
      ("general-enclosed", check(general_enclosed)),
      ("generic-family", check(generic_family)),
      ("generic-name", check(generic_name)),
      ("generic-voice", check(generic_voice)),
      ("geometry-box", check(geometry_box)),
      ("gradient", check(gradient)),
      ("grid-line", check(grid_line)),
      ("historical-lig-values", check(historical_lig_values)),
      ("hue", check(hue)),
      ("id-selector", check(id_selector)),
      ("image", check(image)),
      ("image-set-option", check(image_set_option)),
      ("image-src", check(image_src)),
      ("image-tags", check(image_tags)),
      ("inflexible-breadth", check(inflexible_breadth)),
      ("keyframe-block", check(keyframe_block)),
      ("keyframe-block-list", check(keyframe_block_list)),
      ("keyframe-selector", check(keyframe_selector)),
      ("keyframes-name", check(keyframes_name)),
      ("leader-type", check(leader_type)),
      ("left", check(left)),
      ("line-name-list", check(line_name_list)),
      ("line-names", check(line_names)),
      ("line-style", check(line_style)),
      ("line-width", check(line_width)),
      ("linear-color-hint", check(linear_color_hint)),
      ("linear-color-stop", check(linear_color_stop)),
      ("mask-image", check(mask_image)),
      ("mask-layer", check(mask_layer)),
      ("mask-position", check(mask_position)),
      ("mask-reference", check(mask_reference)),
      ("mask-source", check(mask_source)),
      ("masking-mode", check(masking_mode)),
      ("media-and", check(media_and)),
      ("media-condition", check(media_condition)),
      ("media-condition-without-or", check(media_condition_without_or)),
      ("media-feature", check(media_feature)),
      ("media-in-parens", check(media_in_parens)),
      ("media-not", check(media_not)),
      ("media-or", check(media_or)),
      ("media-query", check(media_query)),
      ("media-query-list", check(media_query_list)),
      ("media-type", check(media_type)),
      ("mf-boolean", check(mf_boolean)),
      ("mf-name", check(mf_name)),
      ("mf-plain", check(mf_plain)),
      ("mf-range", check(mf_range)),
      ("mf-value", check(mf_value)),
      ("name-repeat", check(name_repeat)),
      ("named-color", check(named_color)),
      ("namespace-prefix", check(namespace_prefix)),
      ("ns-prefix", check(ns_prefix)),
      ("nth", check(nth)),
      ("number-one-or-greater", check(number_one_or_greater)),
      ("number-percentage", check(number_percentage)),
      ("alpha-value", check(number_zero_one)),
      ("numeric-figure-values", check(numeric_figure_values)),
      ("numeric-fraction-values", check(numeric_fraction_values)),
      ("numeric-spacing-values", check(numeric_spacing_values)),
      ("outline-radius", check(outline_radius)),
      ("overflow-position", check(overflow_position)),
      ("page-body", check(page_body)),
      ("page-margin-box", check(page_margin_box)),
      ("page-margin-box-type", check(page_margin_box_type)),
      ("page-selector", check(page_selector)),
      ("page-selector-list", check(page_selector_list)),
      ("paint", check(paint)),
      ("position", check(position)),
      ("positive-integer", check(positive_integer)),
      ("property--moz-appearance", check(property__moz_appearance)),
      (
        "property--moz-background-clip",
        check(property__moz_background_clip),
      ),
      ("property--moz-binding", check(property__moz_binding)),
      (
        "property--moz-border-bottom-colors",
        check(property__moz_border_bottom_colors),
      ),
      (
        "property--moz-border-left-colors",
        check(property__moz_border_left_colors),
      ),
      (
        "property--moz-border-radius-bottomleft",
        check(property__moz_border_radius_bottomleft),
      ),
      (
        "property--moz-border-radius-bottomright",
        check(property__moz_border_radius_bottomright),
      ),
      (
        "property--moz-border-radius-topleft",
        check(property__moz_border_radius_topleft),
      ),
      (
        "property--moz-border-radius-topright",
        check(property__moz_border_radius_topright),
      ),
      (
        "property--moz-border-right-colors",
        check(property__moz_border_right_colors),
      ),
      (
        "property--moz-border-top-colors",
        check(property__moz_border_top_colors),
      ),
      (
        "property--moz-context-properties",
        check(property__moz_context_properties),
      ),
      (
        "property--moz-control-character-visibility",
        check(property__moz_control_character_visibility),
      ),
      ("property--moz-float-edge", check(property__moz_float_edge)),
      (
        "property--moz-force-broken-image-icon",
        check(property__moz_force_broken_image_icon),
      ),
      ("property--moz-image-region", check(property__moz_image_region)),
      ("property--moz-orient", check(property__moz_orient)),
      (
        "property--moz-osx-font-smoothing",
        check(property__moz_osx_font_smoothing),
      ),
      ("property--moz-outline-radius", check(property__moz_outline_radius)),
      (
        "property--moz-outline-radius-bottomleft",
        check(property__moz_outline_radius_bottomleft),
      ),
      (
        "property--moz-outline-radius-bottomright",
        check(property__moz_outline_radius_bottomright),
      ),
      (
        "property--moz-outline-radius-topleft",
        check(property__moz_outline_radius_topleft),
      ),
      (
        "property--moz-outline-radius-topright",
        check(property__moz_outline_radius_topright),
      ),
      ("property--moz-stack-sizing", check(property__moz_stack_sizing)),
      ("property--moz-text-blink", check(property__moz_text_blink)),
      ("property--moz-user-focus", check(property__moz_user_focus)),
      ("property--moz-user-input", check(property__moz_user_input)),
      ("property--moz-user-modify", check(property__moz_user_modify)),
      ("property--moz-user-select", check(property__moz_user_select)),
      (
        "property--moz-window-dragging",
        check(property__moz_window_dragging),
      ),
      ("property--moz-window-shadow", check(property__moz_window_shadow)),
      ("property--ms-accelerator", check(property__ms_accelerator)),
      (
        "property--ms-block-progression",
        check(property__ms_block_progression),
      ),
      (
        "property--ms-content-zoom-chaining",
        check(property__ms_content_zoom_chaining),
      ),
      (
        "property--ms-content-zoom-limit",
        check(property__ms_content_zoom_limit),
      ),
      (
        "property--ms-content-zoom-limit-max",
        check(property__ms_content_zoom_limit_max),
      ),
      (
        "property--ms-content-zoom-limit-min",
        check(property__ms_content_zoom_limit_min),
      ),
      (
        "property--ms-content-zoom-snap",
        check(property__ms_content_zoom_snap),
      ),
      (
        "property--ms-content-zoom-snap-points",
        check(property__ms_content_zoom_snap_points),
      ),
      (
        "property--ms-content-zoom-snap-type",
        check(property__ms_content_zoom_snap_type),
      ),
      ("property--ms-content-zooming", check(property__ms_content_zooming)),
      ("property--ms-filter", check(property__ms_filter)),
      ("property--ms-flex-align", check(property__ms_flex_align)),
      ("property--ms-flex-item-align", check(property__ms_flex_item_align)),
      ("property--ms-flex-line-pack", check(property__ms_flex_line_pack)),
      ("property--ms-flex-negative", check(property__ms_flex_negative)),
      ("property--ms-flex-order", check(property__ms_flex_order)),
      ("property--ms-flex-pack", check(property__ms_flex_pack)),
      ("property--ms-flex-positive", check(property__ms_flex_positive)),
      (
        "property--ms-flex-preferred-size",
        check(property__ms_flex_preferred_size),
      ),
      ("property--ms-flow-from", check(property__ms_flow_from)),
      ("property--ms-flow-into", check(property__ms_flow_into)),
      (
        "property--ms-grid-column-align",
        check(property__ms_grid_column_align),
      ),
      ("property--ms-grid-columns", check(property__ms_grid_columns)),
      ("property--ms-grid-row-align", check(property__ms_grid_row_align)),
      ("property--ms-grid-rows", check(property__ms_grid_rows)),
      (
        "property--ms-high-contrast-adjust",
        check(property__ms_high_contrast_adjust),
      ),
      (
        "property--ms-hyphenate-limit-chars",
        check(property__ms_hyphenate_limit_chars),
      ),
      (
        "property--ms-hyphenate-limit-last",
        check(property__ms_hyphenate_limit_last),
      ),
      (
        "property--ms-hyphenate-limit-lines",
        check(property__ms_hyphenate_limit_lines),
      ),
      (
        "property--ms-hyphenate-limit-zone",
        check(property__ms_hyphenate_limit_zone),
      ),
      ("property--ms-ime-align", check(property__ms_ime_align)),
      (
        "property--ms-interpolation-mode",
        check(property__ms_interpolation_mode),
      ),
      ("property--ms-overflow-style", check(property__ms_overflow_style)),
      ("property--ms-scroll-chaining", check(property__ms_scroll_chaining)),
      ("property--ms-scroll-limit", check(property__ms_scroll_limit)),
      (
        "property--ms-scroll-limit-x-max",
        check(property__ms_scroll_limit_x_max),
      ),
      (
        "property--ms-scroll-limit-x-min",
        check(property__ms_scroll_limit_x_min),
      ),
      (
        "property--ms-scroll-limit-y-max",
        check(property__ms_scroll_limit_y_max),
      ),
      (
        "property--ms-scroll-limit-y-min",
        check(property__ms_scroll_limit_y_min),
      ),
      ("property--ms-scroll-rails", check(property__ms_scroll_rails)),
      (
        "property--ms-scroll-snap-points-x",
        check(property__ms_scroll_snap_points_x),
      ),
      (
        "property--ms-scroll-snap-points-y",
        check(property__ms_scroll_snap_points_y),
      ),
      (
        "property--ms-scroll-snap-type",
        check(property__ms_scroll_snap_type),
      ),
      ("property--ms-scroll-snap-x", check(property__ms_scroll_snap_x)),
      ("property--ms-scroll-snap-y", check(property__ms_scroll_snap_y)),
      (
        "property--ms-scroll-translation",
        check(property__ms_scroll_translation),
      ),
      (
        "property--ms-scrollbar-3dlight-color",
        check(property__ms_scrollbar_3dlight_color),
      ),
      (
        "property--ms-scrollbar-arrow-color",
        check(property__ms_scrollbar_arrow_color),
      ),
      (
        "property--ms-scrollbar-base-color",
        check(property__ms_scrollbar_base_color),
      ),
      (
        "property--ms-scrollbar-darkshadow-color",
        check(property__ms_scrollbar_darkshadow_color),
      ),
      (
        "property--ms-scrollbar-face-color",
        check(property__ms_scrollbar_face_color),
      ),
      (
        "property--ms-scrollbar-highlight-color",
        check(property__ms_scrollbar_highlight_color),
      ),
      (
        "property--ms-scrollbar-shadow-color",
        check(property__ms_scrollbar_shadow_color),
      ),
      (
        "property--ms-scrollbar-track-color",
        check(property__ms_scrollbar_track_color),
      ),
      ("property--ms-text-autospace", check(property__ms_text_autospace)),
      ("property--ms-touch-select", check(property__ms_touch_select)),
      ("property--ms-user-select", check(property__ms_user_select)),
      ("property--ms-wrap-flow", check(property__ms_wrap_flow)),
      ("property--ms-wrap-margin", check(property__ms_wrap_margin)),
      ("property--ms-wrap-through", check(property__ms_wrap_through)),
      ("property--webkit-appearance", check(property__webkit_appearance)),
      (
        "property--webkit-background-clip",
        check(property__webkit_background_clip),
      ),
      (
        "property--webkit-border-before",
        check(property__webkit_border_before),
      ),
      (
        "property--webkit-border-before-color",
        check(property__webkit_border_before_color),
      ),
      (
        "property--webkit-border-before-style",
        check(property__webkit_border_before_style),
      ),
      (
        "property--webkit-border-before-width",
        check(property__webkit_border_before_width),
      ),
      ("property--webkit-box-reflect", check(property__webkit_box_reflect)),
      ("property--webkit-box-shadow", check(property_box_shadow)),
      ("property--webkit-box-orient", check(property_box_orient)),
      (
        "property--webkit-column-break-after",
        check(property__webkit_column_break_after),
      ),
      (
        "property--webkit-column-break-before",
        check(property__webkit_column_break_before),
      ),
      (
        "property--webkit-column-break-inside",
        check(property__webkit_column_break_inside),
      ),
      (
        "property--webkit-font-smoothing",
        check(property__webkit_font_smoothing),
      ),
      ("property--webkit-line-clamp", check(property__webkit_line_clamp)),
      ("property--webkit-mask", check(property__webkit_mask)),
      (
        "property--webkit-mask-attachment",
        check(property__webkit_mask_attachment),
      ),
      (
        "property--webkit-mask-box-image",
        check(property__webkit_mask_box_image),
      ),
      ("property--webkit-mask-clip", check(property__webkit_mask_clip)),
      (
        "property--webkit-mask-composite",
        check(property__webkit_mask_composite),
      ),
      ("property--webkit-mask-image", check(property__webkit_mask_image)),
      ("property--webkit-mask-origin", check(property__webkit_mask_origin)),
      (
        "property--webkit-mask-position",
        check(property__webkit_mask_position),
      ),
      (
        "property--webkit-mask-position-x",
        check(property__webkit_mask_position_x),
      ),
      (
        "property--webkit-mask-position-y",
        check(property__webkit_mask_position_y),
      ),
      ("property--webkit-mask-repeat", check(property__webkit_mask_repeat)),
      (
        "property--webkit-mask-repeat-x",
        check(property__webkit_mask_repeat_x),
      ),
      (
        "property--webkit-mask-repeat-y",
        check(property__webkit_mask_repeat_y),
      ),
      ("property--webkit-mask-size", check(property__webkit_mask_size)),
      (
        "property--webkit-overflow-scrolling",
        check(property__webkit_overflow_scrolling),
      ),
      (
        "property--webkit-print-color-adjust",
        check(property__webkit_print_color_adjust),
      ),
      (
        "property--webkit-tap-highlight-color",
        check(property__webkit_tap_highlight_color),
      ),
      (
        "property--webkit-text-fill-color",
        check(property__webkit_text_fill_color),
      ),
      (
        "property--webkit-text-security",
        check(property__webkit_text_security),
      ),
      ("property--webkit-text-stroke", check(property__webkit_text_stroke)),
      (
        "property--webkit-text-stroke-color",
        check(property__webkit_text_stroke_color),
      ),
      (
        "property--webkit-text-stroke-width",
        check(property__webkit_text_stroke_width),
      ),
      (
        "property--webkit-touch-callout",
        check(property__webkit_touch_callout),
      ),
      ("property--webkit-user-drag", check(property__webkit_user_drag)),
      ("property--webkit-user-modify", check(property__webkit_user_modify)),
      ("property--webkit-user-select", check(property__webkit_user_select)),
      ("property-align-content", check(property_align_content)),
      ("property-align-items", check(property_align_items)),
      ("property-align-self", check(property_align_self)),
      ("property-alignment-baseline", check(property_alignment_baseline)),
      ("property-all", check(property_all)),
      ("property-animation", check(property_animation)),
      ("property-animation-delay", check(property_animation_delay)),
      ("property-animation-direction", check(property_animation_direction)),
      ("property-animation-duration", check(property_animation_duration)),
      ("property-animation-fill-mode", check(property_animation_fill_mode)),
      (
        "property-animation-iteration-count",
        check(property_animation_iteration_count),
      ),
      ("property-animation-name", check(property_animation_name)),
      (
        "property-animation-play-state",
        check(property_animation_play_state),
      ),
      (
        "property-animation-timing-function",
        check(property_animation_timing_function),
      ),
      ("property-appearance", check(property_appearance)),
      ("property-aspect-ratio", check(property_aspect_ratio)),
      ("property-azimuth", check(property_azimuth)),
      ("property-backdrop-filter", check(property_backdrop_filter)),
      ("property-backface-visibility", check(property_backface_visibility)),
      ("property-background", check(property_background)),
      (
        "property-background-attachment",
        check(property_background_attachment),
      ),
      (
        "property-background-blend-mode",
        check(property_background_blend_mode),
      ),
      ("property-background-clip", check(property_background_clip)),
      ("property-background-color", check(property_background_color)),
      ("property-background-image", check(property_background_image)),
      ("property-background-origin", check(property_background_origin)),
      ("property-background-position", check(property_background_position)),
      (
        "property-background-position-x",
        check(property_background_position_x),
      ),
      (
        "property-background-position-y",
        check(property_background_position_y),
      ),
      ("property-background-repeat", check(property_background_repeat)),
      ("property-background-size", check(property_background_size)),
      ("property-baseline-shift", check(property_baseline_shift)),
      ("property-behavior", check(property_behavior)),
      ("property-block-overflow", check(property_block_overflow)),
      ("property-block-size", check(property_block_size)),
      ("property-border", check(property_border)),
      ("property-border-block", check(property_border_block)),
      ("property-border-block-color", check(property_border_block_color)),
      ("property-border-block-end", check(property_border_block_end)),
      (
        "property-border-block-end-color",
        check(property_border_block_end_color),
      ),
      (
        "property-border-block-end-style",
        check(property_border_block_end_style),
      ),
      (
        "property-border-block-end-width",
        check(property_border_block_end_width),
      ),
      ("property-border-block-start", check(property_border_block_start)),
      (
        "property-border-block-start-color",
        check(property_border_block_start_color),
      ),
      (
        "property-border-block-start-style",
        check(property_border_block_start_style),
      ),
      (
        "property-border-block-start-width",
        check(property_border_block_start_width),
      ),
      ("property-border-block-style", check(property_border_block_style)),
      ("property-border-block-width", check(property_border_block_width)),
      ("property-border-bottom", check(property_border_bottom)),
      ("property-border-bottom-color", check(property_border_bottom_color)),
      (
        "property-border-bottom-left-radius",
        check(property_border_bottom_left_radius),
      ),
      (
        "property-border-bottom-right-radius",
        check(property_border_bottom_right_radius),
      ),
      ("property-border-bottom-style", check(property_border_bottom_style)),
      ("property-border-bottom-width", check(property_border_bottom_width)),
      ("property-border-collapse", check(property_border_collapse)),
      ("property-border-color", check(property_border_color)),
      (
        "property-border-end-end-radius",
        check(property_border_end_end_radius),
      ),
      (
        "property-border-end-start-radius",
        check(property_border_end_start_radius),
      ),
      ("property-border-image", check(property_border_image)),
      ("property-border-image-outset", check(property_border_image_outset)),
      ("property-border-image-repeat", check(property_border_image_repeat)),
      ("property-border-image-slice", check(property_border_image_slice)),
      ("property-border-image-source", check(property_border_image_source)),
      ("property-border-image-width", check(property_border_image_width)),
      ("property-border-inline", check(property_border_inline)),
      ("property-border-inline-color", check(property_border_inline_color)),
      ("property-border-inline-end", check(property_border_inline_end)),
      (
        "property-border-inline-end-color",
        check(property_border_inline_end_color),
      ),
      (
        "property-border-inline-end-style",
        check(property_border_inline_end_style),
      ),
      (
        "property-border-inline-end-width",
        check(property_border_inline_end_width),
      ),
      ("property-border-inline-start", check(property_border_inline_start)),
      (
        "property-border-inline-start-color",
        check(property_border_inline_start_color),
      ),
      (
        "property-border-inline-start-style",
        check(property_border_inline_start_style),
      ),
      (
        "property-border-inline-start-width",
        check(property_border_inline_start_width),
      ),
      ("property-border-inline-style", check(property_border_inline_style)),
      ("property-border-inline-width", check(property_border_inline_width)),
      ("property-border-left", check(property_border_left)),
      ("property-border-left-color", check(property_border_left_color)),
      ("property-border-left-style", check(property_border_left_style)),
      ("property-border-left-width", check(property_border_left_width)),
      ("property-border-radius", check(property_border_radius)),
      ("property-border-right", check(property_border_right)),
      ("property-border-right-color", check(property_border_right_color)),
      ("property-border-right-style", check(property_border_right_style)),
      ("property-border-right-width", check(property_border_right_width)),
      ("property-border-spacing", check(property_border_spacing)),
      (
        "property-border-start-end-radius",
        check(property_border_start_end_radius),
      ),
      (
        "property-border-start-start-radius",
        check(property_border_start_start_radius),
      ),
      ("property-border-style", check(property_border_style)),
      ("property-border-top", check(property_border_top)),
      ("property-border-top-color", check(property_border_top_color)),
      (
        "property-border-top-left-radius",
        check(property_border_top_left_radius),
      ),
      (
        "property-border-top-right-radius",
        check(property_border_top_right_radius),
      ),
      ("property-border-top-style", check(property_border_top_style)),
      ("property-border-top-width", check(property_border_top_width)),
      ("property-border-width", check(property_border_width)),
      ("property-bottom", check(property_bottom)),
      ("property-box-align", check(property_box_align)),
      (
        "property-box-decoration-break",
        check(property_box_decoration_break),
      ),
      ("property-box-direction", check(property_box_direction)),
      ("property-box-flex", check(property_box_flex)),
      ("property-box-flex-group", check(property_box_flex_group)),
      ("property-box-lines", check(property_box_lines)),
      ("property-box-ordinal-group", check(property_box_ordinal_group)),
      ("property-box-orient", check(property_box_orient)),
      ("property-box-pack", check(property_box_pack)),
      ("property-box-shadow", check(property_box_shadow)),
      ("property-box-sizing", check(property_box_sizing)),
      ("property-break-after", check(property_break_after)),
      ("property-break-before", check(property_break_before)),
      ("property-break-inside", check(property_break_inside)),
      ("property-caption-side", check(property_caption_side)),
      ("property-caret-color", check(property_caret_color)),
      ("property-clear", check(property_clear)),
      ("property-clip", check(property_clip)),
      ("property-clip-path", check(property_clip_path)),
      ("property-clip-rule", check(property_clip_rule)),
      ("property-color", check(property_color)),
      ("property-color-adjust", check(property_color_adjust)),
      ("property-column-count", check(property_column_count)),
      ("property-column-fill", check(property_column_fill)),
      ("property-column-gap", check(property_column_gap)),
      ("property-column-rule", check(property_column_rule)),
      ("property-column-rule-color", check(property_column_rule_color)),
      ("property-column-rule-style", check(property_column_rule_style)),
      ("property-column-rule-width", check(property_column_rule_width)),
      ("property-column-span", check(property_column_span)),
      ("property-column-width", check(property_column_width)),
      ("property-columns", check(property_columns)),
      ("property-contain", check(property_contain)),
      ("property-content", check(property_content)),
      ("property-counter-increment", check(property_counter_increment)),
      ("property-counter-reset", check(property_counter_reset)),
      ("property-counter-set", check(property_counter_set)),
      ("property-cue", check(property_cue)),
      ("property-cue-after", check(property_cue_after)),
      ("property-cue-before", check(property_cue_before)),
      ("property-cursor", check(property_cursor)),
      ("property-direction", check(property_direction)),
      ("property-display", check(property_display)),
      ("property-dominant-baseline", check(property_dominant_baseline)),
      ("property-empty-cells", check(property_empty_cells)),
      ("property-fill", check(property_fill)),
      ("property-fill-opacity", check(property_fill_opacity)),
      ("property-fill-rule", check(property_fill_rule)),
      ("property-filter", check(property_filter)),
      ("property-flex", check(property_flex)),
      ("property-flex-basis", check(property_flex_basis)),
      ("property-flex-direction", check(property_flex_direction)),
      ("property-flex-flow", check(property_flex_flow)),
      ("property-flex-grow", check(property_flex_grow)),
      ("property-flex-shrink", check(property_flex_shrink)),
      ("property-flex-wrap", check(property_flex_wrap)),
      ("property-float", check(property_float)),
      ("property-font", check(property_font)),
      ("property-font-family", check(property_font_family)),
      (
        "property-font-feature-settings",
        check(property_font_feature_settings),
      ),
      ("property-font-kerning", check(property_font_kerning)),
      (
        "property-font-language-override",
        check(property_font_language_override),
      ),
      ("property-font-optical-sizing", check(property_font_optical_sizing)),
      ("property-font-size", check(property_font_size)),
      ("property-font-size-adjust", check(property_font_size_adjust)),
      ("property-font-smooth", check(property_font_smooth)),
      ("property-font-stretch", check(property_font_stretch)),
      ("property-font-style", check(property_font_style)),
      ("property-font-synthesis", check(property_font_synthesis)),
      ("property-font-variant", check(property_font_variant)),
      (
        "property-font-variant-alternates",
        check(property_font_variant_alternates),
      ),
      ("property-font-variant-caps", check(property_font_variant_caps)),
      (
        "property-font-variant-east-asian",
        check(property_font_variant_east_asian),
      ),
      (
        "property-font-variant-ligatures",
        check(property_font_variant_ligatures),
      ),
      (
        "property-font-variant-numeric",
        check(property_font_variant_numeric),
      ),
      (
        "property-font-variant-position",
        check(property_font_variant_position),
      ),
      (
        "property-font-variation-settings",
        check(property_font_variation_settings),
      ),
      ("property-font-weight", check(property_font_weight)),
      ("property-gap", check(property_gap)),
      (
        "property-glyph-orientation-horizontal",
        check(property_glyph_orientation_horizontal),
      ),
      (
        "property-glyph-orientation-vertical",
        check(property_glyph_orientation_vertical),
      ),
      ("property-grid", check(property_grid)),
      ("property-grid-area", check(property_grid_area)),
      ("property-grid-auto-columns", check(property_grid_auto_columns)),
      ("property-grid-auto-flow", check(property_grid_auto_flow)),
      ("property-grid-auto-rows", check(property_grid_auto_rows)),
      ("property-grid-column", check(property_grid_column)),
      ("property-grid-column-end", check(property_grid_column_end)),
      ("property-grid-column-gap", check(property_grid_column_gap)),
      ("property-grid-column-start", check(property_grid_column_start)),
      ("property-grid-gap", check(property_grid_gap)),
      ("property-grid-row", check(property_grid_row)),
      ("property-grid-row-end", check(property_grid_row_end)),
      ("property-grid-row-gap", check(property_grid_row_gap)),
      ("property-grid-row-start", check(property_grid_row_start)),
      ("property-grid-template", check(property_grid_template)),
      ("property-grid-template-areas", check(property_grid_template_areas)),
      (
        "property-grid-template-columns",
        check(property_grid_template_columns),
      ),
      ("property-grid-template-rows", check(property_grid_template_rows)),
      ("property-hanging-punctuation", check(property_hanging_punctuation)),
      ("property-height", check(property_height)),
      ("property-hyphens", check(property_hyphens)),
      ("property-image-orientation", check(property_image_orientation)),
      ("property-image-rendering", check(property_image_rendering)),
      ("property-image-resolution", check(property_image_resolution)),
      ("property-ime-mode", check(property_ime_mode)),
      ("property-initial-letter", check(property_initial_letter)),
      (
        "property-initial-letter-align",
        check(property_initial_letter_align),
      ),
      ("property-inline-size", check(property_inline_size)),
      ("property-inset", check(property_inset)),
      ("property-inset-block", check(property_inset_block)),
      ("property-inset-block-end", check(property_inset_block_end)),
      ("property-inset-block-start", check(property_inset_block_start)),
      ("property-inset-inline", check(property_inset_inline)),
      ("property-inset-inline-end", check(property_inset_inline_end)),
      ("property-inset-inline-start", check(property_inset_inline_start)),
      ("property-isolation", check(property_isolation)),
      ("property-justify-content", check(property_justify_content)),
      ("property-justify-items", check(property_justify_items)),
      ("property-justify-self", check(property_justify_self)),
      ("property-kerning", check(property_kerning)),
      ("property-left", check(property_left)),
      ("property-letter-spacing", check(property_letter_spacing)),
      ("property-line-break", check(property_line_break)),
      ("property-line-clamp", check(property_line_clamp)),
      ("property-line-height", check(property_line_height)),
      ("property-line-height-step", check(property_line_height_step)),
      ("property-list-style", check(property_list_style)),
      ("property-list-style-image", check(property_list_style_image)),
      ("property-list-style-position", check(property_list_style_position)),
      ("property-list-style-type", check(property_list_style_type)),
      ("property-margin", check(property_margin)),
      ("property-margin-block", check(property_margin_block)),
      ("property-margin-block-end", check(property_margin_block_end)),
      ("property-margin-block-start", check(property_margin_block_start)),
      ("property-margin-bottom", check(property_margin_bottom)),
      ("property-margin-inline", check(property_margin_inline)),
      ("property-margin-inline-end", check(property_margin_inline_end)),
      ("property-margin-inline-start", check(property_margin_inline_start)),
      ("property-margin-left", check(property_margin_left)),
      ("property-margin-right", check(property_margin_right)),
      ("property-margin-top", check(property_margin_top)),
      ("property-margin-trim", check(property_margin_trim)),
      ("property-marker", check(property_marker)),
      ("property-marker-end", check(property_marker_end)),
      ("property-marker-mid", check(property_marker_mid)),
      ("property-marker-start", check(property_marker_start)),
      ("property-mask", check(property_mask)),
      ("property-mask-border", check(property_mask_border)),
      ("property-mask-border-mode", check(property_mask_border_mode)),
      ("property-mask-border-outset", check(property_mask_border_outset)),
      ("property-mask-border-repeat", check(property_mask_border_repeat)),
      ("property-mask-border-slice", check(property_mask_border_slice)),
      ("property-mask-border-source", check(property_mask_border_source)),
      ("property-mask-border-width", check(property_mask_border_width)),
      ("property-mask-clip", check(property_mask_clip)),
      ("property-mask-composite", check(property_mask_composite)),
      ("property-mask-image", check(property_mask_image)),
      ("property-mask-mode", check(property_mask_mode)),
      ("property-mask-origin", check(property_mask_origin)),
      ("property-mask-position", check(property_mask_position)),
      ("property-mask-repeat", check(property_mask_repeat)),
      ("property-mask-size", check(property_mask_size)),
      ("property-mask-type", check(property_mask_type)),
      ("property-max-block-size", check(property_max_block_size)),
      ("property-max-height", check(property_max_height)),
      ("property-max-inline-size", check(property_max_inline_size)),
      ("property-max-lines", check(property_max_lines)),
      ("property-max-width", check(property_max_width)),
      ("property-min-block-size", check(property_min_block_size)),
      ("property-min-height", check(property_min_height)),
      ("property-min-inline-size", check(property_min_inline_size)),
      ("property-min-width", check(property_min_width)),
      ("property-mix-blend-mode", check(property_mix_blend_mode)),
      ("property-object-fit", check(property_object_fit)),
      ("property-object-position", check(property_object_position)),
      ("property-offset", check(property_offset)),
      ("property-offset-anchor", check(property_offset_anchor)),
      ("property-offset-distance", check(property_offset_distance)),
      ("property-offset-path", check(property_offset_path)),
      ("property-offset-position", check(property_offset_position)),
      ("property-offset-rotate", check(property_offset_rotate)),
      ("property-opacity", check(property_opacity)),
      ("property-order", check(property_order)),
      ("property-orphans", check(property_orphans)),
      ("property-outline", check(property_outline)),
      ("property-outline-color", check(property_outline_color)),
      ("property-outline-offset", check(property_outline_offset)),
      ("property-outline-style", check(property_outline_style)),
      ("property-outline-width", check(property_outline_width)),
      ("property-overflow", check(property_overflow)),
      ("property-overflow-anchor", check(property_overflow_anchor)),
      ("property-overflow-block", check(property_overflow_block)),
      ("property-overflow-clip-box", check(property_overflow_clip_box)),
      ("property-overflow-inline", check(property_overflow_inline)),
      ("property-overflow-wrap", check(property_overflow_wrap)),
      ("property-overflow-x", check(property_overflow_x)),
      ("property-overflow-y", check(property_overflow_y)),
      ("property-overscroll-behavior", check(property_overscroll_behavior)),
      (
        "property-overscroll-behavior-block",
        check(property_overscroll_behavior_block),
      ),
      (
        "property-overscroll-behavior-inline",
        check(property_overscroll_behavior_inline),
      ),
      (
        "property-overscroll-behavior-x",
        check(property_overscroll_behavior_x),
      ),
      (
        "property-overscroll-behavior-y",
        check(property_overscroll_behavior_y),
      ),
      ("property-any-hover", check(property_media_any_hover)),
      ("property-any-pointer", check(property_media_any_pointer)),
      ("property-pointer", check(property_media_pointer)),
      ("property-max-aspect-ratio", check(property_media_max_aspect_ratio)),
      ("property-min-aspect-ratio", check(property_media_min_aspect_ratio)),
      ("property-min-color", check(property_media_min_color)),
      ("property-color-gamut", check(property_media_color_gamut)),
      ("property-color-index", check(property_media_color_index)),
      ("property-min-color-index", check(property_media_min_color_index)),
      ("property-display-mode", check(property_media_display_mode)),
      ("property-forced-colors", check(property_media_forced_colors)),
      ("property-grid", check(property_media_grid)),
      ("property-hover", check(property_media_hover)),
      ("property-inverted-colors", check(property_media_inverted_colors)),
      ("property-monochrome", check(property_media_monochrome)),
      ("property-prefers-color-scheme", check(property_media_prefers_color_scheme)),
      ("property-prefers-contrast", check(property_media_prefers_contrast)),
      ("property-prefers-reduced-motion", check(property_media_prefers_reduced_motion)),
      ("property-resolution", check(property_media_resolution)),
      ("property-min-resolution", check(property_media_min_resolution)),
      ("property-max-resolution", check(property_media_max_resolution)),
      ("property-scripting", check(property_media_scripting)),
      ("property-update", check(property_media_update)),
      ("property-orientation", check(property_media_orientation)),
      ("property-padding", check(property_padding)),
      ("property-padding-block", check(property_padding_block)),
      ("property-padding-block-end", check(property_padding_block_end)),
      ("property-padding-block-start", check(property_padding_block_start)),
      ("property-padding-bottom", check(property_padding_bottom)),
      ("property-padding-inline", check(property_padding_inline)),
      ("property-padding-inline-end", check(property_padding_inline_end)),
      (
        "property-padding-inline-start",
        check(property_padding_inline_start),
      ),
      ("property-padding-left", check(property_padding_left)),
      ("property-padding-right", check(property_padding_right)),
      ("property-padding-top", check(property_padding_top)),
      ("property-page-break-after", check(property_page_break_after)),
      ("property-page-break-before", check(property_page_break_before)),
      ("property-page-break-inside", check(property_page_break_inside)),
      ("property-paint-order", check(property_paint_order)),
      ("property-pause", check(property_pause)),
      ("property-pause-after", check(property_pause_after)),
      ("property-pause-before", check(property_pause_before)),
      ("property-perspective", check(property_perspective)),
      ("property-perspective-origin", check(property_perspective_origin)),
      ("property-place-content", check(property_place_content)),
      ("property-place-items", check(property_place_items)),
      ("property-place-self", check(property_place_self)),
      ("property-pointer-events", check(property_pointer_events)),
      ("property-position", check(property_position)),
      ("property-quotes", check(property_quotes)),
      ("property-resize", check(property_resize)),
      ("property-rest", check(property_rest)),
      ("property-rest-after", check(property_rest_after)),
      ("property-rest-before", check(property_rest_before)),
      ("property-right", check(property_right)),
      ("property-rotate", check(property_rotate)),
      ("property-row-gap", check(property_row_gap)),
      ("property-ruby-align", check(property_ruby_align)),
      ("property-ruby-merge", check(property_ruby_merge)),
      ("property-ruby-position", check(property_ruby_position)),
      ("property-scale", check(property_scale)),
      ("property-scroll-behavior", check(property_scroll_behavior)),
      ("property-scroll-margin", check(property_scroll_margin)),
      ("property-scroll-margin-block", check(property_scroll_margin_block)),
      (
        "property-scroll-margin-block-end",
        check(property_scroll_margin_block_end),
      ),
      (
        "property-scroll-margin-block-start",
        check(property_scroll_margin_block_start),
      ),
      (
        "property-scroll-margin-bottom",
        check(property_scroll_margin_bottom),
      ),
      (
        "property-scroll-margin-inline",
        check(property_scroll_margin_inline),
      ),
      (
        "property-scroll-margin-inline-end",
        check(property_scroll_margin_inline_end),
      ),
      (
        "property-scroll-margin-inline-start",
        check(property_scroll_margin_inline_start),
      ),
      ("property-scroll-margin-left", check(property_scroll_margin_left)),
      ("property-scroll-margin-right", check(property_scroll_margin_right)),
      ("property-scroll-margin-top", check(property_scroll_margin_top)),
      ("property-scroll-padding", check(property_scroll_padding)),
      (
        "property-scroll-padding-block",
        check(property_scroll_padding_block),
      ),
      (
        "property-scroll-padding-block-end",
        check(property_scroll_padding_block_end),
      ),
      (
        "property-scroll-padding-block-start",
        check(property_scroll_padding_block_start),
      ),
      (
        "property-scroll-padding-bottom",
        check(property_scroll_padding_bottom),
      ),
      (
        "property-scroll-padding-inline",
        check(property_scroll_padding_inline),
      ),
      (
        "property-scroll-padding-inline-end",
        check(property_scroll_padding_inline_end),
      ),
      (
        "property-scroll-padding-inline-start",
        check(property_scroll_padding_inline_start),
      ),
      ("property-scroll-padding-left", check(property_scroll_padding_left)),
      (
        "property-scroll-padding-right",
        check(property_scroll_padding_right),
      ),
      ("property-scroll-padding-top", check(property_scroll_padding_top)),
      ("property-scroll-snap-align", check(property_scroll_snap_align)),
      (
        "property-scroll-snap-coordinate",
        check(property_scroll_snap_coordinate),
      ),
      (
        "property-scroll-snap-destination",
        check(property_scroll_snap_destination),
      ),
      (
        "property-scroll-snap-points-x",
        check(property_scroll_snap_points_x),
      ),
      (
        "property-scroll-snap-points-y",
        check(property_scroll_snap_points_y),
      ),
      ("property-scroll-snap-stop", check(property_scroll_snap_stop)),
      ("property-scroll-snap-type", check(property_scroll_snap_type)),
      ("property-scroll-snap-type-x", check(property_scroll_snap_type_x)),
      ("property-scroll-snap-type-y", check(property_scroll_snap_type_y)),
      ("property-scrollbar-color", check(property_scrollbar_color)),
      ("property-scrollbar-width", check(property_scrollbar_width)),
      (
        "property-shape-image-threshold",
        check(property_shape_image_threshold),
      ),
      ("property-shape-margin", check(property_shape_margin)),
      ("property-shape-outside", check(property_shape_outside)),
      ("property-shape-rendering", check(property_shape_rendering)),
      ("property-speak", check(property_speak)),
      ("property-speak-as", check(property_speak_as)),
      ("property-src", check(property_src)),
      ("property-stroke", check(property_stroke)),
      ("property-stroke-dasharray", check(property_stroke_dasharray)),
      ("property-stroke-dashoffset", check(property_stroke_dashoffset)),
      ("property-stroke-linecap", check(property_stroke_linecap)),
      ("property-stroke-linejoin", check(property_stroke_linejoin)),
      ("property-stroke-miterlimit", check(property_stroke_miterlimit)),
      ("property-stroke-opacity", check(property_stroke_opacity)),
      ("property-stroke-width", check(property_stroke_width)),
      ("property-tab-size", check(property_tab_size)),
      ("property-table-layout", check(property_table_layout)),
      ("property-text-align", check(property_text_align)),
      ("property-text-align-last", check(property_text_align_last)),
      ("property-text-anchor", check(property_text_anchor)),
      (
        "property-text-combine-upright",
        check(property_text_combine_upright),
      ),
      ("property-text-decoration", check(property_text_decoration)),
      (
        "property-text-decoration-color",
        check(property_text_decoration_color),
      ),
      (
        "property-text-decoration-line",
        check(property_text_decoration_line),
      ),
      (
        "property-text-decoration-skip",
        check(property_text_decoration_skip),
      ),
      (
        "property-text-decoration-skip-ink",
        check(property_text_decoration_skip_ink),
      ),
      (
        "property-text-decoration-style",
        check(property_text_decoration_style),
      ),
      (
        "property-text-decoration-thickness",
        check(property_text_decoration_thickness),
      ),
      ("property-text-emphasis", check(property_text_emphasis)),
      ("property-text-emphasis-color", check(property_text_emphasis_color)),
      (
        "property-text-emphasis-position",
        check(property_text_emphasis_position),
      ),
      ("property-text-emphasis-style", check(property_text_emphasis_style)),
      ("property-text-indent", check(property_text_indent)),
      ("property-text-justify", check(property_text_justify)),
      ("property-text-orientation", check(property_text_orientation)),
      ("property-text-overflow", check(property_text_overflow)),
      ("property-text-rendering", check(property_text_rendering)),
      ("property-text-shadow", check(property_text_shadow)),
      ("property-text-size-adjust", check(property_text_size_adjust)),
      ("property-text-transform", check(property_text_transform)),
      (
        "property-text-underline-offset",
        check(property_text_underline_offset),
      ),
      (
        "property-text-underline-position",
        check(property_text_underline_position),
      ),
      ("property-top", check(property_top)),
      ("property-touch-action", check(property_touch_action)),
      ("property-transform", check(property_transform)),
      ("property-transform-box", check(property_transform_box)),
      ("property-transform-origin", check(property_transform_origin)),
      ("property-transform-style", check(property_transform_style)),
      ("property-transition", check(property_transition)),
      ("property-transition-delay", check(property_transition_delay)),
      ("property-transition-duration", check(property_transition_duration)),
      ("property-transition-property", check(property_transition_property)),
      (
        "property-transition-timing-function",
        check(property_transition_timing_function),
      ),
      ("property-translate", check(property_translate)),
      ("property-unicode-bidi", check(property_unicode_bidi)),
      ("property-unicode-range", check(property_unicode_range)),
      ("property-user-select", check(property_user_select)),
      ("property-vertical-align", check(property_vertical_align)),
      ("property-visibility", check(property_visibility)),
      ("property-voice-balance", check(property_voice_balance)),
      ("property-voice-duration", check(property_voice_duration)),
      ("property-voice-family", check(property_voice_family)),
      ("property-voice-pitch", check(property_voice_pitch)),
      ("property-voice-range", check(property_voice_range)),
      ("property-voice-rate", check(property_voice_rate)),
      ("property-voice-stress", check(property_voice_stress)),
      ("property-voice-volume", check(property_voice_volume)),
      ("property-white-space", check(property_white_space)),
      ("property-widows", check(property_widows)),
      ("property-width", check(property_width)),
      ("property-will-change", check(property_will_change)),
      ("property-word-break", check(property_word_break)),
      ("property-word-spacing", check(property_word_spacing)),
      ("property-word-wrap", check(property_word_wrap)),
      ("property-writing-mode", check(property_writing_mode)),
      ("property-z-index", check(property_z_index)),
      ("property-zoom", check(property_zoom)),
      ("pseudo-class-selector", check(pseudo_class_selector)),
      ("pseudo-element-selector", check(pseudo_element_selector)),
      ("pseudo-page", check(pseudo_page)),
      ("quote", check(quote)),
      ("ratio", check(ratio)),
      ("relative-selector", check(relative_selector)),
      ("relative-selector-list", check(relative_selector_list)),
      ("relative-size", check(relative_size)),
      ("repeat-style", check(repeat_style)),
      ("right", check(right)),
      ("self-position", check(self_position)),
      ("shadow", check(shadow)),
      ("shadow-t", check(shadow_t)),
      ("shape", check(shape)),
      ("shape-box", check(shape_box)),
      ("shape-radius", check(shape_radius)),
      ("side-or-corner", check(side_or_corner)),
      ("single-animation", check(single_animation)),
      ("single-animation-direction", check(single_animation_direction)),
      ("single-animation-fill-mode", check(single_animation_fill_mode)),
      (
        "single-animation-iteration-count",
        check(single_animation_iteration_count),
      ),
      ("single-animation-play-state", check(single_animation_play_state)),
      ("single-transition", check(single_transition)),
      ("single-transition-property", check(single_transition_property)),
      ("size", check(size)),
      ("step-position", check(step_position)),
      ("step-timing-function", check(step_timing_function)),
      ("subclass-selector", check(subclass_selector)),
      ("supports-condition", check(supports_condition)),
      ("supports-decl", check(supports_decl)),
      ("supports-feature", check(supports_feature)),
      ("supports-in-parens", check(supports_in_parens)),
      ("supports-selector-fn", check(supports_selector_fn)),
      ("svg-length", check(svg_length)),
      ("svg-writing-mode", check(svg_writing_mode)),
      ("symbol", check(symbol)),
      ("target", check(target)),
      ("timing-function", check(timing_function)),
      ("top", check(top)),
      ("track-breadth", check(track_breadth)),
      ("track-group", check(track_group)),
      ("track-list", check(track_list)),
      ("track-list-v0", check(track_list_v0)),
      ("track-minmax", check(track_minmax)),
      ("track-repeat", check(track_repeat)),
      ("track-size", check(track_size)),
      ("transform-function", check(transform_function)),
      ("transform-list", check(transform_list)),
      ("type-or-unit", check(type_or_unit)),
      ("type-selector", check(type_selector)),
      ("viewport-length", check(viewport_length)),
      ("wq-name", check(wq_name)),
      ("x", check(x)),
      ("y", check(y)),
      /* TODO: calc needs to be available in length */
      ("extended-length", check(extended_length)),
      ("extended-frequency", check(extended_frequency)),
      ("extended-angle", check(extended_angle)),
      ("extended-time", check(extended_time)),
      ("extended-percentage", check(extended_percentage)),
    ]),
  );
