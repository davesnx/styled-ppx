open Types
open Support

module Property_x =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.X)]

let property_x : property_x Rule.rule = Property_x.rule

module Property_y =
  [%spec_module
  "<extended-length> | <extended-percentage>", (module Css_types.Y)]

let property_y : property_y Rule.rule = Property_y.rule

(* Contain intrinsic sizing *)

let entries : (kind * packed_rule) list =
  [
    Property "x", pack_module (module Property_x);
    Property "y", pack_module (module Property_y);
  ]
