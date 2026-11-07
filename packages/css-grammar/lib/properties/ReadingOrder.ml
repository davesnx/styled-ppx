open Types
open Support

module Property_reading_order =
  [%spec_module
  "<integer>", (module Css_types.Cascading)]

let entries : (kind * packed_rule) list =
  [ Property "reading-order", pack_module (module Property_reading_order) ]
