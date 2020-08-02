open Standard;
open Combinator;
open Modifier;
open Rule.Match;
open Parser_workaround;

let rec absolute_size = [%value.rec
  "'xx-small' | 'x-small' | 'small' | 'medium' | 'large' | 'x-large' | 'xx-large' | 'xxx-large'"
]
and alpha_value = [%value.rec "<number> | <percentage>"]
and angle_percentage = [%value.rec "<angle> | <percentage>"]
and angular_color_hint = [%value.rec "<angle-percentage>"]
and angular_color_stop = [%value.rec "<color> && [ <color-stop-angle> ]?"]
and angular_color_stop_list = [%value.rec
  "<angular-color-stop> ',' <angular-color-hint> ',' <angular-color-stop>"
]
and animateable_feature = [%value.rec
  "'scroll-position' | 'contents' | <custom-ident>"
]
and attachment = [%value.rec "'scroll' | 'fixed' | 'local'"]
and attr_matcher = [%value.rec "[ '~' | '|' | '^' | '$' | '*' ] '='"]
and attr_modifier = [%value.rec "'i' | 's'"]
and attribute_selector = [%value.rec
  "'[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [ <string-token> | <ident-token> ] [ <attr-modifier> ]? ']'"
]
and auto_repeat = [%value.rec
  "[ 'auto-fill' | 'auto-fit' ] ',' [ <line-names> ]? <fixed-size> [ <line-names> ]?"
]
and auto_track_list = [%value.rec
  "[ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] [ <line-names> ]? <auto-repeat> [ <line-names> ]? [ <fixed-size> | <fixed-repeat> ] [ <line-names> ]?"
]
and baseline_position = [%value.rec "[ 'first' | 'last' ] 'baseline'"]
and basic_shape = [%value.rec
  "<inset()> | <circle()> | <ellipse()> | <polygon()> | <path()>"
]
and bg_image = [%value.rec "'none' | <image>"]
and bg_layer = [%value.rec
  "<bg-image> || <bg-position> '/' <bg-size> || <repeat-style> || <attachment> || <box> || <box>"
]
and bg_position = [%value.rec
  "'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> | [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | 'bottom' | <length-percentage> ] | [ 'center' | [ 'left' | 'right' ] [ <length-percentage> ]? ] && [ 'center' | [ 'top' | 'bottom' ] [ <length-percentage> ]? ]"
]
and bg_size = [%value.rec "<length-percentage> | 'auto' | 'cover' | 'contain'"]
and blend_mode = [%value.rec
  "'normal' | 'multiply' | 'screen' | 'overlay' | 'darken' | 'lighten' | 'color-dodge' | 'color-burn' | 'hard-light' | 'soft-light' | 'difference' | 'exclusion' | 'hue' | 'saturation' | 'color' | 'luminosity'"
]
and box = [%value.rec "'border-box' | 'padding-box' | 'content-box'"]
and calc_product = [%value.rec
  "<calc-value> [ '*' <calc-value> | '/' <number> ]"
]
and calc_sum = [%value.rec "<calc-product> [ '+' | '-' ] <calc-product>"]
and calc_value = [%value.rec
  "<number> | <dimension> | <percentage> | '(' <calc-sum> ')'"
]
and cf_final_image = [%value.rec "<image> | <color>"]
and cf_mixing_image = [%value.rec "[ <percentage> ]? && <image>"]
and class_selector = [%value.rec "'.' <ident-token>"]
and clip_source = [%value.rec "<url>"]
and color = [%value.rec
  "<rgb()> | <rgba()> | <hsl()> | <hsla()> | <hex-color> | <named-color> | 'currentcolor' | <deprecated-system-color>"
]
and color_stop = [%value.rec "<color-stop-length> | <color-stop-angle>"]
and color_stop_angle = [%value.rec "[ <angle-percentage> ]{1,2}"]
and color_stop_length = [%value.rec "[ <length-percentage> ]{1,2}"]
and color_stop_list = [%value.rec
  "<linear-color-stop> ',' <linear-color-hint> ',' <linear-color-stop>"
]
and combinator = [%value.rec "'>' | '+' | '~' | '||'"]
and common_lig_values = [%value.rec
  "'common-ligatures' | 'no-common-ligatures'"
]
and compat_auto = [%value.rec
  "'searchfield' | 'textarea' | 'push-button' | 'slider-horizontal' | 'checkbox' | 'radio' | 'square-button' | 'menulist' | 'listbox' | 'meter' | 'progress-bar'"
]
and complex_selector = [%value.rec
  "<compound-selector> [ <combinator> ]? <compound-selector>"
]
and complex_selector_list = [%value.rec "[ <complex-selector> ]#"]
and composite_style = [%value.rec
  "'clear' | 'copy' | 'source-over' | 'source-in' | 'source-out' | 'source-atop' | 'destination-over' | 'destination-in' | 'destination-out' | 'destination-atop' | 'xor'"
]
and compositing_operator = [%value.rec
  "'add' | 'subtract' | 'intersect' | 'exclude'"
]
and compound_selector = [%value.rec
  "[ <type-selector> ]? [ <subclass-selector> ]* <pseudo-element-selector> [ <pseudo-class-selector> ]*"
]
and compound_selector_list = [%value.rec "[ <compound-selector> ]#"]
and content_distribution = [%value.rec
  "'space-between' | 'space-around' | 'space-evenly' | 'stretch'"
]
and content_list = [%value.rec
  "<string> | 'contents' | <image> | <quote> | <target> | <leader()>"
]
and content_position = [%value.rec
  "'center' | 'start' | 'end' | 'flex-start' | 'flex-end'"
]
and content_replacement = [%value.rec "<image>"]
and contextual_alt_values = [%value.rec "'contextual' | 'no-contextual'"]
and counter_style = [%value.rec "<counter-style-name>"]
and counter_style_name = [%value.rec "<custom-ident>"]
and cubic_bezier_timing_function = [%value.rec
  "'ease' | 'ease-in' | 'ease-out' | 'ease-in-out' | <number> ',' <number> ',' <number> ',' <number>"
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
  "[ <display-outside> ]? && [ 'flow' | 'flow-root' ] && 'list-item'"
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
  "[ <line-names> ]? <track-size> [ <line-names> ]?"
]
and family_name = [%value.rec "<string> | [ <custom-ident> ]+"]
and feature_tag_value = [%value.rec "<string> [ <integer> | 'on' | 'off' ]"]
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
and filter_function_list = [%value.rec "<filter-function> | <url>"]
and final_bg_layer = [%value.rec
  "<'background-color'> || <bg-image> || <bg-position> '/' <bg-size> || <repeat-style> || <attachment> || <box> || <box>"
]
and fixed_breadth = [%value.rec "<length-percentage>"]
and fixed_repeat = [%value.rec
  "<positive-integer> ',' [ <line-names> ]? <fixed-size> [ <line-names> ]?"
]
and fixed_size = [%value.rec
  "<fixed-breadth> | <fixed-breadth> ',' <track-breadth> | <inflexible-breadth> ',' <fixed-breadth>"
]
and font_stretch_absolute = [%value.rec
  "'normal' | 'ultra-condensed' | 'extra-condensed' | 'condensed' | 'semi-condensed' | 'semi-expanded' | 'expanded' | 'extra-expanded' | 'ultra-expanded' | <percentage>"
]
and font_variant_css21 = [%value.rec "'normal' | 'small-caps'"]
and font_weight_absolute = [%value.rec "'normal' | 'bold' | <number>"]
and frequency_percentage = [%value.rec "<frequency> | <percentage>"]
and function_attr = [%value.rec
  "<attr-name> [ <type-or-unit> ]? ',' <attr-fallback>"
]
and function_blur = [%value.rec "<length>"]
and function_brightness = [%value.rec "<number-percentage>"]
and function_calc = [%value.rec "<calc-sum>"]
and function_circle = [%value.rec "<shape-radius> 'at' <position>"]
and function_clamp = [%value.rec "[ <calc-sum> ]#{3}"]
and function_conic_gradient = [%value.rec
  "'from' <angle> 'at' <position> ',' <angular-color-stop-list>"
]
and function_contrast = [%value.rec "<number-percentage>"]
and function_counter = [%value.rec "<custom-ident> ',' [ <counter-style> ]?"]
and function_counters = [%value.rec
  "<custom-ident> ',' <string> ',' [ <counter-style> ]?"
]
and function_cross_fade = [%value.rec
  "<cf-mixing-image> ',' [ <cf-final-image> ]?"
]
and function_drop_shadow = [%value.rec "[ <length> ]{2,3} [ <color> ]?"]
and function_element = [%value.rec "<id-selector>"]
and function_ellipse = [%value.rec "[ <shape-radius> ]{2} 'at' <position>"]
and function_env = [%value.rec "<custom-ident> ',' [ <declaration-value> ]?"]
and function_fit_content = [%value.rec "<length> | <percentage>"]
and function_grayscale = [%value.rec "<number-percentage>"]
and function_hsl = [%value.rec
  "<hue> <percentage> <percentage> '/' <alpha-value> | <hue> ',' <percentage> ',' <percentage> ',' [ <alpha-value> ]?"
]
and function_hsla = [%value.rec
  "<hue> <percentage> <percentage> '/' <alpha-value> | <hue> ',' <percentage> ',' <percentage> ',' [ <alpha-value> ]?"
]
and function_hue_rotate = [%value.rec "<angle>"]
and function_image = [%value.rec
  "[ <image-tags> ]? [ <image-src> ]? ',' [ <color> ]?"
]
and function_image_set = [%value.rec "[ <image-set-option> ]#"]
and function_inset = [%value.rec
  "[ <length-percentage> ]{1,4} 'round' <'border-radius'>"
]
and function_invert = [%value.rec "<number-percentage>"]
and function_leader = [%value.rec "<leader-type>"]
and function_linear_gradient = [%value.rec
  "[ <angle> | 'to' <side-or-corner> ] ',' <color-stop-list>"
]
and function_matrix = [%value.rec "[ <number> ]#{6}"]
and function_matrix3d = [%value.rec "[ <number> ]#{16}"]
and function_max = [%value.rec "[ <calc-sum> ]#"]
and function_min = [%value.rec "[ <calc-sum> ]#"]
and function_minmax = [%value.rec
  "[ <length> | <percentage> | 'min-content' | 'max-content' | 'auto' ] ',' [ <length> | <percentage> | <property_flex> | 'min-content' | 'max-content' | 'auto' ]"
]
and function_opacity = [%value.rec "<number-percentage>"]
and function_paint = [%value.rec "<ident> ',' [ <declaration-value> ]?"]
and function_path = [%value.rec "<fill-rule> ',' <string>"]
and function_perspective = [%value.rec "<length>"]
and function_polygon = [%value.rec
  "[ <fill-rule> ]? ',' <length-percentage> <length-percentage>"
]
and function_radial_gradient = [%value.rec
  "[ <ending-shape> || <size> ] 'at' <position> ',' <color-stop-list>"
]
and function_repeating_linear_gradient = [%value.rec
  "[ <angle> | 'to' <side-or-corner> ] ',' <color-stop-list>"
]
and function_repeating_radial_gradient = [%value.rec
  "[ <ending-shape> || <size> ] 'at' <position> ',' <color-stop-list>"
]
and function_rgb = [%value.rec
  "[ <percentage> ]{3} '/' <alpha-value> | [ <number> ]{3} '/' <alpha-value> | [ <percentage> ]#{3} ',' [ <alpha-value> ]? | [ <number> ]#{3} ',' [ <alpha-value> ]?"
]
and function_rgba = [%value.rec
  "[ <percentage> ]{3} '/' <alpha-value> | [ <number> ]{3} '/' <alpha-value> | [ <percentage> ]#{3} ',' [ <alpha-value> ]? | [ <number> ]#{3} ',' [ <alpha-value> ]?"
]
and function_rotate = [%value.rec "<angle> | <zero>"]
and function_rotate3d = [%value.rec
  "<number> ',' <number> ',' <number> ',' [ <angle> | <zero> ]"
]
and function_rotateX = [%value.rec "<angle> | <zero>"]
and function_rotateY = [%value.rec "<angle> | <zero>"]
and function_rotateZ = [%value.rec "<angle> | <zero>"]
and function_saturate = [%value.rec "<number-percentage>"]
and function_scale = [%value.rec "<number> ',' [ <number> ]?"]
and function_scale3d = [%value.rec "<number> ',' <number> ',' <number>"]
and function_scaleX = [%value.rec "<number>"]
and function_scaleY = [%value.rec "<number>"]
and function_scaleZ = [%value.rec "<number>"]
and function_sepia = [%value.rec "<number-percentage>"]
and function_skew = [%value.rec
  "[ <angle> | <zero> ] ',' [ <angle> | <zero> ]"
]
and function_skewX = [%value.rec "<angle> | <zero>"]
and function_skewY = [%value.rec "<angle> | <zero>"]
and function_target_counter = [%value.rec
  "[ <string> | <url> ] ',' <custom-ident> ',' [ <counter-style> ]?"
]
and function_target_counters = [%value.rec
  "[ <string> | <url> ] ',' <custom-ident> ',' <string> ',' [ <counter-style> ]?"
]
and function_target_text = [%value.rec
  "[ <string> | <url> ] ',' [ 'content' | 'before' | 'after' | 'first-letter' ]"
]
and function_translate = [%value.rec
  "<length-percentage> ',' [ <length-percentage> ]?"
]
and function_translate3d = [%value.rec
  "<length-percentage> ',' <length-percentage> ',' <length>"
]
and function_translateX = [%value.rec "<length-percentage>"]
and function_translateY = [%value.rec "<length-percentage>"]
and function_translateZ = [%value.rec "<length>"]
and function_var = [%value.rec
  "<custom-property-name> ',' [ <declaration-value> ]?"
]
and general_enclosed = [%value.rec
  "<function-token> <any-value> ')' | '(' <ident> <any-value> ')'"
]
and generic_family = [%value.rec
  "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace'"
]
and generic_name = [%value.rec
  "'serif' | 'sans-serif' | 'cursive' | 'fantasy' | 'monospace'"
]
and geometry_box = [%value.rec
  "<shape-box> | 'fill-box' | 'stroke-box' | 'view-box'"
]
and gradient = [%value.rec
  "<linear-gradient()> | <repeating-linear-gradient()> | <radial-gradient()> | <repeating-radial-gradient()> | <conic-gradient()>"
]
and grid_line = [%value.rec
  "'auto' | <custom-ident> | <integer> && [ <custom-ident> ]? | 'span' && [ <integer> || <custom-ident> ]"
]
and historical_lig_values = [%value.rec
  "'historical-ligatures' | 'no-historical-ligatures'"
]
and hue = [%value.rec "<number> | <angle>"]
and id_selector = [%value.rec "<hash-token>"]
and image = [%value.rec
  "<url> | <image()> | <image-set()> | <element()> | <paint()> | <cross-fade()> | <gradient>"
]
and image_set_option = [%value.rec "[ <image> | <string> ] <resolution>"]
and image_src = [%value.rec "<url> | <string>"]
and image_tags = [%value.rec "'ltr' | 'rtl'"]
and inflexible_breadth = [%value.rec
  "<length> | <percentage> | 'min-content' | 'max-content' | 'auto'"
]
and keyframe_block = [%value.rec
  "[ <keyframe-selector> ]# '{' <declaration-list> '}'"
]
and keyframe_block_list = [%value.rec "[ <keyframe-block> ]+"]
and keyframe_selector = [%value.rec "'from' | 'to' | <percentage>"]
and keyframes_name = [%value.rec "<custom-ident> | <string>"]
and leader_type = [%value.rec "'dotted' | 'solid' | 'space' | <string>"]
and length_percentage = [%value.rec "<length> | <percentage>"]
and line_name_list = [%value.rec "<line-names> | <name-repeat>"]
and line_names = [%value.rec "'[' [ <custom-ident> ]* ']'"]
and line_style = [%value.rec
  "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | 'ridge' | 'inset' | 'outset'"
]
and line_width = [%value.rec "<length> | 'thin' | 'medium' | 'thick'"]
and linear_color_hint = [%value.rec "<length-percentage>"]
and linear_color_stop = [%value.rec "<color> [ <color-stop-length> ]?"]
and mask_layer = [%value.rec
  "<mask-reference> || <position> '/' <bg-size> || <repeat-style> || <geometry-box> || [ <geometry-box> | 'no-clip' ] || <compositing-operator> || <masking-mode>"
]
and mask_position = [%value.rec
  "[ <length-percentage> | 'left' | 'center' | 'right' ] [ <length-percentage> | 'top' | 'center' | 'bottom' ]"
]
and mask_reference = [%value.rec "'none' | <image> | <mask-source>"]
and mask_source = [%value.rec "<url>"]
and masking_mode = [%value.rec "'alpha' | 'luminance' | 'match-source'"]
and media_and = [%value.rec "<media-in-parens> 'and' <media-in-parens>"]
and media_condition = [%value.rec
  "<media-not> | <media-and> | <media-or> | <media-in-parens>"
]
and media_condition_without_or = [%value.rec
  "<media-not> | <media-and> | <media-in-parens>"
]
and media_feature = [%value.rec
  "'(' [ <mf-plain> | <mf-boolean> | <mf-range> ] ')'"
]
and media_in_parens = [%value.rec
  "'(' <media-condition> ')' | <media-feature> | <general-enclosed>"
]
and media_not = [%value.rec "'not' <media-in-parens>"]
and media_or = [%value.rec "<media-in-parens> 'or' <media-in-parens>"]
and media_query = [%value.rec
  "<media-condition> | [ 'not' | 'only' ] <media-type> 'and' <media-condition-without-or>"
]
and media_query_list = [%value.rec "[ <media-query> ]#"]
and media_type = [%value.rec "<ident>"]
and mf_boolean = [%value.rec "<mf-name>"]
and mf_name = [%value.rec "<ident>"]
and mf_plain = [%value.rec "<mf-name> ':' <mf-value>"]
and mf_range = [%value.rec
  "<mf-name> [ '<' | '>' ] [ '=' ]? <mf-value> | <mf-value> [ '<' | '>' ] [ '=' ]? <mf-name> | <mf-value> '<' [ '=' ]? <mf-name> '<' [ '=' ]? <mf-value> | <mf-value> '>' [ '=' ]? <mf-name> '>' [ '=' ]? <mf-value>"
]
and mf_value = [%value.rec "<number> | <dimension> | <ident> | <ratio>"]
and named_color = [%value.rec
  "'transparent' | 'aliceblue' | 'antiquewhite' | 'aqua' | 'aquamarine' | 'azure' | 'beige' | 'bisque' | 'black' | 'blanchedalmond' | 'blue' | 'blueviolet' | 'brown' | 'burlywood' | 'cadetblue' | 'chartreuse' | 'chocolate' | 'coral' | 'cornflowerblue' | 'cornsilk' | 'crimson' | 'cyan' | 'darkblue' | 'darkcyan' | 'darkgoldenrod' | 'darkgray' | 'darkgreen' | 'darkgrey' | 'darkkhaki' | 'darkmagenta' | 'darkolivegreen' | 'darkorange' | 'darkorchid' | 'darkred' | 'darksalmon' | 'darkseagreen' | 'darkslateblue' | 'darkslategray' | 'darkslategrey' | 'darkturquoise' | 'darkviolet' | 'deeppink' | 'deepskyblue' | 'dimgray' | 'dimgrey' | 'dodgerblue' | 'firebrick' | 'floralwhite' | 'forestgreen' | 'fuchsia' | 'gainsboro' | 'ghostwhite' | 'gold' | 'goldenrod' | 'gray' | 'green' | 'greenyellow' | 'grey' | 'honeydew' | 'hotpink' | 'indianred' | 'indigo' | 'ivory' | 'khaki' | 'lavender' | 'lavenderblush' | 'lawngreen' | 'lemonchiffon' | 'lightblue' | 'lightcoral' | 'lightcyan' | 'lightgoldenrodyellow' | 'lightgray' | 'lightgreen' | 'lightgrey' | 'lightpink' | 'lightsalmon' | 'lightseagreen' | 'lightskyblue' | 'lightslategray' | 'lightslategrey' | 'lightsteelblue' | 'lightyellow' | 'lime' | 'limegreen' | 'linen' | 'magenta' | 'maroon' | 'mediumaquamarine' | 'mediumblue' | 'mediumorchid' | 'mediumpurple' | 'mediumseagreen' | 'mediumslateblue' | 'mediumspringgreen' | 'mediumturquoise' | 'mediumvioletred' | 'midnightblue' | 'mintcream' | 'mistyrose' | 'moccasin' | 'navajowhite' | 'navy' | 'oldlace' | 'olive' | 'olivedrab' | 'orange' | 'orangered' | 'orchid' | 'palegoldenrod' | 'palegreen' | 'paleturquoise' | 'palevioletred' | 'papayawhip' | 'peachpuff' | 'peru' | 'pink' | 'plum' | 'powderblue' | 'purple' | 'rebeccapurple' | 'red' | 'rosybrown' | 'royalblue' | 'saddlebrown' | 'salmon' | 'sandybrown' | 'seagreen' | 'seashell' | 'sienna' | 'silver' | 'skyblue' | 'slateblue' | 'slategray' | 'slategrey' | 'snow' | 'springgreen' | 'steelblue' | 'tan' | 'teal' | 'thistle' | 'tomato' | 'turquoise' | 'violet' | 'wheat' | 'white' | 'whitesmoke' | 'yellow' | 'yellowgreen'"
]
and namespace_prefix = [%value.rec "<ident>"]
and ns_prefix = [%value.rec "[ <ident-token> | '*' ] '|'"]
and nth = [%value.rec "<an-plus-b> | 'even' | 'odd'"]
and number_percentage = [%value.rec "<number> | <percentage>"]
and numeric_figure_values = [%value.rec "'lining-nums' | 'oldstyle-nums'"]
and numeric_fraction_values = [%value.rec
  "'diagonal-fractions' | 'stacked-fractions'"
]
and numeric_spacing_values = [%value.rec
  "'proportional-nums' | 'tabular-nums'"
]
and outline_radius = [%value.rec "<length> | <percentage>"]
and overflow_position = [%value.rec "'unsafe' | 'safe'"]
and page_body = [%value.rec
  "[ <declaration> ]? ';' <page-body> | <page-margin-box> <page-body>"
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
and page_selector_list = [%value.rec "[ <page-selector> ]#"]
and position = [%value.rec
  "[ 'left' | 'center' | 'right' ] || [ 'top' | 'center' | 'bottom' ] | [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | 'bottom' | <length-percentage> ] | [ 'left' | 'right' ] <length-percentage> && [ 'top' | 'bottom' ] <length-percentage>"
]
and property__moz_appearance = [%value.rec
  "'none' | 'button' | 'button-arrow-down' | 'button-arrow-next' | 'button-arrow-previous' | 'button-arrow-up' | 'button-bevel' | 'button-focus' | 'caret' | 'checkbox' | 'checkbox-container' | 'checkbox-label' | 'checkmenuitem' | 'dualbutton' | 'groupbox' | 'listbox' | 'listitem' | 'menuarrow' | 'menubar' | 'menucheckbox' | 'menuimage' | 'menuitem' | 'menuitemtext' | 'menulist' | 'menulist-button' | 'menulist-text' | 'menulist-textfield' | 'menupopup' | 'menuradio' | 'menuseparator' | 'meterbar' | 'meterchunk' | 'progressbar' | 'progressbar-vertical' | 'progresschunk' | 'progresschunk-vertical' | 'radio' | 'radio-container' | 'radio-label' | 'radiomenuitem' | 'range' | 'range-thumb' | 'resizer' | 'resizerpanel' | 'scale-horizontal' | 'scalethumbend' | 'scalethumb-horizontal' | 'scalethumbstart' | 'scalethumbtick' | 'scalethumb-vertical' | 'scale-vertical' | 'scrollbarbutton-down' | 'scrollbarbutton-left' | 'scrollbarbutton-right' | 'scrollbarbutton-up' | 'scrollbarthumb-horizontal' | 'scrollbarthumb-vertical' | 'scrollbartrack-horizontal' | 'scrollbartrack-vertical' | 'searchfield' | 'separator' | 'sheet' | 'spinner' | 'spinner-downbutton' | 'spinner-textfield' | 'spinner-upbutton' | 'splitter' | 'statusbar' | 'statusbarpanel' | 'tab' | 'tabpanel' | 'tabpanels' | 'tab-scroll-arrow-back' | 'tab-scroll-arrow-forward' | 'textfield' | 'textfield-multiline' | 'toolbar' | 'toolbarbutton' | 'toolbarbutton-dropdown' | 'toolbargripper' | 'toolbox' | 'tooltip' | 'treeheader' | 'treeheadercell' | 'treeheadersortarrow' | 'treeitem' | 'treeline' | 'treetwisty' | 'treetwistyopen' | 'treeview' | '-moz-mac-unified-toolbar' | '-moz-win-borderless-glass' | '-moz-win-browsertabbar-toolbox' | '-moz-win-communicationstext' | '-moz-win-communications-toolbox' | '-moz-win-exclude-glass' | '-moz-win-glass' | '-moz-win-mediatext' | '-moz-win-media-toolbox' | '-moz-window-button-box' | '-moz-window-button-box-maximized' | '-moz-window-button-close' | '-moz-window-button-maximize' | '-moz-window-button-minimize' | '-moz-window-button-restore' | '-moz-window-frame-bottom' | '-moz-window-frame-left' | '-moz-window-frame-right' | '-moz-window-titlebar' | '-moz-window-titlebar-maximized'"
]
and property__moz_binding = [%value.rec "<url> | 'none'"]
and property__moz_border_bottom_colors = [%value.rec "[ <color> ]+ | 'none'"]
and property__moz_border_left_colors = [%value.rec "[ <color> ]+ | 'none'"]
and property__moz_border_right_colors = [%value.rec "[ <color> ]+ | 'none'"]
and property__moz_border_top_colors = [%value.rec "[ <color> ]+ | 'none'"]
and property__moz_context_properties = [%value.rec
  "'none' | 'fill' | 'fill-opacity' | 'stroke' | 'stroke-opacity'"
]
and property__moz_float_edge = [%value.rec
  "'border-box' | 'content-box' | 'margin-box' | 'padding-box'"
]
and property__moz_force_broken_image_icon = [%value.rec "<integer>"]
and property__moz_image_region = [%value.rec "<shape> | 'auto'"]
and property__moz_orient = [%value.rec
  "'inline' | 'block' | 'horizontal' | 'vertical'"
]
and property__moz_outline_radius = [%value.rec
  "[ <outline-radius> ]{1,4} '/' [ <outline-radius> ]{1,4}"
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
and property__moz_window_dragging = [%value.rec "'drag' | 'no-drag'"]
and property__moz_window_shadow = [%value.rec
  "'default' | 'menu' | 'tooltip' | 'sheet' | 'none'"
]
and property__ms_accelerator = [%value.rec "'false' | 'true'"]
and property__ms_block_progression = [%value.rec "'tb' | 'rl' | 'bt' | 'lr'"]
and property__ms_content_zoom_chaining = [%value.rec "'none' | 'chained'"]
and property__ms_content_zoom_limit = [%value.rec
  "<'-ms-content-zoom-limit-min'> <'-ms-content-zoom-limit-max'>"
]
and property__ms_content_zoom_limit_max = [%value.rec "<percentage>"]
and property__ms_content_zoom_limit_min = [%value.rec "<percentage>"]
and property__ms_content_zoom_snap = [%value.rec
  "<'-ms-content-zoom-snap-type'> || <'-ms-content-zoom-snap-points'>"
]
and property__ms_content_zoom_snap_points = [%value.rec
  "<percentage> ',' <percentage> | [ <percentage> ]#"
]
and property__ms_content_zoom_snap_type = [%value.rec
  "'none' | 'proximity' | 'mandatory'"
]
and property__ms_content_zooming = [%value.rec "'none' | 'zoom'"]
and property__ms_filter = [%value.rec "<string>"]
and property__ms_flow_from = [%value.rec "'none' | <custom-ident>"]
and property__ms_flow_into = [%value.rec "'none' | <custom-ident>"]
and property__ms_high_contrast_adjust = [%value.rec "'auto' | 'none'"]
and property__ms_hyphenate_limit_chars = [%value.rec
  "'auto' | [ <integer> ]{1,3}"
]
and property__ms_hyphenate_limit_lines = [%value.rec "'no-limit' | <integer>"]
and property__ms_hyphenate_limit_zone = [%value.rec "<percentage> | <length>"]
and property__ms_ime_align = [%value.rec "'auto' | 'after'"]
and property__ms_overflow_style = [%value.rec
  "'auto' | 'none' | 'scrollbar' | '-ms-autohiding-scrollbar'"
]
and property__ms_scroll_chaining = [%value.rec "'chained' | 'none'"]
and property__ms_scroll_limit = [%value.rec
  "<'-ms-scroll-limit-x-min'> <'-ms-scroll-limit-y-min'> <'-ms-scroll-limit-x-max'> <'-ms-scroll-limit-y-max'>"
]
and property__ms_scroll_limit_x_max = [%value.rec "'auto' | <length>"]
and property__ms_scroll_limit_x_min = [%value.rec "<length>"]
and property__ms_scroll_limit_y_max = [%value.rec "'auto' | <length>"]
and property__ms_scroll_limit_y_min = [%value.rec "<length>"]
and property__ms_scroll_rails = [%value.rec "'none' | 'railed'"]
and property__ms_scroll_snap_points_x = [%value.rec
  "<length-percentage> ',' <length-percentage> | [ <length-percentage> ]#"
]
and property__ms_scroll_snap_points_y = [%value.rec
  "<length-percentage> ',' <length-percentage> | [ <length-percentage> ]#"
]
and property__ms_scroll_snap_type = [%value.rec
  "'none' | 'proximity' | 'mandatory'"
]
and property__ms_scroll_snap_x = [%value.rec
  "<'-ms-scroll-snap-type'> <'-ms-scroll-snap-points-x'>"
]
and property__ms_scroll_snap_y = [%value.rec
  "<'-ms-scroll-snap-type'> <'-ms-scroll-snap-points-y'>"
]
and property__ms_scroll_translation = [%value.rec
  "'none' | 'vertical-to-horizontal'"
]
and property__ms_scrollbar_3dlight_color = [%value.rec "<color>"]
and property__ms_scrollbar_arrow_color = [%value.rec "<color>"]
and property__ms_scrollbar_base_color = [%value.rec "<color>"]
and property__ms_scrollbar_darkshadow_color = [%value.rec "<color>"]
and property__ms_scrollbar_face_color = [%value.rec "<color>"]
and property__ms_scrollbar_highlight_color = [%value.rec "<color>"]
and property__ms_scrollbar_shadow_color = [%value.rec "<color>"]
and property__ms_scrollbar_track_color = [%value.rec "<color>"]
and property__ms_text_autospace = [%value.rec
  "'none' | 'ideograph-alpha' | 'ideograph-numeric' | 'ideograph-parenthesis' | 'ideograph-space'"
]
and property__ms_touch_select = [%value.rec "'grippers' | 'none'"]
and property__ms_user_select = [%value.rec "'none' | 'element' | 'text'"]
and property__ms_wrap_flow = [%value.rec
  "'auto' | 'both' | 'start' | 'end' | 'maximum' | 'clear'"
]
and property__ms_wrap_margin = [%value.rec "<length>"]
and property__ms_wrap_through = [%value.rec "'wrap' | 'none'"]
and property__webkit_appearance = [%value.rec
  "'none' | 'button' | 'button-bevel' | 'caret' | 'checkbox' | 'default-button' | 'inner-spin-button' | 'listbox' | 'listitem' | 'media-controls-background' | 'media-controls-fullscreen-background' | 'media-current-time-display' | 'media-enter-fullscreen-button' | 'media-exit-fullscreen-button' | 'media-fullscreen-button' | 'media-mute-button' | 'media-overlay-play-button' | 'media-play-button' | 'media-seek-back-button' | 'media-seek-forward-button' | 'media-slider' | 'media-sliderthumb' | 'media-time-remaining-display' | 'media-toggle-closed-captions-button' | 'media-volume-slider' | 'media-volume-slider-container' | 'media-volume-sliderthumb' | 'menulist' | 'menulist-button' | 'menulist-text' | 'menulist-textfield' | 'meter' | 'progress-bar' | 'progress-bar-value' | 'push-button' | 'radio' | 'searchfield' | 'searchfield-cancel-button' | 'searchfield-decoration' | 'searchfield-results-button' | 'searchfield-results-decoration' | 'slider-horizontal' | 'slider-vertical' | 'sliderthumb-horizontal' | 'sliderthumb-vertical' | 'square-button' | 'textarea' | 'textfield'"
]
and property__webkit_border_before = [%value.rec
  "<'border-width'> || <'border-style'> || <'color'>"
]
and property__webkit_border_before_color = [%value.rec "<'color'>"]
and property__webkit_border_before_style = [%value.rec "<'border-style'>"]
and property__webkit_border_before_width = [%value.rec "<'border-width'>"]
and property__webkit_box_reflect = [%value.rec
  "[ 'above' | 'below' | 'right' | 'left' ] [ <length> ]? [ <image> ]?"
]
and property__webkit_line_clamp = [%value.rec "'none' | <integer>"]
and property__webkit_mask = [%value.rec
  "<mask-reference> || <position> '/' <bg-size> || <repeat-style> || [ <box> | 'border' | 'padding' | 'content' | 'text' ] || [ <box> | 'border' | 'padding' | 'content' ]"
]
and property__webkit_mask_attachment = [%value.rec "[ <attachment> ]#"]
and property__webkit_mask_clip = [%value.rec
  "<box> | 'border' | 'padding' | 'content' | 'text'"
]
and property__webkit_mask_composite = [%value.rec "[ <composite-style> ]#"]
and property__webkit_mask_image = [%value.rec "[ <mask-reference> ]#"]
and property__webkit_mask_origin = [%value.rec
  "<box> | 'border' | 'padding' | 'content'"
]
and property__webkit_mask_position = [%value.rec "[ <position> ]#"]
and property__webkit_mask_position_x = [%value.rec
  "<length-percentage> | 'left' | 'center' | 'right'"
]
and property__webkit_mask_position_y = [%value.rec
  "<length-percentage> | 'top' | 'center' | 'bottom'"
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
and property__webkit_tap_highlight_color = [%value.rec "<color>"]
and property__webkit_text_fill_color = [%value.rec "<color>"]
and property__webkit_text_stroke = [%value.rec "<length> || <color>"]
and property__webkit_text_stroke_color = [%value.rec "<color>"]
and property__webkit_text_stroke_width = [%value.rec "<length>"]
and property__webkit_touch_callout = [%value.rec "'default' | 'none'"]
and property__webkit_user_modify = [%value.rec
  "'read-only' | 'read-write' | 'read-write-plaintext-only'"
]
and property_align_content = [%value.rec
  "'normal' | <baseline-position> | <content-distribution> | [ <overflow-position> ]? <content-position>"
]
and property_align_items = [%value.rec
  "'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? <self-position>"
]
and property_align_self = [%value.rec
  "'auto' | 'normal' | 'stretch' | <baseline-position> | [ <overflow-position> ]? <self-position>"
]
and property_all = [%value.rec "'initial' | 'inherit' | 'unset' | 'revert'"]
and property_animation = [%value.rec "[ <single-animation> ]#"]
and property_animation_delay = [%value.rec "[ <time> ]#"]
and property_animation_direction = [%value.rec
  "[ <single-animation-direction> ]#"
]
and property_animation_duration = [%value.rec "[ <time> ]#"]
and property_animation_fill_mode = [%value.rec
  "[ <single-animation-fill-mode> ]#"
]
and property_animation_iteration_count = [%value.rec
  "[ <single-animation-iteration-count> ]#"
]
and property_animation_name = [%value.rec "'none' | <keyframes-name>"]
and property_animation_play_state = [%value.rec
  "[ <single-animation-play-state> ]#"
]
and property_animation_timing_function = [%value.rec "[ <timing-function> ]#"]
and property_appearance = [%value.rec
  "'none' | 'auto' | 'button' | 'textfield' | 'menulist-button' | <compat-auto>"
]
and property_aspect_ratio = [%value.rec "'auto' | <ratio>"]
and property_azimuth = [%value.rec
  "<angle> | [ 'left-side' | 'far-left' | 'left' | 'center-left' | 'center' | 'center-right' | 'right' | 'far-right' | 'right-side' ] || 'behind' | 'leftwards' | 'rightwards'"
]
and property_backdrop_filter = [%value.rec "'none' | <filter-function-list>"]
and property_backface_visibility = [%value.rec "'visible' | 'hidden'"]
and property_background = [%value.rec "<bg-layer> ',' <final-bg-layer>"]
and property_background_attachment = [%value.rec "[ <attachment> ]#"]
and property_background_blend_mode = [%value.rec "[ <blend-mode> ]#"]
and property_background_clip = [%value.rec "[ <box> ]#"]
and property_background_color = [%value.rec "<color>"]
and property_background_image = [%value.rec "[ <bg-image> ]#"]
and property_background_origin = [%value.rec "[ <box> ]#"]
and property_background_position = [%value.rec "[ <bg-position> ]#"]
and property_background_position_x = [%value.rec
  "'center' | [ 'left' | 'right' | 'x-start' | 'x-end' ] [ <length-percentage> ]?"
]
and property_background_position_y = [%value.rec
  "'center' | [ 'top' | 'bottom' | 'y-start' | 'y-end' ] [ <length-percentage> ]?"
]
and property_background_repeat = [%value.rec "[ <repeat-style> ]#"]
and property_background_size = [%value.rec "[ <bg-size> ]#"]
and property_block_overflow = [%value.rec "'clip' | 'ellipsis' | <string>"]
and property_block_size = [%value.rec "<'width'>"]
and property_border = [%value.rec "<line-width> || <line-style> || <color>"]
and property_border_block = [%value.rec
  "<'border-top-width'> || <'border-top-style'> || <'color'>"
]
and property_border_block_color = [%value.rec "[ <'border-top-color'> ]{1,2}"]
and property_border_block_end = [%value.rec
  "<'border-top-width'> || <'border-top-style'> || <'color'>"
]
and property_border_block_end_color = [%value.rec "<'border-top-color'>"]
and property_border_block_end_style = [%value.rec "<'border-top-style'>"]
and property_border_block_end_width = [%value.rec "<'border-top-width'>"]
and property_border_block_start = [%value.rec
  "<'border-top-width'> || <'border-top-style'> || <'color'>"
]
and property_border_block_start_color = [%value.rec "<'border-top-color'>"]
and property_border_block_start_style = [%value.rec "<'border-top-style'>"]
and property_border_block_start_width = [%value.rec "<'border-top-width'>"]
and property_border_block_style = [%value.rec "<'border-top-style'>"]
and property_border_block_width = [%value.rec "<'border-top-width'>"]
and property_border_bottom = [%value.rec
  "<line-width> || <line-style> || <color>"
]
and property_border_bottom_color = [%value.rec "<'border-top-color'>"]
and property_border_bottom_left_radius = [%value.rec
  "[ <length-percentage> ]{1,2}"
]
and property_border_bottom_right_radius = [%value.rec
  "[ <length-percentage> ]{1,2}"
]
and property_border_bottom_style = [%value.rec "<line-style>"]
and property_border_bottom_width = [%value.rec "<line-width>"]
and property_border_collapse = [%value.rec "'collapse' | 'separate'"]
and property_border_color = [%value.rec "[ <color> ]{1,4}"]
and property_border_end_end_radius = [%value.rec
  "[ <length-percentage> ]{1,2}"
]
and property_border_end_start_radius = [%value.rec
  "[ <length-percentage> ]{1,2}"
]
and property_border_image = [%value.rec
  "<'border-image-source'> || <'border-image-slice'> [ '/' <'border-image-width'> | '/' [ <'border-image-width'> ]? '/' <'border-image-outset'> ] || <'border-image-repeat'>"
]
and property_border_image_outset = [%value.rec "<length> | <number>"]
and property_border_image_repeat = [%value.rec
  "'stretch' | 'repeat' | 'round' | 'space'"
]
and property_border_image_slice = [%value.rec
  "[ <number-percentage> ]{1,4} && [ 'fill' ]?"
]
and property_border_image_source = [%value.rec "'none' | <image>"]
and property_border_image_width = [%value.rec
  "<length-percentage> | <number> | 'auto'"
]
and property_border_inline = [%value.rec
  "<'border-top-width'> || <'border-top-style'> || <'color'>"
]
and property_border_inline_color = [%value.rec "[ <'border-top-color'> ]{1,2}"]
and property_border_inline_end = [%value.rec
  "<'border-top-width'> || <'border-top-style'> || <'color'>"
]
and property_border_inline_end_color = [%value.rec "<'border-top-color'>"]
and property_border_inline_end_style = [%value.rec "<'border-top-style'>"]
and property_border_inline_end_width = [%value.rec "<'border-top-width'>"]
and property_border_inline_start = [%value.rec
  "<'border-top-width'> || <'border-top-style'> || <'color'>"
]
and property_border_inline_start_color = [%value.rec "<'border-top-color'>"]
and property_border_inline_start_style = [%value.rec "<'border-top-style'>"]
and property_border_inline_start_width = [%value.rec "<'border-top-width'>"]
and property_border_inline_style = [%value.rec "<'border-top-style'>"]
and property_border_inline_width = [%value.rec "<'border-top-width'>"]
and property_border_left = [%value.rec
  "<line-width> || <line-style> || <color>"
]
and property_border_left_color = [%value.rec "<color>"]
and property_border_left_style = [%value.rec "<line-style>"]
and property_border_left_width = [%value.rec "<line-width>"]
and property_border_radius = [%value.rec
  "[ <length-percentage> ]{1,4} '/' [ <length-percentage> ]{1,4}"
]
and property_border_right = [%value.rec
  "<line-width> || <line-style> || <color>"
]
and property_border_right_color = [%value.rec "<color>"]
and property_border_right_style = [%value.rec "<line-style>"]
and property_border_right_width = [%value.rec "<line-width>"]
and property_border_spacing = [%value.rec "<length> [ <length> ]?"]
and property_border_start_end_radius = [%value.rec
  "[ <length-percentage> ]{1,2}"
]
and property_border_start_start_radius = [%value.rec
  "[ <length-percentage> ]{1,2}"
]
and property_border_style = [%value.rec "[ <line-style> ]{1,4}"]
and property_border_top = [%value.rec
  "<line-width> || <line-style> || <color>"
]
and property_border_top_color = [%value.rec "<color>"]
and property_border_top_left_radius = [%value.rec
  "[ <length-percentage> ]{1,2}"
]
and property_border_top_right_radius = [%value.rec
  "[ <length-percentage> ]{1,2}"
]
and property_border_top_style = [%value.rec "<line-style>"]
and property_border_top_width = [%value.rec "<line-width>"]
and property_border_width = [%value.rec "[ <line-width> ]{1,4}"]
and property_bottom = [%value.rec "<length> | <percentage> | 'auto'"]
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
and property_box_shadow = [%value.rec "'none' | [ <shadow> ]#"]
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
and property_color = [%value.rec "<color>"]
and property_color_adjust = [%value.rec "'economy' | 'exact'"]
and property_column_count = [%value.rec "<integer> | 'auto'"]
and property_column_fill = [%value.rec "'auto' | 'balance' | 'balance-all'"]
and property_column_gap = [%value.rec "'normal' | <length-percentage>"]
and property_column_rule = [%value.rec
  "<'column-rule-width'> || <'column-rule-style'> || <'column-rule-color'>"
]
and property_column_rule_color = [%value.rec "<color>"]
and property_column_rule_style = [%value.rec "<'border-style'>"]
and property_column_rule_width = [%value.rec "<'border-width'>"]
and property_column_span = [%value.rec "'none' | 'all'"]
and property_column_width = [%value.rec "<length> | 'auto'"]
and property_columns = [%value.rec "<'column-width'> || <'column-count'>"]
and property_contain = [%value.rec
  "'none' | 'strict' | 'content' | 'size' || 'layout' || 'style' || 'paint'"
]
and property_content = [%value.rec
  "'normal' | 'none' | [ <content-replacement> | <content-list> ] '/' <string>"
]
and property_counter_increment = [%value.rec
  "<custom-ident> [ <integer> ]? | 'none'"
]
and property_counter_reset = [%value.rec
  "<custom-ident> [ <integer> ]? | 'none'"
]
and property_counter_set = [%value.rec
  "<custom-ident> [ <integer> ]? | 'none'"
]
and property_cursor = [%value.rec
  "<url> <x> <y> ',' [ 'auto' | 'default' | 'none' | 'context-menu' | 'help' | 'pointer' | 'progress' | 'wait' | 'cell' | 'crosshair' | 'text' | 'vertical-text' | 'alias' | 'copy' | 'move' | 'no-drop' | 'not-allowed' | 'e-resize' | 'n-resize' | 'ne-resize' | 'nw-resize' | 's-resize' | 'se-resize' | 'sw-resize' | 'w-resize' | 'ew-resize' | 'ns-resize' | 'nesw-resize' | 'nwse-resize' | 'col-resize' | 'row-resize' | 'all-scroll' | 'zoom-in' | 'zoom-out' | 'grab' | 'grabbing' ]"
]
and property_direction = [%value.rec "'ltr' | 'rtl'"]
and property_display = [%value.rec
  "<display-outside> || <display-inside> | <display-listitem> | <display-internal> | <display-box> | <display-legacy>"
]
and property_empty_cells = [%value.rec "'show' | 'hide'"]
and property_filter = [%value.rec "'none' | <filter-function-list>"]
and property_flex = [%value.rec
  "'none' | <'flex-grow'> [ <'flex-shrink'> ]? || <'flex-basis'>"
]
and property_flex_basis = [%value.rec "'content' | <'width'>"]
and property_flex_direction = [%value.rec
  "'row' | 'row-reverse' | 'column' | 'column-reverse'"
]
and property_flex_flow = [%value.rec "<'flex-direction'> || <'flex-wrap'>"]
and property_flex_grow = [%value.rec "<number>"]
and property_flex_shrink = [%value.rec "<number>"]
and property_flex_wrap = [%value.rec "'nowrap' | 'wrap' | 'wrap-reverse'"]
and property_float = [%value.rec
  "'left' | 'right' | 'none' | 'inline-start' | 'inline-end'"
]
and property_font = [%value.rec
  "[ <'font-style'> || <font-variant-css21> || <'font-weight'> || <'font-stretch'> ] <'font-size'> '/' <'line-height'> <'font-family'> | 'caption' | 'icon' | 'menu' | 'message-box' | 'small-caption' | 'status-bar'"
]
and property_font_family = [%value.rec "<family-name> | <generic-family>"]
and property_font_feature_settings = [%value.rec
  "'normal' | [ <feature-tag-value> ]#"
]
and property_font_kerning = [%value.rec "'auto' | 'normal' | 'none'"]
and property_font_language_override = [%value.rec "'normal' | <string>"]
and property_font_optical_sizing = [%value.rec "'auto' | 'none'"]
and property_font_size = [%value.rec
  "<absolute-size> | <relative-size> | <length-percentage>"
]
and property_font_size_adjust = [%value.rec "'none' | <number>"]
and property_font_smooth = [%value.rec
  "'auto' | 'never' | 'always' | <absolute-size> | <length>"
]
and property_font_stretch = [%value.rec "<font-stretch-absolute>"]
and property_font_style = [%value.rec
  "'normal' | 'italic' | 'oblique' [ <angle> ]?"
]
and property_font_synthesis = [%value.rec "'none' | 'weight' || 'style'"]
and property_font_variant = [%value.rec
  "'normal' | 'none' | <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || <feature-value-name> || 'historical-forms' || [ <feature-value-name> ]# || [ <feature-value-name> ]# || <feature-value-name> || <feature-value-name> || <feature-value-name> || [ 'small-caps' | 'all-small-caps' | 'petite-caps' | 'all-petite-caps' | 'unicase' | 'titling-caps' ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || 'ordinal' || 'slashed-zero' || <east-asian-variant-values> || <east-asian-width-values> || 'ruby'"
]
and property_font_variant_alternates = [%value.rec
  "'normal' | <feature-value-name> || 'historical-forms' || [ <feature-value-name> ]# || [ <feature-value-name> ]# || <feature-value-name> || <feature-value-name> || <feature-value-name>"
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
  "'normal' | <string> <number>"
]
and property_font_weight = [%value.rec
  "<font-weight-absolute> | 'bolder' | 'lighter'"
]
and property_gap = [%value.rec "<'row-gap'> [ <'column-gap'> ]?"]
and property_grid = [%value.rec
  "<'grid-template'> | <'grid-template-rows'> '/' [ 'auto-flow' && [ 'dense' ]? ] [ <'grid-auto-columns'> ]? | [ 'auto-flow' && [ 'dense' ]? ] [ <'grid-auto-rows'> ]? '/' <'grid-template-columns'>"
]
and property_grid_area = [%value.rec "<grid-line> '/' <grid-line>"]
and property_grid_auto_columns = [%value.rec "[ <track-size> ]+"]
and property_grid_auto_flow = [%value.rec "[ 'row' | 'column' ] || 'dense'"]
and property_grid_auto_rows = [%value.rec "[ <track-size> ]+"]
and property_grid_column = [%value.rec "<grid-line> '/' <grid-line>"]
and property_grid_column_end = [%value.rec "<grid-line>"]
and property_grid_column_gap = [%value.rec "<length-percentage>"]
and property_grid_column_start = [%value.rec "<grid-line>"]
and property_grid_gap = [%value.rec
  "<'grid-row-gap'> [ <'grid-column-gap'> ]?"
]
and property_grid_row = [%value.rec "<grid-line> '/' <grid-line>"]
and property_grid_row_end = [%value.rec "<grid-line>"]
and property_grid_row_gap = [%value.rec "<length-percentage>"]
and property_grid_row_start = [%value.rec "<grid-line>"]
and property_grid_template = [%value.rec
  "'none' | <'grid-template-rows'> '/' <'grid-template-columns'> | [ <line-names> ]? <string> [ <track-size> ]? [ <line-names> ]? '/' <explicit-track-list>"
]
and property_grid_template_areas = [%value.rec "'none' | [ <string> ]+"]
and property_grid_template_columns = [%value.rec
  "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]?"
]
and property_grid_template_rows = [%value.rec
  "'none' | <track-list> | <auto-track-list> | 'subgrid' [ <line-name-list> ]?"
]
and property_hanging_punctuation = [%value.rec
  "'none' | 'first' || [ 'force-end' | 'allow-end' ] || 'last'"
]
and property_height = [%value.rec
  "'auto' | <length> | <percentage> | 'min-content' | 'max-content' | <length-percentage>"
]
and property_hyphens = [%value.rec "'none' | 'manual' | 'auto'"]
and property_image_orientation = [%value.rec
  "'from-image' | <angle> | [ <angle> ]? 'flip'"
]
and property_image_rendering = [%value.rec
  "'auto' | 'crisp-edges' | 'pixelated'"
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
and property_left = [%value.rec "<length> | <percentage> | 'auto'"]
and property_letter_spacing = [%value.rec "'normal' | <length>"]
and property_line_break = [%value.rec
  "'auto' | 'loose' | 'normal' | 'strict' | 'anywhere'"
]
and property_line_clamp = [%value.rec "'none' | <integer>"]
and property_line_height = [%value.rec
  "'normal' | <number> | <length> | <percentage>"
]
and property_line_height_step = [%value.rec "<length>"]
and property_list_style = [%value.rec
  "<'list-style-type'> || <'list-style-position'> || <'list-style-image'>"
]
and property_list_style_image = [%value.rec "<url> | 'none'"]
and property_list_style_position = [%value.rec "'inside' | 'outside'"]
and property_list_style_type = [%value.rec
  "<counter-style> | <string> | 'none'"
]
and property_margin = [%value.rec "<length> | <percentage> | 'auto'"]
and property_margin_block = [%value.rec "[ <'margin-left'> ]{1,2}"]
and property_margin_block_end = [%value.rec "<'margin-left'>"]
and property_margin_block_start = [%value.rec "<'margin-left'>"]
and property_margin_bottom = [%value.rec "<length> | <percentage> | 'auto'"]
and property_margin_inline = [%value.rec "[ <'margin-left'> ]{1,2}"]
and property_margin_inline_end = [%value.rec "<'margin-left'>"]
and property_margin_inline_start = [%value.rec "<'margin-left'>"]
and property_margin_left = [%value.rec "<length> | <percentage> | 'auto'"]
and property_margin_right = [%value.rec "<length> | <percentage> | 'auto'"]
and property_margin_top = [%value.rec "<length> | <percentage> | 'auto'"]
and property_margin_trim = [%value.rec "'none' | 'in-flow' | 'all'"]
and property_mask = [%value.rec "[ <mask-layer> ]#"]
and property_mask_border = [%value.rec
  "<'mask-border-source'> || <'mask-border-slice'> '/' [ <'mask-border-width'> ]? '/' <'mask-border-outset'> || <'mask-border-repeat'> || <'mask-border-mode'>"
]
and property_mask_border_mode = [%value.rec "'luminance' | 'alpha'"]
and property_mask_border_outset = [%value.rec "<length> | <number>"]
and property_mask_border_repeat = [%value.rec
  "'stretch' | 'repeat' | 'round' | 'space'"
]
and property_mask_border_slice = [%value.rec
  "[ <number-percentage> ]{1,4} [ 'fill' ]?"
]
and property_mask_border_source = [%value.rec "'none' | <image>"]
and property_mask_border_width = [%value.rec
  "<length-percentage> | <number> | 'auto'"
]
and property_mask_clip = [%value.rec "<geometry-box> | 'no-clip'"]
and property_mask_composite = [%value.rec "[ <compositing-operator> ]#"]
and property_mask_image = [%value.rec "[ <mask-reference> ]#"]
and property_mask_mode = [%value.rec "[ <masking-mode> ]#"]
and property_mask_origin = [%value.rec "[ <geometry-box> ]#"]
and property_mask_position = [%value.rec "[ <position> ]#"]
and property_mask_repeat = [%value.rec "[ <repeat-style> ]#"]
and property_mask_size = [%value.rec "[ <bg-size> ]#"]
and property_mask_type = [%value.rec "'luminance' | 'alpha'"]
and property_max_block_size = [%value.rec "<'max-width'>"]
and property_max_height = [%value.rec
  "'auto' | <length> | <percentage> | 'min-content' | 'max-content' | <length-percentage>"
]
and property_max_inline_size = [%value.rec "<'max-width'>"]
and property_max_lines = [%value.rec "'none' | <integer>"]
and property_max_width = [%value.rec
  "'auto' | <length> | <percentage> | 'min-content' | 'max-content' | <length-percentage>"
]
and property_min_block_size = [%value.rec "<'min-width'>"]
and property_min_height = [%value.rec
  "'auto' | <length> | <percentage> | 'min-content' | 'max-content' | <length-percentage>"
]
and property_min_inline_size = [%value.rec "<'min-width'>"]
and property_min_width = [%value.rec
  "'auto' | <length> | <percentage> | 'min-content' | 'max-content' | <length-percentage>"
]
and property_mix_blend_mode = [%value.rec "<blend-mode>"]
and property_object_fit = [%value.rec
  "'fill' | 'contain' | 'cover' | 'none' | 'scale-down'"
]
and property_object_position = [%value.rec "<position>"]
and property_offset = [%value.rec
  "[ <'offset-position'> ]? <'offset-path'> [ <'offset-distance'> || <'offset-rotate'> ] '/' <'offset-anchor'>"
]
and property_offset_anchor = [%value.rec "'auto' | <position>"]
and property_offset_distance = [%value.rec "<length-percentage>"]
and property_offset_path = [%value.rec
  "'none' | <angle> && [ <size> ]? && [ 'contain' ]? | <path()> | <url> | <basic-shape> || <geometry-box>"
]
and property_offset_position = [%value.rec "'auto' | <position>"]
and property_offset_rotate = [%value.rec "[ 'auto' | 'reverse' ] || <angle>"]
and property_opacity = [%value.rec "<alpha-value>"]
and property_order = [%value.rec "<integer>"]
and property_orphans = [%value.rec "<integer>"]
and property_outline = [%value.rec
  "<'outline-color'> || <'outline-style'> || <'outline-width'>"
]
and property_outline_color = [%value.rec "<color> | 'invert'"]
and property_outline_offset = [%value.rec "<length>"]
and property_outline_style = [%value.rec "'auto' | <'border-style'>"]
and property_outline_width = [%value.rec "<line-width>"]
and property_overflow = [%value.rec
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto'"
]
and property_overflow_anchor = [%value.rec "'auto' | 'none'"]
and property_overflow_block = [%value.rec
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto'"
]
and property_overflow_clip_box = [%value.rec "'padding-box' | 'content-box'"]
and property_overflow_inline = [%value.rec
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto'"
]
and property_overflow_wrap = [%value.rec
  "'normal' | 'break-word' | 'anywhere'"
]
and property_overflow_x = [%value.rec
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto'"
]
and property_overflow_y = [%value.rec
  "'visible' | 'hidden' | 'clip' | 'scroll' | 'auto'"
]
and property_overscroll_behavior = [%value.rec "'contain' | 'none' | 'auto'"]
and property_overscroll_behavior_block = [%value.rec
  "'contain' | 'none' | 'auto'"
]
and property_overscroll_behavior_inline = [%value.rec
  "'contain' | 'none' | 'auto'"
]
and property_overscroll_behavior_x = [%value.rec "'contain' | 'none' | 'auto'"]
and property_overscroll_behavior_y = [%value.rec "'contain' | 'none' | 'auto'"]
and property_padding = [%value.rec "<length> | <percentage>"]
and property_padding_block = [%value.rec "[ <'padding-left'> ]{1,2}"]
and property_padding_block_end = [%value.rec "<'padding-left'>"]
and property_padding_block_start = [%value.rec "<'padding-left'>"]
and property_padding_bottom = [%value.rec "<length> | <percentage>"]
and property_padding_inline = [%value.rec "[ <'padding-left'> ]{1,2}"]
and property_padding_inline_end = [%value.rec "<'padding-left'>"]
and property_padding_inline_start = [%value.rec "<'padding-left'>"]
and property_padding_left = [%value.rec "<length> | <percentage>"]
and property_padding_right = [%value.rec "<length> | <percentage>"]
and property_padding_top = [%value.rec "<length> | <percentage>"]
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
and property_perspective = [%value.rec "'none' | <length>"]
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
  "'static' | 'relative' | 'absolute' | 'sticky' | 'fixed'"
]
and property_quotes = [%value.rec "'none' | 'auto' | <string> <string>"]
and property_resize = [%value.rec
  "'none' | 'both' | 'horizontal' | 'vertical' | 'block' | 'inline'"
]
and property_right = [%value.rec "<length> | <percentage> | 'auto'"]
and property_rotate = [%value.rec
  "'none' | <angle> | [ 'x' | 'y' | 'z' | [ <number> ]{3} ] && <angle>"
]
and property_row_gap = [%value.rec "'normal' | <length-percentage>"]
and property_ruby_align = [%value.rec
  "'start' | 'center' | 'space-between' | 'space-around'"
]
and property_ruby_merge = [%value.rec "'separate' | 'collapse' | 'auto'"]
and property_ruby_position = [%value.rec
  "'over' | 'under' | 'inter-character'"
]
and property_scale = [%value.rec "'none' | [ <number> ]{1,3}"]
and property_scroll_behavior = [%value.rec "'auto' | 'smooth'"]
and property_scroll_margin = [%value.rec "[ <length> ]{1,4}"]
and property_scroll_margin_block = [%value.rec "[ <length> ]{1,2}"]
and property_scroll_margin_block_end = [%value.rec "<length>"]
and property_scroll_margin_block_start = [%value.rec "<length>"]
and property_scroll_margin_bottom = [%value.rec "<length>"]
and property_scroll_margin_inline = [%value.rec "[ <length> ]{1,2}"]
and property_scroll_margin_inline_end = [%value.rec "<length>"]
and property_scroll_margin_inline_start = [%value.rec "<length>"]
and property_scroll_margin_left = [%value.rec "<length>"]
and property_scroll_margin_right = [%value.rec "<length>"]
and property_scroll_margin_top = [%value.rec "<length>"]
and property_scroll_padding = [%value.rec "'auto' | <length-percentage>"]
and property_scroll_padding_block = [%value.rec "'auto' | <length-percentage>"]
and property_scroll_padding_block_end = [%value.rec
  "'auto' | <length-percentage>"
]
and property_scroll_padding_block_start = [%value.rec
  "'auto' | <length-percentage>"
]
and property_scroll_padding_bottom = [%value.rec
  "'auto' | <length-percentage>"
]
and property_scroll_padding_inline = [%value.rec
  "'auto' | <length-percentage>"
]
and property_scroll_padding_inline_end = [%value.rec
  "'auto' | <length-percentage>"
]
and property_scroll_padding_inline_start = [%value.rec
  "'auto' | <length-percentage>"
]
and property_scroll_padding_left = [%value.rec "'auto' | <length-percentage>"]
and property_scroll_padding_right = [%value.rec "'auto' | <length-percentage>"]
and property_scroll_padding_top = [%value.rec "'auto' | <length-percentage>"]
and property_scroll_snap_align = [%value.rec
  "'none' | 'start' | 'end' | 'center'"
]
and property_scroll_snap_coordinate = [%value.rec "'none' | [ <position> ]#"]
and property_scroll_snap_destination = [%value.rec "<position>"]
and property_scroll_snap_points_x = [%value.rec "'none' | <length-percentage>"]
and property_scroll_snap_points_y = [%value.rec "'none' | <length-percentage>"]
and property_scroll_snap_stop = [%value.rec "'normal' | 'always'"]
and property_scroll_snap_type = [%value.rec
  "'none' | [ 'x' | 'y' | 'block' | 'inline' | 'both' ] [ 'mandatory' | 'proximity' ]"
]
and property_scroll_snap_type_x = [%value.rec
  "'none' | 'mandatory' | 'proximity'"
]
and property_scroll_snap_type_y = [%value.rec
  "'none' | 'mandatory' | 'proximity'"
]
and property_scrollbar_color = [%value.rec
  "'auto' | 'dark' | 'light' | [ <color> ]{2}"
]
and property_scrollbar_width = [%value.rec "'auto' | 'thin' | 'none'"]
and property_shape_image_threshold = [%value.rec "<alpha-value>"]
and property_shape_margin = [%value.rec "<length-percentage>"]
and property_shape_outside = [%value.rec
  "'none' | <shape-box> || <basic-shape> | <image>"
]
and property_tab_size = [%value.rec "<integer> | <length>"]
and property_table_layout = [%value.rec "'auto' | 'fixed'"]
and property_text_align = [%value.rec
  "'start' | 'end' | 'left' | 'right' | 'center' | 'justify' | 'match-parent'"
]
and property_text_align_last = [%value.rec
  "'auto' | 'start' | 'end' | 'left' | 'right' | 'center' | 'justify'"
]
and property_text_combine_upright = [%value.rec
  "'none' | 'all' | 'digits' [ <integer> ]?"
]
and property_text_decoration = [%value.rec
  "<'text-decoration-line'> || <'text-decoration-style'> || <'text-decoration-color'> || <'text-decoration-thickness'>"
]
and property_text_decoration_color = [%value.rec "<color>"]
and property_text_decoration_line = [%value.rec
  "'none' | 'underline' || 'overline' || 'line-through' || 'blink' | 'spelling-error' | 'grammar-error'"
]
and property_text_decoration_skip = [%value.rec
  "'none' | 'objects' || [ 'spaces' | 'leading-spaces' || 'trailing-spaces' ] || 'edges' || 'box-decoration'"
]
and property_text_decoration_skip_ink = [%value.rec "'auto' | 'all' | 'none'"]
and property_text_decoration_style = [%value.rec
  "'solid' | 'double' | 'dotted' | 'dashed' | 'wavy'"
]
and property_text_decoration_thickness = [%value.rec
  "'auto' | 'from-font' | <length> | <percentage>"
]
and property_text_emphasis = [%value.rec
  "<'text-emphasis-style'> || <'text-emphasis-color'>"
]
and property_text_emphasis_color = [%value.rec "<color>"]
and property_text_emphasis_position = [%value.rec
  "[ 'over' | 'under' ] && [ 'right' | 'left' ]"
]
and property_text_emphasis_style = [%value.rec
  "'none' | [ 'filled' | 'open' ] || [ 'dot' | 'circle' | 'double-circle' | 'triangle' | 'sesame' ] | <string>"
]
and property_text_indent = [%value.rec
  "<length-percentage> && [ 'hanging' ]? && [ 'each-line' ]?"
]
and property_text_justify = [%value.rec
  "'auto' | 'inter-character' | 'inter-word' | 'none'"
]
and property_text_orientation = [%value.rec "'mixed' | 'upright' | 'sideways'"]
and property_text_overflow = [%value.rec "'clip' | 'ellipsis' | <string>"]
and property_text_rendering = [%value.rec
  "'auto' | 'optimizeSpeed' | 'optimizeLegibility' | 'geometricPrecision'"
]
and property_text_shadow = [%value.rec "'none' | [ <shadow-t> ]#"]
and property_text_size_adjust = [%value.rec "'none' | 'auto' | <percentage>"]
and property_text_transform = [%value.rec
  "'none' | 'capitalize' | 'uppercase' | 'lowercase' | 'full-width' | 'full-size-kana'"
]
and property_text_underline_offset = [%value.rec
  "'auto' | <length> | <percentage>"
]
and property_text_underline_position = [%value.rec
  "'auto' | 'from-font' | 'under' || [ 'left' | 'right' ]"
]
and property_top = [%value.rec "<length> | <percentage> | 'auto'"]
and property_touch_action = [%value.rec
  "'auto' | 'none' | [ 'pan-x' | 'pan-left' | 'pan-right' ] || [ 'pan-y' | 'pan-up' | 'pan-down' ] || 'pinch-zoom' | 'manipulation'"
]
and property_transform = [%value.rec "'none' | <transform-list>"]
and property_transform_box = [%value.rec
  "'content-box' | 'border-box' | 'fill-box' | 'stroke-box' | 'view-box'"
]
and property_transform_origin = [%value.rec
  "<length-percentage> | 'left' | 'center' | 'right' | 'top' | 'bottom' | [ [ <length-percentage> | 'left' | 'center' | 'right' ] && [ <length-percentage> | 'top' | 'center' | 'bottom' ] ] [ <length> ]?"
]
and property_transform_style = [%value.rec "'flat' | 'preserve-3d'"]
and property_transition = [%value.rec "[ <single-transition> ]#"]
and property_transition_delay = [%value.rec "[ <time> ]#"]
and property_transition_duration = [%value.rec "[ <time> ]#"]
and property_transition_property = [%value.rec
  "'none' | [ <single-transition-property> ]#"
]
and property_transition_timing_function = [%value.rec "[ <timing-function> ]#"]
and property_translate = [%value.rec
  "'none' | <length-percentage> <length-percentage> [ <length> ]?"
]
and property_unicode_bidi = [%value.rec
  "'normal' | 'embed' | 'isolate' | 'bidi-override' | 'isolate-override' | 'plaintext'"
]
and property_user_select = [%value.rec
  "'auto' | 'text' | 'none' | 'contain' | 'all'"
]
and property_vertical_align = [%value.rec
  "'baseline' | 'sub' | 'super' | 'text-top' | 'text-bottom' | 'middle' | 'top' | 'bottom' | <percentage> | <length>"
]
and property_visibility = [%value.rec "'visible' | 'hidden' | 'collapse'"]
and property_white_space = [%value.rec
  "'normal' | 'pre' | 'nowrap' | 'pre-wrap' | 'pre-line' | 'break-spaces'"
]
and property_widows = [%value.rec "<integer>"]
and property_width = [%value.rec
  "'auto' | <length> | <percentage> | 'min-content' | 'max-content' | <length-percentage>"
]
and property_will_change = [%value.rec "'auto' | [ <animateable-feature> ]#"]
and property_word_break = [%value.rec
  "'normal' | 'break-all' | 'keep-all' | 'break-word'"
]
and property_word_spacing = [%value.rec "'normal' | <length-percentage>"]
and property_word_wrap = [%value.rec "'normal' | 'break-word'"]
and property_writing_mode = [%value.rec
  "'horizontal-tb' | 'vertical-rl' | 'vertical-lr' | 'sideways-rl' | 'sideways-lr'"
]
and property_z_index = [%value.rec "'auto' | <integer>"]
and property_zoom = [%value.rec "'normal' | 'reset' | <number> | <percentage>"]
and pseudo_class_selector = [%value.rec
  "':' <ident-token> | ':' <function-token> <any-value> ')'"
]
and pseudo_element_selector = [%value.rec "':' <pseudo-class-selector>"]
and pseudo_page = [%value.rec "':' [ 'left' | 'right' | 'first' | 'blank' ]"]
and quote = [%value.rec
  "'open-quote' | 'close-quote' | 'no-open-quote' | 'no-close-quote'"
]
and relative_selector = [%value.rec "[ <combinator> ]? <complex-selector>"]
and relative_selector_list = [%value.rec "[ <relative-selector> ]#"]
and relative_size = [%value.rec "'larger' | 'smaller'"]
and repeat_style = [%value.rec
  "'repeat-x' | 'repeat-y' | 'repeat' | 'space' | 'round' | 'no-repeat'"
]
and self_position = [%value.rec
  "'center' | 'start' | 'end' | 'self-start' | 'self-end' | 'flex-start' | 'flex-end'"
]
and shadow = [%value.rec "[ 'inset' ]? && [ <length> ]{2,4} && [ <color> ]?"]
and shadow_t = [%value.rec "[ <length> ]{2,3} && [ <color> ]?"]
and shape = [%value.rec
  "<property_top> ',' <property_right> ',' <property_bottom> ',' <property_left>"
]
and shape_box = [%value.rec "<box> | 'margin-box'"]
and shape_radius = [%value.rec
  "<length-percentage> | 'closest-side' | 'farthest-side'"
]
and side_or_corner = [%value.rec
  "[ 'left' | 'right' ] || [ 'top' | 'bottom' ]"
]
and single_animation = [%value.rec
  "<time> || <timing-function> || <time> || <single-animation-iteration-count> || <single-animation-direction> || <single-animation-fill-mode> || <single-animation-play-state> || [ 'none' | <keyframes-name> ]"
]
and single_animation_direction = [%value.rec
  "'normal' | 'reverse' | 'alternate' | 'alternate-reverse'"
]
and single_animation_fill_mode = [%value.rec
  "'none' | 'forwards' | 'backwards' | 'both'"
]
and single_animation_iteration_count = [%value.rec "'infinite' | <number>"]
and single_animation_play_state = [%value.rec "'running' | 'paused'"]
and single_transition = [%value.rec
  "[ 'none' | <single-transition-property> ] || <time> || <timing-function> || <time>"
]
and single_transition_property = [%value.rec "'all' | <custom-ident>"]
and size = [%value.rec
  "'closest-side' | 'farthest-side' | 'closest-corner' | 'farthest-corner' | <length> | [ <length-percentage> ]{2}"
]
and step_position = [%value.rec
  "'jump-start' | 'jump-end' | 'jump-none' | 'jump-both' | 'start' | 'end'"
]
and step_timing_function = [%value.rec
  "'step-start' | 'step-end' | <integer> ',' <step-position>"
]
and subclass_selector = [%value.rec
  "<id-selector> | <class-selector> | <attribute-selector> | <pseudo-class-selector>"
]
and supports_condition = [%value.rec
  "'not' <supports-in-parens> | <supports-in-parens> 'and' <supports-in-parens> | <supports-in-parens> 'or' <supports-in-parens>"
]
and supports_decl = [%value.rec "'(' <declaration> ')'"]
and supports_feature = [%value.rec "<supports-decl> | <supports-selector-fn>"]
and supports_in_parens = [%value.rec
  "'(' <supports-condition> ')' | <supports-feature> | <general-enclosed>"
]
and supports_selector_fn = [%value.rec "<complex-selector>"]
and symbol = [%value.rec "<string> | <image> | <custom-ident>"]
and target = [%value.rec
  "<target-counter()> | <target-counters()> | <target-text()>"
]
and time_percentage = [%value.rec "<time> | <percentage>"]
and timing_function = [%value.rec
  "'linear' | <cubic-bezier-timing-function> | <step-timing-function>"
]
and track_breadth = [%value.rec
  "<length-percentage> | <property_flex> | 'min-content' | 'max-content' | 'auto'"
]
and track_list = [%value.rec
  "[ <line-names> ]? [ <track-size> | <track-repeat> ] [ <line-names> ]?"
]
and track_repeat = [%value.rec
  "<positive-integer> ',' [ <line-names> ]? <track-size> [ <line-names> ]?"
]
and track_size = [%value.rec
  "<track-breadth> | <inflexible-breadth> ',' <track-breadth> | <length> | <percentage>"
]
and transform_function = [%value.rec
  "<matrix()> | <translate()> | <translateX()> | <translateY()> | <scale()> | <scaleX()> | <scaleY()> | <rotate()> | <skew()> | <skewX()> | <skewY()> | <matrix3d()> | <translate3d()> | <translateZ()> | <scale3d()> | <scaleZ()> | <rotate3d()> | <rotateX()> | <rotateY()> | <rotateZ()> | <perspective()>"
]
and transform_list = [%value.rec "[ <transform-function> ]+"]
and type_or_unit = [%value.rec
  "'string' | 'color' | 'url' | 'integer' | 'number' | 'length' | 'angle' | 'time' | 'frequency' | 'cap' | 'ch' | 'em' | 'ex' | 'ic' | 'lh' | 'rlh' | 'rem' | 'vb' | 'vi' | 'vw' | 'vh' | 'vmin' | 'vmax' | 'mm' | 'Q' | 'cm' | 'in' | 'pt' | 'pc' | 'px' | 'deg' | 'grad' | 'rad' | 'turn' | 'ms' | 's' | 'Hz' | 'kHz' | '%'"
]
and type_selector = [%value.rec "<wq-name> | [ <ns-prefix> ]? '*'"]
and viewport_length = [%value.rec "'auto' | <length-percentage>"]
and wq_name = [%value.rec "[ <ns-prefix> ]? <ident-token>"];
