open Types
open Support

module Property_translate =
  [%spec_module
  "'none' | <length-percentage> [ <length-percentage> <length>? ]?",
  (module Css_types.Translate)]

let property_translate : property_translate Rule.rule = Property_translate.rule

let entries : (kind * packed_rule) list =
  [
    Property "translate", pack_module (module Property_translate);
  ]
