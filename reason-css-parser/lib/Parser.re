open Standard;
open Combinator;
open Modifier;
open Rule.Match;
open Reason_css_lexer;
// TODO: split by modules

let wq_name = [%value "not implemented"];
let declaration_value = [%value "not implemented"];

// css-values-4
let time_percentage = [%value "[ <time> | <percentage> ]"];
let angle_percentage = [%value "[ <angle> | <percentage> ]"];
let frequency_percentage = [%value "[ <frequency> | <percentage> ]"];
let length_percentage = [%value "[ <length> | <percentage> ]"];
// TODO: note on <number-percentage> https://drafts.csswg.org/css-values-4/#mixed-percentages
let number_percentage = [%value "[ <number> | <percentage> ]"];
let attr_type = [%value
  "string | url | ident | color | number | percentage | length | angle | time | frequency | flex | <dimension-unit>"
];
let function_attr = [%value
  "attr( <wq-name> <attr-type>? , <declaration-value>?)"
];
let position = [%value
  "[ [ left | center | right ] || [ top | center | bottom ] | [ left | center | right | <length-percentage> ] [ top | center | bottom | <length-percentage> ]? | [ [ left | right ] <length-percentage> ] && [ [ top | bottom ] <length-percentage> ] ]"
];
// TODO: let ratio = [%value "<number [0,∞]> [ / <number [0,∞]> ]?"];
let ratio = [%value "<number> [ / <number> ]?"];

// css-easing-1
let step_position = [%value
  "jump-start | jump-end | jump-none | jump-both | start | end"
];
let step_easing_function = [%value
  "step-start | step-end | steps(<integer>[, <step-position>]?)"
];
// let cubic_bezier_easing_function = [%value "ease | ease-in | ease-out | ease-in-out | cubic-bezier(<number [0,1]>, <number>, <number [0,1]>, <number>)"];
let cubic_bezier_easing_function = [%value
  "ease | ease-in | ease-out | ease-in-out | cubic-bezier(<number>, <number>, <number>, <number>)"
];
let easing_function = [%value
  "linear | <cubic-bezier-easing-function> | <step-easing-function>"
];
let function_steps = [%value "steps(<integer>[, <step-position> ]?)"];
// let function_cubic_bezier = [%value "cubic-bezier(<number [0,1]>, <number>, <number [0,1]>, <number>)"];
let function_cubic_bezier = [%value
  "cubic-bezier(<number>, <number>, <number>, <number>)"
];

// css-sizing-3
let function_fit_content = [%value "fit-content( <length-percentage> )"];
let property_width = [%value
  "auto | <length-percentage> | min-content | max-content | fit-content(<length-percentage>)"
];
let property_height = [%value
  "auto | <length-percentage> | min-content | max-content | fit-content(<length-percentage>)"
];
let property_min_width = [%value
  "auto | <length-percentage> | min-content | max-content | fit-content(<length-percentage>)"
];
let property_min_height = [%value
  "auto | <length-percentage> | min-content | max-content | fit-content(<length-percentage>)"
];
let property_max_width = [%value
  "none | <length-percentage> | min-content | max-content | fit-content(<length-percentage>)"
];
let property_max_height = [%value
  "none | <length-percentage> | min-content | max-content | fit-content(<length-percentage>)"
];
let property_box_sizing = [%value "content-box | border-box"];
let property_column_width = [%value
  "min-content | max-content | fit-content(<length-percentage>)"
];

// css-box-3
let visual_box = [%value "content-box | padding-box | border-box"];
let layout_box = [%value
  "content-box | padding-box | border-box | margin-box"
];
let paint_box = [%value
  "content-box | padding-box | border-box | fill-box | stroke-box"
];
let coord_box = [%value
  "content-box | padding-box | border-box | fill-box | stroke-box | view-box"
];
let property_margin_top = [%value "<length-percentage> | auto"];
let property_margin_right = [%value "<length-percentage> | auto"];
let property_margin_bottom = [%value "<length-percentage> | auto"];
let property_margin_left = [%value "<length-percentage> | auto"];
let property_margin = [%value "<'margin-top'>{1,4}"];
let property_padding_top = [%value "<length-percentage>"];
let property_padding_right = [%value "<length-percentage>"];
let property_padding_bottom = [%value "<length-percentage>"];
let property_padding_left = [%value "<length-percentage>"];
let property_padding = [%value "<'padding-top'>{1,4}"];

