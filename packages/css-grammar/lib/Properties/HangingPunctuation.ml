open Types
open Support

module Property_hanging_punctuation =
  [%spec_module
  "'none' | 'first' || [ 'force-end' | 'allow-end' ] || 'last'",
  (module Css_types.HangingPunctuation)]

let property_hanging_punctuation : property_hanging_punctuation Rule.rule =
  Property_hanging_punctuation.rule

let entries : (kind * packed_rule) list =
  [
    Property "hanging-punctuation", pack_module (module Property_hanging_punctuation);
  ]
