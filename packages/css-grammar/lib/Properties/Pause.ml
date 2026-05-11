open Types
open Support

module Property_pause =
  [%spec_module
  "<'pause-before'> [ <'pause-after'> ]?", (module Css_types.Pause)]

let property_pause : property_pause Rule.rule = Property_pause.rule

module Property_pause_after =
  [%spec_module
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'",
  (module Css_types.PauseAfter)]

let property_pause_after : property_pause_after Rule.rule =
  Property_pause_after.rule

module Property_pause_before =
  [%spec_module
  "<extended-time> | 'none' | 'x-weak' | 'weak' | 'medium' | 'strong' | \
   'x-strong'",
  (module Css_types.PauseBefore)]

let property_pause_before : property_pause_before Rule.rule =
  Property_pause_before.rule

let entries : (kind * packed_rule) list =
  [
    Property "pause", pack_module (module Property_pause);
    Property "pause-after", pack_module (module Property_pause_after);
    Property "pause-before", pack_module (module Property_pause_before);
  ]
