open Types
open Support

module Property_all =
  [%spec_module
  "'initial' | 'inherit' | 'unset' | 'revert'", (module Css_types.All)]

let property_all : property_all Rule.rule = Property_all.rule

let entries : (kind * packed_rule) list =
  [ Property "all", pack_module (module Property_all) ]
