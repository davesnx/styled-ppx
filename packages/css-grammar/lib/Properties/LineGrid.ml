open Types
open Support

(* CSS Line Grid L1: https://drafts.csswg.org/css-line-grid/ *)

module Property_line_grid =
  [%spec_module
  "'match-parent' | 'create'", (module Css_types.LineGrid)]

let property_line_grid : property_line_grid Rule.rule = Property_line_grid.rule

module Property_line_snap =
  [%spec_module
  "'none' | 'baseline' | 'contain'", (module Css_types.LineSnap)]

let property_line_snap : property_line_snap Rule.rule = Property_line_snap.rule

module Property_box_snap =
  [%spec_module
  "'none' | 'block-start' | 'block-end' | 'center' | 'baseline' | \
   'last-baseline'",
  (module Css_types.BoxSnap)]

let property_box_snap : property_box_snap Rule.rule = Property_box_snap.rule

let entries : (kind * packed_rule) list =
  [
    Property "line-grid", pack_module (module Property_line_grid);
    Property "line-snap", pack_module (module Property_line_snap);
    Property "box-snap", pack_module (module Property_box_snap);
  ]