// css-color-4
let named_color = [%value
  "aliceblue | antiquewhite | aqua | aquamarine | azure | beige | bisque | black | blanchedalmond | blue | blueviolet | brown | burlywood | cadetblue | chartreuse | chocolate | coral | cornflowerblue | cornsilk | crimson | cyan | darkblue | darkcyan | darkgoldenrod | darkgray | darkgreen | darkgrey | darkkhaki | darkmagenta | darkolivegreen | darkorange | darkorchid | darkred | darksalmon | darkseagreen | darkslateblue | darkslategray | darkslategrey | darkturquoise | darkviolet | deeppink | deepskyblue | dimgray | dimgrey | dodgerblue | firebrick | floralwhite | forestgreen | fuchsia | gainsboro | ghostwhite | gold | goldenrod | gray | green | greenyellow | grey | honeydew | hotpink | indianred | indigo | ivory | khaki | lavender | lavenderblush | lawngreen | lemonchiffon | lightblue | lightcoral | lightcyan | lightgoldenrodyellow | lightgray | lightgreen | lightgrey | lightpink | lightsalmon | lightseagreen | lightskyblue | lightslategray | lightslategrey | lightsteelblue | lightyellow | lime | limegreen | linen | magenta | maroon | mediumaquamarine | mediumblue | mediumorchid | mediumpurple | mediumseagreen | mediumslateblue | mediumspringgreen | mediumturquoise | mediumvioletred | midnightblue | mintcream | mistyrose | moccasin | navajowhite | navy | oldlace | olive | olivedrab | orange | orangered | orchid | palegoldenrod | palegreen | paleturquoise | palevioletred | papayawhip | peachpuff | peru | pink | plum | powderblue | purple | rebeccapurple | red | rosybrown | royalblue | saddlebrown | salmon | sandybrown | seagreen | seashell | sienna | silver | skyblue | slateblue | slategray | slategrey | snow | springgreen | steelblue | tan | teal | thistle | tomato | turquoise | violet | wheat | white | whitesmoke | yellow | yellowgreen"
];
let alpha_value = [%value "<number> | <percentage>"];
// https://drafts.csswg.org/css-color-4/#funcdef-rgb
let function_rgb = {
  let percentage = [%value
    "<percentage>{3} [ / <alpha-value> ]? | <percentage>#{3} [ , <alpha-value> ]?"
  ];
  let number = [%value
    "<number>{3} [ / <alpha-value> ]? | <number>#{3} [ , <alpha-value> ]?"
  ];
  let number_percentage = [%value "<number> | <percentage>"];
  Fun.id([%value "rgb( <number-percentage> ) | rgba( <number-percentage> )"]);
};
let hue = [%value "<number> | <angle>"];
// TODO: should accept hsl
let function_hsl = [%value
  "hsl( <hue> <percentage> <percentage> [ / <alpha-value> ]? )"
];
let function_hwb = [%value
  "hwb( <hue> <percentage> <percentage> [ / <alpha-value> ]? )"
];
let function_lab = [%value
  "lab( <percentage> <number> <number> [ / <alpha-value> ]? )"
];
let function_lch = [%value
  "lch( <percentage> <number> <hue> [ / <alpha-value> ]? )"
];
let cmyk_component = [%value "<number> | <percentage>"];
// TODO: <system-color>?
let rec color = [%value.rec
  "<hex-color> | <named-color> | currentcolor | transparent | <rgb()> | <hsl()> | <hwb()> | <lab()> | <lch()> | <color()> | <device-cmyk()>"
]
and function_color = [%value.rec
  "color( [ [<ident> | <dashed-ident>]? [ <number-percentage>+ | <string> ] [ / <alpha-value> ]? ]# , <color>? )"
]
and function_device_cmyk = [%value.rec
  "device-cmyk( <cmyk-component>{4} [ / <alpha-value> ]? , <color>? )"
];
let property_color = [%value "<color>"];
let property_opacity = [%value "<alpha-value>"];

