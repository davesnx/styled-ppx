open Standard;
open Combinator;
open Modifier;
open Rule.Match;
open Reason_css_lexer;
// TODO: split by modules

let number_percentage = [%value "<number> | <percentage>"];

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
