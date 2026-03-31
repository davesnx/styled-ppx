open Types
open Support

module Property_animation =
  [%spec_module
  "[ <single-animation> | <single-animation-no-interp> ]#",
  (module Css_types.Animation)]

let property_animation : property_animation Rule.rule = Property_animation.rule

module Property_animation_delay =
  [%spec_module
  "[ <extended-time> ]#", (module Css_types.AnimationDelay)]

let property_animation_delay : property_animation_delay Rule.rule =
  Property_animation_delay.rule

module Property_animation_direction =
  [%spec_module
  "[ <single-animation-direction> ]#", (module Css_types.AnimationDirection)]

let property_animation_direction : property_animation_direction Rule.rule =
  Property_animation_direction.rule

module Property_animation_duration =
  [%spec_module
  "[ <extended-time> ]#", (module Css_types.AnimationDuration)]

let property_animation_duration : property_animation_duration Rule.rule =
  Property_animation_duration.rule

module Property_animation_fill_mode =
  [%spec_module
  "[ <single-animation-fill-mode> ]#", (module Css_types.AnimationFillMode)]

let property_animation_fill_mode : property_animation_fill_mode Rule.rule =
  Property_animation_fill_mode.rule

module Property_animation_iteration_count =
  [%spec_module
  "[ <single-animation-iteration-count> ]#",
  (module Css_types.AnimationIterationCount)]

let property_animation_iteration_count :
  property_animation_iteration_count Rule.rule =
  Property_animation_iteration_count.rule

module Property_animation_name =
  [%spec_module
  "[ <keyframes-name> | 'none' | <interpolation> ]#",
  (module Css_types.AnimationName)]

let property_animation_name : property_animation_name Rule.rule =
  Property_animation_name.rule

module Property_animation_play_state =
  [%spec_module
  "[ <single-animation-play-state> ]#", (module Css_types.AnimationPlayState)]

let property_animation_play_state : property_animation_play_state Rule.rule =
  Property_animation_play_state.rule

module Property_animation_timing_function =
  [%spec_module
  "[ <timing-function> ]#", (module Css_types.AnimationTimingFunction)]

let property_animation_timing_function :
  property_animation_timing_function Rule.rule =
  Property_animation_timing_function.rule

module Property_animation_composition =
  [%spec_module
  "[ 'replace' | 'add' | 'accumulate' ]#",
  (module Css_types.AnimationComposition)]

let property_animation_composition : property_animation_composition Rule.rule =
  Property_animation_composition.rule

module Property_animation_range =
  [%spec_module
  "[ 'normal' | <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.AnimationRange)]

let property_animation_range : property_animation_range Rule.rule =
  Property_animation_range.rule

module Property_animation_range_end =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage>",
  (module Css_types.AnimationRangeEnd)]

let property_animation_range_end : property_animation_range_end Rule.rule =
  Property_animation_range_end.rule

module Property_animation_range_start =
  [%spec_module
  "'normal' | <extended-length> | <extended-percentage>",
  (module Css_types.AnimationRangeStart)]

let property_animation_range_start : property_animation_range_start Rule.rule =
  Property_animation_range_start.rule

module Property_animation_timeline =
  [%spec_module
  "[ 'none' | <custom-ident> ]#", (module Css_types.AnimationTimeline)]

let property_animation_timeline : property_animation_timeline Rule.rule =
  Property_animation_timeline.rule

module Property_animation_delay_end =
  [%spec_module
  "[ <extended-time> ]#", (module Css_types.AnimationDelayEnd)]

let property_animation_delay_end : property_animation_delay_end Rule.rule =
  Property_animation_delay_end.rule

module Property_animation_delay_start =
  [%spec_module
  "[ <extended-time> ]#", (module Css_types.AnimationDelayStart)]

let property_animation_delay_start : property_animation_delay_start Rule.rule =
  Property_animation_delay_start.rule

module Property_animation_trigger = struct
  type t = unit

  let rule : t Rule.rule = fun _ -> Ok (), []
  let type_check (_ : Styled_ppx_css_parser.Ast.component_value_list) = Ok ()
  let to_string () = ""
  let runtime_module_path = Some "Css_types.Cascading"
  let infer_interpolation_types () = []
  let infer_interpolation_types_with_context (_ : string) (_ : t) = []
end

(* Custom properties for at-rules *)

let entries : (kind * packed_rule) list =
  [
    Property "animation", pack_module (module Property_animation);
    ( Property "animation-composition",
      pack_module (module Property_animation_composition) );
    Property "animation-delay", pack_module (module Property_animation_delay);
    ( Property "animation-delay-end",
      pack_module (module Property_animation_delay_end) );
    ( Property "animation-delay-start",
      pack_module (module Property_animation_delay_start) );
    ( Property "animation-direction",
      pack_module (module Property_animation_direction) );
    ( Property "animation-duration",
      pack_module (module Property_animation_duration) );
    ( Property "animation-fill-mode",
      pack_module (module Property_animation_fill_mode) );
    ( Property "animation-iteration-count",
      pack_module (module Property_animation_iteration_count) );
    Property "animation-name", pack_module (module Property_animation_name);
    ( Property "animation-play-state",
      pack_module (module Property_animation_play_state) );
    Property "animation-range", pack_module (module Property_animation_range);
    ( Property "animation-range-end",
      pack_module (module Property_animation_range_end) );
    ( Property "animation-range-start",
      pack_module (module Property_animation_range_start) );
    ( Property "animation-timeline",
      pack_module (module Property_animation_timeline) );
    ( Property "animation-trigger",
      pack_module (module Property_animation_trigger) );
    ( Property "animation-timing-function",
      pack_module (module Property_animation_timing_function) );
  ]
