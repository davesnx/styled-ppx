open Types
open Support

module Property_contain =
  [%spec_module
  "'none' | 'strict' | 'content' | 'size' || 'layout' || 'style' || 'paint'",
  (module Css_types.Contain)]

let property_contain : property_contain Rule.rule = Property_contain.rule

module Property_contain_intrinsic_size =
  [%spec_module
  "'none' | [ 'auto' ]? <extended-length>{1,2}",
  (module Css_types.ContainIntrinsicSize)]

let property_contain_intrinsic_size : property_contain_intrinsic_size Rule.rule
    =
  Property_contain_intrinsic_size.rule

module Property_contain_intrinsic_width =
  [%spec_module
  "'none' | 'auto' <extended-length> | <extended-length>",
  (module Css_types.ContainIntrinsicWidth)]

let property_contain_intrinsic_width :
  property_contain_intrinsic_width Rule.rule =
  Property_contain_intrinsic_width.rule

module Property_contain_intrinsic_height =
  [%spec_module
  "'none' | 'auto' <extended-length> | <extended-length>",
  (module Css_types.ContainIntrinsicHeight)]

let property_contain_intrinsic_height :
  property_contain_intrinsic_height Rule.rule =
  Property_contain_intrinsic_height.rule

module Property_contain_intrinsic_block_size =
  [%spec_module
  "'none' | 'auto' <extended-length> | <extended-length>",
  (module Css_types.ContainIntrinsicBlockSize)]

let property_contain_intrinsic_block_size :
  property_contain_intrinsic_block_size Rule.rule =
  Property_contain_intrinsic_block_size.rule

module Property_contain_intrinsic_inline_size =
  [%spec_module
  "'none' | 'auto' <extended-length> | <extended-length>",
  (module Css_types.ContainIntrinsicInlineSize)]

let property_contain_intrinsic_inline_size :
  property_contain_intrinsic_inline_size Rule.rule =
  Property_contain_intrinsic_inline_size.rule

(* Print *)

let entries : (kind * packed_rule) list =
  [
    ( Property "contain-intrinsic-size",
      pack_module (module Property_contain_intrinsic_size) );
    Property "contain", pack_module (module Property_contain);
    ( Property "contain-intrinsic-block-size",
      pack_module (module Property_contain_intrinsic_block_size) );
    ( Property "contain-intrinsic-height",
      pack_module (module Property_contain_intrinsic_height) );
    ( Property "contain-intrinsic-inline-size",
      pack_module (module Property_contain_intrinsic_inline_size) );
    ( Property "contain-intrinsic-width",
      pack_module (module Property_contain_intrinsic_width) );
  ]