// css-images-4
let image_tags = [%value "[ ltr | rtl ]"];
let image_src = [%value "[ <url> | <string> ]"];
// TODO: let function_image = [%value "image( <image-tags>? [ <image-src>? , <color>? ]! )"];
let function_image = {
  let image_src_color =
    at_least_one_2([%value "<image-src>? [ , <color> ]?"]);
  Fun.id([%value "image( <image-tags>? <image-src-color> )"]);
};
// let function_image = [%value "xxx"];
let side_or_corner = [%value "[left | right] || [top | bottom]"];
let linear_color_hint = [%value "<length-percentage>"];
let color_stop_length = [%value "<length-percentage>{1,2}"];
let linear_color_stop = [%value "<color> && <color-stop-length>?"];
let color_stop_list = [%value
  "<linear-color-stop> , [ <linear-color-hint>? , <linear-color-stop> ]#"
];
let color_stop_angle = [%value "<angle-percentage>{1,2}"];
let color_stop = [%value "<color-stop-length> | <color-stop-angle>"];
let function_linear_gradient = [%value
  "linear-gradient( [ <angle> | to <side-or-corner> ]? , <color-stop-list> )"
];
let function_repeating_linear_gradient = function_linear_gradient;
let extent_keyword = [%value
  "closest-corner | closest-side | farthest-corner | farthest-side"
];
let function_radial_gradient = [%value
  "radial-gradient( [ [ circle || <length> ] [ at <position> ]? , | [ ellipse || <length-percentage>{2} ] [ at <position> ]? , | [ [ circle | ellipse ] || <extent-keyword> ] [ at <position> ]? , | at <position> , ]? <color-stop> [ , <color-stop> ]+ )"
];
let function_repeating_radial_gradient = function_radial_gradient;
let angular_color_stop = [%value "<color> && <color-stop-angle>?"];
let angular_color_hint = [%value "<angle-percentage>"];
let angular_color_stop_list = [%value
  "<angular-color-stop> , [ <angular-color-hint>? , <angular-color-stop> ]#"
];
let function_conic_gradient = [%value
  "conic-gradient( [ from <angle> ]? [ at <position> ]?, <angular-color-stop-list> )"
];
let function_repeating_conic_gradient = function_conic_gradient;
let gradient = [%value
  "[ <linear-gradient()> | <repeating-linear-gradient()> | <radial-gradient()> | <repeating-radial-gradient()> | <conic-gradient()> | <repeating-conic-gradient()> ]"
];
let rec image = [%value.rec
  "<url> | <image()> | <image-set()> | <cross-fade()> | <gradient>"
]
and function_image_set = [%value.rec "image-set( <image-set-option># )"]
and image_set_option = [%value.rec "[ <image> | <string> ] <resolution>"]
and function_cross_fade = [%value.rec "cross-fade( <cf-image># )"]
and cf_image = [%value.rec "<percentage>? && [ <image> | <color> ]"];
// let function_element = [%value "element( <id-selector> )"];
let property_object_fit = [%value
  "fill | none | [contain | cover] || scale-down"
];
let property_object_position = [%value "<position>"];
let property_image_resolution = [%value
  "[ from-image || <resolution> ] && snap?"
];
let property_image_orientation = [%value
  "from-image | none | <angle> | [ <angle>? flip ]"
];
let property_image_rendering = [%value
  "auto | smooth | high-quality | crisp-edges | pixelated"
];

// TODO: optional keyword should be a boolean, not option(unit)

// css-backgrounds-3
// let shadow = [%value "<color>? && [<length>{2} <length [0,∞]>? <length>?] && inset?"];
let shadow = [%value
  "<color>? && [<length>{2} <length>? <length>?] && inset?"
];
// let line_width = [%value "<length [0,∞]> | thin | medium | thick"];
let line_width = [%value "<length> | thin | medium | thick"];
let line_style = [%value
  "none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset"
];

