open Types
open Support

module Property_mix_blend_mode =
  [%spec_module
  "<blend-mode>", (module Css_types.MixBlendMode)]

let property_mix_blend_mode : property_mix_blend_mode Rule.rule =
  Property_mix_blend_mode.rule

let entries : (kind * packed_rule) list =
  [ Property "mix-blend-mode", pack_module (module Property_mix_blend_mode) ]
