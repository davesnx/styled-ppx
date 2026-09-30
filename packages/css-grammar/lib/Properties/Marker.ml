open Types
open Support

module Property_marker_end =
  [%spec_module
  "'none' | <url>", (module Css_types.MarkerEnd)]

let property_marker_end : property_marker_end Rule.rule =
  Property_marker_end.rule

module Property_marker_mid =
  [%spec_module
  "'none' | <url>", (module Css_types.MarkerMid)]

let property_marker_mid : property_marker_mid Rule.rule =
  Property_marker_mid.rule

module Property_marker_start =
  [%spec_module
  "'none' | <url>", (module Css_types.MarkerStart)]

let property_marker_start : property_marker_start Rule.rule =
  Property_marker_start.rule

(* CSS Lists and Counters L3: https://drafts.csswg.org/css-lists-3/#propdef-marker-side *)
module Property_marker_side =
  [%spec_module
  "'match-self' | 'match-parent'", (module Css_types.MarkerSide)]

let property_marker_side : property_marker_side Rule.rule =
  Property_marker_side.rule

let entries : (kind * packed_rule) list =
  [
    Property "marker-end", pack_module (module Property_marker_end);
    Property "marker-mid", pack_module (module Property_marker_mid);
    Property "marker-start", pack_module (module Property_marker_start);
    Property "marker-side", pack_module (module Property_marker_side);
  ]