// let bg_size = [%value "[ <length-percentage [0,∞]> | auto ]{1,2} | cover | contain"];
let bg_size = [%value "[ <length-percentage> | auto ]{1,2} | cover | contain"];
let box = [%value "border-box | padding-box | content-box"];
let bg_position = [%value
  "[ left | center | right | top | bottom | <length-percentage> ] | [ left | center | right | <length-percentage> ] [ top | center | bottom | <length-percentage> ] | [ center | [ left | right ] <length-percentage>? ] && [ center | [ top | bottom ] <length-percentage>? ]"
];
let attachment = [%value "scroll | fixed | local"];
let repeat_style = [%value
  "repeat-x | repeat-y | [repeat | space | round | no-repeat]{1,2}"
];
let bg_image = [%value "<image> | none"];
let bg_layer = [%value
  "<bg-image> || <bg-position> [ / <bg-size> ]? || <repeat-style> || <attachment> || <box> || <box>"
];
let rec final_bg_layer = [%value.rec
  "<\'background-color'> || <bg-image> || <bg-position> [ / <bg-size> ]? || <repeat-style> || <attachment> || <box> || <box>"
]
and property_background_color = [%value "<color>"];
let property_background_image = [%value "<bg-image>#"];
let property_background_repeat = [%value "<repeat-style>#"];
let property_background_attachment = [%value "<attachment>#"];
let property_background_position = [%value "<bg-position>#"];
let property_background_clip = [%value "<box>#"];
let property_background_origin = [%value "<box>#"];
let property_background_size = [%value "<bg-size>#"];
let property_background = [%value "[<bg-layer># ,]? <final-bg-layer>"];
let property_border_top_color = [%value "<color>"];
let property_border_right_color = [%value "<color>"];
let property_border_bottom_color = [%value "<color>"];
let property_border_left_color = [%value "<color>"];
let property_border_color = [%value "<color>{1,4}"];
let property_border_top_style = [%value "<line-style>"];
let property_border_right_style = [%value "<line-style>"];
let property_border_bottom_style = [%value "<line-style>"];
let property_border_left_style = [%value "<line-style>"];
let property_border_style = [%value "<line-style>{1,4}"];
let property_border_top_width = [%value "<line-width>"];
let property_border_right_width = [%value "<line-width>"];
let property_border_bottom_width = [%value "<line-width>"];
let property_border_left_width = [%value "<line-width>"];
let property_border_width = [%value "<line-width>{1,4}"];
let property_border_top = [%value "<line-width> || <line-style> || <color>"];
let property_border_right = [%value "<line-width> || <line-style> || <color>"];
let property_border_bottom = [%value
  "<line-width> || <line-style> || <color>"
];
let property_border_left = [%value "<line-width> || <line-style> || <color>"];
let property_border = [%value "<line-width> || <line-style> || <color>"];
// let property_border_top_left_radius = [%value "<length-percentage [0,∞]>{1,2}"];
let property_border_top_left_radius = [%value "<length-percentage>{1,2}"];
// let property_border_top_right_radius = [%value "<length-percentage [0,∞]>{1,2}"];
let property_border_top_right_radius = [%value "<length-percentage>{1,2}"];
// let property_border_bottom_right_radius = [%value "<length-percentage [0,∞]>{1,2}"];
let property_border_bottom_right_radius = [%value "<length-percentage>{1,2}"];
// let property_border_bottom_left_radius = [%value "<length-percentage [0,∞]>{1,2}"];
let property_border_bottom_left_radius = [%value "<length-percentage>{1,2}"];
// let property_border_radius = [%value "<length-percentage [0,∞]>{1,4} [ / <length-percentage [0,∞]>{1,4} ]?"];
let property_border_radius = [%value
  "<length-percentage>{1,4} [ / <length-percentage>{1,4} ]?"
];
let property_border_image_source = [%value "none | <image>"];
// let property_border_image_slice = [%value "[<number [0,∞]> | <percentage [0,∞]>]{1,4} && fill?"];
let property_border_image_slice = [%value
  "[<number> | <percentage>]{1,4} && fill?"
];
// let property_border_image_width = [%value "[ <length-percentage [0,∞]> | <number [0,∞]> | auto ]{1,4}"];
let property_border_image_width = [%value
  "[ <length-percentage> | <number> | auto ]{1,4}"
];
// let property_border_image_outset = [%value "[ <length [0,∞]> | <number [0,∞]> ]{1,4}"];
let property_border_image_outset = [%value "[ <length> | <number> ]{1,4}"];
let property_border_image_repeat = [%value
  "[ stretch | repeat | round | space ]{1,2}"
];
let property_border_image = [%value
  "<'border-image-source'> || <'border-image-slice'> [ / <'border-image-width'> | / <'border-image-width'>? / <'border-image-outset'> ]? || <'border-image-repeat'>"
];
let property_box_shadow = [%value "none | <shadow>#"];

