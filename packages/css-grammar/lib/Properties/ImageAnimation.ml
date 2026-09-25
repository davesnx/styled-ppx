open Types
open Support

(* CSS Image Animation L1: https://drafts.csswg.org/css-image-animation-1/#propdef-image-animation *)
module Property_image_animation =
  [%spec_module
  "'normal' | 'paused' | 'stopped' | 'running'",
  (module Css_types.ImageAnimation)]

let property_image_animation : property_image_animation Rule.rule =
  Property_image_animation.rule

let entries : (kind * packed_rule) list =
  [ Property "image-animation", pack_module (module Property_image_animation) ]
