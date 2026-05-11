open Types
open Support
module Property_orphans = [%spec_module "<integer>", (module Css_types.Orphans)]

let property_orphans : property_orphans Rule.rule = Property_orphans.rule

let entries : (kind * packed_rule) list =
  [ Property "orphans", pack_module (module Property_orphans) ]
