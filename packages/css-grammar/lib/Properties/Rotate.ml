open Types
open Support

module Property_rotate =
  [%spec_module
  "'none' | <extended-angle> | [ 'x' | 'y' | 'z' | [ <number> ]{3} ] && \
   <extended-angle>",
  (module Css_types.Rotate)]

let property_rotate : property_rotate Rule.rule = Property_rotate.rule

let entries : (kind * packed_rule) list =
  [ Property "rotate", pack_module (module Property_rotate) ]
