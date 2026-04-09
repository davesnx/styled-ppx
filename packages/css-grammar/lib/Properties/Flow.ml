open Types
open Support

module Property__ms_flow_from =
  [%spec_module
  "[ 'none' | <custom-ident> ]#", (module Css_types.Cascading)]

let property__ms_flow_from = Property__ms_flow_from.rule

module Property__ms_flow_into =
  [%spec_module
  "[ 'none' | <custom-ident> ]#", (module Css_types.Cascading)]

let property__ms_flow_into = Property__ms_flow_into.rule

let entries : (kind * packed_rule) list =
  [
    Property "-ms-flow-from", pack_module (module Property__ms_flow_from);
    Property "-ms-flow-into", pack_module (module Property__ms_flow_into);
  ]
