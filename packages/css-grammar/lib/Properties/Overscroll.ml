open Types
open Support

module Property_overscroll_behavior =
  [%spec_module
  "[ 'contain' | 'none' | 'auto' ]{1,2}", (module Css_types.OverscrollBehavior)]

let property_overscroll_behavior : property_overscroll_behavior Rule.rule =
  Property_overscroll_behavior.rule

module Property_overscroll_behavior_block =
  [%spec_module
  "'contain' | 'none' | 'auto'", (module Css_types.OverscrollBehaviorBlock)]

let property_overscroll_behavior_block :
  property_overscroll_behavior_block Rule.rule =
  Property_overscroll_behavior_block.rule

module Property_overscroll_behavior_inline =
  [%spec_module
  "'contain' | 'none' | 'auto'", (module Css_types.OverscrollBehaviorInline)]

let property_overscroll_behavior_inline :
  property_overscroll_behavior_inline Rule.rule =
  Property_overscroll_behavior_inline.rule

module Property_overscroll_behavior_x =
  [%spec_module
  "'contain' | 'none' | 'auto'", (module Css_types.OverscrollBehaviorX)]

let property_overscroll_behavior_x : property_overscroll_behavior_x Rule.rule =
  Property_overscroll_behavior_x.rule

module Property_overscroll_behavior_y =
  [%spec_module
  "'contain' | 'none' | 'auto'", (module Css_types.OverscrollBehaviorY)]

let property_overscroll_behavior_y : property_overscroll_behavior_y Rule.rule =
  Property_overscroll_behavior_y.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "overscroll-behavior",
      pack_module (module Property_overscroll_behavior) );
    ( Property "overscroll-behavior-block",
      pack_module (module Property_overscroll_behavior_block) );
    ( Property "overscroll-behavior-inline",
      pack_module (module Property_overscroll_behavior_inline) );
    ( Property "overscroll-behavior-x",
      pack_module (module Property_overscroll_behavior_x) );
    ( Property "overscroll-behavior-y",
      pack_module (module Property_overscroll_behavior_y) );
  ]
