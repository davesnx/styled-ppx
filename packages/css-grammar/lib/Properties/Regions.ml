open Types
open Support

(* CSS Regions L1: https://drafts.csswg.org/css-regions/#propdef-flow-into *)
module Property_flow_into =
  [%spec_module
  "'none' | <custom-ident> [ 'element' | 'content' ]?",
  (module Css_types.FlowInto)]

let property_flow_into : property_flow_into Rule.rule = Property_flow_into.rule

(* CSS Regions L1: https://drafts.csswg.org/css-regions/#propdef-flow-from *)
module Property_flow_from =
  [%spec_module
  "<custom-ident> | 'none'", (module Css_types.FlowFrom)]

let property_flow_from : property_flow_from Rule.rule = Property_flow_from.rule

(* CSS Regions L1: https://drafts.csswg.org/css-regions/#propdef-region-fragment *)
module Property_region_fragment =
  [%spec_module
  "'auto' | 'break'", (module Css_types.RegionFragment)]

let property_region_fragment : property_region_fragment Rule.rule =
  Property_region_fragment.rule

let entries : (kind * packed_rule) list =
  [
    Property "flow-into", pack_module (module Property_flow_into);
    Property "flow-from", pack_module (module Property_flow_from);
    Property "region-fragment", pack_module (module Property_region_fragment);
  ]
