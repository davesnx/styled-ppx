open Standard;
open Combinator;
open Modifier;
open Rule.Match;
// TODO: split by modules

// css-sizing-3
// let function_fit_content = () => [%value "fit-content(<length-percentage>)"];
let function_fit_content = [%value "not-implemented"];
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

let parse = (prop, str) => {
  let (output, tokens) =
    Sedlexing.Utf8.from_string(str) |> Lexer.read_all |> prop;

  let matched_everything =
    switch (tokens) {
    | [] => Ok()
    | _ => Error("tokens remaining")
    };
  Result.bind(matched_everything, () => output);
};