// css-overflow-3
let property_overflow_x = [%value "visible | hidden | clip | scroll | auto"];
let property_overflow_y = [%value "visible | hidden | clip | scroll | auto"];
let property_overflow = [%value
  "[ visible | hidden | clip | scroll | auto ]{1,2}"
];
// TODO: let property_overflow_clip_margin = [%value "<length [0,∞]>"];
let property_overflow_clip_margin = [%value "<length>"];
let property_overflow_inline = [%value "<'overflow'>"];
let property_overflow_block = [%value "<'overflow'>"];
let property_text_overflow = [%value "clip | ellipsis"];
let property_block_ellipsis = [%value "none | auto | <string>"];
let property_line_clamp = [%value "none | <integer> <'block-ellipsis'>?"];
let property_max_lines = [%value "none | <integer>"];
let property_continue = [%value "auto | discard"];

// css-text-3
let property_text_transform = [%value
  "none | [capitalize | uppercase | lowercase ] || full-width || full-size-kana"
];
let property_white_space = [%value
  "normal | pre | nowrap | pre-wrap | break-spaces | pre-line"
];
let property_tab_size = [%value "<number> | <length>"];
let property_word_break = [%value
  "normal | keep-all | break-all | break-word"
];
let property_line_break = [%value "auto | loose | normal | strict | anywhere"];
let property_hyphens = [%value "none | manual | auto"];
let property_overflow_wrap = [%value "normal | break-word | anywhere"];
let property_word_wrap = [%value "normal | break-word | anywhere"];
let property_text_align = [%value
  "start | end | left | right | center | justify | match-parent | justify-all"
];
let property_text_align_all = [%value
  "start | end | left | right | center | justify | match-parent"
];
let property_text_align_last = [%value
  "auto | start | end | left | right | center | justify | match-parent"
];
let property_text_justify = [%value
  "auto | none | inter-word | inter-character"
];
let property_word_spacing = [%value "normal | <length>"];
let property_letter_spacing = [%value "normal | <length>"];
let property_text_indent = [%value
  "[ <length-percentage> ] && hanging? && each-line?"
];
let property_hanging_punctuation = [%value
  "none | [ first || [ force-end | allow-end ] || last ]"
];

// css2
let property_line_height = [%value
  "normal | <number> | <length> | <percentage>"
];

// css-fonts-4

let relative_size = [%value "[ larger | smaller ]"];
let absolute_size = [%value
  "[ xx-small | x-small | small | medium | large | x-large | xx-large ]"
];

// TODO:
let palette_identifier = [%value "undefined"];
let generic_family = [%value
  "serif | sans-serif | cursive | fantasy | monospace | system-ui | emoji | math | fangsong | ui-serif | ui-sans-serif | ui-monospace | ui-rounded"
];
let family_name = [%value "<custom-ident>* | <string>"];

