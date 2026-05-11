open Types
open Support

module Property_clip_path =
  [%spec_module
  "<clip-source> | <basic-shape> || <geometry-box> | 'none'",
  (module Css_types.ClipPath)]

let property_clip_path : property_clip_path Rule.rule = Property_clip_path.rule

module Property_clip_rule =
  [%spec_module
  "'nonzero' | 'evenodd'", (module Css_types.ClipRule)]

let property_clip_rule : property_clip_rule Rule.rule = Property_clip_rule.rule

let entries : (kind * packed_rule) list =
  [
    Property "clip-rule", pack_module (module Property_clip_rule);
    Property "clip-path", pack_module (module Property_clip_path);
  ]
