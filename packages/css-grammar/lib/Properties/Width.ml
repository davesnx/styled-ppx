open Types
open Support

module Property_width =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'fit-content' | fit-content( <extended-length> | \
   <extended-percentage> )",
  (module Css_types.Width)]

let property_width : property_width Rule.rule = Property_width.rule

let entries : (kind * packed_rule) list =
  [ Property "width", pack_module (module Property_width) ]
