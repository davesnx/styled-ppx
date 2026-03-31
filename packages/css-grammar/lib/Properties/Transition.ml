open Types
open Support

module Property_transition =
  [%spec_module
  "[ <single-transition> | <single-transition-no-interp> ]#",
  (module Css_types.Transition)]

let property_transition : property_transition Rule.rule =
  Property_transition.rule

module Property_transition_behavior =
  [%spec_module
  "<transition-behavior-value>#", (module Css_types.TransitionBehavior)]

let property_transition_behavior : property_transition_behavior Rule.rule =
  Property_transition_behavior.rule

module Property_transition_delay =
  [%spec_module
  "[ <extended-time> ]#", (module Css_types.TransitionDelay)]

let property_transition_delay : property_transition_delay Rule.rule =
  Property_transition_delay.rule

module Property_transition_duration =
  [%spec_module
  "[ <extended-time> ]#", (module Css_types.TransitionDuration)]

let property_transition_duration : property_transition_duration Rule.rule =
  Property_transition_duration.rule

module Property_transition_property =
  [%spec_module
  "[ <single-transition-property> ]# | 'none'",
  (module Css_types.TransitionProperty)]

let property_transition_property : property_transition_property Rule.rule =
  Property_transition_property.rule

module Property_transition_timing_function =
  [%spec_module
  "[ <timing-function> ]#", (module Css_types.TransitionTimingFunction)]

let property_transition_timing_function :
  property_transition_timing_function Rule.rule =
  Property_transition_timing_function.rule

let entries : (kind * packed_rule) list =
  [
    Property "transition", pack_module (module Property_transition);
    Property "transition-behavior", pack_module (module Property_transition_behavior);
    Property "transition-delay", pack_module (module Property_transition_delay);
    Property "transition-duration", pack_module (module Property_transition_duration);
    Property "transition-property", pack_module (module Property_transition_property);
    ( Property "transition-timing-function",
      pack_module (module Property_transition_timing_function) );
  ]
