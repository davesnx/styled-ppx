open Types
open Support

module Property_white_space_collapse =
  [%spec_module
  "'collapse' | 'preserve' | 'preserve-breaks' | 'preserve-spaces' | \
   'break-spaces'",
  (module Css_types.WhiteSpaceCollapse)]

let property_white_space_collapse : property_white_space_collapse Rule.rule =
  Property_white_space_collapse.rule

let entries : (kind * packed_rule) list =
  [
    Property "white-space-collapse", pack_module (module Property_white_space_collapse);
  ]
