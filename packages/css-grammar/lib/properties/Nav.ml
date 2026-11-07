open Types
open Support

module Property_nav_down =
  [%spec_module
  "'auto' | <integer> | <interpolation>", (module Css_types.NavDown)]

let property_nav_down : property_nav_down Rule.rule = Property_nav_down.rule

module Property_nav_left =
  [%spec_module
  "'auto' | <integer> | <interpolation>", (module Css_types.NavLeft)]

let property_nav_left : property_nav_left Rule.rule = Property_nav_left.rule

module Property_nav_right =
  [%spec_module
  "'auto' | <integer> | <interpolation>", (module Css_types.NavRight)]

let property_nav_right : property_nav_right Rule.rule = Property_nav_right.rule

module Property_nav_up =
  [%spec_module
  "'auto' | <integer> | <interpolation>", (module Css_types.NavUp)]

let property_nav_up : property_nav_up Rule.rule = Property_nav_up.rule

let entries : (kind * packed_rule) list =
  [
    Property "nav-down", pack_module (module Property_nav_down);
    Property "nav-left", pack_module (module Property_nav_left);
    Property "nav-right", pack_module (module Property_nav_right);
    Property "nav-up", pack_module (module Property_nav_up);
  ]
