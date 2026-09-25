open Types
open Support

(* CSS Basic User Interface L4: https://drafts.csswg.org/css-ui-4/#propdef-window-drag *)
module Property_window_drag =
  [%spec_module
  "'none' | 'move'", (module Css_types.WindowDrag)]

let property_window_drag : property_window_drag Rule.rule =
  Property_window_drag.rule

let entries : (kind * packed_rule) list =
  [ Property "window-drag", pack_module (module Property_window_drag) ]
