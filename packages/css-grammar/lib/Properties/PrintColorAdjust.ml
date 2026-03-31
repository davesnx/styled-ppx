open Types
open Support

module Property_print_color_adjust =
  [%spec_module
  "'economy' | 'exact'", (module Css_types.PrintColorAdjust)]

let property_print_color_adjust : property_print_color_adjust Rule.rule =
  Property_print_color_adjust.rule

(* Ruby *)

let entries : (kind * packed_rule) list =
  [
    Property "print-color-adjust", pack_module (module Property_print_color_adjust);
  ]
