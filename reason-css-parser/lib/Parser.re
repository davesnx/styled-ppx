open Standard;
open Combinator;
open Modifier;
open Rule.Match;
open Rule.Pattern;
// TODO: split by modules

let%property width = "auto";

let%property flex_direction = "row | row-reverse | column | column-reverse";
let%property flex_wrap = "nowrap | wrap | wrap-reverse";
let%property flex_flow = "<'flex-direction'> || <'flex-wrap'>";
let%property order = "<integer>";
let%property flex_grow = "<number>";
let%property flex_shrink = "<number>";
let%property flex_basis = "content | <'width'>";
let%property flex = "none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]";
let%property justify_content = "flex-start | flex-end | center | space-between | space-around";
let%property align_items = "flex-start | flex-end | center | baseline | stretch";
let%property align_self = "auto | flex-start | flex-end | center | baseline | stretch";
let%property align_content = "flex-start | flex-end | center | space-between | space-around | stretch";
