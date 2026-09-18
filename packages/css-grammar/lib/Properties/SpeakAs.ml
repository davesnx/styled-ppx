open Types
open Support

(* The flat registry namespace shares this entry between the css-speech
   speak-as property and the css-counter-styles-3 speak-as descriptor
   (issue #584), so the grammar is the union of both:
   property:   'normal' | 'spell-out' || 'digits' ||
               [ 'literal-punctuation' | 'no-punctuation' ]
   descriptor: 'auto' | 'bubbles' | 'numbers' | 'words' | 'spell-out' |
               <counter-style-name> *)
module Property_speak_as =
  [%spec_module
  "'normal' | 'auto' | 'bubbles' | 'numbers' | 'words' | 'spell-out' || \
   'digits' || [ 'literal-punctuation' | 'no-punctuation' ] | \
   <counter-style-name>",
  (module Css_types.SpeakAs)]

let property_speak_as : property_speak_as Rule.rule = Property_speak_as.rule

let entries : (kind * packed_rule) list =
  [ Property "speak-as", pack_module (module Property_speak_as) ]
