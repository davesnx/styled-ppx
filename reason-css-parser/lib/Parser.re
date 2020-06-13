open Standard;
open Combinator;
open Modifier;
open Rule.Match;
open Rule.Pattern;
// TODO: split by modules

let%value property_width = "auto";

let%value property_flex_direction = "row | row-reverse | column | column-reverse";
let%value property_flex_wrap = "nowrap | wrap | wrap-reverse";
let%value property_flex_flow = "<'flex-direction'> || <'flex-wrap'>";
let%value property_order = "<integer>";
let%value property_flex_grow = "<number>";
let%value property_flex_shrink = "<number>";
let%value property_flex_basis = "content | <'width'>";
let%value property_flex = "none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]";
let%value property_justify_content = "flex-start | flex-end | center | space-between | space-around";
let%value property_align_items = "flex-start | flex-end | center | baseline | stretch";
let%value property_align_self = "auto | flex-start | flex-end | center | baseline | stretch";
let%value property_align_content = "flex-start | flex-end | center | space-between | space-around | stretch";

let parse = (prop, str) => {
  let (output, _) =
    Sedlexing.Utf8.from_string(str) |> Lexer.read_all |> prop;
  output;
};
let parse_property = prop =>
  map(prop, value => `Property_value(value))
  lxor map(css_wide_keywords, value => `Css_wide_value(value))
  |> parse;
