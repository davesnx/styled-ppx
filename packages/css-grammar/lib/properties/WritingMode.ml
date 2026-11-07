open Types
open Support

module Property_writing_mode =
  [%spec_module
  "'horizontal-tb' | 'vertical-rl' | 'vertical-lr' | 'sideways-rl' | \
   'sideways-lr' | <svg-writing-mode>",
  (module Css_types.WritingMode)]

let property_writing_mode : property_writing_mode Rule.rule =
  Property_writing_mode.rule

module Property__ms_block_progression =
  [%spec_module
  "'tb' | 'rl' | 'bt' | 'lr'", (module Css_types.Cascading)]

let property__ms_block_progression = Property__ms_block_progression.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "-ms-block-progression",
      pack_module (module Property__ms_block_progression) );
    Property "writing-mode", pack_module (module Property_writing_mode);
  ]