let feature_value_name = [%value "<ident>"];
let function_annotation = [%value "annotation(<feature-value-name>)"];
let function_ornaments = [%value "ornaments(<feature-value-name>)"];
let function_swash = [%value "swash(<feature-value-name>)"];
let function_character_variant = [%value
  "character-variant(<feature-value-name>#)"
];
let function_styleset = [%value "styleset(<feature-value-name>#)"];
let function_stylistic = [%value "stylistic(<feature-value-name>)"];
let feature_tag_value = [%value "<string> [ <integer> | on | off ]?"];
let east_asian_width_values = [%value "[ full-width | proportional-width ]"];
let east_asian_variant_values = [%value
  "[ jis78 | jis83 | jis90 | jis04 | simplified | traditional ]"
];
// let font_feature_value_type = [%value
//   "@stylistic | @historical-forms | @styleset | @character-variant | @swash | @ornaments | @annotation"
// ];
// let feature_value_block = [%value
//   "<font-feature-value-type> { <declaration-list> }"
// ];
let numeric_fraction_values = [%value
  "[ diagonal-fractions | stacked-fractions ]"
];
let numeric_spacing_values = [%value "[ proportional-nums | tabular-nums ]"];
let numeric_figure_values = [%value "[ lining-nums | oldstyle-nums ]"];
let contextual_alt_values = [%value "[ contextual | no-contextual ]"];
let historical_lig_values = [%value
  "[ historical-ligatures | no-historical-ligatures ]"
];
let discretionary_lig_values = [%value
  "[ discretionary-ligatures | no-discretionary-ligatures ]"
];
let common_lig_values = [%value "[ common-ligatures | no-common-ligatures ]"];
let font_variant_css21 = [%value "[normal | small-caps]"];
let color_font_technology = [%value "[COLR | SVG | sbix | CBDT ]"];
let font_technology = [%value
  "[features | variations | color(<color-font-technology>) | palettes]"
];
let font_format = [%value
  "[<string> | woff | truetype | opentype | woff2 | embedded-opentype | collection | svg]"
];
let font_stretch_css3 = [%value
  "[normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded]"
];
let font_variant_css2 = [%value "[normal | small-caps]"];
let font_weight_absolute = [%value "[normal | bold | <number>]"];
let property_font_family = [%value "[ <family-name> | <generic-family> ]#"];
let property_font_weight = [%value
  "<font-weight-absolute> | bolder | lighter"
];
let property_font_stretch = [%value
  "normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded"
];
let property_font_style = [%value "normal | italic | oblique <angle>?"];
let property_font_size = [%value
  "<absolute-size> | <relative-size> | <length-percentage>"
];
let property_font_size_adjust = [%value "none | <number>"];
let property_font = [%value
  "[ [ <'font-style'> || <font-variant-css2> || <'font-weight'> || <font-stretch-css3> ]? <'font-size'> [ / <'line-height'> ]? <'font-family'> ] | caption | icon | menu | message-box | small-caption | status-bar"
];
let property_font_synthesis_weight = [%value "auto | none"];
let property_font_synthesis_style = [%value "auto | none"];
let property_font_synthesis_small_caps = [%value "auto | none"];
let property_font_synthesis = [%value "none | [ weight || style ]"];
let property_font_kerning = [%value "auto | normal | none"];
let property_font_variant_ligatures = [%value
  "normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ]"
];
let property_font_variant_position = [%value "normal | sub | super"];
let property_font_variant_caps = [%value
  "normal | small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps"
];
let property_font_variant_numeric = [%value
  "normal | [ <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero ]"
];
let property_font_variant_alternates = [%value
  "normal | [ stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) ]"
];
let property_font_variant_east_asian = [%value
  "normal | [ <east-asian-variant-values> || <east-asian-width-values> || ruby ]"
];
let property_font_variant = [%value
  "normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || [ stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby || [ sub | super ] ]"
];
let property_font_feature_settings = [%value "normal | <feature-tag-value>#"];
let property_font_optical_sizing = [%value "auto | none"];
let property_font_variation_settings = [%value
  "normal | [ <string> <number>]#"
];
let property_font_palette = [%value
  "none | normal | light | dark | <palette-identifier>"
];
let property_font_variant_emoji = [%value "auto | text | emoji | unicode"];

// css-transforms-2
// let function_perspective = [%value "perspective( <length [0,∞]> )"];
let function_perspective = [%value "perspective( <length> )"];
// let function_rotateZ = [%value "rotateZ( [ <angle> | <zero> ] )"];
// let function_rotateY = [%value "rotateY( [ <angle> | <zero> ] )"];
// let function_rotateX = [%value "rotateX( [ <angle> | <zero> ] )"];
// let function_rotate3d = [%value "rotate3d( <number> , <number> , <number> , [ <angle> | <zero> ] )"];
let function_rotateZ = [%value "rotateZ( <angle> )"];
let function_rotateY = [%value "rotateY( <angle> )"];
let function_rotateX = [%value "rotateX( <angle> )"];
let function_rotate3d = [%value
  "rotate3d( <number> , <number> , <number> , <angle> )"
];
let function_scaleZ = [%value "scaleZ( <number> )"];
let function_scale3d = [%value "scale3d( <number> , <number>, <number> )"];
let function_translateZ = [%value "translateZ( <length> )"];
let function_translate3d = [%value
  "translate3d( <length-percentage> , <length-percentage> , <length> )"
];
let function_matrix3d = [%value "matrix3d( <number>#{16} )"];
let property_translate = [%value
  "none | <length-percentage> [ <length-percentage> <length>? ]?"
];
let property_rotate = [%value
  "none | <angle> | [ x | y | z | <number>{3} ] && <angle>"
];
let property_scale = [%value "none | <number>{1,3}"];
let property_transform_style = [%value "flat | preserve-3d"];
let property_perspective_origin = [%value "<position>"];

