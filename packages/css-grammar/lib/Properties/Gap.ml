open Types
open Support

module Property_gap =
  [%spec_module
  "<'row-gap'> [ <'column-gap'> ]?", (module Css_types.Gap)]

let property_gap : property_gap Rule.rule = Property_gap.rule

let entries : (kind * packed_rule) list =
  (* Box Alignment L3: https://www.w3.org/TR/css-align-3/#gap-shorthand, #place-content, #place-items, #place-self *)
  [
    ( Shorthand ("gap", [ "row-gap"; "column-gap" ]),
      pack_module (module Property_gap) );
  ]
