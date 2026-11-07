open Types
open Support

module Property_content =
  [%spec_module
  "'normal' | 'none' | <string> | <interpolation> | [ <content-replacement> | \
   <content-list> ] [ '/' <string> ]?",
  (module Css_types.Content)]

let property_content : property_content Rule.rule = Property_content.rule

let entries : (kind * packed_rule) list =
  [ Property "content", pack_module (module Property_content) ]