// css-transition-1
// let single_transition_property = [%value "all | <custom-ident>;"];
let single_transition_property = [%value "all | <custom-ident>"];
let single_transition = [%value
  "[ none | <single-transition-property> ] || <time> || <easing-function> || <time>"
];
let property_transition_property = [%value
  "none | <single-transition-property>#"
];
let property_transition_duration = [%value "<time>#"];
let property_transition_timing_function = [%value "<easing-function>#"];
let property_transition_delay = [%value "<time>#"];
let property_transition = [%value "<single-transition>#"];

// css-animation-1
let keyframe_selector = [%value "from | to | <percentage>"];
// let keyframe_block = [%value
//   "<keyframe-selector># '{' <declaration-list> '}'"
// ];
let keyframe_block = [%value
  "<keyframe-selector>#"
];
let keyframes_name = [%value "<custom-ident> | <string>"];
let single_animation_fill_mode = [%value "none | forwards | backwards | both"];
let single_animation_play_state = [%value "running | paused"];
let single_animation_direction = [%value
  "normal | reverse | alternate | alternate-reverse"
];
let single_animation_iteration_count = [%value "infinite | <number>"];
let single_animation = [%value
  "<time> || <easing-function> || <time> || <single-animation-iteration-count> || <single-animation-direction> || <single-animation-fill-mode> || <single-animation-play-state> || [ none | <keyframes-name> ]"
];
let property_animation_name = [%value "[ none | <keyframes-name> ]#"];
let property_animation_duration = [%value "<time>#"];
let property_animation_timing_function = [%value "<easing-function>#"];
let property_animation_iteration_count = [%value
  "<single-animation-iteration-count>#"
];
let property_animation_direction = [%value "<single-animation-direction>#"];
let property_animation_play_state = [%value "<single-animation-play-state>#"];
let property_animation_delay = [%value "<time>#"];
let property_animation_fill_mode = [%value "<single-animation-fill-mode>#"];
let property_animation = [%value "<single-animation>#"];

// css-flexbox-1
let property_flex_direction = [%value
  "row | row-reverse | column | column-reverse"
];
let property_flex_wrap = [%value "nowrap | wrap | wrap-reverse"];
let property_flex_flow = [%value "<'flex-direction'> || <'flex-wrap'>"];
let property_order = [%value "<integer>"];
let property_flex_grow = [%value "<number>"];
let property_flex_shrink = [%value "<number>"];
let property_flex_basis = [%value "content | <'width'>"];
let property_flex = [%value
  "none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]"
];
// TODO: new draft https://drafts.csswg.org/css-align-3/#propdef-justify-content
let property_justify_content = [%value
  "flex-start | flex-end | center | space-between | space-around"
];
let property_align_items = [%value
  "flex-start | flex-end | center | baseline | stretch"
];
let property_align_self = [%value
  "auto | flex-start | flex-end | center | baseline | stretch"
];
let property_align_content = [%value
  "flex-start | flex-end | center | space-between | space-around | stretch"
];

// TODO: fix https://drafts.csswg.org/css-values-4/#component-types
// the # on properties part

