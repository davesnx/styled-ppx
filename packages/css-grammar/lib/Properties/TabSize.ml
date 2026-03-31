open Types
open Support

module Property_tab_size =
  [%spec_module
  " <number> | <extended-length>", (module Css_types.TabSize)]

let property_tab_size : property_tab_size Rule.rule = Property_tab_size.rule

let entries : (kind * packed_rule) list =
  [
    Property "tab-size", pack_module (module Property_tab_size);
  ]
