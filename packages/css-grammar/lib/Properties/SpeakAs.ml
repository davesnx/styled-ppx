open Types
open Support

module Property_speak_as =
  [%spec_module
  "'normal' | 'spell-out' || 'digits' || [ 'literal-punctuation' | \
   'no-punctuation' ]",
  (module Css_types.SpeakAs)]

let property_speak_as : property_speak_as Rule.rule = Property_speak_as.rule

let entries : (kind * packed_rule) list =
  [ Property "speak-as", pack_module (module Property_speak_as) ]
