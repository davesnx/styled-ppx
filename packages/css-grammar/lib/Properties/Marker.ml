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

let entries : (kind * packed_rule) list =
  [
    Property "marker-end", pack_module (module Property_marker_end);
    Property "marker-mid", pack_module (module Property_marker_mid);
    Property "marker-start", pack_module (module Property_marker_start);
  ]
