open Types
open Support

module Property__ms_wrap_flow =
  [%spec_module
  "'auto' | 'both' | 'start' | 'end' | 'maximum' | 'clear'",
  (module Css_types.Cascading)]

let property__ms_wrap_flow = Property__ms_wrap_flow.rule

module Property__ms_wrap_margin =
  [%spec_module
  "<extended-length>", (module Css_types.ShapeMargin)]

let property__ms_wrap_margin = Property__ms_wrap_margin.rule

module Property__ms_wrap_through =
  [%spec_module
  "'wrap' | 'none'", (module Css_types.Cascading)]

let property__ms_wrap_through = Property__ms_wrap_through.rule

(* CSS Exclusions L1: https://drafts.csswg.org/css-exclusions/#propdef-wrap-flow
   Unprefixed successor of -ms-wrap-flow above, plus the 'minimum' keyword
   that vendor prefix never had. *)
module Property_wrap_flow =
  [%spec_module
  "'auto' | 'both' | 'start' | 'end' | 'minimum' | 'maximum' | 'clear'",
  (module Css_types.WrapFlow)]

let property_wrap_flow : property_wrap_flow Rule.rule = Property_wrap_flow.rule

(* CSS Exclusions L1: https://drafts.csswg.org/css-exclusions/#propdef-wrap-through
   Unprefixed successor of -ms-wrap-through above (same grammar exactly). *)
module Property_wrap_through =
  [%spec_module
  "'wrap' | 'none'", (module Css_types.Cascading)]

let property_wrap_through : property_wrap_through Rule.rule =
  Property_wrap_through.rule

(* CSS Text L4: https://drafts.csswg.org/css-text-4/#propdef-wrap-before *)
module Property_wrap_before =
  [%spec_module
  "'auto' | 'avoid' | 'avoid-line' | 'avoid-flex' | 'line' | 'flex'",
  (module Css_types.WrapBefore)]

let property_wrap_before : property_wrap_before Rule.rule =
  Property_wrap_before.rule

(* CSS Text L4: https://drafts.csswg.org/css-text-4/#propdef-wrap-after
   Shares wrap-before's own grammar exactly (one shared propdef table). *)
module Property_wrap_after =
  [%spec_module
  "'auto' | 'avoid' | 'avoid-line' | 'avoid-flex' | 'line' | 'flex'",
  (module Css_types.WrapBefore)]

let property_wrap_after : property_wrap_after Rule.rule =
  Property_wrap_after.rule

(* CSS Text L4 (preview - Safari Technology Preview only):
   https://drafts.csswg.org/css-text-4/#propdef-wrap-inside *)
module Property_wrap_inside =
  [%spec_module
  "'auto' | 'avoid'", (module Css_types.WrapInside)]

let property_wrap_inside : property_wrap_inside Rule.rule =
  Property_wrap_inside.rule

let entries : (kind * packed_rule) list =
  [
    Property "-ms-wrap-flow", pack_module (module Property__ms_wrap_flow);
    Property "-ms-wrap-margin", pack_module (module Property__ms_wrap_margin);
    Property "-ms-wrap-through", pack_module (module Property__ms_wrap_through);
    Property "wrap-flow", pack_module (module Property_wrap_flow);
    Property "wrap-through", pack_module (module Property_wrap_through);
    Property "wrap-before", pack_module (module Property_wrap_before);
    Property "wrap-after", pack_module (module Property_wrap_after);
    Property "wrap-inside", pack_module (module Property_wrap_inside);
  ]