// css-grid-1
let line_names = [%value "'[' <custom-ident>* ']'"];
// let track_breadth = [%value
//   "<length-percentage> | <flex> | min-content | max-content | auto"
// ];
let inflexible_breadth = [%value
  "<length-percentage> | min-content | max-content | auto"
];
let track_breadth = [%value
  "<length-percentage> | <'flex'> | min-content | max-content | auto"
];
let track_size = [%value
  "<track-breadth> | minmax( <inflexible-breadth> , <track-breadth> ) | fit-content( <length-percentage> )"
];
// let track_repeat = [%value
//   "repeat( [ <integer [1,∞]> ] , [ <line-names>? <track-size> ]+ <line-names>? )"
// ];
let track_repeat = [%value
  "repeat( [ <integer> ] , [ <line-names>? <track-size> ]+ <line-names>? )"
];
let track_list = [%value
  "[ <line-names>? [ <track-size> | <track-repeat> ] ]+ <line-names>?"
];
let fixed_breadth = [%value "<length-percentage>"];
let fixed_size = [%value
  "<fixed-breadth> | minmax( <fixed-breadth> , <track-breadth> ) | minmax( <inflexible-breadth> , <fixed-breadth> )"
];
let fixed_repeat = [%value
  "repeat( [ <integer> ] , [ <line-names>? <fixed-size> ]+ <line-names>? )"
];
// let fixed_repeat = [%value
//   "repeat( [ <integer [1,∞]> ] , [ <line-names>? <fixed-size> ]+ <line-names>? )"
// ];
let auto_repeat = [%value
  "repeat( [ auto-fill | auto-fit ] , [ <line-names>? <fixed-size> ]+ <line-names>? )"
];
let auto_track_list = [%value
  "[ <line-names>? [ <fixed-size> | <fixed-repeat> ] ]* <line-names>? <auto-repeat> [ <line-names>? [ <fixed-size> | <fixed-repeat> ] ]* <line-names>?"
];
let explicit_track_list = [%value
  "[ <line-names>? <track-size> ]+ <line-names>?"
];
let grid_line = [%value
  "auto | <custom-ident> | [ <integer> && <custom-ident>? ] | [ span && [ <integer> || <custom-ident> ] ]"
];
let function_minmax = () => [%value "minmax(min, max)"];
// let function_fit_content = () => [%value "fit-content( <length-percentage> )"];
let property_display = [%value "undefined"];
let property_grid_template_columns = [%value
  "none | <track-list> | <auto-track-list>"
];
let property_grid_template_rows = [%value
  "none | <track-list> | <auto-track-list>"
];
let property_grid_template_areas = [%value "none | <string>+"];
let property_grid_template = [%value
  "none | [ <'grid-template-rows'> / <'grid-template-columns'> ] | [ <line-names>? <string> <track-size>? <line-names>? ]+ [ / <explicit-track-list> ]?"
];
let property_grid_auto_columns = [%value "<track-size>+"];
let property_grid_auto_rows = [%value "<track-size>+"];
let property_grid_auto_flow = [%value "[ row | column ] || dense"];
let property_grid = [%value
  "<'grid-template'> | <'grid-template-rows'> / [ auto-flow && dense? ] <'grid-auto-columns'>? | [ auto-flow && dense? ] <'grid-auto-rows'>? / <'grid-template-columns'>"
];
let property_grid_row_start = [%value "<grid-line>"];
let property_grid_column_start = [%value "<grid-line>"];
let property_grid_row_end = [%value "<grid-line>"];
let property_grid_column_end = [%value "<grid-line>"];
let property_grid_row = [%value "<grid-line> [ / <grid-line> ]?"];
let property_grid_column = [%value "<grid-line> [ / <grid-line> ]?"];
let property_grid_area = [%value "<grid-line> [ / <grid-line> ]{0,3}"];

let (let.ok) = Result.bind;
let parse_tokens = (prop, tokens_with_loc) => {
  let tokens =
    tokens_with_loc
    |> List.map(({Location.txt, _}) =>
         switch (txt) {
         | Ok(token) => token
         | Error((token, _)) => token
         }
       )
    |> List.filter((!=)(WHITESPACE))
    |> List.rev;
  let (output, tokens) = prop(tokens);

  let.ok output = output;
  let.ok () =
    switch (tokens) {
    | []
    | [EOF] => Ok()
    | tokens =>
      let tokens = List.map(show_token, tokens) |> String.concat(" * ");
      Error("tokens remaining: " ++ tokens);
    };
  Ok(output);
};
let parse = (prop, str) => {
  let.ok tokens_with_loc =
    Reason_css_lexer.from_string(str) |> Result.map_error(_ => "frozen");
  parse_tokens(prop, tokens_with_loc);
};
