open Types
open Support
module Property_syntax = [%spec_module "<string>", (module Css_types.Syntax)]

let property_syntax : property_syntax Rule.rule = Property_syntax.rule

let entries : (kind * packed_rule) list =
  [ Property "syntax", pack_module (module Property_syntax) ]
