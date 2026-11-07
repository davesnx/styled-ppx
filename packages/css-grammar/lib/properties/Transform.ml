open Types
open Support

module Property_transform =
  [%spec_module
  "'none' | <transform-list>", (module Css_types.Transform)]

let property_transform : property_transform Rule.rule = Property_transform.rule

module Property_transform_box =
  [%spec_module
  "'content-box' | 'border-box' | 'fill-box' | 'stroke-box' | 'view-box'",
  (module Css_types.TransformBox)]

let property_transform_box : property_transform_box Rule.rule =
  Property_transform_box.rule

module Property_transform_origin =
  [%spec_module
  "[ 'left' | 'center' | 'right' | 'top' | 'bottom' | <length-percentage> ] | \
   [ 'left' | 'center' | 'right' | <length-percentage> ] [ 'top' | 'center' | \
   'bottom' | <length-percentage> ] <length>? | [[ 'center' | 'left' | 'right' \
   ] && [ 'center' | 'top' | 'bottom' ]] <length>? ",
  (module Css_types.TransformOrigin)]

let property_transform_origin : property_transform_origin Rule.rule =
  Property_transform_origin.rule

module Property_transform_style =
  [%spec_module
  "'flat' | 'preserve-3d'", (module Css_types.TransformStyle)]

let property_transform_style : property_transform_style Rule.rule =
  Property_transform_style.rule

let entries : (kind * packed_rule) list =
  [
    Property "transform-style", pack_module (module Property_transform_style);
    Property "transform-box", pack_module (module Property_transform_box);
    Property "transform", pack_module (module Property_transform);
    Property "transform-origin", pack_module (module Property_transform_origin);
  ]
